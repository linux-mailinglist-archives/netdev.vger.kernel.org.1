Return-Path: <netdev+bounces-251022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAAD3A2A2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56EA930D2F25
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B14352FBA;
	Mon, 19 Jan 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1W7rBna"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAE352F98;
	Mon, 19 Jan 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813974; cv=fail; b=HeDIHyTBJS18Xs0pTXZlBR+ZQkncjQ4KFGsRtoncgQ5kHJmAsjWHnK56XFKEm2YDuOWD2dplgXR0wBmxCJioWVpn71wzEICB1HazNRLT56WpKblfzBwj0Sw2LBzS3e4TE3ZDMVLxCyyQFSOi3950DAtda3Zc3CeOe+xvISJ4nNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813974; c=relaxed/simple;
	bh=nx6RXwy/eEomugvG2GhcQyAaTSiUPLGevNIC2Z/z8aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XUfJRf9NG9zZ+OZTvRznc4X3vM+X2Rf4/jw6gZVIn0Lg38JzcqQEkX8ltFJgI3BRH2CLk/ET1V7hJ+My1/wJBZ8lexzveG6ylGXYCbN5hFJGR1wvmjpRQGlgI1gahDV8/Zz1gCK/Fldk6LIxZXBR3ip1LGketHTYpULPxUL0xGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1W7rBna; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIn8r//texpfWoq4kkn5IEfCE2Jgr8qF9TW3hQmXsWcmC6+pftenrmGxEKQ3Oz/9l2J/pFUYfZFeOIL0OnjvWAEnC8mamrKEeBA60USTvM3AJYKm0Sjiuu8Lmfzxq6uGnSE2blrJ5IkCGa+oEUShJ8e8CWe899Psk7vIJq+j9B0CI1Uqteok12jBRHSn5RRiS7xrtNYkp9c6AK0twkwBYFvLw2NogBGiYwtcPyfhc9xuGLNXTW/9c0O/lUyheQaNbN2pkvBJIH1WLtGccopmsZ22astVFb7v1jIO7sQgWhgv2x9NDLAdXp6iJWD8DgAAHh5SWDUWUcOu+mX2+CiRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vREnv6+8N5juXMQUN0qy89ImAKd36PZg7be/flBfLdY=;
 b=Cn5ISMcZJGX9osXfoJuHn+sq8NMsgXCKwDvxwL+F60JdQVL4BJNhXEoLNlGCCa+i4E4dy7NiyM9KRIAfUxOnFzHCSI5mgNGw/kqV1f9GmMywSUSYnhdseBZ5D8yD2BfhqIhLG+g6RRJAGDSgzptEUclOV7d9E19ifvDkBaP+MGTr5i9zMlZjrXNXUtCST3q0uE3o8TtS8I8h3Xz1ZtiCSN3bCRV2M6YrIJ5fO/M9Oo29N8eFNJOtDAMIeozmEN11m1KTQeON8UhQaw9c7PCO9MuIMJ2Ps8j1V3cE7ZVQ3TrpEnRjdTI3XQyBU8EEkmtkr7zm3t+tqAeDpIRc6CBo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vREnv6+8N5juXMQUN0qy89ImAKd36PZg7be/flBfLdY=;
 b=W1W7rBna0bTZh1EES4Vv0hFLkal5xq1imDbvNLG5m8yq0XrN1dH0w5Z3wj+an1I2w3Y1/0cATjB6MsrvTLK8U44lobcvBQ9SjbbsELVJkAmSS8O2Q5+AL3AeiJ7Q2qwe6i2uTk8izDEMuB5p85HakhtLaTV0/F5b8CUQAlw2UNcqJUK7IB3hTqrrOHWqxY7FLiYUJISbFxNuZE6lSw/T/FdVw41gq1zc+Ps+hVXGJMikMfRIfGBtLWwN+BCUjALf6MDte4QmbLxikgkK9kIAZNMJ3Zt0cTGYT9aD8AaJM5OGcOPK0NACPbDT7O3tlHaNpU+m4oxePmkhFLDXKOFalg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS5PR04MB11466.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 09:12:42 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 5/5] net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
