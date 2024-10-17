Return-Path: <netdev+bounces-136392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA19A1951
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C933B284630
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117D1304B0;
	Thu, 17 Oct 2024 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIURT0xl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFA53E15;
	Thu, 17 Oct 2024 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135771; cv=fail; b=NzV/3Z/nhsiDwElWXbwGUjuAlzMtxJ7LuBvyTtcG5cW0LVRVtZt3PeX9yWsOaaSbrPHwhN0x4Aufop4IWa/8ALwBUX57FcyPlwZy0tho3+pzj5zmvVTXDBiX8wsBymlU4Tsr087xPtTnKoW2muXedu4bmZcalpxbm6tmogrm9XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135771; c=relaxed/simple;
	bh=/zc7cdTWafYBEzjU9rWnL/EZpjb0es/iAtCyz6ol9uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDgez4Jl+ct+BW5UzRdIaTX7Q5UAMSJFNHBDKWswrEFzTM14m/lWwgNlADh6MyXVVP+uI4fVKpOjpwxmxPvfsW2KcT37tDKXsQrE5ZqSJZfTBH6q3VUljZjOoagx0p7la3I6wa2HWw6ZJDWheXEL97Bo7kvjgndjgjI1iudBAOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TIURT0xl; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb6gz3t5q9jSdewLICKLX95PDrnNYIyGS6n2ilrb7B8FaPveaGDHFQ6ItLyEq0yZDXTe4L7rwMLV2sj89nfOjAwU/x2h6DWumctp7wCrw5I8m6JrQ4Xpes+K13BtBatV0aRnIintGhVxpQswv2mqLLC0g67md0YFYVAZCc5QRYbe2ah+n35sqOser2cagLe4wvofOyypoMLfP0bhn7r8h0mG75WRJlYtXMhz6Z5s3QE2kC1ZP+M9t70LkpvYb6Q6TWcGFqqBlgoKsXg36lo8rb7dsjx1lECCsOHZnUKWejoB50HweZH2XuZQmpJLjSXArJI0SsCmYpofevweg0PTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zc7cdTWafYBEzjU9rWnL/EZpjb0es/iAtCyz6ol9uQ=;
 b=RxUNOR+9SuhdNTtBK4+ZaakU/fliQRjb/UPb2399dZdusMUp4KPQWJetsbNkSvkl8s5uAHZ/7xuqJcrI0a3hlnTYDNZxqF6GcvqyWyGPZos19tvEDmbz5+wSSkcpTu9ybItnaSEQYMIMKYtV8MTeItRh7kyTJ7HvDgnplTvEtoqRMYORx2jn2uFtCfh8ZIiat1DDG8WZ2cPOtCkgfcHCFW4oIzEC9yUYOYG3JaUyKnh3Nw+mZhOraT1ZyWIKeIwXyjZqY2mBcfD1OLiBLz//HxalOVGC2A3lYu4rF6wsx71TsBcnCQdT4jvVZWs6c0d9Wgvlb/ffPmytVK0dWxhBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zc7cdTWafYBEzjU9rWnL/EZpjb0es/iAtCyz6ol9uQ=;
 b=TIURT0xleaaQdMNzw9Jqvagiv5M4+MAMeC73tTT7y1kcBszG/V0M1kVj2DaQ7PeMKG0s84BLkjHPoAECjmx47RLbFi58hTpCm+oC9NQV9sSGknrpAA1xncGmp8zML6XFAJOe+P9opJdzXvUAYuidFFpDIivS63cu9q9cq/aLNuVdQQtYqX4mYcq6pu1NaHy8sqAAeGgvIPMUwX/Kq6hGJIZsdzMtPbLT5hCzM9V79ebqbjOjPLi8S739S/H1F3EZg5FsmJSRKHkEXWzIeABe18ZYqjRBu0SKu1CApoaJojA1pib8IO76nQhcAFubz6VLOTAysleNsYquXYo88otvvQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:29:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:29:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 12/13] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Thread-Topic: [PATCH net-next 12/13] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Thread-Index: AQHbIBW3v/XStP7sEUG9LPcWUpxL6bKKSUHg
