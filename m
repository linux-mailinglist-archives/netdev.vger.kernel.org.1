Return-Path: <netdev+bounces-135019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE999BDB6
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 04:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760911F21DF8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF3481B3;
	Mon, 14 Oct 2024 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="GNcq1jw5"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DA4436E;
	Mon, 14 Oct 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872628; cv=fail; b=LuPiedCsEHqOuKRqJv+Dvd31XbhMequhcl9Oa5dKZ5DQBZD/weoSFju0hWWLQ9ydLrBhguNBw/WAl8SL5X3AkGGooyWSkp5QfAZcUaZJGtudKq7tzWx8VPSmG49I/LErAXEE/6TrJdmdTMQXcgiUZTwXtxygx5v5hdWwRdwionA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872628; c=relaxed/simple;
	bh=kgXQ0INHVCzAInCB2T/y54xFKMePqnS1DLoaPVM+EfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOSM9A4sc8Sh0S2PerQNnke/eJxD5l5YJbKU5Ze6EUuA//x8jlLcjfdz6BC/OlslU6jUglw1LCQdgejk/A4awEdW3a+bQNMa4cXz8v2VEShEAD/Ghi1gFHvYpJnhsnUA3doUJy2IJjPJylQM0Y9HOrV6zKni+RAgZFH/dbJ3KUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=GNcq1jw5; arc=fail smtp.client-ip=40.107.117.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4alEE+5nMbXRqi3qOq/KfF3KjVdLYeFfkxWWey/Ty/UqyWXGTBrt/lfFiU6TIsLPn0vWhMFsSd8dmHjYH4ZG8xbeG3EV1qkNbZgOW+Pg9OdiqcyYp7nnXqgLGA2pk1DPOVt6fD4VFiR1W8upPITWcosVLY94eA8vl4xZPH1fU37g4Wq31pwXEhzJAp3BJRbQVg2oJqZHKo+duGG6vt0C2vtBqNFJu545Oj8BndL2CXNryK7rF2cG8PsY92TI24RuLxIGZB4OrV3cuHRfD+k9pEVkOLrdVz6Vw4iuZYPt0z0JIVtKCdFkbpbhMDI7dmYqmk0HewQVfaCwuhVqPI4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgXQ0INHVCzAInCB2T/y54xFKMePqnS1DLoaPVM+EfI=;
 b=hHsQWScjw6MQcin+Wq/+XdBjaArDHyEzOhT1zBsrhs9K+4YIYZP4GgZV8OUaqiSMvIngLX2qALA4SxVEZ4yTMj4ZY8XsaHXVN15rgB9OeDPm8elQKwx36Yohlo3eHfvpeJSH7EgsdveSelqTMKNMNfsnV/olrFO3ZVWP5UpmloXjHZeTVxaeEwbzcg7XoJs6Tm6nXU+ZfFtqPVLkn0PHo87M/7WXR74RXT+pBNrJ6B8paaInHr0kBlTT3jWSdGa1QNbBZbdD/1o+ZnwXJKKeMKWgkPdqQ9fxz7nu69ymZWptiGa0dFTTV6A2+GI/Muy0sfrk2BS9S+TjiwW+ToxERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgXQ0INHVCzAInCB2T/y54xFKMePqnS1DLoaPVM+EfI=;
 b=GNcq1jw55CtIMZvf95eKT44cl5j2ACDr7QfWE3464aviH9gj/+0a+vipduKQo7vmywpplD9TEvx5EzJxyFXANjRmJymoLdrz0tc2Psl9tjVEITfjdjDCGb6vEdZJMpddPcjU6QoIT+eRQrCmCgGxKAoIUm4ilgFTy29gvyQo1Cm3TL0lDh5jOsvNptgze9BkX4qQhztuhT67pJH/WWS37r+1bG2C8NUJm2RChvcTT5AKhxU4E70xNOBK6TTUa3oNlhbTkqxQGacLG7g5yIxRT3k3FE8eFtBJlL1/smsy6qCE9NaF/EkM9r6038pcxqxzhCfHr8kS7xNyxM7kAH14jg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15; Mon, 14 Oct
 2024 02:23:40 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 02:23:40 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldF0gbmV0OiBmdGdtYWMxMDA6IGNvcnJjZXQgdGhlIHBoeSBpbnRl?=
 =?big5?Q?rface_of_NC-SI_mode?=
