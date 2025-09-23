Return-Path: <netdev+bounces-225641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9914AB96339
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFFB2E836E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552125B31B;
	Tue, 23 Sep 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmzNdUn1"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B0259C83
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637211; cv=fail; b=g/TFN1SscNZp/5rCC7kjcj0cWfmwybAT/Ulg+UYEbtgeTo+8kQOU+5eIPEEGU0E63U4NiWo5vafivj3IE3LWBdIh2lK4NBf40kWFky7ghKnMqLVakcjJ3IXAf8j+5D/1nu0KMcnJAEVRoQMbO3C3vFj2CukwlnCyBCeD07tzyXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637211; c=relaxed/simple;
	bh=gwYvwZLrDd22VxcLfjbkIbOYlxwPSzO9Fwh8vS4lo24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/muGfocgLm1lj8gvtXAttu4TlD/N63jcUWsvCND071GCgSrjBQKQJ58SBs/Ptxng8GWT1LBmZ9Mn5eB7I94+7pxu7o9RTO6VBT7PNZnzlz2i2SkhuoPLSa9pezXz0wt/3Vb91T6chxDMzBCOVJofytFWlQy7jliv6+XjgZ0Noo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmzNdUn1; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTCF0YWNBmyrwSZq2QhiYFPcs4Hh7Z9F/D0oHdYAGM1zWZ3kMYV9QlMI1+94Ij7ZWCtuswZ4oc+LErI7ePt8asEH9AEnuhYj0QYHSpz90JMBv6s76/AAiQKP7wZkwzALqVUmgiNsWQ47bQvtca+Bq9Sl1R1dLYVUOQ7nw+VFFv5LuSa86A86Inte2WhK3nI+hfu3yOTDBI2wpHo14ZT9NxeUfkVdfZgDvEtfKNwsGaLndSbVsWkbbzcibc5liYPrjeCtMZgoepF9/My0f4kZoLDcKOFjSppSNcWFUmmAnxYu07IDvq+xBLTBCyQ6DnoaaO580ZR3YNyzTdQVMCl6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L+vCss/+i9y7Hy+CJHmQ+mTMjNwbIDERoz26T6P+Xs=;
 b=GeQQGvOgwi8eqRIiZ4pspM0hPUYZ1gZTpfXipfbQQd6GyrpCG+6PpsB1sXYHi50x11Uu3DiHltiyIhUu3eeUcd0qW/DNtiZ/cDqNXos1VEsSkCsDmlabuftb1nvenJ9S8eoIILWe220W25kgR1LxAJrt9fWIYaK532sLndexIWQc0FplLSXkIt2Kl/va5UEBvHeAgBX4BhzyDocOvoy0sbLMYB9U96NsrZBVlZs+YQtyFIkK63r9x4dHna8eiLaMFVhfr6joWDFCou4xiOTktfYIGpg4RlWTLCalHhaRDU9X6wBV/HYFUlLrbHkz6NtOC7B9MgbPwVRdKApA9NBjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L+vCss/+i9y7Hy+CJHmQ+mTMjNwbIDERoz26T6P+Xs=;
 b=mmzNdUn1kWM39tNOwywyXYzyxrQ5WJK+inqG9+PAjhrw9AjBRVl8fhQhMR+T42AKnA5INQ3a5U31KqPBmAXPBP8bks0U3spsb//9Bg+A7bOOR5rHRdeS+M9wntclx6Bm13Se7fJ5lF7mPwtUP/MH9wZAQno/C6c4aRY8BMcn9BLVI7u4C+woS3/yZubRteil1Nx1cOAXxll6/iuxFvmW5r7Yb7V2wkxfOALib59b8SCK5PpVXxTITi8Q5eIwlonspOyZSGZurYZmAjNil2EdlfaDVrkfA2SSYO98KJEMgVbfx1HWq8NKqyENb2jxcANbTq4pUSgAyouRATx5IqX1sA==
Received: from MW4PR03CA0264.namprd03.prod.outlook.com (2603:10b6:303:b4::29)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 14:20:06 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::1e) by MW4PR03CA0264.outlook.office365.com
 (2603:10b6:303:b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 14:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:20:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:51 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:49 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 11/11] virtio_net: Add get ethtool flow rules ops
