Return-Path: <netdev+bounces-131757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165998F71B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64BAB20C92
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D11ABECF;
	Thu,  3 Oct 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXsAVo2B"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5047F5F;
	Thu,  3 Oct 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984258; cv=fail; b=GZ/IrzPf4zCdUjRiLWusuN+zHpwF3yvkOocQERtmRJH561XCpn2Zg71bll434kt7Zy20PyyJ7vp0+AEc/483aazFZpQuceRpKLy25y8sEGa/Bnv53FQHy+UQxHM+PYGHmkPxgpeoHrfZYqSKZ+dcrgLe3YKUPTFQed20ZSUOrbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984258; c=relaxed/simple;
	bh=rXvUmPWPNpKJWMp62gW9yHbZHuBekeZT+OmP/lzz3Yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSkJInfpI2Sp1Jt6C49zopaTqUT8jbNxUrj7PI6XoEDEr7VxHJWwISXwJm4qnH/ks25muwQ5x5u9nz9LPhUfHC5e7rJGHQcQ2STXNLb9v0GkM9j6Pu6eVC97B9Gm0HoYshb8P+DuMHt0++yE2KCX2bEN/ft8CjBwz4eXHJ8Szqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXsAVo2B; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkl/5AIe+X523XWVhRXmcfpdcQ3f1jX4PAtMbUUhXJWEdSImLQxdw/Hnna7e8SY+Q5wy1BHDubPM41EptE5fkviiREhdk4uD9sEsmopNOwkx6Mo9IE39jOiDUU6V9QMAJ4Wx+kjiLIfuWWtSvzjCvsA4EjLs2NY0tl0Nk/9DNb2ci8yzuzMEFDhFemHibw0ukbh1eNv89G7Q6Z1Z5RhEFvrW5TvwzQi7OI7VAFql49CYshPtEXBM7waSz474XJizPcZkbH0DIHgTaw5D46jl6gMRDP0hBVGsRWjq4c6A2oEWE3NLR+AlhxyEgfJW5A/y7gLL3ETQmwzXT4LrCIc8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXvUmPWPNpKJWMp62gW9yHbZHuBekeZT+OmP/lzz3Yo=;
 b=m36/pn/JczAJvqnWbhIYdnChSpBzyodzJd6YWWXinNMs0pnGtc9kkQ3OiVuIIGwHcTMAw5KJ9ANWOkVKT3z1GmAKmOxNxjnHpzRGiHdhniAW+AOEBPd1odMzitEh9Eqrpi5ylk6sAiBaCzVezCBzOme3ru3IbWj3xdu61oQEeFtJzZQopo7C7p3irANxoHyetdNdsEHKtZlaexA3TWe9ziiQAQOHFS+zXGOHyi++aPmTm5Uh9IUHaUBrOZ5XD6i6KXL4t9NpxuKjV/TCr0WEWvTLNnbf/3keRzooNPdDdwjHFIrjjHwmXP1dSmTnWCt68aQpZif48neGIBG3q7BLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXvUmPWPNpKJWMp62gW9yHbZHuBekeZT+OmP/lzz3Yo=;
 b=kXsAVo2B5GoKw2Un7YmEpm9n+56BCX4odHwOre51hCuRDt89r4WaZTDFAFMYymux6UpzDecfhZ5LS7C/LotkI52kfm5ES8EWdkGmZ351X2qS+QzvVgmU+cwva6Ps/EJui3qU4xN64SqH+tyHwjl46shEYuexoDngmzakrt77wOtjsbhiFTSc+hR+a7Rw6PxPot0Wz/+MugVbNKa82LytuvLpyLfQx0HLQ59ncUXMFrGlpW3O+gGpmPRjCWHQ30cMCzL+6/rIuVdoKaMsbfnsLVntB/AVSKwQev1q9cqv48JJn6QNepk3yOAHCVPDK1uvCO8Jtp8gkSGdPDBIwJDGlQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 19:37:33 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%6]) with mapi id 15.20.8026.014; Thu, 3 Oct 2024
 19:37:33 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Rosen Penev <rosenp@gmail.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
