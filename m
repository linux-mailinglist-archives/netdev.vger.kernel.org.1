Return-Path: <netdev+bounces-234130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966BC1CDFD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6214D1A21D8F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82961358D07;
	Wed, 29 Oct 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oe6V1+IO"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D72F692B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764551; cv=fail; b=Igq2CUnyYAb32xX0KOgBeSz1gnO9kPNE6ZsLQwIWP2UYLLah0Oyg32XNO43f+R0hMTbKgjDhWvF4dz/5NsJKorDQap1dvxSzL+QedcmQsOdMnLO+d7RLH/FzUivg6UpSzxcjMWt/8Uol8oymNhBn0QC6B/OAyHKQbMJ/Cw+RYCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764551; c=relaxed/simple;
	bh=zucbdOFrNvJl+K66AELZKzP1oWgMJ7PO7PguJmHTAT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ7Rcyjo3CcM1/qgZpXjWRFpH0pTuGDYE+KD2iAyo20xVtPNwMifp30mq3LQLkwTSO7gjpoYXafleWa0+01o9Yzs4Eldzrenz+dAFxzMz13C2eaitsk4Q74hgPsYSyi6QQ/m+ULkPw10Yq7Eul7pjWfnHeHwKuIfa2al6JP1I6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oe6V1+IO; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxbSnlbhG7g9n8Zv0v500QSwDQGRYeRU03+ODidXJiSapsiiMEuQb3vsr+onS0WpOWK1d7Y9ZOlQ0S4eCa/0fApVG2f18qMuTFjirBGFJfMGMEM/BE+DkdteXoC/Vgx38Bsej/6zQU3wUfvJdiLxmlzuQs681o4mBFjg6pAZLIEn4pxH+PBj4pdGGui5EQZMkLWtkMs7w3KUFHouwxTyPQ6x4WkcKvujmHS5umsWKSLkfShnWhAOzeGn8hvzAr4Iwiptj/Rd2V4gUl5cttNomRqTjRQb1tdw8lBk7W/1sW5NyjtdyB9QnURFFU2fitVA2DSMD75x3M0E3LXiIldbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJWkJbVYq1I0VqFSA/GY+VXIiWGgEnfmiAwv7mjzfUY=;
 b=BOEYWmigCKQcuNNB6HxLRL//6o3piZYyKmelLthkHd4QRP7wenqsles6/DUqyYyWj09zOumvEEP+E4QilR7k0dsNbAfCRfVCDYCS11WLzTZM9k7qfJHWxgipXEdF39rTAeCQRzWfizIZVvHZgjodS2MfOQgYn356VRrBz9WJRfRFRQtTSZbu7UlRU24nj+CYUrgw3L2NVHFiaZIEddRlCsVLknTga4ghJ89ghIRei3ijpctqmfrcG7HC4vwFXXMWmfvZlDitJQDh78aWdjP0MEn43w43aJCrMknmpKv+SRczt/ZQ1vHDs3bMZ7hTAh8KaT2sNkUTowfTEok3wSnspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJWkJbVYq1I0VqFSA/GY+VXIiWGgEnfmiAwv7mjzfUY=;
 b=Oe6V1+IObxwTwBmZxd+UsZu4DehwsIUU/XU78uGE5pgGTUQNOqurR7PGPFeXQECYmIPfzj5jTTA+x1y4XlzXOny8AlqzJRIISrIzkEDb0HiejapouvDHmXKOcw6QFJJtGn7yYO8bzOeZLMBuwGwH5mvZ5NpOspvKs0Ge/nj72Hk=
Received: from CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29) by
 MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:02:25 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::88) by CH2PR05CA0016.outlook.office365.com
 (2603:10b6:610::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 19:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:02:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 12:02:17 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 3/5] amd-xgbe: add ethtool phy selftest
