Return-Path: <netdev+bounces-243371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886CC9E2EA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D563A4865
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369CA2C1786;
	Wed,  3 Dec 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WjF/jxKA"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012071.outbound.protection.outlook.com [40.107.200.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE12C0F9C;
	Wed,  3 Dec 2025 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750130; cv=fail; b=V0nP7G4S9D8nPiGS4fhay4LuHIRSpFYDG/0kPKgqznk51N04Q/pBBFDxdER+Kch/OSqn5IkYuRmrh/yd70XchMxHRhXkwd2AqUKnMhMyqUYH8Wxtc2kA4SLiZNauIHu/xb8NwKuM42UJCt7++jc+CaZPlbxVX164SRtdEN8CxGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750130; c=relaxed/simple;
	bh=gSjOco/L0zO64QfLv825xr0J1hSIKTAI9dShBgaHUdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BwYaTKkX0nFYW/xwJFnrZadBDkFIJ1oGfdO3NhAZb+vkZix/1P0srK3Z8nz6+tAtOesmP3f/T4a7NqpLYVRNLnE3UYjn9ZxZQClD5I5GTisupqZ589iN/QJOLbXB4HiOTQEC6N3614FFV9EaFKnQ8jEOeaXPeoZTtpwOtClN60E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WjF/jxKA; arc=fail smtp.client-ip=40.107.200.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQEueW4MI+zayOWEkISXAE50DU7Plu74Fis3cS9x6R2OTv5XtEgh923deAPpQaLuOLG5m/L7RtqLCsvrGMYoMUBwy7ZN3hrsCZgO20ZD3/HHyysAiY9R7n5a6/dSI2y7R2HZY2JntU2fsdgP54XVvcqdnzeYVFE8pyqOUVS198lZT8PRv017EePHcmHHOb6mMnEvTNZwDY8oPkLddcQnzWZchJCAa2F/rPyq1emwCF20BkBSWQruOfn7vINEmdnzHlVcrAxT+IjWb1xvUtdMJP59/aFnozi25EVr9dJElj+oprWbH7d7hwes2QKlFwXJbz0cChparPlTs2QD/ithqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSjOco/L0zO64QfLv825xr0J1hSIKTAI9dShBgaHUdU=;
 b=E+YJc02m8Kf9CRYeVGlk1zig/j8lNI27oAhVa1NJRBK4g0w0agJ6D7dnDgboMcCrxomkcK9TldVBPWItJGY/67V6VnCghC6NKCHHXNHjY7TsSRMHU/By3x1hU9ewEPKoa15mMgjN4kLNC+OS/++BCsmOeUq0ez9sJIdzNqH10q3vUXYytDk8lGYUtqKf4u5nuPQJj/Fk53IWoWNpcoY3KgFehmzikjOyWK8bzexL/eQp8ZkYiZSpeOVj2gbTJ0hNtY7cVY1PFprUN8LgSEorynTTmm+zJHtI4I5MpJd4tKScPaCgamwgS7N4aaR2cq6tGCDz320rKKcOyvvB90wg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSjOco/L0zO64QfLv825xr0J1hSIKTAI9dShBgaHUdU=;
 b=WjF/jxKA/Tpjt7Knv4PulR08AxqjSF6j0Mb98V51fr87/6mdSA+efnPbTcd9nJdiq3u1sO2psMRbYclVpZF03yFCIahoJhfT3U3S/QA2zKVE+gm8HRnI3tCnsJTPDRaMzZEd+nCVO7DxoPUKYp6/tt3ijDqExWt+h1fsKeyvvhTPxixH7b+25wXEsD5Hyu/JKkJY7EZJu+Kss6V8lpiVyCPJdhoxLZJiv9dWz/zpMxRjn0YxzMdfWHEFsAMH9E/FLGu4EBqhUuF6rNAMRVnLwWyVXbLDdTRHHfvg602jxPaXqOFDEi5UNyw1GiXidqqcIWLDawpAD5pDn37i+uZZMA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:22:00 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:22:00 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <horms@kernel.org>
