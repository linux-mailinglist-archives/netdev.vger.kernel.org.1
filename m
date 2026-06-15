Return-Path: <netdev+bounces-299316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1OJsGBuBL2p4BgUAu9opvQ
	(envelope-from <netdev+bounces-299316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F46834B4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:35:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b="lSS//ZsD";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299316-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5673009513
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F32F83B5;
	Mon, 15 Jun 2026 04:35:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0F246782;
	Mon, 15 Jun 2026 04:35:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498111; cv=fail; b=mp8+hoo6cmjULskwzROKVByIPqD5uyd08riTQokrdQ3Wc4ZvU4MHjpCZSXOK9TLOEDOQgDNugp0q32eeRuotACxRinpNn5mSchR4AA8k0oeNehwWsR0TX4hSm1iTJ4GJemxTzllKuM86N1iuXTNoTlCaYx/A9i/R0u3zfHo6Y/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498111; c=relaxed/simple;
	bh=fpMzSDPnN37fkQlHfUhb33KOMaQ5drHqXzqxoQAqXiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/rZgqsY7d3F6GKtcoMbwUNStvj3AZr3lXiWaejXVmZgirVlxjWLL55gViOyBkWdcA6rSTX2B+USIgkCGfDAqT1GxONCgSEzrxwshAsdED8DyXem5y4UUqbBlZOQqnuynD44egnikOczgzgOrLP9ruvkUHMg8S2XlaQyR4DThxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lSS//ZsD; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EciCjv0ctEPB6iEA8E4g10D8xFaQhzcAhS65NNjkgUvqIo5IUguKkO/q6OOkl4OPefVIoJWvcXstVV1kufGfvEiCnUxLvTKdErzQ7illIe5PdjgQkl20hqg1BMG7tNBZ9u/RGs13+dOkg5ShjRIzGsjuGhxy5JzJV5qqClSAxfDcjiuMbjMT8EUHYsn6DuKFTn4RcyrgcKYOeh34Ru8MrF6oZ8SMDm9CTtvnPVClxs3Jp344NvSVk16nmBju/dnzD7u/5NlZE5EurckPTSFaUCqMJPKYJnetLbNG2I2BML1K52zOBimcDhhwFNGQ72sU06FpsPGsUH87qzjWb8cslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpMzSDPnN37fkQlHfUhb33KOMaQ5drHqXzqxoQAqXiM=;
 b=BUj1AhbpSzAO7H/hz3wX6ALtS2BEpN+guV3qYigzq+9Lkxdc4eBApJ3s2nLAwTw52Rv33fuccRa69nzoazrEiYYyA5I2F6pv69f2Uvb6OpfiKTq0HCWxDKqX4NnxGFN0FZVENywwFCXNfqMh/NRYUJlz6UU7qkzzhMPJW0yI5lTXkLrBbrxtfXqsMz/TBT4qv0utDWCMvnTZbhxSwaQYo/vi6ORzDUWCLZ5MLAq5KzlitcnsB3OE6Tn5hFMf0O4p4a+7jpFIHhXNKhPUS6LoH0YxS4beDd2lEmRhj25Rr18bFWHsYHQ8GooqxfL/1k+U36T0BC5bTggVSGP4C3yxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpMzSDPnN37fkQlHfUhb33KOMaQ5drHqXzqxoQAqXiM=;
 b=lSS//ZsD8x/YWLoZ9O924ffn5vnL3V7hI626BR21b5MzEwnDOmT76b0fc57JVskVCQGbuMb0dOgdpr3Ps4aEvDWb/BqImlT9EvWAfPBcVTGeL3ODsCSYXOcRVYXSrFKEQrcPcxXr0kdaL92XwSMPIDJdImx1QFMQ9nl3NZy9qi94RTajO+TqlaqY3jXX1ewhuTgRcCVbpudr0BO1RiPC2UDSjCRlWrjhTEuUAzJoiCa4XV7TVk/HyQ0rbSfR5oLuqf8WGfaL/SsjrDn+8VoExJKDqeTCvNxHMrzfZ+MIev9RLhzKY5bvjxVYs0tfc4Y9Ybd68+28dAbaUPFz6qE7Fg==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 04:35:05 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:35:05 +0000
From: <Thangaraj.S@microchip.com>
To: <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/2] net: lan743x: add support for RMII
 interface
