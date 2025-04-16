Return-Path: <netdev+bounces-183243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E5A8B71E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BB544488A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC523C8D3;
	Wed, 16 Apr 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="EY0aUVfF"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020139.outbound.protection.outlook.com [52.101.169.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13B23A985;
	Wed, 16 Apr 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800445; cv=fail; b=mE1xeJTaPkjIXxrpr1UV1OWoYJ/TYh7gdoq9HKXXbDuuU7I7Cbul7dQWfYKL81PE7Cl41tOU1/7NfACdm3nZ1o0a86lrlB4wzMNlufU8G72x6o9Lm74tW56r9ya3OmpKWIGAZWT8mx+7QEXMOnDQuR+fK6zFgszvP1DPkfk/5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800445; c=relaxed/simple;
	bh=8q98G3MzY20N0+kU38/eZEvJmlgKVj8uUFqpfNLmDEY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cw3SULNCG40e4HwKxxUDPuI1yTKNccVgf/r3gGVOCm226aTWo2OKghvMP4XOOhwd9tP4aiIjKRzA9wQa7qA9JjuzWo5wzV9K16+WUOATWWJXE3F4XiLFpzPN1dc38jIGin5CepsuRPAG/NkJpo4GUON+nRqlB6nsUwfbNM3iYUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=EY0aUVfF; arc=fail smtp.client-ip=52.101.169.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=holxdy5vG+XyWCM0XsaHU7y+O5dHWyYcqacZiPfBAm1HfP5hhfZSeJcx+fLL0GoRXBp9kLcsg5/LSEtiF1Q/Yg3lLMMEu5+rezBByWFm8h81ru7ht1OSXDLaOAItEQhFJn6+FObdLJpQDNmhcphbM/pTvoASbm2qYkDj3XnKsIq/595me1z2tCHI9RU51ZUnf8KKbojStJ3akcoCjPC6jSenJPRy7KKOsSiZP6uqvAavrXNQi9Mrh2EeGvw8PZMPIGfSMD1UzqLzwgOYymHMdF+ErhMhMcEzrOBmj4Jkg9GVORrLYHAGqUuGbm+1SdfZ48uKGMpL+PXcOrIZjMiMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Ym+jaIqiMEK7gJgHXcUSrNiXErCNEmbXVTmwJiHZw=;
 b=awUC8dAeWifpEqA1uXq1WmtbZe7rYzklmYxy1t2uv/uyCpgcSQsHknBi1ltuTHe0DTVexHUhONUAkR1BWhf3ZR0lKsR6DrK8vt33h2XpVyx3bpk2nSucnh7INsefEicgKoyjNKyBeeVMZfbEbntfZ7yqjKYlYebrki7XvSiW17agICVHntax9j7yh4M9JRCzMJ9rya8cAzHVEmZDkvRQdmp9JnsY9YuqQr3vq75RHb3BQEwXiF4Vuop5r2LoRaThbJBUWUC56fiEHzwdTnFBnLJakF3l+EaGQGQMpOtkmFaxOZxGniXBkCQGhWB58cxpWisGooA8RJxKgCpMIAEHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Ym+jaIqiMEK7gJgHXcUSrNiXErCNEmbXVTmwJiHZw=;
 b=EY0aUVfF5mg1G5wucofJke8KVhKf7MLsCQi6cIe8mCkwu6LgJggQRYiI661Km9K1fs8EUZipvVTm+eAr63IOSyR11sQSlVdH+0JdvIJa11loBwPYZLGKrVOKII69ja0XXKqfRUrGPe5MvKJ+Py0+GMvr4TFU5lf/Lu/eS+jCXf4=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR4P281MB4404.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:122::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Wed, 16 Apr 2025 10:47:14 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 10:47:13 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] net: pse-pd: Add Si3474 PSE controller driver
