Return-Path: <netdev+bounces-233458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32F3C13A01
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC595848EB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7182DC331;
	Tue, 28 Oct 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FH3kZk8p"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161242D73A4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641391; cv=fail; b=eIkHdaEXHNX/BBdcNrM1UAmN17mIyaSG0AKyzmD0TYMF+5mF6nrd6kJSNALuV3ulpMnYt67XWJ1A/jHJaFA3wcSJDkvrvq8a573ZgKUoOFsIYW4X4422O1d8NAbWReKwWLLvlCQrWccyjqXY+pI/LCg5t50bSsTsx2kf5WukXbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641391; c=relaxed/simple;
	bh=gfoU5vR9Ivw+59ARijRrjjOhalG9MfSP+51F/nVOYGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCF8efDsf7wGNL8Y/CKJJwiay6ROmOZwgKoHFuD11zulayp3AIDaCDNbekutOqv1yqovxQ2SBPxJgdkKc7Af1ItkYfS9gFA80XuAopreLsdr1dSMRv2esRHAcJCgqJhSuqfazWkdTjhbkBVhOyeWIriY4PZ8x1mCU6fye76fdTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FH3kZk8p; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxnqheZtOK2pXB+iBLguFoCr450QNfe+wygnH4kuRrjYRwmFLajb8jQp1lnP8druHwF8z3PYpEFoIehxj+sqHWbPz0fbTCNRMj5fZ9KM762eTWiXXrL4eKiEHP9Vs2N+3sM405HBsibRWwkfbACsmu+FNx2cDQvR/q7WXBZl5NULSg+J5DsGFZV8e+eE9a8GuLUJFSLb8GSzv9JLfP8uPJyA82r/o49pxmDFIt0fh3iPiJu1Tmvq5p7fqjEzmyn9iv3b6vk2FOFF5ShefC9q7KAz+FuuIyZk24x5hCL4eA8oRDWOLxBn0NAe4yz5t+rfNiBECcK8n5b8FMXhmzxBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESy0ZGdjTzDCUm/OiQ4e9UL/jXGRX2SSqVc1Nr//gb4=;
 b=YfpCgQ+AkA01sV4nqCOi+6wKcV4MYtM9ImfvQACrLEzO23c9/UTffLI5DbixKvOZL5JmD8iBLNwQFczKKelnbIzFpzpH+OZQX/deTiNXHH7x7kX87gC2hMYEgupNOLdpKw8ncCUfO6lxdGcsVXRp0uiYbslvWjOzqPgnSuS1DeWYz5cfqTVtSolUbijigsZs0Ex8lzQ7XS1ElVB6ETVTu2OzuF0+PAw9l/lGzAJFQzRAWgM4QM/y23XsvTScF4jT/4v1TE3hLS5tcYBlM1/DL3Ryj+g1Ym2yo4ME6KmdOTdq5LEIYVl00qIkwdWMd9l+STGqwASOx8oS3WzAV9es4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESy0ZGdjTzDCUm/OiQ4e9UL/jXGRX2SSqVc1Nr//gb4=;
 b=FH3kZk8pSIv4SCLwFd1t/jXyh0NCra+rbjo19+kdzIPthUTTINvE8s3rDqhJZU/+WQUJnH7Or248y5AXUoBkTd9jmO4wcVh/uLuTzE0yN17davi/CMZYdwdwMTHKbh+02g0Lg86ccdTDnPLaV8EJZbtqH5Bg86y2vEPDlpefsfc=
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:49:46 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::88) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 08:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 08:49:46 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:49:42 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 3/5] amd-xgbe: add ethtool phy selftest
Date: Tue, 28 Oct 2025 14:19:21 +0530
Message-ID: <20251028084923.1047010-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: eacf59a7-ce9c-408a-9949-08de15fef247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/Isonfp82pnRSUSn8TVO8QIqmOmNHrr+JlbUMTUTjBChZpLgwNKFpVj05jS?=
 =?us-ascii?Q?sCmEAbwVWES6zqZFj62jL8C2XcazbsC68ZUMt1riE7ACWr14jXdcljXmY7Fw?=
 =?us-ascii?Q?iyjrDjN6N1+MW50Oo4o+rhhe0VyjdasodG5dbD3O9Y71ppgYSm6GO/B/yIE6?=
 =?us-ascii?Q?9o0YwBHzG2q3eqcwW8jKNJg1ZFwhJVQInM3nejoK+1wMrVicYw/LZYcDleur?=
 =?us-ascii?Q?7IXn4vpoLiyg7Am9w1udRq9IQNe3TtD+J+caowp0uY/PrnSwQFt7snzRIH9a?=
 =?us-ascii?Q?2BT94DVe9miVqtI+YXS3droTT45w+wlaZWKB+WUmMWz73zKdxE3VzRs1AG0c?=
 =?us-ascii?Q?a+g/cnUoPi4RyDoDC5BjuWeJHlb72cVSIH0+hPgjNo2AOM7h5wXhoy/vQ2ky?=
 =?us-ascii?Q?Fa/OdZwndU7EZTH1Ky6s7wVREb4r1SD5XLElkbZFRSjlVsdw/XndmWtinNNu?=
 =?us-ascii?Q?gFTkl2yoQBVy/CsAKZhK4XcAA6RyzgNT8GREoS/S8Ni3RazMfRlZrjzdXinv?=
 =?us-ascii?Q?SIFnXNPhW0W95WimELyWD2MvpsZPw+oJcW0cBCD3JY+cWK5q9MnaqPz6IRU7?=
 =?us-ascii?Q?hCZEFqMpywArhcVIMyqFD6tz8lZDRXyTCZHDRzsm3sljzXVG+bK8g/wMAmJv?=
 =?us-ascii?Q?+GPvd1sChwxOPoBra7t2NE4nMagbwRL67IalfRYYFm8F10Gxm0BXKTekHmfU?=
 =?us-ascii?Q?BkX24j0+DB5x2WjCHiam6W2wmhdQ2agm+iSBSbjW9TK82K2FAS+MyEa86otl?=
 =?us-ascii?Q?aDX0WRR5azg+djlBxTsikC5zqno97/756+Ap7j3Wya8ass+5imZJrjkztdxe?=
 =?us-ascii?Q?2JBmtC80fJ4Oo2XkwFACh5NgNueqyS5nTh/Uxz+gmDAGhDy4bnpqCHYXoumB?=
 =?us-ascii?Q?GD52h7dhsMPjECHCgSqmO9vnAlciCKU9LezSFtCAk/19aG+Vq9B+vvyJvHvo?=
 =?us-ascii?Q?Mwnzn0HWBaH/4WqEtDhNy/l/X9XbwvnwcYvePLozXtr0X7m/5jCLdpU9ax90?=
 =?us-ascii?Q?HsgNGDbcQZx08+847gTf4RjIaOoF09o9aqwd2ahV3mrOKr6jjXXXyOzZ8EKH?=
 =?us-ascii?Q?cKFFJ6RwTRfH7L3FSlqZUln6Emsyysun5I2FmQADgdfe9q8QhJ2SuyCM9wmK?=
 =?us-ascii?Q?OyBIkJ6yG7CYcTPafMbXYyF02CKg8HRfWJhEOQ8zPOITrzA8MAzi6EL6IXsw?=
 =?us-ascii?Q?7tF0m/eroAj+Ry1mvE+5a525hEh/mPGXERXGXXRAH0BsC/3d2UW51QotV2ra?=
 =?us-ascii?Q?/AIvQEsctXczyGPL0ARBlnIlLUguN/BQHDht19DMFtr61LG+CrEuYZCNYaep?=
 =?us-ascii?Q?mbkaSijSVWG4W1ojWmFJ4R2Ef/giTeF9DyzzeTe8jXzOsC+CiEHhbgftM6HS?=
 =?us-ascii?Q?/m6QS4eHFk2BEgJ+sk0ju9gtPd6Y3sRF1hl6MNzE8hYDjt3AyqFlVAg+7Q96?=
 =?us-ascii?Q?Hy1t3m1hT7Y4BIuoxFfjOJ7wESiAnfX5CkXWz7Z2tAunZT6t5mxDil2RkMVL?=
 =?us-ascii?Q?Ani2krTkrbqqaI0odJ9VluEkoSHpFxCIRG5QXsrlSYeVqvqypJQ/aAOxHKTT?=
 =?us-ascii?Q?g0nOqybiM5RYMDwDAww=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:49:46.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacf59a7-ce9c-408a-9949-08de15fef247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

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
index 55b19d906c8f..80071ce816e7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -19,6 +19,7 @@
 
 #define XGBE_LOOPBACK_NONE	0
 #define XGBE_LOOPBACK_MAC	1
+#define XGBE_LOOPBACK_PHY	2
 
 struct xgbe_test {
 	char name[ETH_GSTRING_LEN];
@@ -157,11 +158,36 @@ static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
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
 
@@ -193,6 +219,13 @@ void xgbe_selftest_run(struct net_device *dev,
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
 			ret = xgbe_config_mac_loopback(pdata, true);
 			break;
@@ -219,6 +252,13 @@ void xgbe_selftest_run(struct net_device *dev,
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
 			xgbe_config_mac_loopback(pdata, false);
 			break;
-- 
2.34.1