Thread-Topic: [net] net: ftgmac100: corrcet the phy interface of NC-SI mode
Thread-Index: AQHbG7eQONqwK4T4WkGdCTOORUz5ILKDccqAgAITzlA=
Date: Mon, 14 Oct 2024 02:23:40 +0000
Message-ID:
 <SEYPR06MB51349C634A15F932ED0ECF4F9D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241011082827.2205979-1-jacky_chou@aspeedtech.com>
 <e22bf47d-db22-4659-8246-619aafe1ba43@lunn.ch>
In-Reply-To: <e22bf47d-db22-4659-8246-619aafe1ba43@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB5119:EE_
x-ms-office365-filtering-correlation-id: 434dad9c-0b26-43cd-a0c5-08dcebf737b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?MDRYN0hpQmdDaEgxei91anZ2bWZzVUxlMFdxRkJCcUpHMS9nTTFYLy9hSm04eERt?=
 =?big5?B?Kzc0YTlBWnhKRmV0cWZDQ09zN1BpaC9NZzlhN0E4bDJCMmxQQkRxZGorQ3ZVdHZX?=
 =?big5?B?M1Fld2RaeXF2T28xZXhteDVHZklSUmpwdXZ1UW0rQ0UvbzNaZXFoSzJjOVIwMzUr?=
 =?big5?B?TFE2VE5KU0xza3lRZXBpMkY2QWlmYWFpb1hwSmpuNXZqcXZXMElncWxpMWdkWDMr?=
 =?big5?B?bDY5dnQzOThaWm1mbjBOZWNGVXhMQzdkZnVuSnVvZDhLNWR3ZURESzNFcVRaS0px?=
 =?big5?B?ZlErYUgzOU03NWJGY0tUUXFWVE9tVHoyRWR6WHp0TG53QUxsZ2JlSEJEdm9xT1E5?=
 =?big5?B?VzhpOW1LMGp4S2ltSmcwYk5CUDN1V29PclpNMUhaWFAzMFdRenNEbXRjTGdoR1JL?=
 =?big5?B?cGRsaU5JdzN0VnllTVpRaVFBeGgrS3JWemR3U3JqV21BN3MvOVl4NVV1aU45VldH?=
 =?big5?B?d3ExR2lEeDc1UTRZQjB5NVFhR0xPb3lGb3owaVRHbnpVM01oc3IyQnpyaTQvTVpp?=
 =?big5?B?c1IwRXFCei9TR2k3aEU5M1BQUEpFY0ZwVE5iRkgxZ2M5YnFkV014aHJudE1ObGMx?=
 =?big5?B?ZUs3cWtUaEZPQkpNTjBMZ0VPUW8vcm9SeE05SXlld2RTdTdGenQ1a0ZabnIwUVln?=
 =?big5?B?ZDBhRGZPcTJLeXc4enBaQXlCTHp0ak9VRFZHWDhKRlZScmphNjJ0THV2QjFQQlMr?=
 =?big5?B?RENHdHQvQWJsbXdvT1Y5OGFKVDNiYWcyVDBvUXI5MFFoL3diMzg4Wit1RnN1bS9x?=
 =?big5?B?VGdxS3doZ1Z6T2RHRlgzQjB2Mm9rNFlCaERJelVGME5LekxoYWRjbzJkQzJrcGFq?=
 =?big5?B?QTJZZUhjckw4Y05xaEtXRUpZRi9sS0RqSFVlUFNOUDhsbjZvYW9jUjZLeVJvTFlR?=
 =?big5?B?VlZnbTBpbElYV3Q5ZkVuOUh2UW1vL0VrZWFOcFhIMW4yMkNWam9SRExiMHo0cTZ6?=
 =?big5?B?UDduWituRGpwTjlScFk1T1pLU2ZCRzkxajFtY0RBbmRQa2lNYWdIQ0NzUnpLSFVD?=
 =?big5?B?NE5UVmhERk9lMUM1UDI4L3JZa0cvSGNPVHRKT3BjbTY4TnBaeklwUjZIdURZTmd6?=
 =?big5?B?VU1IUWJPdkNyMXdlTkJPN3RadFNETW1WbHd3ZGl0MWVIRUZLNnVZZklmR2ZKYk04?=
 =?big5?B?NVFhejFKZVNaQU45Mkh0WnVxTEJnVU5pUEkybE9uUzIzSVh4ZkVxUUxYR2puekhr?=
 =?big5?B?N2U3T1crVlVLaWM0TFBDQkR4V05zeGtQRWE5NkJJSFRJWVZJbEk0dThGak1HVUs2?=
 =?big5?B?RlJ1NGg5S1dUY1RKVFRoV0tUZ0EybS9raW9uSGFNOXNRT0xrUHE1UEt2YXpuZ1h3?=
 =?big5?B?UXRlWTNNNmJpSENkSU5UMmRpS2JUQnhXOW5hTmFXUVNFNWh4MWp5MzVmUHNHK3pP?=
 =?big5?B?QmdCcWg1SEN5WnlCdzRoN01iSzJCd3JyR1lDd2FPSHBBc0xBSGUzMjFOWnJuQ3Nm?=
 =?big5?B?em9uMnlFZVRWdWpRWlJpa2ZpbHNrSG5KOU9wSGZVQVF5SHpjWmFjZVZ3dm1hT3dF?=
 =?big5?B?R0dzbU8zbXFVeTY1d284WVZqd0JwdlFGYkNCRy8vampxR0hJcktxZURhTnhTcGZZ?=
 =?big5?B?T2REYXVQUDJkamN6SmdXdEVzT3RnSFlUNEJFZ2JhZDRGVWdoT3NCWWFiVWVNWTNC?=
 =?big5?B?VzhMeitSWm16TDBuK093bkxPOXVKb2JpZzA1RC9PbEp6Y3N1eFpvUVNZaEtBQVly?=
 =?big5?B?OWVJeHo4T0dId0pKQ05zZk1EUDg4QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?QTl1dG1Nd3luSGlJeGFlZVg3Y3ZxazJRV2JLVnFUYkxhd2tIcWFsNVUyVnh3OHhD?=
 =?big5?B?UEVrSHNCb1JWOW9sN1Y3SzhuM01WSHB2TkdYVzlnbUdJUmI5dDB4MEZJaXVCS3pG?=
 =?big5?B?S2pPSzBwZGVKR1RMcitMMUZmNzNnd0F2RVhjclFiL3ZzN3FPRGp2RW0rZ2hUbktn?=
 =?big5?B?T0NIdDE0MHliZGYwOEU2WDFwMmlNZWliUmM1RkhxMy9zMmJFMWE3N3l0d2g3Snhp?=
 =?big5?B?MHdRZ2dQRDRCOXN3TWdFQ2xZamNKSTVWcUNla1ZRNDBKaG02Zm9wZkZCTFpRM2pM?=
 =?big5?B?aFdyUWd6bElodnZWNkRtbHowRytRdG5lRnRtU0F4b01HSm9VellvTytIU2ZKNEgy?=
 =?big5?B?dFQ1VElVL3dKZFhxMW80ZFd4UkJiY3dyc1owSmZqMjd6NHF4dk5PTmZzOWw4MENp?=
 =?big5?B?eUd6M1FrZytNa1VsMG1qUzc2eWp1VDRLa0NBSjQreXdONWpXYUtyRnJJY0ZGL2JP?=
 =?big5?B?RUVnVklHNUpUc3pBekJ0Qkd3dUlXZEZ5SXlyKzRUNG5jZG5tUFA2OXhTZU0zVHhB?=
 =?big5?B?MjBxeVVEaW45ZmthdVEzY3lTYU1Ud2ZCd1RDdVFERDRRcTl5dlI4eVljWHdlRURM?=
 =?big5?B?QnhLSXdQQ2dCL1VnN3dEK3E4SW1aWHFHT2MyeGo2b0hiZmdTR3NHb053b3NTT1Y5?=
 =?big5?B?QWphQXZGZG1md21oYmJjSnFpRFUxSEJQQ0JHencvVkZ2SkV5ZWNOSyt5UzVLNmFX?=
 =?big5?B?cVFlVGsrMnh2UUhHdE5vZUJnN0xXTEVkamZYcEd4NFFNbk1jTG9HNTdQZ3JDOTI4?=
 =?big5?B?dVhWNGlnSjAwZjdHb0FoekJUSm5xdE16RUwrRk5SejhuS3cwOTZFWjFzVjBjdnUx?=
 =?big5?B?Y01OTytPb09xbzBwemRhSVI1UGZVNGtla3RDSnpYaTRqZlNtREh5Z2UxUklWK2lS?=
 =?big5?B?eWtpK3lIMDNQazg4WE1Td0Q3QkZHL0M3YWN0cTE0TDArTkx6cW9SZnl5TEQwakpF?=
 =?big5?B?UVh3aUVUTjdyc2NjTVRvMk51UGRuMlJTdzBIMFF0NDNiZ2RnZmJtemttVVJnZWt4?=
 =?big5?B?OTNibGZkdE9oOU8rb05YZFpFVnVjSmhOOVBZd0VKTTI2OHNqeXBocVRpbVk5eWxV?=
 =?big5?B?ZEU5a1FjclplZEpNYWpUZWUyZnAzRXlYSWdKcUZ3WE9MeFZpdzl2bEtNV2FSZVVU?=
 =?big5?B?WlFiTDdvcjFtM09sVHpMUzgwNFluelJGclhIRklLZXBLRHc4S0RxLzRZZVpybzNz?=
 =?big5?B?c2VwMUdzck5vdEpnT3RENGtkT3g4TnJBNXFUTE9kdE16MFdsejZYeWtQZmw2Sm9y?=
 =?big5?B?VmJtbndzd3Y5MDBmd3drRW9Da0IwcW5NNmJsR3FFZ3FNQnZrSFVBZVdjR1g0SFRW?=
 =?big5?B?cU1Za0Fzb2RLTm94M3JwZ1htcFgxdjJLdzlaK0Q5N0NHSVJTOWxTbVBlZTd0S1JI?=
 =?big5?B?aVVNQUFDK2VrUkNnM3JqMWVhaWdqUWtTajQxcWlCOWNsTmpHeUlPUy9VUzlWRHFk?=
 =?big5?B?OUZESDZybnVYMEZuam11NDc4TFhSMnluSFBhTlk1V0tIbWRiRWNGc0pUMU1XcHl3?=
 =?big5?B?OWlVeDhpekxOdHRrN3B5dkJOS3loTU84alNldWExSmVyaXZDdUFYM3d0M1I0WXFO?=
 =?big5?B?Q0o1bWJXM1ZpbEYxYjh3dkVSNm9VRmxuNmg0YmRBc1ZVWTFlZ0ZhalRsSVV2UE9O?=
 =?big5?B?MG9FQjZNRHhTRC82ZjA0UElzd3BDMW1KTStZUGtPa2ZYMHF4a3hUcGJGQmNLTFQ5?=
 =?big5?B?bVc4T0pMR0ZqY2htYS9zZ2JiS2xHTiswTUpmY3U4Vm9mOGFWNEZRVXNRc1ZGcVZk?=
 =?big5?B?cXBudUp2SSs2c2NLbzE0RW5IYmxnNkNWUzJJdHRtaDNHSUg1OUxnNDA2VE9CY3JS?=
 =?big5?B?OHBvWHB1eFJ3ZkhyYVMxSTYvVC82RDJRNkN0OXZCb25JbHExOHhSVTVpNDhCd1VZ?=
 =?big5?B?SXZIVmJORmFBVDJnSmY3SW1wVDlRRHp2VFRSc0FLOXdMY2VTTThNbzRFMW1kNnJQ?=
 =?big5?B?cmg5dUhscFdpZUJjVHFSRXB6Rm9YcGJxVXJzMW15cmpmUXd3bnlyeWZjTmFydmRN?=
 =?big5?Q?yXDuYVK5Cna5O73K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 434dad9c-0b26-43cd-a0c5-08dcebf737b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 02:23:40.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey4Wex+Stk4F/GtANwhGLmtsX8neLvqKeYglHe6VCfnDMmV4xsOQ6LKG+gvW2Cr3oQpm1PzkwR+YkqaJt/Maf/u4rkQFE3kxOHXexHLdgzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gPiBJbiBOQy1TSSBzcGVj
