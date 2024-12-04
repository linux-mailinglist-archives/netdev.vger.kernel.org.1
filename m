Return-Path: <netdev+bounces-148816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347A9E3343
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2F1687C4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A110188714;
	Wed,  4 Dec 2024 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCDoFt+G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431F18BBB4;
	Wed,  4 Dec 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291150; cv=fail; b=lY+bepSmOet1PH8AXBMu2y05BLu6s5KHILw3con09kreGW9ugBRlBjRXDN4RqNlmpk+FfzvhoL6/CCVmJUOG4VyA4+X04isimPOLn8uLgr7PomLA6eXNTh1p2Ka/1LsLUDbjabSSCuCE+N7ZjZ6udqK+amx7OXeuLNSnwJWOKfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291150; c=relaxed/simple;
	bh=0zMCVcmhBjEAQB56ErX+Pg+cFqK8kJANGeBxfRcdOjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIjkEp+ZifrLTiD/ublteXHQAja0rDTP+8T7x0CZWIWHn32qCs2pwxbe9MwmYp7OITNUD2QwIPdoTKLGO2tJJvx4uXfsXgFN9gg5mSIDew/Drsfx10j+/IGVcs/ouSj4qeslzMKTQ2hk8I9VwQhn+Jn2bm2e8dUEYNMxbMmmv+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jCDoFt+G; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQWHSY7wxizoJXGrTo1q2+Jh4w7Nkh2abiUr1RCmkyMCrfTB+HSxPaPEV5QehbOZJh+eEsBnG0wwdZCjBK3Q7Q2zL+v8h5aNI+s0y0yrJz5V3oxkk7+ZRdzT9fDbsmDHv2bG6RTgeltPy15lCDn4B1RZnZxCyY5mg2qW4Q8G46pUN8TErAp6Rj9pvuelvV3f7b9qsnQsNsPQgngeNWLM0DINpM+9oyQKWNEo5nLRfwOBtoIR2NWvOoPl2FFa0IB7M9hDIIvp8JyyHE1Bg4Cv24POgKJd5RLBGdDsHap67z/u1hdQ1P7e8xv0Tg5NftUzE/YOsHLmabEop1FFAKuLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/AfWydI4suESLBCktZljT3VITlQfc8BgObbW/0oW4c=;
 b=CagIpCb9ImoULqK6yYUs6yI/SX9uNX+sv2FIrQsQ4KwfVL/mvP4IhiR8d6fB4cJZRTPvYXrhjbJJN1xrfXnCnLP5Z5hrmbZBWvRQythScAStjJd7tk75ycphWDgooRQjc/OTrskMMYoRLDIe3RuhthxuPFzfUT1TL0j3Mdefn0rPJnXQ2r1tdc20Ewi96KdWkOGaEgYc0EoamVfPeU8KF+f0HsHDIwgAcSFQoEnLoOJ7q8cDcBdSDWgpzsMhZTOl/3Ai5+dW/3N72l0nb/h9lMO59791oDxp/MI7BAl9SbATxTaUa2S5+784rIjyxCe4dpOFBsa9mNLe34/nrt8JKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/AfWydI4suESLBCktZljT3VITlQfc8BgObbW/0oW4c=;
 b=jCDoFt+GsQwRkuxlqQ/Y++zUioRzMBgIvI/1vdOzS+XQQJwQZlI3dq/wmjCPYDfDQStBS6XfoJXpzX9GxxLDaXTeqXAGAsdXg4vQ8h+no/c9LngpKofz94gZuaqOprrJtAjuGeDQEcV+R7cZKeGtqXN/2In28Ki76/Uw8sX150R7gGaq7t0HMHV2m6b8FNxwuTif1F0mXSx71tbuj/mJgts8jFUs1/Rmtc56bzIjc2CduEjsB0AoAOrfoAY+iWE9BsOrl3yDsmMUfUyGMqhVBvV3EumDy//cw5PQRGyqcdRvuU2HVvs4uQ2XFpshtcnfVm2dfdVIFFxleK539U+Gjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 RESEND net-next 4/5] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Wed,  4 Dec 2024 13:29:31 +0800
