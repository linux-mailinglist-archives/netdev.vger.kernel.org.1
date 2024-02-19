Return-Path: <netdev+bounces-72963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5085A6A5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F055B23859
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA7383AC;
	Mon, 19 Feb 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a94Qu3zi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FA37704
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354616; cv=fail; b=YW9zQtY1pdeh9x/7sVYQNuvtEFRzqQ/UdyaITHIXtHDVe+cba3fWmpmpEzJXBipgZMUKtXcTSk7Lkc1JJt8mW/Bgh3h7X1b49bgb5Lairh7T7uw0qM5YKR7ze8pypHi+cJWP2LVUucQAD+qpkjKkX8tres9g5BAak0U6o8mCUh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354616; c=relaxed/simple;
	bh=XhpOuXCdbfXlQkjsXLBtbNzCqzsHfRGyr6CJxhtNXgQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPfUJfa6iVO1OGGtTPz2int+Ha2LA4XNHdqnCeH5gclYmtWjcieE7fFBdmBy8s4BB9IcWzFvHE930NXWTghbhWnZcxR4rtKmqCXS4Dbeq5R0AqZGIMagpD2HEA6T6y7It76g76NMN+ezrFIlQguF3dsX7VnIcbiNFg5hv0ExWA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a94Qu3zi; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708354614; x=1739890614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XhpOuXCdbfXlQkjsXLBtbNzCqzsHfRGyr6CJxhtNXgQ=;
  b=a94Qu3zi4MuSAeqriNhP18JYFRk9uZMuEKmTPVhP/c72YCysgWQH979O
   LKWhrJ3ihLN3IiUpVkAOeSDjVcUuQzybfseoo2YBvXx88e0tvVtMkKUW/
   Db5Cqc3bAC7w/5FhIusYUX0aEtoc68jWCpQNgDLUZ0Scc1lNZBg/E+E1U
   fiVWVP/yKIWvzp9N+DtUOGIiQYQA4nafrl6pab9wQ/l8SQP8n1JxjW7SA
   x/mrhb1igkJq9WYKskqU1676AwN2cry23kzvOzH+NpWXBmd+pURMyYq4/
   ctGX4r541P/MeaoWvxM4pi2F+uQWSOm3QNutwkMCTDIydGpOG7IjXXCNB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2579477"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2579477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="42007235"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 06:56:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:56:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:56:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 06:56:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 06:56:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fok1gvT/HS2HPfSLwyQiDbJkOqMGPumYBtKiT4YRA9yFppQSn9qpDMWTmRDNgh1E2jNThF05TBH6usJKgQK2sDNRmkClkrbt2qGaRk2GNdIcl4nLLlVPfocBmX7ljSVFkiWdgoSyAAY2ZIckh/bTKGb3e3aojlK+KZiJAKxDGjZnCxdGZ7xhXFcAu268Np5PbN5wbZ76L/5Wi1rcC+hTUobjBU7/DAqp2jkVbk2Zw/bQ26ljpoLP/R16dKbcSD4x8t287DfHgFsysmRhPnz3lzq6mF+nCAa1NxUJddXd+927zPDGPVvf/G/0v8+IOapksdSI9JvhPlVEeQPKYxUKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RNcdzZoT5I4OpJzXuLRtmsC1VfA0NDjN22IORD936c=;
 b=fg0RwcafF0Mb3Zzt5wu8WOtZ+9R2Q4pz2RTLhiuav81ubLQilFhB1lryk/b5e7lU16y17paSyJgCrQ7EWVeW7riR65bs/V8/b/z7HEzatQflVMEgcvOr9icqNho2gDiL3yQMb2p17c0tB7JJbfo8atilj7nfQKN36erQd7CtDbwiHaw245LjfYeQm2XzzzgFP3sDwRzjYkgVqU+YRz4op/fmABdmbpx6NTez3znPoyBpE57hBPg+YgW8BQ7rnUg0DmL81xu+9TUPTKV5CozbclZogD4rWNxZalBqapojyWGXXlXya8AvTFkqbmtQvgLm6c7j7FQrz0vHaUrXOZooKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.34; Mon, 19 Feb 2024 14:56:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:56:50 +0000
