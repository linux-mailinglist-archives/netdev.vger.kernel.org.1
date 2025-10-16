Return-Path: <netdev+bounces-230004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0ABE2E55
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4A53A7CDE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1132F747;
	Thu, 16 Oct 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ic0TELhT"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9732ED4D;
	Thu, 16 Oct 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611407; cv=fail; b=u/1bP1/olm54DcVc03Kpt+c7OBYSc45R2p7/iuCf3soo5zTfz+ZW2sykuh/sYyAMgV3/GBOTiW5Q2du7qnNtJl4eYqby2q1EZu7WYgCht2K5Yc+oogJEHn1U2TuWaL/jn3Z61Ph3+/P1A3kBOUPZNKu1+7TpTwj2UtdMV/SYWKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611407; c=relaxed/simple;
	bh=vZ2FfZ4qZmdlSlFbfV0vmuTdK1PvzA/z5AKipPp585E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=li2R5qz3/RtQAmc8rMZ0oBBkww7dXQpSDAfaQgkGVbhZrhobEJUDOAfck83SdPyKnHROOEFpy9O1Kf5NWHbPe7LV3EQDhgGfOjA8fRzpbf+oxqj1k25YJJZB8kojDw0lBjaR6xE2NFvyxopybQ2m8CHMWxataW6R0ftZeMvaae4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ic0TELhT; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2diCPcBpb2BvpJS0OWgpgxnpmGMzRJXLC1Bx2cqLDd9azDIoW1S604zUNkanh2TokgdtXKtDmAxQHKwvKq+ukFIrduqGc2iLbo2X1XVzq+kpvhI7cCBqDpgiCDeqeUD6wsDpX7tQXg9Qw+emS7ZsY8yxCMyG3r9kzEcpdVb77H7vVRNN+z5pt2RWZT2AtFrkJbyj7I/vV3w6qqpw1VJjktnqptbI0/q+XjtNjEnLFJLDozU4xSMEif4t8X9EXKp7KZGbLT+jsbW0tCcfAnUAe9o1itBYK1/79p22ykPlJsZ513f70dpLYuzUB6huJ41ZjziwNSogtdrRWcNGJrKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6NVIRpByAx+GdWE3gRrHzPyH2FmwIHi9nxB72v8F/M=;
 b=HrSNsRoayztrYrXDkYEk8e7U4WM33NrYJUY2peu8qN+u0+GkfUM4qT+ZYkifCMwmB45ntCBIvRXXHoHz4QluonkKjlfNt2eGb2uH31xvcEqLIVdlqp0QPrhjmbMjkOBbSAaMh4MszrmBN5lkrTWohy2bRQP4jomCJ4iatVIcfspZpaQn0OIyW1Ao55gvO0kxRMHKSL7cwIFK+MUG7EBv/DQ0v59KPvK1EMEzHe+RCOlS5Vk8/OYEJiJnX+EeksLLMJDvVfBT0wID04MK9w2iiz5+Zi1EbWhGUqdw7s+dHjq3dCShthI9rxTTiiXO0rBP/uYTAQERwZE7Vu6HX5rOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6NVIRpByAx+GdWE3gRrHzPyH2FmwIHi9nxB72v8F/M=;
 b=ic0TELhTCLWwov+8SOWsnYOgIpoGzVaGJXqPiTAenCPQbAtb9hjhOE3CeMpI7AwdP0e3+QaVX+AxfFShW0m0gqqr00ydeo6MlOttM21JBbqvTWtS3i7ywHQDactc8hc30yvTHuQWaNr90UwZVEpdz2xiOYVUeNDUJ4dWoIUrsSNRDV/IVY5Ozhj8i3X3wUcbLgKIBpIEJ4EJJH70O6ay1RHmXpUd2ZUQE8bBZLhweFsbfXfhVRtIrbpuAjTYMJNOjdyaiYncJFmMJ/+HUhupruzbGo5gZo9DLwHwNPXNglWTi+SYNX2TqaoU+Rjdi55NlZDbcwK00Vqz+kmb7/6bnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 6/8] net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
