Return-Path: <netdev+bounces-220570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312ACB469F2
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9783B28A7
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169C29BD87;
	Sat,  6 Sep 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KR5VkT24"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013072.outbound.protection.outlook.com [52.103.46.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619726E14C;
	Sat,  6 Sep 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757143824; cv=fail; b=ATmfEss2WzG+2eb+fHMCwRbusShIJ7k3MwlirbgrPYlDRIT5B0pnJs658/4rjC19TxF4kPNoP1DWV7YXFSqIe5yQEFIcCNSGsJBDfwcG3PleNxPrIBzqOLzmzk6jJPLjJiO5U04utJ6/OeCNKB9fFssG2NxvoYJ0z27gk6r0+Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757143824; c=relaxed/simple;
	bh=qGrVdA5BErfRZZ2tleBX/t/9V9JG+Uo3awVEVBkfDqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+geI/DoQRsv7irownSqlAQdXARrHjcU7P75mAHBeKPCqqEraC3yQzRdemlWZ+WiNiQIe0BB0r4p/znHOaqOUpn7j6nvwO7gWsGI+e+rGAkCU5IWJvA+QlceZ8LrBlEh3ORTTD6KN92d7WE9IORKMtq/vSGeiErQWD2dFVvugrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=KR5VkT24; arc=fail smtp.client-ip=52.103.46.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC56GXtyQpSx/OOy8MDM/Mvg878RKPFEP4f/LWtpoBq+rozJowyaULXusmj/ZyD2VtGBTTlpdTcvyRg6nb4Amv3xXAd+oSQV/herMQevHWjwCvKLrf1TAmk0Z/5ve3r+ytASL8ZzTtym8ooX7o7CUvsNvpe3fwFIfveOAoFitZtTbXJ+5Ut9isDyWqVVqCsIpWgzkyHLwJYxKm+EbphSKVPbk/dnLBA4+7sv0tfeT82ECXgPElY4/YfJX95zJyC4WaMHsOu98ULXOwdkh3xeuaktKg6QdhNwCfyjviQg7Jb/s/UB26RD8lvbv2OYjNVoQiAL1tIVKDM6LbinRt9+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGrVdA5BErfRZZ2tleBX/t/9V9JG+Uo3awVEVBkfDqE=;
 b=nEOWZ1TvF2uju1I+mh4oMDmVYDj+86oN5Brs8zZ6aja5nWPPO8jVTyxeteWq45dCivhBzbn01HNQUpJAXY2ZZ1kWUdQXkchXZcujA2BcKMmbGOJxCCJVIUizEX0O7czjRC5IgGlaD0OrnfhROOgVzNSKFKU5fttwolqH6E1bwKj7XH+gmqotSGaoxDWYSqBDUIIM4ur6YNujRE73VWNYavJr/wDC/pvOixRJPYT9rfxhPky5cRO8bxunThZXfN3pmX3XGQ5bFf4nDFGSuPMgVXUY8590mxw6YN6KyA+R/u96nDDcQOrpeXV3Ncn7ZNondU1QZg5atBQQleF31gZctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGrVdA5BErfRZZ2tleBX/t/9V9JG+Uo3awVEVBkfDqE=;
 b=KR5VkT24z2sNYre/xZxARjxzfKfj2+bYeeuusTpXXUCI44yUSTjSOHznTH43q1QgT2vMnqG9PgZ5kW19AbYSPL13bqIUwxSWJnRVtrvRfc+OU8MHKwBL5O377rsE+kunnVinZRRYhFQF1nAVK4RP/+XSjrwjsgYXb8rec4z4z4vwvay/+bRNlnTkE0wQuria+wTHxvyYU3V1PYvqgOeZQJ0gWovnWt4HcvZaVI36XULIMdKOJYHHqoOpM4bNl4l/31MaAzJb6EYngXIR1grZNkSt2iaOTtT1HtD+gCZxDpmmfe7lwlvg+pNbBak8QpmywtuLtsGsnExQxAXdw6AtAA==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 AS8P190MB1254.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Sat, 6 Sep 2025 07:30:20 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%5]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 07:30:20 +0000
