Return-Path: <netdev+bounces-292785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGf3GEZ/GGpBkggAu9opvQ
	(envelope-from <netdev+bounces-292785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:45:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F515F5D93
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E163181846
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC0409137;
	Thu, 28 May 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ma/2voFQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9640801C;
	Thu, 28 May 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989712; cv=fail; b=mI4990sSiWuPuRmNELY6xL4otd0W+9O5lc6bYf7QTqBRxufhLx0hOfRX56yXQGjbpB+uRfPqxm3fXyePM/3LxhNWPmzAcHvUyYLXJJtGqwBeSPprvz0JUrc8cctOxdAX4X2UwBKpqRU06VBd5ybIsCX80Ajz+/1Yw4kFDDcmqbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989712; c=relaxed/simple;
	bh=XoLDNhonU6dBTlTjjRRcNmc3WGdfLXq2qYCUvrVB2ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dr847qxi8ydXpoQqmspvKs+Eqmspz0pK9pLgKdgJIJPq+G0qcfSgCmJUhXrGDlo2PAaNcybtAAhaEYnTrFWvZnnSjfxpPmHNkfQH1ipqsgeLg8X0LjGqOoGgULEEQ0Jz++KEmUVOH+0f0U5noR+YOskLaJmpOgp3NbJf1wi2EaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ma/2voFQ; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGiVKu6PBVQff3wpgLO2ZJG5s1jV5FKsMpslwnIZ20l0NERcNGkOo2+x/iii0SmE5xm879sSL9XqYNfOXDIkfhZy9aYUCsTwMmyz+1Ha09HUFtvlXHxurVQCR9QK71Osk1FIt/trsq0sNdYI1pn/aLI4iW5DUp4/tqg0Xk3uozRVznrynzb27KQhQcDf8dlMjl1daTEa56fotKqSANVP+NSc8GGt09HjwmobcANE+soxPC8S9rNaJKpYn/Z0SDbs5eaHH9lO6hHOfMZqUpqsMmdIsNtKF+NKMjX9yendary4vrEmDBoFeWPh8C0d0i+Dvo10VBMT+Pu7lDr2duWWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAPMBbsxfvm7fJ+cLA2wP7inxCaJOAJONVM0i/vqYkM=;
 b=K2ix0rRI22vspL5VidU4NIyoDM00JwzcsFESxsETqsNoaNhtGsBdxMVHFdlzIr90Hwh5CmABqB4qxKun6ywCAV96g6zjyNwZkVJufAZQ4rbZoxDxMTEQ+X9D1OhNVvi3/dCsDV3d0yjWD4XqJ47cHUPrHC0r3b1a71uZPMzRbLsQc95F/vgA16pNDe2y9BVeraI0GjabCcnJV+37Bc3UIvOELOqRwpU/azoEfwrV/Kj186exSY7EAQH36oMUMgzPRv9GKUp4zpkNTr5cdTf2K9aJcWQZrXb+pDSCaR3BF0fKaEGEvwwHPmnuCxPx4ZY3w6oxOvbj3CUV0pMLUACcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAPMBbsxfvm7fJ+cLA2wP7inxCaJOAJONVM0i/vqYkM=;
 b=Ma/2voFQ4DqtsxXyVjIAx4jDMsI7zyt8kCN1ehnanIbWW6FhvKnsyzo7Txg+CrAfRnpBU6oAvm1nl1l/9elaSsa88/kN+pf0h9l1RjVF/bMk5y6++VClTYhPAqDnYkJeIQ7lucENe3IoEglhpWTyP44Fh20n/bx2uP1f6ICUP3jhsWa2EJAOrqRrPPiLbPDqDMIGKC7I2TZI3+LFQEdQ4MK3i45zUvCftqDoNYH9x0/gg7vyORW3NnT4pgQApzrXbamnbAY5n6m9EXzH+BjLNPf9KziELREo9lv1ko1ifIlmAt4XysfG1mGu2O8h2VNwOL7/qcbSXOFtuNbmyK8lqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:06 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:06 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] dpaa2-switch: fix the error path in dpaa2_switch_rx()
