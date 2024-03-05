Return-Path: <netdev+bounces-77507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53C871FFB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D51F21876
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1A85920;
	Tue,  5 Mar 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jvIPVYMG";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HmdukBpi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21B5A7A4
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644963; cv=fail; b=MOHoPRVVp/zQ0feoqeb5k1ZEo3Oz8zKqm5hl0Bkl0NfX3s5uPgJ4OjryTahx+h9X1YHNNAvJdWCqL0J5vtB3BtB1SZM31mxpE4qVgPNBrJ5Eg6ZZ0cObW9U54yhf9MyVO0CKbRyUJCd9GfHnOQGpITecrJvIqrNcp+cSW46CUMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644963; c=relaxed/simple;
	bh=HJ6Tpiu4uRzmJMjbF5G7Ca7dgM00zLxdzhslADsIgrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B62COdNqQC4nFMnsUto6qUYeQK+7b9bCcUzc38FUfnmOFioubRl6xnsn1FbDAsvHIEwf35n1bnEkVgpmkGWQNDUaHJF9upZIL067sgjFPZhkIl3dHeoHwyk5XpNTn1jKjx7F8M8lCfhm/CRXg0GX8WsKGUzB/S/G6G0a0im17vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jvIPVYMG; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HmdukBpi; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709644961; x=1741180961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HJ6Tpiu4uRzmJMjbF5G7Ca7dgM00zLxdzhslADsIgrE=;
  b=jvIPVYMGouTjk7ICjtQ8sffEldFphuAqHy1RuZGxnP7A6o7pV/jtPUwe
   GiXEbFV3TyEW+EJLXOR2EpZoLlSY04ZUkdASBpIMJirzX8oCaU1pgNi05
   b+Tr/ZbJojK26yp/VQ0jLlqx0ILREAZA4W96wkYiYKIWQ7OvDB/v7vZzD
   ExfhxqyftVEew6Dh73YEnrSm42VJr+9+03MqTlrm8U6q55XJZ66M9Xb6b
   Jx7CCv/7KE/IJi4Xx6G5D6fPx5TnoINZm39fK4BZ+JZNj2VShzSCG4OOE
   v4Dzwt1ZW73G5FwGu5GPWFPU+K0hlYtKKrQOTCrHmyEGXP9vQg8WtPd7s
   g==;
X-CSE-ConnectionGUID: tztKf4E8TI2C8yCHFdGfJQ==
X-CSE-MsgGUID: uOlE2iO2RK2KGsEwhIPQCw==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="scan'208";a="184491824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 06:22:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:22:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAanJFlqgn5xDx+qKdcx03ZPzzKLvuplnZAZknDclXKr9npBDT1lPFRfgGesJhPqbuj8pJYRnSmqWjoZ698uhXtkI0k2CqclyG/cvB4/JSAYDhSlFYYDnsO4x5bhXXGFBJ2GSe+tNkIISS19bc6b8b/yqEftevJQHFFjusuGiniXgqbMCeRZhuBEhMm8F6T9xag556HkYkMYPfG23ixnAxpix0MG0kgH59PHjnPOyavCK8BIP82iGgXtqIdAw3n6pLyQoiDD/Gl09ggykTgGWhqtkOmO2NIXSs8uPM8bAlbWlURpFzh3WPa6F5T/qd48FPDN49Nhb3pMZ4zgreiNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJ6Tpiu4uRzmJMjbF5G7Ca7dgM00zLxdzhslADsIgrE=;
 b=gf2GEb7hBTCjvaI3s7P60bWmHT43QinQAc2qlYR8p+gk0z4Bsg+NgADx1faT3LAF5IvJc31j0iBg8XZFb+BZvwwtn1jDlM6BXl2hx+vjXkVuyQXZYsW67b8BHibk4J6qz/DuDav9vSwpZ4dax1kzaTHCNFBBJQrqnxT4spHlAkL27vFld4aKW5BnQUxm0zc0SvYR0L2b4gWYoF7ElBva20u97CXxWxYvq8J2jR+T7oKpaYzb1WOUdUbg1uFUjjM8ckvuU8G5Ul1bZCAmNt2iD/PqiSUSi0pDtEIAXrwd5GnZ9qOoBZIbbkTFe/9bszVwSsZkVW73GD/fat8GnmqvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ6Tpiu4uRzmJMjbF5G7Ca7dgM00zLxdzhslADsIgrE=;
 b=HmdukBpiYQ3CFRdu/MUr9t6RlmbCRdfKSw6VvJlRgzvJFJRkEZaEqfuOINiy/eFopuIl036BUq+68Ci5cNOO2WIi8aqn+pYnBsPWIhlzQ4hIZDDvPQCNTZE0pqfthD0ns/u/wfUBNBoStdNq6Hh8kOeO13X0IpPeG3fJrgepcFnt8bfg/+S+cSOiHqlxgcULisiUKkP/Aq3JSb8t0jTxo3xRSGpCWLkMehDlnxDs4rrmBEmZS0fyRjGTBQUSrubkwOp9bY7F3JAoS2r4W8Olk9XFOvqjw+dLn6M3XGNK2ym8KspisDSWZFtMDgYWga+AQ5sgTei5NK6uAjoDi11kig==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 13:22:24 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 13:22:23 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Index: AQHaBcg0J9X87rlKy0y2G/CzXLB1SbEOPx6AgAPmdICAAE9bgIAVydQAgAAjlgCAAZJigA==
