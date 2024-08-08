Return-Path: <netdev+bounces-116727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12F94B7B8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D795283294
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8E189B92;
	Thu,  8 Aug 2024 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU/tyy5J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EC18991C
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101638; cv=none; b=dIlTsPOp1hKbeUk7y1cVcRJxoR9JaDrGm31ebJh49/yxsm0iiNEE0fiK4A+bHHormlmQdY6Vkc++tcPsguiEvKjQp96UcOSOGpeCfqa84aPdoC3PiGnFBMi+BBrfn0mm4lfCDcIhdChsK06TLP1jhL+eOAXmhkdZwYHzT7aERY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101638; c=relaxed/simple;
	bh=WK8qdsTxDcmqkJblWSy4esjLmghvrfMZPQnaAtP1zd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTia8yaympGH2BjK3A1qf4mKji2xK6ncOHQuGaE6GQpu/Kgd9GWXe5Hycdin8DWSSCtuXDJQI685lnLmIBQaVBLwoSiwTGo5wFfHnlrveeLBRfp4Fg2UWhZUJpVI1TW9PZmAHfp9zxevfpjcQdm/A+lGjUkjbIblBM2RlxOPtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU/tyy5J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101637; x=1754637637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WK8qdsTxDcmqkJblWSy4esjLmghvrfMZPQnaAtP1zd4=;
  b=VU/tyy5JJBE/cwyKdHKadJaeNcZEqH3cQvMT9CgEVveCsg3bU4KjTjPc
   VBk6DLrhQybXIm4kPMYLWb1pC2bze5lmuHJRMgv0PBm5JHxsIikTFB0/P
   wgqc8DmKu6CeZYi+S567PMQAzGFW5quWavp9DIKEronaE9M3T4uwSjhKM
   RcoMHSyEzylrVf/6JiPxEWMHH5FvGtOTNoMF773LbZ1R0MrkTEtWdiXWS
   7deqqPHFi0UeJJvAtHjlXb4Q5HDogCrjVTrbkdhCq6Gj4qeH1AoANtfBm
   nlPrQMyNsR2vRKIG7r6o+mskw9q0mJk2ZZzLt6CM4HG6FbXgGAJlclXV4
   g==;
X-CSE-ConnectionGUID: mtCew59VRUifTeOcsij5rA==
X-CSE-MsgGUID: 5Wiz/ccPRZ6u7D3KQFg+QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21361370"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21361370"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:20:37 -0700
X-CSE-ConnectionGUID: 4DV3NfKWTuaYiPKo9QHjfg==
X-CSE-MsgGUID: UrMGCU2kQgekRARRK9FvzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57073506"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 00:20:34 -0700
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
Subject: [iwl-next v3 6/8] ice: enable_rdma devlink param
Date: Thu,  8 Aug 2024 09:20:14 +0200
Message-ID: <20240808072016.10321-7-michal.swiatkowski@linux.intel.com>
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

Implement enable_rdma devlink parameter to allow user to turn RDMA
feature on and off.

It is useful when there is no enough interrupts and user doesn't need
RDMA feature.

Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  8 +++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index bdc22ea13e0f..530d443a8e14 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1544,6 +1544,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
+					    union devlink_param_value val,
+					    struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	bool new_state = val.vbool;
+
+	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 enum ice_param_id {
 	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
@@ -1559,6 +1572,8 @@ static const struct devlink_param ice_dvl_rdma_params[] = {
 			      ice_devlink_enable_iw_get,
 			      ice_devlink_enable_iw_set,
 			      ice_devlink_enable_iw_validate),
+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
+			      NULL, NULL, ice_devlink_enable_rdma_validate),
 };
 
 static const struct devlink_param ice_dvl_msix_params[] = {
@@ -1700,6 +1715,10 @@ int ice_devlink_register_params(struct ice_pf *pf)
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
 					value);
+	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	devl_param_driverinit_value_set(devlink,
+					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					value);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index fcde08334880..93a7b875f8aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -834,7 +834,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
  */
 bool ice_is_rdma_ena(struct ice_pf *pf)
 {
-	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
+	union devlink_param_value value;
+	int err;
+
+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
+					      &value);
+	return err ? test_bit(ICE_FLAG_RDMA_ENA, pf->flags) : value.vbool;
 }
 
 /**
-- 
2.42.0


