Return-Path: <netdev+bounces-205852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF1B00759
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BBC17CF13
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96D27602D;
	Thu, 10 Jul 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="h58CDRG8"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020128.outbound.protection.outlook.com [52.101.171.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9C276025;
	Thu, 10 Jul 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161541; cv=fail; b=hsMwp0i7v3l9UTiEYQi2Fy24aOuqBA16/ItSxdvUhXF080qubBDq9RRgdyPuAjUdP3hvtk/N7wD/En7GHIAWtvjd9A8DuQZjmUVaqb4s0bNHLfQxvMfO1BDsAgVktGna5SNURL60+JNOHsuNnaC3/JddtNnj8WxqSHhv9ucZ4z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161541; c=relaxed/simple;
	bh=Aor/1lWUUf8w5zx6gMP3+hdgTICjhNYr+iLW2PbGNcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=leV+gixV9A1hC8rsiqjKo4d9LFEBhoaudjr45C4a4sZTvJmyTBmN7y3ez8iqi3WECB8k5ea1yegI9jyCDRHYd0yS/eOFmQzkERtzWvvgkHvjJUcBOewPj5daQSiQrSFrpFuO7hzeL1H2lfpZzraYPvOmtuwB4KmxTEBh+S9ofwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=h58CDRG8; arc=fail smtp.client-ip=52.101.171.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5AXv76lkOGpYhnb/YMWr+kSOZGmZ3/uj7fn8NvuwSR4MOfbAUKYNbG3kADycXrhTJSdIdntYRBqsGGFxpuIYKDVRF2KRfUNWvYgypQIpOA80RsnqIfc6HaNjaWhk0kWMuo9/I0b/DPZUhrPr+cv7I9jRUf+MLVBr+qnpcKHuC4D4or8G92RtaU3mUIEncqrivzq8HEsp2fAB3I4Q052JuVdqtKaoYZtkErTRA2sO0qrXdgjsHi+pKjhD3nohMaeGgU4v0Q6efO/nvfLA1ltB3/C0dN4b7CzFGUUPhMPEuPVwDVKTebNAIUwtxNTQ0vC8dEoSkW4ow64Z12tzblfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aor/1lWUUf8w5zx6gMP3+hdgTICjhNYr+iLW2PbGNcY=;
 b=mvbFw4WqJ1boCgICRvoaJJle9sn9q+JV8oOceJw1srIRjiZ68XzMFbIoz7QAZvY0+EIyQbHYgh5hy/8m0lr2626xldBAhBcXhTX/x4mZ7t2y6T+eJfMd4h4voBBDUFeCpJ73B/4QZza8Svq0a2wNs8QVws6qDvDI2DWsw8ITOtOXmTVfp/vAYUba+5tkkzlD3spBHwMJOKIZ//KoL8IN+o5x3875+ISNOVPzR7xLSTu419MhnNj/j1VfzJd1kaxXB1kArdfEZ56S+DOmFOIOnKYoksuIj5+lYyKBMBzgSOg+2hk5tF+ZqvXIXJRNytuPfZ6DeG3C3TgtbBrQShKIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aor/1lWUUf8w5zx6gMP3+hdgTICjhNYr+iLW2PbGNcY=;
 b=h58CDRG8K5kBtyhbgsp8Q5YjzrBdw7oNksFSpSEnMhezszPM0Kz3ZTu9TMwU/BNFkMneSoR677DO6G2mqxJzZsLLYxeX6AoLyaEhIHXAlbKBWcIRafSjwYq/czFQZtMM5m3Z3eWnm+waoHHo/rABcfANxhaa8kMotpIVS3GNkmk=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by BEYP281MB4217.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:32:12 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3ce6:eea3:7b3f:a837]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3ce6:eea3:7b3f:a837%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:32:11 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next v4 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
Thread-Topic: [EXTERNAL]Re: [PATCH net-next v4 2/2] net: pse-pd: Add Si3474
 PSE controller driver
Thread-Index: AQHb6c9Btcy8j5pHqUCwns43VZZiTbQmr2YAgATcloA=
Date: Thu, 10 Jul 2025 15:32:11 +0000
Message-ID: <53c71efc-e29b-482a-bd6a-7a66a2d2d415@adtran.com>
References: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
 <4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
 <20250707151738.17a276bc@kmaincent-XPS-13-7390>
