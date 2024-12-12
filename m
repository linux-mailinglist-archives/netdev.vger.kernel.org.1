Return-Path: <netdev+bounces-151346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE759EE4A3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B05282C15
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB731EC4D2;
	Thu, 12 Dec 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx1ms9vb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B51F0E3E;
	Thu, 12 Dec 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001332; cv=fail; b=cP70ZgaMS1B+CwvwQ59uMhjhQfu1qCezbl2/od9Q+xs8EJ6JVAgf/evNEfJcLhqIpiwEIddOVlSc4KVDbBItYs+GzPBMylt7hA0IvFtxTw02LvXc3nFy+BkDPRYvI315ydbwj52l3H6+CawBg+BBDCCW3hXapsQBKxKBXChHl1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001332; c=relaxed/simple;
	bh=F8vPaZ1mLoE4txMq+VFIyTiRSUqVkdEzlLJhKoz6nHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ILdbtQpIhL/2TO2vLM/8HiBDVEa2hQmjRgGEiqimFYI4ZH4gcVBm+KInzWMBuQYvdfkvjeju50/4YJefSAu4r9AMQh57ou73qkoQed6mP4UQmAUsGX8OmD+n//LUmg7nVFjmCtm4jUBUGgSzGXbj6lY58y5rSu9fEDTlqfTPeVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx1ms9vb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734001331; x=1765537331;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F8vPaZ1mLoE4txMq+VFIyTiRSUqVkdEzlLJhKoz6nHA=;
  b=bx1ms9vbBa2Blb26Gw7JE92eeXu3zcEUdxC3u8yuYQUJroWCTN5bJet0
   2GlE1jsPm+alo//6E+Y2sYGDMGfM8fAod25lliHjNNTFFiajju4DEKqPO
   kOGv21BXMojt0r4bmwhJz4qCXrf6mNqt5iwCR0n/SWU8ZbA6FUJoBX/2Q
   DAQTiqEZXVEibe4Hq5C2BAzbMc0wg8SpskIisL8/yOJhyg4RmEkHa5g9/
   fGHxkHwG05bpWTjjrHHBlDMGmE6qYg+HKr7ARbWJ3ITBUiCbK57+9eZyv
   yC0NXfs40Gc6pSdahbFznylR4khJvDQ/tUbFfl6Cn8jXPMYF7J/NU+oCU
   A==;
