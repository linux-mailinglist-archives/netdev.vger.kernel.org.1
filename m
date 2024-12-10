Return-Path: <netdev+bounces-150472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1509EA5F1
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E553285332
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95B1AAA2F;
	Tue, 10 Dec 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SxiUAL5Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE419D075;
	Tue, 10 Dec 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798765; cv=fail; b=nZyQs1TnO+Z6AXpkvdWop8KV97otvl4M7ovuvvzrGd0n3Myd58jufpA65zyYEG38vOs5wFzSq1R37n5kZ05Y3GfccFZWEphbJvZXk7Dg9R6gNxktUWTgdSaynqwK0PxWlH66PMKwgc6oIqB2AjT9IfjloiWwd07Oullgqh1chvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798765; c=relaxed/simple;
	bh=BWwVxkaUT3KzukDW5aSJn12k39ZuxP/9g4rodWAxqbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llGdVAv7mU7W4//RhLaTKKJsoTvDNunSr1loMsML9hgoD8Wh5I0zPOwfjFQKGKR2+jP2tFa4ugqvyDb1yiN2pFpbT3cYT799PbrFHfH7j1Tcu0ItI4wzRe+uyRf+315pD4AvEuiVakEw+FljWLfgsR40vX8K5zp9FwYcxQ5QfaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SxiUAL5Q; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CinUfCFw3KEGuIJVOy90uC54Wj9QZE4T1GH7dFvukXlXt5mV7cd1NhnwMvHS+gMuT687oasi0d8AjrQAAEb4rNjg7PTXjqiGa27T28X9Z7Gyru7P+0Q3TM8As0aOTSYjVrApcu6T8ElLEMzVrcH92flyXQg1hPfMg7QCMnkhME4TzWBaCxtNoeLMp15Mdhr4u1esmVz/5LKCAOCe3tpAXY31m2dsluyoa4urALlnqx7+KJU3RlsiyPARrdBM/eahnJvbTRTlApj/pLd9L/KtiuslDdK8bcOTeLSnox3xv6s+aPtv98cr2rCzp54uAvF09cOgS/yQ3zaamnAGYx2MvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWwVxkaUT3KzukDW5aSJn12k39ZuxP/9g4rodWAxqbM=;
 b=l9lTQkssVJRHZ9FVNtIw79rrY9P4OavxOWt+MoAtKwwJUYZXKgyAz2u5CE5kLHPGa45QsblYx1tSu7axAVm/tWbR8YL8FlyYfWi4ElpWk1L+21X19u8e/ISgfOjd+6V2uxemVJouQfS3UzHyWtXDWCkKBI+kM09fBxP3W0wFh+KUovJpv8JwQl/sH4MYIyfTUsrUVECErC3Ni6qxGOVdUJar2zPzMJXX/7Ha/iSC8qSl7yz6c0lMAaDpTsM+RWzz5HxNL8X5zN58RZbmFQAvQUCPncX5gIzpMWMe5NEPbw/Be66UL8KP/BXXr9WWeOmSUcyitCqcVp53YcCMt5yZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWwVxkaUT3KzukDW5aSJn12k39ZuxP/9g4rodWAxqbM=;
 b=SxiUAL5QhljeAmde2T34lNLkxJDn4p/7QjoMDevpraliPoNRxbOnUywmvpIH5FT25VSMGKL65lvzlTpgJH5oU8wvpRNaUKB8sZ1NRrackFYF9rnFiW/1bTlz3gp/zodW7DSIJCV2eRLnTCboY7NaPE1rTg7utRPWvqDYsEO9s1xL9W3FMwI3EtDfedxgidAZtBGJS+iafF5iodgOIjJgcK+FWW1bZf7NewEBtLMMGNaYx7HD+VGx4bU39FSMwBY2tjjKX8zvEK0f+Rpu6nnf6PQDek5psgFhsx6wo00d+hYuFpya93yXBFj74f5l6hGmF3Twb0XbuB1yxvStKP+L1w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Tue, 10 Dec
 2024 02:45:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:45:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "fank.li@nxp.com"
	<fank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Topic: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Index: AQHbR39SNqGVTmwHjEW5jLsNZX4FgrLew5eAgAAGOPA=
Date: Tue, 10 Dec 2024 02:45:57 +0000
Message-ID:
 <PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
 <20241209181451.56790483@kernel.org>
