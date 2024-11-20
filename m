Return-Path: <netdev+bounces-146381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6C9D3340
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B90F1F23372
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840C158D6A;
	Wed, 20 Nov 2024 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="WxkJV6eN"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020087.outbound.protection.outlook.com [52.101.128.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C68149C4A;
	Wed, 20 Nov 2024 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732081543; cv=fail; b=fclZSgeAr0ZFgXgwZsW+iEsLOlYH7elR1ERYDKafK7SblwMdjtWyeKcdf07psoNdkDxKZ17hWsJPdQj+KhJxmlqVEsG+zbvppKMUrGKg8GVwCu/cpRuhuxJxTfd5btjoyrC4IbMe2yTVHXGojVm51p7oyjoz6R6BYe76wmTlZqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732081543; c=relaxed/simple;
	bh=elkW6DDz1e2XAxwx0SNE+vL5LoSxglAw7BhOXfM1uhk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3dl4leA7o7pIoYSBhrziEhx05INpFp26ka/GuSwZCEC4oPgJ25lfWVwIL1iZil0QFY4++sW4EcjzEbRbVNdD1ykic803j4P7gA8wexqMhw/WcQdX7Axey3+uRUqK1zwa+fgiCmE/f4u9QlvGokR0IstjfDT5XQSSh/QUGJ7jzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=WxkJV6eN; arc=fail smtp.client-ip=52.101.128.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlYW2NvTim6jB1m0l7j7vxap/pdkhsOmuTVOnvQ2Wzo2Cmu57me5EXGYVK75KkeQuUj4ADVWoxtBLPWz9PSZbgpowgVekJ1/GtQCzsXqAV9HQgUOBFjzEjpeccm2bOXNVFUzFX8bWMBnnLNVEMSzhz9ExAqs6i+Ql46NyTbOSXuszW8Bx3PIcjLpWv5s1e/ZyIntF+hgnGhvVe56Y0OrSDPHoK+917qimjK1KUkZAiWpLHoxW0JYMT4oTPgJ8Nd3fhC5nuDHGuGYUOZ1/gBLAk7VnN/Q6lbo380uzddU3jmAa/W2ArCVcJOcNn1/v6vZTdT5xLRMEFVxZUJnoAvP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elkW6DDz1e2XAxwx0SNE+vL5LoSxglAw7BhOXfM1uhk=;
 b=BeCWCt3udJO7+VLi+bP+efX63eI0+P2Epiz9IT14yMtkZDR9TXiYI2SqNhHTCfszWeWVde6AjZEpT8XiqgV9hJI5fukd51r7hy0Vl3PDpHnm2JMYtAOeIa3P+4N211Ba/XFA03ziuiq7SyZRzQxW0tqRI7qtA6VAIKWJW0L90Ar30rbI4+wmEjTQ3VeTfiytfW6ni5ekqTKs8S3p2LZaqL0qt0iwamwhB01l/gYG6hqWpWazTkXA6uoq8NKKKdTbbreq0is53UZOw9a7H6TVGx5SNUdjydvmCQwuFPE8zRnZdofh/BVROvJRPOr9FDL96leNSGAHSVnecIkP9R0+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elkW6DDz1e2XAxwx0SNE+vL5LoSxglAw7BhOXfM1uhk=;
 b=WxkJV6eNRtjGRCGTONZmZtlw807qwmc2xnTeTMyvcskZcIGQ3iP2BqWmR2QAY3AePzkId/Y7GHbcqMYIzxuhsOK/DcQ3UVsImFcVAV0B2laOBznQpGo4JDyec5oixpaLFabjqgDg22PRYlnFBdhz4SQkzvOympTA2v+7nOTU40/S/99mHGqa/athgG97wjU/3oaELZ/ZeG1QsHFtxsMbdjuZZQcmONUOteb7/Qgy3OKoBmXPKGLCdGELfoKBWYkmdF3zSauSoTauufZjfuolvQstDjHDY1+7h+Ys02sZZ5/1SFRKfYxz3C87vUB6SVwHXA4fg1Nev63oyCiR+r/+OA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6936.apcprd06.prod.outlook.com (2603:1096:405:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 05:45:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Wed, 20 Nov 2024
 05:45:31 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0IHYyXSBuZXQ6IG1kaW86IGFzcGVlZDogQWRk?=
 =?utf-8?Q?_dummy_read_for_fire_control?=
Thread-Topic: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
Thread-Index: AQHbOmio67w/1l79vk2W+xgv0i2nS7K/mJaAgAAOu1A=
Date: Wed, 20 Nov 2024 05:45:31 +0000
Message-ID:
 <SEYPR06MB5134244189AF9C4F78B368229D212@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
In-Reply-To:
 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6936:EE_
x-ms-office365-filtering-correlation-id: 0cff9770-5e0f-4e73-aaa9-08dd09268bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0pjd0FhZGtNQ2xlZ2dIcFVPbzNXV3ZKRnBaMFFBVmVVakVYVlN0V0RrZDgy?=
 =?utf-8?B?eU5WMlVSazM2UWMrUytFMVh1R1dpTTlZcEpzNXlTTTNjRk5JbHBBMFpqN2lD?=
 =?utf-8?B?YVk4WXd4anpNZHZSNjRCdHhHbEJhYXk1ZWtrb3hDZC9FQ0d5QUVwODYwUGxm?=
 =?utf-8?B?TFhaMzc0NUlhTGJ0U2MyRmtzbW8rOWJ2Mk9EYWc0UHI3MFp2V1RuekVPeXRO?=
 =?utf-8?B?OWdyaTlhc1BUYmVnbS95MFZCaUZWVWk3b1ptL0ZOUCtGWFJPL1Vva0xKdEVH?=
 =?utf-8?B?M3lKeHpXUWxBSmt1V2RZd3RFTFJUalcrbERWcVM0clcwU3FxZW9sdE8wcys3?=
 =?utf-8?B?VmIwSXhxVE5FTEVPZTlhVmF1M3dFYjJYOUJCUXZqdmsydmk1YTNjVU1hZ0pJ?=
 =?utf-8?B?aHpKTzhHSVg0aG5oUUZXNWZOU20rcnU4L3ZXTndQTy9yclFvd2taVWJIck1K?=
 =?utf-8?B?OFQ5RjJLYWh3L1d6b1ZiZnJ0bDhHbURLNWluR0d0cjdVSEo1bzhhS0h2U2ZC?=
 =?utf-8?B?N3N1S1Y4YVNsYW43VnpGWktKWGoxdVlvMkVjK1lEVlJoQTh2aFdLVnVRdXJz?=
 =?utf-8?B?clBzaWUxWXdXSmJLWUxzQXZHamJ6ay9pbkJrMWZaazRpSktjcG9hVTNaU3pH?=
 =?utf-8?B?R2duelpFNi9udCtXYnhpbkVnMnVZSGxtQTVJdGJRVjNJRUZwNEk5Y0FHSHo4?=
 =?utf-8?B?N2F0Q3JZTXdqYWVzMldMTHZIbVlhbGIrSjdraGNIczA5dmpNek92dStiVTV1?=
 =?utf-8?B?eVNiUStTa0FXTVE1NE9hLzY5dHF5Nyt3dVUxZjIwTkZWU0NDRzRvZ3FiN3Js?=
 =?utf-8?B?KzdMR2VycFJ6L05VMjJHYyswSTJTQVU1MUhUK2N4UVVWS3pqWk5HNGFoenFZ?=
 =?utf-8?B?bi8rSU9NU2U4UUJUS2VvbmlkVE5wREp3a2FYdis1U0o0bmtuUS9mVSt6RmhE?=
 =?utf-8?B?NkRJNUZUdHo5R2tMeFdOZjV5elNGU3FobjQwVVgxd0Y4MmxHRGRTWEJRakg2?=
 =?utf-8?B?TzBKMUdQOXJYQ1FwRGVCUkpHU0xsZ1lTd2JWbFFpUkdCV1JKUXZyTnNHcmpq?=
 =?utf-8?B?dThoemNaY1poS00wUk1DUlhSb0JxbzBMZWJEOGQyemRCZjRaN2xmTUhCNVlq?=
 =?utf-8?B?NERKWHFxU1hvdDhoMHlzR1NvZjd6MWVMYW5SOEVoU2tTQzNUTUs5V2VmNGpo?=
 =?utf-8?B?dElCdjR2RUhtMmFCYXUwcHdXTXZWcVMvajd2ZEQxUVd0c1poQitkY1ZkKzMv?=
 =?utf-8?B?enRRTlgzdS9qSzFsSHY5U2M1R0JuQ0Q5dkxiSnBSQUZmOUZBUE16WnAwRlRs?=
 =?utf-8?B?S0t6VmZNMHBzNXcwL25EdXVzZWRsQmM5dGFZQTlWaWpQcGdBcTlHVENFMW5q?=
 =?utf-8?B?Z0huVXh6ZVN6UjVSMzR4My9lQmRwall6S29LOFFoWTc4a21UNTJHNWxDMm9a?=
 =?utf-8?B?anJTekhIblhqbDhieHZJMC9vcm9lMHNDY09UWjBudWhxNnNPVmZMSHdVa2lJ?=
 =?utf-8?B?eWhQSW9JZ2tWa3Z0cjdpb2RZbllGUmlhelMrOGZ0R0pRSXR0cmZzVGdYYTdY?=
 =?utf-8?B?TW44elJzWWExNkZ4MG1mT3R1QXNOWmdUZUdNT0ZkWktSVVF6RCt3aHVVZVdL?=
 =?utf-8?B?L0RIWGpRRURrZ3c0bDZTSEo1VHExSUM1NFdtOVJmL012OG9aaEwzZTdya2ZL?=
 =?utf-8?B?NWtzSmc4NUZlNU9KYnpIWUNrUGZkSzRNNUh1b2N0Z2hDNDBjbTdqZHZXQmF3?=
 =?utf-8?B?czVZTVRQQ1haVk4wNXE1MlpRUHdqRWRnUG0zYXBML1BUeVB3aE5ka1dFd1Jw?=
 =?utf-8?B?MGUwb1VPK3lpaTlxNlFKcE5XeFpRNzROcFowT2hQS3ZNTHRhMFBrYTRSVHdw?=
 =?utf-8?Q?JP0lnJuvq77vW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXljeFFaRVhuSHVYbTFwQWo0ZDJmdU9LcFcwZ3RLcGZ4cUI5YXkxZ2xWMUd1?=
 =?utf-8?B?U2VNUUx0TURrc1dvY1JxVFNvampFTVRpcjM1Rzc1RnBrdUdyU1hWN0plem40?=
 =?utf-8?B?MUo0NlYzTDArSmdYcFF3QTZHcVcvaVNlY2YzRmhtMkhlaVBXS0I3c0Vrdm9M?=
 =?utf-8?B?Z0pZTmZoZ3laK3FFRVdwdWFRTCtWY3E2Q1BTWE11ajFuQTZuSjJJNVl0RzEw?=
 =?utf-8?B?emNuTUZXVVhPWWZ5T0E0TnhkMlV5NURXNG5pYi9icGdzMGxHQ0t2ZEQ4QmNa?=
 =?utf-8?B?RkF5WkRVWjRzaUdaQndUcDcyU0ZteWJPTFcrRVpwMEhpNFJGM3hzY1hPRWlu?=
 =?utf-8?B?YmZnQWRFL2dIODNYS1d2Y1N1UGYzYkpGMEJ3ZkNLUEV0QmpXZyt5KzlCWjBr?=
 =?utf-8?B?Rm5YOVUzVE03ZXpWWkIyOFZWcVUzYkJMck91RHFXQmVWaHdEUVFZMEZkS1Yv?=
 =?utf-8?B?WDc1OUdZNDhPNGd6S1RaUGNDbjBSODNjVGhjWEVleURrQ3hjMFYwTzRxd0Jz?=
 =?utf-8?B?WkJ2SmltZDhQWCtJNklUOFd3bFdZWkFpTUpYZGJ3WkNuRy9KY1ExelRtNmxq?=
 =?utf-8?B?Y3BQYTNFRjkxMU5uRHQ0NU15QjRIUEhtN3VlSGNFWlZXMjZOeWJRK0k0YXg0?=
 =?utf-8?B?SkVmbHNmZUJIUlJYT3g1V3NlMWV3Y2l6ajV4eTF3NUl3WEpLeGYvT0hJcks4?=
 =?utf-8?B?OCtnQUJ6UzRnMTJhTis1WDArblJpTU9CKzArcEhJRVB5WUVWN3ptUFJMWENY?=
 =?utf-8?B?TmU1bUE4L25NbXVmTDQ0NkM0RXh5WEVwMWhCc1ZlUkdYY1hNNnpaSCt6YVlx?=
 =?utf-8?B?VHdvM1lDQUdrd0pmY0U4REZOcUs2YnNMMHNOZVJRcm9JOCtWdDJxRnVLT1lL?=
 =?utf-8?B?MTNaeEhXSzJsTFYwNEdTYndKMjE2RGVuNkhVZWtZdStBd3o4c1NYSnRqbnpY?=
 =?utf-8?B?ZFRhUGt1SXJ0enNuU1hVN0xGR1E4eldDYUkvRnUzTGRXOVBFVHpzUWtCT3JE?=
 =?utf-8?B?UGwyNjRuOXhwQkZHY3BXN3g1NFpHdGYxRjh2eXU0S0ZPSzQ1UGcxSmR4aEV3?=
 =?utf-8?B?ejd0RTJHYXRHa1Y3dkpIOVRoenY5NkExMEJvRlgzSzdZVjRKY0swcUh5cGJG?=
 =?utf-8?B?WHkrYjZ5QnU1aU5ja2RSb3ZkbitVcnFPeXEvcWQxaElJTTVTN2QvblFrb1l6?=
 =?utf-8?B?Zi9mOXZaQjAyRDlkNTQ2NElDc0VIL1RZREtkeG5Zb1F4ZnVLVG5TL0JadTBT?=
 =?utf-8?B?Q2p3NWJyZUZ5N2hFL0FyQWJDcFFJTXRjRCtBMGdDZjl2LzJpaHJvNVBrcTJ5?=
 =?utf-8?B?U1ZPZ0U5VTAyZGxCL0s1WUZtV0kyc0dpb1JLYVJOQ1FaR2VaQlRTNE9wWWdT?=
 =?utf-8?B?eDVDU0RrTlMzVmNOQjBmcWF1N2RweHFWY3J5aWVrUGd6bHZ5elNZbU8zOFMz?=
 =?utf-8?B?RWFEK1M5UWRYb09YR3dzeWhFWHE5bUF1MFBsY1lnRG1wRW1VeVBIY3hhRW8x?=
 =?utf-8?B?bGxGMmZpU0JyUTRHR1VjUXk1L0xJdkR2MlA5TXAzVVYwZGovYWVQeFBObSto?=
 =?utf-8?B?a2tsdDFHeXFHY0dtOVlWNFNVTnpUcmdyQjgvaTVrNXlMU0VYeDRDQVRXdjda?=
 =?utf-8?B?TE9jYkdQc2ZyT3AwNzN3WEloK1hYRkVnN0JzRC9mR3hxeENHTmk1VHA5cUV5?=
 =?utf-8?B?aGxObGlvK3h5ankvZFFzaVo4RlUrWGs2OGkzMlF0NkZVVjQ5Z1BycUdBUkxa?=
 =?utf-8?B?QjFWZG1QR3drRTdpQmxvTWtXcTJibzFzR2lhbW9YeFVJbXJyOGFPWjdybk1E?=
 =?utf-8?B?SnZpV0pDeXVqdCt0SisvZjB5dHppRTBMbEx5ek5STlgvZzgrVE0rKy9KSW9H?=
 =?utf-8?B?WWhvdnVMVGxXUzJLbm9DUkREUW9oRWdOd2NLSldiYzljTDFmbVp1ZmRkMWJ6?=
 =?utf-8?B?Yk9kaFNzNHV6RzhITGNxWjNXbTN5ZzdkdWtWMzZudmF6MTIzMkxYcWlBWHRZ?=
 =?utf-8?B?U3M1cWZyejF3cm9aNlRoQ05UUlJpZ1VuMHlqV040RlBwaEl5UmQ3SzZOSS90?=
 =?utf-8?B?MWl0d3I3Y3JBZThFdnpUUzl5NEF4bjNJd2xPbmJqdmpibmJOZi9xSHNiSkpM?=
 =?utf-8?B?NEgyS04ycWFMa3FKSG54enFJOC9SQ0dzT0J4Wno5bys1dk1KcGRHaFhBQ1Nj?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff9770-5e0f-4e73-aaa9-08dd09268bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 05:45:31.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4ZE1Ue5QTq+e/fw4GnDVld2jZt6IRj8S+dEIgcLtiDSPgdx2bwk3P0euQnXIfbJ0K3/UR239TjqpoM+A/twcHF19kQ1VGXzeGotFJA131M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6936

SGkgQW5kcmV3IEplZmZlcnksDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IFdo
ZW4gdGhlIGNvbW1hbmQgYnVzIGlzIHNvbWV0aW1lcyBidXN5LCBpdCBtYXkgY2F1c2UgdGhlIGNv
bW1hbmQgaXMNCj4gPiBub3QgYXJyaXZlZCB0byBNRElPIGNvbnRyb2xsZXIgaW1tZWRpYXRlbHku
IE9uIHNvZnR3YXJlLCB0aGUgZHJpdmVyDQo+ID4gaXNzdWVzIGEgd3JpdGUgY29tbWFuZCB0byB0
aGUgY29tbWFuZCBidXMgZG9lcyBub3Qgd2FpdCBmb3IgY29tbWFuZA0KPiA+IGNvbXBsZXRlIGFu
ZCBpdCByZXR1cm5lZCBiYWNrIHRvIGNvZGUgaW1tZWRpYXRlbHkuIEJ1dCBhIHJlYWQgY29tbWFu
ZA0KPiA+IHdpbGwgd2FpdCBmb3IgdGhlIGRhdGEgYmFjaywgb25jZSBhIHJlYWQgY29tbWFuZCB3
YXMgYmFjayBpbmRpY2F0ZXMNCj4gPiB0aGUgcHJldmlvdXMgd3JpdGUgY29tbWFuZCBoYWQgYXJy
aXZlZCB0byBjb250cm9sbGVyLg0KPiA+IEFkZCBhIGR1bW15IHJlYWQgdG8gZW5zdXJlIHRyaWdn
ZXJpbmcgbWRpbyBjb250cm9sbGVyIGJlZm9yZSBzdGFydGluZw0KPiA+IHBvbGxpbmcgdGhlIHN0
YXR1cyBvZiBtZGlvIGNvbnRyb2xsZXIgdG8gYXZvaWQgcG9sbGluZyB1bmV4cGVjdGVkDQo+ID4g
dGltZW91dC4NCj4gDQo+IFdoeSB1c2UgdGhlIGV4cGxpY2l0IGR1bW15IHJlYWQgcmF0aGVyIHRo
YW4gYWRqdXN0IHRoZSBwb2xsIGludGVydmFsIG9yDQo+IGR1cmF0aW9uPyBJIHN0aWxsIGRvbid0
IHRoaW5rIHRoYXQncyBiZWVuIGFkZXF1YXRlbHkgZXhwbGFpbmVkIGdpdmVuIHRoZQ0KPiBoYXJk
d2FyZS1jbGVhciBvZiB0aGUgZmlyZSBiaXQgb24gY29tcGxldGlvbiwgd2hpY2ggaXMgd2hhdCB3
ZSdyZSBwb2xsaW5nIGZvci4NCg0KV2UgY2Fubm90IGtub3cgZXhhY3RseSB3aGF0IHRoZSB0aW1l
b3V0IHZhbHVlIG9mIHBvbGxpbmcgc2hvdWxkIGJlIHNldCB0by4NCkJlY2F1c2Ugbm8gb25lIGNv
dWxkIGtub3cgd2hlbiB0aGUgd3JpdGUgY29tbWFuZCBoYXMgYXJyaXZlZCBNRElPIGNvbnRyb2xs
ZXIuDQoNCkEgZHVtbXkgcmVhZCBjYW4gZW5zdXJlIHRoZSBwcmV2aW91cyB3cml0ZSBjb21tYW5k
IGhhZCBhcnJpdmVkIE1ESU8gY29udHJvbGxlcg0KVGhlcmVmb3JlLCB3ZSBjaG9zZSB0byB1c2Ug
YSBkdW1teSByZWFkIGluc3RlYWQgb2YgaW5jcmVhc2luZyB0aGUgdGltZW91dCB2YWx1ZS4NCg0K
VGhhbmtzLA0KSmFja3kNCg==

