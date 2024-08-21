Return-Path: <netdev+bounces-120428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A320959484
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00195281ECD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6115FA92;
	Wed, 21 Aug 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKueDY92"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53B1C6B5
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221449; cv=fail; b=uu7I8cCNjJ5RbbkrPSa5jPi1dGGD37g1xWEB1V7LhQmsfIGCjjmZ7N38F1s4RMNaiDP4H4qMmH8DkFfuThWAUnd/HknkoojPMfMqWnbwrKnjVZR4PNI6g8okL+bIFRHqCggGsTdnm3tupxGYCeKt93wc8FX7nfYZ7ukZ3g1jnlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221449; c=relaxed/simple;
	bh=1kbZMpRrw4DEmLCuXMLAPhXrOYZZtp/eb/CHUuILuWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7K7AqjJkarbW9WULfv2h/E8HjJjDsRTdlXKDLtINWbqN89t7K5NxWhE1vW3kSRQa5g1SObc4iyJV1HrGNqnUGBw/xz48MzI6VL5Hw5GbyHIKrCod0iSdFEX/JYodvKZueWtfw8iTDyP6hLjbmMrx4K6GxjahCu2/BLgqsvJUNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKueDY92; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724221448; x=1755757448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1kbZMpRrw4DEmLCuXMLAPhXrOYZZtp/eb/CHUuILuWo=;
  b=TKueDY92juLLg6o/1hEYqLxr6i+3DXc4nC9uFqAcCUbujuq9d438NWjI
   04NcY1zkXfLoYqShXEuXPGct+NXszIBIZ2FOf8nDOdCL858RXrkiru//f
   PuSTBF0dFZZHifvi4nU7faCmCVbmuuNVT7oUmiUk0mWHsYk1WJWnDgpEg
   TosaGQDAfJtC4pOd7BYV7834vGYlqOdzumXRtU8BWvsJTqBDa/akVdlT7
   UVDmu6PFNP1tYwtuFG8c8Iu+2rAghyhGdmDcnScfZpx/w9lderWngdpUF
   rWATJ7ucjAZveHctETNSjT9F/+cchPp1lABMlrxVWuc+e5QL4icz8FCDs
   w==;
X-CSE-ConnectionGUID: EWQ+ubWpRgiW/ToOd2KMFQ==
X-CSE-MsgGUID: pNGn5IdiQx+EdcyKxVt1FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33222685"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33222685"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 23:24:07 -0700
X-CSE-ConnectionGUID: JitMqjoSRhGC1Z0HvpiXFQ==
X-CSE-MsgGUID: asFJhFxuQs60oZXbCnwOWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65189241"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 23:24:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:24:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:24:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:24:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 23:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEnvfVjcb9j4wxIQsb65J2lhY6hJroMoVJSx7c10NKhv5KhbPpdK+dGib4KfQ+uDiLWecZDsXiaBLJ+75AV94pd10OWiqH/kwmUftxh+2CRM3ZmMAhsaOQ7gRu7+RzQOMB8e2petVX2zlIWtKxXDvKqPRynkFGdS96thk22bxw558CRog49ig8jdbKIVCoeWZsdFnQKmOkTdW6kuy+nwPOY/P0qye4iG1HopKUHLcWGZofLj1fn/NXL9Rinn1Ur94Zff8kg3qY7BoGHXTUhMB3pLA1ntlFnhzJMLylKNoAeS1XVLCa7ahTWwwKUvARbMvp4Sot1ueUBz0vHo2NO7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kbZMpRrw4DEmLCuXMLAPhXrOYZZtp/eb/CHUuILuWo=;
 b=y0fFaH0UEmfCMxXGil8/jQU29qnwRsNGxh2ancLNe7M0aFoG/geV3Q2VtzdSczppeQN6e6Nx0iP+Qpv/xep3Acvu9b3V3auHaEWAxgtW/MbTRKcHY0HhZDiU8zJoKiIQT9ZuqcmJ0KCKEKMaNkhg5FK2C+PhSOux8FLZlDd1HlRz7dAEY4MOraHkoqNYNaQW/apzkGY1HXPdhQO+rgerY5rv3o7/gT9hDLWVzjG4V3QCVEnG/UXJ0YW3GSHsbKA/BIDVqjBMadA4x5E09jJ020RGuaq4OkDu7eO/uHhFEpaqbZjDFUpbKbHylWttUOB3OGOnojWK9n+NRtJ2sqSNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Wed, 21 Aug 2024 06:23:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:23:59 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: "Vinschen, Corinna" <vinschen@redhat.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"jtluka@redhat.com" <jtluka@redhat.com>, "jhladky@redhat.com"
	<jhladky@redhat.com>, "sd@queasysnail.net" <sd@queasysnail.net>, "Pucha,
 HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Thread-Topic: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Thread-Index: AQHa7+/hMBSGHjPkNU+XhTjMSiVdubIwxtkAgAB+b2A=
