Return-Path: <netdev+bounces-269374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IRQE+q+u2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:16:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89A2C8752
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA9523012205
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F83B3BFA;
	Thu, 19 Mar 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgHAqq6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B73B2FF7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911681; cv=fail; b=llF6Afqa7FRCxLr5x5h0UYUQe255iMVmWlMIp447SfP5ZnPLq0sSH5W6I8sVxNMj0eTdoHmyJwoMYqJesiApPXAiSMuIuZ4egvR8Z3iMh9s/v3of5KFXLU5ioiGTbj6J02aMIax8en6jNV0Xe817mVGxa9TOSwdwJAtEK8MuNTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911681; c=relaxed/simple;
	bh=nJs/ccMqqOv0hVkKvZ/Cn9Yb+0a+YP6do6CI8r6DLv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zy/S2o/7sYEbfII2qwGbH44CepQFLxwrtv5X6UJOXEfDO+W0JtBXZgMiutMB5d2CU83mP+0jhtsGTuDcdlrD6aVjXXMnJK1fAz2H+KoDTLWIKwkv3maToEHKPuseaT/lOCaynniMJYQKY6CX8y9iY+1V+THzE3rtfBgz8TYfWus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgHAqq6Y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911679; x=1805447679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nJs/ccMqqOv0hVkKvZ/Cn9Yb+0a+YP6do6CI8r6DLv8=;
  b=LgHAqq6YcaYpxwBuZbm0BXavDZym6Pk6C6IxYxdmujYv2w1YdtpLSitY
   5WmxUG4ex2cTy7Nwq9C3iiyJURTUb3Vkg9NSUtORfM1ki4uP8pfZrtHUt
   oi5mlbLOtpncUf8qk7ElDYo+BY2CZjDst7dlALCZ7ng4KIH29fYOrJP53
   4cWtm6YUHETCSB4XaYxJ68v3XtiC8NRyaP2GORDQAnvwTV3OQYXWoLWyh
   CFzXzow6uAssHa6NTaK5vIXkelMu3eefC15mMSz3hk1BYNEoBZgM4k1sj
   lXjCe0ZNVe5Hfa8QN5mOWAF1dHcnKR/UsUqlCorDCtVR7LY17LNDP2Xra
   w==;
X-CSE-ConnectionGUID: lwHcxZrFQ5ipqbv4Gfdv6g==
X-CSE-MsgGUID: xr4n5TQIStCPyE00j4Lotg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62547519"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="62547519"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:14:39 -0700
X-CSE-ConnectionGUID: eL1cBb35RzW853SdJBIcNg==
X-CSE-MsgGUID: E5mDSTq2TCiWj1rEsFNWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218832479"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:14:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:14:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:14:38 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li68nZCKb8ICpw6Jwz4ejXx7qU0rt4LTHFI6uqhNo/8i0lqcNmLGoGUUHEp6lgFMEw2F4n6QraMjFtZSz1Z8dYpNA9Ky/TBcCl+duoJ2yQNzZajBiJn0Vt9XZk3I6ZccoZRIzCV+wKCCAVphMNPnWRjyQxSePQG6SHSA3eR7wHFDOvPV6RxmCtuTlWng2vmfgYjK5tlnRtuFL4/ci2AYqgy+XOF1a3Bh4jF3o6u6E1yYYKw/JlE4oWEkuz3V3De61xF3whS7q267AwNsQDt9t6ZV3FLhqYO3Vz9f+FTPWXINd4yGunJ4GZaGZxZtHoVh33dsptQ2+86wXcdAndV5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJs/ccMqqOv0hVkKvZ/Cn9Yb+0a+YP6do6CI8r6DLv8=;
 b=Raryucvgd+EPOZOphDwsa6+m4nekGTiFSirTDmGJVgGSkCAcqhaBlTbnxaqt9eavdakmMugmwwBbzZWaFJ425oYGXbSysOWva1/2XWomPkoIhAUVZnygx0RXa7QYjUHo9JQzFApA8kAWEds8aj7WNkQyA4PjhqLpl9a7AxfpR7SaFQgJ5x2bB6P/KgLuK3aTNkUhoVRig3CJRnboqJRKUp2NnvLQOq7+1gqkjHVufA7zpMV4wjXBYYvAn7ReVC6Jt+aX1asXgihRPtgwKgGEf/QzGoSlxlb+vXpY5SLMSM7/XSMMXfPdWPHiUovOCdU32VRklSU21BOMqdVgvXY+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by LV8PR11MB8680.namprd11.prod.outlook.com (2603:10b6:408:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:14:34 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9723.004; Thu, 19 Mar 2026
 09:14:34 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Kohei Enju <kohei@enjuk.jp>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, Mateusz Palczewski
	<mateusz.palczewski@intel.com>, Witold Fijalkowski
	<witoldx.fijalkowski@intel.com>, Przemyslaw Patynowski
	<przemyslawx.patynowski@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v1 iwl-net] iavf: fix out-of-bounds
 writes in iavf_get_ethtool_stats()
