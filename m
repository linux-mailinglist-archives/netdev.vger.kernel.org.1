Return-Path: <netdev+bounces-208043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61BB09869
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C137AAD61
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88FE258CE5;
	Thu, 17 Jul 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9TDhYui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520F250BF2
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795855; cv=none; b=nuwgkdHIKkph4d5XbleoAfzoSF9roTUQQTxPve8UKs9fknOHHfQf7RVZRW8dkgLWLtZ1XY5Ro5bCv0lLIu1sfcQmIFvNaAdAijMiR006b/YscGFYOgbCltLF84xqnyLgJC93lvvh0Tmb6MUnGnL+wFf/vSRUI6rrnNb6kQj7oLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795855; c=relaxed/simple;
	bh=HviNYO14kpJR1DbmWfZ+894nctpU/zbqmMDjH9qNBTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYnulv3JkeDkgqwRSRQ3HbwhY27A77EIbw3/8Nozy9l+LglUvVLGTiaZHq3JrosbbGX6SGC6QrjBp95FwJDMSgMSknTtvNV81YNfu9t+/BXFtMjMELGsriwCFAvswuw6SiT1cz5s/nxxATNDfzOiLgSka2L/HuoMuGCB83MDlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9TDhYui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF2C4CEF4;
	Thu, 17 Jul 2025 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795855;
	bh=HviNYO14kpJR1DbmWfZ+894nctpU/zbqmMDjH9qNBTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9TDhYuiJDqZobTbJg0EsVhJS6hKsOBKZ+o/PJpwLj8LB2iJcuObb3pCx39fEGRW1
	 IUukTc0xNo21n2jXnjcEizDVaKUYhUo7fiRPcnJOwqdeor7+Ng+SxT5oF6KLh7U9j9
	 Ak8Cw7V3BHE0FncTzPeM5M8Z/NphyLdwcJcnMeRuVPXp0otEawTxa7oyXOtlL9qnH1
	 wzLwgztkyDRyyxfAY6897Wvfgi4XR+mCml/vKTWqUtFlZdS1igRE7jRNKibIDPIgwm
	 g2cVZJ2+ioEgimonjBiKVW+4IJbXTxrQxiVPtST+C6ymxByY4xJETlilF1ozK1K7xJ
	 /8YdYSlWqAIDQ==
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
Subject: [PATCH net-next 6/8] ethtool: rss: support creating contexts via Netlink
Date: Thu, 17 Jul 2025 16:43:41 -0700
Message-ID: <20250717234343.2328602-7-kuba@kernel.org>
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

Support creating contexts via Netlink. Setting flow hashing
fields on the new context is not supported at this stage,
it can be added later.

An empty indirection table is not supported. This is a carry
over from the IOCTL interface where empty indirection table
meant delete. We can repurpose empty indirection table in
Netlink but for now to avoid confusion reject it using the
policy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      |  23 +-
 Documentation/networking/ethtool-netlink.rst  |  27 +++
 .../uapi/linux/ethtool_netlink_generated.h    |   3 +
 net/ethtool/netlink.h                         |   3 +
 net/ethtool/ioctl.c                           |   1 +
 net/ethtool/netlink.c                         |  15 ++
 net/ethtool/rss.c                             | 203 ++++++++++++++++++
 7 files changed, 273 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 069269edde01..25ffed5fddd5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2684,9 +2684,28 @@ c-version-name: ethtool-genl-version
       name: rss-ntf
       doc: |
         Notification for change in RSS configuration.
-        For additional contexts only modifications are modified, not creation
-        or removal of the contexts.
+        For additional contexts only modifications use this notification,
+        creation and deletion have dedicated messages.
       notify: rss-get
+    -
+      name: rss-create-act
+      doc: Create an RSS context.
+      attribute-set: rss
+      do:
+        request: &rss-create-attrs
+          attributes:
+            - header
+            - context
+            - hfunc
+            - indir
+            - hkey
+            - input-xfrm
+        reply: *rss-create-attrs
+    -
+      name: rss-create-ntf
+      doc: |
+        Notification for creation of an additional RSS context.
+      notify: rss-create-act
 
 mcast-groups:
   list:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 056832c77ffd..2646fafb8512 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -240,6 +240,7 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_TSCONFIG_GET``          get hw timestamping configuration
   ``ETHTOOL_MSG_TSCONFIG_SET``          set hw timestamping configuration
   ``ETHTOOL_MSG_RSS_SET``               set RSS settings
