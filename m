Return-Path: <netdev+bounces-234065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E789C1C0B4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A3318885C2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C152EE5F4;
	Wed, 29 Oct 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lc7o+MGF"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F71B87C0;
	Wed, 29 Oct 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754782; cv=fail; b=pQoNghGS/A9UD6oNroIzoPcazsfapJ3su/mdT/XfwGSTVdCQ6+ztci93FolCr1k/Kd4mp1y3ZdLkS1O8s53s62BtCRBg684Ed5LayV/XuyFs/vKRVTR6fcIH6TXyNKrpHdXUcaZomEdtHwG8NaMQ3pLqifPXSdM7dbamac3vjiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754782; c=relaxed/simple;
	bh=7GvhTIX4PiYj0H6zCBVXqCjxGbAAUtsv432HdMHxPKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Og0sfLVSaJXhMpUmf//r7UWabs1/R483RNcNAa6UUNIqO2qW8aj2PHfU70PWdLjJDcdTLTYOCWZhQTaFgBazSjVu0DcsCY6kSmhmQYb52Urdz8Ww1xYDMneRq5GJ2+VhvjbuvwOsBG6vakmBGUjlniCahUdif/tVNYIePxp6f80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lc7o+MGF; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFiu2PXgUO6u6u2v9WHt+cpK0Xpc1FO1CPAK6N0++PRmQkJbl0Y71T2QmCQa59R/UiCSYHRKq4oMVkvLqgqa3L4x9CQQcvXo4mT6jlNWO447cXeZRpks8D2zaTRw/OQQDPI002bXP1Mkg/J6Po1YRgDzJO5yN7FFk5OayOgOvJonkXdAldS6+976vh7/ZNHmHIojsyht6nhoQ9eZ7qI4NOKR6WfllOK39e/Q+9Q1qtbAWX1KM4326lJ4L/okQx6E//QVbg/7tCUBAIWFbY1WkMgGGpsMt83u1w/xP1xFtg4Ri4ahypsl5mkYeHoD+t7N4f0dA0k6+UYsXU5i03F0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwJH//HZSJysUvEcEJ+UaTv7EX+fVy3C7mRImuHaOtQ=;
 b=B8cOM6DazWdLbz3A6osOaSFhbpz0ftE+Uixt3merf9+2/VdFizaHGdHUd3yG7BfqHkKq09azmoZcb70M5WvapSqIFo3yWbUwHwaWpOKblYo0B2gXFc5ukzla+uopYAfkl4Bl8ZHGVjXS5rXnvgkHn7mKZ91KFvFh6lnBH0ZzH4krSBbt4gIwzcfMwmqB8X+fqXeSPTYYDBf01IwR9wAdWbwF1l+Mc9H3DLgpXTWKBDKq8OmbR39tfSyEml0QzvqdE7NukxznGEZqrO68fNQoTvdUNycIky2JbndkJYSRCemcZNppcLhhNh4zTrqWEYUYcxkXXjpyzliJVOlSJ2E7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwJH//HZSJysUvEcEJ+UaTv7EX+fVy3C7mRImuHaOtQ=;
 b=Lc7o+MGFnERQS6Y6f1OS3JmZ5ke0QUZ5ytiSSlUnBAwIGo8zyjIuR3sy00I/m1D62uBMSXng5hXaPX2WE4QUxIjtmtdG4vEzuYxlza0YAQzhzXeBWeYpVvIgR2ffkZ9wdOaMUuSE3xqO5iFRPpY+g33ToRxITk8Asdj4IkB22EEUznU0G9N4AcnpwB8yTATDKtCasEAuF7t1Kmbk/p0RSum9709bgFORfTrFHik5oNGReUxni7SBwgL/jhMqcVAha2EykGwqHwErYCOMNhWnDJzKrTMTDK4os+d/7I35nKE8PdqAMb19htN4rPZ4McILz4tl4NUT65p4yRjkLyt05g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10627.eurprd04.prod.outlook.com (2603:10a6:102:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:19:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 16:19:37 +0000
Date: Wed, 29 Oct 2025 18:19:34 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiaming Zhang <r772577952@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	linux-kernel@vger.kernel.org, sdf@fomichev.me,
	syzkaller@googlegroups.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in
 generic_hwtstamp_ioctl_lower
Message-ID: <20251029161934.xwxzqoknqmwtrsgv@skbuf>
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
 <20251029110651.25c4936d@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
X-ClientProxiedBy: BE1P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10627:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe3aaf3-fb83-4125-44cd-08de1706f457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lvzrbDLhddtfJ2vnE4rtVW21t9BoSgxO/i6Q8Z7PZX39UdamgffYOscvVOnS?=
 =?us-ascii?Q?SnVKOZ39TvKSv/rM17/SkM8evDswxwGhulw1OYb+biN4KdaVRlUaCj0dmkKC?=
 =?us-ascii?Q?xHRCcxTIVPdde/uD65nJr301TfZaB4I2+F9xIzY8OG/hQ0YyCL+uYpfqp4cF?=
 =?us-ascii?Q?7FGK1ADJ5ui0H5qv76tQNYnrM/Isy4POWfYPSoNOgBZEiV0myVQMrRIczM0p?=
 =?us-ascii?Q?x56NaQFvIUvMwgS1TePDwxD9nzbiaPjTd6sDAAIUtba51EGhgftKu31PN3An?=
 =?us-ascii?Q?ZSZ1/HBSstovTo5Lp3NrBMa97RIZJ9u/knRmBwTTwHeMs7Cw4TjZIM8oQv6d?=
 =?us-ascii?Q?lk2I0yozserSiwSRw3rzsBupGY0guKzVPpzt9keLfnA1NRrEEFS/Ahy44+Gt?=
 =?us-ascii?Q?zjoo70IpbwuB/W2Zi51Wi4EpsgdQPUAktJeLTMIaBFtKpIfzuPBgBBVswnZ4?=
 =?us-ascii?Q?tjQ5iJp3sbOmyY9arvBxXy3phJsf+KaMJZkxQuvzGVHg1ffkLaVySfALubQv?=
 =?us-ascii?Q?m+ufCsbpkwhI3asQLYm4BM9ABo4OGffUEhoujK5e6xmKUUWwXdkS+/14KK9L?=
 =?us-ascii?Q?+BSSXcspGmQqSUoPul2skzv/plpoY7qjDX5j2BxP12dfbmqJwo/J0Lnk3x+C?=
 =?us-ascii?Q?SVnQOHw9CpUgvpNUEzLecDY+1lWRIR2pBpyt/EG8CAXyuCDq6+Qx23u8vsLo?=
 =?us-ascii?Q?K/CPM4JF/XOeBaoKuZn/rW6wbnR6h6cJpSjACzmDPWfJb7s/vHCm4yxAx7ZL?=
 =?us-ascii?Q?0DLlCwGfs5skWQ/wNCvKBULkl+BJex32beYZaZgbr7cCRyJ+SkrYgiKFtvU/?=
 =?us-ascii?Q?C6x0SEerFJQ6RaFgsDUD99XKvOsdbTgrOuPV/EvGTaVq/7X9TXVsIdKsxLpo?=
 =?us-ascii?Q?PopzQScwIxoXRAyb0xfCcFUZhdhLLVLMazAIbEzc0AEYYUDuCfn666dxdA9T?=
 =?us-ascii?Q?QmLkRYbdk41hWdJ+qVtHY5y2GdjPNDj6YN3w/n4S+D2+XFxPsXxPSo4FQn83?=
 =?us-ascii?Q?pzw5dok5whgFIA8eW5MS/Hh5wMqkAQESdznQNtxkIz6UXBEXkOAuO1fCCpsU?=
 =?us-ascii?Q?rtLSGQj6+TE0kfFjCRpKPRHSCqwVBe7JjgqretZ3ew+YKBqUHe+yYgpSe1Ej?=
 =?us-ascii?Q?2Z3zy2CbqfBlYhIpRtAB58ekmxhcGE3btxF52uU5wxxcjB3fcBMrBZHIEPwO?=
 =?us-ascii?Q?YOhSx9wAZJivOn0ICt+w1Q52iUa0zNF8iCKpiCE6MVLzVZ5LscAgIAkVMvtp?=
 =?us-ascii?Q?8+nYiDzosEeiSg6XXoGMkImC0yOpp4aJrYlp0csclaE0WOPqbG48l3qXJf2Z?=
 =?us-ascii?Q?1cxPeeWuoGxk/thFTQoQegufMa4dm0lbhAPjKafuCNkmzS6yVI4guHEiZO5I?=
 =?us-ascii?Q?h42mg31/plrMS67Hemqobla/x3UKJAPmV1EtSvnK3HYj3K90E/KVdzrHX1RN?=
 =?us-ascii?Q?1JhgyrhV6t5aw037WvwdF014QDzD9gCiMzKWNxQMS2ucIzGMtFmrOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQgZQtg9yeUCxId5g1mRZpg9QlbFoQlAhSwL8do3Qc3xhE/QoGu0hsdlcaTU?=
 =?us-ascii?Q?6/Py6BdGSM3jxWCNq4/4k9u8nFWJlfimXWv6kzu2bHrvVY6l1Sa6dlijpThC?=
 =?us-ascii?Q?iyj/PoPzWAWI6URe8SbuERZOEZC1jLnFaRhB+PmjqRnQTb5wpLkqYj8yZghg?=
 =?us-ascii?Q?npkI1utkYcnEKhdTU+q4opQUWG/DfcJtWwKkizUH3Ns4wU0iMGNxQ6m9QsJz?=
 =?us-ascii?Q?/Qnxjveou610altna7jQlVd9r1ZABiNOXVMyc7pL3pQEQm6aMpFEyXJ2frC+?=
 =?us-ascii?Q?4wOy3+ZEFNP+XP5VRIgbGvYhO9GGImcmGKXE1eQu45c9G1hS7Mf1ASukFSGY?=
 =?us-ascii?Q?RtERa24gM1n+xZkiPdXRFexFRNxNU+lOAqJDNTWKJWfBQtLeY0zsdeY+LWgJ?=
 =?us-ascii?Q?Pxxhn/UvbszvHzyqQxambNp5m/+KGTU0hjZQdav+zenZx1f5fKQGEbJ+yQH4?=
 =?us-ascii?Q?phKssY9GbpTm/5wYet1/0UwlhhGjXK9H6Ue/5kIwJe2+xURlvv2A+4N+fhi0?=
 =?us-ascii?Q?KVxczhxp3boIRGkhZ2jBsn3VIibRJJmsU5pJJylyyD1yGsUXjEIhWPJqGIsW?=
 =?us-ascii?Q?upj9tCxpU1KfRxRTJ68or+fRDoA/oXKahZeNGMRG3znGpQdkYD+Fg0T1pIDc?=
 =?us-ascii?Q?byAm9QcbxC/Q3UuUl2UCwuS66cyiu8rWTruhcxU6BqRNxNYj++b8uIVMaZpq?=
 =?us-ascii?Q?FLqjByEPKGorwiK4GepsBj/An5tfLgPjUg/zzsAbJZq79Oaaesf6EyYUJXD/?=
 =?us-ascii?Q?8gjGvtbim9Iuf7bG7AmgsB9i3E/nKQyM8xMWdqtMpWuDHjCs8INryKtueRcT?=
 =?us-ascii?Q?R5py6zXrbnYzZc+yhztmBQESAnwMw00yoDJJljWbVaAqIutyi/hnPI2zy7Q4?=
 =?us-ascii?Q?nUi5rudeSVpKaNvVzA+p/SggkPBEYpfIRVaO8o+HmsaorcRIRtu72riSMOWO?=
 =?us-ascii?Q?dTsO3cLF79m8BvwECdpvQFr8gxyXLcmQSYZ6BJtJsXtxuHc+Aehi+CmAeVjx?=
 =?us-ascii?Q?DdNPpmUxUhdvwl1upwVUKMf6r56uvgOKx6AWfVci6LUQiA/2tyVAxoyY2V86?=
 =?us-ascii?Q?nOVd6f0+BjxhUeasDK7HxUP6Xecc0K84F+2cHOlVQOWAqgz69EWa/9HtwF6/?=
 =?us-ascii?Q?+ElFyLWVmLyc1/f1IGbIqyDQiekK7s9vEi7EqrIS9v0YcgUqCXLE2YlJJpLm?=
 =?us-ascii?Q?/fX1sy9DdYTWrsRXxsuCDe5GBOeB42EpHZbl6mn7shBG2/tkVF/3xUFZmIET?=
 =?us-ascii?Q?rF1LsEMEFS4a+X5QZdxZWTyTwuJ+6IixZTaFk6/K4IiUxZ/ogFydb8+Lek4h?=
 =?us-ascii?Q?HFfFchlubTDmhZXibIHSDHaxpQEFtYiTuK1q2i1R5EHorBmGtBLskRhsP7ek?=
 =?us-ascii?Q?xA5wOxZ/FVrxYrIxku883wXPuEV3C5jlUcE6u3fj3mvfzrGU7ICKHTeEKbeL?=
 =?us-ascii?Q?vQ9/oTdYffrIrZS03MLU0GdNQ4UWI2Pnqwrf+OabqvZPobXsfsShzHrEnDsB?=
 =?us-ascii?Q?ck3K9cq9vcjQ0KxULEpc8+b7oEZNkDYEXzEDGUccnXJG/2otZdg/8o0/O9W4?=
 =?us-ascii?Q?QLBnetgmSW4rz2QMY9BbnTdLgYEz0bUUx6gCkS4X6Hf8ltQG54m2vOmUtWF6?=
 =?us-ascii?Q?fTkXaXBrbu/RMI0Wteeh7QlAkXARpswt4yhCqblg5YklDnHy9GmUeV8apW7a?=
 =?us-ascii?Q?UGcXMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe3aaf3-fb83-4125-44cd-08de1706f457
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:19:37.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi5qVjdGdcFENoWiEUEfKB5mauIzTjOI51jB5tTnj3q1Da+jWgAiuMDdDbIz5Xsckvj/aLEll5dSwsVY6/GBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10627

On Wed, Oct 29, 2025 at 11:06:51AM +0100, Kory Maincent wrote:
> Hello Jiaming,
> 
> +Vlad
> 
> On Wed, 29 Oct 2025 16:45:37 +0800
> Jiaming Zhang <r772577952@gmail.com> wrote:
> 
> > Dear Linux kernel developers and maintainers,
> > 
> > We are writing to report a null pointer dereference bug discovered in
> > the net subsystem. This bug is reproducible on the latest version
> > (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
> > 
> > The root cause is in tsconfig_prepare_data(), where a local
> > kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
> > all its members to zero. Consequently, cfg.ifr becomes NULL.
> > 
> > cfg is then passed as: tsconfig_prepare_data() ->
> > dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
> > dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
> > generic_hwtstamp_ioctl_lower().
> > 
> > The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
> > valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
> > dereferences the NULL pointer, triggering the bug.
> 
> Thanks for spotting this issue!
> 
> In the ideal world we would have all Ethernet driver supporting the
> hwtstamp_get/set NDOs but that not currently the case.	
> Vladimir Oltean was working on this but it is not done yet. 
> $ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
> 16

Vadim also took the initiative and submitted (is still submitting?) some
more conversions, whereas I lost all steam.

> > As a potential fix, we can declare a local struct ifreq variable in
> > tsconfig_prepare_data(), zero-initializing it, and then assigning its
> > address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
> > ensures that functions down the call chain receive a valid pointer.
> 
> If we do that we will have legacy IOCTL path inside the Netlink path and that's
> not something we want.
> In fact it is possible because the drivers calling
> generic_hwtstamp_get/set_lower functions are already converted to hwtstamp NDOs
> therefore the NDO check in tsconfig_prepare_data is not working on these case.

I remember we had this discussion before.

| This is why I mentioned by ndo_hwtstamp_set() conversion, because
| suddenly it is a prerequisite for any further progress to be done.
| You can't convert SIOCSHWTSTAMP to netlink if there are some driver
| implementations which still use ndo_eth_ioctl(). They need to be
| UAPI-agnostic.

https://lore.kernel.org/netdev/20231122140850.li2mvf6tpo3f2fhh@skbuf/

I'm not sure what was your agreement with the netdev maintainer
accepting the tsconfig netlink work with unconverted device drivers left
in the tree.

> IMO the solution is to add a check on the ifr value in the
> generic_hwtstamp_set/get_lower functions like that:
> 
> int generic_hwtstamp_set_lower(struct net_device *dev,
> 			       struct kernel_hwtstamp_config *kernel_cfg,
> 			       struct netlink_ext_ack *extack)
> {
> ...
> 
> 	/* Netlink path with unconverted lower driver */
> 	if (!kernel_cfg->ifr)
> 		return -EOPNOTSUPP;
> 
> 	/* Legacy path: unconverted lower driver */
> 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
> }

This plugs one hole (two including _get). How many more are there? If
this is an oversight, the entire tree needs to be reviewed for
ndo_hwtstamp_get() / ndo_hwtstamp_test() pointer tests which were used
as an indication that this net device is netlink ready. Stacked
virtual interfaces are netlink-ready only when the entire chain down to
the physical interface is netlink-ready.

