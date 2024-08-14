Return-Path: <netdev+bounces-118594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F059522F6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FFC280290
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F31BF32C;
	Wed, 14 Aug 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Drb16wzP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72C1BF304
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665387; cv=none; b=bSdIZabFCYk5CZ3gbCP/fLa8sY8btanbV2waQWPXxrlm/+vCO4uiykig1ctpdHGxiCxPBznaIHwJpjrWPICsCQmjn31bDe3GsmsqgV/8kP6ZUfirjiDDsZGKJ6FXoxyaNNLrzHc7jV7b5YHd7mJoY8o0hcrD1ykwrsHIMWCjwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665387; c=relaxed/simple;
	bh=ce4Gm9sK8DtjolFBXVB0Ofy9mfw0ari2vWHuCBCGd8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJeh7zFHRWe40nM7bYpeY5cYuSynrnkH6MWrvyDmhOVWN2SuXxH8IhAN4bfwXNkjugWQpc3nqRcJ4yBsSbMzR6xDUJuZPpMwh8uUNfJHlatANKbzGkvhv0mMGl/t2TVx1JMXpUt6fi3gMiQsKPXHBeoF51B6ipqhBH8iDW8DlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Drb16wzP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723665386; x=1755201386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ce4Gm9sK8DtjolFBXVB0Ofy9mfw0ari2vWHuCBCGd8A=;
  b=Drb16wzPo0zYZU6j1tnu5Uzs3BKZX42Zvsi7tZ33Sf9NsaXtx+aUaA+M
   b5xpSxl0ktVe6JLYI/Dfdt5YVpLj357iCJB0QLLgEy0C9hmg2CkpKHKBK
   dHgjqDZQwf0s0eRT3l5rHEov7iswjt9H9JpC/JuWO38UBTm7KK87gE7E1
   s7+gGUc18NyrkvtnMZH0z35w8N/X72H7DxGQy64xNbVeYwAwLmfakz8UC
   ym6hY7YmelTLBsCrjtLux8qN0sRyTlrJV5QQVmgRMe6SoAUd1qauNsS25
   21s99ZOp3HxXF8wBSBWN7mIbYpO6BKj5eeasQD+ohrqORTz8xZ0SKkmVy
   w==;
X-CSE-ConnectionGUID: swBZkCS8QKadg5zspWlmkQ==
X-CSE-MsgGUID: DoJ7oIVXTfCNYJZ8M0JAVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33292511"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="33292511"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:56:26 -0700
X-CSE-ConnectionGUID: H6NyRvX/RMOBzSeG9vr2wQ==
X-CSE-MsgGUID: 3dRDiYg5SC6rRCksWYI5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59869708"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa008.jf.intel.com with ESMTP; 14 Aug 2024 12:56:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v5 2/5] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Wed, 14 Aug 2024 21:54:31 +0200
Message-ID: <20240814195434.72928-3-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
References: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
in the functions that do not use ctrl_pf directly.
Add the control PF pointer to struct ice_adapter
Rearrange fields in struct ice_adapter

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index 9d11014ec02f..eb7cac01c242 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,18 +8,21 @@
 #include <linux/refcount_types.h>
 
 struct pci_dev;
+struct ice_pf;
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @ctrl_pf: Control PF of the adapter
  */
 struct ice_adapter {
+	refcount_t refcount;
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 
-	refcount_t refcount;
+	struct ice_pf *ctrl_pf;
 };
 
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 31d1ab575ec2..f6c50063d374 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -57,6 +57,18 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
 	{  UFL2, { -1,  3 }},
 };
 
+static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
+{
+	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+}
+
+static __maybe_unused struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+
+	return !ctrl_pf ? NULL : &ctrl_pf->ptp;
+}
+
 /**
  * ice_ptp_find_pin_idx - Find pin index in ptp_pin_desc
  * @pf: Board private structure
-- 
2.43.0