Date: Tue, 23 Sep 2025 09:19:20 -0500
Message-ID: <20250923141920.283862-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 292996d7-f05c-4d5e-9de4-08ddfaac4af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uRq2LfeQMHr5mKoJ+mmmKdKalurT/iqhkaR+pX/bHl8PBTamkLEjqPbvYhVx?=
 =?us-ascii?Q?th3E+9Hlnf2u9YmzXXx0oM+UzejuKFtt9xQlYvQ7ee1H5I5PF+CYKY1FjHH7?=
 =?us-ascii?Q?ScEHRre9liLG/4Mu0Ko8tQuMPf2r6n8nqVPFQk0Tp0r9TLQ85wSfwMPrNrNG?=
 =?us-ascii?Q?NqBrZl5JEb8cPbvYT/yeX5oMWU9csfBBIqCNod/sSUJ5Kk3WL3h2R+ghwzO3?=
 =?us-ascii?Q?Eo13FAvtE3L5paN6r9ZHDTv+8phy4KmbWje1aqolXrQ+6ET7J5wjxAJIhG85?=
 =?us-ascii?Q?slGhhuyosRiGEUHH9xLXHv2mS8h7Qy/o0hxPMZAUoLR5r75qrv4NmtPMFl3C?=
 =?us-ascii?Q?J7Gk38H+zRw4cP1VdFZkqj9zETIyofglri67OV1QTENrYUilx5WcnBHzhEAp?=
 =?us-ascii?Q?TtikGj1NcPy/mXe1tHIIwymKSaP7yZ7060BZPaL3d0yHzCuMLX9mJ1OlemkT?=
 =?us-ascii?Q?de3aH9VefqZ6c8ztJmLaXIxwXNeAdZK5Le/R7PtALmOTqmXKNJj7M0pHKgAS?=
 =?us-ascii?Q?Sz3NVKc067ITACOWWU4mWRtEejxZeYY2ZCuIiXAY1A8RtFmwZTrCAPunXAUd?=
 =?us-ascii?Q?A6Tmdntml6/VeFmFv0QRoSsLYNbKqgeoaF0Eo1cd/aJIHEgHgZGE6LkNo0x+?=
 =?us-ascii?Q?BVE2eSP7LauJVguGba5ok78Nqt0VJ2nKMn1zLlu5rPNU4mG7saq6sDvo7LiC?=
 =?us-ascii?Q?tzr69/r5YxpnhvQ5ZhJe2MNz2f8BeLNK0hkTnLpfG3kvo04ufIcdfYpWkt5v?=
 =?us-ascii?Q?nk/3i5obQPlpgw6qyiI3kqA+ZhyVsuSIVfwOq1dOCKyXRZIBLc/7I9GDwwaf?=
 =?us-ascii?Q?qfq0LOj9ybFeJNqijSy8tqRxxj0aC2PjMSsAtDE2OwFx3KJEmcpCElAfmBK/?=
 =?us-ascii?Q?VGWFKwJmr1W5qQhMjIWreC9PT1uyeqdBcKMKjDVJXNXMUEo2Wn3aV9W5CpIQ?=
 =?us-ascii?Q?h6YBQj4gVhh0396LLiYVyHUnE0LKPpRavW/qqgTx2OtMgdkt1102HSKAkMo8?=
 =?us-ascii?Q?9oI78FJumddZeJU+tZWjZJGv1ulo/4T0uqXi7JKOmkIXyS+OBR7DYqO8mTZJ?=
 =?us-ascii?Q?63yRSdggNMK1w8WWbmj4q4XHa6z+arr0tlLZee8ioB76oDpIPkXTibqg38xp?=
 =?us-ascii?Q?44ceWj8IiJuwo9ugYW1b2aKho9abJyW5L1wc8zyF3XQ2z2NPEky/R0C8eHt4?=
 =?us-ascii?Q?sdvl+G2BZQ2iInVXvCXzP7jz7lnAMnerWC7Y0m+uPRa3U2yCx8rH8/Cji80w?=
 =?us-ascii?Q?J9V5s0m8pgKWwtQN07d8MqiUcjlnPSdQqeZsh3TnTmrICC26OaLo8CDupCZp?=
 =?us-ascii?Q?dwoZSkY/nkJCrXKSvADfpPSg9ZlxaD7AWHWjPt9jkeM9yZNRxGIaSEybNaz0?=
 =?us-ascii?Q?3wVaRSttawjskVKfn8OWZ7+4PbrZIjTqincCLni6g13kM0KLPsIHm2VBDAre?=
 =?us-ascii?Q?5zS1ZK9dkgPesBQvjg+ME8VdGn/qKqrWJQA+LzoQ24Gr2v3PkrsNQ96du81C?=
 =?us-ascii?Q?66pdX4ihvPMIkt54x/cDe5IjijKe8IuIjFdd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:20:05.5441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292996d7-f05c-4d5e-9de4-08ddfaac4af8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066

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
 drivers/net/virtio_net/virtio_net_ff.c   | 48 ++++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  6 +++
 drivers/net/virtio_net/virtio_net_main.c | 23 ++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index d4a34958cc42..5488300a4fc3 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -809,6 +809,54 @@ int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
 	return err;
 }
 
+int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+				   struct ethtool_rxnfc *info)
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
+int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+			     struct ethtool_rxnfc *info)
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
+int
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
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
index 94b575fbd9ed..4bb41e64cc59 100644
--- a/drivers/net/virtio_net/virtio_net_ff.h
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -28,6 +28,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff);
 
+int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
+				   struct ethtool_rxnfc *info);
+int virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
+				  struct ethtool_rxnfc *info, u32 *rule_locs);
+int virtnet_ethtool_get_flow(struct virtnet_ff *ff,
+			     struct ethtool_rxnfc *info);
 int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
 				struct ethtool_rx_flow_spec *fs,
 				u16 curr_queue_pairs);
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index 808988cdf265..e8336925c912 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -5619,6 +5619,28 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
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
@@ -5660,6 +5682,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.get_rxnfc = virtnet_get_rxnfc,
 	.set_rxnfc = virtnet_set_rxnfc,
 };
 
-- 
2.45.0