Thread-Topic: [PATCH net-next v3 2/2] net: lan743x: add support for RMII
 interface
Thread-Index: AQHc9y5anGwEGNFkwUuahEf2EpvRc7Y3/U0AgAQfvwCAAvELkA==
Date: Mon, 15 Jun 2026 04:35:05 +0000
Message-ID:
 <DSWPR11MB9715855BE92C289F77C19651ECE62@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260608100435.11214-3-thangaraj.s@microchip.com>
 <20260610162603.470355-2-horms@kernel.org>
 <232383a4-d035-4a36-8edd-f78206ae191b@redhat.com>
In-Reply-To: <232383a4-d035-4a36-8edd-f78206ae191b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|BY1PR11MB8080:EE_
x-ms-office365-filtering-correlation-id: 7f71569f-eb40-448b-19e2-08deca977929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|5023799004|11063799006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 lQM3wPrSimSj0sPQk29G+/BmZHq6Bf7UGG3UfoTdYEuPw8Ff1uu5VVCJ2ohPpU3KvblBNXEcou7ByDTt6ZMeRU+4H0cSybkaUYHHp+4LDNn+65h8md7utRJjwKwZwubE+CHqQOQDig3bZ3UnQ9xdJ9yYUEMQli0PHnsdWs/GzNgwDpQ2h20ryXJVSLqKZOA7JVDMszwTqESZ88Og0VZUjLyoqmHewN0xWl276cr1R+dzDQ2wqznW5UePYC8Qx3hyfhCCFJUqPR9b3L6f5cTZU1yCeBRlhrk2zkfCYPfiKnjarSFwbWUHZqMA3unUlzhIGOLkNwm8zyuY5ni53Y/OS2TdR6fxW3l7tyokmS7K8DsOyVWYyPdUhxc55pkLMumCiQBNcDdi2nXITTBTY8shq+9Ot3sC0oFn68jjv42V7ppO5cdTEabfqqTSfu27jEKNwgAQBS7Aa6E15veDkpgSNdZnW92gW1iMitZcm4Zi7OIeBmYBvt4wzXZOzY+P6U77BXaOQc9fwSzVGuGpYiX7DfI2ixlmGp3mbseWX7C7uJEkTENypxz/HZdqbpKubm8+pW9fTyKImbZoJoE3p+d6jRD+MAAJt9VSRsplCHEuqJqCGuKjE/mGIWnvz/o1C8180pUlA5o0ky4bmhXD7huRLzab/vKGAsSACVI41/k71RaxFIxjmigwnKJ3XCnPehsu7Ed+jM4F+61pEAc3NuzPgg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDBMdTJ2ME1EL0xIUWdwT2Q3VUZXRVZrKzVVSnNDQjdOSHlzMXh5SGxoYjBX?=
 =?utf-8?B?YXBxaFRoMXo3bkVBTnVuNmdVWU1sajBDUFhyckZJdEk1TGhTbHZaNzkwT0ZK?=
 =?utf-8?B?UXJ5dG8wZEZBZnpGczdlN2QydHVEbjFhaXNmczN1V3hWbFhhNDF4d1M2bkhT?=
 =?utf-8?B?QUpjemV1VERlVzQ3RzJTRmNJbk5mTnVURW96UkRkSlRkUkhldDZQYzBGQW4z?=
 =?utf-8?B?QTlrbDBJNFZjL2tsY3dPZ2crcXc5RStsbUJ0S1U0UFBBWExCeUF1aVhKVVRh?=
 =?utf-8?B?L3FCN0lFa204ZnZzd1EvU0dpMUp5a2d6TS9qZWVlOUY3OUlnSVE0RlJlLzI5?=
 =?utf-8?B?OExVek1Wb3c1Zko4QjBCOHJFdGtGVzE3b2VWWDJ4Nnp5b0tPZkg4WngxeHMx?=
 =?utf-8?B?d1pUYWNXbHhmVTFKUzJkMmdYWmxCV0Z0ZmxLL0xUTloyMnhMYm9TZzFEUmt1?=
 =?utf-8?B?aitZd0V2RXFYYjRnN2tsMUhJQ1JBY0RWaWtLaFZsSlhTakVRK3haZmROQ0Ro?=
 =?utf-8?B?cjJJbnlKMXU0dDdraDdDeWtKOENiNWRXMEpUckZIQTAzLzVXajZSc2JEd0JS?=
 =?utf-8?B?d2VOczArbGN0WExnTHo4YVBGU3dLbFc3Y3lBM05xUURzai9wN3dySnhxUy9n?=
 =?utf-8?B?UjB3Qkp1dndsdXgzRzZSRlE3bjd4TEZmSExRMlhpd0ZVZXhUbGFYUFZvS0FE?=
 =?utf-8?B?MGt6ZlhoWWRPMmIyVjFuQWJoZHdQbDRZREQ1M1pndWlSSkFMbTUyd25uWFhz?=
 =?utf-8?B?MU9XRWV5SWIzUUpEZm9nWnNlT0k5MnFSb1Jlc2tzUTJRZG00UXp4ZDRXWUIw?=
 =?utf-8?B?SW1KTndWTFBDRFNwNXV1TGVQZzBlTyttRklGNmlBMU9xcGN0TzVpSmdlNXdM?=
 =?utf-8?B?QlRVQy9TRHI5UnRFdjZDTlVjWGllbWtQVWNQdDVrSEplVXhUQWpvUzIrcnl2?=
 =?utf-8?B?WlN6T0hSenl5OFNHbVA2ZXEyMno2RnR4aUFkUXQrSm1GTGpMcHlzeUZDemtZ?=
 =?utf-8?B?L2tpR2tCM05hdXNhTW92c2p1QnZQYmhnMG9nVWx1YWkzUHlCR0xyRXUyeDBB?=
 =?utf-8?B?d2tmaXF2dmpMd2N6NmFqYzhtK2hndUFXeXFDOUxZK0tYdXp6REJlaDBpSXl6?=
 =?utf-8?B?Qk5QSTh0eG1iYlFUbldCeG5rZGU1L3ljaUxLVE1yWWRReUMvUEpCbXl3RzBY?=
 =?utf-8?B?RDFEZjk5Ui9DUjFNd1hXM3VtOEFmeXZMN3VKbkQwcXdXdTU2dzNqZXIzSjVH?=
 =?utf-8?B?UWZBOVFkUk51c29Ua2R6WWFCa3FPRi8xb1o2cFpKWDdMdG9QNklGbXFLekh0?=
 =?utf-8?B?WGxSZDJFRGdRaUlWVDdaa3R0ak1ueFdhanFFQ1oyQVNkQ2VBUVFkR0xsMVJp?=
 =?utf-8?B?eUJvV3hwY1RJM04rU0xzL2J0STVWUlJGQzdER1RjcFBXV3E5aXFIUEFPRW1i?=
 =?utf-8?B?T3lFRVlBRnhxTURJTU5RMzFqL0dzMWcyaTFRT0l3RnhyMDlYWDZyRUlXMHc1?=
 =?utf-8?B?YnUycFFiRU9Lb3VVRVg2cjBPdUNBY2FjMlVVb2Z0WXFhODNyNUIxWElVNkw4?=
 =?utf-8?B?Wm1kclNYbmJzTnBXSm92bWU0blNvOE9lQWlOV284V1hUTmNXZVNNUko5dzlo?=
 =?utf-8?B?YnFUN0N3VGVKWVZOdVI4L3phcHhBOXpWUUNjMDFJeVlxOFpuTTdxWkM0ajc5?=
 =?utf-8?B?UmI3enRHMjBsdnZ2N2Fhb2FQdlNkVVpmdHA5aHJoeWN1QlV0RHpIRloreVQ3?=
 =?utf-8?B?Nzc1cEIxai9RWFUvbnJRdi9uZUpHMXE0eXJvMWVJT0FlVjNlanNXUHpIN096?=
 =?utf-8?B?by8xZVZmQkZTL2F4V1NGSGZ3NTBGc01KL0syZTN6eXROa0dyeG0rMWpTbkVG?=
 =?utf-8?B?ZG1nK2NYSzFMWUxhOG43a2Q0cVc2VFBNWU85TUg1UHNrdXh5YmxDWEM0YWdO?=
 =?utf-8?B?anMyU2FkK3M1c0JwWEMzWlBVbWtGUWtaUDVwQzJlbEtYL0dUakcrN01YU2c4?=
 =?utf-8?B?S0VQVjZua0EyOStsVkxBcnNmcFhqeHp5V3lLRi9VZ1pTOHpZbHllV3V0MjNM?=
 =?utf-8?B?Y1JoV3FRSGxPdENUTVFKZDB3c210b0s4VVRvbGNCdUppMjVaVmVZTUhobDBZ?=
 =?utf-8?B?RUN2TzlkdXNObE9LNlRvNzk3Q1V1TDA0bXJhSklaUVJHSEtod2ZFTHpJVExD?=
 =?utf-8?B?MlBMZ3RxeHFVbDl4a3dqYWxza1IzNEdOUFAyYzBKd1BGaUpXZ1ZHUVNPR0h5?=
 =?utf-8?B?OFdTUm0xN1F3T3RMY1RnTFJBY3FEa2E3SVJVRTRpcnd1N1R2OEo5VHhDUWZX?=
 =?utf-8?B?UlpENG14Qk02WjYxckl3NFRCenFYNWRPcUwwTEZQTzRXR3lRZi9CUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f71569f-eb40-448b-19e2-08deca977929
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 04:35:05.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJYqUrvh2i21dm3imAck7kqvuutrbjnDm9NvZ1WJFtqsFFBEON3YBNbXhEDS1riO2WsplGphwWWNT61cL5zvc3gm2LIXXp3nu1QIizeKT0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:Bryan.Whitehead@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:from_mime,vger.kernel.org:from_smtp,sashiko.dev:url,davemloft.net:email,DSWPR11MB9715.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E62F46834B4

