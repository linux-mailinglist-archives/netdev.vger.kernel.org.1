Return-Path: <netdev+bounces-205231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C66AFDD63
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFF51C23CB0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99ED1F0E2E;
	Wed,  9 Jul 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y//v3Z28"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835E1A3A80;
	Wed,  9 Jul 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027808; cv=fail; b=rUiFtlZAWXhSh8O12nE2hvnutCa/0Xow/Kg1obd6mZdIWNXAEe8BDkmZx60tC/08qDZfClrjvtlPejwLAOSNEforvb0MaqHRUcSv6KfOZZ4ZoENz9bboNFhVgIw2zVzmLNxYsJewd5S/g4g9RvVsUgFF/6ZRurpXW/VjUIqfBIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027808; c=relaxed/simple;
	bh=uE2eBdYYU+IW6bdGmoOfI5wfrFT2T2F+pWBVc21hLCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCIwJ9JwXgsN07fw2BvQMOXwK4GwaGkY1vt3t9HmNwe0G2KdpL/9kb8VItavHPZL/iYD3+MYQm1pZuQs6fxTBiz1pJt0a0BRTNMHOrYDepHJeHUEka3lLgW9YwPKp531+/d1T1ALR50U5MIdpFI1/Tbz8vK2CRx8qFIeOfjefnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y//v3Z28; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5Pg7XhYbjz9Vs8o20ux5OeWoARxFelU2tuhWVfv6opUimF5sl76HWE77GB5RNFN3QTPiNN2zLbsoAiwlmqqzylLlVw4I2OIIy/XvuJdL7VWmKlheCjBVuQi/QeeetRGgnHXEd3KahebteXxDmQyg2H6Dl9qxcfkJc/WW4AdnDIw38hhs3XsBbyA7xVbvB5tefUJcO/UbBk2LXmu5KcLUnDdjdCi0uHIifTC9YTvpHAFCZ8VVL/0A1Y9aEAwCDv6+NaKhFd2SF0UC0+Tupuig6r/UACSueWw/PY8EEqeok8VZcJ0xfDFwWCtMs7FwmG8CMqGgT4RUrqfs/7wZ2WMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU6WcTQhxw3OEPDEYhfAHOl7AJsYf4ZLLMaKs+MaxRU=;
 b=a19QiJmJl7DOZG69bto5WewIPh+1goSjxp1WPCu7Oyh3kSG3/d8/xzAURXG1Y91miADZb/Zqg8mYBLHg7sKxSGiX80zznVh7b+Zh8O8C/0CzmglV0YhrVEgL6jqjUJoHBXiEVNsNOrbV4NPlvtQwiUPSOfqm0NFHEvJVtkNc3AYnpUVjEEin7qTNITDp9L1BfgZ+hxHHUHL60Kt+dL+f+/GMx/BxXBaEfZyOFtD+rt7dDxpeb3116x5Y+BRmYwd1HuEq46NE4ES5R4p1T/UfahmWvsT5ixE9F1JwiHQzADGAxafRejqV6jkktA8l5cAkx9j7J63KMZk0ULmwcc2Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU6WcTQhxw3OEPDEYhfAHOl7AJsYf4ZLLMaKs+MaxRU=;
 b=Y//v3Z28S9at0w1+oiKO2hk91wPhO5QSlGkGSIoNJCqm1aEuZYAgzHsjHPKNR/vasW+r8fhVjVCBIezqlpyceLC/9K7jSXZUMovc+G7/98W1b9nMJYg7ZESdWoREevXR0ryzrmzT9ntEHmm00bJW1BybU3pK5+NcrUnkel08m/qsUasGz+znWSDcVf4Xnxvvyhh9N7/o+jTM3EhvI/Z6COPR+DzNnsNtuE7oDH8/0s+Zqg2sxSyQNfBlMtn470YrVRgRpEzQbwg0q2+YQBgRg63L6zfmoNlLrpS1DhVwHf6KBqHj+a/IJaUphe+XSWcWqInmiNMyD/oeZfKlQ9MBXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:25 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:25 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com (maintainer:QLOGIC QLCNIC (1/10)Gb ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:QLOGIC QLCNIC (1/10)Gb ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 05/12] ethernet: qlcnic: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:33 +0800
