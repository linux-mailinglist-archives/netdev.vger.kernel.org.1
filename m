Return-Path: <netdev+bounces-211526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9DB19F04
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A773BD2E1
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A9244673;
	Mon,  4 Aug 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vu2Ybxkq"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE06238C08;
	Mon,  4 Aug 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301040; cv=fail; b=dkvfhuiCkvqt6c31PnHPuTFINP05PWzGyFE0/Qqby6tWYDfEcLv9ZAMDRPuD++KvHJa4ysXrawYaU4KmrKja0XVTw8vNSp1HIXJI7xKfT13hijbtZ9V1wFfEubbMNeB6FOcnNbaTGyUFMSCV1zJPuAP6N+xsbgeTHFs0h8i0wu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301040; c=relaxed/simple;
	bh=m1DB68ZZZEYEtjgD7WMW28r4NWHtGTQ6dLH1caMvJKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7uOuyd3vQqLeX90Zau677gsSZZA92favMfmOlblJbJLcwyg8uQ1LeZtwpg50E+PfnPY7EDtg8g/ugoAEEcXZL/PTlo9+nIk8XT9h3J3x+x4atYgyFBiSeTM6l3zccVvprGL5x5NgzaEtdYpW/301s1eGW1wX1fOtz/LSMTsY/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vu2Ybxkq; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOeFKpHA4Zo0G3j96RYem2hSaa7/fpWJnGJQ6+BMA4jqy7y54yofULs1PmqSSjW/aKTnNZpG9jiLgz7EjjMaw+d2XIAz4kqQzNWGYPoW0mIcRkJXYkav7UjiGcx0FRCqBTfrUD14hsFUsw1MczjEQ7SW837jg6HhAejTNrV8UfUGKREoqFLmAJ+NVANtNUJShpbvD4KRzvYg9BCj8jNzHqudj44GHhD3lg5L4lTbksjkr1AVAEQ4atMYJxBmd/nKcaKxfSwqoRTesMEKfcjih6IvaTkXeyWZQ4HIMKvmQmInT6EO876MqBj2IclqJub5hhlN4D420Rj0RJQTvVBzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1DB68ZZZEYEtjgD7WMW28r4NWHtGTQ6dLH1caMvJKU=;
 b=e6I1LXEPCc4XrVsKzm+Lm8lwSXGlp/h7qf9QEHRcxe6OVBtblJ8ooVLUx4hKQjmjIHc71JgKEJn0LA+ca6yWvzbeXzp4AugDAhWS+w+PiV9OUGgMbdP37LM4KivTYSJ72e9ZaZZHsGl9JaRWlyNxhpEfOFUO362BE2W3NG4whQnAzLsxTANckttnvQZ2bbY9ggj1l8VchFIKj7pVmZ5Z0Oxdqxm2DiIIs+4fj0yu2cVp2RZX0u6+nuAvz+Tx0MXJfJQ5cYTyRVE5QVahyZazMMRLZaKdLdtuTazABCgsfZDIyi1F8dG+vJ7QzLdVjqIW2h+xYkcZxjESTEix0dihyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1DB68ZZZEYEtjgD7WMW28r4NWHtGTQ6dLH1caMvJKU=;
 b=Vu2YbxkqfS+8FjL3kLacerbZoRtdIEgU6kpS6f1pLbqS8GumOtSJP2dUFqL5K7sf0B37UZi8oxc8MYGClsUoTZPSrLB6gOipKA+Gkt2H7roy4gLVThdVQ5H33wK4ZsHXZ3Xgex0LyUSM+ndcamuz7IsGEuJIn69Jvl5kRwS4DrxYeAq2Dk7WwLUiIIl3bRSzs4gK14J0qrdr9WPmZC0jOx/L8CjUl43ZpUlV1NvbHhrT4Fd/V42Zz9TnGWaJ6qhWCCc/undGoXdfEqq2Mbrl4Rf9CHKqPNMiiWy2QsRvhMEaVsabCQu9sMw4cETzkb6ctgNa6h7SL04J7U5KnKPi5g==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7292.eurprd04.prod.outlook.com (2603:10a6:102:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 09:50:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 09:50:32 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Sherry
 Sun <sherry.sun@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister()
 for cleanup
Thread-Topic: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister()
 for cleanup
Thread-Index: AQHb7LSQLA3TVvNOWUyfSGQrRm03J7RSbSDQ
Date: Mon, 4 Aug 2025 09:50:32 +0000
Message-ID:
 <AS4PR04MB96920BF303B02AF7542A09A3E723A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
 <CABBYNZKN+mHcvJkMB=1vvOyExF8_Tg2BnD-CemX3b14PoA1vkg@mail.gmail.com>
 <AS4PR04MB969274E6E1CD42BC80C1BE61E742A@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB969274E6E1CD42BC80C1BE61E742A@AS4PR04MB9692.eurprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PR3PR04MB7292:EE_
x-ms-office365-filtering-correlation-id: 21fa074c-3b92-4f77-5e41-08ddd33c5a8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUhUVXZRaUlOS2lWb3pGdHEzR3NValVjRFRIblN2U2hBU2NMSStMM1E0SzYw?=
 =?utf-8?B?Z3RnVzZTRUJ1ZEFKWGdmRXp5QzNiVmFieGpVcE50bmlmVnJCTFZvQjEzaUdj?=
 =?utf-8?B?MXJISVE0VnBzWHRqL2hFQ2dOOUpZdXN6aWtjektzczN5VkpVQzRqU0NYdVgz?=
 =?utf-8?B?VUdmRUI4b3h5Vm9CRUxXTWtCT1kxampBL09qNWZDRUlBTUNyZVYvbnlxekox?=
 =?utf-8?B?cmV1RVo2Zmp0czlPaHpUYThNWWVOQU1YbVp6aldabFk5ZFh5TFhyVXFXUzV1?=
 =?utf-8?B?cklxblkwbDNZbzloV3ByR0lwS216SGFsMjIxOXRSTjAzZ1NGQTRiTlAvWjZp?=
 =?utf-8?B?MXF6UG4wQUl2OHdySGxpWUdLRUFHZ0w4c29hRWZ6UFlMSnh0emsrTFNiRzBS?=
 =?utf-8?B?SjFsOXN0c2FhODVVaXRVQi9QUG52RHRJdG5Rek5HeWE5OTFiL3hvNndQSEM5?=
 =?utf-8?B?QUhScW9ubk5CbERVdTRkOVlZVEJTQmcwY3ppYk5TWFpUL2xHd2NiQmRwTit5?=
 =?utf-8?B?UDk2UGdxVTFlNStkcXRWR2xLQ3NTeUZ6RGRlLy85WmxVbnBNLzExdlN4ZlZX?=
 =?utf-8?B?c21ZZTlpdVVPK2NBTmkwRDhuMmFZOGM4MkZLSGwwWUZFOURXVFJKbnRXdTZD?=
 =?utf-8?B?cUhsRmEwMFFINnZTdGRIdDRkc1RiSE9lLzgwcDFpYWRUVzljOGptQWV5THBv?=
 =?utf-8?B?dmV0MFJmaDhZenEreWROcld5NjI4N2FQbXduNG5GTmhwNElZY1E3VUpPNlZ1?=
 =?utf-8?B?a0RGaXAzWGM5d0kzbVdONndCeHRmQXlmYVNudWVUWjFOMU0wWkc3ZVdZZTYz?=
 =?utf-8?B?U1RzUVphL0tsOFF4NFc2T3FXMG9IVEl4cUNwa0VFdWhlRmV2MTMyTStiU0ti?=
 =?utf-8?B?ZDF1RzRUQUkwQTlIY0JhWDZsbGhpSTNhNFh3V0tvejBsSXYzY0I3NVg0bUVn?=
 =?utf-8?B?eEdyR3c3cldneXpCRDFTcHljZ3BQeitGN1hNcmN1WEVuc2JocWZLdDFWd3Zs?=
 =?utf-8?B?dFhrRUxJSGl6SlljZU1GTUhJYUhoUS9pZ0hKZU1OT25VMjhVSUdaM3lQVm1M?=
 =?utf-8?B?Sk5oZGdwVEVEOW5Rc1FtdE5UdjdRZmxJdmQweWdzY2ZZVFN4MlhUZjg0WG9I?=
 =?utf-8?B?YkJxa3FoMWc0VVRCRFFTU2ZQL0hGejJudVRYSkp1a29LY2c1Qm4rLzZjd1cx?=
 =?utf-8?B?ZTlDd2UzcHc4Q3RLNXg4WEd6QStseFdBV211bW9XcE5vdzJsSzR4ZVppT3hU?=
 =?utf-8?B?aDFCaGZWZW1xWHFZTjRjVmhuYS9RUDBWK0g5dU5lZ1kwNVhuM2g1U0l2dXUr?=
 =?utf-8?B?MHN0aHEwVnNoUTlSa1RLU0I1NndLT3VrRzNmQXd4YmVIdzk1VXRieXJkeVBX?=
 =?utf-8?B?ZFB2ZXdpemNPNFpmK2ovRjgrS0JiaTAyNnh4TmQ2dHZEYnZBemxKNlZmNW05?=
 =?utf-8?B?UG5Zd2Z6QkZPQ3M4ZyszN1NDT0luMFY0V2RPZEhqdlBOU3ZjOTJZNEU2UXRN?=
 =?utf-8?B?TUxSd0c2cFNieXNadk5jTjdLK1JsUDRwOUUwZUViRWJLUHlUSXVYN2lsdUNy?=
 =?utf-8?B?MXl2Z3daWmpvZCtxcFJSblMwU0s0OUNFNm5PWEVSQkJvZk42VU9OVEJ2SU00?=
 =?utf-8?B?MTl6ajh6eUhDR3hRQ2FPTnZMWGc2c2Zwc25WTFBWeThlKzRYcHBhWWRsZmFx?=
 =?utf-8?B?bU9iTnpHcFQ2bVV3L3Ftc3RoeWl4c25LRnFFNUtQT2g1Y1l4OHFVREhQYVFq?=
 =?utf-8?B?NUl6cmhWeStZNVVSZVpJY0tLK2cxdUt0YkI2Nmx1cjdVcGlkNVlLVHBFWFhR?=
 =?utf-8?B?ODk5Q25URVRJOXVuRStzSUVEUTdGRHZ6ci9kU0RLdzBqc3FqcC9ETXUySE94?=
 =?utf-8?B?ejA2aktoZjYyblBwazh1MFJ1UUUyYWpWVnBpNk9FMkxqeXErUHZKTFk2TTFW?=
 =?utf-8?B?L1RRNWVYRVZXS01mWnEvajJOWGM5MmlXRnJ4aEZ0by9BRS9iaFl6cTZPODhF?=
 =?utf-8?Q?oCIRswEn0O4RntPKQzPD0c4l+EDVHg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEp3WFZpUWIvMXVsQmR2bnl2ZVo3K2xIcTZ2MnRtY3R3M1hDaWlNRW5DWFVH?=
 =?utf-8?B?MmordGF0eGhsZnFSSUlXekhVa3k2Qnh4K0hlY3htd01YVEYxODR2bjhheXJi?=
 =?utf-8?B?ZnpmVkFnN09zRlpIODFDUW8rblJ2c3N1cVNIQTZ6SlBMUWpQYjBBQkdJK2JN?=
 =?utf-8?B?UUMzb1BHaWZvQVViQXNEU01yTFBuU2I2SG9URkowcEFaWXBabk5XUFBzbFdx?=
 =?utf-8?B?cXRPRmp4OXQ4MGVqc0NkcStEa3hKelNXYldGZi9jZUVFakMvdmlTbGxEcTNV?=
 =?utf-8?B?cFRpT2p3ejhwZHg1WFNoYklpbTd2MzVvUHlKTC9RcFNNaVVsTER1ZGpkMU1i?=
 =?utf-8?B?bjgxOWgzM0hVcE9CNkxFMFByT1dUR1dqbkdoVTVkZVJkWjlQd2liUk9OZ0d4?=
 =?utf-8?B?c2RxdDU4UmxkbHI3ZjE5dWpvYmllSGgyVUhWL1NkMG9SU1dWNzNLNjhPeUg4?=
 =?utf-8?B?VGc0UVJ3bmdyNllIQ1VDSmVnQkNhTVNtUlJWeGhOWUlKNXRYaFF3UkVkemRi?=
 =?utf-8?B?V2xvdVNCTjdZQzVkTXVYeGk5Z3RJTy9RQldDeHBMMW02aDVjWXFwRGRpRWhi?=
 =?utf-8?B?NnlYSFBJRnhvT2Q1czFBNlpwRVk5YWllZG1ySnRjZVRySkFZaTZjWFdETmhW?=
 =?utf-8?B?SEcvZ3hyMjJ3dXNEOHF6cU1TakdHeVhWTzlRTFdjUU9lWmJZTGpYanBtWDFB?=
 =?utf-8?B?RlpkWVZ1dmZ2NG5WN2FlUXZYeHJ1ZlEzd0NEVkJwNSt1aDRkSENFM3hSYmR0?=
 =?utf-8?B?M1h0c3V6Vk0wanpLcVgrK2hqdENCbEVudkFYNDZQMlRuU2gydWlPS3RyVHpC?=
 =?utf-8?B?NG51dDhEQU4zdGVnNUZUVkQvcEJydnAraTNhNUxBZTZ0VFpRVS9wTVVnSVBn?=
 =?utf-8?B?U1hKYSswaStoSGMyenZSWHBBdnl6Tzh6cU9TUzRvV1dmczNlREhmZjZwNjlm?=
 =?utf-8?B?OEl0Ry9DTVMreG5nNkRxWUFTVWZyK3JoSFA4YUxjei8yNloxRDVYeHN6MU11?=
 =?utf-8?B?STJCd3lEcjJTelU3c3JJWnlDYXZ6c3k1NE03R0NQSXRoTkhBZHhqSW9TUVVS?=
 =?utf-8?B?R2hJaGtOSjBWYm55OVVHbTdxa3Z2Ui8rQTFISEg0RlpZbGFYNzdiMFR0MjJa?=
 =?utf-8?B?OHN6TG1YVERFKzJOWWpYcmRVSkZlN1NsTHVCNXdKODlSL2JIblIyUGFza2R6?=
 =?utf-8?B?c1NLRGMxUHFZeWhTTzhXN2NSM2ZDMi9yWEpHL2FWTHE5WlJMeDB3VEp3OVo3?=
 =?utf-8?B?R054c0pOaElvMnVkTTM1d3BHbHJFV0txMWRXaHpDazQ2V1B6czRjYU5QOUFE?=
 =?utf-8?B?QzJwMG1OTjJkdnV6aWVEeXpCenk3dHJMOG9IZmhaMjFXT3VEVDdiUTFXQnJs?=
 =?utf-8?B?WENQUG9SVDF2QmJTbnVROW1XaGJQVlUreGlXTVBhUWJaZDJQYTYrQVZhVWEy?=
 =?utf-8?B?YlhyVXpaekJXeU1tVTRuSmVMU1crdEJXNDNlTTBaV01UTVhFR1BVNnV3Z3NL?=
 =?utf-8?B?YnlEWVhyTmh4Q0l3L1ZEUUw2Rm9hZVN6Mkgrb1V6YlJuS0JzTjl4TnFvWWFC?=
 =?utf-8?B?dUVnR1BKRktOd2tDdmJSTjhmSkhuZU1DRzM5MHVkRXFEOTBFMkxCM0pheFFW?=
 =?utf-8?B?NU9heUp4cFc1KzloLzN6TmtHeDBqVVphblI0OUpjcmQ2Q0ZWZUpscXh6aVFk?=
 =?utf-8?B?OEZEdjh6NWhMc2ZtV2xuZ0d0V2MvUXA0eTAyRU5zd1hSWFBqZHZ0OGhtRUNJ?=
 =?utf-8?B?QUxFZFdweU80amhpcG1WSGhZc1k4Vi9nOGV6SXFwbXl3emRJY0dkajdhNWpH?=
 =?utf-8?B?R0VNSW11N2l3Q2toQ1MydVgxV0lwWXJSQ2J0dENIcUppTHFpN3RHZTFUeS9j?=
 =?utf-8?B?MEdNSk9OQWVnZE44VlI1Z1RoWjZ1V0t5R0x4eVduanVNMzNqQmkxcHFkdWRW?=
 =?utf-8?B?MTEwbW5CcG9qVG1HT0N2Tzc3Y3VYL2QzaW1WeC9VK2E4M2s1V1V3allNTDF3?=
 =?utf-8?B?STh2R09GbmN5aWtzVWlGSGIxNnZVbTNsNXg1YlpzNlNrN0tpYmJueUpCbTBF?=
 =?utf-8?B?TCtsRTMrMWRtTENuRExMVGVlUldUdEtwalM0enp6cUdNU3FUZDh6NGlNZkMr?=
 =?utf-8?Q?/vJq2DkDAJxEYM1vJLSO0kbhj?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa074c-3b92-4f77-5e41-08ddd33c5a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 09:50:32.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQZpKgSG4kuCzs/KI/znwY5SathP6Qy2ArqukHaIvFR5pL/pGweE9LaapsqAR0sG34AliduE/uia63h3Rf6ZRtLl0XszL1V6MgAQWIa/ui8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7292

SGkgTHVpeiwNCg0KQSBmb2xsb3ctdXAgb24gbXkgcHJldmlvdXMgcmVwbHkuDQoNCkxvb2tzIGxp
a2UgdGhlIGR1bXAgbGlmZXRpbWUgaXMgZml4ZWQvaGFyZGNvZGVkIHRvIDUgbWludXRlcyBieSB0
aGUgZGV2Y29yZWR1bXAgYmFzZSBmcmFtZXdvcmsgb24gcHVycG9zZS4gQW55IGNoYW5nZSB0byB0
aGlzIGZyYW1ld29yaywgdG8gYWxsb3cgYnRueHB1YXJ0IGRyaXZlciBjb250cm9sIHRoZSBkdW1w
IGxpZmV0aW1lIG1heSBub3QgZ2V0IGFwcHJvdmVkIGJ5IGRldmNvcmVkdW1wIG1haW50YWluZXJz
Lg0KaHR0cHM6Ly9naXRodWIuY29tL2JsdWV6L2JsdWV0b290aC1uZXh0L2NvbW1pdC8zYjljMTgx
YmNkZTg1NTVjYTgxYjIzOTRjMmRjMjIwMWNlZmMyZGQ0I2RpZmYtZGQyOTcxYTRhYmM1ZGJhZDJi
MDNjNDJmMjViMmQ4ZWY5ZDk0MTcxODkwNzAwMTI1MDBmMzE1ZWUyMmZkMTdmOQ0KDQpBbnl3YXlz
LCBmb3IgQmx1ZXRvb3RoIGRyaXZlcnMgdGhhdCByZWxheSBvbiBoY2lfZGV2Y2QgbGF5ZXIsIGNh
bGxpbmcgdGhlIG5ldyBoY2lfZGV2Y2RfdW5yZWdpc3RlcigpIEFQSSBmaXhlcyB0aGUgaXNzdWUg
bWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgcHJvcGVybHkgY2xlYW5pbmcgdXAgdGhl
IGR1bXAgZGF0YSBpZiBkcml2ZXIgaXMgcmVtb3ZlZCBiZWZvcmUgdGhlIGR1bXAgbGlmZXRpbWUg
aXMgY29tcGxldGUsIG5vIG1hdHRlciB3aG8gY29udHJvbHMgdGhlIGR1bXAgbGlmZXRpbWUuDQoN
ClBsZWFzZSBsZXQgbWUga25vdyBpZiBJJ20gbWlzc2luZyBzb21ldGhpbmcuDQoNClRoYW5rcywN
Ck5lZXJhag0KIA0KPiBIaSBMdWl6LA0KPiANCj4gVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhp
cyBwYXRjaC4NCj4gDQo+ID4gT24gVGh1LCBKdWwgMywgMjAyNSBhdCA5OjE34oCvQU0gTmVlcmFq
IFNhbmpheSBLYWxlDQo+ID4gPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IFRoaXMgYWRkcyBoY2lfZGV2Y2RfdW5yZWdpc3RlcigpIHdoaWNoIGNhbiBiZSBj
YWxsZWQgd2hlbiBkcml2ZXIgaXMNCj4gPiA+IHJlbW92ZWQsIHdoaWNoIHdpbGwgY2xlYW51cCB0
aGUgZGV2Y29yZWR1bXAgZGF0YSBhbmQgY2FuY2VsIGRlbGF5ZWQNCj4gPiA+IGR1bXBfdGltZW91
dCB3b3JrLg0KPiA+ID4NCj4gPiA+IFdpdGggQlROWFBVQVJUIGRyaXZlciwgaXQgaXMgb2JzZXJ2
ZWQgdGhhdCBhZnRlciBGVyBkdW1wLCBpZiBkcml2ZXINCj4gPiA+IGlzIHJlbW92ZWQgYW5kIHJl
LWxvYWRlZCwgaXQgY3JlYXRlcyBoY2kxIGludGVyZmFjZSBpbnN0ZWFkIG9mIGhjaTANCj4gPiA+
IGludGVyZmFjZS4NCj4gPiA+DQo+ID4gPiBCdXQgYWZ0ZXIgREVWQ0RfVElNRU9VVCAoNSBtaW51
dGVzKSBpZiBkcml2ZXIgaXMgcmUtbG9hZGVkLCBoY2kwIGlzDQo+ID4gPiBjcmVhdGVkLiBUaGlz
IGlzIGJlY2F1c2UgYWZ0ZXIgRlcgZHVtcCwgaGNpMCBpcyBub3QgdW5yZWdpc3RlcmVkDQo+ID4g
PiBwcm9wZXJseSBmb3IgREVWQ0RfVElNRU9VVC4NCj4gPiA+DQo+ID4gPiBXaXRoIHRoaXMgcGF0
Y2gsIEJUTlhQVUFSVCBpcyBhYmxlIHRvIGNyZWF0ZSBoY2kwIGFmdGVyIGV2ZXJ5IEZXDQo+ID4g
PiBkdW1wIGFuZCBkcml2ZXIgcmVsb2FkLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5l
ZXJhaiBTYW5qYXkgS2FsZSA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGluY2x1ZGUvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5oIHwgMyArKysNCj4gPiA+ICBu
ZXQvYmx1ZXRvb3RoL2NvcmVkdW1wLmMgICAgICAgICB8IDggKysrKysrKysNCj4gPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2NvcmVkdW1wLmgNCj4gPiA+IGIvaW5jbHVkZS9uZXQvYmx1
ZXRvb3RoL2NvcmVkdW1wLmgNCj4gPiA+IGluZGV4IDcyZjUxYjU4N2EwNC4uYmM4ODU2ZTRiZmU3
IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2NvcmVkdW1wLmgNCj4g
PiA+ICsrKyBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9jb3JlZHVtcC5oDQo+ID4gPiBAQCAtNjYs
NiArNjYsNyBAQCB2b2lkIGhjaV9kZXZjZF90aW1lb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
ayk7DQo+ID4gPg0KPiA+ID4gIGludCBoY2lfZGV2Y2RfcmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYg
KmhkZXYsIGNvcmVkdW1wX3QgY29yZWR1bXAsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
IGRtcF9oZHJfdCBkbXBfaGRyLCBub3RpZnlfY2hhbmdlX3QNCj4gPiA+IG5vdGlmeV9jaGFuZ2Up
Ow0KPiA+ID4gK3ZvaWQgaGNpX2RldmNkX3VucmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYgKmhkZXYp
Ow0KPiA+ID4gIGludCBoY2lfZGV2Y2RfaW5pdChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdTMyIGR1
bXBfc2l6ZSk7ICBpbnQNCj4gPiA+IGhjaV9kZXZjZF9hcHBlbmQoc3RydWN0IGhjaV9kZXYgKmhk
ZXYsIHN0cnVjdCBza19idWZmICpza2IpOyAgaW50DQo+ID4gPiBoY2lfZGV2Y2RfYXBwZW5kX3Bh
dHRlcm4oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IHBhdHRlcm4sIHUzMiBsZW4pOw0KPiA+ID4g
QEAgLTg1LDYgKzg2LDggQEAgc3RhdGljIGlubGluZSBpbnQgaGNpX2RldmNkX3JlZ2lzdGVyKHN0
cnVjdA0KPiA+ID4gaGNpX2Rldg0KPiA+ICpoZGV2LCBjb3JlZHVtcF90IGNvcmVkdW1wLA0KPiA+
ID4gICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtz
dGF0aWMgaW5saW5lIHZvaWQgaGNpX2RldmNkX3VucmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYgKmhk
ZXYpIHt9DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGlubGluZSBpbnQgaGNpX2RldmNkX2luaXQo
c3RydWN0IGhjaV9kZXYgKmhkZXYsIHUzMg0KPiA+ID4gZHVtcF9zaXplKSB7DQo+ID4gPiAgICAg
ICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3Ro
L2NvcmVkdW1wLmMgYi9uZXQvYmx1ZXRvb3RoL2NvcmVkdW1wLmMNCj4gPiA+IGluZGV4IDgxOWVh
Y2IzODc2Mi4uZGQ3YmQ0MGUzZWJhIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L2JsdWV0b290aC9j
b3JlZHVtcC5jDQo+ID4gPiArKysgYi9uZXQvYmx1ZXRvb3RoL2NvcmVkdW1wLmMNCj4gPiA+IEBA
IC00NDIsNiArNDQyLDE0IEBAIGludCBoY2lfZGV2Y2RfcmVnaXN0ZXIoc3RydWN0IGhjaV9kZXYg
KmhkZXYsDQo+ID4gPiBjb3JlZHVtcF90IGNvcmVkdW1wLCAgfSAgRVhQT1JUX1NZTUJPTChoY2lf
ZGV2Y2RfcmVnaXN0ZXIpOw0KPiA+ID4NCj4gPiA+ICt2b2lkIGhjaV9kZXZjZF91bnJlZ2lzdGVy
KHN0cnVjdCBoY2lfZGV2ICpoZGV2KSB7DQo+ID4gPiArICAgICAgIGNhbmNlbF9kZWxheWVkX3dv
cmsoJmhkZXYtPmR1bXAuZHVtcF90aW1lb3V0KTsNCj4gPiA+ICsgICAgICAgc2tiX3F1ZXVlX3B1
cmdlKCZoZGV2LT5kdW1wLmR1bXBfcSk7DQo+ID4gPiArICAgICAgIGRldl9jb3JlZHVtcF9wdXQo
JmhkZXYtPmRldik7IH0NCj4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChoY2lfZGV2Y2RfdW5yZWdp
c3Rlcik7DQo+ID4NCj4gPiBUaGUgZmFjdCB0aGF0IHRoZSBkdW1wIGxpdmVzIGluc2lkZSBoZGV2
IGlzIHNvcnQgb2YgdGhlIHNvdXJjZSBvZg0KPiA+IHRoZXNlIHByb2JsZW1zLCBzcGVjaWFsbHkg
aWYgdGhlIGR1bXBzIGFyZSBub3QgSENJIHRyYWZmaWMgaXQgbWlnaHQgYmUNCj4gPiBiZXR0ZXIg
b2ZmIGhhdmluZyB0aGUgZHJpdmVyIGNvbnRyb2wgaXRzIGxpZmV0aW1lIGFuZCBub3QgdXNlDQo+
ID4gaGRldi0+d29ya3F1ZXVlIHRvIHNjaGVkdWxlIGl0Lg0KPiBBcmUgeW91IGFyZSB0YWxraW5n
IGFib3V0ICJoZGV2LT5kdW1wLmR1bXBfdGltZW91dCI/IGl0IGRvZXMgbm90IGNvbnRyb2wNCj4g
dGhlIGR1bXAgbGlmZXRpbWUuDQo+IEl0IHNpbXBseSBtYWtlcyBzdXJlIHRoYXQgb25jZSBGVyBk
dW1wIGlzIHN0YXJ0ZWQsIGl0IHNob3VsZCBiZSBjb21wbGV0ZQ0KPiB3aXRoaW4gImR1bXBfdGlt
ZW91dCIgc2Vjb25kcy4NCj4gDQo+IFRoZSBhY3R1YWwgY2xlYW5pbmcgdXAgb2YgZHVtcCBkYXRh
IGlzIGRvbmUgYnkgdGhlICIgZGV2Y2QtPmRlbF93ayIgd2hpY2gNCj4gaXMgZGVsYXktc2NoZWR1
bGVkIGJ5IDUgbWludXRlcyBpbiBkZXZfY29yZWR1bXBtX3RpbWVvdXQoKSwgd2hpY2ggaXMgcGFy
dA0KPiBvZiB0aGUgZGV2Y29yZWR1bXAgYmFzZS4NCj4gDQo+IFN1cmUsIHdpdGggc29tZSBtb2Rp
ZmljYXRpb24sIHRoZSBkcml2ZXIgY2FuIGNvbnRyb2wgdGhlIGR1bXAgbGlmZXRpbWUNCj4gaW5z
dGVhZCBvZiBoYXJkY29kZSBERVZDRF9USU1FT1VULCBidXQgZHVyaW5nIGRyaXZlciBleGl0LCB0
aGVyZSBpcyBhIG5lZWQNCj4gZm9yICJkZXZfY29yZWR1bXBfcHV0KCkiIEFQSSB0byBiZSBjYWxs
ZWQgYW55d2F5Lg0KPiANCj4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgb24gdGhp
cy4NCj4gDQo+ID4NCj4gPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgaGNpX2RldmNkX2VuYWJsZWQo
c3RydWN0IGhjaV9kZXYgKmhkZXYpICB7DQo+ID4gPiAgICAgICAgIHJldHVybiBoZGV2LT5kdW1w
LnN1cHBvcnRlZDsNCj4gPiA+IC0tDQo+IA0KPiBUaGFua3MsDQo+IE5lZXJhag0K

