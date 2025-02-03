Return-Path: <netdev+bounces-162223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7487A2640A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C77B1883375
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCE20E03A;
	Mon,  3 Feb 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4tgkL49"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423F20E02B;
	Mon,  3 Feb 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612266; cv=fail; b=d1uNSs/j/njMy4b3Nb280ioiORclEEpn8IKo25AipTnauXlTHUsyYYCTUub9/R+NTe5lhctRGjCv3U+qtugJE3btMNi6mKdV9qJHavQCRhSf4w43RilOjy2qSiqbAdowp0u5krE1a8fgbhVdqu1VdR/zrswDEwqxEiXsIxsE44w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612266; c=relaxed/simple;
	bh=GKhZ0m6FpF3YPL4g6dXktmyz+nFl3nNJ103bZKdg5BM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dt3BDffWxKp5yb4OfRVQJOKVMl9uUlLIbZISSWWUKd/atigSATDl2H+kj+5aj2Q3WebAiskZlxmcNXUiQAybVmMp7CV0lGRblVlZmNQ7yFomr669lArHfsZG3ns4bbyjoxYvvss2BFgPu9PDxt9hH8pXwNla4GV6vkBOO5n95lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4tgkL49; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738612264; x=1770148264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GKhZ0m6FpF3YPL4g6dXktmyz+nFl3nNJ103bZKdg5BM=;
  b=R4tgkL49cIiygthDriIL0fv070PT1AV9OvEB+2Ru7/wn5Ok1rbxMELoE
   1SVAEjk8YuVY+hjfj/rbkhFJlHMO3WRnsgyz3Sl+KKeXJ5SsMe77GeFv1
   0/BgZv/yn6NKx7C2BkxdvW/Wb2TpR51quklZyVXPhx7oios38Jxg50GJ1
   C2/Qol2XwTGVvwAjBdP0J3OG6yKYKiBTUlj/H9I/OVz+V0VII1Wa79jtu
   XTswLCdLa5hXFjpXdFFhvrKnh1lag6VjiAnyuuaSrssuVZjuzQrPdaBGM
   LNsqH5oVzyTFNwuPnDZOO77y/Y5BRDS+YHz5GNNR2zZMg1rutd5L5pg8c
   w==;
X-CSE-ConnectionGUID: W48u8Lk6QeSM9V0E8k6fTg==
X-CSE-MsgGUID: AwsX8cigQdq+JcQgJ/kIEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="50510261"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="50510261"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 11:51:04 -0800
X-CSE-ConnectionGUID: CuQVgLgzQom07xJPNcS5Xg==
X-CSE-MsgGUID: UzWmzMijRx29imfDSWBn8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111226129"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 11:51:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 11:51:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 11:51:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 11:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTbJ9/qsoJkv+IFnBe6VQ/yqlp6ZxE5G0b0WxeJ5dchUo1Evp+B+wsKlrikCClddnTR/SZf6wxUnZw/iIJE8Dsjo2pArpiSc0kCCq6X0/T9LI0lhxZGPBcHYmsNhAr0fEF//RN1LXgD5gEeckqsDexSXn/4uEBEGe7pFD+sh/i/yybqHjz8hqrzBcmP9bpQ2KtuzLUe7Bu//mvyFQWWvxITU/oZ5LI/QTUn+5QmNrd/ribEUO45T9FEZShyBPz9MS28JlZvMqK85fgL+sirIv8rJxR+EM9s4P50jALkmi0FtCD37qofyXvKwtYS1F9sxeD4oMpaZJXx9qVqt5I2VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1P787BC8UX2RnYFC28psjr9xnN+DtT2NokLCljXYes=;
 b=Mzb8UBupTRhQAP0FjxgoIxYEW8IERpQKKRtBrKr1RGlg0mXjWqDd+WPNsrEckoyLVlr+PpvFAA6grr14S2dMO0W2e2jc2YwlXoCGlIshF5L3W2B+6axvWJ4b0dobMIFwKWDxTAmA/26CK/VDVIH0ZhDxj9gXZF3z5u7TK7Gz8rnQTNNkHWT2h6FqW9+GTV651eL9f/pin0JSH3SGFmNhHCfWoMWZY9sPyVopF1YeYpRlytUti0Fl3y1qNRmOcz3D1fEDEjPv0+1H+vKVtfxrQyTv8JTsAj8KFvj5wKm/VXplQmar2OwLGAEvupx0I/2+65A9kpaoM3Ol3JfDVsfD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 19:51:01 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 19:51:01 +0000
Message-ID: <59844741-1b08-42a1-bf02-1ab6af4184f8@intel.com>
Date: Mon, 3 Feb 2025 11:50:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Mina Almasry
	<almasrymina@google.com>, open list <linux-kernel@vger.kernel.org>
