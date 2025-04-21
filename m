Return-Path: <netdev+bounces-184465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F287A9596A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E6C160DAE
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005DE22A81C;
	Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjaRuO/V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093722A80F
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274524; cv=none; b=P9/PsW5AYdn82Zkrw8EVwy5lLMcwuCM5N5nGa9CDV3SHqe3ADOvndrd9eUe7UbUaOIyB4t9rCa4dtHiFBnWnt2u8A5N6N7CIalXJ63zoyjHxLs6ZxVqwdl8bZDaKe3bTShDZ7/edTw7ncIBVjEXpzl88e+ulNLEcDcSLr0UNH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274524; c=relaxed/simple;
	bh=2VQ4PFlhMGY7MTA8SYamdP8dGvcuh/hpS4ZIfN1jB3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCZZnNwdudIJtYsqYQxth+tI2GWPD/3oOEgC3XnemopzYtyS0wUCwTuwl0qlM+aKZJFh9n5ml9V54NQImPnnzrCJ6IWoca0xJ+WwD+SIiYG7xiTlZ2HYagkm5msvVAbX+lSRER/X8F4nHyuoFGyKeEmNtguB80+MWqGp/pSqTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjaRuO/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C07C4CEEC;
	Mon, 21 Apr 2025 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274524;
	bh=2VQ4PFlhMGY7MTA8SYamdP8dGvcuh/hpS4ZIfN1jB3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjaRuO/VOzMrPT578e9FIAUEps43UULezLZaoaE0TgUnn6pbujdjQXyyPMxFGFhh8
	 +rMpp11ZP8aDXuaWC5cBqGKtmPxnC4wRJnBgH2DFUSgncGiMTs05v0Llr5Vjj91imW
	 +ZaLkH40rebPnLhjFggXI19xbbjdqe1xXnRygWF3fH/lZuZ5yka1XngicBIw7GVdRe
	 b/lyzwpqpTHn82Pv7lPHuMZ2PzJsLuMiwOAwwPcM7gaJw55qcM7f/xWlWfJfuy4csv
	 z1VWL5umMzE8ZzzO/jU88SH9wc0FTs5lHxZ8v/g6j00j+oDFgex2uKnu0qLmtrkm5h
	 wMckM/e6Nxpgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 16/22] eth: bnxt: adjust the fill level of agg queues with larger buffers
Date: Mon, 21 Apr 2025 15:28:21 -0700
Message-ID: <20250421222827.283737-17-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver tries to provision more agg buffers than header buffers
since multiple agg segments can reuse the same header. The calculation
/ heuristic tries to provide enough pages for 65k of data for each header
(or 4 frags per header if the result is too big). This calculation is
currently global to the adapter. If we increase the buffer sizes 8x
we don't want 8x the amount of memory sitting on the rings.
Luckily we don't have to fill the rings completely, adjust
the fill level dynamically in case particular queue has buffers
larger than the global size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 28f8a4e0d41b..43497b335329 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3791,6 +3791,21 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
+static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	/* User may have chosen larger than default rx_page_size,
+	 * we keep the ring sizes uniform and also want uniform amount
+	 * of bytes consumed per ring, so cap how much of the rings we fill.
+	 */
+	int fill_level = bp->rx_agg_ring_size;
+
+	if (rxr->rx_page_size > bp->rx_page_size)
+		fill_level /= rxr->rx_page_size / bp->rx_page_size;
+
+	return fill_level;
+}
+
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   int numa_node)
@@ -3798,7 +3813,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
 
-	pp.pool_size = bp->rx_agg_ring_size;
+	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr);
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size;
 	pp.order = get_order(rxr->rx_page_size);
@@ -4366,11 +4381,13 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 					  struct bnxt_rx_ring_info *rxr,
 					  int ring_nr)
 {
+	int fill_level, i;
 	u32 prod;
-	int i;
+
+	fill_level = bnxt_rx_agg_ring_fill_level(bp, rxr);
 
 	prod = rxr->rx_agg_prod;
-	for (i = 0; i < bp->rx_agg_ring_size; i++) {
+	for (i = 0; i < fill_level; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
-- 
2.49.0


