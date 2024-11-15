Return-Path: <netdev+bounces-145337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5069CF18D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39CA1F240C6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02318E047;
	Fri, 15 Nov 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6rItfyB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F411D45F2
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688476; cv=fail; b=Uu6mD91bfO2Oy+DhVAgvVpnSClG33nf42Hjb3yrD3D+2BgGbZwUlkjd61YuplxIamaemwqEjHhl16Y4+26gOhXznL2zqM0NS4ao3CKRcdqSwiG9lnsCQalEYVcezjDKa5gPBWb9Gad2HuR6WNdky6yAMxUlwroupkuIybw2oUnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688476; c=relaxed/simple;
	bh=JtwqIeexBXf7bv0RjtExQhJCBn3eE/vfZ+xBa+87T84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a49nloS0g/4wrcfcBv9tL27JI0D0b+qyOlCCBNFLmf4p22gar52SxLHzUr25hdfXLrIg57Yks/2U0yhjGP/Mrk+snRcykdDWBVfIgWa8SzZ7zw4c1s9gvYj+gvPaEyxDFxGrHEYJ6DAzcVZYeoZL8YJ0f3tyFEDHPoFSPI9v04A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6rItfyB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731688474; x=1763224474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JtwqIeexBXf7bv0RjtExQhJCBn3eE/vfZ+xBa+87T84=;
  b=e6rItfyBp7807FRct+L9uEzWghLn/cderN7QBRXauiUCUJrrCM2/tVqi
   ycmuU9Na8SpFnZGLQdd0QjH5DbmyFbD4bYiN99BDrWdMOy4rZAYLmzEYW
   HsN5UKdzpoUm+al2ajmRgHbKT0nogEIMyD2oRnbzWR5ThwCa5ICbE4xU2
   TZmzOzsh18WekpE75enr8WLHJ6rl+X7XLhwgEoY5Y2eZoa58jM0EzItYV
   Sb/0hCFjrWAKHURwVc6gXQbcz6POeozSWQ/bdlMUTqYJwFRokNRwlA29S
   tvZd8mukxdIwooGIKXkci9HbRs8/G38GV2BFfDwOo6Nrq/f+Amq4sD5bm
   A==;
X-CSE-ConnectionGUID: 6C1/DDjKTEeqcD2llYrmbA==
X-CSE-MsgGUID: cRk9miKSTAWcKK7XZJrZ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31086324"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31086324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 08:34:33 -0800
X-CSE-ConnectionGUID: x7CeaxeBQhWUCIdnHi9Gug==
X-CSE-MsgGUID: lMFblB3iS1CO6lC1ZHKadA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="119553785"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 08:34:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 08:34:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 08:34:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 08:34:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz/TzTMP3o4vKwTqxUfGJ/n3fAEdRHE5ZA6l4pWptjDEB58tlGVEn/UdmNgqUd4teVFMKDmKmyrTdxMs+s6oJaxpkRAKEakN1B3ztKtb5QupfOHDTb6IiGZwdjhApU/GGTSKXog+84eXlcoM9mJHnDQB0EZ3jFrWFjJEe3wUXpuz0CmINVOogMa7RwnjHaCnlNH4khG2E2lko77JfC8LFNJs7+whXBRCKL3MK9qDVhupTxQGc46IZXTe57m6FCpuG2CsB/FsoULM3vcZEtDkVyCqdsly7O7yPp0hmenqe8dvgSOa7+yeskcEDKf2vfFo/faua2/62KzVfYhn9yMT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtwqIeexBXf7bv0RjtExQhJCBn3eE/vfZ+xBa+87T84=;
 b=Gmct8Cy/93HFTRJ+gl4fAc8H6LxXLypU5x3u3U+ThE5lAnBMuEMRg8GN36qKpU7ZsnH9i1xyhngJ7SdTd4vP2s8waGyxnk5Xfsnu5VvpoPT1z5Jh/Wu02GtD9w4rsvv9KukyPw9HxKnkQVyP3Hm3zZefu4kmACuBPPx65Ad9z+YA8+mfDbosHK9uiIo7VvK2cR+NuniTjGg+0kzlTPAkMOvfvhV+ZWDqBSSbBX3Gx1oYYq2BozUgzESIlZeXTLctQtXT5B5id/ZkHT5NIcMCmKo5rN9lUNKJP66AWIAv4PxpeFEWW9iOavx4yh0ucpRJaoN/TUOZhq8DeMH8y+Tetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 16:34:29 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 16:34:29 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 04/10] idpf: negotiate PTP
 capabilies and get PTP clock
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 04/10] idpf: negotiate PTP
 capabilies and get PTP clock
