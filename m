Return-Path: <netdev+bounces-233758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD32C17FBB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC7A189A5EA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDB2EB86A;
	Wed, 29 Oct 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eL+JDrBW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E52EA473;
	Wed, 29 Oct 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703282; cv=fail; b=FjQE4gx//JCsy4XNK+ItptFYx4LYXHBEQxSpAEg7AAeW9HTWjyh8Hh7WUdONQXzkAWBHpgV17fSPkJK301G+9yRqSKy2XvgIAPgq1Le7JsYI9GqFZ6zbbQDOIbOyBf1+BPNIDCFZi7+rqSE1jlfSeWngAfX/SNh8Zz03aGexY7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703282; c=relaxed/simple;
	bh=xZ1N5Ht6XfMuXUM8iZkAa+7dOfir3p9d85hQfEeU+5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=No/zD0RhKjUlDxa3FequnweIyiFVy/W5LW+GlV8QxJtUoVXiMct3/sY1kAYep26qdX0w/sCEdOykwiFNDBchaRUkaKaVi8P9caXbdtuamyH7fUcSo96fZnu8eQ0Mx2a/zQWt7PZ81TyDEWVa7NzMOeIpJiDFp+AYsLGW8dEvbUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eL+JDrBW; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK1Aw0a7Mg+4YIx9+gyctB+F9AtYAkRAfwqQDypq1LTjFJ7eRI/2SnRNXeH7nfCnsfrrTd2i0H+elH9xbZb0Sb9GOsO0Nv2szm54avf/Qnxvavoy/0Xy4FJkIyCyHedcmaDH6P/4WfWnxXeu6eU6XVFxD0iUkjx9897SyofgHIUzA4/fCJhp/s5ZJgEe5SjawreWEIvRGgBM3jThGM8OoiLnEnpw8MCBkYuR371+J0egyiRsaB+B1L88jNTUz+IaB7lMoFd4Fdh9S/+6PWoKZE5Pt0NDUAT8vMIocWoKFoP0xDVGr4pOZAzXNBAg02tJ+SQ2J7M2TOvIi5K61LQgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcIVyZgUZTJBAmYzEIXwvdisCPQd0gnLGZ0EZu4AeIY=;
 b=dq+4uwFtwDwOrDz0W96jf/F2qa6HRPKrQuXxUXia/0hE8lmbfBY6aQKKUklNLd22Sxg/yifQLARD6zxa0s3lFjXlj6ZXlEKDsGcKRHaD/HeRv3AiYnQRGGKffzT8Y+xFdKtEwTegHHIwuVGP1JUcT2jz3gHvWi09RvalVptYV8/chWau2kFdU+tTdBWOmPEuPub5y2zk/29wnxaFh5JXtwnOBPb7BOgWNvB3HUOaUHO/hYhlT8k/YZHcTgZlztMX6oO4MakGnh+kATECovn+hHx12SMlfe5lAizmkEbcm1zO4rp69A8Nb48Rc+sESvl5Sefj+cXkcVXdrSg2bi5Hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcIVyZgUZTJBAmYzEIXwvdisCPQd0gnLGZ0EZu4AeIY=;
 b=eL+JDrBWvpco3LXqYzrJfB7BsKmIXnQbh3p2Yf+pilro8YUZ0ujfPoznABQScPtufdOMFokP5+Akm772cuSThIqgmsxoCZIyx0+dlja7DJy4BZnoJRcluVH7QUQGBDWquSAgAMdAzAQIVvZv7W5W6+o/g5p/XKHzH3TiRb0vcCczbZZaua5X7W792VwEflUTIx1r7xziUXFMussR4iQYAUCeGxQLB23pDwbc57MXwHUWnqY75/6uZI/72zN6GYSHWLXW11+vkJEgzmOjWmpvqpTWH1BOQSCZUq0Ruav33cIHo/GHmpZ04NGP0ZdfIa6mRD9dCcwaeqceQFUdEFhbEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 net-next 3/6] net: enetc: add preliminary i.MX94 NETC blocks control support
