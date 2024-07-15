Return-Path: <netdev+bounces-111599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7E931B47
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4B01F21D08
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7755136E09;
	Mon, 15 Jul 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nt4oNfcI"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69157F510
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073326; cv=fail; b=uTuZPx2kRPvhO92MJhrHiJU70RObQIft7zzhajjviUxcUskd37p0CrxRT8+XsRmmdfEoum/8Fu0VJbbR3DdY0TcAoH5WjrOdw8rZxODNAojoeDxl26Dtk+ss3kTdVLlplMEy1Hn26e2fuja/57QJvRpl/HuywlHl2bkh9h3NH2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073326; c=relaxed/simple;
	bh=rSy110d/0of+oYDUW652sT/zG/NPF1+MT0AFyUFymck=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=emwYNgqvj09KJ8TOXsgOTkdpRuuqkKZDDJ9YsJG3FU57UjXB5vPJkeLbEvbNlPpYRN5ihsgt/h+5+bH9iez/6lF1rgrMNT4QRlKxYeLnzPhnhE7f/SecRYk5bcWbu8Zs+evNsa1nc+qsfXoi34Eeq5E5zbDb0MGkwlV4vmWO1Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nt4oNfcI; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDkZ8ionebtIDGYl4fcgLYgtYzZVTkw1chbnoFX1A8eZwqEAPAxNLO+0xDbV1FkbCb7VoPfFEtOuXFhhDjh9F2jFvQBDRXF3XYs5DE3qZPoEAa6rzFv+hN+w6jSG3zldn8crfjj7kDmVPSD5lDiWLq8HtGR5QDbApI+rt/TaYglBDvkk0GiDqLIleBNOf1SCoWY72nXAFpgwhFMIYH4m4zmc010/CWPbbyFc10JSV6M9kNvrJFOrP0ZUdS1378EzK92kyvGXwKjch8wfVac3fQLas/uo7hb9k4CaVd1O/ZlkoyZJEB3gRJAnKY1bMo2NAti6ygIC9Cc9lJPvetV+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epuT8TrFvCsr+63asyJiznq2A9PdRx7lF1vKhE7OIv8=;
 b=jAY5iCPPCXbXpYYBKW+3iTqug3NJg8ZiPVu/Q9PMrDfFmRxfjKmj33KlPfrryROYDwGN2gUWJknmKXXMdSyHRuAiMy71j7Q86HFh/KqCCAvC3y6E/i3e93hLzjXcaEwknWammktbijGC8b89lvJLYrn7mDRFL6mhhyb+9t3Lvnscy9zSRtPirRKLNXie8LEKHU/HDy1IcLUu6tnrHrsJgydyjYpuWLKmjmdlsx+XQLXCrXFbXysfBJxldJ9hILxSF/lba1yj1VFYTZDGxuVO6zMS3usEM3N9H/hF+4feQWI+gXKaqLFB0NRJO/kBune69Kgo09xs6Pj5dvBJUDjkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epuT8TrFvCsr+63asyJiznq2A9PdRx7lF1vKhE7OIv8=;
 b=Nt4oNfcIunJ1oEQVE6GPzaw8prsfvgM4S8a901sZZR6ZYBWt98/nIx9hXfef91ZqVXYNatiX3nKb9QzH3RDIJG1ix9OUp2peCZShAv4y6ku+CTqSBhRe5jMwUYpo61FCHmLAGBZvqeHz2vfLLGRmP9xCdj8lTM4mExhJCbFMWtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 19:55:20 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 19:55:20 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH net-next] net: fec: Enable SOC specific rx-usecs coalescence default setting
