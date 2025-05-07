Return-Path: <netdev+bounces-188540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37525AAD448
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D71B67D11
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D251C84CB;
	Wed,  7 May 2025 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IbBiwoP4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD651C84CF;
	Wed,  7 May 2025 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590318; cv=fail; b=Th10H1U97LtM0zPli+5qP92TW6yE/t6DjNFFf+KYfSZgqUF0eLa/ewr/FhZWsPFaL1q7veHERfNi+3mbBY/TbaOhEhVHcCfKq1wwhtFeUP+ggl1JyAZfC8Ulzlrnm4h+w9gYCxppfQcO6An5yyFYdaUzTrH4/zUTPj/U+K4Zvpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590318; c=relaxed/simple;
	bh=ewj7mJk9REb/NYhF1KmUjLZVh7Wsh1acmuXsJoWPFuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+HbIiDVf5A6d6dVz23rtYsHMuUjO9D7IUu+A1VUBw4EWU+1HvCxkNwbJDTiIlwVGO0Pse13alJq0j/aKX9jdhPYipxSjFvqlFeTgAKZRlMmAPCRmtOL9aPZPLQSfq1GpAmIkGldjtqJ2sKJjI85c5eNzBzDClZJVETcRWkCQqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IbBiwoP4; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnJ9Ub0xYh+1wDl5/5miX1RAVz6JH/hl5iYRboiJKKvMR5tbWJAKEukJ7mAkaEtOl3wUmyPwYvYRNyeoXybS2Ynd8K472SuMK+lPjyISLnczBa5KxiFqO9MyylmL2YLEZRtrR0tRdF0BFOGWFASzMOEnlF6iF9dSJed2CjxMbIGdxGf0XtEOzr8mbKZv2RWNpLQKIkV8z/6jPdmu/5A/oIvACLRMzfhW+MkMJJeC7YuCAO1uItXUHLmMhmGQMKscTC3rQjR5HqbFcWLk0vMGkA4HyvK/HdFrAQfkKaOXLgfpdR3CQg3ewCQ9FUlUaJTwcrsDlY7eiw2qwDWmDJ3aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewj7mJk9REb/NYhF1KmUjLZVh7Wsh1acmuXsJoWPFuk=;
 b=hqawJofGWUCQ6DaiAXmNk054D5cbBEUEidt66B0Vg20G3NJveMb22BgoHPl/9Zdu740G88Xv+Vw2xMeidXiUx/tHSTC5S1y8l9zbvclqCM6zIkgGCuKnB84H5YmjJZMqCmj7lcG4HK5NAu7wxVhSZEtbF0aF8AMET7EfYElajcpaRGJ48O8m+emd976Zg6zfb4sg289dfefYayiNHWL4j43wGQE/R0KYjJXUBTsbDX5Hy1y2BRkpvLr+xR236fYk2x8zRuX9mXmUzVP+OYrydSjnGH0HgQDhSLzlu9UHBUNn7d62x221HVkIdIJqgTjvvugt/qdY6/pLTnTWlRDKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewj7mJk9REb/NYhF1KmUjLZVh7Wsh1acmuXsJoWPFuk=;
 b=IbBiwoP4rDJjNAPaoIdaLLYEMyWt5KBV5QqVSL81BCSPMhm3hUwhi//UUohroOm7XBKLep0JU9jBFWD5sCShgGsOabZyPv+uGtJvUwrJ9Ya6/UHdPwV+EoVeZpMOfUaB4/z51vBZklRtGYnb7ZuhdrrbQOGPY0QkzZv/aHpQGz8T6rUxppy8o0gUqgCe9ICxQP6b4UDiPWHK4/48emWOp9P0toAdFCEg/LOVDjY+B5a3FBXWiJawnNcyLK64SSYSivG/8emIy/7CmRW9lOXez4qXfAy0uF/3pTd/KiMElF/DjaeyTJ4xNkKlDapaIEp36ZpBGNosYLoQ8jj86b72Ug==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 03:58:31 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Wed, 7 May 2025
 03:58:31 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to
 separate detection and MAC configuration
