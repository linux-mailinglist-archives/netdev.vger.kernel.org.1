Return-Path: <netdev+bounces-197634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F282AAD9674
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E03BEE79
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B025393D;
	Fri, 13 Jun 2025 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cpOhhivc"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237525C801
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846824; cv=fail; b=ASceAxP5IOfy+GVWPl9NzSS00JciRO0DyfasdRerF04GdcFLuRmLzhRF3+4slypch2Fi15KDtxOnIL4BWtJICjuAFDTDFDxHi/nAwN5fNh53P7ql1B9zs6HCF02oEZ6gxZdqlNhDNPM5JFvB8igBbvJcU7fuCq9qXUhY4ZMbsHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846824; c=relaxed/simple;
	bh=u1h7f1IxsdaPg610LHER9s45uvWqIt9EOFbgRIBr4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i778wRMYqrXOOxKmoLJfxIk5y3AHxitPIeDBACV0A2FiB0k/gwtAwPcZQexaVoxN6eYGZEzGyhrBeF/9COgpnvegQf6CrAx3cfjagBkbBpTVI6cwIi/a9B+R6PcGqu6YdhD/kMQKpHIHmgQb4Y8A/MB+5YRSPy3ZVlL+lBdgers=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cpOhhivc; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwDp1DVbjHANRY4oUkjcC2d4H5GduCDsqFeO5hd7rKrhmKHXQ5dv00EqoiEO8Xr2OkpFjK2ReEEdTnGhpCt+OrF2RCyRlX7R2TW/JRgplbWcYCPpvbNO2TujQsNRhFyPYnYcircdkVI17tlP8bI7tbShaX1ButkwZnxLyfu1pLqVu8Vf3+eFJQ9Zd7d9OVBv7dfgAg84aPoU6LBv7ObzVVfBpGFA3TyJX870fNatC1eKNDypnOkOYf+d0OAcuyVvu1ssX26K9Qg28x3UnoZExRhXCv63Sh2Yi9ivWWmZEOQtgRiI0YnchgYVL+Rvya9Ue2x/Y292+A32ttUozki6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lLRO4qK1OdVadvk/WnIGeHU0MA8GlfmpLpqncG9vkE=;
 b=sLakElfGYMflojduKnTpVGPFDSoaL81JsT5ULL7rc0ykxUvVV6I+l1gmjgjynk7oa+Gmaqdzrz8uQxPF4glLLRHvhPJtnyhN1KLr3qQNpW3LMIMcl7PfGQZu+2giTl8jWGpkXiYaEyQ8q4UwUlrCMuOUJ0WQbzElVnlfmKBRT2PU7Zg6DC71v/LgNSpCjoG5OmfS4dYPUoP2f37pEGuSj4bBu2ExtjYWnN2u0oZcsCYKXer/G7WvjGlRRGCg/WmWSh7ERkceY7HWaHXXM6GSmpcQuclPU4pu+4MepM6MwJYD2Au6YYgx3ApZY2nflb/5Gm6uMupOHu0iUXMdI/yEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lLRO4qK1OdVadvk/WnIGeHU0MA8GlfmpLpqncG9vkE=;
 b=cpOhhivc24gdvCMnfNuS95u91GVh+zTztcuomeZ8xXt/EBbhHAJjqlWPUzlysaIIkhMpPsJT8sa8ToIMTOHam4zwL9C/kBwHM/gLXH+x+sKrpIuxdnkXF1O5Qxz2ArtRB4KiNwqdQZ8FusPEk/igF3j8e1gk7oOHpKGFdej+D9y0NDef6DifjEc5bS0H025Dae+7MaKQIFNzzBizR5uXIPRaeDGQHXnsN9ZecJg2ONz9/8+ILqXwl1v/nI0TJFqnBGrkhD9mvhbxJubC/luIVGpWAscLccPCAOGUwASbp8tVuZrleYA7J5MmtSaOemSppsmfOwiYHHgTrqzTCk6qaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 20:33:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 20:33:39 +0000
Date: Fri, 13 Jun 2025 23:33:36 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, vinicius.gomes@intel.com,
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <20250613203336.dqrlptfhaciozddy@skbuf>
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
 <aEs3Sotbf81FShq3@pop-os.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEs3Sotbf81FShq3@pop-os.localdomain>
