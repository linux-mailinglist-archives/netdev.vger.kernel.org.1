Return-Path: <netdev+bounces-215147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0100B2D3E0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974CC2A6849
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD592773D2;
	Wed, 20 Aug 2025 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="IeyuL//f"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022112.outbound.protection.outlook.com [40.107.75.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123E242D63;
	Wed, 20 Aug 2025 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670198; cv=fail; b=gbqz4f1h2aPXTcY2FX2MIdN5I1pFFMOEOJIPc8RShAb8W3sqYAAp0+8lla06yvjV1rBgpLlmHWmI2b79UKF0YbU9qq2AtHOm4T7I+1ez/d8gS9OEbj2euLPnZ0f7I2xNoUwgILRYwRAgFr2x/YbHRZxtabLH6amUkkwDZxoB44g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670198; c=relaxed/simple;
	bh=at9y02Lkcrf0VB1KZz5M/EOAHKvQogiza8ydbN8SURA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=moztKFMo5I20xro7IDYYD/KyiWo7tb4FIEQdFKowCTSiiDQc5ypR6MdorGwwvb06zqMNQVTqPkTtOmmRZtytBOpC/j4IgMsv7SPE2uMiz98ZlSC/YNZIswfSwNZ4QCTYrkZWGgndX7pnG0CuNRe0POENPe/8KcCUJk2/GLSobKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=IeyuL//f; arc=fail smtp.client-ip=40.107.75.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+ZoRXqUGcyigbgxRz/TZYLXQ7ad2hSEUIBaG8AxFBf/FCd3O8MZrhSuGbsOfLfNvA42YMiG76XJZiZ0PSD3h9KjhBdgSFpLXtc+LgDs3J+0pxeR+RqvSOFuq8k7jvO8mxgFB8PBJJXqCrjo+MvLaBXM63pub2HGjxoWhICA67vNcs61T5nNrNFXtA8hq/DeShbIgO3rhtU7WNXL6gzKgwa/wPypxU8TlW2ydk78PIS+BkXwG5RzRjRMsFMJ8RDnb7s0mc01YGvv8cP5+dQoaHLBOOU9wvezlY8DxvuYqBqOIFkpHVNl/dtjPbCyQo/F6htA7B8qKQSx2Os2d4ARxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at9y02Lkcrf0VB1KZz5M/EOAHKvQogiza8ydbN8SURA=;
 b=Z1rTCQqhkwuZxZDaqXzpJB5iHsmZbif4tb9uEf79iZW52eDl0Nrc0CbVDjTjDAm9lXgv/yNcz8ulU5tXXvE4H9Wk8PrGoUyWV5GrzEPShE0qKDv1fHRp0FavesJPaR5ZOEqQQWN19ICzq5awP/BXLlPuTR0lXUSacwGdfgrg4kPNbscQq2VwZ4mng9iTLhTL5BaV1k+ZMRRfnG5LoiO80QB/fOG3iYVmdUwBV82EYEGMOZkIDWABFlVLtUEtQsQIEIzJyaV7SAAXBHFnkkalRMhAzpGWwnLWUM7qlOQ3/si8l4K3NyQUK9qIBcumeHgyEXRvhmdNhUqyocJyx0Ofgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at9y02Lkcrf0VB1KZz5M/EOAHKvQogiza8ydbN8SURA=;
 b=IeyuL//fvyIaqHvirkUBl1k17cWIoZGbzMxR2ZAmd7O58ZB/5y9TMo2DfN5HgeUda8m2aOoRTmHaR4/CAzPPoxsmeB/5kaPevwpkmgdg7OX7w1sJPTHzv0sPHls/ILPU8TO7hjpVMMTs/eETd1gr6DKP41Kpc2pnOX3xM2NGH5tFDyd/oC4wLWAzrBzf8dqXeYkGHguEx0OhnSKzBQMWmoEj+jVF5fbUHpaz5jzJTQgnpCGqz80i14qiCgbZKi85aWqKIhn2YEoPImKIIrFRghKHCrXed5RiTF7x42Gkps5J+OUZ7Zr6HY0dtFysqG91h0iJ4buiBV0WTYsqbKjRwA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6403.apcprd06.prod.outlook.com (2603:1096:400:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 06:09:51 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 06:09:51 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Simon Horman <horms@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtuZXQtbmV4dCB2MiAwLzRdIEFkZCBBU1QyNjAw?=
 =?utf-8?Q?_RGMII_delay_into_ftgmac100?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgdjIgMC80XSBBZGQgQVNUMjYwMCBSR01JSSBk?=
 =?utf-8?Q?elay_into_ftgmac100?=
Thread-Index: AQHcDhRZKIdVUppPdkiWsIaFr0P96LRqtipggAAmHgCAADjcgA==
Date: Wed, 20 Aug 2025 06:09:51 +0000
Message-ID:
 <SEYPR06MB5134C67403A80C14797F8F859D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
In-Reply-To: <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6403:EE_
x-ms-office365-filtering-correlation-id: 569efc63-71b6-4a48-feca-08dddfb02c99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXg5c3pBMzJxaXh4NEh3SmprMDV5eHozcStVanFCTW5QakFlWFR4NEkyUjBj?=
 =?utf-8?B?TTBKdU1zbDZEQzBmOTVvZE91ZlRTMGM3VGllU0kvT0FCcmxPTmRoRXVPOWxV?=
 =?utf-8?B?cTl6ZXRlYjVkL1loRWJhbHJNR3BpWThGZ0RydGwxcU14N21YMVgzTHNUWnJJ?=
 =?utf-8?B?ZXIrR0l2NzdnUkVOTDRXQmMrNFpKRDRyRS9LTXhNS05hbTJVUUpONTFUd1pT?=
 =?utf-8?B?WVp5UThvck5pYXM4MjZQQmpsTE1ESXdLTWJlejRvL0FqbjlaLy81dno0MHBk?=
 =?utf-8?B?T0xCN2d4bS95SWVGRnNUczZ4b3Z2NGlUd01DK1BZdkMvNUlCd2dDdTVqNGVU?=
 =?utf-8?B?cC9tODgwcDBZa0NhUkkvK0lUajhJZFZpUlJYdnllZU04NnJtaU85WVNkdktM?=
 =?utf-8?B?MGloNjU0WG1QV0RUcXE4MXkxTlBoRWNZYzlWVEczNWdTOTZzS1NES1BvOFgy?=
 =?utf-8?B?SEtZc25vMm14eWxzMG5TZEMvTVYrdkpXREs4TlNVb2Q3NktTTStWQkVTOEsv?=
 =?utf-8?B?Q29SdHdxRkNZNkdLRHp4ZTc2Y2h2Q1ZMakNIT0JRUGpYM2lkVFJ4VXNUSllM?=
 =?utf-8?B?Y1QxcWJUVVppcThaWFdoa1hFM2dhM3c5amxkTk9tcU42bm91MjlGNGJFeXds?=
 =?utf-8?B?VlV1a1BhaWtzNm1yazAyanRBcGE2Wm93a2k4UUswS0ErYXpVR3RHTUR0Rzdn?=
 =?utf-8?B?N0gwb3hneHVJTnBqbTlETi9rUlhjWEdSU2srbHh6MVdScHY4dDN3aTkzV2pX?=
 =?utf-8?B?bjY0VUJybStSbmhwbFV6TVE2NHZTOEdRSkNPMkUwQzIwNHBIRXhEdXE0UHg3?=
 =?utf-8?B?NHNxdDhaZmJFNnRtT05DYkxPc2VIVWx2aGlucEdmeTZSSlE4cm14SmNUdHpI?=
 =?utf-8?B?T0xnQ05JS2t0eVgrZ3oxS2lpTU16UTZvWmlnUGE1M0FmRGNLeitVSzBFY0JR?=
 =?utf-8?B?MG1TeG1rbmN5QWkzd0JtVWp5Zkw3VlFWZkJpV2FLbnBHSmlXZWFjdHhwRGhF?=
 =?utf-8?B?NnBCc2R4RmVnd1VqM0xTSXFuR2RGS2xlRWlnSkhXbytaK2FnR2ZSRHFsMUND?=
 =?utf-8?B?YkNWQjhzWWQyZk0vVmdIaXZMTmkyYlBrMmZBRlZpa3BRb3ZweFhwVVBLeitt?=
 =?utf-8?B?TXVFU1RSRFZTMjZwczFjMkdCZ3R6WFo1c00vZk1mMWZubkY1NjA2MWZqQzUz?=
 =?utf-8?B?RXErV0hzRWVIZ1NGN1lBN2pvV3JZME1CRWIxaVo2MEMzeHRxaXJ3Wk5KSnVh?=
 =?utf-8?B?d2ZVSmQrY0RoeStJNTRqcWRRcnhsOHdTZnVvaUp3blhrWGs0NlVnQ0lYTjJo?=
 =?utf-8?B?eW56RGpmdmtTa3pmSmh0Sll2ak5EV2tOOVorUjI0cjFFWHFhQ0xhaUkwL2VD?=
 =?utf-8?B?czl6UlNpMDljMm0vN3l6bk1aUjYxTER2VkZZZmg1U1pvOTlqd0l5UlU4aWt4?=
 =?utf-8?B?UmpkUTgxcmVPNnJIT2U2SWtJOWJaditnd0wzZ2ZvWDFNQVdoejAzSzg3eWE0?=
 =?utf-8?B?aGc0TWczM2gxVnVRV1VGQ2RVSnNKckF2RVl4L3VSeFR1Tnd4OFdjTTdWRWNa?=
 =?utf-8?B?cE1nMUR5b2pqakIzOVBoeHJ5RWVjcDRVSEhnNDdDaDl6dklFYXNWUHFhRHdh?=
 =?utf-8?B?ckdRcWpPUjhmaU1kQnh1ME1jVC9GVklrVGJ5K1ZNZ1k0dWtqYnlaMStia1JL?=
 =?utf-8?B?Mlk5blg5anVTdnFBT1A5ZTZUWWxTKzFSYlAyRnB5eWdiUzViaTZ0dDJ2RFh3?=
 =?utf-8?B?Zlp5ekZDd1Z5T0J0WVUrdXoxNDAzZUtvUnBHL1pHeDVmWERqNS81aGc0bGpm?=
 =?utf-8?B?SjNXTlpGNW9udUZoS3FNejJhaEV4a2JSc0FOdUFTWjh5VHlqMWlyOGlrQXNt?=
 =?utf-8?B?b2FXNk5QZEJYK2tpVmt2cmV3VDlzeHIzT011VzJyL0ZmZm9VaEFHV0RRdmhO?=
 =?utf-8?B?ci9OYTBUb2YwM1prK2hVZkFJa0UxYzhTWWlicWNsc3Fub0o2dUtPWVVOZGg1?=
 =?utf-8?B?RWQ1WkwyYVpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0Jwd1d2anRFQ1ArVE93U0JleG1uQnZNaFRzc2hvSnJIVzhiMzY4eUl3aThX?=
 =?utf-8?B?czVNcnR1ZEdaR3ArSnpuRUpyeWdrdzJENm1zSlhkRU1KaDI0aHNyN0dVMW9a?=
 =?utf-8?B?SlBIUFdnRytyREZWSUhoQ2dPa1NhV1dKQjJFOVBlMkszRkhwVWE5QVFOTDhy?=
 =?utf-8?B?WUxySFc0T2dYRVl0M3pYSVJVSmdsS290bWNaUUJOWU9qQXovV0lEWCtKM1ZU?=
 =?utf-8?B?dTdZWmdOcFVldWhDVDVVQ2Ezdy9lRnl6VW5nV1JQNXUwNVpqS3ZXVHZqRG8z?=
 =?utf-8?B?b0VGdndQaG5UcjBqUEw5RHQwaFc1b0VzbGZiMjFWaUh6bTgrSnQyc2FtK3R3?=
 =?utf-8?B?a2NxNGJxWG81bDNablk3YzdZNEQrcGpmZGJRRmZXZDlxUzlqSVVUQmx0QmZ5?=
 =?utf-8?B?WFNqSEVsUEJvQURuVmNESUVNa1BmbGxmV0Y4MTJ2V1VlRUpZck1Ndzc2aGFo?=
 =?utf-8?B?SzgwTHltbDBFWjZTcS94eUNTdlRnak1RcDlLZW9sM3UxcDBsV1lkR3UzZ2ZG?=
 =?utf-8?B?azh4eG5vMnNYdHRaM3M2ZXQwa1VHdDRSeFFsWUJ2NW5zSGI2T0ZHQlExZ21w?=
 =?utf-8?B?ZXdhbWhvaFZiOUJOUWd1TGNUV2xwR3d1M0FpVk5McG1PeGd2K041YmlGRTlB?=
 =?utf-8?B?Y21ZdFRjakNEZ1ByZWRmQmYzeGo5cnp1M3lTYmNUTUNpVzlMQWlCU1QrL2xu?=
 =?utf-8?B?cTExd1B4REhRcmtVdEl5Y1JjSGNUWENzRHhpbHZPaW04Z2J4QlZadkpxRmE2?=
 =?utf-8?B?YVlhTWZYeTIzYWtKRGhtZlRKcFZ4dkN5T1IzQUZWWjVBbkZpczVJRXNyNUEw?=
 =?utf-8?B?dldBdUNqdzliVFZzc1NrV3FFQ2xTZkk3b1NubUhnMWg5Zy8yY2lVMlpEZHNF?=
 =?utf-8?B?NUt6YzBQci9CZFBKZHlaSmN0T1FteE9MQzJrZVVkckFYaVlrUklnWCtEaUNa?=
 =?utf-8?B?S0xtWE9VMGcvUGtMVjdlOE1ueFphdnVUcDZuTGdTUEtCaFN1NXBhN1JldmNU?=
 =?utf-8?B?S1NGejN4RzJ3UzZNU1VnV3Fud1ZGK0phZjZLM3R6MHJXbVRjQlpDMmVZUnMw?=
 =?utf-8?B?VSs0eENScVpiTndQRlNoNVA5cUFraitEZFhIVFRHSHpDYU1OQXFTV3NlRGYr?=
 =?utf-8?B?RHpteUVONDNsekF5OGUxVGdRRjNXMURmOExSalg2NFNQWTJtYXd0andQT1Uz?=
 =?utf-8?B?T2M0R1dUL21Tc0xVSXgwK01nZkQ3bXhmcEF4eHQzMWdhZlh1OVhqWERIbXdM?=
 =?utf-8?B?K1hqb25xcHZkSkwyNGgrUHdsTjFzOHpMQVBlalR3cWFnajR0ejhFSHFWTnJM?=
 =?utf-8?B?Ni9IM0F0THI5S1AwSjR0aGlYcXhQN1NCbFdjdUpsTXJuN3dRN1dYNXNZc0N3?=
 =?utf-8?B?eTJwWVc5K21QbWhZZnFjS3FNQkM5Qm5SMDFwWTQ2OWVMR2YycWxMaERFYWwy?=
 =?utf-8?B?SGtRRytUMEJNNmZIODJjRE1qWFBzUnpOTFBTNTR6aW1Nd1lGeTlGR0NpZllq?=
 =?utf-8?B?R3QyUzFnMWhaNUVDbU5MeVkzMG1hTUY5Ty9FZmNRRExKVlQ0LzVBT0NaaFd1?=
 =?utf-8?B?eGdQbWJ6bUdGUzQwYTMramZkaHNKMnBMVHB1RVkyWnJhaHdTUzk1SERnU2Jo?=
 =?utf-8?B?T0ZEaGZSZG9IVjNYNFJ6b0RlTTVXVzFnRXhtL0IrR0RVMHY2elJVZytQeTV4?=
 =?utf-8?B?OVlBdTc0ajdVdjB1NHc1ZkNjZjRSZDM2aXowd0pzazlQWU5Sb0FkcUVYRXgy?=
 =?utf-8?B?bTVCS2NFMjFVWWxmdkVPb0tWNSs5a1NRQVNVMVZocVVnZHJDZUdlRkxabWNM?=
 =?utf-8?B?REJmVVUxSTdkZm43VmlVVWxaWDNTclRyN3dQa0lra1MzRXJqL0tnVmtkeElr?=
 =?utf-8?B?U0lVNEdHWnloTjJqcGV5WGJtbG1SRTFjdW9ZcC9xNURadzN4TU1KUzVUTnFG?=
 =?utf-8?B?U0FLZm9uczJ3ZmFMQ2F3NVE4Y0dtWm5mV0VXTHc0c0dJb0IzWUpUWGhIY1k3?=
 =?utf-8?B?dmRhVXAzYWNra2ljNzJMV2NCdER0YlJScjBGQlFhVGJCNDBycFQ1VGN1NGpI?=
 =?utf-8?B?SmtyVVdoYXNkYmJPUFZLSGI2eWFvQVY2TXBZdU1DZVVwaS9ySEt3ejNpeVhP?=
 =?utf-8?Q?G65zpP0mtmLtWSyhhcGB9mYHd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 569efc63-71b6-4a48-feca-08dddfb02c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 06:09:51.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vy0/RNLbqEP/2l6s6ppZwHDqYzaIjsaHKCPJ3PRP3qs1pa/B56TiprxbxMgsSMunTnnNDcHSxIcDyKDcO3TiJdRos+yW3NN+bJdaU++Jwow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6403

PiA+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIFJH
TUlJIGludGVybmFsDQo+ID4gPiA+IGRlbGF5cyBmb3IgdGhlIEFzcGVlZCBBU1QyNjAwIEZUR01B
QzEwMCBFdGhlcm5ldCBNQUNzLg0KPiA+ID4NCj4gPiA+IFNvIGkgdGhpbmsgeW91IGFyZSBkb2lu
ZyB0aGluZ3MgaW4gdGhlIHdyb25nIG9yZGVyLiBZb3UgZmlyc3QgbmVlZA0KPiA+ID4gdG8gc29y
dCBvdXQgdGhlIG1lc3Mgb2YgbW9zdCwgaWYgbm90IGFsbCwgQVNUMjYwMCBoYXZlIHRoZSB3cm9u
Zw0KPiA+ID4gcGh5LW1vZGUsIGJlY2F1c2UgdGhlIFJHTUlJIGRlbGF5IGNvbmZpZ3VyYXRpb24g
aXMgaGlkZGVuLCBhbmQgc2V0DQo+IHdyb25nbHkuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGZpeCB0
aGF0IGZpcnN0Lg0KPiA+ID4NCj4gPg0KPiA+IFRoZSBSR01JSSBkZWxheSBpcyBjb25maWd1cmVk
IGluIFUtYm9vdCBzdGFnZSwgYW5kIGl0IGlzIG5vdCBjaGFuZ2VkDQo+ID4gd2hlbiBib290aW5n
IHRvIExpbnV4LiBJIHdhbnQgdG8ga25vdyB3aGV0aGVyIHRoZSBmaXJzdCB0aGluZyB0bw0KPiA+
IGNvcnJlY3QgaGVyZSBpcyB3aGV0aGVyIHRoZSBwaHktbW9kZSBpbiBhc3BlZWQtYXN0MjYwMC1l
dmIuZHRzIGlzDQo+ID4gcmdtaWktaWQuIE91ciBBU1QyNjAwIEVWQiwgdGhlcmUgaXMgbm8gZGVs
YXkgb24gYm9hcmQsIHNvLCBJIG5lZWQgdG8gY2hhbmdlDQo+ID4gdGhlIHBoeS1tb2RlIHRvICJy
Z21paS1pZCIgdG8gbWVldCB0aGUgUkdNSUkgdXNhZ2UgZmlyc3Q/DQo+IA0KPiBJZiB0aGVyZSBp
cyBubyBkZWxheSBvbiB0aGUgUENCLCB0aGVuIHBoeS1tb2RlIGlzICJyZ21paS1pZCIuDQo+IA0K
DQpJIHdpbGwgc3VibWl0IGEgc2luZ2xlIHBhdGNoIHRvIGNvcnJlY3QgdGhlIHBoeS1tb2RlIHRv
ICJyZ21paS1pZCIgaW4gb3VyIEVWQiBkdHMsDQphc3BlZWQtYXN0MjYwMC1ldmIuZHRzLg0KDQpU
aGFua3MsDQpKYWNreQ0KDQo=

