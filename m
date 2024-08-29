Return-Path: <netdev+bounces-123421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26768964D23
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B97E1C2146F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E621B81B9;
	Thu, 29 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZuop0oa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D11B81B1;
	Thu, 29 Aug 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953426; cv=none; b=U1zGZgJq/ikGdyRIMajQzaE93h3icWl0pUHe4LjvX1QtEhYTYA5385IL5DsN9xd6LTP3dAaNxRwAji9kputvnvZMvLDk/v5OIUv8v4NHSDYfeq4zW5JEict7tVYNXGI6V5b7NKrM8fLC7Ih5qecZYMEahqgayNavPkxe51fjIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953426; c=relaxed/simple;
	bh=l0G1lj3t9kg7W6iJDFsH6SdUoM2JxSWq3bynPhlblBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAqyI5RUlwcTEMsdSKtcPRZkfAABi9MxoIMW/lyy7sfKpjwMEtJYdLaSk7CGx8iEv3faHRtgokvk4F9eCOQLrfZS1CPt280zJ6ajtSEMy8jxvWe6+VJftJaUyFK1Y7AFCKeG5yAO9O1JscEfKaDuZc0hmFLltWC4jMXZacwpDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZuop0oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E069BC4CEC5;
	Thu, 29 Aug 2024 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953426;
	bh=l0G1lj3t9kg7W6iJDFsH6SdUoM2JxSWq3bynPhlblBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZuop0oaFcT53M4mV4pxUMUOyndkBLivAGhMCWIL006hlwRWzFEYQTbfqF4gMmkqK
	 cdJH/HbZvOBrV5EbhN+1jrXuDjchrIiEztiY3kgIim6xDwlnExmg55OjUyL061cC9A
	 YDK9rTJJV1bQDNi78rOJEdVbJ/t8uPEHxJvZEYRPKqcHcjiQzC74LfT0piQhEwb9iT
	 pbiGM7TpjQN5l5TK2fMaERvnRdcz6KrQrL4014kIAiqOAWD1YssfBpmBfVMcwLZ1dn
	 Va5rZhn2X3c0J9fnQ+BorkJ26NIRKJq17yactUsEVIMJRGC3RgxYkLWwQwPCwwMynR
	 X5lQ8ZTMU1s1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	linux-doc@vger.kernel.org
Subject: [RFC net-next 2/2] net: ethtool: add phy(dev) specific stats over netlink
Date: Thu, 29 Aug 2024 10:43:42 -0700
Message-ID: <20240829174342.3255168-3-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829174342.3255168-1-kuba@kernel.org>
References: <20240829174342.3255168-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a way of getting PHY stats over the netlink API.
According to my limited understanding of PHYs they are more
standard-based than the rest of a network interface, so hopefully
these stats can be extended to cover most cases.

There's a bit of strategic ambiguity between phy and phydev
here, in case some integrated device wants to use these later.
But the new group is separate from eth-phy which is reserved
for IEEE stats.

Oleksij, if this patch works you can add the OA stats into
struct ethtool_phy_stats or struct ethtool_link_ext_stats.
They should show up in ethtool -S eth0 --all-groups
for the former or in ethtool -I eth0 for the latter.
Note link_stats need changes to ethtool CLI, but
they seem better suited for the stats based on their names?

There's a minor TODO for you to define the semantics
of the error counter, based on however the DP83TG720 PHY
behaves.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: andrew@lunn.ch
CC: hkallweit1@gmail.com
CC: linux@armlinux.org.uk
CC: ecree.xilinx@gmail.com
CC: przemyslaw.kitszel@intel.com
CC: kory.maincent@bootlin.com
CC: maxime.chevallier@bootlin.com
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/ethtool-netlink.rst |  1 +
 include/linux/ethtool.h                      | 15 +++++++
 include/linux/phy.h                          |  3 +-
 include/uapi/linux/ethtool.h                 |  2 +
 include/uapi/linux/ethtool_netlink.h         | 15 +++++++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/stats.c                          | 43 +++++++++++++++++++-
 net/ethtool/strset.c                         |  5 +++
 8 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ba90457b8b2d..7f6c23644645 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1608,6 +1608,7 @@ Users specify which groups of statistics they are requesting via
  ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
  ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
  ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
+ ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
  ====================== ======== ===============================================
 
 Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the reply.
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..0a09ea82e001 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -412,6 +412,21 @@ struct ethtool_eth_phy_stats {
 	);
 };
 
