Return-Path: <netdev+bounces-216763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5FB35113
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B04200125
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF481EDA2B;
	Tue, 26 Aug 2025 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="lHymFq//"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4A42AA5;
	Tue, 26 Aug 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172488; cv=fail; b=Bun0YSdfp04sSPrydxue5dLaWE2wZj0KxwAMPyDrE1o2LUub09ixNhoJ+HYbkoBC31RHLqiXV7BO7vIkImIqx9JZGj3dMH1Sn/P1DHVKWtnDS9sa57RcV3NYkeZEetC88Zlfl2FmIT2LqOHZwOn25/j4CiCPz7JcVMU57dpdFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172488; c=relaxed/simple;
	bh=3SgfDgnlIkz085QTOn1y7Mz1Pdfs6NkX2ThLLOmVmpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSRHjJDWjdZNwPtYDwxXJ4oNjo17thJSkAm6zbn69l0PpuXf+U5Vw++umdR4mYWnyeS1c5qZSiksbOkYzoJ09YgI9I2Yl9Ofp34DF4RG8shh+UZYU6YAxvsuPPWeVMzTerUuQD3sxIyG5RkL+3KlLu4nd+0oxURKMsonKPoTh3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=lHymFq//; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haWY13BLcVKLegox66HEXsFA3QXNEhfQSyNl53rUjpRjBA3gaR69qEOvPbG5yoBJb/9zYp5sao4kmsidfA+NAXwL5aDXPfr0OIjrfVEWxTXzwXliF2PhsW3PVjmIsZunA0QrPNHLikpexHbX4s+D1eZzvX9AFB/65XoQVg+MMJvBgxTW9s9ic9JR8rUPynNUrDWzhEV2+7d4KoaJjtrEAOfvKyGALJgPvOMVHYr4M9x8aLdRhwSioXdtH68u5itGYvVhSJaGPn+iKix48bbiRnMaDHkWRnUV4cfAfpkqEdlZfj7arEEV57tlKmFEIfrWHpMamhDibO22EpM3N2I8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SgfDgnlIkz085QTOn1y7Mz1Pdfs6NkX2ThLLOmVmpk=;
 b=laEYPtS4rrRSp7hK7nSrHdsidvSo6/2lk74QyFwtoMwxgEAlRXXxmw+JCfUN4zbHHo3lktq07hgQKcDPKypZ+C+Ev6G0ksyJAo/8upgT97nYYJ4SvurBj3UEouzxCZ1hc20ktp4j91UN/t1ejM9b5rmcA+LKFt+DzdFYWKWxCIfv1gqL5mKsdGTIUo75R51iFX7/Bq+KDz17EwVa9ybPxkQdi6ammX910ONwzoaxCOuoN52tuODG2H82BHtcfk22DX8kdt1Slkfqiv9OiubcrHSLdxV2KYmrmKYWv+eoSeW6y28vI3CciQ6zKykgOEwtV0K9NOsxQoTpfdmP096bZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SgfDgnlIkz085QTOn1y7Mz1Pdfs6NkX2ThLLOmVmpk=;
 b=lHymFq//SEqrp28jQHJ7t2/OU3ew/ip1lv0Dq75+dvgzedQ3AauijHYCvCxuWu4tENFkQAncRJk13GHVa6j+tsglDyUNWthYYtMmCKo0pIcK/dGPDC/ib9J6swx7RGpkCzTtjvzi6n+N5wpn/dF9NFAnTUBpL2YZZxWfFW8i3eZujWWkWOxTHYunq122wyFw3CFDo89EaZ8cieCc/TUk/WDAOH3J6g0nGPGjcFaOHdRPgtiV8EL71IzBHf57XlEq0913Oo/0uEW6EwlSqLXiAXFFfl/toKCepSJaVPHKVhb5w1aP/vP8IjCL+M0ZJ22AG+8MchFPvbZHCI4S0BqasA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYSPR06MB7100.apcprd06.prod.outlook.com (2603:1096:405:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 01:41:19 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 01:41:18 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Simon Horman <horms@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Thread-Topic: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Thread-Index: AQHcFiqECJ8fEpLerkCh5cEn8BzdoA==
Date: Tue, 26 Aug 2025 01:41:18 +0000
Message-ID:
 <SEYPR06MB51342BAA627D12DA4DC32D6E9D39A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <a9ef3c51-fe35-4949-a041-81af59314522@lunn.ch>
 <SEYPR06MB513431EE31303E834E05704B9D33A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
