Return-Path: <netdev+bounces-97654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFF8CC96C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA271F21DD1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85353145B14;
	Wed, 22 May 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE5uHvHv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114F19470
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419612; cv=none; b=vCUU0gDSNN+Rt84dkEq1ri26NCRQCW1rf4KmYBOP8PE2sbAZjmq20yFK1MOnqEH/JfWzJdPUTjmDvTdAsARkcxQRyOmGzdV4HY58V+TGuQUItZhEmcONnpy1Hsl2UDD/iY1bxKgcHbx6efzCU1wJWQL78ORhZ1C4+7JwZOjERJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419612; c=relaxed/simple;
	bh=8l0uU6Y/yhhgTGiM4chyqvbzo30BwR9FltXBtYW73T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nV2BG5ZP0EGg17w+neoeRYKDjGmEYEDyQ93jnSw3nbNPAlzKCVnevJ5/glOJzi/OE1XoodJ9zhSr7VtijISv9k9b2c4oKzL9RPNDmHmYrRnlnNDYF9P7yYjbFL2rYl5MkxbexYF/TNawscK8zkb1YO+RjgQ5/J2vRQCV+3xCZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE5uHvHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716419606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rbo6pj7DzmYaxMPYk6l4aeo7Pj0pzJzyF80d2rCjlCc=;
	b=eE5uHvHvflPUJx4Xx6KW2Ml9SqeWU0FoKFfKNVQHUZTQV/dv8Sr6eDeVGD8hzwkfwHUnv2
	yA0yFdgwI20G0qlU2bxwSkweCMbrkLNN2LWRt7nJDxFUjuuStLfBWcjOokEXDb22KqV5P/
	Jn8f7qJelT6/e0AWX6BYTmkSW+Up/yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-tpyqX8J-P6a5gjJXbuF7dg-1; Wed, 22 May 2024 19:13:20 -0400
X-MC-Unique: tpyqX8J-P6a5gjJXbuF7dg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95C9985A58C;
	Wed, 22 May 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.38])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBE440004D;
	Wed, 22 May 2024 23:13:17 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Nitesh Narayan Lal <nitesh@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH iwl-next] ice: use irq_update_affinity_hint()
Date: Thu, 23 May 2024 01:12:56 +0200
Message-ID: <20240522231256.587985-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

irq_set_affinity_hint() is deprecated. Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that.
On the contrary, when the driver applies affinities by itself, it breaks
the users' expectations:
 1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
    order to prevent IRQs from being moved to certain CPUs that run a
    real-time workload.
 2. ice reconfigures VSIs at runtime due to a MIB change
    (ice_dcb_process_lldp_set_mib_change). Reopening a VSI resets the
    affinity in ice_vsi_req_irq_msix().
 3. ice has no idea about irqbalance's config, so it may move an IRQ to
    a banned CPU. The real-time workload suffers unacceptable latency.

I am not sure if updating the affinity hints is at all useful, because
irqbalance ignores them since 2016 ([1]), but at least it's harmless.

This ice change is similar to i40e commit d34c54d1739c ("i40e: Use
irq_update_affinity_hint()").

[1] https://github.com/Irqbalance/irqbalance/commit/dcc411e7bfdd

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5371e91f6bbb..0f8b622db2b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2587,8 +2587,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
 
-		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(irq_num, NULL);
+		/* clear the affinity_hint in the IRQ descriptor */
+		irq_update_affinity_hint(irq_num, NULL);
 		synchronize_irq(irq_num);
 		devm_free_irq(ice_pf_to_dev(pf), irq_num, vsi->q_vectors[i]);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..a5d369b8fed5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2607,7 +2607,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		}
 
 		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
+		irq_update_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
 	err = ice_set_cpu_rx_rmap(vsi);
@@ -2625,7 +2625,7 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		irq_num = vsi->q_vectors[vector]->irq.virq;
 		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
 			irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
-- 
2.44.0


