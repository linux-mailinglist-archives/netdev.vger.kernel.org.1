Return-Path: <netdev+bounces-230115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD8BE434B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45CFA4E0FA4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A31643B;
	Thu, 16 Oct 2025 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlfQl2Qw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF1273800
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628270; cv=fail; b=M+rGcx7vrCp9wjtVDNEkTg/8nVFLMHZm3kobJQBaLBxYAIZIfI4NwK8adIqd+xmS4nMKqIJ+MJQbo8r7Gq1j6iu4WnED9QwlvF4ySjg9M1HORlDB1uH4DTEwm7ajHFxT6MxStAXTyoPz2oWAlEZi1WtVCHUEWWQlE+EQxxk1uoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628270; c=relaxed/simple;
	bh=2gg3Al2+nMABi0DOowFAW5OOOCdj458/bHicS1MWZ/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hx8VbsZfjkQnVLKU4xkrKxcy+72gs7OWjzAIJbt+7c4yQngEr0Jfcxm2FEOdpyWcZXrTm8EHjPVMgs545p/hWPmLM4/i6ZvgynJQr3FNxC0DVEBzwvrD0u9ljEQ/4ZsdXb5UOJ82UvDdS5p07q6F2NXltH9dBsGg1v9CcnzKA98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlfQl2Qw; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760628269; x=1792164269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2gg3Al2+nMABi0DOowFAW5OOOCdj458/bHicS1MWZ/0=;
  b=XlfQl2Qwyf+NYncDiH00QAoinJVFPZHM/MQ/L1wEzqexT1pe88CJKIL1
   r0B/a1+Xi+36VSqVMmtsTN7m2mMDtlp2OW36hp2Qs18uvciBWTQrQ08GT
   h/CBChmvnLVdDpIE16H7/NDn9MUT6nYsxOWqJMvRkWkujOONZP3OIqHHI
   pO7pbzX9lvqCRgaYkN6UP2cS3gMR/grxCn6NmjwQIpQUgtvsUsFYpli/5
   PppupFtY6/f/+hqAxo8/lq85eMqkxbSBgFnDLDaYJ4mg5tS8yuF416mbL
   nZqqrqOnpPNAf7WpQoZ5sv4KRrTKbncW2prR6vA8U/drYMMsjIeT6SngH
   Q==;
X-CSE-ConnectionGUID: GHxv3SLSQw6sIGCEPFaCZQ==
X-CSE-MsgGUID: NnXudjvRT+qtUk4HRtx2NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62918454"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62918454"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:24:28 -0700
X-CSE-ConnectionGUID: yTXaXcNMTM61VF2BLwZDMQ==
X-CSE-MsgGUID: zjrZlICjRnOaVUviesV2aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182892717"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:24:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:24:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 08:24:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLylYNhlCcmGwhIj0Ieqec2RinWHukl+lJpYvlQ2CPYcmE9p60JCaP1/+cl3pK9BiEeKcN2lSrEVPTUtlxlSBR/Q1GFdmxCY4+zU0bIvmcjuAYEjTrDa8CinnT+iy+ZYYsxG9md0TgUNUnt4uOyYBwBs9ZHca3kaE7TTQzxYT4kWrwmNi40Y3FlYMIggOZj3T9cqz87h+PiaU4kgMzRmy8FBAoWS3FX9ENSFMrRhGyLM4axIoHIUnpIw9Mxha3agM43k40Ucf9DNpvUVl8dPXe0YEu/h7KtL0DNnbb1wSQLzC4vWL0kEHyfpoFHQmpGTVpc5hdqCIbFF13Ves9eJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34SxYGm7jlT/9WQBG3ewSQhVSIDI6x0rXMjoOQTHbbw=;
 b=DNpn4Vjr8OUOnoWnYV7qoQjw3H6QuOxe3Qa1nUI7gxOM9DOFknjriqnuQRsck9ilHBYIh7D+IsCP+tmTmtTuMVwzF6ZfzCVqGIuyqVIfwkp/kIqqbM3xRBM24mfddauOrsik5SS5zs/1t/TJ5pw86+TNhA94zV1onijO7aT2ZuBt16/HVqTj/aPZdeh8DqbSugiKydzg4vcQn4z16UMsalhYiPRCgPfm8KpmLDAd7OSqQcYlfgLO3LP/bEkxw+ge2sWwwCKDENwwiLw4yQ63ab4yQ9jhw1fsO5Hr0NVEw7Ltplb3qMv1MIkGzLEpneZ/2vQLlmJtjRqDJp+J8Z2fqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 15:24:25 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:24:23 +0000
