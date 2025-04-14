Return-Path: <netdev+bounces-182263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50AA885CD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB90019024A3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4592797B0;
	Mon, 14 Apr 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQooXDFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611C27979D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641132; cv=none; b=XMraWqmGQNmbGiqv6aBB9rkeb/ptQwdozC+tfZNG+sM+pZKy8a8wmTOfkSLhWmTFFWdAEuaVFunu12ZX8Kh6wDGtiWzjGaKmnxxStlqYAQisZ80E2UJR/kTc39Dqs0We+UCWEbfdrWi7aHdFQ91Z3EwTxjNgphwNWCdX71VkdQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641132; c=relaxed/simple;
	bh=Z4hsuMye1QWPaRlENCQ3hF2g0yGPZJXBKHsUZzi2MP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBo7ROqxAxcNcIRN1vJMyhPfvA/frjrRU1xO/qOHHG+u9g7rRGw8EJIFc7gUTBFXhs8aP4i1ScFGBCeJ7RKcyDuHeMzf8zliFJU8qhxOE5UaevPQIIaXcANwLiDE/LF3NasnZ8YK2VWrh1W9DceDINmSPgW1UFUI2TziB626X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQooXDFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C370C4CEE2;
	Mon, 14 Apr 2025 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641131;
	bh=Z4hsuMye1QWPaRlENCQ3hF2g0yGPZJXBKHsUZzi2MP8=;
	h=From:To:Cc:Subject:Date:From;
	b=UQooXDFi4h1/ISfVPj+QxqFX9LNr1ZTem+MGKfQevdt+2S5tGH+ayeAmn/tvifycN
	 efoszND+CF8rSng0bMFMm7tsQiZWPmW4sNL5qeiuzMBZNGSxtCVo9ICcCWyinHaWUX
	 YEnsHqPCVLfPY91WtUZGPoivJFBsT2OZsJkWjEfwbtCujOfeozoqEtfXjpJ4N/XHLS
	 JK03ccRfRKOblk387GDAODzsvTAtZgNU41pkhWFdZrtJmuQ6oQaagH6J9ypX4tq6IB
	 VIJ60AdpcTV0dmvEg8ubzs5im5fX7qpha7/u7BuuayziGDxZy8GF2xPmNRucgADZq3
	 dgzHw0VVzo9nQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net] eth: bnxt: fix missing ring index trim on error path
Date: Mon, 14 Apr 2025 07:32:10 -0700
Message-ID: <20250414143210.458625-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under Fixes converted tx_prod to be free running but missed
masking it on the Tx error path. This crashes on error conditions,
for example when DMA mapping fails.

Fixes: 6d1add95536b ("bnxt_en: Modify TX ring indexing logic.")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8725e1e13908..c8e3468eee61 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -787,7 +787,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_kfree_skb_any(skb);
 tx_kick_pending:
 	if (BNXT_TX_PTP_IS_SET(lflags)) {
-		txr->tx_buf_ring[txr->tx_prod].is_ts_pkt = 0;
+		txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].is_ts_pkt = 0;
 		atomic64_inc(&bp->ptp_cfg->stats.ts_err);
 		if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
 			/* set SKB to err so PTP worker will clean up */
@@ -795,7 +795,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
-	txr->tx_buf_ring[txr->tx_prod].skb = NULL;
+	txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].skb = NULL;
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
-- 
2.49.0


