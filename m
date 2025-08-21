Return-Path: <netdev+bounces-215475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE40B2EBAB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51988725D69
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885C2D5C67;
	Thu, 21 Aug 2025 03:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aTHy6NnC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75802D5400;
	Thu, 21 Aug 2025 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745614; cv=fail; b=b1M1Z73hLbrjxryOZKpR/4ut/K1kIWUGlXa8CTqonNPfEvkr4hvSHzSbijDcR3ayAh1frCV+OqVhTOvLF9HAQz4AB9ivrHrxlsC0/iKw0r+UeFztH1WjC+ZkkkN9hYIhs1xqpv/Bj0Obdqy2xqwikxBjqzkd4uwrBh5CN4uBa7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745614; c=relaxed/simple;
	bh=MpRfK6RvkZ5ef1OTBDER7Drl5skYsEklsHb9pOOMqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfblz19StnwVNr5SWh1sQRIV8o2PnGycgMAgVOWTNyfPTj17KSUiBt7zN3vU2Up6Bf6SUzIwAflUDAGk+tJB9ScexNwTGESa5FTwGzVP8OxBQB5cSww9XstUkAaycFgq5dSObH9grt7z19I72Cw0tUNU0M0Xj4R1t30wdzHi0ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aTHy6NnC; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pidt3kUqqnWCN2m7wQ331KtG4jX/dhBWj/q8a1qgaV3jbMmUPEYM2C65aLJ/5cUrNT3vPWhe5bxmBTPcnsuHIXxqsWG/wi7XtPXE0wVpmAaMgN3TZjd7F/TsBKen4F5jOhp3bm3Yhg/Xjej1/0SyX87OCUkKn+uRnp90Xnhk1dz2uFuOPwDsrUg5RFKVPindrwntNBHqkxrOvEHIeQfKNBGXyVImLOIQ7iKH0OYs1rv2scDgFuRr3IV+IFPWcEjNbqPxQAOwfQDz37Ia4+zYdVwEKQEhPUSo275fXn8zYrGvDYe+5FbpSxziNMMX5t42u4l53nMQgnxFAwe9FKnFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjFPT8M5Z6N2M4ITLWRCB/DFaO3TDWlg+KhhtUyvouc=;
 b=IsjuCGFoGEUzCcK3eFqjCs+SklR0IDmvSde/hJSttGkTUjCJGHw3WBcFFwTBFJox0qhMuX6uNf2JrQ+bC7nyJ0+o9R5B4hejNn1nhuWissgSVcXQ+WrxhKsStU9+4l7f171OxoePB1KBbizOEJHg7n6m0ySv0wb1ZPrrLPWNZx2X+0uGliVHnsFyllPqzpB+lLP4RGjtH6FQoXvr448OO9Y8vui8zPcYNtTJH7oUgbqwCIt1APOhWSkSZQjBXJoomIy3wioA5Fo9DE/pBUbQfI/k8RHyeEkZdn4tsSvpbAutFInMkCmkpLfgG6NB90aG83gYQ5ASUky4R7PJp6ZpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjFPT8M5Z6N2M4ITLWRCB/DFaO3TDWlg+KhhtUyvouc=;
 b=aTHy6NnCpFlCKyqgGd77k2Ksj10Z+wUy5thlRyQTFPe9UfqYcERdh4QJ6nbWy2mKGugA62PSgbmDTdbeL/D3umIib5wjd3/nInXmogJkqmklvVXc0KMuBGbT0ZMu4mqgnJT93nWuPrCceXlpcVmhbvHC8d8hu4rMf4rwdnFpwpM2veOjOPWRiwh2BZm0TEnsPdFtwhAwYqKWeMjzskzkrDdZjAJTU6WGlTGr6QD9W0bw87jqkImapb5rBEmMiRRH5qtA+w8tPAX0HKz5UCnYNGtexTOUnAsAUrCNE5FwVdfXVsGyOougjqjYPKROt9g9lEuQzfmD1mAqj8acG697EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Thu, 21 Aug
 2025 03:06:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:06:17 +0000