Date: Thu, 28 May 2026 20:34:49 +0300
Message-Id: <20260528173452.1953102-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
References: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 62678386-eaf4-485b-6c21-08debcdf7556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AiVJwe3SEjFERuNKw1hmXen5rtzBBzLyNqtMH3XHSt/d8qZ3UO9+Yzg3KKihI743bo53GOIY8rmx0yYaebCQY7H8V39dKUZqEN7u4GO2izA0rmKfuva09tZTSxYfF2evCUqKyj+wowGb3NREV9HoopONdXUnaSYJiefsGVeE92S2if30rKvuY1h2F/nmEFHdkmlqe6syzv0U7jT7DEch4p63ZHD4F2BB9iMyQ1eCc+IqUuaaEJUWyxRzEPkJJsyxE6wEnx/BNFIX92rRWLGh3+huz6RkA8bdbvwCu8DMIWRviX9LWu1bFFGFsC3xShMYuFvgHPJLFcUrayRCvCmxUMTFkMwzOaabCL3dZ+ioTPcEBGNzG9nGTx8DW+7H6YsijzajfGpANEd3s4ZOZqnuP+UKaf9J5LbQI6Rde8q2AMifzIso3BdZSRPhH/sP1oKiC17tknGtGxqc2/lqyMQ23mYOYO//xN00uAYMvrRtLhBNQ8ctyqxfKqZTsfrq5gPuPB1U4UBypfvnYL1qQrvbFuMRNQX9Mu5UNn605jPrfXaG5OLbQpLJ4tnH+W3BEajDuwPUgAHDYzhh4TK2gVyc92nbSaMsoCON/D2b+XMLYEty07lBZyGBIC3oWmNJZX94KCwQVah3mvdFiK3myw2DYTQiSemuqecEGbjSVnlH5k8vz3ZEvKkO03mPRzPJ9Q4M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glBrX/lrXpm3mfO783SIg1PzUdpBJG4SgPNqyuIsrrVXFcCxcXsEk+fGEqYj?=
 =?us-ascii?Q?Y5/FXFpiT1vpDB+q0RK8wvXBtg/vEqpw3RZJSI4XNSwIStS6gBR1F5iKK0Np?=
 =?us-ascii?Q?56asJ7BLS0HLuKdiFzqbBYsOX9Evj6djqA7Q0HMAHtmgDv1+3avsuxUPhFBn?=
 =?us-ascii?Q?tJYdpWElV3hleEXC4nfCj5lU+9OqfglCEalT2fthacqn+Ssq9xCjMd0Gb0xo?=
 =?us-ascii?Q?YFmR+8c6Qf0SNmF0er3G+owYKJA1W6VAoKiTcC2P5WGO24Y7d0W5sH/5VMIK?=
 =?us-ascii?Q?Vkov58y70ettuiXLDzNBQUksC8htXOrJKoLWPeIQo/b3ZFWU0EXaE9mYMaM6?=
 =?us-ascii?Q?+xRrzXWfSPnItU3/a1IBYbXmVwtvU2d0u9h7RD5bYPShwr38JxZd5CWbsdFK?=
 =?us-ascii?Q?7BgvoLuXVVv8rUf00t3L2PEGLQSXw9TQd9aMaqKadYRf7e/XOaCVN2oA5S2x?=
 =?us-ascii?Q?20t/sRqEkDFDgQXQTjEVIylW5G6RhxoA3s4WPL7AZcRDKvgGh51FdfPAdIqM?=
 =?us-ascii?Q?KQIlN4csZv1Fry0kD3GiaVJd2RnI2i+thJRZ1ZvknmgCIFvVE5tpHpo6FaUj?=
 =?us-ascii?Q?4vW0y92VdndAz9h9fvSG7S774l0LUWAWdO4xTvVAqoqNDHrcAOiKFoEDU19i?=
 =?us-ascii?Q?pThV0nmSsTQmjaaHCBiP4TvxiGVJ9U6fAxvoR3+AoHRG+2fXoTrBnlSNrgz1?=
 =?us-ascii?Q?vMhmBBmsFWBL9A5j9XlZlcyFUPD5CpamX0b6JAj3sAbvzCD8a91t0h8mc4A9?=
 =?us-ascii?Q?31YkCQzL2ssi8qys/QVD63+gLPOvhp2GAeIO0MdMZ9+6y6NI7rwsV+mJ+4P3?=
 =?us-ascii?Q?99XZ1BbINGLQtg5seJTDwmeEXsDu+CR7hLy7KGYaI5krABLb4njzmqIK+ppc?=
 =?us-ascii?Q?ItPSYlWSt7JLx452n9p9V4EeSMwLJGoHydlcG0ZdgFzfAjw57TvXNk2AIPFy?=
 =?us-ascii?Q?kGLNIm7vF3uo0zmvUY+6h7FPOBAYtOuHFXI8UJ6V/KxhDHDKRl3x7lj5VsqG?=
 =?us-ascii?Q?s6JflYAGn9blbL/mB7jnmKmxpb19eyPVNgdD4T6RaO3i+gKexouZFN1UCngs?=
 =?us-ascii?Q?li8MnPlrWN8ClXGZ7oZfPj4Xt9IL7GqD+bBX87yAzni8zRSQe/3SQ4JHXDQK?=
 =?us-ascii?Q?P1Dtv+mqxuWMaTAM6+6hVLlghnSZk+ccJagIhDswmBS2NL0DsloTEPn1pc4E?=
 =?us-ascii?Q?24fty+d0ZK09CITguyTuyp1Cua6l7zUk+xDcOUcZOI6Bb5fGNX9cb0PGRcWm?=
 =?us-ascii?Q?J6lyHPsmWPaEwOSXIFiPQoNZDzT45aKvGd0Xz7JceFGkq234PC6Jbq6wCdAA?=
 =?us-ascii?Q?eKfd2KNeoYkBNhCnPbapComQFhI0PLuVvJrIWDJHUFLU80FBO3rY0zIr9RI3?=
 =?us-ascii?Q?aCNctBJATFXjYdkEUz6nFHy4D+Rl5VMioVHcH4dUMUcO28Wc9j79N8C9HsTh?=
 =?us-ascii?Q?N2lyFdbwnpJr5mkEXPMm5PKDOOfX1f1oO5OKW+SEzXvv23ssOhsnpQNE8c3G?=
 =?us-ascii?Q?H8M9WD/oHSJtDjZW1eXfc+j9tD3aT/sikp5zstwY+f2pzb86KtQ/fBffX1c4?=
 =?us-ascii?Q?IPrzWfAfp0UCllWm9Wy4HiRzTtG50uqsoKp40NKV0lydm5PM6PCLY55pdPgO?=
 =?us-ascii?Q?hECzMt013u1hIJLVxBtjVcrx8NyFL4Z1qKsl1p9AENvCiudzGHsITESDrIHP?=
 =?us-ascii?Q?Y2Of1KJjpLwNkILguMBNgJy7o989u+xdi6sxXzlWICtflpbbJXJrt8AbrIB1?=
 =?us-ascii?Q?8Br6UepujQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62678386-eaf4-485b-6c21-08debcdf7556
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:06.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB+4XWYEWIuZjE4Oexhw2UVN942QtMssDHDva5N08sd51X5QZdMjHW5lJixOFbKygz8xqGeTfGJyu0MoJTjorA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-292785-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9F515F5D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case of an error in dpaa2_switch_rx(), the dpaa2_switch_free_fd()
function is called in order to free the FD. This is incorrect since the
dpaa2_switch_free_fd() is intended to be used on Tx frame descriptors,
meaning that it expects in the software annotation area of the FD data
to find a valid skb pointer on which to call dev_kfree_skb().

