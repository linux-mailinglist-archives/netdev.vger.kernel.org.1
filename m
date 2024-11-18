Return-Path: <netdev+bounces-145762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41909D0A6A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3694EB21201
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173814AD29;
	Mon, 18 Nov 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QRBq5acu"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021093.outbound.protection.outlook.com [52.101.129.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC7146D78;
	Mon, 18 Nov 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731916272; cv=fail; b=Cx5NLjRKGBDM1vUHHO44yDiVz1IwqI+BJvFKxEt7jPVLjPxxw4TGjl1qAYzR4Gq47xIU54QlugENjUuUoFtOi6g1RVc+3y+wnuFC2/zXfGr7asfwa6k7jt/C2hh5ST9vGEHp0vKC7MiyQVijUb5aLYfvgZIkqUpgHlCrVMYDQrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731916272; c=relaxed/simple;
	bh=oaaRR5vCKjuQXGCQEfVwPXDzRhkcvTq05MZ+vnC4Vqc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gb2EYt5dLNEZlM6tiunfrzCSTQCD3H5ulEc6MsyUVJQ671aQm+4c85gkQ1Di2kfP/3vuA160Opii9WydX52sJjGPtvfkzf30R++SmaFYTJ74fcGIj3IsvWwJeFbg0CYj8GNVUT5aIr4Px+uqwogoObUeD5CAuW9bpQX+IVO1wHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=QRBq5acu; arc=fail smtp.client-ip=52.101.129.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASBsPbmncGEVKh+qzFmMsN3kdCDXyC3R3MNgTZjT9eUSFkmUfDUi88EVYFDW/rE0E9DIvDD6s3y9WgLIy8l5sRs7eZ4ee8+Wcful0ZY0rVTfqHjaDMMWaunj4rJhp3YrDa2kEWmi//u6ixUF9aueBRXaYRwamLGdFqVCHU0UBdKwNHvx73mcWBGpfpa4JKGhjeOpcZE1sHMq98aof3+jyVcQc3TZPea9AqZJHSWWjrJL2KIwyRHuGruwnewYg1/4oBkCLd8uuMZ+TYFz/7C9GCGDAb8UqloZ8v/+i2nJPWyvbBOjztec2rYgzw9FCaaySJ3TxgmwGg1AhaU+hlq+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaaRR5vCKjuQXGCQEfVwPXDzRhkcvTq05MZ+vnC4Vqc=;
 b=izrV/GPZfX8O3vChyW2ItMDjTQOoCP54FmC2DqqrPD2HsDXZeV0jOaoKb8wBnDPZlLGDwyQLxtAcvJzwYTgjl1FQKSesLSwkVZCjddoDjUnoIQ+0Yofosu8NEyPG6Iu+ux4LaufGHG8u3ipq5xkpSfKjVWWisw6/IlqMeF2AVF/OKEn+Arj/neVNc+f41dNrDaXnBaUB2A1oa8vlWLcRJ/RKG0n5SajjOt8qWOBbTIQqoDv2PSadEAyUuetLHleYnVtJtco0BJnUaoIB0Rf46s9mwy0Zpeam0OSfmCVuZZEHVkxGc7EBs2OYZ/s1OFqfQ1bPPAZWGTCodxds0em1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaaRR5vCKjuQXGCQEfVwPXDzRhkcvTq05MZ+vnC4Vqc=;
 b=QRBq5acujxSFoui+KuU0JTjY/qL5AzQj5FdWuj4hfr/8AhwqjP8fsDgJXWTSj76MMldhEnDYgOdrPHz8bYuxqDghv7SE+o7UR3VPbr4qN55zJKuUSS3oVLnsXCoTbIezbB7nypnpQJ2r2y3vlpa0stjxVT6T63Dyu+RlFKzDXvObVf4cbeRHyjXujaVu81TNzZmLzH6oaArinVMA2xe7jSBbBB9mWzBHQzfWHbfFf3DR35eCiSiMpZjyFNOvyj4SFYYjfTPiSVZeA5NnEUAz0NIsy0sFGZrU5PhiJQvDz7uc5rJcXB4qtYHP50ESRwvESmyHPjLnMvZ04BSD/UYMSA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by OSQPR06MB7201.apcprd06.prod.outlook.com (2603:1096:604:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Mon, 18 Nov
 2024 07:51:05 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 07:51:05 +0000
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
Thread-Index: AQHbOX9rzBlSwC3uvkmC3zGSsduGfrK8lNCAgAAT/YA=
Date: Mon, 18 Nov 2024 07:51:05 +0000
Message-ID:
 <SEYPR06MB51341859052E393D404F4E519D272@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
 <20241118060207.141048-6-jacky_chou@aspeedtech.com>
 <4b1a9090-4134-4f77-a380-5ead03fd8ba8@app.fastmail.com>
In-Reply-To: <4b1a9090-4134-4f77-a380-5ead03fd8ba8@app.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|OSQPR06MB7201:EE_
x-ms-office365-filtering-correlation-id: a459b8dc-5661-444d-88e7-08dd07a5c192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?big5?B?YWlyOW9mdVZweHI4WlRBOHFDSSt6RThtZVZZRWNsa21BNndSVkhRQkVxMmFkc0FE?=
 =?big5?B?NHJ5UmJaN3dJSFNvOExNd0dpRXdTaXp3WUEzM2dTMXRVWXpzQmhMTVNkUzQxbGxt?=
 =?big5?B?Y2lIYTZTOWVEYmE3KzNkdGh0SHhNcW40SWdGcFlWb3kzYyt6bm90UkQ1NWV5MC9t?=
 =?big5?B?SDJDc1A3a3h4Rkd3bVl5WFBHRWoycFVibDFxWFExZ2EwcXZqUWZnWUp1SkYzUHk1?=
 =?big5?B?TW8vVXpENGFMeUlnUWR6RmxjWnp5Y3lURWQvV2M5amxFZThFSjd3NTR0aWZadmNU?=
 =?big5?B?VUxsTjYrTDgzQlJOS3B6enF4WHVXN3ZGSDJMRUFhekEyZHhnSVdQN0ZaTEU5L1lz?=
 =?big5?B?RlBJbmtsYkJFN092SGt6KzZ3YzR0YWdjWkM1d0NYMUNud2I0a21qbVI5bDFqeGMx?=
 =?big5?B?K2J4dG9xQzZTVWFRbi9WMFlZR0tKTFJPT0cvaHdjTHhqdmNaZjlxVW12TzdKbWhL?=
 =?big5?B?WTNDNFg1WW9OTysvRCtteTVlZmkxcU9HNlU2WklOWlplMTVZeFRUZDd5RS9JOFlN?=
 =?big5?B?anFQdTB4Y212RjFiWDZMc09FYk9YckRqS2l0OWU0SndPc1ROREM5WjcxVHlsSkxl?=
 =?big5?B?SHQ3TitEY284dytDMlhSM1dYMWtuTE1RNjRaczVSL2N6eDlvblNqK0phYSs5cEp0?=
 =?big5?B?VFZCSFZpQXBEN25ReHU0SWxGTmV1bGZwdEEyc2FiOXp2Y3ZrYWF2bXpiTzBXNzdO?=
 =?big5?B?ZG1mNGxLL2syY2tqdW5Ua3BlNjM1RzlESWh5ekIwajNhWlpMUnRHTGcwa2FQMGxk?=
 =?big5?B?aDF1WHJiRlJGYzBrTXNKMERMNWp6MkNoSnVOZVpZUlNnT0NIemRhOWM0RXBIemdF?=
 =?big5?B?ZVlvVGVCem1LbFlZb0JsVlJiaWQ5R2hUMVJSRGlGakk2OERLZ2NQYm1wRzg3M1JQ?=
 =?big5?B?WVp1OGwyT3dCWnRZNWE3T2hDVUozWDJZdnZoR3pPelRUZE9oZGkzNUxVbHBjam5k?=
 =?big5?B?NmY3bCsvUXBraFUwWEwvSGhUS3ljeFFGZVNPMWs3UTNaaDY0dklEcmJ6UXB0LzY1?=
 =?big5?B?S1FtQ2hxYzQ2NW5CdlN0eE90SE9HaVQvVjRSdW5DQmJSYjB6SEwwaVZtYTVLcmk1?=
 =?big5?B?cndMdUd5bklkUStOb0dYSWUvdmh1VFpCN2czWGorRkNSMmFjclhKa3BTbXR0aHRT?=
 =?big5?B?eXM2QmV0Nllac3ZwYTJxYlhMamhWWGEzNlR2S2U0UWsvUU5FbGRUMUppcVlXb1lI?=
 =?big5?B?aDNNOTd5NnJzQ25uelFqZlA0N1phUktyQ2JUVjZ3a1BrQmdYajBmcnByeVdkNnVl?=
 =?big5?B?UVZZa3RtZmpYOUJ0cHA4Vy9YbmpWdXhLYVZkUWs4cnB1bzlIRHk2Ykg3bzJ0T2lR?=
 =?big5?B?QitNMDE5dktxQ0crMy9hejkyQXB3ejRteTd1RUdvQzZKbys5M2ZyS0dySHQ0eXpJ?=
 =?big5?B?ZmFNT1NxZVF4bWN5eHJiR3dNQ29GVXd1R2VSUWJKZll5U2UvbGVVQi9SclZsMzZL?=
 =?big5?B?WHRhNDJob055eHhCd3BGU0VuRTRMVkdkWGE2SlZ4TjhlYU95NjFCWWVwV1ArL0Fj?=
 =?big5?B?cnlrOHNFS1lrN0xvbkVoc3ZkNk8weUJBQTRwZ2xqWlQva1Y2bTVvUDhMUEt6TVpE?=
 =?big5?B?NU11eUcwZ3RJTUp4bGVPZDc4TFNWcHZ4MlFxNFUxeDVNMFNZOU10M1VZbnRNSGRw?=
 =?big5?B?QTBtdDhaUTlCNDVRbmlUSWlUMHZaZ3JtV1UrbXBWQkRHbnBURmQxZ0lJa1NITjM3?=
 =?big5?B?NXV5cWlhQVVzZXYrRk0yaUlCb2ZIaXR2cjFjMmFZQlpYSklDRE52RVFmRjdZUmM2?=
 =?big5?Q?AzVPZZvZQBdkqNJM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?RFlNdzZPQy9Xc2Qyd0tyRVlWSDRBVkpkbWc2MXRkZjFlTE5GSnU2SzR5M0lzQWhy?=
 =?big5?B?Nk16eTZpN1lJcVBaVkxRMm5yQ09VbUlia1FyL09IWkVZbW0vOFlHWFE3UFB2UWZw?=
 =?big5?B?NmRZb0JJbFJUNUM3ckJ0bFRIWU1vNmdGbHYzOWVHNVJ3LzdabGJLZm1MWld5Z0hZ?=
 =?big5?B?Mnh1M0k0eCtyemtHY2FQb3N1czQ0NlVocXZIQ0pxTW8rSDhiaUQydEl3am1rSjdE?=
 =?big5?B?clNUTUxDa0w5N1FyRXpoekNJeklKcHAwQSs4M2ExcldXU29jQ1hTcTZCaEpqanNx?=
 =?big5?B?QWlscWFiYWRVR0RtYVUwY2xrQlFTV1VoZk42UjlDajdtbXFaM2lKU3FqcFp3WmU3?=
 =?big5?B?T3hXblRmNHdCWnlhSDRsNm9XR0pncjZEbXJFZVg5MGdqYmtKaC9nTlFKQnlJNUhG?=
 =?big5?B?SkdNbmg0Z01JMVF5Q25EMXNsZitJbzhLaFhYenhuL004djRlZ1h6NTd2TWpqZDZv?=
 =?big5?B?UFBBV3FwYmJKNmtub3d5b3dId0VuZU5HbCtvOWxBUTF1QjlUTTNja2NxT0JOaFc5?=
 =?big5?B?SU9rSnpCTkNyUVh1MkNITkwrRkFPd3BhZnpwU3NJdXVnU1lJTllKMkVoTDZGN0hN?=
 =?big5?B?NDg1b3VOMndBSHpHdkJkWlNPampsM005UEdibHg5RWE1TmpKMDRCL2VwWDl2SjlQ?=
 =?big5?B?LzJFamtzbC9WUkRYYS9hTFk4RytwVVdQYUk0OGZZMHpISVFXUmlQUTNuVityWFpX?=
 =?big5?B?Vi9icmxqbFFEQWtYb3NUWnhxUTU3NDQ2UlRkUEQyM005cmt1M1VQK2ljZG1ZUDJ6?=
 =?big5?B?dkp3eGJSdkw0MWZKeG1BK3BoeXZ5NFQydVYvdkVrc3Y5cHp3dDFocm9HZUxSTVJD?=
 =?big5?B?RGdiS0NoeGR0V1FodWl3cjFSNVFXbkxhQ2VaQjhQUGlkOGhsdGlPanlsMmdVc1B2?=
 =?big5?B?Nk5nMlNxYkZGMERUSkRDUVh5Ni9xdEpXUHJYNXZ4anpEcjZrcmN0NkZSQ1J6Zm1Z?=
 =?big5?B?MUNiTzlkSXNtV0FCbHRlT2FoZG9NV09sa1JhaHBpQVFvQlhsaVpsNFVCaDFzdjRn?=
 =?big5?B?UzNrT0Y0M3hKRjRIczNiWFNKaGxmWXdkOXlLOEJNUzVEVXU3ejYxMFZBVjd4djFW?=
 =?big5?B?cFU1WWg4VndrTlhUMmt6U01JZTVJbzVyaHIya0w3VFQrRXhFeDJYRGpEWTZPYjN1?=
 =?big5?B?RVh1RytZS29hUlU3QzlhOFdsYmNlUzVhdFJFaHM3d250cHdIdjlNaHUvaVVzNks1?=
 =?big5?B?eXhRMEpUQkw2RFdybW42ZGtUbWFMS1Zvcm9KL0dubFFrR0FiU0RYdHRqRklKbG83?=
 =?big5?B?cUtSK251RlVqaG5VVkVjYUM5bXdaN24rVVgyaDdLWWNQb2Vsd1FianRsZURqTXU3?=
 =?big5?B?eU9TR3RMb0ZxTllkQ0ZyUUswSzdkRVc1c0FRL0tuTDgycjlYMlNscGUxMFVsVCtF?=
 =?big5?B?Y3lsWmQ1SmtwWk93OHgrdTZWditna2NNWGxBVzExQUJlcEp1OVlKQWEwK3c4ak1o?=
 =?big5?B?ZGVyUDllUmFlNkJlVDRRZm1FWVpqTjJpMkJjaVZkTWFwbUNpZ0xVNEVyMUNnRG1y?=
 =?big5?B?eGkwaEJ1TTArUGx3ci9ab1lVZGh1ZHN3allRcGN0WWtia2wwUE9TeTFjTkpaRzhY?=
 =?big5?B?bzBBcGU4K3B5T09YSFVERjl1LytUUTcxeXVzTHd3TkRqZ0RINE1oYmF5MmFrZllI?=
 =?big5?B?ZEpHTUgrSnZtcmdwakdWb1ZINkJqS3BWZGJyNDJmdXB6Q2t0MG9UbXpPM3k5TnU5?=
 =?big5?B?bDZSUGo1bExkdjZQb3ZqTWFSb0I2MVYwdmV4ZGtUTXoxWWQ3YkJkVXY4bWxISTNh?=
 =?big5?B?UDBxTDBiL29lTFRoRFJGSEREOHRiNGhpV1RvUGxGeGNqNStTK0Y5cE4xQkVQWURJ?=
 =?big5?B?cHBqZU13M1gvTmR1Ty93SDBQUytYNWpoL1ZicXM2SG5oKzRxb1ZLcHJjMHdYRDVB?=
 =?big5?B?ek5SL05LNEFmaTl3MnozNjNwT3dlT05ZcWQwMmhwbVl5WlJaQ24wRlFSWEVDM3BZ?=
 =?big5?B?Sm9wTTFyMm0xcm1FMVE5d2hlS3VUamFTMFdFMDc0dTBWbXpNUDBFOXEramF4dEVi?=
 =?big5?Q?129uycQSBdA/tdle?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a459b8dc-5661-444d-88e7-08dd07a5c192
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 07:51:05.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1y8uCf/bLz0XwP1asIWQqHjrEthcc/LkFQa2ccMxDlIlLxP0akUvYYjutdULHOQhuZSqqbGq2j1uG64scD/JDL1YWc8gOBMK800QXXsxti4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7201

SGkgQXJuZCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gQEAgLTM1MSw2ICsz
NTIsMTAgQEAgc3RhdGljIHZvaWQgZnRnbWFjMTAwX3N0YXJ0X2h3KHN0cnVjdCBmdGdtYWMxMDAN
Cj4gKnByaXYpDQo+ID4gIAlpZiAocHJpdi0+bmV0ZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfSFdf
VkxBTl9DVEFHX1JYKQ0KPiA+ICAJCW1hY2NyIHw9IEZUR01BQzEwMF9NQUNDUl9STV9WTEFOOw0K
PiA+DQo+ID4gKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUocHJpdi0+ZGV2LT5vZl9ub2Rl
LA0KPiA+ICsiYXNwZWVkLGFzdDI3MDAtbWFjIikNCj4gPiAmJg0KPiA+ICsJICAgIHBoeWRldiAm
JiBwaHlkZXYtPmludGVyZmFjZSA9PSBQSFlfSU5URVJGQUNFX01PREVfUk1JSSkNCj4gPiArCQlt
YWNjciB8PSBGVEdNQUMxMDBfTUFDQ1JfUk1JSV9FTkFCTEU7DQo+ID4gKw0KPiA+ICAJLyogSGl0
IHRoZSBIVyAqLw0KPiANCj4gSXMgdGhlcmUgYSB3YXkgdG8gcHJvYmUgdGhlIHByZXNlbmNlIG9m
IDY0LWJpdCBhZGRyZXNzaW5nIGZyb20gaGFyZHdhcmUNCj4gcmVnaXN0ZXJzPyBUaGF0IHdvdWxk
IGJlIG5pY2VyIHRoYW4gdHJpZ2dlcmluZyBpdCBmcm9tIHRoZSBjb21wYXRpYmxlIHN0cmluZywN
Cj4gZ2l2ZW4gdGhhdCBhbnkgZnV0dXJlIFNvQyBpcyBsaWtlbHkgYWxzbyA2NC1iaXQuDQoNClRo
ZXJlIGlzIG5vIHJlZ2lzdGVyIGluZGljYXRlZCBhYm91dCA2NC1iaXQgYWRkcmVzcyBzdXBwb3J0
IGluIHRoZSBmdGdtYWMxMDAgDQpvZiBBc3BlZWQgN3RoIGdlbmVyYXRpb24uIFRoZXJlZm9yZSwg
d2UgdXNlIHRoZSBjb21wYXRpYmxlIHRvIGNvbmZpZ3VyZSBwaW4gc3RyYXAgDQphbmQgRE1BIG1h
c2suDQoNClRoYW5rcywNCkphY2t5DQoNCg==

