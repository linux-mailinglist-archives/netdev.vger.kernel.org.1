Return-Path: <netdev+bounces-97911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74278CDF29
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBCA1F238ED
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17BBE48;
	Fri, 24 May 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i++UZnx0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B99816;
	Fri, 24 May 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716513824; cv=fail; b=j685qByWgPAm2F0ZNdsfVsVZeHC/CeaTb041HEAr2vWDe/GmKfPJgd7N1fgtmXC0NovrMaKwlZxyW6jHXLinYYChDyHApKovP2Xt69c5strPvKLn/Es6xkX3tKxsnv7z6gitt+DELiGYEa9rvD71pm745neGmr71BE/8dKuPLUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716513824; c=relaxed/simple;
	bh=/DY7Fk/pYYtRw9pMlcFkLxsV4Cd8jK1+s9D6Cx2oM+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OqGD9z2pUNfAYPaCd126BpSGAwWeNRJ3SI/5yVet7rDOgqAkIpLqihh7cBOzUcmkGRJaw+RD3/leradiz4G9FkpUqhnBUZng/jZYIDn2A0eRvrT9CqxFqenJ8J7Tix+UtO84N7bovqLFKTuEeGFhyifGv0HYVFJFhFxSNZSODMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i++UZnx0; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWOfwhDxosFejP7eciRe3ad2ARR4wmgfwPlMwFwEDT7dQyULZDW12ibw58UB6w6Fun58e+z0q1Oc5aYI+y+NtLUxg0UCny7rwFuFv5uAuu2XPzCMWzTWmHS2R2nA4eeU0tPuuHjAvjn/mzx7FX2rrxCbEo3W4OIU1LLouPL71V01zY7M2drdkI1eHLQ2zI1K3/m4eXsO7KRh1wSJB+BtUlNgSpzZvy55Wc+3diXXfgiZFndWjZUgEbOE5ig38GXtcdHvWl7ZGHwf/IYQGZTlpBcpegPUXLyohFrk6gNSgpU91OQoWvCcEaMGUhWEDiZSRGR1vJ6Cwf8QoBnKjIrwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DY7Fk/pYYtRw9pMlcFkLxsV4Cd8jK1+s9D6Cx2oM+g=;
 b=XV1F/bVGJyyFuFv+gyqZVohrHGCPZFJrVdiISpXI3tFLKpilkTvmy8muHKVIL1wWwjLrxb7eWTyKdGLAW2ZzTMjml0NDOiESmpkHOP2AOJmxTKBVVTLrqfLyQ5Af4di3dSbIDg0ac2rrrxR8W+0PQQuszgkeM+ks/Pzr5pr0o7DwQpGxOqFFZ7HPve/VXBGyfMoZSQe8CR0VkeciWwPYs3IhJiVezoOSsqqF6vZXIV/gR/V8Byp+FO8oTghqXmbEHXu2R5VimXTX/SBHiCPosliP0XuIRwBtLYYtzsnKw3xozYKpnmeAFIFFfR8eZc7k1xdIO5ioElhOAH42ngIuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DY7Fk/pYYtRw9pMlcFkLxsV4Cd8jK1+s9D6Cx2oM+g=;
 b=i++UZnx0jGQMqFP8jlk46LGJUrAgk5biXVB3ywepVpxaqfZEbOo/WenvVCUzjNP5XhDCW+eUxkanKVsNny3TMixtTUjL+geI1+bZS80gTwlh30jH56TcO3YJSGGqkSCa5yo76m34lnSQ7ojO7p2GNM5nqq6SNCRco2QxnfXx7Po=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8273.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 01:23:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 01:23:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [v2 PATCH] net: fec: free fec queue when fec_probe() fails or
 fec_drv_remove()
Thread-Topic: [v2 PATCH] net: fec: free fec queue when fec_probe() fails or
 fec_drv_remove()
Thread-Index: AQHarNqs/Q7QPDbVfkaSmO4HBpu9BbGll9iQ
Date: Fri, 24 May 2024 01:23:39 +0000
Message-ID:
 <PAXPR04MB8510173A0C831360E0DD8C5788F52@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240523062920.2472432-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240523062920.2472432-1-xiaolei.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8273:EE_