Thread-Topic: [Intel-wired-lan] [PATCH v1 iwl-net] iavf: fix out-of-bounds
 writes in iavf_get_ethtool_stats()
Thread-Index: AQHcneZV5jLfAzA3ukiN8RoPrAuL4rWIHYOAgC2oMEA=
Date: Thu, 19 Mar 2026 09:14:34 +0000
Message-ID: <IA3PR11MB898598FFABE917E56AA2A4A88F4FA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260214191502.267670-1-kohei@enjuk.jp>
 <705e0576-db72-4ea1-b548-b69197bbaf87@molgen.mpg.de>
In-Reply-To: <705e0576-db72-4ea1-b548-b69197bbaf87@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|LV8PR11MB8680:EE_
x-ms-office365-filtering-correlation-id: 2f0ad5b1-d4cf-49ab-a224-08de8597efe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: WRuQv3sLrRflCizqPSY6nlaYHsdfPvH1WcqOAMUYFVQllvLvZnxaAv1KE0xb2jZzHgHWeVe0d+0s0fuTEYMj3ptsdBv9bt0eW0t9T+Z0u6QybZ32THlFMLYI8zNLI7liOJA1pGHb6799PCxYdYK/oW6r/3V/GgzqdIMlMkx09Olxry6R9F8rEZyCbQq3CjTHLok7t8cmxL80AzPU5bZvflp6Emc1VaZr9jeqq6/hMwXPBb/ekV8TALSx1BHBEB/t/TLOfLSjd0sxJSNUlq9aZYZRhUMNFDuLu965b2ijQq2wb2DAs5uopF0ZVN350K91qeG6svhzNX3CPmvooUKX9hzVfOOJIq3oqDWnmImQPEXv7O4PqRYViViZBA3MFYPD0FWEXYywLxD65kIHJclzqoCFxQ7gX4PyQYn6q+TuXJHW3ZLXxru1ZIQC18YTFpg0u/6M644vAyc3UYYQecuBK/l3F1lj9HX+TUaRTfzPQOgde9dd5qJeUQBCO6o91ReaAjOu30TeHK2VnyQ97ngK57nd8/jvY/EN/TTq/hDAn39CoXcC/NyWrG9x+jrCjmw+a7N59/w+5R45OIhf0C2mWUaDlDu/rvOdD6xYdMEuaKEjVU3dRSQ8czzO4yPjQ5k6L8ddEe+rBi9yS/z1HL4z+MtSAulX7F6H8eFYrvMZgOPDlL2EsGKKxyV/ZklYoZtNPe6L4T3r3l2DYvbw09pPQo1Xgi72QuTpDTRHzj1Txr1RA5LwTfGbGvHPgLK9TfJSsibbN8wXFlqQnzCKJa2CjXJykTDIMb1wImcmb2kUX5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09vcUhaRzl4RDErN1hVNFk1eXVCTzZkbkJXbGl3OHA5dE9YVzNtNzU0RWlt?=
 =?utf-8?B?d0dSZkF2MlFqUmhRYk0xam5HbEorS0ZaVm0xdU1PNkpTUWhHWUdHVUVWVyti?=
 =?utf-8?B?bFk1VWJ1VTAvOWZ6RmdENG5Cb2tBU2hiU1puVXU1KzB2TFExcS9GNzlvRE52?=
 =?utf-8?B?WUlVWExHR0pHR3VBNVU4ZHN4VDk3WFJZdkRRenlkVHNlTXgyeGowemtuUkFk?=
 =?utf-8?B?MWN3MExVK1daN01BVUtjY3NEUkFQNDVZdDVlMDgvSzlIbTI0MTBvWHo2bUdQ?=
 =?utf-8?B?aHhxTUpxK2ZhZ3RELzg5UmJOc24yQUh6Vm1qQlpET0JHT3A2SjNwOWc2TVNY?=
 =?utf-8?B?dElrU2VRNTJvbHU4UjUrTXpEKzlNZjRRK215bjBSSWs1Y3B1VXVxdms5cno4?=
 =?utf-8?B?bC9rN3p6U3pqK1VmSzNoTzNPVGhHR0pkUjdBQ2Z4dGZudHV4ZDBUNnpFZHlP?=
 =?utf-8?B?WVJWKy9LTXUrRjdPN3VsQkVURlNwbW5VSW5QSEZLNEEyQ0x0MHMyTmNiaGJt?=
 =?utf-8?B?WE9YajlOdk11OXZNdkMxaFBMSVVYN0dSR2ZuSnFzVXYwLzZlREFlTXNKOVZ2?=
 =?utf-8?B?REpOUnYrRUV5cjdGMWVqTnJ5MjZYVzhObUt3WkNtZW1USldFeDNPY3kyMVdn?=
 =?utf-8?B?ZWdRZGhoSS9McWQ5Rytheis0SFE5S0grZDlQWjNJdmhDR1Q0blpJNFpnR2Zy?=
 =?utf-8?B?YWVxMDBzVHRMVlFOTEJNWXdkRnU1Zzc5dDlsUnViR2orWkNKNTZ1UjBOdHpL?=
 =?utf-8?B?U0ZNdElFc2s2b2FvdGhteXU3WEk0ZmJRaU1KUXRZcFRpR3luSitSUktIOEYz?=
 =?utf-8?B?TWtnbkEwWkZFcWRBWi9DcndJNzB1RHBpejhtaDJOSnpiZExWRmlXZ2VlTTZ3?=
 =?utf-8?B?SjYrLzVnQ01NYUo4VEtjQUd5RXB5RWR3d2ZZdHUzVS9iNmtsa1NyWlBtd3la?=
 =?utf-8?B?a2FUaWhBUUNGbEdVcGVIV1AvZC8zUVhnK1pJOHJiUFF0eUh1QTJFbjk1bksz?=
 =?utf-8?B?a25qdjlDaEpUQUM1RWtpK3FFeUQyazJsRjlibnFlanhOUE5jb3A2ZVlZd0hi?=
 =?utf-8?B?b002RjlZMDR1ZG54YzBtTU0rLzlXVlAyZnNiN0xFazJQdGhpU0YvZjlaZ0tv?=
 =?utf-8?B?TXJJKzgzdG5GdUgxaGZrZTAwWkJUdkliNWs3K3JNMGV5dXY5YmY0VFpJZGlo?=
 =?utf-8?B?T0l0blVQRFU4RUIwL0V6TlRORzJ3R2ZUZHZidjdmeE9TZEtQeHhHSEdqYk5a?=
 =?utf-8?B?eGtmTjdnNWN1ZGlOQnB6MlVQU1oxNlhtUGNDNFFSOVJDQ1A2UjZQenlJNDRM?=
 =?utf-8?B?WUY5R1V2Q2VMU3JBRExFdUZrSm5wQ3JiUkhiQmtXS2pWMXdza2tYelVzRzV4?=
 =?utf-8?B?VlJjR2pXeXFENzkxZ0ljYkIzbnFuVVhod2hzUkQrczd1VlZ2V2ZlS1N0RkFN?=
 =?utf-8?B?VzgzZWhFVWwzNWs2bDdOUFlBaGgrTUMrcTJNU0NucHk4bEpyZWI0SDc5eC9l?=
 =?utf-8?B?QkhuMWlmWFNqRHZkWG9EMTRPZjQ1NE4xRnRPSmJaSVpKWlRRVnBaTFFQdXhR?=
 =?utf-8?B?SklsUXFFeWFFMWZzMVZ4UDRKNWRFakcxRUFleHIzUktJOHhnVTU1OTROWXpU?=
 =?utf-8?B?OHFIVnJwTnhLOXN0Z014UGx5TS9ZdkNQMVRaL2k4alRmTTFMRU5jNFhDZkZ1?=
 =?utf-8?B?TEowTEkyT05WWUp4QUtGRzdKSnNWdkwvRzhITkJkNlRJYnRkcDBPcnd3YjBw?=
 =?utf-8?B?NUFBUTUyaGVnZG9VZVNLUC9xU3ZFOHUyVFFLM2pJZ2xEc1ZXa3lnVGVYV1pQ?=
 =?utf-8?B?N1ZueDlBaDlsRXpMYnNERDdYNWVQWG5FdXdSa0dQY21IY25NR1BoV2NmQUdj?=
 =?utf-8?B?RWxrQVA1ZlhYckNqZ3JwR1RNQlhGOUpsRlkrdndJdXF3NXBBdXMzYk14cVZo?=
 =?utf-8?B?anhSWEp5MW5aMTFCN0VkaEpvUFRkRUdVR2RwMlZGVE1pTXFUMjV6THZucDlv?=
 =?utf-8?B?eTRvSStJUlJuNU5ybDFOL3U0RzdhQkpGS2pFdUVsNmV2OWFCTUFzRXF4NkxF?=
 =?utf-8?B?bXl3SHQ3UFFEcjlIVy9TL0FFT01mbzN4NUJhVVdSbVRKTmhLVU5OUkZrUk00?=
 =?utf-8?B?dVJieTByd3hBM0lVZ09zeVQyd3J1T3kzS0VyeXE1WnEvUzhqOFVGTUlrTzdy?=
 =?utf-8?B?VUd6NXdZenRVLzRXTzhVc3k3Y0pXRnJZYjJuSktiWUtJdndRSnV6VnY3SDIy?=
 =?utf-8?B?UG04ZG9aRUFuRWQ5S0dOMjlqb2lDZkhGTUMvMzltWGN5VHdpN3BDRlVuZTUw?=
 =?utf-8?B?RVNjd1BRcGtoOGtkUjdCTE9UM0xuelJHYlJld2N4MU4wbkhvRzVEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XL8f71VW7Ci7UmFVeCFUXGkrVfpkGAqIVfYM2e8QCYHlHqRIdj6pV4RZWK267UZkIrue+rFXawum2xkIeUbxKS5NvQChibbbK3rHM+KPkpLrJ/38C8PIrIimcAMRp3KOE8lWbTaxBVw9wLxb9s2Y2EQalAPaTxwcAqXR+o8a6/eBenbOVOifxeXWRhZfuf5qqeJqKtznihyJw316XV2LJjrSCbDWENWKPGXhyc70wlL4W+T0zT1SUhGSiJ45ShtVilwRpAFQMq4md7HoCutQHi9MYggpUgahNVsOZ6TErNmNrqz6nC8IMtU4utMcdUALBUco4Y6c2K/mG+MlDN8vYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0ad5b1-d4cf-49ab-a224-08de8597efe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:14:34.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHnWvXTiV92GTg4PkPODLYxxZS0mgLnhHbv7lhfmso3O5+JbfSQN5N0kDBgcai2UrjdYL19rS8J2pGC2NKLLZXGoxwI1Nnu1nmvW86TnCVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.951];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EA89A2C8752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBQYXVsDQo+IE1l
