Return-Path: <netdev+bounces-254706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LDXHk03e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E4AEBE5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23054304CB75
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD063815E7;
	Thu, 29 Jan 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYc+G+YR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03B3803FD;
	Thu, 29 Jan 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682682; cv=fail; b=HGfxKLFK/03y7oSPjC9rQ5JggcM+VuJgVbspeo+VqaUZr4nXTyBvMsmvW1WmujvtTWOKHwBuINkDapOUviMCY9WI8d2tGPKLM/VjQkr24igBZxZsH/1Wv6Bfn3NCkqKTfJvpPFkE2ndsAKSwGY/Pt4mhQ4oGE8ZdThD7H/zxaZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682682; c=relaxed/simple;
	bh=XTPFNp8ivCddpKZ8LdrUpKNgJT/vq6PP+eyxp071wdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpxNUdVvCjtOevs9tVUaPHKXXvjM2/60hiks3umqoyWMjoXENGDBZjN6U2zfol2H6e32g4QA/FSzhtS0ht4gHSrc30jZp06GXhyYb5tggBUGgev5Xpa0zreEHenghijbzHWzid1+wNBCLMGedTa5u1c65amp3MmTsh62bYB/zl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYc+G+YR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769682680; x=1801218680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XTPFNp8ivCddpKZ8LdrUpKNgJT/vq6PP+eyxp071wdw=;
  b=XYc+G+YRgfbDFJPiTbjUdce7rhWeFCyThMalIz7YhdeTaCLGIMBEymhj
   aKre+LUwDUnhFqZjXpdmawxUgt/5T3zM2I54rBiojL5pnqXItHjUkAGX9
   Odr4eeZLF29L0KHo8HcTlUwlJPeIiBYf8yKyVE1fXhWvkmvncRomv8fwJ
   S3u+8B8vW6nWf0KzGpRLgJfrwXNT21EKiL+uYKM9c2gVh0lyRkcZYmRdP
   06wwLN+1IIs3hp1WkO+rlM4qNOI8hTfaEtj/3YO5y1HxZl5zznBAxc0Y7
   xVjGpwCTavswxPhBWgLAvt7XVbnW4ZfmUtRX15YovYpMBBMjdQ4BXoQ3r
   Q==;
X-CSE-ConnectionGUID: or6fxaPJQBWpG7NXK8tSCw==
X-CSE-MsgGUID: lyt+iMlMTlS4g8NdEGL05g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81552568"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="81552568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:31:19 -0800
X-CSE-ConnectionGUID: rG7k4RGmQvC1Lr07zLr7lA==
X-CSE-MsgGUID: 3KTKQ43qT+aotllnyONn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213090004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 02:31:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:31:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 02:31:19 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 02:31:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRCX+5u+nYV9YaibT34sj5u24aSNV47v9KpfSOiDwqGI56thTD+0GW6LBSzY0RwMZARBP/b/K3DwXmOh+6vwX5fQsqA+z9T81Vh0rrvKazBF6KE/nlrxxCqFIrHWSH+Nf2LKb/ZoSoXkJMBQCXQf+ZBO0yadL6nHDqlvzYVErbhVawp+e9V1T6vf+/j4sQvVsl+FzWW+/G1zawSR3sKb44x2ePU2k6WpcDPuVyLf2L0OBscHWoLhzdgsJ55Bm0v9IAioiBSZCWOSmTUkQVtB0YM8OYd3AWCnCwOGdLinNq3YAzYEeWDkWiv9H+3J+Ga/1b3wd+3P/zrML5ZcMGVCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTPFNp8ivCddpKZ8LdrUpKNgJT/vq6PP+eyxp071wdw=;
 b=pJouaaHWrvlQeQHg7HU7aag8v5unopy7K1vRJzNFiBErDZJg6TUSGRfGWJpQqIqA4cfzEAaDGD4MPAkC12JFQGD1Q77zFveRu4/p2CO9eHw/6UyAqLuBv3Hzg9uB8PkAUFb9/S2ZNG5ZdzdmFWjsU/HbYQHhXWkRyHudxwDaGDpZ2WOSCpph4wZpYYbmSWJeUzl5K/HdTUNg5SkjGCHt5mosXpQbDDHlDCq/TaOY8XM/CA0LZUtYl8MikIfQs2/WkFG3xYGr5lL5RF31dF6V1EGLCeZXd2+bT3TNlc9YPpK6NMCorsfBHQNb6ANDcWzgQlVAC19bET04id3E2AV3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:31:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:31:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH v3 16/30] docs: kdoc_re: better show
 KernRe() at documentation
