Return-Path: <netdev+bounces-180602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD9A81D16
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57F9463727
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676AC1DD877;
	Wed,  9 Apr 2025 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM4VntXF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DC1DD9AD
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180195; cv=none; b=PFya4en+zMigKHz/eFEHYqKB3oz6Z7FXNHNw3tOoM+KntmExQNxmMiSF5O3I+DBRGQBlQmlrzPQk5phWrgY//BpMqPhYIHUAsHF+9qPpwIBxI69ZYZYRjzhXgXlodM/rjbU+gzCzZYP1mhJs9u2V/28YlxqPP6hzqUW1DFKUN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180195; c=relaxed/simple;
	bh=D9h/SvR+OD8whX99uCWdOOZoeOyHH8WRSCSyoddVY80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BecMRHk/D8OkWKCHK/zHZvZNQIw05diNJ29/YMClXojurtgk2Lg44bScXCIL9QJxKciAKIiafUJQ6ZlM7WhikBTM0us9EkghRLXG+wMFGGFgEJYXTDNLU2icA2T7dCz5qH8ff7Q95JoB16NpAUCBvORbHN0o9Rte/uLK/ka19wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM4VntXF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744180194; x=1775716194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9h/SvR+OD8whX99uCWdOOZoeOyHH8WRSCSyoddVY80=;
  b=XM4VntXFVtDdyEzM6f1lTn9Q1LxIW6r63iuFF3VtHatOhlcFGhGVmN53
   ARkwkuE9+fl59BQa2q7nZtXYnYGR4xMOfst8G4h+PXbdzbZQacub7vaE1
   Dqgajb/2QsCt4SoXHTuTci0WrV42DANgFeL2wC4MKs+GJvxC+lprpBv9E
   EsrFVlK+cv5vEiMRDYyZ34KDkAUtilfQmhMFT+kotOIJuGl1IGXE01unJ
   8zSpNuUuCAoNdwKBWTkenx2NlIJU04xE9eo3jxS4ZolUMhEbTqLWLjx0b
   YWKRT6b5E4nxYD/nsgMQFSkRCmnDCq7sL5dD0VA+jN6yEkLeIg1E754qj
   g==;
X-CSE-ConnectionGUID: EI+pX0MXTFiDOHGEXFnn7Q==
X-CSE-MsgGUID: iFQ2bKDfRs63gjZBbFkKKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68117915"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68117915"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:29:50 -0700
X-CSE-ConnectionGUID: bgnxuz6AQtW5CquzZ9AqkQ==
X-CSE-MsgGUID: RpklP67JTsCw0bERkkquHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="159478568"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa002.jf.intel.com with ESMTP; 08 Apr 2025 23:29:48 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-next v1] idpf: remove unreachable code from setting mailbox
Date: Wed,  9 Apr 2025 08:29:45 +0200
Message-ID: <20250409062945.1764245-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove code that isn't reached. There is no need to check for
adapter->req_vec_chunks, because if it isn't set idpf_set_mb_vec_id()
won't be called.

Only one path when idpf_set_mb_vec_id() is called:
idpf_intr_req()
 -> idpf_send_alloc_vectors_msg() -> adapter->req_vec_chunk is allocated
 here, otherwise an error is returned and idpf_intr_req() exits with an
 error.

The idpf_set_mb_vec_id() becomes one-linear and it is called only once.
Remove it and set mailbox vector index directly.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 730a9c7a59f2..4c18c5fceb97 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -143,22 +143,6 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	return 0;
 }
 
-/**
- * idpf_set_mb_vec_id - Set vector index for mailbox
- * @adapter: adapter structure to access the vector chunks
- *
- * The first vector id in the requested vector chunks from the CP is for
- * the mailbox
- */
-static void idpf_set_mb_vec_id(struct idpf_adapter *adapter)
-{
-	if (adapter->req_vec_chunks)
-		adapter->mb_vector.v_idx =
-			le16_to_cpu(adapter->caps.mailbox_vector_id);
-	else
-		adapter->mb_vector.v_idx = 0;
-}
-
 /**
  * idpf_mb_intr_init - Initialize the mailbox interrupt
  * @adapter: adapter structure to store the mailbox vector
@@ -349,7 +333,7 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 		goto free_irq;
 	}
 
-	idpf_set_mb_vec_id(adapter);
+	adapter->mb_vector.v_idx = le16_to_cpu(adapter->caps.mailbox_vector_id);
 
 	vecids = kcalloc(total_vecs, sizeof(u16), GFP_KERNEL);
 	if (!vecids) {
-- 
2.42.0