Date: Thu, 17 Oct 2024 03:29:24 +0000
Message-ID:
 <PAXPR04MB85101CC2D166275AE71DF5B288472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7586:EE_
x-ms-office365-filtering-correlation-id: 2bf8883b-4188-4e34-9f8e-08dcee5be5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkxiWUVyZElHUDUraFhCT09jeHUxYzh0bHJJcEx3MHNOOWFzYXAralovZnJU?=
 =?utf-8?B?RTN3bWJUSnJLWmRvcWVteDRpaE8wZFhDV1RNVTg2Snh6ZVdkQ0NiYko2VVBp?=
 =?utf-8?B?NEpUY0EvL0xXYURLeWx2NzVGUVlqa1hDalhMNEtYQ2pMc3ovUEs4WlE5ekNy?=
 =?utf-8?B?SUEzT01MM25UcmFQMnhjL0MwZXAxbVJCQU5ETk85VlpMd0tEcG1hMmVXSWI5?=
 =?utf-8?B?Uk05ck50K1VzQTlITldyMFZWSGozNVh0MmNIM1dKNVhhQ2xzTi9FWG5WaE5y?=
 =?utf-8?B?Q0kraGlGYzNDQlNXTUJzYm10b3ZRQjVoZUJUZ2I4cDN2aW9JVzdSdDgxZ1Ba?=
 =?utf-8?B?UjA1ZklIb2hHOFhQWGtvajRwMUFGUTVuMUc2NjJxYzVsVmIxTTMzWFRMaTR6?=
 =?utf-8?B?V0NaT3U5WTNQNHFTMWRRYXErMEh0SUloQnp6S1g5aGM1MWRTZHAyK0pleG1B?=
 =?utf-8?B?djB6REtCQ3ZIeDdlUFlicEJ5TVUrZ0pzcjFMaWRJaDF6N29qNHlEMUdMK2FU?=
 =?utf-8?B?T1JkenRsVncyVGlVaStiWFhzWjBGZnNuNkdpUFlkR2xpYURWZU9xUEtXN0Ri?=
 =?utf-8?B?RDN5YU9qNGtiSjZMUWZuOWx2K0dWZGY1WHEwWHN0eE1pSmdiTjlnU1VLb3V4?=
 =?utf-8?B?T1B6elpjQ0JsZTVjNUNmMzZ6V29aVVFrVVYrVkVQeWJabTZJd1JxemwzQXNW?=
 =?utf-8?B?TGVoRi8vdmZkclo1YzA3ZkR5eFpvdjdCYUdtSzdiRG5jUGlVUVhtdnhXeXpZ?=
 =?utf-8?B?VFNhMDJmbVR0UnREd2tKRjh1SzhwYmVncGFtWE53RDlKcDh6dy80ZXdVQUJz?=
 =?utf-8?B?WnFhYTloZUMvT21pV1VCMlRUTWNvcVhlU0VYRExuQWh0MnNieVJnSzZyT2pR?=
 =?utf-8?B?amx1Q2JpSTBEeFk1TFhLSFdQd3pvL0FvWkc2TS9YTGpsOFFpcm5uSVFlSWI0?=
 =?utf-8?B?U3N3N0ZWOEdTZHppTWlDU0NqUnUzS3FzcENYOTVzU0piTDdrVS9xcnd6UkJu?=
 =?utf-8?B?VFQ2M1JnUjM5dDJWNGZZTS9WM0N6bU5RSTZqVW1KTi9mVWxROVpjWURFRVAw?=
 =?utf-8?B?L0hxYmIvaHRGUjRGUEhuWFRIeUhCZDRCQ2hwc1ZzZTFsbzkxRHFWZEJ0bTZj?=
 =?utf-8?B?UnVjbEdoUENLRExHR0NWT0xuNUg1TGY2ZEUrc2FyRXFjTytkU3pSbHllSUhF?=
 =?utf-8?B?T296VkdGVCtiVFhyZTZZMnpVa2YyNWlMUVV4Mlpoam9Ea0lwRndXekZ2WFo3?=
 =?utf-8?B?bzdLMnZHMEtCdnA0TzJFOXZ3d25rL3VKZ1k4OCtQUHFHaWFQTVlnalZaNU00?=
 =?utf-8?B?YXQzeElsL01saU0veTJaOVJzR2t5bXd3TTMrVWtBOXhzOHg5bTVOalBvZUpw?=
 =?utf-8?B?RytaajQxZWJ2c2hxY2ZXZC9iRVhMSzVXU1JxdTJWWEZiSUZyL1ZRNk1ZSkpy?=
 =?utf-8?B?K2ZVQzlMcC9LZVMrTVRqS0RuVFNRTlp6anliRVRsMFV3UkVpcVFCZFJCUXFS?=
 =?utf-8?B?TnlQQ3dxN2VCazR1NHZSZC9Xc0V5U0t0eVVMNWthRlpHMWRwQUVya1JqSGJT?=
 =?utf-8?B?L3RDTW5aOTlzODg4ODRxMkxlZlRsRU9RR1JPOEtTRzBSZmo1Skh6SUg3eVRN?=
 =?utf-8?B?QllwNEhIbEJNenhiZDEwNkhJeUxRN282a01UNXFCaTFQUjk2azZoeWRkUWY5?=
 =?utf-8?B?d05pb1ZkZ2NqMDFDWXJHTmlQTHNodWNxK3BjVmJwcnpISVpsdGMveXVQbld2?=
 =?utf-8?B?V0ozc2lKSzJXVWp2YVZkQnpoc21KN3BjOFl3c01HbUpoYkVpc3ZZeVBvSlEv?=
 =?utf-8?Q?uqq2pfHlGGd9fRtu/CZ+AGoTsb/WxYP3FL/xk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3BaWmpxeGJwd0JlOEVzbWdQNWF1bmdsQ2VuVmVzdHkwRkc0V1hxQTRndTlJ?=
 =?utf-8?B?aHpJK0R4Z3JRSjRlTzdOZ2M3UGplQStuUStmYkJVdmh3NzBDSHNhK056RE1h?=
 =?utf-8?B?cnBRbnFGUUREejhHN3djSWhNU25KeVBGcGpscm1KYks0QUFxMHpYcFVCMUph?=
 =?utf-8?B?VjFLTEYxdi9oZ3BUM0xTU1MxVFZRdXVmdmdDODJIdkw3ZnhpeTVHQzh2TENj?=
 =?utf-8?B?L0krOG80SEdnSkFIVW41VmprT0RJMnhkZmF3dkZ3aEhRcUVmT3AyNTB5SmdT?=
 =?utf-8?B?VHZzcElaTVJTYjk3STY4bFhtT0cwNElubHFqZDJYSkdNYjFjbVZ0WnozaERt?=
 =?utf-8?B?SHFCQ0RMZ095QzFpQkRqbm5XZGhDS1FhUlBpRGhLUkRqdnFCMkZKalFDTlgz?=
 =?utf-8?B?cDVaWlBQc0M0amFEaGlOK1BTVkZkeGYycU91bFgvS2xrWjZMQjhBNDVEeXFk?=
 =?utf-8?B?cDZtL3BoMk5ZRm1hdmRlOElvKzNXbnMxRjlrWTNhNVBpc2RBcTVaZEFqbHY2?=
 =?utf-8?B?R0tQbkEvckxhaWkvYnNTZFhEbFJ1VWZaSFFYcEEvcm1nSzJ0U2lzUXR5M1o3?=
 =?utf-8?B?cEF0RGtuVXp2cmJDLzh1WWxTQkx3Z1NZZlRwU3BhT0JhMFlPRWQveWd2Nzk3?=
 =?utf-8?B?TEVkMEhIR1hQc3h0Qk4xSFVMbmNwSGZKdFBiWXJoTkhEMm5iMHdac09aZ2ll?=
 =?utf-8?B?NWNYTHEvNGR3VjNsbDJiR01yMW5WOC81YlhKVkxDWkVBOUlCT05USG9KVGEy?=
 =?utf-8?B?UFB5bDVlcjFBNXZBNUJsV3dJUUZ0STVaYk1OdEU2QTNteDQzdGlmNjFPK2g4?=
 =?utf-8?B?YzRzelJmdEFJZkh0SjMrZkxVQ3RWR1Z5QU9FOFdjUEdJSllGMDRqaURKTnVi?=
 =?utf-8?B?Zkx3K2xXN1FQTzRYWFd6WjJSaG9WUjJuZVVEZEx5MHd6ZmhyNFZyWVZGWjlJ?=
 =?utf-8?B?UFNmZkoyQnMzV3ZjZDNjbWFYTEFvZE5zcnFJU0ZTZnQ3bmJzZUxBWFYrM1Nr?=
 =?utf-8?B?MnVpdlh2L0xtbUNZVFhGaFJlOGJVczRwaTFRQS9rYStqZWVMSHNmNGRnK3BI?=
 =?utf-8?B?T1RaRUxEN2lVRUo4dFBqZ29XK3oremJXMFhEb09hQUsvNCszNEFNdVlJRnBl?=
 =?utf-8?B?YjRTWnRIVXltN1VCS3ZZdmF2dHh6RCt5VGo4bkFJMDhoSGZmMnEzaytzS1M2?=
 =?utf-8?B?dHZWaVp4RS9yK0NGU0ZuTitUV0JYWXZjSnpLUGFVaUFOMWpTQ29DTjRoYlRn?=
 =?utf-8?B?Wk92SUp6TGRKdVY3QVd6SXgrajFPNGNiZ1BXY0ZGWVMvNy9WKzk2Q0lHelpo?=
 =?utf-8?B?L2FWM2YrMmxZRlV3R3VuRW1mS203WkpwVTdtRGRWZlJ5UEpDOUNmUjY5cTVu?=
 =?utf-8?B?ZDZKb1k4TVd6c3dpYnN1bXRXMXBWaXozU2VEMVpEdEdHQ1pGMDJraFNnRU5B?=
 =?utf-8?B?Z3hKVkt6Wk40Ry82Q2tMc1VQZDNCeEdGSU0yWUtHdG9OL05BT1A2UER0cUwx?=
 =?utf-8?B?dEk0NVlLaEdRNTBsLzVLaCtlVCtiL1EzbHp1QVVmTzN2MkRwbkVjTm1UM2Rj?=
 =?utf-8?B?TXRibXJ1QjJSTFQ3Z2cvUVE0WC90cmRxRTBNOGNhZk93UzR2eGpkZ2dtemt2?=
 =?utf-8?B?cWI2amYvN2VxOUluQWt4bGNoczJTZTFGclBSSkJGT3AveitnYXpHMTRaaWlC?=
 =?utf-8?B?VGVwbmgwcmttMklzcm5iWDdLSGFWT1l5NWk5WVVrcDhabXZJWDJPdEZBeG1q?=
 =?utf-8?B?VnozZkcxaEpPd1pwU1U1RDdzU1lvN28yVkdFc0M5UDkxVVB3aHRHZEhoOG5P?=
 =?utf-8?B?bmcyeEtaUjB6MXNXcG00MGdjays1eXEzczJVLzUzcHZEQmlIVXBiOFJPREkx?=
 =?utf-8?B?ZGN6eDM4SVZaMGlIRkVBL3hFdlpjNHVMMjM3ODlUY0cwM0Y0SUk4VzdYaTJZ?=
 =?utf-8?B?Qmc3UUVLUmpYbldNdDU4akxLRHFNRnFiUmdsd1hBcC9CWXN3QmFNcUhSTGpy?=
 =?utf-8?B?ZVBpcGxXd3EvT1N6MVRjK0o0VDNPZ1BPTWd4ejVLNE9iWXkzeTJNcEplWFZQ?=
 =?utf-8?B?NStFTEs5ZEtvZ3JxM08ybmhWY0xEWWhCOWdtT0hUNDhEZDlzR1BYYUZTemVE?=
 =?utf-8?Q?yHVw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf8883b-4188-4e34-9f8e-08dcee5be5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:29:24.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiBpfG/YdaQbxaVYdmp/00ksU+wC+1BCONUNyg1l04df3xGy3Y7EYLVnh15827sR0ndqM5j66C4RYBKA7/WujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAxMi8xM10gbmV0OiBmZWM6IGZlY19lbmV0X3J4X3F1ZXVlKCk6
