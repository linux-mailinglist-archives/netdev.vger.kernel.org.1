Return-Path: <netdev+bounces-236608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF61C3E579
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 04:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC0B94E059C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB02F6195;
	Fri,  7 Nov 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="W4PnAJFJ"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023102.outbound.protection.outlook.com [40.107.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAB23771E;
	Fri,  7 Nov 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486106; cv=fail; b=HqzoiSxX6HE57zTHnCbgnFsknVZMWmhOoxqI2k7QihFgSS3YlizMsV0RQ9WkrQwz23ajes7+NdqWUp6s5SS+RrsmSdAypJsnhwuOaAK3WcBuqS4HH6N/O/bJFoIJhwmxzMLj3SIqp1oP4CuVGQ4+S9UIMVEC3M+O/M2imHFbe0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486106; c=relaxed/simple;
	bh=0cpFPnCqKgzHDZ7/unOUkUN/nywH6Wr0sAUpzk/j4WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=InreXUgE5AuBXEM6gOuW6DGwnBQ9otRycuwwainDSMD+bPjt6wSPXUeC8pFvEXHFPu25Tq/3QRBFH6goNp/atv4d6zlkTGRUk3yU2eHXC7u1EGJ04LAD5OV8Q79eFZlRuIAUQVaQ/rch3VQJgea/bWaFry5YqmWKsTt81UrE6kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=W4PnAJFJ; arc=fail smtp.client-ip=40.107.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoK68gsyJd3zgKiaOrsMXsuaMKG3G+L9VMphPghqiDGM00JNeoGGoqSy0yXXL476nhYi/rwrsLe18loWIoBkzwKOIyZEybquKpbGrKy38b8IO+9mJTNDXEo+PpUFSWieecQPWOemcvvr25jzqAmDaxjp9BB7r6V2dd9RCNbAY/BMN2jzbZeZiKJRSbbiX2PSeIDeSmLKBBb4SwPeYftlhzCsSJVXzgNTK+At0WXufcidOXnNza7GgXi0tqUj7sw6BCnAlVDhF9H4nmskkRc/dQrtu3qwqFLJS511JTJE6KrxvSDSP8Qd179JWpvePlMK0S3O0O9JHEJLaNJrB8XjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cpFPnCqKgzHDZ7/unOUkUN/nywH6Wr0sAUpzk/j4WM=;
 b=Kj8tDHBU1OGJkorTj/iZ/k6I/MOttit9YAWlMQ5ppH9DZQ5yLYjqKeBa16CE3lVPGJOa+mAlQ/9LmtELoTOmvZJNNPROmBFnnXIYkb0U/v5Q1PlogkfSFdNNLEo0mY5HqCocLttUPz+IxWeDb3KFuPrMVdJ2uz8Rel78V0y2Fszysms46fQMSgIsCnKuS6S4u1iLcVHcVdeWYEAkMHyDkAEXZdBNUGEw7GTt7TAfknB1PB97yG+SBfDWnUD0ybbKhk/0lwqVoPEsgJ3S9q2cCjZwSRyWjIIZVPGxUe0YkMZth2EdjN8H7vCms/DFdfMaOUfxk+9NKMu3TS/COz3v5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cpFPnCqKgzHDZ7/unOUkUN/nywH6Wr0sAUpzk/j4WM=;
 b=W4PnAJFJWd0GlSKRhxfbdJYK3qKF5/csE0ViDMYpLkfylpSBPcp7eIFqVTf4bILmGjcGOV/C4TvyODRbTD9Wb3c9ZDc6Ig+4k0Dyd3q3mbpEqcLzTXwJRumepdE93QIYcUAlZ4dXPQueoE2Kzd4RMR9xHLG2EmsEQXR3qZQPsv3C9QWAZnNN+d/syMcrcBHr12QasJjZ8oTZ3mcEMj3DUutTieNV21W5QO5IjJe6RQeZ0sL5DhGLpN19UIpfunWhPL4//MMSBFWx7KXh/yZgwu1rAES8gbSrHjzFzp7pvodH3FS9urtlgtNeVkfg7QbIYYtShmhbLY1HDJjXy8vhQw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB6100.apcprd06.prod.outlook.com (2603:1096:400:357::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 03:28:19 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 03:28:18 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Topic: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Index:
 AQHcTJUB+TmCwKSgIEaeQsrh+oaRd7TiLi+AgAAZOmCAAAUCAIAC1hMQgAAyMgCAAQXHkIAADFOAgAAHHhCAAA3FgIAAE6Wg
Date: Fri, 7 Nov 2025 03:28:18 +0000
Message-ID:
 <SEYPR06MB5134DA83FF4DB98FA2347CA89DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
 <SEYPR06MB5134B91F5796311498D87BE29DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9ae116a5-ede1-427f-bdff-70f1a204a7d6@kernel.org>
 <SEYPR06MB5134004879B45343D135FC4B9DC2A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1f3106e6-c49f-4fb3-9d5a-890229636bcd@kernel.org>
 <SEYPR06MB51346AEB8BF7C7FA057180CE9DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <44776060-6e76-4112-8026-1fcd73be19b8@lunn.ch>
 <SEYPR06MB5134F0CF51189317B94377C09DC3A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8b2f985f-d24e-427e-88cc-94d9bc5815b2@lunn.ch>
In-Reply-To: <8b2f985f-d24e-427e-88cc-94d9bc5815b2@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB6100:EE_
x-ms-office365-filtering-correlation-id: 3b1d5922-42f9-4213-8019-08de1dadb233
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8N1QlWjYfzov5ACJP9PeiXSZe4/RbppufwRXPGZXxrtE2nqonyft/a3bXvXR?=
 =?us-ascii?Q?f3DKjlE17VSOk5G1wNL2WvWIFyZZS+jKYAVEnYMbjUsoRjWi2jB/xuACFJoR?=
 =?us-ascii?Q?xz0wlxztQ63kZApYXgIdwRzrENNRE/fP8ceCTa1B/QRvF2qiLTygp1CsZnfm?=
 =?us-ascii?Q?8bWlWVs4EhS3KONG2S1YaHLBkWzKnvmO2b6ks5vdFC5IW6fLHeK/ShWMAuo+?=
 =?us-ascii?Q?PTpM/Ot3zo+rNyCLa5Ksr48SuAz5h8Fb3Yd+EzJQu0gHOX32u97KQa34hyMi?=
 =?us-ascii?Q?onYlRQuMwrzDKQkR5uovOmImsRB7kba8S4kzJEDX0ZxOhy9X3gqlgVMjVXa9?=
 =?us-ascii?Q?5pyB/gIXrvag/G61ntz9+jHHtsS+Dv+fdhOEHIFFeCJDfRmMQIbUTVt7+qY/?=
 =?us-ascii?Q?xg7OUnG8s38W/h0tgFLEUZ5MPxROFdzMXec6IPR+hySfQvWjnNIO+oBBM5/d?=
 =?us-ascii?Q?tTasbQl71WvWoZ65tdiduwPYMXuaUNeGaY6/IvwkB75wQYrefpvXns/I7a7x?=
 =?us-ascii?Q?1QScVbHZ8/XFRoXjnwlCNV4nXmgMh+O7zhn26jNwVcxKxAcq2erIiPhFEnyz?=
 =?us-ascii?Q?33MybHjUFMq0dtJ2r9AESdNpI56Cc4KIbo4FDwP2HEwISlzYLTGuQI8TY87N?=
 =?us-ascii?Q?aDuWSBCF9F4zIjq7+deIRTm+JE9hpQKC79LXxpgxl41LoH9qGlJg8caq2Ltz?=
 =?us-ascii?Q?p9hJVQP32Yl9kY3WpY6IOicAVDjJZvrZxmBrxGcX3sUAyK2vLlqU9lmFjPXP?=
 =?us-ascii?Q?s1XP8GrR+gW5WrgSleHRFbrdzufmyLHFqeJNl4SGzAx+O0i03DPsMffmYU+g?=
 =?us-ascii?Q?SfkHZIgZBLGqw0s+/Bg6AO9ha7ItcfNpvcPKl50AtSe0g8Oww8C9i3Zh8gtz?=
 =?us-ascii?Q?X99TzPuh+0g+OBE3AgFXPFqBNa86YF2LuNwomLWzuPKE8npkJZwL+O++UN6v?=
 =?us-ascii?Q?rmRqDYytNeX977Q249xNt7PsT68BpBl72nBhHEvMlWh720JTP6UGkgOMkMtP?=
 =?us-ascii?Q?FJr0pIAJKIsTiz9Nmb4+37Or42ISdUyn37x2dwAEbKgm6bfEFlJuq2upKr5k?=
 =?us-ascii?Q?stH3CTWPwE4yKBcoNALY+vSikyuYCBlvdkwl/vSAz92ej0lKEMsL/EMcgixE?=
 =?us-ascii?Q?JzrKzDvuYxz57/86cxsmWU43Y8l7pM3C3S/q+n9R726FfXHvQcurm2WYxNBe?=
 =?us-ascii?Q?9n1gpQi21ygwtQJZu4sDsbuuhaY+/Ih7emubMdnF+keIn1HrF35Pcb6vnSL2?=
 =?us-ascii?Q?2Jk0uMFvleralwnOcPmsHNhxHQk0ec/U9OeXHZ4nZQfZkylSPvEjopl0exDz?=
 =?us-ascii?Q?b9F8OfKa9zh+dobNnztBSMDy/PFecLbJqxOOEOJ9JnPYOWEfPG+ljXUblxEF?=
 =?us-ascii?Q?GPzgAZr3VZut6cxK+VBkhwowqXMFh6gb+LFQomg++Ymko6LIeOVZ4yjhxjcl?=
 =?us-ascii?Q?ixT9yUrCgSsBABr1bLN26uX13fP7WaxTqR8IV+RWD8cwM2nbMp7O7xaFcXn1?=
 =?us-ascii?Q?Ee7uJJaOuJPiUQN/UrENlX3l1PM1SaPIvbfU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HtHnDBvp5Te2h1q5JpzYGQi7scYrq9jh98OBndBDgTgfmgmOqCvOZLvXdWeX?=
 =?us-ascii?Q?YPCiVS2Uf1w2cG1s+PUx1LhCHqVOW4m6ekWrFduOvHDeP9b9j9/slzqsfppP?=
 =?us-ascii?Q?nemdZjOqbZQLJZaXxFDGKMFe6u5N4/vy5SyvIauBp2mNPoxrU7PQnsXfNML7?=
 =?us-ascii?Q?3sj/TszDbuo7nGCOxawHDRBgXgJOgSmadSt4pwRoB8/03KW37fVa5luLR1Tz?=
 =?us-ascii?Q?YnAzEzRiYbgbv4Rl608KRFP9ZnPUykMAmmz7VAmDQE9IyXjOQ2Nl8xE1FQv5?=
 =?us-ascii?Q?IVIt80dyyA1En678VOAMW0dHN4tVLGHTNQ7Rri/C7rer5yyoRVtf903Sx6rn?=
 =?us-ascii?Q?RE6Rt4mQDK7EpyTeIQ8CGOd4gb9MnA5Zk0voLncmImjjZitlYH73/KdungNF?=
 =?us-ascii?Q?EVjeHVo5N3VnKC6M7w0h9DFGmjLpGyP7iYtxfTKyy/5pWTazc2MXzHW5Tdzo?=
 =?us-ascii?Q?8CaYLTPpJgoWg4hxOE9Zu7o1pLcxOoP35MDJYZMPXq7vYdhG29t9wx+WPzhU?=
 =?us-ascii?Q?87Z6d3xhLVjnso/cQy1jNsAlrkXUouDwkeyHGNhYXTEmDQPA1ZYz37iH2RGl?=
 =?us-ascii?Q?cT/IbG9PiEoq17reGKb2nTrzCJnCy4ogBDCvjgc69T/OGu8P7y5IQjLT4Efy?=
 =?us-ascii?Q?7rpz8x5V51vxYfRVhAqB7vwPPb2w2x3VJMBmevkw5+GKdXp4Sl9NNZHeANbm?=
 =?us-ascii?Q?LpwPTg3/uYHeeeq/Hcvq/i2gPTPy7J0yi3g73vBVo35GUOUUGuvsnxhLZ26U?=
 =?us-ascii?Q?yWyJHVZjgRRWop7Kp7dMeZxHakbg3lRabljIQ7DWSE9MkMeunJ1Wr5l6pV8d?=
 =?us-ascii?Q?zUpeprFafWNtljf9WytFZGbf1EOtUDFlNIWucUAxzIEMGCp7r3RP/LF3njQj?=
 =?us-ascii?Q?BsSJyqwzbbuGfKFa14Ykue95Bu506tFrKGtk14d1LX2rUstsnHz7W04y9wwU?=
 =?us-ascii?Q?cxymEw2Fw9x41EgOJv8cfRZ6GJpjuOd5DaMB63kVbRGMoNXHkW3cYYlpAwfj?=
 =?us-ascii?Q?Q4LCs6m2y4rXd8xw5EYt8x26TXNo3e7vmEdHsU9hIFNNSroys68I8Unrq8Rq?=
 =?us-ascii?Q?AvLIqtJfnM7Prlgq4iCTRdV9hRlkJfGXOnjFbwydXS45UoPNg3ILlRLMHIhu?=
 =?us-ascii?Q?gV3GCHpce7xrFCEfN7bDBrmasiZHzZ6Mp9BBkrVLYr3NQ+QyoyKZ/PEJP2KR?=
 =?us-ascii?Q?c2jlK6CHwa08xT3/PzCmrg05lyMZchbTQCyWEO+C8RrE3u04bFF14szX64zA?=
 =?us-ascii?Q?75XnoAUD0SokfCQlNofJQECAQ/8HaRCVUcqkhgvHJ2bC5Z6D7eOPAsQuMjH0?=
 =?us-ascii?Q?83Ou6oID1VCoREZfYOnG8waoMavC+jDnqS8tbs8gpoQcscm/j0bjDHhW2WmQ?=
 =?us-ascii?Q?sYjWrZB43ncfm/cLjZplQzid/ujGZKKTeiMsPLb4VJp9I7iA227PdFidR6Jr?=
 =?us-ascii?Q?SZ1wsvpE0NRetfPPC50mj31DKaiVQMyVSQISi2DCwqsrQDzcN1l8VdkLhMAn?=
 =?us-ascii?Q?bGD+FhTaEbN/dq/Ay1cS9r+V4EIubdo/8KxKR26SF8p+nbeH1/aWPK9nyHvI?=
 =?us-ascii?Q?Ut4Ik4jf5gvHCZV7mwvAHhnIaDUDGykOzywuWGt/4zFbs4oHRTf21WhqeF8/?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1d5922-42f9-4213-8019-08de1dadb233
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 03:28:18.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtFa9FqdmRUqtvJfcHU7c1x2TTc9Bh3tMwReXzk/RiOExXfjCdrQQSEORan3SML9PdGLKuodrqZQ9jXdtmqNCEbzV5H6JtSodzIgI0zxFSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6100

> > > > There are four MACs in the AST2600. In the DT bindings and DTS
> > > > files, what would be the recommended way to identify which MAC is
> which?
> > > > In version 3 of my patches, I used the aliases in the DTSI file to
> > > > allow the driver to get the MAC index.
> > >
> > > It is a bit ugly, but you are working around broken behaviour, so
> > > sometimes you need to accept ugly. The addresses are fixed. You know
> > > 1e660000 is mac0, 1e680000 is mac1, etc. Put the addresses into the
> > > driver, for compatible aspeed,ast2600-mac.
> > >
> >
> > I used this fixed address as MAC index in the first version of this ser=
ies.
> > But the other reviewer mentioned maybe there has the other better way
> > to identify index.
> > https://lore.kernel.org/all/20250317095229.6f8754dd@fedora.home/
> > I find the "aliase", on preparing the v2 and v3, I think it may be a
> > way to do that. But I am not sure.
> > So, I would like to confirm the other good way before submitting the
> > next version.
>=20
> The problem with alias is that it normally a board property, in the .dts =
file. A
> board might want a different mapping, which could then break delays.
>=20

Agreed. I looked through ethernet-controller.yaml, but it doesn't seem to h=
ave=20
any property that fits our needs.
I will use the fixed-address value from the reg property to identify the in=
dex of=20
MACs to configure the RGMII delay in next version.

Thanks,
Jacky

