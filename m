Return-Path: <netdev+bounces-216376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185DB3354F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4920C1B2355B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB7287518;
	Mon, 25 Aug 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kh5Yjb3O"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C127E7DA;
	Mon, 25 Aug 2025 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096660; cv=fail; b=tXK0FUpZnIYtHAdkZNhOvhlYw6QMtYTa2Y4Ed+8N0hzpP44vT0KZNVGYVOZqWQiZ538bg0LgjJrl7M4JBV96YiS+yDD0EuDpqOMx3cPlw/HnojvsxguulrENAS7lN+nUzH09nJIepOI12zrdOCIgnY12fx/aX2BHLvRmkMdxQWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096660; c=relaxed/simple;
	bh=UTJojxAfJgGXQCOwb3TK5Rtk/qCsTObezhIbI0siTzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bisv4PYEewXqQR/1t3XHJsA/VQrpAMctDFfQPbLOQ+sKeOvA/MElDgMJqHt5pZ5dkSzBC7nLf62ZyeIt7s4ffxVwf8bZk9upgtjax95B4FXANoC1ShXTkpmsS4xP6m0KXNjB0wllacDkXOgJokDxfeBSM+gtRFnT3yFI1EOFZuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kh5Yjb3O; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGwlJip6MPBhDeBcOZOMb7gzApTVLrgjDmkta5Rwp7v5iyjLyVNHNX3ZQpx0pZGRzRwLrNY7OE1S91HfUKzsIr2kihVw+QTUpAap9/kUZ0RmskDmO1CTjgtqR0CPxoGT03/ENFiby5PZ5pIBO+SNbQsWdHzcYDCi/DNohEn/PlP5cWErD2OOjiKuTABIaeQV98ijMNDelG0VBbCdKL2XxKjqtYzq5kUo6tuyujmdiv0S9RyVBBZQx1r+bksbQQg+kg/phmtQ/FmNvFrJzdgetHyE6S8EHdf/tOKGYaq8hFVX7WBT5FrbKVvvCmTK7PHY4Rf58B9f24C7OvPTc/nWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=Lg229erdLDAM3AQ+xzD/eJ28j+kqPGDjrBhH7GBtiHDhGsEKuMlqWWNugto1hssPPp1w6szW3BlFO1kvI3WrZCI0dZWeRH9RgVq/C5wFtKwSD3FbIs7bV5FAgY8w2gysyaHPMV5GX1FZIv+II821Kyrw6Or1ZEQA5p5cjpvPXTh8O0bAiAnBgQZEmrPXOvELm4GUJ1at6zyGuK8b9Mm9fX8cvwfZe48SUVF1droFIkISDDJr7l4qnBwVOnIrwhkHcuBwZfFMKKRUFnGg/2K3/xWOiH4XB2uys01ZYHplCD2apUKxmCT0t7c9n1Wg1UZnJceosVtleEP+Dz67wb961A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=Kh5Yjb3OpSgG1oyQBy/EQwAwmJge5gF56pW+RYnma4EHgo2cRlyZkVbMGlZghUoh3j3es8p5dUpETBwD868mnMzhe/FiU6kSWGvZ5T5R7pShl6S6+fsrUX3OQhjzNFhL2eShCdciYIx8ZVhQ9P4beQ3fTkDu/t7qCTWFgFGNV1wWQBil/epEO1f3RJ3yBe8OEnt6645PRojGDETue/kJNzz9E8aSbT88BFXpByKY4l/ZInwiSMBoigxkmvljW91oMv+jQwTc87Rl9B0i07+BuKoxZgdXbnYuozZHwBOOubGk4bwDLVKqjsUgp4LtUkbh4ilRkmjtNCROnsXiOsY83g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 11/15] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
