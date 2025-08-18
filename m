Return-Path: <netdev+bounces-214453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3DB29A22
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C10167752
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58152777FE;
	Mon, 18 Aug 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q7iIvvTl"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB21275AE1;
	Mon, 18 Aug 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499795; cv=fail; b=NOvrMuC//OHRZNiQ1n0ZXtZ8yMCofA+4nm75yBPNSGqwC7HfAiHjr3F6DkzfJuLSH6YzDEKCSgx1m4FIA8gv50pjQRXHyvrtFf05yrkSHBd+hGAYv5gT1SvQhPCY0xCmFinikTTKi8YpKFbnQ1sYiAiJuECTt7Piwgpgu1PMlQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499795; c=relaxed/simple;
	bh=m95Yco4Jgli8LBig1hqz8gcy/5c8lo8JJSIDquG7WVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1UIiCQNAMooWIMbYUwnGDO2WZbHfM2kKB80yJflm1u/hKoYplTU3Hs/q5MONgFRKChDSwCe/kE4wcHsy6U6yL+3rDhTAxubTxropjMiJetYjEJtWYc3tZ53ERTOnyTCq1JbWYvgeY68091+SjxRh6YgbYd/bGUZHGIFsnLYY8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q7iIvvTl; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oii8Ns024lmrm9gNOaum7/mcWvRFh1n10qTroLRT2haa4wRpQ2AdRxUJfFFOXkbSx2G/AMLmI41gg2eBLnirGsH0qY088M233CdBAg3TYjhFGD2GooINkC7MnKgTq1SrYzRtN54HCsI5+IsHhaeGPBber6v6XuZIndaby8jmIik5cgOSPfYq5UvN9TkJtbSGornvQAPgotT7xcvs0Na4iZFgSQV3Q/VQJXvvrbA0aA+2uDo/mumociGf63o4yQf+Hi0PvZ2Cs8LTCVsOkcwbByhsUJsmZRGa4ljps6f833xvYWTm2iDRvyGZwtcHQAgPEZGd1dc10LHCMauMKLPdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRfwk8z90WeVJqgW4lU3GSnEUYd9ccGjfjYi7pohSBc=;
 b=krtC4mdYDnD5pFKjQYYsreZi2LJsWdeP1drVdLP/YKGUZ90dwJ/Pq8g2cCJHXcHMMNy+OBsRD/bI6t8/bMdqM9qzJvVWrsmPROphqI38ErJJIB4rYUQrwJZLP+XqA3mwTGCLdLco9xhDWlWdLz1a/4hZxpGIzUDZXUVxxlmHLO5OWA0QsxabJ1hZNsmu68G8g7sthswvUQIzcAce4SKosnbWClTFyAiMsq2vHmKi9HjFBDJLTgLdTAplYj21FhuWI1i9cCjScjdoJYGOEHwlktCqf6yvLKDnT7Utjaqr83Krz65N+ubqvUzgjb6u8mQoPyjdFNDVSXdpTtuQSK402w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRfwk8z90WeVJqgW4lU3GSnEUYd9ccGjfjYi7pohSBc=;
 b=Q7iIvvTl7MxEwrf9DyQDoCyUUYfmh9XWd3wAPASif5Y3R5JRnw26t+O+wBRqyUjLicaCofJ7oPlsdXuI6Kr0p9ADkBt7ughz4PqtpssNa4xZPa3mMkS3FN70LQ0WAmbWUqnwRvSOADoEoEjPZe0rUeYMrPGq95eEH7D6KNROBw5uohSRHzBq8D/2OWG8Vu8duicWMLvaYjFOX/nX9VZ8YPCAmvdAFiexakCGNmwUhByK3GWhMa2nAict7tfgD7BW0B2lgDPqPk9xbzBg3m+W1rcSjGQ1Ie7nWDq+ItZ1wKie1GPNxrG1xcvat0yRnP6/ESC+0dLLcpmRTXYNfy4GqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 06:49:50 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 06:49:50 +0000
