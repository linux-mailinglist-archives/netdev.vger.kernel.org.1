Return-Path: <netdev+bounces-241013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E130C7D6A5
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8045035364F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1E02D9EC7;
	Sat, 22 Nov 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mGRXzo/b"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBB2D7DE7;
	Sat, 22 Nov 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840061; cv=fail; b=rMthy/uEFtRx+HZ+489Jd2N6aeoqAjcgyRniMhNdDIM7V/ppDrqswIlfGRdyk9q/ZqzXztdw2qlgGfqwEZr44Q7VDsal6iIehZyuw4f62K/5w2+JprL/Ul1KQcJ9fUdSKtTalcEdLVJhKTPfxDlBILG4DrpgpEBEkeXX7QdBBTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840061; c=relaxed/simple;
	bh=nNLvVu0Ez/nAz1vYHfJazG+1xZ3rnW9NM2zVsw0NUK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6tNRZdrSqQC1MkX9oQbPZdjYtbUqpCXLOsOpQqOcRDEJSG89r90tND0RphX+aXKtqJXfFDYHJcUYD6o/RSMxmcfXlGvQ7fRwmEawk/SNj6Ot8n30RLCVEt842nTVAleb5dbJ9gGLQ0w0q6RelHnagRrjwgTpirQjNxBf4/Ky2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mGRXzo/b; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEE2IFYlqqRLu/NMSf/uV6SdVzrzaPbdpd7H3MGNn3mZoPUUy5pWqJn23kRIeGTXE+0UsukVeYjt7uthrBLzPWj/NesN7hpkjzdn/fWpVB/RLR66H9PtpDw+Q+/S5rO2ooWIaRJl4wiu2Z+31Ppc7K15M+oLkC+4wuIsF7fvyhFnaIXZxySo3/qp5dJpd3mSCZS6GwPDKbjDhEs7kQRYxS0c94qL0EjfLQYEmo92a7SPKIPUqkd1gVRQqXF9oztUcuZC+cCxreXKF/aXGmn3jY+KRYpWOmbienjxKQL/Fplqgp87epYtt/jLhRqy2x3pYXD/VU75IjOa7VLFRMfPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny5+2gznRz7R51l1B2RsyXm0hG1ZpVCqZF99OXnTKBI=;
 b=iOdhFmBaONKRT6MOhrL+JkoJ0qhJFfCLcEsev3G8TVxub1XukSsfqgZUClFX4IDjE2tOgZZ+x5ZQss/LYJ74ARR5yrN/OPgY/8gh5coDfk0+H5eOtTnucsD6pZDG7CM+OK1CzV1WeXaNjkPP2WaY8/M5kOoHd0d/so/9YPp2PtT1JpM1qQBiohe8i88pk8XMci1x2o8IVNYbM4pBlCnrZ8Wdr8b74ufMfEp1joH9xqKSymV43pQ5oT2dX+VWImv3OL/X4p72U6i+3iQwaJHjWBY6L66jSFvtXF3T4J4Vn3PIuQ27ifX0nU+CZienC+jgr1/zlfPcKLDJzcLZGuSqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny5+2gznRz7R51l1B2RsyXm0hG1ZpVCqZF99OXnTKBI=;
 b=mGRXzo/bhi+VP5w028wsQdFx0LEp7WHCzN66cqHON/pchQIjSNmD2LF0lUAZ5EDqvzxooqBj4CHEJRCvPDNzrsgkpr4USpHLhmQ8NvrhGLyGzLzfvSOBD4EneCF50S5Z/qAADiO1j2UZkqjhY5ZND48A7U9b7GvQpN2fCX2CLisyON9UegmQMKeE0rwVuTojlMJZ/8bJ3khazFsMFQ4I9wGT9S2fOmXfgJsUkZdeosVBikAfeRTOqWAWn2MNXLFoifCYc5mylShLgkOmF8pub+Zk7EQpo5Ms6ZctCFiA4vdFakz5UcaHlPOvbtwq75GSPZO2QCrCderBcDmetPHJcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:10 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 8/9] net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
