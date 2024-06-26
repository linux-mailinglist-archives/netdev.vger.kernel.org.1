Return-Path: <netdev+bounces-106931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB9E9182A0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AA51C240A5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA49181D1E;
	Wed, 26 Jun 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRMn3j+O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B848825
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408982; cv=fail; b=cqQ4XsE2oXzvPSTsyCs5YHMoMGCoKP7882NNTgP2aEOoKyYxDVw1LuczJedoCHZBMVlQMlfNER+tOeur7wYpeNx3/tCd5QP6IHQVhzo5ApGXkt+Akj9BfnjMGlb8f0CrkdAhGmjFKfkpkRRVq6L6tOOAhPkMH2hBYM+IDJ6PNhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408982; c=relaxed/simple;
	bh=w6MQBJq37C+z4P1BUS0f0UHh06zmXh/6tj+mEcXWlH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FRsf1NFGPCH//DYKEYSQZ8kXlPOd0MQIbd7SkrdYtma2e3CtcbpCbGGqHIk4aBtpV0nQFYs8U9dnuVEpl4z1KOI8VjdKj3o7sFslBGaIAmzCor3OCihmytyF/wt+KbokTSipwDbFLCQZJUwxOJQqBlpd2vKtITlFNJJCJWZQeEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRMn3j+O; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719408980; x=1750944980;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w6MQBJq37C+z4P1BUS0f0UHh06zmXh/6tj+mEcXWlH0=;
  b=mRMn3j+OW4IvHP/E0inzEeZRsRvYbr6+qUa2h/WYjzoTv7cyxgv62aZh
   6boeAft+N73c3ptHwA/Lk2BuqBMGVvY4HH8mA/R1vh/ecKeJQkLivp0IQ
   8azWdegdSRo6fn3DlCjZNetZ5bMle9OAUfUXobq+y1QqmaBiJDXgAbQcp
   +Nf/few1RgB4Ndk9Jsuw7d5J4gVTV3wodZ9EO2cwF+2nMevWaG+gDZylA
   CdyU2/O/lT1V5K4W5vDJ+rP70B6UzCEpdarjRG7/w4MKb8i0FYOrvZeJZ
   qz3OLPbQ35jd6LmqMtI/0lwKP/VUfvTAjjmK9/GhgoUi5CVRiQq5F/dGB
   A==;
X-CSE-ConnectionGUID: oFG1AMsUTRm2K78AIQ9edA==
X-CSE-MsgGUID: 5SOpye2qQaS8sRTdkumDsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33934942"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="33934942"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 06:36:20 -0700
X-CSE-ConnectionGUID: xbUSkha4Q6+WTrXQseAd3g==
X-CSE-MsgGUID: Pm3MFKDOSPWLgmd62SMMOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="67224325"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 06:36:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 06:36:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 06:36:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 06:36:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzP8fbaqArGJitS3XOclY8Jkkxf46R9HampOSw8noVf7vO6tnNhv0kwBJG0hnEaREGrxqnJCK8k8xliVmwDMMk4hcyYtbFQZhVWDhBqLI5/1A1vR1dHwfLRq5QKL5H5vX29TVVjRedSx3PbgKt8TYxZ38QVIdagJtF8KKt9L0XnHU/x2C88sTVkdXB0Ot7ES5GUEK2qGWeQKpnwc0T8xD1ROzX6e89kP8ZoynLEgsmC7vxRGIh6mhDT7f+5tqndXEoLuK75WK1D43jN4mxa2GXNak4Q+ogdglg+/i8J3cvUsv/omDOhJktB2AfNjEX8DjjphGvVBSDpgpVo+ArVvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2avGvrZITX+LYteLOi4GLkwSzvtOgxrAwcf573KOHGI=;
 b=WMTwqqsqjxqDb5WTofu/d9bH82txcUhGPFt+DKMzR1ycZcsV3U/0DUsGRWr9YMoG8YPOqXnD3MPPRgUIZ9V6e0JKZ06uLozcMRGvr9EVwlcC9MpMAPPbO0d9bf0MxD65n4woNCTJ4zsCI8s/nw4gQRJN+PKeLlbo8fU/u9vwo3es9cRIy4qvxH5ZdjZTyTz7hDQSxZJuTe4G8O/ss5PEncC1pIzQMspbZb+4zjy+PNKnyvB284F4d+ypjBFlI4QvfluvYCscVOq5hy93QNEIUQY/YUirVAAdu52k4Tklx58st9BuNTswjALTpEilJBJK3baYcdWq00n4edT8rAMzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 13:36:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:36:13 +0000
