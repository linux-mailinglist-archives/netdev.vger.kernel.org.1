Return-Path: <netdev+bounces-84969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52D898D47
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE9E28D137
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606A12EBDC;
	Thu,  4 Apr 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0u+JQhQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17F12D770
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252093; cv=fail; b=Aeod+ReJkI3/c3mSaGubV9+Hr2TikMaXo0yvetWDlqmEVOHOX6ZN7EuexVnOL01G0nSt+IZ+H8632RFEEyIqW1Ec/dhZHsOArK/ybig+aJhppZ0xtC171jCJhc87zX/Z6AwngUkMRIC3pDe8f1pNqpEEaRuQnJ0BxxEk1paOP3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252093; c=relaxed/simple;
	bh=k2b6tNatk1khfG9R5hiSGpUjQtc3+9YWFEMxK1IdJug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKxrXmo4yEmuoono2j2HHn2Rrn6R5SIu4hkrcNRirR6pixj69DTUXbciFmqs488Joi5sL9VncgqD6X3/Nr3l+cHuRe7Na08Cv4SvsplX0QzWx0IA4kViPfCzBN0jDjHdo5uJXXCXcEAGbjtez6s61HoHi1IusZjNG9XNpvdAk9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0u+JQhQ; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHlMxix2ldqXeSppcZdN0gxkHu7modI+eb041gro9fj55zkKYeVcLENhE/km2uFhQ0WO3FbkKmfsTZchJ3m9xkz05b/2OtO2EEu3ZCrB/7pi8OyX0w+bAqLLADJWVsik5aOKE/jaqcKykD2MGKtv5H1WwkYBuD5N0Nwy+Bt81kb8LUR5K/E3akYeCLc8B0rgBy0WgMNdw6htP/7VJGBiRJU1XkMLn5jMIGfisA8JXEqNUlLCTMkDahzmxJrKZHcs2l75MEyeLDexXVuPPoVSFaR+jPQqHmt/i/+jNybwvezunSdiRfq8iMXMq3kV9rQJpm52E89GmLuN7u6TX8kEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgceVM/qabZD6BUpvx+R2IoVFz66r4YZCI4pa293OE8=;
 b=Z2COwpST2ygGdMrwGljviHQD0jNrWFHkE3Knn4SjT3Bo21OSfp2oAqRdU4RduMtYAaw+UtItdxq/tQDB+0ik9EvQ/3I2ijeQASxuD6CSSDQSc3uWkiWsLMgY8E0zGI9PjxqaRI6Oc0XhacdUOwA+QFlIL7ydSPzjVab6/A+knHiERJ/HmgVS4PwtBIRzO2r8t77UCCGJ6oSx1i9jNXVmDd1qKPvgfLuuvwyvM8WYbOo+HxZV99ZIGUuEzoKgI6ZiSc+4oNcIujnKNE0zTtwUyTdOQNSyfzTwOgCr1Bs/o3WNKILXyiuRBO6MnWe4v/RGQgB3ndfAx/Pl6lbUOve5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgceVM/qabZD6BUpvx+R2IoVFz66r4YZCI4pa293OE8=;
 b=e0u+JQhQPnh66fb8d9nOlqOb3/8ssrBCC9Goi6mGPAUT/BKROohCzpH8ydN2/ZRg9248/RjpAHgRhtSmvodc3Q0e0DfUAYjWvejhOGZIEP7EUBdLGZ6uMet5evB+5fCxxLIZD6/+d8T9meq7CfYT8rNoVrMpfG1R1wQKe7MIU9Gst2vr1vFV0vmwKJxoWYPC6lgrJTfCQsupT3KBf4KA6CFy2CIqilrez+iZ3Rh1TiH8AWm2/JokvB7tMxK2WlujhZ/GRYDcytj+S003g+jCyEoDva7RiS8JO8RlHjqkD6cEHmsLcE7nD/k/W4bbX8b9myAYUSWcvqRPibq172brmA==
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 17:34:46 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a7) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 3/5] ethtool: add interface to read representor Rx statistics
Date: Thu, 4 Apr 2024 20:33:55 +0300
Message-ID: <20240404173357.123307-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 76edcfdd-853c-40c6-6add-08dc54cd851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwwBqydmHKU0/YtKWsnCyuv0eooSD7Fyv5deOc5olVEH+K4GdHjL79J3WHBbC5uq+SUjDL/+TwTzcKxPG0eIJ3R92wXTS4il6FdN/MuhRu+VP/JHLDSsWVccfb9dZSWCH30oXY6g37lTujmMFMZLzkBW5AQII4XbjwBoDrJJdHmXPgmj/Ivn/3/VnvxUf1nQla6eW8eFU2t+5kay963gJ0gbVYnzctUbVqCEw+csDgjy1GbGajinXz8s3H9IMYY6Zw+2Wx40lXHM+OXYKTDwzrLbnVeDG5Xp0kkRwOuiIfZTGD112/fnqNjbuY6S6c6xLem/Arw2gE6jLVIPIGsIrK+jOPgkDU3+b5HLsxwqdsqs/lQgDoqARl4VLR5VSRnNP1ewgItZ/fQMZsxZ03BDvR9B2zj1pdK7g5E2KwolgbtN5Om80qf6NQ5AXbJDMK4nO3YA8AbEj869wZgJ8ky/KKthVZkxiSI0Jk6Hh3paUzFb5kzgiw72HZNTMqfAIcTunOknngu7WbIoBib5+CP5/thwsAifFIXeAbOt93EVTKcR/NmrPCaBuqJGEleiOwD5E4dGo6X/g5l6tYnfP2Qs5wdCP5sMRnYgvN4OvRkn3EJaWu/nE/pYTzPTd8mlLCrQGCAwuuHk2mh0CgJkG3rKac0lNynbLnKzb3sPUksvg9R6Zn0IlNo0QdCcT28qLjzKKzwg6bRS5raK2CljabNTQhAXpdM9WjWo1nXVFhvpka/2ja/O/kT0vl78JoiwmcCR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:45.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76edcfdd-853c-40c6-6add-08dc54cd851a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

