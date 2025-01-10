Return-Path: <netdev+bounces-157012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73545A08B21
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C43A84BF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED020B1E9;
	Fri, 10 Jan 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fsuI5Cvz"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1990209F46;
	Fri, 10 Jan 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500525; cv=fail; b=m4XxbpWSLcTxrtxMRox35hsflX1/qMjCL8NVidIL2IuH6rQ28fitkUmp1ES6HV8xe6olOvpDhbJQRGVrnN+xlTNgCLr/F9BvR9wv39fosOBpaYh6v5vlyeE2VIC1Hj2t8JHLD+rQhz4WWyP/1uCj4ysqyihlKYlJMUp7zt30EDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500525; c=relaxed/simple;
	bh=t1qkVstBRUb/jmzKNTV7K5GZPOBxmkRLMxqfvfYtoAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fepINdnYNssSell+ccGrAGk31woi+bC6YemWIGKbYbRODYXtrBvBn6jY41I5JlXweLbHcZvIJEXHUgLFCmvjsGYcjFfOzmVx+roXvzO2wZqmCfEZloCJam69B3hZHlJo6v7Wts1hp49a6sd2rMdANIUiBn5Bs5rnNrzKLbAlxBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fsuI5Cvz; arc=fail smtp.client-ip=40.107.117.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxM4u/YkbIpGGr3q3tuleMqh5VHE8R0o44E9vf1x2N8tVirlMXnjL15qmeEFiDRSNsLykWEMEEbx9debT4AQZTWj0o7bLO55XjdthDbB3/svrUTTGzQhthjrFyH0hvQYoTrXhGslOXrgM048wtUCNQKZcr9vLGw1mHMXPOye1VBwvykW5bPTyRWLFD7XgXhxFJtRu+/9da0Ru4hmm/1H81POSEQFJw2WwKQ7DeU6wxnlTLIBtGjyBnx1LnP7NdRU5ZeZTpa7/LPRkiFYTNpG3KVaV83R7XYWGdNT2/V+8QTbQ0OUZgFKiJQA1Ri4Elt+M16g8jWw5/iE3wOoltKlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1qkVstBRUb/jmzKNTV7K5GZPOBxmkRLMxqfvfYtoAw=;
 b=l8x8LAqZ6xwkVRW2scrRQ3EBJBlPo9vGv1VzsAn3qRWx8OC2l004xMQrc+2XxMX0j+aQYDFreeZNp00pJW7EeICzdRYqagHFsPUuaiqr8RUpRSrva8ASDfnpTFA1f7/gRH9ieT1K14Zk29FJUiDcK1SWQfWo4f3NGJwTHviOqhQwZPBOhsuHYsjpYCHm7w5kTc2rkS2ViJhOfE1lXOCJg0Q2mQqbh7HYiU0v0MIz3Vf3UsLFLDmwa+FkisJXK/g+Iut+e9c2QdBbeyTeVaBWixd+aBMK9JirKZtL6X7BhJ5FrteW+tEzmwz1jc9+AFVkJlCx7N3JZkw1kULbY4pwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1qkVstBRUb/jmzKNTV7K5GZPOBxmkRLMxqfvfYtoAw=;
 b=fsuI5Cvz+hLzPhcruoyksrgEbs5j/An9r1GXTgSv2S7khka84+gbsHHhCYfYDPQajVtSB/6/2YpJNVHc7qWCCLg/KuYt05C50g4mNcdpMXt3jHSEnVw4Jk+ksXBLBKHrtW7OUDLkS9jvyKtKiuAaDmX1K6K/x2g3ykEZYUMyK/1RX0ryX7pySxkIzXnncVjItIc0y7lMBPL8cWXBvLEZFhnbRwqiGjquG4GghTZKSCPDQJ5Jz1Uip0VVtNseZqC+xYpRY7N9JGZZDbOM729tpmTGfWIUWR3BTu0L8lyzw8kZN8O6A0D6C0kn4qrf6xXw9dPKgO7UJ0HCPmv3Q/DTOw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB5070.apcprd06.prod.outlook.com (2603:1096:101:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 09:15:17 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 09:15:16 +0000
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
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNwZWVkOiBz?=
 =?big5?Q?ystem1:_Add_RGMII_support?=
Thread-Topic:
 =?big5?B?pl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNwZWVkOiBzeXN0ZW0x?=
 =?big5?Q?:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXA=
Date: Fri, 10 Jan 2025 09:15:16 +0000
Message-ID:
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
In-Reply-To: <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB5070:EE_
x-ms-office365-filtering-correlation-id: ab8cd4fc-3d89-492e-760f-08dd31574c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?R2xsMjJzelNRQm9uNkJaeTVTZ0ZWQnNPS1dML0liUjZPaUVoLzdKTDZsYTRwUW00?=
 =?big5?B?MFN1NkxIOE1RS3krQVNYc21HbmRQSElxU25wQnhsaDY3S0RXSVdBZ2t2Z3VOdnM0?=
 =?big5?B?WjdXN3FGM1JEZVVid25XNWoyY3hjZzBlQ2FqNGZUdXdneUxUcXRySGNWN0lQSXNJ?=
 =?big5?B?K2JzV1dNdnplRzdzYXpsaWxBMmp6MUxxRkJOeWZDMnAva0xYVUduTDFGa1RkMUNn?=
 =?big5?B?b1UyV0c4cCtDMHFFa1FQQmpTU1BjTVUyc2ZNZGFMZHBrZ3NyRVJEemJvT0ZlUUNL?=
 =?big5?B?dW5TVkFxT1QvWGxwb1MwWWxhZDJOMkdYaTQrYmp3R1VMWUt0YXBwOTQ1Q2dicnli?=
 =?big5?B?VXhSdUhVNXcrSHU5M2I1S0dmSU5NY1BOMzZJaVFDZFlOSUNocldGNlBjRnVRQmYx?=
 =?big5?B?eXp1VERDdkhabXhjZjNYOVUveG12a1g1QXhzQ0haTGhsU0t1MFhkbm1GUmsvYWJt?=
 =?big5?B?cmt0WjE3YjNVNVZJL3NkVXdtK2dhUVRrdWpSNWZ6Kyt4SGptd01KaldvbkxET21O?=
 =?big5?B?dGF1V3FTWU8rQVR2aERIRmxDNnRKcFFJeVE0emREa0kyeUcxZnNCRG9hOUppd3lP?=
 =?big5?B?c0hpcENkRDNqellJakpjK3VJSEJjT3A4NTZPeW5VSTgvYkZGOEpGRHZKaUpoa0NU?=
 =?big5?B?L3JmajJoYnUxRHMrSUIvZDBDMC96REpVNUxkcndXRS9HVUV6QnkvS0N0SGFJU1JY?=
 =?big5?B?VUd5c3NKMjFCaldaei83bVdFVVE0V0VOcTJMYVEyQkhzS3VrNHhaYzNkQUVuUVg1?=
 =?big5?B?MTVpcWlhbmRUMGhxSVc5dEpXVTVnL1NNVC9NdTI3clFrc01VdmZ4WkdBT1h6ODhk?=
 =?big5?B?ZGtMRUYzdG9URmpuc2VkcEJ3L05qNzNwR0ZQb1hlZ2IzR2V1dGlHRzd4SVUwVTlW?=
 =?big5?B?VzdZOVN3OVpYanF3ZG05bml1Wk9EeU96VW0rTnI1QzRsazFQSGdUNGpuWFhNOVo2?=
 =?big5?B?MUxNT1J1TlIwcWgwRnNUd1FwR0dsTnhZangzbmJXdjBMWFRndC9Pall3RzFRL0Jw?=
 =?big5?B?ZFA4MExNZ21IVTFrd3BnQ3hzNEF1VHpIVjdacTRYM0M5TFZyVElGaUpRdG5TWFRZ?=
 =?big5?B?bDlWVHBqbVBvbEV4dUlLbU9tcW1Edm1yZHJZMzRSVTJhaFNTY2lYMWUySWlyTTN3?=
 =?big5?B?QTJKL05sRE55TkxCL2FEQWtQYlV2UExwWGlsbHpUQ1JtZ29ZRDlqd3QrTmFXNXg0?=
 =?big5?B?NHM5RlNIQit6b3Q0aDQ2QTJoekJmcGRxdElzd1VPcGRreTl3dG84OVpQY3dUdTF6?=
 =?big5?B?aFFWR21HSVNZVWk1bGxsUjlaaFhCMVBUMldhZzVzaUVmci92bmpGSXNTYW9KbHVl?=
 =?big5?B?L3AyWEM1MjlVYmVZZk9jQ0RhU2ljdmUxVG1vdURWVjdyeExEUXZ0RjdLSWhsNzJr?=
 =?big5?B?SHZKMnIyV3RuQVlwa25sZEl5L25IV00wSW5mSEpnNEVWdzZBaEFDZnN3eGlORjla?=
 =?big5?B?ZGlqdjdFUGJPcXVQM09nUTNnNGJQTVFTemlYbXN6ZGp3SWNvcmhPVEpJSTN4ZmE0?=
 =?big5?B?dTEzZHZ5Rk9NM2NETU51OElEUXc5a3ljNEZsdFZjZGptZS8yMmtEV0dRTkQyRTUy?=
 =?big5?B?MEthakhZVnJXeWRPS2x3MEgvaWV2eVdKaGJwaDkrWTRyb3BRT2ppTkN2SGM5VGtl?=
 =?big5?B?R0JNSkYxSVVqRFlUd09ENkc4ZGFTRjNlSnJIQzZvWlZ4ZjVXN05ZNHBPdktnTmc2?=
 =?big5?B?VWFTbXh6dHAwQ1VPM01kMnlkbE5CQ2dMVEgrRkVnTGpGVXI2OE5uSGkzN2VLYlhW?=
 =?big5?B?Vjhva0tmRlNaZEpaT0lLVjJVUXYwWS9TcGEzd3dtMktWclA0dWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?UVRwV3FnN2NTSVlaWTVPQmp1MGYzVzEvUXI4K0QwWmt2VHFWNU96NGU2V3FLWXJB?=
 =?big5?B?RDA3RFEwclQraFdIL1IreEYvUk9ORVNCai85Rml3d05QU1BTdWwrTUlqd1hlQXhs?=
 =?big5?B?clJOVWxzZTc1WTg3VkIyY0xodWhBamJKNnNUcEpMU2EzeHdDa1FKUEY4MHFVNGxk?=
 =?big5?B?ZEtHb2pHc1B0RGhKY1Z0YmN6TWpVZ2RFdko5c3ZzU2V0ODRzVUNrQnNmRjBXekYy?=
 =?big5?B?MzhhNmFmaDArcStMcGR6b0VEM3h4Q0tGUjNYWWFRRk5oRWt2cFRzWHUwUWN5RXlj?=
 =?big5?B?aFpraXZnUEIzOWNjNVVLdkNiSjNuZCtqMkZHZ0kvYlFPTEF2NkJ2Mm5DQXRpZFJ1?=
 =?big5?B?UFlLbUtYSVdGdnd4M045bWpIMDU5WjY3MW9ic2lqYTZ6OHpXdTBaRk1Ic0FvaTNW?=
 =?big5?B?YS93MjZDVkd2L2x5TlV1WXRQYmRIR014ckZROTBvNU1XdFAvVUFqYUR3V1hRWVUr?=
 =?big5?B?NkdKR0FyZGYyaytjSHY0SkFGQk8vN3NKYmQzUGhKbDc4bE1RVFd1Y3N5dTFCOFdR?=
 =?big5?B?aTJmRTRHWXNuQy9MWERxR2drSHVkc3ZhN1hmK3oyZ2NHS01KME9Mbkp2b1g0UDls?=
 =?big5?B?dFJ0N1NzQnpsREh4K0ozeURCOHBxVEowNzBLdFpyU2VtSVppUlNVV3hCYVNGY015?=
 =?big5?B?R3NsM1VGbEd3Y1duVGZKQVdYTWdEbTNaNGM3QVFPQTdRdGNSTkowbkdOeHYwNFNu?=
 =?big5?B?czFpaGpObkd3YkNiZVFmMnlic29LdUczWWU2Q3FBUk9kWnJxOWhWemZyMWJpbWJa?=
 =?big5?B?NVpLUlhOS2I3ck0wVG0zSXFGb2lOQ3hHNTZPMUZ3cFc3MVQycUQvY25aUGFjeko4?=
 =?big5?B?UVcrS3YwOSs2VjlyWEU5akpLVS9ZQWFhVGJseGJyYmxZWVVtS0t2bUc2dmZReFZD?=
 =?big5?B?czJ2M2FuWWMvK1RVQkpUc0tacW1TcFRSYlEzUWJGV3dTeUszUU56SXh5cUhNK2J3?=
 =?big5?B?RUl3Vm1aZXIveVdqY0l4dXFWY3BsamlRQSswODZsM1QzSG81ZlBubm1LRnlPbTl6?=
 =?big5?B?RDVnMVNHNE1henJjZ3hiRDZ5R3FQODJmSjZlaDQwbkNlL0NBc3BHSWFQVVcwK29x?=
 =?big5?B?R2kxQjNNVWRaUmZ1Sk9SZ1J4TDdGRisxS0hLcEtWMFlqUVJMR1JDL0lXK1B1WDY4?=
 =?big5?B?ZThqVXZzQXorZU4rMjlvRng3OEcwMHo2d29seUdrR1RlQWFvNC83YWdDdkdZTzJN?=
 =?big5?B?OVVIa0xmQUUwMXBCV0JqeDVvcFFHZGdMN1pQanZ1ZDAyWXMzY0d3a3QzNnZrcHVa?=
 =?big5?B?YnpVV0xKMVZhNVpsUWtqc0JXVUtRWWZyM2dSbVhlWmJOSUFvR3JZcEZ5QU9nOGRu?=
 =?big5?B?dmV5bHBqMGdteUM0Vyt0YmxTazRvT2ZTQ1hrRzF1SWpSNVN6ZmlZVGU3U2dNTlY0?=
 =?big5?B?KzhBbnFBQzZ3VTlsZVFVaE8wa1JYeWduci9ZN1AvUUdjOG5vc2crNjFTVUlSRlFQ?=
 =?big5?B?WStMc1NjTmYxdXF4MXZsOGFiMDFRYlFKVjErQ0FTN3JqMnRBanYwZlhGcE0xYnpH?=
 =?big5?B?VlErVkpnZ1FUWEk0VmFrQ083bWx6eDVad1RsTnlWMWRvK29rQk5DL2hUb0t6Z1Vs?=
 =?big5?B?S2hOQjAvanVDa2dtZnEyUXlFRllKWUZHOGEveVRBdEE5N2VIakpKcDBjWFBRNll0?=
 =?big5?B?aWlOZDhzVklrMC9CTlBYM3drSit1eU5acFl2dWlBUis1cys1alNKMTI1K0VxaUZt?=
 =?big5?B?MEJZeDUrZXFoeHdOc0RYVVJQVUxzQ0QrUUpKRjlXakxmdjd2WW1IRjdhSDJ5Nmlp?=
 =?big5?B?a3FSLzBqVlF0NDB6UzJRMUhpekRSd01vQW5JYzBiQk9rak1nRTh4QmpQQ1hnd1RP?=
 =?big5?B?WXIyVGsyc1BtdER1ZTR0Sm85MTV6aUptNzdXWktvc095dkZIaFArN1lPdEZiQ3g5?=
 =?big5?B?VytWNjVxYW9lZk9PeTVPSHg1b1Y4ajBpMGpBYVREbGpPTHZNUmsxbE01RjBldE9M?=
 =?big5?B?Z1RJSjFHYkNGZ0dLTk1xckZmOEJ1YW1ub3Fnc2VoM1FEWTkrZnRFZTloVlFxNy9y?=
 =?big5?Q?0W9kh+hV6ufPG65e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8cd4fc-3d89-492e-760f-08dd31574c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 09:15:16.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8BXask49Gd9Wj5zKMHeJF6xckVrWlQ3nqOznT75T0ODbKK+39BvhIJd6SECAD1DVj0YsOblC3BLXrxk7lqmLl/LUB+Z/W15qiXvtgGI+Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5070

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPg0KPiA+IEkgdGhp
bmsgdGhlIGNvZGUgYWxyZWFkeSBleGlzdCBpbiB0aGUgbWFpbmxpbmU6DQo+ID4gaHR0cHM6Ly9n
aXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xrL2Nsay1hc3Qy
NjAwLg0KPiA+IGMjTDU5NQ0KPiA+DQo+ID4gSXQgaXMgY29uZmlndXJpbmcgU0NVIHJlZ2lzdGVy
IGluIHRoZSBhc3QyNjAwIFNPQyB0byBpbnRyb2R1Y2UgZGVsYXlzLg0KPiA+IFRoZSBtYWMgaXMg
cGFydCBvZiB0aGUgU09DLg0KPiANCj4gSSBjb3VsZCBiZSByZWFkaW5nIHRoaXMgd3JvbmcsIGJ1
dCB0aGF0IGFwcGVhcnMgdG8gY3JlYXRlIGEgZ2F0ZWQgY2xvY2suDQo+IA0KPiBodyA9IGNsa19o
d19yZWdpc3Rlcl9nYXRlKGRldiwgIm1hYzFyY2xrIiwgIm1hYzEycmNsayIsIDAsDQo+IAkgICAg
ICAgCQlzY3VfZzZfYmFzZSArIEFTUEVFRF9NQUMxMl9DTEtfRExZLCAyOSwgMCwNCj4gCQkJJmFz
cGVlZF9nNl9jbGtfbG9jayk7DQo+IA0KPiAvKioNCj4gICogY2xrX2h3X3JlZ2lzdGVyX2dhdGUg
LSByZWdpc3RlciBhIGdhdGUgY2xvY2sgd2l0aCB0aGUgY2xvY2sgZnJhbWV3b3JrDQo+ICAqIEBk
ZXY6IGRldmljZSB0aGF0IGlzIHJlZ2lzdGVyaW5nIHRoaXMgY2xvY2sNCj4gICogQG5hbWU6IG5h
bWUgb2YgdGhpcyBjbG9jaw0KPiAgKiBAcGFyZW50X25hbWU6IG5hbWUgb2YgdGhpcyBjbG9jaydz
IHBhcmVudA0KPiAgKiBAZmxhZ3M6IGZyYW1ld29yay1zcGVjaWZpYyBmbGFncyBmb3IgdGhpcyBj
bG9jaw0KPiAgKiBAcmVnOiByZWdpc3RlciBhZGRyZXNzIHRvIGNvbnRyb2wgZ2F0aW5nIG9mIHRo
aXMgY2xvY2sNCj4gICogQGJpdF9pZHg6IHdoaWNoIGJpdCBpbiB0aGUgcmVnaXN0ZXIgY29udHJv
bHMgZ2F0aW5nIG9mIHRoaXMgY2xvY2sNCj4gICogQGNsa19nYXRlX2ZsYWdzOiBnYXRlLXNwZWNp
ZmljIGZsYWdzIGZvciB0aGlzIGNsb2NrDQo+ICAqIEBsb2NrOiBzaGFyZWQgcmVnaXN0ZXIgbG9j
ayBmb3IgdGhpcyBjbG9jayAgKi8NCj4gDQo+IFRoZXJlIGlzIG5vdGhpbmcgaGVyZSBhYm91dCB3
cml0aW5nIGEgdmFsdWUgaW50byBAcmVnIGF0IGNyZWF0aW9uIHRpbWUgdG8gZ2l2ZQ0KPiBpdCBh
IGRlZmF1bHQgdmFsdWUuIElmIHlvdSBsb29rIGF0IHRoZSB2ZW5kb3IgY29kZSwgaXQgaGFzIGV4
dHJhIHdyaXRlcywgYnV0IGkgZG9uJ3QNCj4gc2VlIGFueXRoaW5nIGxpa2UgdGhhdCBpbiBtYWlu
bGluZS4NCg0KQWdyZWUuIFlvdSBhcmUgcmlnaHQuIFRoaXMgcGFydCBpcyB1c2VkIHRvIGNyZWF0
ZSBhIGdhdGVkIGNsb2NrLg0KV2Ugd2lsbCBjb25maWd1cmUgdGhlc2UgUkdNSUkgZGVsYXkgaW4g
Ym9vdGxvYWRlciBsaWtlIFUtYm9vdC4NClRoZXJlZm9yZSwgaGVyZSBkb2VzIG5vdCBjb25maWd1
cmUgZGVsYXkgYWdhaW4uDQoNCkN1cnJlbnRseSwgdGhlIGRlbGF5IG9mIFJHTUlJIGlzIGNvbmZp
Z3VyZWQgaW4gU0NVIHJlZ2lvbiBub3QgaW4gZnRnbWExMDAgcmVnaW9uLg0KQW5kIEkgc3R1ZGll
ZCBldGhlcm5ldC1jb250cm9sbGVyLnlhbWwgZmlsZSwgYXMgeW91IHNhaWQsIGl0IGhhcyBkZWZp
bmVkIGFib3V0IHJnbWlpIA0KZGVsYXkgcHJvcGVydHkgZm9yIE1BQyBzaWRlIHRvIHNldC4NCk15
IHBsYW4gaXMgdGhhdCBJIHdpbGwgbW92ZSB0aGlzIGRlbGF5IHNldHRpbmcgdG8gZnRnbWFjMTAw
IGRyaXZlciBmcm9tIFNDVS4NCkFkZCBhIFNDVSBzeXNjb24gcHJvcGVydHkgZm9yIGZ0Z21hYzEw
MCBkcml2ZXIgY29uZmlndXJlcyB0aGUgUkdNSUkgZGVsYXkuDQoNCi8vIGFzcGVlZC1nNi5kdHNp
DQptYWMwOiBldGhlcm5ldEAxZTY2MDAwMCB7DQoJCQljb21wYXRpYmxlID0gImFzcGVlZCxhc3Qy
NjAwLW1hYyIsICJmYXJhZGF5LGZ0Z21hYzEwMCI7DQoJCQlyZWcgPSA8MHgxZTY2MDAwMCAweDE4
MD47DQoJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCgkJ
CWNsb2NrcyA9IDwmc3lzY29uIEFTUEVFRF9DTEtfR0FURV9NQUMxQ0xLPjsNCgkJCWFzcGVlZCxz
Y3UgPSA8JnN5c2Nvbj47ICAgIC0tLS0tLT4gYWRkDQoJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
CQl9Ow0KDQpCZWNhdXNlIEFTVDI2MDAgTUFDMS8yIFJHTUlJIGRlbGF5IHNldHRpbmcgaW4gc2N1
IHJlZ2lvbiBpcyBjb21iaW5lZCB0byBvbmUgMzItYml0IHJlZ2lzdGVyLCANCk1BQzMvNCBpcyBh
bHNvLiBJIHdpbGwgYWxzbyB1c2UgJ2FsaWFzZScgdG8gZ2V0IE1BQyBpbmRleCB0byBzZXQgZGVs
YXkgaW4gc2N1Lg0KDQovLyBhc3BlZWQtZzYuZHRzaQ0KYWxpYXNlcyB7DQoJCS4uLi4uLi4uLi4N
CgkJbWFjMCA9ICZtYWMwOw0KCQltYWMxID0gJm1hYzE7DQoJCW1hYzIgPSAmbWFjMjsNCgkJbWFj
NCA9ICZtYWMzOw0KCX07DQoNClRoZW4sIHdlIGNhbiB1c2UgcngtaW50ZXJuYWwtZGVsYXktcHMg
YW5kIHR4LWludGVybmFsLWRlbGF5LXBzIHByb3BlcnR5IHRvIGNvbmZpZ3VyZSBkZWxheQ0KSW4g
ZnRnbWFjMTAwIGRyaXZlci4NCg0KSWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucywgcGxlYXNlIGxl
dCBtZSBrbm93LiBUaGFuayB5b3UuDQoNClRoYW5rcywNCkphY2t5DQo=

