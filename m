Return-Path: <netdev+bounces-206621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281E3B03BE9
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CE83A47FC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596B23E320;
	Mon, 14 Jul 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXFt9+A/"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42714315F;
	Mon, 14 Jul 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489061; cv=fail; b=Z28IusuTO4q6W0tNs2m6av3PJ2g3rCqSmlmQ7uwoTn5b8SQ85KDu/bTktt23nLQor+9h5zcpIfIb2pthzsrVT/VfQYqVTaw79LT8VY5yq3gkW5WUmO9ThVenyMoZSdQQQtCMPMaryZz+a9QG8OeCLrr2PkFyptCakaX9b3jNkY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489061; c=relaxed/simple;
	bh=ISlgbIKTv2v+IQ5XEOBeyxA/COVZvUO8fQyEuI/I6Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fc/vVnKUHYwXbBFyof3ACIry5mXqUsujhifV0gPCbDil49zc7rTlMykh3EIsBdZs/PVyoVYGuW55CktRVLAXObSW7vNOYLPoBjgXZ20ExWf67x2sTVVXEdfNClIS5g56GWK73dHtk3i7weURHoS3AjGmKWknWo8J29t43ooObIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXFt9+A/; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwLnClx/pPPCkNQIazwknuy5tkWyIiY0E5jeTi4VoPZ5g4TTVWqosXSRBlJ/T1JwLUjbKHswEl87K1Z+w5021VBfNq45A9E/bAKT8C0aNQnJKbH1s7E04Bnpbg4Zbxy/G3ge0c4jhQBYzYwFiPtHOJsxceKUVEehoq0f6Z8a+S1dyYVurCn4T3KQoUgmYv8dh4iBn+b8fFcoljBGs6XIpmUYmWDrV5GSLlCur71XrXKlyulpkioYXkGicoZvs5PtmJ5TeZIrrU2U+v/MbSTkIN1Rvllh8iXyJTsSlYn6nq4khYAi73m7kf5OtgGWfxZ6Ohn6JlIv+7Dlcl7WanW/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISlgbIKTv2v+IQ5XEOBeyxA/COVZvUO8fQyEuI/I6Pk=;
 b=a8TSNiHIfGXUiTTQ7h37Bk+sodnDs3Rj481RFYrgPy/d1xqv/Q8ZYw+FAMxe+EM28bJ7hvSGB3reoPubjawqof0JH/F/YGUdL0Po+pnyyogCWbZrOHuh56MuiqcEIYoHMSGfNv5RGcVTvtxd6yml5ToKIIa9TTaIyVrWfBsQ4GhNRsrOzPJiXfJZWNK/MW7riVkyWkH6ET9fUSO2JLu3jDexQxFUsn52WI47qZOhYjjNc5ggbsQH3uuxRIViFx3Q6OJyRgHnNo1gbApi6ukNMfFmHCK9IhlI4SgWT9wcYE9vzQYPOY534Hw/NSQzvnwEVt0zeZqZOAQTbVAK6AFLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISlgbIKTv2v+IQ5XEOBeyxA/COVZvUO8fQyEuI/I6Pk=;
 b=lXFt9+A/t9FDCuzKcVBqD4bjFcxwFabVGTGrYAExFqmRDsGSJyd59xIleC4GlT4+XWXH04Eo9f0fIt8lr9Jd8DwI1Is7BY5J18rEDITpcgbg4YiJnzw0Ci59NtAtCwHC2DZx7mM3EclolAqxXxhGgu6+H6Ocsy9dz+viBZStB08waz+w+gjuuMuIawKvsfgyIYABuGzbx4D2xGsE8Kb+D3NnLx8SjMdgZDafHY+XGQewKVsO2QcTS2fGfdRpTuOTIdSo1WeOzt74Yvgrm4G3sdM5cY3dGI2+jDBTpDmqsH0HOPRNbLIv+dhEi6gNGA8Nw9gtgMkUOpC66hmLnNib/Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:30:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:30:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAADLYCAAAJ0wA==
