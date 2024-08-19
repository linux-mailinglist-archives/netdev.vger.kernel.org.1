Return-Path: <netdev+bounces-119692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E85956A1F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737DA1F21C36
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617816728E;
	Mon, 19 Aug 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnHExaA6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23E166F0D
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068732; cv=fail; b=Qn5vEFQG0mR3io9yIzf4hZRBN9bca3jEfhFEyoSSDak63yw12PlM1TZGqtCXJawLzi+ZVmQaDeW6s7ZkQ2Z77fr9B62DGH7kKeFVkFuyAd3rHlPa+OcXLTz71ZKiUnihyuC6lu5OYFb/ctsUMNjW2Lh8ghfMtzB399EWIHKS/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068732; c=relaxed/simple;
	bh=+F/zfKkv5hKWFzyCKphsFIBdtpsUQ4YPQcTvSN7WzEY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EfRef3i+GtRWh58EgeOxEXaTTEFysVHeWEMYWUTToMdNNDoPHG9+DctfOOX5ugk0mh6u+H4A7u/9Yz8BAX7EOla9lTif2OldC/qrS93NmErjFxmE6auuHKQym0+eTBtMGJQvaOsECknyXb1ByBGW+TsN7tnRZyD3x7ikQYx6cAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnHExaA6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724068731; x=1755604731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+F/zfKkv5hKWFzyCKphsFIBdtpsUQ4YPQcTvSN7WzEY=;
  b=TnHExaA6d4bKyPXLVBk2tyYgVwFLqE3SfrLmf1JuOESASoMUCpWH0X1F
   gR9glsNfUdRveO++pybL9B+fIa/NDJXgNFvuMpwaL1k0IDCC6NZR8GBTa
   EExBxzJSSEqB4QQt4XES0gkH+CdRPN6KlZotsjC+N0yTebv5l/WMWooM6
   NL0wRgoflSEI82+5uDTcajtvXGnXAiH5SbbitUPw4Ic7eyQ0Q2XwLwOV0
   N/hJpUF9wwmQkc/zq/y4LReBC3jcR7qdAjMS8i6BEdi1Y2wh7ee4uSkU+
   UTnFe7wcXSqDZr6/4XFX/pGIJ329sQBQTDNvum0veJTXoIU7foNrCgWCG
   A==;
X-CSE-ConnectionGUID: rs9X0OupTxG4FTlxBvHtRw==
X-CSE-MsgGUID: cx8l2AufSZ+LWlU1Qhizww==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22482934"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22482934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:58:50 -0700
X-CSE-ConnectionGUID: tFqDAXpTQCeIsCY6bWkxkg==
X-CSE-MsgGUID: cXBjCqMCRhe3m+orD9WOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60327698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 04:58:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:58:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:58:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 04:58:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 04:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOssFK32BLYeRrcz7qylX61H3n+Na/FG1WxUYCLZb8BqwgZwzGScQ7qrEzHsP11+mkawNHXhmmR9b2/xQX58vbDct0Nj9YVN9SSIJPd9aa1/Hnyojb6Ugxeg57xO8vhMf2wTxIcOMhQU3tWjG+hOV5KZTJhQmpLu+TnqPPqEMMfqgrCrFttMKxBQfIOTSfCQF5BaUqGDAyNtOLppRdklgjshfVag12R12scvweU5kdef6Y/mT1ztCvMZfptCmGCJQqCd1wJawaT3/3Pz2oHTE1McvlQuWASswGFEhcLWzVz2crww2RR0W/fKTUmBAGd16754gC+kpkuc9nwSsY6tXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n/+I6Y1NVduqz0xEDlIzOm/N1RfG/Xt1KkVbhSmdxs=;
 b=nTO/qr32brXZQQD8jdHle1KWN5ZktZrLoBzFaacL98TzMhxYLw+KR5pw7WseCVdl8N5tW0bA0Mh5KAZVgY5hkw5nXtxtfUQkN776MWt3GApt8mwplJWgu/ao9//FxXbHn9SBjgLjqyuWCv8b/LmgyVHR6B/PR+/KYKL/rySTPtJwuBzj+Rv9GLzvDuSWtxa2KD+xm9gOQVXCeWUdZ56W9WEA3Hx1zJHhMkVGdam/BEihLRuupOJf0wnFHyMvNvaOV2JaTxU1yEKQyd/LyuyMu0NcFSazcNOnDH0xpwk1ZvVTLmgvhnfpAjQb7zp9TS+06XkQfd9dEMxsf8N37TrYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Mon, 19 Aug
 2024 11:58:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:58:46 +0000
