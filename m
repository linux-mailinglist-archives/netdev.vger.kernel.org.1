Return-Path: <netdev+bounces-249863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262ED1FB82
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18BEF300F676
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A937F8C1;
	Wed, 14 Jan 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jsvv4hkR"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D039C62C;
	Wed, 14 Jan 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404120; cv=fail; b=BqMrIFTIXbqKMY9K6KoExVTCNpqOp2b/lVSPdfuXhCtUDyDOo2GBRGrStjv7vOZWLb4uubl1LK7Z/8MyN8HFnM0gVDBNyZ5K3WuxgEANeIqrCDX3i8sVCrgLzvU+xmGSBCHDivKcbYMJzRLgiciPL0wTEVYnMnLUgDbuDPR3WSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404120; c=relaxed/simple;
	bh=I7Lmup9vbfcW1VuqP0qRocQn9sz/IpdIfy511A71S1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5O7fqBTvno5rxOl+kQ2D3QATodrn4N4cmfy60tunLPwIsljWlPmI/wn1Yk306ZMybB+8oyY5Bqi2dJOiWUxULuH1mbnZr0HwNb7HhD76h6itv12Dkx2Ej/Eb3TWuw/gN7+F6mgDtaY/GE4o0GDb+JYYU9bC3D9hrMUlrT3YfNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jsvv4hkR; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0E5gwk+6+V94bgZUi5zq6iJ2T14OaZfePVlPEEcUgb671Jqfh/c8p87KuWdPyU5YyUx2DN2qNaOqczTQsHNJbuk8h5dCh7mC3FYkUQwhGIKURWwmDO6V7/+2iZgdIiUFelrgywK0VJY0GKDA6V3RwqcpVRXkuBm9cgA5TEINZNeuBSZZ6PkRTiU2s8Q/c1yK621BAFalLCs8ePDv+JKH2vxp36scLELyKhW6TR9aLjUDxYAHjyGq2Ow9kC/KDF6Rp6qm7UoYukFwFfHLcfE+us5P1LRFQtx28M4S7u/BUj+kXmdEp2amEp5QErKUzRa2OdLjXQr250CXPgpM/frmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnTWU1ngZKtWj1AHo9b2HnsmlNHaNpaS5FoTywIlE0c=;
 b=kZsIaYRyaT23iX6Dwv/sFO4KjibtES6ROGywFMbgw1ogb0Rt7ZjOyP9W4TlVj5fiAaVCn0mKeiEPZ31Ds8FtZVx7zRjmfCzdbqZ/I2K4bdbr5+RLRzWYdlO26f9Ut2T/6FHTknDjLMFrCXtLAQXqmNxq8D22e7W6sU2QeCjuW4bxwqm28weV1qfH4I+MOMgqFtbcD4CjsyZtLRazvLuNzPqAzTccdCsCdnxXd1zPblnUDRdJrjAp3ijfBat47/aEWCq3pF/8fm8Mv2XxblQyGnAjYK/TLkN/yruC6ykEvi1hviwG8MaUeCo7z4jPfEv6IeemN+Q1pWvQcp0GERV48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnTWU1ngZKtWj1AHo9b2HnsmlNHaNpaS5FoTywIlE0c=;
 b=jsvv4hkRUSo189HiBSr8p1OmGx/gTttRD6sWG9imL4DjOX/aLwfLHwarscDsLO4q9RWoOQSWy1Grrg0xP1m2eF6Ho3T48Ke4AOhPS051ueixstWXmjq0u2Fps+sJZn5Ncl2L3XN9Cf0as3m5IvYL3rlfm7pVocEFEc6F2lN9b4+ZVzarV1i5OgwTG7cPo2wHkMvqTtMHG9WrAxcVPNkrdTdtB2C36y7W9fjQrarR/vR1d9QVxVuK4im302QmEV73KtPN8E9/mB9bdKPT6ZOeeSDtK/d0yPZ9NWXv5QGJHLWQ+QObaGighTk9NoLf1ADPQdq0tmJq8GUqCq5/fUzC9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 6/8] phy: lynx-28g: use timeouts when waiting for lane halt and reset
