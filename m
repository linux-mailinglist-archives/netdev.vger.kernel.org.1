Return-Path: <netdev+bounces-132982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1B994094
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941B328902D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6A204084;
	Tue,  8 Oct 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LKMY4Gsp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FB433DF;
	Tue,  8 Oct 2024 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372216; cv=fail; b=mAVejxjGmL2OXkxrSkOG6cg71V6TkGLoJZvRuSXSyjYWFzd3OXTsf4yUHs9kkF0LJ2xLW9Cdy8nxuI71kbpzv4Argg4U6FuxkgWQ1qeYFpn/rmq+94kYriv9LjPE9WKj/UP97Js+YlJLtD6iHm9mbAEF8CoBCV4GBsreUX8TEH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372216; c=relaxed/simple;
	bh=i/FJWxiyfkTWQ4fUbjKLvJcLzU3Kz8EVZmcY0/HqYm0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aLlUbj8LOakvOGPnfNrtvX99OJItBGwmLJK3P0ha7GdO/6iS/xkTPOOfft2fjbC/ig9QHvVY1hNPm32o+q7S+K2GSRMKBvW7T/j0D4DBIJ0ZKGfOQBnKauZDRdDXHtTHAH7kAhnGj4rJHWPBNDqVkoSeHAF0waz7RXqs4JEeWNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LKMY4Gsp; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmfhSWLsvv5e+TiwzeoKqni8HUvDbNqrDRCCufyNklGx+te1dXE6iAyqB3nZE4nkNKaNPAqxJ23nBQFDzOPIpCmJZG+Q7dyTCsYX92l0DpQz51XeJgPX6DM9YCzqVrPVxjrukiGg68L+XFxOX1O5Le9xw3MmeYcBL4zcxjc47dh6/cXBTMdw2h1wsF/5EeLBxcuMEWHLuMI53ZxzxsylpUBmwJuhxlcWrj8T3KNZ+hkyN6chckukffYYCSqMF+qLUywVlOXZ3FAYs5xqSgvAeUMXeIiPRP9SsZ7Uqj/xKV9IhTvLDjeFLS3TIC4XORohAUeZkapIlAoEuvzauU0VPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLXD7hVcYNZcUeJBcFBZX5qELEvR5u9Ms8DJTXKgF3w=;
 b=EMtRxzHklJaWPkeRPrczJWlXkGBbICjUI6gY7zS7Tp0pTuqHjf4PDI+T6BjQmyc7I6KBtuG+fMy8cjLsM3RyHGWP+OFVIyU1f8Ro7Y9VJ+1LF8kGmHGz92enUhWvIAo71wcmwhe8KuKX2vDoPPZwjIYEJ4Pbc50tooIGxUcaveUzcbWn7Wgv80JqEplGKdxTNcYXgb6Xka4n07YUSODEpoXZYHUa26i6vIndKCTpzhw2KOo3mezjgx+NxJ7uUt3dTaRhc0+sTCJufeFR49Gge9ZezIbd5jL/eJDxijcij0cxZyrJm+sYkB8QtuGsGzGTMsp1+giYzWd69QRgRxBSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLXD7hVcYNZcUeJBcFBZX5qELEvR5u9Ms8DJTXKgF3w=;
 b=LKMY4GspPZeZSnWxdjHtfF8MwNOq0a8+bjd8qhOvi9NU5EdXFvTuBgqk8kmvWzAPMVGIlEpeaWKvWNzPYmh+oPZM1tA0oZUlXyUBlu2QRLAWHoYfPyy8y2rWJuH/ICYMOBjvX427HsAfD/dQ5Q6zcR5mvNt3GqMjivXKzmaOygs00kSE/5OzW9DyGXWxLNQQglMz643DlJrtr3ObISieFTFjeM6iBIDDAoE6t1VakYNInsVHBuBlnFgsJkqjVpgE7Mr2VP9/7NycTJR8RrPS4WIOYOfySrqvpBtSk2mleRf+yD+5ZyfFUDrwIp5g8eCoHF2RYOPMfDUd7FdQq4YlBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 8 Oct
 2024 07:23:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 07:23:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 0/2] make PHY output RMII reference clock
