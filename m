Return-Path: <netdev+bounces-215749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B5B301C0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346586001B2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59410343206;
	Thu, 21 Aug 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UVghpF9W"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D74C6E;
	Thu, 21 Aug 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799902; cv=fail; b=QrH52jpO1CaM0Sjwrww27Xjige6LVw7P0IZ4k1KnvzRxOChmMHu8juf3OTwcSTHEeCwME04grN1IaqywCMoz/6gSDKiglv3YF+o0E9EeANjmiInYzz/POna9fjcYw0rFNsRrzXYC8FjCTSrpaTpIWl4pcVbsbdnEVgzPL669CzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799902; c=relaxed/simple;
	bh=iREuDxAoVdDaSsBW08nYGCQWCVARG3OTReBIeCiSJ4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uGh73F3iQx0jM8aHE/WokxHmZDZNDKyNi+XA4pHCwJpDVFo9Fm000e6CtGbDt87uwTXagzaQhNrhrJ1UphfhJ26thgWmowg2cvzQgCwhk4UmmjN1u9jCesgFJL2vu+3sKcuUa4wpXlIxKugbAsTAGVK0OStXiEmrPe4rCJnGucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UVghpF9W; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imYJcpjdq2mg66nvdLnAfb6pfERqTr5jST0/SEojYPd5R9KqORavngm5y9IsfCZEsVYIp7vbS544kZuFCGI8JksPkb4aeO77WLF6dnZoonXBz2OwhdRs+HQ2D79MBk7NDDBqMql/xWRpQTkVoQ0mr6NLSK+0upjYnPPHvfD9OQIIIt/UW61fi7RFUcDAiQXcAebIet8ziNApcb8PvbNZVi7VBHo+nCExrU2jJ7c/1hWJbDhCTc9yJpCjizYxpRLKabrq3oSMn5wq/7xJapynWsCYeZphXCgyvhmGJhbUuGvXs+mqTXqwglkYbHIsxVy8cBYSV5DnoG3bPNsxaeklSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iREuDxAoVdDaSsBW08nYGCQWCVARG3OTReBIeCiSJ4E=;
 b=dmAmiW2P+Aa8j8trVWRxzd462ZTBWFr7xBVxse1exIWAb7317C68Uihj56bBp5IEZ2DAHAfdAyzSxli++l3jHgCU+E51GcOlgEumG0f8KfBCiIxn5pNS0+wL0k8VwUSaX8zXwft8tdS+FHocYumrUi5t0jmXig6CYNQ2EHaI3PqotBhN7JZidRHFkUTgCM8O+RhjG3dDfoT2lo6Wbrg44RoJvv7ht3sDDXIxLZAAwavKt7joKcXOUv8/t/HbbP8Mz80conG9thHJZjKj6WmQJofxAp8CYq++6mw15/NiY4A3WFXRUyNmSIKtnwQLRQJApLgkErIjMv/KfVnqYdB1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iREuDxAoVdDaSsBW08nYGCQWCVARG3OTReBIeCiSJ4E=;
 b=UVghpF9WsSygLvGi9B9Poa2rJqsSq0IrrMpTi1FFs4BleyvDDs0Qv6ZV072BcxQr630kHAqEmbhp8jkdl6ZL2HknRXX2HQbBcaU27ZOP/Xd25tybwFWQpWFcVJY71OkSEpYbjnVN2KV93Kr4zkpsc1koGdmINNKGO06oYvLdD6btAM1DykXGLrMLAGfW9dCtr1n2UWRxat54wThO8grjZ1M/nLgjXZh74MrklqCQqDaAYl0rW89gr9qjGYViq97fOJ2sncw6UeY/T+YtwA5jT6qYV7NL8SbngAB3CLZG3rE3mbuMMUv8Zc38yvxnKOz960q91MrpdVVWyC28i+q2aA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU4PR10MB8759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 18:11:36 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 18:11:36 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arkadis@mellanox.com"
	<arkadis@mellanox.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 20/23] net: dsa: lantiq_gswip: add registers
 specific for MaxLinear GSW1xx
