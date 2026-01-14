Return-Path: <netdev+bounces-249857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F2D1FB94
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672E730B1E1B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2339447C;
	Wed, 14 Jan 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6HW99cp"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3B39902F;
	Wed, 14 Jan 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404094; cv=fail; b=K2OzCy4njgVFOONfb6LAmG8J0mFNKV1lFcsA1gfIEmHFVg4Li/hvAagZETV2kBocvhtZ6n22HvypHLj1+AN7pFslCb68BH6HpJ/m5EQme7VQS84p1/GNr3ERkGes6Jm5fj+WxiAjqii5wZMA9L2bNixd1DCA7FY0whr8UZzgvgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404094; c=relaxed/simple;
	bh=wmsWA7vlVSen52iNgBIotQRz+NnB4BGfXivDt7J3Tbw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gcOHAwBWTyfHgmeyFKikqcBnA+bVX1VJ2rAfqKFy/8yr1z3wv/jv6Y/Y5il6LTKXisfYmfPpTf8pSNlEE25LvLQ+QrzMjAZRMplXs5gp4OMOnM9rNE6vLugrTvw8Pm7ZKCoA06nkC2B2ndSIOA5k4rmQb7rcRH+Hb95XazbfoVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S6HW99cp; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBJ6jjffP6wtA8/jKrdoAoyH58+OX2svREAvMw+yMbzzZ7NqrLksuHJamUY07Zkr8B5NWdVeTyQNmLzCetWHhFI+3RNR3f/oQorjXvA6MwQfCqx0oTv6IK/BY8jSZSwUywAhirwAP+sXD5bzSHBeXoVNhoDKipZIEV5MZbz0k9oo3tJsnET+a97glNR8xdBVOC0sqaiUYLdVymJQIqUR4yzkfUrgS+OD0f/C+WoSTdJDp7TUfQnIdFEAkrKAFZHaMff/z23xjiywDHneMLrygLMSjJkOpHEA18lxEdNI/y4L8nxDQij81Nhegn7TF6Bow40EJ2EiH/N8afBHXIiQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgJj/N+HjoksY39r0PzIFRgFkpZ0rgB8c7GwuZuQYC8=;
 b=FCjCJAMiXjuh69I6NxAM5wX5q+b8HQmz2pVwe6qIHhdbNo+PicBSWfHzY4Q7HI5tCn1pKswjZQi4xYG24NzvZeYPIllo00cBptL6Hy5gMIi23nSnAXPIdtiRnnpqR7BNzD8uP+DRLB14+PGJQikUqK9IwR5aXxUU3UkUSE8R9ldPap+Jx1CHTx0lqGQasggQIS4LnTCwpBhVLekmek6bOh04iuDXe4cnEbaAtBryKW/gDSwKKRyA1U3XPsjtRl5lSY0QPN/KVgRCbmDCsKMNp3alw5argO4+kJPOVPhtf1YP03um23Su7peZru5m8p23qdO2PsxwQmjyRQeyykVG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgJj/N+HjoksY39r0PzIFRgFkpZ0rgB8c7GwuZuQYC8=;
 b=S6HW99cp33oBHwlw8JKBhmfAMVZm1WL6CtZ9FhEF10HGlpwl9/tAmIg6Hq70PNpKS+CuRvJGXqU+ysp5906JsCNzEiz7pfLx60xkHzyTVv2kEUN84v/hLgXQ9yRNR9Y/1fSO1oDAGpViSzdJDkmMSE1maw/kdivirLplN3Dnn/LB7+Xtg00PVAEHdvI8vGOQNh89G2gq9kD+njHjLf97wZMUdCFYzXTaHUG/nDO4aS/9wxFXmjqoPRanF+k4Na7YMmC30y2GSQ1onWyuY42WuZ88kMQtV54e1YFDxap1cwHm1r/qAgM9wWvIUzVoczPz3fDvTQN9vddfYc81sLE6jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:21 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:20 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 0/8] Lynx 28G improvements part 2
