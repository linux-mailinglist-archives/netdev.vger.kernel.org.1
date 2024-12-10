Return-Path: <netdev+bounces-150820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E159EBAA9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2823166555
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A26226862;
	Tue, 10 Dec 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZ5NuW5y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6121420E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861468; cv=fail; b=aS0A8j2rZbowOL7FINFQ8wUZR3hOBo5UrQsF9XKYrxucDd96++HW3/xC+9SObdArdnbS3vIxpae7qfc4o2aB2zIUUWi0QOFrT5CBiMzh1wT9ktYAx5yPEIPOD+vtQxES6bpAoUpuzi1znBYI5MlV4hWXr6vnGdC1ujlTGfiy/2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861468; c=relaxed/simple;
	bh=NBXZG+Kxqx+rC7wUN1V9KA/5Uhx9B6Dg9WBWAIhrtUo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RWrSuCb1cQwdtDbpF8Ip4weXeg1jr8r+FVT38WV8abFy40VTmuwhua+dUcXnHnUiM5qEVrhkotoMXg31jTFNmeh0OknUXd4IZZH/RLnwgeNE+CEpEdQsVCvdE7yYU6/xf8grGoFWmr3nCbVbhtzCPv/Dn3GTTkkGrgmfsDqR1Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZ5NuW5y; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733861467; x=1765397467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NBXZG+Kxqx+rC7wUN1V9KA/5Uhx9B6Dg9WBWAIhrtUo=;
  b=YZ5NuW5yUlDA5zON1u2j3C8db+m1b8bw944rarb+TS9ZKeLJx3PD7cHG
   +FauJx8ixMYLDniVVr9Sa20ht29RYAy+iqLX17zv5z7lYoHFks5pDnK0z
   tU3kRX0VSvs7QWvPkOWWGdswtHeiDPWlr736m5lObPvO/4DNCpHTKz2Uj
   P6YMk9zeiarady1oQ+wvUIjkMFHLE9mwtSx6KFc5qcrY9wRj9WNpkCNWq
   2DdyjqaFjgqr7W9huVEx8bzRgGuxhfQhYCoQM3evoSffG10VHxMe+USCd
   E+Y6q92cmJC1GxfaOwlJEGkApjHocdRPHnIiGqy1DSNHrD1AMFBbwbpph
   Q==;
