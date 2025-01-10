Return-Path: <netdev+bounces-157142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE42A08FF5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93DA188CC43
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449F2063C7;
	Fri, 10 Jan 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Btcznoxt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AC19ABDE
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510763; cv=fail; b=YMM2awzHz6IPfSmJWQXSlHvmEWfMCVehPY3JBNipO5w+6GiDkMkJREHcT9BSfKH5oYXFhESgIdIvacIQoGlEsiLgHTTh29e9WiRHScYlZr/LYS6H1FWKospHAH2v/WafeZa4LXJYMw2m11a4+GV76jgPtE/HW1jnfbzmZZbMrJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510763; c=relaxed/simple;
	bh=AvUbGLf53++o6nwjGkG7ece6Pa5hPlcTSFYJxnmjZVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDPJ0RG5suZLRCgaWbnTgJgsOFukrHo2Hxwg1mSjEduwWVo8hJw7Nl8x1VrRHTKO3cccV6hSN7VmAQdjq2ejDb71znr1zWiZwc9YaOUCYhvyatIJYal5mxkRmL6TJ//zI9MqpHXGUrliIRzpzXrJURaSDOw9NX2xEv2gSUNgIq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Btcznoxt; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dilNXjBZGM/By6Cbt7S/Eum10Mj0KgbaYP+6nXw1uUeD6p1+MCKKXBwrKppOLFfxqW12vLRCETKBa/6PSQaxb/PxVvrIK0MQSg0uW/CRNGaClJ7d4EWbcUuHRQWTCVj9peXLxs3wcO/LZQt6TfDowmCnNzqNfYom2C9LqFeZ+IlA5zPtIv/jnPL6HOAlEhHu+Zw00bpqVj+eySrzFr91+mAv89bPdkrG0CR/SsgojsvfXgQrgLB5Mlptwpv2agVCUK9SdMy0vJAekqJTgTWtzTZ5o9T+PEyp8s+auI++GquBGe7+N/brBdQNjvrsp9HO24Jv3Pf2Qh2toLLquWpO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvUbGLf53++o6nwjGkG7ece6Pa5hPlcTSFYJxnmjZVc=;
 b=sLpjrPZl1xu9F3AT7hsrhSPTE+xepx9APCIRh8Q1cFnE84vj26/FDWiEFpx0rAZiZwF5KjcQRL2EON5Jt8uM9IvLDVZYtzgzyM6qavoZyNbyAbbDjFCMDJZPBvSROgIUzvE/5C4kQb2LSQ62xjsL2NkqqVjJmjryGBYzAZAt9xL7n6DkyXkc6KLaaMU5r68XrPyPZtGsQT0l3BMwcXYgYBhpez46X8EeCcT+ChPIYPu4Oh81DXZ0wFd9fgY5obAouQ42NzOu6Hv426zAzoChZCy4bJ2ev2v+NmpwfM+m1SUSIjAAZr/g65mWN/uXxkp/fKB9rPP1e9MyYI0KxWBhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvUbGLf53++o6nwjGkG7ece6Pa5hPlcTSFYJxnmjZVc=;
 b=BtcznoxtwI+MQrcC+TPb5wdCTbNiTcddbKwRnAOkw3HfQ6QGUKr5ZvQPpoy6MsPlghID3G0nOV8PhE+5VPCwO0iUJyGB6okjrvFCRK8//ZeDSL458ZVTG7SQzMnvloOiRqNSfPVCJifBkgPBAoveqS31tg9r6OW8GnRsxe+9WLe+qwyR7sngu91CDGX8r+MaHEDY/3NoKHMxmzpIOKMqDwy4EwovpLvyEXPRqG7d1iHfpEPp4/OsJZ/r8sazStMlXUPdDzL9OqUpHBNmr6gvcoexmQGReIi9RE6XRxyN4KJ05sQ6r2iZQGTROwuqmB+GlzV/WY2yXoRZGE+bIIliiQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB8913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 12:05:58 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 12:05:58 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "c-vankar@ti.com"
	<c-vankar@ti.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"jpanis@baylibre.com" <jpanis@baylibre.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW
 only if !DSA
