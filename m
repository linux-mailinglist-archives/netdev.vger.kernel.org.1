Return-Path: <netdev+bounces-161358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F314CA20D2B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A4D163FDD
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE81D79B3;
	Tue, 28 Jan 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lBPZ5OvG"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479911C831A;
	Tue, 28 Jan 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078557; cv=none; b=pWKcu0Os3x4JflyrwAGMK627IXvgP85HLZXTGSW8DzPHHZZS6BCC3ojTAY3v0q/IeW//k0GBe7Bm1P35kXDmCamJhmmk5IOV/WKMVySv60kW8R1pEDgII2PJq1dAOz+OPovQl3sKW/8a0adgQN39zQWp7qR2GjZLiieI6hoqcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078557; c=relaxed/simple;
	bh=VelXopfmEXLdZQVOtP1WXpSI1uFe88AYTlsqabQ+GrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCCVnAw/jK0vWuyi28Z40R5Fymo05IhdBWHBPlTCxsLNtOZS1USqRbEX5jPC/6QlHsCPXUuw7tjvrVk4GJB6qR2Je/seTPBJcay/jzXICiw4fix65vpazUOSv3U2AFT5bw/4g8qJzW2ajvfdfJKVZ1GleXs7SFoVW1ujk7KQ13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lBPZ5OvG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D84FB442F4;
	Tue, 28 Jan 2025 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738078553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3IXFvvJpKIa0cvLJ+N1q7vWsOWWhiKeMF2TRBp81Rk=;
	b=lBPZ5OvGrw1Z3r2XY8TyXSvqntpfkhuckXkIcW1uqtQ7CVmVzazE10K1M/URvtl4+EIF2H
	l8LHVboUXnNabOBb08XRGUJ/c/bBtz+R6AUCopVFbycGSUcAMXmFvaXV2tUysB3T5H3j6p
	JM6CMfuwlCxe64trRvtIGEhoVriDw6og1LSm0ZwVvS/jduuCTOR7KGHv2N2NfXZj3+CKEM
	yhuftOdyMiFoKfqSfSODGDLEvyYj39BM9W9PgQ3D29z3PdsrFbs8M4BJycBChH8U4sWXKP
	zz4cwIP/h9eWB7Mk2crCKqQNwRJgLxmqbfJUeTQTgpvXBvt4CCAuDf6ipTwpCA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 28 Jan 2025 16:35:48 +0100
Subject: [PATCH net 3/3] net: ethtool: tsconfig: Fix netlink type of
 hwtstamp flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-fix_tsconfig-v1-3-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
In-Reply-To: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Fix the netlink type for hardware timestamp flags, which are represented
as a bitset of flags. Although only one flag is supported currently, the
correct netlink bitset type should be used instead of u32. Address this
by adding a new named string set description for the hwtstamp flag
structure.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
---
 Documentation/netlink/specs/ethtool.yaml |  3 ++-
 include/uapi/linux/ethtool.h             |  2 ++
 net/ethtool/common.c                     |  5 +++++
 net/ethtool/common.h                     |  2 ++
 net/ethtool/strset.c                     |  5 +++++
 net/ethtool/tsconfig.c                   | 33 ++++++++++++++++++++++----------
 6 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 259cb211a338..655d8d10fe24 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1524,7 +1524,8 @@ attribute-sets:
         nested-attributes: bitset
       -
         name: hwtstamp-flags
-        type: u32
+        type: nest
+        nested-attributes: bitset
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index d1089b88efc7..9b18c4cfe56f 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -682,6 +682,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
  * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
+ * @ETH_SS_TS_FLAGS: hardware timestamping flags
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -708,6 +709,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
 	ETH_SS_STATS_PHY,
+	ETH_SS_TS_FLAGS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2bd77c94f9f1..d88e9080643b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -462,6 +462,11 @@ const char ts_rx_filter_names[][ETH_GSTRING_LEN] = {
 };
 static_assert(ARRAY_SIZE(ts_rx_filter_names) == __HWTSTAMP_FILTER_CNT);
 
