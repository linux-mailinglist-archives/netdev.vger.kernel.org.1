Return-Path: <netdev+bounces-206025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A6B010FD
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9F01C85362
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA218C91F;
	Fri, 11 Jul 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkM73VZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89317A316
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198823; cv=none; b=qKKaMuwkuILrIG+YoIRFhAAX0+CGr8zjtYV51cd/c7q7SiYR7v4qFkb7Fi4gm0HwFsxmHUbvKTe46lkgLZ0BuZG9XPfgNCHLqLBmNLTOAwQ8w2TRb2+ELbcqLGDwXani5+KRyaaGsUShFKPml9eaRKJi97cs3hT+6dkWFFNYxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198823; c=relaxed/simple;
	bh=bEHU205LPRtfBzGqkp8vReH7tVaHsp+gIEQOGOUnDvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw/VLSTn0fw/IHnv6LINaLKiW4IjZTfcsVxwjA1LkS/2FYB4woaO074PdCvHBkZZDEPXTfL2t2FlyY0wAZ+eNEita4qf3+UgNAYp++VgiqqlZ2irU214+z5ugO0tsJQTTDRrSL7lGQFchOuxlQGLWRmIhj0d4/7MvCk9Hmozyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkM73VZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3822C4CEFA;
	Fri, 11 Jul 2025 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198823;
	bh=bEHU205LPRtfBzGqkp8vReH7tVaHsp+gIEQOGOUnDvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkM73VZh2vUBJ8ZdsQhvZMz3cpZJwFlqbRmZneW5RyYE4qKZEOhNg0v/Jt6pL4YdQ
	 48t3mjjTgLm1sTwnh7KG/uB9h6jCH6R69m63ZHQ70m6+UZdImG1X/puWZqBEWSbdeD
	 HkTAqJFvO1Dene8Q0y2utEPlBBVUpFKHzqsKTfSYeWLdLLEm4fdruf0s+eJksHcNeB
	 uLVEKsYQfQS1CUL2RXDVaSgjZHmfZoTU/HYVeCuNN0B2RO+VmoKhRSiv/AouuJH/Hm
	 3cf/Ako/s3iHFxm/caV32+PnHFCVuXtL9ocOggTALzgAbMzMgG3R5+gyFmafLU0RJm
	 t69Npg3jG7c0g==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] ethtool: rss: support setting input-xfrm via Netlink
Date: Thu, 10 Jul 2025 18:53:01 -0700
Message-ID: <20250711015303.3688717-10-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
References: <20250711015303.3688717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support configuring symmetric hashing via Netlink.
We have the flow field config prepared as part of SET handling,
so scan it for conflicts instead of querying the driver again.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml     |  1 +
 Documentation/networking/ethtool-netlink.rst |  4 +-
 net/ethtool/common.h                         |  1 +
 net/ethtool/common.c                         | 15 ++++++
 net/ethtool/ioctl.c                          |  4 +-
 net/ethtool/rss.c                            | 51 +++++++++++++++++++-
 6 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 3a0453a92300..15cc3f2184eb 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2680,6 +2680,7 @@ c-version-name: ethtool-genl-version
             - hfunc
             - indir
             - hkey
+            - input-xfrm
     -
       name: rss-ntf
       doc: |
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 1830354495ae..2214d2ce346a 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2002,6 +2002,7 @@ RSS_SET
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
+  ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
 =====================================  ======  ==============================
 
 ``ETHTOOL_A_RSS_INDIR`` is the minimal RSS table the user expects. Kernel and
@@ -2012,9 +2013,6 @@ device needs at least 8 entries - the real table in use will end up being
 of 2, so tables which size is not a power of 2 will likely be rejected.
 Using table of size 0 will reset the indirection table to the default.
 
-Note that, at present, only a subset of RSS configuration can be accomplished
-over Netlink.
-
 PLCA_GET_CFG
 ============
 
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c41db1595621..b2718afe38b5 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -44,6 +44,7 @@ int ethtool_check_max_channel(struct net_device *dev,
 			      struct ethtool_channels channels,
 			      struct genl_info *info);
 int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context);
+int ethtool_rxfh_config_is_sym(u64 rxfh);
 
 void ethtool_ringparam_get_cfg(struct net_device *dev,
 			       struct ethtool_ringparam *param,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index d62dc56f2f5b..b02067882594 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -806,6 +806,21 @@ int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context)
 	return rc;
 }
 
