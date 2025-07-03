Return-Path: <netdev+bounces-203927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1FAF81EA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494226E1704
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1CC29DB92;
	Thu,  3 Jul 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sdv2Zt8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579629B790
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574151; cv=fail; b=aQjnCSDMzI/81uycYdvrDl20yH9lVsD6Oxo/neNW/jUbvfAvAhAMp4AfBq1b3pkHYxRpzmMaGwovulRaIbR5OGqsTcfL99E/6Z6gTjxs7XtUgz0X8FA15rFpRgYyOzUTMHLoZlF9h8RyGdTiuXDQUOVhhMic0N0ihhM3WBo2Rho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574151; c=relaxed/simple;
	bh=EwrwGJsGiTuZmG4kK6BG4ayo/T2687Rwy62Z6Zrr8n4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ht/8Tdtvjd39PQdsnA7IUxBNGLV89pk4PNUPaZQkXI6ACzDXzq2I1eEFiCm6a6Yn/vTNFL3olQScuDVhP1Glt7szygqR+4655w0YrLoHg8oJhkpmSjv1/U6wonpyAHaiR4CsbXSE+vJizj/kfVBbe3a10YIB8zUrqBJZkk/vJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sdv2Zt8T; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751574150; x=1783110150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwrwGJsGiTuZmG4kK6BG4ayo/T2687Rwy62Z6Zrr8n4=;
  b=Sdv2Zt8TGjiLN+P3Rw0fgfY+ogZD9vhFm5efCQ+02Fnqhhu4d9uJVcln
   aVaqtJ1esQkkmy3xd18oDOuGIXF/PNqrzaMQGzxMowJugOwbuv8o2+FNL
   DxVfCyYMwUMYDGhvkEd0mWQxy9/HCt61LvUha3oyxPLwA7Nw6PMgCxogA
   2nm2cdUJpmPZy3/mvPqDZxXCM/0DbgEuke8neZ0hxuWz+DtjB5m54p1ON
   060jRh3xrwH4LNe5QPipIiVmsbn7aXXBtUWE5HLb5ZW8e3UXvL4CuheU+
   iB74RMDAwIv6TB8yOQPDbc6KM//WHKAo/rAVWpr0B3+2RSKOgoKBArK9o
   A==;
X-CSE-ConnectionGUID: y7nRVNBsT7CRlgiyBDkRxQ==
X-CSE-MsgGUID: wJnh13HLRQKz635YbUU0IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64964467"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="64964467"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:22:07 -0700
X-CSE-ConnectionGUID: V2j7Wd3KSG2DDpyFZw4UrA==
X-CSE-MsgGUID: HkKbjD7iSP6E9Dxwi+Jn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154958197"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:22:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 13:22:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 13:22:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 13:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y56Nzj2Xf+dQNNrvC3eErA/lFSGNZlSxxy+pZOEM2dcZe1Pdf1CwZnQ8qilZzXQCAlcFv+eqgCsGUnanjizykVAu8thScih5w+May2Bw01+oN4nCWRz0TZsRpYcmcxR54vrGcWib/udt/HmYpYKuUj6vu3XSgLy4emuG+I5F0tlu5HtmAW610ELnZ1yTCFi1LoXjZnFnh0BPwGNSyBiN69P09ejlfWdMYwLcZiqoUQE9lLrzPJqBUNBmmcE/9teegQNnCBQmmf5pMte1W0AoYYzhMt912c96ck309/NDDphpuje1LJZxCZYWEZccKoiBBjzCXRSs1+bgCbdcTPJITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwrwGJsGiTuZmG4kK6BG4ayo/T2687Rwy62Z6Zrr8n4=;
 b=pr0dh5bN8D3d+b6ac1QgC7E2tAKwy3E8G4QqIiCpoXrRB3NW7+7FWlFWVz33bY6tljfyM4h2b5423nb8DKkbyFdCZujWzfUnDtSQZbJoIKNhJK+o8+fErjJ56Z+Wr6L50+Pcd1yvgfN2xvpKSlXcaQ4Ibt0eAqjCpLgASjKjNpbG+cLRzZbh1POe/jl5sSxPXS7RetvLMnKHZO8Q4KUHK1P07BPNq2zKN+bRDUO2pT1kgknSO1dyzhVrZZIzzIKapGBdl8/4DCI/JTPCR9/FS4YTHPRi7O9AVZNowsSTtZjdYQYFkK1BHkyHPfHnciE5vJK05MVqOUyWLzmO765O4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.32; Thu, 3 Jul 2025 20:21:36 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 20:21:36 +0000
