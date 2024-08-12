Return-Path: <netdev+bounces-117568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A549594E50D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AC31C2061F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 02:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003A13049E;
	Mon, 12 Aug 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAbRnvHm"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013025.outbound.protection.outlook.com [52.101.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDDEAF9;
	Mon, 12 Aug 2024 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430265; cv=fail; b=BZhaTt4dgbpld/vVeF7owvpEg8qt+cndmipkIkCiBnhqiz9VLRG3JV99U27ZCXpLyXQmmJgFUKVlJM42s1z6ggHy1g6thZX8Xj2crtCRrI+3Fa4rS39a3sMMRaiLyeTO1p849mxfEyRFMAqZQIIR8CK/9gprM9/tOvqKwweZlzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430265; c=relaxed/simple;
	bh=Pys53PswyRk491krh2eNngrSe/VRIxbmO2f4ZbxULTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgY/GMNpOR4MxQLcbbM78MZz8IHNUkAa/2Og84IwHLPes+xaogNy0LMqV2zw3HjrxPoetuVftWIZeP4D1lKrl/UIFlCQXTtcyBwOdzGVBbrbZLvAur8yUU5v+lyDCgQhNEA588TH6FlndppMNm2MD75vCPCoMvYbsTk/VBPpCEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAbRnvHm; arc=fail smtp.client-ip=52.101.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ8osfKom1PbYLbN5uKydnM9zXnpsxLmqPnam+ymhL/mFU+MQaWEnXhlxegh+XaQ2WwutH2QT7T7ZyIycFWfQa5X7nutRv06afiDQP+uxbqwpDCcr6ZDMyMJVSiu72UV8qkAEammBPMoy6w9F0cFf4XQaHZgDckl3Hv3jqlrRsQymGuXEfZs6Hoewmej24w7il0L7dOOC9UqVlHkkvJqM3MLmkLP70ycPMHZaSS84FUfdPhR7XAWOtwh4XORbJWpvghfjweGC7wvvNl5iRDf5So9xSXCGIigBae2yUOwKEhlkT2BNlqdvs/SgY4L66ex9S8yBTuoCM551gB4fIeYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pys53PswyRk491krh2eNngrSe/VRIxbmO2f4ZbxULTU=;
 b=mekqfi59qmLDu5EpzIQRgThAiI5xsRG+GXyaybF4B5Hpsg51GQa9FMh3LLTEwo5xF8Rzi8SF0RXyJtQQu4HrAjwGIHkNa2VFXuF9dCuRUBiYNED3il4bamBqWBfD4Rtiv93cRr9ag8ktyVBhhrBKP0izO7EtUtk4MBVolsTBbm6UOWVZG2dJngFE3sP794sRUvwDf2A79HJEUCJBarz4DzAoP+wsf1iuVWa6qQB6M4kENvsjbJvcDz2Hkr6yA7AcRlDysT3p0HkneQvDnHQ7RMiczJmsM6uOIm3rrouXo7TVstiqxfU2vw87kgeDzKVZS42YHoLkBpPSp7BAw73smA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pys53PswyRk491krh2eNngrSe/VRIxbmO2f4ZbxULTU=;
 b=CAbRnvHmLNuRMGAKN8zV0Ezh7c05yAMJO5fudf9+82NVy0uDECCPpWN94FZBDCEfkFJhyFGd9ZRTGzJTGtAsVP0CKcarKEVa0zIhHFJkgq+Ov7Pbb1rDVBNx+Wnht45f4l6UOQqV5kBNUWyDYHeCW1MifWf6l1vzjZjNz+c7VStqJiP2s3CGw0QwyT22wsRQCJs7eIIiAan/G9+HGVc+BJMCB5xx8D4NYubwAeph0BUAwyWvtH/zhVyxSzt00yV3WRlgiRsa5MG4cKO9YZIMxaEKjqf8VNRmshEmtxzfatnjLldGtv9FQ5SZF6oEmSsZ2v8lkjWO32LGDsJsBk3fcg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 02:37:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 02:37:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Li
	<frank.li@nxp.com>, Rafael Beims <rafael.beims@toradex.com>
Subject: RE: [PATCH net-next v3 3/3] net: fec: make PPS channel configurable
Thread-Topic: [PATCH net-next v3 3/3] net: fec: make PPS channel configurable
Thread-Index: AQHa6kFAi4gL5hsrEkeoi5LiVHboYbIi7Fgg
Date: Mon, 12 Aug 2024 02:37:40 +0000
Message-ID:
 <PAXPR04MB8510516B636E2935AA2FCDAC88852@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <20240809094804.391441-4-francesco@dolcini.it>
