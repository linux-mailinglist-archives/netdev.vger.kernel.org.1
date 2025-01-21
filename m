Return-Path: <netdev+bounces-160086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C46DA1811D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B888162F3C
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCD1F4285;
	Tue, 21 Jan 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cODrCezl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2038.outbound.protection.outlook.com [40.92.90.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85623A9;
	Tue, 21 Jan 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473269; cv=fail; b=Rn9iQSrsadN0ch8caOLy1o0wpyYlPWAj0E/dKxhWClK3rMy8V49gDNibZsFp4tUdTCT4WS5ni7GE/WHOoruSRM4DPZQsh2izThRdMZBEEA1U3ZxC5JMoMnaNRE5ErBU52EOjz5Nsg3kMZwx+nQVi7QOjG07pDekqGnLZIuWU25o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473269; c=relaxed/simple;
	bh=12ABy1Q0GBhvv46/giwfWhOJF5x54Uq8y1sbnmnNj+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VDafoWmTXRVRxBxx5oniJVjF+EFmnhfEdwb/CNT5+WmIkIJdZ2TMRqjnjNR5PqrXWrps4t/3EwxGRZtF6R3hl5xM4U8y539E8106R5B3DA6ASRBqCedtWZCeayJSuf86pFIroHmyfpcMIlcNx3kcSYGFRWVBP/3ygh7Lm1dioEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cODrCezl; arc=fail smtp.client-ip=40.92.90.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYsAWHIydXdjg2cCEx7P0T/LeW9DbUOPErAa4DOVP9bgDLp/ij+B5PKlLq4NAeBn8ZhUCh+1PzpKybyb1/W51JmGFPfqo2MMOImPuaFSbCymWG4/9KpKJV4erlcrnt+nmgS/l4HaKhLBu4m9UEoDHh2YtYPSS4Ma/zUOioO+t8lg2y8tNKiIdtMhwo4L9zQfziy/kbIFSU0lpHzgxaFvtBP6Akccp+CgpbgtpHD/h5AhdzUo4oM6w4bRLtmYTCO85AHs/ovVQh/TQcgAMbAqzTxZNpKMKq/D+/PFdgylCtaHo/xZssKCiDfPjcVUzDdzBekYVDRFJIpk4AtsRaCSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZzdduWMd+yVv9W5lVnnkF0TAUctiGLOUX1X724kUwQ=;
 b=EL0gFoCQ9p0QPkiAlxzgCVpQuZfIGdkklPjdQgLzMEKGWzoOz+qG59jg9RJGtNd7Yb+PqA5kDfp6nObMbOb8eMrZLvhClHUCu3qh340RvsbvufdjWhRwsBDVirpcl+vB/8TGMJGrRWmMCmwbsAyaTZ5FUjWpp4jcstMliBLxMf5MoUtb8QxwT3bN6DGH6tWeiAPsr3Ys0kywHLez07UfuAZIbpGdzNarCTxpMgeNxYiyqBXHqS9nS01HDSAYo0spKXTdwy13XGxc0TKpqGzeYqnT0Cksg/pFJqk6F4eyHKubsyedpSNq3vBlYLKudOifWiSEIjy8HYHa2Z3QYckHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZzdduWMd+yVv9W5lVnnkF0TAUctiGLOUX1X724kUwQ=;
 b=cODrCezl7PtKkm30+nkDbUy1QHOdRXKRUK4drtJnHGVPKaVclbSYg0e50hNJKPlytZtddOxZ7qU8cdhPDwRWgFkU1IbtNTXQ7Ei6y/67xcG2bFdciFDWFvjoAM50O70/VHA61osGwj7iUHe6/KDYZvQNu7hW6Qt+begzvRBGnYs2oPeRP+YRPO+INkxyzpJkGmDTBqrkYbrisKcTlvT9VEnJ3reC1QKse8kK96oyDpoHrYpgBsTf7Vq/7/+P2E3+Hzy9l9clBiNoIEodTr3m2oE4yILvFXrT733dtP+rIJ70PLJYZDZ8mFwfSEsKN/3UiJGsqF95xbjY1KrUiIKBwA==
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36f::20)
 by DU2P250MB0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 15:27:44 +0000
