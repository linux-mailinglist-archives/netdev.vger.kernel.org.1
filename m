Return-Path: <netdev+bounces-162126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F81A25DB8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C61C3AFC8C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59620967D;
	Mon,  3 Feb 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pvgLNsqC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855920A5F6
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593801; cv=fail; b=P5KiXiLNfQIsJ3/1Ce63Kbe4qiWWE2Ts0g+ly7g+0GUFl8eGUot/KNaVAgsJH2Vi30+rhT/PKaasOzvwurGKSgv9PB/iFyvA/e6DFm/f68KS/F2gs1rRpOfnqfdNwrr5pPxxa0kIdbMo3GJc8szQJzg/mL5D0hwhtATNGgCUXe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593801; c=relaxed/simple;
	bh=L3EaPWoxfKH+yBXMCmwMnSnJE9i/AOC9ahcAbD6/Eg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZSRKH8e5aA5q/1ouJ6XES9HOUoBQ+Bkwhy5SR6JDPy/W8NvaypIMRdB8IrCPB4xNwYbNY2aonlRWqYDKMVxiStlkIvsnrdIExrPhMF78xaaN5sRlOHpbxZfbjWRcDEl9ED8o9dq2U+t4qA3a9rqlx8P2jnyQbl+kevnlbPmm/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pvgLNsqC; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du9Z52xQhhzHOBtKaYCIa+sRClhOrThxolcre1+3oEj2paqmxYO+oTHBZmIWRz53EjRx/Ab2QSD2OE3DjZF+gwr4AF+2ZuwIUylHL3PHt2Buwhk6vFSAx1EKWqirr5NuPne+LPYMvrOUZM9tFBDe5zpA3YBLB6AlHKauhZuHdewEKMPKV5Uid35CKUbPRx21gztAMYjtmK8h2lPuaihAX7PtQ/GH4rbK8p8Qnc3n3cv+P9xvcXz6zQEy0jyh99R/2i8RFiRpMKUpYszXp5m/uUWU9YGUOXZA3Tq0kzM/UHz8wetpS38k7dv1VT6nQ4ytI2eM+LXU3TUjlgu11jZbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3EaPWoxfKH+yBXMCmwMnSnJE9i/AOC9ahcAbD6/Eg0=;
 b=oQMIBnb3eopcl/lD7yGrHYNYdrBEX1li35rsyfT8MO2y6O0NXK/j9HQOi0SHBx4zyKwBlRvcjpZwEiPMl12vPaDnm3z8xOM7vnyjCbXzNobnod0pu39npy6v32R/Cd5Z/26BGS9KZm9bK0A4wHKmurwS5c160HgrQhUzeBFGvRrwsN+2aSfG/Bza0oArnT19cyyh/2HpPwIEpV3tzc/H59pCAVgeK4/7qG+o7AJ7l9H3E6GQLO1iQGslNwZN2Kum+6m7ZR3BbgUgXThBUT6fOSy7D5WfilKNVm2SBjU8HtdAUlYcN1PCDeiqNxKNOAh8ZnymOxbAjz/mTPf/Bax36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3EaPWoxfKH+yBXMCmwMnSnJE9i/AOC9ahcAbD6/Eg0=;
 b=pvgLNsqCVOgJ0LjsGTpMPEb2LJ38070yK2jamLTmYuEOKJk6xjqbFGo8Nyxz9y3FKFjBB+QEhEc+cesW6mnRJkFR8CaiCs2SyVQ83IEeLkrHIMWPfCn7Dq4I/kVqQUdHRp01XJhOgfSCbZoL+C8kYp5CdVfc6PwhQmR2nDBMv3YIK/d4nSoCZOauE/WMMjs/ouEYPsLuAnG3xobSA3Z1u7Ud510u4hOcL7Lf0PTI4Jk6r1KW2x5iYi+DLUJLvsG2z0oSJEBD/QYJFqJuR52NmQxIQ0864oX8GSrTEis35AvVwiZjD8yJIJNqTMvTIJpwMgdP4+qquxTeJsaL4rDQWQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 14:43:13 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:43:13 +0000
From: <Woojung.Huh@microchip.com>
To: <lukma@denx.de>
CC: <frieder.schrempf@kontron.de>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<Tristram.Ha@microchip.com>
Subject: RE: KSZ9477 HSR Offloading
Thread-Topic: KSZ9477 HSR Offloading
Thread-Index:
 AQHbcZ/V7BrTHsAdqUafWk3/ZoT41LMsd0oAgADjJgCAAArSgIAANkeAgAAFAwCAACgGgIAANNSAgAAc85CAAOiAgIAAXJhwgAX6CoCAAFcuIA==
