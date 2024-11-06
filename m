Return-Path: <netdev+bounces-142480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F49BF4D8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4101A285496
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD6207A0F;
	Wed,  6 Nov 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6eFwVd0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6556207218
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916510; cv=none; b=LxxAAil4+ftYkcJPUTDNbgAsO2wAjH0DS0c/Eb1S/IFBEib2O1asrMM8zrnA/bFzdSTj0lk2Uk5KuNncl0nSscFJPy+rWq1xPi91S0mFWSLMEijlWrUXwowHse3RXgImfqNjFh7vamKTPeXz70EOcAspdVQNFg+Rkg0Mdy8M4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916510; c=relaxed/simple;
	bh=Zx+mR+pJK4WCSJENoiqAN9qbUWT6nBlbFBny5lE9/8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msZ0YPdviA/7bnnB6RCe+/cPoqAVD8lNXvjmRV5UcvuHLG3qLNUvzGSkBiPpQUbc8lVwYn2bZZVUm+2R6ZBOnJOMNoVPZ33WWFrZDJOrzUOBc57K4Z4cuStQl+/KmuD2e6tD1HnPnUzLidcoz/0StqE1+ZuQb1Q2OF//s46IuYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6eFwVd0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730916507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qmFxe9cqWWazJeOBmapKJMGyScE7HeewCfktlCZvUIc=;
	b=e6eFwVd0qFPWH7Kdih9FOSE6Q+/EeV2vG4ht6fBGQmwti3Vc9V0CNXAUf9wilEvNjifdx0
	5rjCTxHWHVNLARU9+uenjtrR2KzN0Q49EyxxIVVVx2Ef7vxp9nH/1W/BdPqS+lVWUw9DEL
	mxS9b5geucVkeMAKYMFWIu4AGM4DPjI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-qrlFUO3yMLugGH-RUJkH8Q-1; Wed,
 06 Nov 2024 13:08:26 -0500
X-MC-Unique: qrlFUO3yMLugGH-RUJkH8Q-1
X-Mimecast-MFC-AGG-ID: qrlFUO3yMLugGH-RUJkH8Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E5901955F43;
	Wed,  6 Nov 2024 18:08:25 +0000 (UTC)
Received: from mheiblap.localdomain.com (unknown [10.47.238.66])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D90619560AA;
	Wed,  6 Nov 2024 18:08:22 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] bnxt_en: use irq_update_affinity_hint()
Date: Wed,  6 Nov 2024 20:08:11 +0200
Message-Id: <20241106180811.385175-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that. when the driver applies the
affinities by itself, it breaks the users' expectations:

 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
    order to prevent IRQs from being moved to certain CPUs that run a
    real-time workload.

 2. bnxt_en device reopening will resets the affinity
    in bnxt_open().

 3. bnxt_en has no idea about irqbalance's config, so it may move an IRQ to
    a banned CPU. The real-time workload suffers unacceptable latency.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 99d025b69079..cd82f93b20a1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10885,7 +10885,7 @@ static void bnxt_free_irq(struct bnxt *bp)
 		irq = &bp->irq_tbl[map_idx];
 		if (irq->requested) {
 			if (irq->have_cpumask) {
-				irq_set_affinity_hint(irq->vector, NULL);
+				irq_update_affinity_hint(irq->vector, NULL);
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
@@ -10940,10 +10940,10 @@ static int bnxt_request_irq(struct bnxt *bp)
 			irq->have_cpumask = 1;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
-			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
+			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
 			if (rc) {
 				netdev_warn(bp->dev,
-					    "Set affinity failed, IRQ = %d\n",
+					    "Update affinity hint failed, IRQ = %d\n",
 					    irq->vector);
 				break;
 			}
-- 
2.34.3


