Return-Path: <netdev+bounces-151594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD459F02B0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5CF188C806
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D6155747;
	Fri, 13 Dec 2024 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0TdS2KH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4837868B;
	Fri, 13 Dec 2024 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057227; cv=fail; b=lI//yVZnenyq5CrlmT+mLhELSJB0rAdAg7pWh6rqZUq4AJydrXktDML7c32nPmIXfbWNNyMsG42p57jnUmzomhgHLR9kDGipt8+l3RAeEts4uhLJXCmOkJXcGxQJGiLbSqJuCz2M2qgZsk9DM0bGLfmroC063+tlXUU2flUCKDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057227; c=relaxed/simple;
	bh=txTfwK5asE5FysU+fSoi8matOakIXwMT0hwIZ7uO/kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uaok/xxXWRZFOqwCvpdR0SsoL7q+i7Fmgpp0lgEsymB+Gt5xu94RalBPjXtfX3XVKxx3B1g16fhiJrG0mycH8i641ebIbZOcngNFMNxo5w/uQCfEIL0BsQGNU1tplaShEL3Y7SIS33pamR27nmoY/GyvqnF5cYQK05X718Cctjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n0TdS2KH; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEj4iwln5xo4RmpJAqPd4K6XdO2n2tdoauzccy3fuYdYrGBVap5PBLG/W3bCKiDLVkG3AKwywOVTcXbkaYuIYZtiBcqhHWy7pCdzEM6b5aEXvDQcQnShNwJmK09mL4Qdm87mVdnfAmkD4gj/7wrhtmi7OvsUc5WM32sHYYxt5NFfuhqy5YgutiHn9f5ysU+dTBufq098xORY/WeqI8K8nB2u98LGoiUpBRE26b1g216q0Y55+Uewi96WXrwmmhoo9FfD7WW/SgYJoxMH0N+yaHNXrF1Bw7OJQIQ36oP0NJT+6JeRlkMoBW14IDUGdHVFr5gq5k/FgxsvQdsugg7CVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GA2PmR+U84cNn+YeuVg4t8q8e4u2fD9q8H6KRESw70=;
 b=oyQFrj96U2WtRFpwIM4GwbJuutLR1QYj/OAqv+ROGziPg+3Sxbgy+FtnRV18E5y/pMJnzCUQF3N9egvU2fcgUPBJOIy6HktIeBfrO8Zcff+0C2DGr8Ls9VI+4zRAoCdOwHNIX/+FnWQRKTvNb7WUjCpV7rbFNYq38Ad2BhVUvbfMSgugshNlRFN60OcB1OL9C4eg7iw04GqA1uWGrFzICxe2m0kg4rfZ6pkm5zkAcLZEbIHcpq89tTBLLeJKqQqSCjgNCZiLTfkGhbPXHrFmVIcAU01yDPx76aPQGQB/QTxHOTNqEztBSybVG/COwTml0BG/DQKtwlcj59WLuUSt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GA2PmR+U84cNn+YeuVg4t8q8e4u2fD9q8H6KRESw70=;
 b=n0TdS2KHE5TJ9aL9mev+QZRsiEHJtRD8C3pj/b0ou3e839lLAqdTCxUik4eIs/2T/XNv7EzC3vLa2vgbD7vtpIpWOJelIzK5q9l+Bwkg7no9owH0HbTWoPfoGN8LMC/qv4HixpQweUb+FmB56Cn9uTtzwYG2hVgHlka9D4d9vISQ0zAJJlSVQJn6sNJ7GYGOZwDNt3FlOVXBKE9mcvCVFSzPEPT8DUzOs3rZEQg/nZNnBjtoQ85jiWs/0OQwZHb0NWfjabc8tExZ32RG9TU00Q0b4wsRuUewR+DK32igeOrRNvXdJ4dL5DQOiTgDSTybqtO7Lg2X2gpPseKVrJmbNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:33:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:33:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Fri, 13 Dec 2024 10:17:30 +0800
