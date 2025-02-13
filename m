Return-Path: <netdev+bounces-165858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB41A338D3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533A63A17F9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938A209F48;
	Thu, 13 Feb 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHIMLfqw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10953208990
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431666; cv=fail; b=uHnx/LmAFQqj8dYnR30jWW45lhXjDunFXU+MeZ0n1InGjCobcNmRnevw0FAj9ZlH8/Ao79Q3zKTFBOqJknm8bUn0+r3AWtOAdIqgfpGBYTTJeiLkyiU/GgYg2iaqycRTsg5ele7TTHf3zdUsOtr110nhFRitBNhxGrR/uZLSsfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431666; c=relaxed/simple;
	bh=Ew7rVBY9ubC/w8YCQyos88sku01pndWkERyAnhODoxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W3kiRwcabvPcGrHitFHKGpnQj9hJl+0iS+Jux+qhtFEXT/nrvh2xlK4R29ZPlE9SGrxk+WdmnocnBVkYxaDffBnxGe9NOIHLB5Vqqugd4b6Fb82398Hbaa3OYKCPFE4pEQcpdQZmrQFJ8aDye/vqE7CG8gOtzI0zn0CD/Tm8RlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHIMLfqw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739431665; x=1770967665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ew7rVBY9ubC/w8YCQyos88sku01pndWkERyAnhODoxY=;
  b=gHIMLfqwY7NN5LpfSaTnNhtGddDmW/hkq45cN5kSDCpdqiagZwvrMlAv
   ufkjrKeCzUQ2sIbZzA3wjbGk1NxOsFjyjHAQMDN0L6TJg18oiM5vRGAMQ
   cA+8r3O1mskBLzm1KoNcFvLWqrHvQyrgYN0qn2gU3mpOEgkOHl2rzEudH
   R5CpCaknK2pBqewJ0L2fDBr/6NktX2blvmzak9UCFJMuLjFnecOXgfPsd
   5mcJ6B9AGaYrI1wQeXlped3bDv9xxi2ZkfxQDlc0LMcPRDlLu+Vk3TSBc
   gCngI8eoyzcB7nbzC+S+Izzg3xS+wAHP0V+L0UVLgkduZsnYw7xESM0BM
   w==;
X-CSE-ConnectionGUID: lI2qIqXFTyS7ufeT9qpnPw==
X-CSE-MsgGUID: FginigjbQTCniNtxzJBUbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="44050825"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44050825"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:27:44 -0800
X-CSE-ConnectionGUID: /hyrpO+DT1m328YrBps4Sw==
X-CSE-MsgGUID: LiS+5d/tQMCnRT6++jQkXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118152312"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 23:27:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 23:27:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 23:27:42 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:27:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx5jU8IGhS1lQG/dmo+Xm+lclunYJgtasVvcTEStkR+H8tS2QwkQVzoAlfKz1gfxhk0qjujJYD2A4Q+9d0DCehZshq/l5gKPaFw7wpb5TVlhoH40sDH9OGIb+q1X0ZzkES4/FiT26QICkyrKbLF62/aH3i3ORZMJ5TtOXjyyf7aSOVUhPfy58/dKe4ElM6ZenET9ZDq8wI6OBN3Gbj+3Jf1fIhg3lM7c8lOMlZ0gr4snftZekL4w2+gc/VzzETw/zA9iJKmG/V3F1qcjUsn8vWYEUGBhi9fwH+0AARjHLd3cTFgFhzhLL3ErW/ldkaqVAgSysm0F5uvcKUgBr0+wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI6ZW8IzIsZOsuuvvtCSxkXcEhIoJcAakOG5XlNoYGk=;
 b=yq3yJ9Bz7lb68J31dKr4dJYW5Um8qO4Cf9N+JXwRvDjFjqT06HYaUQNxVgcTQDJv65H7YGN2gPv+FjNXSO6RkRHc/ZuwM/OzhT+seW0I1w8Q2Mm78kq95QwvNcvU0kzi3oA+IU1MbmP3gmLY+ALrzbsVoBy2qNbjpkvcuD0G9W1ppvQu4Mk5I254nhcTvCHhEwJkTvKWLYF89oclirinxbXgbeDiOvHgqmlVwl0Ax89b9YJhBnCBfKIYRgUbiKQ7X9hfQTpw4bRdT/BmTiJSkMF1/QAACuGcqORfETX4Q67sGWDJHb8BZfuPQ9sNW9n/Dp+qC2aKMYbfnR+rtXP5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:27:40 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:27:40 +0000
Message-ID: <13eb84d9-f562-424e-b680-229d80ac0cb7@intel.com>
Date: Thu, 13 Feb 2025 08:27:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, "Neal
 Cardwell" <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<eric.dumazet@gmail.com>
