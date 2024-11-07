Return-Path: <netdev+bounces-142598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F79BFBAF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770AB2828C8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2FFBF6;
	Thu,  7 Nov 2024 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1RTsBJd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C03D64;
	Thu,  7 Nov 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943394; cv=fail; b=ZqJxB9MqNrQTcTqEMmZBiysefObmnggx5nHtS5DBNhVI/lVzeybnxFdDtDw9U8lXi+uzhJFe9RdEPMCLSVmjRygtP4wZMg9lBbhVxURDribPx2vBxNf5qHjPsSnE09QkNP8Uv1NgzJRYZF3hVhobrAcD4jsj7IDP2JTeuu/zDdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943394; c=relaxed/simple;
	bh=1OGX1RSL7UtNeke1y50KzKjfOQHfgKynk1NzDJUUNm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwG6pNPqIUSEKY5ucdC0j0NCG6oEVU7VpdaPHfCHtO3JoMhypoSpUNphrnxWh2mNazPlR4/o9alG5xgTh3fE1NxGNyqg1gwRAnwhwiBkpGXlTZuJjwCwGY1B7353l4TOFO5+iiM7OPy5574sM/M57dMiup+BPU0kiJ0wk+X6zOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n1RTsBJd; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDZH4Pa8nOh9iKz1hwtoENfnJcBVwL8Hsevh+NPvypzPhiTakx53tuqvYrJk2HW1ynYEQqoa1UJnYvI2DcX8q3HbHOCqWJT7+H5ZRElFvXFRKS7LofcPxs1J13TC/DD+4yQKLC34Nd7+itfMyEjDAOR7Ewx51TrWDxsqvgOSpzuuXfpyRtSOSpgFs0+dpVy6SgU2jeJg+0cqteTeMxJPpQb/J1FEFYQnUE4R56u4gY8Qa5ubTV09UTEPIb8yi4zRDDs31cFRoIlDUB0oXcuGcTYOkuGd62QI8VKQAJZDXQG/TRCV7LeCn4jUkqHXp77s8P7+vhBDxmyX6BvlZVg8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OGX1RSL7UtNeke1y50KzKjfOQHfgKynk1NzDJUUNm4=;
 b=s/jIzVHQ+o6XLP3RHl/AUt2r/rJAVB/AcODi1KlOOPGfbwikoaNDFZv4e+WuCv1C9OTmf2yQuInCwGoi2mJZvfAoIuDX233HLlsZgkc0Xy7iIZE2xEUJrEkqD2hrbSOjti7EIN/pfcQXif2V0VbvHpw8C41zH2oHwZzqv9rGOTgoaPEGnSHZidis9qoZtiHtRWs0S6nYtHBTpesWl90O6/YxMath06EC6F/PE89LZYynCKzUiCk2DYGmBJdlutJL64qLqDldWQEUMZC/gyEd0BzgukhU7ZbbVYhwifxOJq/V2ZMP9p7jO8uZyK1pSdfK5jRRVkRqd/b6FKE/6fVdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OGX1RSL7UtNeke1y50KzKjfOQHfgKynk1NzDJUUNm4=;
 b=n1RTsBJdSCUqFLaQ3J5NyuJE3S1k7SubWwTJil53/iRz+9rM9ECHxcDaqQLEXP2SWXAJkdvyVzmJjcmuSGDTNL8L7aa6/efSNzT0tK5rtDv5Hwfo9IvcqWSae2qQWJSq/yX7rPQFBjQGn+bomd94pxLpJaEIZ4FVJk3aPhw+dCPYoVDy7nw53nyfDhbvYjBjXzLUf06vgSG1WUayicWQlB9yYCCVRQk9eqCoqtPMmTX3ivF4beWnyq/MZZgP6J/Wu6XXBbF/5tTCVu8MNT7URBv8uB326iMtyIS0kmw7oORWgQxpjZcwfZTmuQU6CZIR8twXOE1RJE7IQR3/aoDMcA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 01:36:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 01:36:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net] net: enetc: Do not configure preemptible TCs if
 SIs do not support
Thread-Topic: [PATCH v2 net] net: enetc: Do not configure preemptible TCs if
 SIs do not support