Fix this by extracting the dma_unmap_page() from
dpaa2_switch_build_linear_skb() directly into the dpaa2_switch_rx()
function. This allows us to directly use free_pages() in case of an
error before an SKB was created and kfree_skb() afterwards.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 782fef26b78e..53a32b21b959 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2429,18 +2429,13 @@ static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
 
 /* Build a linear skb based on a single-buffer frame descriptor */
 static struct sk_buff *dpaa2_switch_build_linear_skb(struct ethsw_core *ethsw,
-						     const struct dpaa2_fd *fd)
+						     const struct dpaa2_fd *fd,
+						     void *fd_vaddr)
 {
 	u16 fd_offset = dpaa2_fd_get_offset(fd);
-	dma_addr_t addr = dpaa2_fd_get_addr(fd);
 	u32 fd_length = dpaa2_fd_get_len(fd);
 	struct device *dev = ethsw->dev;
 	struct sk_buff *skb = NULL;
-	void *fd_vaddr;
-
-	fd_vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, addr);
-	dma_unmap_page(dev, addr, DPAA2_SWITCH_RX_BUF_SIZE,
-		       DMA_FROM_DEVICE);
 
 	skb = build_skb(fd_vaddr, DPAA2_SWITCH_RX_BUF_SIZE +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
@@ -2466,6 +2461,7 @@ static void dpaa2_switch_tx_conf(struct dpaa2_switch_fq *fq,
 static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 			    const struct dpaa2_fd *fd)
 {
+	dma_addr_t addr = dpaa2_fd_get_addr(fd);
 	struct ethsw_core *ethsw = fq->ethsw;
 	struct ethsw_port_priv *port_priv;
 	struct net_device *netdev;
@@ -2473,10 +2469,14 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	struct sk_buff *skb;
 	u16 vlan_tci, vid;
 	int if_id, err;
+	void *vaddr;
+
+	vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, addr);
+	dma_unmap_page(ethsw->dev, addr, DPAA2_SWITCH_RX_BUF_SIZE,
+		       DMA_FROM_DEVICE);
 
 	/* get switch ingress interface ID */
 	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
-
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
 		goto err_free_fd;
@@ -2492,7 +2492,7 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		}
 	}
 
-	skb = dpaa2_switch_build_linear_skb(ethsw, fd);
+	skb = dpaa2_switch_build_linear_skb(ethsw, fd, vaddr);
 	if (unlikely(!skb))
 		goto err_free_fd;
 
@@ -2510,7 +2510,8 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 		err = __skb_vlan_pop(skb, &vlan_tci);
 		if (err) {
 			dev_info(ethsw->dev, "__skb_vlan_pop() returned %d", err);
-			goto err_free_fd;
+			kfree_skb(skb);
+			return;
 		}
 	}
 
@@ -2525,7 +2526,7 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
 	return;
 
 err_free_fd:
-	dpaa2_switch_free_fd(ethsw, fd);
+	free_pages((unsigned long)vaddr, 0);
 }
 
 static void dpaa2_switch_detect_features(struct ethsw_core *ethsw)
-- 
2.25.1


