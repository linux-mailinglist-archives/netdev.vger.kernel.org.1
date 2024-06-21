Return-Path: <netdev+bounces-105504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6374911875
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F90B21FAA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6343684A21;
	Fri, 21 Jun 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IwU88TrC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F94537F5;
	Fri, 21 Jun 2024 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936829; cv=fail; b=aTW4AXb60KRiXWT4t23XH6MNXWYIx0UMJmIW/VRgEsfYAnrzl66kCJ/vIMb6Y4Ap7ECLzmH09EBs72vsXUPmlhczI5/2W1GnvIPGAY0gNMeBsLaUySu7SlG8m48IHbCr+v/eBHRJrXYeqt2QooqQfB2NbH+I8Gr2lN8fScUmFE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936829; c=relaxed/simple;
	bh=DVimugR5c5eDma5alOJ2Rj0KuhEAgjRMS0BGE9OqBTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpLQaMPOj9tWulxHI3a6nRfkjIuBsU1TZ64vJ0E+llMi7r0Ed9F8H6nd2f0+O0dY8zv8WUTsAPT+58mYKF891mn0urWylP6HKA8txyFKYQsGgIlysfNhW/eQXQQ/8BLy+Y0jOGmlQEk/RByh+qvWytKU/QWFH0uk/NzxP5ynTIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IwU88TrC; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEcgmle+gXEcJTQVKC6G5n7bjgPdmuon3y76pSlQeCmH6sEgU3IH1q9IE0yzmPfLe4Dn25MI4uErr+uM+vSLcEygHdTyFbDcURjNSFY5AQMYgahImgcIHK8UIkCXdMfIqvF/FVoP2rMGEuG7LhzA0n+JCr22wPeGr78o3SSv7svWfI2iviGWNFnXSLf4qFkY3NXK8Pd2aIETgWKz/8CUc2jLmnAYtFVnQIAYT5PZo4Qan9zM69zo0GhLWxEqYj26z7Fr2OgEzfQptE+rryo/p+bChJyCN/FvoYn/XQ1a3PDVIMEVZTimzWLPUkL+CSu4bCyF37MY3qzKzhpVLsjXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVimugR5c5eDma5alOJ2Rj0KuhEAgjRMS0BGE9OqBTU=;
 b=ZiJ48dYgpFY4WsYi01MjwUKAXShrWwY9HMDner/BJ1WBH2eNvIN3DgQX0WdvZ8VXAqUzhv81DjkVNv9kcuFdjPkgM0wYf6ypVWTs8bb5mBVFPbDPVSfhBFUBJgHdCODafhMylRqFX5I1f/KpeykDBz2nBUCabEWEnVG2OWXZtt2ScfCq1WDR80K55q6MeLIo60i++7ck+5qqlFogYbRLZqj5xHEqkcNxGfwzIaq2f+M7M/P0q1hIZg2jPYsd8zlkaYEFGTc4Xmc2La4FX/1z9KLH6o8mUEPdEj7K3JwMrSp3k4dCKoSYvEd/1H3yyYo21vwwGhVpd82zrEBoY1ivJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVimugR5c5eDma5alOJ2Rj0KuhEAgjRMS0BGE9OqBTU=;
 b=IwU88TrC7nFgziK6Jv2fY+GJ9IiBtXywrxB0FdS+nDDHcybBW4KFYKnd4QAdfSqmkKnEpDXfwHJXvSxW4D/kHKiCPkz/QW8G+EkMScjMEzbYHqD1BIFUz9q8m9yVRXYowNIDKHvVK3+kECirBFJuZKYsfbvtW2yJ0qFOSvy1MBc=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 02:27:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%3]) with mapi id 15.20.7677.024; Fri, 21 Jun 2024
 02:27:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?gb2312?B?Q3OormuoonMsIEJlbmNl?= <csokas.bence@prolan.hu>
CC: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH resubmit 3] net: fec: Fix FEC_ECR_EN1588 being cleared on
 link-down
Thread-Topic: [PATCH resubmit 3] net: fec: Fix FEC_ECR_EN1588 being cleared on
 link-down
