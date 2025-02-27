Return-Path: <netdev+bounces-170110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C0A474ED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41963B0EAC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD23FB0E;
	Thu, 27 Feb 2025 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXIXnHMV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE51E8334
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632126; cv=fail; b=N0RkTs3wOmhzjx8y9oRRRrz35jOe6Rb3AKBY8UVkndH47SRT7TZJuFzRXscMEkZOGIyHMfTtXyoNa+A0Z306PvmM0y63S0+ytaqS+urCGHzN0cFRAZUT9m+PV4oHXq8jlCcpkzPmpsWT0PW+HRIG6JkCxuueFdZc9NWXx3PFdp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632126; c=relaxed/simple;
	bh=5c73CEbjlJbBBLbg96Y7ANJrApoJqB69y4RQVI5U1qA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C7Bp7cuI7Kq0OEyavkwBK2z3Ic82e0P8YhBzeMLmPws9XI6mNvDJNuxOicK7cphUMeMZZyB6wIYxKr+t7ZjYtEzM/rSBgydyQM+Wg0KpkHzWrZBtztsNzOETCE4tc2BOKWhG3MlAQmCwDazuxQaoK08VnrclwVGpzooXzZ1ZjXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXIXnHMV; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740632125; x=1772168125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5c73CEbjlJbBBLbg96Y7ANJrApoJqB69y4RQVI5U1qA=;
  b=gXIXnHMVHNrHBV4cnXP2z/oz0XlMWHac5Jqz/2M0wL5cCljQCbtEanR9
   DseyGw13ZVnQZ00j/Qmx4iWs+Kgg3svT7DTNIkxKifR3mX7EQXjhAT+Ro
   iWoccN/coqvDEkzpFTBbQrGeslWvmurJf3WclLfj4/amqr6CvZn18HY9Y
   Wxq2b7B4RsPcqFXgkwF/SmIwFfbWz1ebj1DCdEsT6KUhGCmgEe0wZ/0tt
   SjB+y4mg1ELd4+ZP19U1C18RVp8RJP88iITlYzXkVftoJ1vfQ71kLs7BV
   DmuW0VaJW/tk/bt6UGmAXPlr62bt1jsaLnUcv3wQCS2uWffUfI+plLdnL
   g==;
X-CSE-ConnectionGUID: aOSOaTkmRueTsyH6fekQSQ==
X-CSE-MsgGUID: n6c/OJbtTGKJ+94amUilHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40683545"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40683545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:55:24 -0800
X-CSE-ConnectionGUID: oRGldBdTS86qPQrvqVyOCQ==
X-CSE-MsgGUID: Iipna2LrSOyXhVCVZcgGpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121846465"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:55:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 20:55:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 20:55:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 20:55:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIeAJnGwOV4m1aZD2sCXmPlhEYBzPw10nZjzV8iOD6vdz75bhC1qYWiETBcAEs/1IOBc7kI3H+vc5gaPwz0eg5K8/ons7y1NUrqlD5VgwF28PiU4Ifq0N4QVRBaMyjZXBBAqGggDsIxx67Ybdwt4PHWAZIRjmyyKniUCMyi8zdqVceq7y5BwsKF7pHeDNM939OGEYE/YY61ZDZVp8dPLUlClCML9m5k1+lOt/ovol6po2CTy/jlx20+y8oh3QXqHJNK0b/MG3Xc+3whnUMHTyq1L0kzUhn+hPbVurh1eqhi14lU7bN3eO6Xlnllss309L6YDYU5ZoPoPQ7u0VBtwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a6R7N+c5ktY3EEJ4WtB0hluBMiqoCHbllNu+sd1g68=;
 b=OiXkj7gzWp0DygrejQdDZuM98wQcQqgTszgT/jut+P70sgfqcueu8nh20VEs1JFU+riCFWhAWO+e833HM4R1hZprIIN1eLHXTga4NrmX4HjVGs6D4zGAbRcrv/xO2HGsA7X6NPYPLTdop9eMd+kv1AXLconE5IifRQIfpSxhi+rGKM0vmEVzrvU7LmiqD0mW5H3CnBvRldP8oLS2I0O7B4Vymg16NjjyXTwjtUCY28B7vuw4oy28PzbSyaXu6UuThdz+3aWXa1c6DssxsJKVhPczzJOAKDhXSXelhvn0lAJG5gNNlfWkYcTuDr7jmrVpwlEwJqgDUlgtFvINEYwlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 04:55:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 04:55:16 +0000
