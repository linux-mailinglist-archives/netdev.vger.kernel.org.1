Return-Path: <netdev+bounces-172207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B225A50DC4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D5B3B0026
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3025C6F8;
	Wed,  5 Mar 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdKFtwFp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F1257AC8
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210565; cv=none; b=qGRr6dXXngBPA+WzqXsGhA9u65k4nQ+Ucv0qeGV0jMsJxMS9EE/YPdol1J8Z2+a8qQD6iols2n6Dw2TYlQ+xeA8fmndHq1aIqaa9WrKdz1qnXr66qBgnYg0V4RbUuQ+whc3ysNH/2VOaZ2iMf+iA8P6yePkptPx6CM8q7b+rWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210565; c=relaxed/simple;
	bh=xZF9mGXmB44HOH7lioiVMEtFdGRrl8k8zjhnuToNjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNS/FgsIxu7Zik7bZeQOKI/6OvCw2fL2KwALTicSRanIuxeTqCj0W4LiVXZKWUYrWmW7RN53PSVob4mrjPo0ORqSQ6XglET/jMEhgju7fQ1FHHCmk0hD55jyIADuVHMQnO4ZVp3aV8VpeZQTatKb+BLX5vKjmIIlHirvpWnVgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdKFtwFp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741210563; x=1772746563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZF9mGXmB44HOH7lioiVMEtFdGRrl8k8zjhnuToNjeY=;
  b=gdKFtwFpqTGfowsAujvOUP749vlbWlrZRb3+aR45Mp5TsPkjg7itll52
   5b6X0MVH77W++EfQbxDMhMm0qsKD7v1ngCioZNPO52G2w7SrqsSqwvIbJ
   fbVTAR/11NSaEYNfi7lWyQWx6lhD18oMUzDzJTG/cpsR1J8pifKmwScWr
   GwudlykpvjI6Ck/s20bqwYpuAVNwX2AsiVJ+7Is8fAhabuhVNqcGgLgUm
   HyQnvXWaJ1dX2buGJX2tz1iGC3UR/A/QtNzVdOhFpUFfVAEbJY8h3qwju
   twsXsRGelR0CUd6QkPPmmEAgjIQkLQXKHcTgrBwRHXDjTyViI82ZMGrXE
   A==;
X-CSE-ConnectionGUID: YrktvPoCSd+fYFKrXcUXKg==
X-CSE-MsgGUID: g0ekssfgQIWIE6HILmgBRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53606493"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53606493"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:35:58 -0800
X-CSE-ConnectionGUID: WqN3wkqxQJOoI/hqvNLBnA==
X-CSE-MsgGUID: tXylPksPR9KNFoJRv06QRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123828489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 13:35:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	jiri@resnulli.us,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 4/4] ice: register devlink prior to creating health reporters
Date: Wed,  5 Mar 2025 13:35:46 -0800
Message-ID: <20250305213549.1514274-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
References: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice_health_init() was introduced in the commit 2a82874a3b7b ("ice: add
Tx hang devlink health reporter"). The call to it should have been put
after ice_devlink_register(). It went unnoticed until next reporter by
Konrad, which receives events from FW. FW is reporting all events, also
from prior driver load, and thus it is not unlikely to have something
at the very beginning. And that results in a splat:
[   24.455950]  ? devlink_recover_notify.constprop.0+0x198/0x1b0
[   24.455973]  devlink_health_report+0x5d/0x2a0
[   24.455976]  ? __pfx_ice_health_status_lookup_compare+0x10/0x10 [ice]
[   24.456044]  ice_process_health_status_event+0x1b7/0x200 [ice]

Do the analogous thing for deinit patch.

Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c3a0fb97c5ee..e13bd5a6cb6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5065,16 +5065,16 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
-	ice_health_init(pf);
 	ice_devlink_register(pf);
+	ice_health_init(pf);
 
 	return 0;
 }
 
 static void ice_deinit_devlink(struct ice_pf *pf)
 {
-	ice_devlink_unregister(pf);
 	ice_health_deinit(pf);
+	ice_devlink_unregister(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_devlink_unregister_params(pf);
 }
-- 
2.47.1


