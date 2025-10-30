Return-Path: <netdev+bounces-234311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB27C1F363
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5104734D131
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94433C507;
	Thu, 30 Oct 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UBcECIPL"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AB2D879A
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815652; cv=fail; b=ALw7/B5RiOySJEqcHnbJdxTMI0frLD7DU7yHzoKd0bbAuKyM/clKUJZ8bWOTJMGoJ27ftg0sC1LOYXfQcwuF1r4yKr/ue8PRHYzo7NjtApnri2rsBGO8cB2nTNUipHumDcPoz8u2i61J3XULPiYxYLj4lXNYA4IsnZkv3MuZRQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815652; c=relaxed/simple;
	bh=zucbdOFrNvJl+K66AELZKzP1oWgMJ7PO7PguJmHTAT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkmv62NXDs24IDSvxpj2E+0VQu17cNDqYpt3d2owdmRSK8N3hELS/giSUqEEwu6Kv6WAgE2y87TNvJXn+WlQ1qSfeR7LYrCNlfhL5mfGuD3pvCOlLUhlivNWGBxSpL0K09ofOFMghPJl/1G8d10QD88Rwhac9qXRb+6YV2d1T4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UBcECIPL; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8/lzxgVRp4No7W6DR1DUGTdcyorU7EqfXHkjuJ7zJMif8lW9bH1MCZKkdTfa9+X7BUXVAhw3kXA1cLSIZBTTBuMuLET5aHWSNEajD7h5U33b7bebayGyntfu33UHLvluExfNVK3dF8Qs0yx5jjU1duTLzURzN2TN1hPomisomaibLWcSTJjfNRviuWhGSwWW5uqA4GP4bGR8nRntwWG9Ak+OIdAjBTTEHxrk1KX5zKhSCRrnX1v2Fo6WEm0qWZo/KF/IsqW1cDspbGpReP1bc0ngxqjUD8SJGBmcBtckrY4fvaHOHrU4ojSQIs5vTOT4GUxr9/WF1lLscnF7cIXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJWkJbVYq1I0VqFSA/GY+VXIiWGgEnfmiAwv7mjzfUY=;
 b=LHblrlH0x23AxxbQr3LM9dwQ0g9Tez9CQGO7imgu21w6WOwYxjAI1qfN8glsLmagJpRFCmM6A/liLAtfOhEvGL6hEj4X4fNGXMb5zOGhS7LGKco4D6EL7TDgB/JBS42dxZTR0lxV1kSE55lnfolJvPBI5jNpvFBE2d/des0HvQYLs/RvU27oP+ETpWOHjAE57c+Ik1bOenN5YQKxpqNZJ5fP6qpeAayIl95TQNAEikarSX2avYQ6pqaQDB8sTXd8isBnp688jAWFOQTkrss4fRJy+w3IQmBmPk7oOmhU4hpNSPNk7xoeVYbHB2nt3elnacGCRUIMHmJcR1uZcynQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJWkJbVYq1I0VqFSA/GY+VXIiWGgEnfmiAwv7mjzfUY=;
 b=UBcECIPLUhj5jXVosN55mmooXa+apbOa5dnBx/+vfwbfxqTLvD5u/vX3jdFTiFU+ad85b75U+zVMz3A5/RfSDkA2gix2BUURUVx+yHhPxAl/qsBn9MZShJ6SocuWwcP6M+GwjHvH2VIqyt5SRBX7Fdb4fys48YH+W3tjJJgPUiY=
Received: from BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:14:06 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::e1) by BL1PR13CA0101.outlook.office365.com
 (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 09:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:14:06 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:14:00 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 3/5] amd-xgbe: add ethtool phy selftest