bnplbA0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE4LCAyMDI2IDk6MDEgQU0NCj4gVG86
IEtvaGVpIEVuanUgPGtvaGVpQGVuanVrLmpwPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3Rz
Lm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMDQo+
IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHBy
emVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBs
dW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBE
dW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IEphZ2llbHNraSwg
SmVkcnplaiA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPjsgTWF0ZXVzeg0KPiBQYWxjemV3
c2tpIDxtYXRldXN6LnBhbGN6ZXdza2lAaW50ZWwuY29tPjsgV2l0b2xkIEZpamFsa293c2tpDQo+
IDx3aXRvbGR4LmZpamFsa293c2tpQGludGVsLmNvbT47IFByemVteXNsYXcgUGF0eW5vd3NraQ0K
PiA8cHJ6ZW15c2xhd3gucGF0eW5vd3NraUBpbnRlbC5jb20+OyBrb2hlaS5lbmp1QGdtYWlsLmNv
bQ0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYxIGl3bC1uZXRdIGlh
dmY6IGZpeCBvdXQtb2YtYm91bmRzIHdyaXRlcyBpbg0KPiBpYXZmX2dldF9ldGh0b29sX3N0YXRz
KCkNCj4gDQo+IERlYXIgS29oZWksDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNo
Lg0KPiANCj4gQW0gMTQuMDIuMjYgdW0gMjA6MTQgc2NocmllYiBLb2hlaSBFbmp1Og0KPiA+IGlh
dmYgaW5jb3JyZWN0bHkgdXNlcyByZWFsX251bV90eF9xdWV1ZXMgZm9yIEVUSF9TU19TVEFUUy4g
U2luY2UgdGhlDQo+ID4gdmFsdWUgY291bGQgY2hhbmdlIGluIHJ1bnRpbWUsIHdlIHNob3VsZCB1
c2UgbnVtX3R4X3F1ZXVlcyBpbnN0ZWFkLg0KPiA+DQo+ID4gTW9yZW92ZXIgaWF2Zl9nZXRfZXRo
dG9vbF9zdGF0cygpIHVzZXMgbnVtX2FjdGl2ZV9xdWV1ZXMgd2hpbGUNCj4gPiBpYXZmX2dldF9z
c2V0X2NvdW50KCkgYW5kIGlhdmZfZ2V0X3N0YXRfc3RyaW5ncygpIHVzZQ0KPiA+IHJlYWxfbnVt
X3R4X3F1ZXVlcywgd2hpY2ggdHJpZ2dlcnMgb3V0LW9mLWJvdW5kcyB3cml0ZXMgd2hlbiB3ZSBk
bw0KPiA+ICJldGh0b29sIC1MIiBhbmQgImV0aHRvb2wgLVMiIHNpbXVsdGFuZW91c2x5IFsxXS4N
Cj4gPg0KPiA+IEZvciBleGFtcGxlIHdoZW4gd2UgY2hhbmdlIGNoYW5uZWxzIGZyb20gMSB0byA4
LCBUaHJlYWQgMyBjb3VsZCBiZQ0KPiA+IHNjaGVkdWxlZCBiZWZvcmUgVGhyZWFkIDIsIGFuZCBv
dXQtb2YtYm91bmRzIHdyaXRlcyBjb3VsZCBiZSB0cmlnZ2VyZWQNCj4gPiBpbiBUaHJlYWQgMzoN
Cj4gPg0KPiA+IFRocmVhZCAxIChldGh0b29sIC1MKSAgICAgICBUaHJlYWQgMiAod29yaykgICAg
ICAgIFRocmVhZCAzIChldGh0b29sIC1TKQ0KPiA+IGlhdmZfc2V0X2NoYW5uZWxzKCkNCj4gPiAu
Li4NCj4gPiBpYXZmX2FsbG9jX3F1ZXVlcygpDQo+ID4gLT4gbnVtX2FjdGl2ZV9xdWV1ZXMgPSA4
DQo+ID4gaWF2Zl9zY2hlZHVsZV9maW5pc2hfY29uZmlnKCkNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWF2Zl9nZXRfc3NldF9jb3VudCgp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlYWxfbnVtX3R4X3F1ZXVlczogMQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtPiBidWZmZXIgZm9yIDEgcXVldWUNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWF2Zl9nZXRfZXRo
dG9vbF9zdGF0cygpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG51bV9hY3RpdmVfcXVldWVzOiA4DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0+IG91dC1vZi1ib3VuZHMhDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpYXZmX2ZpbmlzaF9jb25maWcoKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gcmVhbF9udW1fdHhfcXVldWVzID0gOA0KPiA+
DQo+ID4gVXNlIGltbXV0YWJsZSBudW1fdHhfcXVldWVzIGluIGFsbCByZWxhdGVkIGZ1bmN0aW9u
cyB0byBhdm9pZCB0aGUgaXNzdWUuDQo+ID4NCj4gPiBbMV0NCj4gPiAgIEJVRzogS0FTQU46IHZt
YWxsb2Mtb3V0LW9mLWJvdW5kcyBpbg0KPiBpYXZmX2FkZF9vbmVfZXRodG9vbF9zdGF0KzB4MjAw
LzB4MjcwDQo+ID4gICBXcml0ZSBvZiBzaXplIDggYXQgYWRkciBmZmZmYzkwMDAzMWM5MDgwIGJ5
IHRhc2sgZXRodG9vbC81ODAwDQo+ID4NCj4gPiAgIENQVTogMSBVSUQ6IDAgUElEOiA1ODAwIENv
bW06IGV0aHRvb2wgTm90IHRhaW50ZWQgNi4xOS4wLWVuanVrLTA4NDAzLQ0KPiBnODEzN2UzZGI3
ZjFjICMyNDEgUFJFRU1QVChmdWxsKQ0KPiA+ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFy
ZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMS4xNi4zLWRlYmlhbi0NCj4gMS4xNi4zLTIg
MDQvMDEvMjAxNA0KPiA+ICAgQ2FsbCBUcmFjZToNCj4gPiAgICA8VEFTSz4NCj4gPiAgICBkdW1w
X3N0YWNrX2x2bCsweDZmLzB4YjANCj4gPiAgICBwcmludF9yZXBvcnQrMHgxNzAvMHg0ZjMNCj4g
PiAgICBrYXNhbl9yZXBvcnQrMHhlMS8weDE4MA0KPiA+ICAgIGlhdmZfYWRkX29uZV9ldGh0b29s
X3N0YXQrMHgyMDAvMHgyNzANCj4gPiAgICBpYXZmX2dldF9ldGh0b29sX3N0YXRzKzB4MTRjLzB4
MmUwDQo+ID4gICAgX19kZXZfZXRodG9vbCsweDNkMGMvMHg1ODMwDQo+ID4gICAgZGV2X2V0aHRv
b2wrMHgxMmQvMHgyNzANCj4gPiAgICBkZXZfaW9jdGwrMHg1M2MvMHhlMzANCj4gPiAgICBzb2Nr
X2RvX2lvY3RsKzB4MWE5LzB4MjcwDQo+ID4gICAgc29ja19pb2N0bCsweDNkNC8weDVlMA0KPiA+
ICAgIF9feDY0X3N5c19pb2N0bCsweDEzNy8weDFjMA0KPiA+ICAgIGRvX3N5c2NhbGxfNjQrMHhm
My8weDY5MA0KPiA+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YN
Cj4gPiAgIFJJUDogMDAzMzoweDdmN2RhMGU2ZTM2ZA0KPiA+ICAgLi4uDQo+ID4gICAgPC9UQVNL
Pg0KPiA+DQo+ID4gICBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIGEgMS1wYWdlIHZtYWxs
b2MgcmVnaW9uIHN0YXJ0aW5nIGF0DQo+IDB4ZmZmZmM5MDAwMzFjOTAwMCBhbGxvY2F0ZWQgYXQg
X19kZXZfZXRodG9vbCsweDNjYzkvMHg1ODMwDQo+ID4gICBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxv
bmdzIHRvIHRoZSBwaHlzaWNhbCBwYWdlOiBwYWdlOiByZWZjb3VudDoxIG1hcGNvdW50OjANCj4g
bWFwcGluZzowMDAwMDAwMDAwMDAwMDAwDQo+ID4gICBpbmRleDoweGZmZmY4ODgxM2EwMTNkZTAg
cGZuOjB4MTNhMDEzDQo+ID4gICBmbGFnczogMHgyMDAwMDAwMDAwMDAwMDAobm9kZT0wfHpvbmU9
MikNCj4gPiAgIHJhdzogMDIwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIGRlYWQwMDAw
MDAwMDAxMjINCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiA+ICAgcmF3OiBmZmZmODg4MTNhMDEzZGUw
IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDFmZmZmZmZmZg0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4gICBwYWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZA0KPiA+
DQo+ID4gICBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOg0KPiA+ICAgIGZm
ZmZjOTAwMDMxYzhmODA6IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4
IGY4IGY4DQo+ID4gICAgZmZmZmM5MDAwMzFjOTAwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gPiAgID5mZmZmYzkwMDAzMWM5MDgwOiBmOCBmOCBm
OCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgIF4NCj4gPiAgICBmZmZmYzkwMDAzMWM5MTAwOiBmOCBmOCBmOCBmOCBmOCBmOCBm
OCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOCBmOA0KPiA+ICAgIGZmZmZjOTAwMDMxYzkxODA6IGY4
IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4IGY4DQo+ID4NCj4gPiBG
aXhlczogNjQ0MzBmNzBiYTZmICgiaWF2ZjogRml4IGRpc3BsYXlpbmcgcXVldWUgc3RhdGlzdGlj
cyBzaG93biBieQ0KPiA+IGV0aHRvb2wiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEtvaGVpIEVuanUg
PGtvaGVpQGVuanVrLmpwPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL25ldC9ldGhlcm5ldC9pbnRlbC9p
YXZmL2lhdmZfZXRodG9vbC5jICAgIHwgMzEgKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9ldGh0b29s
LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9ldGh0b29sLmMN
Cj4gPiBpbmRleCA2ZmYzODQyYTFmZjEuLjk4YmVjM2FmYzIwMCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfZXRodG9vbC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aHRvb2wuYw0KPiA+IEBAIC0z
MTMsMTQgKzMxMywxMyBAQCBzdGF0aWMgaW50IGlhdmZfZ2V0X3NzZXRfY291bnQoc3RydWN0IG5l
dF9kZXZpY2UNCg0KDQpUZXN0ZWQtYnk6IFJhZmFsIFJvbWFub3dza2kgPHJhZmFsLnJvbWFub3dz
a2lAaW50ZWwuY29tPg0KDQo=

