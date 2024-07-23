Return-Path: <netdev+bounces-112672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCC93A89B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F61F234A3
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE3142E83;
	Tue, 23 Jul 2024 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq0+A8rA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC713DDDB
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769441; cv=fail; b=Xn4hZSNpEAAOJak2PxVQLwNOk17UJdCGW0mVoeLfQdLMR/ViVQ0mU8t63KDjtCnmyjY8aOgSAxw9kKVK5hQZMzJPurWeDDloLMd1FZ+3BX3eeGnttD8Njj7fT8GoJHNjss6bfQ4Bf7e1+2aMGLVOLUUyFiUzA5I6QgkwywG0VSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769441; c=relaxed/simple;
	bh=DnkdQ2MVQJx7nAYVJlo2DCqBVtoF6g/2+/2ytOhU4lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tVRGnqxoY2kKdl2g2uTNr/Psud6K3b3qLw0J8sEurkeoESe1c8QjKAQil5gwLIByrUmd/fh2i2Jig4S6roqTt5EyMZtXFzSAsAhqINcJ6rt2XWQIgw7Y88dtHaCtDNzmpjlkK25Yg2zAicOLJgzTj8uRJZMef35uvJW0niYl0FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq0+A8rA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721769440; x=1753305440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DnkdQ2MVQJx7nAYVJlo2DCqBVtoF6g/2+/2ytOhU4lE=;
  b=Dq0+A8rAkI80GFerKyiW2M3W6d5szGyjhgjvwC1WAUmrRrCsDnGSOIHM
   icz6Rt0p3BiwKGr6m/q2CY4mBkvQbbQjZXJJATxs2dPvUv6V7U9kjNmxz
   lQa2JrFzu76YbshCT1a8OtjNSYamgHlbrQHtLRW/22EX0f8e8Cradvyig
   TwJ5oiEUM4Bq+DbOWxd1I3UI1caHELBWHN905IyPPMDo9Jy7jOWovyIrb
   C8g2W0srAntN7p4Yta6L+CMblSytUAYBD46luda+Uk5mQ4fmffj/wjrOf
   XRaBuTN53936Z0qoIJ0DNGkaWctk9tKdV5XKKiS+FMKDTpY1mA7T26xwe
   Q==;
X-CSE-ConnectionGUID: jVBWntXfQxGwJK2RLJd1ww==
X-CSE-MsgGUID: cLMfFLEIRNaq5Emzu1iIlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="23284382"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="23284382"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 14:17:19 -0700
X-CSE-ConnectionGUID: p/jpdmG8TWO3FJyE8Hzhvg==
X-CSE-MsgGUID: R3JtuKbWQt6gtXFCj49MSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52256553"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 14:17:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 14:17:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 14:17:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 14:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGIpOGPMTePUOK1xlPvVNIdRKyRN5ZsRy02qNDR4aaM+j4kByyTLWb5+kc1udE+GnwjLYAgOtXJPyvKXARPnZoiylB/lYWPpui692nCvZV/xninRiFQFh2PufRn6EsVI6a1FuAPhdFPH1TvCyvuEVJyHWclS+mj+OBJtknWV+wN3hMO3lAVPuMfmENI5ZeLwVjYPrNb6Ovb187NuvhKBN9eqt0d5plmxPpy9BcQmxayZ4CEG9ULKBvhKKNhDaiRYENjiqEtGHWtqLg2Glc11y9HxUqwQafiedZmeGywW1sMHnV5y/JzhL57iwv+SYlWWAMBmOcJssKhmM+P2yoavpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnkdQ2MVQJx7nAYVJlo2DCqBVtoF6g/2+/2ytOhU4lE=;
 b=Z1fJSNUEkqpWoe/Dly2SMFMeg6rat3wXidxc49FFSzMudPuqYqs6XielOodo8tpssUxkw/EOQzR2JKxdX9w/30WtaV1CVbSkY8FbU3872vPQ3Otwcs5GC5qtvkgLNlzEp4s7y9ptEPTQP8uAMbh3AZTEEydSKJWKDRkrd3UjPag7RZMtVg1NCkXPWzNSdx4VZgD2XuRT2mXXhGJguK6P6vzMnPqMhS1ji1Cv+YjTVi2R4i0W0C2iUdANEXYf//NlicuZT3YkWZ6tKWTrTZSobt4zztI120CUjDG46GNC+6eJ7at1GjKh1NJpPt8UMaCYhoBTYonhENd/d79MVVgqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 21:17:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 21:17:14 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Brett Creeley <bcreeley@amd.com>, Kamal Heib <kheib@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, ivecera <ivecera@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH iwl-next v2] i40e: Add support for fw health report
