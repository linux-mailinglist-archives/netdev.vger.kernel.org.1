Return-Path: <netdev+bounces-88043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FC8A56F2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3651C20CAB
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3E7F490;
	Mon, 15 Apr 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9VszjMO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497E7F495
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196926; cv=fail; b=a7ORihlnDsMnoLkeVQGevc6GsL6uPGWhMEP4QGbjyakoe49o9f7MdryqU59AWwopmX0c91ZMA0hjX8srEu1BxHiooocvJhQT8WzFnicNUmlyHuOFOVoydJSnTpbyLrNv6u5mPV87FYw/3FXeu3GUl0yzNV9qp5pjTWSmv7BgvoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196926; c=relaxed/simple;
	bh=xnh/0y7YpK/bbOs9WJ1safYWgKFMPIO2K1qgyvy19vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZaCmRGRarM8Yr+iz+FH1yJmzJoqOuKT6TBHx0N/D+R/SKXEugKFToMvTIkblgpnp6KIsA9PEvCahdFstW+K4klwojY0htEY3YJHSTjsKO6qZIY0fjRhDESKNG9V4Gv75HBw6g1h3gbj0PEP05N7c/vN7ioPwUvSKsUbi52m6Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y9VszjMO; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7yVoO+J2PSlR74Fgz/n4hoFkh3gTV6bvn+nlb9fEb4c1Dhq+B5Oo+G5GRAoWyVn3dvMfmVOJp9PF5nFcJ5P/HYufXd7lSD8iX2tgKw+G/Bh6CVcJhirosIcqC56Iy1SfPTrlDHpagyP8UOe1S40WMyHB2VSm30CFLcpiuHj5mHJIUZaWw+xQmEoDcglni/vpgEiB3JJgYj6SUzNdED0TB8KgwrvE0kBMFelrnEEJgRJYg39jia/C2vfne0ns3vba0e02eGzFGeH3FBF0FsDp+dakqWekXzSmc1lJRdWQRm84yl7mGV2JG2IZE9eoTmcbiMbnEx5JSzF+EtFAUzjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErTNaZWBwmenEQGnJfSAT7xTKzzov/aVir94HzqZD6g=;
 b=fj4TBhM9VnmX1CrNoFZLvW3SSdRR8fYEtZfHP63nGPS+K2/m0Umy190so79KyM9cZJ8aYcuQwOiT+1inONpIB9nNN3LJ5jVS0KccudSy0Dm6p97cYHwtBf0OqF67WxKPVy0vf30TzfL16OuuOdrSZktKntIsAWJttpuGpEIDSukM89h/GTXVOt6xZYaB/0QkjgpJUcjTzxIO7dMvAySvik70QfWIpLTzTotHBT6WEfSmUXNmNvmSuq5eMNMw3n9aXTr01hkSRqhBHyjydEPeKsghLMeXukErA/GZDcV2RBQnV4mEyC6zl9OPCQXuFyAELfPQDMGr6kA5CFhqNVB01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErTNaZWBwmenEQGnJfSAT7xTKzzov/aVir94HzqZD6g=;
 b=Y9VszjMOyi8T8iqHFSYnfoIgyh2wSbFnHu/Dguab/VogI99zSPa4ob34gqLYYRkzNhekhTn3j9dr7857cUDcxj3I7v74+UnbkqJQ8vnNEie2QpOWvC0g8AE/FnZuby3rYiTVox+bK+3qIg9VVT6mU9yRI4arMtTMMy7SnFOFsTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 16:01:57 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 16:01:54 +0000
