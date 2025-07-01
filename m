Return-Path: <netdev+bounces-202820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2DEAEF246
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0324A26A0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873E26E71A;
	Tue,  1 Jul 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/fXIN8R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53E26E6F1
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360334; cv=fail; b=mwjqN2Cm7arZOoLYZ4yrBiCSOLfvbJNBewtS7NdFJyf3azN8kz0bI4mZHC4HuxAlxN04pHyiKCec+Qp6Ad8yiBCFv0vE1fC6I9Vb4kdD6w0BvQa6V6w9PW9qz+hhFiChNojyxa1efoUyV2PXkpQ7eGshBJJBwcXnoecZtrEJ3rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360334; c=relaxed/simple;
	bh=IJpMjNTBI3yCWauv6qXtffJEv1AWGBXynuacexrb+0o=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Gw8X0pcWi8LfXVfwgz4xHVfJ2GijXWGXFyjfGVKtEaHZaY9sqfY6ngjakYWQfDVi6hhD2wG8FuUrrRQR6QOJIBHyJyYwGle4cZOwn1cPLv0E/sqHSZ45q4696gbcOqsYfLPypZM4AnFxciJpX6zmZdMcU6PjGG2GoDqoNvwTxMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/fXIN8R; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751360333; x=1782896333;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJpMjNTBI3yCWauv6qXtffJEv1AWGBXynuacexrb+0o=;
  b=h/fXIN8RtgqOpE/Qww6zjlUL2/OjEEM+lG8tV0HMmlP05HpyLKz7o72h
   bc+9i1SNiPKAZ0Ji4UyUtuCoTaFcvEpjhnxZ2JC38CT+bF/fCXVLEl3wX
   PSBNRIYbrIfOdnlEzeomgmx9mWkCXgapQhtv1pXV+doyQLTceMOl02XNH
   hqgTl3M72rLnYCRtDskCOMCp4FhlDGE7RCqTFrABKscwsqwm1tepkVbWS
   XDojqH4kkPZ8J/IbU34v/34EOfMLLmTJ7a2KLU69sENMNE3bqU1AJGK08
   b5X4oFoyLFoWTS/w/oaWOv4NpGRJBKeiUWekoC54AdQTkaLtOjRkjdAVa
   w==;
X-CSE-ConnectionGUID: HI6Tvos3QFeEHRKi3k/Vpw==
X-CSE-MsgGUID: LMC984DgTImGRnu7ZVCR/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53739217"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53739217"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 01:58:40 -0700
X-CSE-ConnectionGUID: sSk5pHy0T8Ck+665fAeQyw==
X-CSE-MsgGUID: UE7fukmwRAaNpFGYIiKb1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153325505"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 01:58:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 01:58:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 01:58:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 01:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFGYpcEGRwUgas+MdPHyeHG+nEzrl2b7ZyiX93vq1yxgmzWVQrM402hai2mFQ4t4wfFS5jLin7UpgljhSMnbfYg0wvbtjaXJGJfmyH1qLWvG1XDX5xzObkcQkGOYQmxEEiXcLS83QQxP4reIYwDKIzWPq2VsYYuc4fHdTCiiXkFdPr15uTQfKr5412f9JoTwndIiEEQtsgFEKJXGf8oTo9Y97D0JAsL/f4drj0v+IJpTvkYbjxx32ceNvxXTl3FroJ+86dvvraBK2JbSGOE47mb4V3i7Tlp+KQsFLACs0MTGxuH7U1oYM83VCKR848DGno5bfQRtJrb04mDFwOwSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ3qD78IXRHM8BIsGBo/FgKaFowvpT/ZKyDyRvWwg7k=;
 b=gWQKJov9Bl9AwAX+s0HpPl0sSCZ8uxFd43H27vIGiXG0t60KJmgBSJoJ2WKpESmyok42K1gijVyzCphcuaBCwVnnV+5PW401dxakIvblBDCXLtu0hePn3NPlq2x9gx69zCJoD7P4Gc19Wj8AEqm5YQwCzORQr3UUyVO63o8xNuIpmRYre+rjTFWcW3UtEKnZPzdQRnxKjvtTTqLIfVGNQBo0pPEfeIn8HTfky1fW8CzZfDUsFG7SC9KUceijCDiNu5Bm6pkDXdbmuyiWsP6Kr/H2aXqc3NrPwrXlJzlO5wL1XbOZMdN2bwtJ4niGyU/AKS+Whr6lyVzCb/9Lkd9EBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) by IA3PR11MB9063.namprd11.prod.outlook.com
 (2603:10b6:208:57d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 08:58:36 +0000
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::a82d:bc86:12ef:3983]) by DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::a82d:bc86:12ef:3983%7]) with mapi id 15.20.8857.026; Tue, 1 Jul 2025
 08:58:36 +0000
