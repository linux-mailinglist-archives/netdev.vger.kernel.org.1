Return-Path: <netdev+bounces-29803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0B784C3F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82F41C20B1F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECC34CE0;
	Tue, 22 Aug 2023 21:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15820183
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 21:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0893FC433C8;
	Tue, 22 Aug 2023 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692741104;
	bh=4sFv0MV0ptygyq2DC+30IYpXKnpI6svK4FlhdTRljCs=;
	h=From:To:Cc:Subject:Date:From;
	b=aRHtMc48gZP0p81GzU68J+T/J7Qy60EgsxqHPz3zOXoxDZR0jIM48GwhBadpzY4yB
	 yMkBBJ5OLC6sci0CvtUyEYaeSvyWlN3sEPGlrYKQiKn7qZ0xLJ3/61H+j3HzvEsR3M
	 h7XaBiNTWBDCbchz7HruFGa689o4BaDSD0exrhqNfWCpnogD8lhJ0lr7wMey4vfkZy
	 QIbfJNGHge48QmDat00TTiUpFAi7RAYdl0CelFNrJcrs7Kh39MxARbEfMOaGvQTzb4
	 pXOyIx+YAd5Ydsho5Sb/le9YhkEDQuaWy9DIbDSpj/tbYBOALJgl+gDSlsbpXVStu+
	 uf66Hboku9uNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com
Subject: [PATCH net-next] bnxt: use the NAPI skb allocation cache
Date: Tue, 22 Aug 2023 14:51:42 -0700
Message-ID: <20230822215142.1012310-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of build_skb() (*) in bnxt are in NAPI context.
The budget checking is somewhat convoluted because in the shared
completion queue cases Rx packets are discarded by netpoll
by forcing an error (E). But that happens before skb allocation.
Only a call chain starting at __bnxt_poll_work() can lead to
an skb allocation and it checks budget (b).

* bnxt_rx_multi_page_skb
* bnxt_rx_skb
  ` bp->rx_skb_func
  * bnxt_tpa_end
    ` bnxt_rx_pkt
      E bnxt_force_rx_discard
      E bnxt_poll_nitroa0
      b __bnxt_poll_work

Use napi_build_skb() to take advantage of the skb cache.
In iperf tests with HW-GRO enabled it barely makes a difference
but in cases where HW-GRO is not as effective (or disabled) it
can give even a >10% boost (20.7Gbps -> 23.1Gbps).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5d6ea2782c2f..5cc0dbe12132 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -994,7 +994,7 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	dma_addr -= bp->rx_dma_offset;
 	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
 				bp->rx_dir);
-	skb = build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1069,7 +1069,7 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 		return NULL;
 	}
 
-	skb = build_skb(data, bp->rx_buf_size);
+	skb = napi_build_skb(data, bp->rx_buf_size);
 	dma_unmap_single_attrs(&bp->pdev->dev, dma_addr, bp->rx_buf_use_size,
 			       bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 	if (!skb) {
@@ -1677,7 +1677,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		tpa_info->data_ptr = new_data + bp->rx_offset;
 		tpa_info->mapping = new_mapping;
 
-		skb = build_skb(data, bp->rx_buf_size);
+		skb = napi_build_skb(data, bp->rx_buf_size);
 		dma_unmap_single_attrs(&bp->pdev->dev, mapping,
 				       bp->rx_buf_use_size, bp->rx_dir,
 				       DMA_ATTR_WEAK_ORDERING);
-- 
2.41.0


