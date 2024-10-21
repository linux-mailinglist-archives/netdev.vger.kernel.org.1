Return-Path: <netdev+bounces-137372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CB9A5A1D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49151F21624
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781F192D98;
	Mon, 21 Oct 2024 06:05:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75467148FF9;
	Mon, 21 Oct 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729490715; cv=fail; b=J7GR538VnFUrfnTUHvVAZqzYHxqBKR7qExkxbQCokBJfhDjwTQpdX0ndu7wH9YgZ0KsUWXQ/OVHrMCOaBsIZ7FaJna2hsGk1JoEgknh0f427D3rxlNsVz0pd8yeIDqspyynZlE6ENPv/y0gQrD9jEXa3DwVz4V3Z5WWte/2aGLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729490715; c=relaxed/simple;
	bh=R+EeBlj86pRNtPtgXv896mqaSsSseyfHwsT8jQ5djoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkFYbXIZBLZH0DN+jYjOgMUqXHXAqz6W9D9nR8KGH4OlPY2F6u97E14D06Z7x4g88eie3RIhigAXN284oCbOU53LpmL1xN1FC70ToZzmOHGfPFvRXtV9gARjT5UugXBOnGjI5akZ039YkqvVfSP9ZEE9SsGZNV86AZccYPLTpSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3rTQxMuPcQQCLrf1jJr9Mgwrxbr/RLgf/LRuYtsmFcWlRH9E5KVtMvAKz7irY1WaCCHRiONkQ/IrZK0E6P3uowLNYKPvYAIIaz2XkA+mwUfGLNcHvtyZ3OV4mgT5O4paNv0nj0m6y4iV9i25tz1y2rFWiBbu/j6CShtS2D0kg0WZTI/xUIXPdw+8Qdki4DST/ZYGFVnN6ZVntk1lLtcrbJB9KWrjVtZp5HlqFQSYH4r4arMzw3P4774kZf4OhMpC3B7uWs82+uBPI2UmNsSDy3YdXpB/hgv8/cIv4slh8dv0w3eoxpWyGgbOKpU7pK2QD0659QetUi+Ln4NruVAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sNVfhZi9kq6WRMkg6s9bACOW5z61wVpEKgboggd3Zs=;
 b=M/T+6pF4G939G/z9iIuIqHWmatCQyWDXYe8/WP75CwBNZx9cSuFuuo/rODJFvtgBJs85mQrCUVptWvEH5w0FgWUCVYgYpL/yqEne1ZT0xyLJtI1QfbyY2xh1Rn3jNgufS3zJKoXHm5xi1tVzEAxdtRXcz25p4Za8n/7+Ltb+g2pF4yRhD+rtx4esnq+KqnCmVwypxVwkYA9FGKEoJNMD2IM1GyNMBuXHUFyOFa4OR41cS7oKbtaQ0REHbsC0ktMX/UR3TrVEPDQKR3q1kuw+52+c9tiw9Eh1vug5X1uxvrIrf6fRTwmGsKFt4NVN3lKeifkBFooALCgQGofygUUM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0996.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Mon, 21 Oct
 2024 05:49:16 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8069.016; Mon, 21 Oct 2024 05:49:16 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next, v1 3/3] net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal interrupt summary
