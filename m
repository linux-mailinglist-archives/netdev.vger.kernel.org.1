Return-Path: <netdev+bounces-14124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E371773EF81
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12A2280F4E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473215AF0;
	Mon, 26 Jun 2023 23:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680D12B66
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 23:57:13 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FB90E5A;
	Mon, 26 Jun 2023 16:57:12 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 5992020553EC; Mon, 26 Jun 2023 16:57:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5992020553EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1687823831;
	bh=fiPgyc8J5BXMwqhx//yUhPKJcnCZ0LyA5rM0uvnK2RY=;
	h=From:To:Cc:Subject:Date:From;
	b=hwuzGsd2Oc4je6vn0zd2blhZI89dhXLSyTpRe5TdImHU+QimtplZLUomb62Ga1ozO
	 yyl/HRhtzwXuY0YUNAsVfgWjMCkuZYyzlxUFAzpWOVq7fD/gHqDcDxjP99XqwqP4eV
	 3G7iIQ3K0o0LhNNMULVp2YA0FtGWVRutI8KDUZCY=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v3] net: mana: Batch ringing RX queue doorbell on receiving packets
Date: Mon, 26 Jun 2023 16:57:07 -0700
Message-Id: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

It's inefficient to ring the doorbell page every time a WQE is posted to
the received queue. Excessive MMIO writes result in CPU spending more
time waiting on LOCK instructions (atomic operations), resulting in
poor scaling performance.

Move the code for ringing doorbell page to where after we have posted all
WQEs to the receive queue during a callback from napi_poll().

With this change, tests showed an improvement from 120G/s to 160G/s on a
200G physical link, with 16 or 32 hardware queues.

Tests showed no regression in network latency benchmarks on single
connection.

While we are making changes in this code path, change the code for
ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
hardware specification specifies that it should set to 0. Although
currently the hardware doesn't enforce the check, in the future releases
it may do.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
Change log:
v2:
Check for comp_read > 0 as it might be negative on completion error.
Set rq.wqe_cnt to 0 according to BNIC spec.

v3:
Add details in the commit on the reason of performance increase and test numbers.
Add details in the commit on why rq.wqe_cnt should be set to 0 according to hardware spec.
Add "Reviewed-by" from Haiyang and Dexuan.

 drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 8f3f78b68592..3765d3389a9a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -300,8 +300,11 @@ static void mana_gd_ring_doorbell(struct gdma_context *gc, u32 db_index,
 
 void mana_gd_wq_ring_doorbell(struct gdma_context *gc, struct gdma_queue *queue)
 {
+	/* Hardware Spec specifies that software client should set 0 for
+	 * wqe_cnt for Receive Queues. This value is not used in Send Queues.
+	 */
 	mana_gd_ring_doorbell(gc, queue->gdma_dev->doorbell, queue->type,
-			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 1);
+			      queue->id, queue->head * GDMA_WQE_BU_SIZE, 0);
 }
 
 void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index cd4d5ceb9f2d..1d8abe63fcb8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1383,8 +1383,8 @@ static void mana_post_pkt_rxq(struct mana_rxq *rxq)
 
 	recv_buf_oob = &rxq->rx_oobs[curr_index];
 
-	err = mana_gd_post_and_ring(rxq->gdma_rq, &recv_buf_oob->wqe_req,
-				    &recv_buf_oob->wqe_inf);
+	err = mana_gd_post_work_request(rxq->gdma_rq, &recv_buf_oob->wqe_req,
+					&recv_buf_oob->wqe_inf);
 	if (WARN_ON_ONCE(err))
 		return;
 
@@ -1654,6 +1654,12 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 		mana_process_rx_cqe(rxq, cq, &comp[i]);
 	}
 
+	if (comp_read > 0) {
+		struct gdma_context *gc = rxq->gdma_rq->gdma_dev->gdma_context;
+
+		mana_gd_wq_ring_doorbell(gc, rxq->gdma_rq);
+	}
+
 	if (rxq->xdp_flush)
 		xdp_do_flush();
 }
-- 
2.34.1