Date: Tue,  8 Oct 2024 15:07:06 +0800
Message-Id: <20241008070708.1985805-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bb3efd-1b1f-46bc-b0b2-08dce76a1c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tm7tyD3wQViVS7o/MThL5+s+tMKhqQHFSCtSzG37TeqgQ1ot7ga66bJMrz5X?=
 =?us-ascii?Q?Ru0Y1HyhvBQlLGYrycxZEK8I+3AZh1hbJONIa08p3Mbf1LCsNm5rVbqlI7Se?=
 =?us-ascii?Q?+PqySWXVvk52IRwKujwYTyIU0iLAMo9d3nq7XTmD+up15pN4WD4HEAKwOp8x?=
 =?us-ascii?Q?REVdXNE7bfm8apWFApknzfgpRfU9XHWJteweHrKE+C1NHjJOETHSwN39W2Gh?=
 =?us-ascii?Q?L+Lci279w+wV7ENyKl8fbg8ap39zykC4zQveuyxx7mfPWpgPehV4hkSf6Z9A?=
 =?us-ascii?Q?tE3wT2utzrlseJ0Q4ubrDzEOG0QRlEENoSP727JwCoUgL/ysqsQB6MRrpxrm?=
 =?us-ascii?Q?dq5sd/3+3f+W3a9+jNMNOb3hVz1AS+Kwi83isB1in2o5WRGRebHh3YUbtv37?=
 =?us-ascii?Q?B2TfaBauRqB8mdPlTncM/rwrMG0BjmnZ9pmRsNVnWgGCoROvtkL4joQIDWL1?=
 =?us-ascii?Q?gWIk5F9BumJLpRz8R1Yr8iKR69cb81lGxCcWHQ+Yj9hRTu/v8dfhFU8tEaWE?=
 =?us-ascii?Q?rey2x+YRGUsYOEAAHoWkjM6iqOH56EvdRhSSErhFOPAwJZ/+DLIKMMp0X8ar?=
 =?us-ascii?Q?z4WQhskEpDTxTy+BLafEobcmgpuQoLXtglz6v8zIPAybapXu33XPJkYsacEu?=
 =?us-ascii?Q?x0gNmZRm1Lbl77VQFCX7ShC5uLtsxnr/dq6PBROdzX4cGC+6sS5y0mn6PtU7?=
 =?us-ascii?Q?1oKGhagIBv1saSDWpIEGSsy+tCp8Ed7AdR7dqsWBGqZLl5282jAq1NNmiiAx?=
 =?us-ascii?Q?hsAT5duBH0Ydu2HjFXjXhjOqJrMltlOu6dCjqxLsiNL/BC0Kcle3b5lys06A?=
 =?us-ascii?Q?XkCnLyIhqWtcuQlinFjTAmOXFOFqpProrKwYVdhaA8rfpSNTigev9LDhlKnE?=
 =?us-ascii?Q?J+3Qlt8/UL+flv0lblNBf0LjXi4BX/DBGSnGEiJhdnfXZomvM7QRvPu6aLce?=
 =?us-ascii?Q?btyAV5GHCP//A1t8kmiSEcljwJdLvkvPlV2O/D7m/AZtuOVL+HBW2HL2vGzF?=
 =?us-ascii?Q?12H8M/wPByCmFVoFb3dpNaabfKUOqp01/u1/Op0TEvtnLl2x6pEUhVawoafw?=
 =?us-ascii?Q?dKEVSQyIDAOPy0icyY3iyCxjZUKUrYKHKeOPvbMoyAAuTkaN/X7UXelJcZZT?=
 =?us-ascii?Q?rNrIgCJ+mteMwZOQryN4s6rwag62LsSGSl5rCgXmOOM6DwxkX5Qj7ZTtvLPD?=
 =?us-ascii?Q?E53Arl2DA3QQ7tXUha5/AFF7PSMnqtUjSKROL1+NA4XUxhmFGYWqr9l3sEz+?=
 =?us-ascii?Q?BZn1qim6I+b96W2H20KhRqei184m+Cqv+ghj8Zjz1vz9CWtuILwAb/jLfwSc?=
 =?us-ascii?Q?3mBSaCkzf5XnoUvoZyWASZQmPnxxPgZ/rThHF2y7tWdftBEUHCQGDSQrFhr2?=
 =?us-ascii?Q?mTKlcB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJf/GUwik40w15NFIwHLoSEXCnyjOyPE0nqh7lbeBOZPBkAGhsAvOskcGFx3?=
 =?us-ascii?Q?JRWQ8cx6kYfZ2XKzQnhcftnTpu+053WrQCIQIgWthLpbMO0b3aCzrjaMNXJW?=
 =?us-ascii?Q?dZUXeDEShfA0VcN6EU/D51rx6eKneQDFmgRi3iBnMbbeUvgZHgbRUakTVLjo?=
 =?us-ascii?Q?qUu5Vkq/GFM8q1y+2fSAKWy5ToOFLt4m0sd1z3qTI2W3kHt3KISepEioSUd8?=
 =?us-ascii?Q?Zl7A95koaRh6N0WS2w46x1qlkQ+EKWU3a3X9llS5GolEimsGDpnraEJcL5la?=
 =?us-ascii?Q?JTeryjzApXXmwtAi4GDABNByDSS8KnCmbKHImNNyEkMvwH34rsvZJTd4ytdz?=
 =?us-ascii?Q?c6wDOz0IZculSjEn1EhVS6cxVVpiWXjxfIsRrsmUJIhjSyF+x1L2eMhar9lC?=
 =?us-ascii?Q?LQyVONUiRZ/JisySIHRFcjBpe6BwlpJw9Lz0FRelvgfoQSrNhh6US5YDge6d?=
 =?us-ascii?Q?eU30DK+YpjJnaVwYhlv3ybGFMR+RqCRC9+sMzmDCsUmyvhMnyBFZIYFfeJix?=
 =?us-ascii?Q?oW2a+tkQ2dAgLW8pt/1Ewb6CVLa5Gv6CcUnJofUUxM6frsWnA63Ppzq9htsx?=
 =?us-ascii?Q?hbC0/YSDQdViXKz84hoqxrNbnTV9c28Mhr/posHZav4sjqZjUE5Av3KStME9?=
 =?us-ascii?Q?23cmLLpRMiCh4u/It/KGn8/plE72S6oeiiJi0WOP8xUKdGyV+4FLwBpl+R/q?=
 =?us-ascii?Q?xx1vgzM5vYgcv061EBGn+URWsW/BTOeGdPcso7JinnFYsacRIrtLyVlke7Gm?=
 =?us-ascii?Q?9e/iHAQooyT69n5q3H9bknEER5C34frlwju5G/YiWisE4FNksPlPPJhoiE6V?=
 =?us-ascii?Q?rOuX5vQy+VssuJF0/8dqab8BWvuqpU0pCuhYGVL7By01qC45XRDTy9sWD9Yp?=
 =?us-ascii?Q?Ms72Mjbsef2js3zEJtHTXMVKTa4QvlvX3JLLusEqajgvIBBruviLCCPQw2L7?=
 =?us-ascii?Q?97Sdms6NuKf3zM7VoVj4cp8iBt+Ho05M9Oj7g2leBYM0VJqI03NUChXfnDXA?=
 =?us-ascii?Q?ENWP6SI9u6Uj4OBOaalR/O6lLNSpB5TShFtBDEN4X5a54GPbmcDLSwLcYVh2?=
 =?us-ascii?Q?KPoc6bZJlxO6sMMTau3q4P6lotYpgZseTov5SmgSjJmw824c6AU4jUeuD/jr?=
 =?us-ascii?Q?fUx2JmzEb77s6LMKm4xiupdVuPRUqikb+a2FD7d354scfvQ0O9ukLjc64CqN?=
 =?us-ascii?Q?XLULyizK3mXAeJBNcLxdB3UUMribWHnPWAv95L8WK0riSMzClGpIUTxDdj8C?=
 =?us-ascii?Q?S8VvuUwK3HJOqNhEcmsstiZCYwZDsMW9Xp+PWPGd3ntm4kU2Ao6URRWdWliN?=
 =?us-ascii?Q?plEVoriiEEEnZ81xnYu9VZrlu+fY43i9tzuOJDs+sEQMVgcE+c31rUWGURVg?=
 =?us-ascii?Q?jHudFcFPrTjQAkS9OxNiU4a9rm5Kbydl3Kqs/wNGuUpoKu5Vg5StwPzL4ULJ?=
 =?us-ascii?Q?kZzfD2gxM05EZ0v4+moFn0aIq9Bje9bMcXZDYbARpa7+h6SHofVyD3s4+RM1?=
 =?us-ascii?Q?F1suEejpXs39s+DpixY4qc8kpXFZJxrALilwDMNCTs/RrGdeJIT1sF25INHG?=
 =?us-ascii?Q?4Z5slqJVGwBvXDz211l7G3d/uJPhNIhwiuhTQ7ic?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bb3efd-1b1f-46bc-b0b2-08dce76a1c95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:23:31.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzbcAPtDT9wYhk/D1RQ2Ld5SPMUbvI1GM1m4flALQj2PUGyMffy+gRVcx3XNASh4iEyxVYoKUGysHdbchy7zlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606

The TJA11xx PHYs have the capability to provide 50MHz reference clock
in RMII mode and output on REF_CLK pin. Therefore, add the new property
"nxp,rmii-refclk-output" to support this feature. This property is only
available for PHYs which use nxp-c45-tja11xx driver, such as TJA1103,
TJA1104, TJA1120 and TJA1121.

---
v2 Link: https://lore.kernel.org/netdev/20240823-jersey-conducive-70863dd6fd27@spud/T/
v3 Linl: https://lore.kernel.org/imx/20240826052700.232453-1-wei.fang@nxp.com/
---

Wei Fang (2):
  dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
  net: phy: c45-tja11xx: add support for outputing RMII reference clock

 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 18 ++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c             | 29 +++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h             |  1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.34.1