Date: Mon, 15 Jul 2024 14:54:49 -0500
Message-Id: <20240715195449.244268-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM8PR04MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0da6c8-080e-4b70-4c4a-08dca5080e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JZ9iTGNs2vAyS2V40YOSequT84uIVZoUk89HZaMKF1aXVsaKAZ0ZnPUt0RC?=
 =?us-ascii?Q?6AFxhfaEWc1JR96CbxYLLKhu/TyWS+LUb8oz9RrdoDNIJYNHuDeEfFQhFgxu?=
 =?us-ascii?Q?RkDKKNr3CodCV+Sh01NjpM3D0zuTXxSDXcMwqHT+Y0EmXs0qjq/ozwn9cY+x?=
 =?us-ascii?Q?6dNir4vy7EOfd7zzsDRdFIrINQoorV65H/2IjdGelPpUSI7gZkcfJqyf9Zev?=
 =?us-ascii?Q?0JahdDul5YGZwh8oGsYgdMtTxDLk/r4CgqcKj/3Wli+zcYPUd7FZ4+sMqLHR?=
 =?us-ascii?Q?KA58GRy2iW3/QsTNXaSKnKUIy/OoGFguOKM+gYhG6oiyzE6oQRYn3/xtoLfS?=
 =?us-ascii?Q?ZlJJptCPCMy5HdybMpoo0n9Vl2p/Do9KU1rQkw/Xg4iefzj0ZijwK/O83ynR?=
 =?us-ascii?Q?0z1wnx6SszUHUwHUaHToOWrczsIlKEUQ3V3gYgknx9Q7mU/Lz/RwxLCe5FJ2?=
 =?us-ascii?Q?GVZSNyl1R2PyTKoQcyKQfXrsBAr3i7fBLJD7m81dsc5LGGxXIA6X8iKDeudn?=
 =?us-ascii?Q?O+pmPULoaszjqdisPGDemH+zcjBMODJxpAkjm7NJLNvEOOAsEKiKHWN/bL4f?=
 =?us-ascii?Q?RfAdz4t2FBOUBJFL7GcFFEVseCYrvi6LC8Rd71A1AuruHewXmA+kDsZY7aLo?=
 =?us-ascii?Q?bDLrGDYiLbZBWyaUBTomaPMcwBmSplFVNKfGScFRcIIprxaxPpt6WtAhfg3U?=
 =?us-ascii?Q?8iM2vy3jyb7lLVon7Xbf/aeHSj3Dukf2+J0puNRTTE3+2/DJM8CHd3YP83Dk?=
 =?us-ascii?Q?RPSWK9XqEJE0YHnrATyNvXUDR5/6UthHRDx4RgpISVUu3PPaj/0+WsWdmebC?=
 =?us-ascii?Q?cwiqYXkAWO1mbOmRdcegLQOsrwQRaDl8rieW7p5NJoM+fiCj9AHVacVLprJh?=
 =?us-ascii?Q?A6r2CXmo5adxlCmnNDVYVfFv7heLzAfJk4lqUi2yRabt1UHFc/02Iztxq6OV?=
 =?us-ascii?Q?PVeYfFyG3guVVnXLnOPsMdZhrlHULB1gk7gWQVEigJDgIRoODLxtP25DaM2O?=
 =?us-ascii?Q?1GYuQoZ8Qwm/EBaB6CTXhkgggxr4Ir2aIviAVSDGUcRE84PECJcOhz+E9ReS?=
 =?us-ascii?Q?6tIfcfLUZMDNDgdNJhhwliz5DygXVxjP93mpvqDV6k4zlnlHcVSZiZvk7E04?=
 =?us-ascii?Q?1Ks95nHYcRk4xGXGsTjRY3AdwnD5D1rCTGnrzpG2WIb1OQ6SoDu6+ofOHNcG?=
 =?us-ascii?Q?fhTuept1zG7dxKokrc+gZ21M/b2gIXWJE2xxMjCMg/mz5W4gy5E2I/gE0IDY?=
 =?us-ascii?Q?9LtrTclcwFhPitgYV47oo6hVaFbPdjQKgHmI2b2s6f8XbfZpJR50R5uJgu7L?=
 =?us-ascii?Q?TAMF6MmAZ4Why5Pd0vyoB0mP25Sl4R61Cot1O7gJWKkUlkHrRa8XoEaC6LYT?=
 =?us-ascii?Q?hLYYHU4LmsObrpU4YO6CJTJaLPxq5Ojq/pgHOqPDwhb5jDqU6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgvtrK8lnRluAZBzOxoKCgkaU4OS/QqZndcuVMWhYU6R57yPgMIzCYomS8Ex?=
 =?us-ascii?Q?fJ/01UOeOJn2wwy1wbbpRRRX14hMb6tKQz45lA3xEXByzvNJjXZPu/nuwuN7?=
 =?us-ascii?Q?eqBH/YnGMFBDpx1+7E45kc3A1EPstKGLn2qwwsly485nrKqDruYmU3EhHQSn?=
 =?us-ascii?Q?IE5I97eBfx7k4IMePYSY3qQw3h7kFyHcxnw4R8Bj0c/KuLEAe+oRXIwLswbx?=
 =?us-ascii?Q?eW24WZPej55BLpeEPBEzaSmTAexzkhWMP4uIwFs7oWPa2/Gtdd962Y1ut7wA?=
 =?us-ascii?Q?p++T2VJaWJ0W9sq9I80+SpXw2gyP7M+VAw2vazJ8d/6ivC/2SwutXY5Oc2O8?=
 =?us-ascii?Q?h4UjW7nmu1UchM3wEYz/xIV6EVJS0aaSMeAfp7hdFf2oPzM5WucUMc94qpLY?=
 =?us-ascii?Q?pX14LEKoT7z8zlOJq36h8GDlz4YVaUc0sbAbRnuAQAw/TBWxKdn604U2EQIJ?=
 =?us-ascii?Q?X+fybbbDgripFVcEwNZvP1TWqXoKt3q5qXk2TXCNyXT8uQEy+oQAazinBy08?=
 =?us-ascii?Q?/yPopE1Uf8XLozx+wmb2pie7haWxBXKrPH8abEbIbzqjlnHl1ySI18UZz6Re?=
 =?us-ascii?Q?OvLX7JVPGxyZf9plMVpXGU1jXz/K8BmhmoDjJ4cNLvI07NBVgrdriBLdV2V4?=
 =?us-ascii?Q?hdGzidEJyY6wh8nO+4l7PT+W8WeRFwAD58sRo93aiykTgETcRcPd+EfkfPy9?=
 =?us-ascii?Q?wMMdUKV/VyPQPSMiv9pZC4wJMrSDMajC32C68I5cjwbRJEi1PnyP4sEuSq49?=
 =?us-ascii?Q?oo5EvwtdolvrldDvpfAKq3L9nl1LcoEd9yyQV/kfZv66bBpfohsmBEUSu0wR?=
 =?us-ascii?Q?GyebiGXbysguQIdqHPRMaP36aSRjUDRNbQY/JplyhNCjeSOyvdBbS9lmH/mH?=
 =?us-ascii?Q?w02cqmnTbuGq+0vGH/A3MPNzRYk+K6u1nKtUoJHq+9uSy+LA9YPfOQDMoND6?=
 =?us-ascii?Q?pTk2l6ZKq7n8z4KeIt9BB1DEYrcHmbUGm0D8+MwsY5BUkY3b4t1aCZbt3Oy6?=
 =?us-ascii?Q?PaaBR8uYJiDKA8EFwH2krZP7IhV4BSI6RONKAQBp/rVAqDx7LWjvpr3OKIZW?=
 =?us-ascii?Q?qPwdCX37Pr2qNL566xjJZeDVQZ+4RU5mLxrwcqebgrjvwXq3uJ1lySSv/oUu?=
 =?us-ascii?Q?rD5jk4y843buZQ6Umqb5Mu6Xu8VL/wmfWI2MD32a764qllLaxrXkeJAqclWJ?=
 =?us-ascii?Q?kH+BIit16UA6AEtxB0I6zOunfW4uBcW2QcpazBQ3lSRpWFSZY4Y5+qh80XJA?=
 =?us-ascii?Q?kLF4e5I3hj/FFk19anhrnaK6BjEBhDeXpXdutx5g11YfthqEQxSWLhRfl3Ot?=
 =?us-ascii?Q?vf/7s9ANzqPv6GKBb+nuhUnYUkUbQBquKl8/u2K3Ki24LnnF0XQ0wKA5M2gw?=
 =?us-ascii?Q?cJwzzTbLYj85KNXQrWDdhNjL1Lbm8Tn1sv+Sp/1mYQQF6oIHWIOp77vLX1+a?=
 =?us-ascii?Q?MLYyq3F2rll3OHZaYUsdb0TYUAch4pjvQkkMv4QZ2b8LpBGq378vvb2vUQiN?=
 =?us-ascii?Q?hIXlucPDQP1kJsWbh4JaRENl3ebJq9PR0B+xld48ICVttgQpUcK8S/OqUlZR?=
 =?us-ascii?Q?jSWd4VrAZKll8e1BHtypqfN3LwJeclASOKKlvu/s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0da6c8-080e-4b70-4c4a-08dca5080e91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 19:55:20.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eS4L3GyGl85QIj0MhVLh4sLvXoz1wfk1RuhAGYzuwr0l1oFmYCJJWZW3lXrYKPBXe6dCK+q3OwzXwaBs9Tm16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