Message-ID: <73ead084-2761-4106-8149-36301d0b0ea0@intel.com>
Date: Thu, 16 Oct 2025 17:24:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251015233801.2977044-1-edumazet@google.com>
 <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
 <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
 <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com>
 <CANn89i+mnGg9WRCJG82fTRMtit+HWC0e7FrVmmC-JqNQEuDArw@mail.gmail.com>
 <CANn89iKBYdc6r5fYi-tCqgjD99T=YXcrUiuuPQA9K1nXbtGnBA@mail.gmail.com>
 <CANn89iJo-b=B7jUtbazcCtgKJrnbgdEXJ-OPvOwFziP_OSLaYA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iJo-b=B7jUtbazcCtgKJrnbgdEXJ-OPvOwFziP_OSLaYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 872976ce-93d4-45cf-1647-08de0cc815d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlNVTWRwZUpobjhPaFFWdGlVUno1ZmhaN3hSenJ0RWZDc0M5UVNjeWRSMWtS?=
 =?utf-8?B?UUM0bGM2bHIvNlhnK1BPNENpdWttRVpGeUNtMmZmV05DMFllUGRMWEk4a0dJ?=
 =?utf-8?B?ZXppWExSb0hQbG1aL1pLTTI1dkxVbXA5elJZclBtMXJwdzE0VGxsL2M2dkMz?=
 =?utf-8?B?UG1HMy9uR3VFT3lKVGozMGJueVgyaldIZmRabVloeUVpbWZieTZwQk1ZOFor?=
 =?utf-8?B?TDAvQllNTnlZV2ZCNW9COVc0a09ON3ZYMUhrdWEzWUUxWmo1Sm1Ba0E0T2Jz?=
 =?utf-8?B?bzJuM3N5RkdSdWw4SWVnK3FFd2pIVTVwaE8xcEl0aWNRTmZtNHd0cVlyUGlR?=
 =?utf-8?B?ZmR2UDhMeUhWSGJJR2JwTWU2TjZYaWpXa1Byd3F4YU1jZVRsdCt5bnhLWXJr?=
 =?utf-8?B?UnhPOXVMOWl5RDV4Yko1TFBPblNmWXFYYXAxWHQwMlY5cDRIeGZrVWd1NGtq?=
 =?utf-8?B?clc4ckdVWjBrRTNqSUF5SkYzWllTVE1kQmNHeWxZa2dDWmpOTVdaV09rUDR5?=
 =?utf-8?B?b2lpeGMvdThtbXNtZE1mYjdYblBQM3ZLVG4ycW5aKzQzL0dwNlA0d09panlR?=
 =?utf-8?B?YndnV09lRTd6aVFPZG9ET09TaXJFTEpYRFBScEU5ajNLcml5LzZEbnptWndi?=
 =?utf-8?B?QWlqU3c5bnFOUjJYL0U4c3Jmdk80ZHpYOWQxR2Y0am9KZnJSV054YVVRcTJa?=
 =?utf-8?B?SVZ4cER1TEVQNjhzb1NQaEJPUXpQQ2gzeFBmeHA2dms4RDQybGxnQklha09S?=
 =?utf-8?B?Sm5MbGE0TCs0UUxESkJIdWpyNGNxTTZnR1FmTG9nN3k5WUtlMFFCNGNxVEdT?=
 =?utf-8?B?RTF2QmlMRWNUT3dPM3lLblNnbXNCQ01Jejl0VzEwQUNVOWR3ZTBSeml6Ti9B?=
 =?utf-8?B?UENmdWRFOTBzeE40a0MxTmhBOUFVU0NyQUY5SGQvSVVtMHYrbDZpNzNxUlRl?=
 =?utf-8?B?TW1GSGs2UHFhdmNPOHprd3JZUjF4NytuNEpOK1gvS1NNb1JVai93M05XS3Ar?=
 =?utf-8?B?V0lneTNXNjR0OFVJNXlXcHRnK2I0Q2NGR2QwQmw1NENjMDZrOFpna3NOWHk2?=
 =?utf-8?B?TXdvZEUzM1Z2bVBHZE9XcHYvTEJVb1FWSGM2dTA0VE9OVERXTGpSRkhEbmFX?=
 =?utf-8?B?R0U1VEhaNHdrR3NzZkZWeWNNSVh2aVJpUFRKQXpSR2NTS2NoQjA2UzBEWnZK?=
 =?utf-8?B?YTVhdFc0dUZwQ1N5eGEybXBHalZEQ2tpdFFLOURjNUNkN3dMRnFOaVNzQVJr?=
 =?utf-8?B?UXRuVWRsTXliRGt1a0JSalRncm92VVdITUQwV1lhTjZHb1ZVOTVBQm8xK0Zy?=
 =?utf-8?B?QllDTHM1TzFFUHBVWXR3bER4RlZxNmFPK2I1cjd1ZnJ0UURJMC90bkJGKzAz?=
 =?utf-8?B?dmtGc1BaeUpmMmZmMUs5T1BHTE14S05aaE1TK04yNUtneGFJVytDeWxJamR2?=
 =?utf-8?B?aVh2cEZqaFh1WjB1NWFkM1BoQ3V2VHJYUXFqOGZDYm5Td0VnOE1kN09MemNL?=
 =?utf-8?B?NndrWkpNbTR0SmQyUHFtcU12aWhCQjdVbkVVU3YycEpaNWp3Skc0ZU90eGJK?=
 =?utf-8?B?NG9veVluck9BLzRsSXhNTTlxcnp5VjJjV0FVRUZCa1pXaVVPZnFKWHA3VDM5?=
 =?utf-8?B?dWdXei94M25JYTRNVUhJcGdyMUs3NlozTXVaajZNU1Z6QW4rMHowdUNET3Ni?=
 =?utf-8?B?ZDVnL25MeEl4U21MNnRkbXNkM0lrNlhuYUNkM1kvd1UxS3pYNWhBSkVnTG81?=
 =?utf-8?B?K0dDWjcvbkxXTTNTNGxQWWV1NnFXSDhsOEtoaGcydEdUVXNodTJaOFlOTmJC?=
 =?utf-8?B?YjhTWnNzL2R4bGFNNWRZK3JYRW5XSzd2dVgyMXAwZnlSak5kQitFQVI0YUJR?=
 =?utf-8?B?cUlLRU9wSXJPOHY2NzRZODI0VlVQVitaT0Y4MjB0SEU3bUVETEV5SXVVZ0lZ?=
 =?utf-8?Q?c6YmvusjtM3osU75840o6dRC0PqxUho+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDd5c0NBY2tKQWtNeHhCcWQ3ajBscHM5dERpemxyOERCa2dZYUk4RFl0cU44?=
 =?utf-8?B?elJMdlFLaFlsU3lIRFFuczNGVjBRNXZsNXdGMGdYRXdDM2ZiVXZ0NHJiVkNr?=
 =?utf-8?B?a2V3RlhXRmVXTWQwcVdadFI4QUF0b25zRVZsNTA4TUZUTnJkY01TdjZTZStN?=
 =?utf-8?B?NjBha0lZSVZRL051YWdES0dJNmRlT21PWVJrbEpmbGVIQ3lXQjRjVlUxK2pR?=
 =?utf-8?B?bXBvcG5PZlhMNm9EWE05NzdkT29nUzNvRHNVSWw0dEhRZC93K3NZVWRqZEpk?=
 =?utf-8?B?ZkFkQ1ZTVDRDUm9Rd0twd0JqUWlTc1NhN1o5WjBQMjl2UDFkMlVIMno2ODJw?=
 =?utf-8?B?QlY2WmNkbm1SdHkrSzVMTUQzUFk0U1laWlIwclVkNVZrczc0a0RrQmNQZlM4?=
 =?utf-8?B?cTJuQTVUcEhRejNLd1hnQUFyYlVReWxwb25jL1VnVG4rOFBjWEhiZ2RQYVdw?=
 =?utf-8?B?RUFFV0grQjhETDdXZWtKcVdWM25maUZDTnBkdk1HN1RtSEhwMU0vWmpsc0wr?=
 =?utf-8?B?amhEMUljR3c4VnFLeGZNQ2tIUlNRajhvRXh0MUV2Vjkza1UrTGtEcjFKeGRs?=
 =?utf-8?B?ZCtLTW9TSEZTekU4MG9QUXBXU29iT2tvdjdVSzBVMHVUUjRJclpXNE1CZEtY?=
 =?utf-8?B?VHBLOUtPQi9ldUxNRlREbi9XTEpOaUJpZ21pQ0NXZG9WUng5S005eUt0bGIx?=
 =?utf-8?B?MGU3T1dPaHJzNURlaFE0UVZ2dnBmUlBLdWZQOGh5SXNKbWZmaU1RZUFzeUNm?=
 =?utf-8?B?d1ZZTk9QdUFpbE9rcDhnb3ptVi9Wc3JtM25zM2ZmbHQwVEdCUWl4Qmx4YkY3?=
 =?utf-8?B?Y1lwQk56TGNFVlUvYXBaV1RQeU1LcmJiSGs2a1U2Z3lYMTZRRkJDMEZhMGZJ?=
 =?utf-8?B?K21CUGFGVzFlam1xSjZ5VWJpdzllK3FadkMxblZkUGVMMnpTQ0ZueHpKTDdT?=
 =?utf-8?B?QmxPM0VqK0VWTXZneTlaOFJMTklra2g5N2NIVFlaL1M2M0FCUFNRUDhETG9S?=
 =?utf-8?B?V3E0RW1tbVlIdmxCTURhaHZUMjRWaTNpKzRrSXdOM0dsb05vMnRCREpVTHBx?=
 =?utf-8?B?eUZEc2NEQWdSVHVuaGR3OE1xQzZyZC9vMXByZlI3dWlzNHNHMDhWSU4xNlFG?=
 =?utf-8?B?R3h0dWh6b2h1L1JYSCtacDBhbW03TVpYdWkwMEdwbDNaZGM5My9FeUMwMlJw?=
 =?utf-8?B?WGNFSXhaZGpjWGpmcFo5UldUNEJ2cHpFU0hOS1B1VW5BanA0Y1JVcDJiRlJv?=
 =?utf-8?B?VUZXL3VqOUZib0NWUEF1M3F5anB2b1RJelpIQTZBNnFYN0tIbWh0TldRVTg1?=
 =?utf-8?B?YkYzN29Xc0tsbkNmK2RoUmJ5TTRJQTg2SWRrRk91bGFVL2pNYkVTZTRQelY3?=
 =?utf-8?B?ZFdYMnpXcks5cXRKUGdWL00rS1RsMmNQQ3NCajdjMnlyZ0ZVNWRNUWVFRFl1?=
 =?utf-8?B?TDVlV2FZdkc2RGZucmNHQXpIVDFubkVsc2ZQOWdUa2tlcEJJUzV2YTUrOGEv?=
 =?utf-8?B?T3I4REllMi82dHFCVFBJU2dDekpWZHFlWmtob0NqZk1RSUhtd2M5c1U2b2M4?=
 =?utf-8?B?T0M4MC9uTFF4d0hzV0QzYVhuMy94ME5teUdDK3hTTDF4S09PVUlXaW9kRkR2?=
 =?utf-8?B?eGJaazA3d2RjeFVVRjVObm1Hc0FtamVoRXVOb0FRcmwvZ0k4MS9kbmxkT1R5?=
 =?utf-8?B?YVRuRlI4SlpXL2lzcnIrZDE5cHExVE5tZkNiOEs0aXM2bzRuNldXWWYwOTZB?=
 =?utf-8?B?KzVpcStZUGR2Sk9qRlFRZFpIK1lMbWlWVjdkZkJLSGZQYm9KSk84dEFiZElX?=
 =?utf-8?B?b2tBTlZyeSswdFpuelpUalFKTDhadmF5bDJNMkNqdy9pVy9FZ214eU5Ccklw?=
 =?utf-8?B?c01vRFYyQURhRDFMZWttc2pTcUJDYnJDMGd3WXBURHd4R0lNSXpzRmlBUGIx?=
 =?utf-8?B?QnVwV1pzODl2dVBrNVloa1R5ajVaSUFoT2tzT0owNVlyeFBUR2lhbnVwVVpz?=
 =?utf-8?B?WkJ1MmlHaTI0ZkUwY0wrZ0dUVnM3dk1kbHd6ZWw5K3JmcCtjbmtmaUxZQkMv?=
 =?utf-8?B?Ri9EZGdxVUo3QU5WR1JTWTZSUGEwY1g1QS9VS1VESEYvSWI4SGp4UE9mZlVo?=
 =?utf-8?B?eWNQWFVjRlVSZXFIUCtZT0dvNlEvbDRIVGVqZzJkbDEzNHdSZk92WGhoZ1kr?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 872976ce-93d4-45cf-1647-08de0cc815d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:24:23.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LyhI0Keji/00w9ACp8aoWEZ1zWOdO49gaxqNNQ0bvK7JN5Uy4jLg0X3Z+NG2ZRIuML3P8jGAxCYhCGWrblNRseSLN3QgffyUIDHSl/wKhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 06:36:55 -0700

