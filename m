Return-Path: <netdev+bounces-243334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B37C9D4E7
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 00:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C2BE344F26
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40AF2E0B59;
	Tue,  2 Dec 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkwIc1k8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588B2BE033
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717220; cv=none; b=DiAfJFBCXkheDOmrIQXXWss/w6mVIBxC52j8vb1xt3YKyDxFlztmcbbLnXwkCBeY/gCsdmixgRo3SGaOmMPxX7Pms6B9PnzNvFQHunUaCBSwf40a7ZZMkdShDFE8Qjg/Wb/vtN6HmBFghupU1S/buwbhy51JjfXBx5SGGgOmAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717220; c=relaxed/simple;
	bh=fB1lfHRjYWJU+XiQfufCsleOAjIffS1TuegcepeOWEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+vu7AWS3Qz56/kisapa44cYXXy/cDYCtbzk/tIcDr94iC+mopMXxtjgqwVfqkzJmsr01trrTZrJTnjSB2S3gaB2XYjv8cuGfiYv1Y9YptSa91geAL4AdjBn8/Ts7fVVtLIF0cHnGRdJj+NhaQ208hlMgQ4HKZXm1D9CEwusItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkwIc1k8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764717220; x=1796253220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fB1lfHRjYWJU+XiQfufCsleOAjIffS1TuegcepeOWEs=;
  b=PkwIc1k8N+tEVsgZpk3KmtcDgPgPhBIYw1NVDLBpYursyQvJRl48Vamo
   QTzBQbjHtiixtYItWH1UnaL4qeF3m3DKJBEf69QrIAP4ibcTbQy/iLMIR
   vBtwQRAjlY4RpajTlx8LVcRJMC6X/nX2ee0iCEV3TRRVBVxo4mGI7EAzd
   4KlIiPn/bwSzLo6RbqWWCq4wxPNEBEB/5M7n5QHr7juhPivxA4eoRg9U7
   BMKUuZTWUCwOiBdBFx5wt5vBwnCY4gdxOpIT3QYBuixIJUF+Q8PXDe4AS
   ZJwVSGr/V+W2c6Bc+qncVhGsYtmrCj6WuZ2dH+rB8fYdRIffNfDkYku7B
   Q==;
X-CSE-ConnectionGUID: NgGZBiTJRASW8KXt0z3y6g==
X-CSE-MsgGUID: ZlYVYI6gRoa/4aPfKbyg5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66741164"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66741164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:13:39 -0800
X-CSE-ConnectionGUID: U1es4Tc2Qhav/mITG6KdTw==
X-CSE-MsgGUID: QzSaEjHJRam7qFV6VeQOWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194505867"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2025 15:13:39 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] idpf: Fix error handling in idpf_vport_open()
Date: Tue,  2 Dec 2025 17:12:46 -0600
Message-Id: <20251202231246.63157-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix error handling to properly cleanup interrupts when
idpf_vport_queue_ids_init() or idpf_rx_bufs_init_all() fail. Jump to
'intr_deinit' instead of 'queues_rel' to ensure interrupts are cleaned up
before releasing other resources.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 89f3b46378c4..a5051a96f2ad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1516,14 +1516,14 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto queues_rel;
+		goto intr_deinit;
 	}
 
 	err = idpf_rx_bufs_init_all(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize RX buffers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto queues_rel;
+		goto intr_deinit;
 	}
 
 	idpf_rx_init_buf_tail(vport);
-- 
2.43.0