Subject: Re: [Intel-wired-lan] [PATCH v4 2/2] e1000e: ignore uninitialized
 checksum word on tgp
To: Simon Horman <horms@kernel.org>, Jacek Kowalski <jacek@jacekk.info>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad URSU
	<vlad@ursu.me>, <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
 <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>
 <20250630170034.GM41770@horms.kernel.org>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <5e880e1c-2ee0-22e7-8bcf-3ab35280db47@intel.com>
Date: Tue, 1 Jul 2025 11:58:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.1
In-Reply-To: <20250630170034.GM41770@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF814058951:EE_|IA3PR11MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: e54404d7-6ecd-4443-ea7c-08ddb87d7703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amRTWUgwOWkwUk9ISmMwU3JxRFBwYWJvUEoxTkF0eDl2Qk1kMTE1cUNKZXY1?=
 =?utf-8?B?cjNEUHF3TmdHSmVoTkNPdTVoVTQxOWJTdnl3VmRGblkyeHgvTUtyRjFnMW9N?=
 =?utf-8?B?c0pGelN2dU9NdWdyQWErU3BKanBwd0dKa1hKanNKTVJ5b2VrRnFINHRCajZU?=
 =?utf-8?B?c3I2NnZJTXFxaWt2U3ozU045UlR2RzdDZFZ0VnJSZkFHREZ1TDdFbDFLdVpw?=
 =?utf-8?B?UENzL1lHVnBmUmZnUFRkSUFUUnViZ2JtaG9tL01VTEdqdFJ4dVk1Ni82WFI0?=
 =?utf-8?B?dDhJUzE4NkxvVmpnWjJMRE5HdTUzM3ZTdm1HT083enpRSklhVXhvdTBqMjN5?=
 =?utf-8?B?UGRCeUNXUmhWZTBHWUVydFJZZ1orVmxVSlVOSFRhdmZtbWg4ZnJ4R3ZHMHc1?=
 =?utf-8?B?dEdPMFRxbVIxaXcvaVdRdFdlUFp1QjJIM0l6a3cwSU0zMzI4cjZraW5sQmRH?=
 =?utf-8?B?TEFzN05HdWoyMXI1RnNTOEtHWjZ1WDNBamdWVGY3clJWT2ZBeXh2U0tmYmhO?=
 =?utf-8?B?a0F0eDFyd1BkbCs0QllZcE1ESFJzZGZ4M2RuZ0NJV01nTUwvK2s2OC93ZDRu?=
 =?utf-8?B?Z0tlL2V2SW1rRG44ZGEwQVBTYmh5ZDZhbFc3aldLdGl3UlkvRFJLdVdvNFRX?=
 =?utf-8?B?WXozNllHV3p0cldqaStTS0hkT0NoQ0JQNkdJakticXkxdENGTmROV2RsRWNY?=
 =?utf-8?B?WmhuNVZIZEhzS3QyZU1YZFFKQjZNbElQNXN3UkxOUXpScDZ4OFhRK2g2WTJt?=
 =?utf-8?B?MXV3eWYrMUs0MVJ0aUt5MUhhaVk0SjlzSVB1OXVScmdIZmxYN0UyNW5ZTlM0?=
 =?utf-8?B?ZGtzK01ERXlXMnVvclJJM2RFQ3NRcVJoV0RnYUJUOGpOL3hJR3pxVUhpeFN3?=
 =?utf-8?B?anhxbzc0VlA4UTlHRU5uNlRnQWxYYUllKzRZcElqTVM4aWora3RmRVM4ditk?=
 =?utf-8?B?VURORThUVVovMFo2ckFaTUFDd3ZMVFlETFFDRTdIelRZUU9CeTA0VUJoRWhM?=
 =?utf-8?B?dmRPZTBobkNseEpGdldlS0RzK044b011RWRNemttTmJnRVJBSmpEVk5YeVB2?=
 =?utf-8?B?U09MbnhLb3hVVldwVDBhUE55cE1jQ1FUTVpjYm5wdGR6ZkoxTlQ5aEc4L3JS?=
 =?utf-8?B?aDc2a1E2MmRzeFNpcVNTOUJobGtZOExWdERhbGtDVGdGdDRLOGFoazBnd2t5?=
 =?utf-8?B?V0VMV0VDY3VOUXB0M3MzcGFoM0l3UHlGeTRlc0xmalNUbmNneGs4TXhnQWs0?=
 =?utf-8?B?eElxT1EwQlplanJFMTFnYjVmeEp5K0FwMHpyYjd3cUFQSmRUQkE5YVkwNmdt?=
 =?utf-8?B?OHFmam53Vmg1Smx4SkpGem95Vm90M3hxZjVjVHFjRmw3dkp5bWdDTDZwZDN6?=
 =?utf-8?B?WDU4Ti9pL1ptYlI5UG9PSk5lVHdZbGxIUENIMTdWMEpaSFFYNlZwdjgrVzl5?=
 =?utf-8?B?RHdkVkwranlyRXhRTFBHQ0xyVUt1WTR3aG13M0F5bG1zSFNzbllNYjBad0Ns?=
 =?utf-8?B?Wnp6aWtPTHhaZ0I0Q1VpRmpxbEl3U0NwOHhhd2IzcGJ2djgyNjBPYkpWRC9E?=
 =?utf-8?B?RHpZQ09kRjJMbStXNVIwS0t3RFhMdDZvak9JaUFOK3VMQnEyS0hEb1VxaVdn?=
 =?utf-8?B?SXpXOXhBU094MXhWM1B0cmpqODNuYmprNWdoRkFINlVkU2grQllLc2lIRVNz?=
 =?utf-8?B?TFQzaVBIQWVvWmhFb0l1RzcyeXl6ZXVmeTA2dGVaK2NLSUlKYnliRXFtMVJi?=
 =?utf-8?B?MXVvVHVzQ1VWVlRNdkpXaDZLMDNFUHpTQmMxL0hEZk5OMkZ6WCt0eDNYeHhy?=
 =?utf-8?B?N0hyK0dnUE83MnJsNDd3T0d1cDFWSnRDUFRWSWlmcTBpc1E5cStuVmxHRVZS?=
 =?utf-8?B?RklkSjBGQ1VJTFkyQmt5WTZVQWpGeDZMaDUwM0JjL3hzMk5kcWdXSExDOWlh?=
 =?utf-8?Q?Yl2ZNqrSzKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF814058951.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDUzeUNSMXZ2ZUYrc0Vvd3dXbTNaeUY5RDVJczBMYTcxdXUxMzNabWtIaVRx?=
 =?utf-8?B?U0FwZWJRN2FFNVVHcEsvNzR2U1FRUjgza0pQRyt5ZXVTeG1vdFBFTUZQVHFJ?=
 =?utf-8?B?WmszYU1FRjNoZ0wxY3FKVzB3aEwrMkhxemVqMWVDMFFWVDhkSE5rdXlhRko0?=
 =?utf-8?B?YkJtYWlSY3F2Q0U1SThkNllxRUFpejBGaHlSZEdBR1hKVnUrRUUxZ2xqTDlK?=
 =?utf-8?B?bXlxaTNhcTYrM1AxVzVxZWdhc1A4Sy9pSXlXMkRlU0RZTDcrWjFnZFNOc1Iy?=
 =?utf-8?B?WDBPN05LbWJRN2Y4eVhiWS8vTGxWN3ZPRWZhUitKcGlOZlBqQjloTzBPbE5q?=
 =?utf-8?B?QWdoSHFIQS9WcTBXVnNNRTliYnNxMEZHN1VSVDRKZUZpZ1hqMUx1eGlRUU1W?=
 =?utf-8?B?WEE5L3FUU2pSaXNsaGtIMVdRejVwdTdjTFhESldlZjlDalJFSDZhVk1Gd3JV?=
 =?utf-8?B?dVdBQkpyV3VXOExEWmZUV3dzVjlvVzB0WDBLbFUxZVlLNUIxNVBHYjY0SDFw?=
 =?utf-8?B?c25BeGI0aWJMbXE2Y2Z3Z0JTQzUyUzdPTEJDeXVuSFFjYVlnUlEwd1cwT2Z0?=
 =?utf-8?B?OWxIOGhML3ZDbHIrN2w4YTFVS2pMUTB4aXNOK28rNGhIbUtYaG5EQUJ1bGh4?=
 =?utf-8?B?dEtZQzF1ZkVOMmFnL3hJRXNNc2NJakVvQVFoTzBnOWE4czlRRmZMT3M3SGxl?=
 =?utf-8?B?NW81TnYrTjRkUUZFS2JxeDBmdW5JdlRGTlU3VDVHOVluaW8zbHVlTTgvRlhi?=
 =?utf-8?B?U1JHQWZ3eDlDdnJUNEpmTmxxQjdYOW9OY1JWeHlVUWdqbUx4ZTZpOW5xNmt3?=
 =?utf-8?B?b3lkMGNXRURsNDc2eEt1V0daRnk5LzJ4TFVReXNmYkQ5V0RvNnd2OSs3aUdx?=
 =?utf-8?B?eWtWTUNESmV1NzRJVERUNkpFZmw3WlZRdlJVWUVCRmVjU0gwM1FiWWJiZWRP?=
 =?utf-8?B?WU5DSUVWUzZBbC9XNHFlaGM4aUY3cy95L29zTWRML0tuY1k5WEpTYWdaK25m?=
 =?utf-8?B?cm9oYjNvMStjWVRYSVFOamsyWVJETUloWFkramxMbUwzRGNjc0pHYS9oSWJx?=
 =?utf-8?B?TGpPU0FETG1IVk9HcGNENUczenEzYm9FMjk4NHhaYVJmUlllSlQ1WDdMWHc3?=
 =?utf-8?B?elNYTzc4QlhhWjZEVTlWOUhXNWhvd01hOUNtQlpCQjdBVVR2aDdhRm9rN0d4?=
 =?utf-8?B?WUtCOXdRYjR4Sys2eDNjK2ZwODlwTjdnK1RuSXZWZzA4ckFxUHBCSEEvTnZ3?=
 =?utf-8?B?SHJ2UzdZUHEzcWUraTdGK0kyZ1V3TlVEczQySUsycGF2ZUNqOTB3MUtqU2dy?=
 =?utf-8?B?cTA4d3g2RTllZkQySDI3M0lWK2FlRzZFVFh4TDhBYkpPaTh4RkRsSjlTcUti?=
 =?utf-8?B?T2dFb3FMdkhjZlNlZXpwSmVUSXBwVmgvR0NrWWY0V1lwaDdRUHl3N3lNc1Bx?=
 =?utf-8?B?cnBkRHhhVnhMMW5VVnhBeVFtU3FudGxra0RxU2lwNFpaUW40RTIwYkFoU1pt?=
 =?utf-8?B?aXQ4dXdKdzJrNWQrdlIwbTZ3eHFvU1Nzb3JQU21NSjFJVmJMdWxRMmJVU2dB?=
 =?utf-8?B?NmJlZHFWdEhRZjRLQ1gxWENqcTlpRG5hWWY1enhhaUkyb0ZXMnV4SE4zWDFT?=
 =?utf-8?B?amsvYm01VHo0bTdvL3BBYTE5bHpmR3NGdXV3eU5Vcm0ra2IwakFuR01MQ0RQ?=
 =?utf-8?B?OW1jaEZIUVhuK0ljNHJ2ZmNQbE1LeFVrTm56RzFSWDB0UU1LNy9MaXZ1MEJV?=
 =?utf-8?B?Z2ZMWGRFYnVvaDQvdE9CUzU4VThBT0ZDTXpyb3hwcit1VXlqVVZQTm9IeVZI?=
 =?utf-8?B?OXBqbzQ5QTVNZGdGcmRDZ3dKWndDd2FOYy9tTWRyREV0ZXIzMUsvUktOSjdY?=
 =?utf-8?B?dWxrM1lDcDByZWk1M3JheFFPaTF4aVdtVzlvVHVGZ1IySGppMHhSUkx4aVdv?=
 =?utf-8?B?TXRBVkk2SFRZTFNWaThQTFpBTkJaekFHZUFBMnltcXRXYWozeEVnWlRsZVJ5?=
 =?utf-8?B?Z2NHM0VKeWhKMG5QTUlYSjJmQ25BMDJydDRRODBBMTExem1jUU9mTzR0c3M0?=
 =?utf-8?B?OHA1ODFUanBjQlFjVkhwZDBxMnRNdGVEZjYzSHQ4SUVVVDhFVGo2OTFXcjhx?=
 =?utf-8?B?cmxrbzFwSzgraHREWnJRYUdmLzhKNCtOc1hHSXdBTkpMWlZocm5UWElBVGFD?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e54404d7-6ecd-4443-ea7c-08ddb87d7703
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF814058951.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:58:36.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQzB0kPICinmR3Ji0MliWYpukeaXjb0oI7MqJqylh/X1sIdAw933jCJeLvBNLUjJC4ytc1r2NBDWJrrTxE83AkcE/h3uu0OMdPc4LBAP2fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9063
X-OriginatorOrg: intel.com

On 6/30/2025 8:00 PM, Simon Horman wrote:
> On Mon, Jun 30, 2025 at 10:35:00AM +0200, Jacek Kowalski wrote:
>> As described by Vitaly Lifshits:
>>
>>> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
>>> driver cannot perform checksum validation and correction. This means
>>> that all NVM images must leave the factory with correct checksum and
>>> checksum valid bit set.
>>
>> Unfortunately some systems have left the factory with an uninitialized
>> value of 0xFFFF at register address 0x3F (checksum word location).
>> So on Tiger Lake platform we ignore the computed checksum when such
>> condition is encountered.
>>
>> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
>> Tested-by: Vlad URSU <vlad@ursu.me>
>> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
>> Cc: stable@vger.kernel.org
> 
> Thanks for the update.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 


Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>