> On Thu, Oct 16, 2025 at 6:29 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, Oct 16, 2025 at 5:56 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Thu, Oct 16, 2025 at 4:08 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> From: Eric Dumazet <edumazet@google.com>
>>>>
>>>> BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same way?
>>>
>>> Probably, like other calls to napi_skb_cache_put(()
>>>
>>> No loop there, so I guess there is no big deal.
>>>
>>> I was looking at napi_skb_cache_put() because there is a lack of NUMA awareness,
>>> and was curious to experiment with some strategies there.
>>
>> If we cache kmem_cache_size() in net_hotdata, the compiler is able to
>> eliminate dead code
>> for CONFIG_KASAN=n
>>
>> Maybe this looks better ?
> 
> No need to put this in net_hotdata, I was distracted by a 4byte hole
> there, we can keep this hole for something  hot later.

Yeah this looks good! It's not "hot" anyway, so let it lay freestanding.

> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..f3b9356bebc06548a055355c5d1eb04c480f813f
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -274,6 +274,8 @@ void *__netdev_alloc_frag_align(unsigned int
> fragsz, unsigned int align_mask)
>  }
>  EXPORT_SYMBOL(__netdev_alloc_frag_align);
> 
> +u32 skbuff_cache_size __read_mostly;

...but probably `static`?