Date: Wed, 21 Aug 2024 06:23:59 +0000
Message-ID: <DM4PR11MB6117E1E95B5B114534B75814828E2@DM4PR11MB6117.namprd11.prod.outlook.com>
References: <20240816152034.1453285-1-vinschen@redhat.com>
 <172419423251.1259589.15378788577530176816.git-patchwork-notify@kernel.org>
In-Reply-To: <172419423251.1259589.15378788577530176816.git-patchwork-notify@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_|CYXPR11MB8730:EE_
x-ms-office365-filtering-correlation-id: 95a1dd6d-9275-4ea5-c549-08dcc1a9d7cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NktVSyt0TDNQSnM1MTRNUlk3YUlrd0MwZFdDVkZFZHJPTWIyRVVZRnBkRXpG?=
 =?utf-8?B?NzRWSkFLQnJFdE9sUCtzNmpEZ3lQY1FKckZ1ZEhGVTl1cnFST2F2RnRqK3lm?=
 =?utf-8?B?ajlhbmU0YUJoNXArN3FKSzZyQ2hOUXRiNk55MVpROUxNR252WEF4M3RVUis3?=
 =?utf-8?B?MjNUL0lQRDBYWjNtM1N6QmR1S3k2RE9NWmFEcXlHdWl4ODVTRDA5WjE2VzlT?=
 =?utf-8?B?TVEwSWUzOW1XMFFXUXNicnNoMmljc21za1BGWG5Nb1V0VEdHRS8xS2ZiZ3Fp?=
 =?utf-8?B?UkY4YkJlc1ZTY1ZObjJxMS9sMUpITVdSRW5CdmNwQmUxNWIxM1pxTThYNFhy?=
 =?utf-8?B?c1luZG42QUlwTGNjVFlmeVVuYTN2Z3MxTjg3REN5bk1TUC9pU0JMTnRwc0xo?=
 =?utf-8?B?ampjVWJTRFQ4R2ZJWWhVNkg4OE54Yno2U0IvUHdjSGJiZUM2bFlQb1dRV2RK?=
 =?utf-8?B?cUhzWmRmcnFIQnhxYUpGdnJtaU5COEt1Y1EraSt2RDdOYWhhUWJqYzRzS256?=
 =?utf-8?B?eWhuWDVscHptZkFEWDFlL0RVT1d6LzFSakdFdVZDcGlPV0IwMXljbDhSUVJu?=
 =?utf-8?B?ZkU2ZHlzVnZ0NlVpUURnQmZkUDFzTi9UY204VjhtVDZTUDJJaVY5QU5PMlk4?=
 =?utf-8?B?aXcwcFZLNVNHOUg4YVBTeEhDL3ZvUEFWcjNiTzJSajlLQUxlbGpmRVowTDVP?=
 =?utf-8?B?T1RhZHNyS2xiaEhnN2prclNwMHFoNzFnSEZKNzlOZXEzYXkxSzBJM25rMDRX?=
 =?utf-8?B?WFRKZjgwejZFQnp2akJHeU10VDljdjcvSHAzaXhobVZtQTM5QUUra1hZK0FU?=
 =?utf-8?B?VWo1SjJERGNxNlU1YnhOMzBPMXBJaWtHTUVZcFp3TTV2ZjlZUlkvbUh5Uk9N?=
 =?utf-8?B?MmVXTFgzRG1IRTkvS04wR1J5dlJpQnVBKzBDUWF6UFdFN0V4OEw4SW8xMldU?=
 =?utf-8?B?S2RQWEVKZWpIaVdhTDNTS0tSenlHL2MyNTk0V1YyVXdHUkZYdDZwV3RDcmNj?=
 =?utf-8?B?NEZ1a2lkUTJYd0xJQTVnbkQxam9pb0xrQ2N5aWlTSnJoU3NKU0VSKzgzYkNZ?=
 =?utf-8?B?SUNBMXU3dXpkTGVKcUJPdmJaWUFDZ1ExVHRkb2Y4VTZIcTloOGd1bndsaXcw?=
 =?utf-8?B?b3I4K1hmNGlQeUdnbTVPL3B4bDVIMTR2RW5OWHNmY21PbG5KcEYzc0xncEJs?=
 =?utf-8?B?RjNteGloY0twSWtIakdXaFhTWDdvM2pZVVBHeHBtNFd3QjAvWkhUT3ZCMmlH?=
 =?utf-8?B?dXg2N21Tb2ZLV3JpaWJaUGpuZ0RFTzRNOEl5cy9rL0p4OGhueUNxTk9OWExp?=
 =?utf-8?B?dDJLbm5uNnh6c0NrUzBudVYxNnc2VDFnelRoUWwyaEd4UjlwZjg0eThHODVX?=
 =?utf-8?B?N2JNSWJla081VkJkanZRZFlLVG9ZbWorMjlhQjVWemRtWmNWOE5DUUkrOHc4?=
 =?utf-8?B?UUNWbUNCS2x0cEZucEl4SzJPMEtHRDlxR05aQ01rU3JPUzhYdHIvRW4rZ25U?=
 =?utf-8?B?Qms5R3lxa3RuVW5JcUdHS2hpek5lTm8yZHdabFpNNE9uaGFibGtSRXVsbFJv?=
 =?utf-8?B?RzVYMUl1SmFlQjdQamk5R2g4dGxSZmovTFBCSE1pbnc0RXR1eG5RVkgvcnlo?=
 =?utf-8?B?c0dzZDRNbjZJSFVmYnUrSHZlVzNKNnd6bmp0UC9nUFhLaFlHUE1qY2VXeGNZ?=
 =?utf-8?B?RlN0QXBQYXJFWHdQdmYzT0ZnOHRFU2ZSOXJxQUwwdUR4eUtoOVdjZlJ6eTZD?=
 =?utf-8?B?UVVOS0Y5dWNmT1VJR0VDeWd6YWcxb1drNVJsUmF4cnR2YXJsMk1EdVhnUUV3?=
 =?utf-8?Q?/hSVDWxZYbm4iJ9gtaSY1wPZ5Gk0UmJ3ipfDw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklDaGttK25JSmNmeXo3elgyUzZMaE5oWVJLbU5nMVRNUFFGM3Q1Uy82MkRy?=
 =?utf-8?B?Q1AvUENmTklodEovMFZlK0JSdVpLamVWY1JQMHZmbUFuZ21pYnNNbEcxNzk2?=
 =?utf-8?B?UmZjYjgycWJiVUFYc3hSOEFVSEZYdUt2Sm92MDBKS2QrQzY5Y1dLa2Y2RVRl?=
 =?utf-8?B?YTFiOFVLV1JFODVhRU5hSk1BdExhT294ZkJweGJtZDE2SVlYbnpNWUdqekJz?=
 =?utf-8?B?L1BlYlVKeGJGWEFhTW13SFgwSmh3cGlpbGhyL0FPejJZUWh1SFBKRDhtdjhs?=
 =?utf-8?B?YmdLWDJidXVMdnhMVHgyTmJla1orOWoxS3JBOE9EeU5xTlk1SVpPK2M1a0cy?=
 =?utf-8?B?NGVsdDlqaVNIbUJiU3JpNTRDREdCNVA4dzQwNlVXRTJVV1Q3ZWE4d1FhcEI0?=
 =?utf-8?B?bHN6UU9qU25DRVpnaU5wUytZTk9jdmJwYWZlVWZaMWlHakNYU3A4aWVaU2E1?=
 =?utf-8?B?ZEhRNVdNMXpHSWM1Tjc2T1QwakRXaWZVOFZ2SHA5Rk4zaXZZcEtTNlBNaS9z?=
 =?utf-8?B?TjZSODZreWZSN1ZHRUFRQllqQnIrZHNyelRlSklxWmNLVEFIUXdURGV1SThI?=
 =?utf-8?B?QXZzb2E1am1UaUxMWnFwT3VOOEhzaFkzZFJCRE9Ub3BuK0VQSGkvOWdxempB?=
 =?utf-8?B?S1dydXBIMm9JcFl0VEYyU08rVGp1eFFQdUw2Y1NTOXFMb1BUYmlmY2t0dkV6?=
 =?utf-8?B?eWVqRmoxdFpVaW9yRVowV0dDR1RjN2FTLzNwTFpKTTZaQXFlR2pOcU9jbHVF?=
 =?utf-8?B?TjhFOW5GT0NaNDhIRjViZjhKNnQwT1Y2SnUrVW8rRmRIc21EMERHYXI2a2pJ?=
 =?utf-8?B?aTFNREdIbUVTOTFUMDhaUHZsUTFDNmNPaWJnTkFjM09EYWFkclM1bFprV25E?=
 =?utf-8?B?SnMrUVR0RHlkU0dMeE55OVhnWFQxb0NKRk1hQk5JNTFNc2Zvb05iald5ZXJZ?=
 =?utf-8?B?RTVRd3MvcEc4TUVJenUrdjczZU9yU01MWUZ4MGhYYkdEb1pzc2lyT1dYNXVl?=
 =?utf-8?B?bUM4R0kzZnA4WWl3R3Z1UW85V3pXOGJOTXpocEJxWHEweHJWaEQwaGZ3YjFx?=
 =?utf-8?B?VWhOaFd5cjgrRXdxODAwR3VOMEFIMysxQVVVZ01NUU5EWXFlK04zVTZuMGZ5?=
 =?utf-8?B?bHZ0a1Z0RlpVZVc4ZXo2dlJCeGV3N3hCaWliQ2ZROENEVnc0aXpQQ2JocFpu?=
 =?utf-8?B?dUd3YXJvTHBPTkpKSGpTQmRJRE0zSjdhdTNtS3hhRFVxcjQvRjZHWTJDdVhy?=
 =?utf-8?B?L1VyYXhFemVlOGR6Vlp6OGVLWW9uY3F1K09JRXpwODBlTXFVeElkQWoyUFBz?=
 =?utf-8?B?NG4wMTV6TWZrZVpvbGlrTmY3bzBSSHQ0NjVQQnRsaXdNbTV2OHNZMG5qWEhy?=
 =?utf-8?B?SmNDNzNENDVoUVlSL3pYS293UHl3cXVWdEpna1paMGpsb3VTOXVvdXd2b3dI?=
 =?utf-8?B?UDZRekRNd29EUkh2U25meXlUNVdZTGtjN3FGcXpQRDNNOHAxZng2eTBUT3JL?=
 =?utf-8?B?QUxEWWhMM0ZIc1lQMk9RZEhTK0g3TUpFQ1Uwdk9lWlZqOU1VUmFPSlRxZkd6?=
 =?utf-8?B?cmhOSDBROThZSHR0RjR0Y2tYMTRXaHBRaHBLMEhXa2NQZjdBQUdKTFU2T3kz?=
 =?utf-8?B?SG1OY1Z1Qmg4Skd1NXhGVHJPWklLL3l4dlRzZ1hZamhGeVFNaXB2bnJnaGRr?=
 =?utf-8?B?dFN3U0NaVjdXZ1NiV2puT1h5VU5JdWhGQ3VRelJrdE9WUXVjOFRlc0dZUnQ5?=
 =?utf-8?B?SnBlenNGdjd0V2Y5eVJEc0JhVUpvbi9qK1BZeDFQdnY0Y2xNdEVtM01ZcGdx?=
 =?utf-8?B?Z2RCZFNPUStDSVhPenFzSzJKMjdtUTF4eHkwR2ZiK1lCRXM1U2J3Y3hqbFYv?=
 =?utf-8?B?b2FVSjNuQ3cvVnc4eFNVaTczMmpkeHBDYnJqQ2d6enVNMXBoeXJJeURxa3BK?=
 =?utf-8?B?QU5HNGZlU21hcEhXbFZVVzlBL2YwaVhmSDl3Q2thczE4WUZwVVZXUFV3YXda?=
 =?utf-8?B?NmV4UzlXWkdwNVdnK1hGTG9rUUlMSEhNbTkwQ2ErVVgveFBuRlU2RzJibkxE?=
 =?utf-8?B?Q1JiRFBmR0lTUGsyTkhSczRFUnhJeUdjaHhibEpkK3B6cDhNYWJuRThqWnR3?=
 =?utf-8?Q?dsV6FBkUdRbmZi5EcTUuM7J/n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a1dd6d-9275-4ea5-c549-08dcc1a9d7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:23:59.3751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtreJpC0rsQSkkmJx54v3rnQ9jYHV154W4wkB69hY5wMeChdz+ctU6QZu4gwh9OKz7TXN4bHNncLr00pfCnLXBliSn1Zw4zhxVAh+ERLh2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730