In-Reply-To: <20250707151738.17a276bc@kmaincent-XPS-13-7390>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|BEYP281MB4217:EE_
x-ms-office365-filtering-correlation-id: eb255197-b311-4893-7fb4-08ddbfc6f0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkxHNUc2RmxQNGdBbkxvbkpPMEVtTUpqNWV6cm52VUtYSkNwWDhha1dnNlEx?=
 =?utf-8?B?bmpsUFB4ZTZBOUNqUVlXejhiNVVFbkNMZndqTWh3cU1XV3l5cXF4UDhCS2o3?=
 =?utf-8?B?TExHeXo0MmZGWFZ2alBrN0UwcmJDbVNlYXVLTGdYT3U4MXNEWXNsb3EvTnhm?=
 =?utf-8?B?YlF5RFhIeCtyNFQ2clJ3RU1hcjI4eGNjdGU1Q1dJMEZ6Tko2VCs2bURNbDFQ?=
 =?utf-8?B?NjhhakFQZU16ZURRL1BVNGlOWFFhYWExYWhWc0ppcERnbjRmZ1FiWUg1OWMr?=
 =?utf-8?B?MnpDU0tNRzNZWC9YenBDbmY4UEVzRmhmYzd5RVNMbElLTkpBQ20zbFBJTldS?=
 =?utf-8?B?TEYyaUpqa2lMVkZtK0VoUkhQWDQxOWJDdVZmbmR6RmJxYlpweEJFTDhuU0tX?=
 =?utf-8?B?bHVkbG1FSHJONWJkVEZQV3d6cklHb1BkVEkyWFR3MnRGdlhOS0hoaExLN1d1?=
 =?utf-8?B?WWYxUzlaZ1lacVVHc1RWNGFldFJQNm94NitSMHk4Tm05WmFIOTQrbTQ5Qk03?=
 =?utf-8?B?R1pROW5PczA4dUZ2YXB5RVp5N1BESzI1bHVPeFlDZW4wcjBQTGVSMUtHdW5U?=
 =?utf-8?B?SXdLZmNJU2EzSGxwQUs3b2ZmTDJtRkx1SW5jTGk4NDFFNmc3LzNkRlpySk4x?=
 =?utf-8?B?SlN0eEtjSmNYT0JrbWthVkdlVmJuWldpVlhMWm5wRmxCeTNyNk54YklDaTgy?=
 =?utf-8?B?SWlMeDNqWncza3FickdST0dGZFJ4U3F5Y3YzSFV4MTBwaTJROCt5T3FrQ1ZV?=
 =?utf-8?B?UDVXUnkvTkdDYkp3RjVTQ1N1Q1hDTkx2Q1JudXZXakRaeXV0SWJ4ZTdHNElG?=
 =?utf-8?B?VURlalhKeVJ0dVFocmpYNlJUaWtYUmh1R2RVaUUwT2NIbmg5eGZWdG5KbVBJ?=
 =?utf-8?B?bmVBUkk2VXRGSjY4OU42anQ0R0dGVFg5NlNpcUJKdTRLZUpjeEZZdmJKTG8y?=
 =?utf-8?B?WTRad3R2bitRLzBUVnFwcUtrT2JKNG5yY2FUeFNWanVsd2xyUFhEc1ByS1lh?=
 =?utf-8?B?dUYvL1kwTWhTSEdiNEJBbkl5NUJ2Rm5oRHhCR2kwZ28rMjJRT0dZekphczZJ?=
 =?utf-8?B?YVdEQWE3SHBLRUtoakRjd0VWSis0RTNIeHdSM0ROOHR3TjJIL29uMUFyUjRn?=
 =?utf-8?B?NDRMZlhBRjdGZ1N2dlJQYnFOWlpxS1BZQ3FLbkM2dUpSMmlDUTJDOFJ2N3Fz?=
 =?utf-8?B?VGpkQjB5Q3prcFNLSVM1NnN1NXpWQ1d2WlBrb1lheUppYzVSM0M1WU5ndGxW?=
 =?utf-8?B?RUhZZUNRRlBSbXVrelBJK3hEOHk0WHVSN2tpSnRQMGI0VTRWdXdMeXBxYkdi?=
 =?utf-8?B?M094ekRwemNDejBaalJUd0IzTFF3TElSQzJCSFJxUlFCUVoyZmRnbzZBOGFL?=
 =?utf-8?B?K256UXlxd3dWTk9kQUUrTVREV2RWL1diWEx3LzR4RWF5SUNvbG1MM2U0eTRZ?=
 =?utf-8?B?bHJ3eUl4c0ZJNU1xbGtYVnVOek9nTG9TT2FUUW9YOHFIZmFaYnlzVlNSTFJt?=
 =?utf-8?B?VTYxZWZENGNYNmpUc2UraEJNQmhIczJPYjUvQXM5djdvUndsRTlFZHpMSEtn?=
 =?utf-8?B?elczVUxRbVdYelZrd2JCLy8yNkdHcEVkRFluN2tHaGkyWDZsbGR1WjhZNmlG?=
 =?utf-8?B?OXJzNGVmdVFOaDNQck5vbXp2clgxWHRUTk90WDVYMGUwZG5pMFp3VzE5dVdq?=
 =?utf-8?B?R3pIMXBuRXNDS3J5UW1rM0NydWxTZ2kwN1IwelNndC9rU01LellPY1NaMjZu?=
 =?utf-8?B?SkJWc0IzMks0dlNRcWcrWlJLR2tTNnowdUpYM3FtSlZ5WC9XWmphNWVkMHVq?=
 =?utf-8?B?eExYNmd2S0JGMUl0dWFFMVdxekFKKzJVc2lvckJBU1BSeEdsZXpmQnFBczRO?=
 =?utf-8?B?ZkplN2VheVpmRmZ6dlVURm9CdjFFVGVSNlN1d0tKcGp3eFExMWdvSWdYblBp?=
 =?utf-8?B?aG1aUGhTMGN1YVU1ZmxoSjVkbmtqU1Bic0RwSDFzencyMDVUQThrUTA0MmhC?=
 =?utf-8?B?U1pkaWFpQTVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RldhN09mZmltMGNFKzVQbUNsTmVWdnB0cGNsL3RJZDhBL2NTTjNCQUM5R3dr?=
 =?utf-8?B?WERYWldzR09ncHFLMmp0YmhhcXNPZnNXUjIrRDh2OGFQRzVUb2ZzWEtMakw5?=
 =?utf-8?B?S3RlRHdoSk1LcVB4c3NLNGkwY1NOWTd6YzZrOExpcHFiamozeTZpRTRKbXFu?=
 =?utf-8?B?V0hiOWlDckp6VzM1amdVb0xFZG5RMUZsVmZzVExOVnByTnV6cHBDVW1ablR2?=
 =?utf-8?B?Wk1VL1MxWFlTR2ttWTQ4WWJmaVV6cjIzYU9VWHBZL3JlTEo5Ym9XU25PVWhk?=
 =?utf-8?B?UDF0WlBhRWZqNE52dTBsSXZUTE9ZYmJ6NDVUb2hoV2VLbkpsaWZIbjlxRWtn?=
 =?utf-8?B?NjU5aUxuSGVwaU11OWxxV2lYZTJobURWMHlqeVg4dkMveE9vUlNwazUxNWpr?=
 =?utf-8?B?OXhxL0JtSEpSWlcybFprWmtjQW5aRkl1RkhBVmdzVGMzUWhIZCt3S0xPRnUz?=
 =?utf-8?B?Q1pqVHhoUFYvM3lkY0RUS25KM2VvNnlQa205K1J6NTRvbGp6VlMvWlpwOFB6?=
 =?utf-8?B?aHdaRGNGRE9UZHZJN2VnVkx1a0pZQjZVSXpLV0x0SUVJMGk2V1dTQUtvQjNU?=
 =?utf-8?B?Q3ZkU2ZHTjJrb3NlTWt3UncwMFV1N2h2RXFBVHlRSHpsbFJmSjZaNUNDbCtq?=
 =?utf-8?B?dEpnbXZLMXhRclhuZnFIUkhnb0xnL2diYTc0WTl4K0FLZEpBczlHczM0eEJh?=
 =?utf-8?B?ZlhzYnVhbmJqWEZBVVBPb3F1VHZaSVRCUFd6QitWZlIycjMwVGFENzAvUEN5?=
 =?utf-8?B?d3RLUHFkd1VzanYzOTZhRDZwV3N1NXZUZVhMZWsveGovQ1I3bmNIVStsTWYx?=
 =?utf-8?B?YnA0eEI5Mm9hUnU4S1VwR1ZFWkdQK3gxRE15WDgxSjdFVUhnL1JlTFREc3pj?=
 =?utf-8?B?eXd4MWlNTStqVjEvdVZwR0xtR1dWN25zbkFObEJKWTVQU1lLYWh4dWV2a1NI?=
 =?utf-8?B?T2IyWkgwSkIzZi9CMml2d2pWc3FmQmNiNU01SG50RGt4ODVzZDA0eThGV1pl?=
 =?utf-8?B?ZVdnTVhaL3NUS1NxOVNyQ3JhdHBvYmFKUGZ0ZUFjUS9lU3JiS040Si80YkFK?=
 =?utf-8?B?NmJQTTFWblM2Y3kwRVV1Vlpyb2RBckZDTERUcUtmdUNuZEI0L3hNemo0elR3?=
 =?utf-8?B?L0NRaVc5UnBDSERIMi9DOW03QU9qMmgrbXBrdzFGeldMYWRzSFozcW1uVkVm?=
 =?utf-8?B?dHRYZXh0eXkxZS9oSTZXV0hLaVU0QlZNMU1rQ0VaYVBjK202SHZBZkVxYlNS?=
 =?utf-8?B?K3lKdXdTZEhIaDFnUnNZV0M1dnFZN3NBN1lvSmh2RXlxMFpZZWxTTXAyWjZI?=
 =?utf-8?B?SEpCVnBMc2JCbXhVQUtSYTdHQVNzU0VaMGFmSDdxUXU0TmlqR1NxbTY1QWtu?=
 =?utf-8?B?dkJ1ZkE1OFNzVE1CanpBWXIzSzNLSTRlUXJvZVpEYkZqMkJ2RlRoZTViYlhL?=
 =?utf-8?B?S1VTSmEvWkc1dHlnYlYrcCtWZ0hYMUFFNTNWS045L0dnUDBWQ2d2YkdFZlFM?=
 =?utf-8?B?Q05VZXFUSnlHeDMyVGtyangvQXZjc2hEeit1SjI5azBITFl5QmVjWmdoUDM2?=
 =?utf-8?B?eUhHY2tzYlZSblFETGtUR0t1WEZETWtOdVo0L25MRTA0RDFoaUNiNndyVDF5?=
 =?utf-8?B?Zy9jak1NNjBtOElHbTl4QlRwcXpZT0Z0M1AvMkdqOWZZS0R6Vit1MDVFdXNG?=
 =?utf-8?B?VjZ3VXN3YTYvQldVdUxCQVhicDVXMnNrUkZmeEtNdDRYazV2ejNzS3lXRU1Y?=
 =?utf-8?B?Sm5yaWt0bHFxSTRqVHBsM2UvbFVmdi9GL1hJOHJjY2sxSVZwMEw3TU9BRTJh?=
 =?utf-8?B?a1llQmJVa2JqTCtwWVRtb3pXQjVYV2tIWnFob3FmTmE1TWhxNzhGTWhONWd4?=
 =?utf-8?B?UHpVdHF0Yyt4ZG9mMzR5OHV6L3ZnSnIvYWQ5L29ZWDdZT3JJZlYyWFlGUmdk?=
 =?utf-8?B?YmhaZWxwM2MzWjZpY0cyVnZnejZvYWxhZGRMQ1o1MXkydkJ4akFPZnplTmw1?=
 =?utf-8?B?K0lleDJrcDcyMFpjZVZXSnRVTmFQTDhtZ2xIWGNtZjl1RUFnSUw2a3VBOExn?=
 =?utf-8?B?TnN3WE93WG1YLzZVMktqRWdoNkNDZXN5VFh3cUJBVTBtUmo4Q3h2Qm00QlAy?=
 =?utf-8?Q?EZxflclu//H3RGViDSnmcVpEl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92674DEA404FF948BDC59926D95F4776@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb255197-b311-4893-7fb4-08ddbfc6f0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 15:32:11.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODebi1ZJxeAzgt9Wy6fHORTOV31uSqsnKw/zqhCexmQfjpQp2en/G8QV4ZODA1PcFWbmXT1wttr/q5UdsfPiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4217