The current FEC driver uses a single default rx-usecs coalescence setting
across all SoCs. This approach leads to suboptimal latency on newer, high
performance SoCs such as i.MX8QM and i.MX8M.

For example, the following are the ping result on a i.MX8QXP board:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms

The current default rx-usecs value of 1000us was originally optimized for
CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
generations, CPU performance is no longer a limiting factor. Consequently,
the rx-usecs value should be reduced to enhance receive latency.

The following are the ping result with the 100us setting:

$ ping 192.168.0.195
PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms

Fixes: df727d4547de ("net: fec: don't reset irq coalesce settings to defaults on "ip link up"")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fb19295529a2..820122899691 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -99,6 +99,7 @@ static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};
 
 struct fec_devinfo {
 	u32 quirks;
+	unsigned int rx_time_itr;
 };
 
 static const struct fec_devinfo fec_imx25_info = {
@@ -159,6 +160,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_HAS_EEE | FEC_QUIRK_WAKEUP_FROM_INT2 |
 		  FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };
 
 static const struct fec_devinfo fec_imx8qm_info = {
@@ -169,6 +171,7 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
 		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+	.rx_time_itr = 100,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -4027,8 +4030,9 @@ static int fec_enet_init(struct net_device *ndev)
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
 	fep->tx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
-	fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;
 	fep->tx_time_itr = FEC_ITR_ICTT_DEFAULT;
+	if (fep->rx_time_itr == 0)
+		fep->rx_time_itr = FEC_ITR_ICTT_DEFAULT;
 
 	/* Check mask of the streaming and coherent API */
 	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
@@ -4325,8 +4329,10 @@ fec_probe(struct platform_device *pdev)
 	dev_info = device_get_match_data(&pdev->dev);
 	if (!dev_info)
 		dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
-	if (dev_info)
+	if (dev_info) {
 		fep->quirks = dev_info->quirks;
+		fep->rx_time_itr = dev_info->rx_time_itr;
+	}
 
 	fep->netdev = ndev;
 	fep->num_rx_queues = num_rx_qs;
-- 
2.34.1


