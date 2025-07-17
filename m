Return-Path: <netdev+bounces-208044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57EB0986E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B61C45A95
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8E25A353;
	Thu, 17 Jul 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP7eiAE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350925A340
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795857; cv=none; b=Y8po+ykVnpvNNoUffiAxN1AGez5NfIGyZMZv5t3VA2/7Pv76+80VWdrG/SgyTFoKg0qvvAor6NTm5TchIGzBDYY+ITRw5AIniACPjMEI0wOWDifmVnnI+hw2H1pASCP5X+Q8nyih1UjZE/TK0mTADsOqLwTvKeqPyvtHkKJNT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795857; c=relaxed/simple;
	bh=amwakZDRYlkRvshp0cOwc64iAk3mVsw4tW8VDfBzH4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC0oRlh/VL34YwCFxkvDJ6m5eyySGJqW/Y7v7KxQGg1zh7uENiPsAgDmg8P050hD3PDI5JevSF+/3qaaj/6K5Xtx7NQNwVOr5IVyAU6hbmzrYMiWzFbxB2lOMMBgqdqYFoDlwoqPdnoOnCc8v2jun2ZpeAFvDMyxDwqXDej/4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP7eiAE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A03C4CEF4;
	Thu, 17 Jul 2025 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795856;
	bh=amwakZDRYlkRvshp0cOwc64iAk3mVsw4tW8VDfBzH4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CP7eiAE7Nh3s1M942RM0wcJvWnMdKgeyTuvOZPfXCHT90mZCtcIP/gZpuMCZ3qNsN
	 Ssw08jV861UZ4/6Wla7aKwzP3Ys1lbgRDdqqsav1jPTNJOj9ht2nwgXXVlbH9yZ6KX
	 7zuFPXrCvyZ44wM6DiGVDng/D4M0B/ehbtQnnTJYljIuVxoZlfWMWQwFZ8/goPo5wz
	 g3Fz4Dn5mdR3ddxt9FH/yjYR1LlSMcrQef/Zh10BKFXKnJOgnCos1pFWreAoimbRge
	 pGMoJFM6LUjG/OHQbwJT2uOttBt0wr9P70g9SP/qU3yLb+N5hN+fkTA0O8VNAVgxEE
	 bMXsQf41ugZ7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/8] ethtool: rss: support removing contexts via Netlink
Date: Thu, 17 Jul 2025 16:43:42 -0700
Message-ID: <20250717234343.2328602-8-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement removing additional RSS contexts via Netlink.
Technically it'd be possible to shoehorn the delete operation
into ethnl_request_ops-compatible handler. The code ends
up longer than open coded version, and I think we'll need
a custom way of sending notifications at some stage (if we
allow tying the context lifetime to the netlink socket, in
the future).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      |  18 +++
 Documentation/networking/ethtool-netlink.rst  |  14 +++
 .../uapi/linux/ethtool_netlink_generated.h    |   2 +
 net/ethtool/netlink.h                         |   2 +
 net/ethtool/common.c                          |   1 +
 net/ethtool/ioctl.c                           |   1 +
 net/ethtool/netlink.c                         |   7 ++
 net/ethtool/rss.c                             | 109 +++++++++++++++++-
 8 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 25ffed5fddd5..1063d5d32fea 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2706,6 +2706,24 @@ c-version-name: ethtool-genl-version
       doc: |
         Notification for creation of an additional RSS context.
       notify: rss-create-act
+    -
+      name: rss-delete-act
+      doc: Delete an RSS context.
+      attribute-set: rss
+      do:
+        request:
+          attributes:
+            - header
+            - context
+    -
+      name: rss-delete-ntf
+      doc: |
+        Notification for deletion of an additional RSS context.
+      attribute-set: rss
+      event:
+        attributes:
+          - header
+          - context
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2646fafb8512..ab20c644af24 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -241,6 +241,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_TSCONFIG_SET``          set hw timestamping configuration
   ``ETHTOOL_MSG_RSS_SET``               set RSS settings
   ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
+  ``ETHTOOL_MSG_RSS_DELETE_ACT``        delete an additional RSS context
   ===================================== =================================
 
 Kernel to userspace:
@@ -297,6 +298,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_RSS_NTF``                  RSS settings notification
   ``ETHTOOL_MSG_RSS_CREATE_ACT_REPLY``     create an additional RSS context
   ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
+  ``ETHTOOL_MSG_RSS_DELETE_NTF``           additional RSS context deleted
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2041,6 +2043,18 @@ RSS_CREATE_ACT
 Create an additional RSS context, if ``ETHTOOL_A_RSS_CONTEXT`` is not
 specified kernel will allocate one automatically.
 
+RSS_DELETE_ACT
+==============
+
+Request contents:
+
+=====================================  ======  ==============================
+  ``ETHTOOL_A_RSS_HEADER``             nested  request header
+  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
+=====================================  ======  ==============================
+
+Delete an additional RSS context.
+
 PLCA_GET_CFG
 ============
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index dea77abd295f..e3b8813465d7 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -842,6 +842,7 @@ enum {
 	ETHTOOL_MSG_TSCONFIG_SET,
 	ETHTOOL_MSG_RSS_SET,
 	ETHTOOL_MSG_RSS_CREATE_ACT,
+	ETHTOOL_MSG_RSS_DELETE_ACT,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -901,6 +902,7 @@ enum {
 	ETHTOOL_MSG_RSS_NTF,
 	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
 	ETHTOOL_MSG_RSS_CREATE_NTF,
+	ETHTOOL_MSG_RSS_DELETE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index b530bf9f85ee..1d4f9ecb3d26 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -487,6 +487,7 @@ extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
 extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
 extern const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1];
 extern const struct nla_policy ethnl_rss_create_policy[ETHTOOL_A_RSS_INPUT_XFRM + 1];
+extern const struct nla_policy ethnl_rss_delete_policy[ETHTOOL_A_RSS_CONTEXT + 1];
 extern const struct nla_policy ethnl_plca_get_cfg_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1];
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
@@ -510,6 +511,7 @@ int ethnl_tsinfo_start(struct netlink_callback *cb);
 int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
