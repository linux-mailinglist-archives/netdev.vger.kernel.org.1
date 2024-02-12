Return-Path: <netdev+bounces-71081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BA851F3F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B23B20DE0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3254CB46;
	Mon, 12 Feb 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMynDJkV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA14C615
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772332; cv=none; b=RD0ikrMlFHvB7DgEkzlXvlKhpI2eR4DqCzjhqBCNLPMeIqlTHLdECrFp3WSUHerXFs8WEkEnWzRhWBNC9i9CsCxc5gRbJo15QDfVyfK8oFgQSWb7m+L2tTYDeub7O/TDNucbNB6rnailjPKmAUT7EPVittXBQ+ifxH4x8uQlx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772332; c=relaxed/simple;
	bh=JbIpaTuIX1/cu9KcpuComWJuoOVQqnBKBf2ryjECVyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3CHAdX3ADoo7qRrnkw4UCFQGiJ0wCglOIwgKK5MrxvHuEmVwbQhxwIGKirCxt0VCbpqrEfpnlN0ApllRrgJS3J0R5Ik2+2V5H/k3jOpcYHs8oI6IuoYJN+XjJuDZOaxgbYQxNJACQ/dpeH0CAbZ4er+eOh6klP78ERikQJAujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMynDJkV; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772330; x=1739308330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbIpaTuIX1/cu9KcpuComWJuoOVQqnBKBf2ryjECVyA=;
  b=MMynDJkVZZ9AEqTosZso9uqxp2xnAykPLHCTeq4hdw5XYqlKOWHbeOwa
   p9Km45SRLiOfUnH9+zdYXg4FcJpebo3MQJk+C2hibNdelbiRnmadlgz8s
   jmDhvOto7Ecx2mEpPmI5eRoeVViVuYfKJjn5iBrH8W6+XP5/v5Oi1czsa
   doY1A5f1OI1KUsG/RCD5uXy7RwtrOEUFi34rz+7nygSgxAE0e8XA5Y+WS
   rrSjB53DPtPPj1fNDdETrK2H5TjuAvnr7XdPprKevfuNSPKxFCtTZjakz
   aPr0wYcaoBtodnPYM8rXhH19BdmBimbpkjftNIn5Jxmufdgq4jUz0hhcq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910907"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910907"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335611"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Jan Glaza <jan.glaza@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/5] ice: introduce new E825C devices family
Date: Mon, 12 Feb 2024 13:11:55 -0800
Message-ID: <20240212211202.1051990-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Introduce new Intel Ethernet E825C family devices.
Add new PCI device IDs which are going to be supported by the
driver:
- 579C: Intel(R) Ethernet Connection E825-C for backplane
- 579D: Intel(R) Ethernet Connection E825-C for QSFP
- 579E: Intel(R) Ethernet Connection E825-C for SFP
- 579F: Intel(R) Ethernet Connection E825-C for SGMII

Add helper function ice_is_e825c() to verify if the running device
belongs to E825C family.

Co-developed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_devids.h |  8 ++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  4 ++++
 4 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 10c32cd80fff..cc8c9f2b72f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -240,6 +240,25 @@ bool ice_is_e823(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_is_e825c - Check if a device is E825C family device
+ * @hw: pointer to the hardware structure
+ *
+ * Return: true if the device is E825-C based, false if not.
+ */
+bool ice_is_e825c(struct ice_hw *hw)
+{
+	switch (hw->device_id) {
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 3e933f75e948..42d45a73359c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -251,6 +251,7 @@ ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
 bool ice_is_e810t(struct ice_hw *hw);
 bool ice_is_e823(struct ice_hw *hw);
+bool ice_is_e825c(struct ice_hw *hw);
 int
 ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 		     struct ice_aqc_txsched_elem_data *buf);
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index a2d384dbfc76..9dfae9bce758 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -71,5 +71,13 @@
 #define ICE_DEV_ID_E822L_10G_BASE_T	0x1899
 /* Intel(R) Ethernet Connection E822-L 1GbE */
 #define ICE_DEV_ID_E822L_SGMII		0x189A
+/* Intel(R) Ethernet Connection E825-C for backplane */
+#define ICE_DEV_ID_E825C_BACKPLANE	0x579c
+/* Intel(R) Ethernet Connection E825-C for QSFP */
+#define ICE_DEV_ID_E825C_QSFP		0x579d
+/* Intel(R) Ethernet Connection E825-C for SFP */
+#define ICE_DEV_ID_E825C_SFP		0x579e
+/* Intel(R) Ethernet Connection E825-C 1GbE */
+#define ICE_DEV_ID_E825C_SGMII		0x579f
 
 #endif /* _ICE_DEVIDS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2b7960824bc3..b3c24e40ccb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5752,6 +5752,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SGMII), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
-- 
2.41.0


