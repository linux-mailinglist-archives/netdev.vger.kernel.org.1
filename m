Return-Path: <netdev+bounces-234623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF027C24C04
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E634263E6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9593321AE;
	Fri, 31 Oct 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E7AQi2hK"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BED2FD7B2
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909424; cv=fail; b=GjO/zhShEaZZD8tvVkc6QE3KzBCepbvFE9JAp4lmmS8EBZeQcZnqMjqZfCR0aEc9CGOCD0J5qpwk8maW/KHEbzolYox4+qlifSi7uuhg2Nv0CUf7WjDikFKycQOSDxR847WdTRFIEYj8xScs6GGb+ip61Abrrtdzb1fwX1blZIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909424; c=relaxed/simple;
	bh=l5JM3LubDs3xM+lbIYpIkZ7sLoY0uHXZKtdan0GbB/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMjsDZLA5J+anUcOd52Gf+XWckaZsyymCiGbTpfDoecA8kYvTTtGRHyXHAirFq3OCg9he/2bChWld9Goz18fpsYIkMYRlm1Dupp4fb6aPr1VZbiz37oFfRAKGhPmGMVSUsNfT11d6j5Q1S9WDHp6Tg2aXCad4bIi6frwqeCf658=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E7AQi2hK; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+GkjxU9ac/sF3izkSjwSkyA8SscKSL7JQZTovmcGUNYrLRHdgvxhVpACdNVqdA4ARvLTNcfVirlDGyz38kGU7h2TF8PoJi2g7t5P/mt+DDH10NB8h3wEv7wX+X1i7QAUfNDp0T1PrIZ1hxs1zvIWlUHKbI5F1PrnxXIRvCPtYaqSk26f/CmlobXj9QmWqqsgPl2DbYkqrokPTltDH32PgUCNBQGD9XKJTj8yDJtgHJxvH+aEiHPadl4VZFqjuHFgXZbj9ZnyAYdsviWidU0IKk63o2x6jsBUrzlOlTZ+WIWtFojDlbTVS/1jI3LuP+c9TCRNeGJImqg9zOaF48QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnBCW7cdviik+Ztaqtx7VROjHn7j0lFb/oSH9ctDcEY=;
 b=VM4So5q3r4Rq5ZzGTPTgZxg728du+61Qs50OqQseqcs83fUnMpW3V9ldRI68MeD44f09TlETeLmQuEtslg+Xkx3TkKzeGQq6Em+PfI8qVHg30VPNWNC0jlvyK/mxo5x/ZHHCEe1s+KjieAJGCDoswiyxbM8xpbPJOa6K9bVE0OuPKWoRcaW4JqQ4w8S7xyGAtBoxn0AcotISG7uctsM2EcIk8dOuxiosz1QuvHqBGhmDcBjz1caKGJYQrgWTztW0Map+zQvXcaa9dZbL2XGhxVry1Xq3NRUnnbp19Zt4tZE+RrCJYrZU0DvsgsuALbPl8TCPIyeJEo/wuLJihfWnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnBCW7cdviik+Ztaqtx7VROjHn7j0lFb/oSH9ctDcEY=;
 b=E7AQi2hK90dK9kmZrJmBBiPOwDjWYV3ayxDVDzhQS8AUj78FeshR0wJcfckPx4yWq5YeL1S9qCw4/SN08K2xmLvpEj1h4ZxC37nbjRjr5i2Vy2Pektp6j2eWxBdvpmdqC5YSaa84qdT7p96HzBucmPEFCu8pM1u9cQhu718sjNA=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 11:17:00 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::7) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Fri,
 31 Oct 2025 11:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:16:59 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:16:57 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 3/5] amd-xgbe: add ethtool phy loopback selftest
