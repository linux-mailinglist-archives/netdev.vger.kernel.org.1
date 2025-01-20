Return-Path: <netdev+bounces-159789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E93A16EB9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6825A3A311E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBED1E32DC;
	Mon, 20 Jan 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdzhw4/U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542B1E2859
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384338; cv=fail; b=RR0EKlNDtnjoHbtDO38QKLJq/ItwWHeLLDWTsDMNbpXDQSz+RA0BsXm+KQ6KiXl0a6o8B16n/4UOiuo7lVIlsAJF01JWvJf7j5jgWT8JT3m92GS/bWaHVWuGgj1WEzYxD2RIWmbSksTuhLQtHGG04ZNQR6gaKpi4cn+MmXxplcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384338; c=relaxed/simple;
	bh=rH9NQkZ2KkjW4arByH0Yn1aSMA4Myw6tmYr/vejRe80=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KY4aX9xqpR8dRRZAYLsApco3gZkCq0DXzVptSDVEvSD7z40CcLjLSiCL6Tzgh6pPrbBtbVUuTVrzZAPjjcGJtuoxVRxyT3Lhwlb1/AgTumC+IGPmFR7mfI6m5hhJsFqpwu5akS+Vzs7z1kVFx9YVFNU+eu2UdNS4hMh76hFN/p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdzhw4/U; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737384337; x=1768920337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rH9NQkZ2KkjW4arByH0Yn1aSMA4Myw6tmYr/vejRe80=;
  b=Jdzhw4/U7gatKKu5eULJlcWQzkW/hqcnqvtC/zikMABSrtcrpspUffzf
   cVdfpah5KVLVujKrpQY1cnUcy5wGZh50neW6/oI11sP57bQsXnaQCxDPR
   Yo0RrC84Ivu2RRnIBJ/E2ZgEE9DHB2WlgLIIhDdScr2rD9WEd0D79sn9E
   bmJXmOPHdJ0tuU2DAz4y0kZOqj7YczSkUPOsKtfbsMZS05wYvgPN3uDni
   4ouwt14WmcFh3sAG1QgEbl8YALUrryQx0HP+j/DrzmJRS6aF00XKIupZj
   v/aW23mvrpWNQs6xcDAdEf/tqDlm9n7RJVTIumjpmOgAtMbxy6cyrasUy
   w==;
X-CSE-ConnectionGUID: uiXEQCjrQXqQN7QS3jf7AA==
X-CSE-MsgGUID: YYaJLhAGQQiVLiszkj9gSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48372784"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="48372784"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 06:45:36 -0800
X-CSE-ConnectionGUID: lcXgt9ehStGyXonRDxdcWg==
X-CSE-MsgGUID: 5F2+qRMGRZewDg/99sJ0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106371254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 06:45:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 06:45:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 06:45:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 06:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0w061YuGzEEaqoTmGCWiAobA1lmyC0of5XB1PUipuFk2UPQTOxF5hldaUP9RIuCVqUlUm9csDUimVTNYBJrYLuOuP1VcaKgOZgRfgTGNE5ks75dNQyKyDWo/IcgGEynzMFFbM+Sp5yBHofxRURQwtvZBlA9mG4mAtdpWERbb6R0K6vtyJvyE8f4p/Pz5pte0JJyhjslOPGAMRMUsAbN0LI0hP0YOJAVJ1oDPEomcgBIBjjcR2ZuYC/UWYMzRNG/FHMRGx+yK7TUPhMjOvxcYcGwhl4Me5lrz6wRSpeIRpbazaRNmrtSC/frWT91qM1hrCbwqH9AVtat1KLyqDIkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww9o74PpojP9N7LnJCMzb5sOQJaqs1GJUQPaS1E+IvY=;
 b=JQWqE6HEsutdGlU34SWkJRHp+9VGgx9De6r7pDNv7dxA/ehLsI3/dBnbTSkx35LUNUrXAEB/vjxPnmTg2z4bBG3vsTete+ajj6lLAgdHBpKJtmAYbFc9Agyej2lFSRjG+br7hN94g12wQWhXwJwN1s7WWD0r8cK8IzOLa8pzwMEacWV6m1x4Duv1MBSr0Tdvsl8J+WDgmbhof+lbT5HwmyM83JUcNYWhfRPNNlUCeJ2KmWuiaB/m1fRFdtDY+wsbllj77cvNotPzghy9BC2zG5RkcpFd868Tv+OpkPqYXXAFoHO1y8wEC7VDIpi+ANLjuhcqRr3bmmFN6LN2kFDEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 14:45:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 14:45:30 +0000
