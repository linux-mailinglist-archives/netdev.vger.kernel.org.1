Return-Path: <netdev+bounces-102680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F69043DB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C73287454
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0379949;
	Tue, 11 Jun 2024 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF6oNd9i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A567404F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131371; cv=none; b=YevXHWj3xK9mOXnIzNNcT2E+5/O9OFKGcVaW2y2vNLAPXNLGQTjEh5jJrHcuDgvcyUpz9C6LxMqnIspRxZ7IqCKMWhbj7e0IN6PFSym7oCixtScL/c9rn4yNlWuyKwIZ7Y/PEdN3qj+ABOrSVt4qJyIGDjs8nK/HjFAZYGOkiio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131371; c=relaxed/simple;
	bh=Kzn4+5NYzf3vBoHKEY1YRsaK1lMRlsJAo/vlsKmp0SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnk1qL70q0NqeJL7BhSRNnQJE7+mBlrqe3fPVTyQhAlbups+lrCvWsNOWzZlkpNGBTs9lBeUKsm6utxzkjLLpM7RXHV56eS9U74tN64VIdtGt4/8Dhqe0V2KIhRH+e7kDG719wq1JfhkVhPOkqCM+vXCb/Fs4PZ5YLumOT4Sajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF6oNd9i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718131370; x=1749667370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kzn4+5NYzf3vBoHKEY1YRsaK1lMRlsJAo/vlsKmp0SY=;
  b=KF6oNd9iSMaLTVC9iWQwJWbY6nxBczt69m3siW4EypKQS6gc56aGXhAB
   k0/U/mC45gvTqSdMq2xBveFvMUjZmViOBH7GTzrEepfKROHJpxzPM9g/T
   m51Jdj4Ejl734jxjKhX0dWmQzhGlWNp5dzMHSl0N74ZweNASJUGhjFsG/
   aHnyixB9uup9BhY7qCU/+3Dy7AcGv6uoRHC7J2zoUJ/x7Huik3o9x4qTx
   MNN8SAHWIEP/m54XEMKAXpyfrQGg+zULh/Imc1PC2QBUgroMmDzBbI9/C
   rTbVtjPPMDESqJuw9fM06cAdD9poV0BFJREK7r18AlDQBp/hplz/SVjTa
   w==;
X-CSE-ConnectionGUID: 3u1uh3MoT3Kfe30mjqKhIQ==
X-CSE-MsgGUID: hB7tDy+JTQeg/sQaHozWCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12025555"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12025555"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:42:48 -0700
X-CSE-ConnectionGUID: Jg8LAJs8RQ6ZeM6Loq/H/g==
X-CSE-MsgGUID: TEOL35M3Sg+UAYRrg9UuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39592507"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 11:42:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 4/4] ice: implement AQ download pkg retry
Date: Tue, 11 Jun 2024 11:42:38 -0700
Message-ID: <20240611184239.1518418-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
References: <20240611184239.1518418-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
to FW issue. Fix this by retrying five times before moving to
Safe Mode. Sleep for 20 ms before retrying. This was tested with the
4.40 firmware.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index ce5034ed2b24..f182179529b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 
 	for (i = 0; i < count; i++) {
 		bool last = false;
+		int try_cnt = 0;
 		int status;
 
 		bh = (struct ice_buf_hdr *)(bufs + start + i);
@@ -1346,8 +1347,26 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 		if (indicate_last)
 			last = ice_is_last_download_buffer(bh, i, count);
 
-		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
-					     &offset, &info, NULL);
+		while (1) {
+			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
+						     last, &offset, &info,
+						     NULL);
+			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
+			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
+				break;
+
+			try_cnt++;
+
+			if (try_cnt == 5)
+				break;
+
+			msleep(20);
+		}
+
+		if (try_cnt)
+			dev_dbg(ice_hw_to_dev(hw),
+				"ice_aq_download_pkg number of retries: %d\n",
+				try_cnt);
 
 		/* Save AQ status from download package */
 		if (status) {
-- 
2.41.0


