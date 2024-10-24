Return-Path: <netdev+bounces-138614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA09AE487
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE501C225D9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F51D5CD9;
	Thu, 24 Oct 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnYcg52U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124431D5151
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771985; cv=none; b=pP0ooZ+MLMRy2ChNqsPD9WPHBccYtI//TURg6vFpzzp1/5lI/4WR+e9fP4Tpu4RBB6QFSVS5HJndHs7fKVjUWAT/6wfrRkZmetvxJsr/aD/6Ss5NoTBo9xx5NgmY34co55d+sgGPUxdJrNnIj3oWvgrZiwtdIHKxXlkMkqqH85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771985; c=relaxed/simple;
	bh=bNMiaOO8wUNylIk9gISuKsnF9jJ0waLC+cK5MBdQs1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLIcbOEN2e+6xFzP3Em5Le7NUy6iGSf1bdSYx5vmYlicIRJH7gDhT4p0ZGrD0QCNlVH/lv/NHWF8mqfwWsTK3VFOkmSt4amq06pswREIcgQSlUxzxTtnU5a3wPD3Z81LPlWC++LYPkFyVz3m8YUl52PIjcowBYPA0cF6LCtkYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnYcg52U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729771984; x=1761307984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNMiaOO8wUNylIk9gISuKsnF9jJ0waLC+cK5MBdQs1o=;
  b=gnYcg52UbVtsJRbQ8DTkMNRJIPBDpbCjYrvg5ORvYxsWtd45D5YzdT4L
   KRKzpCgbsmCsNu+COePOySS04MhRgcdw9dprskF5fivj4cMBJMQ93+aaG
   fdqE9L0gJuJj01Ok4/etdPyLbU88Yo+OJieHep3Ulp+OrIl2X4gcUD0PR
   bHzv7OQvrNL/HamRxcnhW1w6p+GJ+pWfEKpOQaa+ALM9tELIP4kWGG2mb
   7DT3W+RLmbHM6TgYk5a8blTu/Oz0GdQdQwejF3cSt3+75kHoYohGYLldG
   gxjaplQCpxu5Cr8BmN6BcalEatf7L06aProCaLBKMed64qbdojO4fXYON
   Q==;
X-CSE-ConnectionGUID: E/sYBT9TQrODA1zj31PKvg==
X-CSE-MsgGUID: 8ZdgZlkeSdCpTNqjpJAdnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40008340"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40008340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:13:04 -0700
X-CSE-ConnectionGUID: Sw7L44ZHQcmrDxWdgfUTGg==
X-CSE-MsgGUID: Z8CvajSmSHeDasj/KKYMaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85184537"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 05:13:01 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v5 9/9] ice: init flow director before RDMA
Date: Thu, 24 Oct 2024 14:12:30 +0200
Message-ID: <20241024121230.5861-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
References: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f3dd300a7dad..b819e7f9d97d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5168,11 +5168,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5180,6 +5181,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5203,8 +5205,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


