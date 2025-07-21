Return-Path: <netdev+bounces-208486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0FB0BC2E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE91189A8D2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DBF20010A;
	Mon, 21 Jul 2025 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4NxiTTE"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADE13A3F7;
	Mon, 21 Jul 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077658; cv=fail; b=r4DQecnyIozlt/Jfur1aU57v6iaw4ZSoBOPWMDfs2akydFJc5TTib9XCbs+2Jq8aIWM1mAMKWT1DKjDRx0eaYjE719LDfeZYZumsCzVVeW5x35yFBgw/v1oZI6Z07f6MsUe2U0u+nKmeVFoXI10EWEOJf5Vkwn8FPcDJXygrgDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077658; c=relaxed/simple;
	bh=tzWaCk6vBfiPiscI91sIDWTaqNg4SdHz5e980x5b8JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CUC/zlRVVw+OiIRKuoG6PbycAhXjz8mYRLnLu9y6xom4IKw52ZD6jteDxWsto0SMTw0bRIa6tjHJl0pzzkmXnLQQ/DdpiVFH3sRC2ZHli9Z8bbVZWLtNlDfNpOd4UG4ABuL1idaXFUSQ0Ig9O25BebZrUAUroGJEztFkSVInz6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J4NxiTTE; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1bTjbDZuQUQvCdpxGKRB88Z3McHSiYxJ4E7bX/rY+/VETHLLF+MFa+0mmxtxQdWM4WBtSOGdCSlLDPZdT+XEMzqzhUYqeGnuVHyUj3dFJZja6EKHtUwRchQ4LFeneATgrHbGmlRsw4XgzweFsj5nJ1Mtx+3oxH0bAf0YHQlZdyiyYJOOOHcvEllzfVz0hCQ+Y27HBS7fayb9dARm6kFi+/s0EDdvpZgftybh02Ca8pw5TESBI/Q9TcmrIcLW78nRwheuxrZ05MXZkTypF/kE04SvuFVo23P2d6bcrUmROfbgBGiZOPDjG7mSbjVOJMMWY584t+2cAijLybu03T6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5e1ps42iavB3NamcKKq+JN+reNhKLAxE7uvaq+dP2Y=;
 b=w8s/t9NcWuJ8nQbLpHS6ijVOSyIBSt4hGALd1BVt+7i7nLNLxZm63Q36QcljnbMGqNKJCQHgvzdql6NlPAPM99XOFFIqLp4MUsKiBg6A2t7yj1/Gxo+8S50cwZ2Roto15rgC2jQQXmdzxTwx0nzMiPqkckm0Fyek/iWpqSt/xISmmCXSDY+HOSr+U0EpQEDn13ODq08/KyE1T9shhElAHA3b73D8lCVXAdpLIEpwlJVLPLlZERb1reqOzhvLgSMUWNP3Ow93+Uo/oDoobcDT9Rloxb+cxQpods458XFizwKOK4QIk6FMz+N7Ro2jfc2J71UYeYcPahCr3Lo9sKnS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5e1ps42iavB3NamcKKq+JN+reNhKLAxE7uvaq+dP2Y=;
 b=J4NxiTTEN9nmHfpf/lffuuxOv8aQ1bV38zmTC75y4dnRxzA6Y9ZEiZnZGX5y8vnFAJyUauz5EfVbxDiSndxnVtO65CXdNmtyuZQjXkhoNypATnZldElSTyI3/comxSinD7OGafSnrTNZOC57iAjaL7nt9DZinI6/v+Otonp69c/Toyk5AnhJASQMeF71G4/7iKeBnn2QeGINMhnVN5u7eRxOqdH5i+W6QhOh8xMBIhUZqqPAposcckCnNb9JAF2pIUssWd1t/+cibIwkMHK+b8YzeP/YDg49O3HvOmcLwmul5b8j/IJxuFEPhb9PPtDgtTViBtcnr3LFjQdMZn780w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:00:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.042; Mon, 21 Jul 2025
 06:00:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Topic: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Index:
 AQHb9iZmm/EQyWHMi0uUtvbMzlnJDrQ18GUAgAAJ0BCAAA9ogIAAAdxwgAANNACAAAF4IIABaaAAgABHNYCABCbhIA==
Date: Mon, 21 Jul 2025 06:00:51 +0000
Message-ID:
 <PAXPR04MB8510333427EE012CF3E2A312885DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
 <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250718-enchanted-cornflower-llama-f7baea@kuoka>
 <20250718120105.b42gyo7ywj42fcw4@skbuf>
