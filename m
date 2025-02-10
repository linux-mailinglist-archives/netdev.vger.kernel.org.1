Return-Path: <netdev+bounces-164570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD51AA2E451
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DF3A45AC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA00199237;
	Mon, 10 Feb 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7Ks1RkC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB2134BD;
	Mon, 10 Feb 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170126; cv=fail; b=HToWdqiGSAMyDd/Adql9+tMP6NkXwuNu1lkYw36KktkjqmO2t7ZHrmS++6A/5ZVMpJ28dotKyWIWTaCPuLJRfRg/vo42Ngoi2xWd27N9ixCJVbdqleLHUXGpcbFUcJKMYvACHXAoWUte7uherbBWeUD8IUakdPQgkMDLtJXP/SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170126; c=relaxed/simple;
	bh=G9FqypnUUT+f9kerBppRCWFP5gmdmP9Qoe/8tDYdf4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abBFbEfCzTHO3HmD6eO4jQ/TeqZ88kE7WbUMidqfd0B+ZTptV9cESts5+jCimuiaog2h1nt/Bgx62U3tgARDwLs7qbaxwDpBqgZNW/IffqFWnxEv1BCQJnBEFDHQXGsKHKUm/XuFoSbO1PuC7yqgSuuY17Gj4q+ySqO/I5IAt24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7Ks1RkC; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6VxOhchp/ETiue4rBQZ21bwISly7OxFaqiv/85UtflRQQZikq/EK6XyxRuWhjK/2MR2c9yPOVUjRvLGcBEit6UirgildwqfaNHfinQLvuDW0JUuvNeXa3pNjFHXoCQVFax0AHXhpGsTw7bN5MtHuW7XhflQfvmiHlweGBeKjvkh9eBbeqQFAbKWCybATHdB6WPO+Zw9H0yv5UIL309hZDDzrpdOdyTm97Y0F2PTmpM9/jZQw9EaokbULav87hNtA0uVYx8mI8Gvg5nm46aCYzbM/sWc6CPZYC8xQCyTwZ/W0qwBx6FaDUxA9dmTDVgnQAXILy5p19FV/PhQyDMEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP0QLnsRoCEjmYmS5ZcEU8SpzNo7kXIaEEqVCFY3C8E=;
 b=uYituHiJ5wMT440qo1cLNqbvbhKnUbPS1KmLHMeBXAymbPqCTz/4Ngk2fEKImpeHNqz71mF9n8EAqUv4DKozh+/gpoZHlUyhqesA8bPh3AHzcg0RgWVWDqPzqzPY8d56Twp4cA3uRJXD5Q8yAUfnP7BVQikizN+sgGv2m7LPYFpdDbAVLeB6c3Ipfr9Z7Zr+wVWXcuQsQtIfEcIguYVbwoOVe8tOquB5a7tPY30LbELE+QfwyNgJUZ6SjuBU+k/hXptiU7Jo4EypivwGZWYJEUCKieZBR2lqJ3OcwSQjYah9TVvQIUZv0o/609CxR1TZOfqumAMWhxDxRWSS8c7FKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP0QLnsRoCEjmYmS5ZcEU8SpzNo7kXIaEEqVCFY3C8E=;
 b=r7Ks1RkCpU8qDhdfhXpCHZZ0s2vseXPgsxUvA1UHClfe31uLmPkXYRgqSRXBt7va4QrEcErNk5y6x2kmYoE8t03jgOZ+E3XazpfLcLjXBgs7GQol8LTx42YtTiZXotZyDI+HjjeIBYl5K3JtLsCeaNEsjQJUCeCArTjUDHdd13m/13bZIicHMOPePaJ8NmFUrSD733iNv3LXi1ZB/2JSu9AnTss32rHFmwolFjeY9NIEankT2FDQqOHpLCnaZ7Gx5r1+eNbK0YcS4/sTBuXMzlraGoy5kxGpAha0CQe3Bj6LbwjVAwfCOqq72jZxjhiu/IZnuPpXzBmrk307XZhNNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 06:48:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 06:48:42 +0000
Date: Mon, 10 Feb 2025 08:48:32 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 net-next] net: mlxsw_sp: Use
 switchdev_handle_port_obj_add_foreign() for vxlan
