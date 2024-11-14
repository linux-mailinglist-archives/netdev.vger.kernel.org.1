Return-Path: <netdev+bounces-144880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D19C89C4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923992834AE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3071F8929;
	Thu, 14 Nov 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ+QZaDh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09471F80CC
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586850; cv=none; b=aKtY/w7xm5FeAFBh+ic+3TX+Sq0T1h+7Ye9Vj+1EgfNoP+LR0ov7HfTOYDtBqQNYUqGilSZ7hm9WU9oPhroc5O/fk4VIXAWhblmoTOx3hgNoCo3lOu+xbnlm8SJ7CJhPoH/Z0NTzsWXpNLvPezKqAjVRNsY3NjZqplhrDAGpD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586850; c=relaxed/simple;
	bh=uSfGMC7MpvLcsmrYMIC/KjTjHJL8kyUCy9g8i5xca0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8y8k5KOMI6WM+LOlC/TkTTdd4VE34ji8ptDnb8sRDqM5gohlrolR+/sU+sS50M3Fm/XCwi2cARPgVbMoHqVb76oDx/QsYFZAW1Byz1/Ge0kAVEVvpJf7tN4/Ug6wHlIdKoqwduFMh8u7TXLSJBNuaD1IfABYojL5ko9ekug5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ+QZaDh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731586849; x=1763122849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSfGMC7MpvLcsmrYMIC/KjTjHJL8kyUCy9g8i5xca0k=;
  b=IJ+QZaDhDbH+xWk6gwfSaTuOYIk0+Z7nWj/PUq+JrYpBRgHWnYBhEEgA
   mXZq8QLo7vLUxhmdC+jwEqAJUhFXcjS8GjI3wb89QWsqsEJoUMPai9L/C
   t/hb03I4fpmO7oFe1OWfH7HkUyII0+/T+HfVglk3PqJbyTg96FzqevSim
   AgK6is9GbTLeBXKqjHKNmEnbvaZpDKZVTdk3TjCj4c32krjHS+cqoqozA
   WmnCAQpPn+734Lbv1gggM6x+Z/7O6ahuLSQPYWeolocGphqzwG32S6exE
   sMK3jDk69jb1l2pnskyO8h1G0G9/jcHCPDtRJsesEk1h1FiVny6Qj/cLI
   g==;
X-CSE-ConnectionGUID: i764wbeTTQKN5EYCepRU/A==
X-CSE-MsgGUID: Scf+ZLmRTSGeBCAg1kyEJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="56916945"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="56916945"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:20:49 -0800
X-CSE-ConnectionGUID: 6HqYvtMKS2eGunEJVM2dAw==
X-CSE-MsgGUID: 1TxixY83S56hDbZ4rbY69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93136248"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 14 Nov 2024 04:20:44 -0800
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
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	rafal.romanowski@intel.com
Subject: [PATCH 8/8] ice: init flow director before RDMA
Date: Thu, 14 Nov 2024 13:18:40 +0100
Message-ID: <20241114122009.97416-9-michal.swiatkowski@linux.intel.com>
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