Date: Mon, 21 Oct 2024 13:48:48 +0800
Message-ID: <20241021054849.1801838-4-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
References: <20241021054849.1801838-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::15) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0996:EE_
X-MS-Office365-Filtering-Correlation-Id: a164545b-4736-4a28-993f-08dcf1941923
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	B9fdFMDltopznV+mF9z0mgMzVtoHacy/lZ3BLo97ZIrgzkS4KgF13teipfm/0gSpGilARxPuVl75AqcDc5edC4tdvQlTy4N4/fcGVWu2+Uo8Xigv+/Q8ElJjtr0vGCq/XEw3h9lkIb+lZz/eF9wWwgfi5SYqHsYfLSpH6BalNIQSYnnWYcRrAjAi5YZQvwew5CCkBZat6iTobsLAuPUqCVw0948nSHKUSvFK1kFzEtt4D0iy3kQQPmdT7ytoSokXWMBYpIMm6XNYzDjaYfgpVENVPIpQ0rMNoNHEPvSp0l86DMHiB1+FN/leEjJ6JHnSqq9sluLRhc85Vhi443wt9NXJrUPMJvc4Edbovxfcu7a+weGAL9KscZiQyVLZMfjX38J4BMlwDNQusBo8jeR0EEzdJvqJ1+NlqtT5898DwkEW1T0m7qOAA580hg8MwtA9LXcbX1iiz8KDKrXYAgdpnd0jAc59jUBeLbbxxkBP2kl1GXV+0WZ/pjP3KpB9hJ288NLhUEFh/9V+M5RaHwpatnS0yfnodPv16UnBFQTq6ioix6AzSfRiaukD81sYLpKFs3UMujMzWVI/BPrY3uhOkcNsoYpGzdMKL1Dmb2OwY8UYIGFKQUjS9BUT0CPtVREd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?69GpiCog967GC6fHlzf+sohmxO5xLrZ+3k2HuAoWnZERuCUHcfAoS29cIM+W?=
 =?us-ascii?Q?HvYCEl11UMq9sIsGsWo0vRzHNsuFzvWhYPxdykBTy96VYPG0TmHZg59PBsgm?=
 =?us-ascii?Q?Ss5hixNJpcDJBLQwZFSyOToVE31UChahF3ZDYg9576QkBbOsxP/Cqoj7qfqy?=
 =?us-ascii?Q?07uSFRNzQezD1XxXGpaO5T/hD3U4BoiNBDzWzzqZ/2mQgHoo2wVgh5aKXzth?=
 =?us-ascii?Q?T9mr0z5Fxc8LA4csV5SSN9veIC8oJp/SjN4Y/ioMB+2I14fcnytCwAeyAf3G?=
 =?us-ascii?Q?ege5Dnwp0ThiHzR7IisS83ImKWMLVqfC2HLo9fsJPbfa6Rv/MoIWynvxiwa4?=
 =?us-ascii?Q?e1PCiW006tNVX4Goig5H1R5rmA1ma5WD9nzBeyYFdfV3zd4c403tnOO/6JDd?=
 =?us-ascii?Q?PTUs+gjsP2ncEdoB2x3XMET01Hl6j4x+tNE3RXOJZhOMChW/hl1J/dOlzt5d?=
 =?us-ascii?Q?pTR/ft+LICdY48M47TxaegCKvfKzDqxXfa2lkpvGLyg5wpD4+hujNF4f+b15?=
 =?us-ascii?Q?ICs2J0ySCoDeppjIJzi5ErElRGJYaCNKc7mpnbVCty1E8jLOQNYduftpcir0?=
 =?us-ascii?Q?a8D/cnKxwEqxWFlgjafT71FoegX4VeUNY5fZ0pk7vnDLE7lixmeCmGONuce6?=
 =?us-ascii?Q?oaAXPPGIawGBz0D2vyoQYKfOrIV/MZ3sKY5RUsS9gekoEr+sgh1kzG36o0bR?=
 =?us-ascii?Q?omjVgwA5GO/Jy76GwSH0kODmcJMHrytbhcrZZ2yNTmZVAjy1XgD7MwNWDguG?=
 =?us-ascii?Q?wXCdBRxeEnZj012plXtPoXENsl1uKcQL4X9tItGo8n7DIcrAWj3FKjGbjuNh?=
 =?us-ascii?Q?XkJH+jsdt0hjat04Xe5Ny8sbdxw8iQYo6fyp6o/CT2sBSOvr+4VJBYXWR4op?=
 =?us-ascii?Q?/I99dXdQeGUCY2TShSU/2vvLUms9HbPWLrgYCtW5ryMhi1doqPWdZg0qXlMK?=
 =?us-ascii?Q?aBX7dtDadDybWnOked7ZbMYQtcy46+7KOdfA3DSoSfg73rzoTSImyZEDjsiX?=
 =?us-ascii?Q?GkG+DfNPFU/0ZrPDmXXAs4qPRZgWZJOQ6if7vhAPHBex0q9lJ+MyK2lQHydG?=
 =?us-ascii?Q?qrRNiMnxdunXj4gThk72IvzRiHBia9uGC0pGJD2ervpqwPNNKbUXjkz2Gl/a?=
 =?us-ascii?Q?QXsRGkqjOCO0LCYtawYIP9MDi9KwUaMdDF4OERTMLNzP9ehof6EbLoXqaVb+?=
 =?us-ascii?Q?igii4NS8AffkXiTQZPJXUriyr+rUWn1vMEi2uZTyMqmCEnPg0VD00bB+Xl0O?=
 =?us-ascii?Q?f8DzYwkVXisINSTkIKsWnB2bVtokW71DlzCHbMlvqPMni5JL9vE9HO8nVHA5?=
 =?us-ascii?Q?CWHzuiFrO/Ljogxl23gqERGxYu/5F3q0GTjc0WKyRROwDvJFrgOcGdKqnn+0?=
 =?us-ascii?Q?rJtyJgonmHK7gaSHNVvGicIZkPW4/rkfZ5Ycma/+DSndG+/CiHxANDDOC1zO?=
 =?us-ascii?Q?Zl7OjQYXUjlyay++lx2ElAWn8NhWuvVPwmMAzVskK22QicQgF8bfXY5HaGpj?=
 =?us-ascii?Q?axDaAniXoy8HVzJXdbCLqc4IUhP+ogYeSW828C/hfq4/4HGbeUAvqHazAVyn?=
 =?us-ascii?Q?tfK4ybkM3HZH7lAivREMZPBUObilz+lHI14LkB3G00bko/NwOM83bu52kkIm?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a164545b-4736-4a28-993f-08dcf1941923
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:49:16.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvC1E+h7OkT6y9dYZWnWEWP2r2WtNxbvAhY6AEEBsPTLbTWrUj/mBF7qrQGOc4BOHGBIRfr/SBRuNktuo6zmBgV5V4Uzrceblmch1/uOuXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0996

The Receive Watchdog Timeout (RWT, bit[9]) is not part of Abnormal
Interrupt Summary (AIS). Move the RWT handling out of the AIS
condition statement.

From databook, the AIS is the logical OR of the following interrupt bits:

- Bit 1: Transmit Process Stopped
- Bit 7: Receive Buffer Unavailable
- Bit 8: Receive Process Stopped
- Bit 10: Early Transmit Interrupt
- Bit 12: Fatal Bus Error
- Bit 13: Context Descriptor Error

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 0d185e54eb7e..57c03d491774 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -185,8 +185,6 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			x->rx_buf_unav_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_RPS))
 			x->rx_process_stopped_irq++;
-		if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
-			x->rx_watchdog_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_ETI))
 			x->tx_early_irq++;
 		if (unlikely(intr_status & DMA_CHAN_STATUS_TPS)) {
@@ -198,6 +196,10 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			ret = tx_hard_error;
 		}
 	}
+
+	if (unlikely(intr_status & DMA_CHAN_STATUS_RWT))
+		x->rx_watchdog_irq++;
+
 	/* TX/RX NORMAL interrupts */
 	if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
 		u64_stats_update_begin(&stats->syncp);
-- 
2.34.1


