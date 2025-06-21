Return-Path: <netdev+bounces-199996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0856AE2A96
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCDF177D64
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C3224B1F;
	Sat, 21 Jun 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWWDKWok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1692248BE
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526395; cv=none; b=QtJa7da/LqVrfMQ8I5PIOdXDGbUhCHMUfq1u+PUSJJIcNuKOVht9jvpOkF1LwH8wk0YyCXwdmZTtyxXSTwBragihrUv+pvh+/Xg5SiiAMTaapoSa580bX54Umz3y5M3n3oVXE5MygOo4YUWAnN01XdN6nFTPTdED94eH95j9I88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526395; c=relaxed/simple;
	bh=Kif17/cOim7GiQJ04xGgrLrfIiNFXGP7WI3+MCI20YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6cdgMsfhXqiWgnxfYM+w5aTy4sHtwwl+Z+Y114a7wdAB9bo6wKZIaYn4DoiCjs5BZi1ZKJksWQCReS5yweux1yHYIjRulr5KcejTyqV5LVTuh/KdfqvRUgwm3LfqZNLlQOwGICk/jmSye32IaYd1/KCMrbnlnzMy+TitxtUVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWWDKWok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E54EC4CEEE;
	Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526394;
	bh=Kif17/cOim7GiQJ04xGgrLrfIiNFXGP7WI3+MCI20YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWWDKWokoyii8xMeeF14hn1cqyhA0sPhp/NgZcpeExK5W84BwX91Uvr8EMlJNWHKv
	 c1Zx2Zn2VJmPoWUf45JUmZO28Yqg+uVGrlCmsNZFhV9OYUvUyZ1Kx4qHIGg3wkMApD
	 yQA6YDAbhQv6T7MW7DmvGacCWp6GliWDn10409nm6HFDE3XCvO/gG6ERoztrsk8hcs
	 i6UlxZhm4aPjSyUEhnDRaOdWzIzoEfGgIm3wNTnuZRDWKP4krf0MQVHYYXTTJRrfN2
	 vHTtR0Vka9lKMDwsSEmHdDHfQV/TFgR6wVvSxVlwMBVkiUjoHTiF1nzXm5RjbmIfM1
	 boZvz8Y7piFFQ==
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
Subject: [PATCH net-next 5/9] net: ethtool: copy req_info from SET to NTF
Date: Sat, 21 Jun 2025 10:19:40 -0700
Message-ID: <20250621171944.2619249-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.h |  5 ++++-
 net/ethtool/netlink.c | 14 +++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index 129f9d56ac65..f4a61016b364 100644
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
@@ -979,6 +979,9 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 
 	req_info->dev = dev;
 	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
+	if (orig_req_info)
+		memcpy(&req_info[1], &orig_req_info[1],
+		       ops->req_info_size - sizeof(*req_info));
 
 	netdev_ops_assert_locked(dev);
 
@@ -1029,7 +1032,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 /* notifications */
 
 typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
-				       const void *data);
+				       const struct ethnl_req_info *req_info);
 
 static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_LINKINFO_NTF]	= ethnl_default_notify,
@@ -1049,7 +1052,8 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 };
 
-void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data)
+void ethnl_notify(struct net_device *dev, unsigned int cmd,
+		  const struct ethnl_req_info *req_info)
 {
 	if (unlikely(!ethnl_ok))
 		return;
@@ -1057,7 +1061,7 @@ void ethnl_notify(struct net_device *dev, unsigned int cmd, const void *data)
 
 	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
 		   ethnl_notify_handlers[cmd]))
-		ethnl_notify_handlers[cmd](dev, cmd, data);
+		ethnl_notify_handlers[cmd](dev, cmd, req_info);
 	else
 		WARN_ONCE(1, "notification %u not implemented (dev=%s)\n",
 			  cmd, netdev_name(dev));
-- 
2.49.0


