Return-Path: <netdev+bounces-100590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86D8FB3F1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CEF1F23017
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75D148312;
	Tue,  4 Jun 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="b4z2I7MJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD753147C76;
	Tue,  4 Jun 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508242; cv=fail; b=QR5vAlPkVDmYP/TmtnQRHMcm/gXUNMVK+d5/lzbVniQGATnWCDSpunpgRwVlIApGf44DYdhPV59YNTBjAkVmpmtzp/e3IIKeolGmh1F7eS0m+oh+LxloClxzh1lRKVBOy+n0Zz1zqGpBrT/wkXA9+pAC+iZqTmWTiyJtXQUs+98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508242; c=relaxed/simple;
	bh=AZ06KBNE2fF/6w81AnnwMxflls9XuUXNo+5aPZow2DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0sHWuzo24dmYsll7OM+htP3JIr02JXqoE1CFqU/wxZHzkrVdPhsqFIZSEV9PSxdMrhYaZ12YtlUJE0gpKNUx8qVVEuTD5dFASZAynZrWxGwEeshDhg6pU1myF/j9gi8paEnz/D07ckZ69KjTNHKVdAMhZaddM6TfW/JNIF3aL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=b4z2I7MJ; arc=fail smtp.client-ip=40.107.8.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQH9qZ4IZsbYw3opc3ATTRKyElj2QuEwqoQqdAVavwmon/cW1w2jR0s7aRYzTxDnKPsiwiFDUVOO5btAOS6uXlAJDG9vMzIG/TMwBVpGM0gKf2HUY6P24uMKHUkI7+fbS8GHPAqr2wa28mhSpstfD2FTzbQqE7Ro7rkEaEuC/1lWGPY/QpozDVqd6K4vuISQwz/zoNYqzcivG1A6seDUVGdHVJr5+ayBbFyEaMD0riWesQwFBuLHgdkKXgaaH3h454abXixh4+GYkuEzqMJlyUJ/nwlaYxqTNiotlMv4/yPy6xWMpqiQGpNXXct+cwC39qAoAkcUIYvAg0FbDT9zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=M/DGIZtDUHYFSaCqIAQLp/X+JR5MiZiPJjw4D02LX0LI0N4UUhCzUZY3R4AuPpz5TnIRjbKGKJQIsURAsVseCi3sXNRSC0AeM4eJ6H5e9pCGxVbAP8Rv+VIv0mm70aZWcc7z5diUZc3lq4uzRAmNlDiTyMsYD1Ps3OYCKBBXzDlCL0khE2EZED8Y+o47VEApxC+8jL/hAR50Sl2CtXH/1Uce5C7iwCcp5iMVYdLkIP9iEeWWcloANVKyDMDyY0d9T6YAQMbBFypK7lSsbreAYn6wz6KXFj8xo+IH2zV2JPabmrT57un84LK516sGzDW/ZfP0GyAvPFQDUiDgCVXa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=b4z2I7MJMCSBEMT4gT56YDDOPinQA93U0c3lA8ajMEceQO9umOr357yt1thpFt4A5k9/H3Jagjrg2UHxPom3lwqmyjFMiQJNi7Scxt0rievxvFsOGs2cWrnI6yxRPq9PztsadelhnCij35XIftViz76aEKrGFfMWZUYAKNSi2JM=
