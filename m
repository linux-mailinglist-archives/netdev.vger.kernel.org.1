Return-Path: <netdev+bounces-144883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F09C89F1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F93B2EF14
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EF1F9A8D;
	Thu, 14 Nov 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQ5XjDm1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746961F9A91
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586970; cv=none; b=OL9odgsj2YWbUuxClQZpenmtuiz62PhLGCXnhH8uWy7EZ+WPiOMwDnEDy+IZhgaTrKgDQyfRroObZ7bWzSvrpG6Lru0LTlZJ+oQW7/8HWfW4TeLUKjYLfMo2DzZQuv1WmFxDzM59sGZRDliCdDdqTh1ZkAyp4ryu3B9EF4RvSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586970; c=relaxed/simple;
	bh=uSfGMC7MpvLcsmrYMIC/KjTjHJL8kyUCy9g8i5xca0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hzgl6giy0oTZZy44zI0ctwQEzW7d7J8cMSo1DmXE3iSxmlQQGEnPatgOXSqHZJ1jzDDZFOXvI/oh85MxoaHrhqrj/lDVNsIdE5a8aYQgZbVyUXwNflr65l9yA1KUOeanQMdLRYbt3inWAu7b+VuufYjAADExw5FWzhCVNbOjcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQ5XjDm1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731586969; x=1763122969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSfGMC7MpvLcsmrYMIC/KjTjHJL8kyUCy9g8i5xca0k=;
  b=LQ5XjDm1/DbxllHYaOIMI9EkL3A+bTzgwj9YEYPl0XPfxoL8FtfjTi0J
   lQrAJqh2Z8+TneyGDoUPYG/ZetixYCS5bkNkdX2SUpO9q7unFS9YOPG1Z
   PRHzRgKlrYdk3Y57ZAWP87oax5c3IDranuRk5XGmhkqfIR70RpOJuumM2
   dWBPOy6yuNskE0hw7x6+GwaAcTrZVrrXAK5hdoswa20t3R68in7qTvuKr
   3zZsmdhTOLE3a8hNPuohP34w5iILw2vs+JQfitTSNUh+aNuzJU/iIHro0
   1wDna3KQVzLZBCSsbMWvWSzPQFcdZoYV0aZ7yyPZ2BJ84taaKK4GYJGaM
   A==;
X-CSE-ConnectionGUID: LjQ7AO4eQpuxOa+7EPRPgg==
X-CSE-MsgGUID: 1JbcyXTWSsajE94/2rmmmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42145109"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42145109"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:22:49 -0800
X-CSE-ConnectionGUID: mMvXgwzgQIuC5GR6+C53MA==
X-CSE-MsgGUID: MfjcJqrMTbmougbLThm7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88083637"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa010.jf.intel.com with ESMTP; 14 Nov 2024 04:22:45 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: michal.swiatkowski@linux.intel.com
Cc: David.Laight@ACULAB.COM,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	pawel.chmielewski@intel.com,
	pio.raczynski@gmail.com,
	pmenzel@molgen.mpg.de,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com
Subject: [iwl-next v8 9/9] ice: init flow director before RDMA
Date: Thu, 14 Nov 2024 13:22:39 +0100
Message-ID: <20241114122239.97600-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
References: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flow director needs only one MSI-X. Load it before RDMA to save MSI-X
for it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a6f586f9bfd1..b6997481fd42 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5175,11 +5175,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5187,6 +5188,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5210,8 +5212,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


