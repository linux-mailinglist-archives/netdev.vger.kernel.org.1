Return-Path: <netdev+bounces-67328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351FD842CBF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CFD1C20283
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AA7B3D7;
	Tue, 30 Jan 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXXqFTkp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A867C51
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642921; cv=fail; b=WoHlkHwN1VpbussFzGhJfBftiGQ4FOil5lRg+AuNMEv51qBrRhrhs5bEE1TSSMCz8O3Ypf6jGtgA5n+Pp9eJ3mKJJua/NJTwirtiak/ppKUhxW0S6HydtBfFQLFtWCdChrYHkNVM1+W+ZDVR5WTvEhEftcIuaiEQ9bSrhfZhFhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642921; c=relaxed/simple;
	bh=gwn+LL9TzdwtUJaomW7OC4j3X077+S3DDUjgoU9e55Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rVZgvdgpxSZ4kesLocjSAKw90RLNqgWpck+YPd0XrXA826I+Y6OgmhEGQJQb0NBsmyu5o0FSHFd13uTimrv6d4rBgsdiQp5w7PkM0m87DEZvOgE3xedBQ2Ir70zuKb0iH13ZAQd8XNvMe2TvemjTZhWnXfgmCQIcwTumZWNMkCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXXqFTkp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706642919; x=1738178919;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gwn+LL9TzdwtUJaomW7OC4j3X077+S3DDUjgoU9e55Y=;
  b=BXXqFTkpibqdOhg2gWd6XQtbajPMSDWLbnVockvoUC20A13+ApRmAaSA
   wpkhQ78Eu9d1NrCnIPknXdF+ZjVLmLQifH9RjCiJd487MCOqWw/rOluVC
   xVdc3ru5477l4R6EwENn4aH+ikhxywX9SgVHS2bICFgMXTHoJTN3+k1Mx
   2TH+fnYBadUbKmwa46FfY2+V7hkFGIXRSPzEd+YcP+I9rgqnDZBdMKfiR
   ynGT0fl1rqDTaWXbdCDmrA7iChMQwCuSCfbPyacH0W4n2UsI3E+/g+81k
   R2nFzXrRYXjvoef4zCNcX0qdZk6N5eynCVk9xWkifZJHEuRkGlHu9ViqK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10025791"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10025791"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 11:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822302262"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="822302262"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 11:28:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 11:28:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 11:28:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 11:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV8VSAYyxMw8XFN9Ce+IUNW9hW4h8HnqPvtyyc5+jUtjOLxv05OwhHUr6QhrpTbmCmXZz8unhg811exlnQeR74fietsMLLC82VK7BPiy0H4eP+w4gGsYD7f67OejJsxcP4JaECRBGQx42XEpUhny5rGjJicKaVnu2EPrxnnoEpioNlZyH5bPYA3whwQhTi4dhrdDcqrwEjJfsdewZFcRsmuY3v5mKxdLGccOVT92PFKfumj0oGWopeWlQwgqxUxJ7qfcCcqRSD4iZiQEfxMe9/9OOpqZegBUVhMink7M3z1Xll/apPtghdv+RpML48szU9tH5hsi8Ucz4iOXR+Uj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9G5xvPWzyAb/B3G4DOH9BjugyzBVkv6DLNo46qeJag=;
 b=GYR+MrQLHl9x6gi17GKMMV2pnYqLsu+FVqtm/y4HhP2qHYD5ss7r5z1KONh6+THA6il9EiEAzrAiJ3OgmsruvTXsjKLgBNp9RwiTudTo8AIuo9pUjqaKwJEF5bHEaj8p3xxPBBaMGH5Fcz2OwaOGg2XQVNK+UTqbiVoyXzk5to88ivlK96fQtxnpGvQNFYZhwbjy9zaZi4ATnb035eShZgGvgwvHdvuHw8TSHPMo0Rm/bogTFBmDUMq78EbpU37Ecd16WHIX2Mux+nF/CTssKDYG+qHyta75LiznaGlLVPRWl3UnsIHaMkf3TNuAporwmmSs3oD51RobPmhO927ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Tue, 30 Jan 2024 19:28:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:28:35 +0000
Date: Tue, 30 Jan 2024 20:28:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Seth Forshee <sforshee@kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] i40e XDP program stops transmitting after link
 down/up
