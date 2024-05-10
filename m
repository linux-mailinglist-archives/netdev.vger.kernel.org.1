Return-Path: <netdev+bounces-95338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B7E8C1EE4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBECC1C211F9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E0D15E810;
	Fri, 10 May 2024 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSwEdqDp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420815E7E4
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325609; cv=fail; b=On52v5aWr+NEURcm1wiPSCm5kg2WNJyxIEFF/9GyuyKBjxuXapucT4cPGiIayDJ0pZQY7WUVhEPUdociIJ/PfNk796D8NXA3r0NYszu8hXR2picz2VABbPEPo1cHwML30QaTAZ/uAljBDMnDTuiX2n+9TXzHrkc2pR3ALgzLFKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325609; c=relaxed/simple;
	bh=OTMHUZ3QewwzHQF1Bhn8YAJrWBkXSm/0GPJ96PBx/mY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MiPIHWWPvjn7Y24bbKN1P0i7YDDlDATBq9Fz0MYcN3x7uX2KZcbsyvtxhaB4QZQOuV9XI7kVz3SKbrXmwtJSaPt4l3q5aZte8JlfSRWo10rWP/9nSdlcrmJ+toj+HJE9FGpLgx1TrqAnzKSzMy07PNfglACLDhn3/XYhKfzR8hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSwEdqDp; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325607; x=1746861607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OTMHUZ3QewwzHQF1Bhn8YAJrWBkXSm/0GPJ96PBx/mY=;
  b=jSwEdqDptAxE5UlzJpvQwHhQD1nusDmNRvBfh/BhuYqhViXloDeUGHYt
   xdx/VOvZmBTYIIryrVLjk19yIK+V++0OQjq6aGVBxHA6K9NUktGoe/z2Z
   h+aRiLno9e+aw+mkrZiSnuED3BczI4biJLH7QbAI0fMrWX1UvLshZt/pn
   2E8Tazfrq4OQgkK+lZtArkb1OG6cuzcWXlYHZq4tWCUxETplFSvg3SOQo
   tMp4I++kj1ngv5d8thN3kJHN9sMjRqTxg2txeUtOEG0FnRW/ZCdc3RPtb
   euO7446eWyl4xnohj1wXhsCxFmLb6umiXhKEjWY6KXOmRuIQAJR5EsCOP
   Q==;
X-CSE-ConnectionGUID: 6wo3Gd2kRGeXTuEV7H43xw==
X-CSE-MsgGUID: WrbCNDeyRSaIRsO41Dl7lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15100689"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="15100689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:20:06 -0700
X-CSE-ConnectionGUID: brnbzEACRZ2WDi0ceFh/2w==
X-CSE-MsgGUID: iM9z0xj2QCeSdGhcJXR7sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29514943"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 00:20:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:20:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 00:20:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 00:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLwg8tJkMkOi49eq5ahOAYyGnRenHUCJglThvfwHS4cSoZyYPMRJpB/9M8pPpZ7UulUdUVVm6Gz+hAClqgrJsBUqNG0zYHqyklH5F5SRVnLLesKtazsMBB9fXyxXEiixeEaJue8bKVBe3Pyk4mHKOlCcFMziYJlN/zaE4BWL3cNbPBTSba7jRDIybLttZaHSTorA/MBeMELK3uSZUEgk7TdgjUWgDlcIqoCBuBdo63AiZ9Ss36yIDzV2tAOcVWNoua2HWR9Xv7VgK4A7qlThinSlDat7HuP0B/12BjkZVF06OukXcf1o5nFno+l7qM4777MR0BJykMV+EBI2/owdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5K67rEwG3jm2clJ0dGWbhTKrPbtTriE1snGM46tPHY=;
 b=Qf/YZff7GzsuzyIl0OdtYUvIuQQpe8V+/z6az8myfEx7/SBy8Mz7yEiLTax+g94G9Con9Lep/6dR4mkYXG3Fpq/HGU6Q6YdygbYXzmJVAYFj6Ms2rWVnKsESS+lYo+Zw9M1FWzvxKOuUyBZNmRYlogHA4JTKeiiRuK9bGt3kx5W3eerkgBPDomkp4FOqJ1OTr5tTy61yek8hajEmq/97yUf8GydXi2yGbY2oeqCMbjTKaQibiF3TOix/RaonvBv9xeoHpswxMdy/6xQ+h7mCWFpgcYoUq8Cyt1An4JHdDjls2O3hmaIjxNFsq4vGcKWAX0WRYsvjHOZ1irEZUvmtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 07:20:01 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 07:20:01 +0000
