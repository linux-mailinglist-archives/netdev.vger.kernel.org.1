Return-Path: <netdev+bounces-247408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29548CF982F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B518230275F5
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C7322B68;
	Tue,  6 Jan 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="blq1mPa/"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60020FAA4
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718342; cv=fail; b=XQysPn3n3dm83AkR109E8NnCFqDVpgLE2SC+Xa4FxmHnl05DMy3ZGhiNz8cshS9R9D1njSXVXvviloiBf6mtw6lZqtV57G3CBWLj8rTg1JKx9GrHMw1fTHxV4K4o0sIInBHzQzexYlNsWNViijY0xj7M7aeqhx6O/BKU6Qc4xF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718342; c=relaxed/simple;
	bh=XWM1ybk62F8FPppGl4U2u4RP5qfeP3HFPVj3GR7zN7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV8Gto+WyOWqeowSkYhFpe4voJHUl3VoaUn+7J08orjBwqMr2baJ2rU6i5XureiwrzcZGHZAVH2ge8TiZm1ceaDVR4Wgq+4rgayv1LI8XLst6Mgg9zUOeoCkES4iZwgP4aP2LHPTKgwDEsW3t/u+wk9RakMBNcN6U/1md0twe3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=blq1mPa/; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2yapPfc17GaZ4gAIegEuyelHj3lzQHnXaTZDhRmN9REnro4aiuZeKwG5uhtmwv/LSgeV1UfwadNpaBAtv0/9LuzXsjYrOB1sdJIF5DbTU2C8t/q3M/rNOOVnF3Yh5UozSZWq7FiDue8G5rk+EhtOtUphhLyt1WX6UwieAVj7U9bexsBGoenseR/H9tnAoos9boO+9hxG9I00pzXBWM6BkSCMA3AKYruOO5F0JfVoCz0/dwu3xpgD37uebDasYPubpK4pvRpAz+MBBwTgPDog1FfwZJsf63elyfS29JLoKu1FyyzJU2m1iktBizEbpUvv/sxWo00WeGEpEEva3PP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htl+wzy7kkseBWI62NXDWB3Wa7uV5PSHAzDM0A7AUwA=;
 b=fkrhVxuAMWy3P5av+1/kPC01mYkfIqjoluq9lw+m/ySV2+IceeKJ6ccMDNwiZUDazrxqb/pyajaLCTcdf+hdj2HgVclS6vMlNOeHYkh7F0K5ZHz8S0J8o35LPZB8QCADHeTMCKT0wQ/Xb0nnlQIXeM+m5QdId0CTdbPMJsnNe/jgkgPm/98S4A60ISmc1PNpXqJt/ywffe1MFnTNaY2AEBkcwHtuii42HkiTejC+J5AZFiqBSvbNcadQb50P5xw0n8SpAAE+wHCcEbnuSwJYGCwkKm8xM+dpti7clfuogt14cTuBI5hZx17iJA9TMYAUJYzE4jM7OAmjq3Ib7hgcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htl+wzy7kkseBWI62NXDWB3Wa7uV5PSHAzDM0A7AUwA=;
 b=blq1mPa/il8+iAWy8NMwk3lY36vtvltdms9d54B4hDVzyntic/U6O5Ge8tG6T26jVOZQrdOknYC4GTxN+OYK6xXhIIxgeQeXFcI+9aM1o1TMklqli9OqRgmojMbm5AZWQMcPCEN1cjDvfCeMOwRhtDTItpQJFUkLvsYnkww7/rsaOee/THyaR3iU2fNyd72oWop170qHaPKQt4Zl942vQbrFr3SGrF0LgNWiNtMD1ipzSJp8Wv4fOHnsSSWL4PPVU0Q1Eam7vIAwduAtDYZPIcE8hpfIUSvcD3Mf10JSzohK+SdEnzAl8upMOL84ucFcj1z/kEx/kMtV3l6PSKJhGg==
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:52:05 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2b) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 16:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:52:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:46 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:46 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:45 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 12/12] virtio_net: Add get ethtool flow rules ops
Date: Tue, 6 Jan 2026 10:50:30 -0600
Message-ID: <20260106165030.45726-13-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae67ac2-b2fc-4a6a-9bab-08de4d43ebe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iX4C0MWyn27GD7Sk8ZGJk1w42Y45SYbHKFFs+BQ813zrU04t3HlVpOGpBAd?=
 =?us-ascii?Q?wCcjgFHq+JCBjGKPnuy5+vZj3Xxem59ViRFNQ+vg7em9/Z22swCgouGUDfBc?=
 =?us-ascii?Q?qn7wbvdomIWJaTSLvsA+AyOqcj2Dd1Ck7QZv4H0oNJVs0hlicMdcDxar6w1B?=
 =?us-ascii?Q?kDzotOwwaCyHIVM2Bm5Cj9W5ceMGP7l4TbGoxZvUCPwNANu8IgaDhuUxlq/S?=
 =?us-ascii?Q?m1Riw02xQemQpB7rGqpjLuL1MQtbiu3lf1e2Aw2puOcigGss+uiMlve5f0fi?=
 =?us-ascii?Q?8tWSI2jKlWuEuCJLnf3LcYTCPGGFZobtcOiq+AscsoY+F6Q48IdedFK2Dr9q?=
 =?us-ascii?Q?Z1EvU6Yqw6/OiUCJ0XA04kWzZIsgMlN7ckz0VKTHfHNIIXAjuuhl6EhCGWT6?=
 =?us-ascii?Q?Byu5PgS6BGUW48cDGFk73BTcdCEsjFmrAkcW6US6zwuxt/+olViyTZSfHe4J?=
 =?us-ascii?Q?HiujKHPQEyjAP7McbyW30Pc3MtF7VEvyC6m9K44y0zVqyGUhPpK/Qhd5gda1?=
 =?us-ascii?Q?8Nz42xoipAQEvkBBxYtxqMNNwyOklkFN+qoGw9FlHJpQIvGexAYJOiOuugcu?=
 =?us-ascii?Q?vRIIjieFUiSI2Rb3gzC68Zo+1wBuKsxGZ05PjhmAAR4jDRaLZ58lNE52hnfx?=
 =?us-ascii?Q?yx4jTdpoqVTlw3Cyfl87xv4ymIA8YC8ZLYk2AKBrd2ZXqRi7xmgFeRaNU1KF?=
 =?us-ascii?Q?exyMOrI6hPt0rpfrhzBQofJYWwwNu31wPM/g2RdRKO9UPToT6TIZEMaLs5yZ?=
 =?us-ascii?Q?SK25B4QVS8pNcUEbj+TUU60pG2hJA0JT2Vm6fwsoUSRrWFs6KE4BKYv8a1LL?=
 =?us-ascii?Q?EH/XCxS405Oq1iWB1m4jj6M6KfnxSfk0akUq7wapKQGcjI4KFgYCyRudwIG/?=
 =?us-ascii?Q?D0bxn5LN+IF23gCtQmkjX86piiELG22CqevedGYaxl5cQWaSDCru5T4a6jx5?=
 =?us-ascii?Q?shAtJ4I+SlFKSP2nq1jS1tecHVHVvfgpqBrea4ucKeK2fRjnFL27iGe09y2O?=
 =?us-ascii?Q?LthbtKtGBwi3hyDKDGWAixjJ6tnXDhZj/5BmD9o1TUe3BbGRzXiWEbRZYBLW?=
 =?us-ascii?Q?lsvLwtFEYWWxXf8RrcZRuOuuuOTnzeX5B5ZUoVJlgWFRXFD094aHK3kPt/G0?=
 =?us-ascii?Q?/gvmBJ8xk/fXe0E56FcRkvMYCXhE5Tl5hNys4CVi0wzAu+lDR2Uy4J/QOeva?=
 =?us-ascii?Q?t2enZ/qzePY0A6LRyPlTBUUVLPjZhdeusqcrjtXqvkRZ6SaUBrAtvA0S7Y56?=
 =?us-ascii?Q?pbgy8ztHn8a4JesdL024I8XTMYxKG27yXNaZehc551gow84BbMWO+KOjNSu9?=
 =?us-ascii?Q?UTNnX4A/ST8aqwGLtQqpwo4NFhp/y7ajIXbCDhkYIsAevcoBigofqnGML3rJ?=
 =?us-ascii?Q?jjOpgzbNoPDfHJQcHseIjMWxgRyrNQr7Vs11a/2TddBWmxvNputjfC/eAKVM?=
 =?us-ascii?Q?lLZYk2dv+K3mu8gGNo+EUP4Dy2UXm5uMmwMSMh/dynDJcUXTw55sxEJkIBaC?=
 =?us-ascii?Q?GTX2Fa8l6fw5WmaBrLPEV5DV4KW+4Nd3TXxmaBeWQjkiqQfy1mGDR2xRDPTP?=
 =?us-ascii?Q?3PFJyub38qyrHQHU5lo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:52:04.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae67ac2-b2fc-4a6a-9bab-08de4d43ebe0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

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

v12:
  - Use and set rule_cnt in virtnet_ethtool_get_all_flows. MST
  - Leave rc uninitiazed at the top of virtnet_get_rxnfc. MST
---
---
 drivers/net/virtio_net.c | 82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1b2e23716476..c43d04b3c34e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -312,6 +312,13 @@ static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
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
@@ -5680,6 +5687,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info, u32 *rule_locs)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int rc;
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
@@ -5721,6 +5750,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
@@ -6644,6 +6674,58 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
+	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
+		if (idx == info->rule_cnt)
+			return -EMSGSIZE;
+		rule_locs[idx++] = i;
+	}
+
+	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
+	info->rule_cnt = idx;
+
+	return 0;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
-- 
2.50.1


