Return-Path: <netdev+bounces-218119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D19B3B289
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2842E3B96A3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FB24DCE8;
	Fri, 29 Aug 2025 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PHvycqPV"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5B24BCE8;
	Fri, 29 Aug 2025 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445304; cv=fail; b=DtTJRbwUqhQZsaqpdVhuYMyLGCXbrhrYaoqx9b9VWh95nAfIEPOTNlIOhbuO3RpSB+ArI7cMThkI0y0o2eaAPvXvJ6Uk9FvcypfwM3kfWTbQ/Ur3ajOsbOhxrf+EP2iQnsTffxqfA/HRvnzXVk0E96pem8fgPEWjXcrID9r/vGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445304; c=relaxed/simple;
	bh=kVrkIMn7qRqu0LhFEKOZ+q6LFSU4GNmcHw/g+EggRNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EETSnpfCTMD0DIao+t9pQEwaE9W8dS2pyVb5fys2PvKnOrAgi6IM+0vQ1TjNRNajToO/ZoeTwJKZGMAuiAKI4yQcG8ojLINyRumH3RQiCVWI0FZ3pKPUTY967EjTlQkK+OerMa5UZc3s9kwT5jdWLn6+29j3FW4cXxk+f/cX/B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PHvycqPV; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLHsDxZaQHztLIYoJLBtp4TvUj948FOh/lejb4HV/UqSCTE8XFXG/qYU172szcU/64zwkNJKbnwXOkCHaZjlYQXra6GNR5HTkuWdf/f2E4YC5dj0BfVyuO7+/lqJqvxM47n7Yt1SqO9U5JZrut/pqW7JWFDFt7dMCu7nJ8Zx2sX3VG59kn9crTdsJEdCJdzQpvOVBEeNJJSjJLw5WW+1w0RYhjK+5e3VWT3x67er8b/vFTulmWo6dmmMyxo6qXa+Y/NwHdrUtRnn+A2Yjxaj36iUbDWuy99wDKREyB2/XnTNUfKI1Qq4g9Dr5fuqLionW8GDbpyW79PPTvIfh/WKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR9C3XvAaXbzONQKZ55ZV1bs5Th/nkcB4JcsxeMYFyw=;
 b=rYlUhz1jSdQCL8DquYIbxVhI3wB9yh2vql6L+GpcW+6Pfi8gwGT7hU8PV9Ixtfm1MNoJGo/ZL0gMVVHRQ0LoElAGb1UlRL0VFHEFhJLbRG93ijdetaitSJSdYTHNn56RCxdWCVjXtj/Sb/496EzFodpvQ9ADx2UPlsqgj5ytjkanXbCDw7P5PxYSJmYUD5bNUkKWJk9pbUScGXEMFEaXnNXZWzOr+7VzRDkhW6kR99jRR5KjKUfxGv0iELn0QU44xW2X4RZ9Xot/bObvmpWudp0JE5e2onFJcCH6BNBsC9f8dwt69BT3wq0q1vG0h7CjDC93CfGbctUlMHzdCRj4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR9C3XvAaXbzONQKZ55ZV1bs5Th/nkcB4JcsxeMYFyw=;
 b=PHvycqPVTYLeFJ3ppaSbbuiWOokBAzcLPg6cUogialfjb6PmH68xYrIy0ZUm8MeYH85peA9sJztpWBQ0+3QeMghPzAWuNtxNykNwBtcw7nObxt8OZsgZz0FdCpr/9RMymXgeyAsqvewaNdonBxL/rPObRjSHK5RpR0AT9lN2yFi+BvPtSRzc0o7HEHseHKhQv0UpGhfQLdlkpMxxIhpfIpP0IK5x0WEV4aIBTbPPLkq7QuvR6qVIIxhbRk6enZAAPb0wHT8BQkdYKOpFXK7lG2Fc3yLSI4gMXgaIcFllaam4DCxeXU8dmVTyYShOt3uAcEZ7uHN772vRXzEMEaFqJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 12/14] net: enetc: move sync packet modification before dma_map_single()