References: <20250203191714.155526-1-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250203191714.155526-1-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SA1PR11MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c059ee-ef30-4cbc-5746-08dd448c15ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1FMZDJhc1hEb29xWGRNUDdFaFZsSDVNM0tLelFqT0JCZ3c5SS9aZlRxMks0?=
 =?utf-8?B?Vm4rdU9UNXd6MTFET0t1OWZVWGpvUW95bEswY0hyV1VIdlFOZjQ1b1U2VUJS?=
 =?utf-8?B?bWNWRGwxbjV1cmRGYVlnUU9UZGlNZ2c1TWNBcklsaWw4ZWhZNzNSNnlxUEFp?=
 =?utf-8?B?VzdXRFBlV2M2VTBVL1BoTzZLa3RPUnAwaVBQVG00S2EybmxrK3VjZ0gvWnU1?=
 =?utf-8?B?S2IwV1J1b1NZa1owMnNiSlVoVlNxcmJnT3dMWjY2ZjhLblYyQjNWbUNlY09w?=
 =?utf-8?B?UlUwbk80NHluN2s2M3hZMjMvbHpjZG05T3hadWRYUXpaZ0dEcVg0KzhKNTRX?=
 =?utf-8?B?RnIrbzZrcDlYZVk0ZFptSHh2VTN4YTRZRTJudjE0VnJDRnptRVRBRzZKNzJy?=
 =?utf-8?B?M2g3S1lUZUw3OW9iVmZlS2lJQU1RR2NvalJ3czZiSXduUGFnRGhhditWNjFZ?=
 =?utf-8?B?K1FncGlmVmlSa1RhUHI0b1Fyb0pCN1RVMWQzREhicVY2QkIzZUpRaG9TRU45?=
 =?utf-8?B?ZEpTelR3clJSK0tScFlrUThZcjVWUDJyYllLOUhET1UzOTIybVlkdWFxSzF5?=
 =?utf-8?B?YzVVQXdHeTZVeFJBRC9xNlU1T1JuVkIvMFJ4M2JYMW0wbFBWeEoxaHZkWTNI?=
 =?utf-8?B?eTVGdTJFMmxuM2doZ0Rmd2tUOTJxNjNYRGV4dHlNaFBKeFhXTjl2ajJVMjFt?=
 =?utf-8?B?dkJDRUhsd01yaU9kcnk1RWZUVEN1Q0pOSjlrL0JKaFNQbDBUSmxSRmkxUGlv?=
 =?utf-8?B?d0s2aDNwTWF5N29DM1lYZG05UGd6WGFxUHh3VkFuWWxqeGUyTnhqME9PU1I5?=
 =?utf-8?B?cFl0blRyNHA5MG9LRlZWaUZ4NjAyY28ydTJpT01aZTROUTVDY1dKNUEzNUto?=
 =?utf-8?B?b2ZERmJHUzExWklJb2Q0em53U0U5b1JaYlZQZDBIUzdNcERobGpCRGNXM1ln?=
 =?utf-8?B?dUZkSU1ldUtwcW80bG1kWUQ3VWFaWWl2WEtjMkQrZDVITDQ5V2ExRlpjbzBZ?=
 =?utf-8?B?bmNHNW8vbGhITHN0NjRyMm91TDJMUjdiYXVzdDVuY2hzOGtsUDhjVEdVUko2?=
 =?utf-8?B?QzZTMDZaTjhNZDBLRUp6emRCQkRpeUNkalhMRDZaSFNXOURBeGx4bEZtdXAz?=
 =?utf-8?B?OG4yV3ZCUWg4UzA1a1VvR0ROVnhwaFdveUcwTjJRWUErSkFuRDBqcEJUaDNS?=
 =?utf-8?B?WHV5TGFPYzZ4M21wSTBuUXhvU2c5R0M1QkpwZ1dIUTBBSDlZaUVlK2xFbDJu?=
 =?utf-8?B?NHMrVDh5NzBOZ0x5UTk2ejVJY2duTnNBYUtlemRuUHRJeGYyNHBrYlFJLzBL?=
 =?utf-8?B?NWJ6T2lvMkVhZVFEdThyWlB5dElHSUF2TUU4T3QyZ3B1UGorZjVJQVdIbXRj?=
 =?utf-8?B?ZmNJMGl2WmprNUNqNVZkeGVWcXF5bUsxU3VHMWFmWWxBWTZrczRHREhBbTln?=
 =?utf-8?B?ekR3Tmk2M2hadlB1aVRsM2hJdTA3SUJwdlFRb0xSQUF3RGZSMUwrbHp4MDly?=
 =?utf-8?B?M2IxaDJjWGdvd1F5VzJlV0NOenBneTF2aERQUW91UE1WakQ4eDFTaEQ3TDdW?=
 =?utf-8?B?YUViTTBIZVVTZDBhSWFiQ1BybHlMSnRyR3ZZNUNHOSt4QWJGUExpWDRoRGp0?=
 =?utf-8?B?YWJ0RkpYRVJyQWhncVU5T3pKV1ZnWkp0UWF1MTRjdytTa2Q2RkdTUlJvL1B4?=
 =?utf-8?B?anlZVkRKakptdGxYbnc2YW43cmNCY09LajVYc0Rob2x0MEtwUXdhdXpMNmN1?=
 =?utf-8?B?d3REeWY5eGV0b0I0bjNuVnJJTlk2UXErOUszMHZYSjdNaG4xNTdSZ0ZCV0Jp?=
 =?utf-8?B?ZXQ3Y1pMaFFJQktsZWV5TVg3S1k1S3Z1b2xNSTcrbDFqUnBTckpJY3cxN3lX?=
 =?utf-8?Q?eyC1mwJV7PsbY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q28zMDZ6Zm4ybjg1TGlSQjFVV25TMWREa1cyOEF0TlpDNUdjYUhnaHZMZEJL?=
 =?utf-8?B?UWVLeDlxWWVIZkQzdHBuNU9PMXhCQXJRNG9QeE05Q1puZFdmZ2VVV2cwSnla?=
 =?utf-8?B?Q1NtQitOV1V6TEhmMGViZkVQSmFUSVR2d1U0Q084Y0RBdDVrYlBsOUFqSlI5?=
 =?utf-8?B?dzFoSFRxK1ZnS0ZuK0gzZXFxVithaHN1TWhFN1hzZ29ERUdmUmpwMENVU25C?=
 =?utf-8?B?OEhiejVoYkNLak16S2hjclEwM3JCTlVydnhWWHdsaHhqc3NwdGtSN09hTFpX?=
 =?utf-8?B?YW5sYXlrV0hWVWN5UWxGQlhmQk0xWUNwNTdWcFVUWHA5bFB6UWlGc1VJcW9P?=
 =?utf-8?B?ZCtMeVJCcWtSZ0ZMcVJkOWtXVXRJdERqbHBwNVFMeUdydXVJa2FCZ05OQUla?=
 =?utf-8?B?c3JHejNLUXEveENMYTVqMUVxMVUrWmcxWEl2MkNJaldjWWZQUjJqTm9WZjJ0?=
 =?utf-8?B?aElWVmRjY3lMQU5penpLMGlWaWsvamNoY1E4b2g1TXFDZStNQmM1d2RRaGVn?=
 =?utf-8?B?UXE1NWV5L1h4RDlmYzBxUWpCWWp5NFRzbGhXbkZrNEE2K0hLb01oSm1lM1lI?=
 =?utf-8?B?ZnNEa1RMaGk1R09oSFFMcGRPaUR5dW12Y01YWVBXL3pwc0swT1JuSUN0VW9Q?=
 =?utf-8?B?ZStFaS9rQ2daMks3cyt6WHA0UWwxZkU3NVR5Z2RTZlBMRE9icjR3WW96cWIz?=
 =?utf-8?B?TmJiYUJOajJ5UFJWZDhoOTFKN2QwYUdwM3lCdlR6S2d1K21sVWJrS0U5alg5?=
 =?utf-8?B?UjF6dEpDRGlvdmtDUzJ2QmhMNmxyaVJZbzFLSnBnZ1FNRisramhrTUJ4dkFY?=
 =?utf-8?B?azZTZWZUVnhGT0tiWkR1VFhkbkZzRFJDaEZIS3FNUDRLcmlUbWRPYjRtVzF1?=
 =?utf-8?B?VldEZ0ptYmdhTm5jYWRSUTdtT0F5YWkzcDhqZHlabUVaSVozMDNUMlAxanAy?=
 =?utf-8?B?WlJyVTRaRE5pakV4NFowWTR4YStxMUozcE9pcmV6RjVkUTJkMUhOY1gySG56?=
 =?utf-8?B?dTA2eWplS3o0R3FoMUJDVW9aZXBOSHdLSkJVS21GZjFkNlh4bmNaU2hKQzU3?=
 =?utf-8?B?RTMvWmlxVmM3SC9rVmxoMXowOFZ5Q2pPY2NQWnFEcnB2VS9xMjEzTHBXSTZ2?=
 =?utf-8?B?N0VRY3crQndwNzhRUW5uYStuY2FwWFIzRDVTSHJvZ1JYSnMveHJCS1diU2tz?=
 =?utf-8?B?N1Q4NzJlb2V2emY4S2Rjb3gwd2lVSU5BeDdkVmlVeVhkMjU0S25VMCtlYXFY?=
 =?utf-8?B?N3l0ZnhhSTZHcWQ5ajZuRFJrNzVXc3M2bWtDOWF5aytuOHBvUWptWEJDSGdR?=
 =?utf-8?B?cDkzTHo2bnZQU1BtNjVJUHVrUXdSNU16T05xWnlEQkFUMHp0SHlZWlBXYjNq?=
 =?utf-8?B?WmNyNmsrd0JZMG1nUGJZSWFTY0xwcy8vWm9WYkZRbzgzcDdkbzFtV3FuYzhM?=
 =?utf-8?B?UElrNHBDbE4xeVBxc21aVUM5VmRDRWNHaEowOUZwWHZMV0VUZlRUNUl0Mldp?=
 =?utf-8?B?bFpRM1o1M3JDZnBFS3g1OGt4TTVuYUpwQTBrd3E0a3p5S3dZN2U0cTNBdkQx?=
 =?utf-8?B?Z2s5U3JucGFPWTQwMkZPQm1Wc0FSNEVjUVUxMThWRVcvL0p3bll6aFNhbXRw?=
 =?utf-8?B?ZVY2MHFVbStrdC8vYmk2dnhwYnM2WlgvalFwS0NNYUtLSytSUExqeXIrNDhr?=
 =?utf-8?B?d2pDRDlQTkx1NVVCTGJhRWFUVjZySUwrKzZweXB0TzVTa1BXb2hmT0swc1RC?=
 =?utf-8?B?Sks2OFBISTg3WmNQTzJXb1EydzJEWGQwclhocnpNQnU1L1BXSGZla3RMSlgy?=
 =?utf-8?B?WFdGZXRLd3JybEpzNWJZY2ppTVpPQ251cHk4NGtteFBCM09QTXNQejRab2dW?=
 =?utf-8?B?Q2hIbkFHcFRGM0lsY3BBa2pYZU0zUFI3SDMzY0FBekh2alN5MzVOeTJ0TTVI?=
 =?utf-8?B?VWlEVVJyMW93cURoUlZQNDNIU1hWbUxmajFFTnBwS2dpRGR6VWdBVWw5dVl4?=
 =?utf-8?B?R24vTFdrRGtoZlBqTjdHUjdXMnBMcGo5Vy9CcWFUUWJjb2V4aGdUY1dsZ3A2?=
 =?utf-8?B?VGF0SzR1UnIzdkZndmNPeVZPbmlDeldObzgrKzdUMVJpSXAvd1lsajFLMkV5?=
 =?utf-8?B?TEwrSkI2UFV3Rk5HWXkzTmlSdmlKNVlpL0toSWFsc1BqazJ3Kzc5UDlWeFdh?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c059ee-ef30-4cbc-5746-08dd448c15ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 19:51:01.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUzJxbD54K4ZyEEuc5p9E+SdIfoUAjEFt81lYmnWFYAYL7gTqEBdL8oLC7pvpO7Xfd7k/mVvskh/KbnkMsDSuTcqsIji5utVnLx1mJhmitk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-OriginatorOrg: intel.com