Thread-Index: AQHawkTymQHDr4VNx0SjoNCxn/Fym7HRgASA
Date: Fri, 21 Jun 2024 02:27:02 +0000
Message-ID:
 <PAXPR04MB8510126439D15BFAF5A4897488C92@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240619123111.2798142-1-csokas.bence@prolan.hu>
In-Reply-To: <20240619123111.2798142-1-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8441:EE_
x-ms-office365-filtering-correlation-id: a0bde9cc-54a5-4b26-5567-08dc9199a2da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?gb2312?B?ay9hT0dXdVovRlVrRE5kbVl3eCtmck1vMitCQ2MvZjlaV3I1K1BYeE54Ykxv?=
 =?gb2312?B?aTlaM2svWEFGamM5VXIyVTFTOC9UQTlqdndnOXhvVnk3SmV2ekVLdjhqZ0I5?=
 =?gb2312?B?cVBkYXFNMDVMWGdPazlubnBjQnRFWGRrZGgzU0drZEI1WmJwMTNFTXhBZWVD?=
 =?gb2312?B?VHZtUjViQzA2MW9tWDFhZFJlUlQ1YzduOHRRRXM2VVpmd2JqTVFGUnNicjFG?=
 =?gb2312?B?VnBGT2xuQXpwVjRPTUl6cG8xZVVuTG9mbWh0RHlreDlrWnp1VUtMdDVKQ0to?=
 =?gb2312?B?Qng2Uzl6QVh3SEk4NnphaTVLTEY2V1QwVkQ4RksyVVEzRk1xSklvS0EraUlD?=
 =?gb2312?B?R0ZwOFhVdWF5TXRtK3I3enVEOVNqTC95TjltTFdxY2xHSHJLenZtckVSOE0y?=
 =?gb2312?B?RjJ3cDZmNXh0VU42bGh5SGdXbDZsdWVSck1PUmlRRjRxTUNmV3pKNUg0RCtO?=
 =?gb2312?B?K3Bmczk4RGxLVEhjZlRvZmFiYXRTS2FPN1Z5UmlPS1B3Q2J6MzlVUnMwMm9u?=
 =?gb2312?B?NFhKbjAycllTU3pjS2RsaU94MlVEc1hHWUVzVzZZZzI1SFFjc25peFlEaHhV?=
 =?gb2312?B?cXpSb1hXY1ZnR3dock5hRTliUFFvUEZtcTRnVmNlZ3JaOE1vMXl4Zlcwdjkr?=
 =?gb2312?B?akVvWktvNy8vZlpUOFFMWFdzeUp3cHQwTDVHUWZndXZUbWw1Z1M2MVNqZ0sz?=
 =?gb2312?B?eXZ6clBvR1VYanBUeVh2cGRpYnVUbXVJaGM1bmlLYWQ2T1k1VVRySjgzb3J4?=
 =?gb2312?B?RmpHZndLTjRLODNEcy92NmIzdWFPWDg4WVlHTzdOdnlPb0hlcU9yUlUybDZF?=
 =?gb2312?B?ejJZdGovQXRnSGdtbGdZZmswRDdmYStFcUVXczZMa1g5VmxvRUg2RDRDWWwr?=
 =?gb2312?B?d25vM1p2cHkvQ1I5R3RwbnpzNFplYWxzd0pHU25SSlNodWxuWHpGaEdYUzVG?=
 =?gb2312?B?bmxQMHc0SVVCT1FQaHM3VHhuQlovQklVZWc0Vytha0lZWlJuNnljUFJHZmRV?=
 =?gb2312?B?dG8rbmRGbWV5ZTZ6ZWNCNFMrSjVzL3VWeGc2VXNSbG43SFFlTjd5Y3dpZ0lq?=
 =?gb2312?B?RHc3a1hlL2puUDBENlQwTG5lTG9BRjhTRGZwbFhEcUtSRTlNOGZmUVMzdmR4?=
 =?gb2312?B?YjdyMXRNcG9LWnBGajN4d1VuZ1NuUTMwenVLUnQ2Uko4VzdwUlVLaXg1ZjEz?=
 =?gb2312?B?ZFVZdUdKeFJKS2tId0RHZlo5SitOZndRS3R2N2VRNElOSmkwU3hoR3h0SUJE?=
 =?gb2312?B?RVdpMWNXZ1F4aCtjcWZEUmxhcGYyTkYrVlp3YTVmUmtNYkNaVkVmbi9BMHd4?=
 =?gb2312?B?WWxEbnZTS1ZpRmp6OGp2cVpVdVVyRVFZelZyV2NReXl6M3U4M2ptTldpVEg0?=
 =?gb2312?B?dWYxeTRuS1YxUlNwUjRzSW02aGlndHRRczluMis3MkVXcjF2RnVCYmxKSGN0?=
 =?gb2312?B?allHcTd0U3ZyR2piempnalFxQTd1cFBjSzMzUjY0bTlVQ0c4YkRBY0d5UWps?=
 =?gb2312?B?TGJqVmViYkJyNjduMVNHVmlVUGU1VXB4WUFKNWJjMjVuQWVTc2hDWTc2MUs4?=
 =?gb2312?B?SWNDVndCT29TSHdveENBOExFcVIxUEZhd2xoemxEbXUxaHJVUTM4MUtEOXpD?=
 =?gb2312?B?c0gwcmtOZ1hBY3ZvclpIZU5WRVRoNjEvTUV4aWNKdC8zanFvdnlhK3NHZHBm?=
 =?gb2312?B?RGdib0lMalFYbm9VeXQvWUpYWERZTHNmcDJIenB5UDBaWHkra20xOFM4Vm50?=
 =?gb2312?Q?YQlnIumZD0QuFkxKuXHnEuqNTyHTBQqbO8r3W1h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TjlqT1NTc2kySUxPV3NsYU1pclF1V1JsZk54VW41b3YvU3lsa2xVZFZaemRG?=
 =?gb2312?B?RU5oSXpTbThLL2ZldFo4bGVlUjMwcXRtRDRKc3VWUkxOU1pJNWhvM25GR2tV?=
 =?gb2312?B?TkovRVgwYStZdUJGdjhSZW1udUJINU50YjVWbTNNRWtnbzVCSDV2Y3NUd3Nv?=
 =?gb2312?B?bnBhZ0VwOUpaa2hjWlpzbXV2L3hKUmM2Q2ZFbndmQWwyOUNLTTR5YjA5VDRN?=
 =?gb2312?B?bUVaNXlPdDNUaWdFZ3hwdDcrUzNQZGhyMnJaZ25pdG5CT2dIQXNwdlNETGlD?=
 =?gb2312?B?dkJaWVpMYmZwNWllaWcvSUJxRHorWTY3MHZSRXpzbjNyV0FzaWNJT2tRRWZs?=
 =?gb2312?B?REpqUWMvaWt2L0NCNDR4T0pWdTNlanBYRTlwN0trM1QwM1lCRXZSbi91NVc3?=
 =?gb2312?B?eEk3RTRYVzdSSmxaLzB3dmdnN2tHbHRUY0VEU3BqU1RCSHJ0WUI0QW43VTRM?=
 =?gb2312?B?YUtQMEY3YUxwQTFJSHk3UUxZYVFNN01hdVZkakIvT09LYzFNTUIrWHROQzQ3?=
 =?gb2312?B?UnZBNVBPZzdyM0pCTlBtbnpLc2JSdkQyNTY0SEtselZnZ1JnemZKK2l3UTZ5?=
 =?gb2312?B?TmhqR3dtRlkrOXNNcGVQa0xhRWZxVFMzOHVzbDhsNENyNkh2MElyTkh3MU1V?=
 =?gb2312?B?MnF3RUtxWU1PTGtuNlY2dW51R0RiYnhQZyt5blhvZ00zYXRtT29HSk5Nd3lt?=
 =?gb2312?B?R0pKNlNMdWRGUGg3RVc0RVhPaGxXQUpCZThlMTdjMmxBdVp5ci9SSXUzSGZC?=
 =?gb2312?B?NDkwNVUxb2pxNFk3VlJzU0k2TXlZZktQZ2RQc0ZiaUt6NHNrUG1lOVg1dXJT?=
 =?gb2312?B?cnUzbFBLM0YzSUZjamJBdi8weThUUkNoblo2cEhsQnFDK3Ftckw0UzY2NDlL?=
 =?gb2312?B?QmVDbmF2V0E1ak8zalgwZDI5UDdNckVNeWs5OFJRWEs0QlZxK2QwMmlpTnQ3?=
 =?gb2312?B?YkFNNnkvRTlVU29tcVdzc1lvWmUrZ2M1M2ZPK0h3SStXYkRtTTIwZTlBdW8z?=
 =?gb2312?B?dHd0S2hidExmbjFJam5KeWt5eUc3L25ubEFDaWM2RzJabzdUVVJJNTRYK1VK?=
 =?gb2312?B?VU1UU2lWeW9GQlNYUXliblJEbzJzVkI1MHM5SHBSSDNRNXAxQkI3Tk9zVHVJ?=
 =?gb2312?B?Q0VQTmpaNUNoU0VzZnRzSkNqOUZpWGhENEIxTUhtem4rNHpXUzNmYUUvZDk5?=
 =?gb2312?B?T1Zqc3d3UmNXUjlIeXU3OTJGNXJSV2hkQTFLTm1jQVdzYTM4aFRBNjkrVEFz?=
 =?gb2312?B?eHdDeVRJQWN5RWlHbkZIZ2V0enlWMWp5SmwrUFdmbnBRVndDZXFLelJSNDEx?=
 =?gb2312?B?UkZNQkVPN0RRMTdIV3gxcUF3NVRIN295a0l4bGlZUk16T0xkRDJIeXYwZmpO?=
 =?gb2312?B?QTdLUFloTStoNVBKOW9Manc4cUZOblo3L3c0WEh4bUtZYmdISFJVRWZJekQx?=
 =?gb2312?B?bmtPZERuVHMrSmU0V2Fvczd6YWI5OEZHNktGWW1Pc0t1bnNWV2RRcDdEdVpN?=
 =?gb2312?B?U1Z2Rmk4MzNxdzVldmdyVjFMcW9qV1ZhR2tlaU1DL3c0MGp1ZXZVcmZVSlA0?=
 =?gb2312?B?THFoS3k0ekl1QVFwUFk1dFczRDR3SG52OUN0VDAyUFdWQjFDa0dyeFZEV2N4?=
 =?gb2312?B?TW5Uc1hZbTlLY3BXTHl5QWEvZzZ0NWJ5L2hIbWJuQXNxL3drMHpHRUdlT2Nj?=
 =?gb2312?B?SHRzMG1XNzBidHd3Sko3QXQ4K2FLd1JleWZCMkgvQS92b1ZUOVo2U0VZSjdx?=
 =?gb2312?B?b2pTYVN0M2pWMUFDNk1MWGFaVFFLb1M5b2ZxNXRBTzlBcVB1dHN4TjJXb1NX?=
 =?gb2312?B?L2dKRUlsSUovSkF3WUhvQVpIR1J1aGRYL3NWanhJS01kTUJVSkRPZldpd1BB?=
 =?gb2312?B?WFVydHJzdmYzUXhDYy9IaTBSSm91RkJUQ1lBTHhlaWNzRlZaamV2bS9qazIv?=
 =?gb2312?B?dzJDSjloNFhmVW12azNoNnhqTE0zek9LTm9vYkNDN0svQTc3MFYrR3JGTUVw?=
 =?gb2312?B?U1lJS2EzcnlyL3M3TTRjM3pWdW5MU0x5T01Gc1pwSEVMckRaTnhqUVdqYXpi?=
 =?gb2312?B?SktBQzJkbW8yME8ybms4Tm10emUyZnlGc3FwUEl1ZkxtYVgrdURMend1U0xk?=
 =?gb2312?Q?fu4g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bde9cc-54a5-4b26-5567-08dc9199a2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 02:27:02.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yevTV8soj9weRsJ4ESODHKINNQR2s3oTkGTiVaJ3g7OWx9B9JB3fpM4Wh6YgSyfm2WOKPfoumtsqeAIDKSjXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDc6iua6iicywgQmVuY2UgPGNz
