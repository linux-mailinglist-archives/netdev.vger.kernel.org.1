Return-Path: <netdev+bounces-218574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A775DB3D535
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5EB4E053A
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F078222590;
	Sun, 31 Aug 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GG5EvhlS"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1114A32;
	Sun, 31 Aug 2025 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756674988; cv=fail; b=VNEOEc9Gii6u2PdVpvxOxKSVtRWjUcUT6A409Ahu+e31COgBBOQNK57hiS/t8e0Aj0riPvFi7tMLveyBgjiaOvbkjjIf8PI3e57M136vAAthvqoh6CtEMYDA9BM1B/RbJF9lz9jc3BTV86Xy1nyG72BaI/j3GFNRDVll0eL4kGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756674988; c=relaxed/simple;
	bh=fq8CHDSWJ2u4pXHJ700msqQhMpmFpFER9gsnxpGZaMw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rGGZEqop+0Lz8q09EkA8myZ7o9pknuTTD23J9kgZt7r/aVmzStrHXJIFiQQ48CzTRZbMC7kNXWH2Sl7dM51brUJK8Er2rph1Fu7Tmg53tuGbSUv0Egb7+lCYMuHZgbma+r+HJ3onAnsY2mIEKkCKvAaVzjWfZoutyuou4lY2O/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GG5EvhlS; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl/5H6ucC8n0rTUMyHaqaIFZuAktc1DX1ILDt+zu66RLpliymeSkXmWr/sG91v05DqJUUPcVmWJv31BiCnLM2nI/ohMm9BAsR7gClTDkbIOjVYKa6i7OYxPDRQ1EziLSieHuwi8MCE2uuH+9epk55si9ASgVAoli1pOJOefDFvHaHLZm8e1YQuJqGYK0oQviNaoqM9VYh6ABgWUcxNerSJ7QCcuR244ZA9sAQAtG6SjedDmK4DduY3woQ5TfC3ZTL44vuboQj4HCk85Z163CozgRZ2INoNXIvvr39WtQ1NbCf1umbT3wgn1CWTMqY0RIcSZvJCVBVOxdPm9M4ymbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yogsb1EHi9HEdZPbLjpB1s/RAabCPDYbdPBSxAZto5g=;
 b=JrAg2kTs1koUpWaVPseiegaChjZW1MtsJ6GNr2rNEWrkTrHWIN880OD0Mg2R5hbi292lC74ccfwPKRnilalR892sD9Y/4BXGzgV8zMv982tt3Z+Dtuwx+C0arVO6IoVmuCfM58O4wZ2yQqfJ5UoAgHLdfDw5D7Z0x4PLWhQiuzXIKPalI/n/e+vJKtw8v9Z9MI1rUVfx4a2wrDy3Sx7/xoIhO/TEKIjMIPtR5AJaeMqSsNaulnn5o3jRWY1SAAUSewLgX4jtylOkgwGUZw+JbJQRbxatmYYt5Z0FREaFihx+h2KTpwiEuIcpXZqVmgfQid+xZfhAUFrZb8q+8zl83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yogsb1EHi9HEdZPbLjpB1s/RAabCPDYbdPBSxAZto5g=;
 b=GG5EvhlS89izTevsy86s0Nw5HHLO3Lq4G8s9C5fPjXOSfqs0iLe1nF7GskddWT6gBc7ctazFehoTSZtSCTz7H2cwW331iXuLmVMi5U917JrRWTyeGqJTFdKCGXr9/CT2e27hWtDFwoEC1BDTQOp8AQW4ZnYAfa/+2rJ5NgNBlXiPnEAU3KcxyuzleSD86SIZgu3Q/K0cjpyDXhoOMaenRNQyzPnLnY6/KqZEfcs+CAgWBv4BHpreE6Qeh6bzNYXRqEE2ith+8Z11DAP7v/LrNb9p53+IUhzO/vZvMRUuLtJ9Y9QNbRuiPk6hhi7CgcRF7yx4DtGabWNP/sd5b2QUGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:23 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:23 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v4 net-next 0/5] net: fec: add the Jumbo frame support