+const char ts_flags_names[][ETH_GSTRING_LEN] = {
+	[const_ilog2(HWTSTAMP_FLAG_BONDED_PHC_INDEX)] = "bonded-phc-index",
+};
+static_assert(ARRAY_SIZE(ts_flags_names) == __HWTSTAMP_FLAG_CNT);
+
 const char udp_tunnel_type_names[][ETH_GSTRING_LEN] = {
 	[ETHTOOL_UDP_TUNNEL_TYPE_VXLAN]		= "vxlan",
 	[ETHTOOL_UDP_TUNNEL_TYPE_GENEVE]	= "geneve",
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 850eadde4bfc..58e9e7db06f9 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -13,6 +13,7 @@
 	ETHTOOL_LINK_MODE_ ## speed ## base ## type ## _ ## duplex ## _BIT
 
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
+#define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
 
 struct link_mode_info {
 	int				speed;
@@ -38,6 +39,7 @@ extern const char wol_mode_names[][ETH_GSTRING_LEN];
 extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
 extern const char ts_tx_type_names[][ETH_GSTRING_LEN];
 extern const char ts_rx_filter_names[][ETH_GSTRING_LEN];
+extern const char ts_flags_names[][ETH_GSTRING_LEN];
 extern const char udp_tunnel_type_names[][ETH_GSTRING_LEN];
 
 int __ethtool_get_link(struct net_device *dev);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 818cf01f0911..6b76c05caba4 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -75,6 +75,11 @@ static const struct strset_info info_template[] = {
 		.count		= __HWTSTAMP_FILTER_CNT,
 		.strings	= ts_rx_filter_names,
 	},
+	[ETH_SS_TS_FLAGS] = {
+		.per_dev	= false,
+		.count		= __HWTSTAMP_FLAG_CNT,
+		.strings	= ts_flags_names,
+	},
 	[ETH_SS_UDP_TUNNEL_TYPES] = {
 		.per_dev	= false,
 		.count		= __ETHTOOL_UDP_TUNNEL_TYPE_CNT,
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 2dc3a3b76615..4e8fd4f5c27b 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -54,7 +54,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 
 	data->hwtst_config.tx_type = BIT(cfg.tx_type);
 	data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
-	data->hwtst_config.flags = BIT(cfg.flags);
+	data->hwtst_config.flags = cfg.flags;
 
 	data->hwprov_desc.index = -1;
 	hwprov = rtnl_dereference(dev->hwprov);
@@ -91,10 +91,16 @@ static int tsconfig_reply_size(const struct ethnl_req_info *req_base,
 
 	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
 	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FLAG_CNT > 32);
 
-	if (data->hwtst_config.flags)
-		/* _TSCONFIG_HWTSTAMP_FLAGS */
-		len += nla_total_size(sizeof(u32));
+	if (data->hwtst_config.flags) {
+		ret = ethnl_bitset32_size(&data->hwtst_config.flags,
+					  NULL, __HWTSTAMP_FLAG_CNT,
+					  ts_flags_names, compact);
+		if (ret < 0)
+			return ret;
+		len += ret;	/* _TSCONFIG_HWTSTAMP_FLAGS */
+	}
 
 	if (data->hwtst_config.tx_type) {
 		ret = ethnl_bitset32_size(&data->hwtst_config.tx_type,
@@ -130,8 +136,10 @@ static int tsconfig_fill_reply(struct sk_buff *skb,
 	int ret;
 
 	if (data->hwtst_config.flags) {
-		ret = nla_put_u32(skb, ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS,
-				  data->hwtst_config.flags);
+		ret = ethnl_put_bitset32(skb, ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS,
+					 &data->hwtst_config.flags, NULL,
+					 __HWTSTAMP_FLAG_CNT,
+					 ts_flags_names, compact);
 		if (ret < 0)
 			return ret;
 	}
@@ -180,7 +188,7 @@ const struct nla_policy ethnl_tsconfig_set_policy[ETHTOOL_A_TSCONFIG_MAX + 1] =
 	[ETHTOOL_A_TSCONFIG_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER] =
 		NLA_POLICY_NESTED(ethnl_ts_hwtst_prov_policy),
-	[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS] = { .type = NLA_U32 },
+	[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS] = { .type = NLA_NESTED },
 	[ETHTOOL_A_TSCONFIG_RX_FILTERS] = { .type = NLA_NESTED },
 	[ETHTOOL_A_TSCONFIG_TX_TYPES] = { .type = NLA_NESTED },
 };
@@ -296,6 +304,7 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 
 	BUILD_BUG_ON(__HWTSTAMP_TX_CNT > 32);
 	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT > 32);
+	BUILD_BUG_ON(__HWTSTAMP_FLAG_CNT > 32);
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -377,9 +386,13 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	}
 
 	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS]) {
-		ethnl_update_u32(&hwtst_config.flags,
-				 tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS],
-				 &config_mod);
+		ret = ethnl_update_bitset32(&hwtst_config.flags,
+					    __HWTSTAMP_FLAG_CNT,
+					    tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_FLAGS],
+					    ts_flags_names, info->extack,
+					    &config_mod);
+		if (ret < 0)
+			goto err_free_hwprov;
 	}
 
 	ret = net_hwtstamp_validate(&hwtst_config);

-- 
2.34.1