Thread-Topic: [PATCH 1/2] net: pse-pd: Add Si3474 PSE controller driver
Thread-Index: AQHbrrzpVc7077STXki1+R4vF88EUw==
Date: Wed, 16 Apr 2025 10:47:13 +0000
Message-ID: <93d3bbf0-742c-41d4-83c6-6d94a0dd779c@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
In-Reply-To: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Enabled=True;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SiteId=423946e4-28c0-4deb-904c-a4a4b174fb3f;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SetDate=2025-04-16T10:47:13.708Z;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Name=General
 Business;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_ContentBits=0;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR4P281MB4404:EE_
x-ms-office365-filtering-correlation-id: dd710d9e-d01f-424d-adbf-08dd7cd40c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?NG5Y4V+ogkISsI/ywywN6iesQILExx0F7uRCL6bFWO/r9o+R5LaBQtN1IF?=
 =?iso-8859-2?Q?g1GHrnywXWoreXTMT4W5o3j/QXzeIer8mtNjbeElhfqqkckW9EagQuXeJG?=
 =?iso-8859-2?Q?xFaK/vYhddj59FRhVZmHBMafvTsw6+y8QNN/k6g2ZjeJGR0csYtlfGjFU8?=
 =?iso-8859-2?Q?COpM82UxmwYfUvjRrt0jWyR30vdLE7x9MrFG3grZ6e7GLTetNgFo8yX1vM?=
 =?iso-8859-2?Q?GUQZhn/xrgacQRPhh2q/KtEOE8rbqEa8R1O07F37Dkkk4MuT7NiDf93qcT?=
 =?iso-8859-2?Q?12IfP0ZUDVVAxiR6h47YDi7MHf1dmt3KkWvTG8WHvCEV5uUEDdRnuoIOXo?=
 =?iso-8859-2?Q?BPEhqrEk19U1OCyohUMrBnAlkSH1JrM32lC7aUOyTeC5SRmPCLm67d06DQ?=
 =?iso-8859-2?Q?aXBt9rGfhqD/eH8z4wp5ENr/SO+oB8kBky03ruNjTO9TGxzlsW6qBASchd?=
 =?iso-8859-2?Q?EoTfM6tme+IoekNr+DbGDu1OWVJhUrYemhYb9jXkNPC8H9WpQE51WAP0Eq?=
 =?iso-8859-2?Q?2dmh83hfcVNsCq58O7LSSVtY9dVL5b334QHu0LiXk9UlWCkkLgoaiDthsx?=
 =?iso-8859-2?Q?eFeoJkSHiUmWmDwkTaJ4CH7Xw1Ml0xK3g6Y3coQ74WahL0p+JcA/l+9s9e?=
 =?iso-8859-2?Q?we5iw/VN7W6RG17G7S/8UxeX5+lXmtgsuBWgTFwat6K2z1lCyA51gUG7jM?=
 =?iso-8859-2?Q?K9ICFjrnv2dA8cBzpoeMQz3dqQTcL4rbDatahpLZlTgLwCoZ3PlXNlfPdy?=
 =?iso-8859-2?Q?YYjsJull5tRpBOcvTy4uwn9yZN0Iii354yFAFBbzO+sB6Eeda+J2kMi6oa?=
 =?iso-8859-2?Q?eBhO4DFIYpbZUIHr/BUQ6J0dT0G3EXSOc3F3dXxEoNpVymi8xv+eclWCwX?=
 =?iso-8859-2?Q?BiUFxWOQJZDkd1wr8xI6RkWBOZCim4hytMRAi29d5Qr226d6aL1zSMU51s?=
 =?iso-8859-2?Q?XUw+980rv6gwyp8cxyJhbjlCW5dMlhpL+CvsHsbxTMVaRQ0MVcrCSrZVS9?=
 =?iso-8859-2?Q?08w/r+3IoZRg900Yzztm5C5n/F1WC/RuP4Mx0r0tWj7uTsI2Y41B4DsgdT?=
 =?iso-8859-2?Q?y3gZXAXNXxI8IrDkxVvChuM1C0zlAMqeRuLXX4RJts7BI49zB4SLaW1amx?=
 =?iso-8859-2?Q?ld8UvpsRBCzxANTOHBa+zBWdXsb94KWHtfGljRp6NmqBPQurrIiKmEGZYY?=
 =?iso-8859-2?Q?HV2fSQ1lgtKw7nOSMEfjZBoXPAjU84Vntkve5szMNFiAxG4f37mkaS+MAz?=
 =?iso-8859-2?Q?Aj8AzX3vjRp2fBwMbpIunn9r3BPu7I5ILAT0jjaKBBbongTs8WpyK9J1w6?=
 =?iso-8859-2?Q?eRDDgbqY6ZMvW6Lf2N9RWwiUNp/1geLmQNz9o4LvSy/gXcRM3hvSwEgu8F?=
 =?iso-8859-2?Q?7j48ofSAlXSLQT9bHk5659MWxJOTFcxA7Bme19puYpjuK/vc4PtFGcr7gl?=
 =?iso-8859-2?Q?mkDjYn4im+ybaZhXmG0B/smxFRl8ww7Zj2Wd5nINxRPivS5y9XakWs9XfU?=
 =?iso-8859-2?Q?qaW4IVKTeyLQkc+7ZJAeaSLcdT/PTwHNAUPR0eKPKv55BXcvdNgWBtFTdf?=
 =?iso-8859-2?Q?qweJbLM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?WmFmtsXZ7wrxSzVhx/p6jEQTvZ+tOG8YeykGZSIDi8iXwtFup0lt4Fx4vU?=
 =?iso-8859-2?Q?KV2+fj1NFQLXwpsrjt0772HXP3ApoR6uVkZWn9O17gb7rIM951dNXM75nY?=
 =?iso-8859-2?Q?jE//AiUmGEIh5TTzjIuhOd7ugJQh9LpL899VjmvwFAvuugxOoqcqmVNoUt?=
 =?iso-8859-2?Q?E0jn+O8UP/4Lx86DwOuKSVHvqYMv3/mX2Tn3qxxaEXz57JMG5pkOu+C8Zm?=
 =?iso-8859-2?Q?8BVzyDpZXkTGlHALmMrj2xiars0mw+TK8TgFRgAwEXIszc7oMLezv2LxnR?=
 =?iso-8859-2?Q?DKUxQiPj6pOKS0b9uoC432fp7yxLalQunGnAVsP+F6V8KCHNosGFxUBjI/?=
 =?iso-8859-2?Q?ew0z2msa8Xf9dxtRqiLHKHKH76TMo3wwjXuUNAYxVYXe6Qzn8kwLoqV1oz?=
 =?iso-8859-2?Q?wO0qvlA4gPfmv71gwNb69p7us128ldqpJHHbYD94ULCU8dmZvu2SsIsENU?=
 =?iso-8859-2?Q?0o4LnyXoxzfnJP2nTIH0aTewdakuP75oQW12wM2MGYNMFWTCAKg97uK+X0?=
 =?iso-8859-2?Q?+oOtvFF1AgJj9lcGho7KuDs84NUpqu/Xhpaqqam/NW47TO/ymw/ridkkZ3?=
 =?iso-8859-2?Q?D1+XLJveW38470+RJqPqjTPPwwZygzWPURUGvTYRjOUb6rVSZ9uNL48pAe?=
 =?iso-8859-2?Q?RI3TspxIkVPPjQl0PAkNZq2tN/y2wVo1chIkxOR7FerBi4XCpxRqb/EC3E?=
 =?iso-8859-2?Q?dkOlq9d2W0H3cx4oz2Q1kaHrOug4jq5MQV3rX5iJhS9lI6D3j+p3+hI7Ne?=
 =?iso-8859-2?Q?48o6hkE/ubkvc+kMCsRvut+JB4pZhMKLDW21Mao6WB3PiVauEAP4XDC5BG?=
 =?iso-8859-2?Q?UHr9Lsi+rqCejqT2faatMXQ1ZjB4QQi0HLe+QrcZtP7aJW1CtUJtr+3s6l?=
 =?iso-8859-2?Q?bZ7fekVhJ671eF5SmOmRVfUOPZhdm0/zZxltVBDkUlnWc25u+AGLok80N/?=
 =?iso-8859-2?Q?2KwZflYJYUAN1BV+DhJWaukhjbhcJvIMZcirkJQcm3LnzF46HWgvPlYtGL?=
 =?iso-8859-2?Q?Pm2YbU+s7JrKZDVgQrhBPEuohJk/hT6GaiTkyVQeK+yYGHBBR1IUfVs3NM?=
 =?iso-8859-2?Q?HhmkweEWbTCbOPNuYD2rozKxYkRxoOHhxi/P0q9D0+IigdNUWhR36p8pUP?=
 =?iso-8859-2?Q?bp+F3lF9UM14w4wnzAzuEVvI0muNI7EPoxDgLe8vlOguvZUvFWryFAA5cb?=
 =?iso-8859-2?Q?w3rALTlfy3Xr64Kl3HG+iPgO0ObypLWF3821YMKzuSliI0cylMZd8rn6Ps?=
 =?iso-8859-2?Q?IiRV/fV3s+tm5wlitOZ9EBRkY5dqrTNowfSt/pUhJEsfB6kydNaj9az80y?=
 =?iso-8859-2?Q?9soYMXjlEQldtbOTT4ypA5nEv5f8B1HbiONOypy2jkAg48M66VDGHoidDU?=
 =?iso-8859-2?Q?QhBNgfQh4a3XtswvSNaYBqqE/krowQuunRvVO6zB76ReEckCPB2wBsoMJ2?=
 =?iso-8859-2?Q?sj0vLYT1AgafSirKdKeWiGda7KjXEqT/JZeuHZS2RC6/0zLD6kJR9mdeWj?=
 =?iso-8859-2?Q?RuV9Tf+9rLe/Rl1STpBFMzbriBANltOminlq3sO1GVuwsW0aQTTw0+7hsH?=
 =?iso-8859-2?Q?oLDzNvdlmIfeBmiLAwtzpIQTwI6XcoAMyhQN3uTM0Nz7yHdrA/clmQfkGD?=
 =?iso-8859-2?Q?iI/e+SC8xPGMbRSscQXZh9jyw0dYrESRfW?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <BEF177AF57CDD6418F061703220B9167@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd710d9e-d01f-424d-adbf-08dd7cd40c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:47:13.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQwFLXF/KRZMLJ869j72VwxnX9sPnVzaf9y3kx6Oy+YS94noIA53e1cgPgvjeN9vJ3DkQ83y9oNt/9uTWKLb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4404