Received: from AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046]) by AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 ([fe80::7f66:337:66ca:6046%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:27:44 +0000
Date: Tue, 21 Jan 2025 15:27:37 +0000
From: Milos Reljin <milos_reljin@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, andrei.botila@oss.nxp.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, milos.reljin@rt-rk.com
Subject: Re: [PATCH] net: phy: c45-tjaxx: add delay between MDIO write and
 read in soft_reset
Message-ID:
 <AM8P250MB012472082CA9B9C0C1A5F199E1E62@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
References: <AM8P250MB0124A0783965B48A29EFAE6AE11A2@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
 <20250120144756.60f0879f@kernel.org>
 <AM8P250MB01249EC410547230AB267A78E1E62@AM8P250MB0124.EURP250.PROD.OUTLOOK.COM>
 <0a81c696-5d4e-4e1a-a036-eee001b393b8@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a81c696-5d4e-4e1a-a036-eee001b393b8@lunn.ch>
X-ClientProxiedBy: VI1PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::21) To AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:36f::20)
X-Microsoft-Original-Message-ID: <Z4+86SuDygqc/22h@e9415978754d>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P250MB0124:EE_|DU2P250MB0027:EE_
X-MS-Office365-Filtering-Correlation-Id: db03125e-bd5d-4753-2db0-08dd3a30271f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37102599003|5072599009|15080799006|461199028|6090799003|8060799006|19110799003|440099028|3412199025|12071999003|21061999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+TC+Qi1U/17Hs8YUrgHzNf/2Mik32yE4SVygKRkCcsh6MFsFP0itcH8xLDt1?=
 =?us-ascii?Q?HQN3pHlF+qSY1+l7AN3vu8r3FDRkUSSKOHLl+SMUiNWXqxhVAdbirpGfmsVl?=
 =?us-ascii?Q?LsDvlRn6hO/yT/P60mtyubsmCQFrTNa1EK+9OLfhjvwSqdgHlSouCmN1qOmW?=
 =?us-ascii?Q?kDygJm5fkzGzLTWxuG9/BfBciRtPNl33WC4eJxmbDKFOM+W4XBh5NGZScLV2?=
 =?us-ascii?Q?xTBIKU/5fKDssQ/XIA+jCKNE4VMIJ2dmZLbkv5tJE2s5etavRUYKj7cymZZz?=
 =?us-ascii?Q?tBC8kzH7eQQpUavaRFI8Z7Af0EIhSGEZlqMcsDbYtrSOUjL2a76iTiSHANuZ?=
 =?us-ascii?Q?Gr0s4gQzxg+5x4oySe0++ZLzCXC5KGFeezuqne99o9GkdeVCEZCodCrn3tfm?=
 =?us-ascii?Q?miMYN3X86K1cM4ZeqZ04WrgKh6Fr89QWXtvurskU3MyxmP+YhGMfAF6gO1Vf?=
 =?us-ascii?Q?iowgpNNPgdzuqxRVfyJkf1Z0Q9y+mVwOlkixwansZnYRiatjcBt43+kNn0Tw?=
 =?us-ascii?Q?fWVv0nMNziBMzJuRwL7kqScWUcPEDp9SGrM2HpsELwHrcYqPHmiQpr/tTMR4?=
 =?us-ascii?Q?CId2eE1SvVYW02sLyymoUDG1FeaUxQvPQIyKSb2TmHfw+eatyUKJoTnBsowu?=
 =?us-ascii?Q?5kEZYGrHf0rbsHPF81vKSifaMXSTHrmDnVJbvxBTZCMZck1B67A+gqa4OU10?=
 =?us-ascii?Q?DfeT4kOhKdjn70EC59HaZt/jbqly8U9pbbMWWWZW266xSlZayFTuWSpmL3Hl?=
 =?us-ascii?Q?sLRNaSuCnrcKVcAw9TCPStHsFPXUZO+/QTl02Uxqbnf3Onb6X+CkQQ7rYnZC?=
 =?us-ascii?Q?MVbQfnwPr4AvmUeZL43xpKnQ3Gw8JJCxiGOVtKlurKtvu06L4eRoUlMEFDmt?=
 =?us-ascii?Q?XrjxL5QlqkVMylpuQ3n9swQ8kMmvbJfHL+bJut/r3+Wks1/kt7DGMgebcVzc?=
 =?us-ascii?Q?JOXmWtKfY2iV6oRexuZQ1ULTz7iBdV9bxzXBrdb/KxKgSqd/3CJ/mP9Q4wFn?=
 =?us-ascii?Q?rynQwW8swtB6sgR/jyaWXJX52QJHXXqk6KGHgFPaN40V5NMoDukAHCXQPMwC?=
 =?us-ascii?Q?e1uJNGCF/HZXiQTkMDEf5zUj6I91VXoKoixI8kpa7VwttHfsiH99U/VhOy5I?=
 =?us-ascii?Q?26fHO1cbJU0Lc+7HKRPeXAaLuTWi/R48pUPT3LCyhlL95IBfBNbTfCQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZwzYnQR2xTP9JKOEYgOsvbR3++Z1eXPAmHRAJoSIuZpl88/XQbJKU57dhv2?=
 =?us-ascii?Q?BIJR4w0rQA0jHY7nNbbLZ0Pq0tfY3Ty6S8WIXWbG8bsmzdwx39BYRLK2J6Z0?=
 =?us-ascii?Q?ujzNZK1Ym2nxrXL7QKvTY6MSdTrrh0kWVVC4+ap6Z3lHn1kFkZR/vxX/Uqjs?=
 =?us-ascii?Q?2FyGfb0Ov9deOQiGgeWd8AQ4FIGA/jE5Ck0JrQ0thRcHksvDZ6MVn01pLes0?=
 =?us-ascii?Q?aP11vY/RSAHzNFdu6c0D23IGJGQMN8ChK5vJOGgjDtXNARM+kP2/8of4w59M?=
 =?us-ascii?Q?bLGdvmOm0ALmvurOsk0V5ZmxhjdHrDkvBtlYI+YzqTrWjp0UiLrByvNYfptk?=
 =?us-ascii?Q?tuyCIcfFRJWAap+NBXe5+ftvoho/80pzP4eYYUHxqbyTn+PGYqsi8mgBBnZO?=
 =?us-ascii?Q?w/R+s6obBLbuClV1y0O1/It7WN/UX02ij8zt5LAcqb3ENccVE53+TGFww/uP?=
 =?us-ascii?Q?89hyTn0FdwCSJN37oTyaySy91BnsIRxIeBd6wPPrA+9G8hfmIYRw1gj7Po4y?=
 =?us-ascii?Q?Aa1D7peCBiH+MW3lhWTpmGRTlj6xPHzT8LA/Bh/GyQ03K8lTi5f1ZxT7LvM8?=
 =?us-ascii?Q?miDp9LGY/rAUUVtnulVa4PYgcKRJEX9m6jMl82Sq0VcjPKYIYeTh+eSUXl+X?=
 =?us-ascii?Q?PuoB5t1PO1dz+DZF+rgcMw1Cz9KKCrMxYKJf4qP1UnDoWwUDWNA35gZdtdRF?=
 =?us-ascii?Q?Y/qwHjgSdAtfxGDlim/PgrAKvRZ8Cmo6U2MiyiGkvCIlY+zS5jtxW0xOzV2E?=
 =?us-ascii?Q?rOnlWartI3YmLWHG74TCNFNOeerPD5IZ0ZY2RzwLScy4yBDXhQfpj6yTwUce?=
 =?us-ascii?Q?vaIXOc1FvN4y9TAZ6fjHXsCs9lVNqkIx/WdqB+e4ONekzTEvceyJ6w9y6i3Y?=
 =?us-ascii?Q?3oBnLkXPLx1YLHktBGxLyP6xEq1snknbZmCEvS2m+9N913RKw4r32J7KRx64?=
 =?us-ascii?Q?EXS6/9M+Pk5tTTHX7XGPpNu1h09+YTnz2dA14eiBbAeAvv8j/iuRV04UMuIG?=
 =?us-ascii?Q?PlvnX1ZjIdDTgi6Y1cKS91tcP/56ulloZAusQh5zy/484/0/Hq2jwaCMGA5l?=
 =?us-ascii?Q?vlvkY04yAisx9XkAD6lsi01twOfV8IJq1ECzYL27N8cgOwQPvC/mDsPrdWKX?=
 =?us-ascii?Q?d/WMHYV1WlEhq8tDG7ZJmdbznpRQUAoxGnw9brnw/T24r/XvcsG1z6/TId2U?=
 =?us-ascii?Q?7kg5YEX416z99egLfr/CXHQ7kWN4irDPIm1bpyJKFtnN+lVbgShrKSHybw9M?=
 =?us-ascii?Q?eDDRx4piAaUjfM8jkJ5u?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db03125e-bd5d-4753-2db0-08dd3a30271f
X-MS-Exchange-CrossTenant-AuthSource: AM8P250MB0124.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:27:44.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0027

On Tue, Jan 21, 2025 at 03:02:17PM +0100, Andrew Lunn wrote:
> > If you have access to TJA1120's application note (AN13663), page 30
> > contains info on startup timing.
> 
> You could summarise what the datasheet says in the commit message. It
> then becomes clear where you got the values from, making a good
> justification.
> 
> 	Andrew

Good suggestion, thanks. I'll add this in the next version of patch.

In datasheet there's a figure with average PHY startup timing values
with measurement uncertainty following software reset.
The time it takes for SMI to become operational after software reset
ranges roughly from 500 us to 1500 us.

In the next version of this patch, instead of setting the last parameter
of phy_read_mmd_poll_timeout (sleep_before_read) to true (which adds a
20000 us sleep and by datasheet is excessive), I can add:

usleep_range(2000, 2050);

before the line with phy_read_mmd_poll_timeout. I tested with 1000 us
and it was working, but to be sure, 2000 us should cover the worst case.

