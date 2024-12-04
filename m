Return-Path: <netdev+bounces-148814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D99E333F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C894FB2784C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCE18A6C4;
	Wed,  4 Dec 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LiyactCH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6770189B80;
	Wed,  4 Dec 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291139; cv=fail; b=YOakUMnuT9Ns7JpOe3KUqsmkoqX3RtwIN2/MfBttiYmFX9lUAW1ExeVhirql4RXg6CAb30emL6SDjo4dxjC+fEHqO4TRBDLrRrzedC/gdoVYnVVWEMPtQYq/cekqEQbbNe61942GefKZ/s808EuRJ2skTlyoZEJGcAW3AaX5XbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291139; c=relaxed/simple;
	bh=dBgSruQc4iCWuV6d0hp1J4VLYF6KlK5z8YPXzSPoJJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2pW+ctb66MhRS1YGQyDo9tNoG35O9+80/t19X1/l64UsQu+/+xMKO2Mxj2RBaXfSimVj9jLhsobHSfU3QLHM/vurC9vyB++zJHTpHskdNMX57BFY47JQkIvEx1JGp70C6Zrf/oEYJlhCyG/pyQEsAC2ILvy/0TfuXaWeZiMTgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LiyactCH; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4Wpb4mvezbLLKuEh8mn07kyGTgZsxugvMW6mLbqfgoqqIqh/ThEXzh5nvqTxkiNeZPbVdU1Uj1f/Sf5uhDSRxN1jdBwbwBGnB//GQX+amZH64+UaHBNCTLsp4fyBD6G+v2i2AMi3imipnY83K2wDPL4uVTiQwqNq2zkwZz4uZC6MHbWpMODqFUbs/cqCc8SKsFxRvX/weir3cqpPcSwNNwWrXouh/k68kewtcSRiJyAjp7sMDI1eJAFu1seTw64bXmUDhqF0Y55LgCXGeWS9SkM8ozfoJ2X55fB85Hzf25gr+OHYaeAdDLQ9Ulie/fnY1dzk5t7mRIwzTsRFSNWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8X64OoeC+GrtxcnK5uPV681Wn+knyykExbwg4HZ5bI=;
 b=Hl2FnrIbTHQ75ZoSSJHRag/g0L8Mst6RMRVqvSLNnYBPvjNh+5fRQrgkcR7+oSwonvzMWBlx2hYDa+IXU83JDdvu1p4Bld/iUZynmJDkp6JjTCfhRLk5Ge1nM9DujznRchZpq9Cum5ovrPd5XIaR3LkMWU1M34rGcBWVxatlkA+awZQpw+W+pEnU6cXYbCNG5AGH3b9FstnneNTaIPYgLifhFzlBy+EYO3oqwVT8PRKFMW+wNQkvas2J/bPwpFqzh1/eI6rpn0hsl2CzNcf05dxNSzD/ZcPRwVLP235ll+q3oEhf0w1xvz1Q114TIoqdcW417y3P5kIWrQmoJOUdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8X64OoeC+GrtxcnK5uPV681Wn+knyykExbwg4HZ5bI=;
 b=LiyactCHNQ/ASxhmSudDfQhQBA8/7IL8+Co1NYzGYNvxfSbqGxmW5fL6ab/y+VnG1M0lSUMAWxOgyoWVC6VLU4g+Q9L+USYgES0iFECOTWHBPCDGjt2g9693NXgZv6HDiPAGDgDxfQ+7VQ/OhJNxfFMUJoQMHbnHfGMXjp0eMosfO669AjCyJ+hEEZd4/ApDv1sBMBw6ZPevBRHieaqeFtdPqmilaJr7vMt/W8bd6LxK8/cMZlX7ENhDlpe2bWPhPVE5bEUIzkv0/9ALowIi1PhKvl435rvIZGv2mNofUtDXq6ZokJDfmzOz/hWYLAyrByw4DSppi9gm/UaklVuK3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Wed,  4 Dec 2024 13:29:29 +0800
