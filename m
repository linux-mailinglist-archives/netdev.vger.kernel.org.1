Return-Path: <netdev+bounces-206100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57874B01763
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B195B7B4494
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A1264A73;
	Fri, 11 Jul 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BVKxrYYd"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0D26462A;
	Fri, 11 Jul 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225253; cv=fail; b=AFfl1eUbEHtqMuQ3PHLvy01vfAusb6e9vgLPsNd0bGw+9C5d+k/dym/Zhg/X7xOUN+mLZClAyoOcvrSWQcHiJ/eMaqovq+LgCkFRKwSsucoKCvBsDeGHUSomW+eJzMNuXuvmabGQ418jdAL/PdXQumYijUjz3pcrTO/29vpV8k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225253; c=relaxed/simple;
	bh=FsCev4w/N3b+1RTgen/6n5kuMkiDSPMtbv7iYeW+ubQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rgu//YpVBxv5ytq57ub7FqQbvmt6j2JALEJgzah8sUU2Kic5f4oC0m9defTZMFALUDLqnnPKD7NUKfgoo58w2SPSLeMhsA4YpB77AtcnNZJURHkSKlnuqBJYeUUhbMytU8MXGSBGLyhNdyZTkrFfvhjxxb2+VLvGIoLXD4qVg9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BVKxrYYd; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGHzlm4eqvsbWsuwFUEXCUOO0ze60HatdhL1/PmE6zpDjnGHP7zUtLzuqFdaFKCXJc3bhKMncSRTI4zRkqMIw1DzQLkLrAVYhX1IE/VBn7LBIw6AXLFKSCcgBUR2UIJt+2LCQEaxzyyGTxxwR5PJjdjOVk3vKvd+HepPJuqe8DqcS0DY3P7gyC80iWgFU66WX5H/e5AovlCXCXTalkPuICer0OilHPvqT1oWQ8/O1myKm+jUN7OBODIjBAGRfehEyCkNRQuWzhCzqG8xebldE55hnToh53nBOEnr01WtQmxOeJ1GLIvB/raJdHs4XNmVJUcSs8FyplLVNJZWUXmziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ti1g8OqtrC9CLLyD2KbdenYYBjTdF5ZaPK0W5N1EmA=;
 b=yrhi/eS1fx9qdfgITWDW4v1hyc7kzrhP9YgBK3iM4CkH52K27pfUSdJodUH9NO4WyYkLOW5p8jep8aj8Xdq5B9envZ8LvO2pw7OqM2ihcILFvxFzSrZeKzqHIjZ5mOgiA0YOfor0/pbo98LUVS91GaYT+HH+Ky1CQGDdv5a+TQoJx9tddw0Ps8/NpxDQfgoEfZGSBH83WwsbEQLp7YFVbYQcyFPIgihMn3cK2z/v7GhyDfDKlPy5eBL+AOooyuAi5uDmlF4r6ydhE4mLQtdKJm3hHjcCJ6Gl/QWSIsmrVAF2KVPEytlFg5fyIEbRpztWIRONkDZciX3oDm47KBfUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ti1g8OqtrC9CLLyD2KbdenYYBjTdF5ZaPK0W5N1EmA=;
 b=BVKxrYYdkr3YsOHlA8Rv/Ljh3yjhsov+5daCuFemWPTy17qJGkKe5qdMNJLwY67che7pbt6Xa5peb4UNSLd1u8GiMOkc+L1m4oe3beRJ2dupII2VjmMC2K9QOP6VbmTGxFRpMTOsSuwdASh17Id2uKfzavxqwIBNiMyaLcKh0PEKDZQ8HYPKdgymvYHBJ+06Jj2OaL5bUd35g+Dba4OpJ0Uuffenb39h62IaO0Q/3+ac8AY7LB3fZuBVBH4cnpEFWk3lKqTrHB4IhjIYNIRZ/G48E569etkkW8PduErjR4cU8PTJ4I9psClzFzsgG9Rwnt09k4OVWMcs/EdSJfUpgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 09:14:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 09:14:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 2/3] net: fec: add more macros for bits of FEC_ECR