Date: Thu, 16 Oct 2025 18:20:17 +0800
Message-Id: <20251016102020.3218579-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 38680b3e-5359-4840-8e7e-08de0ca0d3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FytgsZO2PoPc+UJrNuOrx4neWdiBqnmWS+x+pmXGd12DMHtUq2IYiD7SXUHJ?=
 =?us-ascii?Q?JCYbKFnlyrk0svyVJcu6XZyBjApwnLJK/SZc8xDBsHAP85Nbgnm9qJJcSJgF?=
 =?us-ascii?Q?57YJvG85E1HK/D586ZSMj3CQOpkJ7zl8XxvcmmtBusa8ADVYIcZo2k5vHiRP?=
 =?us-ascii?Q?6HbcPxOFi5qSUlRZux0fxvrMt8gBIZ+lg/LWBvKlTdoz8xhX2l7n21/XVfBV?=
 =?us-ascii?Q?7ToBwXlKr1ilICb4SajTaXThtfgJ9b7xWjR3MJPgL46fyDPTvLiOHLULFulb?=
 =?us-ascii?Q?2ziqTs5l3XaJWRE4icv5cNBE1iVt9A3cer7QbNP/G/pf33k3qJqq3WB20Z80?=
 =?us-ascii?Q?nSflrA1nYdoF+LZBIbaFZ5iiYAzIpTG0AmoE8ErY5LrJYW/Yark4uUMPuasY?=
 =?us-ascii?Q?PUbzkVfp3JRt0RxJ0zdu4RyA0xbCy0b5zi6FbTQTBDznawGNalMx2/y5G62A?=
 =?us-ascii?Q?GcEf8iTL7WwSDAlBQIpHCdp8FowUOcRc8XqZg/gOaKeTQgCahDpt0nEz+dWX?=
 =?us-ascii?Q?Y/oujmtyVGo9STJlBwDh+NN9XpTWFwMpRuEhDQzUh47FxY98jkteBS/flnFb?=
 =?us-ascii?Q?5ZVMh82aKl/WNdzcyKSTOvuDkaEPeShYkTHagpLSL0pcYAX1CyeUzQ8bOFfQ?=
 =?us-ascii?Q?1n6vnaZAnvF38tmxAK2JOVj7Kuzk29m6MSSG5+YBgMHne0W+rmBhP8YlCLlp?=
 =?us-ascii?Q?aWTMymGl1IDhvMw999TV9m3rw/58oy+o2l95l5hYNKkqrmGjEqYEiiJUou9n?=
 =?us-ascii?Q?fJcD6sowMX6CsnwT3ej0sgNo+59PbONYOV94GNRwmjWlQX4bYyjtUACim60B?=
 =?us-ascii?Q?AOZorXMY+bm9sU0LNdpsLEGz7VkUZbniV+rJtTBfI1BdCf6KZwH0HQkZZOfn?=
 =?us-ascii?Q?7HD6kEfU8U8ipEeOhoOHkefqhsWMqMQZeiyCBvGL0Sauwa1yk5CrjnJCH9qs?=
 =?us-ascii?Q?BzFKoQIZdEgqfWq04Se6Fx7/TO3QLSixw6ioBAvWo0BzMcGKwCKYEOYSt2XH?=
 =?us-ascii?Q?UpmVCmb4yknTRq0WRiku6sFyNHMzk7iHN8rWoCydlfMEW8iP5QxTn9QBiky2?=
 =?us-ascii?Q?6AQOXc33pyp1z/ycFlJa2nfAjiN0V56PQA49BYeM8sW6VaAD+Bmj+P+TERvy?=
 =?us-ascii?Q?g8L6dD8X0/oml+2j3lXWxjSXp9397H//BFqFoIAb1MttUVFD+0xzusDaFiKp?=
 =?us-ascii?Q?+Ot19eFmLlqma+MPUxmUjAExOahERbguhSd+9WAqJ4G0AGe5WHJQ70aQXtrB?=
 =?us-ascii?Q?J16fp6tEKThTGIgNixC6ljqn6NBoGYM0Mjvm276KrYyJEhqY3png5+iGLioN?=
 =?us-ascii?Q?F/2MfZnRmYr5fASVewfX73og3ipjFs1eNin5ydHI13j83+SuAxA+zcqA27xx?=
 =?us-ascii?Q?i374Ie8eLhJVdrwvzmjTQtNtw6s00v6ug4cOH95HMn1QJhR6FugqKbzz+MfI?=
 =?us-ascii?Q?UJj4TsQS8efou62vPU3hNO2Yaofx1+qf210Syc6ujZZB2u9fjIzBvGaTOIf/?=
 =?us-ascii?Q?0gHFlpmS5oOzEb81t8XL9pBrHTcWJIaBJ2WXJK4AE1HtvvUsFhq15LROjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgDGwluryFEqY3ETL8YykJzKpzje2+bSTYVz5w++NMEj3OfqCE2PN3w/T+x/?=
 =?us-ascii?Q?6WZ53YsegfeiNxuHRMw1BlTX1MPnugyOm5+7oj0FGyLLGUpdIlg3K5QyAcy6?=
 =?us-ascii?Q?Kc/wuZ6uygNGQC/FddXYXjyJmyyAJedikQJEhFeGHtxTLearhQr+oln/KwsX?=
 =?us-ascii?Q?oDVvux//7W9LXL4gjfdQs5Lb5PnzLRhNUmaZHUvBFrd0nAQFo7HplV9aiDzp?=
 =?us-ascii?Q?s7woxNM0RzIkPSI3UVJ+YwxVzPzq5xsP0EXaNkCh3T268cdZyC5fwIn53Agm?=
 =?us-ascii?Q?d2Bxga3v0sPlx7A20CzgT+Cg8r7glsIX2nLGroyE4XL7tmDbVZJV5jPFfBD7?=
 =?us-ascii?Q?y2SAhbjzuMCS2yfuA7Yd0+rQM4HsUjcEtQBLpCCn8nRnJguHWlVwWOs3NxED?=
 =?us-ascii?Q?+ikaoy/xlEpbjoJkJGr8ns/xb1xSArbnyQxP7G3A9d/kCgSazPW+AqMkS1WT?=
 =?us-ascii?Q?XLuKuym/ae3iPeDMtV1ibZTA366/wA504vXrVanP/ijur4o2Q9CkOXisK0VC?=
 =?us-ascii?Q?2z0JC6Oc9gjXmB5Zub0F9pL7NHB4OJ5F6yb3/Mr8G7R7yirJYZrfSDazt5VS?=
 =?us-ascii?Q?1keObMJyZjim97VXoC+7XfaYV+LCPrG+PgTd9CagXY+5MdLM+BlQbZXgvudZ?=
 =?us-ascii?Q?riL6FC9zr7mNx3wlLwOsJWYR7D+Q0tHJ/gq4XyrGH+5oeHI0suQRL9tC8Fd/?=
 =?us-ascii?Q?GLCwnim23K9JMYsDA3Mb0O1t5xJTcQqVSgXwisuXliAGD+yVaZtf05MsKWAW?=
 =?us-ascii?Q?z+Ememo2WADgfZT7H0W2uJSkWrgLgpFoRQixmWdy4r+cY4V27gLSJvZzdFTC?=
 =?us-ascii?Q?67bAl+9MDAUAAr3QvrbKSh87t50eCRQbyoQN1wLW97RJK2yzYp10bFxIWzqk?=
 =?us-ascii?Q?jZ+xQv/cGlyIEHPILXyP9jTT1EYgvpE3vozl2WA687/FerDD6BGYRMfJNW/W?=
 =?us-ascii?Q?C//vEoFrw/ZDm9/SNcMMl1t2MoalYSMVzIUb0DljjEjMxM+JdJifZu3xrN0S?=
 =?us-ascii?Q?qJPPrJvTu62DELYNyeourTBUejzSMPA3lk2FnSB29pJWqhJqOc0Yj/XMQM7D?=
 =?us-ascii?Q?Uuf2QRqSFvv3/nk6D0yVo14cUKsSA+fBy1TY4BqDeuYNz/VA1aSR2+yVnkk6?=
 =?us-ascii?Q?U2YH2nsZQybggRSYpefrKCmbb6gdZHVs1jvvWhZslPxANrewGZl36TygLfyQ?=
 =?us-ascii?Q?Ge0Po87OBebhk1KthfPtIBroTQ7DFxZw1JKct79Ara0gK/73l/WWPwh+5xqI?=
 =?us-ascii?Q?E4p6w1ZgkXXMS3+Bt5PHLSQ9bY0m7V0foTzYEiKdnkO6N+DbkhLymML4cFpe?=
 =?us-ascii?Q?JeniesZRzSWPcAbCpozNnVMnk3avKLOtK9entMYxgq4PJ6lxwyR/Wsh/FQF0?=
 =?us-ascii?Q?PjXXaK1D4faJRrPcJ+P2Pt66cN7laVfuS6ZTfFp//ER5NmonvZDNo+NNvGKA?=
 =?us-ascii?Q?cSdqez6mMIEruRIqAAKIL6uAIkAc9VAOyUa9eY0X00jI14gppaiac3kNKtMM?=
 =?us-ascii?Q?K5pw15gkkp7FeRy1BnC6AahDGLokC9LQHanoP0krDjlxaCEC8Z2pYwck1WAt?=
 =?us-ascii?Q?JK36yo4a2l0a4gcji4yhUEL+GD33VpZqdGeG6+x9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38680b3e-5359-4840-8e7e-08de0ca0d3ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:22.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB3DlSIQUe+0f31jyQOU+axWNbNCc1zNavmqjnpujSEaHJA2AU/KLfDZy/LEQ0L6Vbu+2s4tG8bLlXgTlMoWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

