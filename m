Return-Path: <netdev+bounces-188538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715AAAD442
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927693BF102
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9281B85CC;
	Wed,  7 May 2025 03:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RXyVLhAY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97C42A83;
	Wed,  7 May 2025 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590216; cv=fail; b=tDgEPzkXdGqSmfPLl9AuzwZq7RxyT3QRU3CY61moz51xQAZtumsw/ZOL3BZXaWP3se0uiQveWnu3vgkC7tbKF4TbgJlCj+yRD8GxQ4eczjblRMl78rQJWp8YW8gZ8Zo3wyCsOBDoyY1hOKxS92ftFAjqSq0dma6SN3rJwJgCjug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590216; c=relaxed/simple;
	bh=pgQXpusShMY1hrB08N4Is8ax9QNtp/gg3NZEEFZRJBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKKjoNysgCTyUGPifl6mpJnfuJiTroz/Ulwc5sg+h3x6gWhYJfblrfqCRleDpXEqonLTcyiTNAcMJbxxsXnni/I0/CpMw/JqzJoNHoQJoTDw2lMwYQlR6R5j3/lr/DSv2Zpxv0R2JNDrxpXIMT7GfLwezHGasvvJX55sFUXuC78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RXyVLhAY; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKxFe+wFQa+xOftURUQArLBflWOp7Zg7brMuP0hzPhnHG4a5lU4Br3p8DgxJQqerPEmZhE9zWosoS5on+VUnG2dF7VMPV8Qhgzi3qujhEz6o2USKweKT7w1F+PUOoBk7qgKfxn2GH8Tm4rVh3lKCbPF7XwavZ6MQEbR0J/K569MOo/EN+IzAiSb0T6GbYmBPODYfXcr+hDq0LOJ9kxUlJp7J6GoY85JMPOSe3v+o1OgM4C0dy89uLlpTmilsDm1ARuk/7LO7LABngvOtPP5A7cg0SsCpnWwb2okg7Bsvv/ANvwStchV6zaloIClqI0tEAXHFETOZqLe/mNoqBLFEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgQXpusShMY1hrB08N4Is8ax9QNtp/gg3NZEEFZRJBM=;
 b=shI5goy3bt3ku5sMSiKUbi9KeRRwXkrP5uja6muQd3itzYj3r9fyhj6fOhg2mevebCXZMp415GFeSmsZFV3zp/2B7fQlKehL7Sazdquh1xKNhpraWwtbSz0yVSQscZwcY8VSRClhMC0+VXQJSlQJYRCO4tEQS/nt1jzo6BVjVSbCQH8fB7IXq3F2NOgWZ6Pzzth6eBcPz7BRjHi5hfr2pLv9wvKvTR2vMyXjHYjtejSo1qoXuhL/wK9WGPh+yMq9UIV3Tuox8BMfX3J5xUs1ScsBEPHw99bCGWCM5SBOExNcW8qX8T+3a6pUzlLNbxofTsyWdsehRRRj4bz3X+g+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgQXpusShMY1hrB08N4Is8ax9QNtp/gg3NZEEFZRJBM=;
 b=RXyVLhAYkByuKVxaZa4YaTvuVEARP6cJW2vKosq4RtHKHDbMagJyl+KSwHH4unzWWE9Z2gZlTYtUxfqUYTdU21qg9465igJeIxpJmIkSb8OJtpLli/82y6AOIvI46m3scuBzq2CZg34Mb9r8SwPU2TIfs7HWVdaXVuwb1mqHP4JGixLO8SY/jW5UWmeTS9ajinP9qu1SmgG+GCPHmYr1/1RPn17yK13rbpkEWKi97OJV123oK+Dj3Oit8sVunNJ2pCucah0qaHKk57EhosHPDSKOg6lXPbnA2f2HC+EWxSmMQ1BFwWm62pwo6oXHNajlzoWCP8nWLcG5mK2ruhi7kQ==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 03:56:45 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Wed, 7 May 2025
 03:56:45 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 1/7] net: usb: lan78xx: Improve error handling
 in PHY initialization
Thread-Topic: [PATCH net-next v8 1/7] net: usb: lan78xx: Improve error
 handling in PHY initialization
