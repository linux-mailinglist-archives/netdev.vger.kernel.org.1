Return-Path: <netdev+bounces-143462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B2D9C28A8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ECB1C22667
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 00:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C79638B;
	Sat,  9 Nov 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/8B94TY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40703819
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111140; cv=none; b=MAHUnu6S5u695irVfl0EZjQ7uKOtOYZXFsFiWDAtmeNaVyRXUNAKI139gKMQEYhzQAkiRPnOVkeOVgTAdbol0KAgSpuK8H3rOHChleZPApB5mTBf8yyKpDWjh7M5ourjmen9ReZy+f1LjBmFpC+T0MoKVb8SlNr+YkvCwDa6c9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111140; c=relaxed/simple;
	bh=KroSfN1M0r4HiUrYKVPYXdflVlrOxeZYUJfX7KDpK4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egiYvsPKMm1NoRmVDq0p//RDKOFh/uX6QIlRF0rSAPIverZ8w+He665W9Gu2BsWXC4dM9x1pgeZyf4Gs/MIkou8LN8C+MvxfsDoLosDz2igFAwIUVooS5cW/n+R7HW+2n8A4Fi14wY1m5XZA5yitnoc5lfmHF6cTgRuBTFjF7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/8B94TY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731111138; x=1762647138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KroSfN1M0r4HiUrYKVPYXdflVlrOxeZYUJfX7KDpK4c=;
  b=J/8B94TYdHZ+5/kyE9lDvLYn8onJ1ISOm8d/rKVqG8VApxzRfMpEU/Ae
   L7EyKB+JBL16gRiJkoaD3HJSGvk96nHSLuUDheqWaGUdIQfxTsWNybBG9
   nqE315m0WEz8BZz0eDVOD7zIj72Mi3ZGdiXRVZWse/gZ7say7s1WLiHXR
   foc8FpLcEngxHbWpUliqW8p8MR0SxVsbcLMaoTid4R2D4pQqCQ14nykln
   qErmBSw5fXpluDZrejg7aEvLoraueTBqb3JWCs3eLsrEIkJ1OhjU4p4F6
   R1zKji1MmpPPphoHmtGfPhzzkUz7sYKRG8kaiIuOJ/kRvlKlxuVVY/eC/
   Q==;
X-CSE-ConnectionGUID: mZ+hhu1ORTSOwfwoPRXuEg==
X-CSE-MsgGUID: 6n2gHpB3QP+y8mMfa4Mmxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34795118"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="34795118"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:18 -0800
X-CSE-ConnectionGUID: HYqb+TBpR0CzVg8VxpdyYw==
X-CSE-MsgGUID: cOOkK1WeRf6CKkr+GLhphQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90905950"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.245.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:16 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-net 1/2] idpf: preserve IRQ affinity settings across resets
Date: Fri,  8 Nov 2024 17:12:05 -0700
Message-ID: <20241109001206.213581-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241109001206.213581-1-ahmed.zaki@intel.com>
References: <20241109001206.213581-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Currently the IRQ affinity settings are getting lost when interface
goes through a soft reset (due to MTU configuration, changing number
of queues etc). Use irq_set_affinity_notifier() callbacks to keep
the IRQ affinity info in sync between driver and kernel.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 35 +++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 +++-
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a8989dd98272..82e0e3698f10 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3583,7 +3583,7 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 		irq_num = adapter->msix_entries[vidx].vector;
 
 		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_set_affinity_notifier(irq_num, NULL);
 		kfree(free_irq(irq_num, q_vector));
 	}
 }
@@ -3723,6 +3723,33 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 	writel(intval, q_vector->intr_reg.dyn_ctl);
 }
 
+/**
+ * idpf_irq_affinity_notify - Callback for affinity changes
+ * @notify: context as to what irq was changed
+ * @mask: the new affinity mask
+ *
+ * Callback function registered via irq_set_affinity_notifier function
+ * so that river can receive changes to the irq affinity masks.
+ */
+static void
+idpf_irq_affinity_notify(struct irq_affinity_notify *notify,
+			 const cpumask_t *mask)
+{
+	struct idpf_q_vector *q_vector =
+		container_of(notify, struct idpf_q_vector, affinity_notify);
+
+	cpumask_copy(q_vector->affinity_mask, mask);
+}
+
+/**
+ * idpf_irq_affinity_release - Callback for affinity notifier release
+ * @ref: internal core kernel usage
+ *
+ * Callback function registered via irq_set_affinity_notifier function
+ * to inform the driver that it will no longer receive notifications.
+ */
+static void idpf_irq_affinity_release(struct kref __always_unused *ref) {}
+
 /**
  * idpf_vport_intr_req_irq - get MSI-X vectors from the OS for the vport
  * @vport: main vport structure
@@ -3730,6 +3757,7 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	struct irq_affinity_notify *affinity_notify;
 	const char *drv_name, *if_name, *vec_name;
 	int vector, err, irq_num, vidx;
 
@@ -3763,7 +3791,10 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 			goto free_q_irqs;
 		}
 		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, q_vector->affinity_mask);
+		affinity_notify = &q_vector->affinity_notify;
+		affinity_notify->notify = idpf_irq_affinity_notify;
+		affinity_notify->release = idpf_irq_affinity_release;
+		irq_set_affinity_notifier(irq_num, affinity_notify);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index b59aa7d8de2c..48cb58d14eff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -379,6 +379,7 @@ struct idpf_intr_reg {
  * @rx_itr_idx: RX ITR index
  * @v_idx: Vector index
  * @affinity_mask: CPU affinity mask
+ * @affinity_notify: struct with callbacks for notification of affinity changes
  */
 struct idpf_q_vector {
 	__cacheline_group_begin_aligned(read_mostly);
@@ -416,12 +417,15 @@ struct idpf_q_vector {
 	u16 v_idx;
 
 	cpumask_var_t affinity_mask;
+	struct irq_affinity_notify affinity_notify;
 	__cacheline_group_end_aligned(cold);
 };
+
 libeth_cacheline_set_assert(struct idpf_q_vector, 112,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8 + sizeof(cpumask_var_t));
+			    8 + sizeof(cpumask_var_t) +
+			    sizeof(struct irq_affinity_notify));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
-- 
2.43.0


