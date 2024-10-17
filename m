Return-Path: <netdev+bounces-136711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B69A2B9E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C67B22A5F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE841DEFEA;
	Thu, 17 Oct 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIEMghin"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E21DF246
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188243; cv=fail; b=potWr5UNKAghdAsr99MQnbFhPVUlcWamdxBLXSmxfY55L+n+gcqtsDxQipaVHPXtBw6Xz7QUTMuMYD37aKMiSM/S0Ia3/b4VS1yM7aD9eDK3p9n8FCzUyUEnBBurRwOgV7+6OaniXNdCPCoVtsXa2EpOBXnbZJCJmOvQ4+a3PbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188243; c=relaxed/simple;
	bh=AWUvsJV4M2Zq2koDMtasK/JiZ0jksliFt8Ue4IoJOa8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RgkB2z1JiDV5AvJCs34kMJIjAk1caYTowc5OGpkvCv4X57GyX5twlzYqaeMcm2Y/5vCkEkXOm1baToyVhHFj1q/oxzp2hPsOOtoKbn5drSOxu3oi/fbyQ1iM7vikzsjnEI+qeZ4QLzIBSCdCSxGUEYLu/8Ohy/1DlPLBU4DsKmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIEMghin; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729188238; x=1760724238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWUvsJV4M2Zq2koDMtasK/JiZ0jksliFt8Ue4IoJOa8=;
  b=CIEMghinyQdOPwPZN2F0pu8OI7ZFFcZvB83KYWWLr9R9fNyeRSLb4nbI
   bd7XBe6eiwCwgaiPkRh+8uofy5QJ57Ao+EMNjA+DOi60rg5oNZlGRUAtr
   JNdq+R+1YZ2RPG59TuB4BWkMkHu4nBLoBYbWkdWDKayzF29rNjRIwX7kx
   1tafxpaR6qfbAnHgqDaaQW269pMLQP0+OIA1M3pR2PmZNWukr4fMrj9+P
   zmgoAd8k/vt941EQ6oDUCkpcJrwZYtid9IoDasUmKIlyb+CDiKa17dr8g
   VM5dj4SGTtxrdA5MNUpeprqeC66LxrrKx4jnr1+kaBPSnpeWpF4xC80lK
   Q==;
X-CSE-ConnectionGUID: l0HjukrFTCutpB0HhLAZqQ==
X-CSE-MsgGUID: 2YgIafP+S8aOLhBGEg07mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39238746"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39238746"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 11:02:19 -0700
X-CSE-ConnectionGUID: X/KlBMTaSe+qJ0AtktBKqg==
X-CSE-MsgGUID: Bw9wn+TMRlmrU2a/SfNQcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83269819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 11:02:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 11:02:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:02:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 11:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXCAPKW6gQV4CZvXHZmD8YlHc5TXVShM9V35mT1Sydn6tIQX7PvZh26/GefohNo/sZw0rzoWJGQTjLpiGjO1/1Hz073gLiWwjF90KJglZH508WGU2V8kS8sdPEdpLXePTFE95kNTgO112gYEAfoWXRIE/aP5YjiCiAriHnRiwTTEIVLr99DSt9fzy67VC7VC0rlGjMcnWlrYq6khDBJ/EYaXqEfHnlvQcL0X5oveAsElS8ZWNBaGtkuXKfoKW2giEy5jEVzb5jx+dqWkEib3adpXsoE4SaftACoHTDMam81wf/nDVkY0X8NFDIRjs9IMPFS2cDo9KZG876yb93J0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kxoUzhnILL6FlkcW8zO5yhpE0rqCVo/uJtPpRZJfKs=;
 b=wy+DKOtakc6tkDsjCrpbzQlRJi/ngwx8+K9w0rFoXrX8tj64qgfc+N/uSS/SgplNMkPQUTQS5Ux1zuiHLwe0v99uZm9GhBcEfwX/ygUylE2vgb+WgLVtxcmVSL4JRUPUXZr5q+6yGQJfpeI7oft/oJURKddaHK5iHyI4rbnhs/L7xLQ2wdhViId/hrtAdjcH5HGBSt5joSnTKVtsqpDMG73xQOQIaY7+gguTKKvfQEgalDRA9olsIbAW/jBRMOaKO9eEwdzO2Om6cHYnPmEbVgr6KirWDqujuvhB0roO7lqtS0YiSbOzmzHoCWPQNUGdLew6SjHiAKM+6CbICNtXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 18:02:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:02:11 +0000
