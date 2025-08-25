Return-Path: <netdev+bounces-216671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E83B34E65
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF551897C05
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91229C33F;
	Mon, 25 Aug 2025 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7RQFcfA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98C29B78D
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158628; cv=none; b=EN8XxR5BADV3btjjVjPY0zdzn0KqOjlwIHFUDkqCVCJbW/LYm5kX9oZ6QFklDgoni6B+vvk6lh6sTUyTO9oTaR8dqjLoSkpdz0D9Hc9VIZp3qxwrxo65ZZr0XQsZOqS7yCjUT7Lo3H23BUHWBF02eASGdI/eHQ9lo1m7FfnMaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158628; c=relaxed/simple;
	bh=WiviLeEN8nUPxwEQFQYbq525nJhkfcVvcl91PLOIGF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ2YQP8ygeJMvXsWLl9qa/QolpmLTqrNDdEIid0H8/b9YFHU5HZFwF+fCURNXyuSylPxe7SxXjF2ERmaFd3LsbceZYr7qxGnCEgFP231VZYua0gqYjPGSWuYVDqdfegx4qKT6N40ktMay2UnAw4pbvQ/9SDdBISBD3W6kU4pflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7RQFcfA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756158627; x=1787694627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiviLeEN8nUPxwEQFQYbq525nJhkfcVvcl91PLOIGF0=;
  b=G7RQFcfA/vgxthE7Z/ZjuqpVrM+Hl4R59I30bz00sVKajGJIwslyBu14
   zve6NKjtlN6EJYUE5LWSMLvhmk8tjkNYgaDZh+EaYYYTots8aCTf0IQsB
   J6rkgu3pk0Mq8Km/wgyD6/pKttxkBQbZv9JGxVx1P3xMvsVbY+0NGxY0t
   jMHgasvo2YcHU97b3yTzAILo8q2vpphTCa4UHZAk6cV2R4gjNhc/v4IqG
   jqlE/CCNliDxoNGuTD6EZJ+9zOyikraHm/GTd1kwoOPhnpBuesnG9bckg
   pfd6to+9ZGSoMCAQ3I2E8UliOJG/l9UZzJDPT2z4d0fkqu+95qd/Xg6zl
   A==;
X-CSE-ConnectionGUID: scEQCTeSQva7fp9JrIcFIw==
X-CSE-MsgGUID: lbD4X8j+QNSfQtV8bdKmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68651363"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68651363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:50:25 -0700
X-CSE-ConnectionGUID: Qpmzo79dROKfkbLIfhCJqw==
X-CSE-MsgGUID: uav4wS1WRTuq5z9LmdlDiQ==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 14:50:24 -0700
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net 1/5] ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset
Date: Mon, 25 Aug 2025 14:50:12 -0700
Message-ID: <20250825215019.3442873-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
References: <20250825215019.3442873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Issuing a reset when the driver is loaded without RDMA support, will
results in a crash as it attempts to remove RDMA's non-existent auxbus
device:
echo 1 > /sys/class/net/<if>/device/reset

BUG: kernel NULL pointer dereference, address: 0000000000000008
...
RIP: 0010:ice_unplug_aux_dev+0x29/0x70 [ice]
...
Call Trace:
<TASK>
ice_prepare_for_reset+0x77/0x260 [ice]
pci_dev_save_and_disable+0x2c/0x70
pci_reset_function+0x88/0x130
reset_store+0x5a/0xa0
kernfs_fop_write_iter+0x15e/0x210
vfs_write+0x273/0x520
ksys_write+0x6b/0xe0
do_syscall_64+0x79/0x3b0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

ice_unplug_aux_dev() checks pf->cdev_info->adev for NULL pointer, but
pf->cdev_info will also be NULL, leading to the deref in the trace above.

Introduce a flag to be set when the creation of the auxbus device is
successful, to avoid multiple NULL pointer checks in ice_unplug_aux_dev().

Fixes: c24a65b6a27c7 ("iidc/ice/irdma: Update IDC to support multiple consumers")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_idc.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2098f00b3cd3..8a8a01a4bb40 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -510,6 +510,7 @@ enum ice_pf_flags {
 	ICE_FLAG_LINK_LENIENT_MODE_ENA,
 	ICE_FLAG_PLUG_AUX_DEV,
 	ICE_FLAG_UNPLUG_AUX_DEV,
+	ICE_FLAG_AUX_DEV_CREATED,
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 6ab53e430f91..420d45c2558b 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -336,6 +336,7 @@ int ice_plug_aux_dev(struct ice_pf *pf)
 	mutex_lock(&pf->adev_mutex);
 	cdev->adev = adev;
 	mutex_unlock(&pf->adev_mutex);
+	set_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags);
 
 	return 0;
 }
@@ -347,15 +348,16 @@ void ice_unplug_aux_dev(struct ice_pf *pf)
 {
 	struct auxiliary_device *adev;
 
+	if (!test_and_clear_bit(ICE_FLAG_AUX_DEV_CREATED, pf->flags))
+		return;
+
 	mutex_lock(&pf->adev_mutex);
 	adev = pf->cdev_info->adev;
 	pf->cdev_info->adev = NULL;
 	mutex_unlock(&pf->adev_mutex);
 
-	if (adev) {
-		auxiliary_device_delete(adev);
-		auxiliary_device_uninit(adev);
-	}
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 /**
-- 
2.47.1