Message-Id: <20241204052932.112446-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204052932.112446-1-wei.fang@nxp.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba068ee-2b39-4670-1d12-08dd1426e526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M3h5Fo/lUPWLEVBo3lAwDHhUEg70MBRAe4SoKlCo4v/mgcMCaZQGR5dQw1Ns?=
 =?us-ascii?Q?586/kq5qfwHN6Ti2rxv1thD/B8r2A+fPh8VEk15rokMfg4QLlC3VR6GIr9Q6?=
 =?us-ascii?Q?5VdzJ8rseRt6/yJX36arq1diDqy8uQ6HVKH1Fj+ZpMKq5PbBzU64QcsAzER2?=
 =?us-ascii?Q?+TuGLDEUgBU6Gf0SFfUP8+1RHo8XufZKbCrkzlv37qZIrqBEJETNZ9ljg5PT?=
 =?us-ascii?Q?RUsfBv88UNiPmzYLabL62oM9o/1LtQx8dP2SnKRfYNc4137Qme+Iqx6YM0ZA?=
 =?us-ascii?Q?6BZppXoNNKO8ptT8Wwi0mGsouzUh9yM4gXWG/KYHq57IeUL95co21+zpJbNp?=
 =?us-ascii?Q?CvRT6a/efkc8lf9Ct/BdzqyRYo8cAOVeogYG/kIOMBbkV+LUSpFDB0PTeaQD?=
 =?us-ascii?Q?VqLafwWjundREKf70TOAwcwvO277CpOfv1omT5q22HqpBU4MsT9bVtvPrJLK?=
 =?us-ascii?Q?PGdBgjNE9d1MhmT1h4CsHAY0FpF7P85pww39jwxPgK61J/LLTRriAcjhv796?=
 =?us-ascii?Q?RLnSpE4wcBcj3LA5A2pJdDisSUJ9Y/PiHqGBfJvjQ3GqQVdJQBBG3yci2rgP?=
 =?us-ascii?Q?uop5Ii1Zh13gUQkUAV95e6fTVXo4RzUFbGS5IqgmDlMiHkAHMOuxpM8o14Vb?=
 =?us-ascii?Q?zLsOqoZ6serUslrIGS2fURvddGAunPT91siQpFfaU5yAnJ+Q5H9qZxd0s0wF?=
 =?us-ascii?Q?tUH04Owc61P5pQ8NhhUwcJoaZVH16oyFRLX9KFmvETN5zTiVEGYi1k99S6v/?=
 =?us-ascii?Q?LhsfQLBhTSIz/W2Q+K/2vH23SaL3ocqQk/vjqbqNiCuowDzvBC+5WjmmKQXq?=
 =?us-ascii?Q?WU8KQZGgFy6C3C5xcXrLtErxD49Kh/h4309g59yo+vDbR+2EbLmHr6pDZP/L?=
 =?us-ascii?Q?g0I7/zwFPsrNZ7NCb1MIT5vEBGViOurtiwRyz5CVRQr4PdwJCJRlCLMow25v?=
 =?us-ascii?Q?QghWnIFdaG4tydzAn1qZTclz6qMizXKe8T+P77rLjTEetB9XnqNxvmeclIiJ?=
 =?us-ascii?Q?G+hOHJfzESbhAmONp5zN6goco1A0mQd0MJY1QKkxil0sOC9pCMbQBtQKTr/v?=
 =?us-ascii?Q?zWsSikGei3UJr8SR0UtGSOKBKAZ8vOKtOg0Dcr+QFydclclhzrO8VYdFO/8A?=
 =?us-ascii?Q?ADpNT4ojRGRfilthsgECgwqRwRv30J4VyiLSDZerHkHfGctYIuFHiae5C440?=
 =?us-ascii?Q?2Zgg8aTnmuk7ciG3/Xhy8gTCYrb4NaEOWY1aBjteaBMdC3or/K+Cp2KjBEKh?=
 =?us-ascii?Q?1lX1wcLuhb49gtwrXXQawqj1KrcEV+0w1S7+lBB9p7joxyJkPaS4l4q3cWX/?=
 =?us-ascii?Q?uHfVqBQKGTUS/gelK9R9sxfRwLinc/74BmrPFQpueUIyMJ0opebm9iF0HP0k?=
 =?us-ascii?Q?ye63+pwexJst0gfh/3Z032FOIceihRlddHTJRzxOFe1eYMBjnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPUX7p7OKHL+PNN47ADCoaTFda7qmllBdE8Hyjrg+BaNbvIKmpdYPcL7tdRz?=
 =?us-ascii?Q?QhwoZfRiZ0Q5fdV4By3JTjUFAH7TBludB6zqZuxNKg2C39CFHs0hKjbQy+Ml?=
 =?us-ascii?Q?YqNf2k2+0/quGNZk9/D+ePA9FoHHu1RzopHkYcyq1Rr7JdVGsXgKdtMtdX2Q?=
 =?us-ascii?Q?UX7etGSiBfZ0+5vwXHh4P18yXvyG2G6IC72sS7xrpVyzTNEG0VnwKo85BRBC?=
 =?us-ascii?Q?eBAipQF+t8m9m5ZGlHiIotZLLN0ybDeUuE64+x3K2Xi4mxH4Peelv0634Fbi?=
 =?us-ascii?Q?W2t1AvIBgoj3hMbbNdpZiv26CnxgRJv/DUTB/Ik/UmlSQzRtnssjuwUd3p7j?=
 =?us-ascii?Q?gTvEWYiioCuCEyZAiNo9QwQVkJyWeYFjZy9exVoEUOAaq02tmK8o7RcZ3kKM?=
 =?us-ascii?Q?Q+9yRjsRCt7Ep2FcozVdYn1dmVwlwAWcA0KliTtMBFxrq6E/GpAYR82NVNjQ?=
 =?us-ascii?Q?6/sPXGgyefuXl/bEO2avn1vo15XGzqvGZClTugYb1liGxCMAKhNjxv8GH0nA?=
 =?us-ascii?Q?FEaM/DGRVY5QrbiuI2KzvIZ/cmXMym8A5Lc6K2BaMNJp2H+HxD26UjyKN+s9?=
 =?us-ascii?Q?FAVbiUP8Bmtu/ooKCoBQ/nklzUm4u7ul3cTm2AA9CQEdIwgZFx5f7g8Jt1PN?=
 =?us-ascii?Q?1kjUKg8tDf8XzfDrmJlm5Z+JLxbHTqY3mM0Vfzr5v4VdBjW/zN26hjHU9v3u?=
 =?us-ascii?Q?EVAf8JOQGGZFSBCNcdvIGp4RubVsLoX5zHwW2uJbq/Sad+8mxcgMIAdTS5Gn?=
 =?us-ascii?Q?pyY5WzYDiFO4lEXVw5l9f1O493+rJLSUNYG5CQziuH6MZD+bYDSHR/9Kd3A9?=
 =?us-ascii?Q?sq51o4pOhkJVZYj3sgK9S4kplOJ9GgszeF40G0MJrYs+i7Gaf4qbdrPF339Y?=
 =?us-ascii?Q?/180Crns61ks/mp+fcJQFBQyBy5lpcNCPOSgjxF3XkqBwiQ7ezA59iVcLdl2?=
 =?us-ascii?Q?1e6U+AlKZK5Z7xPn3AOUjYEPeP8i57NCnQ4RmTI/V2CLXegyncAxF1ehvoR0?=
 =?us-ascii?Q?uJzEmwsPXfBILVoBWkBA2nnraTu1mr8ZGx6oH166gwDDz0Xb6Uhadm7PZqTI?=
 =?us-ascii?Q?5ER5QaRufW8tv1Jv1TEVrrIHqzuwfkMU/RaGLP9DMvIxjyNc9Qzpf+o8Kywc?=
 =?us-ascii?Q?gXSC7qARWS7O8pDmMBRc/DaQUUSW0W7RCrdQj847piEe/8e4exfgNmmUhd8q?=
 =?us-ascii?Q?WN2B18NYoa2FVYfacSRUyMjnaiflcDR08jp0f58ANQwa4ZvaPev3XATqRY/I?=
 =?us-ascii?Q?yQMxz3JxGdrhp7be7NiOwleOjKPXLZY5M3lzNbXPHpkyIsluqVkLtJEu000l?=
 =?us-ascii?Q?oSz7/HR2J1poeRP0tIH/6Asaqv21YSCOVa65jbHr14T+xgMEgFneDavRYFUZ?=
 =?us-ascii?Q?k2l/Ybnn4kXviNqnNaVEgQDbutoJp+YFBj/X5BU8Rv0jMEg+XijJjJ2zV514?=
 =?us-ascii?Q?Z+RhjwGCJFUemReRd65svXOIhrzrPoitNpD1eAANKM3q9nUNhIzyozHHHIrN?=
 =?us-ascii?Q?nw7pQYvcbwtqHRs1lkCeb6G+wZGmKX2tQ6gWM0EXtjydvlQsPix4HCwDhsJf?=
 =?us-ascii?Q?HKmeQGVb9wq83Uw0KdHs5jr1oGn24DDmQi6aTT3x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba068ee-2b39-4670-1d12-08dd1426e526
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:44.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHjzkoX+J8dESdpxUIKxNOJQtqCF7Zn65yg9koMyO/CSnFbZWe16dW8eC8OU1Aj5z1tuu5k8lsSjrNJPJwywmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
v6: remove error logs from the datapath
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 259 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 304 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index dafe7aeac26b..82a7932725f9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -523,6 +523,226 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	if (lso->tcp)
+		txbd_tmp.l4t = ENETC_TXBD_L4T_TCP;
+	else
+		txbd_tmp.l4t = ENETC_TXBD_L4T_UDP;
+
+	if (lso->ipv6)
+		txbd_tmp.l3t = 1;
+	else
+		txbd_tmp.ipcs = 1;
+
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_hdr_size = lso->l3_hdr_len / 4;
+	txbd_tmp.l3_start = lso->l3_start;
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -643,14 +863,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1796,6 +2028,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2100,6 +2335,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2113,6 +2355,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a78af4f624e0..0a69f72fe8ec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -353,6 +367,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
 	ENETC_F_TXCSUM			= BIT(13),
+	ENETC_F_LSO			= BIT(14),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 590b1412fadf..34a3e8f1496e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -28,6 +28,8 @@
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
+#define ENETC_SIPCAPR0_RSC	BIT(0)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -574,13 +579,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -589,6 +597,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 2c4c6af672e7..82a67356abe4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -126,6 +126,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


