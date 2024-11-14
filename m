Return-Path: <netdev+bounces-144649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3CF9C80B3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F231F247B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9871E9076;
	Thu, 14 Nov 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="PgsSq8i1"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E841E9070;
	Thu, 14 Nov 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550941; cv=fail; b=EJaa4tD7Z46NIehNRZ4hYrABDla1Rzon7FEse4gNLX7o9rPNJmxwnJraPwF7LoFBDJR3lLCCJY8/Xw0OERQgcbZhWfgetizBhQXCZmYcqenmyMea6khM7u7rnjFbeOf35FXdfmTO2uo+Kk6oF0FYOo8FK8so1prPoUpL3A0jE0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550941; c=relaxed/simple;
	bh=TDsNAMmj95X9e0eyTx4ADPzSG8UUocLmWSY3elKP1UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqzU8wVm5l93D5U1U3IrxBEF4QWn5kVYz2SAk0b//tIBWaF1naDa0q+2lqmLuunfXrHW0qkvTYxWrKlqTr8VhzP/U+F8sE14UNQKPC7evcdCA+uSpS9KNHWKgsd+hH5TXnPA7KPhUGPDusuROzs7vZqCOB/x9uUBhH/Mu1t95Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=PgsSq8i1; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz8ze91zEqN/nLz7mkYaGOnB2MVK1z7/GsXxx5MRpuRcgpDJy53p2JLZSOgQksRTMx1P9NhqOj5wBt/C/MG0w1Jt8GZck0DvbM21VMDyuZ5KSA3Q250wS+6QfCh9Fs0yFaeGgtk/sDxrCzY42Hdd3utRi7rdic14/NEltv8Wygzk1H2ywPYz484mp8mQ4EfU/ai8Z0/ZPqiUqLRbEA+aphT1bibLQUzg4t9ZK5Srng8oe8BlzsujI5tzC9sA3upHIIut3mYtAIs3OBlmb7TnEgZDvhXQThESOsJw2bx2TDGsAVPeQ9YTAzI5bnVL1VWmNPQIpI6Qf6SBV+BZp12jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDsNAMmj95X9e0eyTx4ADPzSG8UUocLmWSY3elKP1UQ=;
 b=IAIWRzuFqQbWBEHpJkSxcra3/lHtCU4AStm9a+UYREeW6jZBqwzkyMmxnWK9Hx1RccCwUpOPs50GP7hT4Iplun/e7HX9z3bprSGU01ZwSkShWC7OWVwn45uMF5BYw3TvNnuUByKNi0A+xJd1at700bMUyIxU7XhvTW4a7a5LnTZIELS/9nxxqpDddDddkOoKpyKJTaaMTedBIi5tusMiyXf492XwKs1qmjG698CrAV+lUxOFq9Ie5LYHQ1IC3acJsbr+3rcZxNlde2nmzbNsEsF6qO63J+frd2iFIegYqvekKTEk0qldv/olRBF3B9doGsb1Mmgul0jRCflIDRXYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDsNAMmj95X9e0eyTx4ADPzSG8UUocLmWSY3elKP1UQ=;
 b=PgsSq8i1LxIFliIoNbIY+ELXTNMnpJIQcy12JQHEiM9JyqFyGh4nenqf2TcjfQZ11Uw0V1a6iMzVGzQHT6bk66egbwGPZuTMO/F4bzgB1mAD5mj0dk+YgbI6GFP/pAJyBjJHGrtPgB6LQziuPGLcSV4bIirnTM2dV5tshu6kaigPCUWBYc9kx3sawQdWsoHGtNS+TKwBQEsidVIC4NNJ/X/ixjMbVwMhnc2dR0TcrncwlM7QVwreWdQC6d2iCcCTmUJ7AxgYhDb4g5NDm9WJ0o2KZJ/ubkQqq3L1RiUMcnpTPmK23YhpPy8i5hUqTYs2k70k5jlAmHmSL1vCyepjng==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5904.apcprd06.prod.outlook.com (2603:1096:301:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 14 Nov
 2024 02:22:16 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8137.011; Thu, 14 Nov 2024
 02:22:16 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDMvM10gbmV0OiBmdGdtYWMxMDA6IFN1cHBvcnQgZm9y?=
 =?big5?Q?_AST2700?=
Thread-Topic: [net-next 3/3] net: ftgmac100: Support for AST2700
Thread-Index: AQHbMQZSanPeA3sdNU6SnHF6uEd5/rKyClEAgAQLA8A=
Date: Thu, 14 Nov 2024 02:22:16 +0000
Message-ID:
 <SEYPR06MB51343BB70CD66E547D637FE79D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
 <20241111123526.GC4507@kernel.org>
In-Reply-To: <20241111123526.GC4507@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5904:EE_
x-ms-office365-filtering-correlation-id: d45f5988-7688-4f26-e187-08dd0453285c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?UXRlS3Nrc1NqZWZTaHhOem0xbmNHYklBWXQ3ekNNSDdOR3dlaW53djF5S0pYVFU1?=
 =?big5?B?OWtvRjRzU0dJcTVNdjZTdm4vZzJKOVlxTFlWdHd2ZE5tNG4vcGpsejZTUSs3UU1S?=
 =?big5?B?ZE5waWtjQ0QvYnlacnRCUkJER3BPWkhZdS9ZTnU1QmVIZEo1dUFhc3JhMWFKVHpO?=
 =?big5?B?WXkvK3JEZXRLeFBzL0h4UXVVSHNON0dKc1JaUFFFTVU2cWp5bHpuWjErQysrVDc2?=
 =?big5?B?QWUvcTAyRGZuYzd6RWg0M2ptd2JVenkxREJJR1RseTdFUE81U2xNYVEvemhycVg1?=
 =?big5?B?aEhLaUUrM1ZYM01TNENqYnFHTitJUkx4MzhnTVJFM21rcmt0TEVpRXlKb3BuL1lP?=
 =?big5?B?OUZ2UVJVRVZmcW0rQ203aDF2dlREK2M4Q0tnNUwwd0czVHlzSXdxNzVTcDNRS2pq?=
 =?big5?B?YzY3azJVaUpZdjdFSWRvL3djQU8rUVhYcEpJV3JPTE9oWldOb2o0YkliL0lrU1dY?=
 =?big5?B?Q0E2TjBwRzUxVEVIaVgxNWdBelcvSXVBN3ZVL2JyZDdMSVJ4dGM2a1JNYVZ3djRq?=
 =?big5?B?V0RJZWdObzRnbk85YUtGdE9ldllySVlwUElPYko3S2pvb3o1THB5ZE1MMWE3TmFJ?=
 =?big5?B?STYzS0Z6L2IyaUdrajlBWlhpbFhFTmZUckpEdGNHQnFEZTVVRFhnMjUxM25SM2JQ?=
 =?big5?B?VGFXU3NCdGdReWNuTUpnN1lUZ2lnOGFyei9GUlhEanJRNC91dTNabkVicnlPSzlC?=
 =?big5?B?V3NIRytxdWZBK1o4MTZXOGYyN0Yvd1ZRNUdSTDUzL0gvMW4vTW5vMnpNVE80REp1?=
 =?big5?B?dlZ4WXpqTXlaaUZxSXpOSDFsN25CN3lqWTVlM1Ntd0tQbC9tdjI1QURDZzB6ME5M?=
 =?big5?B?K0Vrd1VoN2N3RGh6MUIwM2UyR3RQRzZISGVvMXdXSXJkelFSNzcyb1JKOFFBREtP?=
 =?big5?B?QU9TR3oycjMrS3YwQWVQS2JGMk1ocGdUTmxIc2hVeGpBYmtXSEJXR3UyNXpKQ3g1?=
 =?big5?B?TUNLSzJVU0dGclh1SVdWbnNrODlrSldPWFZCL01qbytsMU5vWjBybS9EUzlkQzhp?=
 =?big5?B?M2NMVExDN2lNVGRtVEpzNDYwbll0SDBUYTR3VVNjdU0xWC9MYmNZUTF4djkrR1VM?=
 =?big5?B?S3hYeWI2U2VJQTBBekI1UFpuc01LUExGRGN2Q0xiNHNuSXZmbS9DUG9LWm82Z0ZT?=
 =?big5?B?UVpCK0NoRnlmSXJsNFlycjdlV0hPTVkyb3h1Zis0WlRWQW12dWQ5NFZGQStMTjQz?=
 =?big5?B?VUppUWhqT09ONmRWZ2I2TW9VZWIyQnA2bFA1WTBVenNXaHFEWVE1UFRoMG04VTdF?=
 =?big5?B?dUsvRDFQQkZMcFc3eEVBc1ErcHF3cEs1akNXdUFFbVNCUllNcEpsTk9yemJFNk9W?=
 =?big5?B?Ry9GdUR1RVptVGk5Lyt5MzY4S3gweFVkMDBLTlh5dnB1cmVmTU5iOHhtSzJpVEpo?=
 =?big5?B?SmFUcG0rMzV1MHdFQUlkL2NUT0gwNlV3U1plNXFSS3o4U1dUeW5hUFlOTzRXOEF0?=
 =?big5?B?Z3Q4dUxabHZ6Nk5hQ0VXNlVFamFFUHNZV21iMGMwN01qMXhpelFTbk83UHNMQXhu?=
 =?big5?B?T0grVjVQenRlNURUWDdCdGhmelp0WXNnbzIrdjVzd3AzcS81elZVbllvOEYySTdw?=
 =?big5?B?Wlg0NlZwdUJlR2tiOWthUFBoUEgxTy9yUFZHanZnalh1YTZFZVo1bDhGZjN5K082?=
 =?big5?B?Z1A5VXVZdktlWVJtRzJYd0RYTzduUnNqVVA0V2lINDRJUjRjSXFySk9KUFBqNmJW?=
 =?big5?Q?L+hAN6xHPl5w1iPxbd21SX+vAEB3ziG/Vc3+iA0GhAs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?WWo5UGthalBEbnhGSmpza3hNMk5LWXRWUGRYc0VJTmorbGtMTHVYMXBHNjYxRWhq?=
 =?big5?B?WUJybTl1VnVyN2h1bXdFQW5kUnhtVklmSjhaZEEvdWpCSWFIOHRDYU9Xbjh4OTA4?=
 =?big5?B?c1NzRXFRYkxOQmhIamZmZktZT0hFWldKNTNvWFpOUXJxSk15bjhpY3pQZnJyS3Y5?=
 =?big5?B?S3IzdC9VTktOa01US0VtbjdSYXB5SWFUNFVpSlhtTnVKb09QdDVqN3pvQlpBZDVT?=
 =?big5?B?S0ZqaUFwcHNFbE1sQ29Lay9PYTI3eCt5Nk1lK09zM3hTLzlweWhnTWppNHJCNWo4?=
 =?big5?B?RmozdnZMMDBMeGNnckphUjM5clJNV1dQZEhncUgwSHJpcVpzVjQzd2tjcGdValdk?=
 =?big5?B?c3dOOVA0SE9KMVJ4Vm1kYUp2NVQyc0tUU2sydktTTnJ0Y1FZM2NadW1nV1pwWjdB?=
 =?big5?B?azQvaFlYcS83N3g3L01BWlhmSS9QWDgyaUtLN2Y2NUsrQklmU0V2UjUwRlU4dTFL?=
 =?big5?B?RmRjbzg2OUM4cVBFd2d1MzJRWm5lZGhnN3Zxc0RVM09zUC9yOGw0RzNlOFB1eGp0?=
 =?big5?B?ZFcwdlRyRk9OMXZ0TnhBUkxBeDFDcVBKbW9DeGpZcmdUQ0VkUUgvdTYyRDB3NVU4?=
 =?big5?B?elgxMWdNMXFNU2ZmaGkvOHJIQUtsS3V6TkhnRHBNV1ZRY09mN0lvaHVoVGliOWpC?=
 =?big5?B?aDE0WFhHaWUvVytkTjdQVlNlKzU3NGl6eU9BRzBlRkV4ZE5JMlpianU3WXRBTTRS?=
 =?big5?B?ZDVkMk9XeG05U2x2ZUhxUENzdncxUndWVCtra1ZQNkdoWGdGd0xmamZMTUtGWlln?=
 =?big5?B?VEVxMWIyKzljTmlmT2VuMDhJWkVTNHVDd3Q4MnZmeXhQT3ZzM1lvL2FOZ0hRalU3?=
 =?big5?B?R05PblNQdjB4UHdLeDR5VUhMZzlTNnQ4d2FtRGk5ajZQbHE5aWZjTGFpWWY0ZUdB?=
 =?big5?B?eHN1TWNSaDM2ZlZxcEZ1RXlabmZDSU5HeVRjTUZCOEx2TkM3U0lHZGdibVoxS1Bu?=
 =?big5?B?eFhIL1RxR0wybXdwVjdOUytaK3lBSkxES1czOG94b2tSNm80UEtTMktmejZQU2dT?=
 =?big5?B?cXUrN0lVSm44ZVUwcExIcUZvTjdiRFVFbmZNVkpSYjhVOSs5aEhVcmdjSmxpVUts?=
 =?big5?B?dlZOa0I2UHlHcnJnRU5lRlljWlhqd2p0WEdpa1pha055dXNOejFDby9hNDhhTXZF?=
 =?big5?B?R2ZuY2M2NXZUSUVHZy85UlVCbTE0ZlNqRnprZmZjNDUwZGNTVGtqSkY1OEs0YXhz?=
 =?big5?B?YXpKVjE0OHdpRzJvUkY2MGhWR2oyMTlDeUNaZndJSUwwS1VkbXdNSDJXdVZyNzBs?=
 =?big5?B?ZzRtc0VtckhqQXROM3FhUlE4MFYxUnhuM3NPakVmWGJmUTExMmxqeXErSld2TjlG?=
 =?big5?B?ODIyaGZSRE9Nb3lXUFpNd1c1c1dSVi9RdHNuSEhwYnkzYk4yMDNad1JDblVXYnlh?=
 =?big5?B?RlhRNzZJck9MSUtybDdFOTNJdDlpd2JBV2JraG42MzVEcG1wa3YvL2g5TGRQQmsw?=
 =?big5?B?ajlKYjZzd2MyZ3B1b281Nk8xdUJVdXdETTN5Q0NzcjZJNGhFOWtNY2UyYU5Qa0s0?=
 =?big5?B?WlY5WFdHVDQxYjhKWUVsVWRLc1h3SFl1N1VHOHFnU1dtOWNySlFwTy9oeDg2SUcy?=
 =?big5?B?UGd1TWJtMUZycFlTWHJ2L3o4OHZ2SFlMQURHTHh0bW5vdWl5Y3Fidkg0S1pwRnV3?=
 =?big5?B?eUUweXBuMnN2QTFnTTlqZ3hlWmxRWmVScGFnS09QdUJsSUdjdE5GYmlzby85RUEw?=
 =?big5?B?ZCtudFc2cjFZak1tUzhZbVZRMkxqOWFLV3F0WVhhZkNtTTZvdjZqV2ltUzB3ZjZl?=
 =?big5?B?SE4xWUJGL0x6UWZYZEtVZlBXSHNpbDhIYlZqTUZhemh1aDY4RE1CQWpPR1FFM1Vz?=
 =?big5?B?WFZsbWRtY0g1Y09FTWNRZGc0SldjcHFIYUszQ0xxbDRKeStYVTdpbmFlVk5qMjdR?=
 =?big5?B?YUc5TXJlK1ZYaFRXNjVkZ3F4Y0pTY291MjN3alprNS9wdXB6blY3U1ZnYTdWUkxq?=
 =?big5?B?SHMwTXBISXJpczA2ZTlOTFErTXdycDhRaGRaWGYyV1JaZXhRSjRnaW81TEEzSEUw?=
 =?big5?Q?T+mrNOgnImLLwMeq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d45f5988-7688-4f26-e187-08dd0453285c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 02:22:16.2189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgMlmxpOutbsii3YjEO/vQoBzkevfsNGqqTwMmzU9sU7bVdOCI679McabDv1/mjzyyeObtuOc9wnEvEcjNUrLtnHleIgUlE2WRvOPfwC+to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5904

SGkgU2ltb24sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IEBAIC0xOTY1LDE2
ICsxOTgwLDI3IEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAwX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJCWRldl9lcnIocHJpdi0+ZGV2LCAiTUlJIHByb2JlIGZh
aWxlZCFcbiIpOw0KPiA+ICAJCQlnb3RvIGVycl9uY3NpX2RldjsNCj4gPiAgCQl9DQo+ID4gLQ0K
PiA+ICAJfQ0KPiA+DQo+ID4gIAlpZiAocHJpdi0+aXNfYXNwZWVkKSB7DQo+ID4gKwkJc3RydWN0
IHJlc2V0X2NvbnRyb2wgKnJzdDsNCj4gPiArDQo+ID4gIAkJZXJyID0gZnRnbWFjMTAwX3NldHVw
X2Nsayhwcml2KTsNCj4gPiAgCQlpZiAoZXJyKQ0KPiA+ICAJCQlnb3RvIGVycl9waHlfY29ubmVj
dDsNCj4gPg0KPiA+IC0JCS8qIERpc2FibGUgYXN0MjYwMCBwcm9ibGVtYXRpYyBIVyBhcmJpdHJh
dGlvbiAqLw0KPiA+IC0JCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImFzcGVlZCxh
c3QyNjAwLW1hYyIpKQ0KPiA+ICsJCXJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9u
YWwocHJpdi0+ZGV2LCBOVUxMKTsNCj4gPiArCQlpZiAoSVNfRVJSKHJzdCkpDQo+IA0KPiBIaSBK
YWNreSwNCj4gDQo+IFNob3VsZCBlcnIgYmUgc2V0IHRvIEVSUl9QVFIocnN0KSBoZXJlIHNvIHRo
YXQgdmFsdWUgaXMgcmV0dXJuZWQgYnkgdGhlDQo+IGZ1bmN0aW9uPw0KDQpZZXMuIEkgd2lsbCBh
ZGQgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0K
PiA+ICsJCQlnb3RvIGVycl9yZWdpc3Rlcl9uZXRkZXY7DQo+ID4gKw0KPiA+ICsJCXByaXYtPnJz
dCA9IHJzdDsNCj4gPiArCQllcnIgPSByZXNldF9jb250cm9sX2Fzc2VydChwcml2LT5yc3QpOw0K
PiA+ICsJCW1kZWxheSgxMCk7DQo+ID4gKwkJZXJyID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChw
cml2LT5yc3QpOw0KPiA+ICsNCj4gPiArCQkvKiBEaXNhYmxlIHNvbWUgYXNwZWVkIHBsYXRmb3Jt
IHByb2JsZW1hdGljIEhXIGFyYml0cmF0aW9uICovDQo+ID4gKwkJaWYgKG9mX2RldmljZV9pc19j
b21wYXRpYmxlKG5wLCAiYXNwZWVkLGFzdDI2MDAtbWFjIikgfHwNCj4gPiArCQkgICAgb2ZfZGV2
aWNlX2lzX2NvbXBhdGlibGUobnAsICJhc3BlZWQsYXN0MjcwMC1tYWMiKSkNCj4gPiAgCQkJaW93
cml0ZTMyKEZUR01BQzEwMF9UTV9ERUZBVUxULA0KPiA+ICAJCQkJICBwcml2LT5iYXNlICsgRlRH
TUFDMTAwX09GRlNFVF9UTSk7DQo+ID4gIAl9DQoNClRoYW5rcywNCkphY2t5DQo=

