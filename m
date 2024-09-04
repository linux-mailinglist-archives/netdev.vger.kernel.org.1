Return-Path: <netdev+bounces-125037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987496BB2E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7441F27A1C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA401D04AA;
	Wed,  4 Sep 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sfe73zCR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DB1CF5D9;
	Wed,  4 Sep 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450413; cv=fail; b=SKij9GXujEL+qIVXp+alZmIQKDuFXyX4bXtPSKwsuwxqHk5ScUgG1nGPrAmlwpxLWi7YgviuLgDZhwFmDQj+pJWFJU92mpUlWfhxBIjAT7Phr2qAPeA9cMJfvqIHzZkPJCrHibbZtsNdsAiRj7OHVx8GlAdSoGr6kMafnck+SR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450413; c=relaxed/simple;
	bh=ZnB5O0Ki9Cb5UxdIfkfnBY8ZlNMlIIPCNmXkoHlx6Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BY/YTaaMlOpgsh0FMDdzA7cbDgzXjsu4+qYd9/RJwzWrig1l9XsTc/htZjZN+Hze6TLzwPqxXQeCT6xqKfLo9Gqv302reOiOAAlnkHJHJazuNTWJsG+VOwq0fdVCqLvC/Sy84OI07tcWV1Vm7dWb1Ij835ScYDEl4jDziAMAuxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sfe73zCR; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPkOvQ9SJlw3JNl7dLw7yHZoNBLpCUFleFNIiXuf22sZeq5v0I8q/Z3jT3GFcmYAdLbV3zvZUKNkWRUvvCXQ1fRU9OLbdrXH7oVuJ+MYYytg1GkS1t09mOMR9uosTo2xisvKvCHHiKXQ4dtG9iH9CvEd+YR1R8Bf6En7u5dTh9SSyeFxKjmMYGSrcsz0YsKIv9h4QkHC6Fg9R2moykLdkJgMUQHL8wG5Y9CinSUUIM8BovHfABPCINbfYw9YKLkr9LPbpZn94i5+ENrU+yZah0GSGC4ZlPOE4JqZ54FhdkpEOIqu4vCrTK0fJ6/atZCoAH+U5WnpRcZh2NXjrYRgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnB5O0Ki9Cb5UxdIfkfnBY8ZlNMlIIPCNmXkoHlx6Pw=;
 b=tYx3Fq7LsBQCSeFgkuEq84i0JumSsvVfpLxEQR4x+LvNnjKxgtzDQ/hBmncNHCtZUeIwEZxH+/4Ci97MhQpPlCrJ/e+tcGNWx/8QlyEEqJPuD9vCUtrz81DQyb8ZR8eXtA52LL75lweFr4rlXHUNCvLrDRxe715RTWl0aQGDrJjipGgwYHXLh54Ry4LeGIo6obb/SGbqHnBkvv+6qjcfYEmhIQUTD6YUdeYE49UNbKCn7LMbnBzSA6AleusKRh8EA74BVhhNp09fjbzYbIoH/dxSBizLiOk4NFo0K3bbbUO6riERFZH3P8UbpunbJ0HvtkiU72gmE9/om5JZZoJbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnB5O0Ki9Cb5UxdIfkfnBY8ZlNMlIIPCNmXkoHlx6Pw=;
 b=sfe73zCRDTPLVTA1W1KOJuwnLoH+Kq0yfretW29R20NZRIc2dtDs9JCcFu7Y73a3ORGL9nxjSRTtb5SB1yZNxI6aVxqCi34UQnww12ziLVrVCnMiLoc8VLZvGcAwgPerP2OfpB1EcgseBpZzCZ9vdcjhN98U8N37i+LKgA7We93Soz9qg2q6VJxYndYxDLqsFo+w5VFAnA3s4IWjx7ef47IHxzgvc0+lmPeBm6F2McQqpo0Wul33Ca3dauhjyc1fA7Mnqi9ngW/1l0V4A+7cxx0Un3speO9LYLF6InzRiucrcUm85BfqAedypdAFc7va0Muc2UcUampGJLaNzUt/xg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:46:47 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:46:47 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Horatiu.Vultur@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Thread-Topic: [PATCH net-next v2 7/7] net: phy: microchip_t1s: configure
 collision detection based on PLCA mode
