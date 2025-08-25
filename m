Return-Path: <netdev+bounces-216378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6CEB3355A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06063AD117
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088022877F6;
	Mon, 25 Aug 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n98pIBlm"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3272882BD;
	Mon, 25 Aug 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096673; cv=fail; b=LqJIsAoEzfF3OX6ccpJFVD+KU8Vo7eKC1tE8vDXRPrmuzrMdBeR0LG0/8ar1EfLSv0AU25hZvpJtE9ZDOYeISNL+4o6IYDKpkJrqlUf3vz8cjL7ER0UqaW3m+xdNdu93y4n5xr2EO3VrOrvC/tAI6Fh55tIvxnDM2aQ3ucpTiUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096673; c=relaxed/simple;
	bh=O5j3ikXzmqZlbGGnHLO7cv/bbg5k/eJE85CTUt+B/ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rz75Xm1JO/pAkqqbdWyJJxGZkZ9KTlVuuXENEyY5AWDRPEzvuvWvHszHU+8e6RNrgIYdmQRbEHY8Oc9DPGzeA7dPZOHSue0XoTNEJuzuJsBKl5usqOBKJnGXNY0jpq2xsoZVldWCfX5lwXwnYHPex/aTVGFYyVHAV2ontxN4VrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n98pIBlm; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO1WdDaQfkpBQxR/YOXOaT1/AfiAhtd+Csv+th5NNQjcFDgpcIY7a/Hu9NeF6Yrru+nT2U8IqWEHC5pUaq4yJu4IroC1bb6LZo0RR7oAOpJlSNHCq5Awofo5ojMJ24DIlaJi59WlUiqE7+8yrmKU2mEdo32ybMvEd1ou6CZ1jeangmUonc5OEO9w3LDSRTsjIYLkE+oswhORFfKRNxakjgPEl3lQlTbBv8LKIAcms9LeBxwKxh+rqgKjXZ1+uIabmWTFSkZq0XAm5V12Nf9WFlXe7h3tkhZXJmgIxLie0JF2eel1myhsFSnT5WCNHIzOKi7eJ3CF8c4CEKKEjO9Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VedwvUPgGhrEqg5+3Jx0Y5OdfTD/Th93XPj1bCxRJeM=;
 b=FjbSqsx6wmCADzybL7AEG4yfO0iyJAWdWxs9x6e0RRhfsUl8jU9UhgvGDGSZ9YZ5t++nkNriJtKhvWVjA0xiLBlQ6jitCvCMDQeTXRgAI3fgizMu/MDMn3VyXQvhJLqQcnkP05ySZBc1gGXciT3RpSs81lNPMie+XOprRFA003/9n/xnpBJ+ezFtKWsNLN9FkRNfPIhNtUJBeRXbWAc9BVlWFVMJowujnQkNRFS4p6+On9a9NeOoT/10ZOyvfzyl15KvCTOMTIvWRfCz6jkK0hTlxb9yRjx13V1zJTqYgaiFL+PUsiNCVrFXO/7CiN/xJtRmlVTQUpd6j6wytphCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VedwvUPgGhrEqg5+3Jx0Y5OdfTD/Th93XPj1bCxRJeM=;
 b=n98pIBlmsluUqque9ZJPU1t+nQes4fdaeAzlnsM3BSCU0jJSEd4I15Ju6pj/lZZabehrNRjj8aNOVKcXEfQkwhIuVHJmNMy3fqLouNcnvVWmViIPXT8f5W/RJmEkDiE9VUVXBFZwevEojHqvfBMQhs6HeIwbT2ouwN3qFgZQPvyuoI4cfPy03vPNfTKZ7IDlavc4Rgqpzrb+4gC30GQO5F4CXgWb/eATTRcBQq9RhOhNf6GeAT6c3DejWQkkiuWKjVM0TNeyp5JbvVjPBRGGE8AIJRYsfEejabtpiYJNnf5HYV1fhtuaMhWqISQ8zjtzOcTmi5dl29/6Fah/nKe/4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8614.eurprd04.prod.outlook.com (2603:10a6:10:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:48 +0000
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
Subject: [PATCH v5 net-next 13/15] net: enetc: add PTP synchronization support for ENETC v4
Date: Mon, 25 Aug 2025 12:15:30 +0800
Message-Id: <20250825041532.1067315-14-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e6f64f-209b-453c-d46e-08dde391248b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmV9RnnBHrPXsPu2bh/iHGvI5Pk+CXuiJ2078+Qx9bRURuANInw7AUzG5rC/?=
 =?us-ascii?Q?hUTkc9ujRxntPmoCn/HQIJi3N+jFZ4tyq68luqXVK5pi66ZibLajtEN2KyPF?=
 =?us-ascii?Q?RoZuHHTzQHovITRf0dT2LNa8gy275Crq2rPW9gj7Pm/oXuvo1Of4Kdh+0wT2?=
 =?us-ascii?Q?1+1mO9SWy5kpop79xbUytOB5vQIRZZNOXTNJlx7XtlSK1sXcICeBOMjSxAds?=
 =?us-ascii?Q?EDhG+nGTTJz8GtmRYgDl8xOOD1ThsfHKAzQ5+V3Havs4utz6hsdqZtHSxT5s?=
 =?us-ascii?Q?E4+dlbg1JL1KsrwV95f934AmLEjof2Kzq/q63y+KfJTntZK/mwbzPeXcR+i/?=
 =?us-ascii?Q?i6367uc+Jq3TWtzwGDWlILx3T5hcqxsf6EGw9DfoR3/grCUfMhDp9pQ3Hj5y?=
 =?us-ascii?Q?E+57WdcMk5Z5QdYlI8AZLi1j/BiFHdUm/QDrFAbyna4/t7YwbHYX2i5KwNAW?=
 =?us-ascii?Q?RTL4xs41cXKld9OeGzX3eoMKb/snigGXahKIfP5jOUCHkRz2MaWo+SkAdOZq?=
 =?us-ascii?Q?LegHO0NrF2ER/nY/+NtbTsarR7Z3j7R3fXvh4N36TyMDZKHZfAI2InmiMMHW?=
 =?us-ascii?Q?l5hNSeOk8KVnezdCB8K2sA9tHfc1ob4/K9kxnqrRt9i/ICN/VoThZA79zouo?=
 =?us-ascii?Q?TSYuL/AZ7MT4wM+hRsM329f2CPdg0790OsGoxZNo4tbnprCHNSqsQG/rZMAg?=
 =?us-ascii?Q?D/L6q3fPVNTgWcPeHye2/sooCU3KqA8eiU2EjDWvR2+9YWDZVQZZzVR2pmpT?=
 =?us-ascii?Q?AtcJ3hLkpcjdL8uLqHeey42XdCdH6foHkUuO93McgKkpEFS38R1I/C1m1xyY?=
 =?us-ascii?Q?vUalKpPrSk//ZoBfJygswGZUOGYWsnOzNnvuWZgUqngiSa6dr2lkf+M5opnP?=
 =?us-ascii?Q?4OzUOlJdFNBx2qDGmwMPyXYTU87BL+Nur6mz2wyPwNGSHS9UxUAiDMssu4vb?=
 =?us-ascii?Q?/V8ABVvXnCe/XSeseezLQ5D0qWggoFC526aP1EE+vF3FS2B+X3/pw/lJAozE?=
 =?us-ascii?Q?lGw3u2kcO9SAHBmDUJeC1buf4tSQD75DcLw1YH8lViV62udI0Ku87NXQdUHy?=
 =?us-ascii?Q?lpQP86ePjNOT/rsS60bTl6TCcE3y/BAF2MFNNx0YB6O21B3LJorZCxQ3xzkK?=
 =?us-ascii?Q?XeO/9ZLOJRSrZRLs62wTECewUgL2QoAnw10seskvQqN0TiPVbluKdLQ63YTD?=
 =?us-ascii?Q?fw4xdrOipIu+dgt98rXcAnNGDlCp09F/7bZuPZj50iyU1PdHPEqZYGlsqMQH?=
 =?us-ascii?Q?eJR6l2Akr+13ejAdjrPLxSm3ibhiR3p5djQfN5RgfV6mFNhFT8eWkMrwuuj5?=
 =?us-ascii?Q?tl+WrkyMTb30mQYbxkvOUB8kgWnSGxW6Kq3lTIv8ofSg6IfEw5UHWKlnRzOC?=
 =?us-ascii?Q?NNO1ThjDr2pj3E53gEIJ4re5HflxdATsuFPYHn4L7dS4N+jvwBDvP5x9UBbP?=
 =?us-ascii?Q?6/B8ufgWhzaZ3O0lQyi99San6XQCK1mQVHWBRfqQO8F/2ZHjn4JojYWpVvDy?=
 =?us-ascii?Q?pdVfEnHfLCcmTf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3jSXrV2vVHfNoyoMcNWOJGRg70nMDuN/euMV7hAwvng7+d+RiULy7n+8Wtr?=
 =?us-ascii?Q?P3XnCMpmZYY7MqISvObMXWlWMgXjQJO/z+56TsGUNhYFIwf6ytm7jQc9wdCx?=
 =?us-ascii?Q?kQ0Qj/fngToaS+KyG6HWp1ieEIEF0c4dVUAvNqutJaI+LDVGbxftqtKaDSLk?=
 =?us-ascii?Q?GZGaJ02de2m0Ybmk+atxapWAM0sHml/GpVpMSzj6NBE4jkIxcSjpewVHvewk?=
 =?us-ascii?Q?dMORBWcBTGzraUE6bkZOxHE5auIXZ1CfHXpFzDnjEaD4vC9Cspa4noVNEp4w?=
 =?us-ascii?Q?2uqN4eOaYFlB82QlZcZgnF6wVKfAALUCbe2uo0hQD6nwHe4qBqYUtejZ9N2E?=
 =?us-ascii?Q?GPfo6136zpubVTVEujJw3TqRcVMLLDj6RrLtzS+owPgr3AnANBRpTYBmYRr8?=
 =?us-ascii?Q?En4f8DI2hcERpLhF6i30A7qoG58DmK5OQ4VnZGH9U+LR7WQy7/GfVrsoDDEJ?=
 =?us-ascii?Q?L2FDdTHuqvMtwl58FHYqvt+mYf4rakUA4OO8WlPyn55Menh5r9P95gJWLSLc?=
 =?us-ascii?Q?vuA387Oy/QTvdoFhfeXe4iNsdt0CVI72NzSIWOsCPbuDSp42NvZgTk5aaVJy?=
 =?us-ascii?Q?zZXogtqWV8iWLagI95k7uj5vz0juY/RmnhbSqpDcExeTcXMcy/3BNpaTa+lD?=
 =?us-ascii?Q?6Jg2FK7CKezPQ/jvP2E/eGkpB8gqkKN+Z63KJ4tyWcwEWStN2Eki6K1a95hD?=
 =?us-ascii?Q?vwKQA6u+vhvShEBOZpsZVRB5izyb9+Fapm/Dza1PXRgJvREOHO906jUTrc1w?=
 =?us-ascii?Q?0FhurxNMgi7nXKFcNKJn+nLwtFsR2KiA8hvhTI5QpN+zmwZZl2ejDgMDayd+?=
 =?us-ascii?Q?qAo2oXCr9N2fJmDq+LSqFKN2lKk4VcLPfXk/cxi5DAHi52hBcNYIhyZnWXpB?=
 =?us-ascii?Q?dHYJ8G17qFpDiXMrmY492wDsYUA1XL28mcfkj+U+Ct1H8vSuzpepvJTd29Ui?=
 =?us-ascii?Q?IAShDfKBJMEu1vAV56NC50+tFekfefGVz6lEQi+rFw8Qb+ctwXSM1seZvMpL?=
 =?us-ascii?Q?5BrBgoQuQOMYN9RHsReosZUsD0ibGh1Yljqz/og6kRaytncHu5ypWAIprjC3?=
 =?us-ascii?Q?46XDfu9CNu8eX/svllh7P0yqWZBCi9vuzNm7hp9DD+HQyQRJrekgXBIWnlnJ?=
 =?us-ascii?Q?3WEAhI7ethyZ/APF1qz5XvHPrzwYJmKjlhHhzSKnbIRAwunbraW6mobIv0rb?=
 =?us-ascii?Q?1TCpJwPBJMqKBCHydOhBxyXh8+kpbDOpiWM8RrDU22JThdnlmDriVQW9pfMf?=
 =?us-ascii?Q?cc1vFxDjMzJgWIOAtlW4xkevS91k1LIPbNK+xU44eESirTVnOLYfMQgn4VQV?=
 =?us-ascii?Q?wfNi44SafTuEsA/ESCd6ICwRE1YQPoe87gN6bBXVgEuMpCYZsqTwkUQlTUeh?=
 =?us-ascii?Q?mi5uhRzubWodHTRAgmySJ9sR1KBPZp3Z97UJF/GOuGMCAsPMxyX6Mw07rNwP?=
 =?us-ascii?Q?By0jaIY0D5ipQzwr62dpTXPExapsI5n+xHWCA6Q9yRktx0Q7Bpm2YuqNJekv?=
 =?us-ascii?Q?jb7Rq1ybjgGN2NxP3R1T7Rlg3ldbjWIQ2/V6uMghqD/+83fyOT8rVGi9oPhS?=
 =?us-ascii?Q?CG6qNmKqpwlhe9OgFaLhy3h1S83/exnzRg2rx8Vo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e6f64f-209b-453c-d46e-08dde391248b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:48.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YsWu/La7oaA8ThFeyZDqjp8m/e8Eyejj7JM07dFOvZCQNjp55ewZutEc/1vHvcPohE3c3R14oNwiRpH/M0LCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8614

Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
mainly as follows.

1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
different from LS1028A. Therefore, enetc_get_ts_info() has been modified
appropriately to be compatible with ENETC v1 and v4.

2. Move sync packet content modification before dma_map_single() to
follow correct DMA usage process, even though the previous sequence
worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
(ENETC v4), it does not support "dma-coherent", so this step is very
necessary. Otherwise, the originTimestamp and correction fields of the
sent packets will still be the values before the modification.

3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
register offset, but also some register fields. Therefore, two helper
functions are added, enetc_set_one_step_ts() for ENETC v1 and
enetc4_set_one_step_ts() for ENETC v4.

4. Since the generic helper functions from ptp_clock are used to get
the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
may be changed in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v5 changes:
Fix the typo in commit message, 'sysbol' -> 'symbol'
v4 changes:
1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
of this modification to the commit message.
v3 changes:
1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
2. Change "nxp,netc-timer" to "ptp-timer"
v2 changes:
1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
errors.
2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
Timer.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
 6 files changed, 137 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 54b0f0a5a6bb..117038104b69 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -28,6 +28,7 @@ config NXP_NTMP
 
 config FSL_ENETC
 	tristate "ENETC PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
@@ -45,6 +46,7 @@ config FSL_ENETC
 
 config NXP_ENETC4
 	tristate "ENETC4 PF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
@@ -62,6 +64,7 @@ config NXP_ENETC4
 
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..6dbc9cc811a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = ENETC_PM0_SINGLE_STEP_EN;
+
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
+	if (udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	/* The "Correction" field of a packet is updated based on the
+	 * current time and the timestamp provided
+	 */
+	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
+}
+
+static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
+{
+	u32 val = PM_SINGLE_STEP_EN;
+
+	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
+}
+
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 				     struct sk_buff *skb)
 {
@@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	u32 lo, hi, nsec;
 	u8 *data;
 	u64 sec;
-	u32 val;
 
 	lo = enetc_rd_hot(hw, ENETC_SICTR0);
 	hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 	/* Configure single-step register */
-	val = ENETC_PM0_SINGLE_STEP_EN;
-	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-	if (enetc_cb->udp)
-		val |= ENETC_PM0_SINGLE_STEP_CH;
-
-	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+	if (is_enetc_rev1(si))
+		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
+	else
+		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
 
 	return lo & ENETC_TXBD_TSTAMP;
 }