Message-Id: <20241204052932.112446-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204052932.112446-1-wei.fang@nxp.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 240e5bd5-9fd4-443b-43d2-08dd1426dea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D3YV6/r1r7Cetl87sXqYrBXUvz/Wnt3YtWNrGLXBq06iFAO5DqJLgGiBL0E6?=
 =?us-ascii?Q?9F+g/61x9N+sc3FDgVgRgdAAQP5aIHOpATGm0v0S4SNhtv7Kyj89Njl0t2Tm?=
 =?us-ascii?Q?LJ1gQ4htoA/ukBaC2KG97OsqTDraH0Jf4Ay9H+ZBdRLxx8n153JbbyiFXmuX?=
 =?us-ascii?Q?r/5JPyBhj70kIzCPJJgCbIfyNgVbrjmYxhaAoEN1gD8T053f1g0OOZ6uLpxc?=
 =?us-ascii?Q?yZpEXioV06uD4Ei67FFfHk8e8ybZdsAyORj7oJxO6gRnmDHJb9ds1yxreHFG?=
 =?us-ascii?Q?DIvRxBgidQmTss/hc67g+CtojXdTDnqqlPO3dJv0vELT40xk/dQdhqrteRMv?=
 =?us-ascii?Q?4HIqJFC3pZZXt/miD1Rd1zXm9xK6Yozpf+4RIvXQsUdWIa5ZgtuR8xOuqQEm?=
 =?us-ascii?Q?p+GlysHhXqksG78/ed3hc5Of2U2fysaG7O0oPudYg3AP5ghaRk7wYQFAm/UA?=
 =?us-ascii?Q?5ndK9/s2bCtc8JrFp9GYVgjdh5k5SCoenWdW7eErpe8xiyfyDCnbaapaG+Ia?=
 =?us-ascii?Q?ZYfVy4H8LzVE/V+dAKOpWCbMqRsuv0rRkUBE2ffjLpUqja+Vjkn3pMc0z9e7?=
 =?us-ascii?Q?UPzoEzpd4lU2ifVIY9wAXl7zF3vXDocXCWT5OuI/SJlI+ilw0jqfPcETPlJL?=
 =?us-ascii?Q?RK9HvMsMfAhrvXg8uRMsVDUQJH+cUxyLo69UhJ9QiAv3AUT7dF64xUKSr3fx?=
 =?us-ascii?Q?rAiYxrBDJkRw/CL0A3nsKQUsVNr5BFDmyU0QoyNyWfqGKGkoxSeNWy9YtkIv?=
 =?us-ascii?Q?etxGZ7EYB3ZQrXQA83JGQ6t7kdyGG8Mj4PI+50ak35wy5qxX85e87RU9WQYb?=
 =?us-ascii?Q?FAZfC4oWK+n8DxsEFcOTu2ha5pFoVJuCQ5tzh2RHolYfvtFn087Wud6sk9tm?=
 =?us-ascii?Q?QG5pR4pC50/52D61zcvM0b3OSgEt63gUXpJy1S18lHxG8suHPkwFlWD3kxOa?=
 =?us-ascii?Q?lu/qZJm9VvrJ2xXpGuOg8k1eMD5wYSj1WSkBwb69Pcpq+/NnxDkgEAviTiB1?=
 =?us-ascii?Q?zx8vEUcN8tiO5nepiBR5xQcrnD2Yr5JKayGFrbrvpwiT/siQyUOfBOUPIcIr?=
 =?us-ascii?Q?2v4EsAUngyY+WmDm+mY+2MYacomDjS0T1BbaLymJkj5pUEr9woM1FcoUUIRa?=
 =?us-ascii?Q?RgTpuaOQTq9FVrnxXN0NZ4txheOjAwbO96PiEt4Coz58DkKnuzQ23Mm37Fz+?=
 =?us-ascii?Q?gce/08/GFj2L6Xtwa0yPI6Gblubk+kStWtQpQDsuMfUpinLDf5LjC3UHzHo/?=
 =?us-ascii?Q?mChvgDbYRB8zQGm2PoBRl8t1reD7jg/FHTR67paJ2fUWWnCBYHs4sC1VU0An?=
 =?us-ascii?Q?Xlt/mcLF/X+PLlqD3nP1gxt4n4T5EVjMJKbcIEotF+WqbeB3v6E26expZFrg?=
 =?us-ascii?Q?NtvMsdekp8B5OGd1+Fhi9MgNYlDumVFVdFG3PITtWXNxBTKoEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vafkHnhbUZey96Oez+82DdQVd269qB5az7tAMCIj0JXGhvYsN/S2Fqw3bG7g?=
 =?us-ascii?Q?8h0Jzz1KzdAu0C3OsGhc8GjENnd32yus6tytpzqQwnrxWFuNfceydFNxLN+G?=
 =?us-ascii?Q?8ygEOhO9MEdLOwpPaw8Cy88YTKWTIk8F1SbmAgPAhiJx7KgkPoXcJixKhbeo?=
 =?us-ascii?Q?CI0ALZlGP3bYrjnlkc0YQgKcrbezkPxtER05s3h+F3u+S2JH/KuKAnAqnNLf?=
 =?us-ascii?Q?85ubqW3x254BsgtzZC6suaoe2W+FJJoo+a0yKp7ZpjVAGFuyN4beTIIXd/yx?=
 =?us-ascii?Q?pJq+aRBuyhyTGfRw4Muy9LF/Vig6w0XsoPnvFA4ZgpoiRW4o5L8QgZLGwGT5?=
 =?us-ascii?Q?3Bb1Hv1IN6X+oD+63Rn1F+58muQ/tF/i+R7MKpK2qC4h7EKgrTMYVQHs24wa?=
 =?us-ascii?Q?V14yflJYASDr7GefJbcWjLrXgIciviNd8kjfTEJR6G4s7E+BklMMNahScUba?=
 =?us-ascii?Q?TSkVUS+AYJC6O38xJlWcgX8TLsw6Xp5/WN+q6410buI5QKOX4KCIcDvk9Vr+?=
 =?us-ascii?Q?+LH2iRyqiefn+IweohmiU9Q8mVFCmcJ9lYdsMsL0YoiBmF3CgPMILfLkvcpi?=
 =?us-ascii?Q?B0VlAP0hPgU3DbQTvMCHLIp3NiIcmt22BEaBj4L7ORVao4PIYZAiaEsDaaxV?=
 =?us-ascii?Q?fhx3m5+a4LO8tCf8pLwTRcfaMhHs32UpeLKpYBwxF+49+SqyepqKmS34nTHZ?=
 =?us-ascii?Q?vbXQ1BVyJ4SCdwOMTdnzV3ZdMe2lRM/NSTe8QQV8/AUiPN+gRLem8SYC3sDF?=
 =?us-ascii?Q?dBCSF1ikJbmHO01GAjZDogclA3g891fl/oWG7RfkuTPFf5faSqxzQkR5meHS?=
 =?us-ascii?Q?K9yr5LFKKqVBwFmSEB97fz8vv8RbHXRvQwSxgLr5SmzIXfrkhz26juhGt5pP?=
 =?us-ascii?Q?WI/r0oU1U6TIbeI+Aqzv43/mD3jRQstdB1DjTgnt5OPlNQ8G0ZyAxW9GLHcL?=
 =?us-ascii?Q?yfFR1bnJpJfpCuYtisZ5KZk06TPfT8JmsP+yirlpvfNiAPO44brUCyixe7iZ?=
 =?us-ascii?Q?4YPx4uGkImsVFNvItBhLItpVMMb0qVuJhmc/VowuVULZzHVj4mpNcBGKI4H1?=
 =?us-ascii?Q?jJIGFJe8Zu+adlnJUsXGcD5bv0Na2Um7ANmYg14nGjCF2dyFNOwnWL6m0f6u?=
 =?us-ascii?Q?BYZ5wgedtu8GOjCJ3MLXDoFuOPhVBYWFbuJR6n2WdlCQllSoDLiqzd5ZvXZ2?=
 =?us-ascii?Q?2CWFvl6avwgcjBkk4pJjbS78lTv76C7BXAD52EY8YBWHd2iElQ4NUcSe+kGJ?=
 =?us-ascii?Q?V3MdZEbv2cHgNJU4SWYYDq6ehxJhQogfhL7/+P8JnpAUGC8Zy5E+FE9SNWc7?=
 =?us-ascii?Q?+H3xO4QtLuO0TyVADFbAG9fRj7C5jECIemVezMdFx/mVhrqLoS06jGQkX7Iq?=
 =?us-ascii?Q?XubelZpQBoYHVW7Tp+CmDUlwCY9J/E6PdPphr8ltP1UWo4YrsHRMa1u2Qtin?=
 =?us-ascii?Q?0saZjP70ILvTAhqWWZjzGgNG6lWz87TK+iMD5xXEBT5TTFeeYFi49qwwopZS?=
 =?us-ascii?Q?k3u1iwzzBRX2iwsHBpCJoa+Srcf4t9cEMBgQyIY9TzLcFXQj+Il+bPqYj9DN?=
 =?us-ascii?Q?i5UwIAywk4iTmiKVQv5fzgHYlbDdusUUe9r2eCVI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e5bd5-9fd4-443b-43d2-08dd1426dea2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:33.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMxVUF84fNueyBrAqO5aX0SaJWC4qPZCxuqxWtmkcInmSjWrKmoNydI5PNGg0QcDTauT+5rzeLxY89q2BWMNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
v5:
1. remove 'inline' from enetc_skb_is_ipv6() and enetc_skb_is_tcp().
2. temp_bd.ipcs is no need to be set due to Linux always aclculates
the IPv4 checksum, so remove it.
3. simplify the setting of temp_bd.l3t.
4. remove the error log from the datapath
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 47 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..94a78dca86e1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,23 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = enetc_skb_is_ipv6(skb);
+			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
+							      ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb))
+				return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +208,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +628,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +661,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3319,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


