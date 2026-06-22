Return-Path: <netdev+bounces-301140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bt4TOodLOWqIqAcAu9opvQ
	(envelope-from <netdev+bounces-301140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 625336B0766
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=favbxEIK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301140-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8AF230316E6
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BDE2E717B;
	Mon, 22 Jun 2026 14:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BBC26ED3E;
	Mon, 22 Jun 2026 14:47:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139637; cv=fail; b=ZpwnSS1IpMZwuO88TfRPWwOLPf20Ffo1xLyiViA3vTrKCAfHPwcE1svZN82+YZQ59uOB+YNtXoQwQEQrgQf1mMZI+qndBjkYIB1G7JBRQJxGRpygazxeK+vvMY9xnFrEH5pazhYRcqBdI2XN/Ye9WzOHwFEQl5L0p+WdCv06c6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139637; c=relaxed/simple;
	bh=JXcNxdAwrcc/uHQYyxqCBqORl8VHsvgwigVvw7M9tng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DuyvKHfVPp8yoym9Kk0V+DNuQ3nDE26tGzqxbDHdVBHRD0OTrI30Mtl/HTHZ958RBj+KO0vjTEZlE+iv3Or6GNfISYx+uYXc6u3YOEB7fY7nis++3ml5W6Um1oQU1hEZF9eMbKHL2VYL8SW72INdpbq93X+eexcrED2QSJJUtGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=favbxEIK; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782139636; x=1813675636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JXcNxdAwrcc/uHQYyxqCBqORl8VHsvgwigVvw7M9tng=;
  b=favbxEIK29m4Jffsia0576BO3dMLWLFxbiV/vdQ4p42gyTOdMJmRPuLg
   vFcVBANY/sMCQuYVD9JJEQJLjpzcdRSHSuK/MHVL6fx7MmcL05SLbDqEb
   YPHU9AxATiulSQo8yC5nZXZhxPMS2OtpCuQkuuQXBGmiMTEgKtmzYNudp
   yLT4yWC30zMogzGA6Jh3aEC47O2xCPd2dSDtLeXZMLJMCwAZFZPykcdde
   rC+aqUTmDiY8dG75I1/QnOQI74p/4pdd0iyDD5aJIPiQQAgEpE9Yuuz1N
   k2IkHxdV+n0/bzilC9ctCiIQB6n4NtzdOGptHlvXsDgtMsZ0Tmk5nIvQ9
   w==;
X-CSE-ConnectionGUID: cUE0LZK4R1irxfBygsSR6A==
X-CSE-MsgGUID: 8tjki2v1Qne2OpEruTSUqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82639388"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82639388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 07:47:15 -0700
X-CSE-ConnectionGUID: zDdG4qyHQUKgu1nvlMDWnQ==
X-CSE-MsgGUID: agOoTcOaTL6RD65lW8Kyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="245099297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 07:47:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 07:47:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 07:47:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 07:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRL/4M0s4XKj2Shx0eC30yS5IMd2fvSCklgJCOjs/Dy9Z+BkztZX+BX0KWg1SrLkD0c0pjS9LuIDiJgw+tnh8vuQ1GkOGOB/3NgxnK0IUnr/0VhUsKhT3xUvC21YGARgFg76BFWAs8xiQAA8r384EWtgQTNNQzp9g2aLMhjzRzDmTgmKoB016RJibxCgaLBA4i6UPi7ZAsyh0FY9rAS7FrAWTHsllJJT9L4w8QCmrTUl9P9om8phdtSus+WrGZm5lNwKt1J/T4piemmK/Reabayw+cTQCDFMDcEcS2lvHKqd7iBWvdZj21QTF4iec08OZSGEP5etRGOAYJ+cVFMBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXcNxdAwrcc/uHQYyxqCBqORl8VHsvgwigVvw7M9tng=;
 b=fOfKGQsZbnKbSzo7t0fsuXkfqeLSiMNUNZAM/xn6Nk2KMEvGS66snoRS34tfVch/vaBlVBJmqyBsTRAnzVsQPE+KczYYyuc9OJbA7GMI1BwfpmZYSVhG1pnHFt2a+lXFUGGDRIlUDLSXODYVk7V8BzpUqADQGNFhIRF/1qvImuLRA8xwHCQyYq108RQ03N/I7hI4AyHcvLVTJ/7eLOgYyO2Pv2F+2LGrz2vzkhS3ecyxcNmemB4crxFjJPCDkmC17T5CM2S4AKY02FVNC6LEF9S05IjGksiHyeXVktD+YPHJaxHD5rT5OsZarfx5ZEwrxaGipzg0sr43sqWgs99d7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ0PR11MB4894.namprd11.prod.outlook.com (2603:10b6:a03:2d4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Mon, 22 Jun 2026 14:47:07 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:47:06 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Donald Hunter
	<donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, "Schmidt,
 Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, "Vaananen,
 Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Topic: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQgAAWBwCAABGk0IABDEQAgABT0HCAABLVgIABXZxggABB2QCAAVXzgIAGRr2AgAL8fYCAA6K/AIAEMQeQ
Date: Mon, 22 Jun 2026 14:47:06 +0000
Message-ID: <DM3PR11MB8735FA6F3C1870A4233B9DB59BEF2@DM3PR11MB8735.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
 <aiqkZhNdt-WhglDg@FV6GYCPJ69>
 <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
 <CH3PR11MB8749910F17977B951A8B12CA9BE42@CH3PR11MB8749.namprd11.prod.outlook.com>
 <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
In-Reply-To: <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8735:EE_|SJ0PR11MB4894:EE_
x-ms-office365-filtering-correlation-id: 196817b1-c796-4728-cf19-08ded06d21b9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|18002099003|18092099006|22082099003|11063799006|5023799004|4143699003|6133799003|56012099006|3023799007;
x-microsoft-antispam-message-info: fwmywr4cXalCf7d121pjm4OhH3MOMPxWd+Kaq0LRsVgXkcViLocgiE+B/PDsk9TSyd+VoIfWJ46EUTVeUELgBesJ775yqlDTZlosCWF9gEbATaeJb+v8O+K6tHok1A2s4u8QYTX8eTN9Gu+o0OAunRh5EeGLtNeYj0pI1bU7X0b3HJEbxsR0M+e+oNL2vElnCejCTk0Xtue0CjmFt85qIgmtgsjBBToe1CtdYCaOGO5bY5E1n2ql14mvRwOwMT060Pt9xPrFcA23/Z1OUg9Evp94EXyVMsczfniwGVa6kCBsXh2CNHam65b0+OqLjmzFFsieHGGKYDIEPb4aGsxstJZNGtviC18qeTUhtJRS9dL/27Kpz5XYrgPYLg2wpZqvgwhypOYEA29hPgVqks5coC0AKc8pS3tUYqQ00RIfIODQ9+mzsei5jmPlbam5wcgVRgU+/xO3iEpo2jIVTCLaJwSCtLAgSvQr3LlpO1jLg0utCdg/NWUEN7kZpx/snHo5OzD+v00qlophlXhMHucata4fRynRrDWx8LWIqIijqr3nQrHMiDMJgvDphndenPsn8gPVdJC0zlt0nvHxz8t5uotUiKe/rG4byhzRkkSF21q89a4p1VZQUZjvBr40uUv0mzKLFumg8bbkj5KsddjYFtJNVdJxS5KNl0UhQS1uyOJm9+yb7JJDsyCOiwsZGi3YL1t1uQ/kTxA7aECRVdQ5Ugq9XawO68q7C/DhGlj7+zI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(18002099003)(18092099006)(22082099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRocmxNcUtRZmFyK0QrWW8xRzRpYkVONHhBaGRzWVJwQk5Ld01lWThkMHRq?=
 =?utf-8?B?eGJhcCtjTE1PNSt2QTFGNG03cVlKdzJsM3JxVmp5U2ZkcGZRa3hscHRxdnN4?=
 =?utf-8?B?UGlFKzludjJlRWk5SlM0QjVNczhoNUtRMWdBcE9jMC8rZmJ2Z3gyMWoydWhU?=
 =?utf-8?B?eUU1SEhUY3M3R3VNTjk3RU5JWTEzR3BzNGI2N0NTZEo4aXE0cFdoa1Qzd3dy?=
 =?utf-8?B?YTBiY1NBajRFWGRLL01Vc1REbFZ0T1k4SHBWWERodWZicmNpdFh5TktISnd4?=
 =?utf-8?B?WFNieVRqTERyMWFuRHAvVjJxSHBmaWZpOW01akhSQ0psUVpOS3pNMG5mZnc3?=
 =?utf-8?B?S200T1hnbjFYN1hFSE5zQkNIVmlsaTRWTU9CM1FOUTYzSjc3U2RXclpDZ0lO?=
 =?utf-8?B?TjNPaTQrTHhHVTJXVDNSK2ZpTEVXc1J1OGcvQjM5NmFWNUxWWkdBRnhKMU0r?=
 =?utf-8?B?WHVyNGRvUTZhYWo1d0gyWGlROGlrZ21KUXhiT1hFTlhVVFYxRmZsckZsaXRt?=
 =?utf-8?B?aWdkSHZoL1d3NzZSMk1OTHJxV1pBa1J2NG50VDBEVEFybXM0TGllK0c4eWtx?=
 =?utf-8?B?Z1lBZkZuVWhWbHdzRmpQLzNPbGpyd1NybWlVRmpzSEJZWExBcUZQSnNQVkRE?=
 =?utf-8?B?aW9LcitVNzZyWkVvZHp0azRjcmdFRXArQUtMZzF5YTZCRk9tYUYrOGxERE5T?=
 =?utf-8?B?WGJPeVUvbWhiZVN6SkFmTTUyUW5OTGVWTjVseEozV0duVS9udVZUS0Y5MlpI?=
 =?utf-8?B?a2FqaysvOVhNTndYa3N2ajI3Y29YM3EyM1VMbGIrRTRsWDYvcW9nT2x0Skdn?=
 =?utf-8?B?WFBBaWRPbmsyTnNiLzlKK0tyK3RlWnI3TVZwbVE1cDFrSlFnTnpxK3A5UEwr?=
 =?utf-8?B?Y05Gd2FKelprdm01L1dYWDZQdXp4N3RDYUtBSHJxOHJpdzlZQThvbDRWOGk4?=
 =?utf-8?B?bkNLYmFvOG9rVzR5TmdxVkNnMXE4UGFjb3l1MFhJSjhDVDd6RXVQOTJidHQv?=
 =?utf-8?B?NE51SlpSZDNwVWRmZWkycXVETk9mTkp4aGowTVlET3dBTE43a0tKOVFLNUJ5?=
 =?utf-8?B?ck5pK3dLU3NKZFNrWTNFYVh3RXZZVmsyblhOeGVNUGFlR3NqaW94U0VGeEZn?=
 =?utf-8?B?NVo4RlRNb1FvVnkxQmsxRk1hWEJDTVEwUWR3UEUwVjVRWFRsLy9yaDNaV29F?=
 =?utf-8?B?ZXM4bVduSCtjSzZjYkNIcmV0UUYvQnBYSnN6ejZicFllQ0czSXpxaER1THpa?=
 =?utf-8?B?QWRPdGNMb01ZUUROUVlyZFJ1RXVNTXFMRXdTM3Z3djZSLzltdW42ZFN5My9C?=
 =?utf-8?B?V3FoWWFkRmkwVVFScTdEdVNmMkUzUVVmSHB0L2lTdjVxVE41NG8yNW5BWFBj?=
 =?utf-8?B?STNxQkRtU3d1dmFvdGVzSjhLbllsUFJTVlU4UGxuS0cwc1dUM3dWbVFvelU0?=
 =?utf-8?B?Ymh0bTREUS92SStRVFVESjZvQmxjaFhOSjhUNzdhQUM3d3BjcHZLNGR4bmY1?=
 =?utf-8?B?Wk44R2xsSllZcFN1UWxuaHAxWnhwUXVPWWpPU3VWUlc4MDJhTEZzRURkS0or?=
 =?utf-8?B?UTZEM0NyaituMFo4MmtIUVpENUZtSUY0bVJZVll4YWpNa2dzNURVNXpDUWo1?=
 =?utf-8?B?TjR5VnJieHpreExuUWxYSUN6dW45amkwYURwVmZFMlpKQ1B4NTZ3cGhxMGYw?=
 =?utf-8?B?QXUyMnlEYTdkR3dZa0hWc2FNaEN2UG43bTVvLy9ndzNxY012VjdHeStqdVVj?=
 =?utf-8?B?dXdGanVwZXRHZ0lwRWlIRHpuMUtrWDBrSUlFK1MweVBQRkRKVGx1eXNmWGxz?=
 =?utf-8?B?SnUxcEQwRFoxMTlKV3h6ZXJvVmE1R2pIcWwwSUNQa3gwc0xYb1R5MjVLTnVh?=
 =?utf-8?B?RklvUEMzUnl5V0NmUjltcXJOK01HaGJEaHpaNENabjQ3YWJweTRXTEJZT2RV?=
 =?utf-8?B?TlRRbk9RbVNvZFpsNUlyRE5NRkUwL0djQ25jMW9ScGhyRlIxbUZNTkFSb2Zj?=
 =?utf-8?B?UnY1Wm96cW94dzkyczRZdUZvWWdGMjZuYjNTZCtnblJ5QUQwRnI2U0tWUks5?=
 =?utf-8?B?aEpsUmFXTVlibEtCcDdlUzV6NjQ0by9hNU42aWRxRU56dmJWQ3NJZXkrdHpw?=
 =?utf-8?B?SjcvWDl4R3FyNnhzTU1EazhJZDU2MWduTHZsa3krTWhBQVJzQjIycDREY0Zo?=
 =?utf-8?B?bXJtYS90K3FuQ2hQVWk5cHVXbE5NZVg0cEV6bHlnb1JWTUp4a1gxbFAvaUtx?=
 =?utf-8?B?RzJKK0l1L2NVMUdMTE9uOUNCRndSa2piSmR0WGE1eTNVaVFsazVWYTROdmlu?=
 =?utf-8?B?SEt0dVlscDJ5aUNiTlVGNUJUZWd2RmoycDY1ajdYUzN4WWh6aGRHVjR1cWxW?=
 =?utf-8?Q?/aUumvT3mCUIxTP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NaLVz3V4vA47zWevxUeonxS3F0+3zSQcDkIby0TwF7t2iVH2OewtFUX9cY2lcuoQFEx+v5995baiTlnsc3gEGnT29H+op/CYT/2ylRswtCFFl0dIXlRaUQwvC2b7nDnOFZJVeMa+fX8pe6s2faH7Wxa9KbhaS/9IFXLJzNhSIEvrIZidKppZcn1bK/YXxXwXi0PPIlG8RO237kAP9WSS91Tm+MVY27B6V+DrTYM+nYmGXIvu901IzpBICvwZLXvgygM/j0+0Ujq8usjk7e501cDtQOLMIBiKW/7MqDyka8ZcMl7BB2ijISiu02ekdsqdTJgt6H0pBhsEY+GQlY+N/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196817b1-c796-4728-cf19-08ded06d21b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 14:47:06.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFX5XCcNhng3cpQFGeiYvmQRvg8olBFPK2v2h+ZrpOCQdloV5NsecD2bpfe1R8cg7RG4okRZSofJdXAWE/jUvFwhZFN5ze3aNUGb/Bbrmrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4894
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,redhat.com,microchip.com,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 625336B0766

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogRnJpZGF5LCBK
dW5lIDE5LCAyMDI2IDc6MDggUE0NCj4NCj5PbiA2LzE3LzI2IDE6NTkgUE0sIEt1YmFsZXdza2ks
IEFya2FkaXVzeiB3cm90ZToNCj4+PiBGcm9tOiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQu
Y29tPg0KPj4+IFNlbnQ6IE1vbmRheSwgSnVuZSAxNSwgMjAyNiAyOjAwIFBNDQo+Pj4NCj4+PiBP
biA2LzExLzI2IDI6MDkgUE0sIEppcmkgUGlya28gd3JvdGU6DQo+Pj4+IFdlZCwgSnVuIDEwLCAy
MDI2IGF0IDA1OjQ1OjQ2UE0gKzAyMDAsIGl2ZWNlcmFAcmVkaGF0LmNvbSB3cm90ZToNCj4+Pj4+
IE9uIDYvMTAvMjYgMzowNCBQTSwgS3ViYWxld3NraSwgQXJrYWRpdXN6IHdyb3RlOg0KPj4+Pj4+
PiBGcm9tOiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQuY29tPg0KPj4+Pj4+PiBTZW50OiBU
dWVzZGF5LCBKdW5lIDksIDIwMjYgNDo1OSBQTQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiA2LzkvMjYg
NDowMCBQTSwgS3ViYWxld3NraSwgQXJrYWRpdXN6IHdyb3RlOg0KPj4+Pj4+Pj4+IEZyb206IEpp
cmkgUGlya28gPGppcmlAcmVzbnVsbGkudXM+DQo+Pj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSnVu
ZSA5LCAyMDI2IDEwOjUxIEFNDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBNb24sIEp1biAwOCwgMjAy
NiBhdCAwNzowMzo0NlBNICswMjAwLA0KPj4+Pj4+Pj4+IGFya2FkaXVzei5rdWJhbGV3c2tpQGlu
dGVsLmNvbQ0KPj4+Pj4+Pj4+IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gRnJvbTogSXZhbiBWZWNlcmEg
PGl2ZWNlcmFAcmVkaGF0LmNvbT4NCj4+Pj4+Pj4+Pj4+IFNlbnQ6IE1vbmRheSwgSnVuZSA4LCAy
MDI2IDU6NDggUE0NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBPbiA2LzgvMjYgNDo0MyBQTSwg
S3ViYWxld3NraSwgQXJrYWRpdXN6IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+PiBGcm9tOiBJdmFuIFZl
Y2VyYSA8aXZlY2VyYUByZWRoYXQuY29tPg0KPj4+Pj4+Pj4+Pj4+PiBTZW50OiBTdW5kYXksIE1h
eSAzMSwgMjAyNiA5OjQ0IFBNIC4uLg0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgIC0NCj4+Pj4+
Pj4+Pj4+Pj4gICAgICAgICAgICAgIG5hbWU6IGduc3MNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAg
ICAgIGRvYzogR05TUyByZWNvdmVyZWQgY2xvY2sNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgIC0NCj4+
Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgbmFtZTogaW50LW5jbw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAg
ICBkb2M6IHwNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICBEZXZpY2UgaW50ZXJuYWwgbnVtZXJp
Y2FsbHkgY29udHJvbGxlZCBvc2NpbGxhdG9yLg0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgIFdo
ZW4gY29ubmVjdGVkIGFzIGEgRFBMTCBpbnB1dCwgdGhlIERQTEwgZW50ZXJzDQo+Pj4+Pj4+Pj4+
Pj4+IE5DTw0KPj4+Pj4+Pj4+Pj4+PiBtb2RlDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgd2hl
cmUgdGhlIG91dHB1dCBmcmVxdWVuY3kgaXMgYWRqdXN0ZWQgYnkgdGhlIGhvc3QNCj4+Pj4+Pj4+
Pj4+Pj4gdmlhDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgdGhlIFBUUCBjbG9jayBpbnRlcmZh
Y2UuDQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBIaSBJdmFuIQ0KPj4+Pj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+Pj4gSG93IHdvdWxkIHlvdSBjb250cm9sIHRoaXMgaW4gY2FzZSBvZiBhdXRvbWF0
aWMgbW9kZSBkcGxsPw0KPj4+Pj4+Pj4+Pj4+IEF1dG9tYXRpYyBtb2RlIERQTEwgc2hhbGwgYmUg
Y29udHJvbGxlZCBvbiBIVyBsZXZlbCwgc3VjaCBwaW4NCj4+Pj4+Pj4+Pj4+PiBicmFrZXMgdGhh
dCBydWxlIGFuZCByZXF1aXJlcyBzb21lIGRyaXZlciBtYWdpYyB0byBzaG93IGl0IGlzDQo+Pj4+
Pj4+Pj4+Pj4gaGlnaGVyIHByaW9yaXR5IHRoZW4gdGhlIHJlc3Qgb2YgdGhlIHBpbnM/DQo+Pj4+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4gVGhlIE5DTyBwaW4gY2FuIGJlIGNvbm5lY3RlZCBvbmx5IGlu
IG1hbnVhbCBtb2RlLiBJbiBvdGhlcg0KPj4+Pj4+Pj4+Pj4gd29yZHMNCj4+Pj4+Pj4+Pj4+IGEN
Cj4+Pj4+Pj4+Pj4+IERQTEwgaW4gYXV0b21hdGljIG1vZGUgY2Fubm90IHNlbGVjdCBOQ08gcGlu
IChzd2l0Y2ggdG8gTkNPDQo+Pj4+Pj4+Pj4+PiBtb2RlKQ0KPj4+Pj4+Pj4+Pj4gYnkNCj4+Pj4+
Pj4+Pj4+IGl0cyBvd24uDQo+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBCZWlu
ZyBwaWNreSBvbiBEUExMX01PREUgZm9yIGVuYWJsaW5nIGZlYXR1cmUgaXMgbm90IHNvbWV0aGlu
Zw0KPj4+Pj4+Pj4+PiB3ZQ0KPj4+Pj4+Pj4+PiBjYW4gYWxsb3cgaWYgaXQgaXMgbm90IHJlbGF0
ZWQgdG8gSFcgbGltaXRhdGlvbiwgaXMgaXQ/DQo+Pj4+Pj4+Pj4+IENvdWxkIHlvdSBwbGVhc2Ug
ZWxhYm9yYXRlIHdoeSBpdCBpcyBub3QgcG9zc2libGUgZm9yIEFVVE9NQVRJQw0KPj4+Pj4+Pj4+
PiBtb2RlPw0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSW4gYXV0b21hdGljIG1vZGUsIHRoZSBwaW4g
c2VsZWN0aW9uIGxvZ2ljIGlzIGRlZmluZWQgdXBvbiBwcmlvLg0KPj4+Pj4+Pj4+IEkNCj4+Pj4+
Pj4+PiBjYW4gaW1hZ2luZSB0aGF0IGlmIE5DTyBwaW4gaGFzIHRoZSBoaWdoZXN0IHByaW8gb2Yg
dGhlIGF2YWlsYWJsZQ0KPj4+Pj4+Pj4+IG9uZXMsIGl0IGdldHMgcGlja2VkLiBJIHdvdWxkIGJl
IGFsaWduZWQgMTAwJSB3aXRoIGF1dG9tYXRpYyBtb2RlDQo+Pj4+Pj4+Pj4gYmVoYXZpb3VyLg0K
Pj4+Pj4+Pj4+IElzIHRoZXJlIGEgcmVhbCB1c2VjYXNlIGZvciBpdD8NCj4+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4+IFsuLl0NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBUaGlzIGlzIG5vdCB0cnVlLiBBVVRPTUFU
SUMgbW9kZSBpcyBIVyBzb2x1dGlvbiwgU1cgZHJpdmVyIE9OTFkNCj4+Pj4+Pj4+IGNvbmZpZ3Vy
ZXMgcHJpb3JpdGllcyBvbiB0aGUgaW5wdXRzLCBub3QgbWFuYWdlcyB0aGUgYWN0aXZlDQo+Pj4+
Pj4+PiBpbnB1dHMuDQo+Pj4+Pj4+PiBUaGlzIGJyYWtlcyB0aGF0IGJlaGF2aW9yLCB0aGUgU1cg
ZHJpdmVyIHdvdWxkIGhhdmUgdG8gbWFudWFsbHkNCj4+Pj4+Pj4+IG92ZXJyaWRlIHRoZSBBVVRN
QVRJQyBtb2RlIHRvIGJlIGZlZCBmcm9tIHN1Y2ggTkNPIHBpbiBhcyBpdA0KPj4+Pj4+Pj4gZG9l
c24ndA0KPj4+Pj4+Pj4gZXhpc3RzIG9uIGl0J3MgcHJpb3JpdHkgbGlzdCwgSFcgY2Fubm90IHBp
Y2sgb3IgdXNlIGl0Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBDb3JyZWN0LCBBVVRPIG1vZGUgaXMgaGFy
ZHdhcmUgZmVhdHVyZSBhbmQgaXQgc2hvdWxkIG5vdCBiZQ0KPj4+Pj4+PiBlbXVsYXRlZA0KPj4+
Pj4+PiBieSBhDQo+Pj4+Pj4+IGRyaXZlci4gSWYgdGhlIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBv
cnQgaXQgdGhlbiB0aGUgc3dpdGNoaW5nDQo+Pj4+Pj4+IGJldHdlZW4NCj4+Pj4+Pj4gaW5wdXQg
cmVmZXJlbmNlcyBzaG91bGQgYmUgZG9uZSBieSB1c2Vyc3BhY2UgKGJ5IG1vbml0b3JpbmcgZmZv
LA0KPj4+Pj4+PiBwaGFzZV9vZmZzZXQsIG9wZXJzdGF0ZSkuDQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+
Pj4+PiBZZXMsIGV4YWN0bHksIHNvIGZvciBBVVRPTUFUSUMgbW9kZSBIVyBpdCB3aWxsIG5vdCBi
ZSBwb3NzaWJsZSB0bw0KPj4+Pj4+IGNyZWF0ZQ0KPj4+Pj4+IHN1Y2ggcGluLCB3aGljaCBtZWFu
cyB0aGF0IE5DTyBwaW4gd291bGQgc2VydmUgb25seSBhIE1BTlVBTCBtb2RlDQo+Pj4+Pj4gaW1w
bGVtZW50YXRpb24uDQo+Pj4+Pj4gQmFzaWNhbGx5IHRoaXMgaXMgc29tZXRoaW5nIHdlIHNoYWxs
IG5vdCBhbGxvdyB0byBoYXBwZW4uIERQTEwgQVBJDQo+Pj4+Pj4gc2hvdWxkIGJlIGRlc2lnbmVk
IHRvIGNvdmVyIHRoZSBjYXNlIHdoZXJlIEFVVE8gbW9kZSBpcyBhYmxlIHRvDQo+Pj4+Pj4gaW1w
bGVtZW50DQo+Pj4+Pj4gYWxsIGZlYXR1cmVzIGNvbnNpc3RlbnRseS4NCj4+Pj4+DQo+Pj4+PiBJ
ZiB5b3UgZG9uJ3QgbGlrZSB0aGUgcHJvcG9zYWwgZnJvbSBKaXJpIChOQ08gc3dpdGNoIGRyaXZl
biBieSBOQ08NCj4+Pj4+IHBpbg0KPj4+Pj4gcHJpb3JpdHkgLT4gaGlnaGVzdD09ZW50ZXJfbmNv
IGVsc2UgbGVhdmVfbmNvKSB0aGVuIGl0IGNvdWxkIGJlDQo+Pj4+PiBwb3NzaWJsZQ0KPj4+Pj4g
dG8gaGFuZGxlIHRoZSBzd2l0Y2hpbmcgYnkgYWxsb3dpbmcgdGhlIHN0YXRlICdjb25uZWN0ZWQn
IGluIEFVVE8NCj4+Pj4+IG1vZGUNCj4+Pj4+IGZvciB0aGUgTkNPIHBpbiB0eXBlLiBUaGVuIHRo
ZSBpbXBsZW1lbnRhdGlvbiB3aWxsIGJlIHRoZSBzYW1lIGZvcg0KPj4+Pj4gYm90aA0KPj4+Pj4g
c2VsZWN0aW9uIG1vZGVzLg0KPj4+Pj4NCj4+Pj4+IE9ubHkgZGlmZmVyZW5jZSB3b3VsZCBiZSB0
aGF0IGEgdXNlciBkb2VzIG5vdCBuZWVkIHRvIHN3aXRjaCB0aGUNCj4+Pj4+IGRldmljZQ0KPj4+
PiA+ZnJvbSB0aGUgQVVUTyB0byBNQU5VQUwgbW9kZS4NCj4+Pj4+DQo+Pj4+Pj4+PiBUaGUgcmVh
bCB1c2UgY2FzZSBpcyB0aGF0IGFueSBEUExMIGNhbiBzd2l0Y2ggdGhlIG1vZGUgdG8gdGhpcyBv
bmUNCj4+Pj4+Pj4+IGluc3RlYWQgb2YgaW1wbGVtZW50aW5nIE1BTlVBTCBtb2RlIGp1c3QgdG8g
dXNlIHRoZSBmZWF0dXJlIHdpdGggYQ0KPj4+Pj4+Pj4gJ3ZpcnR1YWwnIHBpbi4NCj4+Pj4+Pj4N
Cj4+Pj4+Pj4gSSBkb24ndCBleHBlY3QgdGhpcy4uLiBidXQgaXQgaXMgdXAgdG8gYSBkcml2ZXIu
IEkgZG9uJ3QgcGxhbiBzdWNoDQo+Pj4+Pj4+IGZ1bmN0aW9uYWxpdHkgaW4gemwzMDczeCBhcyB0
aGUgTkNPIHBpbiBkb2VzIG5vdCBleHBvc2UgcHJpb19nZXQoKQ0KPj4+Pj4+PiBhbmQNCj4+Pj4+
Pj4gcHJpb19zZXQoKSBjYWxsYmFja3MgLSBzbyBpdCBpcyBjbGVhciB0aGF0IHRoaXMgcGluIGNh
bm5vdCBiZSBwYXJ0DQo+Pj4+Pj4+IG9mDQo+Pj4+Pj4+IHRoZQ0KPj4+Pj4+PiBhdXRvbWF0aWMg
c2VsZWN0aW9uLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJdmFuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGVyZSBp
cyBhIGRpZmZlcmVuY2UgYmV0d2VlbiBwYXJ0aWN1bGFyIEhXIGFuZCBBUEkgY2FwYWJpbGl0aWVz
LA0KPj4+Pj4+IHdpdGgNCj4+Pj4+PiB0aGUNCj4+Pj4+PiBwcm9wb3NlZCBBUEkgd2Ugd291bGQg
ZGlzYWxsb3cgdGhlIHBvc3NpYmlsaXR5IG9mIHN1Y2gNCj4+Pj4+PiBpbXBsZW1lbnRhdGlvbg0K
Pj4+Pj4+IGZvcg0KPj4+Pj4+IGV4aXN0aW5nIEhXIHZhcmlhbnRzLg0KPj4+Pj4+DQo+Pj4+Pj4g
RFBMTCBOQ08gTU9ERSB3b3VsZCBhbGxvdyB0aGF0IGJ1dCBhcyBwb2ludGVkIGhlcmUgYnkgSXZh
biBhbmQgYnkNCj4+Pj4+PiBKaXJpDQo+Pj4+Pj4gaW4NCj4+Pj4+PiB0aGUgb3RoZXIgZW1haWwg
aXQgd291bGQgYWxzbyByZXF1aXJlIHRoZSBleHRyYSBpbXBsZW1lbnRhdGlvbiBmb3INCj4+Pj4+
PiBzb21lDQo+Pj4+Pj4gY29uZmlndXJhdGlvbiAtIGRldmljZSBsZXZlbCBwaGFzZS9mZm8gaGFu
ZGxpbmcuDQo+Pj4+Pj4NCj4+Pj4+PiBUbyBzdW1tYXJpemUgaXQgYWxsLCBJIGRvbid0IGhhdmUg
c3VjaCBzaW1wbGUgc29sdXRpb24gZm9yIGl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gRmlyc3QgdGhpbmcg
dGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRvIGNvbWJpbmUgYm90aCBhcHByb2FjaGVzLg0KPj4+
Pj4+IE1ha2UgaXQgcG9zc2libGUgZm9yIEFVVE1BVElDIG1vZGUgdG8gYWxzbyBzZXQgIkNPTk5F
Q1RFRCIgc3RhdGUNCj4+Pj4+PiBvbiBjZXJ0YWluIGtpbmQgb2YgIk9WRVJSSURFIiBwaW5zLCB3
aGVyZSBpdCBjb3VsZCBiZSBkZXRlcm1pbmVkIGJ5DQo+Pj4+Pj4gdGhlIHR5cGUgb2YgUElOIGFu
ZCBlbWJlZCB0aGF0IGxvZ2ljIGludG8gdGhlIERQTEwgc3Vic3lzdGVtLg0KPj4+Pj4NCj4+Pj4+
IFRoZSBwb3NzaWJsZSBzdGF0ZXMgZm9yIHBhcnRpY3VhbCBwaW5zIGFyZSBub3cgaGFuZGxlZCBh
dCBhIGRyaXZlcg0KPj4+Pj4gbGV2ZWwNCj4+Pj4+IHNvIHRoZSBkcml2ZXIgZGVjaWRlcyBpZiB0
aGUgcmVxdWVzdGVkIHN0YXRlIGlzIGNvcnJlY3Qgb3Igbm90LiBTbyBpdA0KPj4+Pj4gY291bGQg
YmUgZWFzeSB0byBpbXBsZW1lbnQgdGhpcy4NCj4+Pj4+DQo+Pj4+PiBGb3IgYXV0byBtb2RlIGFs
bG93ZWQgc3RhdGVzOg0KPj4+Pj4gLSBpbnB1dCByZWZlcmVuY2VzOiBzZWxlY3RhYmxlIC8gZGlz
Y29ubmVjdGVkDQo+Pj4+PiAtIG5jbyBwaW46IGNvbm5lY3RlZCAvIGRpc2Nvbm5lY3RlZA0KPj4+
Pj4NCj4+Pj4+PiBCYXNpY2FsbHksIGlmIGRyaXZlciByZWdpc3RlcnMgc3VjaCBOQ08gcGluIGl0
IHdvdWxkIGJlIGFsd2F5cw0KPj4+Pj4+IHNlbGVjdGVkDQo+Pj4+Pj4gbWFudWFsbHksIGFuZCBp
biBzdWNoIGNhc2UgYWxsIHRoZSBvdGhlciBwaW5zIGFyZSBnb2luZyB0bw0KPj4+Pj4+IGRpc2Nv
bm5lY3RlZA0KPj4+Pj4+IHN0YXRlIHdoaWxlIERQTEwgbW9kZSBpcyBhbHNvIGEgIk9WRVJSSURF
IiBvciBzb21ldGhpbmcgbGlrZSBpdC4NCj4+Pj4+DQo+Pj4+PiBJIHdvdWxkIGxlYXZlIHRoaXMg
ZGVjaXNpb24gb24gdGhlIGRyaXZlciBsZXZlbC4uLiBJbWFnaW5lIHRoZQ0KPj4+Pj4gcG90ZW50
aWFsDQo+Pj4+PiBIVyB0aGF0IHdvdWxkIGFsbG93IHRvIHN3aXRjaCBOQ08gbW9kZSBpZiB0aGVy
ZSBpcyBubyB2YWxpZCBpbnB1dA0KPj4+Pj4gcmVmZXJlbmNlLg0KPj4+Pj4NCj4+Pj4+IEV4YW1w
bGU6DQo+Pj4+Pg0KPj4+Pj4gUkVGMCAocHJpbyAwKSAtPiArLS0tLS0tKyAtPiBPVVQwDQo+Pj4+
PiBSRUYxIChwcmlvIDEpIC0+IHwgRFBMTCB8IC0+IC4uLg0KPj4+Pj4gTkNPICAocHJpbyAyKSAt
PiArLS0tLS0tKyAtPiBPVVRuDQo+Pj4+Pg0KPj4+Pj4gU3VjaCBIVyB3b3VsZCBwcmVmZXIgUkVG
MCBvciBSRUYxIGFuZCBsb2NrIHRvIG9uZSBvZiB0aGVtIGlmIHRoZXkgYXJlDQo+Pj4+PiBxdWFs
aWZpZWQuIEJ1dCBpZiB0aGV5IGFyZSBOT1QsIHRoZW4gaXQgc3dpdGNoZXMgdG8gTkNPIG1vZGUu
DQo+Pg0KPj4gTm93IHlvdSBzYWlkIHlvdXJzZWxmICJOQ08gbW9kZSIgLi4uIEkgYWdyZWUgdGhh
dCBpdCB3b3VsZCBiZSBhIG1vZGUgaW4NCj4+IHRoYXQgY2FzZS4gV2hlcmUgaW5zdGVhZCBvZiBy
dW5uaW5nIG9uIHJlZ3VsYXIvYnVpbHQgaW4gWE8gZHBsbCB3b3VsZA0KPj4gcnVuDQo+PiBvbiBO
Q08gYW5kIHVzZXIgY291bGQgc2VsZWN0IGl0LCBhbmQgdGhpcyB3b3VsZCBiZSBhZGRpdGlvbiB0
byByZWd1bGFyDQo+PiBiZWhhdmlvci4NCj4+DQo+PiBJIGFsc28gYWdyZWUgdGhhdCB0aGUgcGlu
IGFwcHJvYWNoIG1pZ2h0IGJlIGJldHRlci9lYXNpZXIgdG8gdXNlLA0KPj4gYXNzdW1pbmcNCj4+
IGZyZXF1ZW5jeSBvZmZzZXQgZm9yIGFsbCB0aGUgb3V0cHV0cyBnaXZlbiBkcGxsIGRyaXZlcywg
aXQgbWFrZXMgbW9yZQ0KPj4gc2Vuc2UNCj4+IHRvIGhhdmUgaXQgY29uZmlndXJhYmxlIG9uIGlu
cHV0IHNpZGUuDQo+DQo+KzENCj4NCj4+Pj4+DQo+Pj4+PiBJbiB0aGlzIHNpdHVhdGlvbiB0aGUg
cmVsZXZhbnQgZHJpdmVyIHdvdWxkIGFsbG93IHRvIGNvbmZpZ3VyZQ0KPj4+Pj4gcHJpb3JpdHkN
Cj4+Pj4+IGFuZCBzdGF0ZSAnc2VsZWN0YWJsZScgZm9yIHRoaXMgTkNPIHBpbi4NCj4+Pj4+DQo+
Pj4+Pj4gUGVyaGFwcyB0aGUgcGluIHR5cGUgY291bGQgaW5jbHVkZSBPVkVSUklERSBpbiBpdCdz
IG5hbWUgdG8gbWFrZSBpdA0KPj4+Pj4+IGxlc3MNCj4+Pj4+PiBjb25mdXNpbmcgYW5kIG5lZWRz
IHNvbWUgZXh0cmEgZG9jdW1lbnRhdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IFRob3VnaHRzPw0KPj4+
Pj4gSSB0aGluayBfSU5UXyBpcyBvay4gSW4gdGhlIGNhc2Ugb2YgVFlQRV9JTlRfT1NDSUxMQVRP
UiBpdCBpcyBhbHNvDQo+Pj4+PiBvYnZpb3VzIHRoYXQgaXQgaXMgbm90IGEgc3RhbmRhcmQgaW5w
dXQgcmVmZXJlbmNlLg0KPj4+Pj4NCj4+Pj4+IEppcmksIFZhZGltLCBBcmVrLCB0aG91Z2h0cz8N
Cj4+Pj4NCj4+Pj4gSSBhZ3JlZSB3aXRoIHlvdSwgdGhlIGRyaXZlciBzaG91bGQgaGF2ZSB0aGUg
ZmxleGliaWxpdHkgdG8gaW1wbGVtZW50DQo+Pj4+IHRoaXMgYWNjb3JkaW5nIHRvIGhpcy9odydz
IG5lZWRzL2NhcGFiaWxpdGllcy4gSWYgaXQgaW1wbGVtZW50cyBwcmlvDQo+Pj4+IHNlbGVjdGlv
biBpbiBBVVRPIG1vZGUsIGxldCBpdCBoYXZlIGl0LiBJZiBpdCBpbXBsZW1lbnRzIG1hbnVhbCBO
Q08NCj4+Pj4gcGluDQo+Pj4+IHNlbGVjdGlvbiBpbiBBVVRPIG1vZGUgdXNpbmcgY29ubmVjdGVk
L2Rpc2Nvbm5lY3RlZCBvdmVycmlkZSwgbGV0IGl0DQo+Pj4+IGhhdmUgaXQuDQo+Pg0KPj4gSSBk
b24ndCBrbm93ICdjdXJyZW50JyBIVyB0aGF0IGlzIGNhcGFibGUgb2YgdXNpbmcgQVVUTyBtb2Rl
IGFzIGEgcGFydA0KPj4gb2YNCj4+IEhXLWJhc2VkIHByaW9yaXR5IHNvdXJjZSBzZWxlY3Rpb24g
YW5kIHVzZSBzdWNoIE5DTyBpbnB1dC4uDQo+PiBCdXQgYXMgYWxyZWFkeSBleHBsYWluZWQgYWJv
dmUsIHRoaXMgaXMgc3BlY2lhbCBtb2RlIG9mIHJlZ3VsYXIgWE8sDQo+PiB3aGljaA0KPj4gYWxs
b3dzIERQTEwncyBvdXRwdXQgZnJlcXVlbmN5IG9mZnNldCBjb25maWd1cmF0aW9uLg0KPg0KPkxl
dHMga2VlcCB0aGlzIGF2YWlsYWJsZSBmb3IgcG90ZW50aWFsIGZ1dHVyZSBIVy4gSSBjYW4gaW1h
Z2luZSBhDQo+c2l0dWF0aW9uIHdoZXJlIGEgdXNlciB3aWxsIHByZWZlciBhbiBhdXRvbWF0aWMg
c3dpdGNoIHRvIE5DTyBtb2RlDQo+aWYgdGhlcmUgaXMgbm8gcXVhbGlmaWVkIGlucHV0IHJlZmVy
ZW5jZSAtIGF1dG9tYXRpYyBzd2l0Y2ggbWVhbnMNCj50aGF0IEhXIHdpbGwgc3VwcG9ydCB0aGlz
IChub3QgZW11bGF0ZWQgYnkgdGhlIGRyaXZlcikuDQo+DQo+Pj4+DQo+Pj4+IE1vcmVvdmVyLCBJ
IGFjdHVhbGx5IGxpa2UgdGhlICJvdmVycmlkZSIgY2FwYWJpbGl0eSBmb3IgcGlucyBpbiBBVVRP
DQo+Pj4+IG1vZGUgaW4gZ2VuZXJhbC4gSXQgbWF5IGJlIGhhbmR5IGZvciBvdGhlciB1c2VjYXNl
cyBhcyB3ZWxsLg0KPj4+Pg0KPj4+IEFyZWs/IFZhZGltPw0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+
IEl2YW4NCj4+DQo+PiBBZ3JlZSwgJ292ZXJyaWRlJyBjYXBhYmlsaXR5IG9mIGEgcGluIHdvdWxk
IGJlIHRoZSB3YXkgdG8gZ28gZm9yIHRoaXMNCj4+IGFuZA0KPj4gb3RoZXIgc2ltaWxhciBmdXJ0
aGVyIGNhc2VzLg0KPj4NCj4+IEkgYmVsaWV2ZSBhIHNpbmdsZSBhcHByb2FjaCBvbiB0aGlzIHdv
dWxkIGJlIGJlc3QsIEkgbWVhbiBpZiBBVVRPIG1vZGUNCj4+IG5lZWRzIGEgY2FwYWJpbGl0eSwg
dG8gc3dpdGNoIGZyb20gcmVndWxhciBiZWhhdmlvciB0byAnT1ZFUlJJREUnLCBhbmQNCj4+ICdP
VkVSUklERScgaXMgb25seSBwaW4gY2FwYWJpbGl0eSB0aGF0IGFsbG93cyBzdWNoIGJlaGF2aW9y
IGZvciBBVVRPDQo+PiBtb2RlLCB0aGVuIHNpbWlsYXIgYXBwcm9hY2ggc2hvdWxkIGJlIHVzZWQg
b24gTUFOVUFMIG1vZGUsIHRvIG1ha2UNCj4+IHVzZXJzcGFjZSBrbm93IHRoYXQgc3VjaCBwaW4g
aXMgYWx3YXlzIGF2YWlsYWJsZSB0byBzZXQgIkNPTk5FQ1RFRCINCj4+IGFuZCBtYWtlIHRoZSB1
c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24gY29uc2lzdGVudCBvbiBlbmFibGluZyBpdCBubw0KPj4g
bWF0dGVyDQo+PiBpZiBBVVRPIG9yIE1BTlVBTCBtb2RlIGRwbGwuDQo+DQo+UHJvcG9zYWw6DQo+
MSkgbmV3IHBpbiBjYXBhYmlsaXR5DQo+ICAgIC0gbmFtZTogc3RhdGUtY29ubmVjdGVkLW92ZXJy
aWRlDQo+ICAgIC0gZG9jOiBwaW4gc3RhdGUgY2FuIGJlIGNoYW5nZWQgdG8gY29ubmVjdGVkIGlu
IGFueSBEUExMIG1vZGUNCj4NCj4yKSBuZXcgTkNPIHBpbiB0eXBlIHRvIHN3aXRjaCB0aGUgRFBM
TCB0byBOQ08gbW9kZSB3aGVuIGNvbm5lY3RlZA0KPg0KPjMpIGF1dG9tYXRpYy1vbmx5IERQTEwN
Cj4gICAgLSBzaG91bGQgZXhwb3NlIE5DTyBwaW4gd2l0aCBzdGF0ZS1jb25uZWN0ZWQtb3ZlcnJp
ZGUgY2FwYWJpbGl0eQ0KPg0KPjQpIG1hbnVhbC1vbmx5IERQTEwNCj4gICAtIGRvZXMgbm90IG5l
ZWQgdG8gZXhwb3NlIE5DTyBwaW4gd2l0aCBzdGF0ZS1jb25uZWN0ZWQtb3ZlcnJpZGUgY2FwDQo+
DQoNCkl0IG1ha2VzIHNlbnNlIG9ubHkgaWYgc3VjaCBBVVRPIG1vZGUgRFBMTCBjYW4gaGF2ZSBi
b3RoIE9WRVJSSURFIGFuZA0Kbm9uLU9WRVJSSURFIHBvc3NpYmlsaXRpZXMuIFNvIGZ1cnRoZXIg
SFcgZGVzaWduIGNvdWxkIGltcGxlbWVudCBpdA0Kd2l0aG91dCBPVkVSUklERSBhbmQgY3VycmVu
dCBBVVRPIG1vZGUgY291bGQgT1ZFUlJJREUgYW5kIHVzZSBpdC4NCg0KSGF2aW5nIGl0IHRoaXMg
d2F5LCByZXF1aXJlcyBkaWZmZXJlbnQgdXNlciBzcGFjZSBpbXBsZW1lbnRhdGlvbiwNCmJ1dCBk
b24ndCB0aGluayB3ZSB3aWxsIGJlIGFibGUgdG8gZWFzZSBpdCBhbnlob3cuDQoNClRoYW5rIHlv
dSENCkFya2FkaXVzeg0KDQo+NSkgZHVhbC1tb2RlIERQTEwgKHN1cHBvcnRpbmcgbW9kZSBzd2l0
Y2hpbmcpDQo+ICAgLSBpZiBpdCBleHBvc2VzIE5DTyBwaW4gd2l0aCB0aGUgb3ZlcnJpZGUgY2Fw
IHRoZW4gaXQgaGFzIHRvIHN1cHBvcnQNCj4gICAgIHN3aXRjaGluZyB0byBOQ08gbW9kZSBkaXJl
Y3RseSBmcm9tIEFVVE8gbW9kZQ0KPiAgIC0gaWYgZG9lcyBub3QgZXhwb3NlIE5DTyBwaW4gd2l0
aCB0aGUgb3ZlcnJpZGUgY2FwIHRoZW4gYSB1c2VyIE1VU1QNCj4gICAgIHN3aXRjaCB0aGUgRFBM
TCBtb2RlIGZyb20gQVVUTyB0byBNQU5VQUwgdG8gYmUgYWJsZSB0byBtYWtlIE5DTw0KPiAgICAg
cGluIGNvbm5lY3RlZCB0byB0aGUgRFBMTA0KPg0KPlZhZGltLCBKaXJpLCBBcmVrIC0gdGhvdWdo
dHM/DQo+DQo+VGhhbmtzLA0KPkl2YW4NCg0K

