Return-Path: <netdev+bounces-217186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA61BB37B16
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8741B689B8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E343203BB;
	Wed, 27 Aug 2025 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lqJge4A8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30113148DB;
	Wed, 27 Aug 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277779; cv=fail; b=m+oyWebLPl88kk1ANm2Z7uropD7mu3Lj2MWRpwvpjYgDuvz0MHHDPzGVdJ4F90KpMna11DyTe7mEyh2S3j8DQHDceQqMLzZ0Mt+RjNzxa3DxYnLB+2ebQBEbxRQjugnyf7gpPwW2peE53jC5+fXVRDb9PvHH1Glp4j6vHwS//e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277779; c=relaxed/simple;
	bh=hF5UNdOdmYEvr3YO4bJQXUPYEmdEGigM7FH1BEk/g48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOv/dbhRr27oE08fvuCjTEaKcUQNjppjruvgP5xJG9HH5ZA36ty1kHOkN7xjCEuc0n8fZJ9/oRwVJH3h0GIMeKaodUe3r5HQSjstuC+2gtpAq7e5a5kIW91UI55TkzAx7zLwi+m9Hw670ESdLXrg69tO0mjfgDwekfNIcO7Jyuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lqJge4A8; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE1TeCgSbvwjRJx17euhQjguWF4gFKV+OXUnX+DcDKF3W7I4ZdIs4J3MB3fL1bwHhdCgXeqSbF6RbcOwGJQubef7P/Q03XzxG9rDvwaVZIBRTjkQ9ABb4yrUeVhnMQZvQ82ZquVlfgKpOZlut6wVnCxxmG/8xqyUwvRKL7uC+MqIy6fPXfqZ3HeVH3TZqlHqjOySUKezdHavYd8RGd0UPWtIMgST/dJ6FlzsmtgmoUIV/SaWj8VYQg7/a1zrCk8dANgFcwYnM9982UBWGTi6irRa5wQtZ3CosUW6saBIvKWqtEpgWlSTGNhoD0Y0H3QGaeI49QeoTLoNr5sqV53cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=uqG1hqieTsicAeelDJaw9anBKDCFznnHcFnWOQxriWjyFxDLJgf4QQTA2r1CG2KDN5rrRmkXY1kyirQDA/Kf51kuEgaO20XoUF+74jwuARDoJFKj6/taObU8xptiCe5kBlgrSvRU6RTfO5Nyx4p3mYk6qG6dO3W2KIW4teBZEGkMpZg76cFzymVhDNrUpdXHww7RvblJPlfAIJYtCVg7lr0Wm4liaBgzHSnbsxrJkW2gXXNaWwAkBKefZwJpdazIKpZc0Z/v380dGjd3NyNcB3Da3JSEzWppRptanPA6e/pLcwM6u1O5FUqNefG0qhtcSTde79AZWpAt2sqgGix+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=lqJge4A83bTNmER4sCOEvT6ucXhhu+/JIJwrRGNQPc4ZmZVYnNsHEL0aoxQO1DMZeVWUdjyYu1TZcsLbazxtmtKLdsjoXfs10Gz29cDTyjwPhMMZrAAfoc/RXcKs8A9AlERFztSVmTSAeZK8fa+DaCe79ZatDlaLAggsCeJTBF4//W5ZffTolYNIgIRabvKL3d3pYft/KoHkXTFo2fwvyri03WkSddd71cy/FGpCqoljlXI7aTJ0xtUDJFGH+YCvpNexBH+aj1R5WokNex4Mna0nc1CA3gyiYn+sR2M5U+/noBB3dHc/6DUz64U64fcmrXzyC1rh6ZEn5shDbLyqmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:56:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:13 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 13/17] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Wed, 27 Aug 2025 14:33:28 +0800