The ENETC with pseudo MAC is an internal port which connects to the CPU
port of the switch. The switch CPU/host ENETC is fully integrated with
the switch and does not require a back-to-back MAC, instead a light
weight "pseudo MAC" provides the delineation between switch and ENETC.
This translates to lower power (less logic and memory) and lower delay
(as there is no serialization delay across this link).

Different from the standalone ENETC which is used as the external port,
the internal ENETC has a different PCIe device ID, and it does not have
Ethernet MAC port registers, instead, it has a small number of pseudo
MAC port registers, so some features are not supported by pseudo MAC,
such as loopback, half duplex, one-step timestamping and so on. In
addition, the speed of the pseudo MAC of i.MX94 is 2.68Gbps.

Therefore, the configuration of this internal ENETC is also somewhat
different from that of the standalone ENETC. So add the basic support
for ENETC with pseudo MAC. More supports will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 24 +++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 +++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 32 +++++++++-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 37 ++++++-----
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 61 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         |  5 +-
 7 files changed, 145 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aae462a0cf5a..88eeb0f51d41 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -14,12 +14,21 @@
 
 u32 enetc_port_mac_rd(struct enetc_si *si, u32 reg)
 {
+	/* ENETC with pseudo MAC does not have Ethernet MAC
+	 * port registers.
+	 */
+	if (enetc_is_pseudo_mac(si))
+		return 0;
+
 	return enetc_port_rd(&si->hw, reg);
 }
 EXPORT_SYMBOL_GPL(enetc_port_mac_rd);
 
 void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val)
 {
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	enetc_port_wr(&si->hw, reg, val);
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc_port_wr(&si->hw, reg + si->drvdata->pmac_offset, val);
@@ -3350,7 +3359,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		if (!enetc_si_is_pf(priv->si))
+		if (!enetc_si_is_pf(priv->si) ||
+		    enetc_is_pseudo_mac(priv->si))
 			return -EOPNOTSUPP;
 
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
@@ -3691,6 +3701,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_ppm_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc4_ppm_ethtool_ops,
+};
+
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.max_frags = ENETC_MAX_SKB_FRAGS,
@@ -3710,6 +3727,11 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{
+	  .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PPM_DEV_ID,
+	  .data = &enetc4_ppm_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0ec010a7d640..a202dbd4b40a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -273,6 +273,7 @@ enum enetc_errata {
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
 #define ENETC_SI_F_LSO	BIT(3)
+#define ENETC_SI_F_PPM	BIT(4) /* pseudo MAC */
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -362,6 +363,11 @@ static inline int enetc_pf_to_port(struct pci_dev *pf_pdev)
 	}
 }
 
