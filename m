Return-Path: <netdev+bounces-246691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15675CF05F8
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF21B3069B43
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF92BEC32;
	Sat,  3 Jan 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkxQV/CA"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BB2BE647;
	Sat,  3 Jan 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474322; cv=fail; b=uLWPenIJ+X1SHCGIpev4/zh5Ia7dIV3CZdfCPDnd0OXZkPtRlTocQkc/WLySmO6JDVu1V3r/sJuqoamXcJpFaKsmoHU+WRGbCEcnTZ4S3f7smuWV1iSl3QobwGjSYaoIXkc2X/DwQv1MMHR1mbdP0VOx0W2eLap8o/ZGZ+bVXBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474322; c=relaxed/simple;
	bh=LBf+H3C/42fgUJIhRDhMWcdFmGXBBX+OnJLl6hBEI/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBxV+eeocWXUZWoe2j24fn2P/yCUdDSplPZ3tiGsF5bCt5kJV73vVqBd0CxjdGxN4fmJO5rbiPYhXXwEKP0nBFlzfuAqKn+gMwZtsQ5YoXUHZhT7n4OaHmVMR7xe2mja68ZtXw2tTbxWvidRgjzUoOVFuZGv1d4evlPo7pJG54o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BkxQV/CA; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhZkYCPtaEEQchQYK6EZbyeSnC+hV6n2yoc1iLnlEgOZ45tV+jjuD1YRf4lyJec9PTceAt4YzalZ7+lMDbsSfZD+sgsSd0BLgnN8pebxZFY+EzVNWXJFQAqJIZQyj9k+VW3j1WLnspSDdd2aaq9N8A+LJ9Gr4mJL1EvwIbhRpUBM5wtTKr9/1Kj0RRDFqyEhx9fHdoxkmD/+K0xCGabtgfqq2WfzjKbRegJ+qfm9e6se/7lP3bi8yE8qDr3vPdZ6K2YL0a2CGB+qcjCS70EVbG9Qbt1IsX76Ta6n66PbBakCs+dlvVu7gdzJCYEjBHPh5Z+Jh7dUKt/nc7ud30NDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OBrg0q4GY/Ef2cBVdLYxFZPGBub/nDOAs/E2DriYUc=;
 b=sa6hNYeTz02kmr10xVlPurh2IkLV3qgBL8y9QI1YZ+SYaq8WT0cjrjjEsi7kMVLaQHRLUR0f2hKHVCWKi3fDAhcHilBRHpFjUDZHui84VFOZ43z3PBKmsP8X/4u8FERVjJX2JsNLBUv623RkQQFm58tP3sOhl8D47ZuyFs3hZ5k70bDcTOYANEZ2vP4D30bx7hYc29H8MDxVcOWlheOy91BFGjW+yK01KPGYCzcDs3Y9/Oow7p5P3C/plLlp3yVd2nLRMsUGQSACMwmP7B917LoQhA8MVoiz1D/WgfYtjGMmUisu0+DL9Pzcv7RmwCAK8YsH1S3UCu4mgXZZAfEUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OBrg0q4GY/Ef2cBVdLYxFZPGBub/nDOAs/E2DriYUc=;
 b=BkxQV/CANZffjtVfQDIbLkjF9d5TyPXGP2RKTKjNYeBpdcvSr2Hec8eQy5zsIjyVORGb3JgOX3JHvsLe3MUP+QZHJa1v0XF10Etx8eQeLnPMtJsAbBO5fD9yyO9/Ck5vKVo3KRVoUVBHQwMrJC2YaZuA9YqUsctj6+m7XSL6baY2dEGW/B3DDuDMMrxw4sprhDD46dIn7pr6qi3vsSyl3I08/kegXsKgkL/lhHlfRVyZ2Xh1BiutRuv8JagBZvB8Lsji+IGUWei/TgS1s+CpBN0wYXslC6WdzwlRx0kzSQ+NsK7riYq3bb4btohNMMiclalwJy+aEMt5VmcvMEVosg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:05:16 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:05:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 net-next 09/10] net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
