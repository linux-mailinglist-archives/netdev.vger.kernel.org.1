Return-Path: <netdev+bounces-279675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL6eHgvf5Wk1owEAu9opvQ
	(envelope-from <netdev+bounces-279675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDA428037
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1B75300D575
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03137386C2D;
	Mon, 20 Apr 2026 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+9urV6K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594C386C1B
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672488; cv=none; b=WRNGmQwSw81Oxfx5Bd8DyWQ+C0U67bK6pSSKwiFNMX1yQFiurJ66Qmq7zYPSg0KowIRqzMd3XqFSn619SabLpitlKifIGD5DU6/9+5oiXg/nm0OVelzQhsNi7OzLEcRrc06bqY7O8FTEJi/3cazgdQzQNv+dayz4N23FVbEGn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672488; c=relaxed/simple;
	bh=iJfYHjbtQcWXulEhPUnNrNVT7wdpLyZo8wc0yxlsesk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DG53oWIrZcOq2WmP5J3vWNkIkjsAbpieLad0Qf47ANfisoR5BgNXXU93u52K65iyD9lmtH21v3F9nsq5VI/kYfChaX80g27P+7BQVf/d69RCFyt9O+TzIh2kBnLkAKrIpe/RgZ/yB0EWLs7lO0pb+ttEODYEGUWDNx6L23tCLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+9urV6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CADC2BCB3;
	Mon, 20 Apr 2026 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776672488;
	bh=iJfYHjbtQcWXulEhPUnNrNVT7wdpLyZo8wc0yxlsesk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e+9urV6K58ahpj9nD4gByGJBfQ2yw6edYmFol3cpas1UUf/+DDiIyXWyXqxNpydt1
	 yuJz8wOQZfrtejlLFgX2wClYdI9997yMSMZRu7QaAEhH7ZHub6Tim87qKTnOX5CD1o
	 S6iQNIcGHpyH0eK30Dqjw+jUJMjobksb8pbGOpf0hup8Li35T0OMG9nlZlmR5x4OXL
	 HkgfKNQC2nfAWuNVL45bmC3hZwJ7AAqw5pPyxDG/cEFZH11ZI+gXRJHFforF92dKOw
	 9STnhtATXXqRFVg9xJmS11ExPXqKHvWazwF5qIuizQP9ITG++4zLaw4HRxDd6MfsGF
	 Tsl8BjwBwkUTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 20 Apr 2026 10:07:47 +0200
Subject: [PATCH net v2 1/2] net: airoha: Move ndesc initialization at end
 of airoha_qdma_init_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-airoha_qdma_init_rx_queue-fix-v2-1-d99347e5c18d@kernel.org>
References: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
In-Reply-To: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279675-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76EDA428037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If queue entry or DMA descriptor list allocation fails in
airoha_qdma_init_rx_queue routine, airoha_qdma_cleanup() will trigger a
NULL pointer dereference running netif_napi_del() for RX queue NAPIs
since netif_napi_add() has never been executed to this particular RX NAPI.
The issue is due to the early ndesc initialization in
airoha_qdma_init_rx_queue() since airoha_qdma_cleanup() relies on ndesc
value to check if the queue is properly initialized. Fix the issue moving
ndesc initialization at end of airoha_qdma_init_tx routine.
Move page_pool allocation after descriptor list allocation in order to
avoid memory leaks if desc allocation fails.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..fc79c456743c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -745,14 +745,18 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
-	q->ndesc = ndesc;
 	q->qdma = qdma;
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
+	q->desc = dmam_alloc_coherent(eth->dev, ndesc * sizeof(*q->desc),
+				      &dma_addr, GFP_KERNEL);
+	if (!q->desc)
+		return -ENOMEM;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -761,11 +765,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
-				      &dma_addr, GFP_KERNEL);
-	if (!q->desc)
-		return -ENOMEM;
-
+	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
 	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);

-- 
2.53.0


