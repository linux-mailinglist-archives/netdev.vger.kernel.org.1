Return-Path: <netdev+bounces-207823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F99B08A80
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F853AE0A1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C098299AA4;
	Thu, 17 Jul 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pm51JoxI"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7528BAB6;
	Thu, 17 Jul 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748116; cv=fail; b=PQ12hvZgXxw67GxHeOeBOpjTQVAwmdkluRKEiYfDlDUamQZS3KyfiEWRBtEWFVQGVieHIzJi8q2pD295nGpQbSB51Kqxqp2L4twHZb7PD5YIhXY2YU+XQaHjBXOqjgfAYbMWQyp0DjQe2YV9irKQFLgOdmJwW+hfdN8KCSMbyjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748116; c=relaxed/simple;
	bh=hJjKk8B0ujVi7EvXBr3BNyQrVP6Vl4hHb49JgPQQbSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppuJj6eH6af2AGibSHahepxwRmbq5kohzR4roG26UEtv3K8Vnf2/yVKv34bj6grb82LLJYHUQkzll/xWupUgTdZDbHjrTicHCDGPhxJ48QD7kxLNhB+wvRyc20eaUW4L0KzuyiqNLlNYEZlKQL8JWLs7pzkHnabjkNdUlaTUnXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pm51JoxI; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+whp5A6U+g1lPAUkVPjP4KzWCZtpK3zbIOxVilT64mQS8CcYus/kB6T5qYBgmtg+wmoE7JVwuMup2JyHCyk12rxZYibdfdlWQrfmbh+ZjvNuXdpfHGzQSHV1/r0dwbJePTeNEcElBCq3v5agMdv6x+nG/G9RW66BHcn7Q0YxQZS7vE2XK3Gg/beg7gEIJHa3sy//JACimEHFtNrnYWlDpuc7/gTiUyk2LzZpO3Bd50+uPeh1roumQZRnL21wBpe9cgsf8Bs3RLPqDgVgSsu5/jzQhsI+cFuMgGoMIEUh/7MNpa8+AXWC08KYkVMIVmHFY3Fpp5etOqvmk6bSlwEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJjKk8B0ujVi7EvXBr3BNyQrVP6Vl4hHb49JgPQQbSw=;
 b=W5f8vrPhG3t7ew4eKjkiNvS73ZJlRDWuQcW5OJlWqfiHqmTEEGru4s4weI75HpAaJbnQsBg9+UhwQl/HsSIQgrbyJ/3T4/2ZIHn3qD9GU+EmkYMyn4mn1mBrqxIwWkditEeQqOT9cP8fAP8Kudqc9VKV33FNAQtLM4WeM2PUIAw8lWp/c/xhxvfxX5eKS8Ch+lnmlsGddADJEwFs4F4D/Wff1Tm+7JhqFv1OJOLetATd2iwFa/tGJ7Vy8LGnhMImnTSVrc+wj4h4D8QEY62MIby11hQR27o01/RqVpIIxCW+RgvZUM8AqZAVp1V9phKT9gUwQzbrnSVeeZKNXa50zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJjKk8B0ujVi7EvXBr3BNyQrVP6Vl4hHb49JgPQQbSw=;
 b=Pm51JoxIqGb0fh1a2e70h9bnDymR3I21pWRbSf+4cGYg8QLrPjpAZcdmt4XakteJdScT4HdZSK5REyG6tyF4nIf0t0yg/wOGSU/IDh7XoUfMntij8YfgQqMEql2VfjIzmbncljNqNzScIxTv4zp+JFLJxTpfimzjN2RmfAIZf1rC/ooUY0lY8V2wSEcTod0H2Emwx5FYnMFSqgn0QH9OC9jczo5fV3JNmnZ0t9W5aRr8qpyR43dHHIyNsmsphbqsBFRpcKHNhpJXIkHpkEQmJIz06sFE/h2Ny47mDg8KuG07Clul1y2PRnRqLHCZkE/o6tF0bhvdkqm7x51aadF2mg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 10:28:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 10:28:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Topic: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Index: AQHb9iZhkd5V4Hmtg0ufc8muIqXiyLQ178gAgAAHnYCAACCYAIAABkwg
Date: Thu, 17 Jul 2025 10:28:31 +0000
Message-ID:
 <PAXPR04MB8510F1755A7EFF016394FCCF8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ec01c2f1-7ab8-4830-846d-aa772e6cc853@kernel.org>