Message-ID: <ZblN2ABkWPM0gGZB@boxer>
References: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
 <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>
 <Zbkq4cVJ1rEPda8i@do-x1extreme>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbkq4cVJ1rEPda8i@do-x1extreme>
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa3355d-f01b-4607-ca8d-08dc21c9a6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ce/PN0mfqoMiWOTX5d9bDoqUtE/suyMJp2l31gCOxqJyVQYY6D+AM9tbdjWoVSDEPOXfcwr48ZEZdir62U+idx44habJNaW9wWf3OSP+/XOauQStqJmaqul41rLW2OZDz+5su10iEsQgfF4VKWzzTDANhzfS/aQ4OjNSCoRQ64ZMHyEIG63HXKqmK9ECy7c6DQvZt72bXBo8TGr/lABoLnxGIJpV3YJfMim+0gcmzH/2yDevKTuelTNIFPymfuaQ1KxWc0bgl2aWRxlDDvDR9hTZy/MKvdcoTvC3te2QMcGT1dOHqVttcxiPsk0IWsCeUeHHE1AioYEBBRm8kS1gxmCSz/HPvZHDnb2pZDXO+StqCjKOxO/qdO4HO70gm+tm1FQ9KLBHM5/ysGgNaPxGgsuiNydMdDFyL9ifrDqX9TCqZkaY/vxkBqMbNbEpo7bcSmuL1hpt84dWsYjXwapYcKKamGsmEH3Ki3HZJ3zcMNL0hXec/aeVJWqliaGxglCE8/gfIURMCCAjDMNd5Qkhe92uZM5H6I3POBi1glzdDmxGR30Bj0/7KWw+yHy8bWj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6486002)(8936002)(8676002)(4326008)(5660300002)(2906002)(44832011)(86362001)(316002)(66476007)(66946007)(66556008)(6916009)(54906003)(82960400001)(6512007)(6506007)(9686003)(38100700002)(478600001)(6666004)(83380400001)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEI3NE43Mi96Smp1WG5nZlNCOHJwZm5TeXdWVEplMnVBbmQ3aGVsa1NqTFZK?=
 =?utf-8?B?K3F5cGpwRHhidThSelVYNkdJd1pFck5HYVo4ZUc2OFhYSXJteGFpdUFZNVhK?=
 =?utf-8?B?QUNic2ppU0V2ZDJUUE5ZL3NMRmdrU01CWkFuVHdiNVVaNlRHSkg4UTQwUlND?=
 =?utf-8?B?eS85dDV1ZFN5OVBXMmsvbkNGSnJXQU5sM3U1YmtacEdLUDAxakk3WW83M3BK?=
 =?utf-8?B?bzFxNnpKd0VoeFZLVGxOMXhHbVVuOGdyMnEwVGNZd1VadnRtbllGQ2JQdkNI?=
 =?utf-8?B?bmhoZlkvR21VN2hzRW5uRkQ0ZWJYWjZFMzVRdkQvMGd2VmRNMW4xYUdLL1ZU?=
 =?utf-8?B?MnZ2dWd6aEFlZGJuRlhWYUtPUWp0MGFBNkpGcGtRcXZqVDBMMnN5bXd6eGZF?=
 =?utf-8?B?bkRUZVpZWlpQOVpwb0JCUCt0RnhjTHo3ZFl4dzd5RUljWFJRckNEK3lFTW5a?=
 =?utf-8?B?YzJjYXc5L09HMFZDRkRuSVVNZU95QVRRU0ZZNXcvRUJ5aG9rOTJKWFpad1pq?=
 =?utf-8?B?ckthai9HYTdqY1dyRmZvVGNUYUZTVy82alYrSlVFNEplNG9ieGN0dXVNRGVC?=
 =?utf-8?B?K2huaTQxaDZJZ0NBM1NwaU96QnplSUkvOXA2ZGFVWmdKRjVaL0tXRUQxUCtI?=
 =?utf-8?B?MkNEcnllUW10USt4Z3o4QU5wQ3JjaFRqd2Y5bm9FbEMydGtDTC9MMSsvcEky?=
 =?utf-8?B?aVFQVHErT1Mxa1pXNllvWHozVGx5bTVTczk3MGlPMmdsSzdIVzRIYzU2WVdI?=
 =?utf-8?B?azlnMHdjYTQ0cTZaS2ttS3ZzdTE3clJ2Z1UrUUxzV2M3K2VKbzkzQm1Kd0x6?=
 =?utf-8?B?MndlanRjZW5WTW51QTB2THZzZFRtaWVJb3ovQURGblFneDlDSXRLTHIvWXVp?=
 =?utf-8?B?OG1pbFpWWDdaVVVVQUE3NmljcjZtV1Y1M291MUhvWmxUdVJxVFo0Tm5lUy9T?=
 =?utf-8?B?cEpIeU9JTDNtZkt1K25ablIway9jeWtDbTA4SmZ1UGxrZlhrSWlUMnA1VUU4?=
 =?utf-8?B?NWJXRThQcVlWVktxbmFxbWxRQkxPY0ppdTdyaWxmcnhORHNZTkdlZVozN0pv?=
 =?utf-8?B?K1BnTzVKTDEwaXdjT3FqNTdpTDc0NG0rNWdtRHZ2SWRxOU9LUXZnd2lJbGpl?=
 =?utf-8?B?UVdKUnlBYVhNMDRPaE1XUkhHRWp1ckJRd29pbTlMQnJFQUtGQ05LSENySjhM?=
 =?utf-8?B?M3hJcHhFZGVZbnZvMmNHcXJoQ2VsL3V5eWZjK2QyVHVpNFptaFJyZDhuQWlI?=
 =?utf-8?B?ZGJXN3RWUlRub3VxMnJqbVl0eXlnZFlPS1JaMjZkVHgyUHdJdlhLRmtSa0ZI?=
 =?utf-8?B?RWw4SDhCQ21lQlpxemlkRndyU3FUUXBpR2NRVzlBSDFFYjVUYW8wanh2Qnp4?=
 =?utf-8?B?VmU0NFdLK1pxM1JrOEZrZWZ2a094YmlMV1NGZSt4WkcxeGJvc0FEQURCMWd0?=
 =?utf-8?B?aEpya1V6K1ZhUU5oempFam5UOHh5aW0yL3pnc0Q2ZkRmMlQ3Q3poNllmYnhX?=
 =?utf-8?B?dktMTFlYbHlYeFJtbUVHN2NwUFpBYTFFZDZBZDdNZ0dKOXhtZHd1VmF4UjAz?=
 =?utf-8?B?c2hKSHhQOXFuQWNrSCtqSEw5ay9VRVJDcCsyT3hZTFNiSW9UTDEzWkFuRW5u?=
 =?utf-8?B?RzJBalJNT3NpS1JrZXRkWjRnMTZ4MXJ5MGU0bHRoajlwWVgvbnh3YWh4dDhM?=
 =?utf-8?B?NUpZcVc5NUhKL2VpVjdwSTNYRStzTVpPclhheFMrYmJQWHNGNzR4RStxNWxo?=
 =?utf-8?B?a1htQi9vZXB6cXZxKzVXYjd0VjdCSEc3UUE5ZTlYVUlvVlYycFZmc1JXY1JR?=
 =?utf-8?B?enRNQW95SW9ZWXVLcUxWMUxCWjFLaldLUWNPOGJCSHVFU3kvMWhtRVU5RmdZ?=
 =?utf-8?B?S2xkTTgwVXhCWmF2NU5WM2NQSXNrWDBsQlVSMkNSbVU3d084WU4ydXRwa2JL?=
 =?utf-8?B?MkVVTDhZNUJTUzNXK0Vjc08xa01Kb2YxMDEzTnNoNEN6SC9uaHJDcitOUjFv?=
 =?utf-8?B?dnBQbC9mMmdYa3dUUkR3cFlGaDlnemdrMWRtRytYTkN0bFgxY2ZlQzBxZ2J3?=
 =?utf-8?B?akRmSzVXdU1qZkhKTHNnTUR6SVZQTENESmtuRFo4Q3FMUlpsOXBIbEJRRm85?=
 =?utf-8?B?ejhvams4eWppQ1dMbXJ0U2tyd1piSjFYT0ZlTDc0M1huaXl5RGFXdnJadjlo?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa3355d-f01b-4607-ca8d-08dc21c9a6d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:28:35.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAqRGYem/zhepgG1kLxL7v+qas6KMYigWY0HcJHDXaio6wG9+y4kANsmHSEB1DR5uXcDxwzfCZI+ariUJpjT+ItfwkQEftcpIKuPq4aEkzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com

