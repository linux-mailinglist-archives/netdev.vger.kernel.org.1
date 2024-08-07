Return-Path: <netdev+bounces-116499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8A94A940
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FBA1F28AFC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F08E2770E;
	Wed,  7 Aug 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkXwC8PM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FFECC;
	Wed,  7 Aug 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039318; cv=fail; b=jwyJ6cYuataXbOdsvD5Y35YQHh6t1kPtYcAK4TLMiYhJ4BtTaa5AkGcOMxZz+kVSTl2It3vy/P277a+WylCPJmxoJLSBoI1GmdavRMuPuKNuVFnVJTKgAq9XVSpQQAhfBuLRcCBS64I2SxhKpkVN7Uw/JAyBiyByLAvRnDaHems=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039318; c=relaxed/simple;
	bh=jnRVV2qmhh/yYrERqI4FX6mU70KJDG4APAhVxxLswfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u55ADQXptA9MgbZbvgsq+O7TF8Qq9pEuk7LU9GkEschgQR12wX2rF0acLHeJGmbnwRmD82IFcB9XWuEDtgFyFuLvWo9JH/TmGj+1nW4ngMs1A8JKmcIac3t7B7qaRd4V/rxmjcn/tuyfJ7kX4eGsP2cuLtR7eY9RXHv6k0fd9Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XkXwC8PM reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMgjgcRGALcol2CW4PIZ6MAwJE3DD4tN+XxPQM1389CEOPR6EILIIVa/VQE+wjucID6n9ftnehtyCqi07K7eJZ3ePVcYVjhbi0Vx6/IfhAjz30RQSAx5akxg8Pw8wGXtUoOypfvtnmG9lpTuZfuTUF4HoqXgL4+VkltG34MNaoLKzNS45oNMgELIrZ+xf7kY8ThkGaC1qY+LzQ5GWuoX0ZB/N3uCGgmD5rj9km9brH6Bg++HGWGUZLAx9wANYrzLIwPwCa3urn4LC5+XvGORMXjj6l1JSB24gLe6wFAcYfxsUmAt8p5K4m2VwguNxGdzlQYlYIKh+Xh/e+Yof9QY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONa+88zL6xFsXUqPzDf2TNrNPIStO6HBH2dn3e3a74w=;
 b=bY8u1/tVu72S6whbleVvni/yL0T9o03DdGLGNnjCQN+mI+n7vU1vGMOydmBHOYjR338QK4idJiZyM7MleRhzu5+Kfnhe4Wkf2CgLPCIvI+IXthP5xvdBPgj4MeSvf5LUSXE5X+4d18pnw47K4CeCCpJLAMDSkNAf+X86R/N8d5Oj93bwMHohMifGsBP3fbzDl0L6pCoT83pDIyhX6fd0ST7fUI/Neq14oSpJYO8kxh1mLuE7O69G7TWgA67rdZqRFzWmpWsiSn9GyjhSiLtwx5/4DY4bO6JD7hrtgWAKjdYpAn/6ZJ7pjWF5eliyVfd7EvM/PB3XIpuERMoFmouRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONa+88zL6xFsXUqPzDf2TNrNPIStO6HBH2dn3e3a74w=;
 b=XkXwC8PMNv6O4qMTGH6szY2OyeV1GEypciTvKo0TPGGEhtbC25yB3HurYDXH5J+PJIgbNCx31jkgtxJZwB+NVPM1hys/H1SrQIFIcRlDimy8A4FRQWEiW138G2R69+DbiEbTe1vneASHb0qktLnoiOCth/n2glyJDh4zrHC0C777XoUNj4jywCTs1bno7k7Mag9+LmX4oUBaIo5+VPwgkscVhaS3beuH2O/bL9bLAGCvzCcrnr9twrP6PTofdW30jWdbfvOTOPE47IAofClZYYcvOFFiN1jla5GblljsboFEMctv7GzEPJNzmODIV2QuMrcGAUsb+jFkabzdLJixKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:01:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:01:53 +0000
