Return-Path: <netdev+bounces-241452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81932C8410D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9047734D8D1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BF2FE56E;
	Tue, 25 Nov 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EV9Mr6b/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109702DAFDA;
	Tue, 25 Nov 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060695; cv=fail; b=iGJ7ndEYB2x0BUcB9IBHOk3kmdPKE8ojtikRVhyjL2CgI4TGUToJvxvu5Ou1XNp04rIhJyu0B7bmVuYO6admO2+kouVG3AMKcjQfZF3AVkripnTRaRSGD5xDgCWCpR43YK9Oc+ZPsQVfyBpb9UqKXCVbpp2dzW9vPrRTq0ytejE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060695; c=relaxed/simple;
	bh=HdsckBWSG95WlvPsTD6wFTt7nUD2XM45VlgF1rj8Z2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0XSiX6tiSLHa33dBOpB2/OM7L0WpShjK9BGvxe3kF6HxurYa6LBJ7vNtrKp8DkpYD0XzGnP4LaRcL61RbJJXWe4LRKpBiZuGVSFIuy7lZjAKChMCgafayRAD2b4pxidF1qs7/YM4Q+eEimfdiLm0FqUo0z7jM2l1jViwL+vS6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EV9Mr6b/; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/bwmZwE/TVSIw1jQzB5D+I+Nq8x5WpdhuxQQNGeryEFRGscOzrnOf2PGa5WqUygVOszU3UTmhjZfU+m79mjHDWxqpzphpByeQ+OZwfysTG+ogXCApkXFlJyr3B/+seECwig4jY+wWxTtA1smy7KtTWh2qhykFxuAy4gTDh/6jrKNQ7KlXPVhGNo59iR7E3ktgs2ce6aAZ3ME25S5wKo8oXcNIs7lmHcpixu9TxM5B+gzZNy5CTOHXIpDI1ylwor6gmnTP2VsMYKTN3V/mpI3kWXRAULumDh3725+FZIfcdf0hnLCME6dF2Vx/lvG3qP8XeLPVwzddCk8bnL8VswwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hda9IyWFyUZmh1WlGmTn8pzIuDPhrkp1AzeGFvtTXX0=;
 b=A2BVoYTgn0sNpzE6SlgzXugqzSlI9HHyTVO55GKv8S2k/2nKhm+3474hOEhmZHNBfK2FvxA/NOomkAAvAfLC7skhD4m++UTBKFmGoDGAYo2NsP/pw6ZNWGaiubbyg00URvN6UdfmgCOLmNoWjFMUoYTxgqjHswamSEi4nVBTo4pusCI5CXuktIGa6aTABnF3QEnlVpeCoX8K92fkiev5BWY+e+5jKzpeAQaQxucO3VnLZtEcAEDMSwIVDMJYlSf6J/IncUX/rkfRqLN+qFISfNU3ieheenRnTDUidTCxOM2388sCElMySGcmt6hHQyzaZ8vIhxC8wUe00HHpk2hZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hda9IyWFyUZmh1WlGmTn8pzIuDPhrkp1AzeGFvtTXX0=;
 b=EV9Mr6b/BcMVmYz3m6iG63ipAADCKF7wtTQK2ST364xWyYYbTmjWnis/5FtHOci9XIilTY+LGgFzs8qF4xl8+mhGJ5mn0Ijv0Qf4/R5cVyh56CONspUKv5vC05kU+TetCB/uSZGwA/lF2ytejxLM3mrJu6INC9JUJ9esiGy5Dc/bwEs0Ed4GFLqRNK5JkOSOSaPVxJZECFWG5sTIdAwQv07wNri3+vnlxdTPOpjX69r0xas4+zZcN9Frf+yUCORpJwuU5qFVEfIgOkZ1AkzA0XcUkpe1ydZtTqwlPhcJJlaRzrYW+XbdcR3vWAka1e2fHHdLyCI5OaFCqoIdBt84xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:51:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:51:32 +0000
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
Subject: [PATCH net 1/4] net: fec: cancel perout_timer when PEROUT is disabled
Date: Tue, 25 Nov 2025 16:52:07 +0800
Message-Id: <20251125085210.1094306-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e43a192a-c7ea-4cf2-dfe5-08de2bffd4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WmZ6hVYRYuWUabiI6HTnmFdYDLvQBlru6F8TudFA6PxgvN0O30Iy/yxJFcm?=
 =?us-ascii?Q?lQcfKy7U6FKb/dBqN0BaWLPWscnPsorJmeeDN/6d5JLT/kphY/FcuHepCUXd?=
 =?us-ascii?Q?XKZAJv03Wr98HQ+1lyvI+5VwwukPozXTWReUJnYTin2419w5WXx+cWaQXnze?=
 =?us-ascii?Q?WPRwjbGxtXvAw29aVDVUISZsQ6BdTC/gBz6EhYSqHTXfDegl8KFWcnLIlQEW?=
 =?us-ascii?Q?DokMxhhVaGXBTVV/DyG9eXDFFFDioTORh57jSY73pyCkFuDzy0DI1qoMdmaj?=
 =?us-ascii?Q?z4yP4AnhwjWF7So31DA+fwDbqVTY94Go2Y7DZddg5YRSPiD+uY2A0/RVd2Si?=
 =?us-ascii?Q?I1BLnJscVbfGq3U9E3RBbXKQAC/SGcfrs2NWO5wgGILmTSMfcO+Nq62a2HiB?=
 =?us-ascii?Q?9ifbK/nhJbO+em7VBSFPxi7c6IHHfdFCK9aiYWBTfDKyMoRghwb12ltDP/wu?=
 =?us-ascii?Q?lIzKFbYATMISQecTCJYxjXVwL5niBnZo4BRx/eqdduKmZvmEnmxkXoxwK3rz?=
 =?us-ascii?Q?Q3Kxx804JEF0JQ8qvFHIlMSrw2L3dr+HYE3Ih9wxUy2wpS07TXjNLPW7wVEx?=
 =?us-ascii?Q?OUWzH1snFZNalPEY+IDt1KfJTjpCpMnjdW8Yp5Kh6ql7ha4GDAFoq4HadjcT?=
 =?us-ascii?Q?65unhKe2hm/qfRif9X/H8/dKuDu0e0zECcpllrfZ8ypmbF5fMt0ZH9SI8gjA?=
 =?us-ascii?Q?oGwPEaS6TEcV3Y6BHvvXScXLyQuCljPczJm41a/CWF14tninWBkqV/rqArD2?=
 =?us-ascii?Q?OOm731gBzcIOvMvC2ayI8s2K0qYP4D/tPN2HU7UB3zimAJo4o1jtnn3FBV28?=
 =?us-ascii?Q?LATwu0N9Kkc6rjDV8Y3OlFEZ/PSfpUkfqvOmsESmLFjqqEIPrJ10UpTEuNoJ?=
 =?us-ascii?Q?IHJ1Du1sscB9/jfQAefJrepjRk+bGBCdvD1UhNNZiGbNgD7gTWna5W6dsSMF?=
 =?us-ascii?Q?VBzzhk/5JQHSVin099aY04RXz+nWXxAOhLgg+l6jz2UtqGtHuQuMYOfH/+5+?=
 =?us-ascii?Q?FwdZ+EQoDAwcCpWbyBlFSKE6HgenWmTkT80iZZJFtAo3chTZntf1HzSjZr+u?=
 =?us-ascii?Q?wknt57zhCJdYkNPlSpqwYD678tZtRmjQXHTREy4110WiBohEby8XCa8c3Smx?=
 =?us-ascii?Q?EME0DuVHa6CjbJ+XFY939kd26xBrRbVSRw64xHtfv+Xa4QGExj9FRY55+bCV?=
 =?us-ascii?Q?wN3/j6MyOwO5LBnZQKq4zL3tm1PMtR56+UXUtXrYBXZHR5Ac0KlZRqGLmdtd?=
 =?us-ascii?Q?LPCgph53kDg0OwWDz3JgXP0Ihy2Nf5Avu8+h4v9KfWtRJD2TfHrPQCG3x7+N?=
 =?us-ascii?Q?mOU66lwJYZJfgNQBqPm9leRdjbDmxiOvSWHl3DZvaIygQiTQoHJZ4BO01kFh?=
 =?us-ascii?Q?mZl7nA0sTsSxULCgUjH0kY9jb85tULA5MVBGNRSjaOvH6OOZnpJZCusLbBm4?=
 =?us-ascii?Q?Laj6T6W2H2DSOoduwNtLHozlYOyQHmywzJz4h5wFC64xpO5EmbkVXOdjUgc7?=
 =?us-ascii?Q?y4RhFJYqQjEcv1/e61Vg3gEca3okFCTZbiw3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qww0Hw/DG205lMKJvJjD8rOCzhRE4EpqVMAjpLsSMnQ1rZ1TGLg6mW0Y+Dlp?=
 =?us-ascii?Q?wO0yN9ox1vCpv9Hw62su2sdNe1fIjb7wfHQ5ZdJseUGjgKFlwAXQSADi3qU2?=
 =?us-ascii?Q?sKM5dJ236qoJ6K8J1lI0RIosrRO5InO8V8ytf8YQhv9ZV2anlB4OpxzOoOFu?=
 =?us-ascii?Q?CCl9aaO3Lczyyu7lQ8asYzIWkDPID4srn5jpa+PeZWmD11FIC+zli6suA4OL?=
 =?us-ascii?Q?UlMapwSA57RcNi7Zy1MktVuYdjcJVNB0Ndg5cr1PHMTQbb8ea6dK1hI2MfyP?=
 =?us-ascii?Q?v4H/Axc2YDp3d2DTpGFZ0XUVNv8cox0GuJ3REOJ8Cuhqk3UUwvqK8kbS13De?=
 =?us-ascii?Q?qhKddCqJYwLQcQ+J47FEvF91mYcRYUxoyoXZuXu48XPj1W7nj7dDQKNy/naS?=
 =?us-ascii?Q?MWJFp4tSGnjb0zMOCu9+r7j/1fk+qpBja8tb7RGVgaYbhTP/qanOl/GyA7EX?=
 =?us-ascii?Q?g5sO8hfRMdsOMn80l9ffvRXEFVbUbPjv5TedUtiMbkl9+YqP3oBRMIScOAAQ?=
 =?us-ascii?Q?TU/NNtyGNuOw1ZcyijPKgHknB1QKXJTzb35H+YJkEcgL5+lBESZbfpQpYgSF?=
 =?us-ascii?Q?wdlKOl8l6Ot6LQ5e3tAWKVd8oRzKaG5A6dmXqF3DlDt8jvfKX1DCALsnJS8B?=
 =?us-ascii?Q?WuUf9mLHTl1lwbZ8zHG6U/FV2f0sE5Lq3iuy+yuyoqO0xzeCi7lpoPnNcTQ0?=
 =?us-ascii?Q?PP2v5m3/Mxym2h0J4UPqnArng9Izqwg8pLrJZ8fkxBa9UR9ZYWuVa35ZBm6I?=
 =?us-ascii?Q?sNIPOOV1//sE0358/MbpnmZ+CriNRrcBDAhqGhvl6vAsIkM9q+G9EooNBWU2?=
 =?us-ascii?Q?SsLwg3yQmptCthFC8YRCbW3Is5OVq7Du/inWgywt7GSfPeGf8sPsacq8H2g3?=
 =?us-ascii?Q?WfRw3vUqmFKQ8/TB1jkfQWcoC9apvuuXWwitU+TcTzPQVls2krXYAa6QWhoK?=
 =?us-ascii?Q?omPn2huJeismers2VdUhN+L7G8yPsBmpiEv7q8xhG+D8ucgqBfeV1kCZmr9u?=
 =?us-ascii?Q?3LKWhmxbuSjnHzWSNxNEZn+2eDa25JHiH3LNfA0sF3/hHyvrBKuoUZVyE8GH?=
 =?us-ascii?Q?IERYzIuCqZY5a1xVJ3mLBmiJeJZz+joqFE2BSe1Zl4zjxhi5tMmvhvGSYT8z?=
 =?us-ascii?Q?ypKPbVDIzujN7p2o93rUKI81IEhvRRNnr6a8gqLy75Pe29eUSDweRz+6ZPE+?=
 =?us-ascii?Q?+xk3Hk0NULez/gaulZTboPE9y9ki1dBm17vd7A8yTIEWZR34CAe5a0/KYWUc?=
 =?us-ascii?Q?v4rl+RVkcnEJcnSWt+H2bgmTnSI2nTj3tFxIQ/dtPrrI0FHKlJVD9p6UUI2H?=
 =?us-ascii?Q?bRUfZTC8hk9dBS+LPQuxqQuUEg7gnkFgW4kr3jk7UQq35tI569AitnZC160o?=
 =?us-ascii?Q?q1Y5qlYE5+qHeUmpoNq3hBPIJkToMA1rwj/bJKEGeo9nithy/slwPkUm5qHf?=
 =?us-ascii?Q?utkxgaoA1sfQQxm+Vd4nUjJuw0Of05Mn2KWqoFRi3qFkr7BO+Ea58TS2ouHM?=
 =?us-ascii?Q?8cm0Kii0kezJD8v2vqrXpAUqF1x0uWvuCBhoReBN11mOL5h+q+hZ5c6eUmKS?=
 =?us-ascii?Q?WjjdX3iQsSFvnPXy5H9zwjUkU+IYsBv2QnX2TWrW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a192a-c7ea-4cf2-dfe5-08de2bffd4c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:51:32.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODMjhtd6FyVj/uGGud9ERVYMwGz6BMuSxZCTl2rVSjf4C+/pYd52XARbg7oUwF3cxS5OfNtCLS0gct2XoKOGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

The PEROUT allows the user to set a specified future time to output the
periodic signal. If the future time is far from the current time, the FEC
driver will use hrtimer to configure PEROUT one second before the future
time. However, the hrtimer will not be canceled if the PEROUT is disabled
before the hrtimer expires. So the PEROUT will be configured when the
hrtimer expires, which is not as expected. Therefore, cancel the hrtimer
in fec_ptp_pps_disable() to fix this issue.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index fa88b47d526c..7a5367ea9410 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -497,6 +497,8 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 {
 	unsigned long flags;
 
+	hrtimer_cancel(&fep->perout_timer);
+
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 	writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-- 
2.34.1