In-Reply-To: <3966765c-876e-4433-9c82-8d89c6910490@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYSPR06MB7100:EE_
x-ms-office365-filtering-correlation-id: 16445f7d-abff-471a-aef9-08dde441a720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWdtOFNaQ0lHRUV3ZFpLVkNBaFpSM1VISlBvRkk2WEhqbjN3ell1MUpzZFhJ?=
 =?utf-8?B?UlRGalA5cGo0clpBOW0rS1JsL3JrSmIxTmtiSGZRd2xaOEo3SzBVUE9UV0RT?=
 =?utf-8?B?a0NWbmZKL2lQdTl4VWd2ai9GOHV0bWs3ZE10VUIwNTh2RGNVQ0h2REpXQWdE?=
 =?utf-8?B?Y2JDcWtsU09BdlN0SWphU2t4VkZiUlVoYXN0VFBlUDhnK2VGWFJ4LzUxZlhx?=
 =?utf-8?B?Z3NsKytXeGc4eVduQ0YrVkIrZXNURXNlbmVqRG1vd1JmWmNDeTJSNGk2bzhR?=
 =?utf-8?B?UFZ2amFoYVBZUDRFWElqZjBLbjF0V0FmbC9zZjVtZ3QzSDhGV1lXdXZkQ2xP?=
 =?utf-8?B?czE2bUloRW96a1dwM1Y1djJTU29IVHFkTzVjbGM1N1hqZlFOSWZnQlA2ZFBC?=
 =?utf-8?B?TThLSkd3U3RqQ3I0Z0RtNmRMcUYvWlI1VFViM2J1RC9VSThvcVp6K3V2Mkk5?=
 =?utf-8?B?TzhENTgwcE1rbWlQeWhXclVLTTFVTlpuc2drWWgwUFdjWGdVcTVpV3IyMUZR?=
 =?utf-8?B?bXBRKzRwK2dlOUZ0cW5Nd1NzZzloNmNHSmF3ODUrYTVNQzBvRWRIckpDQ3gx?=
 =?utf-8?B?a21qajRiNWE0ODFJZk5wVlQzdU4xcG9JNWM3UkhFMHlVQ2Jnc0dMbW9mSERN?=
 =?utf-8?B?TVRxbXI5WXZmZnU2T1N5dTNwSk5OWlNuNjU3QnowK1pLQ3FiM044Q1BxVWsr?=
 =?utf-8?B?aDgrM00wd3cxQXZQS3dwTTVBbDY2TjEwV2M5Z1ZFTDVnZTgwQkZvZ0gvWVZW?=
 =?utf-8?B?L0RJZjdwVGI0VEtrSkcwY0MrdUN1blhtMGNFanZHM3VBL1VmOFZpRnRLNEVJ?=
 =?utf-8?B?SzFmUUVLbW1GeWJPYVFDMnBCcXgwbFFqOEsxMS9yZTNBRVpWRkhRRXBQR2xT?=
 =?utf-8?B?emNmN2ZHT0VCWWlQRks0ZmNwRlR5Y2YwWFBXQ21JaStEVWRqcXBUOU01MXd4?=
 =?utf-8?B?WXZFbmJkWk5DcUZiV2lCc1QwWTRMdFpmY0dmajJVa3B4bncvQ0tERW1MdXpw?=
 =?utf-8?B?UXBOVlFBNGlHYlo0bHNFWDRYVzM3N0VJQitZWStCTjRuZlN3SVIyQ2EwcjNR?=
 =?utf-8?B?bTl1ZXA4c254MHFBcmRXWEJ2M2lUb25ybnBVK1p2NVphby9QeHNVQTlvV3kr?=
 =?utf-8?B?cXVVeThUSENkNFBnSWxCSEtoSldjVTJRakptWG1odjJwU2VTazRQcXVkZVMw?=
 =?utf-8?B?eWVIWW5aRlRUcWNySStNTVZrSTBEdWpQdllKQ1ZnR29tUlRhSGRmUnE2cVdK?=
 =?utf-8?B?bDFmRTBicnUzMGhlaEF3RGFQeXhUREhYZ1VCdzZyR2pCZms3U0c2dUtTZm1F?=
 =?utf-8?B?TXJRbEhaWU9sUkJJN0pCUUg3YUUyYnIzaFVEZEtGdHlybGkwRk4wNFBjaTEx?=
 =?utf-8?B?aW1VR2tuckRDVFlBSUp1NXgrWUlOOFFSTkxwRVBibHpZVjNkNDVXOFN6ZG04?=
 =?utf-8?B?SWU3WkZMclJZbllycnZsK3BJU05hbEM2cllFR3J3WTRTQkJzN3hsOWJiSWhH?=
 =?utf-8?B?cGVzdGw0WkRBY0xHRmQyUFYyT2NpYlQwRzhzakhhTXlRdEl5VGhsNXo2TnFP?=
 =?utf-8?B?eVh4VzVwRlNJYVVLbGZ2M2NJMFhIbE1neHQ4dC9YaGdVRzVKR0lHeHdQZ25k?=
 =?utf-8?B?VTlta2hWQjZaUFlJVkRyYXM1aVl6NVNYRGZKdjVzMXZNQWZ6TTEwUzNaSTNW?=
 =?utf-8?B?ZTdRdUZ1TjdTeWl4dTg4SDRzVWY4MVlhNkYwNjFtRThXbUpsbDMxamVFMWpM?=
 =?utf-8?B?RVFZMXhKaDhFckM4K1RnM1pYNGRXTW1SbkYzc0tVNW5UZXNQMHZrNk9WQWYv?=
 =?utf-8?B?YVZHUlRVV3BzUnBOZ1FVR3FGMlhuVk9wUy94ZE1ZV1k1SVVLOTNJQ3lWVStX?=
 =?utf-8?B?c2RVRHJPcVZRVWsvb1ZqM2d6aDRUandNNlZ2RjJWbHQrd3VTTkR6YkdmRGdC?=
 =?utf-8?B?UDluckYxbUdRSVUxc0xnNUF1Y2VhcHVkUnk1akNPbXVzZ3prcGFTelVldzZi?=
 =?utf-8?B?djZ3OUx2Tkx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmdrWkxTZXRBNVRCYmtwaDB2eUtYNjZhODJUdGZ2dkJWbUlkNWwvTE1jTlll?=
 =?utf-8?B?ejlZMWYzL3hwcWt0ZTkwTWorSDlLSXlyblNTSnM4NWdtNnprOE13VkdxYno3?=
 =?utf-8?B?bVpIcjBTaVRmS2h6VHc4OVZaR0FhdFhZU3M4dXlrN0dpZ0J2aytGcy9yTk1p?=
 =?utf-8?B?Y3dzK2Y2Rk9ZUkNUb2FKVXNOZ251bzNMb3UzV1ArTlAvREhWS2pyNWhETWxs?=
 =?utf-8?B?NGVQNzBlUk44bEpQRjh6b2JZdU9peXp2cUlydHhiMDhJd0lURzdRWmlBTmk3?=
 =?utf-8?B?SXlXaTNwWlluTUhwZ2FXZmxNSzMwL0o2TVdzS0pSQWxHWHQwOForeUtrTWlT?=
 =?utf-8?B?T1lLdkZvdGVZQTB3YnlZTjdTcDJDQWt2L3JjYzJGSERoOEN2cGhKbzcrWFR4?=
 =?utf-8?B?Vk5mS2UrejA0YUVxTkxmWjRsTU9xd0V0U0NZTXR0dEpUZlhxUzFIYlVGeDAr?=
 =?utf-8?B?bUFqcWw1RnR0bDFtWThBOGxWZjh5aVphYlA3cEtvblNmSDU1VnBBaUkwTkJF?=
 =?utf-8?B?RmNFUVdxelF3VnRRVk12dWE3K1dudWVVSUlCLzExazl0cEk4aFNFNnhmWEVX?=
 =?utf-8?B?M0xyRWF0WU8zem42Q2NSSXRmdUwrQ1kyVEhKMUJwSlFURWJKa2RqQUczenkz?=
 =?utf-8?B?eXpzaVZlUERVeHRnVnc2bHp2M25UY0p5bEI3ZU9PSzh2SU9qcy9hc051NGw3?=
 =?utf-8?B?S2J0MzdlUldEa3FCeHJuZGo1NUtqNVpRQmluNnAxYUtSOEtUZ3pYSUFiMnBn?=
 =?utf-8?B?Yk1WSHNURGI5Q0c0YjlFU2QvZDA2ZFNjR0RPdDhKeW42VXFuUjRZVG9mTTln?=
 =?utf-8?B?Nmh6VzBYbzFPVE5iWFBzZUZ2OUhJSXdnM3FLTzYzWjA4RHFKdDJvVGdnZ0Jy?=
 =?utf-8?B?RDNsMzk5UkxNUEl3SEhydW0wa3NlMzBhZk9RRkNWZmtaeTdsdXlMTFFWVW1D?=
 =?utf-8?B?cGN2bnBoS0E3dVM4V2M5YU8ydjdvM0ZIc005cXVnejc2aTRkb0hXRFBvMm1a?=
 =?utf-8?B?WnQ5SnM4d1lZWmlneUEwS1lkbU00bXZkVGdZZFNVVWEwOVBvNkZSajREMHpM?=
 =?utf-8?B?U0pvNDlrYVZjdTVpSE1WZmFSNk4xMy9rbTRqcHhMa2VvZDFJT1ZHczdmR3Nj?=
 =?utf-8?B?Z1ljTkxlQjE0YklvK0ZDcC9SbkdUZHpDaEQ3VTFvOUdnUTgybk81eTF6NW91?=
 =?utf-8?B?VnRObk1KVGQ3SWgyQTdDbkN3V1p5TWx6TEZlNDhRYmFSUzFzcmJ4SXJWS1BR?=
 =?utf-8?B?S1ptMlVrZEdaNzVnY3h4aDIvS3AwWFMvMG5DQXpiWnVDMkN4RlFLMVNEeFU0?=
 =?utf-8?B?VEtBNmJETmRhMTBNYXBSRk1WQnhPZW51cWgya2ozTmp2eGxILzZSc29ublFi?=
 =?utf-8?B?REx4MFZHWmtzc21yVkh2T05HSHB2RzNrNnAzdXlZcGkvc0N2YmZkWEJRUkxq?=
 =?utf-8?B?RkFVeWNqcEN1ZGVyQktjd3pHWTVsVUlzY05kYnpnSXdoaUNwb2N5aTdXdTJj?=
 =?utf-8?B?VDNBc3B5SWdBY1g0SS83aEJFZjRKczhQUXN0eFpidmp2YWZFYkNoS2x6UER0?=
 =?utf-8?B?d0RydjBDTHFTbktkSU4vK0FlVEp2QXljcnhueXhtSkhTTWoydnBzTEUrd3dG?=
 =?utf-8?B?WEFJcmhiWllGQTBWYWxZNzFwc3pzR3ZXUmhRaWtlbCtiRVlOV2ZmN2hhNXlT?=
 =?utf-8?B?SG1tRUd1SU1EMjhPRlN5aHBWYklTM25VeDFwNWRJVnllb3pBbktMTmk4cmlP?=
 =?utf-8?B?OUdDOXZicFpYa0l2a2R1Y2UwYklIRXRhaFZvNmlidWtOOVF3bnhxY3kwWFYw?=
 =?utf-8?B?MUQvUWJCWVczWC9GZEFhelVrQ1hJVitEMlVZb1BsWEp0a2tyV1VqeWZBbWNy?=
 =?utf-8?B?dWNNWDU3bXFtbDFkNmpUeXorSHF4QUFnWGVyRVRqWFdNbDNnN0MxbFNUL3JI?=
 =?utf-8?B?aUZFRFJkTWYvdkJrclJ0eFhKd3UzbnhmaHozMlpoUCtaRi9oRXdSYjZXVytQ?=
 =?utf-8?B?NjN3Q2RNUHNzekRCWlFha2UyWjFaU3NjYURpcFhtRVJDNnVkYjVhN3FlYzY0?=
 =?utf-8?B?dUtWcnhLZ0psS3YxVUNLV0FHdkZka21xeVcxTFI0QnIvMlBzUVRyK0lDaUxo?=
 =?utf-8?Q?GR7LzU3+FyvIf6xb2rTCF+gF6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16445f7d-abff-471a-aef9-08dde441a720
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 01:41:18.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vpj0i+AEXuY5bfG7HDQX/rvThFriGVl1NQNJ9Jrvxvs/q9mHZVUu1+aFG0ZvDj5HWoFr1se5JE2AkkZmRK/vlBvXJhrKB8bO3toWcB4HEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7100