Date: Mon, 19 Jan 2026 11:12:20 +0200
Message-Id: <20260119091220.1493761-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
References: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS5PR04MB11466:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2f2fc7-fac3-47e6-4e04-08de573ae697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mcxjgm5aWfYwI3sCtJPXWIoXF5e4rl8hCN4UpPOS/QknkCz8MI8xr80zYvnX?=
 =?us-ascii?Q?BeBZpk2QFobB+1tvGc+oIzebOvJC1CHiJxylXs8w+ckHpJLc+nrdjUjIRwWl?=
 =?us-ascii?Q?Mebf2PFPbpTdBMWyOuBJg8XcyDU56/WlY8VtrlcK3Fyb+FzqreM5DythyNFb?=
 =?us-ascii?Q?CFhW3ozdx+BpEbrcrWnXYFi51BfJBvObkm6lT0aVM6Ncg6KpTtBW5rCLHCag?=
 =?us-ascii?Q?J5b+sxNYm46xQr+ir4rbpfMx1jsFw58C+ZvETcdS6td1ScypjZvruyglDDhb?=
 =?us-ascii?Q?gh21cH/76lYtTbi7XdZrj0i9lO3/qBdKKR3RAgGIz9Byd1yoQ2QMMvRTEeKw?=
 =?us-ascii?Q?d1RBJwNV/He8qlj90fUbGMAy1a4AefED4jsIrlcT6XbzK6aLHHH2gO67MFt+?=
 =?us-ascii?Q?SLafVXTNooQKW+lDLCNcvhMBKcqwNc+p4CRLzpOOpUUyM0wyJQLoEpFoL2s1?=
 =?us-ascii?Q?pQbBqyd8xF1ZmWo4lnDKYfOSCtGQ8eUkA0+pWcImLpECB35237BuU8KXTJjy?=
 =?us-ascii?Q?GQlaHDiUV0JfaeUmXIvo4QHAX9D1IbK9NPuL+aQgbC5OIUSTmN5GA4SdW+dF?=
 =?us-ascii?Q?AJVn/bPJ5Mxslm3RfCAaTjod1/8YFlKrKvXUpEqo3S8XmEgskiemopa5kidj?=
 =?us-ascii?Q?GYFmo1FchFZjGuqV0dNx0hK8pX8B2nYNY/xgX8RIJL7j0WiaAOB+++CfK18Z?=
 =?us-ascii?Q?15PUWq2ToE305nuRMoVDgRhM8WwdnijzvNvCi9zp9jtuwxkUcJR/boT/ipcj?=
 =?us-ascii?Q?adnfXGrVI3/O48sULhNhuCn+cITTkigNu58a5/TzrhvNDn7Qnzki62axbgtr?=
 =?us-ascii?Q?rU+ByxY8jjIvGwzVpX7pAXmrncBHGRlvLDlg/NQhdyCPSrPV1rrIRunrlF3v?=
 =?us-ascii?Q?mlvEn9hha0JTZFYhUR3x70L4zD8tk/CDJaatSbFbJVQbXf6zpWryQMJ1Ld0r?=
 =?us-ascii?Q?KMokD8Avag+yshFLexp3wT7QSDVNCgRkhiPB6V1jt1v7mKDcO4tlLwO7d324?=
 =?us-ascii?Q?7MJD2Iqgp688ksOjegc91GeS+oy4yfKHtE7i7qd56xU3mqqmW7S7BPdYr7AC?=
 =?us-ascii?Q?rtcvJ8ATeKpwkRwBDaPLNqP7/1GjxOrsQKWSfrO7jsGonH6MPd5gr6Lw9I8f?=
 =?us-ascii?Q?sbTX5qjipXZMM90UrIBfbYKY1nigATeIcPuuWSmo5HzMcNKeKRFXUeghf0Sv?=
 =?us-ascii?Q?epYOl16J0VsyULWX4ScmrvID+tSB5TGCcy63L5yfjBqTC/mGVVPjJx5/SA1P?=
 =?us-ascii?Q?QSj97SfRmf1Pr34knbNLPKYmrHQOQi/JZjb2Gm/4EVWztQnuY78Ssj08Q/yn?=
 =?us-ascii?Q?owWhnjHW8i+6id4050VQ+2fyZSjLonSKgmqKudilQmb9Xoe3wXyH3Q5lWp4y?=
 =?us-ascii?Q?YVhPNxlw/b+GtG9Q7WFfmxTNxcNHALBSmoWDBxBeoKZHFQR+vQPTO+V55Vih?=
 =?us-ascii?Q?w0ukpOeaf1kJYPTdGlQ0g5uYF35lr6cG8OJfynhjQ7wXQhI9XS3MULBuxy0v?=
 =?us-ascii?Q?gejVBrvZWrgDzgoMVVWw+TuFmWZUp8vtKfc5wnO75ul0IG5bKcwMpH/Se6Di?=
 =?us-ascii?Q?E30M58xM2ltcqJ/Hgk9gP2i3Krjmn2sEHvZLyFCEdP0yEYB/1UCbEh7DYvMv?=
 =?us-ascii?Q?FfC67PbKAbaJw4CdIB2RA9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1o4iSVaXhkMXdUTejfPZ3vX5vvpeDSjTYHN/p4S0p7v0Vb6avoVpwOqaTtf?=
 =?us-ascii?Q?E5itSb31pqjQYjtf3CuHvXi2GNd6xUTVfIL8RmZhxa1j62HHHd3REY9oIrq9?=
 =?us-ascii?Q?giyMDCWB5CD18MyJNlI1RzkMxdoin5bCqpJygKHpUNMkTJ4RpkhkO4D1lBl8?=
 =?us-ascii?Q?5PDnBlKzLu25a8M6Y4uhTw2APE67N5nhroQLNp01c0KgJQaG7xDovDYe0ZDA?=
 =?us-ascii?Q?zz4ww3eyg/lAGjUefGmgg5DPHdCKUUTx5VUSI1rCmn/taE0X1IZVLd4eN88l?=
 =?us-ascii?Q?Le/0a/5o4sZAQfi1EkOWgPSi/GPNGyu3Pko0ne1icOAFGP6wtbzu97sBBcG0?=
 =?us-ascii?Q?6NCdJLq7aJBnmYKgU99MsSpy/EjIOhwvqG187sSsRLM5oRfFpc7v99lEmY0E?=
 =?us-ascii?Q?ZdnTVEpIfkjGCuiumFIWttJBxAeeTNwojSj7/V0FG4y1DAKCmG0doTcbAyu1?=
 =?us-ascii?Q?YYwpTr76JdHAASF4IiuH/MdVEo5oDGJl27rDdUXye7csei7aqbCOw0u/cJ4s?=
 =?us-ascii?Q?sFk9ZjZQPDwCsXo7oF8ZZwKz/V2mUkSFJLwbS9RhI51/cO4YfnDYBlmj0F5E?=
 =?us-ascii?Q?Zetg7LPWfiQ59+tWo+59SQRRbc03x80+1vh3TS4nT6YMUAgbsMP9CrlVxs6g?=
 =?us-ascii?Q?n2ifxkL6pPHAwUQt33Q3TYm3sPaTrNxpvkxgAYs5lPlbZFcLScZl70rX/2bQ?=
 =?us-ascii?Q?+NuoZhmDDV7hcjw+B1s2kCUBcBKMYvWYPHmDHW2r5UKQ+s2RmB2ER71JhAKi?=
 =?us-ascii?Q?/Lr0fZX5CKiAPxesCF1AYp/kGUTa1OU5MpO51qUkwYOviGFETBbQwjSdxVHL?=
 =?us-ascii?Q?IVLBD9VLdYsiPF1tRAcPvJhqYdEATl9gJWAHN0Z+zWgeXQfb+i/zFcUmI9Rg?=
 =?us-ascii?Q?3AOPDnrYI8dCVoKHgQ7HuPJlFj3Z+hmoTrkxEc1zh0PRMJZDSzk+W0KM79fD?=
 =?us-ascii?Q?ylbR8Yi03VvUNrpnBMplKVyVcFBmGDOOSKJZiWS+XL/FeHF/OB5iSGwcr8EC?=
 =?us-ascii?Q?Cp82l6Qg4+Jmokj3gymbU+QJKhbpCsqNXRMxkdeglFx95VT4uD9l0rSjHCA1?=
 =?us-ascii?Q?Rn2vNXJcoLyGFL4B1Tzon47fRU+UfBXeXMnVVxvAPATEW6Rx2eByMkEA73vL?=
 =?us-ascii?Q?L7yqJXt6yf3R7aYtIjMqIXw2+vuv4I+WOsKOzlDYtrltVCW9xlwdI/Jpk6JX?=
 =?us-ascii?Q?DTAGBx+eEjBLZbUV+YtfO39hQXA8ScjTun5HJRT1Iwh6BDpcbjmLuCsM2TVW?=
 =?us-ascii?Q?FCEYeD1LzYJ02Tp0RrIxIqNXZ+TAayoPusWsuyrolYUeEXSjPS4QzcetBDbR?=
 =?us-ascii?Q?ft6jvBrvwJ4BZh+XWZc27yJz4guo4yPkCgTYWUQBW5nwGCxUO+MX2vHFCq2V?=
 =?us-ascii?Q?+SduI9xvOmyUy8XiimOS/VFe63DXOsPPYJyLGrK8C/9ny673twNxa15vHqyX?=
 =?us-ascii?Q?9dNFc6qXMOt3jwCFHW6BV+uzeIyXqSSYR3QHcYF0v35vztp+/PEceKSb+q7U?=
 =?us-ascii?Q?bG0OcNzM0oaWRkV6dhfPFWjhBY0CLdPXrg4vcdixgSgKiF668Wz1Ze2kTBbe?=
 =?us-ascii?Q?fEnVkl6X2PbWfHpAzoPCTCaqAQgloTEBn2N/MhmFQH9dNiJ1SKj3EXv0qWZS?=
 =?us-ascii?Q?YATCDRNJ6eqNt47y72zTY49/G9QSIZeDiRsuPTcTBnIMHE9Ww+I36XdLV3Lr?=
 =?us-ascii?Q?PqGo9LVDDGlVVu1bAnajYFXX1rpjCJsqe7OYSM5kQhZ+2ctcTUsJmS5TuT9s?=
 =?us-ascii?Q?ISAASjH2+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2f2fc7-fac3-47e6-4e04-08de573ae697
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:42.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7N9ym/M1USYN9ywbkrkHuG/pBUAr7sUKavIhQsbpB3/ty975NmOw0OEU57Q2Oesf1kb15A8xHNdmpS9Pq3/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11466

