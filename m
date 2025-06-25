Return-Path: <netdev+bounces-200907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F770AE74F3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EE3ADF8E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F638FB0;
	Wed, 25 Jun 2025 02:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0C1EA73
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819912; cv=none; b=gJj0nptHjBwOuv49V8ekJJbLOJ4u9y7gLef7dKDBrItopQPb7ta3WSuM008KYXyHejsPayxztHvp9kwQ+XbGk0BllxoYLDYlxPB4S/wqy6ZM70OCPok9Gm2AyJY5eoaj3b/BLCGjd46XyDSOFiVmmrOKYASHHUgR3b7qHNojK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819912; c=relaxed/simple;
	bh=76O9Wj5Ul+EhuOXnDR6dDQw8gB/ZpDyiqenMfD6gMrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZL9MYFvoZkRVz4/ePp1Cdy06i4hvBmh0nJaTjwKAUZLXD0K5/nrQIVjguZKjNevYmZhC2MGD/e0bqKSl8GOVdTcGkbcuQCsVBc/8yi9gL7zJ++PZ/MmsGlaroJlvebYe8a351D2fU8RmDLYwrCbGLwcPZVP/eXagdDoMRyJcLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: RQz7XIEZRfSD6zQw4klrkw==
X-CSE-MsgGUID: W3l9fVWGSZu3x6laMDNs5w==
X-IronPort-AV: E=Sophos;i="6.16,263,1744041600"; 
   d="scan'208";a="144173493"
From: EricChan <chenchuangyu@xiaomi.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>
CC: Feiyang Chen <chenfeiyang@loongson.cn>, Serge Semin
	<fancer.lancer@gmail.com>, Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen
	<chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, xiaojianfeng
	<xiaojianfeng1@xiaomi.com>, EricChan <chenchuangyu@xiaomi.com>, xiongliang
	<xiongliang@xiaomi.com>
Subject: [PATCH] net: stmmac: Fix interrupt handling for level-triggered mode in DWC_XGMAC2
Date: Wed, 25 Jun 2025 10:51:34 +0800
Message-ID: <20250625025134.97056-1-chenchuangyu@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX08.mioffice.cn (10.237.8.128) To BJ-MBX15.mioffice.cn
 (10.237.8.135)

According to the Synopsys Controller IP XGMAC-10G Ethernet MAC Databook
v3.30a (section 2.7.2), when the INTM bit in the DMA_Mode register is set
to 2, the sbd_perch_tx_intr_o[] and sbd_perch_rx_intr_o[] signals operate
in level-triggered mode. However, in this configuration, the DMA does not
assert the XGMAC_NIS status bit for Rx or Tx interrupt events.

This creates a functional regression where the condition
if (likely(intr_status & XGMAC_NIS)) in dwxgmac2_dma_interrupt() will
never evaluate to true, preventing proper interrupt handling for
level-triggered mode. The hardware specification explicitly states that
"The DMA does not assert the NIS status bit for the Rx or Tx interrupt
events" (Synopsys DWC_XGMAC2 Databook v3.30a, sec. 2.7.2).

The fix ensures correct handling of both edge and level-triggered
interrupts while maintaining backward compatibility with existing
configurations.

Signed-off-by: EricChan <chenchuangyu@xiaomi.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7840bc403788..5dcc95bc0ad2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -364,19 +364,17 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 	}
 
 	/* TX/RX NORMAL interrupts */
-	if (likely(intr_status & XGMAC_NIS)) {
-		if (likely(intr_status & XGMAC_RI)) {
-			u64_stats_update_begin(&stats->syncp);
-			u64_stats_inc(&stats->rx_normal_irq_n[chan]);
-			u64_stats_update_end(&stats->syncp);
-			ret |= handle_rx;
-		}
-		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
-			u64_stats_update_begin(&stats->syncp);
-			u64_stats_inc(&stats->tx_normal_irq_n[chan]);
-			u64_stats_update_end(&stats->syncp);
-			ret |= handle_tx;
-		}
+	if (likely(intr_status & XGMAC_RI)) {
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
+		ret |= handle_rx;
+	}
+	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
+		u64_stats_update_end(&stats->syncp);
+		ret |= handle_tx;
 	}
 
 	/* Clear interrupts */
-- 
2.34.1


