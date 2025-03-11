Return-Path: <netdev+bounces-173996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D7A5CE31
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13A3189F584
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F27263C95;
	Tue, 11 Mar 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EZvMQ8vi"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9525C710;
	Tue, 11 Mar 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718983; cv=fail; b=mzOueuUrvd9FIfbDKXdH8wcysVf/BZGJeoq1QkmNir6lrZyr6GBEj/3lp6yzSdwodZJNETlYWGx2JkVzgk6GPwNMGpsK+fF2hDgpXPCDskVO77JJmVNCGUhmXt/nzsFaaTcgd3rAOAVjz35R/WK7EgzMVIQah2mLd1Dl3wQJljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718983; c=relaxed/simple;
	bh=sydcEjVa8OilYJ5mYqFHYR15zFHk7qKUsAF/OuO8wA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T00xPWOYPpEKYJa6SPeTZDWCGvrACd9Mdbr3r4oa6b1ZOwUXaz6CxCVUTAazYGf91U/Zp02WYOBKkxLlXaS6TRY1qF77fKM+0Du6EveWxIPhNt7itVcwMRGtOItsGCA5S1Qr0yL78gQ9It6ykNyi2DPZcKUAB+OjQNLXdfSHR80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EZvMQ8vi; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/YNbyAFWSOkk0F4Hjy//g28xKwJV+F+hSBVW7rlF37QNDH5RFZuNUM1QPlkKpOaBblPa0CSXXd9bduowMMvH2a9JvHiz/PKppwb15uPg6J5XBiLiVf73APxvliAEC+dORKt/6V+wbIIRLlI4kfQ2xAIreb6ZAkiET6yC8LXDktz96IIHdzvV5Xsuj55nIv4GoGO465+QHARTcZghhOWB3ELAmxrz5DtyW3IiAJP65HGQgvhEz+nv9kmBpxwg830sqXjJ5o/9hIUQdgMlh2DV8/fInseI5dwTh0HaOfqsrJik5b/ZwuxKyvX5RlyPqsxEJlmVbxR4y/GeBf8IZd9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sydcEjVa8OilYJ5mYqFHYR15zFHk7qKUsAF/OuO8wA8=;
 b=eP0+uaOWw1CvyQ5fLQ+mQAzgaCQuyvHQ/eGVcwCd7LObTjxzITZ6E8Y67YXvIpVyP+Ku1JrBXR0C8tOhk69VrhTD+lbmihih3EoZb5fdWAc94Hy1PJUayE7jwWYmcD4F/KuJDqeH6LjYivYSZoQx8G7x0lMVlSY+dLAlM3PnDPBwGuQPnQInfiTnuETqRo9eXqvJqkkTYetSNO7arrD/lDCPsAAdc0hQcvADO6v0pOc2igSaxgf+64Wh+cwyCcGDx4cMVLE6KN0TzfB5OSIa3HCs0sAZf9pHh8Rs7WjtBOJEScebRgOItw+y7z1fc+8SytEO/M2DliX4+zzi0M44uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sydcEjVa8OilYJ5mYqFHYR15zFHk7qKUsAF/OuO8wA8=;
 b=EZvMQ8vi7GK+HcuQvJIvnaieJmNNMpb3/Se9NBdOmNprnk78sg/MwCDwOwvgkUoQKY4j/mzVIrqv4J6QJiopxHWT7OM/eInikVqhLiC0lYckfh55YSE9M3fFBMAESAgQO3/tcJ7Yk6ZoQ6coaIV+TzoNY9EDro5XdJWQGHz+3QcTa9XT+pVv3Vl48xzA4mZd6x3eKW4qVYBShdSa/eNGX+oWdYZJdHTPP/1Gb5inaOuCzn82MZLIa14zonczjgcSRVQybYabdw4I6zqMQNW5KY5Vci4nh3YU8NA5+pNQkjaCQvd/MSrxsgNp1tNzFYBsU1eGmgmT5zzdBeXMXYFjiw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU4PR10MB8542.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:49:38 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:49:38 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "jpanis@baylibre.com"
	<jpanis@baylibre.com>, "npitre@baylibre.com" <npitre@baylibre.com>,
	"c-vankar@ti.com" <c-vankar@ti.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Topic: [PATCH net v3] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Index: AQHbkpxSlZU285rUb02xUW0qbYhsX7NuR3SA
