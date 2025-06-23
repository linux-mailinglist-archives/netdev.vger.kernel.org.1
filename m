Return-Path: <netdev+bounces-200425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A7AE57D7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA41C25B6F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2026E140;
	Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYbjE4A8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0E2673B5
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720647; cv=none; b=SqGP1rlraKTXypj7ll1eSlyUwFEE+tEq1ZjKHCotmBCX4a3nSGfQ4jHSSlr2QlTf96+IscdiL068pTwxoQu3P/TKyU7YIC/j/G7a8jPKZqZLCPdILV+KpM1b269GqguUAXKS7+sig1UWrshPAitNOOK7+odFrq4CIOrQ8TGZAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720647; c=relaxed/simple;
	bh=TFQ+8affGkun7NGNu+NR/dGpiowEBzy4SmG9WMysr1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1caPstWp55OtWmQHUQLaA0Yqn76+AxbM8H0skTgkenGJZDaWZo4Wa0vg37T+46rzMI6GnMM33qSpbxIjZR9P5bVvdsPjdC/lyVDkeoXIVp0jSeSz2YQVSOs9ameJxXQ0VnJcnBIf+WI9lyl5Df75/50bHqax16+WuS2DahGojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYbjE4A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BD4C4AF09;
	Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720646;
	bh=TFQ+8affGkun7NGNu+NR/dGpiowEBzy4SmG9WMysr1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYbjE4A8SM2cbjafQXqqOOM4dgQ6yGQVz2iNEHDIzdYX4f73Zi5qnId6hbWULAvfY
	 dImES4rIiT8zLvST3Iqa+Zeo1iYThgu8cH9BGPa/oPyfD812gyD6/wXVzm2iLEMd25
	 QidbuGhgguBNmAMI2H1fqqxO6AtgUiwo16b//yusV0caiCsSDPYRtA4D7GFmIVqHEv
	 SjoioESLJrkd+1ZlVglqv/b04O9FunS48z3wiovakORpnlZRFeYEPPmWVrnOKa3oaJ
	 VzRetwH8smWDGZfKKATMO6Ani+4vwhNyyAiq8WmciqXcRq5Ix4E0a2LyL9qwAzxB5p
	 kFFYTLC99VS8g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/8] net: ethtool: copy req_info from SET to NTF
Date: Mon, 23 Jun 2025 16:17:17 -0700
Message-ID: <20250623231720.3124717-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy information parsed for SET with .req_parse to NTF handling
and therefore the GET-equivalent that it ends up executing.
This way if the SET was on a sub-object (like RSS context)
the notification will also be appropriately scoped.

Also copy the phy_index, Maxime suggests this will help PLCA
commands generate accurate notifications as well.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - populate the phy_index
v1: https://lore.kernel.org/20250621171944.2619249-6-kuba@kernel.org
---
 net/ethtool/netlink.h |  5 ++++-
 net/ethtool/netlink.c | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 4a061944a3aa..373a8d5e86ae 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -23,7 +23,8 @@ void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd);
 void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd);
 void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd);
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev);
-void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data);
+void ethnl_notify(struct net_device *dev, unsigned int cmd,
+		  const struct ethnl_req_info *req_info);
 
 /**
  * ethnl_strz_size() - calculate attribute length for fixed size string
@@ -338,6 +339,8 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  *	header is already filled on entry, the rest up to @repdata_offset
  *	is zero initialized. This callback should only modify type specific
  *	request info by parsed attributes from request message.
+ *	Called for both GET and SET. Information parsed for SET will
+ *	be conveyed to the req_info used during NTF generation.
  * @prepare_data:
  *	Retrieve and prepare data needed to compose a reply message. Calls to
  *	ethtool_ops handlers are limited to this callback. Common reply data
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 129f9d56ac65..60b3c07507d2 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -911,7 +911,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	swap(dev->cfg, dev->cfg_pending);
 	if (!ret)
 		goto out_ops;
-	ethtool_notify(dev, ops->set_ntf_cmd);
+	ethnl_notify(dev, ops->set_ntf_cmd, req_info);
 
 	ret = 0;
 out_ops:
@@ -950,7 +950,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 
 /* default notification handler */
 static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
-				 const void *data)
+				 const struct ethnl_req_info *orig_req_info)
 {
 	struct ethnl_reply_data *reply_data;
 	const struct ethnl_request_ops *ops;
@@ -979,6 +979,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 
 	req_info->dev = dev;
 	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
+	if (orig_req_info) {
+		req_info->phy_index = orig_req_info->phy_index;
+		memcpy(&req_info[1], &orig_req_info[1],
+		       ops->req_info_size - sizeof(*req_info));
+	}
 
 	netdev_ops_assert_locked(dev);
 
@@ -1029,7 +1034,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 /* notifications */
 
 typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
-				       const void *data);
+				       const struct ethnl_req_info *req_info);
 
 static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_LINKINFO_NTF]	= ethnl_default_notify,
@@ -1049,7 +1054,8 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 };
 
-void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data)
+void ethnl_notify(struct net_device *dev, unsigned int cmd,
+		  const struct ethnl_req_info *req_info)
 {
 	if (unlikely(!ethnl_ok))
 		return;
@@ -1057,7 +1063,7 @@ void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data)
 
 	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
 		   ethnl_notify_handlers[cmd]))
-		ethnl_notify_handlers[cmd](dev, cmd, data);
+		ethnl_notify_handlers[cmd](dev, cmd, req_info);
 	else
 		WARN_ONCE(1, "notification %u not implemented (dev=%s)\n",
 			  cmd, netdev_name(dev));
-- 
2.49.0


