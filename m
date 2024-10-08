Return-Path: <netdev+bounces-133337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291D995B4A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6971F1C21F81
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F6218581;
	Tue,  8 Oct 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKEl1sFp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C245217329
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428474; cv=none; b=kt9FKkiF4yX4QyMAMcr6+THqlM2pHFGv9oPHBNX8Cdgq8jxoPby2ECQFwFGYk1vpUg31QUnq+MhfpVK/ntW1Xl4zFykTtuzgCU/n9GGhweGUEZMRS4TUz2SOq+SenN4CTNln6Qw3/ff7hIXmE8R4OIXCPVYRU2RrdNREGBJgys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428474; c=relaxed/simple;
	bh=JM3MhC6/VzjhaoZ5ftmwqde7tQ3kXbCVKZ/x6xxqlbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpbsUD5JfQuF25deJ8cEqMt7M+OTxX77kO0g+7xNzd4R4+Xaf7uQtK+JXpg6b7m0A6fR4g3QoCEy3dI4LnJrpwmELswdLUCOyvM/uId6gHfk0blIaSui8sc9GAwhGyZ8asfjZ9Hm+r624gmitH+dgX2Dn9QipZqkMNcH5fMm4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKEl1sFp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428473; x=1759964473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM3MhC6/VzjhaoZ5ftmwqde7tQ3kXbCVKZ/x6xxqlbE=;
  b=EKEl1sFpsXJpX6E05I+N9aAvGyX9DL2D0doXInHCRJgVB8M8M62ogEAN
   imZJu0sKbbHWVtlc8sr40TFi1clTCGgI9P4ZFIHh5/VcAPUjM3amoE+/7
   OHJY1jVJfEMcNLCf42BhGqitKY1UsUCGmpznj4718ntRsZ81hS1/WhWjX
   v9SCzOvxCF8+dpm8Bi4YubBOBgXsZ4w4mJHeBcAANf6zc8L+9MiX9m2nn
   gfmMfFZ/WTzQlLuJgoaCFwWXCKLzhr/kt/trXbaNuyO0r4c5pv4WILOPX
   c6kCIlpHk5ux6mqHeaIHwsoF9et9qUmYurHl8XhsAvrd4Lm5QZx9JawyO
   A==;
X-CSE-ConnectionGUID: twRPrW29Rc+SM9+r6Of8Aw==
X-CSE-MsgGUID: /YAjEzvGS4ybYbPCxOUglg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302425"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302425"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:10 -0700
X-CSE-ConnectionGUID: cf9vRFgwSF2twzTkp28EeA==
X-CSE-MsgGUID: u0lc6H2IQgCy7RqruT0+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787601"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 5/7] i40e: Fix macvlan leak by synchronizing access to mac_filter_hash
Date: Tue,  8 Oct 2024 16:00:43 -0700
Message-ID: <20241008230050.928245-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch addresses a macvlan leak issue in the i40e driver caused by
concurrent access to vsi->mac_filter_hash. The leak occurs when multiple
threads attempt to modify the mac_filter_hash simultaneously, leading to
inconsistent state and potential memory leaks.

To fix this, we now wrap the calls to i40e_del_mac_filter() and zeroing
vf->default_lan_addr.addr with spin_lock/unlock_bh(&vsi->mac_filter_hash_lock),
ensuring atomic operations and preventing concurrent access.

Additionally, we add lockdep_assert_held(&vsi->mac_filter_hash_lock) in
i40e_add_mac_filter() to help catch similar issues in the future.

Reproduction steps:
1. Spawn VFs and configure port vlan on them.
2. Trigger concurrent macvlan operations (e.g., adding and deleting
	portvlan and/or mac filters).
3. Observe the potential memory leak and inconsistent state in the
	mac_filter_hash.

This synchronization ensures the integrity of the mac_filter_hash and prevents
the described leak.

Fixes: fed0d9f13266 ("i40e: Fix VF's MAC Address change on VM")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 03205eb9f925..25295ae370b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1734,6 +1734,7 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 	struct hlist_node *h;
 	int bkt;
 
+	lockdep_assert_held(&vsi->mac_filter_hash_lock);
 	if (vsi->info.pvid)
 		return i40e_add_filter(vsi, macaddr,
 				       le16_to_cpu(vsi->info.pvid));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 662622f01e31..dfa785e39458 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2213,8 +2213,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		vfres->vsi_res[0].qset_handle
 					  = le16_to_cpu(vsi->info.qs_handle[0]);
 		if (!(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_USO) && !vf->pf_set_mac) {
+			spin_lock_bh(&vsi->mac_filter_hash_lock);
 			i40e_del_mac_filter(vsi, vf->default_lan_addr.addr);
 			eth_zero_addr(vf->default_lan_addr.addr);
+			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 		}
 		ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
 				vf->default_lan_addr.addr);
-- 
2.42.0