Date: Thu, 30 Oct 2025 14:43:34 +0530
Message-ID: <20251030091336.3496880-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
References: <20251030091336.3496880-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1a04f0-7a50-4ea7-8a73-08de1794ad7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6AgKHKImOIH8kjNqCt/CsFJ3HXRyfPK4ACqf5vndKJzxWkrkv6UntaA7Z1w?=
 =?us-ascii?Q?084eD7yZbx+FwtrxF7TF+vzSA83CUcIy3pC+5kh/coOk2Qhxq4imHwo6ruR4?=
 =?us-ascii?Q?9fcMZkGio+O5G4+ymzLtfofkvQk+xFv6wte1ETSTpFTyxvwvO+HRpkOB4sdL?=
 =?us-ascii?Q?iOkYLrMci2lZbmZnVDIV+WRAcalO9P+r3VB4ksX2o0Apooi+dbNUsVbZ5Zsd?=
 =?us-ascii?Q?JZW+Y/iHvX09J9mtMnwb4xNERe+rQvp/j950O9GuwxxnAi/FfnN5+mcRjJab?=
 =?us-ascii?Q?nuwh7WiB19WSnBMtyFNOyoEATmuS7957kdzYxnCN4RzX6IS703gXWMKKKAjY?=
 =?us-ascii?Q?th+xTKeCOnYzGe0xMLSBXH2fFrC3v59Lyhxz9+0f0XdpEh+b0UA+9/rGjtZ0?=
 =?us-ascii?Q?Q7JBcZRkv6beuELPxzd1nH+PaplvmRFEHJ+iYHDqQkgxsByCaeoqlO4aVW8v?=
 =?us-ascii?Q?3iK4fGZ1OfQqsDM74tztnvXPREN8Z3IfwTEQj36Od8ky0iCOPGHIYIBr2Lbj?=
 =?us-ascii?Q?1+YvWH7GAxCfS+65MPDGbsJIA5pzRkkZr7F7uUCiHZb+TwHe36AiNytFZ9PT?=
 =?us-ascii?Q?i8hcVGrfQ//TghLwNc3N5wcssOMY2ItUCcKQZ6M4XLAawwUgJle3SsM/m220?=
 =?us-ascii?Q?r10hzKfZD1mtBLE4uxl1yUVyYNcEEyrbT2ISY9CJzwcPNHYKM0OYcFWYqbkP?=
 =?us-ascii?Q?oFefKDXb4IdBTpZ+8tKVfdX5wPF/QazwcVKsO0JTmVqWuIX16wBXiCBQH7wv?=
 =?us-ascii?Q?raAt7CWYeWsXBQmVM9zWoWeDGxO4/UERBKrAmKKLwfqSquYzBV4iGAG09GqR?=
 =?us-ascii?Q?1jfW7hZd54zRC8wKEZ50A1osrhJp0QSgdL+C5Jytnc40j206CF7x9nDQvYj7?=
 =?us-ascii?Q?wdodKkJez9gL4XWv0nvSuTCqC4RhL3OAW3m20NkcaGygFQfEfe6D4L6u36xY?=
 =?us-ascii?Q?k1d0U+d8oj7dG3rZ7U2aGi9QpVaGGZrLzvW+ZfGN/q7PJhFGZfJS5ei48jBc?=
 =?us-ascii?Q?qmn3Qjv/oC5zBGu91ilC0yhC0wM/yXaCUK93qlO41UyJAYWGSbnoRvYvTnK9?=
 =?us-ascii?Q?wf8bGLZu+l7+tbadJ2cK7CmBvGmza7o9wK2UkI0UE4hnU4H7LMaZV3pn56EE?=
 =?us-ascii?Q?LI6Zz6WZjt3llpmENvo1lv46QumncUkxfbEjRX5u5ZPeOrRbqSKgvQWFennF?=
 =?us-ascii?Q?BgW9zIb0Nh+QUtHAT0SkDDjW7QuKgq+fJRNJBVH7etEtxyNm76bHguWojKdV?=
 =?us-ascii?Q?c1KT6ZJuHbhbDR4PFlR/IBFBVm9qQjNDnJXYBb+mQ0trDcYtt6n3OHqjTAPt?=
 =?us-ascii?Q?XQZLavISWMo9q3hkqEFKTx9vyfuLnfsL/ZWXnlC+yIBPwotmS8mwjLu93zsC?=
 =?us-ascii?Q?iQJQU7KWd4Ou3fSFltFbxzoT3GFIzYCgMkRImC1n0krgrM9e6dyVndqRZlqL?=
 =?us-ascii?Q?E5Qvq2eem+gXUDz5q1UZAAWvjfdwuSwfHjmma5FSZwb3p7B3rCfsb4MG1Q3J?=
 =?us-ascii?Q?n5Y86xqWDt9R2DoxIVd3xwkZ6DqQco+P01WCTfIJWnfYcOGkYOWctu1S8hGy?=
 =?us-ascii?Q?pjk6NJ3qbLzsYiSMO1M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:14:06.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a04f0-7a50-4ea7-8a73-08de1794ad7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

Adds support for ethtool PHY loopback selftest. It uses
genphy_loopback function, which use BMCR loopback bit to
enable or disable loopback.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
 - fix build warnings for alpha arch

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 2e9c8f5a68ca..dd397790ec0a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -19,6 +19,7 @@
 
 #define XGBE_LOOPBACK_NONE	0
 #define XGBE_LOOPBACK_MAC	1
+#define XGBE_LOOPBACK_PHY	2
 
 struct xgbe_test {
 	char name[ETH_GSTRING_LEN];
@@ -151,11 +152,36 @@ static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 	return __xgbe_test_loopback(pdata, &attr);
 }
 
+static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int ret;
+
+	if (!pdata->netdev->phydev) {
+		netdev_err(pdata->netdev, "phydev not found: cannot start PHY loopback test\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = phy_loopback(pdata->netdev->phydev, true, 0);
+	if (ret)
+		return ret;
+
+	attr.dst = pdata->netdev->dev_addr;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	phy_loopback(pdata->netdev->phydev, false, 0);
+	return ret;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
 		.lb = XGBE_LOOPBACK_MAC,
 		.fn = xgbe_test_mac_loopback,
+	}, {
+		.name = "PHY Loopback   ",
+		.lb = XGBE_LOOPBACK_NONE,
+		.fn = xgbe_test_phy_loopback,
 	},
 };
 
@@ -187,6 +213,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		ret = 0;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, true, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			ret = xgbe_enable_mac_loopback(pdata);
 			break;
@@ -213,6 +246,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		buf[i] = ret;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, false, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			xgbe_disable_mac_loopback(pdata);
 			break;
-- 
2.34.1


