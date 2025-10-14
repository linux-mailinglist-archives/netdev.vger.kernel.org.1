Return-Path: <netdev+bounces-229137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B320BD871B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FA0D351DB1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A32EA724;
	Tue, 14 Oct 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVbKICwT"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641442E7BC2;
	Tue, 14 Oct 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434360; cv=fail; b=NdOQoKEwHw+TiUiJAzyCXD/ECwcqJs+fEyjrSdU6TYO8FxOeMJZEXgeLeZRMX6KMzVM5kSTJOR6Di1FXp4HrvBXiBE1HUGB2b1CBOZDhf714nZ8qBV1MsyWVvvHETLbuj9Pn1we+RLmX9Hn2sNNkMi9txCopU6OgKYuERyDtZOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434360; c=relaxed/simple;
	bh=41ZGwyYltPB0Bey4CSPGzWWF1i4bnyrWZuPa17cCD4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OT83dd1Ljm+WLulKXvymXoW/QoOPPPQIm1CA3zUsGyZvkQfRvYboMu96ocYHQZ4LztFSGgG8/r5dz3D9WGxApwW0o2x+9ikwnICHZKYplilq4kfmTCDdG7ueZDpibhfXcubxUbM/quYO0buDzAYJWYgCjTcojqPZbrbxv/rCgpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVbKICwT; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDfhea1/YbijcdNK8G5L+399/KlEdsHdsu+bssq6Zj3y8coxwb8STSe8zFpgz/g3Oezsq5V9NJV/1IuuKLq2ojB/g4L2kOf1HLMcF8m0J7RG/a7pPSmw1x/DJRrg3hpfw/CC7b9YrFz+0IzYRA9cfmWOr1GDg7o28jXPN5euSKhy53AOyGxHTrYRdnf3/9LPi+S3b/4JosCB0i5wJlvjJ7DmqGmgiDReXp5xnAAdpRNOQMZthZiYHnf8SWiwuv52mUqNIkTU/hKf8y+yucuC8hwCsbhoGgyA6kyokFajO0je23bmhZ5g+nk9IM6f3ejIHGiSTMELApWpaH44ftdjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzDJOpkSr0C+uKm3mZbHIF9THWkoS5C7wMo4rPzTdiM=;
 b=SLiXgV6M0TQBAducI8NCJE81O1Gq/n2S/amjoTjidN1GD/y4UMovoQokX2/0wbW9tTqDmbvQWyknM9sxNyh5O8LLueCLgGiHn25i4jb1gDnhsmccMdL6Bvk4msVcpwTdPu9KrDKwox6Ed8kyCR0F92CZap+9Ae979FDndcYy9/jDhWXz2fQK4L12u995nmn6tQ2XXa7lP2cc3FvLoD0Herh74Vl3w8uqScb3AE5WQzmiPrQO55oRRuG8Pxd8IBQJ3mbr33wB+0SoyFEYAlLpfLXGvl+IEvXWlGevkWUQvOA4lJ6m349v+tTJYgYO6v8O6WNqVMqixXunUnbZzRrloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzDJOpkSr0C+uKm3mZbHIF9THWkoS5C7wMo4rPzTdiM=;
 b=RVbKICwTnkVvc6SWsRJXuI/+28aBjSYR4ffa0gsD83LChShiRpcl/UYefXJva5M0jZytnZHWR8u/xeUOLmO3VOU7vjeRNLV6bRw7VoWoxeOHU+jSJjNSL9SSogPp7MoJarB2QPlO1+RvDt0QzYtBrOTcx+fZLZuj3ADd2jz1md1U4Os6Ls1qD76P6efUqLQRAj+Sp/QWfLfezseG9fCcCSYI6Yxix0kNzrSGMWF4jpQ/jLp8ntVJvCSZ7eBzZjX0KvLuY+ju1K0MTLoir8iIvKCkjGZkzPtv0gIjqNN5+ccKyty47AVX+/QZEcfBAaasXzCL1G/E+XC2A7PdWn6z6A==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 09:32:30 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 09:32:30 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Topic: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Index: AQHcOcsjLfa+tXqAmEqFL+MdmHhkNLS7VNgAgAA7RCCABV5mgIAAbs1g