From: Piotr Kubik <piotr.kubik@adtran.com>

Add a driver for the Skyworks Si3474 I2C Power Sourcing Equipment
controller.

Based on the TPS23881 driver code.

Driver supports basic features of Si3474 IC:
- get port status,
- get port power,
- get port voltage,
- enable/disable port power.

Only 4p configurations are supported at this moment.

Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
---
 drivers/net/pse-pd/Kconfig  |  10 +
 drivers/net/pse-pd/Makefile |   1 +
 drivers/net/pse-pd/si3474.c | 477 ++++++++++++++++++++++++++++++++++++
 3 files changed, 488 insertions(+)
 create mode 100644 drivers/net/pse-pd/si3474.c

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 7fab916a7f46..6d2fef6c2602 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -41,4 +41,14 @@ config PSE_TPS23881

          To compile this driver as a module, choose M here: the
          module will be called tps23881.
+
+config PSE_SI3474
+       tristate "Si3474 PSE controller"
+       depends on I2C
+       help
+         This module provides support for Si3474 regulator based Ethernet
+         Power Sourcing Equipment.
+
+         To compile this driver as a module, choose M here: the
+         module will be called si3474.
 endif
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index 9d2898b36737..b33b4d905cd5 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PSE_CONTROLLER) +=3D pse_core.o
 obj-$(CONFIG_PSE_REGULATOR) +=3D pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) +=3D pd692x0.o
 obj-$(CONFIG_PSE_TPS23881) +=3D tps23881.o