X-CSE-ConnectionGUID: NQGmfZ9mQwi32La5/YhMNg==
X-CSE-MsgGUID: 3SumosOKQ+2+SVY0o4UxUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45624989"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="45624989"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:11:06 -0800
X-CSE-ConnectionGUID: G84tLPUaRzSyfCb3G5lgFQ==
X-CSE-MsgGUID: fjyrqsecTxWd69xdVrMePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126331309"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 12:11:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 12:11:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 12:11:05 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 12:11:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6upVCKkMqNHjbm+LKKrvsmMisfOQGHY8OZheJL7UaqdLdTGHRqdSjwcX8iOEZ0405Y7y8b6YtOjSDc1xsAgSjwpbIGpboIf1Lhq/XSuvZmSfSN8Q7jxiD2PNtLUPo3iEuukUPfVivrbAjx3mkYyY58BPtI5bPR3HO/rXTdEq/9151az9qu4r1CGS/lR4pknXlFb3QfdPklzXohkOoZJBSvnYbRot3WjgtaVw5JNopmvJ9T5WQwVZy/CQjN6TG176R3Wh3l50o9mQypEYaZVwOIwbl8gyQRTUOh8jjOCeX00v2WKS4x43WxQo7YPznwB3V+YEaejJeNHM1rRwNiBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv4IExHW05m5LnTTxWoWhSQSsF1f4/2rkUxU6p74340=;
 b=zOJqhh8Hh9ngfm4AH4HEtkTHd7DeScWpiSu0kZvpW8oTtTMbWG8w1DwoPGdOke3sf2+pIwdzh6ORF3EbwHd4P7q4Dw6XEtAKt/cjoinY2Kgx2/dCNWY0mUBqyunRbqOsB6BmWeskiztbuWxpD2R4oLnGtTh8s1fFFoQkxkhbv6KTowUgBRXY9QZ6cjjI/3g35U2ZbKEXS799MuZR3uOAG6XVDAD5aef7QmwAvC7l2BDRtkjYrtYmIInTriLxGW59Brcm/Onrs89ZTMNEUX/Gg8SF/XrG2Im9A56FipmoP5KO8b5TnhDFV70J2XfB4VIi34XM97WNloJTa3WiOP3t6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by LV1PR11MB8849.namprd11.prod.outlook.com (2603:10b6:408:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 20:10:58 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 20:10:58 +0000
Message-ID: <22226518-bb44-480b-98af-a949c5a3ed84@intel.com>
Date: Tue, 10 Dec 2024 12:10:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
 <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
 <20241209141838.5470c4a4@kernel.org>
 <89f34386-1d18-423f-a105-228eb3d9c345@intel.com>
 <20241210105952.xbh7gnoaxseni66q@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210105952.xbh7gnoaxseni66q@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|LV1PR11MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: e488602f-6aa9-4ca2-d123-08dd1956c2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHQrbTQ3Qkh6dEFEQTlQek8wK2RJUGVYOWlzQ05ROUVCMGh0aFZRZ1NaQmlS?=
 =?utf-8?B?WVVYYmp4NWl2ak1IUVBqMGRqNytKK3ExcGhVTUVsbitnR1hjOUptemc4YlRa?=
 =?utf-8?B?QzdIbUc5M2xUYktwdG1ac3FVWUViamJjSk5mck5QNWR3TWZ3NnphQzRXSHlY?=
 =?utf-8?B?OHZBeiswY2o4N0xZd3ptNDNRaTNCK2pSTm9BSnFDUFJtdnZ0VlBFdWtCaU9x?=
 =?utf-8?B?UnNmYkJ5c01rUWREekFkMVlWbzR6MlViQSt5QTFJRzZEY1V3N2xGOHczM0ow?=
 =?utf-8?B?V2tqRkVTckhSdmttVE1KZ0lIY3ZaL1phVkZJL3NVL3R5bWJSV1d2OTVWNGdH?=
 =?utf-8?B?QWZ0UXpUMzZJUkUyQVN4emdNSTJTWWc0ZTV2NGkwTmhnajlvdjFsZkhtQmtR?=
 =?utf-8?B?Y21vb0JlWkhCYURzU2ZGVlJnUHhCeXJXSmFMdmlKOFVMb0ZNSFBqVm9lazRh?=
 =?utf-8?B?dnRkemFOTmpuZVRSY3NBL2Zlb1hja0Fpc3pKSnZaSVVaNzdPV2hjSXAvZ1d0?=
 =?utf-8?B?bVRMRTlJTHlMZTMxQ1BqSDJYOWlkMWdJenhBYWtENmZuOWlxc0l5Yi9rdUVW?=
 =?utf-8?B?bitQM1dRdlk3a1R0dHhHNmtiSVpKSVRGZjYvYlBST3VGWEg1NzU0ODMrd1Fx?=
 =?utf-8?B?MTd4alh3MmJJSkU5UmpGTml2SWwxekpRRjFnR25hZUhla3hKeWRlem5YYjN6?=
 =?utf-8?B?Mk5PUVJvQ24xd3Q5QnRDRVNnZVBodm9tRmU1YzdLOG1uL1cvNVB1dS9XSzNQ?=
 =?utf-8?B?VnEwZnI4YTZYbjN0T2dXMG9sbTlGRUJsZmxNZ1ExSm9zY2ZJa2NGbzNheEEr?=
 =?utf-8?B?dkJITGxNM2V2MGtES1lvTTJYN0RDRXN1dlNtTzFQSkpLRnVLdzJ4c3labWtL?=
 =?utf-8?B?QTJ6YXp6cTJXQ0JDcHc5akdWZUNVTXlpZ2IwRFFIREZ0aUphWlZ0cS84MHJJ?=
 =?utf-8?B?NHFtNER3K3BMUzJmS0QrNldlajQ5SkNCY1AvdStRQmpqZ1RRTFZicGJHVTVH?=
 =?utf-8?B?eDd2RXJwUDNub1RYQjRjRmp5NjZ2YjhiVnAwWEVaTVZqMGJkK1E1N2RwNlpj?=
 =?utf-8?B?dzJoVVd1YUh4STVzeDRMZzZma0QxeGxFSnBVNldTd2x5dHhGdVl4NHg2REk3?=
 =?utf-8?B?eDNKOWNDRmlUWTZlTUdCZlFpQUtXbmtYcklIQ2dzRFl1VzhqUzRCN2lGRlRV?=
 =?utf-8?B?R2JYaGp3WTdPYndMQjlRRVNZbFh4SUwwdTdmYlU3MjltL3hmRzhJeUwzYTdE?=
 =?utf-8?B?UHh5RFB6aUcvejJQUExidXp6Ykx4UmpDeUpJNUhHUzAvYkZYRVV4OER6bG8y?=
 =?utf-8?B?ZzdpVWlkRFNidzVRSGN2RzJZZkVqZkF0Z2tFcXlHUXNwc0RpNmRJbUlJRWsw?=
 =?utf-8?B?U2hSYTZDdWZqUzRiYW5PaTJ3YUhyd29zcU11WjVHaUpVczZSaUZoWmtNQ29y?=
 =?utf-8?B?NmdpUXVlMHdzallTckIvUUw2b243Z2lyZnRMcDVYNmNZdW1mMFlDRGd6UHoy?=
 =?utf-8?B?ckxkZ0ZmOUZabjl4TUpnakVNRWVHMU1nMHFTRkdDU0RLcHpwVWNWZTZuSi9P?=
 =?utf-8?B?OGU1VW80OFVuY01Vd0Jqa3o4T2FrTml4aFI5WWNFMHMwcUhwOWZVTGlJZjg4?=
 =?utf-8?B?cE9uVW03WHRtZTRSeVFjTGw5ZnVpa1QxbGlWeTF0NnduSFVQckM1KzNJdWI4?=
 =?utf-8?B?ZUc5dVRkd2d4Q0RYdzl5YmN6TFpLZXdLeVpIeXhKYUVONFdRbmFycTNWNHVB?=
 =?utf-8?B?MzhqdHdTeHJWWmNPVmFuVDIrWDVsTDl4NEJiZ3FnbTlCRjE0TU8zVlo4Mldz?=
 =?utf-8?B?YkRwaTFnb2xVeTdlbXY2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hrUW9aMDVtWU8rVVZmZkd0dTNzRlJCdWlYVWpFL25RZ2prSXVwbTZaZE1Y?=
 =?utf-8?B?T0oxOU5GTHpxQ0xXNzFWeFhNdjdEQzhDTjBGQXJ2bmdhbEhWOUFOcE9nSUxY?=
 =?utf-8?B?VU1SU3pPeTAzeUZRLzhKT0JrZFN3YUZ2UHY5bTRzQW5jTExuSG83ZFN6aVpl?=
 =?utf-8?B?MTJDVHRMYWRHdzFRNUc1OUU1RTcxREpsNGV6Nmx5a3I1QzRpMml3eWNSWGM0?=
 =?utf-8?B?eHZNcUVTamtaR0ZYVm13c2ZNNk81SmJOMk81UHg2Zmo4MHBybHN3WjI3TXZU?=
 =?utf-8?B?MzlGUTFna0xEcjluZ1AyeHJ3a0c0bWE5YWcwLzJ3N2FiL3pId25Ba01nTDlo?=
 =?utf-8?B?WkhyS29lY1JDVFBJWVJ4RkxsQU5CaXVLVHl1QVZpbWlKNVo4R3pVMTdFUzBk?=
 =?utf-8?B?TnhGa3VkUGRCQlpZOUdOR0tub3pEalRIQWJDSi9PRWYvcUxBN3Z5RmVGV2h1?=
 =?utf-8?B?MWFqaFRQdXozUkwwMTF2UERLbnNHRTR1L3VQM0VydHZEeWNaOVl2ditVcjBO?=
 =?utf-8?B?c2lGaVVXdTRMRzFLR0lFSVZXYS9QSHdhN1htYTh5cUkvL3hlVHBkSXM2V21z?=
 =?utf-8?B?VWZKb0lpV2RGQ3ovWUFJQllQQVFib0tmQlozbXJDaGJTY21wMWRHV1NiT2NQ?=
 =?utf-8?B?SzR2eGZzRndGbnlBSlNpa2RSZC9uYkNma0tDWU56R2NRU0YwVU9zVXYvNzdh?=
 =?utf-8?B?TTVqaTRZbkl1TzZ5UEk1K3RibFU0endjL3pBU244RnZjWnp6NGQzNUY0R3hN?=
 =?utf-8?B?YUJ3dHZSUEdBUTUybDNOMXhYZVBVVjZrbi9LZEo4Z3VVOHNYZ3RHamQ2Vm1I?=
 =?utf-8?B?V1NzTTg3U3JKUzdkMDU2KzhkV2lhTjVYQ09tcThwMHdtSmY2aGdrSENRT2ph?=
 =?utf-8?B?NHg5ZXZvd3h1SzhWdGovOWZiblVQdXRRZ2FZbGdSWHRCOVZ2b29TRWx2Mkow?=
 =?utf-8?B?R3k4UWowNW51RFlmSURFaFlnTGErL3JZak9LTjU3OEoyUEZvL0F6WW43ZmtX?=
 =?utf-8?B?UFFvdU9PZi9qZWc2V3I2Zi9iNUtaZDVVclFpTWd5cTdDOUtLNGZRdUNxQVhx?=
 =?utf-8?B?MDJDVy9iY09BUVVUeHVZYmZtMkdyWlIxUXZjbWRYNUI0RWhCM0JvZjhwenI2?=
 =?utf-8?B?Nm5DNlUrcDUvallRU2c5TnA4ekR1YXRRT0hFVlArVTdJSjZmVFpYU1dsQnpK?=
 =?utf-8?B?NjdKWDRDK0pPN3F6Q0p3TVVSVnZxQmdQWUhoSnpVYnBDYXY1OWNpNERRUHdw?=
 =?utf-8?B?ZnB2ZmJyYm1UckpSTmdzeG1uT21KYVpmcWREV1VHbUNlTW1uMTRoblYvMStk?=
 =?utf-8?B?QnB2d2RHU0czOUt5eU5RSTlqcnpLVlRlSHVHMElseFM2cmRDb3dsOTA0R1Ew?=
 =?utf-8?B?QXpWT2Z5TmlRUCtHRDd5SUtSUVQ1WWlJdzZNSGFJeW1MY1pidTR6MzRRMUdX?=
 =?utf-8?B?SlVhUVZYSGN3djlrRHJ4dENlMmV0U1JRdmVsMUhmK0xOakw2akFJcGtZNTUr?=
 =?utf-8?B?L3VLN0x2YVRZQ3Z2RVdNVThSYWNhM25PSmp6WjFHV1hoTlBvYTJ1dEdQTlgx?=
 =?utf-8?B?ZldINHpyd0xnb1F6TEpiSThUQUJrbTVxOFB1ZWQzei9YR3NKSWlSS3AvdTBo?=
 =?utf-8?B?Q1dUMmZlc0l2WmEvQmtBUXA3OVlYN3BHeEZSUWlNSm9acllsa25lMS9Hemwv?=
 =?utf-8?B?ak5ZZEwyL0xEbWNCak9JR1dyMDlXNDc1TGVhQWtZUFU4d0lWQmdwSHpLM0pD?=
 =?utf-8?B?U2x1VDZyMHRSTHd3cXNHcXJGUlVkUmdOd3lFR2VIczBNRnZ4VlAxZnVBQ20z?=
 =?utf-8?B?bDZVcGF5UGoraCs1WitCL2xwV285OUx5a3pWQnJETnIwNUhBYlZTR1VGbjdX?=
 =?utf-8?B?S3VFSlJvV0REVHhiR1RUR05QVk5zbnR6enlxTXFkVWJpMXhpRGtXSXFxYm1R?=
 =?utf-8?B?NUpzOUVwWUhVcjk4MDlrN3RPVW1uSnZDVUhyWmZpVTRVUGplZDdBNzZKcnBB?=
 =?utf-8?B?ZUhaVCs1c1JVemVGeUJyR2l6U1hZbUJ2Z3ZMWElqY2hGK1JBL3pZb1NjVzN1?=
 =?utf-8?B?Nk8zb0ZxV0diWDVzSnR2Wk9rejNDV2VQOFFGakxlWUdBRzk1RktYNEd4S2di?=
 =?utf-8?B?dFZGcEFEcWZyOWFoRURSYkc1SHJaS2N5WjNZaVphak40THk2UGFEZG90WDJh?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e488602f-6aa9-4ca2-d123-08dd1956c2a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:10:58.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDXGfx73PjOqE2a335Wu9JFTbcxmkrnDq0lh3PgaVuU/yh+iN7Jc5TbxHACHTt/fdrCVuGacpoVFfNkaSdtzif5I+5CsHteYkAACDOvJPYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8849
X-OriginatorOrg: intel.com



On 12/10/2024 2:59 AM, Vladimir Oltean wrote:
> On Mon, Dec 09, 2024 at 03:05:54PM -0800, Jacob Keller wrote:
>> On 12/9/2024 2:18 PM, Jakub Kicinski wrote:
>>> On Wed, 04 Dec 2024 17:22:49 -0800 Jacob Keller wrote:
>>>> +/* Small packed field. Use with bit offsets < 256, buffers < 32B and
>>>> + * unpacked structures < 256B.
>>>> + */
>>>> +struct packed_field_s {
>>>> +	GEN_PACKED_FIELD_MEMBERS(u8);
>>>> +};
>>>> +
>>>> +/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
>>>> + * unpacked structures < 64KB.
>>>> + */
>>>> +struct packed_field_m {
>>>> +	GEN_PACKED_FIELD_MEMBERS(u16);
>>>> +};
>>>
>>> Random thought - would it be more intuitive to use the same size
>>> suffixes as readX() / writeX()? b = byte, w = u16, l = u32, q = 64? 
>>> If you're immediate reaction isn't "of course!" -- ignore me.
>>
>> Its fine with me, but Vladimir was the one to change them from numbers
>> (packed_field_8 to packed_field_s and packed_field_16 to packed_field_m).
> 
> That was to avoid confusion with the numbers in CHECK_PACKED_FIELDS_8(),
> which meant something completely different (array length).
> 
>> @Vladimir, thoughts on using the byte/word suffixes over "small/medium"?
>>
>> I'll work on preparing v10 with the git ignore fix, but will wait a bit
>> before sending to get feedback here.
> 
> If you both think it is more intuitive to have struct packed_field_b,
> packed_field_w etc, then so be it, it's just a name. I'm not too
> attached to the current scheme either, and I do agree that "small" and
> "medium" have burger connotations :(

I opted to go with "packed_field_u8" and "packed_field_u16" since I
believe that makes it obvious these are different from the length of the
array itself.

I'll have v10 out soon!

