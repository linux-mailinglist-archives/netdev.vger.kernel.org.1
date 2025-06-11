Return-Path: <netdev+bounces-196409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFDAD498C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 05:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D37A17A19C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA4618DB2B;
	Wed, 11 Jun 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IbOveIV0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2079.outbound.protection.outlook.com [40.92.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734F13AA53
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613419; cv=fail; b=ru0S/IZrZtL4vd8xb1VrNNEOg4w27Uhil7gLNmxNsuMfBT3RoYCvpplTzKraioBhjII2bgsDpHr/+0rlPFSmHhZ3LTMIlxDepDh7U1MgOElFTUz1x+NY7YueRP557bMTXuz8dRW/05QZw6zsc0nP3Z3MwJMlFuGZXYWFnSOChnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613419; c=relaxed/simple;
	bh=RIs9s7Yg3YE45TeLOXOoBjkPlshamVq7MFswLEXBugM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOPKfb97JS4FoT49m4g2mMpEaKcyPVlTeZq8LWSpi3rLHtBWvcJkqSzBPtKpMVlsoL1vPbexfa5xHQtaqvPfQh1uNfku5qRHD2qpK9ayEYLJoC4H1Y+NxNbeq+LlYfoBgAj14D96GXVC8lyDCB/IeTKxYEgJWNcrayTkMIa4zj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IbOveIV0; arc=fail smtp.client-ip=40.92.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv9/D8LxygmInZtQvvo6Eq3+lNiLcvgJbGhyf/nD1XPcSB14fkYOT+zAisNzCJIKRe00EUbfh09L1HF0280J1mk/tNBax+6/gwBpZ/dsC/xuCpklcCs/YNmGrSHU0LviyR2aQbEz+q5XOZGwqOYlv/X3Y3Vq8Aq/JVUhE3ULEByIpCqm/KkKURK+AgK8MfuEjvgSf1abeh5Flf89Ef4G73HyDYWslslJl1NtCkxVngAKhZqdm440E7EXd77/n9nt4DOmKxEq4tjwcWhWA0jzNmJ/hRGqHHbkSfEHE3x92KQFBAt9KWPeGPAq2D88Ji7KJGrxq8IPPW4dI0OjcsiIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c89AcKExllhOqhHOAoBsZHFVpqgR8VybtJjZbR+dHFY=;
 b=nMd9Mtjv21WEtT03bnGgksHCudzUZiXBYn2hNi2IyGw0QkgQRAnDW6vCAQ3i2dhWUOZ8n7bbsVEvcYBwmpMU9Au61F/JfWhHc8T7KTWAUsvKXse0rAiEgz31iCFWOPlxtwC4glvKJ0bocppGa3en/zUskYti6No/t0FXySLawjdsj9gOUt6MreE0bZnti5uFhQDk1v9Od9AcWNtK2mUbpeBESHVAuqq83R1jQrlV0WkToZEmw0LOV5dcEUkTRR6ZcuVM0RnMBef5waZy5G+cmIujdmLAqBoLOCmxUAAmzhqkWbeixzzugvD/dJ3Dzk7DMT9TgmRshI1bxDIexElTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c89AcKExllhOqhHOAoBsZHFVpqgR8VybtJjZbR+dHFY=;
 b=IbOveIV0kAYBG8HD4qSoBCJBOIABgIke3zt9fm4QV7Q+S2LieEs/ukDRHjyv/685WEQnqbZssa5SSbpABrgvtjb714OuiT8vbOeqHYcnd6H1qM97fY3jrAXMqq6nL6EAg7faQRuNXKoV+lzv5xT3GUHH1psEyv6WbMBbob25ux9Yme6hro0EodlK5622lfsbj+Rc5/iQzRONdoj0Y0VfrX+xDeLGzKFbCeZCurdhRjJ6bCvlZVrz456wkbFkrpi+ISwA5rURPgTyxPQ8eCHX+Enu8cXz1xqmKcNBaeTlJuYyHs8ybo9FWeD2nQZP7ldv/G1Fhn9smplbZiZYJ8huXQ==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by DS1PR19MB8678.namprd19.prod.outlook.com (2603:10b6:8:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.17; Wed, 11 Jun
 2025 03:43:35 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8835.013; Wed, 11 Jun 2025
 03:43:34 +0000
Date: Tue, 10 Jun 2025 22:43:31 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID:
 <SN6PR1901MB4654B995FBAFAC7298C7C6A3A575A@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
 <SN6PR1901MB46545250D870E79670E43E06A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENv5BI2Amtqui4v@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aENv5BI2Amtqui4v@shell.armlinux.org.uk>
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aEj7Y7_ZEPUMSjSs@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|DS1PR19MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 43652553-a0e8-45d2-c7b5-08dda89a23f3
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReHvskRdeqBVeL7aliE8C5/Qe47NFQWxtPw0DlLvDLCxE7PmpN/zz2MFylZLpFWCzPqRKOWIfF39/hEnhSaCLIqqizPI2m1PqFPIuVvnuuF8u/s7bvrIWauU8LJlleiybWs4xVGvTi08oVCzr2PjnBOdqNjorL0LTDe700k4NZ8085g+G/EoJv+YDmTW7mDyWhd+p/2ReSOcotnY384klZAxJOiyE4bRdUZT8cL5GNf4qy4pRKcd0UtN3O2itkpVnp2o/AbmfaXDwnrji/dFvvQ9AlVMuoM9T3SgzMqOIlIMoOUVy2rzZf5wT0VufGuTlBXs2tGWGFfO30RCWh8XUfkcHCdDD8mrvt6NVTU6toAeWFvOHMifnjQdjxxpJp+JhI5ptwwxDk3sGy94O/Phvus9PRgLckn1+xbXprciMlxfMKJJOlYW4lw0OIy9Wr1v1+VgnlNJrbtiHU5ZRAiGNFuBn8cks3GONC2CHvbVhb478AoE+Ns5vF+NbEhdLg6WqjE6AMGSeb80qOh9HCHxd7CiQWDjZXE/XKlji/kLako6fYEuP3dTGhAHJhh1paxr6rlPmLPLR2iUy/x7PS+r/HHO2LV6UjDoFSr8SO/KqVYdUWgfsQ4wtgD7iI+ZXE3YA+CEY39O3yOXLJgh+ionN4wc7H7uSGwJ1CHRw+BMuqgBh8W9Ph7dWaal3jGVR03/9HBojA65kLQV3ugmG5qSlI/+k9r1/UOMfKMlEbvIfVMmz/jBUEcBlfaSyWicCrMyEKmUSNKDdHLS9d0PKju2beeK5ZPuqRo1OUZ7Y4nY0xmYmQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|8060799009|7092599006|19110799006|41001999006|461199028|15080799009|440099028|4302099013|3412199025|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?prORo1lJ5tcHdy4HSQps3m0MwbbegIMp95EjDS4w/Yo8R2Qe9RVxtFpM+vgb?=
 =?us-ascii?Q?vSDh3bbyso2KsjFm8/hyG/r5rNOpJtmR9AtMvK5GoKBiKm6rryEEJrFnlJFu?=
 =?us-ascii?Q?zotFzm5CBt1gG37nq863jLl5axZuW27Kj9N5AH8BTMzW4u5oNOTQsuLgf43P?=
 =?us-ascii?Q?KFbiTGu6fnK76JLtYv44mOE/fcHaLPGO9KkMDvYb0d/W591h2v7u51DX/1Yl?=
 =?us-ascii?Q?vFckmwy3pbtOJvzhG8L9c5KzhJvqcfjT5nxPC6lBMJL82jdhq8KB2g/EutLS?=
 =?us-ascii?Q?QT2PqnYzShBocR2e/RlGxMO/8YwrL43ysg3GZREfQE8LfNAl0gW5nvcVKe1Q?=
 =?us-ascii?Q?hCKvowDMpRjFkhrrg8hWHwCpD90FhBtECPWmHMK5reSCmGX69+ROI4z7D/zh?=
 =?us-ascii?Q?7AQtJKYZISScGGVCDLNX7v6fbyR6mCrET/M0ePFvXruZ1t6EcQesQKu4N+ia?=
 =?us-ascii?Q?z7vn+iglblWGCOPgYuVMOxGK9jJwVPPpUDC0sNuGjV7E8021QyWjfsqGKPA6?=
 =?us-ascii?Q?m24OrbSJHnMPpeSUKwmZuHZUXeIrCLzUlkCAUGITwFWPS3xK8if7tkWgvplz?=
 =?us-ascii?Q?iFMdH8bB26vh7OMmHuD/ZGQrrBaFDJ/AXdDzusrIzhme10GzMbCNV/TE5n02?=
 =?us-ascii?Q?2gNIqywzW2C5/RX1lDVAmW3wL04cJ8jybMzlc3MXT0FSHHPTsj121gT6NyHo?=
 =?us-ascii?Q?z1+hAOlW/D0SpeZ2nAbAZt8jumuPx8iv1w3xZKDfLuaQDUiNdVgAm/eUth+c?=
 =?us-ascii?Q?/yOkno7EfTcyLTwqfok5nkcKKS1KJaAGEmjC1ooOqpc9Eb1yYW57zth3PC1t?=
 =?us-ascii?Q?qTzPNUFK6pffQFIA/lF81uFjS+nPGnRSciFuP0z4Cdf5ejH/Eb5gWxoLyCuB?=
 =?us-ascii?Q?GtRwMotBcoU5O2Ci8lwby+xyUdbVsuYw+SFhd8sGNxqQOo1TltjsYbOtFVCL?=
 =?us-ascii?Q?REZ71+OU65u+QbSLxWgKTa7Ovc/O1el9CsUrQWpKigGUuLElCicvz9bxw5PK?=
 =?us-ascii?Q?dwoFfof4iSoJ4XZC2y9+vx/0/7qBIeK1pF6ZIWPnPZO8AMNG1SitrZfuGOf+?=
 =?us-ascii?Q?RIgihp2q310bh+mKBqiPbvTda6dXdLUULtQHII3yDP0ApapZp7EpnjPzS4ez?=
 =?us-ascii?Q?NwbcB/AQOyOhu+TIridt+OU3Irx0d9eoVUCfQsUTjb+yEWSO3m2g5WlI+ktg?=
 =?us-ascii?Q?0IykIU4k2pTNFQrxV1Mzreic97ftpIQ5u57JyK79WrmE363YmLit/bdVoptk?=
 =?us-ascii?Q?rUusAvDCq4PHtd54Fe5v0ALld9dzinnXBrEDHDDkZQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W7y3FVdC5GXLp7Wtdo1U3XaQKycr67PXlEvi1irdwnkCigLX6NqzLQzlSQ2p?=
 =?us-ascii?Q?kvUNAEvkCH9M+7UAe4wclYyUaF5mpv/slTvE7d472AWSHi5EnfJ4JPsV4+4T?=
 =?us-ascii?Q?RHp5AZ2pKly6S2MbiIFUM61SZljVslivGDZenFboBycQnm6NwWf7AardA68c?=
 =?us-ascii?Q?i0OYvjf2a9yj6i+9NeQ98/tHv5qPxuchoTKcdXuwR2flAaansFsDdR4slBlv?=
 =?us-ascii?Q?PsaVuFavEc8VjbbR54FfAs4PrNYeIHanwVBY/OvIcppxl0tYSxsH8NekN3jO?=
 =?us-ascii?Q?3VwRGy8cbFn4ZqzmqxXWFZkDIQ+1trU/0sSgRNmfrDD+Ak2WMgJo9eA1vMG8?=
 =?us-ascii?Q?sW9UjJuTlflckpfbQuTL/rOMHCSQjEQJCYzMCTjnGruVVE25d2irKO5IU7lq?=
 =?us-ascii?Q?0EJTScCn15Q3zjOPkDlMwgY6R5R7jULY6VkarLzSG1qgbqKmL0L6+bNlOJj7?=
 =?us-ascii?Q?L04X//gQDhljDegLWci2BHKVz6JZMAF5NQR3R4DoDACSXceSMiu33u9mrjqw?=
 =?us-ascii?Q?nvXDcdjhRR6a080B+f6G3llTgTCmPT1XwOrcKKzmL4E+NYuSh1EaC4QwHcDa?=
 =?us-ascii?Q?VqW21x/hSDdS6qMQl07BBvOYhbB2cjRV1qpszdLBTJCaFbN8LrezgMuxgsu2?=
 =?us-ascii?Q?3fcJbbVQVjZBV+5sZCE28eo8nTHHbQWM30AcE0N8TT3XmfFK+V+YJP3k/gID?=
 =?us-ascii?Q?QF5AOeohUiurYKd82mjHcpM1YSNiVs5i6d3UdA3bh+B2j2i3iHnId+ZG5v+M?=
 =?us-ascii?Q?BZ8FvfIDskoCFi4+CWfNQ4HZ85Yl156SUti8tM7Zibm3JVc8Xx3TAPxbJD1m?=
 =?us-ascii?Q?6SjiyTCk/Cob654f6D941ePGW5jzJ/vQ77aHf4ZQx2qKwSaflBjhEnkZn6r/?=
 =?us-ascii?Q?rlBmZjpfUUcJRu4G7sBPacErvpHVEXYFZDlhIkeaYq5GnM541DIp9XYi0xHy?=
 =?us-ascii?Q?5QrEG28aMp/CdjQMnCq49crEuE49K+YzkKrGcZreRLGzk6v48VrS1l9ud6jx?=
 =?us-ascii?Q?mYBrHmDMqx8H0nd9xh9EKDFUF01gCP/0OdLLmrqqhD4hHI/lWkekA0IzbV++?=
 =?us-ascii?Q?8E7ecZcXYm6YGKeoFFAB1t/QVK3gB+lJoB8ipEIRPBx/aTgvZvqfbPGlqLUy?=
 =?us-ascii?Q?sxsL9hHu1DvDDSaqkLohRenresJciJAADOZw1VBq/+2y+q1dsilLgKisAcs8?=
 =?us-ascii?Q?MvT9QgBMfQS4ZlZ7/ihb1T0nSFOTzHsF6kLsBH2qSdhwddHmwEbIIn8eot8O?=
 =?us-ascii?Q?aceqJsOTVZiqUacMwg/dWnpUyFKusY5XX+U+d6XGxS72AMKNsQzusgCL4DN5?=
 =?us-ascii?Q?n+zsfPBYkDcGe81YGReE18zl?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 43652553-a0e8-45d2-c7b5-08dda89a23f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 03:43:34.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8678

On Fri, Jun 06, 2025 at 11:47:00PM +0100, Russell King (Oracle) wrote:
> On Fri, Jun 06, 2025 at 05:32:43PM -0500, Chris Morgan wrote:
> > On Fri, Jun 06, 2025 at 10:21:37PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Jun 06, 2025 at 01:54:27PM -0500, Chris Morgan wrote:
> > > > 	Option values					: 0x00 0x00
> > > 
> > > This suggests that LOS is not supported, nor any of the other hardware
> > > signals. However, because early revisions of the SFP MSA didn't have
> > > an option byte, and thus was zero, but did have the hardware signals,
> > > we can't simply take this to mean the signals aren't implemented,
> > > except for RX_LOS.
> > > 
> > > > I'll send the bin dump in another message (privately). Since the OUI
> > > > is 00:00:00 and the serial number appears to be a datestamp, I'm not
> > > > seeing anything on here that's sensitive.
> > > 
> > > I have augmented tools which can parse the binary dump, so I get a
> > > bit more decode:
> > > 
> > >         Enhanced Options                          : soft TX_DISABLE
> > >         Enhanced Options                          : soft TX_FAULT
> > >         Enhanced Options                          : soft RX_LOS
> > > 
> > > So, this tells sfp.c that the status bits in the diagnostics address
> > > offset 110 (SFP_STATUS) are supported.
> > > 
> > > Digging into your binary dump, SFP_STATUS has the value 0x02, which
> > > indicates RX_LOS is set (signal lost), but TX_FAULT is clear (no
> > > transmit fault.)
> > > 
> > > I'm guessing the SFP didn't have link at the time you took this
> > > dump given that SFP_STATUS indicates RX_LOS was set?
> > > 
> > 
> > That is correct.
> 
> Are you able to confirm that SFP_STATUS RX_LOS clears when the
> module has link?

I believe this is the case. I've sent you a dump of my EEPROM when the
SFP+ is active (it's now powering my internet connection at home) in a
private message to confirm.

> 
> > > Now, the problem with clearing bits in ->state_hw_mask is that
> > > leads the SFP code to think "this hardware signal isn't implemented,
> > > so I'll use the software specified signal instead where the module
> > > indicates support via the enhanced options."
> > > 
> > > Setting bits in ->state_ignore_mask means that *both* the hardware
> > > and software signals will be ignored, and if RX_LOS is ignored,
> > > then the "Options" word needs to be updated to ensure that neither
> > > inverted or normal LOS is reported there to avoid the state machines
> > > waiting indefinitely for LOS to change. That is handled by
> > > sfp_fixup_ignore_los().
> > > 
> > > If the soft bits in SFP_STATUS is reliable, then clearing the
> > > appropriate flags in ->state_hw_mask for the hardware signals is
> > > fine.
> > 
> > I'll test this out more and resubmit once I confirm that simply setting
> > state_hw_mask (which means we don't do it in hardware) works just the
> > same on my device as state_ignore_mask. So if I understand correctly
> > that means we're doing the following:
> > 
> > sfp_fixup_long_startup(sfp);
> > sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
> > 
> > The long startup solves for the problem that the SFP+ device has to
> > boot up; and the state_hw_mask solves for the TX and LOS hardware
> > pins being used for UART but software TX fault and LOS still working.
> 
> I'd prefer to have an additional couple of functions:
> 
> sfp_fixup_ignore_hw_tx_fault()
> sfp_fixup_ignore_hw_los()
> 
> or possibly:
> 
> sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
> 

Which of these would you prefer? Do you want a function for each
scenario or just a generic sfp_fixup_ignore_hw_fault_signal()? I can 
create functions for each and then apply them to my device (and
probably update the sfp_fixup_halny_gsfp() too since it's identical to
what I'm trying to do plus the delay bits).

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thank you,
Chris