Message-ID: <c24b5c95-33b3-4501-ad5c-4315b29c4a18@intel.com>
Date: Thu, 17 Oct 2024 11:02:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next] ip6mr: Add __init to ip6_mr_cleanup().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "kernel
 test robot" <lkp@intel.com>
References: <20241017174732.39487-1-kuniyu@amazon.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241017174732.39487-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1d1530-838c-4df4-c847-08dceed5d2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2F5dS9kRnNYNjcyRUxEUDc0TldlQVVleUZ6TnpWSlQ4T2xRd0wwdndaTHI3?=
 =?utf-8?B?L3FVRTlHSUh3dndVUnhIbEQyY1c0dDRheXRyc1hhWE1IVk1RbzhValNOSHhI?=
 =?utf-8?B?b0Qrb2R0WDVHQ1dIM0VqTmROTkRVdWdrWEdXbkRySEhRQWhjcHo0MmhrTmVB?=
 =?utf-8?B?Q0VKZXkvVDd1ZTlQV2VaTzVRbmd4bzE2RjA0K1dTN2lvbzI3NWxxWFRuY1Na?=
 =?utf-8?B?ZlA4UlRvSWk2Y21zUnNqc2hLYzNBanh0bFBmbFpzKzQwRmV2V1U2YWZKZk9I?=
 =?utf-8?B?WlNTdXRhSThKTERwSTRFemdGRUtaeDZJNGdWTC9QRDh1SDZ6TFV2ZEdzWHk3?=
 =?utf-8?B?TTBqL3BvVGNYMHNPbXY1ZTRRRzRlN0NEdHpod2ZxYzFsSzVyMW9vbUdhbU9r?=
 =?utf-8?B?VnpZb2tZVnRETWF6YWhJNXJMbk9jSk9oQ2NQUU52Z2NCUU0vQlk4eXNWaWgr?=
 =?utf-8?B?UTRGMnN6NE0vc3prbGZSUFE4c2s5bjNWempTYjhQa1duVWhabUZURkFQVTRG?=
 =?utf-8?B?dWd6TDVkN3ZzOEt1Q0tCWWxNNHhDU1V1cDI1aVlhZTV4UUF6RmZ6OXRacXNC?=
 =?utf-8?B?VGl5Qkd0YmtBS3ZCN2d5MFFpMStxK0NZU1hRNmpEUXBoTFh4c3Y5WUhCcEM3?=
 =?utf-8?B?UlRBQktpRE9FVGFXRCttTEpEd1JoZVpBemlvb2YwaW1qODlKZnFvQWJWN0xU?=
 =?utf-8?B?L0xLQ1RyeXI1clJGdG00K29aa1FLWU9ydEFKNDA2TjdualFxSmwzazVlUTZs?=
 =?utf-8?B?TjNtZ01vdnZOcDBFMytvbGRRZE1RY2dSSjJNeUN4M3Q5aWQvVThMWTZreFpu?=
 =?utf-8?B?aDBFSzlBTW15SW5ObzJkY21EVFlyOCtnVFZpZXAxbjN3cE54QldDMHBZcWtL?=
 =?utf-8?B?YWpvT3hjb1piczIveEd1ZkQ0UllJZDNUUHVvc2wxbjE3SERySjBqeTVxakx0?=
 =?utf-8?B?eWVSSzRRSXlCanhuc0gwVzFNL05Zb1JoU0FORTZJQVdSNUNoS0FuVWFFSU1q?=
 =?utf-8?B?VHZqdGJhUzFNdmtQdEdjM3kzNkZOUXN4MmplaUNIcXpldGswVWNnTi8vQUNU?=
 =?utf-8?B?Wk1FQml2dXNlRWxnYnJ0YjJtTGpBY1JnTkd2NVBJWWIwd05PMDJJT0R5WEcw?=
 =?utf-8?B?Q1NraFJCQTlhZzlINjVPMnhKK3ZKYnlYdWdDR0pRRFBaTTViR0J5WFJLN3RP?=
 =?utf-8?B?V0V4SWpkOWZaUkt4RHluZlg2YnY5T0ZEanBvQ1hkTHpha0Y4eFRycmRaTlRi?=
 =?utf-8?B?ZXovRnROcUNyRmlLcURmaC82WHpBNEc3TUxYY3JmWnUzdGdRblY4NHd3L3ZR?=
 =?utf-8?B?bkRod01pM2ZHdmQ5MUUzWDJwUVFvTkR0Tm5kSTZ4M2k2WXRybll3YllNQXNo?=
 =?utf-8?B?VkxIUzlabnF4TEZKSy80Tm1ZT2V0bWpORnA0WDlKN252dkpxSXBqdEc5cmVo?=
 =?utf-8?B?UTkwR3BrSkNKazJlSVFONHdDeHNsUzdTSG1KYVlyRGZQUTBsYUMrUENWZjlD?=
 =?utf-8?B?eDFodmVNUWEyNnJOVmpxN0F2NitBL3h1ck0vU0FvMFRUTjVIZkxoU1MvNEVM?=
 =?utf-8?B?UFRIZi90M1FBemNhaWtyRXliTUU0VVRjeWVKQUdiL0NNRHpVWE1RZ1RnZEtq?=
 =?utf-8?B?SEtUYjhsRm5TeGEwK2JQa09tL3dwTnk3UHpydDdXWFc1d1ZOZEZpSm53aW1N?=
 =?utf-8?B?Wk44Z0NBWHRtUWNIUmFwS2xiUVBpa0xKM0RYR2N3Slpsd09KekxEaUpMUWd5?=
 =?utf-8?Q?Jt5aMZjGHk2afIy9a4wTjbpWq8JiZ1mY7tuMeqB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCszbGNUSExpVzV1cmNHWFJCNmF0VmcrSURFRmxIbGVpYXR5MmhmOTYxQjc5?=
 =?utf-8?B?UEpackpKd2h1Y3A3byt3Z0ZyZC9KSkpBajdJdUVoV3hvejY5ZVZWNEptYVkv?=
 =?utf-8?B?WFdOeHpHRjJrK000OU9lV2FJOGt3OW5vMS9BV0VtOVpZK092dDdPdEpUYzFs?=
 =?utf-8?B?cEtxWVpSWkVkOWJUTlR4UDdSSlFDOEJPWHlrbjdXeC8wSmpob1orc1RoSDg1?=
 =?utf-8?B?ZHZBMWIxOGVRUFRCTTBRT0x0ekZYM1BXUktQVUwzUlN0dW1qRllDZW1RT0N1?=
 =?utf-8?B?QllyNzZDTmZoSm4rMHhISjNPMjFVY0grOE8xalpDenFPUUNoUzd5dUtSSVg3?=
 =?utf-8?B?S1lXL3IrSExlbW05RUhxc3g5bTFNL3ZJRGZxanZ1SHA2SFRsK29Wc0tkTEho?=
 =?utf-8?B?cHk5dExBM2ZXUFkrYVlxam9QMzZYd0tXQlYvQ2F0ZDNyUThWYzM1VmM1ZTh1?=
 =?utf-8?B?K2dlQks0SFI1dURjd0tlWTBrMFJvZnVmb3FSNmg1aENCcU0zUzhSc2hVRVhs?=
 =?utf-8?B?VFJIbXdIL3ZYNXErcnNmU1VlMjlDc3FpSjFaZmNSdktIbmk3S2hGT0ZnRS90?=
 =?utf-8?B?R2M3ZS9PK1lkaEcrTGJyWTNFNXZDamtiR3J5VURTeHJVT0ZvbkZVOG1Wa2Iv?=
 =?utf-8?B?SGVWVUVXM1I1bDZoSTJydlNZQzRjMEkxakVIY21XY01PS1paOUtwSkd6c2s1?=
 =?utf-8?B?OC9HNE5XM1htU0dMQWVCdkFrSnF6bHF5UUdaN1ZHNThHM0dpcFBHYmhwd3RD?=
 =?utf-8?B?dFlXY2hzZDZPVEJXOUc4RWkyR094VzNVSFNqMDM2TXhWdGI2aU1hbWFrMVZC?=
 =?utf-8?B?NGVZblBlOENuODF0STdYMXVqcUtxTVVjSXo1YUlocHA5cnVESndNbmdLTmhr?=
 =?utf-8?B?WGZleldtbDFRTFZCNUk0akJhc1ZJeG1oWUR3bWpUYmF3c2tES0NBNjcrcVFi?=
 =?utf-8?B?dEtMdlkwc01FOU9YS3JaNkh2WkxiZVhVQTRLYXJ1UDk5eTFHUFNhQk5hV0tW?=
 =?utf-8?B?SGZ5TWQvSWV0VXN1RnJzQVFLV0lMckpua1FIVG1peHhhVkFJSkdkcmpHWUgv?=
 =?utf-8?B?K09ZMTRBUUVkM1ZuQ1lScXAyRTFrR3d5dWJESE9hQkhSZEVLMGRVaDNLTVFm?=
 =?utf-8?B?K1l2OVFmeG5NQStRaEZGQVZCdmtrZHdDU3pySVNjWVVnWXVza3l6a2l0Unht?=
 =?utf-8?B?WkRhMUZoL25MT3hKQm91ODV6WE04Mmp4ekEyL0pHRjB2WU9OREVZc0N1Mm0v?=
 =?utf-8?B?NzhEQWIvWkdXVVNBeTR0QVNRbW13ZTlrM1RNK0NVd0VZbDYraDUwN2NPY2tt?=
 =?utf-8?B?VE5oOHNVUWV1WWRrSFkvUWNtTXVveWRkMjl5V1RrUmlYVG0xbUdOdUR2SFls?=
 =?utf-8?B?RHRXV1pEMnZUWUtvK1daZTlsOUpEeWUyWElpZGh0NFZkYlBVdmdvSU1ROUpY?=
 =?utf-8?B?U0tSQmw1YWFyemJMZXBGTFI3N0JZMGZuOW9OYzlvUENlSzEzQjRxUEVCaE01?=
 =?utf-8?B?OHovaDhjOGhXb29qWnV4bjZLbFZnLzFibFl1ZzIrZVBPcXJ6VjcwRUJXaEp0?=
 =?utf-8?B?dDh2QjQ4Mm5jQjZOQ0JybTVjcm1oemZHd21JZkZZRll0SHdlQ0o0VEtXdnli?=
 =?utf-8?B?NkdLYWNPYzFZR1NpMGpqdnZySmpUeEN2WXpaZ281K2FOeXhIWXNoNnpuZDNz?=
 =?utf-8?B?VCsrY25RV1o2Z2pKbkJ5cjI1V2NjdnNUMHRkUi84YWxSVGtNemxCOSs0UTFO?=
 =?utf-8?B?dDhZdzYzcTdKTVlsMTNadGRGMlpUcGNSTis3TTA0dlpDS1lpUnpONFhUMGhU?=
 =?utf-8?B?azR0QmY0eDdiTFcvN2c2WW81UkFXcDNUbFN0L3hGTEFvbzZLclA4UGxkd3lO?=
 =?utf-8?B?R1RmRHpWdXVMbENGQ1dFYXZRSys3WDZKbGxSaHNtVEV5VklQd0tON05qRGN4?=
 =?utf-8?B?bUREeHdNOEloODBwSmw5RTA2a2NRY2swQ3Fwd3FUcHJkZFI0cFV3UWFoMGpK?=
 =?utf-8?B?encwUXlRQUpzT0JwQVZFN0E4UXEzVU1LNjJWendwRy9XMGhLUi9SKytJSUd2?=
 =?utf-8?B?SVpBeDhpYVRQR0tlRXFYcDViU2V1TDlKVGVKWE9oVXNlRFBhdGFvRmFtMGxP?=
 =?utf-8?B?UVowVTcrK3gxQUwvQ2MvWDB5S0FxNXhXVW1TanRsYythKzdVTVVod29MVVlk?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1d1530-838c-4df4-c847-08dceed5d2ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:02:11.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CR4Xv85I93UUMgSL8wmfKzJlXE/0/paaZxW0q7XlHeDxZJH1F+ixqs03tcXpILwx0I5n53+WSymc2aRzP4lZN1p1yFDTEDrBbCj8P168cLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com



On 10/17/2024 10:47 AM, Kuniyuki Iwashima wrote:
> kernel test robot reported a section mismatch in ip6_mr_cleanup().
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x0 (section: .text) -> 0xffffffff (section: .init.rodata)
>   WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
> 
> ip6_mr_cleanup() uses ip6mr_rtnl_msg_handlers[] that has
> __initconst_or_module qualifier.
> 
> ip6_mr_cleanup() is only called from inet6_init() but does
> not have __init qualifier.
> 
> Let's add __init to ip6_mr_cleanup().
> 
> Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410180139.B3HeemsC-lkp@intel.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 437a9fdb67f5..8add0f45aa52 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1411,7 +1411,7 @@ int __init ip6_mr_init(void)
>  	return err;
>  }
>  
> -void ip6_mr_cleanup(void)
> +void __init ip6_mr_cleanup(void)
>  {
>  	rtnl_unregister_many(ip6mr_rtnl_msg_handlers);
>  #ifdef CONFIG_IPV6_PIMSM_V2