+static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
+{
+	return si->hw_features & ENETC_SI_F_PPM;
+}
+
 #define ENETC_MAX_NUM_TXQS	8
 #define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
@@ -534,6 +540,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 extern const struct ethtool_ops enetc_pf_ethtool_ops;
 extern const struct ethtool_ops enetc4_pf_ethtool_ops;
 extern const struct ethtool_ops enetc_vf_ethtool_ops;
+extern const struct ethtool_ops enetc4_ppm_ethtool_ops;
+
 void enetc_set_ethtool_ops(struct net_device *ndev);
 void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 19bf0e89cdc2..7f1276edcff0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -11,6 +11,7 @@
 
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
+#define NXP_ENETC_PPM_DEV_ID		0xe110
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
@@ -115,13 +116,17 @@
 #define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
+/* Port capability register */
+#define ENETC4_PCAPR			0x4000
+#define  PCAPR_LINK_TYPE		BIT(4)
+
 /* Port configuration register */
 #define ENETC4_PCR			0x4010
 #define  PCR_HDR_FMT			BIT(0)
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(speed)		((speed) / 10 - 1)
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
@@ -193,4 +198,29 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/**********************ENETC Pseudo MAC port registers************************/
+/* Port pseudo MAC receive octets counter (64-bit) */
+#define ENETC4_PPMROCR			0x5080
+
+/* Port pseudo MAC receive unicast frame counter register (64-bit) */
+#define ENETC4_PPMRUFCR			0x5088
+
+/* Port pseudo MAC receive multicast frame counter register (64-bit) */
+#define ENETC4_PPMRMFCR			0x5090
+
+/* Port pseudo MAC receive broadcast frame counter register (64-bit) */
+#define ENETC4_PPMRBFCR			0x5098
+
+/* Port pseudo MAC transmit octets counter (64-bit) */
+#define ENETC4_PPMTOCR			0x50c0
+
+/* Port pseudo MAC transmit unicast frame counter register (64-bit) */
+#define ENETC4_PPMTUFCR			0x50c8
+
+/* Port pseudo MAC transmit multicast frame counter register (64-bit) */
+#define ENETC4_PPMTMFCR			0x50d0
+
+/* Port pseudo MAC transmit broadcast frame counter register (64-bit) */
+#define ENETC4_PPMTBFCR			0x50d8
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 82c443b28b15..5de6b7b46c06 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -41,6 +41,16 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
+static void enetc4_get_psi_hw_features(struct enetc_si *si)
+{
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PCAPR);
+	if (val & PCAPR_LINK_TYPE)
+		si->hw_features |= ENETC_SI_F_PPM;
+}
+
 static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
 					 const u8 *addr)
 {
@@ -277,6 +287,7 @@ static int enetc4_pf_struct_init(struct enetc_si *si)
 	pf->ops = &enetc4_pf_ops;
 
 	enetc4_get_port_caps(pf);
+	enetc4_get_psi_hw_features(si);
 
 	return 0;
 }
