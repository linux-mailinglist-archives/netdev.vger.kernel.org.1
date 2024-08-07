Return-Path: <netdev+bounces-116317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8D949EAA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7041F2289E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36F3F9EC;
	Wed,  7 Aug 2024 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rJOu0NiC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD1A269;
	Wed,  7 Aug 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002617; cv=fail; b=IHjkqbakYw8ksY02/7fqyPxqjdAf/wWJW0GeTdWpmFB39X5Nyr4mF6DnsHA8zIb/2xMU9RpDPV+wugW6DgZ3cuS7rnLCmHUrkZmg8mGfhG7qAgcHoky35DTmGA4SRcEWcrQ6uT5aWg5h0EQ8etriryS/HbP3rKu6NhlYZ0M7I+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002617; c=relaxed/simple;
	bh=R4f0DY0XZaE1WpR9pmpuX5zibnM1/6YxgM53HKpP+LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnhrqlg3YqXZS58Wo+/Tdsvny8yz1epLBkW2XSyJCiF+0xTKag8hoFb7XVRUJBYWcwHAY1UfmaIqIQNg31D/6dNmAFJLo4JYt+Wj7MVJ/r3jMpLN3NiOO0LnwECLcKk/fzReV+EgUftGQQqqXRl4h8JvKS2tS4rjybuZ5XPsj/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rJOu0NiC; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrgFoZvpRIIFtrpszrjHXfayWf5Rwg49HtK9rlD5tQw/TfQYRHK53B4nAf7AUz7e9uVRG/gXTuyjgLmnXo8po57/TS4oCeX1rP2eioGesbdCE3To4Q4bJRJulzkhnBz30GxXarQAX2w1Qlal+bcwcxmWvBlC4XxNfZBOGVOy0CfBMiomuXuuDFt94N2Suzf6VTwY+jsOmtKAf/3G2tdbgCEqToZm3muWxotU70gxRjFqBK3J7FB3Ml5YmqAEw4H7WYEV56Qf30jDU1S0ydHumzPj0gFjlyNfVSHKjT0fmgw/q3JXaNGgnHiJcZAjStWqlefet2vMj1CkRvIqnQkaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4f0DY0XZaE1WpR9pmpuX5zibnM1/6YxgM53HKpP+LI=;
 b=HmbChWr2Lqwrz/pIOqQFFOjbZSDudYHQ0bTVHhZlEXjgGmeMKymwNtHmmCQCgyiazR0YGC3dLzza0OOYO+PT6YI8XJprOarVV0fPqKNYSSk6ufjXv4TMU/jyHHs/c1Dg3j+eHEqaEMBXI1k/LiCvWhvCg9AEXTRsduHPIqNfZ/JGumPbr5y2Iw+beAjimRa8Nm6ksqRIlldQyWaMHDDquPjJUlN76wo48qIl7RvZhtuUEQJtm3lL/3efKkaJucH2R6kESSlHixMQl+c6O7EEQcGxCR7ClEWzArVS66m29kAebrK/qlZ/njjImDzyg0EaRCkzYnz/wnQGdNYZ9u50Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4f0DY0XZaE1WpR9pmpuX5zibnM1/6YxgM53HKpP+LI=;
 b=rJOu0NiCrEHltvAYe/r0dEc841PMidjPwL7gEWOZhI1/IcR7LbqPkUk9XV/dm/hUX1sDqRnUbaTB6xCx6Bmg5m/khMf3SX7wxkBw5gxIz2I81y9DriRPL4uWoSVExObdeabDY3K7ti2bFd+JaJXfkOb63iYrBXkVjUTETqaPFKg/k6DOU0kbVSnoWGytyrJ5hDi7SwesKRC/e2pDAnetkQlYKgk2s5NBrDf0nnc3DoD+z0bPMeOq54rdwCawTCvGtLN6VzWWNErp7EFwKYjL7oE2w1ENCi+iz19L3ZIm5+lbGvYf2y2bYg5/wYS7eT7s825beusetuVqzCF8woqeUg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 03:50:12 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 03:50:12 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<conor+dt@kernel.org>, <Woojung.Huh@microchip.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>, <marex@denx.de>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/5] net: dsa: microchip: move KSZ9477 WoL
 functions to ksz_common
Thread-Topic: [PATCH net-next v3 2/5] net: dsa: microchip: move KSZ9477 WoL
 functions to ksz_common