x-ms-office365-filtering-correlation-id: e009d0f9-aac2-4a91-7d4c-08dc7b90241a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?d05qVFJXc2pxZ2hKOTdHYjg2MVN6Zm5DN2lYZkIvS1hvVldZMHpENUhIeFJV?=
 =?gb2312?B?ajdhYVJoVDZybnFBaWJ5akJkREFSbVBYUjlBYWc3VUxzY0NxQmlPMFhGc0Ru?=
 =?gb2312?B?Wld4Y3d6YUEvcDQxRGhWOGQrZFFFZFBrQnk1ZGMvSzA2ZWQrcHg2dlRmTE9r?=
 =?gb2312?B?WGxjckV6OEhpQmhXVVFWTkI0aEVVS2hMTmhzQkh3Q080d0QreEhDMW9JQTBk?=
 =?gb2312?B?eTdvTFVETUExeEpCQUN1aS9RN0xsbVlPRjY4N1hvclpnOEdQai8wN2UrVGo1?=
 =?gb2312?B?ek8yOGl0aGUzMFhUVFJ1aFJsWXlidHo5dkpISzEvVS9tN1NrZGJRMFluZFZa?=
 =?gb2312?B?bTgrM3NhaURaUGpSVDE5K3NXWVp2VTVUMDZkZ2RnMDY5cnJmOU1CeHFJZ2hm?=
 =?gb2312?B?VjZiRVNlVURTMGthMU1QNE9nS3FjZ3JOenVaZ2hKcHpIeUt5RnZZb0FyTy83?=
 =?gb2312?B?SDdma045K3lWdkpuZ0wzZzRmZkkydml3Z3d5T1RQd2xjcUxkZkVxTXNNZmNG?=
 =?gb2312?B?WDl4MkUrMjBEVjhwd1RSYkVVamxvTFA1WWVlc0xQRFNlem5TRmhpK0JEaUsx?=
 =?gb2312?B?NjdWZThMbUVOK2tXS2c0T21qVk9JOGQzU1RnU2FHeHlPR1krNnE0WjltdU5h?=
 =?gb2312?B?WFgrTjhVYWEvTXJBVlF3dEU0Ynphb29JWmVIWitpWDJ6eFNMenpDODQrbHl3?=
 =?gb2312?B?MVVMTzJOVFNPdmpSU1RkeGlZcldGY2lDM0tIUHRFbXpqMzF3YXliZ2xJN2xX?=
 =?gb2312?B?Tkd2S04zWUdxdXdSYUZTL3dOVjRreVI5eTNsaE9VUG9TeXpLRy8xaG80UFEy?=
 =?gb2312?B?dnRicnJtektNbE9HaHYzalcrOVRXSm1QMGR2SlhzU0xOcFI1L3Judjg5ampF?=
 =?gb2312?B?V3I3MEtTMXBmcVVEcjhjcURuOUV2VFd1T0EydnNIOENNQVUrekVJbVo1RXhU?=
 =?gb2312?B?V0NlM3FoMnRNd01BSWZXaFNoZUZud2k3dEw0U1dPR2NUUjJiTVIxVEo3VHVI?=
 =?gb2312?B?WGVWamhLTitvZlc5UzRONU8vZnpsbFU4cEhtUHlnRnN4K0FvOTA1elk1WWx1?=
 =?gb2312?B?R3lPSy9KNUEyNnIxNFhXTXk5eXBHUHpPRGpVcjZYbXhhNWk0ZXgwUUQwSHFs?=
 =?gb2312?B?bDN3MEtubWpUcndVbjRDWHIyNUFDb0pVR3dRaTUzZ3YxVUJxRE9IT0VlejBa?=
 =?gb2312?B?dWpBUXh1UTV0ZGVyRThYMkROTWRacURaeXl3anR5ZnlvcjZHN25EcUlMdk1j?=
 =?gb2312?B?cUhXbGdjTVR2ZGkrbTJYQXJtd0gzUXk1NFIyOU5semZiNzdLeDA5dkJvdm9m?=
 =?gb2312?B?dkV0citXSytPM1hvcWNrT3NBeS9nL0h0SkRFVXR2Mm8yVHlKMGZxZEpUcThC?=
 =?gb2312?B?RzhxdHhEUVFuNFBqdjczbWJMMWpja0FDcHZodzBhNmJxbk5oNU0xaVFsWGFs?=
 =?gb2312?B?V3V3THhpQnRYWDRHSGJCWjVQdE13c3kzamlNQnoyeHFMMVlXWUpYVE9VdkR0?=
 =?gb2312?B?dkN5VmhFYU55cmtHemg5VkdyWnp6Q3VZN3pZWlVrUzhDT0pObHp4Q0drZEk5?=
 =?gb2312?B?S0pORFdZZVM5LzF0NklHNllkdHNHSXJjUDR0cW11UkF1UjJTZ3FNYjZWc3ZT?=
 =?gb2312?B?VFVOd0Z4NVQ4ZXhHcG9qRjZyejFYTFdmbDJHR2o5VUZaV2NaU2hoSXZhSnNL?=
 =?gb2312?B?K0w1bUxpUFd5TElXek9BV08yeUxpbWtnMldvQnBqejA5bmVmSGFKMHFyS3dG?=
 =?gb2312?B?OTFFTGx3ZWQ0THNDdWJLdzc5MmZmam4xOUZVL3V0ZXNOWnJ2dXpTSzFUUHJF?=
 =?gb2312?B?LzNqdUxHTDlVWmlYcmYzUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UVhlU2I4ODJHa3JoK3prVjdKdHhFOXNXVTF5YTRYaVl1ZVJFbDFveEw2ekNw?=
 =?gb2312?B?ejRoUHBHd0ZOdDNqeDRRYldxM21yaW5lRjhybTF2V0J4N09KV0R0TzR0Rk8w?=
 =?gb2312?B?eDIvMXlOWVByZTNPNFpSWERrc05KTDVGM3dWUm9CSWpFWktTbGUzYnZuS3Vo?=
 =?gb2312?B?NzdEWTh2YTJid1hMbk0vNFY5VlJic3BsTEczWGQrTnpGR2NuL3FCUURhZXBp?=
 =?gb2312?B?NTdWSFJaWGtQMGxOQ0hqTkRIQWRHWHorZ0hLRFc0R3RNR2lOeG5RYkNXR09s?=
 =?gb2312?B?UzUycHJZRzVHOTdJaENyckxPKzRLRm5wZ3hNZnAwQ0w4TEJHdzdMNERNbnBU?=
 =?gb2312?B?NElTVFA0eTBPbmZYN3VaekFabTNmQ2hwalFLZUFVY2NJZ05SQmJ3UXgwK29Y?=
 =?gb2312?B?VTJLaWY3dHlsSkUyVmtRZXVQZ00yU0JBbW5JRmJLZkFMcFR2RVBGelRIS3R0?=
 =?gb2312?B?L240dFFrOTAzUEpmNStqeXNwbEI2TWlBK0p5dXJ2cHR5QmlPb01QaHorTjcw?=
 =?gb2312?B?SDd5MzJaVm9Zc2NwcUFCZVdGWVlHMkg2VzN3TUQ5disyallvcXBUN0ExdTJj?=
 =?gb2312?B?Uk1pdUljSytOM0RBUC9sazVzRzM1aVBUdFU3ZnIyZlpWNWo0V2JyTDBpSTI1?=
 =?gb2312?B?ekllM1VkTFJBUUNQMUpud2t0U21rWTV6U2ZjQ3RpL1lhVUwzYjJOakQyTFdE?=
 =?gb2312?B?d1FiRlVnaSttbFVKZEp4Z2VmV1F6aVNBdmpXcm8xQnduWmUrMWpKSGxRTE1s?=
 =?gb2312?B?MU4vNDRZVmtob2tuL0U1TWJoZ2x1THhmK2lPUlpKczgxUFdKc2p5NG5lMjA5?=
 =?gb2312?B?RXFUNG1sZFlmeGxzejE1aFR0Vk15SkNPaEs1Uk1qeGVoWW1HY2dpeDlxUmE1?=
 =?gb2312?B?dmZxZ3NUM0k4anl6Qi9pVmFrOXpxdWNxZWlWRHdpKzJ4NWZDQUFLdU9ndEk4?=
 =?gb2312?B?WFdEd292WG1IM25zV1pTeVlPbHQwS2xOZHRwYTZ0c1FFTnYvWmJpSVZrM3ly?=
 =?gb2312?B?QTQ5bHFxMlg0a1prcHdHWUgyYmJSemxHSXFGM2czazYrcExJSW1LampaN21W?=
 =?gb2312?B?bGx6LzRXNnpOa1hLMHNQZVZnckJsbEpUSUJ4TStObEJUdnNNWWlrN3JqMlJL?=
 =?gb2312?B?WW84ZkplblRGUTlTK2g2bkVsUm1xaHdHd0dvcTg2M3ZEK1ZmSFF4VVhXeDhr?=
 =?gb2312?B?Mk5WTmdycE1STC9GLzY5djhRWmMrNEJwR0ZMYSsyWlJSZW1qQ3hoZmVQSUpW?=
 =?gb2312?B?ZEwwbTZTTmZFTFBlWnZvanBENjdKcVQvMURPTXpkaDFhWStZSWhVMTlLUlo5?=
 =?gb2312?B?Z1F1QWtNSURxd1hwM01uT2ZXQS9MeFBIamZ2RjBwVzF6WllIczRvb3dKUEo5?=
 =?gb2312?B?UE5SMnhxamZzWWVlOHlnRXl4TGJ2M1h2TDIzZEpVSjhuRE1CR012c0w3L2hV?=
 =?gb2312?B?N0NzcG5NS2FSd1NXcTViTEtlQU81VmpIdk95eUszc3JhR0xHUk9tODRRU0Ez?=
 =?gb2312?B?MzNTeXk0NUtNeVdvemFsTStKQnBzL0NGbEZMdUJYMTZDYU9XUlZJYnBJMW0z?=
 =?gb2312?B?ZkhNcHJaMUMxeVZDaEdCRDM1dHRnQjFtdzF2WWMvb3pZV3c4RDg3clBabWIw?=
 =?gb2312?B?Qm10VEppQ1NnanJOMDlHeU5sdlJ2RXNDbFh6SFo3YmMxWnBwNEhDbHdTQ3ZX?=
 =?gb2312?B?SEtDSWpERUhJNDB5ekY0YnF0SGsrR2REMTNYMDNHZDFQdGgvWlJLRlN4ZGV4?=
 =?gb2312?B?a21UdzV3RjhOdVpQMTJNeHBJWXNYYWs3QXJsYXh2WHVkNmpObWRENkx2NWJJ?=
 =?gb2312?B?MTM2NGliQmVYdjdRWDFZSkFyNWYxTFg5MFE0NGloNWFmT0s1REs2a28zQXc0?=
 =?gb2312?B?OVRSdmsvWW1idUdvYVdaVGp1em43bkE2UG9rNzJQZ0w2OStVQXc5eXR0RjFi?=
 =?gb2312?B?b0NONmR0aGJETk9ZaDUyS0JxVFRGNkNsZWxmM2pmZTMyVGFhMGpOcE9XTVJF?=
 =?gb2312?B?TzBGVzhQeG1NMHpVZkErWjFyUFVIcC9ta2d3b0FyL0lkdE81MHU3clFzYVBM?=
 =?gb2312?B?ZmI0Y3FvQTlOSVFaTmlEaTZsUmV6VytTaUZOVGJLN29IcHBuVUlQN0VKVE5t?=
 =?gb2312?Q?k05c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e009d0f9-aac2-4a91-7d4c-08dc7b90241a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 01:23:39.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPpcRgfq/IOhLxqrptsJTwbUgxcTNHz7i0twuGE035QLnq1RFdFbu+GsLWkt4GHks501eR6yDi2K5UScNdMfRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYaWFvbGVpIFdhbmcgPHhpYW9s