Thread-Index: AQHa/UVnEGwEICz1Fk+B+6aZAYJrcbJFnowAgAHnJgA=
Date: Wed, 4 Sep 2024 11:46:46 +0000
Message-ID: <d8b880ad-28c2-4fea-9dc6-3adde9dfe8c0@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240902143458.601578-8-Parthiban.Veerasooran@microchip.com>
 <20240903064312.2vsoqkoiiuaywg3w@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240903064312.2vsoqkoiiuaywg3w@DEN-DL-M31836.microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ0PR11MB5151:EE_
x-ms-office365-filtering-correlation-id: 09cf4abd-67b1-428f-fcdb-08dcccd74196
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEZBdDhFeFBPQ3ArVTVUUzA2cEdseGtrVkozK3FHSm5lQXMvMC9aOEVmc3hq?=
 =?utf-8?B?QWRzK1AvTzRDNFk5UEpWKzc3ZWx0YnYvdTlPaUZFMzlTR1EvUWxRN1NjUFNp?=
 =?utf-8?B?OUtPeUlYeGtUWTB2cncyby9ua2Z1K1o5cEhiYVk2R0tVdVVIclhrU2lRRHhv?=
 =?utf-8?B?b2szZm4xc0s4UHo0UEx3RFRvajduOUJYWkdxcE5HZ2E5VTJwczg5ckhJRVJ1?=
 =?utf-8?B?UndPeFFaQzhzTDlNNnRLbEFiaklHWmtYUWFDdDVXY2pUMldIWkJEZ21tVmpO?=
 =?utf-8?B?WVdKa21PM1JqNzk4eXZvZnpOQi9obW1nUDRZNDI1UlBOMWFRWW4xZ3lSaURP?=
 =?utf-8?B?RUxIVlRnYlgrbnYwRC8vTkRTL3BxUE1JVG9BQTdIYmpkeHJIQlRrSHAxNUJj?=
 =?utf-8?B?RzYzUzVWQjBTUFh1bktrZ3p2ZEJEZDJSdXZXaHFLM291cTBHRkdCRFVVL01o?=
 =?utf-8?B?dFBBc1BhV2JYUU00bWh1UzBXYTBKRW9Senp0U3M3YVUvVWg3dk5ndDBrYU9Z?=
 =?utf-8?B?aWFyQnNPUyt3a1MwRGtiQklqbGZxU05DSVYyd0tWZWFpMElYYmxZMkVVRWYx?=
 =?utf-8?B?dTlJM3h2L2RuMjMxNERmcG1JU0JUemtCZXdLUHlSSDFFOG5DVzRhQXJ0WG9T?=
 =?utf-8?B?VUFqZ0lzc1ZGRHIybXJZQzdkcms1OEJrQWFOSm0zUkFJYUN4TGVEZTBEMFhR?=
 =?utf-8?B?UC9PMzRyQ3lGUnFvVXRYOGJhQ0c5L3UrNkhSUWdOWjZnUFUvbWxzbGdaWjVE?=
 =?utf-8?B?b0xieVMyTktBLzlqdXhkRnA4YmNBUFVSOXdQMEFhb0REbC83a21vcnM0ZG9l?=
 =?utf-8?B?T2RGZ2svSWdyVTVYZEVWdk9oMytUa1kvbzJ4UjJSMGkrVVgrek4xSUE0NkZM?=
 =?utf-8?B?REkrS3pwZHhJMCtpZjF0YWM3dHdIVjA4MGhnRHRRb2FCTFR0eG5BUTVYU3pn?=
 =?utf-8?B?eHZHeEFUR0I0YTYrdWp5STNrai9iMDRlY1NmMDhQeTJnZnUrNmdGS0ZoWUpM?=
 =?utf-8?B?d1B5dENkY3d2VC9DUHFkNUp2M1QwczEvK2U2Q01wQVc4RjMrbEJPSHRFTkF2?=
 =?utf-8?B?bkkzb0NmRi9ROEN5TCtnRnJtcmxVUzZjYzV4VVNINDN2ZDZJb1E2NUhQdGJV?=
 =?utf-8?B?UnNRUVM2ZU5vbmRqTmtBVFNGc2JYd09aVXlUa3R3YkF1N2wzRy80OHZPNHJN?=
 =?utf-8?B?THdueGlkbGpmMVBiTHV0U3o2UnM3aGdWQVN5N1Q5bjdDdW50eFdQaHV5eWxE?=
 =?utf-8?B?akhrYU9mRENmWlArTkpxQmFsNHlSeE55TlZXTE1GL1A2NWxEQUJKK1prTXJM?=
 =?utf-8?B?YTZXMHNKaXlSbXBvc0R0bTdBMHFWbGxoOXVMWlBwWFY1cVY3WG14MndDK0pG?=
 =?utf-8?B?ZnVBV2lpdlZQUC9LVGRiOERid1RrQ0FRRTduQUw0Qk42dWVSb1RmcmVZS01y?=
 =?utf-8?B?NzkwK0Rma3JNSlVIbUZ2aVBWTUhrYkFMdlFyYkh2M01MK2wreDJDNC9YS3F1?=
 =?utf-8?B?VGx4LzhZZjhFYVNSWXJyQ3FhRHFid3E0QlArNllNSjZuNFN5Y2hHMGs3V0Jp?=
 =?utf-8?B?VHlXQTZwU1NrWm1PSFl5K3VqcUdlQUw1MXozdmlOMGRPc0FlU1owR3FBTFBY?=
 =?utf-8?B?OGdjVEJzc3V5Z2I3KzJySjlLblpvWnB0TUZuQnkrdjlUZDZkaGhyaG4yWksz?=
 =?utf-8?B?M2tmV2VrRzVFc25DY3k4NWtGUk8rZUl6TmxrSlRneTVnZTNyVUJaZER1REtr?=
 =?utf-8?B?SE1RQndlaS9Qb1UwTkpSeS9Vdm1MUTVjQWd1TmZlVlpmdFNmd3V5Q3NXekJm?=
 =?utf-8?B?MVNzZGJRTjBmUzR0SFhMaHlXeEU4VWlybHRJQ2YyYldVUWtFNkd4bHhSbUNy?=
 =?utf-8?B?WHdoazhBZHYweEZZa1B6VjBSL3Jwc0FiWlNXcnh6L0xrN2I3WW5sODNnclE2?=
 =?utf-8?Q?ZIkeUuxupWc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm5GdElVL1Z1R3U2MDFRdVVQRG9YNXhIRzZwTHdEVVZER0d4c3ZLMEJsN2Nm?=
 =?utf-8?B?V1FpN1Y2TmVoN1N3OTdaMTRJeEh3MVRkZlc0SDBnakxZTFdzRUNoWFRqUVBX?=
 =?utf-8?B?a3R1T3JYeDJYbk5PRDBjbVNYeGFmK0hjOTFGMU92bUNrd2liSXdUS2dON2JJ?=
 =?utf-8?B?S1c0b21pcDJXRmxMeE1rQnZ1YUJVcm1idi9JQUV4NkZTVlJ3MU5aSjJOWlV2?=
 =?utf-8?B?Unk3S1dCdVY1WXZKT1ROMGZyY1UzZHpLRjB0UTQ1TFExRlFFZFVEU2Q0akUv?=
 =?utf-8?B?bnBVRUVRdVRBYkcwZERVQlkybWtacHNRQ0pTakJDTmVBRE1DNXhmQTJlNm9T?=
 =?utf-8?B?UCt1bHBnSFJyd1kyR0VjNVdNRDRpOXZPbStjMmNkeGJ0SDFDaTBnNkcxdG0v?=
 =?utf-8?B?YW9FWXJQSm9xKzNJZHEyaksxMXJyNDJhdTdERHRaa01LMGFTZDB2U3RlbW1v?=
 =?utf-8?B?aWJVczl6SVJRb3ZQT0RYZGpabEFwYW1oNTFTZW5KbWc2eXBaRWlJNlF6R2Vz?=
 =?utf-8?B?dDI3RG45a2JQRGszWGxnZTNEYTYzYXZXM1p4RnJLQ1VlUElCZDZjMW82Sk1U?=
 =?utf-8?B?M29obzBFWTBYUE9VQXY3WUk4OXZBVFllVGIvVWx5SWJ2dWE1VWNTZ3Y2SE9X?=
 =?utf-8?B?cU5kMjJid1VCQXkrZFFXbUdYcjE1emRBS2hqR09zQnZKVURvYlE4dndvbzFa?=
 =?utf-8?B?YlVRZ01WWkNWOWFVT2dKc1NoTkNvKzNnZTNCdXpNQXVNM05rTlZJUTNWaWw0?=
 =?utf-8?B?U1kvVW15R1RDZDFtYlNiT1NHbmR3b3pOaXFjTStDbTRzNnZ4ZFI5Uk9NYkN2?=
 =?utf-8?B?aVdyZDdNSUNCMkthZTAvL2c4OHVZeDREY0g4SG9ZY0piUXcxTi80VTQ1dlNz?=
 =?utf-8?B?NE1zSjB6NzdaQVA3djhTWEFSbFNaTTNSMXZNTkY2TnpOdWRwVXJtanUvQUtC?=
 =?utf-8?B?R21nZXRkOG1uaXhtRTU3RW5uaW40WHFGeXNYdGpLODBtcE55UnQzdjU5eXlr?=
 =?utf-8?B?c3BqelhuVGVVMTQzZmUyTEJvcm5nTVZLSnpxekpwRjIxNzJ2Um9zZVdZTTVm?=
 =?utf-8?B?cnQvUElRWmJHSFY3aEY3cDRUekh0SUJSUXZpRGRuM2ZRMFRXSmVBYmRRTTNn?=
 =?utf-8?B?SEJ1SDRsN3Z4MDNUNEJZR3ZhU2Z3ajZqYXBlMFVLZlJ6aXFCUkZaMkxoMW9J?=
 =?utf-8?B?YWxHOXQ2QmxtQkcwdE9BaUFBWDZKQzhlVUVIY0N1L2FFTnk1UU9xL2JjV2FN?=
 =?utf-8?B?QnREQzNFb3ExZXBvZCtLZjhzT2NVa0FJNnBjOGkrYUNKL3d5TTh1NlFBdG02?=
 =?utf-8?B?bzhMT2lmSWszRVJzbmZGMloxbHVIVmhMMmljSGdaKzVpajl0OXBWSTBFY2tx?=
 =?utf-8?B?bkRTeUo5TlRFU2lFN2ZnMVpFOURDWHgzUDQ2bWFyS0RtdDhMb2xPK3FCUFRB?=
 =?utf-8?B?cUlxcjBnaElnRlM5ckxoMWxSNTZaeUZ4T1BudkpPeTcyQTJsU2tWaTUrenEr?=
 =?utf-8?B?YWQ0cHpiQ21sRXI0MWUrazU1ZWd5Rk43K3J3UzZzenhGeHQ0NFFZZUdRSHZn?=
 =?utf-8?B?RGZVWlJoVWswbWJXRWlVVzY4MVhqeWYzQzcxdUwwZzkvVkluNnI5NlEwRGpa?=
 =?utf-8?B?dlg0Qk55UkJFcGF2MkRzRFBaaUo2bC95UUFVWTkvaGhVbUMvQVIwTkg1MjMy?=
 =?utf-8?B?Q2NBTU5DMzBJNzRoYkZCVm5PWFF4QlRtNHphYWhHenN4a3kvSWpRZjFQb3VK?=
 =?utf-8?B?MDJiTWpvVVB6Y2JQTHJCTm5tcTF0cXpWL2VKQVBpOVhrZ1pLZmRBRW51VFBn?=
 =?utf-8?B?WmJOaGZBSk1GbEZ0YnBCREJYaVR3Y3pIb0dLSWwvRFNDSUszVHlVZEZDM1Vi?=
 =?utf-8?B?dlJ3QTFTSWlPMWR4ZXRtS0xiMTdNSXFTanREYTVTaWtvZ29MMVlQYmhXVnNq?=
 =?utf-8?B?TDBFU1JrWkxHWXA4QlVDa2hZNEtZRzJEU0U5MFZQM3hjZ0l4akpQQmxseTNu?=
 =?utf-8?B?UTJvb3ZXSWFuS3Erd2M2ZXBRQkNzRGJueUphdVpCTG85WEpWcUJnS3RWajc2?=
 =?utf-8?B?YWFpSit6QmRuWlFxRlJQSkFuY045YkVBRitsbGVKTC9iMi9Wakl1Q1hlZWZm?=
 =?utf-8?B?Zm05cmJaanV0UUhubG92ZERzR3ZZejFvUGY2VkppT0pVUTk3TkFkVW5NcGwz?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEB86A8D51C1B640A74F7CA4D59B589D@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf4abd-67b1-428f-fcdb-08dcccd74196
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 11:46:46.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xZq4PZAWU2q5AYm9TQ6S1cMc3felmHahawMZALdTqO0+8wINMYTM1qGuVAOJ+ohKwmIDvGnqhDHjb3BfxgqTxxKCqq7LzyMnsI5C4iLF+b0r4FQkLSpL3biqDiKAhn3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151

