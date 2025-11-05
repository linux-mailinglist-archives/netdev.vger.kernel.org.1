Return-Path: <netdev+bounces-235747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FBC34835
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6AD4611C9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515012C0275;
	Wed,  5 Nov 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVs+H73W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE621CC6A
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332017; cv=fail; b=eiJxCB+4nWK+oniow5FpWxJFjxSLwdlKmbnpA3inuneloMekha0L8Ml54FCCJppXG7p/r4A17UxAfayYuToJeB93g+vWKTPmtOoLLawrV0jnCd0BwcG4MOj7S1B7uM6tiC3wQVPL6g/byuqgbBb6v5LTWwdXINhThPwqHAS7liI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332017; c=relaxed/simple;
	bh=taLvN0B3T2sV7soQm9gGRduXAG7ofs50DQSAHNJZ20A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asH0e7JZHb9vO6gJMs/9ds2ZNcNTECn/tHkc8p5f41/e5DaVaFfunOLFq+kod0Stz3KCfFxEX6Ggsu6jL+c/ewfZ0Sq6vzA9UWcDliKsufbHrpJJDMvJoMViZZN8JzIN3pdNWB6HGM9zFeQpNZshYzE8B21NsrkeOHr753QNNVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVs+H73W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762332016; x=1793868016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=taLvN0B3T2sV7soQm9gGRduXAG7ofs50DQSAHNJZ20A=;
  b=RVs+H73WKX0k70BAmHYXYJRSQebAy5awb7NMOiwgeKj43djKjisDx5CB
   AcEbuwLHI/OjeERR4Ox538Pw5A3Kuck8ANDkuZ8DOcY0OrMB8052s+ody
   slGsmh+NEloWzdn3lYV8VKEF2HQEIYLikOBWXkzl00Ysz1MmvwRZcHX/Y
   xCyoClXbYLhTWq6ZEwpQcmxs/VxBrfXX6jBclYsCUzamk+jTV7zEVCF+c
   2ZNtA1f0FQCbcidy8yuVG1BIFWLSLU5JElCS0g7lSsMsFZxvAqdlqgrYh
   BagWZeiH/fxa0iN20aCVzoMSvbBdbtHFzZ3+cCas8A8srifbq5n8d4YqA
   A==;
X-CSE-ConnectionGUID: HRz1sZ5rTqW9ninwfK/dgg==
X-CSE-MsgGUID: MgRGF+BWTNaWH4eZm4CiZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75889509"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75889509"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:40:15 -0800
X-CSE-ConnectionGUID: FWVd5brpTJeA8QFz2fCvOg==
X-CSE-MsgGUID: YQ3fnVTWQrmvZBKm2TqJgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186684355"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 00:40:15 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 00:40:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 00:40:14 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 00:40:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMxT0/JIbqaTwocvQhRGt5903XpXEhls5P0Yq28kyzuNWuZzU2bwFeHdsUhX8AaNZIgvlOGvR7Qzl7NoftzPce6SaISjJIoVxT/7vhzSXcJwRiVD6+kPxus9HW3BKCvnPSkT2emMFWG1QhYmXFz69loVBLsFY/hajVzOSfIlgWUAtdc02/jJqh4+VG8HYFsWjr+K8It3obydHYYGYi9qTKokxh+01fH8u3TDSMdw+B9lOoYxat/cn6GgwqXzP/4D9EPZLlovpFL2ue5zuDyPBYhyGCeBpDgSb7CrosWdgNfrYTMQqZfqZErTewRGXQB7ED2apnXNfBJ9pP1Kw7TfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taLvN0B3T2sV7soQm9gGRduXAG7ofs50DQSAHNJZ20A=;
 b=BBS92C2HTqGh8c6MSIua9yNgwA0TyEmWH9LOqLpOmy4IbB/SvjAc83yo8MOVt2G7SgPsbAFBlp6Smci8cnBeOQOAi9G3E1ZpV+E09MonSx6rttnIpeGEvJ/QUA/C8UU3GOrx5v4II6EdNTIncwtJ1qMSSLwNTRSZ4R5b9rdmzjZNZO86bECSrUv82Y5tnHqTRoEno/l0PAmc2iCHhIWuT1nmEUFTjlK8LVWemZoSVg+fToyTuRq6wph507elsv6Z15Al5Xjv0PaNQmqijHjY93oRmdv98yi4xulZfi4fkGsKp9bcoLVxPZsWYhm42znt2Mc1mXtOOHd85NAYWzw2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 08:40:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:40:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [External] : RE: [Intel-wired-lan] [PATCH net-next v2] iavf:
 clarify VLAN add/delete log messages and lower log level