Thread-Topic: [PATCH RFC net-next 20/23] net: dsa: lantiq_gswip: add registers
 specific for MaxLinear GSW1xx
Thread-Index: AQHcDufpcMd3Gd2mckihtyBc0P2gPLRtcD+A
Date: Thu, 21 Aug 2025 18:11:36 +0000
Message-ID: <d867cfec3cc144f1404420ab868aefc0779cbcd9.camel@siemens.com>
References: <aKDief99H-oV0Q7y@pidgin.makrotopia.org>
In-Reply-To: <aKDief99H-oV0Q7y@pidgin.makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU4PR10MB8759:EE_
x-ms-office365-filtering-correlation-id: 389ac26f-5f9b-4d66-d7d6-08dde0de2adb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elFFZDZ4VURzMk14Q1lRYWlWRTlUVUd1ZEp6VDRXRFUyMDExMEl5aFYvdWly?=
 =?utf-8?B?d2VzbU85WnI4YzJET21DM0FmMk9ST0tJRlg2Q3k4eXZrRWlLK0Jxb3hURnRU?=
 =?utf-8?B?K3ZGMFVFWnoybUhsL01UT1N2M21lcHZWbjJWSi9PNHg2ekpMaC9WU0tlZVhB?=
 =?utf-8?B?RUNVZ2R5YnBOdndpUnBxeHN5OEJaS3k2RHA3UmJoRnA1a2UvVkE0NzNHSmV4?=
 =?utf-8?B?eEJaRDlJWDFaV1JaUU9mNWdnVWovQXV0QjU1NExXSUlkaG4rMG8xbnVDcWhZ?=
 =?utf-8?B?anlnOHBpYXRLaW4wc3ozR3pTYkJVNkhPNUI2dTZVQlEvOHNuNWFneDAvekR4?=
 =?utf-8?B?R2daTUpMM2hLSURkSWtvczU0ckZtOEFzOFVpZHYvZ2E5M1RvZk9QMHY0Q0xX?=
 =?utf-8?B?eitqbHphclJMVUp2RGJTbmliSHJzZ3V2NGxSdjVka1NTMytyd0VqMDY0cVVv?=
 =?utf-8?B?UkFpekZWcDY0OGwrcjRFRXJkOC9DZzZuUnlUVG50amM0N29YSXhQRkN4U01h?=
 =?utf-8?B?VmNMYjBUQWNOci8wZi9UQlFqMTB6Vy9pWkVtdDB0VVNhL1hWeGdIVHVMY2ll?=
 =?utf-8?B?bWFTTEdScEdKKyt3c1F2UHVjdkd1bGdVSUZUL0pENUhLS05pNnQ2cHU3ZVNJ?=
 =?utf-8?B?NVR4bUtHVU1CN0Z3Q2JDZE1jY0NqRWtqbWs3ekJJQUZCUGN6aTBId3VhL0pJ?=
 =?utf-8?B?a211cXRZSWdiTk1ORnNSLzlTU2lZc3RPK002SitQbnRmaVhXMFdXUkVDZEJj?=
 =?utf-8?B?UXQyNDdORFM5MlY2RXJwc2dPNnFabFp4azRLT1RSaWtmb2RSakgzY3lSdXlY?=
 =?utf-8?B?QXc5L09BRUY1NWdnQ2EwYmd0OXR6bHRjSXdXZ0ppM3lkWjJQanJGUVJ5a3p1?=
 =?utf-8?B?azNZQ0h2bDJoQ1BVSmptdmxtK21IVFdLa0hyVkpjZFh4OEh0clI0SCtVUkln?=
 =?utf-8?B?Uks0ZVJDN01ocUVhMlZTTmNmcjF5UW9za2loVkI3cWJtZG5wenRJNVVPcXps?=
 =?utf-8?B?c3BoWXlmV3FkRGxaWnMxcHc4MFF0dHpqamxjSzBHZXVpdGo4L0pLc0V3TmlK?=
 =?utf-8?B?TkVTWGdXeWlMT1hKdTl2MnAxak8vejFjbVZCd2J2SjRZYVZwOHp3azFQVHdh?=
 =?utf-8?B?b2o2Z28rV1pQTlorUlRRQ29QOFZQVExlYlBBQW1FVXJWOGlpeEpkMENNUkI4?=
 =?utf-8?B?REsrOTRnNzJaNkhneUZVYVh3K3Z2cjBUTlFkdktkMC9HdnFKSFNJTHI3akpm?=
 =?utf-8?B?eFd0SytmQ0RvZ3A3alI2ZTV6R2V6RkNPNWFmNkFFWGpVdkl3NmJLUUpMQmda?=
 =?utf-8?B?UE45Q1B3eFNiU3ZHQnlFV1czeHV6b3lLVzNxR0Jhb2dMa3NCMmhxNTBoWUFQ?=
 =?utf-8?B?VDg1eGEwWnlyTVdVcjdYdUdCajlKY0hJc29qWlI1UmRySzUxWWtPVUFqV1RM?=
 =?utf-8?B?aDk4bGVEaVJsaHBEMVFXY1Baa1BIL3NKQkRRZDFrbUVaZHVDbEF4SUU2ZTNu?=
 =?utf-8?B?U2RaSDJKalBCUFNUc3FXUG5lUWk4VE1WcTRSaGYxLytaYmQ4YzlPQ0hTU0s2?=
 =?utf-8?B?dFlTb2c0RkNXa0crbThibHNvNTV3cWNJdm11cnRhWk15U2pnMHVSdXVMcmQ3?=
 =?utf-8?B?SzFkZXhzZ0NpbzVXOGVrVFBUNGY1ZXpZMDdTQW1ZRFk2MytoYXI4ODdHZ2kz?=
 =?utf-8?B?L3c4R3orZU5GYkVOdER6aU0rTlBLOWx2U2Y4U1I5SXdvVTVNK0VPZE5uZ0tD?=
 =?utf-8?B?N0hYMVNXL01Yb0xtMmdzdmYxKzJPNWlJc3BHbXNpUDdOZjFQanQzejdnN1c4?=
 =?utf-8?B?Yy9aTlRCaHFtNytnVER4RXJlK1c0RDFKMFJkOGFhbklmdkFYU29KQkp6Z3VH?=
 =?utf-8?B?OTBhU241VysyZmVwVU5VWDhGdnpmS2JwdVBENUdKOTd5MjhVa21saVQvUTBj?=
 =?utf-8?Q?PiXURUMA5uI6aQWuWIE9MRmR/V22jTTx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MldtNkJCOGVqWkhObVFRMTJMSjJidmFnc01Kcmt4MERIVDYzdkYycVZPcVI2?=
 =?utf-8?B?TUJjMVpzRjY0L2tGMmJCNFd6VStzSzgzNEk5aVhqeGxNeFl4dmd6VU9VYzY3?=
 =?utf-8?B?akZ1b1pTNXlZaFR1MVI0aVlXUDd3YW9SMVdVQWZNQ0dKUHkrWE8wSlpGQ0hQ?=
 =?utf-8?B?QUhlbG9LZ1RVM3ZTbUpQbGh1TWFXRnBJZlY1dFFqTzByb2hOOEVBZWRYQnRy?=
 =?utf-8?B?UWhNazdnSTV0R0pyOEFXZ2hiNTlUNmVUSzlmUFBUQmVCbjdKMmhYRHQ2U095?=
 =?utf-8?B?NWs0RDZpYTlBTWh3S1h5SUYwS0ZnUVZoeHMzNnhVdkFYd3h4QkJzTDJ0Zi9I?=
 =?utf-8?B?U3hhOGcrcjdXa0RjeEhKTGtYcFZqWFJzS29PU1ZDQmxKa2xXODNzcUlJVEhr?=
 =?utf-8?B?TUcxK0U4SnNXeTVKc2JtakZUZUl4bVBHNzZwREZ6TE1wRWp0TEo3STVFcXR4?=
 =?utf-8?B?TEs0bW1LdVh0ZW1JL2VSdUJLb3ZnaDRpekV4L3BaRlFuaHN4WklVVHgwUyt3?=
 =?utf-8?B?bVZpNkxqN1JTTDBoSmV4VzZIQ0thVFAxZTdTbGdleHZBaUFHV3ZKcTh2NlVx?=
 =?utf-8?B?T1JXamgya2NPN29LcStFZHZRcUlzZ1ZFWFNOLzdQSHppeGdTK1R2cVFDL0pl?=
 =?utf-8?B?cThCZ016eUFPZkM2dTVENnVCajQwZjlkSmJxZmh3bnQ1V2NFVTIwdEdXbFRV?=
 =?utf-8?B?ZjExNFhydVhTWWdGTmxCOFBBektjS0JvV3pRTmlQNmczOHlVeU5UTFMwUGZh?=
 =?utf-8?B?MFZEd2dDNTB1djFZdm9sdWRnUVYvVzYwZ0s0VTgzaDU3d1FNY3lyWXZ5Q0Rv?=
 =?utf-8?B?T2MxV2ZIKy92Y2lzUUx4VWNtVkpDeHZacUJ1TWthUHZlSkhEdnpsa0JaWTdX?=
 =?utf-8?B?QjBieFdaL0dkYVduaExqUU5XaHFRMVR2UzE2SER6VEorUHY1OFc4MW9FK1BV?=
 =?utf-8?B?OW1PTFVNZVJwaXAzbDEwb0lCbnVwMk1SYVh5Z1J2U3VSOEVsdHRpQytZQUFr?=
 =?utf-8?B?MHhJdHljYVRWbnl1TVYrVEJDaEhSWStxQ3JmQ2F6UHFMZ3ZzQUpWYy9ONUto?=
 =?utf-8?B?OUpndVVVWkpMbGhEVGJyZDF6bWxncEVtdVFET1VkbmFGalI4OG9iTnlDZE40?=
 =?utf-8?B?ZlRPdFFGSFNzdldxd09YSDYwTVJUcW81Y05sUkFBL3RXYWdtUlAvZ1BWOHFH?=
 =?utf-8?B?QVFtSW1LTDZlK3ExVkdMZWFDdXQ3Sk1ya0t0NHJ2Tm9KTnAxUzZHVXU2VTVQ?=
 =?utf-8?B?VTlFZUlMd2hSQ1h5cWg0SnhXc0xuNGZ2dHRsdVhaTkRHV1YzZDQ4U2p1Y0lD?=
 =?utf-8?B?YzhtL1I0VkZwNTl1YVRjM2VqaklaRWlJeldPeG1YakU2V2xOSVpqWjFDNjFT?=
 =?utf-8?B?ajhXRzFFeUhnQlhWM1A2a3dyS3AvVUJ4YkkrUWh3MGVtK0VtV2RsdWhCNGhx?=
 =?utf-8?B?dElnaURsNWxpdkV1anZtUU82eTZnVW9ES2Q1T2wwNnFRUXNHRVBIbm1ETlQv?=
 =?utf-8?B?RmRRdmFqZnFVa0VxVmJhUGl5UmlLL1p6c1ZRNE44ZURkdHdiUU02b3grUjcv?=
 =?utf-8?B?SFg2VGkxQS9IOTlmQ2YxdGxzMnV5ZEYzZEFzQmJMd21SKzkzT3M0Rm1LQVoy?=
 =?utf-8?B?U09LREs2dDd4Z0g3b0VOcTV5NGhBMVVlZVJVODg2NEc3N09ZMWVGY2FrV2M5?=
 =?utf-8?B?N1RRNzdJellJUmJiczc1ZSt4OXNwOFBKeUFnOWltRktaQWZBVEVueEJwRHpG?=
 =?utf-8?B?aHlMZ0RpRmRCUXRsczl2MitNQk1JLzhrUkhkQ01oTW1TYnJhck5VKy9NQ1A0?=
 =?utf-8?B?eVlSVHNTMHZvUEViQmZ3aU5kWVVxMVVyTjREVE02MCtlUnVEcGNPUVJXbTBV?=
 =?utf-8?B?d21sempWcXc0K0UxdHJxUzJsa3VqU1N0V3MrSGJyenZpZEpmcnBEUHlORjNC?=
 =?utf-8?B?M1NGdFRwbkl6dzYrVWw3MTh5ckxETm5saTBkU0pVSkVVZE1hWitGZmhMOGto?=
 =?utf-8?B?RWZ4cnVCcjhieldzYldtaHZod01ZamwyckhqWWtuMjhBSXplWWNXVkJmcTR0?=
 =?utf-8?B?T3hCVHZwVzcrcjZMYVpjd01lSGFLWEZieUhLeUFQNmJKeWFVRHUrUEgvcnk0?=
 =?utf-8?B?OWJBVGNUN3dBVnF1S3ZUalcxM0VlZnNHYnpmVmMweVg0cnlMbDl5WE5STDRX?=
 =?utf-8?Q?mXOqL7RByKLsfkkn4HwIOdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BABA5F36FD7344FAEB6020C179C5FA6@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ac26f-5f9b-4d66-d7d6-08dde0de2adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 18:11:36.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkmRnFQJf/eGgRdz3rdj59LSa0tC9WuWIaQqevA7rRyzQiGf/7FRK7nyr4LKSPhaiOU7BGnVHJqnob5yK0FSwxTcNZ8I32MoIjeMu/hlqkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8759