Prefer the new "rx-polarity" and "tx-polarity" properties, which in this
case have the advantage that polarity inversion can be specified per
direction (and per protocol, although this isn't useful here).

We use the vendor specific ones as fallback if the standard description
doesn't exist.

Daniel, referring to the Mediatek SDK, clarifies that the combined
SGMII_PN_SWAP_TX_RX register field should be split like this: bit 0 is
TX and bit 1 is RX:
https://lore.kernel.org/linux-phy/aSW--slbJWpXK0nv@makrotopia.org/

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: none
v2->v3: s/GENERIC_PHY_COMMON_PROPS/PHY_COMMON_PROPS/
v1->v2: patch is new

 drivers/net/pcs/Kconfig         |  1 +
 drivers/net/pcs/pcs-mtk-lynxi.c | 50 +++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index ecbc3530e780..e417fd66f660 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -20,6 +20,7 @@ config PCS_LYNX
 
 config PCS_MTK_LYNXI
 	tristate
+	select PHY_COMMON_PROPS
 	select REGMAP
 	help
 	  This module provides helpers to phylink for managing the LynxI PCS
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 7f719da5812e..74dbce205f71 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -11,6 +11,7 @@
 #include <linux/mdio.h>
 #include <linux/of.h>
 #include <linux/pcs/pcs-mtk-lynxi.h>
+#include <linux/phy/phy-common-props.h>
 #include <linux/phylink.h>
 #include <linux/regmap.h>
 
@@ -62,8 +63,9 @@
 
 /* Register to QPHY wrapper control */
 #define SGMSYS_QPHY_WRAP_CTRL		0xec
-#define SGMII_PN_SWAP_MASK		GENMASK(1, 0)
-#define SGMII_PN_SWAP_TX_RX		(BIT(0) | BIT(1))
+#define SGMII_PN_SWAP_RX		BIT(1)
+#define SGMII_PN_SWAP_TX		BIT(0)
+
 
 /* struct mtk_pcs_lynxi -  This structure holds each sgmii regmap andassociated
  *                         data
@@ -121,6 +123,42 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 					 FIELD_GET(SGMII_LPA, adv));
 }
 
+static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
+				   phy_interface_t interface)
+{
+	struct fwnode_handle *fwnode = mpcs->fwnode, *pcs_fwnode;
+	unsigned int pol, default_pol = PHY_POL_NORMAL;
+	unsigned int val = 0;
+	int ret;
+
+	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
+		default_pol = PHY_POL_INVERT;
+
+	pcs_fwnode = fwnode_get_named_child_node(fwnode, "pcs");
+
+	ret = phy_get_rx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret) {
+		fwnode_handle_put(pcs_fwnode);
+		return ret;
+	}
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_RX;
+
+	ret = phy_get_tx_polarity(pcs_fwnode, phy_modes(interface),
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	fwnode_handle_put(pcs_fwnode);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		val |= SGMII_PN_SWAP_TX;
+
+	return regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
+				  SGMII_PN_SWAP_RX | SGMII_PN_SWAP_TX, val);
+}
+
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
@@ -130,6 +168,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	bool mode_changed = false, changed;
 	unsigned int rgc3, sgm_mode, bmcr;
 	int advertise, link_timer;
+	int ret;
 
 	advertise = phylink_mii_c22_pcs_encode_advertisement(interface,
 							     advertising);
@@ -169,10 +208,9 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
-		if (fwnode_property_read_bool(mpcs->fwnode, "mediatek,pnswap"))
-			regmap_update_bits(mpcs->regmap, SGMSYS_QPHY_WRAP_CTRL,
-					   SGMII_PN_SWAP_MASK,
-					   SGMII_PN_SWAP_TX_RX);
+		ret = mtk_pcs_config_polarity(mpcs, interface);
+		if (ret)
+			return ret;
 
 		if (interface == PHY_INTERFACE_MODE_2500BASEX)
 			rgc3 = SGMII_PHY_SPEED_3_125G;
-- 
2.34.1


