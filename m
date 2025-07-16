Return-Path: <netdev+bounces-207318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A4B06A4D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31301A60C06
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45DB1A4E70;
	Wed, 16 Jul 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IETvkZJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119D7483
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624262; cv=none; b=KZ5BYn3rpnH38afMbtXlLuWdiywszZPgG3Kkf5FVA44Z1k3qbdJDAXVx7Bt5nWv4+yYBj511GxmsRcT4lf/p4Pac/yOQxeSaciWPJhFatqbfOnrO++t0RdvVqEENVN6S35N5uV89Ar7lb2vGjBLTmzJT7Ev4vfCeVOzBdOsLHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624262; c=relaxed/simple;
	bh=ECn093ogkMLHdxaehEIk93W50h2MFiDyawQcVb56ags=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFDzw8Pq72/vFMDjO/yZbwC4Ns1nro+lm1EX6t7WNfGf2XMMtVW+/wOX4r57/d7d+6Mv0vjKsgSLm5CDKgbc8yUGCcnmOlAEIT7bKS7GlVxbVq4GsTfxJVZ4p08hnq813FxAEmfohzmKX3i8bd3zp+C6rQVzOIP2rrQzvrl+uX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IETvkZJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CAEC4CEF6;
	Wed, 16 Jul 2025 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624262;
	bh=ECn093ogkMLHdxaehEIk93W50h2MFiDyawQcVb56ags=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IETvkZJu/hi5ogLlpo2pLJYsLzsHYfE+BgUXAZI6mrpVLUxf+9Siej/7sgRg2VEav
	 XVNQ44WZS0XpN2GVHX+U3o+rGGnhqsoUiwgQKZUW7DHFKoN61Y54RCL+ZNCSqfop7J
	 G8jj+s1SV8FI3Aj89+aMKXePjyMqBlbuJpEZE6lN9pv1SAH5EfuWf1r2n3z9/nqzIl
	 trwg39KiX6D+a5UnnRq1O6yEFtZXfCnLyLK/69L8oZd9x48PaUdAlst/2rpt9IoM9y
	 43IsuDm3JCxZVQCJ+QbKu7ECnl/xlTMjg8d81BiPEI25hY2xAl5YRio3P4BiozHej9
	 PQfqjy9u1dxmg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 10/11] ethtool: rss: support setting flow hashing fields
Date: Tue, 15 Jul 2025 17:03:30 -0700
Message-ID: <20250716000331.1378807-11-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ETHTOOL_SRXFH (setting hashing fields) in RSS_SET.

The tricky part is dealing with symmetric hashing. In netlink user
can change the hashing fields and symmetric hash in one request,
in IOCTL the two used to be set via different uAPI requests.
Since fields and hash function config are still separate driver
callbacks - changes to the two are not atomic. Keep things simple
and validate the settings against both pre- and post- change ones.
Meaning that we will reject the config request if user tries
to correct the flow fields and set input_xfrm in one request,
or disables input_xfrm and makes flow fields non-symmetric.

We can adjust it later if there's a real need. Starting simple feels
right, and potentially partially applying the settings isn't nice,
either.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - improve commit msg
---
 Documentation/netlink/specs/ethtool.yaml     |   1 +
 Documentation/networking/ethtool-netlink.rst |   3 +-
 net/ethtool/netlink.h                        |   2 +-
 net/ethtool/rss.c                            | 111 +++++++++++++++++--
 4 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 41f26d58f2f9..069269edde01 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2679,6 +2679,7 @@ c-version-name: ethtool-genl-version
             - indir
             - hkey
             - input-xfrm
+            - flow-hash
     -
       name: rss-ntf
       doc: |
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2214d2ce346a..056832c77ffd 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2003,6 +2003,7 @@ RSS_SET
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
   ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
+  ``ETHTOOL_A_RSS_FLOW_HASH``          nested  Header fields included in hash
 =====================================  ======  ==============================
 
 ``ETHTOOL_A_RSS_INDIR`` is the minimal RSS table the user expects. Kernel and
@@ -2464,7 +2465,7 @@ are netlink only.
   ``ETHTOOL_GPFLAGS``                 ``ETHTOOL_MSG_PRIVFLAGS_GET``
   ``ETHTOOL_SPFLAGS``                 ``ETHTOOL_MSG_PRIVFLAGS_SET``
   ``ETHTOOL_GRXFH``                   ``ETHTOOL_MSG_RSS_GET``
-  ``ETHTOOL_SRXFH``                   n/a
+  ``ETHTOOL_SRXFH``                   ``ETHTOOL_MSG_RSS_SET``
   ``ETHTOOL_GGRO``                    ``ETHTOOL_MSG_FEATURES_GET``
   ``ETHTOOL_SGRO``                    ``ETHTOOL_MSG_FEATURES_SET``
   ``ETHTOOL_GRXRINGS``                n/a
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 620dd1ab9b3b..ddb2fb00f929 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -484,7 +484,7 @@ extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MO
 extern const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1];
 extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
 extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
-extern const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
+extern const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1];
 extern const struct nla_policy ethnl_plca_get_cfg_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1];
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 79de013da288..bf45ebc22347 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -472,7 +472,41 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
 
 /* RSS_SET */
 
