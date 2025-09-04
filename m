Return-Path: <netdev+bounces-219831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E9B433FD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD511C22399
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917026E717;
	Thu,  4 Sep 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dP084dbB"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5611ADC97;
	Thu,  4 Sep 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971122; cv=fail; b=EN0wc/2ztEMHBguRUbcE8JngCE/ihY6LbM/Ja4vZGAYjOrx5Gfm/ZQnve5rIx0UuWbnFT1pA+BQok5DdGDkgsipHSiX6emnqRdOlQqu0tnXHIHoL0M7oIEzIwInAQyAE7uo1yUPDHFDbgQCJkVFhuWbv3dXjvx1vpEetYPOKCHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971122; c=relaxed/simple;
	bh=1NPI3+4IuwC8eiDZs7bmaKgkGGr9UnEINpvvXH+8IUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WEPGNxqPtuJ3N6qcelJMvd19O9gCcjWouCn39+NVB+WL4VG2bl0bLw38Ch9aYIm+7ebbG/dHM3wG3Sewl4pNNY/DdV6N3LCkLVWm0H8XOnrHU71aBJ23sKcCrGRmFWh7oSx3iGy4LN0/AcPSFTqE4OALUyKHi8xC1Ms3mjyZb1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dP084dbB; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaPLYdPRooQphTzLih4MN8WMK78v2KXnaZ1lntaRS7DuImeVlyM3IqLmpI+NSQXvdXyI1alsfyIwo2fhH3r9ezgGvcTK49fV2GbAMfvghnZkx3ryz7lDT2hoWJSNJPa3XOoMXVwSLrLj5LD3j4gbg7Pj/bN1lkUmq1LbH/RYcco8A3dL3DvMBaZ8ABD0pzxy/o7iFumlYz5EzYxfGLeEUEps1Fpm1w7MckHEGnNnAwr7Tu2nlpBeIyQh/G3KnPP1jKh5mMiootRSesZYBK6RY8bXW6nHkeD21pEJt5PpaUM2DlXhETCTnBKvtnh46wfm8wc+xnKmeFnJQhGZjkC8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PljJ16AmjnhHCcsD/v1QxIvXkyodaii0eWVKjRMGzfI=;
 b=VOpHffs8gEotnYgaa33pQs7bIz1CRf4fp0zMkFWJAZojGa/o7GD083iFci7Sm1IYQtke3V7H+aJKt7L5eTEHqd+RWIolEuJ7sLq8wSvSAPTvB3IgzY21XhZ9/rxZWL+SZwAXeXeKAQmkH8f3p9eQVJ4TJ8cYqmtxBbYG4towKn4GiVZuUnJxzV8znvTxNV7953PWr5Vtk73oqSLiTybN5rahpgW9UGQfklVK8HDAtHtZcRym+WKUPJNDZvTbqXtKGiNQHvGzgqJW44M9eKSxQjdfB/cnldNUE9iewOBFK/u+puRzE7YOR5kDOw7ulc3sIIJ8GGZzgxCS9K4o5hWF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PljJ16AmjnhHCcsD/v1QxIvXkyodaii0eWVKjRMGzfI=;
 b=dP084dbBgd27Ca+9C31ju3E3ShQbvDy3exQMAOPF9jO2Zzoo8HaaQcjyaKyAS1IR+evPC1pi1ZXczYMGBtU5pHbqwK7Ojf5rW4d+YXLDIAPwUyX5JQjksgFXR9+2zAVtG9WkvrZRF2VGehQ5PGGuVxlNprRWFDyaUCZQxVpc8p0EeGjJl/enEF23RSxdXOsZN0yj0N+3JbH1BLMxMucWtdBnV3lfq7ecSyM0e5HgG6oGBKJ6ulHZRPnNu9Qq4mCfQhGRP/SgNziekHFDoIjdNjbEWMETKsXYGhNzQHS65QqTs9QNu2AUOsxA2k95L1jde+seAtuKjGoc4nLjjK//+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB9757.eurprd04.prod.outlook.com (2603:10a6:150:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 07:31:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 07:31:56 +0000