ZWkud2FuZ0B3aW5kcml2ZXIuY29tPg0KPiBTZW50OiAyMDI0xOo11MIyM8jVIDE0OjI5DQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IGFuZHJld0BsdW5uLmNoOyBTaGVud2VpIFdh
bmcNCj4gPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0Bu
eHAuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3Vi
YUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbQ0KPiBDYzogaW14QGxpc3RzLmxpbnV4
LmRldjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbdjIgUEFUQ0hdIG5ldDogZmVjOiBmcmVlIGZlYyBxdWV1ZSB3aGVu
IGZlY19wcm9iZSgpIGZhaWxzIG9yDQo+IGZlY19kcnZfcmVtb3ZlKCkNCj4gDQo+IGNvbW1pdCA1
OWQwZjc0NjU2NDQgKCJuZXQ6IGZlYzogaW5pdCBtdWx0aSBxdWV1ZSBkYXRlIHN0cnVjdHVyZSIp
DQo+IGFsbG9jYXRlcyBtdWx0aXBsZSBxdWV1ZXMsIHdoaWNoIHNob3VsZCBiZSBjbGVhbmVkIHVw
IHdoZW4gZmVjX3Byb2JlKCkNCj4gZmFpbHMgb3IgZmVjX2Rydl9yZW1vdmUoKSwgb3RoZXJ3aXNl
IGEgbWVtb3J5IGxlYWsgd2lsbCBvY2N1ci4NCj4gDQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhm
ZmZmZmY4MDEwMzUwMDAwIChzaXplIDgxOTIpOg0KPiAgIGNvbW0gImt3b3JrZXIvdTg6MyIsIHBp
ZCAzOSwgamlmZmllcyA0Mjk0ODkzNTYyDQo+ICAgaGV4IGR1bXAgKGZpcnN0IDMyIGJ5dGVzKToN
Cj4gICAgIDAyIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDUwIDA2IDhhIGMwIGZmIGZmIGZmICAu
Li4uLi4uLi5QLi4uLi4uDQo+ICAgICBlMCA2ZiAwNiA4YSBjMCBmZiBmZiBmZiAwMCA1MCAwNiA4
YSBjMCBmZiBmZiBmZiAgLm8uLi4uLi4uUC4uLi4uLg0KPiAgIGJhY2t0cmFjZSAoY3JjIGYxYjhi
NzlmKToNCj4gICAgIFs8MDAwMDAwMDA1N2QyYzZhZT5dIGttZW1sZWFrX2FsbG9jKzB4MzQvMHg0
MA0KPiAgICAgWzwwMDAwMDAwMDNjNDEzZTYwPl0ga21hbGxvY190cmFjZSsweDJmOC8weDQ2MA0K
PiAgICAgWzwwMDAwMDAwMDY2M2Y2NGU2Pl0gZmVjX3Byb2JlKzB4MTM2NC8weDNhMDQNCj4gICAg
IFs8MDAwMDAwMDAyNGQ3ZTQyNz5dIHBsYXRmb3JtX3Byb2JlKzB4YzQvMHgxOTgNCj4gICAgIFs8
MDAwMDAwMDAyOTNhYTEyND5dIHJlYWxseV9wcm9iZSsweDE3Yy8weDRmMA0KPiAgICAgWzwwMDAw
MDAwMGRmZDFlMGYzPl0gX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4MTU4LzB4MmM0DQo+IA0KPiBG
aXhlczogNTlkMGY3NDY1NjQ0ICgibmV0OiBmZWM6IGluaXQgbXVsdGkgcXVldWUgZGF0ZSBzdHJ1
Y3R1cmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvbGVpIFdhbmcgPHhpYW9sZWkud2FuZ0B3aW5k
cml2ZXIuY29tPg0KPiAtLS0NCj4gdjEgLT4gdjINCj4gIC0gQWRkIGZlY19lbmV0X2ZyZWVfcXVl
dWUoKSBpbiBmZWNfZHJ2X3JlbW92ZSgpDQo+IA0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19tYWluLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Zl
Y19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0K
PiBpbmRleCBhNzJkOGEyZWIwYjMuLjc3NTAyOWFmNjA0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTQ1MjQsNiArNDUyNCw3IEBAIGZl
Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWZlY19lbmV0X21paV9y
ZW1vdmUoZmVwKTsNCj4gIGZhaWxlZF9taWlfaW5pdDoNCj4gIGZhaWxlZF9pcnE6DQo+ICsJZmVj
X2VuZXRfZnJlZV9xdWV1ZShuZGV2KTsNCj4gIGZhaWxlZF9pbml0Og0KPiAgCWZlY19wdHBfc3Rv
cChwZGV2KTsNCj4gIGZhaWxlZF9yZXNldDoNCj4gQEAgLTQ1ODcsNiArNDU4OCw3IEBAIGZlY19k
cnZfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcG1fcnVudGltZV9w
dXRfbm9pZGxlKCZwZGV2LT5kZXYpOw0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2
KTsNCj4gDQo+ICsJZmVjX2VuZXRfZnJlZV9xdWV1ZShuZGV2KTsNCj4gIAlmcmVlX25ldGRldihu
ZGV2KTsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuMjUuMQ0KDQpUaGFua3MhDQpSZXZpZXdlZC1ieTog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQoNCg==