Date: Mon, 19 Feb 2024 15:56:39 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Pavel Vazharov <pavel@x3me.net>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
Message-ID: <ZdNsJzWpho81ichG@boxer>
References: <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk>
 <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer>
 <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
 <Zc+aN4rYKZKu3vKx@boxer>
 <CAJEV1ij+fYUhXmscxk_tsgDppHFWZLuP_bc_gUhZPLMdi4qLQA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJEV1ij+fYUhXmscxk_tsgDppHFWZLuP_bc_gUhZPLMdi4qLQA@mail.gmail.com>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: cb94ab72-aa52-4f57-c785-08dc315b006d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKgsXuwO6KvFlpRmMDkW/ti4z34Eh2UEQ1IYF/Z1xabHwMwlJna05ycLggbFldR53H26I/FHi6I/cVuRy0z+5+Qn36b4srid5CIZHYOINTr1Sv5f+2xK/bFHALWFqosXqxklOxzrTvfQgd6+TUCXEeCMoPrDWF+blbpl6fB2Xl9cRVxV/unT8kSw37Jud18Z7xsQPyhGqlZ2jIAZEAhhRI1wERqb2zQo+Zd45zm/X0MAJeyMqHasn16zQLK13iG88Tbzo7/GTj/Byhtnd1s3sl2tM1+hZizF4X2COujboqM+6JputawKbK9lPVuZ8zPsrlYg3zG6pfFjy6PGUAcFozsjI4dl0oGrdKrm4agGH1MS/HOZVilGW/6tUEwTCTglU9zE1vLanahK16+jVX1KrBnWSeUaZ1y6aYiR16gp7r8KnCX4KCotUR5vmLMz37RYNl7p3GOD/bq1abBOEcGJR53J9/Tp5cIBhZ1oRvwfEWtVMWVMlNUjWa5riHNBUZU4A3LAxwyYDr3wAnYwZkshzZdx6VEAgtmkN6pMjZbeN24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thYAAL8YeaIqMVFhNYnMzZ+fQfipSv2zGFKiCnpQgchjLwrA+JzshM5Y12sw?=
 =?us-ascii?Q?+CA18UK99Zh1B06bxMCMqx/K1XENM2twyG20bor+tXmTTFTpuD4Et33xNfC3?=
 =?us-ascii?Q?AmdeGv+ExhsLQDjRqC9+0j7rr3XxSm7FLHs65161E/iPp6prBgDyJyuob05n?=
 =?us-ascii?Q?4MG7AXbZeAb1dcaHh0E5MhfzSUi5fkLVlqB6hYah2KA8uZXN+BN4jBx6MCeJ?=
 =?us-ascii?Q?FRhssJeMTUZ13PIRg07pEubBgJJ8aGHAx26G/hf3Cz7sjB4s8m2lwR7GM8Zr?=
 =?us-ascii?Q?W5WKBa/b3Js+quVevQL9HD8Q6Qu7XVEkitUJ3h6mGktXAky6KkglHWKyuH4I?=
 =?us-ascii?Q?hxIipH2N2Xu40uSxsnsDFVmJ7D2u7YX47xySghimhaak8WOjiOG2eYI2AZUA?=
 =?us-ascii?Q?0AuV1mQ61P4ARsQv3qPDxZUrbvexKxVEcc+WLByliRN9BCZdg29voQgiHbZc?=
 =?us-ascii?Q?0fckuVULdVv0WZ9rKYKzmFpPsLDepfGU37pJCZyhMBaPYiFmQ9EpkmGnbziU?=
 =?us-ascii?Q?c+DYmYW/1n4d/LCLvpq9wDSv3UvlJxjbK3QgrOuCdAjVlnupM8gdWeCzFocf?=
 =?us-ascii?Q?I1XId0b7Y2IuJ62Hnr6VabvJiFEZaMStX6LMC8VZaoPKuxA5nS6Kc7DXMXnU?=
 =?us-ascii?Q?0u7hK4prRHbFSyrq7zA1eushMBR1XaoTec1Mn0g+HhPf6KMP8OgFnWkYk8nM?=
 =?us-ascii?Q?4pEj8wjB1CEtYRJ4j452uHY3pPN71GtMXqkvQe6uEA0AbPgCK89+GAQ2SI2j?=
 =?us-ascii?Q?u65DExRIR4sYMnevzU9IulE8aBG72Lcn4EPHHwSrkOXG3WzVTXYrLbeFVjph?=
 =?us-ascii?Q?xdoDiGGi2FqEwXSr7S7TqsgzWAUvkuACuKsJex8SYvF665gp9j3RiL42arA9?=
 =?us-ascii?Q?QAb02xcPdtUisNp7LWO9zvoYbjp9XhAJvNl0+WQqTckfkdenwSA7zE1ORI+C?=
 =?us-ascii?Q?OO4qYZGvsmhmfX7joX+39v49RcKOc+HE+zK92airWQBAwqLV3CXebbXosz01?=
 =?us-ascii?Q?0qlWys2S3/8l0hpasX3VoKiClrRrI9x7nxXVVs055uNDvWEKBRZgzn+W1H/+?=
 =?us-ascii?Q?ujlrcUusfFZSgWG9/N7+w6mYf8rM+gHTD93ia/N3Vcip7PEAcEMJGJT2JZNc?=
 =?us-ascii?Q?E7QhQYtxnk5/owTjSx8EligECogdeh/uQ+1Ge+vetsZTyOjEyT6OHK5MBw+a?=
 =?us-ascii?Q?NYxLgSShkXHvCCZofiP8lilHUwyBgvHnMzJmguzScpJ4+WnR1QZ5AmtQcV4F?=
 =?us-ascii?Q?FeGOm6PlaRYysOYo7US2Y6DGlF+wmKCfbs5Ab8I3WV8UVD9OrIVa0i/zdgQd?=
 =?us-ascii?Q?FSTiJ+tChOXDtfDGOhigVRfhXuYEQBCCuP/nEUaF+Q8UrAT3XRPGMsRfX1aA?=
 =?us-ascii?Q?ChMXCVclIO+mRNFpOGU8bmH+89+mbUAnGrLZqZvnpAqPrDmgnk+ykFzS2zFP?=
 =?us-ascii?Q?43ik3guUtZdO/CHDee3LYR+gx3oNfpxbnJ/MHNl2ZP4GYqtdZzRYBDZkhn4J?=
 =?us-ascii?Q?4zhbC9awlmWPk0Ip7Eo8jP/sTf0LxRTIh7uGQOVkOZfCNbMsRUTwsR6jFner?=
 =?us-ascii?Q?ACBqHzTzY1YBs68ixnA5sN3llOBPZybPw9lxIHhQvlwVKevGsEl1wqqMYL1L?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb94ab72-aa52-4f57-c785-08dc315b006d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:56:50.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO4601noSKKQx0oWFtwdNUQldegAXwU/boqwrrSjbP+dYbEt78seOufoUsWWPT/xdvFadzYzVieB6XPvHApMMYuwiv5IFx4g6QPJ0l+dm30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