Date: Sat,  3 Jan 2026 23:04:02 +0200
Message-Id: <20260103210403.438687-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: af09625d-2b15-4abb-3a4a-08de4b0bcb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/cIXJxM94POBvtC8AAirwjFveL9jivwZU2ZbG4CmyRQ6nnnPPbDlU/+90DsF?=
 =?us-ascii?Q?COL7EcWZFp3o5y3BfywjI0qaG+oocS9TM/4FFJ9kpeLMmmUo8HMTTGaMnFgP?=
 =?us-ascii?Q?JaCVBk6P+WC+OYLZ86FDON0/e1MAWAjb6nxkPnZ0IvYJhTnsqd+hamUBewDM?=
 =?us-ascii?Q?SfBCuHH5rm/tBgHO8leNJCxx2rFmoSa78BSlzpOCrsM9W64JXjowtEXEptfT?=
 =?us-ascii?Q?y9CtgMEn11a1TOFk7WGI9Ugi+rRgY/DQ8LQiErtHWYkgqGp1xEOTqM8preWD?=
 =?us-ascii?Q?WoDpxEMmrnCYPDaeZvZzwCAUBiRbysp/CN2DfPxOioLf1DdMHu504Aon8brd?=
 =?us-ascii?Q?OGT7mc8b4VG/cOXVpXzhxFWoIr91DHvvfC61ct9/OymbTr+vnFZ/QR23OCoe?=
 =?us-ascii?Q?VbvsAk1ZIMAkXnpc0lPV8t6OCjpbPa5LL6J9t5AaSwBDBwgl8Qo9Q8jPk63X?=
 =?us-ascii?Q?lUy7Q2lupltVKFiESy/s6dANtt7nb/lQu6uk5HazXhjrLrbRtQhASxXIzbnj?=
 =?us-ascii?Q?W1qF2BIs6eaMjfCrvpGovFLdUYzMU8dTdOk7a/XPoU5RFeseA2BuzClJj6rU?=
 =?us-ascii?Q?B+e8biGoho1Da2r2n/fLu1Pzw8nzjPUZf02VCB9WoYUv2tKKp0fZ7aP9rmRd?=
 =?us-ascii?Q?L1zBcsTS5k24VvxZQuJ+84KXjtIjp6qsJFv3ZaXiiONEtMkhcMFn4J3vPtDV?=
 =?us-ascii?Q?GMdC5l86HW2AJlmBKHTNeb4+9tC3BKvW+Cx5yhbeZNkgq+1JXO9V1OJiVj1y?=
 =?us-ascii?Q?SVLlvVxExuCBB1LBIOkKEjDU9Pt8wZpgMR3f/tZmj5wdnfLOE2uWBCSsSFUP?=
 =?us-ascii?Q?BfVDSpXiDjfH1R4/TA7HPimmIvPI8EZdFQzH/m6/ciNL3HEfvorP6qQbBBJH?=
 =?us-ascii?Q?wUceoJ2jxe9QVR87Lby0roFRNFt7Uq8m1diTMKvETS7eQQme+UlTSRQ1V9lj?=
 =?us-ascii?Q?vAPjqPJtLTy+3IIfBZqfNF3b3V8qvOzJj547zP02xlVqhbPTikOZDyIDWAWo?=
 =?us-ascii?Q?H8YSJp6CEwGNrzgGwpK7JdpD8tIcNPYLAG1r51JBrYxK6piC2xPLjGdi+828?=
 =?us-ascii?Q?r9Y1UVWfWPX4MWsj08dxTK75UCn85PqaFchzA3yDCtGDe2P8axDONdA3FiXn?=
 =?us-ascii?Q?H+p64bQnjbeqZGbxpHa+558R1XhtYsxwnO62bNWIhB02CE0ECniR/Q/CJUNV?=
 =?us-ascii?Q?FeeP08bDTmKnvCHhEJKavvSOfQLO7ZGBRFwEaUfxGLqJ4q1SipjXQSAeLJu6?=
 =?us-ascii?Q?3lFD2ZMNwjMfF5HD6kOXSgcJMRzqH0tbwt8lLCzDOVIKH7zHSCnt6DVsKzJc?=
 =?us-ascii?Q?LCqpDE6Tn0/ej6Z0w10X1Yy85zWDK5Zt9ZJQhapvtYxKTa76hM28l6VWIWXs?=
 =?us-ascii?Q?CEtYvbz5gKIHtMzgMHqwp9/qEGNxf++yYQMyt2l+Tqq4ZH/oxZ5sz60sN+Eq?=
 =?us-ascii?Q?fkQn0Mp3CujNo6lsyxE0ts8UdxeuLGFM3hY34/R8QPrGUxdFZJoXAVutZHVb?=
 =?us-ascii?Q?jUdAhDM3jI2At41Kg/J0Gmx1ZYd1h5EunUR8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d7o/ScoecqMM/q+5geFxirnxnbZpByxGU+oA0bkNlQZ7Bm3SlS64GpY8ZRyE?=
 =?us-ascii?Q?uorJE/eLyJY42yQdVyuCEd+66DVV5aH0YSvKmhiVCjI2eIpFKgOynCI4xcdM?=
 =?us-ascii?Q?nI+PwswZb1RA+omA/ca7+slyky+wE8oCjZkftfRwTLQjsiQyT2II7jZvskjT?=
 =?us-ascii?Q?TgFIs2gWFq04mLEt+r5K5MD/fvNNNaACJSFKvGCTgYEFCp7Jv99HIBvcMzgp?=
 =?us-ascii?Q?mxVk1u3PErr4UaYXdUYEIs3Wxa0tyBB/uaKezbXS/LXNYVKluFK964VY7d6J?=
 =?us-ascii?Q?8mGNmNIM8tL9rZ7v6w3v+YcoAUK1xeWRXfi+KwDcRhIhmAvcYw+mCB6cTc5H?=
 =?us-ascii?Q?wG63xdO6wLhbFzpJAHMWQaM/TPcMEIfPdpijXUv0/3kd1N0k53gVFfrbofQE?=
 =?us-ascii?Q?qIaO2ISmoMs6SlZtpEG3DfUP0/16CZB9HU7/rULFwar9kBKZMQlFtzDLhUBm?=
 =?us-ascii?Q?QNkEuWZLbWJQCK97e3lDrXXqRyr4aQi1tkz0nmjjLlTSgJ8sZrvaMCtvIyqX?=
 =?us-ascii?Q?ddoXe/uVRakaYbI7vTm31lr1Xik7wlFpUspAqEm6kWxp21zpIti0ftW8PNkz?=
 =?us-ascii?Q?emTeNAZNGK77qv7t5X8M3vUvMumQ4naTXSGjTmdIAoLSzMbsU9hyeaH+yUhh?=
 =?us-ascii?Q?fiFrZ2Y1/W2gZD/UUr2VmwT4ia9pn+JkpFK15lijbOb2wxpqyVouLqnuEhQ8?=
 =?us-ascii?Q?ObURjvz6X89TRgnWzHRfGqWhaFXxPsBRdFHqoY5ZDYqTXmL1/ocJWRbVfY1A?=
 =?us-ascii?Q?iAZgm1citSrTK8y0FJQc+6IZPaAFo/cbtt1Aa6Yk5zT/KZtLORLloxJOVV1w?=
 =?us-ascii?Q?SOLdQPbUvdDES1LI9cTzZsMnHUrWjnjvgvbvjCqnkbP674Qerpm7SU3RARhB?=
 =?us-ascii?Q?DublxPKuJkJlR/aGHGxtq2Nl95wlo7cM46dLdSDYemvQG1g/IpsUjApkqTQQ?=
 =?us-ascii?Q?Kh3cSkknOT2PZhFUvFh8Hg4cCf5UVkeZx9paATVbYd8BdfkuskSG2lVxv2rE?=
 =?us-ascii?Q?7eb6u9e9Hk8fLf3HCvjXCTvdAlMD/aljEPgc3/kq1a5dxDKbNyheywKdJ2eL?=
 =?us-ascii?Q?+CCY7vFIgY2iQ3p6xQXcEEF2YX9ox/AS9aHQN2a8eGv5xeLBiw2/WZU+eTaf?=
 =?us-ascii?Q?GyGX0kU82p6TzYbIByrnr5Q5pCY1NCWI1JeJPpw8SUmb4kWQuW9cBovqPY/G?=
 =?us-ascii?Q?wsovSkuAWO0xz3gAy353RAp5S+fZSqDfFsENCnNS7oPuJPmMPyB3jjzf+E1j?=
 =?us-ascii?Q?g5GVDerk35qzkbLu8iNO2UDVhcotHAeKK99NHRAmWOE5mMyCKoWJpdH3siOv?=
 =?us-ascii?Q?L8QaJvqflQCRnZ7TwAyrkONT0Y/U0kQGZcBiXhIwUF2vyxcD8geN7A3ahZWV?=
 =?us-ascii?Q?vrxgxQvwv+6s4gggi07utIC2FBerKRYFF32Kd4WpoINRbSIBozwPWg88wFtf?=
 =?us-ascii?Q?DxEDa63qDyFfLQTz/bnKxt8T5chhAh4eoSpvycYheEePGzsRcIypjSGMScnL?=
 =?us-ascii?Q?4Hwi3HzuI36GcsVpbKfaQbWHuf/Tk0ea2JDP6gChPkiZis4Dgk+/Sryhatz3?=
 =?us-ascii?Q?M4FhQ6aq/6+yaypLII2vT0qmUYAolhvaUDml9L+vK4ZhZv2iThlmu+/M+kmo?=
 =?us-ascii?Q?PMpoHq7fAG5RX8nizXKSgXajHlNhBxQ594Pnj4ngqQjdut0e5VE4b91dYWUn?=
 =?us-ascii?Q?Ac8Zr36abRJNp8ZQG3GEapmYZOy+dVJCyX4tQagL4aJsDvTkQngAcaG+2CEW?=
 =?us-ascii?Q?nLsYeo2gWHzuicVv1wznL1SHApb0yJw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af09625d-2b15-4abb-3a4a-08de4b0bcb62
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:05:16.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdbSaHlZDx299VtS8WrBPn5FX2QZrk+qJ6C+Zh6l242e1AZN52sxoXhbCZy1sk6xxNmB6/TvMw9z16jT3u+S8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

