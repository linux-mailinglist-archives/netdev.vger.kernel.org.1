Return-Path: <netdev+bounces-205721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62633AFFD8E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8C53B72A4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7211293C48;
	Thu, 10 Jul 2025 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrMM3OUp"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CD292B44;
	Thu, 10 Jul 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138398; cv=fail; b=JOBa77ZubfkvJH0dN2UBvf6OySNJ/madeCyFVVCEoxRWp64/H0Txq1RY82W3hyznPblQsNyiP9XaCG8CmYQlI9av4RQTpBvLJviHBBPfPauU3WwAzkvBXGKhT8rxwZ7lT0OebZrGUulMzTIJRyl0yaeiAnnfNGuVYacIWsP2z5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138398; c=relaxed/simple;
	bh=aGJVPYg66xF8Kib1LT3mMzq95wDw83xHevBRq3IBCVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trWvkb1hIGqPU7fbPAzc/KwvQ9PqqS+Uq2o+R5oQUYYOKKY8UYOd9RJtVDxpTk6+UvAn6ratyg143FQpONrzx8/bvZT1YDDWZkWxyoMY08tAFw00RGxG36Mo4+XisBOI8tXU2DOIuLLOOqbvQ8I4uKp1KJhTvxgilmkPaRr2V5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YrMM3OUp; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPbZJnIyvVc21Rl8IS33dcd8VjJPwPlRX+WfIPZHctCZC17GqmPsrOONVU3n7HL0ME3b+7LI3tVAVvYItJ02eoy4f94MJ1UexNyLqBLBavJopPAcM9T74ICU+21+J4PP0ar02OWQCaZ6VFf2X5oGwf3H2Ve+zyNuq0S+O6fFEmEih54DP5yTrxRCK2X+3FE60mUMwXGT8Cyk/SrIIzxFNFzQOvfzhlNp9FN16itrPGNzOQdbtmqYCgDPabaMY+tu4wDFP8GatGXbBIOibkDPf0YqA/8mgkunVu5jJVaSxYjyFNPfPsmuwux0kh7YY5C+viTGM/yzHV0rV7pBbB3Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ow7HMYJJ+c3OTavQKkuKd4pXsKLIVlYaDsuj+oF5Q8=;
 b=GlCVM7wbPqygiLm/vz6kRa5EyYlqvZoR8RFQk9rr+tpUL9Hj5RiQ3oza5rWYxNcrSHAipnZA9FMmlrZ6Dstl+8tnd1twH6gjdUAAVf+8SRugOfWNvcLQrWqWwBRFMSPEvBav/ytun5O8u8HG+i/TOH5JKjwZs/PXnOM1r0QqiH2RwEfDuR3SVqLVrEpoJa6fyAm19dJjPnAIJQOBnTmUp1sulHgbwHIMUYqMZ5snQ/++0kiJ8k7nH2ZTsCg1Dx4aD4x6NEF32Ip4Jk0ju/vXOjLjdAIbzVu3I8JYMtTxMzWy+pjEZl3z+LGQ9OEXzjUzZrVcSo+r6I7CqnvTKt4LoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ow7HMYJJ+c3OTavQKkuKd4pXsKLIVlYaDsuj+oF5Q8=;
 b=YrMM3OUpkpXKXt8ydfR5Hb1Abyl4m575GzhapqZWB6ZPr/LWBHpgvt84MeJJgmy6pCjN2m9Mtid1bPYpqNZsN57xFdl+EGeAMnhJJ37DMeVWPKLM2EbwuuD80QAPoCA73TZXJVIXDGdlZZjxHPinaaRNQD0ZClsbkYVMJriTmvWdqfvD120WcMyzGmCOKkBvXOLmtFo7KGqFi5i4YbOEb+/NTgGFV0YS8hnNxNGIlMHfQxA98POCyMygNglUagKkdQ5F/7hG54fw0ZY0sYK8qKwv/BnHeBUzfnSSelHGU779mUXT8PVnu/6gEQ79pLjosXI7zzdO6CtQ94s2fYoUUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 10 Jul
 2025 09:06:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 09:06:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 2/3] net: fec: add more macros for bits of FEC_ECR
