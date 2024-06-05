Return-Path: <netdev+bounces-100913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02AB8FC867
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4232F1F21CA0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EA18FDCB;
	Wed,  5 Jun 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ShMsSTGp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49D14D458;
	Wed,  5 Jun 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581434; cv=fail; b=bL4Q81IeReeSO2H6sgKCBQKv7UT3Xk+5IgR11wg/4l3Ln34bF23cp2xbzlf2UdJTLOcQf50rpNK3F07iCsAsZ4pt1i1WmmK7F120R9vs/KRsI2ojSoqbcJp9Im1b7mvkpt+uo5id8LzsdL7F7X8g5Drw6RRlgCpkS/Im9RpXNRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581434; c=relaxed/simple;
	bh=AZ06KBNE2fF/6w81AnnwMxflls9XuUXNo+5aPZow2DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW3E2GhhPBh7mxZObxjy2b59GGrHJPvoLkcXcqmam4L4jNZaA0tD2gh8iSyEr29kUbt81uqJPIbgloBX/eMO/UoH8JNPItjQpk/9EGEBXBr1lnT0ITn/9kG19BKqY7RvlxzgYIi+PW/afvz5FUnBr5aXN4qXoz1GViOe+j3RR2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ShMsSTGp; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJCIgKMZvGh4WZdYgBNjRZHhBjMokbwlqyIQXrl3ahxXzesT6TP5W7T6ih9YbfUR8EehNtcqh0ppp3mAOLFhkyxVKGYG0U1Vq0jlNq6YNLDVEmIWLNEzJTKrhS16+PRhPPRqMurs99M+U6YNzFOCwLUuBTZKg0opRAC326nnYg2Ewv56rNhHFPJHCCtHTZUP1jNHSBbh876Q+9ZFct1toe3HlZ2v0sOqizDAr+Fq025EsuhGLmQ0bNvHKpaFxWch1c1ADe4upkYPuyMQOfEqKQkK+ssVXwugtikJoNDDaIkmrqLNdPbJ4OkMXpBLaAXFM+QvLPWwxm6+FEh2dUSD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=WjU1dmIiVVPKLx6Y1YtI8JSWMB9BLjNpdgWh0Ua6O9zRdkOgWpGPPehqHh22kceAyJX2y2+Xs+aVmAkcZLjBXifZ44BqXDuTbHM9VsF4a6jsJD7MmX+V2rThlxWrxjPl6eJ0E37y70NAqCTavo+pQP6H5DGep+d3rIT2JVhSnxHq5/sPpxVq9cAmoK/diU+G1JcZbKYA+GV/lOLOsNbQQsEPN5pQaO2ReDD19hR2rnIXNPa1DALLdFJt4vPiioBUkYyuVkKTgvsemE6P8JTd2uups7h86E/5IzeeByXWA67U1hFXT1XKd/s67HuC9oDAL6KsGtCG0mPOz0azxbE08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=ShMsSTGpdhobnxXO0u7X2Vx/uzS02s1xARMNm50287/dhWpgg9PyS609SeF0WuLpTu+8S2sQfkwgXGWuK3lA1I5r+PCzMjqLWXHM3V6fn4NNPaCKVADk/IWt9H09TNXcNwqRwMeNnY8Cq9lnWaxDiLV3RXM24BWPUeyrg4TTydE=
