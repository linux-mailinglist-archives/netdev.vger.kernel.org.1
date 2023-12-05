Return-Path: <netdev+bounces-53798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE7804AA0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D04E1C20C9F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058512E71;
	Tue,  5 Dec 2023 06:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5701109
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 22:53:50 -0800 (PST)
X-QQ-mid: bizesmtp69t1701759042t9rcroc6
Received: from dsp-duanqiangwen.trustnetic.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Dec 2023 14:50:40 +0800 (CST)
X-QQ-SSF: 01400000000000D0E000000A0000000
X-QQ-FEAT: CR3LFp2JE4lDhXGU5C6AEbq8AZd/Cs7P6ZQ6c/PfFez/YJBgNVA7LrfUu6et/
	vo7Nl+OmOikpTAXd9DWAs81T2Anmp6zPVOQrkHj0msCBdYCAt1Z15NvaTvN3JbBiLUsIRX8
	jw3FEamTBj4i/pf/xyHoDzagIvDIuFhP2e6/xWcca1rwWlJZpvrLXmKEwIUeQ35XrHlf7+3
	ocoN5OkqSjSDTpy6ArUiIGYgcQv2uuwjYbJ4l5BZHT6sF9zqxO99NWygoTldOz+kyMP1RaW
	FHdPHO8QoUAwesBnGCBpqAyi9m/uAoJXQR0+CdOffYpTCXsGtid5MmyGCSu7BXBbsteUVwA
	IvoP29QwOc043zRemaRJACchjCzfRPMF3BvRQnxpkpXWw0BJIMZH4J0wHbSCHdIV8GqxJiY
	yc+arjEjUjwQjurBMbXGyg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7161745348621205028
From: duanqiangwen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	yang.lee@linux.alibaba.com,
	error27@gmail.com,
	horms@kernel.org
Cc: duanqiangwen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: libwx: fix memory leak on free page
Date: Tue,  5 Dec 2023 14:50:33 +0800
Message-Id: <20231205065033.19536-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.12.2.windows.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

ifconfig ethx up, will set page->refcount larger than 1,
and then ifconfig ethx down, calling __page_frag_cache_drain()
to free pages, it is not compatible with page pool.
So deleting codes which changing page->refcount.

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")

Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 83 +++-------------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  1 -
 2 files changed, 7 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index a5a50b5a8816..945543dd5f15 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -160,60 +160,6 @@ static __le32 wx_test_staterr(union wx_rx_desc *rx_desc,
 	return rx_desc->wb.upper.status_error & cpu_to_le32(stat_err_bits);
 }
 
-static bool wx_can_reuse_rx_page(struct wx_rx_buffer *rx_buffer,
-				 int rx_buffer_pgcnt)
-{
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
-	struct page *page = rx_buffer->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((rx_buffer_pgcnt - pagecnt_bias) > 1))
-		return false;
-#endif
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buffer->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
-/**
- * wx_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: rx descriptor ring to store buffers on
- * @old_buff: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- **/
-static void wx_reuse_rx_page(struct wx_ring *rx_ring,
-			     struct wx_rx_buffer *old_buff)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct wx_rx_buffer *new_buff;
-
-	new_buff = &rx_ring->rx_buffer_info[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	new_buff->page = old_buff->page;
-	new_buff->page_dma = old_buff->page_dma;
-	new_buff->page_offset = old_buff->page_offset;
-	new_buff->pagecnt_bias	= old_buff->pagecnt_bias;
-}
-
 static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 			     struct wx_rx_buffer *rx_buffer)
 {
@@ -270,8 +216,6 @@ static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 skip_sync:
-	rx_buffer->pagecnt_bias--;
-
 	return rx_buffer;
 }
 
@@ -280,19 +224,9 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			     struct sk_buff *skb,
 			     int rx_buffer_pgcnt)
 {
-	if (wx_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
-		/* hand second half of page back to the ring */
-		wx_reuse_rx_page(rx_ring, rx_buffer);
-	} else {
-		if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
-			/* the page has been released from the ring */
-			WX_CB(skb)->page_released = true;
-		else
-			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-	}
+	if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
+		/* the page has been released from the ring */
+		WX_CB(skb)->page_released = true;
 
 	/* clear contents of rx_buffer */
 	rx_buffer->page = NULL;
@@ -335,11 +269,12 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 		if (size <= WX_RXBUFFER_256) {
 			memcpy(__skb_put(skb, size), page_addr,
 			       ALIGN(size, sizeof(long)));
-			rx_buffer->pagecnt_bias++;
-
+			page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 			return skb;
 		}
 
+		skb_mark_for_recycle(skb);
+
 		if (!wx_test_staterr(rx_desc, WX_RXD_STAT_EOP))
 			WX_CB(skb)->dma = rx_buffer->dma;
 
@@ -382,8 +317,6 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 	bi->page_dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
-	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
 
 	return true;
 }
@@ -723,7 +656,6 @@ static int wx_clean_rx_irq(struct wx_q_vector *q_vector,
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
-			rx_buffer->pagecnt_bias++;
 			break;
 		}
 
@@ -2248,8 +2180,7 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 
 		/* free resources associated with mapping */
 		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
+
 
 		i++;
 		rx_buffer++;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 165e82de772e..83f9bb7b3c22 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -787,7 +787,6 @@ struct wx_rx_buffer {
 	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
-	u16 pagecnt_bias;
 };
 
 struct wx_queue_stats {
-- 
2.12.2.windows.1


