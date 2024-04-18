Return-Path: <netdev+bounces-89403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638D8AA389
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879201F245A3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0121BED96;
	Thu, 18 Apr 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkoWGY1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF91A0AFA
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469949; cv=none; b=TCV2GM7FqmV0rl/KyIJ+/8llUnRSawjajUnoZ5Mie9Z1nGfcms4aTYWJK/usmTVbbUDs2uDrMZFEIr678cQh/ywOlQpekA5BW1mPOhfESpKiTemIhA4cuVmXpipVPCtTqzeeHtRxbjAxbpc1tCrBbUVvxWZFQvxuD1n3Y+W9gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469949; c=relaxed/simple;
	bh=9VNZiN/LhNydhx1ESFWqspNdurMS5WG84UMK12gTx1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UM6k6Kg3JL7G0vjTRC/BmwdiaspxPC8MA7WI6ufYMqdd8pIlMWi89zly70yfgPuxrqwBjj0Gt6GwIQqR6U05sv/0/7QoSW3ayFCWxhUF0uXLhfC3UZzN9Pr0c98bjv+M2AV2UG6AxFmi+GnsjVdKklIVuPiVynVLcGM9PrwlPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkoWGY1n; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610b96c8ca2so22379667b3.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469947; x=1714074747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwUTYaz8zxeLWvGDnxMv0voRtmZ/Nn0Ru5SD7WhY/cY=;
        b=AkoWGY1nxWzLbyQ4z6/F/nTvQhWwNUqW9h51DhVv6gcMPMt0K0IJJ+ca3cEn26Pro/
         Dc2folbR1u91Gn3C9gSezm8PO3A5YzR/ErQT04c6k/DESwnOOub/FJMxcDYvK6zyRNWj
         swTHaeOe2g8Tg0oGZGN8NFXaK9rescNEz094NMFqohG1rbtqLmVIJ+C622U8BnI2mfly
         3wX8KH9jM1bZMDNtPxaxsaQobVWPN56FoEhoBm7oAQmyF+VdpuiesFUeyJHHYbs+tSW4
         6gumrbQ6ilUhK64sfirnE4Zqui/de/uTiRMD/QShkxwoIsg1iSCjx8IsT4b3i/rClVlT
         EMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469947; x=1714074747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwUTYaz8zxeLWvGDnxMv0voRtmZ/Nn0Ru5SD7WhY/cY=;
        b=eQFGpxNN29fkRqgqLsSH6Uk76c4Tk/BcaPLXGrx3XJsogJAfN80SS3Sj5uOb/QQj7U
         I0PX1NevsTqWS8Tq5A+Hrw1FhqqpxrZ8HLi5YJldP04hmrc5teID8LHrqQjMd0/8vb1Q
         LUjzL1ojCiMObltxGQV+8FSwfyNTkJghbMCL77oahZq4AUxN7tb5puWYDo2FCrUBEk4G
         Safnb0ZmVOYMTSen3CqguS242KQDTYo3MMxu+Lq84WSiqVYCJomoVNYufZa02Cj6j23p
         T0YYu3OdBd93+IxDGyRRAlhM+8/AR1iofBKCyv7FVKKwjZQcUo1M9Qy6dpgF45p8zPX4
         gA8g==
X-Gm-Message-State: AOJu0YykztbhjyNHJhzh4IljN4QJLNGiGsbsGAtz1LGMFjnv4rb/lGbb
	pn1HSo9Q7gAq+ahiQ+C24sY6RrOKbFlroGPQwqIIG5YKaSRSmA3J+Bnp0Yq9X597/8eAhJ+b6OJ
	7ZRUbR8XrvID9s9YDetOO5o9gbMq6guSCCiAcYVSEqFhZA7igVO1w8W18KursHs+UjW++5CXnJu
	3dpF1/hvRc3J901TuwvBy6X+mb4UsNo4s8JpPYhbv5m4g=
X-Google-Smtp-Source: AGHT+IEzfufoFaqPXDZd5vA/PywOHq/fR5Z+QoGuLF1IMlWloWx/99a4euqM29iGKVszVtqcmFLy+Pd7/i5enQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d982:0:b0:61b:2210:4f43 with SMTP id
 b124-20020a0dd982000000b0061b22104f43mr591593ywe.6.1713469946859; Thu, 18 Apr
 2024 12:52:26 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:56 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-7-shailend@google.com>
Subject: [RFC PATCH net-next 6/9] gve: Avoid rescheduling napi if on wrong cpu
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to make possible the implementation of per-queue ndo hooks,
gve_turnup was changed in a previous patch to account for queues already
having some unprocessed descriptors: it does a one-off napi_schdule to
handle them. If conditions of consistent high traffic persist in the
immediate aftermath of this, the poll routine for a queue can be "stuck"
on the cpu on which the ndo hooks ran, instead of the cpu its irq has
affinity with.

This situation is exacerbated by the fact that the ndo hooks for all the
queues are invoked on the same cpu, potentially causing all the napi
poll routines to be residing on the same cpu.

A self correcting mechanism in the poll method itself solves this
problem.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  1 +
 drivers/net/ethernet/google/gve/gve_main.c | 33 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e97633b68e25..9f6a897c87cb 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -610,6 +610,7 @@ struct gve_notify_block {
 	struct gve_priv *priv;
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
+	u32 irq;
 };
 
 /* Tracks allowed and current queue settings */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 4ab90d3eb1cb..c348dff7cca6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <linux/filter.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
@@ -253,6 +254,18 @@ static irqreturn_t gve_intr_dqo(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
+{
+	int cpu_curr = smp_processor_id();
+	const struct cpumask *aff_mask;
+
+	aff_mask = irq_get_effective_affinity_mask(irq);
+	if (unlikely(!aff_mask))
+		return 1;
+
+	return cpumask_test_cpu(cpu_curr, aff_mask);
+}
+
 int gve_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct gve_notify_block *block;
@@ -322,8 +335,21 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 		reschedule |= work_done == budget;
 	}
 
-	if (reschedule)
-		return budget;
+	if (reschedule) {
+		/* Reschedule by returning budget only if already on the correct
+		 * cpu.
+		 */
+		if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
+			return budget;
+
+		/* If not on the cpu with which this queue's irq has affinity
+		 * with, we avoid rescheduling napi and arm the irq instead so
+		 * that napi gets rescheduled back eventually onto the right
+		 * cpu.
+		 */
+		if (work_done == budget)
+			work_done--;
+	}
 
 	if (likely(napi_complete_done(napi, work_done))) {
 		/* Enable interrupts again.
@@ -428,6 +454,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 				"Failed to receive msix vector %d\n", i);
 			goto abort_with_some_ntfy_blocks;
 		}
+		block->irq = priv->msix_vectors[msix_idx].vector;
 		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      get_cpu_mask(i % active_cpus));
 		block->irq_db_index = &priv->irq_db_indices[i].index;
@@ -441,6 +468,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      NULL);
 		free_irq(priv->msix_vectors[msix_idx].vector, block);
+		block->irq = 0;
 	}
 	kvfree(priv->ntfy_blocks);
 	priv->ntfy_blocks = NULL;
@@ -474,6 +502,7 @@ static void gve_free_notify_blocks(struct gve_priv *priv)
 		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      NULL);
 		free_irq(priv->msix_vectors[msix_idx].vector, block);
+		block->irq = 0;
 	}
 	free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
 	kvfree(priv->ntfy_blocks);
-- 
2.44.0.769.g3c40516874-goog


