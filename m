Return-Path: <netdev+bounces-273264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDudNqyjymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EF35EB78
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6783300E5C5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D703377023;
	Mon, 30 Mar 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+fZv8SU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14EE63CB
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887797; cv=fail; b=YwSwj8p09ppPWEWVDKPys4Z2CeYoKJ5gyBgJkQoFh3Baugyfl5Q7F+9EY/vojPzwSlqglnoTiar9YUkAior1z/XghOmpzC7S1Qi57TnMK+xD5aH4TnWD08v70GzCrhjQeg0ksJQbk6+f19MdVi0Wh8jW0IqsaMAEgolJODHHDtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887797; c=relaxed/simple;
	bh=t/m3jW+VT2wVkV8PCLjdROhMKt/tf7M1D/P4wbXgks0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLPonnMINdn9ufvmr9ot/C9fuNhtplbShOId4zFH4E+RkE+F15bsRfxoY21LfaJ+2pP1xWePr1vunOiWnkIHyA8o5hBFPMvTdoF99d65jgbDGv7MpsJZHkkeg0pwIRo9m7YnyqG6J6+n1we4ACzA4RgmerteR9/+u7KlYLitdNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+fZv8SU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774887796; x=1806423796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/m3jW+VT2wVkV8PCLjdROhMKt/tf7M1D/P4wbXgks0=;
  b=N+fZv8SU6UaWAC7Vrs8lVv9IGK3HxWxWpAmz7tjRqM/b1zcwWEYviRoO
   4kD6uEMa7wUr+tWdxUioYMI2rmi5ro9mdSMycuYb+St1fGchXptoYEeaC
   SByuExachCfemLKHDrwUNeaoFGxbYUD7rDQIZhBcGhWVbEP816EvTaF/X
   d7pPoBx0PHC8XPHuMQLYVQOinpBseF6Fcyc3mOm5rpDFmXtCu0lQbDoXj
   xE3PFl/Cu8E8BcMOHuAClIdDEL6CVWg245XXozERhn683vx5msopz+Pih
   2zjUGsw272w0CZTmbQZsIWO7xNL8aQrqDpNTF7eVue1MvesYRBjlZIijD
   A==;
X-CSE-ConnectionGUID: aNtKmrPuQCaAZoOgjq6Rtg==
X-CSE-MsgGUID: Mm46ZBfOSTyBnaMAk3bYsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87354999"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="87354999"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:23:16 -0700
X-CSE-ConnectionGUID: UpfL9asUQQq+qFSkg95YUg==
X-CSE-MsgGUID: i4HVDoWKRaqCHGiw3NEpmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="221689964"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:23:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 09:23:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 09:23:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 09:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJtrn9Sr3Ms48rCJHoEmVDpgSpmrwhvkvg6Ww9qtZ4EcJI0iKhHUTWXcuAMZ8VOeRNc2OSplzN7wHeJPJW571PpvdR97Xc1hWU56NS4xTm0cHFecJIZytK77X7YApWhouEFIWCXbde0RnekCWZ6XxrZpqeTPxnbpYgoXcnEgtmbWMv0lQG2VG3ZD39Uiaio1mAs42asOOXXJ3ILe9eIqqbhkRQRvCGDF1atGLtzBon1ZllrlzhxwurUQx/pq92kSkoQu0aum3uGjZ/Sc/Zs28LtK0XJGfxdnWxk/uYXLSWikCZYedsZ1bk9AlahfNBkr16sYcpFRIL0J+TSsCjWsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/m3jW+VT2wVkV8PCLjdROhMKt/tf7M1D/P4wbXgks0=;
 b=fQmCYXNBeYRLmFQTBVYdOi0Z1P842GaDCQoNuy+71NxHtcUgQgG5is6f0fwly+0gP2fk93OxKJa6ugb5VuqdGjyPlBsDRU8TF47jslhHGM+lIbFVXrQidTpidjK4vILtH2/tStlh/JTnhGAXKk6u/4mAFKOra4UNTzSL3dQfHr56PJCLC9phsMEJ62V7VjKDPDOLSz1ltEKe39XHfeBEFuNeaJbx0W7ZxN1AHZ6lYVFyv1GEBWPzb9HrWuOlgU4FJJM+3UrQMFqvdb5a0CuodwK652rOlt6CrhnNFaEI79g85I3cpdd89tloOftjuDHl2ArAesUt4enwtNVpAuPZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 16:23:09 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 16:23:09 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