References: <20250212132418.1524422-1-edumazet@google.com>
 <20250212132418.1524422-4-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212132418.1524422-4-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0067.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::20) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca1442-a445-40c8-fff6-08dd4bffe613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2xrMXBkZlE4NVZybHRLT2hwS2ZwTW5Sa2RDaTQ3elFBaGhqc0JJb1Q2UEJD?=
 =?utf-8?B?d0lVcUtYZXNGazZ0aG9lNGk4elZKVDJ4YkxsRVJFZTBPaDNSS0lVOG44aVBj?=
 =?utf-8?B?UklOVEFiRFZORVVPdmNSU2JiUDJmNnYzL3BhTnNsMUEyOTlnQzNpWVowZHAv?=
 =?utf-8?B?aTZBZ0o3cy9Ia3ZOenBvc0Y1c1BpbVZDd2UyTDY2OE9hVGJnM29MUmpFTjN1?=
 =?utf-8?B?WXVOYytwVllKWDlydnJkc0FqVW5iZERUbDhwb3BCbHluaE5qSUQraVE5ZUNu?=
 =?utf-8?B?RE5nMEhtWGxuTHFXVEg2bnZielA5Y3RZY2todWlvcHpJQll5RUZkTGh0dlRp?=
 =?utf-8?B?aHhzZXBHQjVldWpoanB6eTF0aWdOdUh3REtzTVBIKzE2MXV2bkNLUjRmcWt6?=
 =?utf-8?B?cXp4NW01Tm1UYXNWM2ozK3F1L0N6OTRtK0VGS2ZWenpMMFFsSVlCN3ZZQkl1?=
 =?utf-8?B?RjRUWDRsZGpGSW8vVEFXcE9jSVhRTm1iR09kbzN1T1BWWnhZUURGbHVnUW1F?=
 =?utf-8?B?KzZCSE1YdzFIQ1lyM3UrT252OWV4ZkpseGtSYTUrUzJDT2t0T1VxaU50OTk0?=
 =?utf-8?B?N08zeDUxbVVYQlBYWlRScTA1bkJTSE9HWTFSRkpzb0FVS203N3QwVEpPc1pM?=
 =?utf-8?B?Z1RjQWJRd2R0Y1Z6aVJkSTgzMjFRSHVjSzlSTnR6REZqYTJROTJORktvSFlk?=
 =?utf-8?B?WlZaMWFNb3JJVGRiWlRQZVhhRjJFdzZEK0w5NFFVUGlzZERGMHhaT1p1K01k?=
 =?utf-8?B?VnNqblVabDBkQjdGR0ViV0xHek95QUR3ME9pZkRjYkI0cSt0cnltWjNYdlNB?=
 =?utf-8?B?a0pVcHhlSEFyV3pJU3JSajdjMlluZW0wZXBPelZUdFN3VU04ZVZkVml5Zjkw?=
 =?utf-8?B?T2ZKTEhzdUVReC9tR1QvSy9zMW1DTFA3QWVwVTJmSzZERGdZcWxTL25LWXhG?=
 =?utf-8?B?dEp5Q0liV1dsYW5OeHY2VWtuaTk1cVJNTjdIS1duWVF6RDJCR0U0NWkrd1I1?=
 =?utf-8?B?K0kxeTB0YU0wRmFTMDE5NkFILzBCcG5nUjB2NVZkbFN2WnFXK1lMcGoweWlw?=
 =?utf-8?B?d0VFeFgzZGNtV0JIRHNhOWowTGtQYW5qaFk5VmNqdGlub0NqYzNGV2dlMFRE?=
 =?utf-8?B?T0ZVQktLRTAxSTYxSkNkVmkxR1grTWhIRGZwS3dOVWZ1WFlpd0FLSHkvQ1Nm?=
 =?utf-8?B?SWE2MnN5YVAwZE5SU3RYYXhZYk9ySkNHMjVEdVVISm96ODFxMENuUExvSTND?=
 =?utf-8?B?WVRqWDljTjRZNjJwZkwzaEYvaXJQSzhWZy9VTGl1Qk5iMFIvRUtHYzVnUnJx?=
 =?utf-8?B?VjhlMnRSVmM5RGhLcTdOcmxTb1p6cU5TK1Z3cHVlb1V5cEJLYjlieEpSNzdn?=
 =?utf-8?B?aW5UelQ1anNIbHczcmUweVJtQm81VHNjaGkzNTQ2WmdjRUNJVDhHTWNaUURW?=
 =?utf-8?B?eVdvNlJDTDJvOVc2WHZPaVVLRzVyZlJOVmUyOUM4cENDeUN2N2FZRm5LZGNm?=
 =?utf-8?B?cTBFMkVCUW5WdGtKcVBRQWthT1Bvck80L05hUWlWdWYvWmEzM1BnMG81T2pq?=
 =?utf-8?B?OGlFcGtqb2VwNVFuZVpEbVkwWEZxNzArWnNKQmpDMDJwTW5SbVVMa2tJK2gw?=
 =?utf-8?B?R1grdW1RanBhVDVNbG92V0tHT2xITGY5ejVESWlOUWs5WkRKSVVvMnZKd0VN?=
 =?utf-8?B?V3d0UUJyUjV5cEppcGxHODVTSmVSR3ZIRnNBUzNwQzl4U0J2ZzJlMUoxeFAv?=
 =?utf-8?B?enR5UmR1VXlramlrc2NrQVJxMVMvZTk5cHMrYTFhNlVVd1ZvdnBtOVBnYlBk?=
 =?utf-8?B?Ry80KzZnRVV2Z2xSdk45dktNdkF6MjZONS94YnR0UGtkOFlrbUlzYkRnZU1W?=
 =?utf-8?Q?fy4iXYLXONCu1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpLOU5iVk41a2c3VG1yeTk5T0grQ0VuYjJvaFJFdjdYSlVsbDQrcGs4VGww?=
 =?utf-8?B?STJiKzNSM05ldk1GOUJaQkcyR1labHI5OUVmd1JqMVJXck0yOTBucDlPVlZa?=
 =?utf-8?B?Y1FkaFVPbWYzSHB3aUU4ZDhRamRlS3UxWXlTWks0WE1vaUM3N1YyZGRxOFJq?=
 =?utf-8?B?ZmNPRmtaOFBuR3lramZQNitOM2o3cFBhWUlWRVpuODN3ZmcvSGxXdWNPVmZr?=
 =?utf-8?B?Q1BSVk5oVUJCWVEvVllFQ1ZJMlhzY0RuR3hrM1NiK0U4T1RHdVIrNVNWS2tQ?=
 =?utf-8?B?dnJKN1VUKzNZRlZlNXgzcWdORDFWVW90N3V2OHVVdTZNUE4wREpNeklJVWFR?=
 =?utf-8?B?bUk3Rk04cnJJU2M0b2xPdjZ1Y0pQaWcyY1U1TDIwWkt5bEdZNnZZV0JhYVU2?=
 =?utf-8?B?UGhpSldBeFZYdEYveXE0eUlkdFZkWVZobGIxOVpyVHB5RGxqakwrL0lsYUVE?=
 =?utf-8?B?cWxQa3diZ3VqQmgvK205bk9nYzl1bktZZ1B0Y1hFUWNEVmtEeFlqVUlUUU1j?=
 =?utf-8?B?aDAwUjRIYUNkTndSUm9SYmdSTnFYMWZVZkVxeXA1TWQxRzdJUXNObjJDUFRY?=
 =?utf-8?B?cWdCcWJYakpPVG1nRDBocEdjaThlUzdGYkpXNnJsN085WmlLbEdTKzdiQThE?=
 =?utf-8?B?ZlovZEFaczlCQWRjamhCQTV6eXdHVDJsOXZZUURsbWlWNEx3M2UzM1h0N2Nu?=
 =?utf-8?B?R1FMeHg2WEl5ZEk5bnRrMW5aTVRmVjFOR1gybW1ERG9SRkJObGN6N0oyYk41?=
 =?utf-8?B?M2ZkMEtzVjhmR2F4S2xZOUx2L3RFcElzdDhFM2dhWlB5YzFQRkNGYjdrbzVJ?=
 =?utf-8?B?c3ducnc0VDlZcGtkQ2xzbjIwcVlzNWZkZ0owRWFlSE0vVkY4azh0bXJFLzdu?=
 =?utf-8?B?MWJBOEhFSzNCaDZMMGRZQmFoOEQxbHJjcGxReVZQUlhielFJNndEZkZodkxn?=
 =?utf-8?B?RXpmdy9YZld0Uk5tOUxrYzBxR3BsL3hObjFHZUN0RFA0Q0kyVnlRcTZXdmVr?=
 =?utf-8?B?OVQxeUdjaWxvT25TQTU5cXNPSXF4MSsrVWYrMXVMUzJuUGtxbkEzS2RxNlo5?=
 =?utf-8?B?b0diNVg3ZXcySGV2dTRQb3RuWExRNVZwR1VreW9oZXV2QUtqcUtQVUVZWU45?=
 =?utf-8?B?V01YREZPdlJGQ1J1STFCN0ZJUTZxaEcxNmRWT0dERXRKaG4xYVdIYlQycUhY?=
 =?utf-8?B?NnpyUWdGc0lOWmNQZUJmMGhFVWRoZCtUZnJUTDBSL2JPdzA3MW5KSW91NmRr?=
 =?utf-8?B?TnIwelM3ZHd2aVkzTHlkSS9vL2RNVjMyOWJvNmRNRG1MOEF3Uk1WZi9YMWt5?=
 =?utf-8?B?eW1TTkE3d21Qem5vQ2VOTVY5Vlo3Mm96NERLWThXZG1hSklJMXp4YWRjbnB0?=
 =?utf-8?B?c3BIVmhrY1l6bThsRFdFNVB1TTJGTStWanVFV0dQSi90RjNHb1NiNElJM2F0?=
 =?utf-8?B?eTFleDhKdkJ5OGtqUnMwWFRvOUp5R0ZXSy84d2VjUEVQeDVERG00WXBTWE53?=
 =?utf-8?B?WmUwNml6NExtamlqdjBKVDZCb2dNSGlsQUFHdHRxNDFZbU51U0JqM2tDWW5F?=
 =?utf-8?B?Mk5zdFE4cGlLU2pmZHpaZkJrT1ZNK1ZKWGV5Z0M0MUpxVGUvTExOOFRjNGly?=
 =?utf-8?B?bDloUno5MXd6dUpad09wVnd5bmU2b2p2SmgxL3hRMHdvWGxsN25EWHRZdnZu?=
 =?utf-8?B?UGVoMFRXR1g3a3NzVWU0UjZaeVdUQkc0YklySXJXNUFteGhwWXVGUzZWRDc4?=
 =?utf-8?B?b1RKWmIrZzc3T2IwOWVsWmxXZVMwM0Y3QVVKd0I3YnJZbE5NM0JHWm5UTEg3?=
 =?utf-8?B?Q0FNbU9pcllFTE5vL1k4VGxzcmE2aWREaGY5WGpvSTVQeVBlWUhlSm5DTHR0?=
 =?utf-8?B?cVZkbUx1NUlPcU94RDE3bUhOb3dFbVJlY0NvOUdVOWFCZjZOM3lJNnBwbUhq?=
 =?utf-8?B?dWxaQnFjYWhoWEw3ZldHbmU5Sk9NOVVKaTB5ZEtCekVvVWRxeXlpSDJLVTFr?=
 =?utf-8?B?NFBHWDh0QTd2MGxMdTRXTk8xWHMzSmhFV2xpUGo3RVhtNXJWcko5ei9lVHdQ?=
 =?utf-8?B?d3ZiSXVJTVc4WENoTWdYcXQya1NjU0t4Rno0U0p5d1lEUCtXNmRpQ2lOcHBi?=
 =?utf-8?B?Wm56NVN1T2RZNlU3ZCtvSytIK2ZXZEdUZFFYNEtCOWI2VU93M1orV3dGWmRL?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca1442-a445-40c8-fff6-08dd4bffe613
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:27:40.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2gKSm8wnsboLJVzkMNTNqoqig6K8SXAOcrwzrB1DrMI9ldy+qZgrVftd3146j4O5YnsWIUZZ1TZWGGE68QGEi8+aw3FYXWs2Vrsk8MAkEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com