Received: from DU2PR04CA0224.eurprd04.prod.outlook.com (2603:10a6:10:2b1::19)
 by DU0PR02MB9516.eurprd02.prod.outlook.com (2603:10a6:10:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Wed, 5 Jun
 2024 09:57:07 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::47) by DU2PR04CA0224.outlook.office365.com
 (2603:10a6:10:2b1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 09:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:57:07 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Jun
 2024 11:57:05 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Wed, 5 Jun 2024 11:56:44 +0200
Message-ID: <20240605095646.3924454-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240605095646.3924454-1-kamilh@axis.com>
References: <20240605095646.3924454-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|DU0PR02MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ce83f7-9172-4e67-e27d-08dc8545dc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TisvT0J4TE05bGhLRjdTQk9FcEQ4R1dmM0dXTjFjMUlKRkJqSlJVTld2SnUz?=
 =?utf-8?B?WVp4Q3IwZDF0emlpZ3R5Q1RmZkxEWmdkbXBldHBuenRjS1hBdXYvaEpjRzNQ?=
 =?utf-8?B?OU0wUmVwVGVtNE1uQ3cyU3lHbXNpSERIZ0MrL2w3SlFCTHZVRmhlQjBTTUFG?=
 =?utf-8?B?RElLbldEQStnQVAzQnE4dWZQZjZlZTBXb1NJVWZnVlVjdWhTQ21JNGlKR2pL?=
 =?utf-8?B?Q1ZhdkxqcnB6UHdEcDkvbDJPbVFvUmVRZjZNZVVPUHhjRWlISlQrN2JEY0h1?=
 =?utf-8?B?VnhzeUZDVFRycHlpZzM3SmhPRE9waDkxTy9TbkliNTh6eHFRQndyMFlBdnJa?=
 =?utf-8?B?enY4eko4TzNwbXBNTncvN29OZ2VUbFpXVVVzTGF0R2RJZmdQUlRRTXVqc0pC?=
 =?utf-8?B?L21Nekw4VGhhOGs3aSs3WnNoRWZhdDdvVGJSMnpWVjdCVzF0b29FRVN3d0Fo?=
 =?utf-8?B?WHBXa1BadmI5L0Z5UDQ4cWtnWHNWdE56L2pwNWlyN0l0d3YvRldianpwK1c0?=
 =?utf-8?B?NDJIc0E3RnZkWE1JYlZTNFhLamlrL2xlOHVodUZPKzRxditMa251akRTa1RB?=
 =?utf-8?B?S2JYZnRkRnFacmpLc2g4ZG5YQUxsU0k1SDBaSXdlNmhxaWtUVnVqSWhGcmFM?=
 =?utf-8?B?VkJXblF4SmZ1UEVXMXVYOGVUbzg0SDR3RGp6dXZWVEc4NG9zcVQxWnFGK0E1?=
 =?utf-8?B?ZXV3ZTdJZmIvMTREU0NvVktvMUhzRVBjSnBNTGQ4TDhGU2lWN3VKMlkxK1dP?=
 =?utf-8?B?ZHQ1b0FkZ2grZU84MzJubzNJSXYzWHZaN2FwL1g1VnVISGpBNTlvTnVZT0Jq?=
 =?utf-8?B?VnFsUHN6eGtGK1IzOWdBOFBNSEw2NHk2K21oZktSa05JWjlGQVlBQWsxNXVW?=
 =?utf-8?B?UkhXRUk2bEtEaVFmLytHcVd0VDBDZ3JERFNPTFNCTENQVzNMWUt0WFZkQ0ZB?=
 =?utf-8?B?WEFyb29rR0FCTHVSUEpvNWx2TUlwdjdqREtZMzJiWnJJODlSdkNZNkZaRlp4?=
 =?utf-8?B?K0lYQzVIR255bmc2TjBkVGJJZmNyK0I5SWNqU0h3WjBxNkRjSnh6V2RNS1I3?=
 =?utf-8?B?Uk40eUxKZ3FrU2xUQi91OWROWW96NkdvNWlTdXhoeDFjdkpkTnlBZEl5N1k4?=
 =?utf-8?B?cWhBd3dkYzVodThlQzFsTk5SaEJUa2NYTnhKR05zR2NIMW9RT0dmcnRtamYv?=
 =?utf-8?B?bHIzOHlFczF1WWk4QWZqajNRSjBZdkNvci8wV1kxYUp5SlVLSmY3T2pLRnEz?=
 =?utf-8?B?KzVCY1pBTTVGN2w5Ull6bVhJeEw3VTVoaG5TMUNUUm5FUCtzWk8weDJsQURh?=
 =?utf-8?B?ZDIvbkFFWTlFZS9TWVhwQjk0UUtMMlg3cE9kbUhhd1V5THBHazdMTnVGNkFZ?=
 =?utf-8?B?WVFma283d1oyVkdVNytVQ2FWUmpWTUUzSThSUTB5Y0Y0Y0FiREZtVTVocXV6?=
 =?utf-8?B?UURPZTczSFNwT0Z2NFZBVDRSM2swVFloQ1FwYldoNUNCY0MrSWttMGd5RWhP?=
 =?utf-8?B?K0UyenVYdjBKN1Q3Zy9vUGZGaUxZbnhobmdyMDR5YlUyMENoM0Nma0p5NU51?=
 =?utf-8?B?RlBnaTFxTSs5MVpYMDJQMytRdTI1TDBKR2tGVmdmMFdBUzdhK2ZRSEFXWENN?=
 =?utf-8?B?VXhWSzUrdTN1UlhxdGtSMjI0TGVyS083MEM5TVJRenp3aExkM0FmZUM5T1ZX?=
 =?utf-8?B?ZlJmRU5aWkozbGpjSm53Y3QwSEdJVG1rNi8vYXlSc2NQZU4vZU01OGN6UGVt?=
 =?utf-8?B?bk92OFhINVk2V0VEZ3JvN0xFeENtR0F0N0toVjZLWkszNy85NXdUUDVWRkNa?=
 =?utf-8?B?enVYWkl4eEtkTUIxZklrdG90WTAyS2hnWUR1U0tMdjY4TkpZSVpPWkVqekVQ?=
 =?utf-8?Q?PQy3NwzYQ/A8n?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:57:07.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ce83f7-9172-4e67-e27d-08dc8545dc7e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9516

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


