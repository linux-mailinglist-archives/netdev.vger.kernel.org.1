Return-Path: <netdev+bounces-302908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /4HiH0oxQ2onUQoAu9opvQ
	(envelope-from <netdev+bounces-302908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA486DFF0E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:00:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hotmail.com header.s=selector1 header.b=Iz0MpEGX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302908-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302908-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=hotmail.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E443007CA4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2F3D0932;
	Tue, 30 Jun 2026 03:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012055.outbound.protection.outlook.com [52.103.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF432D0E3;
	Tue, 30 Jun 2026 03:00:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788423; cv=fail; b=UtP28113kzmAaP2DESFuuQN8a0JcNxXMKRvy/cuCkR9BUafPY2K5Wbo+MYWgV9Tsvs92feYgiamzLQCvcsWphYJLQ3x8K1VvnLyHtxtPT94ksLR0GOJy0Br7dFTY+TEOOSfKCZIKhZCm08ykvQhN86yZaBbzrpB5ZukfwCOy4JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788423; c=relaxed/simple;
	bh=YyXwwttf++UbQ/t0ElwXy7kcUI3/YtrMkMf6+umkhQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hrW1YtmgLvK5v0ISyJYaa1K2tkZy8xqWyKziPqPkivyE6hoar9GqHNX8b8WCNtflg3X0ijc2WIkXCcsLfak1eASVMo8NCzk/kHWp0c7LGVJivWmXOcgP/m6FYZLslV3mSC0YVbMgi5xaHy17xSZEu1NVx7qrlAsUFsZ9uflElto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Iz0MpEGX; arc=fail smtp.client-ip=52.103.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv1H9kML4vArygL8vdvPvktoJI0JIMDwJVY5uf/3Bs/a8lKg1hvYYKJ+pYCwk3XtA7a3OqDT0MZsD6F9zVoK96SmjhYw15+rLHqGkgbtXLo8NRAk34qcg1yKhhqhQ3GfwSpsT1FzZb9klbKeUfO2v+m96uGn+n2HY24Ah3+npkgxofLD+QIjR5BBcZU7/IJ3vU5Xocg/OnshuDs4JHCxqfWa+21uM9bUx0N5uHEObsP28ytKycX0HKxYoyQOYwPElzSgDLUEL0YkXQde+UIrwIkce6oxGzBOkeMVA1DR1qQSxmN8eoK4Togc4yH6umM+OwmGhfKZyCEJbysAxO0w2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyXwwttf++UbQ/t0ElwXy7kcUI3/YtrMkMf6+umkhQk=;
 b=mqbXzVXbyaOrU8/iIUp5fZjoQwo9I46xXw3TzlCY9KZuQLToa9UO/mWFvDkfPFcodnQJi6ewXiz/wxuECejD0U9t95+G2g18DvpYAnIcohAkwx+fcBD4+myUwLl6vLUprJ+UJB2sU4oBlqLjt51P1CkyYZe9t+8BOBLCTq0xKHwoIRLQEnWhVX6+Yo6d4S4Jy430XFARZ8pQM13MtiRhwEY5c89mLlRFAlAYqqZgAB57GTZRSafNa7ECKSofrdFiJ/5NariEPDciTtAkKi0pmVAWcdVvAWQRm4gEXlxTgjGykNxtq5TS6U/l0SK6yD/QpxAKbncHcBIB9NXdiJi9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyXwwttf++UbQ/t0ElwXy7kcUI3/YtrMkMf6+umkhQk=;
 b=Iz0MpEGXITVhv8YFFb3Hm+8d9VAALXhKLyxiVc7qOW9Fs0VuQiI2wj7fTGcpJe0ndPtfoeak/CrikzTzQPk8lp8dVGiMepRogxoiNaByYM3tNF8T9T+IoFuaX/QA5eRsSvLt7I09mKHTf1jh7+vs9YGddQ7e+ZXXGSxDYarrSxesTTrqlZmK3mv9vSrsm0UI94GoOjI6quWq0HEmOohdGlM+NZTT6ma6Um90FLGyYXvKGXnOLd+9klesQroNq2zVS1vSNsqmCuj+QEOvuLc/REMXnaUVyaVgq2nlIKEkP5QdwptmqIYMjadr2vU0W7aqeHhhiFKFzzdVM+Wp8CabXw==
Received: from TYZPR06MB6916.apcprd06.prod.outlook.com (2603:1096:405:42::10)
 by OSNPR06MB8592.apcprd06.prod.outlook.com (2603:1096:604:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 03:00:18 +0000
Received: from TYZPR06MB6916.apcprd06.prod.outlook.com
 ([fe80::e814:9b12:c9a7:5f4f]) by TYZPR06MB6916.apcprd06.prod.outlook.com
 ([fe80::e814:9b12:c9a7:5f4f%3]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 03:00:17 +0000
From: Kir Chou <note351@hotmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
	"davidgow@google.com" <davidgow@google.com>, "visitorckw@gmail.com"
	<visitorckw@gmail.com>, "brendan.higgins@linux.dev"
	<brendan.higgins@linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "kunit-dev@googlegroups.com"
	<kunit-dev@googlegroups.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Abeni Paolo
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:NETWORKING"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3] lib/random32: convert selftest to KUnit
Thread-Topic: [PATCH v3] lib/random32: convert selftest to KUnit
Thread-Index: AQHdB4oCRDvxz59XqEyNwDocm0uKwLZVPLuAgAEtWYA=
Date: Tue, 30 Jun 2026 03:00:17 +0000
Message-ID:
 <TYZPR06MB691672076025A5A6F476D90BE8F72@TYZPR06MB6916.apcprd06.prod.outlook.com>
References: <20260629054143.7737-1-note351@hotmail.com>
 <CAMuHMdWMx1zAgnzkoYqDB8TOu7s93L4f1PoeXVpYm1n4=dESnA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWMx1zAgnzkoYqDB8TOu7s93L4f1PoeXVpYm1n4=dESnA@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6916:EE_|OSNPR06MB8592:EE_
x-ms-office365-filtering-correlation-id: b83ce693-cd99-44d3-810b-08ded653b729
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|25031999004|6072599003|14091999006|24021099003|19110799012|8060799015|8062599012|41001999006|39105399006|4140399003|31061999003|25010399006|22141099003|40105399003|41105399003|102099032|26104999009|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2xLOUVSdjN6N2UwSzRMcVVzT1pzS0x1UGp0ZXV1ODNFT1hRelVLMkNURURN?=
 =?utf-8?B?azhxd3NNZG1ZOUZ2T0o1UXliWTZYVEMrZE1iMkRqLzVHbW5jSW9UdWNzV09k?=
 =?utf-8?B?bi8rWFQ1RXltdnAxQ2hGVlI5d3ZCMU9mVVlVSG9uK3JLaTRseGFZV2tQRVFW?=
 =?utf-8?B?VlVLcHpJVzkzZ0JuT3o3cDZRMDFncFg4ZlFKUmFpWU1rNzBGU1JSSDhXdEFm?=
 =?utf-8?B?WmthODJ6WVc5bDJLSitZR09JdjduTUJDNFRjZ0sxYXFLcCtvQkZ0bnVYb1RQ?=
 =?utf-8?B?RXpVN2xodnROTmJsb3A4T1ZlQ09JRlZWZlhCUkxRS2dLQ2RmR2JlVlllazhO?=
 =?utf-8?B?d21nVmlJK2dSRWt0SjdCRDNybDBKSHRCZWRwelVSVGdnNk1kRFdQaFlsQmx0?=
 =?utf-8?B?Q3JOY1lnTEpOWVlCWVNiNzUrc25sYlMyYmRKajBvUWZ1SDdoTTJYbVdLTjY2?=
 =?utf-8?B?bEt4bTNMNExwWXRtcnBYOEFQaHc1ZllXU1h4Mi9kc0dDWHVVN2VpNjB1aFR4?=
 =?utf-8?B?OWF0VjNLUzBEMzJNOXJFU1hmTUpsdUd6REJZQzF4MVZwelZHWXdzYUVpdzdH?=
 =?utf-8?B?YWExKzFGK1B4UklnbEZ4VzJIci8wV2J2dHc3eTNsdzV1ODlQRWpXRDMxaFMr?=
 =?utf-8?B?S0E1anJXbDBWak8rbVBhaU5SZkRGbTRCUUhPVDVPVXFZd01lTjNRbW9TME4z?=
 =?utf-8?B?NFFNY21GT080ZG5QQ0pJVk1TMEVCNE42SWh4YllkRHR6QVd3OU5PdUdFVkUz?=
 =?utf-8?B?TnRZSFRUUmZmeWFySjYzSlQvWldUbkJHb1I5UkxZQkMwb0xkSU1BQlBOS3dQ?=
 =?utf-8?B?aUc1RVVIZnQ4U0RaYUFSU0R1VjU1eXJXanRuZTNqMUttWEJSQmYyalVQQmdn?=
 =?utf-8?B?SkQrSFo1OTZsT0gvSm1WLytERHQwb29qdWkyVjJkUWtVZ1pqWW9BbWt5QW9n?=
 =?utf-8?B?S0QydWNJN2M5RXF4Wk5LWEhCRzlZc2h3VTM2ZnNZRjlmdnR2b1YyK2MybU9l?=
 =?utf-8?B?SUpZdnVvbGN5MFRvWFplbklUZVF4YzNNU0cyUGl3L3RTcmpqSTRiM1NaUzVT?=
 =?utf-8?B?aXBKdEpUbnczdmVlMGpIajY1NnRpT2ZmcmhKajlLYkZBK1prOExoYXJXbjE4?=
 =?utf-8?B?QmdRaEFkVnRndmlxekYxcm1Xd3ZXZ1E5VStwdUw3TlNqdFMyQVNOZmF2Qmoy?=
 =?utf-8?B?K3paM1p6MWE3RXIzU0VjZ1dWRVpKY0ZpMWM4WHU3U2lZZWRmeTQ2bWtKaVV5?=
 =?utf-8?B?SzdvVUZ0d3hTeHl2c09hYmRnSlBRcW1jUDIzMEROandkWWx6Q240R251UzI1?=
 =?utf-8?B?Y0NjSnBYYlUzMWk5VkszTkUrREhnOUdXY0doNjU4QnNyTVAxZ01sb0pqRllJ?=
 =?utf-8?B?cENuVkRHQkI4RFVDY0NncHZxWHhBZytTa0tybVdyaGhiSUt4MHMySU5YVE9y?=
 =?utf-8?B?c05HWGQwTXR2RXgvQlp2YXBGQjVlUnRyUzVNRzFSdTRDcGo5MDR6NThyRWNF?=
 =?utf-8?Q?59bz7Q8Dr5yfwKJFumy03nNRrYj?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzF3ZzQ3bENqY3RTMzJ3aTZKRUJPZVRyWUVRMmZEenpOWkUySHhoN0JkeVQ0?=
 =?utf-8?B?TE9tK0ZOTzdoWi9mMVhsVGlBK09Kb0Y0S3M0QmxESXk1YTJ3SXFGWGZzTzZG?=
 =?utf-8?B?MjBETGZMTzVZaVRkRFljKy82a3hsZEYxaXdOSmRqN0lJY3g1ZGtGSWcxVG0z?=
 =?utf-8?B?bUtRNk1aZEhUblBOdWlsWGV1SU5kaGYvNTZDMG1GSEYwRFFCcmhlV2paNEFX?=
 =?utf-8?B?RHU4N2RHNkdzWnJ6OXVkeEV0T3Vudjc2dzJtb0IyQUFiTldHOE50RVhwNlVC?=
 =?utf-8?B?U3F2NzRxZWFPRTlGT3cwS0JIa2dtZUVtT1hTVHZkdWg4eWZHd2NRcDVqdVoz?=
 =?utf-8?B?ejVwbk9GSkFWWG4rUjgwMmdJQllXVVN6Mi9Denh1bzN6ZGs4eUpKOXVDSW1q?=
 =?utf-8?B?ekFnU2FoTmMxQXlISmwxR2Ntd2ZPcjkzQkFTVW5RRGhFeHBEOTU5c2N0Y2M0?=
 =?utf-8?B?U01wdlhCSjlUMThwYXlNZFVHRE9EN002SFpXcTNuRjJoUG51L0ZNUGNlNnkx?=
 =?utf-8?B?L3c0LzhDUGhldHA5MDNNTnY1eDNTOW9NUDl0NW42aTEwR1I5Y1ZaZWF0NDly?=
 =?utf-8?B?QVpRa2xwdDZIblJlMklxNGNZeXhrNlhJeVRkWlVHL3o2Q3hBcHVXb1dIamZH?=
 =?utf-8?B?VVdvMldUZTRWQU5haU1zU0k5SHBlZW5VaysyYmFTcUpyOFBJM2RTN0IwT01M?=
 =?utf-8?B?eXpBTFVKVFJwd2JxZ0VaRGpBUjdrdUpIVXF5Z09wSitOclBDdTU5WnhtRnhZ?=
 =?utf-8?B?NzF3UkRyblJScFRVeWJqK3grRHRiai9OeXRHMFkwNU03SkFOUlJFbm4yeExm?=
 =?utf-8?B?ak9BTExXTnRxMFZoblU5Z2phdk9JQngweHNUakhjYkNPMHczV2dhNytPZzd4?=
 =?utf-8?B?VjE3WDhDY2JJMkR4dG95blhSaE8rQUJ3T1BuN24xTGpUNjZITzdUdS9rMXRV?=
 =?utf-8?B?eEVaL253NHhlR1I2UXB6a3N6OHhtckJwOGl2dk02T2tNbVpLZXVEZDhQSWtP?=
 =?utf-8?B?U2FOdGFvcTdnTkxERnNpZEs5WWVzYmNzc3RXT3BKVjBxdG01bHdmakprZkY2?=
 =?utf-8?B?K0hyK1MzMnppSjJDMWFVZU9GbWtMSzBLVTVISGhXWU9FQXduNzdNc2ZKNE5y?=
 =?utf-8?B?bW0rMUF3Vng3d2E5d2hBSzdNcnhGbDF4YlA2ZUg1YmMyWHdCNk0xclJYNjdy?=
 =?utf-8?B?K2ZPVE52ZFdVbHJKN1pCTFZjUXllNmY1cWZJNi9Od1FEUlB4Z1QyVXZYYjJ6?=
 =?utf-8?B?TjgwQ3lJR1BucWZQRTk4b0JBL1NxZnRNZFN4UjVmdURhV1IzTURHeXZ4aFcr?=
 =?utf-8?B?bUU4ZlExT252WldoTW9lRFlYWTQ0dWUyekEyc0ptSWJxbTRwMEMzWWpMWWdm?=
 =?utf-8?B?QkowcC8yRm1oeG1PWWlXbFFBWG8rRGRYQng4VTFtOCtMdVM0UTFLdzJCNENQ?=
 =?utf-8?B?aFZ6MnFtamRWVUhSbXNpNEZwTmlUMitvZlRLVTltQ1hhSVVuV1NZODBxRmFa?=
 =?utf-8?B?aXgxOExkbkdOQWxFOCtYMm1LUHJPbGpZR3lnNnNMQ2pUSDQ5dU55d1hhMWFp?=
 =?utf-8?B?ZnFRWkt1akUvaDJ4U3lNa01PSTl1N2JzYWpGbkk5d0JacTdsVlpBQ3FzL215?=
 =?utf-8?B?ZnpGc2tMTnFHRVRDUUxGSEZETHg3cVhRZ1o2VzV0cldtcndoNTc0VjU2aS82?=
 =?utf-8?B?b1hsb2kvWnJSMEVBU0ZWSzVibnN2emhzMG9TMTZLRG1VQTM0L214aVc3dTlQ?=
 =?utf-8?B?c2NoeEl4Qmd4SjJmV3VHRWdQV21pV3hhSVJrQWN0QXY2ZnFjYUsyVFQzNjhn?=
 =?utf-8?B?YnJSWm0rVUZrNjBhUmRHelViYTdwcVcwNEdwSkNxVHd0Qk9yOXZHVmVEMmNw?=
 =?utf-8?Q?NEWTkHw+pSW2V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-25b72.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6916.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b83ce693-cd99-44d3-810b-08ded653b729
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 03:00:17.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8592
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:geert@linux-m68k.org,m:akpm@linux-foundation.org,m:thomas.weissschuh@linutronix.de,m:davidgow@google.com,m:visitorckw@gmail.com,m:brendan.higgins@linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302908-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[hotmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,linutronix.de,google.com,gmail.com,linux.dev,vger.kernel.org,googlegroups.com,davemloft.net,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[hotmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,TYZPR06MB6916.apcprd06.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDA486DFF0E

WWVzIGl04oCZcyBwcm9iYWJseSBkb2FibGUgKGRvbmUgaW4gdjQpLCBJIGRpZG7igJl0IGRvIHRo
aXMgdG8gZm9sbG93IHRoZSBleGlzdGluZyBkZXNpZ24uDQoNClNvcnJ5IEkgZm9yZ290IGFkZHJl
c3MgdGhlIFNvQiBmb3JtYXQsIEnigJlsbCBoYW5kbGUgaWYgaGF2aW5nIHY14oCmDQoNCj4gT24g
SnVuIDI5LCAyMDI2LCBhdCAxODowMiwgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1t
NjhrLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79IaSBLaXIsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1
cGRhdGUhDQo+IA0KPj4gT24gTW9uLCAyOSBKdW4gMjAyNiBhdCAwNzo0MiwgS2lyIENob3UgPG5v
dGUzNTFAaG90bWFpbC5jb20+IHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBjb252ZXJ0cyB0aGUgZXhp
c3RpbmcgcHJhbmRvbSBzZWxmdGVzdCAobGliL3JhbmRvbTMyLmMpIHRvIHVzZQ0KPj4gdGhlIEtV
bml0IGZyYW1ld29yayAobGliL3Rlc3RzL3JhbmRvbTMyX2t1bml0LmMpLiBVbmxpa2UgdHlwaWNh
bCBLVW5pdA0KPj4gdGVzdHMsIHRoaXMgZmlsZSBpcyBkaXJlY3RseSAjaW5jbHVkZWQgaW50byBs
aWIvcmFuZG9tMzIuYy4NCj4+IA0KPj4gVGhlIG5ldyB0ZXN0Og0KPj4gLSBSZW1vdmVzIHRoZSBs
ZWdhY3kgQ09ORklHX1JBTkRPTTMyX1NFTEZURVNUIGZyb20gbGliL3JhbmRvbTMyLmMuDQo+PiAt
IEFkZHMgQ09ORklHX1BSQU5ET01fS1VOSVRfVEVTVCAoZGVmYXVsdGluZyB0byBLVU5JVF9BTExf
VEVTVFMpLg0KPj4gLSBNb3ZlcyB0aGUgdGVzdCBsb2dpYyB0byBsaWIvdGVzdHMvcmFuZG9tMzJf
a3VuaXQuYy4NCj4+IA0KPj4gdjI6DQo+IA0KPiBUaGUgY2hhbmdlbG9nIGJlbG9uZ3MgdW5kZXIg
dGhlICItLS0iIHVuZGVyIHlvdXIgU29CLg0KPiANCj4+IC0gUmVtb3ZlcyB0aGUgbGVnYWN5IENP
TkZJR19SQU5ET00zMl9TRUxGVEVTVCBmcm9tIGxpYi9LY29uZmlnLg0KPj4gLSBBZGQgY29uc3Qg
dG8gYXJyYXlzIGluIGxpYi90ZXN0cy9yYW5kb20zMl9rdW5pdC5jLg0KPj4gDQo+PiB2MzoNCj4+
IC0gQ2hhbmdlcyBmcm9tIHRyaXN0YXRlIHRvIGJvb2wgaW4gbGliL0tjb25maWcuZGVidWcuDQo+
IA0KPiBUaGF0J3MgKElNSE8gdmVyeSkgdW5mb3J0dW5hdGUuLi4NCj4gDQo+PiAtLS0gYS9saWIv
cmFuZG9tMzIuYw0KPj4gKysrIGIvbGliL3JhbmRvbTMyLmMNCj4gDQo+PiAtY29yZV9pbml0Y2Fs
bChwcmFuZG9tX3N0YXRlX3NlbGZ0ZXN0KTsNCj4+ICsjaWZkZWYgQ09ORklHX1BSQU5ET01fS1VO
SVRfVEVTVA0KPj4gKyNpbmNsdWRlICJ0ZXN0cy9yYW5kb20zMl9rdW5pdC5jIg0KPj4gI2VuZGlm
DQo+IA0KPiBJIGd1ZXNzIHRoYXQgaXMgdGhlIHJlYXNvbj8NCj4gDQo+IEFueSByZWFzb24gd2h5
IHRoZSBhY3R1YWwgdGVzdCBjb2RlIGNhbm5vdCBiZSBzcHVuLW9mZiBpbnRvIGEgc2VwYXJhdGUN
Cj4gbW9kdWxlLCBzbyBpdCBjYW4gYmVjb21lIG1vZHVsYXI/DQo+IA0KPiBHcntvZXRqZSxlZXRp
bmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdl
ZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0g
Z2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0
aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJ
J20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21l
dGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGlu
dXMgVG9ydmFsZHMNCg==