Date: Mon, 20 Jan 2025 15:45:19 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<dan.carpenter@linaro.org>, <yuehaibing@huawei.com>,
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ixgbe: Fix possible skb NULL pointer
 dereference
Message-ID: <Z45hfyEC6dE2Zkm3@boxer>
References: <20250117154935.9444-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117154935.9444-1-piotr.kwapulinski@intel.com>
X-ClientProxiedBy: DUZPR01CA0325.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a9d780-3663-4604-bd37-08dd39611642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HBwSwkNDSIxL7Oom/6y/FFYDRzmJlQctHaRvNTam9/NGbVTeKxN/c79eDgPn?=
 =?us-ascii?Q?TEiYNKkqDhORjDetzDiCrRZWb+GQHRy4ATH6C4K1tsgjaVevO4lkglQP+42m?=
 =?us-ascii?Q?ikGZxQIcmI6fUpq4kD4s2f7H3bg/DsP/aYqIPxpFljFSMZlgfAxkS4X7R+0+?=
 =?us-ascii?Q?J5LmuVA3OIC7jXRqXY8+C3i6vl5YBMofVD6sNkeCbtpPVA6zX0i4y7o7g0R5?=
 =?us-ascii?Q?dS+QYeVUF0y6SXqrR0jczZDaA6rPXXs5SmxK7EI8yKd/l3mGc2uBnCkdzBU4?=
 =?us-ascii?Q?xmxztLc6OcNMTCCnEYJJZ7r9U5zHW5wztxx3fv5+LB5gaGBElBpGCaFt4JlV?=
 =?us-ascii?Q?mxB3SRP6EUcLGbPKzB+LEragKvaFJw9EO6BLJ/hUMltNW4/maMVtMExXxrup?=
 =?us-ascii?Q?PZ+d8eItOqYRb7au79T7NJ3TGJG3F66TARzamp+Xumt+qrlCtq6PaTkTqyO3?=
 =?us-ascii?Q?UYrqjFIGIqLv1PesIIBjX5KizzrUC+YStXTMlXrO2Lk79P4KNXyrBrI6LDt7?=
 =?us-ascii?Q?rQdwRUfiIR4u/BFeyWPOxosIE3JG981AJ0aDLYG+pAomcd6giib24+lFnwj3?=
 =?us-ascii?Q?fLsS4eVvEmLE1CQpw7xOpWLiTHJmY2WF4D2TEFxzNv5KJ2nvvUgZQFOjzSRY?=
 =?us-ascii?Q?3zOtrrUSoyhXnVoAF4DWeWx7N80W8HJWTKJDthdl3vSKrexhfOHqyoek7mSH?=
 =?us-ascii?Q?lORlyP3QSFnSoVXrClulUXToPf77vIsRJiDJ4jNHt7umQgVTOtJuW4KlfAaz?=
 =?us-ascii?Q?xXurY/WPrUmcuaRXB5dhsZ9U5nz5e6BVNnKkA/HSF1pWbGQYuqQLixJtmnsh?=
 =?us-ascii?Q?81ZF8E5fBXbi+l6nRhFyzbTdAv0koUQwP0JwUX+Lm5STIGzVhIpXnx8h19xt?=
 =?us-ascii?Q?6nORVNAj6Rjv9dYiOc/EQoDYEjpxf4l74mMkvLbUZ0+SkcJlVwv5XsszX8WQ?=
 =?us-ascii?Q?W6kN7s/JEwdqCRNK/OHqxF4ZU5ReOhNNZxZ79RR0CCZmOgCKM6n7oL8QPFWU?=
 =?us-ascii?Q?/pdM3uo0utirb0xMf84RbFcXdVWESrqA8ZpjgVM1NUBN8o1iYLr7xjiaNmj8?=
 =?us-ascii?Q?ihsWkhRmF7EjdQ9LAklV2qwY7TLmLJOEM/SUX0hpWorBfeEi2dBvncUywkRH?=
 =?us-ascii?Q?YdLK+vhtt+Yx0vz5g96E6fAKtJ4wHBbiNoJmF98I3zTWCZZqS8vfXKmkmdFS?=
 =?us-ascii?Q?GmbiYOuOAYYbv78g/Qz2NhoaJ0AnoyNm7dRttC1maqvadJEvvaZMBKup1gWc?=
 =?us-ascii?Q?8je0LglO9o7qtpfdQIagbShRLxiE6EJahLa7qwz1qVmNx5bLfr1b3NhfdCQh?=
 =?us-ascii?Q?TBxHoxocbupOAIMUoyYIw2YXS8lnnqIfQh+zrQyNlbqiU3DSsTKPPCDG1G0I?=
 =?us-ascii?Q?v+R7NB2aa5MI34yY7UAJa0i5U7CR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFx6+GXOcQLtq4rd+7WTQRvQoBqjc7SsVRVn9MukTML7J7nrsrNFosqPk6tY?=
 =?us-ascii?Q?FMvJt/TuOEyGKswFN7e+UCb5m6XGWdKo9Wi+BWFb/ZKtzEzKMemDzQ1hQD7C?=
 =?us-ascii?Q?4tCtkP7PZo0YxHLBMoaxbjIq3GjiWuhZ9Us4n3SGCVbnMQ7QFm5b2pmgcI3h?=
 =?us-ascii?Q?Haz2DJhyc0M7uTfmhSFBQImAOOAWmUOG3TwVzsMXi1wmEZXxDoABq66sXmqW?=
 =?us-ascii?Q?r4rI10vvGXGMP1L+i9PGN3bHPnydWGrsCzxVgGaNdAYSzNdGZxcD83+BQD3q?=
 =?us-ascii?Q?n2X4TMXj5UMDtfR0JqEh5G/gatryHMv3AdKvLuGrWyx4jtHtKuShNnvQXI1q?=
 =?us-ascii?Q?00ELJYW0IqrAYgmu0YhWQWyOIdkqR253BRxdOqNhsoNcX5eAV1iBVW0cBe1v?=
 =?us-ascii?Q?PdQEMq0tj4Au8B9MHcqWQJu+KgVsCbRYOHkIkwlkHobreL5sAHRjFrFP9dHi?=
 =?us-ascii?Q?lFx2hslkGj1CL+BvX48I4a5sEmNP2vFpxWPE6kVrDNYchu5XDf/FYWXDPxAZ?=
 =?us-ascii?Q?3DPqSr58thUbZ9XxYdcZlgSFe42nVbvEipK+Ks5FletsB9GJnWYCHCoaKhrq?=
 =?us-ascii?Q?+PjorbRib233icgBEMF63PzCEn842RnUFIQeXKB4+zXxKeL0c9n7dUN0nY+S?=
 =?us-ascii?Q?MfqVsTcEIqhvu9VJn1JFcbEn/2nx8bmR44TaW9p8eSmmUuTdh+9wyjeJWoF3?=
 =?us-ascii?Q?beWVyPXlvPW49tva9hiOV39/S/jAv4wsjDwXON0i250QTuCkDCyg8LWPbznK?=
 =?us-ascii?Q?2xPSTXeN8lD5sNs4iqtIBYuTWuL4YM3ztqdp3SCBW0a4+QFwyS1fGGeSvGZp?=
 =?us-ascii?Q?5Tw8eBJy1fc6fG2tBbXf7HytQU0VknwKwOgKGMMe1SUIDH1j9tpr2gTGZpir?=
 =?us-ascii?Q?gEt9iLO9bvPbc/T3H0i1aN4fX/fwDcXlwoQ5AOx9PCeFEB5QZfifAf0O2I27?=
 =?us-ascii?Q?pWxppoyYGDKLrvd84xhlsXHfpEkkscNoc37e/EYOE7QpVHCpfunAhggcME2r?=
 =?us-ascii?Q?mYgF9KSWvX889tP9uFZcxeGzOuUN/PVaBQJJ3tjj00vC9UwzVMIPeYUuFLnW?=
 =?us-ascii?Q?M8YZAFz5YF8zm0pHdunaKiQTzsVpjJr+uNcBD5DGGfAtwokXwOSfjl4wqJno?=
 =?us-ascii?Q?550Mut8WeTR3KXcfq5emvrT63F5ohDC2Fhl0MAGBg5yy6zjlr2zE57IpGRNt?=
 =?us-ascii?Q?sPQpgaYp61D++IegCHg4EXQpDKAX14xuBEVEuHA7mUFWjMkWtf2dH5LumOZF?=
 =?us-ascii?Q?zDBLkeC3E9HSGDeb8e8jMsiJ0XPNQVcXuooKsTthV2q/9yF8S5l7ArywiuP3?=
 =?us-ascii?Q?MBhmM06Wr+f/9sH+rPGnzLAaqfre9Ld4hvJ79zJu1SeqdcXjaieQppksNOgC?=
 =?us-ascii?Q?OwVBnrHY/K2WBLuJQ5cvsI7Ud3r/YvFnfUxme/9sgIL6dJ9MgGtPoihXyy6k?=
 =?us-ascii?Q?+/6rCzYnhFMKFYoyZHQLXawWJdBDrjfHeBzcTL3wvZkz0pxvYX+AtB7oUbfu?=
 =?us-ascii?Q?WZ+vlz0CqtrY9WrT2hhOrwSCRiFVsxhDWU/bDS+A+2lqLfLwvVi4l6v5kUyY?=
 =?us-ascii?Q?g9hYxCIpcqwCyrhRd3v6Unvnnc+jfWpgWoSBdBkAZfKsUQS1iJCMWrYRWi9+?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a9d780-3663-4604-bd37-08dd39611642
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 14:45:30.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfHZAOnE0dkqqBh4G4D/CXQHau92geJbtGu/QavxZPKPhruQ9hOkgPlirbn+t6UAsi0u00sMAnLaFXAngzzRrJgJyw6w4VNMtA2omEloavY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com

