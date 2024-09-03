Return-Path: <netdev+bounces-124526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A4969DB2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9215F1C212EF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2251AD270;
	Tue,  3 Sep 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IG0U6wPO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FA1C986D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366961; cv=fail; b=UhN3m2vZPYnGPWVc5roI/Cy/5VTr/NO9MKXwqc8HOsSpjfvhBAW7blPiZWt0NZf1KYViXlT1NtJlnWbgYVwFM3PXsSa7QJTuXWWRRBTLJIuZ2qjDJrq2JzxrPM4g1kamKvRCcqW8Xjz3YYxs5x5rJjhsclPHYykrLAdmTRs/OvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366961; c=relaxed/simple;
	bh=BipMep7Fbkd8z+tZSzuK8cVQ/5lkmLf1zuPo5qCnIWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AawyydD5uXnjsEZBn9W5+fyPk2v+L1Ua2HBGO4oO6axHTbU6rEvyGv7nsXkhqb6H3M18TJ1y9QYjVE8JuiRjzyWuvmnA49o0Ec9Vdyq00ygLv7wBEbib3H8HwTUls19lQ0lLDHRgplVji4q2fsvQbVZQGRdh7bry6VwxM/8rSt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IG0U6wPO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725366960; x=1756902960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BipMep7Fbkd8z+tZSzuK8cVQ/5lkmLf1zuPo5qCnIWM=;
  b=IG0U6wPO8i4Kp1xlvQ6S84/i7yLkkKkIkKoqQbXTZzRgQ5/WSF+LCHOj
   4z4p4aTy6ly/AFgAKGbjmhy/6lAV45MvJpRBX05PrWaJAn4y12DH8B+7S
   s8chW/3egEWBTnx0/tbjIIcXCK1+fZ1JlCzoBC3Si6aoQdIHDYTN080Xm
   M+CQbIGLox8jG/Z1my4jHT46yc7WZseLa3rCQEvoz9bj8arlWi0Yl26MC
   vADPKYJ7udD7JQouGdlM2d6X3RzsVCQD+8IrYSy77uOPGa5zWk2KQpjcf
   wKvzhz/s3Yx9ZQKS2xqs5ZwyhFUBEbB8G861wTTCOrgn5l+Wi5V8i+cAQ
   Q==;
X-CSE-ConnectionGUID: pfrOWGUMTu6DM2Lyl9qeJw==
X-CSE-MsgGUID: TRA0mrM3TYKF9OC6+GkVYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24100102"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24100102"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:35:59 -0700
X-CSE-ConnectionGUID: yStOWKt/RXeDvZUdJqrmkQ==
X-CSE-MsgGUID: 9eZDxMaBQXadb+UfgkLZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="88138668"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 05:35:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 05:35:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 05:35:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 05:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdJNRX3qJEfoSElesTksBLHMG5+QmIoNbGUZsR6Xh2a85meJmYtCH4hnpazIiInU3kQTTkcxKwl8hGMeatDwAaV4PpSu5WZYR30y6ZJ8Ue77u73zfwYXNMLRhuSnkCqFeTebFqQf7QQqN1tX07h/MDFzAO5O2Y1TG58nKYj1/EJsyUBC98DhBo6qIp0A4HV8qbGIur8pOyAR6Y3e2Q+83YPO5sQpNbKRURKbI6bKuuuNUxsbIFhVGvhbk/QxZFV3yhgZjra2+ayF15oEEUTEBhcWER4gYRa1indGFCPmz7m28DA+yDksamoK8sgyCp4LddiiHEwwIrHr5JqGow7MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BipMep7Fbkd8z+tZSzuK8cVQ/5lkmLf1zuPo5qCnIWM=;
 b=uhCPGB6bDkucLeTEm3zLAhmx3kSBu8xl+l0ZOwmUWOPTotFKBllC+P+nZOxQfU/canbIT1t6L9fJA9fR1Hs7H4or4ph7quQVvHCxCMfpFL1OaBpBayArs73EPPasrlWIZ0ZvDnaqRfxaeT9ycOZvWK5YZUN3Zf9kOHeeFZh2ANhAbrwdPuKqnq/9PwhudkUpk1EF28308QF+Jnw3T69A4+3gU736IzG2lXPi8sajAzmEyM0yv322hrSib1n7gWXKrJCcY3DefNBrIxleYg7g86m6Dc8gzQ/2Su9VcSZ3cU8Ld9zHCjuENLnGv7mH/oYum8OlnAj38SUj2+3nn5c3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Tue, 3 Sep 2024 12:35:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:35:49 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Nambiar, Amritha"
	<amritha.nambiar@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 0/3] Cleanup intel driver declarations
