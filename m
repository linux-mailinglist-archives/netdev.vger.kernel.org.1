Return-Path: <netdev+bounces-73328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841685BF01
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6B02886E3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D56A35E;
	Tue, 20 Feb 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPLPE8XQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77B2D796
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440197; cv=fail; b=aLqwH+HQPWzIInsBIwtZudN6uFdrmIH8fTWV3jm3oU1UgKzI+/29u+dP0Uv8kUXZ8iyxW6k1UTG+zlURqeUK3vFwAT3sA41KQgxEpnA65exLvRIa/mFZSbZRsolRNIEgsE8yNGxJeZ8iCnVFoDfB8vLItIjt/+vRz+HKLq1kzOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440197; c=relaxed/simple;
	bh=i5uU+SjewztxUkkfVsW9LXCWsqSy3YGDtQ9KjSI1KKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kTixvlEuwJVzmjU1BJJpTbk0A15MvSO+EZwfIfIDF70KxTT8ieovk4JavEUAtynV29bSHC8AtgAHTfjGCgwBdKZv6EvUWZX8z6HVDGWOuRGtUwa2cb5urveqzFqQt8fjiHJSnNMZ334xHYXNzftxgFBhaEk+gGUK2LFC53hEaCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPLPE8XQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708440195; x=1739976195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i5uU+SjewztxUkkfVsW9LXCWsqSy3YGDtQ9KjSI1KKU=;
  b=MPLPE8XQauoOnZHm0JZLDb+ku9m5gOiXovFGVR/bjtWTwQ9iZ3Uwva40
   Gl4F86bm/kDgAx6bErfGrt526S3eXBKvnK8++dERVdvW2Wquctx4zWoqC
   h97WRPhPV/V7Oh21YhGPQrwIiktFvIE/IQWfe2Snny6L6hzurzLQaQUYA
   /AjFOlrC225Qq1qmbUHaJRKk6bRT8Gxhqm7JjQaW9D2qUlBy/pwy7RGuW
   xjsdmUYQ48c8mfBXU3zU11QgHcFos+EQKwg3kpht/DfpbWg8gGInMA1tu
   ywSZrOvcGDb/CyE7Zkj+z3l8RBteIHsCLNRBKRcRT4J2cpmB9tkLDNN+R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2678157"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2678157"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5031327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 06:43:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 06:43:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 06:43:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 06:43:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 06:43:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL0APBEhZdl7mEYvcAcXIpzwjaz3Ex5TNNQ2ucld/TuRbDPmD0w4NN7n/iou6jIigBwyCTaYFv/Um2jY+Htq8N60ZfkNnRyV+etVWn6qUgwozcpfiWdXAWAQQ262qwGnp5CPzZNwCRj84quxxnP87UPFEkc6G710VSCyxza9vyIg29LpZzdMZ83G68ybOWdOa4pzuamz2WuhtwtRC5Ox6tdSUCeahkHEjePMsVS9zFGwkacAq53NgWFW0aHALLb/DAlCFv3evgfwPTclCStSTZkqeOnoQYt3Aziu+U2cDIvuvy6X37W1xEKltjJV+PMKbr/mlUlXzYC8D5yOKCNGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji0gxpvJjY9N30akseeelCnCL12jpx0xxl+YriLgc3U=;
 b=KpNfcJCEgj8qpJc1QCgenCPEMfZZ8L7igqgxIXIgAZNFEigh7KNvVRWoJIQJpxRbFd1ZInN7oYqmD7QnqyS1PXqFyvvEl/qACqFtO9ZcH7REJTw+L5omT8arVqM1sOglF3FT9P34EnEmT/EqPGHYNAQYScaaY7+ckIEYx7ZNwigBmomrgqojH7nDzgGNMQnuGgBnlSQl3iPwEys24H9FaMNR5eO0yPD120sGf83lyRwTCwgSetztTxHEZ55+wa0+AKqS92EjtoCL8ecfX6LkV6BGn395bSSd7pTGloIdCmFlXsVcgFnRwSZXh/AITOn4kVtP+8dlGDxfJh1S5lhWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6711.namprd11.prod.outlook.com (2603:10b6:806:25b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 14:43:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:43:08 +0000
Date: Tue, 20 Feb 2024 15:43:03 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: Kurt Kanzenbach <kurt@linutronix.de>, <netdev@vger.kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Stanislav Fomichev <sdf@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
Message-ID: <ZdS6d0RNeICJjO+q@boxer>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
X-ClientProxiedBy: DBBPR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9924ad-1d15-42a3-cb71-08dc322240e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+Fe9JJ1WsDdwSE6xKCpnjCcftkMnSjxsypPi3auEbdGzl5A3IWEx1r57VF4c/7WkIFyLpORhgUHCAtgbBU5efJWkHUBCIiZQF92Nm5kRTNCj0fiMbeUvoxHSmvlGP0nftGXMWqRyb7KOLzrHxfmvzi3j+vwBxFYqerFYRy4ot/WDfa3Gqlh5C4LY5vSr6+cVQNTes7PvLpfsa55Meix7iO7xWMKpHT6+sndnwTEh99raB5ZhKOnJywA1TqpXa8+rtn/VJvWSFT5a+qExoOf7UIigzZJqis/SC5xAXAC7kQtcklXJwcO3YjbY+Mf67VJ8suRjMVhR8fdDzdeyTsCDtNNI5BWLGrd+6JKvDfmiiQDpseRK5MVUIT0Kh/lMHV5lavCT/9yBea/eUS2yiaiuD+fQ2emNXjXB9gHQHqqKmNPvDlzmmxeVgNsO953qjtzhsHKoJuv6PvPL35jwafID2EK3t2hRRxqidz6LqxOjechoovnT7K2lITBAEd8jIkM/3dRA5eoSJDCiDtm3wR+jZD3YkxOsfwgSl7+KUcEqR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqbCV2lnuESAEsE8FQglGIR7dAUMnlyXr8+0CW4z95ySsk9TX7EiU7yMaGha?=
 =?us-ascii?Q?V9WwvfmkfKIzSUoFGaADHUlt7SJl7Lki1+GZv0TbPVaEjDBt1hl4Z3U1VftR?=
 =?us-ascii?Q?dxr88UEV5obeZKkHmn5fLxBMr6DP3Y792O+2wY04+EdXeDC1mZy6ECpENC4I?=
 =?us-ascii?Q?mci94Oy2yPPFevKyxE5S96sm00oaL4TjXhRx2rRyzOMePQ35IthM5LncoUV+?=
 =?us-ascii?Q?kA+WYBHn/GYaBaxMgFy/7Qjhu6YroKzim/hVeennfKo6/tFmff8Z6W4F+1jZ?=
 =?us-ascii?Q?PiE63o8QxfOIrsT3tOTUqNKGxydOXwqWPy2UI9tL5WTEzlYm7GytChnjw7kn?=
 =?us-ascii?Q?+Br7JwvMhl5z0IMcXrboPr0nff75V8FVyF+fWRrTP5Yu0QzQH9TSYw/rco68?=
 =?us-ascii?Q?gIEqbwXKkgGlq2/VPUOSZzAA/vA27Z1fK0f+XHTJ9N0bwodOQ3P/7n6gAQCk?=
 =?us-ascii?Q?rM7jVV2Q+uw9zWfeWulHIISP0fbdOcPQJLLoFCRSbK+3p5f7bS3Tx3WKr80G?=
 =?us-ascii?Q?fkkruw2KP1J8bmi3wad4IqsjWxSyaXcPlvjhaRXnvfUgN0yNm6fVAfdEs/7g?=
 =?us-ascii?Q?f3EDVExJGIl9dLKOIYiOath0JrU0hefkq0USb1as4Odl3TyFMbtLpT0zqYdJ?=
 =?us-ascii?Q?DIaDTwz9adgA5oP/1M3S8LyM+MRHW0k6uNwFiSbNVR3x7NDJ4CQ08p7NzaG5?=
 =?us-ascii?Q?vF2NlgzllCPO5Y/SaOY7eFyOV0uGGq1AJzWTjS7y4JnCwzvN+eSagdiA/g6t?=
 =?us-ascii?Q?AZCA/QZZ12CbjutyC7oBzR8N9fp2RyeUDXCEzgOroVsUoa1hU2oKZA3oOJY0?=
 =?us-ascii?Q?bjNfFsjhqDn2AB/CcZ9u5e7+G/g8dzekLYKqwTf48fv0VN1t684imd2CS02f?=
 =?us-ascii?Q?BcysWVnBPk5DvH2klrzr+w54u27TOHtl0XHlGQs/HP4QQazCur5VeignOf0r?=
 =?us-ascii?Q?YbRlEzZWpYONNdgbO7LNES0WyOtef2zI5XrpWpvLInOd0rf7D7wy1iogcIGW?=
 =?us-ascii?Q?jx1zs5g4b8lng3ecRC0Unnp54PLlfNqGG6ns0SDxdfP+R0leNUTdtXmBiznO?=
 =?us-ascii?Q?ieG0Umb7YTqsM8ANEiHQSBvsAw8MeiKayCJS2L136CCGoqcpBOAkXAAF9vZX?=
 =?us-ascii?Q?7m4sbiySD0543imDKVJfnOhHdsbtqc5b7ynpWIA4SR2zy2UA/XzzzRlI18V3?=
 =?us-ascii?Q?FMfsaX/ilHDuUUQ1Tms3P0F+W7rFvofxte+01Ludm4wLegu10W1+kHL2/U9C?=
 =?us-ascii?Q?QJRsA/afIdfzsoWg5DGzqJ1OvXlDhOyAydvjxiS0LH4p3JZaz+GqM9kO6UXX?=
 =?us-ascii?Q?FGvk85hdrEoCOCrI8ZJThEPxi9L9ABajqNXMuPTRA45ho1/vBZSbUg98Ubsa?=
 =?us-ascii?Q?k237f3Rmwml8fwU2Yh/xN61HttwhrmsQrfXKapIje8A6bzsux07H/817q2Af?=
 =?us-ascii?Q?3lmWQjFQ8u9oLpTbahW3AgvzztOSYxIu3jbt+a4aPwR5EwsOGjsQI3v5ZWl6?=
 =?us-ascii?Q?YQlJjXzwA0sBzRoGyXoPe78cvMZyw48fTrZTe2Lpqt+hZ0ojRKOOWj2v4U6b?=
 =?us-ascii?Q?XyY32iR6Kx4VQPMiUIWXGfH1bsdmzML5QqjPQnoCYqNGxel8HmV7e1eVkyfc?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9924ad-1d15-42a3-cb71-08dc322240e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:43:08.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdU5SDuJp+qKRocuvvQ4PFDBEsiimswsip/GzutluGL+cjXDH1aogyqOHYxlp+tkD1Wd+eZZ+/FWEAsHxswDti86aJj8LLHSI9oSt29dQ2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6711
X-OriginatorOrg: intel.com

On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
> Hi Kurt
> 
> On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> > Hello netdev community,
> > 
> > after updating to v6.8 kernel I've encountered an issue in the stmmac
> > driver.
> > 
> > I have an application which makes use of XDP zero-copy sockets. It works
> > on v6.7. On v6.8 it results in the stack trace shown below. The program
> > counter points to:
> > 
> >  - ./include/net/xdp_sock.h:192 and
> >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> > 
> > It seems to be caused by the XDP meta data patches. This one in
> > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").
> > 
> > To reproduce:
> > 
> >  - Hardware: imx93
> >  - Run ptp4l/phc2sys
> >  - Configure Qbv, Rx steering, NAPI threading
> >  - Run my application using XDP/ZC on queue 1
> > 
> > Any idea what might be the issue here?
> > 
> > Thanks,
> > Kurt
> > 
> > Stack trace:
> > 
> > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
> > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUFF_POOL RxQ-1
> > |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > |[  255.822602] Mem abort info:
> > |[  255.822604]   ESR = 0x0000000096000044
> > |[  255.822608]   EC = 0x25: DABT (current EL), IL = 32 bits
> > |[  255.822613]   SET = 0, FnV = 0
> > |[  255.822616]   EA = 0, S1PTW = 0
> > |[  255.822618]   FSC = 0x04: level 0 translation fault
> > |[  255.822622] Data abort info:
> > |[  255.822624]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> > |[  255.822627]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> > |[  255.822630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085fe1000
> > |[  255.822638] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
> > |[  255.822655] Modules linked in:
> > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
> > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> > |[  255.822696] sp : ffff800085ec3bc0
> > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000000001
> > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000000001
> > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000000000
> > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000000000
> > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000000008
> > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000008507
> > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080e32f84
> > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000003ff0
> > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000000000
> > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > |[  255.822764] Call trace:
> > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38

Shouldn't xsk_tx_metadata_complete() be called only when corresponding
buf_type is STMMAC_TXBUF_T_XSK_TX?

> > |[  255.822772]  stmmac_napi_poll_rxtx+0xc4/0xec0
> > |[  255.822778]  __napi_poll.constprop.0+0x40/0x220
> > |[  255.822785]  napi_threaded_poll+0xd8/0x228
> > |[  255.822790]  kthread+0x108/0x120
> > |[  255.822798]  ret_from_fork+0x10/0x20
> > |[  255.822808] Code: 910303e0 f9003be1 97ffdec0 f9403be1 (f9000020) 
> > |[  255.822812] ---[ end trace 0000000000000000 ]---
> > |[  255.822817] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> > |[  255.822819] SMP: stopping secondary CPUs
> > |[  255.822827] Kernel Offset: disabled
> > |[  255.822829] CPU features: 0x0,c0000000,4002814a,2100720b
> > |[  255.822834] Memory Limit: none
> > |[  256.062429] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> Just confirmed the same problem on my MIPS-based SoC:
> 
> Device #1:
> $ ifconfig eth2 192.168.2.2 up
> $ pktgen.sh -v -i eth2 -d 192.168.2.3 -m 4C:A5:15:59:A6:86 -n 0 -s 1496
> 
> Device #2:
> $ mount -t bpf none /sys/fs/bpf/
> $ sysctl -w net.core.bpf_jit_enable=1
> $ ifconfig eth0 192.168.2.3 up
> $ xdp-bench tx eth0
> ...
> [  559.663885] CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 809a81e0, ra == 809a81dc
> [  559.675786] Oops[#1]:
> [  559.678324] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc3-bt1-00322-gb2c1210b8fe6-dirty #2176
> [  559.695824] $ 0   : 00000000 00000001 00000000 00000000
> [  559.701676] $ 4   : eb019c48 00000000 bf054000 81ddfe53
> [  559.707524] $ 8   : 00000000 84ea05c0 00000000 00000000
> [  559.713372] $12   : 00000000 0000002e 816e9d00 81080000
> [  559.719221] $16   : 00000002 a254c020 00000000 00000000
> [  559.725069] $20   : 84ea05c0 00000000 852b8000 00000040
> [  559.730917] $24   : 00000000 00000000
> [  559.736766] $28   : 815d8000 81ddfd88 84ea05c0 809a81dc
> [  559.742615] Hi    : 00000007
> [  559.745826] Lo    : 00000000
> [  559.749029] epc   : 809a81e0 stmmac_tx_clean+0x9f8/0xd64
> [  559.754974] ra    : 809a81dc stmmac_tx_clean+0x9f4/0xd64
> [  559.760909] Status: 10000003 KERNEL EXL IE
> [  559.765588] Cause : 0080040c (ExcCode 03)
> [  559.770063] BadVA : 00000000
> [  559.773266] PrId  : 0001a830
> [  559.777740] Modules linked in:
> [  559.781150] Process swapper/0 (pid: 0, threadinfo=9e75df13, task=e559c9e5, tls=00000000)
> [  559.790194] Stack : 00000001 00000001 00003138 00000001 001a07f2 4696b1a6 00000000 00000000
> [  559.799552]         00000000 00000001 00000000 81080000 00000001 00000000 84ea0b40 84ea2880
> [  559.808909]         84ea0e20 00000000 00000000 00000001 81600000 81ddfe53 810d6bcc 817b0000
> [  559.818265]         815d8000 81ddfe10 0000012c 80e83fd4 84ea05c0 a254c020 00000000 80142518
> [  559.827622]         00800400 eb019c48 81600000 00000040 81ddfebc 84ea05c0 00000000 84ea1320
> [  559.836979]         ...
> [  559.839710] Call Trace:
> [  559.842435] [<809a81e0>] stmmac_tx_clean+0x9f8/0xd64
> [  559.847985] [<809a8610>] stmmac_napi_poll_tx+0xc4/0x18c
> [  559.858885] [<80b2db94>] net_rx_action+0x128/0x288
> [  559.864232] [<80e84d48>] __do_softirq+0x134/0x4e0
> [  559.869489] [<80142484>] irq_exit+0xd4/0x138
> [  559.874261] [<807cc768>] __gic_irq_dispatch+0x154/0x1f0
> [  559.880101] [<80102d50>] except_vec_vi_end+0xc4/0xd0
> [  559.885641] [<80e78884>] default_idle_call+0x64/0x168
> [  559.891288] [<801975c4>] do_idle+0xf4/0x198
> [  559.895965] [<80197990>] cpu_startup_entry+0x30/0x40
> [  559.901513] [<80e78c1c>] kernel_init+0x0/0x120
> [  559.906477] 
> [  559.908126] Code: 0c2682db  afa50048  8fa50048 <aca20000> aca30004  1000fded  8fc208b0  8fc308ac  0000a825 
> [  559.919047] 
> [  559.920734] ---[ end trace 0000000000000000 ]---
> [  559.925908] Kernel panic - not syncing: Fatal exception in interrupt
> 
> No problem has been spotted for the XDP drop and pass benches.
> 
> As you pointed out reverting the commit 1347b419318d ("net: stmmac:
> Add Tx HWTS support to XDP ZC") fixes the bug.
> 
> -Serge(y)
> 
> 

