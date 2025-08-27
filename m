Return-Path: <netdev+bounces-217417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE4B389C8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D6C7C504F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171142ED858;
	Wed, 27 Aug 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhcrqYEV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BD301498
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319981; cv=fail; b=C1fBx200XAHM17L6N1ucxrN4JgkmlVFgAOa+Wzo9qmktZsWlOi4QGlZFn/qps4GeraKtqY5ZrCfVy8qVJY3/1Bi9ujUVnxIZmtVS+smSYDoejYOAVZB0BKXD9zQfkTLj8VJOZ5NbfErc8VP26mrSUbUtDpf8YhWB/HKRi+i2/Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319981; c=relaxed/simple;
	bh=4lIgSt/i7TV+M0Mo93ApN1MrBo3OzDL75ocf0WwemPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPMaRIuO5yVIEQ4HriAAjnexmERouR0wwkozwPExtyfsHC8bGfIdiMlAkCEcsFCwbNDnFMDmp/IgVX+huwYAbIxlNhLz9Fd+lXuxKTfcrIWXUgSCXb3W6x1XsNp6ADy927tEeeZ0LP3evPg7uosaSYcqVq6r1Kxa9fD+LVpoV9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhcrqYEV; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilMSZ8/p54nK/qneD9yqAPXgrVRcq47taQ4ljS442qxvx4oYcI4vRm+ATrS7dh685d+TarHmNA0yACPXulwbkNKyCDM6s/QRYXTTUNbUCTOzHWOm/+/Spq2UvYN7g1ec+PB7dYckZ4AnW5x7jsxDH5YyTlFuGpfTyisyriXSoom4HPNGW2fpN1W1b9CtZ7DaWonniu97tM5y6WF9LgEEudFMPdGh8zZF06K5ULIrdHSn7rVBZAO0Uj4EQRSRyNhmDHiLsSEgD1H2zdgzH5778uNsllAQWTX9H+gE1BDSonH+G8POGU7oO+qzUEPaJH24vS/NB1bB3w2J3E/Wkom0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxL/h8UxNKLfgSxl4AGYYQpId2xWmROF+4avtZRpbA8=;
 b=P9yt8vBsbRfyOY8HFKHkRuxHYhEUpD7bN2WpvkALGKdEgjIPdAqFF4esNOS52zOGw91h9yFq2YTp9zRpUY5Z0XcatZ52buIUXyWChNFbGKIqY1vcyO0BPAPXFwobSOB7YUL7CYgznMIHpBWpiqlcMhmZ81ofKk/3KkIgHcXG1y0l8tOr2vWAbiumoBsS3CC49jD+PpcfcaaFrTTu2Hk19wGpERNwpJTzxBqDNpebhxWvAljylL8VTVLsjGYn7cyJXFvypQl92Mm/mwhv1AXn4m/W/EgVgtpLY5CvPnihlrydWkvoqqlBz8REzJ4hqXwS8xE3+upHrC+PRug9TxpBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxL/h8UxNKLfgSxl4AGYYQpId2xWmROF+4avtZRpbA8=;
 b=LhcrqYEV6MGl2zz3RfWI5mUwRRkjdL5Rm1ZE0oah8C41yzmLu7uuInnEDXf2PXwjkZnv1UuO3R2r+toe75HeUTHVllDbBusucTE0urFRFKz3j4pDBGzg6WMezdbvvNrx3VfT8vP14mni5Yi183ZADqedinnXr32O6fwGgorhMwOdpO4qacoCv1VY21wSb5rtnrMp5g51cXFCL16/jzJP+3j4/2X7e2IrIxEQnWNBKLj1lU5olN+zOdgvsL9l74SPKAbK4noVMBgI/eqAt3vaazy3K80+H9T1GKZTiAeIsD4n12d6OdoqoO/yfpzpf2MIRy9zjE1dMyi9hexQ2Nw06w==
Received: from MN2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:d4::21)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 18:39:34 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::b2) by MN2PR04CA0008.outlook.office365.com
 (2603:10b6:208:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 18:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:13 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 11/11] virtio_net: Add get ethtool flow rules ops