Date: Mon, 25 Aug 2025 12:15:28 +0800
Message-Id: <20250825041532.1067315-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2af5cd-3798-4430-55ce-08dde3911c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjcL/x+8Ss/UkCPXNORIsQcCZt2UDB/98lUEVL1rnMYUHHliPE6qmaLD8AKk?=
 =?us-ascii?Q?iMNtjT9ZWPBNFtMdRMXfXHcH2gl/fsP/CyGI/GjZ8O7LF2L5TnzhKYr1XONV?=
 =?us-ascii?Q?savv8Ig5sKdI7zzl/iPvtsOea5A2FUzGLWglUvQ4dftlEiXEJciZJnRrlmQy?=
 =?us-ascii?Q?Bg66RzQhfYYovIx/Dm7xdzISG5BAKkzSPnc7mndkxxXOK2cBhOY2uXGNHRZl?=
 =?us-ascii?Q?oG9ldDz3bYX1n83GBy3PA47AqHSyLUsDMTbUg6kyeIPc/lvyBiKn9zfG6rkA?=
 =?us-ascii?Q?S50Av1uezG7/6jR8kdnO3kBNzHkhPlIIrax36tBrFfB1a/wyxfGynbiJeVxE?=
 =?us-ascii?Q?uVusOHPEyQTgbCpNwTj2apqNcGCe/aVMwCQov7l4JIyhQf7fsJb4B5BAPhMA?=
 =?us-ascii?Q?YXGosT7s/t5YvkIb1IX0vcIgUVKuQYUMOiV/uIsYhhNWAs264PNEKL1wkeWo?=
 =?us-ascii?Q?nUd6qHcYz4M3ar/XStnZD3v1i1siRbpGyq+aDBHkCUj8yWXI59QM3Xr2phHt?=
 =?us-ascii?Q?m6FIzl+YWcnVu4a7Ct0LpGEYGDzW2THQPU1wyDSs/fkbnr2aGno9B5VAVg4j?=
 =?us-ascii?Q?RP7IIuH0PmM9t/RfoXMe4YW+EZGWeSahQuLl2nEZKTzLRg0FEP4QOur3WNHd?=
 =?us-ascii?Q?1euJa1h3eO5y4xLMOPRW78z21cOiRDQ7vc0BY/PI5I1bOPHSq20ke7iCpsJo?=
 =?us-ascii?Q?/0z7EHSfQohq4geh4jIHiUD+ys+z42NwKoQ0DQR4Al1pJVo4gDxkN9iw6bkp?=
 =?us-ascii?Q?CYAJMbTh+BHUj3I6SZLS0daDFBg7JkVdlO+4t2ojI4Xg4Cnh7vAn23Vlhd19?=
 =?us-ascii?Q?Bqmqc1ZN8M/uKTEWfWaxWQOzR0/dqO5JD+2/atR4x8MD+uXuiucKR1cfYnfS?=
 =?us-ascii?Q?c5zS6Zl9exRCxfrIV1uSS2s6a+IWSaKLtqKCt4zSPo/CwNa4p3Kex3Tf8Co6?=
 =?us-ascii?Q?xraIA8KfS85XgQzcik1xrC/bpocj+BAm1MF+7+of0E/I457UxfuH3lFB3PlA?=
 =?us-ascii?Q?kXb7pbBE3iKkqU/NhFsn8+ZrAN5suXRk93Len8Dl4waSPEDXQ46sspHyXWn6?=
 =?us-ascii?Q?hAT4dGiAXPQ275LjEFdHwab1DJs3GmobACQUBU8cSCmzY1jjbBMfhV0Ym9c9?=
 =?us-ascii?Q?0yDZTQvYK6Ia7Qx6LqKcZjYckV7/Biy2XFNJm9z6CVa7Ega14gUnQW8N7GOc?=
 =?us-ascii?Q?wd/zJfor9MBGSir7muCULQzjZywkcBnsj2dpZ3kB4RBZiMS5dvCe9MZ0Qpvs?=
 =?us-ascii?Q?G/Bx6xEnMPnSpqqxdrGg6OCz50iMPUc0V042/kWtcIq8zVToasat4ifSMWzb?=
 =?us-ascii?Q?6jlov3MYGVwO0r6pHfSWMXL/UxKr7d0Y0ggvmELLBxFpYewYn9nxnTEvuULd?=
 =?us-ascii?Q?we7Qu0T7Owdyu8Vc3DgGKgI94G5Na2V1CqckOdmqCE8JbGJAj72VPL2eABeM?=
 =?us-ascii?Q?wC/FgH189wDDkXkdL78HqhWph2iFFbLEHfyTI3IDma8FTT8sXC6ANl3bXnZi?=
 =?us-ascii?Q?eepob8IoSnGQgwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2U1BbQibzzTZvx8tbitTap+50h/BLSngiQ/4ojfCVmr0p4e916shOadfOqqr?=
 =?us-ascii?Q?+sS5mnlaNHOQdTRH7vPQJKERfGLq9Fcs4FmEhe9KSmbnPfDRgJ26YdIrhPFy?=
 =?us-ascii?Q?B1eYLWwLkk4w/jzlOLpENZ6o92L18zm0VfJCENqrNUGxoSzoZAq7RiWnxoaY?=
 =?us-ascii?Q?2RYJiUzBetTdQhVVP4FYq67AXmlAwNJU6MhhX3Zu/jbELTrJsxoW2ZidnnZx?=
 =?us-ascii?Q?0lsIMWL5NZ1PxAjPkGFpmRFLIPB3T0DMOwKQyapqpPah66oYgXmK1J9HwEyX?=
 =?us-ascii?Q?Zmgf4Ho+Ri/LkQSfjsiGO3ew8ZbwfI03XyBRVL6vWclSxZfglKf3vUBRvYAh?=
 =?us-ascii?Q?8Bk/aSw6wCusTMqgJs7BcVUJd5G7a84+hc44CZaPu5t161M+ydllHmH6aN4S?=
 =?us-ascii?Q?dWN8ujMfTmylPuZFtTwDtNHFqvujT7OHqGk2gYY7ViureNUr0gFI2Fhsb6Xy?=
 =?us-ascii?Q?KMnj6L3fv+rjXhWNisSfBTdXgN1/8JHiBGKruSDABo87/uLO4dTz7B+GGR7o?=
 =?us-ascii?Q?aHi0p2rmm0Hncr/QUzyJrX5bgkB9rJMiNCDoSE6FpKETeMfY24KEUcR5Jg4Z?=
 =?us-ascii?Q?IqnGPamo9qhJ0MrSHC1ipKX3JA//cS8SvHojJKh2t2QL4pzzsjsEmE7L72HT?=
 =?us-ascii?Q?pl3MvrfqTyfaU7im9TkhcXphmZW7h7oXRo9CNaslEp5rPEf55Z49l4Ry7+Y+?=
 =?us-ascii?Q?ilEJgZt3ZT8XO3GjAoCMgbbTXaR0jjd0iTMFVYn5cjyKIFpPQ/prliqjmfr5?=
 =?us-ascii?Q?YbPwsy+Xd0CS+Xu6FE+P1q6ICun9lL2Q001hM116ztjRxZmVsO2lN9aafYHK?=
 =?us-ascii?Q?AtYlmPbacAgrIGk4r5OiiOxpKd/iuLc4EFKz8sezajL+qlW1aDbJCTCb20bY?=
 =?us-ascii?Q?oLT1OhTHwOxp6B2/eqihRpHoQ5e9eNVJNQDMOFqDTgdVzKNC3KHTpe2Ha77d?=
 =?us-ascii?Q?OKFgqL3EkInnK6ptkoW9XrNrdG40iAnyxWRx1MZFzeS7BLus+7Fjpj7nvwry?=
 =?us-ascii?Q?/TefcABSqAoE5LNa3oNXQ4uJady7/UcEC7XF3KOvsznU6/nKesZl/hX5XRwl?=
 =?us-ascii?Q?ZzVkG89jCqQRxqhybQqFrxZ0LLS34vIlHHE5BfzRvFLZ7Hn7jrLO7470WxY5?=
 =?us-ascii?Q?+6NNzJjmPutqd/kjADIpd95cSDinrLSsMiiAXfMgnh1BhQYErj4KCNuLIeqx?=
 =?us-ascii?Q?UgAHqjAgUl1QvuPX+zfXxffYTfDRJULVLArYjKkn6peczzuE5MSP2o4jZeGs?=
 =?us-ascii?Q?u18cxxr4LU1dhDxPR+LeB6+pq34nHHOqZFhpWmPw++pp5N9TXIhie/0psV0s?=
 =?us-ascii?Q?eM1BeNxqqt4hVMM7nq64kkIDmPsgZ1e6/MHIh+9BK6f/JDlk6wfhKHwczEi0?=
 =?us-ascii?Q?LYZK+ofpU4c8GXHwQqTYoaNm6fTkdDuSnHzEYE5TWL/PurMJSHhmwH2dXoEd?=
 =?us-ascii?Q?R+J+NE59+Rm7liujT6aC1jzCoeSytmO7iPmFzWI8CX/2i+YKXlvoKICyz2K7?=
 =?us-ascii?Q?xHOB3454j9FXwmIqDi5eLuFYepeG8a4yB+BzWog+yVIEAc2IXw1uZHgsuotS?=
 =?us-ascii?Q?rUZQruk/GtagO97c5/JXRLBowGwGHxx4aZlTKChJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2af5cd-3798-4430-55ce-08dde3911c38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:34.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/N7lEnx5ajhA59KaGgQqfYN5y558sDdYQ6eXRRIQ376G3mQ8xKcIXdJd99vusJ/ziZTMsF/9FrwqELPaMdhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.
Prepare for upcoming ENETC v4 one-step support. There is no functional
change. It is worth mentioning that ENETC_TXBD_TSTAMP is added to replace
0x3fffffff.

Prepare for upcoming ENETC v4 one-step support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4: Add ENETC_TXBD_TSTAMP to the commit message
v3: Change the subject and improve the commit message
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 54ccd7c57961..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