Thread-Index: AQHbvZna0OUcxNgAPkSBfDlyDsnrXbPGi9YA
Date: Wed, 7 May 2025 03:56:45 +0000
Message-ID: <3b21fd4b1b1ae6767fc16abf4c3171d2083d1dfc.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-2-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS4PPF0BAC23327:EE_
x-ms-office365-filtering-correlation-id: b5e6b835-5c2f-4bed-6287-08dd8d1b2f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXoxemNNNnNqbm53N1p4MG9nVER6NHVNdlIvSWJ4MmZDSEtrN1ZndnFkMmN4?=
 =?utf-8?B?b1F5M1d6RDQ2dElscnRCdlA0Z045OEkzejN1Um9hTnl5NEE5QUlwb2dPMnlM?=
 =?utf-8?B?SGZYMVI1TXFrUDJXKzNiSlhQcW5nQXZSK29HTnYwTjB0NDFOZ3hzQ1JNTDQ2?=
 =?utf-8?B?TERCMHlxcFhzTFBIdy9iS0ZHaXdJay9wUDluWkdONGV1S2JVbVZ6TUMvTVVY?=
 =?utf-8?B?WEttUisrbmJQdExRMEg2Vmk0bmZWK2s3d1EvZURTOXFNaU41dWJtMlZEa0d1?=
 =?utf-8?B?eWZIdi8xNkViT1R2YVU3ejNjSDNWSllwSnNTaXYzRjNndG5GU0FZZGZSM25O?=
 =?utf-8?B?RzRCVmNWMDNyNzBKUDZrcFRIY1FhMnZOTzk0N2hxRVprK1YrUmJRQWRMMkV3?=
 =?utf-8?B?Sk9sTEgzM0tzZXc5NHNsY1pLdldIZ2VkN3FBNnMyMExjVjdaMkFidjhCT05x?=
 =?utf-8?B?dGN5cnFFZW1nR0xDaXJXc2FPcldtREgzOUJjanpERWZqYlFPb3d5Nm9NS214?=
 =?utf-8?B?bVIvKytRcGJ6U1NReGloVUJKOVFvSFNNaFBMMFBzSjhNblpFb2d1T0lOWDR0?=
 =?utf-8?B?enFNTGt1SXFqSVZaQjhQOGh1WXpTZXZ0b2JPN3BxZVAyTlZKL21YWTEyOGx3?=
 =?utf-8?B?QXZFdXdCYW5tMkhZeVFsUkgvcEp3Mm1UTHdRMzBGWWlyUVdreFAray9Sa3Nu?=
 =?utf-8?B?Q2VLYkxWUFNKcTQ3K29mOWJINmxUTjN5THU4VDFDWUtjMDJOQ1hXN3dPbmM5?=
 =?utf-8?B?dVNpalo2Ylh4RFRUYnpmL3hTSno4ejdmMS9tYWtNalJMZm9hUER1ZlhJWTR5?=
 =?utf-8?B?STRTRTlRT0t3K1RTb1VlNUVrUjZuV3VMeU9lSWVwRG56aGFLa3pkU3ZraFVV?=
 =?utf-8?B?d1dpYk0zOGlhaXdPS2pYSjU0Z3p0OEJiVm9wZEFNMzI3VFE1NDllWDhYR1ZN?=
 =?utf-8?B?V281NG43bGQ1NDR5a1NhMkhZazcvN3MreEliQkhISkkzK1RuZ1N6Q011RVZL?=
 =?utf-8?B?dGxtbit1WVY1WDIwQmEvWHBoOHZ4ZTlEUlFwK3h2aFpnVVdNSkcvVEt1R3Qw?=
 =?utf-8?B?c3VpSHlSdVVldk1WTE5Ia29hSGladTdRc0JwQnRMcHFJS1RmVklUNWFodXJP?=
 =?utf-8?B?ek1TK0NnUnMyTTd2K2pGUW5HR2ZpKzcyenR6RXZrY25sSnNHTXhYYWZOdFNx?=
 =?utf-8?B?bVpQMUlSOW9RaGJjemFHV0VTYWRlSk5yU2J4YkpDcldpYWdhOERvMzJycWxO?=
 =?utf-8?B?eHBva3Fsb0h3SzYwQUUwV0xDQ2pQYWZiNEhlandQOU40TEFrSnp0VVFwTTZE?=
 =?utf-8?B?Mzg5THB3MllEbFA1Qmx4bkdBZUl3VmdJV09lZFh1dmU1TERudVR6RFlOc29E?=
 =?utf-8?B?UUJEY0lGKzVlbnhMbkEzamdCQ0F3OEtmNXBuYzFZT2pFYjVqcVRoZldQUHIx?=
 =?utf-8?B?dTM2T0ZnL0xweHpYSVU5OEFHdFBSS3p5aWxnbWhBeEFxYWdVeDZFOHRJRjBw?=
 =?utf-8?B?aDdTdytEa3ZZL3J1c2QwSFgvdW9leUtBZWt2VFZoT21uZ3dyN2wvdmJrMXVv?=
 =?utf-8?B?RkRQK3dQbGFPSkdXTC9zTXZuUUdvODZGN3RXZjFBMWV0ck9adncyUTd0ZCtM?=
 =?utf-8?B?RCs2SE1CRzdidlBEelpmUWNrOUpUUjVXWUxHUEZlYzZ5T1F4UGF2ZTNBZlA4?=
 =?utf-8?B?eTNrcjRLTWlmSUFCZFhpWVJRZ2Y3SG5pL0hWanVwb0NjQk1Kbm9kWldzQ2Jt?=
 =?utf-8?B?dThVMGhva0RVVDYyakdaUGhGeUVWYU5FMC9zMTRFRVpjQ0hNZDFHN2RIQ3Nw?=
 =?utf-8?B?RGxWb2lSZy9MdWZrRGMzekxUdUpEWGoyZHYvOURtT2JoZXY5eEdWVUZLY3Jx?=
 =?utf-8?B?UkJWYkFHZks0ekRrYmtnWlY2MTdhd3NWZHNQOGt4ZVJXaXN0YmRWMVFhdmRo?=
 =?utf-8?B?blJUTi84TGdlNGgxOHBLcHc5N2R0S1UxRExvdzI1THEySmJEbm1UQzhHUmtV?=
 =?utf-8?Q?/KEW5Mi08hs/dTNEp93dXVTsQRq3qg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3NlaTFteFBma0FtbFJ6SXdPTi9QeXNBL1RNdEZMblFVamk0c01QREo5OFlu?=
 =?utf-8?B?STFnQy9kbHZybG5SMW1JOEsvT1BzVDhNd0R2OG9sUng1Ym5obll5dHdYbW5s?=
 =?utf-8?B?RFBBalQwdjZzNFUyeUNxaG5NVG1LdFNmbE05Rzl4K2dma2xuTnFQeno1bHhr?=
 =?utf-8?B?TWMram9PMGNOdWR3SGRpdWFuek03MjRBSGczZ09ndFNESTg0QWJVV3hYT2VH?=
 =?utf-8?B?Wk91VlYxb2tLVlNXK0RMOXdqM2piNmJKNTd2M0ZjOUJyNisxd1hXTytnU0U1?=
 =?utf-8?B?QjV6OU1lNURRRlVuVzlKOGhocitBMTkzbzRzWnV2bFdnak1VUERyNFdDVlZW?=
 =?utf-8?B?eGhONlBHRkdjNHNmZVRJc0hBeWxkblVWUTZCc2lhYmc1dFFnU0ZmT0hvYU02?=
 =?utf-8?B?bVZXbE1GRmZmeGNpdWhWMXRQb1RXLzBYQTlTMmJzQUJJekx6Yjl4NlZCTG5D?=
 =?utf-8?B?V0VHMWFlaG1QS0tsVGpzcExBQXRxM3lwUllKWEJlM2JJM3pWUnZ5L0UvSzds?=
 =?utf-8?B?KzMyWG0xWk5EMXRLMDlSNTlwbGY1T0phdzczenk3dnRiUUdvQ1YxZW8yeEF6?=
 =?utf-8?B?Yjh6eVBJZkhOMGpTUWpvUGlsSWl4aE5kVW1Ed3VhZ3lyN1pST0c2M2piZzd5?=
 =?utf-8?B?T0srdFRtTkxSTFJDSERqcjZwUC94MTQvT1RYYTExSUpKWUFtTmtVcktJbUVR?=
 =?utf-8?B?eXdtbWNtNUJiQ0xwU0dQM3J5REFSTDVaVE5QNHUzcjJJb2hhTERCZ3Z3VEhU?=
 =?utf-8?B?eXhiVk1zNVFlY20zVDhaUk5pbzkwUlFXWk9BSGhZUFU1Q3FIWGhZd2M5ai9X?=
 =?utf-8?B?cVE2VWtTMEp6Z0tOWFAyKzVrODl0TnJPUUxZdEJnUFZhVFVkVXJkVVF6THQ4?=
 =?utf-8?B?VW1obzZpci9ZZFhyeEM5M25GQzRUK2MyUnQ1a0ExMHNjMVcxYUVYRXppS3hF?=
 =?utf-8?B?a2g2Z0pIZUF6Tk5YSENsOEhpdkFkcVNFbXFoNXhiV1hLL1JBNDVGbkFVWDVv?=
 =?utf-8?B?dzUrKzg3NXJoVlU1OXFTZ2cxSlVkYjE4QkhzYWxJTElyNWY1dFd3ZXg1ZGFY?=
 =?utf-8?B?T1hYZS9HM1NlTlFLeW9lRDV4SWRIRENYMitsRTAzK0ZmME5VSURESlpPRUpN?=
 =?utf-8?B?aTdHdi9wQ0d5c1g0UlRXTVZtU2VwdUxNMEs0VW9ucDZnNXJtbTVVTnFBVWhK?=
 =?utf-8?B?dHVrWkYvR2NJZVFXalo4eW5SeWxmQ1lHZExnbFRzclBuQUFGcWs1bjczenZC?=
 =?utf-8?B?dU41eHZDL3hPWWRqcm5TazNZcDRST2xqdWNkYzY0VTFtTnU2UXJvSUR2dUNt?=
 =?utf-8?B?RllFNGlQODk2Q1QwOTRNcTlXRmlXcEFtZVVGVGhxaUltM0J2THlZTU9xSHVE?=
 =?utf-8?B?ZHMvUkxvbE9OSnVoRUttOTdNS3gwbFEyL2lNNnI4aXhsMUVWa3BiTVRla3lK?=
 =?utf-8?B?VHhJT0lLd0VXMHR4V2ZhTGV1WWdNUTh6OHNOMFlMR1FWUVptZnNXYnVZRUs4?=
 =?utf-8?B?ZEFqU1dyck16allZcS9OT29nYmthWTBKYk5PNjhwVEJhZC9aZ3N2K1F0SlV2?=
 =?utf-8?B?dHZ6d3VISjdOUkJ3M1RUZFRrc2lkZnp5dXYvR3JkTURZWDAyeDY2dmU1cy9M?=
 =?utf-8?B?R3hNdWxPVzdXZnExTVVFUU9YdTQ0YXR4S1M3dGlkandSSUJPTm52djJUdG1E?=
 =?utf-8?B?R3lHenEvVmRsWjhMSmpOL2R1cDZodmYrL3Q0VjQxNlIxTVk3Tkt5ZWxWbjhz?=
 =?utf-8?B?K2U3MzJrVW1hMERqK2t2empHRHlHNUpQRUN0UExyd05Xc3hXLzJ1OEEzMUV5?=
 =?utf-8?B?bGJxL1p5eXdWQkZqdFVPT0lEMEV2S3EvdmpTRzNuait2aWF5RXBjdGpDclZV?=
 =?utf-8?B?SWx3TWpOQVRZd2RTTkRYT2diL0YwWG9lUkU4YWhhT2UvWG0xTlJEZmlBQXZJ?=
 =?utf-8?B?NG9WTDRZbHIwZFp4OGEwUG9DSTZNZG5GWFF6U1pVbzNOc2JLSGduSzhjbnRh?=
 =?utf-8?B?ZC9SRWVuYTN4ODRkSE5DYWZNVnIxRUZPRm82dUlQNjFscnhCbFRiQm9Ua2Nj?=
 =?utf-8?B?Z3RuaDFoUEx2Q2QzMnpxY21sdmtnZFBOQmFoclVNTk13QW1PZ1hmQTVpZmZy?=
 =?utf-8?B?a29YQ0hoY0p3L2dYLzhsRndTOEY0UGpxaHV4TFRRNHZ1MVRWQlM4dGhsYWlO?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB3464A1352B524691A2BD82E17A362B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e6b835-5c2f-4bed-6287-08dd8d1b2f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:56:45.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgZZSalhhU69c5bMWt05xjWVdPjMsOscp6OTd8Wwify7/iMBmsw6t8R6pjyKfg5L69fjpT7Eey5uQ4pF2l0eOAguzE/RMY9EQaRXW9MvjAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDEwOjQzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFbnN1cmUgdGhh
dCByZXR1cm4gdmFsdWVzIGZyb20gYGxhbjc4eHhfd3JpdGVfcmVnKClgLA0KPiBgbGFuNzh4eF9y
ZWFkX3JlZygpYCwgYW5kIGBwaHlfZmluZF9maXJzdCgpYCBhcmUgcHJvcGVybHkgY2hlY2tlZCBh
bmQNCj4gcHJvcGFnYXRlZC4gVXNlIGBFUlJfUFRSKHJldClgIGZvciBlcnJvciByZXBvcnRpbmcg
aW4NCj4gYGxhbjc4MDFfcGh5X2luaXQoKWAgYW5kIHJlcGxhY2UgYC1FSU9gIHdpdGggYC1FTk9E
RVZgIHdoZXJlDQo+IGFwcHJvcHJpYXRlDQo+IHRvIHByb3ZpZGUgbW9yZSBhY2N1cmF0ZSBlcnJv
ciBjb2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBw
ZW5ndXRyb25peC5kZT4NCj4gDQoNClJldmlld2VkLWJ5OiBUaGFuZ2FyYWogU2FteW5hdGhhbiA8
dGhhbmdhcmFqLnNAbWljcm9jaGlwLmNvbT4NCg==

