Return-Path: <netdev+bounces-125029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142796BAA3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C698D280254
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1851D0147;
	Wed,  4 Sep 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hoQNJmUE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4ED1D04AA;
	Wed,  4 Sep 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449340; cv=fail; b=h8AhwLFtNTjSnCDptH1vNv7ZeRtXUFQDH9JWc2vcjN8eLDtFLwBMj/xCBztn9H8CNJJBry3dKxTgnoHfLcXjGnwuBz7mnci9kcgM71fXZmI55TeQE/baptCPTa5Ik2XTgfY0uK8MphYTcDHcIAm2T8bO57/WuCoAv75G178OLys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449340; c=relaxed/simple;
	bh=YgGzm8RPGYVrANHobfLeN3QCl9D2nL7L+ap947LIwz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uu+qxPH+zFevz0CsU8dWLHSx7Aez4TMEe1v6iS7y/1J0WLDFdk08a/aM5TCYEvOB0MPhcCU7MvPtY/H/uBIrtlBfduO57NxMmJRR2iG/vuFBemlyUEbmSoGdqEebVQEBjhT7f9JF5OfnhCwXW5MLqewIQpPbLUDW59dfWCI9SqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hoQNJmUE; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBSt0qegdggk6FODPlWfXa9OjbzePtHJaDNv9Z8YuXjAMLIar1/ao1+eMmxPlDfTyVwz+Q44eBFObjyMeOFvLsY8Chdb8AH5l12TbQPFuvN0uyrKhgZ4PafpBVCg/KIZ6M9eUKb+KF+ZS+5YTxTGaTy5avEuBYPUJxZ7Loa9jzeszK+/9Os0J7WSAqPipQvm6MACLCaX3QP8JkBV0FGFXe9bg3ITIgmwhljaYmODfiDQAKffIZfDiKojdMSiN9pW5xrp8I2JZtVsnRwAA93qAxCRxAzND7VJ4hPv6lt7JGeDd+/cM5SlwZaTX/qjgTi7kmxv/jEnNgSldO9H2ckCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgGzm8RPGYVrANHobfLeN3QCl9D2nL7L+ap947LIwz4=;
 b=XHD+fXfdSlf+LLZUxeZjHfXVmHCOrtL6R9Xu7cluAgmd90RTuHDP5rwA2G4OB312OjxC1eBtDyihYR4xl9JA8WRE/HAJ7vP74+2liQNu4IF8g2MF2qCBULudVza2C/G1/XZuMtUSxQCzApFuzexS+1FXcEO4kOIBzwc2VIEZ1ZZOvqrtRiGKc/uiaIDabVxb3czU5fpIz1bUXJOpmw2BQO9eUn10N1XjhD9DAVnQKgd9R0g2fpdDSJppDM+tW1wL2ZgXlh4qA1r5iphFYlQ+2c4nk3KWcmefQzEUSTFUx065fskb0UaMQXOsx70Cx9pcyI4aFVNpH3Q1uMPVdGkIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgGzm8RPGYVrANHobfLeN3QCl9D2nL7L+ap947LIwz4=;
 b=hoQNJmUEUqSUdlxlWzqtJcK6JdYLfVs69eWJNSU9XOUrVCsknN2IC7eabjYymDCXohpCBISczOLmdrOR+g/LTMkH3nA+rrc1vzUe1rY+IPnHBVoiiJ+NX93v4MSHTEUEs3ImzEv5Q1HF5uDEwQ6TLF77E0FBn/xU0Vy69+TqueO5VKsnNBxv8nr36mULHvx3bwSp6l5tVRObH0pGEK4CbCn1xY7Qk0ZjT9yjry3fIqqngXF9PxD7N+eu7XtuZBHJTPKaaA4ZI9MUASZB+gFG9j9jl/yqH5X0zS+7jT8FM9BCVJn1+sEf1LfZhxf7VXm9tYfr68bFXNBo62PwfePTcQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:28:34 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:28:34 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Horatiu.Vultur@microchip.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 0/7] microchip_t1s: Update on Microchip
 10BASE-T1S PHY driver
