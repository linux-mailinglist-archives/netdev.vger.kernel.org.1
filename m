Return-Path: <netdev+bounces-75204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AB8689F7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17F01F21D56
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835154672;
	Tue, 27 Feb 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n91hmxMr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF31E89A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019474; cv=fail; b=fCYJ6IxcQo3EK9L4LIQzdyfupv+VTPXdQII9mxfHy3/ykD5oIPXt93Z/sM7j31gC1CN/K7w4l51SLgbFme9RRq5XhF2z4lPNa7uVoW5vOQLEUgpY+tVV4Q0AZNujDZTg0x5OCGPhbwEfYcMIeBg2E412Vhsm6X68xB8Vpl67BEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019474; c=relaxed/simple;
	bh=9PEUokXNt3xLvCYn6nwoNY6loLqKSJfUPvTqGBBPdfM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VXNDWgIrs0pdrJrOOl40FJR92eC1+NmwTMLpgM6hxcS6Kt9T5yv/uNmAvgZ72UIoOYLT4PjPmj8067J+gbyB2h4osL1O2bt2dUi3v6jcsv0j3y+oqduHEZqxxaB0s+/GIpcE8RIQrHew3pSzWNCYSVQAJfM4naEandtymWj3DMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n91hmxMr; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709019473; x=1740555473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9PEUokXNt3xLvCYn6nwoNY6loLqKSJfUPvTqGBBPdfM=;
  b=n91hmxMrc2oXLse/thy6dMIS1hJlRIHr9t0mnawpj8kfwqWOGKO7XdpI
   xrrM9mzpTO9Cc9xa0gg+7JOwCYOkwKuof0ATqrX/nPf9DhjdIzMCgOslD
   0D9XzBE5OVhBo8KH2Q3PQToGr3rdXLniIlzbfMavxdiNBs7xEWjtE9dYN
   B9jOYkmoGBM1fqiKrMkJw74vyKZlhbDbtrVK74yP+tLTKXeYT1DzmDKvC
   drSPWsfjJWD0vlGbD1qp11N46xptJ2OVpKQ0ifmaf6Bh+6t6u+SN3/+Ih
   P1mKxF76FeJlVSXr+ksh3qWKebplXfjWragCuaoW42aWhNj6wT6GVwZA7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3507457"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3507457"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7366120"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:37:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:37:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:37:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:37:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcAlOFXfFs2Y8DzaX5177rTwxEQMTKdIYA2Bf6lk0Qm7luEC5Vbh3lSrm/YPFz+YICr4qYJLxu/qfSmMH5LRY3OVb2x8xs5mZE7ZDU0RtOAttsdqZoTp/3qPLlYa2auVXUAvXoTV/HSKHbEn89Eopy69G0n+YY+5YpddVgw1VZLNWxnFCiZJPZsduF7Rl0pjUnnMXwNRaC8rTjieXBbz3+kHoMfENUwkBf62506iM1Xkqo40AeGn8GPogHCJbat2e06hTJZXrVcSCrhbMigd7kI6CJmxNBTFqDlP/CFY2rs7sK/zwNTuisjWhd4XFSAN7vCze6mPr3q/yEsUy/25SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V35GyODMjZy8e04ALYWOXaZ5s+5GNMIYw/MhZcTmhqM=;
 b=Eg5B4BGpGl+boyKKkZ8Fl1bKVWIGH8MH3yz5yiUZRM2ZwM7L72EpYZQbXXal9ylM4YxyOcyo1bw+xY1sUsdoQ4Stom1ERtz8olkmTozx0CyV6SOsP0iLGNb7ewuNW46ADIB1kAeIJ1Wm5LcC5p+jvgljYtqYNPDZmNmtKJw/r96CVVShkq044W+jqOOQuYokZa9M6F1QatNYU1tA1fH2H3a/yc/gFpxB/OIS4SIg3cI5y3SU88nmf+sTfe7460RsGieUngCXhUj81172ZG8qPQqNcau6CfMx7D+w/G2+FmV83wp+za89Kstj70UwmV9vvtfd/ahaL0oWhzwflylv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 07:37:47 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 07:37:46 +0000
