Return-Path: <netdev+bounces-86763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE878A034E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFB01F23846
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5F19066E;
	Wed, 10 Apr 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5T44mFu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AA190668
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788050; cv=fail; b=cCdjO5Ff6LBZkfxKNHWsMQRBT8PZNY2gjTEdgU1/5bxgbrzlAT7xSNAEIa9DB9kzd/IA9NQ0IkRl/YrtM2GXdGMJuqD6tDf4UPJLHBb3VKBN+W7FIy+sGkzPdSm9B8Y8IvAd6XSNWlFiqDvS2W4DYYuU4kLUE7egEDt4hG8BoxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788050; c=relaxed/simple;
	bh=Q260T/iRnyjq9iY8YDaGCpi4L40AjiH/TxCNWu2lKjs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJf+vljUBbEIbemX2caOWpmnwwlBuzgws+BThOYusv3E++2y8IqLNUbggvDrFZvLG+jJ2w+pHjXva9ElGd5VtlU8TUcNRk2aBHAbIkAj/5PEHHdK1C8GVkVojRj+XzPiScL2NqbNDZ9OpIjD2DgQlkRhwMwfMvcQSip9HNfYbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5T44mFu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712788048; x=1744324048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q260T/iRnyjq9iY8YDaGCpi4L40AjiH/TxCNWu2lKjs=;
  b=n5T44mFudZ7W3rCmbSWDfA+IYbjCdtpsdR2lwwHm4KWU7AHSXUQS74df
   4wHtARjn3Xn1vfm2aGUZerdr1WbeaNmNEmvQndRFZNW2CYOJRwmj7nX2H
   +W69DdGpqAuQgdn7bIokKIDYdUwIeMJ2v+LHV/4Uhmm7AhmQ3CX18RmMm
   1n065hnW2jUNQe66uSnks+/+TwhATX6VyEAbkhVim9/PQvdkplecbezzt
   vOfvOvZUzCDbO/9HzcKbAlCmSugRbsLqQq2lbeUhHqVHMYKixh/HgzDzg
   Tg+1CoWSRiepfeWWa/GhouEJNjUD8dz3Q0dDChlWpnOXcWxVQObNhbp98
   w==;
X-CSE-ConnectionGUID: +45CaIAxRdyRiOKKQAPRrg==
X-CSE-MsgGUID: Cbioq6NdRCSY/kWkFvQiEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19571114"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19571114"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:27:27 -0700
X-CSE-ConnectionGUID: gt1gYxgFS7K6qNgFAe0m2g==
X-CSE-MsgGUID: tjea2rLaS3GSF0baI67kXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20740671"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:27:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:27:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:27:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsnmoK6PqgRe4tPHFyTdCItCJ+CE+H25Pq4KCrzO6WTx7ULRuLCkwbcfqJh8aVefR97n5gYlxbkHDmi7Dk9jiJq2zz9Eg9Ih3LnpY+aAe/QhJU6Ypnll6LDwYwZvFsmWmHfXQcaAmqW2pSnu5Z/6oJiHiDld2TYoFTPWKaHPfE34+UeODJ/ZC9MT74cfr033nqK3lb/imut4vVdGtzw+o4zv8HMgG9fHgr8Oeo5GjGXvSs0eXWGBPDwyPuke4c2ImuDJxMuTRwDAi0Kc/4XrDuzDb9Xby4fGb52WJFKXWjZ4ycBUbDuPxFW2XF5UkTjeHHpZe+BNPdaRTyWOfG2HHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCsg+o+fghxkb8yjNsjnAdsjuSJIS+0CR9zR6uSpNz8=;
 b=MbmwBU08GXZklPOXKd9+ITS8lxAvh3dn+o11I0KEptxFOj3s7FKrRomecDrO1NVOKpsrICwui/y1MjPrknv4k+Cs3O0+ZeI/FCJ2xZtMTE0mwwVEyEpszgB/JI+lAX+ICnLz6HJ40w4On2R7SQsRmpXDJR7RruARVxdhZW1vP4mSGRwRyWLAKFj4sHbitE86lh4/6GNBAmJ2Vopq88KSWhefxR6mlcuGx72/fd179P+1bj1ZsKgvu4pAuR+L75BA0cAhXSNA+Bs/emg3kbNYw1+5NEwGaZWwPKGbdQ9iPqonw0iFEPW2WRHLuuEWqwUi4fsA2VQPi1dZ9klyNI9/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:27:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:27:25 +0000