Thread-Index: AQHbLn6lxL+vpyyvmUe1oLeOGIyEt7KqWUAAgACzMdA=
Date: Thu, 7 Nov 2024 01:36:28 +0000
Message-ID:
 <PAXPR04MB8510EC6A0D1BAADEC54DDCC2885C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241104054309.1388433-1-wei.fang@nxp.com>
 <20241106143954.3avqol5m7j6i7hrt@skbuf>
In-Reply-To: <20241106143954.3avqol5m7j6i7hrt@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8422:EE_
x-ms-office365-filtering-correlation-id: 55017745-bdb9-4f60-3beb-08dcfecc99d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SmE1Y01wUlFkU1MvaEtCa1hWemNYMHRiUU4vYWRnMGdPUGcwVnUzR3JJNnJG?=
 =?gb2312?B?a20vaVh4QnNGRVMwdW1xb3hiMTlzZlhWbTY0M3RZQnM2R0ZQK0ExS3ZmYjlh?=
 =?gb2312?B?SjZLWHBHeDZyS2pqMFVBSGliY04zUkQyS2tDR0R2a2NIdUl2T2U0Zy9LTmVh?=
 =?gb2312?B?MGR4NFd1dDlFSEcxMUNKZWZReEhZWnZxRkQ1eXNDZkprZ1VwRXIxalhiREVW?=
 =?gb2312?B?MGF2aFZtRUVHVm1SQjdFb1V1bE8wTEJJUHFxVEwxcy9URXV6TDAxYUxxbVhh?=
 =?gb2312?B?OEFyWDh5Um9KTEVtM1lYS0RnV0VrNkVReWNST2EyVDJyWU1DZURTMUJzN21h?=
 =?gb2312?B?eGJiWEhVNmQxVjJ5MTM1N1FBckNQU1NoS1JBQzhiaTQyeEtXdHB6SzFseHkw?=
 =?gb2312?B?eWpZbzk1SDdsTGg1SzlVYlU5cDZwZiszL1Y2NldtSnBYS2RlaFoxN2ZBSTZN?=
 =?gb2312?B?NisvQ0lVVzNlRndidktNek10WVkvSkxneVJBSG93QkRYbzE3Qkw5ZFZ0aDk0?=
 =?gb2312?B?ODhPajlhM25SWlRXRHpzWjdUM2lwdUtLS0xFMVp6eWdtSk8vcEZVcnlUMVBP?=
 =?gb2312?B?MmM1VlhsY0xab2pWOXVIQXRMbkF1SFJKNk1kdWZBeUZ4WVlyYXlDSDdiWnRC?=
 =?gb2312?B?dUEvUGNMbVNkb2JmOGwvN2d6V0xoUTRoNDV6N1RwSGx4Z3BsbytrZWo2ejJv?=
 =?gb2312?B?TnJzT2Y5ZmNnNXp0bFdKby8yUlNwWUp1N1VvMCtBL1doNVJhZGt5WGFORVcy?=
 =?gb2312?B?QW5PM3VVYkNiclY5ZTVaLzVBNU9YUEpLQzhjdWJNSWlOVTFsVk9QejhYWE9l?=
 =?gb2312?B?SGpNNEVPQVF2dlgrL1JhbkpnWVdwaUFxajFyYkNsRGErd2RCS1lTZWg3WFpW?=
 =?gb2312?B?amlQVlpmeCtUV2xsMkh0Z2xuN2VLc2hsaWZmakNXY1M0MXlNSXkvdWpnZ2lx?=
 =?gb2312?B?dnhrNkhGVVIwcnZsZ2xzcmd3ZWdTSWNtdUdMODR3ZmZYVC9MZm9pdHJNRGhX?=
 =?gb2312?B?WFdkNVVyenYralJLNnZ3OUZNc3BEY1YxNXloWlFYMHBJZXQrSWVHdzhjbHI3?=
 =?gb2312?B?T2VEUzNoeFNSOERjczFYTGFyUXNPS3JUQ0EwMmlaTXRVZGtzb2huVmxSaUhE?=
 =?gb2312?B?S2J3L3h4RjFkUEU4T29xZVFGeG1rYUY4MVprYVpMZlFzZjJhakc3ZkovVmth?=
 =?gb2312?B?VDZFU3FvUVhic2F1WWRuSkpCNFh3QkNLOVl6MFpjU3ZtSHQ3bDRLU0tWU3ZT?=
 =?gb2312?B?VlA3R3IwSzF0NHo3SDRVS0toSUtZTTBmSG9ocnFpZGcyWG0zRFU0bXZvNWtJ?=
 =?gb2312?B?dEs3REhycUJnSGo2bndmenpUMldHSmFnQzU2UVNyb25Gd3VSTklTU0lpSXN6?=
 =?gb2312?B?ZE94bEpwWHp4WnZPS09QSjFIbjBCbngyN2hTRlhwdWtmSDRrQ0RmVDFrb1BS?=
 =?gb2312?B?TnZFeEt4KytSSEViV0FRcXo3Y016MEFuL01kZEVPbElzUEhOY1drM0hyREw0?=
 =?gb2312?B?OW5KbTlhYlQ4QXI0QUZtclh5eXdPdVZyVFNiQ1Q2Z3JkalFuMXFHM2NublEr?=
 =?gb2312?B?SFlQMjhZdklZZVAvRzhSbk1zUlJhRGZ1bkx6ZS9EYUZFdnE1SmIreHhlV1h4?=
 =?gb2312?B?RWxVaERqdGZ5UXZOYU16aEs1L05uTkhRRE56TS9Ha2xQVlBidXA2SlVhYWtr?=
 =?gb2312?B?bVRqT2phRFcrcVg0R0Y1dXV6LzlEU1dvbXNqZWJEUXFwZlVJS1JpTlpHV1pD?=
 =?gb2312?B?UVRSTG5aV3RacldLQ2kzZm9NR21PSE5jSGJxMmQwSUEwWXFzczR0ck5WVEVa?=
 =?gb2312?B?UWxqSHlDK1czNWtQZndScjMzcXk3WlAyWEZmMm9yR2dpUE1aUDR4bkxqZVZ2?=
 =?gb2312?Q?y8EMdiOEh3uOJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eFc2WjFqbjh6UHd0eXV1S3RzSWEwVUw1OGdCOVN5WUY1MVFxSVhkYmlaWjBW?=
 =?gb2312?B?SXdSaDZja25pWXZ4eW95Q09GSFR0RlRGYmdzMmI1amZjS1A4NnIxb0VkSnBE?=
 =?gb2312?B?enFOSm1CSXJiZ1BUbEhuQjVmYUQ4MGd1QmIwM0I4MHp5aUQ5VzJHbmlQM1pC?=
 =?gb2312?B?MHBNVzhoamdMZHNLT2NYekRYZkpnWkVhUDN2a0RWMk5QNEY3M095YmdYc1Jt?=
 =?gb2312?B?TFB6cmh3alByQXNjOTdCQm1La2dpNVpmZ05DeG5jR2ZsbGx5ZTI3eGQxSzI3?=
 =?gb2312?B?TDRnbmVFTVltOFJTdUExOWkyMi9tVjdUQ1F2UEJQTGhKdGEvVjFkZThtQkRx?=
 =?gb2312?B?WjQ0L0ZBQmUwcHQ2bzg2dENTREVhYTR4b0p1aEFuWnlvekE3NGVPNDJaeXVX?=
 =?gb2312?B?WTJKNzYxYzVsak9ROEpncVdicVdHTDBvTFg3bjlLRnlwbzNUak1OTFNqK0Nl?=
 =?gb2312?B?Tm4ydFNpbUFpZVFhcnlzS2dHWDEwcjZISWU0VVlwcWhKTkxISnZkN0dJUk13?=
 =?gb2312?B?Y3hWVGFlUmtyK2swZFl1NGNBZGp4cHhsUER1VTFEb2Nua3cvYmYxbjlSWGhI?=
 =?gb2312?B?OWFTZktoR0ZydnRTeFFXY1EyMXN0RS81QUFiWCtnM3krcGRmUGhWLzl4L09T?=
 =?gb2312?B?QTdRTzBXaXNpTkVEcCt0d3l0aXJSMll3QUlJeUdDUkNBNXdtY0FwSmoyZnp5?=
 =?gb2312?B?QTdhS1BVL0tNamk1NVFBZWw2YzcyUFc2YnVJazRxSTRkQllKTHdQSTRReGNV?=
 =?gb2312?B?WlQ5ZU54aCtjTmZBSzdGUnFtbXcyQm9QckVGdlA3T3BDYlNSbkxhSGhabGc0?=
 =?gb2312?B?bHZLTE1rVUVKMHZjT0wwQ3RqNjVXczcxZGdESWJsREt6bFp6M05xVjhhU2ZB?=
 =?gb2312?B?UUprdjlrM3MxTGtnSWhMV2hZL0N2OGQvMW5CM25HTG4zWHNKNEZIVTlWcFVP?=
 =?gb2312?B?Ri8vaktRSkt2RktlNjdFN3FVQ0g5MzRMQ0Q2VXJ2ZVlHMm92NTNZZ2JsQTZu?=
 =?gb2312?B?b2VDODVCcjBBdU11dHdlcHhQbktScXVHYTIrMlVhS0h3aHRyd0I3QlhLOGVD?=
 =?gb2312?B?ampHUzY2UGpNSDU1cG5ZNmM5NFVkOEVKNktoQ0s0WmZldUlXcmhaM0twRHdW?=
 =?gb2312?B?TllPMFNkbjgyb29oSVorYVk3VENEeDJIeG1mV09OK3d3QXpwaUVSR01TaXU0?=
 =?gb2312?B?NTVVVlVFaENJM2cvL0RSN0xCS1RyV1REakgvanZEZW5NdjU1MEJDbWdibWpq?=
 =?gb2312?B?TG8vRUlEcDljbmFVcXBDbk54bUhCTno3a0ZxVElBNWR6TytRdHROb0JTaTVy?=
 =?gb2312?B?VmdFUm1zOW5WM3hVNStscy8wWDE0cXFRRFB0OUZuS2llWmRoZEhLU05NNEI4?=
 =?gb2312?B?b0pveXV0MXJ2dVNnSnBUM215YUYxQXZJY3hCNlZvQ3BJUDFYclNXYVpKRjM3?=
 =?gb2312?B?M1gycW95YUlqTzJkVEZHa1E0QmVFb0d0cU1KU3JrWllBaC8wbHpZc2YvRWli?=
 =?gb2312?B?OC95NDdyNWdmbUZUZFdCWUxuUkN5RU1YWjdoRVdVdm9NMnB3UE5rN1dKTnB3?=
 =?gb2312?B?c2JrSWJURk9iZml3bStVMlJ6UXQxdTZSd2ZFQzBvYU13UitpWFhJYzJqSUdW?=
 =?gb2312?B?b0REcXdIQ0dHckZEVUNJZGdBbEVGQlVVbmhQSDJHSDVnT2l6YmhaNnBxVVI4?=
 =?gb2312?B?SS9rd3lxZnhWdVpiOGN4MXA3UEpiNjhqd254SWhmU1lEYVVNVXdRREIzeW83?=
 =?gb2312?B?SXBxbzUxRDIxY0VtWlFtcWZVYWtoYWg2S1Ura1VlMWoreFo5K0wzcGQxVDRN?=
 =?gb2312?B?YXpOYVQ5RjNVRGFjK1hoRkJBZ245MWpCRkRtc1JJVEJ0d252T2t2ZkRXY2dh?=
 =?gb2312?B?MDBIQk9HK1NaTUM1emNOdStZa3VlUHlXMmFwU2pmSDdPQmFkUVRsWlc3SVJp?=
 =?gb2312?B?UTVnSnREVW5sUEk0S1hTazNkeml5QW80NW5ManBMSUJwMEdhMEJoL004dEZi?=
 =?gb2312?B?YkgzV2tzUUE0Q2xLSGwxcjdWUDF0RUF4QkdBUFZLeDJ1TVJacjNJei94UHpj?=
 =?gb2312?B?QVcyVzJDWnZTb05DN3lSWnBGdTdZenB5OVVkUkMrV2JSckFzeWxwcU5ZTWNK?=
 =?gb2312?Q?fHws=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55017745-bdb9-4f60-3beb-08dcfecc99d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:36:28.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cyYQHdelWZ2rj9wo+s+5GJhRHf0jA6zPIf8w92HLT1keVe50d9vn79VWsWys8QePL8NzsQiiNsIFmEvJeDdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMdTCNsjVIDIyOjUwDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgQ2xhdWRpdSBNYW5vaWwNCj4gPGNsYXVkaXUubWFu
