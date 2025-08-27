Return-Path: <netdev+bounces-217187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C84B37B13
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568BE3666FB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA73164A8;
	Wed, 27 Aug 2025 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbRFPRtf"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D232142C;
	Wed, 27 Aug 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277785; cv=fail; b=GKxUXb4rljZnQishZGOoPJYpieFeOebYQvQ48HaXx9lnGSjQ4/XtelfyPKlbAfTAP/+xC+EenkK47MunhfPGP/Fx8KC2qApk4iDsi5zY5p9jQoTb1v7Gc46VenARQgq6+2QFB/trPoCBAd0wI4kT9zMQgqnpWh/M3UEFp/NATjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277785; c=relaxed/simple;
	bh=jcUUdbGVIPtd/rKAT7mzTkFWfWDQiZPzakvKXOS5fr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwldcuurXLFmZ82J/AJ3oOkEx+Ezh8zhZXXL6FjuQkyWioDYB+XkwFpbU9Ivv92S+rvSEPyOkB7oSqmuz0sz/sBhW/6F1r3/SwpPjw31kFr17pvV20Uq32JUK+SKcydLSvk4wgV68W6Sk3yuskx+SEIuaS0rRliXQqwYpU8gty0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dbRFPRtf; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou8sjxMGZazzBN3ZhiRNwi6ROHxWQ2isxi13WtDxxBDgeh0T5pv9zr/QNqNHvUX0By7JXJGSysyp2CIRheNbwGMo/KaeQ4P3YGhktCXQs7zfvN84gFzgRKdczPvTiukeMttAl3ThZKWu14YtNvvtlGGFVE8uoJJh9g92iK+vUQzZu0EhvegPwGf+T2TRsLUMDEoFWkayCyZ65mA95OEczMVFk4rknX75rl8cooFFZU64MQyA41hnyv0AgaTFbUgl4B5G4POU3LKcxlZ0CkAXWqPJgjWondIFijD1hck/CQSM4vQoTCikaR/cizo+64PC7ldeKP/3j1twcGsDz2+dEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IojUH2HvxtIxiZMOOqSdOg4+IXpu+S4Jaug1lQuABRU=;
 b=ZykN7zZMVmdLzzJ+DBqgs37v6kX85NTjxv1j4mIy4gMjZyU/BoK6IDYY16bpnWHStX3qra/oHRwvuy7Svmr0PJW9HSDe+mROrHiIQijx0ianZ6obtUjiH9rBYb7zNQeFKGUFaQpGW8r4sOLaYB4qEgBPwoCt2AXB6GJu061OeJBhO1Jry9XDNUmsGlDSKpDKpvcZCXVOxIwez05KZHCWWw1ToBi3QksiRxwJI2FwSiKF4/Y54YuwRkn5AcG+WgTMN3C/03utQCdInTPMBhP6QaZbfCqwxsK4W1HDgOZcK9mVL45RwRn86Q3fnV8XSfeyxkusJV0kD/7AmtLRaVtG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IojUH2HvxtIxiZMOOqSdOg4+IXpu+S4Jaug1lQuABRU=;
 b=dbRFPRtf3s6tl/CBGv951CTWMMYeJP5IAi/hIE9gZLi08fYhs1yuMWnemmrh4Kbuitn6AxIrnWHh3Fcg0ektezm2S6Mv9RtfiuLLHboqZDAo4Ct7SVxmZglPtB7KL3kmjyVuDJv3HLYIrP4Sb3+Fg+8FCyXrFS1TtH/HUfwORMn7xrmwuVz1UY+OmRh01pWcxfJmw6OXvTyjmtsYUYzYfnZy/i7dPGcF05TH5bbbL/LWcqSUt2vkkNkhvU8x6bpVcuFzi5CWZJWQ7eK6zz2eEoJn9Gl/1d7fme4W2kB/gOu9jKyiBZWRk3PF9lPHTERpvZy5fQAmEtv2hNTUyldBlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:56:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:19 +0000
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
Subject: [PATCH v6 net-next 14/17] net: enetc: move sync packet modification before dma_map_single()
Date: Wed, 27 Aug 2025 14:33:29 +0800
Message-Id: <20250827063332.1217664-15-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa108533-1940-42bd-334c-08dde536d303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZPf0Ysu7q+RrT2mXi/Db3oWqJWSQ9kz39eBi5sEabCdgIYPabkqUkz+6IVT?=
 =?us-ascii?Q?Tgen+1aKs5ub9ZygKL0kStgwf1RU8CSxO5DV33RgVSeEbTgfvbqvzgd1Gx51?=
 =?us-ascii?Q?S8ncMqLHsXvBQtzRpaLzQA5gy6s0sZ6PrHnKqE9kHfwuqzHnPZcxVzmMaZSe?=
 =?us-ascii?Q?tLXPpfOayPDTFFpXTv55fiu+pgUy6BsX016CyuCkqJ1onF6vdkK5ZIy/ZNL7?=
 =?us-ascii?Q?Pnxuji+2eFRhD2BMXYT74PQFXtSt2nmOI8Wbp95HGrX5PoRsdLN2xAA2K1x6?=
 =?us-ascii?Q?xgPM2kycp9TllWAJtlQ/Mx2C1ZOom9eoc3MMGC4DEZLq5+fh9lhG1391E7ug?=
 =?us-ascii?Q?Cu25bx6uzBa2wBbKSoR64ZQq2/dFLI5Y9vufo/qq1xIeGtuKFm2dYk32tC4A?=
 =?us-ascii?Q?g4O2LPRaONeOaM0cyrS2PsykWGED5o3phSEnyS+ZsfnZwy8mfIMbplAEDIp7?=
 =?us-ascii?Q?QhRYOzuK8TPv+Ce54UGejdlk8zZu5niqjDJ34WnjfXhcmCJSoQjGsU0QQal0?=
 =?us-ascii?Q?y/FSE6adlQOhoi7aFs36KIAALQBOgKd77+wSuY2DIFpTz2qXhrCVbQ4Lk54z?=
 =?us-ascii?Q?blhd6kAGnMWDtCygdYHBuaF2qNlxC/4D769tUAn3JttKqB/4V7budBPwXDG4?=
 =?us-ascii?Q?gRbcJkA3mNM6mPtfagUQUH/UHtVcgVan94Yv0EEzX5V4my9XYE3c+EaQ5FxH?=
 =?us-ascii?Q?llj6jKboM6CqVQCGovAZbiYx9vpRtROY5/5KRUOzeR5TxGdUvHFn2Ob8SbIm?=
 =?us-ascii?Q?NvQtrr21U1CFrBunURPGQa4cGckCQVSVNsoIgRglSRzMdU6jNpFZv7Xw25o2?=
 =?us-ascii?Q?xX0PiVsKSUHte6w0dPJNuPH66MWubJOt7YRyJwDEhH/A55ON/N8h9Xkj0gYL?=
 =?us-ascii?Q?+PwSenb15wRviIleU964DfCzSCBlSMUNtCbKASMZt+GjsY3xZh/yQNXzsdjp?=
 =?us-ascii?Q?fAh/ObT6lJ1Yyltnt8cOZE2dNPrC+GsEqlesP+fIOLMf2p7Iybj834STX1yt?=
 =?us-ascii?Q?Q/O4toTt0t6NWXcwLKceiRlDogEEGkpJPANxMjUITSWYeAh70oEH61tyw2YJ?=
 =?us-ascii?Q?uDD4M0H7Fznj6KcHk8K1OCo6rZQ9ZTCAP3BIZTNBcC7vV4y8m1xXPcWDw+lO?=
 =?us-ascii?Q?8lp4eLkE5cIJ9e7nf9dfRcajObqOgQYAh+rQOXSEZ3I05zXjbnZMHhktgGkS?=
 =?us-ascii?Q?ha6LxHC0DYzNPryusA2+dJ2NyWb2r70+VgTelA3ROdLCh0ErfSempyiOSUzx?=
 =?us-ascii?Q?TE5ot6w96kvUbaRYK0aPjYD8yX8eHGZ4J8Jzenndcc6m4r+YuO97Z0ZyX3MQ?=
 =?us-ascii?Q?KTy7Jq51BVs7UwsGmsK/kJ8hkAUnUQEg0nOetstflXdc4BhsKVWFZXcUPgwh?=
 =?us-ascii?Q?aOWdg7pAvgTG/hDEysJ2jidhjgVxS4wtHTsmlTuog8lbRFCCeLtHEiysyTIu?=
 =?us-ascii?Q?m+ZunplGtKjbAFbjaNbSOvtE31oLz1cECmE5AaeQwepE+l7YplRnvitqhaqK?=
 =?us-ascii?Q?MmUQvZqrUt8FhOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h06rQSKfPEIdwtX6Ow/rWxzGxVfVWME2insLYfpiBDED4EPbAK3Q982CQXvQ?=
 =?us-ascii?Q?PbPX8Yv/V1TV1bkQmSH+APPxQ3P8Q0QzrbLPrdWK0HbuGqNmjuBWq8QJI5vr?=
 =?us-ascii?Q?KUfp+Kw+RJubhpjNPx2S8+o9RssRAfc6LTT84xtY7XoemhluzMwKElLxUyg1?=
 =?us-ascii?Q?hh3iDqv6ADL6qQk5zMP6Z3XHaTJU3yZDpnF1+gB6imADKtkqv5Zj6j73hunO?=
 =?us-ascii?Q?fJHZS883tdAGcgD2VKZgUEW6lolVcnco8j8vvEpHaNPcY3PsRtcvhmbHAO80?=
 =?us-ascii?Q?TgM8FLXcKGE7UtAUB4evuWsJwGOVxy5YbyTwy6qBVfLKIa3CdxQbqIPlP5lI?=
 =?us-ascii?Q?PUHFB3u1KlFrI+hrm3Vwq/Ku4rlx22QNxLM7p8M3aNGlNHWbwMxAs0I5Esh/?=
 =?us-ascii?Q?a5iRZkoEm9QlgoL9H27qa+8NqfoLMw4WWmjT7P0mDxh0Z7Y1YnCudgrXGd1+?=
 =?us-ascii?Q?RiAoco6xw+px7ryTO0PkcW4Zxsw2zvhdEdeTnwNrbl8rxUzJcJu/d9M1Gkjf?=
 =?us-ascii?Q?h1njWIkaliprPZcorj5c5fhZxHw2F/+4DJ2BW2DycPVMf2vz698Z8SIOYcsM?=
 =?us-ascii?Q?nsfAFTHN4zS489yvPfIy+41D7+U5Gvtkmumv1NaPwEwfoPDNJFl+NP6ugQC6?=
 =?us-ascii?Q?nZz4wraJ3wv6NQ16h7CeBCIsYLGOcnJIH5DzhsnmSJgIQ48c7OWmKkEsI1US?=
 =?us-ascii?Q?s45Y3+1VKfXK8ZNsgkyPRRiwzycwiWmHTSzQLT8GfF6bn8MCM75wVdXIJnIw?=
 =?us-ascii?Q?RJHiqLVWaLbjX4N2f43DB4MsYgtZ0as2MVBTy5kkchQzsbpnit1Dsxm2PAZq?=
 =?us-ascii?Q?lchmirMyHVAbFfGdMf5c9GsFqYEcF53TfM6c0dnZKr6bCEcdUT050LQdzHWo?=
 =?us-ascii?Q?Jr3FGXSWecQXVaYyIAwDb8GqLVsjq3YnfljkOoZQhqcUJ8vMSlQCWDCGATa2?=
 =?us-ascii?Q?au2Tgwr/6qwR5VMMPVbl7c+st6CRBeD8TYwmDBlPjXo3BD9p3AgJAZX0t8M5?=
 =?us-ascii?Q?I/rBAjbV3W17Qm5FXaehS29qCbyRQtTxYlUDBqnz0pxQ/sZhiMc3luZ6dp+V?=
 =?us-ascii?Q?AD8lj+vcawwvsYh2H+bsR3vyFre+lxGM0zpclP5mhEQRFTOeLZsyvn+C/YJV?=
 =?us-ascii?Q?Bhn9a7MthE0ScPmV3RE2qIZmgdvMKIVeyFmiWexD3J0tC3Wx5N+FLZhh24nU?=
 =?us-ascii?Q?wCLvr9RSDDQlajHOFMz9lPE9fgbobok7k45XfVbxmeLR9h4Gi/Fj6Q0Xk1QO?=
 =?us-ascii?Q?zav5h5EkylYo79faHOJQj/hN4E941iMe5o1+Qa7obQzP0iewFf0xBTGEA2fQ?=
 =?us-ascii?Q?IxK1HddwXXpu5kaqZA3emKoJtyO/xWZM9nET7AGjus6LOz5nTUSJyARgHTk4?=
 =?us-ascii?Q?/v+8AcQ2ScNgNjEGwdCjO41xULk7U2LivXvQU8Wo+aXZslCwkTCRv9EXyYrp?=
 =?us-ascii?Q?r9A/mcET4Ln6b2bliduCEVCtYPx8Bq4i9GsHCAVGIWJmiXED6e3t+7skzaPM?=
 =?us-ascii?Q?j+JELXlTXF2CMuqRPSulGqDYdyWV6YwdonGiflhb7h3SkP92JT+Udrmg44hQ?=
 =?us-ascii?Q?ysgIrRwKOZx1tizbqwwmFlIOirAGgA9UmYD6NHiD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa108533-1940-42bd-334c-08dde536d303
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:19.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rPoopJ04+V+yS9RSrjJV0IsLEUgR07nN2PVWBjcqFzkHQp6apeZiSYt36sO+t0PCSiQHprrmEp9Pg1YRI8dvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

Move sync packet content modification before dma_map_single() to follow
correct DMA usage process, even though the previous sequence worked due
to hardware DMA-coherence support (LS1028A). But for the upcoming i.MX95,
its ENETC (v4) does not support "dma-coherent", so this step is very
necessary. Otherwise, the originTimestamp and correction fields of the
sent packets will still be the values before the modification.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v6 changes:
new patch, separated from the patch "net: enetc: add PTP synchronization
support for ENETC v4"
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..25379ac7d69d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -303,6 +303,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +328,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
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
@@ -346,11 +354,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
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
@@ -393,8 +396,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-- 
2.34.1


