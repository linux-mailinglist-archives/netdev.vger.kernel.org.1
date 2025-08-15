Return-Path: <netdev+bounces-214199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D50B28750
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41793A25A1D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5112C0F79;
	Fri, 15 Aug 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTDQMgHK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA62BE03F
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290534; cv=none; b=UO+Xrc29jK2OZTGMPQ+xdi2j2UDHUQu9/9LafwEbCXyCQ8lvK6VM0B+2PH4LA3YlUGze6+UnbDgX95MhZ7aXYPBXU4KAKDoEdRijtLPT8Ul+G5nxtpXHoS7CAGb7dB1suHlSrgIHZmi2+7SxozM2PE5N/SHa02lfPHz8G9KiZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290534; c=relaxed/simple;
	bh=6F9TlIeMjNBAgf3BO3eCjOcPgLbSWc016FuZZUFGoI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYUL9mYEA5fZchQ9R6ljo2c7UexjVPyg2PO110pZVimJbenCy/XN9owMqWHc5iBRnLHiQ6PFE8lj3ovj6u+dpZYc/3PqYqFuuUENySbvF+Aa5YbqWj6Qxzw3OfFg1W4P/XGG/dlhZZOWcDn+CGFenHjKGvOVNX602gAvc8+NGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTDQMgHK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290533; x=1786826533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6F9TlIeMjNBAgf3BO3eCjOcPgLbSWc016FuZZUFGoI0=;
  b=kTDQMgHKqFRx5muVHiK2fKpJYMkfwkAxXgoFM9bQT0jLr05RheOiic+T
   HBIJc0neUliXbTskpUErFUcvf1P2kYVt6kLAlcMz1l5iTPDdEJnLk8mGt
   aKvBFYeUNeYTrnEWTSUyjBw63d/s9jCuUb+194RCyWufnVB5/RwjZmgeZ
   82HaW7YTptu3gkRwXNXr7anhIqZ3EaOkLUcQZ7hcfl1Sa/rbCXQITeH0y
   M/MvKyxoCtwud7XUE+7SgCrijQMHp7IJLoVYKgppljQB6RGKrsOw/v0Q9
   QJsfxXo4Z5aOPmnxs9WtQpdrD6PJ4jm7uEF15meFiWYKQe6sPWIJqtD4+
   w==;
X-CSE-ConnectionGUID: 3WUPo+jgSGWiujZHDTRPjw==
X-CSE-MsgGUID: P2cryNPWTHaFzdU8+s/bkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320299"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320299"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:10 -0700
X-CSE-ConnectionGUID: nD4ZWEVnSoKO9uprhC+zYg==
X-CSE-MsgGUID: 7aIzcnYoR6qsCcuJirv0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084316"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	tatyana.e.nikolova@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 2/6] ice: fix possible leak in ice_plug_aux_dev() error path
Date: Fri, 15 Aug 2025 13:41:58 -0700
Message-ID: <20250815204205.1407768-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Fix a memory leak in the error path where kfree(iadev) was not called
following an error in auxiliary_device_add().

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 420d45c2558b..8c4a3dc22a7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -322,16 +322,12 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 		"roce" : "iwarp";
 
 	ret = auxiliary_device_init(adev);
-	if (ret) {
-		kfree(iadev);
-		return ret;
-	}
+	if (ret)
+		goto free_iadev;
 
 	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
+	if (ret)
+		goto aux_dev_uninit;
 
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
@@ -339,6 +335,13 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(adev);
+free_iadev:
+	kfree(iadev);
+
+	return ret;
 }
 
 /* ice_unplug_aux_dev - unregister and free AUX device
-- 
2.47.1