Received: from AM6PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::20) by PAVPR02MB9569.eurprd02.prod.outlook.com
 (2603:10a6:102:305::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Tue, 4 Jun
 2024 13:37:16 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:3a:cafe::98) by AM6PR0202CA0043.outlook.office365.com
 (2603:10a6:20b:3a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 13:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 13:37:14 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Jun
 2024 15:37:14 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Tue, 4 Jun 2024 15:36:52 +0200
Message-ID: <20240604133654.2626813-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604133654.2626813-1-kamilh@axis.com>
References: <20240604133654.2626813-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|PAVPR02MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d8804d-8c8c-42a2-7be5-08dc849b720f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEVYUTZWTjhOT2l1Umplc1FRZmJ2YitSZ0ljUmxSRkNKMFJabTlSUDZqZkdI?=
 =?utf-8?B?NlRlK0NtWFRXd0I3Y2RJVzJnUGZvMnVqblJVRzI3MDBjVWdkZ2ZnaU1tVE5U?=
 =?utf-8?B?aEJlMUpSMlkxVWVXc25UMUhzQXBCdWkvd0NqblJ3ODVuZFRKZm5lM1VuTDJV?=
 =?utf-8?B?K3E3OXBpd1BvMXVOWWQ0OEN0Z2RvOGw1c1ZuQ3NTZlJkOEM2eDBtNkRUWjZH?=
 =?utf-8?B?emlrd045Mi9NTlZWT2dya2NIUUE3cmVnSGxRS0ZpaUdPcUtsWXNWNTEzWFl5?=
 =?utf-8?B?UEdBVjRrcGFZcWNCQVRSVjBVOVluSmEwaW56YkdYT0NxYUUxcnYrcEI5K00y?=
 =?utf-8?B?NGdjNjJYL05aQUtmM0FWZWhaeGFKbUY4dzVtbC9leUhDTlhXUzdWdEJFTUh1?=
 =?utf-8?B?akVXVElpd0lOWFFiN1dEWjhyNE5LYlZJTkp5Z29aVjlsUkpqWFpyVDlXVFVq?=
 =?utf-8?B?NE4yeCtqQlErZGZucmJNdkZPUEdQZWVqYTY0cjV0N0wrMGhQQWpVcVFsOWZ4?=
 =?utf-8?B?UFF1UCtEaC9NSnVYOGZYNm5SRVlwa3o5Z1RtaUVHcVMxclMyN1V6TjV0Qktl?=
 =?utf-8?B?MEZuOENQd0xpcjBxWmQ5Tmx1cHVaRUtJMjJocHlJK29YUURBL2lYWXVZQU5v?=
 =?utf-8?B?TnE0MXZMSy81azRTWDBMOXdTWTRXS3NyN1NUUmZ1SjJ3RFVsVFZ1dFdGV1R4?=
 =?utf-8?B?bU51cGJEK2tROFJ2UFEyWWZLc1QvRWdHSURIYWdxN0FhVGJVYU5zL29ZWVVh?=
 =?utf-8?B?blNmcE4vQmpiNmJUbEVpZGMwZ3psYnU1MmROYmlKQWxKYVFJYXFkSjBLWDg0?=
 =?utf-8?B?V2RhWlRNRE04TmZKdHlmZXVLTmhoMlhNUVhxbGRvbHBkVEJVNzhoRUg0WFVn?=
 =?utf-8?B?ZGYybFUyNkt6MmlTMmhEcGZ2MkFnWUxHVk8rdWRMZHhHNTROUEJ5alFNV3Fq?=
 =?utf-8?B?YmQ2elJMeUN0K1RJTlF2Y0FWb3hxdENXZTgwZ3BuNnV6L0pvbXZqUXhwZm9H?=
 =?utf-8?B?K2s2RnVmM1djVy9DMDZBdlp6MUdYcXNBYzVxaG9QczJoSGdObnIrekRaUVBy?=
 =?utf-8?B?dUtxeUtNcktsMGY0a0VpcWoreW1WUmcvQkRrblBVNjRJM2tLeVptOEVjZHZD?=
 =?utf-8?B?ZytJMG42TWx4OGlxNVN1MURxT3JtcWhrYXk3NXljQ0tiNkFHemh3US9Rd3Mx?=
 =?utf-8?B?WUtKNXBJZGtnWDdieTVNeTdXT1BZall2TVYwcEl6MFNBdUt1Wk00cUFnYjJq?=
 =?utf-8?B?ckQzbEM5WjlmODdmVnM1TW83cllvcGhPelFCL2hQUXpWN3htWW9IYy84RklQ?=
 =?utf-8?B?TGc3b1VPalF5NncxTiswaXJYK3Vqelg0eWZ6YkhQOThCY1UzblR0N2IrUnpl?=
 =?utf-8?B?NDBSSFRTc0hzTWllRnhEbUR0ckwzcmNMNnhtL0NSM3d0VkpzenVxRHJkM3V2?=
 =?utf-8?B?eGFWMldBMHJUN1Z5QVZoVkxjTHJmYzdnblAyVkt1NXZtdHJkUTNnU2c3ODlT?=
 =?utf-8?B?Y2dXeFpqQlc0VjlPUU9yN3VWVkJQTW9YZzkraWs1bjhRYXpMVHVzdkkybmFB?=
 =?utf-8?B?Rm5IUEd6Z2JsTXExTkFXcmlFODl2eElENkFmRlFPOWcvS1ZtdjZ0elJ6MTl0?=
 =?utf-8?B?aG00RmdOVDhBbmF6ZzlhNWxDVnF3ZTNNTU93b3N1ZzRuLy9yWkZjWGY3R20z?=
 =?utf-8?B?TW1lanlGUHFYNGRLWXV2V3lMSE5tSmNKM2gycFNtTHdQQXVhblVyam5PN2xH?=
 =?utf-8?B?cVBSRUNtT1NwRU5WckpVTkEzZVFHaVBhQ2Y5cWF1YzkySXU3eG02Q1REbkUx?=
 =?utf-8?B?cWNTUExkbTUrK2YvSzRWQm84V3crU3RUcFBGaG9qSzlqWVFVTWpHNzlTcGF0?=
 =?utf-8?Q?T6+7yRQamvUnK?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:37:14.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d8804d-8c8c-42a2-7be5-08dc849b720f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9569

Introduce a new link mode necessary for 10 MBit single-pair
connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
terminology. Another link mode to be used is 1BR100 and it is already
present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
(IEEE 802.3bw).

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/phy-core.c   | 1 +
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 15f349e5995a..4a1972e94107 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
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