The Mediatek LynxI PCS is used from the MT7530 DSA driver (where it does
not have an OF presence) and from mtk_eth_soc, where it does
(Documentation/devicetree/bindings/net/pcs/mediatek,sgmiisys.yaml
informs of a combined clock provider + SGMII PCS "SGMIISYS" syscon
block).

Currently, mtk_eth_soc parses the SGMIISYS OF node for the
"mediatek,pnswap" property and sets a bit in the "flags" argument of
mtk_pcs_lynxi_create() if set.

I'd like to deprecate "mediatek,pnswap" in favour of a property which
takes the current phy-mode into consideration. But this is only known at
mtk_pcs_lynxi_config() time, and not known at mtk_pcs_lynxi_create(),
when the SGMIISYS OF node is parsed.

To achieve that, we must pass the OF node of the PCS, if it exists, to
mtk_pcs_lynxi_create(), and let the PCS take a reference on it and
handle property parsing whenever it wants.

Use the fwnode API which is more general than OF (in case we ever need
to describe the PCS using some other format). This API should be NULL
tolerant, so add no particular tests for the mt7530 case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/dsa/mt7530-mdio.c               |  4 ++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 19 ++++++++-----------
 drivers/net/pcs/pcs-mtk-lynxi.c             | 15 ++++++++++-----
 include/linux/pcs/pcs-mtk-lynxi.h           |  5 ++---
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 0286a6cecb6f..11ea924a9f35 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -113,8 +113,8 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 			ret = PTR_ERR(regmap);
 			break;
 		}
