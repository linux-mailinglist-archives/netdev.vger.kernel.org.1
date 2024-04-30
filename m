Return-Path: <netdev+bounces-92642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735798B82F0
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987F91C2271E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5C1BF6FF;
	Tue, 30 Apr 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QXevQ32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F31C230A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518886; cv=none; b=qXRTOrfHv3dfQSGjShpV9mz+LzdoshA5XemfEKeWTD5z0QL1rM/b1s99j4sWDWabnv8sX9fxyisRzdkxsnWKoGJwJG8LPOmT/ykCMObt0VFTW/RAjH0QR6jtz98rCfVxVhCW36RaYOd9xCQXaHQoK+N7HsSq7hKtbRtipZTE/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518886; c=relaxed/simple;
	bh=Kcwo9z19w2X4PJZvh7/+SUOYEVJ9O743aJGBsQl493Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KHE2iz0Sq1G9f7Ny2qxYhgfczAEa76YMpqmyLimH1oswzEgL5m/rLc0FUzGPWUjAFzriQ04D+jZYHwVlHJZHoyewLN4b0guQEcPKnCL0RwcxpjJgqYRP1yCI4OLrEFcVX49yZuCYLaM5q8lgf1OJTCThInCQUSL+y7I3k3pGNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QXevQ32; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de617c7649dso2012148276.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518884; x=1715123684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIWEL1Ar1WKeaXWtcbiWbbyFnhxykfVzID7b3E5pD1Y=;
        b=2QXevQ3296fpHclMT7dzULr0cqAB8hWncMOi1LY2dqsayNBoHo5bce3vO6CG1aaMz8
         UY3nTGWwKWn7fTIr7TX8nLBLo+8NaVONw28uLz9LI6UxT8r+UiEBMLQmyyFR2wmZ4MWT
         xXbSKMaN9cVPb63ljIZLxLm1xIEV0pkVEx5rvw0Ctux1Im016GKUUARA/vBj8FnwlL2N
         joqOgbbgiwHCdsbcwqaHtqftWTWldJhoxztjxhfaR6NCs6nGEhdbcjYl0IkGIMZiEMdR
         Q5qNOn2PBC/z3MDoc+DTHNHH7L9Z9p5QPMGwbZ1Xar8wCXJU1rnzFIaq2++1fl+tk8OS
         QsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518884; x=1715123684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIWEL1Ar1WKeaXWtcbiWbbyFnhxykfVzID7b3E5pD1Y=;
        b=o4vxEaUPisSGCay639+LgjJG1Fbi6TOrDW8HXmddXfHp03opFhmoK7Y/g9G2o+TOfi
         6ffkF7TVLMhnJzTct/m7mrbTNivmfmWHwKTjtB35AeKgnzylofmSh7f3ubHmOCfQiYXd
         984JhKoJxsBw5hFSlzPO22Gv29kX2uRmCmhG7nDZPc05OrzVhGEtR2w2BVyyWJij+fzz
         vtQDxWX+SxMOWycJuLOhDLyEdhptrWl1CVPRxZeiyepLX8Dyfl7UHlgnKJ1MslRZ/P/j
         vn4WbZaIy5MvC/0xJ1+XmcUnJaWd812DZA61pLIRw75ss1zFDstvJYwGuKniEUckCDdg
         3qAQ==
X-Gm-Message-State: AOJu0YwNpPNThRrirB5xLMgji9eVh3RYfziOjbnYldpgxASKt2N/Ekmp
	/f6fkMQyAYxA2cSeUZDxu7wQzqRuJPGxzGdYzEIdHF0mhyFQvMJGmLW7CydWH95y7koukdm/F9o
	DoxroGjkXn1d4tAtoQiDG5WxKD62cEeQn0k3Qrr6la6FK3LxHXdze2FDngISX5KXB5zTiINaFOA
	1YvSzqo84fTzjmWFvcGMpCmjLyFq4zGOa+858583xABRA=
X-Google-Smtp-Source: AGHT+IHrd84vedK8kDVn4adgcF0t6RY1A7JQ4yVDVigBnBJ/hDldO7NfdnX5qQvNMfVtuZE5DpTRPP3frBE2Ng==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:c0b:b0:de5:2ce1:b62d with SMTP
 id fs11-20020a0569020c0b00b00de52ce1b62dmr168525ybb.10.1714518883761; Tue, 30
 Apr 2024 16:14:43 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:15 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-7-shailend@google.com>
Subject: [PATCH net-next 06/10] gve: Avoid rescheduling napi if on wrong cpu
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
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

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  1 +
 drivers/net/ethernet/google/gve/gve_main.c | 33 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 53b5244dc7bc..f27a6d5fbecf 100644
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
index ef902b72b9a9..79b7a677ec0b 100644
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
2.45.0.rc0.197.gbae5840b3b-goog