Date: Wed, 14 Jan 2026 17:21:09 +0200
Message-Id: <20260114152111.625350-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47c72b5b-2490-472f-a3bb-08de538095fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AKoUHKFr2CjPAGqSYtaY8VYY/Fa1k+TPW4Kmcq6SBlaR2CNQ/r0We2JB2Gr9?=
 =?us-ascii?Q?sBy1wipI9DMHbrIzw/E9Nv2dLqd9a5d20/9L0X0+d0HeRRJUX/4sXxEOZ8O8?=
 =?us-ascii?Q?VdfQ07Yb2Ez2yq5LwpJ+u+EwaoiW7MchLqo1T5xducpkg3Nkhs4WrQPtEjb4?=
 =?us-ascii?Q?0NJpIhqtyN+hi1XOJx0trYroLFWhVBw7bZeaCYhE8TxH6tHvBCoGGyfsOezw?=
 =?us-ascii?Q?k72c+F6o+Wn+Wy1W5stpmGIZuGTL0Y2RmnfMvgU0pXvgjHGH7PvM2+UPB5I0?=
 =?us-ascii?Q?6H8c5r/MXVMu06XaDD9Xh4sbEZcBrvB5dy5U3BAD/gFyQaGLzob/OMKFXjc+?=
 =?us-ascii?Q?W42JXVHvwuqye3LGeatLDkgQsKn0b+SncgVFNplac8BcTNcsWQJLYf1WHbf/?=
 =?us-ascii?Q?bXKeT5UDV/c8LxOijiJU8bJi3++yPqPvvNURTunjju9+32qPWgrMMvaM9y/0?=
 =?us-ascii?Q?QKHqenk4l96mrhbSg3iIhEUe/FzAkUE04cdWcC/UcceF2hRM3jlKAFpekTYX?=
 =?us-ascii?Q?u3LTrOm6nAmxEYdKymspUjIvSm/+gfPKorKG8jl+K/8Nr7oi3Dy7QZSuwso8?=
 =?us-ascii?Q?yNafolshD5A3Ul9/3QUcyqkz4FGmZIBGEtg/24WzTXh5N/fjmrg+NqKMK7bw?=
 =?us-ascii?Q?Tuh2ZNXrRoWDFuZLv6dnnei89JA39M+uvgTAZXexFMXm5iYPgPWxgOFQCXRK?=
 =?us-ascii?Q?QQWHHTrxQeyiUIfmozW2eYis51mwCHVX7wwkMXXk5P0dQ8SEGZbaB2cYdIuB?=
 =?us-ascii?Q?G3/1YySKPF4Vfc0A4oQ6mNIr0V8a4CaKJqX6N6qW/Vi2jn+P8uLvcnoiF3WL?=
 =?us-ascii?Q?2nMIjt/hzV62LSJ3OM8VZdsIZYdSokETL34fstSOrRWnx73kYJoQ06GkRIgw?=
 =?us-ascii?Q?JVlxUmsFZxY0/FzNTU4ixY77WEc31O0ilbaHkBAijxuREeobRh+sSFJsgnTl?=
 =?us-ascii?Q?waoY8f+cbgqzQiJvmvc5HbsaIQGXGMZzCVmUsqRNowvpssH8FMLBxvq2g7KU?=
 =?us-ascii?Q?Ka+exj+coL1SNJUxYI2eeNgDNidPFupYlMg/pqakrYO5EvN1+su+C05hprW+?=
 =?us-ascii?Q?hB59VuWsu513RqfCWIrHjQwmMqW5bCouuQDf+hBZCzwQS+OSNHenrv2uzp1l?=
 =?us-ascii?Q?ULhGGq4siJwViYnMxQwbcBIL6M8wpBkHVUgevFZCQA5tn6RInMNcHkP+NPJU?=
 =?us-ascii?Q?Wzkqaw84xCCivU3Bduz4oY1sj9U25JpxTA0jO1fjp3XG98LQGQCw+90Py5WF?=
 =?us-ascii?Q?HxQO8NkxsRNcRV870w7c2vDR+rVPrUpSSpTu8mSll8Xfmzn6dWHbXp2qLKH3?=
 =?us-ascii?Q?G6nnfpp7e6NL47pMrV/wg3paF0wB836hDpcJh08SymGeLyDKZzBz8Mv0mkGM?=
 =?us-ascii?Q?rpBdvHCvUzC2im/WyJ1PRqOmyaO6xcZYU8TFzfTPoJr1ceekJDTHGRjDykSl?=
 =?us-ascii?Q?Errs6Y1N3lIkKK3ZaFVTgqJwDfamVHVzgk0PKGZCUB0zEVd3ywPBogx7zGsz?=
 =?us-ascii?Q?ivmOGe2sZz2fYWJvxOdr/7h9PedudYVg7x9bP7kirtkfr0cjgJBJezPn1SqH?=
 =?us-ascii?Q?gZZY1PyMomWe0mKGDukCNXTqxBSws4YVQQ2wK4AJNhRs4pLyRO3xigRu09bw?=
 =?us-ascii?Q?li0gcaJ8glHce/CJFd0JEh4Y58kMrQe45kWPrz107Ji9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCmAtZlQ+0TJohdojE0JviOkscaBKvK1zYBYFhsK1K7o42KxmnfAtrQiMS44?=
 =?us-ascii?Q?RGNewM+4Djy4ZcxAIc7J3Fs3CRm9Rqssiulk+Z/F1VuQHNpq9fZK5Q3Jv/mb?=
 =?us-ascii?Q?+SX5g0ugJWRdJuzx094RPIhRv862/stJW/jxdL6xmu+tYkRJQLWj7XtLSO4H?=
 =?us-ascii?Q?SP2voulojV2C7qxQ+tFiFwfKEA2550jcq2uP3ULmao3JsDwozijlNqXUqnh8?=
 =?us-ascii?Q?q5GGakFbLsS4xI+48sZ737I8Xwbyzo7/oK4Hp4FIK6sofLWITUL/M+fZB7Ff?=
 =?us-ascii?Q?bzqf50bs9TRh9V8Cb69tCzRqvHS1h0ByKz5K6NCdkr/EMk4gTLnjiXNrKLpv?=
 =?us-ascii?Q?RZ/UQdLTZ5r7weJJzNMSLRrYV15o/DPelwbQdObQSk92qs3AGip6SF6z2fYD?=
 =?us-ascii?Q?yQsffqw11Qt+QRgUwwDTf4G1///Lc4gYscOjiDH9TuJIYN9XH/+Xj5Zf0/sM?=
 =?us-ascii?Q?LW81YzeOOCneQnEoL40ti1XKvQvbDHOqcm73SBBG+AKgJz80aTltSNKrS66B?=
 =?us-ascii?Q?dc0UHR7tN7gLC7v5EhY5e7z71WfZJzCFmJE2vkcTy1oc8P6UILjMxgTACadX?=
 =?us-ascii?Q?GYz5i092gfWKgcedaCvAghHP2VaoUFmDN5tIRzBUOGa/ix/yAULaYwVzMTxt?=
 =?us-ascii?Q?5q2/v46XP5iAYRVbyrKdPwYHKrb1WYowsRgcOW/ydevoGWgwH3RyJqFVzOBb?=
 =?us-ascii?Q?KWgESH97Eirqt3gwmUUfZQs5pE+6HncLK+uWP3RTgVlp+SxEi1kRP5JIVW2T?=
 =?us-ascii?Q?kzN+SHyYSK/VjmGYdXOB0lx9hHIkp3cHJW6Jma2rawxxtn71p520q9O9NVtM?=
 =?us-ascii?Q?V+INBbsZjRByi5/TXDAgyF3Tqa5yUhy7avxCOSOenB3KKGaEN7ru47185rJ5?=
 =?us-ascii?Q?YnEbittT+iHXDn7TzsYNJsUU+Jm51W9sqoel3Awjp+9SQHICG9LI4M+L4O0y?=
 =?us-ascii?Q?+2uiVsc8HGEoRbCPYj7YEh9EfxmwXzjRwrRlHppnoqIfILSfYrxJPY4c9HL3?=
 =?us-ascii?Q?29pVRSQUkGHXWDDqJjrn64jSjrCe+7uQoygpcLIy5gkvLdYMZxsNyDhcktLW?=
 =?us-ascii?Q?mRW+WRqQIiCBzkugvBdCMrPmUv+j2Rg1bCNAeleuFn9vcpUPEe/eUObpe+Sz?=
 =?us-ascii?Q?QTmcJ5EYRP8FL/4viidLpEvfLRboJPRl/5oj7VCMKhaf45CgN4E+qasujkdH?=
 =?us-ascii?Q?AA2Gh5b4nvkQgANhSyY+Rpalze0AyX91SRudGCqZdpydot+VXOguNRKBkzDu?=
 =?us-ascii?Q?kVJcoayb+dAEN+d5sGg1BYnlK75NEpbGnuxGNzdzSZX14cKD3tsDNW5f/TlC?=
 =?us-ascii?Q?6JDZ9cq1y8mhQ0P9R9KBL43HkBualCi6b3XtlCURwPwC96/RVaN7OqSgx8tk?=
 =?us-ascii?Q?kvX2XyUVNiasrDzZciSr4A9G+ijKK0KkDvlwvOT7ByWgC6Ee1BWPYdnn2hxm?=
 =?us-ascii?Q?9b8DcGIX/FC4Opgd/Re54nZi8sQ/H7uYnTWvGjhzvrGuKagAEDJO4ceKX0RI?=
 =?us-ascii?Q?lDSeSQSxqqI24Mtm8e142zVOdVMjfcDjfeCIkd2AXDksAH2aWLz3JfTm2ddG?=
 =?us-ascii?Q?g/Qb5FvBXfKQaTGtsRYoyQd4tJUdUXdvAZVY9cFkzZg/4KwFQ4ZxUW3y8vbn?=
 =?us-ascii?Q?fP7gPyKorHjFZ2+EYQnZe6tCg9tlZOLgo12fptl876Xmom+nWB7LCK13szhz?=
 =?us-ascii?Q?rWNCthca+mv1CZtukBWf5FuSnF6GNPowavXacS3rWT/908y3ay0elqBcFb63?=
 =?us-ascii?Q?SE8ENsxKS8l7SVr8zzLH4DWyY1jVqq4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c72b5b-2490-472f-a3bb-08de538095fd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:27.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU5zM9cW8ada2Q1IK+rsx0wx3Ylg9mVpTORPtgmfvPYCM7H/p1N1+odne23WMLoHU6/p97mDI5wESz00eB61rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