Date: Thu, 4 Sep 2025 15:26:03 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: usbnet: skip info->stop() callback if suspend_count
 is not 0
Message-ID: <ttbjrqjhnwlwlhvsmmwdtzcvpfogxvyih2fovw7nl5bk7hfqkv@4cfkfuuj6vwr>
References: <20250818075722.2575543-1-xu.yang_2@nxp.com>
 <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
 <ajje6wfqyyqocpx2nm6nmw3quubmg5l3zhuxv7ds2444hykgy5@xbi7uttxghv2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajje6wfqyyqocpx2nm6nmw3quubmg5l3zhuxv7ds2444hykgy5@xbi7uttxghv2>
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a7b67b-8493-4e1b-ac0b-08ddeb852091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5d90y+W2SwueSUNV2hfjOsG+/YGC9q9mGecoSvhuPuDPjFTEwd4F1bqzYP+?=
 =?us-ascii?Q?MqxkDPoIpIdxxiX7E14Q28l4Q3qrZjnPRjmLKBaNyXnZit8zmLPxguhEnl3C?=
 =?us-ascii?Q?QdVItgaItUsVW40sCVvmTlUtwbnfQeoDVFFfat3xmgZBFi8uHrihoO/lLzDy?=
 =?us-ascii?Q?pal4F57g9yw9aZh1eYseE6MH4TYfiyDiF2l0INDduM1O4d6x2NEGNBQ0Jp3n?=
 =?us-ascii?Q?d9QE65kZRjoJK7JYElOtD//mgTRhkw1wiqTumZcnBzAiJyWHoj+JNURizVgh?=
 =?us-ascii?Q?y2+hrnQRVD4jiv8qX8IWJTmCGbtcUwJOQVzGrZBHmcuL3XpcssuvRjPVW3ft?=
 =?us-ascii?Q?iHA1zcVpiy5vKJxG1QDdwW4NS7RrCHBmZv6dgjc6XXBB+EjE+p0AFOkK10ct?=
 =?us-ascii?Q?EHmWL7lH6L0P3FfheBO4CKX3y+A9vLXGTBWgoGibhw/rpnr7r0+5YZH1jDTq?=
 =?us-ascii?Q?VSO13tHIlRO1QZNUJtEGn3yv9qq5CzbxhPtL1Khh9SZyoPh2jpBAe7pxswcD?=
 =?us-ascii?Q?k7WaCB5VNWhMFO0w+Mx+aPmsBVYx31gjB1alHaB36+bqBDgeB6QbB2Ai4Ods?=
 =?us-ascii?Q?+O9yaTJIeY2qUa3lscQHk6lmk6u0x+gVrHX73K+aTrKXzcIHoPTAX978ewIC?=
 =?us-ascii?Q?JYBKi9gbiA/4Y/9HpCR/se8TFhfyRHgsw17hIO71lLpJseG4xzTxQxTwtozZ?=
 =?us-ascii?Q?NP/3+oBZFrL07mGEQxjKKW7+H+7wlS4M2rWuDwYvPpWaOsK1q2wEn1EDhrs9?=
 =?us-ascii?Q?pmwx2n4gylzAh6uqecYa2VcgY9vMxB2k8c1PHP3nrLjtFJg1KJ/G7kZB5wti?=
 =?us-ascii?Q?oPgZ/yCvblT28a8TZKYhyNj0UYl2kzDJ4uIWoPFOp9gdczlftVX+MjxaKOHi?=
 =?us-ascii?Q?b/svB7sSLwQQNDs5cErmuY7wu8PJvxCStiiUWxTxKPDKp+rLcRd3ezAgk79U?=
 =?us-ascii?Q?+CEbZv71QFkcJXG4B5tUdUvtJ/BMQ4viwp1NhFU/B3n3jx77IE9yF1T6jSl0?=
 =?us-ascii?Q?uMVLvjppt3KJYVJYuAVkcnsaYtH/61GJzbZSVvykgMlO1svs01flGpDK+Dve?=
 =?us-ascii?Q?JIFjraZDXQTUGFk/+RD6CmoysqLFMsTDom0mgj/k+4SK+QmWKW0JJC1/aOsB?=
 =?us-ascii?Q?FjCI/iKkwuC8amu6rJMYzoGwYHiWP6Gtl4wTrzMHSPW7IIN7C8QUx/V8reZ1?=
 =?us-ascii?Q?WerS6MBzIBBtbEW1aAhTlZQNRFqexbNGnJ/BUa9bC8wWikQJmK0N+z9cwSP8?=
 =?us-ascii?Q?ErI2To3lLVB0lTPKR6RqX+bEvamGQet8xBcISbHGFxam/YsDjUeYYWkVJhfb?=
 =?us-ascii?Q?idTEbOJs9QHemFQceLzJDCDnRNcVVmi3+TXiIW0lhJl2lp4HJUwuKX6/jRtA?=
 =?us-ascii?Q?63SNZvL4N7PDGvEqmsJ7dQtyy9ot4oSanyPWaBXXUz7rBMF0OEz0f+csHky2?=
 =?us-ascii?Q?jRh+rfa2ncFnlnD+rnAKv8x2NNheckbHJJQ4B/DGXqAM3lQgkSgkSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qe2OzKdBla0j25Lm3+0M26Pc/u+T9du1DdZ5PBCB4J0NUz7kCkjSw4w7hIH3?=
 =?us-ascii?Q?AM4Re0UY9RwaOrWOL/1gAfq2MjjxWvXhW8WLiAXGoAr1jRR3fb+66w/ws3rL?=
 =?us-ascii?Q?msMGo3X8ZzEqLptXqXDaGaPTS7bqi8tTfb+t2ajctBy0GeuK8ipT90OSkABV?=
 =?us-ascii?Q?cZKtq8LZGy5joMR48y7Zxd+Qdrdh65aDdtp+zxU7WApdzXWBOdbB0crYlCwC?=
 =?us-ascii?Q?WOtMGpnR829y4DN1NVB78tna0AEOrW383wM9Tww9iAO6XRfEQxd0gXVr5KWu?=
 =?us-ascii?Q?iCP71fPy0v9DsXo5z12uOLq5IEmnNxp2z4ZwlpWI8r5Dx1Y6KOSncZlZOIqp?=
 =?us-ascii?Q?Mv0Y4Efc7GBRXw//cvqPZzhFYnN75ckHjvw6S0shXsfQUyTmDlMKL5uqJZZz?=
 =?us-ascii?Q?j4SWdbJl0l8XwGnGw3w50NMFN5Xo8bLBKqtC1i17a2FMlrpFfu3HAPtxUWyN?=
 =?us-ascii?Q?e4AffHh7RMUU8ZebjWy8vweczr3W3yMZV9vuOCyptmxKpP+RIsGxxWGRCZ4u?=
 =?us-ascii?Q?y4y+7SFUbF4g/LrHUEGRu76KjPBJv6M01UvSF1Vgcs6vQGhg6csrns4G7GvJ?=
 =?us-ascii?Q?suomdfA1mVPfirPFEg1Bu274Swx+Ap/IHUQ8bejykU9hp7mjfG7r5hOHJKw7?=
 =?us-ascii?Q?tzbOWavWRJ/f51+P0DcxlXgVs4qrPoUqIXEcZ6cK3IxFATNk+zAWNibqiEer?=
 =?us-ascii?Q?2+fW7KHOjlItOM0Rg/FqIjWBAZ2vgrrCgEtbzuCMfjgcEgcC0Ed80v9rix2m?=
 =?us-ascii?Q?QNajU0jX33cssEiXb4Se7BuhjqFDkX/LqmBgR+k8muzsqib+zF8ES6prmpZW?=
 =?us-ascii?Q?E6zK7CCEN8FENwsMB/LHm65+x1Dpozd/vllwuPuuvgPANasBmAn6yNq/mZcH?=
 =?us-ascii?Q?XQux1ousJM5frRwQG0anx/ltjuANZPStS723JGxR6+8AauUVSBalrYL0C3j9?=
 =?us-ascii?Q?nrYq4aLBEfKy8WNkHHtnx742OwtjKfk1fsIvLe4Odc1pqVCzbAXdJflbHedL?=
 =?us-ascii?Q?/52UOQXAjhi8CtW/DnUVFrcRYrwdvSCzbT03PSv7jTVe+uaSog4F7uiiA6gM?=
 =?us-ascii?Q?6Vx67INKZ8vzuwF9z1zkw4X2KakmfyVcEKUtoHgQCn8iSs6Cvx+f/7CxMA2i?=
 =?us-ascii?Q?Ua+H/eofpdDfWX5L5Tha8qb9HglXVKx9E7r1MscjyMqyebC6lkITVPy4bh7O?=
 =?us-ascii?Q?oy0V6WuPhYQ69UDmzFm55Nem34XM3kZB55U1rwx3znYlZ9AO03y3hDCUEs2A?=
 =?us-ascii?Q?0foCt6Gr48R4jGlD+srIPJvadltzG4vWfFcX4zs06rEP4I0gxUfZW/o0scIX?=
 =?us-ascii?Q?fKLyf/7LR5k0B+CAJaVSnQYrVc7PS3gDc0Y577YHJHeToorQ2uu4tfP7KZWG?=
 =?us-ascii?Q?ODhAvV+LyykUm/1RGpVuB9In8x41pqBp+U5+6o9Wu06O1413ZDnKBwSiJtAe?=
 =?us-ascii?Q?+DlHyMidpn6ituFlYOq/qhiuvlVnf/nPpUTqV2NCJPNCfHKePKpnFiWzwdiX?=
 =?us-ascii?Q?EgBNL9/DcZHRUUeHgum84iCdDyrhB+S1AglgY6TdAwSakvhiWaswF4cTn+WH?=
 =?us-ascii?Q?9I/3rXSlP+KHIrnJF0QL/adQdvq54/nxzjqVz+Fu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a7b67b-8493-4e1b-ac0b-08ddeb852091
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:31:56.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhcI36NHWWsNfSADptyiHqhowxEqEzaDxU5t7FMMi8/EP0r5MfmVzjORBLauhjsf/Chb6FW066gP/mxeAfAPmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9757

