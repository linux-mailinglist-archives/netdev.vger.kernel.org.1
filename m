Return-Path: <netdev+bounces-205025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35492AFCE5B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF868165F4B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C302DECA8;
	Tue,  8 Jul 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3ZJ1xt4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBC1FBE9B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986693; cv=fail; b=RN70k+fGEZr5YkdswgDEX7thUGsew3KmcK9usqsJnjLBmWWI9bHMAPoEjMJvHvtwvp3j1C8SJey6ehhRBAdeGo+EIwwqEzd+mOCFrmkx5JSsfEeQGEPMyM1Ek7sGGZ6aMttUygRBbCrMF4shX8ManDOgUOK8hkeK83YQ6qe1qXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986693; c=relaxed/simple;
	bh=n6thtW/8+zRqkspFWO95AdLk59N2dpKeS7IyIVmxq7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M51v1pyQhRkN7fsnqIihB4awASqtMqlducs1wJmyQ9g810IsmTMX8pussWtRn4way95Mog5S5q+dSjOl4dlBotoniZSl/7V3pSDN1BIMEoJ1GaFXGdsiZMExyKe82S4KI3y6LjN9BBik9MzK39edMd5xV00sXbAin24C/ND2vN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3ZJ1xt4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751986692; x=1783522692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n6thtW/8+zRqkspFWO95AdLk59N2dpKeS7IyIVmxq7U=;
  b=A3ZJ1xt4jl5SRxbFyQgkhbP+KDxC2qfY7L8VUAqruJ45sgqsaLU9DFNs
   4nfd6uFuZgnebXssJlTlP5e90HxOklYyn1pKGz8jXLyet/xuNnvUGnWzq
   YTEIcRq/P1Pdu6mlEedGol4ninhchl8gGHNK11s4bQ+a9UsHr/9A8+4S7
   XFoA7nUfgaHWHbjjm3Qw66x/9aKRU4OtpExc1cNUyzJPJCRK2sOVvKwBI
   IcSKbmCeuhtINzYsJC0oSZHBgCMPdr30d02X+XXlO6LBkHJPlNKsr7gMa
   UlrfdD1H60LTYdbx7h+OvE9wu40QlIElvsfTHzr6OcU7Iox6d7Ejfekh/
   g==;
X-CSE-ConnectionGUID: 6v26MToGQEGePq8XxQ0wAQ==
X-CSE-MsgGUID: iLGWpa0xQ8Cqocsi2OluCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64477460"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="64477460"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:58:11 -0700
X-CSE-ConnectionGUID: nN1ycO1oT6SvMJDvbVGTtg==
X-CSE-MsgGUID: amt0hiN2SJG5N738ZILMWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="155608417"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:58:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:58:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:58:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:58:02 -0700
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 14:58:00 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Tue, 8 Jul 2025
 14:58:00 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chittim, Madhu" <madhu.chittim@intel.com>, "Cao,
 Yahui" <yahui.cao@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 7/8] ice: avoid rebuilding if
 MSI-X vector count is unchanged
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 7/8] ice: avoid rebuilding if
 MSI-X vector count is unchanged