Date: Thu, 21 Aug 2025 11:00:46 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: usbnet: skip info->stop() callback if suspend_count
 is not 0
Message-ID: <ajje6wfqyyqocpx2nm6nmw3quubmg5l3zhuxv7ds2444hykgy5@xbi7uttxghv2>
References: <20250818075722.2575543-1-xu.yang_2@nxp.com>
 <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663e2978-8e89-4af4-bc1f-ebbcb2c57b1c@suse.com>
X-ClientProxiedBy: AM0PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:208:136::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: d989cd89-0250-4fb4-781b-08dde05fb219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNInj1HMXBaUCLieKEcO2qU95wgEeZQfhELSGSDOlXP2QvWucYfLs0rxBSC4?=
 =?us-ascii?Q?zcwiPXXeyBWoe7KLMbAnPtlarJcerzzNY2PqRphw5SfESTR1nTeY2AfNPCWD?=
 =?us-ascii?Q?NFD2Mxpa9UGoSjZtvXUs6EepJm0BbojZqbzLlqIR5KMutB6Zug3Wn46Vsuze?=
 =?us-ascii?Q?A07Wi1vBoGCU3Mpj28c7wjSzHVn+Hbx9NwDdxvfw+Z/QiqAUA0xbDHWY9AxN?=
 =?us-ascii?Q?Er7+j6vof3Vf26eg0ubqDHdHyMRaSX5fiL8hVZ5ZaP82rpgumcwNhpDQ9TBy?=
 =?us-ascii?Q?kz7znWMkplSwjrmG/jm3F/Nj5IRAjzfdMuRnpoqD7+y1M3NQ5uni/7p/GXVv?=
 =?us-ascii?Q?++WidT827M2DukyLst6ec8LnVxDs8VIkt0g50sMuJdcjbglYOfLZiHMEeieP?=
 =?us-ascii?Q?jP/WX1B3b2hs80XhDYQfmN/i9ZGCL67ezo5hia5uJHsLZlEB1lxuA1QJVR1r?=
 =?us-ascii?Q?UGQIkVd3CGTgP4cDJPYuLNCtCWJeQYNrg9ltPmTs178mOTEFwko07qTk9cFh?=
 =?us-ascii?Q?J62bAf7q5Bwh/oKZqy2a5ttroKfLCP1e+qEA0Ls/sDgZaB7kNfvCl9NnpmJL?=
 =?us-ascii?Q?oLqwDEyROby/xM9k16nFk48evHO3kjhI964Zax/+svfA9X96OLNClLzlWfhx?=
 =?us-ascii?Q?JSsGMfAkrZVO1NY3oUds/pXMLHVjWerFBwoo6TEP58C60nQ0VXZYeCogKihg?=
 =?us-ascii?Q?QZZHgcFm9zSL0uhQKeZ7f3MLzTKIPneD9fKj9DnOXHyxgzjJIW3jXauMQNC/?=
 =?us-ascii?Q?TFpPRlRSTF1WDl550CxxwIeaU0p96w4FcUtaYVk646l8ORy/cbu1SihXLzLN?=
 =?us-ascii?Q?U/zIGnXQh78+ggKpkFigCB7Ij0aXJ2hfuKayrJETtse6SugVSulYYFeb+uY0?=
 =?us-ascii?Q?h+y++TyylMYMrwpx8HLE+V1SCswH6sZjUFU2GZsAPG3TpvB7puGzaLnlgoHw?=
 =?us-ascii?Q?9tsIIOJpJJTRuDEn1qF1PPkW0oJ/7bt8V29VurjIXXd461gly/xW7TvaEpPF?=
 =?us-ascii?Q?D5XAyE9PWCOV6+pznXmJskT6MQYo5h9nbvipX4U82gny5ZkwMrUMlje0ZZ6S?=
 =?us-ascii?Q?WqFCuKK0EWyVKSgku0StjsV8hF/Ql86XHpScexVkBe8B3b2g2tz0cReRRwWA?=
 =?us-ascii?Q?Xq/Avd4h0+Ty9Mi/ntdm4zX64MwG+pI8zIiN6qYWnu/wNy/wfvw0IJVNxUmL?=
 =?us-ascii?Q?eoarUdxsqcFG9P82rrGSRC87BqWJma9FRs1S+MkTJ9QY99RuL6OHYD07or3u?=
 =?us-ascii?Q?/N+SFUmUWoXB+daGx14m1GodmbKYpQAgY6Hdnt7BDhviXP0sMoz2vvRRAR9J?=
 =?us-ascii?Q?Mf81CDYN1qMHMvBaP6+DJtqYhqXFYrOCJien9++01RLv8J3PeT1n60IuBqb7?=
 =?us-ascii?Q?LGduFTmgFUgkbPuPJVyFK1/miL+xEivdufJg448LppORiEQ7MNRA7bKNBqdN?=
 =?us-ascii?Q?7DNa9mXe6aO8VTf9AddD8PI/zn64AoxACDOr51X0OXSxrzcogMdTMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+N5D3kuzGw1psthkbHdiFX0F5PWpk1VyvP81X07a2WX9vLN9I5dpTfzgpnuS?=
 =?us-ascii?Q?+nExFB2C7ku52JxEBy5zlDVQU+xV21OjpHihdVTlaS3dQtmb21oXQdwmXgs4?=
 =?us-ascii?Q?aheM4R52a/cNDzAk4asDVbY1QEYDJ8imhdKrkBG2GAWgrFG/FxQ3wVsrI0j7?=
 =?us-ascii?Q?JCPJcret9cH3KnRTazGTsKAIGsFDRnB6NqwPXIJVPDiyQFZsSqUGol2s390d?=
 =?us-ascii?Q?YgfcWz1O5ncS09TLWrJcnCXCPaaK3TbA+jafEoVptXT8DKkfIrBTHcg0Y53M?=
 =?us-ascii?Q?pdu4VAgsTdPlorQLv6ywSOB6Pn4G7oSVri7KnQgRNrJuRQQjtQgkxbcwNp7n?=
 =?us-ascii?Q?vEaxGHlrMAYRRsh9dcZP3z87JJBzM1pCeVGVi3dDhEb+mRqWlV0J4LVKA9jQ?=
 =?us-ascii?Q?LpSWmumFE4Z/rXR4QpkSEykah8FfZE1t9gzt1pT594g4DyJPWMWXJh5Qc+iP?=
 =?us-ascii?Q?xfixB0h3+UOXVUSpryqxohEZ94r9cGllAsDuaPQ8u7EkgzwOpZK+a6T1vxUy?=
 =?us-ascii?Q?IOGhD0vnyVKOYmNb0Zt/day+GB2d6vJS0QxJkCOLID2IqhIfSRcHJDVA6zCR?=
 =?us-ascii?Q?lQmuuzik9sr8dpWAxJUUKgH1rjgFtPqM10PB6BVGOcj8eqP9Ys0yph40fTtb?=
 =?us-ascii?Q?golpE6YTXM3p3w6F2khlRSE8llZT8W/OeSouTM3m/D2s+QSIwZHbSDyfAPLL?=
 =?us-ascii?Q?26bqY6PTE2I3l9qMtb2sioJ371XzTi4Tvu4+sQ3Rs+7LoQD4f7vsotehXknb?=
 =?us-ascii?Q?8NCXRGdyNJSOzV5U2I/ahnItrnJt6uldhs8pSvafssH7kkj4gROueZENGZ22?=
 =?us-ascii?Q?AOhtpVDfb9Fb/ehVfgVdKLKbHD8MOPxWEbEC24im+vTfC01mKWQ3/Ss+IorJ?=
 =?us-ascii?Q?Kiy8d3P9ctvI42YRqK9uAQYN5P3tBXWEhGmchpcPuaWIyX9yvM8h6TmRIe/+?=
 =?us-ascii?Q?RH0c7COYh0nATBJ4Nb5L79PDkAMGTz5dQcppo29E8KxiFaDU9k45MZoNoF9Y?=
 =?us-ascii?Q?9OwfuTV3YINj0lUmh8jlTb9InDq4X7Js3qjSsVuBFoe/K5yeCa4fsZgYGStR?=
 =?us-ascii?Q?cHUpl0E2mtgahFxzgBE4o81Vzvydza7spAZvzYBm0dk8tyBwBhujytx7ec62?=
 =?us-ascii?Q?GUhRCMCubmekOowyFnQvOHGxeAYBEO8uIiw3Pnrlw4E/GbuIzOHs85ukY4Bn?=
 =?us-ascii?Q?smsxcekCfwmdPthwv1TyiK0hBQi3DaDKDWUwXnBfVob25p/MzEpTLtKSIBC2?=
 =?us-ascii?Q?ipUA7eUZor51MDZEP1UqjDohZGKmHQgn7eNLSTr7DU+x3dCVFryuDL9KshLB?=
 =?us-ascii?Q?py8bXYQ5Jb23HgcMRQnuiLf7yVZui5EAAqG4Vlb/aZwlYugNnO21hyEaIHbU?=
 =?us-ascii?Q?iN8aNYQyCfL8kYDsyLk6dQVVTMEcgUXbZygeFaQzSwalua+TQpFHIU8v3QE7?=
 =?us-ascii?Q?tiVeVN7Yvz9fvPhFdrkbgvdSGmkpvbcFagJY5LBfi6LwXq2wI6MBO8NrkXX+?=
 =?us-ascii?Q?tU71S05bqsMeb0BMpTGdNvDMaulUwbKzYChMnQs6WbmOZ41+ejwhK9F08qKX?=
 =?us-ascii?Q?sGv5/Zv/57dxC+8uEmd126jmDarMfLhbP17VzkDy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d989cd89-0250-4fb4-781b-08dde05fb219
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 03:06:17.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dGIfZHFbRaatgmWjjrbzszdsEaoMyvLr3yInRlFljQDvJiMd1FMdExQf6sCp9BB8jtmJg9oboG8CGAwBOkqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978