Date: Tue, 14 Oct 2025 09:32:30 +0000
Message-ID:
 <AM7PR04MB7142C31C1EA26B48E92042C596EBA@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
 <20251010124846.uzza7evcea3zs67a@skbuf>
 <AM7PR04MB7142CA78A2EBA90FE16DF83B96EFA@AM7PR04MB7142.eurprd04.prod.outlook.com>
 <PAXPR04MB8510610DB455D9CF2D4E295088EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510610DB455D9CF2D4E295088EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|DU0PR04MB9585:EE_
x-ms-office365-filtering-correlation-id: 90d16102-cb02-4713-fcd8-08de0b0498c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?amJvYThIdXByeTRIUHdGbVJwcDZPU2t6Tm5JaTRZaGRWT0tRWWEydkk5?=
 =?iso-2022-jp?B?RDM1Rm0vNGVmdWlxTThQYXN5OXhxUGVlN2NJc2YvbnJYTzBoSnBxOUI1?=
 =?iso-2022-jp?B?ZXMxb0tlWWgrbGlrMEJSSkZMSjY3d0lndzVIY3pOZUJKRVpzL0ZLZkds?=
 =?iso-2022-jp?B?cW82emlOMmRaK1ByMDJWZmI2bjBuQXl3Q0ZDd0hES0V4dzlxQ1B5bDNQ?=
 =?iso-2022-jp?B?SFFGM3NDdjRSUkRNTWtxcCtQMTZQWjRyUERkMWNrSDZBcnlMbDVNejM4?=
 =?iso-2022-jp?B?aHhLUHEybGxGckhyZWs4SkI0OUNneHYvQVIyc3ZjU29mUm9ZbWNLNVQ2?=
 =?iso-2022-jp?B?NytxSlp3OVg1R3NjME5WSzZzWUtINGxaaEVBcnQ1K0tPaWJMQmFkbXJ2?=
 =?iso-2022-jp?B?OU00b25GUS9TdjlnM1N6TzBicXdYSGpTZG8vN05Xc0V4VzRTNFYvNm9I?=
 =?iso-2022-jp?B?T0k1NVF2VWN6UTRTdmMvYlJhNDBNK2VZR0Nlc3dLL1BQVENINUtrSXh1?=
 =?iso-2022-jp?B?dzRhdUNYVlNNQmRxZTY4d3BmV2o5bEdvUktPNHpNT1c1eWNKQ0NrZ0Ri?=
 =?iso-2022-jp?B?ZDk4S0g4QSsvOXNpZ1pRd0tlV1Ivbm4xNTZ4TFM2c1Jmc0JNcVhiYTVV?=
 =?iso-2022-jp?B?WG8rSm52ZFNOU3FIZXRZY1piTkVrSnZ0RXU5dkhBWElra2cvM0xWL2ps?=
 =?iso-2022-jp?B?anFraHdoYys1dW1TemQxMC9vM1FPcGRMUEluNHhzU2VIL09iRlZMVTV1?=
 =?iso-2022-jp?B?VXRsV1hndlIyRjZyd2RVdDg1clNpem1OVCtHajVzZlBGak8zcWdzUDNR?=
 =?iso-2022-jp?B?ODBoMVFHUlNkM3l3ZUZ6eXkxU3V2cjhTL3dNcURNTmoraEd2ZFVweGhr?=
 =?iso-2022-jp?B?K2c5RzhJVzZobjR0c3cwSDZmWDZ2VkdNRm9ENUdrNFVzL3ZXeE1HL0c3?=
 =?iso-2022-jp?B?YStmTUlWZ0xxNEJQRk1uWXJqQ3Z6dU44ckhpZXZFaHU1MFJWeUR4TlVQ?=
 =?iso-2022-jp?B?cjV4cUJURXFpbFJHM3BUZHhsK29YenVFNDNOVDk0dzZQSFlUaWdLY09N?=
 =?iso-2022-jp?B?WXFRMHU1MHZ2TnI1MEZYNVphUzhqSnQyUEtVQS9ScEl1SDQ1TWVKUUJW?=
 =?iso-2022-jp?B?SkVMaGFXVWswY1RYNG02N3IrZi9VdjRYZFFzUE56bS92Mm1CUkM2SFY1?=
 =?iso-2022-jp?B?eE5CYUxiZzhCQTNrekdrZ3k5ZUg0bXdveW9tdmEwYVpiS0l4MkFHZXNa?=
 =?iso-2022-jp?B?MGViU2wycWNjZzJRRWlJRWFQZTd0Q0h0Y2ZZeWFLTFhFZk8vc2hKRXNG?=
 =?iso-2022-jp?B?TmtFNlJZeUZVSytNdURqZVRua0R2YWE5ejFqTHFnN3JrTkVqWG0wallK?=
 =?iso-2022-jp?B?a1ZpR3F0V2JoRWk1bmx3TStCQ3Zod2JPZGNVcy94QXh3OEs3eUx2Snd2?=
 =?iso-2022-jp?B?WDlqb1lhWTc3SndKbEdLNHFIQ0xxNWozeGw4VHJHVS8xUE5Fb2VHS1Vo?=
 =?iso-2022-jp?B?OVIzV0ZqOHBQaWt3T3Y2bmJEK3BlMDByT3FUcFZoMDM0MHZZUzZyNlJs?=
 =?iso-2022-jp?B?aUlCclh6VkordHRBRVRqdmhOQk5tYUI4R0JoQUx1VjRZcjljWVNjU0Za?=
 =?iso-2022-jp?B?QzR6bTRGdk9NYzZOUnBoTFViSDNkQ2tFMUY2TFJMUE5JbFlyWnJxQ3Nw?=
 =?iso-2022-jp?B?WmxGSUo5bGw1dDBwbDdhVUw2K3lPNUZvTVBNTzlmUFRqUVVGM01HMUVk?=
 =?iso-2022-jp?B?bVRVTU5ER2o4Q0U5cWFOY2dGVkdDQkRJbm02SkhCMUVSWUN4MmxFZGV4?=
 =?iso-2022-jp?B?S2xNaXZqTUxOYjk3WFVidTh6NGVWQVZyYUNlclBNamtDWWtmUGZtUHFk?=
 =?iso-2022-jp?B?Tmg2UXRlN3c3RXlNU0NrSU56ZVFLVFRpbFBYYkpvdzBqbGo2MlY1Q0tI?=
 =?iso-2022-jp?B?SnduMVFDdHRMN2ZBMkd5eGg3WnY3am9DbFBoaURjdmp1d1pPOCtkbUJy?=
 =?iso-2022-jp?B?Z1VSalpmV3JFWkxpMVc5bmIvbjBmTGRmZ1k1T1ZjaGNFR1VQOHdQNjVI?=
 =?iso-2022-jp?B?UUY1eVh1aUlHRnFUY1FDTSs1NE9jQnh6UlpFQkp6MEZMeVZ0dUcwWnFU?=
 =?iso-2022-jp?B?ZEY2Tm5qYmZ0QVc2WDh2dkd5TnVHVjlFR0xHc05yaUp4Ymlxb1NoeWhn?=
 =?iso-2022-jp?B?YU11VXkrUCsrWlhvRWorTEdXUTQ2S2Ju?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aFVpT0pENk9tTWRTL2VQdkpITU5CYnBrTUkwTDhRbDVCeG1adEN5TXQ2?=
 =?iso-2022-jp?B?K1dic2pDNkZLKzNnQ2FnMUZkeThsQWtKYVdNOHFrdEpjSUhxRCtaWDJT?=
 =?iso-2022-jp?B?RnllZVl6VDNxeHFEaWRNL0NvM0xPcUkrcVZ5YTBDdUVSVU9XYlFoNzhC?=
 =?iso-2022-jp?B?OUJXUnVwUENueGRHcUV2OGtIbDJFMUtpWFVUbHczQ0p5RXg4dTNPOWJ4?=
 =?iso-2022-jp?B?VVpyZndpeFNYVGlZSWhqekQ5K0Y3Y0RPSmF5UGJsQkdiZGlhVE5OTUtI?=
 =?iso-2022-jp?B?UUdQc0FEamIvTmZLVnhtajNTS3N6c0ExdmxPOHJuMHhWdUkwUzA1bkRu?=
 =?iso-2022-jp?B?Vjd3ZzBaYkV4dkp4dnNUUEROdEJHMExlNm1wejRGa1VSMlNyT1F2VzhX?=
 =?iso-2022-jp?B?bG1ZV0h2SVUva3R3T2w2bUtPR2FuNHpDYlYzOEUrVDhNbEdVamk5bjZz?=
 =?iso-2022-jp?B?SkF6UUg2MW5DdjY5a3NtdnRjNVlDZXF6U3d0VlRFNTJMbzRXS2xlUUpC?=
 =?iso-2022-jp?B?ckJIU0dsQTZ3S0lVVzlyNUJUdWVVV1lOUzNJWldtOW9yc3g1UlVURVcx?=
 =?iso-2022-jp?B?cFppT3RKMXArTTQzTzB4cytyVGpYdFhoSEpFU1NBRG51K2N1MVN4RWYr?=
 =?iso-2022-jp?B?VDRZbmJXT29hcnhVbGExQ3VkeDdyQmR5ODNxWEZCK28zQjFyQjdxVldx?=
 =?iso-2022-jp?B?L2FHQ3VUbDE1VnB2Vlh4NWpUaTE3cUxjdEZZUWx6OUNiczQvTjVPK0Y5?=
 =?iso-2022-jp?B?NHVZTWs3WnF1eUFYdTJCd1ROUzRQUW04VEhqclJYVWVvYklVNUxzY2Ju?=
 =?iso-2022-jp?B?ckw3NHRDWkdMV0JUT2lFU1g4NFppRnJCRzZHT01KNHRoM2hXVWp4elBv?=
 =?iso-2022-jp?B?TldqNkVwSkNRVW9NMW1DTFVUNUlReE1OL2sxMGhiazVLdmZGZ0Z3QUoy?=
 =?iso-2022-jp?B?c3BvbHVoNjk2RlR6ZEEzQ3FpREsyQkJSTWZTb2tKV1R0dFBZbEF5VkFk?=
 =?iso-2022-jp?B?TkRtY2NFaEZDQXlvbVE0dzZBcUFKN0RoTlRkQkI0STJoR1dGcGF0SHlJ?=
 =?iso-2022-jp?B?bWMzZnFrY2RQWFhzQldnaGpSZmExeTA1QlpzYWtiMjg3SXZDem1UazVR?=
 =?iso-2022-jp?B?dzJwZFVHbUllSS8waHJaMitoOWJldjRjRTZERzBmWHJOdkxZdmVCL0Vr?=
 =?iso-2022-jp?B?UFVFTUdGbVFBQnltZU1WTHBnTU41NUR1TDVkRFN5QjFhcnp4YmpjdEZu?=
 =?iso-2022-jp?B?UFlvR2VsazhpZFJvMFpMSFJoUGlHSHJ5Vy9CMm1ubmY0MGR3VlpOMml1?=
 =?iso-2022-jp?B?WU4ybmo4TTUyT1NzdlpRa01ZQTczWkdXc2xuc21OVCtFS0JLNVAyQ3dX?=
 =?iso-2022-jp?B?dUJCZWxSVjZLQnJXb1RZbEZKdi9FVlRFTFUzdXU1LzZPdkxyTkZ3bUNp?=
 =?iso-2022-jp?B?R2g5MTU3WTY4dG52V29ISHdTajdzcWVrWkRqOU5wRENILzZhSHBwbUVm?=
 =?iso-2022-jp?B?aFJaWUNDMjh5QmhMZmt4TFF6NDBGcWhxa1NzS0Z6NWlCNjlUcUZOTGhP?=
 =?iso-2022-jp?B?TTR4TTllaFByYTB0YTJJN1l0YW1BN2p3SmRXYzVGd1ZpTkVHUHh2TURo?=
 =?iso-2022-jp?B?a3ovWkdwbVREZk9EUGhPK3AvazNUa256V0xvSlljM2Zsa3o3Z2Yzbzdt?=
 =?iso-2022-jp?B?a1dYZGdCZHg3U2YxNDZ3MHQ3N3FJdkZoL3k0V3I5NEFUZDM3OWwzYnN1?=
 =?iso-2022-jp?B?YjNYdEFBVXlid1h3N3BBYm94ZG1YQWM0T0pYRTBDcjgreEN2SzU4U2V6?=
 =?iso-2022-jp?B?VzBqaHI3T0pNR1FQWlJoRnEwMUlmaHpQMWludFk0T2JaU3JTVWlhNUlM?=
 =?iso-2022-jp?B?YlFGOUhuRzYyQnVpenp4SUsvMXUzOGNjcTU2cUtWZXd1QlpMenU0eG10?=
 =?iso-2022-jp?B?L082NmVqY29VcUozNlp2QnFaa1paT2h3NHlyVGpTUzlSN205MFpYV3RG?=
 =?iso-2022-jp?B?bEdadyt1OUt6MTViTjMxL1oyOUEvbDBOVjN3bWxrTlVuVzNQSFdmSG50?=
 =?iso-2022-jp?B?WStXMjNVMm03bTRwSnBTMWsvaDVQUXdXcVB2bGlZMUxUaEJ4UkVRTWNK?=
 =?iso-2022-jp?B?amdXREVlbnBlU0xEYmRGa1RLMEt5dXZOZ01sbGxuN3FPMk8xYkRnMmhJ?=
 =?iso-2022-jp?B?RnJ0SkNFVkRVWHZQaWlkZExLMURGVWd6bHdEZyttcVZhWVlodytFbnpn?=
 =?iso-2022-jp?B?UVJsRDNvd1RvdFRnNk9va29DVVpNQ3dnd1pIWm1EMnNiWnh3VmtJZysx?=
 =?iso-2022-jp?B?MHJ1SQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7142.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d16102-cb02-4713-fcd8-08de0b0498c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:32:30.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwVbRWui0NXdn179qBNSgvJCRrL2dOjZjQEUAunxUugHkVEsW0DJJeUoexU5hgWM7QcexJj9SG0oxuWlUpM5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 14, 2025 5:20 AM