Date: Thu, 10 Jul 2025 17:09:01 +0800
Message-Id: <20250710090902.1171180-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710090902.1171180-1-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1208bbb4-cf90-4428-07b1-08ddbf9111aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePmnIodGAUIM4SCkd2dE7JEigANAfDNctGNp05nt0MZrc5kO9ZAOkXxOhxpf?=
 =?us-ascii?Q?F+g/RIxdEsaotVPiXfzpj1yqdv6mqnHMaDT7l3f/O4YEW3LLdhuaIpUIKwWd?=
 =?us-ascii?Q?3qHaNpDd3O8UTA663SO0yT+Eobr7dI6NfhDzMKYEIKu09Lt2/oII4KwLf0SO?=
 =?us-ascii?Q?MrK76iA6p6/fJ0aE2uzlof5K37sE0RZZjJMrgS37bnxuisppF4vzPvuEvFT0?=
 =?us-ascii?Q?q73uhmqqtRL/kHCqi/6I+ED6Rnv89bkxusMyFlehfUmH+4mbodaRwvRShIXc?=
 =?us-ascii?Q?Z7pMEjPAIz9yqK1lf7ZUb1a1SdPb5eR/yhIvSO4rkcL/LxdZfZ9stf2kKczc?=
 =?us-ascii?Q?a7RDVO3ngVKMCIdIRqYpkoIifjV6fA4wp0fZ+rfSjFbb789NQYxVlojrjQkF?=
 =?us-ascii?Q?U5GHx1LA/8DTbYMOXpkXzy3xcREWGDQzLFJPRK7i1+1ese/8tCAgu63CCbYg?=
 =?us-ascii?Q?a9Qz6yqSzGjeuVIN7fqJPOg3l9ziirZ/hIS7NahhJUx/q/2yr3KyGbsHJcjM?=
 =?us-ascii?Q?E51f7JaqJMSwwWsPGNMmnKnv2+BZ/6egasYZYphRbp03ADrE52ScAyjPL3Ky?=
 =?us-ascii?Q?TSS8tffPHOdNaU/yYXa1LuQc6pZojIDg1s/cWDh51uyPBtCgq8bv8NXMmV+f?=
 =?us-ascii?Q?YkcD3zdxdelv5sh5CgGQaqQ1W7X3ObvcHOirte8B3KZzKlJayQLp2kY7xrHj?=
 =?us-ascii?Q?NUPLYjJro2tBxnxuYbkeMAuSRW8FdqBs5M2O+wbpCVmNSrwvz4E/eFKcylgz?=
 =?us-ascii?Q?sXqJPoknNE1hViCwJghgXAD2qynbJf+X/xWeB5eCS8NxuRf/sJzPQGh7ix0M?=
 =?us-ascii?Q?6IsXSu55njT+ZEsmOiX+BxbwtnaKRCwaYJ9/9Sa12TEj+McfZ+cjI2iv8wwa?=
 =?us-ascii?Q?isAio3uA5RKD1p08ScxzG93KbtYzIpMZl4wAUWYWy6XNGdXMb+AFKLSu8Hm7?=
 =?us-ascii?Q?faMW6xolRrjmBFXamPg8nKitG2xNTYr9NVGAjDowonsgkzAd6lrsyTOM3KFM?=
 =?us-ascii?Q?hcgJV0DeQtq3DU/Z9uD0PRh+X+gZt9mjo4VEjsn3+tQiV5+G6pHxxswrPLhf?=
 =?us-ascii?Q?LLRWxM8wjH1S2GFNvpms7QfYKBIpcoc4XtJyjepeie015mF5ks7ldC5jorIi?=
 =?us-ascii?Q?noWBCecQBLBT2paMZmwUmaoSz+gAbUVr+8DZDq9G9sRLrnWYAX+ADJW6B4EQ?=
 =?us-ascii?Q?Fs5FvVMMaHnMPmOjwE7VlaIrg1m5sydji02Hdd0tD6LV+mPDSq56hs3BCG16?=
 =?us-ascii?Q?OOfhgQ5y6lNQ2MMKzJYt0BvNqPC6lkExONxlVks6iylW/SnfFW2dK7XFPQbg?=
 =?us-ascii?Q?8G4wzNjlpfsbinX4snVIKnRzluq4Lqewd5OMpMmyCstUVf1FxczJN4Uez8Ib?=
 =?us-ascii?Q?v4UXF0N1rv1Ym8+77D4IkJxtJsRSyzXBg6bfz192p6alaFbGtHP8E1/rb7xL?=
 =?us-ascii?Q?lm6Jc/b81yG84fMek6KRwXbmFVGeit12eifPmUDVftQ/oXjWO4ZMzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDdLB6LZcUz8At0BiqMS0WUrqBheIZ4FpbhObXkspBPeE3XgpT9gUNiqmPlz?=
 =?us-ascii?Q?MS3eLh6iViDSj0apjvYP2fU/Wmcm6WrcZsuuAhaXPT30UxbHIut/2O1I0AlJ?=
 =?us-ascii?Q?34LaHRd6HhJhq3L/Z7kfekoUdTGFaZRCBJF4Q7R19fUPYC2oo7Y7vhKAe8ge?=
 =?us-ascii?Q?6BXJXvzSvFmg8GK9T+3cCHO61aW1eqpKSjNpVS1uPAg5WLGtjubruoRPvUMi?=
 =?us-ascii?Q?DutGnrMKtW5LPFVqhcuI+tPvha5hlavER4S80ZFZazon4exq+EXFtseQ86yp?=
 =?us-ascii?Q?56SwgLHgVKyoSOEUHV6asohceDbvakjcG4+JLcGFzfTg9X10LbrS15FJ3/lB?=
 =?us-ascii?Q?RSumAVjnMhXvlfYmZf690+d74owkaibQTHK3bIJseododmSENDpK80S6cYmN?=
 =?us-ascii?Q?HfHL3t0EKIGKch38lFQAHFAMbbvnJPmu/bWG4DrNyTN5te7AlKpr+YvnJjU3?=
 =?us-ascii?Q?AKSmNlwQadDqXzoJvHDsiNlwDNt0eCpTkFoQ1NXpb0dOFCyGFvl0mjiB2tBj?=
 =?us-ascii?Q?26xmIUN1kKMwJRNjZ0oPzVGfiOEpTFdrInsZow58nfO6W+C+y5IKJEmqNB6J?=
 =?us-ascii?Q?mI4IIk0PlHbclw3muY/ZZbK3oQ0WjJfLXhJwdNyt1HGpFPBBUEHfn796e42Q?=
 =?us-ascii?Q?Uwzdmbro3d67dVPmdCZ7TZOjKB/TgDQ7BSxjUjBy37HZ3C+Omm+p5PrTKZ2h?=
 =?us-ascii?Q?2oXdBLHsQd0PQVqLnJqsaenZbQCo5Iauj3pHexlhLn2yp8ZsbIb0pYLIoOfA?=
 =?us-ascii?Q?RYXNIjGHnsNfDNl696rbxlA53ozgbNPCKkqGha2gJoMDAQL9puXzY96GOTBo?=
 =?us-ascii?Q?ZhTZ/7jZwyssezY/6afLzOxzIhif4Yefg7UYQkGCxwdpfSmArK6imzZdPYtV?=
 =?us-ascii?Q?EKuwaxr+TAcLOPJXg1Lw/7vjcIj48ayNIOVH0r2yCJgFBDD2ua+yGm3QiaUM?=
 =?us-ascii?Q?jQVI6JZK3IsMYztSKL0M3vgPnJ/FPC+Gf8pxqab87f5Bhr8M0GYgw+jmJaJ1?=
 =?us-ascii?Q?SItS9EZLYkCFFcf4lsHmF4oJ2+oxkkHt2n/1u0/BdgTK7om6YA80RwTZgQYL?=
 =?us-ascii?Q?SWQWUnJa8gVyKdMHVXMsQ+L5CB7Iy8oAprwUcyteKhXS4jnbJQeNeXy1zgAU?=
 =?us-ascii?Q?7eVUJHIEnuDwyz9Nofn0A9jKX1L07HFq/fVLMoROlm8qrRY0kVSkjIQ1MIez?=
 =?us-ascii?Q?gMjsaf4tGEKlmyExzi9t87OyEfAfnEElCp0GuVB5WyNqik79stJLQYeBA4pF?=
 =?us-ascii?Q?+BNGlEmQOyJvXuNghYL2wYGJ6SzbXkEBZ6ROY0wq2HTnWPi/sTz1Zlbz0ltF?=
 =?us-ascii?Q?Jgksp65Y0LcIldEY8CwuCucpaGckJjGED57EOSH4JiQSWiYWaXkbvjM3/sUl?=
 =?us-ascii?Q?G1CTvzlh4yD7yJtfEE9GablOKYGpFrHdGcVtiQmk7KJ8stw5mDqcfv311aWh?=
 =?us-ascii?Q?ZL0rn+VGhSbTmh+sqnP5y8MNIQ0KtbZ4lAbkm6DoSJBSLQUrX3iclUeR/P2t?=
 =?us-ascii?Q?0WPc1bKDkI7V7PW+mn+c2u9dCJvx2QAEGduPySkwQbC6NsOPmWgk9+TN/MSW?=
 =?us-ascii?Q?tyHgY7zZX5SZwIFd0L/yA4JIwDlUy5x+zJvNgov2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1208bbb4-cf90-4428-07b1-08ddbf9111aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 09:06:34.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET2ecxYIrJqMWVas7VCBokbpj3y9rDhYvpWDEPluxrdAcwMdjZl116TcD+3JlL7nAtj9NcxrM85kl+F3OKnVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

