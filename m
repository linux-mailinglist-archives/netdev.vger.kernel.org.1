Return-Path: <netdev+bounces-116729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C494B7BA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67F11C21D2D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6438189BA1;
	Thu,  8 Aug 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fmu5rTyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44420189BAD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101644; cv=none; b=M9BtCzBKOCKdC3qRFxB5OdS6fKngnmVziBXhBjJ/UucnpJoyyAkRW4tKLQA/T+8jddd4Hz6Lz5Oy/Tr2v1GZSYq2HkXgrqhN/Ef7e1CVrOETwJWdUtvOXEetnlGQAH/g1+mRBTxreNNbXa2oewdaAdgxE10tO0QENFnZ898q8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101644; c=relaxed/simple;
	bh=a2QTM4YmmefzVNxyTiU8f/nPHpRT+z0Aq+zZodKDD3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL/7Oh8GrgNzaNe6nZiqJ5C1NX6OzZ5evA7R+i7VpXMTZ8E56dDY6+CtOCJ6B4zXjGlFYa3jVqv/QvzeF/vMpJpMWg0BbY7pddO8Md0omYW5IT1bFY+EfzrVZ5ITsRboHUjtjIpGpa23nDOCQxbXUFZLdqRP8SB5CUc/UhmdySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fmu5rTyZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101643; x=1754637643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a2QTM4YmmefzVNxyTiU8f/nPHpRT+z0Aq+zZodKDD3A=;
  b=Fmu5rTyZb6CXgw8R9kRvOX5Ps943vD97RVAWq9cyiVtJCD6nBqMhfXsq
   vjgoKuIlf9177Fm50Ytn3+NKL8YCx6s/lM4Dj3By49ggmRs18ch//kVCE
   BxBYXoEakMaKWRjw8MwWxl/4uJuntYXE7frB4T5TpPMmOOERVALFExvma
   TMvUkEUVgzLBkoUYUZiJU4FdW/iJgK/4M2msOqI0oiIuQPGcPrWG83Msw
   uNlDIESmS2RmoG9GLjiWy8ulre7JJnwlM9FYyK2pO+6hg6J7cFs0SowtP
   UaOUo0w/1JzNN6akpdosQqlBqNBX6qMNny6VPwzB4eXzdOoKChq5sOAdn
   w==;
X-CSE-ConnectionGUID: wD9pIajDRoCcicK/vgUyqA==
X-CSE-MsgGUID: aUMS5VZ9Qi6F3Rm2qV4VDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21361390"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21361390"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:20:43 -0700
X-CSE-ConnectionGUID: DTJwXOX6T2GOc/cy3vn76w==
X-CSE-MsgGUID: S8RDVoyyRFW1oE2VY44O8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57073518"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 00:20:40 -0700
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
Subject: [iwl-next v3 8/8] ice: init flow director before RDMA
Date: Thu,  8 Aug 2024 09:20:16 +0200
Message-ID: <20240808072016.10321-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
References: <20240808072016.10321-1-michal.swiatkowski@linux.intel.com>
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
index 8f02b33adad1..2a3c6c29cccb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5185,11 +5185,12 @@ int ice_load(struct ice_pf *pf)
 
 	ice_napi_add(vsi);
 
+	ice_init_features(pf);
+
 	err = ice_init_rdma(pf);
 	if (err)
 		goto err_init_rdma;
 
-	ice_init_features(pf);
 	ice_service_task_restart(pf);
 
 	clear_bit(ICE_DOWN, pf->state);
@@ -5197,6 +5198,7 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 err_tc_indir_block_register:
 	ice_unregister_netdev(vsi);
@@ -5220,8 +5222,8 @@ void ice_unload(struct ice_pf *pf)
 
 	devl_assert_locked(priv_to_devlink(pf));
 
-	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	ice_deinit_features(pf);
 	ice_tc_indir_block_unregister(vsi);
 	ice_unregister_netdev(vsi);
 	ice_devlink_destroy_pf_port(pf);
-- 
2.42.0