Date: Fri, 31 Oct 2025 16:45:55 +0530
Message-ID: <20251031111555.774425-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031111555.774425-1-Raju.Rangoju@amd.com>
References: <20251031111555.774425-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 180e7a6a-ca5a-4d08-6fc1-08de186f02c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLscmjea4eDbfzi/Od/syH7e9UlnnPfA4MFeV82CoeC7bWfoAyFVEmqFEAAr?=
 =?us-ascii?Q?UrlzbieScdrO5bk2D3EPef5uGqqHJQUuXsMMytii3649GsZNhYSS3Th7/Cev?=
 =?us-ascii?Q?D0DcEZvR/jUS1PCethHJ5siFXx44JQhLqJCPLpkyZjM7GTUOLfyPNQj/An0n?=
 =?us-ascii?Q?GvQjkxX5d8yJ/iLf538pV6gt2EvFtnh6GcuEUq/8lTFAOxJvhJ62XqZwMtXE?=
 =?us-ascii?Q?67iH1H9E4VzHusdNm4RzYSRun4+W/tHyO562kZ9wDSTK3J/O11jUlZtrbshY?=
 =?us-ascii?Q?9oW/dA5m3DrCCxsqCKTp+6hnJCtvfH4xT0gKxp3hBhdx1WZVjMo3sLL/V2VW?=
 =?us-ascii?Q?VDl7JeWlq8MOIRZWjkCiIqQQcHBxLSRfMZUNqV9EC2fj1qBTq4na45GcBU4x?=
 =?us-ascii?Q?dS8aRpNOfSxBDoVW5/uZ0SJZNsiOzh4GV+iPsJAnPURD+f0Vvyw1n6WTRNPB?=
 =?us-ascii?Q?VPp/e1pHG9pw+GGyB2Ux7tPu0kwAbFDqq5nxSfklsFFZ1e7QBtoAbyuwBUyT?=
 =?us-ascii?Q?aKbHc/F2cE1tutTYrbP+BTbStAjE6sqAurkO2v0mLE4FBs5g+ZCLeo07b5cH?=
 =?us-ascii?Q?RiG703xe8GmOCv/BXwtmF+qTFULP9dYxl4VkR56p78b+XjM+O0XE8eDNIMQe?=
 =?us-ascii?Q?7e20CwgITmLLr27EeTsApkmsJAQ4qHetF7Q+20XCkFVAE1twh090Snl801ni?=
 =?us-ascii?Q?FJuZUkT6IKehWCOUwbcsCwbZLjZfqvgpusnMh+DvqsvRY0QiXmzS9BPl+1yv?=
 =?us-ascii?Q?38Q1Kk2qRYg+1Rq20pFifxb5Hj6WVaNLXNKISO0XqK1dDUumx/RlWFoKK4le?=
 =?us-ascii?Q?a1qYRGfOjc8/6vFK2y5D/CHSXYjgoCfDfzaPgM994E5ODjew5H2fTHcGig52?=
 =?us-ascii?Q?WAAORqQKjihhrcn0bkolYzdRN48EvEQocxsl8BDrCu2tAGYDq0DMeED12V3Y?=
 =?us-ascii?Q?VuC5j9cLGP6ln2mbLdEZJbvSxlUs11nuryZwFMWb+yLDP+ocIFOk3ZtfvG3J?=
 =?us-ascii?Q?aE/PG+MtYzSg8HO0qfLR4M8Z5WJrgEwttwK0s9vle8O1PWHPKfd9Zm9MpM1I?=
 =?us-ascii?Q?tHcqw2nraqB+ESMPHcBfsqMV4kYxLl7lSU/plZpHgqXH34gzGRAzF8uRCJSh?=
 =?us-ascii?Q?tXC0XHz2lFq+Wpc+uUTR1UeNj7chE18ljoQu94ESeQsLNitAZNzIVQjGtbsF?=
 =?us-ascii?Q?S/L/YcWgr9xWwUCLteOFTggsYDVtlA0+V3OfCQ+Wl4DQxKkLJh42d4n03rAQ?=
 =?us-ascii?Q?6eGy5PiUWL3ya1X14j1O49YRixCLWast4DknOTR2i4ViUJuf7qhBArB7N/iM?=
 =?us-ascii?Q?y3RuZ163tjZXfEeMT+hzaSt/lyz6hAesfljycL+PRC9SxYeh5t3+eaxszUTE?=
 =?us-ascii?Q?VR0ohZGOQLeVjW8Q0QUlUbrLTuTNkQQRN9S0LZYSKzVblojAl2exBsMbDw2c?=
 =?us-ascii?Q?54LwSq310EyU6FRiwR/voPY71i1nZCRQ8cVAOc3ZJJKkxqU3NRq5YXm+rJgS?=
 =?us-ascii?Q?lDjGeWUlkF/DcHbIMTYrIZPazAw3XZJcMPW/rsHs0vWmwmwm8Qfr7QeOXRG1?=
 =?us-ascii?Q?h7Hycnc7DXFejm8EfpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:16:59.9402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e7a6a-ca5a-4d08-6fc1-08de186f02c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851

Add support for PHY loopback testing via ethtool self-test.
The test uses phy_loopback() which enables PHY-level loopback
through the PHY driver's set_loopback callback if provided,
else uses the genphy_loopback().

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changes since v5:
 - fix the commit message 
Changes since v2:
 - fix build warnings for alpha arch

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 8a3a6279584d..23b9d568a861 100644
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


