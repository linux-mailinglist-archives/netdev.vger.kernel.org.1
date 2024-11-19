Return-Path: <netdev+bounces-146288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36909D297B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E842282EB0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA471CEAAE;
	Tue, 19 Nov 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpm8Ld4U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482512CDAE;
	Tue, 19 Nov 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029728; cv=fail; b=hbZJBP978SNOz5BAFM7WCGjeHmUHgrK7guv1wALRKWMgz4Qkl7WoCHhg9AwK/uWl+yzhinbhCAmvBWyje4GWm6w0b4pwWuWcnwO1BWOKoRX5GrrdlXezE4ds8pVwAYu9rwt3TakEOdnVBXdtyQSJ/PKGNswBpi/rsALPGK9Qg6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029728; c=relaxed/simple;
	bh=qE9zCpy0SaJ2/fQUe2kRFK/hK7leL2LbSzKApSF3/c0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nx53ksQW5YwflB846b7rpYnKoAS/3Ti51zEj0jzJi3OiU6P3Ng+UIV84s7WItGB/X4Xj80VVF+a/ZR2GlfgWEMspOZJGWkxb2Hucih7rEKI3JU5s+A/jrkD4ocMddEyO1jceRdwNpDGTBwHr941W0W7h4KDktMUiWkHEyEWrJBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpm8Ld4U; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732029726; x=1763565726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qE9zCpy0SaJ2/fQUe2kRFK/hK7leL2LbSzKApSF3/c0=;
  b=gpm8Ld4Uz1wIuEBQ7PGSWr6GQw7EWvohTiteO+FrssQ2vxTxaovTCEXy
   90ZF6wbHDj05dDjsZpbdknbmYmYxWlp61R5eoR3zeQSzdlpn+x4xqWall
   Yb8eD3Q1n4sRNDTEg4EKVWOZjzX9jJzV9oOTBg4CBlt5x4fE55rDGgU9/
   Bb5CAVUw3lKmPg3GT4JL0leISW+tUaFAft9+DNHw6nBmUi0P979EV1rkK
   y4Iw82UoQ2/Cmk/H3p5NaNmERytGAEhhiglHVzog8AUyBBNQX9s/H6rs1
   RzOUi+2lARApQpodo0V1VInReEwu5NL/S6XvRVzI3fq5VFaPZd/0gxL2W
   g==;
X-CSE-ConnectionGUID: 1bdnwydkTziiNbmAg0LuOg==
X-CSE-MsgGUID: P2oTyE8LSmy7dKreo9HYtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32144569"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32144569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:22:06 -0800
X-CSE-ConnectionGUID: StH/tGw2QoCBtgaUs6LSLA==
X-CSE-MsgGUID: QYP48rAuTKaq0gdnKy0kVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="127116077"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 07:22:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 07:22:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 07:22:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 07:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1FToKfK+Yynen3QhcycsZznFrEJypIsaSnO9Yayk+nqLny5Co0VYkKopTfg84mPJgEdy13v9V/rIcEeeiFvhjKO8KkDh8ammTve57SBoDPgnbEO68gtETQ2GWtNxsHejq4Gf//JIszTdTnBQgZXaUhXMxDCtNaQ8bRZdnLN3/9OxI+iIofrCuUvauoXevhphGgNcBvWDoyHKHHhTLyawoABDuUYJdCAfYDs4iM9YLB5oFHVM1TztmHV1Iots2yH1ilOmwRHulQJZBqWNeVr5moqdnWGaeDLtkr7tET28Mq3IZeqs/vKJ4qz1GwSIYra12viLlF0ibbJgOlN4n6jLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh+WLf639aK4P37QjwMenEMDIozyt46Ub4kNdsPVH+Y=;
 b=KmaXKbk3Shxzm85bpJI6jFbtkqy3dTPnBq7SO16+JhSeU9LbJ4YjT6dJafwSRSfImVue+49xn+EsDnMe3ixIQAHiVyNeMOFyfKQn89xeEzr62HYZkf713B9CsHJhbztNW4EXpf94WGd/8GOwViaub01Hwr4lSPUSYhb37UCz9VwBU9Xntk/DAjz4NE/NQF+PxsPSvTXJGy9ehAVEP1+W/PwmhxGLKaXupAf6ORDsRVI9dLi6qzLSEpKOpA0TAxuz9CgOiuAcfO8e1kvZ6U0auo0NUl4Rmn9NrD8v0CmyN5cokrq9o78+SbXKIXf0NJ0utxUIReb6xTngLrAHtKoOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 15:22:00 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 15:22:00 +0000