On Mon, Aug 18, 2025 at 11:04:55AM +0200, Oliver Neukum wrote:
> On 8/18/25 09:57, Xu Yang wrote:
> 
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
> >   	pm = usb_autopm_get_interface(dev->intf);
> 
> This needs to fail ...

It returns 0, so "pm = 0" here which means it succeed.

> 
> >   	/* allow minidriver to stop correctly (wireless devices to turn off
> >   	 * radio etc) */
> > -	if (info->stop) {
> > +	if (info->stop && !dev->suspend_count) {
> 
> ... for !dev->suspend_count to be false

The suspend_count won't go to 0 because there is no chance to call
usbnet_resume() if the USB device is physically disconnected from the 
USB port during system suspend.

> 
> >   		retval = info->stop(dev);
> >   		if (retval < 0)
> >   			netif_info(dev, ifdown, dev->net,
> 
> In other words, this means that the driver has insufficient
> error handling in this method. This needs to be fixed and it
> needs to be fixed explicitly. We do not hide error handling.

Do you mean info->stop() should be called and return error code if something
is wrong?

> 
> Please use a literal "if (pm < 0)" to skip the parts we need to skip
> if the resumption fails.

pm = 0 here.

Thanks,
Xu Yang

> 
> 	Regards
> 		Oliver
> 
> NACKED-BY: Oliver Neukum <oneukum@suse.com>