Date: Mon, 18 Aug 2025 14:44:12 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de, khalasa@piap.pl, 
	o.rempel@pengutronix.de, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] net: usb: asix: avoid to call phylink_stop() a second
 time
Message-ID: <yynqwoltgvequoysbzivrpff3bpr734wtzce4um6ugx6ca4lpm@useknrj6bmwr>
References: <20250806083017.3289300-1-xu.yang_2@nxp.com>
 <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
 <e3oew536p4eghgtryz7luciuzg5wnwg27b6d3xn5btynmbjaes@dz46we4z4pzv>
 <c3e7m63qcff6dazjzualk7v2n3jtxujl43ynw7jtfuf34njt6w@5sml5vvq57gh>
 <1c352c2f-c8b3-4cbe-9921-8ba5f0e4b433@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c352c2f-c8b3-4cbe-9921-8ba5f0e4b433@lunn.ch>
X-ClientProxiedBy: AM0PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:208:be::33) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d180024-1d44-47bd-6f30-08ddde236d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tMfdZDiv0m4UjzyivGilKIFXG4p+hsNoqW/uhe9PJ8k++fXLlNePMymLd5h?=
 =?us-ascii?Q?DS/NA5F/cx3HGNp8dq6k394+A379DquDmqKRRDK0KMEAhW6m4R2Y/+EFEyki?=
 =?us-ascii?Q?ViUQMs0npbvi2c7pEhrAlnXhjQtjISvBQv4MzVTqpEqGCfZRTPX2ywha6Lk2?=
 =?us-ascii?Q?oi1eEStYA1NkwHob+C6rE/O4F+1WfAXnVu2i3A5ruZuqk1oQR6p1DDnnkksI?=
 =?us-ascii?Q?anUaE2wcj0XO34RYHrhTEAt/ICEWkI8Ph06lgxHxkv/UVPjZZ2PvmtjUtF8X?=
 =?us-ascii?Q?qT28gSxYZNXfCLQbIxU9J8TYP/VPOCcLflFClivuChstXHaxi2iwX+nr4Hsi?=
 =?us-ascii?Q?xZ7+3enlBIbopsAFnXfWsfElwCLXLW5NAx0Dxl1NXIavFXZrAJTYKWQc3VVt?=
 =?us-ascii?Q?EhK3KAfr8j3Fhfmq5zXeG8jchvnE7BN9RMxpRgPOR5Y5rSXFFHePrKMK9KGd?=
 =?us-ascii?Q?99/hmYujoTU/dTbE7X3ngnSdgdqt6vil28sRJHmuZzC9KQTlAG3PIjI4aW78?=
 =?us-ascii?Q?7ahqANyj5THwuRU4eHskfgjlbnvhnRy/4YxiYHfmIUZXS9CXagAYmNQ4EZdI?=
 =?us-ascii?Q?/wp6S27VhfRXKBdLt5nAsaicUxf9qV2LRtbPUOA+/8JSQg2O81XALm8uFWud?=
 =?us-ascii?Q?04jRAKfNKkgw7QzIkZkjJQQ5AFehHh/Y70bedecX9Ig919Dz/Y/ljcwK2u1p?=
 =?us-ascii?Q?p8TItMnduRWs+AySra6NIpQ90ItBRysrLKJgScKXo3ZSefIksD6QV3/MH2vz?=
 =?us-ascii?Q?EH91cCfUs8+iJ4dSQegefYayCX06vM7ttg5iCsOjQrGRMWmzB8yeVut5+LAk?=
 =?us-ascii?Q?GdEuhDC6CRWHpHclBE4tgKmt/8UV/3yFI9I0UI5HxRmtmjbhB7CBpQ8AGuRL?=
 =?us-ascii?Q?aJuIRSIFKS3z4mtrIqq3e1jL7nyJYCzRwM1LhvkKFAtpLviUJhcKeOMKUzDi?=
 =?us-ascii?Q?qGpvxq5vDvy50KH6+QYjGq4YJR2J6oN4xRw6pB6XVbhVCqORlOSaiqKxpHU0?=
 =?us-ascii?Q?2B8F3ZTmJylHecwqNJ7MKGFrwGO+sJWBgkbAZSNHjegXn9DG2W2cxwPknJ6p?=
 =?us-ascii?Q?6l2qB8MUGW2Box05fBrN1CPkrYriD9eeXeZOEUA0Ujo9uW15wFqo7gHd2GVD?=
 =?us-ascii?Q?6Tk86hZwOj2QX1cZjKkb9JRs3cqNkuvKp3UKNuN1fgrYEwRJOC9UM44vXkQV?=
 =?us-ascii?Q?Smrg5dlRrbg/ep4bmyCWBRTJ5M9KDCSRKxLB5FVF3QjcS34DKxtt46fayqbL?=
 =?us-ascii?Q?L4jWF+4ZQZiv0/XLey1edbqMv+rB2KMoGiW+CqbURg8Ch0YqE+H0fUytk5R5?=
 =?us-ascii?Q?Ogl3vhDA8OnEUakAgg/Gi9lzxnHf+S2OPPtTfvdqcbwCjrUAAKQBUDgnraGq?=
 =?us-ascii?Q?pX7mw5P/Kb3neKyfooLxHtNQ71T81SnUaQ2w+xEfeC+CKDoKvhc9Fq10r53H?=
 =?us-ascii?Q?XxFEIMEjSRrqj24JFJvFAd7DKwKpye/EF+MF0i0B/8hxfCrpdze+tA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0PlHR42dKEXr5D75bdsj77ZlR005XqSYiDw5QhJ4STIJt3LaOYr5Qc6EF0xS?=
 =?us-ascii?Q?aes7djzd7LUmOKsEbiRme4I7iZHaurpe/uvUMD8WhHZQQg6Vydvr1yGExp+e?=
 =?us-ascii?Q?Wm0nue6xakimxJ9t4kyLxUPU0K/a6Bnum3RlbMokLgFxH/pz57O30853MTCL?=
 =?us-ascii?Q?H9ER82oSblflrrKa83CYEyrk53IXxoT3IOcPrdl7OpeTVkwq74sW6lpDoE4Z?=
 =?us-ascii?Q?qgBj6atHnDxGQov+VRUV+ZSJenhysuFDYpiL4MCahyoVl9t5VWl/e/AezEIW?=
 =?us-ascii?Q?qW8Pueg6WyV4n4GwztRZLY/RyHOk3Z4lhgiYdJtTVJzrPIJ4n2jpcWPxje5U?=
 =?us-ascii?Q?7loTcAYRE8gfUCHLD4laxxID71jKY97Ftdq/cit/HyJe2JNfnhj5P82wU5vo?=
 =?us-ascii?Q?JlcR4xK22DkYvOlpD6iNVEFeb/JbEgHJ9ClAlrNvdnpS9mSqYllrVcuL6ZoZ?=
 =?us-ascii?Q?3ijlEYOQgDYNd29Ur2iZ4IZCDDwXfx/xbdwle+nbMPoWdcQ9kshM5u+sz4Ir?=
 =?us-ascii?Q?eeKtyEewNgvo+Fo2MiSQhvKkA6GU3Ejn6h8wj+shfjrxjBFrpNB823sA07OO?=
 =?us-ascii?Q?WaSWv5qoS/hlwY5f0HmdQvT4y5BB4tQi6Vp+RDHGiMeln7/lO3QZ4j8PMYfW?=
 =?us-ascii?Q?qPOzu7jLDyHzM4WQJcwO8Y5ciWMSxRAIJxdqm34y4KWGA5gp4mIy9e1PgwN1?=
 =?us-ascii?Q?OHT/PY3Vyn/JNpuG5SRD0j7qDxlbbJ6xItScA+6T17kK8szFterABNCCdi3r?=
 =?us-ascii?Q?/q2VJ3U6Oo4BssDqnDvBZfir9o6o/0kGy5iN2aA2ShmGYCCHhoDhJIpOoFPo?=
 =?us-ascii?Q?fpRGI6dwJC3zqSTGcKr6RJBVZj5YFemovC6I0vdvCHxbF+8kwDJ+rFkOEoHX?=
 =?us-ascii?Q?kMM4EGvWGvIrsWDXNbfaN/UlBkovyAzDYqhPpttW+KoLt2+8Y5zq1vxz4ho1?=
 =?us-ascii?Q?6Gac4zu4UC1tvT9TLbVBELY2QbYOe/P8cjW6tJsxBrALOjMk+4KYeIHj3uuG?=
 =?us-ascii?Q?HwfQ4Qo433av/R1cpPgFfvhtL/9ZFOI9u2QkgWQp4JErjEXuCwXAjZj3LAXy?=
 =?us-ascii?Q?Mq5v1pn03qTogxEg0T00t+V0UDLVK0SEgXeoecr3GPKRqriQN4XZ7qcQnM2b?=
 =?us-ascii?Q?UODEZoE8TgGWcqr8Gb0EYMviNg577UxeLA8J2zB/JJ73d5aucAwEOtIm/1P6?=
 =?us-ascii?Q?1zgRC3h5knxjNGmurMGinGlwiU44cUMpLD+O5UkxQPiR2Z5FIs6glD9vPbgm?=
 =?us-ascii?Q?Q37x5SX5BR6aJo/BBqTTkRBnVSVNuSNOeH5tyFsTIVW4P9Qcu4Psd2jk2pHH?=
 =?us-ascii?Q?8XRQQEXMKIyvG6LMxYcEAsX7zGEm0IP78O7k1dPMTBPKw7VT/DB7yN5z42fu?=
 =?us-ascii?Q?aLYIZ4MWgcdWmc/zx37olg3ZxVV/mRKAzm1xuefW+K/k0l+Go3VlZIRly8Vs?=
 =?us-ascii?Q?CgVHtmsdRhzvQ6cM88GfT+yfsne8HB+zA6fN/Vpt4IJiHZoyzK8xUrJ80/kB?=
 =?us-ascii?Q?umpkp7bpSSOUDqr6OswbKAWdtQccaepBsXWoC4YB95a7Dj6ARspKz4oLM9kf?=
 =?us-ascii?Q?+XOxVKvqQ2V6xfcFmpSH1qJ/Z0hANd2Yl1LlbX6O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d180024-1d44-47bd-6f30-08ddde236d4e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:49:49.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR367iWpB8OyVvfDxrGqLpRH0wxQm+vGrvAKxDhf1eidT45cl7B6cfeRMjfZqE9DegZS2CK2SlVr875OStJK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373

On Fri, Aug 15, 2025 at 02:59:12PM +0200, Andrew Lunn wrote:
> > > > Looking at ax88172a.c, lan78xx.c and smsc95xx.c, they don't have
> > > > anything like this. Is asix special, or are all the others broken as
> > > > well?
> > > 
> > > I have limited USB net devices. So I can't test others now.
> > > 

[...]

> > > 
> > > Should I change usbnet common code like below?
> > > 
> > > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > > index c39dfa17813a..44a8d325dfb1 100644
> > > --- a/drivers/net/usb/usbnet.c
> > > +++ b/drivers/net/usb/usbnet.c
> > > @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
> > >         pm = usb_autopm_get_interface(dev->intf);
> > >         /* allow minidriver to stop correctly (wireless devices to turn off
> > >          * radio etc) */
> > > -       if (info->stop) {
> > > +       if (info->stop && !dev->suspend_count) {
> > >                 retval = info->stop(dev);
> > >                 if (retval < 0)
> > >                         netif_info(dev, ifdown, dev->net,
> > 
> > Do you mind sharing some suggestions on this? Thanks in advance!
> 
> It does look to be a common problem, so solving it in usbnet would be
> best.

Okay. Thank you!

Thanks,
Xu Yang

> 
> 	Andrew

