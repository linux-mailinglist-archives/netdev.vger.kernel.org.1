Return-Path: <netdev+bounces-158899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1575A13B0C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96AA161ED1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813D1F37B0;
	Thu, 16 Jan 2025 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAVikvRP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCED6DCE1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035000; cv=none; b=OwNOVV4xlAZtq3U5XMryssTxw2FQVO8qd7nf7Wls56u5Lsda24gh7CIs2l9eEpxFR0+xCWFyPiUtVx/8wsZG6dFBwr+JQcGG9cNEcd/NaRKAuwJ6N3YChquG9IftCXaj6M76OcyjdsdSd6HGxg60XSvHRywLfQmNwM5hIpJPFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035000; c=relaxed/simple;
	bh=IZwr/CsfoMIuZdZy4cqtAyqJw+Xf7KaIKfQsIzcNrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IB9/6b8Iu58dA2apZf5hAgqMeTxrY+NRwxVVIuRCD1PalKOEzdnKCQJL9fGP/uZjT+DfqwYue82bkLtVwQ7JBSatwbY4wasbSKfbF4urkyW4p1CM2Um7ja2mlPzVDBnxAyN+c+nc45cBPOn5WBOFzJzcvhLqZqy4g8pZr60LC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAVikvRP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737034998; x=1768570998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IZwr/CsfoMIuZdZy4cqtAyqJw+Xf7KaIKfQsIzcNrm0=;
  b=PAVikvRPdZ9w0hWro52TP2D/J6lLKXWGJmT1VqRX8scHR7ic/MOsU9Je
   MciPDCczx72ymjhewa1wS9cZeg5jWGmnW1DV/RFjKDmrOToyWUrIJJ9zx
   pwDu2XMEFORXoLVlTVcUQjJ1Nq7AN22kqlJgYHCuelMxumHuA5rPHpBKk
   KMZSLSeMqkwMuxe8UnHHHnk7sBtTKf6W+ls97GecCGY6mDKxu9xGQ3+Lo
   m9cSUyhdFwfvCOBud36LTzkXtROUm4w8Yj0zbQU2Gwr95uho1c8CCdV28
   5d5F+lQgnt/mMVUvtsKfgsG38Hyn/GzbK1YPXnyHemYztUdWiSTdqiFY6
   g==;
X-CSE-ConnectionGUID: uEwNaPPuS3OuxFqSOhBVZQ==
X-CSE-MsgGUID: VdeWJCRGTJeyBwV2vK2SPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48834679"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48834679"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:43:17 -0800
X-CSE-ConnectionGUID: f0+D8YZ6RgqpYjvENTVZhg==
X-CSE-MsgGUID: su2RPnGyS7+9K+vwTCHPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106082341"
Received: from spandruv-desk1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.109.48])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:43:15 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Subject: [PATCH iwl-net] idpf: synchronize pending IRQs after disable
Date: Thu, 16 Jan 2025 06:42:57 -0700
Message-ID: <20250116134257.93643-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait for pending IRQ handler after it is disabled. This will ensure the IRQ
is cleanly freed afterwards.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Suggested-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9be6a6b59c4e..8006bd9a95f6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3592,10 +3592,15 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
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
2.43.0


