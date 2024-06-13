Return-Path: <netdev+bounces-103235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53056907388
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA306286FC9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2A148307;
	Thu, 13 Jun 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="alLavymb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2061.outbound.protection.outlook.com [40.107.8.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A09146D51;
	Thu, 13 Jun 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284884; cv=fail; b=sy6L4GFC0IrdzqfX9ebuxQ+fGrzdKoTSrqmcUlocb7IbFnFY3me1k8yH8d7OPWT+1HxgW1qj6kgmsEB/Z8lxfFNoYrgdHbDkQg9XfZKYS3xoR2f4XaZlKDK4w0Sd/rDBRR99vSDHt3IanR/x37GlhpzmHpNXJvANKNMiZXNIjSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284884; c=relaxed/simple;
	bh=AZ06KBNE2fF/6w81AnnwMxflls9XuUXNo+5aPZow2DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Ac1AGy2fP2g5rCDmLMeWw5o/z3aLoDMe8PR3/ev7SEvIVUW+AHniYsJ4+Lk8uU0adfQm/SHX9ryb5UTmW11p6GqyLebAKRYbhMvoE7CElRn5pS3sGKct3IA9btQDRPhHV8noZlDVZdYi0ktyrsMB7beT7iu+n66NDCsJMo7v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=alLavymb; arc=fail smtp.client-ip=40.107.8.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em0MsV48FH5f5xPf7zURAKqekSmUXf+KVjNJDGT8+cDvSQ4GPD6eZEmYHqtknjFluOLBu/eb1CNczZoX7BpZRN/Cszh8YugaoRaoXGYNSNalj9FtbNo3pXCVEoVpZdLOTPouF6oxXCt0uzW15y+8upS+cv0Z07FwJAH2xi30MFQeA38YVmA8RGLgWObpUGnJBCi4sgFTxcHdF+dto5Qry2kcQ4jg9k5f8s4udqMmTW3y7pRlG+543UQVjueNfH9g8RvYeIyUHRT7hs0DT7tYNE1KIsnA1wVsBptv4w3chIn3wi+YPGSwSq9v75YZo+DQ/QxfyVG7rgGAwqIEJ1KEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=f0R4XWeEtwmi/+9H4Y1rl5C86WbGoTblUC81ost+MiTv36PukIBi8ZimVj/L4RKh3m/kcYR/MpReEQ1SqmBdjdFFq9HjWxfZ8NRyqaOHLs9H1lr8WZaSB3paRTccl6854O7QRkQpgK4lcdGQ06PA7kXdu1Nv1HF6Czv5lpT3dNeDcyAZYOLkd0/Z2YjMNZtXvjSPWqSH2pj3YwDb7lHXRRrqlDbuUgTX16IZ8vT2KDKit8aVR2HJ7pSk/TLW/24LtnS/0Yjv3gBkxGqtGdUamV6THs6VxK2qzRtWjQF+t+ICdXvbqIQ6Je5RBiI/O4Vt6kz6DtGzbzrm34RRe1NUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qk5HkWquX5hnH4oz0TZDo8Tx+l3Dq48d2ORsvVXy1U=;
 b=alLavymbZ0n4GZp7t3axX6qfRU79IQSfHilEMrsHTxQd8rrdMfsvvw8WaIWwWtuvb86fzLOG2HwEHaEmPJlgODd9+pB0V5+Z/EVo0++qcwkBjNrJobUlpIqZ5VKNm9eBISdvTV6nlCjSS5fxw0J6XuPo+eTT2JTzjxMhPbqRysQ=
