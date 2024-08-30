Return-Path: <netdev+bounces-123721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6A966464
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88626B20DCA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879218FC81;
	Fri, 30 Aug 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReI/uM+P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945F3F9C5;
	Fri, 30 Aug 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029138; cv=fail; b=ocrEiDrhOzSsP/PZz08js6AkWlxTT5IBfb1wXEbaWXR/lDPywLiORIpnvE7DgmfrNvYeFkMEiA5MPvwJ2AQkpQ8JJYllfagYStAqysaM60f1SsmZY7pEc0yzatQbOSdhnIlTOvf0Iu0PrpJmz6ZKeTbsJba+CE9/Gki1Yqmda14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029138; c=relaxed/simple;
	bh=sWhi/6rhKROfIxwlQ7kb75seNGkObaHS7NaTjTYPqxU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0NJqBu4tgmN4mRHZPCqn4c4yajc8neRHlNkevHmwIO4Q1SRX6GxO9Yfc/6ubHlIDnsSGj9VEOm6AqMoTTy3U2P+ydTbFEFvUW7mEO4NWTu/KIL49hAnJ66DHn5JpUlUCb69DWEoC1g8q+esvoJU8r+KZhrz/CkL5Z9VkgSFIrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReI/uM+P; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029137; x=1756565137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sWhi/6rhKROfIxwlQ7kb75seNGkObaHS7NaTjTYPqxU=;
  b=ReI/uM+PxaFTo/rDVRtA0Kn2iyfWToo9rsMQ6lRABCQD5fCHXySB5/T3
   oIDv6HUpOomqvZUDbqgnYSQc8xCnGf0A1iiYoT/IL+a5THk9UgOO9Cmvi
   ntTFZcJVu8iP3P5WeMPbDw5XA41rm1Dc9HDN4wZUJeaYTwbC9uIwavXA8
   vC4ItkkyllnCwLcsgb+vDHoAZGSt9DZSfGe9ZmGVgHdFqb6YvC1I2MZW9
   Wa7Eg2ByAarVrOTWn2iBVAroFrPaCwXectT0WggikZRHBM45NEAz7DV8a
   E+mnSayc3HsHV7THgBsPJpkgqLip05myTxwjq5P9kQaoEwHeyvVCNvV/k
   g==;
X-CSE-ConnectionGUID: xmk5KyNdSqe6Vrk46Y9+1A==
X-CSE-MsgGUID: egJmxvbRQ1WvbmME+4T7dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34835331"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34835331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:45:36 -0700
X-CSE-ConnectionGUID: Y9azb2qARjuG0jKTVjlpjw==
X-CSE-MsgGUID: /rmq/DJ8TiqrNOyKkPxaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64667776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 07:45:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:45:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 07:45:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 07:45:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 07:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkgFoDgh0/dF+gtxgLHSXxiVGSWM844GYeJGrAoDqkMzFdpFvolzdTisWraOlPql+ZqWcz0V8qdy1puzEorqDf4rEA3XEjwy8uqD/6bUp09VjheS91qbe9YLqtv+qcEL+UI16JxjFVfu3TLzGu9c2qkO5uKlFlCBVU8zYatvdphkXgTfHG9TFIrCrFOzrFMolzkZWclhAcVNMZGSubWfEzQBwfTg62IWQgAYPZ9EmvAj24Pznv73Ub1FJEb2wjeU/j7C3u7H7vFEEfeAhFwhdlSGSAMX24lU9Q/YOE/wlCopGKvBum88/UNZd/F4NSYlGkOmbexUv9DJCqqAf+ODvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ARxBcM50Z7d0anGTDzrl++/mH//XD7y8FOASE2ngls=;
 b=pI0rTgdKtEDlNWa2fW2EjctarBzKQibZKKuK4F20wIkZZV7UIJalvmqQ7OLmvpIGltmPLYscaN0OgDW1Hh1lLaxVllWxucO5Dfkx4PJpSWwfpOdjn4Rsv7wSLYkErBN3hQxKGnydbT7gt7rEzK2Do3FUpoiMMUbGxx1nU22ISuAeRriEyNiu4wrYLU+BUB7PJmGInkuBR0RjPgIiNvZzYTSwN6irDYSj/r0AM/ZCO53hzn/51APv6VvlV+zyYIaV7A1UCOmk282t0XR/Rj689N3X7x19HUM8cMoeTp/uw5RNNGDHJ4SB4GfBIve1RhQOdrwG3b1Yw4WuKZz1oKEQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Fri, 30 Aug 2024 14:45:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 14:45:31 +0000
