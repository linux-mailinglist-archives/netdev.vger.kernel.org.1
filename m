Return-Path: <netdev+bounces-140774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701669B7FD4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306B1281E80
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CA1BC9FB;
	Thu, 31 Oct 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKs2nmW8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032C1BC062
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391499; cv=fail; b=fd/u3BMhvSSASkumwi17DRf90xv+rC9Qo4mIFU9ujJqg/xdlg8jxO7Yx4NWSCs1Rn0ZPOM0OAQ+zwQo9fcCDSFP+8p7ARKlBGbmSJfXj0pj09YamtnKD6anNwGugGw+ItrL9GDa8oOwsMnYBJQ8xBJOPAU5o2UkZ1XVa0pDFQug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391499; c=relaxed/simple;
	bh=vkVyM4OUbh9jq8sFgLBTFVqUjSQjij7fKBMflGiH3JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r30QKB/hVbCWEkKsXQ+6GwsRbYHcYElTwYItfHOxQuhyZe0x7ocd3GuzdPhTAvccaQGWk+mSq+MilFpC8y9yiT4AX5rb4lPuMXBFeKKPkk7VyCNzH5WyoFzsRWEvZl5kX8VAHJW9wfObJyu+T+vsl51UZwjEnbVaQ7AS2VFw/4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKs2nmW8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730391497; x=1761927497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vkVyM4OUbh9jq8sFgLBTFVqUjSQjij7fKBMflGiH3JM=;
  b=fKs2nmW8t5g9KsncWXHDZy/GoIdUiKyWVKvm2MzAaHJLsPs6oN66zyF6
   HyH25sImdqZtIRQn/hzLkFFxqVCE+RPUqaUoEJoO/e87vfGKOWJkYeK6S
   xSDvw5B3O30dM+jUK7pj0Fw8U9fBHNN74SbzkF620Ppk5ycxATeLfgbCz
   cAw+paxUDHicRO9RTDdHz+elQNgdn5lEvYJO6U9mpj73XOtUiNd0HIArx
   XsncLICW5GuRFr/ZFMv96H4ojxOwf3JRfmrFQkJjtPBMXNV7G1IZU5zOV
   /VTzLyy2ffXhMAsF+z7TBFuP33eIf8eHVG39PTOl/IaaMW7jh08+1tcCq
   g==;
X-CSE-ConnectionGUID: udXECtrrQl6rdRmVpS9FLw==
X-CSE-MsgGUID: uTGkv+SATk6EHxkyyNMscA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="55536471"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="55536471"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:18:16 -0700
X-CSE-ConnectionGUID: C0i9WVYNRQePuf1VMrrWDw==
X-CSE-MsgGUID: mUlq5pTNSdeisolrta8F2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82597134"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 09:18:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 09:18:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 09:18:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 09:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0AJXroebC7q7tps9DDZXlskz/H3YumJJSoWM0ozNs9ew/2jDCzEW6wD2NFxos2NvcSCsvLdh2CYXXey96YpyDaL1+OD/DjM4dPNocfxw6Xx/qmhT11y1+0zO8rsgXGi++66dCxXFrkhnaNUMH4yAAxY4H6cu8/72KpHyZ8BpD8MUnN1AEBrjM/g3bH/R6R5lmbEt0Ib/nBGFI82muj8JVHB7FX+iddEgHvX+xB6DZEqVaP2UjztALQs6ek4yGA+NJZxHvtf6j3ukChRacVRT9YFgk7JPq3vgkabdJrHQjU9gjrBuMuHKn7fVIyZ8gdMBZvnmPHz45bb7azbBZMy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkVyM4OUbh9jq8sFgLBTFVqUjSQjij7fKBMflGiH3JM=;
 b=LV0Ya97yt+XoZacRSmUzpKpBKGW8mn83diDZqZM79LoVvxpGdPzTyumN9j6/nSxEIDIEDiNlT2Ed1hw+39K94k55MKPkhD1oUPnO95bYnbOX7fn0GgZz4Z6sjZY3jN5MREt3Ng5EanpRFqbQlZaTWACU1YGYj25oqen3qmyMVCoimCDRUb8wO6Tprh43Ud6L+nzdrklWJvjTkdD61AdJoPe0rf+foCopiJG59HTIk1UpYtXL1mFPCOVtgXM0fByFqe4+ejtGs0cAobD+G2mc9u8/dE5c5d4sdRgP6qJ2rjHXk7R4PTPpvLPAmVtIB6YuhHsGmXOY7ug552RDv6DUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 16:18:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 16:18:11 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Guo, Junfeng" <junfeng.guo@intel.com>, "Nguyen, Anthony L"
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
Thread-Index: AQHa7c+UfNCuNBrL9kyTYeOz7YUQLrKgd3CAgAB8doCAAJEoYA==
Date: Thu, 31 Oct 2024 16:18:11 +0000
Message-ID: <CO1PR11MB5089AFECEC0354C0B38BEF2BD6552@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
 <20240813222249.3708070-12-anthony.l.nguyen@intel.com>
 <506acb47-a273-4b57-8dee-2d231337ff48@intel.com>
 <BL3PR11MB64822BAEBF130476C4F6C9E3E7552@BL3PR11MB6482.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB64822BAEBF130476C4F6C9E3E7552@BL3PR11MB6482.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8424:EE_