Date: Tue, 11 Mar 2025 18:49:38 +0000
Message-ID: <3f6b99966ff7ad119d087e65f0f58e5b1411066f.camel@siemens.com>
References: <20250311154259.102865-1-s-vadapalli@ti.com>
In-Reply-To: <20250311154259.102865-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU4PR10MB8542:EE_
x-ms-office365-filtering-correlation-id: 48716e14-4873-444e-cab9-08dd60cd79c1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVloOHBOTHFGZXJjM0tCZmNHMDBINHcvR1J6cWtUTllkb3JneE5RbUN4TFZJ?=
 =?utf-8?B?bmZVbFVjWE5kZXF2STlHRTh2ZlBlZHNnZzRpVUJlUXR0WFhPMkVEaS9ndGQv?=
 =?utf-8?B?MWNJRXpMT3VmR054ZCtKU2lIdkdrNmxWQjZodTZFQmNEZFpHc1pvZStoWnVp?=
 =?utf-8?B?WGtHUmpDNTNmblhRK3FBNkJNZmVOR094Tmx2a29LQ2xMUHBSUm1rN0EycGM3?=
 =?utf-8?B?UzF3WGU0QkFyZDBGYkVMdzlMRUdWdDIrRzVlWDlRY2ZReEUvdE5HM2JaYitO?=
 =?utf-8?B?cGxoV1lDZlJWRTZWdk44TFBSekVEaXNwQWNTclpTaXY0TlZPeTduRDkzclph?=
 =?utf-8?B?S2IwQnREc0F4UExDemhPSGVKNG9ldWtLcFpZUjB5RW1XRVd4OGRJaGtPRlVx?=
 =?utf-8?B?NkJNcWFnVE9lTTV0bnhmbURNMTZqRm9YNlZGKzl1djAvaHAra1RaQnh2M2ww?=
 =?utf-8?B?blpkYUlqU2czZUVNL1ZNc0lDTHdRRnFFU0JYcE1BR3R3dEw5KzhJbWE4NTB5?=
 =?utf-8?B?dmh2dUtyZWlENDdYWklMZkpDSWY4OHhZRGNTME83QWJTTWpVRWlLUEdCVDN5?=
 =?utf-8?B?NG9jcmxxdXdsaXpnaUNCSW16MWNtamRBWjhZZzBKWTYrY2VrN2o4OU1hTWJm?=
 =?utf-8?B?b2JkN0xyV0FHdktYR1ZOaGRzMXp5cW4rM01RVkNXNG53SWVLSnUwSC9wWmtk?=
 =?utf-8?B?OXRxS25yc094OFlrVzY2VHJFTm15NnBYR25NenlxL29MdzV0eDRaUjRYb29J?=
 =?utf-8?B?djJsamg1VFdsOGRQUHo5QTdSRE1vUzRTaDQ0Y0Y5Z3JpdHRadW5qZnNQaVFW?=
 =?utf-8?B?NWh4djlmWHRRN2xwN3F5d1dQZitaNk53NnRoSXJNY29IbDhLS0EvMFdiZjBp?=
 =?utf-8?B?UGcxV1d4dzNxeXgwUmF1dW9HcjVROTJQQmFpVUFqWGdXTWdoWlBmczNJc00w?=
 =?utf-8?B?NjJWY0J2elZIblFoOCs1alRoTmd3YWlsYXYwV2Z1OHdxaXR2MEtFWHV6b3FV?=
 =?utf-8?B?djRPeUtQTHMyYkNnaGhrczIyMFIvbDI5VEt4bjRtSUFzRzl4enFMOE9ObU5m?=
 =?utf-8?B?YW1pWlZ2K25SWUlpSWdoSU4ra3VMQWlNVHI3aUhxQkZ2OU9MRFB3blRHMVVY?=
 =?utf-8?B?eUpmbnFiUm9sRWdWNDJMc05Ec3Qrb1FYa0NjcTRDcVVPOFY1UDcxaUxPeXVF?=
 =?utf-8?B?dVpyektkS3lJMmZIV0x0QWNSVWhhTGRZaG5hUFlxakFURHowQzVyRU8yZ2V3?=
 =?utf-8?B?U2tVN3J3Nm5qT2ZZT3IyTWxXMWFhM1hxSE53UXJpRWJ6dWpkcnRrNkNWRTZF?=
 =?utf-8?B?dWZYeHY2M3YvSDg0RU5zZFZvSEI1eFZhUGIvdXZDRUhLWmdRcmFGR2VscnBM?=
 =?utf-8?B?cHhPN1BmYmF2dHlIdERQaGZKSFQ1bTZJZmJHVEQ1UlFmK2JJZDZ4UytGUjly?=
 =?utf-8?B?dmYvNzVrL1NrSm1tUldaUVp4UjdjZ3dCZFlhcmVzbXVWZHZ2V1AvSXpRS3ZQ?=
 =?utf-8?B?cGpsK3dQMDVuWkN3K2x6VVhjSUJ0MEtKWmV5S3F3UDhwQW0zTkgyYWtNcHF6?=
 =?utf-8?B?cE5XclZkN1c5Qjgva3MwMlhqTDR6aTAwVUlyTWZxY1BRcFpTTnRsaUtRODNj?=
 =?utf-8?B?eVFXUzFUTDNob3pMTDRieHhCSE9mbDNCb3B6bG04bHBjQzZtcTdLWmR1Sk1F?=
 =?utf-8?B?YWhOOUkxUElBR3Q4L0JFUGVpQWx4eERJcEtvOWlXS3hBSEdSOGZFNERhNndP?=
 =?utf-8?B?T3FKcGRka3MyaHZJUmxXbUJGYjU1L3RySWhkSGhrSDV3R056YUErNVpJRUV2?=
 =?utf-8?B?S2pPTUl4MERsYWNPRTd5U3Z1VDBtUWVwWHhtSmRoMUI4ZVljVnNjRUgvU004?=
 =?utf-8?B?Mkt3TG56QzQyMHM1VkxySkwwcDZIUU9ZenNNcCtGNUNsYXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFJPY0xYVDlKWHM4ODh2SnhONWd3ZVc1YlRIeE1Rc1QydS9ZMC9RMTZnSjFt?=
 =?utf-8?B?VEN1bjFwayt6Qy9TUkJNblpkNWJTRmpqNHU3Njk1T2xGMkpzL2NBRysrZE1k?=
 =?utf-8?B?UGduV1MzQ24yaThiTVZBQ005Z3FraStsdlVCTUd2M0hCeGsxKzJZVkgxWjVJ?=
 =?utf-8?B?R3lZNzlsNURIRUVTeEIxWWlKQ0pNeXNSVGVkQ3hhNjFBbHg2Z0pLZzl2dEdo?=
 =?utf-8?B?K2R0MlZoNWR0K0ExUGo2dWxXM2V5U0d3UGRXN0JTMU1UYmV3SHo2anN6T2o1?=
 =?utf-8?B?NlIyYzUxTFQ5Y2RZRGZ0OURzRDBEaG5uM3FZU2hqRDhMRFZFdWhmTm5GWDRm?=
 =?utf-8?B?dUpPVk9ib2tQR1BtT0lnYVhkSVZ6c215citORU1IbDRzUnc1eWxiY29NeTkx?=
 =?utf-8?B?MlJJcC9UV0xpUWd0aFczazZUekNQd0s0RWk3MHRMMGt2R240WFR6a2wyYTRR?=
 =?utf-8?B?Ymg5NURKNHI2OE9vcXNqVGFrd0wxUm50QUpHc1JHZHNoWTVrQUJVaWZQcUtG?=
 =?utf-8?B?d2ZNUXN4LzdVOStNdXhvb0phZFo0RTlyTXAyVkdBaWhjdmRZcmhDUDE5QnZS?=
 =?utf-8?B?TjBQRjU0RTdDbEJKWk1VTEU0ZEFiV0pvbUV0OUNIekNtQWNOZ2lDeDgzdlhB?=
 =?utf-8?B?U3dZd0tDVDFyY1I4Uk1QSllkd1BuTjVpRVdTZFY4a1JMTHZRVk16TEs1NmtK?=
 =?utf-8?B?TjlrWVJSZkVLVzBKc2VpUVRPbVlZS0tkVWc3QWExZlhvaXJEOXVqcENLaTlW?=
 =?utf-8?B?cmVuS2lmVU1kZGRrMndIQXl1R0JObVNlRG50WXYxQmcxSnorUWJIOSs2TktJ?=
 =?utf-8?B?a1BNcFdHYm8rRlgyanR2djZubWtCRFgrbjFhOWlWWitSTmlhVjJMWjlhUStP?=
 =?utf-8?B?ZlI4bEIrVlYyV1hzODM1NkFtWCthRjNWQXpnZzE4OUd5UVNScTdscWw1TGVw?=
 =?utf-8?B?Ty9HMmh4VlNIQmo2RGhGc1RWb0k4WWdVUU82SGlKM2FOR1J5ZDFhRGdhUW92?=
 =?utf-8?B?bFFQRFBQbXhYRXY4N0FMUGlyUEJiMXlITmlKeGxVTU1xMEZDZUl0MWN6V1Vu?=
 =?utf-8?B?NHlpSVN6WE50azlwc2R6dG84ZEtJTWxzdHlVYTRwUWVDcDNYUmFMckJXNmIz?=
 =?utf-8?B?K2VuZGI5OGZEV29mTzdBb1ZrUmZFTlA2bFB3N25qZU80TERaeHBwcHphMGxs?=
 =?utf-8?B?QlVDZ0J2V1o0TWpIajNtdmhaWHAwYXlZcW00bGJBbGVzbDNpcERSUUhMTFA4?=
 =?utf-8?B?bWREek9rK2NkYUVYdzNSMTUraG5IL1BsbHZaSmo5Tyt5Qld0RXg1bEN3TnJu?=
 =?utf-8?B?bTM4YThrQUVENGRPaTBUNVlnRVRvN2ZDL2x6Tlg0K2Q1TUdUUmYxRDljdFJZ?=
 =?utf-8?B?aFU2WDJabThCdWE1MWp6SzRhWTNlMzVTWGVTRUdXajhrM0NnN01uWmRjRlZP?=
 =?utf-8?B?cUE2RGxVVS9VV1FMZVFFY3RVYTR4UjRYZWRZZ2RSeXoyMHQ2NnFOdExjZVh4?=
 =?utf-8?B?T2tJL0dteHJyTWR0UEVRdUZwaXdEeDhTVUNGekxSak9GWnplZnV0eSt3TnJS?=
 =?utf-8?B?WHZkR2hwb2VFNDl2RE9rNFkxWm9MbU5CbnJnc1k3MzF4RUo4TktXanFXVjBR?=
 =?utf-8?B?K0ZBTkR2cngwSjQ0eHdDWGdkVHhYWWxwc1lpWFFNSzBCS3R4N0Iwd0J2L0dq?=
 =?utf-8?B?L2wzUHZxK3g1bThTS0JyVFRGQXBuZkUvZy9NK0w2OWIxTmRYV1VnTm5aK1Zh?=
 =?utf-8?B?NnhvMmRlVmczNXdtTWF3RmthMFZYU0FiZmNneG05RWRMT01odG1CcDhPY1N2?=
 =?utf-8?B?R3BUc0M4N3RUMGk4KzE2cUdyaktrNFlqSCtrcGxMeU5XOEJTWlpnUGUwcWV2?=
 =?utf-8?B?ZVVNL2NuWFpRRkFJZlFnT1ZjNlR1ZnQyYTRCWVRtWHZHL3JMR3o1b1Bwemlk?=
 =?utf-8?B?cWN5R25MQkZtQ2U0K01OSlJ1TDVxVzNvaEpOV0lWYllZNitEZ2MxSmE0UWVX?=
 =?utf-8?B?YTR4ZWZROTZhYkdkZXZseEVrSmQwZUtZWDNXSDVYeitsdHhKbytWTU96MzlM?=
 =?utf-8?B?Nkl6aTdaUFZ5K3hrenpxQmdiS2xmWjVDVlFqdzZFZVJhNWZPd2ZtT0tKZW5t?=
 =?utf-8?B?b0xybU5uOHI0SW5YK1pqTXhONEpXemo5a0ZZUUdVNTh1ZXBaaG1Kd3FXbktN?=
 =?utf-8?Q?ea9BIEqng1/hCsjC+G2IC8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01E374FC5A8EF4A919F7F3789879F72@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48716e14-4873-444e-cab9-08dd60cd79c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 18:49:38.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ViE32KIhhMk6dmMOf00p0I2F3N9xFG+kbylb7DWONTva/kS8x5cV1smp7cW5DLLwMfmrWC5fwwsqLUTCVPse+RQeH2ahTwOr7dsI54PqcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8542