From: "Hay, Joshua A" <joshua.a.hay@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Thread-Topic: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Thread-Index: AQHb5eraTLJIverxnUGFzGLsGjNTNLQUdh6AgAdn0ZCAAAx+gIAExkJA
Date: Thu, 3 Jul 2025 20:21:17 +0000
Deferred-Delivery: Thu, 3 Jul 2025 20:20:40 +0000
Message-ID: <DM4PR11MB6502C412C043F2560FC468FDD443A@DM4PR11MB6502.namprd11.prod.outlook.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
 <DM4PR11MB65024CB6CF4ED7302FDB9D58D446A@DM4PR11MB6502.namprd11.prod.outlook.com>
 <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>
In-Reply-To: <c6444d15-bc20-41a8-9230-9bb266cb2ac6@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6502:EE_|MW4PR11MB7150:EE_
x-ms-office365-filtering-correlation-id: a934a2d1-ca42-4f44-87e8-08ddba6f35ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NWFmenJlWGlqc3Z2ZVZuejduY2VPWlZCYTc3dzU2SFptMjlnbnlMTHNDQTVn?=
 =?utf-8?B?bi9MRnFkVmtRVGxaZnhrNHl3YXhSc3ltU2N1SmFqemEyQWRsTlZTQ0MvYzZK?=
 =?utf-8?B?V21lekhoOVEwL0lqQjFWRGtCWERIYmxyYTFzL3NNcEdYNGhidDFra1ovamcx?=
 =?utf-8?B?T3VGNFFMcUFRSUpHWWY2TDUrVFladjJTVHJNUW9CK1Z0VmptaDZLSGREQXp0?=
 =?utf-8?B?VjFzRlNoM0NnM011QTdYbU9zc1RtNVhNZGs4VktHQm1VdENGSG1UYVJCS1p2?=
 =?utf-8?B?R0FMNHBNSjF3M3RGWml4MW1JWjBlaFdzRTJMekV5VkFOM3pqRHRRSzdQYW5l?=
 =?utf-8?B?SXJyd3IraWd5cU41UWRFQ2dDTUtHVEQ2RTI0bnNETjNVVEYxM1dzU2Z3ZGhy?=
 =?utf-8?B?MTdUL295SWhlWFMrcU1vNkt4UFJ6UWdtd1djMm1JM3RPS3ZSaDVLd05kK3o3?=
 =?utf-8?B?WVU2Rnhyb3lwOWlRSmozQ2lUZ1V6VDRwNmwyWDNlcFZycGZ2Z1hiaXVaRkdi?=
 =?utf-8?B?WDkzdUNhTS9KOXV2dWJ5dmU5bThxNy9NSFRPRW83cGRBRnQrb0tuSmIxTjRk?=
 =?utf-8?B?V0w3bERMUS8yejh6OTlUazZBY3JUS283Q2kyakwxdWVhRjVreDdVZXpUakN2?=
 =?utf-8?B?NWVqY3lEelI3Q3ZVZ2wwcVk4SExzSkRJRm1LblFRWmFkSk92Q2xPdm9IRDFp?=
 =?utf-8?B?Z21TRUZLM1hLWCtRZG5tejNVRVYxMjhQNVJ5UmV2bGxXS0JLL29CVWgzTW1B?=
 =?utf-8?B?SXV4aDUvOElrbU1nWHhWcFpDRG9vNDhjeStENHU1WmdFN2NvZ2c1T1NzdDE1?=
 =?utf-8?B?ZFpoU1VWL0dyeVp5b1ZkZkVQZi9jMWhmNmlJV0JpK0MwWFJma2pEY0N2aTVQ?=
 =?utf-8?B?ZE1DUFB0UTRZbHd3ME1tYlh3VGE4ZmcycjlIRi82N0I5N2Q1TXRqSDlEMnNN?=
 =?utf-8?B?MENEU3I5SzJoRmRmU3EwbE00Sm5keWhDUS9aT2xrYWZqRkRhMjJlZE5kYlBl?=
 =?utf-8?B?VnlnRFZuOC9mczhRTENiNVR2clY3MlozNGtGRDlwU0tDWWptSkZzSkNIRWk4?=
 =?utf-8?B?MEVvcEZ1a0g0ZUZQU2xNREFDTnRaN1h4dGJ0amVKY3RtN3RKYkpMeHZsemVn?=
 =?utf-8?B?WXhtSXpEQjBaME02ZExMdS9IWEN5WWh3VTFwamJFa1N4THRXc0l0TkJPSVVt?=
 =?utf-8?B?WDNhdHdsb3JjTTQ5akZQanRlcnZBb2FmWU9qUWxxWE1uVGNNajVMUHpiVFdY?=
 =?utf-8?B?SllNVkozd2pVUlpMMDMvZS96QkpVVXl0SXZ3TVN6UW51NzhRbUNmMHR0aWg3?=
 =?utf-8?B?VEErc2JadDdVaHM0QzFiay8vT09hRVdKYVhGbm4wckg1VU9TVmJxQWZ2djVS?=
 =?utf-8?B?dUpWL3pVTitBU0g4Zi9ManVTK3EyV1lDNVBZRWhDdDdUOHBacWxaOU9KRFQx?=
 =?utf-8?B?ZVA1eWgrblpSZWJZS0Jwd1VhTUtRMy80bjMzbytHaXZFREJ0UHBQM0drMUFF?=
 =?utf-8?B?bVUzK2VJMW12b1NJTGloUkFhN1ZCQW56RTJYMlBhM3VyUlR0dG1tUW1iQkpF?=
 =?utf-8?B?U20rQ1IzTWNpZTMrSjI3OEt6dzMyb1lHTmxjWnZvdlByK2Q0dHY1cW1aSVBJ?=
 =?utf-8?B?Y21mbERWMmowbStGMHF0d0N5RHljem50NjVnQlN1V1A0eVdDSUg1Yld0a0lV?=
 =?utf-8?B?cTMxYzdObzNZZUpTRmpvRUtPZnYwellRRHJ1dHZkbDFvWUUrTzZaTFdvL2lQ?=
 =?utf-8?B?dWk1c0FLanpmaDdDV0txQW1Wdk14ZVFvZnBOcEduYm5YQlNNaG8vZWp6My9X?=
 =?utf-8?B?RjRjZWVmWVF3b3hWaTB6cUtFOURUTjdKM2dQSHlVSjdwRktEb2hBbmtNK2JJ?=
 =?utf-8?B?NnpKeXh1SEZSQ3pVaURQLyt2MmhnTkJUa2FScFNoS1ZaeWVPdEdRY0JTQmRh?=
 =?utf-8?B?S1FaWWdVK3Y3L080dHhLV2NKZGdMU2RpUVg2QlR2TGhaeVZQclRpZ28wcmpu?=
 =?utf-8?B?ZDRVaHZFQnVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBBeXNDU3BTWEl1NGxadEJSSEMyOWt2a08xVy9YZjd4ZTc2dzRsWXQ5QVZ6?=
 =?utf-8?B?c3BoODJYNlBrR29TUFMwbXg3OGNsdnBhRlVWRUpUVExHVDBMSnBaZnpqNTRP?=
 =?utf-8?B?NGVUelBaVndXa200dFFocllKTEU0R3NVSDQyMXdWZjlLalVjWXVxTG50WHh2?=
 =?utf-8?B?N3pCajYxMGV1VGlkMEtQVCtwZXpBeWl1UmdsQTlJQWJNUVBmZ1RjbVpzaGhw?=
 =?utf-8?B?VUliSEZvOVBJU2ZLZm1oY0pZSStaWkMxRkNqbEpBMHhkeFRZRU1RLy8wb3ZU?=
 =?utf-8?B?anU2bDkvYjB5YTBJWElCQ0J0ZEpackVIblFUVU55Y2lFU1loRHhxbkFCYktv?=
 =?utf-8?B?dWhMSFBGNlJiOWZQQ0xadURzbFpTZHY0ZFN4TWZoZ1M3emt6TTNTSFp2NGt2?=
 =?utf-8?B?WUhSRHJuMU1aT2FVbVdtSlFIdUttZkh4dHRpYW5ObGhHUjFDV3FDYVNSV1Bo?=
 =?utf-8?B?RW5ZQTIrMytGSUJaZHRkaUpBNHVJZi83cHp2akZzc1pwK2gveGoyOExUZllS?=
 =?utf-8?B?RVNuVjBhamRqUjFDZitsK2h6Rzl4R1pQRkI4YS9WdWpSMDcwaTRkVW0wazJt?=
 =?utf-8?B?T1dsNVJjMWJxdkFGOHNYcVMwM1dPUmxJRC9qem1JWTB1THJCR1VsOWtlQWNB?=
 =?utf-8?B?SjFpVFFIbHhRcVlSWXowMzdwcnloZWxFMXJjTFhLU2tEUnpaZjAvSEVxc3l6?=
 =?utf-8?B?SkFOVHBHLzZ6ZVVQaENER0Q5dUUvUWF0WGZPT0w3MWJ2aHd1VlF1ZnFCYUpn?=
 =?utf-8?B?MFh3OTFEUjUvZklDYkZhR214TWhRc09CN2FmQWZFeUJrc29UWnEyMHBDVldV?=
 =?utf-8?B?TExiQTJzZ2tNYUo0a1N3VjRDUDFEKzZ4bmsxWklnMWNSaG9FWUxVaW1iQ21l?=
 =?utf-8?B?K21qUlhpb1hiV2NhcjdvRlNndTNwV0xLVFY1NkhtNzE2K3h6bitrc3MySUZu?=
 =?utf-8?B?b08zNHg2QTV5ZTJ5ZlJuS3pZMkx6WnFsV3EzNUJlcmZ5bGM5R3A0MlROd3pZ?=
 =?utf-8?B?SzVocUdyTWE2RmllU05ibVJ5THU3MjZoNjNkcjFqTGgvTFc5TXd6Sk44eC9F?=
 =?utf-8?B?aWdpdHI3VWdHNFljY0IxaGlHWFc2ZnR0cE4yZXd3UjZ6ek16UFB1cmQ4S3VT?=
 =?utf-8?B?OUpROXNzdzdtcGg4a3ZqbVRQdU9Od3hzd2lCQWlOMCs3blBvM3Z1d1NXYnVV?=
 =?utf-8?B?RUdGVklidkFMT2toKy8vNGJ5TVRPNVZLaUdNaW5lWHhGWFdPNk1nVGxwUUVW?=
 =?utf-8?B?ZCtacHhWby8yUkJDU0pZOUhxdXZwZ0tYOXh6UW9HRHYvamU2UXpZek5yaFNC?=
 =?utf-8?B?dGE3a3FoMm01QncrR3NHdHB2MVlJcFI2aEl2bml6amxDT3FCVTJqQW1aVWhn?=
 =?utf-8?B?elo3cXZLT1dtWnRrN1U3RHQ1TFVpa0FlSEJlL3VpeGZXclJQTkpCQjNwSFBw?=
 =?utf-8?B?TWU5WDRFR2JnTGx1N0tUMUE3M3d6RkdaaVBZWTZLWGN6YndJZkNDL1ZFVzhm?=
 =?utf-8?B?V1hnT1ZSYlI0dGFndmJndStWWmJaejdjMzFSbisvaXczdVRmRitJbzM2czBV?=
 =?utf-8?B?WG9yWHZJdVowVUZtYUhhdkZocjJSdFk4WXNibGFDSldCR3FPRmtxSnhNbTk1?=
 =?utf-8?B?N3FnWStWMy9ZNkhadW9RcVpnYmx4cjFXV2F1TEZUaVhpVG0xQnNhdGhnOTFV?=
 =?utf-8?B?TjdmZ1k1YXlRcUVFc1h2dzVQUCtzY1lUTnlqWXJpd2ViV1N5MkU5WE1RZmF6?=
 =?utf-8?B?V2Y3czNOK0dLT2NmellRQlhaRGQwbUVzb3E1elA2dkw3QUJ4cWtvTlFrSHIr?=
 =?utf-8?B?VUdYdGtlR1JZSS9Ya0FxWFBMbkVLd2F4UnJFNG8wcmViOTd2MUhDWmhsUEtx?=
 =?utf-8?B?enJWa1lzL1ZwVmdxZFNibms3djIzSHhhUTNRZFdTekNPcWNuRGFlNGZFN0lm?=
 =?utf-8?B?QkpUOWtMM2lycWJJR1RGRVRBNmVFaEE4WnNzMUhDczh4V1BRUm9PSmJlT0di?=
 =?utf-8?B?bEdtd2tkVjRXMTFQVzU5Ky9EOGNwbU9EVStlakRZbVQwbDVpVXBkNzVjb29y?=
 =?utf-8?B?UkhWVlVTMElUczBwNnJiZStubWg1OUxIZlFuaEhWdDR2NXY1MGdWY1BVdXBw?=
 =?utf-8?Q?tSgmsC4ofGiFsOGfiGtjRPnnh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a934a2d1-ca42-4f44-87e8-08ddba6f35ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 20:21:36.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tLoWeafgh8Ns3/1anpBsUbDpJitwsy0ufB81vI2NhFBiHLZgnEUFGy8eP2Cgh0HAx5FSETJIrbWfPEFCiA+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com