Message-Id: <20250827063332.1217664-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: e13c18ad-db11-477a-2235-08dde536ceeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqwuXNM6u9oaopCdKRQyle7063Z9anTLfkINp+DMSFQIezfyHcjl4BSDn/Bj?=
 =?us-ascii?Q?9SjmJVzLXyWHQ0xMG+0fZoqsOWmors0/kIxjxchmABiJJshkib7leIkssgAV?=
 =?us-ascii?Q?it9W9EM64VZ7MMFykNOmuJlfn/6ByVBxqUFA49Q07v6yDDJKnTxdYQ8jS6OR?=
 =?us-ascii?Q?yFHlksn7Buy8HO2sjA61MlYus91Htzil1+xc32nWJLLZSdLUVkRoxoMzBv0+?=
 =?us-ascii?Q?/whp7fHzblSDqE9jc2n7f0UdwgMP3K+YFZv9dL3Sqb7OBDKnL5iOeC3pC3M9?=
 =?us-ascii?Q?omDBwcIStRwQ6P+0q8udddd0Jq3Ylwfje8d42zkwMU3EGfsRB9U1qeihBgvo?=
 =?us-ascii?Q?t8N4TDL6UzjFiGPrS7O9Q/FudiwDk/1rENPu3oO5Kg5HBanGIvugoKGZPvGo?=
 =?us-ascii?Q?DCxeHt58e38g/u84mppVh5IzVT43EKyp2rbIrH7M1F5y1/PdA1Mt61Ao1AL4?=
 =?us-ascii?Q?tjudR2SRRmdJn+rY3SjOCCNQHPjwJX+gOwKyNS00oGzfvQtoQMXM6jcNyGIU?=
 =?us-ascii?Q?UQbg15U70aY2ikEGIPBvC8SvCI8zoUjxuxPWS/lLGOcmRDcMo8wpZYCG+RJJ?=
 =?us-ascii?Q?iMbGqXqWp9hlcP6mfAT2bKvO92CzEqNrO9g5ddBh/vcK2NlP1jkUu2rzeHtd?=
 =?us-ascii?Q?LFfmWc0XOwnYADFvQCLP+eMeeH3GZBro0mAUSFtByEfU31KkaYNYGlkGJXVF?=
 =?us-ascii?Q?LqSUeIR0da+7bY+bfcP/LyusHu4p96QO/HnfFoeJYUniJt0+gmCKK2kUUfUa?=
 =?us-ascii?Q?WYXqDWPsxEq/tUcuighUvUn7x21j1zPdXS6f/x5GmNj6tKk5C5fy3n35GOlB?=
 =?us-ascii?Q?gxNfxf49csU5TZipH0TSqmvZSg0mC3qflVUC/NCnH6PSxHnssxcyZ7memb5j?=
 =?us-ascii?Q?A5uUdIjLyhMbhl55MYqrpVtO/Zv1dYcr/I0H1RaV+lynuxhAK/8zPfnU854s?=
 =?us-ascii?Q?R0FD3IWd2MOs4uSiNR3a4O9hhfP5XziRt+/GCLzCsI8vOWLyILI5QoZ9Rex6?=
 =?us-ascii?Q?5QH1Z61ny6WsWIP2daw1RLruuqZnkSiVxC2rzaOB4TMAzvAN92E4Clj8b3bn?=
 =?us-ascii?Q?AdtczhPC4/KAtnsXKPgH3PEjpyGmCdNLIxpHTydmbvt36kLb/luoHROEhWat?=
 =?us-ascii?Q?vYfv/vW+WCVTyqUX8yrtUFOXP33WzrTOhB0VNfwRy+qPB8X74vyr3VzEIEt4?=
 =?us-ascii?Q?kKQmLrO1XvGpFaLy2RqJY9U/dq6nAaD0+OUxwLkjc9My7sOozYAX8z53m0Yi?=
 =?us-ascii?Q?C4qBtF+HLK+73EqFLYFMh3bkQHWAd5+C/Qk4gxYiTHletUojc+6+uLMUJ+su?=
 =?us-ascii?Q?h/rXB+Vc1t6ntY0bTckHB7SIXlDXi6spSo1XA5eUjNfVIi+WAFySIwC97n/C?=
 =?us-ascii?Q?TyBwBXHj2Uv74xoMOxCfM/RxuhGaZeR+LUbmCOsa2w1V2L+Z1mC5YGRhEeyo?=
 =?us-ascii?Q?iNXMFjJBJNuTs82LQ0iGGtZM2jZ6v932FYxXmjSzd6IR8MQrP4dsXyvl0KWx?=
 =?us-ascii?Q?GQh8pAkOql0VM6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXTnX8lKKkK+b7KIEkGqDqSf0o7H2HZCxdXDdv7jX2hu4JIp64BPYB0Fs/Ix?=
 =?us-ascii?Q?EcorK4yeK5sow65R3R01V7NPYZ0l9A8Up0xFyArukxtUDhHMPS0atP0hDFRu?=
 =?us-ascii?Q?9/6SIS9agW3c/MxnIuEh8Gz8LoVmNn95nP7xismxlJJ4tkNw8E0xr5T4hfMA?=
 =?us-ascii?Q?ezR2RchPImieptYe2EfyP4UYWsjnZObZFPwJClGxKOTzCTADdVv4cV+40hi5?=
 =?us-ascii?Q?FZnS80xXfi/V36YIfEQT+CKlDXEgyXTtn7SmESku0W+B3zC0pTpdUKt7kpF/?=
 =?us-ascii?Q?rqpmcjQwGxU9Z8pPj3Y6D68sU7xoOj7DZJ6OA8X8BPExSsUVKx89Q8PT+cO9?=
 =?us-ascii?Q?7DXpxrWvzsWJfAbZ5IFp2gfWPEJQrvv1ZOwwiW6r9DIvMgkptJkz3iyyuYLo?=
 =?us-ascii?Q?qLyAJdOCzrHq6FFcXAEMgxor+q7SowTQPScxurttPNPopd2QHs34J8KJpx46?=
 =?us-ascii?Q?QLdX4BCGFfLLoZIAnGJd7bx461q0EQueCBCnLcBH5IKF7w6uxZy/PE4a0Kyr?=
 =?us-ascii?Q?m9/DQq97pXAg6yT0rz8C8yxBsymqL7kYXWC8wsP+Jx2ugTHdY2Va+OZSSUrC?=
 =?us-ascii?Q?Guf1Bvuj8VHxg6OE7+i0VzZCMPLXUGNzk8QrO9861TnEXrNmGuehlHXW9vGo?=
 =?us-ascii?Q?zQQkDnvXOwhYEcwdIp7WLdRptN8SuWADRxaH0riR/5zNPiPWewJj7mDhtjQS?=
 =?us-ascii?Q?HwJMyUxj7G9WhicTF5iz4y1uJ6aBCEHXg06pgAM0sD7G0BgPOhC16E0Wn377?=
 =?us-ascii?Q?W8i+/oUQiOnIGlVLM430y9PcKD6XoSTrjd5bsdGipzjGflAZmXq8GFXS+m6m?=
 =?us-ascii?Q?rkdxFEcapkyQKrp1kTQSnYk16TqBVvoWsgP+1gUNhBr0/48yNlrBb4vtjHDm?=
 =?us-ascii?Q?SWTOhbyC8eAuC0ingmgG1k7Ud0eR5pG7LgAFD4qwp1ipv7zIPiou3OYjD1yi?=
 =?us-ascii?Q?Yn8ZAVRTzlaJWohh53bX/mCH21RSKOzAS5Ye2ZNxF7XYKdOD0fryZDuAb5md?=
 =?us-ascii?Q?f8J4TsU9wmr/qG1D8GvnF844sD7dw9e+IzeBwm2K7Ae6zi8T0yinX41JbKwv?=
 =?us-ascii?Q?qI0u8prFOpFBhx3W60GktJx3ugXgj0nqJSO6pJvQPvRhhQy9SLtcyheTF72x?=
 =?us-ascii?Q?ZZOx0cvZENnbmnnPD7vYHrxxzFhBO2+12dAcWUasQnLWcn2Tkp3oDBpJisME?=
 =?us-ascii?Q?AYGVQ5icQTa/cz/D3yXKOZQ4kQnu0WL+2xPxE1KP12o0XkGXgGKd2x16L6E6?=
 =?us-ascii?Q?fJS5/X50n1CQtRgnn0tJoAr4w/XzglOvtBgUdcbuszHUj3y6y1t9bDMhrnZ8?=
 =?us-ascii?Q?4XZsyrH4WEtY359aRfWhHnwTJHAfheS/j7xTZ92etVsjz786fAvRjqvSuQpl?=
 =?us-ascii?Q?9p+ija60fFi9NB8Fe8HtQekv9QHKksGZoRoehIRQITH+rZuALd0xWyJHcMSA?=
 =?us-ascii?Q?X2su1ZwDZFB5ZqCrs3GTszLV4L/ay05QL1oESPBk6Gfy/ksu7wRXIjd/ZQ/T?=
 =?us-ascii?Q?xDXnmkIgtS4akQglgXZdjHjKVBuQwi3KmrV6NOwj//R6PNjtmm99Xm/9eAHV?=
 =?us-ascii?Q?rU5zAguoyYYIEV63vJbBp3SLTqZG7HFjgg47zSGx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13c18ad-db11-477a-2235-08dde536ceeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:12.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXEGzC8hhremrcSN98LwEQZckVPIki5bW4+0Py5jQyiB8KQ+/JGGLtbWMF3/6l2ksBIMhwaGWtbIavG4xfUCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