Date: Wed, 26 Jun 2024 15:36:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <richardcochran@gmail.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>, Simon Horman
	<horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 1/4] ice: Fix improper extts handling
Message-ID: <ZnwZQMe1outhbqPG@boxer>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
 <20240625170248.199162-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240625170248.199162-2-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: ZR2P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: a84fd248-1abb-44dd-7469-08dc95e4f24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|376012|366014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gHNNFOoyJwdpPvvqe8m7AV0VgmHJjqo0N4l9NWUWW4ERVg2/EOWldpp6qtbn?=
 =?us-ascii?Q?d+SeVUwPhxuIS9BRWt5arV118VjHMO5/6HNE4ISb8lkbaEkvEp0E1s1X8ke9?=
 =?us-ascii?Q?B/ZtmS3nhHalAEOwi5ILivBOk3CltWZa915nAcN2L9rQXs9u40lUfMDSWLt1?=
 =?us-ascii?Q?ZFQYigBNED594QwmbqkEF0w577IiyolRsKXwCFYmgccxvQbr/iX4XCCAKXd+?=
 =?us-ascii?Q?fWcxrhZHxTDwHuTqFXalZWC+LruSXja8YkzX0bXBkiLSiEG5zKMy4oVJIx6t?=
 =?us-ascii?Q?nOUZY78CIaUpY8jVI3Smch7Yt8DHAnE4pPdCkUWoAtv3LcO7HlRCdEIQ+ePo?=
 =?us-ascii?Q?6akOm/xXueF14r14r2/siQeF5c7Seu/e9WQgxxNsMuBC49Rnrd0VnulDAx2f?=
 =?us-ascii?Q?iuSwppUbGMu/9ITC+LcPY7G7YMOE1zOrbG2ghnAhFmFg9joScQbzNmbfVGlN?=
 =?us-ascii?Q?FRgEhfib1CLEyyQjGkjS6Pk9HyxGkvbEkhTsoxf33uLT9XctJ5cyfU8qpiY5?=
 =?us-ascii?Q?BBRLnQUMyG1sxB3eIbEHn4XnGt6iMHAPuwEdk54jTCUJmdyFTA0KVBxYUriS?=
 =?us-ascii?Q?w7lAqBzwk6UcqJ/DIDLmthpxMF8MrBSvLmpCrDvfzzIxoJ7emeWPE9qmZXAc?=
 =?us-ascii?Q?Ppid6aBeBdmIBFFA/Alv2MdIHU135iImMUBaag3M9yZ0wGgozQK9MKw5pelW?=
 =?us-ascii?Q?v3CwVnSoxeN0mAIQTDWCmMeDhozwpFvTJRfHv4sX2uwYsgavlLmWpR6Z2BMj?=
 =?us-ascii?Q?CWAwE4g3tr9FpZ9XvZgZq6c1kzdtR11AxPEORLDWJ+w4rDvE5TakEJP2vsRx?=
 =?us-ascii?Q?VYcx/XIhJSz7rnRd+EQ5JO3vjCK1pjv8KFmHVOFSt+BVqhiDYFtL0HdvWGjC?=
 =?us-ascii?Q?AEC3tvBgu8maCt752IbGrpA6OsimnYOX2fkaI9h5+5G7Mud4kHSIcsnclnIC?=
 =?us-ascii?Q?NP1oVi/JDwXjR/um2YV0ez5Emgp0Nmhy1OXsqywhQ5Bidv8NzrQoHegsTd0K?=
 =?us-ascii?Q?VLZFT8wHLdUCow2h9q99JAa4dXcJFkS/UJTFrYviG5L8OXGV1NCRyvVm82bC?=
 =?us-ascii?Q?IyA9lJ+zvLOGVICD9Z5qp2tr/Y8iRZHCWwZgDEL5N+qn3SXBCXT1gMx7B1yW?=
 =?us-ascii?Q?NIrSaS6YVUHCgHfI68i4dJz8TWRVxHFTt3+jJkT7VLd0TZ0NNNz9eK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(376012)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfIZnUswLrcQCPGJk7F+FTv/OOiiPitKPb284NSiPtYEyMtmpJBuLWshXdyA?=
 =?us-ascii?Q?XqngWbUt9kpdN+7f6yJjVla6pMiwT2ApymQ90si7Vynv709flVhvHYONwLcB?=
 =?us-ascii?Q?wQEC9aC3vX3KtdbU8+4spGZlg0MprAn1AUIQpm4O+9hUnkljkkfrMxlRj8XS?=
 =?us-ascii?Q?huPNvExIcxh3n/immryWpxuLfwPq4LNuEh4f955J9jfNoOJtckyFZhdHXS3u?=
 =?us-ascii?Q?A+CD/WSKXPfLate76dhUr/ukQL6xj+lch/HOjjiSXxRo0IokKd/CYqCP8OIT?=
 =?us-ascii?Q?n2v9HWC7T/PIfK4OeiozscStIOtE9vygLgo++MNcyQ1uJndHu3c1DbsS/dcs?=
 =?us-ascii?Q?zMtFGUSrH2+LpklUYlhWfiO5LlTOOYTwwllir+7ACncUNpplb3HXUewKf6yf?=
 =?us-ascii?Q?4jUDDugjG+UjaneDUo31GTVp/RBaUQHsmx6qquTB0G7vydfPVlUOC4TRDVe7?=
 =?us-ascii?Q?nr5G8TzHz1GkC3LiqE3XqI4QR+dW9ZofFRnzSqdhWt1P15CgDpZFg+e/VK+w?=
 =?us-ascii?Q?Cp+hZLdlgv3XGmK1s7vGQHAelTTIaLsKbMlYC6QPBAmuR1oDFMtU/UMqkjLh?=
 =?us-ascii?Q?5//G1fZBlKBO9AvZ1OraqKj3kTwYbyDfDkKoFVe0rN7FXJF35/bAaE9LfJbQ?=
 =?us-ascii?Q?sYejiTnzWCDSRPFWKMvyhpjyivM/06g14vBkWJu5mjsOlw6X2ZGO4uC9YPlY?=
 =?us-ascii?Q?nmnwD8Sux3nVNDCopNxfHTu80t78Jsv2lHCRB9y++RCp2oD/nR3/ZwmM7b36?=
 =?us-ascii?Q?t6wuHGZy8S+cuT632IEAaLDOeebDj6llb/dMmEM8M/guvKBqZBrC+YBkm2Qd?=
 =?us-ascii?Q?LucSUH/TOWIoz42BUXRNw/mzd8M7yNNcIUYau+LWnCw9Gxifpc+figFtCyRj?=
 =?us-ascii?Q?qb/Byt153IrZorv45YODX/Irn4hqy5rhLImvz8tqQwSWHeuhIeClrCsaeKgc?=
 =?us-ascii?Q?9vvNANxeazbd4kRG6Lq83Up3jm/qjwfVMmS52/Wuyt8EvmqwQAXtoIWsXPQi?=
 =?us-ascii?Q?WPv0ZE3dzlY6qZMlCECRf86OmbG94kN3Keu6Sffpq/U/AUjeVP2jnJQrxlPz?=
 =?us-ascii?Q?hvqcwz7wRkv6zxixvpmBpu8OQ/rtdGT6LFer7DPH0NJtcWl0rkAZd2ZwVJQB?=
 =?us-ascii?Q?zn8P9cNwjufWsPksVaA/mfjAFWTzxCSpmqvu9cgsNATNkJEBMD40BkS+HQ+z?=
 =?us-ascii?Q?ToVaGCMe4lKi3Vq6e+TvLH03wyfnqBbHdd4RI/ag1Uh+LNp+4dk2/f9Q47KM?=
 =?us-ascii?Q?ftMPAb/iLalRA2Qdzm50z6N9yugavtAYoXf+6C9FzukcqOO7cP/6RQtVhEFZ?=
 =?us-ascii?Q?N3k06OrgvvWBTWCvOIhKx9WMQH2hSwwCRPsSNMramcKRhgbKXpD/PZtfwxWf?=
 =?us-ascii?Q?txxrDUK2bDaQfbNzL+XZoMcNILOeK0DoxIT44N71wgj2nGTU3cujOPQRLEL0?=
 =?us-ascii?Q?pNJDtmrkJiM+nj5h87tf/OOME1DpozyxG0B/wYSlbFnHvhaIc3sUg4KmcAqt?=
 =?us-ascii?Q?er58ZAvXzRk/AK2lcEOqSI8uVmIftOIzy13pkwB8RqcenN4QCRHsUYkhDuXv?=
 =?us-ascii?Q?Y1NM4eQb8U/9A0RPfG9Nj8C3dgoaLBYwX1bRuO1avtVzANKePEzbASbG1kqj?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a84fd248-1abb-44dd-7469-08dc95e4f24b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:36:13.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JDzepyYec2klJ9uUEKKzlXfkKbitFeSDIhg58scNPLqNwevemzq2Ixz9evAwBkO2STvqFZ5ftCYVgvl+xbDY9d8qnGABD7yQfOr1gKHODk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com