In-Reply-To: <20250718120105.b42gyo7ywj42fcw4@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9838:EE_
x-ms-office365-filtering-correlation-id: 516adcb2-3cc1-432d-4ed5-08ddc81bf252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5xV+bhksVFdAh3Y+PzYwLxDGkyEac6wbmyjZ7puT6VJC/ytcSLmCkL8WPhJy?=
 =?us-ascii?Q?o67RBbOdoyBUFf0p/iyK2GqvR42wDFDxtyGqpJ3Gan48xa75054wHHVRvsD8?=
 =?us-ascii?Q?cps0ATfsWGbxKzmzSqnHrfyKFYC5RxPBOQOJEKvoSVXofn4pdXZ3Zpg/YnEm?=
 =?us-ascii?Q?qWWjwsQxEbh92/uF/sMtE8567Qv9lmkrocAfNytPm3WGUmW827i/5Gfq6U3n?=
 =?us-ascii?Q?Kn12iTkqRGav1Arb7lRGSbFBWUCd9kc37iO4S+YB/ZB/2arCdW/Rld4fiDol?=
 =?us-ascii?Q?aZK+xaIV7SXEfy31n3/7nrUfo5io3fCp6C1qOWRpR73BFwxCD8lQF2VpdJCd?=
 =?us-ascii?Q?Ik6dT8+ZtbUb9xc+WmkTJzaQ/0K6Iicsj5xjKy8wzmjicniWE6To2fzUVdA4?=
 =?us-ascii?Q?nC+lP05kNSSy72KpTkJviFnfLxro79jnbhLDvUEL7lQgalSxxhEuzTfBmJ0+?=
 =?us-ascii?Q?gdcmVvtWB+QHDjSom9CtP0qrR4SnRuGni2OP+V8OIwya/iUAJjBQsil/CrB7?=
 =?us-ascii?Q?L+JNS2WTVw+pYARRHzmVIrkakd2dXXOebi+N6KV60NaxQHFFw+Iqt7XsBZ10?=
 =?us-ascii?Q?DmqTbM5wgTU1Dc5ZkUlzxoicO/i20P2reA+hfj6cZnoDM2Lso1smD2h6ICpG?=
 =?us-ascii?Q?N4fT8XCwHz9vcN4Gr8VcVQP+uJNZc0w/BxO4NGSaVl1GPeBpN917kMB2i/Dz?=
 =?us-ascii?Q?Di20LgRUH78QZOmlnVQqu/y05qlT39Iu2vMrXthuVCDntRSyDdfzMad7vNfM?=
 =?us-ascii?Q?JqrPdaPuuaN2uyn8/tCDiYv5zgJXk/m8pGvUvj8dpAPTxJPLNzXfowEHeOv0?=
 =?us-ascii?Q?7WQRhkG42RLG1fkkdSxjQyJWul7cuZt6eQqIQYJHs/EGwJzHh0dALnfAbBSH?=
 =?us-ascii?Q?2mIMe55cMoB3N5J+kWuv5pFOoZ5wEidb61Oo7Tp6LXudqH8J1vmbStFq+sAz?=
 =?us-ascii?Q?Bm17rCfQsZOVXXNV826fy3rl+mZCoyTDxNsYWB29q5qhODjiEoGnq+VsmaLh?=
 =?us-ascii?Q?wQq46VcdRS3kHw2cFqtE+jie1YS2v/NqcsgUKKYAQ+G4F+fXD0Yrpdp8QufM?=
 =?us-ascii?Q?HTdIuf0lqSz+87tisoeU0GqIe5ZnpRsw6gihk3OMm/JZo1uf9Nf6WTgrbeiv?=
 =?us-ascii?Q?g7LGXXKcyYA4oVilk4DTWah0bjVfv61UTcxknPoqhTjSVwkm36QHWWNOWsbZ?=
 =?us-ascii?Q?NEe6PId9+lDkk+Irm9dIAiVDjtRxdxPmuka1I9vwweyqPr5sucNdEJDVIHES?=
 =?us-ascii?Q?AuoQtxXnjEStwWMFlsI9PiEQf6uvAJHRBJ/BoCIuaKssngOzRnURrMiU5CCS?=
 =?us-ascii?Q?OXcR2RbP6/A3XmTenElmcrk1pHsToMHTdqFRw9hKeH+/EY8x39woyOhaB8Eh?=
 =?us-ascii?Q?QeLn8gBKO/G7h9acFFibB1dPuf7IVDr/pfhZibpZ2G3u2Laxt6ky0KRoWbMq?=
 =?us-ascii?Q?Wx0xI8Z0xn+D0DDbrIPraJqSlA7wbVOS60FzYQV7cEuU8gAT8p4yxw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o7vZIphq01OaiJPtOKDC/zNDT5kZBgG9+APJmzDzq1B2S7KdL/VEdVi3XxqJ?=
 =?us-ascii?Q?ynjx2+E1wuwg6V8SYoSbcKrxZkJ8C8yAi4lI5uEj7K7P3BQdfAW6VfJ353jS?=
 =?us-ascii?Q?IpydNYp8ApNz3pk1wczfVJz22UiT2X0ak/ggXeSz2wLe9ASIKWJuI4X/uqrd?=
 =?us-ascii?Q?vWUnuvI6142crLBOccZ4UbLxwiG7w0yOvJ26dlCkwVV3oPY44pMAeJ9ezmHO?=
 =?us-ascii?Q?3sgOtS7V6iScccWeyrjRrZEgO6sEe3x/45Xw74KyOJNsxt99Wo5M0bKLLB/o?=
 =?us-ascii?Q?8euwL+g34JXSUjf29ysAtQsEEtYbakRkIaajpORL2LS8U3bswRPZRdljk7DD?=
 =?us-ascii?Q?jNNIqjrDKByu6APR7GqH4tvyDM7zi7YCm4rgZpGggIJucJtICC2Qzp8lOPtO?=
 =?us-ascii?Q?pdLzgn3wPo/SygZBW7WJ20fsEphP2eOpOs6AoqNKzVEAyftHFc48dMcBa7Ta?=
 =?us-ascii?Q?NePMalDk2oLFzDRAfb6saxYXOKZSVCltIzr15jI4jtKlK4SrTYgjAWtcpk0R?=
 =?us-ascii?Q?enfLFo+BPnYiaLy4lHQGNVwn1KpJo/cKehR0RWrIFlItK6VW4T1ywwlDHyok?=
 =?us-ascii?Q?GJfh8TkW6iyjA0aB8QnTpbtEwjTHsQZlrVNtMgup/hxZsftEAjct0xIOr8Xm?=
 =?us-ascii?Q?v+bEJl5jEx/9WY+n0MoraNe0o3pyz2CCHktJrQvyTYy8P8gUbnXksucK/xrt?=
 =?us-ascii?Q?IW6azf/pQaHeuqecj16ZwHQHLU7DNWYyzZMsPg3sQ+S1yV8slmXfpqlutI/Y?=
 =?us-ascii?Q?kUooNtMK1snPGAzjipGWJD3x4p5soba6N2fTB+svdOVU2fB6vGx52GyTaavX?=
 =?us-ascii?Q?XdmT2jBFcM/KybyULb2HrK4xnC7jFpl+9LFtBPLFG93+DYA0ko0DVD5Z8Y+v?=
 =?us-ascii?Q?BD2fCjpfmOdj3hxhZK19qqHYF09wflz9tLk3bY8W46kUO6KI7oxFIyoWz9EN?=
 =?us-ascii?Q?fl47Koh6R7FeRdS7hITPInGoNPxYaEcoXqVS+QLskLJQJqEKpQFeQkm8ZFHw?=
 =?us-ascii?Q?bDOckLSpQh2F7OWKo63uXWc/UnkwzWAXPgUN3YHy531ssx1QZs/kVzGPkK4c?=
 =?us-ascii?Q?qxwU6YujBF5ChHNoBMdFznYWt/Ndz5WOlONG9eWbCtp4hS4vOU7wmErOfEvb?=
 =?us-ascii?Q?lcf6vrPnPmcQjhQQ9NrB1qsiVAFwTWiDMQVEW7q5hqnOLHM3DDNqlsFMnsrQ?=
 =?us-ascii?Q?DaxQr6tQGf6pdeCiJfavq767BUPfJkeoAy1nNgst8wQJ9NieS3kRxzeQ1AQU?=
 =?us-ascii?Q?z7LQxwgLIDcluAchMXMUXdxN+4twKEK4/Ts+cK1Opd47FYpV3qxY+Olu8Ogd?=
 =?us-ascii?Q?oHPb9QASN0MSI0TzorwycxGtHucKVKP4L1VKs1AfQgODx9t3bHDwdz628pSH?=
 =?us-ascii?Q?LimXBeetDbY1BKs87YtFRvm/U+GIDcuhB9mbS+8nHRihttrSXsdXdGRP+lDb?=
 =?us-ascii?Q?CUKIbGNUO7J1NF4GQ6nQ7zSLoncf3m4yb4Ia3O9G8EN9X2cOLNZAhqrowcCZ?=
 =?us-ascii?Q?DfWhJLGUlxbxGy65h+SZJfRQRuR0qJmJvS883Sr7fktZIGA7zAqrH7fnLkci?=
 =?us-ascii?Q?+1uxSugdnI+w+vFUb+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516adcb2-3cc1-432d-4ed5-08ddc81bf252
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 06:00:51.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgFouE9uL98uAbALMCnL8ZYluukObzU8LQX5QrKFO3rxm6Ts4++s9W7kYMKF3g3D/LRUr7F5240OwXckhMQJSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

