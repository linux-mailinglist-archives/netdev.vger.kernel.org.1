Return-Path: <netdev+bounces-272481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELz7FJRTxmkkIwUAu9opvQ
	(envelope-from <netdev+bounces-272481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:53:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F191342092
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA91D307800B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A153DA7E9;
	Fri, 27 Mar 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khNPZwTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8763DA7C4
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604935; cv=none; b=HEUkdUVYP8NXqFDYYf/1DS1UsEoHX1g9YNWesSkCjd5b+Didr1g1lMYEJkXhTsQQ5ceWmW/6laXzbpM0qRnpoG2rhaEWOyv1I/ZJUeAbTkF5R681MR90QtMLyBEon8OqPaexzOJUngnxE91k0mwYhkGFYHqvdgSNCEMx3m2gw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604935; c=relaxed/simple;
	bh=mxd+97vIOAnLehTvk1vdsvxt2oKWOD4syysFg/2MUkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SBKNh/JrffykRGKr7mSwbpg4eIq9CZDWKt3SBx774mNDd7cNgfSdJy4w1LLhH1zUpX+TzOCUyKyWndzzKOPMRnZwSM7vsxUkbqiqQpipRV1H0F98dqb06YYk9V94icOwqwqYH3pgc4Ms1qjiojRmOB+Et/FULIxk++5Blvaoa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khNPZwTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6DC2BCB2;
	Fri, 27 Mar 2026 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774604935;
	bh=mxd+97vIOAnLehTvk1vdsvxt2oKWOD4syysFg/2MUkY=;
	h=From:Date:Subject:To:Cc:From;
	b=khNPZwTCoQkFOnTxuFEFYovhH2GFOXF+iyaEgLEjRFNIyBoUFJxvExBkvyovF1QKw
	 hE0qXlTWnJ2ca1ppfekD7Adhq6vEncctlmYZZP8djKuGLQZ091e6gmhnpfWAlUERHb
	 su6zzaTsLZ45SBTQDkXTqOrSKTNddhlctHaOj+0Oflm6zhMW1itshcHvcqLbzAwQsa
	 Sgeif7wj1yS5hidfTK4ROGt0Ks/5y4DADsS4cP53JDLKTbWOPV7jdUtJsqxZrnskeh
	 rfO2hF+jQOfoeskcVeXajc5sG2jUDKmIZ7z4u8uafkLjwjPHJq2XjY1kfzVJQhj4Bm
	 yHWUmHiDEZIxg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 27 Mar 2026 10:48:21 +0100
Subject: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X23EBMqLT9FSlha551oY26ISKI/
 97Q48xh5qAMFWR6NAcpNskypwrtpaFh4vSGkViZnHWd9a4zLDpPHNb45TB8wKksQfewFhSYUXZ
 zxRhv8Hf3ipZqZlFU/V/0z/P8AaT+eVpyAAAA
X-Change-ID: 20260326-airoha_qdma_cleanup_rx_queue-fix-5efd8e392bd0
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <Madhur.Agrawal@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272481-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 8F191342092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to properly cleanup hw rx QDMA queues and bring the device to
the initial state, reset rx DMA queue head/tail index. Moreover, reset
queued DMA descriptor fields.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 56cf9a926a83da38bb03373ced9728f1fecdbce7..c2a54dbcbb0d576da298f2a36a354afaef89b240 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -794,18 +794,34 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 
 static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->qdma->eth;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int qid = q - &qdma->q_rx[0];
 
 	while (q->queued) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
+		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		struct page *page = virt_to_head_page(e->buf);
 
 		dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
 					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
+		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->ctrl, 0);
+		WRITE_ONCE(desc->addr, 0);
+		WRITE_ONCE(desc->data, 0);
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		WRITE_ONCE(desc->msg2, 0);
+		WRITE_ONCE(desc->msg3, 0);
+
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 	}
+
+	q->head = q->tail;
+	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
+			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
 }
 
 static int airoha_qdma_init_rx(struct airoha_qdma *qdma)

---
base-commit: ae05340ccaa9d347fe85415609e075545bec589f
change-id: 20260326-airoha_qdma_cleanup_rx_queue-fix-5efd8e392bd0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


