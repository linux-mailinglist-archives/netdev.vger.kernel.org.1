Return-Path: <netdev+bounces-170415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08FA48A56
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5B53B5F5C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C921E51E0;
	Thu, 27 Feb 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4uXkicO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC48BEC
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690977; cv=none; b=dQXtr53wlGrLxpd4o6IM9u4PWPHoXA0bxlG+5EQ0bfmCXdUS7nbomyl/FNyr8lHh9XbUkex+XjFO/DZmNxS/arwBN2P/BE/fIuLrEFaDhDOwJyJYHpIMbTgkIlTFMvGYi5H55nbrq1+JTOF3HBy0DEyKCA4k84suMtBjjl+nIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690977; c=relaxed/simple;
	bh=oh3IVZx752jbwhy7GaUotxI9REU9iazHHuSmuL5k8T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i82boP6bc1Z2iaXt3zltsucuWq5/B0ry7YftNMkT0yJNrKbrbNcz5+4JrEahrdlGHyYh3kzebUBxdtKjot5RrtB6cRizrtn1+qhlthzVS+onJpER6wTVVHM1/j4n+ofc0vUikDbZlIkBCHDDC0dA/6+Ra0fA6lmnoKJPepscsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4uXkicO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740690976; x=1772226976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oh3IVZx752jbwhy7GaUotxI9REU9iazHHuSmuL5k8T8=;
  b=T4uXkicO5DkC650T+DZrvycAr4vQUim+S+YvfdNR1oRYjBAK+v7c3DDm
   6jgTZLL5wA4G19RJJuUONND4LSj7zuky0ClQKLnNcey0EYeQgDZ+uNGN3
   651eQhD5fMGSsVZb7K5CEMaj4z8NoAqi3l7ihBkxd3jHbLPKfTBB0jmA4
   O69o8b6ntTYuYQJQutjkzrSNiocJPhE9DWVxGE25JjALjFRD58yWIGap5
   mzDokKF5eWroTdrn+mucEHnOGs4ckQyIc/y/hhHBARkqNOwjxhg7ZdyCl
   5Nt2q34AlJuvVAjLmffZ/UiHdKrPx5Xes63EUPEoC3vgjiWJHTPstXgd+
   g==;
X-CSE-ConnectionGUID: OPdDT65yQ7i+O5NaU1ctSQ==
X-CSE-MsgGUID: oerNaE9hQ92diEZ4c4U1EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="29205991"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="29205991"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 13:16:15 -0800
X-CSE-ConnectionGUID: ZbTco0XYQS+Xpr9XC8b88A==
X-CSE-MsgGUID: 7lWfphKGRReHFJfnTXRGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140365217"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 13:16:14 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net v2] idpf: synchronize pending IRQs after disable
Date: Thu, 27 Feb 2025 13:16:09 -0800
Message-ID: <20250227211610.1154503-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

IDPF deinits all interrupts in idpf_vport_intr_deinit() by first disabling
the interrupt registers in idpf_vport_intr_dis_irq_all(), then later on frees
the irqs in idpf_vport_intr_rel_irq().

Prevent any races by waiting for pending IRQ handler after it is disabled.
This will ensure the IRQ is cleanly freed afterwards.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Suggested-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
v1 (originally from): https://lore.kernel.org/netdev/20250224190647.3601930-4-anthony.l.nguyen@intel.com/
- Rewrote commit message

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 977741c41498..70387e091e69 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3593,10 +3593,15 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 {
 	struct idpf_q_vector *q_vector = vport->q_vectors;
-	int q_idx;
+	int q_idx, vidx, irq_num;
+
+	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++) {
+		vidx = vport->q_vector_idxs[q_idx];
+		irq_num = vport->adapter->msix_entries[vidx].vector;
 
-	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++)
 		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);
+		synchronize_irq(irq_num);
+	}
 }
 
 /**
-- 
2.47.1