From: Muhammed Subair <msubair@hotmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej@kernel.org>, Samuel Holland <samuel@sholland.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: arm64: allwinner: a523: Enable MCU PRCM and NPU
Thread-Topic: arm64: allwinner: a523: Enable MCU PRCM and NPU
Thread-Index: AQHcHwAZt26ouOWl0k+iW4DyVKJH0w==
Date: Sat, 6 Sep 2025 07:30:20 +0000
Message-ID:
 <DU0P190MB244586AE96B47F85AFE7A702BC02A@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
References: <20250906041333.642483-1-wens@kernel.org>
 <20250906041333.642483-11-wens@kernel.org>
In-Reply-To: <20250906041333.642483-11-wens@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB2445:EE_|AS8P190MB1254:EE_
x-ms-office365-filtering-correlation-id: 47e39224-bd0f-434a-0db6-08dded173bed
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|13091999003|15080799012|19110799012|8060799015|8062599012|461199028|102099032|440099028|39105399003|3412199025|41105399003|40105399003|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUZtZzZuU3JmalVyaSs2TmtqZ0tsYmdwbVZqc2ZyS051RmcycFUrbWpyWmhB?=
 =?utf-8?B?dzFsV1hLK3phd3VMbkFvV1NCcTlWNE8wbmcwR3ZjRmVzZFVhcHh6azdUY1J0?=
 =?utf-8?B?SHRFelF6ZjhHM0tXZFdhQlY3TDNRZWYvQzIvdUFWbjVVTjhpWCtubFNoZkNv?=
 =?utf-8?B?WEQ5QzhkR3BoSXo1OEtWRWdvUUlpMnRtcEh6cUNJWThjS3dVQTRLZWx5YVJt?=
 =?utf-8?B?dm9ma1BNbzFkRlNLZS82a2dmd2xUWkdFTnQ3UC9CRmRLVjgwVFZyRmZTWTEx?=
 =?utf-8?B?ejVuUmhoZ1NUUitzRGxyNEwwNERWWUZLazRDWUhQVndJYkQvek9oNEdKNkk2?=
 =?utf-8?B?LzlUa3g1SGFGVHhYNUdncEZ0VW9HUE03SXhWYXp0TkFDYm9zYkJLZ1FCL2tx?=
 =?utf-8?B?ZGxmSnZwejMyaFBRY0h2NU4xNk9SdmM4ckxsUXFjN04wU3hTOTBGUjlwL3du?=
 =?utf-8?B?WWdzWG1IQTZMelpZcXp6MDQydkFwL0FoMFhDTmdPLzdvalZUS2duUW0rT1Vm?=
 =?utf-8?B?RWFIM21zR0xpblNPUktmY1lvQ2xGSnpyUEhHcUtORG83b0RreXZhRU1XTFVm?=
 =?utf-8?B?RE54UFZKTkZhTGQ0L3ExcVB1bVFreW5kK0JoTHJlZ2YyVjJkUEFwRnJMd1Zy?=
 =?utf-8?B?Vkk4NkZnM1g2QnNPZE5EajNJck9PYkxOb1FENFVFN2hKdWFjVmttVUcybzFL?=
 =?utf-8?B?V05TWUpMSjdDSllIc1pmWS9zTWo5eDNCSzRIa1lIYWZEL0tQQkgzYVFBZE1s?=
 =?utf-8?B?aXRJU1p6NENXUXdYR3VuYVZEb0NlNUNzZjZYQ0FXakVxVUwzNXJQR2M0Q3Rw?=
 =?utf-8?B?L2FObmZGM2JZRndLWkpzS3NraTdjOVp3MktLY1VqQ2ZrWUR5UDdmaGpJWDBh?=
 =?utf-8?B?SkNhRElOdmdjUUZncWZDbmFTcXZtWmlWZHBCN3Y4V1BGaS9MZGFJYVJDbit4?=
 =?utf-8?B?WUdzR0cvUFR4N0hBZHhuUkRyS2hkMXpBWFdpemlSbmtFRCtVMGxpRjZVSTc2?=
 =?utf-8?B?N3ROU0YwWkdYREdIZ3dGTjdQdTNJMnVKek5PNitBQUdtaHVicmpPZm5FK0dy?=
 =?utf-8?B?ejgwb0ZvTzdyNzFmT3Nyemp3MzJNcGxXQ3RmV0M5Y0M0cW1aSUhSaDVNeHB0?=
 =?utf-8?B?NXY1RXd6aXpzejlSR05GcmUwSEh3cHdUR0Fob1JvMU5KWGJRZkFRaitoV3lu?=
 =?utf-8?B?elFuSTQ5V1pVbzRKcDRaRVBMVWRBSWdQbTl5MVU2dCtmZ2tjWEwzR1VFU1hu?=
 =?utf-8?B?NGhWM1EyUDRnQ0c3aUdrenlqMnNhRytWbng1ZndsdllRS1RkNVViNVYzZDdK?=
 =?utf-8?B?WEdKU3NzZ1RJYzFab2F1OXM3Q3lXV3pNcysrOWZpY0UyNDg1cDhVbWNCM1B6?=
 =?utf-8?B?ZnF1bGJMcm5VSk4rSmUrSTdvbE9jQjJ5b2tHUDExdWxtNHJFclArMFNGclFj?=
 =?utf-8?B?M1VIeEI3Y1p1NnFEUk5NTFlTSzdvc0dBSFRDUzRNUGkxTjVvYVh0dHA3b2Fl?=
 =?utf-8?B?MGF3UDVaTi9YRm4wSy96c0x3bG5BdklLOENwdEEyd3ZoV1NLbC9ja1o3ZUdV?=
 =?utf-8?B?cjNWN1RoQlFxNWFhQWhlQTR5T3BBcXM1MHROMHhZWllERUlQVFBwbEZpYlZN?=
 =?utf-8?B?S1MvQWxMVmRLRzc4UFFidHNoVVc1MTU3bE5pbFROb0V3QkoyZTlrUy9vMmYr?=
 =?utf-8?B?cTZNMWxiTm1Wb09ZYmVQRzk5YnJhWnYzM0dQTXg5TnFZdFZNWjE0R2RRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekgyditIMTZPNGgzdjFsSXk3eHRzQ3Ftb1N2YjlURlFLeFdSMTAxMzBpNVBi?=
 =?utf-8?B?cmhGblZRSjlub1IrajV6L0kvdVp6dExQYkpYZyt4Yy91eGR0Mlk5QlZ3NWE3?=
 =?utf-8?B?TzJmQ1V1QmxKemxwNi9jaHpNOVhLd2JNdjh6cC9seDNpeVBxSEJKdWJIWlpG?=
 =?utf-8?B?MHVicDF1ZmttSWhaYmZCVDZQQVRoaHFWWWV3WXlOaTltZzZvdzA4Rkx4SENy?=
 =?utf-8?B?eVRFMThKUHd1UDhhSDRnZ1JrZU1NZ1hnZVAvY3paYU9DTklxRGZwUFhXWXZh?=
 =?utf-8?B?SkQ5dm5rRElHZzJvaU1iSUY3c1dnaEtwbmMvNkVYM21Ub2NMTllOZkljbHUr?=
 =?utf-8?B?YzdWK21CbGpxRkVEcDBjemk4SUtnMGtuQ084S3plaEZuU0NrUEdrNmhKdjVy?=
 =?utf-8?B?bC9kck5wNkhPb1N5SVZkWVRTMFM3bjlRQ3dMSWpDcDZ1eW1xSEdKTHZYVjF0?=
 =?utf-8?B?QXJkTXpPNTM1MmNjYVVJN3NFNlN2RDhiUExBdnJNWHc3eGFvQWFlUzYrYWVR?=
 =?utf-8?B?SHYwbFhYZkpHRGdWRjUzWTF5WkVRM3lEUHpieFZ1Y2EwSDRBQy9NR3JLcFAw?=
 =?utf-8?B?S25sdHlPOERGMXZGWFQ1K2Y3UjYxeUdQazZ5KzZjR2RyeHA4RXpWT1hNMmRP?=
 =?utf-8?B?WE9GVXllQnFYenZXbTlWbGNhdW15bXpVSVEwYUZLY1V6RG9FSjdVN3NjWGZT?=
 =?utf-8?B?R0dvM1JPb3BhL0djNGdCaW4rYWkwVXFiNmZVTGhTMmtqalB4enc2L0FDY3BY?=
 =?utf-8?B?WXA2ZHlyTkFCOXhFZTJad1BJM0NvaVA1WFJkOU5OT3BHQ1ZFOHlrSjVucUNh?=
 =?utf-8?B?WUtueEZCWUY1blVvMzV5emFqNnhmWnJOKy9HQzFjV0ljWHNpdmV4dXd6cjZa?=
 =?utf-8?B?T1lFOHkvSllNa2p2WDlmazJsTTBYdC8xcEs2NWJxKzBRSHFwMVZBNUJMK214?=
 =?utf-8?B?NmZNTGthR20xdW95K2xCN2xuVlphRmlwa1lmU2RhZ1c3KzRUYkhlWVJFeXdi?=
 =?utf-8?B?OUxTMXJQSmx6VUZzWUxzalArS3hTYTdKUDBpMUlQaTdLa01RRHU3ZCtJQU5Z?=
 =?utf-8?B?ZVZXSU9RTno5ZGJXNXZ1YjdtdndiTlh2WU91cjh0TXphVU9pcEZ4d3I4ZWhE?=
 =?utf-8?B?T1pEVXVYdUI3d3NWODdIa0svSEN2YjdKQTg0ODdiQW4vZ0lOK2Q2NEIvOGox?=
 =?utf-8?B?cnNSNW9wSytzK0FPUmE3MTc2QytTcmh3QWFMaXBiT2hPWEY4VXFhMU1KK3N6?=
 =?utf-8?B?ak55M1RjdENJQjgrWXFiLzZJRU5WSkw2K3hUOVpYeC9maHZaM2paZGNRakxC?=
 =?utf-8?B?SEJBbklKSWlPdFRyK2dnck1RYW45THBhU0ZnQkUvRVJpWXpLbjhqa01vald5?=
 =?utf-8?B?SmMrTWVlZGppQlNmM285dEU3TW9YTGdFTElyT2ZBZk10akNqNVl4WHdFMG90?=
 =?utf-8?B?YmgyYklKNVpka0hHbTQ5VXVDanhRaE8wZHNMeFVDQlUrU2xSa3hUTitQUit0?=
 =?utf-8?B?ZURsM0dKclpvVzR0VUQrTlNEd3hwbU5HbTNoMmcvSmM3L0owV2xHMVF4N29Y?=
 =?utf-8?B?OWw0TWRBdkZJN1lmOW90MklLWkxWV3lZWWF1U2hlTm9YQjQwN1QrUUV1T3hs?=
 =?utf-8?B?VlBZSTlKZlgzNVJUT09FRHFoT0htbEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-e6540.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e39224-bd0f-434a-0db6-08dded173bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2025 07:30:20.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1254