X-CSE-ConnectionGUID: ZhmxzKCJQqKjCoR8ECEDCw==
X-CSE-MsgGUID: 1xEnwsPRQbWZAKpWf7rBmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34541532"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34541532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:02:09 -0800
X-CSE-ConnectionGUID: AulAKc/hT/i6FY/52H6+rw==
X-CSE-MsgGUID: vcYEUFIyQraBz8J43UKISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96738378"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 03:02:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 03:02:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 03:02:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 03:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK14cGVD7ncN9m7e8idK8nv8k0nzws/pn3YFDt0CwtaZzdXR6Z4bvEykLpr8nhxnNXVDpaVeE+AhfTIzGY/63m/nsQOD37lWtu5KCBGWjb3qllLkUhIM2rxwwSkxcMOt1NuSqXh2ELQG8na0s9QERr56Dc3WaaclnezYKLRUnwIp5ar2UzuRI4gcHFftpiKJwjb2YUPZ2uHnBEjJFhp9mi65FoWBYV9pzTbMY5VtqoYoC8j58mEjGgo7GSF/TqP0NaFIuFOkOdOP09w8dK6Fjpi8pRb6BDm9xl6wC77t5aigX8d3fmzXTaw0w+INkgLZ0OMrcebFLahPHvjAVBX67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XarIwy3usrS1aVJw5f9vIoeOLq7QkHrVQnKEx0Kmv/4=;
 b=f/ja3TiGdFvsYYSzc8yuc/HzkGupCL73DjgjX6oUwujfucVBT5s94SUQxOe5zMkAB9r8oVFFtW1ExMfQ/zia2iRoksJFZ1e6HjxhF9Zel++fRLhsZDDMv2wq9Ah00Vnm3H4vqVgGQSn1oHqHLyyoe8d2Pnp8ZIIB7Y5rpYtWHq8QoZiypTanwJ5VAFhXt6SYR/m6rQ9nGEXvdrF2c4+2f3cbcAnfJEzcHaWbgWv4PzUjfhzM2PWuuPM9uSBpVRhdZQfZsI5CJfypYbnqCclc614xlFk9mBhzRvuZE9k7XqF4QVy1dVceX/9j+HYGDCecOQoPLpCuMeJjpluHsA7b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5402.namprd11.prod.outlook.com (2603:10b6:408:11b::21)
 by SJ1PR11MB6274.namprd11.prod.outlook.com (2603:10b6:a03:457::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 11:01:59 +0000
Received: from BN9PR11MB5402.namprd11.prod.outlook.com
 ([fe80::77eb:a7b8:dca5:18b6]) by BN9PR11MB5402.namprd11.prod.outlook.com
 ([fe80::77eb:a7b8:dca5:18b6%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 11:01:58 +0000
Message-ID: <b409c23a-0b6f-458c-8e34-039338e799c0@intel.com>
Date: Thu, 12 Dec 2024 12:01:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1] net: wwan: t7xx: Fix FSM command timeout issue
To: Jinjian Song <jinjian.song@fibocom.com>,
	<chandrashekar.devegowda@intel.com>, <chiranjeevi.rapolu@linux.intel.com>,
	<haijun.liu@mediatek.com>, <m.chetan.kumar@linux.intel.com>,
	<ricardo.martinez@linux.intel.com>, <loic.poulain@linaro.org>,
	<ryazanov.s.a@gmail.com>, <johannes@sipsolutions.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
	<corbet@lwn.net>, <linux-mediatek@lists.infradead.org>, <helgaas@kernel.org>,
	<danielwinkler@google.com>, <korneld@google.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>
References: <20241212105555.10364-1-jinjian.song@fibocom.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241212105555.10364-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To BN9PR11MB5402.namprd11.prod.outlook.com
 (2603:10b6:408:11b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5402:EE_|SJ1PR11MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc32f56-b071-4e8a-cb7f-08dd1a9c65a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2piNDFaZ3dTUXBSN2Q4VWtQdEloaWpyZHlpZ3YxSUpJQkp5SXpnNVphODBF?=
 =?utf-8?B?MU9nRzJ1RmorVm1UVVZESGJFbUVUSFpYd2t1UzlrVVhvbVNIdThuZklnTStr?=
 =?utf-8?B?ejZWM3VSUGgrUGRMTE1Cak0wcGZTOGRpMklOYkxkNUg4dEdUN0RiRmpqN2p0?=
 =?utf-8?B?d0NGaU43NG5rbFFVeWIvZ1g1M0hZblV2S2lHZXAzVnZPQjJoRWlGVTVsRm5B?=
 =?utf-8?B?bk9nc1FXSC9oNSt0Z0VrSjZ5eEVrWUZvMFlibXVua29DaS9zNVdoNitjZXR5?=
 =?utf-8?B?K0pZYVpTbXR3R2dKekw3S2llTnRNSDNnQjFLWnFNNDlwRW5pMzV2TjhzZm12?=
 =?utf-8?B?d2hkN0lrUENVRGtlNVhDc2NWM3B3NWd1TmNLcHUyazJNY1U0V2N5Q0kyd0cr?=
 =?utf-8?B?N1h2TlAwSzh2ODVWclBuc0hjRFVVU3YwdHdkMnhuQ0g1dTJwa3NMK1RlVUwy?=
 =?utf-8?B?ak5aSWJlNFduL244eTJyakR4YmVBclFId1d1ZE5vZ0ZWdUFlRmdqUEsrYWFT?=
 =?utf-8?B?akhOMUMyaGtvSXlCaXRBUnQwT1k1Ly9SV3FYQ29xOU85MSs0Y0o2ak84T2RN?=
 =?utf-8?B?N2VERnZUR2NnY0MrTmNjVUgzM2FoemhvMlZpSU80S0V0cXlFOXNpZ1NQUzdJ?=
 =?utf-8?B?WFVkTGJrNHRLQ094RzBiNUw0RGpsakVaZUk3MXBKVjhmSmRJVVRmdW9DeVlT?=
 =?utf-8?B?OEp2d29VVkVjWEFEZ0dTRHE2WmtpVEs5V1hyNG1tVGR3QjlkVHcySnk0YUx5?=
 =?utf-8?B?TnhqSEpuUndEbjhWbThMdGoyUmx0VmtGREJLL1BtZkNtd3UwdWpJM1FUOWUy?=
 =?utf-8?B?Q3ZFbzJZWTZVcmRYdWIrMjFQMVlHKzRMdXdlK1R5SU1zNmtyME5icm5SZnBG?=
 =?utf-8?B?ejMxbW4wTGlOOVVSQ1NSNGQydE4ybENneUo5S2c2aHN2cFBWQ2t6bnh5dERQ?=
 =?utf-8?B?a2JOZUVYY2ZReE1yZmhWS0N6NGkxMnJHUERjc1psRmZJa0JLcmFWSXZWTVJm?=
 =?utf-8?B?eGw3K3g4MjlrdTMxelFhVjB4VmVEaUxMUlRsN2MrR01TMEc1V3huT0dIVG1D?=
 =?utf-8?B?NXN2UHRVTWRSd1ZpME90TU02Q25MbWlrc092NHErWWk3WkN6WVp5bkltbUdY?=
 =?utf-8?B?U2RGYU1DTjN6eDlBb0d0c3R4M2RWcjFjdGVmbGJDaVhRcTJ0UUxRWDZZQnNr?=
 =?utf-8?B?MnluTW9mMFNrbUxZcWRlZFFPWVRTU011dWUzN1publVJNWVDWjByU2NJRDZj?=
 =?utf-8?B?cHJwZE9MbGJSY0UzdVhGVnd5MDdMVWVtMUk4SEpzeURqQ1ViU1pOZSt1U0Zt?=
 =?utf-8?B?L045MnpTUC9CRm5mL0Z2aEpDeWtyTytnRlJvMDIzUUZ4VkltblZEUmlGU085?=
 =?utf-8?B?NmM1c3p4dW5QOUVEN1B3QXhwU2duWkdJcXltQzNvOG80YVZwM2hDaGVuNldQ?=
 =?utf-8?B?dUtxeWRaUWhZSFNudWhGa05jQ0dZYmZmRU1yaDlIZllQSzAvRWI2OTI1dmZF?=
 =?utf-8?B?b3Blek5BMnJDenJLZFJ5MDVNcFN0bHBLTTBnMjZOR0xOU0xUaXBDSUNGQjNk?=
 =?utf-8?B?TGgva1c0YlJZTjFTcEVhU2hVN0J2QVF3Yzl0R3RwTDFIaU1QQmNXT1NEQWps?=
 =?utf-8?B?Q1RONjVmT2hqN2FKNW9uVjZWcFZ4K2tISjVsZ0Y3czF1STRPZzNxUTEyL2NC?=
 =?utf-8?B?c05VU1JtTVBPbXpoQzBuMVZoQlZaSTJWNzZRbFlYd0Q0RE9rZUdSN05GbjNz?=
 =?utf-8?B?dytSeXNOcDNNY3BDTDFPWmVQNmdkRVNQZmpQT0pSb1ZJTUJxT251THdiSnZZ?=
 =?utf-8?B?aTBKMWVlUi9TQ0IrTmFCUnJyUnRwUytkR29pR2pLRkJMWHFsSzNwcGJ4c3Zr?=
 =?utf-8?B?NnpNSm1TT3pyK29kdDBxMEJkbGljVkhRRk45SGJJeFo3OFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5402.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDV4ZE9BQWRXQ0Z3U1RUeTl1SkhBdkREVEhNNXM2dUg3eWJuWFlneENyNUJW?=
 =?utf-8?B?TWZxZ3FROEs1ZTRCdHF2djhucUVteWdYa29DS3Z5RlZvRXYvNVBuZ0lxcG9O?=
 =?utf-8?B?LzJPM1BjZWR0blBBUXpRRXFXQWc0cTkxMXBpV1IraWVCRnU3M01EWHgzbXNY?=
 =?utf-8?B?VFQ4a0JweEdLMnNqdWNTNnpFYjB2ZXlwdTkvK3hFSlFsS2paNkZZUDU0eFNv?=
 =?utf-8?B?dUVrRFpSZDFhb01qUDBtME1rV051RWlGNHRPRk00Q0RDNFF1NnJNcEFZYzhI?=
 =?utf-8?B?MzIveTdYYmtmM0lkendwZVZnS2UzNjV0RFB1ajJVL29UcllnYXJOKzQ1dEVa?=
 =?utf-8?B?ZXdDdWJJUW9UbzR5U2xRMXNKWGo4akVZTWQzSEgvRUIxb1RrcXFkbGRDc1ZW?=
 =?utf-8?B?cjBXNVNyOStSSHNKQTZIdlhEWkxMQzJvNkNXS3RmMnM3RVBleVVLNTA5M2Vw?=
 =?utf-8?B?NDQ1bnhPcHVKemhsQkMrZVU2a2FOOFhSK3BieWpraEFYUnRrY0NibXZQUzdo?=
 =?utf-8?B?REdkVHRZUjEzSzFVOWY3NEs1OGtzcDBYbDdaMjFzQTA2YkIwQTh5ZkRlOHZu?=
 =?utf-8?B?RkZtR1JidDI0VHk3TGN2ZEpPZVpwL29TdHlPUzVyLzZUbWtFMGtSVWxZd3BB?=
 =?utf-8?B?Nmw4QjhHUkhKVTJYQkJEbEQwaWlxUGtNbW5KSXBleFVuU21pTnFxT2hzakZW?=
 =?utf-8?B?R2JyLzJwSkhLV09CcWVISlpGZzdDT29acHhncXlKMldvRGJmOGNTNVJCR2NF?=
 =?utf-8?B?aVlPRGtvc293QUpZK0ZBNnRMQ1I0L3VtMEcyWmtMZHdpOUY2YzhWYi82R1RN?=
 =?utf-8?B?NHdKRUtOa3htZWZUb2RYK0tpbmVNMlJHVWRrQmQ2Y3dTWnJlN2VrQ3k5VnpK?=
 =?utf-8?B?UWtoeGQvTXh5dHYwRG83a2Z5WTVYS2hFNlEwY21uL2F1UlJaSHdiVzAwSzdh?=
 =?utf-8?B?Y0hqUnZxNGl5MjA1NyszVmRLcm9mR0V2eC84YzhHQ2JJVVh0YmllMHkvSUJk?=
 =?utf-8?B?d0JhbmlhQmpiQkwrQ3h4TDQ2cTlCQ0VQa1RQSnoxQmZVdTYvbkVqVFp5Zitz?=
 =?utf-8?B?ZmJ1RVl5djM5cit6akJkZVRZamh0Zis3bmVhdE9Qc29NcGd0TTRhTWdDblRw?=
 =?utf-8?B?RUJESnBBcDkwMUxuZDE2aDhjdnUyeFZocDJ5bGlhaG16VFNSMDNQcVpaYlRH?=
 =?utf-8?B?cnNURk5uNWZIYzkxQXNjYUpqcHk0UHRkOFZoSE1GWEJXRkZzdDVvLzFaTFFQ?=
 =?utf-8?B?UlNYRm8xejhYeUovOEVmUFhFRmZUMTZ1SVFYdlpmdFU2YjlNSzhLUXJDejNY?=
 =?utf-8?B?V05XY3owRmhVejJ3NldWTUxjbyt1eHBFOUEzVFA4aER2c1htYmRkRlFneEoy?=
 =?utf-8?B?UFFYTmdzWGE5d2ZRYUhDdlFzaVdLMnZIa252eCs3VVpkbm1xc2FaRUtmaCtq?=
 =?utf-8?B?WkhyK05VSGxvN2dmdDFZN2Q5NFhCZjZXNGpqc2psZ2s0dmoxYTQ4OEJIMXF2?=
 =?utf-8?B?bEhSSGJ6WEhLNTZuRUEwVUtqMmR1THduLzlNcGtSQXo1TFRQWEs0WVR2aW1q?=
 =?utf-8?B?Y3dXM1hpVml6WHk4bk5HY1FWZmF6RHVRZnl2UWpYT1hQbUVEaXlZSmJ1dGw2?=
 =?utf-8?B?ZXkxdlpoNTUrYzFLNWE1R2RBb0tvVjFvQjZKc2hYSHpJOG9HUlZ0RHYxNkpa?=
 =?utf-8?B?Y21wcUV6QWtUYzJsVTA2MllOWmk1T3lQWWpCWnFpUVgxeEVrandSSGZqb2VJ?=
 =?utf-8?B?VjdHWjk2dUMvL2dKSm5NVGo4bERodjJCNEx2TUl3VEJJMDNLTmFxUEVIc0t4?=
 =?utf-8?B?YVF1Z01tMisrZzI0QnhYcXJZOVpMRlZDc0lyTkFjS2FzTTgzQ1ZXeXhSQkpw?=
 =?utf-8?B?aXY1enNHZ0Y1VFhBNTQvZWt3VVE3ZGh6OVVHemNmZThtdlVCUGoxY0dCMWs5?=
 =?utf-8?B?akxNQzZXNEh4R3IxdHpQaXhFbmI3UXhYY3d1RmNYbmNKY0gvbUsyZGFiWVFZ?=
 =?utf-8?B?TVhJb2RjM0VTekthMFZWdzlMV24zRlpwNnNGbWRqRDRPMnNFTUlDK2JlR2Fs?=
 =?utf-8?B?eGkwOURLbmJpTVB2ZkpiVk43ak9XVUhrMjlvdW50Y0pSdjhUOENIblYyOUs0?=
 =?utf-8?B?VnFNdldGaFRGci90bTQvY0Zwb0JCdE15ak51UVQwMExnL1g1YndQVE9HUk44?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc32f56-b071-4e8a-cb7f-08dd1a9c65a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5402.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:01:58.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL9ZBzHCZuBbuVBQ3MKnZ60bZGZN0pbbmJhvUEcbLbpmQhKqwjaqeiWuLdi3RIhFC7xxTX01ZFZ1mmDxUhnFzPHe5xSWiMGLXPlDd4Wi8+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6274
X-OriginatorOrg: intel.com



On 12/12/2024 11:55 AM, Jinjian Song wrote:
> When driver processes the internal state change command, it use
> asynchronous thread to process the command operation. If the main
> thread detects that the task has timed out, the asynchronous thread
> will panic when executing te completion notification because the
> main thread completion object is released.
> 
> BUG: unable to handle page fault for address: fffffffffffffff8
> PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:complete_all+0x3e/0xa0
> [...]
> Call Trace:
>   <TASK>
>   ? __die_body+0x68/0xb0
>   ? page_fault_oops+0x379/0x3e0
>   ? exc_page_fault+0x69/0xa0
>   ? asm_exc_page_fault+0x22/0x30
>   ? complete_all+0x3e/0xa0
>   fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
>   ? __pfx_autoremove_wake_function+0x10/0x10
>   kthread+0xd8/0x110
>   ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x38/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
> [...]
> CR2: fffffffffffffff8
> ---[ end trace 0000000000000000 ]---
> 
> After the main thread determines that the task has timed out, mark
> the completion invalid, and add judgment in the asynchronous task.
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
>   drivers/net/wwan/t7xx/t7xx_state_monitor.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> index 3931c7a13f5a..57f1a7730fff 100644
> --- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> +++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> @@ -108,7 +108,8 @@ static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
>   {
>   	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
>   		*cmd->ret = result;
> -		complete_all(cmd->done);
> +		if (cmd->done)
> +			complete_all(cmd->done);
>   	}
>   
>   	kfree(cmd);
> @@ -503,8 +504,10 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
>   
>   		wait_ret = wait_for_completion_timeout(&done,
>   						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
> -		if (!wait_ret)
> +		if (!wait_ret) {
> +			cmd->done = NULL;
>   			return -ETIMEDOUT;
> +		}
>   
>   		return ret;
>   	}

If this is a fix then should be targeted to net and not net-next
and probably should have Fixes: tag.

