Return-Path: <netdev+bounces-86567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6B89F333
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4661F2AD19
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589A15CD6B;
	Wed, 10 Apr 2024 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENyzRpYH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2215CD69
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753528; cv=fail; b=Lpin3mzXytcuSoY8F5N+fDGqKx8Z7IE5tJUGX6awLm8rfxxIPNZ5gO1DBYUBWTFq0oyJGU5y1+WqcJwYgSZEkqhM+eFcBsEdfHHH6zusFl4y1j0aMrpu/FpXVhBoM1Yz99TUbpe8MJUTRQ97fBlaDPrc2sEvQb0ZLrj3nNgNONk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753528; c=relaxed/simple;
	bh=dtpp4oKyP4C2wpv+I/i8+wwE8ykwQo+QWL0b8dFuEKw=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEIfcbZaB/gZxKvVjRyFfZAwS/gX54RUd5AM4yLCOjnKoFwzIDgh96pWoAyaaqtJziOCy5gUwee89G8v8fRSZN6KOJK+8JxLZ0m+4YaLAfTh8zOBlKescgrnaeTrh7U3SvMV4MjstnwYWXnGEWXPz5lS5T7NExCjgfamV9jIeHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENyzRpYH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712753527; x=1744289527;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtpp4oKyP4C2wpv+I/i8+wwE8ykwQo+QWL0b8dFuEKw=;
  b=ENyzRpYHKIzKkxFV+UrvcZhv8dMknQtWsSXMkNO8h6hPYq7BamOUQvNm
   ePf28/+MXDJVyZgi5gqko99PtJL+SQUTP3tbysR8ZlHIBwqv0z9aM4W6K
   RonI5WNSDPJbehk/b+6faDnSJdztK3CiBY3iQY5ALWEN0cs7dfxw7wKfw
   ZW8dzsJkbT/kfG3zVYebyVRt6f3MNC27Nn1OI9CB8ZYJC/qRhe9Tx8dIr
   fmWRKji8ev/n8RPM3iszTbtXuvH/gzc2dIillI50q6hOYaq2mWU/jJFo4
   6RcvlkWeLfTGD4hB3dg0xp7/xhu6rzTWyjmeeaWiAiHgqKWjmly5gDB/x
   A==;
X-CSE-ConnectionGUID: KbNit3e1SX2fTAooIBqJGQ==
X-CSE-MsgGUID: x0+2TDNLTGS/84PzV++2nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11079629"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11079629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 05:52:06 -0700
X-CSE-ConnectionGUID: hjpGSLVMQCyVOjux/EUh3Q==
X-CSE-MsgGUID: sxkaYHl8SbySzBM2o4+BKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25062904"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 05:52:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 05:52:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 05:52:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 05:52:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 05:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXtsQI5Ro4gFdisn2wWEdPb18S7gg03WhYKVEOLoC6T42XOKfIX6cfoZHtgLFtC81UFSsze22q83djWQNPr94+HMzYnAzgu+fJFsKGzrhi4F74c09X3IqiY+pexZ/dgn1Ei5aicroYIZMTk0roer2JUzXTacIIQ8t6r0JckVE+bFPlFIzKeafWGOgwNOWyXPwbfwiPa7UIeivKRcQeokMakLkwTI945MOQiAoHslCdeoJGrUhHcq9YBbIMw3Ila9k5GAEGK18ceI9xese0jFoT5hR6nWn+jhmyy5IVrivWAX+cCNzL3Hn1CCMrOtUWKdeDuG10BWeEnyU6qg0Zu7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poxhk4CuoX48BdyypM3WWl+PkKtLVrP9Zh5wLW6COcM=;
 b=YDlAK7pv0R8dRPNhE338HlGkl6Ni8An0G+Emb/fYgpEyqtxDPwKduzg3Qc+WZxYiFC3yM4yqDaWFw+7fNqF4JYIAKm3s1qQCFeVaD7zr8f5y91BJTQAyV5l1HBRN2W7qn4Np7sXaiF8YecKlFPERVHPEa/fARzU/X3kXzSfRLKL9PsTJ751uxGEdlAVLA2C/MlN0XJsdqBTyTOM6H0509EsPnWdDQN+3J4e0CnzotNPgFmc34yAIYTXtfGK/3/esF19/I613UDBl74pfe/1KSeXGJBV5j5LU4tP3bAxNbfkGIAzhZkMUc26i9aBlGgjWp0S+y4c4QA6Hoi+yKNP3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 12:52:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 12:52:00 +0000
Message-ID: <8e60979b-31f3-4037-a1f6-5db7d3ec00d3@intel.com>
Date: Wed, 10 Apr 2024 14:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: Move eth_*_addr_base to global
 symbols
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <jan.kiszka@siemens.com>
References: <20240409160720.154470-2-diogo.ivo@siemens.com>
 <20240409145835.71c0ef8e@kernel.org>
 <e6166f35-87d4-4873-a412-fcf62d22e482@intel.com>