SGVsbG8NCg0KSSBoYXZlIGEgYm9hcmQgd2l0aCBBNTI3IGNoaXAgLCBhbmQgTlBVIGlzIGRldGVj
dGVkIGluICBsZWdhY3kgd2hpbGUgdGhlIG5ldyBwYXRjaGVzIHNob3dzIGJlbG93IG1lc3NhZ2Ug
DQoNCnVwc3RyZWFtIDYuMTctcmM0DQojIGRtZXNnIHwgZ3JlcCBbICAgMjEuOTg4MjE1XSBldG5h
dml2LWdwdSA3MTIyMDAwLm5wdTogcHJvYmUgd2l0aCBkcml2ZXIgZXRuYXZpdi1ncHUgZmFpbGVk
IHdpdGggZXJyb3IgLTExMA0KIDcxMjIwMDANClsgICAyMS45ODgxNzNdIGV0bmF2aXYtZ3B1IDcx
MjIwMDAubnB1OiBkZWZlcnJlZCBwcm9iZSB0aW1lb3V0LCBpZ25vcmluZyBkZXBlbmRlbmN5DQpb
ICAgMjEuOTg4MjE1XSBldG5hdml2LWdwdSA3MTIyMDAwLm5wdTogcHJvYmUgd2l0aCBkcml2ZXIg
ZXRuYXZpdi1ncHUgZmFpbGVkIHdpdGggZXJyb3IgLTExMA0KDQpsZWdhY3kgNS4xNQ0KDQpbICAg
MTMuODg3ODkyXSBucHVbMTA2XVsxMDZdIHZpcGNvcmUsIHBsYXRmb3JtIGRldmljZSBjb21wYXRp
YmxlPWFsbHdpbm5lcixucHUNClsgICAxMy44OTAzMjJdIG5wdVsxMDZdWzEwNl0gdmlwY29yZSwg
cGxhdGZvcm0gZHJpdmVyIGRldmljZT0weGZmZmZmZjgwYzFhMTFjMTANClsgICAxMy44OTAzOTRd
IG5wdVsxMDZdWzEwNl0gdmlwY29yZSBpcnEgbnVtYmVyIGlzIDExNi4NClsgICAxMy44OTA0NzFd
IHZpcGNvcmUgNzEyMjAwMC5ucHU6IHN1cHBseSBucHUgbm90IGZvdW5kLCB1c2luZyBkdW1teSBy
ZWd1bGF0b3INClsgICAxMy44OTI1ODldIG5wdVsxMDZdWzEwNl0gTlBVIFVzZSBWRjMsIHVzZSBm
cmVxIDY5Ng0KWyAgIDEzLjg5Mjc1NF0gbnB1WzEwNl1bMTA2XSBHZXQgTlBVIFJlZ3VsYXRvciBD
b250cm9sIEZBSUwhDQpbICAgMTMuODkyNzY2XSBucHVbMTA2XVsxMDZdIFdhbnQgc2V0IG5wdSB2
b2woMTAwMDAwMCkgbm93IHZvbCgtMjIpDQpbICAgMTMuOTM4NjY0XSBucHVbMTA2XVsxMDZdIGNv
cmVfMCwgcmVxdWVzdCBpcnFsaW5lPTExNiwgbmFtZT12aXBjb3JlXzANClsgICAxMy45Mzg4ODld
IG5wdVsxMDZdWzEwNl0gdmlwY29yZSwgYWxsb2NhdGUgcGFnZSBmb3IgdmlkZW8gbWVtb3J5LCBz
aXplOiAweDIwMDAwMDBieXRlcw0KWyAgIDEzLjkzODkwMF0gbnB1WzEwNl1bMTA2XSB2aXBjb3Jl
LCB2aWRlbyBtZW1vcnkgaGVhcCBzaXplIGlzIG1vcmUgdGhhbiA0TWJ5dGUsb25seSBjYW4gYWxs
b2NhdGUgNE0gYnl0ZSBmcm9tIHBhZ2UNClsgICAxMy45Mzg5NDhdIG5wdVsxMDZdWzEwNl0gdmlw
Y29yZSwgY3B1X3BoeXNpY2FsPTB4MTBjYzAwMDAwLCB2aXBfcGh5c2ljYWw9MHgxMGNjMDAwMDAs
IHZpcF9tZW1zaXplPTB4NDAwMDAwDQpbICAgMTMuOTQwMjMwXSBucHVbMTA2XVsxMDZdIFZJUExp
dGUgZHJpdmVyIHZlcnNpb24gMS4xMy4wLjAtQVctMjAyMy0wMS0wOQ0KWyAgIDI1LjA5MDkwNV0g
c3VueGk6c3VueGlfcGRfdGVzdC0wLnBkLW5wdS10ZXN0OltXQVJOXTogcnVudGltZV9zdXNwZW5k
IGRpc2FibGUgY2xvY2sNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZW4t
WXUgVHNhaSA8d2Vuc0BrZXJuZWwub3JnPiANClNlbnQ6IFNhdHVyZGF5LCA2IFNlcHRlbWJlciAy
MDI1IDg6MTQgQU0NClRvOiBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2
aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNv
bm9yK2R0QGtlcm5lbC5vcmc+OyBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+OyBKZXJuZWog
U2tyYWJlYyA8amVybmVqQGtlcm5lbC5vcmc+OyBTYW11ZWwgSG9sbGFuZCA8c2FtdWVsQHNob2xs
YW5kLm9yZz4NCkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1zdW54
aUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFuZHJlIFBy
enl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29tPjsgSmVybmVqIFNrcmFiZWMgPGplcm5lai5z
a3JhYmVjQGdtYWlsLmNvbT4NClN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2MyAxMC8xMF0gYXJt
NjQ6IGR0czogYWxsd2lubmVyOiB0NTI3OiBvcmFuZ2VwaS00YTogRW5hYmxlIEV0aGVybmV0IHBv
cnQNCg0KRnJvbTogQ2hlbi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPg0KDQpPbiB0aGUgT3Jhbmdl
cGkgNEEgYm9hcmQsIHRoZSBzZWNvbmQgRXRoZXJuZXQgY29udHJvbGxlciwgYWthIHRoZSBHTUFD
MjAwLCBpcyBjb25uZWN0ZWQgdG8gYW4gZXh0ZXJuYWwgTW90b3Jjb21tIFlUODUzMSBQSFkuIFRo
ZSBQSFkgdXNlcyBhbiBleHRlcm5hbCAyNU1IeiBjcnlzdGFsLCBoYXMgdGhlIFNvQydzIFBJMTUg
cGluIGNvbm5lY3RlZCB0byBpdHMgcmVzZXQgcGluLCBhbmQgdGhlIFBJMTYgcGluIGZvciBpdHMg
aW50ZXJydXB0IHBpbi4NCg0KRW5hYmxlIGl0Lg0KDQpBY2tlZC1ieTogSmVybmVqIFNrcmFiZWMg
PGplcm5lai5za3JhYmVjQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IENoZW4tWXUgVHNhaSA8
d2Vuc0Bjc2llLm9yZz4NCi0tLQ0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBTd2l0Y2ggdG8gZ2Vu
ZXJpYyAodHh8cngpLWludGVybmFsLWRlbGF5LXBzIHByb3BlcnRpZXMNCi0tLQ0KIC4uLi9kdHMv
YWxsd2lubmVyL3N1bjU1aS10NTI3LW9yYW5nZXBpLTRhLmR0cyB8IDIzICsrKysrKysrKysrKysr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTVpLXQ1Mjctb3JhbmdlcGktNGEuZHRz
IGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTVpLXQ1Mjctb3JhbmdlcGktNGEu
ZHRzDQppbmRleCAzOGNkOGM3ZTkyZGEuLjdhZmQ2ZTU3ZmU4NiAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjU1aS10NTI3LW9yYW5nZXBpLTRhLmR0cw0KKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTVpLXQ1Mjctb3JhbmdlcGktNGEu
ZHRzDQpAQCAtMTUsNiArMTUsNyBAQCAvIHsNCiAJY29tcGF0aWJsZSA9ICJ4dW5sb25nLG9yYW5n
ZXBpLTRhIiwgImFsbHdpbm5lcixzdW41NWktdDUyNyI7DQogDQogCWFsaWFzZXMgew0KKwkJZXRo
ZXJuZXQwID0gJmdtYWMxOw0KIAkJc2VyaWFsMCA9ICZ1YXJ0MDsNCiAJfTsNCiANCkBAIC05NSwx
MSArOTYsMzMgQEAgJmVoY2kxIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQogDQorJmdtYWMx
IHsNCisJcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KKwlwaHktaGFuZGxlID0gPCZleHRfcmdtaWlf
cGh5PjsNCisJcGh5LXN1cHBseSA9IDwmcmVnX2NsZG80PjsNCisNCisJdHgtaW50ZXJuYWwtZGVs
YXktcHMgPSA8MD47DQorCXJ4LWludGVybmFsLWRlbGF5LXBzID0gPDMwMD47DQorDQorCXN0YXR1
cyA9ICJva2F5IjsNCit9Ow0KKw0KICZncHUgew0KIAltYWxpLXN1cHBseSA9IDwmcmVnX2RjZGMy
PjsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQogDQorJm1kaW8xIHsNCisJZXh0X3JnbWlpX3Bo
eTogZXRoZXJuZXQtcGh5QDEgew0KKwkJY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktaWVlZTgw
Mi4zLWMyMiI7DQorCQlyZWcgPSA8MT47DQorCQlpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZwaW8g
OCAxNiBJUlFfVFlQRV9MRVZFTF9MT1c+OyAvKiBQSTE2ICovDQorCQlyZXNldC1ncGlvcyA9IDwm
cGlvIDggMTUgR1BJT19BQ1RJVkVfTE9XPjsgLyogUEkxNSAqLw0KKwkJcmVzZXQtYXNzZXJ0LXVz
ID0gPDEwMDAwPjsNCisJCXJlc2V0LWRlYXNzZXJ0LXVzID0gPDE1MDAwMD47DQorCX07DQorfTsN
CisNCiAmbW1jMCB7DQogCXZtbWMtc3VwcGx5ID0gPCZyZWdfY2xkbzM+Ow0KIAljZC1ncGlvcyA9
IDwmcGlvIDUgNiAoR1BJT19BQ1RJVkVfTE9XIHwgR1BJT19QVUxMX1VQKT47IC8qIFBGNiAqLw0K
LS0NCjIuMzkuNQ0KDQoNCg==