SGkgSG9yYXRpdSwNCg0KT24gMDMvMDkvMjQgMTI6MTMgcG0sIEhvcmF0aXUgVnVsdHVyIHdyb3Rl
Og0KPiBUaGUgMDkvMDIvMjAyNCAyMDowNCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0K
PiANCj4gSGkgUGFydGhpYmFuLA0KPiANCj4+IEFzIHBlciBMQU44NjUwLzEgUmV2LkIwL0IxIEFO
MTc2MCAoUmV2aXNpb24gRiAoRFM2MDAwMTc2MEcgLSBKdW5lIDIwMjQpKQ0KPj4gYW5kIExBTjg2
NzAvMS8yIFJldi5DMS9DMiBBTjE2OTkgKFJldmlzaW9uIEUgKERTNjAwMDE2OTlGIC0gSnVuZSAy
MDI0KSksDQo+PiB1bmRlciBub3JtYWwgb3BlcmF0aW9uLCB0aGUgZGV2aWNlIHNob3VsZCBiZSBv
cGVyYXRlZCBpbiBQTENBIG1vZGUuDQo+PiBEaXNhYmxpbmcgY29sbGlzaW9uIGRldGVjdGlvbiBp
cyByZWNvbW1lbmRlZCB0byBhbGxvdyB0aGUgZGV2aWNlIHRvDQo+PiBvcGVyYXRlIGluIG5vaXN5
IGVudmlyb25tZW50cyBvciB3aGVuIHJlZmxlY3Rpb25zIGFuZCBvdGhlciBpbmhlcmVudA0KPj4g
dHJhbnNtaXNzaW9uIGxpbmUgZGlzdG9ydGlvbiBjYXVzZSBwb29yIHNpZ25hbCBxdWFsaXR5LiBD
b2xsaXNpb24NCj4+IGRldGVjdGlvbiBtdXN0IGJlIHJlLWVuYWJsZWQgaWYgdGhlIGRldmljZSBp
cyBjb25maWd1cmVkIHRvIG9wZXJhdGUgaW4NCj4+IENTTUEvQ0QgbW9kZS4NCj4gDQo+IElzIHRo
aXMgc29tZXRoaW5nIHRoYXQgYXBwbGllcyBvbmx5IHRvIE1pY3JvY2hpcCBQSFlzIG9yIGlzIHNv
bWV0aGluZw0KPiBnZW5lcmljIHRoYXQgYXBwbGllcyB0byBhbGwgdGhlIFBIWXMuDQpZZXMsIHRo
ZSBiZWhhdmlvciBpcyBjb21tb24gZm9yIGFsbCB0aGUgUEhZcyBidXQgaXQgaXMgcHVyZWx5IHVw
IHRvIHRoZSANClBIWSBjaGlwIGRlc2lnbiBzcGVjaWZpYy4NCg0KMS4gU29tZSB2ZW5kb3JzIHdp
bGwgZW5hYmxlIHRoaXMgZmVhdHVyZSBpbiB0aGUgY2hpcCBsZXZlbCBieSBsYXRjaGluZyANCnRo
ZSByZWdpc3RlciBiaXRzLiBUaGVyZSB3ZSBkb24ndCBuZWVkIHNvZnR3YXJlIGludGVyZmFjZS4N
CjIuIFNvbWUgdmVuZG9ycyBuZWVkIHNvZnR3YXJlIGludGVyZmFjZSB0byBlbmFibGUgdGhpcyBm
ZWF0dXJlIGxpa2Ugb3VyIA0KTWljcm9jaGlwIFBIWSBkb2VzLg0KDQpCZXN0IHJlZ2FyZHMsDQpQ
YXJ0aGliYW4gVg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29y
YW4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIGRy
aXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBf
dDFzLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcm9jaGlwX3Qxcy5jDQo+PiBpbmRleCBiZDBjNzY4
ZGYwYWYuLmEwNTY1NTA4ZDdkMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNy
b2NoaXBfdDFzLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyb2NoaXBfdDFzLmMNCj4+
IEBAIC0yNiw2ICsyNiwxMiBAQA0KPj4gICAjZGVmaW5lIExBTjg2NVhfUkVHX0NGR1BBUkFNX0NU
UkwgMHgwMERBDQo+PiAgICNkZWZpbmUgTEFOODY1WF9SRUdfU1RTMiAweDAwMTkNCj4+ICAgDQo+
PiArLyogQ29sbGlzaW9uIERldGVjdG9yIENvbnRyb2wgMCBSZWdpc3RlciAqLw0KPj4gKyNkZWZp
bmUgTEFOODZYWF9SRUdfQ09MX0RFVF9DVFJMMAkweDAwODcNCj4+ICsjZGVmaW5lIENPTF9ERVRf
Q1RSTDBfRU5BQkxFX0JJVF9NQVNLCUJJVCgxNSkNCj4+ICsjZGVmaW5lIENPTF9ERVRfRU5BQkxF
CQkJQklUKDE1KQ0KPj4gKyNkZWZpbmUgQ09MX0RFVF9ESVNBQkxFCQkJMHgwMDAwDQo+PiArDQo+
PiAgICNkZWZpbmUgTEFOODY1WF9DRkdQQVJBTV9SRUFEX0VOQUJMRSBCSVQoMSkNCj4+ICAgDQo+
PiAgIC8qIFRoZSBhcnJheXMgYmVsb3cgYXJlIHB1bGxlZCBmcm9tIHRoZSBmb2xsb3dpbmcgdGFi
bGUgZnJvbSBBTjE2OTkNCj4+IEBAIC0zNzAsNiArMzc2LDM2IEBAIHN0YXRpYyBpbnQgbGFuODY3
eF9yZXZiMV9jb25maWdfaW5pdChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gICAJcmV0
dXJuIDA7DQo+PiAgIH0NCj4+ICAgDQo+PiArLyogQXMgcGVyIExBTjg2NTAvMSBSZXYuQjAvQjEg
QU4xNzYwIChSZXZpc2lvbiBGIChEUzYwMDAxNzYwRyAtIEp1bmUgMjAyNCkpIGFuZA0KPj4gKyAq
IExBTjg2NzAvMS8yIFJldi5DMS9DMiBBTjE2OTkgKFJldmlzaW9uIEUgKERTNjAwMDE2OTlGIC0g
SnVuZSAyMDI0KSksIHVuZGVyDQo+PiArICogbm9ybWFsIG9wZXJhdGlvbiwgdGhlIGRldmljZSBz
aG91bGQgYmUgb3BlcmF0ZWQgaW4gUExDQSBtb2RlLiBEaXNhYmxpbmcNCj4+ICsgKiBjb2xsaXNp
b24gZGV0ZWN0aW9uIGlzIHJlY29tbWVuZGVkIHRvIGFsbG93IHRoZSBkZXZpY2UgdG8gb3BlcmF0
ZSBpbiBub2lzeQ0KPj4gKyAqIGVudmlyb25tZW50cyBvciB3aGVuIHJlZmxlY3Rpb25zIGFuZCBv
dGhlciBpbmhlcmVudCB0cmFuc21pc3Npb24gbGluZQ0KPj4gKyAqIGRpc3RvcnRpb24gY2F1c2Ug
cG9vciBzaWduYWwgcXVhbGl0eS4gQ29sbGlzaW9uIGRldGVjdGlvbiBtdXN0IGJlIHJlLWVuYWJs
ZWQNCj4+ICsgKiBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgdG8gb3BlcmF0ZSBpbiBDU01B
L0NEIG1vZGUuDQo+PiArICoNCj4+ICsgKiBBTjE3NjA6IGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5j
b20vZW4tdXMvYXBwbGljYXRpb24tbm90ZXMvYW4xNzYwDQo+PiArICogQU4xNjk5OiBodHRwczov
L3d3dy5taWNyb2NoaXAuY29tL2VuLXVzL2FwcGxpY2F0aW9uLW5vdGVzL2FuMTY5OQ0KPj4gKyAq
Lw0KPj4gK3N0YXRpYyBpbnQgbGFuODZ4eF9wbGNhX3NldF9jZmcoc3RydWN0IHBoeV9kZXZpY2Ug
KnBoeWRldiwNCj4+ICsJCQkJY29uc3Qgc3RydWN0IHBoeV9wbGNhX2NmZyAqcGxjYV9jZmcpDQo+
PiArew0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlyZXQgPSBnZW5waHlfYzQ1X3BsY2Ffc2V0
X2NmZyhwaHlkZXYsIHBsY2FfY2ZnKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJCXJldHVybiByZXQ7
DQo+PiArDQo+PiArCWlmIChwbGNhX2NmZy0+ZW5hYmxlZCkNCj4+ICsJCXJldHVybiBwaHlfbW9k
aWZ5X21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQyLA0KPj4gKwkJCQkgICAgICBMQU44NlhYX1JF
R19DT0xfREVUX0NUUkwwLA0KPj4gKwkJCQkgICAgICBDT0xfREVUX0NUUkwwX0VOQUJMRV9CSVRf
TUFTSywNCj4+ICsJCQkJICAgICAgQ09MX0RFVF9ESVNBQkxFKTsNCj4+ICsNCj4+ICsJcmV0dXJu
IHBoeV9tb2RpZnlfbW1kKHBoeWRldiwgTURJT19NTURfVkVORDIsIExBTjg2WFhfUkVHX0NPTF9E
RVRfQ1RSTDAsDQo+PiArCQkJICAgICAgQ09MX0RFVF9DVFJMMF9FTkFCTEVfQklUX01BU0ssIENP
TF9ERVRfRU5BQkxFKTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgbGFuODZ4eF9yZWFk
X3N0YXR1cyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KPj4gICB7DQo+PiAgIAkvKiBUaGUg
cGh5IGhhcyBzb21lIGxpbWl0YXRpb25zLCBuYW1lbHk6DQo+PiBAQCAtNDAzLDcgKzQzOSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBtaWNyb2NoaXBfdDFzX2RyaXZlcltdID0gew0KPj4g
ICAJCS5jb25maWdfaW5pdCAgICAgICAgPSBsYW44Njd4X3JldmNfY29uZmlnX2luaXQsDQo+PiAg
IAkJLnJlYWRfc3RhdHVzICAgICAgICA9IGxhbjg2eHhfcmVhZF9zdGF0dXMsDQo+PiAgIAkJLmdl
dF9wbGNhX2NmZwkgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X2NmZywNCj4+IC0JCS5zZXRfcGxj
YV9jZmcJICAgID0gZ2VucGh5X2M0NV9wbGNhX3NldF9jZmcsDQo+PiArCQkuc2V0X3BsY2FfY2Zn
CSAgICA9IGxhbjg2eHhfcGxjYV9zZXRfY2ZnLA0KPj4gICAJCS5nZXRfcGxjYV9zdGF0dXMgICAg
PSBnZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1cywNCj4+ICAgCX0sDQo+PiAgIAl7DQo+PiBAQCAt
NDEzLDcgKzQ0OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBtaWNyb2NoaXBfdDFzX2Ry
aXZlcltdID0gew0KPj4gICAJCS5jb25maWdfaW5pdCAgICAgICAgPSBsYW44Njd4X3JldmNfY29u
ZmlnX2luaXQsDQo+PiAgIAkJLnJlYWRfc3RhdHVzICAgICAgICA9IGxhbjg2eHhfcmVhZF9zdGF0
dXMsDQo+PiAgIAkJLmdldF9wbGNhX2NmZwkgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X2NmZywN
Cj4+IC0JCS5zZXRfcGxjYV9jZmcJICAgID0gZ2VucGh5X2M0NV9wbGNhX3NldF9jZmcsDQo+PiAr
CQkuc2V0X3BsY2FfY2ZnCSAgICA9IGxhbjg2eHhfcGxjYV9zZXRfY2ZnLA0KPj4gICAJCS5nZXRf
cGxjYV9zdGF0dXMgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1cywNCj4+ICAgCX0sDQo+
PiAgIAl7DQo+PiBAQCAtNDIzLDcgKzQ1OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBt
aWNyb2NoaXBfdDFzX2RyaXZlcltdID0gew0KPj4gICAJCS5jb25maWdfaW5pdCAgICAgICAgPSBs
YW44NjV4X3JldmJfY29uZmlnX2luaXQsDQo+PiAgIAkJLnJlYWRfc3RhdHVzICAgICAgICA9IGxh
bjg2eHhfcmVhZF9zdGF0dXMsDQo+PiAgIAkJLmdldF9wbGNhX2NmZwkgICAgPSBnZW5waHlfYzQ1
X3BsY2FfZ2V0X2NmZywNCj4+IC0JCS5zZXRfcGxjYV9jZmcJICAgID0gZ2VucGh5X2M0NV9wbGNh
X3NldF9jZmcsDQo+PiArCQkuc2V0X3BsY2FfY2ZnCSAgICA9IGxhbjg2eHhfcGxjYV9zZXRfY2Zn
LA0KPj4gICAJCS5nZXRfcGxjYV9zdGF0dXMgICAgPSBnZW5waHlfYzQ1X3BsY2FfZ2V0X3N0YXR1
cywNCj4+ICAgCX0sDQo+PiAgIH07DQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4NCj4gDQoNCg==