Date: Wed, 14 Jan 2026 17:21:03 +0200
Message-Id: <20260114152111.625350-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d80d6cf-8316-4011-1956-08de53809215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0u+o92LAo/nWBUQnRRU72vCG72o1MLTgrAjLR+KfTefDBxikjGy74vtndrWq?=
 =?us-ascii?Q?i1nQMFxV/K/s4BOLSzf2aYWnbx373MEX1gt5sRHc67Xn/qvQ6Tg2m+LvZmAF?=
 =?us-ascii?Q?iMjQi0RI+37xBUCY0wVSoxehDJgW0MG7PGuoJRqiP8ej37yG3nSmxMPA+osK?=
 =?us-ascii?Q?zTgJgTQApaN5iqHKy/mPx4nLyj9i58Lm7VGXL+zurwiqEyS84YVVo2aumvwm?=
 =?us-ascii?Q?dKDA3lH+qo91Q/FFyzFOoJNrPEkD0KyETwPffvByYqkmHU5jqAfcviGYdj8P?=
 =?us-ascii?Q?iJMSaDFttXy3prdXdbdB77XoqHRacMr6f21rJ0fl59kY6P1o61T0DdKP3neh?=
 =?us-ascii?Q?uYT5UpB4Nptkhs9hDSYWzQMFFk2tKHzQqb7wokjV5eHsSIg3RQ1xXtzNKd1y?=
 =?us-ascii?Q?I0tFKQ+h8/JptU58+GFrnfNkd4/xMhHHx2T9RUzMAjU22+t03OnGBpFIh8Jy?=
 =?us-ascii?Q?w0H3BHGx7wwz1kzR9hCr+FTbPWjypTQfMf98THtQJrX0u4dHvw4SbAwmKfPI?=
 =?us-ascii?Q?aDmFYsOEtjTDA5u/gKLOSxAuw9fbq/eIa000NENGN/Qt7Bcambq5b5lItbK7?=
 =?us-ascii?Q?JNK+BeoNUOfHYQLtgHNc4k6REGdLl6iObawcj6A0jvFCNTo4m0xSFr/XBFx7?=
 =?us-ascii?Q?TelaU0AR1mLZxYpceMsdo6ad7DfFNLjGlT653LRXyOf5KD8VbABwphtMo5sf?=
 =?us-ascii?Q?bMSCpmCVvn6lv0c/ZWF5ujveLq90bdhN/LXMzkMoHMlyb7krwY7wclK9MnQP?=
 =?us-ascii?Q?fPHEnBD7drp8v+XYTMdnUmr3DGkLoHewUep7Hadzp1ngp7AqmZymMAESkZPh?=
 =?us-ascii?Q?oJArzN0iK3wsrKW+1B/rm3wi9uvV0WhhDt40wzX1W1ksc2AW3pP+5pQnfjsJ?=
 =?us-ascii?Q?/7r0FVtSi6aiOEvCQHg2IzoYeUxLfGBeFRGJfIHYgmgN7ZNRVe374muOTs1r?=
 =?us-ascii?Q?RBj2wc1mF8i/kNNQ6zH+7l0K4/SHPNDE4IPyJOckm0euSi0n1/ofRgsUpZvd?=
 =?us-ascii?Q?ZExFBA65FdCtsN0dvltAAbRNAH9e8vBe4CtBNwgWDamcOPKMFLGvh/GevhXi?=
 =?us-ascii?Q?G9LeP6XT1hSfD5cheJW2e3KYW9VIJpyTl8tx3UZ9KXPyr/aRMmx86Ara+Xnq?=
 =?us-ascii?Q?5PGJQRhm+At6zXe8e3TTIO4oXrcQMqk2HR5apfysD9ysm+i7/ulOrsEM998w?=
 =?us-ascii?Q?gpLWjyTvSxNfi++k1ldONXmn5M0boukZkqQF5YJtgF4GEknUaRDueTi3G7ZS?=
 =?us-ascii?Q?dM/rR2dr0fn19IQGij0DKwwNKvuhC0rA4pZCKb8CsybxE2GPdztRw+uODW0G?=
 =?us-ascii?Q?4U5R9MZ/zD6KOely1IFlTSV0pA2d/jOBIy7om7jobPSU4zvhnrcX/MfqbSSx?=
 =?us-ascii?Q?GpX9dPsiF2j5sHYrfHTRYAx3hd2glKQBKibVzTCWfU4Z9LljfdHLsEbJz8yA?=
 =?us-ascii?Q?z6+80+idqLe0hfVRxSHNZZoGFGcg2uOhq/rCZtzHyZC2kiDC/nKtNZv//PCM?=
 =?us-ascii?Q?R+226rxGmvHJTZfRoQ6owL6znDIkGsEpP5aowrOQp7RwRuiTsWUqhIIzT5oP?=
 =?us-ascii?Q?3fUJklFGSF0LhhjlS80j8QWZWaX1AqMFxXr7Cu9Ne/DbYP4m+/rMPoCLnTdq?=
 =?us-ascii?Q?eglCDkE2kvfCTEF77vazlPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLVhgALQd5tBpoSaLaAKCY08eRgPN2IPp7VgI557JUXi/PZeZPqT9scyla3f?=
 =?us-ascii?Q?c7xA9C2FXmOFu1Gg/ZN63+ydEW3YMUggOMTDpDNd0zzTnda3gHs1JoLk2qzn?=
 =?us-ascii?Q?xKuONODF8fcTaokGh+KLBg5tHipslMI+4fNjxghw7M+bPT4mNlMyigNcVJK6?=
 =?us-ascii?Q?0CY7TANviyy22OOh532J/Y379qy0yp73nsrFPDDeObXUHeoTO79aMx0c0AbQ?=
 =?us-ascii?Q?L6Hi6JwvOtP+Q/wGFJyMdhMHupFitwVBolnuFSPmRli/d1SOpvctI99osMlc?=
 =?us-ascii?Q?Vs7vbt9EsOJS3tWYgNz5/TWXWgZd7orUT89RA6D3A7yRydpW+lIHWwEvDwMA?=
 =?us-ascii?Q?kpu9kB6OkPTG4y09kXhy4URtJX4R7u4CEprnlcWrhAUXlBZvtCFqyttDqBF8?=
 =?us-ascii?Q?9w3UkD//9k/udv9d7fuULYodTyj3TZb34e6JAYT44vZj1JK555YabOnKkVSf?=
 =?us-ascii?Q?5NBvkjCxkQq1TCFtiRmesju9cKaGKmhEYwPeKIRh5O3e3spTUpiT/OqalS+x?=
 =?us-ascii?Q?ZfrDm4qGs9ptWjsLnPdHjYfM6d1zatuQDkdXZT2cZ/QETAxdFB+9aRkB1WsA?=
 =?us-ascii?Q?HfTl069e4o9ql5fX0VhSdDtime7yQDl9dkJQsRKSJuh/vToC/94QqYqNIkhh?=
 =?us-ascii?Q?DI//V18ep/OlkV/yE2dg25Z+TrN05jzFDws4sTMx6Xq21cyQFUj2YtBPfuRY?=
 =?us-ascii?Q?i0zI9/JByH2QSrhjzBFsTcE+rVRwgYU41KxbLDQZjn9elLrgbYLk5RQbAq34?=
 =?us-ascii?Q?on42pCAS/stCQg6HcZpSQKP/Hz8ksB9qFKnxdv/7tMFsQt9qYVYmqnwUlu1r?=
 =?us-ascii?Q?9s9A40BogovEwT3JlKaRlFleO0ACBzyu5Ed0r02a+pq75QgMHjMPICCwcOZ9?=
 =?us-ascii?Q?NlCKGFqio5HmiQMGhFWOB5QKMwN54zDySDfNZryYMd6cxtmO7dVv9yOTPc6f?=
 =?us-ascii?Q?QujQcgCPb4h5UwBRCdc9PiBTPuESPtcSm9axzPI2mHnVotJh5y28EQWLGSLU?=
 =?us-ascii?Q?/CeT5UD1hD/I6sTsrPaLFTPqIddwPjBpfXC0NJ9/mnpfFC29a2PUTRupgUsp?=
 =?us-ascii?Q?yIOcmEnU0DlP4vrPuoZbpjOu6i2tfdHZxyfkV8rbofaaivIJwSWx3adLtvVR?=
 =?us-ascii?Q?AUA1yG4iBw071Ib280wbHZ8qKaIZm6d5lumzpgjUK/9sjy6BX/qV97KbrNUk?=
 =?us-ascii?Q?cZUPWFCVuEu6dKG78Zl8tmMy5nPEOypR0DhrZ1V6IYNAEGaR9e+xHrKFO2D+?=
 =?us-ascii?Q?yOQRHHTIYc9sF2q0q6dKOVgyftCe0MeULRr1kPzAuiY9vHRLIZEj1Apk3FgB?=
 =?us-ascii?Q?2tCYxJ2d2d/8ptA44ltz92u0Mfo76nz8/ZFmrEdOlDEFS3X57Rv97rN2ulEQ?=
 =?us-ascii?Q?nuAMyDhrEcuWLanRVtYtrD5rpuZip946YMuy2USB8oU6ejoqQ9rg+97dXEuM?=
 =?us-ascii?Q?axdUP3tt3bV4eVbgn251Tfa9IdqvYqkocZkXRfNkEABYCx28W+UkrZtm9MEn?=
 =?us-ascii?Q?EV9LMelGNsijGKf+4cnVZN3Yj+P2bTVQvOuXiOr9aWzFAlurjlExGCvb3otq?=
 =?us-ascii?Q?KezowZwchJlxCOKimSWnw02YZzWajeHMPKsYXy370MxeelYI107bZHiGs5SH?=
 =?us-ascii?Q?tEsoHrqyKno/hRm2DC3KYrVzDpUWpGC5IyIt3uGHIXfVC3FNkZJVAfBrVDg0?=
 =?us-ascii?Q?3G0AX8vC1IGCbDayZySu9sAvWL+vNhHBNewtqVIwAeo/J6TNsPb0SiRWg9OH?=
 =?us-ascii?Q?C33LEsZqLTOEA3g1iP2S6noWFQtng6o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d80d6cf-8316-4011-1956-08de53809215
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:20.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t18j9ty4xBtLtb9lCyxLXu2c+U2t18yd7IDcZQrjK3SUhtrdyS6yYZr8MXUom5A39f/tGCjwvQAq5p1gLscfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