Message-ID: <33cd92d1-5d54-42d9-9e01-7c633543bfff@intel.com>
Date: Mon, 19 Aug 2024 13:58:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II: convert
 Tx completion to libeth
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
 <20240815191859.13a2dfa8@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240815191859.13a2dfa8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0139.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c25bfe-fb17-470d-500f-08dcc0464778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3lTSlRuVUlBZk85MzhYck1Qem9xanB0Q1dXN2gvaHArOEFpZDArbERHQ0lr?=
 =?utf-8?B?aHpjcjcxOHFTV2JQbGRIdG9aa0QwSFZjZG5iSnFHQ0ltWlFQODVrSGNLdWts?=
 =?utf-8?B?dHBKRDlrL0hscHJjMG8xcUk1NU01WUhoS3pKOFRYeHNiQVpxOTFvcDBEd3Nn?=
 =?utf-8?B?NU55aG82U1RvTW1LWjdSV3ZmMGFhN0JlNjdBaGRjS05udmltWHFXcStmbnJq?=
 =?utf-8?B?alpzVVV2UlJkUXpOeFNzVkxVVTlVdG1CcUdvUm1yNHZpRjRHNllMMnV4MzNY?=
 =?utf-8?B?MDFCajRiSmtFbVMyTHE2UzZSbk95UTNNbUlESHVSN1JZKzkvWXFoSnUzK2ts?=
 =?utf-8?B?R0NOaHVZSVA1RUk1QlFCVC83OU14eS9OZlI4cUFXZ3ZBZk56NjJZNHA2eFZw?=
 =?utf-8?B?b09sSC9RcXZaaUJ3Vy9zVkVYRGdJcWxEUDI4ZndXcGovZEdTYVRlVEJpZ1hG?=
 =?utf-8?B?eGRSMVBPeXNkMXYxQ3pQTnp3cGM2YTNleGRuMituSmdPSy9uRWp5VmY4Y0lj?=
 =?utf-8?B?U1FLWWZ0bTBUMHBWM1dNb1IzbDludTY4Qjh1eFQ1NTJ1eTBmMjNPcVJPQUlD?=
 =?utf-8?B?bWg0L1JvVFpUenYvbjFxZmRGNFdTL3JDQVUwTUxKQ3RjUm5pVkJVWm1vNGlZ?=
 =?utf-8?B?OCtUWWRWTitCaHhKb3FPWHVBTGtFNXM4S09XTjBud3dyay95dCtBV1kxUmdy?=
 =?utf-8?B?UjJ0UExKZHhLRnZKRWxRL1ZaR1VtRWszWHh3a3gvRjRIbUxaakpUbDR4UHA5?=
 =?utf-8?B?a0pEY0w0UlR5TlhSUGFTc2VHdVNTU1BTRzFadXJ5NU1FNUVQZHBETHU3VExp?=
 =?utf-8?B?dTUvc3Y2SWQ1YXBCT3BCRUV4OW5QMXBPWm5ERkFMQlI4bmN3R3dxMXdmMmFT?=
 =?utf-8?B?cE5Sa3FPWDhOekJwSDU4NjZML2tocDZmSEx4ZzFwZGQrRDduNkpCQ1dobDlw?=
 =?utf-8?B?MHVwRjBIMFFhQlY1b0hnWFd1UThjMk9IcTkwb1F0YWxWVVdJVG9PR3k4OWUx?=
 =?utf-8?B?czZTa0M3eHRyaVJZRVNaZzdtcUcvdTdvS0ZwYi92WlpkTko4aTN2WWF3eUwy?=
 =?utf-8?B?Q1BDNkt2UjBwL1V5NGRYOEt6ZHpPTml6SldJODh3SloybnlBNG1ab2x6TEgw?=
 =?utf-8?B?R3phWnZjS3JwMkRVU2E4bHUrZTZLdCtrRzcyRWhzS2hmYWJ1eDNmN0VIS0th?=
 =?utf-8?B?MkJPZW9FM1psL2RKV2FTWEhCVEs0ZjZrdVZhTTFFenFRWnoxSEhJMlFRVE54?=
 =?utf-8?B?dGdSVVRVUEJ2WkduSlAzZU84akRCcmxDK1V2MzJhdGxTeFJyS0FDOFZVLzNq?=
 =?utf-8?B?OVV5QWordWg2T1JYemZDRUluRlJJOUdKbHdVTTUycngzR2hHOEpSeDdCbFpp?=
 =?utf-8?B?d0RLOW9ZSW44bVV0YlhveXhndlFQM1I5ZFptOGhmb0lsa1locVdWZmEwL1Ni?=
 =?utf-8?B?SHVQMWUxVmtkMFhIRW1PZytyTWc0aU1RY3Npa3o0NS94dTU0UDhmdXdGRzF0?=
 =?utf-8?B?M0NPOGZzN3NhU1BwSFdMenE4YjN3aXNtNGZrZ1M2d2hHdjBGY1RMUWRKZlpM?=
 =?utf-8?B?RlRVaW1LZ25kOXlXd0pEeGlNbDRNN1NXV3FmYksyd0dhNk1vWDgrbGE1T3R3?=
 =?utf-8?B?QlM0VG5JMExibmsxeFJkTTV0RVVXL0cvUUY2dG9US2JSeUlrWGg2SkluVHlw?=
 =?utf-8?B?cG82T3FqMXFOb01VMXc1TWMrZWtzZDJtWDY4cFlvYkxHVzZ5QmJBOURCYzZr?=
 =?utf-8?B?UW9pTTdkQ1F1QS9VWkg0VWFrME1vTkx6Ni9ObHF0TitUeHBMcXp3K1N0cENV?=
 =?utf-8?B?TkduRnZ1VkxleXFoTGJWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDh4R3pZazIrY0dXVzVqVEFLOXlWRy84WTlzay9hdGpmUzlKK1dxSnV1S2RK?=
 =?utf-8?B?NjVPdGpiMUJJYzVRYUF3clVjK0pJVzJ4ZGM5am91OFovYnNEQU56ZTIvWDlD?=
 =?utf-8?B?aG9BV0lPVG9VeExoczUvTkZwaGJMSFcrRnE1UGM1bld4b1RMcCtoeUNyenBI?=
 =?utf-8?B?NmFFVUxFamtnM092TVdERkdPRTY1ZGtzVDRHTE1mMjBiTXorcEQ1NWpsSkFD?=
 =?utf-8?B?bm5qT2k3aFU0TFlHVUh6bWZaRTcwYVQzdHZnS1pwMHRCOFY0bWZIbGptNVpO?=
 =?utf-8?B?SGRQUmRCQ2RrQUpqdHlYWjZyUG85Qy8xSStmSzdOWlkwTjZwNUxPL3VJcjlQ?=
 =?utf-8?B?WGRGbTVhblc5bHNOOEdQbHBHQ2w4djZPcDNpNTRoRktjVnA5NE4xM3dZWFEy?=
 =?utf-8?B?K2xkSVp4VFYwZC9zQmovcGJTS2t0UWlRdnpFYUxTYm04VUx6QlgzOGtvdC9t?=
 =?utf-8?B?Smpxck5MaGFKbUoxZTc1Y0E1WGZlSHo4K0t6WW9nZ3BVY2trcVM0UlNyVnNt?=
 =?utf-8?B?TEZQZlhXWXFsS000VC9NMy9sbkNUTnZpNzhtK0N4VGpweXBTazM4M3RVdjZD?=
 =?utf-8?B?THBMNVNOVUNsbHlBdHNWV3E2dC9zaFhCeUcyTy96S3lFZFFMYldzMTNjTUxm?=
 =?utf-8?B?WUFWUGNNY3BEV3BrQVhTOUEvZE5oMklzR0hhTERObytmL3VwazBTZUVsZHRu?=
 =?utf-8?B?dzlMZEpScklLMmxpRXo0SlVTVTlNVGs5QkZNODBQSmdDNWdacGNVMXZhSVNv?=
 =?utf-8?B?Q3l1R2s2U0syb3RacXJ6QjJVdngzamZNbitmS1RNUGRXSHg1blRzYkt3YndN?=
 =?utf-8?B?TTk1UURGVWFlOEgvM3dnWW1MNC9NMklLVjg2K3hvdjFBMGpOUjdCbCtSZW5k?=
 =?utf-8?B?QzYvbE5PbFRseFB4dVFvUUYwdzlScklTTzBicllNUnJVaTErNlVRMnVUdUVC?=
 =?utf-8?B?ZTlOdVowK05XYTB4K1BLcytUTSs2VFQrS1NFQ3BPam9tZjJFRDMvd2JMdXc5?=
 =?utf-8?B?OEtZc3dnN295MGFJZXNEeStLQXAyZUtmR1Bvb0hUcUwrVC9pMVlSNnp0M25P?=
 =?utf-8?B?aWZTeFNjWTVsRjU1WG15L29JUU9veFNLaEZQRE5GY2dtTHk4SjBBdWZLRzhD?=
 =?utf-8?B?Yy9qNEVqZTFTZE5IUzNMdW41cTI1VjdSVy8xT2k3eEQyMGV6SWFNR0FDT3JP?=
 =?utf-8?B?bTB1MXRDSE1kbnFkalpWbDlYUEtVbzU0TTVTNExJSlRWWDZwQlRNRlIrbi9M?=
 =?utf-8?B?VHJXRVRYOVpNcWlPS2JyaGFXbGNxa1JtWG5RL3NvTWw3L2RPWG9mMlNGMkRr?=
 =?utf-8?B?RFZCQ2tZamt3a3pTdTBQMEQrK2xsQkRJb2xKSG40c1N3bkdjSDdwaTUrMVJq?=
 =?utf-8?B?RUwvUXBvQ251bHpXRTRNaHhISkFaeFlsT1h4bnVWbjlCWVhtTVRKYjZUOWZS?=
 =?utf-8?B?dmp0OEJ1ODZBODR6ZFZYcVJNUzNEUWxEOVBpTURLdEQ3QUhpR0dQRjNsbVhJ?=
 =?utf-8?B?VW4zdnNETEVrb25DamtBeklkTklhR29QSk1CN0JBRlVxSURRUWFVZjZObzBO?=
 =?utf-8?B?UE5lQmx2YlNRTmlxbzZRMXp1S204clRaSFc4Tkd3Y3pNZXYvY3NGTXJpbzhx?=
 =?utf-8?B?UG1VZkRicEYrZDJ0cTFwdjBXNjQvU3R5MWVBSmsvVkoxZHNpVWFabW9SQTZ5?=
 =?utf-8?B?aU1FbnczdFhUUWlFeFBhMW5mdG5IVUJmdit2cUZzaUZEMzN2bUp0d0VrUTNR?=
 =?utf-8?B?UjRYendHbnNzSVM2anRYb2t4M1RJQ2hvVHdXQ0VmYTBmenFIWmY0V3JlY0k3?=
 =?utf-8?B?N0pxOURydGFZZlplcmlhU3Q2KzFvNFR5VktaR2o2SjRYRnVXQnNPeHFnSXlk?=
 =?utf-8?B?TG54bmJrQW80RGJJeTVjY1BQSWplL2ZHNjZLZnc1TTV2QjRRNXNOMlMzUXhi?=
 =?utf-8?B?bUREV05ZMGE4L2NPRlVxazRDU3FINlhTSllBRVlnamw1OS9KN01rd2h3RDFz?=
 =?utf-8?B?SkIvcWRxMkNIRC9WMjk5cDVybldCelZicm55MWVwUTlSL3NrLy9oV3BLNldp?=
 =?utf-8?B?YWJNNExLZWVWUUJETXhYZCtLR2p1TG1XQ285Z3ltOTJNMi8xcWZQVkRaRm4z?=
 =?utf-8?B?VHBwNUVHK2FVdVdjMW0yWHlyc0hrUDFtMTdRQnhwNW95MkIvZG43ejd2Z3J6?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c25bfe-fb17-470d-500f-08dcc0464778
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:58:46.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmDtc5O0YDwD2jqLPEnx7/Qlu/FhfjQ2A880NWA8IjQcXyLA/1KvBmQOdGWr74Wabc0eozf0dvhFk0MByLV5blDom7a9rzu+2ji6mj9LrH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 15 Aug 2024 19:18:59 -0700