-		pcs = mtk_pcs_lynxi_create(priv->dev, regmap,
-					   MT7531_PHYA_CTRL_SIGNAL3, 0);
+		pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
+					   MT7531_PHYA_CTRL_SIGNAL3);
 		if (!pcs) {
 			ret = -ENXIO;
 			break;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e68997a29191..8534579b8470 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4991,7 +4991,6 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 {
 	struct device_node *np;
 	struct regmap *regmap;
-	u32 flags;
 	int i;
 
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
@@ -5000,18 +4999,16 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 			break;
 
 		regmap = syscon_node_to_regmap(np);
-		flags = 0;
-		if (of_property_read_bool(np, "mediatek,pnswap"))
-			flags |= MTK_SGMII_FLAG_PN_SWAP;
-
-		of_node_put(np);
-
-		if (IS_ERR(regmap))
+		if (IS_ERR(regmap)) {
+			of_node_put(np);
 			return PTR_ERR(regmap);
+		}
 
-		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev, regmap,
-							 eth->soc->ana_rgc3,
-							 flags);
+		eth->sgmii_pcs[i] = mtk_pcs_lynxi_create(eth->dev,
+							 of_fwnode_handle(np),
+							 regmap,
+							 eth->soc->ana_rgc3);
+		of_node_put(np);
 	}
 
 	return 0;
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 149ddf51d785..7f719da5812e 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -81,6 +81,7 @@ struct mtk_pcs_lynxi {
 	phy_interface_t		interface;
 	struct			phylink_pcs pcs;
 	u32			flags;
+	struct fwnode_handle	*fwnode;
 };
 
 static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