Date: Wed, 27 Aug 2025 13:38:52 -0500
Message-ID: <20250827183852.2471-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 425db479-4d8c-4c9e-f93f-08dde59911b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUKUzmdLjJvCQmH6UEkLNUHldWgNWbiOlk6mLm3WARILXjlnkZHGpaRcflDG?=
 =?us-ascii?Q?Va7naez28Xaoypy6NMy+8vaI1dBjMcu1Q5MTt3C/a6+YgeETg3XxuKfUUN3U?=
 =?us-ascii?Q?C3zIkCWKfR2rSPH485tNCdCxBkFJskSYaQymfq1+HWoIrbks3NRLbVyNdtse?=
 =?us-ascii?Q?EeS+N1rXnpdSZHRHQOIxJ063j2UVnHWlfcsQ2mNEF/EVGWbZwcSTFtsNR2nn?=
 =?us-ascii?Q?Nt+AhtY99dcrKE173gqw3wyQFxHDczluIVs3NhK/E244JjQu0FBOTBjMpZOb?=
 =?us-ascii?Q?YgBnsSFrqgb1JfucgOevw7Mi46SFOu4lc8Al7QXLh8Y5qU2svfybscn7QzGM?=
 =?us-ascii?Q?7QtNbey50iu/5SY6zyrc0NM//uxgfnF+9J8qiimlXC1a4gC2IGtF9DVmpqpY?=
 =?us-ascii?Q?SNEBH2Y/M6c8WeBi+3p6bSWTYZlli4C8NvyKOpvcKIoyQq0eSnDeBilX7M3S?=
 =?us-ascii?Q?bWwnbfWp1uwrnofifhMmWpVASzo/cZxaUow0/H23zrmyijGLVtZyCjLCCGwr?=
 =?us-ascii?Q?hLB8Mc1sGEwBP4gh1Af8hLbUJ9EUgJ+SyTQVAm4acHX+ETZEKc4cIeIGR/mc?=
 =?us-ascii?Q?t8EaqatIQezPoBvf5qPeuCmz6xbCMzGGK7Z7VTAklDn6KiIPr0TzCOKjTxDE?=
 =?us-ascii?Q?sMhhqjJwbXIZTrcB5n9d3xp1oTijWAdTaL9OyH0tOqlFq9a8tlB8CQJujg76?=
 =?us-ascii?Q?+IUXUNRdlFKoEh/o1BMkPPfB46QbLH+duJElFUowFtRL2rzPNKR+7iGHwIVk?=
 =?us-ascii?Q?XV9rP/pcDUZzTSva5Q9dhgIFlY7vHNOv03UbsH2+KtoLSDSecaFa+ydznYP9?=
 =?us-ascii?Q?OUWqt59/7Kf9GOTNRJQjooP3JKUu1aibJT1Rwt/InigGl5/SwQriPsZgn0Ms?=
 =?us-ascii?Q?DNXPIgZf88DQffG69GlpZlGsOS/03URKYEBe9UrO0aIMDZ64ySv83WtVO605?=
 =?us-ascii?Q?1pOeYV2hvy097voox5+h91PVMa94aN18eiurYlZcdMcoYJuek76XMtaqiYST?=
 =?us-ascii?Q?pJPYjVDujZt9lVkOGkod3D/AT/wb9IswDgTibuYMwG/kqCue7JvZ9/ceeUep?=
 =?us-ascii?Q?ezyYd1YCQ5v+76PbAmxTHx3jgJrOhPXDX5agjQkea0tqDePqtnNmhYWTg22s?=
 =?us-ascii?Q?BHs+h2TBCjUeXqxtJ8I2lxDhx7mzYDY/bmeRMbhmJv6TV7OCrK0V2qk12Vx1?=
 =?us-ascii?Q?DG2669OWffr6FIXIl+OvJ3Ct00kJPyu5gjHz870apK1ilCvIAO65Mfp/Zp+2?=
 =?us-ascii?Q?bzxphxXboD+dI3teQbcZCaeK4YaIz0f2iuUFgRuLGaymJMHgGPZD4JoJ8RGf?=
 =?us-ascii?Q?EFc8t5VmKAkUzjZVWrIzja0h375Y2qkP4px0WKRPY41LnIORO+4oH5pbRKAp?=
 =?us-ascii?Q?iFAD8djXJBG8wLB1yGfPqmSqUuwwpZXCh4QkWCEX6tNTimyatCp/6p1Uor3L?=
 =?us-ascii?Q?YztcTVK28JvjLD32Vpyy870zXgAKRUMrAxFQmToO19QWlRTTVqw59PrGgUNp?=
 =?us-ascii?Q?QcasF4H6hwgPI9xwhaLml6ilBxJT6zH8mEfS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:34.4371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425db479-4d8c-4c9e-f93f-08dde59911b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

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
 drivers/net/virtio_net/virtio_net_main.c |  9 +++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index a1f5c913bf08..2a76de5f7f32 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -807,6 +807,54 @@ int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
index 14ee26fc9ef3..63bf5fdc084f 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -5619,6 +5619,15 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	int rc = 0;
 
 	switch (info->cmd) {
+	case ETHTOOL_GRXCLSRLCNT:
+		rc = virtnet_ethtool_get_flow_count(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		rc = virtnet_ethtool_get_flow(&vi->ff, info);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		rc = virtnet_ethtool_get_all_flows(&vi->ff, info, rule_locs);
+		break;
 	case ETHTOOL_GRXRINGS:
 		info->data = vi->curr_queue_pairs;
 		break;
-- 
2.50.1