b2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IFNlbnQ6IDIwMjTE6jbUwjE5yNUgMjA6MzENCj4gVG86
IEZyYW5rIExpIDxGcmFuay5MaUBmcmVlc2NhbGUuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+IDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ3OormuoonMs
IEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1PjsgUmljaGFyZCBDb2NocmFuDQo+IDxyaWNo
YXJkY29jaHJhbkBnbWFpbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+OyBXZWkg
RmFuZw0KPiA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54
cC5jb20+OyBDbGFyaw0KPiBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBFcmljIER1bWF6
ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
cmVzdWJtaXQgM10gbmV0OiBmZWM6IEZpeCBGRUNfRUNSX0VOMTU4OCBiZWluZyBjbGVhcmVkIG9u
DQo+IGxpbmstZG93bg0KPg0KPiBGRUNfRUNSX0VOMTU4OCBiaXQgZ2V0cyBjbGVhcmVkIGFmdGVy
IE1BQyByZXNldCBpbiBgZmVjX3N0b3AoKWAsIHdoaWNoDQo+IG1ha2VzIGFsbCAxNTg4IGZ1bmN0
aW9uYWxpdHkgc2h1dCBkb3duLCBhbmQgYWxsIHRoZSBleHRlbmRlZCByZWdpc3RlcnMNCj4gZGlz
YXBwZWFyLCBvbiBsaW5rLWRvd24sIG1ha2luZyB0aGUgYWRhcHRlciBmYWxsIGJhY2sgdG8gY29t
cGF0aWJpbGl0eSAiZHVtYg0KPiBtb2RlIi4gSG93ZXZlciwgc29tZSBmdW5jdGlvbmFsaXR5IG5l
ZWRzIHRvIGJlIHJldGFpbmVkIChlLmcuIFBQUykgZXZlbg0KPiB3aXRob3V0IGxpbmsuDQo+DQo+
IEZpeGVzOiA2NjA1YjczMGMwNjEgKCJGRUM6IEFkZCB0aW1lIHN0YW1waW5nIGNvZGUgYW5kIGEg
UFRQIGhhcmR3YXJlDQo+IGNsb2NrIikNCj4gQ2M6IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNv
Y2hyYW5AZ21haWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5u
LmNoPg0KPiBMaW5rOg0KPiBodHRwczovL2xvcmUua2VyLw0KPiBuZWwub3JnJTJGbmV0ZGV2JTJG
NWZhOWZhZGMtYTg5ZC00NjdhLWFhZTktYzY1NDY5ZmY1ZmUxJTQwbHVubi5jaCUyRg0KPiAmZGF0
YT0wNSU3QzAyJTdDd2VpLmZhbmclNDBueHAuY29tJTdDNjhhZjk1OGM4YTM1NDViNDU3YzQwOGRj
OTANCj4gNWMxMjliJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzODU0Mzk3MjMNCj4gMzU2MDY4MTMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYNCj4gMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9R2ZWMExqDQo+IDZrNVJ3UkxVQXJSaGJ4YURvTnBHNndM
bFpTUWg5dk54dVJlWkElM0QmcmVzZXJ2ZWQ9MA0KPiBTaWduZWQtb2ZmLWJ5OiBDc6iua6iicywg
QmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjX21haW4uYw0KPiBpbmRleCA4ODFlY2U3MzVkY2YuLmZiMTkyOTU1MjlhMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTEzNjEsNiAr
MTM2MSwxMiBAQCBmZWNfc3RvcChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gICAgICAgICAg
ICAgICB3cml0ZWwoRkVDX0VDUl9FVEhFUkVOLCBmZXAtPmh3cCArIEZFQ19FQ05UUkwpOw0KPiAg
ICAgICAgICAgICAgIHdyaXRlbChybWlpX21vZGUsIGZlcC0+aHdwICsgRkVDX1JfQ05UUkwpOw0K
PiAgICAgICB9DQo+ICsNCj4gKyAgICAgaWYgKGZlcC0+YnVmZGVzY19leCkgew0KPiArICAgICAg
ICAgICAgIHZhbCA9IHJlYWRsKGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+ICsgICAgICAgICAg
ICAgdmFsIHw9IEZFQ19FQ1JfRU4xNTg4Ow0KPiArICAgICAgICAgICAgIHdyaXRlbCh2YWwsIGZl
cC0+aHdwICsgRkVDX0VDTlRSTCk7DQo+ICsgICAgIH0NCj4gIH0NCj4NCj4gIHN0YXRpYyB2b2lk
DQo+IC0tDQo+IDIuMzQuMQ0KPg0KDQpUaGFuayB5b3UhDQoNClJldmlld2VkLWJ5OiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg==

