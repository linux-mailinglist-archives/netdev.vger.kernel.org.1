Return-Path: <netdev+bounces-258287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MISBMyWKjGmHqgAAu9opvQ
	(envelope-from <netdev+bounces-258287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E4124FA0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C869300405A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC83148CF;
	Wed, 11 Feb 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7cMkBCq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76300260565;
	Wed, 11 Feb 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818078; cv=fail; b=f+L2v+gpzuwSycF8tqsZ8ra3gU6gikJqIApBwwZAWDcYewwf9jWGFvCF7MHuPqrRNgFoOSEoLBX4zOVRp5emQcz6QXSIWKxPPhtYc0DfZlpQMW+LtwdbJv6p30nIc1r8WojJoyirnl9S30dsb9f5zEr5y+jJUnuwUN3K7Ncxod0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818078; c=relaxed/simple;
	bh=BIThnqDHalgaVdl2qKjENFhuFCHeQ6LnrxUMvnTAdAI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehj/e0LzVCZQ1skcnuD7Jh/GVB6paK2uODgI7MPesNqb6YOnKqL0RXgPj00oh3LahSgSVrKq3LCKMt+kJyA966nFuuM0C7MrYjE2t6GINuLCMtWWnKal1Zg2mQ87re23pZQhMCanCsodjZAazFUngXd/Q+H1+A3ffwBaLJG2SQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7cMkBCq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770818077; x=1802354077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BIThnqDHalgaVdl2qKjENFhuFCHeQ6LnrxUMvnTAdAI=;
  b=h7cMkBCqKF63lTAg1OMwen0PUbXiznl7OzQKQYXfiPvT0AUCaMlHDHVH
   Lzb6XkeUXsCGKBozkyhjv3pVQnUiAjl/rWgkdu/nOHFZPWaGiKKRWmjHA
   3poCKwEU1wlLqImMm1lX5zj7wP5UQjtOc54bl0jEjV+AAW1H/5atRy6zC
   EurVrj0txqyPO48CeioA4epkPD2yVsb5KiWl7snHYm2pInrCf8gRBOGME
   Eu5QOr2IeoH/VCYEmZMr65AdlWOBO5eCmIO/R19TjxJwpf1SZ28ZqEM02
   4UFMq0CFgdg9gho5xD3AII5OM+289H5LCfEF4FMclU+nAXtnevol1GCzu
   g==;
X-CSE-ConnectionGUID: UavOPHL4SYCJ/2r8a0TPkQ==
X-CSE-MsgGUID: TgDNI2FjQTe7XA8xWsv9pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89554564"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89554564"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:54:36 -0800
X-CSE-ConnectionGUID: ItT3RHe4QKOKrdOVHH1/gw==
X-CSE-MsgGUID: lEl0ZvyYQl6I83vHTyBYXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211565160"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:54:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 05:54:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 05:54:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 05:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0hBfgv8m6FH9ER8I5fCu1F+/3mxg9By86LNBusyafmVOQUDoLTArvSAh2+RssJM8Qh97sbsLs65l5VfKiltvc2z7ViObeO7Q9UTltGGwHpoitkk5yi3WC61Vdjxw3qLUeMey5kcWWblaeetUjqTRNRIkf7rOT5KGVzD6XT3EVShjO+ER9790hHZNXwu6UrNd2VzkzzNHjruEDURk+KpkGs371uW8M4cIwp72DoAcubk8EViNsqSpk14Ct2JRCCBt6WstJwGEUGbiRUZ8YA6+VdynZUNdQkR8g2EvSy7LPgXz6f62bW7Z6dJ3ut/VvaJj8JHKRv7gtyQEAlkiBFkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFEA3soUSOBCr7JX048sFT73ISt9RGA/NsvvMygp2vs=;
 b=VFzYQAdirYOHeXibwUaYxu7+TA5yBOl3fGJeRjwin2kC53zKktIIXhn/Nq5myVfPNmMbA0lMpri2DNvG0ga3Wm+mrCEqAaTzV7DWTI+DoUGl710WpCSZdiWuVINlMzhxB2yPQGgdBEXkF0e4XHzH7dTGCbqTMDnl2GCfoOB4au/TdeE4LKggaEZjYxUmLSG9WWSbJERc3zIK3osL9NwXUSxLn6w+WtPMzUPJ3gTbrO3qnVDIVAYZEZ0UBkMzRWfGCdrT0fmQZWnCw825LZqA+nbWOh4knEiMMdUYPaL4XZZqcwhBt3kBorgOghm2eJRJlfBmqsWo11nWChqSsBAM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:54:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 13:54:31 +0000
Message-ID: <2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
Date: Wed, 11 Feb 2026 14:51:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<andrew+netdev@lunn.ch>, <ast@kernel.org>, <sx.rinitha@intel.com>,
	<horms@kernel.org>, <yury.norov@gmail.com>, <john.fastabend@gmail.com>,
	<kohei@enjuk.jp>, <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
	<alexander.nowlin@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<edumazet@google.com>, <aleksandr.loktionov@intel.com>,
	<marcin.szycik@linux.intel.com>, <hawk@kernel.org>,
	<jacob.e.keller@intel.com>, <magnus.karlsson@intel.com>,
	<pmenzel@molgen.mpg.de>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <andriy.shevchenko@linux.intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
 <20260211042458.555701-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260211042458.555701-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0221.eurprd07.prod.outlook.com
 (2603:10a6:802:58::24) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dc18b1-d537-4717-178b-08de69751484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGxCeDBOa21LQ0xEU2lpSlAwMC9SNkovQ0JYTUxtWE0vSTBvMW9DSHBnQzM2?=
 =?utf-8?B?bGVxMldCUUsxREEwclR6eks4YjBxR3Bhd09WemQ1OUFxcVBEZEl2Q1F4Ulpu?=
 =?utf-8?B?WDMzTlBZV3k3MGxHUk5NMDE3aHN0YmFHbVFKV1Q0cnNqd2dOUHlKVXU3OTl1?=
 =?utf-8?B?U09Ta0pobFpESTE5UHJlL01ud1dSamhBZklNV0hzVnBMMWpKZkNwUjRBWVpo?=
 =?utf-8?B?USt4Q1pHLzFOTHJtcVpGcDRuZ2FtcGFnaHg0UVNzTGdEREVITGUzaVl1ay9J?=
 =?utf-8?B?VlRCdzVtQThwUVFnL2ZkaDNMZTJ5Y21zVWc3eUVBQW1XRzZteUNuYzVRdzF4?=
 =?utf-8?B?KzlSdHpHVWZJUENXMlUrb2RaTTd0MGtTTE9LK1dpOHY4VnY5eHpkUitmU1dF?=
 =?utf-8?B?dUtBMFV6TC9MM1JaMkdjMG04ZU93SEZPZXNuaG1VYTNjaVhyKzltbm5GMm9s?=
 =?utf-8?B?aFNiQ3JCeFJPYWRBUTgwMFV5a3RWSFV6ZkRndWZiRDlYNzdxa2xxTDg5ck1w?=
 =?utf-8?B?SE5VODhDbGd6S0RsRFVYS3J0ZlJiOWptQjJKZ1V3OVJJNzJiVzNtWmFBWEc5?=
 =?utf-8?B?eEZkdzdwYXJxclpwU3ZaSk1HQmthYWh2QnE0VzluR0J0YytXMmVLQlZtVFZQ?=
 =?utf-8?B?WS95MXBUUk16NTY4MWljNFc4N0YrYjBiS2FvS052UmJrNWxqVWdjRWQvSFYx?=
 =?utf-8?B?ZjlFZmRoSlV5c1lBM2VmcFBta3BFNHdKNDRXN2U5eVlCMFArZXhKUlV4Uzkw?=
 =?utf-8?B?YjVUb295WDFYWW5BVFc0aVVYcXlrUlN6SUdpK2hOaGs4aEVKaWplSXVENXcz?=
 =?utf-8?B?V3pqaEFPWW5FL2RadVJqZFhRZ25xcm16YkthVWVNbmRsWkVwM0Zvc3M3eEhl?=
 =?utf-8?B?bTFBSzBEQXh6SjFFeG9XbFExUys0TU5PbkNjWlBBLzR5Vkd2YUhrMkhONndm?=
 =?utf-8?B?ZjdDMVVMckJ2QU4xdWp2VXBRSnVOWHpEQW13ZU1PMHpZTkxGY3preGU3bVEx?=
 =?utf-8?B?Y3lYUWUwRERzSkFvbldsK2thNWZmZ1Q2amNrSG5DRmE5Rit0YVNKSDhQMjhj?=
 =?utf-8?B?YWg2dm5JMDQwWHVyVVBHbmlLaWU4L1JCUkRwNEpxZGtHUkdRbnozd1gyWWVp?=
 =?utf-8?B?TjJZY1piMU9mSHV6QkVpVU94bEhEcDN1ZGpZQ3dLSzR0eUJCSmRSdmdtQ2l3?=
 =?utf-8?B?bnF3bWZndWgrdUsrMnN4TVUwMzB4ZUQycTY4QVVSSTJ0YkRPZkMvUTVMODlx?=
 =?utf-8?B?cjVBM1V1MHFrc0NzdWNWWFBHVENVOVpWL0JMbENqRldIcHdSUlJNOXZhaDEr?=
 =?utf-8?B?TndmUEZ1Z0tHRG0xSGM3dG14QzZla2JrM3BucERmQjNmK0kzaGdSSWFCOTQ2?=
 =?utf-8?B?QVpRNDdUeVRHV3REMlQrN3ZkL1ZJK3RjWDJWeFJEdWdTc0kreEtwaVNNUDVM?=
 =?utf-8?B?UUJDRm1Scm5UYXhWTy9iMHQrQm02K2w0Z3ZQdzFBbWJEVTZCQWVHTkNENzZZ?=
 =?utf-8?B?aUJrYUs3QitQWG9rZjlmMEtBRzdIVmJsOE5zMGd4RUs1YWlybUxKODk3OU9F?=
 =?utf-8?B?NlA1aUlDc1NQNHJxcTVGUXpCaDhENDFEUDFVNVFwT0VZdVVlTjFOcWdDYUh1?=
 =?utf-8?B?dUFYL0V4ZnAvTmxIZHllUGVDRkdwdXBqUXg2Z1hGcmowdWJ3RzA2cGYrcHFz?=
 =?utf-8?B?eEtCelQzeHdJb0JIb3dIRnJYMktFUjVJeXVTZmhod0VQdTN0VHBwWGNmaDln?=
 =?utf-8?B?bXJYMUx4RlFOWW0wZTBoemxPYm9nOFpQMW9jeExERnZKZmN4WnkzdU5CbjR6?=
 =?utf-8?B?YUFNakZHTnN1M0docVZ6T2NSb0J4QnluQjNFOFFSdlRVamIwSWhZSWxBclBj?=
 =?utf-8?B?dVNqVVNyakg4YXp6WGlDcGFmZjEzVlp2MW1kdHh2b1NnMC9ib2ZNeDkyMjE3?=
 =?utf-8?B?Y0xzSVF1TG94MVNUOUovUCt1ajhXeHZzMHljUnh5dUVqaXZpZzZKZ3RzRFdS?=
 =?utf-8?B?VEczdWJ0a0xsK09oTld3UEdpK3N1Z0JzNVBESXI2SXlTUjNiekI1WDh0dkRQ?=
 =?utf-8?B?YnliTlZIQTlGU1UrOUlRTHhDdEtkaStFNUx0TGFCWmpTZTFlcXQrY25qM01t?=
 =?utf-8?Q?2KOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHNTaW0rZnRRdUhuclNHQ1pna3E3NTlqMXREVUlYbGE5dFJyQ3RqQ2tVWHlU?=
 =?utf-8?B?emkwL2Z0ZmYrTDAzTVhBVnc2c0NJNzIwZHFpYlpoc3VUdjZsdlM2R1JHNXdR?=
 =?utf-8?B?MFpCUm1iRFQva0VFSFIxZTZqbmcwZEtjeGRmSlc3QTIxb0RMR1E0L3B3ZEw0?=
 =?utf-8?B?eTQzQmJ5NFE2Ync5bGZZQmJIS2tiT3FPV04yUzlxYnJRWERIcWJZVmtmWVkr?=
 =?utf-8?B?Z0I4ZTBvbXYraktCNXhuUm5KY0dLc2UzVHhOcGprMXRUdDMvbUVGcjhnZUxZ?=
 =?utf-8?B?TDB5ZnA4RmdCT1l1ZnAyVGpvK1FQTlh6MnY2TEVpUUFweUZ3TklWelJSalFI?=
 =?utf-8?B?QWZtZW11WFUxWS9yZXJ2R01VWmZlQjBpTU1hMm1tQTlmWTVzM0VoQ29tQ21h?=
 =?utf-8?B?Kzkxck1NalQ4ZVZRYU1GRnZqVFFiK1VZQk9NeURweEJqc2FsTExsMUgxb2NW?=
 =?utf-8?B?UE1uWmxJMU1YbHlVWHhQSDBRQk9lckhFanl0aXRuTzFrc1ppaVU5aXQ2U0p3?=
 =?utf-8?B?WGtVUC9RMTF2MHJreXpmYkhVbmI1Q3cyWFZBSWlLaXpqd24zVVdPUjU2VHpQ?=
 =?utf-8?B?ekZ4NEpQdTFMeGdwVGRFMGJ1ZUZXVXY5RXhxL1BLRThWY0E2bTV5Q0V2bG9J?=
 =?utf-8?B?c0tLSlFPci95aXNZYlNaVW4vZWdkOWtvOFJEcElZOVlXdENaSGM3OCtxSnox?=
 =?utf-8?B?VWZRUXBhVEZaTEUzNjNlVGp4aWRFMUZwdXlGclNCSEw0QnBidlVQQ2xGUEps?=
 =?utf-8?B?cnJxMzlLb0gwSlMyNzZxOXhqaDh5ai8zWjhXd2Vsc1BhZjhDbkJFMzJiQmtt?=
 =?utf-8?B?K21tVHIyU0RSdGRCck1SM29lNGJLditMU1hOZE1IVWxQcjNqZ0dsRjJPdmM3?=
 =?utf-8?B?SkE2L0h3OCtNa1oxMGJsQ2V2U3VyODZOTUI3Y1dQUjhJcUpod2N2ZUZHR1la?=
 =?utf-8?B?eEtrUWtvMXFQRjdnd241NjN2c3RIbEhMSUdObWdPVERlK3lCbVoxRUovVU0w?=
 =?utf-8?B?aUhSUytQLzRESm44T0sycjEvNytQaVhqVTNzK0x0UHlWTVFFTHpadWtCY1Ju?=
 =?utf-8?B?TnRDcTZyWGk1K0xqcmwrb1lCRlAyck56OWFEZDY1cVh2d3VnZDgxK25seTdk?=
 =?utf-8?B?QXFkWnVzWVdqSkZMVnNybnMvb1FZU01vMFRQemZXK2xwaUNHZXFPU3NOSlI4?=
 =?utf-8?B?OEpkNWJ4WTJVTkJsTUhuYUlNdGJTd04zTXp6WDFGZjAzSVlDVjVjL0ZHdFA2?=
 =?utf-8?B?MFBxQ3FrY3RDSUxSWDQ2dmpYc3hScEJuYVJTeEsyQ0JIc3RWZlMrWkhvVEJj?=
 =?utf-8?B?dzVka2ptVE1vQk5jWUJPYmZKVzJ0MnArcUpHQWNSSTVHT3hGQWFPbUM1NkFR?=
 =?utf-8?B?b0NMT1N2dERpaWpJcU1GMjVXWWZiSVVldkkvWFVLaVdEMXVDUENpZVlESE5W?=
 =?utf-8?B?WjFmUnYxeGdLZmR3OTBWSnJtSmMyQ1lGOXhWSTBUU2lyM1lKM3BGZ1Uxb25V?=
 =?utf-8?B?aHFsa0o0akg2b2x4QkQ2UElsbFJmRytkT0lEQno0WEJoRHNlOFhpSEsvUkVa?=
 =?utf-8?B?WlFBQSs5Sm1uYU81bUM4Wjd1TGNzUkFQaitLbDJLQktWRHdEWnBPK0Y1TG9z?=
 =?utf-8?B?aE9yZDZuc3JvOUs4cnNXSS9DTitnZUIzNnFoeEVlWXNLWlFXOVd6S2JsNGJZ?=
 =?utf-8?B?RS8vNFZuRUtYUTV1MzJpeGV5TDZPVktLVDFkbUsyTkVkQmJLRzhRenBXZGw1?=
 =?utf-8?B?UGUxdHVMWlZzODFUODgzTldIOVl3NFN3bkcxRVBsSk4wS1h1RWFmY3ZWM2FF?=
 =?utf-8?B?aE5uOWE4dUVZV3hOaEl0TnhsWlkzUzYwaHpxMVF0bWdCeVNDOXJQM1ZIcTFx?=
 =?utf-8?B?QnhnUWVHUXpLaTg3ZXVhbnhFYTd2UVY2cytoQzJ3NVZURDZsSXFBQ1RjNHl1?=
 =?utf-8?B?U3dScW00S2NLYWQ0MGtWek95ZlpLeTJoL292aGk1SDUxVCs2R3pMa2hyY1BZ?=
 =?utf-8?B?TVZ3QldUZmo3QTFLOG56d0RZV09JanRxbGpGbk90T3lOVm9ieGhaejVhTDE2?=
 =?utf-8?B?QWFtcHV4WlB3ZkdwSTZvZVV3OWk5SjJiUVRCTmtiNTRScktnTWxjSTZkdUND?=
 =?utf-8?B?WDQrQk42WGFFOG5SeVZKYlFzZzlpUHlnTEZ3RmYzcEUrQjFaUE5Ob1Zqdzdj?=
 =?utf-8?B?aFVaQXhreitMaWYydCtuT0dEcDAvSzV0WmhpeWdwVXIrYk1neVRmSkdMcS9i?=
 =?utf-8?B?ZGoyWE10UEdNV21qQTZWUU5TN3NPVlRSNndkNHhrU21YWmtVSExpR2NJS0ZJ?=
 =?utf-8?B?L2Z5V0FrV2ZLSXpOb3RiY2tWQkFZRzBhRnZ1akt2MnBzSHVZOG82c1lzejdw?=
 =?utf-8?Q?6XBPAyYVRXtv0ru4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc18b1-d537-4717-178b-08de69751484
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:54:31.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLjetJEDs8J7fwsQNhlpDHqfQNsVf4CATH25SwijWqCM1uyc2/RzZGtZ+6MGTgrgZWybqfmpbNRxi0HBToR2xVf6uiZTy9OiXHPcbQYRbXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258287-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,lunn.ch,kernel.org,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DF5E4124FA0
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 10 Feb 2026 20:24:58 -0800

Hi,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ice: migrate to netdev ops lock
> 
> This commit migrates the ice driver to use the netdev ops lock by
> requesting ops locking and using _locked counterparts of NAPI
> configuration functions to avoid deadlocks during suspend/resume, queue
> rebuild and resets.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> 
> [ ... ]
> 
>> @@ -2308,10 +2308,14 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
>> }
>>
>> /**
>> - * ice_vsi_cfg_def - configure default VSI based on the type
>> + * ice_vsi_cfg_def_locked - configure default VSI based on the type
>>  * @vsi: pointer to VSI
>> + *
>> + * Should be called only with the netdev lock taken.
>> + *
>> + * Return: 0 on success, -errno on failure.
>>  */
>> -static int ice_vsi_cfg_def(struct ice_vsi *vsi)
>> +static int ice_vsi_cfg_def_locked(struct ice_vsi *vsi)
> 
> [ ... ]
> 
>> +unroll_vector_base:
>> +	/* reclaim SW interrupts back to the common pool */
>> +unroll_alloc_q_vector:
>> +	ice_vsi_free_q_vectors(vsi);
> 
> Should this be ice_vsi_free_q_vectors_locked(vsi)?
> 
> ice_vsi_cfg_def_locked() is called with the netdev lock held (either by
> ice_vsi_cfg_def() wrapper or directly from callers like
> ice_vsi_rebuild_locked()). The error path here calls ice_vsi_free_q_vectors()
> which tries to acquire the netdev lock:
> 
> ice_vsi_cfg_def_locked() [netdev lock held]
>   -> ice_vsi_free_q_vectors()
>      -> netdev_lock(dev)  /* deadlock - already held */
> 
> This would deadlock when an error triggers unroll_vector_base or
> unroll_alloc_q_vector paths (e.g., memory allocation failure in
> ice_vsi_alloc_rings() or ice_vsi_alloc_ring_stats()).
> 
> [ ... ]
> 
>> @@ -2703,7 +2748,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
>> {
>> 	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
>> 		ice_down(vsi);
>>
>> -	ice_vsi_clear_napi_queues(vsi);
>> +	ice_vsi_clear_napi_queues_locked(vsi);
> 
> ice_vsi_clear_napi_queues_locked() expects the netdev lock to be held.
> Are all callers of ice_vsi_close() holding the netdev lock?
> 
> Looking at ice_sf_dev_remove():
> 
> ice_sf_dev_remove()
>   -> ice_vsi_close(vsi)  /* no netdev_lock held */
>   -> ice_sf_decfg_netdev()  /* unregisters netdev later */
> 
> And ice_dis_vsi() when !netif_running(vsi->netdev):
> 
> ice_dis_vsi(vsi, false)
>   -> ice_vsi_close(vsi)  /* rtnl_lock only taken when netif_running */
> 
> Both paths call ice_vsi_close() without holding the netdev lock while
> the netdev is still registered, which could trigger
> netdev_assert_locked_or_invisible warnings.
> 
> [ ... ]
> 
>> @@ -3069,16 +3152,17 @@
>> }
>>
>> /**
>> - * ice_vsi_rebuild - Rebuild VSI after reset
>> + * ice_vsi_rebuild_locked - Rebuild VSI after reset
>>  * @vsi: VSI to be rebuild
>>  * @vsi_flags: flags used for VSI rebuild flow
>>  *
>>  * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
>>  * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
>> + * Should be called only under the netdev lock.
>>  *
>>  * Returns 0 on success and negative value on failure
>>  */
>> -int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
>> +int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags)
> 
> [ ... ]
> 
>> +free_coalesce:
>> +	kfree(coalesce);
>> +decfg:
>> +	if (ret)
>> +		ice_vsi_decfg(vsi);
> 
> Should this be ice_vsi_decfg_locked(vsi)?
> 
> ice_vsi_rebuild_locked() is called with the netdev lock already held
> (either by the ice_vsi_rebuild() wrapper or by callers like
> ice_vsi_recfg_qs()). The error path at label 'decfg:' calls ice_vsi_decfg()
> which tries to acquire the lock again:
> 
> ice_vsi_rebuild_locked() [netdev lock held]
>   -> ice_vsi_decfg()
>      -> netdev_lock(dev)  /* deadlock - already held */
> 
> This would deadlock when an error occurs after ice_vsi_cfg_def_locked()
> succeeds but a later operation fails.

Tony also fed the series to AI, two times, and each time he got a
different answer.
The series was on iwl-next for 1.5 months and only one bug was reported,
which I fixed immediately.

I can take a look into this, but wouldn't be better if we take the
series now and then have 2 months to fix bugs if any appears?

Thanks,
Olek