[...]
> Subject: RE: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUES=
IZE
>=20
>=20
>=20
> Best Regards,
> Wei Fang
>=20
> > -----Original Message-----
> > From: Claudiu Manoil <claudiu.manoil@nxp.com>
> > Sent: 2025=1B$BG/=1B(B10=1B$B7n=1B(B11=1B$BF|=1B(B 0:24
[...]
> > Subject: RE: [PATCH net] net: enetc: correct the value of
> > ENETC_RXB_TRUESIZE
> >
> >
> >
> > > -----Original Message-----
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Sent: Friday, October 10, 2025 3:49 PM
[...]
> > > Subject: Re: [PATCH net] net: enetc: correct the value of
> > ENETC_RXB_TRUESIZE
> > >
> > > On Fri, Oct 10, 2025 at 05:26:08PM +0800, Wei Fang wrote:
> > > > ENETC_RXB_TRUESIZE indicates the size of half a page, but the page
> > > > size is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K,
> > > > 16K and 64K, so a fixed value '2048' is not correct when the
> > > > PAGE_SIZE is 16K or 64K.
> > > >
> > > > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC
> > > > ethernet
> > > > drivers")
> > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > ---
> > > >  drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > index 0ec010a7d640..f279fa597991 100644
> > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > @@ -76,7 +76,7 @@ struct enetc_lso_t {
> > > >  #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
> > > >
> > > >  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
> > > > -#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
> > > > +#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
> > > >  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if
> > > needed */
> > > >  #define ENETC_RXB_DMA_SIZE	\
> > > >  	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > I wonder why 2048 was preferred, even though PAGE_SIZE >> 1 was in a
> > > comment.
> > > Claudiu, do you remember?
> >
> > Initial driver implementation for enetcv1 was bound to 4k pages, I
> > need to recheck why and get back to you.
> >
>=20
> Any updates?

Reviewed RXB_TRUESIZE usage, and confirmed that it's not only used for buil=
ding
skbs and in the page halves flipping mechanism, but this setting is also ac=
cordingly
propagated to the hardware level Rx buffer size configuration (e.g. for Rx =
S/G).
The allowed h/w Rx buffer size can be up to 64KB, so we would be safe even =
with
128K pages.
The 'PAGE_SIZE >> 1' comment is actually a TODO item, and I crudely limited
TRUESIZE to 2K to enforce 4K pages in the initial driver (i.e. for simplifi=
cation).

So, pls go ahead with the configurable RX_TRUESIZE, and note that this open=
s up
the driver to new usage / performance scenarios, and user configurable Rx b=
uffer
sizes.

Thanks,
Claudiu

