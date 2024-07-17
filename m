Return-Path: <netdev+bounces-111849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9292593395B
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D0E283002
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170303BBF7;
	Wed, 17 Jul 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtMYmIOM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A73BBF4
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206046; cv=none; b=S94xI/9clEeA5/v81HndsXA04XllwCtcuAnMAzjbnmh118W0YgcGwQjecKOV98Wh6WCizyXdsgnBEbhG8TxkQhDxPqhtg0I4CSMXMECh0ZmNiYXIIpMl/7w3pC477fztNbd4n1LdC22ooHKevkYBxlc0mfi7L0tYomRfsGw1GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206046; c=relaxed/simple;
	bh=KH7lMEIWSZuYFrVjZzqlywLaovvhMmEPrNQkmA+0g/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnExjp3zvodjjXTlabFHkGCFyo1a46tV4H5ggGzrlhKZKAEqEMd4SSYltQoZaLu9jH7psOCne2ByS3pkwMFr3LYin0mXkNatT2ZpFYsWPYtRR50uZq2/hwOWIKhyR5zM4F1dZYBLtV8rRnP3WMN/L5/Tk+AwnWfIbliJ7cg75S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtMYmIOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EF8C32782;
	Wed, 17 Jul 2024 08:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721206045;
	bh=KH7lMEIWSZuYFrVjZzqlywLaovvhMmEPrNQkmA+0g/U=;
	h=From:To:Cc:Subject:Date:From;
	b=gtMYmIOMLm+z/+2OLUgPvDzoDUhF/feWRieVSc8VELPXm95xRwbTexLkptPTBkO8e
	 gieMy09N9lfXGVnHxbYNL+9+0xuzAGap6K6eXtes1I1TiLdqw55H4u7yKYDLUWiOFC
	 Qbfu8M7wEW+EIrAcEac7KqFlq9+n0+5RiPm1rIrH3SxPxoet73xEgEmMT2YGjeEgAp
	 U3BcNh4E2qcrwPSIhD1qolfBV1yGm4vMad2Ii5AGdKGzxuk8bJRn8JFOKwPn/eLoug
	 yjD8hyYRukyGu+8BkiPRG/Njk4SrIAkNfSJSa+ImoFPAOn7D/2bYMeA5rfBFROXSA4
	 b39Ggsh6BC1lg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com
Subject: [PATCH net] net: airoha: Fix NULL pointer dereference in airoha_qdma_cleanup_rx_queue()
Date: Wed, 17 Jul 2024 10:47:19 +0200
Message-ID: <7330a41bba720c33abc039955f6172457a3a34f0.1721205981.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move page_pool_get_dma_dir() inside the while loop of
airoha_qdma_cleanup_rx_queue routine in order to avoid possible NULL
pointer dereference if airoha_qdma_init_rx_queue() fails before
properly allocating the page_pool pointer.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index cc1a69522f61..16761fde6c6c 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1585,7 +1585,6 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 
 static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 {
-	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
 	struct airoha_eth *eth = q->eth;
 
 	while (q->queued) {
@@ -1593,7 +1592,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 		struct page *page = virt_to_head_page(e->buf);
 
 		dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
-					dir);
+					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
-- 
2.45.2


