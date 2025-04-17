Return-Path: <netdev+bounces-183726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBAA91B21
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A246116D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76023F41A;
	Thu, 17 Apr 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="GhzCyIyO"
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022075.outbound.protection.outlook.com [40.107.149.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EE23E346;
	Thu, 17 Apr 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890206; cv=fail; b=m4Ob7gofoK2GXVRRRT+MnjqArvVNgWaaiKRGRy5Ynv5BWMUGECnPdIf6UM6ov52m8c/y81X1hATL+3YBZgiFC2IpaXaig3YDVf814IMv2mY26hQpJJQw8OXpXOuvTHNe/KXIYvmmOFLcvIE65njIet034/XwVqywEA/soX/ukAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890206; c=relaxed/simple;
	bh=wIhrHT7OmSTWikgVmc+YxN7CGQQ8yIEVBT8QB41l5SU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKN5bTirdFW9z4hW/apZa6UPGrS8y1c1+g1owkb4EKk/QJY55gh4aGEVkwcdkwSQnHMz1cwDEousAN3v9DwgVJqJqzCwgK231UJL7n38agJx/GPSUSfkZ5Xp8e2gZy1t02j320JXYEPofm8dE3qp6qqGywpCcPpowEOGzbNXpM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=GhzCyIyO; arc=fail smtp.client-ip=40.107.149.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr8CZVT6adrQ8Rk4meAAu+0yEgwsw8ES9mmzQmaiJcIJ2KYTlDjk8mICEqbroB42stYXy/1H2FeTf8WWHoyUhS+b6bZ96VWsnDkme0HwX8VehF2vOncRkntMGk9Bn2DwoeFlPO+QOBo+Ce9Jr2DnH1/9APQfvoI2fZO+5wBkRmcgn0xhJWWLGnuQIF9inbHlJeKGJwHCUAjZpSWFUQhC9oZPEuD5lff9YbMljREZO2R8ZL0rGRGZatsS0BFpBPZIaDmGbtvinsUo7885DFdoooN0EBCaWVguvaDd5+KyNnIxQwRIENd15sFJAuMd+HHCGnKIB39veRaEzIc6j2nC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIhrHT7OmSTWikgVmc+YxN7CGQQ8yIEVBT8QB41l5SU=;
 b=QRV126RMrNPW/QsSwti8UW6YMK4x6VEhy/OOerjoddHFR2lb7mzAFsg+t9UtrC22Dxs8L0ZD6YYUAfVznHsV1bNNaS1SsVLVCNYMsGOF/NTgliUtFHiRBkHk4VxHxWC+w0lA8uPKSvvmhK0CZKjYbaPryv/GliRGPy4Z4ZRu8pNInDosYqlesijOn8+EaUNn/PJ03vbJfvvXlLf0qMVF8qxnCnTYwGlJsKEJU2n9RwU/X8q9RpmaXnUUfIrv73rNJswjOhyCYI2kxt4n4Qrus1RpWdeqozXki62Hr1FoCBU/I/hxGxcvSsS7Sg382XST36orxqZS4deXop8vZKaIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIhrHT7OmSTWikgVmc+YxN7CGQQ8yIEVBT8QB41l5SU=;
 b=GhzCyIyOu1W1b5DpVW/GYdtkyJsLlxJwjOB6r1GQorYOk+pCzCOnJC0ZzcCiTOyxfz9aCFe02rCVCVF/6ZscgRJeUS0UxlaAEOjWzwvyOIeabJYTsmVKC3ErEu56OQv7dtTCeLMilsnXs/eJRT4wNYBoOOJ/0L/iokZlKMhLavY=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR3PPFA6B113938.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::177) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 11:43:03 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:43:03 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH 2/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Topic: [EXTERNAL]Re: [PATCH 2/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHbrrzr/zSZ0hIkl0iiZf25x3PlB7OmH4GAgAGexQA=
Date: Thu, 17 Apr 2025 11:43:03 +0000
Message-ID: <15fee959-5128-4e9e-8c7f-a0f08bd0cd76@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
 <4ddf2ede-3f40-438d-bae4-6f8b1c25e5eb@adtran.com>
 <ee0599ad-7f67-46fb-aa60-32a1dac21bd0@kernel.org>
In-Reply-To: <ee0599ad-7f67-46fb-aa60-32a1dac21bd0@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR3PPFA6B113938:EE_
x-ms-office365-filtering-correlation-id: 631868e6-52a4-41c6-69a6-08dd7da50328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVRhZHhJcjM5MGZsQzlmdExUb2tHOE9ZQ1NTeDVCZWZWTkM1MnhHTmszbER2?=
 =?utf-8?B?dms5UUc4L1FXZFNvajduck9Fb2FpaGEzanVmU1BIWGtvQXE1ZCttMUpsTGJz?=
 =?utf-8?B?bVViYTU1T0plQnhGeEt2UFNOekZMbFJhUGl3a0R0a0UwY2g4Z0l0MGFKOEVP?=
 =?utf-8?B?eWdhUVp0OWx4KzkyZVFmMVVnY21yMXhnUGFNQ1MvWmthczZFREFUREJ4WWhT?=
 =?utf-8?B?dHBlbmh1MGJLMmxLWGYyZmhlaEw5QlJyZUg0WVFFWnBCZ09kM0k0OFJPQTJa?=
 =?utf-8?B?Tm1lMWtKQzdLcEZMeFVjTlFScGRKYXFzTGtpZ3ZGV2dabHp0OXpPeUgxYXRO?=
 =?utf-8?B?Z0pWTkVqbVVGVThNbFU2V1hNcVcwRUQyaG5ETFoydHlabUxBQkEvZWxDOUhu?=
 =?utf-8?B?dWZ3NEZDcEFuRkhVdE8yQURBWks4bzNnMVEzK0lkclYyTVN4VXdyV3hSZUlU?=
 =?utf-8?B?VlVIQ3ZIVlNjZ2t2VHlaUXI0WVNYSjNTcU5WM0NhY0ZTdTZ5ZDFhQkw5dXZ2?=
 =?utf-8?B?azRESmh2ejZkb2JBb3Z3L3U5QVlwd0ZRSTlFbVU4dnBKNi92VnlEWUxrUDhH?=
 =?utf-8?B?NjY0Lzc4c2dOaG1XN0xWbWdTbVJieVNaNmNaYnh4Qmg5Q0l2TTh1eEorTHc3?=
 =?utf-8?B?eCtOZzQrb0hWTHo0c0FYMzlETE5uSlUrUWhxVnc1Ty9rT2Fta2w5Y2dROThW?=
 =?utf-8?B?VmphNExzdDNmQ2lDZG1TOThuNmNCbzdBdldvZ2lFNnlGQzhZQXcxWTRCcGNv?=
 =?utf-8?B?UUQ3OGxxTE8ySlhOSkpUYUJKUmNlUzlQcFpEQ1A5K1pJU2ZTWWVKTjRlb2xF?=
 =?utf-8?B?VlB3Z2V5UkJVRWI0M2ZMOGo5N3dMQ3A0aVdKa2dJWElSWVVCRWVjNHg3MlJV?=
 =?utf-8?B?Njhta0VHMklteHF1Wk1lM2poMHl3L0FHM2dvQ0NFcFcyRkF3NFhvTURlNkEv?=
 =?utf-8?B?QWNyd3YweWE1R3hib09vdFdiQzNoMXQ1RXRVUXgrbTlvOGdnWU9hMEJTRzVi?=
 =?utf-8?B?eGxsRG8vNVZTNkZJb0dtbHJCOXhTckdQZUdyalpjVGFsYlZWME9XVE4yc2FJ?=
 =?utf-8?B?a1VUNlZQZE85Y1dXSnNDRlkvcUo0Qlc1U3pRLzdqZU52TTFxMXc4MHExK0wr?=
 =?utf-8?B?VDVkMndyZ0c3TUJqMno1bldZak5oWE85U2RLa1FEYXBRK2RhYm0wZTNKQThm?=
 =?utf-8?B?a1IyNU1pMDVZRkRqMmN4US9YWW9Fa3pGdU9YYnRCVnhyVmVwOXM2TWNZeUdP?=
 =?utf-8?B?RkJwRnNWdGF2K2IxLzkwWjFsenR1MzAyMS9Wb3k3aEJhZTA2UjRKNC9NR2ZK?=
 =?utf-8?B?WklBMmF3WGsyTXU5d1JOcWRjT0FqTVF4cTh4OEZiV0NiU2Jjb2J4NHZkdmt1?=
 =?utf-8?B?WG1nc1A4NW5qK1ByZUd0QmRvUittdGFZa3BVVWZibFpoQUdVcXB0cGxwYVo3?=
 =?utf-8?B?Yk8xa0ozaTZmU0NlSmtXdDFkSVdZSHprWWZjMlJvQzZUQjB6MHRaWStuaTh5?=
 =?utf-8?B?YjlhZ1REV3VNNVZYZU9zVVJKb29MdnhkZTZaRmVqZDJ6YjdxREF3clZsZTRu?=
 =?utf-8?B?bTZzWTNRRHJZMGp3QzZ4aEdDSjZrd3JOTkJMVklndld1MC9PSVdyQXZxTkJp?=
 =?utf-8?B?cDFNWk5DVXVMTXdWTDB2S0swT0x4bzcyK09TQ3B5c0ZDNzl4Vk1FQ3BXTjdl?=
 =?utf-8?B?VEZ2Vmg3YlFaZk1qemxqMkJiYUJoQ3hOMUVFTTUyUU52cTdpZkZCRzZYUFV3?=
 =?utf-8?B?MXVpLzNCTjUwdDRnekVUR212bGhENWhUNHZtMGxFMDRYeEluM1h1UUhydjky?=
 =?utf-8?B?YXpOb0d4b2N1L0V1dEM4V2R2L29DazdVUldtTVh3OTE4ZWo5eWwyRnpMOFZy?=
 =?utf-8?B?djZLbWJrWEZ0bEx3VFVVOWtqVEZZVWtUYnBCZVVSMmZhR09sZHhRVnVKQnQ5?=
 =?utf-8?Q?kLdPU7fHjOxwJRE3AiQgN07I17Mm0Hy9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFFPN1FqOWM2RDQvdncrSmxrL1FiZ0NQcUdoblA5Szhia0JoM3NpcC9xalpL?=
 =?utf-8?B?V0JzSjFmOU54NUhvRDBDcEUvWmNSWk5GNUM2WkY5L3ZZUFRYdWEyaU1RTmI5?=
 =?utf-8?B?dUl4clVPeGs0T0hBcmVHS3Y2NTZ0N2hIVTVLeHhQS2lHQ0ZuWUltaGF3Tk1V?=
 =?utf-8?B?TUgyMlZjcVNrcWk3dUY2aXJHUGVzbHVDZDRTeFhyZkxwS05Jdy91SFU4ZFRZ?=
 =?utf-8?B?SWRCOGoyWWZrSXBxTWlLbHl0V3ZGZ0gvL1JnbDhYVjNOaTc4M2dsc2E5N01P?=
 =?utf-8?B?bzJyRi9QUWVjRkU0QzNGNzhiOGR0SzRuMWVyUzYxZnlramI1c1FlUUNtQ1RP?=
 =?utf-8?B?ZlBSQ1BvcFNBbE0zTnphKytSZW9UQVpvZlpURmprL1hXSUFZZjVYNjRpUDJX?=
 =?utf-8?B?YWJqSGdtSTNuSGs3Nkl0T1NDa1dLMEZkdy9oT2NLbXk0eVNHdHZjMTYvQzBy?=
 =?utf-8?B?ZllacjNwbkJnVVBjOHFCUEhyWkJUWTdjS0wrdmFpQlNKaG02TjZTWFhJQ1p1?=
 =?utf-8?B?S0JDR2MzcTl6MndIdE5wT0NZVjlYcGtkaldiUXBhRVlTTWJhRWRjZ3JmV01Z?=
 =?utf-8?B?bDNzTkMxSGo3YUdDbkJpZU81Yi9JK2hXd1I2d0RobiswSzJCZGhsZDNUZ25s?=
 =?utf-8?B?Z2NqSEdPUnBUaDFLbDdPN3h6TklhbXZNazFIakdVZjM0UWwxbFJ6UGJDcExE?=
 =?utf-8?B?Z2RKVUR1UEZNKzdMZVpMMlVZY3BjR3YzcmFRSk81OS9zKzFzMzBQeUIxcHlq?=
 =?utf-8?B?dzlJOHErTiswNVUva244WFdpMlNVaG5mdDR1aE5iQkhjakJheldJOFpRb1ZQ?=
 =?utf-8?B?VjVUMVBBMVhQRDVibUNSMHpHbUNsS2c1QUxoL3FQOTFJdWI0UjFxaDVQYzRo?=
 =?utf-8?B?aTFSNFo5dnRJbTcrQWxuczVxV0I3c2xSY0g2cXlua1RrVTNzU1RyaERPazV2?=
 =?utf-8?B?WVBKcVFoK1FERDIwYU0rK0ZCSFkrWkIwWXoybHlIRmRPUm9KZksza1RWUHZt?=
 =?utf-8?B?MnFmaEZSdkRQK0dZRG9QaUZrVEpHTWtLdnNCOVE2Y00rZEFlb0lpRUNlbW1U?=
 =?utf-8?B?Z1RuWlBoZzNOUHBEQlY2Uy9wSU82ZUhldW0rTWJxbXNQL0FseFNETVVTRjVp?=
 =?utf-8?B?NXUvenRYVTNjWm43QWtqbjA0bkJMaU1ZbEZ3VG16a216RXV3MUZKdTFPcG1x?=
 =?utf-8?B?OGUyNjM4K2dvQVFFMWRWUWoyajRCOTZtNzVIVEFzSWZjQnV2SUxqajJIT1VS?=
 =?utf-8?B?WVFPNVZxeVYya1ovcTVHQ0FsSVNQTGhrVkl3MkFPTVZKcXdQUXp0ckNkQW1R?=
 =?utf-8?B?ZDZrV0daM2tNZGpDYmUyd2d6cHR1YTluTTczenJITVBwTmI2ZVZPbHVESGpN?=
 =?utf-8?B?cGhPMlllcUdkb05qRm4yOUU5ZDdCMEVCQ2xaRDZpWitlOGhJOWZuSCs3S2U5?=
 =?utf-8?B?RjN6RXloOW1RZk0rWlBlalAwZFNzTzA4UWdnUHhYSEJxa09kay9FcEhJbUJZ?=
 =?utf-8?B?SEk5ZzN5SkhSTlhiTEpXQXA1dm5ZTVd4bFlDSjJVMC80OXUyeDUvdDRhYUZ3?=
 =?utf-8?B?MGVCR0tQMVlDSnZTSWhSaGZRclZsNDRmVGhSdGdqL0hnM3RNK0srNWVwRThJ?=
 =?utf-8?B?ZUVkYjNRU1o3eEI3Sk1YNDl5Vmx6eDk1Mk1JVytjak9vZEZtMUZkdXYzQzZu?=
 =?utf-8?B?aHQ0UWMvTGdEdnpLUmFwZGR6aHdQSFdjVS9PTklwazFXWWQ5bllVeGJ5MDM4?=
 =?utf-8?B?TndBY2lLUmdJV3BIbnRQL05kaE5tQTlMQkNreGc4QWtYZndLSzlIOUZ2aUhR?=
 =?utf-8?B?YXRzMmpSOFRWRjcrNU51TGVqZEZWY0tQTGxtcHMvK012N1ZnVzgrSkxFN0k3?=
 =?utf-8?B?dHhHWjUwdXBBWGJqQXpGd2FPUU1MZE9RVStydThITXRMd1YyTTUvMmtIcFB3?=
 =?utf-8?B?MUhjWjBXeEdIL3JTcGI2R1hSZ0pFZGNGcnNmMklnK1Vod0NUbG04MUFBdzhx?=
 =?utf-8?B?WmplT3dXdDY5Mm5QVFBJS0FRY000SFNQZjNQa2d2R1djKy9LRDJQK0dDMDZT?=
 =?utf-8?B?MVR0SHNtSlJPRzhtRHMyVCtEMnE3TWROSThRd0RhL204T0xCVHVUendWSzdk?=
 =?utf-8?Q?nAPDUMfpTFzFHb08DilVgNOMc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B630333C8385EB4E9DD082F7562AB61C@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 631868e6-52a4-41c6-69a6-08dd7da50328
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 11:43:03.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtvMei7D8RA03X67kE6tj87fjbVdNh6yMg1kw7SU+GiJeETJe/bcNNKxyFecHiEIdg36wL13vkjsF53UJuT11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFA6B113938

T24gNC8xNi8yNSAxMjo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW05pZSBvdHJ6
eW11amVzeiBjesSZc3RvIHdpYWRvbW/Fm2NpIGUtbWFpbCB6IGtyemtAa2VybmVsLm9yZy4gRG93
aWVkeiBzacSZLCBkbGFjemVnbyBqZXN0IHRvIHdhxbxuZSwgbmEgc3Ryb25pZSBodHRwczovL2Fr
YS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBPbiAxNi8wNC8yMDI1
IDEyOjQ3LCBQaW90ciBLdWJpayB3cm90ZToNCj4+IEZyb206IFBpb3RyIEt1YmlrIDxwaW90ci5r
dWJpa0BhZHRyYW4uY29tPg0KPj4NCj4+IEFkZCB0aGUgU2kzNDc0IEkyQyBQb3dlciBTb3VyY2lu
ZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0KPj4gYmluZGluZ3MgZG9jdW1lbnRh
dGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0
cmFuLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNp
MzQ3NC55YW1sICB8IDE1NCArKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MTU0IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQo+
DQo+IEFsc28gbG9va3MgbGlrZSBjb3JydXB0ZWQgcGF0Y2guDQo+DQo+Pg0KPj4gZGlmZiAtLWdp
dA0KPj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3
b3JrcyxzaTM0NzQueWFtbA0KPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmQ0OGVlYjJmNzliDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3
b3JrcyxzaTM0NzQueWFtbA0KPj4gQEAgLTAsMCArMSwxNTQgQEANCj4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAx
LjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25ldC9w
c2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IFNreXdvcmtz
IFNpMzQ3NCBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlcg0KPj4gKw0KPj4gK21h
aW50YWluZXJzOg0KPj4gKyAgLSBLb3J5IE1haW5jZW50IDxrb3J5Lm1haW5jZW50QGJvb3RsaW4u
Y29tPg0KPg0KPiBUaGlzIHNob3VsZCBiZSBzb21lb25lIGludGVyZXN0ZWQgaW4gdGhpcyBoYXJk
d2FyZSwgbm90IHN1YnN5c3RlbQ0KPiBtYWludGFpbmVyLg0KPg0KPj4gKw0KPj4gK2FsbE9mOg0K
Pj4gKyAgLSAkcmVmOiBwc2UtY29udHJvbGxlci55YW1sIw0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6
DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gc2t5d29ya3Ms
c2kzNDcNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsg
ICcjcHNlLWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDENCj4+ICsNCj4+ICsgIGNoYW5uZWxzOg0K
Pj4gKyAgICBkZXNjcmlwdGlvbjogRWFjaCBTaTM0NzQgaXMgZGl2aWRlZCBpbnRvIHR3byBxdWFk
IFBvRSBjb250cm9sbGVycw0KPj4gKyAgICAgIGFjY2Vzc2libGUgb24gZGlmZmVyZW50IGkyYyBh
ZGRyZXNzZXMuIEVhY2ggc2V0IG9mIHF1YWQgcG9ydHMgY2FuIGJlDQo+PiArICAgICAgYXNzaWdu
ZWQgdG8gdHdvIHBoeXNpY2FsIGNoYW5uZWxzIChjdXJyZW50bHkgNHAgc3VwcG9ydCBvbmx5KS4N
Cj4NCj4gV2hhdCB0aGlzICJjdXJyZW50bHkiIG1lYW5zPyBMaW1pdGF0aW9uIG9mIGhhcmR3YXJl
IG9yIExpbnV4PyBJZiB0aGUNCj4gbGF0dGVyLCB0aGVuIGRyb3AuDQo+DQo+PiArICAgICAgVGhp
cyBwYXJhbWV0ZXIgZGVzY3JpYmVzIHRoZSBjb25maWd1cmF0aW9uIG9mIHRoZSBwb3J0cyBjb252
ZXJzaW9uDQo+PiArICAgICAgbWF0cml4IHRoYXQgZXN0YWJsaXNoZXMgcmVsYXRpb25zaGlwIGJl
dHdlZW4gdGhlIGxvZ2ljYWwgcG9ydHMgYW5kDQo+PiArICAgICAgdGhlIHBoeXNpY2FsIGNoYW5u
ZWxzLg0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+ICsgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+PiArDQo+PiArICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgIiNhZGRyZXNzLWNl
bGxzIjoNCj4+ICsgICAgICAgIGNvbnN0OiAxDQo+PiArDQo+PiArICAgICAgIiNzaXplLWNlbGxz
IjoNCj4+ICsgICAgICAgIGNvbnN0OiAwDQo+PiArDQo+PiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVz
Og0KPj4gKyAgICAgICdeY2hhbm5lbEBbMC0zXSQnOg0KPj4gKyAgICAgICAgdHlwZTogb2JqZWN0
DQo+PiArICAgICAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICsgICAg
ICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICAgIHJlZzoNCj4+ICsgICAgICAgICAgICBtYXhJ
dGVtczogMQ0KPj4gKw0KPj4gKyAgICAgICAgcmVxdWlyZWQ6DQo+PiArICAgICAgICAgIC0gcmVn
DQo+PiArDQo+PiArICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgIC0gIiNhZGRyZXNzLWNlbGxzIg0K
Pj4gKyAgICAgIC0gIiNzaXplLWNlbGxzIg0KPj4gKw0KPj4gK3VuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCj4NCj4gVGhpcyBnb2VzIGFmdGVyIHJlcXVpcmVkOiBibG9jay4NCj4NCj4+ICsN
Cj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsNCj4+
ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICBpMmMgew0KPj4gKyAgICAgICNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKyAg
ICAgIGV0aGVybmV0LXBzZUAyNiB7DQo+PiArICAgICAgICBjb21wYXRpYmxlID0gInNreXdvcmtz
LHNpMzQ3NCI7DQo+PiArICAgICAgICByZWcgPSA8MHgyNj47DQo+PiArDQo+PiArICAgICAgICBj
aGFubmVscyB7DQo+PiArICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICAgICAgcGh5czBfMDogY2hhbm5lbEAw
IHsNCj4+ICsgICAgICAgICAgICByZWcgPSA8MD47DQo+PiArICAgICAgICAgIH07DQo+PiArICAg
ICAgICAgIHBoeXMwXzE6IGNoYW5uZWxAMSB7DQo+PiArICAgICAgICAgICAgcmVnID0gPDE+Ow0K
Pj4gKyAgICAgICAgICB9Ow0KPj4gKyAgICAgICAgICBwaHlzMF8yOiBjaGFubmVsQDIgew0KPj4g
KyAgICAgICAgICAgIHJlZyA9IDwyPjsNCj4+ICsgICAgICAgICAgfTsNCj4+ICsgICAgICAgICAg
cGh5czBfMzogY2hhbm5lbEAzIHsNCj4+ICsgICAgICAgICAgICByZWcgPSA8Mz47DQo+PiArICAg
ICAgICAgIH07DQo+PiArICAgICAgICB9Ow0KPj4gKyAgICAgICAgcHNlLXBpcyB7DQo+PiArICAg
ICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgICAjc2l6ZS1jZWxscyA9
IDwwPjsNCj4+ICsgICAgICAgICAgcHNlX3BpMjogcHNlLXBpQDIgew0KPj4gKyAgICAgICAgICAg
IHJlZyA9IDwyPjsNCj4+ICsgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAg
ICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsN
Cj4+ICsgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMD4sIDwmcGh5czBfMT47DQo+PiAr
ICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KPj4gKyAgICAg
ICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCj4+ICsgICAgICAgICAgfTsNCj4+ICsg
ICAgICAgICAgcHNlX3BpMzogcHNlLXBpQDMgew0KPj4gKyAgICAgICAgICAgIHJlZyA9IDwzPjsN
Cj4+ICsgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAgICAgICAgIHBhaXJz
ZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCj4+ICsgICAgICAg
ICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMj4sIDwmcGh5czBfMz47DQo+PiArICAgICAgICAgICAg
cG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KPj4gKyAgICAgICAgICAgIHZwd3It
c3VwcGx5ID0gPCZyZWdfcHNlPjsNCj4+ICsgICAgICAgICAgfTsNCj4+ICsgICAgICAgIH07DQo+
PiArICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICBldGhlcm5ldC1wc2VAMjcgew0KPj4gKyAgICAg
ICAgY29tcGF0aWJsZSA9ICJza3l3b3JrcyxzaTM0NzQiOw0KPg0KPg0KPiBUaGlzIGlzIHRoZSBz
YW1lIGFzIG90aGVyIGV4YW1wbGUsIHNvIGRyb3AgYW5kIGtlZXAgb25seSBvbmUuDQoNClJpZ2h0
LCBidXQgU2kzNDc0IGlzIHNwZWNpZmljLCBsaWtlIGl0IGhhcyB0d28gaTJjIGFkZHJlc3Nlcywg
b25lIGZvciBlYWNoIHF1YWQgcG9ydC4NClRoYXQncyB3aHkgSSBrZXB0IGJvdGggaGVyZSB0byBz
aG93IGhvdyB0aGUgZnVsbCBjb25maWcgZm9yIHRoZSBJQyBsb29rcyBsaWtlLg0KSSBhZ3JlZSBp
dCdzIGFsbW9zdCB0aGUgc2FtZSBhbmQgb25lIHdpbGwgZWFzaWx5IGZpZ3VyZSBvdXQgaG93IHRv
IGNvbmZpZ3VyZSB0aGUgc2Vjb25kIG9uZS4NCkFueXdheSwgaWYgSSB1cGRhdGUgdGhlIGRyaXZl
ciBhY2NvcmRpbmcgdG8gT2xla3NpaidzIGNvbW1lbnQgcmVnYXJkaW5nIG9uZSBkcml2ZXIgaW5z
dGFuY2UNCmZvciBib3RoIHF1YWRzLCB0aGlzIGlzc3VlIHdpbGwgYmUgZ29uZS4NCg0KUmVnYXJk
cywNClBpb3RyDQo=