On Tue, Jun 25, 2024 at 10:02:44AM -0700, Tony Nguyen wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Extts events are disabled and enabled by the application ts2phc.
> However, in case where the driver is removed when the application is
> running, channel remains enabled. As a result, in the next run of the
> app, two channels are enabled and the information "extts on unexpected
> channel" is printed to the user.
> 
> To avoid that, extts events shall be disabled when PTP is released.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 106 ++++++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp.h |   8 ++
>  2 files changed, 92 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 0f17fc1181d2..d8ff9f26010c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1584,27 +1584,24 @@ void ice_ptp_extts_event(struct ice_pf *pf)

[...]

> +/**
> + * ice_ptp_disable_all_extts - Disable all EXTTS channels
> + * @pf: Board private structure
> + */
> +static void ice_ptp_disable_all_extts(struct ice_pf *pf)
> +{
> +	struct ice_extts_channel extts_cfg = {};
> +	int i;
> +
> +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> +		if (pf->ptp.extts_channels[i].ena) {
> +			extts_cfg.gpio_pin = pf->ptp.extts_channels[i].gpio_pin;
> +			extts_cfg.ena = false;
> +			ice_ptp_cfg_extts(pf, i, &extts_cfg, false);
> +		}
> +	}
> +
> +	synchronize_irq(pf->oicr_irq.virq);
> +}
> +
> +/**
> + * ice_ptp_enable_all_extts - Enable all EXTTS channels
> + * @pf: Board private structure
> + *
> + * Called during reset to restore user configuration.
> + */
> +static void ice_ptp_enable_all_extts(struct ice_pf *pf)
> +{
> +	int i;
> +
> +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> +		if (pf->ptp.extts_channels[i].ena) {
> +			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> +					  false);
> +		}
> +	}

nit: you don't need braces for single line statements.

maybe you could rewrite it as below but i'm not sure if it's more
readable. up to you.

	int i, cnt = pf->ptp.info.n_ext_ts;

	for (i = 0; i < cnt && pf->ptp.extts_channels[i].ena; i++)
		ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i], false);

>  }
>  

[...]