On Fri, Jan 17, 2025 at 04:49:35PM +0100, Piotr Kwapulinski wrote:
> The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
> ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
> encoding. Propagate this logic to the ixgbe_put_rx_buffer().
> 
> The commit also relaxed the skb NULL pointer check - caught by Smatch.
> Restore this check.
> 
> Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 7236f20..c682c3d 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2098,14 +2098,14 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
>  
>  static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>  				struct ixgbe_rx_buffer *rx_buffer,
> -				struct sk_buff *skb,
> -				int rx_buffer_pgcnt)
> +				struct sk_buff *skb, int rx_buffer_pgcnt,
> +				int xdp_res)
>  {
>  	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
>  		/* hand second half of page back to the ring */
>  		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
> -		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
> +		if (skb && !xdp_res && IXGBE_CB(skb)->dma == rx_buffer->dma) {

xdp_res check is redundant here. skb ptr will be non-null only for xdp_res
== 0. so skb != NULL implies xdp_res == 0.

If I am not mistaken:D or ixgbe has some code path I missed.

Besides this, thanks for improving commit message!

>  			/* the page has been released from the ring */
>  			IXGBE_CB(skb)->page_released = true;
>  		} else {
> @@ -2415,7 +2415,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  			break;
>  		}
>  
> -		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
> +		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt,
> +				    xdp_res);
>  		cleaned_count++;
>  
>  		/* place incomplete frames back on ring for completion */
> -- 
> v1 -> v2
>   Provide extra details in commit message for motivation of this patch.
> 
> 2.43.0
> 