X-ClientProxiedBy: VE1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:118::41) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 282f7e79-7bb0-4dd6-44a7-08ddaab9944c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cRCbuk9GR6e5nl4eCoYVTX+l3HksJf47deH/QpHR9bfB0v6D1kK7UH++yA4?=
 =?us-ascii?Q?qWcj6G9JMorZpBvnb9xzH6kgsxUnVmxICR7gJQ2ZnGXhHiQ00Y0h7R1gT7Rt?=
 =?us-ascii?Q?JN/dWqo0Je8DaHn9JdGmZJDNkYUPHBWSO5dKJLHIPEJKPEH1mPF9u4btSmt8?=
 =?us-ascii?Q?qryEd94g3hubfvsEnP77lrUKldhP2QHRZR1+Ger3q+K0lJA3arePp8gyXgtf?=
 =?us-ascii?Q?uxn0+lQH/fc0+mJO3bljRFCGFLHD3CBZIw52NwkLfojcxuYk34bkhZCZbllN?=
 =?us-ascii?Q?zpn4XA7MC1BlHc0X3U5z1N18P/lG5xUI1TwADbp5hlb1NNHT4/0XCpB8TYjr?=
 =?us-ascii?Q?h5MFynJckBJ/4N+9qVLmmFRndCsENKeeUhVJMSfiNsQSvQLZ0IDEbhqnN8jh?=
 =?us-ascii?Q?o5QebbZ2bpCEuM57Kq6eRAYFR57pD59w58xJVubWU4dWyk0DnPpjC4+bCKVG?=
 =?us-ascii?Q?wdiiW+qOwo8+fu024iJ+3GBzTWesEK9a0b0/Gq9qTJ+xRwLilfg7ocZ8XgGJ?=
 =?us-ascii?Q?pecvv/vk7bC8H5ncvu/n6XPxJLxw3LOeWp1wVmUGc5H6GMd3yW3vO91H+5u8?=
 =?us-ascii?Q?MVMjJexKrbQN4OBtPg2tq/yxHJk2nrwMfV12LQXFQbMT+b6UTWttfXwp3mBm?=
 =?us-ascii?Q?M0mu0c0WTxGM8PaqbO7BhF80ilT/BYKxcNqltg4emHuyuB/gEbW8z7TBbZ8P?=
 =?us-ascii?Q?FHW8jedZRu5/+MYGZHGIPfuN0Tq9r1pwBcRw1J/7Tce1UUL+6gtBuXxcaG5k?=
 =?us-ascii?Q?GtJKoNVO+EaIgvklFGEaWgV79N2UpULq9zHzHa2QCe7ceiqbNHo9AsXM4BFS?=
 =?us-ascii?Q?VQZ7z/qYbVoPCAASHRmlqZ4jX4Z3vRVUlBmwjPV4V4zptTzWsHxTKgYWgL+n?=
 =?us-ascii?Q?epY+dsYrmTx0bbeJIGolnhP1UP5bo2XArNSJRvDjbHFP+zyyf/o+6hAHJXAk?=
 =?us-ascii?Q?rPfTYZrkE18seDb6KzZ9zbw6NtPkyq3eIEOwA5lLxCd5eESPiU2MeD4iyYC8?=
 =?us-ascii?Q?O4mPqxeQbEwDDWqAihtI9LViD3j/mMaHmtUnOqvLC/4kZHor+pnALYwNeYoA?=
 =?us-ascii?Q?q24aLo3ubbDM8ASJUWgSaRGNVEjX1qbja+RuToB0Y4CEbuoxKWHk25OJ+PYQ?=
 =?us-ascii?Q?GSzXBgBIyF8xRpSrJIxTPQiNw47ntZO6wGCkAseBxnmwyJ55p5LufCTEVS81?=
 =?us-ascii?Q?X8TpSSz3zbb5ffaJhGlanZedRTGF1plX9OwhFa0lhHV+EfaPHpNoDrWbYwSu?=
 =?us-ascii?Q?L2RcZYhpkeBYNHWITptmDDeFi8U82oVjBa3WBrA8O2GA3LSEGW0psyarvDn3?=
 =?us-ascii?Q?ArZLFGhVNMK/ltg59atyouzlDQrez49qOYnW+81sD9G5RFh/a0pXNdYY/ySc?=
 =?us-ascii?Q?Nst5EtViz/fqYQW7R3N7KO5gfKZDvVV8vqS3KHEMS+q4ic7t3LIDTT7jWm0m?=
 =?us-ascii?Q?NMTMKR34D/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0F7njH79893beTVNmcLtmh6PNj9AQQl3rb43x3kn8m5Sx/jVAlhjz4O5jJ1a?=
 =?us-ascii?Q?GusaU+h5w7HWaGKGFtu8/Q5BvTm1CFvnXwSMl2gpODapbcodhXVhsPSJ9PD/?=
 =?us-ascii?Q?0OdrH5zwt1XdvYlqgtmBpAgzc9ZlXQxVqccLrXR9GvoK2YJkAIijkwFhwwRZ?=
 =?us-ascii?Q?K68sO4tmdEUwjgBqCOGeS5z+MWR/URte3cggrVcMpv/N92hOhnp/OXvk185C?=
 =?us-ascii?Q?NGjhaZQ1D3M/jUoHVs3RFsHsh3Pc/6vuMZMhv9Y/rZdWvdc7WzDnFiwKZCGh?=
 =?us-ascii?Q?yebNgKkAVJIHCcyhcYx2294gBuBb9yfFR/31vuXfLBYq8vYray6lsReQA1jX?=
 =?us-ascii?Q?PXwtZyXfxRKacQzKFwFGFU78/CRdFoHgr5fonvPm6S67BXAIsMNbN1ucpole?=
 =?us-ascii?Q?0Xc+W91IXjYktOtPN7MMV3/MjpVoRXHbHx9z9d75Fz4qHisIL1Py+b5t2UaD?=
 =?us-ascii?Q?eJs8vK1NXBv7QszHzMejl/hYI7By12P2/Opiy6MKseeKM9Dpp1lrytSptL74?=
 =?us-ascii?Q?jHTuOA9gLMcLqvCXW89Q3cL1vlkmPgbZS2tHyrIgwQW5oqdixBA8vp0JaUpz?=
 =?us-ascii?Q?dAy8KFR/kCbPmqk/LlvDwiGHU+AHukNuNIQ1YXODxgRX+je1RaY39drdz9TT?=
 =?us-ascii?Q?5ApbHlxObgqw9DcIh1b55AZvzDMBDH8LRkyZY9HThxXrXlOdirVrbiYhXYLE?=
 =?us-ascii?Q?tUYqZn2zDydFNBjIghGlagstrLzqAotL3mnyrEVkUcRZHHTK6R/7wQiR80MP?=
 =?us-ascii?Q?sPO4oZJXVKivKBiBJJsTyDsz924IGD9weTZTilhE6eTqS3Xxh8Dn4GzooSO7?=
 =?us-ascii?Q?oyo85Vx09RW0+EIV4jUiTCexGm+vSJlo93C2H54e/yJqz2sWWonCH4sN1yMB?=
 =?us-ascii?Q?jKvURoPj8oYCGROSU+8AkPCtOlwNpOv19LyNvT7+SCYyAjI+cTTLQ/LAMaxo?=
 =?us-ascii?Q?gVwkIhUm0RXZmlBoJdK0qv6eefj4n6Al1eMw+wFWrwBZSkW70auisBoG8MGQ?=
 =?us-ascii?Q?TQNT6/NfLdw3+cK1M6qvqBawq6uP2Pluc+rNE4cnq8slcTBAxx+0J/KNieod?=
 =?us-ascii?Q?vci28gjYVQ3eHKptREK8mbLO/29rr5EJO8yjjia3cuoq+kr5Qr4Xm90F0/7j?=
 =?us-ascii?Q?LUgZfwYDvCB6K9c88mtHyKY0OM/lPUR6BaiOw/mmJL+QWNm5yDFTU38rnhS4?=
 =?us-ascii?Q?nxN8r8rM88xz3W7OMSXDAdrNrbpQvKMWTQLYJp2GTEhiS522ZbQUVIJ/YcaE?=
 =?us-ascii?Q?NRLj1EKRxHbxNNXJZIjOxaVMhso8FyxXzRxvzXYalSdOt12/JV0UliLRJfV5?=
 =?us-ascii?Q?lJCas3sLhJydUIZ11fCWxOIau7CZGhVX3mKl9SsNzwMzetixSnvyCK5XpL8Y?=
 =?us-ascii?Q?00YCK+Kf3Gh+DJgm3Q1816lHVl2punj91aiYq+ScncVrS91Ci4+KOKCogq9l?=
 =?us-ascii?Q?xY80GqIn4ulod1ODZYx7jpeoTN6bP8t/QhH70SFbD4Z5ZmdkZhqVTyQYFWN0?=
 =?us-ascii?Q?1vQNsR7WrqwKVcTKAObpdVUSQV6WkiCS3cA/jx9omw8DktrPleVq9sp2uyyB?=
 =?us-ascii?Q?Kv/dDI6VTKq2XVcCPovVX3+rXc/w93JXBDOoJ1MOsRtTMSCQSMYgd7wqkk02?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282f7e79-7bb0-4dd6-44a7-08ddaab9944c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 20:33:39.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjhiezBDvFGXhxO2lkPN+M9WMhG2uopWEsReX8IKpL8u1yDtFEdcJbT3WhzwcYTlLQQo6GA3Ex2dg5NVj9Ubng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

On Thu, Jun 12, 2025 at 01:23:38PM -0700, Cong Wang wrote:
> On Thu, Jun 12, 2025 at 07:16:55AM -0400, Hyunwoo Kim wrote:
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 14021b812329..bd2b02d1dc63 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> >  	if (event != NETDEV_UP && event != NETDEV_CHANGE)
> >  		return NOTIFY_DONE;
> >  
> > +	rcu_read_lock();
> >  	list_for_each_entry(q, &taprio_list, taprio_list) {
> >  		if (dev != qdisc_dev(q->root))
> >  			continue;
> > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> 
> There is a taprio_set_picos_per_byte() call here, it calls
> __ethtool_get_link_ksettings() which could be blocking.
> 
> For instance, gve_get_link_ksettings() calls
> gve_adminq_report_link_speed() which is a blocking function.
> 
> So I am afraid we can't enforce an atomic context here.
> 
> Sorry.
> Cong

Yeah, and phylib's phy_ethtool_ksettings_get() acquires the
&phydev->lock mutex, which is sleepable. Agreed that this won't work,
good catch.

