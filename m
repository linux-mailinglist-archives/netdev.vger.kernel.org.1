Return-Path: <netdev+bounces-146370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20DF9D3239
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A9E284445
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 02:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DDE74068;
	Wed, 20 Nov 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="mgwtR4KL"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021086.outbound.protection.outlook.com [52.101.129.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE45FEED;
	Wed, 20 Nov 2024 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070106; cv=fail; b=uZJHg61tebJD+Ly8ziwN8eO64ej2U0V1WtcORGLyjbHdpNh0ETpz0QxJeUI3QeKjRW6md7CaCAVs49FXt0+rN64kPsgXnvro4piB+nk4/z2ovBs00VgiN4NWpgV/9PbkuZBxfSiD0Ugm6scSOagGbB7HmMA2AZuEhNVZwjfDhX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070106; c=relaxed/simple;
	bh=ekiDupnI2Jc/TnwrrBmABmbCxZDghalIky54qGldg98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYdId2V5NvMfg8ThIZl68jsO57p5bW/2dcY410kcRNJn8vLIc74bD7t4+dU0WeoXxSE1UWmn19MzSiOERzLVr5WwA7nYRNks1FOjBU/qv6n4+zbWuQYOhdfUnxFcMYDVKPJRiyDhtC/DE5hJZy5M14dom2Ch3tZRBxiMNQrLu7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=mgwtR4KL; arc=fail smtp.client-ip=52.101.129.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln3OiYxj6rYrEKfYLO4o3Ar+WtDgydj0eF5D9a7GDsaAC83TLx4p6C7S7ouRXvFeIjVntDbdxasJvmgI/kcvKFD33hd+Y9Z/rDCJaWo1X3cg2azHCkjEfRILS96tSqRCBXunXdFB2281GJ26/EBIIVQzbc0C3i/icLfuqadf+QuBIXK8NRIP3/H75SMJ8kbCtSsDnZE730a+2CrDFqs0H2ZzqxEz/nHc5g5bycStZ0eASwtqjpGUQJj/4aR8Bo8iXJZKrJmOhoRhF4YfDkYoCJd78jEakdOK+bMObv21JMUitbY86ZTwZCjSzG/mmbF/xPPE0ek/XjEjjwSqckTh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekiDupnI2Jc/TnwrrBmABmbCxZDghalIky54qGldg98=;
 b=vylThoJ7gwOY5kQkJU51ihuNvwjhMFPfjUBqk+C33yY+fpCjb6oVhY4tOenW8tcd6WWfjohDjvC1euftor50arRmA3po1WBspOCMwUs9RDb4/YEcnUTllcqbWLCHRXdkSlhVnir6ojV6mq2C2pWpxCWkcP3/ZWo6GKNLukHw1ps3l1tH3e+V/rAZy/gttyUfjr4PewJdEj5vYt45XIs4/uUxEUt+lSWGz8lQaYb01H4v5I3JVzivk6WcVRXrrBH9LjDNm4arUWYqMK5Kj4OAd3XPYY7agAejvF5q/iXijZD6V3du6qQBRCOw6wsPHzidwd471t4/uwQ8oFRk4UX4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekiDupnI2Jc/TnwrrBmABmbCxZDghalIky54qGldg98=;
 b=mgwtR4KL74tMw7slhMfEwAziZ7UT+uRb4wDWXDHuSVksSUz97zcTArNnU8Vzwp7TjSQZaMzo38lMcW8aN35OI4NIq35KP84jYbR8Z7NPCL2gK314ffY5tF7iDviLQ0PtMZ0GDERy5lla3E4VaXlZ1HYmeVvrebStMQVMaWPKw19qGmrd7w+1GtG3G/gEInHAN9CVNhTcBn+D30utYxOcnqugt+2SiGTgDsGGdsS7HWyVJ2M6zsoawoumAAWK67zmBbBJoDowdCG80Qp0+UoL4hugpKRyeDPG7bMVkAzODX4gbyjqhjKpRwnem5QUYD3y9gLXbLD9SENvujz96Fvg9A==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB7309.apcprd06.prod.outlook.com (2603:1096:101:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 02:34:57 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Wed, 20 Nov 2024
 02:34:57 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldCB2Ml0gbmV0OiBtZGlvOiBhc3BlZWQ6IEFkZCBkdW1t?=
 =?big5?Q?y_read_for_fire_control?=
Thread-Topic: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire
 control
Thread-Index: AQHbOmio67w/1l79vk2W+xgv0i2nS7K+oK4AgADTfaA=
Date: Wed, 20 Nov 2024 02:34:56 +0000
Message-ID:
 <SEYPR06MB513421BF046C1478303E8C299D212@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
 <27a39b05-3029-4b31-ada7-542e23e4de8b@lunn.ch>
In-Reply-To: <27a39b05-3029-4b31-ada7-542e23e4de8b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB7309:EE_
x-ms-office365-filtering-correlation-id: 595900f4-3046-4dd4-0b1c-08dd090bec3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?OGNuV056a2NMRm9XK0thRk0zUlZrV0JKNWljQlkzWldwcDBBeHpjbi91bURpang0?=
 =?big5?B?TW1xY2ZKMzNHNks4ZlZuNUtneXdwVm9DRHVNeGlkZ1JWZkJDQlovNUg5dVBCaG9u?=
 =?big5?B?eHhPY01OdUJzZnN1U21nWFRWaXY0L2xTazJyR1NPWUpGd2xZd0RqK1pQWlMvN2lY?=
 =?big5?B?dkdVRlRTMVJKZkdoMFRJUDBsbjlYeTYwZ0V2Yi9BV2wwaEFCUnV1cm5PK21zYkZE?=
 =?big5?B?UktTTklRMjZEQTl0d1JFWHJZM0R2c2dwNzBvQ3RneG5vcEhIVkpxeHltaEhUUjd4?=
 =?big5?B?SFhyQk1rSzh4UklNS0g4ZmVVWHVGSi9EcGJ0UFpXc0ticjZBc0toWHlveWNmTjRF?=
 =?big5?B?dHdEYTV0SzM4K1Q4RUw2ZkZucTJXZnVKQkxzYkJXSkswdnA3Uno1VDR2WlVMRUpa?=
 =?big5?B?bzY5Z1RLeWlGbFN1UDY3aUpsSjdjTUd3cXUrYnQ3bHY3SnJqZnR2WDZvczliYWdy?=
 =?big5?B?ejJZa2cvSThjNDFTWlRyalBxdzMwWWt1VVBsbXhqZW9lbmZkdnFjNVkrc1k3TzFN?=
 =?big5?B?cWNzYm4vTkpkRXJUL1ZWam02UVJJVzNDNnk1aTlIcGtZZHVXaSsrQkZlNE8xQmlG?=
 =?big5?B?ZzVsZzRWZEJlWTg0WFNwWStDWUh0M2wrdHlHZTlQUDVlZ0Y2bDJOTkM5c3FyWFV1?=
 =?big5?B?a3Mxc25JUkFRc3lCaEVZVDhCVGY1bTFuZS9IV0R4aHhYd255cisya3AvSUZ6ZVFZ?=
 =?big5?B?ZWZTMW9CQjBPYUgyUVFLaEFSbEFrZW5NdHQzVHRCV0hTMTFsWXB6a3VieldhRndz?=
 =?big5?B?azd0YngrN253TVhXK2Q1RlhVdWljelRRaGI1blphOGZubUNaSEhEcm5VU2ZNY0Rq?=
 =?big5?B?TlQzbXc3Mit1RDU1ZkVhaVVEb1hHRHoyVjdiZm5ONXA1cXZldXJQV2RHTHhuMmhz?=
 =?big5?B?aEJJWTlyNkNtMG81N2tOMU1oOGRPQXV6ckM2eTc2bHYwWjJmdi9uRGhvN2F0cHVP?=
 =?big5?B?WFhUdWdNVVd5M3d0K1YxRngwMm5ncytBMGpuc3hEQW41cnlxcHFyVnhoVVloaEJB?=
 =?big5?B?LzdCQWJrV2tMMXlkL0JpNy81R1MyRFZab3Z2MjhGd0NibG02TkFkTEh4d2kydjhL?=
 =?big5?B?TXNXWkpidlo1M2E3eE9UQlZmTjJwVzd1MjNpcWZLNm15bFFwRWNiZlpWTUJxOTEw?=
 =?big5?B?Ums2VzBWYWU4UkgwWU1VakIxbFBGSEFSUm9TaUYyWGF0N0ZyTXYxSkNEVDdFMURS?=
 =?big5?B?cEJjZVdEWEdFcXBET3pid0JVcUVNL3g1MC84d1o4OXJFbFRMVFhqQXgwcXZZOGJo?=
 =?big5?B?MlNmVDVhVEZMSEtFeVIyM01yZForVWNOdURQU3k2dFExMHBpdWY4MTExeUVsanA5?=
 =?big5?B?TEp0QzIvcVg0bnRnMVI1WGtvSFlVU21DYXZrWXZycjY4dWU0eEVaMUhyazhwaGtm?=
 =?big5?B?Z3J6d1N2eUoyaHdkUjcxSCsvREdseFJZUDJ2TSthUEw3T0J5ZGRyNFJsL0ZIYnFz?=
 =?big5?B?VmRtSzhpWFBheTQzMTVIUmprMjFIYXgrSm1URnVaWDRadTcxYWJiUlF2WFVTa240?=
 =?big5?B?MTZFMXp6cFlCTEZ5NFVuMkRuSmRKUVJFeXdOM3N1YTdTWFM5R1o0V1RWNTVtaHJj?=
 =?big5?B?RzN4Y3BobTRJZW1YLzArUzYvYkp1aEJMWUxuTUpEOG5NYTJtRkErUWNhVDB5dysw?=
 =?big5?B?eGRMZ2FGajRhRGF3dUhxNGxBVnpVcWVnbmFJeHNCbkdDazJOc1UvZjNCT2QxdTBu?=
 =?big5?Q?Usv+ASNUYXRrpBD0ugrQsf7TJQH+PCOjgAPdxQcvoHk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?QmpWYUR3MXlwWFVnZy9pRjkvMWdrQlZYc0NpYVlqWlNVWWNLT0F2NCtBRmpBQUtJ?=
 =?big5?B?WE91YWdkcnRpdnBBL1FRT0JFV0crUmt4WU55eHIvWlBuNVlrU2xDVk55YytoY1FJ?=
 =?big5?B?bEE3ZUVlOHNqbmRDeitYMW04eFVFREVKd0s0SmM2NEhCVDhySHZkY3ZGQVRKdXM5?=
 =?big5?B?NE1oZUVWNEhrRGNkaHZ4UkdOK0JSUk9LQnhhSysvcHJzM3lLZk96bkxQNEJ0Z1VU?=
 =?big5?B?TkRyL3VLVmxYV0xzWmFRL2VwUldibWgvWWpMWVJOenF4OTZBK0lsMGFRZ29WVXRi?=
 =?big5?B?S0VDeEE0NW9QbkRmU2E5SHo0WERQdG8xR0p3aURubjViUXhqRjZ6bElRTEJJb1Rp?=
 =?big5?B?VENJTFlUT0RGV1VZbTl4Vm5lc0VPL2ZUTFNiSEhaSGR3OXhNN1BHb2JmZTdZaFg3?=
 =?big5?B?dk1kMCsxbERXbFdlMzV3TXFUemRUR3VDRXpSK3MycjVoU1dzVkZkSExSMWswM0d1?=
 =?big5?B?WldIZGdYWTlPbEZ6Wk5LQ0NoZTNGWXJ4ZlJVeHAxV0ZnampZcGZ6N05lVmZkcVQ4?=
 =?big5?B?TkNwbFNlcHdxOWtlVGZ5dEJxS251VXdvWEt0M1ZGbmFQUWZQYVF1VkZ0MHp5a3Bo?=
 =?big5?B?R3pvTHdEUWtsL3pMS2tmSnNadXBua1puYTUvSFJHZkluQ1cyeXNlVlBDRDJFWTBx?=
 =?big5?B?SVZnNFNTdThCNytlOHdqZmxzbG1YOUxkREhSUGNsU0piVEVKaE41SDVpUzR3bzBk?=
 =?big5?B?VzRGOHpNTlpDV0ZPZlR4Nmh6eE02TUZDSDFrQlVMcFhqdnRxdXgybkxTTjFTYitP?=
 =?big5?B?SnA1QUJocWZaNlEzREdHTjR1dnVVRUNsYm4xUHo0Z2VadkIrY1BWUHRPei84Yi8x?=
 =?big5?B?eDB6STdiWks5TytRY2FVLzlqb0xtcTRaMHFSTXVjNEJzQmxrT1VxZ3lFTlUzQTFE?=
 =?big5?B?VXRtMEF3SGxjOC9hckxqbi9BdllMK0t3NnJKK0I3c0NBbW5JMzc4TmxCSHlCZzBj?=
 =?big5?B?Y0FmUXh5ZnkxVnM3aFBjVmdDaGtLaW1BdDNFSU1MZ2dVMU5YSE5nb2hQRDIwRTMz?=
 =?big5?B?VEZGaE5DVERqN0YzSFVWVCtmZldRekJrTUpqZjZkRzNGQ2RadkN0RXlBT00zZ013?=
 =?big5?B?S3k2YUNWVlFOQTZmbWJCYktzdXpjWFkvcGc0QVVZaXF6Mngzcy9kWXcxbEZJa01L?=
 =?big5?B?Z2VKdFNYQnNKS04rUFZiYi9UNWZGOGlwN1VqZTBCMGRVaGFpdkQ1dWNZN2xtK3A0?=
 =?big5?B?OFhTRGNGWlhNN0pDUmREVkg3NEFHYmpVUTE0Q1JITUFaR2JjNnRwZ1FWa2k5N1R6?=
 =?big5?B?bTlpSFN1T2g5MmkrSU1XZ0FPcjROQWovdXlzUHJoTndQb3RWM0EwTWV1a0k1UkNC?=
 =?big5?B?clZMSklBK2Q3ZmVacyt3aGhHQTR5b0tNNzBPN2RNUmVNekFmYjgySnYzcTRPT1c0?=
 =?big5?B?SWc0WUt5NTREUStKU3kzTWhlendybUM0TlUzNnZGNVhrSWFnUllFQ2tOU3orNWVH?=
 =?big5?B?VUVNeWFkRC9MYUZoMWpqRmlIbHo1QW5ycWJSMnE1YlBHVURydzBiVll1RGFCQ0lM?=
 =?big5?B?ZXZ2eTVmY3ViWGtia1lmYmRoUjFJN2NpMkNLaVBPQ1hIdjczQkpXckVhamVkK3lE?=
 =?big5?B?L2duTkh2eitJUWwrTzVCSk1YVlhZNHJPZ3JIMUlOYUdyT1V5bXpvZFlRMVkvWUdv?=
 =?big5?B?RFFlOHdidXNJcnRabndXb25sY1J0a0ttVXpJU1NiWXJaUENHZ3ZuZjNTUys5YTd3?=
 =?big5?B?VHNDSWZNblNNWjZ5Mnh0MUs5dndabFpLWWdCcERpRld6ZCt2UG45MU5yMFQ5cUw0?=
 =?big5?B?WGN4QUVzZi82VnJTemZRUno4ZTByLzlpM2dXbHJqVDdrajRwSWJVZDNXejFmNnlN?=
 =?big5?B?K0tmMVNDTElqVVkxcEJUZFlZUTB6ZWQ5VldMdVNQSU5VKzk0aUNkWkVlS2ZxcVlv?=
 =?big5?B?Y1p6bXFSZk56R1dTeE9iSlJDeWRrcUZHZEd5MHM3bHVuTGVwWVBxdHVQblpXcE5a?=
 =?big5?B?ekZCVXkrTUZybVBndCtVUXFwVDBHblY5cVBhN1FuczM2N0JPS0l3ejBKdFJrRjkv?=
 =?big5?B?R21TK0c4LzNMTmxIRU5OK1FMb091azJFV2U2SDdWemF5dEo3WUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 595900f4-3046-4dd4-0b1c-08dd090bec3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 02:34:56.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeDIzigZ7ER76tyCdtQTrG0UrebQ/uxnoJfzMBHuygzUtTtMRzKJ9oBF7HaUG3mYT9ARyQoAGkXsgeJ79ZSuB6CjIlfCXHVFOpZLTrOYdRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7309

SGkgQW5kcmV3IEx1bm4sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IFdoZW4g
dGhlIGNvbW1hbmQgYnVzIGlzIHNvbWV0aW1lcyBidXN5LCBpdCBtYXkgY2F1c2UgdGhlIGNvbW1h
bmQgaXMNCj4gPiBub3QgYXJyaXZlZCB0byBNRElPIGNvbnRyb2xsZXIgaW1tZWRpYXRlbHkuIE9u
IHNvZnR3YXJlLCB0aGUgZHJpdmVyDQo+ID4gaXNzdWVzIGEgd3JpdGUgY29tbWFuZCB0byB0aGUg
Y29tbWFuZCBidXMgZG9lcyBub3Qgd2FpdCBmb3IgY29tbWFuZA0KPiA+IGNvbXBsZXRlIGFuZCBp
dCByZXR1cm5lZCBiYWNrIHRvIGNvZGUgaW1tZWRpYXRlbHkuIEJ1dCBhIHJlYWQgY29tbWFuZA0K
PiA+IHdpbGwgd2FpdCBmb3IgdGhlIGRhdGEgYmFjaywgb25jZSBhIHJlYWQgY29tbWFuZCB3YXMg
YmFjayBpbmRpY2F0ZXMNCj4gPiB0aGUgcHJldmlvdXMgd3JpdGUgY29tbWFuZCBoYWQgYXJyaXZl
ZCB0byBjb250cm9sbGVyLg0KPiA+IEFkZCBhIGR1bW15IHJlYWQgdG8gZW5zdXJlIHRyaWdnZXJp
bmcgbWRpbyBjb250cm9sbGVyIGJlZm9yZSBzdGFydGluZw0KPiA+IHBvbGxpbmcgdGhlIHN0YXR1
cyBvZiBtZGlvIGNvbnRyb2xsZXIgdG8gYXZvaWQgcG9sbGluZyB1bmV4cGVjdGVkIHRpbWVvdXQu
DQo+IA0KPiBQbGVhc2UgaGF2ZSBhbm90aGVyIGF0dGVtcHQgYXQgd3JpdGluZyB0aGUgY29tbWl0
IG1lc3NhZ2UuDQo+IA0KPiA+IEZpeGVzOiBhOTc3MGVhYzUxMWEgKCJuZXQ6IG1kaW86IE1vdmUg
TURJTyBkcml2ZXJzIGludG8gYSBuZXcNCj4gPiBzdWJkaXJlY3RvcnkiKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphY2t5IENob3UgPGphY2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvbmV0L21kaW8vbWRpby1hc3BlZWQuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L21kaW8vbWRpby1hc3BlZWQuYw0KPiA+IGIvZHJpdmVycy9uZXQvbWRpby9tZGlvLWFzcGVlZC5j
IGluZGV4IGMyMTcwNjUwNDE1Yy4uMzczOTAyZDMzYjk2DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvbWRpby9tZGlvLWFzcGVlZC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvbWRp
by9tZGlvLWFzcGVlZC5jDQo+ID4gQEAgLTYyLDYgKzYyLDggQEAgc3RhdGljIGludCBhc3BlZWRf
bWRpb19vcChzdHJ1Y3QgbWlpX2J1cyAqYnVzLCB1OCBzdCwNCj4gdTggb3AsIHU4IHBoeWFkLCB1
OCByZWdhZCwNCj4gPiAgCQl8IEZJRUxEX1BSRVAoQVNQRUVEX01ESU9fREFUQV9NSUlSREFUQSwg
ZGF0YSk7DQo+ID4NCj4gPiAgCWlvd3JpdGUzMihjdHJsLCBjdHgtPmJhc2UgKyBBU1BFRURfTURJ
T19DVFJMKTsNCj4gPiArCS8qIEFkZCBkdW1teSByZWFkIHRvIGVuc3VyZSB0cmlnZ2VyaW5nIG1k
aW8gY29udHJvbGxlciAqLw0KPiA+ICsJKHZvaWQpaW9yZWFkMzIoY3R4LT5iYXNlICsgQVNQRUVE
X01ESU9fQ1RSTCk7DQo+IA0KPiBNYXliZTogLyogRHVtbXkgcmVhZCB0byBmbHVzaCBwcmV2aW91
cyB3cml0ZSB0byBjb250cm9sbGVyICovDQoNCkFncmVlLiBJIHdpbGwgY2hhbmdlIHRoZSB0aXRs
ZSBpbiBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNCkphY2t5DQoNCg==