Thread-Index: AQHa6ASVt0mbWyXu2kisxm8Srmb8KrIbKnYA
Date: Wed, 7 Aug 2024 03:50:11 +0000
Message-ID: <fff0c913f216f622185631312a254627869e9dae.camel@microchip.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
	 <20240806132606.1438953-3-vtpieter@gmail.com>
In-Reply-To: <20240806132606.1438953-3-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH0PR11MB5048:EE_
x-ms-office365-filtering-correlation-id: e84c36d8-0b90-4c77-0152-08dcb6940a11
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?anM3TWFEQlJoMllsdG9xbUxidmVMTHlWVWkrOHYvNlhyQVIwNlkwU3MvWHlF?=
 =?utf-8?B?QStScnVySVFNeUxBZUtpZy9LckpJVmE3TGZOM0QwdS9ZdkZhMndFN004THd2?=
 =?utf-8?B?bW1HMmJqZi93NVhvbVdxb0pKamJ0cWptL3hRNFpvQWRrQ2Z3TUQrY290aGpJ?=
 =?utf-8?B?d2xMNzZIZ3FKNjBsZTVNZmZkMmNKT3o5QkJ5am0wa0Nyc2c4MDRpMFFKK3NV?=
 =?utf-8?B?aFZ2emlTWExjdGdzUmgyZG4yRXd1cThkYWZOaGVRdTRsa29obkpheldvcnVV?=
 =?utf-8?B?K1BWYWowMis3NVFNSXRkMit6V3NZT0VBNXAwUkZud3YxU0hjTDE0eVRJQzRZ?=
 =?utf-8?B?U29wTjByMDZhcHdCb21WRjNqQmRtUk9jMEJuREFuZEFzVE1lQ2Y4QVJDYTBp?=
 =?utf-8?B?eWFLVGNyd0tkUUY4cFA4S1ZJMHZBSXpUdkFKbmhSK1BwOTFtSEtpcVUyMHhs?=
 =?utf-8?B?T01zem5CWjVXTHRBVEE4NTNiaURFeFdZaHFPSXlWTUQzRHJnOUJUTGNGaVJm?=
 =?utf-8?B?V1BUc09KbDBRTCs4WmhTVUg1WEJrK3JtSmZIRnBXaW5sVVY0L1VZTGpiZ1BO?=
 =?utf-8?B?VHBnSWs1V2NSMGFjWllka0FkanMzOThMVk1IYS9nUkg5emZQell6cEE2MktN?=
 =?utf-8?B?M211OWtvNWNFSTVYdTg1akowWUxUVE5HcWpnTzVyZFkydEVnSlBQNU5CL2hE?=
 =?utf-8?B?RzMxbHQxK2piU0JNRXdIc0Rad2c5R3c0azlNMjc5UkFSTm9lakxaVTJleVFE?=
 =?utf-8?B?L2tCWmx4OVNEbE5yRndIdTBMWHF4aW1WSjV4cFcrTXNmRTB2aXA4YVJhdU16?=
 =?utf-8?B?NHZNWGE5c09YQWp6Ym4xaC9EUzVWd1g0bzZid0w4WVFWK2VaY1BjakFZeWN0?=
 =?utf-8?B?QWE4ckszTStjSkxzV0ZvNkFJT1RzVFNka0FnVmIvZXRybEgybUQ5aWlmR0k0?=
 =?utf-8?B?M1E2Uno1THlKcXArK0ZDNHJLWk5QdHRzMVFrT2FBUzM5YVhHRG5tQWcwQnV1?=
 =?utf-8?B?Sjh3b21VT3dYdGhlaXNnR0svOFlzeDdxc1lVdWVXQVRtQTFKU0ZuZDFKTWZ0?=
 =?utf-8?B?U0RKTEZuRU5MU2J4RzFVOGwrVXVnTmpRWktyMEJmQTI2bjFRSm11TXNxQlBv?=
 =?utf-8?B?S1crZUdhdXdqd3lNdndoc3FYTkJaOEFMZVdDd1dYaEdYU0RGTjFtWEdwQStR?=
 =?utf-8?B?dEdoaW1rTzMreHhJYVM0YWF5eEk4cWFqOThpbDJjVG1SbUZVd3ErZk5BNVEr?=
 =?utf-8?B?WUErY1dvSEJqVWZSYnJEWU1EOWlrdVdpUUZRUmNDbjFqY28xem8yZGJPa1c3?=
 =?utf-8?B?STBrVGxaREVCdjBKREVXOGtwQ0dmVHVhSHVERmlzNDdaRHhINDFMMEJSc1lt?=
 =?utf-8?B?aG1MSDk2MEZIOURVckhpVStXMXB2eURVeVNoNzVvVjlkckQ2OEM4d0c4dmpE?=
 =?utf-8?B?dnJDRU5tMk5aQ2oxb2c4OWo4TmNjRndEdGVWamxTb2xpcFIzcUoreUdsaXJ2?=
 =?utf-8?B?VXVxS2JlWjRxY3BiOXRsRnhkSUFoM1RONDhLUzZhWWw5c09XV0pQWUdRQUxY?=
 =?utf-8?B?V1p6b05sVDZXbkRiUXdnSFFvUDF1ZTBYRkNoQ2dhUHBUV2NYSm5iaDhGUC9x?=
 =?utf-8?B?WW9seStuWGRMMzRrUGJSeUVGQ1VFbzRqMEFjRjdTVmhCc1lhbktTMHFLSzNv?=
 =?utf-8?B?TXhFUndGbEZiMkFua1BZMVlHYXVGK05zQlMyZUpzUnVxSjlWMkFHSmJPU015?=
 =?utf-8?B?UkRoVEdXb0lFNjlhZUgzakZCWFVnVUlxaVd3cDlPRHlTL0d2WGJBZWRoUGFn?=
 =?utf-8?B?OWlRM0x6czNxQXhUaXpmVjZQZ0xrU0pLbllJU0U1cjkrVlFneUovRWlpZml5?=
 =?utf-8?B?MExnR08rVlVzWjU0N1FOWmRLZU1mWXdhcmk4S21Ra21KdkRjaWNDQzZ3NkRl?=
 =?utf-8?Q?p88RgWbj8co=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGdUUm40UGQyTENsWCtPQVA2NFZhKzMzRlQ0Z0NDM0Q2eHhDY0NEVTZsK1VZ?=
 =?utf-8?B?a1E4TzY4N3kzYUtKc1JjZkc0M1FOR3VlRkUrVlVLZW1TbWp3L1VMRnRubjI0?=
 =?utf-8?B?V2d2eHppemNFVUZDK3lIeGlybFpqSDJXSzlDRWpvbi9LWSt1WUxtcWdYYjBP?=
 =?utf-8?B?cGNwbzlYVks1bVFxU2ZadUJOU00vcnNlRG1UdTd1VXdkY3gxUWt3aVkvMm1t?=
 =?utf-8?B?MHhKblVmc2hBT0xEOUJTRGlScmtoZ0QvQXAwSURHalBCN0E5azdWMmZTUi9C?=
 =?utf-8?B?RGtQdG5SVjlxZ0RZajltd0M5OXo2UEJTSDlDZWQ0VzduakdWK1greFQ5aDlj?=
 =?utf-8?B?ZEFmc0NxSEJBcDd5NnpFaWFUUnlWd29uUmNMYWhBalcwN1JjUFc5WVVqTWJF?=
 =?utf-8?B?ejVYQm9BT0M1TzFnVGhxL2dtUkJoQm1XczFaN3BHYkVaWS9iUGdHMkJVTFNz?=
 =?utf-8?B?cHRrc1BIeXVMa0x4azVwYWRRd05nNXIxcHJaaVdJaEJlbjhwR1pVcitQWE0y?=
 =?utf-8?B?azZ4TlA0VTY0bmFrUDBIWGM1NTNTbGxwQlVNdTNsRDNSTnFveUx3NFRHYW1P?=
 =?utf-8?B?eGpQeGdUdVExck1TckFtMXZsSGlrMVAvNW9mL3RsMmg1NGF5WHh1eWZESnRV?=
 =?utf-8?B?SW1ROUV2SCs3eER5enRVY0tCRzhGY28vWGMxQ2o3VlptanR4SDlpckdRS0FJ?=
 =?utf-8?B?b2pHSDNSNlBsZ1pCbSt5WURCNS80N1RYZklITkFIRWFuRG1peHVIMnJEK1hR?=
 =?utf-8?B?bHpIZlBrQ0JhZ1ZaTXhqR2RXN0U5ZGhRaG9obGlObkJyT21qb2xFVSt4a2ZJ?=
 =?utf-8?B?aE9zb2E1NkJhVlVtbTZVTDRlN2I5ODBacnppRFp6S21sYk53QjZucWhOZnFp?=
 =?utf-8?B?eU5qSkwwUldWb1dGY2wrQnY0bE1BVXFkSDljbk5LZWYwYVMvSmJEZm1ZWVZx?=
 =?utf-8?B?QmJqT2x2N29GTWxQbkQwYlBjT3RwS3NkZldsNmhlWjh3emZvZVNlWEVVUXFR?=
 =?utf-8?B?NGJqcDVHb1lCeTBSQk5jdUYvNHFHK1IvSnFUWVY4SnJ5T3FYTkZDY1hpNUFs?=
 =?utf-8?B?Y3NIc1FzRmdUNk9laEpDZ0NGci9BOXdwdVFMcGdkZkdNRWhvVm5XcjV6Nm4v?=
 =?utf-8?B?d29LZXVPK2hnVlpVSGEzWVlrYlpTMWRBQkNOZGp1eWFXdmZmbVVTZEdsZHpw?=
 =?utf-8?B?Z2thVFFTMDJpN3N3VWRCanQ4b0pBT3FlRVJSSWhNUEhacWFUU2c0dTRFVStw?=
 =?utf-8?B?MUhCOEhJQWhmSC9ScHhsSktpOWE5elNNK3hRZ3IyS3hOcDlieDNyK2V0RVdy?=
 =?utf-8?B?cUp2V2JHSTRzelA2bWxPejhvU2loamlQc2tHMjMxY1h1WlJJdWF4SXZXem1T?=
 =?utf-8?B?Yis3K29xK1pzZm9hd0NDUjc0QXQzRU1ibjVmNnBFNlVURXZMOHMvdHFCbTI1?=
 =?utf-8?B?TFpDeUZ4QnUzWlpWVGdBZEIrWGkwMmFNc1RXZDAwZlplMTEvZDg3NFJFamcz?=
 =?utf-8?B?TW9XNUNzdjUrcHdBRHJHdFV3WkRKdFRkd2l0b0R4WTZoUXR3V2VBczhXdTBQ?=
 =?utf-8?B?aXZTMTJCU2FhMnc1ZFgwV3pkOXhkVXNVV203REFZVzhZWVhxWEJDeHhHaG4w?=
 =?utf-8?B?YkpKbGFXaXc0K2JZc0ZvTHVHa2xQZ3V4dnpTd0RVbWl6MmtjdUZwWXRVdUpQ?=
 =?utf-8?B?bUVEWll6cFdEUEthTVZKb1JjTHlBeW9zaUlnUmNWZ2xWUFFTRksvcVpENFdI?=
 =?utf-8?B?UGc5Q3FjUzZ0MUJ2YWFLYTlseU1IK2J1eWoyYXhuTGpMaExVdldDUFludEg5?=
 =?utf-8?B?d0dMNnpoQ251c2dnZW9JbDhYcitFWlR0Qmo4UHNhQXNCR2o5WWg2bWhFS240?=
 =?utf-8?B?dGRPS2ZqamttblZoZ2gyRC96ZSt3Z1IzdWhWUEsrR0w5NSs1MVZ5VElJMDZp?=
 =?utf-8?B?WWtpdGM2ZkFIajhRNjR1RzVOZ2p1cVMvcFFXdDFlVyt0VjcvL3dmc3RSamVJ?=
 =?utf-8?B?VVk1Q0F2akN2YjRrVGlvMTJzRmhkK001MzBCK3J0cm53RkRCaGFMRHprb21r?=
 =?utf-8?B?eGZZTXYvZUxxSWVDZlI0ZHRaSzhXd0tkQmlvWC82c1RoWTF2K08xWVROQUQ1?=
 =?utf-8?B?dElzZ1I1RjdVMklCNzZlNE00c3FYN3BhaWVBRW12dlo1MXl1SzFDalhLbFp5?=
 =?utf-8?Q?+BVBuVNiJEcMxiUF/jHIXxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D63BF5460AA549ACF94378BD96EE90@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84c36d8-0b90-4c77-0152-08dcb6940a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 03:50:11.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4P7N1JSXamihFPBhNVywzjm+K7nMExlkpGJfPOYzCes1IAMoO26/fyOofMz8trAiD9DSI6mef9++gg8SqvFRF8UOgUQkhLVvyk/ARmz922M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048

T24gVHVlLCAyMDI0LTA4LTA2IGF0IDE1OjI1ICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IE1v
dmUgS1NaOTQ3NyBXb0wgZnVuY3Rpb25zIHRvIGtzel9jb21tb24sIGluIHByZXBhcmF0aW9uIGZv
ciBhZGRpbmcNCj4gS1NaODd4eCBmYW1pbHkgc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFBpZXRlciBWYW4gVHJhcHBlbiA8cGlldGVyLnZhbi50cmFwcGVuQGNlcm4uY2g+DQo+IA0KQWNr
ZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg==