+int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2a1d40efb1fc..4f58648a27ad 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -1136,5 +1136,6 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id)
 	netdev_err(dev, "device error, RSS context %d lost\n", context_id);
 	ctx = xa_erase(&dev->ethtool->rss_ctx, context_id);
 	kfree(ctx);
+	ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_DELETE_NTF, context_id);
 }
 EXPORT_SYMBOL(ethtool_rxfh_context_lost);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4b586b0f18e8..43a7854e784e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1647,6 +1647,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			     !memchr_inv(ethtool_rxfh_context_key(ctx), 0,
 					 ctx->key_size));
 	} else if (rxfh_dev.rss_delete) {
+		ntf = ETHTOOL_MSG_RSS_DELETE_NTF;
 		ret = ops->remove_rxfh_context(dev, ctx, rxfh.rss_context,
 					       extack);
 	} else {
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index e9696113a96b..2f813f25f07e 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1527,6 +1527,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy	= ethnl_rss_create_policy,
 		.maxattr = ARRAY_SIZE(ethnl_rss_create_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_RSS_DELETE_ACT,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_rss_delete_doit,
+		.policy	= ethnl_rss_delete_policy,
+		.maxattr = ARRAY_SIZE(ethnl_rss_delete_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index be092dfa4407..992e98abe9dd 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -486,13 +486,49 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 /* RSS_NTF */
 
+static void ethnl_rss_delete_notify(struct net_device *dev, u32 rss_context)
+{
+	struct sk_buff *ntf;
+	size_t ntf_size;
+	void *hdr;
+
+	ntf_size = ethnl_reply_header_size() +
+		nla_total_size(sizeof(u32));	/* _RSS_CONTEXT */
+
+	ntf = genlmsg_new(ntf_size, GFP_KERNEL);
+	if (!ntf)
+		goto out_warn;
+
+	hdr = ethnl_bcastmsg_put(ntf, ETHTOOL_MSG_RSS_DELETE_NTF);
+	if (!hdr)
+		goto out_free_ntf;
+
+	if (ethnl_fill_reply_header(ntf, dev, ETHTOOL_A_RSS_HEADER) ||
+	    nla_put_u32(ntf, ETHTOOL_A_RSS_CONTEXT, rss_context))
+		goto out_free_ntf;
+
+	genlmsg_end(ntf, hdr);
+	if (ethnl_multicast(ntf, dev))
+		goto out_warn;
+
+	return;
+
+out_free_ntf:
+	nlmsg_free(ntf);
+out_warn:
+	pr_warn_once("Failed to send a RSS delete notification");
+}
+
 void ethtool_rss_notify(struct net_device *dev, u32 type, u32 rss_context)
 {
 	struct rss_req_info req_info = {
 		.rss_context = rss_context,
 	};
 
-	ethnl_notify(dev, type, &req_info.base);
+	if (type == ETHTOOL_MSG_RSS_DELETE_NTF)
+		ethnl_rss_delete_notify(dev, rss_context);
+	else
+		ethnl_notify(dev, type, &req_info.base);
 }
 
 /* RSS_SET */
@@ -1096,3 +1132,74 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(ctx);
 	goto exit_unlock;
 }
+
+/* RSS_DELETE */
+
+const struct nla_policy ethnl_rss_delete_policy[ETHTOOL_A_RSS_CONTEXT + 1] = {
+	[ETHTOOL_A_RSS_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_RSS_CONTEXT]	= NLA_POLICY_MIN(NLA_U32, 1),
+};
+
+int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethtool_rxfh_context *ctx;
+	struct nlattr **tb = info->attrs;
+	struct ethnl_req_info req = {};
+	const struct ethtool_ops *ops;
+	struct net_device *dev;
+	u32 rss_context;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_RSS_CONTEXT))
+		return -EINVAL;
+	rss_context = nla_get_u32(tb[ETHTOOL_A_RSS_CONTEXT]);
+
+	ret = ethnl_parse_header_dev_get(&req, tb[ETHTOOL_A_RSS_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		return ret;
+
+	dev = req.dev;
+	ops = dev->ethtool_ops;
+
+	if (!ops->create_rxfh_context)
+		goto exit_free_dev;
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto exit_dev_unlock;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	ret = ethtool_check_rss_ctx_busy(dev, rss_context);
+	if (ret)
+		goto exit_unlock;
+
+	ctx = xa_load(&dev->ethtool->rss_ctx, rss_context);
+	if (!ctx) {
+		ret = -ENOENT;
+		goto exit_unlock;
+	}
+
+	ret = ops->remove_rxfh_context(dev, ctx, rss_context, info->extack);
+	if (ret)
+		goto exit_unlock;
+
+	WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rss_context) != ctx);
+	kfree(ctx);
+
+	ethnl_rss_delete_notify(dev, rss_context);
+
+exit_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+	ethnl_ops_complete(dev);
+exit_dev_unlock:
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+exit_free_dev:
+	ethnl_parse_header_dev_put(&req);
+	return ret;
+}
-- 
2.50.1


