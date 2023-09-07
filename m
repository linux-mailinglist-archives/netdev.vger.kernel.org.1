Return-Path: <netdev+bounces-32435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF201797907
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A71C20B43
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D512134D3;
	Thu,  7 Sep 2023 17:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AC6D22
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:00:38 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25D1BD9;
	Thu,  7 Sep 2023 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694106016;
  x=1725642016;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=diUzlnvHkwnFRUQDjEqQ8wBxKHMIU3epIc6mBh7MkYE=;
  b=W88ZpTZX3ekEmNYyKpOaSrSKFPwOTJWkhsCzNGVZ6KXnhRxvcx8087QH
   hMmvHAUrQYnUQJZSxkSdNSaWNYcAVgnM7IQLYvw1CfPqgKqvq3vxHu6JA
   PSUDANw81BIJr2wx7CrgFRJIvP6SPurfikYtmf4GzStsLh0l+El8iNAVT
   avgaI/4XhUeeQqtIHrLnTU20lA3Et3inuH379mcm8nBJ2ziPsPNXbq93t
   ve8MpuvDbOb7AvjC6lS1sr0wlHcgoPNFYiVuvTABBg5kx6Op7d0oCzJa6
   YsOtFfg9sUxF595SjzJVadqmZbfATYKIln+c9f1p7/Vgpjcs5qK5QK69t
   Q==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Thu, 7 Sep 2023 12:46:31 +0200
Subject: [PATCH net v2] net: stmmac: fix handling of zero coalescing
 tx-usecs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
X-B4-Tracking: v=1; b=H4sIAAaq+WQC/12Nyw7CIBREf6W5azEUa9O68j9MFzwu9iZSDBBS0
 /DvEuLK5ZnJnDkgYiCMcOsOCJgpkt8qiFMHepXbExmZyiC4uPCZDywm56Rm2suXt5ZJLUeFVhk
 xKKijd0BLexM+YMMESw1XismHTzvJfat+vuu/L/esZyjmSXCcrB3NXe4Uz9o7WEopX1DdP1mwA
 AAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: Felix Fietkau <nbd@nbd.name>, Maxim Mikityanskiy <maxtram95@gmail.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
coalescing timer but currently it gets programmed with zero delay
instead.

Disable the use of the coalescing timer if tx-usecs is zero by
preventing it from being restarted.  Note that to keep things simple we
don't start/stop the timer when the coalescing settings are changed, but
just let that happen on the next transmit or timer expiry.

Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Rebased on current net/main.
- Link to v1: https://lore.kernel.org/r/20230905-stmmac-coaloff-v1-1-e29820e8ff6d@axis.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9a3182b9e767..2206789802bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2704,9 +2704,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
-			      HRTIMER_MODE_REL);
+		stmmac_tx_timer_arm(priv, queue);
 
 	flags = u64_stats_update_begin_irqsave(&tx_q->txq_stats.syncp);
 	tx_q->txq_stats.tx_packets += tx_packets;
@@ -2995,9 +2993,13 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	u32 tx_coal_timer = priv->tx_coal_timer[queue];
+
+	if (!tx_coal_timer)
+		return;
 
 	hrtimer_start(&tx_q->txtimer,
-		      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
+		      STMMAC_COAL_TIMER(tx_coal_timer),
 		      HRTIMER_MODE_REL);
 }
 

---
base-commit: 35494b0d61e44b517178aa1c6f5a69168b086940
change-id: 20230904-stmmac-coaloff-aca6befbd24b

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