Date: Sat, 22 Nov 2025 21:33:40 +0200
Message-Id: <20251122193341.332324-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fea16d2-b839-4556-96ae-08de29fe1c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFbdB8D2bCXZ1yWNaj66XXJYpnVlFkppKHwa8Ru+GEU+J3oC9pfsgki6XVix?=
 =?us-ascii?Q?c6TjThZTkzLNxRJqxcNXz9KdgznuCXpY6X1kqBLTkUN5cs01uciXtjLazC8t?=
 =?us-ascii?Q?5gncLzxXinIZipcrvb3x2PibgYRqq99xv2zvIZ7kUPP6ENucfC14SP4FsmQv?=
 =?us-ascii?Q?i2M8TjcIDmtpktUBm+1pButbQyT6pnx9kdx17/P8NzlWXFLVSqHUM6FHkGeM?=
 =?us-ascii?Q?hDtdlVv8w2j9nS84xNjGVJcHgJTETem9gkH46ed6h6qB+IQsux54h14KfjQf?=
 =?us-ascii?Q?Y08iXzuSDU+jkS30Ei+3exfAhp81sw01CBxZSwiinvwxaUqmXhy7OVkjtBMi?=
 =?us-ascii?Q?r5qf9EGtpnqWo0UCe4zGbzQx12MMbxGznc8s2GneLOn7dmrjF5g37TITgM3p?=
 =?us-ascii?Q?c/dnjC4KngZQ+cUk2QSjhv0cFMMkREukm364EMW0kmgUsbUHaMBh430YRdmt?=
 =?us-ascii?Q?Xnyztt5XB7nf/DRJWEmIHs1fhgpVSHTUiw89WhDyTuAYv4QCE4glWqnC6KEY?=
 =?us-ascii?Q?Nb3Bc1nk90sY/oiFaSLcO9+jYYphoNjNh0LiJv86BRdav0vwPCbAfhWPL+gQ?=
 =?us-ascii?Q?dALqPm1EK7wfjXIuEqRQvXgLZtnqe+Q/yOEiXFMq40He3tt0hVxRcpMlW85s?=
 =?us-ascii?Q?1V7qQoipJUNIN1PcqAcfM4Wkkq5m9q0p3FgqX4ghJk8LcNM9+ROxRT5tZk+h?=
 =?us-ascii?Q?YcBnjDTa+CCB0Kht3RlP3JSyugIz12wvLb75ohzvf3d9yh+fv6S7jRP6Llka?=
 =?us-ascii?Q?8HZ0XQ1HQjc1WQ4F0D0uQK1yayaoEGM9M7cEdb9++R1YSMSN4kPjSIwOLgFT?=
 =?us-ascii?Q?kY5scgtbd8Y4o2UKTAjnqwvOIHoWQJUQelUawyr6w9Y0ksWdYTOldaAUzDM2?=
 =?us-ascii?Q?c7L/DZlddhfrTF/GXJLToqb4nAEgVkxTv8zu+cSpwCHwUQ+dM1QbQ9AGBtBI?=
 =?us-ascii?Q?yGBpnXqp1C4PSV0G3qtfLkyURjO199Hwbnpozirf+jB5EqlzoNGrLU29yOMQ?=
 =?us-ascii?Q?bWPERxtXl19EXlRMFlZYNJeIaPnjd6A8GSDMegqO3Vj0bgdzmYN0x28WUcvM?=
 =?us-ascii?Q?CCmPpLY4e4KCy2juVUs2TEK0QjHSeMoPsGccLGs0mxPtJrRp2t29+pVj7Ih5?=
 =?us-ascii?Q?wv1TBdh1jc6sRge+S2sItLbm8XEPAkpzobhcKsay/4ZPCmcgBvfG8SHJ618O?=
 =?us-ascii?Q?Tif9f+aXRGM82zBSzlYI1CMvKvOOjnZkYaW468SdYsh0RRJeTePK8R5gbrso?=
 =?us-ascii?Q?P5hmO4LXRU4+2GmAMn7YPtVIC19L4U1BSsIHocLYMwA8ILlGyzKup2L6oBQ/?=
 =?us-ascii?Q?jyHDenhCYmMAYEX5oFeb4NKelPKZFeX69ntCQx+aiBZv9hLk47hdjIohnyrN?=
 =?us-ascii?Q?2H2YqiIUuEGR3+AV2RJ2PicOmf+r9jp+Q/3RX6PxDEexZM8El3WntLXKzfEf?=
 =?us-ascii?Q?UEhslrWMH5LcDvNYMeofeOxp7gSjz3bD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NvfDJmUU9DAeWOEkohKUZw0S2qAXq3saaFrnS4XAXcbqsT61S7Mh19fb8BD?=
 =?us-ascii?Q?LqNQGThj+/bUfz4THpUYU1V+xyNpT4Eevh13p72a1CuUos3VBkMAvkr0VAFi?=
 =?us-ascii?Q?6enDRDKwbkvGW9xqmrLTo3mTlB6N3+elxSsKO+jzifmdvnimx3gtRrgN+nUS?=
 =?us-ascii?Q?Y8lhALUx8UT9cCYiaaSZnhdPak2c21Huc8ITvn+W2wJSPg+QTIYGou0hGsDR?=
 =?us-ascii?Q?aFgNJBTseHiYRgZIr0ugwqfte4ABrX7ZspEt0NSwJyAsN7xRtlumFtOZUjX/?=
 =?us-ascii?Q?Zdlspfmm978uf/oSHTsqkVX7exIlEta53i+puUoH0v27nziNBtPmssELl1+v?=
 =?us-ascii?Q?V4xuAJ/f/81Su54/BXgQau+1cAO9yXDXo9urSHWDlPONpiShd1KVaoE/MXUE?=
 =?us-ascii?Q?GOflQVbGAET7oF4YD9rl3+qRQY0m087oLB7mYL1JlihD/wKwAWgXnW2Vee1z?=
 =?us-ascii?Q?RqFRLqurNyfP5wXYNV6xM9H1zF7uoNMPIX2baRXRUOsfgdIIC1Fls78powUu?=
 =?us-ascii?Q?fR1UTIfQ6YGxq1D/TfWM820BO1NZBLEarD6ByouX4kl4Bap/c03zpaNgmJFP?=
 =?us-ascii?Q?vLxUQcsY3e/klxv5zFugbxxo4Jaqt0kb9cN0jnKAIBNxVNNOVeLFTN6qCNva?=
 =?us-ascii?Q?4/ZU/MjxJ8dhYdwAhLZ3doRO0H6icxhEt/bptjdXEihfzna2IAU0h1u07ngJ?=
 =?us-ascii?Q?cDJElXYKCI/eBEs4JrfkjmIOFnEAUGPlq38ZfqA3so3tuCKBKQ4OHW1n2HTY?=
 =?us-ascii?Q?usj7RJxtu7z5pcK8jAd+E9E/JzkI5YEB6AnJFPJZ1eCyxCrtDCijvE9zJnZe?=
 =?us-ascii?Q?KpAL8R6NkgWTizCFNl8O8pvQKlXc8YNn/fAaIdlG3uG1j2tBPnDSJiu9AwiU?=
 =?us-ascii?Q?GxjgNQRXH40JvaBL+r6gYLxo1h9JC0UtUclNakceS37KeKOOdycGjAYDLShs?=
 =?us-ascii?Q?ukaJAINFKBdTyY85/FKQtGCTVVELDeGOTn2CMJOXI2ZtQG9M4uF1kgaFQPVa?=
 =?us-ascii?Q?o8oiK4bNryADT7FoKctZzbml7FjMoUBcFFRdwllot7eJn2YXoyQyHsR1Fo9e?=
 =?us-ascii?Q?/uiz0AAzbm+NllRV0qHTEVjpbTbb15m0wkOFbbgsDIOztn6PaZGIC+4Md4PV?=
 =?us-ascii?Q?vbjs6LugtCRzH6pL0Fmo/Ejin0uWriTw9E2gDo6CndDTjWqCc0Q9pUdwyn7k?=
 =?us-ascii?Q?2gz6sODRA8dVXZz2dQCUVfo+LVZOySyFaxAyF/PTPi+t5kXNyF2AXkPplfGz?=
 =?us-ascii?Q?1NBgXKXkfEPus0kyF3bOfUzxJFitBf7DILfplSGRU76sB37fnlTCmYmtR/pm?=
 =?us-ascii?Q?cT2Yaq1oIIOZEtcvVhJi+Oll3Zm3bw6SG5kaG/ZPPvCcORd2pBIAOF1vpR9k?=
 =?us-ascii?Q?DUWCL2E0YXLmKGIOUSxlYuhFTHXRaNe4uNKzkk0uEgHOQ7Ndan9WioJMzcDC?=
 =?us-ascii?Q?l5Jcm0Em+Gs6K8KIo0s3OcUSuYgUzQ3q+gi62k5G/GLsDXO3emqZk90J4OqY?=
 =?us-ascii?Q?sGljvy1O9vNBcJG1xep1prgTqnpBKnYFzu5NEx9BApfORx/YBmLdGAh5xgeO?=
 =?us-ascii?Q?WsJxcEh+LToxrqjQH1qRdyrF9BbwFD0hT8PniFuBl462rS4h+8nb/CGglRKC?=
 =?us-ascii?Q?lK9/WkosMV+Q0qSrct54RtI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fea16d2-b839-4556-96ae-08de29fe1c00
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:10.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uxL4i9TKf9aKzcWVdoak70SbVbUVdqqRNaDrOWI0DpcJafU532oM7YUQxM//jraK5QJN7rZVOppFsr3fHU2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Prefer the new "rx-polarity" and "tx-polarity" properties, and use the
vendor specific ones as fallback if the standard description doesn't
exist.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/Kconfig       |  1 +
 drivers/net/phy/air_en8811h.c | 50 ++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a7ade7b95a2e..7b73332a13d9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -98,6 +98,7 @@ config AS21XXX_PHY
 
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
+	select PHY_COMMON_PROPS
 	help
 	  Currently supports the Airoha EN8811H PHY.
 
diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index badd65f0ccee..4171fecb1def 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/firmware.h>
 #include <linux/property.h>
 #include <linux/wordpart.h>
@@ -966,11 +967,42 @@ static int en8811h_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int pol, default_pol;
+	u32 pbus_value = 0;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
+		default_pol = PHY_POL_INVERT;
+
+	pol = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
+	if (pol < 0)
+		return pol;
+	if (pol == PHY_POL_INVERT)
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	default_pol = PHY_POL_NORMAL;
+	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
+		default_pol = PHY_POL_INVERT;
+
+	pol = phy_get_tx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
+				  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
+	if (pol < 0)
+		return pol;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				       EN8811H_POLARITY_RX_REVERSE |
+				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+}
+
 static int en8811h_config_init(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	u32 pbus_value;
 	int ret;
 
 	/* If restart happened in .probe(), no need to restart now */
@@ -1003,19 +1035,7 @@ static int en8811h_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	/* Serdes polarity */
-	pbus_value = 0;
-	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
-		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
-	else
-		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
-	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
-		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
-	else
-		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	ret = en8811h_config_serdes_polarity(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