There are also some RCR bits that are not defined but are used by the
driver, so add macro definitions for these bits to improve readability
and maintainability.

In addition, although FEC_RCR_HALFDPX has been defined, it is not used
in the driver. According to the description of FEC_RCR[1] in RM, it is
used to disable receive on transmit. Therefore, it is more appropriate
to redefine FEC_RCR[1] as FEC_RCR_DRT.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f4f1f38d94eb..00f8be4119ed 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -279,13 +279,15 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_ECR_BYTESWP         BIT(8)
 /* FEC RCR bits definition */
 #define FEC_RCR_LOOP            BIT(0)
-#define FEC_RCR_HALFDPX         BIT(1)
+#define FEC_RCR_DRT		BIT(1)
 #define FEC_RCR_MII             BIT(2)
 #define FEC_RCR_PROMISC         BIT(3)
 #define FEC_RCR_BC_REJ          BIT(4)
 #define FEC_RCR_FLOWCTL         BIT(5)
+#define FEC_RCR_RGMII		BIT(6)
 #define FEC_RCR_RMII            BIT(8)
 #define FEC_RCR_10BASET         BIT(9)
+#define FEC_RCR_NLC		BIT(30)
 /* TX WMARK bits */
 #define FEC_TXWMRK_STRFWD       BIT(8)
 
@@ -1131,7 +1133,7 @@ fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 temp_mac[2];
-	u32 rcntl = OPT_FRAME_SIZE | 0x04;
+	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
 	if (fep->bufdesc_ex)
@@ -1162,7 +1164,7 @@ fec_restart(struct net_device *ndev)
 		writel(0x04, fep->hwp + FEC_X_CNTRL);
 	} else {
 		/* No Rcv on Xmit */
-		rcntl |= 0x02;
+		rcntl |= FEC_RCR_DRT;
 		writel(0x0, fep->hwp + FEC_X_CNTRL);
 	}
 
@@ -1191,11 +1193,11 @@ fec_restart(struct net_device *ndev)
 	 */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* Enable flow control and length check */
-		rcntl |= 0x40000000 | 0x00000020;
+		rcntl |= FEC_RCR_NLC | FEC_RCR_FLOWCTL;
 
 		/* RGMII, RMII or MII */
 		if (phy_interface_mode_is_rgmii(fep->phy_interface))
-			rcntl |= (1 << 6);
+			rcntl |= FEC_RCR_RGMII;
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
 			rcntl |= FEC_RCR_RMII;
 		else
-- 
2.34.1