SGkgRGFuaWVsLA0KDQpPbiBTYXQsIDIwMjUtMDgtMTYgYXQgMjA6NTYgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gQWRkIHJlZ2lzdGVycyBuZWVkZWQgZm9yIE1heExpbmVhciBHU1cxeHgg
ZmFtaWx5IG9mIGRlZGljYXRlZCBzd2l0Y2gNCj4gSUNzIGNvbm5lY3RlZCB2aWEgTURJTyBvciBT
UEkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlh
Lm9yZz4NCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dpcC5oIHwgMTA5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMDkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXFf
Z3N3aXAuaCBiL2RyaXZlcnMvbmV0L2RzYS9sYW50aXFfZ3N3aXAuaA0KPiBpbmRleCBmZDg5ODk5
MTE4MGQuLmU4OTE0NDgwZDU5ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL2xhbnRp
cV9nc3dpcC5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9sYW50aXFfZ3N3aXAuaA0KPiBAQCAt
MjI0LDYgKzIyNCwxMTQgQEANCj4gwqANCj4gwqAjZGVmaW5lIFhSWDIwMF9HUEhZX0ZXX0FMSUdO
CSgxNiAqIDEwMjQpDQo+IMKgDQo+ICsjZGVmaW5lIEdTVzFYWF9QT1JUUwkJCQk2DQoNCmEgdHJp
Y2t5IHF1ZXN0aW9ucyBmb3IgeW91IDstKQ0KDQpUaGVyZSBhcmUgc2NhcmNlIHJlZmVyZW5jZXMg
dG8gUG9ydCA2IGFjcm9zcyBHU1cxNDUgZGF0YXNoZWV0LCB0aGUgN3RoIHBvcnQuDQpPbmUgY291
bGQgYWxzbyBlbmFibGUvZGlzYWJsZSBpdCAoYml0IFA2KSBpbiBHU1dJUF9DRkcgKDB4RjQwMCku
DQoNClllcywgaXQncyBzb2xkIGFzIDYtcG9ydCBzd2l0Y2gsIGJ1dCB0aGUgcXVlc3Rpb24gaXMs
IHNoYWxsIHRoZSBwb3J0IDYgYmUNCmRpc2FibGVkIHRvIHNhdmUgcG93ZXIgYW5kIGF2b2lkIHVu
bmVjZXNzYXJ5IEVNST8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K