+/* Additional PHY statistics, not defined by IEEE */
+struct ethtool_phy_stats {
+	/* Basic packet / byte counters are meant for PHY drivers */
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_error; /* TODO: we need to define here whether packet
+		       * counted here is also counted as rx_packets,
+		       * and whether it's passed to the MAC with some
+		       * error indication or MAC never sees it.
+		       */
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_error; /* TODO: same as for rx */
+};
+
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
  * via a more targeted API.
  */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 53942fd7760f..9c3094706c7a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1097,7 +1097,8 @@ struct phy_driver {
 	 * must only set statistics which are actually collected by the device.
 	 */
 	void (*get_phy_stats)(struct phy_device *dev,
-			      struct ethtool_eth_phy_stats *eth_stats);
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats);
 	void (*get_link_stats)(struct phy_device *dev,
 			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index c405ed63acfa..977c5a8a0d6b 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -681,6 +681,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_STATS_PHY: names of PHY(dev) statistics
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +707,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_STATS_PHY,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..dc332f8aa3a6 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -820,6 +820,7 @@ enum {
 	ETHTOOL_STATS_ETH_MAC,
 	ETHTOOL_STATS_ETH_CTRL,
 	ETHTOOL_STATS_RMON,
+	ETHTOOL_STATS_PHY,
 
 	/* add new constants above here */
 	__ETHTOOL_STATS_CNT
@@ -935,6 +936,20 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
+enum {
+	/* Basic packet counters if PHY has separate counters from the MAC */
+	ETHTOOL_A_STATS_PHY_RX_PKTS,
+	ETHTOOL_A_STATS_PHY_RX_BYTES,
+	ETHTOOL_A_STATS_PHY_RX_ERRORS,
+	ETHTOOL_A_STATS_PHY_TX_PKTS,
+	ETHTOOL_A_STATS_PHY_TX_BYTES,
+	ETHTOOL_A_STATS_PHY_TX_ERRORS,
+
+	/* add new constants above here */
+	__ETHTOOL_A_STATS_PHY_CNT,
+	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
+};
+
 /* MODULE */
 
 enum {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..3a6ecdcb5b8c 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -505,5 +505,6 @@ extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING
 extern const char stats_eth_mac_names[__ETHTOOL_A_STATS_ETH_MAC_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_ctrl_names[__ETHTOOL_A_STATS_ETH_CTRL_CNT][ETH_GSTRING_LEN];
 extern const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN];
+extern const char stats_phy_names[__ETHTOOL_A_STATS_PHY_CNT][ETH_GSTRING_LEN];
 
 #endif /* _NET_ETHTOOL_NETLINK_H */
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index cf802b1cda6f..8ae3c57cea21 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -22,6 +22,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_phy_stats	phydev_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -34,6 +35,7 @@ const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_STATS_ETH_MAC]			= "eth-mac",
 	[ETHTOOL_STATS_ETH_CTRL]		= "eth-ctrl",
 	[ETHTOOL_STATS_RMON]			= "rmon",
+	[ETHTOOL_STATS_PHY]			= "phydev",
 };
 
 const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN] = {
@@ -78,6 +80,15 @@ const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_A_STATS_RMON_JABBER]		= "etherStatsJabbers",
 };
 
+const char stats_phy_names[__ETHTOOL_A_STATS_PHY_CNT][ETH_GSTRING_LEN] = {
+	[ETHTOOL_A_STATS_PHY_RX_PKTS]		= "RxFrames",
+	[ETHTOOL_A_STATS_PHY_RX_BYTES]		= "RxOctets",
+	[ETHTOOL_A_STATS_PHY_RX_ERRORS]		= "RxErrors",
+	[ETHTOOL_A_STATS_PHY_TX_PKTS]		= "TxFrames",
+	[ETHTOOL_A_STATS_PHY_TX_BYTES]		= "TxOctets",
+	[ETHTOOL_A_STATS_PHY_TX_ERRORS]		= "TxErrors",
+};
+
 const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1] = {
 	[ETHTOOL_A_STATS_HEADER]	=
 		NLA_POLICY_NESTED(ethnl_header_policy),
@@ -123,7 +134,8 @@ ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
 		return;
 
 	mutex_lock(&phydev->lock);
-	phydev->drv->get_phy_stats(phydev, &data->phy_stats);
+	phydev->drv->get_phy_stats(phydev, &data->phy_stats,
+				   &data->phydev_stats);
 	mutex_unlock(&phydev->lock);
 }
 
@@ -160,7 +172,8 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
-	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	if ((test_bit(ETHTOOL_STATS_PHY, req_info->stat_mask) ||
+	     test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask)) &&
 	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE)
 		ethtool_get_phydev_stats(dev, data);
 
@@ -213,6 +226,10 @@ static int stats_reply_size(const struct ethnl_req_info *req_base,
 			nla_total_size(4)) *	/* _A_STATS_GRP_HIST_BKT_HI */
 			ETHTOOL_RMON_HIST_MAX * 2;
 	}
+	if (test_bit(ETHTOOL_STATS_PHY, req_info->stat_mask)) {
+		n_stats += sizeof(struct ethtool_phy_stats) / sizeof(u64);
+		n_grps++;
+	}
 
 	len += n_grps * (nla_total_size(0) + /* _A_STATS_GRP */
 			 nla_total_size(4) + /* _A_STATS_GRP_ID */
@@ -266,6 +283,25 @@ static int stats_put_phy_stats(struct sk_buff *skb,
 	return 0;
 }
 
+static int stats_put_phydev_stats(struct sk_buff *skb,
+				  const struct stats_reply_data *data)
+{
+	if (stat_put(skb, ETHTOOL_A_STATS_PHY_RX_PKTS,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_BYTES,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_ERRORS,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_PKTS,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_BYTES,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_ERRORS,
+		     data->phydev_stats.rx_packets))
+		return -EMSGSIZE;
+	return 0;
+}
+
 static int stats_put_mac_stats(struct sk_buff *skb,
 			       const struct stats_reply_data *data)
 {
@@ -442,6 +478,9 @@ static int stats_fill_reply(struct sk_buff *skb,
 	if (!ret && test_bit(ETHTOOL_STATS_RMON, req_info->stat_mask))
 		ret = stats_put_stats(skb, data, ETHTOOL_STATS_RMON,
 				      ETH_SS_STATS_RMON, stats_put_rmon_stats);
+	if (!ret && test_bit(ETHTOOL_STATS_PHY, req_info->stat_mask))
+		ret = stats_put_stats(skb, data, ETHTOOL_STATS_PHY,
+				      ETH_SS_STATS_PHY, stats_put_phydev_stats);
 
 	return ret;
 }
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index b3382b3cf325..818cf01f0911 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -105,6 +105,11 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_RMON_CNT,
 		.strings	= stats_rmon_names,
 	},
+	[ETH_SS_STATS_PHY] = {
+		.per_dev	= false,
+		.count		= __ETHTOOL_A_STATS_PHY_CNT,
+		.strings	= stats_phy_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.46.0