Thread-Topic: [PATCH net-next v8 3/7] net: usb: lan78xx: refactor PHY init to
 separate detection and MAC configuration
Thread-Index: AQHbvkeQLlq0s7i89km9ljrxl5kPpLPGivkA
Date: Wed, 7 May 2025 03:58:30 +0000
Message-ID: <2935e3d6a325dccc9de6955c5e5eba18cfaff401.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-4-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS4PPF0BAC23327:EE_
x-ms-office365-filtering-correlation-id: b3b83c78-2db4-49d2-b55e-08dd8d1b6e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckh3dm5PZzhxMTBHMXpyeEZWc3JncjRod3R0YUFDeVYzbzF0clNYZEpUOG1l?=
 =?utf-8?B?Q2NIdjJuT0h1c1lXMVpZOUNZd2pFNVN3RXBzQWVKdW00QWQxOTByTXh1cG4z?=
 =?utf-8?B?aTA2R2RhTzduZDltQ3JjUWcwbytNYUMwV29JN3d5bVY2eDVmRzBvUTdES1c3?=
 =?utf-8?B?QkE0dS9NRlNjYTJ3QWd6SDliWFNVbUdlL1NwUDkxYUt5MTdjUk5odW9qSklI?=
 =?utf-8?B?dTZCamV6THgrT3B2Zld3bElyOVpNbkFkMmM1a2N6ejk2a1E4VUp2ZVQxVjkr?=
 =?utf-8?B?bFBpSll5bzFxRndIWllBSmtsTmwyVlN0cG5jaW9xSGtSTWYzN0lDdGo2N09S?=
 =?utf-8?B?NEVjb3pQY2wvUTJ1VzBCMUx6d2NnTkhFSnB0aHlqNEVUdUh6SkIxMVdyRGNF?=
 =?utf-8?B?SW5XM1IxOFpha2VpdUFMbjlBZTVZVjNHM1VoQ25tc0U1dUp2Y0Z6aVJuVHE4?=
 =?utf-8?B?RGcxNERSV2xJM3hibmZrY2JpalFzdFdjVWp5eTRwL2J0SGFFVkhGdHNoR1U2?=
 =?utf-8?B?bWFkMC81RW9RRTFJenpyRzliNmxkbGpjckZmejZrVkJiM1QySTBlTTZ6bGE3?=
 =?utf-8?B?R05KWXlUTjZnbmQ4VHNodU9CRHcwN3lyQ3c0NjlDdkRzR0JLLzM5RGFsdTla?=
 =?utf-8?B?SGNnZGtmYWJZd1k4VXZmclN0bndidDdRU1BYaFo1a2NXVk5lZ21ZcnNaZkZ0?=
 =?utf-8?B?Q1JWOUFERWxBL3R4UmdPZmE5TWtnQzQ0UzBNdkhGTFJBcjVzVXlUdlhzdWNS?=
 =?utf-8?B?aFN3M0twdUtlN0tFdHZTMGhlWWYzb3NVWGVkLzVVRzB0SzFWOHpOcW16Umoz?=
 =?utf-8?B?U05KcGVxQlpJNGIrTDZsN2E1V1JkdjZwWXlPMER2N1ZYRE5zWkVWVWhqQkxr?=
 =?utf-8?B?Myt0WVlyR293azhac0F0RHJFMC80RHRXSTNxWi93ZW1WUDBuQ0pWenJ6eGNk?=
 =?utf-8?B?ZzQxZVZhNVVoZC9MM1hmTXpyTlRvTmZQTVBDWGQyUC9CcmZQQmp2MWFKb2Zt?=
 =?utf-8?B?bEhPSFlpMitjTnoxRTZVazdZNFltSzdmeWJydmROZG5VRUZzaVNVaklnVEJ6?=
 =?utf-8?B?RVQza1NpbDJ2WmRKQXhTVmZOcWVnUEpQWFUyM0JtTy81bHpTZ1kvY1pQSEYw?=
 =?utf-8?B?NHRzQWhxd2tmWFo0ZyswdU5UdGc4YWxjdjZGWlZNWWl0clRraTV6TkRJalJR?=
 =?utf-8?B?Q0tMakdZZmQ3R1RBMG5wNlVaaWlrQmtmVEdYSUhFNGVMdXBMb253ZUNDaG5t?=
 =?utf-8?B?aHFxVG5wbmhKYjdUUVhNMUdxZytrQ2FiOXA0dzMvb2MrLzkrK1RpemlZSHg4?=
 =?utf-8?B?K2RjYm9hYzlNK3BJWnJGNVhHdjNuQzFzbllmQ0hNb3JRaHFxbVFYcHBGTmJn?=
 =?utf-8?B?L3Z0b25WKy9TMFVOa1E2MVo1T0lGcmdITStqQ1JlZmZlams2KzhTcjlYOXVS?=
 =?utf-8?B?Z3hpS09ybUtoRHRrbzRiSk9RYUNzSm1zV1QvTk1ncFJ1c3Yyck5XNlk4QkhZ?=
 =?utf-8?B?TkJmbW82NXlsUVdhdWFlSlNpWlZrTTRkR0MxcVFET21QVjJ5VEJUZ0RlTzNa?=
 =?utf-8?B?VSt3eGx2YVRzQWx5eXdJTFBqUnRMZzViV0dDU1dWYWtjcWRrczhWWW13cnJ2?=
 =?utf-8?B?QlhLS29jZGYyR3Y0T0VxK2tZY09lVjZ2SytiQmV6eWJFUkJuU0g1bDkxMEE1?=
 =?utf-8?B?RFdvanE2NGhaY3VveXB4RzJpVW1QRDBhb1NyWngvcDFsNnkvMEZDSmYvSEcr?=
 =?utf-8?B?NmRFK1VCc0R5cW1Xc2VnYkNGS1FCTGNMeUdRUWxxOVJpSmFoRnlaTXI2cHJN?=
 =?utf-8?B?eDNwd3lqQ0lDaytOaTg4a0ZHdldxekJMbGVtM0hpZm1SQ1JUL1RvZFp5elVK?=
 =?utf-8?B?cXlVUkpvZk9wdXFvUWQxem5VaThxb2dscjg4Rm9MYjRaL0piVnFKclRPcVlr?=
 =?utf-8?B?bW5rSGp2NGJRS0lzVGZjRk9zaXVWZ21qWjU5UjFlYlU1VnNLUUxDSFhUREUr?=
 =?utf-8?Q?I8b3NsISS18nHyfVzfsS9DesL982NM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clBLMTZVL2pKc25Cd2IwclBUUyt0WDZtcVhob3p5WXFKZGROWEVGMkdCY1Jz?=
 =?utf-8?B?U0l5a0lJL3JiSER4Nlg5UU53RXh0dksrdjY5dENWZHpYcGpVd05RaGo3R3hJ?=
 =?utf-8?B?VTJkVFhrK0p0NnpBMS9GTXVsUmNxZk0rVXQ4ZnpSQms4R2hUaHpUeDNjZ2dm?=
 =?utf-8?B?NTdGbGN2UzlrRDhVT0wvaGgwSm9BMHBubkVWTDVhRXl1bVc3RkFHaldNeHNo?=
 =?utf-8?B?YmFNYmhZNmE3MEY3RXQzSkREbkY0YWE2dnA1S0JtNVlCUXlGM01abFhFL3Uw?=
 =?utf-8?B?RHVJdzJCcEhHMHhselBlaXV0Y0FyRVJDaW9MOVRVd2s4RWN2c3hjNnlYRG1u?=
 =?utf-8?B?TFY1dXFiSWJmdTFFUGRNM2FVYXpJSTZaY282VEJiN3lLeTBjYS96KzJLL05r?=
 =?utf-8?B?eXZ6RjI0bkhnTy9qNnBDSG9sZy9wdklndVBMc0tLdFFrMkhBVnRtNVcwR0du?=
 =?utf-8?B?TmptUytMOWhUR2tUUFgzMlQ1dUo2QVJqcDBsTG5pZ3hla1o0MmV5Wk0rZ2Ri?=
 =?utf-8?B?dEgyUE8vVzRVQnZjYmtZQTI4RGJaWHB4Wm5zR3pSVmdIdHF5YkFSak9tWVM1?=
 =?utf-8?B?ZVF5ZjJSUnBrN2Q2RnpvREQ2aEFyNWZTOXU2dTRoUFN3dDk1UlZmSXV2WTdi?=
 =?utf-8?B?eFhNSlFvVDAyYkNYMWNKSTNSV3pSRVVkaDhBSU00Tkt4a0pNcEFNNjVYSGhV?=
 =?utf-8?B?Z1VwUGZNVDhNSzF3Q0l3cGRPdXU0SnA2QllERkVpbDZIWU1nRHVpT0UrcUhN?=
 =?utf-8?B?SWViS1g1QXNvOG96ZnVzbVZKM3h2LzdtYTRJK0pzb1ZpK2pDNmxiRWw2YVdt?=
 =?utf-8?B?bG9oeDJudGRhWmtTTFE2cjhBTFQyZlk1N1FUWTBxVll3akNFR1BjdFFUT2gv?=
 =?utf-8?B?dy8yS2VlWmxxdEJFVUtScFJFSFN6K3JvZHFoUHFNams2ZE5NbGpxWHgyYjBj?=
 =?utf-8?B?bXBBdkRlL2JQWE04UHpFU3dmS0lpN2FVOHpIKzJJVHB0c3dNNEZhNWtjcG93?=
 =?utf-8?B?NTl0KzI2NEVuSnQvanQxNTF6RFBkcGJJTUZFMUJoRkZ6NERZdkFPcFovb0J5?=
 =?utf-8?B?OTNaQVo3TDczR1hRc05QYk5WdDJabzNrV0RmTk9VNlN3RVlPYTJ3UnhDaFJi?=
 =?utf-8?B?OXhnSGJLWjJVTkJYb0VQQzlnd2J1eHFLK1l6NjgxZHh4MFhseTFnS0NrdEVm?=
 =?utf-8?B?cW9USElERUo3SU5xdEk4UDQ5V1o4RzBUMzhVWld1c0xzcDBYak1kdEt1SEw2?=
 =?utf-8?B?ZEhtRlNsa1lOUnFjeGU0WDh4czRzODMyZUpSTzg3dnVaejVHWTFvUHYva2tu?=
 =?utf-8?B?RXFlUFFheHEvelZzNFFEWkJiUTdBQ28zZENCN1VZZWdNa1Y4MEkrWlZRaWNB?=
 =?utf-8?B?UEJPWWhQQUtMWnRTdHRUR2JNMUJ5TGdEbkh3NDlQektyV3RlaWxtTnRZSFhw?=
 =?utf-8?B?MExoVzlZNm0vZGgzdGdGTjBRQnlHZFBIWU53eHQ2SkdJd1ZxMTZjZlFuVU5P?=
 =?utf-8?B?dFFud1hSUkx3eFoxZ0NsME5RRUtmMWk0MFJBbkY4cWNPeHBZdGxZOUdkaFdX?=
 =?utf-8?B?a0I4emlOUldkeFFDUlZWU09ranpORDZSbEpsY0M3QlB5TjVjM2VZNHF6TzVY?=
 =?utf-8?B?U3I3Q3B0ZmM4NCtKYlNtdnFCVUxMdEx0ODdwVC9GRmtXaThmbTgySHhpMWdu?=
 =?utf-8?B?RzFjRHdjbERxNTBSUnAxdzVFTzB0b3BxVlFRSmpTWnI3SUd1eVphR0l1RXh2?=
 =?utf-8?B?M1hudzNObEl3SndzQVFJUUF2WHdVbit0WmIwUVVWTjgxN0JZNEIyREg1Nm10?=
 =?utf-8?B?QjBxZ0Rob0p2alFFVDkzb3IycERaZnBMWTZOd0dEbk8wck9wWmpRR0lCWjF0?=
 =?utf-8?B?bkcrRVNNb1k3QWRJbTNQTUlSRGc2a2prQUlyQzg5MEtqL1pOZ3d4VlRsZlVG?=
 =?utf-8?B?VkkzeEk4SnQ3TU9seXFrNTkxeUJKQWV6T2tIYkZDcUs2R2hCNmppTFBLLzk1?=
 =?utf-8?B?M3hXSnRrclBjQ2JNTUEyYnpQUDh0YTJBTjlTSytIUmMySE50QVFOUU9mUFgy?=
 =?utf-8?B?OE5KZFhYODRmNDlwM1A3clRGZlhOYjg0dWp1Njl4Z3VBSndBTlFVMGxWdnB1?=
 =?utf-8?B?RjFtaUp4UlJPTWtudCtoYkU0dHk4YlVpVW1wKzRsNjFPVGEzS0NkTGJlNlg2?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50024E420AAC524E94BA1A3AE3A3E282@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b83c78-2db4-49d2-b55e-08dd8d1b6e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:58:30.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JycYbTQPgicyhyzpiZgXSDnMYv15LVxKc+lNYEnmMpS6eD5yPM4sJHxfYnhql1kzREVz5pcYemHsXwgQvDUaulYl8MeBfjebe7IrXNkk7t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDEwOjQzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTcGxpdCBvdXQg
UEhZIGRldGVjdGlvbiBpbnRvIGxhbjc4eHhfZ2V0X3BoeSgpIGFuZCBNQUMtc2lkZSBzZXR1cA0K
PiBpbnRvDQo+IGxhbjc4eHhfbWFjX3ByZXBhcmVfZm9yX3BoeSgpLCBtYWtpbmcgdGhlIG1haW4g
bGFuNzh4eF9waHlfaW5pdCgpDQo+IGNsZWFuZXINCj4gYW5kIGVhc2llciB0byBmb2xsb3cuDQo+
IA0KPiBUaGlzIGltcHJvdmVzIHNlcGFyYXRpb24gb2YgY29uY2VybnMgYW5kIHByZXBhcmVzIHRo
ZSBjb2RlIGZvciBhDQo+IGZ1dHVyZQ0KPiB0cmFuc2l0aW9uIHRvIHBoeWxpbmsuIEZpeGVkIFBI
WSByZWdpc3RyYXRpb24gYW5kIGludGVyZmFjZSBzZWxlY3Rpb24NCj4gYXJlIG5vdyBoYW5kbGVk
IGluIGxhbjc4eHhfZ2V0X3BoeSgpLCB3aGlsZSBNQUMtc2lkZSBkZWxheQ0KPiBjb25maWd1cmF0
aW9uDQo+IGlzIGRvbmUgaW4gbGFuNzh4eF9tYWNfcHJlcGFyZV9mb3JfcGh5KCkuDQo+IA0KPiBU
aGUgZml4ZWQgUEhZIGZhbGxiYWNrIGlzIHByZXNlcnZlZCBmb3Igc2V0dXBzIGxpa2UgRVZCLUtT
Wjk4OTctMSwNCj4gd2hlcmUgTEFONzgwMSBjb25uZWN0cyBkaXJlY3RseSB0byBhIEtTWiBzd2l0
Y2ggd2l0aG91dCBhIHN0YW5kYXJkDQo+IFBIWQ0KPiBvciBkZXZpY2UgdHJlZSBzdXBwb3J0Lg0K
PiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiANClJldmlld2Vk
LWJ5OiBUaGFuZ2FyYWogU2FteW5hdGhhbiA8dGhhbmdhcmFqLnNAbWljcm9jaGlwLmNvbT4NCg==