@@ -168,7 +169,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (mpcs->flags & MTK_SGMII_FLAG_PN_SWAP)
+		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
 			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
 					   SGMII_PN_SWAP_MASK,
 					   SGMII_PN_SWAP_TX_RX);
@@ -268,8 +269,8 @@ static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
 };
 
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap, u32 ana_rgc3,
-					 u32 flags)
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3)
 {
 	struct mtk_pcs_lynxi *mpcs;
 	u32 id, ver;
@@ -303,10 +304,10 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 
 	mpcs->ana_rgc3 = ana_rgc3;
 	mpcs->regmap = regmap;
-	mpcs->flags = flags;
 	mpcs->pcs.ops = &mtk_pcs_lynxi_ops;
 	mpcs->pcs.poll = true;
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
+	mpcs->fwnode = fwnode_handle_get(fwnode);
 
 	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
@@ -318,10 +319,14 @@ EXPORT_SYMBOL(mtk_pcs_lynxi_create);
 
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 {
+	struct mtk_pcs_lynxi *mpcs;
+
 	if (!pcs)
 		return;
 
-	kfree(pcs_to_mtk_pcs_lynxi(pcs));
+	mpcs = pcs_to_mtk_pcs_lynxi(pcs);
+	fwnode_handle_put(mpcs->fwnode);
+	kfree(mpcs);
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
diff --git a/include/linux/pcs/pcs-mtk-lynxi.h b/include/linux/pcs/pcs-mtk-lynxi.h
index be3b4ab32f4a..1bd4a27a8898 100644
--- a/include/linux/pcs/pcs-mtk-lynxi.h
+++ b/include/linux/pcs/pcs-mtk-lynxi.h
@@ -5,9 +5,8 @@
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
-#define MTK_SGMII_FLAG_PN_SWAP BIT(0)
 struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap,
-					 u32 ana_rgc3, u32 flags);
+					 struct fwnode_handle *fwnode,
+					 struct regmap *regmap, u32 ana_rgc3);
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs);
 #endif
-- 
2.34.1