Thread-Index: AQHct5HD0lbRdFIoZE2SjMITLEHmtrW/8uOAgAdfdZA=
Date: Mon, 30 Mar 2026 16:23:09 +0000
Message-ID: <IA1PR11MB6219D3F43CF0192FFAE07CD89252A@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
 <dbe4af5f-b8c6-4abe-bd55-8f970e18add9@intel.com>
In-Reply-To: <dbe4af5f-b8c6-4abe-bd55-8f970e18add9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|IA1PR11MB7175:EE_
x-ms-office365-filtering-correlation-id: 1d8b23e2-1a6e-45a2-46cb-08de8e78a1bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: gRsMMQcsjmZh+d04/nig1OuvDSwumrQJxsZ6oa3xAeXql5Jpl5z4Igu1KhnYLIr+C3FVZw/7TPvLoHHRnUt452H1UuurDtuHeQharHzvPKQNoLmmkxYyytYQgGJPLQvtoEihn4GqEihldivrmC8c/lJl1C9Aegg7lP50SrZ6VlvnFkZvEHAFk1CK7DsTwhm+P/2GnLKF4N56ambhok9KxY7my5OW+ye60gj7lc/O6kMmNHpfXmpltDtAew9i0O3YU1nZ6oIN5dZfwzrQTqNNqj8hMtN1CHnjiISWclJjR6ONKAjnLLci85hPi3g9YwVbFS0DxI3oQO8JBVvT28rYS49kiBwiRoXl6QM+U01c+HwlsFLNQBpnCAS/3BVNRtE/Y6236x+ff73lH2LkVHbh589EqZk3sQ1b6pPcSJQBmPHhFY6wQS6JBAPF4eJ8NuD80i91bGz17bHSDb1bbGdWpPEiXZKP5NKs3BQeZtqry3bXsfjLaYzcxyO+NeSqu7FaBsEpA+41Jo3loDrG68727hFWMkh0GA21p+8BRbmckfEgyhXP19stoqYCpXtcQbV47E0hEa9TPd+sddxfERpthsxf8DB4NwEAt3QBp5noLDqPCMJB+Xbpe9SSbsngLJ20ScfF5i3rWkhfeP6L+83uHaWmuWLMXrkFHEFUnnLCx5fBulQ5vExkPhMwWnptqbHn+HE5Yxcm/hpl6zAOFrYMMlUZ+srb1hAUTG83rJ/PpAlw74VIQFUOGkta5vLEEPdDBe1y6b939AQum83DN/nGMUYjB04J8eZIH06IuOyxL6ObIQpPEgFC0xeFJA5E82U6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXRyaUZSWW9Sd1p6LzNjbHlHRXNmMEIwZlVLVkJGK3BzMHJrS29FWFNtYWVX?=
 =?utf-8?B?cmpDWlRnZWNxKzFXZzdNSTRDL0ozOHV2NUt3WnpSejg4aUpEN1o0ODJIMDFt?=
 =?utf-8?B?MDhiSGNzbEdMY3pWRGFtQlRMZ0U2SDlhdWJseDJFWW1EeFZVUHprUFlaY2di?=
 =?utf-8?B?VlR1SXdjeG80NnJUOFA1TVE2c0ZrOFJOUjhEaURrYjN5c012N2h0M0FEcVlB?=
 =?utf-8?B?L2NKcFpobGwxbWtrYjdNZFYzcDVvYUV1ZXpYWGp4Ymk3T0tGdjB5WW9iOElW?=
 =?utf-8?B?WUtNTENiU0p4UXhBNjN0K0FINFI3cHd0M3p3akVQV0dtbGd6R0NobzR5ZHli?=
 =?utf-8?B?eTZEak1KRzM3QW5MejJmWG5NUGlKQXRXSzR5dVZQODlUNWxHSVZiTWwzeENU?=
 =?utf-8?B?UGhVb3ZNUW9rWjZ3RUR3WFMzejdMVWR0Z1JyTFJyV2dWaUN0SWhaU0lleDIy?=
 =?utf-8?B?M0ptaS80ZU1EUGZ3ZC9pM3EwTjE1TXoydmNoVHNROUdteFRRS2dLOE9YeTdK?=
 =?utf-8?B?K0UxTVhEbVA1cWpqRWNCMWQ3cURBT0lhOUxoUjBENHVUZHZTRnZJRWF1bk1o?=
 =?utf-8?B?T3U1SnQ5RkNreGlsaUJpWEsxVkVWdVpzWUhnRXdKZFpQR1VJbkd6L2NiekVq?=
 =?utf-8?B?TTJob3dMQS9XakI4UEd4RFB1WjdvVk1RSmJoTVFUQWZpb3dkWWNBejE5T2Rt?=
 =?utf-8?B?czlhcy8zeEZER0xRaEhCNjlnREc3c1d4U012NGFXWTVEK2NTMEJGOGM2WFdq?=
 =?utf-8?B?aUl3Sk9hRGVBekRYT1VnV0NiVllwTERIQzM2R1NGQWxSenFNaFZLajBNN25L?=
 =?utf-8?B?SVZmUG9qQzFzb2FjbTRZem9JTkxETGNzQnhUQmhUWnFxakdGYjltWTNDV2xE?=
 =?utf-8?B?M3B3ZHRSZ2dqdy9RckpKazAycW1TVldPN1pjVkNibkVUeEhwLzF6WDVlZEZz?=
 =?utf-8?B?QmtMeXAzZk5vK0ZydEhTek9QQ0lPNEloNDBZNzVGbjh6dTR0eGJyU3orUk51?=
 =?utf-8?B?SVZhREtXTW5LbTFzNDdqMWhXdHJkNGJQS2dLMFlSMkJ5U0twSy9mVUI0L281?=
 =?utf-8?B?ZExqTW9jcGNJbHJWVWpUT2todlA2d1d1Q041TGlhOExQQWRHMy9hZjM1OG1K?=
 =?utf-8?B?TFZ5Z3BFQU5peVFKMUdwYWFXbU5RM0RrL1BzVWRpN0NHUExVTjliOTAwVW5I?=
 =?utf-8?B?WXVnQzdwWnZBUURIVG9jZ2dSZllWb1V0NGpET0VoNWNrOS9NdzFNRjNLSnZU?=
 =?utf-8?B?bHBqU3dVcFdadHY2QnRPNHN0aHhEd0JNZVNpUjd5bENzZUVrYTN3NFIveXpJ?=
 =?utf-8?B?RGgxdHRYRE0xdzd5MEVGR1RQNnROWE5ZODllQzhZUURLWEg1Slkvc3FDNnlx?=
 =?utf-8?B?OFovdlFyOE1CZWxJdStvTjNGWXdla0JKeTA0b3RiU29XZnU5aTVrenVhNWV5?=
 =?utf-8?B?aGZYVVQ1VU1QTEk4VE41bG9YWFFIVmZrcnVhU2VpaWY3Z3hXYVFuOE1lbkhr?=
 =?utf-8?B?QWM1aVREQitNb1BkeXlrWERoV0IwUVMxYVVvV0RwbFJienM1bHVHYlF5Tnly?=
 =?utf-8?B?cDlwTWZ3NTRlNVZ5VVUxSnZWM3FaVDJRVTJtc0RLdGY3RXFtUk92NitWYnN3?=
 =?utf-8?B?ZHNIVWJWOVdGeXAwZHQ5QXJSQmVkQ2NRbWpTdmc2RlBzTUtSUjI2MG9SYVpY?=
 =?utf-8?B?L3l5TmRsenR3ZlVpV0g2Szg4R3UxSFF4c0ZsZ3BkMjUyZEltUDZNeVNoL3Aw?=
 =?utf-8?B?eC9XSnpjQjFSOEJLK25aY1hLMUFOSi9TS0FnTnE5bUlXaFJIQi9ST29rajFp?=
 =?utf-8?B?QlNtRWEwcjhMQXIwL2R2bEttZzUrcnFGZGgyZ1plTzlxSU9XLzR4Q2xvenFz?=
 =?utf-8?B?S01uR01qQzdyeUpSdmJiQTZrYnNVMUFMemJ4U2pGL0ZaQjdlN2FFaGZDS2pm?=
 =?utf-8?B?RTBpUnFuUDJuaDVURW94ekxEbEZuZGQydmVSUUROMWU0YXBvSjg0U21GMXNr?=
 =?utf-8?B?VitiWnZKVjFiMmNTRUxCWWVhUFNHeFpNbU9DaStTeEpHMkY3blV4eXFjWFVB?=
 =?utf-8?B?TnRvbENXSFJiZ1lkVURjclpZMnM4aUJOaW9rQWNaT20zTVJlTUowYysvU2FR?=
 =?utf-8?B?Sjh2TURDbUtHSTE3dmpsY3lEMHBoeHdmeVJXYUxHVWlGL1ZocUlDN0hSRkZu?=
 =?utf-8?B?QVBIb09BUStnSTVjdXEzYlRpd1dTY2pyeW5XWWhmN3M3YlA0NjVCTENMZlBq?=
 =?utf-8?B?UVpTa2ZnNDI0QXRPK0RhdzFqYXcxVytGNmtXa1kxcW5RckhZemtGbWg2ckhS?=
 =?utf-8?B?cG1rZjByb1JVb2RFTC9seTdjdHVkd3BKU1JJT0hqZFpYVW93MGk0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lr0rLuN4uCzL77ZNb/vdkdJNDIekDs+v+BSMzVWHONUcJDgwXl4JJ3Jr+hXA4CbLWr9TVbdnkzJz2guAJTkbbcLnSYSrp0pOMtnAbHlXQrfMBb0e915XaH3roC9TkIC+pDQFG2CuNzuxa9O44BS76sL/+bjzWZvmgRmNMg1B5N7I4X+z6HGtcLU+zKqEn/Qj0puXtJAut12pnZB+/u8zXqZ+AxA/2LYHHeUwTKVnzbREMU3lJY6ryaVlMkfc6zlDULfMXPI+qSQdJvtXpbw4Yoc6gYbBLOh+lBkbHnzYr5nH6fyJyw1o8bney8HekyQPXz7ij7gWaPizlmeE0nC9RA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8b23e2-1a6e-45a2-46cb-08de8e78a1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 16:23:09.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lzvu3YEju38N0zHEt/O/D6QHUNtX1sc6zGYkxuCcU6Qi8Q5HbRLY/IR5lxxziIWstx9hBuMmc6O62WTpE9t4TokcFsAJDFFbUtfSLrXPmm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273264-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 549EF35EB78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyNiwgMjAyNiAxMjo0MiBBTQ0KPiBU
