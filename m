Return-Path: <netdev+bounces-26017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682877673A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2C5281D97
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C721DDD0;
	Wed,  9 Aug 2023 18:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE01DDC3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C45C433AD;
	Wed,  9 Aug 2023 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605619;
	bh=jqODKKmCub5wrb2E7WkReRREaDLOltdl3oGTaId6QBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyByiRb83ugqvgqH/wMoi0hXLyHLoMuqyhZRmtAMYG/ahLRcf9ayrOrhEGjhO89iS
	 p7d8QMSQ+gE1JdQSM1hrKy+fDMc3LCUli4OMsD2rOoIov3+nRUYnoneGHxVFYfYEmM
	 rkQUaTmiVsCWXGw42EQQPGdfUoJdMwae7jWISVAwygGyAQw2B8Ap4DoSRv1pwf7REz
	 Yp6bMCCuiL93b9/qpAqUeW2UaxF3VHkXGir5SOWEZoDsCc347EXHLey2jfpqNnaCDT
	 7nKXXWtW15+uyKAuHDuLQdZVCZC1P8TI2rIa9VhQ9qZOuLQGuzMd8Jgu20WfBZsyfa
	 zfWsEjfe3Ql8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/10] genetlink: add genlmsg_iput() API
Date: Wed,  9 Aug 2023 11:26:45 -0700
Message-ID: <20230809182648.1816537-8-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some APIs and helpers required for convenient construction
of replies and notifications based on struct genl_info.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/genetlink.h | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 6b858c4cba5b..53f403b8efa9 100644
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
@@ -270,6 +270,31 @@ genl_info_dump(struct netlink_callback *cb)
 	return &genl_dumpit_info(cb)->info;
 }
 
+#ifdef __LITTLE_ENDIAN
+#define __GENL_PTR_LOW(byte)	((void *)(unsigned long)(byte))
+#else
+#define __GENL_PTR_LOW(byte)	\
+	((void *)((unsigned long)(byte) << (BITS_PER_LONG - 8)))
+#endif
+
+/**
+ * GENL_INFO_NTF() - define genl_info for notifications
+ * @__name: name of declared variable
+ * @__family: pointer to the genetlink family
+ * @__cmd: command to be used in the notification
+ */
+#define GENL_INFO_NTF(__name, __family, __cmd)			\
+	struct genl_info __name = {				\
+		.family = (__family),				\
+		.genlhdr = (void *)&(__name.user_ptr[0]),	\
+		.user_ptr[0] = __GENL_PTR_LOW(__cmd),		\
+	}
+
+static inline bool genl_info_is_ntf(const struct genl_info *info)
+{
+	return !info->nlhdr;
+}
+
 int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
@@ -278,6 +303,29 @@ void genl_notify(const struct genl_family *family, struct sk_buff *skb,
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
+ * information in user request (or info constructed with GENL_INFO_NTF()).
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