Date: Fri, 10 May 2024 09:19:53 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next v4 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
Message-ID: <Zj3KmQMKsTJ480Ea@lzaremba-mobl.ger.corp.intel.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
 <20240508063718.69806-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508063718.69806-2-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: a3190f91-c3c3-4f82-9940-08dc70c19aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7X2poDPMuXrYidM2Gwc7rOuuJikKoK7Fgd56Jn//bbnYdnzTpEc38MyuG0Ke?=
 =?us-ascii?Q?VVr+yObCE5ki5Xa9mLZG7gXI7uVzZ/Px8fZSqqDCHbfu4J8rPXQwYLYh29dD?=
 =?us-ascii?Q?DF6w0dvQ3ZJVquejaiEVjq1j//9IOeX4LOYrxObMmd0dcvmU3ETm0oiuAW0N?=
 =?us-ascii?Q?aWANsqwS/s8wy4rzToC5t7H4qrEMXc+11LKCCspnPd9cnATyVaV6SK+j79Zo?=
 =?us-ascii?Q?VAhP20r2IHRTGE+dSgIFpEEUlXb6s1duTvKggoqAB6GNsdfF0XjAcVuJuYGp?=
 =?us-ascii?Q?ix+VsIMXYx0uhEPvSLFbtfYAHi84VdqGsB+0ysF8qYMoOTQrfbP70nHFtVLs?=
 =?us-ascii?Q?M3TzvVncBfNhrF0+9bYwL49GQkxeJ8advNFtG2TPqZ061C54g1z5r2uY0h8X?=
 =?us-ascii?Q?9rwzDmtoqCpfByx+PmTmdtvSjRd91sfV2l15TaB4POwIYoV4Oai2sfTn1NXp?=
 =?us-ascii?Q?PtHRt7h3UftGkffEbD1qCw9VriCn/okRum1m7TZAywQ0vvmrdV7BfwQyvWnl?=
 =?us-ascii?Q?QoGfwVvaB/o1pGSndlOwJypwPmWsRlu+OtY6h0/MJSCMM4s+Q+IYJLXF3KsS?=
 =?us-ascii?Q?Kj2t96xI/pc35uyDx0eeXa7iXB8731suN0q/TNHjL5lU5dTBxA+8vkjm62aE?=
 =?us-ascii?Q?lgbtWlAcv0aOHertKU7LPA3FQPrPgYGKtO0Rw0XZysUbm0/ni84eXt2gGR2R?=
 =?us-ascii?Q?2MzNliohf78cXvgZDKhkFr+pAlb43IWrX+H1rBKLxZJDqUyvXppGmzlgtbss?=
 =?us-ascii?Q?L+044dD/lJtrMxj4fmdg9llnrFNY9pFV946GaKAsf0PURU9a2oqNpEPmtG+u?=
 =?us-ascii?Q?YMdI2Jp2+8XFXH84zXAcgGJLpn2NL6YbUGjFhBjdYnYrvCzifBbtWb1Y9tRm?=
 =?us-ascii?Q?lgGMKFb90yPzXpuNK+XyGUCLR2rRjlsDHYMO+QOlZlHUGshWyzzVwAMOaFWV?=
 =?us-ascii?Q?zGOQknxCW+YYcglSMbsMZivrs459HUTYfgCi6OPZ8aP4Bbz1dCF09PzFLS6n?=
 =?us-ascii?Q?cCnWVXX7sWgRx4P9jDUOL4haQ0B16yr/8FyHL0GIErAlLYggWLtJ2yYLby1Y?=
 =?us-ascii?Q?m7E7cLWNhJ4I4LG2WGf4Tfk4B2u8LIx5vmj1L7W8f8fzAjUuFKneKHWBLU1W?=
 =?us-ascii?Q?LbyhyZnphBUlqnvlum06gBnORYy3Pf91caOQwaRzP8wN1Tf12Yf8uP1LO8w2?=
 =?us-ascii?Q?XiSrcxTwmAYPl0qRg3IYvemw3do9HjPBO3akEIlqGAAiyrwOcS7pnoG6Kfcv?=
 =?us-ascii?Q?BWeLBosofnwRet/J1OOLRkjEPAKLP431+26pEBakzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcKVQVB4DLXlkQSn70gZNFyyWIWDtX3xMx9z69O81f6gPP3kdJ5hzc53/ilN?=
 =?us-ascii?Q?IJdKZN5PW35eOV5WIauq22sWPouq1xiXKsNW77RekR+XzocYzhcAcTkv8lyE?=
 =?us-ascii?Q?3Wa8g173xbnCsUSWS4rTJfxd8esfE6TZegUZY9a3Yn0qBCc2z/bKU2hTnoWG?=
 =?us-ascii?Q?vm+sG5wBBV7hoIVn7ZpLgr7CNOcy9+o7rm7q54mTLzevqtVcypQoDdUABAEI?=
 =?us-ascii?Q?DdL/euvnHZ5x40E3ENcZyzGv70Hjya3XbzImuG+58/g5RYYPFAbectDGmHCr?=
 =?us-ascii?Q?kXY5RN8cFhgF3qWa/0H/PfradX7qw+T9pA7oiRddB2dGEoSS6g3vdNc8A4cB?=
 =?us-ascii?Q?xwmpIvOE1rpYcEQ/rColrdUpMKM+y9PMBC4N5D6i8Odwzt1W/6DgR/iRjbo1?=
 =?us-ascii?Q?RQ7PBdtTvm/RQ5XvEkB+woCzS6zA2erm6ildQPGqr5D362PueJVNayBYSc4K?=
 =?us-ascii?Q?MOvSktA2Z2snvGTZ+ed3h0fHfTCoCJgY1v3Y7goGfDenaC7pibS7wQ93UPFc?=
 =?us-ascii?Q?gfa3nkifV+zim8KXRJTH24a7A2Wl0vzMNjeWA6wk2wR54iGaaTqd30uNMmYp?=
 =?us-ascii?Q?sWHqTLMHI3qJUpp/PWbeyo5codkF5FNxQ2Ye3OHTGGSavigR41xoMngxNPHI?=
 =?us-ascii?Q?88owBpMl6JSBoiCYhz7jHgOPai2aSkCp/pLdixCH/HTNoB8rF8hRmW7hsj3U?=
 =?us-ascii?Q?IJUPCZWX6D4dLb52JvymqnjefSDc1jtX+IUFzHe9LlHCckSU1AGbNGlpAPWu?=
 =?us-ascii?Q?6wlmo4F5QGFg0A47UUgGJl8PvFx1Yb3NjaqxGKPdFF6T0peq5C3xLdPz7RIb?=
 =?us-ascii?Q?/jDX3VZtVUhsGoLfL7Y+SBbM3bTJ2rJe3ZqhJCgXXbDwUzAvJuiCgMwl9Fil?=
 =?us-ascii?Q?wpTcIumj5BNq9P07t/RxBrRCrPV6JAW484+5bx3fJjplyNmnTs5mzgDVSzpZ?=
 =?us-ascii?Q?SAzrp+X30jhLzWWIz3kc+RHKN5OS7n9c/DxhmAFyw5jVPQu52nQkNpNlWdYi?=
 =?us-ascii?Q?THG/AZyS3rqa04cI25tRhj51eTo9P78g6FHB+An4k5wWltIAK0r5LtY2qEdt?=
 =?us-ascii?Q?iIc+sHrcBi0AlbloahfG0Bt2Vt8TbWN4Ex5SvcCnxxY8j5g7BSFvQn/Z3cZ/?=
 =?us-ascii?Q?Ttu9d8l8hVLAif/r/nHFsS9Cq46o7mXcuPs7WdDinXRePlGxs+vo68RbeweB?=
 =?us-ascii?Q?oDJOayk+4vYjz4JCL3C/+qaBMQ4YXF6RN2G2DvxTw9zGcgKJl1VcJbQ35ieQ?=
 =?us-ascii?Q?wi1vD01UDpldJv/2wAig3VL80GzgR9M2M3Vtx5/Jc+3N1atMTfV8FI9wXfiB?=
 =?us-ascii?Q?QgpGqXapc+MJof7BdYgXTTiYuEbBL0GFT+ce3gU0+4ovTtTgQuilTHCUblcK?=
 =?us-ascii?Q?QdDkdRZvVywFdjpUNFX64yXn7BzZyCk7dITC4/Bv8zOcl4i0/hwOt0JhqGVM?=
 =?us-ascii?Q?k2e9zfcNZDKL4fBPNg/UyS+vbOhuQhoD9GSPz+f694/DbFcfWlGwM4+wGPs6?=
 =?us-ascii?Q?Kb1Dw5/Eqjy/uKwKB+F12a7sSZgKC9//ay+ZVI7TWvmzTlIS/xXxUthwD3sK?=
 =?us-ascii?Q?7tjeEEyNY+f3hu6iXfTFex4oMRSqZU/5GHQ7uaOWLsMqg6r7+xZi5iowkI0N?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3190f91-c3c3-4f82-9940-08dc70c19aca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:20:00.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1pYJQ79cEkY4dW1KL11i7EDMIFa2pYu3T+H8/+XaR9iRTvWMxRPWQpuwxYI1T+ixN9um+q1HgHBtYV02JwNu2mnXeCkKBk4rHZD7CGvdUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com

On Wed, May 08, 2024 at 02:37:15PM +0800, Xuan Zhuo wrote:
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
> 
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6f7e5010a673..85d0dc26ae9f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   *
>   * Returns zero or a negative error.
>   * 0: success.
> - * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> + * -EINVAL: the vq is in use.

To me it sounds more like -EBUSY with the current error description.
But I suspect that the error is returned, when the following condition is not 
met:

* This function must be called immediately after creating the vq, or after vq 
* reset, and before adding any buffers to it.

If I am not mistaking, then a better way to put it would be:
* -EINVAL: too late to enable premapped mode, the vq already contains buffers

>   */
>  int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  {
> @@ -2798,11 +2798,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  		return -EINVAL;
>  	}
>  
> -	if (!vq->use_dma_api) {
> -		END_USE(vq);
> -		return -EINVAL;
> -	}
> -
>  	vq->premapped = true;
>  	vq->do_unmap = false;
>  
> -- 
> 2.32.0.3.g01195cf9f
> 
> 

