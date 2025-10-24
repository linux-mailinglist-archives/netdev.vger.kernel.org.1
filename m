Return-Path: <netdev+bounces-232703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E51C081E8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB5254F5A23
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9782FC038;
	Fri, 24 Oct 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eboQK7a7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7C2F5A27
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338878; cv=none; b=bOBBiqKO3SD3Eav177ytwqbd22f5tQlnAazAfKBGSAD1Bf3ZFIA41rvVkqxapz0jSSEj2tZIIxh5ImtbTPZBsOjLcMV7ghsNaOMSNlYy4QXMglgNrvf8S9JMZI9M3lOqZk4NaQ8nYbFAGfhx7QgkyqrqX6v2AmSYYJfsX/uAW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338878; c=relaxed/simple;
	bh=F+sFUYnSofF/7SytIdsqtut7eF3fre6zQphQJqHu6RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBo4aVUDjv/y/YKwlqQwkUKKuAzXibNNe3Fvtrfyjb3Bv90wC1qGUYkPxzC/pemcFjLxDrfgXsT6FUcvpqlc4NQcydBmRs8NCibsqQ0iIDUJ2a2yhUrFaVCJ8aJG4xFjAe57wwgiRop5Fe5gn9Dqbb+cAZD0i4w+id63hzkJqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eboQK7a7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338876; x=1792874876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+sFUYnSofF/7SytIdsqtut7eF3fre6zQphQJqHu6RU=;
  b=eboQK7a7n/Uze2OxWk56D9U3Ea3Q1leU9f3rNr3SVjHfXB15wCcESboE
   HFaGTKfw9ASSAqBbqM5D1XnbjyiI2M4xM/AR2IEsk2WvMH7FUqy3Zo0aI
   FbJsENDmNT0nt3rwwgw3iiMWInx8lxxkUSkjn5GEIqaY0U9aqFmvN6Mn2
   bTvcGyh6I+Ur23tFyJvtv48V7R5VnnFvixUInmRhpr+K4wZphIJMMdiHl
   aWfiLJBEpGRNAOpQliA//uWXi2sGXVJ9CVrIbAyIk/xBRpTR7d/BCUvKo
   FnTzXSogjQ3GILsXwHFkYuR0fNJat3P5t4M0d6ltOlNh3r20+ltkMcApj
   Q==;
X-CSE-ConnectionGUID: 5Leg8spVSpeQQgbD5+M6kA==
X-CSE-MsgGUID: ll6feiWBRB6qgWQ0pJukEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139506"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139506"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: yoSpRAPrQYeL53pmXDTixw==
X-CSE-MsgGUID: mGS9M3DaQkGIQIvomUWHFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821523"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 4/9] ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
Date: Fri, 24 Oct 2025 13:47:39 -0700
Message-ID: <20251024204746.3092277-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Unroll actions of ice_init_pf() when it fails.
ice_deinit_pf() happens to be perfect to call here.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 31 +++++++++--------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e00c282a8c18..09dee43e48aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3951,6 +3951,8 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  */
 static void ice_deinit_pf(struct ice_pf *pf)
 {
+	/* note that we unroll also on ice_init_pf() failure here */
+
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
@@ -4055,25 +4057,6 @@ static int ice_init_pf(struct ice_pf *pf)
 	init_waitqueue_head(&pf->reset_wait_queue);
 
 	mutex_init(&pf->avail_q_mutex);
-	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
-	if (!pf->avail_txqs)
-		return -ENOMEM;
-
-	pf->avail_rxqs = bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
-	if (!pf->avail_rxqs) {
-		bitmap_free(pf->avail_txqs);
-		pf->avail_txqs = NULL;
-		return -ENOMEM;
-	}
-
-	pf->txtime_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
-	if (!pf->txtime_txqs) {
-		bitmap_free(pf->avail_txqs);
-		pf->avail_txqs = NULL;
-		bitmap_free(pf->avail_rxqs);
-		pf->avail_rxqs = NULL;
-		return -ENOMEM;
-	}
 
 	mutex_init(&pf->vfs.table_lock);
 	hash_init(pf->vfs.table);
@@ -4086,7 +4069,17 @@ static int ice_init_pf(struct ice_pf *pf)
 	xa_init(&pf->dyn_ports);
 	xa_init(&pf->sf_nums);
 
+	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
+	pf->avail_rxqs = bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
+	pf->txtime_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
+	if (!pf->avail_txqs || !pf->avail_rxqs || !pf->txtime_txqs)
+		goto undo_init;
+
 	return 0;
+undo_init:
+	/* deinit handles half-initialized pf just fine */
+	ice_deinit_pf(pf);
+	return -ENOMEM;
 }
 
 /**
-- 
2.47.1