Thread-Topic: [PATCH net-next 0/3] Cleanup intel driver declarations
Thread-Index: AQHa/fyIuhg8cchOu0ODg3l+UNhZF7JF/y/Q
Date: Tue, 3 Sep 2024 12:35:49 +0000
Message-ID: <DM4PR11MB6117BC51EB846A71BDA8132E82932@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20240903122234.964218-1-yuehaibing@huawei.com>
In-Reply-To: <20240903122234.964218-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|PH0PR11MB5077:EE_
x-ms-office365-filtering-correlation-id: ada896f6-6c73-44bb-765f-08dccc14f0e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ZUtON25ZQU41WTJ0R1hiZUhFVXdaVFdoNnVrQ3diRGFrZHFQS0ZGZmhFZEkr?=
 =?utf-8?B?R1FrYXZTR2RROWpFY041ek9OQkpqbk52bjRHbVlZbHZITDFjM3RaMVlabTNO?=
 =?utf-8?B?QTBETzc5cTUyQm9YZXVjZEJ0VWZSckJ1V0t4VlV3WGNEQmxCOW5ZQTh6TStv?=
 =?utf-8?B?dlQxZVJ4ZHcwaGJydGRza1hpeWVHR3p1OTZRdFNWaFRWRDZyMVh1RU4waTh4?=
 =?utf-8?B?Q0c4L0xrcW5xVkhlN1BYSitSSTIwaUljS1dUeUk5cXY0bGJmbVMvOXJZYmJk?=
 =?utf-8?B?eTNodGQxU1RjbDBTSUNwWm9SN2wxTkpIK2tKdlRjemZPYllhUFloSzZvRGJK?=
 =?utf-8?B?UDRVbW5PNG9zVlp6K2VCNE9LMVoyaTlTY1pUYklNNzdVQnAxOTY2U2VDKzVO?=
 =?utf-8?B?VHYvNjMyaG1jTE1pWlg2UzdSTVhieW5CbVJDLzhhQ3loQk1RclpTZVFrRktO?=
 =?utf-8?B?V2d6SlozTUJlUGtKRDJPVzg4Z3ZTbHhHVW8za1R0K2VJNnhELy9OcXpEd1JK?=
 =?utf-8?B?UmpPZFRMck80czdaWngwQWFXREVxcVlSVGNGSEpicnp5eEluR0lLK3Q0UFFF?=
 =?utf-8?B?Rm5XMVJRYVU5VFN3bFM3YVhuSFFEd25HL094enJHNlA5Ui9aSXRXSDUrYUVG?=
 =?utf-8?B?Y0ZQZVhSa05YakpteFJPdmhDTDBUcjNZUDJLaFNYRUN4TUhJRWE0MU85djZC?=
 =?utf-8?B?Y3k4UEtUUTIvL1FnbUJSYUluWkQwNWlHVFVKSjcxTXVPaWtMZ1BaZDg2TmRO?=
 =?utf-8?B?eTRGc2w4aU5SNlNJaWlpRDZpUlBkZnllbFJ2a21KbjZRUWlSL1ZKRWRBV05I?=
 =?utf-8?B?b3ZLckN4VFZQb0FVa29wWnhKYjRQY1JudG5JUVhCRjhuNVpPb253MEQ0bnhs?=
 =?utf-8?B?TTlxb25HSml3Z2JTNlo1R3c1TkI5d0pzVFUyek43YUlHTCtmSVZKV0trMDZY?=
 =?utf-8?B?S1lsOGtlUkN3cytvWDRVQkVNVzA2TlRSNWRVcUhPQnpGbzNIcnhpTTc5S2Jh?=
 =?utf-8?B?UDNtUU4wMXUvNEdUUG5GekkxTi9GZjlhejlUdjRUQkc2Mit2eTc0bnQ1d0ts?=
 =?utf-8?B?UmZHLzB5UmNqMmQ4OHpuMDN5bTMwTWZLYjh3TDdCTjNJdi9HN1ZJMjlRVk9L?=
 =?utf-8?B?NFlhSytSSkY5K1Q5M1lpcmxzQlRPcmo4SnRYQXRWUDBPbzFETldCVGV0Ujgv?=
 =?utf-8?B?Vk5qVC85ZGo1eENZcEwxK0Z5cnRaT2JrTzE5K3lZR08yQXZTc2krSUNINnEy?=
 =?utf-8?B?bVdoRzJaamJkT2V4cXZPdjFwT2x5SjRYb1NvYVVRTE5UOTBkdW1ub3dTd0Q3?=
 =?utf-8?B?WDNFR2t4V3A1NG9qanFRaWZXSWJ2aXhVMmdreDNLSWRwQWFrUytuWVQ1dXRG?=
 =?utf-8?B?TlgxM2hvU1ZMUkY1Qlp3bHRsM3lyYkxRTjRDWjdiU28zNnhQK213NkpOOEpG?=
 =?utf-8?B?K3JVRUtnUXU5cEtZUUQwZklPODZXQit6OVdJU0Z2cUkwbWRJM0tLZjdUZU5R?=
 =?utf-8?B?NmtvL25hanFwSFY3SGp4QmRaUlYyeXl4dlpwRWRWM0RLTzZDL0FvZDRLRzEy?=
 =?utf-8?B?ZmlGT2N4bWZjVnUwVG4wcGZOMGpVRUpSWTRkOUsyaVg0U2RUNXBpcjY3akVL?=
 =?utf-8?B?TW5GTkF1RTJ5ejNXWG85Q3cwNm50SEVNUHdZOGhDeTRVKzNtSU00ZCt3UytO?=
 =?utf-8?B?ZGVVN2RKM0dqalR4bCtFbkpuSi9Ra0lNUUdvTHRsSkRURC9kazNIN1hGN1hw?=
 =?utf-8?B?U2IxMlYyM0xwU2xoamhpZkZrSEwwbE1yanR2YnN3blFmSEUvbEhINkZXSFk2?=
 =?utf-8?B?TXZ5a2xXNXJuUzVuLy9iOGIydi8xU29UallFeXgxcUVkT21oSFdFa2s3Nzhy?=
 =?utf-8?B?MzcvUmJSNHdnUG5jeWZIN1JNMDlIL0ZFbXorQ1JHdjhrMGl2QUU2K3MySzZU?=
 =?utf-8?Q?TdAIIEzzmJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5kbU9UdzhlQXptUVg1dHlzVGpuOXhCM1huTlBMNGlYWUdmR3Y4QVN2TFJJ?=
 =?utf-8?B?aEFGdUEzQ1VlbGRveVRmZHg3TU14aGZHSXBVQTdWZnkvaUY1aTMrQnJJWjlQ?=
 =?utf-8?B?elJ4dHJ6RFpDdWl6U1FDMFVDTWZLa052ZW1iSE5YMStWSVRpZ3BkR0NvZmN3?=
 =?utf-8?B?RisxRmZrR0xlVG5ERVFmcGtCejFxd3RkbU1vSy9CR1h0N3Y1UmZkQnFlTVlG?=
 =?utf-8?B?R3hoVkFITHplU2FWNStDbk5oVW1MLzFMUlRZUitnaXAwc1BLM1FzZTExa05K?=
 =?utf-8?B?aXkzYU1UNGtkM1V1UlBrWkM3c1puVzVsaWI1Z0xybDZjanJFelVrV3JaYVNQ?=
 =?utf-8?B?cjJsd2lEajMwNHQ3LzBLWUpNRXkwRlNqSi9GU1lGcHVYVTVpSE92QXh1WGFw?=
 =?utf-8?B?UGxTWkloRlpBb21nMjBnaEdPa3picktrVi9ndDhCVTVJV0FMSFRJbGtCWFdE?=
 =?utf-8?B?YkduZkY4UkRBaWhvRjBtTkxzTDVaWHFiSHhaQ1p2K3p3NytiTTRjdE5XTVlE?=
 =?utf-8?B?RmQ1VFRiQjUvc282T2l4NHRMbHNyTFBzT2xVRmJST2dvOFdaMURidTJSbzl5?=
 =?utf-8?B?Y1RuU1BaeWRrWGxyU3ZVUTJWejVsL2JXY1NmMXBUMzdnUVh6VHlqVkIvZHRi?=
 =?utf-8?B?OVdxWkhVeVo1eWNRbTN2SXFMQngrK1lheGdmMUlZbW9ZdVN4Nm5zbmVWLzRR?=
 =?utf-8?B?TkJ2ZTIyUXhxaG5tMlQrMlRIOVhkdGZ3WHVlN1d5c1VuSlZyYUJpMk9RTmZy?=
 =?utf-8?B?bUdlT1YvQzB6NFA2YzRrYlNKOXhQdWQyc3g2WEd1aTUvVVlwa3ZxUHl0YVZL?=
 =?utf-8?B?Y3kwYzZacmcxcUVrdktqbXhVN21vSDk1Kzl6VTZPaDJrZFg1ckhiM1BRaE56?=
 =?utf-8?B?L1JEVVcwRWtQcTFqY1NPelhKMUpSU0pYTVV1d2lQRkRWWC9QZzNhOW1qVXQr?=
 =?utf-8?B?a3EveWpMZ3BQRTBLcUdsUzVHdVFoQlFBelQwVDdpMUt0dE9JRTIzRjMzSE1u?=
 =?utf-8?B?eDFYK1R6ajMzVko0RnUxNzVmUWRVUThhWEkrT2dkQ3VvY0dqVWRDSlpBc05G?=
 =?utf-8?B?d0lnNld0OTFsUzY1Mi8vUkg5bkQ3Qk0zcWp4ZldORlUybDdEcXU0V1dZYktp?=
 =?utf-8?B?WHJHQVY5ckVqUndSWmxWVERTWVJMUjdNV04yVFZXcGtzcUZmMzlzUU8vSXVP?=
 =?utf-8?B?QXZHaGtZV2hyRUJvakhsSEV1NnV0M2w5NitBd2FpZm1XZ3J5TnlGUGVMQVNG?=
 =?utf-8?B?UUVlRFJoZFpXbXp2THM3bERtZUdDaUplQ3FFb3hkRWhoK1RuekxNNG1Genhk?=
 =?utf-8?B?YkhZTFR3c29rcmZTOTVYK0FnMDRuVXZhQmNYdnIwcTJyMzdsaklTN3FVZWpS?=
 =?utf-8?B?S0FvL3ZjSkpyVnFiZ2I1RUVLWFhuN1g2MnZmWnk4V2RFcWFpaW9JK3UxK3JO?=
 =?utf-8?B?djRCTjloN1g1SGhGckswRVkxRVlmYjc3UG53YlFKQjdnUkxLRVozTDlXLzdO?=
 =?utf-8?B?eEZyVjRQQmQxaXdiZWg1OWxKVXcvV3NCY1ZyWCs1TkkxSi9qdFQzMHNtSys4?=
 =?utf-8?B?UldXdGdsK09LZ2doR2YxZ0U0dEtsTTB4aGJHUUM3blNuMkZRMFUzaHJRUWJG?=
 =?utf-8?B?MTZMcVRyUmZTNkViV3oyaHhTeTFtb2FFOUgwY2JTYUhtMnBJOW11aHc3aVRE?=
 =?utf-8?B?UjBybjRqVU05QnRMRlN2OFR3V0NrL2tOTG0rVEVXQk9UV1BWQTVHMGNZbW5z?=
 =?utf-8?B?ZU1obFhHdWtNNWJOWXJBb3hRTUVWLytLS0RBUE1MYzhtRk02czVaVll0aUht?=
 =?utf-8?B?SHRZR25FbmJFbVdDSkFEdGJJNFplcGRBSnpWd05pR3FON0ZCVG1RZW9LWWl1?=
 =?utf-8?B?SXVac2NlRDVMMkxONyt2QWRIYWtsYzdyUFI3Vm1iY2tYd2VxRU5DYUt6Sm00?=
 =?utf-8?B?ajAvR3NlYUVycEVLVDdNRWtKcGViV0ZWS2xQR0p2ZHVha3FCdk8vK1l2dGlB?=
 =?utf-8?B?RThZZGluR2o1QW5zNDY0d0JUOUJNOXVvbVJYUmdXYndhRW9pM3Y1MXNZYmpr?=
 =?utf-8?B?Tm5tbnIwZjVUSmhNRVNkOWhZSWkxb2xTWGo0YXZwTDR1RURGUGpwZUVKVFRX?=
 =?utf-8?B?em43ZTZrWDl4bDJHUDRMUTM4R0RYK1JkNlhyZEswY0d5U1JLMHJiaWc2dEF0?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada896f6-6c73-44bb-765f-08dccc14f0e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 12:35:49.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFLq/yE47uGz0ihvbO9G87/VoP53FClpVIa92gDlS4e9fBG0Ke2C376E2mD6uDQQd8Frm504KJNxIGbcyo681AjznR7U+2LKhc5BSLev5O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

