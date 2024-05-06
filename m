Return-Path: <netdev+bounces-93742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0658BD07F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4991F2541E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68458153504;
	Mon,  6 May 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CyTvyzq5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56813D2B5;
	Mon,  6 May 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006505; cv=fail; b=FhP2VI8MsUcGqJkb2bN4JTh3uimBOMJkUVgDyv4bzH644/MeM8xjBl7nQVTORH2yDvirsJflRbc5FPt3W7dQ9TBnYu/8yF/F6bKKxvstoXya/GxfIOB3AnnNyACkcDf1Y4AKiJkab5QR2CmDoZ1hIs7LsEqRrLWyC0lYQVxyEng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006505; c=relaxed/simple;
	bh=puC6Cw5xCrNMwjcwdeeGTnh5+2CtzvKEf9qP8gu6EU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/V6YoKDK14cozP1dSB1ipN1yptbaGPcrK18kYkosQcnqu3MQVu6wmX3YVdU9O+VxNyVFilbfrX2a3gNyyFgANNxizqVLP4F6BvUgdwguykRtHcjVrxUzzzc6zPY3o3hQ7njewGtNPvGqHk8Tv7/U3Jk7eB/HyJsPSrlUISK1bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CyTvyzq5; arc=fail smtp.client-ip=40.107.14.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHujMI7vM+rqCVmi3ir/VXWTM20cRjoHCXU/lIsFDlkccmVmjwDCHujslkjQ8tDW/MEdkki60FgG7Ce+PvY3IBBYBof1puAqICGqPm+Bbol1+AtMgkM1RF6brdN0xx47qzcnI8U+85FhQJyqYyX9GfCCEAzdkdUAC/6eZ3JnlF7VPXmmpB2znqNhbMG8AfKFfl5oMqzJLldC/x2LGtUpYeotKnTOJIIh38IFlppjxUZHTdz+VUTTnnm8CHOI0gNLycxJNGwnWLzOxVFXZ1jDxOjaxPXUlydsrhR3yAU3GYrLmal63mvYzwSRxDdIs3vGzFEqiHd1BfjgLE0eqyST2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNBlp7XZyp2eH/hSpcqQ5vddpGpjjouZPcjb21p6Pe8=;
 b=Tz7WEGcM/k/isLrvN/DCdyDP19/XH+OdS/DCFzcZZ2qKJ3WT4sRQ3UT6HxXFdip5BTDPfOncTp7a+uPj5Fab7RrcpRrb/3L6A0F9Px1Xebc21yWJ3eNPI2GR0KTxttF/1IqPiE4Udae5pdfcZpAJq/uTsemyUb42IlrWeUVeX5dCf9g8Lm+lMq5yLvgDkN/J9AvHqwu0dIavn9zkYXMkUQ204DTr1ET3lX/WxbeplmVjJ/JhebEqRlbGcUGsWSRJ1lYKjE3VgOjRBqVxITIg5l21ds//jyx1wJbnOEc4ka2nOgUc/PbIiHR416ug9zlnrlaBHEPDdO3BrD8rMUZFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNBlp7XZyp2eH/hSpcqQ5vddpGpjjouZPcjb21p6Pe8=;
 b=CyTvyzq5X6OkMwa0E+R7V/Kz4yMbzfIIPwlaREvkPXYICg0vT/P7MTiGdW1Obs3W+DI5+poWqRs2KSSOmB86DhpYg8+doPxxYAraE6U1qkLuwuvwjJmn1j6NbzngP1xn6aOz39PIHLosAC4tsaMDgqorEstPUg3mawTJKKGQ1rk=