Date: Mon, 14 Jul 2025 10:30:57 +0000
Message-ID:
 <PAXPR04MB85108D63FCC52FC3B06CB6608854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <eade255e-cb83-4e2f-adf7-ee3747bf90f3@kernel.org>
In-Reply-To: <eade255e-cb83-4e2f-adf7-ee3747bf90f3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7515:EE_
x-ms-office365-filtering-correlation-id: 4c9fabab-4244-4da3-6118-08ddc2c184fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGNTQmw4RDBFS0E1TjNyVkV0dEZmeG1RMXNEd3I2L090VkZIQlY5amlQRFhF?=
 =?utf-8?B?M2NnZmY1cTBsVE5QS01tMCtRR2RQNStNald3cExqZS9rSEEzUzNvM2plU1hR?=
 =?utf-8?B?S3JlcFIxdXNHRWloZjNtbVBJQlBOaEhPNkU4VVhtaTlaMHd3QjcwKzlvYWQ4?=
 =?utf-8?B?R08rRDhpWlZUUnI4MlZNSVlYQzNjMzZ3VXU3SWJ4T0twUDFZaWs1SXNCUWtE?=
 =?utf-8?B?UTZOdXFmSnlDbCtMajA5QVBTUzhqckVkTEVMeUVCTitlK3lZeVVtNGRDOHVo?=
 =?utf-8?B?NHVnTW9QSFFRZWptWnUwZ0FiNXYwcG9DQXQ1alJKUVZPZ01qQmFTTTNESkFp?=
 =?utf-8?B?U081OVUrcDVHaHJucjVMd2ZuODVEbS9KVDhMYTlsTUs0Y1IrUHF4SGVXanpT?=
 =?utf-8?B?SXltU2pwNXVWOUwxRFpza1o4VzUzMm9BNnlLUWlNaHhIZVlQTitseURTTW5o?=
 =?utf-8?B?SFZQeUwxSzZNSEVwSUhWU2cwOHNkcVdtMHNNanZCNG9DQkJVaFN1OVlQNGdp?=
 =?utf-8?B?WFBsNWlCaFdLSHlocnQ5SWFqb1VGVVB5MnprVk9BaHZOc2dZWlRIM2o3eHYz?=
 =?utf-8?B?NWsxL0dac0wxamJVS3M3ejZZZlBCK3Z3Mm1LMktwL3RyQ0ZNaDAwbVh4ck9L?=
 =?utf-8?B?WG9STW9zV3pDR3VvZVRreE1Kd2FXbU9yZ09zSS9obExuNUl4dmlabTAvU0dj?=
 =?utf-8?B?NjZiNFZibDRnNzF5QVNmYTlEaDhGWHRDQU5VR3Fld2gwUkRUeUxWRXRUUElx?=
 =?utf-8?B?UGp3NEp6dkRuR1BhcjFMamxFNCt4MSs0bnBldysvb0t1VzNlWFVkQ0tyUk1R?=
 =?utf-8?B?N1loMEM5alhYdWpBaS9LMnhrZW1rdTU1UytrZXRTN2RCUHpyOEJXY1RENzF4?=
 =?utf-8?B?UXNhWnl5L0JnUXoreVdINC9iazJHanFodlhuY2xBVjRnSnRsemF6RWRlbEFM?=
 =?utf-8?B?cmJOZzlGb29vOUNwNXY0WVdLOUlGbjRLNjJ1RzBoQlIrY3k4Vi9LTWtpYWRX?=
 =?utf-8?B?ektyc1VhVUlrNGZkTHk3OHpHenNYZzUvc0xTVE9jSlhOUkJBMlI5ZW9ibzQ5?=
 =?utf-8?B?bTllcFVoNkZkK1JiVTJlMXlDK1psbzRpSVkyT0RZcEpxazg1VHR5aGo2M21o?=
 =?utf-8?B?Q0dFcVNtamZKeHlTTkpBbDNybCtPR2xYeEJsNC9iRmN4QWxKZmROMW1NV25R?=
 =?utf-8?B?YktFc29hdHUzbGpLdG9BMmRLa0J0Z0F5ZE9meGlpMUZrdVRVT0o4TEZ4M3R4?=
 =?utf-8?B?UXhFWXVTVzhPT2hQVTNORjBZeHAxRzU3WEp0aGNHM2k5YjRROUNOT2lzT1M0?=
 =?utf-8?B?eHE4NG0rOVlrV3NLcVQ0cW85enVwMmhVa3BCTnRGVTd0Y01QT1dNRnNUWEFh?=
 =?utf-8?B?ZXlCd1FKbXNtbmkrZEt3R3hYR3hRb1JFWnRzcWU5Si9IMWpXSGFtNU5qcGdY?=
 =?utf-8?B?VDVLOGZPRithSGk2T1lWdTJZZDhPVkt3a0IzTjNMaDFOMzN2UmVmaGlyVmE5?=
 =?utf-8?B?UzBqenFPNkxnV3Z5NlJYemhGZnhJbjBLM0tzVU15dlFBaGE1MUZDOGRSWWdm?=
 =?utf-8?B?N1BaZGtTUmE4aUdyVUxNeDNDcEZlTnZIVXpKSUVLSXA5bG55c1BUY1phd0xM?=
 =?utf-8?B?aVU3NXBUZSt3S0lGMEM1SVR0UmxKcFNRZkVMSEc4WHhGMnkrZDdrcEtleGI3?=
 =?utf-8?B?cy9zeUxiU1h1NDdYUzNFUVcybmxHUWtuL1RrTHdteSsrdjhlaDNBdXd3MUxG?=
 =?utf-8?B?dlZ4VVJka3FxL0ZCT214aEVrcmNPQUJtc0loMFduaVNROU1jTmN3S2MzMHdO?=
 =?utf-8?B?ZnorcTBDZ0g2L05NdzczbzZKU25DRmRCNUxweGN6YSt2THpHS1Y4NWtES0lP?=
 =?utf-8?B?Z2lEMTNPOU1heXlrNTJLUWxoTlJsdStPem0reDhScjVXSlpPcm01aTBRSzFJ?=
 =?utf-8?B?SS82Ny9Vc2pINUsvZG1keGZqT0wybHY3Tzk5TUI4ZC81SGIrOG9lYncxa01v?=
 =?utf-8?B?VzY5ZXZGKzFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUF1bUNLTnMrY2hFNXpURHVvVEpNbVg4MGoxb2ZzcmVnRnVYcmlyK05RRnhu?=
 =?utf-8?B?UytONXI2SWgvVU40NThmcWFXZDdyTGV5YklNQkZ3b3VvT1FXa0JRVFpUcCs1?=
 =?utf-8?B?RVFaak5MVmNMdmVkR1dMaUhzNVd0RVM1c2c1NldKME1LbnBEeWtMaHpISFB2?=
 =?utf-8?B?YlNvK3FhVmJFcXd0U0RFQkpUN0UzNURLUHRxTTA3VndHQjFNbVM3c2Y5Qzgw?=
 =?utf-8?B?TEwrQkdXaFVSNzJlSEpMbmMxUGlNN0VScWNDKzNRbVFBc2JFMjRvSVZzKzBq?=
 =?utf-8?B?MWRvVkx1NmpnRjR5K0FzVVUrUGYwbjVvdU92OVM5MitUZUJ6TW5oVVR6aWxr?=
 =?utf-8?B?NU1JWTFxNmJnVHpTK3hYTit2UzdFWUtEVnJiV1RhNkJXZDZubkdOSHNwR2hR?=
 =?utf-8?B?UnQwUEZBbmQ1WDRUZ1UySmJtZ21wdnFCb3QwQ3hFdVpkRWlaeHIvZHB2RXV2?=
 =?utf-8?B?U050T09FUjNYelFPK21GYytlYVNnM3RjVTRhUjZIRzFmMUZ0QXozeE5lZms0?=
 =?utf-8?B?Q2gycXlnZS83SkZhSnZCSk9PR216NWplc1ltbXBVaW5MQmcwbDZhTjRzd29F?=
 =?utf-8?B?RWlCeGI0cDBMNld0YXlyckJEbndyQmlJZTBBa1dKTGFQOW8rbjZEcGNEOER0?=
 =?utf-8?B?c1IxTVlWbVM3enR3dlZLZUlwMksrelg1cHRzSThmb280cE1LaldFS25saHFX?=
 =?utf-8?B?N3JUL0tIT2dNUzViTGY4UStBSlBRSW5vS2dTa0k3dUxhcnpUOEFRWXYweGZj?=
 =?utf-8?B?QUtIS1p6Y2NHQnB0Nkl3bzF2dEpwck5wbXJkVjg3T1ZYYzZZNmM2ZWF4Nmg2?=
 =?utf-8?B?VkNpSC81SkFCdkhUZHBHZ3YreWZUZzM3T2QvOG1ITVFIU1FobXFMNUdiZGxI?=
 =?utf-8?B?NmFCMUVJMzdRb1lCNDcrZHZDS3dZYmZCVEJxeHZoQ3MwK3puaTVnTG03Q21x?=
 =?utf-8?B?ZnNqdTNyZElUTGtNamh1OHRpaVFQM282VTc4dUN1OXdEakZ0Mmo4K1dRa3BR?=
 =?utf-8?B?MHhKaVhyY3JFY2txSVNsNWRwY0tqS0FaWlRwbWUzb0VRS3JBNGkyR05wQjhw?=
 =?utf-8?B?SlpuVm53ckFxN3R2eGRTYzBPbjhvU2tkS2FDK3NoRjhkZkVCRnQzaDJpSzhY?=
 =?utf-8?B?c0g3TVRRYm01S3k3SUVMeDl4OEhkdHBDMEE0N2RuMG9kMnN0TWRQaFBmNmpK?=
 =?utf-8?B?R0FOMElTb1ljaWQyWmVTaTVpV2Y0T0l6b1p5dDRXcERKazVMME5pdUNLUXVH?=
 =?utf-8?B?aGlrNm1CNmxTTmw0WXl1bDJIaGZ1TGZ6bUhnRDNuWWFPdWJLeTdsYUJjdDU3?=
 =?utf-8?B?N3RaT0p6T2FPd203akZqUnBDMEZaTDhyU3RIK3h6Yi9yeGNpd1NxczltNk9Y?=
 =?utf-8?B?N1JmMzcwSkdXS01IR2laektMWmRHQ2g4ektLcGpzUmd1SCt6YjBXTGZEMEkv?=
 =?utf-8?B?b3pnZjgxdTJSVnVPOTNlZzhyemFoSFF5ZnB2ZGg0OERTYlhmcjFFaDBDQ1Y5?=
 =?utf-8?B?bFQ5YXVCUE1uUXEyNUFZcEVpMUhGdFpnVm5oaXd3dGhSRVpKeDV6VnRnSnVw?=
 =?utf-8?B?ekgwZExZNGwyVmVLSG5aTFFOdmhuMFdRbWZXUDRnNG0rN2VnYXdNNUN1dWRx?=
 =?utf-8?B?RnBBbTNPYnlKUWRXNUtvamxqa0tFYi9DeHowWGJiRm9STko4VDEyMWhWcXhS?=
 =?utf-8?B?OE95S3g5SndCK3RmSVh3OW1NSTV5R3VLeVVuTTBlMHBzcTdOS3gyY3hyZHVa?=
 =?utf-8?B?a2NFN1p5VUlTQWZFQWQrRm96STVTeDh6ejFpMXpYWjFVM2hBYnFyR2s5ZFR1?=
 =?utf-8?B?WGQ3QWJxOWJNV01OZy93Qnd6QXE1dUJxQ29FYThraDJnZnczWlRKbUN4eU9t?=
 =?utf-8?B?UVMzZnc2b2RjNW9kOStUMUhoeGQzbStTaFpCaHo5OGNkUlhZL3A0M05UeVl2?=
 =?utf-8?B?TENmbUxDYUw1MHN0QnJxRXJBMk9SSGZaRXo5cEc5ZVM4b3I4MmhjOWc4TkdB?=
 =?utf-8?B?RmJITUFaS3dIN0RtWHV6Q3hjVDdZVEsvM0djN1ZQaDhMWmRXNnYrY09qeHpB?=
 =?utf-8?B?YlVodXRQeTEvUUxLRUVUaEJ4QUVIWmhqWXo5NjBROTVkcFMraE9ITHladnlt?=
 =?utf-8?Q?fU5I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9fabab-4244-4da3-6118-08ddc2c184fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:30:57.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8WZxTkh1yeW8tRDI3gwn2ajMWd/oPb/y4a23MtlVVNNe/CNbmM9C7k1KT7bN0Xvbqb8ZyeJjg/XP+kMEb0m8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