Thread-Index: AQHb4J/xETwE/ONnSkOKS0JTpwO017QocBQw
Date: Tue, 8 Jul 2025 14:58:00 +0000
Message-ID: <IA3PR11MB89857CBBB9B57DF4CB1B23878F4EA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
 <20250618-e810-live-migration-jk-migration-prep-v1-7-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-7-72a37485453e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: 33dbf6e5-2d64-4b0d-404b-08ddbe2fd522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXNNNXl5V3ZwZFB0SXd5OFRYRERWT0dzOHhDSUY4WitCWHZlTDZDQU9iN01D?=
 =?utf-8?B?QUMreFRzclZIeFB2WVp3eURpSVR4b1NiZ1k1Q1ljRmNTbnVqVjRUdEtUVXN2?=
 =?utf-8?B?MjJKZmg2Q0ZHOHZGYUd5UXVDNnhtZkl6T1NWMWd5TjR6TGdLM0ZQVVlPZjRj?=
 =?utf-8?B?R281SkhqbEpxbnEzT3p1WUFiR3JmSHcvQXRIQ1VZbERHZkRWVHBKY0lqSW1V?=
 =?utf-8?B?bnJ5RTE1OHgzMTdrTVgzcEdVdk1qLytXNUtPYnA0SU1DenZwbWZiSWpxdEd5?=
 =?utf-8?B?QmpvREx3WUlaMWVUWFZOT25XTlVTc25uczJoSEhZRzhIanJ1T2hzM3NzcHpT?=
 =?utf-8?B?YWpvTko4eXhQa3lRdzZVMy9rRzFadzVRT01PdkxvZkpLNUZkbE90djNLR1c4?=
 =?utf-8?B?M1lzeFVaZnhuUG1UV0J1MkNoR3paZUQvcG9NMkNIUFRHa1lubjM2N05qRGdJ?=
 =?utf-8?B?ekE4WmNza3d5Q3B6eURLWUQzckVwbDBaM04wTzMrWEExRjczb3ptTkowZzJE?=
 =?utf-8?B?ZmovSDAzRmNiZlJHbEwvbkhJaE4xMUZmU29wZGFTbkptd0Y1ZEVHZEVwcVl3?=
 =?utf-8?B?WElRTlhObTV2TE1IZG5EK2xTektTODZOOC9hWmUrY3dqa3F4SjlVWFFIZVU5?=
 =?utf-8?B?T1M5MFl5UnYvR0NNeWVsb1B3L0NiSmxSVnlyVkdOU05GMmpoaHhDdFVmR0Nn?=
 =?utf-8?B?eVV2UDJXZ1Z5cDRiWS9HckkwUDBpTGI3UklweWY4T1VaZDFKQUI0SEx2T0VK?=
 =?utf-8?B?U3IyMmdrMWZoeEhQVUY5NFdVbjZOc0NVWnQvVm00U2orNFFyQ2tHWFFrTGxy?=
 =?utf-8?B?YnF4amlPK0xjUUxLcXhmTWZQMVBKcmpOUFo3WVAyTmJ3aGFWbDlRenV2OUVp?=
 =?utf-8?B?cW9TejdpNVUrcXV0SHJzWjBscGN3VEZFSzB3TW13SHkzck9Za0pML1VTWUhD?=
 =?utf-8?B?UWhZNHhYNmQ1MDd2TXlneGY5NnhBTVJiMlA1Yi9EejRzUzR4NGVQMVVXa09t?=
 =?utf-8?B?SWtnb2FQZE9PK2NrV2NMNzBHaitrSGVaZjRtbXRZY1JraGtIUEZzVjRZRllN?=
 =?utf-8?B?blJndXRvUW93RVM1b3cxNXFXL1dWb3FGSUJ0c1lJOElIR1V3ZHhwVExjRmZL?=
 =?utf-8?B?RFpGVmNQNnRSRkVYRGRaQm9FNnAwdEJvMFNnTjVFdDQ5V2dTWnFTd2FCQjZT?=
 =?utf-8?B?czhnNG9RcndDK2JMb3ZLVmxRcnNTdlNvNWgzNU5yM2FIejFneUdUa3ROK0JU?=
 =?utf-8?B?MnpJSnc2Y25nWGdDZEVtUUtSY0dYalpaZ1hTb0ZmSlpabEVHVS9jNGp2RFNW?=
 =?utf-8?B?dFlNNzh4YmxtZmk1S2FEYzB5cXdCM2hrS1lGdDE5bnV3ZEtyREhDaHA5OFNE?=
 =?utf-8?B?bVZnTXRJS1Vxa09oNXJjc0k1bzF2eTZBS01vc0lVU05aME52WWxWbHFpRXJJ?=
 =?utf-8?B?Yms5bXJ2UGlnMVRRUDVzMEV3NVBJTXk2WUxqNzJIRHNjYzRtd2dWV0ZVRDh3?=
 =?utf-8?B?dGJGWExRWStuMWI5UkxpVWxwQllDcUErUWxRM3NQaDE5MHBGdmxGeEtPNW9Z?=
 =?utf-8?B?UXAwV2FVNE5aMDdwSzQ0ZTVML0E1T0xONHd3RDVmcEV1TWxMRnQ1Zk1TbDlj?=
 =?utf-8?B?WWErUUpSS0pqNWZFeDZ4dXUrSzNubVViYlMxMmJSeHpERitkeGsycnczOGxF?=
 =?utf-8?B?Rk9UR09LSkh3bkVESWZyeGxGeFlUS2Rqc09sSVk4RVRHcW9PMnBNU3BzZ0FW?=
 =?utf-8?B?Yng2UmQ2NTB2dnRlU0U3WFFoa2JCWmlNbU5XVVhFT0lRSGJIMmNCVk1JY1o5?=
 =?utf-8?B?VkNkak81TjROWUhUY0VDRWpCTVlhbm1YWG1xc3MvY2pWclozQmRYQVhwZklI?=
 =?utf-8?B?UVpwVTFEMXJraDczZDQwc1RpRk9ZZzRDM2c2SFI0bXl1cTh2ODR6eUk1VDU2?=
 =?utf-8?B?cjNIMloxdnlNWDRCWjlOeGdKQVIwYU5VMURaQjRTSXhkTUtDaXlORTZuaytr?=
 =?utf-8?B?dGVjVnhYZ3dBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hUb1B0d1RwOW9XakRsYXhmTFJ5VFl6RkxFWnIxdnA0VG1TREFvbVJUOXQr?=
 =?utf-8?B?bUlqb0h4K2ZGd3VrSXU3NDFJWTdZZ0R4RVBWSUhveFgyV0lGY3dvTmUwektO?=
 =?utf-8?B?MDJaUkczc2s5THRRSE1UcU52d2Z0Y0g5NGhOWG5LUjdvK3lXYTgxa28rM25N?=
 =?utf-8?B?S2gxWmJZUEtXcWU2Rm1XWFpJZ0JPc3IwcUtEblk2RkU2WW50dmNTMERJZlMy?=
 =?utf-8?B?ZExMOFhmcnNQRittWndqL0FBQ3pYVEZZcjlQRHNQZUNXSGRuaitCaHhVN1E1?=
 =?utf-8?B?MGJvMFQ2ekY2YlVPMDN2UTkyMDgzMWNkSzVYeEQxU2FaRW1sL3RnNGJXYXVk?=
 =?utf-8?B?cFU3bjcxZFAxWkpHekdiUHhmU2p5L051TUI1SXdUMVQ3R3Yxd3c1eXAyZkxE?=
 =?utf-8?B?Ni9kQnNsbHJrZFhlWXJLRkJGT1U2TzBPMGVyU0FkTFhHVjdkVkpQQmVoOEFj?=
 =?utf-8?B?M2VnVGRjOEQvakE0N0NpdHgvYnR5Q1hlcHNKSkorckFIMG9IOWh3a2J0bmpx?=
 =?utf-8?B?NDkvWHk2cVVES1N3ZmljVmRQOUwxUlNjbjRSQmNTU21wbGlLZnBVZTM3MTdR?=
 =?utf-8?B?L1pjMXJweE9DaWxQVjBGUVhiSVNsdjhmMkM1UlpxdTl1eTJydis4OEZTbTIz?=
 =?utf-8?B?Z2Q3aXdiSEgrbEk1SWhlbWFidWVjbjZ0aUhXd0xKbkJ3NmEwaXQ3Q29Vdnd2?=
 =?utf-8?B?TlVSaXE4V0JvMW9Gd0xaNEFkakp3QzBQRkRnK0pvd1NSZDF2cWZlU2pwYWRl?=
 =?utf-8?B?U3dXNXd6ODZYVUxWK3hVYnE5M0lLNjlKeldzZWVIQkR0dkJQSWxLdHAvUmxH?=
 =?utf-8?B?eEMzMzZxMEwrRExTT0RXMDgveGp0VXFpdURCQkE2Y2NCWWlxMzJnM0FFMVJK?=
 =?utf-8?B?Z0pGVEd4MEZSMWpybHIvR2o2ZFZ5M2h6OERITXFySmx4c3ZSeGh2TDhIcWV4?=
 =?utf-8?B?bmFDOERJU2ptVnlpL044eEJHQzArV2dqSDhtSnYzNjB5a2NRcElKUUZ5cFFZ?=
 =?utf-8?B?aE0zYzZlZnh5ZVBXZVFtNTgxa3p5THhyK3RMYTNNWEoveUM1bjY4SWtwdEg0?=
 =?utf-8?B?UEMvL1NyaE9pVU4xLzIyVzhua21sckJ5NFBrQ1ZmN1NxWXcwMnM4TzBpbW0v?=
 =?utf-8?B?bFF5Q25laEVIUGV3bmdVQlF1ZDRsMnVNK2JsRk12WFZBRnMrdGNKLzVKcURt?=
 =?utf-8?B?YTBoZGlwUHR2WUtwdXo4Y1QrdTNLRGhtVEx2S2Jyejh0Y3lFM21rd1pXZ0VG?=
 =?utf-8?B?dDBnNk01endyRWVIck1aK2ovUDhTT1U3NmxmSWhlWDJxNWVGSVhUQWFJM0Ux?=
 =?utf-8?B?U2l2R05MNUQ3N0NFdW84aU5GNnVUQ0doYjlQR1BETDF0YnJEb3pQbDg2Tlkw?=
 =?utf-8?B?ejlWbEVCYVJnbE53blJ6TklCZlFhdWlKc1hkNDIxeEl4bm90UzkxMjdsbWt6?=
 =?utf-8?B?MnFvS2VPVUkrY0xlcjdnRzBJRS96Y2I3SmQ3dVVSdS9qZjJiSUphRHN6cGhu?=
 =?utf-8?B?YXZ6SkFmeUZ1ZTc5eG13WThvTTI4ckZpZWRMSW5wMG8rSWR6TW85QnlrZjcv?=
 =?utf-8?B?Y2FHZG0rUWt1TjltRHlmRlRaVnJxRjZaRllvb0Z3NEU5RWxtZWJvckZmdnpp?=
 =?utf-8?B?eWZQNGRiaTJKMzZoSnp1ZVZQdnNhL0xGVmx2Rzlic2RwcUlXQ0I3WW8va2E1?=
 =?utf-8?B?eUFROG5jbFpCcFAyeklnL0FrT054S2pRVlBMeVdLNnJQQ1o5a3JOdWRMWlFM?=
 =?utf-8?B?cXg0R2h0QkpINUpRVjR4aEMyYWFOKzk4OTJLUjNPUHZselM1Wk5nYzA2S0JV?=
 =?utf-8?B?cDU0YjdvcjBGTmltVnk5R2JUMEhSdVI4QzUyVERsUUhxM0E5czZaTmN6UE5o?=
 =?utf-8?B?MWUrall1empWakdJbEZNcWpsL3Eyd0lydkRDaklFazU5ckdsaWVMMHNRK3ZS?=
 =?utf-8?B?U2RYK29KL2F2c2dSNE1IUFlWSEJ1ejVCeWhFK2tzNjBUVWdPTlBCK294b3Fl?=
 =?utf-8?B?UUw0dXBqWGhrYUMwbExHSUMzcFB4V0xJUnVvN1Rhb0ptNVh6Wm5taTFEQXp5?=
 =?utf-8?B?VXR6VGtuNzBDWkxEN1d3WWQ3Ukw1V0FZZDJCWDR2MlQ4MHVEY0l5TTlaU3B3?=
 =?utf-8?B?N3BxV1hFWDJEalpVREdwS29JelcrNjd4NmdpLyswM1gwVkJwMG4yWGFjV2hs?=
 =?utf-8?B?MEE9PQ==?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agQDPzoZXBnP8Kh60+SAVQUIUfhP3060C4UMFSZ+TcKKa4wbIz7N2ksS0iQAvnCOw6N6gG9nm3MR0D0D7kJgFRr4wNATHKnHfM2Guuvw6pZBWkKOhm6wbVUM+C4rmrlsf8lOmNqMGX02g3fUO97V0Towl0Q33vEiDCtxaHOKj8+SV2ghX8/+rC0c+kOHNxBwioPrPHUPIA7hXmqksQuYm848RT9tGewO6/aZ21AL1Ep90NkibMQEcpQTOArnw6HvPEDskeYKX6C8o8kviNo8mmTBoQne3LBAyn+gDsRC0Qs3MCBlivua7ArlHDWsD7v9buLBdWGXEVXNV70L0KK6Bw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4F+3wKWn34emjkkNnWLXc6JP6wzhAlQCX6hqSYuc/8=;
 b=EMmNEKL83FacsX2T/wpK9pG7EgwVbwufsY6ptf8TSeWIZzgfDsRrmJkvQ5nj+zAKWBNkjmUjuPMxmLCilcCEfA+HUznaeZAx+SCBbigZLZ30VFMkN1753FRgwWQ40YvDKD+Ah9gcMzlOfMFt6ryP01TzYlOkORGqBpQG/jPy3FA35nmCfh5wh+27Bn+ozwXIXeXJRQmMKCzOyjxEzCvIHalfmYKaVWIb0tzP2hkT9wlPECcp3Y8h0uXw0bL7bLHOBqr96kVuEAdZNqzpQ/OovzVI4/Z93M0tY/44rzv4kNP8G5L5uD5asT10F2PwcLSzWELPj2TZ/HiObHa0JaE84Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA3PR11MB8985.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 33dbf6e5-2d64-4b0d-404b-08ddbe2fd522