> On Wed, 14 Aug 2024 10:32:57 -0700 Tony Nguyen wrote:
>> Alexander Lobakin says:
>>
>> XDP for idpf is currently 5 chapters:
>> * convert Rx to libeth;
>> * convert Tx completion and stats to libeth (this);
>> * generic XDP and XSk code changes;
>> * actual XDP for idpf via libeth_xdp;
>> * XSk for idpf (^).
>>
>> Part II does the following:
>> * introduces generic libeth per-queue stats infra;
>> * adds generic libeth Tx completion routines;
>> * converts idpf to use generic libeth Tx comp routines;
>> * fixes Tx queue timeouts and robustifies Tx completion in general;
>> * fixes Tx event/descriptor flushes (writebacks);
>> * fully switches idpf per-queue stats to libeth.
>>
>> Most idpf patches again remove more lines than adds.
>> The perf difference is not visible by eye in common scenarios, but
>> the stats are now more complete and reliable, and also survive
>> ifups-ifdowns.
> 
> I'm tossing this.
> 
> Eric and Paolo are mostly AFK this month, I'm struggling to keep up
> and instead of helping review stuff you pile patches. That's not right.

I'll help with the reviews as well.

BTW can I send the netdev_feature_t to priv_flags conversion since
there's only one kdoc to fix and the rest was reviewed or should I wait
as well?

Thanks,
Olek

