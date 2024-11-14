Return-Path: <netdev+bounces-144643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DD9C802B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FD12832D9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276842A9B;
	Thu, 14 Nov 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Z3tGAH9H"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023133.outbound.protection.outlook.com [40.107.44.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1A28382;
	Thu, 14 Nov 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548780; cv=fail; b=a6L1Bah5iNJ7E9/aCBEe9O7fuPiHwN2zsAX+CVeIN3FuAlxyL5ct7uYiAj4ZNWQtGSOkniFLDBvNFWqowEX+ysV+/CS9jH6cvnWj9sn7YDk8N/4SRMed/oII5jGr8TEfXnvRsRYGxEJfs+p+9x3/b2AcYhHb/rdgTGwBB+xY7Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548780; c=relaxed/simple;
	bh=A8ihpfUpElPn8Tq+PINXL+eEpCheJclWrmvRxSzYUW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ly5X3K2gRAJ6js/rwTQd21RzNLCy1njJT1MKh8bQ0i1anw4HMmXwuEajRG0P/TiZ/ByH/jLgmp5iwqgsn25Es7kWhB5CVZdP561FHP0BBTMR6+s+Cr2x2jeOOKL3tJdMVcArKFnGMM4wQDf6M5E67ZyRhsQ/GkfEb1VfbhY2aT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Z3tGAH9H; arc=fail smtp.client-ip=40.107.44.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgmZnaxnSm1SxVcj8MO65yrUOLi3Yz5exNRJRoluwN++evIc7nNkIYUiW4Hx2doq9ha6QyJkh1yykfNJDaNRF1ZkkblXtKX8JQWgRMDth882+lDGuoqdTCXDHW3ODaZsZ0RkpXb57GbEhrTXa4ElgXzq3hBwaaqzOvg7Go9PBfyBRuP8jC55RehnLwOeKwU45yAHdqSUQTe0csweHEDmiI7c+0NDnz0sIV8oZDuRlnZ57AIGOl9GVCzk5D303Vnjss1UrgZ2diHwa8dJyJ2PQh4s7nZa124nmW+VXJIN8olS+SeCVYC9/Zlxs6TlYHbSNigGeZ/pPTpP62XrWeN14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8ihpfUpElPn8Tq+PINXL+eEpCheJclWrmvRxSzYUW4=;
 b=dxqaJjmQZSjxV57uTkTeh5+Kx1WMWrZCcA4DGUa0HPFMnSYqJXym2DAj1VhOw85Sj3ukF6eCZYAFtNRuyg4R7RqcdlJdIKigvQ6B6vaqmaH7SaB2FwgUfezXV5NDNu1/RENPaTh4g3odkIvn2I78xlFLkP++QwPLu4UGvYBUn6yu6oRZcaGiUs9eCoTWCWNIbJSVmpv6B7cPhUXC3Wuc2q7f3C6SFO0zqwAgvnWgx+MKgqg1fpbDEdYMIB9IX0qHzBW4HP/3S4gX+aWEhtiILFrjc69WJCxHtUA8/BWhN/MZ7tPuemwEDwIYL6ORbdMQfQ9YqHM0yilJd9pH4ttiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8ihpfUpElPn8Tq+PINXL+eEpCheJclWrmvRxSzYUW4=;
 b=Z3tGAH9Hh6Qk1kGqiJPXkpdR0tjtbV2coJ6eN4lgfl+2DxGEZYR+togHpm0I4kB+xqJ4FLEgSfUlxrKrqzgtHHRomHjzcDxESOmFAXJ558uxGzzbpUbrw2i5MyAXcq9Yd5+AJ1gcV8/FP6BinBTt5Yaoc6DCFvrWiee19v7yTIKB+P+eva+uc/Uyo5qRg7VCrVCL0PmG4UQlffzA0xP1wBDDuVO11MDPLoxXLHZCLrS31AV1OxyNmYLOPiK9hLyS2jcYLjFXp4rT+D3GdSNdhAT/lVg36ns6g+mWz1PZRICBDugeaMGXHBWimz2ezf3talS0fE4LTxyqhTDm7/m/og==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB6359.apcprd06.prod.outlook.com (2603:1096:101:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 01:46:11 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8137.011; Thu, 14 Nov 2024
 01:46:11 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDMvM10gbmV0OiBmdGdtYWMxMDA6IFN1cHBvcnQgZm9y?=
 =?big5?Q?_AST2700?=
Thread-Topic: [net-next 3/3] net: ftgmac100: Support for AST2700
Thread-Index: AQHbMQZSanPeA3sdNU6SnHF6uEd5/rKrwcKAgApI26A=
Date: Thu, 14 Nov 2024 01:46:10 +0000
Message-ID:
 <SEYPR06MB51348460E58B8601F630B4819D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
	<20241107111500.4066517-4-jacky_chou@aspeedtech.com>
 <20241107133811.3109d98a@fedora.home>
In-Reply-To: <20241107133811.3109d98a@fedora.home>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB6359:EE_
x-ms-office365-filtering-correlation-id: 5ec65113-c3af-4d1d-5baa-08dd044e1dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?aEhnTUVSVFE2eWI0K3VlYmhUNHRsS3RNTXdnRWZGaWV1Z09NZE9OZFptcHVFNlBF?=
 =?big5?B?b0oxMnZybm1uWmdaY2VRUmdKV0J2VjdWa1hEbFVwblErRVQ5YnkzVzl4bkhHaFNH?=
 =?big5?B?S1gxZVQ1SkVqdEtIUEF5K3JUSTlqak1LMEYzYWJkd3BmK3lpZ1ZXM2w4RVZyQm0v?=
 =?big5?B?ZEtzNTlpRWlNSDJBSmJpZkFNUFNhVHJCNnpjU2tMcEwvRCtOK1JhckVTUWRkb05M?=
 =?big5?B?LzZsdkFWdUdpMTdWZ0NMOVRCSy80WGE0eEpTSUdaTlRVZXVlUHN0Yjh3Z2dad2ZN?=
 =?big5?B?UFVRUnVsMVYzd1dQZUtnOG9pLzRXNnVLMlFDcGlZS1VicTVQRWRsMVRNaWtNYzRL?=
 =?big5?B?QXY5emJWbk9nWFhJYU5iMElFVFc2ZU5QanZ4Q1phR0RuSlZVMkxtWm1GWmpWMERZ?=
 =?big5?B?SHVmTjdvNGc1M2FyMjJQTWkycEFxUjJJVGRkVWlTTkx0V1BjdjRpU1FXSmhta0NF?=
 =?big5?B?cTdxMDE1cC9xcjRTbnZKYzJmMXBQVDcveWNlYitoWG9lampINUlwUTlxK0V5UDhE?=
 =?big5?B?WE0xUUZsRmJkNFQrMG13VXNCckl2UHFDL1RoUEJsdXJpNk0xUzZxTDJPOXRibTk1?=
 =?big5?B?RDBJSUpIc1l3eTlrU0RTU2NxUUh3UjlsVStxMjJUYjd6b0xzcnNvWmRZejJOZTY0?=
 =?big5?B?Q1gva2tZUjR5ZWRMZDI4enoweU9OSGpJMS9pRmFZaDlMd1BOUlBYbU4xRXNMamov?=
 =?big5?B?bXlCWm8xVFB6dFpDNE1iUklIQ1lucHU0VEFRSkZYMmdLTTVtYk91VlMzdE1FeWZY?=
 =?big5?B?aGpmeW96RHZ0OVNDdU1nQ3JjaUtXRzRpOElSVzRabFBTVzJKaFdYa0tKTTFrclFG?=
 =?big5?B?V2I1ZFBHR2puU3A1UU8zMU9zYjZ4aldLdzBvdVlvdzlySEJ0OTMvTXVqeWkzaG4y?=
 =?big5?B?NTM0STMzb2RjQnhBaVdHbGx0RnE2TCt4MzFSSU05a0k1NXJiUGtqeXpxeTdUczVx?=
 =?big5?B?QkUrZ0xKdWkyNnNPVXh3WnRkMjdhbjNXdWh5blo1UWdZS1BVdGE3dzdSc3ZQQzBz?=
 =?big5?B?YURkSytlOUVhV2lnUk94eGhIalhWYTZOWEhoaUVtOElOR3dPSi9YRU5DWW8xVGJq?=
 =?big5?B?R21IenVodGpZRXM1ZkY3RWhBSTViQVRLUFR0K01HdUU1SVFxTzM4bDdhZzltV3R3?=
 =?big5?B?MExZRzgzUTVEZDZLMnllenB0SmJNUGw5dE5xWGd4WWlxeHNJbU9tMEdHdjRvUXNV?=
 =?big5?B?OE9INVQxTjlFL1RqWUVTMy9KYyt3cUVxOXBvb0xZZlMzUFYydkMyT2MzZExUYkhH?=
 =?big5?B?SVlJQmJlOXlvMktwVFhnUlplM3FwQjNyaS8yOE9qRmk4Z3dETnhKTmNJaDd5VVFO?=
 =?big5?B?OG05eXdaQldGam0xNjNGNDExbmMwZGExQ1RzSHk0bnVCYlF1OW9IRUJvRk1wZzFw?=
 =?big5?B?UEdkVmhXcG1iMEVrM2hhWDRKMGZYVzRvdS90UFpYS1FNazlmdUI0SndoMm96RUJs?=
 =?big5?B?NUp1RTRRTzc0NTZyNGw5Mmc4KzNtbmZHeXlXbm9Ieit5emZsOUg3SU1YdzhCanMr?=
 =?big5?B?WEdUNC83NFo5OXpvZGMzSlFncEhVb0p4aXNWeXFkRFY4S0lOc0luL3M5WXdVRFBV?=
 =?big5?B?dGMvdi81NEIvMzlWekdaZHFsS1R2U0luYkdZUjlvL1pQVDNyd3dCSjdXalJxYVhY?=
 =?big5?B?U2tCM04xbkRuVDlHS2kwYlpKWFczQlk2V0FLbE9ZUE9ya3pmZFl4alRiUUJleXI4?=
 =?big5?Q?NEnJ+V31QEDsV+QVP1dmbjWFsqF4GrWfKzuk7EqQUf4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?T2pjZnh5SjdPWnYrOXJETzRjMVFiUUROa0JIVGIrNW01QkFjZTZUTDlNeThxYmU2?=
 =?big5?B?SmlGQVhTRWorV0hsRXN4MEZPNWIzanZLY3lnaDBQVGxpSlFFTW9NOUNrZmpEKytI?=
 =?big5?B?MVd2a2NMQS9DOWZSQzlwSlBCRGtwSjNBMnpDQzNjcmFwU2tML2lXajQwSkRndlFO?=
 =?big5?B?eHdERzlSYWJFeU1DbnlsU0M0WmYzNnNIc0pFaUZBakNRbXRUMEtBbW1TenFYcStH?=
 =?big5?B?MGtJZ3pUMndWVzVEbkk5UkNtQzlmbzZTekpLanloRjEvYjdBNDZKT1lhclE2NVdr?=
 =?big5?B?dGUvY1ZFMkh4WlNlVXh4cmVtWUdSdk1yUHFEdmp5VFM4K29EbEVjWkMwT2JRalo0?=
 =?big5?B?THRPSUVyVThyeitkYWFHenc2WXp1Um56eWtIRFhJOFlzanRCZmM4M3VWTEozR3dC?=
 =?big5?B?UEhyLzRTMTBmQ3ZlS0lTbjdnZ24xM0JUOVVsTXFscEI5d2doeDI2azk1VWxLNi9U?=
 =?big5?B?eTQyQVJibFNXUkRBZVRsM1d4Q29pbFVmQ28yb0oxRHU2MGRrVzBzOXJUOUtEa200?=
 =?big5?B?VUVQOEgwUTNQVXdISGpFSlI3bGNxMG8rU29OckQzdmxvVTRaY1U4anRBKzRQM0lD?=
 =?big5?B?eW4yOUdtQVZlNWRuNFowMitUTXlGaVkvS2xoSGhXWUZWK01HdlM0eVpxbUhQa2pI?=
 =?big5?B?ckIxQlBZUUtGZXptT2lBTWsrcm5ON294dnVBZ092UFJybSsxaHI1S3JDNkxBcnZS?=
 =?big5?B?eFdoZXczRE9OcnpnbHptTmU5MFF0ZG02UmFwcm05Ui9DblpxaHdHUTgrUTFxU1oy?=
 =?big5?B?ZFRnNDBycy96ZHVxUmVKTkUvK0VwVHhWM1BkY0dXRGZ1ditmRjNMMzRRRmNqV0lw?=
 =?big5?B?djJEbjdYY1dvZFUvKzBUWE9aUHRHUkM4WUE2VmFueWFwRC9tbWhMWHIvMnVHTFdT?=
 =?big5?B?UlBhVjdXajNuMElQbldSdE0xVEVzYll3WTJOV1c3dzNxcmR4RFdPVlhFMlVORHVv?=
 =?big5?B?M2kvU0E3M2xtOCtEV1NTTVhpV0JJVllQcjZzTUNYSmVMVVFZUDN1Sno0OFpyVXJq?=
 =?big5?B?YXdFcWdJYmtRVU5GdXI1ekEyd3ZLcHNrQllLVVMvKy82U1hDOEJ6QkpybnAxR0lU?=
 =?big5?B?dDhNMTloSHJhUTgydUtRZERJZkQ1Qy93YWMwOG13OGt1TGpjVUhZSXI4SHlQQ2J2?=
 =?big5?B?N0diektGVjFHZG1Ndy82WCtkVTNRM1BXNzgyNngvNEFSSG5Yek8yU3FaOC9xcTQy?=
 =?big5?B?N01uWGNCZXg2dXJka1RsMXFVYk5LaG11bjhXMkp1YVd6WmlZd1ZRQ1l3ZVVqQTNT?=
 =?big5?B?Zk1yaFZMakovV2hzOU9iUHJCSHlIbmdHL290SzB1TTdZMWFxU0g1eFdqcTVmc0Zz?=
 =?big5?B?ZXJXem4vdi9BdkZGZUtxN1FHbElNVFNEQWQraUpWTFBoWS95UEc2c2xrTlpXNGNT?=
 =?big5?B?WEJDdCtjcTB0TWhBTUtJSDArZEFsNXdKNU1ZWnNyTHRPL0ZvaXNpUTdidzdVbzd4?=
 =?big5?B?M0FUalhLZFNPSFp2TzEwL1g2elJ1azN3N0Y2eG5uYmFzd2x3ZnZKc1dIajQ5ZHJH?=
 =?big5?B?dVZuLzlWckZlQVlDUTNjcU10VC9qbm85LzJmRjVmRTY4T3JWWTFISFhXZTF5QVNS?=
 =?big5?B?UE1tUFhlM1poaHpsQmVWZEdnNk8wYVpaRThPYzhRM3p4U1lneC9jL0hvU05TN2gv?=
 =?big5?B?Q3IyVFFpYmZLMmJBNWVQbllCcndVQ2p5VUlScitJRnNxK1ZnYlpOQVhYLzg0eWto?=
 =?big5?B?cWJnblVEY2xGWmpUTFExcld3WHJ2djVPaDdjcWdhbWFFTVdENFFmeW5XbG1selBE?=
 =?big5?B?dkhSWmg0NDhRbnc2NjJUOG1MTHpZUmlyRlhzOU41RkJXYTVGWTZOZVZNdEpBVGxq?=
 =?big5?B?d0RVOXlZT3VrdjV2NUx2Q1JiQ0R0NmZOT0ZqZ2M5a254M2xTSkFPUnNYRW1VTVlz?=
 =?big5?B?cjVBSmpjbW5zVG5IM2U4andmbXZUME4vSmxGTU9GWmdSYXIwWHRqUGdLbGVYKzlD?=
 =?big5?B?aHJVNGhFSUxsQkVaOVhKNHg1Q2wxT3lMRGJIZGJVYzdzMGlqV0JsNDJtSHlKc0tZ?=
 =?big5?Q?7rlpSrAc9po0m13F?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec65113-c3af-4d1d-5baa-08dd044e1dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:46:10.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQ0cxG5FdGywW8ygtklFAxkKQcyW55TsKqCPSnH+rql9zjcC9iopnjnxReRC/ZweM0qUlpW5zbooBt/J1aUqUsUt2kzY3FM1X8qTVqUY5LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6359

SGkgTWF4aW1lDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IFRoZSBBU1QyNzAw
IGlzIHRoZSA3dGggZ2VuZXJhdGlvbiBTb0MgZnJvbSBBc3BlZWQsIGZlYXR1cmluZyB0aHJlZQ0K
PiA+IEdQSU8gY29udHJvbGxlcnMgdGhhdCBhcmUgc3VwcG9ydCA2NC1iaXQgRE1BIGNhcGFiaWxp
dHkuDQo+ID4gQWRkaW5nIGZlYXR1cmVzIGlzIHNob3duIGluIHRoZSBmb2xsb3dpbmcgbGlzdC4N
Cj4gPiAxLlN1cHBvcnQgNjQtYml0IERNQQ0KPiA+ICAgQWRkIHRoZSBoaWdoIGFkZHJlc3MgKDYz
OjMyKSByZWdpc3RlcnMgZm9yIGRlc2NyaXB0aW9uIGFkZHJlc3MgYW5kIHRoZQ0KPiA+ICAgZGVz
Y3JpcHRpb24gZmllbGQgZm9yIHBhY2tldCBidWZmZXIgd2l0aCBoaWdoIGFkZHJlc3MgcGFydC4N
Cj4gPiAgIFRoZXNlIHJlZ2lzdGVycyBhbmQgZmllbGRzIGluIGxlZ2FjeSBBc3BlZWQgU29DIGFy
ZSByZXNlcnZlZC4NCj4gPiAgIFRoaXMgNjQtYml0IERNQSBjaGFuZ2luZyBoYXMgdmVyaWZpZWQg
b24gbGVnYWN5IEFzcGVlZCBTb2MsIGxpa2UNCj4gPiAgIEFTVDI2MDAuDQo+IA0KPiBNYXliZSBl
YWNoIG9mIHRoZXNlIGZlYXR1cmVzIHNob3VsZCBiZSBpbiBhIGRlZGljYXRlZCBwYXRjaCA/DQoN
CkFncmVlLiBJIHdpbGwgc2VwYXJhdGUgdGhlbSBpbnRvIHNlcGFyYXRlIHBhdGNoZXMgb24gbmV4
dCB2ZXJzaW9uLg0KDQo+IA0KPiA+IDIuU2V0IFJNSUkgcGluIHN0cmFwIGluIEFTVDI3MDAgY29t
cGl0YWJsZQ0KPiAJCQkJICBjb21wYXRpYmxlDQo+IA0KPiA+ICAgVXNlIGJpdCAyMCBvZiBNQUMg
MHg1MCB0byByZXByZXNlbnQgdGhlIHBpbiBzdHJhcCBvZiBBU1QyNzAwIFJNSUkgYW5kDQo+ID4g
ICBSR01JSS4gU2V0IHRvIDEgaXMgUk1JSSBwaW4sIG90aGVyd2lzZSBpcyBSR01JSS4NCj4gPiAg
IFRoaXMgYmlzIGlzIGFsc28gcmVzZXJ2ZWQgaW4gbGVnYWN5IEFzcGVlZCBTb0MuDQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+
IFsuLi5dDQo+IA0KPiA+IEBAIC0zNDksNiArMzU0LDEwIEBAIHN0YXRpYyB2b2lkIGZ0Z21hYzEw
MF9zdGFydF9odyhzdHJ1Y3QgZnRnbWFjMTAwDQo+ICpwcml2KQ0KPiA+ICAJaWYgKHByaXYtPm5l
dGRldi0+ZmVhdHVyZXMgJiBORVRJRl9GX0hXX1ZMQU5fQ1RBR19SWCkNCj4gPiAgCQltYWNjciB8
PSBGVEdNQUMxMDBfTUFDQ1JfUk1fVkxBTjsNCj4gPg0KPiA+ICsJaWYgKG9mX2RldmljZV9pc19j
b21wYXRpYmxlKHByaXYtPmRldi0+b2Zfbm9kZSwgImFzcGVlZCxhc3QyNzAwLW1hYyIpDQo+ICYm
DQo+ID4gKwkgICAgcHJpdi0+bmV0ZGV2LT5waHlkZXYtPmludGVyZmFjZSA9PSBQSFlfSU5URVJG
QUNFX01PREVfUk1JSSkNCj4gPiArCQltYWNjciB8PSBGVEdNQUMxMDBfTUFDQ1JfUk1JSV9FTkFC
TEU7DQo+IA0KPiBUaGUgZHJpdmVyIGNvZGUgdGFrZXMgdGhlIGFzc3VtcHRpb24gdGhhdCBuZXRk
ZXYtPnBoeWRldiBtaWdodCBiZSBOVUxMLCBJDQo+IHRoaW5rIHlvdSBzaG91bGQgdGhlcmVmb3Jl
IGFkZCBhbiBleHRyYSBjaGVjayBoZXJlIGFzIHdlbGwgYmVmb3JlIGdldHRpbmcgdGhlDQo+IGlu
dGVyZmFjZSBtb2RlLg0KDQpBZ3JlZS4gSSB3aWxsIGFkZCBhIGNoZWNrIGZvciBuZXRkZXYtPnBo
eWRldiBoZXJlLiBQZXJoYXBzIGl0IGlzIG51bGwuDQoNClRoYW5rcywNCkphY2t5DQo=

