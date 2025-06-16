Return-Path: <netdev+bounces-198155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F3ADB6B4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6239D18873C3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E21E2877D6;
	Mon, 16 Jun 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="p4i6/14f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2016.outbound.protection.outlook.com [40.92.42.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B232877D9
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090930; cv=fail; b=SnItFPFhNz+al5bJqFP8mr9TinTd2smb+56yJOCl0MDfg90N/JfxdMEx1B8uWjjy+JtqV5iHnYIMZZlt88j/+wTgm8elpkcjVpBbJl+6xeZkotC5YnbAZZY9YFcounJ4OMmc6z1CdHaf1VzMvGvd4scfPj86/2KwOTD7LuHuQng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090930; c=relaxed/simple;
	bh=F2hk4M6UMBV7JKAUjSbmiEZVuPe+x0JCJMiVPDVBZCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjzGMcLnBJtb27JtV9Ermgj4Ld1N+cQYnWAY7gkq/Aqzry9nilQMzy5PYzdPgpWsUIrP7ZCRi+H6OO/1Ek0rYjTqDFWi7cO9KHYH9s6p8Th8lLEHaKU1GooP9NZHRBI8Rv34ZBBe47jDfgpo3+evmJGgH2cN5M5/oKYVZMal510=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=p4i6/14f; arc=fail smtp.client-ip=40.92.42.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9hemCFLRYCGCIRpUvGWnj+1DKbDHK5UT7Sq7RRF35RZ2dUeT83aCVXPSAb9b7z1wnr2JVcv7Wwf4JBitgUqzGNC1Qja5vX0fqHbZYyUj8sT5rjFR9AIV/Nm7DRGgYv1T5/jP6cJb2o0SpGINXlZ1XwggfZFFpL3ZqieeKZl01vnhdipFbJatBGT9KG2LSK4DD7lwdbhWNFLtJo/wxSVa4HmQGZHRRpKs9y6HAx9l5mt8CBAk3eA1/naA+vf58LXouzKOmaq0ASqf7XyYpQfbtDje4m8FCsrh8IRE7KYu3LUz6wxDso3S9/fUo9L9hAyhNf7tYLCcjtWFFToI0ZI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22LaOZQOR6n3BWm76Yx86BQOuhsy15oxd8EDhkEluHs=;
 b=YcEoFTfoVr3PwKq2oYsk6w0JVs9+H20ATMqijLUtTVlUhEAEQU0bQVR5Aaj0+OXrXXomSO2Ym98E0vWdPlOH/jG1Lx7cHztHLAT5ePL8VooyzNeOM0RZIZ4XNPGsXdCP8Ukf1+T7B1h5xBPcgFxmw5QGlabdSeLMAGiFRX2v+lmRTWcsB41BgWsp7h6zp42VSCMi1QkaKhL6uXMRTR2lz0Xu0MZA6mgm9IWD5tmsLNn0X0rSuYE6KHm02832DulQllN5CQKNPMtYWOGWdRMBorUbJypM19p2RJ+nJTmRjv66R1xpjmlCjcDecNy8csZTX4WvnWlNeETSnvOifio4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22LaOZQOR6n3BWm76Yx86BQOuhsy15oxd8EDhkEluHs=;
 b=p4i6/14f6KsZNo5Yg4ZsykfF60y4KhvGKFTMkvDh9rWL++I6+jrmdMvx3F9G/e6N2enWbmLxCPfYOkt3OhiOb4Kc1rzNliccZZcclKg13H2JGwzBSXN5LHr6HCsNzG3thlyU0JAqU087JD6BYUM5/I8jAjbPo6aPFzgvIKHKewPYl9EtR8g7JnFQ6QFy5F8hEL5JOhVaCACRY/Pkq88AJZ+LO2c+oo9K1cxatV5rliq7HOC44tMnwVt3ivPj5EfMfK4OhGNhn9syx5DzUzu9bTBXsKH5kMa2iU1v+kulVQBqIYyfyBIXDV6y4AKIpLygImWg21hIPjgiJl4XLlw9Bw==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by IA1PR19MB7879.namprd19.prod.outlook.com (2603:10b6:208:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.17; Mon, 16 Jun
 2025 16:22:04 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8857.016; Mon, 16 Jun 2025
 16:22:04 +0000
Date: Mon, 16 Jun 2025 11:21:59 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Chris Morgan <macroalpha82@gmail.com>, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID:
 <SN6PR1901MB46543B8C0721160E8B3C42FBA570A@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250613171002.50749-1-macroalpha82@gmail.com>
 <aE_mFWgIuuIn06E3@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aE_mFWgIuuIn06E3@shell.armlinux.org.uk>
X-ClientProxiedBy: SA9PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:806:23::20) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aFBEp0Q5tX3mk2HV@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|IA1PR19MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e511653-95d4-45bf-ddaf-08ddacf1ed96
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReGWl9jvtk7ljmD933NMMLtl/Y9pfKzZHg8vE/8BbDCclK/nabe0nDd2pro2vjOY9DLId/QpQ0fDPVslA4zPb36QQpA2RSjTY67qdk9aJLm9GwZYLDT7hvNQct7EASwzP5FJuCjbYs3wDh6KQCj2zNU4fE92nfHxrqnL8wO+/DIfXS/tEku9vuGsHu0eAo7iiyVPHevCZGctHvXMlqKoe7YazxYZjoEID8ZbQJASNBZe0SaCWBiT2L4ycQDjKVXsfG7D8m4AE+gLCFsxfJf3QMbK8GhQnL2E23Z9HXNk6cV7kr6YVW4PwUEvjwDCMSuzBJlc4PFYNYvhW53s3b7nXxZKQhczMDOAmcorqZAI7FyL4I1Y9MNKk1VfgakCoUJ/LG12iTUgrsj30rgAPnv7heXrU5qwhTFISGx0/M9io7tQWYQQIMGPm+sPWxZ3IafrdkkIo0MmzUKYREqlJtG1u5PwYhYufLXIYQIrtlCSF19abhuewiJgH48ZfCV0TRRobIMUPXSq2pizf/vjrQ3Hfxu+z3SxsTmKXx7DKuO7wBbVVYdGsdk1/+6sc2/nryCRP60nzMNcsKRb/4LzS5fPrLO2L52VPnqLZyMgF67gv9RfMEkn6m+kOYbINGOpaYxFZYkkmvk2aZZQSndqJYDVKWfZZS8CuJJZPxBC07slbXUNwHjN7ig2lm0i6v0H+TmObXWblHfgRIKvigKxNIckd/VYZli4H/ymNGbM6UKU9Ic+b5jJjp7Efb/205aSdkIFOEMX6TwPdAGplaGZGJOONDUPY37pjQk/gjTKeK7qYhQrig==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|19110799006|7092599006|8060799009|15080799009|5072599009|1602099012|4302099013|440099028|3412199025|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVLwccS0EeNlSNh/oRuOHWCZw0rfa3KynV/EepZmrosHnmSStzM9OkXublcn?=
 =?us-ascii?Q?lOpFTwtx1qVi6GNEsyB9MKU0vHUsTRrFFAvGZAuPfvMby8FtM4IA9KhKwitJ?=
 =?us-ascii?Q?DViN/QjWa+a+mXDuoFyLRFy12F51sW9QnS+qLxOdTOQAeT2ryG4QI6+O2ZR0?=
 =?us-ascii?Q?+8VQP613u2rG6kdO7BqY7034fwwbUhznwFfWsfY7B4U8mQFU5LVxPvcjKDGJ?=
 =?us-ascii?Q?i9OXcJlgckuy1fIVOd168s6DAiFKI0+xfFzHAKzDmzh0bxr8EDE+j7dZVUeb?=
 =?us-ascii?Q?IS7ayegBpap0dyrjzJ3gWBUc9kc2TpQ08Vd1yamW4v98Lvo6zsdnjlsx55qo?=
 =?us-ascii?Q?na+0dyw4QOr9kdlVi9P84fqEL4HeGHbe3tqHPPDVVi019U4oTy5Yu+aembGZ?=
 =?us-ascii?Q?oFzQZPQh7arC62h4f/RYsy5LY2f45WNZEe18C8Oo6aBrtGTGdQXQTHmy00Dq?=
 =?us-ascii?Q?lsN6rno6YUEv73bBpJU0mKoiw7MnvqRqbjfOs+jGznr49Yq+sL2QePIDLSEQ?=
 =?us-ascii?Q?9cvEwlOL2V8z4V6aDPlTIZ0gvFsO9nJKIbztftVp7g2fhs+8iUvIrivSkrP2?=
 =?us-ascii?Q?4Qu9AkPJLqg1P7v+c5D2rn+I+RRsayPJ/jkVbWrfNldEpNWb1U69V7rJq51M?=
 =?us-ascii?Q?b4oCSnwDxXFlchNoWB+syZUmh9ajVzy1IimzFS/AygRQRQLh3aaUk9wf8Jqn?=
 =?us-ascii?Q?8irXLJhhgG8/phNEZW7WQq6jCdMYWGsqpgG+AhNrRXiuXZwNjF1M2sqWgCyY?=
 =?us-ascii?Q?3KlSMSKJajBTbYntNHUnQ2pSUSOh7k4Pn/xDQrKOmX5Ghp/hnMSoY8F2DDov?=
 =?us-ascii?Q?zWFoD2DAPLm3XTpgdhfqullQfIp81eOeskNddA65QQgNMsiNIE3bIe3SkI8f?=
 =?us-ascii?Q?7tbGL876yN3AC20DU4JLiqVX7ZfWia4S/ySS3lF7fjhcPMsD1Hmfz+FfmKyd?=
 =?us-ascii?Q?nSxVVt5lFuJbZzEZbXR+neAIDzOeyc3jUz4IcXz6/NH+Z4KcVj++gympi7c6?=
 =?us-ascii?Q?CgL6E2ihBPk+tj0o37wE1jmXni3oFnun8raG0Z0gemL/uw2LxIsC8+qcsHCi?=
 =?us-ascii?Q?iAp+wFUfFvss4rNQEg1gXPrkoAWRf+OpnR0/qXM4PGkaV9LRE6tyMMhGNo0q?=
 =?us-ascii?Q?BHiIYrGyuevVEEyzsjn18lydSjChheGQul0+TufVcs4K4HZpEWb41XnVwVO0?=
 =?us-ascii?Q?0QQyvaa80+xjXpy8n5POF3Va80WvqQSGfWU8Wvxhte++2alRAa2b/MG2oG35?=
 =?us-ascii?Q?XnbugO6GlVGJwv4Z9FP/7PYnDkjVihdXknqkybwNDA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQBXCaltouyC3XHHJKmbY+ZYh1NkJ9uUGhwOzyNpjQAiIGrRhiaTbaJ9Mah/?=
 =?us-ascii?Q?knqvaY6KDRT8hprq3N59lzevvAbMybn2JSCg9GxtKOHlo7HGWXC1ggQntX3p?=
 =?us-ascii?Q?CaPYuLXOr1EiXUFpg+Y43iizo9jW334YFLm5yZClAUsQLo+wSBHJT8z8Z4/b?=
 =?us-ascii?Q?RDRsBlOzU9wZI2nqCFg3NnLdS4oXv0e1LbOMLXbDLSG9Tm5ly1+5WHuVpbNR?=
 =?us-ascii?Q?JPkHdO5kx7FdbqILnGtCL5/bmu7PzFfggE/FnQK3mSGkOT6Opr6hiIRGa4EA?=
 =?us-ascii?Q?VYdY19YAt+GIosWvMcCkBloKb6c7e1h87ljtBmcE/CvzOym1HO/JfCYfET4F?=
 =?us-ascii?Q?0Elj+UgsJIaDS2yZaGDfGMgO3uZCf0OC9LQqQVYmPa6t4G2k2H3HuY4G1ypL?=
 =?us-ascii?Q?34XEcnFYSoAs4ZoTjRCQEK3f10SarrnCsVFrCZUdAaOIwt78o37Up2IF1dlr?=
 =?us-ascii?Q?V9iXYgMQdSuFCE92fYsy2vG6Wx5AB/623Tbwi/Ac8u9e68CbbBTGwNSVKA1L?=
 =?us-ascii?Q?E9tUHQzF3IbUc5D3sHqfoL57Fn3X8UaT7SSR+hGlIOWujPAXTFP2204tsjdv?=
 =?us-ascii?Q?TSSGL5QDZknFlZ4lQINl12cVvkXp/3Zy5y+x57vWpGEIN7MJ8uHgGeEg9S/6?=
 =?us-ascii?Q?6PSnh8pJ/HHzf0CBZSDyxu5quSYZ+ZYiLtOpRWBbZuzpYqI/yHLkxavir0Vx?=
 =?us-ascii?Q?u9Kn6dD2mMBgfR7ioUz75TjSRwpHGq/f6/9JJIm0WkfUNxZn3P6TMNLPjQuM?=
 =?us-ascii?Q?KPmPzoLDQleMaFO4//O1IgIfYoKipv9d0zykGByvmJ1DNhOQz77FbBN3YdHo?=
 =?us-ascii?Q?to48wmX2hu0OXAPw3mHlzPMxzLTdZ7jti4OmVGocnITq/bY9JchZFVkZvBIe?=
 =?us-ascii?Q?HK+h6Clb8a9EQugZ4UYDkXpFyHfHhF7hCwoaUb+VrFZtBn+mw8r1SMe1XFho?=
 =?us-ascii?Q?MX0PZB8UN1nP/5bPZqaNmumPZzJF45EDCioJAMcvZoKiEoOOpXhXuL4pw/wP?=
 =?us-ascii?Q?MKHsS4SoL/NUOkwGL6qEVd0hyIb8bSiKLbL/KZidQcGm0cdKf3VR+PGs9z1K?=
 =?us-ascii?Q?/m5OWFzR4lPu10HdOHmGtAsftHjTyrphBRycAXeGTtFbaYvxs0gmjD/slhCI?=
 =?us-ascii?Q?rDMvH6aCJxFndPDFaiULmAcUbLD+d90h5AUQCZhnvEua3QzumlCqpb2Hf8Cj?=
 =?us-ascii?Q?pz+n6iXybkjT/eGvhm+0hvFdMA2DWjgenSH50l1S1Ci/DqdWrOyjoqbwA2xq?=
 =?us-ascii?Q?yRMt6zZehLrxwVTl7iMXZhanKw9XrYDvtde+2LqgXS9PPxBqhfCggZ3b3M+6?=
 =?us-ascii?Q?xUzwS0Yw4yNiw16BwDbRZXei?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e511653-95d4-45bf-ddaf-08ddacf1ed96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:22:03.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7879

On Mon, Jun 16, 2025 at 10:38:29AM +0100, Russell King (Oracle) wrote:
> On Fri, Jun 13, 2025 at 12:10:02PM -0500, Chris Morgan wrote:
> > @@ -409,7 +414,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
> >  	 * these are possibly used for other purposes on this
> >  	 * module, e.g. a serial port.
> >  	 */
> > -	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
> > +	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));
> > +}
> > +
> > +static void sfp_fixup_potron(struct sfp *sfp)
> > +{
> > +	/*
> > +	 * The TX_FAULT and LOS pins on this device are used for serial
> > +	 * communication, so ignore them. Additionally, provide extra
> > +	 * time for this device to fully start up.
> > +	 */
> > +
> > +	sfp_fixup_long_startup(sfp);
> > +	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));
> 
> There's no need for parens around the second argument to
> sfp_fixup_ignore_hw() - the bitwise OR is unambiguous.
> 
> Apart from that, the patch looks fine, thanks.

Thank you, I'll resubmit tomorrow with the requested changes.

- Chris

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

