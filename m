Return-Path: <netdev+bounces-130328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB398A181
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7584E1F20597
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398E192D8F;
	Mon, 30 Sep 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3dUMuvw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3A192D63
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697869; cv=none; b=XbSolJc6nNqPuTzmdhaJsve7K+rLqcsvfBh4DBf1T/xPRvV5f7E7rhFS7I2CMg1VpHMvEoGjUj/wBR3hp9hpqifAGpSwYttE6bbEn4SHttKd6hdD8RQRrBNs8qbpcWPslh4ujxTenHJ8ZgCBoM9Gx0aXh/BAiUvbNCukP1tTV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697869; c=relaxed/simple;
	bh=+aAYHoZPaeHh7Hy62w+oK6tBM3RYG6kFiyaV03yiAMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNgeX3DlCGqLUmjCUg/e9qdkFaNqu6NKwu4k6R2/PIb5feX8eqUQA/jfRAx0qpQjE1dyMCTHWo+gcSuFGGRu3W/Ci+FbMetQMFDS2xab1Sduhka/GQx5jyMJdUrNEIMijlTsXu7HXW082N0lZFBU+xB1h2K5d4fvSSQWX6Pu0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3dUMuvw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727697869; x=1759233869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+aAYHoZPaeHh7Hy62w+oK6tBM3RYG6kFiyaV03yiAMs=;
  b=Q3dUMuvwuZPD+efSSJCuu/xmzgr5lfwVCxK6iuFuhoVije0ZVH4rfNjL
   8OlmAsj2miimEWrhygZUe2z9ekx+D/9ArruS+xYQ/2k7lO+2ttiT2Ps9w
   he0wBBFtyq/y38+NQ3QW9tr2iBuhjnKw8n/q3CN1YPqt1P9yHdMq+AhX8
   HQsDioCK6t58yLeaqxWUG9MoP16iHrd5oCxYKnwHA3eSqiIuKoLFE1fvw
   2eU5MDLnPYYmfptC+OaMFMR/iJi9zk/LFPliiu63VNgsMWpROzl4JPwHv
   YtUqwLz5k2KkLaymy1RTlC5bXAdEWsCGrSjvulbwsYoNrJVXeq9EjcQbP
   g==;
X-CSE-ConnectionGUID: DBF+t3TSRIqQEo979wjRvg==
X-CSE-MsgGUID: JbYkI7E3TbacJxFWJfHbPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="29665590"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="29665590"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:04:29 -0700
X-CSE-ConnectionGUID: xc0ZzHdzRB6VDIAiMelOgg==
X-CSE-MsgGUID: KRGBYmFYT1KvHViScywwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77363559"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 30 Sep 2024 05:04:26 -0700
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
	jiri@resnulli.us
Subject: [iwl-next v4 8/8] ice: init flow director before RDMA
Date: Mon, 30 Sep 2024 14:04:02 +0200
Message-ID: <20240930120402.3468-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240930120402.3468-1-michal.swiatkowski@linux.intel.com>
References: <20240930120402.3468-1-michal.swiatkowski@linux.intel.com>
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
index dc1a085d413c..ef5e04c06267 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5217,11 +5217,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5229,6 +5230,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5252,8 +5254,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


