Return-Path: <netdev+bounces-183241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69FA8B718
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BD74438B8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4F23315C;
	Wed, 16 Apr 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="LQUy6++S"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020139.outbound.protection.outlook.com [52.101.169.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACD22FE15;
	Wed, 16 Apr 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800440; cv=fail; b=IdPYoQJVjPQ9jYMo+zBIEsyKFlXyvtB99IkSNZN0xpnLafoxBpuF7PrJh0Z/7p4PyiEA8qrD/nacvO3XjVCnfgt6XLRiHiAYn+u6kEMuD+PZWDxAwZVghPX7aqPgPItd/FZBsP6gf/xUuaa/VkZYub9RPb/LbRCgCUzJhKYdYdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800440; c=relaxed/simple;
	bh=GrtF80bq3m3Zq/JzZQjudXkzGrhcd3ptjjiKr9OQv1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7dBkNGeamR6hXfgQHRV6G7wtIpiLXQTg3/5f1zKOMiEsGhGpYtJrXIx+oK8ndOa2xWsEm5HRC0H7djFWC5RQL87xRkRYzAJDd35jjae3xMohHtAu0e/o1iC9UrlX2hyI42ooeDkFpVRYECPU5fna5+6puhNURw35uh5PeLl6a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=LQUy6++S; arc=fail smtp.client-ip=52.101.169.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bII6/SkR0FDfmIlHofG5XHq3VlqaYrKOmWz6EMykHq5oRH7MOgcyCKVRC91HAZtNfpuNxMamnMYMRJBDIUwV3EqzWkvtAwTjQ1DKNTMyEdWrL2sst9JSy8ikAEKObq5RF/GaBLYQ2f1mtcQGucn1HW1gB5sKnZWtUMla17jXzGAmHNyyFkz8l+vCtdV9t4qiZVjbqFKWNtAm01heCWSt2JEDoquG3OO5pWxap0K934lsFNt5LXO8BBDVpTWpyb1igXnRocFpT83eUNrDnSLYeJzcMh3NM+lb7VkhOELQJIlbyzLUbxogmHb6lHGDRyvgrkiYxc71urmRSP9oZyFKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEd3sViFfdLJR8WbSTFQbMJwG3uySea8rKsAR1hfqSA=;
 b=Ztez/6guX9XiZOQaEjJZ0KatjcRlDor+A9v5/BMeY/vHos82kBdaGcZFm/zSBmrI04IYFz1SbYEYkEdvX1Ef81zwP4yocz4KEAiVdd4UMLt2fPQ3VkGFth9VTbJG1Ps4M3pmYrWFoP1aR6fsZc5ODwDM3AtIKS+4zD8XO0uupZUHnwd0FrRDazVawg7FfF/LA1aqjvDKa3YKbXYmHaj6rtcgeyokmh2m+BDurr4XTrpu//DSVw5VN7TAg+RHyyrBqcbWI2O7Ct1YCzoxK8M8zEqnJAxVU8Rg19LrJ5fQ2zzMLl2HKE762WsgF9V+Mk6m4TNARtMH4pQ78k8ZUo/DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEd3sViFfdLJR8WbSTFQbMJwG3uySea8rKsAR1hfqSA=;
 b=LQUy6++S2qHCgQhXc2kPOkfNI0+KbIbFFTCfGFGyN0tWIkESnfvQCrIBdA2RFA8VloEDHThzowpvSa9w0vYJP+X+Df2GFIXli8A5lLCgwSRuPcy5gm3JPTyHxOfPP+YTCsKmztQA0e3FIQ1zAszhE7ibnP14IkNmXVB7BRu1vcg=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR4P281MB4404.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:122::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Wed, 16 Apr 2025 10:47:16 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 10:47:15 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: net: pse-pd: Add bindings for Si3474 PSE
 controller
Thread-Topic: [PATCH 2/2] dt-bindings: net: pse-pd: Add bindings for Si3474
 PSE controller
Thread-Index: AQHbrrzr/zSZ0hIkl0iiZf25x3PlBw==
Date: Wed, 16 Apr 2025 10:47:15 +0000
Message-ID: <4ddf2ede-3f40-438d-bae4-6f8b1c25e5eb@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
In-Reply-To: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Enabled=True;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SiteId=423946e4-28c0-4deb-904c-a4a4b174fb3f;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SetDate=2025-04-16T10:47:15.688Z;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Name=General
 Business;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_ContentBits=0;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR4P281MB4404:EE_
x-ms-office365-filtering-correlation-id: 8b3bd6df-c845-453a-1e2f-08dd7cd40d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?q5rNJGT0w/aHZHLr7I8YTr8xp9GPeVv6iP4LCT7BFB0H7/nSmaVAcMMVcE?=
 =?iso-8859-2?Q?HUcIi4y5ufxwMtVMLV86u+SV0U18KjPaFpAAcCRkfw9lQZFn7KLULDketn?=
 =?iso-8859-2?Q?1h1DZfcUChNiquHEGtVG3+P7M24ZAngb+wqpNC7c+VDltAT49Ls7CPQng1?=
 =?iso-8859-2?Q?X1YhrnAHnjN45TSWmMQGC/dFZ027G5b1Xyufh4y80n6PKkolCqSJq7x05t?=
 =?iso-8859-2?Q?a5jKlyIq2686Tr5BmUVbx0qCFq/o2IDKt8aSu0BSzRRKduf9L9kqIaAuSC?=
 =?iso-8859-2?Q?iOenN+teHhjO3SmiAB67XIiBB6vRx2DQysP2H94PREFXu09PMItBFcxt/S?=
 =?iso-8859-2?Q?3onFli0XPo8V6/vypjb7vGVho5wS/OEs1/4T27ixHom2Ky/8QcKrt62URp?=
 =?iso-8859-2?Q?H4Xx0wu/Pxib27CdMM9JFtHvURj7X5wffylGNglPoajm9V1ua1yFSS2DKT?=
 =?iso-8859-2?Q?/lfcMgy59E38UelfUJPe3F9s0MF8Z9jC6zPWQ0421FrmFXqAS9tTESy0cR?=
 =?iso-8859-2?Q?h1OKkGybTPUwyD6jnq3OhR0QW7StpD+1YF7kIk2YZledKKCuHqMjoeYUb5?=
 =?iso-8859-2?Q?x6W+z8aAgcryWFMO5Pl1w1MwKD4ChcvgXw9RpK2PC/GNymPKkmkckNPtm9?=
 =?iso-8859-2?Q?RHQEfJoutov80Zb23+n7jqOmpCqXzg3/7yMC6Ubl7IShmjgjyUV3TQAZY7?=
 =?iso-8859-2?Q?kVXj5/Jn63/iEndsO8iGqTJGPamag9ByG+8dJE+q/kn8BAQCMwr/lCdAB+?=
 =?iso-8859-2?Q?eiI7LGMApzEUqzaj6tzJUS04vOvGGkTTIorYkAptkI3WxmyLzVNPzfGhyK?=
 =?iso-8859-2?Q?P1u0fphzIdWehff/X1a98gwkcoW4ivK1crblIaGc2KWfLeCg1ehDvpZrs6?=
 =?iso-8859-2?Q?gHxttEkwxgfsE2Zs8k2pzggxIGURFBMMDMybcDUPIj/Io9cc+4tGkZw+WB?=
 =?iso-8859-2?Q?GY7UoLyigO4GWkXxw1BX3sV6gdHcB9elbktL3r/Q7xuLzv7bx37YWJiDvp?=
 =?iso-8859-2?Q?qM47AVUie2wvSnViBvsWK8Hg7HCu+nf+lg4cyfcjCKz5eN9ZLfhZZHUEuy?=
 =?iso-8859-2?Q?NXIYFSyr5WDt/TBaknUyEtHHC73wJyifiVf2IN15SMPtFHxO9HIh+KjL+l?=
 =?iso-8859-2?Q?gzCHPi8+E5gY2JauZqKFESvfO9m8XKi8Lj6Gqk6xHDuWPxBlpE9ON6unEY?=
 =?iso-8859-2?Q?o/ew7bF47/ZQC6o5/rvi/xQc7J89Ip2GCWJPCHl9LoOVT9NC+dFGO8b+A3?=
 =?iso-8859-2?Q?yAoLjZasHkv+3ZJsAOCC2dfFgVDUhcMNieGeO8mTKayRL+SKPxy666RhPc?=
 =?iso-8859-2?Q?99nhOghO8r5PKzyXl7Vt0qUmZJNz46alL9aVSbVb79HI90AgkfscAlCvG2?=
 =?iso-8859-2?Q?qu8g7hsaC+Gus5easmuYTlnvtEbr92irvx86KIpjajwykifUCtJFn0bwSz?=
 =?iso-8859-2?Q?xiY/prHURZxmtPSWQjrnw6uK7z7T4ntUsvxx/TtLIQF8Ry5d6clR42O69r?=
 =?iso-8859-2?Q?4WkE4rckqYWM3mKzf6yEvF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?vIlOik+G+uDFayIrk9nj5FZk62rvZRLgkY2TwPQBhXPV/eldV+aRODct4r?=
 =?iso-8859-2?Q?gYRO6K2ZCsbtFdVnuwFIcUOZHF54Sid3m4dmwPtUrAybl28HwOw3HC4re2?=
 =?iso-8859-2?Q?MT5RF1ACEAXFXz9gDQx5SR7RIsgs1xgNWDJQa28TRVJ+8casLpfzh5Q+cv?=
 =?iso-8859-2?Q?SOpRUarZ9Kxhbu12iThtz5ElIecti4DTnbSxCqsZZF01HMROc3LqS3dk98?=
 =?iso-8859-2?Q?MauntdkJkTKu2erCfpqBJ5gu3mNQ5M75Suh8fWoCSSDvWwu9VlOaJyyEth?=
 =?iso-8859-2?Q?7wAgNU/PGWW6PAFZTobaKgFEgxLGGBZxTGxUhlfOXBBSrKeC1DpAEhlNeG?=
 =?iso-8859-2?Q?VR0tpAYKCuaCmnWz9l8zQaYAhs8halbzJ9y5GJB4DPAAcO60jAQV0L8gLh?=
 =?iso-8859-2?Q?BU3JjbunnyhpLYfhIBhqrQqP9hCH8Kw47Fd5TxiIAi5VXsTgiViPqNo9Kg?=
 =?iso-8859-2?Q?eg3Ua0k4Hf+WNxy0lwfooMCO13ONeC0DC4EgusqhM/4pHcaYo/RQWPg07u?=
 =?iso-8859-2?Q?Q8w/lxt5uozf7bIzOVQscdTjFmFFzwjeptsxCfeytQwmjSzwug1XkAbnJh?=
 =?iso-8859-2?Q?6upwmLUeMKeA2wvZ4eWLTz1cSkj4qyp5QH8bIEohYestfbk7FiaVVgAt8E?=
 =?iso-8859-2?Q?y0qqY8zutiBfBczYluDnJQqUKk/yIXdXISvAGbOKGxiffdjqEZujCH6IWc?=
 =?iso-8859-2?Q?pYvULECqO2b6veHHDz9qruzYUr8bAHHPRV3NDGN2R7stwAbMvNU8RPQo7q?=
 =?iso-8859-2?Q?6mmcSmUnwL16u2qh0e70bLaj1eTFXBa2+mi7tgNw2YFzqQXZokOfL/riRp?=
 =?iso-8859-2?Q?XI0pVPDBVxLvvRy93hzLfhRPZrUfJkSbs8vHD5DH/YWQZPOlriOuDMZFRE?=
 =?iso-8859-2?Q?vmj4qoWpTvnkIHWRNRCE/t12v+yfpNdCMl4Sx3aMIDHbFy8X6iGeyrWVFV?=
 =?iso-8859-2?Q?BaKIvCOgce8JFsKpXiVLXLo8ISGqjQMkV3uWF2xkwHP4Akazhqnj7bKtoi?=
 =?iso-8859-2?Q?NF7nh/pBODfwtCGsy1yYFqBwk8wVfygewQuMbVyVcV6RUHtLZKisoz4Xhj?=
 =?iso-8859-2?Q?RGZQx6R1YjNEPyQ5CF19tyu1DU3RsgRKWkv4tTAlyhrhcynj3IOJML55BS?=
 =?iso-8859-2?Q?zhHGJWa2L/+OtBm8DfZPNnwaL6OUICLpWvmdIjciEVqujInwFOu6o39Yxl?=
 =?iso-8859-2?Q?+YnakLrxqtkJ8U4Z3UkiD3qVz4ColRd6i6pleEQNTiwV0Gvt00oxK+WhlB?=
 =?iso-8859-2?Q?NVDuvudu0koIRgkEfcryom0H1LMBW05pj4W+2KdmF8wcgdMV8Nlz77F8hG?=
 =?iso-8859-2?Q?17ZL0nfQSzpYf6xxu2Puy6EQLqJF/VVRym42jEz2J5tzeLxHsl+oZ3NoFS?=
 =?iso-8859-2?Q?/nb/YZh/g+rAlepKP8jHBqY5/1n6zwFzYRy2zpUkOA7w+gQNXevnZm7WcJ?=
 =?iso-8859-2?Q?5iAMPYPZWOQLtJx8y14xFY3+aNgwtYMyLP9TMuUZyK1/b1iEBzu25cfMX/?=
 =?iso-8859-2?Q?OE+XtUB9T1D8sdzfge/9CCHl4FLfvaX8m48ZAGflxLvM/AIiovePZjplYG?=
 =?iso-8859-2?Q?IeRRk1a3GvrIyHWNAOMgaBVw4ZFs2IqlyFJwPM1MxjZuHh7v7vDtM/fuHR?=
 =?iso-8859-2?Q?+AhzAYr4tshDTC1kNWj5Pja4+QU4JKj4Zs?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <6A7B81DDB93EF1489F6218186BCC3F07@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3bd6df-c845-453a-1e2f-08dd7cd40d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:47:15.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2t4DxDtoMNAE6C2KtIFayh24WVJiJ53jH6Eijp7VugJxEkVPjpeCCedVDdJCLO/HMFxdgl+gXoU/sE+K1kZ3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4404

From: Piotr Kubik <piotr.kubik@adtran.com>

Add the Si3474 I2C Power Sourcing Equipment controller device tree
bindings documentation.

Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
---
 .../bindings/net/pse-pd/skyworks,si3474.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml

diff --git
a/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
b/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
new file mode 100644
index 000000000000..fd48eeb2f79b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/skyworks,si3474.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Skyworks Si3474 Power Sourcing Equipment controller
+
+maintainers:
+  - Kory Maincent <kory.maincent@bootlin.com>
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - skyworks,si347
+
+  reg:
+    maxItems: 1
+
+  '#pse-cells':
+    const: 1
+
+  channels:
+    description: Each Si3474 is divided into two quad PoE controllers
+      accessible on different i2c addresses. Each set of quad ports can be
+      assigned to two physical channels (currently 4p support only).
+      This parameter describes the configuration of the ports conversion
+      matrix that establishes relationship between the logical ports and
+      the physical channels.
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      '^channel@[0-3]$':
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      ethernet-pse@26 {
+        compatible =3D "skyworks,si3474";
+        reg =3D <0x26>;
+
+        channels {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          phys0_0: channel@0 {
+            reg =3D <0>;
+          };
+          phys0_1: channel@1 {
+            reg =3D <1>;
+          };
+          phys0_2: channel@2 {
+            reg =3D <2>;
+          };
+          phys0_3: channel@3 {
+            reg =3D <3>;
+          };
+        };
+        pse-pis {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          pse_pi2: pse-pi@2 {
+            reg =3D <2>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a", "alternative-b";
+            pairsets =3D <&phys0_0>, <&phys0_1>;
+            polarity-supported =3D "MDI-X", "S";
+            vpwr-supply =3D <&reg_pse>;
+          };
+          pse_pi3: pse-pi@3 {
+            reg =3D <3>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a", "alternative-b";
+            pairsets =3D <&phys0_2>, <&phys0_3>;
+            polarity-supported =3D "MDI-X", "S";
+            vpwr-supply =3D <&reg_pse>;
+          };
+        };
+      };
+
+      ethernet-pse@27 {
+        compatible =3D "skyworks,si3474";
+        reg =3D <0x27>;
+
+        channels {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          phys0_4: channel@0 {
+            reg =3D <0>;
+          };
+          phys0_5: channel@1 {
+            reg =3D <1>;
+          };
+          phys0_6: channel@2 {
+            reg =3D <2>;
+          };
+          phys0_7: channel@3 {
+            reg =3D <3>;
+          };
+        };
+        pse-pis {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          pse_pi0: pse-pi@0 {
+            reg =3D <0>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a", "alternative-b";
+            pairsets =3D <&phys0_4>, <&phys0_5>;
+            polarity-supported =3D "MDI-X", "S";
+            vpwr-supply =3D <&reg_pse>;
+          };
+          pse_pi1: pse-pi@1 {
+            reg =3D <1>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a", "alternative-b";
+            pairsets =3D <&phys0_6>, <&phys0_7>;
+            polarity-supported =3D "MDI-X", "S";
+            vpwr-supply =3D <&reg_pse>;
+          };
+        };
+      };
+    };
--
2.43.0


General Business

