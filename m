Return-Path: <netdev+bounces-270387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOzHCG3rwGl6OQQAu9opvQ
	(envelope-from <netdev+bounces-270387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:27:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801812ED95D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4434304E701
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679F35F16F;
	Mon, 23 Mar 2026 07:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D35F17D;
	Mon, 23 Mar 2026 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250674; cv=none; b=QLD0sOIFFbEkKNoXeys+wrSnpTdKgMa9Oof+cZ12mVqhF3mqg9f6WAa6pOGiWxycJlbgCwWcopF7h5z/0d28fwaZBKuWabW7WHlqjXIy7K3IrWfVJa15d0pnSXMUzl6xz4/ulHu87yYKuYi7TiPLgHRzo6s3YHmxKAxfzoe2tLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250674; c=relaxed/simple;
	bh=PxNGi/hkPIZHlx09eUzwK1ipMisaPPu38DW+8nEgceE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMUEu8siT44URgy5+9z26MFWpFOue1oJaqywwxdHuiLxqupjsbT6BLGuzS2dwBn0NPOlPLdvaiuJ2V5YLeBn6vxLwfEFrXrGk57XV8Ml1GVMePvLLPQq5lViO1v8k3RWYY0ZZoIt4Fb+x382jRCv8M3XXvoupRXFeL6CwkzpNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowABngdif6sBpGlSGCw--.11689S2;
	Mon, 23 Mar 2026 15:24:15 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Pavel.Zhigulin@kaspersky.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] qede: validate TPA aggregation indices from CQEs
Date: Mon, 23 Mar 2026 15:24:15 +0800
Message-ID: <20260323072415.60149-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABngdif6sBpGlSGCw--.11689S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1Dtr4fAFWrXrW8XFy5urg_yoWrXFWkpa
	13J3Zak397J3WxKw4rAF4Uuw15C34fGa4fWa93Ga4fAr90yr18XFWktrWYvrn5JrZ7AFW2
	vr4Uta45C3W7GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2fUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270387-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 801812ED95D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fast-path TPA handlers index rxq->tpa_info[] directly with the
completion-provided tpa_agg_index field. That field is only a raw u8 in
the CQE layout, while rxq->tpa_info has ETH_TPA_MAX_AGGS_NUM entries.

Reject out-of-range indices before touching rxq->tpa_info[] and recycle
the affected receive BDs instead of indexing past the fixed aggregation
state array.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 59 ++++++++++++++++++++--
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index e338bfc8b7b2..85d640de5f21 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -668,8 +668,18 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 {
 	struct sw_rx_data *current_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
 							 NUM_RX_BDS_MAX];
-	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
-	struct sk_buff *skb = tpa_info->skb;
+	struct qede_agg_info *tpa_info;
+	struct sk_buff *skb;
+
+	if (unlikely(tpa_agg_index >= ARRAY_SIZE(rxq->tpa_info))) {
+		DP_NOTICE(edev, "TPA aggregation index %u out of range\n",
+			  tpa_agg_index);
+		qede_recycle_rx_bd_ring(rxq, 1);
+		return -EINVAL;
+	}
+
+	tpa_info = &rxq->tpa_info[tpa_agg_index];
+	skb = tpa_info->skb;
 
 	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
 		goto out;
@@ -833,10 +843,26 @@ static void qede_tpa_start(struct qede_dev *edev,
 			   struct qede_rx_queue *rxq,
 			   struct eth_fast_path_rx_tpa_start_cqe *cqe)
 {
-	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
+	struct qede_agg_info *tpa_info;
 	struct sw_rx_data *sw_rx_data_cons;
+	u8 agg_index = cqe->tpa_agg_index;
+	u8 num_bds = 1;
 	u16 pad;
 
+	if (cqe->bw_ext_bd_len_list[0])
+		num_bds++;
+	if (cqe->bw_ext_bd_len_list[1])
+		num_bds++;
+
+	if (unlikely(agg_index >= ARRAY_SIZE(rxq->tpa_info))) {
+		DP_NOTICE(edev, "TPA aggregation index %u out of range\n",
+			  agg_index);
+		qede_recycle_rx_bd_ring(rxq, num_bds);
+		return;
+	}
+
+	tpa_info = &rxq->tpa_info[agg_index];
+
 	sw_rx_data_cons = &rxq->sw_rx_ring[rxq->sw_rx_cons & NUM_RX_BDS_MAX];
 	pad = cqe->placement_offset + rxq->rx_headroom;
 
@@ -876,7 +902,7 @@ static void qede_tpa_start(struct qede_dev *edev,
 
 cons_buf: /* We still need to handle bd_len_list to consume buffers */
 	if (likely(cqe->bw_ext_bd_len_list[0]))
-		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
+		qede_fill_frag_skb(edev, rxq, agg_index,
 				   le16_to_cpu(cqe->bw_ext_bd_len_list[0]));
 
 	if (unlikely(cqe->bw_ext_bd_len_list[1])) {
@@ -960,9 +986,21 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
 {
 	int i;
+	u8 agg_index = cqe->tpa_agg_index;
+
+	if (unlikely(agg_index >= ARRAY_SIZE(rxq->tpa_info))) {
+		DP_NOTICE(edev, "TPA aggregation index %u out of range\n",
+			  agg_index);
+
+		for (i = 0; cqe->len_list[i] &&
+		     i < ARRAY_SIZE(cqe->len_list); i++)
+			qede_recycle_rx_bd_ring(rxq, 1);
+
+		return;
+	}
 
 	for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)
-		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
+		qede_fill_frag_skb(edev, rxq, agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
 
 	if (unlikely(i > 1))
@@ -979,6 +1017,17 @@ static int qede_tpa_end(struct qede_dev *edev,
 	struct sk_buff *skb;
 	int i;
 
+	if (unlikely(cqe->tpa_agg_index >= ARRAY_SIZE(rxq->tpa_info))) {
+		DP_NOTICE(edev, "TPA aggregation index %u out of range\n",
+			  cqe->tpa_agg_index);
+
+		for (i = 0; cqe->len_list[i] &&
+		     i < ARRAY_SIZE(cqe->len_list); i++)
+			qede_recycle_rx_bd_ring(rxq, 1);
+
+		return 0;
+	}
+
 	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	skb = tpa_info->skb;
 
-- 
2.50.1 (Apple Git-155)