Received: from DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) by DU0PR02MB8451.eurprd02.prod.outlook.com
 (2603:10a6:10:3cb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:41:39 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::42) by DUZPR01CA0069.outlook.office365.com
 (2603:10a6:10:3c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31 via Frontend
 Transport; Mon, 6 May 2024 14:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 14:41:39 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 May
 2024 16:41:38 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Mon, 6 May 2024 16:40:13 +0200
Message-ID: <20240506144015.2409715-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506144015.2409715-1-kamilh@axis.com>
References: <20240506144015.2409715-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|DU0PR02MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: a016ff9a-a0e2-4d0a-9fc4-08dc6ddaa372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAdMcnEfczt8CAt1JzRNy4Hr9LEfRLmyRLsyptc9yaNgGcOqll3YSBbMksQH?=
 =?us-ascii?Q?uurEVd6VFRA6w5SRHfFZ4ubdoJFBetVAgN1fMDWi3Z1Rf7Ll8nTYWfWEomlf?=
 =?us-ascii?Q?p1bmykUE9rx/vqP17nJ348YLbFj9nxp0+ZgB4heUf/Y9ZDoPWR5AfhUQM7yF?=
 =?us-ascii?Q?wTRlG1XLfY5HJ56uNB5AOcS257JxKM5MiWAsn55705Y+FtenkPgBXM6keFdZ?=
 =?us-ascii?Q?ji3prOi+/LzRHt9Ob6EQn69Fb1zC6CrvHtA1vciPTU0LqUYlhGUT8rgvr3B3?=
 =?us-ascii?Q?q3YALDec1mrrIhNDv13kHa2S+O0viDZedpNlfuNvXzAJUJLZReeXx08RgEJx?=
 =?us-ascii?Q?JlVKayrEj2iUYD+Uw58d3OzO6lWLtaVWQL3eIb2MB5guOovyKIxsYJC/kPCP?=
 =?us-ascii?Q?pvIaDQACjNUJjFpbUKBOtZVLp73yHPHy+YPNNOjCP8Ue87gLHZnSDz5gJCUz?=
 =?us-ascii?Q?x/y1r14pZ6ABaWWYk+yfgqg14EWgCEzFkeiu4i3CzEDRbnCtFmbtpKzoJwyg?=
 =?us-ascii?Q?vTg2UQ/0Z6gYUsfY2wrPZQ7Ty9TQHd4TWXZ0fyiZFMwSE9Ni4HkAAjuRAc0S?=
 =?us-ascii?Q?AX7AnUA3MsgL6aSwwA2SMg5JtufH8jD828Fha+d6v8fIY0kFfEwhUHM62YvT?=
 =?us-ascii?Q?YOgeeeIuW7sQQqPTMamqgD2ZQC/eTE/WDDkn3ZUdc8HGKtHZd2YtWdnHf9le?=
 =?us-ascii?Q?mJp+sq2bRal8UoQ3V+d+IUEJoaglsJgUVVunL6shil7BRtoMhpWNmaRkJkpw?=
 =?us-ascii?Q?eEdqV8ypxcFTW67z+YHUBRlGQD4k60Y2Gj+Exui7xkmXvMJtpEjwPYjR16wD?=
 =?us-ascii?Q?u//oo3LehXzurpImxRTRCNBgcEFB8l7QgDKJgliI7jB+3cniQlUvnFFA0xl/?=
 =?us-ascii?Q?IWFpX7hkQbEAKLoa4Al1+Tpn3eYrsxp+mADcJ/IZUbbqxgnWoz/2EuR56N+d?=
 =?us-ascii?Q?QwFzF/JVY+67Z5qOmaVV3nGKPBPEJjeog09OzH8q3dhOU7uvVK2Y66WuJwqg?=
 =?us-ascii?Q?ChWw6DqoWSUBYPTTqld4N7nclYycK17MMCEY346HBqUk0TdANmLvkrsUsGge?=
 =?us-ascii?Q?HMr714b9Dmrqu86ruXTJ2udOX3nDtMvwAv+LSdN80BOYWfsFx74W9Ttubu+f?=
 =?us-ascii?Q?56ifr4zece3AIv2OdD8WYKviLtVoeEUTIVqjhvaN3wFBOfr37tIBNCk6g/DL?=
 =?us-ascii?Q?9BR66jsm6/GaRR+QvpWGdCchtOqZ9h0AHZierLUYmrYPZ+IZ+5MwwMAvSSZa?=
 =?us-ascii?Q?COM936BOGlPcR1g+tpSqTJR/aPO7zEv+Dw39J5VIFWcb28E94lLMDQrUNzoO?=
 =?us-ascii?Q?qjxzYzpHrn+jW7SBDjnwPwAVAPgV2VFotZwCFtcAy6RqGFa5f0WQoOHdPBg2?=
 =?us-ascii?Q?a6cXrEo=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:41:39.1482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a016ff9a-a0e2-4d0a-9fc4-08dc6ddaa372
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8451

Introduce new link modes necessary for the BroadR-Reach mode on
bcm5481x PHY by Broadcom and new PHY tunable to choose between
normal (IEEE) ethernet and BroadR-Reach modes of the PHY.
---
 drivers/net/phy/phy-core.c   | 9 +++++----
 include/uapi/linux/ethtool.h | 9 ++++++++-
 net/ethtool/common.c         | 7 +++++++
 net/ethtool/ioctl.c          | 1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..129e223d8985 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,10 +13,9 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 102,
-		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
-		"If a speed or mode has been added please update phy_speed_to_str "
-		"and the PHY settings array.\n");
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 103,
+			 "Enum ethtool_link_mode_bit_indices and phylib are out of sync. If a speed or mode has been added please update phy_speed_to_str and the PHY settings array.\n"
+			);
 
 	switch (speed) {
 	case SPEED_10:
@@ -265,6 +264,8 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     1BR10			),
+
 };
 #undef PHY_SETTING
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 041e09c3515d..105432565e6d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -289,11 +289,18 @@ struct ethtool_tunable {
 #define ETHTOOL_PHY_EDPD_NO_TX			0xfffe
 #define ETHTOOL_PHY_EDPD_DISABLE		0
 
+/*
+ *	BroadR-Reach Mode Control
+ */
+#define ETHTOOL_PHY_BRR_MODE_ON		1
+#define ETHTOOL_PHY_BRR_MODE_OFF	0
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_BRR_MODE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
@@ -1845,7 +1852,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
-
+	ETHTOOL_LINK_MODE_1BR10_BIT			 = 102,
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..5e37804958e9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -98,6 +98,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_BRR_MODE]	= "phy-broadrreach-mode",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
@@ -211,6 +212,7 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_SPECIAL_MODE_NAME(1BR10, "1BR10"),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -374,6 +376,11 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	[ETHTOOL_LINK_MODE_1BR10_BIT] = {
+		.speed	= SPEED_10,
+		.lanes  = 1,
+		.duplex = DUPLEX_FULL,
+	},
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5a55270aa86e..9e68c8562fa3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2722,6 +2722,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_BRR_MODE:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;
-- 
2.39.2


