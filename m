Return-Path: <netdev+bounces-241453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FAC84116
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8110834BE4D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0032C2FF17A;
	Tue, 25 Nov 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jt2YKyOp"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B523F18EFD1;
	Tue, 25 Nov 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060700; cv=fail; b=oWJPOuoJNwvd87p7rFUVQ08/PXk8qnBhwvrN0ZklqxFD8t8hh1jYo5kuA5lMBCqWSYO4SvlFTjDmC2Q6XI3WGiTtxdY4KdZ1L3gmGoibVO/7iWF/90ksgVyxCTvjWuK+5rWQFs+YRVMrWx+8VN3tZA0odjFPvMRgP9Jal0x99zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060700; c=relaxed/simple;
	bh=Cdg3EZmY/x2Mq5KObR+3880Klb17Kl3cX8NW6ZYeLcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/svEz3g7kCuku0ip1QybDcr9WFwk16TmVCYRLSg/Gkz/OdSiivmtu/oV+W1B8cijDXzT1NuNmbr/3H7bRej6V2vBlNYLS51Yxj3sfGJJXNdH6gnF0fWNPR4HB0ZVOm6IG42gYUk2vTV6ggFZeQUFoYU+MY/qUXHg0PocFTa3dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jt2YKyOp; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sd7WAuhg1TWwn1Fiw2Yj0GMT13eC9x3qvAi6cpbNeBWPqIYulOZxtB8vhADpXu25gno+45HSFmER5V3DqIFMEQvsKmW37ETskZdIPbSImGFk+Z9YoFIpLQ6LJcADAymqC9SjdvNe23tNbMV68sfMpr/LVN3xnSdLg80nAr9G8eypyPxvCsAjb+Szd9FvBRGtXBgIh0AAZO7ZvHO1VbM6vhMwHPthFZC/TUdn+XprM9qx4o6ILH2JVLTtqoYHlKeGDUbo9cybuyFm9Nt5NOnG6Mz2625/aRo363z+jGkMPWZBX86MGiLo3CYpRh7Rtr1HjgMHS34Kr51lF5nqVZFrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0aERrrEWRv2NDTpiFZAbQxH09FpUXVdUNQjXzjkYcE=;
 b=QUP+7aEALlJQC0hs/GHkFwY2gnU0GrEalPCHWJ+xxx+gcLq1OzVxPWuLmPejWaN7D3bY10Ke/cZlka9uNoV3rz3LTEbVnZBUNaa2fBlhSoKiCncokyjEsnra6g0FXVYxBq7572w2O+NrzE29zrvETuCFkcbPmJ2Qcq9rpkO/9KQOhPwFS+BD6e9Wg4FL1Zkd1a/rZZCBMo4BueWFRqzpNGDsaynja0B7MggLYO9uEiPZnaYb/wu2BDmAmyBKwa1a8fQ4Bsb7BTm3UeQSykIcqjBVfDbNoJZLBUIffsfNVFPfRQnQ4T1cwhNnul+32QkldLdX+2FD0ZE1ZcIzLhOkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0aERrrEWRv2NDTpiFZAbQxH09FpUXVdUNQjXzjkYcE=;
 b=Jt2YKyOp4Nd7Z4FW7va5L+PRZMalqF9v2O52vSw78ghTG+djEiofaj71+KRr/iWzFo9GV/H2WnlbRXMIex1g/3tH8etGNNLnuUUTLRSaTgNkAZ4jzYc9W5UEiJVT7lEVxbONkY0yzLebkynjaA33saySW6N1NV6q6qHL5Izo8b10zlHmZfc3Sv/pOFhqoLwUTw7ol65DXzZbJaSs4W9tNk4PY3lfC95RIQO7D8sxxQn3Cgb8AQmkifgZaLHB8/KBAPu2IfOmQiBATBN2vOLiuPnZ0nwyCyRe+use7W7cKNwHomcXi9lN4zPthaosASQ4eLQyKDhTALHHRe4d9RqeGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:51:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:51:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] net: fec: do not update PEROUT if it is enabled