SGkgQW5kcmV3LA0KDQo+ID4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3Ig
Y29uZmlndXJpbmcgUkdNSUkgaW50ZXJuYWwNCj4gPiA+ID4gZGVsYXlzIGZvciB0aGUgQXNwZWVk
IEFTVDI2MDAgRlRHTUFDMTAwIEV0aGVybmV0IE1BQ3MuDQo+ID4gPg0KPiA+ID4gU28gaSB0aGlu
ayB5b3UgYXJlIGRvaW5nIHRoaW5ncyBpbiB0aGUgd3Jvbmcgb3JkZXIuIFlvdSBmaXJzdCBuZWVk
DQo+ID4gPiB0byBzb3J0IG91dCB0aGUgbWVzcyBvZiBtb3N0LCBpZiBub3QgYWxsLCBBU1QyNjAw
IGhhdmUgdGhlIHdyb25nDQo+ID4gPiBwaHktbW9kZSwgYmVjYXVzZSB0aGUgUkdNSUkgZGVsYXkg
Y29uZmlndXJhdGlvbiBpcyBoaWRkZW4sIGFuZCBzZXQNCj4gd3JvbmdseS4NCj4gPiA+DQo+ID4g
PiBQbGVhc2UgZml4IHRoYXQgZmlyc3QuDQo+ID4gPg0KPiA+DQo+ID4gVGhlIFJHTUlJIGRlbGF5
IGlzIGNvbmZpZ3VyZWQgaW4gVS1ib290IHN0YWdlLCBhbmQgaXQgaXMgbm90IGNoYW5nZWQNCj4g
PiB3aGVuIGJvb3RpbmcgdG8gTGludXguIEkgd2FudCB0byBrbm93IHdoZXRoZXIgdGhlIGZpcnN0
IHRoaW5nIHRvDQo+ID4gY29ycmVjdCBoZXJlIGlzIHdoZXRoZXIgdGhlIHBoeS1tb2RlIGluIGFz
cGVlZC1hc3QyNjAwLWV2Yi5kdHMgaXMNCj4gPiByZ21paS1pZC4gT3VyIEFTVDI2MDAgRVZCLCB0
aGVyZSBpcyBubyBkZWxheSBvbiBib2FyZCwgc28sIEkgbmVlZCB0byBjaGFuZ2UNCj4gdGhlIHBo
eS1tb2RlIHRvICJyZ21paS1pZCIgdG8gbWVldCB0aGUgUkdNSUkgdXNhZ2UgZmlyc3Q/DQo+IA0K
PiBJZiB0aGVyZSBpcyBubyBkZWxheSBvbiB0aGUgUENCLCB0aGVuIHBoeS1tb2RlIGlzICJyZ21p
aS1pZCIuDQoNCkkgd291bGQgbGlrZSB0byBkaXNjdXNzIHdpdGggeW91IGhvdyB3ZSBmaXggdGhl
IFJHTUlJIG9mIEFTVDI2MDAgaW4gdGhpcyB0aHJlYWQuDQpBbmQgdGhhbmsgeW91IGZvciB5b3Vy
IHBhdGllbmNlIGluIHJldmlld2luZyBvdXIgY29kZS4NCg0KQ3VycmVudGx5LCB0aGUgUkdNSUkg
ZGVsYXkgaW4gQVNUMjYwMCBpcyBjb25maWd1cmVkIGluIFUtYm9vdCBzdGFnZSwgbm90IGluIExp
bnV4Lg0KVGhlIGZ0Z21hYyBkcml2ZXIgd2lsbCBub3QgdXNlIHRoZSBwaHktbW9kZSB0byBjb25m
aWd1cmUgdGhlIFJHTUlJIGRlbGF5IG9uIE1BQyBzaWRlLg0KDQpJIGxpc3QgdGhlIHBhcnRzIHRo
YXQgSSB0aGluayBuZWVkIHRvIGJlIG1vZGlmaWVkLg0KMS4gQ2hhbmdlIHRoZSBwaHktbW9kZSB0
byAicmdtaWktaWQiIGluIGFzcGVlZC1hc3QyNjAwLWV2Yi5kdHMuDQoyLiBBZGQgdGhlIHR4L3J4
LWludGVybmFsLWRlbGF5LXBzIGluIGR0cy4NCjMuIEFkZCBSR01JSSBkZWxheSBjb25maWd1cmF0
aW9uIGluIGZ0Z21hYyBkcml2ZXIuIElmIHRoZSB0eC9yeC1pbnRlcm5hbC1kZWxheS1wcyBoYXMg
bm90IGV4aXN0ZWQsDQogIGFjY29yZGluZyB0byB0aGUgcGh5LW1vZGUgdG8gY29uZmlndXJlIGRl
ZmF1bHQgdmFsdWUuDQoNClRoZXNlIGFyZSB0aGUgZml4IGl0ZW1zIEkgY2FuIHRoaW5rIG9mLg0K
Q291bGQgeW91IHBvaW50IG91dCB3aGF0IEkgbWlzcyBvciBhIGNsZWFyIGRpcmVjdGlvbiB0byBj
b3JyZWN0IHRoZSBSR01JSSBtb2RlIG9uIEFTVDI2MDA/DQoNClRoYW5rcywNCkphY2t5DQoNCg==