There are various circumstances in which a lane halt, or a lane reset,
will fail to complete. If this happens, it will hang the kernel, which
only implements a busy loop with no timeout.

The circumstances in which this will happen are all bugs in nature:
- if we try to power off a powered off lane
- if we try to power off a lane that uses a PLL locked onto the wrong
  refclk frequency (wrong RCW, but SoC boots anyway)

Actually, unbounded loops in the kernel are a bad practice, so let's use
read_poll_timeout() with a custom function that reads both LNaTRSTCTL
(lane transmit control register) and LNaRRSTCTL (lane receive control
register) and returns true when the request is done in both directions.

The HLT_REQ bit has to clear, whereas the RST_DONE bit has to get set.

Because of the new potential timeout error in lynx_28g_power_off() and
lynx_28g_power_on(), this needs to be checked for at call sites. Before,
these functions only returned zero.

Suggested-by: Josua Mayer <josua@solid-run.com>
Link: https://lore.kernel.org/lkml/d0c8bbf8-a0c5-469f-a148-de2235948c0f@solid-run.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2:
- minor commit message fixups

Patch made its last appearance in v3 from part 1:
https://lore.kernel.org/linux-phy/20250926180505.760089-16-vladimir.oltean@nxp.com/

(old) part 1 change log:

v2->v3: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 96 ++++++++++++++++++------
 1 file changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 7ada581bbe4c..048c24c48803 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -254,6 +254,12 @@
 
 #define CR(x)					((x) * 4)
 
