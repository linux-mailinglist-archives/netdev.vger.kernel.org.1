Return-Path: <netdev+bounces-275054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NvvDOTDz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:43:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F2394A15
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DECD1303B050
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C23BC666;
	Fri,  3 Apr 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf4VAW4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEB3BADAA
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223715; cv=none; b=EvOhF28vXrGNcQA0+o7rBgg+oQHfuGvmtj2SBoCG0tLTItoWIgHTOU4YUQCYCnj+/MQvNh0h4+/MBMcbnfyJFybngEEgDtYf/scj7gMQxad1Js+Rqo7WZpVEoCucYEbePI2S4tTuBqZ+e+/JUG2gv0E9O9h8nzf9ZPvYdcRNW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223715; c=relaxed/simple;
	bh=z4klBNTv7RwSdxS+S+yGsHyIQk+ZVEk9gn6Mday17jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YvNvJUETUno/lVjqpm9yhnyu59OxQi75ImQI0BNGSxqxfCq8muZRyYmUDOGNVX92CSOci65xlxfVYwoXR8yYfrydJ8tpzXrYVvc1h93VreipfCCsSjPtXx+Zq+dwoFzlzST7TccGtSv7v87hqYGqyr8ewc16+twpOJwaSFNOG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf4VAW4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A81C4CEF7;
	Fri,  3 Apr 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223715;
	bh=z4klBNTv7RwSdxS+S+yGsHyIQk+ZVEk9gn6Mday17jE=;
	h=From:Date:Subject:To:Cc:From;
	b=Tf4VAW4EuGJGRmB3Lrdh7KPxGwuRJwxKzEeLuIgFnXJyDZewHgmXRxW/7h9edC8YL
	 5mWvjJcfk1gF9wNPdqZujBiqOg0kFK8hKY6IQxLFc1hiBYUDg4CTQ4peNbPn83lL+Y
	 QukBYfXoLPkLKJ35pyfZeyGkuFh9GGLVPKDm/Ir7wyCQlJ4xNpTBYRvNAR4vxhhhMd
	 /1W0vlpmAJI9gKR27nu1YGzpYj/PS4YHvYmc/5HZ9a0v2NGJLjAVAR8hc4QGkiadTh
	 t1fz5UJU9VKQ2v7A8n4H7x7Xxkk6nUGhmcAUVlDgdzbKpZzV9pLql/Id0BsFJ29mMM
	 OkVWazwnyPkqw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Apr 2026 15:41:31 +0200
Subject: [PATCH net v2] net: airoha: Add dma_rmb() and READ_ONCE() in
 airoha_qdma_rx_process()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-airoha_qdma_rx_process-fix-reordering-v2-1-181e6e23d27b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNTQqDMBBGryKz7pQ4GpWuvEcRSXXU0DaxExGLe
 PcGb9Dl98N7OwQWywFuyQ7Cqw3WuxjokkA3GTcy2j5mIEWFyhWhseIn0376t2lla2fxHYeAg91
 Q2EsfcW7EkihTFWn9KDRE1iwcH6fnDo4XaGI52bB4+Z7uNT2nPzVriinqjMoqL/NBFVQ/WRy/r
 l5GaI7j+AH3JOy34AAAAA==
X-Change-ID: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Xuegang Lu <xuegang.lu@airoha.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275054-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B83F2394A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing dma_rmb() in airoha_qdma_rx_process routine to make sure the
DMA read operations are completed when the NIC reports the processing on
the current descriptor is done. Moreover, add missing READ_ONCE() in
airoha_qdma_rx_process() for DMA descriptor control fields in order to
avoid any compiler reordering.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Use msg1 in airoha_qdma_get_gdm_port() signature to avoid missing
  READ_ONCE().
- Link to v1: https://lore.kernel.org/r/20260402-airoha_qdma_rx_process-fix-reordering-v1-1-53278474f062@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 95ba99b89428..f1843bc5b991 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -581,10 +581,9 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 	return nframes;
 }
 
-static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
-				    struct airoha_qdma_desc *desc)
+static int airoha_qdma_get_gdm_port(struct airoha_eth *eth, u32 msg1)
 {
-	u32 port, sport, msg1 = le32_to_cpu(desc->msg1);
+	u32 port, sport;
 
 	sport = FIELD_GET(QDMA_ETH_RXMSG_SPORT_MASK, msg1);
 	switch (sport) {
@@ -612,15 +611,17 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 	while (done < budget) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
-		struct page *page = virt_to_head_page(e->buf);
-		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
+		u32 hash, reason, msg1, desc_ctrl;
 		struct airoha_gdm_port *port;
 		int data_len, len, p;
+		struct page *page;
 
+		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
 
+		dma_rmb();
+
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
@@ -633,10 +634,12 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!len || data_len < len)
 			goto free_frag;
 
-		p = airoha_qdma_get_gdm_port(eth, desc);
+		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+		p = airoha_qdma_get_gdm_port(eth, msg1);
 		if (p < 0 || !eth->ports[p])
 			goto free_frag;
 
+		page = virt_to_head_page(e->buf);
 		port = eth->ports[p];
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf, q->buf_size);
@@ -670,8 +673,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			 * DMA descriptor. Report DSA tag to the DSA stack
 			 * via skb dst info.
 			 */
-			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG,
-					      le32_to_cpu(desc->msg0));
+			u32 msg0 = le32_to_cpu(READ_ONCE(desc->msg0));
+			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
 
 			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
 			    port->dsa_meta[sptag])

---
base-commit: ec7067e661193403a7a00980bda8612db5954142
change-id: 20260402-airoha_qdma_rx_process-fix-reordering-722308255b65

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


