Return-Path: <netdev+bounces-220213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23276B44C1B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9AF1C2659E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5F1A2398;
	Fri,  5 Sep 2025 03:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884672628D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041688; cv=none; b=IewDR2RltpWrlRO6OOH+z8fHf4/E7nFQxPbm8b8T5tG2To+bHA6VnlsScDWP3Na0qEXewN9G+foeEJMJjO6l8KyEOwP3O+HEmYDALVNW/vfobIX/6KUSzEMVN9f/nU3iT4QUPY6SUfWQSkrk3FVvbKQWypcYg5PX0g8fYrcdLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041688; c=relaxed/simple;
	bh=4pnU9K3Ib56qdsTvpQ/kbd6uN/uS5urg3ADNTinfndA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO1JQSeuzT62NHYw5QEqa8uVaQtXK2XSmXmV7cLTpQae/B0a/9xBrAdtpLOD751egaARvHV7papyGw/jmmxLm0AHlyJXLNXuPQuZXLdxBxmudxGw+WB1+Pl0XAoyccjtjfvBRRnDRA7Dbv1vTPBir0B4HMr7OwvUtp7njiefCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowAB33RYFVLpo8kC3AA--.48295S2;
	Fri, 05 Sep 2025 11:07:51 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: ecree.xilinx@gmail.com
Cc: kuba@kernel.org,
	linux@treblig.org,
	netdev@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] sfc: farch: Potential Null Pointer Dereference in ef4_farch_handle_tx_event()
Date: Fri,  5 Sep 2025 11:07:37 +0800
Message-ID: <20250905030737.220-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB33RYFVLpo8kC3AA--.48295S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5uFWftry7JFW3XF45GFg_yoW8AF45pa
	yDArWSvF4xtF4rZas3K3WruF45JayrJFy2ga4Sg3yYvr9rGryDXF1xt34YgrsayrWkGa1a
	yryUAF4kXFn8J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUoKZXUUUUU=
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAYQEmi6Ik7aTQAAsh

A patch similar to 83b09a180741("sfc: farch: fix TX queue lookup in TX 
 event handling").

The code was using ef4_channel_get_tx_queue() function with a TXQ label 
parameter, when it should have been using direct queue access via 
channel->tx_queue. This mismatch could result in NULL pointer returns, 
leading to system crashes.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 drivers/net/ethernet/sfc/falcon/farch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index 01017c41338e..29b34fb9fb24 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -838,16 +838,16 @@ ef4_farch_handle_tx_event(struct ef4_channel *channel, ef4_qword_t *event)
 		/* Transmit completion */
 		tx_ev_desc_ptr = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_DESC_PTR);
 		tx_ev_q_label = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_Q_LABEL);
-		tx_queue = ef4_channel_get_tx_queue(
-			channel, tx_ev_q_label % EF4_TXQ_TYPES);
+		tx_queue = channel->tx_queue +
+			(tx_ev_q_label % EF4_TXQ_TYPES);
 		tx_packets = ((tx_ev_desc_ptr - tx_queue->read_count) &
 			      tx_queue->ptr_mask);
 		ef4_xmit_done(tx_queue, tx_ev_desc_ptr);
 	} else if (EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_WQ_FF_FULL)) {
 		/* Rewrite the FIFO write pointer */
 		tx_ev_q_label = EF4_QWORD_FIELD(*event, FSF_AZ_TX_EV_Q_LABEL);
-		tx_queue = ef4_channel_get_tx_queue(
-			channel, tx_ev_q_label % EF4_TXQ_TYPES);
+		tx_queue = channel->tx_queue +
+			(tx_ev_q_label % EF4_TXQ_TYPES);
 
 		netif_tx_lock(efx->net_dev);
 		ef4_farch_notify_tx_desc(tx_queue);
-- 
2.34.1


