Return-Path: <netdev+bounces-153364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D69F7C50
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CE163829
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F08227585;
	Thu, 19 Dec 2024 13:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984922616E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614760; cv=none; b=pdcMPWFjOx9XQWjKKXPT1TbR18mdhV5ZdF/0kGZVZvUyAaH/CbLbCILE+VVFuKNmEl/k3VbrqZDon54ORxEmpfSNQewkIADxKqwq9ndUUDX+F3flEq8r52xifMw20PEZgbSrBRrPS+8SXQ/qyGkOZaLvMMhoJhAlXA4uuAu5wEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614760; c=relaxed/simple;
	bh=r45wixo1Dwbc2zOnUrNoBbXFAJiuYmUoFAOqfeRc2KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neDLVqqIo6i9nGK61hGjlTTEj44jHbEgCliAfYFZoYdF17zSpLFUHHql/le+35peN11NQTXu2DzPg9ts15djc28wCa8MQ65cO3d6UpoTfidjzKh+ac9BmqP4BdGZ+az2d2SBxYsSj/iX9l6o7xvelR6+/bj3jM8FlbU2x0/XVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX5-0001b7-Oe; Thu, 19 Dec 2024 14:25:39 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX0-004DDC-1p;
	Thu, 19 Dec 2024 14:25:35 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX1-0032hn-0s;
	Thu, 19 Dec 2024 14:25:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 3/8] net: ethtool: add support for structured PHY statistics
Date: Thu, 19 Dec 2024 14:25:29 +0100
Message-Id: <20241219132534.725051-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219132534.725051-1-o.rempel@pengutronix.de>
References: <20241219132534.725051-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Introduce a new way to report PHY statistics in a structured and
standardized format using the netlink API. This new method does not
replace the old driver-specific stats, which can still be accessed with
`ethtool -S <eth name>`. The structured stats are available with
`ethtool -S <eth name> --all-groups`.

This new method makes it easier to diagnose problems by organizing stats
in a consistent and documented way.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- move 'struct ethtool_phy_stats' to this patch
---
 Documentation/networking/ethtool-netlink.rst |  1 +
 include/uapi/linux/ethtool.h                 |  2 +
 include/uapi/linux/ethtool_netlink.h         | 14 +++++++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/stats.c                          | 39 +++++++++++++++++++-
 net/ethtool/strset.c                         |  5 +++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index a7ba6368a4d5..da846f1d998e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1616,6 +1616,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently defined values are:
  ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
  ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
  ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
+ ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
  ====================== ======== ===============================================
 
 Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the reply.
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 7e1b3820f91f..d1089b88efc7 100644
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
index 9c909ce733a5..9ff72cfb2e98 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -99,6 +99,7 @@ enum {
 	ETHTOOL_STATS_ETH_MAC,
 	ETHTOOL_STATS_ETH_CTRL,
 	ETHTOOL_STATS_RMON,
+	ETHTOOL_STATS_PHY,
 
 	/* add new constants above here */
 	__ETHTOOL_STATS_CNT
@@ -193,6 +194,19 @@ enum {
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
 
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 0a09298fff92..1ce0a3de1430 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -511,5 +511,6 @@ extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING
 extern const char stats_eth_mac_names[__ETHTOOL_A_STATS_ETH_MAC_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_ctrl_names[__ETHTOOL_A_STATS_ETH_CTRL_CNT][ETH_GSTRING_LEN];
 extern const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN];
+extern const char stats_phy_names[__ETHTOOL_A_STATS_PHY_CNT][ETH_GSTRING_LEN];
 
 #endif /* _NET_ETHTOOL_NETLINK_H */
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index fc9f2358b075..6ecc81afb859 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -35,6 +35,7 @@ const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_STATS_ETH_MAC]			= "eth-mac",
 	[ETHTOOL_STATS_ETH_CTRL]		= "eth-ctrl",
 	[ETHTOOL_STATS_RMON]			= "rmon",
+	[ETHTOOL_STATS_PHY]			= "phydev",
 };
 
 const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN] = {
@@ -79,6 +80,15 @@ const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN] = {
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
@@ -155,7 +165,8 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
-	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	if ((test_bit(ETHTOOL_STATS_PHY, req_info->stat_mask) ||
+	     test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask)) &&
 	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE) {
 		if (phydev)
 			phy_ethtool_get_phy_stats(phydev, &data->phy_stats,
@@ -211,6 +222,10 @@ static int stats_reply_size(const struct ethnl_req_info *req_base,
 			nla_total_size(4)) *	/* _A_STATS_GRP_HIST_BKT_HI */
 			ETHTOOL_RMON_HIST_MAX * 2;
 	}
+	if (test_bit(ETHTOOL_STATS_PHY, req_info->stat_mask)) {
+		n_stats += sizeof(struct ethtool_phy_stats) / sizeof(u64);
+		n_grps++;
+	}
 
 	len += n_grps * (nla_total_size(0) + /* _A_STATS_GRP */
 			 nla_total_size(4) + /* _A_STATS_GRP_ID */
@@ -264,6 +279,25 @@ static int stats_put_phy_stats(struct sk_buff *skb,
 	return 0;
 }
 
+static int stats_put_phydev_stats(struct sk_buff *skb,
+				  const struct stats_reply_data *data)
+{
+	if (stat_put(skb, ETHTOOL_A_STATS_PHY_RX_PKTS,
+		     data->phydev_stats.rx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_BYTES,
+		     data->phydev_stats.rx_bytes) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_RX_ERRORS,
+		     data->phydev_stats.rx_errors) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_PKTS,
+		     data->phydev_stats.tx_packets) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_BYTES,
+		     data->phydev_stats.tx_bytes) ||
+	    stat_put(skb, ETHTOOL_A_STATS_PHY_TX_ERRORS,
+		     data->phydev_stats.tx_errors))
+		return -EMSGSIZE;
+	return 0;
+}
+
 static int stats_put_mac_stats(struct sk_buff *skb,
 			       const struct stats_reply_data *data)
 {
@@ -440,6 +474,9 @@ static int stats_fill_reply(struct sk_buff *skb,
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
2.39.5