@@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
@@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	switch (config->tx_type) {
@@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
+	if (!enetc_ptp_clock_is_enabled(priv->si))
 		return -EOPNOTSUPP;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index c65aa7b88122..815afdc2ec23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct enetc_si *si, int size,
 void enetc_reset_ptcmsdur(struct enetc_hw *hw);
 void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
 
+static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
+
+	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
+}
+
 #ifdef CONFIG_FSL_ENETC_QOS
 int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
 int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index aa25b445d301..a8113c9057eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -171,6 +171,12 @@
 /* Port MAC 0/1 Pause Quanta Threshold Register */
 #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
 
+#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0 Interface Mode Control Register */
 #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 38fb81db48c2..2e07b9b746e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 961e76cd8489..6215e9c68fc5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -4,6 +4,9 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/ptp_clock_kernel.h>
+
 #include "enetc.h"
 
 static const u32 enetc_si_regs[] = {
@@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc_get_ts_info(struct net_device *ndev,
-			     struct kernel_ethtool_ts_info *info)
+static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 {
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	int *phc_idx;
-
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
+	struct pci_bus *bus = si->pdev->bus;
+	struct pci_dev *timer_pdev;
+	unsigned int devfn;
+	int phc_index;
+
+	switch (si->revision) {
+	case ENETC_REV_4_1:
+		devfn = PCI_DEVFN(24, 0);
+		break;
+	default:
+		return -1;
 	}
 
-	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+	timer_pdev = pci_get_slot(bus, devfn);
+	if (!timer_pdev)
+		return -1;
 
-		return 0;
-	}
+	phc_index = ptp_clock_index_by_dev(&timer_pdev->dev);
+	pci_dev_put(timer_pdev);
+
+	return phc_index;
+}
+
+static int enetc4_get_phc_index(struct enetc_si *si)
+{
+	struct device_node *np = si->pdev->dev.of_node;
+	struct device_node *timer_np;
+	int phc_index;
+
+	if (!np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np)
+		return enetc4_get_phc_index_by_pdev(si);
+
+	phc_index = ptp_clock_index_by_of_node(timer_np);
+	of_node_put(timer_np);
+
+	return phc_index;
+}
+
+static void enetc_get_ts_generic_info(struct net_device *ndev,
+				      struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
@@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device *ndev,
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
+}
+
+static int enetc_get_ts_info(struct net_device *ndev,
+			     struct kernel_ethtool_ts_info *info)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	int *phc_idx;
+
+	if (!enetc_ptp_clock_is_enabled(si))
+		goto timestamp_tx_sw;
+
+	if (is_enetc_rev1(si)) {
+		phc_idx = symbol_get(enetc_phc_index);
+		if (phc_idx) {
+			info->phc_index = *phc_idx;
+			symbol_put(enetc_phc_index);
+		}
+	} else {
+		info->phc_index = enetc4_get_phc_index(si);
+		if (info->phc_index < 0)
+			goto timestamp_tx_sw;
+	}
+
+	enetc_get_ts_generic_info(ndev, info);
+
+	return 0;
+
+timestamp_tx_sw:
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	return 0;
 }
@@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.get_rxfh = enetc_get_rxfh,
 	.set_rxfh = enetc_set_rxfh,
 	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ts_info = enetc_get_ts_info,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
-- 
2.34.1