X-OriginatorOrg: intel.com

PiANCj4gSGVsbG86DQo+IA0KPiBUaGlzIHBhdGNoIHdhcyBhcHBsaWVkIHRvIG5ldGRldi9uZXQu
Z2l0IChtYWluKQ0KPiBieSBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjoNCj4gDQo+
IE9uIEZyaSwgMTYgQXVnIDIwMjQgMTc6MjA6MzQgKzAyMDAgeW91IHdyb3RlOg0KPiA+IEZyb206
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gPg0KPiA+IFNhYnJpbmEgcmVwb3J0
cyB0aGF0IHRoZSBpZ2IgZHJpdmVyIGRvZXMgbm90IGNvcGUgd2VsbCB3aXRoIGxhcmdlDQo+ID4g
TUFYX1NLQl9GUkFHIHZhbHVlczogc2V0dGluZyBNQVhfU0tCX0ZSQUcgdG8gNDUgY2F1c2VzIHBh
eWxvYWQNCj4gPiBjb3JydXB0aW9uIG9uIFRYLg0KPiA+DQo+ID4gQW4gZWFzeSByZXByb2R1Y2Vy
IGlzIHRvIHJ1biBzc2ggdG8gY29ubmVjdCB0byB0aGUgbWFjaGluZS4gIFdpdGgNCj4gPiBNQVhf
U0tCX0ZSQUdTPTE3IGl0IHdvcmtzLCB3aXRoIE1BWF9TS0JfRlJBR1M9NDUgaXQgZmFpbHMuICBU
aGlzIGhhcw0KPiA+IGJlZW4gcmVwb3J0ZWQgb3JpZ2luYWxseSBpbg0KPiA+IGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjI2NTMyMA0KDQpFaCwgSSBtaXNzZWQg
Z2l2aW5nIG15IHJldmlld2VkLWJ5IHRhZy4gRldJVyB0aGFua3MgZm9yIHRoaXMgdjIhDQoNCj4g
Pg0KPiA+IFsuLi5dDQo+IA0KPiBIZXJlIGlzIHRoZSBzdW1tYXJ5IHdpdGggbGlua3M6DQo+ICAg
LSBbbmV0LHYyXSBpZ2I6IGNvcGUgd2l0aCBsYXJnZSBNQVhfU0tCX0ZSQUdTDQo+ICAgICBodHRw
czovL2dpdC5rZXJuZWwub3JnL25ldGRldi9uZXQvYy84YWJhMjdjNGE1MDINCj4gDQo+IFlvdSBh
cmUgYXdlc29tZSwgdGhhbmsgeW91IQ0KPiAtLQ0KPiBEZWV0LWRvb3QtZG90LCBJIGFtIGEgYm90
Lg0KPiBodHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2JvdC5odG1sDQo+
IA0KDQo=