On Mon, Feb 19, 2024 at 03:45:24PM +0200, Pavel Vazharov wrote:

[...]

> > > We changed the setup and I did the tests with a single port, no
> > > bonding involved.
> > > The port was configured with 16 queues (and 16 XSK sockets bound to them).
> > > I tested with about 100 Mbps of traffic to not break lots of users.
> > > During the tests I observed the traffic on the real time graph on the
> > > remote device port
> > > connected to the server machine where the application was running in
> > > L3 forward mode:
> > > - with zero copy enabled the traffic to the server was about 100 Mbps
> > > but the traffic
> > > coming out of the server was about 50 Mbps (i.e. half of it).
> > > - with no zero copy the traffic in both directions was the same - the
> > > two graphs matched perfectly
> > > Nothing else was changed during the both tests, only the ZC option.
> > > Can I check some stats or something else for this testing scenario
> > > which could be
> > > used to reveal more info about the issue?
> >
> > FWIW I don't see this on my side. My guess would be that some of the
> > queues stalled on ZC due to buggy enable/disable ring pair routines that I
> > am (fingers crossed :)) fixing, or trying to fix in previous email. You
> > could try something as simple as:
> >
> > $ watch -n 1 "ethtool -S eth_ixgbe | grep rx | grep bytes"
> >
> > and verify each of the queues that are supposed to receive traffic. Do the
> > same thing with tx, similarly.
> >
> > >
> > > > >
> Thank you for the help.
> 
> I tried the given patch on kernel 6.7.5.
> The bonding issue, that I described in the above e-mails, seems fixed.
> I can no longer reproduce the issue with the malformed LACP messages.

Awesome! I'll send a fix to lists then.