SGkgWXVlLA0KDQpJIGtub3cgdGhlc2UgcGF0Y2hlcyBhcmUgb2J2aW91cyBidXQgb25lIHNlbnRl
bmNlIGluIGNvdmVyIGxldHRlcg0Kd291bGRuJ3QgaHVydCDwn5iKDQoNCkFueXdheXMsIGZvciB0
aGUgY29udGVudDoNClJldmlld2VkLWJ5OiBNYWNpZWogRmlqYWxrb3dza2kgPG1hY2llai5maWph
bGtvd3NraUBpbnRlbC5jb20+DQoNCj4gWXVlIEhhaWJpbmcgKDMpOg0KPiAgIGlhdmY6IFJlbW92
ZSB1bnVzZWQgZGVjbGFyYXRpb25zDQo+ICAgaWdiOiBDbGVhbnVwIHVudXNlZCBkZWNsYXJhdGlv
bnMNCj4gICBpY2U6IENsZWFudXAgdW51c2VkIGRlY2xhcmF0aW9ucw0KPiANCj4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zi5oICAgICAgICAgICB8IDEwIC0tLS0tLS0tLS0N
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl9wcm90b3R5cGUuaCB8ICAz
IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9lc3dpdGNoLmggICAg
IHwgIDUgLS0tLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZmxleF9w
aXBlLmggICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9s
aWIuaCAgICAgICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfcHRwX2h3LmggICAgICB8ICAzIC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV90eHJ4X2xpYi5oICAgIHwgIDEgLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2UxMDAwX21hYy5oICAgICAgIHwgIDEgLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWdiL2UxMDAwX252bS5oICAgICAgIHwgIDEgLQ0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAy
OSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K

