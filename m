Return-Path: <netdev+bounces-294768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c+uxGoo5IGpTywAAu9opvQ
	(envelope-from <netdev+bounces-294768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAF6388D1
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=J+DfQpZG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294768-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B404130C7D13
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDA385530;
	Wed,  3 Jun 2026 14:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DE2F361B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:19:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496369; cv=fail; b=uQRvBPujNNiEoMt5qdbRxbcSUmqLed08zGAVNXNIJcVEn5l6WaEsuv2sjKtFBKjN5iVQ5E6sYI9poVra1a98inw3hMaNpAnmO5KCf8iCvZeS1Cfz09F0IFV+7NM9+6e+B1NyPRW2rXKp+L5n3gFgJAldXpkcnC9QdGwUc3EAE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496369; c=relaxed/simple;
	bh=IwtmAwqZLaCl4MYpvxKW6PUmooDCeObDIspzSqOut74=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nc+G3IjBTyR8eTyleEsNkuIOyoaaDTQS4RktlShlBC0DmAsfYOFIyXFrzT1Gd1RJb0HVmt3kyBg7OksxtPI03Y9S2f1hKPXaCCNakwFIGFi1IBG5SZARYdUs/Z3ws0R74QWbWg9V57EV0m3cEkFcd41VwT3QIoVGCJnQOijeqps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+DfQpZG; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496367; x=1812032367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IwtmAwqZLaCl4MYpvxKW6PUmooDCeObDIspzSqOut74=;
  b=J+DfQpZGQe0c2y1zG5NU3Gi4/zCWuS7ePg0Mh5llVvf9tycZxFAxkY9R
   VghVe7xawEUIh5gK/CJCqyo47hOLfYtpDF/5ECRcECvjuwOtBQPF7jL3F
   D6tRxI8kKXC1Lx2RcrZj+K1yhgNSzOXmYUn0gRiY9t5y6/TsR4wtpMm71
   03Cg3dKMzaccfijV8uDWtiNSMsSTmihoe1JrSOw9GM1wZTP7rvJv9zKSb
   mP3ANACknbokGOZrtl9jMXmj9gXDJuB1rEYrfTiosyol14kzd1+YBj4w4
   UnKJLWHFFthKZlmNk+qvfH9+f6hj5aLM2F3qHtFjutKnnYQTHkyoYKG2y
   g==;
X-CSE-ConnectionGUID: lMG530b4RVaGv/J1Iqkm8Q==
X-CSE-MsgGUID: B9z+8W0ETy2G7+PbwNxrJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81368201"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81368201"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:19:26 -0700
X-CSE-ConnectionGUID: jSJOKPh5Spyu6GzmQ6Bz5g==
X-CSE-MsgGUID: x3xsRXCBQ7qA3iwkq8PV8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="246074276"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:19:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:19:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:19:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuGX3PcMFHf6y9QhZD4L/6lqnPr4jKk+743tN0uECHq09zVMbPxW8pZ+5W1SOYCqVJnd8sJb90sVkAcrOuIeQcMIkm6tZUUt5+fgKjp81gAXIIk89ZN5/13Q/7xkqWt+r/rxq6l70DOPIyrwHWPkiuRUmwhkAc/FVEvehuxQrnYaP71+LRYoMa9GNjw52dqIX06bakP+LMtpidCemPrX+hsbi67GnWLfo4bzlTiFnda7p6IAkPPkOJA3calEaLEYqjKvbwULjdV2yFfk04n8/F9Mzot+grJ+oVePLkQEpnP9Qqk0JGfzvOxzy/W9RqaAXNr9YOPskF2CZ7uHv8Mupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+aKQMoCwCaF2kCvsMqXAJaKF2GdQhdJGVi9xgVmRec=;
 b=d8ddCbnJowAyoEjuS1lcEX6ADE8IvrQwD9rPjy/mh0TVa4JWQqLhnhxIzSBU+wyxyzEWDHa3VKBn/fN2QjKEmxdXXkY8SmqE2TIs91T7O3AV6LKqNjYK5HmlwVj48aLRkIn/MzsWP02pZUJCSY2HM56xIEI9ikmEGsUfsyb6YiicVH7McPEFixSSMp31WdOD8ms7jp+7/gs8IWmDAnH4ToIdbr4RVtorC6J712DEM7HReCTppp3PTxyxM0jQQYN+xqEBM1HvC76CKZ9Xv4zBak46OMxe3EiNW8bFI3oF+84NVrNhDIqmCbmeHnsggF5tQlY1/avXrM5U8X9ieswZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB8271.namprd11.prod.outlook.com (2603:10b6:a03:47a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:19:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:19:08 +0000
Message-ID: <4f1a4883-695e-4f3b-8759-184fa263825d@intel.com>
Date: Wed, 3 Jun 2026 16:19:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pds_core: disable bus mastering in pdsc_stop() to
 quiesce DMA
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
CC: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
References: <20260603035245.32972-1-nikhil.rao@amd.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603035245.32972-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd224ba-5dcb-44c2-3a04-08dec17b1352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dbPnudwdGHAN5UbrKzzoc2Vl69MO0PxlMkarHIuHYCUrKVt2UNEu9vf4SKOhHwkWnSysfVgJL7MCLnWQAuJ0o5D08mCAr238ja87ZSoRfHz1FunftFOfdm7r4trhX538DCoPkC4oIcxD7iMQEeS9H6Xv7GxOgT6H/hvVzFrhZkvfNmF6wxzihW9CApoK9Bx76zBjROyLxF/q1KBm3beXhpUhiB/zGhXVIryMPL0H+AR0KHb/SrAy88ZObIAm8fRjECGjHOO0ip9bCzxvgUtaMWt4ITknJfK+Sy1hmShoCXwcjeQuYXGRmCipxc/EEEBahlIaVfBhkPG66nyvTd935GpaMKioxBL1IknRxDF1NS0xAXaHa/cJg+5b/djnH0GkGkfJzqpXST/kZO7zkejPqCqT1qXIkLqX1Crvur0JVIfSioab5Y0ZTs1LhU/5DX2DUSewZqmewGxsBYbgFKfBYaed89iDWSJ3pGMCdvHprcyXP22cNloBMbaddnQsDEgVwwXaWv+f7WCx39q9s8VBkowaDIQYtKa0aQ/EdsKZs/NmWI1nUdOrCTRYVWjf3PiD+WUeOCyHCSmg4Ix6HHR/60cRL+P0VKDOY5IWixBVGk114q2v0+SO5br0EKbw/T4soMzPC08fsD2sornGMj6VXSk5lqW295ljj8CIx6ZL1/F9M/8vD6QAR/o87ISGW+LF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNBTTEvSjh6YTd2Q21FRlVMWnhITmVUS3QrTzNLZGx3cVVEQndYUEJ5MmMz?=
 =?utf-8?B?ckVZZG41ZjZkZytEd3lkcEVSeG56ZkJNM1lqVnR3VEcxR25NUmZIT2dsdUlq?=
 =?utf-8?B?VGNLVld6cm9hRnVMMFVHemFrMmswenVseE5WQnlnWExEdURNM09JN0piRVlC?=
 =?utf-8?B?Ulg3a1VNWWtJK3U1KzJmMVI5L1doLzJrbjdHTjMrcllLb2xYOEEzUExOOTRy?=
 =?utf-8?B?TFQ5blB1SktLZHM3VGhwbzVrUW5IS3VTZnBlNG1rYUo1L0wyMFIxOEdXVnlU?=
 =?utf-8?B?UXp1Ris5QTdtN1h4eTdXZUVYbEZVLzljVnFJNDhaTkFFbnp3cmxTcDd5VHZR?=
 =?utf-8?B?VnlpVHBPcHo4dWFTN3c1eEN5dUpYaXJnMHZ6OFlEdEZFaUlkcVVuVzY1K1o5?=
 =?utf-8?B?aGQ0WEltWWVKRlY4Q2ZSUVhMdmxMeUErTExiQ1RNZFBJZ3h1cEFWSzU1THB5?=
 =?utf-8?B?Q0JreTRjY1BnbWlWZVFMbDUyMFJrTkZqTmhpYW90eU9uN0dtbkwyQzRXZmdr?=
 =?utf-8?B?WkVGNU1NRkpHbTdFeENwQmlaNzRWYlBuQUJ1WmI0WEZUbnR5U2Ezd1J0WkhS?=
 =?utf-8?B?YUNxRGQ0bXphanpET2NkTi9MZWJhVjl0anRWK0NQMVpveEtWTVA0Kzg4eTBw?=
 =?utf-8?B?N29mNnBUWU52MGt2cTIzMmxBY0Zqak5LMnR0TDZlNklkd1pEclBkUW1xM1Y4?=
 =?utf-8?B?bHYwMGd0bmtOV2F1dytpSGhmcGwrTkpST1RYenVEU1hEd25Sd0d1SWpJSStJ?=
 =?utf-8?B?VXBFUzVrazdoNFZpN3dXYW9iUUE0bm44WmFIT2wwV3IxSXNCV1U1THpHOGVZ?=
 =?utf-8?B?dlk4WWsrQ0JoSjdVRlJVL3JhRENnT2djRS8zY0doODhlS2U2alVKSFd2NDVJ?=
 =?utf-8?B?d0JNZmFyN3l5c09FNE1ySkRvRjR2VXJNT00rUGdueW9BSUt2RXQ5UW4vTm02?=
 =?utf-8?B?V29jb2pSRHFKTkdEaEVBK2lCeDd5cVJta2FLM2Z4cjJGZDQ0SlQyWFlLa056?=
 =?utf-8?B?REtITkp0SDI4S3h2UGhBWlpQeVZoUUtwd25FMGtQWWxWdlJESHlBVFVoajVH?=
 =?utf-8?B?Ui9RTmNteDJabnMwWXEvYXAweURGRFY1Ky9TdDZnUmlxY0U2K3JLcnRESzJm?=
 =?utf-8?B?VHpzUmRYODRUeE9Qa2pwMWE3c2JnRjExY0xZT0UzU2Z0bWtHVG9ralM4Y05v?=
 =?utf-8?B?aTF4QjZXSVY1S2hSUHRQbnhLaXBoYWpQMUxtMzZNREVZUTl3UEtubDNERVpR?=
 =?utf-8?B?bEd4eHg3WmJocmN0UWRXNU9RNC9pTGplYzJ3ZGltUi9MUGE2NmpsV3JKT2Ew?=
 =?utf-8?B?WlV6dXE5NUxnbnBJeHNFdTNYdGVEd3o1c3VLd25GaFJIdzIyK2xvaGtLdCt1?=
 =?utf-8?B?OXFIY1dxZnRWKzB6MndxVmVJWXYrNHlZbTBvQU0rMjNsY09pajM4aEFMVFMy?=
 =?utf-8?B?N01oYy9ZTXcrMkNCZnhBU3JlLzREWXF1UGhFQ2s2SjZVWUlqMkpJdGZjazhY?=
 =?utf-8?B?MjJEMUhCa1hpK3FWNHg0NlExdEhXM0svelhnUmtEVEZvS1RMMWxhL3p5cVVt?=
 =?utf-8?B?ZzJDV0ZXWVYyNmdWUzg0VGxua3hsaktiTm9DcU04VjhCTWhnc2NuaGZLWVgw?=
 =?utf-8?B?bjJaYWV2K2lPeTA0eDNIdmdvZkd4SmMwYUVqbXlMWmlDTjE0OEZzbUtwUFFt?=
 =?utf-8?B?STdya01JRzM1VFp5Vlc2ekNINHFtZThYQ1JBckhUOXRmSG1relgvY0xoM0w4?=
 =?utf-8?B?cEpuQXVaR0JpVWk1TE16ZCs5OCs0YlZKcGkzWGZZRzJabjRGWXFCUklxRGhn?=
 =?utf-8?B?SHZIMHRERmFiSDFxREIxWS9YQ1o4eElNeGQ0RXMzc05SdlZYSFVyRThIWG8r?=
 =?utf-8?B?aVQ3SVBwT1dXUFBoMWVPS05rMFlCeXB1eVdXN3l1WDVGM2tYYWxvN01jZlAr?=
 =?utf-8?B?TDRJaGN5MDh5VzluVnlwaU1wLzN2RWgwMXRXaDgwenVBT1VCNTYvQndTajZm?=
 =?utf-8?B?Rm1rcXdlaVhRdllvOFFWT2NSZXpOUG1hVWF4UnpzeXJzMGRza2REanpiK3NU?=
 =?utf-8?B?SFdacUNrdEoxdDhZTTRJTi9lNHMxZmdBOEtSSTRWTG9YMTFIQU1GODFrZXRZ?=
 =?utf-8?B?elZTcGlCMnlyTXhkS3JzTlV3OGRaMnVlaWNKd1lmaUE5WklMeVFRMXNNUUNj?=
 =?utf-8?B?eEIyRE9tUlJIeG54YXV6Smo5Qkl3bFEyN3JnaGtnZWFYZ1U2elZMRS9Band3?=
 =?utf-8?B?Rk43a0psaitKR1FkUmZlTTh0ODdPbVVMQk9SdHU2SGk2L0J5RW9GUjZMcmsr?=
 =?utf-8?B?WEhKcmF1bENqZVFXQzdLNmZITHJaSXNpdmxmOXJlMC9jbnJJdTlqdVdxRHJw?=
 =?utf-8?Q?6WAcLlExkahPo6UA=3D?=
X-Exchange-RoutingPolicyChecked: k5G4A/BbUrOBWeBaAZdiNrOnbdWYurBeF3XAGP+h1JnTW9wx7gd383YdQ8SzAqClTXmg+a8Q5omdRAFc09OlZGBg9yJMo6zIE1iGHp5SAiwSdm9asL6LdGrZaS0zl6SSylCRior+3OqoHeNGWHxaMySzeVbH/+ORSQVQkJJ/q829NHcsxOVg/ljq6eI7hJbnXUqb09FlVC4LM0YRt1kd2nvBbehwA4XKeFnn3zejgHtDs/qXTdM6c6iFHkjl7KIEbKr1xhAAIeLdC3EZ6e96i1HQDLLihoGP32pmkgiKRTKqJ38FxUYDZXM5lAC2q5U3y/LzlqBzFiMHHEHbASEhWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd224ba-5dcb-44c2-3a04-08dec17b1352
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:19:08.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEq4VjavtizmtnP5Jrm5WJA9N6H69yXx/uPpaxnTgORsA2Fn4EF2TCsfPG8by7HHIc9MUEpJM83MN15u4E2NNWslWkhIpx81rpi2h6PPiQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8271
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294768-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5CAF6388D1

From: Nikhil P. Rao <nikhil.rao@amd.com>
Date: Wed, 3 Jun 2026 03:52:45 +0000

> pdsc_stop() masks interrupts but does not disable bus mastering,
> leaving the device able to perform DMA after the function returns.
> This can lead to use-after-free if DMA buffers are freed while the
> device is still accessing them.
> 
> Add pci_clear_master() to pdsc_stop() to disable bus mastering after
> masking interrupts, ensuring all DMA is quiesced before teardown
> proceeds.
> 
> Add the corresponding pci_set_master() to pdsc_start() to re-enable
> bus mastering when the device is brought back up, such as during
> recovery.
> 
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

One nit below.

> ---
>  drivers/net/ethernet/amd/pds_core/core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 705cab7b0727..27369b3297b2 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -494,6 +494,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
>  
>  int pdsc_start(struct pdsc *pdsc)
>  {
> +	pci_set_master(pdsc->pdev);
>  	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
>  			   PDS_CORE_INTR_MASK_CLEAR);
>  
> @@ -504,14 +505,15 @@ void pdsc_stop(struct pdsc *pdsc)
>  {
>  	int i;
>  
> -	if (!pdsc->intr_info)
> -		return;
> -
>  	/* Mask interrupts that are in use */
> -	for (i = 0; i < pdsc->nintrs; i++)
> -		if (pdsc->intr_info[i].vector)
> -			pds_core_intr_mask(&pdsc->intr_ctrl[i],
> -					   PDS_CORE_INTR_MASK_SET);
> +	if (pdsc->intr_info) {
> +		for (i = 0; i < pdsc->nintrs; i++)
> +			if (pdsc->intr_info[i].vector)
> +				pds_core_intr_mask(&pdsc->intr_ctrl[i],
> +						   PDS_CORE_INTR_MASK_SET);
> +	}

Could you add braces around if since you're touching this anyway?

		for (...) {
			if (pdsc->...)
		}

> +
> +	pci_clear_master(pdsc->pdev);
>  }
>  
>  static void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)


Thanks,
Olek