x-ms-office365-filtering-correlation-id: bf0476c9-2537-4c86-1e83-08dcf9c79d45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?RGNoUXlXaThVVlFjMDJJNVFsQjVRbzhJNU8wRmE5TlBXZEhhU256QzRiTzUy?=
 =?utf-8?B?eEpmbUxQTXNSdUZBaVlYS0ZNV0xpN1hhYUdnbG50MUw3MU1QKzA0R05UWVUw?=
 =?utf-8?B?eitDcHdhcmxiZVVyYmk1Sm1nbnMzRTlOZFU3bnE4cDJOK0VGR2xXdURlOXhH?=
 =?utf-8?B?NHJPNEQySXZ6VUlqOG9XSElHcEZxeUJhM3k4ZWxVVXBVaUlCa0FoekV2b3JE?=
 =?utf-8?B?QjcyeDVVdm9MMERqVStBSEdEVmhtcWJWNFBKRFNEbEJSdTh5YVBvZmZGQ2tm?=
 =?utf-8?B?em0yYjdJYkNTdnpORjFSaDcvOTBzYndpT09kTVkvaHZQMkJ3dTBtZFI1TzBr?=
 =?utf-8?B?UzVCUkpQK01DMHZ3NERrd0ZVRDNZdVFwNmx1bEdJalQwcDJnd01mYmloakhw?=
 =?utf-8?B?NUJGUHFYcEZ2S0xSK2gxWWZwb0VyMEdIQUpFbmxQakF4SDdJUEk4TjdtdmJ6?=
 =?utf-8?B?bm9CYU1EdndwNC9yMDA4VCt2bWxCZ05xS1pMZ2RTL21halpnK0ZOakpOd3Zr?=
 =?utf-8?B?UTR0RzdhaTJRbWRHVWFUN3haVDNHTGlzcDNFbEJFVldMWWltakpab0hyRUZk?=
 =?utf-8?B?MVdpZ3pnUDVxN2kwWkpKQ0RYdEtKK3VTejRXeENCZm0rK1lHQThzN1FzTU82?=
 =?utf-8?B?bEd1OXA1TEl4Tm9lRm0yMFBOMXhUK2EzcERtbFdBWHM3aVdLbThvb1NBN1FF?=
 =?utf-8?B?NE1nVytGU0ZuKzVqY0lwbVV5YmY2NVlxZ3I5YW5XeGNHN3lzOWFOVHU5ck9I?=
 =?utf-8?B?TlNnWkQvTGc2TTlSSVZTeTYwbE5CTVVqc0ZrRzFuUzF3YXYvZnhGTzNZSmM0?=
 =?utf-8?B?TkYxR00zOEtDaVZQNlgwTnFWOXliOStFOGVTNGlWaHNYY3BwYncrbHU0TDh2?=
 =?utf-8?B?czlMRjJqcG1oVCs5MVl0N2FMcGJsUXlQMjFYWTk0UHhhMHVELzV5V1M1R3B0?=
 =?utf-8?B?UEY3N1J3T1VHbW1vYm4rSkd0V0ZkeVJlVlN1a1dacEk4MGgxUlpMZEdQdytu?=
 =?utf-8?B?eVFLK0RhYk5rZUJiTzM5NC9hWkVUekZtTm1QMWZtVzhhRXhLaTZ3cUdGdTRT?=
 =?utf-8?B?anppNTkycmNnYmN0NExLYnR3SG4rTFhEZDN1NmcxYmx6QU5saEZsRkZlbldn?=
 =?utf-8?B?YUpGQzFVZnNWcEZDSERGaEF4ZFIxeU56OVBodHBCbEJ5bnZWWWJPNWZkUXJL?=
 =?utf-8?B?UWk1TW5OaHZ1aWlCSnd6bXhuMGZSNnJiak1sYlliWDE4QXB5eUpTN3RYZUQ4?=
 =?utf-8?B?bDNvbWo5OHdBUGxjRFB3elpaYWFhS2M5ejBYTWRRQnFFKzkxdVhjQ3ZreS9U?=
 =?utf-8?B?VVplS2R3OXFya0MxUGhPM3hFUHdwV0hyeXBuZHlZQ25XTE9SU0JvZ3ByUi9K?=
 =?utf-8?B?OUdtN0J3VFhyVmZYM2YreEZkWld6UG8yRHBNR1I0ZGtSMElBeDRpSFlIMWFr?=
 =?utf-8?B?V05xTHJJZmxmMXhubVdmV1FUejBuK0xzZGRsellmYVRBSEJqTzA4aHdxeWxU?=
 =?utf-8?B?dEtxNjhFZXU5aHJtVXR6ZFRvOG5wcWpPUUZRYzlJeG1XNXRNZFJNSDJUZW4w?=
 =?utf-8?B?NXl2Q2tQeWc5dDBYVWlLTWJQcUpJZlVQM1R4N3p3Mzhhc3IzZ0VFODduandu?=
 =?utf-8?B?TmZSRVg3c2MwMkIvWEJsVGo4TzV2MzczVG5MV1NVY2N6Smx4WFZWTS9pcnh4?=
 =?utf-8?B?QWJjSGJ2MkFIMFkxam5keUNIWno1MW52dnE0Z0VQWUVlL1JyRXNEYkpuRm91?=
 =?utf-8?B?aTFXRi9ZUldhUG5zYU1nQlVJaDZWTmRTNmI4MGdjdWcrd1NCU2s4Tm5FdnBp?=
 =?utf-8?B?VUdlRTMwanV5eFgrYU5IMFI5emdRU3RscDUyTWlZN1ljZ0xRUTNEdjE0UUJu?=
 =?utf-8?Q?lkYqwurTdzcQg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVA2OVgxdXVQZEVBajZ0SGl2ZXZ1NlllV3dyVG0rY1lYU3h0UjFkUERhUHpz?=
 =?utf-8?B?ekFhVW9vT2pPZWRBU2tOSXRuTmFzMFBab3RrTGxvbmxJUnl0Y2RwN2tZNWsv?=
 =?utf-8?B?bHRiQjllYVc2V21CQ1ZXMjJzWlZUOWlrZG1tejROalBHUEoxMEkvRmw4eFhN?=
 =?utf-8?B?MFQ4Q0NuUFFtd1lIcWNhOSs2WVRVMDZsRitNVW5GWEdPQlN1QU1PU2VxWm5s?=
 =?utf-8?B?Mi9EbW5panFHN1pRS1pkL3dZQjAwcjFwc0dDZDFabXNhL3Y4eVc2ZGxncEdt?=
 =?utf-8?B?QThQRThlL3FVbmtEbEZ6QkRiSlViRDY3TUZvQTA5dENMTSt6Q1JZenpJaWZk?=
 =?utf-8?B?c0VNMmk1NXZDZnF5TTVRYjJkanFmN0wwV1lUWU5FOXBzb1gza3M2MDdhdDMy?=
 =?utf-8?B?ckd5QXNLUjlvMjhGcXJLY3R4SXFQMTFBTVVhNDM5M0xOdzVKTXJDZ0JPcDZB?=
 =?utf-8?B?b2Q1VEFkZ0FPTjVEZG9wdlU0WGVsSWRqYzdNRVNaV3lJZzA5UERYWWZMZGtC?=
 =?utf-8?B?ajVEWGZMczh5ZTV5bnBsYjJLdXpjOEtsTGFpUk8vdHE1QktiQ3UyRzVPSmlL?=
 =?utf-8?B?b2NnRkV6TmRKNUNudUh5WUpxZEx4bHZ2Z0w0RjlKWko1Wk5sVVR2U1dqUTJF?=
 =?utf-8?B?Rjg2MlNhSlBuQ0l3dEtDa1ErVmpmWmxlNkxQYWxjdEo5ditWV1JieitBaFNI?=
 =?utf-8?B?THMzTUlEQzNvSEpkcGdFRkpnNFhYeXdXOWpWTWJkWkVacktZa2dPczl0M05t?=
 =?utf-8?B?QTQ3ZHdnQ1Y2aFFkOUgzQ3JuVnVBcUlrcTJBelFkVUZxenNydGkyNHlkNlFN?=
 =?utf-8?B?R3hWMDRiS2NEUlMrQ1NWR3A1NFNPUzlBd0Uxb281c1pwZ3RsVUovdjJkMUJN?=
 =?utf-8?B?L29RM2VMeGk4WWVzR3Rvb1ZIMHl4bDEzd0VHVFhNTXFjazRON2xZVWo0R3J4?=
 =?utf-8?B?MUVZMU1iejMrMHM2TVFEc0NDU0VoRWV3VnZISkM4Zm9ZbllqODJYRytzVE5G?=
 =?utf-8?B?UWVjbmVOdGNzeTdPZk96ZUoxdzE0Si9sTHQyUFdOUk9weFU1SDR6ckRtOHRQ?=
 =?utf-8?B?VjNqcUkrcE03WE92a2p5N214SzZ4MjFvSFJWSXNLcUxCZGdGZkJUVmRINVln?=
 =?utf-8?B?UEFBUGpBMzF3QUF6ZWk1Ykl0a1c4SnZNWnM0dWFwR2VKN1FpUEE4ZldreGdU?=
 =?utf-8?B?TEZEK3dvd0dMU2g1WmtTYkdvcW5pSnR5UFAwY0d1UXErN09wL1AvYnpGZ2JQ?=
 =?utf-8?B?SHdLZ25VK1ZIT2x3ZnBwL1FyZ3R1ZnZXcjRqZWJjRjJLQm05UUYyOVNKZjdI?=
 =?utf-8?B?L3NLTlloc2s2RExTaGJDWXlMSS9nbG1HUW4zMGFFU2JhYkRpaUE4SlF5MlU4?=
 =?utf-8?B?dTFDQUszRk0yYWRGbnJPZXRJZ1A5cGVyUXVPSytORWtYcFI5RzNZV3hwVWdi?=
 =?utf-8?B?MlZCVUJkQUtlTGcwaGdqc3hrbis4K1VVY0R1YjNSdEFRVjJSVlBncVloczla?=
 =?utf-8?B?NTNyQUswRG8ybmhOYlNGZSt1ejVhMTlEbUVQQ3lWSTlUUU5FM0c0ME5LYlVr?=
 =?utf-8?B?TElpWmdLY3JEb3JMWENoU09YTk40MEs1QkpZMkxTem04dG1oM0lPdlFpMEEx?=
 =?utf-8?B?R1RBT0VVVmdPN3hyLzB0d2ZhT1QvZGowRFJnOWJTcDNaZEs0N29SQ0FXWmFR?=
 =?utf-8?B?RHdLTktPUklETEk3OExGSEhSdmhLTFM2UHB5UkRFS1hvVmsyV3IvNElvOTFo?=
 =?utf-8?B?Q292M3Y3bmFncFpDVlV5UzJ2djdtdXJ5R21LRE02YVF0TkVPYlBJYjJwcXFW?=
 =?utf-8?B?eE95THc2Q3pwbGgveGkzcjVMNWk0dlhLdWFQdTd0STc0ZFFsMWNvZW9GN3o0?=
 =?utf-8?B?cnhnOTZtaWRxYzM4SHp0TThQaVowZk5YNGR2N0VxbjJLK094dUpoOHEycWE5?=
 =?utf-8?B?bVJTc2JLb0NNUTNiVGI1THI3YWIwVklRam9uSGNYaWgwd0QxaHBoMDBZMk1U?=
 =?utf-8?B?elBqNmhzcHlRQzVTMWxRcHVVOThRVCswbmRzRW5ZazY4RzBWQkpJU1kvK3Uy?=
 =?utf-8?B?SGsvcWcwemwvWHRQWC9TTnBEMVlEYmJtb3JtNFZYNEhNQ1dMU3lZMDlhc0t3?=
 =?utf-8?Q?v9tHdxQzRiRkuQwmyPYD1xJno?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0476c9-2537-4c86-1e83-08dcf9c79d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 16:18:11.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to2SYQqeplZ77f3u4XAxGVQOw6HIE1jPeNJbAIvJgaJNOwwhGgly/6T0mD8QPY7Bfa3YOZMH8UlcAtCb7fluuv8pjxT3iOGo2XZpSEj+fFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvLCBKdW5mZW5nIDxq