Date: Fri, 29 Aug 2025 13:06:13 +0800
Message-Id: <20250829050615.1247468-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6bbc4f-2eb7-435e-2dc0-08dde6bcdd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ql02S6ydm4ksypjDMCYgBZ6EHwWMKbsOByB3s/lUuMs5BVqQ67wmqT0VFt2W?=
 =?us-ascii?Q?Nhmg/SqwhL2dWd6lKv490B7dIHY3lwtaFHQcG2vIso7x3D75MSOJznsmLMJa?=
 =?us-ascii?Q?u6z0re+eU2zoCMnjnHGxgatCg6Q/YvP8RyQJuHE5mNBZCp9Y21v0g7wqlKOL?=
 =?us-ascii?Q?pq7m8zXAVoYMn+Z9rbi7Hw6SbRrPQYa5U/POsrbthicfxdujs6bOwGVFpkVE?=
 =?us-ascii?Q?+2tMUSwpqxIJS6GvXsd/8zEQOJudN3tiJmp8YHOaoQgv1kmUa0sX+p00oE0Z?=
 =?us-ascii?Q?PpYxE1Y8yGbX5hNnb6BKAeQcBxu74abmgAbZbKKxrwG7clKQX9THH9Edj810?=
 =?us-ascii?Q?TpJvlyAW47UEeiauPCzOJJ5YubLhU0Dqf8B+7f6d0jsz1DBZ68Saro70UM0W?=
 =?us-ascii?Q?brO8ll1i1FMMZzXFzp7hD7rHwYG+RcDHeH4WVMq6S8bUkj4GyGIdeQue/S6w?=
 =?us-ascii?Q?xjnb4zhFGRDcXrIoMFFSdvvtTqJE8RB2xu1STgOP6DKThp0sj3u56uYqn5Vg?=
 =?us-ascii?Q?JfplkPLmIrQwd3kVhpCTuEweY6IAWQGYtF92FKuOTmE2lecDUqZKuBZ6N+An?=
 =?us-ascii?Q?+EdrspoU0kO7fY4AL2eszuNkfmuwyq/M130+lHPmHpjk3GyuJ8AYHRfOrkrn?=
 =?us-ascii?Q?wLWPucH7Q3hnuc0S8jfsuchafup6jYeEmfyNysBORClF55neEPGszyXIjycp?=
 =?us-ascii?Q?MoDw7SRByRYY+g9dKqub3NH+KJGp9+7qq/uYU1YBPwYDHFO/eYxYy3etXCDD?=
 =?us-ascii?Q?JdCIr+FHKPK2hRAHZG3+dxXovMh938b8LoTqK8PZGAqgNOOsLQFgMzUPdTif?=
 =?us-ascii?Q?RG3xhzOdV6N6AITpDH6p7E1sXpI2DlnfBKARBgqgKqRzvQRFkiJsEin3+ki7?=
 =?us-ascii?Q?aifzqs5EtVxeSqoIalBjfnu7UuBel+qv7SRJTqGafXm3z2kayNzRswl8x9SK?=
 =?us-ascii?Q?eZuhc9MrxZ4LALXrxUbZBAPeVBKmljHsI/g/d5vNNW4Rwm7DCy6N1jkDzke6?=
 =?us-ascii?Q?AQ7G6kmqoQGqEYlrpziWy0lucNbiIuTyWmtNLEglDiqmrxbfLxM75bpvyzmN?=
 =?us-ascii?Q?incGyPFMcW5bGsexIWjp//7ofK4bF4BkVKgvSQn8USHVfgJ6wqGXWRoMGOVL?=
 =?us-ascii?Q?j+FYOuppkjmQ0X+fJx2dO2MoeoQqMhikZAQw8i0CKfeQnRFB6BwF+CKWRHNr?=
 =?us-ascii?Q?ymcWmXsCcWVYSWPtzPZyy9WTr0Jfs0tWjzRGjxfNbMjwBkqGQHleIjIrLL9/?=
 =?us-ascii?Q?EQwaRaQAZt2QP28eeYXfQeVl6rRp4qEqAuaRZqA1JqgXj9oREBu2GDfsHZ2R?=
 =?us-ascii?Q?C/rR8cdl1pBaKDTgz5qo7hhCU/T9TqWKu7c9ChkiTDtt+hMIcR8mWv/V8nXL?=
 =?us-ascii?Q?/PCJCJvy+9vSgM6+MEm6e+VgopKrh2vWRiKMHnSv0ogEeTJf0ZOb8/MlkOHk?=
 =?us-ascii?Q?X5sThegR3NMC2WORBYM9lyAh0s//XNbpkgdbT7GMYYkhiSauBDjveho1a1s/?=
 =?us-ascii?Q?1WkrecV7+L0xHzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERu3kI8Kt/IKDUT4w/vDV3OeQvF10scDULLKZuYVXGkt9Wgrr1vIhdpSE7c6?=
 =?us-ascii?Q?kqSPKPqzIvVD1MxCa4pmpmTHkP76s/KLKCEvlxDJSkWOrf33t4eA/q8E5W+8?=
 =?us-ascii?Q?3zTVjiUB6XaBAGyUK7ipvaGYOzyDeIDW9y8qtu/QMjILzxTCNjoCroHzY5CL?=
 =?us-ascii?Q?WsQeAhtXD5Ye5A0bjvutEN8avZW9i0TIy2cp51QhxTS/n16SbYMKLJfXA3d9?=
 =?us-ascii?Q?lDSjYdmAM65g6GPFOumxPCY57m1347RxFccuypOMDxET9OKrkoeG+s48QYRh?=
 =?us-ascii?Q?jm0f+/HbyNn5EgJJrk2nLLTh2Lbv0+0RtSNHA8EyZRMmkDY0Bhbt7t5IlOT1?=
 =?us-ascii?Q?E1RKQWVvwk7XVF+CEAAy64SjPmXhtwh4CX2FGalRCxg3PeO23x7VTyP7GHOA?=
 =?us-ascii?Q?vG6BeEyVzAcGvj60zxETX3Z9PJqoxLOU6C8OiWBdmGtz4EGOWCDPQhW441Ma?=
 =?us-ascii?Q?wbwUwT2mgTqzAiSK/alKskhMMyPK65wHlXUQMowz7IAmDMRiry4j9lOviqvk?=
 =?us-ascii?Q?rJ4qHtUocF4cRaHwHgIJif1ltVXwrPPaORapC7PwTDIsRXJOk/mH6DN+Sc+S?=
 =?us-ascii?Q?rykX4xUqTKcQlIrDvWXXR60y/E+tYb0wOtvGdrEpbJaXN32xJmoO4RAP3STa?=
 =?us-ascii?Q?AICVFQ+zyYYhvoWLCCl73QW+UiTrgiND3h9oYLthJPlAjpLnrWfsIfYT9ZlI?=
 =?us-ascii?Q?A2vuimRnfvxAVqw6+SeV4Ry1IvoUO0q7dfEZMP63+6udA3Fgutb3LhxFdRca?=
 =?us-ascii?Q?52IO9oYmSlGLwwKAKTkknaHOeWbMMqSOvrrDrv8lXAGqkdB5yXQd7y3LvYjK?=
 =?us-ascii?Q?kbJC3J8dzbM8Q+TqMJAxon4OWzTmzF0Q2Fuw9MHYCR1mq0J6UzWvnji6Xsx0?=
 =?us-ascii?Q?88dWHprhtVT4by93yZKd+qC6j+LL/8a5v5fdm1mqSged7zGxB/rw1s70bft6?=
 =?us-ascii?Q?ZTKQGajb/npz07mO3GEezDWnb8Qtl8dwPwCQge2O4rrIEKE1FHUK+X7pA1ol?=
 =?us-ascii?Q?BPK83T+2rIrjzio1Y3bAPRhQ6J/G2JVReo8CG0NqM0ZnDS0IPTyecNkibncT?=
 =?us-ascii?Q?Aefy1/hh42T+GUboqAV1BatCrG5gAkbyd2vGUvfcQ+PaGRW81H7HCxIQhBK9?=
 =?us-ascii?Q?dYNVM/ameyGJh1P4zjkDv2csUqRjM980NmBE/A386c49+MqcV+7quAAWpg8q?=
 =?us-ascii?Q?u4dfALQ/nnnDtSwrKHTgiJCqKOiA31X2vemgVRMA4Lz5oUqMpnDaFT0qAlgh?=
 =?us-ascii?Q?H2kPPTm1FjPcpOVtP7B79G2oZxIfvKeViXSZm3jsqpdVgBRM/aZKs54gVE3f?=
 =?us-ascii?Q?5DKqbh2XPC9QzMwy7NFKVTA8aWKSpSIearAKqs6McOFVP2ROqXS/vPvN/O3X?=
 =?us-ascii?Q?foPTgqBVc2wAX0+UqdMXrW2g878/WMIwGvkEx/BIOSbC6w9VKdyv7oNOfcrp?=
 =?us-ascii?Q?WrHoBPLHslytOtpKt10ZB1PvWyx8mQyac/y6ngVmCcdg733WYZ3Z/LuFNzWy?=
 =?us-ascii?Q?8/cS3kJc3p6+l+NekPZeiSUIReLom2Tc1hclrxJ8oYEmpJBeL0HWS14uNj0I?=
 =?us-ascii?Q?weHFgrK1agefyeyDJhd+A8DN1OWtjY6Q4rYKGp7H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6bbc4f-2eb7-435e-2dc0-08dde6bcdd93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:20.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vilDg0fgUgx6F2V8inxs+xqQwhULQbWBTPojkn7ysTfRvMQ4HdBgkqWdlTk/gKn42ApGEhVn68AFPYHKHFSeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Move sync packet content modification before dma_map_single() to follow
correct DMA usage process, even though the previous sequence worked due
to hardware DMA-coherence support (LS1028A). But for the upcoming i.MX95,
its ENETC (v4) does not support "dma-coherent", so this step is very
necessary. Otherwise, the originTimestamp and correction fields of the
sent packets will still be the values before the modification.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v6 changes:
new patch, separated from the patch "net: enetc: add PTP synchronization
support for ENETC v4"
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4325eb3d9481..25379ac7d69d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -303,6 +303,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	unsigned int f;
 	dma_addr_t dma;
 	u8 flags = 0;
+	u32 tstamp;
 
 	enetc_clear_tx_bd(&temp_bd);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -327,6 +328,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 	}
 
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		do_onestep_tstamp = true;
+		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
+		do_twostep_tstamp = true;
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -346,11 +354,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		do_onestep_tstamp = true;
-	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
-		do_twostep_tstamp = true;
-
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
 	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
@@ -393,8 +396,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
-
 			/* Configure extension BD */
 			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-- 
2.34.1