In-Reply-To: <ec01c2f1-7ab8-4830-846d-aa772e6cc853@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7918:EE_
x-ms-office365-filtering-correlation-id: 8d949fb4-e8a4-4ef7-8f7f-08ddc51cad31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aytGRUdreFBQam1RRWJrQm5qWEFxQzFlVjNGYy9KcE1BbDZTd1BqWFZjQ1Fw?=
 =?utf-8?B?a3JLZCttaUJqV1Jtc2pJVXQ4MFl2bDR2V2wvWC9OMHgrS1RxN0w4a1dDTno4?=
 =?utf-8?B?WTVJbjN6WUs1azRnQ2g0OFM2M0d3aGIyVEU2c0xnMVZ5a0RlSFo4d00zcnQr?=
 =?utf-8?B?ZTMyclZ3M25pSERJWFA3OFFCcDVqOExKUXFqaTNRamgzWGtUc1NLaThybXV0?=
 =?utf-8?B?bktMV0NTZzltUzQ2dGhxMlFEc2NpT3ZOVE1FNEhVN05LbVdvZXNLVEsvRlJS?=
 =?utf-8?B?NE5jNEgrbGpIZWZqM2R2c2VNT1VkT0xxRHZwaWV1c3RrVHFacFloZzEvMnhJ?=
 =?utf-8?B?a2VxZTFNN0lOU0djelFZeXdHbWxTdHlYYUREYmpxc3lxUEp2cmRTanMyOTJw?=
 =?utf-8?B?SmdOTGROMUFadVlsdHpXLzAzSHlQVTBDK0lOUzB4a0d0TjBNTVFuOEdxRjhN?=
 =?utf-8?B?ckZzSEVjMlNkMCtjdktFM20yVlNMcWFHTFRCQUwxZ3hYczhjaHl6M01iRVJr?=
 =?utf-8?B?eHA4N0FhZEI1R0pHZVRQYmwzS2NsaTF6VDJURlZQMjhoeGVxWEpKME1YbnhP?=
 =?utf-8?B?VjBXejZhRWZuUEhyQjVXazk3SzBNcFpqZGk2SVRMMFVhWmlpM1M2YWlBaEZ4?=
 =?utf-8?B?SWllcHVvU2I2ejR3ZlRabEdSV0Z6T3pJcGRTNll0ejF0YUxBZHRqako5UlFP?=
 =?utf-8?B?aWZYMnpRTXpOQ0dnS3l2b3dyUnphaEEzRXBmaitZdFk5TGs0WmJsK2VURWZQ?=
 =?utf-8?B?NGswWWg5elcvaWEycW1JSUVtQXBzazVxVFpwZ2gxMEI1TlhPLzl2MjVyWnFB?=
 =?utf-8?B?aFBMdXh6aDVXQVBNUnh1ZVFhOTFOM3IwQXd5WHBlUXMzMks5QVRRSUpKYXM0?=
 =?utf-8?B?VFBxL1RlOUN4eklRTmlva2RDQTlvVjdBSURyd2dxMFk3cmU0N0Q3ZlVDdVl6?=
 =?utf-8?B?UUVkdERnV1N0SnE2K0p1c2ZPYTVBN25JRmEwTHVieHhwZ1dIM01iaWw5bENz?=
 =?utf-8?B?cU8xeGhUZ3ViUVBxaUZHTVNzbmRFTTBsdDZXcXJSWXluNVZrRXRLdUMwWE1X?=
 =?utf-8?B?V0Y1cmdSeTBxQ0FCdFJtYlBrNTBIOWdUb2cvKzd5ajFXeTJrdmVxdSszVmVs?=
 =?utf-8?B?Wnh2VUFRMWZKSU1QNTIvc0ZaZ1lGZGxka3Rpb2Y5cXVvNFJ5MmpFSWxXZ05y?=
 =?utf-8?B?NVNjQUZPNlZ0dzYwVkROeGhOV2lkazNDcGRsNWpLMDFYeDlCN0N1V09BekNP?=
 =?utf-8?B?bWNyMlJNRThCZ2FVMzd2Z2NVNy9mWk1kejk1QXdzbnhoY1lpWTdtd1lDZnYv?=
 =?utf-8?B?RFhjbFNOeW54ZXpqT2V4b1N5OE04Z1VyV0pFMW5teVllcnlpTWZ4d3FWTEpF?=
 =?utf-8?B?TDRLUkdMUnhxNDd1MHFEQnVwb040YVBaSUZyVHpQc0pPZ01Sc25tUTlTc2d1?=
 =?utf-8?B?dlRrOTZqVVV2bFVyRFY3RktWa0xMU2JqYVJEd3JGTC9SSmJ2NTNZNzkvV29a?=
 =?utf-8?B?YkV2SnhNdjhmMUtTOFlyMHpMaVBuZkh0SzROYVFncUxMeU12aERaU0hTSDE1?=
 =?utf-8?B?WHo3SkFxaWRWdkk4MjM0ZWtVVUxvTEtWSEhLd1VOZVQ4ZzFnWGd3NFI5VjRF?=
 =?utf-8?B?WHF2SndFcjF4aGQ3eTRNZ21zRE9yWVZHWG1IWk5IVVBXYmg5b1A4TzhGK21D?=
 =?utf-8?B?bFpzZTNla1ViWWczcE9rWERwUm9OSmRDQXlwRldvR0MyVGJxa014QXpNdkk1?=
 =?utf-8?B?K01GSjJFbDRuV0U5MWE1VGUzdkc0ZHcvK2kxa081S1hmVVFHQTk0MGZkMXl5?=
 =?utf-8?B?emJFNnN0VHNpZ1Nlb0RpbVV0ZDBSZnFCbUlHUXpKbHY4dmxXOFZKZEE5WEx1?=
 =?utf-8?B?eDlJa1I5ZERjaDFkUkx1Q29pdWI4ZmNrWVBwalN4YUE4dlUvNjVuTFN5VG84?=
 =?utf-8?B?Yi85VTA3Z2tVc0M4cFIwNzgrN2ZLRHJhWTlFbkVkSURnVTZZTE1YdktsTDFx?=
 =?utf-8?B?NHhOOTNlTlZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akd4TlI1N0E4b0F5c1B3ZTJMaG5nUE1aeXVZUzN3K1BTWGZLNmpSSnUwUzY2?=
 =?utf-8?B?aFlHUVU1WGdrL1NtTkw1S2Z0cEJRRTFmMndnN0lWOXFiOGIyd3JxalYzVjF3?=
 =?utf-8?B?aTN1djBvZkFyTktuQ0lheS9NeitMVXdEU0UyUEJhTFpTZjVhRkZTMzJpaXNG?=
 =?utf-8?B?dXB3NzJ3UEFFRkJMam5pK2dibUJyQkFadldhYWUxM2FlRG5jcWxrdGVFS29Y?=
 =?utf-8?B?T2ZGKzF6VGszZUQrTXc0TGQrS0NDWk9wWExUSDZpWHVNd3lrMmdRQWhuQVFW?=
 =?utf-8?B?ZndoeWU1U00yMHJWdWlHWk41L0JQSDZsa2pzZ1FrTXpGNm50dmcwSlphM0tO?=
 =?utf-8?B?TnFtSEsxbm81MjZCVTZHSVFhWGJib1VkZHlzMVJJRGJpa3FwSjU1WlE0b0xl?=
 =?utf-8?B?N0ZwRXpubVNTUjEvY3lGZm52MkR3bkorTjh3ZUh2RFBHU1MxbVZnTWljRmJy?=
 =?utf-8?B?emJCOEc1UEpXb05NanR3K1dPZHRSdDlnZkgvM0llaFp1UzZXWWVjVlRpVFQ3?=
 =?utf-8?B?cWxacExqNDkvZTNaN0F3VWVSWndudmVXQlBCTkZsNEs0ZjhoQStsa3RSK3By?=
 =?utf-8?B?NktCQWdaMFlocEdhSGx2NDk0NHV5Q1hyZStNU1BueDVleXZNZUFYc1pETUtr?=
 =?utf-8?B?d210dVFUaVpvZDFobEltQ2lPYlV6MEhDc0svUVVZWUdNR1VWTTQ3enZFeC9V?=
 =?utf-8?B?V2xLV0g1UXFBbHZjVFdQNkxZNVJUUnpmWkFQREY2UGlCUk5QdmFNZmVaVXFr?=
 =?utf-8?B?OUpDTE4vajlRMDlKVEoxbC9mT04zdk8waWQzTjZXTmJuUXRoUW9QSjVZZDlF?=
 =?utf-8?B?ZXF5SS9adlpxT2RWL3F0bmxxSzNOejVIZnF1cSsvQU9SZFJZcUgzMTNsWisw?=
 =?utf-8?B?eWEydjJqRmtwOWRTSWsrMzVYZmFTNDJkZXA0SkY5NnR2Q1o4T0dVa0pjUHpa?=
 =?utf-8?B?UXJwVk9GengyRlJIelBEd05lMStTWEhXWUliMFVMN2dTTHF2WlUxa1YvU1F0?=
 =?utf-8?B?cXE5SlJoV0ZhRHR6dW1mSzNXQlZ4K1c4eG1hanpEbzBWRDYxb1pxYVYwSWdB?=
 =?utf-8?B?TnpobU4rRG5Mb2pIVFJtc2w2R3VpRUFtTFc1N2M4N2dpUGF5T05MMHYxeXVz?=
 =?utf-8?B?K2ltRW8yV2tyYisxaWJ6bGRDNDNkMG9YRjhHMmI4TmdHYWNTVTdzbDlrOWRp?=
 =?utf-8?B?ZmJYeUZLMThNdWtwK2cvZzdDMzA5aWhpakJ3UTVUcVBIWk5xNVhYcGFXV2k2?=
 =?utf-8?B?YjlRYXNzOFY0TS85MDFMbU1HS2dia3RrTHM1c2VXME1KVWk3em1rcmtSTnZy?=
 =?utf-8?B?VzlHQjdrUC9YWkMvQm5kSEhTWDNteXhZSTNiQ29rTDZoWC9BU0Y2OXBsZ2d5?=
 =?utf-8?B?YlYvSHV0L0orMDIrKzRIMWFXQjkrOTU3d3NSaUNRODZEZWRHNzlBLzBJTDdx?=
 =?utf-8?B?MGxmM2RQaUNrVHBTVWFGUFVvQjB5UGRxSzZnSStacllhaTRlamxhblpYMHZl?=
 =?utf-8?B?b0hOanhvNU5FYXlsZUViZzVtOGdrQVJ3dVI4L3d2OVVJd29QNFl3VisyajA2?=
 =?utf-8?B?bURWQTlCYXU0OHVkRWVEblZoRTE2WXVPVHJwTnVsS1ZFcmhRblQrY1N4RVps?=
 =?utf-8?B?QnFLUkRiVXhVdFc4YjhaMFFoZ2JJVDNnSlUwdk9VVFVTaW9lcnlRL2craHli?=
 =?utf-8?B?L21vL3l0bHAydEZtN2dTMks4ZmRqcUVSS3JwSjJJcFdSV2FTdWZWeVAxQ0I3?=
 =?utf-8?B?SjIvSlJza1JWWnNVUXM4OU9sM2xuOXJ1MjkzcU5vQ2NFVlZKT3hOdnpiTVFi?=
 =?utf-8?B?L2M2UW42dmc2d3dKQmIva05ZUW5INnBHRDNVVDA3M0tVNDRVdGwzbFF4UVpI?=
 =?utf-8?B?b1RmYmFwd0xBREkxQ2NielRYTTlkWnVhQXNiQUY5M0x2c0pmK2RCL0IxUnRi?=
 =?utf-8?B?M0NJOEJzSzR6V3pmdHNVeXA4Y2x5WkJ0KzNGNWNQa3lnOGpUY0RBSlJiTUJh?=
 =?utf-8?B?L3VZZHkxbCtPejR4amVWRDdWbVB2SWIzMmN2VzVEMGlTUzBUQXZsS3hQZit2?=
 =?utf-8?B?R3BjZlNlTXhHRGMrZ3ErWHY2VkJZWWxEY3FHSXR1dlhZbkhhN2RVZ2YvQjBJ?=
 =?utf-8?Q?jEFE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d949fb4-e8a4-4ef7-8f7f-08ddc51cad31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 10:28:31.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbqb6SPTc/9Xi/2C4xsCYqpjcljVUnftSM5BQQES0hfGWj2HOOWMs7pD3PewkhPDk0i7VJZevaWI+XuEsyjvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918