@@ -589,6 +600,9 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
 	val &= ~(PM_IF_MODE_IFMODE | PM_IF_MODE_ENA);
 
@@ -635,28 +649,10 @@ static void enetc4_pl_mac_config(struct phylink_config *config, unsigned int mod
 
 static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 {
-	u32 old_speed = priv->speed;
-	u32 val;
-
-	if (speed == old_speed)
-		return;
-
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
+	u32 val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
 
 	priv->speed = speed;
+	val = u32_replace_bits(val, PCR_PSPEED_VAL(speed), PCR_PSPEED);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
 }
 
@@ -1071,6 +1067,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc4_pf_id_table[] = {
 	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PF_DEV_ID) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PPM_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc4_pf_id_table);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71d052de669a..5ef2c5f3ff8f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -435,6 +435,48 @@ static void enetc_get_eth_mac_stats(struct net_device *ndev,
 	}
 }
 
+static void enetc_ppm_mac_stats(struct enetc_si *si,
+				struct ethtool_eth_mac_stats *s)
+{
+	struct enetc_hw *hw = &si->hw;
+	u64 rufcr, rmfcr, rbfcr;
+	u64 tufcr, tmfcr, tbfcr;
+
+	rufcr = enetc_port_rd64(hw, ENETC4_PPMRUFCR);
+	rmfcr = enetc_port_rd64(hw, ENETC4_PPMRMFCR);
+	rbfcr = enetc_port_rd64(hw, ENETC4_PPMRBFCR);
+
+	tufcr = enetc_port_rd64(hw, ENETC4_PPMTUFCR);
+	tmfcr = enetc_port_rd64(hw, ENETC4_PPMTMFCR);
+	tbfcr = enetc_port_rd64(hw, ENETC4_PPMTBFCR);
+
+	s->FramesTransmittedOK = tufcr + tmfcr + tbfcr;
+	s->FramesReceivedOK = rufcr + rmfcr + rbfcr;
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC4_PPMTOCR);
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC4_PPMROCR);
+	s->MulticastFramesXmittedOK = tmfcr;
+	s->BroadcastFramesXmittedOK = tbfcr;
+	s->MulticastFramesReceivedOK = rmfcr;
+	s->BroadcastFramesReceivedOK = rbfcr;
+}
+
+static void enetc_ppm_get_eth_mac_stats(struct net_device *ndev,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		enetc_ppm_mac_stats(priv->si, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
+
 static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 				     struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
@@ -1313,6 +1355,25 @@ const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_mm_stats = enetc_get_mm_stats,
 };
 
+const struct ethtool_ops enetc4_ppm_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_eth_mac_stats = enetc_ppm_get_eth_mac_stats,
+	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rxfh_key_size = enetc_get_rxfh_key_size,
+	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
+	.get_rxfh = enetc_get_rxfh,
+	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ringparam = enetc_get_ringparam,
+	.get_coalesce = enetc_get_coalesce,
+	.set_coalesce = enetc_set_coalesce,
+	.get_link_ksettings = enetc_get_link_ksettings,
+	.set_link_ksettings = enetc_set_link_ksettings,
+	.get_link = ethtool_op_get_link,
+};
+
 const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 377c96325814..7b882b8921fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -378,6 +378,7 @@ enum enetc_bdr_type {TX, RX};
 #define EIPBRR0_REVISION	GENMASK(15, 0)
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
+#define ENETC_REV_4_3		0x0403
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index edf14a95cab7..9c634205e2a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -109,7 +109,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_VLAN_CTAG_FILTER |
 			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
 			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
@@ -133,6 +133,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (!enetc_is_pseudo_mac(si))
+		ndev->hw_features |= NETIF_F_LOOPBACK;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si))
 		goto end;
-- 
2.34.1