Date: Sun, 31 Aug 2025 16:15:52 -0500
Message-ID: <20250831211557.190141-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d3d7d0-412d-42fb-dd7d-08dde8d3a330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6I3+wLQnKgc8ANCCsqC+3B4ZgGdJHQ6FWbm3OpLZtCBBCk2mTPDDTqdqbQU?=
 =?us-ascii?Q?8vq+hq5kuLQM59U0O1U+UZMNwtxH1ecztMXs32+dExsxndo4iCgMFtOKPqZj?=
 =?us-ascii?Q?ex1bA/VbeN1yuCV6TmckgOGfy0MGk4AK5BzQr3oj2/f7uF3nFRjCEGjE6e8z?=
 =?us-ascii?Q?FbHCAzZ5R/F6l0DMvPRX6XTcr6IFW5Ci9RBoZ36KsrdntsOTQ6Y9ZFuUTupd?=
 =?us-ascii?Q?iX3Xh86qgv2tSApSHktqPZ0LprUqm6khfMb6gd9fKcdZe2gqiM9loHiWOrQr?=
 =?us-ascii?Q?RjV4Iib3EEr06egfVgirXW3NL6KLYauFTo3IBlVsiit3gYBP61EOzpYxt3mH?=
 =?us-ascii?Q?+jIA3C/Ib5yOtslkb5vfsJz8oorLQv9vNzs0AIPi2uJ9+xumKBFuVozc8Laa?=
 =?us-ascii?Q?ak1NoZpAcvg3btccb3uSj4N2l+cP6UIAbcXhsl3SyLVz9FAKpYUkvfBy+sSm?=
 =?us-ascii?Q?mXcirlPk7iVtCk/c3H3i9G+qoSsooJmeU4CsaNcpY5vY4z4GOEJFvL8SeU8B?=
 =?us-ascii?Q?KSkqgfbAuEJHYwYWOZv9uDYTs4n0dHGNfvyngpMmWMwRGzloHJ9Xig3Mt2Vz?=
 =?us-ascii?Q?9C5mBrYGvmu8Qo94N+8gCRU4DpCpCGI5k28Qz+S0q3WmhJ4IwZPplqRbCcay?=
 =?us-ascii?Q?CVtkcoWWINKX2yZQswE08UlfayDKHFUj6c6xBEqBfIT+LODdStp4/7vsr46P?=
 =?us-ascii?Q?sMzhXl0YjAnp8ncPSyUic154JXUfHfuvKT+pQAEMDZrViY+RrLcafnUbYjXf?=
 =?us-ascii?Q?jYzUjhbUFJ+9Ehe6egX/1DuaSpAsUjiRTLUgXZooAPJ5e1NyN0O88t0dH2SP?=
 =?us-ascii?Q?ynlyPrz3WyoCVBbO1a36RE6GenODeiYdbAnzh7YBivZtkO0/5oaCvWigDkFV?=
 =?us-ascii?Q?tm730acUqbdHODFyvGQ0EKYT46FFoZs1FKIXMWGQHES05shaO6JqnJRPlH1I?=
 =?us-ascii?Q?i9zgtMQi93cPrfzxqQ6p+EktXft+XD3Jl0p9gD9dqc3rvOFYQZ84hMmORts9?=
 =?us-ascii?Q?ETA3IqGRyU6sePY2D87y2bMMwRaVuCOmVNhfZoBltJZ2UZ1NqfR09qruVhl9?=
 =?us-ascii?Q?GrPukWPiNATC7PN1mP/XplghDa6QizJ3acmR9R8xKiwErP5azB4yINinEQgS?=
 =?us-ascii?Q?h6dbkodmPZn6bSWksSe21jS4/hrGis0tMfiSIyFQpkV+NKRBOXgJiEBFDnIV?=
 =?us-ascii?Q?HJYRQIi88Zxg+DkXIQ1qsTSk1QLuNcLtnodbqDLWw/bxPrdXkL3q4yPibXyK?=
 =?us-ascii?Q?8Qxb0luWaed2Dok9+Su/4MhlFyjXjNPKHYtuK5rQkV9wRmwxnv+OtsvvL6xW?=
 =?us-ascii?Q?TXbAwsqp5p9YuI/auxjnwFewUHnjdFf/qsMwxF/5c4dCkBoEfinBgXP9ZVcS?=
 =?us-ascii?Q?ZkQlfW+Y1tnf/3rhMg3FL4G3LGq0O8SIoHjvuAQSOOlKJ5uYkMo7lylW+0eX?=
 =?us-ascii?Q?27yIPJ0jX25Fk7agRgKEGSFCIAE1X1o31stBdBHsqKd6Z1lj1oVjyuAVg7Fq?=
 =?us-ascii?Q?MfPKx+UoItw2Mj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcf1kiWoZP/WC9Th/2Ne1yEK0F9VqlmUFA73GEbb+HDMoiD6f+gsPZbVlL/8?=
 =?us-ascii?Q?4uZqTrtil3ocnuYk9OxHAwduhrjlKfLT3KicITxiUvmjenbLkANun8AldUWx?=
 =?us-ascii?Q?GBI7ZZIwokKh4+nReNIB99I338PNnuamPSzSGDtiIGkxTosc1wsT2It/7+km?=
 =?us-ascii?Q?tU/tHbSeXFZ37U1q0kGOhcFX5r/49q6LJHDZAPZMobDK+Sy5XBYFG1kbf/WP?=
 =?us-ascii?Q?S0CSdb4h4iz2iMlpbcdHoz/uLWO8vAI5LrmliTR15m8I/rNvM7S7LIu+2EqD?=
 =?us-ascii?Q?IR7QpfsOzNA1xXnR1Qdf5SPX02DrdV3PX63MFRKr5D4phkBwo7tdk4/cTzlR?=
 =?us-ascii?Q?7WOTdrq22bMcRiyYWQM/aFCwTMR82k3Mu6HORUVClU+CxLEbfT/DfCeN+X4m?=
 =?us-ascii?Q?3uOzc7mbukwxLu1kksRaDE/NHa/EDUEPbmLsdPvApcI5Q3Bxj+rvaHBPNMC2?=
 =?us-ascii?Q?qemlbcEDbKX6P3Fs/MvPswcxvwqUeJUpqTzXaVBFdI83ce9EB0Vpk9dgqaRW?=
 =?us-ascii?Q?b5NdQv42582D21Mr66O1pJ29cvN2nggBFFI9T3Zm1y8tTMfWxPhmnQaameBe?=
 =?us-ascii?Q?R9AvzBpdwv2csm2IlObeuMMqtAJxROTzpV8wyQO2fZEWyA20nW077iPu1adY?=
 =?us-ascii?Q?8v4A9Mhf7M3SxJzNVLQ/c7XroSM6SaBVxb+k6ka5NDNveYMxVQMWMuP45Pnm?=
 =?us-ascii?Q?3k6ZotDjfjyqcAI2V6GuGkPCtzDR9C7brj4w1TGgR3q42gzuk/y+1K5Rc0Ln?=
 =?us-ascii?Q?PoiebzHbgjAOGmqvugmcDBAG6Ne1Xg12a+b9PgUiKpiAT1cj4UOL2wEQN6s3?=
 =?us-ascii?Q?OLUKWYQ+H6ML+D1yZVCJoQBK1m7EgGvYk8mHMbpdvGhAc1jZMErBRJ/iJUrO?=
 =?us-ascii?Q?pvqcUv1yA8Q6cdTJmkWPzfFHh9fCkc9s/rMTMOtkPqcnvYbV2PV7lSX6tTmv?=
 =?us-ascii?Q?8rcFK4vwHJQZzJC6sglY7zh20aMqrtAltLueKz5DzQuRjVwV6ytZbb6J7Twh?=
 =?us-ascii?Q?SNGmfWOotvs1/VYCxmq9moFVwoXUlhNi9KwUqBl7PfwkS5G3juLHOI5YaN4c?=
 =?us-ascii?Q?4VDJ+U00L9B9ssKYkeP0gYM33ThUNZDzbQBSi9wmYxa+nShy/bu0y8ppMgYJ?=
 =?us-ascii?Q?1IyLZ0BykJ5wKhHKnIxiK7q4GO0I7d8OWx5q2ebUy2WJUbEZ8al5b0KxVrMs?=
 =?us-ascii?Q?bqyaOOQBOArQlHYwn66pb4hZizvBYSnMa5YAoDpErrOvEBnQEGFXbzD8/Wld?=
 =?us-ascii?Q?42jUopb9+VqRmOtS26a/IbwBWAZQesCdZEQDnUJdS/TagN9OoqJPr5epuCDJ?=
 =?us-ascii?Q?he6Vv7J4dI9wm8pbF6dJNg2NA19hMEKMSVtqBp3gR5AWG9uJEf5puG0QsJFt?=
 =?us-ascii?Q?eBqLHUf11b8CMYRp5H93PowlSIOccMg8W+Tj7bfC3GYIBMQjb/d7XX90AtX2?=
 =?us-ascii?Q?LeGhHlS+hpms7il20+7gPnPyZxG3o4+tPjvmFRaBsL2iooc0NZU7nWLC+G76?=
 =?us-ascii?Q?XZQ2tyV94umgS2q99kQvbQDXWG+TIq4xdmpO6e8kBaSAnGlfy1fqNDaq3Jgn?=
 =?us-ascii?Q?CRPOxkkPAB6F9iLQRlpKuYFKm078LGpzcjNQOZ9A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d3d7d0-412d-42fb-dd7d-08dde8d3a330
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:23.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RnSKy7dTqJDgheb09pa83YapXeBCkthibvbdTGcCzHXhAm22RZx23jVJBSuGLOOoveLFiKAE+Tc0n4hAFcV9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

Changes in v4:
 - configure the MAX_FL according to the MTU value, and correct the
   comments for patch #3.
 - in change_mtu function, revert to original setting when buffer
   allocation fails in patch #4
 - only enable the FIFO cut-through mode when mtu greater than
   (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)

Changes in v3:
 - modify the OPT_FRAME_SIZE definition and drop the condition logic
 - address the review comments from Wei Fang

Changes in v2:
 - split the v1 patch per Andrew's feedback.

Shenwei Wang (5):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  net: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      |  6 ++
 drivers/net/ethernet/freescale/fec_main.c | 96 ++++++++++++++++++++---
 2 files changed, 91 insertions(+), 11 deletions(-)

--
2.43.0