Date: Fri, 11 Jul 2025 17:16:38 +0800
Message-Id: <20250711091639.1374411-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711091639.1374411-1-wei.fang@nxp.com>
References: <20250711091639.1374411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c095ec0-5a20-4200-bf23-08ddc05b4ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdWaqcKxv8YHE+O9r73Va2ed8Oj/4CXesDftcBteZOdQYseJHm5yOl1Wn4yn?=
 =?us-ascii?Q?j4UBPoGWPcB52roE9cXpXmIE9FLC5fB3mar7hRvlUsbA1vYHyAxDANT0ATxz?=
 =?us-ascii?Q?e5a10QwXJMibB2K0sxtt0kvgMhIi+aM2Pfbb9yRfmQb2/ydo6pgX3fwiVJbR?=
 =?us-ascii?Q?WpYi6fgyMpw80sREPIWWouJx84CeRhmx4UPciEinNpHGyXDW2TX6s8ztm0cQ?=
 =?us-ascii?Q?0BP/+Niv0U4NU+AMY+iKSx46BikA8q14PDh4jaoHxLfaIdXy6eVFKTspnMl1?=
 =?us-ascii?Q?mFW4F+vBEMxVZHZCcIPWHFEMbdQZrKFB3IP4CoIRVISEplidZ56Z87FEkFxg?=
 =?us-ascii?Q?uhwukWneWdMalknjGP0vxpPotbZxMbsRbH+KdtEwWPmtu/6fBygkkUilIv2x?=
 =?us-ascii?Q?ADCmBLPBGCUyk70zjQsGUksOv7rvz0IasO7XUE/Ehn+QErJpYbLgaokyrJfr?=
 =?us-ascii?Q?GeLM4hG/hXg7Mw8BNsqcZL0sduCqNaO2fUvSu7VvATKD32p3QCGNl7GmCJle?=
 =?us-ascii?Q?tex2e4pgrZBMlCJsZHQcNnYBZjMhNqOwY5BLcC9knp2PRB+sd8x4SclZLp46?=
 =?us-ascii?Q?1rxF9vkDJIaVwCSKg2PkwXA5isBBY3nCafnWcDu2g7oP63/MMog8ElNKnmLQ?=
 =?us-ascii?Q?OMAhQuNV6ikiBcGJj95Bgz32VwCffpVPKtSMBe0zIuvg2gohDqAy7obDhMoR?=
 =?us-ascii?Q?NvExAahR5E5H255uUR5hMOs/Wy8ZU8SjPqItZG6amv+GatlVLU6jzBdAxsPF?=
 =?us-ascii?Q?gW3VQWQfnXQ01+sBOTayCyImU67/htLyePn41DM8OSaos+t2DQLao1GrGGY0?=
 =?us-ascii?Q?UKswu7cV+detdH02UyKP0jL3BfGNC4EBe3iTAFbSVdU+7spXJg6GQb5B/gTA?=
 =?us-ascii?Q?+APFLtWHfZrYefVJkhG23nPNPkusz3H+RoMKNYT/MxM0pPNk5ELDekaDYlFw?=
 =?us-ascii?Q?5HJMuO/ekXduv8tQODpR76bKO03HpLhhNqDsWEOymI0f9e6KzmR9lymSr7xI?=
 =?us-ascii?Q?yVrDeAIrHmxtBh3KQroIbVLql7uTfA1cNruFJkrLsVty/1z9yUGk8Wj94oug?=
 =?us-ascii?Q?w1n9QVz4r0IWT/vbO3ubHmb534fa45U/kj3xlUp6675mwguuaJp/WvW7Jz/q?=
 =?us-ascii?Q?c7Axu/YsnAjS9lvIxSOP3fCuq0N1+HB0DRHGhfMmVqHOAE8podAASgCtVEts?=
 =?us-ascii?Q?JvDjKlRavld4xOG1iOHV/BE4ev9QU5AF4zIjO9bpaxpHRUZF3qel/Wy07+Xk?=
 =?us-ascii?Q?GmzzoJLrD83APjBrbvYEjsS53jJyiU6zrdLA3K8qVFUd2+tLHwA1zhhz9MYh?=
 =?us-ascii?Q?LvAVDhJKXWa8jGaKy6VDU9LXICkzESj2I1jFGtfkEr2DVNiDCbUmIIYEJDTF?=
 =?us-ascii?Q?6LMUC8JRJg0tyQQBfewtpWtLPNsNUaSZBP6BtUVXnPcbFZXnOezEu/Rq81/o?=
 =?us-ascii?Q?/lkK4XvsINpV1sXYci7IFTEHsw0w7/R2evHWT1ZtZ2rNdg43HQKyzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pod745wW4kqf58teDmS8Eum+tfDqJJ4VkHLADowDYvA1RNnvozdsbnxwH+3?=
 =?us-ascii?Q?XXprEIpQZuq12vz6FCukyyuQI5BV0X+s6JCfrjcMlhEuUW0UMWGYIby+tZdO?=
 =?us-ascii?Q?NCVnXc96w8T7Hvyt/LIBfClwQfYC20590INpF6DCUul14oFCqGv+dHlafjjR?=
 =?us-ascii?Q?ZvR0zZt79MfwI/f1P3IaDbbotRwqF/NtHpGCKUwKz+/wgnxvnCuvNEUozQuL?=
 =?us-ascii?Q?wjyzk45CEuHLv6hRm1lqhZs/dMYLVnuVc8ABJtWVF2qYoxmhknn4RzQjsVo3?=
 =?us-ascii?Q?HK3O0mgGSWfsVDxQd68r8svi1J+Iqg1kohYYPKQif8KmsNaqTh++9aaOOmxO?=
 =?us-ascii?Q?XWYgZ/o+KO/N0L8OCLSqD8U7Sq7i/7eDaUNR2zK/pYKRV1bPE7D253OoaIyu?=
 =?us-ascii?Q?3r/SBYKWeBlWeCBCD5rXHQpeFd21WBRV93x/Adm7beqPNNAYPRSNg9Uy3HYX?=
 =?us-ascii?Q?RFClcBaBJJLI7j7LrAUWWjQbYVFKO1GhaVs2shT5ZeWpoTGD406PR1ImiDIQ?=
 =?us-ascii?Q?+xwctyo/jhnvk0C7lWP14gvlMb+CSKZ/Sp5p5qEycO6l7vErg5Kx7B1hhFw/?=
 =?us-ascii?Q?YNeHi194Udq1Tmb3P49i42awIt2hNd2t5+7d79kU7DBMwlr2lQiOpMZwdKkp?=
 =?us-ascii?Q?KJTCYNNbSnyOZI/oyBGvtecr3UnvntVTvyl/jUlhMGNwCtX0CA9FfKB2DBYe?=
 =?us-ascii?Q?bAlhZk4Kxwce0+7TJ9xaG7LHREkZdzC8u0o4PwR8ylw92UkBqF8IpST3gmv0?=
 =?us-ascii?Q?2+XeYWH8e0CPNEO3Zn7WpgYesdn0VSm/drxouxaB3GdFMUFwFzVkmitEXe2d?=
 =?us-ascii?Q?x78GW5YbrrJTUScmDWa5pptKOBqXbk3Ynml0qsMiktSQlcUYeDVXQNagFQQ0?=
 =?us-ascii?Q?Am6U6YkNnRg7KSdbe2R1lX8kj4BFZkJ9ZvT/8j3YOvA/oHDc3Kd+O84sQXqw?=
 =?us-ascii?Q?Cia8Ui0W218GPSiggiOitnGd9VB9CUxDlxJW1azBMFe5jBu5DUYKsqWm4Db2?=
 =?us-ascii?Q?HfX/Ylpbrib+IGlC8iJxnSRB3qVlCKxPRF9tsyDPHaEaySq6Oe2K6TPJuJRZ?=
 =?us-ascii?Q?78TMhGjVnDJ0DiO+hNqYLu1o0na3zxuNCknW0z+w8wsmtIcVwxR735JJi9cC?=
 =?us-ascii?Q?YC6UgQLiAyjCkYT3SylvMW4tLBfREKC2eAIZpOpsn7/5gVGYqRgxH2iOLdfW?=
 =?us-ascii?Q?NcoHxj49Awjjamoh/NTpA64jjQ7o/vEbyJG7VKm+Ye1pcTEfEvMuxY1eZ7yy?=
 =?us-ascii?Q?wEfA+UVk20mopZImR9kRsOv8UirZkyb1dXyw3VbM/h/Y1uJFHfVNUG4GqpeH?=
 =?us-ascii?Q?8e9hdwBEBMRr3WktiEoKd67Up+Wr3sQqd4x8xfKkC9f3DaSA526naKEjykGr?=
 =?us-ascii?Q?hjMv24/bkXb75xhKJHc67V1JdsAqn4q8hrH+lLpNR/Evn+hBzZnjrKwqp97T?=
 =?us-ascii?Q?qp1ZWvzLuGEEh2/rWY4urTAlOCmIUfFMvqjNyQa337XtefMDnXQ3Ox4xd1x1?=
 =?us-ascii?Q?bACe3HmsOhG9J5R3AqyvKjO0HXWPTb21I+fMb8kTI8UWub2oWTcYVXAW53ZV?=
 =?us-ascii?Q?7x32SMYr9XeBuR77hpNsncpjWo6qE7+uTv8sZrvG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c095ec0-5a20-4200-bf23-08ddc05b4ac5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:14:08.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mom4CKxUva9+8o0LBnww2Ry1/ceSrjqzxz66II1ePXHkbWFRoOPQTsg1E6qOx4cYLEdwxtyaZzzlwaCUmDsPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

There are also some RCR bits that are not defined but are used by the
driver, so add macro definitions for these bits to improve readability
and maintainability.

In addition, although FEC_RCR_HALFDPX has been defined, it is not used
in the driver. According to the description of FEC_RCR[1] in RM, it is
used to disable receive on transmit. Therefore, it is more appropriate
to redefine FEC_RCR[1] as FEC_RCR_DRT.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