On 2/12/2025 2:24 PM, Eric Dumazet wrote:
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> tcp_hashinfo and tcp_openreq_init_rwin() are no longer
> used from any module anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/core/secure_seq.c    |  2 +-
>   net/ipv4/syncookies.c    |  8 +++----
>   net/ipv4/tcp.c           | 44 ++++++++++++++++++-------------------
>   net/ipv4/tcp_fastopen.c  |  2 +-
>   net/ipv4/tcp_input.c     | 14 ++++++------
>   net/ipv4/tcp_ipv4.c      | 47 ++++++++++++++++++++--------------------
>   net/ipv4/tcp_minisocks.c | 11 +++++-----
>   net/ipv4/tcp_output.c    | 12 +++++-----
>   net/ipv4/tcp_timer.c     |  4 ++--
>   9 files changed, 71 insertions(+), 73 deletions(-)
> 
> diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
> index b0ff6153be6232c5df27a64ac6e271a546cfe6ce..568779d5a0efa4e6891820a0bbb87d3fd9f65721 100644
> --- a/net/core/secure_seq.c
> +++ b/net/core/secure_seq.c
> @@ -71,7 +71,7 @@ u32 secure_tcpv6_ts_off(const struct net *net,
>   	return siphash(&combined, offsetofend(typeof(combined), daddr),
>   		       &ts_secret);
>   }
> -EXPORT_SYMBOL(secure_tcpv6_ts_off);
> +EXPORT_IPV6_MOD(secure_tcpv6_ts_off);
>   

[..]

> -EXPORT_SYMBOL_GPL(tcp_set_keepalive);
> +EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
>   
>   static void tcp_keepalive_timer(struct timer_list *t)
>   {

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


