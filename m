Return-Path: <netdev+bounces-164702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867EA2EC57
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596E91889BCE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14521C9E0;
	Mon, 10 Feb 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCUzSCpy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89D1F3BBB
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189460; cv=fail; b=dzos7+dRdv7/RdYz0uLZPIMcp+0TX8ekocyKB5NOsb4phDKsBQF7IsomxmG5Zbo7FFK7qIngA77RT/gB8Tbwwt1528MsAdsfHEGdtFe8ig5POCdYkyBHXBPwld3S4jf37RvflziIb/WjprcjYbpNwyE820A6skldaXr84fbT++k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189460; c=relaxed/simple;
	bh=8knlF2NJbpDDSMQgBAM9j3P+rOM3DGNBobWcb8/eoSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lQT2Fz/0sctktDl+XL6kb2Fr1sklP0ljh4Xq8/TqNqS8ftbhGD3bsuNXmOJnAtieeKJ1ff8+dO7YIaf0BbpleKhb1Qruna2M+iHFrKIxrwgC+/9UHZrZqd7fj5jcXrZHenYSp2kfm8aDskVzCYIasmFEQEoVurGyieslgC8wMr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCUzSCpy; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5vUUgiD2lDlOqsjff8zgguM1Dm8J2cCWbXr7kl3B1/2fufllGFCeSTWnYO3Bc/2APFd0Fs8JM+6yn6o8gs+Le90jMnRYjMPe38yFc+hgNvEfn7hnjgS/jXGxL01atfqnz37S2k9Xzq1IkA+dTPA0TkrZeZ/Okt6NIVmsnz91+I5G2pJim+W3DRvguoaPCsaLiP8YY336awr0jCYM1qZfqlg8Ji6oVdcWEVqFcDwSvCI8ukJKoMB/Di7R1uKJnZg5FT/gi/MaSuOJ4C8jfOpVepQEt3Ce/RFlXjO61LfNv8bzU6X43L0Z7wyWeEmKNhAN/333so4ZYrzylL8MFlqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHo1sbFKzCa2AtynHGuYQfsyRfOx0odJlCcDg+JUjKg=;
 b=uOvcR32amrlFRphpdCtFlIYDkEodzCYZt3cYRXeqmEIxo/hncRAtKr/hb2YmvCb91W/Bt8b2DLjnbUP9/QVSTkzk/rpZXxcUHd3WiziY3gY8pIY4jQTScBdEd/EcfD02s5/Benf1ZUXPwI8Iz9fF9z3TFac4Srs2j9UW4Bgzh5MAEo3jbsR1iyzMBxfikgGqTPCAPc/BkXeF+D26F6L/j/VGWQcEWnQDrDxHfiNgXHNL+7YGd8jkqkul949zIp+0nAApYcLEMqzhWLcwHbzrpuLxltBM2Ix+io12SUD4ZzrFRxg46GNK1eLsIV/nTwbsiU1uSu7dyiqhp621cX24iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHo1sbFKzCa2AtynHGuYQfsyRfOx0odJlCcDg+JUjKg=;
 b=CCUzSCpyOhG8jdUl2UHcxm2NUH9cbr1Av64h48DwAKLzVZY7oj3Mf3Jd2y2Q4Weh5KhLiO+CZE3tvZQXAYPCHXftEV/qg1AP7bJV9qcfIECcbupJXjCGfMJC74oEfb7pPh19QBxDLvTFhwsZc06RIOXLV+rHQOFxckAxvvga+vk=
Received: from MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 12:10:55 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::de) by MN2PR01CA0053.outlook.office365.com
 (2603:10b6:208:23f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 12:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 12:10:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 06:10:52 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH net-next] amd-xgbe: re-initiate auto-negotiation for Broadcom PHYs