Thread-Topic: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware
 CPSW only if !DSA
Thread-Index: AQHbY1LYc2/Ywrl+eE+iq6LL4sIQEbMP4rwAgAAB0ICAAAPaAIAAAPYA
Date: Fri, 10 Jan 2025 12:05:57 +0000
Message-ID: <92f332a16eb5bb011e47290ba60ebc4a8dbb3dc3.camel@siemens.com>
References: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
	 <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
	 <5864db3fdb5fea960b76a87d11527becf355650b.camel@siemens.com>
	 <tjc6uc74j3add7bzh7of32i5topeenzv64y3hudne2lioqwqzb@qlhi4gdfn6ww>
In-Reply-To: <tjc6uc74j3add7bzh7of32i5topeenzv64y3hudne2lioqwqzb@qlhi4gdfn6ww>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB8913:EE_
x-ms-office365-filtering-correlation-id: 6066dc7a-d821-4185-ae3d-08dd316f2483
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEZ4TjcrY3pIeGF3c3k4MUVsbXBGZkN3REVrL3dMZnkxQVVuVFZiUHJIRHBa?=
 =?utf-8?B?eXBzTU1CWGJ6OTFubjY5UU85NjJwK0FyRUN1Q2s3WDlQSjBHNmZrY1dOUUZR?=
 =?utf-8?B?aENGbkdtSXA0cXROSXhrVWozZWZvZnV3YkVQRVFqZHNISlJPUDRYSzRocjA0?=
 =?utf-8?B?ZU94eFY2UFk5SVhvUFRMNDA0WHZ6dkh5cGNLcFFWTzgycHNWdis2eUdqdlZW?=
 =?utf-8?B?RUQ2VFpZdkh1bDdjMUdNdU5rME11RkxoZU1YVkxCbld4SG9xeVZxTWlXWHpy?=
 =?utf-8?B?bGhiNXY3bmEybGg0K1YrS1JVdk1Ha2RsVG1HWDYrT0RqZjJod0RaZUJVem90?=
 =?utf-8?B?d25mMXV6WFY0cFpNVWo0U21xQWs1K1RORDgrVGNUVllnaThIeWRNVDlIdEkz?=
 =?utf-8?B?ZFdxNE1RYXVseCt0WmdXbEhWbmJrclE5cUlaeWIxR3N1VmRzZUNHWjlwY0FN?=
 =?utf-8?B?Nm5UdjgrbUdUNGthZ2tqb2VPdHFpcElHU2xGTUJITXROaFVkcjdPZUFTSC9W?=
 =?utf-8?B?NkIvR2dHVGkyWjBFUkNJRE9hekd4VEV1MlYvM3YweTFsSStQL0s4TmpWK3Y4?=
 =?utf-8?B?TEs3Wk5PSWhjOENxSS9UaWFFM2MwR2JrVmRDSXJpcmtxVjhOK1FuSHNTS0d6?=
 =?utf-8?B?a0RiNjI4N0JGSUliRjZpUytZRE80OUozZk1lTjBsRFpvL29odXVtbVNPRTZi?=
 =?utf-8?B?d0thSjY4WGExYmJVbDQ2aUUySnJjdGwwNGM1eW9VcFJQTFdBOEFDT1NOM1hR?=
 =?utf-8?B?MkRxVThVV0xxZlpzU05GRUNmcTdxeStLWkNXQXF0bDFFMzlnNlRTNTBxdEdi?=
 =?utf-8?B?ZC9PdWdTdU9KNklLa3JTUnQwRlhNTnRnL1hkcm5ET2RMMkZBejhhUDJVcnBp?=
 =?utf-8?B?aWx5clpEQlo5a3diVndxQ2RGQk95akE5UnBreHlPS0JaK2FZTmlwanhpaSty?=
 =?utf-8?B?dUZrUVI0b3ppZE5QSWxtVytqSGVrRkQvL1g0b1hEZ1lhQzBxUlJ2Y3dEVnVr?=
 =?utf-8?B?TE1RbWJFY3o3UVdUMkZ1ZzRCQnhJQjVock1MT1h6N2FPL0xHcEV4UDlrcmZ0?=
 =?utf-8?B?T3M1MFlLcE5yQmRGaDBHUVlEQVYzQ1FNRTluSUkwaVlXUStEcUhPaXNpcmtW?=
 =?utf-8?B?OU4xclpJNFdiaWVZMW1KczZqRWt4bUJ2THZTRW41RXB4V0JUdmVWcnRuRmJF?=
 =?utf-8?B?ZFlvUytNTVdGdmlIalJ1c2sxbHRwc2o4TkZLdGgxckNaU1k5TzAydCthbWhU?=
 =?utf-8?B?QXFob0UydDBkazZ1WDA4Q3NmMmE2RW1IL2dHL296OFM2RVBIbGVaVDd0MnI0?=
 =?utf-8?B?UnM3eEl5MXFrY0E5REp2bmJoSVk0SEJKV3NhOUNmY051dVZLaDJ1YVhGdDFL?=
 =?utf-8?B?ZjVIa3U2cGloOGZwZXNIRVVSRGlCVnBadEkxYStPbTZrV2FGVjF5MDNJZWpI?=
 =?utf-8?B?aEl4aGxsdnpFc28zanhIMU9MNElUTzBQTDhPTS9mMnRGVldISUZ3NXB5QVZ5?=
 =?utf-8?B?aEgrcGI5Y3F3aTZpVThVKzI4SEhnSlB5aFdXTHB0eVNsRGxsTXg1YVNOY3Fz?=
 =?utf-8?B?bnRvQlRuVmgydWNLNGhWOWlzaWtud3haTEhyMmxFQSt3QmsrREN2ZTNud2kr?=
 =?utf-8?B?cFE0d214bFlxcndmb2xNWk9WNEtQR3pmZjIrNVRjRmVGVUNmaXUxUkVtV1Bl?=
 =?utf-8?B?dDdDNExrSVhuaDljVUZieU9qR3grUXFXTlBXMFFSUmhhdGJPYnNJWFJUUDFk?=
 =?utf-8?B?YlkxVjdESS96TnExWk91THVQUlVmbExHZWF5S0pvUGNDdlBXTGd2TE10S0tu?=
 =?utf-8?B?eUFZemIzOWFRVXdOM2ZuVm1NcWVOK3pYOG9pWFZCRHhyQnp6djNBOVRRVEYy?=
 =?utf-8?B?NHNUdlVqWXZia3hPZktvL0lrY1JQcFJHaGtrVEV4Smx4Q0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzhBQWFhN3UzYkRFMUJROEtJZ1NQZmVuaW81Y0t4RWdlU1YxTUZoaklnbXlT?=
 =?utf-8?B?Nm5FSEJ2Sk4rUnhsdFBlTjVuL1Q5UFY5c0VuMTc1b2c0UmUvS3RsK3k2S052?=
 =?utf-8?B?aUs3SFJtaTdIYXY5TkdGRlpXZzBrSzhKbG5sV1ZiMjBYR3hDL0c1MjloU080?=
 =?utf-8?B?WnhDRWZtYnRSMFF5bURLbXRPeHpzbkV2WEN0VU9WUVZNcjdnTzdOUWhDb3BV?=
 =?utf-8?B?b1B0OEVrNUpkbnV6ZTdjK3M1T0U1SmpST1VTMFpiajkzU0dwY0xLd0hSVThE?=
 =?utf-8?B?bDhVN09lNnp1U1didUwyNzY0NTkwMGtLRUxveVllUEhETGFNby9wSHcxQUFX?=
 =?utf-8?B?Wms1MDdGVFUxelhXOG41Z2xaVUVXb28ydXRmUkZnRWs1elB0aVduelhuTXhJ?=
 =?utf-8?B?WllZNldBdFo3clBDU0RreDZWQmRRaURydW9wcnVnT0VvYkZNcldjdURZSHRi?=
 =?utf-8?B?UFhrdXlTd3I0MUV0dlFvSEpkbUtuTTg2TkpXdlZyUDh3Vyt3akI5dGFBQmtt?=
 =?utf-8?B?a1c4WkR0SVNZeHNicG8yM3h2K2Z5aGpFRHZlZGJ3MVNwQ0FYeVJzNlptU2xK?=
 =?utf-8?B?Z1RmOS9zcGFYQmJ1MTlGOFllSVNyTmcyWC8wcXBXQWllZEI3Y3FuMWJNTEhy?=
 =?utf-8?B?RnpOVHBJcmVTdzd3N0JJZSthQzdURG9jVmozbURYR1gzVjJUZ2ZqK0E2NFQy?=
 =?utf-8?B?bVlwTkcvSlNnYXdYdkY0WXB5Rm5FY2dvcyt4b2c5ZTg3eGJzU2M5T0U2Y3hC?=
 =?utf-8?B?eFZ2bkRocmV4QVNhaStDRncvQyt5RHA3WkM1YXIzay9VRTZRWFFGREpKUEZJ?=
 =?utf-8?B?cVFRM2NOM1lCYmxxRVM3aUk2L1k3aFlKam83bDRWSnJiVkh6VUhpZDM4TC9V?=
 =?utf-8?B?V2JGaGVqWUx1bHF6RWlJWDErNkowMjV0cW9lVkFmbTVVc0JBeVhUTE90TVl2?=
 =?utf-8?B?UHd4eXRmL3ExOUJtZTdjV0lvV2pvVTM3SjBDM2FNTGF6cTBCTnI1NkkrZEtB?=
 =?utf-8?B?RitzRzZnNzJrWWRvamVsdlIvWVp4dDFPMDJucHNURmN5SHFzSVVDQmVGU1hY?=
 =?utf-8?B?SFo2Vk9NL05SbTJ6NzhPeWRGV2dJeXpJcUEwQ1lvY2xmZFdxZ2ZVSW5KZnBv?=
 =?utf-8?B?bllHc0YyNlBZTDZYelZMWmcza0pMZVhJbzA2TWNoTnZla29mWTM3NW42TDFp?=
 =?utf-8?B?YUZ2eGpJc0N4MS9pSExtMms4Ukd4TytCVFBxNjRSdFNGR0QrMFlCMk93M2Vj?=
 =?utf-8?B?cUZoMnpFWlovL3hLaVZ6cDNPUSs0MlU2Y3dxQTJHRitScTBFSjM4b2dHZkI4?=
 =?utf-8?B?bkZqUVZBQk9kVERTWkpSV2xoRDhWM0NzRGRhZW84cVpBMEtOMWgweXhJWW45?=
 =?utf-8?B?UzRxSkxRdjVTU29oRUR5cERXemtpMGZxRHBTVUhvRTVQczJENll3Z21PYWxR?=
 =?utf-8?B?NEhOTmFtOUNhV0pTSExLRXQ3VHNhazNVSllCSHQrd3BxRFM5RW5nQk01QWNM?=
 =?utf-8?B?bXRyMm52RzFEcXNFSVhHZFZZM25zWm42NnpCMnI5SERUY2NOdkhnYnNKd0ps?=
 =?utf-8?B?eGVXd1NMNVBYc0duVXl6VjBlVlI4RERzeDA1TU8wVC82SjBEVWY3TGo2Z2lF?=
 =?utf-8?B?b1hMbW1IWGNkK0VnTFhneEVITXdmYm9SRy9JV2VrT3lmV3AvYVZSWWlBRVVk?=
 =?utf-8?B?bUhXNlR6TjFhSU5RMXY3SUlNNmJnbXlOam9OMXU5VUY3TEltdkxCUGR4RXRJ?=
 =?utf-8?B?cm5KNGJJSzdRMUQxN2Y2MEg5bjZIbEx1QUlPSzVwUUQ5QVRKU0pabkVrRHp5?=
 =?utf-8?B?dDVpdnl5eHU2UFdRU0k0dmFZMGFsQ0gvUmQxV285YjhjYkt0dERMZDR2WlNk?=
 =?utf-8?B?YStMS3YvNTFYMkw5Szk4Zm53MC8wNDZOM3lmUmFMa3d2K0oxbWJrQ2M0ZXla?=
 =?utf-8?B?K2hTclpIallMUGExMGNESnYvN2g0dHYvY1pXR0NEaEwwRDJKMjNRNHBySVBR?=
 =?utf-8?B?WitVY2FXSGZrSXYxakMzeGFuczJVOE1VeHNWVE9lWUFLa2JRRVVVaUVoRnNG?=
 =?utf-8?B?Vi9PRHMzOURRTTZuRDNqa0NDUktnVFBPY1kwalZtL1R0Ym1qOFBxaXAzRm11?=
 =?utf-8?B?LzRGclR2bVRHODBqZk9MUDVpdDRMZHhnM1hOVGNRcGM1MEcvdHhQUWxWamVy?=
 =?utf-8?Q?vLnEE53AQLa+HdeIf1OIvCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41952E4532378E4F9701B62964EB1AE8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6066dc7a-d821-4185-ae3d-08dd316f2483
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 12:05:57.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0FJDNsjjVNXK8kYOvl2ZVOlIN0qkdrsIzfkuZ58eCo2WjIv1woHUqoy0HDIypm3huQ/EJGViXxXkdzx8qzOCsrFEgnLDu3DlLvswe8s/S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8913

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDE3OjMyICswNTMwLCBzLXZhZGFwYWxsaUB0aS5jb20gd3Jv
dGU6DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNw
c3ctbnVzcy5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiA+
ID4gPiBpbmRleCA1NDY1YmY4NzI3MzQuLjU4Yzg0MGZiN2U3ZSAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ID4gPiA+IEBAIC0z
Miw2ICszMiw3IEBADQo+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9kbWEvdGktY3BwaTUuaD4N
Cj4gPiA+ID4gwqAgI2luY2x1ZGUgPGxpbnV4L2RtYS9rMy11ZG1hLWdsdWUuaD4NCj4gPiA+ID4g
wqAgI2luY2x1ZGUgPG5ldC9wYWdlX3Bvb2wvaGVscGVycy5oPg0KPiA+ID4gPiArI2luY2x1ZGUg
PG5ldC9kc2EuaD4NCj4gPiA+ID4gwqAgI2luY2x1ZGUgPG5ldC9zd2l0Y2hkZXYuaD4NCj4gPiA+
ID4gwqAgDQo+ID4gPiA+IMKgICNpbmNsdWRlICJjcHN3X2FsZS5oIg0KPiA+ID4gPiBAQCAtNzI0
LDEzICs3MjUsMjIgQEAgc3RhdGljIGludCBhbTY1X2Nwc3dfbnVzc19jb21tb25fb3BlbihzdHJ1
Y3QgYW02NV9jcHN3X2NvbW1vbiAqY29tbW9uKQ0KPiA+ID4gPiDCoMKgCXUzMiB2YWwsIHBvcnRf
bWFzazsNCj4gPiA+ID4gwqDCoAlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gPiA+ID4gwqAgDQo+ID4g
PiA+ICsJLyogQ29udHJvbCByZWdpc3RlciAqLw0KPiA+ID4gPiArCXZhbCA9IEFNNjVfQ1BTV19D
VExfUDBfRU5BQkxFIHwgQU02NV9DUFNXX0NUTF9QMF9UWF9DUkNfUkVNT1ZFIHwNCj4gPiA+ID4g
KwnCoMKgwqDCoMKgIEFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRSB8IEFNNjVfQ1BTV19DVExfUDBf
UlhfUEFEOw0KPiA+ID4gPiArCS8qIFZMQU4gYXdhcmUgQ1BTVyBtb2RlIGlzIGluY29tcGF0aWJs
ZSB3aXRoIHNvbWUgRFNBIHRhZ2dpbmcgc2NoZW1lcy4NCj4gPiA+ID4gKwkgKiBUaGVyZWZvcmUg
ZGlzYWJsZSBWTEFOX0FXQVJFIG1vZGUgaWYgYW55IG9mIHRoZSBwb3J0cyBpcyBhIERTQSBQb3J0
Lg0KPiA+ID4gPiArCSAqLw0KPiA+ID4gPiArCWZvciAocG9ydF9pZHggPSAwOyBwb3J0X2lkeCA8
IGNvbW1vbi0+cG9ydF9udW07IHBvcnRfaWR4KyspDQo+ID4gPiA+ICsJCWlmIChuZXRkZXZfdXNl
c19kc2EoY29tbW9uLT5wb3J0c1twb3J0X2lkeF0ubmRldikpIHsNCj4gPiA+ID4gKwkJCXZhbCAm
PSB+QU02NV9DUFNXX0NUTF9WTEFOX0FXQVJFOw0KPiA+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiA+
ICsJCX0NCj4gPiA+ID4gKwl3cml0ZWwodmFsLCBjb21tb24tPmNwc3dfYmFzZSArIEFNNjVfQ1BT
V19SRUdfQ1RMKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiDCoMKgCWlmIChjb21tb24tPnVzYWdlX2Nv
dW50KQ0KPiA+ID4gPiDCoMKgCQlyZXR1cm4gMDsNCj4gPiA+IA0KPiA+ID4gVGhlIGNoYW5nZXMg
YWJvdmUgc2hvdWxkIGJlIHByZXNlbnQgSEVSRSwgaS5lLiBiZWxvdyB0aGUNCj4gPiA+ICJjb21t
b24tPnVzYWdlX2NvdW50IiBjaGVjaywgYXMgd2FzIHRoZSBjYXNlIGVhcmxpZXIuDQo+ID4gDQo+
ID4gSXQgaGFzIGJlZW4gbW92ZWQgZGVsaWJlcmF0ZWx5LCBjb25zaWRlciBmaXJzdCBwb3J0IGlz
IGJlaW5nIGJyb3VnaHQgdXANCj4gPiBhbmQgb25seSB0aGVuIHRoZSBzZWNvbmQgcG9ydCBpcyBi
ZWluZyBicm91Z2h0IHVwIChhcyBwYXJ0IG9mDQo+ID4gZHNhX2NvbmR1aXRfc2V0dXAoKSwgd2hp
Y2ggc2V0cyBkZXYtPmRzYV9wdHIgcmlnaHQgYmVmb3JlIG9wZW5pbmcgdGhlDQo+ID4gcG9ydCku
IEFzIHRoaXMgaXNuJ3QgUk1XIG9wZXJhdGlvbiBhbmQgYWN0dWFsbHkgaGFwcGVucyB1bmRlciBS
VE5MIGxvY2ssDQo+ID4gbW92aW5nIGluIGZyb250IG9mICJpZiIgbG9va3Mgc2FmZSB0byBtZS4u
LiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUgbm93LiBE
b2VzIHRoZSBmb2xsb3dpbmcgd29yaz8NCj4gDQo+IDEuIGFtNjVfY3Bzd19udXNzX2NvbW1vbl9v
cGVuKCkgY2FuIGJlIGxlZnQgYXMtaXMgaS5lLiBubyBjaGFuZ2VzIHRvIGJlDQo+IG1hZGUuDQo+
IDIuIEludGVyZmFjZXMgYmVpbmcgYnJvdWdodCB1cCB3aWxsIGludm9rZSBhbTY1X2Nwc3dfbnVz
c19uZG9fc2xhdmVfb3BlbigpDQo+IMKgwqAgd2hpY2ggdGhlbiBpbnZva2VzIGFtNjVfY3Bzd19u
dXNzX2NvbW1vbl9vcGVuKCkuDQo+IDMuIFdpdGhpbiBhbTY1X2Nwc3dfbnVzc19uZG9fc2xhdmVf
b3BlbigpLCBpbW1lZGlhdGVseSBhZnRlciB0aGUgY2FsbCB0bw0KPiDCoMKgIGFtNjVfY3Bzd19u
dXNzX2NvbW1vbl9vcGVuKCkgcmV0dXJucywgY2xlYXIgQU02NV9DUFNXX0NUTF9WTEFOX0FXQVJF
DQo+IMKgwqAgYml0IHdpdGhpbiBBTTY1X0NQU1dfUkVHX0NUTCByZWdpc3RlciBpZiB0aGUgaW50
ZXJmYWNlIGlzIERTQS4NCg0KVGhpcyB3b3VsZCBmYWlsIGlmIHRoZSBwb3J0IGludm9sdmVkIGlu
dG8gRFNBIHN0b3J5IHdvdWxkIGJlIG9wZW5lZCBmaXJzdA0KYW5kIHRoZSBvbmUgbm90IGludm9s
dmVkIGludG8gRFNBIGFmdGVyd2FyZHMsIHdvdWxkbid0IGl0Pw0KDQo+IFRoZSBwYXRjaCB0aGVu
IGVmZmVjdGl2ZWx5IGlzIHRoZSBEU0EuaCBpbmNsdWRlIHBsdXMgdGhlIGZvbGxvd2luZyBkaWZm
Og0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+IGluZGV4IDU0NjViZjg3MjczNC4uNzgx
OWE1Njc0ZjljIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNw
c3ctbnVzcy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNz
LmMNCj4gQEAgLTEwMTQsNiArMTAxNCwxNSBAQCBzdGF0aWMgaW50IGFtNjVfY3Bzd19udXNzX25k
b19zbGF2ZV9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPiANCj4gwqDCoMKgwqDCoMKg
wqAgY29tbW9uLT51c2FnZV9jb3VudCsrOw0KPiANCj4gK8KgwqDCoMKgwqDCoCAvKiBWTEFOIGF3
YXJlIENQU1cgbW9kZSBpcyBpbmNvbXBhdGlibGUgd2l0aCBzb21lIERTQSB0YWdnaW5nIHNjaGVt
ZXMuDQo+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZXJlZm9yZSBkaXNhYmxlIFZMQU5fQVdBUkUgbW9k
ZSBpZiBhbnkgb2YgdGhlIHBvcnRzIGlzIGEgRFNBIFBvcnQuDQo+ICvCoMKgwqDCoMKgwqDCoCAq
Lw0KPiArwqDCoMKgwqDCoMKgIGlmIChuZXRkZXZfdXNlc19kc2EocG9ydC0+bmRldikgew0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSByZWFkbChjb21tb24tPmNwc3dfYmFz
ZSArIEFNNjVfQ1BTV19SRUdfQ1RMKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVnICY9IH5BTTY1X0NQU1dfQ1RMX1ZMQU5fQVdBUkU7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHdyaXRlbChyZWcsIGNvbW1vbi0+Y3Bzd19iYXNlICsgQU02NV9DUFNXX1JFR19D
VEwpOw0KPiArwqDCoMKgwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoMKgwqDCoCBhbTY1X2Nwc3df
cG9ydF9zZXRfc2xfbWFjKHBvcnQsIG5kZXYtPmRldl9hZGRyKTsNCj4gwqDCoMKgwqDCoMKgwqAg
YW02NV9jcHN3X3BvcnRfZW5hYmxlX2RzY3BfbWFwKHBvcnQpOw0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+ID4gDQo+ID4gPiA+IC0JLyogQ29udHJvbCBy
ZWdpc3RlciAqLw0KPiA+ID4gPiAtCXdyaXRlbChBTTY1X0NQU1dfQ1RMX1AwX0VOQUJMRSB8IEFN
NjVfQ1BTV19DVExfUDBfVFhfQ1JDX1JFTU9WRSB8DQo+ID4gPiA+IC0JwqDCoMKgwqDCoMKgIEFN
NjVfQ1BTV19DVExfVkxBTl9BV0FSRSB8IEFNNjVfQ1BTV19DVExfUDBfUlhfUEFELA0KPiA+ID4g
PiAtCcKgwqDCoMKgwqDCoCBjb21tb24tPmNwc3dfYmFzZSArIEFNNjVfQ1BTV19SRUdfQ1RMKTsN
Cj4gPiA+ID4gwqDCoAkvKiBNYXggbGVuZ3RoIHJlZ2lzdGVyICovDQo+ID4gPiA+IMKgwqAJd3Jp
dGVsKEFNNjVfQ1BTV19NQVhfUEFDS0VUX1NJWkUsDQo+ID4gPiA+IMKgwqAJwqDCoMKgwqDCoMKg
IGhvc3RfcC0+cG9ydF9iYXNlICsgQU02NV9DUFNXX1BPUlRfUkVHX1JYX01BWExFTik7DQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