+#define LYNX_28G_LANE_HALT_SLEEP_US		100
+#define LYNX_28G_LANE_HALT_TIMEOUT_US		1000000
+
+#define LYNX_28G_LANE_RESET_SLEEP_US		100
+#define LYNX_28G_LANE_RESET_TIMEOUT_US		1000000
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
@@ -672,10 +678,29 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
+static bool lynx_28g_lane_halt_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return !(trstctl & LNaTRSTCTL_HLT_REQ) &&
+	       !(rrstctl & LNaRRSTCTL_HLT_REQ);
+}
+
+static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return (trstctl & LNaTRSTCTL_RST_DONE) &&
+	       (rrstctl & LNaRRSTCTL_RST_DONE);
+}
+
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (!lane->powered_up)
 		return 0;
@@ -687,11 +712,15 @@ static int lynx_28g_power_off(struct phy *phy)
 			  LNaRRSTCTL_HLT_REQ);
 
 	/* Wait until the halting process is complete */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
-		 (rrstctl & LNaRRSTCTL_HLT_REQ));
+	err = read_poll_timeout(lynx_28g_lane_halt_done, done, done,
+				LYNX_28G_LANE_HALT_SLEEP_US,
+				LYNX_28G_LANE_HALT_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c halt failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+		return err;
+	}
 
 	lane->powered_up = false;
 
