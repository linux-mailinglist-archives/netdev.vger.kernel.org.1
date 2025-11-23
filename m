Return-Path: <netdev+bounces-241056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9DC7E441
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA034E2B71
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2819F40A;
	Sun, 23 Nov 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbZoaLV4"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12C4A35
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915872; cv=fail; b=NvxOJb2juerfdTDUyI5xM7Tl26+JcYcuDWkXTV3sFWu3nhSvIVPf8m/zgH26wa1xGbCh1nlB03locjykmVMVA7otwybp2fGOMpXBG1JDhDlL9WJ+u004Jo7pLR41Q0JBAC16tQ3Zmm9FYh3JxAfipd8gLpw7DvEKk/8WlIi+lSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915872; c=relaxed/simple;
	bh=+zDwKVQ9OH1U5AgIEWbu++ZcVvZMdiDSJSBIKr8YpDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fzoyqa9/VaIw89qbGDIsljteTYw3tF9LR1giOM6MhX3j6ihAw7/e2N/jvfIz6TQS1cv0lVuUknmsvcMyutll/MLYcDX9JcJwSoJMSau/IK/5PnPcLVijweoRvem0uHWJEcmevYFYJjKvuatpWoxJZLTTkzQDQzGt9JNY9oXY2ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbZoaLV4; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ1s61pilmIRMzCQLPEkdcavYdoG7g7ieqKX9zKxGO3D2TewfkR7MEYIvNXRtKn5jm61vtPC/wlBYrBJjlGUw9v8nH9DI1kvDvJJYszVVuRC9pBakI3L/nnh0XWlucyVrJzQ0LCKixtRzuQwcLDd2m8eaWcDGJJbkTwDudu1+77lUGeuc+k49WV1d51h7s4F0oECWmESQlKtdOfUwV8OCrKdXWehqw/uIofajpJjRUi458s7Vln18x8CsuMkZGzNzE8/z/luieCey5xgZNuoU4pHEvXS+jofsA3Jn2zoKahUEkLVuru1JWxiK2FLmt4hJygovMWCLCWm4QHcn+bQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tuHeOtpus+bBlGRb5rk0CU/gqdO9dI0RwaXQ+As7lk=;
 b=DmfYdVrlvVydELtFCyjmcbvtpAf625L4tzD/oXoNXNV8chhMEoH1Cn8fGd5FEHiv9JhXnPmo68LrYLHJl9Pjd04sRRI7IVUliJcQFiv2QOy4AOANAnNH+FucmrA99+FNTGbGXz4CiMpUQtd5a8IVNmqTDonYgfdWrA31100zYkBISMqO9Zy6DIs1cFevnqNmh02b4J+gdkfbREj7GGoWuws2VrPBb/QkFkiwlYcU4BH+vujISyE+0E0KQlf/LIEf8P+tvmHvZfU5hElpv3x2/89D02iDpXGQOm6tze3KbJ/FhuPz60QQHIGlF5YtWG52gqYmFBqpZ1RrpRHZlNcISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tuHeOtpus+bBlGRb5rk0CU/gqdO9dI0RwaXQ+As7lk=;
 b=pbZoaLV4zNqgxvxpUY8ONLYyLqjoHpFPtKsl7GEeu98Y1Ik+fN62TtRgetpkYT3pLusg/pStFUMMROROnu9hVMJAAnLCuMJ50CQf/LFZ42y0E3tQYGKikS05UIjCBOc3WJhTaF8wj7SKU0cwsM5JDTpVFX32wMNkEeaXiGLN4bA=
Received: from SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 16:37:45 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::b6) by SJ0PR05CA0091.outlook.office365.com
 (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7 via Frontend Transport; Sun,
 23 Nov 2025 16:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 16:37:44 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 23 Nov
 2025 10:37:41 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	<maxime.chevallier@bootlin.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2] amd-xgbe: let the MAC manage PHY PM
