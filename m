Return-Path: <netdev+bounces-233278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E5C0FBA7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541944FC35B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189231770E;
	Mon, 27 Oct 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4TZvqo5"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603ED3176E0
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586862; cv=fail; b=Qa1Ww4cD6kpFuLElwyy4HsPxGvRPG6SeavZ0K9RfpnjtJKu5LtjufPrDvfIIVkXYCz4MMTKeBu/+vMD8E4jqCdJp6MRE+wzmJ8oCUUAKKql0yL9xgpIQTv6V2bCSVjj01jyKvGwbPs7E6LJSqKJKHnhSHfn0iZMX3r68qRBGAsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586862; c=relaxed/simple;
	bh=vDL+VcGihIAnef1CepOQ8v4USkjJhSDEfuCpW9YeewI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK7N1m2eO74XZUt6Ew5v8aeQFijd6Jp+d+2Buln6IgEY1BqN/4OK0TyxkxAJZmfDbdNIc01hctdZRLoKGYbEGHvwkTivmkTxC2+24iwX8GNma2GyY+WiXGCktAOwQYXqUoWev2G7mMMizJkMeBuP4WCtFyGYfwzpV06q4b3HNMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4TZvqo5; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGYvTsPpUJG4OqajZI1o/Nm7KlpvhuaoriGey2xp8583fFWmHA0pphx7X2e8+kgxBhA2lwi/HbYtYp063Xz3ETEsNKo0kmhaZK+Oo99CwtKY3n+31XxRXoIy56UbTS594ZMEcXEjsXujR0/HSyjchFZAbRq0XhSszoNBchNo+4sy+N+oJ/JuKUVT4t9Qw7L3ea3Q1HSyg94NlH6uC7+QiZfBCmi+er2/OelEm+f5zSEbjGSjdhOAv2u5gW8SMUv7ker/ognjGmhCxeW8UC8PbYmqmaDu98pwXzbtEEGd0rSdfSzV2/YBw0dvUdz88p0W6/Y7UbNNrlBxRBYVUpNxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NjB9PX9sbzS7pILfg68yrPst8oTLskv9UhPjkLjOI0=;
 b=d4ZYQzdQS9Xlv6XvpoKtKpnJZ2FZNlM6zBMK/YCnT1KzX1nImWlxLNYtoXbm09EREKTfsWVY+RIVuIYnIE46ulQCH2AJMYLVO3woD7+PC6kwV5o937TBBKaQTpt6QOjw3a1YHuUWSNFcjq8Rs0AmL/kr/J+sqnzOYTc2AIgj98TM4po/77mnSNyKm6CE4gs3nFaJIpeVbzhLx7i5NJjrHAKr3JIWQdhGP4NmNOecFG1jQHtLLkcTFKegj2hEwQJKzNakbvFT7VZ7TG+xzkgl6AGqv787jICKitwxSlWH6NiftDlMw9t/4IeL5hzCnrabsWmaovGe/zh+BUIUtWfd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NjB9PX9sbzS7pILfg68yrPst8oTLskv9UhPjkLjOI0=;
 b=L4TZvqo5fBcLBATFlm9csoRMon6firF4Gzu6CuKRcyPG8Bd8xi7D3AIspwGZ4zaYql5yPLoMBn35j5ev4KffucGZp97QoUT5qSxROgXh6wMvRvcs3yU/RW/aGLIJpJpmO3YKVt9Dqd2E5LQbHQKYaYnI3azGlTjkshI2jvGkd5BW9UV8j+Jym6gpW7dmUCVcPXA0lnx6xD83Q/rWGWmsxat7OodFe7C2axLfvvDNIPcau6TqE4sRO9pZ/dGzGY3G7FWB0+5g8fouu3uYZo5QlSGfiRNOfTQlDiPVvv3ABnXFlsFYHzeVrv6IoGJvwep7u8BVI5nacr2GgPixgUZimg==
