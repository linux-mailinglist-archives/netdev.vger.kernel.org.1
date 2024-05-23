Return-Path: <netdev+bounces-97867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4708CD959
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426C6282458
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE217F7DD;
	Thu, 23 May 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb0m/G+q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E848CCC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486363; cv=none; b=KS8mEfjPG0+/D5H8cWdyl65E39O+p7+O5RWGyhntfP8A6XaHWByOaZOWq/YlqBHDYhhIzXDkEfcVF+1eftm30+0LMvIHgQn3KqvbuUuqK6azuyUfPR5wZXP+3PrzwkkUiHwqLy0hpg654R/znQEfJa1oOpZWA65RfAZ+N7uskmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486363; c=relaxed/simple;
	bh=UWNjPAw4VWxQaIkz/ErV9J7anWaWZMrgEpCrmipL4dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mj48pqu9TGEAtsIDAbzpak3wDfQ7XCIRFLktBBUzQcivne6QvH8ILRqc64lo8siqTnG9sp6/NPUKKad7L3uXAo537qaYDENrVZHhFq2M9mQD7Hgds22LRkH07ogbuY2nDW71nFRfAQAibB/lAodwYnJgs4LjYPBt1dl3VApqyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb0m/G+q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716486362; x=1748022362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UWNjPAw4VWxQaIkz/ErV9J7anWaWZMrgEpCrmipL4dk=;
  b=hb0m/G+qSb0SdMqzXYJ4itaVPhXFbDaSE/zLgebsU9pTEwCgF4b65XTo
   b8fb3BWYpMa782vaW6dWRjU23eKNC8Ml8hfCeF0vUP/67kreVhI7BjqZx
   9pg/T82iOmd0g/M9Q2N0TyNJ4eeNfFcMEizp5I+isRi1pi88JCxKSWz9n
   65HkpL4WDqj6di3uszioNOvXdYos2qYVRi/Bn4/0+IN9TJ2UjLIrRgf5n
   R1SbfLKfmTDVt9+1x3teJYn6yYGjqg2L7u+Nv7JWcs99DKizt7CBYi5WS
   WEphqxscXSgj8CkbdWcD3Mb/k9EWXCmxnpFeHHmotW8XLgowhM1pjxlD7
   g==;
X-CSE-ConnectionGUID: oRVg8omnSJWLItOazSUsmw==
X-CSE-MsgGUID: jbQllbh4Rqa7rYIgb2WKEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12675517"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12675517"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:46:00 -0700
X-CSE-ConnectionGUID: xc3dHKeaTamSJUw2obl1BA==
X-CSE-MsgGUID: zVfn58tkQ1uATs5NfcR6kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33719180"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:45:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 May 2024 10:45:29 -0700
Subject: [PATCH net 1/2] idpf: don't enable NAPI and interrupts prior to
 allocating Rx buffers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-net-2024-05-23-intel-net-fixes-v1-1-17a923e0bb5f@intel.com>
References: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
In-Reply-To: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Krishneil Singh <krishneil.k.singh@intel.com>
X-Mailer: b4 0.13.0

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Currently, idpf enables NAPI and interrupts prior to allocating Rx
buffers.
This may lead to frame loss (there are no buffers to place incoming
frames) and even crashes on quick ifup-ifdown. Interrupts must be
enabled only after all the resources are here and available.
Split interrupt init into two phases: initialization and enabling,
and perform the second only after the queues are fully initialized.
Note that we can't just move interrupt initialization down the init
process, as the queues must have correct a ::q_vector pointer set
and NAPI already added in order to allocate buffers correctly.
Also, during the deinit process, disable HW interrupts first and
only then disable NAPI. Otherwise, there can be a HW event leading
to napi_schedule(), but the NAPI will already be unavailable.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reported-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 12 +++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 52ceda6306a3..f1ee5584e8fa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1394,6 +1394,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 	}
 
 	idpf_rx_init_buf_tail(vport);
+	idpf_vport_intr_ena(vport);
 
 	err = idpf_send_config_queues_msg(vport);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 285da2177ee4..b023704bbbda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3746,9 +3746,9 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport)
  */
 void idpf_vport_intr_deinit(struct idpf_vport *vport)
 {
+	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
-	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_rel_irq(vport);
 }
 
@@ -4179,7 +4179,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 
 	idpf_vport_intr_map_vector_to_qs(vport);
 	idpf_vport_intr_napi_add_all(vport);
-	idpf_vport_intr_napi_ena_all(vport);
 
 	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport);
 	if (err)
@@ -4193,17 +4192,20 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 	if (err)
 		goto unroll_vectors_alloc;
 
-	idpf_vport_intr_ena_irq_all(vport);
-
 	return 0;
 
 unroll_vectors_alloc:
-	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
 
 	return err;
 }
 
+void idpf_vport_intr_ena(struct idpf_vport *vport)
+{
+	idpf_vport_intr_napi_ena_all(vport);
+	idpf_vport_intr_ena_irq_all(vport);
+}
+
 /**
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 3d046b81e507..551391e20464 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -990,6 +990,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport);
 void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
+void idpf_vport_intr_ena(struct idpf_vport *vport);
 enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *decoded);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);

-- 
2.44.0.53.g0f9d4d28b7e6