Date: Tue, 5 Mar 2024 13:22:23 +0000
Message-ID: <82e1f510-70a7-4a58-87bb-ad2e4e6117e9@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
 <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
 <04a2e78e-aac4-4638-b096-a2f0a8d3950b@microchip.com>
 <0dd74757-33e3-4872-85e1-8276ea6f1f22@lunn.ch>
In-Reply-To: <0dd74757-33e3-4872-85e1-8276ea6f1f22@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW4PR11MB6862:EE_
x-ms-office365-filtering-correlation-id: df80a8a1-5426-4fcc-5c3b-08dc3d174b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxZlNskbOF5A34o21S+KxQoMYuXi3Wws2pKx+vHQ2XcutQevRBtj4yEVbm6nZTP1kPpQylIlhy37FbTVfN/yCtMqVbenDTkUlwao5c0+f0c/wLmwbgYKTEmiv8RyTzvNahD8S4i9v0mqarmA99C52+RhixTzgVaB0XDat4arvF2Hbw80YLqIoA568S//C96gBrT8Yqq5ZQPSW5fLLfWHtTaUIiV0V1he/8UwNCrTukC6LTjJtoBdFxPKYWMTvMLT36OMPnTGm/yVbZaPBzEOC15DZ6TYLMN+0jL0N2NxpCAm+HZJsUb25Cahr69IbrrC2Ml5AFufRfG7l0r8U0zRbMzzJGeguutkQOjT2F1rm3cj0Q3Z+/7BUv0FXuBIE6kdKXRHYeyZS1WzcgReG1wGUR+Qn0GMnfhb2MpPr94Zqhesh3wNEBJ0T4V+NzVQYnuI+dg7SFrZBz3gKK4CQRiEoGV6IYPDzzJAzMpYqTHnmtjL4fN7DqAcEljr1MiGFftgDXARIMxQeDkQP11DVZXVlE8yUJ/NqBKB0YPxuGN16x/kyMnnkJnxpms5lBSBRKqANCKrD7hjjZm211QR8WSD10yoev4FRXg0rhNYaovp2Sqc1wAFPn+Wrf9osyhuwYYn/jD5swN9aG/fTGItAdQnCWf13/RDLh6wrxyKvGgWCH7i/3EeOl6q0zvxKORVrRQwc03+SZKoyz9ZdtOR2KpOaeCFne2Tke2VrW5N7e4kZl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0dzbmJaaVFFZFhjT1QvVXEvTDhvT1pEdVFrRnRKaEdRY0duQkVwNERWalZt?=
 =?utf-8?B?cFBqNnlnRnlzbzBpa1Z5enNwODZpelhQaTlvbmk2SWNxNC90NXpzLy9MbHo1?=
 =?utf-8?B?dmdaTVpkMUFuU3ZCNWlpRWJrek1zVGxwYnZIUWxaLy9PblFqNjFCdlNsOTJZ?=
 =?utf-8?B?QmVxdjdHVCtsV0QzcDNjSXBnSWVYaVYxZlkzaWM3djNQSjZBWlFMTlJIVlc2?=
 =?utf-8?B?MDVKSUxsRUtoeFhLcjc0VndhU3dBc1JBa3R1SHlDelRqQUJOTUlWN2ErSlhp?=
 =?utf-8?B?S2FIeVBpTFlKcXliNlRxRy9nQlNTdXkzaDIwREh1cVlaU292QzBaYW1jMEZD?=
 =?utf-8?B?TlVseGRaOWpPcjM2YzVuOFZHSndxT3kzeklndDQvcUpld2tIZXpFZXBsdHVI?=
 =?utf-8?B?L1BuRTNiRDJCMkdJdnpNTkJLMDJ2SnpzbG53aTNTOWJ5Zmg2VWxXY0M5b2JZ?=
 =?utf-8?B?THZkMlJLRHZDcU95dm9PQ0NJN01NVUIzcXQ3eG1SYVIxZXJxUkNESGVnV0VG?=
 =?utf-8?B?RVhWL1pSQ1dCeCtONktKZjkxeU9JUTdBOEN3S3VWVVdXTEpvbFFqczNvczBK?=
 =?utf-8?B?NjdkNnpvV1BqeVcvNDFudFFQUENMdC9KeDFseWl4UFNLTHNGTlJLdVZ6S1Ax?=
 =?utf-8?B?eEVLR3d3RzBkOEtHYk5kWDNOYUI3U1FyR0JjSXFIck1kaUJyT0NDN3ZEOWRY?=
 =?utf-8?B?d01SUXBydUk5SHVvZXZRSWQ2VHB6NG5oVUJuS2JYMTl4d3p4ZUNUUXRIRXcv?=
 =?utf-8?B?QXZKbzFtZzVRTEQ2R0c1VHVoRHZvT1lXd3NvN0w4bVduTE9mditLYStuOGlE?=
 =?utf-8?B?M3UwQnp2dnlPRHZCUktZRDEyMDdoQWh4MUJ1S2FmUTdxOTBlRGJhazU3bUha?=
 =?utf-8?B?NDZYZzJRMmVmdUZxb2RZa2tMNHZZV1F1aTRFQjdkQkRkVXZnRmxITGVtY0c1?=
 =?utf-8?B?TS9lZU5KRVBuNW5xeUM4VXVqN2lRVldzQ0J3VmJab3ZLM2lCUG1Dd1haOFNO?=
 =?utf-8?B?YThQb2hBL1BMNzBMSURDRy9Ga2o3UGJrait2MUQzWHpRYUN0QUZESy9ZaThO?=
 =?utf-8?B?VDdiSlg5dCs1Q3J5TUVrR2Q2eDErUXhCcEZWOHJYWkxzMFE4dmRabkJvcWh2?=
 =?utf-8?B?Z1J1aGwza0J1TXhrNklLWHlzTEYzQTBZTEdXWkRrRG1ROFY1S1BOYS9WQmtl?=
 =?utf-8?B?NURpSnhvV3RTeVpvRnl6WlZod1gzYXZLdDRVS2dkOWlXVzF1bWVQSGlvOGVl?=
 =?utf-8?B?dkhSUmE2NFpHVDlEdkdCSXA0ZW02U3BGRXcrekZmaE5FVGdUNldoWks0cUJE?=
 =?utf-8?B?SnNOaDhzZEVpSkd5dzZyYnJ0WWErL2wwYSt0dkFvdkMyeTVJUEVia1BwTlNN?=
 =?utf-8?B?UlRGNE9KUUU5cGFYUlRBRG53WVJJemVnL0VyMTdiL1cyT1cxRlQ0QUl3MEU3?=
 =?utf-8?B?L1hSZFhNZURiTThPZkJLWDNNQTZOVFplUytxRVlWWVVQTUw3TjRQR3FoV1Nh?=
 =?utf-8?B?M2toaEJ3cithOGo2c3FTcFVUZlc5TnZJalY1c0JHUGRJZXZUdldCUks4dzMy?=
 =?utf-8?B?RUovYmxvR2lMQXpNTGdKU0EyenFKSXZsOUpEaUptaUp0VWl4aUszZVNLZzNL?=
 =?utf-8?B?WG44aEJGOEZnYjhGVnZDR3RrS1gxeGM5N3JkRmNvNG1ITXhZbVY1MmF3andX?=
 =?utf-8?B?eHBBeWxUUjF4cVZYT1E4aUExd1Yza2JYYzA2Nm14cEFseEM2VGlVQm0rYm9T?=
 =?utf-8?B?dW41L01yWW9LcjdSYWRCS3ZpYUpMZGVlS2MvNDJYc3FxRVhmQlFnQyt5Z2xv?=
 =?utf-8?B?YkJyck9wMXV1cEdkQVQwRTQ0WXdva1I2VTRSSmxJZnBtZ1c2WHM2Z1pNMDYx?=
 =?utf-8?B?WDA0RTZNQjVhME0vcXFBZU95SjJoYUY4dlFjbkJYNXdxeGMvWTZrTXA0ZmRK?=
 =?utf-8?B?NWtYUzcvS2RCL0hzTE1tVkgrVFd2OWl3a3FSZERPZDFjVFU1RnNxeWFVQXJC?=
 =?utf-8?B?blBqclRnTXcyTzcrbElJbW14ZU5xMTg3blZ3bW16R0VnQjF1dWJSbks2UWRq?=
 =?utf-8?B?SnROc1NUWFh2OHNVdTR0SmV4c0JSNzIxU04vM0dSc0RFR3oxRGIyanRUNUR1?=
 =?utf-8?B?SE5ra3B4V3d4b2JnM0tMSTVWQ1FLMmdSNGhZYTY3cCs3Qk1qdUZZczFMMC92?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91CC960D62A20044816CF70C7137D0E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df80a8a1-5426-4fcc-5c3b-08dc3d174b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 13:22:23.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9upYlc/WTcuKgnpPgFfluVPkvsGSviEAT5RgVT/7HMPmh9XW2xRZAR7UFrv4RTpKau1kmNwihd0jZhoykMOqlqQgHDz5BvMQI3Rz1I5Qe9txKLRTGhnNKaB6PMVoWG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862