-const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] = {
+#define RFH_MASK (RXH_L2DA | RXH_VLAN | RXH_IP_SRC | RXH_IP_DST | \
+		  RXH_L3_PROTO | RXH_L4_B_0_1 | RXH_L4_B_2_3 |	  \
+		  RXH_GTP_TEID | RXH_DISCARD)
+
+static const struct nla_policy ethnl_rss_flows_policy[] = {
+	[ETHTOOL_A_FLOW_ETHER]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_IP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_IP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_TCP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_UDP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_SCTP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_AH_ESP4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_TCP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_UDP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_SCTP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_AH_ESP6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_AH4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_ESP4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_AH6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_ESP6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC4]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC6]		= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC_TEID4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPC_TEID6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_EH4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_EH6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_UL4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_UL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_DL4]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+	[ETHTOOL_A_FLOW_GTPU_DL6]	= NLA_POLICY_MASK(NLA_UINT, RFH_MASK),
+};
+
+const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_FLOW_HASH + 1] = {
 	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32, },
 	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -480,6 +514,7 @@ const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] =
 	[ETHTOOL_A_RSS_HKEY] = NLA_POLICY_MIN(NLA_BINARY, 1),
 	[ETHTOOL_A_RSS_INPUT_XFRM] =
 		NLA_POLICY_MAX(NLA_U32, RXH_XFRM_SYM_OR_XOR),
+	[ETHTOOL_A_RSS_FLOW_HASH] = NLA_POLICY_NESTED(ethnl_rss_flows_policy),
 };
 
 static int
@@ -504,6 +539,12 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (input_xfrm & ~ops->supported_input_xfrm)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_INPUT_XFRM];
 
+	if (tb[ETHTOOL_A_RSS_FLOW_HASH] && !ops->set_rxfh_fields)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_FLOW_HASH];
+	if (request->rss_context &&
+	    tb[ETHTOOL_A_RSS_FLOW_HASH] && !ops->rxfh_per_ctx_fields)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_FLOW_HASH];
+
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
 		return -EOPNOTSUPP;
@@ -644,6 +685,59 @@ rss_check_rxfh_fields_sym(struct net_device *dev, struct genl_info *info,
 	return 0;
 }
 
+static int
+ethnl_set_rss_fields(struct net_device *dev, struct genl_info *info,
+		     u32 rss_context, struct rss_reply_data *data,
+		     bool xfrm_sym, bool *mod)
+{
+	struct nlattr *flow_nest = info->attrs[ETHTOOL_A_RSS_FLOW_HASH];
+	struct nlattr *flows[ETHTOOL_A_FLOW_MAX + 1];
+	const struct ethtool_ops *ops;
+	int i, ret;
+
+	ops = dev->ethtool_ops;
+
+	ret = rss_check_rxfh_fields_sym(dev, info, data, xfrm_sym);
+	if (ret)
+		return ret;
+
+	if (!flow_nest)
+		return 0;
+
+	ret = nla_parse_nested(flows, ARRAY_SIZE(ethnl_rss_flows_policy) - 1,
+			       flow_nest, ethnl_rss_flows_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < __ETHTOOL_A_FLOW_CNT; i++) {
+		struct ethtool_rxfh_fields fields = {
+			.flow_type	= ethtool_rxfh_ft_nl2ioctl[i],
+			.rss_context	= rss_context,
+		};
+
+		if (!flows[i])
+			continue;
+
+		fields.data = nla_get_u32(flows[i]);
+		if (data->has_flow_hash && data->flow_hash[i] == fields.data)
+			continue;
+
+		if (xfrm_sym && !ethtool_rxfh_config_is_sym(fields.data)) {
+			NL_SET_ERR_MSG_ATTR(info->extack, flows[i],
+					    "conflict with xfrm-input");
+			return -EINVAL;
+		}
+
+		ret = ops->set_rxfh_fields(dev, &fields, info->extack);
+		if (ret)
+			return ret;
+
+		*mod = true;
+	}
+
+	return 0;
+}
+
 static void
 rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
@@ -673,11 +767,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct rss_req_info *request = RSS_REQINFO(req_info);
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct net_device *dev = req_info->dev;
+	bool mod = false, fields_mod = false;
 	struct ethtool_rxfh_param rxfh = {};
 	struct nlattr **tb = info->attrs;
 	struct rss_reply_data data = {};
 	const struct ethtool_ops *ops;
-	bool mod = false;
 	int ret;
 
 	ops = dev->ethtool_ops;
@@ -710,14 +804,10 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	 * symmetric hashing is requested.
 	 */
 	if (!request->rss_context || ops->rxfh_per_ctx_key)
-		xfrm_sym = !!rxfh.input_xfrm;
+		xfrm_sym = rxfh.input_xfrm || data.input_xfrm;
 	if (rxfh.input_xfrm == data.input_xfrm)
 		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
 
-	ret = rss_check_rxfh_fields_sym(dev, info, &data, xfrm_sym);
-	if (ret)
-		goto exit_clean_data;
-
 	mutex_lock(&dev->ethtool->rss_lock);
 	if (request->rss_context) {
 		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
@@ -727,6 +817,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 		}
 	}
 
+	ret = ethnl_set_rss_fields(dev, info, request->rss_context,
+				   &data, xfrm_sym, &fields_mod);
+	if (ret)
+		goto exit_unlock;
+
 	if (!mod)
 		ret = 0; /* nothing to tell the driver */
 	else if (!ops->set_rxfh)
@@ -753,7 +848,7 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 exit_clean_data:
 	rss_cleanup_data(&data.base);
 
-	return ret ?: mod;
+	return ret ?: mod || fields_mod;
 }
 
 const struct ethnl_request_ops ethnl_rss_request_ops = {
-- 
2.50.1


