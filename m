Return-Path: <netdev+bounces-18422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33432756D6F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643DA1C20BC3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB8C2E2;
	Mon, 17 Jul 2023 19:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFCC2CF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:35:56 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E435ABE;
	Mon, 17 Jul 2023 12:35:54 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
	id 74E7921C7A03; Mon, 17 Jul 2023 12:35:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74E7921C7A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1689622554;
	bh=XYVYgOirAsauRpIsvXixfB6J0evqIQh9opQ7LMpeBYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTGZ63aKpVdiObPnWxlrtfW3yuiycFmIC1TMO5NpnDGQWVNEYqaMuBnfdW0yxyWf/
	 d10Ag5aFp1R8bnomNulbwL9ag3CVAsyx6VuRhD1oDE4ILLKoauQp9RDn5AQ6AedqPy
	 onH5hYPH7JDTMAQv2jf7Q+YevKdEUUFV6G3AQXhQ=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Shachar Raindel <shacharr@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH net-next v5 2/2] net: mana: Use the correct WQE count for ringing RQ doorbell
Date: Mon, 17 Jul 2023 12:35:39 -0700
Message-Id: <1689622539-5334-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
References: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

The hardware specification specifies that WQE_COUNT should set to 0 for
the Receive Queue. Although currently the hardware doesn't enforce the
check, in the future releases it may check on this value.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
Change log:
v4:
Split the original patch into two: one for batching doorbell, one for setting the correct wqe count

v5:
Drop Cc: stable and use net-next

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.34.1


