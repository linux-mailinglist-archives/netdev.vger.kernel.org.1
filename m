Return-Path: <netdev+bounces-104910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FF90F19A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43C8282736
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B576056;
	Wed, 19 Jun 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gyyciXHz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F321EEF7;
	Wed, 19 Jun 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809472; cv=fail; b=QJBRg3QWvJWTGxvo245U6i2hd2OsEOQLE42kKKLWchqfi1Gf8euRavRoEDvLBc0mzoIgiruVdUpkMuPoGvuf/vgrLtvsKVgYd739Z0PHAxsSfmM697eoGk/F5bfaefetdxtxynRlrZSs0wErP73gTF1PAecXzsI6qEeowX0UzCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809472; c=relaxed/simple;
	bh=ExVPDHtUGWy3u7SpxFHM3GGKx/VcxwiX1VQn1m75MgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBXbvP4G0aH3xuvhFjMhW10cegVs7FCmTJO+MySZAkk7aiV+MfqWada6rZdwIRBxpzqQLmnSq6Wsn+6v4bZPVOYdvz8K49iCweE/4pj0lJSLmWJKTSVtFotJJhm9HXA7eviOMryCuonCLWHL6BsV7bLytk3Hddh7CSXmWJJ5+ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gyyciXHz; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsihV2VCDmMOt0LNk8sxqopH6uw+PCVtuDouG2hV442NQdUAJpfjoglyhOW6pCMiyB72360kBJWSXV3Nxd6zBUrXMAtVSBcezG5f5R6d7WjvxuWDN+0jVnHAadO+/Xu7p5WJWTjJw1/glvpk7o36a4LQHiaZc3LrsFTmQ2CpvQ+aH9HRZQgkc4dHhQDtbyN8ymOc2Vhnk0pFDEMQSccj2B/+w3ch4vImmExv1FMQcbCkOY4hpaxEhI0wBHHvJtpzkxxi9+QgkSTZF0dgah91JW1NHZf3RYvDwqZJrgJhptfc19pB313rtv8QBTV0KOl8PzPc9MwDWJhS3d5g1RCHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqzgVaNXLX3nlZ+6G/BWRL/KCnft0RlbQItfkGwAjKE=;
 b=Rw+lblFvCLvxV6C9kPTV+lVy4O0Bkd1vv5Py+qbMhdnD+3iXlFbza6Uc7NvLxOsJ2Q5KBDzNmsVVoLntglS9WP5l1pmXJQqqTsZnbWOQdmmtiy2waCJUu5DycNeYwD6FST6cA10lZT5GXLk5LLVUYIpfQk2jHrlKAMvl4Ca1gXRM8aFWHrfC5YOOXxexMAly+juJE193809Kl7sP6/NORWBo2+Hf9QcrgU522LgwcjiAwotIFH3SUYeVbZl1+4qcIqK2P8f0q8CWYJmrFmp+OROjqiLu5mAwirqguglbyuvtrAUtzu0s3PoenInk+ZHsSRwRqV6/fLZf5LUCaZK1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqzgVaNXLX3nlZ+6G/BWRL/KCnft0RlbQItfkGwAjKE=;
 b=gyyciXHzjegDWast+bCTWys6mNo+DNCcHUxAFVEwI+FFGdeS2PPR+a6Sw9f3OO9UQAvXor5AuX3SfKUsr6HyiCBTwuipcywADFw8xYXb7fGOpnpqQ/JgZV8J0QaHbA2kmDIIvPjEfQrSybilj9nNfZWEeuzQvu9rS/wBLHWGRhA=
