Return-Path: <netdev+bounces-238176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 372ABC5551E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E469C34E18B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C029E113;
	Thu, 13 Nov 2025 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T2rfhtFD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FD2EB5B8;
	Thu, 13 Nov 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998125; cv=fail; b=eOqTltKGChAnO34lKGxnkUZ/yj2mIs0rro7NoAp+f9+wqZl0SCmuZfwsdXK0DzzeihLuAojXUyF7sGXldypSzfGZLFoyLdNFPizcOSjTYowZNnZcBSoSNNl8a9cDEpj3PHlq0IP+mNqJEHhBd1ZtKu/jzyGcFZ+tQdZx3F1PNKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998125; c=relaxed/simple;
	bh=dF2qUYB3fAl8xKHy8JM0Qrj67TIWeNYtNr8on3YlWNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXq6UPG5+ktiX01E8xW0fq4zJebjIJYtpiaxdLIhJH+0FEGzniNdDw+nT55C+Rqr6fAWk9HeV+ix5JfBLw6Bulge065KcK2+kag4apGdqOAr6cvQIslPypIjM9s0flZ/CW01QUIq6Sd7Rm9B9ZRCOzLrFHt2DrAvXPlpdYD3MRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T2rfhtFD; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rphg93IUy0WMCTn281jnq2ETvdoWwDBgcrpRSaQIxNyxFtoBy1mXul7r4CDUNt+F/AcNSze3SeuiBQTQ/dWBdS0YGSpTk2VvQub/KuMSCpCu96NUf0BK3yqmmmmLz5lC4ETWPa3mp5J7xQY2QWV+GtSusir06VkPja34FaZwGShLn7TGAYSdSpPptmKa98S0DTFbR8bXks+wOGvgkCUlocdKZV+87PAS4nvFPqhd9pClWOaUxfr0A9BRrqreDxpoE19RZWTkxhnmd2U2rPPzr7jCH23BvsSmypAv3NNgSC9NX7z30bZ/ZTmDSYoTQnCneaxy1wbj1NnSbvJaTWkxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF2qUYB3fAl8xKHy8JM0Qrj67TIWeNYtNr8on3YlWNs=;
 b=uJliY9TTtRcHJTL6E/40Jt4sZ4I0bFkTdD5DUBGW+CRLN0wLHUig4Du0R7ICzVsce0f0xPEO4DMtWtk64lBaRCELZjFCkyIU3RXfHLy+AGNWTB4LwtgjfbRL1W6IYMRntnJBD7CU3FtaRNG3wuBAXiXTiJJcm/N/RCUPKCdAr267xYveF3Aqu8zdtAHQknSLM9YiLAJ53iQkbUFfJzv9fZVKqEH/SwYB9j4LPbZuO8Ynl9HLsYx/Br64oPJ923WKJjQ6oG6FFdsnTTBt2XAMekEBB/foNxZmOSmUnoYv17PZQr6gadMtSjwoh3RMbB61PkoV7C1FLMBiNg1g06zrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF2qUYB3fAl8xKHy8JM0Qrj67TIWeNYtNr8on3YlWNs=;
 b=T2rfhtFDj/XmRFshE1oEWf4B9AonNQDFvF29hOMu+h6muew6TmAKcrDn4tGYeAQ9QPuXNnMumJ2Wb0FjspE/V5qkq0bFoD1PIi1zCTxAGxTTowNPjbyVL2ajNuEm+7VLKY4LWmvdSijL+f6cKMfN4GZB44jB3bKM1/AvktygljOH/9EhzIlw2KQ49jyHXfn1HpbBbXReSHL24NNfghhVrEZR9flDCL/OEQqoKRjhPAdx620meDkt8v1C0vg5To02mcwnBkXxA+LEamAR6X7zEwHr87lNkANfK03FLLWsxGqrnU90Oj5OmBwSPcQI6wqPb/hf9eKHIlS6Ee5vt0HMVw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA3PR04MB11106.eurprd04.prod.outlook.com (2603:10a6:102:4b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 01:41:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:41:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Aziz Sellami <aziz.sellami@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Topic: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Index: AQHcThB8B/EmTKsCu0Wd8Fe2HUqMMrTs2uCAgAAVb+CAAI4ZgIAAAklwgAJgPQA=
Date: Thu, 13 Nov 2025 01:41:59 +0000
Message-ID:
 <PAXPR04MB8510284B67712788C5F169F988CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
 <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
 <PAXPR04MB85106ADEC082E1E8C36DA65188CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <d43743aa-715d-43b3-b00d-96433a85f5fa@lunn.ch>
 <PAXPR04MB85100E644E9508F3362B470488CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85100E644E9508F3362B470488CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA3PR04MB11106:EE_
x-ms-office365-filtering-correlation-id: 98e1faaf-190d-4c5f-c027-08de2255d666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2crOThicGlzRlEzMVB6OG1xWUZsaXdEdkZldy96WVFIMFovNGtkYW1BQnRp?=
 =?utf-8?B?WVBReHRpOGdGK0ZqRXJTQ0YxMXRHaG9xTUZlamE4aVplYWNFQkhZVHkvdWw0?=
 =?utf-8?B?bDNQZXhKNW0xWVNXcysvcFo4UHVxYnE1ajNSQVdhNFR3ejAvMElVbTRLSjhp?=
 =?utf-8?B?eGJGV2MwNG5qdk1ReE9VekpsdFVYNDQzNUJsSkpXOGlHK2lKVDVReEkrN1Q1?=
 =?utf-8?B?YmpDYWRCNW5QbURGaEljSkwvRE5qaUYxN3F0NjdOU3duL1Zxd05xZFhLbU96?=
 =?utf-8?B?WGNCeVlOUTJrY2drS2hCOXo3Mk4wQ0p3SnB4QzJ1blR0MUpIN2R0c29ocEhq?=
 =?utf-8?B?UkE1eUZRQ0JzU0pvZ05JOGRxc2dEYlBXV3krZFVYOCszVXgvVm1aVUlKRm9R?=
 =?utf-8?B?RXUvSy9OUXE4VEJpVjYwd1lzdnM5N3ZZM0g4S3JHREZDVVExWnpzaVFRODg0?=
 =?utf-8?B?b1lkRzhDYWlZSVk2Tmt0aDI3dnV4MDdxYVBBTjM4UktMMjhVWjBqd3JORUZ4?=
 =?utf-8?B?TU5LU242ZEFVbllqNW9IL3JJTmRObElUT2VKaFJiZnlVdXJpeFA1ZE1YQ2hw?=
 =?utf-8?B?Y3BWUEFpZklPZlRWTE9iekIybzhMZ0NuVFJTMk9KTmlISFRIeTNBSm1xOFdx?=
 =?utf-8?B?V0UwNTdKRnQ3TlBkaUZPZzJRRGRDcTUzMjJmNUJwQkNLTy9mYysyVHBGams3?=
 =?utf-8?B?ZzdSZkJQVXFmdUdHQnRiTytIR3gxdXJZS0hXY2pycGFvSEF1N3NYcDBDR1FP?=
 =?utf-8?B?U2NkcU5wRExHWUhRVEdsdngyRXY3TEt4RktCTHFUemJCMFNrMk9WM00wSFZs?=
 =?utf-8?B?cUNIekVXcWUySFNEcFFUTzVqY1NXTmVuZFJ1NHBvZXM1ZUtiQitydm1QMkxx?=
 =?utf-8?B?WFlIZEtJRkc4ZnRIV3VWRFFhUVovMXZMN1J2SzZjNzVqT25TSFpoNGRkUlpr?=
 =?utf-8?B?SHMzSitZKzY3aCtnbFdkMGUzeTVZVmlzWWZGOUtmZ09va3RLR3Y3MWxGK2hj?=
 =?utf-8?B?WnZMbEhYTWxiMWFsUmZzUG5CV3MxL3V5NHBNWjBLQzRhQXZWY201WFgyNUVP?=
 =?utf-8?B?UjR4NTlMN0JtNzd3eHZ1ekNiSzBsK3B5ZEJML1o3WG00cHBiT2VEM3Yvcyt2?=
 =?utf-8?B?RVluOWoyZG5SQ0d1WTB5RTh6OHhJYWw1c25kVElPYVBLVTdBMGVQeG55M0Zp?=
 =?utf-8?B?RXhXNy9tR1pXbDBOaVQ5Zzl5L2g1aTA1SEk4ekZCb2JlV3YrWG5ERFM3VFBR?=
 =?utf-8?B?d0NFcDNwUVhCK2ZVMnVxQy9uY2RJeXZHWDBQdytxR2I3bCthSGxrcEl2ZTIv?=
 =?utf-8?B?S3BLTllpY01NTm9uQnM2bEtSMVg3RWQyUVlGQ2k5a0NLaHRyUVBMS1JHRGdQ?=
 =?utf-8?B?NlcxcGdYZHNHUFRoNDkxV29WREd5NkN1ZmhEamhQckl2ZTNvV09jYllEUmhJ?=
 =?utf-8?B?QlhkZlFiN3pIdVF4UFc0ZktHWGZjaTNYL1FrU1RhbHpWT1ppWnlra0RKZ2kw?=
 =?utf-8?B?WUhYcnFzOHM5cWd4MVRtMUFaMmhycTJjU1l6RUpzSzZDc3hDWSt0NERUeVRi?=
 =?utf-8?B?SHNWNFNyRElEdHFmUlVZL3hIZUFpaExseDZFRkJCWTVRQnJtRnJlc0d6Z2xX?=
 =?utf-8?B?K1FoM2ZGQnJTa0NSOXMyOGtOZmlxRUt6QXluMHhjc3d0REJDdFc0c3ZtZDRj?=
 =?utf-8?B?eTlrRW5OelU5V3JhREtueFFlZU9aU0NzWFFmMjF3dDU5ZWNVNitGcjl1bVdx?=
 =?utf-8?B?QXBqL29QOS9hQVRieXJmU1ZJTUFaK25MMG5pdEhsb2lIVzFxYkt2ZXh5SEZn?=
 =?utf-8?B?Y09DV0ZPMUJEY3FOUHQ4YitEalFFZ1QxdE9QejlOSDdTcTRLalRBZGZ3N3JM?=
 =?utf-8?B?OGIweFROV1RZZnhYRjNrMytIWU83RVp0b0RmVlE0OWhOR0ZJYzN3K0hCS2E5?=
 =?utf-8?B?V2Yxc1RLbThsb3JrcFdNY3JKUXViaU1OUXBIaHBDeVNhZ3ZwRkx4ek13UnNT?=
 =?utf-8?B?OHF5UUhGVmFhVk5CazN4ZkhxSlE3dzNwNlBteFRoUDkyMHRyMStuVTB6REw3?=
 =?utf-8?Q?e4LZG8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEc1ZTdFSExuM2F3M1Z5UUc3ZEtNeXNQK1dxVXB0UldmNEpWVkFGejVGTFQy?=
 =?utf-8?B?WkIrWU1QRk5VdTErYzVRdUQxdkYvSmlWOVpVemJIMGNUMFJOU0hoSGo3ZTBt?=
 =?utf-8?B?UW1SVU43bDZkMDBJRzU1MlJQYUltd3FOVkFvSWF0V0oyUkJQRk4vdG8wVDhq?=
 =?utf-8?B?M2xzZFNPVkM0cjZpRUNoNWVHZ2E3ek5saHdxTlpBbnpZdFJITEdFbVZFY1Vw?=
 =?utf-8?B?RGVHUll5UlQ1S1FIQUFHMzhKb3dFc0NGZXU4bnpSRnRDaGl1aUJyUmRUM3VD?=
 =?utf-8?B?T1BRWW9XYUJPdXo2bkRFcmN5My9GU3ZRUFluVVhKMUZBVFA3Zk1xYXJPeks0?=
 =?utf-8?B?U1hXcG5zRjNWanUvYlpyRjV2S0ZoZmZhdkFFeW9YZTRnNS94c2IzakljVHds?=
 =?utf-8?B?Z0xMRjNpZDc5UFZyV09ZVWlITndHa3g3MHBwZ292WVVZWGxlV3h0QVgvc0Nl?=
 =?utf-8?B?dFIyK2kxTkJmUXRVc0dLSW1RbzVSS3FHcy9VNDVKWGhjbFg2REJTWlRMSWwv?=
 =?utf-8?B?eWNETWY1YkFLVGlXTWYrRk1VdjAxYXYyaFE0YTlpOUlXU3RYRjhOKzBPRFcw?=
 =?utf-8?B?dHJlZkNYanI2SG0zY3M2Q0pISHRHY29ZMkJ2N3VaSTl6NGI1NVhGaThMZFJx?=
 =?utf-8?B?VVBRMnJqNS90Tnc4anArR1FESWg4V3p0d3E3aVp4N3FFaHRiK29ZMURaMmdX?=
 =?utf-8?B?R1BlZm9hT0xvQXF6NkdGV01QT0hVZGNuY0J5eDRJb2tkbktuTWJ2Z3ZRTW1T?=
 =?utf-8?B?UW4zUHB5eXJhS2hZeStObi8yeGFFSDR5ZU50bEtUQldmSG1TNnhZeUdTb0Jj?=
 =?utf-8?B?bTE0OHNKNTdxb1RUSUIrc1pvaWRxTVBWeDNvam5oT0RGVmZiNkdWcThHWGN6?=
 =?utf-8?B?NHA4Q1lVL3BzRUovZHVtdGx1TUpPU2xYWnd1NFp4VTdmUTFZRkZyZnl0RlRj?=
 =?utf-8?B?VjBGOHRkRlZ0eEk4bXNlWXQ4RGZ0eTU3MHR2QVd1TDFXckVKKytmYWp0SkNV?=
 =?utf-8?B?RlZPQVhWQmJIWUNXYkZybWtNcWc2UGNJRlROemhUWXNINnV2emlzT3FKV2R2?=
 =?utf-8?B?VUhtcWRUVWhYYWx2akZUT1JpZ1RueFo3MkNXWXI3anRHOEF6NWRBcFhSUFY3?=
 =?utf-8?B?SmQwMlF0ZGt1RTNrTzh2ODE4Z2VqSmdGc0k3UitGQ25mUFFCY0NpeXlLUFBo?=
 =?utf-8?B?NDd5UFhVMHNqaXhYcHd6UVNsVUZIQjJOVGxFVXZIek1SNkNZVnpleERqMnM2?=
 =?utf-8?B?a3hLZVM3WlBkSGhpb1Q5bUxTTnU4L0k2eFFkT2lKOGNUZG5kRDBUSkNab3Ew?=
 =?utf-8?B?NGVlNEhTamxLZmprRGlJMWxOL0F2TmR3U0JMRFVVbDFCSzJNYmFML0tMOUt0?=
 =?utf-8?B?NnJKQnpnMkEwamFRc3hvR0Urc0k0MlE0ekJMMzdMUjRjREQwK1ptMXlvU3ZP?=
 =?utf-8?B?cmNmT1NSK1hRdHhJUnRGTVN6QWJZbVRmd0c0RWlEOG1mNDUxcExFQmt0K2Rs?=
 =?utf-8?B?VmcxNFpLV29vclNLWFZtaUFUQ0UyZUVhZjVvUlBuVkZUTnZUT2UzUCtpd2h4?=
 =?utf-8?B?VEpMT0F2Skp2MzFtcEgzNkxqNDhKZHdRUXE3S2JUS0N3ZE4rWmZLSmczaGJH?=
 =?utf-8?B?TGNIVFhMSEo3Mlk1TTlITEE5Tjh0dmlvL0NLZ1Fmak8rSTRKdnVqRVBEV0Uw?=
 =?utf-8?B?OGhDeUgyWEwyUjFXVlFIeGtkOW9GQ1I2Q0ZHMGM5K0ZFVFJ0WmhCQVBOaHlX?=
 =?utf-8?B?SVRmNFhwZFFkUWZUOE9PeEM4c1Vvbzl4OC90OFAwZnkxYkp6NjNyZjhnVk5Z?=
 =?utf-8?B?Q05heUdzQkVtNmFLcnNIengxWlFwUzc1VTB3ZE5wcFVRWGIwdUhhNEV2S3lW?=
 =?utf-8?B?a2cvYXIzcmJyMU5jODFYR1VUN3FJTEZ1M1c0YWYyWlF2eFVmM0dpdEIxRWFs?=
 =?utf-8?B?MlVEWGdYdkxMS1p6MUZrZU9RU1VySjQ3TEc2bzhhNkZyV0RDRE5kU25xTWFB?=
 =?utf-8?B?RWVkK2hlbFJVdGVwUUxHSGUvWExaM29DeHJGQTEvRnhDTEM5d2JwR0xpWEtP?=
 =?utf-8?B?MUorUEZBMHg0Z1gvQnZJZVBvWkZxWDA4TXFxYjRxaGhKZUQvdWV5eGozci9N?=
 =?utf-8?Q?GzsQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e1faaf-190d-4c5f-c027-08de2255d666
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 01:41:59.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48hWyY1zGCZAtWlGmLpNM8g1U0Tqih43FoI+9pXRRXCDw/CAvtOSTsO8zmEAx3F6xnMNTO+dyNDJKxdEulSkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11106

SGkgQW5kcmV3LA0KDQpEbyB5b3Ugc3RpbGwgaGF2ZSBhbnkgcXVlc3Rpb25zIGFib3V0IHRoaXMg
c2VyaWVzPw0KDQo+ID4gPiBUaGVyZSBpcyBhbiBJbnRlZ3JhdGVkIEVuZHBvaW50IFJlZ2lzdGVy
IEJsb2NrIChJRVJCKSBtb2R1bGUgaW5zaWRlIHRoZQ0KPiA+ID4gTkVUQywgaXQgaXMgdXNlZCB0
byBzZXQgc29tZSBwcmUtaW5pdGlhbGl6YXRpb24gZm9yIEVORVRDLCBzd2l0Y2ggYW5kIG90aGVy
DQo+ID4gPiBmdW5jdGlvbnMuIEFuZCB0aGlzIG1vZHVsZSBpcyBjb250cm9sbGVkIGJ5IHRoZSBo
b3N0IE9TLiBJbiBJRVJCLCBlYWNoDQo+ID4gPiBFTkVUQyBoYXMgYSBjb3JyZXNwb25kaW5nIExh
QkNSIHJlZ2lzdGVyLCB3aGVyZQ0KPiA+ID4gTGFCQ1JbTURJT19QSFlBRF9QUlRBRF0gcmVwcmVz
ZW50cyB0aGUgYWRkcmVzcyBvZiB0aGUgZXh0ZXJuYWwgUEhZDQo+ID4gPiBvZiB0aGF0IEVORVRD
LiBJZiB0aGUgUEhZIGFkZHJlc3MgYWNjZXNzZWQgYnkgdGhlIEVORVRDIHVzaW5nIHBvcnQgTURJ
Tw0KPiA+ID4gZG9lcyBub3QgbWF0Y2ggTGFCQ1JbTURJT19QSFlBRF9QUlRBRF0sIHRoZSBNRElP
IGFjY2VzcyBpcyBpbnZhbGlkLg0KPiA+ID4gVGhlcmVmb3JlLCB0aGUgR3Vlc3QgT1MgY2Fubm90
IGFjY2VzcyB0aGUgUEhZIG9mIG90aGVyIEVORVRDcyB1c2luZw0KPiA+ID4gcG9ydCBNRElPLg0K
PiA+ID4NCj4gPiA+IFdoYXQgcGF0Y2ggMSBhbmQgcGF0Y2ggMiBkbyBpcyBjb25maWd1cmUgTGFC
Q1JbTURJT19QSFlBRF9QUlRBRF0gZm9yDQo+ID4gPiBlYWNoIEVORVRDLg0KPiA+DQo+ID4gQW5k
IHRoaXMgaXMgZG9uZSBieSB0aGUgaG9zdCBPUy4gVGhlIGd1ZXN0IE9TIGhhcyBubyBhY2Nlc3Mg
dG8gdGhpcw0KPiA+IHJlZ2lzdGVyPw0KPiA+DQo+IA0KPiBZZXMsIHRoZSBJRVJCIGJsb2NrIGlz
IG9ubHkgYXNzaWduZWQgdG8gdGhlIGhvc3QgT1MsIGd1ZXN0IE9TIGNhbm5vdA0KPiBhY2Nlc3Mg
aXQuIEFuZCBJRVJCIHJlZ2lzdGVycyBjYW5ub3QgYmUgc2V0IGF0IHJ1biB0aW1lLCBiZWNhdXNl
IHRoZQ0KPiBibG9jayB3aWxsIGJlIGxvY2tlZCBhZnRlciB0aGUgcHJlLWluaXRpYWxpemF0aW9u
LCB1bmxvY2sgaXQgd2lsbCBjYXVzZQ0KPiB0aGUgZW50aXJlIE5FVEMgYmVpbmcgcmVzZXQuDQo+
IA0KPiA+IFRoZSBob3N0IE9TIGlzIHVzaW5nIERULCBmb2xsb3dpbmcgdGhlIHBoYW5kbGUgZnJv
bSB0aGUgTUFDIHRvIHRoZSBQSFkNCj4gPiB0byBmaW5kIHRoZSBhZGRyZXNzIG9mIHRoZSBQSFku
IFNvIGlzIHRoZSBNQUMgYW5kIFBIWSBhbHNvIHByb2JlZCBpbg0KPiA+IHRoZSBob3N0IE9TLCBi
ZWNhdXNlIGl0IGlzIGxpc3RlZCBpbiBEVD8gV2hlbiB0aGUgZ3Vlc3QgT1MgaXMNCj4gPiBwcm92
aXNpb25lZCwgaXMgdGhlIGhvc3QgZHJpdmVyIG9mIHRoZSBNQUMgYW5kIFBIWSB1bmJvdW5kPyBB
IERUIGJsb2INCj4gPiBmb3IgdGhlIGd1ZXN0IGlzIGNvbnN0cnVjdGVkIGZyb20gdGhlIGhvc3Qg
RFQgYmxvYiwgdGFraW5nIG91dCBhbGwgdGhlDQo+ID4gcGFydHMgdGhlIGd1ZXN0IGlzIG5vdCBh
bGxvd2VkIHRvIGFjY2Vzcz8NCj4gPg0KPiANCj4gRm9yIEhhcnBvb24gKHJ1bm5pbmcgUlRPUyBv
biBjb3J0ZXgtYSB1c2luZyBqYWlsaG91c2UpLCB3ZSB1c2Ugc3BlY2lmaWMNCj4gZGV2aWNlIHRy
ZWVzIGZvciB0aGUgaG9zdCBPUyB3aGVyZSB3ZSBkaXNhYmxlIHRoZSBkZXZpY2VzIG93bmVkIGJ5
IHRoZQ0KPiBpbm1hdGVzLCBzbyBob3N0IE9TIGRvZXMgbm90IHByb2JlIHRoZSBFTkVUQyBhbmQg
dGhlIFBIWSBkcml2ZXIuIFRoZQ0KPiBpbm1hdGUgdXNlcyBhIHNlcGFyYXRlIERUUywgd2hpY2gg
Y29udGFpbnMgb25seSB0aGUgaGFyZHdhcmUgcmVzb3VyY2VzDQo+IGFsbG9jYXRlZCB0byBpdC4N
Cj4gDQo+ID4gPiA+IEkgYXNzdW1lIHRoZXJlIGlzIGEgaHlwZXJ2aXNvciBkb2luZyB0aGlzIGVu
Zm9yY2VtZW50PyBCdXQgaWYgdGhlcmUgaXMNCj4gPiA+ID4gYSBoeXBlcnZpc29yIGRvaW5nIHRo
aXMgZW5mb3JjZW1lbnQsIHdoeSBkb2VzIHRoZSBFTkVUQyBwb3J0IE1ESU8gbmVlZA0KPiA+ID4g
PiBwcm9ncmFtbWluZz8gVGhlIGh5cGVydmlzb3Igd2lsbCBibG9jayBpdCBmcm9tIGFjY2Vzc2lu
ZyBhbnl0aGluZyBpdA0KPiA+ID4gPiBzaG91bGQgbm90IGJlIGFibGUgdG8gYWNjZXNzLiBBIG5v
cm1hbCBNRElPIGJ1cyBzY2FuIHdpbGwgZmluZCBqdXN0DQo+ID4gPiA+IHRoZSBkZXZpY2VzIGl0
IGlzIGFsbG93ZWQgdG8gYWNjZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGFsc28gdGhpbmsgdGhl
IGFyY2hpdGVjdHVyZSBpcyB3cm9uZy4gV2h5IGlzIHRoZSBNQUMgZHJpdmVyIG1lc3NpbmcNCj4g
PiA+ID4gYXJvdW5kIHdpdGggdGhlIEVORVRDIFBvcnQgTURJTyBoYXJkd2FyZT8gSSBhc3N1bWUg
dGhlIEVORVRDIHBvcnQNCj4gPiBNRElPDQo+ID4gPg0KPiA+ID4gVGhlIE1BQyBkcml2ZXIgKGVu
ZXRjKSBvbmx5IHNpbXBseSBjaGFuZ2VzIHRoZSBiYXNlIGFkZHJlc3Mgb2YgaXRzIHBvcnQNCj4g
PiA+IE1ESU8gcmVnaXN0ZXJzLCBzZWUgcGF0Y2ggMzoNCj4gPiA+DQo+ID4gPiBtZGlvX3ByaXYt
Pm1kaW9fYmFzZSA9IEVORVRDNF9FTURJT19CQVNFOw0KPiA+DQo+ID4gQW5kIGkgYXNzdW1lIHRo
ZSBoeXBlcnZpc29yIGxpa2UgYmxvY2sgaXMgbGltaXRpbmcgdGhlIGd1ZXN0IHRvIG9ubHkNCj4g
PiBhY2Nlc3MgdGhpcyBNRElPIGJ1cz8NCj4gDQo+IFllcywgdGhlIGd1ZXN0IGNhbiBvbmx5IHVz
ZSB0aGlzIE1ESU8gYnVzIHRvIGFjY2VzcyB0aGUgZXh0ZXJuYWwgUEhZLg0KPiANCj4gPiBCdXQg
d2h5IGRvIHRoaXMgaGVyZT8gVGhlIERUIGJsb2IgcGFzc2VkIHRvIHRoZQ0KPiA+IGd1ZXN0IHNo
b3VsZCBoYXZlIHRoZSBjb3JyZWN0IGJhc2UgYWRkcmVzcywgc28gd2hlbiBpdCBwcm9iZXMgdGhl
IE1ESU8NCj4gPiBidXMgaXQgc2hvdWxkIGFscmVhZHkgaGF2ZSB0aGUgY29ycmVjdCBhZGRyZXNz
Pw0KPiANCj4gVGhlc2UgcG9ydCBNRElPIHJlZ2lzdGVycyBhcmUgRU5FVEMncyBvd24gcmVnaXN0
ZXJzIHVzZWQgZm9yIE1ESU8NCj4gYWNjZXNzLiBTZWUgZW5ldGNfbWRpb19yZCgpIGFuZCBlbmV0
Y19tZGlvX3dyKCkgaW4NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjX21kaW8uYyBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCj4gVGhleSBhcmUgdXNlZCB0byBzZXQg
dGhlIFBIWSBhZGRyZXNzIHRoYXQgdGhlIE1ESU8gYnVzIG5lZWRzIHRvDQo+IGFjY2VzcywgdGhl
IE1ESU8gZm9ybWF0IChDMjIgb3IgQzQ1KSwgYW5kIHRoZSBQSFkgcmVnaXN0ZXIgdmFsdWUNCj4g
4oCL4oCLdGhhdCBuZWVkcyB0byBiZSBzZXQuIFRoZXkganVzdCBsaWtlIHRoZSBGRUNfTUlJX0RB
VEEgcmVnaXN0ZXIgaW4gdGhlDQo+IEZFQyBkcml2ZXIuIFRoZXJlIGlzIG5vIG5lZWQgdG8gYWRk
IHN1Y2ggYSBiYXNlIGFkZHJlc3MgdG8gdGhlIERULg0KPiANCj4gQlRXLCB0aGUgcG9ydCBNRElP
IGJ1cyBoYXMgYWxyZWFkeSBiZWVuIHN1cHBvcnRlZCBpbiB0aGUgZW5ldGMNCj4gZHJpdmVyIHNp
bmNlIExTMTAyOEEsIHRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgdGhlIGJhc2UgYWRkcmVzcyBpcw0K
PiBjaGFuZ2VkIG9uIEVORVRDIHY0LCBzbyB3ZSBuZWVkIHRvIGNvcnJlY3QgdGhlIGJhc2UgYWRk
cmVzcyBmb3INCj4gRU5FVEMgdjQuDQoNCg==