Message-Id: <20241213021731.1157535-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213021731.1157535-1-wei.fang@nxp.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3d8fab-1fc8-4c07-76e2-08dd1b1e8eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5g5vbecJUx9H64C1eNO2IzvQshnYq2X//pkco1PtuFiWchDyMOcmhzc07lvW?=
 =?us-ascii?Q?EikbCYMrQj3q/tijYpeo9SfzT6JSZknTwe84G7VrP3bRZeTv9vDHvNKRp0rm?=
 =?us-ascii?Q?pbb39zxveGeWK1p8Xb9/gC8rpUHuHxP1YnkKH5CyGspGZOIFBfp1SpsC7NK5?=
 =?us-ascii?Q?zwlE4YfIBg/YAauAB+rkDJnTA9Sxq83oFCw7bu+p8lxEInvyaLRP8+grtcEi?=
 =?us-ascii?Q?HnvP42DZ/KKvGYwajcv6c0OEZoM/2xbuyQpnpwBn/R8JIExL5zIHgatbS77c?=
 =?us-ascii?Q?mHMMILeNQp9fPyNTs9HdKrM1A/rSAsr7g/+W+12Ztw4ukvhO/VH4ZI6GJgYB?=
 =?us-ascii?Q?N0o//AiaaulksvWjGmA0icCGWiQngI4O5zTXg27OA9SMxVS6Bz+/Itx5Zx9D?=
 =?us-ascii?Q?ibKp6k7p7KQd5cm8QmjTsOdvYAc0s2B753IOA8Dsa6qA1UWH4FHdUPV21EMf?=
 =?us-ascii?Q?oirjEZ381i6cTSO7ZIHzb6OPr6YArv57Ro0Ae/bu304uMc0MeSxyuf14n4bw?=
 =?us-ascii?Q?OwMXpM9rfQse3dVUN/PcsoxISy1MXvpOn2OAvYfsqv0QK7N4kYKeLW3h4HL0?=
 =?us-ascii?Q?i81IQmxC7WANXcV77oUno8BcnQT6ZA0dTFeRV6FkIuSHByJJ2xAL9i9zY1kG?=
 =?us-ascii?Q?wKcOqvLMblZpxXkqrAoJu3V0H4oZVfS8AwVT+E+EuoQ5nP6BgT3U4VIbfnjk?=
 =?us-ascii?Q?1L3fyE17UDO5BjncpL94Y2V3NZRPUZeC2nvpiiq6xE4mBBAYlOIxUBPSAQCi?=
 =?us-ascii?Q?+UTQ+xmOyBhEHYDG3Z1mV18OLwUuCAwQQaICjXePKIFxeO3SH2Ef/UZqVRhT?=
 =?us-ascii?Q?ips9Bz76Z/64DY/Q2K8p76kQeL+aJsDJK30kZs/xw3qQ7flcx6NYhuLcdPVP?=
 =?us-ascii?Q?DHP2kFTdnAktXoHBxryYGweHzq+QCyRsB+M4SKS5tq4V7jLhD6D5Mz00ymYn?=
 =?us-ascii?Q?WjMHrgUA0DebZP/kwJ8X46HSEMgswPP3xCBYpdi/NCgkOtEQm2piyms22+et?=
 =?us-ascii?Q?pKZtUIU1MYAvYmQjNtstWw31HTfpocDvYgNlpvPsj4AOak7Q5i3FTCMHznEL?=
 =?us-ascii?Q?u030huiqvFNoFQrSjlok7Tp5Sl7PRcx1CRO+02DcRNKhAKuR1OWU526YRpnV?=
 =?us-ascii?Q?pDqehRs/b9kGYASWd1Mh8v24uLft4aFbyTHWV+MEUdBXW3SCAYdR0/Nlh3Fi?=
 =?us-ascii?Q?Z6dijeaRCZktVFaiP16DaksGQ3GRIl9QhhO6FPjgH66zNzEwotW74AC+gl73?=
 =?us-ascii?Q?R+IVh4KdYXJCXrgc8QzvOZBPoV/Yq29n7hLlJbUVp3b6YqpiTZx7FRr6Lru6?=
 =?us-ascii?Q?IoYB1UYGZDAmhI4HK7gRFdy8+qFZDu1fk1Wil+d8HldQkvyQ3OybL0RgSrAs?=
 =?us-ascii?Q?nE2a90l/r+OG4aYsHWb+TTk7G4IhsRRe71OQ60Nyki4WDYJ6D092iaUgEG1Z?=
 =?us-ascii?Q?1noBcJuNodw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?54bqwLWC9nPEMa4Vy0WNiboUMsVk5A66e0sQuNzK9p4zMKop6QWw33QzTuqk?=
 =?us-ascii?Q?QsMi6bO0Ml+EZPAOrlJ6hjFYoGD2JojUJHCLnZLyvg47wStH/L4m64TkJNpk?=
 =?us-ascii?Q?k9bTfFWpJeMfV2t1g/nM1B/xssBLNW4IFDg3aJdZcV0doyZQzPYcM3LsZZ4/?=
 =?us-ascii?Q?D/ZmOKsHsupP2TRrgh6CFmnMTuT28AQMhYFsgpjPc/FdYgx01eDYsmM76oK7?=
 =?us-ascii?Q?ABM5SMnVTBlv5518qTi6XBWI2ww71Yy3qqnNWHZ9laBdfPMqH5udyoqSeaV3?=
 =?us-ascii?Q?XIZiYXCx3YQSZLEybEecT12WIuQWUoQex0icTXj9kuiBUIDwNqaqJ/f+SQ/T?=
 =?us-ascii?Q?W4ynLppjNBq04JYU0McSS0PqITnd28XQBasHhZxnFHnKv0kWYmDClNuFHNST?=
 =?us-ascii?Q?AoS7HQYeGrKsYIYgI54d/iTSBMQGqiUzk3qIOiTBy9OSOpCNhYPecybhV1fj?=
 =?us-ascii?Q?TbPd3UgMHKukOFX+gLmL06oqHuLiKMwbqQ+iTNrFPYtClrDPYAicGx0MlRxi?=
 =?us-ascii?Q?uL/5Gc3gRw2jjDoTCU/uqEcTm/QbAtRftcQEeZ73DzDVnRblw9EMfHUd+eqk?=
 =?us-ascii?Q?ZIHB0S6kVvJTIo1zASPgWSrOCZKMyt4wHF0T13rmsn5lOX/Rg8jF3lO8F8bf?=
 =?us-ascii?Q?pssIeKsHrM8SEx1ZFY1D40RVlz+enex6sHN/hO0odR0FAHz+HuxGV+s+ftBn?=
 =?us-ascii?Q?VQLotRtfxen4YWAb9YdI3iyVA/URG1+niQENCuZ9v6LacWB90d+rWMPdC0Q+?=
 =?us-ascii?Q?3D8qomNvinZg4tNWN4u37fzWfCTunAllesRpBgMVxMAcuYDtXLEBHVDiiIY5?=
 =?us-ascii?Q?oea6sI2Qm3RBrKZHKvL5IR6h398tR1tPWVJqZoMXeYpjxwBw8Ax2NZCc7LGZ?=
 =?us-ascii?Q?0F4y6Kcu318nGWkSki1DvFKr7nhNOivql/9MFTtjUZnpR4it2EWK8mk818LT?=
 =?us-ascii?Q?rb3R1JJhkWu0d84x8gOGqN/NyoC9SIuLa86NlQfFY3xX5Kzt8xMV+VhOk+Fi?=
 =?us-ascii?Q?0fFvB+m1f8eAXgxOHM1zqfEKK0YdZTvveQkBRec7EG0fVmnrxqLHiCFl7W1+?=
 =?us-ascii?Q?gyy9L2tIhHkjqFWN9GYAmyvhcBYquPBRwVg7NI/BUTP44DRu5Cmq5VQb3bsY?=
 =?us-ascii?Q?Tz3UGsKAtbT5SJCuMkCWOt1w9Hn0nsAmUAhekERFhQpYK07FxShRtsgcVXQ+?=
 =?us-ascii?Q?JldCNZTWNmGlVZzlY6+STwOArRfeR/GGqF8gwvNHOkWyP5YCVVPCyBZRfzxQ?=
 =?us-ascii?Q?L3NXKg1QFIBYE2QxIdMdqK92aq0JnneupMRPpsYfbl6Dfrz2hBaCAF63QMVo?=
 =?us-ascii?Q?sm3SnHQQItxH4uljTMBBnYC+cRI+64HP1ZiJT6CfWQXp9k9n6WDvKJyWB95i?=
 =?us-ascii?Q?SZM2JMce4dKowYl9BELpxtOMfktaaJ9DA5tM86R4F7lkpJ4uCOULDbByY6df?=
 =?us-ascii?Q?6jtF51Hf8qXu3m0jTwyx3nSPWMT6kgQqSjsDyfx2+568k0YCYhJHerGRbpCe?=
 =?us-ascii?Q?n+WBKgIp9YFBfdMj1avoyZ4xKJIWOTuqGc3V3Q6qpk5OiNUFnkfwmKnDtsrD?=
 =?us-ascii?Q?LQrcno+hpTWrLHZmZyEIbg0DbzE3/J5Gz05pjniG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3d8fab-1fc8-4c07-76e2-08dd1b1e8eb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:33:41.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iso6nJc7Hg3zBCuCQy8keYq/TKF48VK8G9K0kMZG611b5WH0GgCAlmMcaxT9AYSmJ94fTH02lJ0gblvUSpZw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