Date: Sun, 23 Nov 2025 22:07:21 +0530
Message-ID: <20251123163721.442162-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 055abf8f-6799-47c6-4b53-08de2aaea136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qpSgLYCUcOkg9dpcIM3rle628LAWrPgYJk2fmXkDsSBmIIxhM+1bMDqV9nZJ?=
 =?us-ascii?Q?w1jiTpP4xsyXEDDjXnC/7+PUO+0e7An+wggZLdmbUUmAh1ATTXu9yiVjQQkM?=
 =?us-ascii?Q?y77+5eNzwKPOGshfEm71ZKZuwCAy+T2daDszjkUpa7npT4i6FFvWHLMle5HE?=
 =?us-ascii?Q?kHVsD3kzPX6yjo8sqUczTOm2CGA9lKlLOyJcTUw861nnFfPkAFyJnM8kMsja?=
 =?us-ascii?Q?VL8bsCaFosjG4vmc5xbftlFFkyjE8A2YKUnj6evXvTWLydasRN5MTXjIQaNw?=
 =?us-ascii?Q?XwvbzzwIsAcCnwTQEpfQ63MIe+3ci7z0BqsAXSleQ5jghfTVv3Fa1wFzCHD5?=
 =?us-ascii?Q?VOklUZquiOPG8Fy7cDfifr9giVGZvUY51zkmcFtsWgTwS5klR0WSz5OrUR6C?=
 =?us-ascii?Q?dusli0yxsRvmzyHGH8QjUCwUrU/DTyQ1RVp405atTa4B1ecbRPJevX5GgiSH?=
 =?us-ascii?Q?9TAY/Gbl3zACa2l8XyWIk59s3qOfnX7ACbNfUwN+OjFGyGsC6W800h36COkx?=
 =?us-ascii?Q?kyAYc5ehRqtC7PGxn8i7DCIhMRwCiS6ZTR6AsMnxre58YGlXAvwECl0JQqrD?=
 =?us-ascii?Q?2PjZDc13EFluIiTL2ew7MvCGfsAlmYfgj0Qw40zQExX8dWwVB7A+M56fEgWE?=
 =?us-ascii?Q?0SF0aTZL7CgOIFOrJ4kfSVZ37IQJo20H2pPdmCBMN5aBpXQJ7UNqXzCspt2/?=
 =?us-ascii?Q?gzCR+SmI0ZkcnuuxMvh3p1qIfW3QdYdY6/XoX7/pP+pOoARYhCzmxODjmt0t?=
 =?us-ascii?Q?F5HwHhYqdPB+KRum/I5hCcFSUpuOhRnjt45TpEll60WAE4tqsSv89Ffl/PqO?=
 =?us-ascii?Q?iPIpI0iwAofiFOGdI3rucgfUG4/wyMrwU5+4ZCErFe6OxUT40pdDc+e1bpgf?=
 =?us-ascii?Q?ocXk3QhA0aKPzYabagr8KiaUiwckuHrRbGAUGiQ+SyQO2BpOidZnssArDYOW?=
 =?us-ascii?Q?XKYc+hAKrK+vEa/RH4WhazfFA6XvsoQqeVgYVS/ywcc61kBIGMZX2Uwta+TK?=
 =?us-ascii?Q?yX2v2Ch7UfDMmyARWb/sbFOy6/ulLUTi+VaJJ1hGZs5f4l73C7a0H0D6hEyr?=
 =?us-ascii?Q?mJnBrW4hIlVcFDHBM1x4IF6CN3vkOawTd3GCcNCE9wVvKE7DwDoUmwj79yTw?=
 =?us-ascii?Q?jUkq/wS65qz3i/h7BEsC7XRUN0juCOAatpgHANPoaqmbr3KjkIwc/vs0suCJ?=
 =?us-ascii?Q?K0rrlFkd4OUvht08158EbZd9Q4oHM1XV1maMuks9VS+XWoXndfaPHmhyuRxm?=
 =?us-ascii?Q?JJ1pRBfYYpdWvj5VZV/QcOVHQEANULee0L2ypy/uDcR4V77BPGvdxt6U/SPu?=
 =?us-ascii?Q?7pgXBIIcPZj7ny1yl7SZZWSWIie8layM9NrL9yEPSan8fxAHj2iCKdL8ByjZ?=
 =?us-ascii?Q?Y2h/MCaKOyzz85HlTbElPAUFAqKWFkoHN3hyaLQR9znO57IkTEFdb7CutGE+?=
 =?us-ascii?Q?Ir3E+YmmkNlWPQbtiYDX6XgsomuVqrU07V3eSMdYoLuWbHTx0LabWbnoj/5t?=
 =?us-ascii?Q?W8RTHMk6PejrTR3Zz3FFTwLjeMeUvghflm4ouS6tlR1c/10izsRHY3IHgli7?=
 =?us-ascii?Q?04QfCMd36sF80TXmQuY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 16:37:44.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055abf8f-6799-47c6-4b53-08de2aaea136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650

Use the MAC managed PM flag to indicate that MAC driver takes care of
suspending/resuming the PHY, and reset it when the device is brought up.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - remove the first call to xgbe_phy_reset() in .ndo_open

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 14 +++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index f3adf29b222b..0653e69f0ef7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1259,6 +1259,11 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
+	/* Reset the phy settings */
+	ret = xgbe_phy_reset(pdata);
+	if (ret)
+		goto err_txrx;
+
 	netif_tx_start_all_queues(netdev);
 
 	xgbe_start_timers(pdata);
@@ -1268,6 +1273,10 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	return 0;
 
+err_txrx:
+	hw_if->disable_rx(pdata);
+	hw_if->disable_tx(pdata);
+
 err_irqs:
 	xgbe_free_irqs(pdata);
 
@@ -1574,11 +1583,6 @@ static int xgbe_open(struct net_device *netdev)
 		goto err_dev_wq;
 	}
 
-	/* Reset the phy settings */
-	ret = xgbe_phy_reset(pdata);
-	if (ret)
-		goto err_an_wq;
-
 	/* Enable the clocks */
 	ret = clk_prepare_enable(pdata->sysclk);
 	if (ret) {
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 35a381a83647..a68757e8fd22 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -989,6 +989,7 @@ static int xgbe_phy_find_phy_device(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 	phy_data->phydev = phydev;
+	phy_data->phydev->mac_managed_pm = true;
 
 	xgbe_phy_external_phy_quirks(pdata);
 
-- 
2.34.1


