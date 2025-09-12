Return-Path: <netdev+bounces-222593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D42B54F2C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17165A2C60
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D0030F54D;
	Fri, 12 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiHs6GHy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EB30DEC8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683038; cv=none; b=HMgj8jJc3y+JoX7M0w0lP6WtESYa9R974TG2CE571eTZnkgqUjfu9KAAd05sQ+r8ckzEh3r1c5tscDRZzfvitFaGDIMTQXONIWER4jQGrf87zlCGJHlPQ30Kl0KwIHv9YdwmLkdBTfQb+RIQDxKqvh3XMUp2k80XJtHTcL3xAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683038; c=relaxed/simple;
	bh=zEDT2zk6sDw9n7wb2DsAGhqz7IAju+kAkTiyHD5PYg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAZ7kdWmss2zlt7UjnBSzvT9cOieWwCAxH4biE++Fhcu9FkAWzIzKrpstnGAOnz3i7ZEeBq93GVkcKmW2a1zocFWcmcJvWu2mPA8RKd34Se6HHrLZ0X2W8dJQI8wUTEHDXvaakj3AGUq+cnQxWJ9Bnurc20TeBUxgayiliBBGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiHs6GHy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683036; x=1789219036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEDT2zk6sDw9n7wb2DsAGhqz7IAju+kAkTiyHD5PYg4=;
  b=LiHs6GHySdpD3XpnKmyhrdo0NIt0cJumNEhks8XjklGr+pwsrfIzJEPq
   uWxDXWiws8l94ympEUV2PZGdWThZ91YjtEHKkS+LBMR3oHCF0b0xdawF1
   vtfWgwUubEU2O1eVUnaCynbeeqF/Hx5J8NcrdiBQWF46qcJUGdoxIdva6
   qNfNGldmKoyGOTZocZcWiHtirIGF2Ub45C9jk0OvhGgTc4lkEVMyTiFEj
   YXicfm+bW17GIUZeFSU9hp7cjMMBIiObYwa9hhYrCC1PYcM41w/8C5zw9
   5Z8iZ4qHVz65JnTXbBk9F4umj0CiNFF6q+76SzXFL5FJ3s4ke4RRxsivJ
   A==;
X-CSE-ConnectionGUID: 0gnp50jSSI2jkyRUbe91gQ==
X-CSE-MsgGUID: wH+iqNLIQQ6VrjxszKe8SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461416"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461416"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:14 -0700
X-CSE-ConnectionGUID: RDkGcKA2RlukGmBI2tbb1A==
X-CSE-MsgGUID: R07mJCgWS5mICKWxcLDOWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131222"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 516162FC72;
	Fri, 12 Sep 2025 14:17:11 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 4/9] ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
Date: Fri, 12 Sep 2025 15:06:22 +0200
Message-Id: <20250912130627.5015-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unroll actions of ice_init_pf() when it fails.
ice_deinit_pf() happens to be perfect to call here.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3cf79afff1bd..f81603a754f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3975,6 +3975,8 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  */
 static void ice_deinit_pf(struct ice_pf *pf)
 {
+	/* note that we unroll also on ice_init_pf() failure here */
+
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
@@ -4074,16 +4076,6 @@ static int ice_init_pf(struct ice_pf *pf)
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
 
 	mutex_init(&pf->vfs.table_lock);
 	hash_init(pf->vfs.table);
@@ -4096,7 +4088,16 @@ static int ice_init_pf(struct ice_pf *pf)
 	xa_init(&pf->dyn_ports);
 	xa_init(&pf->sf_nums);
 
+	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
+	pf->avail_rxqs = bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
+	if (!pf->avail_txqs || !pf->avail_rxqs)
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
2.39.3