Date: Mon, 15 Apr 2024 19:01:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <20240415160150.yejcazpjqvn7vhxu@skbuf>
References: <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <E1rvIcO-006bQQ-Md@rmk-PC.armlinux.org.uk>
 <20240415103453.drozvtf7tnwtpiht@skbuf>
 <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk>
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|GV1PR04MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f404f2f-fb8b-4b54-862d-08dc5d655e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ZxFYCXrmZs0Zkh58Db9oFjP1TQ1X9LlSt6oDc6wLVOS6QygNi3MtUzV3WYLOrvyzR99O2RtTtrDlJh48Ts5HoFaHnUkE6bL5mnWUoq9hH2Li782lPFYq6tu43K7W8/tLAyOtLTrAuOfbsyjONVcinzG86+uQ8GmjvD4zWbpTz4v9ABxq3/FjHnnDZplU1Hvclb7PFproKZeNKiaI7RTBc5FVwvAHMZlC+5mFXFx1QbXzfAAkFzFSsAVO39h+AMq+pzyDnngEwNWCpCCeu3zPnT2BfchUdaaraN9OXSTrkGggNSKtH5ZzcY6a/JuoMtZAVKzzFlNy51aWiu27oj+/yG6p3rAOoZ9+IQleCXw9gnxQ3GwlwuxqhQuV3TSkPe3grkxTTC3C6XP/XSuQdYWaseYWOs/aiodhz2QsaPrhEKRDatZcr46pW8gwi+jWFg3JKsE7B02NaJ9NTRSRjXSNjOxRvFkPIS3wBEZ3YMnuRe9CFHiSlTduIf61B6oV88latfm2L1eVvDGGFk76+wYYt8ajyHlQE7TgPIabn6pIbKUVXjqrEOj56KoIZ5LT76ulu18fY+acrHDvxGwRLexvYJL0ErlYhYpnueRQdNyPhDcDK3btSs77UI2Q18IXR8x9oN6fvw/fhdk3MrT9RXJeSORHlEaw8Iu0cr/cywAjXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RNfCj0CrAaAcJ8c+leKHhr/+j6PUEPb/6t4Wns9DGy/M4Gy9h6gUjHKD8I0?=
 =?us-ascii?Q?wcQPgUQfNDTpQJB5dA+/la7BQUOj3WQ90RVKRvrImqTu5QK+J72h0Nyqr9Vl?=
 =?us-ascii?Q?QqIl6k3UhurZuGcYMkPUgvLHqIFAQEgUzLuzvkIxw6ChLVpg83ZoTh2qBVYS?=
 =?us-ascii?Q?VA12D0Fyluf3yD6NnBCofeBpGnLvZG4IQUJ+CtQfHKy6jpn0+QGaP6brN1pd?=
 =?us-ascii?Q?cZZrOZojuarenKrhBnuut/GlqN0kjUZ7B7JFfNCmArtY7g54KlYPsoB7BMMo?=
 =?us-ascii?Q?XxKSuzpibUKFTNfODXnKDx3W2gb5B1xvvMbbk6/ZvC4f+f91ULJjc8FGYqYA?=
 =?us-ascii?Q?ERGK/kE6oHbg64IrG1joY6S4E48GZWP0PJCdgXPM+BhkwOOgoKrhc1T88+q2?=
 =?us-ascii?Q?c2zfrXoqPQzYLQ3rlfwlqfU1vkUCizHbIKSq/ySKUT9E4sy20DGupKNqfmRY?=
 =?us-ascii?Q?pvUeNnuvm+dZuFz+//06J+tWQ88XDoPYB9NhXk5kwmWHPiuzli4MqyNQjDMH?=
 =?us-ascii?Q?HtYdNTasJzvOAoXCAHqL32htxa07rTlxMn9icbcgt1th+QNtdXUlpXxJWNPv?=
 =?us-ascii?Q?BZ63ydZCrn6zAd7JhKwP08gCpKbS2NYtzxoYOPo8m4zylknlJJGQqT/E52xh?=
 =?us-ascii?Q?F5Kjiw1W46eCVDM1cNdJ9y5VUemvR71sREoQAMYASV4t56u1u1HdSew1SaEQ?=
 =?us-ascii?Q?yQvzxqV/258tbYt0OR1M2mAkpHNtrXpVJr048QwTsga4Yg13P7in6TeIORsE?=
 =?us-ascii?Q?lLxTv5hYiJPkMG4K8V7uFCuUuhjwOkDoASb1RXMzdLJZyKmGFYjf21qybyvB?=
 =?us-ascii?Q?86XaUklEjFsZr4NyIVbfcLfsmVMacM/ApESaizlAg2t4UT42z7OmXFeZxdfG?=
 =?us-ascii?Q?ojjMSjuf+VI/9tt0TbU9M58TVO0tcKoz9jgXxG527F+LVtKXyzwAsXXCZ+44?=
 =?us-ascii?Q?tUS/J4J+BIjAjgTajKL4NchWsjxp7q7rosvV4FgMqmAmBoKnQ9dAOyvXfWgo?=
 =?us-ascii?Q?8CdLW7T0EegPzKFYO9e+1b3K4X4MiiLDO7TxfyWqKNyF8PyGYy+W/gRyJ0Mk?=
 =?us-ascii?Q?gcJ4/LVUhI5VYlRHX4M8Kkg2Hbu8cbFORf+aVegNMI5Ebq0DL+LIemy8RH9o?=
 =?us-ascii?Q?hkHNM2H1Rp+YQpKUlWM2Dc4tEGwkkN2BFn5AP0NRIEvy/WaR6SQ/d3ey0wsk?=
 =?us-ascii?Q?pUdq+DRebHDprpB3unvF0TGZ/+/+Xs28JFVQbc/5qfjMVboNNTgHBAo1JrQD?=
 =?us-ascii?Q?vKag89TvKIPD38NcQQg0TDRtci39CocpOBZs1Bs4092qDNMiGAkf0MvwjcPH?=
 =?us-ascii?Q?T44ktCmKSlkuzDSK1F71y6RV16EudJT8zJr1wjuSiRn6XKlCphZ0ladsuxDf?=
 =?us-ascii?Q?MfNqVtXhHIg0KsVouult9lFBTdY8n3YJbjokZKBTEWDeE/84V/rEhbrBWOCy?=
 =?us-ascii?Q?m79QafOlsl9UYvjrZu66kcxabZ9IPWTmDWOftl5Gkdkg4rysTLCM9fyV5xaH?=
 =?us-ascii?Q?JbhPLLT0XYx64ecmlfiyOFlmCh1X99vEWi3gpEYnwPGKxACBUwZFUD90aVkM?=
 =?us-ascii?Q?Y5uuLSrn0WnKc9FvjGDnAQ7mTcfn15e7Zo2wVK8iEnpiZVArM5SqwkKHpd2L?=
 =?us-ascii?Q?fu9sSC0GOA5xocTU4svDqsc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f404f2f-fb8b-4b54-862d-08dc5d655e7b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 16:01:54.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1/V2txkx2fS8Cin8V6GRO1fEXhTR0GhhlftRK9LH0ea2SE0YDroUcRRi2mSpUwxsmtuyAyDP94AjXTo4hLHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214