PiA+PiBBbSAyNS4wNi4yNSB1bSAxODoxMSBzY2hyaWViIEpvc2h1YSBIYXk6DQo+ID4+PiBUaGlz
IHNlcmllcyBmaXhlcyBhIHN0YWJpbGl0eSBpc3N1ZSBpbiB0aGUgZmxvdyBzY2hlZHVsaW5nIFR4
IHNlbmQvY2xlYW4NCj4gPj4+IHBhdGggdGhhdCByZXN1bHRzIGluIGEgVHggdGltZW91dC4NCj4g
Pj4+DQo+ID4+PiBUaGUgZXhpc3RpbmcgZ3VhcmRyYWlscyBpbiB0aGUgVHggcGF0aCB3ZXJlIG5v
dCBzdWZmaWNpZW50IHRvIHByZXZlbnQNCj4gPj4+IHRoZSBkcml2ZXIgZnJvbSByZXVzaW5nIGNv
bXBsZXRpb24gdGFncyB0aGF0IHdlcmUgc3RpbGwgaW4gZmxpZ2h0IChoZWxkDQo+ID4+PiBieSB0
aGUgSFcpLiAgVGhpcyBjb2xsaXNpb24gd291bGQgY2F1c2UgdGhlIGRyaXZlciB0byBlcnJvbmVv
dXNseSBjbGVhbg0KPiA+Pj4gdGhlIHdyb25nIHBhY2tldCB0aHVzIGxlYXZpbmcgdGhlIGRlc2Ny
aXB0b3IgcmluZyBpbiBhIGJhZCBzdGF0ZS4NCj4gPj4+DQo+ID4+PiBUaGUgbWFpbiBwb2ludCBv
ZiB0aGlzIHJlZmFjdG9yIGlzIHJlcGxhY2UgdGhlIGZsb3cgc2NoZWR1bGluZyBidWZmZXINCj4g
Pj4NCj4gPj4g4oCmIHRvIHJlcGxhY2Ug4oCmPw0KPiA+DQo+ID4gVGhhbmtzLCB3aWxsIGZpeCBp
biB2Mg0KPiA+DQo+ID4+PiByaW5nIHdpdGggYSBsYXJnZSBwb29sL2FycmF5IG9mIGJ1ZmZlcnMu
ICBUaGUgY29tcGxldGlvbiB0YWcgdGhlbiBzaW1wbHkNCj4gPj4+IGlzIHRoZSBpbmRleCBpbnRv
IHRoaXMgYXJyYXkuICBUaGUgZHJpdmVyIHRyYWNrcyB0aGUgZnJlZSB0YWdzIGFuZCBwdWxscw0K
PiA+Pj4gdGhlIG5leHQgZnJlZSBvbmUgZnJvbSBhIHJlZmlsbHEuICBUaGUgY2xlYW5pbmcgcm91
dGluZXMgc2ltcGx5IHVzZSB0aGUNCj4gPj4+IGNvbXBsZXRpb24gdGFnIGZyb20gdGhlIGNvbXBs
ZXRpb24gZGVzY3JpcHRvciB0byBpbmRleCBpbnRvIHRoZSBhcnJheSB0bw0KPiA+Pj4gcXVpY2ts
eSBmaW5kIHRoZSBidWZmZXJzIHRvIGNsZWFuLg0KPiA+Pj4NCj4gPj4+IEFsbCBvZiB0aGUgY29k
ZSB0byBzdXBwb3J0IHRoZSByZWZhY3RvciBpcyBhZGRlZCBmaXJzdCB0byBlbnN1cmUgdHJhZmZp
Yw0KPiA+Pj4gc3RpbGwgcGFzc2VzIHdpdGggZWFjaCBwYXRjaC4gIFRoZSBmaW5hbCBwYXRjaCB0
aGVuIHJlbW92ZXMgYWxsIG9mIHRoZQ0KPiA+Pj4gb2Jzb2xldGUgc3Rhc2hpbmcgY29kZS4NCj4g
Pj4NCj4gPj4gRG8geW91IGhhdmUgcmVwcm9kdWNlcnMgZm9yIHRoZSBpc3N1ZT8NCj4gPg0KPiA+
IFRoaXMgaXNzdWUgY2Fubm90IGJlIHJlcHJvZHVjZWQgd2l0aG91dCB0aGUgY3VzdG9tZXIgc3Bl
Y2lmaWMgZGV2aWNlDQo+ID4gY29uZmlndXJhdGlvbiwgYnV0IGl0IGNhbiBpbXBhY3QgYW55IHRy
YWZmaWMgb25jZSBpbiBwbGFjZS4NCj4gDQo+IEludGVyZXN0aW5nLiBUaGVuIGl04oCZZCBiZSBn
cmVhdCBpZiB5b3UgY291bGQgZGVzY3JpYmUgdGhhdCBzZXR1cCBpbiBtb3JlDQo+IGRldGFpbC4N
Cg0KSGkgUGF1bCwgSSdtIHN0aWxsIHdvcmtpbmcgd2l0aCB0aGUgY3VzdG9tZXIgb24gd2hhdCBk
ZXRhaWxzIGNhbiBiZSBwcm92aWRlZC4gSSB3aWxsIGFkZCB3aGF0IEkgY2FuIHRvIHRoZSBjb3Zl
ciBsZXR0ZXIgaW4gdjIuDQoNCj4gDQo+ID4+PiBKb3NodWEgSGF5ICg1KToNCj4gPj4+ICAgICBp
ZHBmOiBhZGQgc3VwcG9ydCBmb3IgVHggcmVmaWxscXMgaW4gZmxvdyBzY2hlZHVsaW5nIG1vZGUN
Cj4gPj4+ICAgICBpZHBmOiBpbXByb3ZlIHdoZW4gdG8gc2V0IFJFIGJpdCBsb2dpYw0KPiA+Pj4g
ICAgIGlkcGY6IHJlcGxhY2UgZmxvdyBzY2hlZHVsaW5nIGJ1ZmZlciByaW5nIHdpdGggYnVmZmVy
IHBvb2wNCj4gPj4+ICAgICBpZHBmOiBzdG9wIFR4IGlmIHRoZXJlIGFyZSBpbnN1ZmZpY2llbnQg
YnVmZmVyIHJlc291cmNlcw0KPiA+Pj4gICAgIGlkcGY6IHJlbW92ZSBvYnNvbGV0ZSBzdGFzaGlu
ZyBjb2RlDQo+ID4+Pg0KPiA+Pj4gICAgLi4uL2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9zaW5n
bGVxX3R4cnguYyAgIHwgICA2ICstDQo+ID4+PiAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZHBmL2lkcGZfdHhyeC5jICAgfCA2MjYgKysrKysrLS0tLS0tLS0tLS0tDQo+ID4+PiAgICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdHhyeC5oICAgfCAgNzYgKy0tDQo+
ID4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25zKCspLCA0NjkgZGVsZXRpb25z
KC0pDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KDQpUaGFua3MsDQpKb3No
DQo=

