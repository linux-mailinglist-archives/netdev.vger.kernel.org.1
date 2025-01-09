Return-Path: <netdev+bounces-156645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB8A0734D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B57A1F63
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13E2163A0;
	Thu,  9 Jan 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="PMuDI3fr"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BD216397;
	Thu,  9 Jan 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418810; cv=fail; b=s6hIhw6PXvpjY6IqrXZDmn/phwERU21hn3L48nZmYRUOzv4YE2vya2JEWDP4JRHnvDJL4JnqV+ODrCZoG/wAzcLLu6XX+LomDmw89FbAmLfEUL3rW7XwuCXr8KgFgn0k0KszR/a9mAW7+fFkPsSkZWoz8YIvet0kBMoVX472sn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418810; c=relaxed/simple;
	bh=HYEeul6B3x4Jxe1kWbtwZ7O0+30C2HHCpUEyvi8rZd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a5zp2/M0smGBtwjhR+eSjELKkrjt7r/aeBsn8AN8K6yTB3uRc/WbKBRDdfwuCIudBsQ179YVn46aQKbcD4C5UmFEyEfzSzubiQw6scZrzIKGKkw7Y5NXDTacz8yLiovPzctph13xTAu0KzFnzitBkjxKx/Slku7HXLQzkhJ3M8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=PMuDI3fr; arc=fail smtp.client-ip=40.107.117.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj8Q79cHRTYmrDzy7uzbsCUQOJN37nNciuy6ZlIKSffrkR83gx/8xg4/QHO8XpKA+nwG7W63ss0Ypp1WY+sz6fxMoXaDxW0pIuGp2RjfNDVVuWev8cFpJPF2Ocv3675rJhEGw1T735reZKM3LLJlxkPAnIHuTBPhZRlrb/R9mOa6/PHyKJiZBdt+6QOe1hy5nNwYDYu2X/9ILPlbIsuuaC3TNfktEpkUJDubN8iX9351V3aJfj05YrdYClsYrJfsI5i6BME2bM9Y8OyX300HNNNZZ85xk4arCq8VK+MsZ+OzUPyvxcACV4XkAcukuS2R4G2t+HAUpQMl5ZxzHOY1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYEeul6B3x4Jxe1kWbtwZ7O0+30C2HHCpUEyvi8rZd0=;
 b=Cmk6uLwiATgr5vEDLKLOnjXjCSNCBX6ZzuzoRkdzZHCHrTgzZARdMReikmx4wFM58NfH3W7Y4YQwsJN/OKR5s3F1nZJ9FB0i0WjBpZAvyTvT8KsjCSEPlkuyPa+JFvkT6rIEo5kHXcrGa5kHLpexd5eJsVNOtSGXpU32Z/TjW21pddOgLv3xxGnaNpnAB8lqsZ+QncNY9PPuSmnhmEMiqQLQLb/oJtrBLdAmQviTb7jaKwHlNknV3w5X2zWP3FZczqUYY1NLewy1ZFPHkIjhqB1uY+/afo5HZcEkbhAENrVaEP+HCdc1Gved/rQGHt744nrex7l1/nVgiXREE5tqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYEeul6B3x4Jxe1kWbtwZ7O0+30C2HHCpUEyvi8rZd0=;
 b=PMuDI3frYscH1jqoRRthh1EsmTsASwSgwAeJQ2f2WeaV3XCWD9g44K33sPdsDIxsXQg0RZw6gZNxqWsDIyfPB7Y6I8L1wasFuS0LcZqjvu0u/J26T7nmUGQe/7U4dJ7mrStRx1UGormHge0y36NqfKuZ/iegnFFgtEwIu0NQn0ZFaxeGLDaAdpJSbc3xwqUeZ0R+NF/oU3ZjSuSSXQ94YIWBbjMFsWkNOEgdh3Bt6xrjr3AHKK/w5UTiiOQewb/vj/GmZrmzP39D47PTLSeHJc/4/Xw7MmAh9uyzk1sQQA0aqVynYW8SmATlnULxP1AoRTSql9xdR1kjd/Cfn3L3ag==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6513.apcprd06.prod.outlook.com (2603:1096:400:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.9; Thu, 9 Jan
 2025 10:33:20 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8335.007; Thu, 9 Jan 2025
 10:33:20 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Ninad Palsule <ninad@linux.ibm.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNwZWVkOiBzeXN0ZW0x?=
 =?big5?Q?:_Add_RGMII_support?=
Thread-Topic: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Thread-Index: AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3A
Date: Thu, 9 Jan 2025 10:33:20 +0000
Message-ID:
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
In-Reply-To: <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6513:EE_
x-ms-office365-filtering-correlation-id: 8da9f795-a645-4473-a854-08dd309909b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?S3RWaWlrdmxhWXNabzVRUTNWZTdvUkFIQVdqTjMzVHJZdDJRWFEzYVRydjZpMG5m?=
 =?big5?B?bXZMbDltSkRLSTB4V3RMYWt2a3RPTVZTSFlzMU1VbStBbEJEbjlDMHorL2ZYTDVJ?=
 =?big5?B?R1dHQmMwUUo5SmFuclBvY2FDMmNHTUVqZkhyNk5tVUVQTGNYM1Fac1hyN1JuYjND?=
 =?big5?B?dHFsUHNBenRUUSswK2k2L1Foc042SllwT1d0L3U4cTFBSlRuaTZhKzE4bVlFS0xl?=
 =?big5?B?eE81eWpMdkI1cWRPWmJaN3kvbWJYZkxKU0VHNzRwdklBQ2Nid0RMUCtMeGNTZkY1?=
 =?big5?B?ZjdmMW9ZQ0NTcnJtVm45cVo3ZTR0dzU0bkZZV0tTVXduZWltUkQ1WHVNcGNBUTMy?=
 =?big5?B?SmNXbDJBanJhWGx0MDBJTWJDOFVGTFBOTTQ4RnZlTWJXQ0lIaWlSZ2tUOXljU3lQ?=
 =?big5?B?TUhWS1R1SVpOcVBmWHVxaGNsaHVGRFh4WmF4ZC90OU10KzAwcnhDSVRoNjdEQ1k5?=
 =?big5?B?ZThNeEFWaGRPYnFIekd3WTNpeU1PaURRdmNxbmJTTUk0eWpNcE9xQmdrUTNybGZq?=
 =?big5?B?YmhkZWtlWEVJblNmNWU4eHdiR3dLcEhJNFhzVzh0VUszZUdzWVNtZjM3WlRlNUt0?=
 =?big5?B?ai9wTUIzL1lONlMvVUxnVk1JRTh1ZUFMUHdrUHpReTVMUXo0NGJQUTR3Q2o3WXVQ?=
 =?big5?B?K2hLTnBseEZ4Q0o3bjdRdFkyd1JidWlrc2lNbVBNZ3Zsb0V6V2UwZjVQRkpra2Jw?=
 =?big5?B?SzVtWVFZMElleFZ3bVIwVWlFUWo1eW5xckk3dWl3Z3k3UjFFb21teEZzRktyUzlk?=
 =?big5?B?Wkc5d1d1OUxFUS80RjFiOWtpMDVURm5VQ3U1YUVLQUUxNU5DR1RLRnNkME8ySkk3?=
 =?big5?B?V3FJRVVVNEE5Ymx4K0lTOEdnVHgzUVArdVhidW1tUG5mQXV2UUM4ZmFhOEtQby9I?=
 =?big5?B?RjNlUVJ1eWw4TWtCSEkzQldzZzlWRmJ3NmdXaDBmYUR6Y3ZpVXpydnpjek5FOWZn?=
 =?big5?B?WXQ1Ti9ZZ1BPQzFZMlhncVFTUlRhRGdsUGpudDQxTW0vVnNzTkx6dDA1aEFOV2hW?=
 =?big5?B?cENtQ1hFek9EOWlnZzNxUENCWUt4RVpWWEg3bzJVNHNRUG56STlvZ094OVhZZnRO?=
 =?big5?B?em1SdEF4b0ZPS2J5V1RCYytkMDdSQ3FLWDhwSU9EWUx2TUlya0Y2ZTBGQWc1ZTlS?=
 =?big5?B?MWQxZjJZYkNrWWY5M1FJM3E1SWpYU21EcmpFQ0FKVGxGbjlHUFErS3JQYTRmbXFJ?=
 =?big5?B?K2xlTzlmY1ZNNkV1NTh5YVlzSmdKdWI2d3diYnFTeCtqaExaZktDSmt1RW9DOHBP?=
 =?big5?B?Qnhpek1xOWVTbXlKa3dWOTBmWm1oWmdncEFTcFhFR3BrVEtSRTFyK21pSkJBWU1C?=
 =?big5?B?STAwNmNkVTBtQURFUU5jYUorajNSVmE4aGJ2ZWhveGtqRkhxT3U3QVBLdTE4WkhS?=
 =?big5?B?d0ZyUStjUmRpeUJpN0NPdVllZkhzeDZDZHYraVVNT1YwWGs4SHpRWUNXdmxDbjZa?=
 =?big5?B?UWF0Szh4d3pFQ3dISDVRc08reDNCYWJwZzFaUjVRRVlXdTlUOUtUTHZneDFJL21K?=
 =?big5?B?dmZXZHRDa2I1UFNVU0MwRlFHWEhJQ2J4T1hKcUFrSzRrbUZRSVdLbW5Yd1M4Uzl2?=
 =?big5?B?NU1ES2NNVnhjTzhVaW91a2tYQTdKa1VVakZWc1ZIMzBPN05Ud2RUUDVUQ2l3aDh0?=
 =?big5?B?K0RaSzdzVjQrRzl0R1FwN2l6bzA2OVdTSnJFOWw0UVFqdlZwN251MmRwekdJZlUx?=
 =?big5?B?b2V2RlQyOTFVcTZCODdhYXJNVllKSTB2bWpjMUlSbk1WbUdEZFhjSmlHMnR3STMw?=
 =?big5?Q?aI5T6DDBm4vz1VeE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ODBYUWJxTlVuakJIVHgwaXErbUJuUFJsSFJqbE92WTkrSU5PMmJ2aU83c3I4dWd4?=
 =?big5?B?M0pHdk9QVXVkUEwvQzBKVnpqM1o4MEs4aElwTzJWbkxLVEdIbjRKVTZBNC9DcHo2?=
 =?big5?B?QUN5cVhpZUNRZHlWN1Y3R2tyT2Q5NHR0TDZNQ2FzTk9lOFlVTzFaUk5aL202MWFz?=
 =?big5?B?M3EwWE9TcFgyL01XZVc3cG9HK2dYYVA1WlRyMFJRYWg1azM1aWNHK3FiMEtVSWdu?=
 =?big5?B?d1czZjhaN29PZGN2L3QrVkt0VmtJbUtJbmlzNmxSRDJzYnhlU3JKYTJ1TlkxQ1BI?=
 =?big5?B?NEtFcUVJSGNqYmVHMi9XdnkwN1JpR3Y2V2k3dHBzUkRabnhZYWxROUlQN1U0dVI0?=
 =?big5?B?Qy9YR0o0ZFdYdUwwM0dOYm5zR2NhWU5TTFk2WjVuU2tId09Gb3l6VlU5SndFWUVt?=
 =?big5?B?ZFdzdk01TWNEem1ITnBkYjhGZXIxNXR4NDF0eVg1ZVlhQU44eGlWdHVaU25Vb0V5?=
 =?big5?B?QVJ0WkQ1NVNoQVJzMTM2TW5jZ2M2QjBWOWtpTTY5Y2Y4TUd1dVhWblI1YWpxdGUw?=
 =?big5?B?YjByQzRzM0tFSldxelNhUjR1N3lrcjBxcnp6UzJIZTVXaTVSeGdLcEJUYUwxTlVY?=
 =?big5?B?Yzl1ZVhHekt5aHBJQ3N6RDhkZkdWNCtoVndleGZoTVF4TzUwdEYrcWR2YzBYcC9w?=
 =?big5?B?YXZzMHVqblZObVV5bXowZTJaekdaWklmdDBlS3F0SXo3blJ2Z1BmaEsvT3lNMmp4?=
 =?big5?B?WmtZRWFRRkJoQVpJL3d4QWUxWVg2YTZ6TmlGdDVDbnVCN25BOEE5eU8wbWtLa291?=
 =?big5?B?R3pXdXpFZFE1MDZHU3FmeUo2ZmNjcFJBbnR4SlQ2UXBGQ2d6N0VUOHRuK2U5cDJn?=
 =?big5?B?blNVK2w3NTdJakR5WS9FZjJ4Q1diaTJzckdTZVQvazQrTlFvbWFEVXhlU2d6clR1?=
 =?big5?B?SHhmcnF1bW5mL1pCQjBzc2duVGR1NzZmWEgxQi9zYjFKVDZRSEJRUmFCYmtwOHVW?=
 =?big5?B?OFNoTHE4Um9UNWVoR2ZreFRuWVB4VTMvWVBRQk5CR3VRTmtNcXRhdHZmVkdBTWt1?=
 =?big5?B?K29meGVPMG51bUNucDBBRGhYUllUSUVjd3AyZDVGa09uNFhVWElkUXNTNFhra1Zu?=
 =?big5?B?cXpVbXpFSG1aV25oYWFTbHgwb055Njc1cGZRWVkyS3ZBcVpLd2hWQ1dVTVFCRFBU?=
 =?big5?B?RmFOYTFkdzNicFZFbGhucFVhTWJkak43TWRwZTF5aXhMSkdWYnU0YlYzQnlzRUU1?=
 =?big5?B?N2pzRnp0UkhKcHhpcFlIS3FDVmRRZk5HMEhsdiswRHRSTFFNL1JJbmtndzNBb0ls?=
 =?big5?B?THdaL3owTDdlb3NRVmJlV2prSDNzSlUvVWU5cmM2ejgwb3JPOU5tRXZaZjlFSVpl?=
 =?big5?B?STRveXhiS0U0dXZkZmVaU21VUW83MGgvWm1uekpGYk5INENrczI3VFQwVVdQVFNq?=
 =?big5?B?TTFGeVlnVEQzTGdBSVVBOXZUcDNkK0VUeXhsbEJ0VG1kWUM3Z1c1QUFrdEMrdXBR?=
 =?big5?B?TmsvKzhHRFpuVE8vL1JuNlRQekFiM0dpR25YS0VzRVB0TllXc3l0YjMyWXpYbjJm?=
 =?big5?B?djhlV0RFZlRmU3RrZGNtWlNsejcvaVlSS25tTktNVGx0empCdnlDU1QrbWU5Nlhl?=
 =?big5?B?TWhIdWE3bURySkNrSUhUeTRWMkR2NGdoWHZzSWNPTVhoc05PaVhmeWREYXEwR2hn?=
 =?big5?B?V1B6OGI0UEtjSFZsQmdCdFg1SE9GUFpLem1tR0d1VWQ4Wks5Wm4xUWhCc2dHWUR6?=
 =?big5?B?WlgwSDBLVVIzb3hkUGljbGd4enRiaEhramdjdUNlb0F5SzQ2eENBZkNBYnBDSVhV?=
 =?big5?B?UUxidVI2L2lnMWJNMlpmSnUydE5IbjFlYk9YNjdKMmNNV2xHenVJbEZ3dm9FRGdC?=
 =?big5?B?ZWk0cFZNcll5cVlMYmRjY0FUTTV6TEk1eWhneXdqb0RLdjRUeFNQRkR5K2s5YXZn?=
 =?big5?B?d3ptcnBZdE5JOXVNRklFS3d0b0FtK0J4bU5NdUMrbzJ4a2EyS2c4bDRWTzZGT1kz?=
 =?big5?B?V2xVNTNid2w0ZWhRN21wM1RxSVlPVWNveGRZcnlSdFB2ZTA1c2wzNGRjeWNZamFP?=
 =?big5?Q?KM6L1A1c0NxNPVPd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da9f795-a645-4473-a854-08dd309909b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 10:33:20.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QthDJUDpsDu7sk0aTARdlic7koCE3uk5ICezUFFsDfjS1//p5EmXsK9sG3kd5jr+aeoXmJkQ+ogdRcm4NZLV7M2l6HA7eWrCX3wPG4cRNF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6513

SGkgQW5kcmV3LA0KDQo+ID4gVGhlcmUgYXJlIGFyb3VuZCAxMSBib2FyZHMgaW4gQXNwZWVkIFNP
QyB3aXRoIHBoeS1tb2RlIHNldCB0byAicmdtaWkiDQo+ID4gKHNvbWUgb2YgdGhlbSBhcmUgbWFj
MCYxIGFuZCBvdGhlcnMgYXJlIG1hYzImMykuICJyZ21paS1yeGlkIiBpcyBvbmx5DQo+IG1pbmUu
DQo+ID4NCj4gPiBObyBvbmUgaW4gYXNwZWVkIFNPQyB1c2luZyAicmdtaWktaWQiLg0KPiANCj4g
Ty5LLCBzbyB3ZSBoYXZlIHRvIGJlIGNhcmVmdWwgaG93IHdlIGZpeCB0aGlzLiBCdXQgdGhlIGZh
Y3QgdGhleSBhcmUgYWxsIGVxdWFsbHkNCj4gYnJva2VuIG1pZ2h0IGhlbHAgaGVyZS4NCj4gDQo+
ID4gPiBIdW1tLCBpbnRlcmVzdGluZy4gTG9va2luZyBhdCBmdGdtYWMxMDAuYywgaSBkb24ndCBz
ZWUgd2hlcmUgeW91DQo+ID4gPiBjb25maWd1cmUgdGhlIFJHTUlJIGRlbGF5cyBpbiB0aGUgTUFD
Pw0KPiANCj4gVGhpcyBpcyBnb2luZyB0byBiZSBpbXBvcnRhbnQuIEhvdyBhcmUgZGVsYXlzIGNv
bmZpZ3VyZWQgaWYgdGhleSBhcmUgbm90IGluIHRoZQ0KPiBNQUMgZHJpdmVyPw0KDQpUaGUgUkdN
SUkgZGVsYXkgaXMgYWRqdXN0ZWQgb24gY2xrLWFzdDI2MDAgZHJpdmVyLiBQbGVhc2UgcmVmZXIg
dG8gdGhlIGZvbGxvd2luZyBsaW5rLg0KaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1D
L2xpbnV4L2Jsb2IvZjUyYTBjZjdjNDc1ZGM1NzY0ODJkYjQ2NzU5ZTJkODU0YzFmMzZlNC9kcml2
ZXJzL2Nsay9jbGstYXN0MjYwMC5jI0wxMDA4DQoNCldlIHJlY2VudGx5IHBsYW4gdG8gdXBzdHJl
YW0gdG8gbWFpbmxpbmUgdGhpcyBwYXJ0IGFib3V0IHRoZSBSR01JSSBkZWxheSBjb25maWd1cmF0
aW9uLg0KQWxsIE1BQyBSR01JSSBkZWxheSBvZiBhc3QyNjAwIGFyZSBjb25maWd1cmVkIG9uIHRo
ZSBTQ1UgcmVnaXN0ZXIuDQpBcyBtZW50aW9uZWQgYmVmb3JlLCB3ZSB3b3VsZCBsaWtlIHRvIGNv
bmZpZ3VyZSB0aGUgUkdNSUkgVFgvUlggZGVsYXkgb24gQk1DIHNpZGUuDQpUaGVyZWZvcmUsIHdl
IHVzZSB0aGUgInJnbWlpIiBhbmQgInJnbWlpLXJ4aWQiIGFzIHRoZSByZWNvbW1lbmRhdGlvbiBm
b3Igb3VyIGRlc2lnbi4NCg0KVGhhbmtzLA0KSmFja3kNCg==