Message-ID: <55330d53-8217-408f-aca4-a23261428117@intel.com>
Date: Tue, 27 Feb 2024 08:37:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iwl-next 2/3] ice: avoid unnecessary devm_ usage
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<magnus.karlsson@intel.com>
References: <20240223160629.729433-1-maciej.fijalkowski@intel.com>
 <20240223160629.729433-3-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240223160629.729433-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc41fc1-dfdf-4145-8854-08dc3766fde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeYVl+4UiOvdJYIQx+lKR9f4ACtfL/XNrJQ3H/xX9JA4+NjebmVf27mHCqgSyYBD6ax0ewK9AujpxtuaFhb3U1+sWDMMRZ38MiaWihlWIUt48U2Z6jV2uGT7OqnGUzhnZg86rPYlTQvj07geQ/Hg60Ce/MWy3cgOlGlF4H9En80StJZIK8H0G3Phz6xPwNk8EhNQc0dzEYjEUSeaLauy45lBA69vak7QGeALQclCDeV1Pq+LidqAiGxb+pMIYxklLqriOExmxO1M4WGh15YvwE0nN4iVETFnrwvyg6e0xY7RJTcmMqKqO130yF1fIqWVTjuF054rBPP8fH+T0jTKsKsONgS9pleIx8daasD9TYYW0iZhjG+NtoCJOM8YOLaQcBvLaMDm8TxQfloffHkizCbwGcszh9MGuAqkkKO6lbxDAM+oi7Cp/cYVUBap/Bawt0aNq4m7wkA0JYhUwo1wsz0MdBPonjQvshwLOFEw+CNFxboCW1AbKkyruRUiC3dO72GJNX59n3tcGNXmU8J0tQzeFCeXEh0M7Iq3U/FX3Mv0YAzdp5D1fdLvoDvtB3XZOJWUhDJ4aREuhlYY4sSsCSdyYCdYBvKXzD9D++E6Eb1mLFUtA1cYFbeZ/2z3ms9+NyL6HTJsBunsYtK2TynwSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VWUTBVOVV6NXpjYVNBMWZvNmU5TGphV2s5My81STRVUDVWdHRTS2ZlSVUz?=
 =?utf-8?B?OFR1d0JjL0hFV0JOZVBVY1p6dTRJSjdiYUtYVjBNZi94bGxUazB0S0lrenJJ?=
 =?utf-8?B?eStZMFlHeHRNeCswV1QyWG1BMmRnSWVSYURHakcrRTZqaVB3MzVJK21yYkJK?=
 =?utf-8?B?QkYwcHBybUUxemc3bWhBdGJRbTc0elBTb0FOdm1RUFRjZXdvb3ZDZW1Oa0lT?=
 =?utf-8?B?QTVuMzZaZ1VSeFNOamw4WXJtNTZlaW80L3Rrd0ZmZkNUdTFLQ0wvQVZSQWRh?=
 =?utf-8?B?dHk2L1NUTjU2YVRFSS9LVmtaL3BBNkszNHB4L2FyZ1ArZTFrOWpjWmx3K2ZF?=
 =?utf-8?B?RGYzc25mcDFaNHpVYUF4cVJ2ZnBRVWxrd3djdmx5cTBneEMzWTVSWlJpMVhq?=
 =?utf-8?B?TmREeFBDRGpLcHgwbUxYTlU5Y1JpSUpYNGpyWGduNExCa1o5Z2hLRysvTUR1?=
 =?utf-8?B?MUJodUdZUzIzMzVpaTYwZ0lkRXBwS3dVeXA0Q2RoV1UwQWpGWEc3UkxxRFpQ?=
 =?utf-8?B?NDIybVB2Y0l0Ujh5U2Jxd09QeE50WitCZ0xIOHBveVhET2JidUxEaGdhZzQ2?=
 =?utf-8?B?Z24rODF0UmoveVljQlBkcTgyd1NkYVpoM0VaelJWLzY1RnBwL1luZytPSWhQ?=
 =?utf-8?B?enplM1F0RmpTN1hEMkVtc3lMNE5VMHRVWUVSUVNTRUJrRnlONnZyQzB5Q2kv?=
 =?utf-8?B?ajhwOU4yL1kwWlBFRXlaTmszazlBZUhwNUJvQURDeUhGNlRmandZS0xqQ2hv?=
 =?utf-8?B?VTRYdlowMlZWVGhBbnJPWjUzR1VUTEd1SDUvMG52YVJlbVdTTC9kOWduSmxI?=
 =?utf-8?B?SWFDUXlGMURFZGFWUDZhUDVDSkwrSW5Ub0ZrRUcxMEdWNHV0a21wNHR3OWoz?=
 =?utf-8?B?YkdKRkprcVQ1T1I4TVRPdUljSmVTdGgxQlBBcnE2WjhSS05nV0ZhblFRSlZm?=
 =?utf-8?B?YkUyL1dNY0pTeHpJOTdvb01qU2FKU2ZvaWNEK1d4VVJxRlRqbzNSK1M0QU1r?=
 =?utf-8?B?a3VqSE5zMGc3Umx6UnhlWC93emNpUDJtTkNjc09rc3RiZW9XYW8rT0ZjdEc4?=
 =?utf-8?B?aDB6cHYxTU40OUJQVStJU3E3cGo3L1NTNTJsZ0IzU1U2bTk2VDg3OUp3WTVF?=
 =?utf-8?B?bVhKNGZpZ2NnWUE0YmpQVzFEQ2FiOFRPQlZSaDErNlAvejdyZTBqaTBlUGtZ?=
 =?utf-8?B?cE4rK001ODlNbjR4YU8yYW5KSnRQRE1CSjNQTmpCdXp4cEdxYkF1d0V6dkxi?=
 =?utf-8?B?a093Ykk0RnoyV2xLanhoTi9QbExTanpsMFEwNHNEWTlrVlFKVTV3NmFJd2Nj?=
 =?utf-8?B?NW4wd0NVQkFOTU95a0JoK3lUY0Y0RnpZd3NlcnZnK3lsOEZLL1hQSEF2Ym9h?=
 =?utf-8?B?Zk9NM0dPS3FmUUt5UVpxN1UxS1c2RC95clZ1OXFOZ3ZOM0VYNThLNWhxUUlM?=
 =?utf-8?B?OFpaOG55bFhzQ04rRXNETXdkUTJvaW5TSXJmVkVTU0Z3YjVaVEN3S2k3ay9o?=
 =?utf-8?B?L0FBSUFhRU92c3FTb0thS0NqVU9EUys1RnMyd1JwK0VjcEZoaXVxSTVQMjZD?=
 =?utf-8?B?SlIvN3pCMzFyR3dBaGl5ZUU1VHp4ZjFpejUzbjJqSXUzbXZNc09sMHNyd0s0?=
 =?utf-8?B?b2poLzI3WE04Y0tCSjJhNEZuendMRzB1Z1A3UUc1R3JaSzRkZzdXUGhUZ1pZ?=
 =?utf-8?B?K1JKeWozSWt4Y0lvZ3BTbDNUaExmUzRnenphRmlUUVcza3pURHVUOEdBZmhH?=
 =?utf-8?B?VnR2cnpYV3hSTlJyS0V1c0FXVW9KTGYxRUhXT2lMOTJsakNiTTVmanlNeUw4?=
 =?utf-8?B?cFF1MVlqUzZ3dVJKR0xzZVJpQlZKU0JuNUp0ZjF2eGdhQnhUWCsrOXBZR3Za?=
 =?utf-8?B?R3F3Rll6cDhHSk9hUTl2QnRRQnIzRHg1dE9RejZ1a29aU25Wa2xNQ0IwOFlh?=
 =?utf-8?B?Qk1wWUdDOHFtSE9SMFRmVUxmTFdZMzBCSDI0L2Y4L0srenp6QXJXUTA5Sm9C?=
 =?utf-8?B?ZHFuNmZqMEtuUUI4TElaZ1lwaDF2WGoxWXpMRlRNcmtJMDIwMExldkliSU1W?=
 =?utf-8?B?WUQvVzFpK09qNUQ0bEIxWjZwNXkzYkdwS1RGQUxUcTZHK2xFVHNBUUYrYTdD?=
 =?utf-8?B?ZjZ6eTg3TEVuWXZ5WE9KbTJXZXRucW9kcEdjZ0Jqcjl4ODZ4bXNhZWtxUlF1?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc41fc1-dfdf-4145-8854-08dc3766fde2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:37:46.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zwImihCGuoVj3FTjZeu/8BHl+yz8ZZsyTDS83EI/nf5J+5h09cXaJdA/PLYSDQOXMc9V7/5+TJ/8zdc6w622TzJdYtrcgjE5Gj9iM0Rydk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6514
X-OriginatorOrg: intel.com

On 2/23/24 17:06, Maciej Fijalkowski wrote:
> 1. pcaps are free'd right after AQ routines are done, no need for
>     devm_'s
> 2. a test frame for loopback test in ethtool -t is destroyed at the end
>     of the test so we don't need devm_ here either.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c  | 34 +++++++-------------
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++----
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 

Thank you very much!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


