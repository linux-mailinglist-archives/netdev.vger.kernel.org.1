Return-Path: <netdev+bounces-158356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64FA11787
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB73C7A0626
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330822DFB2;
	Wed, 15 Jan 2025 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="kiXcoUsG"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020142.outbound.protection.outlook.com [52.101.128.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3020CCD9;
	Wed, 15 Jan 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909833; cv=fail; b=pP5I08xTkN+teshf34+ggnjvXYwX9mQVn+iB9KGhxY2PvcINiY1HeexGYZ7XiL85+nXZaNQnDYB6JaONTm/XBqDW5ebys/bmD+jIn2G+Ma/d5ogfPmuOSCGHr56AonqcJNQpPCsV6pc2+c4fNKMhMh64t4TLQQTKb20SNy4bpho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909833; c=relaxed/simple;
	bh=eQmB2DTezgUTlD40DXM56m5LY5vNOVFMPSg2+1BZUcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSwa84yCZgHv1uhJKaGWI7V6H95JuK+kSBZjtyz9RklUCUo15QA69Mp+Cz6LIwdotSxw6RD9srPWDcC2s+fTmZHtCS3oe2qfneNAtEh7Ck6JM5+jtFZ4d8eSiC7ny036bz38vfQna/PE9kf5HzCaedPF6y7xtuks5njPsA31718=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=kiXcoUsG; arc=fail smtp.client-ip=52.101.128.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc6J16jpqBQ3Cuf+0yv6s9hd4jujpoUQ6IWH+SgOUx+F7mJiBvm7SF5MMkvSYDI3y5eSM1Y9atgPgPthx7/si8GNSm9peLlpFy/ijTg2LHcpovix9SFC9/bLrAlJnneCZfjbaXCQyBnQMWwIM/PEbt6M9v2ARMgVZ+Xg+6H/6okO9pB/og+7GQKBXfUmab54l4Y974TkatSKVW79qjqKFk+vfW2lz+iIJaBeOhPm/KVbq1dg7z7pIBr1MLf47S15PWY+2U61hSp6rg14SluYlPFWQboztZFEUjMoMlxzPnPpETx2xpmDrLKLChjk5JO89ZWjNKccz9w4OKuX1dHLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQmB2DTezgUTlD40DXM56m5LY5vNOVFMPSg2+1BZUcQ=;
 b=dBmc9n2UmPwPiRVlF+yjnKSvYv4UpIPs8KnsA2qW29Rn7F4h46KFaF9j6C5fwXEAeYNK5qwUTfnzkLx13GxlbCHLApnpz/E3/PGphARL2W1rZx/gxITADmOZghzXISiVTg1iKBZgyf+n+Jm9qZnnmPuqysn4ki/dxE5nE5AVfyryv0GWgGDOX0wM0CDQR/0zO728no2zGUz3yuCKPLwYgqvERc6FZXbt2Ht+AIBVGvSmBF9R+Uv7xdrNq+sUeowuhGS5ssXL8pfNH1BIJb66FHQKgrRq0dWsZhixeCNmDlloaOAAjbxFGcxBJwJRlQBPbDt+jqpUR3h2B4uud9164g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQmB2DTezgUTlD40DXM56m5LY5vNOVFMPSg2+1BZUcQ=;
 b=kiXcoUsGI7A15q78i1VqLRcbFVu2zNWG2AvV0+7Eqx2gUvyaDSNlRK+uy7kpGY8S7ACn6Rfjy08NbFV0J4bta62HnooYSX3rdfpcNEgQ1fckAInBANCwY2WwY2dQ7dGIsnN7DCpcG8DPc1f037MUILfOUN1/t1GbxjjpopQLCGUX04uvfnFiUeEo/5ukK5J5K0NxtznP6KD8D0f0NVG9+jZ8SIdYtmoQ4tyC7/nK8gs/8LoWAP+Yi5WDkV30qTnK3UyNSXGhlQfPLCd0RvSRhkfh9R7Ab0KC4P0F1x+/zC2qUyepXm+YpAKPKjly7CiRbZ5u9BQ8LLB8XLHLah9XaQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5332.apcprd06.prod.outlook.com (2603:1096:400:215::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Wed, 15 Jan
 2025 02:57:05 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 02:57:05 +0000
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
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0?=
 =?big5?Q?s:_aspeed:_system1:_Add_RGMII_support?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNw?=
 =?big5?Q?eed:_system1:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXCAAFgBAIAENTRQgACHsgCAAAOEgIACXbCw
Date: Wed, 15 Jan 2025 02:57:04 +0000
Message-ID:
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
In-Reply-To: <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5332:EE_
x-ms-office365-filtering-correlation-id: 92da8928-5b7d-40b6-921f-08dd35104b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?RUI2ME43RGVlcEFxcVJmWHJmMkE2bkx1eURtZkFtSnVpejZLZ3RSbWZabldJZEJC?=
 =?big5?B?ZVk3WUw3NzIxdS9mUFVnOUtqbS9JYStKNmVnUU8vcjAxVHV2WWg4Y0hReVo3M0V5?=
 =?big5?B?a3JiWms5L2FUYW1yOGswNnd6S1VUa1VKSk9Ncm1hL0QvSGx2dUo5RHIrSS9rQ200?=
 =?big5?B?NGlqTGNhajlBc3RmeFFnYzdvNEF5SHRYYmZDa2xqUSs1RGQrSDRGdTJrb3dybUw4?=
 =?big5?B?Q0hJZ3dqYlJoUG83L1c4QkYxZWNPV0oyWFB1SW45SEkyMGZlbkVSNFprRlM5eDlh?=
 =?big5?B?dTBkMld4YjVKREVaeXBHWWlwZmJNUmcxSDhmTk1sa3JmblROUklTOXdvQzV4QjEy?=
 =?big5?B?OE1XNE8wTHROZlVmcnJMT0FXQkJwMlM1T2pUQUVWNUZhdkZUdFEwb2FJWUcwWWNK?=
 =?big5?B?SDdya3o2Mm8wRWFNRVQvcUVpblVMQVZxWkZlY0VMTG5tcldJR20rMXQ3bFQ2U0M1?=
 =?big5?B?ZHFQRk1McEtEWFBwd0pYdkthdUdqbi9yclIwUERrWjhHNENGYVlTdGx5RU96cjJB?=
 =?big5?B?d2pSeldsWVhwelNaaEVpdCsxazl3N2g2SE5ISUlCOFpiZDhHOEd5cENudjZKdEJU?=
 =?big5?B?a0gxTHR3MCtQYnFYS0VKSGppMUgvNkZZRWc1dW9QczdKRHp5RmFhVzVJcXEwMVVP?=
 =?big5?B?d3dyMVlwa3NIRzlBTUwzQmVLVStnYURUUDNPZnVRUHp4RkxrUk5sVG5TT1AzTzlW?=
 =?big5?B?WWhEZ3FrVUJuWHJkZllmbTFQNXVBVlpJNmp3VGdCakovWWtQMVArVlozNmg1VUV5?=
 =?big5?B?YzBBREpkRHhEdEVvdEFOOS9nelBrWXhhUHFRRTZCUVR6N0VFMmNaOWVRV1lrOXdN?=
 =?big5?B?TllVTTBUUDFQcnZiTXc1VUNNNE5WYTliaGlMSC9uSEM2TnpUby9ZdXpFcW1DdXQr?=
 =?big5?B?NWhhc3NXbTJ0N3BCL2RIL1ZpRjNISStMT2dwRmg4R1F5dDM2R2FzVXNJbXlXZTBT?=
 =?big5?B?WHJKSUZ2NXdjbzB4Tm9BKzYrK2JNZ3E5eWtNaXMrSzFlcnBEMW93L1EvUnlXMVl5?=
 =?big5?B?RVZrcVN5U1lTbzFCQWVnRzA5ZFRxWWNvU3o4NFAwdXFaZXFwcUhFR0xUQTd3VmVJ?=
 =?big5?B?M2JlWFNyQW42ZnFYRVVHL3JiN0tnLzF5WVhTY0REK2FsaXIzYWpmam1YdTJoZlp3?=
 =?big5?B?YVU1RG9WbEtITjAyNkFIWERNY2RQanBKalFaWlpSank1OWtDQWhZcFBhcTZweW5a?=
 =?big5?B?cUJtaE5kVERGcHBBcEx6SkFCc2tnR3Q5TzdpVW82RlJHblJ2SXljd21hbWlwL2Z3?=
 =?big5?B?M2lyN1QvRkNiL3FPdS9OWEFYNjBFbDROakVRRFBRSTR5UGRDeTg3Vm5mVk9yVi8v?=
 =?big5?B?REY4aTNUcEk4SVZzQ0krbEdLZzkyRnhIcU92TUQ4c29tM1RDaU9qcmZRWW9sR056?=
 =?big5?B?TDR0eUxXVFVWR2krdmd5Ti9wVFpHOVhxdEllT2xXRWd1TkZid3pWVDRjMWNEUUMx?=
 =?big5?B?aE5iaHpvVVNwWnl5b3lVczJCcUVNNmx1azlxdmR1djV6aG8wQkdPK1UzQklqSFRh?=
 =?big5?B?SkphNjEwdm9LTnpDdFB0UDVTVXpIN2VWY2F5MnR6ZmFqU1o4VzZtaGVla1lOWTZ6?=
 =?big5?B?aCtacE5UNnlnWkJkQVVZWDZEWXo5Q0xDUmdPQ1ZETytLdEwvTkV6MTM1QVAwNDJK?=
 =?big5?B?Mys3aVdOWWZRV2hRdXRqVUs1Mm1XUDB5L0NkdEJDSWlLWmdZZ1lhMm9xMWtqZXdk?=
 =?big5?B?dk0wOWxkNllQNTlLcCswcFV4QW90bldKcHRmRE0vaEE2UFQrUDEvSVJ6ZSs4Q0sv?=
 =?big5?B?eWQvUUtOeFhvWTUrdTJGQ010MmMxNHRuaE9YZEFMQUJmdTZ2Rll0QXNVYVhKSnc2?=
 =?big5?Q?Byiqz6ys1z4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?RVVSYW1KL0VIQlBtU1RycS9jR01ZalBHRXpNcFRXZklwOXFnZDNORDJRVFA0dXNV?=
 =?big5?B?MTZXcWtmNkxRclNrL1k2b0laV1VEU0JiNUJaY2lncXBBcWVNcFJKcDZCUFNRNHRl?=
 =?big5?B?WnpvZFNld0NFb0VmN1YrODQ0eDYyenM2ZHZ2L0kvZjJoMFY3VzlaL1cvWm9wQUpD?=
 =?big5?B?TjVVQ0R6MFp2a0hlU3l3QXpYYVhzRm9tQ3Z1ZGYxTFhES0Z5TG1Vc0NhNkgzY2RI?=
 =?big5?B?VnpYdHhQNDZzQnhqRko5RHFlZHI4eVpxcXNLU1VmRWIxdG9Od3FVWU53MlVhQTZy?=
 =?big5?B?VjhmNnVzc0Q5a1FwL1VZRU9LSE0rTW14V0Uza0x1bWNjU0pzODNDTktCaytHdmpn?=
 =?big5?B?R0k1Q3JHcGUzeE51dnFpSFNYdTFRNHQ2cXdScFE0RXpiZlMxTHdQZktiYVB6REJV?=
 =?big5?B?RzA0MVFQSTQrOHVCZnJ2Z1R6MWsrbVZJamdjZ0xhZHBtRmc1U1B0NXFudXdiTm04?=
 =?big5?B?TEtTQUpLUm81WmpZM09LaU93aXpKejUvbDVpcldGbHl0dUtIb01SMmp0c29NVStr?=
 =?big5?B?d3RyWis5Rnl6R29sYmludlE4cmw0MkRFV2tEMCtiV2dqeUJXM2tiY1c5L29qck81?=
 =?big5?B?OFV2L1EwRitsVTVhU2dMOStBY0VvOXVtdlA1L2hnRFU4SkwrUXBtTUx3RUZobGlX?=
 =?big5?B?Nzh3MkM3bnh2M3Z4NE1ydVM0dXFzVzR0NjRQR1UzeUNXbmt4SFpXL3ZTUkpOeUpj?=
 =?big5?B?U3VCVFhNenloQ2RaS09rZVNsa3dpbEhKQ20vU3pqNERiNEhDZU10eHRDTHhkbDU0?=
 =?big5?B?TXNPQUYvYjZKTUdnSm1rbzNnTS9Dc1hBUkJnMHlKUjZ4d2hRTmhqRzRmYmdZMUNE?=
 =?big5?B?UGlMSnVUTVhqS1NmRWFybkVmZFB0NzJURyt5aFU4MUhWcTQycFdBclR2UTJIMXdO?=
 =?big5?B?N2VybFhaUGRUdHFrUlMzUUNWa25NWFdaTnBOVXJxZWQ2S1pFOURFZkRNTHR1RWJL?=
 =?big5?B?ekxpcmtvcTBkS0tSbk1HVVpRempLL1QwaGJNSit5eWFncUQ1RFFCTE9iOHRXOVJv?=
 =?big5?B?RDdoaVFGOHIydFZYdjRQTFhMdEZZc1ppZmFqczM2T21XTVE1WW5oTTBLd0d2OWdL?=
 =?big5?B?U1NGcTZ0OVIxNzhxRU9NbkZ3bVVJKzM4UDBReGZoT2VIVkh5VU5XVDRDalBqRXRP?=
 =?big5?B?c1E0MEEwTGkweDF0aHBlQmxwQm9HWnhxNTMrZk1WTDRWZGNnY2J6U1Y2bm1CS3I1?=
 =?big5?B?b2NOd1duWTVNejNYTUl6alNMQWlZaWhqN3N4UXo3Vm1xM2NWdWJ4ZzRlWC9VdzVk?=
 =?big5?B?L09iR2RsMFh2eHVHZlJlUURvQzFsUTIxazJac1ljT01mQUtVMXBFbFN2WmlZcVdH?=
 =?big5?B?R2NmN09RakMxM2tHYTlZcVhlUW9PNzh4YmhLZWY5T1JEKzJTVnNySUtCQTErMy9T?=
 =?big5?B?VVdZSlM4Z1JQelFkcjNhYjBmODBWM3FCUjhySzc5a3cwdzJsNVo4azVhaVowSEhT?=
 =?big5?B?bjI4SFhHbjRUdEtQOE9LclRFSG5BL3pjYkgvVU45elVseHVwYzlyRkRPSit5THor?=
 =?big5?B?Skc5WmQyczhRSkZvOGhsS0VUcGxMTlRwZ3JLQk0wN1E0TWtiZ1hlaXJmMDg2Ny9F?=
 =?big5?B?YUxhK3VEcSsvWmRWVmFMcTZoR0pQcGJEb2tiZnpYWVU1VHZlczZHN09icEpOS0xH?=
 =?big5?B?dWMyREkzcVByUnlMWGdOaDJCOUNZSFVpY241TEFQTTZkaytYdExCNmQwNmIyVXVh?=
 =?big5?B?T1dDMHBhb1NRamZxT1ZuanNDVjRXYzNucVV3d1dORGcwbTI4OFp4b1prSDJVL1BL?=
 =?big5?B?NERmUTB2aXV0b1pPZ2x3VHdpN2ZmMmU5cElFTE9DZ3ZuTzkxWSsyR1dNYkpNVTRy?=
 =?big5?B?TnU3U3pDbFIrOVp5ZHhEUzk1c1RkSjBiVXZQUDJsYysyaWl3YUtWOGRZV0pMVnlG?=
 =?big5?B?Ymt4YnFQWHlJK2NiTWRweVdOdDlTK0VwdHMxNm05Nlllc0JqK3J6d1kvSkhaZ0t6?=
 =?big5?B?VGxQZEIyWEovcEJQcm1hMkQ2Z3VQV20zaGZrTW1IcEZnOEVFUk5mMCtnT1JDVERX?=
 =?big5?Q?k7Ug7UCqzJnYloEp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92da8928-5b7d-40b6-921f-08dd35104b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 02:57:04.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsrfS+pS2o3uHWUiAWiX6c/+IfUd0Hijn2JHJfn9/1uh2o/EWmbFlpk8M/MGFF/SbnFVySnG24F/8PPyZWH9Eyn+j+W0rbpw+dT8SBHs3VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5332

SGkgQW5kcmV3IGFuZCBOaW5hZCwNCg0KPiA+DQo+ID4gVGhhbmtzLiBXaGF0IHdpbGwgYmUgdGhl
ICJwaHktbW9kZSIgdmFsdWUgYWZ0ZXIgeW91IG1ha2UgdGhlc2UgY2hhbmdlcz8NCj4gPg0KPiA+
IFdpbGwgaXQgYmUgInJnbWlpLWlkIiBmb3IgTUFDMS4uND8NCj4gDQo+IEl0IHNob3VsZCBiZS4N
Cg0KUGVyaGFwcyB3ZSB3aWxsIGtlZXAgdXNpbmcgInJnbWlpIiwgc3RpbGwgYWRkIFJHTUlJIGRl
bGF5IGNvbmZpZ3VyZSBvbiBNQUMgc2lkZS4NClRoZSByZWFzb24gaXMgd2UgY2Fubm90IGJlIHN1
cmUgYWxsIFBIWXMgaGF2ZSBzdXBwb3J0IGZvciBwaHktbW9kZSBwcm9wZXJ0eS4NCldlIHdpbGwg
cmVmZXIgdG8gdGhlIG90aGVyIE1BQ3MgYW5kIFBIWXMgZHJpdmVyIGFib3V0IHBoeS1tb2RlIGFu
ZCANCnJ4L3R4LWludGVybmFsLWRlbGF5LXBzIHByb3BlcnRpZXMgaG93IHRoZXkgaW1wbGVtZW50
Lg0KDQpDdXJyZW50bHksIHdlIHdpbGwgcGxhbiB0byBpbXBsZW1lbnQgUkdNSUkgZGVsYXkgaW4g
ZnRnbWFjMTAwIGRyaXZlciBiYXNlZCBvbg0KZXRoZXJuZXQtY29udHJvbGxlci55YW1sLg0KDQpB
dCBzYW1lIHRpbWUsIHdlIHdpbGwgdGhpbmsgaG93IHRvIGNvbmZpZ3VyZSB0aGVzZSBwaHktbW9k
ZSAicmdtaWktcnhpZCIsICJyZ21paS10eGlkIiANCmFuZCAicmdtaWktaWQgaW4gTUFDIGRyaXZl
ci4NCg0KPiANCj4gPiBJZiB0aGF0IGlzIHRoZSBjYXNlIHRoZW4gSSBjYW4gdGVzdCBpdCB3aXRo
IGN1cnJlbnQgY29uZmlndXJhdGlvbg0KPiA+IHdoaWNoIG1heSBhZGQgZXh0cmEgZGVsYXlzIGlu
IHRoZSBSWCBmcm9tIFBIWSBzaWRlLg0KPiANCj4gSSB3b3VsZCB0aGVuIGV4cGVjdCB0cmFmZmlj
IHdpbGwgbm90IGZsb3cgY29ycmVjdGx5LCBhbmQgeW91ciBzZWUgQ1JDIGVycm9ycywNCj4gYmVj
YXVzZSBvZiBkb3VibGUgZGVsYXlzLiBJdCBpcyBob3dldmVyIGEgdXNlZnVsIHRlc3QsIGJlY2F1
c2UgaWYgaXQgZG9lcw0KPiBzb21laG93IHdvcmssIGl0IHByb2JhYmx5IG1lYW5zIHRoZSBQSFkg
ZHJpdmVyIGlzIGFsc28gYnJva2VuIHdpdGggaXRzDQo+IGhhbmRsaW5nIG9mIGRlbGF5cy4gSSBk
b24ndCBrbm93IHdoYXQgUEhZIGRyaXZlciB5b3UgYXJlIHVzaW5nLCBidXQgdGhvc2UgaW4NCj4g
bWFpbmxpbmUgc2hvdWxkIGJlIGNvcnJlY3QsIGl0IGlzIHNvbWV0aGluZyBpIHRyeSB0byByZXZp
ZXcgY2FyZWZ1bGx5Lg0KDQpXZSB3aWxsIHN1Ym1pdCBhIHNlcmllcyBwYXRjaCBvZiBSR01JSSBk
ZWxheSBpbiBmdGdtYWMxMDAgZHJpdmVyIHRvIG1haW5saW5lLg0KDQpUaGFua3MsDQpKYWNreQ0K

