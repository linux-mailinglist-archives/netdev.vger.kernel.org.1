Return-Path: <netdev+bounces-133363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD680995BBE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76365288EAA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C9B218D83;
	Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFPNIWce"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B22185BF
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430493; cv=none; b=n0N1ZKcEWVS9ToV8WPriAeMXvGbR3AM5e3G5N04AM4++pBgb/HZZdH69weZ13hsLoTWt4K7C1u2zqe0yBoMoT8soQHgrmFZm+/IxhXu1qkhwN0A3zbPNgE68X+l5ya5oZbzJK1/wowDhdMhKbIFnC6LC7XPZgzEYiHJuz3gKMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430493; c=relaxed/simple;
	bh=mtnu9mZgGqF1gAy9sORYjjSMTuPf3i2D04CL9vGdHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMNksKZISNJObFwmI2mn9sXUpPibekrGa8kJj137GVRCTBlY+aplNkIAjATiFqcojdpUfrtT/mwGfYXoTjHDA2ZnDM+s/H7RKUiGaNbp606OKrGtpHNN4lvwNXNWduZwEk18ZfX/+2lXNCxVCpwn+Tgqk1U9n1zp+C9RYSju8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFPNIWce; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430492; x=1759966492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtnu9mZgGqF1gAy9sORYjjSMTuPf3i2D04CL9vGdHaM=;
  b=bFPNIWceLImQXletbRwNjKCpBmqterURQg61awHBowyus6ufuiFhvTxo
   xBh9WH8rDQuTbjx3KU76WP8G15ZDl/VqXjaN7p+LbnJNFRqyNOR+awq9+
   ch++39BBLojiJdtvQxI0i39zbsPR8CTpItCqJGkxLzbWmxfTPvSxhFhph
   RRcM/rpfa2iRW/nBRKub/66wC3IK/nLGKfXvOQM1w1zT54qg3SWUSleri
   3153Jds4TlnFcfYxOPE+9CFve5C+OL0N6ZFiZpT4S0crt8n5N06B7kzap
   dRz4B6WGvVeTKAomqqEYQrWBatJ29F6kH14bmSwOKyZ6cLaVynjoGh4zw
   g==;
X-CSE-ConnectionGUID: hvxzdLjvSRetK2MsvK9VLg==
X-CSE-MsgGUID: 1wZ3KUBtSBeT2PkkX9rU0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779890"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779890"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:49 -0700
X-CSE-ConnectionGUID: PYUlNV2ORP+W/0HhGZ9HWw==
X-CSE-MsgGUID: Cr9YscXlSweNqiHLNj2RqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794194"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 06/12] ice: Use common error handling code in two functions
Date: Tue,  8 Oct 2024 16:34:32 -0700
Message-ID: <20241008233441.928802-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

Add jump targets so that a bit of exception handling can be better reused
at the end of two function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 74de7d8b17ac..a999fface272 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2857,10 +2857,8 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 
 	/* Write the increment time value to PHY and LAN */
 	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
-	if (err) {
-		ice_ptp_unlock(hw);
-		return err;
-	}
+	if (err)
+		goto err_unlock;
 
 	/* Write the initial Time value to PHY and LAN using the cached PHC
 	 * time before the reset and time difference between stopping and
@@ -2873,10 +2871,8 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 		ts = ktime_to_timespec64(ktime_get_real());
 	}
 	err = ice_ptp_write_init(pf, &ts);
-	if (err) {
-		ice_ptp_unlock(hw);
-		return err;
-	}
+	if (err)
+		goto err_unlock;
 
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -2900,6 +2896,10 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	ice_ptp_enable_all_extts(pf);
 
 	return 0;
+
+err_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }
 
 /**
@@ -3032,18 +3032,14 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 
 	/* Write the increment time value to PHY and LAN */
 	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
-	if (err) {
-		ice_ptp_unlock(hw);
-		goto err_exit;
-	}
+	if (err)
+		goto err_unlock;
 
 	ts = ktime_to_timespec64(ktime_get_real());
 	/* Write the initial Time value to PHY and LAN */
 	err = ice_ptp_write_init(pf, &ts);
-	if (err) {
-		ice_ptp_unlock(hw);
-		goto err_exit;
-	}
+	if (err)
+		goto err_unlock;
 
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -3063,6 +3059,10 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	pf->ptp.clock = NULL;
 err_exit:
 	return err;
+
+err_unlock:
+	ice_ptp_unlock(hw);
+	return err;
 }
 
 /**
-- 
2.42.0