Date: Tue, 25 Nov 2025 16:52:08 +0800
Message-Id: <20251125085210.1094306-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125085210.1094306-1-wei.fang@nxp.com>
References: <20251125085210.1094306-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e27d24-dee4-4b08-df70-08de2bffd71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjCTkMmyG3cgB51nTpICRuoMrc9f+DXjjhyOxHRRQ6hZxZLim/PfNg8R3N3Y?=
 =?us-ascii?Q?y9HcvIS6ULeEbg74i0S2B1pwgTcuOiy5z9Ppx5k8WwR+QfTyg+1x9Qr58EFv?=
 =?us-ascii?Q?X+L1XZ89oaeO2vSr/S94FhH0xVCZnI9BkSTfCurjNkhApg9WTJnBRTBJSaJF?=
 =?us-ascii?Q?E5h+ndeAI1uzg7Br38rXK4tv+ehqVUGlbJ+Y/yrFnd7b/Pn/I4wA2kD8Nx0m?=
 =?us-ascii?Q?qgZik+e/UmATzzsDBlonHlddG2MWl7GbDrJ+bdDq4bkIVWFQMBulxzJVGMuH?=
 =?us-ascii?Q?oZsTxTF5Y0ewTP+035PLuwc2NvfewtFIQgQVRn23ekv++nb2G0rx8/ERx2Jl?=
 =?us-ascii?Q?onxOCZk56tv6GSNcWsaqsRpCC+SUIJHZB7vzR5CB8+6xfOSHyh+G3lXFpuaE?=
 =?us-ascii?Q?aBz7kEivNTNVpj4FFXwkUX4TDKet2Lv6e8x/ddURhlg6creZr0qd8RldUp9Q?=
 =?us-ascii?Q?2mTPeGNgi8JFK9d+PCMSVSMTJdNN8SDb72kb1sK9hgcG3K/C46fdW8YSb8B+?=
 =?us-ascii?Q?nm2DeqATRq/VcQ0Q5Pw5PmTvizN9nYCnXhtEgOr93r/31fRPbB2VXfprPpfj?=
 =?us-ascii?Q?/xjiHOgVmiCU4aA31f980r9zsghUbdqlCNZ+L8zQkkTBqzrp6C0Kq6bChph5?=
 =?us-ascii?Q?VRpg+blzDDnfDazg51IFHH/GMC+6sdLzTOsRgylth1L0RW/Y1/CeGU4ddHnR?=
 =?us-ascii?Q?UQyeDMgbU+0bCJitMk2trbdbEJNU+jkCW5lAkyi4bu0qUGXm4lU+RnrK6zvn?=
 =?us-ascii?Q?KrmCzwVb9QnmoFN4UJMTYaTBRUw5FwNKrxzKSlPoEVvSVp1sw1RB4CPFM1Ur?=
 =?us-ascii?Q?lSrBzwd/zEqU29pCkaUQPU39ltBGqW8us0swI/yEgG268gz6zukRDm64s8Jp?=
 =?us-ascii?Q?Fk1Yqj7iHLGkbS2WyuQ9HB/3PvM6ph4yyBnwWGAn6hpWWjZ880w7NZMGR9fa?=
 =?us-ascii?Q?w9xgAiT5AxpDmlwbhvjjOa4bAjzAd0zbk0iBCdaxj/lN1H2AbYih4G7zhCYL?=
 =?us-ascii?Q?qrGGYF8P8LYM3/o5E8p/hJjs3lNY0NsHY3HsB0b10SEn5E7L6dl+gUuHU//O?=
 =?us-ascii?Q?9K5p8j643sTTFdYnUpYwi75Th//M0IYMWAYKh2EPCzCfxQGnJtzTdgFVTh8d?=
 =?us-ascii?Q?+WF7p+vK253+s3Nm68K93dqKqI5vCmIS7PJP+mOffj1P+JzzgqbX2AjIYCg/?=
 =?us-ascii?Q?DS8jH8vC9nNi6S28PzlvpbQs373vqiJTS399berI2BPZQznrs4Er1PdaSjRC?=
 =?us-ascii?Q?Mf+rcb4BBBTjrPgBYHsjxVQfScjA3O7mXpjT3l41k2wwVVrTV9ijlM6NhcfI?=
 =?us-ascii?Q?8q2OvIdz6RZka3Ll0pTvE5NOAUjMQoq8MKoTPYksW4Y3M64rKFtcaS/cl+Qz?=
 =?us-ascii?Q?eTaQ4+PJnQi0usyz35scrTxxOKJbWZ6bnhKSY+xgUAWwcJi2Eh6vhliYC6Xp?=
 =?us-ascii?Q?bO/lzc4rbnbOGDx2/RuUbOAQRR3Yyxe3qtpFgSfecNluMfZjGSnIlVGxmId2?=
 =?us-ascii?Q?Kyu1SYn9ChBR3Pr4D7tkQNDQbkA8MvA9lPeb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNjvPvb5dCf9mhc6Hctc/W49QuzlC/l1ctfS2HZ619Px2UUm/S68O626hn23?=
 =?us-ascii?Q?tSrf+65BjPEY6rUp7SiAh6/8UycXZ7kzlPlfb4IsQemryP0cvWgQx4FbdiTp?=
 =?us-ascii?Q?wh+32Fm0EYb3Th4UjjMozPD2gxSJb66jWI3OlVA6aKjnGHDlA5h5pIXrXrWC?=
 =?us-ascii?Q?xMfnP1gJqxjUGTPfYFlHXK1BaxOy2klRqcau1KRK3416biYWFFldYeci/TyX?=
 =?us-ascii?Q?A8zlBSlSxT4N8RwOAfQM0klJ1i0koPEXCT0xa9JzOVJgdm6yLgLbm83nin+R?=
 =?us-ascii?Q?C9yo5mYh0aB9zG27krE5pRd++GNrkm+ZlvBquCeoYjF2kYGiHjcN+LZsQwM5?=
 =?us-ascii?Q?Y2JkkoPDotfeqnDZ4LFC1r38lVTL3N1jyBJ0baNAuXAOLQe4MCISbuCJZq0J?=
 =?us-ascii?Q?Z5YUKOzTin+VC7uaVc3UzL+3aZnY1Mltz6e8mi66/aTSTD4OVaQlQsgqMW1e?=
 =?us-ascii?Q?N/yD65JEGmVSX7gTXmvjV/dzMWi6IDaOxDLRB86lOfIIlUQ6QNrwixBHGTKq?=
 =?us-ascii?Q?YpWjoW9RPn83DO358FevaVP9j35mqHBGntYl2bH/ru81L/mk80oQ/crXc6nr?=
 =?us-ascii?Q?zyCg9krS147NPFuybZjwG/NShnbTOAaRgT7M0SbwjijShHBLmP8Dx3DibURm?=
 =?us-ascii?Q?3LUykU3s34oTFCKSE6PQ6YjbRqIcNJszfRYYyxVC7EO9PDkuQgHr+iCpjU7T?=
 =?us-ascii?Q?GYDWuTb0QdNIL7edjnX5DV50MN2UF9Mo8CCfkZrBhQRZH2K9/flmlRkQ+2z8?=
 =?us-ascii?Q?+XoDuG4sOjB15sRQTsxz/GpyC7++3S3xPfcJBBbWWM2YQDh98CnzKFhQREM4?=
 =?us-ascii?Q?vxknaGpreiJpvba6R5MLRWHHNS8UoqPnyeHuidwwK1nfR7p54Fh40gkovaEX?=
 =?us-ascii?Q?yERhJbP3gJdYXNE8CaKuL8MuM6g0JbDW3UJB4Nz0VqfjZYyXOqScqn7OzKUl?=
 =?us-ascii?Q?Pmxg3n8pq0g1ENfyWJZpl0wpP3SEjIrdgz8Vp4RDVSYlbTW7Ekfz2hTs1LWn?=
 =?us-ascii?Q?YdtUfKSXXjBL2ga/eHZjhS8qWlcbRd6ur/ujCPnEsNFYqzTwpjeqWDMmo/h5?=
 =?us-ascii?Q?0szXjGY1/9gjxJxVAA/hGw2OQI3HeQFxr1E6DyNdtu4Snbt3Z1BWFhVBNWgO?=
 =?us-ascii?Q?RebY93rHnrt++7a8tUVlayb07/U6uq4AC7pTpAu80W4IDS3dYRYJ4cxN4B29?=
 =?us-ascii?Q?0NF7OBR8kruZNIOa0Jk5hHGGCqGBtTw9a20l98ITDf+xingC0f0T5OsaAgma?=
 =?us-ascii?Q?2/Ff9yUv7jweB0v9c3EkifYZvTPR7Q1BeIPsGRm3IjfSKtve7/moHKnJvd+7?=
 =?us-ascii?Q?57b9yPCLOLPydDgAYaafR/EhQw4iKd7fC5bEEZY70djz+6mGtna/9+wjBC/C?=
 =?us-ascii?Q?HFSPX5O5dR6G2SDz9hSixP9TLQQAUJA4qzJN0nBdV/fESXh7bxogoPFdd0YS?=
 =?us-ascii?Q?w2+Cw9wpOwRSFTJbAnYqibVtvQEyE+3oXCDuo7UlxsBQaJ69YMC5KyQDNCx8?=
 =?us-ascii?Q?e0Gi+2ATA/5dS2OgshHTjh46qDQz1rcI9kUKaLXxsxMHxr56ic0jDqkO3YDs?=
 =?us-ascii?Q?NLc2VPaZZN528ov+1S32piGMlmOGB6TVTYwK9jDC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e27d24-dee4-4b08-df70-08de2bffd71e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:51:36.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN0IIyrgL8yaYeqL38F+G/3JhkLPO4GZvf+Wz/j6KBD6aiy5itZcLcpdwh8SE0kg1C9BmqvKPUfh1xtYZiI3Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

