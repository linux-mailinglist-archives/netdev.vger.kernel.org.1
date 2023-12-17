Return-Path: <netdev+bounces-58370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A5816033
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 16:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C5C1F21E19
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240B43AAB;
	Sun, 17 Dec 2023 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTEQ+v40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D644C82
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 15:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C335AC433C8;
	Sun, 17 Dec 2023 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702827477;
	bh=GK7xAUGF66NpUpUig6hIj6/sKGq7G9HW5IE15iuBjb8=;
	h=From:To:Cc:Subject:Date:From;
	b=FTEQ+v40mXkS6e04xHul8k6JolCDsURXrm3YRcQCaI4vNYtemLLS6D6ZBig0kEkj0
	 wTTliYDQttNMn5IizXVn8oCGRlqvyUwkg7KZL7B7SUOwvmc7/f9CTmEbWOp1E2p1Mm
	 1FnsKXWN392NlaBdI3pAfULNIFQRkub+pqbtOeN74nzMlbFZ7Z1YbKXUc3+BsQcC8i
	 mf34KmeeP6pTEobnXTMWB3NUjTg0Edz6C3WFGeQS+xa/ij/t7rjcQ5A9kDZ1rvm/Vw
	 xhfrtcQPoDu3sl/lCI3YtAYwYidV+ltKdSgwZy1RjeAeXp6vQNBE+5638ClRsnZD5Z
	 tXWNa1TVv32nQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net] net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()
Date: Sun, 17 Dec 2023 16:37:40 +0100
Message-ID: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to avoid a NULL pointer dereference, check entry->buf pointer before running
skb_free_frag in mtk_wed_wo_queue_tx_clean routine.

Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 3bd51a3d6650..ae44ad5f8ce8 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -291,6 +291,9 @@ mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 	for (i = 0; i < q->n_desc; i++) {
 		struct mtk_wed_wo_queue_entry *entry = &q->entry[i];
 
+		if (!entry->buf)
+			continue;
+
 		dma_unmap_single(wo->hw->dev, entry->addr, entry->len,
 				 DMA_TO_DEVICE);
 		skb_free_frag(entry->buf);
-- 
2.43.0