From: Carolina Jubran <cjubran@nvidia.com>

Implement common representor port statistics in
a rep_port_stats struct_group, introducing a new
'out of buffer' stats for when packets are dropped
due to a lack of receive buffers in RX queue.

The port statistics represent the statistics of the
function with which the representor is associated.

Print the representor port stats when the
--groups rep-port or --all-groups are used.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/ethtool.h              | 16 ++++++++++++++
 include/uapi/linux/ethtool.h         |  2 ++
 include/uapi/linux/ethtool_netlink.h | 10 +++++++++
 net/ethtool/netlink.h                |  1 +
 net/ethtool/stats.c                  | 31 ++++++++++++++++++++++++++++
 net/ethtool/strset.c                 |  5 +++++
 6 files changed, 65 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 9901e563f706..6f2a6c78d41d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -480,6 +480,17 @@ struct ethtool_rmon_stats {
 	);
 };
 
+/**
+ * struct ethtool_rep_port_stats - representor port statistics
+ * @rep_port_stats: struct group for representor port
+ *	@out_of_buf: Number of packets were dropped due to buffer exhaustion.
+ */
+struct ethtool_rep_port_stats {
+	struct_group(rep_port_stats,
+		u64 out_of_buf;
+	);
+};
+
 #define ETH_MODULE_EEPROM_PAGE_LEN	128
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
@@ -804,6 +815,8 @@ struct ethtool_rxfh_param {
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
  * @get_rmon_stats: Query some of the RMON (RFC 2819) statistics.
  *	Set %ranges to a pointer to zero-terminated array of byte ranges.
+ * @get_rep_port_stats: Query the representor port statistics.
+ *	Returns zero on success.
  * @get_module_power_mode: Get the power mode policy for the plug-in module
  *	used by the network device and its operational power mode, if
  *	plugged-in.
@@ -940,6 +953,9 @@ struct ethtool_ops {
 	void	(*get_rmon_stats)(struct net_device *dev,
 				  struct ethtool_rmon_stats *rmon_stats,
 				  const struct ethtool_rmon_hist_range **ranges);
+	int    (*get_rep_port_stats)(struct net_device *dev,
+				     struct ethtool_rep_port_stats *rep_port_stats,
+				     struct netlink_ext_ack *extack);
 	int	(*get_module_power_mode)(struct net_device *dev,
 					 struct ethtool_module_power_mode_params *params,
 					 struct netlink_ext_ack *extack);
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 11fc18988bc2..a3bc96e7e958 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -681,6 +681,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_STATS_REP_PORT: names of representor port statistics
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +707,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_STATS_REP_PORT,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index accbb1a231df..0257103a001a 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -764,6 +764,7 @@ enum {
 	ETHTOOL_STATS_ETH_MAC,
 	ETHTOOL_STATS_ETH_CTRL,
 	ETHTOOL_STATS_RMON,
+	ETHTOOL_STATS_REP_PORT,
 
 	/* add new constants above here */
 	__ETHTOOL_STATS_CNT
@@ -879,6 +880,15 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
+enum {
+	/* out_of_buf */
+	ETHTOOL_A_STATS_REP_PORT_OUT_OF_BUF,
+
+	/* add new constants above here */
+	__ETHTOOL_A_STATS_REP_PORT_CNT,
+	ETHTOOL_A_STATS_REP_PORT_MAX = (__ETHTOOL_A_STATS_REP_PORT_CNT - 1)
+};
+
 /* MODULE */
 
 enum {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..f1568fa788f2 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -454,5 +454,6 @@ extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING
 extern const char stats_eth_mac_names[__ETHTOOL_A_STATS_ETH_MAC_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_ctrl_names[__ETHTOOL_A_STATS_ETH_CTRL_CNT][ETH_GSTRING_LEN];
 extern const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN];
+extern const char stats_rep_port_names[__ETHTOOL_A_STATS_REP_PORT_CNT][ETH_GSTRING_LEN];
 
 #endif /* _NET_ETHTOOL_NETLINK_H */
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..84b05d9a2fc1 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -20,6 +20,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_rep_port_stats	rep_port_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -32,6 +33,7 @@ const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_STATS_ETH_MAC]			= "eth-mac",
 	[ETHTOOL_STATS_ETH_CTRL]		= "eth-ctrl",
 	[ETHTOOL_STATS_RMON]			= "rmon",
+	[ETHTOOL_STATS_REP_PORT]		= "rep-port",
 };
 
 const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN] = {
@@ -76,6 +78,10 @@ const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_A_STATS_RMON_JABBER]		= "etherStatsJabbers",
 };
 