Content-Language: en-US
In-Reply-To: <e6166f35-87d4-4873-a412-fcf62d22e482@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BY1PR11MB8077:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kkpp/cY66S8FcWc+ZWy5DKOKEZMIqdR73Ny7lZwlbbUZfViyr8KeaL6L6/MnJam+vxsuOnr+uXBdPvjT2aGvvWIf5fSodYRz5xIFFZzMgWD+VQ7qUT8sHvFxdRzixQO6fB8CyFuwYRL97bXenxMsnIue7Qb2IRuNqDbSsftsq0wVYLhq4IlO99CUGVTuwrUZcmrXpGdgpbOYk36C3D9qPVDsdR123T692GGVfVoJlJo6ih4AuX1M3eNSdXAsQB3PPwMA3JOhaf3GXfrkxALyWLfIKYdt0hJm/7zCIYwqEKg4d2t2f7OVM3uTkarOLvsC2qhLMvpUtiQKZOKd5PiGiztCoO8xWYzTvYEr0OAsrJ3/R7gIERgKj2XCPPvHiwIuPLGRfckf+VXNpZZC4M6LhajNf76S1l+sqwCEvLYXZZK7nkbpv67eGqRu5WtpfnIoVvplupMoVa3G5bievhstt1LQuh9CJ1/GoXnPXNtXN9VrR1ubs4Okt61JZYjlKUYl54XWI4pFoE3soJbi839gdn8dnucAmCIl0k8+yTzFA16MzyPKG5oLKP4U8zYn/YfAFU34s8y404ZQKRfDFevsi0nJAvRK7mdBEdDOlssBTZsLFCvJ71aai67Gfd1uZaxO1VJDAfQXir57SJ0Yd/wO7BGfGWTwcVQWWCUDgr+sHzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGcxeDRxdi92OEFnK2s3UDE3andmdldhME5KTWNaN1dmdzZENWdsSnFhNEsx?=
 =?utf-8?B?azUyZHNHYTlBR3lzYi9YNTByNXVrTE11WTZ6bkIvK3lFVXpTcWswQmdISlZn?=
 =?utf-8?B?cHNkaFNxdlJsb2ZzcVhUcUpmZDRDTkNIOUhacjljcEkrMzhOMGRtYk56N2Mx?=
 =?utf-8?B?Q3dkQkZQa0lxMFJBUjF5N1phUnFoY1h0SzhKcnBlMTNZODIvSGNQd1MybDhi?=
 =?utf-8?B?MSs2VXY5OXZxV04wQXpJYWNHQVhjajV6Z1MrWVJra29rMkFITHlqSllDUHQw?=
 =?utf-8?B?S2FJaEZRQzJGQ21DUjFVbXNwSCtqRVVRcFFMMmh3NjVwbmZUcVFVTlpsUDhx?=
 =?utf-8?B?T1BiQjMxb2l0K3lzNElPb01IWGgrcjcxc3hJeXoxOEJhdVkzb0grT0szWHNK?=
 =?utf-8?B?aENaK1dMMmpZNjVMcDZ5aG8xRkFTVk1reDRaYXFyNS9qdWlGZTdCQXBXcXJ6?=
 =?utf-8?B?RGtFQVk2bnRCYTZmVEFLMmJ0MGRPaW5OOXJNK00wWnVzVzFkZFNqSGpLUnEz?=
 =?utf-8?B?M25LRjgzV25pRG44cGg4YkRVMnRLbDFiM1VWajZFRFQvOGE3NVFwZTMwTyt6?=
 =?utf-8?B?bWZlSGRldHlVKytDd1hQTUZadmFaMG5LYlRQREZRNXVCR1YyNUR5WXJtWm1L?=
 =?utf-8?B?UjJZTFYvTFdZcjlYSmhGKy91UU80bXBMT0xLemNqZjhyZlQ5TzZlczJFN0Mx?=
 =?utf-8?B?RG1rbEgrNmh5SDVuQ3RKZ2dNaTIrRGZVMjUyTDJtSzhLckRCekpMSG1OYU5O?=
 =?utf-8?B?b1NFYjRVM3gwbGVLRVhpOGtwM0xwYVcraG1DL1NjSUVHaW96UWpVTDdlZzBk?=
 =?utf-8?B?VFd6eVdualEwQ1Arb2RXR2FXMDdXL21PakpXRjRBa25FSjRsUmM3R3VjWjNj?=
 =?utf-8?B?WmkzemtCcXE1enFjU0NQNE9Ea3didUViVjgvSmNaL2JwR0NFSGdkVjNRNHRy?=
 =?utf-8?B?eWlwZWVpNW45OGVYbnlzRE4zKzcxMExBTW1kWVROdU1WYld0bDhTTUU2eXUr?=
 =?utf-8?B?VXYxMmRHSXpETUdidHBEaGRIS09tbVhveTh4MXhYQmNpY1JqMFJZcS9GOENV?=
 =?utf-8?B?cGVzMmUycWY3YmNVRERuNjdIYVdxYU8yQ1JGOVpjcHV2M3lCdURJMm4wOFVN?=
 =?utf-8?B?cVhFSE1yT0E5NTNQbGF0RFdGUHlJK2VjR0VEc3g3NVRxNTU3ZUNRbHd6UklQ?=
 =?utf-8?B?TEhuSWJqTEMzdVJMUU1MalgvMTNaZXljN3Vwa2F5VVV3VXE5U0JWb0YrL3RP?=
 =?utf-8?B?WkFDeGhFN3BXa1ZhMUJFeWNJSWkyOWJGY2pqUEE4ZHRLeXV2R28ydWtROVFp?=
 =?utf-8?B?alhIaGdMaTlaNDJJSGRzRi9rQlk1eWt6ejgrRzlDVjY0OFc5UDlvaEQ1blVF?=
 =?utf-8?B?eGhtTndzdUtiS0F4c2g4ekg4eVpOOFBzcmVTMHRKTE9SVmZwU3BmTkRlemJy?=
 =?utf-8?B?SVZhT2ZoSk1JRTdXdmZaWEJQcUUzTnR5WWN4NnFKcjVpb1d5UlhkbVZOak9Y?=
 =?utf-8?B?OUlKZEVwOXNPVGd4VklGcUY2OGQxczVtK290dDlocVlxMFJFUm9aMm90eXBB?=
 =?utf-8?B?YU9odGp6ZDhHSVZHUWVvbUo3N0x5Q0JzN0JGQ1JSdzB5OWo2ZUZTZjVoWGN2?=
 =?utf-8?B?TUxZQ2dEb2Zwam9CQ3k5U2xZODdTTmdhU2QyOVpIdFFHMzVrdm5IclVyb0dR?=
 =?utf-8?B?aFFWdGZvT2tLOEVuT1N0M1FrVjVtL21FTFZvczZ3Ny9keFh5MUdXSzc4WmdY?=
 =?utf-8?B?eDZ3dkFLT3l5b01PdWNsWHpxdm9nN1lwUitSS1RVMzVkaGh4WE9JcmpmYjdq?=
 =?utf-8?B?YU5RZnZjKzUwdS9rQkJZMGhSV284eXNkZXAzOWZvRjJxMThYM3J3c2thQzhY?=
 =?utf-8?B?eDZkcnhSbGJmVzR3Z2ZRVGhjaWxRZVJkcW5XOE4xa3ZZTHg1QnY3eUxhNUtj?=
 =?utf-8?B?MHpqL3lVMXZYdUNXNFErQ3Z0SHQyQUgzNkdzTUJ1UU5ZM3FzelF0VnBwakV4?=
 =?utf-8?B?dTdmUXZFZW1udkw3bFM4eXo2d3pMRHNUZkFsRmdVQUlzdlVINWhWOW1TaEF3?=
 =?utf-8?B?NXA1T0Iza1NGT3h2UlNVMzhtUUpHa3FnbTlBWWFzOFFJVHljdk1XK1IyNUVT?=
 =?utf-8?B?TlNMcmx6RUVyQ0xteEtkZ0JySUZsTlIveXJpdThJcFlRbEZVYkZrVWp4eFRQ?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8704b91-b277-4b46-eac1-08dc595d0355
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 12:52:00.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVBGVpI8/MRpX7IH3XAWI4lGJZQOL7WuXSXeWv/HZNM6IN8vd++dpUVGAVvbUEo6KxiYzmRIVQRwZGEJq/K9Mkclfi7IMOPfuCrwvxefyEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 10 Apr 2024 13:48:54 +0200

> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 9 Apr 2024 14:58:35 -0700
> 
>> On Tue,  9 Apr 2024 17:07:18 +0100 Diogo Ivo wrote:
>>> Promote IPv4/6 and Ethernet reserved base addresses to global symbols
>>> to avoid local copies being created when these addresses are referenced.
>>
>> Did someone bloat-o-meter this?
> 
> bloat-o-meter would be good, right.
> 
>> I agree it's odd but the values are tiny and I'd expect compiler 
>> to eliminate the dead instances.
> 
> The compiler won't copy the arrays to each file which includes
> ethernet.h obviously.
> 
>> I mean, the instances are literally smaller than a pointer we'll
>> need to refer to them, if they can be inlined..
> 
> The compilers are sometimes even able to inline extern consts. So,
> without bloat-o-meter, I wouldn't assume anything at all :)

Kuba is right, converting them to globals only hurts.

vmlinux before/after the patch:

text: add/remove: 0/0 grow/shrink: 2/0 up/down: 16/0 (16)
text: add/remove: 3/0 grow/shrink: 0/0 up/down: 18/0 (18)

Simple module which uses static inlines referencing these arrays:

text: add/remove: 0/0 grow/shrink: 4/0 up/down: 75/0 (75)

I'm sorry that I suggested this anti-improvement :z
Please reject this patch.

Thanks,
Olek