Message-ID: <06ff49c5-10b0-42dd-946c-388f5cc3a1e1@intel.com>
Date: Fri, 30 Aug 2024 16:45:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/12] net: skb: add
 pskb_network_may_pull_reason() helper
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <idosch@nvidia.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<dongml2@chinatelecom.cn>, <amcohen@nvidia.com>, <gnault@redhat.com>,
	<bpoirier@nvidia.com>, <b.galvani@gmail.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-3-dongml2@chinatelecom.cn>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830020001.79377-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1531ff-6993-4b21-dbaa-08dcc9026582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1dvZHRKa3hTeXpSUk54U25qeEFNMnY5R3IxenVQZGFTc05LR1A4L3hoV0wv?=
 =?utf-8?B?SFhoeGlQMGVCY0xJd29TQktNbFlrenRlN3UyS1A1UjY4d1RNTlhwT1lSYzlC?=
 =?utf-8?B?ZGhnVTViMWY3aUllZjFHaWp5QTlzdnErMHlhZ1F6SWhmTURoY01oOVREUWxx?=
 =?utf-8?B?SldLT05nSStBWUpZQ1pIV3BmTlN0Q1d3ZUFHc3VtMk0rQ2pHcUJvQ0I0WVor?=
 =?utf-8?B?V2ZUN0hLYkFTeGFRSzZnNHBKbGFEcEl2RWxFb2NwcXpBbGk2WkVwT2lKRGk3?=
 =?utf-8?B?WTFqN2hxaWMybDFDRU5YZzVRYTBEK1d5eTNOY3lRdG9OZ1AycUg3VFRYdGVh?=
 =?utf-8?B?TGd6bWJ5N0ExKy9BaC9uSERtTTVkeFA5NTZzeWgyZUs4N1hIOG95QVRRVTlU?=
 =?utf-8?B?eWpyOWI5ZlFzeEFEL0F0RWxUM2tSRExoWFZlSnowQUtRZXQ3Q0t5TG82ZUU1?=
 =?utf-8?B?RnNqc2JCRTdtVVk2ekpSbi9EYXlHUWFLd20weUMyRnhzSXNNTnUxNjVUWnRi?=
 =?utf-8?B?NU1VbTI4QmNqcVN6N2d1eSs3cFFKZDAwSVJoNGpCVDRFdW1TQ291NEw0c1ZY?=
 =?utf-8?B?NFVtNGw0MytIOGluOEFYbkZRZDMzei9zQ24rWWJTaXBnenZsK2pZOGxwZ2hY?=
 =?utf-8?B?RXJHdU1PdWNldFp1Wm96RUxkRGVlTitXMjVqRXBKNkNRQVlPTGRDcENXQU1O?=
 =?utf-8?B?c1J4Y2d0SWg4YkwybndFSkE4Y04ydUpmOXNCZy9RN2tQSFhoT210Q3N3RVB2?=
 =?utf-8?B?a2J0Y1BaVTdwc09aMUxuSnhZbU9nNkFYdWJPc2N1SmdnMjFrL2NhUitEeUdL?=
 =?utf-8?B?OWFZc1BuOVMzbmk4a2Z6blpRdWVZLzlKMlM3Zk1QcWFVUlB3c0RrZWtySnJ6?=
 =?utf-8?B?RGh3ZmgyaWVDeE1lZS9jcS91MkRlSFdRT29RTHM3dnVwTDNXU2N3NUZhWE8x?=
 =?utf-8?B?SEs4OHVQK2NPZ011dlVsRVlQS1JFUlE0UEMraVprWU1hbUdYZnhmMHVCV1c0?=
 =?utf-8?B?VWRMYm1yL2VjQWI0UWdUOElDNERYNXNkUFZvTVhRajZQbDNwZmlIZ1l3bER0?=
 =?utf-8?B?c0VUR0VzdXVzNzFrQVJsQXZlSEU0NjZCTDlmNGNiSWdOaUt3S0VZYTBzbUd2?=
 =?utf-8?B?RW5TQlFFYVlqWEJnZHUrNHFkdU1CRWdndnVZYURYdWxXT3V3ekFjOHREWFZx?=
 =?utf-8?B?UzZ6NHIwUG9HRDJocjUwRU9ISUFCaGtwejJIQUJSUk5ndTRyMzhOVWFOQjJB?=
 =?utf-8?B?NmNVUW5rM2UrMitLRkUzYnIyYjhuQk1Ody9RUnFseWp3Wi9WNGRmeEV2T3Zw?=
 =?utf-8?B?THZSOGpPeHBNUGM5OVM5UWdDQ3Y3WW9pWE1VbDJKK1RlQWxyM0JQOWVnd3ZY?=
 =?utf-8?B?eHVKU0I4L0JGTDJtN3dkL3hDRjJwaWp2M2grRXJIYkY1R0t4RkVNWUxSZ0xH?=
 =?utf-8?B?Qkt4VGRFVUtnM1hXSHc0YTB5VnZ4M3hXSG9CcVRDVzJpY2lkL082SHU3cU9S?=
 =?utf-8?B?YVhxZ3JENU5pTGxtYmw4ckpMaVdSQ3hJMXBiZlVTSVptNW5YVFJIZjNPTXdW?=
 =?utf-8?B?d2VFM2J6cmdlWDhid1l3aU5Sb1dVVUdiVlQ2eVczdmdxRkttb0hTV1J5Z2kr?=
 =?utf-8?B?TmlrNFUzbEJibEczQVVHZ1AvcjRNN2ZKTHBBNzBYRFByNnBMZzdKNUM0OXZ2?=
 =?utf-8?B?NnpxaTlwTm1hQ1ZuQTNsaDEzN3ZqVjllTVRZeEpNT0MzaFBaVE9qK0NIT0ZI?=
 =?utf-8?B?QW52RXhkbkpZTkxWdGVBVUl5azNXK3hSYjFYOHI2U0ZDOTRCY1hOd2c4VmV3?=
 =?utf-8?B?MlRtbXkwb0ViMDlwL2tvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndBNmZMNmN3V1ZJcnArV0NtNlFLV2ZKQmErSVp1bk5rSTVYU2IvN25TSmhr?=
 =?utf-8?B?RkpsbmpuTkEvU0hjdEtLU0V0UTdKVHV2R05CRWZIYkVyRmsrYmV2b0dPWXNq?=
 =?utf-8?B?NkE5cndvWlQ3U0l2bExEZUM0cmFhVEJvbGw2UWFZakhGZGI1U2RjK1h6MENx?=
 =?utf-8?B?dHBOT3Q1aUxvRDl2bERnWHRQMk04NzVqVDAwdG5xb05RNTVCV1J6TG9SVzNx?=
 =?utf-8?B?VXYxSFNOZTUxcC9vNTJrTWxBaWhHSG9IVnllV2JpS3d6cXZtZ1Vlb1UzTVRr?=
 =?utf-8?B?YW1LQkZPQU14TGRLb0E3RXVlQWFaeDUvWmJIK0RsRGlUYVg0WFlMNW9ScEYz?=
 =?utf-8?B?dGZrWGkzVnltVFd1Qi9yZXh4ZVIxVklZa2gweHVPYTRpWnAxUDl3ZmhvTVFm?=
 =?utf-8?B?WENrMWJlandiVS9BWHVuUzB3Qi9nRlFmbHZNdlJ5YTVOSUs4ZDVHWlUrak1N?=
 =?utf-8?B?UVhaVDJEL1BJSHJYSXNjREZjU21CTkEzSG83dElldGlrQkw4VklpVkNTNzdo?=
 =?utf-8?B?Zm1lZDR3YW5PUXFGdm9WZmhIRTFKM2k5RGNlUDJKS0dUamxjd3F6NHZMdmc3?=
 =?utf-8?B?dVNQTDFldk1NTGd3cU9ZNktxME9QZ2Y2Ym1QbXJNMUFNc0FzY1BaeVljaXcz?=
 =?utf-8?B?a0NPRmQ0a1JRMTczdGFIanNqRVZMSmhnRTJ4b2dXMkkvRHFZL3ZLb1lGRXJP?=
 =?utf-8?B?RHdpVUtRVlJkWVFHNTJwZ2FMOVBXMnJHeGlzUHJhQmlsVUtTTGcyY0NYNlI4?=
 =?utf-8?B?NHNWdVQ3c1BqbmZvYTgyMnNVYnZpcHlEU2owZ1lEbkd1YnJMRUxUQURFVXNa?=
 =?utf-8?B?WFhieHRaZW51RWs4OC9FYi9aVDd4MUtVNklDSzRoTTJXaHV3NGxnVFJoNlBE?=
 =?utf-8?B?ZlVyeXpkQWRjdzV1OWRRWmxKeDJYU0hicmNjY3ZPME5xOFZ4ZHYxUWdaaVNv?=
 =?utf-8?B?SUxVbEFtVC9RUnpzMldFNEZpT0pSekpCQ0VpcXJEUlM2d3g4UmdIK2lneisz?=
 =?utf-8?B?UUFKOFo5MlZlckcvbDcwdnJBeXhEdGtja0hmUnJHQ2NDQnFBRzBjT3oycTVa?=
 =?utf-8?B?YzNuRlhNWW40SWlwZUxqcFE1enk4SlZqejdJbjVoL2V4b3oyUVQ2eFIxMmlj?=
 =?utf-8?B?TXRwNXlDNkZsVnp2WERmWEdsN29wZENWMS9lTlBLdGZ4YjBHcm52QUxjaEpU?=
 =?utf-8?B?bjlPNUNybnNncUF0eW52MTBQNEh4cU1ublQ0K3g3TUY0VVE1WjNyQVlTTFZh?=
 =?utf-8?B?b1RsTkVFcHpKanlHMlNMR2Z0SGtLTlVSblJxNXYyNTN5STVlM3Q0WmRMRWZL?=
 =?utf-8?B?UDRyemVTd3hvZnVpTEpZWFV4N1huSGJLZDRkZVNEWW1IRUkvYUVZYzkrelVS?=
 =?utf-8?B?WWtGQ1pka2FzN3hUaklNMURoS0FpbWZSekE4RXFKMUowY0JqNE5oUFdkbFQ2?=
 =?utf-8?B?WC8rRlEzUk9qWFN6RExLSmE2dzhYcCtUOUdrVTBzVTJXWVUwbzhuS0lBV3JR?=
 =?utf-8?B?TW9hcEJlSDRMU3V6dHFWUVlEYnpNSU0yaTVUTHRibU44bXUyUTcrZU5RdkZo?=
 =?utf-8?B?TTNjeEVBdTY1ZEZRSlNPb3dFRVlJVHc5YWxxMm1GZjZqcUJKWklTNU1iQ3dn?=
 =?utf-8?B?ZEtVclpXa2FaOWF6OSsyYitsb2hwNElycWdFanJhMnQ1RXp0dHg4MnVSMG9X?=
 =?utf-8?B?L2NFeklFVTFVR2ZwTFNVTWk5empOMW9SeUUwZVJzcHhiQWJPVjFMN1FXemNZ?=
 =?utf-8?B?aStEWmpGdHdVek1pVjloRGhoN3hjRjhOK2xQbmZlVndKTGdSekg4Z21WRnJo?=
 =?utf-8?B?NnBvR2o4eFFkU2p2TnRvU3RGRit2SXI0VWdKK2dtaVpCR2h4bFh0Q1R6cXdY?=
 =?utf-8?B?NHI0OVhNdGNQRnVwTGE2NlM1d1kyNWJUaWcyMENHME13VnVHU3JZeDlENnF4?=
 =?utf-8?B?Wm1EUXhUOWpIdE5MZ2xWY2dVTU9JQnRuK20vbmx0YkhKUjduTWVTMkNIRGJD?=
 =?utf-8?B?Wm9uOVBRYWU1T2Jya3VRV1hxcnJnaTJOSGQxUWVYZXltWWpjNmdUdzl4dmh5?=
 =?utf-8?B?YklSdVJvaVpMR1BTYXAxcmhaKzNwbkw5bnovWTM4YTFSQWxUTGFpRWpCTDRz?=
 =?utf-8?B?UDk2bjJITUdnY0hlM0tIVDBVRVQ5dU54L1c0ZWdEdHpEUVlWWmgxeEJtbXY4?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1531ff-6993-4b21-dbaa-08dcc9026582
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:45:31.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfFGohov2G2Z+v9zyw4ZHpdy0751OwGk2NXg4lG6oM9xKnbEj22YTdu+7/PubkeEHFYttJUxpsbcJX8sJi3wz5MfZgQ3GlBl0poGkb0Ii+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 30 Aug 2024 09:59:51 +0800

> Introduce the function pskb_network_may_pull_reason() and make
> pskb_network_may_pull() a simple inline call to it. The drop reasons of
> it just come from pskb_may_pull_reason.

No object code changes I guess? Have you checked it via
scripts/bloat-o-meter?

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/skbuff.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index cf8f6ce06742..fe6f97b550fc 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3114,9 +3114,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
>  	return skb_inner_network_header(skb) - skb->data;
>  }
>  
> +static inline enum skb_drop_reason
> +pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
> +{
> +	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
> +}
> +
>  static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
>  {
> -	return pskb_may_pull(skb, skb_network_offset(skb) + len);
> +	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
>  }
>  
>  /*

Thanks,
Olek