SGkgU2ltb24vUGFvbG8sDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDEzLCAyMDI2IDEyOjU1IFBNDQo+IFRvOiBTaW1vbiBI
b3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBUaGFuZ2FyYWogU2FteW5hdGhhbiAtIEk1MzQ5NA0K
PiA8VGhhbmdhcmFqLlNAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IEJyeWFuIFdoaXRlaGVhZCAtIEMyMTk1OA0KPiA8QnJ5YW4uV2hpdGVoZWFkQG1pY3JvY2hp
cC5jb20+OyBVTkdMaW51eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT47
IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYzIDIvMl0gbmV0OiBsYW43NDN4
OiBhZGQgc3VwcG9ydCBmb3IgUk1JSQ0KPiBpbnRlcmZhY2UNCj4gDQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gNi8xMC8yNiA2OjI2IFBNLCBTaW1vbiBI
b3JtYW4gd3JvdGU6DQo+ID4gRnJvbTogJ1NpbW9uIEhvcm1hbicgPGhvcm1zQGtlcm5lbC5vcmc+
DQo+ID4NCj4gPiBUaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZpZXcgb2YgeW91ciBwYXRjaC4g
VGhlIGh1bWFuIHNlbmRpbmcgdGhpcw0KPiA+IGVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSBy
ZXZpZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4NCj4gPiBGdWxsIHJldmlldyBhdDog
aHR0cHM6Ly9zYXNoaWtvLmRldg0KPiA+IC0tLQ0KPiA+IG5ldDogbGFuNzQzeDogYWRkIHN1cHBv
cnQgZm9yIFJNSUkgaW50ZXJmYWNlDQo+ID4NCj4gPiBUaGlzIGNvbW1pdCBhZGRzIFJNSUkgaW50
ZXJmYWNlIHN1cHBvcnQgdG8gdGhlIGxhbjc0M3ggZHJpdmVyLCB3aXJpbmcNCj4gPiB1cCBwaHlf
aW50ZXJmYWNlIHNlbGVjdGlvbiwgcGh5bGluayBzdXBwb3J0ZWRfaW50ZXJmYWNlcyBhbmQgTUFD
DQo+ID4gY2FwYWJpbGl0aWVzLCBhbmQgZW5hYmxpbmcgdGhlIFJNSUkgZnJvbnQtZW5kIHZpYSBh
IG5ldyBSTUlJX0NUTA0KPiA+IHJlZ2lzdGVyIHdyaXRlIGluIGxhbjc0M3hfaGFyZHdhcmVfaW5p
dCgpLg0KPiA+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2No
aXAvbGFuNzQzeF9tYWluLmMNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAv
bGFuNzQzeF9tYWluLmMNCj4gPj4gaW5kZXggMDc5OGYzZjFmNDM1Li5hZDNmODMzYzhkODYgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21h
aW4uYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9t
YWluLmMNCj4gPg0KPiA+IFsgLi4uIF0NCj4gPg0KPiA+PiBAQCAtMzU2Miw2ICszNTc0LDExIEBA
IHN0YXRpYyBpbnQgbGFuNzQzeF9oYXJkd2FyZV9pbml0KHN0cnVjdA0KPiBsYW43NDN4X2FkYXB0
ZXIgKmFkYXB0ZXIsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgIHNnbWlpX2N0bCB8PSBTR01J
SV9DVExfU0dNSUlfUE9XRVJfRE5fOw0KPiA+PiAgICAgICAgICAgICAgfQ0KPiA+PiAgICAgICAg
ICAgICAgbGFuNzQzeF9jc3Jfd3JpdGUoYWRhcHRlciwgU0dNSUlfQ1RMLCBzZ21paV9jdGwpOw0K
PiA+PiArICAgICAgICAgICAgaWYgKGFkYXB0ZXItPmlzX3JtaWlfZW4pIHsNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgcm1paV9jdGwgPSBsYW43NDN4X2Nzcl9yZWFkKGFkYXB0ZXIsIFJNSUlf
Q1RMKTsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgcm1paV9jdGwgfD0gUk1JSV9DVExfUk1J
SV9FTkFCTEVfOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICBsYW43NDN4X2Nzcl93cml0ZShh
ZGFwdGVyLCBSTUlJX0NUTCwgcm1paV9jdGwpOw0KPiA+PiArICAgICAgICAgICAgfQ0KPiA+DQo+
ID4gW01lZGl1bV0NCj4gPiBTaG91bGQgdGhlIFJNSUlfQ1RMIHByb2dyYW1taW5nIG1pcnJvciB0
aGUgc3ltbWV0cmljIHBhdHRlcm4gdXNlZCBmb3INCj4gPiBTR01JSV9DVEwganVzdCBhYm92ZSBp
dD8NCltUaGFuZ2FyYWogU2FteW5hdGhhbl0gTm8sIFRoZSBSTUlJIENUTCByZWdpc3RlciBoYXMg
bm8gc3VjaCBiaXQgc2ltaWxhciB0byBTR01JSS4NClNldHRpbmcgT25seSBSTUlJIEVuYWJsZSBp
cyBlbm91Z2guIA0KPiA+DQo+ID4gVGhlIFNHTUlJIGJsb2NrIHNldHMgb3IgY2xlYXJzIHRoZSBl
bmFibGUvcG93ZXItZG93biBiaXRzIGluIGJvdGgNCj4gPiBkaXJlY3Rpb25zOg0KPiA+DQo+ID4g
ICAgICAgc2dtaWlfY3RsID0gbGFuNzQzeF9jc3JfcmVhZChhZGFwdGVyLCBTR01JSV9DVEwpOw0K
PiA+ICAgICAgIGlmIChhZGFwdGVyLT5pc19zZ21paV9lbikgew0KPiA+ICAgICAgICAgICAgICAg
c2dtaWlfY3RsIHw9IFNHTUlJX0NUTF9TR01JSV9FTkFCTEVfOw0KPiA+ICAgICAgICAgICAgICAg
c2dtaWlfY3RsICY9IH5TR01JSV9DVExfU0dNSUlfUE9XRVJfRE5fOw0KPiA+ICAgICAgIH0gZWxz
ZSB7DQo+ID4gICAgICAgICAgICAgICBzZ21paV9jdGwgJj0gflNHTUlJX0NUTF9TR01JSV9FTkFC
TEVfOw0KPiA+ICAgICAgICAgICAgICAgc2dtaWlfY3RsIHw9IFNHTUlJX0NUTF9TR01JSV9QT1dF
Ul9ETl87DQo+ID4gICAgICAgfQ0KPiA+ICAgICAgIGxhbjc0M3hfY3NyX3dyaXRlKGFkYXB0ZXIs
IFNHTUlJX0NUTCwgc2dtaWlfY3RsKTsNCj4gPg0KPiA+IFRoZSBuZXcgUk1JSSBibG9jayBvbmx5
IHNldHMgUk1JSV9DVExfUk1JSV9FTkFCTEVfIHdoZW4gaXNfcm1paV9lbiBpcw0KPiA+IHRydWUg
YW5kIG5ldmVyIGNsZWFycyBpdCBvbiB0aGUgb3RoZXIgcGF0aHMuDQo+ID4NCj4gPiBJZiBSTUlJ
X0NUTF9STUlJX0VOQUJMRV8gaXMgbGVmdCBzZXQgYnkgYSBwcmV2aW91cyBhZ2VudCAoZm9yIGV4
YW1wbGUsDQo+ID4gYSBwcmlvciBkcml2ZXIgaW5zdGFuY2Ugd2l0aCBhIGRpZmZlcmVudCBzdHJh
cCwgYm9hcmQgZmlybXdhcmUsIG9yDQo+ID4gc3RhdGUgcHJlc2VydmVkIGFjcm9zcyBhIHdhcm0g
cmVzZXQgd2hlcmUgdGhlIGRyaXZlciBpdHNlbGYgc2V0cw0KPiA+IEhXX0NGR19SU1RfUFJPVEVD
VF8gZHVyaW5nIFBNIHN1c3BlbmQsIGFuZA0KPiBwY2kxMXgxeF9zdHJhcF9nZXRfc3RhdHVzKCkN
Cj4gPiBhbHJlYWR5IGFjY291bnRzIGZvciBjZmdfbG9hZC9IV19DRkdfUlNUX1BST1RFQ1RfKSwg
Y2FuIHRoZSBSTUlJDQo+ID4gZnJvbnQtZW5kIHJlbWFpbiBlbmFibGVkIHdoaWxlIHRoZSBkcml2
ZXIgaXMgY29uZmlndXJlZCBmb3IgUkdNSUkgb3INCj4gPiBTR01JST8NCj4gPg0KPiA+IFdvdWxk
IGFkZGluZyBhbiBleHBsaWNpdCBjbGVhciBpbiB0aGUgIWlzX3JtaWlfZW4gcGF0aCwgbWlycm9y
aW5nIHRoZQ0KPiA+IFNHTUlJIGhhbmRsaW5nLCBnaXZlIHRoZSByZWdpc3RlciBhIGtub3duIHN0
YXRlIG9uIGV2ZXJ5IHByb2JlPw0KPiANCj4gSSB0aGluayB0aGlzIG9uZSBpcyB3b3J0aCBhZGRy
ZXNzaW5nLCBhcyBpdCdzIHJlcG9ydGVkIGJ5IGJvdGggc2FzaGlrb3MgYW5kIGNvdWxkDQo+IGJy
ZWFrIGZ1bmN0aW9uYWxpdHkgaW4gaGFyZC10by1kZWJ1ZyBzY2VuYXJpb3MuDQpbVGhhbmdhcmFq
IFNhbXluYXRoYW5dICBObywgVGhlIGhhcmR3YXJlIHRha2VzIGNhcmUgb2YgdGhpcy4gVGhlIHJl
Z2lzdGVyIGdldHMgdXBkYXRlZA0KT24gcmVzZXQgYmFzZWQgb24gc3RyYXAuDQo+IA0KVGhhbmtz
LA0KVGhhbmdhcmFqIFNhbXluYXRoYW4NCg0K