> > > > > timestamper:	provides control node reference and
> > > > > 			the port channel within the IP core
> > > > >
> > > > > The "timestamper" property lives in a phy node and links a time
> > > > > stamping channel from the controller device to that phy's MII bus=
.
> > > > >
> > > > > But for NETC, we only need the node parameter, and this property =
is
> > > > > added to the MAC node.
> > > >
> > > > I think we do not understand each other. I ask if this is the
> > > > timestamper and you explain about arguments of the phandle. The
> > > > arguments are not relevant.
> > > >
> > > > What is this purpose/role/function of the timer device?
> > >
> > > The timer device provides PHC with nanosecond resolution, so the
> > > ptp_netc driver provides interfaces to adjust the PHC, and this PHC
> > > is used by the ENETC device, so that the ENECT can capture the
> > > timestamp of the packets.
> > >
> > > >
> > > > What is the purpose of this new property in the binding here?
> > > >
> > >
> > > This property is to allow the ENETC to find the timer device that is
> > > physically bound to it. so that ENETC can perform PTP synchronization
> > > with other network devices.
> >
> >
> > Looks exactly how existing timestamper property is described.
> >
> > If this is not timestamper then probably someone with better domain
> > knowledge should explain it clearly, so I will understand why it is not
> > timestamper and what is the timestamper property. Then you should think
> > if you need new generic binding for it, IOW, whether this is typical
> > problem you solve here or not, and add such binding if needed.
> >
> > Maybe there is another property describing a time provider in the
> > kernel or dtschema. Please look for it. This all looks like you are
> > implementing typical use case in non-typical, but vendor-like, way.
> >
> > Best regards,
> > Krzysztof
>=20
> An MII timestamper and a PTP clock (as integrated in a MAC or a PHY) are
> similar but have some notable differences.
>=20
> A timestamper is an external device with a free-running counter, which
> sniffs the MII bus between the MAC and the PHY, and provides timestamps
> when the first octet of a packet hits the wire.
>=20
> A PTP clock is also a high precision counter, which can be free-running
> or it can be precisely adjusted. It does not have packet timestamping
> capabilities itself, instead the Ethernet MAC can snapshot this counter
> when it places the first octet of a packet on the MII bus. PTP clocks
> frequently have other auxiliary functions, like emitting external
> signals based on the internal time, or snapshotting external signals.
>=20
> The timestamper is not required to have these functions. In fact, I am
> looking at ptp_ines.c, the only non-PHY MII timestamper supported by the
> kernel, and I am noting the fact that it does not call ptp_clock_register=
()
> at all, presumably because it has no controllable PTP clock to speak of.
>=20
> That being said, my understanding is based on analyzing the public code
> available to me, and I do not have practical experience with MII bus
> snooping devices, so if Richard could chime in, it would be great.
>=20
> I am also in favor of using the "ptp-timer" phandle to describe the link
> between the MAC and the internal PTP clock that will be snapshot when
> taking packet timestamps. The fman-dtsec.yaml schema also uses it for an
> identical purpose.

Hi Vladimir,

Thanks for the detailed explanation, I think so too, but my previous
explanation was not as convincing and professional as yours, many thanks.

I am not aware of any similar cases before. Thank you for pointing out the
"ptp-timer" property. And I also find the "ptimer-handle" in fsl,fman.yaml,
which has the same purpose as "ptp-timer". Actually, these two properties
are exactly the property I want.  And I think this is exactly what Krzyszto=
f
said, use existing properties instead of adding new properties customized
by the vendor to implement a typical use case.