Thread-Topic: [External] : RE: [Intel-wired-lan] [PATCH net-next v2] iavf:
 clarify VLAN add/delete log messages and lower log level
Thread-Index: AQHcTZ0IkgEDbSYX0kmbwdo5tWm1RLTjsEmQgAAIgYCAAArhEA==
Date: Wed, 5 Nov 2025 08:40:11 +0000
Message-ID: <IA3PR11MB8986C6192990882A8B0C7C99E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251104150849.532195-1-alok.a.tiwari@oracle.com>
 <IA3PR11MB8986153AC57FBE801247FD50E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <9e736c4a-bafa-44e6-9152-3a9de078ee4c@oracle.com>
In-Reply-To: <9e736c4a-bafa-44e6-9152-3a9de078ee4c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB8116:EE_
x-ms-office365-filtering-correlation-id: 921062f0-8734-4628-cda0-08de1c46ef07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Mit3bWc0MS9tcXl4SG5aMEtSSDFtSllneTJMeTdZbFAzOWcxZ283WDFHd3lJ?=
 =?utf-8?B?aEJYODl2SlBqekRTVTRadXJVYWMwaXk0L2l3dFNYWDVGMDZLN1dhL0UyMzI0?=
 =?utf-8?B?VytwVUJxTHdlRFVnSnpzc2lyVTlrckJBMXluL1poS3FSY29VMWhZem5xYUt4?=
 =?utf-8?B?QW1hSExsWlh3Wjg5b2xTNEtsS2RLaUVQS2lyRlgyRUN4QjlWSGErYnkrZzBX?=
 =?utf-8?B?cDFRSXp2SnM2YTVsaUg5YVV4ZkgrT2N6TEtHY0UrK0syYWlrV1RWKy9NRVFT?=
 =?utf-8?B?S1p4UVJtaWgzSFVCSksycHlqMkRpTDNwQ2o2Y2FMS3crdkFqbkhGOERaWjZq?=
 =?utf-8?B?NXoxK2xXc0ZoUmhJcDkraGxkejZLN2xFTHl2Y1RsS3RjbzJoQ3A2YTYya0tO?=
 =?utf-8?B?QVl3VkxleXNNL2UvMzJ6Z1VqUGIrOEVNbzdGZ2RHd0IvTythZVlPakVFbldD?=
 =?utf-8?B?UzJVK1NhVWJjM1dFWFVRWTJNbmNUT0tOc205azlhTDhZQWw1WjlKL1pxa1pR?=
 =?utf-8?B?em96N2VzUHphZFBTbHRvaVJwakpza0JUWVdPa25kdk9zQXVBaFdQS3Z6OUNn?=
 =?utf-8?B?cXVzT2pjZ3VsMjdCVlE1ajltZzJyQTEyQ2M2OFgxTHFoRHlnVFExQVB5aitu?=
 =?utf-8?B?clRYT2lXUGNRK0dXdTZFQldFelpTZDdLQ2dCa3N1Q0RZcFBmSm5zanBBemtq?=
 =?utf-8?B?R09CL2o1dHpPN1Z6TkxzRFZmejd6T2hDQmc0SGhPRWFla0Z2aTVnOVlJeWhO?=
 =?utf-8?B?MXppbUM3U0wyTjZqQ3QyaVJlWDFreGd5aDVxckZ0WWVxV1dyRmZyUm1STzhV?=
 =?utf-8?B?R2w4cVV3bXBFZ0FDd0I0OU1WcHpzNUthMDBFejFVRWQ0bFFraTZiYkpLd1Bz?=
 =?utf-8?B?dTZCNUtvNk5vbUNodnNxS3JFbkdJQk5mRVlpR2oxL3lzc0lCcTdlNnQrdHh6?=
 =?utf-8?B?UnVSTGpGeTl1TElXUnpJUUhKUlFPY0lrQXhHbEJGejFVRUpES3dxdlFYdzcr?=
 =?utf-8?B?dVBUU1M2WmJmblI1VjlWUEFrZ3NuMndpQUp0cDNzN2dTd2J0dHl4NlJIOTZF?=
 =?utf-8?B?OG53NjlXbW1OUFZDT2k4UnUzU2dvZE1Tb1NTWDZyZDZkYXNmcnBQM3Q2am5J?=
 =?utf-8?B?ZXdFTlBXTHVVblNJVXRLUENvc3VBUlJmNTVsNFJadGlEeHlXNnJtVW9FbTBw?=
 =?utf-8?B?cm1oeU9Pd3M5bm0wQlZhM0xNQnJ6SnE2T1FDMHdxNUlpUlpQVm5PczZLTWx1?=
 =?utf-8?B?a3hUWE5KOUZmMFg4VGJsU3J0Umh1K0xoWHlQWEllRjBLdXpyRlNmbnBtNGFm?=
 =?utf-8?B?R1BHeG1jR1lyQmV3U3RTVWlBVDcyaWpUVFlya2NFVllueS9XYWFoVllRUGwx?=
 =?utf-8?B?TXdHUUY2Y0lSZHNwZFVYTmdmMjN5QjdVZ1JudFZUQzdmZlBTTWxXU2JZY1RN?=
 =?utf-8?B?alNTTzRqazVDVTJ5ajhaQXM2ekFDcFdJN05qR1RpUUxOQXk2SHJ3RnJnVHU4?=
 =?utf-8?B?NEJsaXVGYVdhNTZUbk8zQmN2dlZjRUlSWlNLYjlhZHBSNXVMUkNEREFNMXhV?=
 =?utf-8?B?c0NpZVpUQWppUzJXY01oOThsM3FMd2tkTXJORXZ2SjVUcFAvdmFKR3dkZGVI?=
 =?utf-8?B?UnJZWGl0MUxmSnN0QU1HOWd0clpnNkozQm5Yek1uSWlpbGpPclU5SjdtdzBN?=
 =?utf-8?B?a0NwOEFYTjFTa3NKbXdqUW1Faks3aWZoTGM1Z3VBVjZzSnVXdnBOclVsajBE?=
 =?utf-8?B?bGNlM0hHMzBLZWIrU2dDb2tJQUxzWG9CM1BpVWxyNXBmNXlqOFBuUDBXdzIw?=
 =?utf-8?B?bGFnS0JtSFVxQVJVMStZU2o0TFhGM3ZPejJSVWxBN2NrdEx6Z2Rmd1h3ZkJW?=
 =?utf-8?B?Mm5WNlg4a3B3WWtlY0ZXcDZoeUJGTUhGL0tTTHhZSndTR0pEazF0dTQ4Z2VF?=
 =?utf-8?B?bXRwNUU5Vi8zdDFkS1VGTHduZnlnSERVcnJyYnVYUDNLWmVOWGxJRkZidXdo?=
 =?utf-8?B?NXFRSkRxSHRETnVUSGNVY0x6MTVxcmJZRWNPVVpWdGhabnBiVEkxclIwSWRM?=
 =?utf-8?B?NjAyWUNhaU52QWVGNkdTc2VVeUpUVStSL0Rudz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEdmYXF3ZU1JQlRaRHFKdjR0WDJFMnJXMXhwOTlQUTJMb3F2RDdhdDVjR0p1?=
 =?utf-8?B?TEU4aGU3bnF5TDI4SmFWa1V2OEJzdjJkb3hxeWFCUW5mUnFxeS8xa3lMNWcv?=
 =?utf-8?B?d2FXWWRxQUJQcWk0TUhLT2REN1Blam5pbFg0TVNTRU5DV25tSzJKNUtOT05P?=
 =?utf-8?B?REY5ellkc05FZm5JKzZBZ2poeTJYWmRLNVdicm5ITC82bU5ZS2FLclQyK1pQ?=
 =?utf-8?B?ekxBVUxQd3NDb1BEbllpcHFCNHp6RkZIRHVWakxqdGVHTVB4cmtGSDdjSTI5?=
 =?utf-8?B?SzU5VmN4cE0zd0ZkaENDV3A0bjkxTDRSM1N5YTZQbGVrUWpublFMZGxGZjZT?=
 =?utf-8?B?ZkZHeWY1aElDNmlQS0pubEM1RHlxNFZXWGJ1RGtJcG5kcmNqaTNhbkhrWVla?=
 =?utf-8?B?ODRXUEFYdWUweXdrTUN2Vks2OTNRdytQSDBaakxVUWJzN2l6TUFUWGF1MHZK?=
 =?utf-8?B?blpCWEtqUHNkL2t3di9HV1JhM2dLM0tIZHBTQTJFWnFrM0lWN3BSUlJwSUxY?=
 =?utf-8?B?SCtMZjFCdU00cEFORGhQZXVJS2dXa0V5Z3RoUkJMUjFKL09PU3M1MWNJV2cv?=
 =?utf-8?B?bXE3akplZTFNbFM2SUoxTEdVcGtRMmZkUHA4Wm5tcjZldXMzSmdpTWVpMk5p?=
 =?utf-8?B?ajA0ZzhjMzlOUGFCK3VCVUZvRkM2VnRHdWI0N01QUDZqM21kQUFOM05VaUtE?=
 =?utf-8?B?NnpUcnZXNHRHamFUazNzQnU5aEZQb0xXbjkwb24vQ0hCUitPQ0R2QnpqMVRM?=
 =?utf-8?B?NXFtbXkvdlVUQk83clhhUjN2eVRWVkhWZWxBZGRpQ1FpTmtPVW9HVytWNnZ3?=
 =?utf-8?B?dG5xZjVGQ1FmbTVXSkNBVmxtNmxqYlVGNzBLdUxRa2R2YUd5WEFpa3FCMita?=
 =?utf-8?B?NFNLdStyQ0ZmWE1DR09YZTY4WUV5dDR3MTV6c1QxOEg1WVYwNVdzNnZwNG1x?=
 =?utf-8?B?SkVNeCtNbXg5MTJaZFFMVVZEMU9OVUVBV1J1QW9MbytwSEMvTUExK3NjVU9k?=
 =?utf-8?B?T243dzF2aVJEeVlsc3A0c0dqMVN1RWt0RjRrd0k0YjJTTzBNRndWWmVrSEQz?=
 =?utf-8?B?aWpXQmQvdWtJMzFITUYxa2cxeG5uSlpKNXhTVjZNMzhpN3BlM2VXOU9EY2xk?=
 =?utf-8?B?WVBjRWVMSHovZkRTV1oydWYrYmxabS9WTXhic056YXpyZHVWRGpzTitjVFVQ?=
 =?utf-8?B?SHF4SmNvbHY2V3Azc09zZ0lPN1JLSlZMK1lkUWZxUDY3OXY4WEllelpYWUFU?=
 =?utf-8?B?eHcwSUxXcERFWERsamNPZVFWaE5mQnhWUEhTMVorbll5c0lZWTBPeGdQZ3Fz?=
 =?utf-8?B?T1hjTjRPdzhQdk5Ub3dkQ3FyWU11N0ZpQVlFS3c5L2JWRDV1dC9iallkNU51?=
 =?utf-8?B?eVVhUGpNZmdHTXZUcmx1STFnUFpvcHBnL3V2QUl1eTdTQzZQdFVyMHY0QzJn?=
 =?utf-8?B?dVkycWJYU3pNVnozVEd2L1dwZDBOT1hmdlF3SGlmTUh4REZ6d2w5amRSTU13?=
 =?utf-8?B?RkpJYy92Rnk4TFlrWnBzejhoMGhaZmxoR3VIN0JFeDJtbHpraURMUHY3cHJY?=
 =?utf-8?B?L0VSK01xZnR1VUtPWXZrVUgvaCs3eGNXbXRIa3B0VUxjSDIxS3FLWnBjQzZt?=
 =?utf-8?B?bjN4RHcvTXR3dnhacng1UkorRDdHYVhma1ZaWUdlT2Yvd3ExWCtmcHVDVDFY?=
 =?utf-8?B?L0dnKy90RmtsOXlpMGU3UGZwMGRrMUVrYWhyNzNTL1JUVGxSWENPUU5JOWZh?=
 =?utf-8?B?V0N4c3NtaUJWUkVPZFFPS0dvYkk2eGNkdjloTlMwTy9mQ25ZUHRjT2loakN0?=
 =?utf-8?B?c0wyTTJzWGRUVi9SRGJ2T2pkdDNJcUVxd1l1STVmbFFFVzdkSEN3WWdaYVB5?=
 =?utf-8?B?TTA4SG1nMzVPWnRqWmFEVGZHOUZwQ2JadVlnRDF0eE0xekJidkdpSWlvL1JN?=
 =?utf-8?B?cmVWK3VQdWhQb05aanlYRmMzeGhSdzJac2RkelYzRWNuSFZ2UDFtd2lsZVdE?=
 =?utf-8?B?VUY4bkNwMmhJOTNmMGppVnp1T0JLUFBoUXBrSy85TEV6OVBoMWJ2V2szbGNs?=
 =?utf-8?B?WVM5LzMxbmpuZ0Jwb3FweEY3QzVKRTdNZ0dQUG5kUkVYbWUxWnkzV1FyTWMr?=
 =?utf-8?B?Z3dvTUlNR2lWc01iQWRwRjJOeU9ya3ZBYVcxd1h1Z3NBRTcxeGNWTktaZ2JI?=
 =?utf-8?B?VUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 921062f0-8734-4628-cda0-08de1c46ef07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 08:40:11.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPg9eVoSpoWsXhpW5uYWDX3rqZyQmWN7soS/n7JGXPW/uCRC3h36QMMPsX2rNZ+SzyFHn5apJbghkY/SQr+MHRG00EKN3jDBiOvu68wByz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQUxPSyBUSVdBUkkgPGFs
b2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA1LCAy
MDI1IDg6NTkgQU0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3pl
bEBpbnRlbC5jb20+OyBMb2Jha2luLCBBbGVrc2FuZGVyDQo+IDxhbGVrc2FuZGVyLmxvYmFraW5A
aW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwu
Y29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBrdWJhQGtlcm5lbC5vcmc7DQo+IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOw0KPiBo
b3Jtc0BrZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsNCj4gbmV0
ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogYWxvay5hLnRpd2FyaWxpbnV4QGdtYWlsLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSA6IFJFOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0gg
bmV0LW5leHQgdjJdDQo+IGlhdmY6IGNsYXJpZnkgVkxBTiBhZGQvZGVsZXRlIGxvZyBtZXNzYWdl
cyBhbmQgbG93ZXIgbG9nIGxldmVsDQo+IA0KPiANCj4gDQo+IE9uIDExLzUvMjAyNSAxMjo1OSBQ
TSwgTG9rdGlvbm92LCBBbGVrc2FuZHIgd3JvdGU6DQo+ID4+IFRoZSBjdXJyZW50IGRldl93YXJu
IG1lc3NhZ2VzIGZvciB0b28gbWFueSBWTEFOIGNoYW5nZXMgYXJlDQo+IGNvbmZ1c2luZw0KPiA+
PiBhbmQgb25lIHBsYWNlIGluY29ycmVjdGx5IHJlZmVyZW5jZXMgImFkZCIgaW5zdGVhZCBvZiAi
ZGVsZXRlIg0KPiBWTEFOcw0KPiA+PiBkdWUgdG8gY29weS1wYXN0ZSBlcnJvcnMuDQo+ID4+DQo+
ID4+IC0gVXNlIGRldl9pbmZvIGluc3RlYWQgb2YgZGV2X3dhcm4gdG8gbG93ZXIgdGhlIGxvZyBs
ZXZlbC4NCj4gPj4gLSBSZXBocmFzZSB0aGUgbWVzc2FnZSB0bzogIlt2dmZsfHZ2ZmxfdjJdIFRv
byBtYW55IFZMQU4NCj4gW2FkZHxkZWxldGVdDQo+ID4+ICAgIHJlcXVlc3RzOyBzcGxpdHRpbmcg
aW50byBtdWx0aXBsZSBtZXNzYWdlcyB0byBQRiIuDQo+ID4+DQo+ID4+IFN1Z2dlc3RlZC1ieTog
UHJ6ZW1layBLaXRzemVsPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEFsb2sgVGl3YXJpPGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gPj4gUmV2
aWV3ZWQtYnk6IFByemVtZWsgS2l0c3plbDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0K
PiA+PiAtLS0NCj4gPj4gdjEgLT4gdjINCj4gPj4gcmVtb3ZlICJcbiIgYi93IG1lc3NhZ2UNCj4g
Pj4gYWRkZWQgdnZmbCBhbmQgdnZmbF92MiBwcmVmaXgNCj4gPiBXaHkgdnZmbCBhbmQgdnZmbF92
MiBwcmVmaXg/IEZvciBtZSAndmlydGNobmw6JyAgJ3ZpcnRjaG5sIHYyOicNCj4gbG9va3MgbW9y
ZSBjbGVhci4NCj4gPiBDYW4geW91IGV4cGxhaW4/DQo+IA0KPiBJIGFtIHRyeWluZyB0byBmb2xs
b3cgdGhlIGNvZGUgcGF0aCwgYXMgdnZmbCByZWZlcnMgdG8gdGhlIHZpcnRjaG5sDQo+IFZMQU4g
ZmlsdGVyIGxpc3QuIEl04oCZcyBqdXN0IGEgd2F5IHRvIHNlZ3JlZ2F0ZSB0aGUgbG9naWMgYmV0
d2VlbiB0aGUNCj4gaWYvZWxzZSBjb25kaXRpb25zLg0KPiBFaXRoZXIgJ3ZpcnRjaG5sOicgb3Ig
J3ZpcnRjaG5sIHYyOicgYWxzbyBzb3VuZCBnb29kIHRvIG1lLg0KPiANCj4gSGFwcHkgdG8gZ28g
d2l0aCB3aGljaGV2ZXIgeW91IHByZWZlci4NCj4gDQpUaGVyZSBpcyBvbmx5IHNpbmdsZSBtZW50
aW9uIG9mIHZ2ZmwgcmVjZW50bHkgKGp1c3QgNHllYXJzKSBhbmQgb25seSBpbiBpYXZmIGRyaXZl
ci4NCnZpcnRjaG5sIGV4aXN0IGZvciBkZWNhZGUgb3Igc286DQoNCmxpbnV4L2RyaXZlcnMvbmV0
JCBncmVwIC1ybiB2dmZsIHwgd2MgLWwNCjQzDQpsaW51eC9kcml2ZXJzL25ldCQgZ3JlcCAtcm4g
dmlydGNobmwgfCB3YyAtbA0KMTI0MA0KDQpQbGVhc2UgdXNlIG1vcmUgY29tbW9uIGhpc3Rvcmlj
YWwgcHJlZml4Lg0KDQpUaGFuayB5b3UNCg0KPiA+DQo+ID4gVGhhbmsgeW91DQo+ID4NCj4gPiAu
Li4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IEFsb2sNCg==