CC: <piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Topic: [PATCH net-next v4 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Index: AQHcYnHyfDQnfxRtA0alWZXRh2FD67UOipYAgAEMT4A=
Date: Wed, 3 Dec 2025 08:22:00 +0000
Message-ID: <4c4e1431-0018-4fb7-a52d-75b71f9cea95@microchip.com>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
 <20251201032346.6699-2-parthiban.veerasooran@microchip.com>
 <aS8SFIN_LZsoyAKW@horms.kernel.org>
In-Reply-To: <aS8SFIN_LZsoyAKW@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ1PR11MB6275:EE_
x-ms-office365-filtering-correlation-id: 54081955-c342-4a9c-de82-08de32450816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGFrYWFJWktwT3RYejdMeG5QRWg0YTZvemdLaXgxbUlZTGJPVTNGQSt3bEhG?=
 =?utf-8?B?dlRsUUQ2Q0k5d1pRbyt3VGNSZ0puWW9SanFZeXJqWnJMQ3VXeldJTlVIQlZO?=
 =?utf-8?B?TkgwZklSd0dCb1QvUnJkSVR2ckJoQVhkZ2ZBRXo3bGdkV2hRR3FzM3o4U1Ru?=
 =?utf-8?B?UGd1eGZtZmdkOVorbUFNODVXWW9lVkNzQ2RENWJoL2ZhSWVMdWk2ZjBaSDRh?=
 =?utf-8?B?TjNaNFhzU1JESzkweFloYjQwQmM5RDFOc2t2Um9LenFiYTY4NS9OTldqNUZT?=
 =?utf-8?B?Wm00dm15NGFWRFUrZjh3N2xWU1c4ZmlDODVjSGxpZHRsbkdMMkU0Q28vTHYw?=
 =?utf-8?B?TnhiV2FZaGd6WSs4dUFEbGV4YXpZMDZadEIxT0VsTFVnMk13cmdVdG9TVnAr?=
 =?utf-8?B?bDZ1VitQRW1ZdUR6T2dyWEdTa1prSDc4Ry9mN09ZZnZxMGd2UklBeTFZdHdH?=
 =?utf-8?B?L3AwcTk4V0NpdTdTWXgyd2x4Zk9pVXRoYnlzWXdISkxrSUZITkR4V3k4TEYx?=
 =?utf-8?B?QVI0ZmF3Mkc1enNUUDN0NUtXZHMxdVR2Ym1jR2hxSnlUVlRmV0FnRjF1NGdt?=
 =?utf-8?B?Q1A5NENTa1ZEOEd3TDFxUDZJVVFjdExlMGtQR3AyQlRvWml5OU8vemNtQjBZ?=
 =?utf-8?B?VTBOU28wa1lsSldCK3ExMEhaTzJ5eEpWbXROVDZGRS9UOTFuUTBHekxtdlh3?=
 =?utf-8?B?Vk9RbXBnZ1hNRlRQUnZZNE4rUGtPaTJUWE92ZDFKR2ljUkFOSSsrOGJUVGt1?=
 =?utf-8?B?dEErSytvYWpWWmdPd1hEekdZN1RIVEEyd3Bzd2Z4ejd5bzJSUGJwUjZ0NHNB?=
 =?utf-8?B?VTFjMWlKT1RzYzBuZVJnZGdwZUxHTzhLUkF0ZzBRUEJFbVE1QTFGWElaeDEv?=
 =?utf-8?B?T1VMenR0OC9KdHlhRmdpRkZMSUFUTVkyZ0tBdjRGcjR2QUpMTDVXQkdWZHF6?=
 =?utf-8?B?OTRPZHhhdUVaL2twNDg3UVRkTCtpRlhNcTBkL3d4UFpkeFppR1dKZXlQbmZu?=
 =?utf-8?B?L0RjenYzb2ZOc2JaMHZUQkpKcEhxNnd6Q2FJb2ZoempjU2FWSVpVTEc1MFI4?=
 =?utf-8?B?T1JRdEFwVFBoQ0tLdEVKbDhxRTVxeFgyMys2YzRKcDZmbWZuSHpqbGRpaTM2?=
 =?utf-8?B?L0NVZko5QmNoTHB4V3FXaDFwQmtHYTJwbmhLKzlOeXBkY3k3YjBPQWtyYjFU?=
 =?utf-8?B?QnVLNFp0NTgzSHdJSjlxQTBlb1lQTCt2UXIvK0JCTjYzbFg2TkNHUFlOQVhU?=
 =?utf-8?B?K3NGQW02TnRtNHJrQUFNZ25UL1ZJbFpSQU8zTHYvRUUxd01MS1lFdUkwZGhk?=
 =?utf-8?B?QmJ3STBQZ3ZEOTFHRE15NkN6SUxtbThBczZ4SE5xazhMak1taUp6NFZFdnRP?=
 =?utf-8?B?aGtJWVBXK3JGL2F3Qmp6a3BDU2dSSDBzL0VjS08zU25xQWdUM05kUWxFMTdu?=
 =?utf-8?B?Z0ZLcWQ4b3pscTVrb1Faa0cvOVRta01PRTVJMHRuWnlObUJXOHZ5S2plNkRy?=
 =?utf-8?B?Y09ZRElVQUE1MjZ2WGVFaVlJcjE1a04rWFN0ZlAySDllb0RXUGxnaXNJY3ls?=
 =?utf-8?B?T25Dd3J4Q3BjNFpCU25hcTJVN0VWZHUxaGFqN2pnMGRPOXFLZEs2c3d0Z3ZD?=
 =?utf-8?B?MjVwc0owUVRLQU9WYUZPeFUrRitFQW5wVDZ5RlVvU2xJajZtTHBWaFQ3QUVE?=
 =?utf-8?B?dC9pTndOOUZHOTNyMnNFOUNFcTU4aFZYajF2VzdaUTZFYmdubS83eDYySnd5?=
 =?utf-8?B?bkN4cksyNU9JYzNleEtNRTN5cWRBUDM0bUM4RmI0NnQ5MTFSK2s0cnQyeWtO?=
 =?utf-8?B?cDM3dHNKaXgzSi9JMWRFYUtvR1RFWmdobjkxTUUvUXlrMG8xWEZKRktRRkVt?=
 =?utf-8?B?MUkzL1NFVWZ2czZ4b0FGZ1NmejhSY1F4S3lQTi9UK2hiSWU2TWh0eWsyZjFm?=
 =?utf-8?B?Tnl4L1E2Zm55THhuMXZwV1VCcjcrczJPMGFxZjY5N0FWM2dqWW5xL2hOOXZE?=
 =?utf-8?B?ZDBqTE8rY3JwVlBubHhpTStraHE0M1BvMzJUV0pNUHVvSCthREk0WjByMThZ?=
 =?utf-8?Q?EZnTPe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1VJUjh4dmZMRDYrMDJFZmFTVVd3b3BtM1ZTL2NFQnRKU0dNaXFDYlRmVVRC?=
 =?utf-8?B?SmtjOGw2aXo2UlZ0TXpXak9jZTlVcU9qR0NKU1lkZVNLTk1TVkFoWkhpanY2?=
 =?utf-8?B?WndDS0ppRHBnb1NSblU0M2Y3UzhScFpkSDJERUxuU0RWZUpkak01YW8rdEhp?=
 =?utf-8?B?aXVIeE1hSHR6ZHFxZ3N4ME5GY1l0RndqZzFEc1dKT1l2ZS8xUW1xM1JUVVNL?=
 =?utf-8?B?ZFBsaVZ1ZDBxOHRwYkZVaGx0VFNzMWdpVXhDT25SdDgreGRWdUVyRkRqcnly?=
 =?utf-8?B?bHROb056WXhoWnFva3l3VWJYakdXRUhhdWZ0L1JWejMxdWsxcDExdVVDVDZL?=
 =?utf-8?B?RmdCNEk0UFZiTnErU3p2TGlTbG5waExIeE1XTkZqTFliMmhuY1p0czJoVHN2?=
 =?utf-8?B?d205ZjIvallJbWp6TkpxamtnTmZpNEdvR0pjOHBXd2x3Sk1TNmduYk1GT1pY?=
 =?utf-8?B?bDdZbEFZZk00U0VmSi9IZFd5Z0RVVHB6VzVWMXczRExENDhYbmhIUSttckZC?=
 =?utf-8?B?WkhLcVhBTXNLOVdYMXRNWDVjSEV5RmRMRlJ5MU5KeU12aVJEdHB1ZXJneHE0?=
 =?utf-8?B?dEVER1ZsNVVzazJoT0dkamdaLzYyalNaS3ZhdzJ1OTB1WVF5VERXcjRvdTAx?=
 =?utf-8?B?NWZSMkVpS2JxRm83NDhxMEhjdnFYTUFJOUdTQk1heDA4ZU1pV0NsMkxsSjlo?=
 =?utf-8?B?TGY1VitiWEVGSTdGN25rRlAzU25BSVJ5QkJUMVpHZ1lYckoxckNac2RqYkJ0?=
 =?utf-8?B?R0xRcVJIeDNoYmE1UjFHK3ZLOG85KzVhV3Y3dlpGM0U0NlppZXJ5U3JLakV2?=
 =?utf-8?B?VnNOckh5SFdDU0lYWTNkcVFYU05hMDR3K3lGbmI1MURjczhqQ3BMTmZuQlRD?=
 =?utf-8?B?V2hWblJ4SWl5S0ZkUDNYZm42bXJnNWRWMDdkWU05SXd0NW0rUjUyQnBPL1ZJ?=
 =?utf-8?B?TGF2NGhUS3k5Z2NTcVpaUjRpSUZFSXREdlhBNlExcTZXZ0ZISE9RUk1UcGQ5?=
 =?utf-8?B?dGIwVllkMHo5YW5ISC8vNnZSRHdQODFzaWdmRE9zQllTaWppaHZFTlFPeHIx?=
 =?utf-8?B?SmhCRi9jYkpzTUhIRWNzNlk2Q0pFQ21rWEt5M3hsUnl3UmJlYjRaZk8vRjcv?=
 =?utf-8?B?c2hGYlpkSDBXcTgwdmVzUVZDN1B2UzQ1Y0dQQjNJUkJab2Q5M25XcHZCUktt?=
 =?utf-8?B?b2pXeitudjN1YlZDL25SaW9BU1NsOW02K1hiZXlvVi9xQ0I4WEw5MlA4c2dy?=
 =?utf-8?B?RU1MN1oyNTV2Ulk1eEhyZ0hzVzNYYnB2T2p3a1ZGakZEbnVYQlBMTS9zTFZH?=
 =?utf-8?B?MStFQURtM2I0RG1WVmMzdS92UXJHaXp6dnptVDArZ3U0NzBERXFsSWI5RS9w?=
 =?utf-8?B?N1Eva3doTFZ1MS96blRUN0ZIOEY2cE0vSklvN0NKVDRsdjZEY0poaFJUUVl6?=
 =?utf-8?B?RjEwWitKUW4xcVNJMnU1YXF5MHRycmNSR1YrYVZvMFgvR3FpaGF0bEZRY3hu?=
 =?utf-8?B?WHYvOFBXOGYxc1Z6ZW0yRWthLzdneHp2RjF4K3dBb21lSWJKeUlvL1hnSmx6?=
 =?utf-8?B?TzRZaXEwRDdxVWdUcWFpNVlSTEx0WnZ2SzAyU1hYUHNlRndsa0lQUFBWTVF4?=
 =?utf-8?B?clhQOVhTMUtmZE1vaUJoZUllZ3orQVJTM3ViQ2NvUmlodVU4dktGRnJDUFRu?=
 =?utf-8?B?MTFtZU5NNk12cmJLaStlYlJjNWdBUElvcXFzRktiWklhVXNCZFl0QktkTVNH?=
 =?utf-8?B?M0J6dVZ6T1E5OCtWRVhBYTdLVHBSVyttMWs0Rkw0ZFFUcTAxN2NJWHZ2WWRU?=
 =?utf-8?B?OTVGTnpweHQ1MnV1RXVzOE5Wak40WkUvWjVsN2REWDlBUmJnSFRkYXBJbHlC?=
 =?utf-8?B?R3RwakRTSXlHNkdPSFYvdHJ2d3M0YmY2bEVBWUhaQ1JRTWY1UkFLOHBtVS9Q?=
 =?utf-8?B?bUtxU0lCTUZuYXFhU1pjNmpqZEl3OXNzbFpjV1Uzb3dLT3RYRlloU0NpbDVQ?=
 =?utf-8?B?TFZ4VHBiWmtmK3RRNVlsYktLQ1VQdGVUT29UdlFhY1hqSjUrT0hGZzNreGhO?=
 =?utf-8?B?bFlkdVNVODd5MU02SUxESEptUHdrSndEWSs0VEFNNGFlTFEvdHFmcWpUVFRB?=
 =?utf-8?B?S3daMU8wMEw2UG1zUGxVTDFJdndIbm9xU01tY29LTUd3RC82SC9pZzZITlRm?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <722DC76B7342FE4CB22B7C481FD25CDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54081955-c342-4a9c-de82-08de32450816
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 08:22:00.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVs3R/Dzn6MrN2dyZksJn6XHqF2Y3cY6uL3ws1M0vrDkVpnQX2NSN+UwXfe7DEtaqVsDjLuHwrDNzhBDPehLtPcrBE6Mt985cprl+Ab7E0rLqCQ6yRoQhPOuRpa53N49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275

SGkgU2ltb24sDQoNCk9uIDAyLzEyLzI1IDk6NTEgcG0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIERlYyAwMSwg
MjAyNSBhdCAwODo1Mzo0NUFNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
IA0KPiAuLi4NCj4gDQo+PiAraW50IGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWlfbWF4KHN0cnVj
dCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+PiArew0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+
ICsgICAgIGlmICghcGh5ZGV2LT5vYXRjMTRfc3FpX2NhcGFiaWxpdHkudXBkYXRlZCkgew0KPj4g
KyAgICAgICAgICAgICByZXQgPSBvYXRjMTRfdXBkYXRlX3NxaV9jYXBhYmlsaXR5KHBoeWRldik7
DQo+PiArICAgICAgICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4+ICsgICAgIH0NCj4gDQo+IEhpIFBhcnRoaWJhbiwNCj4gDQo+IEkgdGhpbmsg
dGhlIGNoZWNrIGZvciBwaHlkZXYtPm9hdGMxNF9zcWlfY2FwYWJpbGl0eS51cGRhdGVkIGNhbiBi
ZSBmb2xkZWQNCj4gaW50byBvYXRjMTRfdXBkYXRlX3NxaV9jYXBhYmlsaXR5KCksIGF2b2lkaW5n
IGR1cGxpY2F0aW5nIGl0IGhlcmUgYW5kIGluDQo+IGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWko
KS4NCj4gDQo+IElmIHlvdSBhZ3JlZSwgY291bGQgeW91IGNvbnNpZGVyIHBvc3RpbmcgYSBmb2xs
b3ctdXAgb25jZSBuZXQtbmV4dCBoYXMNCj4gcmUtb3BlbmVkPw0KWWVzLCBJIGFncmVlIHdpdGgg
eW91LiBUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4gSSB3aWxsIHNlbmQgYSANCnNlcGFyYXRl
IHBhdGNoIGZvciBkb2luZyB0aGlzIG9uY2UgdGhlIG5ldC1uZXh0IGlzIHJlb3BlbmVkIGFnYWlu
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+ICsNCj4+ICsgICAgIHJldHVy
biBwaHlkZXYtPm9hdGMxNF9zcWlfY2FwYWJpbGl0eS5zcWlfbWF4Ow0KPj4gK30NCj4+ICtFWFBP
UlRfU1lNQk9MKGdlbnBoeV9jNDVfb2F0YzE0X2dldF9zcWlfbWF4KTsNCj4+ICsNCj4+ICsvKioN
Cj4+ICsgKiBnZW5waHlfYzQ1X29hdGMxNF9nZXRfc3FpIC0gR2V0IFNpZ25hbCBRdWFsaXR5IElu
ZGljYXRvciAoU1FJKSBmcm9tIGFuIE9BVEMxNA0KPj4gKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAxMEJhc2UtVDFTIFBIWQ0KPj4gKyAqIEBwaHlkZXY6IHBvaW50ZXIgdG8gdGhlIFBIWSBk
ZXZpY2Ugc3RydWN0dXJlDQo+PiArICoNCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHJlYWRzIHRoZSBT
UUkrIG9yIFNRSSB2YWx1ZSBmcm9tIGFuIE9BVEMxNC1jb21wYXRpYmxlDQo+PiArICogMTBCYXNl
LVQxUyBQSFkuIElmIFNRSSsgY2FwYWJpbGl0eSBpcyBzdXBwb3J0ZWQsIHRoZSBmdW5jdGlvbiBy
ZXR1cm5zIHRoZQ0KPj4gKyAqIGV4dGVuZGVkIFNRSSsgdmFsdWU7IG90aGVyd2lzZSwgaXQgcmV0
dXJucyB0aGUgYmFzaWMgU1FJIHZhbHVlLiBUaGUgU1FJDQo+PiArICogY2FwYWJpbGl0eSBpcyB1
cGRhdGVkIG9uIGZpcnN0IGludm9jYXRpb24gaWYgaXQgaGFzIG5vdCBhbHJlYWR5IGJlZW4gdXBk
YXRlZC4NCj4+ICsgKg0KPj4gKyAqIFJldHVybjoNCj4+ICsgKiAqIFNRSS9TUUkrIHZhbHVlIG9u
IHN1Y2Nlc3MNCj4+ICsgKiAqIE5lZ2F0aXZlIGVycm5vIG9uIHJlYWQgZmFpbHVyZQ0KPj4gKyAq
Lw0KPj4gK2ludCBnZW5waHlfYzQ1X29hdGMxNF9nZXRfc3FpKHN0cnVjdCBwaHlfZGV2aWNlICpw
aHlkZXYpDQo+PiArew0KPj4gKyAgICAgdTggc2hpZnQ7DQo+PiArICAgICBpbnQgcmV0Ow0KPj4g
Kw0KPj4gKyAgICAgaWYgKCFwaHlkZXYtPm9hdGMxNF9zcWlfY2FwYWJpbGl0eS51cGRhdGVkKSB7
DQo+PiArICAgICAgICAgICAgIHJldCA9IG9hdGMxNF91cGRhdGVfc3FpX2NhcGFiaWxpdHkocGh5
ZGV2KTsNCj4+ICsgICAgICAgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgfQ0KDQo=

