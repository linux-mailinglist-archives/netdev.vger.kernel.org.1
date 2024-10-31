Return-Path: <netdev+bounces-140639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DC9B757C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746E31F213F4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB011494CE;
	Thu, 31 Oct 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWA0f7zF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48B1465B4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360265; cv=fail; b=ZMKlUX08LbKuVH0Kg3MrwOj25ChzA5565JUqEU0YSaYZJVuXAdqh/TlRPzGyIDb0KF/DBGyo5wfpfVUy7+UljMToI7h7XlFM7tHtS4ndeWhakqlPXWg6Q+AM6v5aaHrpIALo+uaBOb28Ve+2WvbsQwP52T4sCBM1Zap/AlyT15E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360265; c=relaxed/simple;
	bh=W6xtLlxudcm4/Hmp66hV576fFiTeaAmN63hfPLG6qWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nrwbrUp3w3dM1c7sVxIONivZ3HzLeiZC48sQMS2Djvvgh9ufOkVfyR6qPiK5kZYtrrD5safngvN20dIqOL5up8YEzEjWWNNRyIwtB+qnUtCcPkPqGi6Jx5sKD/SuTOVwgs4S4VBQ8C5HOMtpPYnWZIlMFUWamIQnBt45eXu2d98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWA0f7zF; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730360263; x=1761896263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W6xtLlxudcm4/Hmp66hV576fFiTeaAmN63hfPLG6qWU=;
  b=SWA0f7zF+yrp2SaasYAau+Q972m2+AXOyAIosKarXupj1a6xjGCx3u5p
   ZCBf6Qz4gsMBcHkPZ7rGffNV3F7OrAYVCU/NUXSZAng2rmoU9oyJBV1C3
   lv6MRJsVMPKgKzB7dEE1GFN2Mmzm58P0Tv4XEmGbRJJZRaMC8qBuCMnCA
   D/mMIbOVGljH1q3Xq8B3MpY5msWxorAuXklkevdVQDn1PR29EDyJC861F
   6ZVdeNmRetizxGb770u8sOU0YUUEypWZV1hsfSHeeJy8jrpKndWzXHbJ+
   PC93NBf9lhAUO1j9j7thWIsiY/V3tHwWYo/HdVcENj/iSpvze5shinIHB
   g==;
X-CSE-ConnectionGUID: WyFDyNBtSKSB7N7oOdjysA==
X-CSE-MsgGUID: XBWSH9mnQJS7LTvRdtjj9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32921828"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="32921828"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:37:43 -0700
X-CSE-ConnectionGUID: 59ts1Sv0TPqiazICIobFvA==
X-CSE-MsgGUID: 3TwRiQTIR3qxcM1iz7i6dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87692196"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 00:37:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 00:37:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 00:37:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 00:37:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxMYUjGQFYke9sArS7tZKDShnVAbCCm/xscEa17Wxe9rnmxmDVchuFFtiMbGkPBNxwSqpJbCp+3ruillxtJbRB0ntDMrmwOBvo3OgKv8aggz/FIEw7tTD3ZisXtQvh/idchuvC47PVq7qbcaqacPXBrQ+gdguGzYDzUr0y1kl1Qauy3Fp5bwD4PinoK7lQO1YCGab8vXPPXRr/u3NgCQVM84N1O7VIkfgQFW3qszE+XtCziPWlYu9JwtSpH6jfBwSlsDE6f9geoGvjyrR7Yu3GkxciUlugTik0C4cytpr/MnFKIOslHFTs9Cw1yMnTUmLW84gviSxb8qzS8hyRP1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6xtLlxudcm4/Hmp66hV576fFiTeaAmN63hfPLG6qWU=;
 b=wrnhS3iqNkQH/jUZPuZ9rQzeCjrX/dAS2ti13GEmMHxv+jTzd+v6ZAM+nLXWBC34ubOoQxBEAF/4AW7NrI1BcLQ0L68vuNCAt3nZgB3O7Aq1FHm4K6oVYhlDxTZLp4V/H5kJbTTGFv42e8j5DXPlPlfSZZ3zhs2JKRie4ylJdGIIamvvEJxyuzLk28F82w86ZaSNaXLGdpk0QQaTvTN619BnJB3YN4EoA6fVmTU07melus+0IT6Upox/zWEV9vJXwtXr8Q28l0RWJmbuhAWluGeatGc8wjeijjhFYN+mgZE+ruz+NfCtqFGKmjIpAEQuDsfsxQYROMqVf7c/o+b3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 31 Oct
 2024 07:37:39 +0000