x-ms-exchange-crosstenant-originalarrivaltime: 08 Jul 2025 14:58:00.4509 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: k7LD+Zj2j/r7bKK87ZZWJbuLiFHqd+ddbtIYx057v/90P4VHFYspFSbftZwo5Tmjj8sw2m5PreouSQHQI4EOEtyMhzJu3VP50MXm8lGNM58=
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR11MB7300
x-originatororg: intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBKYWNvYiBL
ZWxsZXINCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTksIDIwMjUgMTI6MjUgQU0NCj4gVG86IElu
dGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc+DQo+IENjOiBL
ZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IENoaXR0aW0sIE1hZGh1IDxtYWRodS5jaGl0dGltQGludGVsLmNvbT47IENh
bywgWWFodWkNCj4gPHlhaHVpLmNhb0BpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFU
Q0ggaXdsLW5leHQgNy84XSBpY2U6IGF2b2lkIHJlYnVpbGRpbmcgaWYgTVNJLVgNCj4gdmVjdG9y
IGNvdW50IGlzIHVuY2hhbmdlZA0KPg0KPiBDb21taXQgMDVjMTY2ODdlMGNjICgiaWNlOiBzZXQg
TVNJLVggdmVjdG9yIGNvdW50IG9uIFZGIikgYWRkZWQgc3VwcG9ydA0KPiB0byBjaGFuZ2UgdGhl
IHZlY3RvciBjb3VudCBmb3IgVkZzIGFzIHBhcnQgb2YgaWNlX3NyaW92X3NldF9tc2l4X3ZlY19j
b3VudCgpLg0KPiBUaGlzIGZ1bmN0aW9uIG1vZGlmaWVzIGFuZCByZWJ1aWxkcyB0aGUgdGFyZ2V0
IFZGIHdpdGggdGhlIHJlcXVlc3RlZCBudW1iZXINCj4gb2YgTVNJLVggdmVjdG9ycy4NCj4NCj4g
RnV0dXJlIHN1cHBvcnQgZm9yIGxpdmUgbWlncmF0aW9uIHdpbGwgYWRkIGEgY2FsbCB0bw0KPiBp
Y2Vfc3Jpb3Zfc2V0X21zaXhfdmVjX2NvdW50KCkgdG8gZW5zdXJlIHRoYXQgYSBtaWdyYXRlZCBW
RiBoYXMgdGhlIHByb3Blcg0KPiBNU0ktWCB2ZWN0b3IgY291bnQuIEluIG1vc3QgY2FzZXMsIHRo
aXMgcmVxdWVzdCB3aWxsIGJlIHRvIHNldCB0aGUgTVNJLVggdmVjdG9yDQo+IGNvdW50IHRvIGl0
cyBjdXJyZW50IHZhbHVlLiBJbiB0aGF0IGNhc2UsIG5vIHdvcmsgaXMgbmVjZXNzYXJ5Lg0KPiBS
YXRoZXIgdGhhbiByZXF1aXJpbmcgdGhlIGNhbGxlciB0byBjaGVjayB0aGlzLCB1cGRhdGUgdGhl
IGZ1bmN0aW9uIHRvIGNoZWNrIGFuZA0KPiBleGl0IGVhcmx5IGlmIHRoZSB2ZWN0b3IgY291bnQg
aXMgYWxyZWFkeSBhdCB0aGUgcmVxdWVzdGVkIHZhbHVlLg0KPiBUaGlzIGF2b2lkcyBhbiB1bm5l
Y2Vzc2FyeSBWRiByZWJ1aWxkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3NyaW92LmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV9zcmlvdi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9z
cmlvdi5jDQo+IGluZGV4DQo+IDRjMDk1NWJlMmFkMjBjMzkwMmNmODkxYTY2Zjg1NzU4NWZjYWI5
OGIuLjk2NGM0NzQzMjIxOTZmYTg4NzU3Ng0KPiA3YWMyNjY3YmU1ZDU1MGE2NzY1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3NyaW92LmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zcmlvdi5jDQo+IEBAIC05NjYs
NiArOTY2LDEyIEBAIGludCBpY2Vfc3Jpb3Zfc2V0X21zaXhfdmVjX2NvdW50KHN0cnVjdCBwY2lf
ZGV2DQo+ICp2Zl9kZXYsIGludCBtc2l4X3ZlY19jb3VudCkNCj4gICAgICAgICAgICAgICByZXR1
cm4gLUVOT0VOVDsNCj4gICAgICAgfQ0KPg0KPiArICAgICAvKiBObyBuZWVkIHRvIHJlYnVpbGQg
aWYgd2UncmUgc2V0dGluZyB0byB0aGUgc2FtZSB2YWx1ZSAqLw0KPiArICAgICBpZiAobXNpeF92
ZWNfY291bnQgPT0gdmYtPm51bV9tc2l4KSB7DQo+ICsgICAgICAgICAgICAgaWNlX3B1dF92Zih2
Zik7DQo+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgIH0NCj4gKw0KPiAgICAgICBw
cmV2X21zaXggPSB2Zi0+bnVtX21zaXg7DQo+ICAgICAgIHByZXZfcXVldWVzID0gdmYtPm51bV92
Zl9xczsNCj4NCj4NCj4gLS0NCj4gMi40OC4xLjM5Ny5nZWM5ZDY0OWNjNjQwDQoNCg0KVGVzdGVk
LWJ5OiBSYWZhbCBSb21hbm93c2tpIDxyYWZhbC5yb21hbm93c2tpQGludGVsLmNvbT4NCg0KDQo=

