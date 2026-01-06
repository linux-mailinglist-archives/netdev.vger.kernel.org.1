Return-Path: <netdev+bounces-247368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9ECF8D52
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00B1305A2E2
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA5313E21;
	Tue,  6 Jan 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XlOnugwF"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1D313E08;
	Tue,  6 Jan 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710204; cv=fail; b=FmW4pqamgF+dOscMUMCus21KTKkluC++cGXiNYl7eJ82NZf7K2G6+W0McYfeD0vaceoHYFcW1yqjIE7XL++D+c4nbS728n69OJuD7ZpjRnsVOyTHjfBrX+53G6nRfGFlMjPiPA2k9d/YGnLm2LF3Bfqw6zUeSFs0SgwxaOAgMIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710204; c=relaxed/simple;
	bh=Gjd4tROvsw+SddgnQBWb/KZZqKLTt/GL2wKA+iOF5Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K6IlUw3nCispHFJoCZ0RUC7pYDVuY61N9ZibRe14OKzAcWI05t8jeEqs7I1TcJsDprf0EbKfP8InXnnF6vPllhPg2uSeApBG5xWMZlvFYNH2MQ7eAL5XNs3wf6NicoAgGFj7XalXoq49vUr7q4aHnQN1UC8NdAVRqZ2iisl/sA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XlOnugwF; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOmP++iV73QO3meMDMiWvKutEfO1hywwshRnGo/OwLqRhF5g4qMEpwcNkl6ukyual6zd0z/gj2ka3cfbZu2SraQIz/a2vP8uYhu+syAZ6Su4ocknTfOnDmdpH0I751XMvP5L1rGTjwlsDgffemvoDpx/mZAihF5R7CBc5WkckDtpe3n4uX11fYQ31MuyCFRp6d78YsAR0H5n057bpE1myt8yYBf5DFbp2ZfzOl5GvJFaSowy1KQUO6//goSixDojedn43O93kOwd8Y0hOsPeqjx3i/9+HB32m2tHTiArlxUkuGTXdgAn2c1QC3ox8EWCTLJ2YGvKKEf0K0UZfVnEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d5hI5SS9v7fM5vkEGb44Ol60vxN3g0VSoZ9hgNNFOk=;
 b=A30TJEQRLR+Z88UUj7n5lOeM226Spw5OOgdSCefeTcj06OxHEdS/ya8+U4x3zdW+vnrO1XRdzhcYbd5KBMApAs+GjRMBE3UBX9212S+ubfwHgMe89d6Jh8rx6UWdnzBidxjqqOOboFTj40UwZtkxrOKOKWxTAo3mlJpVei/enja7TNdtQ4/Ya35OSfgaca49wzECex2m+toqgupshCQwxtzxkrL2qu32G4lknE1Tm/x8r8/DrrrjHv+n8a0Qzjt1SCLBXr+yvmghG7dE/1nB6eUFeKRKVcAIbSsgM5i67Vcp+3EFIGl3RRK9eVxGsW7puJOfsHge6mO+2W/xuVTH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d5hI5SS9v7fM5vkEGb44Ol60vxN3g0VSoZ9hgNNFOk=;
 b=XlOnugwFkVIHT51dFjbKRmA+Cup5XibNVFT7UfaPQvyN8uU1CbVBdPpTT367ssjzt1t8hY+6fDtwS8iR+gj49J+CisPXFWdu+ZGF7LAN9xgsqCIUCaYrCxl3bxDEVOr9LgUVzjzNpbxmEsptsfwbPusO+yxC7CkXQ8oSeR1nH/tDLz4W4kjDWHaJ5F4OEs1vl3twtXRWXypPnpDsFZfZNrPKcq+sGLW9qx6OKJVJRoiEQXiAagOBpz2HGH/V3JdaK7dss/681eA5UhohIPIlalxPzHciSznVslo+deXpE3kvhf0a6LO7niaEOlFM0RO6pTw70prv9vciIWBcOHlblw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV4PR04MB11732.eurprd04.prod.outlook.com (2603:10a6:150:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 14:36:38 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:36:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER),
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org (open list:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: m.felsch@pengutronix.de,
	imx@lists.linux.dev,
	shawnguo@kernel.org
Subject: [PATCH 1/1] dt-bindings: net: dsa: microchip: Make pinctrl 'reset' optional
Date: Tue,  6 Jan 2026 09:36:19 -0500
Message-Id: <20260106143620.126212-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV4PR04MB11732:EE_
X-MS-Office365-Filtering-Correlation-Id: e503d3be-de0f-4645-e4f7-08de4d30ffb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t10APBw9rJse6s94IGmnqjujoGZ2Nlhtf1DX3Vx2XE1mmUcGyacSOVtVEHsL?=
 =?us-ascii?Q?WZTWEPPYtsUU4RJPDpfMFT+Q8hfTdu38ybVUuOxUGo4uvljpl4s2eSd54z+G?=
 =?us-ascii?Q?rnqKnXckRqbJrY6+k94XQKoxsFM6e/zKf5LPek/sMgt2Zw52XfsXas8G5dPD?=
 =?us-ascii?Q?ju3D7OMR6Yp2Nqw76X24wy4KgldCCeHbX64OJyM3HS4EHf7mYxhoRfmG0qat?=
 =?us-ascii?Q?9qVLHrflbfjLRt0e9wAKOKSCreGLcZapUBGl8IHXu2QHf0ZsiUQrIV4wtl/7?=
 =?us-ascii?Q?kQIwsyrfOtBzy7ZdQlryikLKuHYBlTbL6vtESSSH8zP1msvzdricLX/SUUUJ?=
 =?us-ascii?Q?DB7CWZxqxmz395nD8vNk7T62s8eVF0lAaiv//hdugr4N33pPY4P4KZl0OxZU?=
 =?us-ascii?Q?j/5lOr4rrY4u+Lcnog9VJpeoHPp/QqwthGdjcw1cAUDGulCWzesYIcDzKXfJ?=
 =?us-ascii?Q?PlTuBumlUktsUkFS80gyeSofQcgaVKYjAZIxNRuK5KgCcGsrP8NdyGqkz0Kz?=
 =?us-ascii?Q?qMdaxVeLoEPeQV3GISocqCALNJo8EqzKMPM7NaBdBdInGcM9AQeiGbwKk5fE?=
 =?us-ascii?Q?SMjDehshq3hGnC3a3ijtEO6DWSU+cqh2+lS6VppLxNkYCtInQMBNjkdAEq6i?=
 =?us-ascii?Q?GJ8Wfmca3Yj/Q29bZEiPORxRffjbA4LwcWGo5nZax4dS10fgjtVIqAVrP21N?=
 =?us-ascii?Q?rgZbdmn95Pi0FfeRsi84gKLsDYxmH8KCVCnGP5UMUSMCBlTiO9NYOBS1h6zC?=
 =?us-ascii?Q?+SI5Gm+N2x9KVY3DtjUFvA90e2Hq1ggzHZT6wrw2zKKz9onoagSSNfkK2kP+?=
 =?us-ascii?Q?85QPB0pypI1kt7H3KReRtQ3LxMfB0TNrsF35+8eZPZoKbxLY453rOAlQi51Z?=
 =?us-ascii?Q?SkWsTVtfYZuZQuoLXaY7uZhVwo1fwO5UYpwcH5flYjnZTGzhmviGhEWoRnUT?=
 =?us-ascii?Q?ENngWEOq1mmvKvlMVBTHw9zKbPEbi5ht/DWBr/lJk1ov/62t4s8u4481kei1?=
 =?us-ascii?Q?9xfARmRWiNmKFjtom7poQ6mlVQ/NZqYnBB3bStXhIBZA4XYewLC2N17zICHf?=
 =?us-ascii?Q?iz1AKaVTkvsARcTcjXejRQJKOlAluHuiGboZumwOkGf1avvZjTj3vcQjSZTv?=
 =?us-ascii?Q?W/vAqSkJG+NBkLksDA3yRC52dPRxzzz1k7y04+TJBts9vehgM7mJWxvdxIqW?=
 =?us-ascii?Q?ugQ9oZjyJwg1u/TkdcvxuA3Kg6h/aKq9rubjCKoNPA6+QuouqXkSvrJ3spPH?=
 =?us-ascii?Q?5zKREPdg5eAC1iB2qhCFmn0HBakiKqVjSVw0fOQYGqRASASqwrBtp1F8qzVI?=
 =?us-ascii?Q?LOWzDBNJ/EFSyZQGqrzlRYZZuHxsJ1+CkEW6gxL08bB4M6nKPG8sIO5AFhud?=
 =?us-ascii?Q?buK6c10nk+KxRZX+AO+iYgAQUCv5c62vZJHm0ncEzHY0olOv4vRXVFR5SMAn?=
 =?us-ascii?Q?GWQO1sLcaxB2QW2pNBko/N8mlMaRmKLzCQYVh6rLFpIgPS0te218ZIXbDZdO?=
 =?us-ascii?Q?pCniE5nBqMB+2xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhO0Sy0zj4DUFy6Tbg9cpf9vOG37b1eLm5orTO3gVDVA0ehvOp3LnBuR5R1y?=
 =?us-ascii?Q?xP0o9qRdhh13kNjHe8PJMlCZwhVD4bPcGjPQ5kY7hxfnuSyPNIiCl718BU1X?=
 =?us-ascii?Q?301AaM4UYBpu9iqejy6HbhK4XfkWYnQORM8BfxAPTKdJCKaHwEoOeFMQiCBL?=
 =?us-ascii?Q?ysuBNKbupyZcs06gV+zsXzogVjb1Vk0WSzNDGfYA7mED/jWcYLe7DpF1qrh2?=
 =?us-ascii?Q?JP1ef7Fyh8daPwFcdjjc3RoREKlRj0T1L83kZPdSPC0TM9z2xwWVUF3Y5qYL?=
 =?us-ascii?Q?wO/w9fkYQdmNj1VYVIgcwnQZFV4SovUHukDobNZFCPv2nhquMPZ1XrVqjutH?=
 =?us-ascii?Q?Z8jfnOSQsJB1+psy64joIfFZoEU+T1w32v0SO+oU9MN+ObjkyZph6vrj8d0D?=
 =?us-ascii?Q?SSbADEDeuYauwAkGnGCHZsw7AnDmnwkwLSEvK6B3AEjeKTw13ZkX1YkeFdVi?=
 =?us-ascii?Q?AIQnyX2qHWy4T4sB0llLn5zdLlwc0vjaHpjCVO89XIYy3JgGz3wRXc619IdW?=
 =?us-ascii?Q?fXaBrm4ded9Mwypfa7BJwWoxgJwX6N7zY4t7eOvA5Bh0vaTZ47ukkNWJH3Pj?=
 =?us-ascii?Q?3iwnJZbBp8Pcqfyi8hJy12wYSAUKuPTp1CxLfrk7Rz+eR2oiOWXVG736x/Hg?=
 =?us-ascii?Q?jwK8OGCKVqeMrIk1/HRzlsiyXwzO9/R3Hrlli69yT4YthMj6xpZmqINNqYTs?=
 =?us-ascii?Q?DCgtWOT4fi3lBWGL4sOb3PWr0GIchdkH48pTuBy2+miDwD7JrQaJC1cuDQN2?=
 =?us-ascii?Q?dql0/a4qIIj8JlNkJpe4DrEiuWweUDKA1ufWwuxk1KSgOyqM2giF56+5Fek6?=
 =?us-ascii?Q?06gcEzx/Zcj0pLtB1CHRS60q6TczBLA8FTVblWPBufLKbd/36nyYcmPGJ3u4?=
 =?us-ascii?Q?GBXwBrCQOtMlustv/sbxkf13hexsUO5iv70eQDmnP8Agfi/QOgBgNZ+4R4R2?=
 =?us-ascii?Q?yBd690zKS1vxaRJXgdoAf+Es312MtwwU8ezA+beh9DojFgSa65MhJ2qbIT4Z?=
 =?us-ascii?Q?VZ8sumOzIDd5QAv1UBs8AVnGfschv+6AA87xV2fA3/fXFVgHweGDZfyASuRN?=
 =?us-ascii?Q?SSyXxfy373ERHBWJhqbUoNwZBQsAdJ5AOFu/Sf/PFJX10SsF43YNuZXxdmcd?=
 =?us-ascii?Q?Qz2TkFxbjlOGfecFozEStbuOlcVHBI+dp9E43a9KWRHNrurLi4WQjGHuU9po?=
 =?us-ascii?Q?2levIKrNE6F6w9aQhEzdl1Ao53196ETjf13VKm830I29LVOQHJ8DbVsxHYju?=
 =?us-ascii?Q?JiVqB7l6EhoEDHu/I/wuWj2T4r3Gv+o8UOvQjSa9zrLj4qhI4ntYR+7XN1IS?=
 =?us-ascii?Q?2k9s80HBGkwJZxne+F8+KdsdHOLzNTK3G4a2gW9WCU7xBr/Yj/Xg5KWHgXRC?=
 =?us-ascii?Q?pgMDk6P2/XgYxZ37vBE5uMgHRkpbXZppQkfPp2dPOP0oJvoP7DvhvseJ5tZK?=
 =?us-ascii?Q?Op4s6lT6npKI8TpSVXGaRMQvz45kUgiiY75hJr491B0YdMPD2uRyLXoWzbPs?=
 =?us-ascii?Q?FoOqe6py5U4z6jxlMRb3DcGqeTWCxYjOUelKYAd8midynKsjUeBZYq+GFhDJ?=
 =?us-ascii?Q?l+NbE4t/gjAnbvwilyPcaUi6oZTWPPXlTJJDKXV0qj1gfkWhvdtm+Jzsr/Zp?=
 =?us-ascii?Q?xwwSL1Qqplh59ql2wqHtr88wW827PZmvuz3jHj3EuQeumemyHXTu994nRlTm?=
 =?us-ascii?Q?wkBVk28EI78rQlwRWnryh9HqyRgfroWUHKNZvzkSkEX40fMaM3w8e4+Naz8E?=
 =?us-ascii?Q?QOn3klGXgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e503d3be-de0f-4645-e4f7-08de4d30ffb9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:36:37.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5iD5K/qukVSsqOmvWUIx84hj+J1Vg6KezXCzHHJwC6GsR4teZjM3jz2W9E4lXaps22Iw5+VM0yeqdKaxCFxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11732

Commit e469b87e0fb0d ("dt-bindings: net: dsa: microchip: Add strap
description to set SPI mode") required both 'default' and 'reset' pinctrl
states for all compatible devices. However, this requirement should be only
applicable to KSZ8463.

Make the 'reset' pinctrl state optional for all other Microchip DSA
devices while keeping it mandatory for KSZ8463.

Fix below CHECK_DTBS warnings:
  arch/arm64/boot/dts/freescale/imx8mp-skov-basic.dtb: switch@5f (microchip,ksz9893): pinctrl-names: ['default'] is too short
	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index a8c8009414ae0..8d4a3a9a33fcc 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -40,6 +40,7 @@ properties:
       - const: reset
         description:
           Used during reset for strap configuration.
+    minItems: 1
 
   reset-gpios:
     description:
@@ -153,6 +154,8 @@ allOf:
             const: microchip,ksz8463
     then:
       properties:
+        pinctrl-names:
+          minItems: 2
         straps-rxd-gpios:
           description:
             RXD0 and RXD1 pins, used to select SPI as bus interface.
-- 
2.34.1