Thread-Topic: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
Thread-Index: AQHbFEf9dCiTXoYOJkSDUK3m0fZNOLJzE1YAgADGyACAAZIo8A==
Date: Thu, 3 Oct 2024 19:37:33 +0000
Message-ID:
 <AS8PR04MB88490FFC1ED17B686DC1CA5296712@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
 <20241001212204.308758-6-rosenp@gmail.com>
 <20241002093736.43af4008@fedora.home>
 <CAKxU2N8QQFP93Y9=S_vavXHkVwc7-h1aOm0ydupa1=4s9w=XYA@mail.gmail.com>
In-Reply-To:
 <CAKxU2N8QQFP93Y9=S_vavXHkVwc7-h1aOm0ydupa1=4s9w=XYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DB9PR04MB9937:EE_
x-ms-office365-filtering-correlation-id: 8818a54f-757a-43b3-3653-08dce3e2d3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0Vzb1VQeGtTU0Z4TFNtK2pqbGordHowdlBJUHZQeDRrakVkZ1Fob282bmFs?=
 =?utf-8?B?eStVa3IxZEc5eDh4MHRYTW52RTNkcTVTeWkrMWV4Y2Vlcjd4dGlwMmRicDJP?=
 =?utf-8?B?NlkrRlpjc0NhT0FORk9LZ3VCcXFBOHI2cWdvaGJPRFVQanlKVUEzWVVLOWpr?=
 =?utf-8?B?d3BMais2QXlyRXFibjVDZ1Y2cXhTdjk4Wko1YVlucTdaOCsxOGdqZ3NBYlVs?=
 =?utf-8?B?QmU2L1lmb0NlSzNFTkgvUnRQdzN1R1pqcHpNSDNoRVczTUxsM1g4RXA5cWVk?=
 =?utf-8?B?N1llMzllU2RJVTRFQ3RYVWgvVjFTSHk0YWZORUFWLzZjNkw0VyswbHdxMloz?=
 =?utf-8?B?NzZHSmY1YUZrSEFEUmx0L2xyTE9hU1g3L1RvSGxvenJVclVDbkxSUENYenZF?=
 =?utf-8?B?S3NVOVNwd2t2eEk5SVdrWkJ0cGNPUUJncVJFYllmVE43R1lQZFdMWnl2YUcz?=
 =?utf-8?B?MlFaTEgveTZwR1FVKzhEQ0kzekEzd0hlKzd2U1dTbjAyRUpheWx3a25XYWlx?=
 =?utf-8?B?NTVyU2ZUV3VhWGs0dDVROVMrN1RYdm5FRUR4c0dCR1lzK2tpQjIzeHFmeHlN?=
 =?utf-8?B?V0sxL0Exam1sMWhMNUliVGd0OTBXd0RNdHIveDhSU3pXb3ZYdmlvbEw4Z3BK?=
 =?utf-8?B?dlBRSjBiUDZSQWgzZjJ1b0tHOE5JSisvVGttTTE5NDRVK3BTNi91TGFtYU1D?=
 =?utf-8?B?TTFIR2YrZGZEOWtUNWNsaGhFRmtvK241M2ZXeWNvbE4zN2docTBPT2JuNENq?=
 =?utf-8?B?eFRCMWk1SmhMbWFXd1BlMmEyaW5VL0FDdytGT2doOE9nNFhuRmpYOUg0dGpk?=
 =?utf-8?B?ZllmR2tsV21hV2VPdzErSGpFVVVBMjdRNzFCQitVajlWU3JzSTNuUmVUWTNs?=
 =?utf-8?B?bTZaUGo4SEdiOUpHRlVWcjMxZ1IyS2pZOXJUNVUzcWQwZXZKMHRIR3BpVm9w?=
 =?utf-8?B?NGZ3b2NOc2VTM2M2cUNOaTFQTmIzSkVPdlovejI4OW8rVzVLWm11R1ZZM3Ru?=
 =?utf-8?B?MGNDUEt0OFBMM2J4aWV0WmtXczc2eG5EbVc2aGU5NlRQZTJRamJwUEt3SFFR?=
 =?utf-8?B?dUJkblZvUVRWZzk5d3dteUM0U2FYVlUwZEVJNjJYVkFIckxDOE1naUppRjNu?=
 =?utf-8?B?L1pDazVpcVBtZ0pRMUN0Z2VUWkxidUZzSUUxVk1kdFh5UHhwOUVuV1pTOU1X?=
 =?utf-8?B?M28xSjRaR1FJelBFVFlyQ2VkQk1VOVR6MDEzS21Ec2VBWHRwS1R6RExNZFpH?=
 =?utf-8?B?OUhKNkVpM3RSOXByamFoMllMSG8zQ09jb0lVSmt4RjN1Y21hMHVxcUJNMHZL?=
 =?utf-8?B?SG4wSklNb2FGTGYvVEIxUGlVaXpQTENmNWV1S1lad3pXR3JZWjJxVFpoWHNo?=
 =?utf-8?B?d3UxZmlZWDR1Z284WVN6SDRteUJZa2NOMFBIWXlOeWMxcG96aXIybE5wK0ky?=
 =?utf-8?B?N1lhcnBCUmd2ekJScjFzNWk1eFpCOUtBZHIyUTN5ejF6TkMveXcyRzNJWDJV?=
 =?utf-8?B?RWZPSXJ1MS9aUXlaTUJJclVHNXBBbzdyZ2x2NU5VOTdRd2dWUDIrbXFsQmxR?=
 =?utf-8?B?VWZFZTErdHUyclpmZGNWaElyT25xOG5Id1hCS1F1TXlzaEVwU21LNHZSV2Yv?=
 =?utf-8?B?UTU4clpQKzRRKzhuaEpKZzVMb3l5dUdpaDBraDliZEoxTDRFTm1BK1doTVR3?=
 =?utf-8?B?ZU82bUJhNWNUVjV2V29Pdm9SN21mQkFUVVpuMExuZUxhWDdzZnZrS2E2dGZ1?=
 =?utf-8?B?Lzg3NHFMVVhIR0xEeVY1TWlXZU5OcTI0S004MmRsQzJFZmVZK1BZS3YzeUtR?=
 =?utf-8?B?cGEyTlRPZHNid0RNbkRsQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWtJYTNKMUJvWjk1ajZJazA5WUMrU3VzOEl5RitqVWF5ZG9mQkpobmt6dGl4?=
 =?utf-8?B?YmdhSDVTcVM3N2l2cFRscWpWOVN0NEJvRjVybWlhNTJjZGROTUJkbHYwUXow?=
 =?utf-8?B?Mk9Ia21kSmlkTldzYVhpQVY5VnJvNnhnTjdpa2dpa3lIT0ZuTDR4eEsxMjRy?=
 =?utf-8?B?Z1prbVBoaloydmFjd3E1SnZiWktvcHNoQlU3NWhMaFNkV0lzNVNNclg2RHNm?=
 =?utf-8?B?MjBkZ1V6ejVTWCtYNm5mdC9uY2xINGY1aGN6WHpKTVZKRmY5am9wSmdOMDJX?=
 =?utf-8?B?MHowVVFPNjJaM1Z5ZW1IdVNERjF5UTVhZW40cDJoQVVpaTZMS2xrSHNuU2Vu?=
 =?utf-8?B?RXh2eEFIOUhJWVBXZFVhTmR2RjdWNDhZdG1OVEdZdXpLTjJKRDJoWkduWUtM?=
 =?utf-8?B?ZlpzZ2lYV0d1b3lWeVRpZDhTdG0wMHBYVkJRY1FvN2o1M1gwUHlacEZjQ3RC?=
 =?utf-8?B?R0FPNG5TZ3k0WlZBamZaQisrRlUzK1ZucXZsRHRzY2l3c1pVMU1Lajc1OFgr?=
 =?utf-8?B?UHFFSUpNckdsMFdiT3RIUnRYUkoxeEFuTWZQOGhMODgvS2JKL3NPNEMySkZ0?=
 =?utf-8?B?RXVNaytpbVc3V1o4NWx6NHRVRERsY1RPZmt4dkpsWlEvRnJpM0JjN1QrOW9t?=
 =?utf-8?B?NW51NHNaN3FQQzZFQ1dkOUZVbjd4MnBjbWEzUkk3Uy9lVG5jVEhtd3Q0OVZ3?=
 =?utf-8?B?SmtFbUJzeUFuUlR4ZEsvVUExOE83V21OaGNtdEY2cHgrNndQU3A4Vmo4WDFw?=
 =?utf-8?B?c1F6K3VrMXdhWGJ2d0pOTDRTc0txcnJEaHhyVnhXbXQ3aGZuRVlENzFkY0sw?=
 =?utf-8?B?c0dleVE1WXFxN1RHKzVhRTRlcVJkelYydjcrNjdhelBhWlJ5KzdmSXV4aGNo?=
 =?utf-8?B?QW9GTHBjQnZYTi8vdHhjNnI5Y0RSYTBQYWxFWnZFMUcrdGw5NlMzOVFSS1Jw?=
 =?utf-8?B?elhuMURVeE9xaVJrRXdwZzNENk56a3Z5YjY0S3FhOTJ2MGlZWDZmZTNQSm9J?=
 =?utf-8?B?VFhGTXR1bHpsL3FRdVNsZ1RDckFxUDlQVTJhWjBvbjBTZm9LMkhxdXkyZVI2?=
 =?utf-8?B?THhRc0l4S2lteW4yN1N3UVFORlpPbUJlU1Zjc0dIOW1raERJQUpjWXkyUDh5?=
 =?utf-8?B?aDFrUXZsUHRYRkl2VjNseDZJQm5EZlkweXFGQTJuS2dYNWlwY0E0MHJLQmx2?=
 =?utf-8?B?Ym1TUEVMVUh3NGhwcldMUlNyalFYVHRmQmRBdzg1dkNGS2o4QmI0TXlCYUk5?=
 =?utf-8?B?MjhWSjRDbkh4cUR1aDBQS2ZZR21SWkFPRVppQW1WdkRVTUxBYVVtZDZKYnk0?=
 =?utf-8?B?dHlxYXo4VEJRUjduTVR1b0pYRmhpZnh0elQ5aXd2YnNhd04xWDlhOVBzd1dI?=
 =?utf-8?B?TjZGQWtwc2hFM3JtblVaMHpNOXFjSU52ZnhGZmdFS1BpWGwzZ1hMY3kvSEs3?=
 =?utf-8?B?L3g3KzRsVFdWTnJmY3pRODBIVG0rK1hzMFdUQ1ArR2lLWWVRYUk2T0JucDNi?=
 =?utf-8?B?bnFaQjJHZXZrYlFScE1UTW1jVVZnWERzSHVEK0dReWJ0VE9FZDZKSXp2YTFE?=
 =?utf-8?B?ZVhQN3VxSndwMVVJbFJTc2F4S2d5TVVmL2U2aEp1K2xNTWNJMFhNVVlIbEcr?=
 =?utf-8?B?SDVXYTVTaUZTeVJKbnZkclJzcENjOGpKb2x2VFBreTd5aUh5dDFsOEIwNzh1?=
 =?utf-8?B?UnlRT2lBY21zRUhBLzBIQ0ZrWit0NlBkdGJDSUJxalpHZ3dxM0xURlpYZ1ph?=
 =?utf-8?B?MTRtYjFTWnlWVXdlRlpWMmRmOTNPM1ltVXV1cjFhZk5rejRxYjRzNG1TbmJN?=
 =?utf-8?B?b3Aya2xPK1dUMFZYczJEMm5VUzhObVNSeEF4M3pjazZtenNvbE01bXNqU0dl?=
 =?utf-8?B?bkJ3Rzc4ZnJSM1psdW1seGxZbXFIRXFGZXUwTUI2YzBkV2NqbU43eHhoamhl?=
 =?utf-8?B?Z1hVeDRzbU12RUsxRk5GRTNEcUUxZWpwOHptV3pQcU94K254dm9CRStRakdM?=
 =?utf-8?B?dkluUk5DMTREVWpDZzFDdm5pdWJyREsxU3habkJyVnZQaFZ0TmNydXFJdlhu?=
 =?utf-8?B?RldDMTR0aE9WR3F6MmJxTiszdjhVTGpuT2x6R2V3VldFZWUzWFhuVHZRL1RQ?=
 =?utf-8?Q?8YlgkaOi07s/uXu83W1yXIYfT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8818a54f-757a-43b3-3653-08dce3e2d3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 19:37:33.5381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI2tdzcLDYp/chi9FwLDOB1PHqGa4vci0fNYYnqLM+TVEispMoy2rR3gezUCR8SnHaktCNGtkPcCFggyUSojIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb3NlbiBQZW5ldiA8cm9zZW5w
QGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIsIDIwMjQgMTA6MjkgUE0N
Cj4gVG86IE1heGltZSBDaGV2YWxsaWVyIDxtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbT4N
Cj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGFuZHJld0BsdW5uLmNoOyBkYXZlbUBkYXZl
bWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVu
aUByZWRoYXQuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpdSBN
YW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0
LW5leHQgNS82XSBuZXQ6IGdpYW5mYXI6IHVzZSBkZXZtIGZvciByZXF1ZXN0X2lycQ0KPiANCj4g
T24gV2VkLCBPY3QgMiwgMjAyNCBhdCAxMjozN+KAr0FNIE1heGltZSBDaGV2YWxsaWVyDQo+IDxt
YXhpbWUuY2hldmFsbGllckBib290bGluLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBSb3NlbiwN
Cj4gPg0KPiA+IE9uIFR1ZSwgIDEgT2N0IDIwMjQgMTQ6MjI6MDMgLTA3MDANCj4gPiBSb3NlbiBQ
ZW5ldiA8cm9zZW5wQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFJvc2VuIFBlbmV2IDxyb3NlbnBAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2dpYW5mYXIuYyB8IDY3DQo+ID4gPiArKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwg
NDkgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9naWFuZmFyLmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2dpYW5mYXIuYw0KPiA+ID4gaW5kZXggMDc5MzZkY2NjMzg5Li43OGZkYWIzYzZm
NzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZ2lh
bmZhci5jDQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZ2lhbmZh
ci5jDQo+ID4gPiBAQCAtMjc2OSwxMyArMjc2OSw2IEBAIHN0YXRpYyB2b2lkIGdmYXJfbmV0cG9s
bChzdHJ1Y3QgbmV0X2RldmljZQ0KPiA+ID4gKmRldikgIH0gICNlbmRpZg0KPiA+ID4NCj4gPiA+
IC1zdGF0aWMgdm9pZCBmcmVlX2dycF9pcnFzKHN0cnVjdCBnZmFyX3ByaXZfZ3JwICpncnApIC17
DQo+ID4gPiAtICAgICBmcmVlX2lycShnZmFyX2lycShncnAsIFRYKS0+aXJxLCBncnApOw0KPiA+
ID4gLSAgICAgZnJlZV9pcnEoZ2Zhcl9pcnEoZ3JwLCBSWCktPmlycSwgZ3JwKTsNCj4gPiA+IC0g
ICAgIGZyZWVfaXJxKGdmYXJfaXJxKGdycCwgRVIpLT5pcnEsIGdycCk7DQo+ID4gPiAtfQ0KPiA+
ID4gLQ0KPiA+ID4gIHN0YXRpYyBpbnQgcmVnaXN0ZXJfZ3JwX2lycXMoc3RydWN0IGdmYXJfcHJp
dl9ncnAgKmdycCkgIHsNCj4gPiA+ICAgICAgIHN0cnVjdCBnZmFyX3ByaXZhdGUgKnByaXYgPSBn
cnAtPnByaXY7IEBAIC0yNzg5LDgwICsyNzgyLDU4IEBADQo+ID4gPiBzdGF0aWMgaW50IHJlZ2lz
dGVyX2dycF9pcnFzKHN0cnVjdCBnZmFyX3ByaXZfZ3JwICpncnApDQo+ID4gPiAgICAgICAgICAg
ICAgIC8qIEluc3RhbGwgb3VyIGludGVycnVwdCBoYW5kbGVycyBmb3IgRXJyb3IsDQo+ID4gPiAg
ICAgICAgICAgICAgICAqIFRyYW5zbWl0LCBhbmQgUmVjZWl2ZQ0KPiA+ID4gICAgICAgICAgICAg
ICAgKi8NCj4gPiA+IC0gICAgICAgICAgICAgZXJyID0gcmVxdWVzdF9pcnEoZ2Zhcl9pcnEoZ3Jw
LCBFUiktPmlycSwgZ2Zhcl9lcnJvciwgMCwNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ2Zhcl9pcnEoZ3JwLCBFUiktPm5hbWUsIGdycCk7DQo+ID4gPiArICAgICAgICAg
ICAgIGVyciA9IGRldm1fcmVxdWVzdF9pcnEocHJpdi0+ZGV2LCBnZmFyX2lycShncnAsIEVSKS0+
aXJxLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdmYXJfZXJy
b3IsIDAsIGdmYXJfaXJxKGdycCwgRVIpLT5uYW1lLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdycCk7DQo+ID4NCj4gPiBUaGlzIGlzIGNhbGxlZCBkdXJpbmcg
b3Blbi9jbG9zZSwgc28gdGhlIGxpZmV0aW1lIG9mIHRoZSBpcnFzIGlzbid0DQo+ID4gdGllZCB0
byB0aGUgc3RydWN0IGRldmljZSwgZGV2bSB3b24ndCBhcHBseSBoZXJlLiBJZiB5b3UNCj4gPiBv
cGVuL2Nsb3NlL3JlLW9wZW4gdGhlIGRldmljZSwgeW91J2xsIHJlcXVlc3QgdGhlIHNhbWUgaXJx
IG11bHRpcGxlDQo+ID4gdGltZXMuDQo+IEdvb2QgcG9pbnQuIFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8gbW92ZSB0byBwcm9iZT8NCg0KSGVsbG8sDQpNYW55IGRyaXZlcnMgZG8gcmVxdWVzdF9pcnEo
KSBhdCBkZXZpY2Ugb3BlbigpLCBpLmUuIEludGVsIChlMTAwMCwgaWdiKSwNCkJyb2FkY29tLCBN
YXJ2ZWxsLCB0byBuYW1lIGEgZmV3LiBBbmQgSSB0aGluayB0aGF0IGNhbGxpbmcgcmVxdWVzdF9p
cnEoKQ0KYXQgb3BlbigpIGlzIGEgZ29vZCBwcmFjdGljZSBhdCBsZWFzdC4gRG8geW91IHBsYW4g
dG8gdHJhbnNpdGlvbiBhbGwgdGhlc2UgZHJpdmVycw0KdG8gZGV2bV9yZXF1ZXN0X2lycSgpPw0K
DQotQ2xhdWRpdQ0K

