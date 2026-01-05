Return-Path: <netdev+bounces-246969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B009ECF2F44
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23A623002D0D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E9313E17;
	Mon,  5 Jan 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Toc/DSmg"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183F2BEFEF
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608413; cv=fail; b=FVi4BDXsRtDVAdht2ZA1YSUQDdsAJEaRDqajAqPNIBKsVKwBwiyb7W8ZonSavP7vsrjji9pLUbJTzpJKdthAbnLC873D9tmaL8iXT9DrYWX71wD48/4V7KRu10yP5pDzroCdha7e4LEwlRIgYuM6ixidncPmywLP2qS5deVHM/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608413; c=relaxed/simple;
	bh=+Y+zr3Po/KBTYxwC0IfqxSSbU6B8NVzBi6Y2nDwluLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rk8bvhD2nbU5Xv3o8VV+IIJznvI+JdyeeR4+fGaXCCZkdcpHxjRdBLtc+HD/LCAY2nH+UnOFgoqHtdDp5gUYrqHZI4BHHBm1s/3grcZDf+uLzwJsWCAskc9kF4LXcg1SMVOyrGpshLFeLmSBuHgHd5lNre1eNmbJVr8DWwrXfjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Toc/DSmg; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk9OZFNTiMBdY6fdr5EqKNnnzpKIjn/to3XVkmohN0TUnNVOHLAKmtznSwnV+7aXtgnkUnXpn3OnIl+I3x0rYTrcy2vjReDvvbP2V94S6P/aMYo7Ut+O8ecf8ecL0XC5ammKJYA6dmarPGR9pCWKr1PgEpRc/XaDcxeE/uJxM2vWSCwc6+/07m7J0GT5+T8UZ5eKInz0jtyPUm6YUgamBDDoYvA/AXuxw8T0o2nrno/CZb1tAFynNt8uLBN2m5nLbwm3bW/8ijoRGXgiXYOlnemzlrOi1xc5Qw7pnKubcLV1dY9/Fnmv4ShInWN4yNUyEpvp0e9X82dR61nFx8hl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKOk59rIP4FQ8/UOLnZak/QWOOyTJLsq7g0LDEYbDwc=;
 b=HwnbRf3GaEZQw4eOMu7j7ivfMMpZ+bCkJkI+27fJL+BDXRAnupvMgZKEzbHdGQh8VGhifc9emrkkmczwr3z07051PCD2tOZTvi0BPeye2XLfsN7vVxLzIONSwWvO/p3tX+8gwnh7Tp7SgFncE1vpYOe5NAlO9laCs7rHhN5iwv24SB4DBfNGm6izoqxLv4ilvEIdw3cJYN03oAppsoWHwZBlekB9wVANjoUqMdt43YIxyR5k+uOLadaB11P+1N4oUgjWbsCcUgJnopMrHKNFq4ZMjKUdJDJR4h0PDreYVmQrhb+n4ay23XVfk1nHLmkBUDVSU85UU+Gt+YPSuei8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKOk59rIP4FQ8/UOLnZak/QWOOyTJLsq7g0LDEYbDwc=;
 b=Toc/DSmg1I5fy4GlLNeTXc/+zwuMdt5Mx0Jl0+NHN4vHFV4Lo88yeesPq6S78HRKazfdhg64R3osAPLqD7iybP5ZOQMfoKo/4eYP5oUXNRoDtFOkiyvhYDzNRBpgbmC8Gq2/7kEtjnxFtz8U6SVr6caGtXi6OncXcOn2lXJcyv5zKJpfF8RFdbDtuIYQd0N3S5mNUrC2AXuwfcJ5RMHNqBG9Aqnn9tIzmN33SbW2hR46TOiL9/yXjfOKidMP0fAWU+bKg/Kp4iOvrQslry+vHCwqfHdh1V70LMU0KRQp09FEeuAS2HCOXZf8NGV65gbC5prLWogUoC1fuxrevx14qA==
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:20:06 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::a2) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 10:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 10:20:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 02:19:59 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 5 Jan 2026 02:19:56 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next] macsec: Support VLAN-filtering lower devices
Date: Mon, 5 Jan 2026 12:18:58 +0200
Message-ID: <20260105101858.2627743-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9aee41-b4b7-4f6c-cafa-08de4c43ff3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Py9jQx/GIvBjmohD5uEmlGhXP5jVjz+ktHkL017o4Kpy8rP3P+7x/8j2mQGo?=
 =?us-ascii?Q?+VvJySAZYLx9YTkQehqP4x2g6Wd2gzpfqdK+DWjHUSecURA7LOxwEnte6oHK?=
 =?us-ascii?Q?CJbtNyUXcSSPqDxSJXmaCwdvMiY+d1EHesoa3YokXujkmXHLKYjB4JXVVqqY?=
 =?us-ascii?Q?8QTiOYfthyABhwCxljZRxwNMDT3zDaxKuVPkOgRneUAsD00Q9cdye/JciStY?=
 =?us-ascii?Q?G3BM4wb+PbyRIzUqzeZksnd63QSF6M2SkH1Zd16xZ8svA8ppQbzQm8q8gGDt?=
 =?us-ascii?Q?H5RY0XuqN85E+9tXw3eZTxetCwaE6d9OEpHDuiMw18Si7Gz4FsVu5exy1Kn4?=
 =?us-ascii?Q?fejMn05bCQgFH+qGvLwuP07L/Axn97YSHW7AZtSbFqCmMGnLw1NCJ0m5w9X6?=
 =?us-ascii?Q?kNrJ6aqjo2crmOcEu4nfLVv99/dgRmHXIx00SMVqnbA/ZfNvmSQj3eSPREwH?=
 =?us-ascii?Q?Oi+3tY47rHPvRSLcjTx/lVxUGpHAqtn6NDpAQVbZp0Kr9tKysVI9y6mVU/st?=
 =?us-ascii?Q?mq3yAmodTLJJEGaVVYL/KF0f+oeWluRYAggKzW52lx+uJC4T02WGjtXx/mg5?=
 =?us-ascii?Q?ymP7le4DEgID5dQLbW76R4E9a1f7mxYoiKeJfX1fxRaVvrhVwL0d5uwzldpM?=
 =?us-ascii?Q?7iHplA3xq43JcXsIpXq9CtM5pxaP71JFymVO9UUGMnH5HA2J5ypo49kD88OR?=
 =?us-ascii?Q?0bTBqBhjBQ+GxrpzJ2NLU34W2MdTiwV4gOg2i+N+9PIkZRo0bNTcDYNSSONg?=
 =?us-ascii?Q?o1Vf0l6sjXeFO10TCUoqLrdeM0Q8ORQZ5kHuH2m8b9jeW2KFxMpVXRBg92CW?=
 =?us-ascii?Q?4I0Ef9fhejZ0hymvjRLoUTlzqIxt2m3cJQ3Y9M/kLwMbXnIiltCZplujQ/Az?=
 =?us-ascii?Q?Xo6kXUdfRbreEp7vd0Zus6ljfz4RqUlgFZiU8HX7ISnQOowH7ZStssU5q6L9?=
 =?us-ascii?Q?LlvV0K8OzGruzGYKTKwq7Ac+TdEx/gNG5txRhC2Y8k+90vpwUsER8YUIFuxb?=
 =?us-ascii?Q?vKJiGtgf0p92bcT3T8vmrsDy04Mw+Veiz356X70OOJ5pX38/CEO3Si92OsTK?=
 =?us-ascii?Q?DwQLVHfTI4iYyO1sV+2tpwm/aONnfx7gq1Bmbpo2ReBYSCXRqu8DGYx3M6D2?=
 =?us-ascii?Q?+01qwhD5vuABVxG8yAdcunOFk20G1BOaxrHOXH9M9ZOMBPECyWkMSNW/+iKi?=
 =?us-ascii?Q?2i3pSNTctltk714S3GXrM03yGMNHgVt7PGfwbtQVp/nWIUcT92tcniv53VT1?=
 =?us-ascii?Q?U7njk7/Hi8sQS4a4azHDSIfyQg7SAe8pquIzY8D32v3MNCBBGASOxQ4URlgv?=
 =?us-ascii?Q?xX9AvoQjZkZLE4hjsWL5oow/fUNnq8vud+1ZYtw0wfGx86tAO1DHUK36WluH?=
 =?us-ascii?Q?1jt4bnr1ieVma2GUD6GjdQS3BRUPbfo049j/8bTZZGwZGDeJSgDbwrgbsAtD?=
 =?us-ascii?Q?BZ3t3rnyNurNb7nHiJQ+BQR64ntjKFG1DsHGeLETJpAAyQn6yPzNCshcoQH+?=
 =?us-ascii?Q?VjWIrYtkzVivrBXUN1HZ27QuX0Iod/SXfKPv25gB/3bYP/XwymDtlZyORLmf?=
 =?us-ascii?Q?TAV+oHPXaw1UBxM7FGU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:20:06.0517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9aee41-b4b7-4f6c-cafa-08de4c43ff3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of macsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before commit [1] this used to accidentally work because the macsec
device (and thus the lower device) was put in promiscuous mode and the
VLAN filter was not used. But after commit [1] correctly made the macsec
driver expose the IFF_UNICAST_FLT flag, promiscuous mode was no longer
used and VLAN filters on dev 1 kicked in. Without support in dev 2 for
propagating VLAN filters down, the register_vlan_dev -> vlan_vid_add ->
__vlan_vid_add -> vlan_add_rx_filter_info call from dev 3 is silently
eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

[1] commit 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/macsec.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5200fd5a10e5..bdb9b33970a6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3486,7 +3486,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3708,23 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	return err;
 }
 
+static int macsec_vlan_rx_add_vid(struct net_device *dev,
+				  __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	return vlan_vid_add(macsec->real_dev, proto, vid);
+}
+
+static int macsec_vlan_rx_kill_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	vlan_vid_del(macsec->real_dev, proto, vid);
+	return 0;
+}
+
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -3748,6 +3766,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
-- 
2.45.0