T24gNy83LzI1IDE1OjE3LCBLb3J5IE1haW5jZW50IHdyb3RlOg0KPiAuLi4NCj4gDQo+IA0KPj4g
Kw0KPj4gK3N0YXRpYyBpbnQgc2kzNDc0X3BpX2VuYWJsZShzdHJ1Y3QgcHNlX2NvbnRyb2xsZXJf
ZGV2ICpwY2RldiwgaW50IGlkKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHNpMzQ3NF9wcml2ICpwcml2
ID0gdG9fc2kzNDc0X3ByaXYocGNkZXYpOw0KPj4gKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
Ow0KPj4gKwl1OCBjaGFuMCwgY2hhbjE7DQo+PiArCXU4IHZhbCA9IDA7DQo+PiArCXMzMiByZXQ7
DQo+PiArDQo+PiArCWlmIChpZCA+PSBTSTM0NzRfTUFYX0NIQU5TKQ0KPj4gKwkJcmV0dXJuIC1F
UkFOR0U7DQo+PiArDQo+PiArCXNpMzQ3NF9nZXRfY2hhbm5lbHMocHJpdiwgaWQsICZjaGFuMCwg
JmNoYW4xKTsNCj4+ICsJY2xpZW50ID0gc2kzNDc0X2dldF9jaGFuX2NsaWVudChwcml2LCBjaGFu
MCk7DQo+PiArDQo+PiArCS8qIFJlbGVhc2UgUEkgZnJvbSBzaHV0ZG93biAqLw0KPj4gKwlyZXQg
PSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCBQT1JUX01PREVfUkVHKTsNCj4+ICsJ
aWYgKHJldCA8IDApDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwl2YWwgPSAodTgpcmV0
Ow0KPj4gKwl2YWwgfD0gQ0hBTl9NQVNLKGNoYW4wKTsNCj4+ICsJdmFsIHw9IENIQU5fTUFTSyhj
aGFuMSk7DQo+PiArDQo+PiArCXJldCA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoY2xpZW50
LCBQT1JUX01PREVfUkVHLCB2YWwpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJcmV0dXJuIHJldDsN
Cj4+ICsNCj4+ICsJLyogREVURUNUX0NMQVNTX0VOQUJMRSBtdXN0IGJlIHNldCB3aGVuIHVzaW5n
IEFVVE8gbW9kZSwNCj4+ICsJICogb3RoZXJ3aXNlIFBJIGRvZXMgbm90IHBvd2VyIHVwIC0gZGF0
YXNoZWV0IHNlY3Rpb24gMi4xMC4yDQo+PiArCSAqLw0KPiANCj4gV2hhdCBoYXBwZW4gaW4gYSBQ
RCBkaXNjb25uZWN0aW9uIGNhc2U/IEFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IGl0IHNpbXBs
eQ0KPiByYWlzZSBhIGRpc2Nvbm5lY3Rpb24gaW50ZXJydXB0IGFuZCBkaXNjb25uZWN0IHRoZSBw
b3dlciB3aXRoIGENCj4gRElTQ09OTkVDVF9QQ1VUX0ZBVUxUIGZhdWx0LiBCdXQgaXQgaXMgbm90
IGNsZWFyIGlmIGl0IGdvZXMgYmFjayB0byB0aGUNCj4gZGV0ZWN0aW9uICsgY2xhc3NpZmljYXRp
b24gcHJvY2Vzcy4gSWYgaXQgaXMgbm90IHRoZSBjYXNlIHlvdSB3aWxsIGZhY2UgdGhlDQo+IHNh
bWUgaXNzdWUgSSBkaWQgYW5kIHdpbGwgbmVlZCB0byBkZWFsIHdpdGggdGhlIGludGVycnVwdCBh
bmQgdGhlIGRpc2Nvbm5lY3Rpb24NCj4gbWFuYWdlbWVudC4NCj4gDQo+IENvdWxkIHlvdSB0cnkg
dG8gZW5hYmxlIGEgcG9ydCwgcGx1ZyBhIFBEIHRoZW4gZGlzY29ubmVjdCBpdCBhbmQgcGx1ZyBh
bm90aGVyIFBEDQo+IHdoaWNoIGJlbG9uZyB0byBhbm90aGVyIHBvd2VyIGNsYXNzLiBGaW5hbGx5
IHJlYWQgdGhlIGNsYXNzIGRldGVjdGVkIHRvIHZlcmlmeSB0aGF0IHRoZQ0KPiBjbGFzcyBkZXRl
Y3RlZCBoYXZlIGNoYW5nZWQuDQoNClllcywgSSBkaWQgdGhpcyB0ZXN0LCBhbHNvIHdpdGggZGlz
YWJsaW5nL2VuYWJsaW5nIFBJIGluIGJldHdlZW4gUEQgZGlzY29ubmVjdHMvY29ubmVjdHMuIA0K
RWFjaCB0aW1lIGNsYXNzIHdhcyBkZXRlY3RlZCBjb3JyZWN0bHkgKGNsYXNzNCB2cyAzIGluIG15
IGNhc2UpLiANCkkgY2hlY2tlZCBhbHNvIGNsYXNzIHJlc3VsdHMgd2hlbiBubyBQRCB3YXMgY29u
bmVjdGVkIG9yIFBJIHdhcyBkaXNhYmxlZCwgYWxsIE9LLg0KDQoNClRoYW5rcywgDQovUGlvdHIg
DQo=