In-Reply-To: <20240809094804.391441-4-francesco@dolcini.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6769:EE_
x-ms-office365-filtering-correlation-id: 222cefd1-b352-4266-2046-08dcba77bc5f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?aXJxb2dkZWU3SUJaUXZQQTMyRDlBSXNscWxMTGRuSWVEUXdGdDRlNmNUNWsv?=
 =?gb2312?B?ejFmSlMvVVNEVVZVTGpLaGVzT1NpcmdNV0loak9sOWd3REJib3dBZ3Y3bVZ4?=
 =?gb2312?B?aHhpWmI0b3dNTCtZaUc0d2NYN2h0OENkV2RyTUVwRklFbHpTU0FHSzI2cW9S?=
 =?gb2312?B?U3hnNEhYaDZRWFU3QmtUbVordkJtZjkrVWZmSzhndTVIRHhKMktoa0FBditL?=
 =?gb2312?B?SjNDMnkvQzZ2S3F0ZFE0UnlSZXJQajZXMndOVmptZVhlM1p5aTdHRkZtaWFJ?=
 =?gb2312?B?WlYvdlllUFJMSnU1RHhscXRhM0QvcGFXaVBvdlkzbmphdmtRejVuMkJUWnV6?=
 =?gb2312?B?WCtvMW96ekVmdHkydUo4NUxSRWptTUdmMjVGTFpCZThrdUhkRHpXc0UxOFN4?=
 =?gb2312?B?R1dyZmVCOU9qSGk3Zkg3OFRwendyNjNGb2x2L0lvSm1Yc2RTOWZpNkVmbW1Q?=
 =?gb2312?B?aTZ1TmdQc3YxL1phUTJTbUNpY3l5TDlrNGpvS1dWK0Z3SVY5ajh1TVgxbW44?=
 =?gb2312?B?R3g3bjZaNEJ4MWw2V0QyYndvR3pNQnAwM1kzNGRYM2JZREVNMU1QUGpWb05C?=
 =?gb2312?B?VVlIM2I2N2lnOG85TUpmK3dERjVUMjQ4THExa2d2cWs5RUF6YXErYUZCbmxW?=
 =?gb2312?B?Z2lLbk9HaVd5eGtZUWxNV0xFZGc2RDZaN1hhNTBKRXdwZW04U1VoWnZxeWRP?=
 =?gb2312?B?ZGU3TS9wdjdscnVmNkJKRnA1VFRzSHNuNEtrZUJFazN4RUYvTjlva09tS0ZL?=
 =?gb2312?B?WC9YaUFlOUdVdm83QTdVcVBGb1dRZjdjbmF1Y1g2aDErM0NkUmtHeER5UVNP?=
 =?gb2312?B?RmRBTWRkVE1TTTNRZS9McUpzaWpnNGdtM0w2R2g5VlRJWVI4Ym1yUTU1QndX?=
 =?gb2312?B?ZHhJSVNaZEwvZittTUdqS2cwSnBtRUFpNC9JdTRtUlNCMU16ZnRhbU5MUzk5?=
 =?gb2312?B?MFVIRUM3ZG95MFJRaFB2MWNtSTdSV2dsZ0l6TFNCSzNqUDZMVUFqM0VCSGRE?=
 =?gb2312?B?aER1R0FJMFBvTTA5MEt6ZGtIb3BEbDYwYk1WUmtXWG9uTVlGV0VoeTgwYWRE?=
 =?gb2312?B?ZzhRb1JyL2FwdUNMUDlzeXZMZUs0TS9nWk8vck5ESFVKdGl1Zmh4ejVEN1F2?=
 =?gb2312?B?aVVyMXNEVlJnb2xCU2prNkRPR3l3UEJLMkhuM3M3WlBtb0dSdlIvUzFNbjNT?=
 =?gb2312?B?M25rMm5uTndWY2RYcmQ2TzRuU3QrTEthaW1vc1Q2RVlGcTdGdXlVa3hSK1Ay?=
 =?gb2312?B?SFFKbGptN2VSNTk1WVpaTzNST3FyeENoVTFINDRuNVpFVFRHMHFmUHgvRGc2?=
 =?gb2312?B?bHdKZHM0OVltWTdUdWwvamhiU2RuY0JMK1ZOcWgwSVZHb1pVVWwzYldyeTBM?=
 =?gb2312?B?dFFVblBnNmM1NlhSR1NPL29tbEVldmcvNHg2cGkzWDZzcEY0ZW5qdjVsQWhE?=
 =?gb2312?B?Qk9TM1hESVZBb05iWXdTM05rYnZrZEkrZVgzOW9mSHFGRTA0ZEJHc2JwK3RI?=
 =?gb2312?B?OXlGaXprbjNQV2ttL0g5UEZjMDdWaUVGbFQzcXJNd0I5cDRBVUFybTViaVdr?=
 =?gb2312?B?OFVFbzlSV2l1MDRwbCsycEU3cEFpL1dyOFFWT0wxZytGSks5N3JnK1d2dE1S?=
 =?gb2312?B?eS9BQ3ZuQ1E3dXNhc3R3d3ZQNUFmRjI3M3A0TXJ2aytiY3ZEN3RWZ0dRUStk?=
 =?gb2312?B?ZjhHNFF6WWZtcmpsU25BRGdaMTd5NGUrRDRrYlkzTktNWHN4R1VQV05iWGV1?=
 =?gb2312?B?dWI4Y29YV3pJRDRZanFkRnNmUVN6cU1PelNZSkZNZEIyMFRoUVRwZW5RWjBD?=
 =?gb2312?B?Rk4rMkJ2cW9yRUtUb3k0ZCsxb2ZvVjNmR25jSGFGNjhCK1BSL0dYb3J3Tm9x?=
 =?gb2312?B?azhXL0RkTmhXd0lEQkJpU1pnenM3RllPUS9TMmpYSzJ6TFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dTBTRXhyb0g3dmtUc29zNmF3Y3BteDh6YWNJRVBGMSthb0NEVEV1anFQTWhr?=
 =?gb2312?B?dkg2emZHTU9ydHVJU3ZUVXpyeVRjTmtpMlVLK29wZGNFZlc4ME5lVFVyZkhU?=
 =?gb2312?B?eE9CYmpLNXU3NmNEUVBkL1RtaURxSFNyREhlWmlJREluMWJIdlNLVmhFb2lu?=
 =?gb2312?B?NHBWM1ovRjdwSDA4Zm1iMkZ5WjR4S1IyWXhicGhPQi9ERUtmVHFTeXQwU1E2?=
 =?gb2312?B?dnd0YkYvZ25SZXBjSUFwazFoVnhIZWNKdGFYOWF2ZTNucEw5dEM4MWdMTUNU?=
 =?gb2312?B?ZWR5dFliT2JCVU45eUg1VWVGaStVbVJ6dUZFL0IyKy9WZ0xBbHNwM0x6bVpq?=
 =?gb2312?B?SXN5dWhkek5Ca0ppandWL25EcnNxc0g0aTRFVlhDaFNLa2E4OWhOYkg5clhI?=
 =?gb2312?B?dkd5MFMwdUQ4azMvWnB4citPc2lXWkppZnRGSG9Kby9qRU9UYytyWlRRZ1Vq?=
 =?gb2312?B?MWJpNlEra3FuSUJhT0ord2VMQ1ExSGxIdzdpVGpLMGd4UVJpWmNHUWN4VVhY?=
 =?gb2312?B?SjRLN1MzNW43V1hNcmo4dGRpTXFuWlFpZ3JZZ2NJQ0F3ckc5ME1hUnJFM1hT?=
 =?gb2312?B?MzZhZWw5REVKSUtQQXBrd3RzcWZRNnRFclVzZktCRG5YcnV1SEpkbkNBZjRp?=
 =?gb2312?B?bXRnSURKK2V3M0UxampUSTRBM2loYVVQQ3hBT2tUU082emoxSFpDSHE4ZlNW?=
 =?gb2312?B?UVdNelBlT1ZvbnErNWpVKzhtY0huMFMrNGxxWEJhWG5JcUtSc1g5SURmNENQ?=
 =?gb2312?B?R2s1ZkQyRlh4Qk5YYklkUnMrMmUxQWkvWlJLQjkrWG40MEZLcVZ1ZmNUQVV4?=
 =?gb2312?B?TzlBSzcwKzJYNWVWTHhaNDZ6a2NjYjVKdnpMeklkK2FlbVFrUUdKNFFCREdh?=
 =?gb2312?B?Z0FJVkdTSGo3RXpPQnFoZlZ3UUczeEorQ05rZzBIMWJKWE52eTJIRkk3UzJX?=
 =?gb2312?B?cW5ERU1MY3RPWFVsb1pMVDVZVHRPYXpsTHFyQkJaNmkrNEpzR3JwTzZIbVNI?=
 =?gb2312?B?djhQajI4K1grVHV1ejNCZXdVYWl2ZjFHTEY0Ty8yQlZGcHRMM3VlUnNBTWJr?=
 =?gb2312?B?ZEd5bEFpVDg2QWR2Z3Q5TTRLS2FRdEQrYXM3REJISzFiaG1YSDIxYks0L3Zx?=
 =?gb2312?B?R0h6dWJwNjVOeXJZOEFyU3NmY0ZhT0s3VGpNTzZLekZLcll1RWFVWFhyTkZu?=
 =?gb2312?B?WGg0NWdHUlZscU1IRTVtYXRUQ1AwNVFWQzJMUkRFSkVQTTF4cGpoNUUvdmdm?=
 =?gb2312?B?WGxBT3pmSTlsUzM1N05zVzdiUmU1R2E3alpqVlFsbVplcDl2bFMyS0dVZWlw?=
 =?gb2312?B?dFVCK29ubUQvR3ZNcE52ZXBGc0E3bEE5dTRRWURhc1ZTa2x0cTRzbm93N3l0?=
 =?gb2312?B?VzJ0dzA0aW42OW5LcjF4UjBuQkdRek5wV0ZMeFVFTEUxR3Y3cUlUUlVDcTFi?=
 =?gb2312?B?NElINWpjcU9pSVh1a1BMY09jMkUyaFFtQnZreUQ4Z0d6bzFZbE9KSWJiU2NR?=
 =?gb2312?B?RzczWUN1bkpxcjNWQ284VEc4MkZTTXRHakprbmphdDQ5ckRvV0ZMWmpIcTly?=
 =?gb2312?B?SnZkV1ZuSFpDL3NHZDVkdnNpdEFheFFmeGRDbTFyUlNLMVNDb0lxQU1JMWw5?=
 =?gb2312?B?d3loN2ovZ083ZURwUSsvK1ZlbzNrTHUySDVPTzQvWURUSTFQZ1dUQzA3cCtH?=
 =?gb2312?B?d3JpeUF5ZkwrYlZFSkYvb2phSXFEaFMwdUJsaHljS2FpbWc3UXRZUnExVlRK?=
 =?gb2312?B?RlNBcGZhUmk1cDFoWDczM2Q2NG5FYjdJRENNSkVLbklIbE95S0lkcWtaN0Ri?=
 =?gb2312?B?cW1BTXVKSy8zdm8zSVhEQ01DUVRoeEt5K0k0cVYrRHhJU2I2SHk4ajdkUS91?=
 =?gb2312?B?NWZrY09tc2xWNkxrUmFpbXJNU2tXSDBoc0FxcU83aWNPOEpyZTBzaEY3amJN?=
 =?gb2312?B?dng1Rko0RkhFQzVJNXAwTHJlTzYrL1pobTQxRlJBSndpc3hmRE1nZm5oWjlx?=
 =?gb2312?B?V0NrNnA4SkNYQk5QVGtWbWV3RWh3K3NhaGEzMzJiNENlbTM2WGhRVzJ0Sk91?=
 =?gb2312?B?RS9paEI2cWYrVFpIOFgybEI4Uzc5eU91L293VzlIaS8xbklkS0RCRi82ZFpM?=
 =?gb2312?Q?dzM8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222cefd1-b352-4266-2046-08dcba77bc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 02:37:40.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lScMKilbrug+uxgFAdphvGYocV7IAsAgSguJ7YkFmIY5m1PJROjW+uEqPh3XWolmnZmK39YPgCkPAhNhZiiTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+DQo+IFNlbnQ6IDIwMjTE6jjUwjnI1SAxNzo0OA0KPiBUbzog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBTaGVud2VpIFdhbmcNCj4gPHNoZW53ZWkud2Fu