v6: remove error logs from the datapath
v7: rebase the patch due to the layout change of enetc_tx_bd
v8: rebase the patch due to merge conflicts
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 257 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  14 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 301 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 09ca4223ff9d..41a3798c7564 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -533,6 +533,224 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	txbd_tmp.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START, lso->l3_start);
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+				      lso->l3_hdr_len / 4);
+	if (lso->ipv6)
+		txbd_tmp.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T, 1);
+	else
+		txbd_tmp.l3_aux0 |= FIELD_PREP(ENETC_TX_BD_IPCS, 1);
+
+	txbd_tmp.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T, lso->tcp ?
+				     ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP);
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -653,14 +871,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1800,6 +2030,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
+
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
 }
 EXPORT_SYMBOL_GPL(enetc_get_si_caps);
 
@@ -2096,6 +2329,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2109,6 +2349,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 1e680f0f5123..6db6b3eee45c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -351,6 +365,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_TXCSUM			= BIT(12),
+	ENETC_F_LSO			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 0e259baf36ee..c3789868e9eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -25,6 +25,7 @@
 #define ENETC_SIPCAPR0	0x20
 #define ENETC_SIPCAPR0_RSS	BIT(8)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +555,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -578,13 +582,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -593,6 +600,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 00b73a948746..31dedc665a16 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -123,6 +123,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


