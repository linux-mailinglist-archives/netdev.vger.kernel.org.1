Return-Path: <netdev+bounces-131035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444998C6A2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5425283CCC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E31CEEAE;
	Tue,  1 Oct 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLLqVk98"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE161CEE8C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813841; cv=none; b=Zc0+rf9ZIKtaZSdW/kp6uVp6niaiWYHgvCRT3bZ9LCAJSpSyBsI/1mcyc1E8Uy4PobEGalJ97dNgID6no0+P/kjD9+86lS5feIUf04ENXekuBtaC7O/gknQFs4CL9T0ehseKdxHVFymK6wte0xyt+5pYkk6aDoVlR71doEvXTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813841; c=relaxed/simple;
	bh=3t5NRxutDnM45uytOKMhCUn9Omf8jTSUeeyO4WfV5rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMZTLSo+5QpBNQdlYdfKm7ZRpkOD/6GfmBfViB4ELfQKB9leIel6hZ8Dc4dXKF1dSyNsJg1xuOz8jcZx7Iu1FNdTMSkwFXPVYoK+NBpAiI8b0XGVBg+9paiczZtC3NAXQr4TlDh/CRSrkksi66aW/DwoYL7wWLIIGYhgSCRryAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLLqVk98; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727813840; x=1759349840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3t5NRxutDnM45uytOKMhCUn9Omf8jTSUeeyO4WfV5rI=;
  b=BLLqVk98cKMLH6RAlTMaa8Avd39z2MCEz7SXK1ZEb2fojpo24advei7p
   Brm8+YygTsGgM+92sE6nO0IM0vPUXhgeWTz1VSgLEbDkdTbA3wpuGjHKD
   NNjrki3kaaAMJdSgjHU0d+2og+Kd6Cq61c4E1kyTv4GK9iQhP6ojVsTU3
   qoEEaXP7gjNtMdCmIeDr162Rkb6EUo8Cv3sGdBa8CWY0x1LCDqN1FQwCZ
   Ml08BtHfRFHOSza2VaEF/fYByfveNjVqK9SH1wwwhssEk6qCfJjrVxphg
   +sv6/i0vodHlEAD1x78wiIidT/6I/ZprYQcBhfmwmxal7WoEf9AWDa3yu
   g==;
X-CSE-ConnectionGUID: 3iaJzYo5Ql2g2ta9WszTcw==
X-CSE-MsgGUID: +2q6K5feSoKRW1Xh7k7xGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27063106"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27063106"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 13:17:15 -0700
X-CSE-ConnectionGUID: wYL/VNEvRBm9Hth9PQ/u8Q==
X-CSE-MsgGUID: A5cqNJyfQ2KNv2HbMg3EmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73761876"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Oct 2024 13:17:15 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 09/12] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
Date: Tue,  1 Oct 2024 13:16:56 -0700
Message-ID: <20241001201702.3252954-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
in the functions that do not use ctrl_pf directly.
Add the control PF pointer to struct ice_adapter
Rearrange fields in struct ice_adapter

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index d3cd7e663d38..e5c5bd53bfff 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -57,6 +57,18 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e810_sma[] = {
 	{  UFL2, {  3, -1 }},
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
2.42.0


