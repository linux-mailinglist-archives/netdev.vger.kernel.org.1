Return-Path: <netdev+bounces-122653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294C962169
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB6D28180C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919816A923;
	Wed, 28 Aug 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwSVXsGn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6C16088F;
	Wed, 28 Aug 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830628; cv=fail; b=kPzw6dbRCudIlC45cDkYSijD/2jvDbTSQNxWwfzKVB5vT4vFLkx1jMNOpULlNgi3QvRMoUXwpROZvDovwTYda7+PyFk/YbxgQ9tcR/Gj86OFmOUAn+PDymP7FXN5JKLCyPORPLRnEvsaCdcSUsLYdIwfsUIb5gdkNjy3RoFWp2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830628; c=relaxed/simple;
	bh=l8M+v/z/NwvZbNAFiQikJg8YuNdfQ7LRtfivVLRQKjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W0PSoqq0LBopZprp3/0mjbO63xWbjgsG3MCG/OQQ8ErQe46q5Mwjn2a7Wb+lr2KK2VV3mzVySwXsYQ4uKnxFD1TP+AIGlOu1dSWLI627vjCIBeQCBvzjD+hURtuTqV/9ul1plAdgiy84biiJr5lgSs8IkSduHyw9XCBbWzYfmvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwSVXsGn; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz/nWTqXnyV2ErJJl3r3nAS0hN2GET3n5SgVSk1W41hNGAYmAqK7Lm0ANAJ3+rB67wI5T6p3LkoKwzwJhX15dy2rv6LDXGYNww9iVXo5yaI9aaT0CfTTC8/03OVXofsUjXIUy7xRHsq3vb8WSwe+SywWRnNNB0eLUPZRK0SOPiqBdaiRpxH5eSx9ATomY2uD8tv6zFbNOtqjcR79CkJsNf/oAsiaxpGDcE6peqjJs/UDyEZ4yBEaRUWNeR3gIjEkcQotKIS9IiG3Jwvy2u2AOTW0SJ+3jsUoMS4UGpz/Lz4+7Lgt5q2ldEytOtgquxWSGhxXfHpwbF/D3ivFQtiKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8M+v/z/NwvZbNAFiQikJg8YuNdfQ7LRtfivVLRQKjE=;
 b=ux4PV8Xc5rLPjSjeSuNSu7fAvadV+7WOfuWT2DJgOCo76W+f7VCHtoh4N0VUOwfaAZ+l7BjnyGXQToWuqh1O7ZE5YdZI/l76p4veW5gFuaHDhGF6VcgiF7qKwd+0MTJJMvbw7perQqCs5Cjq5IGhZ7w7lN/IPv+jTvs5dLcWJglYwoBAcV3vafJxjzJ67uRMDrQtdV8e9rUQcHkXYSJbTADEuc2oqUJUHGP7wsUN1DjHMXUg7bcq9epVRezGaPfTLpFtsX1krnZ9Xkn6h+acAtZxkhD4SismA2PLD6LNFXk6nZL/Thzm16DsnOxJpssXxoKn1ayEk8Sm3nTyUeQBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8M+v/z/NwvZbNAFiQikJg8YuNdfQ7LRtfivVLRQKjE=;
 b=UwSVXsGn1a4htVg48MAGg8L4QFfXIsoJA49HhLrsZuh7jNhSF6v6jAsXEcwoyyixozpN0qV12OpCkDOBHq+2WSlTU0fDzL2fQo673+KZxYHd/A1K3NWQAe8JnVfdv2AlyU+P75jp6Jt0caPYszaW12PJmmyTv6CWL9TLlUaksewVE6GUF7iLGTE9VB7y1zTtzROPiF2uA1VIMMjH6JzvAksPXiipaOGO59tKXrrj+UsKEfFfhjQU3Z2HKLWa9N8hiW5oSmnTji74eE4cHVDetKruZnpUhRLNf89f7fvhxsh0Klke0BaH706a3kpYICTJQHpCiMo4nrqOfofWek3QTg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10072.eurprd04.prod.outlook.com (2603:10a6:150:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 07:37:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:37:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "Andrei Botila (OSS)"
	<andrei.botila@oss.nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Thread-Topic: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Thread-Index: AQHa93qWJiFBjD+OmUSVXRJrTkYTd7I5sD8AgAC15ICAALRbAIABMG7A
Date: Wed, 28 Aug 2024 07:37:00 +0000
Message-ID:
 <PAXPR04MB8510596C172BCA296D5D775388952@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240826052700.232453-1-wei.fang@nxp.com>
 <20240826052700.232453-2-wei.fang@nxp.com>
 <20240826154958.GA316598-robh@kernel.org>
 <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <31058f49-bac5-49a9-a422-c43b121bf049@kernel.org>
In-Reply-To: <31058f49-bac5-49a9-a422-c43b121bf049@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10072:EE_
x-ms-office365-filtering-correlation-id: ff78bb01-3c10-4e0c-ac8c-08dcc7343414
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzBWZjNmb3RBVmxNUktZZjkwVEdTd1I5SnVuSm12VmtSVzVmZURHVGtXTU1t?=
 =?utf-8?B?cFc5ZXp5R05RUk9jMS9mSDdsaEhiRnJ2T1M0alE2b1J6bHRhM29wdXN6UHFW?=
 =?utf-8?B?RndRYWVEektrbG84OG03SG5Ic3lQWXE5ckNYRXV6OGljK25HdEdDUUpobi9m?=
 =?utf-8?B?ZXYvRzlIMUhqdUtLdHJzTDB0eTBTN0VvK1hIeWVkYUdZWklYMlZta0oxREE5?=
 =?utf-8?B?QTArTkxzdTJYZXVZNVJJc2pieHVoR3RESEVmRnp1SWkwUlVIcEpZV1Q4QmFU?=
 =?utf-8?B?WTBLN05BcEhvclYzYlRQa1VzNWNnWGNnbXhNV1pBcklwai85cWF5VWVaUVI2?=
 =?utf-8?B?VXBORmZHQlpJenNrTXJtUVpZNWtNaHRiUWVWd3RnN0k4WVBTaTZ6RGt6cnhD?=
 =?utf-8?B?ZnhkSXMvTE5jNHBRS0Q1M1VraDlUa2ROaFlVUnlxVTVnL25NUGc3cy94L1k0?=
 =?utf-8?B?TnpPQlQ0dmJFVkVlTlBqWmd1UDQ5cm16TEpSVEtDN2tMZUtWUWRXdCtzbW0w?=
 =?utf-8?B?MFlHZ3hsZTZySTVjazhkdDQ5ZVZWcTB6UlNUWGdneEtBaHdBVVo3TGtOc1ln?=
 =?utf-8?B?QVY0THNpTGxyV21vWm9hd2NhUFA5c1BnUUVYQ0J6NVAzRmxIeTJmbG9KWEpD?=
 =?utf-8?B?T3dMcStBbjlGWE91bWFUdEdIUkxRQ3R6bWtjNm8vNkdrYXVicUY0UTZnWEth?=
 =?utf-8?B?T2RxSXdVS3Q3d2RsY2Q4emNJY1Y3aHZsakZ0NlpmbXJPNVBjRVhWdEZmdXUw?=
 =?utf-8?B?ditJWUZPQ1NaS0YxNlFsL3BqTXg5N254N0Z1SnNsVkNMNmFTblMwRW0vRVhp?=
 =?utf-8?B?SGNRa2pmQ3g0VlJORmZPWTZ5eVZtakhBb1AyZ1UwZ0RFTU1mSFh4cWZxVlBo?=
 =?utf-8?B?RVVqWkxHc2swWXVqY1pGbFozTkN5dnVzc3poaEFFYkhNazBrVDlsWDFYejFH?=
 =?utf-8?B?QVBRN0ppU0FWZzIzdFZ6VHJ3Uisvc1J4L2ZNSHlSTk50Q25QSWEzRE9kbGdI?=
 =?utf-8?B?NkgwSmZGLzcreXZKN25RUWhnaHNpRDNGZFMwalJBRmkvd09nMXJLemVQTjF0?=
 =?utf-8?B?ODNiRDlFcFdkUE4rQ1VCelZpTVpIbXBCZDhyWW85K3RPWGxyR2cxMlNVVkRV?=
 =?utf-8?B?Z2kzaFNHUEU3RSt0MWdnTW1PTUJvTmVMUDI2aTlwUElvVkZLUFB5MEJqckJO?=
 =?utf-8?B?NWVtN3k5czZscDNFNGhUcUpWME5EampNNlZ4MEZLQ2VnTUFsSTB4T2xzbUN6?=
 =?utf-8?B?dTFnODZXdWlUN2RVeTArQmxJcTQxM3ZnWDY3dVhEMjhOU0N2a3ZnZmNYYmpt?=
 =?utf-8?B?bkZEaUNHRnYxU3Z5alJjMnNUVFRsenM0elpzSVlTeGpKakJwckZURUlKeWNY?=
 =?utf-8?B?N0FjMm9XNk4yckVlUlV6ZlFlSklwT0EyajBvMVByNHFodUpJemlaT3VDSFFO?=
 =?utf-8?B?NEptb0hobmYvQTRsNnJXaFBabXhTUXRvemlodDNCaTh4R2dVZUhTM2ZaV0Jm?=
 =?utf-8?B?MS8rTzVWQzkvZFF6OTFCS0huU0RZdXN5VXNnbzBSWUZlRWRoNE1EVnNsYi9I?=
 =?utf-8?B?clVaNHIzb1JsVG9UbCttMm1zcHNPSVRuSndBaFFIYm0vcmhjSFc4VTl2QjdN?=
 =?utf-8?B?b3pUaTVaSFg2UTQvMnBhSVA3VWM1ZGpsaDZkRjB5SFp5a1poelAzUFNuU1dS?=
 =?utf-8?B?MlNGbjU5TUptSVMva0F3Sm82OFo5S0VKNzJrV1pzYzZYamhoVlEzNjFGaEsv?=
 =?utf-8?B?d0EwK3N1OEdHbm1OV2VDRTFwNktLdDRKRTg1bm9KRG1rN0pMeFY5Z0s4NTd5?=
 =?utf-8?B?V0pINENIR1VQTVFhWUQ5NktaM0xNZHVMdmUrZkxUUUl0OWZkZDVTTzZPRXA2?=
 =?utf-8?B?Zmc2TytxNXZVRXBEUGZ0YVY5b0xiRkFWUDVjUUd0TDlvRWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkNaYVBwSXpvN1ZUbDVnd3E4azZSZlIxdzNyTkNZalZZYmV0WGdEOXpZQXN6?=
 =?utf-8?B?VWtCM3hncm4rWS8vSE95eWdJSkxLZUxOODVYWUYrSHZnRzVVUkxWdmdpbFRZ?=
 =?utf-8?B?djZiOHVGVmNuYTR4cHdvdzQ0dlVsdlo0WElXa3hQUUUzREFVWUJydWFFSVlv?=
 =?utf-8?B?WWRGTHlUNVdlUnpTNk8rb0ZIalZxOSsvMDJ0OUYrWmNSdVRSanE3RUVBdUp0?=
 =?utf-8?B?amZzcnVwZ0p3dVE3ZEdyNUVsbE1oSjc1azh1bEVCVTJSbCtHbGdSMG4xTENZ?=
 =?utf-8?B?RDlESWEwNE82cDJFSkRZWDN0T3dvTDJsVGxiWnVJR0Y3eWtRU1k1UVcveVRU?=
 =?utf-8?B?K0M0dHZSdUgyMndoSnFGOTVPV3NENE55VWp5WmtTeW80cmRjSjVJSi9JeEJn?=
 =?utf-8?B?eWNMRjhwRGlGQUROU2ZpODF2dWhLcjlod1hrOVBxNno3MUtlVkQwMS9WcnZD?=
 =?utf-8?B?U3k2cFlTTXFlYmd4N2VQUjV3TTQwWWxDY0hWTExndlNzY2NqNWFFRzRab005?=
 =?utf-8?B?aGZ0Rk95ZEN3S3EvWUZDQ2hNR2xjK3FLZVJ1OWJoZDZyaTV2YVRqenZBVm5z?=
 =?utf-8?B?M0VIZFl5M3NsZm14dGR4amFYVTluZU5LUERLMTdPdDFkaW1NMjY5Yk4rV3BB?=
 =?utf-8?B?NTVFTnk4SEpjeGN5MUJaeWNoWmhNcVFsQXpqVlBxa3NyKzZjZFhHdFdBc0Ft?=
 =?utf-8?B?NHU4bHZpd2FmeVZwQUNZbmk4MzJhNXJzTW0vV0RDUjJGQXVrVlBVZStIQWxQ?=
 =?utf-8?B?MGVoSHNJV3FtWFhkN2ptSXFsMTExWlZTaDlwUkFJM2VBZC9VNnFuQ0h5ZzhJ?=
 =?utf-8?B?eHRhcGVoWGJzeWFvdk5FanB0Q2ZQMHlNU3FyRHY3Tk1kTFkzZWRQVkVsc2NE?=
 =?utf-8?B?NVVaUnM0MDRsRkF0NTd2ZEhSMllsdGxIRWZQUGJGWmtTa0hmMDlOMVVYc3Rz?=
 =?utf-8?B?R1ZYVitTSlhrOG8rclBMQkU3WGg5NlY1ZXUwZ3pvUWFmYjlqcXJ6cGJONko0?=
 =?utf-8?B?STZTVkNWMW9adjljNUt6SW9YUHc5OGZsMHRIRUVVaVhGTzgwZ3U0VE5VWHI0?=
 =?utf-8?B?QmpSOEU5ZU5obWE3RjZlUy9iSXAvT2w4b1dVTEgrZ1dhUkpvaXNVdmtOSHlP?=
 =?utf-8?B?cG5kaGVLOENBakdTZ0prYkw5KzhyMjlLeUZoaVlHbTdtN2NIL0dzRWJ5SENy?=
 =?utf-8?B?S2F2V3h2YitJZXljdlZKK2wwTVZGWmlMS1B1RURZSkdHZnBmUUpFWWJISmZh?=
 =?utf-8?B?dnlDWC9mT0FHQVRqZkJuQi9xdnZMbnNPQmJpT2MzOFZ3WFU5VlRzSGp0c0pl?=
 =?utf-8?B?L05FdktKWW9qT0xoc3htNXFXYVV6TWFTUjRweHduOFBvK1JXajVnZjBnQ0x4?=
 =?utf-8?B?Rm5QcUtZeDVycnFiRW5LMEl3VW5MMnNyZHh1TTI0U3FTREQ1VTZVdU9BVTc2?=
 =?utf-8?B?bU1lNldyMHNYNjdZTk9QMkVONnRuV1h2SUFhMFIzeDRiVm00bVd3Y0plUDN1?=
 =?utf-8?B?eG1pMk9QSFhHM2pTY00xaktEL0M5YlRBalRIRlBDeDc0UmcwdllVZGJ3bFJa?=
 =?utf-8?B?VHovaWJXT3pIdmwxTWhaZTlCVjAvVndmZHVIUEQrZEJCZVJHRDAxL0JFS29C?=
 =?utf-8?B?cHRieFh4TGovZ2UvcjZ5OWdlK1hmVUtBVkRvYVFjYmlVamp2Q2k5VWJhMDhn?=
 =?utf-8?B?K09iNnJUNTVzVllKUnVoazFGUWthU01Eb1JTek14MTlQcHZCY1JjdWUxcDVK?=
 =?utf-8?B?dndzMmRFOWFFeStSYzE1cjJyU1BBS2VWdW1MSEtqbDVRR3hBUWtHaTF4WWJr?=
 =?utf-8?B?WGZ2UVJ3ZzMrQ1hyUmlMZ2lKbGUwL25xRE1kSEZEMmplSHlMY0U2TzA3Sk4r?=
 =?utf-8?B?alFaeGN2ejFKeUJtK1lHTzVGS2pOOW5paCtBQ2ZxT1NmcEN4SDBBTVFFNklJ?=
 =?utf-8?B?WVQxNERyZEdxc3E4d0ZYMFMrT3pROTFaZWIyUXJuRjdqRDBSNzFWYWJhUWx3?=
 =?utf-8?B?Y3R1UHdadnVqNzd0Qk0wUnVnQUprUmxTaWt5NENpUWx3K1BXUVJwWXFqT21z?=
 =?utf-8?B?MVVQem9rYU90TFdkQXBpOUVVLzNXdXJJY3ZrYU9NZVQ2SlF0SW1OaHFGSlZl?=
 =?utf-8?Q?FES0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78bb01-3c10-4e0c-ac8c-08dcc7343414
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:37:00.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPDd3238aIE9gzjaPgWfMhT3ovdmuT2MA2PE0k/xlJb8LgQtxfLowM/j9NynZJhKHCkNaYhSS+HUjKJQKmyPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10072

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ45pyIMjfml6UgMjE6MjcNCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFA
a2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGtyemsrZHRAa2VybmVsLm9yZzsgY29u
b3IrZHRAa2VybmVsLm9yZzsNCj4gYW5kcmV3QGx1bm4uY2g7IGYuZmFpbmVsbGlAZ21haWwuY29t
OyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBBbmRyZWkg
Qm90aWxhIChPU1MpIDxhbmRyZWkuYm90aWxhQG9zcy5ueHAuY29tPjsNCj4gbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyBuZXQtbmV4dCAxLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IHRqYTExeHg6IGFkZA0KPiAibnhw
LHBoeS1vdXRwdXQtcmVmY2xrIiBwcm9wZXJ0eQ0KPiANCj4gT24gMjcvMDgvMjAyNCAwNToyNSwg
V2VpIEZhbmcgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IDIwMjTlubQ45pyI
Mjbml6UgMjM6NTANCj4gPj4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+PiBD
YzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwu
b3JnOw0KPiA+PiBwYWJlbmlAcmVkaGF0LmNvbTsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitk
dEBrZXJuZWwub3JnOw0KPiA+PiBhbmRyZXdAbHVubi5jaDsgZi5mYWluZWxsaUBnbWFpbC5jb207
IGhrYWxsd2VpdDFAZ21haWwuY29tOw0KPiA+PiBsaW51eEBhcm1saW51eC5vcmcudWs7IEFuZHJl
aSBCb3RpbGEgKE9TUykNCj4gPj4gPGFuZHJlaS5ib3RpbGFAb3NzLm54cC5jb20+OyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIG5ldC1uZXh0IDEvMl0gZHQtYmluZGluZ3M6IG5ldDogdGph
MTF4eDogYWRkDQo+ID4+ICJueHAscGh5LW91dHB1dC1yZWZjbGsiIHByb3BlcnR5DQo+ID4+DQo+
ID4+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDAxOjI2OjU5UE0gKzA4MDAsIFdlaSBGYW5nIHdy
b3RlOg0KPiA+Pj4gUGVyIHRoZSBSTUlJIHNwZWNpZmljYXRpb24sIHRoZSBSRUZfQ0xLIGlzIHNv
dXJjZWQgZnJvbSBNQUMgdG8gUEhZDQo+ID4+PiBvciBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZS4g
QnV0IGZvciBUSkExMXh4IFBIWXMsIHRoZXkgc3VwcG9ydCB0bw0KPiA+Pj4gb3V0cHV0IGEgNTBN
SHogUk1JSSByZWZlcmVuY2UgY2xvY2sgb24gUkVGX0NMSyBwaW4uIFByZXZpb3VzbHkgdGhlDQo+
ID4+PiAibnhwLHJtaWktcmVmY2xrLWluIiB3YXMgYWRkZWQgdG8gaW5kaWNhdGUgdGhhdCBpbiBS
TUlJIG1vZGUsIGlmDQo+ID4+PiB0aGlzIHByb3BlcnR5IHByZXNlbnQsIFJFRl9DTEsgaXMgaW5w
dXQgdG8gdGhlIFBIWSwgb3RoZXJ3aXNlIGl0IGlzIG91dHB1dC4NCj4gPj4+IFRoaXMgc2VlbXMg
aW5hcHByb3ByaWF0ZSBub3cuIEJlY2F1c2UgYWNjb3JkaW5nIHRvIHRoZSBSTUlJDQo+ID4+PiBz
cGVjaWZpY2F0aW9uLCB0aGUgUkVGX0NMSyBpcyBvcmlnaW5hbGx5IGlucHV0LCBzbyB0aGVyZSBp
cyBubyBuZWVkDQo+ID4+PiB0byBhZGQgYW4gYWRkaXRpb25hbCAibnhwLHJtaWktcmVmY2xrLWlu
IiBwcm9wZXJ0eSB0byBkZWNsYXJlIHRoYXQNCj4gPj4+IFJFRl9DTEsgaXMgaW5wdXQuDQo+ID4+
PiBVbmZvcnR1bmF0ZWx5LCBiZWNhdXNlIHRoZSAibnhwLHJtaWktcmVmY2xrLWluIiBwcm9wZXJ0
eSBoYXMgYmVlbg0KPiA+Pj4gYWRkZWQgZm9yIGEgd2hpbGUsIGFuZCB3ZSBjYW5ub3QgY29uZmly
bSB3aGljaCBEVFMgdXNlIHRoZSBUSkExMTAwDQo+ID4+PiBhbmQNCj4gPj4+IFRKQTExMDEgUEhZ
cywgY2hhbmdpbmcgaXQgdG8gc3dpdGNoIHBvbGFyaXR5IHdpbGwgY2F1c2UgYW4gQUJJIGJyZWFr
Lg0KPiA+Pj4gQnV0IGZvcnR1bmF0ZWx5LCB0aGlzIHByb3BlcnR5IGlzIG9ubHkgdmFsaWQgZm9y
IFRKQTExMDAgYW5kIFRKQTExMDEuDQo+ID4+PiBGb3IgVEpBMTEwMy9USkExMTA0L1RKQTExMjAv
VEpBMTEyMSBQSFlzLCB0aGlzIHByb3BlcnR5IGlzIGludmFsaWQNCj4gPj4+IGJlY2F1c2UgdGhl
eSB1c2UgdGhlIG54cC1jNDUtdGphMTF4eCBkcml2ZXIsIHdoaWNoIGlzIGEgZGlmZmVyZW50DQo+
ID4+PiBkcml2ZXIgZnJvbSBUSkExMTAwL1RKQTExMDEuIFRoZXJlZm9yZSwgZm9yIFBIWXMgdXNp
bmcNCj4gPj4+IG54cC1jNDUtdGphMTF4eCBkcml2ZXIsIGFkZCAibnhwLHBoeS1vdXRwdXQtcmVm
Y2xrIiBwcm9wZXJ0eSB0bw0KPiA+Pj4gc3VwcG9ydCBvdXRwdXR0aW5nIFJNSUkgcmVmZXJlbmNl
IGNsb2NrIG9uIFJFRl9DTEsgcGluLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFdlaSBG
YW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBWMiBjaGFuZ2VzOg0KPiA+
Pj4gMS4gQ2hhbmdlIHRoZSBwcm9wZXJ0eSBuYW1lIGZyb20gIm54cCxyZXZlcnNlLW1vZGUiIHRv
DQo+ID4+PiAibnhwLHBoeS1vdXRwdXQtcmVmY2xrIi4NCj4gPj4+IDIuIFNpbXBsaWZ5IHRoZSBk
ZXNjcmlwdGlvbiBvZiB0aGUgcHJvcGVydHkuDQo+ID4+PiAzLiBNb2RpZnkgdGhlIHN1YmplY3Qg
YW5kIGNvbW1pdCBtZXNzYWdlLg0KPiA+Pj4gVjMgY2hhbmdlczoNCj4gPj4+IDEuIEtlZXAgdGhl
ICJueHAscm1paS1yZWZjbGstaW4iIHByb3BlcnR5IGZvciBUSkExMTAwIGFuZCBUSkExMTAxLg0K
PiA+Pj4gMi4gUmVwaHJhc2UgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBzdWJqZWN0Lg0KPiA+Pj4g
LS0tDQo+ID4+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ueHAsdGph
MTF4eC55YW1sIHwgNiArKysrKysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+ID4+DQo+ID4+IFRoaXMgYmluZGluZyBpcyBjb21wbGV0ZWx5IGJyb2tlbi4gSSBjaGFs
bGVuZ2UgeW91IHRvIG1ha2UgaXQgcmVwb3J0IGFueQ0KPiBlcnJvcnMuDQo+ID4+IFRob3NlIGlz
c3VlcyBuZWVkIHRvIGJlIGFkZHJlc3NlZCBiZWZvcmUgeW91IGFkZCBtb3JlIHByb3BlcnRpZXMu
DQo+ID4+DQo+ID4gU29ycnksIEknbSBub3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgd2hhdCB5
b3UgbWVhbiwgZG8geW91IG1lYW4gSQ0KPiA+IG5lZWQNCj4gDQo+IE1ha2UgYW4gaW50ZW50aW9u
YWwgZXJyb3IgaW4geW91ciBEVFMgYW5kIHRoZW4gdmFsaWRhdGUgdGhhdCB0aGUgc2NoZW1hDQo+
IGNhdGNoZXMgaXQuIFRoYXQncyB0aGUgY2hhbGxlbmdlLg0KPiANClRoYW5rcywgZ290IGl0LCBJ
IHdpbGwgZml4IHRoZSBpc3N1ZSBmaXJzdC4NCg==