+const char stats_rep_port_names[__ETHTOOL_A_STATS_REP_PORT_CNT][ETH_GSTRING_LEN] = {
+	[ETHTOOL_A_STATS_REP_PORT_OUT_OF_BUF]	= "out_of_buf",
+};
+
 const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1] = {
 	[ETHTOOL_A_STATS_HEADER]	=
 		NLA_POLICY_NESTED(ethnl_header_policy),
@@ -158,6 +164,15 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	    dev->ethtool_ops->get_rmon_stats)
 		dev->ethtool_ops->get_rmon_stats(dev, &data->rmon_stats,
 						 &data->rmon_ranges);
+	if (test_bit(ETHTOOL_STATS_REP_PORT, req_info->stat_mask) &&
+	    dev->ethtool_ops->get_rep_port_stats) {
+		ret = dev->ethtool_ops->get_rep_port_stats(dev, &data->rep_port_stats,
+							   info->extack);
+		if (ret) {
+			ethnl_ops_complete(dev);
+			return ret;
+		}
+	}
 
 	ethnl_ops_complete(dev);
 	return 0;
@@ -194,6 +209,10 @@ static int stats_reply_size(const struct ethnl_req_info *req_base,
 			nla_total_size(4)) *	/* _A_STATS_GRP_HIST_BKT_HI */
 			ETHTOOL_RMON_HIST_MAX * 2;
 	}
+	if (test_bit(ETHTOOL_STATS_REP_PORT, req_info->stat_mask)) {
+		n_stats += sizeof(struct ethtool_rep_port_stats) / sizeof(u64);
+		n_grps++;
+	}
 
 	len += n_grps * (nla_total_size(0) + /* _A_STATS_GRP */
 			 nla_total_size(4) + /* _A_STATS_GRP_ID */
@@ -370,6 +389,15 @@ static int stats_put_rmon_stats(struct sk_buff *skb,
 	return 0;
 }
 
+static int stats_put_rep_port_stats(struct sk_buff *skb,
+				    const struct stats_reply_data *data)
+{
+	if (stat_put(skb, ETHTOOL_A_STATS_REP_PORT_OUT_OF_BUF, data->rep_port_stats.out_of_buf))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int stats_put_stats(struct sk_buff *skb,
 			   const struct stats_reply_data *data,
 			   u32 id, u32 ss_id,
@@ -423,6 +451,9 @@ static int stats_fill_reply(struct sk_buff *skb,
 	if (!ret && test_bit(ETHTOOL_STATS_RMON, req_info->stat_mask))
 		ret = stats_put_stats(skb, data, ETHTOOL_STATS_RMON,
 				      ETH_SS_STATS_RMON, stats_put_rmon_stats);
+	if (!ret && test_bit(ETHTOOL_STATS_REP_PORT, req_info->stat_mask))
+		ret = stats_put_stats(skb, data, ETHTOOL_STATS_REP_PORT,
+				      ETH_SS_STATS_REP_PORT, stats_put_rep_port_stats);
 
 	return ret;
 }
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..01d7a6fd9471 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -105,6 +105,11 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_RMON_CNT,
 		.strings	= stats_rmon_names,
 	},
+	[ETH_SS_STATS_REP_PORT] = {
+		.per_dev	= false,
+		.count		= __ETHTOOL_A_STATS_REP_PORT_CNT,
+		.strings	= stats_rep_port_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.44.0