Hi Oliver,

Is this mail been missed?

On Thu, Aug 21, 2025 at 11:00:46AM +0800, Xu Yang wrote:
> On Mon, Aug 18, 2025 at 11:04:55AM +0200, Oliver Neukum wrote:
> > On 8/18/25 09:57, Xu Yang wrote:
> > 
> > > --- a/drivers/net/usb/usbnet.c
> > > +++ b/drivers/net/usb/usbnet.c
> > > @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
> > >   	pm = usb_autopm_get_interface(dev->intf);
> > 
> > This needs to fail ...
> 
> It returns 0, so "pm = 0" here which means it succeed.
> 
> > 
> > >   	/* allow minidriver to stop correctly (wireless devices to turn off
> > >   	 * radio etc) */
> > > -	if (info->stop) {
> > > +	if (info->stop && !dev->suspend_count) {
> > 
> > ... for !dev->suspend_count to be false
> 
> The suspend_count won't go to 0 because there is no chance to call
> usbnet_resume() if the USB device is physically disconnected from the 
> USB port during system suspend.
> 
> > 
> > >   		retval = info->stop(dev);
> > >   		if (retval < 0)
> > >   			netif_info(dev, ifdown, dev->net,
> > 
> > In other words, this means that the driver has insufficient
> > error handling in this method. This needs to be fixed and it
> > needs to be fixed explicitly. We do not hide error handling.
> 
> Do you mean info->stop() should be called and return error code if something
> is wrong?

Do you mean this way? Or do you have any other suggestions?

Thanks,
Xu Yang

> 
> > 
> > Please use a literal "if (pm < 0)" to skip the parts we need to skip
> > if the resumption fails.
> 
> pm = 0 here.
> 
> Thanks,
> Xu Yang
> 
> > 
> > 	Regards
> > 		Oliver
> > 
> > NACKED-BY: Oliver Neukum <oneukum@suse.com>