Date: Tue, 19 Nov 2024 16:21:48 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
Subject: Re: [PATCH net v4 4/4] rtase: Add defines for hardware version id
Message-ID: <ZzytDBkUFWYjTTgU@localhost.localdomain>
References: <20241119095706.480752-1-justinlai0215@realtek.com>
 <20241119095706.480752-5-justinlai0215@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119095706.480752-5-justinlai0215@realtek.com>
X-ClientProxiedBy: DUZPR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::18) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3d14e6-9126-4136-e323-08dd08ade9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5pULGal4P3UQPwb+sUzlIuaj/I8colwK3yuhuelhjKVd2Q1nSGZ4Pq52Wc8n?=
 =?us-ascii?Q?mxNsRF3E2vP/Ennx5N/rgrAtEeDfZ0iPO8zmHW/7AkWLShVvqbNM7krBP1VL?=
 =?us-ascii?Q?9GdsgaxrWvhYkPZczTDZMELwhtvNJuMyM1XhqWG0xlAk8rc3LF/zZC0lIzIS?=
 =?us-ascii?Q?D2pM+do5OdaWREqxuXFVVfn+b214xDp6MDPDYgVVCmI4W4+h9pQ6nbNPKnfd?=
 =?us-ascii?Q?0Ot/51Dx2oHecw/NQUmCHdKSPUKBHK1UGsjBZ1u9T8rdOxCzIo5a/8NmZBxh?=
 =?us-ascii?Q?TgV4blhaZ03C1jK3Qzjj24gfe9rMNEZN7NFFolkbaXyja560M3KGrx4xEFq4?=
 =?us-ascii?Q?62d+iPD35ivx+P0B9Q5OtE8pTutwHOeGUxAGidWnIVqFyRgYg/XeVpnyPtyS?=
 =?us-ascii?Q?Zb+pfbuvikA5RdMsJKyRRPnWR/6QRjAM3GPn03GRFVsyWUxhk451Ml89AJC3?=
 =?us-ascii?Q?aWeYjhmxg7yR8euN4pXYSnfWien2K9GITgdHHZEHuEp6Mitzb1YinFubFgX4?=
 =?us-ascii?Q?4xs0G9b+89ahT14fCKuw/wKtSO35zFMuFInKcI1Jtjybqr23pRL4Y7L6Tv15?=
 =?us-ascii?Q?bfqbkXZNjOIlq5FLzW1+t6kPiHFwHX2D56cswNpLB+ZxcH61EOhOPRIfy3Uz?=
 =?us-ascii?Q?nlQJ1LQsNVKMdN7aCUYbIZlkz828Bj8H2dcZO1Nv5KBR19V/RIVi9AY3KR+4?=
 =?us-ascii?Q?LTZG3EoYqRHw8h4l75PcmihFbxdziN587puZZx1kQBC0A4okyVrt2Jcy1lYc?=
 =?us-ascii?Q?MFxAdhJp1ae7bgIW0IvqCFSjXdwc7TaIYs2yjWEHuZp3o4dL1DEh0mFO/72F?=
 =?us-ascii?Q?BDXeHUJe3I2KiGxuOMl2TcwaaweF6dtm8BbMNhbGvUSK21V+z4aICyOaHU7o?=
 =?us-ascii?Q?AnBAeUfeP0LQaiRpMG8fovURn97eQEuS4+y17kbqBZnI99PPdAH+jQILk4ey?=
 =?us-ascii?Q?vh2sc7lQzkh3Y+kwmS6AQeUo/zbdHZ85hsDRKkZuMqo7JjSLTFdlFa2g8VGb?=
 =?us-ascii?Q?JQEv/Dy7E0MteETNYjrjrZFCyScVpAtF5Z5TtDwFiYS0JV1gJ6pSapZvRxE2?=
 =?us-ascii?Q?DdJR0nYSclqeoxwArI20mkys62UEO0Fzp8tNaCz10ZZkVuoQHQVaZqPfQVvc?=
 =?us-ascii?Q?Izd+jtNHxrY3SAftkp3e1Uj2QnmBa661tTCoh83GlGSuoHcbIoTTt1wHh6ei?=
 =?us-ascii?Q?Jweqt1BSWjBAq7yLGgmwkajSS837MaCrwYtsy8/z//1FankLF0UM/ZXS2xoz?=
 =?us-ascii?Q?n4bgSqQ9S7FzNAIucHzbFTYywEDzyHiqt/pwd7YP4C+04BTx18PHdCML1yvy?=
 =?us-ascii?Q?eRtleN5UXj9UHGM7sCuWJo2T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORAOUTGKeNzAwz2ap7VW0zV1BqEAzERV+cEJ9SbjhOkAyBuRfcELDiSPNGYq?=
 =?us-ascii?Q?FuC5ms2KGRGrQxg3EYjExktt+qycUfPZpFHgYPj66GEuhYrpkRxHRUfkOucB?=
 =?us-ascii?Q?G/Rgrf5F0qxSjeCawWAs4Qdh4Q5uWgC1c2+eT5xMZNqxhH2PNF7SUzn5Ey50?=
 =?us-ascii?Q?kiGOKqXkpZkUrwRXsWDYL++IwizEcNnag1Si3brPZn5tCTfClqTbC53tAFgx?=
 =?us-ascii?Q?mepa0/QJz2NhBQ79nDKvF1cIFfOojC+DV/7yfG8wkfIJKzWf+0rXY8OthxER?=
 =?us-ascii?Q?+h5VGwHjaKgkvITapjB6CFcMqm8khoTvp8tuAre/2tA1aY63qCoGR6uayAHh?=
 =?us-ascii?Q?epXtdHkN+PFSHsc4g5aPD/KFVloelTcMbUE0ctXM+SOcOKclpsAU7CfDSk5W?=
 =?us-ascii?Q?YMSfBXBL6lPXbNBkIdCKtByaRh+q3xAOh+0e8dnzTVwSQgDOYW2/jeGdYt9D?=
 =?us-ascii?Q?Jt4scfxJP/3yPcqGfsj13oTlr9rdMMUAqWICXbIwtIlpIkCD2vvgoQRzbhBh?=
 =?us-ascii?Q?QSDm1Nrc0di4bcTfFdfm1LOKZI/XsuuYRpD5UUcOrBAfdcBL3bAk3aiRQYGa?=
 =?us-ascii?Q?IcWQxDnV78kqgiVFIy8qDgf8qhHI09BetNv6c5gAuZPtGxEkF0xmnaDO41Rj?=
 =?us-ascii?Q?q8zXKQ+UfGRvyJ4EJGFfPBjp4uALY/rdy+poNdXckIf7NS804IGVnguLn+0O?=
 =?us-ascii?Q?LwGGXcCSXiMVOubdy3esUwKgX8qxc5iQiEbGLP0M6klc8qqHXaHvErnDmlW5?=
 =?us-ascii?Q?bTUnfXVSi0iM3LipqthwptTPoQBeubaJacBqwwv61Mnm+NGK8F8H7W7NVdSs?=
 =?us-ascii?Q?qS8mZ4sMlJ7JEe+dIeIQD23zXBZjisquF7xDdJs9O0Y6l5DMuuNZ4l1cppjt?=
 =?us-ascii?Q?0TcZJ4Blqh7u4Dd5kNPQZuSA2+cfmTrWZuJCp5u7Clfd+2Nyq9y5ezu9+zcs?=
 =?us-ascii?Q?CpjxTHpqKPxcYybvev1DfnsyBiNDMUrjYNrbsZ+/aWvYs7gnas0grBWQxda0?=
 =?us-ascii?Q?SksGx+Xd5hDaiPdWWLQ95ZhFzO7IiFyD1gnSXqYd5FReEEl5/FYF11NZf1b+?=
 =?us-ascii?Q?HqVzqWOqK9rK4HAOzVXcfBeUpwpSCSWcoAVXTfg+4VkY3dlfgW5HCbA54gkJ?=
 =?us-ascii?Q?6DqDQ+0ASVQJYux/ctK+fkEkzjzIniYVJK/uCQhke4holoul7QY6TthVYi3G?=
 =?us-ascii?Q?1H2KEK6uNNdpQckSO6K3VuJ/DjUqBaDoIaobdO6H1Hqrs4USNxy9sZcxtOD1?=
 =?us-ascii?Q?4GHBfe5XIdv02RxVAz3301MYwzVjL4dpRh36R2wAHDMFoKkloykyO/WTEAtO?=
 =?us-ascii?Q?2aqBvzowC/4Oi8c8tFpVg8hDL96FEVc+l95fR4SZpUJr84NCKQHA/Mf3rRJK?=
 =?us-ascii?Q?N/QmrU7TnCKqG6D/ejQcqq/W1AolH1mkTqCzZX+gSL2o7j4NFZNWFPm30hgN?=
 =?us-ascii?Q?cNe0HA6Ce6vtrpJXcx27+P+pK1KOhqruSETRpTmkR8q1ygabRf8tsvnfa7nc?=
 =?us-ascii?Q?+FKIxL3mxz/d1+EpWpShUYJ5f7xJdWQye6GRwh5AWubVwFlz+I3RyuOUQmNZ?=
 =?us-ascii?Q?cXgJZiBXwZRVJXm8lAxWdZ5Us67bEuUTiub6ovK8qTWLupPdk9yF2+54f70l?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3d14e6-9126-4136-e323-08dd08ade9a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:21:59.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItZz4rZ231IF67PUpofPGZdaMLyt3/jKlpvSVytvXfy33nkgwY5f2iKLdCt6Hk3pvlBrEfs4dMU8lhBQEwKNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Tue, Nov 19, 2024 at 05:57:06PM +0800, Justin Lai wrote:
