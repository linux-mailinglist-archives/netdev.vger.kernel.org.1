Return-Path: <netdev+bounces-158384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB4A11857
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 05:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EEB164DC6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918E22DF82;
	Wed, 15 Jan 2025 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Zzb7SdjS"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC52746D;
	Wed, 15 Jan 2025 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736914945; cv=fail; b=Q7YM9ugCXqIjYkRWeeaNoybBF5KlkLrNP1XB42wdg6b9/9OOV5E8czewbRIUVan0C4dKTryGCl3bcILphHr8TqHgMA9ZPUY84W+YWXd+Y8qfyIN5Bt3bl9b/c+mAMv4JXHROq90edwsEw6EIHv0WCOO7OW6JrVw/MadXAMoq00M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736914945; c=relaxed/simple;
	bh=KRpkm/OisHnyUp1QJCYTRRsVMyfyR1aSPP3zAmhuH98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpvcnx09NgYvWAJSBzwjUrFmFnU73rI1izRkZvGu6RRb7YTFbn11Nse6CuNpMUYoHtpR+QhPvptKnINDOyvxVFWvieZqYsN8skefGGNhb8nPlwqyyMkojixYdxc6QNcRfmh70Wb7AVbQcqKmjcPAfdpmfWe1upcX1hTnDvTQdjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Zzb7SdjS; arc=fail smtp.client-ip=40.107.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVEY0fIJ1xKiqtbS0lDFN/ppoj9zN3Pm9mriPQqH/lfM4xDQOwaZnM6QkATh70h6oy8XRu+tw8nlmhuzc4UuJy1z4CGCDejBl6fjDgOELhRRbmfBX0SFiW+1WqpGNJJWUzEmgVVcDt8rVDZCMgj0F7iDRROJoLlowWG5t/njOk0WGdgZKKftv0MchvsZzf7kGIds/7TAh/rGwLnkeOxqJM9DwZernbT2fa7hHeLIlLc/9iTAMxP4LCg7uwXB6w0ihPqTFJrQyCTLtO5LHh8LBGTVTq1fyOuViX040G7NKy9cQI3WX/KMNhxDtZWGEuEODe51yj2kD9wIdRQlo5jk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRpkm/OisHnyUp1QJCYTRRsVMyfyR1aSPP3zAmhuH98=;
 b=m5x2R3P2x71KLmHBtymm9AX+gxlWQ3HuPkJpUeFLqFhQXZ9QGoCP2LjYKOqj9j56SY8y90oxlxaXwep3unwj7VHR2mk6W5ubZP8rQhesSqJGDM1en80yNCKUaQuBB9hrSc8gshAkRgVAVMKJb1altg9tvb8tmDXy5xiG2SgAZtT2JWSPFhNy0e9mKQkN34L42bgvklCg6My2qXLhMAV6Fi15Z2J1Ik8Jf9vt0y0vtKA+U6TDrpvfxmEMheuBavzZrJz/HHbKrihHPVLhIk4WiGUHHUx3uDrmAfvm1dQ08YKrPh+I6PnPJmzYeKb9kB/ROxvaws6QEmcu3tgqSeqjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRpkm/OisHnyUp1QJCYTRRsVMyfyR1aSPP3zAmhuH98=;
 b=Zzb7SdjSo8I9BTZ4HROCQkyH07OcoGbS2G99KIutQifTcfuteLIu2/tuIYHr8ULsi6JFWLqpPl3tqDqv4c4aSknsNmxYtRD/m5MkZsG0LIBGrNQjUgBL9/xhUSKgOE3lj8mKZjPplPK9KYz0t9/eYIEOYuvMevst4oDh6tFE+oMVI2uhdS+ALHTD39dvwSYaRj1Esh0s0VF2uGAwcv20dW3hdhKdh2br33B82QOSx5Vd2A+EFOzuB03zmf9jKnTlknn45t+ZZ7sFdCqiBN/nIela97RZRUDZ5jLUX4LWwsAaNrChqGJT4iO+zQAlcW4KcsHPIpLS0nwV3KWMHYVePA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6602.apcprd06.prod.outlook.com (2603:1096:990:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 04:22:17 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 04:22:16 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Ninad Palsule <ninad@linux.ibm.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBB?=
 =?big5?Q?RM:_dts:_aspeed:_system1:_Add_RGMII_support?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0?=
 =?big5?Q?s:_aspeed:_system1:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXCAAFgBAIAENTRQgACHsgCAAAOEgIACXbCwgAAFSQCAAAD+YA==
Date: Wed, 15 Jan 2025 04:22:16 +0000
Message-ID:
 <SEYPR06MB513402FD4735C602C5531F499D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
In-Reply-To: <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6602:EE_
x-ms-office365-filtering-correlation-id: 8e20ceca-949a-42d7-83b2-08dd351c3196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?QzIyL25GcGFzN1k1SlRsOTFUL0dCbGlrcjNQTjBJS3pOV2lUVGdMaytWWGw0WlJh?=
 =?big5?B?aFBRZ0RsN0k5N3lsQmhHUFlpa0plNWZ1WEVJQTZjeXlaQXRTM3lYZlZtZU50bVNM?=
 =?big5?B?SjhvUlJOa3pPZ3RRSTJjSnkwWFZqTFlZVHJqbEpwRjAvaVEvQ0hDTVpKQUVIejBI?=
 =?big5?B?MVcwMGowQklqaDJzdXowWFBFdzFINnhLWXpYZ1AwczQxSjBaN1BiZXpka09kbDRz?=
 =?big5?B?MGRmRzlDMHk4M3g4SytPREI0aGp3NGY4OFY4WTBGUmtrYldTMHFiM1ZqcEYyTXVD?=
 =?big5?B?WjN5bWpCZ3luYW1IekkwUVprNWlaMEJYeVBKZ0svQUlsV2tmZXNTemVYNEdmZVg3?=
 =?big5?B?UHdpYkRyVVFweDZhUGltOGoxTWRmemhhWHFuNnptTUd3WDFJd2lQRFNqR2ZMY2tX?=
 =?big5?B?NWlNSW9MTGJQTWl5S3RRVjZqN09rSUhwUS9nUWNWS25udXdrK0w1ZjlUOGRnL2hr?=
 =?big5?B?RCtuSk83UEJ2am1HdVExNTNvb09tbFBUSHhjd0dJWDZTRUphcWgwY3BOMDJ5WGFY?=
 =?big5?B?OWtWS1pwS3RlZTVJYlV0cXBmTUFabWhtOFVVVHVjdHNyR0JzVTRCK2p0b05mWXNL?=
 =?big5?B?UEl2NXI3a3FXaXVSUWpuaDZMU0xydHNwbWpyTkNvUGpsaHMvU2hTcTRXZEl4QW9j?=
 =?big5?B?aEJhUm85WGxuYzFiaWlQTGxCNlg2cm5xbjV3WityeW03WERMZVlUQ1YrRmQzMHdF?=
 =?big5?B?T0s3aHRrTjJNOXh6K25mYmFkLzMyd3FUaTNjTktKZk5MWVEvdGQvTHpjM2g0OHVW?=
 =?big5?B?OGlSRUNzOUtyZnNBRjFGTmp2cHVCblJ4WDlNNzdLRU1EVEpGQ1k0NlhESFpOTEky?=
 =?big5?B?Y1d3UW1tVThHV1R4dGlJUVh1UzJRWk5KQ0I3cnprcG9zRy9qOUlsSVM3ZkJkZVNV?=
 =?big5?B?a3hUcUlYTzg5L1ZCZWJ1dTJ3eEZvbWxZRWY5eTlESE1zb1pPVGFnY3RETDMyNG1q?=
 =?big5?B?VjRORHpYLzJmdW1lZ1I0T1VyME14NlR6OGxYK2pDbGpobEUyZnozKzBSOVBmaEJh?=
 =?big5?B?WEowU0JLbnorSCtvZ3VFSHlKZVc2Y2hVWW5NeE14K1Z1Tnl2Q3FqL1lSMmhqSUVh?=
 =?big5?B?S2N3cU1WLzZ5ZDRTR0czQm9jSy9NZWgzc1U2VmlJNmFPSVkyRWtCakprUnhid2Qr?=
 =?big5?B?N3VDTWNVYjhsM21meTVtZ2hwWW9tMXRMYW43Z0FwR1FYOUN2Z2QxdEdxZVJIWXlm?=
 =?big5?B?OGRlRTl3allVdlBkVmo2QmlSZ0htL3p6M2dBeVd6NkhVYllnY1k0WjNlUHdXdE9V?=
 =?big5?B?VTJqSk45cjlHODBYalBaRFcvSlordmdib3FXQ3h6NHpBR2R3NG5iVG5mMktMUmti?=
 =?big5?B?SmpNR2pRUDFWWEEvSHF5dWNlaWRUODhyNFRnZTdzMldRUW5qVFBUOW8vbFpkaitO?=
 =?big5?B?L1RTSlkxaWh2R3BYUVFYUi9vcG5SV05kSDY1Rzd6aWJneGtKR2VHamZUdzk5cEZR?=
 =?big5?B?dkozK2EzaXFBdnFaQnhSZVJ2b2gwOG9yWHpLdGluVjdlVVJvRFVmYi9IRjlyOGM2?=
 =?big5?B?L2hMUCtEK3dwVW9XUm94VDRXYlNGR2U1QXNLUGhoT3F1eEoydVd0Y1pqVkxkTzRH?=
 =?big5?B?TFZodjdjS21pTGc2WEd4YkFDWkczUzBwZW5OSlBFRWdNOUp5WVE5dlp1eE9jejRy?=
 =?big5?B?Zkc2K3J2WUJ5OHFicFJ6QnEvZ2ZsQjVDYU9tckpMOUhCTzJ6T1oyY25iRm05elhM?=
 =?big5?B?OTE5MHJoK3FUcHk5cXJTMkdNa2YrNG9uZWdGTktjM2EvTzFHeGdWYVZUL0EzalE2?=
 =?big5?B?SUd0c25rMXZlUVVZNXp3d3U5a0JUVTZhdUd2NzQ0RU1kWGN6dndYd0orRXpaQVZV?=
 =?big5?Q?rxqsXPM4BQ3aKKBLeMRYV2DNqoDdtu68?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?R2xZcm9HeGVub2I4SkRuQ1h4d3hWSGJITExSUGdJSlcrb2djaUVBQlU1ZHlqRUJu?=
 =?big5?B?UENVZ0EyY3duNjN6a241OUliR1RrZTR2QXJuMWZFcHZSYm55QmFHVHoyVGxCbm5D?=
 =?big5?B?MW1vUDNKUmlrY3c0VHNzanRBTjAxQzVzZStmc3hMcStTR1ZYekFUSm5leXBDTGxH?=
 =?big5?B?R25SZTVNSVU5dG9MM3d1VUd6RHJlVGpoZUNYMEwveTlFRzBUTVViRExPRUo0Wk1I?=
 =?big5?B?T3l3c2grOFphRkJjV3JBOG5pRGYycmxCdXlUb1ExSjVXQW1raDNaei96V0xlc1B6?=
 =?big5?B?UGUvS3IrTTVMZ1ZCMVVnTHdFRmMrYURzSkZBVC9sQnBqamNqd3dVdTF6cmpZYWR6?=
 =?big5?B?R056cDlwYlVISTVSTFcrZEtqZnpOQTFQQkh2N3N3ZENTQllrbm9LeEQzRnd6WWNS?=
 =?big5?B?NDd1ZUNJNkJKL25mM0ZhNWhEeCt0S0pQR2NUSW91OXplRkxBcDF3WkE0cTJiUnpB?=
 =?big5?B?MzRNcHQ5aU42emxRZElRTFpFTmdhSGJ0ZTJnL0lUK3FkcENPdlFKQlpDRVpZSEVn?=
 =?big5?B?ZXdldkFHYzZnVGVJQkNyTXFrbVNuYWlkSjJweDY3ejVoMiswekdVcHloOFUzUXZp?=
 =?big5?B?bGk0UU5XeUlta00zd2RVdEtWMktqdmVaSnRReWh0ZzJ5UU81djR0c3A1b1pPS1ZK?=
 =?big5?B?bWc1YzRmREtTVkFxUFBvd21pYWZxNVpmRGtjYU5lMDFqSWltbVkzOXdyNmpxakM5?=
 =?big5?B?TGR2emNXQ3JhM2N4T2JjQjY2RENXQkRuazNRZllGU1ZZeUF4R05yaTd4TXJSNVJD?=
 =?big5?B?cElJSHowb0poQjRVYUVlcTdJVzFDVzVMV0lHdXM2Nmp3UzQreVdaR3BtUU1wQTFR?=
 =?big5?B?VmVya21ZS3JFTzJBekdQMEFSbGxUZHg4TmxQWmpnU2JrS2JlVVJCemlYNDhmajNC?=
 =?big5?B?YUQyZEZKYUdqUjFIQzNjd09KdEVnYkxENlRwUy96VlJzV2dVM2FDYjVOaUg3VEE1?=
 =?big5?B?UnNEVnlxaUFVOWRMTWx5c29mNnFkWWw4MG9XYytLMXNsVmZrY2JrWG9HZ0czTEZi?=
 =?big5?B?YkhZVEtpNCtPSEQzc0lObEd6MTR4azFtZm1OYUpMRUhuZjlqckF5citob2JoMkxV?=
 =?big5?B?OXBnWnNhTEdoSmFyZmVNcitKL3NXRkZpK1REa0ROQmd5WC9aS0E3c05FZWtkV1A0?=
 =?big5?B?aVpRODFSdGtjb1lvQTdJT3J0YUhoUktSdmIzU25jRGdVK3E1NEhJMWIvMjh3Sjha?=
 =?big5?B?RExnT0VzSTk4b1lVUDh4T2VHV0lyK3NiUDJhM1lSeE9DSlpyNWlZY25NeDdaT3V5?=
 =?big5?B?eGlIdVNoK1JXSW9tR2haemtPUTNUK3dzeGt6dGpqc3BkVmVCU0ZiY2l0UXkxR0xG?=
 =?big5?B?NktnTUVTUDFQUU1Jak1vZHNnNnE3NkUyT1lsTnErelVhQTFiVW9VYkM4endQc0tz?=
 =?big5?B?elFUUXpDSzJKRU4wb3hlRDhQMzhRY0ZjaytmeURZa3Rxd0dDUEs5ckFwZ2xOUWZv?=
 =?big5?B?czVERnpmQXJmUkNEVFlOL2JhcmxYTnlnaDFMTHZsclAyOXpURDEyRG5UREQzcmxT?=
 =?big5?B?c2l4UmhiNWFJNnB4NnNrVW9ncG13eW51UUQwaXEvcXZhR0NOaXJaMHNLMUJZeUNq?=
 =?big5?B?WnIxM05WY0xUejRrMzlBK0RpVzhkRjVWZHpHTExqeGNnNnM1VkJORy83ZVo3OFJW?=
 =?big5?B?L2dqcGJML2VhenlERHZKMTJPUWdUWmE5Ynh5SUpjRXFiQi9URHpkbVo4Ykd6MFk0?=
 =?big5?B?Vkh6cFc3d0hGeDB2VDZ0enFKNStCLzYrUkVPaVhVa3cwSFgxcDRCdVEyTzQxT2Fp?=
 =?big5?B?QUR5a0dOV2U2U1NkbGdCdEZUeTlyNkRhZmljVWtJVVVHNW8xTmgzRG4rZk5sMmFl?=
 =?big5?B?US92QXY3am00eTFWdjRneVluRUY5bWVPamp4N3ZXMk4xSnpyVnBsWlgwRThoUlRp?=
 =?big5?B?VGlTM2VGM2tBSGlKK0ROREJJVkd3c2ZvKzI4YXlBOGIva09lSkZYZzdYQmF6MTR0?=
 =?big5?B?eEtqeDd1bFRhckhza0JLbDVMaDg2UEVvNmRDOWNxV3hoZUk1Q1RrVzA5K0xaN2Rh?=
 =?big5?Q?09fDappBkvwfCY6Y?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e20ceca-949a-42d7-83b2-08dd351c3196
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 04:22:16.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKTu6znj+boVCyQdDoABqJvVd5HG+Qm1kotqWI9G2g5F417AfR8BgCj3z9YXiJVWyRsqzu040EMm6w+LcZB2/1L7sWOsFMfyL/zjWUsodKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6602

SGkgQW5kcmV3DQoNCj4gPg0KPiA+IFBlcmhhcHMgd2Ugd2lsbCBrZWVwIHVzaW5nICJyZ21paSIN
Cj4gDQo+IE5vLiBJdCBpcyB3cm9uZy4NCj4gDQo+ID4gVGhlIHJlYXNvbiBpcyB3ZSBjYW5ub3Qg
YmUgc3VyZSBhbGwgUEhZcyBoYXZlIHN1cHBvcnQgZm9yIHBoeS1tb2RlDQo+IHByb3BlcnR5Lg0K
PiA+IFdlIHdpbGwgcmVmZXIgdG8gdGhlIG90aGVyIE1BQ3MgYW5kIFBIWXMgZHJpdmVyIGFib3V0
IHBoeS1tb2RlIGFuZA0KPiA+IHJ4L3R4LWludGVybmFsLWRlbGF5LXBzIHByb3BlcnRpZXMgaG93
IHRoZXkgaW1wbGVtZW50Lg0KPiA+DQo+ID4gQ3VycmVudGx5LCB3ZSB3aWxsIHBsYW4gdG8gaW1w
bGVtZW50IFJHTUlJIGRlbGF5IGluIGZ0Z21hYzEwMCBkcml2ZXINCj4gPiBiYXNlZCBvbiBldGhl
cm5ldC1jb250cm9sbGVyLnlhbWwuDQo+ID4NCj4gPiBBdCBzYW1lIHRpbWUsIHdlIHdpbGwgdGhp
bmsgaG93IHRvIGNvbmZpZ3VyZSB0aGVzZSBwaHktbW9kZSAicmdtaWktcnhpZCIsDQo+ICJyZ21p
aS10eGlkIg0KPiA+IGFuZCAicmdtaWktaWQgaW4gTUFDIGRyaXZlci4NCj4gDQo+IEkgYWxyZWFk
eSBleHBsYWluIGhvdyB0aGlzIHdvcmtzIG9uY2UuIFBsZWFzZSByZWFkIHRoaXMgdGhyZWFkIGFn
YWluLi4uLiBUaGUNCj4gTUFDIGNhbiBhcHBseSB0aGUgZGVsYXlzLCBidXQgaXQgbXVzdCBtYXNr
IHRoZSBwaHktbW9kZSBpdCBwYXNzZXMgdG8gdGhlIFBIWS4NCg0KWWVzLiBJIGhhdmUgcmVhZCB0
aGVzZSBtYWlscy4NCg0KSSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uDQoicmdtaWkiOiBkZWxh
eSBvbiBQQ0IsIG5vdCBNQUMgb3IgUEhZLg0KInJnbWlpLWlkIjogZGVsYXkgb24gTUFDIG9yIFBI
WSwgbm90IFBDQi4NCg0KZnRnbWFjMTAwIGRyaXZlciBnZXRzIHBoeSBkcml2ZXIgaGFuZGxlIGZy
b20gb2ZfcGh5X2dldF9hbmRfY29ubmVjdCgpLCBpdCB3aWxsIHBhc3MgdGhlIHBoeS1tb2RlIHRv
DQpwaHkgZHJpdmVyIGZyb20gdGhlIG5vZGUgb2YgbWFjIGR0cy4NClRoZXJlZm9yZSwgSSB1c2Ug
InJnbWlpLWlkIiBhbmQgdGhlIHBoeSB3aWxsIGVuYWJsZSB0eC9yeCBpbnRlcm5hbCBkZWxheS4N
CklmIEkgdXNlICJyZ21paS1pZCIgYW5kIGNvbmZpZ3VyZSB0aGUgUkdNSUkgZGVsYXkgaW4gZnRn
bWFjMTAwIGRyaXZlciwgSSBjYW5ub3QgcGFzcyB0aGUgcGh5LW1vZGUgdG8gDQpwaHkgZHJpdmVy
Lg0KTWF5IEkgYmUgY29ycmVjdD8NCg0KQmFzZWQgb24gZXRoZXJuZWwtY29udHJvbGxlci55YW1s
LCBtYXliZSBuZWVkIHRvIGFkanVzdCB0aGUgZGVzY3JpcHRpb24gYWJvdXQgcGh5LW1vZGUgaW4g
dGhpcyBmaWxlIGZpcnN0Pw0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