> 
> However, I tested again with traffic and the issue remains:
> - when traffic is redirected to the machine and simply forwarded at L3
> by our application only about 1/2 - 2/3 of it exits the machine
> - disabling only the Zero Copy (and nothing else in the application)
> fixes the issue
> - another thing that I noticed is in the device stats - the Rx bytes
> looks OK and the counters of every queue increase over the time (with
> and without ZC)
> ethtool -S eth4 | grep rx | grep bytes
>      rx_bytes: 20061532582
>      rx_bytes_nic: 27823942900
>      rx_queue_0_bytes: 690230537
>      rx_queue_1_bytes: 1051217950
>      rx_queue_2_bytes: 1494877257
>      rx_queue_3_bytes: 1989628734
>      rx_queue_4_bytes: 894557655
>      rx_queue_5_bytes: 1557310636
>      rx_queue_6_bytes: 1459428265
>      rx_queue_7_bytes: 1514067682
>      rx_queue_8_bytes: 432567753
>      rx_queue_9_bytes: 1251708768
>      rx_queue_10_bytes: 1091840145
>      rx_queue_11_bytes: 904127964
>      rx_queue_12_bytes: 1241335871
>      rx_queue_13_bytes: 2039939517
>      rx_queue_14_bytes: 777819814
>      rx_queue_15_bytes: 1670874034
> 
> - without ZC the Tx bytes also look OK
> ethtool -S eth4 | grep tx | grep bytes
>      tx_bytes: 24411467399
>      tx_bytes_nic: 29600497994
>      tx_queue_0_bytes: 1525672312
>      tx_queue_1_bytes: 1527162996
>      tx_queue_2_bytes: 1529701681
>      tx_queue_3_bytes: 1526220338
>      tx_queue_4_bytes: 1524403501
>      tx_queue_5_bytes: 1523242084
>      tx_queue_6_bytes: 1523543868
>      tx_queue_7_bytes: 1525376190
>      tx_queue_8_bytes: 1526844278
>      tx_queue_9_bytes: 1523938842
>      tx_queue_10_bytes: 1522663364
>      tx_queue_11_bytes: 1527292259
>      tx_queue_12_bytes: 1525206246
>      tx_queue_13_bytes: 1526670255
>      tx_queue_14_bytes: 1523266153
>      tx_queue_15_bytes: 1530263032
> 
> - however with ZC enabled the Tx bytes stats don't look OK (some
> queues are like doing nothing) - again it's exactly the same
> application
> The sum bytes increase much more than the sum of the per queue bytes.
> ethtool -S eth4 | grep tx | grep bytes ; sleep 1 ; ethtool -S eth4 |
> grep tx | grep bytes
>      tx_bytes: 256022649
>      tx_bytes_nic: 34961074621
>      tx_queue_0_bytes: 372
>      tx_queue_1_bytes: 0
>      tx_queue_2_bytes: 0
>      tx_queue_3_bytes: 0
>      tx_queue_4_bytes: 9920
>      tx_queue_5_bytes: 0
>      tx_queue_6_bytes: 0
>      tx_queue_7_bytes: 0
>      tx_queue_8_bytes: 0
>      tx_queue_9_bytes: 1364
>      tx_queue_10_bytes: 0
>      tx_queue_11_bytes: 0
>      tx_queue_12_bytes: 1116
>      tx_queue_13_bytes: 0
>      tx_queue_14_bytes: 0
>      tx_queue_15_bytes: 0

Yeah here we are looking at Tx rings, not XDP rings that are used for ZC.
XDP rings were acting like rings hidden from user, issue has been brought
several times but currently I am not sure if we have some unified approach
towards that. FWIW ixgbe currently doesn't expose them, sorry for
misleading you.

At this point nothing obvious comes to my mind but I can optimize Tx ZC
path and then let's see where it will take us.

> 
>      tx_bytes: 257830280
>      tx_bytes_nic: 34962912861
>      tx_queue_0_bytes: 372
>      tx_queue_1_bytes: 0
>      tx_queue_2_bytes: 0
>      tx_queue_3_bytes: 0
>      tx_queue_4_bytes: 10044
>      tx_queue_5_bytes: 0
>      tx_queue_6_bytes: 0
>      tx_queue_7_bytes: 0
>      tx_queue_8_bytes: 0
>      tx_queue_9_bytes: 1364
>      tx_queue_10_bytes: 0
>      tx_queue_11_bytes: 0
>      tx_queue_12_bytes: 1116
>      tx_queue_13_bytes: 0
>      tx_queue_14_bytes: 0
>      tx_queue_15_bytes: 0