VGhhbmtzIFNpZGRoYXJ0aCBmb3IgcmV3b3JraW5nIHRoZSBwYXRjaCENCg0KT24gVHVlLCAyMDI1
LTAzLTExIGF0IDIxOjEyICswNTMwLCBTaWRkaGFydGggVmFkYXBhbGxpIHdyb3RlOg0KPiBGcm9t
OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+DQo+IA0KPiBSZWdpc3Rlcmlu
ZyB0aGUgaW50ZXJydXB0cyBmb3IgVFggb3IgUlggRE1BIENoYW5uZWxzIHByaW9yIHRvIHJlZ2lz
dGVyaW5nDQo+IHRoZWlyIHJlc3BlY3RpdmUgTkFQSSBjYWxsYmFja3MgY2FuIHJlc3VsdCBpbiBh
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4gVGhpcyBpcyBzZWVuIGluIHByYWN0aWNlIGFz
IGEgcmFuZG9tIG9jY3VycmVuY2Ugc2luY2UgaXQgZGVwZW5kcyBvbiB0aGUNCj4gcmFuZG9tbmVz
cyBhc3NvY2lhdGVkIHdpdGggdGhlIGdlbmVyYXRpb24gb2YgdHJhZmZpYyBieSBMaW51eCBhbmQg
dGhlDQo+IHJlY2VwdGlvbiBvZiB0cmFmZmljIGZyb20gdGhlIHdpcmUuDQo+IA0KPiBGaXhlczog
NjgxZWIyYmViM2VmICgibmV0OiBldGhlcm5ldDogdGk6IGFtNjUtY3BzdzogZW5zdXJlIHByb3Bl
ciBjaGFubmVsIGNsZWFudXAgaW4gZXJyb3IgcGF0aCIpDQo+IFNpZ25lZC1vZmYtYnk6IFZpZ25l
c2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBTaWRk
aGFydGggVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNp
ZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCg0KTEdUTSwNClJldmlld2Vk
LWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4N
Cg0KPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgfCAzMiArKysr
KysrKysrKysrLS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMTQgZGVsZXRpb25zKC0pDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==

