Return-Path: <netdev+bounces-146114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738EE9D1F9D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 06:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD64B20E42
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185B149C57;
	Tue, 19 Nov 2024 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="PMZGiJYH"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021108.outbound.protection.outlook.com [52.101.129.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9062563;
	Tue, 19 Nov 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731994550; cv=fail; b=hqgM298XnoWs0N5R9Fgzxw9MqfYUkO0n+UDb1C/pfP+a7gAno1lf0Kl0xTjtnf3GIX1xYjCtxUW6d4RurJCQuQ/A/lPbLyq9NnAJeyqDAd4bxUuODjYLhh5QE3HG4biBAJoxnccXOvcJ2wT0hg7nZdTbQeWaibZwBXcqxlLR5O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731994550; c=relaxed/simple;
	bh=6pCbOoyvyBX8zP7uflppEdhmXZQOyd2PEZpqOMT1vRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOWB95jNT30JgV/LJbX2xOPSkLMWQ0iryj6Liiqil4yWPZ5M3aYg8u6NGjJxI9P6f+GE/t3IlCEqUWN6Cxv0YGQ3mBlHyYe3lJNc5SKnE5S0fU0riEAN3MVtTXPxadN0wA/BAWvMnrwjQRhe84j8tLV9+bk4/r8kuxs08r8RDsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=PMZGiJYH; arc=fail smtp.client-ip=52.101.129.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNslm8M92BoDO7f2jHR/6c6SFV7vUeTRrux6CU3n+ali/fOscg9eFCwk+opQGQBHgSBvKJGeQ+Y/QYzOTnOU3vpAGHroNhb6urdQ+gQRNrD7WzKVC2KTsvLVKd18lTB5B0RqFUlDrwZJNJ1o/rk0atTbMrctYJ2frx85Fl10ouXZ/1b3mIMZ6VBCVzqYsgakYv7qo6UY8LljlMMt8O+AHM1ueIhXB9zf5hZkNy2DJ71ElhRmook9ShrLWb8UpIW5J4Fd1BfjLW+D8eRQG+e+BKqcI0RAtWyQ81UAPKXjMsDyBDlO4MSRytUO/B7n7He8CPFS7nUbNuCn9bA8oSD+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pCbOoyvyBX8zP7uflppEdhmXZQOyd2PEZpqOMT1vRs=;
 b=RtbjG5aot7HSBUCyiZ0RsqaQsbx6N95OhyKrW5cGn0HyD5Fdx4QSyhUPBz0bZyX0xgGQ0ethmJYKRE0Bm/pX/ZgfL7p3zbAi0g7hHZ3RFrS/T15iPyI0G/d7ORNf0qspffmZNqqEsOtNEk0PIWt3GnNCORnX+VyrJvap4sYTHhFKh4woIjkjPK9ShyKUxJvich5SEsfqG/xCKoSydfAHb1+0CYFMv3fBt5i5GhIHIKDlTH8hxw2PyjK2SQAD0J+HCmHlGodct43ia1RyRWBeq+5GyCafUMDvAxZZ8zAcuHL86vOWdQdqNGIT1kr8kWd7Mw+itGpRabwqRcwqw/CJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pCbOoyvyBX8zP7uflppEdhmXZQOyd2PEZpqOMT1vRs=;
 b=PMZGiJYHrUlwXZ5wUxZjxKHwem0Lhy8nIbjDWPckE03Cd5tumgdjk/dZUPIV32z8MJadeOHI3rgnVIzNwVhDs4ITvt/NPnXSbSrQZT9ExjrY3za86vSC8PzyZAVm2sphRKZZcCkvCGh0Wl83+9rzSVqBUejHeQFg1z9PbTtaCLPhT/bJBAsyY6gl2tFU6pwEqFGUGy6+KkfK+TjoPejvU4ZeaFK6Mhs34n4JwRAoYj2sd6YhIMRp4U8y8J61w1YXOLcLTDip95pE8hUaAfSPnssP9RgG72lillH5gNiS/pdWk3AaCXrq68BFarlOiH8GGh/ZV3gDR1aEvK1a+MXzzA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by OSQPR06MB7201.apcprd06.prod.outlook.com (2603:1096:604:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Tue, 19 Nov
 2024 05:35:40 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 05:35:40 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDAvM10gQWRkIEFzcGVlZCBHNyBNRElPIHN1cHBvcnQ=?=
Thread-Topic: [net-next 0/3] Add Aspeed G7 MDIO support
Thread-Index: AQHbOadJpi6fxSNzsUeMszvV5wuaILK912EAgAA8lWA=
Date: Tue, 19 Nov 2024 05:35:40 +0000
Message-ID:
 <SEYPR06MB513475D2B233EA9BDF52AD259D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
In-Reply-To: <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|OSQPR06MB7201:EE_
x-ms-office365-filtering-correlation-id: 31eb9b20-0648-4909-d863-08dd085c0115
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?VkRDNEtJK3BEd3lVU2RqTnp0dXVrM3dHYmJBRmltdmVmcXU2ajdKWjVyZVRHZkFa?=
 =?big5?B?TTdEV0lacGprWEVYdTBZaFhPUDl6TWRRUzVPTHZ2VkFZTDA1dW1yVlJ0cGZFYXlB?=
 =?big5?B?Rm1PVjIvZWVqVk1PKzI5NzZjY1MvRWlTb3dCQS9pY2hlbWs5dkdHaGNzUDVieGd5?=
 =?big5?B?T25jWGJVS2gybEhXYUVBSWpFQ2FqUEV6dmI1TTZxTHlZY2dqaWRrcFplSWllQkk4?=
 =?big5?B?b29OWEsvbThoS2dsRnV2a3pnNkFwdzlqTzZkRmgxaU1XQllESGkyQW5lUUhXWFZh?=
 =?big5?B?ajVvcUVVSGNaMHNnZUZoWFlVY2xLQkMyRGtLRnpUd2IzeUc4NENod2RDTyt5K3Q5?=
 =?big5?B?SDVTb3JLcTE5R3FZSStzaXA3MDZLZGZPb2NwSEowZXQ3VUg3M1haQTFHSFZrWnFU?=
 =?big5?B?SFhlN3FsTHBodVlLdnYrU3lSajg1b3N5S2pzcm00bVN5NndkQTlPV2txb3l6dmtn?=
 =?big5?B?UGZDNmxhdjR5dkw2RWpZS2VMZThwRHNPSlJQZUJ3OE1VQjVKRVFTdEwydURjdk1K?=
 =?big5?B?L00vZ2dTRyt6d0JxaEE2MEhaNkRzS0ozVENDRXpmMkYxOVAzdkQ0MmRuNnNYb0Rj?=
 =?big5?B?d08zaW83T0hvOVN4RkRyRHZSSVQ3c3ZWOGV1K0NSV1VqMFg0VS9leEZUaGVwTTla?=
 =?big5?B?VnVSbHFCVVF2WHMvZ0RIbER3UHhsbzExM1hHUk52bUJRZ2IzR0xpWDA5dnRaQjJT?=
 =?big5?B?U1ZGZnRDZG9GcGZTMlp1cnA4YW5LMDBqUHBmSkVNWmRmT0hPakk0cW50MzdVYXlr?=
 =?big5?B?KytDNkZjVkw5YTVGVmxLd2EyelUyOXRERWxlM3BFWVl0VjZ2MzZxYmZRZkNuc3Zp?=
 =?big5?B?WHRWYS9RaTRFdmdwZEtSb1ZvZ0RHOVZjNlBKM08rYXJIOEhuTnh3UU5LTlpjaWR4?=
 =?big5?B?VkNGZXk3bTYwemVObWZscGlIRzRMRFk4dEhPTHpZYWYvOUxlMWovL0ZQUVF6UXQ2?=
 =?big5?B?eXZLckpPVVJvQSt1U1MyM1JmeGZiQXliMU44cGZnNFBFRUsrNklNZGZMZk1yNGgy?=
 =?big5?B?M3dNQlF3RCs2UlJ3R0U3K3pQQXFIbnFmRU04bDErSytPNG5aTmhCdEdPeGRENjdB?=
 =?big5?B?UndtUmFwMUg2K2JwVlhVYm93akpKNjBaOEtvMnB3MFkwQ25mUG1idDh2U2ZCbGwv?=
 =?big5?B?TWhPL1J2ckRVTFVxVWxWTG9Hc3NNTXZoODJRM01xbHNBU1UySWlnMjU1Q2ptbFZv?=
 =?big5?B?QWkrYmRsaHJNODhCU0FTYXRqNVZkQ0JiYWI0aGZjUWlaK0QyVGJuS2Q2cENPREZK?=
 =?big5?B?dGpaZzc1T3EwQlhJVzc1UHZxZVlqZDByQkl5UzNkNmg0MnhBK1pWNEwveWMreWgz?=
 =?big5?B?Z1VycjFPKzdTTUJSY0xWd1FEMGVWbEZBWkdQNXV3Y3I2ajBkL0p3ejlmTFlOdzRS?=
 =?big5?B?MUIvODR1WmV0Z2Q4Ykl0ZWFyeXFOclg5aVpuQks5STY0WDJCREJrSTk5aUVBcEsr?=
 =?big5?B?eGlQS28vd1Q2TjN1REdxbVhCejc3Z3ZJbXN3OEFVTG1XTCthZUYraXg4V1VSekZ6?=
 =?big5?B?bzNXWnNmM29WQ0IyYUppN2tkbHpnRWMrY1J3cXc0MW9LSmRXa3Q1K09XWmdFMVU1?=
 =?big5?B?UmtIVXFlM1oyT1dNOWwvQTFMYmNSeWk5WjhOV3VNd0MrZlRsL0pEanNOQWxrVVh0?=
 =?big5?B?ZHdTVFNmeWJmblpyV0NEdU9tTGZsV3pYTVp0RndXc25Vek91S0RzK1oyY09mc0ZZ?=
 =?big5?Q?Lo5ZUkb/mZHkEVkbMgbQDdeLGUBSM//+IIYUbWxwr+U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?UDF0OThoZFdVOVhvaTVlYVhpRjBwaTZDdEdEdUhmcjlheGc4dnM1aU85eE9FZHBJ?=
 =?big5?B?d0RTTlRKSFB4UU5uc1VPa2lRdGtsUWRva2Z5SVpQZjkrbDBPRU1ZNHJldjdRVnpP?=
 =?big5?B?VC9VMzVNQm9QNzZkTDhmaFRNUXlUWDcxRVYyUDFEYkZHa2luOHZNTzBaRXBPV0lI?=
 =?big5?B?SXd0RmNVSUhuNmtYYjk2cGVId29pZllzM0dDQ1FQWEpCQkhkZ28xT2F0bi9yTnJw?=
 =?big5?B?YytpL3NmRDVZcm1pQlBaVnNGRkNRMU16cml5Tkw4NGx6c01NVUl0R1pLcG9rU3dN?=
 =?big5?B?ZHgrNDVWWEFvKzEydkJaTnYrRlVEVFVQMlFpMzVYYllydzRkS1BlZ1VSUmNOZTlj?=
 =?big5?B?UHB4QTBqd21LMFZaMDNNQ2RnRFhPQ3NOVXlWb0QxanFhTVJ3dHFvUVlmMklmbEZV?=
 =?big5?B?UEdweDlWbWZiQ2Rha0V0OTNxNXVOTkNmamRYK1h6ZzBBdFptMGFiemZLQk1QS1FN?=
 =?big5?B?MW0vbVExSTIwc0s4bnNiM04yZmwzeGFjOWF6czVUMjZucU5OREdvMmRoTmxxVlRh?=
 =?big5?B?NWEreWtQdkN4Y21tQlViNnZYZ0hGQWUrQXVJK3dlWVZJK2hISjBnV292WVVFZ1Fj?=
 =?big5?B?aGVBZXZEMy81U05zdTdsdEFMWWZSZk1WZWhDVWovb1YzLy9ETGRJbnBwTkhhU2M4?=
 =?big5?B?Q0lEOHFHdkFEUE1aSE9waDRkZFMwTVJaRFh2RGM5MDNqQm9acDFUeThRc3VERzcw?=
 =?big5?B?VkpkZDBmaDQrcUFpUHZKMjI1NGhITzI3S2J4eW1QTUNuazQ0SXJjYkR3M3B0Sk0z?=
 =?big5?B?amFEYnJpbFhwZG5hSlRXV0xGaVVOUzg3WWRpTThMWllqSFErWS9BVVZMOFRuLzFO?=
 =?big5?B?ck05dXBCQ3d1SXlWSUI5Nk43RkM2M3lvNGdKcTFBdlk2RzNab29WWWlFYnJMbndC?=
 =?big5?B?UHN2U1dob1dlemNIclY3UjFHdHY3NHdVWHhUb2g0aUhncndybUZNQjNadkZHekpW?=
 =?big5?B?YTNkQW5rYzkrRXNQRmQ3MXdReUsxaEZTNHU4MUVtek9aSU1oT3k0djFnQyttWFpK?=
 =?big5?B?ajNoTFVmUnI2bVhHWHpRcWlnUUNzT3lUQWNnamZVWjRwb01yeDhqamFvd0lwdzh1?=
 =?big5?B?ekRnQXNRTXp2Vm5ZMnlBVVgrcGFwaWR1cWJiMThLbkF6ZEhQZVI1aU5IVFlaR1lT?=
 =?big5?B?NTVNSGwvcWpvMEZ6UlAybkdqalhoL0lKNGNOVHdJYjYraTRFSi8yeGdMajBhZTJt?=
 =?big5?B?alBJWi92TkMvWFlNSHZFYUdWMGcyYnNjNXNmYVdVUS9scG52eHpXM0luTUZKYlFO?=
 =?big5?B?c0Q3NWlWZCsxZ0tWN0dTNEcwTmx1ekFxckpQR1RvYUNDa2p3OVp4Z3pTWjJXT3RJ?=
 =?big5?B?akNld1JpNk12OEJvcGFrTXBOMEVPUGlVUCt4T1hFc3J0aXRLMkxWaklzMEcrMjJE?=
 =?big5?B?ckpZdXk2WTErMTVYMzZHcDRDUG9XRWNJUGFmQWV3L3dNeFpCY0t2c2RkRnFDSGVs?=
 =?big5?B?dm1aSmFyMUJrdnA1QUJDZDhiNWVkTWIvZ3JsVDh1NldFRXhtNEZ6SHE3QUVVL2l6?=
 =?big5?B?WkV2OTcxZWcyWmkzblJ2UjFlcEdHemROaVlkWjY2ZTJLOGUvL1hkNzRSczF0TjdE?=
 =?big5?B?dmw2em1aSGZkbS9mWG16V01oUE93dG9GZGVVTmlXY3R1L3V1Y2Qzb2VpZnY4L3FW?=
 =?big5?B?UTUyYzRrdTJxd2RVaW9tTWRNVHBFOER3UzkvNU5FMWkwVFRPUWtkR2tNdnMrSFFL?=
 =?big5?B?bjNjOFA1eDc3SUM3QXhoRlAzMTdRaDVza1RIZXJHVDBOaVcvejRta3ZCSjFWKzJr?=
 =?big5?B?Witsc1BLMUNtd3N6OXN5eFVlNVFSZE00ajdhK09KVkZ4WUxOcHBHM05GbEJiRGha?=
 =?big5?B?ZGZlc3R3akZUc3ArSGxHemoxak9rQTFUejFOaVlQVzB5T2dHSFF0Sk5wTDk5MW0z?=
 =?big5?B?NkRER3ZGeTlrcmpMQ3lUdVUzN2M4OFJ2elk3NXVGTk9lam1POWwxQlpPczFJZ2lL?=
 =?big5?B?SER2RU5ET21FNGV4amN2Y25LT0xwSUNGdHZrYmIzT1JIYk9HdFlpZUw2c3FTYm14?=
 =?big5?B?SHNrdERXd1V3Qmh5S1NUR0luQUtPVC9QdlBjMXBLS0d3NVRRaHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eb9b20-0648-4909-d863-08dd085c0115
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:35:40.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ew6tBQ0VZ8mtJ8inZNFjiF7Wh0YQEwGdYvGutNH7e6lz/zitIl+dBm/2NjOxz/So3mzxaShAThnbLs8TIuYQlWGNb9jM5fofLwh2FE32N3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7201

SGkgQW5kcmV3IEx1bm4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gVGhlIEFz
cGVlZCA3dGggZ2VuZXJhdGlvbiBTb0MgZmVhdHVyZXMgdGhyZWUgTURJTyBjb250cm9sbGVycy4N
Cj4gPiBUaGUgZGVzaWduIG9mIEFTVDI3MDAgTURJTyBjb250cm9sbGVyIGlzIHRoZSBzYW1lIGFz
IEFTVDI2MDAuDQo+IA0KPiBJZiB0aGV5IGFyZSBpZGVudGljYWwsIHdoeSBkbyB5b3UgbmVlZCBh
IG5ldyBjb21wYXRpYmxlPw0KDQpXZSB3YW50IGNvbnNpc3RlbnQgbmFtaW5nIGluIHRoZSBEVFMg
b2YgdGhlIG5ldyBTb0MsIGV2ZW4gaWYgSXRzIA0KZGVzaWduIGlzIHRoZSBzYW1lIGFzIHRoZSBv
bGRlciBTb0MuDQoNClRoYW5rcywNCkphY2t5DQo=

