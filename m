Return-Path: <netdev+bounces-296669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sDMINOj2JmqUowIAu9opvQ
	(envelope-from <netdev+bounces-296669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFF659136
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:07:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Eq+7H0G2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697FE306409F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B93CFF58;
	Mon,  8 Jun 2026 17:03:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDB3C76A0;
	Mon,  8 Jun 2026 17:03:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938236; cv=fail; b=hUgXysutSrGel3p9RbrMuDHlo7FrME1oqe499pOYt+vcHUCJNSiFUXXOylSeywW7I8ifisKQmXVrzsa4IGVS6S0VrZC9gI9Keekj4pyqPqWM5BtbGGB7YCeHQ0w6ceU6iHd67eMF/P1ISM6ALKsceNNid5dSNhDmNJfOx/OkuXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938236; c=relaxed/simple;
	bh=NG0KJvSmKlF8h9sUHZNr5kIklEKvI/UnRlcnLhsqIj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/sFQXO0pfMnvWw3Pu8Ug69pDq0UBwLgT3L6nrt4xgw5vxOqzkYoH9TazGCWtnwXfIH3ZdEMoM5VBeIaKW0RyuX+GF8X5LbMFsPJg4C5RMUqf3djVESDHmMMZs3pUiFJXzyIrYixeBrf3nYAjB6uuu1g97NUBes6OUNdrzP6YUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq+7H0G2; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780938234; x=1812474234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NG0KJvSmKlF8h9sUHZNr5kIklEKvI/UnRlcnLhsqIj8=;
  b=Eq+7H0G2r/FhYl+yeseYuvvBhYqATlkb23SAZK/SPzJmH0RwQGGxUQDG
   iqaM5kJ7o7MGDxmcD7Yj7OQtjpVaST+aqhJzqQ6AuETHHK26WydY10Y/B
   yIkbPks95zQmsyNT4zao0jQfJ7XEf0aVZ6eo8tngwTOwaC+5t0ep1GCyY
   +ckuLlEBBZ9688r7enAXw9NonVIx6+NngTh5eL0/2ViCkp1826XLC/fOS
   B5lckoZX7vnaLY/8+vZAK87U8yulevKhxL0rhqnCQ8KbYX/aLJAcaFO/q
   B2P/tttmALksUGL3//3BJQlAo1IELVPXkSZvk4CEHXuGDHY+p7w2xtcyd
   Q==;
X-CSE-ConnectionGUID: sivveErmQ7CerpQdjvJJQg==
X-CSE-MsgGUID: jRH9OpziSWK571K2f6KLdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92248946"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92248946"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:03:53 -0700
X-CSE-ConnectionGUID: ZrdW0ul1RI6aLICa0TlzMg==
X-CSE-MsgGUID: tCCULTF0TfKSqnq2BFE7wg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:03:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 10:03:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 10:03:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 10:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf5DVn4EbK1U1IgelpQYzlq7PDdJqZ5KDnWdX3Ea7M7wKwph+0YSbKt9n8V+B8QfUntM671p/rECi2aAJZ7OGOs4FsL15FirXVitUOoo1n6YS25J6YePuHywsA9IPdBe8wu3k3BweJURWcJzQE+e/Tm4V/5h1DYB/kSzF/QFF+i0XAE813hmIUphCvikg3qbNPDtdT5qDUgGzsOqiwJjWjFbKwSWXEAXmnWC/56jAxExXcRnj9/eCA6WuntLm89pJedSwVmFpsMS0j8ZGiOakiZC2n08G4S/apdg+sXo58vVJiAADLRSiCcaJNsj6Ag5HeOxB6Ou4r6MHga7W7QYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG0KJvSmKlF8h9sUHZNr5kIklEKvI/UnRlcnLhsqIj8=;
 b=MAjSuwAcENH2S9h8ARY0bMKmL83ifGQ6fZFcsMJwga3vubS/j9Crdis1vQ/DHfp0j1QgHez8JrP5+sUUFp8i6WkfJMs/M/SsGIZTC6Fqu8bf1Bmx4pne+knPB3hahojvdR+OxxE9wx/U/xtL44YWUtjSqdfiGMjScElX8WFlgdshrZYAZt7DF5xms43w1gYwmrsmquGnobet2Jmkx2uQcLVOVHbD6RtdiJ5V4Fv9MeA9htCCR6gz1FaGry5do9N94PhLk6AH+ZvzFGYfLQkj05Ozkug/mIL21f7DAsypaQMdIHNniwF7MOYYMRrzfZHsI1y3nXexaXMeSa8rlB1jMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 17:03:46 +0000
Received: from CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968]) by CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:03:46 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Schmidt,
 Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, "Vaananen,
 Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Topic: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQgAAWBwCAABGk0A==