+  ``ETHTOOL_MSG_RSS_CREATE_ACT``        create an additional RSS context
   ===================================== =================================
 
 Kernel to userspace:
@@ -294,6 +295,8 @@ All constants identifying message types use ``ETHTOOL_CMD_`` prefix and suffix
   ``ETHTOOL_MSG_TSCONFIG_SET_REPLY``       new hw timestamping configuration
   ``ETHTOOL_MSG_PSE_NTF``                  PSE events notification
   ``ETHTOOL_MSG_RSS_NTF``                  RSS settings notification
+  ``ETHTOOL_MSG_RSS_CREATE_ACT_REPLY``     create an additional RSS context
+  ``ETHTOOL_MSG_RSS_CREATE_NTF``           additional RSS context created
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2014,6 +2017,30 @@ device needs at least 8 entries - the real table in use will end up being
 of 2, so tables which size is not a power of 2 will likely be rejected.
 Using table of size 0 will reset the indirection table to the default.
 
+RSS_CREATE_ACT
+==============
+
+Request contents:
+
+=====================================  ======  ==============================
+  ``ETHTOOL_A_RSS_HEADER``             nested  request header
+  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
+  ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
+  ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
+  ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
+  ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
+=====================================  ======  ==============================
+
+Kernel response contents:
+
+=====================================  ======  ==============================
+  ``ETHTOOL_A_RSS_HEADER``             nested  request header
+  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
+=====================================  ======  ==============================
+
+Create an additional RSS context, if ``ETHTOOL_A_RSS_CONTEXT`` is not
+specified kernel will allocate one automatically.
+
 PLCA_GET_CFG
 ============
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 130bdf5c3516..dea77abd295f 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -841,6 +841,7 @@ enum {
 	ETHTOOL_MSG_TSCONFIG_GET,
 	ETHTOOL_MSG_TSCONFIG_SET,
 	ETHTOOL_MSG_RSS_SET,
+	ETHTOOL_MSG_RSS_CREATE_ACT,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -898,6 +899,8 @@ enum {
 	ETHTOOL_MSG_TSCONFIG_SET_REPLY,
 	ETHTOOL_MSG_PSE_NTF,
 	ETHTOOL_MSG_RSS_NTF,
+	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
+	ETHTOOL_MSG_RSS_CREATE_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ddb2fb00f929..b530bf9f85ee 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -10,6 +10,7 @@
 
 struct ethnl_req_info;
 
+u32 ethnl_bcast_seq_next(void);
 int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *nest, struct net *net,
 			       struct netlink_ext_ack *extack,
@@ -485,6 +486,7 @@ extern const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1];
 extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
 extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
 extern const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1];
+extern const struct nla_policy ethnl_rss_create_policy[ETHTOOL_A_RSS_INPUT_XFRM + 1];
 extern const struct nla_policy ethnl_plca_get_cfg_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1];
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
@@ -507,6 +509,7 @@ int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_start(struct netlink_callback *cb);
 int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int ethnl_tsinfo_done(struct netlink_callback *cb);
+int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index c53868889969..4b586b0f18e8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1640,6 +1640,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		ntf = ETHTOOL_MSG_RSS_NTF;
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	} else if (create) {
+		ntf = ETHTOOL_MSG_RSS_CREATE_NTF;
 		ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev, extack);
 		/* Make sure driver populates defaults */
 		WARN_ON_ONCE(!ret && !rxfh_dev.key && ops->rxfh_per_ctx_key &&
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 0ae0d7a9667c..e9696113a96b 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -81,6 +81,12 @@ static void ethnl_sock_priv_destroy(void *priv)
 	}
 }
 
