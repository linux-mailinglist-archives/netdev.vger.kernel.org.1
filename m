Return-Path: <netdev+bounces-26453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA1D777DD9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605D0281C82
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC120F89;
	Thu, 10 Aug 2023 16:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AF1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5DFC433C8;
	Thu, 10 Aug 2023 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684017;
	bh=0ACMwsjjFCOBAaK5yqEuLgfguqBWhvWUjsMDX1ROMdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYA/O3IqtHxhuq2zoU2OkRwaHz6HZwJ5+StAu+WAInl/cPxb7G1ERC7kNFtaLUA+C
	 hiqcRfNa4YQcq1QhZq3QYX9OdXAoP/3MFEi4zirpn44LAMM6EZDHud8FOlJBaZadey
	 TxVJcbDbUO2nzZeGPx7Sv4zQ0+dKqouUNADVEp+1edwXjnJiIw4s3afI0nfVA2WhF2
	 uAXpT+W1bZ1P9ECNngbEWRF5aMvkPnoEOHyGgOB7OMnqXxealtiIy5LLPztjR7trD3
	 8ZcVW921q59GGllEnVXplK1daLmUYCFk9M7OunWdsq1PNDs6Hz2KM+ohKeL6H24guY
	 eI2XbObYL3qcA==
Date: Thu, 10 Aug 2023 09:13:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 07/10] genetlink: add genlmsg_iput() API
Message-ID: <20230810091336.40951430@kernel.org>
In-Reply-To: <ZNSo3X0GeVOgPnN8@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<20230809182648.1816537-8-kuba@kernel.org>
	<ZNSo3X0GeVOgPnN8@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 11:07:41 +0200 Jiri Pirko wrote:
> >+#ifdef __LITTLE_ENDIAN
> >+#define __GENL_PTR_LOW(byte)	((void *)(unsigned long)(byte))
> >+#else
> >+#define __GENL_PTR_LOW(byte)	\
> >+	((void *)((unsigned long)(byte) << (BITS_PER_LONG - 8)))
> >+#endif
> >+
> >+/**
> >+ * GENL_INFO_NTF() - define genl_info for notifications
> >+ * @__name: name of declared variable
> >+ * @__family: pointer to the genetlink family
> >+ * @__cmd: command to be used in the notification
> >+ */
> >+#define GENL_INFO_NTF(__name, __family, __cmd)			\
> >+	struct genl_info __name = {				\
> >+		.family = (__family),				\
> >+		.genlhdr = (void *)&(__name.user_ptr[0]),	\
> >+		.user_ptr[0] = __GENL_PTR_LOW(__cmd),		\  
> 
> Ugh. Took me some time to decypher what you do here. Having endian
> specific code here seems quite odd to me. Why don't you have this as
> static inline initializer function instead and use struct genlmsghdr
> pointer to store cmd where it belong?
> 
> static inline void genl_info_ntf(struct genl_info *info,
> 				 const struct genl_family *family, u8 cmd)
> }
> 	struct genlmsghdr *hdr = (void *) &info->user_ptr[0];
> 
> 	info->family = family;
> 	info->genlhdr = hdr;
> 	hdr->cmd = cmd;
> }

Nice! The endian magic is easily the nastiest part of this series.
I considered making genlhdr a struct (rather than a pointer) because
it's actually smaller than a pointer on 64b. But dunno, feels kinda
weird to have a copy of the struct and a pointer to nlh. Hence the
magic.

And I was trying to save the 2 LoC and provide the DEFINE_ style macro
but on second thought your init helper is cleaner. I don't like the
DEFINE_ shit myself. I'll just throw in a memset(0) in there, and maybe
add a verb to the name - genl_info_init_nft()?

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 53f403b8efa9..e18a4c0d69ee 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -270,25 +270,26 @@ genl_info_dump(struct netlink_callback *cb)
 	return &genl_dumpit_info(cb)->info;
 }
 
-#ifdef __LITTLE_ENDIAN
-#define __GENL_PTR_LOW(byte)	((void *)(unsigned long)(byte))
-#else
-#define __GENL_PTR_LOW(byte)	\
-	((void *)((unsigned long)(byte) << (BITS_PER_LONG - 8)))
-#endif
-
 /**
- * GENL_INFO_NTF() - define genl_info for notifications
- * @__name: name of declared variable
- * @__family: pointer to the genetlink family
- * @__cmd: command to be used in the notification
+ * genl_info_init_ntf() - initialize genl_info for notifications
+ * @info:   genl_info struct to set up
+ * @family: pointer to the genetlink family
+ * @cmd:    command to be used in the notification
+ *
+ * Initialize a locally declared struct genl_info to pass to various APIs.
+ * Intended to be used when creating notifications.
  */
-#define GENL_INFO_NTF(__name, __family, __cmd)			\
-	struct genl_info __name = {				\
-		.family = (__family),				\
-		.genlhdr = (void *)&(__name.user_ptr[0]),	\
-		.user_ptr[0] = __GENL_PTR_LOW(__cmd),		\
-	}
+static inline void
+genl_info_init_ntf(struct genl_info *info, const struct genl_family *family,
+		   u8 cmd)
+{
+	struct genlmsghdr *hdr = (void *) &info->user_ptr[0];
+
+	memset(info, 0, sizeof(*info));
+	info->family = family;
+	info->genlhdr = hdr;
+	hdr->cmd = cmd;
+}
 
 static inline bool genl_info_is_ntf(const struct genl_info *info)
 {
@@ -316,7 +317,10 @@ __genlmsg_iput(struct sk_buff *skb, const struct genl_info *info, int flags)
  * @info: genl_info as provided to do/dump handlers
  *
  * Convenience wrapper which starts a genetlink message based on
- * information in user request (or info constructed with GENL_INFO_NTF()).
+ * information in user request. @info should be either the struct passed
+ * by genetlink core to do/dump handlers (when constructing replies to
+ * such requests) or a struct initialized by genl_info_init_ntf()
+ * when constructing notifications.
  *
  * Returns pointer to new genetlink header.
  */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 8e4e78bbd71a..c1aea8b756b6 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -41,13 +41,15 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 static void
 netdev_genl_dev_notify(struct net_device *netdev, int cmd)
 {
-	GENL_INFO_NTF(info, &netdev_nl_family, cmd);
+	struct genl_info info;
 	struct sk_buff *ntf;
 
 	if (!genl_has_listeners(&netdev_nl_family, dev_net(netdev),
 				NETDEV_NLGRP_MGMT))
 		return;
 
+	genl_info_init_ntf(&info, &netdev_nl_family, cmd);
+
 	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!ntf)
 		return;
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 5aa319c4279c..3bbd5afb7b31 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -644,15 +644,17 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 				 const void *data)
 {
-	GENL_INFO_NTF(info, &ethtool_genl_family, cmd);
 	struct ethnl_reply_data *reply_data;
 	const struct ethnl_request_ops *ops;
 	struct ethnl_req_info *req_info;
+	struct genl_info info;
 	struct sk_buff *skb;
 	void *reply_payload;
 	int reply_len;
 	int ret;
 
+	genl_info_init_ntf(&info, &ethtool_genl_family, cmd);
+
 	if (WARN_ONCE(cmd > ETHTOOL_MSG_KERNEL_MAX ||
 		      !ethnl_default_notify_ops[cmd],
 		      "unexpected notification type %u\n", cmd))