In-Reply-To: <20241209181451.56790483@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8329:EE_
x-ms-office365-filtering-correlation-id: c988f98a-9fcd-4ef0-2c8c-08dd18c4c67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?R1UzaDYyaDIxSnZGTWFLVVRNdGRGcG9QRzZ1blRSNUFIWFI3RVdpNUJTLy9G?=
 =?gb2312?B?bFM2OFBFS29hMjVLby9ZdWxSZlg2aVVFcFkybnZic1p6UmVmalp3ZUNPNk1O?=
 =?gb2312?B?UllTUnZ3QWFnTTZMUnVPdU4ybTJDVmZUTnN0dE51NFYxRTZTN1dLWXNYN2NH?=
 =?gb2312?B?NDZ6UEphbHFmMUJUUnpJU1FPOEZRYS9LeWd6ZHM3ZlBEUHNzN3BLQ1BDbXRo?=
 =?gb2312?B?Yiswd0NWYVZJK1hERTczVkp6amlHUHEyc0tYTGlUdldOMERvSW92SCtYTEIx?=
 =?gb2312?B?ZGFWSk1mL1B2L3ZoN25ZYjBBZEdnY3FPQXhHS0hiUnB6R054R3lGUkdEc2Zi?=
 =?gb2312?B?TE5MNE54VWZYaDUzU0VKQ1IzZU1VaHBkK25UU2h6UUVqTVg4R0lOQlFJWTZ1?=
 =?gb2312?B?WDN0c2dnNlBrMi9qTDd1Y0lqYVFFd2drdlBwZ1B1MTUxcXJsR3YzN1lRZkFk?=
 =?gb2312?B?cVBpSVBJWmIyUUxKRHJ1QjJ6RTVDczd0LzBYVlVBMG9YbVcxSUEwM2oraFV2?=
 =?gb2312?B?RER5STZYYWJrVUY3M0tjMzYrN2VQOGdzbzVMeVF2ZXNjTXc5aldlV0ZhYmZF?=
 =?gb2312?B?ejBPRnpxMkMrTnlDSVh3L05OLzdKRitQQzRDbG1yLzFPSHZxdCtDRVRaQkFy?=
 =?gb2312?B?WW5ucDVnZDJ3UVQ2SGE0U1M4T0g0RFhUWUlOZWhzZ2ptd2RXSm43anlqUmg2?=
 =?gb2312?B?Tm1WU3ZsT2VyQ0R5bmhVR1J6MWo4eVdEQXFvSTFkNmdQN3dJMm1FVDAvUHFB?=
 =?gb2312?B?ejk2YXhWYzBVTktzUm5JdHdtcGJlWHhMTU1iMFJub3FHbU92SEVoQzhwcnBR?=
 =?gb2312?B?QVBJMGx2TVVGRXR3eVpHMlJMR0tBY2Y1Q2RsVCtUS3VwZVBxc0hBYStpaVlL?=
 =?gb2312?B?QmdDRmV0REdtQjJIRzQ2ZC80UlRZNjBzT1dYcThFU2U4bWVFcERJN2FmT1RT?=
 =?gb2312?B?aGxiTlVlNFI0cW9FRlN1TGo0R3U0NVRVOWxYZkVFNUovb0FhcmJQNEdJTS8v?=
 =?gb2312?B?dEFqMUlJOXhyWnBJUGt3cjRxZWlYZGVQOWdxY1hQcndRVGRBeGRZMUZBOFlJ?=
 =?gb2312?B?S3hnMGN1Z1BKQXJtNVFoL2NEVTBIVEduQzBEOTUrSnBIQklEbGo5ZlZtRkFy?=
 =?gb2312?B?Q2dRKzhkSENrMEp5cU5zVzlhWGRxZXg1Tyt6cm8yaytMQWRLak5ZZjE3aXpr?=
 =?gb2312?B?cVJiOCttVTdNMUVWUGV3azU0TjBwVXpkTC84UzNxenRZa1FIbm4rQ3h1TjZv?=
 =?gb2312?B?Wk1Rcll2a0hCRlIzeG9VbW1XNVhseW9NaFFLeEhlUG5zUGdibzZKbTlWU2ht?=
 =?gb2312?B?cU14bXlpUU93eFY0V0NYM3pZV0NYdzY3UUNyZncyWXRSR1NReCtmSmZEZUQ0?=
 =?gb2312?B?OHk4Z3Bsaml1UTlQSE5la3RsV3E1T2szWGtQeEdNQXo2VE13WXFaVXZzWEUz?=
 =?gb2312?B?RWk0V2MzcUpKb3VMbUwydkRGMVQzQll1ZEpMUUVGalZQdStFdHR4bG1vUnBX?=
 =?gb2312?B?cFFaWCtuRHBnVTAxKy81NlZVSVJicGcxb2tmRnZsaHVqZjE0bFFmVGhOUWR3?=
 =?gb2312?B?a3FBUFpiV28wSFV1eE9qUXFBemExcXRLaHhaZzFGeXhKcVJ4K1REZTd3Tzdq?=
 =?gb2312?B?a0FDdndRdmo1T0lSM3VNNW9DaUJkdjI4VGFPQVM5UVRsMjI5Sk15SWU2UDIz?=
 =?gb2312?B?Q2I2anl1RUpuYmtsamNpRnpUMUw2ajJNME9waFJ1RVduY0FaaHE0M21jTUFE?=
 =?gb2312?B?ejZhOHNzM2pIVjNpSHQ2Wmc5YmVGa08zR2VqR01JV25RMHQ5NUFtNUsyYkds?=
 =?gb2312?Q?K0R+gNHg8WZZvZSeKalTT3e3m8s/0XXhQ0K/c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OTlCL1hFVG1ibWNmQUZvNHYzQnIzc2tCWFdRcHZoVDlmNzhidmxTaWhtNTc5?=
 =?gb2312?B?RENBdmp1a0ROMmVFaW9MQlBrS3doeFpaaTBqbXV3NnB3dUE3ODRiZVl5UEo1?=
 =?gb2312?B?NVJ5YmFUWXVacmNWaEVzWDhIWXgwUDJuQ250bzBkUlM1WkZ2YTdYaVFVSWdE?=
 =?gb2312?B?L0FPT05MeEZlempVYnp0VWwyR3ZhazJqdjlZaWNiaHQwWXVxSTZaNHM4MHg3?=
 =?gb2312?B?bW9kQjdqRGtzS21NdXZJQWZzZlQwMzFWRXlqMzBCL0FSemJTRjd3YXIvSHZv?=
 =?gb2312?B?SWVudGFxbjFaL3pPZkhqaHk2aUpzMWRjS1g5SFF6RjBpOXdXb0dKQitZNGhI?=
 =?gb2312?B?Ly9LNUh4N3pPMXh2a2dVRkUreXVMZXJiOEtPeTNKT1dveUlpK2FkTWVCRzFJ?=
 =?gb2312?B?bGRsdzBCVHRjUFg3N3JYMTJwNzk3Wkl6WWxIZ1M4K3BjUG9rdDZHVVRnbG1B?=
 =?gb2312?B?L0w5N1ZyWWpnd0czRzdKL3pJQjBjWGRmL3JnTUlDUW8yZG1BOEVhR2JhRGEz?=
 =?gb2312?B?eENuUVdaamxuQUhQWFIzTHV2RnZrRzI0S0NxdEExSU9ISlNGNC9WbnlhbVVU?=
 =?gb2312?B?VFVtWVQ4OGRST1VyMlYrVVc2YitCa1ROWk8rQ3YyaXNZWFVaK2w2SkxYQzFR?=
 =?gb2312?B?Znk2YUtRdkZsbitCRE9mM01kR2FYalozU0puV0NnMk9oYURvZ3F5VmJISlpE?=
 =?gb2312?B?bE1VZ0lGbHdWRk9WQTE5d2pCMXRTeUpzM2lJWlhrdVhJSGhIb3FLODdHYVUz?=
 =?gb2312?B?WFNLU0hteTZlcGVINWhDalUrNXZMZFdoeFprWjZCVUFmRkxGT0d4ZncvQkx1?=
 =?gb2312?B?amJmdE14OG1MYUNpZmlTZHIxZjhrZ0dFTzhKYW1STldVRnUzNFcya2RFc04y?=
 =?gb2312?B?aWNGOGJ5MkRWcXoyRTFlc0IxbkFIeEJMZTNGc2JtMmJkWHYwU1JvdVhNWEFM?=
 =?gb2312?B?TG5zSVZDVTM3djF1VVNjQ2dudnlzQzhHQlRlMWtDcFJNVHRGc3RVWWRJRS95?=
 =?gb2312?B?RGtLUlJ6NVEra3JPS20vVWpmNzUrNytObGlXVzFlSElLb3VsVU9VTDBXeC9G?=
 =?gb2312?B?OUFhTjNvSjJSYzhOZCtMV09wVGkrSjJBOW5wYUVsYmJKNnU1SzJKWURoZlpK?=
 =?gb2312?B?RW0xVGxTMFF2RUJIZVZQMWs0VnhVYncydDliaFlTVW5MYVZEeWlnQWhUU1J6?=
 =?gb2312?B?UmZuVXBVc0lFVVl1SkhVcG1GOHZRdVdtbzBPM2VuN0g5N2JZcDFNS2xIa3pK?=
 =?gb2312?B?OEtRY1lVZnZnVUh1OERTREkzb0dSU25mWVg5SUkxSkltN0pUT1VTVzFJZDgv?=
 =?gb2312?B?NVFBcU8rS3I0RWFKZFU3eng1T0lTVTFyU1JEWGhkS2xaek80Q0RvbTJJSmFU?=
 =?gb2312?B?ajk1OVUwbUxtU3o3RWJmNnZtK1BlR3BVUC92ZkM5eld6em90eEJZWU9tK3Rv?=
 =?gb2312?B?Nm1xQXJUdkkrU2RGWk1uZDFXNDZCYnJYd1dnZ1piQjB5NGJnTlhFL0pjdTdv?=
 =?gb2312?B?dXlTQkx4NVhBVWVDd3ZQM2wxOUszU2JjR0VzV2FVYk5vN3BXSnFycnZtSjBn?=
 =?gb2312?B?REJzQTBzTHdiSU9CUGo3VEpWQWdZc3hSckM4ZlkzZ01SaU9peEU1R0gvOFRh?=
 =?gb2312?B?MW5pQXpGOGU3TXhya1RONUxWRlVBYms1amtubkRtTTc0a0hJcDhzN0YrbFpD?=
 =?gb2312?B?YlE1Qkl5V0NOOVU0RXdiUVlhb0lZbVFUYlpLZ2Z5cXJBZnhtd1VZN21vOW9p?=
 =?gb2312?B?MGRrOWpBenRIUk13MHJmOXlLTlV3dXFVcGpRNjlPSTVaY3Y5UmgwRHpRY3c2?=
 =?gb2312?B?RWRKeVYxUDdQY3ErbUJEd05vOHA3RjFYeXFnTTRBRStwaGhXRG5jdzZjUFdO?=
 =?gb2312?B?eTlLQlZrSGovWFhzcHZheHFPaW1yQ0RKZzZDWVpUSmVUMXphd3NBYUhOT0VY?=
 =?gb2312?B?Vmw2OVdFY2ZjS21vWXZCTFNDVTJuT2RwZ2puUk11bklHZ1NXOHNCV0djcjY5?=
 =?gb2312?B?SzF4ZW1PdmoxOVFPenpDaG5HRUFvbUJQSkVVODJkL1Rack5SektIMGM1eGxG?=
 =?gb2312?B?R2YwR29UQkY3MGNycTUrdDlsTUtrV2g5SnB1NlhPTVBWMlVneGhyN2tTTFlv?=
 =?gb2312?Q?phpg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c988f98a-9fcd-4ef0-2c8c-08dd18c4c67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 02:45:57.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgdnL5aqSUfsynFqAVJ5EtYvFOaeIs/jhdNWFkurhQQNT1VN4ALOICQiZxk4n9s2eLsTbaHc1n5IUUEbxT+18w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMtTCMTDI1SAxMDoxNQ0KPiBUbzogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBhbmRyZXdAbHVubi5jaDsgaGthbGx3ZWl0MUBn
bWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51azsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsg
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGZsb3JpYW4uZmFpbmVs
bGlAYnJvYWRjb20uY29tOyBoZWlrby5zdHVlYm5lckBjaGVycnkuZGU7IGZhbmsubGlAbnhwLmNv
bTsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIG5ldF0gbmV0
OiBwaHk6IG1pY3JlbDogRHluYW1pY2FsbHkgY29udHJvbCBleHRlcm5hbA0KPiBjbG9jayBvZiBL
U1ogUEhZDQo+DQo+IE9uIEZyaSwgIDYgRGVjIDIwMjQgMDk6MjE6MTMgKzA4MDAgV2VpIEZhbmcg
d3JvdGU6DQo+ID4gT24gdGhlIGkuTVg2VUxMLTE0eDE0LUVWSyBib2FyZCwgZW5ldDFfcmVmIGFu
ZCBlbmV0Ml9yZWYgYXJlIHVzZWQgYXMNCj4gPiB0aGUgY2xvY2sgc291cmNlcyBmb3IgdHdvIGV4
dGVybmFsIEtTWiBQSFlzLiBIb3dldmVyLCBhZnRlciBjbG9zaW5nDQo+ID4gdGhlIHR3byBGRUMg
cG9ydHMsIHRoZSBjbGtfZW5hYmxlX2NvdW50IG9mIHRoZSBlbmV0MV9yZWYgYW5kIGVuZXQyX3Jl
Zg0KPiA+IGNsb2NrcyBpcyBub3QgMC4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCBzaW5jZSB0aGUg
Y29tbWl0IDk4NTMyOTQ2MjcyMyAoIm5ldDoNCj4gcGh5Og0KPiA+IG1pY3JlbDogdXNlIGRldm1f
Y2xrX2dldF9vcHRpb25hbF9lbmFibGVkIGZvciB0aGUgcm1paS1yZWYgY2xvY2siKSwNCj4gPiB0
aGUgZXh0ZXJuYWwgY2xvY2sgb2YgS1NaIFBIWSBoYXMgYmVlbiBlbmFibGVkIHdoZW4gdGhlIFBI
WSBkcml2ZXINCj4gPiBwcm9iZXMsIGFuZCBpdCBjYW4gb25seSBiZSBkaXNhYmxlZCB3aGVuIHRo
ZSBQSFkgZHJpdmVyIGlzIHJlbW92ZWQuDQo+ID4gVGhpcyBjYXVzZXMgdGhlIGNsb2NrIHRvIGNv
bnRpbnVlIHdvcmtpbmcgd2hlbiB0aGUgc3lzdGVtIGlzIHN1c3BlbmRlZA0KPiA+IG9yIHRoZSBu
ZXR3b3JrIHBvcnQgaXMgZG93bi4NCj4gPg0KPiA+IFRvIHNvbHZlIHRoaXMgcHJvYmxlbSwgdGhl
IGNsb2NrIGlzIGVuYWJsZWQgd2hlbiBwaHlfZHJpdmVyOjpyZXN1bWUoKQ0KPiA+IGlzIGNhbGxl
ZCwgYW5kIHRoZSBjbG9jayBpcyBkaXNhYmxlZCB3aGVuIHBoeV9kcml2ZXI6OnN1c3BlbmQoKSBp
cyBjYWxsZWQuDQo+ID4gU2luY2UgcGh5X2RyaXZlcjo6cmVzdW1lKCkgYW5kIHBoeV9kcml2ZXI6
OnN1c3BlbmQoKSBhcmUgbm90IGNhbGxlZCBpbg0KPiA+IHBhaXJzLCBhbiBhZGRpdGlvbmFsIGNs
a19lbmFibGUgZmxhZyBpcyBhZGRlZC4gV2hlbg0KPiA+IHBoeV9kcml2ZXI6OnN1c3BlbmQoKSBp
cyBjYWxsZWQsIHRoZSBjbG9jayBpcyBkaXNhYmxlZCBvbmx5IGlmDQo+ID4gY2xrX2VuYWJsZSBp
cyB0cnVlLiBDb252ZXJzZWx5LCB3aGVuIHBoeV9kcml2ZXI6OnJlc3VtZSgpIGlzIGNhbGxlZCwN
Cj4gPiB0aGUgY2xvY2sgaXMgZW5hYmxlZCBpZiBjbGtfZW5hYmxlIGlzIGZhbHNlLg0KPg0KPiBT
b3JyeSB0aGF0IG5vYm9keSByZXBsaWVkIHRvIHlvdSBidXQgeWVzLCBJIGJlbGlldmUgdGhlIHNp
bXBsZXIgZml4IHlvdSBwcm9wb3NlZA0KPiBoZXJlOg0KPiBodHRwczovL2xvcmUua2VyLw0KPiBu
ZWwub3JnJTJGYWxsJTJGUEFYUFIwNE1CODUxMEQzNkREQTFCOUU5OEIyRkI3N0I0ODgzNjIlNDBQ
QVhQUg0KPiAwNE1CODUxMC5ldXJwcmQwNC5wcm9kLm91dGxvb2suY29tJTJGJmRhdGE9MDUlN0Mw
MiU3Q3dlaS5mYW5nJTQwbg0KPiB4cC5jb20lN0NkYTZkZTdjMzFkMmE0ZjkzMjY3NjA4ZGQxOGMw
NmZhMSU3QzY4NmVhMWQzYmMyYjRjNmZhOTINCj4gY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4
NjkzOTM2OTY3OTUyNTE1JTdDVW5rbm93biU3Q1RXRg0KPiBwYkdac2IzZDhleUpGYlhCMGVVMWhj
R2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0eg0KPiBNaUlzSWtGT0lq
b2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPVlqUiUyRnVwaw0K
PiBweWUlMkZtTVhDSDAySE5FVWlvdDFrR2FEMXhrZVVFTzloWThQMCUzRCZyZXNlcnZlZD0wDQo+
IGlzIGJldHRlciBmb3IgbmV0LiBJbiBuZXQtbmV4dCB3ZSBjYW4gdHJ5IHRvIGtlZXAgdGhlIGNs
b2NrIGVuYWJsZWQgYW5kL29yIHRyeSB0bw0KPiBmaXggdGhlIGltYmFsYW5jZSBpbiByZXN1bWUg
Y2FsbHMgdGhhdCBmb3JjZXMgeW91IHRvIHRyYWNrIG1hbnVhbGx5IGlmIHRoZSBjbG9jaw0KPiB3
YXMgZW5hYmxlZC4NCg0KSGkgSmFrdWIsDQoNClRoZSBzaW1wbGUgZml4IGNvdWxkIG9ubHkgZml4
IHRoZSBjb21taXQgOTg1MzI5NDYyNzIzICgibmV0OiBwaHk6IG1pY3JlbDogdXNlDQpkZXZtX2Ns
a19nZXRfb3B0aW9uYWxfZW5hYmxlZCBmb3IgdGhlIHJtaWktcmVmIGNsb2NrIiksIGJlY2F1c2Ug
YXMgdGhlIGNvbW1pdA0KbWVzc2FnZSBzYWlkIHNvbWUgY2xvY2sgc3VwcGxpZXJzIG5lZWQgdG8g
YmUgZW5hYmxlZCBzbyB0aGF0IHRoZSBkcml2ZXIgY2FuIGdldA0KdGhlIGNvcnJlY3QgY2xvY2sg
cmF0ZS4NCg0KQnV0IHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHNpbXBsZSBmaXggY2Fubm90IGZp
eCB0aGUgOTlhYzRjYmNjMmE1ICgibmV0OiBwaHk6DQptaWNyZWw6IGFsbG93IHVzYWdlIG9mIGdl
bmVyaWMgZXRoZXJuZXQtcGh5IGNsb2NrIikuIFRoZSBjaGFuZ2UgaXMgYXMgZm9sbG93cywNCnRo
aXMgY2hhbmdlIGp1c3QgZW5hYmxlcyB0aGUgY2xvY2sgd2hlbiB0aGUgUEhZIGRyaXZlciBwcm9i
ZXMuIFRoZXJlIGFyZSBubw0Kb3RoZXIgb3BlcmF0aW9ucyBvbiB0aGUgY2xvY2ssIHN1Y2ggYXMg
b2J0YWluaW5nIHRoZSBjbG9jayByYXRlLiBTbyB5b3Ugc3RpbGwgdGhpbmsNCmEgc2ltcGxlIGZp
eCBpcyBnb29kIGVub3VnaCBmb3IgbmV0IHRyZWU/DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9waHkvbWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCmluZGV4IGRlMTE2YTA3
NTNhMS4uZDJhYTNkMDY5NWUzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvcGh5L21pY3JlbC5j
DQorKysgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCkBAIC0yMDIxLDYgKzIwMjEsMTEgQEAg
c3RhdGljIGludCBrc3pwaHlfcHJvYmUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmF0ZSk7DQogICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgICAgICAgICB9DQorICAgICAgIH0gZWxzZSBp
ZiAoIWNsaykgew0KKyAgICAgICAgICAgICAgIC8qIHVubmFtZWQgY2xvY2sgZnJvbSB0aGUgZ2Vu
ZXJpYyBldGhlcm5ldC1waHkgYmluZGluZyAqLw0KKyAgICAgICAgICAgICAgIGNsayA9IGRldm1f
Y2xrX2dldF9vcHRpb25hbF9lbmFibGVkKCZwaHlkZXYtPm1kaW8uZGV2LCBOVUxMKTsNCisgICAg
ICAgICAgICAgICBpZiAoSVNfRVJSKGNsaykpDQorICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gUFRSX0VSUihjbGspOw0KICAgICAgICB9DQo=