+u32 ethnl_bcast_seq_next(void)
+{
+	ASSERT_RTNL();
+	return ++ethnl_bcast_seq;
+}
+
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -954,6 +960,7 @@ ethnl_default_notify_ops[ETHTOOL_MSG_KERNEL_MAX + 1] = {
 	[ETHTOOL_MSG_PLCA_NTF]		= &ethnl_plca_cfg_request_ops,
 	[ETHTOOL_MSG_MM_NTF]		= &ethnl_mm_request_ops,
 	[ETHTOOL_MSG_RSS_NTF]		= &ethnl_rss_request_ops,
+	[ETHTOOL_MSG_RSS_CREATE_NTF]	= &ethnl_rss_request_ops,
 };
 
 /* default notification handler */
@@ -1061,6 +1068,7 @@ static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_PLCA_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_MM_NTF]		= ethnl_default_notify,
 	[ETHTOOL_MSG_RSS_NTF]		= ethnl_default_notify,
+	[ETHTOOL_MSG_RSS_CREATE_NTF]	= ethnl_default_notify,
 };
 
 void ethnl_notify(struct net_device *dev, unsigned int cmd,
@@ -1512,6 +1520,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_rss_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_rss_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_RSS_CREATE_ACT,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_rss_create_doit,
+		.policy	= ethnl_rss_create_policy,
+		.maxattr = ARRAY_SIZE(ethnl_rss_create_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index e5516e529b4a..be092dfa4407 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -893,3 +893,206 @@ const struct ethnl_request_ops ethnl_rss_request_ops = {
 	.set			= ethnl_rss_set,
 	.set_ntf_cmd		= ETHTOOL_MSG_RSS_NTF,
 };
+
+/* RSS_CREATE */
+
+const struct nla_policy ethnl_rss_create_policy[ETHTOOL_A_RSS_INPUT_XFRM + 1] = {
+	[ETHTOOL_A_RSS_HEADER]	= NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_RSS_CONTEXT]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RSS_HFUNC]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RSS_INDIR]	= NLA_POLICY_MIN(NLA_BINARY, 1),
+	[ETHTOOL_A_RSS_HKEY]	= NLA_POLICY_MIN(NLA_BINARY, 1),
+	[ETHTOOL_A_RSS_INPUT_XFRM] =
+		NLA_POLICY_MAX(NLA_U32, RXH_XFRM_SYM_OR_XOR),
+};
+
+static int
+ethnl_rss_create_validate(struct net_device *dev, struct genl_info *info)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct nlattr **tb = info->attrs;
+	struct nlattr *bad_attr = NULL;
+	u32 rss_context, input_xfrm;
+
+	if (!ops->create_rxfh_context)
+		return -EOPNOTSUPP;
+
+	rss_context = nla_get_u32_default(tb[ETHTOOL_A_RSS_CONTEXT], 0);
+	if (ops->rxfh_max_num_contexts &&
+	    ops->rxfh_max_num_contexts <= rss_context) {
+		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT]);
+		return -ERANGE;
+	}
+
+	if (!ops->rxfh_per_ctx_key) {
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HKEY];
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_INPUT_XFRM];
+	}
+
+	input_xfrm = nla_get_u32_default(tb[ETHTOOL_A_RSS_INPUT_XFRM], 0);
+	if (input_xfrm & ~ops->supported_input_xfrm)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_INPUT_XFRM];
+
+	if (bad_attr) {
+		NL_SET_BAD_ATTR(info->extack, bad_attr);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void
+ethnl_rss_create_send_ntf(struct sk_buff *rsp, struct net_device *dev)
+{
+	struct nlmsghdr *nlh = (void *)rsp->data;
+	struct genlmsghdr *genl_hdr;
+
+	/* Convert the reply into a notification */
+	nlh->nlmsg_pid = 0;
+	nlh->nlmsg_seq = ethnl_bcast_seq_next();
+
+	genl_hdr = nlmsg_data(nlh);
+	genl_hdr->cmd =	ETHTOOL_MSG_RSS_CREATE_NTF;
+
+	ethnl_multicast(rsp, dev);
+}
+
+int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	bool indir_dflt = false, mod = false, ntf_fail = false;
+	struct ethtool_rxfh_param rxfh = {};
+	struct ethtool_rxfh_context *ctx;
+	struct nlattr **tb = info->attrs;
+	struct rss_reply_data data = {};
+	const struct ethtool_ops *ops;
+	struct rss_req_info req = {};
+	struct net_device *dev;
+	struct sk_buff *rsp;
+	void *hdr;
+	u32 limit;
+	int ret;
+
+	rsp = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	ret = ethnl_parse_header_dev_get(&req.base, tb[ETHTOOL_A_RSS_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		goto exit_free_rsp;
+
+	dev = req.base.dev;
+	ops = dev->ethtool_ops;
+
+	req.rss_context = nla_get_u32_default(tb[ETHTOOL_A_RSS_CONTEXT], 0);
+
+	ret = ethnl_rss_create_validate(dev, info);
+	if (ret)
+		goto exit_free_dev;
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto exit_dev_unlock;
+
+	ret = rss_get_data_alloc(dev, &data);
+	if (ret)
+		goto exit_ops;
+
+	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_dflt, &mod);
+	if (ret)
+		goto exit_clean_data;
+
+	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
+
+	ret = rss_set_prep_hkey(dev, info, &data, &rxfh, &mod);
+	if (ret)
+		goto exit_free_indir;
+
+	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
+	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
+
+	ctx = ethtool_rxfh_ctx_alloc(ops, data.indir_size, data.hkey_size);
+	if (!ctx) {
+		ret = -ENOMEM;
+		goto exit_free_hkey;
+	}
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	if (!req.rss_context) {
+		limit = ops->rxfh_max_num_contexts ?: U32_MAX;
+		ret = xa_alloc(&dev->ethtool->rss_ctx, &req.rss_context, ctx,
+			       XA_LIMIT(1, limit - 1), GFP_KERNEL_ACCOUNT);
+	} else {
+		ret = xa_insert(&dev->ethtool->rss_ctx,
+				req.rss_context, ctx, GFP_KERNEL_ACCOUNT);
+	}
+	if (ret < 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT],
+				    "error allocating context ID");
+		goto err_unlock_free_ctx;
+	}
+	rxfh.rss_context = req.rss_context;
+
+	ret = ops->create_rxfh_context(dev, ctx, &rxfh, info->extack);
+	if (ret)
+		goto err_ctx_id_free;
+
+	/* Make sure driver populates defaults */
+	WARN_ON_ONCE(!rxfh.key && ops->rxfh_per_ctx_key &&
+		     !memchr_inv(ethtool_rxfh_context_key(ctx), 0,
+				 ctx->key_size));
+
+	/* Store the config from rxfh to Xarray.. */
+	rss_set_ctx_update(ctx, tb, &data, &rxfh);
+	/* .. copy from Xarray to data. */
+	__rss_prepare_ctx(dev, &data, ctx);
+
+	hdr = ethnl_unicast_put(rsp, info->snd_portid, info->snd_seq,
+				ETHTOOL_MSG_RSS_CREATE_ACT_REPLY);
+	ntf_fail = ethnl_fill_reply_header(rsp, dev, ETHTOOL_A_RSS_HEADER);
+	ntf_fail |= rss_fill_reply(rsp, &req.base, &data.base);
+	if (WARN_ON(!hdr || ntf_fail)) {
+		ret = -EMSGSIZE;
+		goto exit_unlock;
+	}
+
+	genlmsg_end(rsp, hdr);
+
+	/* Use the same skb for the response and the notification,
+	 * genlmsg_reply() will copy the skb if it has elevated user count.
+	 */
+	skb_get(rsp);
+	ret = genlmsg_reply(rsp, info);
+	ethnl_rss_create_send_ntf(rsp, dev);
+	rsp = NULL;
+
+exit_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+exit_free_hkey:
+	kfree(rxfh.key);
+exit_free_indir:
+	kfree(rxfh.indir);
+exit_clean_data:
+	rss_get_data_free(&data);
+exit_ops:
+	ethnl_ops_complete(dev);
+exit_dev_unlock:
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+exit_free_dev:
+	ethnl_parse_header_dev_put(&req.base);
+exit_free_rsp:
+	nlmsg_free(rsp);
+	return ret;
+
+err_ctx_id_free:
+	xa_erase(&dev->ethtool->rss_ctx, req.rss_context);
+err_unlock_free_ctx:
+	kfree(ctx);
+	goto exit_unlock;
+}
-- 
2.50.1