Thread-Topic: [PATCH iwl-next v2] i40e: Add support for fw health report
Thread-Index: AQHa3UC6bhhyYLASdU2Nk0LQ/1OTorIE0MXQ
Date: Tue, 23 Jul 2024 21:17:14 +0000
Message-ID: <CO1PR11MB508983C35CB98A8DD33E7476D6A92@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240718181319.145884-1-kheib@redhat.com>
 <42eee0c9-8cc2-40a1-a233-bb87cc4a8324@amd.com>
In-Reply-To: <42eee0c9-8cc2-40a1-a233-bb87cc4a8324@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SN7PR11MB6678:EE_
x-ms-office365-filtering-correlation-id: 143e0b3e-9f52-4a85-c9ef-08dcab5cd31f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eklUazNET1ljSUhHVHZpWUxDR2RLOVNuQlkxS3ZNSE5XanpRSHVHQWd1R0R0?=
 =?utf-8?B?RWtMNnBlaXYrZ251NlBGYldJck5EWVZmS3REY05neVZPTnNQNm5sVFlhcGtY?=
 =?utf-8?B?UHkvV0JXUUlEU0FlUmF2bzB5V1lJQTlONnZ1Y0Q3Yy9NY0dtVlozcndQYml0?=
 =?utf-8?B?TTk0Y2dmQzB6QmQ3QmtNeHJyUHJSaDVKQTJjTFU1a01OZXZpS2djRmF5SnZp?=
 =?utf-8?B?WWJYZGRtMFFFK0JobHdZOVpBVm1nVURzTXpJMjBmVXdkS21wUmlMZVBLVXQx?=
 =?utf-8?B?dUhhVzJUZzZPdlFINTJPWlRWS1VRVTFQR0lOMUg4UjBEOVJ3VUJXRFFUYUZ2?=
 =?utf-8?B?VWZJQzFJQkViekk1eXZYa0hNVmQyY0NZcFBFNXVWK2tmeXV3azlncVJqenlv?=
 =?utf-8?B?N2xIRXQwZnZjT3g5bzd0SFZhSUM0bzNLaXlIeGc0RllrQTY4a3AwMGVnT2hR?=
 =?utf-8?B?YUVXdVR4K0RxYVRpWXNuTEFyTnFJM3hCNGk1eFU2VmM1Qkc5bTVaQ1RlUWI2?=
 =?utf-8?B?SDhPeUdlUTZJODdRZlN6YlZOSDJnNVZpLy9BOGZ5U3hubDlaMnJmQzhwaFg5?=
 =?utf-8?B?a1lkN1FDRlZTOHFPZU9xcW8zd2JWZjJpbkEwbTQ5R2I3VXE3bThPdzFBcDhS?=
 =?utf-8?B?aXNOK0RzVVl3c1c3QUNyWUk2SXFnMEdEaGFibThwYktFYndBbSt5QlFGK2FU?=
 =?utf-8?B?MkFpMDk3Rm9GeFlDQ1JrTExpRmRpdGE5TEk4NHl1bDMzOGZUaVdBVGJ4MUpP?=
 =?utf-8?B?dTlDMkVKNWY3TEhFOTYzWlc3dDhpZHR0VTVzRlpTNXVnbzgvTTVXem1MM2tC?=
 =?utf-8?B?VlJtKzNYL3Yyd0tlV0x1OTNudnNmYlUwTU5XMG1EUjNTSnp6bEpIVG81MG1w?=
 =?utf-8?B?UDJncTBIb1BVYmxXZWRqT1VKUU82eU1NUlVOU0tIOEhFYWl5M0FNYmlXRG03?=
 =?utf-8?B?VnB4Nll2a0ttbXlyaEdvV1M0RS9FeEdWQUFRRks0MHR5aDZsZ0lNUTZiYmMz?=
 =?utf-8?B?N2V3dTVaZXdNT0thdDZISUFJdW4rZ1lNVzdkWHN4dFY3WUorN2lHVDJOYk5E?=
 =?utf-8?B?ZU03YlQ3VFBoNnIvMmJLZnJPSHFLZ0hoQ1RHRk1BL1JsS25uenI0ZnY2N1E2?=
 =?utf-8?B?eU9BWWQ3a0lFbFV5ZmNKd05ETVNwcXl3N045NlVDYVpRdzduTGl6VTZPd0Rp?=
 =?utf-8?B?ekxCdlZOOEdGUVFmL3hqTk83dS9yMExqb2F1R1A2bUhmamxPT1NyTGY4aTZD?=
 =?utf-8?B?WUJOb3ZyTGQ4b2xPNXhLTUpQQXdyU0ZtRmg0QXJKR1RWak45T0dRSWtjNDJw?=
 =?utf-8?B?YkVzZURNNUtkejV5SjU4NEZ3TXNNUkp6MG51dHZPa085RUxrM3lsa1hDNFpY?=
 =?utf-8?B?Zms2YzJ4SFBrZEJ1a0pVMHZwdTdWVVJsUUo3ZWpPZHg1eEV0YmNlTDQ0M01k?=
 =?utf-8?B?aDBuMzJMNVNNN2dhRE1mOUkrV29xTTU0b3JFdUNtYkxXZXZUdE9KajlPdXZq?=
 =?utf-8?B?WE1tR1ZPOENpa3JCRkE2WlZaa1JDV0pmczJxYzF0K3BYbHFPRDJyYU1OS1Qr?=
 =?utf-8?B?a2FnY0hWZXNXQjFJNmFpWXBPZDJwRWpabWdNTmhjWnEyWGpRdGZNTU1YL3NF?=
 =?utf-8?B?R2UzZGk2WGwvRG1FdGxyMTNNZzFQaWxWZXhiekg4L2xBTFFOdjBCU20rWmdv?=
 =?utf-8?B?dXVUdnlrYlJVVFQ2TmtMb0FQVEtqVWkxWGVqS2ljRUprMGJsTFlic2NxTE5o?=
 =?utf-8?B?Z1FxLzRmekowM1RqQnpzdXNUZ3I1U05NaC9iV3J5YjlBRkdpWXJHN3JRWWRj?=
 =?utf-8?B?ay9wKzFmQ2szWStkWDZDaFRkbThsbFg3SGRWa1hadjdNd05jL3BIbUJiaTlG?=
 =?utf-8?B?Um9nVDBYMmc1aGt4eEVBL2h3d0JqWE1UbXRHQmQ0cU1iY1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUEyZjlXR1BwMlFubURNeVNtc0lWb1pLSDhMak5qRGkwbEtoa1ZOVDBLZ0tx?=
 =?utf-8?B?VVZzQytTYk1QV2NUSnJHOEpmMVQ4MW1lZjc4Z2ZKb3U4RUtzYlR1eDFMNXBX?=
 =?utf-8?B?SzVzV0Nka1d3R3FPWldJY0srTnN2Q3NVVlI2Q1BSQmlPZlRvT3NTTXZ3c3lu?=
 =?utf-8?B?U3hxSnlzNFQrTXhqQWVJOThPOEhLUUE4NUlJc3FTTHZZWWgyVkJnTDJoTmJS?=
 =?utf-8?B?cUxtMGdXdnBvRzNiRDUxYXlWSFo2T0ZPcWtYdGhLZXNUR1ljd2lhc1c0ZVVk?=
 =?utf-8?B?Q1NKMzRyc0Y1TkRkb1c1STZFS2VJMUlkYkQ4djlWVjk0UzBud1FNN2dLaTJa?=
 =?utf-8?B?Z3lROXNCMTB0YzNQWFI0VUVjQ3dhWDNBN3lRZTE2amRYTnBwQm56T1ZpcnBu?=
 =?utf-8?B?elZTT0NVVTRMSFFLNHVNOHBwak9nOWQvRmZScDRVZ2RxblFrSVBjZVdSc0xQ?=
 =?utf-8?B?Z0JGYklsamxNUTYrODhtWXN3ZGw0alhOWmhMMHV0OEdIWmk5dkJOeWpnVDFS?=
 =?utf-8?B?OU8yai9pVmMzSFA2VURxa3hwZEx6bUlNZHVjUnVFR3JpTUNIekVGNWpKUGR0?=
 =?utf-8?B?MUNRazNMYVBxcUk5ZU5xNWEzSVFvQXF2V28xcHZLRzFwTXBGclVzK2I5cW43?=
 =?utf-8?B?c2hxcUdzdmVnSzNqcm01bnR0VWkwbEU3NEFmMjVqamxBaGo5aGpaZ3paS0RD?=
 =?utf-8?B?cmhWM0JOUW9qc0ZUck1Zamxsam1Ya1Fac0NBWGttdjh4Q2FoY3Via00zZ1ow?=
 =?utf-8?B?eEVEMVJ6aTFxZkdxR3NnTTJjS0ZmWGIxdU5oUjJiUkFUcHlXN2pkYmVxVDFn?=
 =?utf-8?B?TitWanNZMENsMDFXcUhqUnJoRzF4RjVqN3dKWGpUbU8wTnNXbDBEdFYxVmhJ?=
 =?utf-8?B?VlVRU1JHRkFEOVRkSDFYOUsyN0J3NjJpTjA4dXZGd1J2NFFUa0hraWpwbFBE?=
 =?utf-8?B?TjhHcUg2b1JxVHlpaUlHYVBYb1BGQXRUYXZXbVAzR3J2Nm1EVjBXRWhWWERn?=
 =?utf-8?B?Y0FQQVIxRElZejJSc2NsbzhFTDNkS0RSemxLclBreHFpTjNCVlhSczhXaU1v?=
 =?utf-8?B?NXJSQnpQd0w2UWxScjdlT2xheVZiUm9SSWc3bHpjeFZjaXV5ODF6UkRZSTdC?=
 =?utf-8?B?ODg1RG8rdXRoS2MwMFZQeW9ZUUZTanphZ0RwdnpMcVhPVE1PK1Zvd3NKZzBP?=
 =?utf-8?B?SGMxTHpSREZtVFB3UUpEaDlnRlRmSXAzMmZWZ3FPUVprYjNFTDNaWU5QRXRv?=
 =?utf-8?B?VmdBeW85MVNpZEJNV2J4SHc4QjV1WWxmejJZZEFaNHVjTTl6Q0NjTlpqdzk1?=
 =?utf-8?B?S3R3alRGSzVuZ0ZZbU5LVzFkdHlCZWE4QWZLTzlpakZaREsvVTdLdEhmRENT?=
 =?utf-8?B?TFkzUDE3NGp6S0gyN3hRSVYxMGQzck1iV0cvU00xbEJDbHNqYVBrcHdlVGhY?=
 =?utf-8?B?N0FRV2ovMUdvOTRkOWxmdTMvMFM5Z2kxNkpKMmFZNDZib01tSE83WmhnVklN?=
 =?utf-8?B?L2VIUXNFbVBXZW1udlcycjBvYVNaU3crcnZqMHVQM3hOM0p2czArMkhBMXZk?=
 =?utf-8?B?RzRYZGJqOVlBd2E3WFFRV1NQcDkvaWFJZjFFa3VDcWxqZUZCMm5SYkVNL0NE?=
 =?utf-8?B?Z0ZoY2VyZzJmR3VZQnkzNnorYTZ1d1FkTFNMREE1aTFFUy9BOGh6SmJXK2Fl?=
 =?utf-8?B?dFFIbTMrQVZLNEUrMllST2VBU2hFakgvMmtYTjZsY21haFIzc0ZDRTdlbGZN?=
 =?utf-8?B?ejc0Z2dqMWJTdnpCMy9BRUZWRXUxTWl2MDY4SEgwNXk1cmtYTG5nQkpoaGZS?=
 =?utf-8?B?MCtFeVhpWjZaMUYxZ3c5bmE0ZGIvTjQxTEpJVVN1V1NZSHNJbk56dUtva1B6?=
 =?utf-8?B?N2U0eWc2YmRTUXdoT2ROWGl0UXl2UVJuSEo3WjZBaTJ3Y0hvQTkrTUZqSmh5?=
 =?utf-8?B?dmcyYWxPOXQ0Vzk1aUlLVTU2NmR1QVp4SDE4SnU2WFRlbm9oSWZEQU11TWlP?=
 =?utf-8?B?U2ZSMlNNWVRJSUZmM1VyZHNSa2cwMGw1aFk2aFg0VzJWQVBSb3F2c1JMd01L?=
 =?utf-8?B?bVJ4UmdQMWdtQkgyWWc5Y0Y2VmVzTGxJNER1VFQrQjUrQnVaZms5QmE4SDFt?=
 =?utf-8?Q?KKdSD43BsoeBNAamT7J4TD8Fn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143e0b3e-9f52-4a85-c9ef-08dcab5cd31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 21:17:14.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9ethLLAH+36k8CpOLYm5ifE9LlkdE0kwO76b4AN0fuW/fhce/KfbgdACbB5Rohn93J55tRWSy58IJ/dW8B0m0zNlas9lWz4Iik1HZYPYOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJldHQgQ3JlZWxleSA8
YmNyZWVsZXlAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAyMywgMjAyNCAxOjQxIFBN
DQo+IFRvOiBLYW1hbCBIZWliIDxraGVpYkByZWRoYXQuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxp
c3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50
aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47DQo+IEtpdHN6ZWwsIFByemVteXNs
YXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBpdmVjZXJhDQo+IDxpdmVjZXJhQHJl
ZGhhdC5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgRGF2aWQgUyAuIE1p
bGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBpd2wtbmV4dCB2Ml0gaTQwZTogQWRkIHN1cHBv
cnQgZm9yIGZ3IGhlYWx0aCByZXBvcnQNCj4gDQo+IA0KPiANCj4gT24gNy8xOC8yMDI0IDExOjEz
IEFNLCBLYW1hbCBIZWliIHdyb3RlOg0KPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gPg0K
PiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIHJlcG9ydGluZyBmdyBzdGF0dXMgdmlhIHRoZSBkZXZs
aW5rIGhlYWx0aCByZXBvcnQuDQo+ID4NCj4gPiBFeGFtcGxlOg0KPiA+ICAgIyBkZXZsaW5rIGhl
YWx0aCBzaG93IHBjaS8wMDAwOjAyOjAwLjAgcmVwb3J0ZXIgZncNCj4gPiAgIHBjaS8wMDAwOjAy
OjAwLjA6DQo+ID4gICAgIHJlcG9ydGVyIGZ3DQo+ID4gICAgICAgc3RhdGUgaGVhbHRoeSBlcnJv
ciAwIHJlY292ZXIgMA0KPiA+ICAgIyBkZXZsaW5rIGhlYWx0aCBkaWFnbm9zZSBwY2kvMDAwMDow
MjowMC4wIHJlcG9ydGVyIGZ3DQo+ID4gICBNb2RlOiBub3JtYWwNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthbWFsIEhlaWIgPGtoZWliQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+ID4gdjI6DQo+
ID4gLSBBZGRyZXNzIGNvbW1lbnRzIGZyb20gSmlyaS4NCj4gPiAtIE1vdmUgdGhlIGNyZWF0aW9u
IG9mIHRoZSBoZWFsdGggcmVwb3J0Lg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaTQwZS9pNDBlLmggICAgICAgIHwgIDEgKw0KPiA+ICAgLi4uL25ldC9ldGhlcm5l
dC9pbnRlbC9pNDBlL2k0MGVfZGV2bGluay5jICAgIHwgNTcgKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfZGV2bGluay5oICAgIHwgIDIg
Kw0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYyAgIHwg
MTQgKysrKysNCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
IA0KPiA8c25pcD4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2k0MGUvaTQwZV9tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBl
L2k0MGVfbWFpbi5jDQo+ID4gaW5kZXggY2JjZmFkYTdiMzU3Li5iNmIzYWUyOTliMjggMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX21haW4uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMNCj4g
PiBAQCAtMTUzNzAsNiArMTUzNzAsOSBAQCBzdGF0aWMgYm9vbCBpNDBlX2NoZWNrX3JlY292ZXJ5
X21vZGUoc3RydWN0DQo+IGk0MGVfcGYgKnBmKQ0KPiA+ICAgICAgICAgICAgICAgICAgZGV2X2Ny
aXQoJnBmLT5wZGV2LT5kZXYsICJGaXJtd2FyZSByZWNvdmVyeSBtb2RlIGRldGVjdGVkLiBMaW1p
dGluZw0KPiBmdW5jdGlvbmFsaXR5LlxuIik7DQo+ID4gICAgICAgICAgICAgICAgICBkZXZfY3Jp
dCgmcGYtPnBkZXYtPmRldiwgIlJlZmVyIHRvIHRoZSBJbnRlbChSKSBFdGhlcm5ldCBBZGFwdGVy
cyBhbmQNCj4gRGV2aWNlcyBVc2VyIEd1aWRlIGZvciBkZXRhaWxzIG9uIGZpcm13YXJlIHJlY292
ZXJ5IG1vZGUuXG4iKTsNCj4gPiAgICAgICAgICAgICAgICAgIHNldF9iaXQoX19JNDBFX1JFQ09W
RVJZX01PREUsIHBmLT5zdGF0ZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChwZi0+ZndfaGVh
bHRoX3JlcG9ydCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZsaW5rX2hlYWx0aF9y
ZXBvcnQocGYtPmZ3X2hlYWx0aF9yZXBvcnQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJyZWNvdmVyeSBtb2RlIGRldGVjdGVkIiwgcGYpOw0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgICAgICAgICB9DQo+ID4g
QEAgLTE1ODEwLDYgKzE1ODEzLDEzIEBAIHN0YXRpYyBpbnQgaTQwZV9wcm9iZShzdHJ1Y3QgcGNp
X2RldiAqcGRldiwgY29uc3QNCj4gc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4gPiAgICAg
ICAgICBpZiAodGVzdF9iaXQoX19JNDBFX1JFQ09WRVJZX01PREUsIHBmLT5zdGF0ZSkpDQo+ID4g
ICAgICAgICAgICAgICAgICByZXR1cm4gaTQwZV9pbml0X3JlY292ZXJ5X21vZGUocGYsIGh3KTsN
Cj4gPg0KPiA+ICsgICAgICAgZXJyID0gaTQwZV9kZXZsaW5rX2NyZWF0ZV9oZWFsdGhfcmVwb3J0
ZXIocGYpOw0KPiA+ICsgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZf
ZXJyKCZwZGV2LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byBj
cmVhdGUgaGVhbHRoIHJlcG9ydGVyICVkXG4iLCBlcnIpOw0KPiA+ICsgICAgICAgICAgICAgICBn
b3RvIGVycl9oZWFsdGhfcmVwb3J0ZXI7DQo+IA0KPiBEbyB5b3UgcmVhbGx5IHdhbnQgdG8gZmFp
bCBwcm9iZSBpZiBjcmVhdGluZyB0aGlzIHNpbXBsZSBoZWFsdGggcmVwb3J0ZXINCj4gZmFpbHM/
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCcmV0dA0KDQpJIGFncmVlLiBJIHdvdWxkIG1ha2UgdGhp
cyBhIGRldl93YXJuIGFuZCBjb250aW51ZSB3aXRob3V0IGZhaWx1cmUuDQoNClRoYW5rcywNCkph
a2UNCg==