Thread-Topic: [PATCH net-next v2 0/7] microchip_t1s: Update on Microchip
 10BASE-T1S PHY driver
Thread-Index: AQHa/UVVw5Ect2l75k+aZEEMgJ79wrJFmWCAgAHnO4A=
Date: Wed, 4 Sep 2024 11:28:34 +0000
Message-ID: <a0428bdb-d422-4801-ab1e-649c409bc03e@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
 <20240903062441.otbn6qcrhjisovhy@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240903062441.otbn6qcrhjisovhy@DEN-DL-M31836.microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CY8PR11MB7946:EE_
x-ms-office365-filtering-correlation-id: a73c98e7-9e28-41f5-4e3a-08dcccd4b623
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjE0OGcxck51MFk5T2FCMXkyV3RQK3drRkd3UWNKeU5ZY1duNEV6bHkvVCty?=
 =?utf-8?B?MlZyTHpDVXJPV0FoUkUybm9GOXFmbVF4VTcwSlMxOUFEditjZkxHbnZ5dlcx?=
 =?utf-8?B?ZlFZRDBKeElkN0I4b1dBRDZVV2hyWjI1M3RBK3FRQ3Y3YTVCc1Q3UHJyaEp6?=
 =?utf-8?B?ZFIrWlU0VzUwRStBcHBTS2tIWUtVSW1GRjk2VEZtb2dnZ2FKSTNlZUlGenI1?=
 =?utf-8?B?U3ZXcjBCVWx2NVI3Ym5vMzlsSE8zOE5WWTVmcThBRXRtTDJhMTRHVTJUSkVZ?=
 =?utf-8?B?bXpma2dPV29welVnZ1BWbFVtbWNwdUxWWXc5K0hXWXFXMG94ZXRyK3p3aFFs?=
 =?utf-8?B?cWhoMStCU29sTVdTNkIwWTZwTnFlS2ZHOE5rZVhuVWVabkw4TXNaak5Ucm5i?=
 =?utf-8?B?UjlsV2IwUGJYanRsdWxtNTZxaEF6eU10eUpJSWw3VW84S0szaThsMExGT1hX?=
 =?utf-8?B?NHJ6aktWNFVWNGpoZGVieUk2WURlUy9MQURXaFVrR25RL2JWbmcwSnJuLzBy?=
 =?utf-8?B?cXM0VGtGNHFWYS9KQzd0SWRVTXgyalpHK1lPOThCMFFsMHUxb3kvb1lINFNE?=
 =?utf-8?B?ZjFXd0hBaG1QY2VGMURtYWZJeUxuc3hVZU9wYkRaM1M5aldjYjFzTWF3Z3FN?=
 =?utf-8?B?Qk0za1orTWV6MjIrQVZDTEg1QWZVWjZXa2V1RDZGQUVEVnN0SVdzNkxnbDhS?=
 =?utf-8?B?a2VmNDR3RFlBbnNKbWlhV081QVRPT21nZm1KeU5JRFNpR2tiSXkra1lBUDVH?=
 =?utf-8?B?blgvRnZINWZ3aEI3Z0dKR3dJV2UzM01DKzNBalRqTkp3MHVPSXd3M0N6M2Fq?=
 =?utf-8?B?MWU5aWdyM2dTSi9nZHRBd0FOWCtmSjlHeDlCeHNhRk1VYzI2R0wrZXBjOGhM?=
 =?utf-8?B?RnBCOGUyY1FpRkJyNmlNejRXRkh2bmN3SDdMSGhvQWE2MGNVRVB5Q0I3ODB6?=
 =?utf-8?B?VndFTXlLZXFrTUNPdW1Hbkc1TFl3Mi96SGx6NWJ5eWdIU09IM2tkLzMzc0FQ?=
 =?utf-8?B?Z2w1TDNHMUhWQ0c5T3Z4aC9jeURUMld5WWN4M2YwN1FJRk90M2FvMUdjZVRs?=
 =?utf-8?B?RXR0L3BPcEdRamVWTnhDY3YyZkthQlpYV0dxSGdENk5ZQ2x4Umd1TkhNN2cx?=
 =?utf-8?B?Vy9td3JUMEhGdHJtL2pTVEhkN0xndjlMQjVPRFZ6WWo0VytHTXFtZC9oelYz?=
 =?utf-8?B?M0VoMzI4U2tKUnZTZ3R1TkplMjhydU5rWEpBWVdiNWJpajFGVVkzaTBOWEhB?=
 =?utf-8?B?ZE52OHRQYmxnbjI2YlpXUTJ3VExCWklvQnhZVG9ZQ1dTbmFhazhvbGVieWFX?=
 =?utf-8?B?SWRNelVaZ2w5dWsyRllqUUsweUNaNVQyVE5EaUEvOGdLR0M5RGZLOUhBYnVV?=
 =?utf-8?B?SXJ4UGtXWGVGK1V5a25pbjNwRmwvSE8xNzNnbVlzU0YrUjluNHlXUitxR1Ar?=
 =?utf-8?B?bTJuRC9EVVVKa2hWZE9wTnA5V1Q4UXNnZWt6d015NXZUbDROdVNyVjhSU295?=
 =?utf-8?B?QVg3dlUvZHV0YjJFZ3lib2NVeUhqbENCU0lzaGNvWlBFUGdKWm9Fb1BvZEZJ?=
 =?utf-8?B?R2NRU1dCOEZjbkh5WXNEOFQwaTNNTUdPeUR3N1MwREtpb2xIQTR0bkw4VDIw?=
 =?utf-8?B?N01nbktlaHdScThCYWEwYmZzQXF0b1ZILytTSVR2NFZQTDlVbVNCZDVwMWM1?=
 =?utf-8?B?Rkhaa1plbmw3MXpYdG1VWUVKRUkzNWdZaTN3ZWtuSG1FZ21MdnZKL3Vnb3ly?=
 =?utf-8?B?cmJmMjhEU3lIUzRPVUVST0VaYnplS3FLQWszR0dveUN0cXEyMnJ2cVgzWFV0?=
 =?utf-8?B?citFc2NWSm5Hd0lhSDQ4Vkx3Nnp4cUpFNG1JRmVXWnh1bUJqVUxHWVdQVXh0?=
 =?utf-8?B?UDZCc3VLR2JRb3BmaHVVSEtTdUJOVERsYjBVMmo0WHJpWGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjIzTXdVT1hIckJWY2ZnMW4yaWh4cE1Cd1pHQ3JaZXVZOVVvRWk3TFRGcmtq?=
 =?utf-8?B?WXFramk5c0MwTzhOdDBtbkhKYUVnblArOElpQlJEZkZyNlBYUzd0dWZMOGc4?=
 =?utf-8?B?L2NyeWxHYy9BbDdkSU5EWFc5Z0dpTmxXaC8xVWU0SU5FM0lmeHdiTHhwTyt4?=
 =?utf-8?B?YytIakpESmpzRVp4Ykl6WTJBSUpyOExHVm5yTGQvMWFtZUdLSFFILzJUM0Va?=
 =?utf-8?B?RGg3NGtyd01aOGN4aE1MOUZUUzFRTkxpZ0JuZ0xuOFd2bFFaRXV4RlBrcjdD?=
 =?utf-8?B?M3BnSG5hL3plQnpYRWNsSWU3QTVkMVVzd3YrSUd4NzQvTGhuRHBudk9RMVlR?=
 =?utf-8?B?Qm0xUnBoYXgwbzBNejFZLzJRanE1Y1lBNzk1Q3lLbDRHSiszZEVTdHJVRmNL?=
 =?utf-8?B?Mk5OS0hRbC95Y0dnK3UwUy95RHhDMHRqS21QUGNRVUU2S0E3Q0dFVDlqSDJE?=
 =?utf-8?B?T2xIOGkvNVMxNnZlZnR5MWhISExUcGF3elVCRXAvYWczcXhRTU9NTGIzaVd4?=
 =?utf-8?B?cUdFbU1GL2lsdnpTMVZJWlI1Z2NETjE5QnNNR0toYy9wSkM0bkF1VXVtWmo0?=
 =?utf-8?B?NkczTWZ6L3BjTnZJZ21kYzZLYVpjbDJWVHZTeTd6NXpCVndQbDhXVTRRYVdn?=
 =?utf-8?B?OHZuMElRdkJCNFV0cG8xMk5vK1pFTTZDdC9tQTlaOXBiMmZZMHV2M3lRSEtL?=
 =?utf-8?B?RG5KRlFmWHcxRDFBcHVHMWZUdkVXNSs4b01VZGlHWmhsQ1lsb3VwcjdPZXNj?=
 =?utf-8?B?YnE1R1UyZ21ZN3ZjbnZSNG1QckZLaHEvOXF4eXpVT2Y1SWV1dHF5aWtDVjFT?=
 =?utf-8?B?a1VXTjVvM2krSzlGQnVGL2JWYlNyZ2RJKzhnTzRMcG9TOXJwUHNaY2FvV2Ex?=
 =?utf-8?B?R1V6WUlWU0NUYVd2OTVpZUJEQTNqSlhTV0dlSHVaK1U5NnNnaS9ITjd6Q3lr?=
 =?utf-8?B?WXIzQkJNdlgxbTIzRWh3S2R2Tlp6emZMcGtWM0hUU1NkWlFOcTg1N29FVnZO?=
 =?utf-8?B?UlVndWlZbS8rUFdCR3FpRzczZ0tYQlorbVhmL2J4R1RuYnREdGZQZ2xBQ1Bv?=
 =?utf-8?B?cFJQUzN0UTZQQnh3Q2htanV4SGZVVUpoMVltVEJua1pzR3h1TTdHV1Y5S3NO?=
 =?utf-8?B?ei9zeS9lenhVc0dXb0Jxc3grUVV4cXpYbTRsVmw0bm12Z1JocmwyeGZTbkFq?=
 =?utf-8?B?VVF1b1NjVVlSR00yc1p0ZTgySTExQXk5NjBJT1ZtOUJPeUgvREg3bktuYWdN?=
 =?utf-8?B?d0lkSUYzVnl6cERzKzErUFdmMnZaSEY3aGxid3BGN1dKTlpvYkNWQ2FBajQx?=
 =?utf-8?B?bUVEcEcrbTZQTmRRUkkwZm5uK2NweGQ3eHNkZ2gxamJEaDdLUXZNNU1kUTl3?=
 =?utf-8?B?TEFqZ3JxMXI2bXlhSHVFaWVWQzE5eEpZMEhYUmxWcHk4WDZQNzZ1MU1oQjRL?=
 =?utf-8?B?cVl2Z2tpMG1qTTZBNFhjVEFrajk2Z1VLM1ROSDNPMkZjVTNrc1pkck03V1Nl?=
 =?utf-8?B?ZkFuQ3EvSHYxSDJOR1cwN3JHbXRWbjFpaGw0UXIvWkxXMWhUcndoUDcvT2oz?=
 =?utf-8?B?NS9tdStHWWpjdUVEcGVCMnhmMFExV0xIcm5ISC9sT2VIL09Uako5SElFelBJ?=
 =?utf-8?B?RTlhQnVFZVEzL1oxbjZHZHBUVjJaSkFPVFhzOXg2WER1Sm5WaGVwU1hwYUdX?=
 =?utf-8?B?ZEpXMGlZUXpJSUtiemE2RFIyeDdFWW5sNTdsRXIyeVpvUkFTUkVFdUNqVHly?=
 =?utf-8?B?Vy84ZUJVd1MzOGZ6TmkzTC8yYkhnN1p5S0pYc2l2dTdGLzlvZWVlQ1dWN1Fs?=
 =?utf-8?B?ZW05T3lodjRxa2RNekZKNmF3bUdLTkhkdTVmY0F0RE9WN0hJUXg4d0I2c3Bw?=
 =?utf-8?B?QXJXcEFFWUxGN1FObkp5VG1FNjE5YnNJcFJtMkFrVDNYbHJwU1NwSnU5OEhs?=
 =?utf-8?B?L01zSThLY0JSY3RMOERVZ20zVkRHdWRYLy80Q1BwSlVMNHhnOTlwZUxVSXpV?=
 =?utf-8?B?QVZuWFZTaURmaWZWTjFSaEVSbEtBa2hNTVRxM3AxNFRZbkVmOUxRTXN4YTdU?=
 =?utf-8?B?TXpDTzB0ZWZzOGlGTUlMVnRNQmZZbnM1TjJyeFYzbEQyQ3U4dFYremdkNXg4?=
 =?utf-8?B?ckJKeHo4NHEvMkdWTUZsVEdjVUpGMjI2U3N6dGtwdlVkU0g0VGxBdEk4V2Z3?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33DBFEAD338C5640BE946336FF78A885@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c98e7-9e28-41f5-4e3a-08dcccd4b623
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 11:28:34.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edOhRc2Dxz4WLHhYufT6ugR3T81csCSrzltTbZ3krva+igOU2+PuZPGvEbKD0o61LJKMv+H1pzq4MMDTrYsw2kZNygi4c0NaAEhDNYJgBm3oZMT2xDE8H1KFbXd+HZbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946