Date: Wed, 29 Oct 2025 09:38:57 +0800
Message-Id: <20251029013900.407583-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: a21d7bcc-3248-4e0d-a5b3-08de168f0d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHqj7F1iGK19+OePi0M5YqnkxPGGSAOtJNNG3bauhrcpXZ4zx+FWmYbhDzH8?=
 =?us-ascii?Q?Mwks7+t6C0JVClq3OSuWKzVxZpVuAWNC2+Wc176FEVbBPsb099JHf6mc+nFD?=
 =?us-ascii?Q?sdY14Low7e5mPAwPtcmRKW02gYaHmY5te3CtPAYH98z0NeYvXkeB45F2cLOF?=
 =?us-ascii?Q?Ba6AIVnnh9mZ/Rj6ednfnRZE6T6eDKkCfn6Ud0YqpMaXb2N88jP43OmiLA7R?=
 =?us-ascii?Q?7VFgVUoRjLWCSlS0kpdrZ23z1p5u4zWUeJbxLDUow5tbKkMpPrndjzjgAchk?=
 =?us-ascii?Q?kz6LgZfTvbffs6Op1gpCFwAAr0ZqV7vNcPXfKI6UKxp+xha1Vdm6zx/DFqUY?=
 =?us-ascii?Q?vooKno13RouZZbGljM4lNjpryKZhY1vE7izI4e91Jxz3x9OV2kFNglBrSg7+?=
 =?us-ascii?Q?IsAjece9UvExdeCMLUNBKqlpz2bt+lGo9UXxMlJy/XSkxhxVrI90Y/WK3BiQ?=
 =?us-ascii?Q?L4/HcGfOxnaQiOFLGqIfp4tY2bKt3AJLFTwENMV+qOrMUTPkl49UMTYiOyS+?=
 =?us-ascii?Q?LrBcgZpmQg4U0/hBlk+dsiGq4Ok0A3oi7eC2OpK51pKvzYUwl1A2kIavnA1k?=
 =?us-ascii?Q?sCDBzJo3PrImPSkBFqnnQppkFwwEhUpeRiXvWGBJ0EHBO5PQ/Rzm5ll3TlgI?=
 =?us-ascii?Q?8ipSkKl0FDUc7NAH9dOWOR9nE8iPm2zJfgabAOFAhlA8hOl9/r7/y3O/JWry?=
 =?us-ascii?Q?Rd4SWogxay5PonMPpVL8y9pz+cpRn3m6b6phrtJz6Oypds7qCVuicpE+vYdX?=
 =?us-ascii?Q?0F5vNcwOWaFM2zY67pAQr4ahbtR9ePAcqamfIUsRDepfVuPKiBbYhOe99eP+?=
 =?us-ascii?Q?hj1qLsxYYpR2ysId5II71hI7Q5AVrgPBBpglSxDqyzlVIxmYxiDAZrmTFbyP?=
 =?us-ascii?Q?H4X152r0S0i4636lvLP9SR2gDIkhHBWIb5pyyqf+kGAKLvd0Pivvk+uEWt0c?=
 =?us-ascii?Q?8XhkEl9X3MrWwGZ9DrfFaASLq8KEHoEAabb1CEVfvmMpXZ8w47Phw/KxAWYy?=
 =?us-ascii?Q?gNstfqJ0yqi0FTFjvqZTFh9e/hbBUUZdgaxYBRP9OKFZB8b72nOmYY+gqXEn?=
 =?us-ascii?Q?T1nH27aO+ZXO/g66jXhVUoYKUd3D3CeyTm4XEJFP/YZWf4WwGu6AEVX3XMkf?=
 =?us-ascii?Q?dCKeQ6swYhDl8a3oswSuyq8sBZl+sHF0JzERUedQJXo0wPb92X7oHXOl00bl?=
 =?us-ascii?Q?7uGw4Ry07Cmq8QWPCwGJmg8GobsxI/eeWM9iJQ1fEi4ECvGMXRVPKhX75kK6?=
 =?us-ascii?Q?2EDvMcfaWoCSaxshLykaRh5C6e8NiCQNIpHvaQBPPnv7mXTl4upOjckagvs4?=
 =?us-ascii?Q?bTQwAyRPb2K6gv1VVy9T6QjHa93Oy9OhYZ/ogXccT79dtu/aoG08q8k/RBrX?=
 =?us-ascii?Q?RG96P7QCN6vhI+BJHDhkGvPdxiXXByLwzWLrjvFBgmOMbbtrGLtJObi5AJ+i?=
 =?us-ascii?Q?DEQB81W6jMEsBeSHfS7L0mx44G1//5GuqGbp/gOG3dfKqAZqnsHJpTYYUssZ?=
 =?us-ascii?Q?tax4eleT4IcJq6OyFqnjEi6bvmONqBa/WwmK54TvE4yIP7zDt4GF0Q4oCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjsW6g6LLoxXZe1tPeoQ+dIMEPUKjCVgbQ1B3WUTpv0D26cqbXOrvTTAyMBk?=
 =?us-ascii?Q?meWvNdUfW94HClVMRhxJ2BpjkVlXLLUEe1/lvtFhlawtDMsHNVFsMDrxiIid?=
 =?us-ascii?Q?vBvt/uxmgTxA/oGIScWA9pD9NnkgqUD+PZ/d4qd+gCIUKrAorEem62z8itWI?=
 =?us-ascii?Q?4ze6nKe1pEfcIbpMFEqCC5ZN+nsPaX4WupPd15lc93i/n8Ot3GpmLKwDTYzS?=
 =?us-ascii?Q?6Pyy0JpY9tt90ZwMZxk8P/KzL1fZuQ2iJxUhfLEJjEj2ManhXu1hk5qiHPee?=
 =?us-ascii?Q?2caBzCqQ1l2CxFweWPNpSIsprKA9YQx7mEX+B7VR5hosFDIJi9lnAiTBZQgx?=
 =?us-ascii?Q?7FbWBFvoaKe9AwNHi9XfK746jvNbN0OHTZ/c4ZbBSbwDfFkS5QCORx6CvXUb?=
 =?us-ascii?Q?rjeV2FtX33VhZqt0y2eKMiQ8bqL6CdhhPCqhyJzYaoYYxSPchIgC3/X61PBC?=
 =?us-ascii?Q?BpE1pTiHavshkrCOMs1JBa0rIVDxoq0y3hcTXY1C9OeUfGq5xVCHxJp35yJ7?=
 =?us-ascii?Q?hEgEfkm8PqF6RVzfXc1gmLuVJThZyBC/DbiFyFA7w3VUs80TW3Yrqy2paKxL?=
 =?us-ascii?Q?+or20fwG7Qg8Omg1ejG4M3g0rujMCXtI1n4o8ylb4IWWrxNZABlzkS/A7jK5?=
 =?us-ascii?Q?eU5uP0iIQWgd6b2QMKQOX2d6lTeV6ii4DPezHQZemJgjae1hPlcoTLEurp5U?=
 =?us-ascii?Q?FV5jtCqJ+8yT3CNMLqUiO4CYegPnWGQmFHkBZPQCi3Mc/u2JM87MFa6wTbYG?=
 =?us-ascii?Q?TFHm4z/spfRPZSq7QJdyRNtSOZFZZW6avnMr4S/Abf8ed4RPV9+WvbO9h3Nh?=
 =?us-ascii?Q?6/wycm992xcLtqcqPbrgqBX8qm3l5FbR5pWO6wNB+g2PZIm+bk1DDQ8aCBTE?=
 =?us-ascii?Q?8jNgSp1tk3m11GBpZCy5MdI+r+7qgy3Q2rdXNA3ScbgIawx4i6FhKR04zMND?=
 =?us-ascii?Q?D1mU16EViXl6b7a1/CjhaAAFG/lk6dzPUQCpjrp5Uq87LF7s3G2GIgGMQIRJ?=
 =?us-ascii?Q?k50gfbH1ybAH8mU8hxA07e+5a2Y9z+/ccKOEgNnln5+ZULN4c3GxRq96fvFp?=
 =?us-ascii?Q?pxNK0JaggP9n2+iCHOZLRF85tQZGz8T19saJ+x3NqmEVm4ARc8NvpgVbIxce?=
 =?us-ascii?Q?h/u6u0XF7wQP99UMtbw1afw7Zwcc9lKIs/r5pI4pku+DneMXg5aVRAFGdMbB?=
 =?us-ascii?Q?l5t5xiGglI4igEFgP39vckJbRrXCNzcXPYDmXkuR/k4iwbWXuuN7CPb+md1q?=
 =?us-ascii?Q?6/j7egAf8tX+f+XWvCQA8Jm+NbsYG9E+/ciP0bilSLc1AJZ+ECR/YuVb7OU/?=
 =?us-ascii?Q?LzBnn+NqH6bfUMAWFDMPd4QyHVrnMs5ZmVbzKtSWDZN9qDgNjJ7YRqwUVhx8?=
 =?us-ascii?Q?FUnLCk23cnlMZefXP1R186CK8kyHQbnQdfD/I2gvrv2ddzL18niM0fXUuqwO?=
 =?us-ascii?Q?AGVH0KTBgcG0KifvrZ3Yfsq+suyTjdd3sPknoxZd2UtTltKgAMsMY19mjybT?=
 =?us-ascii?Q?d2SIRIrQ/XZIrDuATm9wArAwcoBaW4zlPXJKc8U/qLNxPm1Vk4QSGrJ90LIN?=
 =?us-ascii?Q?J2JC3betREm6Dy1fHE0wXgqJfXikG3BvxQ2BjjUb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21d7bcc-3248-4e0d-a5b3-08de168f0d4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:19.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAxN/svVo1wImEcwAkR4IahJOD348upCFK68PCMPs+Rs3hFwFstPyEGgs+0auwhwnx1GHrGhd3gDvguAWFAwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