@@ -701,7 +730,8 @@ static int lynx_28g_power_off(struct phy *phy)
 static int lynx_28g_power_on(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (lane->powered_up)
 		return 0;
@@ -713,11 +743,15 @@ static int lynx_28g_power_on(struct phy *phy)
 			  LNaRRSTCTL_RST_REQ);
 
 	/* Wait until the reset sequence is completed */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
-		 !(rrstctl & LNaRRSTCTL_RST_DONE));
+	err = read_poll_timeout(lynx_28g_lane_reset_done, done, done,
+				LYNX_28G_LANE_RESET_SLEEP_US,
+				LYNX_28G_LANE_RESET_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c reset failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+		return err;
+	}
 
 	lane->powered_up = true;
 
@@ -1132,8 +1166,11 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
-	if (powered_up)
-		lynx_28g_power_off(phy);
+	if (powered_up) {
+		err = lynx_28g_power_off(phy);
+		if (err)
+			return err;
+	}
 
 	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
@@ -1146,8 +1183,16 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->mode = lane_mode;
 
 out:
-	if (powered_up)
-		lynx_28g_power_on(phy);
+	if (powered_up) {
+		int err2 = lynx_28g_power_on(phy);
+		/*
+		 * Don't overwrite a failed protocol converter disable error
+		 * code with a successful lane power on error code, but
+		 * propagate a failed lane power on error.
+		 */
+		if (!err)
+			err = err2;
+	}
 
 	return err;
 }
@@ -1180,9 +1225,8 @@ static int lynx_28g_init(struct phy *phy)
 	 * probe time.
 	 */
 	lane->powered_up = true;
-	lynx_28g_power_off(phy);
 
-	return 0;
+	return lynx_28g_power_off(phy);
 }
 
 static const struct phy_ops lynx_28g_ops = {
@@ -1240,7 +1284,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	struct lynx_28g_priv *priv = work_to_lynx(work);
 	struct lynx_28g_lane *lane;
 	u32 rrstctl;
-	int i;
+	int err, i;
 
 	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
@@ -1258,9 +1302,17 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
 			lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
 					  LNaRRSTCTL_RST_REQ);
-			do {
-				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
+
+			err = read_poll_timeout(lynx_28g_lane_read, rrstctl,
+						!!(rrstctl & LNaRRSTCTL_RST_DONE),
+						LYNX_28G_LANE_RESET_SLEEP_US,
+						LYNX_28G_LANE_RESET_TIMEOUT_US,
+						false, lane, LNaRRSTCTL);
+			if (err) {
+				dev_warn_once(&lane->phy->dev,
+					      "Lane %c receiver reset failed: %pe\n",
+					      'A' + lane->id, ERR_PTR(err));
+			}
 		}
 
 		mutex_unlock(&lane->phy->mutex);
-- 
2.34.1