This contains a number of changes deferred from part 1 (patches 1-6):
https://lore.kernel.org/linux-phy/20251125114847.804961-1-vladimir.oltean@nxp.com/

They are reworked in ways detailed in their individual change logs.

I have a special request to linux-phy maintainers: after merging, please
provide a stable branch/tag of this plus part 1, that can be pulled into
netdev. It is needed because phy_exit() calls from consumers would
compile but would cause a functionally broken link, so we need a linear
git history to avoid (temporary) regressions.

Ioana Ciornei (1):
  phy: lynx-28g: add support for 25GBASER

Vladimir Oltean (7):
  phy: lynx-28g: skip CDR lock workaround for lanes disabled in the
    device tree
  dt-bindings: phy: lynx-28g: add compatible strings per SerDes and
    instantiation
  dt-bindings: phy: lynx-28g: add constraint on LX2162A lane indices
  phy: lynx-28g: probe on per-SoC and per-instance compatible strings
  phy: lynx-28g: use timeouts when waiting for lane halt and reset
  phy: lynx-28g: truly power the lanes up or down
  phy: lynx-28g: implement phy_exit() operation

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml |  50 ++-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      | 418 ++++++++++++++++--
 2 files changed, 420 insertions(+), 48 deletions(-)

-- 
2.34.1