dW5mZW5nLmd1b0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDMxLCAyMDI0
IDEyOjM4IEFNDQo+IFRvOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207
IGVkdW1hemV0QGdvb2dsZS5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFpha2ksDQo+IEFo
bWVkIDxhaG1lZC56YWtpQGludGVsLmNvbT47IENoaXR0aW0sIE1hZGh1IDxtYWRodS5jaGl0dGlt
QGludGVsLmNvbT4NCj4gQ2M6IGhvcm1zQGtlcm5lbC5vcmc7IGhrZWxhbUBtYXJ2ZWxsLmNvbTsg
TWFyY2luIFN6eWNpaw0KPiA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+OyBSb21hbm93
c2tpLCBSYWZhbA0KPiA8cmFmYWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggbmV0LW5leHQgdjIgMTEvMTNdIGljZTogZW5hYmxlIEZESVIgZmlsdGVycyBmcm9t
IHJhdyBiaW5hcnkNCj4gcGF0dGVybnMgZm9yIFZGcw0KPiANCj4gSGkgSmFrZSwNCj4gDQo+IFRo
YW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQgd2l0aCB5b3VyIGNhcmVmdWxseSByZXZpZXchDQo+
IA0KPiBBbmQgeWVzLCB5b3UgYXJlIGNvcnJlY3QuDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBm
ZGlyX3Byb2ZfaW5mbyBhcyBhIHRhYmxlIG1heSB3YXN0ZSBhIGxvdCBvZiBtZW1vcnkuDQo+IEl0
IHdvdWxkIGJlIGJldHRlciB0byB1c2UgYSBsaW5rZWQgbGlzdCBpbnN0ZWFkIHRvIHNhdmUgbWVt
b3J5Lg0KPiBBbmQgdGhlIGxvZ2ljIG9mIHN0b3JlL2ZpbmQvZGVsZXRlIHByb2ZpbGUgaW5mbyBz
aG91bGQgYmUgbW9kaWZpZWQgYWNjb3JkaW5nbHkuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCBJJ20g
bm90IGFibGUgdG8gd29ya2luZyBvbiB0aGUgaW1wcm92ZW1lbnQgbm93LiA6ICgNCj4gSGkgQENo
aXR0aW0sIE1hZGh1IGFuZCBAWmFraSwgQWhtZWQsIGNvdWxkIHlvdSBoZWxwIGNvbnNpZGVyIGFi
b3V0IGhvdyB0bw0KPiBpbXByb3ZlIHRoZSBjb2RlPw0KPiBUaGFua3MgYSBsb3QhDQo+IA0KPiBS
ZWdhcmRzLA0KPiBKdW5mZW5nDQoNCkkgbWF5IHRha2UgYSBjcmFjayBhdCBjb252ZXJ0aW5nIHRo
aXMgdG8gYW4geGFycmF5LCBzaW5jZSBpdHMgYWxyZWFkeSBhIG5vcm1hbCBDIGFycmF5LCB0aGUg
dHJhbnNpdGlvbiBtaWdodCBiZSBlYXNpZXIgdGhhbiBkb2luZyBpdCB2aWEgbGlua2VkIGxpc3Qu
IFhhcnJheSBoYXMgbmljZSBwcm9wZXJ0aWVzIGZvciByYW5kb20gYWNjZXNzLg0KDQpUaGFua3Ms
DQpKYWtlDQo=

