Return-Path: <netdev+bounces-105674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F95912399
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB51F28524
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3917B4F2;
	Fri, 21 Jun 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Pg5ie7NZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24417334E;
	Fri, 21 Jun 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969247; cv=fail; b=d0WypsbEutFW0ke4W1SOOWwlZohYMxS8K09a9wNuz5Q4fEGVq1Be+vGX0jA007DEZlLnye77pzZO1ODVbCskYG/QfHChnKgR7GZZzZm9qEoNEvrUf5OniCtYyBPldcG6MhBTTzN6rVduNjud3T9esMJSp7YQEVufF1VUZ4yznhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969247; c=relaxed/simple;
	bh=oX7HVXb50EaDbTKqkKeZvDDz9wl8L1+Xq0DV7DzcH9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMnmQezgDXkpqL7/kOOeCIqwR1Eny7vkAyWC/iXB0N+kKeBXG7yEw/HCVMgmjMdVsc5URIuq8UeiIq7s4dH8AVQz9V1Jtvmy1tyd+4jEEEPbLFtAzo9NM+YwLM3/PDDFGawM45zngmi7cnQveVHyxR91Qke2kLAZop6nxdvKg58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Pg5ie7NZ; arc=fail smtp.client-ip=40.107.13.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKr6nch+pQnBC0btOndbUknE3McS+1wV27dver2t+IuUPLoFNFbLRzlEdUx6zy7DC5xXtXr1pP1NYb0WcwS56j0Rbyms74s6v2RrE4hMM7zfeCXIZf//wDE7CTCwxqFpHNGLLfNW1/3cNmq+ahvTwgkQ3Tqafb36fk6mE07xWhROm8h4ms0hr3aZPd/xRcMmjyqCvo9iSf8ZJ0aWhmlqbrJiLiCI32jYiVdGFzms+lXI+D9/1tZ3tTiqnwEe/rSCKAKIDfyVVHV9ruFUFC2YH+ouk8UEjrMVgmNkEkmiomQ3X+/QCVguG1sPbgWKFeKXT4C86QgrI3rh9zLKTKg1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMRtStTVPn/nr9tAGPXNUWniEQgDlSjDakr6EDsd42E=;
 b=VSS+Wx/R0g0BhDXXHtDubY9ZrnJkRuiSOww95/4ASmwvDVkB1kU0J6k8YaY5e1onXFozqnmQm9QGK2YOl4QS2Wb8KUQRJxy3gYZeg9BIoXmSzr9iKHe/TpWvXRSr50N2b+Da7A0UbTUpUDg0N/L3RC16uWjHS6RB+ifgLKSw8BZ8ciHCXb7h+lkkiDqm9C0amA1gI5pw9Jjb5VDTGxvt11eZhs9aaUvzuqjviUA+gE/JKjrxfehu1rvaYADkDGaMJKA/GxAa/VtIJsPX1bHqHqzCBxAGlKX2rAD1SeMcOZcgeNO785bbVR602zwus1o9NMocfSBDPTaYrJKVNDG19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMRtStTVPn/nr9tAGPXNUWniEQgDlSjDakr6EDsd42E=;
 b=Pg5ie7NZ2iZakdhNaCoURTIxULJk5Fhjg0OfbMzKHnp4OMBpq3ouXfQDSZTQ0NP7rM8TpLaVypbvVQbqjEGjpTZtTCgIwVLo8ifsJ3KTYKfw+7sLrPPycqgpOVGvVqCDASIkeC2H9KFFyXNRFYilrmOd+UWmMZ9xO++4kOti5VY=
