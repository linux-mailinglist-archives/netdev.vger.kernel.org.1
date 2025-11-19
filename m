Return-Path: <netdev+bounces-239799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206FC6C773
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A9964ED688
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C52E62CF;
	Wed, 19 Nov 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6KNYDJK"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38B2E5B09;
	Wed, 19 Nov 2025 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520678; cv=fail; b=c+mZXkwM0gQ+8RL9/nGQ06R/xpuLomgRlxYWrGG5p3HR30ozf9/lFZUFDEIWs4iO5RlhD3twt8cTp4Pg8GlOH9TwiE8JYZDRb1+Xeb5PEx07D/y1RwcZr0MOrLEVaKvLAb5wBSDFEE2+jONOSE8EaSj7lpIMPe5qLgWr+CmR7Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520678; c=relaxed/simple;
	bh=ffkfmGj7qT2xswVxlU2BF7F5zxtpqGnybn8ea7iDSEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+MCVRicQHNhvQb2ue20BiZ1evRd4mKpW+SvZ38Du/qyfX3UPVpuHovGfdjN1nKj/8ZM09so82ajWRT21bxSocuOyj/M9Sjp7DkiMU8NYX5NeJlS1+w7jrXmp2PTKq/zJPd9sKfr3rgqfw6uzRtHEP0734eUqOeAr1T8Uljp4VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6KNYDJK; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wACqfksKIjAFnE/rxpipyitGFSNPQJmx+sc7rRpojbvsj9SoATFRvvYwN1f2PDv2yIJJadcf1Jh/7Ra1E1/447cA8jreaCogsuLN/Y5O1uR1Moqsg9STiqIoDDt4iL1nCnI4GsVXTcXvdJrBcZp1KFn5pvsptGFd3KX9MFLMW3r1/7MmWA2w9xWq0e9dpeS/uk3y1kGkNDVF8z4tFe1KUITDXs18TVE1edfF/26raVokhCHo8cWoT6KOTQiiCrRUzivkr6NDRfUT/O6U0jZ5ZxhjVOK9vjKcfuay72eVlbfZEG9INsp+mJYo882UxMHDKdeFMf2Cv2Qehv/eSTSrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU/J4QnK0iIgDDXSLf3eYnChnHzLfeUayZ4ZtQN1PgA=;
 b=Nlo3/jfwavudpkbZt/yK6jQQHjVJTjf35pk5YMrN/G0wIinlo+rw2uDUMfqpNClpgRmWOg/dYGgEw+hQhg3BzjpvxnnpBfkcNy5mpnJU02Bg5qXZ4FuKCHTBSNg2ZqruwgtdZrWzXcVseK2X/uuBVWXBjDuc4jht/Rzyhu93eMv7lZ/6vwyrNUIRwECYpylEaW/5F5gOXSqEpflm5AFekDVUk2lmYSAE9h8uwnW5cFcEV/LUG1bIXR7FGEx2dsijR6TuubvyHMUkHU4zMRmjS0PS6Euk8TrCqEUYjARF4jnds2fpn4gH4D5jgNDat+chkxmC2lMG+5Jk3JfKMOdBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU/J4QnK0iIgDDXSLf3eYnChnHzLfeUayZ4ZtQN1PgA=;
 b=M6KNYDJKIbw5NPXFjB0NiWbVzL6BX3BDNos7EL2zI5KY1G3ddNXZvUDJj8x1h/c4eEk0oRjAdIsjnKTA8FjV6FwSPJTp+/0f3m4dgmQUZkSg5aXIz9T6BD9UybksWeXQvIlr9B/xzb7co5a9tPVCx1J+eCw/6CiyEyGYZBuUeI4lg9syfiD5arPe5rqSeypVfkOhuCIR2lb147V+gRtRwj7cfSlafBbt4FhtR2fWJNPXE6YpDwi79XetoFaustLDcMhgph58MiL+X8lyqcWvLi5t9KZ3A47sXeMW1FmDSaIcY6iiE5QTBEvcfEfoJNJCCGsliRx3Qyfa4qdVQ7P3nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 2/5] net: fec: simplify the conditional preprocessor directives