Thread-Topic: [Intel-wired-lan] [PATCH v3 16/30] docs: kdoc_re: better show
 KernRe() at documentation
Thread-Index: AQHckPaO9GgdESefDUyGms0Ga+2GWrVo8thA
Date: Thu, 29 Jan 2026 10:31:17 +0000
Message-ID: <IA3PR11MB89864C16148D5B0189182777E59EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
 <a81e9e61cc961fb710e3aa1ae9b55ffa00a701e7.1769673038.git.mchehab+huawei@kernel.org>
In-Reply-To: <a81e9e61cc961fb710e3aa1ae9b55ffa00a701e7.1769673038.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4956:EE_
x-ms-office365-filtering-correlation-id: 389de43f-9e68-41ee-8604-08de5f218906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TG5OTVNENDBJUXgwZE5sbGJkSk1zLzZ1UFVWRGFFKy9UU1oxM2xlaW1SS1Rt?=
 =?utf-8?B?Ym4xSkVqNm9CZ3JPR01UQ002ck1yUWZYUlB0OGN4dlRvMFZCaHlCM0RLSEVE?=
 =?utf-8?B?dlRJNzVFZUJCdjRBY3RpVkxsZW9neHdqWnZlYUNhRlFRalljWmw2SHI1Wld5?=
 =?utf-8?B?YXNTb3J5Y3hLcUFaWWNSeW1TSmNVZXBtTERjWTBLY3lkakh4VXByVERrTzUv?=
 =?utf-8?B?VXpJY2ljaFE0L01kMjByVldWZVpYckI5U2lVd21VY2ZFcnhTN2VxdGM3QnZZ?=
 =?utf-8?B?QTZ2T3VXRFE1SW94QzREYk5vTU9sS2ZMeHI5TiszV0VlNE1aaHZjZ2NGRXhV?=
 =?utf-8?B?cEM5SXFxMTdhTTlBY3FVb25vdW9LQkJhdGU0OWZDSWtiV3ZlSXZ6aTlESTd0?=
 =?utf-8?B?MjNVbXhZVEpnalNaUGU5V0NVdzZDdExkVUdHSVBjLzZSVTNmZk1kTjFrOG90?=
 =?utf-8?B?Yi81QXppeXZxZEFEMmpORld6SmU0eUZRMXdGTWNnaTQxY21IcjMyeWdSblMw?=
 =?utf-8?B?azRqRnVuS2djbncyRG9nQW1Ta3BVZ2NxWmtuQ0w1cWZ6K0JCemJ0NVdHQUha?=
 =?utf-8?B?MVdnVWJNaHU5MzI5RmZpdm9nOXErVzN0dmRYc0Z5ZHByNXJpMWQ1MnNuNXRt?=
 =?utf-8?B?LzBkYXFCd3N1bi9FNmUrM1lPZTdGaE5vV255a3RVbEc1MVFZbnNVNGZDVFBp?=
 =?utf-8?B?YkducldnZUdwWGI1NVYzZ0ZRaFRYeExqdnlGekcwRmpHN3lxeWtnSzVxQUpL?=
 =?utf-8?B?aGVmMWpHcFdVZUVSQk1tY2ROQWRYR2EzektrSTBwVHVxVE9DOG5kVUxqV2VY?=
 =?utf-8?B?ZTRDTEExeXltWkdOdHA2UW5sYUQrKzRIWURkN0s5T3pxQ0plTjZZa2NZdlcz?=
 =?utf-8?B?WkVZOWRQWExVc0hOdndsUElQMWl6eEJOSHQwT2t4Y1BJT0VCTjVFUnAwcUJx?=
 =?utf-8?B?UXBCZWVmTHV5M3huRGpyeFZmT2kwNmtXZ3djdGJoakwrN05zSHJJSFlJSXpG?=
 =?utf-8?B?MEhZR0dQWTFUSDFCVEZJMWJ4N0JacWJkMHUvVHRzSDRLWGJSVVEySEFpQWto?=
 =?utf-8?B?cHU5cVpxd3FKTzV6RXJvdERnS2VDeExTMlFHS0FGTGJ2YUxIWDIySGdBRk5o?=
 =?utf-8?B?elNGOWg1VVdEQWlqU1lmT1RRT3dHYXhtSHhWdi9qWHMvM3kwc2lKU1hFUEFG?=
 =?utf-8?B?dDdnajRXemMvdHc1Rm1zV0RYQmk4QzhjTjc2bVMwZlV3aXVDblcxenVmellO?=
 =?utf-8?B?VEJMWjJ0TjVGRjN6cVZDM3RCbTA5ZjFZRnh1aXp3Q292NzZLWFFlRDFIeG5J?=
 =?utf-8?B?VmFuTVFrSjZ6RUFXQkxtc1N6Tk1TT2tyNWRPd2NyckhyTEVRM09zQXFqSllG?=
 =?utf-8?B?R0xYbmV3dXpUU1RJQ2lnd0FvREc2WG1mbUVRbEZNcW05WTBhKzZ1SVNadDlI?=
 =?utf-8?B?WU94cVFjWmlPc1FqbmE3YmFFUm9NMURiZEtidElEMGV5SFVoTlNkRWlQRldE?=
 =?utf-8?B?SVZzcGpWME9Jb0JGTk5FUUhTaEhtVXBwL1hKQTVtNXZXVGw2dW9mZFhicGtU?=
 =?utf-8?B?eHBsc24ybldJZXpVYTFTNHdINnRRa2phUHFxeHlIaXZ5em1BdE5ZaE5LNldW?=
 =?utf-8?B?aHN5em5aL1FxQk1KSmlqZGdNZlhjY1haaUgrZXAwOEVxaHpEbHYwNU1VOVg5?=
 =?utf-8?B?QmZMME1qTTN3bWxOMXh1RzZLTytlUU1KSlgwTGtUZTAycHNFMGNqNjV4SXNY?=
 =?utf-8?B?b3dhbjYxaVVlTG1adGNjbjNldmxlUHNJaWwwNjkvMXB1Uks5anloazVIaXdO?=
 =?utf-8?B?aDgvVlVPTUY5c24wMVdLblE2cmJDcE5BZEtkT3RXLzdBUUlHZ3pqN0dJWDI2?=
 =?utf-8?B?UENmRWVlN3R1bzMyTUNoanNPY0RjZS9TeitsY0Y4Y0Y5Z2NMMjhxa0NOQjcv?=
 =?utf-8?B?SXEzTUVCeUhyK1pMQk1RaDdLMTk0TEhkK0F3YUU5cU83Q0ZIbWpoakNKQlJ3?=
 =?utf-8?B?K0pvOFhNMGU2dnlPOWwzQW1IUzAxVm1ZTFBIRlRBMTJoZEd2SUp6Z3lrdDQ3?=
 =?utf-8?B?UGNZMmFlUzNjcGxycVR3ZHNGd1gxalRSL3Z1c01JMGt1N1ZGWHQrQ1ZuQmtS?=
 =?utf-8?B?aWlJbUcxeWx0Sk5CZEJIK25qL01rU3l6MUFUODNqTms4TitJcE5PcEVublk3?=
 =?utf-8?Q?5Rnck4MENSIe1QrU4bkrwV0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzF1blB5RHdKeU5uNURlcitDSG9PYTgyOVdSKzBZRXJSYjY5QVkrckhkSHND?=
 =?utf-8?B?ckg2Wkk5eFdGaFRBREVXZEdJVktLTHY2TCs2TTVWd05EaU45UXc3M2IwT2kz?=
 =?utf-8?B?UWlpNmdyRFlDckZuc1o5ckVEQjZWMWJCbytPek9LM081eXpCQ1dpRU9DVFdI?=
 =?utf-8?B?RE1ZYTZrSWM5MW1pOTE4dFlzM01JQjlaQlcwUlFvTkErS3NlYzRmbm9aZWtn?=
 =?utf-8?B?WldibHAvOGJHaUQ0VnpYREJCWHF5Ui85S29SQzBXTGszM01BRFVISUYzL3RQ?=
 =?utf-8?B?eTh5TDBsK1pQTU9PSGJTTFNrbHNaUXcxUzNEQUFZQURTYmMvNmRVaGhZQndu?=
 =?utf-8?B?TU9TODBUN3F5dDNOMm1zZnN5OHlCdTR0aEcySHIzL01pQ0x2bzhmclJwamJm?=
 =?utf-8?B?NGZaRi9JSlowMlU5RkxBem4rNi9vR0FCV1hvSFdGbnBuV0p2MnZ3VGZGZW5M?=
 =?utf-8?B?QS9DazFmazBrOHNoN3BIajllajNBN3hoK2pYRlNoVEw5WFJmaFZmbDJFL0tB?=
 =?utf-8?B?RGlnc0FmWEtEZ2twSTJHUExvSFNPZjlEdDJNWEdtOEtoMmRnaDdXV2tyOEpR?=
 =?utf-8?B?MXB4aTNGUm5SQnR0NXBOT1BBM09rZjdBVXpBc3FZVldPdm10d3JUa2dxTSsw?=
 =?utf-8?B?ajNkeXY1eFJmcElmcHA1VlVGUDgyL3pON2xUVnVrM3NoUGJmMEJsakM0T2t5?=
 =?utf-8?B?dGJKRGRuNmFPWUVad1Rnc1BRM1RwS2U0OUt0MTVOZWdDaGhiRVIyQkYvdmVm?=
 =?utf-8?B?U21JRXVRV1V3UCtkdHJjY29XdGZ3MFJadDdwR2gyaVF0Vk9PTThMN25pWmRl?=
 =?utf-8?B?L0h2TGg5TU9HYllUeTBFZkZ2bEttYnl4Z2kxU0szT3NIQU1WV1N1NjFpdkJu?=
 =?utf-8?B?OTJpQ00reXYzbFNRalkxcFR1MGRsVTZyMzBiZ2tuVUlKSnhTRlpQcTcrRzU3?=
 =?utf-8?B?ZUhTWWhRNjcvQTNhWE9UaHhSUVlpV0M4WTJYeFk5bXN2OGcvdDduNWEvYXNV?=
 =?utf-8?B?elJrWjFhb1ViQm1JMkd6OHRmTmVtOS9YbjJZYSs0UGN4ZkFwQ1BkcDJlZkFJ?=
 =?utf-8?B?b0VTUllpanVTVXIxK0RaOGY5cUdQeDFsQ2J0d2Nsc2lBS05Qd3RXN2wzV3c1?=
 =?utf-8?B?WDM1VUI2R3dscnJjRVduY0xMTHh2c2o4UytvMFVtTFRZVHN4a3pxRWt2Ujls?=
 =?utf-8?B?V0o3L0pFb1dJeGR2dzZuRy85eExjd1ZRaUhoUWYrTlBEdkluSGM0R1M0OEp6?=
 =?utf-8?B?clk5Q25tbkhNZHBWczNwOG5Qb2RUeFd6Ykp6RmIvWExpRHBlMmJJUnZsQ0JL?=
 =?utf-8?B?bnVTRjdja0NKSkhGdXJDNVI3NUMweTR3a3FJSGhLaHhZNWVHYVNqcGVSVHMr?=
 =?utf-8?B?S0daRzRZaER3S3p6RTM3VUNDUVVESHFKazVGY3JGciswdjhnV05yZHd6Y0Ri?=
 =?utf-8?B?TnJHdkxzRjI4a3g2VElXMzJwTVVNRzBkM2tjYU9JT2VoVmpPNFBQVmE1TURj?=
 =?utf-8?B?UHUxQUZDYTBKYVlxLy9lak9xaHFUcXF6SFZsQS90dkJ2N2xGLzF1L3ZSRzZn?=
 =?utf-8?B?cnV3YWhMVWxKZ1B6Vnh6QVZuMjgySjRGQ3JOeVVodXN0SXVZaXhMaVpsMHZm?=
 =?utf-8?B?VDI0eGZkSTFGUDNlUTZRVlhKdURDY0wzaW5kQnRYdEZYK0cwTkdjdUxwMXRt?=
 =?utf-8?B?V2hBS0Z3TW14MFRXNU9ydDg1czg1Tlp5L1R2VTRCWXJMWGJOVUFlbHdZNlQz?=
 =?utf-8?B?MjhxMnNBUkFXWWxxeFI2b2J1QmdOeGFsaTlkR293K3BicFJ1Ni9iYmUyRHp2?=
 =?utf-8?B?MURsRW43b0pOOEUvUTRaVUhmNE9BMm9qRk1MT25aMWdvYXZyN3VudHQvUTV1?=
 =?utf-8?B?ZFJVdUwvS2FZQkhHZ1dsczRIRFJac2FzVXhDcTBkVW9rSitnVWVuRmpmWW1j?=
 =?utf-8?B?TGlmMzMzdGZCbXB4U1NBcGVYaUVaazJFWDRQWk4za3NMMHJPb2FRd2JYc3Vp?=
 =?utf-8?B?bHlBVW5ZYkxyUHBxYy91cXlFUlI3TU1hWjVGRkVaZ0lESFA1QUNrWHNuVnFQ?=
 =?utf-8?B?VGUxQ0xCSGljdDNNQmQrcGRzcDhxTlJ2dEVUVDEyRHR3RUxpQ3NpTklpSFpv?=
 =?utf-8?B?OHRRa3pIaXBES3oraU51a2VuM1R4dUg5MHRoMzZiZU1MRVRuTm9sSHI0VHlZ?=
 =?utf-8?B?b08xUFBVeHcwSFVOQ2Z2WXBCZTNUTmdEa3N2YzJiVGpMaG9OcE5XQ1dFd0NQ?=
 =?utf-8?B?Y3B0alVMZzZiRzQzbVM0N2RaaEYrdHI5U1RtRjdRejRTRzJSaUo0ODJlSTFu?=
 =?utf-8?B?YjRCcFVCWnhobDQweHU4SmhqQ2RDOXdvNEVaN0NqTDZuaE1wK0hjbDVpZnN3?=
 =?utf-8?Q?YkQ6bCDKU48IezSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389de43f-9e68-41ee-8604-08de5f218906
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 10:31:17.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JF0f2JCDYvKnWzjOGZfOkW0njzMzx5SYdiyN77FXyYZ8z20P2D4ZHjeRd6ABNLUhZbhxus4p9vhi2XprbGGHNySf3LNXYtuc6HlDb8mYaQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email,lwn.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,infradead.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D41E4AEBE5
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI5LCAyMDI2IDk6
MDggQU0NCj4gVG86IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBMaW51eCBEb2Mg
TWFpbGluZyBMaXN0IDxsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IE1hdXJv
IENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz47DQo+IGJwZkB2Z2Vy
Lmtlcm5lbC5vcmc7IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBsaW51eC0NCj4g
aGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFi
QGtlcm5lbC5vcmc+Ow0KPiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYzIDE2LzMwXSBkb2NzOiBrZG9jX3Jl
OiBiZXR0ZXIgc2hvdw0KPiBLZXJuUmUoKSBhdCBkb2N1bWVudGF0aW9uDQo+IA0KPiB0aGUgX19y
ZXByX18oKSBmdW5jdGlvbiBpcyB1c2VkIGJ5IGF1dG9kb2MgdG8gZG9jdW1lbnQgbWFjcm8NCj4g
aW5pdGlhbGl6YXRpb24uDQo+IA0KPiBBZGQgYSBiZXR0ZXIgcmVwcmVzZW50YXRpb24gZm9yIHRo
ZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIr
aHVhd2VpQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2Nf
cmUucHkgfCAyMyArKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9s
aWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBiL3Rvb2xzL2xpYi9weXRob24va2RvYy9rZG9j
X3JlLnB5DQo+IGluZGV4IDE4NjE3OTlmMTk2Ni4uM2Y0MDVhZGRjYzU4IDEwMDY0NA0KPiAtLS0g
YS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiArKysgYi90b29scy9saWIvcHl0
aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBAQCAtNTIsNyArNTIsMjggQEAgY2xhc3MgS2VyblJlOg0K
PiAgICAgICAgICByZXR1cm4gc2VsZi5yZWdleC5wYXR0ZXJuDQo+IA0KPiAgICAgIGRlZiBfX3Jl
cHJfXyhzZWxmKToNCj4gLSAgICAgICAgcmV0dXJuIGYncmUuY29tcGlsZSgie3NlbGYucmVnZXgu
cGF0dGVybn0iKScNCj4gKyAgICAgICAgIiIiDQo+ICsgICAgICAgIFJldHVybnMgYSBkaXNwbGF5
YWJsZSB2ZXJzaW9uIG9mIHRoZSBjbGFzcyBpbml0Lg0KPiArICAgICAgICAiIiINCj4gKw0KPiAr
ICAgICAgICBmbGFnX21hcCA9IHsNCj4gKyAgICAgICAgICAgIHJlLklHTk9SRUNBU0U6ICJyZS5J
IiwNCj4gKyAgICAgICAgICAgIHJlLk1VTFRJTElORTogInJlLk0iLA0KPiArICAgICAgICAgICAg
cmUuRE9UQUxMOiAicmUuUyIsDQo+ICsgICAgICAgICAgICByZS5WRVJCT1NFOiAicmUuWCIsDQo+
ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBmbGFncyA9IFtdDQo+ICsgICAgICAgIGZvciBm
bGFnLCBuYW1lIGluIGZsYWdfbWFwLml0ZW1zKCk6DQo+ICsgICAgICAgICAgICBpZiBzZWxmLnJl
Z2V4LmZsYWdzICYgZmxhZzoNCj4gKyAgICAgICAgICAgICAgICBmbGFncy5hcHBlbmQobmFtZSkN
Cj4gKw0KPiArICAgICAgICBmbGFnc19uYW1lID0gIiB8ICIuam9pbihmbGFncykNCj4gKw0KPiAr
ICAgICAgICBpZiBmbGFnc19uYW1lOg0KPiArICAgICAgICAgICAgcmV0dXJuIGYnS2VyblJlKCJ7
c2VsZi5yZWdleC5wYXR0ZXJufSIsIHtmbGFnc19uYW1lfSknDQo+ICsgICAgICAgIGVsc2U6DQo+
ICsgICAgICAgICAgICByZXR1cm4gZidLZXJuUmUoIntzZWxmLnJlZ2V4LnBhdHRlcm59IiknDQo+
IA0KPiAgICAgIGRlZiBfX2FkZF9fKHNlbGYsIG90aGVyKToNCj4gICAgICAgICAgIiIiDQo+IC0t
DQo+IDIuNTIuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRy
Lmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