Received: from DM6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:333::34)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 17:40:57 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::1) by DM6PR03CA0101.outlook.office365.com
 (2603:10b6:5:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 10:40:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:36 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 27 Oct 2025 12:39:57 -0500
Message-ID: <20251027173957.2334-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f735d2-c60f-4574-8bcd-08de157ffc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5vhaE+J7bMVQPAM+7cMNo8EYm75ceee/QZSlJwQoHoocB+K8h22x9XuQkil?=
 =?us-ascii?Q?iFk7rBMM8SEPFC1lOJAHJ1iyEwYJ50C1JLhcPLXmWayb7QSaUggXOWP7/7jt?=
 =?us-ascii?Q?ERC+aFF5df6O4sbTL6RCRRqQZrrIV7mwdIM5xioMX1ns0ZByhFf1j7C0FJUB?=
 =?us-ascii?Q?jsIOw1klVHebInpPl1s94WY0sgWgWaYYHVHj9wAoykOhPGm3uOYnhIWHn+6z?=
 =?us-ascii?Q?PBrdAIcXTVKRdp/o/nZegBkJyidNrCtMJM3kxBO/8hvBs1K5/1c8kAbhVI5B?=
 =?us-ascii?Q?x7r+jilksXURhc1h1rX/4QHbgVFPlvmoOA0wGH9qQLn1UPa2rdP5ll3qOxNt?=
 =?us-ascii?Q?Bm3qKxR089OwFRLEmMe8p1BuHlDxqB+EyK9HwdfdZhIrjYVZgXSNCjyKB/7q?=
 =?us-ascii?Q?lczOanEHIV+FaBfLupvvCxURZ5ex2KHKqkwKwfmKppKnwPaHhU00WcoXt+Zj?=
 =?us-ascii?Q?UQN+hRU4Y7N3ibnhOlcx1yN5RAGlIHvRhUUfLsgAbdGCMT85UXnQ8D8DT4oH?=
 =?us-ascii?Q?h1FFRKMdC8r33Pe8g5u0SO7hqkujfERbx3IzTwE+8B+7XVF9vUoKGk5KpcW/?=
 =?us-ascii?Q?hUva+dW0soHmk7ZuGmK52/83drAnanl5jeSqAuN0rsR99LwiKFaCoFOrgFIp?=
 =?us-ascii?Q?aCfEv16SdAFhgYBPzM50Flko+WMztkHARXEK8uM+l88NLjEaXOI2LF/C0lmR?=
 =?us-ascii?Q?woEijQwPYgsr4eK+mUWYqeb3qCHi5fIQ0/r2N5BtnH+FEJNGv7lyJ2hnEWhc?=
 =?us-ascii?Q?/0SZ0LqbKRjYhlPiuVDeS8GNkyhl5MlyirWpEhDHblOFBqKe5bth9b/H4rFD?=
 =?us-ascii?Q?6+0sMA5NQ7apVibEeX3tpUMvUhFPYVlNY9u9hGhpM0G5bhKnbTY1dtOMBJd+?=
 =?us-ascii?Q?Y3IJYN0rsfvHOe2bqwaESusdgQC3FfO5eiiRcVTJJBgi9A2WUY3wNkl1KyxQ?=
 =?us-ascii?Q?bOJFlUKE1leGOQGucJpey3uKDJiQ7cyFdwR9grlHrchDceNHDNwdBK2+flEd?=
 =?us-ascii?Q?DpLoRW0BCjgkwb9ipltZbGdriz4BkWwTCmmD0f5k3JW4lYFvfFpHbc2EDcnf?=
 =?us-ascii?Q?x0rU0/mkd+FRx9SbrFNzfPvHz9paeQvM0Ww4GO/7Ga7F6jFbSQEqIc9udtD6?=
 =?us-ascii?Q?zR5iOuVcMOiLYIv3/Lp5GzituSeNmwxUmkNXnZh99dgfoTOdHx4nGoIoEgkl?=
 =?us-ascii?Q?pdVQdwGGICzYfElXRVMTD2seKTLGhjjaJveSmYIPvp3RpZgmOWQYezrnOYAA?=
 =?us-ascii?Q?kPDSCAlpGxDMCBA207LMr4Deb1w7/u9bi0CwM5VfKn96HvjNHH7+eB37WdJh?=
 =?us-ascii?Q?25Zz1RZ50JB77/sLlOAuEnlBq0Z+fsTyan9CbrLrh8ngGTNDMDVzKwpyPmlj?=
 =?us-ascii?Q?dK4iXn0LgsY6EUCkILA6PDo1eW1KjHI9pNEzVZ8OPetLSRYNOcwoThJ7MvRQ?=
 =?us-ascii?Q?wXzdW0f39aItQ0emNCog2Xl+yvByEb9COYIvvVyW1JfIzTUl+6GUL6IcsPkx?=
 =?us-ascii?Q?tIXepwvKgFZ8I292VJa/rLdMuCZjrlkSM/LszJ/QsOY58aWY8+iODojB4MeG?=
 =?us-ascii?Q?gmNAhT9q9+ehO7wLWMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:57.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f735d2-c60f-4574-8bcd-08de157ffc99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

- Get total number of rules. There's no user interface for this. It is
  used to allocate an appropriately sized buffer for getting all the
  rules.

- Get specific rule
$ ethtool -u ens9 rule 0
	Filter: 0
		Rule Type: UDP over IPv4
		Src IP addr: 0.0.0.0 mask: 255.255.255.255
		Dest IP addr: 192.168.5.2 mask: 0.0.0.0
		TOS: 0x0 mask: 0xff
		Src port: 0 mask: 0xffff
		Dest port: 4321 mask: 0x0
		Action: Direct to queue 16

- Get all rules:
$ ethtool -u ens9
31 RX rings available
Total 2 rules

Filter: 0
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 192.168.5.2 mask: 0.0.0.0
...

Filter: 1
        Flow Type: Raw Ethernet
        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Dest MAC addr: 08:11:22:33:44:54 mask: 00:00:00:00:00:00

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: Answered questions about rules_limit overflow with no changes.
---
 drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a24fb601cc1..e01febca8b75 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -307,6 +307,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				       struct ethtool_rx_flow_spec *fs,
 				       u16 curr_queue_pairs);
 static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info);
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info);
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs);
 
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
@@ -5645,6 +5652,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc = 0;
+
+	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	return rc;
+}
+
 static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -5686,6 +5715,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7605,6 +7635,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+					  struct ethtool_rxnfc *info)
+{
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	info->rule_cnt = ff->ethtool.num_rules;
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
+
+	return 0;
+}
+
+static int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+				    struct ethtool_rxnfc *info)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, info->fs.location);
+	if (!eth_rule)
+		return -ENOENT;
+
+	info->fs = eth_rule->flow_spec;
+
+	return 0;
+}
+
+static int
+virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+			      struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i = 0;
+	int idx = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		rule_locs[idx++] = i;
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


