Return-Path: <netdev+bounces-265367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJZyEFM4rmlyAgIAu9opvQ
	(envelope-from <netdev+bounces-265367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:02:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEA2336D4
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D8E300820B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FB26CE32;
	Mon,  9 Mar 2026 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lOEuKHk9"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623A246BBA;
	Mon,  9 Mar 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025360; cv=fail; b=nGn1tPy9hdm1afXxfDaAhy6vbocBWiUrbSF3n/glhB60/KhUNZ6fZsMM3Zt9iHiMq5BxSdeSWkoIzXAEA+5t3sa6iBzsW/3PrrYH9Ix/MUxqKQ1SkKsd7dcACCi30mILZQ+JHv5Cx9gFAVUvy0zPmMnpzThT5rLvZuY7W95oWVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025360; c=relaxed/simple;
	bh=+z5t/mPvBtA1oHtE2pXXzAOUXv2t6BGSNkR9KWbBfV8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A7uPZWwXsaO9/mDscy3F3nNY+MGLTdPQSN0RDmIt66CN93saJmJXRjFIzAaiou2MNUKa2AGawgeKEhd/pKSLQO+KZ5N/kJADYpusDXS4KXN6yuikOGsy539mt6FJIkiwuv3VD9Fwk/4bhJu3rLKPgJR+KfJ1RLFpI18KrDRq9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lOEuKHk9; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qyk6h8yzn9BOWRHTKC2Cen0tb2F0f5A4VHJrWOoHoORHdutUh4vNMFJK9lu2MQXFlC9MO7uCc/2GsL0pi8/PQ17tqGTbh6At0lbg4aOul8XFrk7d0nvAcy0fG7ibGD+hImAL+2bPsRiy5svDNjOPXdu971o7J4rpntY4cQc0kbd89ks9Bne5zM3ZWE78r1liNRbrCeGZA7UGWHZpZOcoaEcaSQAyP2RIhiXEYigoQYmqdriMEauZOMYSsCGTieMe3cyhVZCovED162u2r9F7VpWzu9ZoB08OCiyrCUke+vaD8zpDvOBgWg1whKdJdx5Yn0n7SW47a7nCKVINcFF4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkChTElwT6u60fguYYTUYGYqmdSq+y2CdqcNjM/0c1U=;
 b=BxV4Kr8jn4HWIOXNAJ6wfR1QXFGsVirp1XREeOQVZjD/No4S5MiDTPmEJIqcZsmo7YHdJZlPMvNHMcY/fWGHG8d7Oj2BiiUr/9GEXpdrriatS0uPTABpDMkzr/LZRgOExC3AyrNQbczTwUA7AjtNWEmgi+WbOMWudNhAPqKU7zZoswgB4QHao7kimXdO8J7PojkMNyQ+RLllGxK39EuSXQGLSinQhMkppLFtjSuQMx8CItwOCToESCowayytQCBMiHFX80+qp8anr/4jGaCAF4LoCG/7s8gbzxFo7eqVaIdXmaWST23I6tc4tSXuAINn37EwzZQtGKNll9ruAa8/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkChTElwT6u60fguYYTUYGYqmdSq+y2CdqcNjM/0c1U=;
 b=lOEuKHk9v8gjZc8ZIiGEbCKUvrnGNyWjyoqxG26Qr24jWwj2+oU9hyruvnlWr5A7oWa6HuarSE1fabSn79lFfXt2XyJRmBDG4x5UeFYH19+eZGMLY8Eh8djvOKGpC0Ct1CbmlkWqSuiNV8X29DIxMwq2hSO8u0NZ7WvMb7z41ErXPvfyz9JcNzQg+ATo8Dlh42lOlIXvQLoF6pbV1ciQmg66sJc/8D2G/+lkqOwVULgkWBDuX2dIvPkFKScJTbZvSRwrmLdhvre5Wl+ivX8LFX6H+S8gY3rZ/CwoG7SSJUDG3qjapib+GVwoAAcS09sew957AoTQxs4oG+xz5iLjBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Mon, 9 Mar
 2026 03:02:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 03:02:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Mon,  9 Mar 2026 11:04:12 +0800
Message-Id: <20260309030412.2716984-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: c124ee0b-8edc-46d4-df04-08de7d884a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	GdPU0q22ppBX1FPyGhZ1/apuVSov2xXJV8aC+KfoLQ9Wzk8StZWML/CXSqQfM71Fvas/rzfv9IYgYnMWJ6VCYOctjBtXkiTUWlhXZsoayJY0BK9+uQMc6Niv8b0sNAdVTx2hdIDCCQiqLzQzaHooe1PxXXwjT8oMMOHI7wIRoU1nLurTtiTUVWdHwONSgsRnNBiOdyS8gsXGweXjdT9sIzNr7tLe3N/Z7SZGNUDZs5ulYdF9+KPIqMeympxTsTlvhW0UHJXIMxS2XKZh0wH24IYwLxy2M+9VH9yx1Y5E1Xr+0HCEbToVnn68omiUrQ5e7jQVthmMio3/WIbsq/c0EikFx0B1IxrMMsDuUnk0ZQe+wRF44fh0fASvLGhcgWjBBNbp96CeUWua+EYiBNWcCOBtSQLgEARrUdjlGCA6PSXXUvTZPftoGPC8Apr/SHjDtyVlvO38c1HdjZt6VFJeZ42ND3xsDEVGVCCGHqebqgRXnZiMyf4Lfoc4lYypaKurHBd36Pv4SsjjPo2wPyus9YYLu+j1qjauQRzQEITDcaCw7kds3dmOD0OZhiJvQaCo0J2rWBUn1k9NhJ8N1lTqeRaZgqBgoukU0DTxqLQ1d9/4SqZqGLc9oCI0ImpwBk2B0OI4hBIsvGQwelWNidquTFKnx48UjWPFyul6P4ulwOhjddqmk7vFcgZuaQ9ZIDpRoZynmfpf8sVyHvmSEyqKhY/EOjy131ZrXZ0A2RHYnlZFyLi+EYUvFymZRoByeezY6JM9aYBb0BjAXPfUU7pTte35iUlxdE2/HJzp8O6jN16fK1xkTQ+icIRJtvCrCJsj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5vXKSjZnDGFFbbT6JmSvBUEXxbNREYjLIbJOrldl8AWZ8zRynWH4GwUN+Yv?=
 =?us-ascii?Q?bCw75x52oaK/WyEAT65NkGliqlUkfGL1ZGuN6RDFincGh5gm9AO++oPWnpcd?=
 =?us-ascii?Q?WHwAdjrIjtkrE4Qtlkn+YlzBDdYFoaPsrmy0yDW1MkNryhepUQIK+wPa3HOm?=
 =?us-ascii?Q?Oy2VVhBC7+BCFiXBr4MPKLosLbPAXXjXpB3tWz7Zbo2BklmaAMwOA+CQC2D2?=
 =?us-ascii?Q?MTDX/iq9g0lMnsj+aYp6m/1/UOQXJ7GeQwonE5E2txI5SF/CDSkvVwuQfK24?=
 =?us-ascii?Q?GYjQqGs7B97UVFxYEMRlKx/zXZEDbL24tCJZ6Zm6BVEfeR/PghLi5dp9EFLr?=
 =?us-ascii?Q?KH32mi/umz/XTpBsnYZiFQwBFiMsmOa/WFqsN/KU8nu6P+gbogARtGyK2Oh5?=
 =?us-ascii?Q?Sn28VHXJsXojR1x82GIdItf/qMkvy11Kp+D7KM9IeUnO+4I02meD6YUUw5Pc?=
 =?us-ascii?Q?mTDM4X+pp61c1Jkr1sFvScFePv4UmE58KJJpWFjV7+ic9auTU7nGBXOr/iog?=
 =?us-ascii?Q?gfYxydMv54OuxrSXiMgRF6K8e3esFGuE/FwU1b3njEy2v712suyYa9CXm5bO?=
 =?us-ascii?Q?E+yMRplRf7x7RXDHN27lqqwsoGhNs4ezFXvtlkGs1Qee5PQIiMyip0FHUhbH?=
 =?us-ascii?Q?NjDcJp92H6dgen67w4R2cMEDg7ryZTvo9vr4DnP7Z3W9MGyZ8dy3pFmHW8lR?=
 =?us-ascii?Q?qO0YB/N5fKAxQyj5MfMd8JhxR+jsYEj1Cuw5XJ19bN3TJr/aLT8k/isA+QQ2?=
 =?us-ascii?Q?ukUuC+zj6413bFrkDHDlihA4X5cEtUPdqHX8aGcdJiROuZi0dQlhCNscvljA?=
 =?us-ascii?Q?LpEbKlI30np7NEFudMvJkTTcNGpIkwY6lYqdJrcT6+nj/Se/LlS6F0zAF5pO?=
 =?us-ascii?Q?9BGsQWpjh56UXR2Im1gngHXQGSuqBXIbA9ZPmLojVD29WwF+HcRboR5N3stO?=
 =?us-ascii?Q?R7fzXci5wwj1vbTS4vIQyPDZBjOqnPpqy/EimdE7fJR0DW60SigihH5kI0Qd?=
 =?us-ascii?Q?PbtspEyldd1lE+Up2ui+vGeC3PYAzWtrgItVgFOS9nq9HrtDsG0PrfJsMuVP?=
 =?us-ascii?Q?a6pZpn5aweO8h7O1zb6XJjyWbN81RLX6XLtz7oze5vLDuodwYB9dGX/soTrX?=
 =?us-ascii?Q?5MA8bqTamz/P+oWTzPByfDym1egFadLvnYivpUw+sDMltKJcInUg9Xs9fcT3?=
 =?us-ascii?Q?7j8TkYAT366DfRK8B0XKURvT+D+NlOMHzYAH5afVlaMXEc9tIWhzo0Ux2RTG?=
 =?us-ascii?Q?uZEQ5EdtA4IdXg+iHPXnd2Gt4CTHYz5IAdVA2Af/1vUcnHzqn6K9ZDor/t0d?=
 =?us-ascii?Q?01z16tWDcHsOOZicXmEK/zztdqSW3fJUX02uAriAOUI1mIOAtxURnursIC9W?=
 =?us-ascii?Q?VuBiswlyTC7rn4qDCm4sTptZCKD7havQzVhTLGxUER2BGHPHE08KX1QB7jwL?=
 =?us-ascii?Q?zlQwS3O7H1et9PeU9j+ysvZlVFhVjUjmSJfBEDJx0nudRVhMDrxJKDyMK5X6?=
 =?us-ascii?Q?rgk+9T3HsFjxRhS8kvXYI0tWtCIbAXlq3qxbIwovleQG1WSz39DlO6Du1Haf?=
 =?us-ascii?Q?kOb4n3YGH5ILpZLdcBZ7Ah+YqLIZnNACV8CFuuTP3kA8eEEIvhX8O+Y6S37E?=
 =?us-ascii?Q?SOp2aR2tN9MgZoq55CoGATupvWKyqgsKyaVfl8lZ0rnkFsc7vPOpFtYOmX+M?=
 =?us-ascii?Q?Z4g/lkB6oAfZ2NF7CS7uKBUE0FkRChiURpvJz+JsDVuUnknS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c124ee0b-8edc-46d4-df04-08de7d884a1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 03:02:24.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJX7y0ziHAfcccB9PqlPtnIen8HADDIssZETQGyFit2TTfLKx/VQHPVDfs5T1VKFnJf8QBmmfWIlTiJ0sNjGmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
X-Rspamd-Queue-Id: 97FEA2336D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work perperly.

Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
the driver must reset them if they are not equal when reinitializing
the TX BD ring.

However, resetting the PIR and CIR alone is insufficient, it cannot
completely solve the problem. When a link-down event occurs while the
the TX BD ring is transmitting frames, subsequent reinitialization of
the TX BD ring may cause it to malfunction. For example, the following
steps may reproduce the problem (not 100% reproducible).

1. Unplug the cable when the TX BD ring is busy transmitting frames.
2. Disable the network interface (ifconfig eth0 down).
3. Re-enable the network interface (ifconfig eth0 up).
4. Plug in the cable, the TX BD ring may fail to transmit packets.

When the link-down event occurs, enetc4_pl_mac_link_down() only clears
PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
ring after a link-down event, we checked with the NETC IP team, a proper
Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
graceful stop to the link-down event handler enetc4_pl_mac_link_down().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2:
1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |   9 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 126 ++++++++++++++++--
 3 files changed, 132 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 70768392912c..825a5d1f2965 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2595,6 +2596,14 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 3ed0f7a02767..1ce6551e186c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -134,6 +134,12 @@
 
 /* Port operational register */
 #define ENETC4_POR			0x4100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+/* Port status register */
+#define ENETC4_PSR			0x4100
+#define  PSR_RX_BUSY			BIT(1)
 
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
@@ -173,6 +179,11 @@
 /* Port internal MDIO base address, use to access PCS */
 #define ENETC4_PM_IMDIO_BASE		0x5030
 
+/* Port MAC 0/1 Interrupt Event Register */
+#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 689b9f13c5eb..6103f1535d43 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
 	enetc4_pf_reset_tc_msdu(&si->hw);
 }
 