IG1vdmVfY2FsbCB0bw0KPiBfdmxhbl9od2FjY2VsX3B1dF90YWcoKQ0KPiANCj4gVG8gY2xlYW4g
dXAgdGhlIFZMQU4gaGFuZGxpbmcsIG1vdmUgdGhlIGNhbGwgdG8NCj4gX192bGFuX2h3YWNjZWxf
cHV0X3RhZygpIGludG8gdGhlIGJvZHkgb2YgdGhlIGlmIHN0YXRlbWVudCwgd2hpY2gNCj4gY2hl
Y2tzIGZvciBWTEFOIGhhbmRsaW5nIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gDQo+IFRoaXMgYWxs
b3dzIHRvIHJlbW92ZSB2bGFuX3BhY2tldF9yY3ZkIGFuZCByZWR1Y2UgdGhlIHNjb3BlIG9mDQo+
IHZsYW5fdGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBw
ZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZmVjX21haW4uYyB8IDE2ICsrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXgNCj4gNjQwZmJkZTEwODYxMDA1ZTdlMmVi
MjMzNThiZmVhYWM0OWVjMTc5Mi4uZDk0MTVjN2MxNmNlYTNmYzNkOTFlMTkNCj4gOGMyMWFmOWZl
OWUyMTc0N2UgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFp
bi5jDQo+IEBAIC0xNjg4LDggKzE2ODgsNiBAQCBmZWNfZW5ldF9yeF9xdWV1ZShzdHJ1Y3QgbmV0
X2RldmljZSAqbmRldiwgdTE2DQo+IHF1ZXVlX2lkLCBpbnQgYnVkZ2V0KQ0KPiAgCXVzaG9ydAlw
a3RfbGVuOw0KPiAgCWludAlwa3RfcmVjZWl2ZWQgPSAwOw0KPiAgCXN0cnVjdAlidWZkZXNjX2V4
ICplYmRwID0gTlVMTDsNCj4gLQlib29sCXZsYW5fcGFja2V0X3JjdmQgPSBmYWxzZTsNCj4gLQl1
MTYJdmxhbl90YWc7DQo+ICAJaW50CWluZGV4ID0gMDsNCj4gIAlib29sCW5lZWRfc3dhcCA9IGZl
cC0+cXVpcmtzICYgRkVDX1FVSVJLX1NXQVBfRlJBTUU7DQo+ICAJc3RydWN0IGJwZl9wcm9nICp4
ZHBfcHJvZyA9IFJFQURfT05DRShmZXAtPnhkcF9wcm9nKTsNCj4gQEAgLTE4MTQsMTggKzE4MTIs
MTggQEAgZmVjX2VuZXRfcnhfcXVldWUoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHUxNg0KPiBx
dWV1ZV9pZCwgaW50IGJ1ZGdldCkNCj4gIAkJCWViZHAgPSAoc3RydWN0IGJ1ZmRlc2NfZXggKili
ZHA7DQo+IA0KPiAgCQkvKiBJZiB0aGlzIGlzIGEgVkxBTiBwYWNrZXQgcmVtb3ZlIHRoZSBWTEFO
IFRhZyAqLw0KPiAtCQl2bGFuX3BhY2tldF9yY3ZkID0gZmFsc2U7DQo+ICAJCWlmICgobmRldi0+
ZmVhdHVyZXMgJiBORVRJRl9GX0hXX1ZMQU5fQ1RBR19SWCkgJiYNCj4gIAkJICAgIGZlcC0+YnVm
ZGVzY19leCAmJg0KPiAgCQkgICAgKGViZHAtPmNiZF9lc2MgJiBjcHVfdG9fZmVjMzIoQkRfRU5F
VF9SWF9WTEFOKSkpIHsNCj4gIAkJCS8qIFB1c2ggYW5kIHJlbW92ZSB0aGUgdmxhbiB0YWcgKi8N
Cj4gIAkJCXN0cnVjdCB2bGFuX2V0aGhkciAqdmxhbl9oZWFkZXIgPSBza2Jfdmxhbl9ldGhfaGRy
KHNrYik7DQo+IC0JCQl2bGFuX3RhZyA9IG50b2hzKHZsYW5faGVhZGVyLT5oX3ZsYW5fVENJKTsN
Cj4gLQ0KPiAtCQkJdmxhbl9wYWNrZXRfcmN2ZCA9IHRydWU7DQo+ICsJCQl1MTYgdmxhbl90YWcg
PSBudG9ocyh2bGFuX2hlYWRlci0+aF92bGFuX1RDSSk7DQo+IA0KPiAgCQkJbWVtbW92ZShza2It
PmRhdGEgKyBWTEFOX0hMRU4sIHNrYi0+ZGF0YSwgRVRIX0FMRU4gKiAyKTsNCj4gIAkJCXNrYl9w
dWxsKHNrYiwgVkxBTl9ITEVOKTsNCj4gKwkJCV9fdmxhbl9od2FjY2VsX3B1dF90YWcoc2tiLA0K
PiArCQkJCQkgICAgICAgaHRvbnMoRVRIX1BfODAyMVEpLA0KPiArCQkJCQkgICAgICAgdmxhbl90
YWcpOw0KPiAgCQl9DQo+IA0KPiAgCQlza2ItPnByb3RvY29sID0gZXRoX3R5cGVfdHJhbnMoc2ti
LCBuZGV2KTsNCj4gQEAgLTE4NDUsMTIgKzE4NDMsNiBAQCBmZWNfZW5ldF9yeF9xdWV1ZShzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiwgdTE2DQo+IHF1ZXVlX2lkLCBpbnQgYnVkZ2V0KQ0KPiAgCQkJ
fQ0KPiAgCQl9DQo+IA0KPiAtCQkvKiBIYW5kbGUgcmVjZWl2ZWQgVkxBTiBwYWNrZXRzICovDQo+
IC0JCWlmICh2bGFuX3BhY2tldF9yY3ZkKQ0KPiAtCQkJX192bGFuX2h3YWNjZWxfcHV0X3RhZyhz
a2IsDQo+IC0JCQkJCSAgICAgICBodG9ucyhFVEhfUF84MDIxUSksDQo+IC0JCQkJCSAgICAgICB2
bGFuX3RhZyk7DQo+IC0NCj4gIAkJc2tiX3JlY29yZF9yeF9xdWV1ZShza2IsIHF1ZXVlX2lkKTsN
Cj4gIAkJbmFwaV9ncm9fcmVjZWl2ZSgmZmVwLT5uYXBpLCBza2IpOw0KPiANCj4gDQo+IC0tDQo+
IDIuNDUuMg0KPiANCg0KVGhhbmtzDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdA
bnhwLmNvbT4NCg0K