Date: Mon, 8 Jun 2026 17:03:46 +0000
Message-ID: <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
In-Reply-To: <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5394:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: 50c47c31-92c6-43b2-97f1-08dec57fe722
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
x-microsoft-antispam-message-info: 6ats3lUouglU3OHlfisfEqgVNVdyzUWuM/StbLF7jAngIcScUNMdV1/IeR/n535AxuWN69Uz5xuVFiwXIftWwe7jgfgneyXFaWsfssxXJAb4CQug1egr14tNo2tJKfCITilW0Cs4tR78C+v6J+NALV4OXAkp+vbnZcMaPp1qo+n4bGAMsLFqWSj+fRPNP7G1WC3fPYthz68ofoSxdHrMB7pvGbyM5DSVVwVmTQja7E/n35PcqvS3xymd6LKh6XCAh4BR8BrAKc3XOQYk7SELsm6djC6nhLue+zDXuy+72gwKok0qGMCoBA2WLVx42wq3dFq6wZmBgavR07AwVTLP4QCL/PWsrTjpFUmpoc9zs93XXHFQhFde17sl7P7RIHhkPiZomyoBVCKaO/zyEn4v8wom8nErTBMUzkfdkvUCersSlqYUTmna7WGa666YJY4XcCgyZuZwIHida6qluT+rtekejrqDrhyQEi6QuE7zHjI2GsSwDF5QUdhgDQ5lm+Nu7piYZs2MXWG6C6VREEg5ur+kjiaCCq0wSpII8wypNxgmbyXt4nid45BsiAEQ50UA0eC3wiqbEOrKoFppO4PdRqSu23SciJZh9v5SrLUgCYALt1wSc9tglLHepRRfygWeYbe3yb9OuIz8cbQQIh+k1lURpsTsXQcMXzCMp1T0s0FUJfN04uoTZ7zK16dPFUnkxIsmLbrK5s2mO4s5cu0G5dGhN/tfsU46XMrofOW7dtb5Q363IVRrfSLOLpaIav92
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5394.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkphdjhuUmMrcU91QWpRN2VZVnZpUDdqTzkyenR6MCtPSFZxdjZSNDRoOURP?=
 =?utf-8?B?NC93NkVpRm0xSUFnR0hyMmcrR3krNWkzWTl2QjdoWDI0WE9Jc2s4dUU4VjQv?=
 =?utf-8?B?UEEyOXlHL3JrVk1VTEpmdmZQTzdwUEtLaDY1VWxEcDF3aWlKV1IxcTV3ZE9N?=
 =?utf-8?B?Sjl4SG5zeDU2Y2UxN09NWHc0NzNPWGN3NnZCMmZ0aWJuZnFCSlQ3OU5pdWtL?=
 =?utf-8?B?TGkrd1FLMEh4Z1luTFE3MTV5TStNOG5hTFhBWjVVb0ZNZmlqenhoRTlZMmJJ?=
 =?utf-8?B?aFlmem9BM1gzRTJPNFVVK2R3UGJCNWdRZ3M2czNsOW9wUlY4ekM1dGFOQjU4?=
 =?utf-8?B?WGUzd3hpNnpCSGJpekhBWHYwWVloeVZSS0YyZGZwQWZLNUhYWmczUjZWd25R?=
 =?utf-8?B?Y092VElJR3ZaWFV2YW1xYkFJSG4vQXlrZnM3NExQWWQwN3doY3hXc0xBN1hD?=
 =?utf-8?B?cnR6U2pCUXRsNUlVMGxBYy90NTJGYjRpbzNtcDZoMVhYc0pwWVFPOGtMc2VN?=
 =?utf-8?B?bFpJWHVCV0RReWkwbHl3N1psM3B1WXQzemtlY1Y2cDJqOTkvN2N6Qko2cWR3?=
 =?utf-8?B?SzRCd0duZlV3TUVoOSt5QWUrNXNHdDkvb1ZhMEZJSTg3QnlMNjd2QWFwU2FS?=
 =?utf-8?B?R0dEVU5KYkdjbit0TCtsQ3MvbWxPYXFMNDdjTU9kUno0MTg3QlF4dndOVzBk?=
 =?utf-8?B?YmRDNVgwOFVoWXVHVjdzZ2lNV092MWpycHBIampYQWtpUDFaVzR6czNxQlJR?=
 =?utf-8?B?M1diWlZMQnV1QjJXOFdkL3BPdGQ3VVJ3YStVZnBibmFaR2FpdEpQM2FaWkJs?=
 =?utf-8?B?ZzZDQkR5TU1OUlVLRzZ3QWRYQ2xNS0xMNm1QbU9vQklZRHZqcm4vSkJna2lO?=
 =?utf-8?B?YlJiWjFPSmJQT3YxcXdLZEh6azZIQWYzNnpWS1ppQmZnMFduWnNyQmcxVnFP?=
 =?utf-8?B?N3NNZ253QzM3eUVBdjZxQkEvMU1kRXFlOG55a2F6NnBJQVNpSTBycXRMbVZM?=
 =?utf-8?B?elNhcEtMaEtiSURTRVB3M1d1ZGtGR1h1VmJUa1dQTG5vTDlsWG9KSUVFYU83?=
 =?utf-8?B?TnFjRUZOUFFzRUt6V3U3M2tJTlI3MW9nS0JQQTJkTW1LMFR5dWhiSHgrd0Ro?=
 =?utf-8?B?NmNFV28vQlFyQ0VuUTd0RENpb2I4MmhORFM5WW9iOTBET282UkZiZXhyLzRu?=
 =?utf-8?B?WGI1THBmaDh0aHVOZDVMM1dESVp6SEprRGo0Wi9RL3owclp2cGdyTWJGT1A5?=
 =?utf-8?B?aVV0aWJrbWZDZ1d2VXkwVlRURXY4eXVaQTBrZ1lwb3J2UThsVG1CSUFURTY0?=
 =?utf-8?B?am5zUHlFRWM0WCs0N2lod0FneFhCdHZ4eXVrMERZRG5Ud0lWSTVmbVQrK1VY?=
 =?utf-8?B?V01FalBLVlJRNDlaZXUyUzg2alBOSmgxcVVhbnpESkVTYk5DRDdvUUVuQlFo?=
 =?utf-8?B?bWZOSmVvczRKcGF1OWlUKzh1cUxpUWNQcHNrTHZaN2ltUmswcG5MN0tsVEU2?=
 =?utf-8?B?REtFQlJGWnI2L29jSnliWlFLb01hVkd4UkZwMWRxRzQveXU3enU0SktMbzNH?=
 =?utf-8?B?WkNDU3BLaUQvcmpkam8rblV3eHBkOForQ3ZNY2FOb1JYOVN4dFJjV3BaMzkr?=
 =?utf-8?B?cEJ2SEhNNVR4RUx5SU9yWUZRZzRVWEtyM3paR29pS2ZkQnhmZVJYQVd2bXNC?=
 =?utf-8?B?UEl1ZEY0WGJvMnhGRmlDT0RHRE14aGwzdGtZMmVEMk1EejZrSDJFVEpMN2dt?=
 =?utf-8?B?WlN6dWU4d0RFUHA4TGh2eDgvRlY5bUUwS0NlZ0xnQng0RjcwcVNNbHNKeEli?=
 =?utf-8?B?VHlQS0lTd1FJLzlocGJSQnR4ZTcxQ0NTRlM1KzluQWsyK2MxL2VVeUZqT29z?=
 =?utf-8?B?ZEtKdjlJekpxRGgyZTZsVzY2R3d4TVBoL0EvVER6WlVzVUwyNWd4Zld5ZERZ?=
 =?utf-8?B?eS80dXdEOEpFblp3SHZhSnVVQldIeUFvWTdnWkhWZlltTWxPNnh4eWIvK2tr?=
 =?utf-8?B?dmlzVXVrVmY2emFzTUUvZXdhaWp1Q2YrdUhBTW5JNnltNjJtMUR2akV0Wk5G?=
 =?utf-8?B?WWxQaXJVVnBuc2NxZ3dxMGVtQWZuNGJTZFY3L0k2QUNnUEV1VjVESW90RS84?=
 =?utf-8?B?R0V0Vko4UXNjNDBQZFRpTXBoK2pFdkNabUhpbUpQOFYzMUNxeUk5aHJiR3F2?=
 =?utf-8?B?QktPOGpJUXNwNG5sTFdoZmFNdmd4VVNsS3UwcFRQSE5MSGltUTJHV2s4TGJ3?=
 =?utf-8?B?OC9nM0NCTnhjSDFIenJJZ1F1c0lCTWxmcWRQN001Z1ZGejhXTWZHa3VaZGl6?=
 =?utf-8?B?UUxiUkdDWkc3MWpJTWd4azRyRmF3bWplMTA3L3FmRnJCallkVFlLcnZodVhV?=
 =?utf-8?Q?66gvM4sYbww9DiX0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lz22WF4Js3EB2yvuf4hehls7RQ3mXclhoSXfdPyTd1LUiLMon7tPpW5ciKXcCi/wyFbrJuuWCLUuhGBu3JfcKS1qMMs22QKhn/ooPHZqFi4xwQPbiNd1pQSJ3nbkXMNWZH8JgEsgH/RCg1+N3/eFi34z83NM71leM1tRPZy1Dorjklybv3AYQPjLWPHt5Yhh63xWNNA9wGlzPhOlH1vlOw/4mKHf0OY4yNq2Ww7z9t6ps3ZxtWGnH29Nwz90Sed/axofX5NzpXREZ4riGR9oyoUahk2gO022he32nSJvwBkiokEC55MmBhpt7qX+cT80sMt90npxgEJOJPFVQVgMXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5394.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c47c31-92c6-43b2-97f1-08dec57fe722
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 17:03:46.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACGacdmmQCE7f/X3I6dOeHTrQkw2B8jWYokzk4uYTkoHyAl+VyfqlNXiu/aK1dWVUgwiKj9TKEjiYbS8uPw0Th2SgfsTYH+nOm9/5AFOnDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296669-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,CH0PR11MB5394.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44DFF659136

PkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+DQo+U2VudDogTW9uZGF5LCBK
dW5lIDgsIDIwMjYgNTo0OCBQTQ0KPg0KPk9uIDYvOC8yNiA0OjQzIFBNLCBLdWJhbGV3c2tpLCBB
cmthZGl1c3ogd3JvdGU6DQo+Pj4gRnJvbTogSXZhbiBWZWNlcmEgPGl2ZWNlcmFAcmVkaGF0LmNv
bT4NCj4+PiBTZW50OiBTdW5kYXksIE1heSAzMSwgMjAyNiA5OjQ0IFBNDQo+Pj4gLi4uDQo+Pj4g
ICAgICAgIC0NCj4+PiAgICAgICAgICBuYW1lOiBnbnNzDQo+Pj4gICAgICAgICAgZG9jOiBHTlNT
IHJlY292ZXJlZCBjbG9jaw0KPj4+ICsgICAgICAtDQo+Pj4gKyAgICAgICAgbmFtZTogaW50LW5j
bw0KPj4+ICsgICAgICAgIGRvYzogfA0KPj4+ICsgICAgICAgICAgRGV2aWNlIGludGVybmFsIG51
bWVyaWNhbGx5IGNvbnRyb2xsZWQgb3NjaWxsYXRvci4NCj4+PiArICAgICAgICAgIFdoZW4gY29u
bmVjdGVkIGFzIGEgRFBMTCBpbnB1dCwgdGhlIERQTEwgZW50ZXJzIE5DTyBtb2RlDQo+Pj4gKyAg
ICAgICAgICB3aGVyZSB0aGUgb3V0cHV0IGZyZXF1ZW5jeSBpcyBhZGp1c3RlZCBieSB0aGUgaG9z
dCB2aWENCj4+PiArICAgICAgICAgIHRoZSBQVFAgY2xvY2sgaW50ZXJmYWNlLg0KPj4NCj4+IEhp
IEl2YW4hDQo+Pg0KPj4gSG93IHdvdWxkIHlvdSBjb250cm9sIHRoaXMgaW4gY2FzZSBvZiBhdXRv
bWF0aWMgbW9kZSBkcGxsPw0KPj4gQXV0b21hdGljIG1vZGUgRFBMTCBzaGFsbCBiZSBjb250cm9s
bGVkIG9uIEhXIGxldmVsLCBzdWNoIHBpbiBicmFrZXMNCj4+IHRoYXQgcnVsZSBhbmQgcmVxdWly
ZXMgc29tZSBkcml2ZXIgbWFnaWMgdG8gc2hvdyBpdCBpcyBoaWdoZXINCj4+IHByaW9yaXR5IHRo
ZW4gdGhlIHJlc3Qgb2YgdGhlIHBpbnM/DQo+DQo+VGhlIE5DTyBwaW4gY2FuIGJlIGNvbm5lY3Rl
ZCBvbmx5IGluIG1hbnVhbCBtb2RlLiBJbiBvdGhlciB3b3JkcyBhIERQTEwNCj5pbiBhdXRvbWF0
aWMgbW9kZSBjYW5ub3Qgc2VsZWN0IE5DTyBwaW4gKHN3aXRjaCB0byBOQ08gbW9kZSkgYnkgaXRz
IG93bi4NCj4NCg0KQmVpbmcgcGlja3kgb24gRFBMTF9NT0RFIGZvciBlbmFibGluZyBmZWF0dXJl
IGlzIG5vdCBzb21ldGhpbmcgd2UgY2FuDQphbGxvdyBpZiBpdCBpcyBub3QgcmVsYXRlZCB0byBI
VyBsaW1pdGF0aW9uLCBpcyBpdD8NCkNvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoeSBpdCBp
cyBub3QgcG9zc2libGUgZm9yIEFVVE9NQVRJQyBtb2RlPw0KDQo+SWYgdGhlIERQTEwgZGV2aWNl
IGlzIGluIGF1dG9tYXRpYyBtb2RlIHRoZW4gYSB1c2VyIGhhcyB0byBzd2l0Y2ggdGhlDQo+ZGV2
aWNlIHRvIG1hbnVhbCBtb2RlIGFuZCB0aGVuIG1hbnVhbGx5IHNldCB0aGUgTkNPIHBpbiBhcyBj
b25uZWN0ZWQuDQoNCkZyb20gdGhpcyBwZXJzcGVjdGl2ZSBzZWVtcyB0byBtZSBsaWtlIGEgZGV2
aWNlIG1vZGUgbm90IGEgbmV3IHBpbi4NCklmIEkgaGF2ZSBwaW4gSSBjYW4gYXV0b21hdGljYWxs
eSBzd2l0Y2ggdG8gaXQuDQoNCj4NCj4+IFN1Y2ggTkNPIG1vZGUvcGluIGlzIGRlc2lnbmVkIG9u
bHkgZm9yIHRoaXMgc2luZ2xlIHNwZWNpZmljIHVzZSBjYXNlDQo+PiB3aGVyZSBhIHRpbWVjYXJk
IGNvbnRhaW5zIGEgRFBMTCBhbmQgUEhDPw0KPg0KPlRoaXMgaXMgZGVzaWduZWQgZm9yIGEgSFcg
d2hlcmUgRFBMTCBjaGFubmVscyAoZGV2aWNlcykgc3VwcG9ydCBUb0QNCj5jb3VudGVycyAoY2Fu
IGFjdCBhcyBQSEMgYmVzaWRlcyBEUExMIGZ1bmN0aW9uYWxpdHkpIGFuZCBzdXBwb3J0IHRoZQ0K
Pm1vZGUgd2hlcmUgRFBMTCBpcyBub3QgbG9ja2VkIHRvIGFueSBwaHlzaWNhbCBpbnB1dCBhbmQg
YWxsb3dzIHR1bmluZw0KPm9mIGl0cyBmcmVxdWVuY3kuDQo+DQo+PiBBbnkgZGlhZ3JhbT8NCg0K
Pw0KDQo+Pg0KPj4gSXMgdGhlcmUgYW55IG90aGVyIHVzZSBjYXNlIGZvciBzdWNoIHBpbj8gKE5D
TyBpcyByYXRoZXIgYSBnZW5lcmFsDQo+PiBEUExMIGNvbnRyb2wgbWVjaGFuaXNtPykgU2hvdWxk
bid0IGl0IGJlIGNhbGxlZCBleHBsaWNpdGx5IGxpa2UNCj4+IHB0cC1uY28/DQo+SSBkaXNjdXNz
ZWQgdGhpcyB3aXRoIEppcmkgYW5kIHJlc3VsdCB3YXM6DQo+LSBEUExMX01PREUgaXMgaW5wdXQg
c2VsZWN0aW9uIHN0cmF0ZWd5DQo+LSBOQ08gaXMgYSBjYXNlIG9mIG1hbnVhbCBzZWxlY3Rpb24g
c3RyYXRlZ3kNCj4NCj5BbmQgKl9JTlRfUFRQX05DTyBvciAqX1BUUF9OQ08/DQo+DQo+WWVzLCB0
aGlzIGNvdWxkIGJlIHJlYXNvbmFibGUuLi4gSSBjYW4ndCB0aGluayBvZiBhbnl0aGluZyBlbHNl
IHRvIHVzZQ0KPm90aGVyIHRoYW4gUFRQLi4uIGZvciBub3cgKGNhbiBiZSBjaGFuZ2VkIGluIGZ1
dHVyZSkuDQo+DQo+VGhhbmtzLA0KPkl2YW4NCg0KWWVhaCBidXQgbGV0J3MgY2xvc2UgdGhlIHBy
ZXZpb3VzIHRoaW5neSwNCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQo=