-static void enetc4_enable_trx(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-
-	/* Enable port transmit/receive */
-	enetc_port_wr(hw, ENETC4_POR, 0);
-}
-
 static void enetc4_configure_port(struct enetc_pf *pf)
 {
 	enetc4_configure_port_si(pf);
 	enetc4_set_trx_frame_size(pf);
 	enetc_set_default_rss_key(pf);
-	enetc4_enable_trx(pf);
 }
 
 static int enetc4_init_ntmp_user(struct enetc_si *si)
@@ -801,15 +792,120 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
 }
 
-static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
+{
+	u32 timeout = 0;
+
+	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
+		 PM_IEVENT_TX_EMPTY)) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev,
+				 "MAC %d TX is not empty\n", mac);
+			break;
+		}
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+}
+
+static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
 {
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	enetc4_mac_wait_tx_empty(si, 0);
+	if (si->hw_features & ENETC_SI_F_QBU)
+		enetc4_mac_wait_tx_empty(si, 1);
+
 	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
-	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+	val &= ~PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_mac_tx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
 
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
+{
+	u32 timeout = 0;
+
+	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
+		 PM_IEVENT_RX_EMPTY)) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev,
+				 "MAC %d RX is not empty\n", mac);
+			break;
+		}
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+}
+
+static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 timeout = 0;
+	u32 val;
+
+	if (si->hw_features & ENETC_SI_F_QBU) {
+		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
+		val &= ~PM_CMD_CFG_RX_EN;
+		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
+		enetc4_mac_wait_rx_empty(si, 1);
+	}
+
+	val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_RX_EN;
+	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
+	enetc4_mac_wait_rx_empty(si, 0);
+
+	while (enetc_port_rd(hw, ENETC4_PSR) & PSR_RX_BUSY) {
+		if (timeout >= 100) {
+			dev_warn(&si->pdev->dev, "Port RX busy\n");
+			break;
+		}
+
+		usleep_range(100, 110);
+		timeout++;
+	}
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_rx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_RX_EN;
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
@@ -853,7 +949,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
-	enetc4_enable_mac(pf, true);
+	enetc4_mac_tx_enable(pf);
+	enetc4_mac_rx_enable(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -862,7 +959,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
-	enetc4_enable_mac(pf, false);
+	enetc4_mac_rx_graceful_stop(pf);
+	enetc4_mac_tx_graceful_stop(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
-- 
2.34.1