Date: Wed, 19 Nov 2025 10:51:45 +0800
Message-Id: <20251119025148.2817602-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
References: <20251119025148.2817602-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ce1d3b-089b-4de3-f8ef-08de271680d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/veSzqV/2ZHikw2eiabNV5wuWeUmU6OdCMVv60EOjN9+XQBm/rKFuw52KKHU?=
 =?us-ascii?Q?amzewCpa6QeSMxF5P3H3pU1gtDwzC23FqhQMIsKQmqqS6KL2irJ8XN6upZTb?=
 =?us-ascii?Q?AoVJSLoZFi0n0owul35XGVpx94G77mlbI1zHtXRdSbbOGzmJLUZbyVWwOnn3?=
 =?us-ascii?Q?wMLSRcZdPVfaES6nX5a6L+s5l5erBZPJxCTtjKgVxdINkA1/mDkeBV9FniUF?=
 =?us-ascii?Q?zX9Um00goskF4Uau1EEg+8PCfhWNQmuTlf4CygaKjg5AGQKlZ4VG0MDmAeY4?=
 =?us-ascii?Q?+N2vL2SQkS3poxX/8r9cFBmRIrIZshZWQ5p30ZrpMJkY9/Jd2OxIvL/qUk+m?=
 =?us-ascii?Q?GxAB38L2c87Vub3VJVFGt16bulb69LMMiNKYgpbtneDNRiuMpSt5c+72LpuP?=
 =?us-ascii?Q?4N6DFW4XEafAjjvZ2MZmJ7FkYmImQtPvEBDGt0N0gRf/vE9lF9JLLRecqHvb?=
 =?us-ascii?Q?zNIVOod1Sl/ZEQRL+6cTm+PGInQM0rwSl9YesEIKP/hazHhKtdysnk0ivITd?=
 =?us-ascii?Q?uBCTfzTWbqztq1AsnYHL8/t4srSWXV1VtZT2P1NTWFAdRZ/QIzXlt4O3fmcy?=
 =?us-ascii?Q?wz6Y1soV1wLL+W/YPIufa1V0GxgkAZTBCSlZOHrklzXOeM8u7yp54ffXJm8B?=
 =?us-ascii?Q?mAeH6ylKJPzCXZbeffNc6xes1pqsaAgU7lh9gZDu7fzBUtuwuBZDyiHt0+qq?=
 =?us-ascii?Q?BqSKAvoVn4LCthzq6hRzq/mgWrZ6RZc3qvv/AUMh/j0l3OEmDlEeM/DCX7uh?=
 =?us-ascii?Q?GcmEDKjyuzXnT2qC3ffdU9wYJC8jgpRFYxv+RLiekIOjfehwfNrhOsG+RKFD?=
 =?us-ascii?Q?sn4//R9ZM6UePSN8Wh8uGMuV642WUMzGFy/Tz3yS0gKRJwtWRpqpZfAj9wuG?=
 =?us-ascii?Q?5Eu3HVbxSodIEoFyKNhSL1CQmhZCacs/56pQsW7jW3Tn0ODj5Z3YkQtchJWc?=
 =?us-ascii?Q?YZyQqZgaUeLKp5G/fD/JbHLwPiEb+2yhNdSd9v6wY12MFuwan9t7ak1doGyS?=
 =?us-ascii?Q?MPEfUbqT7ue5yJovlqUz+UcNXbje1suu5NX96CXvqUtXyyxMWoq3+mZ0OOff?=
 =?us-ascii?Q?Ts6RFEtJk9KSdZ71V5OFBw/Jbxmo4mVv+E5XO3XfQKBce5KUQlboFjsAAupg?=
 =?us-ascii?Q?nOF+TMypgl5FQ28aZCCgoNGuLyu0aWmmPSlv7PzAhS1msLl+OXB9kjAEU7au?=
 =?us-ascii?Q?/yoVYz45UETsppGeyclzA6B4wNF9eTHXVlF2u8CIPpGe7ttDPNUo3jpdTs1b?=
 =?us-ascii?Q?hAhD82ptYOLUYWbRu6E0pB+wDmlKA5buKOAoo5aoCwLDo6V9/KIN+e9vecni?=
 =?us-ascii?Q?1nbJ3wEJtwJH8Ipohc5v0jIa11hE/rnIIRUl9hfPw1ugY8MB9wqd8nI/ML+E?=
 =?us-ascii?Q?k1hmD4PF9pnhO5FOY9Z+QVXCHKAXzG8JP1kM2N9vWn/molfDzvsR9viVfVzs?=
 =?us-ascii?Q?5zhXvZnHr6XCTxI4QssO3xR3jpKT110zSugplzo7NllYUWU5I/wqqB9tFJeu?=
 =?us-ascii?Q?3OMkpeU9qb0KkJbjHXV90CmsDj11ZwCdNmLs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daEO5m0zkTEE7la5jMvy7Rld/y0LkQzDx6NXksf35MSPte9mK+d9ljaLCNsR?=
 =?us-ascii?Q?jPuboP4liy16e0EQERALqe0TpRAmPpEP5t/w20r+chc4HhvJ2o1htNTebZvg?=
 =?us-ascii?Q?FsEjd+Frsf6SphNwa0GvowAuAAJGTlR/peM6vXflK3YUaiLQUowgMtLMhzKR?=
 =?us-ascii?Q?vx869leApqDHu7XNqJU7WYj5+JU3EJJR633DJmoPS68h5m24JK7ie9Osp0AZ?=
 =?us-ascii?Q?OGA9NuqhgO++iGOy/I9b2MOFbSS1VLuz1zY02dBfIIfeCAFLGpz8xg3F3Vii?=
 =?us-ascii?Q?6ngBcdOKAv9U6NymgUyQ0iUNaukKjnGWJgYQo7M/2Ktu6elbfQwQhCxkO32c?=
 =?us-ascii?Q?lhvz7XYarBLeHm/FSGxGA7xmQljaXncmDGNkDYlRx+oCDqbtd8PKlevyw9Ei?=
 =?us-ascii?Q?APcz6T6MhgxhheiRHshVJi5v2owYvgPnExXS9ZWgyUmUCVr3/JvzlhmBAeo7?=
 =?us-ascii?Q?g9pNgbVgcI9TKknBOmQyACbSmmGjEh0yTngBRe7QkSothykBZUNj8aRj2xBZ?=
 =?us-ascii?Q?0OO1EnneM1lpvp4Pv3xSOSWtJg6nQdK3jMeKECuhuaAlaO80VN9y2dxuqbPd?=
 =?us-ascii?Q?SREpJGLJvEO+zE/6duj1OqAtXxbpr8U8FtrM7h2/ZLWWccoFOF+J97JcL+dG?=
 =?us-ascii?Q?Q53ABQj5LP+EUaiGS7euXOcsGQyLfzMxczvVeeiahjS4+nrLnGRxGAzx1VqP?=
 =?us-ascii?Q?PUFxtmgGsRP2UxHCOeASK/vQ97XZO3Zru0SEwLn2PUNmbgSiPTb4fYZtQSwd?=
 =?us-ascii?Q?tpSwlwbD0TXnZqyzYcm5XXuZilpeSl+DVy9kUeoc3LRXuzbRZPZJw9vVAPcQ?=
 =?us-ascii?Q?moSvjdOFkJnYh1erFVn73Rlv2j+dGj4XPSARKJldp3OXu4i6uLnST/bpYyzU?=
 =?us-ascii?Q?kZNUxASTVYKqgS2M/ILZ/osTeh66QZh1sytKrl+TyQ4zzjE5neabXlxbV4Vb?=
 =?us-ascii?Q?TLij/GE+tD1PqSSaIjNMID2hdsS063chXEIoSs5ZEEjQtMFITc4i4iuQzNGD?=
 =?us-ascii?Q?hCNoErFiVsRlg53zkyd1VMM21PQ/7QhRz1o9r7P4MPh0jcivjDP3zxp3ueYy?=
 =?us-ascii?Q?JwuTV24C9tV6L+0IVuJpiEBdTK0O4V5m2twxT6/AgmVc3UazO5GjxKDQE5R6?=
 =?us-ascii?Q?gSck/MBAjTOO114AKlr/rKu6TJjnBLRtFYahjuvZhzWQ/heT+Z+ylGtX07vB?=
 =?us-ascii?Q?lw7uBMDw90nEkzMhBcRqDbzZB7k9NEJzIbotfebJdft7x7zBvCTJeyvcQHBg?=
 =?us-ascii?Q?6w7/giuwU7hF6GvqwSKE9qdQlXZ3r+G9uGu+JkTbasMIM5Dr0/GDfsuue5nQ?=
 =?us-ascii?Q?rNEn2UCPMZb4ltNM+SPZjj6F1bsLr7d63JgV0wUyqhj3bpYWo8jsz7NykGm7?=
 =?us-ascii?Q?KwvnXaJGYivhMDfkmBacxSFND3/HsgWPdqoz23JNZEeOlMozLTPgnou1FKEf?=
 =?us-ascii?Q?2d8yVwqoOTQZBJBFD4YIMlysjZHcLA89PgMl/3eDEAyPluL704wODuRTc4ka?=
 =?us-ascii?Q?uVX4vdIyzOILQ6Op2MTAZWQhJk2P0kepsRoe97YWlbC5CuViVY6rxHNf9iwD?=
 =?us-ascii?Q?db3Iz9tpwo2G0X4rT/qi4pQeqL5dGeq+DC2uainJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce1d3b-089b-4de3-f8ef-08de271680d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:13.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebUM4SQT18O0P8vP3qLJyG9nf0I/9xHOpJnwabUpDmTj0FQImHFaKPPRXLCQYo33ibJpDG4/KQqGgHaCr8Gy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

