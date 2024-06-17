Return-Path: <netdev+bounces-104002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2B90AD28
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EA22859E3
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFFE194AEA;
	Mon, 17 Jun 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Dj9GEpuF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2062.outbound.protection.outlook.com [40.107.7.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B51946BC;
	Mon, 17 Jun 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624472; cv=fail; b=ufGqcboytk3PsXQkxGs9PP1lSs1Hr+vlY5yWxMMsspAHzvEzLxim++utdLl02THNM/+4FNlebeT8xmW78+aA6kTopvYEtibd/RhZ5gN2tw8lhtc8Rr2xTn0Qo6kCnl2Z7lo8nPW1EJuzwLQvMDj8VrwCR6MXvgxapeWPglhm2TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624472; c=relaxed/simple;
	bh=ExVPDHtUGWy3u7SpxFHM3GGKx/VcxwiX1VQn1m75MgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcIhtNqqTNBvwLQW8MpZWI3j6hDehYzVPwQee/kI5TAsTCeIRbhnE0/OpXeHcGbwiHCwS9Rcb5z5BhdqsijUdF7m0S6Wgt3aKz5T6E10rdKo1MhnZZkrYoMkg+DNhACBotZm2BaCtFl4zC3+5On7kziBpw/8Qqiw8SBZgYxRmnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Dj9GEpuF; arc=fail smtp.client-ip=40.107.7.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EADehsn0FExaLYSN1g7Tv/vdZiCc4/fAw2hzKmE81LtIAKb8UV2OUKD5RHaO+in5UT6zGvq4cLlI/NYfYofcuCT1PVphYl06yl8hCfT5e+0dLJJkTFsnjxUSA7lH0FEAiBgJYMO5N2xlWI3Du1tHBo6ibcT/Wz8vWD/NpvtZnCGOOfbG7EkRUukW8vOIAOYA5IGdGIebjfdqO9cg57U/OvO2OGB2Ml7wuYxIVD4pgbcYZcxTNUIecRXRBNZ/TDiL0ExgCQTIRN0TmUnhPu17FT+J6jeH0iIVksTIOlU0wae2CJEEKeqUhpXifopGsvzQiaqpfiBJiAyNex/ootfkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqzgVaNXLX3nlZ+6G/BWRL/KCnft0RlbQItfkGwAjKE=;
 b=H7mc4KPf4IJQPiAk2sZ23AW7wNuaG5frIOWW28oNIXVSfKhUKUnOETRVWpGyu7BeJipAmT3MalU25RG/w3A9iIyalWMly5YYMKFj1p/BTX0/3y6pOvuQ/hMWfHY/7luUg62h/F6H9NNjs2xXK+8Ed/VcmMBpgqAWWHaqsWrTGXdG/IObagiXZgccPA6QxioAyRXaSShrPhhylvUX29iqdfLMXvS5tKDTL7qrJe+X1HxSuTj3uCgFoPfmXw7VGw6fuNChNKzaJ3WIEG4U1Ugpqs7yuhaQqFUxgQDmk64X2KpwFVz2qz9Qs304C/oJZsryYhDGkOcvgVXOB8Myl4dKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqzgVaNXLX3nlZ+6G/BWRL/KCnft0RlbQItfkGwAjKE=;
 b=Dj9GEpuFOH1lZEPb+bzsip0cLgeknHQepjJ4GQcc1AMhfox28TsMr1WeqZ3J3O5s0uhBxEwwE8+9S9Xfg7zQOv5Q+hFmmj918VhKGa8mgC5jIDrO1iUaN+T837RQoDNxbcVC5yhZy31eIzKgYBO5hrHWm5dAcKeepW+vNmPhdxQ=
Received: from AS9PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:20b:462::17)
 by DB9PR02MB7307.eurprd02.prod.outlook.com (2603:10a6:10:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 11:41:06 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:462:cafe::1a) by AS9PR06CA0013.outlook.office365.com
 (2603:10a6:20b:462::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 11:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 11:41:06 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 13:41:05 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Mon, 17 Jun 2024 13:38:38 +0200
Message-ID: <20240617113841.3694934-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617113841.3694934-1-kamilh@axis.com>
References: <20240617113841.3694934-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|DB9PR02MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f68e31-7f1c-4410-f062-08dc8ec25fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTY3MXQ3eUt0VW03OCs0Qis0SDRFS1FEL0c0RzlUTmlZRGtmNGxhYzI3c2Ju?=
 =?utf-8?B?K3ByTjNjTWUwbUhyeHVHM1I3QTZCZ0wwWkFKd0dUK3c3cGtGOGtCVlJkSjJt?=
 =?utf-8?B?cGVzcnJQUk1tWVRFdTk2Sm5LSTNDNVRrVElaa2JxdmFoQjZnZS8yMU5HU1pS?=
 =?utf-8?B?ZWV0MnhjWVFRU3ZSU0t0ZlI2M3ptYWxza1lKZG9TM0d1YTZ6U1I3OVpJcGd2?=
 =?utf-8?B?MVk4bDgxa1N5Qm9rQTQ5VDhOa2JwNmgzTkh5aHpzU09qbXpkUGg1ay9YUjB1?=
 =?utf-8?B?ZHhkYjdvZUJIOCt3UzVzRmJKL05qOFgzMEtjMEZvYmdWNEgwS2FRbEs0Y1Fm?=
 =?utf-8?B?c0JBSUdMUm5JRUFQVmh4dWtEM2JTOVlTS1lkK01rRkdzVUh5MVZhbHZ6NmpS?=
 =?utf-8?B?R0c2SXV3OFIwK2FoWXQ3eEk4eGF6MkFES0pQYTRrR0xxNHQrbllDNVdyNmly?=
 =?utf-8?B?RW9hYThjQ0RGeGxsZCtqakxZMGNLdHpPREpnSXM1RXpEaTBPQ0ZpVThmNDZv?=
 =?utf-8?B?NWtZQVA0LzJiM3R3R2xtWHBIcm9jZFZMd3Y1Yk4ycWVkZnVzdWl4eEIxaDht?=
 =?utf-8?B?cFpYaWM0citLWUFjb3I5cm12UUx5RElyTUxDSzBCQUVXWWR6UldKY1RsNXRM?=
 =?utf-8?B?aEZab1RHSWxob3J4UXJaVVB6UU9kOGF3V3NXOUphOElBMDBwSWpQSnJ1MXYx?=
 =?utf-8?B?RndzQzJSL1k4RnFHN0FXRlIzaUZIU1lvUUxmMkJhUVphWXZKQkt3Z2JRK0ds?=
 =?utf-8?B?UmlwSzRPakhJWjF0bnEvVzRrK3MvSGk1bGE5MFZPVW5Nc2dDMFh3UjFwZVJz?=
 =?utf-8?B?N2ZtcWVFQkdtYUkvdkZhcEEyamJVdWc0QVZvNzBnRGFDNkNIUnFVMTVleURH?=
 =?utf-8?B?cXFJZzBzaWVuT2V2ZW9RTUZIK0pMVFh5TE9hZ280N2lOZmFCRHVYMmkzNTVi?=
 =?utf-8?B?WVFPTUFnNTZzbHNnUWJza1lSOUI5RmpqOXF2dEd3UjdRSEIwb1BHa1BwZ1Ba?=
 =?utf-8?B?V283L1Zqb1czUUpFYW8zVS9WMWNiNzhmSzBaRFdaZExaQldlQzE3Q0xLQ0lG?=
 =?utf-8?B?SHc5RkNPWFV5b2JvSFZNUWVrWmtkUVhtb082cFlsWmh6TXdqZGo5WDFaOThl?=
 =?utf-8?B?VHI1M0drcDVjRDU1d0V0K2VSVy9iUjF2K3EveHlhYkRSeVEwcCt1MjJyVUZL?=
 =?utf-8?B?MmMzdzg2ampWR1pVclNFMmQ2KzhIVzZ5QVQ2cmtsdkpNU1lMV1hiMmZ3YUd3?=
 =?utf-8?B?UEF0bTZNUGF2QkpkRnNINEFFVkNqV00zd01SK0F4aUN4K3RTQ3hTbk8zZlI5?=
 =?utf-8?B?YUo3dkxYeU5uVHMySVB0Z1V3cmxnWEtMTnVOcGNFblE1dWU4T09wNWxrVGpw?=
 =?utf-8?B?Vm1CN2VRRFV5ckU0dDNxb1lGUmJGVlV6NUYraDBpKzBzRkpxaG1KSjJOZE1I?=
 =?utf-8?B?R1JFZE5FelNqVDZ4Z0ZXN2xwSXpZU0ZSa2duZHlrYk9jSExkNlRHWXcvUDdD?=
 =?utf-8?B?RkhidG8xdmxJQzMxZTFpM3kxd2d2M0ZHMHE4RVhRR2xvQVZveEpxZkVNODlw?=
 =?utf-8?B?N2V1a1ZJcm9ZdmplK3pmbWowOHJWcFJNMEwzUEIwbnRqOGE4cFhlN3N1RXpR?=
 =?utf-8?B?a1JITE13NWpzRzMxREx6VlNjSFo5TE9mbjVMT2daQklxYUR4YnhrRlFxSzVh?=
 =?utf-8?B?OHk3bE1YRjR2RXpHNmYyN3FWTW5reEFweUcwWWFCNEVyZ3FuYmQ1MUo4dEho?=
 =?utf-8?B?c1Rha3pqVjVNK0tyaEpUU0srNVUrdjVYM1NzTUZMU2VyRDJ3MWlLcm9sUVFy?=
 =?utf-8?B?MkN5c09rRytGMzlEbFIwdW1nSHRDcFB5MFYwK3lxYjdvY3VrY3RMcDZqaFd4?=
 =?utf-8?B?L09ITGJQdjdEU3IxcElsUjFWOThZTFg4bmZDTVZSdmlhMHhLUjAvN1kvQW1r?=
 =?utf-8?Q?YNmi533MO+k=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 11:41:06.0382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f68e31-7f1c-4410-f062-08dc8ec25fbd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7307

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