If the previously set PEROUT is already active, updating it will cause
the new PEROUT to start immediately instead of at the specified time.
This is because fep->reload_period is updated whithout check whether
the PEROUT is enabled, and the old PEROUT is not disabled. Therefore,
the pulse period will be updated immediately in the pulse interrupt
handler fec_pps_interrupt().

Currently, the driver does not support directly updating PEROUT and it
will make the logic be more complicated. To fix the current issue, add
a check before enabling the PEROUT, the driver will return an error if
PEROUT is enabled. If users wants to update a new PEROUT, they should
disable the old PEROUT first.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h     |  1 +
 drivers/net/ethernet/freescale/fec_ptp.c | 43 ++++++++++++++++++------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 41e0d85d15da..abf1ef8e76c6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -687,6 +687,7 @@ struct fec_enet_private {
 	unsigned int reload_period;
 	int pps_enable;
 	unsigned int next_counter;
+	bool perout_enable;
 	struct hrtimer perout_timer;
 	u64 perout_stime;
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 7a5367ea9410..f31b1626c12f 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -243,6 +243,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	 * the FEC_TCCR register in time and missed the start time.
 	 */
 	if (fep->perout_stime < curr_time + 100 * NSEC_PER_MSEC) {
+		fep->perout_enable = false;
 		dev_err(&fep->pdev->dev, "Current time is too close to the start time!\n");
 		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 		return -1;
@@ -500,6 +501,7 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 	hrtimer_cancel(&fep->perout_timer);
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
+	fep->perout_enable = false;
 	writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
@@ -531,6 +533,8 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 
 		return ret;
 	} else if (rq->type == PTP_CLK_REQ_PEROUT) {
+		u32 reload_period;
+
 		/* Reject requests with unsupported flags */
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
@@ -550,12 +554,14 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 			return -EOPNOTSUPP;
 		}
 
-		fep->reload_period = div_u64(period_ns, 2);
-		if (on && fep->reload_period) {
+		reload_period = div_u64(period_ns, 2);
+		if (on && reload_period) {
+			u64 perout_stime;
+
 			/* Convert 1588 timestamp to ns*/
 			start_time.tv_sec = rq->perout.start.sec;
 			start_time.tv_nsec = rq->perout.start.nsec;
-			fep->perout_stime = timespec64_to_ns(&start_time);
+			perout_stime = timespec64_to_ns(&start_time);
 
 			mutex_lock(&fep->ptp_clk_mutex);
 			if (!fep->ptp_clk_on) {
@@ -564,18 +570,35 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 				return -EOPNOTSUPP;
 			}
 			spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+			if (fep->perout_enable) {
+				dev_err(&fep->pdev->dev,
+					"PEROUT has been enabled\n");
+				ret = -EBUSY;
+				goto unlock;
+			}
+
 			/* Read current timestamp */
 			curr_time = timecounter_read(&fep->tc);
-			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-			mutex_unlock(&fep->ptp_clk_mutex);
+			if (perout_stime <= curr_time) {
+				dev_err(&fep->pdev->dev,
+					"Start time must be greater than current time\n");
+				ret = -EINVAL;
+				goto unlock;
+			}
 
 			/* Calculate time difference */
-			delta = fep->perout_stime - curr_time;
+			delta = perout_stime - curr_time;
+			fep->reload_period = reload_period;
+			fep->perout_stime = perout_stime;
+			fep->perout_enable = true;
 
-			if (fep->perout_stime <= curr_time) {
-				dev_err(&fep->pdev->dev, "Start time must larger than current time!\n");
-				return -EINVAL;
-			}
+unlock:
+			spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+			mutex_unlock(&fep->ptp_clk_mutex);
+
+			if (ret)
+				return ret;
 
 			/* Because the timer counter of FEC only has 31-bits, correspondingly,
 			 * the time comparison register FEC_TCCR also only low 31 bits can be
-- 
2.34.1