From the Kconfig file, we can see CONFIG_FEC depends on the following
platform-related options.

ColdFire: M523x, M527x, M5272, M528x, M520x and M532x
S32: ARCH_S32 (ARM64)
i.MX: SOC_IMX28 and ARCH_MXC (ARM and ARM64)

Based on the code of fec driver, only some macro definitions on the
M5272 platform are different from those on other platforms. Therefore,
we can simplify the following complex preprocessor directives to
"if !defined(CONFIG_M5272)".

"#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || \
     defined(CONFIG_M528x) || defined(CONFIG_M520x) || \
     defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)"

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  4 +---
 drivers/net/ethernet/freescale/fec_main.c | 28 +++++++----------------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 41e0d85d15da..8e438f6e7ec4 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -24,9 +24,7 @@
 #include <linux/timecounter.h>
 #include <net/xdp.h>
 
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 /*
  *	Just figures, Motorola would have to change the offsets for
  *	registers in the same peripheral device on different models
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c2a307c6e774..4193559c6b9c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * size bits. Other FEC hardware does not, so we need to take that into
  * account when setting it.
  */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64)
+#ifndef CONFIG_M5272
 #define	OPT_ARCH_HAS_MAX_FL	1
 #else
 #define	OPT_ARCH_HAS_MAX_FL	0
@@ -2706,9 +2704,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
 }
 
 /* List of registers that can be safety be read to dump them with ethtool */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 static __u32 fec_enet_register_version = 2;
 static u32 fec_enet_register_offset[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
@@ -2782,30 +2778,22 @@ static u32 fec_enet_register_offset[] = {
 static void fec_enet_get_regs(struct net_device *ndev,
 			      struct ethtool_regs *regs, void *regbuf)
 {
+	u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
+	u32 *reg_list = fec_enet_register_offset;
 	struct device *dev = &fep->pdev->dev;
 	u32 *buf = (u32 *)regbuf;
 	u32 i, off;
 	int ret;
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
-	u32 *reg_list;
-	u32 reg_cnt;
-
-	if (!of_machine_is_compatible("fsl,imx6ul")) {
-		reg_list = fec_enet_register_offset;
-		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
-	} else {
+
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
+	if (of_machine_is_compatible("fsl,imx6ul")) {
 		reg_list = fec_enet_register_offset_6ul;
 		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
 	}
-#else
-	/* coldfire */
-	static u32 *reg_list = fec_enet_register_offset;
-	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
 #endif
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return;
-- 
2.34.1