Message-ID: <6b95cf68-69fc-47a7-a1b2-8ed1fc828f24@intel.com>
Date: Thu, 27 Feb 2025 05:55:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] eth: bnxt: rename ring_err_stats ->
 ring_drv_stats
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>
References: <20250226211003.2790916-1-kuba@kernel.org>
 <20250226211003.2790916-4-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250226211003.2790916-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 104b60fc-570b-405e-bcb6-08dd56eaed58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWtJUmpHOFptd20weGMxRnMraGhjT0NQaWtpdkkrbm5CM0R1Y1lMYWFmMFlp?=
 =?utf-8?B?L3YxbkZmZXBRQVppRm1OV0FRL25mK2pDM2dhRS9IbmlKaWczUzlrNGw5ekIx?=
 =?utf-8?B?SG1XRXJhWllHaXVZRXV0QUZCbXBQbGlWN0pDa0xMU0pkeGtCVTVvdUtJNWVU?=
 =?utf-8?B?cHlmODlZc0xnQXFza3E4dE04SmpuSHM0Y0YwaG96U2R4VkE4ZkVEVU5nSjRq?=
 =?utf-8?B?YkdINEc4b2VUZldvRnRPblV4SzdtWFRGUGdyS1FVamNHZXc0Mkw5OXhNemtG?=
 =?utf-8?B?cGxkQ0ZPaTV0QVdGRUNTOFhMRjF0VU1nQ1V2YXFlb0s2K0daY2ZFQjI1c29E?=
 =?utf-8?B?cTB4TzBYUzlGSHRva1VaRXRwNFl6dVdnV3drMHBkTDk4dHMzUkk1WFc5Wkti?=
 =?utf-8?B?dXJxaVlQUkl2WGRuK25LcnpEa1ltTE1Fa0VHUi9OQjdncFRJbkdOeVR3dGE2?=
 =?utf-8?B?YmIreG9QTy9YWTlxckJSVjl1MGFHUDFpQzhHZ0VnUFFRR0ZKeWgrb0RJL3lw?=
 =?utf-8?B?NkpQVU90SDM3dGNDb1RyVTlzdURJRTdyMEdXckFpVTRJQlk1WWVDZE5XRXBi?=
 =?utf-8?B?SUJZUVFUa1MyQTEvYjdra3JKSmtpK1BmQ1lyTEhTaWhJQnkwbHNySEU2TXA0?=
 =?utf-8?B?aHpoYlkrN2J6dUJMVFprSkdqNHZQQnVsejBiakRmWWI0R0U3WXV3elJ1c3Z3?=
 =?utf-8?B?enNSdEJyOFdGTTcyTDZ1NkYvcjV5R1FxaTNDdXppS0hmcXNNa1JyVGFibVEy?=
 =?utf-8?B?SktRNzJ1cHROM05uM1RZbmRGU2xoOU0rdlI5SEI3UWgyQ3lHRDV6M2JtbXkv?=
 =?utf-8?B?N1FOVzJoUzNYU3hGU1liUHZYMGtBOC9aODhNUEYwWGJIQjNJZkQ0NGVCeG1q?=
 =?utf-8?B?VkFXYXo0SlZMaitQZjY2VTFCNm5sUm40RHFTbllyaVU2T2NvUG5VczFqTzV3?=
 =?utf-8?B?UytQQ2R3dWd5L1ltZ2RTR1V5TXlycXBCUWYxcUhKblR0TldvcUxUQWVrWm9j?=
 =?utf-8?B?MmpXZjFGR2pWcnRnS1I2VGZmRlF4MzdGb0I5d2tmdHZta2kvenoxTURDZXRQ?=
 =?utf-8?B?SmhXdiswOUdOY0J0VjVDdlRxNU9yNVREKytzLzMzb09MbFQzcGNFV3czaG15?=
 =?utf-8?B?UC9IL1NzZnhtYTRXQ2NWL2ZuKzE0NytWeGRtemt3YVpEcWVWUkliMW5rK0Uy?=
 =?utf-8?B?dUVYZ0FTWjNWYUdtbDVBUkdwdlZZenF3aTd1bzZEOEtidzM0NEdyOWltRjg4?=
 =?utf-8?B?OWhrbjAyU0VUb0NzcGlpM3JMbm45aWg2U05jdmtIY0FZcTFMTTVBNS83eTdN?=
 =?utf-8?B?REI3UzNNVGxUczJuN3ZOWXo3bmYvWVlmZVR4Q3NVRmJqVWgyaEdBdGdwRTVs?=
 =?utf-8?B?Z05vNFJLS0dRVVFIcTdlR1h0TEtXWkp0ZXZ5WXA4ejdXOVhCWWxkWU90TUNC?=
 =?utf-8?B?OFo4WmplTG9Vc3UzLzVwbitOY09odG1jSUR2SHlYWDhHVjZTQ3h0YnVvaUtn?=
 =?utf-8?B?T1BqL09xMUJ1ZXFqbDBUbkVkZFordGxmMXhGVWp4NGFNVnJINmM1Wkh6Q3hH?=
 =?utf-8?B?NmdQeWd3dkR5RnNNbTZzYitwQ3EzK0xYWUU1eXNHQlNSbllJeGp3TzlxVk4w?=
 =?utf-8?B?L3dKQXN2Ry9ZQW5SY1Jqays2TzcxUGVzeGl4cVFVaXN4QmdvRnB4Vzd1Vjln?=
 =?utf-8?B?T09RTUFzcmhMMjFvbVdHZjNKQ0JuL05WUGlJKytlSnl6bUE5Snl1VExmTVly?=
 =?utf-8?B?b3RTZisrSlhVdjUvRGh0ZnBxUE1NRWtOMDllcjNSYWtjSEc3NWlkTW90dEx6?=
 =?utf-8?B?MHd0eWtIMGIrSVBPUmZuV1JxeWhmWDJodnVTQXJLZjFsOVBCcjhtWXMvSHIy?=
 =?utf-8?Q?iy3BrKMgZJN/V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lTRFd5VnNMMmIwS2tza0xKSWIwOU9PNFVNeGpmcUs1bWkyRzBVV0JPYTVG?=
 =?utf-8?B?TTBQVjQ2bEM3cEF0enROanA0QnpSSFhqQVNqMzZSZXZmQXBSemFoSHBHeHBv?=
 =?utf-8?B?cmlkSkdwZkFBd05acHpPTndDNTl5djhrTHhGeWRHT0hJakRsdUE5ckIrek5K?=
 =?utf-8?B?R09kd3NoaCs5S1lLV3FSZTdScXNvOVM1K1BZa1orNFJsR3dySTJiZ2RIQ2Rr?=
 =?utf-8?B?YUpIWVN5K0dwdWNRVXo0UmpKeXAzbVpPaHlTQ1Z4bUk4T2h4aXp6S25UVjlB?=
 =?utf-8?B?WDg2QUZBaC9QalNmdnA4WC9WTm1hTWJjYXA2Q2tzN051ZWNzbDIvVXJKQkFE?=
 =?utf-8?B?Tm1WcVpRMVlaWGRQSmthV2pnY1c5ZjYrbGp5bElyd1hBL3NPdW1VUEdYdkhT?=
 =?utf-8?B?aEgvNXNDSkFoQW5vdDd5YTF1MEJ1endCS25PR0tOZmNFSk40R3JkdEVDWS9Q?=
 =?utf-8?B?aEVHU05PRzE2MW1qa1RPeWViMWtRUWNGakZzeXpEL0hYb1EzS0hORE53STZj?=
 =?utf-8?B?QlFhaGFWUTdYNjNqOVZDbXAzNUN4UDBFb05ndFpZOEhmZmJGYk1scEErRjNZ?=
 =?utf-8?B?Z3JnckRpU2NhQlpuaStueVpjay9yRGhBSmJPSXZpOFZ6VlI3T09GQUd4L2tP?=
 =?utf-8?B?ZFplTDlUMlo0MnFzaGhBWDg0bVlUOThCUlFTWnJyNjBHRVdKN0V1NjRMc1h0?=
 =?utf-8?B?dFRqWVdYaHBzY3U4Um5hd3F2bWtZKzlvMmdYYUJqUGNkd2NYemNNWFNOdGdH?=
 =?utf-8?B?MlBGOHNpeWlwSHFTNkoyM3FJWE9kZ3NRNVY0aFJYTVZvMzlZRzZvOXBIN3A1?=
 =?utf-8?B?ODk3SlJqM0VnMFVjQmNSdW8xcEZVenZxNG83bndNRjBiWWhBdnVya3FibDZm?=
 =?utf-8?B?TXhjci8zekRwNDAzaXozcEpNalM4RUdqWmkvUWY1aUhBdzJZM1RWdlE2NjQw?=
 =?utf-8?B?YTY5UnIxbVRsVzBiVENxTDMvVzRYSy9CbUZ1WjJiV0xCNlROeU91aHdINjZt?=
 =?utf-8?B?L3ZJK25GQ1hRYm81WmZtU2svVDdnSVBYRERIdEdST2F5RVdSQnpUVEw0YzB1?=
 =?utf-8?B?U3BWNDhmOXcwQXNueW0vSHI0VlFrbitQMjlFbVZUVmF4RDlEMFdkTG5KaXRZ?=
 =?utf-8?B?YUxtclRMcHkvcVlWdzU2YlVnV0hBbU9oa0ZNWC9xa2xKVnVMaWcwSUlJU3Np?=
 =?utf-8?B?YzlNWFJtTVRzbStVWkRheUZRSVgvdjVHdVlYOGRjRWFLOTlnKzNTbE44R0Ir?=
 =?utf-8?B?YlhDcm9IejMrL1hyNWl0WHB1Nlc3L2dveTk3WUdLbGhkbEJTM1Jrdng0dHhI?=
 =?utf-8?B?UmVDOFgyKzhjQXM4d3FtL3pmRE5OdFZkZFZkRHcwaGZVQzkyRmJFYmVhbjlk?=
 =?utf-8?B?dUhOdDZSd3dWS2tWRVdtaU5lU1JZU0htR1Z3bllOTjRLQVp5VmZaYmJ6Zlgx?=
 =?utf-8?B?SUk4NWlmRXlHV1Q1TkFMSTJ3QkxKd2ZBQVhsRE5naXhCdFdWdG05dTRUalpn?=
 =?utf-8?B?NW1QVW5meDQ5eFBuSmlBL3BHVnFaSHlqeUJFOC9zdjVjdHVJR1pRaSs1c2xR?=
 =?utf-8?B?Y0pkcm4wUjh0VHdUUUNaMzlYcjZKREVQSThyclRwSkZ1R2k3QWtUY0czZFI2?=
 =?utf-8?B?enpQTEJnWjg5VVJ1bGVsYld1N24vZGdjR1o5REdoRWZSSnF1U0tiOTl6ZVFj?=
 =?utf-8?B?Wm5WZzNMaXBFb3FWaWRGZnhzS29icHVFY0wwVDN3cThNWVoyUzZoc1lPQ2JS?=
 =?utf-8?B?bm9hTU9RL2tjKzBLUVhFS0FjTzg1ckpwc1Q3cHU2aFNvWUYrMzI0bTZGRitJ?=
 =?utf-8?B?WGtQNTFDQThiMDlneFlkaFNpWmhzeXloZ3E3SUJLVXRzUnd5MWEralJjdzJX?=
 =?utf-8?B?SzA3TkJjdW9UNjdzRE43OWFYbjF3c000T2RyQVR6TzJJTmkrZGFSb0Evbjh5?=
 =?utf-8?B?WC9pUmVSbDFjMnVqYVozNngvNmlDY2kzeURpUi9BV2taWXR1M0ZlSlpWdWQ0?=
 =?utf-8?B?OGhDbWt0WDlzOXpNVWdqR3Fnb21NVE9rWlg1T1VaTWVtSFRzZ2EvUWpFUGV3?=
 =?utf-8?B?K2R2MUdwdXJPdWMxd0xxVHhRRGd5N0I1VTlpaGdZLzhmV0VGbThHY28vSXhF?=
 =?utf-8?B?OHMrYU1jWldwS2xXZXhoVXhBdS9qUjB0TEl1NllMaUJVVlNoUXVEOVBDOWRD?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 104b60fc-570b-405e-bcb6-08dd56eaed58
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:55:16.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcEXrgktoFh+yoC8Tn8F/UH2vHmLUh8JBJenrcOcMaV1R8wz9skQ38u8qGGlgNuP0jFVdoNYMmUjfkImbPtGdsKNed5jYRluwq7dPLbUVWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com

On 2/26/25 22:09, Jakub Kicinski wrote:
> We will soon store non-error stats to the ring struct.
> Rename them to "drv" stats, as these are all maintained
> by the driver (even if partially based on info from descriptors).
> 
> Pure rename using sed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -340,7 +340,7 @@ enum {
>   	RX_NETPOLL_DISCARDS,
>   };
>   
> -static const char *const bnxt_ring_err_stats_arr[] = {
> +static const char *const bnxt_ring_drv_stats_arr[] = {
>   	"rx_total_l4_csum_errors",
>   	"rx_total_resets",
>   	"rx_total_buf_errors",
> @@ -500,7 +500,7 @@ static const struct {
>   	BNXT_TX_STATS_PRI_ENTRIES(tx_packets),
>   };
>   
> -#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_err_stats_arr)
> +#define BNXT_NUM_RING_ERR_STATS	ARRAY_SIZE(bnxt_ring_drv_stats_arr)
s/BNXT_NUM_RING_ERR_STATS/BNXT_NUM_RING_DRV_STATS/?