Message-Id: <20250709022210.304030-6-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f06b6c1-1c4c-48a6-d9b4-08ddbe8f9583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSqqjxGhQgcIgsaV54gxBnyHAFR4MjG5xHwZAr6ZeDbXWDRcM7jBjypHfXlQ?=
 =?us-ascii?Q?OfjXq2AYPtPE7Wy/8wfnvy2uNgRoE6jADjpY/E720C65isgeU+kbpOAJJIPd?=
 =?us-ascii?Q?Yj3XIzhqFL/g8EVchMTNdmxqn7N0/Mt3oFHW7+ypfzo8kTXJ7/Q3hYIm+/so?=
 =?us-ascii?Q?riSnh3/MYFbtaLz1/ErTSfDjIHsO7MAAubhlqS92CSzAdRYp/wy31dgP0G/9?=
 =?us-ascii?Q?y+W9irCuK953znGAdhi0Gdyk7/siS1B+pVOcB12LgCHS6ivLGvGLzbRa1CqW?=
 =?us-ascii?Q?2/hvvtqBdyq6sC0ChskGHXHY61uGapRGcf6FbGHO64/etuQHY8e9VkUDs2NE?=
 =?us-ascii?Q?GceKggcb8Gq8O/ItUedNQ+uxzUEOSaxsLzO8dp3v3DoV1I+iZ4yBTW/ZN8DD?=
 =?us-ascii?Q?jMleNztIQWhFYrCgmI3r6kydxqSwVfMcZUt0f7Y/Slt1qRxu/nr8Cjcy7YO8?=
 =?us-ascii?Q?gW6d96sngqkH2/JaZSJ1M3FtnQrXHbkyd7Pd0PCDqHpcJXQl5iWz4XbDLXrj?=
 =?us-ascii?Q?K3FykK40Rujk/hg+1RNnlCxIvXEdNoexxYs9SWJMUqn/VFxWPWpW3S/Yw+CM?=
 =?us-ascii?Q?uToGz5KgHzuygD8VLJyaCTdqAotOPg1tLHuxRpq4kTrDnSVSvptGurQmw2/8?=
 =?us-ascii?Q?YGsQVPbPwQJWwo/3dIMfTeYaSOsR1TYe1Nxuv5nW2g3sGozv4B3hJY9ofMuj?=
 =?us-ascii?Q?noI2LR2yEEEVcQAJQljYQmMaDOcEvTEF0SljtRQa1GWpsBIHeyGhfKX36xN2?=
 =?us-ascii?Q?gYWIJMQj9xr4L4Emgw5drb9BB+ClNTKNh8x4KqKlRw9LsiDRL+UgSmhf2+bx?=
 =?us-ascii?Q?wLgXA4yH1xSKmR/1auftd5JPnMFKlzVl/265bSEO8xL1Yw876ZAYTBS0o5KR?=
 =?us-ascii?Q?iAHDy+3VjLqdDka7Oj8NVZDL+Mt9k9/imRFpxiqZIpV7Mb97nhXurINqxmCx?=
 =?us-ascii?Q?zbQXlWW3Ql9DTklPtCkZdvC+QPiq1UgWCzpcJzyWPHMjxZDqj8J+nawWySdK?=
 =?us-ascii?Q?kLmdurlnnj+fIfrYSpA34fmZYIL8XGH/qK34t+0gk1Mv5kP2001jp+vVsYOR?=
 =?us-ascii?Q?UIz5O7weW0AlnXFUi2PPuLagvlUAWzLJzU9+kK6YQeI2PuQhqIusrPulECQM?=
 =?us-ascii?Q?LbPfBOqMZ0u2Ufr9wEw3a9jJ8hjpldQwfLJThEavIshFisPkftm8T0nmPvph?=
 =?us-ascii?Q?mTAnnseyg2BNkQNUVZ1PJAX2cVOoadesA8rdldl1RsCFGbv/WrvAbB/2SiLL?=
 =?us-ascii?Q?lhQ0H1H2jw2NrJBtVTiMpq6nMUgr026WsR2VbWVNhaiMcuCLJFRHPU/rFg/+?=
 =?us-ascii?Q?PzyF2xNhdQS2Q8SpTMjLMqfp5JunIUfqD8H0kJzWMltDEb0sSvrO+4vD/bit?=
 =?us-ascii?Q?4rqsLoulNKIuuafESl0P9vgLUI/2bY/cBgNsWss1M8kPXHXOFwD585erA8U+?=
 =?us-ascii?Q?LgcE/v/G5hj8HiwYUWO3+CyOyniyMTopEVUtlMJGllM/NlkgHOTce65ay3SU?=
 =?us-ascii?Q?yWcLaxBvT1+pIw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZeIyyqdklr1HkswdloVT+0pmgVo5pTW3/mO6zz266SVJ7weg9+xIXdWlG6Jq?=
 =?us-ascii?Q?a/fUSXZZBuyeviEW6ADqf46RhmyIFRCZTId5ZNH4HzSzNNpJ5OnJgVgrYZ+U?=
 =?us-ascii?Q?QwjqVGVLjCs9P6vlvoRuVrHpgXl43NIsFi3YSPWfF3YfdXi3ui+u/E2mEBau?=
 =?us-ascii?Q?jPa1aWVMCxAn5n0tEJUr5pqcLumwDNeOQ2yvCuRhpGRldwKloz3uTnFjeoj3?=
 =?us-ascii?Q?5DdPrJkz8e6C3URxWqPB3kjObNSG4pxkNf6oO84x113xFoO/ubKtpmpZy81l?=
 =?us-ascii?Q?t9z77tHkrGCBV5WCOVPp2C8Kg8AQhaYfbGKQ9nQ6dHMc6rFnaLQFGht4QM2A?=
 =?us-ascii?Q?AvtzfC6K9n0t2TsMCqBVHuO5vGMohO6XB/5GSLUqKTG8YC/tV+JDPd5DMAgc?=
 =?us-ascii?Q?4mz4YXpsnLu9vdal23fzgYLZ4U9jdVGKXOFLze5R8VchjpAH4lrM/ckLJJ4l?=
 =?us-ascii?Q?SMV6ZXcCoLpJw2enF076MjgfKsrd8R1SrA5tRS5Kg3CRt6sA/hx4r5O26sWA?=
 =?us-ascii?Q?RKhHVYMVlvfl40xcR0zMc98WDLZ1CxasjcL2Q39Zt5S5UcZ4l6NYM6vN86BZ?=
 =?us-ascii?Q?NNqoD84cybRhkfR6wOOaxo6sXusy3tr5GR895RF6i5rMRBqR5Rb+MGPykBwi?=
 =?us-ascii?Q?09zMWSKCgjLFEXgn46812iMSEUh1xLvzVK/VPLCshyoKhPJqr9voYER22pq1?=
 =?us-ascii?Q?bH5EswwP6EuLPSBQNzHBMTa9jg0okRCNcxGlNTsnP/Fba2Jv7K9JQn9qQHb6?=
 =?us-ascii?Q?5L+6qy8kitj4KSMgIZndkwPV6yhvYP68kqAe2dqODsmtsURI8W20kFNQQhgG?=
 =?us-ascii?Q?hdddHykKc12+CcjbtLDTkuZYvHGZppmpBa2mpe4EgQBVpny2OsXGpSV3iwXV?=
 =?us-ascii?Q?SrdchKN/R+zjoJa9Zv1k005fa7ydRGeTlsne2IxD49LPYPNvB1S3xWZf1dFz?=
 =?us-ascii?Q?vbCUo9CHn7isgKBrj+5od6jLBOrOmu/EU6HgI2aPIDYduR4H132FW2vzniQl?=
 =?us-ascii?Q?FjAjYRX2OudwG3AWBDIgruH3+n4pTncaELSR8zAmJV4sFGGyZ3VdYiPl2nad?=
 =?us-ascii?Q?S69ZgY9NNCRpJ7OBFXMid5otvsYMEmvkTAKc5X2bGTKk5DcddHDAgYeB9QLH?=
 =?us-ascii?Q?j+OvhI+Ofur9fu2IDlztXZdSKYtA2nQnuldYorscxCdDv/jjAn7P3F+bFTLG?=
 =?us-ascii?Q?gIHIpxgvFtt5Ioo/Mkfs3mhQalBeq6z6BDVpsWzCRZYR9+nwc2p5YKahtpr+?=
 =?us-ascii?Q?w9KqdgRW/QqEGuqHkfDtAofbGd7fovQReOAbeZp+LOI0AUq7RwC6qT07LC58?=
 =?us-ascii?Q?Mn5PKH2EcmTrMzm4CxWc0p2Bloieg8h8lHY5QIxL2kmTG60JKhhX0fYY6w9J?=
 =?us-ascii?Q?Ozs2TGjClMqLJbjQUEniRRNTuk9Gewudxzd27ZBSwooKpy399HlA+cn9iA2g?=
 =?us-ascii?Q?GGlNNEmwW/MWeqfbjI11gMzfvc/W4w8y9mxljeZEp43G9Jzuc71RYxJMy2rx?=
 =?us-ascii?Q?IzIaM6xPSVMs0+l3W4F4MWsk+QIH6tidYqhx6pwHcSS2G7NjiOfG3O1cFzgp?=
 =?us-ascii?Q?2ec5y71HHdlxkLTYoG7Kv98kf6IX4QMfHCEvJ5Le?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f06b6c1-1c4c-48a6-d9b4-08ddbe8f9583
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:25.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY1Hryjy6yo+d3ByMP7iN1dQw92z5CNi/CFhsTPWMVN/QxKQBAS9aSFbfc9gUO2fTXTsvuAOADVEk4h5TR9R0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index d7cdea8f604d..c273a2716786 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -1181,10 +1181,7 @@ int qlcnic_83xx_create_rx_ctx(struct qlcnic_adapter *adapter)
 	struct qlcnic_hardware_context *ahw = adapter->ahw;
 	num_rds = adapter->max_rds_rings;
 
-	if (adapter->drv_sds_rings <= QLCNIC_MAX_SDS_RINGS)
-		num_sds = adapter->drv_sds_rings;
-	else
-		num_sds = QLCNIC_MAX_SDS_RINGS;
+	num_sds = min(adapter->drv_sds_rings, QLCNIC_MAX_SDS_RINGS);
 
 	sds_mbx_size = sizeof(struct qlcnic_sds_mbx);
 	rds_mbx_size = sizeof(struct qlcnic_rds_mbx);
-- 
2.34.1


