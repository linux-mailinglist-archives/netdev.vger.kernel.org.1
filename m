Return-Path: <netdev+bounces-193542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7EAC4626
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F95174DA4
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293370800;
	Tue, 27 May 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Bqp0s6eg"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023072.outbound.protection.outlook.com [40.107.44.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65801E49F;
	Tue, 27 May 2025 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748312233; cv=fail; b=kUaqX3XLqHoGrN6C1IO8WOJ0nIZpmAkQO86N1iEmthHas48u5okRVcX7c4WLb9ZVZwhAdWSndAjrCokEw401tfAQBGF5OwDMdq9XrHbTqtxr5oxYoJHf09eVwbW1XOpK2xJMVvs/losaOrU5hUk662kTu7MdMLRVoVkadyVY4Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748312233; c=relaxed/simple;
	bh=fr5BKm45mwXrCCRUi2IRE03btLWxQMyslfWPYecRBuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iKroO7QyoZtCBAhO5t6SlL/A/MdGBi8QYlX5gawp3gq5ZD3yrkWtPfio094DhmTjtCaOZxLG4alWahITsYy/XGU2jhjXra4hNrrytQ7pRq1olPdy8mVJaKnpiKBvyt6u9DukaUKmE4D6nTRH3W5FAkYJPtEvLbizfyTYE34oowc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Bqp0s6eg; arc=fail smtp.client-ip=40.107.44.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9+NOqzkdm86VGMTNgNkYXxsJWJG6WXANuRtmO/BL6n89RQhAH+hygZKv3w+X0/IPBuva4HCX0nH8L4CCmZMvvmbxMafAlv+S7+vR/QJXb0/CnXQr12CicAhczaEXfcOGbSAi4C2DGkOxA3pQRz0QaVWak3SoRzy+CSrdmQQ2+zjg5xSo1oX/8Yhd5qtRi5o9+xqd+Xd0vB8Ujtl1SdUIaYnICn2iTAaA/FNinmuP5OqnxomEK/IAi6v2GwYi/wb27kx46Ybs87oNMaScInE9mDsnZAoU+j9efndGiNadxH4YZa4Vta+sOfV3GTpr4pkV0H8d6mobaJqDTdRu7CtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr5BKm45mwXrCCRUi2IRE03btLWxQMyslfWPYecRBuU=;
 b=g5wscMn6S5pJWD4hjqqXk8n7C8RzPMLgGNGKRltVJOdg/4IuZPRz1eD54LmhX/MB8c76r6+zkC0PWhitLBay4rx9hhpnetQ8w9dz/vjEK0Pvfklb9n2OHF2smJGPo+k29e9+LyTuUsYgqUKOsai1+clvTqLdNI7EEPwzuaQ6EV85Wbs3YMUMHEq+jn7uyo4+o3oUAmxdemyChBcFpzcVycAr8vh9AlXR3epdZlb/WyH1fGgHcpCrR0smZdDu+EDCi5AFfdwZs+O/vrOuGW0tCjU2A/Uoj1gwXzq8CguXHyi3cavzTFqPYzsP8e4Mk9Totz16ccPkBArGF55v42ZDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr5BKm45mwXrCCRUi2IRE03btLWxQMyslfWPYecRBuU=;
 b=Bqp0s6egcAtXxQjg2Dx1rBeb8tpsY8VNVa4m8kBLoo04NfYG8yHLiT2Jo39z32XADRqc7Wu9ufcHFtrr8q0aB5X8PEq+Wv/PCi8DwmSdNq4oHTKyCd2XZwgTOg2ltxxmhYjNgjBJFUY+LKeK6/4fxbcXmWUViRvsNLAQx7uqeZEL9Rx3Var03BiqOvtleKEpOzHSBlyDMbmzFzsHurAO1jJ+rGMDgih46/y7UqQXUqH7FdDYJdbE9U+AdZbgvmJFkfoaTwZTaghdxbI2ShmzP5g5Jcw6OEzQaXO57jq4B6Bb4MP+dveCK2uinwh4ptq3IHkTHhJQViWB1OpxJsGZDg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6792.apcprd06.prod.outlook.com (2603:1096:820:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 02:17:02 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 02:17:02 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, BMC-SW
	<BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0DogW25ldCAwLzRdIG5ldDogZnRnbWFjMTAwOiBBZGQgU29DIHJlc2V0IHN1?=
 =?big5?Q?pport_for_RMII_mode?=
Thread-Topic: [net 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Thread-Index: AQHbyWmaCWjiI1u+ZUqVQN90hno8zrPblJcAgAoyHhA=
Date: Tue, 27 May 2025 02:17:02 +0000
Message-ID:
 <SEYPR06MB5134C11D9A5072465FEF04099D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <cfb44996-ad63-43cd-bbc5-07f70939d019@lunn.ch>
In-Reply-To: <cfb44996-ad63-43cd-bbc5-07f70939d019@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6792:EE_
x-ms-office365-filtering-correlation-id: b6611c71-7c4f-4a49-e190-08dd9cc4914e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?QldlQXVEWnFkcGJuSHFvTFEvbitkVmpBS2Z2Q1lIendoUDkyS0VLODZBT2hJTHRw?=
 =?big5?B?Yy9aa0dTNkJLSXQwRFJPVXVJVW4wVVVQbEFsWkJMK3ptaEFaWnNPb0YwdXBScUN1?=
 =?big5?B?NlBFT2VacVVIaWl3eGgxWUpLSXduT3N6L3h2MFhWU0NReDlqZmtEbTdHbDV5NkNY?=
 =?big5?B?NVZ2ZGxYNlhIcXlDNXEwTEhBNnZxTHNZaEk1Q1FmWnNDSTZLOXluejBIeHFwZmdr?=
 =?big5?B?NG51SU5FaVpCQTJDeTdGdFlGT3pFUkFVNkZXZFBPaHBiWEhDcDBJZlEvemI4aVYw?=
 =?big5?B?ZWtUOExFRGZyNTJiN1kxRVFxQ0lvVE5oY253WGFWZHdFRTB3OFdTRGtxUm1xdkhy?=
 =?big5?B?alk5cmljYlRFclQ2VTJZS1I2WmVleHFzTlhmR0hsYjdIbi84RDNpaFFvSHRYOGFZ?=
 =?big5?B?RFhRTzdNbWtCeU1EMVdtMkRRS0VMV0V3MFhwQ2NidVA0bUR0cTBvUk41bnRIMkgr?=
 =?big5?B?eGtRWlYvcFIxbjdYYVF6QnNZRkRwRVZYRW5EcUxxZUNKKzJvcU5YUGpvTkhCdjJH?=
 =?big5?B?NmRSaXk2Ni8vQjF3QTlIVEQyZ3NKQnowNWJ1dmJiM0NoWDBZMk01ak5WUGNrZDhv?=
 =?big5?B?TjFpR1YvUURBbGJISk0zVGdGeGpFWWYrMEJUL2NrczJTN2hpaGpvdVVCVHk3Wlpw?=
 =?big5?B?ZVYvMCt1Z0NCWWpHMWFYdkJGeGJVVE5PY2VhNWdUek9RYmlJQ2ZFUVlVMVErTStB?=
 =?big5?B?aUo5ZjZqQkx1dzRKbzV0WmY4N0c3VWxXNkNyOHpIRk8rTXlyRWJTQjVUdkZZdFJ3?=
 =?big5?B?bks5WjBESndIY0JaVlUzc2VyUllrblhtbTFVMXdQLzY1dFlrZU9lUEY5cVRRYmlQ?=
 =?big5?B?djFUZXZQYWxYMmJaT01MUzkzNXEzdGxPd3d6U0E4VGZCY1V4bG0rWWlEU1VwMG12?=
 =?big5?B?djd1NVl2dWNaMmdLc3pJbDlDMW9vbHFuUUFubGl4UDB3bWR5VElhd3hxOHFaSTRs?=
 =?big5?B?ZG4wOWZLVUY5VlFLQ2ZlcGRMeHFLQ1U0RUJPRFFiSGdSWXRQUEpxS2FOUkJ0bUZu?=
 =?big5?B?L3ZkZTc5d3VIeVZNNkpBSDdKRm9oNXkya24zMlc2bnIxWXhHL0lkdGpHWkpzdmg3?=
 =?big5?B?M0FZSDN0TFJKNUlZMFkwMXAvL3pBOHlCM1BSR21OSlQ4cjdDa2c1M0o0VDlPQlds?=
 =?big5?B?d29VcHZ2UklrZGR0OHFiMFFJOVdQdHE2d0lETzNwUHVPbTUvSThLYThBVG90NnNI?=
 =?big5?B?ekRHVXNHbVZlc1FwcDVBeU15ei8wYVVJV0R2OTZKMG1aQTR2dkhKdGZhaGJscVUw?=
 =?big5?B?S002R0tsMlRQdU9Qdy9UZGNSQzNhWXN0cUhmU2VXTTlFcUhZYkJuemZRNWFqbU1n?=
 =?big5?B?aGsrMmVvL1M5YW55bHptM0FiM1dTRTN5ZUFmaENQWW5NT0d5VVJjZWY0NklGR0lG?=
 =?big5?B?ZExtYnI1amwxaFFHOTZ1bXI3anFuOFdLSW1wWFgzdGpyK05aWmZQeFROcmd2MjdN?=
 =?big5?B?VlRySGFKVnNVc2YxdmZPdG1XRUJIVU5YemR6NFdPdkdONml1U25NWGRjMHR5UnBO?=
 =?big5?B?NGwzL0ppOWNvaHdZZWZBZUtCTEx2aVR4bEYzamNQTFZrbURQK0RXTysxM0d1QzQy?=
 =?big5?B?STUwUjkyOUZyd1hYT2dsZUZ5SUE3b2w5WTJOVEh4MXdYbUtueXJneTBrcHNoQVNn?=
 =?big5?B?YjB6ZnV6ekt0c3BlNEdaWXlnaVlySUgwVGdlS3VNUFZMcEVtNHZjTzRuWnE4YThN?=
 =?big5?B?SkIxZ2JYMEEvYVlIZi8yRkxqNmdwdXkrU1g0cWxUVzMwZlRudHZmb1QvQXFjWHJ4?=
 =?big5?B?ZytyNk5tRmRrSDhSSWo3RHNOb01PTGg4enNFMW00YkdlZnQzc2o3TVFuc1VJNjBk?=
 =?big5?B?UmZad2lHOGYyeXE4SldUakNzNGYySUxNL1JHTm5LZ2wxOUZmZjU0UkxFREt2UlNS?=
 =?big5?Q?stFRimJfmuL27+7SPwoeFUCbLwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?eW0wNVZJbE0zRUdCaUJMYzh6QXMrQXFTRDE0YjFOWWFIV2VtKy82TDRibkloaWda?=
 =?big5?B?Y2gvTEZLMEF4UDhJYnhXaHpXbU1yRUxWZmxmbE9uVFh5bmJlb0JRODhkeGJuYUdr?=
 =?big5?B?V1ZMMm1SZWYxamRDUDE1dEluOWVvTEJ4L0s3VVJ3YmVmakJMcGdaL2tLNWxLMUtN?=
 =?big5?B?dkZ6VHlicSs2NnhWK2lDWExjQmRkZVJhNER5WkdKWDVwa3lrbFVqbVNnY3drV0Ru?=
 =?big5?B?NEg5K3lzWGpkVjJjTzhiUVAzMnIwYjl0cXhRdGR4M0t5R283NHcxV2xaaWh4Um5q?=
 =?big5?B?TVdpKzVrNm1pQjF3M2prVW5VdTZzTUV2QTk5WDg5Y1Brc3ZDekxwbm5Ualo2aCs2?=
 =?big5?B?MjA4b3RlZ3pIV00vRXU4M1Z6enlCckFKZE9wN2hQbmN2K1h0SnpFRmlzaHFyRDlp?=
 =?big5?B?SVdtOG9WQSt5Y0pZTlgyN3B5cGVydVpqUUUzSkFRQllTT25rUXluY0RCUHNXQjds?=
 =?big5?B?V3Z1UVVnNzFIUHc0akdpNmpYSDljRkhEYmxoYW4vT1pqNUhuUEVyOEZYZmJ0RVFJ?=
 =?big5?B?eXNXVnh0QjNiUVc5ZlQyUk5lRzcxOFpxS2xsRXBCTVkzeUJHZE1EdmtNWHd3bEZF?=
 =?big5?B?UGpoREorOXZYTlZFeFJpK3JvK3haaFZFajMxN1FaNzdUZ0pGdFlDMHJLSFFnb0Vn?=
 =?big5?B?dDRKckUwOEswV1poa1pIckNTTVZRT2RhcDltUkxVc0UyZGpzbWdIWmFHMEhpeDY0?=
 =?big5?B?aWZ2Qk5ITGY5NlBrVmJzSUZxOXg2eVpOSktCSDdZWml6dEJvdWxDVzVHQXNHbUpV?=
 =?big5?B?Mlk0aW1zNFJLV2ZZQzk3andwU3RTSTVmNHZEK1gzSHpZcWlCTGhONXhaYUI5TnIy?=
 =?big5?B?eXk3UzBkM2NuYlNaWUM4bFgxdnBUaHN0eDZZY3dwRUVBQ1BGbVFjOTM2eE5mem9z?=
 =?big5?B?YWRSOFE4T0o1SU9NWWY1OFVMT0ExRDJFRTFLTCswdHhRSHkzRnJ0NDhuSWl3ajZj?=
 =?big5?B?VTVSRXJQa1hjajY3a0cvMnV6S2ViZC8yRDdKbEp3YWZHQVB1YzJwVEc2SHZna1gv?=
 =?big5?B?WHh6U0FjMlIvVXVoazNNNGZiekVYNU5iaG5kQkc4M1hhNW1vKzhZNTZSN0Fnbm1J?=
 =?big5?B?V2Q3aTJSRzIwQ285NTk3SDBCVmVtUTBaRXkzNVNVMnE0d1hNK0p6TEhJcXVhOFBt?=
 =?big5?B?YzB1SEZiUUtDYzJUbVZ4MnMwdUF6ZmZ6anp2clhaMVVBZmFIM3Jja2dqcWV4TzNa?=
 =?big5?B?dE16UFhqbjAzSVc3T1BGSFY3Vyt2ZHhhcnFDdktZOTNGZXJVZnJPeE1PeVZucDdL?=
 =?big5?B?M3FJS2RsQkx5NndZZ3I1Z0xlcmlVY1BBTUtCMDRsVTdLWEdCakFLS2Noc3ZHbm9v?=
 =?big5?B?eEp1R2J3MzduRGFBYlhxaHhRaFpLNHNwVTdkZUo0ZXNHRkwxNDVvcG5GenJTT0cr?=
 =?big5?B?SDZjYmlxejhsZFhrMktLR0hBYndJcHZnUGpTSkYyK1ljT0ZUY2xyWU9sVDZIYUlV?=
 =?big5?B?L1BYMHoxVzFlMStXMEFTd3hyRml3MlVOY0hBVWFKZDBCUkJncExxY1dGOHJYK0xQ?=
 =?big5?B?N3ByK0x5VnhRYVo1K1pzUjdHaFJaZmM4cFJvUW5xbm5mdDAzU3Y4OXRFeEQveElk?=
 =?big5?B?Zm9YQmp1UmxLeTJWVmFlbmNJYjQwaVh6akRUcGVuQ3puWkhDdFBhaWJ5bFRwZzdE?=
 =?big5?B?V20zbkFrL0NqME9ndWluMFl2cFlwa013VXNZT0ZXYnhIRWEwMmUycDc3bHA4TlJU?=
 =?big5?B?eTkxU0ZPZWxjSTdzcC9ZNjFzQkhqVExIWXdwcVM4RSs0V0RjR1doc0txbktITWw5?=
 =?big5?B?TmdQdzFhNnprcG9BaFlXZnh1MVVBTUJscWxseXB4ZTN1SC9hV2hjK2FIdFNkMUxm?=
 =?big5?B?dUo2OFpXbHRWTTlmRDEwVVR1SXlZZTJSUnkxNm5ZSWJ1cjdmRW1DcEdKbStqWlI0?=
 =?big5?B?RUY2SXJyNXVSc1pHVitmTndJc1NIQjQwTTZEU3E4Wlg5SndyR1pVOW1ET3B6TEI3?=
 =?big5?B?WktQYjJJemFKY2k0L2VzOWN5cGYxOE9kenZmNFhJTG96Z2pUcGN4aXpEcGJOM2Rv?=
 =?big5?Q?LXyIgtO5nxJ4IC4a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6611c71-7c4f-4a49-e190-08dd9cc4914e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:17:02.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl6V/evyaClzZNpqVzq5JjD7LdPif4zY/R+Can+AnQimsd5Pi6kCSy+/F570NTIB88HmbdGNc/IRweW7nCsQGqp05l+JtDsuMmjOBdIeLXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6792

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBUaGlzIHBhdGNo
IHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGFuIG9wdGlvbmFsIHJlc2V0IGxpbmUgdG8gdGhlDQo+
ID4gZnRnbWFjMTAwIGV0aGVybmV0IGNvbnRyb2xsZXIsIGFzIHVzZWQgb24gQXNwZWVkIFNvQ3Mu
IE9uIHRoZXNlIFNvQ3MsDQo+ID4gdGhlIGludGVybmFsIE1BQyByZXNldCBpcyBub3Qgc3VmZmlj
aWVudCB0byByZXNldCB0aGUgUk1JSSBpbnRlcmZhY2UuDQo+ID4gQnkgcHJvdmlkaW5nIGEgU29D
LWxldmVsIHJlc2V0IHZpYSB0aGUgZGV2aWNlIHRyZWUgInJlc2V0cyIgcHJvcGVydHksDQo+ID4g
dGhlIGRyaXZlciBjYW4gcHJvcGVybHkgcmVzZXQgYm90aCB0aGUgTUFDIGFuZCBSTUlJIGxvZ2lj
LCBlbnN1cmluZw0KPiA+IGNvcnJlY3Qgb3BlcmF0aW9uIGluIFJNSUkgbW9kZS4NCj4gDQo+IFdo
YXQgdHJlZSBpcyB0aGlzIGZvcj8gWW91IGhhdmUgbmV0IGluIHRoZSBzdWJqZWN0LCBidXQgbm8g
Rml4ZXM6DQo+IHRhZ3M/DQo+IA0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xh
dGVzdC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwNCg0KU29ycnkuDQpXZSB3YW50IHRv
IGFkZCBhIHJlc2V0IGZ1bmN0aW9uIGluIGRyaXZlci4NCkkgd2lsbCBjaGFuZ2UgdG8gbmV0LW5l
eHQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpKYWNreQ0K

