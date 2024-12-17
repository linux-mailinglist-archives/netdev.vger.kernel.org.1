Return-Path: <netdev+bounces-152738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58FB9F59E5
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C13A1893E16
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643001F9ED8;
	Tue, 17 Dec 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iN/3lFeb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9491E009D
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476246; cv=none; b=mhYbXX8eGPTrmjak/IGBOfkJk+ObpIRa2hYz4a2pOfKDVNa9nKpjFr1bJYJnmDrBB99DJk0UdI1Kz5Z/PLEHss07GlVBrr5pzNrh5lAaaYAv7iK5V1Hm7x4unzZdObWZqltT5DbfSxAmUTp/Cpiu2uuYyDEq49qeR2qtSJf5Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476246; c=relaxed/simple;
	bh=kvVxq7DhuqDtNAngRqw2v2RSj60oucL5TMdyr4Zy6cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXULrwjpeQooWuiDyH2PSazD5EjAnQy5w5RPGC495cnN8FhRUU9+L2w8rXA9R5GZd4pHGdKTRGmufG1JMLqSSzTZ/Opn8CpTOI+RY2QWToeyvsrl+0Pi9ZE2/ZqB+JO+mV/obRdtUZ+1SyNE0yh3fosogc+8ez984vT6k2cZny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iN/3lFeb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734476245; x=1766012245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kvVxq7DhuqDtNAngRqw2v2RSj60oucL5TMdyr4Zy6cs=;
  b=iN/3lFebWkIHO858waN37yqSBerabnQKJI/A/eN+NyBTvAbn4k2zoOdp
   xK15tNQkcTfOnpQBqSo3/lUACd0Q5mELoVNgq4KT/lviVQVHZ2Q8ld86p
   V3UXgtfp4Mk95oc907TWF985W+lruhHsOUzjna7km2Gb8HgYcbC45UJ22
   wGbqG3ooGoK7ayGZJLIVi/tpuezySyo6K3dynxzT5QWtZLeWLqr1kIy3j
   ybgfS/t05Eh1m4QmFwlYwWwEpAoamDRiaFlCSxaJYGKrr/Y1czY7RhHBA
   HPKqLlqdrz14Twl5s2OvOPlhISBgAbCCWvIjEUYlT9x3+qa9JeurYq8ao
   w==;
X-CSE-ConnectionGUID: HowEr8nARZmNGcvr9UDTLA==
X-CSE-MsgGUID: VNKak05OTxON29OyGK8Eyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35071998"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35071998"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 14:57:23 -0800
X-CSE-ConnectionGUID: 8NH9BEtVRTq/EdKxcjGQTA==
X-CSE-MsgGUID: dWyxbMdqTBmH/1IpXdf5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120916647"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Dec 2024 14:57:22 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	michal.kubiak@intel.com,
	madhu.chittim@intel.com,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 1/2] idpf: add support for SW triggered interrupts
Date: Tue, 17 Dec 2024 14:57:12 -0800
Message-ID: <20241217225715.4005644-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
References: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

SW triggered interrupts are guaranteed to fire after their timer
expires, unlike Tx and Rx interrupts which will only fire after the
timer expires _and_ a descriptor write back is available to be processed
by the driver.

Add the necessary fields, defines, and initializations to enable a SW
triggered interrupt in the vector's dyn_ctl register.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 8 +++++++-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 6c913a703df6..41e4bd49402a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -101,6 +101,9 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = PF_GLINT_DYN_CTL_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9c1fe84108ed..0f71a6f5557b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -354,6 +354,8 @@ struct idpf_vec_regs {
  * @dyn_ctl_itridx_m: Mask for ITR index
  * @dyn_ctl_intrvl_s: Register bit offset for ITR interval
  * @dyn_ctl_wb_on_itr_m: Mask for WB on ITR feature
+ * @dyn_ctl_sw_itridx_ena_m: Mask for SW ITR index
+ * @dyn_ctl_swint_trig_m: Mask for dyn_ctl SW triggered interrupt enable
  * @rx_itr: RX ITR register
  * @tx_itr: TX ITR register
  * @icr_ena: Interrupt cause register offset
@@ -367,6 +369,8 @@ struct idpf_intr_reg {
 	u32 dyn_ctl_itridx_m;
 	u32 dyn_ctl_intrvl_s;
 	u32 dyn_ctl_wb_on_itr_m;
+	u32 dyn_ctl_sw_itridx_ena_m;
+	u32 dyn_ctl_swint_trig_m;
 	void __iomem *rx_itr;
 	void __iomem *tx_itr;
 	void __iomem *icr_ena;
@@ -437,7 +441,7 @@ struct idpf_q_vector {
 	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 112,
+libeth_cacheline_set_assert(struct idpf_q_vector, 120,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
@@ -471,6 +475,8 @@ struct idpf_tx_queue_stats {
 #define IDPF_ITR_IS_DYNAMIC(itr_mode) (itr_mode)
 #define IDPF_ITR_TX_DEF		IDPF_ITR_20K
 #define IDPF_ITR_RX_DEF		IDPF_ITR_20K
+/* Index used for 'SW ITR' update in DYN_CTL register */
+#define IDPF_SW_ITR_UPDATE_IDX	2
 /* Index used for 'No ITR' update in DYN_CTL register */
 #define IDPF_NO_ITR_UPDATE_IDX	3
 #define IDPF_ITR_IDX_SPACING(spacing, dflt)	(spacing ? spacing : dflt)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index aad62e270ae4..aba828abcb17 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -101,6 +101,9 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
+		intr->dyn_ctl_swint_trig_m = VF_INT_DYN_CTLN_SWINT_TRIG_M;
+		intr->dyn_ctl_sw_itridx_ena_m =
+			VF_INT_DYN_CTLN_SW_ITR_INDX_ENA_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.47.1