Received: from AS9PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:20b:467::20)
 by AM7PR02MB6129.eurprd02.prod.outlook.com (2603:10a6:20b:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 11:27:20 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:467:cafe::25) by AS9PR06CA0143.outlook.office365.com
 (2603:10a6:20b:467::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 11:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:27:20 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 13:27:19 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Fri, 21 Jun 2024 13:26:30 +0200
Message-ID: <20240621112633.2802655-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112633.2802655-1-kamilh@axis.com>
References: <20240621112633.2802655-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM7PR02MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cb2912-d962-44f2-b63f-08dc91e51d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|36860700010|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9QQXQ0L3RIaGJjRkpHQjhpNVU5SEtmejNSd0VVUlJEZUhkWDZPazZkMHEx?=
 =?utf-8?B?eHBFMUV0UzRTYzVZbHlSaC9objlNQ0ZtTDh0NkI4R0VRczl4djBiZWhrVkc3?=
 =?utf-8?B?L05HZFYyWXNyNHg5THAzRHlSODEwTDl3Y2M3R2VVL2x3enFDMTlKZ2NCNzU5?=
 =?utf-8?B?TjJNT2VJRWJESTA5U3czZzU3S0FtRHp3NDNibDE4a0Y5elBsV2I0WUc0KzFz?=
 =?utf-8?B?c0E2Z2FISHFnUURLdzB0cHBoREp1RG1JbFVXc1BTTEYyNmpaeUpRcHpTWGlF?=
 =?utf-8?B?Vnc0aFhrS2RQYnhKN0grVzhhbEZkU0Z2Y1o3V0sxaTlZK21OM1ZlQ1BteDZ1?=
 =?utf-8?B?aUl2SGxpYXE1OGZYSjVCdmpkM09LWTlOZ05CWG0rd0xxMHBwWTZiZkdEek9C?=
 =?utf-8?B?bFE2aTliQlU3cWR3OEtvMjlzQUV0eGZaMGEvZHJta0xQTEVwVUY5Q3diQ21Q?=
 =?utf-8?B?YUpqVlNXMVVQcXpzNXpTUVpsU0lFVmNuQ2pUdHZwSCtrK2NrekhzaFREWXJr?=
 =?utf-8?B?WDRVbm1Va2V0bzN4bnBpNmtSQjM0M0lKcGg1Wm1MR09GOGtwbzJ1QUFiR1JW?=
 =?utf-8?B?TnRCYVJMUFdiZDFFTTJWSC9oZ0x2V1JFVFlFZWN2TkQ0blhJdDVRZzIwY3ZG?=
 =?utf-8?B?YXduSTRhWU9menVobTZ0ZEtsYWFKc0VROVc2emVXNTBVYlhLekw3TFRlNG4w?=
 =?utf-8?B?alFDYTd6UHg4WGptM21zNGNhWWRTc3l5OWpUS3hRMmIva1JhdklSWFJ5dkk2?=
 =?utf-8?B?cU96R3B2QWdRV1RvUGcxVUttZzJKenplODdwZ1htZEVmMjh2aGxOcDNhOG9I?=
 =?utf-8?B?TXRaTFQ4QWltQXREZk0zNTBSRVg4T1k4dmFFRklPbEkwQUJEb3hDSHlCZUVw?=
 =?utf-8?B?ZDROZWRJaENvNzhnMzZyK2J0SU9EanpUY1RmbXQxaDk4ZzlkRFdJMEVhL3ht?=
 =?utf-8?B?S0pNNDM0TDBvUE1EYzRLSlpveHdLYVVYUzJDZjlSWkFydnNmc29sdGpYNCs1?=
 =?utf-8?B?ZzlLL01nS0Y2MFZsY1hBa25zajZiNE4ycldjMG9JSzIvMTBWZUkxYXBQMGhT?=
 =?utf-8?B?LzMzQTJHUVpGSjBBZ2RLVUxIY0s5S09kWnJrVm5yUDlOSG81NENjVEVPSGcy?=
 =?utf-8?B?MytjVmlYZG5QRFNMOVF2Rkg1MkVoVDJYWHlNR2dFU21xbE93aVRMSmxKVEIz?=
 =?utf-8?B?L2d6aC9tK29pWFhnT0htTk9sV0VibFh6VHF4cEptdzdDbFY0cUpqY3FOQ1FU?=
 =?utf-8?B?Q3c0MlBIdGphSklMZ0NYa0ZCRG82R0ZWKzl5eXFkYlFJdFdkUGtCeExUWER3?=
 =?utf-8?B?OUVXdi9IZk9TT2ZvU01rL3h6L3lpRWV2d0pRaGpMdE9NVnl1UENqNFdSYWtt?=
 =?utf-8?B?b3UrT0ZJMEdCK0RaclN0NnV6UExzcTQ4MGQxcXhVN0wyUi9Jbm9oQXk1MktP?=
 =?utf-8?B?TVl6N1NYRlYrZWlvODVZR0dDT2ttSU1LVkt6NHAwdXp2WUw3NzVZcEVTNzBV?=
 =?utf-8?B?cndYT2FwRFBPUkFzQ21RdUp0RDl1OVdqZm9LTks1YytzeGVpTHg0am5UcjQ1?=
 =?utf-8?B?MncyVDZBOUIramFMcnlTbVlOZ1VHNkIwLzY4aVpyQW9kV1kvOXFMTUJ4Yjc3?=
 =?utf-8?B?M0tjTmJzcGFpbVE0RWtmTnJSTjdlTmRoYWRXWWEzSGQvWlpvcE5ST3BUTFYx?=
 =?utf-8?B?L1d1NmVYMGZqWTIrV2U1dHJBU3NWRXExS2Rac3VTNm1uSndqUW5uTHFPNUl5?=
 =?utf-8?B?bCtYQ3kwR2FSaFg2dG5kZWJtZERjZ2l6WE9EZGdjc3Zld0h0UktXNkZvS0Fu?=
 =?utf-8?B?QW9EbC9EbUVWZEdXUnRWNWFnWDZUWXZtTndhdGVZaGRtU3JkNDdrRHE4VFlL?=
 =?utf-8?B?dCtBemRJK2ZUMmdYWDlxelRNTnMxaksxdVdvK09yS2VPN1pXR283RkpZb2hP?=
 =?utf-8?Q?vYxchwhL+IU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(376011)(36860700010)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:27:20.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cb2912-d962-44f2-b63f-08dc91e51d5e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6129

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