Received: from DU7P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::26)
 by PA4PR02MB6927.eurprd02.prod.outlook.com (2603:10a6:102:108::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 13:21:17 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::93) by DU7P195CA0007.outlook.office365.com
 (2603:10a6:10:54d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 13:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 13:21:17 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 15:21:16 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Thu, 13 Jun 2024 15:20:52 +0200
Message-ID: <20240613132055.49207-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132055.49207-1-kamilh@axis.com>
References: <20240613132055.49207-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|PA4PR02MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: f2576ad7-7aa4-48b7-410c-08dc8babb501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUVMbXk2OTZuZncwT0hLY2t2Z0gzWW1CN214Y2krandVdlFXRm9Ya3poTXFi?=
 =?utf-8?B?WU41SkpsNDFXNldnT0swRU1MVUFsbTdGLys2aEl3MWo3ZkM2T3pWZGYyYVE1?=
 =?utf-8?B?c2VqcFVoMEs4VU8rR3R0Ylp0NE8rbGRGZjN2YUNYc3hwaG5QOFNzMysyWGdq?=
 =?utf-8?B?VkRibzVMYk8zZ2QzNjNhNXFYano5OXpwTW55RkcvT3hDbVRmUUVGK2FnMThT?=
 =?utf-8?B?S29FTVRqaWhPSHowZ3BYR2lOUVR0ZDdsbGJaRGp2WlNTOW9mR2ZqOXE4NG96?=
 =?utf-8?B?UFpsa21xd1lPSlVqdG41R2xHSGM0b29TUUNmV2doSUVKNzI3ZHlXRVZIRTEv?=
 =?utf-8?B?czZ4VkMzL0xtMENkRDRTQkxUajZ4b3FDQ3BVS3cvR2ExeDE4M2pnNXNJaFZY?=
 =?utf-8?B?Skk2ZUFkbXM1M0hQZVVxcGY4b1BNZUpsYlFiWWZxSnYzSkVVTngxQXdMSXd6?=
 =?utf-8?B?QkR5Y3lRbUdxeis4dUZWZVlQeDNVdGFDSlJzNHZoTml4bkc4RGxEak95MmtN?=
 =?utf-8?B?LzdXN2ZWTC9LSzcrWTRXZ1VUV1N3Ym5lNkxZb3RvVnJTeUF2R2ZQWVoyYnVE?=
 =?utf-8?B?QXhVSnNyc0FNRGpLaEgrdkJjRVF6MTRRdy9nUm9oQ200Ny9vZnFNUFBzWWNo?=
 =?utf-8?B?N2VtRm9hME8wYmNpbTJJeTQ2azdXdmQxaEZmeUNiN2kvdVQ2U052SmpQSUJq?=
 =?utf-8?B?ZUF4NkZSbHB1ZThVZGdXVEROOHdlZ2YydDZDclpoZ2dyekZWaHhDbS9Bcmlj?=
 =?utf-8?B?NTRCWFV6cmpUL3ByeTRMdGp2SGdYZnVuT29JVFZzK2VmVmxmYWw2bFNqRG80?=
 =?utf-8?B?L3IzTzJDWWxGdEtrRjRndnB6MzlMNEtLa3RITjdWTC9HTXR1dHNxQ3c5cXVE?=
 =?utf-8?B?b1BsNnJhK1pQUjczSnFMbVM3MFU5MnJXaDlOdHJ3MUlNc1EyWjFmOUpxbGpH?=
 =?utf-8?B?V2xjNThveWJ3ajk1QW5pNGMvcmZWNjJ1bURnT3k3OGdxSnluUU0zYXFOT3Vr?=
 =?utf-8?B?S2JGZFVBOHYzOG9DaE9QNUgxNVlXUFFTNys2cExleW9wL01hT09WQXRQc3Bj?=
 =?utf-8?B?QnFEV1VMUHQ5NmxhTVRzd2NkNkdNUUN4Mmh4ZTJpKzZZbUJaVndjdmlnQUxn?=
 =?utf-8?B?YlMrK01zMmRsOXpmdFFrUkFDU1ZtTUhWZUNSbUZjM1ZvTjZtZ2hDNDJFS1dM?=
 =?utf-8?B?TDFYRXZuK1RrRHFNdGozakU1TkE0bHY5b05iSmlJWENwVnNnck9XSmZJWmxl?=
 =?utf-8?B?eSszWldVQ3o5MzRuM3BoMDFoOWt3azl5Q3VzRURRSFpIdkl2d3REUlZQMnZ1?=
 =?utf-8?B?dml0U3JEZEtNczR2d0N6VTQ5NWhJZ0JFTjA3OSs1V0YreUhya3JjYXFUbkRt?=
 =?utf-8?B?MmV5R1d1ckpReVRlVWpKSEdkbEI4Y2pKN0lDWUdMc1Z1S08wZWdSdmNDM3R0?=
 =?utf-8?B?YjV4Z2dJc0M5UnMxLzVOYlhCcUVjZ3MxSXBwdDhUc0tLaXNxaUI2elB5cHNh?=
 =?utf-8?B?Tm5tWXNiMnZyUjZhb1AwNzBtWVJhMHVzRHI4VnVjYzhjcVpzeHRkMTFqZUF3?=
 =?utf-8?B?ZjlSVmhMTkQvSFYvd1p5YWNOZlhxdVc2SGpjajBPWUoyUWJJWG9iZk1SR0gv?=
 =?utf-8?B?VDBMcER1dHpzR0hqOTFKZThOaGI1L2xxQkYwK3IvQWZveGJPeFFoVW8wUjZK?=
 =?utf-8?B?aHkyZ0JvbGZidTJGSk43VHlFWis1THFXU09FN0VwcG1EZlA2bTNPUkVZb05j?=
 =?utf-8?B?Z09TZ2lWaUZjU0JZaFVJTXhiNkFNWU1WMHlMZlZ5aG5KODZMNmwxMThsbms0?=
 =?utf-8?B?QjN6bVV6MWJyenVZTUhKRkNJTk5VaXhvbU02TVc5LzFRNkl0T0F4ZkJnREZl?=
 =?utf-8?B?dW1WWmN4SDV1TnVXRUZCMzVaT0pBRFduL2xkNDBkajErdVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:21:17.1413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2576ad7-7aa4-48b7-410c-08dc8babb501
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6927

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