On Tue, Jan 30, 2024 at 10:59:13AM -0600, Seth Forshee wrote:
> On Tue, Jan 30, 2024 at 05:14:23PM +0100, Paul Menzel wrote:
> > Dear Seth,
> > 
> > 
> > Thank you for bring this up.
> > 
> > Am 30.01.24 um 15:17 schrieb Seth Forshee:
> > > I got a inquiry from a colleague about a behavior he's seeing with i40e
> > > but not with other NICs. The interfaces are bonded with a XDP
> > > load-balancer program attached to them. After 'ip link set ethX down; ip
> > > link set ethX up' on one of the interfaces the XDP program on that
> > > interface is no longer transmitting packets. He found that tx starts
> > > again after running 'sudo ethtool -t ethX'.
> > > 
> > > There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
> > > timeout' message in dmesg when disabling the interface. I've included
> > > the relevant portions from dmesg below.
> > > 
> > > This was first observed with a 6.1 kernel, but we've confirmed that the
> > > behavior is the same in 6.7. I realize the firmware is pretty old, so
> > > far our attempts to update the NVM have failed.
> > 
> > Does that mean, the problem didn’t happen before Linux 6.1? If so, if you
> > have the reproducer and the time, bisecting the issue is normally the
> > fastest way to solve the issue.
> 
> No, sorry, I should have worded that better. I meant that they were
> using 6.1 when they noticed the issue, not that kernels before 6.1 did
> not have that issue. We've also tried a 5.15 kernel build now and still
> see the issue there, we haven't tested anything older than that.

Hey Seth,

I am observing same thing on my side with xdpsock in txonly mode, so I'll
take a look at this and will keep you updated.

> 
> Thanks,
> Seth
> 