aWZpY2F0aW9uLCBOQy1TSSBpcyB1c2luZyBSTUlJLCBub3QgTUlJLg0KPiA+DQo+ID4gRml4ZXM6
IGUyNGE2Yzg3NDYwMSAoIm5ldDogZnRnbWFjMTAwOiBHZXQgbGluayBzcGVlZCBhbmQgZHVwbGV4
IGZvcg0KPiA+IE5DLVNJIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYWNreSBDaG91IDxqYWNreV9j
aG91QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9m
YXJhZGF5L2Z0Z21hYzEwMC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
YXJhZGF5L2Z0Z21hYzEwMC5jDQo+ID4gaW5kZXggYWUwMjM1YTdhNzRlLi44NWZlYTEzYjI4Nzkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMNCj4g
PiBAQCAtMTkxMyw3ICsxOTEzLDcgQEAgc3RhdGljIGludCBmdGdtYWMxMDBfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgCQkJZ290byBlcnJfcGh5X2Nvbm5lY3Q7
DQo+ID4gIAkJfQ0KPiA+ICAJCWVyciA9IHBoeV9jb25uZWN0X2RpcmVjdChuZXRkZXYsIHBoeWRl
diwgZnRnbWFjMTAwX2FkanVzdF9saW5rLA0KPiA+IC0JCQkJCSBQSFlfSU5URVJGQUNFX01PREVf
TUlJKTsNCj4gPiArCQkJCQkgUEhZX0lOVEVSRkFDRV9NT0RFX1JNSUkpOw0KPiA+ICAJCWlmIChl
cnIpIHsNCj4gPiAgCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ29ubmVjdGluZyBQSFkgZmFpbGVk
XG4iKTsNCj4gPiAgCQkJZ290byBlcnJfcGh5X2Nvbm5lY3Q7DQo+IA0KPiBJJ20gYSBidXQgY29u
ZnVzZWQgaGVyZS4gUGxlYXNlIGNvdWxkIHlvdSBleHBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlLiBX
aGVuIGkNCj4gbG9vayBhdCB0aGUgY29kZToNCj4gDQo+IAkJcGh5ZGV2ID0gZml4ZWRfcGh5X3Jl
Z2lzdGVyKFBIWV9QT0xMLCAmbmNzaV9waHlfc3RhdHVzLCBOVUxMKTsNCj4gCQllcnIgPSBwaHlf
Y29ubmVjdF9kaXJlY3QobmV0ZGV2LCBwaHlkZXYsIGZ0Z21hYzEwMF9hZGp1c3RfbGluaywNCj4g
CQkJCQkgUEhZX0lOVEVSRkFDRV9NT0RFX01JSSk7DQo+IAkJaWYgKGVycikgew0KPiAJCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJDb25uZWN0aW5nIFBIWSBmYWlsZWRcbiIpOw0KPiAJCQlnb3RvIGVy
cl9waHlfY29ubmVjdDsNCj4gCQl9DQo+IA0KPiBUaGUgcGh5IGJlaW5nIGNvbm5lY3RlZCB0byBp
cyBhIGZpeGVkIFBIWS4gU28gdGhlIGludGVyZmFjZSBtb2RlIHNob3VsZCBub3QNCj4gbWF0dGVy
LCBhdCBsZWFzdCB0byB0aGUgUEhZLCBzaW5jZSB0aGVyZSBpcyBubyBwaHlzaWNhbCBQSFkuIERv
ZXMgdGhlIE1BQyBkcml2ZXINCj4gZ2V0IHRoaXMgdmFsdWUgcmV0dXJuZWQgdG8gaXQsIGUuZy4g
YXMgcGFydCBvZiBmdGdtYWMxMDBfYWRqdXN0X2xpbmssIGFuZCB0aGUNCj4gTUFDIHRoZW4gY29u
ZmlndXJlcyBpdHNlbGYgaW50byB0aGUgd3JvbmcgaW50ZXJmYWNlIG1vZGU/DQo+IA0KPiBGb3Ig
YSBwYXRjaCB3aXRoIGEgRml4ZXM6IGl0IGlzIGdvb2QgdG8gZGVzY3JpYmUgdGhlIHByb2JsZW0g
dGhlIHVzZXIgc2Vlcy4NCg0KQWx0aG91Z2ggaXQgaXMgY29ubmVjdGVkIHRvIGEgZml4ZWQgUEhZ
IGFuZCBkbyBub3QgY2FyZSB3aGF0IGludGVyZmFjZSBtb2RlIGlzLCANCnRoZSBkcml2ZXIgc3Rp
bGwgY29uZmlndXJlcyB0aGUgY29ycmVjdCBpbnRlcmZhY2UuDQoNCkluIHRoZSBmdGdtYWMxMDAg
ZHJpdmVyLCB0aGUgTUFDIGRyaXZlciBkb2VzIG5vdCBhY3R1YWxseSBuZWVkIHRvIGtub3cgdGhl
IGludGVyZmFjZSBtb2RlIA0KY29ubmVjdGluZyB0aGUgTUFDIGFuZCBQSFkuDQpUaGUgZHJpdmVy
IGp1c3QgbmVlZHMgdG8gZ2V0IHNvbWUgaW5mb3JtYXRpb24gZnJvbSB0aGUgUEhZLCBsaWtlIHNw
ZWVkLCBkdXBsZXggYW5kIHNvIG9uLCB0byANCmNvbmZpZ3VyZSB0aGUgTUFDLg0KDQpQZXJoYXBz
IGl0IGlzIG5vdCBtYXR0ZXIgb24gUEhZIGludGVyZmFjZSB0byBNQUMsIGl0IHNob3VsZCBjb3Jy
ZWN0IHRvIHRoZSBjb3JyZWN0IGludGVyZmFjZSBtb2RlIA0KZm9yIGNvZGUuDQoNCkphY2t5DQo=