b2lsQG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgbmV0XSBuZXQ6IGVuZXRjOiBEbyBub3QgY29uZmlndXJlIHByZWVtcHRpYmxlIFRDcyBpZiBT
SXMNCj4gZG8gbm90IHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgTm92IDA0LCAyMDI0IGF0IDAxOjQz
OjA5UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IEJvdGggRU5FVEMgUEYgYW5kIFZGIGRy
aXZlcnMgc2hhcmUgZW5ldGNfc2V0dXBfdGNfbXFwcmlvKCkgdG8NCj4gPiBjb25maWd1cmUgTVFQ
UklPLiBBbmQgZW5ldGNfc2V0dXBfdGNfbXFwcmlvKCkgY2FsbHMNCj4gPiBlbmV0Y19jaGFuZ2Vf
cHJlZW1wdGlibGVfdGNzKCkgdG8gY29uZmlndXJlIHByZWVtcHRpYmxlIFRDcy4gSG93ZXZlciwN
Cj4gPiBvbmx5IFBGIGlzIGFibGUgdG8gY29uZmlndXJlIHByZWVtcHRpYmxlIFRDcy4gQmVjYXVz
ZSBvbmx5IFBGIGhhcw0KPiA+IHJlbGF0ZWQgcmVnaXN0ZXJzLCB3aGlsZSBWRiBkb2VzIG5vdCBo
YXZlIHRoZXNlIHJlZ2lzdGVycy4gU28gZm9yIFZGLA0KPiA+IGl0cyBody0+cG9ydCBwb2ludGVy
IGlzIE5VTEwuIFRoZXJlZm9yZSwgVkYgd2lsbCBhY2Nlc3MgYW4gaW52YWxpZA0KPiA+IHBvaW50
ZXIgd2hlbiBhY2Nlc3NpbmcgYSBub24tZXhpc3RlbnQgcmVnaXN0ZXIsIHdoaWNoIHdpbGwgY2F1
c2UgYSBjYWxsIHRyYWNlDQo+IGlzc3VlLiBUaGUgc2ltcGxpZmllZCBsb2cgaXMgYXMgZm9sbG93
cy4NCj4gPg0KPiA+IHJvb3RAbHMxMDI4YXJkYjp+IyB0YyBxZGlzYyBhZGQgZGV2IGVubzB2ZjAg
cGFyZW50IHJvb3QgaGFuZGxlIDEwMDogXA0KPiA+IG1xcHJpbyBudW1fdGMgNCBtYXAgMCAwIDEg
MSAyIDIgMyAzIHF1ZXVlcyAxQDAgMUAxIDFAMiAxQDMgaHcgMSBbDQo+ID4gMTg3LjI5MDc3NV0g
VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNz
DQo+ID4gMDAwMDAwMDAwMDAwMWYwMCBbICAxODcuNDI0ODMxXSBwYyA6DQo+ID4gZW5ldGNfbW1f
Y29tbWl0X3ByZWVtcHRpYmxlX3RjcysweDFjNC8weDQwMA0KPiA+IFsgIDE4Ny40MzA1MThdIGxy
IDogZW5ldGNfbW1fY29tbWl0X3ByZWVtcHRpYmxlX3RjcysweDMwYy8weDQwMA0KPiA+IFsgIDE4
Ny41MTExNDBdIENhbGwgdHJhY2U6DQo+ID4gWyAgMTg3LjUxMzU4OF0gIGVuZXRjX21tX2NvbW1p
dF9wcmVlbXB0aWJsZV90Y3MrMHgxYzQvMHg0MDANCj4gPiBbICAxODcuNTE4OTE4XSAgZW5ldGNf
c2V0dXBfdGNfbXFwcmlvKzB4MTgwLzB4MjE0IFsgIDE4Ny41MjMzNzRdDQo+ID4gZW5ldGNfdmZf
c2V0dXBfdGMrMHgxYy8weDMwIFsgIDE4Ny41MjczMDZdDQo+ID4gbXFwcmlvX2VuYWJsZV9vZmZs
b2FkKzB4MTQ0LzB4MTc4IFsgIDE4Ny41MzE3NjZdDQo+ID4gbXFwcmlvX2luaXQrMHgzZWMvMHg2
NjggWyAgMTg3LjUzNTM1MV0gIHFkaXNjX2NyZWF0ZSsweDE1Yy8weDQ4OCBbDQo+ID4gMTg3LjUz
OTAyM10gIHRjX21vZGlmeV9xZGlzYysweDM5OC8weDczYyBbICAxODcuNTQyOTU4XQ0KPiA+IHJ0
bmV0bGlua19yY3ZfbXNnKzB4MTI4LzB4Mzc4IFsgIDE4Ny41NDcwNjRdDQo+ID4gbmV0bGlua19y
Y3Zfc2tiKzB4NjAvMHgxMzAgWyAgMTg3LjU1MDkxMF0gIHJ0bmV0bGlua19yY3YrMHgxOC8weDI0
IFsNCj4gPiAxODcuNTU0NDkyXSAgbmV0bGlua191bmljYXN0KzB4MzAwLzB4MzZjIFsgIDE4Ny41
NTg0MjVdDQo+ID4gbmV0bGlua19zZW5kbXNnKzB4MWE4LzB4NDIwIFsgIDE4Ny42MDY3NTldIC0t
LVsgZW5kIHRyYWNlDQo+ID4gMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+ID4NCj4gPiBJbiBhZGRp
dGlvbiwgc29tZSBQRnMgYWxzbyBkbyBub3Qgc3VwcG9ydCBjb25maWd1cmluZyBwcmVlbXB0aWJs
ZSBUQ3MsDQo+ID4gc3VjaCBhcyBlbm8xIGFuZCBlbm8zIG9uIExTMTAyOEEuIEl0IHdvbid0IGNy
YXNoIGxpa2UgaXQgZG9lcyBmb3IgVkZzLA0KPiA+IGJ1dCB3ZSBzaG91bGQgcHJldmVudCB0aGVz
ZSBQRnMgZnJvbSBhY2Nlc3NpbmcgdGhlc2UgdW5pbXBsZW1lbnRlZA0KPiA+IHJlZ2lzdGVycy4N
Cj4gPg0KPiA+IEZpeGVzOiA4MjcxNDUzOTJhNGEgKCJuZXQ6IGVuZXRjOiBvbmx5IGNvbW1pdCBw
cmVlbXB0aWJsZSBUQ3MgdG8NCj4gPiBoYXJkd2FyZSB3aGVuIE1NIFRYIGlzIGFjdGl2ZSIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gU3VnZ2Vz
dGVkLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+IHYxIExpbms6DQo+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW14LzIwMjQx
MDMwMDgyMTE3LjExNzI2MzQtMS13ZWkuZmFuZ0BueHAuY29tLw0KPiA+IHYyIGNoYW5nZXM6DQo+
ID4gMS4gQ2hhbmdlIHRoZSB0aXRsZSBhbmQgcmVmaW5lIHRoZSBjb21taXQgbWVzc2FnZSAyLiBP
bmx5IHNldA0KPiA+IEVORVRDX1NJX0ZfUUJVIGJpdCBmb3IgUEZzIHdoaWNoIHN1cHBvcnQgUWJ1
IDMuIFByZXZlbnQgYWxsIFNJcyB3aGljaA0KPiA+IG5vdCBzdXBwb3J0IFFidSBmcm9tIGNvbmZp
Z3VyaW5nIHByZWVtcHRpYmxlIFRDcw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYyB8IDEwICsrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IGluZGV4IGMw
OTM3MGVhYjMxOS4uNTlkNGNhNTJkYzIxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiBAQCAtMjgsNiArMjgsOSBAQCBFWFBP
UlRfU1lNQk9MX0dQTChlbmV0Y19wb3J0X21hY193cik7DQo+ID4gIHN0YXRpYyB2b2lkIGVuZXRj
X2NoYW5nZV9wcmVlbXB0aWJsZV90Y3Moc3RydWN0IGVuZXRjX25kZXZfcHJpdiAqcHJpdiwNCj4g
PiAgCQkJCQkgdTggcHJlZW1wdGlibGVfdGNzKQ0KPiA+ICB7DQo+ID4gKwlpZiAoIShwcml2LT5z
aS0+aHdfZmVhdHVyZXMgJiBFTkVUQ19TSV9GX1FCVSkpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsN
Cj4gPiAgCXByaXYtPnByZWVtcHRpYmxlX3RjcyA9IHByZWVtcHRpYmxlX3RjczsNCj4gPiAgCWVu
ZXRjX21tX2NvbW1pdF9wcmVlbXB0aWJsZV90Y3MocHJpdik7DQo+ID4gIH0NCj4gPiBAQCAtMTc1
Miw3ICsxNzU1LDEyIEBAIHZvaWQgZW5ldGNfZ2V0X3NpX2NhcHMoc3RydWN0IGVuZXRjX3NpICpz
aSkNCj4gPiAgCWlmICh2YWwgJiBFTkVUQ19TSVBDQVBSMF9RQlYpDQo+ID4gIAkJc2ktPmh3X2Zl
YXR1cmVzIHw9IEVORVRDX1NJX0ZfUUJWOw0KPiA+DQo+ID4gLQlpZiAodmFsICYgRU5FVENfU0lQ
Q0FQUjBfUUJVKQ0KPiA+ICsJLyogQWx0aG91Z2ggdGhlIFNJUENBUFIwIG9mIFZGIGluZGljYXRl
cyB0aGF0IFZGIHN1cHBvcnRzIFFidSwNCj4gPiArCSAqIG9ubHkgUEYgY2FuIGFjY2VzcyB0aGUg
cmVsYXRlZCByZWdpc3RlcnMgdG8gY29uZmlndXJlIFFidS4NCj4gPiArCSAqIFRoZXJlZm9yZSwg
RU5FVENfU0lfRl9RQlUgaXMgc2V0IG9ubHkgZm9yIFBGcyB3aGljaCBzdXBwb3J0DQo+ID4gKwkg
KiB0aGlzIGZlYXR1cmUuDQo+ID4gKwkgKi8NCj4gPiArCWlmICh2YWwgJiBFTkVUQ19TSVBDQVBS
MF9RQlUgJiYgZW5ldGNfc2lfaXNfcGYoc2kpKQ0KPiA+ICAJCXNpLT5od19mZWF0dXJlcyB8PSBF
TkVUQ19TSV9GX1FCVTsNCj4gPg0KPiA+ICAJaWYgKHZhbCAmIEVORVRDX1NJUENBUFIwX1BTRlAp
DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiANCj4gQXMgcGVyIGludGVybmFsIGRpc2N1c3Np
b25zLCB0aGUgY29ycmVjdCBmaXggd291bGQgYmUgdG8gcmVhZCB0aGVzZQ0KPiBod19mZWF0dXJl
cyBmcm9tIHRoZSBFTkVUQ19QQ0FQUjAgcmVnaXN0ZXIgcmF0aGVyIHRoYW4gRU5FVENfU0lQQ0FQ
UjAsDQo+IGFuZCBoYXZlIHRoaXMgY29kZSBleGNsdXNpdmVseSBpbiB0aGUgUEYgZHJpdmVyLg0K
PiANCj4gSSdtIGV4cGVjdGluZyBhIG5ldyBjaGFuZ2Ugd2hpY2ggbW92ZXMgdGhlIGNhcGFiaWxp
dHkgZGV0ZWN0aW9uIHdoaWNoIGlzDQo+IHNpbWlsYXIgdG8gd2hhdCBJIGhhdmUgYXR0YWNoZWQg
aGVyZSwgYW5kIHRoZW4geW91ciBwYXRjaCB3aWxsIG9ubHkgY29udGFpbg0KPiB0aGUgc25pcHBl
dCBmcm9tIGVuZXRjX2NoYW5nZV9wcmVlbXB0aWJsZV90Y3MoKSB3aGljaCB5b3UndmUgYWxyZWFk
eQ0KPiBwb3N0ZWQuDQo+IA0KDQpPSywgSSB3aWxsIHVwZGF0ZSB0aGUgdGhpcmQgdmVyc2lvbiBs
YXRlciwgcHJvYmFibHkgYWZ0ZXIgdGhlIHJlY2VudCBpLk1YOTUNCnBhdGNoZXMgYXJlIG1lcmdl
ZCBpbnRvIHRoZSBuZXQgdHJlZSwgYmVjYXVzZSBJIGFtIHdvcnJpZWQgdGhhdCBpdCBtYXkNCmNh
dXNlIGEgbWVyZ2UgY29uZmxpY3QuDQoNCj4gcHctYm90OiBjaGFuZ2VzLXJlcXVlc3RlZA0K