Thread-Index: AQHbNeOgACv3vXlTB0GhTL5/ibKtJ7K2snYAgACRSQCAAUg84A==
Date: Fri, 15 Nov 2024 16:34:29 +0000
Message-ID: <MW4PR11MB588900EDB6B3F934A1BCE7FE8E242@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
 <ebf7e086-829e-4266-bef5-b4d746aea45c@linux.dev>
 <6736642260849_3379ce29445@willemb.c.googlers.com.notmuch>
In-Reply-To: <6736642260849_3379ce29445@willemb.c.googlers.com.notmuch>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|SJ0PR11MB5023:EE_
x-ms-office365-filtering-correlation-id: 9a85b0ba-adc7-4451-21a1-08dd05936050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1NMUndqMytkaFZEREZ3VW4zVE1tdHVRSTRnaHhwdzVZdE1LYitCbllnUGV3?=
 =?utf-8?B?TmE1VkdCLzI3ZEN2dWRMY1BGZ2pYWWpUYnBVRUV6UkpRRW5RVDlrQjFMdGhz?=
 =?utf-8?B?MTZGZFJaWURrRXVuQmV0Z2xnbm1GdE9Xbis1OHpOa1NLREYweUYxbXVGbDRh?=
 =?utf-8?B?eC9LWU9UaHpYSXlWM1drRnBvVEQvMUpiQXgvTTlzNmlxRDBpNTd4SFgyMWRT?=
 =?utf-8?B?VFQzaHpRYXJoNytuaFU4ZGJnTG1ueHIwaFJGT3VLa3FlN2V5SVBjMGk1Z1dh?=
 =?utf-8?B?RktJS0NNM2svdEFxWm85RFB6YkZVbUZYbGFYNVViRU1pb3ViQWJUZFAwZ283?=
 =?utf-8?B?dEIvYU9FSmNYbXRKbWZObFRsNjhFdE1HQlBCa0xmRzY4VjRQTmZnYVZoQmph?=
 =?utf-8?B?V0o3TjRJT3pWMExwdkllRkhSMjRDQmhRbjkwbTg0S01JQlVkY2hvVkJtRGg3?=
 =?utf-8?B?bXZobXNCeWk3KytHRTdncENuaFJFUG80RUhqbHNub1hkSmhjNk9hcmFZNWl4?=
 =?utf-8?B?aGlPbVVzUGxOa1A1SVF0WERrN2FwNkkvT29Id2NNUlFRc2JOT1JVNDFzY3JP?=
 =?utf-8?B?RWc5NXNTN3NyRFI3blZvS0R3Z3k1TTNmMzAzMnVlTE95R3dOUmp5dmNVSWp0?=
 =?utf-8?B?R0xlUXRacExnNTVhSWJITko2RktnSEFoRUhVYVlvZzBNVnkrbWV6WVltWmRh?=
 =?utf-8?B?dFRRYzFzbC9Kdm1pY3NodUhDdHBEVVB4YXhGOUlzUElXeDBTSzVTYmI2cW10?=
 =?utf-8?B?NUhNNjBWaTNPU0lEai9ldGlLOWhsNDMvWHRVR29Pb01ONEdCV0I0V1FJTXpq?=
 =?utf-8?B?bnhMcmQrTTdUWTVxNmh3c1BzNHNKMmNZd3NKQnRya1hVeGlPMXVJZEd1MmNC?=
 =?utf-8?B?OFNadEdpYUZ3MXZVaXJiZlZIQnh3cExmdkswcG5qSUFGSzZHMkxBMHlqM1or?=
 =?utf-8?B?VGU4WUpSQWM5RzAwVXcycFFNNzFraDlNUTZkVnd6OGZacEh6NmxNUzF2ZGJF?=
 =?utf-8?B?OVZlaHdwRkt1VVdwbzJtdkZ4RjQzSFRHTldCRFpMWS9nb3hpN2ZnUEltVGNq?=
 =?utf-8?B?NnB4U09LMUhXOXVOQjF3TXIyMVpiNXhGTFpEL043cDBsbUpTb2N5ZVRncVRa?=
 =?utf-8?B?R2toalNKRDNlejdXMzN1aXcxNE43NDl3ZzUwMmgrWGpzU0tIbVZ1dVQ4WkV5?=
 =?utf-8?B?WVhiUnhOTW1XeFgwNVFHZzBUSTNhZzFRRitZMG1HNklsMHBXMTEvRytwY2FD?=
 =?utf-8?B?WkpjNkpPdUZYYVVOeXBnNEZQTFp1WnZweEdvQVpZcFRxaWowVXJJRFgxbFVa?=
 =?utf-8?B?YllIbzI3WkNESktSakJDazdDRzd0NHVkZkVRRytzNHF4TVNLamZ3VWY1Ry96?=
 =?utf-8?B?bU5CcnQrakZDTjd5YkVZQlBwL1RYSGJJckdhN1pUT2lKVTZmVDBJZEtmanBX?=
 =?utf-8?B?Si9jMmhMREJQL3pFZSs5YmxMVGNOWE5meWpqUnpZcWowSVlhc0xmY1RMZ0Zl?=
 =?utf-8?B?UFZKMi9FMEY0OGFuU1JTVkRheiswVHlCTlVTTUdBaXVESVNNcmloUm8zeXQ2?=
 =?utf-8?B?M1JSdXJFSGxuc2VDWVcyRGlrZlFhVzFtU21ZVkEzK1lFQTJPZHVxdFhWSUJv?=
 =?utf-8?B?QWViQ3ZoR25QWFZGVkRkYi9FOWU1R05HaWtVVWZObWxtazZMLzc3a2VoMUlE?=
 =?utf-8?B?TmRYRGs4anBoNmprU1IrR3ByWVQya2FmSjNIZUhCRHBUb3JTUVJCWXp5dFdN?=
 =?utf-8?B?ZnZkTVV4L1VIQ1lXL0ZvZnJHSGVZd1VNcjBSR0p1QjBuTnZucE4vak4rTHVU?=
 =?utf-8?Q?WVCfQ+45BZo5yXAcSabJ5Oh6SBdtIzPwlyxy8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9qTDdzZXZGZ0hGcUxpa0dyVzlFTTYzaXZsSlhFT3YzTWxJZWowd3luMFZm?=
 =?utf-8?B?UGwrMmIrTng1QnhPclVoNWpNbG93NkdSZXlPby9haStpcDJqY3FKWVFxcG5m?=
 =?utf-8?B?UnkwN2k0b3F4Mm5xTEdUYUlhS3lVRmJjT01UanBGblRPTkdxSjVkbHJ2dlVT?=
 =?utf-8?B?SUZaaU5qYnBiVW15NHNSMTN3eWU5Q2dQWHNMMG5VMEcwT1A5OVZ2YXBoaW1t?=
 =?utf-8?B?V3o1dG9qWEZpSnMwNjBEYUQ4MEVUUFA4bWttMWwybkxmUzdPZTFnUHFjdkJR?=
 =?utf-8?B?OCtud1R1amxhM2liU0VqYVlXQW5uZUNiWHlaMm5kMXNOMUwwLzBBWXA0SWdQ?=
 =?utf-8?B?Q081L0N6VHRGV21PNkc1NG5VUEhjaTlGcU41aU9oY2FQYjRsN3o5OHplUTY0?=
 =?utf-8?B?MXBmaWRmcmkwaDhFSjlxeVVmNXFpWTNOam82UlUyeU9obTBBZlVLd3JGeVg2?=
 =?utf-8?B?dlVwNXExUUcxd2xiZm5mNmNtT0MyRWNTL2NNcUU4UWFzNm9HdG5qWWNkTjVE?=
 =?utf-8?B?eXhNQ2l6dEpEdDZYcDhySGpvQ2NDNzJyZy9Nc294YWZtTDNlR09FRlhhbVVQ?=
 =?utf-8?B?TmM2bTg0cENwUVhuS3JMb1A4UTFTWnZMVlJIRzk5QVlLWVAyNWJ2UW5PNGtS?=
 =?utf-8?B?R3lzRjZOUkhuYlhCWVNVUFh0TzNiK203b2dMRnVLdjJ1MnJnVTRKdkxaM3NV?=
 =?utf-8?B?TDJIQkdOejVaN1BkYnh4V1hBY3FRL0JiS29WWE0rRTMrbU0wbDJkeFR1SGlk?=
 =?utf-8?B?OHZ3S0RkYjV0OXBqbTRBRE1QQ3hCVm5sWlFCZ1hnd1VZc3FhaDVCUWZ4Q1JB?=
 =?utf-8?B?am9jVElUd2phUzNQcmloRExha3h5Y1orRTYxZjM5N2orbmorWk5wMm1FYUtB?=
 =?utf-8?B?ZGdva1JwR1lBQkZSZk1iQm40WWZqTitrOGlBdGVEVkN4VG9CODV2THJnUzIx?=
 =?utf-8?B?bDRvZkQ0RUtieWpkbnJEMitsbXdnVm12Vm5SY2xZUVI1eDl0Ui9xWGxRdzJZ?=
 =?utf-8?B?UjlFcGcvdU9lOWE5WmliM2ZBY3RocHZCbTNELzcyczVPUy9GYVZLNlI0Ykdq?=
 =?utf-8?B?alBuTWcwUmEzcXZZZU0zUGVsKzlja0MwVWNKQXRiRDFTaDdZMUFNeWpjR2Ri?=
 =?utf-8?B?dDJYMmo5eTA2ZlE0OTFyR3d4SDV6azg1Z3dJOFloczJER2JpOEhOQ1RmUU53?=
 =?utf-8?B?NnI4QUx5alV4c0k4U0dTQnV6aDM0UmovOXkwb25DbVJsM3gxU3VtQ3ZDd3JO?=
 =?utf-8?B?WVVNME9xLy81TE9MT0xQSWxOOHIrT0JhRWVNb0JxNFlwcUJaUHFteTJiMzZX?=
 =?utf-8?B?OFgxa0tFVGR1T0haSUdrSE5PYkdMMXJZRjcvSWYvRjJ5RmlROXRtaVNJejNh?=
 =?utf-8?B?TURYSTVEMCtlV1BCaVcvNzZYUVhFWTJtV0RsckF5bmNiKzdVY2xCOU14MTE5?=
 =?utf-8?B?ai9mMGQ0cG5iRlpKM1RvTmEwdDF3WjRieUlHL1NxcU1TVXRJSVJ4K01pcFVr?=
 =?utf-8?B?bFBYOER0SGpUT2dBMzZHWlpGYlpYUXlvQ1ArS0ZISDN6R1Jya3g5ZEt6MXg1?=
 =?utf-8?B?QjFhUGlOb01iZmNqRHRxMVNRaE1WVmZxajVXeWhNSW40b003Um42WTFGRzhY?=
 =?utf-8?B?K0t3dWJHb1o2V3BWR2tQVGdCV0JWa1lmOTVuaWhuMzZzS2VTalNRcGpTWTJq?=
 =?utf-8?B?UmE1ZGp6UUFhUlNtNUw4TWkrZThJVTI5czdHd3JzZjVON1AvZzJNZlJyVWQz?=
 =?utf-8?B?d0NhOEl4Zk81QVhoTGdSOGQxaFk3K1FWc3RnZ1FKZmNnRWVsa1dqcnI1Ymlk?=
 =?utf-8?B?UFZ6cnUyWlFodTFHVEpuK01LS0xFZ0szVURhbzVPWkMwa3VzL1R5N3RRVHRz?=
 =?utf-8?B?ZHJQODYyWG5IUEV0cHNaaExhNFV5MCtHZ0hvV3g5cmZaY0pkQWZBWHUvRTBo?=
 =?utf-8?B?cERqY2JDZjNSKzM5N25uRmxIa091ZWEzZDRHR1JvTExiaDVIeFhDQkR1Y2FK?=
 =?utf-8?B?TC9abW8vNEVBUVBvODErcVN3b0kreFd4NzlHZm9rbE5QUlhsZkdFeCtKNGgw?=
 =?utf-8?B?R0pWcDV2S2FZemRvdFNZSVNjUVhKNnRDeWxJamZDaTd1RjRpM1BWZ3hGQ1JT?=
 =?utf-8?Q?vekj2JfJNQ6502t6Ibv2lCk5h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a85b0ba-adc7-4451-21a1-08dd05936050
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 16:34:29.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWHCMpmYUfQ36drY0mjztsHXYNMvkd8TMcDQixifIh4F3NQZOesrox30mlpjbz7yQZ3W0tYYxBNGmKwe/mz0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com