+obj-$(CONFIG_PSE_SI3474) +=3D si3474.o
\ No newline at end of file
diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
new file mode 100644
index 000000000000..a2b4b8bff393
--- /dev/null
+++ b/drivers/net/pse-pd/si3474.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Skyworks Si3474 PoE PSE Controller
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pse-pd/pse.h>
+
+#define SI3474_MAX_CHANS 8
+
+#define MANUFACTURER_ID 0x08
+#define IC_ID 0x05
+#define SI3474_DEVICE_ID (MANUFACTURER_ID << 3 | IC_ID)
+
+/* Misc registers */
+#define VENDOR_IC_ID_REG 0x1B
+#define TEMPERATURE_REG 0x2C
+#define FIRMWARE_REVISION_REG 0x41
+#define CHIP_REVISION_REG 0x43
+
+/* Main status registers */
+#define POWER_STATUS_REG 0x10
+#define PB_POWER_ENABLE_REG 0x19
+
+/* PORTn Current */
+#define PORT1_CURRENT_LSB_REG 0x30
+
+/* PORTn Current [mA], return in [nA] */
+/* 1000 * ((PORTn_CURRENT_MSB << 8) + PORTn_CURRENT_LSB) / 16384 */
+#define SI3474_NA_STEP (1000 * 1000 * 1000 / 16384)
+
+/* VPWR Voltage */
+#define VPWR_LSB_REG 0x2E
+#define VPWR_MSB_REG 0x2F
+
+/* PORTn Voltage */
+#define PORT1_VOLTAGE_LSB_REG 0x32
+
+/* VPWR Voltage [V], return in [uV] */
+/* 60 * (( VPWR_MSB << 8) + VPWR_LSB) / 16384 */
+#define SI3474_UV_STEP (1000 * 1000 * 60 / 16384)
+
+struct si3474_port_desc {
+       u8 chan[2];
+       bool is_4p;
+};
+
+struct si3474_priv {
+       struct i2c_client *client;
+       struct pse_controller_dev pcdev;
+       struct device_node *np;
+       struct si3474_port_desc port[SI3474_MAX_CHANS];
+};
+
+static struct si3474_priv *to_si3474_priv(struct pse_controller_dev *pcdev=
)
+{
+       return container_of(pcdev, struct si3474_priv, pcdev);
+}
+
+static int si3474_pi_get_admin_state(struct pse_controller_dev *pcdev,
int id,
+                                    struct pse_admin_state *admin_state)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       struct i2c_client *client =3D priv->client;
+       bool enabled =3D FALSE;
+       u8 chan0, chan1;
+       s32 ret;
+
+       ret =3D i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
+       if (ret < 0) {
+               admin_state->c33_admin_state =3D
+                   ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN;
+               return ret;
+       }
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       if (chan0 < 4 && chan1 < 4)
+               enabled =3D (ret & (BIT(chan0) | BIT(chan1))) !=3D 0;
+
+       if (enabled)
+               admin_state->c33_admin_state =3D
+                   ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+       else
+               admin_state->c33_admin_state =3D
+                   ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+
+       return 0;
+}
+
+static int si3474_pi_get_pw_status(struct pse_controller_dev *pcdev,
int id,
+                                  struct pse_pw_status *pw_status)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       struct i2c_client *client =3D priv->client;
+       bool delivering =3D FALSE;
+       u8 chan0, chan1;
+       s32 ret;
+
+       ret =3D i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
+       if (ret < 0) {
+               pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_UN=
KNOWN;
+               return ret;
+       }
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       if (chan0 < 4 && chan1 < 4)
+               delivering =3D (ret & (BIT(chan0 + 4) | BIT(chan1 + 4))) !=
=3D 0;
+
+       if (delivering)
+               pw_status->c33_pw_status =3D
+                   ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+       else
+               pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_DI=
SABLED;
+
+       return 0;
+}
+
+/* Parse pse-pis subnode into chan array of si3474_priv */
+static int si3474_get_of_channels(struct si3474_priv *priv)
+{
+       struct device_node *pse_node, *node;
+       struct pse_pi *pi;
+       us32 port_no, chan_id;
+       s8 pairset_cnt;
+       s32 ret =3D 0;
+
+       pse_node =3D of_get_child_by_name(priv->np, "pse-pis");
+       if (!pse_node) {
+               dev_warn(&priv->client->dev,
+                        "Unable to parse DT PSE port-matrix, no pse-pis no=
de\n");
+               return -EINVAL;
+       }
+
+       for_each_child_of_node(pse_node, node) {
+               if (!of_node_name_eq(node, "pse-pi"))
+                       continue;
+
+               ret =3D of_property_read_u32(node, "reg", &port_no);
+               if (ret) {
+                       dev_err(&priv->client->dev,
+                               "Failed to read pse-pi reg property\n");
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+               if (port_no >=3D SI3474_MAX_CHANS) {
+                       dev_err(&priv->client->dev, "Invalid port number %u=
\n",
+                               port_no);
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+
+               pairset_cnt =3D of_property_count_elems_of_size(node, "pair=
sets",
+                                                             sizeof(u32));
+               if (!pairset_cnt) {
+                       dev_err(&priv->client->dev,
+                               "Failed to get pairsets property\n");
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+
+               pi =3D &priv->pcdev.pi[port_no];
+               if (!pi->pairset[0].np) {
+                       dev_err(&priv->client->dev,
+                               "Missing pairset reference, port: %u\n",
+                               port_no);
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+
+               ret =3D of_property_read_u32(pi->pairset[0].np, "reg", &cha=
n_id);
+               if (ret) {
+                       dev_err(&priv->client->dev,
+                               "Failed to read channel reg property, ret:%=
d\n",
+                               ret);
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+               priv->port[port_no].chan[0] =3D chan_id;
+               priv->port[port_no].is_4p =3D FALSE;
+
+               if (pairset_cnt =3D=3D 2) {
+                       if (!pi->pairset[1].np) {
+                               dev_err(&priv->client->dev,
+                                       "Missing pairset reference, port: %=
u\n",
+                                       port_no);
+                               ret =3D -EINVAL;
+                               goto out;
+                       }
+
+                       ret =3D of_property_read_u32(pi->pairset[1].np, "re=
g",
+                                                  &chan_id);
+                       if (ret) {
+                               dev_err(&priv->client->dev,
+                                       "Failed to read channel reg propert=
y\n");
+                               ret =3D -EINVAL;
+                               goto out;
+                       }
+                       priv->port[port_no].chan[1] =3D chan_id;
+                       priv->port[port_no].is_4p =3D TRUE;
+               } else {
+                       dev_err(&priv->client->dev,
+                               "Number of pairsets incorrect - only 4p con=
figurations supported\n");
+                       ret =3D -EINVAL;
+                       goto out;
+               }
+       }
+
+out:
+       of_node_put(pse_node);
+       of_node_put(node);
+       return ret;
+}
+
+static int si3474_setup_pi_matrix(struct pse_controller_dev *pcdev)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       s32 ret;
+
+       ret =3D si3474_get_of_channels(priv);
+       if (ret < 0) {
+               dev_warn(&priv->client->dev,
+                        "Unable to parse DT PSE port-matrix\n");
+       }
+       return ret;
+}
+
+static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       struct i2c_client *client =3D priv->client;
+       u8 chan0, chan1;
+       u16 val =3D 0;
+       s32 ret;
+
+       if (id >=3D SI3474_MAX_CHANS)
+               return -ERANGE;
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       if (chan0 >=3D 4 || chan1 >=3D 4)
+               return -ERANGE;
+
+       val =3D (BIT(chan0) | BIT(chan1));
+       ret =3D i2c_smbus_write_word_data(client, PB_POWER_ENABLE_REG, val)=
;
+
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int si3474_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       struct i2c_client *client =3D priv->client;
+       u8 chan0, chan1;
+       u16 val =3D 0;
+       s32 ret;
+
+       if (id >=3D SI3474_MAX_CHANS)
+               return -ERANGE;
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       if (chan0 >=3D 4 || chan1 >=3D 4)
+               return -ERANGE;
+
+       val =3D (BIT(chan0 + 4) | BIT(chan1 + 4));
+       ret =3D i2c_smbus_write_word_data(client, PB_POWER_ENABLE_REG, val)=
;
+
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int si3474_pi_get_chan_current(struct si3474_priv *priv, u8 chan)
+{
+       struct i2c_client *client =3D priv->client;
+       s32 ret;
+       u8 reg;
+       u64 tmp_64;
+
+       /* Registers 0x30 to 0x3d */
+       reg =3D PORT1_CURRENT_LSB_REG + (chan % 4) * 4;
+
+       ret =3D i2c_smbus_read_word_data(client, reg);
+       if (ret < 0)
+               return ret;
+
+       tmp_64 =3D ret * SI3474_NA_STEP;
+
+       /* uA =3D nA / 1000 */
+       tmp_64 =3D DIV_ROUND_CLOSEST_ULL(tmp_64, 1000);
+       return (int)tmp_64;
+}
+
+static int si3474_pi_get_chan_voltage(struct si3474_priv *priv, u8 chan)
+{
+       struct i2c_client *client =3D priv->client;
+       s32 ret;
+       u8 reg;
+       us32 val;
+
+       /* Registers 0x32 to 0x3f */
+       reg =3D PORT1_VOLTAGE_LSB_REG + (chan % 4) * 4;
+
+       ret =3D i2c_smbus_read_word_data(client, reg);
+       if (ret < 0)
+               return ret;
+
+       val =3D ret * SI3474_UV_STEP;
+
+       return (int)val;
+}
+
+static int si3474_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       struct i2c_client *client =3D priv->client;
+
+       u8 chan0, chan1;
+       s32 ret;
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       /* Check which channels are enabled*/
+       ret =3D i2c_smbus_read_byte_data(client, POWER_STATUS_REG);
+       if (ret < 0)
+               return ret;
+
+       /* Take voltage from the first enabled channel */
+       if (ret & BIT(chan0))
+               ret =3D si3474_pi_get_chan_voltage(priv, chan0);
+       else if (ret & BIT(chan1))
+               ret =3D si3474_pi_get_chan_voltage(priv, chan1);
+       else
+               /* 'should' be no voltage in this case */
+               return 0;
+
+       return ret;
+}
+
+static int si3474_pi_get_actual_pw(struct pse_controller_dev *pcdev,
int id)
+{
+       struct si3474_priv *priv =3D to_si3474_priv(pcdev);
+       s32 ret;
+       us32 uV, uA;
+       u64 tmp_64;
+       u8 chan0, chan1;
+
+       ret =3D si3474_pi_get_voltage(&priv->pcdev, id);
+       if (ret < 0)
+               return ret;
+       uV =3D ret;
+
+       chan0 =3D priv->port[id].chan[0];
+       chan1 =3D priv->port[id].chan[1];
+
+       ret =3D si3474_pi_get_chan_current(priv, chan0);
+       if (ret < 0)
+               return ret;
+       uA =3D ret;
+
+       ret =3D si3474_pi_get_chan_current(priv, chan1);
+       if (ret < 0)
+               return ret;
+       uA +=3D ret;
+
+       tmp_64 =3D uV;
+       tmp_64 *=3D uA;
+       /* mW =3D uV * uA / 1000000000 */
+       return DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+}
+
+static const struct pse_controller_ops si3474_ops =3D {
+       .setup_pi_matrix =3D si3474_setup_pi_matrix,
+       .pi_enable =3D si3474_pi_enable,
+       .pi_disable =3D si3474_pi_disable,
+       .pi_get_actual_pw =3D si3474_pi_get_actual_pw,
+       .pi_get_voltage =3D si3474_pi_get_voltage,
+       .pi_get_admin_state =3D si3474_pi_get_admin_state,
+       .pi_get_pw_status =3D si3474_pi_get_pw_status,
+};
+
+static int si3474_i2c_probe(struct i2c_client *client)
+{
+       struct device *dev =3D &client->dev;
+       struct si3474_priv *priv;
+       s32 ret;
+       u8 fw_version;
+
+       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+               dev_err(dev, "i2c check functionality failed\n");
+               return -ENXIO;
+       }
+
+       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+       if (!priv)
+               return -ENOMEM;
+
+       ret =3D i2c_smbus_read_byte_data(client, VENDOR_IC_ID_REG);
+       if (ret < 0)
+               return ret;
+
+       if (ret !=3D SI3474_DEVICE_ID) {
+               dev_err(dev, "Wrong device ID: 0x%x\n", ret);
+               return -ENXIO;
+       }
+
+       ret =3D i2c_smbus_read_byte_data(client, FIRMWARE_REVISION_REG);
+       if (ret < 0)
+               return ret;
+       fw_version =3D ret;
+
+       ret =3D i2c_smbus_read_byte_data(client, CHIP_REVISION_REG);
+       if (ret < 0)
+               return ret;
+
+       dev_info(&client->dev, "Chip revision: 0x%x, firmware version: 0x%x=
\n",
+                ret, fw_version);
+
+       priv->client =3D client;
+       i2c_set_clientdata(client, priv);
+       priv->np =3D dev->of_node;
+
+       priv->pcdev.owner =3D THIS_MODULE;
+       priv->pcdev.ops =3D &si3474_ops;
+       priv->pcdev.dev =3D dev;
+       priv->pcdev.types =3D ETHTOOL_PSE_C33;
+       priv->pcdev.nr_lines =3D SI3474_MAX_CHANS;
+       ret =3D devm_pse_controller_register(dev, &priv->pcdev);
+       if (ret) {
+               return dev_err_probe(dev, ret,
+                                    "Failed to register PSE controller\n")=
;
+       }
+
+       return ret;
+}
+
+static const struct i2c_device_id si3474_id[] =3D {{"si3474"}, {}};
+MODULE_DEVICE_TABLE(i2c, si3474_id);
+
+static const struct of_device_id si3474_of_match[] =3D {
+       {
+               .compatible =3D "skyworks,si3474",
+       },
+       {},
+};
+MODULE_DEVICE_TABLE(of, si3474_of_match);
+
+static struct i2c_driver si3474_driver =3D {
+       .probe =3D si3474_i2c_probe,
+       .id_table =3D si3474_id,
+       .driver =3D {
+               .name =3D "si3474",
+               .of_match_table =3D si3474_of_match,
+       },
+};
+module_i2c_driver(si3474_driver);
+
+MODULE_AUTHOR("Piotr Kubik <piotr.kubik@adtran.com>");
+MODULE_DESCRIPTION("Skyworks Si3474 PoE PSE Controller driver");
+MODULE_LICENSE("GPL");
--
2.43.0


General Business