+/* Check if fields configured for flow hash are symmetric - if src is included
+ * so is dst and vice versa.
+ */
+int ethtool_rxfh_config_is_sym(u64 rxfh)
+{
+	bool sym;
+
+	sym = rxfh == (rxfh & (RXH_IP_SRC | RXH_IP_DST |
+			       RXH_L4_B_0_1 | RXH_L4_B_2_3));
+	sym &= !!(rxfh & RXH_IP_SRC)   == !!(rxfh & RXH_IP_DST);
+	sym &= !!(rxfh & RXH_L4_B_0_1) == !!(rxfh & RXH_L4_B_2_3);
+
+	return sym;
+}
+
 int ethtool_check_ops(const struct ethtool_ops *ops)
 {
 	if (WARN_ON(ops->set_coalesce && !ops->supported_coalesce_params))
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index cccb4694f5e1..d6c008b93fbb 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1027,9 +1027,7 @@ static int ethtool_check_xfrm_rxfh(u32 input_xfrm, u64 rxfh)
 	 */
 	if ((input_xfrm != RXH_XFRM_NO_CHANGE &&
 	     input_xfrm & (RXH_XFRM_SYM_XOR | RXH_XFRM_SYM_OR_XOR)) &&
-	    ((rxfh & ~(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
-	     (!!(rxfh & RXH_IP_SRC) ^ !!(rxfh & RXH_IP_DST)) ||
-	     (!!(rxfh & RXH_L4_B_0_1) ^ !!(rxfh & RXH_L4_B_2_3))))
+	    !ethtool_rxfh_config_is_sym(rxfh))
 		return -EINVAL;
 
 	return 0;
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 20c7122fdc99..839cf65b35f8 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -476,6 +476,8 @@ const struct nla_policy ethnl_rss_set_policy[ETHTOOL_A_RSS_START_CONTEXT + 1] =
 	[ETHTOOL_A_RSS_HFUNC] = NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RSS_INDIR] = { .type = NLA_BINARY, },
 	[ETHTOOL_A_RSS_HKEY] = NLA_POLICY_MIN(NLA_BINARY, 1),
+	[ETHTOOL_A_RSS_INPUT_XFRM] =
+		NLA_POLICY_MAX(NLA_U32, RXH_XFRM_SYM_OR_XOR),
 };
 
 static int
@@ -485,6 +487,7 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct rss_req_info *request = RSS_REQINFO(req_info);
 	struct nlattr **tb = info->attrs;
 	struct nlattr *bad_attr = NULL;
+	u32 input_xfrm;
 
 	if (request->rss_context && !ops->create_rxfh_context)
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];
@@ -492,8 +495,13 @@ ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (request->rss_context && !ops->rxfh_per_ctx_key) {
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HFUNC];
 		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_HKEY];
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_INPUT_XFRM];
 	}
 
+	input_xfrm = nla_get_u32_default(tb[ETHTOOL_A_RSS_INPUT_XFRM], 0);
+	if (input_xfrm & ~ops->supported_input_xfrm)
+		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_INPUT_XFRM];
+
 	if (bad_attr) {
 		NL_SET_BAD_ATTR(info->extack, bad_attr);
 		return -EOPNOTSUPP;
@@ -609,6 +617,33 @@ rss_set_prep_hkey(struct net_device *dev, struct genl_info *info,
 	return 0;
 }
 
+static int
+rss_check_rxfh_fields_sym(struct net_device *dev, struct genl_info *info,
+			  struct rss_reply_data *data, bool xfrm_sym)
+{
+	struct nlattr **tb = info->attrs;
+	int i;
+
+	if (!xfrm_sym)
+		return 0;
+	if (!data->has_flow_hash) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_RSS_INPUT_XFRM],
+				    "hash field config not reported");
+		return -EINVAL;
+	}
+
+	for (i = 1; i < __ETHTOOL_A_FLOW_CNT; i++)
+		if (data->flow_hash[i] >= 0 &&
+		    !ethtool_rxfh_config_is_sym(data->flow_hash[i])) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    tb[ETHTOOL_A_RSS_INPUT_XFRM],
+					    "hash field config is not symmetric");
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
 static void
 rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh)
@@ -627,13 +662,15 @@ rss_set_ctx_update(struct ethtool_rxfh_context *ctx, struct nlattr **tb,
 	}
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE)
 		ctx->hfunc = rxfh->hfunc;
+	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE)
+		ctx->input_xfrm = rxfh->input_xfrm;
 }
 
 static int
 ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 {
+	bool indir_reset = false, indir_mod = false, xfrm_sym = false;
 	struct rss_req_info *request = RSS_REQINFO(req_info);
-	bool indir_reset = false, indir_mod = false;
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct net_device *dev = req_info->dev;
 	struct ethtool_rxfh_param rxfh = {};
@@ -667,7 +704,17 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		goto exit_clean_data;
 
-	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
+	rxfh.input_xfrm = data.input_xfrm;
+	ethnl_update_u8(&rxfh.input_xfrm, tb[ETHTOOL_A_RSS_INPUT_XFRM], &mod);
+	/* xfrm_input is NO_CHANGE AKA 0xff if per-context not supported */
+	if (!request->rss_context || ops->rxfh_per_ctx_key)
+		xfrm_sym = !!rxfh.input_xfrm;
+	if (rxfh.input_xfrm == data.input_xfrm)
+		rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
+
+	ret = rss_check_rxfh_fields_sym(dev, info, &data, xfrm_sym);
+	if (ret)
+		goto exit_clean_data;
 
 	mutex_lock(&dev->ethtool->rss_lock);
 	if (request->rss_context) {
-- 
2.50.1


