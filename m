Return-Path: <netdev+bounces-119052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AC953EF6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00ED281C01
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9F1E502;
	Fri, 16 Aug 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e8k7R/H7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AD372;
	Fri, 16 Aug 2024 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772353; cv=fail; b=jah1fv4pSqQm0w0TO8dEPGugTClp1Hvh1MFijBxJ7uo9sTMlSaAl7miKFBMhd67cnp+GgMoGmWvqoYYq2KKHtLzYRSmq7a79gsHvoJ9oleoamrLoew+xi7v02bm9hdYnDK9v4022l2upv1RsYV2wGNR7ao5PpDYhoN8WfeeJ1ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772353; c=relaxed/simple;
	bh=7WQ9B2CcrH29KBfbWf18S78LhIS5iPq9eaOv3Uwlwss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sa91ClLzwNdNmLklV5SDMGBKK8IaVI/8J2u16VbOq9SvYWy0uM6DeRCcKyiQBRK6FaXxcE5CfhtwZEzeo1Vp5BaOaOU4mUa+LONqzCsW5OaC61qDZipmhIOZczfx5FA1xCJ2cf0CdUQbqLjw5sTKDNb4geUmNcsTR3l7vCNdHns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e8k7R/H7; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAgw2ySvDMCQsVVoQHsSU0rfXEF568zKiWevA/q0DpulkGd939Ppw7pI5kL2I334IvX71KOAyoj3djmfqEQj2DPp//S/eKYXF3f5Cg6RaVPQS11LKSfy79hUvKv+6gRKYmk1BLyzbnEFfvurdpT62dBAEmqKWz8cC+eqeWp4LGYQSgrdnEBUQdMSuBdo+mF8pKxsQQEzqv1fBPo4ILFLertnpNZBxJvCAKDKKVwWvbPyVBOM8Z+bXYV7CHkFmmk8vVTa/IJCsS1nk/Leu2WZxJ3WGUvuJ8wOilRaHWd7uExnyVLTFc5vnrwbHf5ocAkdXIWbnXrO8AUT3WIEAItwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WQ9B2CcrH29KBfbWf18S78LhIS5iPq9eaOv3Uwlwss=;
 b=qb+qX86hTnEhRJBQ3OVlpz6x6DJVHIb/uKrza4QTKbLmMUd0OZk0ZTBpaZu8yfkGzAjeqvnZ3mQD0AO/lYJ4KUktkhe22lcvB6KZAZG2Tygop+LRUov7rcMMzTOAH/uwNIwbrprxS2ScoQ6iiWfo23RRQLB9IBgzOfLuPF1YOqfCsgroXsS0X9hZ4JYvjaxfImxZIrzB4OBgNBHuku8hTZ/8lLKjLDKZ/klYkZtlZpLroY4vNdmT1EjS53tQI4eunFbrZ6wNlVOuSoGtM5btiKz8+MlD1uHOWU0gw1gtLFxa7JIvrKJwlr7/+ewXx/rqEorisJHSbN8K7ZM5z/aApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WQ9B2CcrH29KBfbWf18S78LhIS5iPq9eaOv3Uwlwss=;
 b=e8k7R/H7CO8GJ1ydmHktM7gEik+Ip77KFJxAtPpz5msF75SckEN0zr33N6mMjY+6c+OormzKwhyh3LTnMFKdcsRdET97AntMrOzvQql9iiE6oivrIEwlQcEZBjYnS8xJSWLSNpK0UEdPEdj739/NTxy1buKLn6z0gCCfy/BpKtSFy5090FEc3XQSTb0OZZtetwGS1xmG0FANb1GWCkDTs3yOQS1qecBDq+uuD12JGgmYVJ2KicVLM9Kwe9xxTH8QXOmmX3j6DF4aV+nhLlgrqzuUnN+c4lk/B191PJ2IskQDRZZSy35IlrbbXhKfFScytiMfHwqmo0fKC04oPzhN4A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10104.eurprd04.prod.outlook.com (2603:10a6:800:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 01:39:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 01:39:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Topic: [PATCH net-next 1/3] dt-bindings: net: tja11xx: use reverse-mode
 to instead of rmii-refclk-in
Thread-Index: AQHa7tklv/4L4ggGKE+iM9Tw+y7ldLIoYlwAgAC0geA=
Date: Fri, 16 Aug 2024 01:39:06 +0000
Message-ID:
 <PAXPR04MB85108770DAF2E69C969FD24288812@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
 <20240815055126.137437-2-wei.fang@nxp.com>
 <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
In-Reply-To: <7aabe196-6d5a-4207-ba75-20187f767cf9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10104:EE_
x-ms-office365-filtering-correlation-id: 8f7fe8cb-9154-4c43-49f2-08dcbd9437e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?anRLdXNxTEtrM3ZtYTZYaE1WVTQzNWp2T0ZPUVh6VVRER1lxN1Qydkd0dkhC?=
 =?gb2312?B?UDAvRjlKVEw2Q3dsMnNGUmlZcldzZEZremJpblFab29DR1hPamIzd2lRaGlm?=
 =?gb2312?B?S0UvMFAxNklibktDZFFJUHBBaVMzZUw2QWZUeTJ3NGl4RHBxZ054MTl5bGVU?=
 =?gb2312?B?NDhJZ0NpRlp2RWRUa01rZ09BYXhqekFlS0VMUFk2UlNieXo2c0lwa2ZETGtm?=
 =?gb2312?B?cE5SZmZ1QktwTXR4ODZwS2FCdU1vWUVlS3NZSFNycTBDck1XbGdXdVVPcXpo?=
 =?gb2312?B?c29qa080d1kvVmlndEp0TFpSVStFd29rOEp0MVdzM1p2SHd1VDhNWVl2TDNv?=
 =?gb2312?B?bXBzT3hGSHpLa2V5QVFKSC8zK2N4ejl1SmY3RlVsbUZoU3RhcjhCUzUwM0dV?=
 =?gb2312?B?WW5nNGhvY2kxYUxnc2ZwZ0lCeXZaQVYvSGIwbnkzeGFsOEtOM2NMNThqemRQ?=
 =?gb2312?B?OEc0TkZraFJkZXVPZ1JETEwrSnlveUhTa1J1Ly8vQ0xMb1FxMkJETnNUM240?=
 =?gb2312?B?VVdxd1NYeEtITDlaM0c5blhvT3BrY0VNQVkveGpQYjJ5YnhtckxYazFIUW9y?=
 =?gb2312?B?cVRmd3YyR1NhMFJLck9LaldZNjllYUd6UWFsMkxBeWE3eERiejFGMGIrVFI1?=
 =?gb2312?B?YktjYTI4VFk1YmhsTFEyOXdOM1YrVjNaSkdXQjNiN0JpZis2Mnd3Yjg1RTZC?=
 =?gb2312?B?RDYraUw5elRoZGV2QURCSGNqVENCRWgzb2xZSXhGZndVS3NpbzdIY0xWRTJZ?=
 =?gb2312?B?eHNLV1JTQWJ5VFdOWVBhaHZ0R1hzdFdUeUhLcFZOSzBuQ292Yk8rRGNvM1RX?=
 =?gb2312?B?dWRrOFpTNXRLNzdSY0trZnlWMlNGbDBCZU96SmMwcFdSdk9qU2RvR2sxbFZS?=
 =?gb2312?B?T0dwM2RUeWJleUs4UjdCb25rM2pFaUZVMjJkd2dVOWtmL2J2ZjBnOU9LbzY4?=
 =?gb2312?B?YWNDUjIzQ1BhOTU2TmM4Z3lZMU1XOU00dUw2WGFPUjVBV3FCQVJIc0pqcWRR?=
 =?gb2312?B?bEJPd3pLWHBoYXA4NHFRMXVFT1VaNlVYYTJmNCtpZkIzUTR3S1VnK3dmSVZG?=
 =?gb2312?B?MkdqbXVJYzIrbWtDVXgrOVdMaHZBVWVuMGxXYjkwT1c2UWVXUDFqWTlwNU1P?=
 =?gb2312?B?VXZwYWM3MExsMlRkekNlVHE5RnR5K0l2dXdUTThWMlpoTmhaQzJrUkx1TXcz?=
 =?gb2312?B?OGk0MVZheXRIVCthUVl2WEovTnk4TlRETitVNXY5S1hHUlZWeGtHTFBiOVNW?=
 =?gb2312?B?eEtTNjZ1Rk9PS2t1dWlQYnBJenhYdHRTajdqTU9FdHNMUlRqQkl4dHVYQ0lW?=
 =?gb2312?B?UHMwMGQ4ME5wUlVnSjN0NHptdUpGdTVsMjV3M3EwNzhEUS83Sm9VTzZyRm8v?=
 =?gb2312?B?QmNJM3VoTW9McWNVMllqcU9xNDFWQXJnK0R0dTFlZnp0RjQwVDV0WitJUDdH?=
 =?gb2312?B?QUczTmk5VjhGdVkzaHJOYUNlVno5bmRCV0NtVSt0TGZYbFFzZVVWWEpqVkV1?=
 =?gb2312?B?THVxTDVjeTFkb2pXc0tYd1dzK0x5eGFKN1dCRmFONUx2WXcxRUxna1BZV1pH?=
 =?gb2312?B?Z0pvTHBMSG1Tdm1pTXJEWjhCN09UVSt0cm45Uk9JY2F3ZlJJZEx2S3ArWktw?=
 =?gb2312?B?Q2I5NzlDZGxScTdyck54Q1FKNXdzUDhzcFM3R2tOWmN5dld5RlplMlp3cFhG?=
 =?gb2312?B?M3JpeTBidDgyVWtYSGJ1MXJEQU1lVnJndjVSQlVVdmxBdHlZaEFtOEUydmhY?=
 =?gb2312?B?emhXQzZ0aFF4V3BnWXdkcHJaS0dmRFdDZ1hPY2J3TmQwYUk5azNpdGpjUTU2?=
 =?gb2312?B?YXloL3F3cXc2U3BNaWtmTUdZd0ZWbnlaMlNDMUg4Tis3NEFqckhwWWhUYmFm?=
 =?gb2312?B?Y0F0RnpaVWNOMHRHZERrTFhzNEZ1QVZ6bER1VU9Va2t0Wnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K1Z2aWVSQ01XZG5YR2J6cXplK1pVYTFRdnROSzExZXNKcnZlbDhMckt0RjZM?=
 =?gb2312?B?b09ueXlDUDBXcXdBQXE1ZWZaMkM1c1ZOS3NmNU01WXdoU1U4bWxUZDZBZnl2?=
 =?gb2312?B?S2dMZ3dKRzVzeXc5OHlkaEt2Uk1CNEx6Q3pBTU5tMnlwdkgrdVBjTDVCbkRk?=
 =?gb2312?B?eDJsdFRKRW0wQTFFR1VWYURnbzlvVVdKSG1IZnJRdytLSHdGVjBnQXdldVNN?=
 =?gb2312?B?MFRPOGNIQVlIa2xXbzliRmJNamgxVVI5R1dsVnlJUmtYUFhQYnhXWHhvL2tl?=
 =?gb2312?B?blhzS3lnUVFDZ2JZVFA4RmhTV05SMDNsU1I1VnRTSlZyYkpBVHhJMFZvbGlD?=
 =?gb2312?B?UGhqT2tyZ2M1WEUySU5iV1FqRmkzaTJMa3k1NHVMdXNCN2l6RjZDSzZYNCtK?=
 =?gb2312?B?a3VjZ2hJK2dnQUkzUlJnM0ZHWExBVXRYS2ltcVFKeVl2YVdlVFh2VEQ5Sk1T?=
 =?gb2312?B?QWduYnBIYVUya0tBSFJXMHBDTkQ0NVZaTVZ5SDF6SEhWQmxFVHJvWlNnNEJo?=
 =?gb2312?B?UjhOUnF1MjN3REtxaWc3OEZmb0IxdFpHKzZGR29KZEYzSFhtNmFHbG5PK05L?=
 =?gb2312?B?bFl4Q2JHOTh1VnlGM3VEMThXeXR2alp0MjlFaHk0d1FGUVBMZ1VFVFVDRk5p?=
 =?gb2312?B?RDM0TkdYTWtIUDJKMW1VeFhSR2RHaHk3RHpRb2JPUGRNWlBDa2xnaFA3RGMr?=
 =?gb2312?B?WlM5a0MwOWIwOVFtblVxbVlQamZBZzFHWjZlbEdjSmFKK0lsMm41OHA3UE5i?=
 =?gb2312?B?dWJ6aWRENXFaaHkyWTN0RnpOdHJaKzl2d3NQQ0VKcVdLckZzNElCK1NWSmFl?=
 =?gb2312?B?MmVDcDNwWUpaOHA0WFFYajB2bTNsWGdHMDhiWUlKbXFzc0pqZEtiVnJlLzd5?=
 =?gb2312?B?b0x1d2V3dEp3YzhxWmtwRTRsNHhEWjZ0b2pSZ3ltdnhGZTE1VmhFWlVJLzRE?=
 =?gb2312?B?UXdXSGZGLy9uNWtJRjJXN0JvNUVWeGhZK0JHTnFEamh4Rmx4SjRxTHlPTmdk?=
 =?gb2312?B?T1ZFMVZKTHVxL0ZYdzJNeCtraDZmbWNRQkc3MjFuZWlTOVB5elJwWTZqTTQr?=
 =?gb2312?B?R0M4SW4zcmNmbkNYREcySTF1MWxzOVZjSDZJb2NidkhMenJBd2VINWFZWU5Y?=
 =?gb2312?B?UnpGMlRwNy9wVEdzRlp3QUtwNnd2cEpMVCtBM25aK1dIb3pFajVYMVQxd1g5?=
 =?gb2312?B?SGdMN3JjSG9tZjhhZ0lyU21BMDdFRTNIMDByOFA2dmpIQmF5TkFxbXBhRitR?=
 =?gb2312?B?bGM0djJqTVp5QmZHZjZrZHRrd3NCYXcxaVdrR0loZEYybUlEeE1DWEx5Y0RI?=
 =?gb2312?B?MTN4US8xaEtPUFRHdm5wNEtrVlYvNldEODRBN0dGdWYrdGo5SFptYnRsU3Ro?=
 =?gb2312?B?b2RJR1hoSDNMS01IZC96ZWVUdVBwdUJaeWF5RHdxbHZXU2lMS3ZZUE9jbDBk?=
 =?gb2312?B?dkUwTWQ2SHMwbzRMTjlXUXl0RGUyc1Z1TnhUS1gzRDZPeEVGSlhNVnVraWtK?=
 =?gb2312?B?MXY4S2JYMTNOTGRBaCtVaW00T2VjeGV4SmFtRFEwcFRsK3JSLy9wSW8vOVli?=
 =?gb2312?B?U2psKzdCbURxTWpEWXc0QjR2M3ZPNTdKTi9FaGh1V2w1S0QrQ2VCWCt3dkxy?=
 =?gb2312?B?NlVzN21vcFJYQWI4MkZwZXVXWUhCTTUwTzlMRmJuNVdJeTIyKzZzOFhDRTMy?=
 =?gb2312?B?anVFV243VnV1SG14bThZclJ5dkg3ZmFpMEUvRk5abmo0SEt6K0JXK3JFdlNT?=
 =?gb2312?B?eHRteWJsZjZqTDlOVitDOGk1YTdCSFVxc2lFQ3IzSHFhaXgxWDFrTGU0L3VG?=
 =?gb2312?B?TU5SOTBQUGcrSEFKYlVWbWRnUk5lSlhOaFVwaEt6bTNwei94NXBRVWJxZkhC?=
 =?gb2312?B?clVxYlZDRndXTzVPSzBkYzVNY05hMHpsbGp3bUxMZHRUZmlDQXdOU1Njcmwr?=
 =?gb2312?B?dmNIZmY3MnNKb0E4UXlNTUVUVE1Lc1NHRXN3OFZaeEJ4RWovMktGUld5aU1p?=
 =?gb2312?B?ckw0WVoxK29mekprejg5dVpXcTZUK1dRdkN5SGtDNFJiNk0xdEU0d1JyVmJr?=
 =?gb2312?B?dTRXRlI4R1BmM1JaUnhGTWNZUUNOWVlWWWdtVWJsckFkZjdXcElGSVNlTmhi?=
 =?gb2312?Q?oRw4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7fe8cb-9154-4c43-49f2-08dcbd9437e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 01:39:06.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpk+54UGa63ubELwh+vwAzTswheT5h0exLS4ook54oyPYCZhp2LScdCLHSq4OXkpbD1YHO0S2k32XfbKNKNfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10104

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjE1yNUgMjI6MzMNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGYuZmFp
bmVsbGlAZ21haWwuY29tOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgu
b3JnLnVrOyBBbmRyZWkgQm90aWxhIChPU1MpIDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsN
Cj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxLzNdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IHVzZSByZXZlcnNlLW1vZGUNCj4g
dG8gaW5zdGVhZCBvZiBybWlpLXJlZmNsay1pbg0KPiANCj4gT24gVGh1LCBBdWcgMTUsIDIwMjQg
YXQgMDE6NTE6MjRQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gUGVyIHRoZSBNSUkgYW5k
IFJNSUkgc3BlY2lmaWNhdGlvbnMsIGZvciB0aGUgc3RhbmRhcmQgUk1JSSBtb2RlLCB0aGUNCj4g
PiBSRUZfQ0xLIGlzIHNvdXJjZWQgZnJvbSBNQUMgdG8gUEhZIG9yIGZyb20gYW4gZXh0ZXJuYWwg
c291cmNlLg0KPiA+IEZvciB0aGUgc3RhbmRhcmQgTUlJIG1vZGUsIHRoZSBSWF9DTEsgYW5kIFRY
X0NMSyBhcmUgYm90aCBzb3VyY2VkIGJ5DQo+ID4gdGhlIFBIWS4gQnV0IGZvciBUSkExMXh4IFBI
WXMsIHRoZXkgc3VwcG9ydCByZXZlcnNlIG1vZGUsIHRoYXQgaXMsIGZvcg0KPiA+IHJldlJNSUkg
bW9kZSwgdGhlIFJFRl9DTEsgaXMgb3V0cHV0LCBhbmQgZm9yIHJldk1JSSBtb2RlLCB0aGUgVFhf
Q0xLDQo+ID4gYW5kIFJYX0NMSyBhcmUgaW5wdXRzIHRvIHRoZSBQSFkuDQo+ID4gUHJldmlvdXNs
eSB0aGUgIm54cCxybWlpLXJlZmNsay1pbiIgd2FzIGFkZGVkIHRvIGluZGljYXRlIHRoYXQgaW4g
Uk1JSQ0KPiA+IG1vZGUsIGlmIHRoaXMgcHJvcGVydHkgcHJlc2VudCwgUkVGX0NMSyBpcyBpbnB1
dCB0byB0aGUgUEhZLCBvdGhlcndpc2UNCj4gPiBpdCBpcyBvdXRwdXQuIFRoaXMgc2VlbXMgaW5h
cHByb3ByaWF0ZSBub3cuIEZpcnN0bHksIGZvciB0aGUgc3RhbmRhcmQNCj4gPiBSTUlJIG1vZGUs
IFJFRl9DTEsgaXMgb3JpZ2luYWxseSBpbnB1dCwgYW5kIHRoZXJlIGlzIG5vIG5lZWQgdG8gYWRk
DQo+ID4gdGhlICJueHAscm1paS1yZWZjbGstaW4iIHByb3BlcnR5IHRvIGluZGljYXRlIHRoYXQg
UkVGX0NMSyBpcyBpbnB1dC4NCj4gPiBTZWNvbmRseSwgdGhpcyBwcm9wZXJ0eSBpcyBub3QgZ2Vu
ZXJpYyBmb3IgVEpBIFBIWXMsIGJlY2F1c2UgaXQgY2Fubm90DQo+ID4gY292ZXIgdGhlIHNldHRp
bmdzIG9mIFRYX0NMSyBhbmQgUlhfQ0xLIGluIE1JSSBtb2RlLiBUaGVyZWZvcmUsIGFkZA0KPiA+
IG5ldyBwcm9wZXJ0eSAibnhwLHJldmVyc2UtbW9kZSIgdG8gaW5zdGVhZCBvZiB0aGUgIm54cCxy
bWlpLXJlZmNsay1pbiINCj4gPiBwcm9wZXJ0eS4NCj4gDQo+IFBsZWFzZSBjb3VsZCB5b3UgYWRk
IHNvbWUganVzdGlmaWNhdGlvbiB3aHkgdXNpbmcNCj4gUEhZX0lOVEVSRkFDRV9NT0RFX1JFVlJN
SUkgaXMgbm90IHBvc3NpYmxlLg0KPiANCg0KQWNjb3JkaW5nIHRvIHRoZSBjb21taXQgbWVzc2Fn
ZSBjODU4ZDQzNmJlOGIgKCJuZXQ6IHBoeTogaW50cm9kdWNlDQpQSFlfSU5URVJGQUNFX01PREVf
UkVWUk1JSSIpLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQNClBIWV9JTlRFUkZBQ0VfTU9ERV9S
RVZSTUlJIGFuZCBQSFlfSU5URVJGQUNFX01PREVfUkVWTUlJDQphcmUgdXNlZCBmb3IgTUFDIHRv
IE1BQyBjb25uZWN0aW9ucywgd2hpY2ggbWVhbnMgdGhlIE1BQyBiZWhhdmVzDQpsaW5rIGFuIFJN
SUkvTUlJIFBIWS4gRm9yIHRoZSBNQUMgdG8gUEhZIGNvbm5lY3Rpb24sIEkgdGhpbmsgdGhlc2Ug
dHdvDQptYWNyb3MgYXJlIG5vdCBhcHBsaWNhYmxlLg0KQ3VycmVudGx5IFBIWV9JTlRFUkZBQ0Vf
TU9ERV9SRVZNSUkgaXMgdXNlZCBpbiBib3RoIFRKQTExeHggZHJpdmVycywNCmFuZCBpZiBteSB1
bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QgSSB0aGluayB0aGV5IHdpbGwgbmVlZCB0byBiZSByZW1v
dmVkIGluDQp0aGUgZnV0dXJlLg0K

