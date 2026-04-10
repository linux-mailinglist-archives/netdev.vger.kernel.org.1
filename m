Return-Path: <netdev+bounces-277435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCuwGgcI2WnolAgAu9opvQ
	(envelope-from <netdev+bounces-277435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:24:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61993D89D4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F433003EE5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443B3D093A;
	Fri, 10 Apr 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFhLtV3W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72203CFF4C;
	Fri, 10 Apr 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831044; cv=fail; b=MVsQPzm+GO8CJcANGGiONtl5P8Ua5Gw7HQUH94UwAnuOis/WwbhZ+ku84P6cP7sqdkBT/Vt3a7Ss3vSXfF61iV+5F1B7bcHyAP83qfJQtgcEou9rSgwF1ZI056dU7VsbWZ+LomXLQSkaM9EhSq+09Ok1GCYt0u/u5e5SRs2DHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831044; c=relaxed/simple;
	bh=fymaIpmsIVYF3V5vn5K3KjyggD9doOr5OgZTcBZ4hIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOVkBWr2dTqegY1+8OMKHSg8Y6VD7mPmCsqB/jjeXd8VyHJRRO/1Vu17O087hM0s95HSH3wGBtPvTKSyQbPJQWyNppDSdLrz/Vyyl9xVTUdUFmZI7YZ+y1V47plo47/iIP98KvIWpflZ1YvwVVcKeSPX2oEAfIpU25PTk4vH0JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFhLtV3W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775831043; x=1807367043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fymaIpmsIVYF3V5vn5K3KjyggD9doOr5OgZTcBZ4hIg=;
  b=LFhLtV3WLx2pLImXr+elV/3e6Tz8wI8l7vcQreu6CV1tlU0DCrsB1mAw
   scvHzNRCGAs6lrh4FRtlZfAQFiGSysdLa2FsntyADgZU/fRKtlTuZH3lE
   AaOhTJJVOD1Erateovq40wo+wGrr0Pfv2Nm+3Mqy2PUHi1soiqpBn6MIk
   cnOEPGvPQDX1y3aeGZ78CNyyzl/Zg3YeCBrfGQART5OidilP0FbBoRQQF
   loNhux5b4FehWh/YQTNZZEDoYfyzGWx304DSmtaHpO/Fa7f7g3SHy8VL9
   RUFbJiYNw0ABK0EIEFze9nhRHOeN5lzyO45N3ybcNFkTrSF/RhADnoJkW
   Q==;
X-CSE-ConnectionGUID: Xgw5ege3QQ24Vcv6VX3gnw==
X-CSE-MsgGUID: tV0oqeBKSiKXjotI/MaiKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88293913"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="88293913"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:24:03 -0700
X-CSE-ConnectionGUID: Vt6Om2ISRx61n3Iqz+9s0Q==
X-CSE-MsgGUID: nxwqDtu3RuWCkbDZnAxUYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="229016962"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:24:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 07:24:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 07:24:01 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 07:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtwuUqaxtWTC3u8rCQP0dO2GKmHHKCMWrF+QL+fd4Qi+VIk++WRx8epr6JOZO7E2f4pTEPbvRyS14tUljiQEyqyPt2nmTWl1gxRCXwgbpWBu0syZ7OJkSxEEa9JsK6g9QtGKHNjBMT59G0X2mL+jI0oucNixYbkv53r/X7hLYGB4DVTzRWAHAMvFZrCGgOuMij8xaLmyy4/jSJKRwm7pOD6ISW078y2KOaRNoK1N1lXxC7A+q/3yfVJmjlQMzdX+W767TXuggAG3cQvQQ7tCBj4sJpVNcQl6/RNKojbqSQrM1EVjDWk/tx48QB6zbAaZwUOfxOW7f7oPXEYh6WC3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fymaIpmsIVYF3V5vn5K3KjyggD9doOr5OgZTcBZ4hIg=;
 b=j4qGDk2VaOKitHLEF4stMiFHfOHQUG54nfN6wqjmlaKDLrskXWwqowiX+TIvAzdPAe042RiOTn2WIIproRBHrU7w/+qBky+99x6IVwVD7aCLcaJDPMvLvs29lNNaLUYvpNuKtTMYjZ3oskw5D59KzXNrmrvq55r1Tv7B6UfBLThOAFlWYrdY94p1WVmKHboccijd9YHVopv2QxTPXYEHbvpy6Xod37UbRw394yh/RGIf0t3XsawOQBgJ/a7SRHG8T8c2uQvRUOWZ68VPNoHZ45WOAcGwNmXG1WF6w3FU78me4dRiZx5ymqTKDRTWG3w3i3uggG0Jv7PO6IAZG0AoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA1PR11MB9526.namprd11.prod.outlook.com (2603:10b6:806:4c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.45; Fri, 10 Apr
 2026 14:23:58 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 14:23:58 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Topic: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Thread-Index: AQHcwvXi5hF918e07EGu/X9NQPzLLrXS5QsAgAO6hfCAAOg2gIAA3TpQ
Date: Fri, 10 Apr 2026 14:23:58 +0000
Message-ID: <IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260409181041.395a0c37@kernel.org>
In-Reply-To: <20260409181041.395a0c37@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA1PR11MB9526:EE_
x-ms-office365-filtering-correlation-id: 2439e60e-1710-4238-5105-08de970ccdd7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: as+D57CIAM2wOyjoESPMYQbMDn/d3Gyt51KirP4gSM1pVv6FzVDdbFTPdRiAeIujo/ufyIjrDj7hz5BpuJN4Tb4lW3kIMLzY9H3eCx+OkMoEGIB8DdB1X38f5/6+AZVLTPjJnEudtN6zXhBvE/HB1Se1MXj+F/0Wa/cHxNqHOMQRIs3Dn5lGWxsYFEDucmlCpS5sCWwXve4w7enjXI6NwQrGhYyOpY3I5gvbYR2ugk8Y9VGPaeCYez6lMKfXHX4wSGCrVu2M8gNSYnP2F0YgLZ1dWsTj62bj1wYZf37oiNuo/2PhrdBhEbVJiuxeWxvLazcorCdUGUSNOzB6a/fOrpZiGE6y3ZQ0YsGKiC690t9dKFYA0NcmCPEbL39aVICLe4TM92LrRRc16NrU06cm5aUdtd9XZABZ3s7UxQsCWYS8tjR58Ls6coIDfDWY9zpOxbcHZrtlsoqD8Ml0fjlNXdEEsH2ijb6LiFOlDptWaE7UU10l55aRtLVDKJVieuGQhxHfYiU+jTum/GnwoGVEFYzWKDnI8e2sko3CUZ0Wg9RmNnuKxNZ54D3F63KUMaj4XKvQLV1jo7g2ihmbW6oo+WeZwBEcj9uNoTcxQedJFMXk+QPJuBchoMCWDnTVmSRd8pCxeYF2USMcb14YsV65u70if7qkr2qZEypGlBoIxGFYUz8d4wwXCSSyIDRk+jMtCxXV3LkiFOAvVH8Im9LsadGx72t1q58O3Y8XjTy1ffNu7cSTZMU+hUSmMmiYTcLjZvvv1ZPwiv9XBdvZR8c0qUpaOSJYsMnU/nR5ajFjomE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmNMUmFBV2tJdXB0QVZMRGlyaGZIMFZkM1F0Z2ZUWU9QbExldmJCTG95ZTFP?=
 =?utf-8?B?SzBnazRveUJhYUdrZEFkMFhySytWSkpqU0dGUlY4Rk1ia1dqYTkvYnNqR0U4?=
 =?utf-8?B?WGlBbkpRY0JWaDFENkxpSXdscS91YnlrQ2hUWmJxaGYrQzZHNWJ6WTBOalFB?=
 =?utf-8?B?RXBCWnNJNzlOUmNVQU9qbGtQU1dNQ3AzV3pCWTM3Z1haMFQ4ZXl2ZFBMNmpr?=
 =?utf-8?B?UnZOS1hBRXJVSHpUQytzYkNTZTNrT2FYeFZEcTVKRVg0QkkwamFrV1RETTF5?=
 =?utf-8?B?LzFYaFFTNmlKRHFpWWM0NW5nSXhWVEl6V0pvMWlIMUp6ZGFndzRocGZqQWg0?=
 =?utf-8?B?R2ljbjd5b1U5Q3h6elVEa1VMYWQ0YW9oNXlaS3NQUnR0Z2tlR1NaSFMrV3JM?=
 =?utf-8?B?bEVhTDJVZm1lczRxL1pUamE2REx1N21GQWZBcXRycFZkODV6UlNHQ0pVaXFo?=
 =?utf-8?B?RG5jZUJiQU5xREZZZjRxTFFTdGZUQUpubjB0czJVRFplTGc3eG9LS1ZOWHZC?=
 =?utf-8?B?Y0dOd0lQNWp3U3UyL1NWUkV0ODdVZUtkczlWQWVCa3ZRa1lGMnVHcEVvQy9B?=
 =?utf-8?B?NXRHWi9ZOFZaWjQrcUs0RGRDTmdlMFVyeUVxLzZvVm03SFhSMUNKcnlvdjF3?=
 =?utf-8?B?T0Nvalhwcld4anZCMUtOZFF2dnJDN3ZacTk0T1BjbWhncmdpc0xVV1lqVzda?=
 =?utf-8?B?aytBRG56eG0zTHpCMzdEaFFIN240REZhYjlQWG16dmh5MitxWW5xRUlUeXJG?=
 =?utf-8?B?bjhQVlI4alpJYm51SlJ1Qko4TExva3V0bXF4SmxZMGdqWW1QMUhXL3RZSFRq?=
 =?utf-8?B?alZjMmtkTnJZU2FuTDF4a1ZlUHJRS2tDMlB3akFoaGRHRU10TFJCYzJyelhV?=
 =?utf-8?B?Z2VMK3RvUnN6cnhYUUxjbjJOeDRiS0RhbkNTbzhPNEhoM2UvRmIxY0I3NHZT?=
 =?utf-8?B?Y1hXMnBhN3pKZk1nZFplc3RDalhDRTczYlRoSEh1RWQxeDdpcVV2aVhQb0hk?=
 =?utf-8?B?Skk4TXVqeFB4YXNYK0pEZko1RiswOUdCdklBdDhqWXlKTlRDb3pBL1V1ZVJQ?=
 =?utf-8?B?bUc5OElNcGVWY0MyanFLNkM2TCtSV2UwUzBtS21YcXc4ZlZhN2RTODBrRlNT?=
 =?utf-8?B?OHFkREJSWXZwMzZ5bXlaMG9ESllNci9oUG1kMDRjc3d3NWNUNDVhQ0tFeDRQ?=
 =?utf-8?B?VzJzQlYvdTVKdDR2QW9NRnNxaHpvY1E5RzRqc28yMjNKUWhMWUdHOXZxQnpO?=
 =?utf-8?B?QWx3M2d5VjFPejhLMkJOSEFOaTlHOEV3c0txZjhweHg2OUtNcEJmR1RldnVB?=
 =?utf-8?B?bnl3NnJ0VUF0eUNneE5LZ2JSaENPZ3V3b1BGQUg2N1VYcTZ4RStxRWYwdzhv?=
 =?utf-8?B?eDhRUDdsOWJvZ2t0ckRtOVVvcFIxSDdta0xGU1M5T0M1Y3dQQVhBZHlJSXJT?=
 =?utf-8?B?Rlk2SEcyY0lCdXBGdUVLMk1CUW92ZDJBVHdiUjJ4Qk40cTdtdHNIM1hhUFAr?=
 =?utf-8?B?MjJHVmhFbUcrNitzOGQ4a1ljRjVyT2JLRTJlaHFlYS9KVGJFa09ld1h6bW81?=
 =?utf-8?B?TmFMUEorRjlFMzRFc0dqOFVzM2NkNUx0Umh6Y1l0ZmxlQ2xDYS9lc1Y1K00z?=
 =?utf-8?B?WVV0OVBCUFNiZ3ZFQ2JsVys4SjVnYzlFWnB6NklVb2plWU5EekEzYzMxUXAx?=
 =?utf-8?B?c1lkS25nNkFzTlRSdFlla1JhVm9KRTRrN1IwSUo2TTFMRVRPeklOU1hjMWNK?=
 =?utf-8?B?NktHQlU1eGJXb0ZjbDFsbmxsSE9UVzNGYWlQakFldUtya1ZkT1JNeVdXcFZ2?=
 =?utf-8?B?R0RYUkxhOVhJeVk0dVdYbnF1eEkwRm84RXNHb01oQ3M1ZWprb1UyOUhDSlB3?=
 =?utf-8?B?NnNNcUtYUi94dXhsb0VVbXdWeHVKd3ZUUXRSQ1BHRFQzc1JTNDN6cjhoZ3dx?=
 =?utf-8?B?MjFKZjNPcnZWSDZuQW5Ea1JsWEFaNEl5UlNXTDVma0FXWEROeVVuZCtPZ2I3?=
 =?utf-8?B?U2VENUtMVnd1K09sbFBoVDlHU1VHZkxTUGFYT0pkNUVtWWg4NDlVSkJKaVVU?=
 =?utf-8?B?czg1VFk5TDA4ZUZKYkZrR0VLMGNRNVd3QndPU2FVNnFIZzh4MnNhb1ZQemNo?=
 =?utf-8?B?TGVUMlF3OFpqRDBsbTdUekVvR2JVUk40a3plWXlFMDJVTGk3MkJCSlFySXI4?=
 =?utf-8?B?aS9VdkkzdnFobU9Qd3JhQ2RzWWtOcWUwWncrYitLc1pXVU13V1R0WERpNUdD?=
 =?utf-8?B?Z1BUdlZUejI0U1VqYy9iSWEvT29yUlh2RWFRUEJJS1BlSmwzdTBxTCs0Z3h5?=
 =?utf-8?B?NkJZNTJySk40VjVGSVgzQmM0WCtiMjVYT1lFc1ZwZVBRdUFQMjU3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nJhZrFsT7dD0z79/DFnIgTcficxeiG9JclJtXWePxnRCu4r5cnkF2m3a7HFihvVgh0V4xJOYVW2/3gsG2e/r78Bd4CKrwzWp8kQWlcDUdzIn3C+Nu8PPWw0OK/pGExvV3EWR8FtpAh02twwjmdhi940DjrU6Fcy93exH4xwx0ISau5sS7Gj7EKlAezCwOl84hAfH5ekKGumfVHGXimFS21mtvV0+iWXRuCvLHt1zFOYYr/wa3aDEUBH6UiKJEuCje3xPy4rEhW+pXENliw8OG+L/twzydnLTKjvaYLP7C/7CmZrZ7+IrpU8I/W6ypDPPrJp/8ylwHpG1dqMyHbP19w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2439e60e-1710-4238-5105-08de970ccdd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 14:23:58.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yxfbIkygafxSnvo6szExRvhsd3Wei1t2uoobOE9eELhKxjGumNfarszXguGDThSuxq8q2fPKEkbXwk+LeX2XLjwU5sra5St8Q4tiLCxMek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9526
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277435-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B61993D89D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMCwgMjAyNiAzOjExIEFN
DQo+IFRvOiBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVsLmNvbT4NCj4gQ2M6
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlu
dGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZzsgT3JvcywgUGV0ciA8cG9yb3NAcmVk
aGF0LmNvbT47DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
PjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgUHJh
dGhvc2guU2F0aXNoQG1pY3JvY2hpcC5jb207IFZlY2VyYSwNCj4gSXZhbiA8aXZlY2VyYUByZWRo
YXQuY29tPjsgamlyaUByZXNudWxsaS51czsgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+IDxhcmth
ZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyB2YWRpbS5mZWRvcmVua29AbGludXguZGV2Ow0K
PiBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhh
dC5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NSBuZXQtbmV4dCAwLzhdIGRwbGwvaWNlOiBBZGQgVFhDIERQTEwg
dHlwZSBhbmQgZnVsbCBUWA0KPiByZWZlcmVuY2UgY2xvY2sgY29udHJvbCBmb3IgRTgyNQ0KPiAN
Cj4gT24gVGh1LCA5IEFwciAyMDI2IDExOjIxOjM1ICswMDAwIE5pdGthLCBHcnplZ29yeiB3cm90
ZToNCj4gPiA+IE9uIEZyaSwgIDMgQXByIDIwMjYgMDE6MDY6MTggKzAyMDAgR3J6ZWdvcnogTml0
a2Egd3JvdGU6DQo+ID4gPiA+IFRoaXMgc2VyaWVzIGFkZHMgVFggcmVmZXJlbmNlIGNsb2NrIHN1
cHBvcnQgZm9yIEU4MjUgZGV2aWNlcyBhbmQNCj4gZXhwb3Nlcw0KPiA+ID4gPiBUWCBjbG9jayBz
ZWxlY3Rpb24gYW5kIHN5bmNocm9uaXphdGlvbiBzdGF0dXMgdmlhIHRoZSBMaW51eCBEUExMDQo+
ID4gPiA+IHN1YnN5c3RlbS4NCj4gPiA+ID4gRTgyNSBoYXJkd2FyZSBjb250YWlucyBhIGRlZGlj
YXRlZCBUeCBjbG9jayAoVFhDKSBkb21haW4gdGhhdCBpcw0KPiA+ID4gPiBkaXN0aW5jdA0KPiA+
ID4gPiBmcm9tIFBQUyBhbmQgRUVDLiBUWCByZWZlcmVuY2UgY2xvY2sgc2VsZWN0aW9uIGlzIGRl
dmljZeKAkXdpZGUsIHNoYXJlZA0KPiA+ID4gPiBhY3Jvc3MgcG9ydHMsIGFuZCBtZWRpYXRlZCBi
eSBmaXJtd2FyZSBhcyBwYXJ0IG9mIHRoZSBsaW5rIGJyaW5n4oCRdXANCj4gPiA+ID4gcHJvY2Vz
cy4gQXMgYSByZXN1bHQsIFRYIGNsb2NrIHNlbGVjdGlvbiBpbnRlbnQgbWF5IGRpZmZlciBmcm9t
IHRoZQ0KPiA+ID4gPiBlZmZlY3RpdmUgaGFyZHdhcmUgY29uZmlndXJhdGlvbiwgYW5kIHNvZnR3
YXJlIG11c3QgdmVyaWZ5IHRoZQ0KPiBvdXRjb21lDQo+ID4gPiA+IGFmdGVyIGxpbmvigJF1cC4N
Cj4gPiA+ID4gVG8gc3VwcG9ydCB0aGlzLCB0aGUgc2VyaWVzIGludHJvZHVjZXMgVFhDIHN1cHBv
cnQgaW5jcmVtZW50YWxseSBhY3Jvc3MNCj4gPiA+ID4gdGhlIERQTEwgY29yZSBhbmQgdGhlIGlj
ZSBkcml2ZXI6DQo+ID4gPiA+DQo+ID4gPiA+IC0gYWRkIGEgbmV3IERQTEwgdHlwZSAoVFhDKSB0
byByZXByZXNlbnQgdHJhbnNtaXQgY2xvY2sgZ2VuZXJhdG9yczsNCj4gPiA+DQo+ID4gPiBJJ20g
bm90IGdyYXNwaW5nIHdoeSB0aGlzIGlzIG5lZWRlZCwgaXNuJ3QgaXQgcGFydCBvZiBhbnkgRUVD
IHN5c3RlbQ0KPiA+ID4gdGhhdCB0aGUgRFBMTCBjYW4gZHJpdmUgdGhlIFRYQz8gSXMgeW91ciBz
eXN0ZW0gZ29pbmcgdG8gZXhwb3NlIG11bHRpcGxlDQo+ID4gPiBEUExMcyBub3cgZm9yIG9uZSBO
SUM/DQo+ID4NCj4gPiBIZWxsbyBKYWt1YiwNCj4gPiBGb3IgRTgyNSBkZXZpY2UsIHRoZSBzaG9y
dCBhbnN3ZXIgaXMgeWVzLiBXZSBoYXZlIHBsYXRmb3JtIEVFQyBub3cgYW5kDQo+ID4gd2Ugd2Fu
dCB0byBhZGQ6DQo+ID4gLSBUWEMgRFBMTHMgcGVyIHBvcnQsIGFuZA0KPiA+IC0gUFBTIERQTEwg
Zm9yIFRTUExMIGNvbmZpZyBwdXJwb3NlcyAoaW4gdGhlIG5lYXIgZnV0dXJlKQ0KPiA+DQo+ID4g
RUVDIChFdGhlcm5ldCBFcXVpcG1lbnQgQ2xvY2spIHR5cGUgRFBMTCBpcyBkZXNpZ25lZCB0byBj
b250cm9sIG11bHRpcGxlDQo+ID4gc291cmNlIHNpZ25hbHMgKGludGVybmFsLU5JQyBvciBleHRl
cm5hbCksIHdoZXJlIG9uZSBkcml2ZXMgdGhlIGRwbGwgZGV2aWNlLA0KPiA+IHdoZXJlIG11bHRp
cGxlIG91dHB1dHMgYXJlIHBvc3NpYmxlLCBlYWNoIGNvdWxkIGRyaXZlIHZhcmlvdXMgY29tcG9u
ZW50cw0KPiA+IGFzIHdlbGwgYXMgcHJvcGFnYXRlIHNpZ25hbCB0byBleHRlcm5hbCBkZXZpY2Vz
Lg0KPiA+IFRYQyBpcyBzcGVjaWZpYyBkcGxsIGRldmljZSB0aGF0IGFzc29jaWF0ZWQgd2l0aCBz
aW5nbGUgRVRIIHBvcnQgdG8gY29udHJvbCBpdCdzDQo+IHNvdXJjZSwNCj4gPiB0aGVyZSBpcyBu
byBuZWVkIHRvIGRlY2xhcmUgYW55IG91dHB1dHMgYXMgdGhlIHNpbmdsZSBvdXRwdXQgaXMgYWxy
ZWFkeQ0KPiBkZXRlcm1pbmVkLg0KPiA+IEJhc2ljYWxseSwgaGF2aW5nIFRYQyBEUExMIGluZGlj
YXRlcyBwZXIgcG9ydCBjb250cm9sIG92ZXIgU3luY0UgKG9yIHNvbWUNCj4gZXh0ZXJuYWwpDQo+
ID4gY2xvY2sgc291cmNlLg0KPiANCj4gQ291bGQgeW91IHNoYXJlIGEgZGlhZ3JhbSBvZiBob3cg
dGhpbmdzIGFyZSB3aXJlZCB1cD8NCj4gRFBMTCBjYW4gaGF2ZSBtdWx0aXBsZSBvdXRwdXRzIGFu
ZCBtdWx0aXBsZSBpbnB1dHMuIEknbSBub3QgZ2V0dGluZyB3aHkNCj4gYSBzaW5nbGUgZGV2aWNl
IHdvdWxkIGhhdmUgdG8gaGF2ZSBtdWx0aXBsZSBhY3R1YWwgRFBMTHMgKHdoaWNoIG1ha2VzDQo+
IG1lIHdvcnJpZWQgdGhpcyBpcyBqdXN0IHNvbWUgImNvbnZlbmllbnQgdXNlIG9mIHRoZSB1QVBJ
IikNCg0KSGVsbG8gSmFrdWIsDQoNCkhlcmUgaXMgdGhlIGhpZ2gtbGV2ZWwgY29ubmVjdGlvbiBk
aWFncmFtIGZvciBFODI1IGRldmljZS4gSSBob3BlIHlvdSBmaW5kIGl0IGhlbHBmdWw6DQoNCiAg
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsgICAgICAgIA0KICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgDQogIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgICAgICB8
ICAgICAgICANCiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgIHwgICAgICAgIA0KICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgIE1BQyAgICAgICAgICAgICAgICAgfCAgICAgICAgfCAgICAgICAgDQog
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICB8Ky0tLS0tLS0tLS0tLSstLS0tLSsgICAgICAg
ICB8ICAgICAgICB8ICAgICAgICANCiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8Ulgv
MTU4OCB8UEhDfHRzcGxsPC0tLS1cICAgIHwgICAgICAgIHwgICAgICAgIA0KKy0tLSstLS0tKyAg
ICAgICAgICAgICAgICAgICAgfHxNVVggICAgICstLS0rLV4tLS18ICAgIHwgICAgfCAgICAgICAg
fCAgICAgICAgDQp8IEUgfCBSWCA+LS0tLS0tLS0tLS0tLS0tLS0tLS0tPiAgICAgICAgICAgICAg
fCAgID4tLVwgfCAgICB8ICAgICAgICB8ICAgICAgICANCnwgVCB8ICAgIHwgICAgLy0tLS0tLS0t
LS0tLS0tLS0+ICAgICAgICAgICAgICB8ICAgPi1cfCB8ICAgIHwgICAgICAgIHwgICAgICAgIA0K
fCBIIHwtLS0tKyAgICB8ICAgICAgICAgICAgICAgfCstLS0tLS0tLS0rLS0tLV4tLS0rIHx8IHwg
ICAgfCAgICAgICAgfCAgICAgICAgDQp8IDEgfCBUWCA8LS0tLXwtLS0tLS0tLS0tLS0tLS0tK1RY
IE1VWCAgIDwgT0NYTyAgIHwgfHwgfCAgICB8ICAgICAgICB8ICAgICAgICANCnwgICB8UExMIHwg
ICAgfCAgICAgICAgICAgICAgIHx8ICAgICAgICAgfC0tLS0tLS0tfCB8fCB8ICAgIHwgICAgICAg
IHwgICAgICAgIA0KKy0tLSstLS0tKyAgICB8ICAgICAgICAgICAvLS0tLSsgICAgICAgICA8LWV4
dF9yZWY8LXx8LXwtLS0tfC0tLS0tLS0tLWV4dF9yZWYgDQp8IEUgfCBSWCA+LS0tLS8gICAgICAg
ICAgIHwgICB8fCAgICAgICAgIHwtLS0tLS0tLSsgfHwgfCAgICB8ICAgICAgICB8ICAgICAgICAN
CnwgVCB8ICAgIHwgICAgICAgICAgICAgICAgfCAgIHx8ICAgICAgICAgPCAgU3luY0UgfCB8fCB8
ICAgIHwgICAgICAgIHwgICAgICAgIA0KfCBIIHwtLS0tKyAgICAgICAgICAgICAgICB8ICAgfCst
LS0tLS0tLS0tLV4tLS0tLS0rIHx8IHwgICAgfCAgICAgICAgfCAgICAgICAgDQp8IDIgfCBUWCA8
LS0tLS0tLS0tLS0tLS0tLS8gICB8ICAgICAgICAgICAgfCAvLS0tLS0tfHwtLyAgICB8ICAgICAg
ICB8ICAgICAgICANCnwgICB8UExMIHwgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS18
LXwtLS0tLS18fC0tLS0tLSsgICAgICAgIHwgICAgICAgIA0KKy0tLSstLS0tKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8tLS8gfCAgICAgIHx8ICAgICAgICAgICAgICAgfCAgICAgICAg
DQp8IC4gfCBSWCA+LS0tICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICB8ICAgICAgfHwg
ICAgICAgICAgICAgICB8ICAgICAgICANCnwgLiB8ICAgIHwgICAgICAgICAgICAgICAgICAgKy0t
LS0tLS0tLS18LS0tLXwtLS0tLS18fC0tKyAgICAgICAgICAgIHwgICAgICAgIA0KfCAuIHwtLS0t
KyAgICAgICAgICAgICAgICAgICB8ICAgICAgICArLV4tKy0tXisgICAgIHx8ICB8ICAgICAgICAg
ICAgfCAgICAgICAgDQp8ICAgfCBUWCA8LS0tICAgICAgICAgICAgICAgIHwgICAgICAgIHxFRUN8
UFBTfCAgICAgfHwgIHwgICAgICAgICAgICB8IA0KfCAgIHxQTEwgfCAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICArLS0tLS0tLSsgICAgIHx8ICB8ICAgICAgICAgICAgfCAgICAgICAgDQorLS0t
Ky0tLS0rICAgICAgICAgICAgICAgICAgIHwgICAgICAgIHwgICAgICAgPC1DTEswL3wgIHwgICAg
ICAgICAgICB8ICAgICAgICANCnwgRSB8IFJYID4tLS0gICAgICAgICAgICAgICAgfCAgICAgICAg
fCAgRFBMTCB8ICAgICAgfCAgfCAgICAgICAgICAgIHwgICAgICAgIA0KfCBUIHwgICAgfCAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICB8ICAgICAgIDwtQ0xLMS0vICB8ICAgICAgICAgICAgfCAg
ICAgICAgDQp8IEggfC0tLS0rICAgICAgICAgICAgICAgICAgIHwgICAgICAgIHwgICAgICAgfCAg
ICAgICAgIHwgICAgICAgICAgICB8ICAgICAgICANCnwgWCB8IFRYIDwtLS0gICAgICAgICAgICAg
ICAgfCAgICAgICAgfCAgICAgICA8LS0tU01BLS0tPCAgICAgICAgICAgIHwgICAgICAgIA0KfCAg
IHxQTEwgfCAgICAgICAgICAgICAgICAgICB8ICAgICAgICB8ICAgICAgIHwgICAgICAgICB8ICAg
ICAgICAgICAgfCAgICAgICAgDQorLS0tKy0tLS0rICAgICAgICAgICAgICAgICAgIHwgICAgICAg
IHwgICAgICAgPC0tLUdQUy0tLTwgICAgICAgICAgICB8ICAgICAgICANCiAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgfCAgICAgICB8ICAgICAgICAgfCAgICAgICAgICAgIHwg
ICAgICANCiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgfCAgICAgICA8LS0t
Li4uLS0tPCAgICAgICAgICAgIHwgICAgICAgIA0KICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgICB8ICAgICAgIHwgICAgICAgICB8ICAgICAgICAgICAgfCAgICAgICAgDQogIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICstLS0tLS0tKyAgICAgICAgIHwgICAg
ICAgICAgICB8ICAgICAgICANCiAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfCBFeHRlcm5h
bCB0aW1pbmcgbW9kdWxlICAgfCAgICAgICAgICAgIHwgICAgICAgIA0KICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rICAgICAgICAgICAgfCAg
ICAgICAgDQogICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKyAgICAgICAgDQogDQpCZWZvcmUgdGhpcyBzZXJpZXMsIHdl
IHRyaWVkIGRpZmZlcmVudCBhcHByb2FjaGVzLg0KT25lIG9mIHRoZW0gd2FzIHRvIGNyZWF0ZSBN
VVggcGluIGFzc29jaWF0ZWQgd2l0aCBuZXRkZXYgaW50ZXJmYWNlLg0KRVhUX1JFRiBhbmQgU1lO
Q0UgcGlucyB3ZXJlIHJlZ2lzdGVyZWQgd2l0aCB0aGlzIE1VWCBwaW4uDQpIb3dldmVyIEkgcmVj
YWxsIHRoZXJlIHdlcmUgYXQgbGVhc3QgdHdvIGlzc3VlcyB3aXRoIHRoaXMgc29sdXRpb246DQot
IHdoZW4gdXNpbmcgRFBMTCBzdWJzeXN0ZW0gbm90IGFsbCB0aGUgY29ubmVjdGlvbnMvcmVsYXRp
b25zIHdlcmUgdmlzaWJsZQ0KICBmcm9tIERQTEwgcGluLWdldCBwZXJzcGVjdGl2ZS4gUlQgbmV0
bGluayB3YXMgcmVxdWlyZWQNCi0gZHVlIHRvIG1peGluZyBwaW5zIGZyb20gZGlmZmVyZW50IG1v
ZHVsZXMgKGxpa2UgZndub2RlIGJhc2VkIHBpbiBmcm9tIHpsIGRyaXZlcg0KICBhbmQgdGhlIHBp
bnMgZnJvbSBpY2UpLCB3ZSB3ZXJlIG5vdCBhYmxlIHRvIHNhZmVseSBjbGVhbiB0aGUgcmVmZXJl
bmNlcyBiZXR3ZWVuDQogIHBpbnMgYW5kIGRwbGwgKGJhc2ljYWx5IC4uIHdlIG9ic2VydmVkIGNy
YXNoZXMpDQoNClByb3Bvc2VkIHNvbHV0aW9uIGp1c3Qgc2VlbXMgdG8gYmUgY2xlYW4gYW5kIGZ1
bGx5IHJlZmxlY3RzIGN1cnJlbnQNCmNvbm5lY3Rpb24gdG9wb2xvZ3kuDQoNCldoYXQncyBhY3R1
YWxseSB5b3VyIGJpZ2dlc3QgY29uY2Vybj8NClRoZSBmYWN0IHdlIGludHJvZHVjZSBhIG5ldyBE
UExMIHR5cGU/IE9yIG11bHRpcGx5IERQTEwgaW5zdGFuY2VzPyBPciBib3RoPw0KRG8geW91IHBy
ZWZlciB0byBzZWUgIm9uZSBiaWciIERQTEwgd2l0aCAxNiBwaW5zIGluIG91ciBjYXNlICg4IHBv
cnRzIHggMiB0eC1jbGsgcGlucyk/DQpFYWNoIHBpbiB3aXRoIHRoZSBuYW1lIGxpa2UsIGZvciBl
eGFtcGxlLCBQRjAtU3luY0UvUEYwLWVSZWYgZXRjLj8NCg==

