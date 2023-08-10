Return-Path: <netdev+bounces-26582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB599778435
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6D31C20E66
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9C23BEC;
	Thu, 10 Aug 2023 23:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BC1ADD7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42AC433AD;
	Thu, 10 Aug 2023 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710733;
	bh=W/Ur4vjq0RMNYT46/HA26fDAt0engewK2fNICkBLH7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHrAQ0uLjUwTYI6cUtpW8FrQ/vTGccX8fRKfN3PtAZhrFngPnvFsLsiNWQwGCIMAu
	 hV+29vOXu7ZRFkGZyeJdHqpnKp9Vi2trvk1E0J9wjF/LQhlJA1BUVJXGb6rg2HRB74
	 MF196lTjBqoJwBECnW/ykMB0mPITf5R1O960+KSAMbgGl50XBMcI97tw16jzKladVA
	 Tr6HtJpwBs6ehbaeWX6NDE+DxLWllCOK1MfXZz0myzT4wtPtB6koNQk23Nj6FUMUDq
	 9Rv4PHjZV9vnCEWlBYiQTF8jhLwRq4WYde90ReGO+3rHyLPoLJ/0WXGq4mr+YT4SSf
	 DDQHy0EH3Fvnw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/10] genetlink: add genlmsg_iput() API
Date: Thu, 10 Aug 2023 16:38:42 -0700
Message-ID: <20230810233845.2318049-8-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810233845.2318049-1-kuba@kernel.org>
References: <20230810233845.2318049-1-kuba@kernel.org>
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