Date: Mon, 3 Feb 2025 14:43:13 +0000
Message-ID:
 <BL0PR11MB29130DC3BD02197B1A26C944E7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203103113.27e3060a@wsk>
In-Reply-To: <20250203103113.27e3060a@wsk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH0PR11MB7472:EE_
x-ms-office365-filtering-correlation-id: 44a47613-62c7-41f2-c250-08dd44611665
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFFHY2FIS0pXNTdwQlRYSDNRRUp4L0RhLzkrUElCY1E4SjMxYXNicjFSRHcz?=
 =?utf-8?B?Yi93Z2dpRkV4VjVFQXo4L1g1U2QzcU42Q1M5aDJsWnJCMmw1Y3pLZjB6TEhG?=
 =?utf-8?B?YXV1NVRONnRaMU9qd2lTY0xITDcyait6bHIxVVBJc2dyZENFM0ZyRzBReVE5?=
 =?utf-8?B?Wko0VUhWQTNBRjB5cnZqZzBKUG1wR1g3RGlkcURVM1BiV05IUEZDb2gxM08r?=
 =?utf-8?B?YlZzcnJOVlR3V2Z2ckNLMU1aNmRVOTVSTlNFK3YzZzJYSURGdW85VW1SMWpx?=
 =?utf-8?B?WVg2NVdlYXZTc3AwVXdHUDZpd3VwVnpKOUlVejZRZmxFZVU3dk03V2VzOEpl?=
 =?utf-8?B?S3NORFFtN3JBU05kVHlvYXVpd3dZMHFXUTFMMm84a3BKNVVEcWVOOHE1b0c2?=
 =?utf-8?B?dWlWKzh1U0lXaURwSlZjdG9KNlJjZnIreU04WWtZUE03SmdocC9XdmcwN2FO?=
 =?utf-8?B?aUVpVkJxc01ERCsvM2N2a1ZGWkxXRi85US9ReFVWRGFTMEE0bHU4aVZVMy9z?=
 =?utf-8?B?U2hKcTFocXppTkdlNFdhZXgwaFBGSXRobnhaT3BxbFU2NE0yYlJqZTk4N2lG?=
 =?utf-8?B?ZWRlMmNrdEE4cUgvWFlSOElYNWh1eUd4UVlQa0tiS3A3WEhBcUhhdFNqZXFK?=
 =?utf-8?B?alJ0eU1VbUk3RVNIRXF2NDFXZ2V3TU50Ly9XamMrQVM2ZDVXM3RWc0xxalRv?=
 =?utf-8?B?eG82Yk9sZzJUNFdNYklqNmMyNHVMVnVwbW9mMHVEWWRUczVHRGFnWVpZZXZL?=
 =?utf-8?B?QTVtWkhpNGNiQU8yWkNZMS9qa2hpOXlEQWJhVHBPSnljdDV5OTBQNm56M2sv?=
 =?utf-8?B?VGhScEV4Tlk3UzRxYXNPNHhCTHpTajdBUFdEWE5IQ2d1ZWlFN1lXbkhCTkFn?=
 =?utf-8?B?cHkzZlhpWkIrNnRla3NIejZjbUsxTm5oWHJ0M3BxRDROeU10UTd6QnVlcys1?=
 =?utf-8?B?Y3Z4ZEdPRnpYWGxUUFlRcUxDd3hjL0t3U3VnWDM0TUpDcXJILzl5czJyUnB4?=
 =?utf-8?B?NjlOS3FHbjBrbCtkUHNUR3hvRFJqbnVMdEZldGF0V3FFU2lJS3FJTUZubDMx?=
 =?utf-8?B?bURIRUtBVHpiMzZ4OTlNeXFpbWRIN1BIMDhJb3g0WVd0OWhXcUpRaW9qRXhF?=
 =?utf-8?B?Zitscm1xZFk5S2lveGVpT0NxMHhNclpHa3RxSkZxd1RQeWhtdUw2WlRkMVJv?=
 =?utf-8?B?dm9RWWR0b2RsMW43K0RhRjVTQm9xK2t0cTZBSkdLeElkY3BzOStadkt2WTNv?=
 =?utf-8?B?UGowNVhJM0tHbjg0RU5HRDFIYUI4RXU4ankyTjFJSE56MUxESzJFanZFS2pI?=
 =?utf-8?B?STlrWWpmLzI4Wk5KMXpvY3BrdlpGZVgzeGxhbHZid3FOSXZuNWVyNGlqazhy?=
 =?utf-8?B?aFA5eGszaXh2aCtlN3pTZmFNQjRiQTJQTXcxejd3SlB4UFA2SmZ3YmIyd1NU?=
 =?utf-8?B?Q2ovZW1aOFB3OEFBZlNhNlpUMmRFZmRjZ3hKM2MvM3RieXIydGpZcC8vYkVS?=
 =?utf-8?B?MnFwd0crRUdqdWZUNUNxVHE1UG1HWnJXQ0xZQ2FHMVdBaEhaT2Y5L1ZzaXJY?=
 =?utf-8?B?V1lWdkZpQXlZQUZYOUMzS2Jlbjd1cGFCNDV0aHZPTlliZkRhcHNLSEdObHpj?=
 =?utf-8?B?dWkvTmRoVnFmVHpTRVZrTHoyOTh6M0k5Q2ZaMW5nOGNxMUNsenFJTFIrejA0?=
 =?utf-8?B?ZkI5M1VtQUtVOHh5OW9QZEtOZ2loSzI5em5jdFpLQzBuQjVjMlJJQXJtTHZY?=
 =?utf-8?B?d2JWQUFIK3Njb21BVnhaUndBOXgvY0NtK0l4Z3Nkb1p4VmEwOXQ0N1NaV2tQ?=
 =?utf-8?B?bndaNWNVOHJtZ1Uvblg5SnJqMm5RVnJJRGFxK0x5ZjViS1FHVVpJQTVTdjcv?=
 =?utf-8?Q?XYIHqZpEogjT2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlJGTHRqQzl3OFE0STc3dERaYm96bnAxK1dncFZXbGlzcGwzL2c0TWxkbE8z?=
 =?utf-8?B?VHF1QmhEd2IrZDBWSi9QZ2pKQWhWSEIvRHpGdkpNKzk2MGkwYVZJd2VJNnhO?=
 =?utf-8?B?YU5Tb3F3ZUp1RHhrTkxtaFRTM2JrUjJodWZYbjJucUpnNDFKVEIzUkRvWFVp?=
 =?utf-8?B?LzhVclAvamdiMkJFbk5KaFhBSzQxTXpPb0thVlVBd1F2VkZFekNuY2VKOEVK?=
 =?utf-8?B?ck9HMmxWZW1YYVMxQjZkeVpJbWFEaS9lSmcvVkd5OWYzblJKcmdyc1VCaVUz?=
 =?utf-8?B?Umc0bWNYTTJFRHM0UFJSbGRzNk1jaWFJQ0JUZHEyYnp2MWRuUDV1ZzZwczNq?=
 =?utf-8?B?NEdnOUVEWlRGYllEUFRiNDBTTDJUMHkzdWY5elcwMWhtbTZHWFdiMFFOREty?=
 =?utf-8?B?dy9nbGphRDRGMVZ6NUtQNUpjZDYwRmZNbWpSVlowSTZSaW5URHd6dEFSY2hD?=
 =?utf-8?B?dmR3SkJEUXMxcUJaS3pCZ2lKS2c4ci9CcGk1Zi9QbndiVFRDUm1ha08reThw?=
 =?utf-8?B?RmZzSEFWbHpnWFJvUnkvRnNONEQ2MkUrUXJBeDZNbDI1WHhRZTJwTVkvMW1y?=
 =?utf-8?B?Y0Q4di9KWVF5dmhGT2NjSk54cEsyc2NBNUtCZXV1TWRya2JvT2FmYjVCUDdT?=
 =?utf-8?B?RXltTUVmTkxUOU9TaVRhQVQzaU1TS3N1ZlNMNFNPM0oweE9Vb21oZUhETGJj?=
 =?utf-8?B?V0pEbElWMU8xa1lYYXRZZExaZm5GNWhhQU1yVHJiWWw2bnVaV2g3ZEhYaXJO?=
 =?utf-8?B?NEZlczZYSk5GMnZZcGtJNGFadXdPQnRrV1UvL0dmNHUzMXJ5aisvUzFIOEZa?=
 =?utf-8?B?OXhiRk1zRzBaR3NUczBtNHRFU1RmQTZnUnRXOCtwSnJmS3RDeFAxUWhsbHV1?=
 =?utf-8?B?a2x1NE94S3cvMDhYOS9OMWRlWUtmZXlTS1d1RS96Uk45Y3RCOGhaZFE4a1lX?=
 =?utf-8?B?TkIxM0RQYjNia1hZU2FObGh3cWRGNG1YaGN0RWpKUHFJK1AwVnQ0enBOOWVD?=
 =?utf-8?B?djFQRWQ3bDJ5RXFobWFjUzdwM0lBTGxXaG1jYnlwZmUxZE5QSzB5b2ZYd3U0?=
 =?utf-8?B?UDhRaWFaSUdBaTdheTlBNzVkbHVFSzMzN3JZTmErZ2pUNzMva25wdGc0cW1R?=
 =?utf-8?B?c3hYR3ltbDZ2dTdXZ2lUNm5uS0dyeGh3WjZNU2k5YTJmQ2E2Zi85L0ZSVmN6?=
 =?utf-8?B?L1FLbUNPeHJOMVNBVDlnUUdRalhBMUJnRXlvUHNseXZBVnp0aGVkQzlWWkhK?=
 =?utf-8?B?SVYvbUVHSFkyT3QrbFgvTzFGS1JLZEdaMXB1UU5yTW4xdHpkUnZZbVdQemRt?=
 =?utf-8?B?dC9ZN3RLOUpvS2hMWFJHMUxDMkhBVzNYMkRlMVdqZis2cVBPNTliMEJ3U3hl?=
 =?utf-8?B?Y09ISlFnNnFwcW42enlDSDRxaVZGS1NFVDR0ZVdRRitiY2d0Y1E4aDZETk5l?=
 =?utf-8?B?VVRlWUNPMTdhQkxORVlZQUJUNEYyWkhFM250RVQ1RTZnanVabHB2elVIOG55?=
 =?utf-8?B?MFlCMlYwSlV6SGlwOG1ieGplUlVCTGRQU09MY09HR2hlR1JVWnVWdXFsaEJo?=
 =?utf-8?B?SEFLY0g0TTZPWmpRVERLRU8zUFBzdjdqTXU4UUVVcDJsRDYydGtvUU1UMlpF?=
 =?utf-8?B?SlVUU3ByUkpmRjhvNXc1OGh0UXNHaGw4bEsvSXNVbTFVZkVOS3lQZHVwSFU0?=
 =?utf-8?B?cDdsenVuZ2JlYTc3L21UYkJ5RmNiMXRnY3h4VUF0NnhIaldiRkxpV1ZiUXdL?=
 =?utf-8?B?dzhhQ0d5MTBjOVd5a080dTdvb3Bkc1c1dVNkN25nZWl5WHRGWVFKRmgrNDRt?=
 =?utf-8?B?ZnR2K0pFUEpHVmd1cC8wc1p6WFRkbm5LUmY4V0R0Vmg5Y0RHNEhnM1QvSWE1?=
 =?utf-8?B?SlB6aHMrU3hHVk1GZE5XUFRxL3dpTytPYnp4a21kb292dXRRYnhUZ2JlRndO?=
 =?utf-8?B?b0dCck5jUzRuRHlLNlM0WEdKeDgwVHd2NHprd1JnTDMrOEhMNWp6WUZsSkUw?=
 =?utf-8?B?TytWUFVzdXlZU25SVDdKQlBtNytFTHF2eElucExha2l4azhnbjFEd3ZodXRQ?=
 =?utf-8?B?Q2kxM1dSL3hVWjhNS3NyamJScVBlejNyUFFlUmZJVUIraDJvT2tEcVRrdUxO?=
 =?utf-8?Q?0bESJ+Ve2QxpfYqb0hLIm3L1Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a47613-62c7-41f2-c250-08dd44611665
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:43:13.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyfLuxxtZgTakexzrE3RzlngMssn+GC9TpX/uKhWGMa17nXJJMUV2jP0+LlLt73naQYTaWGNbbqYE2TdmZ6paMC0NAHLxNQTina4Va1Y3Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472

SGkgTHVrYXN6LA0KDQo+ID4gPiBTdXJlLCBoZXJlIGlzIHRoZSBsaW5rOg0KPiA+ID4gaHR0cHM6
Ly9taWNyb2NoaXAubXkuc2l0ZS5jb20vcy9jYXNlLzUwMFY0MDAwMDBLUWkxdElBRC8NCj4gDQo+
IElzIHRoZSBsaW5rIGNvcnJlY3Q/DQo+IA0KPiBXaGVuIEkgbG9naW4gaW50byBtaWNyb2NoaXAu
bXkuc2l0ZS5jb20gSSBkb24ndCBzZWUgdGhpcyAiY2FzZSIgY3JlYXRlZA0KPiBmb3IgS1NaOTQ3
Ny4NCj4gDQoNCkkgaGVhcmQgdGhhdCB5b3VyIHRpY2tldCB3YXMgYXNzaWduZWQuIExldCBtZSBj
aGVjayBhbmQgZ2V0IGJhY2sgdG8geW91Lg0KDQpUaGFua3MNCldvb2p1bmcNCg==