PiBPbiAxNy8wNy8yMDI1IDEwOjMwLCBXZWkgRmFuZyB3cm90ZToNCj4gPj4gT24gV2VkLCBKdWwg
MTYsIDIwMjUgYXQgMDM6MzA6NThQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4+PiArcHJv
cGVydGllczoNCj4gPj4+ICsgIGNvbXBhdGlibGU6DQo+ID4+PiArICAgIGVudW06DQo+ID4+PiAr
ICAgICAgLSBwY2kxMTMxLGVlMDINCj4gPj4+ICsNCj4gPj4+ICsgIHJlZzoNCj4gPj4+ICsgICAg
bWF4SXRlbXM6IDENCj4gPj4+ICsNCj4gPj4+ICsgIGNsb2NrczoNCj4gPj4+ICsgICAgbWF4SXRl
bXM6IDENCj4gPj4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+PiArICAgICAgVGhlIHJlZmVyZW5j
ZSBjbG9jayBvZiBORVRDIFRpbWVyLCBpZiBub3QgcHJlc2VudCwgaW5kaWNhdGVzIHRoYXQNCj4g
Pj4+ICsgICAgICB0aGUgc3lzdGVtIGNsb2NrIG9mIE5FVEMgSVAgaXMgc2VsZWN0ZWQgYXMgdGhl
IHJlZmVyZW5jZSBjbG9jay4NCj4gPj4NCj4gPj4gSWYgbm90IHByZXNlbnQuLi4NCj4gPj4NCj4g
Pj4+ICsNCj4gPj4+ICsgIGNsb2NrLW5hbWVzOg0KPiA+Pg0KPiA+PiAuLi4gdGhpcyBhbHNvIGlz
IG5vdCBwcmVzZW50Li4uDQo+ID4+DQo+ID4+PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAg
ICAgIE5FVEMgVGltZXIgaGFzIHRocmVlIHJlZmVyZW5jZSBjbG9jayBzb3VyY2VzLCBzZXQNCj4g
Pj4gVE1SX0NUUkxbQ0tfU0VMXQ0KPiA+Pj4gKyAgICAgIGJ5IHBhcnNpbmcgY2xvY2sgbmFtZSB0
byBzZWxlY3Qgb25lIG9mIHRoZW0gYXMgdGhlIHJlZmVyZW5jZSBjbG9jay4NCj4gPj4+ICsgICAg
ICBUaGUgInN5c3RlbSIgbWVhbnMgdGhhdCB0aGUgc3lzdGVtIGNsb2NrIG9mIE5FVEMgSVAgaXMg
dXNlZCBhcyB0aGUNCj4gPj4+ICsgICAgICByZWZlcmVuY2UgY2xvY2suDQo+ID4+PiArICAgICAg
VGhlICJjY21fdGltZXIiIG1lYW5zIGFub3RoZXIgY2xvY2sgZnJvbSBDQ00gYXMgdGhlIHJlZmVy
ZW5jZQ0KPiA+PiBjbG9jay4NCj4gPj4+ICsgICAgICBUaGUgImV4dF8xNTg4IiBtZWFucyB0aGUg
cmVmZXJlbmNlIGNsb2NrIGNvbWVzIGZyb20gZXh0ZXJuYWwgSU8NCj4gPj4gcGlucy4NCj4gPj4+
ICsgICAgZW51bToNCj4gPj4+ICsgICAgICAtIHN5c3RlbQ0KPiA+Pg0KPiA+PiBTbyB3aGF0IGRv
ZXMgc3lzdGVtIG1lYW4/DQo+ID4+DQo+ID4NCj4gPiAic3lzdGVtIiBpcyB0aGUgc3lzdGVtIGNs
b2NrIG9mIHRoZSBORVRDIHN1YnN5c3RlbSwgd2UgY2FuIGV4cGxpY2l0bHkgc3BlY2lmeQ0KPiA+
IHRoaXMgY2xvY2sgYXMgdGhlIFBUUCByZWZlcmVuY2UgY2xvY2sgb2YgdGhlIFRpbWVyIGluIHRo
ZSBEVCBub2RlLiBPciBkbyBub3QNCj4gPiBhZGQgY2xvY2sgcHJvcGVydGllcyB0byB0aGUgRFQg
bm9kZSwgaXQgaW1wbGljaXRseSBpbmRpY2F0ZXMgdGhhdCB0aGUgcmVmZXJlbmNlDQo+ID4gY2xv
Y2sgb2YgdGhlIFRpbWVyIGlzIHRoZSAic3lzdGVtIiBjbG9jay4NCj4gPg0KPiANCj4gRWgsIG5v
LiBJZiBhYnNlbmNlIG9mIGNsb2NrIGlucHV0IG1lYW5zIHlvdSBhcmUgdXNpbmcgc3BlY2lmaWMg
Y2xvY2sNCj4gaW5wdXQgaXQgaXMgY29udHJhZGljdG9yeSB0byB0aGUgZmlyc3QuIFlvdSBjYW5u
b3QgdXNlIHNvbWUgY2xvY2sgaW5wdXQNCj4gaWYgeW91IGNsYWltIHRoYXQgaXQgY2FuIGJlIG1p
c3NpbmcuDQo+IA0KPiBZb3UgZGVmaW5lIGhlcmUgY2xvY2sgaW5wdXRzLiBUaGlzIGlzIHdoYXQg
dGhpcyBwcm9wZXJ0eSBpcyBhYm91dC4NCj4gDQoNCk9rYXksIEkgd2lsbCByZW1vdmUgInN5c3Rl
bSIsIGR1ZSB0byBpdCBpcyB0aGUgc3lzdGVtIGNsb2NrIG9mIE5FVEMgSVAsDQp3aGljaCBpcyBh
bHdheXMgYXZhaWxhYmxlIHRvIFRpbWVyLg0KDQo=

