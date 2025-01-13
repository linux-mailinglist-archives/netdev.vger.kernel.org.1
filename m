Return-Path: <netdev+bounces-157596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52BA0AF4B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF43B3A4A32
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EE231A37;
	Mon, 13 Jan 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="m3n3ziWm"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020141.outbound.protection.outlook.com [52.101.128.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBB1465AE;
	Mon, 13 Jan 2025 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749379; cv=fail; b=qneE0XMBA6rxmmcTDrVAL7C65tPyVib72sfx9gy6hgOxBAiH8QW5DbW3Jp35JDfbPgwTXKxwy6INEptIxM1Y1kc+B5hUtQTYEsFUgS5jcjVg7X3LFt50DsiDrM7depI92hAV51qsuwL6qr/LO4AT/k9I4D0w3hdx9FiFClyrHmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749379; c=relaxed/simple;
	bh=GTeN5ChWAjLJClykP34QjXxhH66S1VKBR9m+RnjbrzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASQCDAAXLUVs7ig3LGdQ9qZtG8uli0aPexEHtHXjEIZOMSSOTo8vuzQYeOo87mHHAKIsRLx7Esm8gkmrpDV0fctS/aWYJstS/DYVo6HGSJBXiRj5GxcUaqVjkKa/DWETUu9gZolmnh/r31A0ruxLOHCrAGuttzFpOHW8rqQYgmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=m3n3ziWm; arc=fail smtp.client-ip=52.101.128.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuOIqWIw5F57xh0S4l+EBajg516+cm3dmj5gzlfJZ9/za6h9vsxgNVqqZmQa8GtPq05hO1QKrWy3X6UVy1m5Y3ByaEJFjeeCDP5BRFjEM3BLXD9KLF56tQuvtYWrmjYExruXxTJhZEiCx9u6aAeG5NZ9SuBHoYXv2ryk6BruKalzf2IFqd3DaEls0Q3q/HpDiW6pAlASByvpYyBnu9bWAWFIlJUGdmwxwXY3Eugwon+KR7m6ikfNyHPtyiIYaCndmPfO6l22Mn1eSI+a12UHP4bp95TxUD+OEqiyTdr6woKNxVYkGYUtXx4L/h8wFVaX0+JHJF+qcymnfTdiA3lEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTeN5ChWAjLJClykP34QjXxhH66S1VKBR9m+RnjbrzU=;
 b=sKetecTZA3QW0WqDBWsHBVWMjtT2oUZxhMM2iENTCUqL78Il1eScSYTrgfbAJNVLEWIbrsDFKkP3wzCAylKMQjIeoAFunm95WImo3ZSRHhfpwCR6LW4I5YAdNwgIKuGjA2TZ1jqrpxUtd74UXg8IgnGNTb1Niti8gErwzSEFwtzFlNecXIa7h+rYszF18sBiP9rIGnzQqXtyk2v7vntY7d8GgXyQ6vywJUvGfdJ2Opgx09xYrjQQAEH43N8Z2B1CvJ496y5E6gw053gJ5xij2EUpeKB6jlIIGHXYu4Erx7/HGETkrZCUgYvBhnQcfxFhQoLpHlquKxGxiyfCImDAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTeN5ChWAjLJClykP34QjXxhH66S1VKBR9m+RnjbrzU=;
 b=m3n3ziWmlIRAo1peDpupc7jifXXWRD8Dn65fimLdnA5gAAKt6NXoDOxHLbRXCIuOAJMeSbq1a4XxVZNddx8DLp9xje98p0idDNCp0uPvGfyEpSaodQr5b1bSO2t+cUVo5urjqYvDAeCfjKvG5kxjZxtGt5itqkVcucGU2nE8La4YfPp95cT3L+3DJAu666tzLPb6yD80S06/IYl+OYgzKEcal09JNbeSS/FxstmT0Zp5TeTb4bIKM0uDVuO9n4RnOA1HN/npbychooDoxrxNrWUj7JJOmyv+e1fDIlPJisLesLsyChs9WcoXr1F1r62k4jFXCpLIzmNf8FPuPy62rg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SI6PR06MB7272.apcprd06.prod.outlook.com (2603:1096:4:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.9; Mon, 13 Jan
 2025 06:22:52 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 06:22:52 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Ninad Palsule <ninad@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>
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
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbnuimhjogW1BBVENIIHYyIDA1LzEwXSBBUk06?=
 =?utf-8?Q?_dts:_aspeed:_system1:_Add_RGMII_support?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSCB2MiAwNS8xMF0gQVJNOiBkdHM6IGFz?=
 =?utf-8?Q?peed:_system1:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXCAAFgBAIAENTRQ
Date: Mon, 13 Jan 2025 06:22:52 +0000
Message-ID:
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
In-Reply-To: <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SI6PR06MB7272:EE_
x-ms-office365-filtering-correlation-id: b845e359-0378-4ac1-1030-08dd339ab5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0RBRk16VU0yM3VmUi9HN1B6L0oyOVF2eDhMRnptTDNheGk4RUw0TXZmeWNJ?=
 =?utf-8?B?cHQwa3NyZFpBa0ZBeDdaWTJrM1VOTjE3VjJIcGMzM1Z0TG1NclVOTGV0SlNv?=
 =?utf-8?B?blhiQXVUelRoTjRXbWdaRXZKODVwSlRQdzhWdVpFc1FOVzJBREZXSVgxM0ls?=
 =?utf-8?B?SGovekFtSDBsUHhQS2VCbGNpbEZIWGxja0NIM3VLNjRpRVpCZmVNQWVxSzha?=
 =?utf-8?B?Z2dJenFjcGEzL3ErK2krdzRtRVNEZ3liWHpGYmp6c3p0dmU1eS9uTTJWQzRF?=
 =?utf-8?B?cE5YbFJFeXpLbkN2b2ZmdllYVzg2eUtieXhwSGFtNFNGVU9FNGlQb3lEL3Vj?=
 =?utf-8?B?eG4vc3kyaUx1OXZZcVczUlYvcm1IakdxN3Z2ZUxVelBxQy9LM3hQbUxwZFN1?=
 =?utf-8?B?Zm4vdWIzNG1aZktkdHZrbnJDMkk4VWlERG5PdGpoeitWeENEV1QwUXU5aFc5?=
 =?utf-8?B?RUFrNkV1R25zSkxkZHB6TENCcWNnSTVHYWFJeFZPYlVKaFJVWTFNRUFFcFov?=
 =?utf-8?B?OHJLOXpObVdxQnhEMlZHc0g4SWJDNzVWYVJkZjROWjZrL2pHdVNiU2pkZDI3?=
 =?utf-8?B?R3pkN3A5UnJuQTNVZ1NVRG5FYzhIUFFxNXJtUWlDUm1Kd1JEU2FoNGoxMkFR?=
 =?utf-8?B?MHdrOHFFUkJFY2pUSTJzbzNybUZ2dGpaZGt4dFlEZmUvR2MveHN5VGhZaXds?=
 =?utf-8?B?VTJDZVNQWEEzZ3RyYkNDdVpncXd5ck5oSk1rSkJ5NmpHVEdFUmxPOWRMNFpr?=
 =?utf-8?B?RVJEdDIzYkg2T0ZPNHpyV0pFOUIrQ3dUVm1QYUFPSCtxL0ZsNllEOEVjc1dt?=
 =?utf-8?B?VVJUcVFqU29lYkhPY1dvTGZGWW9LV2pOY3hUdWh1WDRsNVN6RVV1UWhCdkMx?=
 =?utf-8?B?eGoxVnd6TXZSVEdCZ3AvZ1NHWDF1M3lwSmo4SWtjVnJ4RGtGYnVRMk1nL0xE?=
 =?utf-8?B?dUIwTy9COXFjdW5uckFraGdSWjZkRjZORDVjd0xvK3VrQ2tDV0tkVDI0UStF?=
 =?utf-8?B?SjVoZUxBN3libytDTmpBR0hRemdmM0VPSHZLNExVc0EwWlNFejdIdFpkeFhW?=
 =?utf-8?B?TjFUcElvTGtiaVFjY2dLK3pHQ09JREUxVXhkQkdrR2tsVyttMDRsdE5Jcklw?=
 =?utf-8?B?MUxVdjh2S3ZIb3haTkt1cm5jbUJpQldrWVdyZ2hkbEtoUHltSC9pbE42dEp1?=
 =?utf-8?B?aDVqRE9kVHAzUlAwYTVQZmRlaDlIbERuWURsYm03bjBTMVJhbnR3Ykk1cldi?=
 =?utf-8?B?LzA0T0RWS1lFcVk1Smpja3V2WldiTG1TY3dMSWw3eXVlZUVEZ3RvMXNzWE1K?=
 =?utf-8?B?WnFSMEc1V1NOaWRQbHhIc24vNVM1NWQ4L1FhV3JCK1g0dUU4LytRTk53ZGY2?=
 =?utf-8?B?aDhRMERsbm8rZHJJTEZEOFpFMjBlTVY4SXhtY1NVbDNzL0k5TWRNYVJGWGlL?=
 =?utf-8?B?THB3UmpBc2g1WU1oTTJ6VG4vU1NoWTNIZDZwazltU0MzMTZKc0lwZkVUcFhX?=
 =?utf-8?B?OTBGQkxoN0JFZE1lTXJLN0VQWVFNUk1kYlFRdFM0YUtMQkZyOU44RDF2M2dN?=
 =?utf-8?B?aUNtR010NnBKL2IxT1lQRk5ZZ3YycmwrZEpEOXBCUXh2STZBcHN1eGZZK0I5?=
 =?utf-8?B?bk8xS29lYm0zSDZiZC9tbEptTzJzNDE2RU9neUhlWEx0YVNYWkVwa21DaHBX?=
 =?utf-8?B?U3ZWa0tTWlRJZURsUWM2dnBYTXRRU09BNnBWT0k4TFlDMVgveFc3YzJhMDhm?=
 =?utf-8?B?cU5pWTdkUGpTRHI4Uk02SnpVcERBajRxSVdoQUw4d01JM3Y0TXRJQ0x6UU9G?=
 =?utf-8?B?WW9QR3VjYjd1L21FZVIyU2piNW1md1d2MFhlT1I5MW1ZVDZWL05TK0k5VU04?=
 =?utf-8?B?MmtVWWRBb2VXaWdpalMvak15Rjd2UWxSUitzRWxlcGo2eHF0NWVtUGl2d0M0?=
 =?utf-8?Q?uR0ywiGmnXGHPRWrDujVT8bgX+W4L2zc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXNLL2VzTldlMVhNcldlWDVCUk9DTUh2NTRQeXh4UDl5UXF3d2hKSm5NTVB2?=
 =?utf-8?B?dGhIWElKZlZwZkJnNG80YkFsWGlGT01FMGVVbW15d05KbWE1My85eUZCVHIy?=
 =?utf-8?B?em10clNBTlYyb05zSDFCUjdDNTdDOXNmRk85aXZBV0IwczFSdWhKcTdsRHA3?=
 =?utf-8?B?cy9aeG93RzY4TitqUG8rVDlyWXhZcnRtVHVpNDJYVFh2Y29XQTRjZmd0dk41?=
 =?utf-8?B?bXBvbXVtVndZZEpqNFhSM2hFYTA5Z1lMYUtFdjFYVlJoN2RjTGpqRGNWSzVu?=
 =?utf-8?B?eVZpR2dORE1JWHN1YmZyMkZPZlRyNjFZdVl2L1dVemlFMTVWMUpZTVVwZWRF?=
 =?utf-8?B?QlJLL3NJMTFaMW45SGI2WGNBKys0dnpieHQwcXFiclBMRkh1S3Z1cHhsRHN6?=
 =?utf-8?B?V21jSVZPaHFQUC9qK21oMU5JeUVhOXA1QXJreHQ5TDBJTUo4dTNudktYQW93?=
 =?utf-8?B?QW1XWnRTZFN1RGx4UFQ1RjNlcXBDWmFrNzVxRTI1NWdPTmNrN2lzU3V3K0cv?=
 =?utf-8?B?aitodW5Bd1V5L3JnNlhXa0ZBeURSUzI3MEZ0WXc0TlFxWW1yeDhTNzV6dnZx?=
 =?utf-8?B?RitNY3ZwWTJOTk1vdjAyTHcyY3NzMnJQTVdoY01oaFA4dkJMeFNFK3VaRzBE?=
 =?utf-8?B?Wmo3NmxqenFEYmJmVjg0aWVRZEtIbytDb282S3hmOTVnelpsZlhpdWpiMzNv?=
 =?utf-8?B?aWFCMk9WKzNrR2hMWFBkRXBPTXRxL3ExbitPWU1iNVF4Q2hnQ2lOUjd1TFQx?=
 =?utf-8?B?aTZRUDB3cVphaXpZM3VOcG90bklrTE8vbFpuSlVnMXU3Uy9oZlNQU0dDcCtv?=
 =?utf-8?B?RU9uQnFTT3FWc2RvMjJod3BiQ25WTmticFFYRFRDcjNQTTgwRE0vRlZPRU1G?=
 =?utf-8?B?Z3ZVbitzNVBsUHhBaVREVVFIa1V1R2Y4eXl1N01EUE51dy8xeVhXeDNuNkdy?=
 =?utf-8?B?ampYQlRzbW1LbFcyUGRNSXlncWNKbVd6OUlZVnU0YkhKOUNKNnQ4L2R4R2tX?=
 =?utf-8?B?S2RUamMrS3YwWnU1UjhmeXBFMXg0b3YvZ3BMSUE3VzNING5PTVRPcEc4ZDVP?=
 =?utf-8?B?YXdKVithdEhKdFRpMGpUZUV5OGtjUVVvc2hBWXR0a1ArYW9YTTdDY2hmT0pt?=
 =?utf-8?B?bkduTHlydGJWczBTUVBjTnhmbmNoK0VMeFhhU3hEQ2U1Mmg5MjBTZlRsN0tO?=
 =?utf-8?B?aENxb0Fnams4Z1QxSzl6cHNLdnlnZUk2TnVlVEFoYVcrZXlUVml2b1BnRzh0?=
 =?utf-8?B?c09PMGFXVWRiME1lZVlBQk9BaUJtUXlvelYwVGh4YmpNaXdGVUI3QmwrdmQr?=
 =?utf-8?B?WHZDS1pkRmF3ZmhockphdjdycXkwbEg1aXpmSlAwaFUzOVhuM2h4YllnU1FF?=
 =?utf-8?B?VENON2ZpcHpZaU9jYWNXTWVGOVEvdXVUaytOdXorWFYxcERMYlUwcWc2S3hw?=
 =?utf-8?B?TjFrcXFrcFVOYmJhTVgwVkRmbGl2MFVkMkQxY1FFVXlmSHV2TDh0c3FIeFFv?=
 =?utf-8?B?L3VJSGx0NUEzL1BhamRVUGlYNFcrTENvR2NMUlFXSldrNEhPR09aUFh1VnB0?=
 =?utf-8?B?TXBqWjU1MWhIWXUxRitiaTFYZENYZzFMRWRzV0VJd0ZmTEZlU2VOa1dVTjVE?=
 =?utf-8?B?SFNpOGs0YjI2V1FPWFE3Q3RVMFl6RlNaaGVlYVRQdnM0UDc3U2FJclR1SlQ2?=
 =?utf-8?B?YjF6RGtoa0ptbHcxMGF0Q3IxOUpFaFJPbkwydHU5ZHgzZTVoMFI2bmhCOHAz?=
 =?utf-8?B?Yk9qSXV6NCsrcUgrR2Z3MFFNWVorUHQxZWRMMGh1ZDYwOHJPeWp2WjFlWjVK?=
 =?utf-8?B?emk0Z01zR3I5MjhRc2l3WExBY1BBbkFlS1RsZy9keUIvbE1GOUVkUHV5T25i?=
 =?utf-8?B?WWprNHVDWHg1bGZBa2NuUGcvWEVhZkJMVUVJNmJCbDhkTURneFJMYVI1c3NK?=
 =?utf-8?B?K1krTjBRMDFmNHlOMWRiaXAxUUxXbXdoZnVZQVVBMldRdEV4VzVEUG5aeElr?=
 =?utf-8?B?c2xwbDM2cjhoVm9kSnp6ekJHL2NZNHdwc0Q0dEUvU3JhTkl0WXJvb2pldVAy?=
 =?utf-8?B?RHZKQ3hLNkdybUplTWEyaEFiMmdPUWo1UERmVEhyK21mVVc4MnVzRE1sNWlN?=
 =?utf-8?Q?HwxpdFRBv69Ftlw2b01x0DA4b?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b845e359-0378-4ac1-1030-08dd339ab5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 06:22:52.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ec50f9f9UrIzC+xZ0nyOcgnGM2q8YH83SU0geykNSoZX3dXXt9ZQMftIUUGt+ygtNyfSL37fJ6zlsY1SDX2O+GEUrojRrRKQLKrGZMKZsPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7272

SGkgTmluYWQsDQoNCj4gDQo+IFRoYW5rcy4gV2hlbiBhcmUgeW91IHBsYW5uaW5nIHRvIHB1c2gg
dGhpcyBjaGFuZ2U/IEkgbWlnaHQgbmVlZCB0byBob2xkIG9uIHRvDQo+IG1hYyBjaGFuZ2VzIHVu
dGlsIHRoZW4uDQoNClllcy4gV2UgaGF2ZSBhIHBsYW4gdG8gcHVzaCB0aGUgcGF0Y2ggYWJvdXQg
UkdNSUkgZGVsYXkgY29uZmlndXJhdGlvbi4NCkN1cnJlbnRseSwgSSB0cnkgdG8gYWxpZ24gb3Vy
IFNESyB0byBrZXJuZWwuDQoNClRoYW5rcywNCkphY2t5DQo=

