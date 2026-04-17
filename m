Return-Path: <netdev+bounces-279266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALA7FDfy4WmKzgAAu9opvQ
	(envelope-from <netdev+bounces-279266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12DF418CE2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBB53304A9C9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C33A9636;
	Fri, 17 Apr 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4a/K1jX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDE39E6F0
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415253; cv=none; b=MdsV5dKWotTLZ9BhWft+TBcXPUCJPL16PejM/tIKO0GEN0CuUHVn7e33aD1vZELtWtnkFUb/zR+DFdHo3majJGfTZFZx28zW1CBgNK9ICQUOZSuytjmHJFX6VElKK5JcoY+gKko8Zcxem35U3zD5Juods4qyHZuX318iiDdMBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415253; c=relaxed/simple;
	bh=/WPWpdEWGVeVIKzCLSytQNHRi9qSOAcxdyy0+jcS/uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOcEq7SLq56hOZzu6+6WPxnITlzDYG3AJMnV7F0dtWAjFX0h8IhBaBhfnj8W3/YVsFlKC9WCcD6kLvswm4VlpYrgHY/rB9bc5CwqokIn0TMGSNcPRz3WIP8rp0ARA6QNydpf4/7eORHrg33Q+aXNGaUXiPc0+IbrpKIBLW82VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4a/K1jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB00C2BCB5;
	Fri, 17 Apr 2026 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776415252;
	bh=/WPWpdEWGVeVIKzCLSytQNHRi9qSOAcxdyy0+jcS/uU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q4a/K1jXnS2YC4tXyvarjsTNi5v5b6Cq+w6HgC/bxzpUEUCnxinmwLDtyAht/Ioqq
	 TzU0vAr3+mJu9tvaXmM+yEGyhisDJqTNWUs4RwAp5W2hKZXYwxc+Z2C7y/EfRBpEzp
	 DyP9LlC5+eiP0QiTKFVSl45Dy/esZez8V+5wGW5TMR+oIexoKDbFmOINzZgfExnQ+J
	 Z095kD2q9WlOKIRMpl7mbbc2cW+si8aTzcImPpxIeXAw3h9qVgfrjjD9m/rKBiKB5Q
	 JAXjRzgJOZTDxQPT1e9zjJWHMhTSf5DKAL91+gqmnPR4tpDYxIT6Mx45YfXeqXZKRQ
	 wyGRR+42GqOhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Apr 2026 10:40:36 +0200
Subject: [PATCH net 1/2] net: airoha: Move ndesc initialization at end of
 airoha_qdma_init_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-airoha_qdma_init_rx_queue-fix-v1-1-db9fa5e468e5@kernel.org>
References: <20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org>
In-Reply-To: <20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279266-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E12DF418CE2
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

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..a6f8b231583d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -745,10 +745,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
-	q->ndesc = ndesc;
 	q->qdma = qdma;
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
@@ -761,11 +760,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
+	q->desc = dmam_alloc_coherent(eth->dev, ndesc * sizeof(*q->desc),
 				      &dma_addr, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
+	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
 	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);

-- 
2.53.0


