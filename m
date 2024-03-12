Return-Path: <netdev+bounces-79396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1609878F9E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD32D2822D5
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC069972;
	Tue, 12 Mar 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko3yvNCx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE069D01
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231813; cv=none; b=p6BVaO77ScVkNFHMxjBCgdwstuxhNrV3rMsECHV7dv1H6qxeMhbJWOcgUBwSlIxVMW8BP9se9zP2cUPO2UHfJlG2Dmc2pU8wlP4XxrP0aZXpcvPpDA92jWtnfJQp+bmSV6lJCfRcugnbobLXg9VDxJDrkR4S4znPaNaD94uLlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231813; c=relaxed/simple;
	bh=N0agS2sa4w8oMJCmaEjfN/D67p/n5OOOkOTO2lNG4k8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MgA3T4fKFKG7V8FZVWXYD0zy0Y9s+vH2+Zp98FJKXBlJOFbvcx+XCVQNYp759UO16VPVVm6yZP+E7snzfxsBVPM08zS0FF/Tee+1mzxIdCc2buLNGLWfqcJKXfbGeaXO6HwEJlniFVnUbdhsBGeQhdvZqg7DF9d9thzFL02rF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ko3yvNCx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710231812; x=1741767812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N0agS2sa4w8oMJCmaEjfN/D67p/n5OOOkOTO2lNG4k8=;
  b=ko3yvNCxUtuPkS2X3evqfmjGJKs77BdKnEn3aTTA+GtbbTrfegNqF6qb
   nCTyHEUFaIz+OG1YdA5a5HNMEruAG4gXCG4ob0tXnpIneVnZpv8HpVDd6
   CC7ComUsbcF3TXb6YaaDxw/6EBNgvkJG1EOB1CJhNB/X5vbi6CUTVMEf9
   jWwDAm+/5TBYD96XKLZ37y01dTLj7e53/6JkmG0bHZMJgSAXFtsUew4L7
   J/eZ9MfQf9Bh4KiZRI3tEQHKoCiC1hjwxXXjtYGZKE70vMhgQu737rQ8q
   beIxWd3W7k5U4Z5Ak/zzQBzMnkLSl0mLLyCnz8SYU2QQI1IVFzdZZnY1M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30367339"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="30367339"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16035164"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2024 01:23:30 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net] i40e: fix i40e_count_filters() to count only active/new filters
Date: Tue, 12 Mar 2024 09:13:43 +0100
Message-Id: <20240312081343.24311-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix counter to be bumped only for new or active filters.

Fixes: 621650cabee5 ("i40e: Refactoring VF MAC filters counting to make more reliable")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89a3401..6010a49 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1257,8 +1257,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 	int bkt;
 	int cnt = 0;
 
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
-		++cnt;
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_ACTIVE)
+			++cnt;
+	}
 
 	return cnt;
 }
-- 
2.25.1