Message-ID: <fdfecdb3-2070-40d9-8129-01df41d4232f@intel.com>
Date: Wed, 10 Apr 2024 15:27:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] nfp: update devlink device info output
To: Louis Peens <louis.peens@corigine.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
	<netdev@vger.kernel.org>, <oss-drivers@corigine.com>
References: <20240410112636.18905-1-louis.peens@corigine.com>
 <20240410112636.18905-3-louis.peens@corigine.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410112636.18905-3-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5257:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqHh6NMA/+g7msUwoHHuXBJPcOQs7Bicf0o576NsMBNLvKrQ2pqLKIED5GMl8zxmGy+0Yfej9JIKPS2OyOxcUHS7274JM1bMvynKEUyHq+CTI3bsL3oufHSBX0LiZoIqo8gQudMjhwzcBe0PoNRPOBfpEi3jwzb+zdtcau4dDRAzYHUBCtUMHoP6ovQ4JuvJCZmeuaixPmyluJXR4GL6Qs31ER3K/2MzTth4r5aZiFzU5y2wV1hHROMMrdtRZOg302WEa1zmxnsWgmD0KoU3fNR/f86+u7dLRjF+A3WS1bvRXEnfXWeqJsHvLo8fPDE2mvEm860mtBZzkoTUGU/+Wk5lSSkLgkYLbNvetWD0mE+uuVouxPBfw3vRsX+GmQ3a1PPxrLseQl0X1YOplG7kuqyJagip7pVfpbTjypt1zKfS1N4StJTfnubvq/qpdlk0QWBArzEuWR48qOG8Nb0PB18wERhv2k9Iy2wyubY7F7huZxatblx0QzaPh+APrTD4x+LT0/B/HG+eKNd/ouzl5J/XW8uotMHcJMOH438SQubItBr2A+CtO9wF2QPbL9ra7Zvy9LnrsieOfhkzIEHFKoCm+mSoAos3cykgE5nFrJZ4bSJw3bhdKX1RWMBOo7Reci+uL3VSvlfw0YOZqaEW5ASNmDW19MwBMTybgFFM3Ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhPVDlJWXJKbktRMGEwblpXMC9YSGNDQjRvU0twR3BsUVJKYVgyTGVvQy83?=
 =?utf-8?B?UnBORVJ1SklEWWdnWGJSN0lFZXUrbmZKdjcveDY2aGNJcjhVZGptZmcyWUhr?=
 =?utf-8?B?Zy9RUXNVNjJrR0dLNjRGa3lBZzEzQmxjYUt2S1dtaDhBdkFmT0lLZzZDNnQ5?=
 =?utf-8?B?V2dBVDlHZmJPeW5SVHdRYXE0enUrNWp3c0FPTDFxZ1pLZXdWQ2I5VmZramVl?=
 =?utf-8?B?cndkNWRHd003b3FQd2ZEeGZWSks4VmhQa3QvbHU4eGdUMy83Nk5XclRTdWho?=
 =?utf-8?B?M2NSUFZTYTdyWWhxa2M0Uy93ZnQrQjVHMEVtT2lWYURlME5FSnZ0aUpwVHNG?=
 =?utf-8?B?VEFMSk0rSHozdUpCajlxSDhRT2VBQm1UWlpVZ0VlN2ZnZHpJVDJOUGdSSDlR?=
 =?utf-8?B?Tmc0WndQY1N1VVVBbWtZV1ovM3lKT0x3Tkdac0NUZjMvamU4anY4WkxSQk9r?=
 =?utf-8?B?THdHUVMwN2xZaXJoM3FTZUtkYWVsKzV0dklKMDRGRWduOUNGRTFWK2JsWkEw?=
 =?utf-8?B?RGs2MGZ1SkErWnhiS3ZzMWdBWEpIaFNnM3JEbjB3SytqUHFaNzBvR2dsYXdY?=
 =?utf-8?B?amxEbVdLVXRsd1A2cVduUVI4ZEtpV2pDeXV6SHBlQlNLZWpRL0luV0JrQVNS?=
 =?utf-8?B?K0xTM3VFZW01Q2xCSHhhd09oQ0F1bFkyUzZGRkVrcktMd2pjaDQwUTJVdENz?=
 =?utf-8?B?ZmVUR3IzT1B0ZFpBQXptT3UwOEpPd3FzcDl0Vm9qN2QrZEFydUY0N2Y2T1Fo?=
 =?utf-8?B?THEzUTJrRGZkK2VjdzYrUjZYME5XVzdJN0ROZXk0a3EwVy9xeFlPMnNJb2J4?=
 =?utf-8?B?SkJwZS94QThwQmtYdWE3THU1ejV1MUhybnc5SlYwSDZ3d1JoMkc2MXJPUFQ4?=
 =?utf-8?B?alZxNzErTVpIeWpwdTcwVFhQL21uSDlrV1ppbTFLWWp2dnM1QUtYZllZQmkz?=
 =?utf-8?B?S3ljdG5FajByR2F2QTdvaStVb0Nzdlp5WDRGekRUWXRCeElHZlBMTEdicitt?=
 =?utf-8?B?WEJycEE2VkZmSGM3RlRDZkdxSVpFdERrUEhFVWtMVmd1SkRwdGtlZUVTTGho?=
 =?utf-8?B?U0FJeXZVUVFLVFUzd3ROb3Z4T1hwSjJ1R2hkU2ZvY1UrMExRVDhDN2pORGk3?=
 =?utf-8?B?RjdZNjNjcEdDeWxJdmk1Q29ocUdWa1RCRnhKK2ljV3h1M0RWbXhpK051cU5Y?=
 =?utf-8?B?WXp5UmxMdk1vR0laT3lrZEtTRmQ5NFpGNzEweHVPTzBvaVc5RjQ5NGJvRUpW?=
 =?utf-8?B?NFlxbGY5UWJWU0V6UUMyeTdHWGgvUFhPbGhNcEVWWVhaUGNIRzBCaDlWTzU3?=
 =?utf-8?B?RWtNTVlpMGhtM2VERzc4VnlocEtTelJ4NDRTb3RzNlhyTmFUalU1eXA3aEYz?=
 =?utf-8?B?dllJUG8wcXM5RWcycUFvd1RDVUpUMGNMQ0hoQVFYalFGblJiMjdTd254T2Vz?=
 =?utf-8?B?ZFVjejRTN0NaUlBHbFdHc3hmREttVWtYRldnTlpDN2hSdUV5aG9kM1htVEI1?=
 =?utf-8?B?TDgrS2V2eEd6MkYrZk5ydnJlcDlmSGZKMXVXV1IrTnBCa0NSMVpUZS9Jemc1?=
 =?utf-8?B?MERFUWNxUk0rYmovQTBzOGJZY05zS2lQZ2k3S0hPRCttYk8yaUYrMnYzUS8r?=
 =?utf-8?B?bzNDRXljR0crMXJGNWhBT1hKQUJwRmpKMG1xQWFxdTFTT0E5aWFlRmFJMSs0?=
 =?utf-8?B?ODhCWUlMcFNsRDVTaWRmcUdNN0RybHZtZE0wSm5iOTZlWm9MeEppUy8vK3Y4?=
 =?utf-8?B?VUh2VkNpU0V4dDh0NWhVNUxuT21hMEZ6SUNKT0RPOWEvNmY2K2NVMDI4cGlS?=
 =?utf-8?B?cUpqc3FmRUlKWFRDb01jRkIyQTlSQmh3SnRKM245dGtKUlZ3aHFpOXp4OWdu?=
 =?utf-8?B?d24vWXQ2Wlh4MnBVeUdtQVlWVkh1RDR6a1FyV1JVV0lkejFsbzBjWFRhWlZk?=
 =?utf-8?B?L0JzOEdGWWh5ZExyTmdJeU1rL3h2ZHc5aGxndzhLK2N1UDdzL0YyVGFJdjlL?=
 =?utf-8?B?QTFlNnZUUTNzM0MvWlZjN3E1NFRVbTZzWHFvcUo3ZlZ6cHFQWkRIekhyNDFt?=
 =?utf-8?B?Y05kb1p3bGE2NWJLREVYVk10UXR0Um96Y09OL29LSDRhYVNPNmNwSHVuMzlY?=
 =?utf-8?B?bTd0cG5oWHlJMWd3YnVWUGV2akJramF1RC9zSUZCNlNndDNXWTk2MlRialF6?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e693ae8-e329-427c-b3f1-08dc59ad65b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:27:25.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Bk9JyfxEOzwgNoZhHEzo5xICJWa3W3Y0DOWAk8SkjEABcXIJX5YQK8mfAv3c+5ApOHTVZ+SgCET9ah8SRWgf7966uqmKo8UZng59/aitA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com



On 4/10/2024 4:26 AM, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> Newer NIC will introduce a new part number, now add it
> into devlink device info.
> 
> This patch also updates the information of "board.id" in
> nfp.rst to match the devlink-info.rst.
> 

I was a bit confused since you didn't update the board.id to reference
something else. I am guessing in newer images, the "assembly.partno"
would be different from "pn"?

Thanks,
Jake