SGkgSG9yYXRpdSwNCg0KT24gMDMvMDkvMjQgMTE6NTQgYW0sIEhvcmF0aXUgVnVsdHVyIHdyb3Rl
Og0KPiBUaGUgMDkvMDIvMjAyNCAyMDowNCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0K
PiANCj4gSGkgUGFydGhpYmFuLA0KPiANCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGNvbnRhaW4gdGhl
IGJlbG93IHVwZGF0ZXMsDQo+Pg0KPj4gdjE6DQo+IA0KPiBZb3UgdXN1YWxseSB1c2UgdjEsIHYy
LCB2MyB0byBzYXkgd2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHNlcmllcy4NCj4gQnV0
IGluIHlvdXIgY2FzZSB5b3UgYWxyZWFkeSBoYWQgdjEgYWxyZWFkeSBpbiBmaXJzdCBwYXRjaCBz
ZXJpZXMgd2hpY2gNCj4gaXQgaXMgc3RyYW5nZSB0byBiZSB1c2VkLiBJIHRoaW5rIHlvdSB3YW50
ZWQgdG8ganVzdCBkZXNjcmliZSB0aGUNCj4gZmVhdHVyZXMgb2YgdGhpcyBwYXRjaCBzZXJpZXMu
DQo+IFNvLCBteSBzdWdnZXN0aW9uIGlzIHRvIGRyb3AgdjEgYmVjYXVzZSB0aG9zZSBhcmUgdGhl
IGZlYXR1cmVzIG5vdA0KPiBjaGFuZ2VzIGJldHdlZW4gdmVyc2lvbiwgYW5kIHB1dCAnOicgaW5z
dGVhZCBvZiAnLCcgYWZ0ZXIgdXBkYXRlcy4NCkFoIHllcywgd2lsbCBjb3JyZWN0IHRoZW0gaW4g
dGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+IEFsc28gYWxtb3N0IGFsbCB5b3VyIHBhdGNoZXMgaW4g
dGhpcyBzZXJpZXMgc3RhcnQgd2l0aCAnVGhpcyBwYXRjaCcsDQo+IHBsZWFzZSBjaGFuZ2UgdGhp
cyB0byBpbXBlcmF0aXZlIG1vZGU6DQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
djQuMTAvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbA0KT0suIFdpbGwgY29ycmVjdCB0
aGVtIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+
IA0KPj4gLSBSZXN0cnVjdHVyZWQgbGFuODY1eF93cml0ZV9jZmdfcGFyYW1zKCkgYW5kIGxhbjg2
NXhfcmVhZF9jZmdfcGFyYW1zKCkNCj4+ICAgIGZ1bmN0aW9ucyBhcmd1bWVudHMgdG8gbW9yZSBn
ZW5lcmljLg0KPj4gLSBVcGRhdGVkIG5ldy9pbXByb3ZlZCBpbml0aWFsIHNldHRpbmdzIG9mIExB
Tjg2NVggUmV2LkIwIGZyb20gbGF0ZXN0DQo+PiAgICBBTjE3NjAuDQo+PiAtIEFkZGVkIHN1cHBv
cnQgZm9yIExBTjg2NVggUmV2LkIxIGZyb20gbGF0ZXN0IEFOMTc2MC4NCj4+IC0gTW92ZWQgTEFO
ODY3WCByZXNldCBoYW5kbGluZyB0byBhIG5ldyBmdW5jdGlvbiBmb3IgZmxleGliaWxpdHkuDQo+
PiAtIEFkZGVkIHN1cHBvcnQgZm9yIExBTjg2N1ggUmV2LkMxL0MyIGZyb20gbGF0ZXN0IEFOMTY5
OS4NCj4+IC0gRGlzYWJsZWQvZW5hYmxlZCBjb2xsaXNpb24gZGV0ZWN0aW9uIGJhc2VkIG9uIFBM
Q0Egc2V0dGluZy4NCj4+DQo+PiB2MjoNCj4+IC0gRml4ZWQgaW5kZXhpbmcgaXNzdWUgaW4gdGhl
IGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVyIHNldHVwLg0KPj4NCj4+IFBhcnRoaWJhbiBWZWVyYXNv
b3JhbiAoNyk6DQo+PiAgICBuZXQ6IHBoeTogbWljcm9jaGlwX3QxczogcmVzdHJ1Y3R1cmUgY2Zn
IHJlYWQvd3JpdGUgZnVuY3Rpb25zDQo+PiAgICAgIGFyZ3VtZW50cw0KPj4gICAgbmV0OiBwaHk6
IG1pY3JvY2hpcF90MXM6IHVwZGF0ZSBuZXcgaW5pdGlhbCBzZXR0aW5ncyBmb3IgTEFOODY1WA0K
Pj4gICAgICBSZXYuQjANCj4+ICAgIG5ldDogcGh5OiBtaWNyb2NoaXBfdDFzOiBhZGQgc3VwcG9y
dCBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WCBSZXYuQjENCj4+ICAgIG5ldDogcGh5OiBtaWNyb2No
aXBfdDFzOiBtb3ZlIExBTjg2N1ggcmVzZXQgaGFuZGxpbmcgdG8gYSBuZXcgZnVuY3Rpb24NCj4+
ICAgIG5ldDogcGh5OiBtaWNyb2NoaXBfdDFzOiBhZGQgc3VwcG9ydCBmb3IgTWljcm9jaGlwJ3Mg
TEFOODY3WCBSZXYuQzENCj4+ICAgIG5ldDogcGh5OiBtaWNyb2NoaXBfdDFzOiBhZGQgc3VwcG9y
dCBmb3IgTWljcm9jaGlwJ3MgTEFOODY3WCBSZXYuQzINCj4+ICAgIG5ldDogcGh5OiBtaWNyb2No
aXBfdDFzOiBjb25maWd1cmUgY29sbGlzaW9uIGRldGVjdGlvbiBiYXNlZCBvbiBQTENBDQo+PiAg
ICAgIG1vZGUNCj4+DQo+PiAgIGRyaXZlcnMvbmV0L3BoeS9LY29uZmlnICAgICAgICAgfCAgIDQg
Ky0NCj4+ICAgZHJpdmVycy9uZXQvcGh5L21pY3JvY2hpcF90MXMuYyB8IDI5OSArKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRp
b25zKCspLCA2NCBkZWxldGlvbnMoLSkNCj4+DQo+Pg0KPj4gYmFzZS1jb21taXQ6IDIyMWY5Y2Nl
OTQ5YWM4MDQyZjY1YjcxZWQxZmRlMTNiOTkwNzMyNTYNCj4+IC0tIA0KPj4gMi4zNC4xDQo+Pg0K
PiANCg0K