PiBPbiAxNC8wNy8yMDI1IDEyOjA5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9u
IDE0LzA3LzIwMjUgMTE6NTYsIFdlaSBGYW5nIHdyb3RlOg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IEhv
dyBkb2VzIHRoZSBvdGhlciBjb25zdW1lciAtIGV0aGVybmV0IC0gcmVmZXJlbmNlIHRoaXMgb25l
IGhlcmU/IFBhc3RlDQo+ID4+PiBjb21wbGV0ZSBEVFMgb2YgdGhpcyBhbmQgdXNlcnMsIG90aGVy
d2lzZSBpdCBpcyBqdXN0IHBpbmctcG9uZw0KPiA+Pj4gZGlzY3Vzc2lvbiB3aGVyZSB5b3UgcHV0
IGp1c3QgYSBsaXR0bGUgZWZmb3J0IHRvIGJvdW5jZSBiYWNrIG15IHF1ZXN0aW9uLg0KPiA+Pg0K
PiA+PiBCZWxvdyBpcyB0aGUgRFRTIG5vZGUgb2YgZW5ldGMgKGV0aGVybmV0IGRldmljZSkgYW5k
IHRpbWVyIG5vZGUuDQo+ID4+DQo+ID4+IGVuZXRjX3BvcnQwOiBldGhlcm5ldEAwLDAgew0KPiA+
PiAJY29tcGF0aWJsZSA9ICJwY2kxMTMxLGUxMDEiOw0KPiA+PiAJcmVnID0gPDB4MDAwMDAwIDAg
MCAwIDA+Ow0KPiA+PiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPj4gCXBpbmN0cmwt
MCA9IDwmcGluY3RybF9lbmV0YzA+Ow0KPiA+PiAJcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+
ID4+IAlwaHktbW9kZSA9ICJyZ21paS1pZCI7DQo+ID4+IAlzdGF0dXMgPSAib2theSI7DQo+ID4N
Cj4gPiBIb3cgZG8geW91IHVzZSBuZXRjX3RpbWVyIGluIHN1Y2ggY2FzZT8NCj4gPg0KPiA+PiB9
Ow0KPiA+Pg0KPiA+PiBuZXRjX3RpbWVyOiBldGhlcm5ldEAxOCwwIHsNCj4gPj4gCWNvbXBhdGli
bGUgPSAicGNpMTEzMSxlZTAyIjsNCj4gPj4gCXJlZyA9IDwweDAwYzAwMCAwIDAgMCAwPjsNCj4g
Pj4gCWNsb2NrcyA9IDwmbmV0Y19zeXN0ZW0zMzNtPjsNCj4gPj4gCWNsb2NrLW5hbWVzID0gInN5
c3RlbSI7DQo+ID4+IH07DQo+ID4+DQo+ID4+IEN1cnJlbnRseSwgdGhlIGVuZXRjIGRyaXZlciB1
c2VzIHRoZSBQQ0llIGRldmljZSBudW1iZXIgYW5kIGZ1bmN0aW9uIG51bWJlcg0KPiA+PiBvZiB0
aGUgVGltZXIgdG8gb2J0YWluIHRoZSBUaW1lciBkZXZpY2UsIHNvIHRoZXJlIGlzIG5vIHJlbGF0
ZWQgYmluZGluZyBpbiBEVFMuDQo+ID4NCj4gPiBTbyB5b3UganVzdCB0aWdodGx5IGNvdXBsZWQg
dGhlc2UgZGV2aWNlcy4gTG9va3MgcG9vciBkZXNpZ24gZm9yIG1lLCBidXQNCj4gPiB5b3VyIGNo
b2ljZS4gQW55d2F5LCB0aGVuIHVzZSB0aGF0IGNoYW5uZWwgYXMgaW5mb3JtYXRpb24gdG8gcGFz
cyB0aGUNCj4gPiBwaW4vdGltZXIvY2hhbm5lbCBudW1iZXIuIFlvdSBkbyBub3QgZ2V0IGEgbmV3
IHByb3BlcnR5IGZvciB0aGF0Lg0KPiA+DQo+ID4+IEluIHRoZSBmdXR1cmUsIHdlIHBsYW4gdG8g
YWRkIHBoYW5kbGUgdG8gdGhlIGVuZXRjIGRvY3VtZW50IHRvIGJpbmQgZW5ldGMNCj4gPj4gYW5k
IFRpbWVyLCBiZWNhdXNlIHRoZXJlIHdpbGwgYmUgbXVsdGlwbGUgVGltZXIgaW5zdGFuY2VzIG9u
IHN1YnNlcXVlbnQNCj4gPj4gcGxhdGZvcm1zLg0KPiA+DQo+ID4gQmluZGluZ3MgbXVzdCBiZSBj
b21wbGV0ZSwgbm90ICJpbiB0aGUgZnV0dXJlIiBidXQgbm93LiBTdGFydCBzZW5kaW5nDQo+ID4g
Y29tcGxldGUgd29yaywgc28gd2Ugd29uJ3QgaGF2ZSB0byBndWVzcyBpdC4NCj4gDQoNCk9rYXks
IEkgd2lsbCB1cGRhdGUgdGhlIGVuZXRjLnlhbWwNCg0KPiBCVFcsIGFib3ZlIERUUyBpcyBub3Qg
YSBwYXRjaC4gUG9zdCBjb21wbGV0ZSB1cHN0cmVhbSBEVFMgYXMgcGF0Y2ggZm9yDQo+IHJldmll
dywgZXZhbHVhdGlvbiBhbmQgbWVyZ2luZy4gT3RoZXJ3aXNlIHlvdSB3aWxsIGJlIHBvc3RpbmcN
Cj4gaW5jb21wbGV0ZSwgdW52YWxpZGF0ZWQgY29kZSB3aGljaCBpbiBmYWN0IGRvZXMgbm90IHdv
cmsgYW5kIHNob3J0bHkNCj4gYWZ0ZXIgeW91IHdpbGwgYmUgYnJpbmdpbmcgZml4LXVwIHBhdGNo
ZXMgZm9yIGJpbmRpbmdzLg0KPiANCj4gTm8uIFRoaXMgaXMgbm90IGhvdyB0aGUgcHJvY2VzcyBp
cyB3b3JraW5nIGZvciB1cHN0cmVhbWluZyBTb0MNCj4gY29tcG9uZW50cyBmcm9tIG1ham9yIHZl
bmRvci4NCj4gDQoNCg==

