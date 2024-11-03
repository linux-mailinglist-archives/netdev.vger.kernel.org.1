Return-Path: <netdev+bounces-141329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5FC9BA7B1
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1CCB208CD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC117A597;
	Sun,  3 Nov 2024 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kD1e3IaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03911CAB8;
	Sun,  3 Nov 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662921; cv=none; b=FyMrxLhKyTll0x5XIKhXmAh2OvgooPeGaEaOk0HA6+uGb/czYLG0wbuTvs5OlTiwAVL+n6Ertif14nMnGFAjwgXjiuMaDE7iz+tT2eZRzDQOfszz8okMbQHTzIlCx8aVSl1pAJWCDvd81N8D2KRlPrZNqi+ZsBpDZ2nNUzHz6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662921; c=relaxed/simple;
	bh=o0Pc2R9wuW7omPMTf/RTnyMCsJapsJt8yRyVB1HTJes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqfRtxNez4pSblOoEu9goXolP84AstvhFu8EuAG2nQArG90uQzl8Hq4WyDubIoOTrYoaccFL0sQAIY272untlKDxY6++YWrUOFPiyEiE9dPqFLjL7ulvaN0kkOcuqTrI0ibC7rn0glMdTakbXbHOqe6h6zFTNshy62O7zx3GD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kD1e3IaZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=fRIwc7I4KZcMP8rRONzc1mtVgIvo9wZ3VmVmgqHtqpI=; b=kD1e3IaZv+7HZNRB
	sbaDSIh/tPOBs4Dk/ws2rNpjiRuAUQV11xiBG//7ysrNU0Qqo/yJJCRjWscExjM2o/kfRD2zLdeiO
	6XzfOVGTi4p7ZxbAz4JupK4pXeD2RjzcxPRwD8848yPTxeC4QvgmqHq8SdtaL3yUS/Pmf51tG2KD0
	lt8nK/Ow9mgRC0/PQndCiLyi4Q0nE5SOJjh/mQfMCeYI292RxG899PflTMufbFxglwYYi/Dod5NZQ
	GglSbpXyaA+kH74A3jDrUqlIQ89kmsrSIZDgX+PFR2r0PraWuKiPTI+t5furVQNu+Gbp/2SXAT3XY
	3VqkI7O7XEmuQygKcA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7gTu-00FCCo-0z;
	Sun, 03 Nov 2024 19:41:50 +0000
From: linux@treblig.org
To: shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	ndagan@amazon.com,
	saeedb@amazon.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: ena: Remove autopolling mode
Date: Sun,  3 Nov 2024 19:41:49 +0000
Message-ID: <20241103194149.293456-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This manually reverts
commit a4e262cde3cd ("net: ena: allow automatic fallback to polling mode")

which is unused.

(I did it manually because there are other minor comment
and function changes surrounding it).
Build tested only.

Suggested-by: David Arinzon <darinzon@amazon.com>
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 25 +++++------------------
 drivers/net/ethernet/amazon/ena/ena_com.h | 14 -------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index bc23b8fa7a37..66445617fbfb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -763,25 +763,16 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 
 		if (comp_ctx->status == ENA_CMD_COMPLETED) {
 			netdev_err(admin_queue->ena_dev->net_device,
-				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				   comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
-			/* Check if fallback to polling is enabled */
-			if (admin_queue->auto_polling)
-				admin_queue->polling = true;
+				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d)\n",
+				   comp_ctx->cmd_opcode);
 		} else {
 			netdev_err(admin_queue->ena_dev->net_device,
 				   "The ena device didn't send a completion for the admin cmd %d status %d\n",
 				   comp_ctx->cmd_opcode, comp_ctx->status);
 		}
-		/* Check if shifted to polling mode.
-		 * This will happen if there is a completion without an interrupt
-		 * and autopolling mode is enabled. Continuing normal execution in such case
-		 */
-		if (!admin_queue->polling) {
-			admin_queue->running_state = false;
-			ret = -ETIME;
-			goto err;
-		}
+		admin_queue->running_state = false;
+		ret = -ETIME;
+		goto err;
 	}
 
 	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
@@ -1650,12 +1641,6 @@ void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling)
 	ena_dev->admin_queue.polling = polling;
 }
 
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling)
-{
-	ena_dev->admin_queue.auto_polling = polling;
-}
-
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 20e1529adf3b..9414e93d107b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -224,9 +224,6 @@ struct ena_com_admin_queue {
 	/* Indicate if the admin queue should poll for completion */
 	bool polling;
 
-	/* Define if fallback to polling mode should occur */
-	bool auto_polling;
-
 	u16 curr_cmd_id;
 
 	/* Indicate that the ena was initialized and can
@@ -493,17 +490,6 @@ bool ena_com_get_admin_running_state(struct ena_com_dev *ena_dev);
  */
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling);
 
-/* ena_com_set_admin_auto_polling_mode - Enable autoswitch to polling mode
- * @ena_dev: ENA communication layer struct
- * @polling: Enable/Disable polling mode
- *
- * Set the autopolling mode.
- * If autopolling is on:
- * In case of missing interrupt when data is available switch to polling.
- */
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling);
-
 /* ena_com_admin_q_comp_intr_handler - admin queue interrupt handler
  * @ena_dev: ENA communication layer struct
  *
-- 
2.47.0