T24gMDQvMDMvMjQgNjo1MiBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IEhpIEFuZHJldywNCj4+DQo+PiBHb29kIGRheS4u
LiENCj4+DQo+PiBGaW5hbGx5IHdlIGhhdmUgY29tcGxldGVkIHRoZSB2MyBwYXRjaCBzZXJpZXMg
cHJlcGFyYXRpb24gYW5kIHBsYW5uaW5nDQo+PiB0byBwb3N0IGl0IGluIHRoZSBtYWlubGluZSBp
biB0aGUgbmV4dCBkYXlzLiBGWUksIG5leHQgd2VlayAoZnJvbSAxMXRoDQo+PiB0byAxNXRoIE1h
cmNoKSBJIHdpbGwgYmUgb3V0IG9mIG9mZmljZSBhbmQgd2lsbCBub3QgaGF2ZSBhY2Nlc3MgdG8N
Cj4+IGVtYWlscy4gQWdhaW4gd2lsbCBiZSBiYWNrIHRvIHdvcmsgb24gMTh0aCBNYXJjaC4gV291
bGQgaXQgYmUgb2sgZm9yIHlvdQ0KPj4gdG8gcG9zdCB0aGUgcGF0Y2ggc2VyaWVzIHRoaXMgd2Vl
ayBvciBzaGFsbCBJIHBvc3QgaXQgb24gTWFyY2ggMTh0aD8gYXMNCj4+IEkgd2lsbCBub3QgYmUg
YWJsZSB0byByZXBseSB0byB0aGUgY29tbWVudHMgaW1tZWRpYXRlbHkuIENvdWxkIHlvdQ0KPj4g
cGxlYXNlIHByb3ZpZGUgeW91ciBzdWdnZXN0aW9uIG9uIHRoaXM/DQo+IA0KPiBPbnNlbWkgYXJl
IHdhaXRpbmcgZm9yIHRoZSBuZXcgdmVyc2lvbi4gU28gaSB3b3VsZCBzdWdnZXN0IHlvdSBwb3N0
DQo+IHRoZW0gc29vbmVyLCBub3QgbGF0ZXIuIElmIG5lZWQgYmUsIGdldCBvbmUgb2YgdGhlIG90
aGVyIE1pY3JvY2hpcA0KPiBkZXZlbG9wZXJzIHRvIHBvc3QgdGhlbS4gSWYgdGhleSBhcmUgcG9z
dGVkIFJGQywgdGhlIHNpZ25lZC1vZmYtYnkgY2FuDQo+IGJlIG1pc3NpbmcgdGhlIGFjdHVhbCBz
dWJtaXR0ZXIuDQo+IA0KPiAgICAgICAgIEFuZHJldw0KSGkgQW5kcmV3LA0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgc3VnZ2VzdGlvbi4gV2Ugd2lsbCBzZW5kIG91dCB0aGUgcGF0Y2hlcyBzb29uIGFu
ZCANCndpbGwgdHJ5IG91ciBsZXZlbCBiZXN0IHRvIHJlcGx5IHRvIHRoZSBjb21tZW50cyBhcyBz
b29uIGFzIHBvc3NpYmxlLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K

