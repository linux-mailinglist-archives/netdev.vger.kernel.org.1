Return-Path: <netdev+bounces-109231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A037D9277B5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F0E1F2749E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF71AE873;
	Thu,  4 Jul 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XWwn3CiF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC491ABC25;
	Thu,  4 Jul 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101894; cv=fail; b=lW6WXKDCh/Cd+wmJmSG3kEoUQ/Hc6TBGwbitwvFd+4tWf39qxcu5gq0KJBxT1dmSOnSZ9sQCoiNvpJEEHtd7X3Kk1w9DBHsPUOJkauIUXfYUQXKGmOwXBC79Qh0D6HdBld2+MBmyN1IKwBtpbiFKZFvNXkMi2YF+OwJTxzEren0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101894; c=relaxed/simple;
	bh=rY2yN9ZhJccZa678cRD8YoBWUIqI4x8dUEU6EmR2Ye0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEqKjjK5c89W558mqw83szswlfOzXdFFjjH4K4M5NtxrYdLjMRJZSUEBCHcn7nss1ZQFBER8EQwD9ACoY2NM241NC/U7Wp+tGqpRjdw12CwjaTquiyMQgVbPeDs4Sc7bY4UtJ3rAnsS5FLlQ5DyOGwPc13wIPbp2u9IzI1VpzEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XWwn3CiF; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5w27ohzZZuVDjfdQ0JH4QXpoKAlUB8NrzacRLDsWHkJfX9WJucEWyu2t+TCPm+vERDNFdxoclqg1mzB2BUQRjAcckaeUskHJiHZygKSad8/LsxnYsqrT0EXklRk4m92y4IOMgdvrcI67RdkfNKOCnM4CoL4G261fIcDpcYRZPHAKjYdkg7y6vOJrGKa4hWaRtHgX+qW3i77jLjJdyit7PY3r0Y0rUtx52AKqterH3rLpJzWzdYBdUeaw6AVxkuYbqujrGQNHq27LamC8vsgkPPSwmJuEjYxPQjH8gKdZ5KUgTKHdDrbVb3jFPPocQkBQije67OqbZAvD5t9fUfDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrzxF+efmd49eXzkBexWj4ZUsr9TZMniEw4M8z6Onpc=;
 b=fHleo9iFDvz0iSEV1WeJjhRQSLrkrLsJ9WYZ1ff+Jy+OW3l258TKZBJUqxCIAT+bR5kg4SrEaNC6giR+H65pnu8eBR5uh+rhZTRwBHlzbw6OOiDdOjtovVUGNnvBxGcZ9u4BSI9B3FucH6fuN7fCd8kkysKerSbJr01cBpt/+YrEl+xt8SQNVyp2cC/s1iPy4Nmg75VhdkLGMoRMV9cXUlAl+K1DbrG6JehNWHNZBucYJJqpdn6W7LF/CNhGx8JycVLgRz05lD7OREEMEfdPQV+naXOiz0KfKfFZEBQyOisBughkGbNeQ5Y80aYmsxGllwfnRmn9BNWbLUI8/9mLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzxF+efmd49eXzkBexWj4ZUsr9TZMniEw4M8z6Onpc=;
 b=XWwn3CiF+68lM+l9yDv+P8acgVreRNy6PsXmrTqzke55w7l3VpY6yvIzpEpIUHNNR9O4/fK62j2fwnXz9x31AE33w+JN0OzNxUaS/jFN58h1r9/sTDgCm87clVKou+mPdzwbmCVVu3OMBXmaCGcWvOFERfh4Fcd8/TFeDCCs+Ag=