Date: Mon, 10 Feb 2025 17:39:33 +0530
Message-ID: <20250210120933.1981517-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e26dcc3-65e9-4db6-c43b-08dd49cbf888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cqf4/Kxi2AsZaSW7i6Umj7pWC4WQzbwnxWyQ4Sqshn78/SgoaY0ZOeAcJIn+?=
 =?us-ascii?Q?RMqbtLP4UiG6HGQH9rkeTMEU8tpBAf69XkVCSDV9io0V1/crAyy2tuP/K1r2?=
 =?us-ascii?Q?j3T02negCsG2QLjO5j3nADIgnazlzT24SqAEwyUmAg4Zd+I2ppbkuOTMNyzS?=
 =?us-ascii?Q?p8hfUTF7lJInJzpjszUxL9L3wT0diT9rHdA7Z5tk1YLgJEXbJ9UayPzA9yGn?=
 =?us-ascii?Q?h4Urp18rqvQUmrvCFEDiZ3Pk40hsOiISguAqR/W+db/42Il4fvkk6CFEXG3d?=
 =?us-ascii?Q?QpEehCcoybvg8yqN57Tei1pLQ2lBZlwcIw+nokYb0mqvy7c4l5Y73JID8ZH3?=
 =?us-ascii?Q?xkW8zM5dFvOh/3qeaOU+G5BNxbum91E/83pelNfQGPmtWu2fsYaXG33Jxewa?=
 =?us-ascii?Q?8biqTlE3AeBbSh328+uPW11e6Q00H0IsBGXQ8Za3w4LWZhwYCSGxClg27Dq7?=
 =?us-ascii?Q?XqCnraDwzFOvzJbDS9cI2sGMMDSqG7TyiKPJkzhtbISMvgVABvhxzDxdqxaf?=
 =?us-ascii?Q?1s2Pl9+F7c9kly/wHOj2IULVJUaI93uiiADnGzJ/qXDqwZz/k/moeimXqDmY?=
 =?us-ascii?Q?weWHHESIV2jOqUy0y6L2W44ATWtcQl0hE/SwYuX44izxfMJoc11kZgb8fgxE?=
 =?us-ascii?Q?csuP5GTspolAbt2ybWy0rMlHaq7B2XNzUy8mF6MVF3teJcqLfP5g0rrirW0t?=
 =?us-ascii?Q?Dc8DOK8l5oFf5BckEeT4+9cn1NR3sWQ3UgIzutZ2cCGZL9HuhbBR+V0TIZLG?=
 =?us-ascii?Q?qeL3HG1SNTxGUgXdxjUlrf6cGl0DdoBYxH/BaTAb0vX3DcxRu17Qedcv64wV?=
 =?us-ascii?Q?RPHT6B0NikLzvWfrPe5M3oeK6ci7lWF/blYe2CDyY+w1jDenR+W5WV0YtjVd?=
 =?us-ascii?Q?Kq+ut22pJBTX2DdDmPaEa4UhW8skl7ZnjttGxtagrXYWMPWkDlDktyaIs2gI?=
 =?us-ascii?Q?Jq6rZ1p8Yzn5uHofllC1/+7ijandnXK+rey+Tpayz704i9tzZZBwkZBp/DSa?=
 =?us-ascii?Q?Ph1Dwuu+35yVu1wspkIxMWEwYXka42XWqi4d8iCuLzFWcvrQJG+//pIsgzj/?=
 =?us-ascii?Q?k+kZk0PR5f8g4rH5CMRqE+s3S51snHzBwSwcSgsUtkpfdjWV2fGYWyW7lyA1?=
 =?us-ascii?Q?nAvF9F+kiLWmUP5we97EnDK9oZylrY+PLAQ2r3WqV+pvSLtUwWqRDEngKW9y?=
 =?us-ascii?Q?UQp3r1FwH4uZ9qMGryFO1GZUnJGQJNegUw9razcoERMxRLOckhCowsKjOVuV?=
 =?us-ascii?Q?bOw7noEgGhUFdTsKCAl7qGpp7mJRwjbc8jBxyDs/Y81b93QjJlpOtjStn7wE?=
 =?us-ascii?Q?w8cDxVnsa+l3g7RBRKW4pE0+nbrqWTB5JZ9bkfIOZZzD+eTtmuRZxQ8/h4ZW?=
 =?us-ascii?Q?gdiXjR0WGk5vro4tNJtdI+oxAMWln3MxR6t01gibOqKA/V772OODzInpIktf?=
 =?us-ascii?Q?a7O3f9wVuNSVlAZPs2f/qOaDNab0HkvP+h7jhRK4rUYTC5+iFiavAuk3Vm5/?=
 =?us-ascii?Q?LsPphAzgKdJAvG4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:10:55.2754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e26dcc3-65e9-4db6-c43b-08dd49cbf888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

Some PHYs on certain platforms may show a successful link after setting
the speed to 100Mbps through auto-negotiation (AN) even when
10M/100M/1G concurrent speed is configured. However, they may not be
able to transmit or receive data. These PHYs need an "additional
auto-negotiation (AN) cycle" after the speed change, to function correctly.

A quirk for these PHYs is that if the outcome of the AN leads to a
change in speed, the AN should be re-initiated at the new speed.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 268399dfcf22..4a9477554937 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -921,6 +921,24 @@ static void xgbe_phy_free_phy_device(struct xgbe_prv_data *pdata)
 	}
 }
 
+static bool xgbe_phy_broadcom_phy_quirks(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned int phy_id = phy_data->phydev->phy_id;
+	unsigned int ver;
+
+	ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
+
+	/* For Broadcom PHY, use the extra AN flag */
+	if (ver == SNPS_MAC_VER_0x21 && (phy_id & 0xffffffff) == 0x600d8595) {
+		dev_dbg(pdata->dev, "Broadcom PHY quirk in place\n");
+		pdata->an_again = 1;
+		return true;
+	}
+
+	return false;
+}
+
 static bool xgbe_phy_finisar_phy_quirks(struct xgbe_prv_data *pdata)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
@@ -1035,6 +1053,9 @@ static void xgbe_phy_external_phy_quirks(struct xgbe_prv_data *pdata)
 
 	if (xgbe_phy_finisar_phy_quirks(pdata))
 		return;
+
+	if (xgbe_phy_broadcom_phy_quirks(pdata))
+		return;
 }
 
 static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d85386cac8d1..543206976da6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -249,6 +249,9 @@
 
 #define XGBE_TC_MIN_QUANTUM	10
 
+/* SNPS MAC version */
+#define SNPS_MAC_VER_0x21	0x21
+
 /* Helper macro for descriptor handling
  *  Always use XGBE_GET_DESC_DATA to access the descriptor data
  *  since the index is free-running and needs to be and-ed
-- 
2.34.1