Date: Wed, 7 Aug 2024 10:01:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
Message-ID: <ZrN+SM0LOY0yQxBl@lizhi-Precision-Tower-5810>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807082918.2558282-1-csokas.bence@prolan.hu>
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 817d1aef-0a0c-4b44-12ad-08dcb6e97d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TPqbn7AR7wQfyv7jlxJdurjpjFAka3WebIQK+YAJRYiILlO4lF7JlhDkVr?=
 =?iso-8859-1?Q?wMpG5OCOGDXTWxDy+2jqUZWkLx2W9+/Ercf9qAzKMEUzNBe+gnd5E+xevd?=
 =?iso-8859-1?Q?f8GDySoPBOnn/H9+3SAOPDfSmF6PNH1wKWjHNUUgNqrex7j2/1eveqmu4J?=
 =?iso-8859-1?Q?q5XrhHduU6633ZiZ6dxsUnpYWgtP819CalTIxpbHFqP9zDorXOLdhogOFv?=
 =?iso-8859-1?Q?dTVGW8oBe2f7L6nas9OBN8LxEbBTle3LYQvDQvZQFRrTlTD6oIHamZLFSr?=
 =?iso-8859-1?Q?tuDyKtQWR0MHUhljj0tj2O4wbdhIsKd22sv/c5RQV6YA0uU3IrjZm8KWD9?=
 =?iso-8859-1?Q?FrB808SkIY0/akyXTsw2bzPCYFsjZnmtBSMva3w+4Mx7DEUfxB6+HToolh?=
 =?iso-8859-1?Q?yIfAHf75VR/ld4EFWdzoSJaj6h8uvuK7xK8FEf6xpw2h7a7UeD/l8aF0cs?=
 =?iso-8859-1?Q?Ze/W920F4RoTyILY3/0kt1lybLuYNOHPjQcI86smlH8IQaf++F+pJFCNJY?=
 =?iso-8859-1?Q?aDdeZxfuHnMUCf2PN/xODnpdHc/LOTTjAoaJvYTH+w/jpFo75pKfrdBzCE?=
 =?iso-8859-1?Q?lbmfrr5Ad+DOl8PgSdT4KJxUViZgjagGgqVskxQihslFtJnKyZcyN2uTlU?=
 =?iso-8859-1?Q?uriK12rYL2k6rLn7Px1dxEQVc3uAjyEMI0Q+TdV8bkdfg3g9PSFO99JV2Y?=
 =?iso-8859-1?Q?eiSFlHrV2tSXEUd/+IgTTIS4lZ5fbyP4cQ35h/iw2QLTf9zdy994XizMkE?=
 =?iso-8859-1?Q?SfAxMSsN5iy5k2RK84CY8KEGfQk9BgeNk2IHwFR15Va2LN9VzHWUoEJwld?=
 =?iso-8859-1?Q?5pgRlnrq9kEv+1vgAT/Qy5g61vg5eHmWUqDwbmMWL58FBItOZ3QzAI5p4j?=
 =?iso-8859-1?Q?inF5dL5+KineOHyHPx/z0s1z5AIUZy2emkyV2BvD5zLExYUoeC/Ta2KF7i?=
 =?iso-8859-1?Q?21ejJ22yIupqSVcp9gf3OYO0TRLu1dr+4qkpsvRC1RreUxAOlNaOzu3bqs?=
 =?iso-8859-1?Q?GsvfiogpDk23V3TmFcAYn/ZqmXXW9PO641Pt1qLafESo9L+D1P0TPT5Alv?=
 =?iso-8859-1?Q?OR8tS8RJAnp1hfYElOMjpSWd662TrQkh5r6/QAp1/AHClw3Px6MkvdsErh?=
 =?iso-8859-1?Q?jpAJy5c/cZaIyUf69ieMx7xu5/a2+J02lFQ/CX1CySC4DLa1UUQ6Hl7kfm?=
 =?iso-8859-1?Q?zZV5p29Y3nLWYeePbmd9qO88eiSNM+5QzMUJs2o93GkoYpHMX1RHNZgz1K?=
 =?iso-8859-1?Q?xgRbj6NHqnyJqd75pTudBs6JFRmCvRVbMlGP00codTcXldbNs7Wxmr5+01?=
 =?iso-8859-1?Q?K88NGxxcXYTw4WPyUqduYPlrpQ9L/oncAcLgkT2zXZ4rcWFZhP1R5M0m9R?=
 =?iso-8859-1?Q?kdp22w/gomMIRvjOtA4fKssdbsfL8aVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?MrQCPn71b+Vt5/4HGkPEFpalxvwB+vQOuRabkVyWNAEsv+YL1WD4r7Unmw?=
 =?iso-8859-1?Q?j6GHSNHwVfYz2Kn1WPxh5jrE9v7ndaabeHeY9gmbFpD3n/M81JA3CtONxl?=
 =?iso-8859-1?Q?benT2aTkPJtSqvTGYrb3bp3/XwAPo3hG8+0IUx1BOeUr/kIkc8bFoL9ScT?=
 =?iso-8859-1?Q?zybO/OPqk/qrhPmLMTsDPJBHIxODquTO0WoU+X++bBFjonuBVwDDpwsksG?=
 =?iso-8859-1?Q?fYpHl7sEPp85cwuMEBRtuKjTUYtFS/iKMM6wZB2LXTAXbyuHYc0MKvNqCX?=
 =?iso-8859-1?Q?62FiirIZyqf3KzVjH8+wfrOGlg1nkNDfh704FCSN/oor527vye3rAFDXPO?=
 =?iso-8859-1?Q?sj9Wyr4enyN32LVrU7+JuF5OSgD9wVRcxdLLLrtz6aOVBIsOlEOFMBLmu4?=
 =?iso-8859-1?Q?HOfXB5zKf1ODhMecjAX5HfVLvNgCjZW/VlxC7QKdwT1MFPYbjB6ms+pRSu?=
 =?iso-8859-1?Q?mJ1vi/ruyujID8WOUVtN3OgCQpqJibFnTauQbewspBIS4Bolwnnvh0Qbpm?=
 =?iso-8859-1?Q?7PpZ+J60V6guky2mtZEt6lkY5jHxPsvTi5TSLmWPrq8AJWDYumv7qq/1Gs?=
 =?iso-8859-1?Q?Tw0/g4TG6vbkW51wviVuUOcKfIUSqSD7iktBsU1RNCSbIAwPan8DCZbhxJ?=
 =?iso-8859-1?Q?E7t9jGL4HjPEKlQOwwPOOYj1Y9R+ze3MHdoEPWBRkuXys0bOy7lbJzpduF?=
 =?iso-8859-1?Q?aVHNZWNxSmvzZMHKSmloP+9gYuv5ciRiP+Riegecrig4AtbX6i2bih93gw?=
 =?iso-8859-1?Q?kc9sjWU8x4hEJav1zBb0DIF+LaFSKjrU3SbJolIegthdOgxUIv4D1oVa/O?=
 =?iso-8859-1?Q?TfRiPzEz+luqkbg/kHO9k2FrXLeaocjOFfCRCGq6xTUg0SHB5l2nj2jqW+?=
 =?iso-8859-1?Q?iZ1+i/CVd/5sgvmYphTzu1onq3hHOm+Lxh0i4Wn6suAnUo3I56OCaggwNr?=
 =?iso-8859-1?Q?7eqUSja4a2JXAIa5g7gRYjalyCouyJmoIXmSQJwDhtY58BHdTPv0Ak4A0X?=
 =?iso-8859-1?Q?St/b+ib0LxiOfxSCd/McUyQ74UISHe9zfGZ3DlWWYspmwD3uAn33T6v94O?=
 =?iso-8859-1?Q?IUPSBIdV/qZBH7J1XDI+nzS7cCdIE+Z+mpcP98oZ131EvEDWp6M8DQs4rk?=
 =?iso-8859-1?Q?kbT3BGfDWqbqw7luDT2r5cQ2DGTEEvPApntr+vATi24WckZIhAgjS4t+4H?=
 =?iso-8859-1?Q?73AFRFcNA7IUcbQ1uOJft/bHEkILSSUDhnPaXWa7lXD+KouVhJpOJwWfN+?=
 =?iso-8859-1?Q?h5XdAEmwyQbffybdL3hl9oRPgyk7+qKTFFWWZW6O2aOh7V1+JgidPAFCv2?=
 =?iso-8859-1?Q?ftFFt7GeAP+qx8/H2nT/N7u0BknpqOSPqOQTD1w1mTBfUr0t6cAY6W6PuG?=
 =?iso-8859-1?Q?DqCWzx7jiPv7u9cXcwnfdaVmQjkXSciwvvWu19nBYALG2N59+rfKzO1TJV?=
 =?iso-8859-1?Q?At9I4UsJIEpQMURfbkgohrMn56vtt6vhGolqLhl8XB9clDA/Fd89tWwZoH?=
 =?iso-8859-1?Q?QVusQWpSfMLy0CRurJu1EIsTPMLgg9eRT8tpjdL7Vxakv8MU22U6hAtS7C?=
 =?iso-8859-1?Q?ns70TLMTukmFDiGpeQIxN/JLf4AWaQPJJVKMwbrCgRYR6F6GFDvESjjuoT?=
 =?iso-8859-1?Q?adTqxj6xkZpQzaO2ucsCBQydgUiAUn2cj1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d1aef-0a0c-4b44-12ad-08dcb6e97d77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:01:52.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7DEbFmli3WDvD/HVgJ3Y/FpFqDJE/+i0IXJGpE1kuV/dUGuMQqMwcC313eS9vnohuWYIKSwJQ4TVITw4qnSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
> This function is used in `fec_ptp_enable_pps()` through
> struct cyclecounter read(). Forward declarations make
> it clearer, what's happening.
>
> Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
> Suggested-by: Frank Li <Frank.li@nxp.com>
> Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index e32f6724f568..fdbf61069a05 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -90,6 +90,8 @@
>  #define FEC_PTP_MAX_NSEC_PERIOD		4000000000ULL
>  #define FEC_PTP_MAX_NSEC_COUNTER	0x80000000ULL
>
> +static u64 fec_ptp_read(const struct cyclecounter *cc);
> +
>  /**
>   * fec_ptp_enable_pps
>   * @fep: the fec_enet_private structure handle
> @@ -136,7 +138,7 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
>  		 * NSEC_PER_SEC - ts.tv_nsec. Add the remaining nanoseconds
>  		 * to current timer would be next second.
>  		 */
> -		tempval = fep->cc.read(&fep->cc);
> +		tempval = fec_ptp_read(&fep->cc);
>  		/* Convert the ptp local counter to 1588 timestamp */
>  		ns = timecounter_cyc2time(&fep->tc, tempval);
>  		ts = ns_to_timespec64(ns);
> --
> 2.34.1
>
>