> +
>  static struct sk_buff *napi_skb_cache_get(void)
>  {
>         struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
> @@ -293,7 +295,7 @@ static struct sk_buff *napi_skb_cache_get(void)
> 
>         skb = nc->skb_cache[--nc->skb_count];
>         local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
> -       kasan_mempool_unpoison_object(skb,
> kmem_cache_size(net_hotdata.skbuff_cache));
> +       kasan_mempool_unpoison_object(skb, skbuff_cache_size);
> 
>         return skb;
>  }
> @@ -1428,7 +1430,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
>         if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
>                 for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
>                         kasan_mempool_unpoison_object(nc->skb_cache[i],
> -
> kmem_cache_size(net_hotdata.skbuff_cache));
> +                                               skbuff_cache_size);
> 
>                 kmem_cache_free_bulk(net_hotdata.skbuff_cache,
> NAPI_SKB_CACHE_HALF,
>                                      nc->skb_cache + NAPI_SKB_CACHE_HALF);
> @@ -5116,6 +5118,8 @@ void __init skb_init(void)
>                                               offsetof(struct sk_buff, cb),
>                                               sizeof_field(struct sk_buff, cb),
>                                               NULL);
> +       skbuff_cache_size = kmem_cache_size(net_hotdata.skbuff_cache);
> +
>         net_hotdata.skbuff_fclone_cache =
> kmem_cache_create("skbuff_fclone_cache",
>                                                 sizeof(struct sk_buff_fclones),
>                                                 0,

Thanks,
Olek