Received: from BL3PR11MB6482.namprd11.prod.outlook.com
 ([fe80::e0f3:ecc8:5f8b:f20d]) by BL3PR11MB6482.namprd11.prod.outlook.com
 ([fe80::e0f3:ecc8:5f8b:f20d%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 07:37:39 +0000
From: "Guo, Junfeng" <junfeng.guo@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>, "Chittim,
 Madhu" <madhu.chittim@intel.com>
CC: "horms@kernel.org" <horms@kernel.org>, "hkelam@marvell.com"
	<hkelam@marvell.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Romanowski, Rafal" <rafal.romanowski@intel.com>
Subject: RE: [PATCH net-next v2 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Thread-Topic: [PATCH net-next v2 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Thread-Index: AQHa7c9eMjsHeTA790mfh4zOrvNRnbKgd3CAgAB5ntA=
Date: Thu, 31 Oct 2024 07:37:39 +0000
Message-ID: <BL3PR11MB64822BAEBF130476C4F6C9E3E7552@BL3PR11MB6482.namprd11.prod.outlook.com>
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
 <20240813222249.3708070-12-anthony.l.nguyen@intel.com>
 <506acb47-a273-4b57-8dee-2d231337ff48@intel.com>
In-Reply-To: <506acb47-a273-4b57-8dee-2d231337ff48@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ahmed.zaki@intel.com,madhu.chittim@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6482:EE_|PH7PR11MB6608:EE_
x-ms-office365-filtering-correlation-id: 8d43e66c-4b6b-48cd-2b9a-08dcf97ee5ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGhXcTJLT3U1VnAzdEtIcFEwN1hoUnNwb0o3Q2haOWFWQldhUGtKWGlwU3NK?=
 =?utf-8?B?OWN1OFZKYmxKQ2E4Ykw4MjJscSswWVZ0UFF2dm1neWRUSFJUV1NKWDR2NWpo?=
 =?utf-8?B?SUI4VUFkMERFYmNDR2s5VUZ5TVRkUUxhM2I1OFFxVGd5NGFPa20vcGxKc2wz?=
 =?utf-8?B?MVpJZGx3VWViUGUvWmd3eGlnLzRTUTZ4ZGlpY3hPMkw2VWZHRGVKdW51UjQy?=
 =?utf-8?B?VGdRK1hQUGRyWnBnVHZ1b0owY0RjMGxZUTZKOTExMUdtcndiSTVCclF5Yit3?=
 =?utf-8?B?VWtxOXJZc1Rid0YzUGdIdDZLMmlnaDJncTMvd2hTaW9iVU9kK2w1Mks2S2pR?=
 =?utf-8?B?dzBYL2xucWVwNjh3UUU0cC9iVkpKL1g1Mm45TEdwVW91Ly9VR1ZGQ2YvRGFD?=
 =?utf-8?B?a1lWSjE3RGZpR1VtZ3FRYUdMYVJTeFl3aDRFZzhBM0g5dGprUk9mRUl5c1Vx?=
 =?utf-8?B?b1BGek1tdHppdDBLb0ZUaU1YMzdVVmhQaWZhaWFkbDU2QWRSVlFWUmJjL08w?=
 =?utf-8?B?NVYvSGEzUmVVWHpqYythZm5MWGE1SDJJSXErbmRZT09TWFZNREx4dE9kTHBL?=
 =?utf-8?B?S1YwMlpwQldDNUZuZ1NVTW0xQ0VYQ0IySloyZktnaWI0YjNsRU4wdVk3WUd2?=
 =?utf-8?B?Y0QvMEFETEdrclA1TTRGK3NKL3ZMVG1oRHVGY1hTdjd6bkl0Z3pWbXY5ZzhH?=
 =?utf-8?B?NGIvb3hkVjkyUGxZRkZMYWxjaUtmc3dtQTNKZHNnWjIwMnVDRGo2UUNQY0FW?=
 =?utf-8?B?S01maTNsMUVWUCtyRDE4Y21mSWloYlRKaUFEQS9nYkZBWEUzYjBXeFhCckcy?=
 =?utf-8?B?Y1FFMEdscmVHZWNtNnZmKzREcUdwR2tXYlRiVEtIOW9sNkxLS2hFU2dGMi9X?=
 =?utf-8?B?L2RPVVRsT21iSWhCSmFabExoTU1CMTd1NmFFNVZoV3g5YXQ5QlRGNTMrTy9k?=
 =?utf-8?B?TWROdUJTVGZZOFFpaDU3SW56TExWcDlrK0p6T2orRXZoZDhDL3hqYlFzelpy?=
 =?utf-8?B?UURCUG5qY2FPYlNkam9xRGNJSnAwZzN0LzBrOWxiZnEwazRJTGVuZS9OdkUy?=
 =?utf-8?B?U1VFY3VZUU90eWtCMkd0MGQzOGQyT1Y3N2Q3VDRsbmtkUy9QY2JWNmxESXVi?=
 =?utf-8?B?Q25iMkk4V05mMXc3bkloeXNLamsyRVF0bjBZekd4dFJoMXVHL0w0UjBpY1RD?=
 =?utf-8?B?UlRZa0xmdmdyMW0wM2tUVnFnSTBaU3UzeTRlVVRMSDUwWlJkdnJnQ2ZKc1M5?=
 =?utf-8?B?ZU5OcFloK1FrSTROcFBVcmhWUjBTQW12UmpWR0ZPWktzYlAyd29CWDlDYjF5?=
 =?utf-8?B?NGFRcEI0MWNicUdwUFdXdlhWWjYwSm9jNFBWektCNzFlaXRzTVdkd1ZDTmU5?=
 =?utf-8?B?Tk5uL3JkOXg0dnZnbXdpRktaWG9rMDFsK3RVQmNiZGF6andZclpYSytlVUIx?=
 =?utf-8?B?c2UvSzF0Ull6S2hXd2dac0ZNLzROT3AvamF3UkhJVnArVFZ0d2l0blkyN21S?=
 =?utf-8?B?TEFtbGxYbzNuSTZidGd4dXl3d2xRZUpEcE1NS0NseERXNFNJaHMvRDk2MDZX?=
 =?utf-8?B?dVVPUHlzTTdmUFFEdDZ6U1VCdUNSdk13NVlVNWVweDA1K1Fpak9obU1Ld2lR?=
 =?utf-8?B?OTBtK1hQUW1EVFhyRFl1SHM2RW85bkEyOElzOGZXbndBd1NwWGd0L3Z0QkdT?=
 =?utf-8?B?UTlaVWJlVDZDOUZoVWJ4VTNkaFUwMVpaQm8xcy9VVTdNUHJqYm5Ya2JlZEpq?=
 =?utf-8?B?RzFVMEd5anR0VHZsNlBYbDVXQ0hPTy84eUJNSnQxV05xSUxiaGYvZ1MzbTNG?=
 =?utf-8?B?b1pvUXBzcjRNY3I1UElmUENoSE1sSVJRdGlGTW10NTk4VmJPZVRBOUlWc1dv?=
 =?utf-8?Q?GwnB5A7yn3lQV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6482.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNmeVBKYTVWcEIzVWt2U0VBZjZ1a1Q3aWpaeFVMeG1ZZWJXR096WmRWeDBs?=
 =?utf-8?B?N24vMElTSEdoUnhHNVZucS81T3lxVDFQUVU1Q2dJUUgzcGlzclJuN3pWZ01y?=
 =?utf-8?B?VWdtWVo0THRkVC9ocU9mcytqeTJidVlKZXRqTFVrTGJya2RQbGFXYzAxSWhG?=
 =?utf-8?B?S3VaY3pNM2tTVFdzTXJmUHp6Tzd0bEFnT0Q2anF5V25aTnRnQUZGcVlGeG5x?=
 =?utf-8?B?NFhTYnhnSzl6V3pVeVBKZzhLbnVWOHBvTzR5ZlYyMTNybXJia3F4dSsvbEN0?=
 =?utf-8?B?SmpaUDlFOEUxNHJJNVNzNmhQSlNZaHBxbUJvNHcvYlRVT3lvRzF6c3BsZERL?=
 =?utf-8?B?NG5MRnI2aS9OZjZCUU5lVWRacmZoZEF4WUxNWm1CZVhpQlBkMjVtZzRrOEdO?=
 =?utf-8?B?M1ViQ1hmS3h5KzZCeTJVbkJwVlV4bkROTVFXeWFMU05PaVlFRzBJREdGeXZB?=
 =?utf-8?B?cEd2Z243VkpDVUlSNnFjeXhCcXZIV3YxT3lyZ3BkVEltREppbmp3VDkyYmJZ?=
 =?utf-8?B?THZDeFBQNEtBYzNpa014YVQrelh4Nys3MDNzeWoyK1NHbVJ3aHdETUpPdmts?=
 =?utf-8?B?clU3WldSYUNpaVptMFhCb2VhcENnZ1dmOXA3d3g1VmxMK3JmYVF6RWdFT1hF?=
 =?utf-8?B?SzVYUWJHbGNmS3NVaTE1QmNxY21WUFRoQ2wvb3J4ZjBOUnlGUEY5WVJMTm1p?=
 =?utf-8?B?MVlHWisyb0Y3d3o3cTdBUzFSYXo4WjQxU2JrSFFZemw1SmtIZnp6VFAxTkR3?=
 =?utf-8?B?RDVTV0JNZnMxVEZ0MWlVNDhvSVN4ZUZxNDJ3L0FwRXZKM1RWQXNJeFQ2Zng2?=
 =?utf-8?B?ZGEwWWlRaDRvNGJ2WUYzaW9oQTdhSGV2UVg5TlFPYkFNR2NQNUZXWlZBdXdo?=
 =?utf-8?B?K29CeWZuU2t2dDB4Z1hFWCtUSTBsRENBM1NML2JVVXRFZUs0cW9XejBKMDhv?=
 =?utf-8?B?eEJRSmY0Rmp0NGV3QWJHOStLejhzQ0hKcm1Cbm9DdGk5Nnh5aUJzZ0FGeHM4?=
 =?utf-8?B?am9DT1JKODk1RFZRTFZGVGJyZ0N1MkpBSk5pRmwyeU5RQzlRSklEYnlrU0xQ?=
 =?utf-8?B?WG1mUjg1WngzZlBUUDNlUHc4YmxzVUtUTDh3RFQzbEcxZUlteU4zdEdwOXRS?=
 =?utf-8?B?aGlZR0duMUM3aG51Wit5K0RHMHc4RHpLSWlkSExDQlFWYlhNM1dscUNkZEd6?=
 =?utf-8?B?VDJuWktjeXdyNktVZkFzbmsycWkvS29EUE5LVDVvREVvbzlLN08wZ1NPNVVs?=
 =?utf-8?B?cHlPeEJ2b3V2eVVWcWw0VDI2RXpXVFdxUzBqR1JJWFNsQkdOQnZoYTlsdmZQ?=
 =?utf-8?B?VUVwR1VSeStUcUI0b1RiUFh5b3hWY1VKdDNhYTJTaGNKaXBLRkg0ZENaN0V3?=
 =?utf-8?B?VTljeU1ScjlwZ1lmZUdRdEROZHUrK0JTd0pabXJDU1lPaEJtbWRHMEhndVpJ?=
 =?utf-8?B?UjhYT0I2MTZrRThMQ2NjWDU4bzRqMDRMWmFtWUVWOG5CUnZqN1llbFBnNVZF?=
 =?utf-8?B?aWR3ZnFYems4c2x1NlAxbUZYRDZ3dWtUTHJ1TEt6RlU4K0ZhdWU2ajhpOXJk?=
 =?utf-8?B?cE9EeWxWakUzdDdScTl2aFZPKzVnV250eFlTZ1o5dGpNbUcrbTNydGUwWDlx?=
 =?utf-8?B?WUdiSlc5dnhIM051Q1VIcVBmdVNsdlFFQkpMZVJLVjdHa2lyaEVxS0JnL1Zq?=
 =?utf-8?B?bmNWaE9vWjZrZ1JFaGFxVVZnR2E4VXdrOXJkcXFqS1psczFFTXlSclVLUmUw?=
 =?utf-8?B?SlFYekpJT1ZQUjc5YzRQeGRPVnYySmtTZExzaTBxbmhod0l4RFN5MDdwQTdS?=
 =?utf-8?B?c3RNR0VvckNZenRuYnNFWGVocFhTMnNnUGNaazNvS2p4b3ZZVDg0ejlPQ2Zr?=
 =?utf-8?B?dlVKZmQ4MHhRcTVlRzNYWlRNT3A1R3ZEVUtuUkFvekZ5RUFmL2F5bUlHNlQv?=
 =?utf-8?B?UzFpNUZ1a3g5Mjc2ZFNWWjBleHc2ZGJhWmQrUFdrOS92akNlMFNISDJZUm04?=
 =?utf-8?B?eHJaRTg5YW83NS90cjcvMzYrekhMcGhZelZVRWNPdDZTYWcva2d4VDU2S2F5?=
 =?utf-8?B?Tm5JeldSQi9uZGRMVFMvdm4yaDdYYnZKUWs2My9tSGVjMUtFVjRLZ3FxcGZQ?=
 =?utf-8?Q?6fTYztfn1DeUmQmFc8VzYHsH4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6482.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d43e66c-4b6b-48cd-2b9a-08dcf97ee5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:37:39.8400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpQwWERESu6G2nb5FEAkQFIFGjEsmGnYwGse2nly4zR3HLD+AZan9YJCgm24lpfspNplCZKrFMOfzLgzIXDYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com

SGkgSmFrZSwgDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQgd2l0aCB5b3VyIGNhcmVm
dWxseSByZXZpZXchDQoNCkFuZCB5ZXMsIHlvdSBhcmUgY29ycmVjdC4gDQpUaGUgaW1wbGVtZW50
YXRpb24gb2YgZmRpcl9wcm9mX2luZm8gYXMgYSB0YWJsZSBtYXkgd2FzdGUgYSBsb3Qgb2YgbWVt
b3J5Lg0KSXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZSBhIGxpbmtlZCBsaXN0IGluc3RlYWQgdG8g
c2F2ZSBtZW1vcnkuDQpBbmQgdGhlIGxvZ2ljIG9mIHN0b3JlL2ZpbmQvZGVsZXRlIHByb2ZpbGUg
aW5mbyBzaG91bGQgYmUgbW9kaWZpZWQgYWNjb3JkaW5nbHkuDQoNClVuZm9ydHVuYXRlbHksIEkn
bSBub3QgYWJsZSB0byB3b3JraW5nIG9uIHRoZSBpbXByb3ZlbWVudCBub3cuIDogKA0KSGkgQENo
aXR0aW0sIE1hZGh1IGFuZCBAWmFraSwgQWhtZWQsIGNvdWxkIHlvdSBoZWxwIGNvbnNpZGVyIGFi
b3V0IGhvdyB0byBpbXByb3ZlIHRoZSBjb2RlPw0KVGhhbmtzIGEgbG90IQ0KDQpSZWdhcmRzLA0K
SnVuZmVuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0
b2JlciAzMSwgMjAyNCAwODoxMg0KPiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5u
Z3V5ZW5AaW50ZWwuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwub3Jn
OyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogR3VvLCBKdW5mZW5nIDxqdW5mZW5nLmd1b0BpbnRlbC5jb20+OyBa
YWtpLCBBaG1lZA0KPiA8YWhtZWQuemFraUBpbnRlbC5jb20+OyBDaGl0dGltLCBNYWRodSA8bWFk
aHUuY2hpdHRpbUBpbnRlbC5jb20+Ow0KPiBob3Jtc0BrZXJuZWwub3JnOyBoa2VsYW1AbWFydmVs
bC5jb207IE1hcmNpbiBTenljaWsNCj4gPG1hcmNpbi5zenljaWtAbGludXguaW50ZWwuY29tPjsg
Um9tYW5vd3NraSwgUmFmYWwNCj4gPHJhZmFsLnJvbWFub3dza2lAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDExLzEzXSBpY2U6IGVuYWJsZSBGRElSIGZpbHRl
cnMgZnJvbSByYXcNCj4gYmluYXJ5IHBhdHRlcm5zIGZvciBWRnMNCj4gDQo+IEhpIEp1bmZlbmcg
R3VvLA0KPiANCj4gSSByZWFsaXplIHRoaXMgaXMgYSBiaXQgbGF0ZSBzaW5jZSB0aGlzIGNvZGUg
YWxyZWFkeSBtZXJnZWQsIGJ1dCBJIHdhcw0KPiBsb29raW5nIGF0IHRoZSBpY2VfdmYgc3RydWN0
dXJlIGFuZCBmb3VuZCBpdCB3YXMgZXh0cmVtZWx5IGxhcmdlIG5vdywNCj4gYW5kIHRyYWNlZCBp
dCBiYWNrIHRvIHRoaXMgY2hhbmdlOg0KPiANCj4gT24gOC8xMy8yMDI0IDM6MjIgUE0sIFRvbnkg
Tmd1eWVuIHdyb3RlOg0KPiA+ICsvKiBTdHJ1Y3R1cmUgdG8gc3RvcmUgZmRpciBmdiBlbnRyeSAq
Lw0KPiA+ICtzdHJ1Y3QgaWNlX2ZkaXJfcHJvZl9pbmZvIHsNCj4gPiArCXN0cnVjdCBpY2VfcGFy
c2VyX3Byb2ZpbGUgcHJvZjsNCj4gPiArCXU2NCBmZGlyX2FjdGl2ZV9jbnQ7DQo+ID4gK307DQo+
ID4gKw0KPiA+ICAvKiBWRiBvcGVyYXRpb25zICovDQo+ID4gIHN0cnVjdCBpY2VfdmZfb3BzIHsN
Cj4gPiAgCWVudW0gaWNlX2Rpc3FfcnN0X3NyYyByZXNldF90eXBlOw0KPiA+IEBAIC05MSw2ICs5
OCw3IEBAIHN0cnVjdCBpY2VfdmYgew0KPiA+ICAJdTE2IGxhbl92c2lfaWR4OwkJLyogaW5kZXgg
aW50byBQRiBzdHJ1Y3QgKi8NCj4gPiAgCXUxNiBjdHJsX3ZzaV9pZHg7DQo+ID4gIAlzdHJ1Y3Qg
aWNlX3ZmX2ZkaXIgZmRpcjsNCj4gPiArCXN0cnVjdCBpY2VfZmRpcl9wcm9mX2luZm8gZmRpcl9w
cm9mX2luZm9bSUNFX01BWF9QVEdTXTsNCj4gPiAgCS8qIGZpcnN0IHZlY3RvciBpbmRleCBvZiB0
aGlzIFZGIGluIHRoZSBQRiBzcGFjZSAqLw0KPiA+ICAJaW50IGZpcnN0X3ZlY3Rvcl9pZHg7DQo+
ID4gIAlzdHJ1Y3QgaWNlX3N3ICp2Zl9zd19pZDsJLyogc3dpdGNoIElEIHRoZSBWRiBWU0lzIGNv
bm5lY3QgdG8gKi8NCj4gVGhpcyBhZGRzIDEzNSwxNjggYnl0ZXMgdG8gZXZlcnkgc2luZ2xlIFZG
IHN0cnVjdHVyZS4NCj4gDQo+IElzIHRoZXJlIG5vIHJlYXNvbiB3ZSBjYW4ndCBjb252ZXJ0IHRo
aXMgaW50byBzb21lIHNvcnQgb2YgbGlua2VkIGxpc3QNCj4gc28gd2UgZG9uJ3QgaGF2ZSB0byBz
dG9yZSBldmVyeSBwb3NzaWJsZSBpY2VfZmRpcl9wcm9mX2luZm8gZXZlbiBpZiBpdHMNCj4gbm90
IHVzZWQ/Pw0KPiANCj4gSXQgc2VlbXMgbGlrZSBldmVuIGlmIHdlIG5lZWQgdG8gc3RvcmUgYWxs
IDI1NiBlbnRyaWVzLCB3ZSBjb3VsZA0KPiBhbGxvY2F0ZSB0aGVtIGFzIGEgbGlzdCwgeGFycmF5
LCBvciBzb21ldGhpbmcgd2hpY2ggd291bGQgcHJldmVudA0KPiBuZWVkaW5nIHRvIGFsbG9jYXRl
IHRoZW0gaW4gYW4gZW50aXJlIGNodW5rIGxpa2Ugd2UgZG8gd2l0aCBhIFZGDQo+IHN0cnVjdHVy
ZS4gV2UgY291bGQgYWxzbyB0aGVvcmV0aWNhbGx5IGFsbG9jYXRlIGl0IG9uIGRlbWFuZCBvbmx5
IHdoZW4NCj4gdGhlc2UgcmF3IHBhdHRlcm5zIGFyZSB1c2VkPw0KPiANCj4gRm9yY2luZyB0aGUg
ZHJpdmVyIHRvIGNvbnN1bWUgMTMyS0Igb2YgbWVtb3J5IGZvciBldmVyeSBWRiBzZWVtcyByYXRo
ZXINCj4gb3ZlcmtpbGwuIElmIHdlIGNyZWF0ZSAxMjggVkZzLCB0aGlzIGNvbnN1bWVzIDE2LjUg
TUIgb2YgbWVtb3J5Lg0KPiANCj4gVGhhbmtzLA0KPiBKYWtlDQo=

