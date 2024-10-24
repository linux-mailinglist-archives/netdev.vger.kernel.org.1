Return-Path: <netdev+bounces-138627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3889AE63A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B44B287394
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A41E2821;
	Thu, 24 Oct 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="3E1dgXSd"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020123.outbound.protection.outlook.com [52.101.169.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93871D9A71;
	Thu, 24 Oct 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776269; cv=fail; b=fvgQhaGG0r2evWwe5t0Hu2LfeeADlKJjzORWg/sWqmdfDxepeCylth5npzPWgxo1L5bW+lBh9Npg41BF6j5QnK3mDeLvqeB1OO2c55lulx+Zkuj4l9M2xHSm5o3lF9nkeICY46+Tn5YI9GPjW1nncdPh2CyCdiq3bp6GMl5KMzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776269; c=relaxed/simple;
	bh=S5VTMBtqNy8wFhijNvuBMmv2oV9cj940jaAXCEWZmhM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dq6D6DpZ3n2ceymeGKSBnicnQ0awoDFpXgzOKbPJCkfnPo21zBgLJqHLMhyuaUkjJXgviSiTNBqDIh+0pMfN/2lP5VL+SZGlKZAV8kTiT1lenwjuPykYl4GPiUpPQFm+8ps9TOT1hAfih9tEBiVqK/ZkatOCZEb2ERIecYEg7e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=3E1dgXSd; arc=fail smtp.client-ip=52.101.169.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW1QpHxGyCHSKH3dZOoH9ASjSmLxJ4MH/x21lT7wsv7z8TYViCZr0zZULcKJoOefwdZZFvvbsImT/H15FXTSai6M27J+KOAiG4QdMoCH3+bTFiCGzWJqzlbAi4MI4z9MxzL1l9DxNttJk+Hth1i7MVpBG6HpFTNrIIySyJON7AwK+oaWoVap62r3CicAnQAz6I2n4o080gQ7rA5izz1dOQZ/gCXuAFYEpNE0H4kZO5SzWXLNHaTZ4PAdUYCtq0Q3PDMz5UXrE2TErxrf0qgQKyjumbBYmVBGUHGhnOjy/ykZFrsf00nMRvRj2993zt+DMKbip2AW19BhXVoRWKAJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5VTMBtqNy8wFhijNvuBMmv2oV9cj940jaAXCEWZmhM=;
 b=sWyugkTGwdXyclEBVg/YPJcKI5g1rKQ065+V7M9QUcXxwRcTPvEAq+1oDRH1B3ONdXtQfIVSflDwmc8fhwR+nNsFHsKQzNyuKg6YGa9cNPlqXX9oxsOt+4So7iieT74CRD1P3VkNNk6TmwSyqvmHVCXJ3K3EE+2SfE714jUDWqPEfdEi+0AsGgKlHDP5SMA10WzeiCYJSfVg/I8AFpBBF2j6a63KB26GTeSWibpDZdd3pwrIjc7qUXrUwI0AoCNMXVOuqzL84jWsh/EdPoldpbkj3dr2enYwnD8Y1E7Abn7NDNb4mDDh80Fs4gPdXmCPVErTrNaPJRqMgsq6nYZ3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5VTMBtqNy8wFhijNvuBMmv2oV9cj940jaAXCEWZmhM=;
 b=3E1dgXSdQ/dZwhQomWZJXGVveY5nWnTsCuUjEaRoXvDe3xMIUs1hQy0fsy9qNwSAPPBpbwhCFo9Wug0Wbo+JPmJQotXZ2Sk5itIeE9TYeiTK4o8rn7deyKyzG6udUozKIwCgWC2RPT2CApZk24f1ZP3UIu5LTs17s92bDnnBQDHvc2nAKI+PIEuPCseHR74FX95iO8x+9EWbG5WSHKlAUx9FMlwpvAF1Cdf9ltgycyqBOWwVS6FzZepDe2qX+xR5mC5nznzflhldhnPhslURBcEzHwz4u02Ow4FUPz/jUVa0550fE1rn42/XDCREgWl51kgm5tTOTw01cLoHOvF+zg==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FR4P281MB3493.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Thu, 24 Oct 2024 13:24:23 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 13:24:23 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"jeremie.dautheribes@bootlin.com" <jeremie.dautheribes@bootlin.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: [PATCH net-next] net: phy: dp83822: Configure RMII mode on DP83825
 devices
Thread-Topic: [PATCH net-next] net: phy: dp83822: Configure RMII mode on
 DP83825 devices
Thread-Index: AQHbJhgKGFGOOWZToUS3NBClQzY34Q==
Date: Thu, 24 Oct 2024 13:24:23 +0000
Message-ID: <aa62d081804f44b5af0e8de2372ae6bfe1affd34.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FR4P281MB3493:EE_
x-ms-office365-filtering-correlation-id: c57beb85-e4f7-417a-fb6f-08dcf42f2d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzlOeXJPenp3RFJRU1YyWG50NjZjMGo0aVlLUjBpMm5aNmlsM0t2VkZVb3Jq?=
 =?utf-8?B?N0d1eDlZTFlRalZCbmJscXNmZFY0cVo1L01wU25wUjdzbnlFZGIzQ0JuMkhD?=
 =?utf-8?B?YWpkOHJaYUsxOE9zRjlYNVQ0ZWlaZytlVExadlNXUnV1U0hObVg5YWZCbnBt?=
 =?utf-8?B?eGxicHVXUkxTWUNWM2lXM2lpdHczK1JYd2s3cDM4aVArcUlUYTVpSGVhdzBx?=
 =?utf-8?B?ck5xbmhhRkN2aktkdWhtM0psa2REdmRYVDkrSkcrWGVJRkVXNnJqaS9wRHBu?=
 =?utf-8?B?SVlkRkNaRHZseHhvM3BrRXdmcGlNSjJ5c3A4dlZ0LzlST0N5bHZzMGoxek5a?=
 =?utf-8?B?aFl6UWlWRlp4emN4OWJET3pHSlVNOGxUTlYrZzd2OFk4V1Y3RjB4aDE0MWJB?=
 =?utf-8?B?dEt2Ynk4Q1VzZDN5a2RvTi9ZREp4TllFcXAzYlI5VWtXSlZOYmFpTEFCaG5j?=
 =?utf-8?B?SnF5RzF3QUJSRDEvZnVkWGszNEpnQ096cGlSRnJWWHdPc0NRWDZkZXNaWFVX?=
 =?utf-8?B?eldyQXVDVjcvZUQxSldNRzdzeTUzVGxHb1hScW5GSG5OT2pVUi9EaTcyRTZT?=
 =?utf-8?B?d0YyRDJVcSthRW8xNVZ4K1FnK1h4c2w3UnRVM0N5U0FkNW41bkpxWXpaREl3?=
 =?utf-8?B?bENzeE9QL1crZVdNSWJKTnhrRkxkdTJ1bVExVEIxbXI1SWlVL0loc1B1MWcy?=
 =?utf-8?B?NXQyM1A3UUlvMmZxbGNCSVp6SnVXZS9IaDB1c3U0UnNWWDE0U3VvZ0dnZVVM?=
 =?utf-8?B?TDdaREttbmViU2ZGcW5ZVXErNFJjR1orOFVNcnpKenN0SkV6cnB0YklPbVZC?=
 =?utf-8?B?UXhTNnZLOG80R0FxWWVBS0tiNlorSXg3ZUNzOU56eGhyQWdQWjdxVTNaSnJE?=
 =?utf-8?B?aE9jOU5PdC8wWmNrd0QxMzQ3OVFab05ISkFHN2ErSk9jQkRsaTQ4TGlhZ0lO?=
 =?utf-8?B?azlROFNqN0tkTGlBV1plVUVsQ05wU1A5WW50QzBuT1M2ckxrVndRU2IrVWkx?=
 =?utf-8?B?YzIrN1pWRVRvS3VtRFRHcjl1TlNkM2lLRWJRVlErcnV4N2FyTmhZRVp2aE5T?=
 =?utf-8?B?b2VUMWVGMC9aQzM4dTlCOTJLdjZiV2FZd1BFNWpVazZCK3VUMFlRaUJ2Skoz?=
 =?utf-8?B?VFFKWXlFeXozeTVlYWVjUDBpRHovSkRjcmJaems2L24rT21LZndLcytMMG1Z?=
 =?utf-8?B?VEN0Zmk2SGgwRUNsY3hVU09oUG90M04xN1VyN0ZxendtNm9xZUFmUWVsVkRV?=
 =?utf-8?B?VjlwK2V4V2t0bjNBU1M4bnZjT0xrOEp0MHBYUnZzVmcyWlI1TThNVzV0K1Zk?=
 =?utf-8?B?Q2o5UVU1cVB1dml5Q3NHdml5UUlORWxseDZsb09JMWxVZk1hMEpUT2pLN1Mr?=
 =?utf-8?B?bkJQeWhXbDZqZWR2VVgyckNPREdvbTVpL21VN0EweXlYOENzWkMzQ3dnU0hl?=
 =?utf-8?B?OWFvbk9oZmVBRXVLOU1aYm9haHJRZU9Wa0pMRGwrNFRmWlhVd1dHZEZBVzZr?=
 =?utf-8?B?ZXlyRGlxeTEvUUIwT1FyWkcyUnIzRU1GMWRvWCtwVE1Vd0pHTHVjQkplQ09y?=
 =?utf-8?B?UUZrZnFGczJmOHlycllZT0dIWTMvR0p2bmZJK2hraEFzcGhCMThnVy9wUG1h?=
 =?utf-8?B?QkYwVWRUSEg1QTZJQkN6TThscERaYll5YnJVRVV4eWlaUUpqUWdnSXdtNjEv?=
 =?utf-8?B?Ym1CZXdKbjBWMDgyQkZ0bktKZ2VTOUZUVTdOUDNCYmlFMWRObEJNaytCeVo5?=
 =?utf-8?B?VnZSR000VFNtZ3d2bGRSNGkwTXRSNnZEY0VlLzROV05iMVdtUGRQb2pPeXZv?=
 =?utf-8?Q?y+L4jmDkgQjmj9RaFnGRnefZlpKu+Sqp3gk7g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am9ZcGNDZElTZWMvR2ZGc3ArTUo3VWdJeS9kL3dldFJ4TGFQRzBVaXNETHBG?=
 =?utf-8?B?WFlHdVkwU3Y1dTlrdmtFR09Iakd0RUlFVStuRjZhTElaTXRSdWpqY2hkRERr?=
 =?utf-8?B?MTBqelYwZWV5MCtRMW9FRVdiQWJZbGQ2ZURGcjcyUWV2d1ZKdTcxeFRQOXJH?=
 =?utf-8?B?dkRWM3lGTG1XcXdiTklHYmNlRTlpVFhMZ1pseE1US2VBTEVrMFN6YlhOT3Q4?=
 =?utf-8?B?R2t5NjhINTJYRmhxVnBlTVR3L2Y5b2lRN2pDbG0xNDgvK1cwd3Z2OHZTUG9a?=
 =?utf-8?B?Sk5Ja0xKamxBZ01RN3EzVW5FaXVnSFR4T21iYVNISUJQTjNuVnhjTmtEVzFv?=
 =?utf-8?B?RGxPc1NZeTFoMjVaUi9NUjZVSlNEWjNpODN5aS9QODdJYS9CQmVtZVBjYk9u?=
 =?utf-8?B?L1hPQkxvWUFnTEp0aks2WjR6VStNZEFISVRQSTFuYmZ5UFFteXc2bDZjQTJy?=
 =?utf-8?B?K3NqSC9XQjVsY0QzMlJPazFZakhxT2VvamNBcjh5cnprb0QzbC9PQld5NFNY?=
 =?utf-8?B?dC9KQlpXalhSMnU2YlpoMjF4aHdieDhQU2QvdUl1ZlVMNVhveGdBaHRDZ3Vz?=
 =?utf-8?B?b00wVUtBMGpLd29Fd3MzanFsMkgrbUYvT1dIbVhXemM2OXJhQk9wTkFkNUd6?=
 =?utf-8?B?NU5pODhOQnhla1JKLys4Z2MzV3F6OVA2OVVYWEFPeHY2Y1ZnbVNQYWU2K3p6?=
 =?utf-8?B?NWtPOUhDVWQ5YmpLZVpHUXNBNmZ6aUc0QmhJQWFTc3hKUUd2YndRc0phTmth?=
 =?utf-8?B?SW9IVzd4MUMrRHdRbHJVdTB1ZDRqVnNJbHh1cUN6WTFDWXF0MWQ1dmE1TjVn?=
 =?utf-8?B?MDVHT3FKOFUrcldBRytDNjBQb3FaajRYVDRMaGwxVEJrUHRVS2pIa0toRHYy?=
 =?utf-8?B?MTdMYXl2MklaNmJyVmVNcU9IT2pVWXQvODhZSjVyRHcycDZPYThJTFViUDdX?=
 =?utf-8?B?UUJ0eFhzZEtSOGRSVUs2THNReVlzUE5pTVpFbmJ5TGt6VVFmSkxYWVlaQWxU?=
 =?utf-8?B?MkVTYUNlUG9VOUJuTXFiNDc1RCtVUjJxZzdoK3Y0c3NxZnEyVW8xNzhycTNZ?=
 =?utf-8?B?T1E4UFpjaEdMSHpnNmxOTUd4dmVSc1JjQjY3a0RIYlBUVjZTUzVOOVJDVkI2?=
 =?utf-8?B?eWtwODBGV2ovT0NFMUJpd1Q5djE5dkJ2WVdtMGRTc1EyeDRXaktXUVJYaFVq?=
 =?utf-8?B?V1ozak9RSHdKbVNaa1M1NmF0SDlwK0VpZWZjQjBnZjRpTXpuZHgrSTFVNmZQ?=
 =?utf-8?B?dmo1eFp1djQrcFVOakVtSis2WGtPSVhyVzIrdkhSUmkzdmEvWjFHMkgwck01?=
 =?utf-8?B?dGtxWWM0WXVDUEVDcm1wQUdscVJlMDg0dmg4L3ZrWlJNL2hXY2QzWmxBR1JO?=
 =?utf-8?B?S3RuSmRpVXhLWUZVZmR5SlZCcUkvTm5zV2ZCK0RWQUQzN1NxdUhmdGRSL3Nn?=
 =?utf-8?B?TnMvaGEvMU50T2xmN3VEOGM3U3UwNStvcHp6T2lKWmh0L2dibmw5cldTc2Qw?=
 =?utf-8?B?SmZNaTNBdGRTUktDNFpjU2NXK2l3UEdjYXBuczZhTThiL3dWSEpGNUxqRVVw?=
 =?utf-8?B?YzRFZDdDM0tEczFIZE1ESHhOWGQ5TWM0SHV6L3loVDBnVjB1Tno4aTdaR3ZI?=
 =?utf-8?B?eFMvQTIzY2hrUWdTMnlJMktyNWRKdWhObHRHZjg3N2JlNFZSTE15bnI5UStW?=
 =?utf-8?B?S29HQzJxZWx1eEtzaG1LbEhpdjcxVU85b3dMTXNyZHozalFhMEt4YlZENTVK?=
 =?utf-8?B?Ri95bUpHKzJMOTN6bVRJeXV4RG1aRWJySEdSZWtpU0RTeEdmMXNDL2tZT2dK?=
 =?utf-8?B?OTFTeDUwOUZ2dHF6dzdYTGRnSGVoZHlZbko3eVMxRHJISjFDOXJ2Q3NsWTFD?=
 =?utf-8?B?MmI4ZVVYSmdWaU0zb2hpY0c3bTRFL0grOHc5c1orcjhEU2tsb2o5Y0NvWTVo?=
 =?utf-8?B?RlRHc1NPU3MwLzlXSVZmQlJ5YSt0aWEreW92bE1OWWN1d3JZYzY0c3ZGUjZG?=
 =?utf-8?B?bkk1bkt2M0F2Z0Qyb1dBa2d3eS9rdlFpQ3dYcTJPeFY1Y0V1VmlYTy95dWFn?=
 =?utf-8?B?c25FcjdZWS8zQjFYQ0hERTNBUUhFMFN1ZVFqbXNDMVBBSCt1TVAyN2xjUWtT?=
 =?utf-8?B?VjBZSlBGOVN3a2piRng1VXFET292dkEvSFMvaUozT1BzOFlKVERpaVNmdGFz?=
 =?utf-8?B?eklzajEvVGhHWGc0d25FTFQ3VkJNSnRrRXQ5ZzJTMVA0cG13SHZ3eFE5VHk0?=
 =?utf-8?Q?ECBAtRS30EbLo4pFd6AzU9UBvm+BW4HUf/saiEyT9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <442FA0F2D6093244B25BE6581A00D7DB@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c57beb85-e4f7-417a-fb6f-08dcf42f2d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 13:24:23.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgSYf+cv30iEJX8OHJAVmlksql14P0f9N40iqWZWNBAczRSIgMoKH3hfrrK5vUWktqZJPT75AEJ8YiA291QUvNBzUK63EnBS5WWI9TX29KReifnZqYelucxwIr5YiLCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3493

TGlrZSB0aGUgRFA4MzgyNiwgdGhlIERQODM4MjUgY2FuIGFsc28gYmUgY29uZmlndXJlZCBhcyBh
biBSTUlJIG1hc3RlciBvcg0Kc2xhdmUgdmlhIGEgY29udHJvbCByZWdpc3Rlci4gVGhlIGV4aXN0
aW5nIGZ1bmN0aW9uIHJlc3BvbnNpYmxlIGZvciB0aGlzDQpjb25maWd1cmF0aW9uIGlzIHJlbmFt
ZWQgdG8gYSBnZW5lcmFsIGRwODM4MnggZnVuY3Rpb24uIFRoZSBEUDgzODI1IG9ubHkNCnN1cHBv
cnRzIFJNSUkgc28gbm90aGluZyBtb3JlIG5lZWRzIHRvIGJlIGNvbmZpZ3VyZWQuDQoNCldpdGgg
dGhpcyBjaGFuZ2UsIHRoZSBkcDgzODIyX2RyaXZlciBsaXN0IGlzIHJlb3JnYW5pemVkIGFjY29y
ZGluZyB0byB0aGUNCmRldmljZSBuYW1lLg0KDQpTaWduZWQtb2ZmLWJ5OiBFcmlrIFNjaHVtYWNo
ZXIgPGVyaWsuc2NodW1hY2hlckBpcmlzLXNlbnNpbmcuY29tPg0KLS0tDQoNCk5vdGU6IFRoaXMg
Y291bGQgcHJvYmFibHkgZXh0ZW5kZWQgdG8gY292ZXIgdGhlIERQODM4MjIgYXN3ZWxsIGFzIHRo
ZQ0KY29uZmlndXJhdGlvbiByZWdpc3RlciBiaXQgaXMgaWRlbnRpY2FsLiBCdXQgSSBoYXZlIG5v
IERQODM4MjIgdG8gdGVzdCBhbmQNCmJlY2F1c2UgdGhlIERQODM4MjIgZG9lcyBzdXBwb3J0IE1J
SSBhbmQgUkdNSUksIEkgY2FuJ3QgcnVsZSBvdXQgYW55IHNpZGUNCmVmZmVjdHMuDQoNCiBkcml2
ZXJzL25ldC9waHkvZHA4MzgyMi5jIHwgMzEgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9kcDgzODIyLmMgYi9kcml2ZXJzL25ldC9waHkv
ZHA4MzgyMi5jDQppbmRleCBmYzI0N2Y0NzkyNTcuLjkxNWEzNGRhMDRkYSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbmV0L3BoeS9kcDgzODIyLmMNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9kcDgzODIy
LmMNCkBAIC01MDYsNyArNTA2LDcgQEAgc3RhdGljIGludCBkcDgzODIyX2NvbmZpZ19pbml0KHN0
cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQogCXJldHVybiBkcDgzODIyX2NvbmZpZ193b2wocGh5
ZGV2LCAmZHA4MzgyMi0+d29sKTsNCiB9DQogDQotc3RhdGljIGludCBkcDgzODI2X2NvbmZpZ19y
bWlpX21vZGUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCitzdGF0aWMgaW50IGRwODM4Mnhf
Y29uZmlnX3JtaWlfbW9kZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KIHsNCiAJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQogCWNvbnN0IGNoYXIgKm9mX3ZhbDsN
CkBAIC01NDQsNyArNTQ0LDcgQEAgc3RhdGljIGludCBkcDgzODI2X2NvbmZpZ19pbml0KHN0cnVj
dCBwaHlfZGV2aWNlICpwaHlkZXYpDQogCQlpZiAocmV0KQ0KIAkJCXJldHVybiByZXQ7DQogDQot
CQlyZXQgPSBkcDgzODI2X2NvbmZpZ19ybWlpX21vZGUocGh5ZGV2KTsNCisJCXJldCA9IGRwODM4
MnhfY29uZmlnX3JtaWlfbW9kZShwaHlkZXYpOw0KIAkJaWYgKHJldCkNCiAJCQlyZXR1cm4gcmV0
Ow0KIAl9IGVsc2Ugew0KQEAgLTU4NSw5ICs1ODUsMTQgQEAgc3RhdGljIGludCBkcDgzODI2X2Nv
bmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQogCXJldHVybiBkcDgzODIyX2Nv
bmZpZ193b2wocGh5ZGV2LCAmZHA4MzgyMi0+d29sKTsNCiB9DQogDQotc3RhdGljIGludCBkcDgz
ODJ4X2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQorc3RhdGljIGludCBk
cDgzODI1X2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQogew0KIAlzdHJ1
Y3QgZHA4MzgyMl9wcml2YXRlICpkcDgzODIyID0gcGh5ZGV2LT5wcml2Ow0KKwlpbnQgcmV0Ow0K
Kw0KKwlyZXQgPSBkcDgzODJ4X2NvbmZpZ19ybWlpX21vZGUocGh5ZGV2KTsNCisJaWYgKHJldCkN
CisJCXJldHVybiByZXQ7DQogDQogCXJldHVybiBkcDgzODIyX2NvbmZpZ193b2wocGh5ZGV2LCAm
ZHA4MzgyMi0+d29sKTsNCiB9DQpAQCAtNzgyLDE0ICs3ODcsMTQgQEAgc3RhdGljIGludCBkcDgz
ODIyX3Jlc3VtZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KIAkJLnJlc3VtZSA9IGRwODM4
MjJfcmVzdW1lLAkJCVwNCiAJfQ0KIA0KLSNkZWZpbmUgRFA4MzgyNl9QSFlfRFJJVkVSKF9pZCwg
X25hbWUpCQkJCVwNCisjZGVmaW5lIERQODM4MjVfUEhZX0RSSVZFUihfaWQsIF9uYW1lKQkJCQlc
DQogCXsJCQkJCQkJXA0KIAkJUEhZX0lEX01BVENIX01PREVMKF9pZCksCQkJXA0KIAkJLm5hbWUJ
CT0gKF9uYW1lKSwJCQlcDQogCQkvKiBQSFlfQkFTSUNfRkVBVFVSRVMgKi8JCQlcDQotCQkucHJv
YmUgICAgICAgICAgPSBkcDgzODI2X3Byb2JlLAkJXA0KKwkJLnByb2JlICAgICAgICAgID0gZHA4
MzgyeF9wcm9iZSwJCVwNCiAJCS5zb2Z0X3Jlc2V0CT0gZHA4MzgyMl9waHlfcmVzZXQsCQlcDQot
CQkuY29uZmlnX2luaXQJPSBkcDgzODI2X2NvbmZpZ19pbml0LAkJXA0KKwkJLmNvbmZpZ19pbml0
CT0gZHA4MzgyNV9jb25maWdfaW5pdCwJCVwNCiAJCS5nZXRfd29sID0gZHA4MzgyMl9nZXRfd29s
LAkJCVwNCiAJCS5zZXRfd29sID0gZHA4MzgyMl9zZXRfd29sLAkJCVwNCiAJCS5jb25maWdfaW50
ciA9IGRwODM4MjJfY29uZmlnX2ludHIsCQlcDQpAQCAtNzk4LDE0ICs4MDMsMTQgQEAgc3RhdGlj
IGludCBkcDgzODIyX3Jlc3VtZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0KIAkJLnJlc3Vt
ZSA9IGRwODM4MjJfcmVzdW1lLAkJCVwNCiAJfQ0KIA0KLSNkZWZpbmUgRFA4MzgyWF9QSFlfRFJJ
VkVSKF9pZCwgX25hbWUpCQkJCVwNCisjZGVmaW5lIERQODM4MjZfUEhZX0RSSVZFUihfaWQsIF9u
YW1lKQkJCQlcDQogCXsJCQkJCQkJXA0KIAkJUEhZX0lEX01BVENIX01PREVMKF9pZCksCQkJXA0K
IAkJLm5hbWUJCT0gKF9uYW1lKSwJCQlcDQogCQkvKiBQSFlfQkFTSUNfRkVBVFVSRVMgKi8JCQlc
DQotCQkucHJvYmUgICAgICAgICAgPSBkcDgzODJ4X3Byb2JlLAkJXA0KKwkJLnByb2JlICAgICAg
ICAgID0gZHA4MzgyNl9wcm9iZSwJCVwNCiAJCS5zb2Z0X3Jlc2V0CT0gZHA4MzgyMl9waHlfcmVz
ZXQsCQlcDQotCQkuY29uZmlnX2luaXQJPSBkcDgzODJ4X2NvbmZpZ19pbml0LAkJXA0KKwkJLmNv
bmZpZ19pbml0CT0gZHA4MzgyNl9jb25maWdfaW5pdCwJCVwNCiAJCS5nZXRfd29sID0gZHA4Mzgy
Ml9nZXRfd29sLAkJCVwNCiAJCS5zZXRfd29sID0gZHA4MzgyMl9zZXRfd29sLAkJCVwNCiAJCS5j
b25maWdfaW50ciA9IGRwODM4MjJfY29uZmlnX2ludHIsCQlcDQpAQCAtODE2LDEyICs4MjEsMTIg
QEAgc3RhdGljIGludCBkcDgzODIyX3Jlc3VtZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0K
IA0KIHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBkcDgzODIyX2RyaXZlcltdID0gew0KIAlEUDgz
ODIyX1BIWV9EUklWRVIoRFA4MzgyMl9QSFlfSUQsICJUSSBEUDgzODIyIiksDQotCURQODM4Mlhf
UEhZX0RSSVZFUihEUDgzODI1SV9QSFlfSUQsICJUSSBEUDgzODI1SSIpLA0KKwlEUDgzODI1X1BI
WV9EUklWRVIoRFA4MzgyNUlfUEhZX0lELCAiVEkgRFA4MzgyNUkiKSwNCisJRFA4MzgyNV9QSFlf
RFJJVkVSKERQODM4MjVTX1BIWV9JRCwgIlRJIERQODM4MjVTIiksDQorCURQODM4MjVfUEhZX0RS
SVZFUihEUDgzODI1Q01fUEhZX0lELCAiVEkgRFA4MzgyNU0iKSwNCisJRFA4MzgyNV9QSFlfRFJJ
VkVSKERQODM4MjVDU19QSFlfSUQsICJUSSBEUDgzODI1Q1MiKSwNCiAJRFA4MzgyNl9QSFlfRFJJ
VkVSKERQODM4MjZDX1BIWV9JRCwgIlRJIERQODM4MjZDIiksDQogCURQODM4MjZfUEhZX0RSSVZF
UihEUDgzODI2TkNfUEhZX0lELCAiVEkgRFA4MzgyNk5DIiksDQotCURQODM4MlhfUEhZX0RSSVZF
UihEUDgzODI1U19QSFlfSUQsICJUSSBEUDgzODI1UyIpLA0KLQlEUDgzODJYX1BIWV9EUklWRVIo
RFA4MzgyNUNNX1BIWV9JRCwgIlRJIERQODM4MjVNIiksDQotCURQODM4MlhfUEhZX0RSSVZFUihE
UDgzODI1Q1NfUEhZX0lELCAiVEkgRFA4MzgyNUNTIiksDQogfTsNCiBtb2R1bGVfcGh5X2RyaXZl
cihkcDgzODIyX2RyaXZlcik7DQogDQotLSANCjIuNDcuMA0KDQo=

