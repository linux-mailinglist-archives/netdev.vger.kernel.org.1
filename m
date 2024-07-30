Return-Path: <netdev+bounces-114062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D9940D90
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA051C2456E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77391990C4;
	Tue, 30 Jul 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjT+G744"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E276195389
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331688; cv=none; b=Kzz88nFfSd00a2AsIHqGgZFI3PiTI8zy+cjZbp1co/Ez9c7Xg5mdHhxr85lKUlnwd+x9PNtl7PNPwDJ68nwkQ1xS5hyH6Z2LQJHFQQvsbAV7yVTYS5lX53sfuTRR0Yq/CrKjkH2dU4zJ3OxxDuadtdAPkc8E2uO3SPQ91rk6XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331688; c=relaxed/simple;
	bh=aiibkHLYfAIJg7ZVJ7jttQ7bm7XvkHOAkgdHFcUoUHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5pTM+hCkRJ49RgnRPZKOicCLH+DACOY66CmWF9oMz9h+/tVi+qiI5ZbiE7V/bH9SNlTe3KSFBeokey/WZLZov2iruyFs42HJsXl/lz1eC6ThVmKH8xKIuoOfcsOIwgaA8gJ2hQpVS4ktAswxgS/B6BsYMZHFxGQOXHR7BKsv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjT+G744; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331687; x=1753867687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiibkHLYfAIJg7ZVJ7jttQ7bm7XvkHOAkgdHFcUoUHk=;
  b=JjT+G744wihtASFxgvpWaN1nGFkU5TrPItxzjwO9bKwv2Mcb+GiwUC3i
   mfeYiK3u3roXNjSNL5HxgMKNYZrhufimI5w4gu2pXywvWG3xsNqJgKNMu
   AM/q4d2jSdnR1hR6rT2hPpBAQt3OQCHFqdanU7HPQ1ufpFZtr4/D9eoUl
   dfiT1r9YySPrZNeR7G/5o7GtGLFNHQ1ffqK5r4YPVm/nSlLCaaKPLQZ4T
   PnefsBPUMKJHNliAFY8Uzl16F+r6xRrdfaAYB9Zp3TigkuKq4bUdk/qZq
   iTGQa+N0W7KWuy3lLYNSfRlPV7AjuMMW3cdmu5UV0arQ6A8tTVWIWFdVK
   Q==;
X-CSE-ConnectionGUID: LRDrtvnZQs2kENBetU443A==
X-CSE-MsgGUID: pI5r+dzARHKqdI30+I0dVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="45551335"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="45551335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:28:06 -0700
X-CSE-ConnectionGUID: 3INPqJXdT9GZEaeqtkUmnw==
X-CSE-MsgGUID: YkECMyYiTcSLFdpSFbyDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84923218"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 02:28:03 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 162942816E;
	Tue, 30 Jul 2024 10:28:02 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [Intel-wired-lan] [PATCH iwl-next v8 12/14] iavf: Implement checking DD desc field
Date: Tue, 30 Jul 2024 05:15:07 -0400
Message-Id: <20240730091509.18846-13-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx timestamping introduced in PF driver caused the need of refactoring
the VF driver mechanism to check packet fields.

The function to check errors in descriptor has been removed and from
now only previously set struct fields are being checked. The field DD
(descriptor done) needs to be checked at the very beginning, before
extracting other fields.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 27 ++++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 16 ------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 5b81b3fe2e18..997fd0d520a9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -9,6 +9,28 @@
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
 
+/**
+ * iavf_is_descriptor_done - tests DD bit in Rx descriptor
+ * @rx_ring: the ring parameter to distinguish descriptor type (flex/legacy)
+ * @rx_desc: pointer to receive descriptor
+ *
+ * This function tests the descriptor done bit in specified descriptor. Because
+ * there are two types of descriptors (legacy and flex) the parameter rx_ring
+ * is used to distinguish.
+ *
+ * Return: true or false based on the state of DD bit in Rx descriptor
+ */
+static bool iavf_is_descriptor_done(struct iavf_ring *rx_ring,
+				    struct iavf_rx_desc *rx_desc)
+{
+	__le64 qw1 = rx_desc->qw1;
+
+	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
+		return !!le64_get_bits(qw1, IAVF_RXD_LEGACY_QW1_DD_M);
+
+	return !!le64_get_bits(qw1, IAVF_RXD_FLEX_QW1_DD_M);
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1336,7 +1358,10 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		if (!iavf_test_staterr(rx_desc, IAVF_RXD_FLEX_QW1_DD_M))
+		/* If DD field (descriptor done) is unset then other fields are
+		 * not valid
+		 */
+		if (!iavf_is_descriptor_done(rx_ring, rx_desc))
 			break;
 
 		fields = iavf_extract_rx_fields(rx_ring, rx_desc);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 289d061c3a58..94023873cb36 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -80,22 +80,6 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-/**
- * iavf_test_staterr - tests bits in Rx descriptor status and error fields
- * @rx_desc: pointer to receive descriptor (in le64 format)
- * @stat_err_bits: value to mask
- *
- * This function does some fast chicanery in order to return the
- * value of the mask which is really only used for boolean tests.
- * The status_error_len doesn't need to be shifted because it begins
- * at offset zero.
- */
-static inline bool iavf_test_staterr(struct iavf_rx_desc *rx_desc,
-				     const u64 stat_err_bits)
-{
-	return !!(rx_desc->qw1 & cpu_to_le64(stat_err_bits));
-}
-
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IAVF_RX_INCREMENT(r, i) \
 	do {					\
-- 
2.38.1