Received: from AM0PR02CA0201.eurprd02.prod.outlook.com (2603:10a6:20b:28f::8)
 by AS2PR02MB9930.eurprd02.prod.outlook.com (2603:10a6:20b:609::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:04:26 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::c4) by AM0PR02CA0201.outlook.office365.com
 (2603:10a6:20b:28f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 15:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:04:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 17:04:23 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Wed, 19 Jun 2024 17:03:56 +0200
Message-ID: <20240619150359.311459-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619150359.311459-1-kamilh@axis.com>
References: <20240619150359.311459-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|AS2PR02MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c1944c-2f81-4b64-e5c6-08dc90711c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlB4UTk0Ly9WVVVkWE0wY1lOMWJ5Z2ZESUVRbnZrRTRjK2pKVVFwbDgrYWdE?=
 =?utf-8?B?VHJYQzZTdXJsL0hpSjBMbGVTOHM3UUFsT3NuK25WampLc0tFMC9aWnZDMzNZ?=
 =?utf-8?B?MVRDakhxdmdESlM0NHR1dUQ0WUViNVBDZlc5U1hrbnMrTnFDUW5tRGYycEI0?=
 =?utf-8?B?c1FnQ3JKSEs5RzhQcDBlclZ6Uksxb3pHTVU2eTgvNFQyMDE4dDd2SExCaTUz?=
 =?utf-8?B?ZEZhNWxTWm5sSzBYNWtlTUZYREFrT1BoczV3QUpzK1hYYlB6d1JKTlBWRDVB?=
 =?utf-8?B?NFE4Y0xXYklBUGdwQnBtMEx0bEsyMFZVM2kwQmVNdytJY1puc2pjdVRSYW5u?=
 =?utf-8?B?eHlQcHRNOTJJYjU4dEV4RE5SZFFWa2paNUcrdTcrUGsxWE4rTm5yNlF5bzUy?=
 =?utf-8?B?MzZNK0I3ZUF1ZUZWQnlZSDJjK0k2KzdVVHFoQ3BFQzdFRVlveTBRYnBKRk11?=
 =?utf-8?B?cnZDRi85elRkazFBVWNrNG0yMXQzdm1Ia1BZQndZMkhMR2NLK1JXd3BUeUQv?=
 =?utf-8?B?cjZ3bm5UNUk3ZEhBUksvb1VKYU5ma0NIcUxzVGRSWEFpQUFqZDhsd1R1RGE5?=
 =?utf-8?B?eFR6NWNOc0dNK2wxVm5wZmF4MVZ3SW9LN1pTaHNQMjdhZnVDb0lvWDVqRmdy?=
 =?utf-8?B?SHA2TlA0YTEwZC81a3FxWDEydVNKd0EwbjFRQzlQVUorNFM4cCtpczFnSVhZ?=
 =?utf-8?B?dkZOMHNWaDZnZFh5clNZL2VadTFGSlpLNjRteWViU2twcWRKYWY5OElKVWlI?=
 =?utf-8?B?NXVqUmV4UjJaNS9tdUhieHpQWUk1L3Fqd0gvcXlhUzVTZ3oyRDJuS1FXZ1Ar?=
 =?utf-8?B?NVhVTnVrcGJQNWpldjhjbGlrZHRhR2xOVWNjUkdDYTEwamVkZ2VhY1pVaGdm?=
 =?utf-8?B?eFROeU0wdWVtcVJDa0g2VCtRTXpZSG5ReUxiTzM3UDdUdVZhRGN0bkQ4ME5w?=
 =?utf-8?B?VVBJOXhHajVNN29VeWF3RlpNcWNEZGI5dHBPUzdlRW5Id0RaQ0xrdWhOZGpw?=
 =?utf-8?B?Y2Q3TS9temE0bUdBRnVZdW96V09ZOUYycjdITlcvMU8rMGQwMEVlbXRHRTZH?=
 =?utf-8?B?UWFtbHAvZUFyREhkN2VuUUJ5c2REcTBjQm80bjhGajRlUGcwdXVDdTFuREp6?=
 =?utf-8?B?SkN5Z1lwS2ZJcW9hRndKVXZTMHZxU1BCQ1A2UVdrR3NzcEhrY3ZGRXVuMi9R?=
 =?utf-8?B?RHl5ZHV5R0QzWmE0T2Z4ZStkd3AzMlBYVkIxSE5YaVJlMEN3bkN5ODUyS3FS?=
 =?utf-8?B?TDlhbXRpOCt1OW1MWEx3ZTk2amh4V08rYmRoMS9PQ0xKTkgxM0xlZHA4TVkx?=
 =?utf-8?B?VXAwRk1pUTVRUGhSUzIvcVA2YzlrMldBQ1RMSkozQWFqeEcxSmVRazFxRVZ4?=
 =?utf-8?B?UVd1a3BtclN0NUJoSHErTVlyNjhwYVRJVlF5N3NKNkZ5V0N2UjV5RXR2WFdV?=
 =?utf-8?B?SHpXcnhabFBSMVBUQi9UQllXUEJXZmdRSTV6UVBDYmRIM2hXTS9qZ2V0aTRl?=
 =?utf-8?B?N0lmOHByZm9XbFZUOEE4L3JzVXdabElSV0VKVktlWUFrM0VRSGgwc05ub0R6?=
 =?utf-8?B?YlFLaHpsOTZ2UWpuN2ZwQlBWVURYTHF0T1VwYzBobmpuUFlIemU3NDBEeW5u?=
 =?utf-8?B?SkJ2ak5DOCsxL0xyVnZBVlJBR1c0SmhaRU1xdytzVzBPRldhRVZXYUduRy9y?=
 =?utf-8?B?S204OHk1YUhmNGZJZVBBenZsUFkrM0VSWk1Dc0duK0dSMGpNbklMN2t4MHp3?=
 =?utf-8?B?VDNTVERnaWh5WnNxQkRGUExnRkVZV0prR09HSVBmUnM2OGxLYUJCY2dqS1cz?=
 =?utf-8?B?ZnZHZCs1VGZsRUJsU0FtNDhqcVVEN0lpM3NQUGkxU2hxSS9KQ3JCMHpwWDBY?=
 =?utf-8?B?NEhSUmFuOFBPZklDaXQ3dzdqTWJPSUVsakJXZ2E3cW0wekpma3hJdUMvdFdh?=
 =?utf-8?Q?AP6LX+UORy4=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011)(7416011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:04:26.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c1944c-2f81-4b64-e5c6-08dc90711c64
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9930

Introduce a new link mode necessary for 10 MBit single-pair
connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
terminology. Another link mode to be used is 1BR100 and it is already
present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
(IEEE 802.3bw).

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/phy-core.c   | 3 ++-
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..3e683a890a46 100644
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
@@ -265,6 +265,7 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
 };
 #undef PHY_SETTING
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8733a3117902..76813ca5cb1d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1845,6 +1845,7 @@ enum ethtool_link_mode_bit_indices {
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