Z0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRGF2aWQgUy4N
Cj4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBn
b29nbGUuY29tPjsNCj4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47DQo+IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hy
YW5AZ21haWwuY29tPg0KPiBDYzogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5p
QHRvcmFkZXguY29tPjsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRnJhbmsgTGkNCj4gPGZyYW5rLmxp
QG54cC5jb20+OyBSYWZhZWwgQmVpbXMgPHJhZmFlbC5iZWltc0B0b3JhZGV4LmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIG5ldC1uZXh0IHYzIDMvM10gbmV0OiBmZWM6IG1ha2UgUFBTIGNoYW5uZWwg
Y29uZmlndXJhYmxlDQo+IA0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRv
bGNpbmlAdG9yYWRleC5jb20+DQo+IA0KPiBEZXBlbmRpbmcgb24gdGhlIFNvQyB3aGVyZSB0aGUg
RkVDIGlzIGludGVncmF0ZWQgaW50byB0aGUgUFBTIGNoYW5uZWwgbWlnaHQNCj4gYmUgcm91dGVk
IHRvIGRpZmZlcmVudCB0aW1lciBpbnN0YW5jZXMuIE1ha2UgdGhpcyBjb25maWd1cmFibGUgZnJv
bSB0aGUNCj4gZGV2aWNldHJlZS4NCj4gDQo+IFdoZW4gdGhlIHJlbGF0ZWQgRFQgcHJvcGVydHkg
aXMgbm90IHByZXNlbnQgZmFsbGJhY2sgdG8gdGhlIHByZXZpb3VzIGRlZmF1bHQNCj4gYW5kIHVz
ZSBjaGFubmVsIDAuDQo+IA0KPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5j
b20+DQo+IFRlc3RlZC1ieTogUmFmYWVsIEJlaW1zIDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0
b3JhZGV4LmNvbT4NCj4gLS0tDQo+IHYzOiBhZGRlZCBuZXQtbmV4dCBzdWJqZWN0IHByZWZpeA0K
PiB2MjogYWRkIFJldmlld2VkfFRlc3RlZC1ieQ0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiBpbmRleCAyNWY5ODhiOWM3Y2YuLjJlMDUwODNjYmYy
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IEBA
IC01MjksOCArNTI5LDYgQEAgc3RhdGljIGludCBmZWNfcHRwX2VuYWJsZShzdHJ1Y3QgcHRwX2Ns
b2NrX2luZm8gKnB0cCwNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgCWludCByZXQgPSAw
Ow0KPiANCj4gLQlmZXAtPnBwc19jaGFubmVsID0gREVGQVVMVF9QUFNfQ0hBTk5FTDsNCj4gLQ0K
PiAgCWlmIChycS0+dHlwZSA9PSBQVFBfQ0xLX1JFUV9QUFMpIHsNCj4gIAkJZmVwLT5yZWxvYWRf
cGVyaW9kID0gUFBTX09VUFVUX1JFTE9BRF9QRVJJT0Q7DQo+IA0KPiBAQCAtNzEyLDEyICs3MTAs
MTYgQEAgdm9pZCBmZWNfcHRwX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50
DQo+IGlycV9pZHgpICB7DQo+ICAJc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYgPSBwbGF0Zm9ybV9n
ZXRfZHJ2ZGF0YShwZGV2KTsNCj4gIAlzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0gbmV0
ZGV2X3ByaXYobmRldik7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGZlcC0+cGRldi0+
ZGV2Lm9mX25vZGU7DQpuaXQNCnN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zf
bm9kZTsNCg0KPiAgCWludCBpcnE7DQo+ICAJaW50IHJldDsNCj4gDQo+ICAJZmVwLT5wdHBfY2Fw
cy5vd25lciA9IFRISVNfTU9EVUxFOw0KPiAgCXN0cnNjcHkoZmVwLT5wdHBfY2Fwcy5uYW1lLCAi
ZmVjIHB0cCIsIHNpemVvZihmZXAtPnB0cF9jYXBzLm5hbWUpKTsNCj4gDQo+ICsJZmVwLT5wcHNf
Y2hhbm5lbCA9IERFRkFVTFRfUFBTX0NIQU5ORUw7DQo+ICsJb2ZfcHJvcGVydHlfcmVhZF91MzIo
bnAsICJmc2wscHBzLWNoYW5uZWwiLCAmZmVwLT5wcHNfY2hhbm5lbCk7DQo+ICsNCj4gIAlmZXAt
PnB0cF9jYXBzLm1heF9hZGogPSAyNTAwMDAwMDA7DQo+ICAJZmVwLT5wdHBfY2Fwcy5uX2FsYXJt
ID0gMDsNCj4gIAlmZXAtPnB0cF9jYXBzLm5fZXh0X3RzID0gMDsNCj4gLS0NCj4gMi4zOS4yDQoN
Cg==