bzogS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsgaW50ZWwt
d2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBL
aXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXQgdjJdIGljZTogZml4
IHBvc3RlZCB3cml0ZSBzdXBwb3J0DQo+IGZvciBzaWRlYmFuZCBxdWV1ZSBvcGVyYXRpb25zDQo+
IA0KPiBPbiAzLzE5LzIwMjYgNDoxMyBBTSwgUHJ6ZW15c2xhdyBLb3JiYSB3cm90ZToNCj4gPiBP
biBFODMwLCBQVFAgdGltZSBhZGp1c3RtZW50IGNvbW1hbmRzIHNlbnQgdmlhDQo+ID4gU0JRIGRv
bid0IGdlbmVyYXRlIGNvbXBsZXRpb24gcmVzcG9uc2VzLCBjYXVzaW5nIHRoZSBkcml2ZXIgdG8N
Cj4gPiB0aW1lb3V0IHdhaXRpbmcgYW5kIHJldHVybiAtRUlPLCB3aGVuIHRyeWluZzoNCj4gPg0K
PiAgSG0uIElzIHRoaXMgcmVhbGx5IGZvciBFODMwPyBJIGRpZG4ndCByZWFsaXplIHRoYXQgZGV2
aWNlIGFjdHVhbGx5DQo+IHNlbmRzIFNCUSBjb21tYW5kcyBmb3IgUFRQPw0KPiANCj4gQWNjb3Jk
aW5nIHRvIGljZV9wdHBfYWRqX2Nsb2NrIGZvciBFODMwLCBpdCBzYXlzICJFODMwIHN5bmMgUEhZ
cw0KPiBhdXRvbWF0aWNhbGx5IGFmdGVyIHNldHRpbmcgR0xUU1lOX1NIQURKIi4NCj4gDQo+IERp
ZCB5b3UgbWVhbiBFODI1LUMgaGVyZT8gQ2FuIHlvdSBjb25maXJtIHRoZSBkZXZpY2UgdHlwZSBh
ZmZlY3RlZD8gT3INCj4gYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+ID4gcGhjX2N0bCBl
dGg4IGdldCBhZGogMiBnZXQNCj4gPiBkbWVzZzogaWNlIDAwMDA6MWE6MDAuMDogUFRQIGZhaWxl
ZCB0byBhZGp1c3QgdGltZSwgZXJyIC01DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgcG9zdGVk
IG1vZGUgbm90IHRvIHdhaXQgZm9yIGNvbXBsZXRpb24gcmVzcG9uc2UuDQo+ID4NCj4gPiBGaXhl
czogOGY1ZWUzYzQ3N2E4ICgiaWNlOiBhZGQgc3VwcG9ydCBmb3Igc2lkZWJhbmQgbWVzc2FnZXMi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFByemVteXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+IC0gY2hhbmdlICJwb3N0cG9uZSIgdG8g
InBvc3RlZCINCj4gPiAtIGluaXQgc3RydWN0IHdpdGgge30gaW5zdGVhZCBvZiB7MH0NCj4gPiB2
MToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pbnRlbC13aXJlZC1sYW4vMjAyNjAzMTAx
MTA3MDAuMzQ1OTA0LTEtDQo+IHByemVteXNsYXcua29yYmFAaW50ZWwuY29tLw0KPiA+DQo+ID4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMgICB8IDcgKysrKysr
LQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbnRyb2xxLmMgfCA0
ICsrKysNCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb250cm9scS5o
IHwgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfY29tbW9uLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Nv
bW1vbi5jDQo+ID4gaW5kZXggODg2NjkwMmVmYjkxLi5jODljNmNhMTI4MWIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMNCj4gPiBAQCAt
MTc2NSw2ICsxNzY1LDcgQEAgaW50IGljZV9zYnFfcndfcmVnKHN0cnVjdCBpY2VfaHcgKmh3LCBz
dHJ1Y3QNCj4gaWNlX3NicV9tc2dfaW5wdXQgKmluLCB1MTYgZmxhZ3MpDQo+ID4gIHsNCj4gDQo+
IFRoaXMgYWZmZWN0cyB0aGUgaWNlX3NicV9yd19yZWcgZnVuY3Rpb24gd2hpY2ggaXMgdXNlZCBi
eSBzZXZlcmFsDQo+IHZhcmlhbnRzIGluY2x1ZGluZyB0aGUgRTgyMiBkZXZpY2VzLCBFODI1LUMg
d2l0aCBFVEg1NkcsIGFuZCBldmVuIEU4MTANCj4gZGV2aWNlcy4NCj4gDQo+IERvIGFsbCB0aGVz
ZSBkZXZpY2VzIG5vdCBwcm92aWRlIGNvbXBsZXRpb24/IE9yIGRvIHdlIHNpbXBseSBub3QgY2Fy
ZQ0KPiBhYm91dCB3YWl0aW5nPw0KPiANCj4gSSBkb24ndCBzZWUgYSBzaW5nbGUgY2FsbCB0byBp
Y2Vfc2JxX3J3X3JlZyBmb3IgRTgzMCwgc28gSSBzdXNwZWN0IHRoaXMNCj4gaXMgY29ycmVjdCBi
dXQgZm9yIGEgZGlmZmVyZW50IGRldmljZSwgYW5kIHRoZSBjb21taXQgbWVzc2FnZSBpcyBqdXN0
IGENCj4gdHlwbz8NCj4gDQoNCkkgc3Ryb25nbHkgYmVsaWV2ZSB0aGlzIHBhdGNoIGlzIG5lZWRl
ZCBmb3IgRTgzMCBkZXZpY2VzLg0KUGxlYXNlIG5vdGUgdGhhdCBhZnRlciB0aGlzIGZpeDoNCmh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9pbnRlbC13aXJlZC1sYW4vcGF0Y2gv
MjAyNTEyMTgwOTQ0MjguMTc2Mjg2MC0xLWdyemVnb3J6Lm5pdGthQGludGVsLmNvbS8NCnRoZXJl
ICBpcyBhY3R1YWxseSBhIGNhbGwgdG8gaWNlX3NicV9yd193cml0ZS4gQW5kIHdlIHVzZWQgJ3Bv
c3RlZCcgdmFyaWFudCBmb3IgdGhpcyBjYXNlLg0KDQpSZWdhcmRzDQoNCkdyemVnb3J6DQoNCj4g
PiAgCXN0cnVjdCBpY2Vfc2JxX2NtZF9kZXNjIGRlc2MgPSB7MH07DQo+ID4gIAlzdHJ1Y3QgaWNl
X3NicV9tc2dfcmVxIG1zZyA9IHswfTsNCj4gPiArCXN0cnVjdCBpY2Vfc3FfY2QgY2QgPSB7fTsN
Cj4gPiAgCXUxNiBtc2dfbGVuOw0KPiA+ICAJaW50IHN0YXR1czsNCj4gPg0KPiA+IEBAIC0xNzg1
LDEwICsxNzg2LDE0IEBAIGludCBpY2Vfc2JxX3J3X3JlZyhzdHJ1Y3QgaWNlX2h3ICpodywgc3Ry
dWN0DQo+IGljZV9zYnFfbXNnX2lucHV0ICppbiwgdTE2IGZsYWdzKQ0KPiA+ICAJCSAqLw0KPiA+
ICAJCW1zZ19sZW4gLT0gc2l6ZW9mKG1zZy5kYXRhKTsNCj4gPg0KPiA+ICsJaWYgKGluLT5vcGNv
ZGUgPT0gaWNlX3NicV9tc2dfd3IpDQo+ID4gKwkJY2QucG9zdGVkID0gMTsNCj4gPiArDQo+ID4g
IAlkZXNjLmZsYWdzID0gY3B1X3RvX2xlMTYoZmxhZ3MpOw0KPiA+ICAJZGVzYy5vcGNvZGUgPSBj
cHVfdG9fbGUxNihpY2Vfc2JxX29wY19uZWlnaF9kZXZfcmVxKTsNCj4gPiAgCWRlc2MucGFyYW0w
LmNtZF9sZW4gPSBjcHVfdG9fbGUxNihtc2dfbGVuKTsNCj4gPiAtCXN0YXR1cyA9IGljZV9zYnFf
c2VuZF9jbWQoaHcsICZkZXNjLCAmbXNnLCBtc2dfbGVuLCBOVUxMKTsNCj4gPiArCXN0YXR1cyA9
IGljZV9zYnFfc2VuZF9jbWQoaHcsICZkZXNjLCAmbXNnLCBtc2dfbGVuLCAmY2QpOw0KPiA+ICsN
Cj4gPiAgCWlmICghc3RhdHVzICYmICFpbi0+b3Bjb2RlKQ0KPiA+ICAJCWluLT5kYXRhID0gbGUz
Ml90b19jcHUNCj4gPiAgCQkJKCgoc3RydWN0IGljZV9zYnFfbXNnX2NtcGwgKikmbXNnKS0+ZGF0
YSk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
Y29udHJvbHEuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29udHJv
bHEuYw0KPiA+IGluZGV4IGRjYjgzN2NhZGQxOC4uYTYwMDhkYzc3ZmE0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29udHJvbHEuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29udHJvbHEuYw0KPiA+IEBA
IC0xMDg2LDYgKzEwODYsMTAgQEAgaWNlX3NxX3NlbmRfY21kKHN0cnVjdCBpY2VfaHcgKmh3LCBz
dHJ1Y3QNCj4gaWNlX2N0bF9xX2luZm8gKmNxLA0KPiA+ICAJd3IzMihodywgY3EtPnNxLnRhaWws
IGNxLT5zcS5uZXh0X3RvX3VzZSk7DQo+ID4gIAlpY2VfZmx1c2goaHcpOw0KPiA+DQo+ID4gKwkv
KiBJZiB0aGUgbWVzc2FnZSBpcyBwb3N0ZWQsIGRvbid0IHdhaXQgZm9yIGNvbXBsZXRpb24uICov
DQo+ID4gKwlpZiAoY2QgJiYgY2QtPnBvc3RlZCkNCj4gPiArCQlnb3RvIHNxX3NlbmRfY29tbWFu
ZF9lcnJvcjsNCj4gPiArDQo+ID4gIAkvKiBXYWl0IGZvciB0aGUgY29tbWFuZCB0byBjb21wbGV0
ZS4gSWYgaXQgZmluaXNoZXMgd2l0aGluIHRoZQ0KPiA+ICAJICogdGltZW91dCwgY29weSB0aGUg
ZGVzY3JpcHRvciBiYWNrIHRvIHRlbXAuDQo+ID4gIAkgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb250cm9scS5oDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb250cm9scS5oDQo+ID4gaW5kZXggNzg4MDQwZGQ2
NjJlLi5jNTBkNmZjYmFjYmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9jb250cm9scS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9jb250cm9scS5oDQo+ID4gQEAgLTc3LDYgKzc3LDcgQEAgc3RydWN0IGlj
ZV9jdGxfcV9yaW5nIHsNCj4gPiAgLyogc3EgdHJhbnNhY3Rpb24gZGV0YWlscyAqLw0KPiA+ICBz
dHJ1Y3QgaWNlX3NxX2NkIHsNCj4gPiAgCXN0cnVjdCBsaWJpZV9hcV9kZXNjICp3Yl9kZXNjOw0K
PiA+ICsJdTggcG9zdGVkIDogMTsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBycSBldmVudCBpbmZv
cm1hdGlvbiAqLw0KPiA+DQo+ID4gYmFzZS1jb21taXQ6IGFjZDJhYmM1MmRlYTkxYzNiYzNkMWI2
ZGQ4YTkyYjk2MzFkNDhiYmYNCg0K