Received: from DB9PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:10:1db::29)
 by DB9PR02MB6874.eurprd02.prod.outlook.com (2603:10a6:10:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 14:04:49 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::bf) by DB9PR06CA0024.outlook.office365.com
 (2603:10a6:10:1db::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 14:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 14:04:48 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 16:04:47 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Thu, 4 Jul 2024 16:04:10 +0200
Message-ID: <20240704140413.2797199-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704140413.2797199-1-kamilh@axis.com>
References: <20240704140413.2797199-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|DB9PR02MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e2b649-bd0b-472d-9414-08dc9c3243e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGtjVGVUNUNKNVBNU3Z4QWs0NzVYbHJHMlpYZW1VSE0rQ0VTcWhSbVE1ZjB5?=
 =?utf-8?B?K2tsTEc0SGpkNCtBdENYVkNBWVhoMUlSUksvQWt0QkJUL1F0eTkzUTFUTytJ?=
 =?utf-8?B?dXVFMjhrQm5IU1pNYTZDUFZ3dS9jZUQ2NzE3VjlGejVyb084elFla3dyb3dV?=
 =?utf-8?B?NE13TVNVczlPNjRyYnArRHNxazRWWUFSK3ZHeWVGOHZvdGdYeDNZTENBNlVh?=
 =?utf-8?B?RzMwdkNsazNuMFZtdSt1MldUcTk2KytVYUR3K0FsWW52QlQwbzA2aWUxcE5V?=
 =?utf-8?B?UmUwK3BXbE85Vy9rZ2RTR3k4bVVvNWVLaVdaRHNNZFUva2hVZjZXRXViM1E2?=
 =?utf-8?B?K2h2TzUyZEluMzFBZk94MDFDRzRWQzVhb2JKYmhVNEhoZmJrQWxxT1FhZVFG?=
 =?utf-8?B?Tm9RV0syaGUybm9FYjMvVXpvcEYxTlhGcGhGR2NGaGNIYWxKZStIbVd4eVcx?=
 =?utf-8?B?c0EvaC9jeVpXSGgrWHpUSzNPemV2Yko0dytCK2M5aWR1TGFWSldJTDhUbmdi?=
 =?utf-8?B?YWZ3OTJsbmpiNVJvR2xXaFl6djkyVkczSERqQmJyUmQ1Z2tQWkpXM3g2aDFa?=
 =?utf-8?B?U0FkN296bFh6clNIZ1U2Yjd4U3pkMUZTRmovazFWRkNqN1NkaGptV0J2QUdv?=
 =?utf-8?B?bnFvZnU1d0ZpTGJacm9hQk5KYkxlMS80QlVBOG8zVjNhcVA1QS9MTUN6U05X?=
 =?utf-8?B?endlZGsyb21SNUJ6eHhwNytxQzZ2ZEluSGtHcnlKbklnUHB0US8zMEpkM2xO?=
 =?utf-8?B?QUFEM1pTak9QN1NnODhDU2ZEL21VYjJocUd1cFduRlhPODVYMmtXTHkvZFA4?=
 =?utf-8?B?Z2V5NHBsUHRpOUtPWUYyMndoOU13NEpDTmY5ODBKdFFzd0UrSUFmOGNWYVh3?=
 =?utf-8?B?dU5YNU16WERtbE4rTGREdnFjSnAxd2lpeFN2a3l3YmE3cWVGcEVUeWFpd1Ax?=
 =?utf-8?B?aTltOVFqRWFRdXNxMldWTlBJbXdtRGJpSnJBdDFXMTJJNVhvMTN3Y1V0cXkw?=
 =?utf-8?B?bGdoTThqZXNQamVvM1B5WGhNSGNLT21nSjZsSG5TdWVWcXE5emE4OUM1cjJi?=
 =?utf-8?B?QmdKd0RpL2wvTHNpell6MCt4YXhxMDNxdjU3Sy9TNDFhTkJ6RkI4cHBkS0Vt?=
 =?utf-8?B?elR3OGkwaGRieFhkS2NrUEZwdzJDMWM2UEwveFcxT29GK29NcnA2cmNDNEJU?=
 =?utf-8?B?RXFHbmdpRGhSM1E2cGQ3WFZCZkpBTklocU9TaE1JMTZVOE8raGpVN3BPMmVU?=
 =?utf-8?B?dmNyclpwVmg2YU5uazlzUnRWRERXZ1VMVGtuc1BVNSt0VTRkb09tSENRSTJ0?=
 =?utf-8?B?TnQ2VXBhbnBYckZDWG9wOHlXVXlQRHJteTlWeG43YkJyMHU2TXVnWjQxM0Fp?=
 =?utf-8?B?NlZQc21tc2kySGRGdjkxR0xTVlJ6VEFudGN3Nnp5TldqaTBCTWFwWE1Pd0RV?=
 =?utf-8?B?M1pLYm1vaUJ1WDY1VmVyY3c5TnFNcHA1aW5WaEdqUUdsOFJCWmNLNHBiOGox?=
 =?utf-8?B?SjluMURzelRyQ1d5NXdNZ0RONmE1WFcxZ3UxOFJaaDJvdVVxRWlxa2Rxcjha?=
 =?utf-8?B?M3drQ1VLYTBYcGhLQlZyRzZ4TC9LSXpSc09lRS9xV3BYL1JmYlYxdmR0UlB0?=
 =?utf-8?B?bkRLR1orbStsd01icjFRR3dVK2owWC9oUzhHSFVDUEdkS3A3NjNSNW8zMkFz?=
 =?utf-8?B?Qmw2SkpxTmFGcmZkNUtYLzZTV2x2MzdibHhLL0prOVdqb0Y0aDRUbHYrcTYr?=
 =?utf-8?B?eUZTTVIzWDVybG5FM3lHYmRpZ3ZtQjc2RXNDYlFmZlBnUENMMDlMcTRWbHZH?=
 =?utf-8?B?MCtmZ0R2eTZlM3dLOFBGU1MrTWlYVEp6MUx2NHp4U0RkaU1vZTUxSWJGT2F6?=
 =?utf-8?B?TDU4cDlQUlFMMmJINU8rZk5vZzR2TDU2WSthRFZxYjF6THBRQ0dVaFZyRXJr?=
 =?utf-8?B?bzdCQkNvRS9OK3g1WnE2SjBJUXVPYmJwdHQ3R0lxamR4azY4ZlNncDlYbVdn?=
 =?utf-8?B?RDV5TWtsYnlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:04:48.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e2b649-bd0b-472d-9414-08dc9c3243e8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6874

Introduce a new link mode necessary for 10 MBit single-pair
connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
terminology. Another link mode to be used is 1BR100 and it is already
present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
(IEEE 802.3bw).

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy-core.c   | 3 ++-
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index a235ea2264a7..1f98b6a96c15 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,7 +13,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 102,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 103,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
@@ -266,6 +266,7 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
 };
 #undef PHY_SETTING
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index e011384c915c..54b31344961d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1863,6 +1863,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..82ba2ca98d4c 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -211,6 +211,7 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_NAME(10, T1BRR, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -251,6 +252,7 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_T1S_P2MP	1
 #define __LINK_MODE_LANES_VR8		8
 #define __LINK_MODE_LANES_DR8_2		8
+#define __LINK_MODE_LANES_T1BRR		1
 
 #define __DEFINE_LINK_MODE_PARAMS(_speed, _type, _duplex)	\
 	[ETHTOOL_LINK_MODE(_speed, _type, _duplex)] = {		\
@@ -374,6 +376,7 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
-- 
2.39.2