> Add defines for hardware version id.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> index 547c71937b01..4a4434869b10 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -9,7 +9,10 @@
>  #ifndef RTASE_H
>  #define RTASE_H
>  
> -#define RTASE_HW_VER_MASK 0x7C800000
> +#define RTASE_HW_VER_MASK     0x7C800000
> +#define RTASE_HW_VER_906X_7XA 0x00800000
> +#define RTASE_HW_VER_906X_7XC 0x04000000
> +#define RTASE_HW_VER_907XD_V1 0x04800000
>  
>  #define RTASE_RX_DMA_BURST_256       4
>  #define RTASE_TX_DMA_BURST_UNLIMITED 7
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 26331a2b7b2d..1bfe5ef40c52 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1720,11 +1720,11 @@ static int rtase_get_settings(struct net_device *dev,
>  						supported);
>  
>  	switch (tp->hw_ver) {
> -	case 0x00800000:
> -	case 0x04000000:
> +	case RTASE_HW_VER_906X_7XA:
> +	case RTASE_HW_VER_906X_7XC:
>  		cmd->base.speed = SPEED_5000;
>  		break;
> -	case 0x04800000:
> +	case RTASE_HW_VER_907XD_V1:
>  		cmd->base.speed = SPEED_10000;
>  		break;
>  	}


This is new code added in the patch #2.
I understand that you want to have those preprocessor definitions in a
separate patch, but why does this patch have to be the last one?
If you had included this change before the patch #2, you would be able
to send the final version of the above code (with no intermediate
changes).

Thanks,
Michal