Date: Thu, 30 Oct 2025 00:31:14 +0530
Message-ID: <20251029190116.3220985-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
References: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0384f4c9-44c4-498c-6287-08de171db191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9vDjO3BGTivZqOzwHjJQo0/ghygg9eeWSInAA0MMptisK4prEShY226R91u?=
 =?us-ascii?Q?Z9S5R0Jpu7pBlromOR3rsVnAnbhpBgbjUQPcK+Dc/LAlXyuLskzDkFQOsxkW?=
 =?us-ascii?Q?xVZEecUR5Ub17DE5++556HuBBOrblvYirpMAkSqFq5f7n8HPU2h3PVK2ynb5?=
 =?us-ascii?Q?fHlxW7CGV1Y/2x5k0nMfFuVnDhXYuFXawuwMg2tzpeDevxmhpxNLT4BTO53I?=
 =?us-ascii?Q?EcmivD8YgmM1d7hpqYRaj1V1g4KznVuQP5dJERKTTsKEbLZnTOZ6aYfHSXs6?=
 =?us-ascii?Q?x6GdQODSSkPW3pwjP/H0PngEomCBqbLzNnTOXX+f99Cz2e1Rabmd5qtPzuhV?=
 =?us-ascii?Q?QJLe3DTR1kJn5qtYo1N15QVNGZtX8+M/DAyIJxwCw5NEoWb8BsAuxSbnONOz?=
 =?us-ascii?Q?VgXRbQ6x5+65/jw2q4r3kZHghEQ5K/b617OiJO6oW7OHjzu8ZEqyyDuUFaYp?=
 =?us-ascii?Q?RLVwn8orogKirEjmRYU7NluHuL3Noffe10VTKaNqYbNNihzffC5B8x51OuTm?=
 =?us-ascii?Q?zGJSEfelmcnwQQXpDrWPnmaoaYZ2cEG0Q4SPEgPU3jIHpDz3Rpik9usl085/?=
 =?us-ascii?Q?JM5MbaZxRDbyiIa4KJbl+ClJ5hGEiMtKiisc/j1fxADpwxoa6GuBa2UddnfJ?=
 =?us-ascii?Q?saaysjV5hggi0WJGveHOSRENXwxzze/5u29Y+udkbrHiReLAqkQwJxKEEzEF?=
 =?us-ascii?Q?pa83OpjyksTBHccIq1g8ur9xyZT5MeGm2hFUPzGtWDuJDIdT5H57PHx/RJuy?=
 =?us-ascii?Q?bAYV/7WDGzL3VJ9zsd/cS7l9aTXRAZFJ2fGbbxn6yh2TIENmqFIzyu64QOl1?=
 =?us-ascii?Q?xC0LWUaO66SnSpUiV4zDCUt3jzAfW0z+Ja85GKVFLAOGKTIH/S/ZJB1seJ+8?=
 =?us-ascii?Q?YSiXulTlAlBMrcmVkb+QrkZwip2sZpEaxN2Ya6WsCyuY6cBRq0UQm/9XzmKL?=
 =?us-ascii?Q?mnN4TqW7luiGlpqESB7uzMNxNFnCpeRZh7j6JCW3wnwgkoKDyibl6uXrW6Y0?=
 =?us-ascii?Q?2d0+gCs0j1E94DtzHSChV1cZwXX8pyuUevtWZzMgya0RrdaQEN2aExHWU0r6?=
 =?us-ascii?Q?VWmA6bwsTIPimpF7EVsN8OIac+y86NVw/X5G7UBezoI8pUjWBV1H0Ev8s/4a?=
 =?us-ascii?Q?d2gTfEY4n7yBxDPi83+6nc+cyrv//+zDtJR6O8hJzZQYIMWkyAPUPkHjTw61?=
 =?us-ascii?Q?MRx508d00dGDKBEDPx92AHVmBHZPooQt3CUbTmt8sgztObSllvDp+pOOuHGn?=
 =?us-ascii?Q?4sTpDYGnrIqYm8cxubs1+vD2wOW05g4qJB0CR7CHPwxDhTpyy+4PwV1qVyLu?=
 =?us-ascii?Q?Z00wi2AEhAVJ7tPdFHeLrXWS+RHnrCdR+X9do2WaE+1+5hbrft/ENgZm9kwS?=
 =?us-ascii?Q?yDSyDRBpEwpBqUEju3C+BL0KWMw61Q+h9jNLrcHtWGsu+2lfxWYGBRA9rLum?=
 =?us-ascii?Q?EjANHGkO2I/9k6ShfJx2jj+w9/hPf5vfcyabsokxG4bk+euvDUYWgJOsrbj1?=
 =?us-ascii?Q?n5LELPHZJlV16+yYEsU8boqeaXEIcmLvpHKfV/RicEhvdrgJxTRwFtR7ZISD?=
 =?us-ascii?Q?dWAjPMs6/9ypMgQq4Dw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:02:23.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0384f4c9-44c4-498c-6287-08de171db191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224

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