On 2/3/2025 11:17 AM, Joe Damato wrote:
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
> 
> 1. Queues could be created, but napi_enable may not have been called
>     yet. In this case, there may be a NAPI but it may not have an ID and
>     output of a napi_id should be elided.
> 
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>     to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>     output as a NAPI ID of 0 is not useful for users.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

> ---
>   v2:
>     - Updated to elide NAPI IDs for RX queues which may have not called
>       napi_enable yet.
> 
>   rfc: https://lore.kernel.org/lkml/20250128163038.429864-1-jdamato@fastly.com/
>   net/core/netdev-genl.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 715f85c6b62e..a97d3b99f6cd 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -385,9 +385,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>   	switch (q_type) {
>   	case NETDEV_QUEUE_TYPE_RX:
>   		rxq = __netif_get_rx_queue(netdev, q_idx);
> -		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     rxq->napi->napi_id))
> -			goto nla_put_failure;
> +		if (rxq->napi && rxq->napi->napi_id >= MIN_NAPI_ID)
> +			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> +					rxq->napi->napi_id))
> +				goto nla_put_failure;
>   
>   		binding = rxq->mp_params.mp_priv;
>   		if (binding &&
> @@ -397,9 +398,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>   		break;
>   	case NETDEV_QUEUE_TYPE_TX:
>   		txq = netdev_get_tx_queue(netdev, q_idx);
> -		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     txq->napi->napi_id))
> -			goto nla_put_failure;
> +		if (txq->napi && txq->napi->napi_id >= MIN_NAPI_ID)
> +			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> +					txq->napi->napi_id))
> +				goto nla_put_failure;
>   	}
>   
>   	genlmsg_end(rsp, hdr);
> 
> base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76