T24gMTEvMTQvMjAyNCA5OjU3IFBNLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KDQo+IFZhZGlt
IEZlZG9yZW5rbyB3cm90ZToNCj4gDQo+ID4gPiArLyoqDQo+ID4gPiArICogaWRwZl9wdHBfcmVh
ZF9zcmNfY2xrX3JlZ19kaXJlY3QgLSBSZWFkIGRpcmVjdGx5IHRoZSBtYWluIHRpbWVyIHZhbHVl
DQo+ID4gPiArICogQGFkYXB0ZXI6IERyaXZlciBzcGVjaWZpYyBwcml2YXRlIHN0cnVjdHVyZQ0K
PiA+ID4gKyAqIEBzdHM6IE9wdGlvbmFsIHBhcmFtZXRlciBmb3IgaG9sZGluZyBhIHBhaXIgb2Yg
c3lzdGVtIHRpbWVzdGFtcHMgZnJvbQ0KPiA+ID4gKyAqCSB0aGUgc3lzdGVtIGNsb2NrLiBXaWxs
IGJlIGlnbm9yZWQgd2hlbiBOVUxMIGlzIGdpdmVuLg0KPiA+ID4gKyAqDQo+ID4gPiArICogUmV0
dXJuOiB0aGUgZGV2aWNlIGNsb2NrIHRpbWUgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4N
Cj4gPiA+ICsgKi8NCj4gPiA+ICtzdGF0aWMgdTY0IGlkcGZfcHRwX3JlYWRfc3JjX2Nsa19yZWdf
ZGlyZWN0KHN0cnVjdCBpZHBmX2FkYXB0ZXIgKmFkYXB0ZXIsDQo+ID4gPiArCQkJCQkgICAgc3Ry
dWN0IHB0cF9zeXN0ZW1fdGltZXN0YW1wICpzdHMpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3Qg
aWRwZl9wdHAgKnB0cCA9IGFkYXB0ZXItPnB0cDsNCj4gPiA+ICsJdTMyIGhpLCBsbzsNCj4gPiA+
ICsNCj4gPiA+ICsJLyogUmVhZCB0aGUgc3lzdGVtIHRpbWVzdGFtcCBwcmUgUEhDIHJlYWQgKi8N
Cj4gPiA+ICsJcHRwX3JlYWRfc3lzdGVtX3ByZXRzKHN0cyk7DQo+ID4gPiArDQo+ID4gPiArCWlk
cGZfcHRwX2VuYWJsZV9zaHRpbWUoYWRhcHRlcik7DQo+ID4gPiArCWxvID0gcmVhZGwocHRwLT5k
ZXZfY2xrX3JlZ3MuZGV2X2Nsa19uc19sKTsNCj4gPiA+ICsNCj4gPiA+ICsJLyogUmVhZCB0aGUg
c3lzdGVtIHRpbWVzdGFtcCBwb3N0IFBIQyByZWFkICovDQo+ID4gPiArCXB0cF9yZWFkX3N5c3Rl
bV9wb3N0dHMoc3RzKTsNCj4gPiA+ICsNCj4gPiA+ICsJaGkgPSByZWFkbChwdHAtPmRldl9jbGtf
cmVncy5kZXZfY2xrX25zX2gpOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gKCh1NjQpaGkgPDwg
MzIpIHwgbG87DQo+ID4gPiArfQ0KPiA+IA0KPiA+IEFtIEkgcmlnaHQgdGhhdCBpZHBmX3B0cF9l
bmFibGVfc2h0aW1lKCkgImZyZWV6ZXMiIHRoZSB0aW1lIGluIGNsaw0KPiA+IHJlZ2lzdGVycyBh
bmQgeW91IGNhbiBiZSBzdXJlIHRoYXQgbm8gY2hhbmdlcyB3aWxsIGhhcHBlbiB3aGlsZSB5b3Ug
YXJlDQo+ID4gZG9pbmcgMiB0cmFuc2FjdGlvbnM/IElmIHllcywgdGhlbiB3aGF0IGRvZXMgdW5m
cmVlemUgaXQ/IE9yIGRvZXMgaXQNCj4gPiBqdXN0IGNvcHkgbmV3IHZhbHVlcyB0byB0aGUgcmVn
aXN0ZXJzIGFuZCB0aGV5IHdpbGwgc3RheSB1bnRpbCB0aGUgbmV4dA0KPiA+IGNvbW1hbmQ/DQo+
IA0KPiBZZXAsIHRoZXNlIGFyZSBzaGFkb3cgcmVnaXN0ZXJzLg0KPiANCj4gSSBndWVzcyB0aGV5
IHJlbWFpbiB1bnRpbCBvdmVyd3JpdHRlbiBvbiB0aGUgbmV4dCBsYXRjaC4NCg0KUmlnaHQsIHRo
ZXNlIGFyZSBzaGFkb3cgcmVnaXN0ZXJzIGFuZCB0aGUgaWRlYSBpcyB0byBsYXRjaCB0aGVzZSB2
YWx1ZXMNCmV4YWN0bHkgYXQgdGhlIHNhbWUgdGltZS4gQXMgV2lsbGVtIG1lbnRpb25lZCwgdGhl
eSByZW1haW4gdW50aWwgdGhlIG5leHQNCmNvbW1hbmQgZXhlYyBpcyBwZXJmb3JtZWQuDQoNClRo
YW5rcywNCk1pbGVuYQ0K

