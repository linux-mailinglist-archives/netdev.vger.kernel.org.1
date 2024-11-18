Return-Path: <netdev+bounces-145781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD79D0BE2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF5C282B62
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154E17DE2D;
	Mon, 18 Nov 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gayedl80"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16118E1A;
	Mon, 18 Nov 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922622; cv=fail; b=aDZY0USTm+lcniRE/PG6gg9BTCbe6AqbwbO6hDGhNZLg2V1/enJH0s+tPK6XMxErCfzXtIIeooyFW6BmVnSeMF/ocKJVEl1vvMHDr5sK5I89AI2wWpBoLIoDTUk9HmwUgSMcuJ2JXKhlH7wMRwvRTua7+/r7WCN2yhDj11sFCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922622; c=relaxed/simple;
	bh=BoRYm7/P3UWPa/4Rm3NsIS40GkmsXJKImtukO5JXQJ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtOva+P4MFDj25ItmOagsJ9ot20bDmgCtqR2fjTULoh+LsCY5k8SJA1VsoMd+l1xkiOBMU6qp408bDze89aLBUZdpJMkD7VHQq5qo/KSqhrARhp9BiraC6KNQYsvRV5ojaZcX2zht3pGaEU+/bO7/DWlk8AheEnKzACAi0lEx5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gayedl80; arc=fail smtp.client-ip=40.107.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzMmsQ2Zzja66reOZgl/XLCb6SIlr0QnN1bumX5RJCY32oiNjzSHSwI0nuzzro+0WjflALPjArcdjBMUP3yx8BhPYUWj07VohJ/E94wnOSh6aWGZaAIyjX8BZ3BG1Ghtf6SrOTMP5y0UO7PP+8QnWgwwKTq+ZUsOQG4SUS2OqnxXAg144YnhzasdnSfi36ovmUHMB/b59M6drFGCh5UNdGuGkMta3Fpi19rJfjLOjaVFWqlxJ7YlNGITLne6XRPmT9xXLjB01gikgCMoHuk5zey1fS7o3vjci6sh33v6RVqAFQtx+Dk+h5ZD5vvd91UOTNoyH+rDRQq4LZ3ABiylgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoRYm7/P3UWPa/4Rm3NsIS40GkmsXJKImtukO5JXQJ8=;
 b=cyvXNMfgGHAEwR2jZPT8STOKo8xACGd7krAPB8N2wbSDLj9HWz8YS7xLHVaKL1UJBYyrukKc2Vtw+3XEkZhnJVXnDZUI3SXGzxezt+yIc4En+FJVUPVVN2EQisiq/GmGEk4HbvbTwNiKjMwOGsdfuT4wUurJtkdO0j14es83M+l5CA+JE9jcEkpN7VTg6y6UdYQ083Ijk57MQNtO1zIIVxPrZBF+c4N8FgyB0krMBzEs6vPFsYzYajlMWGFLl69gFnfqjaez0uVV8G6as50SyYclSb9a+kwNzUNsERYRmoAmKbDGDgYJCzBvo+JSe8uPtqrgHl102DmrJOlF4C9XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoRYm7/P3UWPa/4Rm3NsIS40GkmsXJKImtukO5JXQJ8=;
 b=gayedl80KevOOK5BRdqz5IS41J3xTH2XUpAzY4kQvkywHIO956RQpwH2at/21xwux/xdFsV4N35Q3tELgoYghXb6GTjcWiqThQkxmHtCTgD4IYqeX42EvjLqX/neXS01xhw2iJ4EkBKxja5gm8WR2naT4DjQzxxP4gS+N/740nueoA+BXTrjpVrQtQr1CSvU0yev8tywl6IcGdne4Ll9Ssisa852OB5Gsbli382NnrKHMmwDbRKS/xCC4WgZg+7AhwIoLufgLfIlfHf2jS7cou5gjBpPK8ML1CJB4RJHZVf1hYiWUUsWopCTXQfpM9ut4IYEvNPDdHUlrdjTLV6fpw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5530.apcprd06.prod.outlook.com (2603:1096:400:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 09:36:53 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 09:36:51 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Arnd Bergmann <arnd@arndb.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Netdev <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IHYyIDUvN10gbmV0OiBmdGdtYWMxMDA6IGFkZCBwaW4g?=
 =?big5?Q?strap_configuration_for_AST2700?=
Thread-Topic: [net-next v2 5/7] net: ftgmac100: add pin strap configuration
 for AST2700
Thread-Index: AQHbOX9rzBlSwC3uvkmC3zGSsduGfrK8lNCAgAAT/YCAABX9gIAABxcA
Date: Mon, 18 Nov 2024 09:36:51 +0000
Message-ID:
 <SEYPR06MB5134034FACBE7D7B9DCC67AF9D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-6-jacky_chou@aspeedtech.com>
 <4b1a9090-4134-4f77-a380-5ead03fd8ba8@app.fastmail.com>
 <SEYPR06MB51341859052E393D404F4E519D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e0ad34dc-cc11-428e-8bf0-c764612452e0@app.fastmail.com>
In-Reply-To: <e0ad34dc-cc11-428e-8bf0-c764612452e0@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5530:EE_
x-ms-office365-filtering-correlation-id: 3739a5bb-86bd-41a9-18f0-08dd07b487e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?QVJ0QW91WUpqalZCU1llNzhYZWkrRFprbElHdU9VcE1rRDdJZmtPZ1FYejhwZGFn?=
 =?big5?B?YnpiV1doL0pFd2NzRkNXVE0rWmVrR2g3b0NRNENGWTliWTI1bjNrWFlQWVhHNXZJ?=
 =?big5?B?QXZTUEZoWW83dkVQVXduanducHY5cGNYU05jcW02bUxFTnpaMDFxVGtEblJKZVZX?=
 =?big5?B?dTVBdmVWeEY0YnBHeTVhYzNCQU5GNUhXbm84TnNHaUljc0V6TGdnMzhhNjAxWDRl?=
 =?big5?B?dW5VU25ad0xRdjZxVUtsbUV5SG54RFhrKzZ6aFJnQ3FQTW1VanYyZ1NlNHF2MWZF?=
 =?big5?B?Q2huYkZDcTdpZzVlbmt2SXBGdUsraW56eGFxczNSRkpaZXFjWlFkK0R2NzFOdk9I?=
 =?big5?B?T0FGL1RaNGkvTm1lWU9yUlFyUHVMREp1SGFYa1J2Q2J4Vm9hMlBuV2x1QW9RQjhx?=
 =?big5?B?VHlwZlN3TDQxL1QzcnVHQmdTRnBtOHhCc3pwQmR1WnQ1M0c3cmhlZTluR0xjTnFV?=
 =?big5?B?QkloMXE0ZU5CbGU1MG04TTlrQXRIVDBFT1lYY3FIQklRYnRIOGp1bytRZ2RtT1RN?=
 =?big5?B?TXluSUQxSGtxUzFwY3lQVXpLNjA2dU04WHVkaU1TME1uNVpKMWNnYWo4OXhqV0dF?=
 =?big5?B?RVlIMHRZaWQ0dGR1OXc2cnkzSmp5QmJ2UWdBODZrblRUVllqQW5OeVh6VGlFaDRt?=
 =?big5?B?S2xVVlZYeTcvcXNobmFRQ2pteVBweFZBY0szTDN1K3FuTHhVdFRuemZMY0NHbjVV?=
 =?big5?B?aEFrTzdHd1pwZGZYb2w3NkxtaEttTFdWUVllREhUNjJKT3FjVkcvdDl4NDhJQ0Z1?=
 =?big5?B?dzg4RmJKQzcxTG9oWXE1YmowN2ZBUVYrZmZIVDZOZi8wa0xpZFFQK0hJNWpXSFN3?=
 =?big5?B?eEwxM05XbHF2Y3JQMWhEdGVLMUVDVTdTNTBuelRDRkpGcGlsODhaSlVMeFVtTjl2?=
 =?big5?B?NnlGcDU1a2YzL1dNam9iYWpXVlYvRndQMzAwMi9rOVFsaEJucGU1VDd2ckppUHNW?=
 =?big5?B?MGhsZGdVdlhlSHd6SkM3aVhCUHl5SVRSMHFPYkF4SGNWSWxybk10K0I1cWx5SVor?=
 =?big5?B?L1BZaXlOTWlyaEpESy92VUN5N2VGSS93NUpEU0xuaUxzc3ptY1VUVTRwTFREUGtR?=
 =?big5?B?RWIyelhZZVhVMFZjV0RYM0tXWEQ1SFV5cmw3di9MZlNiTUFKdC95VFZHZm41SElL?=
 =?big5?B?M2pXMmUvOGloR1JzYmFxc2pLK1pDRktqNWdGbWpEcldZbklhWHZ0V25SY1J3cGtm?=
 =?big5?B?Zzh5NlM5U3hzMHFBWWhZTlhoN3AzOTR6Q3VwQTUvdGJoRjVVVnl5cVdiZW5PeWZB?=
 =?big5?B?UGhSdnlURC8vVXhYTXZxNFk4Q08rVkhlZ2ZZUGJYM2RPenF3ZWRvblkvTlFGWHVm?=
 =?big5?B?T0JqUHZsQ09qN0tFOTI3RlE0aThmMHZkSndxVmJnbHpYVWwxOXcyK2EvdXhZVVFS?=
 =?big5?B?YXU1MnFWZm56QlQzTWp1ZktZd08zVXZoYkRob2F5bzZNcWpvM3RXWjQ0UUJ1ZllN?=
 =?big5?B?NVJvZnU2ckYxcWZLUlhIdHZOdXNOaEZuMWZvbmtBbzJ1elVSR0xZRmhSKzNQeksx?=
 =?big5?B?cnpBRERQTkVqa0VzS3FnNkRPY1R0alJvT01Kc2xkNXc0T0d3K3QrYXhQU1MydTk1?=
 =?big5?B?OWM4dVoxa00vaXNIc1ZCTlM4L1hjVXgrNGhVeTRWVXZYZ05TcHJlN3Nlb0hSMENB?=
 =?big5?B?RnE5N0M0bjBnYnJzb2FQSllYZWQ0NFVwSzlkQ2d1SXAwZS9DVnJHR0twSU9hNVFK?=
 =?big5?B?SW1DYlpCeE5VSGkvZ29HeWc1SU5zR1hLRjFCREd3UEZocnNaS2VsangvYVNnUkxy?=
 =?big5?Q?GOmcOqP8cUaqdeJY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?SVBQTHdUUEpRTEJWTEpZRzBKYjNwaFNSQUZqdGdMcE5adzVWeXZSUGw0UnVFeklM?=
 =?big5?B?a2JubCttdmVGT3RjWDJqaXIrUC9ZU3hpOW1TelFCbFR2NC9qa0xVRXlwdER3MFJz?=
 =?big5?B?by9ianZNNWlWMmxYblJ2eXNCMS9FcFVWTys0TkdJK3NqOFlGODRSbnJwZmZDZjk5?=
 =?big5?B?RjB6SG5wQ3J0WTJHL1JMOXBtcWNZQ2l1cndjMGFFMm9oV3lNNGtPbXhoYWNWa1Bk?=
 =?big5?B?bldqZlY5cWc3TjJFWmZoOU1RdzRJRUxselVwMENYQlloTElqQXg4ZTJ5UFBEMWht?=
 =?big5?B?ZW0wbHBwTVNCUllFSlM2dDlLTVB6Z1NzQy9PT2RlRTJIUm9ZdHorWlpzU3JteFJQ?=
 =?big5?B?VlY5am1OMyt4cVNUY1l2TkM1ODVCZDY4OHdIMFBRQ05aeUNZT01HWWJJQXNDSUpt?=
 =?big5?B?MmNiUHJnT1pzYXkwU3Bjc2pKWFdIMUxGZnFYTjRCdzRaajEyS29tejVIZlpSUTg2?=
 =?big5?B?RG1JcDh5R2tYL3Z3S1lHUmlaeDY4SGRFMlZqcUlieFIyVzkrKzloRnVFYk9pZjRk?=
 =?big5?B?bjBWeEZTRnZsbWdVczVTbmNPcTdkdERlVmRtN0xHSEJZUVFhRUJmVVRNeEFZNzNV?=
 =?big5?B?dXczaHRXUWFtQjhuek9La21UWGNHT0lhTmwxd3YvVzRJcFFxZWlVZ1Qrc3hRM1kx?=
 =?big5?B?RXZGaUxKenBSeWt1dngrb3JyenZXNE5TZE5xVzFrbk1EcFAyZmI4MmZFRmJ4OUlC?=
 =?big5?B?VHRqbTdTOFQvNVNTcXZmRkRJTXF5QjBHY3RXTVIxL0tWaEpJUG52a2E3S2pMYVA4?=
 =?big5?B?blY1dEpObUlmMGlPQlFPYlRWeFZtdDkrWFZFRU5LUy96dGlDYnBHSjRmVVZzUE5y?=
 =?big5?B?R1p3Y0tiSGlQS1F4ZFJ6R2ZHSHErZGZEaGYvNllhdWJpdlhjUGhGbTRyb0w0SHY1?=
 =?big5?B?T2x4T3FXdlp4SzZlMHdJeDFxaFRRQ20rOG10QkVkRUNURDZpeWVLMmV2MVBxRmJs?=
 =?big5?B?aUVscmNGQUxQYS9oNHVjT3NTMkpGM08vSzdjSnA4d2xGQ09uRVBxMDlRZ05HM0hN?=
 =?big5?B?MWY2bkR1eFNZam4yczhkbllPREFaYXVZYk1RbzVBcy9jb0pOaFdMZkNLT0RKaUE3?=
 =?big5?B?bDRVMUhmQkg4SEFyeDJ3bEFLUzBLa3FaR1VkUjg3S2NQc29GTFlsdzFiMXZ0VHdZ?=
 =?big5?B?OHRWVHZFQnJ4d2JycGFsS1VsTWZ0OFJzczBZVmhnQk1DaE1BMk5nR2haTlZjcTc1?=
 =?big5?B?OGxRVUhmaXpIZWY4REY4dHJXS0Q0MXpudHp5L3BQR2VJWjJtWTVzWk91QXJGT1ZM?=
 =?big5?B?S3lMdjE5NmpPVHRlS1A5eFBqNk1uMWRFanRYaGU0M3lwckZLR2pOWmNBK0pJZkNW?=
 =?big5?B?ZS9hd0FwSUpmbERzL0pTcVY2OFlCU1JNdDYyN0l6OUVUWENLaWtBV0M4Q284dDJm?=
 =?big5?B?dDRkbUIvVm9Rd2JaL0xvd3p2RVpwZWQ2S1pIeEY2Wnh2cVJTS0piV2hkN1FOZ0Z4?=
 =?big5?B?VDJYVUkxVGZLenFyZDYzQXhOZnZrelRvY29nZTNUR3cwa2ozaHk5cjhTUmtQVFRp?=
 =?big5?B?RnVucWt2OW82ei9ibmo4c2x2cERFTG01eUdjK2FuU2R3SUlZbmhESUtmQTZTTjZn?=
 =?big5?B?QjBaMHl1QmRtdjJLY0xrOGh3Y0hBVHFpb3JkZzZGSHh0YXZDT01udk9KNExCQm5u?=
 =?big5?B?c2NQSXpiN3gveEo2ZUl3ZWxOZ2FKZFlVZ1lzaERvYVhsbkROUS9QSkxVdnp5R3hY?=
 =?big5?B?M0FzcEJVc2MrdUNrOHVkeHdMM3Q5L1VxemlwaHNqL25KT05JZU1sTHdYNDVQT0g2?=
 =?big5?B?VUtGNXlRWTByK0R3RER2Q3loanlxdDQwT2pWNFFVbHVUdThLYTRhWW1PQ2FGeU8v?=
 =?big5?B?aVpQNzg4RmNSMENzZExVZDhuZkp3anZ2VFBwa0NsMUYybEhmYVlYNkJCKzhQSVlM?=
 =?big5?B?Znk1TVRsQnlqd2tFc3E2ZVdaODFYT3VxMUtnYTlMRHZVSzlwWS9qSTB6dW1GQkF5?=
 =?big5?B?RFladFMyN1VsTklCdHY5dDk0WStYNk1UY3luTytSc1RlT1Jla0IyQVhsYXU5TG4r?=
 =?big5?B?czg0dEJ4THlzYldTdnJmS2tIWVVvUGIvaGtSTExqd1lJMFFOUUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739a5bb-86bd-41a9-18f0-08dd07b487e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 09:36:51.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBbJBFigqbB7IU3FNwyQkONB/g06ekowFVermzVe0sbqOE8dmnBy0VH6elJ3VytZRxooPJDP+NH6Nv2Pm03Cdhs+V8/1UkjMLbF9pFChbxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5530

PiA+PiBJcyB0aGVyZSBhIHdheSB0byBwcm9iZSB0aGUgcHJlc2VuY2Ugb2YgNjQtYml0IGFkZHJl
c3NpbmcgZnJvbQ0KPiA+PiBoYXJkd2FyZSByZWdpc3RlcnM/IFRoYXQgd291bGQgYmUgbmljZXIg
dGhhbiB0cmlnZ2VyaW5nIGl0IGZyb20gdGhlDQo+ID4+IGNvbXBhdGlibGUgc3RyaW5nLCBnaXZl
biB0aGF0IGFueSBmdXR1cmUgU29DIGlzIGxpa2VseSBhbHNvIDY0LWJpdC4NCj4gDQo+IEkganVz
dCByZWFsaXplZCBJIHJlcGxpZWQgdG8gdGhlIHdyb25nIGVtYWlsLCBJIG1lYW50IHRvIHNlbmQg
bXkgcXVlc3Rpb24gYXMgYQ0KPiByZXBseSB0byBwYXRjaCA0LzcuIFRoZSBwYXRjaCBmb3IgdGhl
IHBpbiBzdHJhcCBsb29rcyBmaW5lLg0KPiANCj4gPiBUaGVyZSBpcyBubyByZWdpc3RlciBpbmRp
Y2F0ZWQgYWJvdXQgNjQtYml0IGFkZHJlc3Mgc3VwcG9ydCBpbiB0aGUNCj4gPiBmdGdtYWMxMDAg
b2YgQXNwZWVkIDd0aCBnZW5lcmF0aW9uLiBUaGVyZWZvcmUsIHdlIHVzZSB0aGUgY29tcGF0aWJs
ZQ0KPiA+IHRvIGNvbmZpZ3VyZSBwaW4gc3RyYXAgYW5kIERNQSBtYXNrLg0KPiANCj4gTGF0ZXIg
aW4gdGhlIHNlcmllcyB5b3UganVzdCB1bmNvbmRpdGlvbmFsbHkgd3JpdGUgdGhlIDY0LWJpdCBh
ZGRyZXNzLCBzbyBpdA0KPiBhcHBlYXJzIHRoYXQgdGhlIGZ0Z21hYzEwMCBjYW4gYWN0dWFsbHkg
ZG8gNjQtYnRpIGFkZHJlc3NpbmcgYWxsIGFsb25nLCBhbmQNCj4gdGhpcyBkb2Vzbid0IGhhdmUg
dG8gYmUgY29uZGl0aW9uYWwgYXQgYWxsLCB0aGUgY2FsbCB0bw0KPiBkbWFfc2V0X21hc2tfYW5k
X2NvaGVyZW50KCkgb25seSB0ZWxscyB0aGUga2VybmVsIHRoYXQgdGhlIGRldmljZSBjYW4gZG8g
aXQsDQo+IHdoaWNoIHNob3VsZCB3b3JrIG9uIGFsbCBvZiB0aGVtLiBTaW5jZSB0aGUgb3RoZXIg
ZGV2aWNlcyB3b24ndCBoYXZlIGEgbGFyZ2VyDQo+ICJkbWEtcmFuZ2VzIiBjb25maWd1cmF0aW9u
IGluIERULCBhbmQgbm8gUkFNIGFib3ZlIDMyLWJpdCBhZGRyZXNzaW5nLCBpdA0KPiBzaG91bGQg
aGF2ZSBubyBlZmZlY3QuDQo+IA0KPiBKdXN0IG1ha2UgdGhhdCBwYXJ0IGluIHBhdGNoIDUgdW5j
b25kaXRpb25hbC4NCg0KQWdyZWUsIEkgZ290IHlvdXIgcG9pbnQuDQpXZSB0cmllZCB0byBhZGQg
bGVzcyBjb2RlcyB0byBjb21wYXRpYmxlIHRoZSBvbGRlciBnZW5lcmF0aW9ucy4NCkkgd2lsbCBh
ZGp1c3QgaXQgdG8gbm9ybWFsIHByb2JlIHByb2NlZHVyZSBpbiBuZXh0IHZlcnNpb24sIG5vdCB1
c2UgY29tcGF0aWJsZSB0byBjYWxsIA0KZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpLg0KVGhh
bmsgeW91IGZvciB5b3VyIGtpbmQgcmVtaW5kZXIuDQoNClRoYW5rcywNCkphY2t5DQo=

