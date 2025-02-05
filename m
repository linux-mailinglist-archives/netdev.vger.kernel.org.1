Return-Path: <netdev+bounces-162941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2716A288D1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369A9165453
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0E22CBFD;
	Wed,  5 Feb 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A4PaMW7h"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698115198E;
	Wed,  5 Feb 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753502; cv=none; b=tp7v7jr0tTbahxafG0/d9oM4/oK1SDz/wSc0pLrfVpPxO4r6h1HZStBYmCppTR2SdYvOw3rWqMFie5UMAwH0AZSSx1DepJsMDL7y2dwSRowYvN1LkC7MP4SDzMfouyo/PQlZgoyMBae5mKVdJIDUg6/VXVVh0xzThkb4v9c69cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753502; c=relaxed/simple;
	bh=DGVXjVg8RAwsP/Dp4kA//P6vgnifP8xK1RUISsmVgw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7jsQWd6F96NkFmpZkYEVWB72RIU5ICumcgft0AJTgwHGjTDnhjCHxTCjCYG0vDbOT6G/0ru6GrXmBONrwgoVA1pG+2jXhU/Vi3Zpa8hzTUeULCseYbWBC1nCi8Nqu7dszPxDEOmqQtmjSsaj+YZdxKa7KJ7PgXjsUAcd0awtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A4PaMW7h; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9155458138C;
	Wed,  5 Feb 2025 11:04:17 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0C4244288;
	Wed,  5 Feb 2025 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738753450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BDAAAVZpKpGbZtkiC8xflhp3Jt0i1JP80IfRh8Sb2K4=;
	b=A4PaMW7htn4bjEm98FrhExYlgzm78vmUoUiuUNGNaWeI0d6M/1OsgbzEGBH3un0KYAJXQC
	Wve6tc+Z419wg9Glr478MyQ64/otu550p2DBvFt2rebyZ+q7sXlIgru4o9wxkesGn+2ZgG
	c+Xw8eVK6lv6XPl/QolWLSl373f0dqbP2pTCyEm2P6AuT3U8RTcMvvpn08QhM6VuK4/uDv
	onvck0pvUd2x5WvHy8TUgneFzcXwEFKd1vZ1jhf7leABxlLwKxx9nv4LQBcAYIxGsjvsrA
	kvAmCjV9RcU+B1qF3hE8Z18S42rE2u66vwprOH/Yq95Cm0RO36nTwxLhNYQrEg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: ethtool: tsconfig: Fix netlink type of hwtstamp flags
Date: Wed,  5 Feb 2025 12:03:01 +0100
Message-Id: <20250205110304.375086-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegudegvdeklefhheefueeiieegteegteeuudegteduvdevffeikefgjeekgfdukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddrrddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrs
 hdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Fix the netlink type for hardware timestamp flags, which are represented
as a bitset of flags. Although only one flag is supported currently, the
correct netlink bitset type should be used instead of u32 to keep
consistency with other fields. Address this by adding a new named string
set description for the hwtstamp flag structure.

The code has been introduced in the current release so the uAPI change is
still okay.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
---

Changes in v2:
- Update commit message.
---
 Documentation/netlink/specs/ethtool.yaml |  3 ++-
 include/uapi/linux/ethtool.h             |  2 ++
 net/ethtool/common.c                     |  5 ++++
 net/ethtool/common.h                     |  2 ++
 net/ethtool/strset.c                     |  5 ++++
 net/ethtool/tsconfig.c                   | 33 +++++++++++++++++-------
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
index 9188e088fb2f..2be356bdfe87 100644
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
 
 	BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32);
 	BUILD_BUG_ON(__HWTSTAMP_FILTER_CNT >= 32);
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