Message-ID: <Z6mhQL-b58L5xkK4@shredder>
References: <20250208141518.191782-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208141518.191782-1-ericwouds@gmail.com>
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ee3bb0-30b0-40e1-6642-08dd499ef506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvDd4jp8IB3gYoYi1gyE1DzkleeJLd9xuvtMpA1kolQexEzAQ1tGUAXzLvx9?=
 =?us-ascii?Q?ToOB6QB6Jgw9zA0+ylcTSxPpxi/dIhWfx5mGheR5Oc653UuENapVg1MMfx/X?=
 =?us-ascii?Q?YmZO9I/WkA9VEryR3+/kCPTDGH1DnhTqKIPRnn5ddjGDuoCfOVMS5qixreQQ?=
 =?us-ascii?Q?q1WQomZAHmWJadnwH0RsoKsgU1bUTnhwYCRyGX68/Pca1DKHbom3Twmqi9Ha?=
 =?us-ascii?Q?y77SIvxzcSUzni5sJuqTSJeJpj69l26FsZ7LHt7X2072xKqoWGcAd7kflnRt?=
 =?us-ascii?Q?fB/+dIFTekP3mROg7xsoAG4W+ioYCPmRO2Znj5IlBNF0hWuBY9bQ5az3Duvg?=
 =?us-ascii?Q?w/T7tOr/bPe6K9wvpir3dJr7uGRPLDExUcTqfrFO2uJf++rcCUho/4aAOV/0?=
 =?us-ascii?Q?YvaPQHk33wnRMBjZt22XTXPueRXFsrESASoBs+yfTTxVK/ZLwIpLK4BsoE4o?=
 =?us-ascii?Q?wkjadaOe5uPPogBp9PryjBVTaGIpA+yCHqop3ZpJbBZjVZiacFCN7ZDrh+Rn?=
 =?us-ascii?Q?1tuXStql9R6ylUppTjovRgfgdgswn0cnXeJRw3NKmnVuJE7ZDRQUTDE3wB3j?=
 =?us-ascii?Q?AvlVYOvWhGs9vL7Tw7yipxEzg3ggVAeJcILXlWDCeig0YnR7jaTABKr1Sr/X?=
 =?us-ascii?Q?2Fwk6H9C0zIdL/V73kSpsR9OoSxJ/ZoZPtgMlQ56e5bIhRurnG9sbv5O3zn8?=
 =?us-ascii?Q?0AyHVctfRm0WX4mVq34u1RqfkPi35TuwipzQ6FV4iohADP15pXLcsmUXymf8?=
 =?us-ascii?Q?3B4+wYwdUiXERF0uUv5kSTqOZdjxESXcsIr7fvzivTd+6tGpdqStIO4zzpBP?=
 =?us-ascii?Q?KV6MopJ1FZmrtmSbsysmOTZqEQxNk9T2O6kP65xDo5mlD4QIFCZkslX1zwTc?=
 =?us-ascii?Q?vrRyGhppi4oppYZDHynejO/MUfbWScGeMxgNOxYW1h6mVUPWOe/XD9AiSudg?=
 =?us-ascii?Q?1J7csqnuApTcyceAzB56XnzRpdxglhHJo3SdUoFqF5K9W5ioQznCc3A/ylcS?=
 =?us-ascii?Q?ptZpgWateByiwYHKtnZSyZSRrk4uieCAOPWAhMHA+vf0qF9AjuGQDglpidYk?=
 =?us-ascii?Q?8vcRIcty8SsYta4jbD5WTKuMdRioBrFzPmTPO2Z+Ym380DN5Hywwc9cZEBh5?=
 =?us-ascii?Q?YguzTiUALb5iFdWEE9ggaT1oWpFCcZ3BVXO2WRgfc8BN2fEksRtfRsuRAbAL?=
 =?us-ascii?Q?J5g5rNfKatxDj8h/jF4bysMr1qvaKVW4Li9kAhhY9daaAaPhOgOcmPwb6w4r?=
 =?us-ascii?Q?c8vSnvvYXEVoKMePeCK+vRI2ZudRwWEtVl/CitwZmr9e8JbyIIpQkCbL27fl?=
 =?us-ascii?Q?gwIPXGJ4wXCvWVnkEjbwlSG9BACRxFDHcBFTk5hpJK6pIKKBpMfmVok8VQGc?=
 =?us-ascii?Q?bblam3SCZ/lng7PsyQKceISKJGPZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PoyzbkuqkKz4HUBiwbc6xGFC5PQb4nVkrga4zmN3ZmYlhWmyAcnBCPq/WPC?=
 =?us-ascii?Q?O2XjMiG38nXhFQL2GgO2QExqotrN9sXqCN8NucaeHM3IvwKLlUPeweEW8jIK?=
 =?us-ascii?Q?uImHlzGwfSkApPGTLY9/o3z4Dr3Q6Z3Z2Lgkh2aBJT8DXhGNczbbHKmzZ2IV?=
 =?us-ascii?Q?BzIfeNaCDMSs8cBAy5kZlYyTAWUkc7HpzzzYDcaaaF30UcWINhr9WF56kuqA?=
 =?us-ascii?Q?LhlpwSHrGyKtfqGDf61iihs3DkontMRTcqEGhS1hme7cB/kAHSOaps7+rh8O?=
 =?us-ascii?Q?MDiA1TrzFohGeKMWAxay1oME8Glr5eh7eLESzxbuZCCLWn19i46VZcviLALh?=
 =?us-ascii?Q?p3akZ9qUwBWvqGKJ/pOOOixx0d+4qgYXA2g69WX5PN3mDYooUr9eM1XmdLoa?=
 =?us-ascii?Q?MgvZ04D+E1Rj5gnp03LpLysmdB5xLvIZ9vNLQzfwUEYwkIPvcXyg1NZVnNjO?=
 =?us-ascii?Q?DjMKC5CiTjpRRxaUYG7rlT49xpuPL4/6S+aXQbCYFNSbiMuaKcgFvTFmOPhv?=
 =?us-ascii?Q?HdSh3RVSIYUs8RN6v9Ph9BKXChDisQ6cAuDiFRLXcDjiGKApesnoAysU+0K7?=
 =?us-ascii?Q?ryvZq2UHI2Bw20S+lNDeB44rkFiMVKkZG3SYHVkmUPSm31D48b0T+93U9r3u?=
 =?us-ascii?Q?SxnlT0Vm1RuA6LyraeApmH6jrk3PupXlBPVffjjCVS7fovyDwWlJ+lIVdBeR?=
 =?us-ascii?Q?xmLFU+rr4J+sE/MPadL/EGBOJnIhExy2zUd+vUXHl2hB6K4SPm10xliGleng?=
 =?us-ascii?Q?V/pfGOK6THCt3t/dWdD0BN5ByQOdnoWxeU0zeL/06V+6RKt+eTtz7sqMszSV?=
 =?us-ascii?Q?iDEu0VHHYNwLOjTFrpIx0ZY2B4GivT1HzKkDM7Lz8RtGvazk5eU5iVVZcYT/?=
 =?us-ascii?Q?mO9ZfZQ4dDXEt0cjtsBqRRHpnGK9HqUzozzqecoN/FMK4RDKoR4YzaaiStra?=
 =?us-ascii?Q?oS8dD+BeP3RQ+P7Ff4IrELYvBYRhdrz/tgxxV+dKuUosgBXw7X14yknegLY2?=
 =?us-ascii?Q?tEOG67dO76BZEAGN8taNsoccu8LJqpBP5SRzwOukaxXttfm6DZOfNWvqghCF?=
 =?us-ascii?Q?Ia98glEqQAEfNmTNNItSQJTsAm4Llm+L2SkBTMOWsMFk0mndvvjin0uSmxU6?=
 =?us-ascii?Q?k6xhc25jG7T9Qvwhq8OwFZJfji7j2Vz0DW0XGT8CLlTYTAeyrR+Xqn6/fKNe?=
 =?us-ascii?Q?NEdj2pn6P622ZVFMdwOhKyLfuV4fw5lPUQx9tGjz8gfKkpRed4LzW0haRAGe?=
 =?us-ascii?Q?RdFSDFHYcsE4BuzXtYf0MslaXPAUjWIXcc+oGrP7UnC56d0IkjNtAT6TgSjA?=
 =?us-ascii?Q?ylmgG8WAHsY181VSX6ygO9Rvhi/ysPzjW1LWSfmmd/Pg3RNWgrofoOpOP9Iq?=
 =?us-ascii?Q?36WjA63oX59jnAiJqrcIfSb9Z2TyxmX72jaWs5R9tfmTGz/SZZilnhnlez/e?=
 =?us-ascii?Q?fLHRfUAdqy0yTQ4X1ggZ+RA63PlHv0PSx10PI+Cof7NHfXmk63yHYGnwgwmF?=
 =?us-ascii?Q?EPCyyx06+IHqQx23ZCL8YHnLHOQGbMQUtzYj42srCN8+jnTG6kfCKA/TTBvQ?=
 =?us-ascii?Q?jwbfoJFgBPzi5iuEKgKTnWUwrSPwaRKgb6dPC8oZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ee3bb0-30b0-40e1-6642-08dd499ef506
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:48:42.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OowYong0HGXmz0U5hMYC5R7V2SezY5VjaYnIGxJ/t3Qb4NbGKU299QKALQtJlwanLmfLBG37usOd6tXiK1vNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215

On Sat, Feb 08, 2025 at 03:15:18PM +0100, Eric Woudstra wrote:
> Sending as RFC as I do not own this hardware. This code is not tested.
> 
> Vladimir found this part of the spectrum switchdev, while looking at
> another issue here:
> 
> https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/
> 
> As vxlan seems a foreign port, wouldn't it be better to use
> switchdev_handle_port_obj_add_foreign() ?

Thanks for the patch, but the VXLAN port is not foreign to the other
switch ports. That is, forwarding between these ports and VXLAN happens
in hardware. And yes, switchdev_bridge_port_offload() does need to be
called for the VXLAN port so that it's assigned the same hardware domain
as the other ports.