NETC blocks control is used for warm reset and pre-boot initialization.
Different versions of NETC blocks control are not exactly the same. We
need to add corresponding netc_devinfo data for each version. i.MX94
series are launched after i.MX95, so its NETC version (v4.3) is higher
than i.MX95 NETC (v4.1). Currently, the patch adds the following
configurations for ENETCs.

1. Set the link's MII protocol.
2. ENETC 0 (MAC 3) and the switch port 2 (MAC 2) share the same parallel
interface, but due to SoC constraint, they cannot be used simultaneously.
Since the switch is not supported yet, so the interface is assigned to
ENETC 0 by default.

The switch configuration will be added separately in a subsequent patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index bcb8eefeb93c..5978ea096e80 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -47,6 +47,13 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define  MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define  NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define  NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -68,6 +75,13 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -192,6 +206,90 @@ static int imx95_netcmix_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     struct device_node *np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	/* The node may be disabled and does not have a 'phy-mode'
+	 * or 'phy-connection-type' property.
+	 */
+	if (of_get_phy_mode(np, &interface))
+		return 0;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return mii_proto;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (val == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   struct device_node *np)
+{
+	int link_id = imx94_enetc_get_link_id(np);
+
+	if (link_id < 0)
+		return link_id;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_link_config(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface.
+	 * Currently, the switch is not supported, so this interface is
+	 * used by ENETC 0 by default.
+	 */
+	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+	val |= MAC2_MAC3_SEL;
+	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -340,8 +438,14 @@ static const struct netc_devinfo imx95_devinfo = {
 	.ierb_init = imx95_ierb_init,
 };
 
+static const struct netc_devinfo imx94_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx94_netcmix_init,
+};
+
 static const struct of_device_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
 	{},
 };
 MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
-- 
2.34.1