On Mon, Apr 15, 2024 at 04:24:45PM +0100, Russell King (Oracle) wrote:
> Looking at these three, isn't there good reason to merge the allocation
> and initialisation of struct dsa_switch together in all three drivers?
> All three are basically doing the same thing:
> 
> felix_vsc9959.c:
>         ds->dev = &pdev->dev;
>         ds->num_ports = felix->info->num_ports;
>         ds->num_tx_queues = felix->info->num_tx_queues;
>         ds->ops = &felix_switch_ops;
>         ds->priv = ocelot;
>         felix->ds = ds;
> 
> ocelot_ext.c:
>         ds->dev = dev;
>         ds->num_ports = felix->info->num_ports;
>         ds->num_tx_queues = felix->info->num_tx_queues;
>         ds->ops = &felix_switch_ops;
>         ds->priv = ocelot;
>         felix->ds = ds;
> 
> seville_vsc9953.c:
>         ds->dev = &pdev->dev;
>         ds->num_ports = felix->info->num_ports;
>         ds->ops = &felix_switch_ops;
>         ds->priv = ocelot;
>         felix->ds = ds;

Yes, there is :)

If dev_set_drvdata() were to be used instead of platform_set_drvdata()/
pci_set_drvdata(), there's room for even more common code.

> Also, I note that felix->info->num_tx_queues on seville_vsc9953.c
> is set to OCELOT_NUM_TC, which is defined to be 8, and is the same
> value for ocelot_ext and felix_vsc9959. Presumably this unintentionally
> missing from seville_vsc9953.c... because why initialise a private
> struct member to a non-zero value and then not use it.
> 
> An alternative would be to initialise .num_tx_queues in seville_vsc9953.c
> to zero.

It makes me wonder why felix->info->num_tx_queues even exists...

It was introduced by commit de143c0e274b ("net: dsa: felix: Configure
Time-Aware Scheduler via taprio offload") at a time when vsc9959
(LS1028A) was the only switch supported by the driver. It seems
unnecessary.

8 traffic classes, and 1 queue per traffic class, is a common
architectural feature of all switches in the family. So they could all
just set OCELOT_NUM_TC in the common allocation function and be fine
(and remove felix->info->num_tx_queues).

When num_tx_queues=0, this is implicitly converted to 1 by dsa_user_create(),
and this is good enough for basic operation for a switch port. The tc
qdisc offload layer works with netdev TX queues, so for QoS offload we
need to pretend we have multiple TX queues. The VSC9953, like ocelot_ext,
doesn't export QoS offload, so it doesn't really matter. But we can
definitely set num_tx_queues=8 for all switches.

> If we had common code doing this initialisation, then it wouldn't be
> missed... and neither would have _this_ addition of the phylink MAC
> ops missed the other two drivers - so I think that's something which
> should be done as a matter of course - and thus there will be no need
> to export these two data structures, just an initialisation (and
> destruction) function. I don't think we would even need the destruction
> function if we used devm_kzalloc().
> 
> Good idea?

Looking again at the driver, I see it's not very consistent in its use of
devres... It is used elsewhere, including in felix_pci_probe() itself:
devm_request_threaded_irq().

Yes, I think the use of devres here would be an improvement.

Note that felix_pci_probe() will still have to call pci_disable_device()
on the error teardown path.

For even more consistency, it would be great if the error teardown
labels were called after what they do, rather than after the path that
triggered them. Example:
- goto err_pci_enable -> goto out
- goto err_alloc_felix -> goto out_pci_disable

