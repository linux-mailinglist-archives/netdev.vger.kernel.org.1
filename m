Return-Path: <netdev+bounces-195497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF6AD0852
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9421891AA9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6AB1E8335;
	Fri,  6 Jun 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AZA+d5/g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2077.outbound.protection.outlook.com [40.92.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC0323D
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236079; cv=fail; b=XTiQKeXRxGUK9U7/A8m0+qZRKhBDWu1ySZxNLr5AWpA3EjXW196DAXHPyJegbGEIxDGTlsOzhaMY9S4oc7uifeHjSN2MBUIoCEVNvUwvFRvzC2wSDfauQBtkBRVzfu+SewNmqjBlJrT1xOyVmeLy7IWzw/bYR+ZxlpCt/cvYMDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236079; c=relaxed/simple;
	bh=KTdn1NsREHx77ZLnK3QmwfcmimZfJtWliF9GnfI8lsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkPmQIMHMcYHPpPty8BiWDJ8/scUA+HmgQ3uUQEvAVLNLUtO3dTUmpo2+6k5HspO6dVeMr+doSveBhuUSbhATE3EJxaAu7hzTYDGhlTcXk7uQna/OzfcfZfg9OrdXbtnEMyWmf1gvwebadi4BCNnE6KbK/7IOodKqGn7kwNH1Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AZA+d5/g; arc=fail smtp.client-ip=40.92.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd8R93ySU4ld8QIEYgy4R9wp0//GDid1guY4yx4UfdUZoAN8+/engY4DcHGynoybd8N4Mqc03L5V4OKgulJW/wGCseKMyMkzvrjWop6sTi83PnGX2mAB8fbvibkGYJEblKDNOPdLY4hRl5lRmiqNyzW7/kHLsbGXLLLD8RWJlsLgU/NLfNQQoTQGDsCyMm6y7cy4lxy8gTk4HSJWj+LKZdxVu4fcfOJqU4ASqobGms/wrUjBvwoHpXCZlB20MXFB3QhUXQQXbgC0gGJ0zAmbYxAdD0mk5NS9qeZC2McAOVROBXU75EsLVMOjKO37dx1KnH/hvf8003lxfsDLUpcEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7WK4mG25QPxrEiVZAlcIEt9i+pAQGcywUwx6YC0WKI=;
 b=Vmblh8dXIn1Dv7WIPHRuaLK1BKm4beVpMUNDAp1C/aVSKmC/X0I/3hOs7PZq3iT2zHX1CWYw0CpaYQWtkIxDboiOWt/6RoJcDqec3JBoWNNndsCStPRpCHWDiZjC+Zp9J45ksyvKrpvSDOPfkrJPNPawRUqiSWKdj/2boZEBcntbf8ElJPqzHnQDE/iL7OXmO/lhOL0XMzi5BRYH256Q6lgD30SS6k4kuvxbP006NRCfYtlfuUrOGRNS9hCPqr5SoZwsQErhoug1CSKc5EEryjTMHxHH4pp7UT7j+zJ2I+gaHxOByHrzWOeRmUV3lWJekeLrjAno6q9I/p5ChdiaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7WK4mG25QPxrEiVZAlcIEt9i+pAQGcywUwx6YC0WKI=;
 b=AZA+d5/grVKc0c5fFH50IaRD6oh+A7eAJJYLtWIeY93mlOlOZyeASge4gz4EvKu0xfntxr/+32EuhFr3s/kLQmAhxvWW2NBZty+PG7RM5NNPJ8qii/LVqF8AVp6kedVSy7mHXHxxFcszBkdMYzJSDN8jn1Sism0JAo+g+HkGlDAk1r58JVkC75wh53oVy9j1hkVhROeAqrfxSAkvFOmG+YdKnxxfD00JPyWr7GCqKvHB3k9bcDK/HHGeM+mkPbyeGJmV4L6Y2oldxAeMgC1jmJuNLAZ5lJ4CB5zbSM3J2H2n3pgIkVJKfoInwvaiD92HV08g46m5cIgjK8GfREwd3w==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by DS7PR19MB8964.namprd19.prod.outlook.com (2603:10b6:8:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 18:54:35 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 18:54:35 +0000
Date: Fri, 6 Jun 2025 13:54:27 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chris Morgan <macroalpha82@gmail.com>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID:
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
X-ClientProxiedBy: DM6PR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:5:174::36) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aEM5Yw-f-bXF1KPQ@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|DS7PR19MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0256eca1-dcc2-4848-0070-08dda52b93b4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|19110799006|15080799009|8060799009|7092599006|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76p13UWwpOyD6S7VVbqfigixd2L1aY0YRhceDis3qdNWYCf+hnWilXYYdVif?=
 =?us-ascii?Q?D80K4ydbThA770bcSvCQr5//91DdYjx7yd4yY8HfrJOfdBJknE2USaOX+Rvl?=
 =?us-ascii?Q?ih2nR7JBeD8eSQKSvnoFzhhYOvnhcsj4/86niwgw9ViPaIQlMfZxxJPxoaRz?=
 =?us-ascii?Q?6etTDgLnQU/YeEhiqC9p4pYUnqj0mdOY2Q7Zk6PFblb0KSZQkW/HaJNVM6tE?=
 =?us-ascii?Q?sApPvakjWkaYH/eDAJaXkRPxbGEpC7ivPL0S8wmSNtC31AauCUzJ6bjlAetF?=
 =?us-ascii?Q?Ngl5u4Avq/CuhTB+oC2kfUFEhlOMceyGLNzw2sQjMlfMMIXLytUWl9mXMWO1?=
 =?us-ascii?Q?6qh1Xd9RhLP4tZ1CoDXm27ATfgm3mKc3fws0sTRc395ZQN1CLu0gvtgp7AQY?=
 =?us-ascii?Q?pxOFGyMMzXen+qhl1Qrg+kwuOlORgkhOCeRbHQ7vEukOhfunIrMpS2kN8ZLF?=
 =?us-ascii?Q?ReEsUk/qOIVBtRYQP85lqaTifNBlC2Lu1ZU1FqY5lAoUVK3mLamsLt3lqEth?=
 =?us-ascii?Q?qXxepcC5xN62RM0Wo0s3dK0EsXJrl5s9WuIVswhvaar0MS9EMQek80sn4FwC?=
 =?us-ascii?Q?gxH/3StTgNxBImhkyrop/PGnaLS5nTTGYnW5ksb7C7QHSB62Te4LkGx4FqCj?=
 =?us-ascii?Q?sRsQQn5sizdD7f79m7dmFdKsa4E4usMd3aHlwrtzSWk2nL9U7EoTCQVmMX49?=
 =?us-ascii?Q?42Ubh+lj64KNGkyhOsVfwVnII5OPmkxBNhIww1zWj7Pe1FIJg0U8cB2TwvcZ?=
 =?us-ascii?Q?NmXzxT6PiAPvZXusiOAp9wFYgIgCXNTc8yyxELEK7vqqGTxJ90ckyoW+gj1m?=
 =?us-ascii?Q?2qJrXmbkuLCOPLiFswjV1fQvB8vBcL+hvcL1mZUPKoU0AWzkBuPbahB/ewXd?=
 =?us-ascii?Q?LjuehZWTGnMF7OvQYNtUvpeaTdsDEMej25bsqSXFcZ+S4bvN2QJujp3a0QBi?=
 =?us-ascii?Q?MR9YnwfeXA+v/+oG1+iXjCAR87VC+/aWTGkLaUJm5I/XoluIgb2Q29narsf9?=
 =?us-ascii?Q?7fScHrKSgmCpFR7C/jqfmQ2DDxl/OLK7titNU0p28gqaBYgpNiXXTyfsqd9K?=
 =?us-ascii?Q?1cMjoDyX0ISeFZYNw+OiZ3d6/CrxHUWTbiR86m+zvXSRoAEZL8vxfDKmSeNQ?=
 =?us-ascii?Q?7m/711Utle4SLcMGzbCLX7G6f85RguzAFyrckT2dOHgL9pW6+L0D4N83ZyUf?=
 =?us-ascii?Q?Yf5pyY+RKbdOhzzX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAHZhWLC9honBcjPW1nSM283K4N7WH+arjNRu6K2z9SLWlmKocNaAk3CeDOV?=
 =?us-ascii?Q?qBWBwBw8NRfHDOP8LbliHFAlGP4VaaN+Ls3TVn5BRzHB2IrSPG/qfR20vjWP?=
 =?us-ascii?Q?yZtydYWVb3yL2GTUjNPQ9zUYDhwQCfykN7M39guhIMegiNfIEsVTJbfv+kz+?=
 =?us-ascii?Q?0EBTfPir0vREr46TLIye2DdVv3LQokcWXKTwoiJj5q/kCmF6R94h1HHtFDoF?=
 =?us-ascii?Q?hmL+rub+nGByT7iLaZFqKwTgTnwYMQ7JT3Wqr/437IArEIjL/3gBLhlEmci2?=
 =?us-ascii?Q?2xbrEg7Dp7V30bZ2IKHZwTTQTwO+O42fWllwhO8lfW07gPtBkfi2Y5SmKPUI?=
 =?us-ascii?Q?s3MwouUXFnjbTDdTlKpHKnA3L3QnWsU1voVOL4sWBmTvAu1YvCWgxEMhjqgv?=
 =?us-ascii?Q?DCxee/G9h4QKUfCOpZUdM2QK3e/vNoYN2KUrHQ7SI114ephRLav4D+gkdItN?=
 =?us-ascii?Q?Zb8ePJ1os6rKOVl1aOZdoV7MkuIu6/PAPzo1Hn6rOiMXr8lbtBvdWykeqXsI?=
 =?us-ascii?Q?5G4tbKNWt5V5pyBhgZ/V3VF89RmIJ9nELwZ3ABw2+vpxNpLw8P1qg68Da+Y9?=
 =?us-ascii?Q?ZxmAVj2HirLphaji//3jH+8MBSXt8888dVxYTNUkJ4aWNJC0dHvs1d/z3YEJ?=
 =?us-ascii?Q?i0yxPFypESkUlMbgGq4f8B5WXzeBNTVT6W/0d2nvoeyj3l1l7eR7ahgxWCWY?=
 =?us-ascii?Q?Ehw8/ILTW9ag7iRRhM3sTPQuHiChZSU7KlnrZ+9lha1DTwA7UimDECbE69o9?=
 =?us-ascii?Q?gHD5Z0Vo0xZnqbEgr7UzrPHiSd6k98WgVOtks+z4BZUv0DBVkhy2JGldE+ia?=
 =?us-ascii?Q?G9JQTwgNUYmjpriAkt3eJzM3OYVObGKoLn4+cPgr9fz24gBasQQ7oIg8vT1X?=
 =?us-ascii?Q?AUbjs7OFv4f9OeCQoDWLM5YsD7hrEns3/k8q8PTd+jJGxPtDfKvSIB0nGgxW?=
 =?us-ascii?Q?CUmYF+1SNtlMApnudUgKGd2DyRsnwT5/tYqs1HZLxY5DIASBhWx1yRNvXOEQ?=
 =?us-ascii?Q?N0f1ZHt3G07MJeQF0nyZ1FZ1QWB276BNUNlnMFJr7WTkvJd/mQEHTJaRfKm3?=
 =?us-ascii?Q?RKGC/SlNNoleW3O+mpZO3E3YrkTOc31cypF8JNqfjnuky5+hkE0J5FWjF78y?=
 =?us-ascii?Q?yV++Zn8w7l+J6nZo0WjvnVZ3G6nsT2rxaEKA+3I8BHIuNYEsGiyYVwFOtDcs?=
 =?us-ascii?Q?ZShl2RTl3/5q3ycxOaxImEdyYYWukHeoN3nADOcEOs9LOQKs/tv2Rm0zZqhB?=
 =?us-ascii?Q?H0IjYOJrL9OT0E6qNnKyX+4NjvySdw3PJAi/ubq/qD6LGvx4JQsypHe6D5X3?=
 =?us-ascii?Q?kz1wC4geignvVd9YFSXQ1oGC?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0256eca1-dcc2-4848-0070-08dda52b93b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:54:35.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8964

On Fri, Jun 06, 2025 at 05:33:29PM +0200, Andrew Lunn wrote:
> > So I'm a bit out of my element here and not sure how to check that.
> 
> No problems.
> 
> Please show us the output from ethtool -m, both the pretty printed and
> the raw hex.
> 
> The relevant code is:
> 
> https://elixir.bootlin.com/linux/v6.15/source/drivers/net/phy/sfp.c#L872
> https://elixir.bootlin.com/linux/v6.15/source/include/linux/sfp.h#L400
> 
> I don't think the pritty printed ethtool output shows it, but we
> should be able to decode the raw hex, byte 83, bit 4. A lot depends on
> how broken the SFP is. 
> 
> Or you can put a printk() in sfp_soft_start_poll().
> 
> You might also want to add #define DEBUG at the
> very top of sfp.c, so you get debug prints with state changes. And
> then pull the cable out/plug it in and see what gets reported.

	Identifier					: 0x03 (SFP)
	Extended identifier				: 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector					: 0x01 (SC)
	Transceiver codes				: 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
	Transceiver type				: 10G Ethernet: 10G Base-LR
	Encoding					: 0x03 (NRZ)
	BR, Nominal					: 10000MBd
	Rate identifier					: 0x00 (unspecified)
	Length (SMF,km)					: 20km
	Length (SMF)					: 20000m
	Length (50um)					: 0m
	Length (62.5um)					: 0m
	Length (Copper)					: 0m
	Length (OM3)					: 0m
	Laser wavelength				: 1270nm
	Vendor name					: YV
	Vendor OUI					: 00:00:00
	Vendor PN					: SFP+ONU-XGSPON
	Vendor rev					: A-01
	Option values					: 0x00 0x00
	BR margin, max					: 0%
	BR margin, min					: 0%
	Vendor SN					: 202504250094
	Date code					: 250425
	Optical diagnostics support			: Yes
	Laser bias current				: 0.000 mA
	Laser output power				: 0.0000 mW / -inf dBm
	Receiver signal average optical power		: 0.0000 mW / -inf dBm
	Module temperature				: 52.47 degrees C / 126.44 degrees F
	Module voltage					: 3.3912 V
	Alarm/warning flags implemented			: Yes
	Laser bias current high alarm			: Off
	Laser bias current low alarm			: On
	Laser bias current high warning			: Off
	Laser bias current low warning			: On
	Laser output power high alarm			: Off
	Laser output power low alarm			: On
	Laser output power high warning			: Off
	Laser output power low warning			: On
	Module temperature high alarm			: Off
	Module temperature low alarm			: Off
	Module temperature high warning			: Off
	Module temperature low warning			: Off
	Module voltage high alarm			: Off
	Module voltage low alarm			: Off
	Module voltage high warning			: Off
	Module voltage low warning			: Off
	Laser rx power high alarm			: Off
	Laser rx power low alarm			: On
	Laser rx power high warning			: Off
	Laser rx power low warning			: On
	Laser bias current high alarm threshold		: 60.000 mA
	Laser bias current low alarm threshold		: 0.000 mA
	Laser bias current high warning threshold	: 55.000 mA
	Laser bias current low warning threshold	: 0.000 mA
	Laser output power high alarm threshold		: 6.5535 mW / 8.16 dBm
	Laser output power low alarm threshold		: 1.5848 mW / 2.00 dBm
	Laser output power high warning threshold	: 6.5535 mW / 8.16 dBm
	Laser output power low warning threshold	: 1.9952 mW / 3.00 dBm
	Module temperature high alarm threshold		: 90.00 degrees C / 194.00 degrees F
	Module temperature low alarm threshold		: -50.00 degrees C / -58.00 degrees F
	Module temperature high warning threshold	: 85.00 degrees C / 185.00 degrees F
	Module temperature low warning threshold	: -45.00 degrees C / -49.00 degrees F
	Module voltage high alarm threshold		: 3.6000 V
	Module voltage low alarm threshold		: 3.0000 V
	Module voltage high warning threshold		: 3.4700 V
	Module voltage low warning threshold		: 3.1300 V
	Laser rx power high alarm threshold		: 0.1995 mW / -7.00 dBm
	Laser rx power low alarm threshold		: 0.0011 mW / -29.59 dBm
	Laser rx power high warning threshold		: 0.1584 mW / -8.00 dBm
	Laser rx power low warning threshold		: 0.0014 mW / -28.54 dBm

I'll send the bin dump in another message (privately). Since the OUI
is 00:00:00 and the serial number appears to be a datestamp, I'm not
seeing anything on here that's sensitive.

Thank you,
Chris

> 
> 	Andrew

