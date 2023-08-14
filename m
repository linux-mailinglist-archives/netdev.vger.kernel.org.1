Return-Path: <netdev+bounces-27512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D89E77C2C3
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355E128124D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F71078D;
	Mon, 14 Aug 2023 21:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A41078F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8528C433B8;
	Mon, 14 Aug 2023 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049651;
	bh=huaLC91PYFoWp40umQDBC6xbiNhCHQhAQi13wgJ9WUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhG7BTI1biL+shG8Ieecsy0nxtwblXFB9mrlacZq301rqOiuvmdMC2kc5JIOeVoBq
	 Bmdj2B8pg905TkKHpCjAPWjBCk9lLA2WhDDeBz0wRBpaaaplXuEdxte9WuZhV8WN6l
	 QbL/+rUFzODbfIo/c6tXzzA0G9Vkv7FRMWwbKnjfXSn7Ewlh5FpLR44XtCrS+jQLFc
	 gsuRmd24R7h57k8LRHVyqoHMNDJkN2JhNzruKtzX/j7RvpLRm4wrqQ3ydmq5NIab8Z
	 yPi7XrlmXj9vphnYE0W+Guv3Ce8Vv0TpnNJ81nG38kWaClMUbUfGnsSCN5o1qIlmdj
	 IawIEg75NyWIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 07/10] genetlink: add genlmsg_iput() API
Date: Mon, 14 Aug 2023 14:47:20 -0700
Message-ID: <20230814214723.2924989-8-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214723.2924989-1-kuba@kernel.org>
References: <20230814214723.2924989-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some APIs and helpers required for convenient construction
of replies and notifications based on struct genl_info.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/genetlink.h | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 6b858c4cba5b..e18a4c0d69ee 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -113,7 +113,7 @@ struct genl_info {
 	struct netlink_ext_ack *extack;
 };
 
-static inline struct net *genl_info_net(struct genl_info *info)
+static inline struct net *genl_info_net(const struct genl_info *info)
 {
 	return read_pnet(&info->_net);
 }
@@ -270,6 +270,32 @@ genl_info_dump(struct netlink_callback *cb)
 	return &genl_dumpit_info(cb)->info;
 }
 
+/**
+ * genl_info_init_ntf() - initialize genl_info for notifications
+ * @info:   genl_info struct to set up
+ * @family: pointer to the genetlink family
+ * @cmd:    command to be used in the notification
+ *
+ * Initialize a locally declared struct genl_info to pass to various APIs.
+ * Intended to be used when creating notifications.
+ */
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
+
+static inline bool genl_info_is_ntf(const struct genl_info *info)
+{
+	return !info->nlhdr;
+}
+
 int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
@@ -278,6 +304,32 @@ void genl_notify(const struct genl_family *family, struct sk_buff *skb,
 void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
 		  const struct genl_family *family, int flags, u8 cmd);
 
+static inline void *
+__genlmsg_iput(struct sk_buff *skb, const struct genl_info *info, int flags)
+{
+	return genlmsg_put(skb, info->snd_portid, info->snd_seq, info->family,
+			   flags, info->genlhdr->cmd);
+}
+
+/**
+ * genlmsg_iput - start genetlink message based on genl_info
+ * @skb: skb in which message header will be placed
+ * @info: genl_info as provided to do/dump handlers
+ *
+ * Convenience wrapper which starts a genetlink message based on
+ * information in user request. @info should be either the struct passed
+ * by genetlink core to do/dump handlers (when constructing replies to
+ * such requests) or a struct initialized by genl_info_init_ntf()
+ * when constructing notifications.
+ *
+ * Returns pointer to new genetlink header.
+ */
+static inline void *
+genlmsg_iput(struct sk_buff *skb, const struct genl_info *info)
+{
+	return __genlmsg_iput(skb, info, 0);
+}
+
 /**
  * genlmsg_nlhdr - Obtain netlink header from user specified header
  * @user_hdr: user header as returned from genlmsg_put()
-- 
2.41.0


