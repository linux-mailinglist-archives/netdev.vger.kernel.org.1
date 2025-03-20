Return-Path: <netdev+bounces-176399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C2A6A0E9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893E91893D83
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A8207657;
	Thu, 20 Mar 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="m4lYRodS"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738F15A8;
	Thu, 20 Mar 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457989; cv=fail; b=UuMxEWD+imgN7Tss+2/+uxrKiY70EldI5FMcMpQqlmcmc2YBWrz8iiQ3CKr7sIPrZml/Ge8oJu1ZZwuqZdfpVK6w4N8uA6ZNBAsJ2Uz+ru8smMf2KZZdidbrwTFZLVH/NpZtFlOkS2pfImJAm+5jTFWpnUGIdBoEWpPuH38+TpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457989; c=relaxed/simple;
	bh=NI6LE61vU6KT15GvGEPAU5lGVKad3UCfXlxdLDRmDJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DpeiQbwVi1Y51jzlJ3AP8knuIE7ll5UalXzUBL/JVrFdPLevdZcMFidEloybT8Zv4m3mAqSG31BfB3Fz3knx0BHofx5ygbeA5VqgFTCc4eBiphX0Xw7SDpPlrhgKiTHnprycB/UWVYQf60MjXMvWvXzaTMIv+oKRM2AxS5tV94E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=m4lYRodS; arc=fail smtp.client-ip=40.107.117.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAi5Pp1FTSo4eG19gSPXqyM1BplofsEQM//X7yiKVT7/IXJxoSNcklzFL4T4kGx+SVxT82Y1I2SwcHiA2nFsRoUylFsBpAH3d3d0+CTZE5xOVRSg25df1cbRYMANo6c02VolWcPFv8HlT23jpMpxJUD1L0SZ3kzCzTTMharN6o7euNTjMwCyB6FUY92NTne0rG7mPa/36juTXCd3+IdgBLCwngLIlwMWGlUGBNrAs4SEeU3SjkFKk9hywT1G6pwL7fXtSq26AdFni+AxvUkSCrBxRYEPZAKKAwBHY85LgKBygRTnWZ1AkpdbH4NMyJFmm6srUoC5mXfsGuaBf4p8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI6LE61vU6KT15GvGEPAU5lGVKad3UCfXlxdLDRmDJc=;
 b=Sx4f88CdGRB9YNiJGEOWOIXoQZ81B1CEo6Xpz7kxEhVU28Z12ki+sAe0Y+pJmL/oVWuMQXbgsTZN87CT804rtAfaQy5T1b3jx5oCAdwQTv9w+y5D2mzbSh0pLX8xaRuwryAuQ3+W80krLmAsCmf4WkPzFJ1MLXJz60f4ckRnvnVLZdu0afu0XHWVeXPPq+WrmtMhE6VBnnwJ0Vgvw0zFWeVXcer22jJo9DUhRPMeVMWCjR86nNZ7yGLdIe9zd9Ipwy3hgT+Awi5FqwiNM/3lnyVBOdsHsXZ/sN0oFmo6xsUkuJoTcBwy6Acfc3n9UPUynU/qXTt9AhbfBnUeHpzYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI6LE61vU6KT15GvGEPAU5lGVKad3UCfXlxdLDRmDJc=;
 b=m4lYRodS1Wg0ZgNepFX2lFFLLrQ/GKT5wcOLYCYBZ2CJOvYlycQJSGmJnYJHwJP+Kv5AQxCdqlpL4c7A1SR7KCVIdzBh/3RRN5IMxL6UAOfwGh8ewo4HXDOOqyuVuuRFxgzEFcQaF38tDfq1Q8Fh84x9ovrO+drToZ1g7HqzNyfeGWbMqv5+CJtTEjDxulnPAIvb5wE43zJY8LWVzQiO518kHlNB5FuZpBVCwXT8drLlR2YA3yYDP/tMDTRgQzMXr0L4bHki3NrZ6LVgd2TRWhR8yoJBZNei4kXkF3/26s/7qE8svMP+wpImRB4oYCqDhgpkmKhBoxzA4/9is07Fyg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB7173.apcprd06.prod.outlook.com (2603:1096:101:22f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:06:24 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:06:24 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjogW25ldC1uZXh0IDQvNF0gbmV0OiBm?=
 =?utf-8?Q?tgmac100:_add_RGMII_delay_for_AST2600?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtuZXQtbmV4dCA0LzRdIG5ldDogZnRnbWFjMTAw?=
 =?utf-8?Q?:_add_RGMII_delay_for_AST2600?=
Thread-Index:
 AQHbluibt/La9I2bwU+d8Trs1O9LmLN3Bk6AgAAl6QCAAAE58IAAG6yAgAEVPPCAAI2kAIAALpWAgAKUw8A=
Date: Thu, 20 Mar 2025 08:06:23 +0000
Message-ID:
 <SEYPR06MB513443D43C99A04B3493ABDB9DD82@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
 <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <5b448c6b-a37d-4028-a56d-2953fc0e743a@lunn.ch>
 <8762dea1-3a0d-4bc8-aacd-fc8a2b5e2714@kernel.org>
In-Reply-To: <8762dea1-3a0d-4bc8-aacd-fc8a2b5e2714@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB7173:EE_
x-ms-office365-filtering-correlation-id: 45970c83-3c56-41ad-3280-08dd67861b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHo4b1ZGSVdKZW9vSkNnRWE2bXhwUUx2cHJ0cVUvUUNEWmxJQ0dpRi9hRm9S?=
 =?utf-8?B?Ui9tRHVmQVp3MDJ5NlFvSkR3QmlrcWhMS29KZWd5VzlndnFxakF4T0FRM3Fm?=
 =?utf-8?B?M0dyZVdsS2FRa3Zka2dqTVdlSTVMcVAwOTBHRG1WWnZpV2lKUXpEU3U2aEFx?=
 =?utf-8?B?dVg0OUViNWwycTltMlNCR01SMVVnYWNvVmt4clVPTzRmYzM1Z0paRjlMc1ZV?=
 =?utf-8?B?T2g4b2kzOXZweXU2Sks2aDN1YnJwSjZXYU9STXJlVDJXRzlmR2s2MFBXTU41?=
 =?utf-8?B?TWxnSDNNTnAzM1AwL0dXaXhEYUF6NFNic24rUS9qQXVvUnRONkhIQ0hxaUFV?=
 =?utf-8?B?SDUvd1NYWC9rWEp0MkVzeXY1R0Z4aHl3YThIK3NJVWJhY0dmMm5DS2ZCbkta?=
 =?utf-8?B?WnZ5RUdmb0VIM1hnWnoyNDNCcGQ5a3JKYTZmbkR3T0tTb2ZDTzhVU1M0OTdG?=
 =?utf-8?B?dFpIcy9KMWRibG5DTnpQTjlSbWhtRStnWWpCZ0xRbm05VjhTOUl0RVMzK3Vy?=
 =?utf-8?B?UTVqSlBBaklGS2lOVEIvbEdoUFJHZGpFZElFOE9DV3NrQlQxNWM5QTF4MWZl?=
 =?utf-8?B?dUMzcHBPOS81bFd2UW9MdjRmaFg1ZnZHRjM3SktUWVJldVhGZ2cxOHVZZndF?=
 =?utf-8?B?cXZMZWJSampUOVZabmRabkpMS21mOTQ5K1BzWjlOQ1lOK1pnbUxHOU9VQ3l4?=
 =?utf-8?B?THNvemE5Nlg0RmtwM3doYVlab0R6SGZybE9xODZFZ0xvUDNjSEZsWU45bjV5?=
 =?utf-8?B?b1JLZzZxczdEMUhIalpQWlMxc3hzZTg4d09UdllNVG1qNDFYN3BsUlRnK1Bu?=
 =?utf-8?B?aXhESFNoY09WWmVhTWw2dlZmd0VZdWtBbENSNzZ1RVlRbVFCeHcwWWhuL2lT?=
 =?utf-8?B?ODlSTzZ2eStHQXI1b1hCRElIRHp3ZlpSN3VFQ3MvRWRXNFVtaVU3TC9aVWFl?=
 =?utf-8?B?aUo2azQvNmpSZzVjc0w1V1ovTHVVV1BZWENud2FmSlh4WnJmbGduQUlOTCt3?=
 =?utf-8?B?WG1Cem1wTjNsUGVyMWNpTHd5R016NzZvTlh1VWtrSkNNVW1yNXh6aEN4NnBo?=
 =?utf-8?B?YWQrQ1dGSThBM3pUNWFVVEI1TVF0UERKUEdsRHdIS0NTR1lhQWJiclRjb0Uw?=
 =?utf-8?B?aUVKRE1yTEhOZTlUeUhJRXpRSnhOaGJIUjgxVXJucTMzdkFNSFN6a0lIMk9K?=
 =?utf-8?B?bnFkRTRsK0d3YkEwR08vbS9SVHZCNDA1N2hFT2NUSEVRT0MzT1ZMc0t1T2pa?=
 =?utf-8?B?dUwwZ2JSNDFKa01BaW0veUs2dDlWNTRmaEpDVTMySmx4QVN2c2Y4dEZvUXRG?=
 =?utf-8?B?VGVldC9MZUNTOVo4b3d4U2Q4NFJiWDlUaXVoWU5XTUU0RmwraFBZMmxYYVMy?=
 =?utf-8?B?M0hxWHIvSHZjL3ZQaWJXQkM4dFlpb2c1RFZxeUpKTFFhUTlZbDVlYThIOW1X?=
 =?utf-8?B?UVoxaVZWVUZ5S25aRnplQ25QSlNkK2JDRnBMZ3R0SEVTcGV1RHZ3WXF2SmpK?=
 =?utf-8?B?N0Q2UlptTGNUdFVncXZxWlR3d3BDTmE0OVJjRlViWW13UWxZVWpkWkkwTWxj?=
 =?utf-8?B?ZjQzTTdNTG5XUWxtR3Z6eG1RRitBMzlROHJremx4MUduREE1SklRVk5QL2ZP?=
 =?utf-8?B?aysvbFpHb1ZTalFhWDlaSGFvV2JwOTJKOGFqNWF0T2dqM3M1bUtwdHdNVkpU?=
 =?utf-8?B?a3ZvQzhqc294QjhmSmgrSGgwTExlQ0dyYjRNYm5UcnBPd0tzYlE0a0lCRVA5?=
 =?utf-8?B?aFI0K0d2OE1GTHNQUndWaXAvN2VQcnJsRFc1WXRzQ29lZXVxalc2YW5kZ1pF?=
 =?utf-8?B?UnV0VnVkUDBkTk5SVUJMbWU0eUhSNTVoWFUvc0xocXBXcXJlYkN4VmZUbmxH?=
 =?utf-8?B?QzhQdG13TG9JbmQ2cWc2S3VabklsaFlCdlFFWC9NT0Y3SGFka0s2TEdMemxU?=
 =?utf-8?Q?oZclEGtDIhW7yM/Zvbf395LqZnMxt1Y+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzZPd1hBVHIvMlY1eG1kNzJ0ZCtvQzl4TTVvd0ZmaDliYzlOSDJuSW1mUWJi?=
 =?utf-8?B?V29PZ3VnUFl0dDJRejBBZU0xQ05Pd0VwN1N6TUhCeGZuTVZ2VmdTSDBIU211?=
 =?utf-8?B?NWZLWEdmK2p1aHJYRWQwTUNZcjZDTWt4MkFSWWlTRGdwWDNyb3U5UERhMkNI?=
 =?utf-8?B?N3ZZNUdIT0V2NDVHbC9tU2NWc3p1VURsZnc0ZUhlMFdhdWdyaDZQVDR1VkxR?=
 =?utf-8?B?L2xXUjU3K3I3TUdXdTBQYWFXczErQjZBdHZLSDhYMnFHWWNSWUsvOEZVeE1P?=
 =?utf-8?B?Ukg3bTA5SDV0LzVxRE5UcTl6dkY1Z0pGazY5NnpTVGhiMlc3UWR5QzVhUXBt?=
 =?utf-8?B?L0hKRWdZSFlmampGU012RjEyb3JLbFVUR1VtcXVFMGM5WlkvdFZkR0p3Zkh2?=
 =?utf-8?B?QlcvdmNJWXN4dEdwWUIxeUxzNUVGcTJlVmZON0trQzlTUytuYUNMN1hzZjA0?=
 =?utf-8?B?anRMYzBPWHJQWFUzaUd5RDl2NU9qRUJNRGNwMHFzRDZSRWJvWWcrSkk2ckpt?=
 =?utf-8?B?R1dVSythY2ZlbEpLL0RBZ0tLNDhFZGZIc1ZYdkF5VkhEcXMvTTdHbnJST2RU?=
 =?utf-8?B?R0VwSlFuK1c0SktHSHpjWWlhYUltVHZxa3dVRyttUzM3MEpTYXNtQVorTFhr?=
 =?utf-8?B?TWJwY3hHZytINm56N0JDYm1jdFNJb1V4YjREdW8vUEF3dnhvQ3UwcnZseWUv?=
 =?utf-8?B?Ty8zTVhFK1dqUVp0NitXY25LWThaRnYrcENVYlQ1Z09RTWFHVUNYNG56Yi8z?=
 =?utf-8?B?Qjh4cE5Xa1pUeDBNUEdSSEhWWFNQdnFNQTZKMXZMQTdYR3lHd1M0RUFMSzRi?=
 =?utf-8?B?N3RkSkcrbGxNSER2Q1YyU2owMWNETUFYVDVRaTZNTkFSNFh6cGtoMWNTT2Fz?=
 =?utf-8?B?Qzg5eW1wRFdIVFpROStoQ042bUc1WEhwT2NhbTZEb3ZDbkxJdzVlNEU4RGlP?=
 =?utf-8?B?UHVXLy9NSHpMZzhNY0pDVzVHS1YwNXYvZExvMi9DVlBPUzRpZ0xSc3lGUmcy?=
 =?utf-8?B?dmx2a1ZPbnJRTEUyd1M3bEo0U1ZZYVFEQVRzc3NORzdSTCtHaUdXVC95ajZy?=
 =?utf-8?B?aGlndnJWNnBJT0N0cHZLKzZCMFo4eTA0NWpLSURvcElBWndhbkNJWTZ5MjRT?=
 =?utf-8?B?YkpkOHFRRjNKRXJqVG1QcXQ4emN6bVJ5UGk1MU12ZEd3NWdZWjVHTW1peVA4?=
 =?utf-8?B?cUpwYlRCQkgwajVCdlBackxkZlhURGtady9lQmVTSHNnOGRIb2Fka0kxMGRY?=
 =?utf-8?B?Wm1WTm90MkZyZU1FRzhQZVQ5MzVhQkRKL3EzcnduV24zQ1ZCN3JsanF6a1BQ?=
 =?utf-8?B?TXRadXYvYStQY21WRDIwOGkzcTQvUVRYVUIvcXV2cVhwSk5mUy8yR01pMm00?=
 =?utf-8?B?L0MzNUw2MVRJOHhqYngra1d1QjdRbHVXdCtzZWttZElJNHdTZnZDTFVhT0VH?=
 =?utf-8?B?a09NZnNDb2pVVXRlOCtrNXErekg5Q2Vrd0Q3SWxxUjJ2aFAvYVJSdEd1SDJr?=
 =?utf-8?B?VEtKajVRVUdsd3VzZGxLT1RlRktJQUtNWnJkQ0w5YVNEY2k4RzE3MHVVVWJs?=
 =?utf-8?B?UHZ0Qm9uNXJjSXp3RHZXbWRxcmozWjdVTld3S2ZPSHBWMUkzcWRIU1NPV1BM?=
 =?utf-8?B?eDkwQWlJQ1dRNmpQUlpBeXlIYU9jeXJQRWI4aVAvYjdUbTBzYlV5c2t1Y2sw?=
 =?utf-8?B?RVgzQnFzRDdaQXMxN0FRY1pHS1p4Q0l3KzFsWjM1MDRHbTBLUVlMQTV0SVNG?=
 =?utf-8?B?SFZwSklUUVV0a0hCUXN0NzVmZm1pdWsyaldsdURUMFFSSjQweGRvVXovN1Ro?=
 =?utf-8?B?Z0I1bXBsOTBXTDZKVzdKd015Y3grUHovdEY3TzlBeXdpM2V1cnN3VENIK1ds?=
 =?utf-8?B?OHErTmZpb2NSRjQvUTZNVTRxbVpHZndqa2EzOFh6aG5UZlc4a1FpeEg1ZURN?=
 =?utf-8?B?NmxKTlNxc0tVSVBZSnY3Y015azQ5MmV6MEN0N1kwT0MvY3hrT0RYZjNocXlt?=
 =?utf-8?B?ZlNSZUZDODcxYU40ZEVkQllmY29lVEN0eVQ0ZmJ1b0twc0I1MTMvNjlDOXdK?=
 =?utf-8?B?cXdMWWY0dDhBVUt4dElXZnVSOG43aDNwYVlLazcxeFdHRUphbGRnalZyV000?=
 =?utf-8?Q?LwKUUxbkOro9sHtylxEKLGava?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45970c83-3c56-41ad-3280-08dd67861b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:06:23.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6ouLCMnwBw3hxMUVKg055cGEHiArjYPf9l71lcbmz+Jdrahv/+U7Ahc7kBiIgaBIJTQyZ53t1DxXVUQmVtJNCGff7l1l640wr3wSMXIYfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7173

SGkgS3J6eXN6dG9mLA0KDQo+IA0KPiBnaXQgZ3JlcCBtdWx0aXBsZU9mOg0KPiANCj4gZS5nLg0K
PiBvbmVPZjoNCj4gIC0gbWluaW11bTogNDUNCj4gICAgbWF4aW11bTogLi4uDQo+ICAgIG11bHRp
cGxlT2Y6IDQ1DQo+ICAtIG1pbmltdW06IDE1MDANCj4gICAgbWF4aW11bTogLi4uDQo+ICAgIG11
bHRpcGxlT2Y6IDI1MA0KPiANCj4gPg0KPiA+IExldHMgc2VlIHdoYXQgdGhlIERUIE1haW50YWlu
ZXJzIHNheSwgYnV0IGl0IGNvdWxkIGJlIHlvdSBuZWVkIHR3bw0KPiA+IGRpZmZlcmVudCBjb21w
YXRpYmxlcyBmb3IgbWFjMC8xIHRvIG1hYzIvMyBiZWNhdXNlIHRoZXkgYXJlIG5vdA0KPiA+IGFj
dHVhbGx5IGNvbXBhdGlibGUhIFlvdSBjYW4gdGhlbiBoYXZlIGEgbGlzdCBwZXIgY29tcGF0aWJs
ZS4NCj4gSWYgdGhpcyBpcyB0aGUgb25seSwgKm9ubHkqIGRpZmZlcmVuY2UsIHRoZW4ganVzdCBn
byB3aXRoIHZlbmRvciBwcm9wZXJ0eSBtYXRjaGluZw0KPiByZWdpc3RlciB2YWx1ZS4uLiBidXQg
b2gsIHdhaXQsIGhvdyBwZXJzb24gcmVhZGluZyBhbmQgd3JpdGluZyB0aGUgRFRTIHdvdWxkDQo+
IHVuZGVyc3RhbmQgaWYgIjB4MiIgbWVhbnMgOTAgcHMgb3IgMTc1MCBwcz8gSSBkb24ndCBzZWUg
aG93IHRoZSBvcmlnaW5hbA0KPiBiaW5kaW5nIHdhcyBoZWxwaW5nIGhlcmUgaW4gdG90YWwuIEp1
c3QgbW92aW5nIHRoZSBidXJkZW4gZnJvbSBkcml2ZXINCj4gZGV2ZWxvcGVyIHRvIERUUyBkZXZl
bG9wZXIuIDovDQo+IA0KPiBJZiBkaWZmZXJlbnQgaW5zdGFuY2VzIGFyZSBub3QgdGhlIHNhbWUs
IG1lYW5zIHRoZSBkZXZpY2VzIGFyZSBub3QgdGhlIHNhbWUsIHNvDQo+IHR3byBjb21wYXRpYmxl
cyBzZWVtIHJlYXNvbmFibGUuDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBhbmQgaW5mb3Jt
YXRpb24uDQpXZSB3aWxsIG1vZGlmeSB0aGlzIHNlY3Rpb24gYnkgYWRkaW5nIG1vcmUgZGVzY3Jp
cHRpb25zIGFuZCByZWZlcmVuY2luZyBvdGhlciB5YW1sLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

