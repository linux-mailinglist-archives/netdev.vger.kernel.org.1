Return-Path: <netdev+bounces-92857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278F8B9257
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BB91C21134
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA983168B17;
	Wed,  1 May 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYeLJujI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13216ABCE
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605969; cv=none; b=F9iEmAc1dFPvUN98nmq/uhFvcgjVBABPOvcxV8FVn7+OaR6kcRTLXnc4Nl/ceTB78Sao9seOC9RdQ1Qk4ZvaOFG3cVrAS+qJMpjAUcBhMv7KVKWMim0gwew+hQgmP2usVHP718JP9Ya0nAM68ShXwqu2ishIOHCM7OsEuikDt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605969; c=relaxed/simple;
	bh=Kcwo9z19w2X4PJZvh7/+SUOYEVJ9O743aJGBsQl493Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmB86OU2k8BUFz+YbwlR6/vvqgSRRFTqrEKchFv6zuTVW3dFcdNEmTMeCJIbfwxFRtEv4h6xV93qCFov8Gef1DKgzVl/FCNxsxWAvHQ264+2Dzyergjv2FxrjH9QWyBziNiF0x27uEjE9l2BBTO9g3uWMXuo/l0ngaJ7pAeIdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYeLJujI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso17462077b3.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605967; x=1715210767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIWEL1Ar1WKeaXWtcbiWbbyFnhxykfVzID7b3E5pD1Y=;
        b=fYeLJujIt1lGgG2enaRI2DALN4pXRQm/D6UiKlZiYfXvkpxLnHa2/t2Hr02W46cIN6
         nZAtQTXpXgF/gE7ubk2PpiAvMak+yW4fjZBMlAFZw3HiGS1cc+IF4pIyfL1KSsSpJgxj
         Qzp/kOd2G+bY+tcI4frB7JYkLDrrY2a51C950UNBTAasR5rog7RLDp0SkVCOfiAU3p3r
         CXPVgmJxW1vmDgKT/TM/KD3LKR3aJckzF2HdwA+kQAY8IZYq6YCzHx8cFxwSzygnGz/V
         XGSUqtkQyTvU4FC3eksV9iK77W8i4L+ahPoXCe7v6WO81BFwVeEY/W105DOqXFnuT7B/
         iKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605967; x=1715210767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIWEL1Ar1WKeaXWtcbiWbbyFnhxykfVzID7b3E5pD1Y=;
        b=SLoP2FkeViURd/Z+AfpgpHJq9M7iNL2UyE2rlQMydIEYEdz5mTJQDhWyqVE/zN6vwN
         cn/Ejt8bYMOOP89A3I7wDrQ6bw1MUAvimrJhreVzmKxLbstXdxxc6DuhuhKQbRg2PJFU
         sKaF52EHVWYA73y/PsC60qzQ+YtLI2x2ifE/rHVTOHKHEGpriTLZWE/ABuc2P0qT259l
         gwyGjTGdcWIHZYGiXdw41/41TyQ2IAMdqYR6g1Sa/XFcgnwYsYBSgjcucumPMMfLcFtD
         ftZjdcw5MMk0x06r6zs6HIdpTZ4VMPs1mf9n/TLwSkFUIpZLeoI4hMoJ9j5nD2BTx4IN
         jxbg==
X-Gm-Message-State: AOJu0YxcKvHNUeRQbrJmnAgh0g5a//YQf2d7IXbRIaQ/RiZxy0eogupW
	kU6c9jn6OBEaJOmCOmTA8XDYS+8xTW8ZVu9U4MpdsaAi3YbmtJP54S1Uc+ZK2O9CyI3t5mGoSFi
	NYWSLRYjvpFW44+uqyHCzx4PF6Kdyat+bUg3awhill3iuNB7JW3tLqrf0hFn8vtl9s0XQuOnl7k
	9eWwHUhULM/+aIlfIvgwqSPd/bnKjC3SVRrrD1ir6KktM=
X-Google-Smtp-Source: AGHT+IHEDdUpz3rmvRrmU+185B4fQ4LIOeNyJW2yJybyAyJkvAnW89dqCcfsZLY/mBybGoerFSpjMZgRLRFabg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d9c9:0:b0:618:5009:cb71 with SMTP id
 b192-20020a0dd9c9000000b006185009cb71mr273438ywe.5.1714605967283; Wed, 01 May
 2024 16:26:07 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:45 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-7-shailend@google.com>
Subject: [PATCH net-next v2 06/10] gve: Avoid rescheduling napi if on wrong cpu
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
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


