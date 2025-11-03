Return-Path: <netdev+bounces-235260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73DC2E56E
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79CD3A4C18
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D29313E1E;
	Mon,  3 Nov 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEUvLjnG"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4602FDC27
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210585; cv=fail; b=PAtOMhpuxucSL5QY38iPQAVJflYeWS54cvdAs88b9yzekQyWIO6Z5ehRpWFpcJl3Lizbvro+X09/2m1ggTHrd1+bI5DOb2qpum8Bqe9+p6JTP6m6O8IR5GJ4IBy2jB1yfg7hekiXiAawpoI5OqTpCR7FoV3VC4wGP1+YLxmiNQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210585; c=relaxed/simple;
	bh=ybMBDl7jDVGjFHDJiNx3RUY8a7lHF6Nfstj5F/sGqOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0ZkcYCow870eGFliNWMDnAUk9jdtfgg9UI0syMcgBK0FUd/nrh6S5kb9q9vWSHkxZVe0jCn8cgjWzKJISC9l04hb1HkaHNaTVB2OLD7nU4EtopkIN/wGOqnj8Dc4ID6/TNTd+waZtTmck/ZrkT+Z1ZSAgRMZljFN//7FDZcDtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEUvLjnG; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4JdpJeX29TkN8H/ZCn++WZbAZ2E7dkXuLKEonsTvOZuSOZ7ye1XRZfCmtYvxh6uEX62Q33y4Meh6a4LVH93ZIVra1UHYk6Lqp5Y3RqjDuOtisnEVYSjAgCwgbKgPT8pRDJ1QZuLllcPKWTilt9TN/Cb9vJbT4weZ/B/vBvtGlBDnH5NFjI5F5HPvT8KHDYoq6IEmcrwAY6I9grUUVx7aPtgLyODtYsXvWAmtFiSNq0lbU/scWTR1Vl1Url4cl21AEKI+p71hLoVPIMa6IEVheLUAM/X7d3rEu4pdw9cUYGPD8s6UPttqdVYIt51FaA8QFaM/qQq8b9BgNJ07aQj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PhbLByD1TlulzxGQsf0LcZIylfdf8iSrS6iX9M4SIs=;
 b=X0oxw0kzb7FiZrc6j1U7YnshNZmSFE5p9Sf34J2dUcgIKuDToftfD96ZDxAAsFd4hWyku6fsW7JrxfGA02pvXkk6z+dU9pfmj+BDxA2gTSmeSTRAouK7lS1cZHIJcJMBiEysjNqp2GKayDeUXe0VCN3Nxbc3i1/kJUqcM7YFoupPwsIHHLWGYTL8i3K6fauYgpkiaf+cNZLMHOv55CAZbemNfgwtNNNXIhpHJPuYTZqZRoYnn1uu8GccgNUGdphaEb4kaUtjO/nwV2yV8W9M+84Xzp10xfiKzf694/ovK6fHLiE/yBS4o1eNtmZFVHy8zC8FXCkOKUzCMSIcc9E84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PhbLByD1TlulzxGQsf0LcZIylfdf8iSrS6iX9M4SIs=;
 b=JEUvLjnGiasKXNFaqVMn+XFh0OVA1e6bIBaKpGsOhZ4mdDFlxb/FnHKstF5KnOjlXcM2Wr/DWwRXzcLtvn4bm0N1gnBXMpa44mGHcvYgjae1lx8weK68HYiIoUSZ7IP5Ig4vqJFIqi/7UhgrJmtCK3k1I7TDUgUP3SZy1uFTiOy5KUYRdKqFrb3wAftayOcT3UTtcpHsLzJcdTpuwDZbyqat5xgKzh5/A+XO3UZ+yk7K1JlMTfnfcpe4gmrfi8N2osEY9PGB/jHGDpCewKZ+rxag1c5PekV8t4X4/cobyyVYfvyZuRQS1eLtyZ6LdkolELsBFlzPFfBN1Q8UI2mi0A==
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:18 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::97) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:56:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:56:00 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:58 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 12/12] virtio_net: Add get ethtool flow rules ops
Date: Mon, 3 Nov 2025 16:55:14 -0600
Message-ID: <20251103225514.2185-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7e83ae-0efa-4a0c-8808-08de1b2c336d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aGehPrcc6SaCR2oiIphKlu5Bo8p8OIVOWd4CE0LoWTGL1bSK27ao4RT9TdPy?=
 =?us-ascii?Q?kK8i9sEzbuvNbkQwy81blD7zrN5VqwP4QYLrfgYy7WcOhFKYLRlpAiZnIkVt?=
 =?us-ascii?Q?iQfs2TbLkjnJtKQTU3JPGvekztDUd1hAVnbdxOB1/UXssyu1P5q9YwBTSaDm?=
 =?us-ascii?Q?aGue09MMOvR0/U0iAL6iYTt2ctVRrFD24MlLzhoxAwWjtmx3mS7gyG/mww7t?=
 =?us-ascii?Q?ywtrFdh5HwFsbZjurIJvRxU2OV/wtESQ5XDieLyPy6ihLVMvaYQ85rYlU4R9?=
 =?us-ascii?Q?9l+WzkRnsf+SS0Qr7wnqxwJTixOtVG8wychOQNgZIFtP/k/+nSbbBxzwpMPH?=
 =?us-ascii?Q?TjtFQoJqVugxPv8QVb6HddkHywxDXP1NxmKrIshZetF5ynbEWzfXtgT//4oX?=
 =?us-ascii?Q?dX4zg4cn3vnWXVgG998jKNd0AVHvBIGkFmHsn6rlxUnU/mlLOWlQ38TYu//l?=
 =?us-ascii?Q?Kimck+KL2QVTxd6BgrqSxCgNEv61iTaswOHyhxyu9F/buYf1XvXJ7lWlr6ZR?=
 =?us-ascii?Q?5N6+usPWFpozajFtQxaYow/sGI83p541i3zVblqv6W6ViMKRia1IQqdy0Ohf?=
 =?us-ascii?Q?v5uwen2aG1sf5Uj/EWjMJBAVARYD1XWL3t9vYT3g3ykJ+9leyJTEN4FSJE7G?=
 =?us-ascii?Q?HXS/T6uAwE0DJd7N64Uboi/ur5M/CvMjtXUT7inZwolbjxf9qm9Wi7RstUqN?=
 =?us-ascii?Q?UCT3Ikj4z+Fk2L37hNlzwXSFQSjgWjuK72nG4eExarr9CgpD8/cguv7k9DoB?=
 =?us-ascii?Q?I5AdSKDe1aol3exzDo2RIMb3st4XIHnRIMBjUhzUuo0gM+dpIPPjZD8+25zz?=
 =?us-ascii?Q?ufWnK/FswrP8m8tSWYW+EQs6SzX1+dsDO4olAd1JnXtBRsI3q2S7FIabSooQ?=
 =?us-ascii?Q?zz5xZ45YQuza1E3wL4X/h3ftD2w3h1FOimpSUTqebo6ZnCObJ6R5X9jUXJmD?=
 =?us-ascii?Q?fcStFUh7NrTqxpShYTRfCWCm6OSXtiKvCUdE9mQWD+kMamEbHDaVNFV6Nb1w?=
 =?us-ascii?Q?TLvpvbg4IJznJ7EPjOUltUzbiWwYx50GuBvNewr8OtTxDQoyJrOx/mvCPoRw?=
 =?us-ascii?Q?iY9apZ798N+R6Ec8j8zNqtdpVIzP/SKF6qkGVaiWbpItSV1OVipsKmMtnwO9?=
 =?us-ascii?Q?y2nB+RKrsYs86YTz+WZnE2TdPGJ+eSR2+NQ0uOW4IuyENL9p4Gl6MqSEOkQA?=
 =?us-ascii?Q?AV+hHOnLgUZakGNTJOSaOJ1Iee39e1awmt+NBWPiPWEpm5VpWBhTy8x8lE/t?=
 =?us-ascii?Q?jghIHbK2vEucfhCjbwrKngdWzDIgfflnrFJhR7ZmiFZ0NwLR6zxgxrb+b3gr?=
 =?us-ascii?Q?qQ2IMGIKL3j82dSTRmb1gy1H7l1RoDVISgYAhyaBgPTaytwjwRFRIMAmboc3?=
 =?us-ascii?Q?ANqw8UjTXWtAxe2ZkEURkGjPUclWR6Xbxf2gOCBMyZdtGxujhWMWZN9cV8dc?=
 =?us-ascii?Q?7Kq4A11/thwLv9DR9FEpqkFm7H0G/JyzBLSj3mxn/Xkex8mXY8OOigIqMuRJ?=
 =?us-ascii?Q?oQi+OJoKZcDe/qUsO+tfjYk886LP+idmW0UOSE/tTLgsj6a56Tp0Atg0fdmZ?=
 =?us-ascii?Q?eSsLAMSZWX77k7wqr/0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:18.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7e83ae-0efa-4a0c-8808-08de1b2c336d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Answered questions about rules_limit overflow with no changes.
---
 drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2e39d2c0004f..f3a8dcbbed11 100644
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
@@ -5650,6 +5657,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5691,6 +5720,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -7610,6 +7640,54 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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


