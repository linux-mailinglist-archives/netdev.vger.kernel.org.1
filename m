Return-Path: <netdev+bounces-208222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACDAB0AA61
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DE85A4F03
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4D2E8E07;
	Fri, 18 Jul 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAqQGT/g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A92E8DED
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864689; cv=none; b=NzuIkSCIPN1O0mH/i4kG5sqSfVyMTzELyCMSzol5jeiZ/EwNfLcGqNbJrxSuas3Jl6DgmJSTSCPgj9Vijw91He+4kfxcI1RnKNDM92xTFnri35afVRMYffic/3NXRiFWqEjdMfAZO6iwHWK+qFKEGCEFwv10oUYGPjcE8V8t5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864689; c=relaxed/simple;
	bh=bokqwTUgy2D67P8yW4GJ8SKvXKa3jgPlrMsGdG/k1bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJmO7qm3L33b1g6wSi1K7AE5t+V4cl9kAVmsSVLuyLl0zMClCuAXQFBgjKGzf0y9ADNFche+/BKRni086bejodmXLsKkmW9WuRqNF9h1lHmUOH+JbCRZc4uK+4mkljEA45AGELp8FZZHG4smMSNfM3cY1LEqXRDpfNF7QidkvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAqQGT/g; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864687; x=1784400687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bokqwTUgy2D67P8yW4GJ8SKvXKa3jgPlrMsGdG/k1bE=;
  b=HAqQGT/gtj2zRzG6TfDdbraVBUFUU0BdafvciZ8bPMrS1kaiUjlsthfZ
   LIP+Kx0fvT1SWLaPErtOvPpj9OCZUwfOpg/wVI3+FzuORkNHLqDSx0eO0
   hNquQtG93TVJzTRw+PrPmSbeHrhNsc3Y5fJ99iyYyrw0u9ClD+J1eAZOH
   ChV3tniHyC2Jr+k3dtCBRt3609EI2fc6oBOpw/JK7QTTgrWGRGUgyeJxT
   gNu2nrYfjl8NMwsESpyJM70Z9maobLLp729qUcgqJaA1NrC5rnjhnoZ0E
   UvPLbsokK2P+NC34+7Q9lEEc1E6hfvKfZkzFDbkuVuFDmPwiCxTBceJfg
   A==;
X-CSE-ConnectionGUID: 2RELeuhwQ6+4AHGOXn6/Cg==
X-CSE-MsgGUID: 3bijNPKQT2+puqevLbXhDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320572"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:24 -0700
X-CSE-ConnectionGUID: sQ2wcDJrTKuYjkdCM3us2g==
X-CSE-MsgGUID: B0oqxBCoTauKa5KwqGlhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506886"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 04/13] idpf: add cross timestamping
Date: Fri, 18 Jul 2025 11:51:05 -0700
Message-ID: <20250718185118.2042772-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Add cross timestamp support through virtchnl mailbox messages and directly,
through PCIe BAR registers. Cross timestamping assumes that both system
time and device clock time values are cached simultaneously, what is
triggered by HW. Feature is enabled for both ARM and x86 archs.

Signed-off-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 136 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  17 +++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  55 ++++++-
 3 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 4f8725c85332..ee21f2ff0cad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -42,6 +42,13 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 							   direct,
 							   mailbox);
 
+	/* Get the cross timestamp */
+	direct = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB;
+	ptp->get_cross_tstamp_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
 	/* Set the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
 	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
@@ -171,6 +178,127 @@ static int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER) || IS_ENABLED(CONFIG_X86)
+/**
+ * idpf_ptp_get_sync_device_time_direct - Get the cross time stamp values
+ *					  directly
+ * @adapter: Driver specific private structure
+ * @dev_time: 64bit main timer value
+ * @sys_time: 64bit system time value
+ */
+static void idpf_ptp_get_sync_device_time_direct(struct idpf_adapter *adapter,
+						 u64 *dev_time, u64 *sys_time)
+{
+	u32 dev_time_lo, dev_time_hi, sys_time_lo, sys_time_hi;
+	struct idpf_ptp *ptp = adapter->ptp;
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	idpf_ptp_enable_shtime(adapter);
+
+	dev_time_lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
+	dev_time_hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	sys_time_lo = readl(ptp->dev_clk_regs.sys_time_ns_l);
+	sys_time_hi = readl(ptp->dev_clk_regs.sys_time_ns_h);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+
+	*dev_time = (u64)dev_time_hi << 32 | dev_time_lo;
+	*sys_time = (u64)sys_time_hi << 32 | sys_time_lo;
+}
+
+/**
+ * idpf_ptp_get_sync_device_time_mailbox - Get the cross time stamp values
+ *					   through mailbox
+ * @adapter: Driver specific private structure
+ * @dev_time: 64bit main timer value expressed in nanoseconds
+ * @sys_time: 64bit system time value expressed in nanoseconds
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_get_sync_device_time_mailbox(struct idpf_adapter *adapter,
+						 u64 *dev_time, u64 *sys_time)
+{
+	struct idpf_ptp_dev_timers cross_time;
+	int err;
+
+	err = idpf_ptp_get_cross_time(adapter, &cross_time);
+	if (err)
+		return err;
+
+	*dev_time = cross_time.dev_clk_time_ns;
+	*sys_time = cross_time.sys_time_ns;
+
+	return err;
+}
+
+/**
+ * idpf_ptp_get_sync_device_time - Get the cross time stamp info
+ * @device: Current device time
+ * @system: System counter value read synchronously with device time
+ * @ctx: Context provided by timekeeping code
+ *
+ * The device and the system clocks time read simultaneously.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_get_sync_device_time(ktime_t *device,
+					 struct system_counterval_t *system,
+					 void *ctx)
+{
+	struct idpf_adapter *adapter = ctx;
+	u64 ns_time_dev, ns_time_sys;
+	int err;
+
+	switch (adapter->ptp->get_cross_tstamp_access) {
+	case IDPF_PTP_NONE:
+		return -EOPNOTSUPP;
+	case IDPF_PTP_DIRECT:
+		idpf_ptp_get_sync_device_time_direct(adapter, &ns_time_dev,
+						     &ns_time_sys);
+		break;
+	case IDPF_PTP_MAILBOX:
+		err = idpf_ptp_get_sync_device_time_mailbox(adapter,
+							    &ns_time_dev,
+							    &ns_time_sys);
+		if (err)
+			return err;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*device = ns_to_ktime(ns_time_dev);
+
+	system->cs_id = IS_ENABLED(CONFIG_X86) ? CSID_X86_ART
+					       : CSID_ARM_ARCH_COUNTER;
+	system->cycles = ns_time_sys;
+	system->use_nsecs = true;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_get_crosststamp - Capture a device cross timestamp
+ * @info: the driver's PTP info structure
+ * @cts: The memory to fill the cross timestamp info
+ *
+ * Capture a cross timestamp between the system time and the device PTP hardware
+ * clock.
+ *
+ * Return: cross timestamp value on success, -errno on failure.
+ */
+static int idpf_ptp_get_crosststamp(struct ptp_clock_info *info,
+				    struct system_device_crosststamp *cts)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+
+	return get_device_system_crosststamp(idpf_ptp_get_sync_device_time,
+					     adapter, NULL, cts);
+}
+#endif /* CONFIG_ARM_ARCH_TIMER || CONFIG_X86 */
+
 /**
  * idpf_ptp_gettimex64 - Get the time of the clock
  * @info: the driver's PTP info structure
@@ -661,6 +789,14 @@ static void idpf_ptp_set_caps(const struct idpf_adapter *adapter)
 	info->verify = idpf_ptp_verify_pin;
 	info->enable = idpf_ptp_gpio_enable;
 	info->do_aux_work = idpf_ptp_do_aux_work;
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER)
+	info->getcrosststamp = idpf_ptp_get_crosststamp;
+#elif IS_ENABLED(CONFIG_X86)
+	if (pcie_ptm_enabled(adapter->pdev) &&
+	    boot_cpu_has(X86_FEATURE_ART) &&
+	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
+		info->getcrosststamp = idpf_ptp_get_crosststamp;
+#endif /* CONFIG_ARM_ARCH_TIMER */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index a876749d6116..785da03e4cf5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -21,6 +21,8 @@ struct idpf_ptp_cmd {
  * @dev_clk_ns_h: high part of the device clock register
  * @phy_clk_ns_l: low part of the PHY clock register
  * @phy_clk_ns_h: high part of the PHY clock register
+ * @sys_time_ns_l: low part of the system time register
+ * @sys_time_ns_h: high part of the system time register
  * @incval_l: low part of the increment value register
  * @incval_h: high part of the increment value register
  * @shadj_l: low part of the shadow adjust register
@@ -42,6 +44,10 @@ struct idpf_ptp_dev_clk_regs {
 	void __iomem *phy_clk_ns_l;
 	void __iomem *phy_clk_ns_h;
 
+	/* System time */
+	void __iomem *sys_time_ns_l;
+	void __iomem *sys_time_ns_h;
+
 	/* Main timer adjustments */
 	void __iomem *incval_l;
 	void __iomem *incval_h;
@@ -162,6 +168,7 @@ struct idpf_ptp_vport_tx_tstamp_caps {
  * @dev_clk_regs: the set of registers to access the device clock
  * @caps: PTP capabilities negotiated with the Control Plane
  * @get_dev_clk_time_access: access type for getting the device clock time
+ * @get_cross_tstamp_access: access type for the cross timestamping
  * @set_dev_clk_time_access: access type for setting the device clock time
  * @adj_dev_clk_time_access: access type for the adjusting the device clock
  * @tx_tstamp_access: access type for the Tx timestamp value read
@@ -182,6 +189,7 @@ struct idpf_ptp {
 	struct idpf_ptp_dev_clk_regs dev_clk_regs;
 	u32 caps;
 	enum idpf_ptp_access get_dev_clk_time_access:2;
+	enum idpf_ptp_access get_cross_tstamp_access:2;
 	enum idpf_ptp_access set_dev_clk_time_access:2;
 	enum idpf_ptp_access adj_dev_clk_time_access:2;
 	enum idpf_ptp_access tx_tstamp_access:2;
@@ -264,6 +272,8 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
 bool idpf_ptp_get_txq_tstamp_capability(struct idpf_tx_queue *txq);
 int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 			      struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time);
 int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
 int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
 int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
@@ -305,6 +315,13 @@ idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			struct idpf_ptp_dev_timers *cross_time)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter,
 					    u64 time)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index bdcc54a5fb56..4f1fb0cefe51 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -30,6 +30,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.send_buf.iov_len = sizeof(send_ptp_caps_msg),
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
 	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
 	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
 	struct idpf_ptp_secondary_mbx *scnd_mbx;
@@ -71,7 +72,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 
 	access_type = ptp->get_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
-		goto discipline_clock;
+		goto cross_tstamp;
 
 	clock_offsets = recv_ptp_caps_msg->clk_offsets;
 
@@ -90,6 +91,22 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	temp_offset = le32_to_cpu(clock_offsets.cmd_sync_trigger);
 	ptp->dev_clk_regs.cmd_sync = idpf_get_reg_addr(adapter, temp_offset);
 
+cross_tstamp:
+	access_type = ptp->get_cross_tstamp_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		goto discipline_clock;
+
+	cross_tstamp_offsets = recv_ptp_caps_msg->cross_time_offsets;
+
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.sys_time_ns_l);
+	ptp->dev_clk_regs.sys_time_ns_l = idpf_get_reg_addr(adapter,
+							    temp_offset);
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.sys_time_ns_h);
+	ptp->dev_clk_regs.sys_time_ns_h = idpf_get_reg_addr(adapter,
+							    temp_offset);
+	temp_offset = le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
+	ptp->dev_clk_regs.cmd_sync = idpf_get_reg_addr(adapter, temp_offset);
+
 discipline_clock:
 	access_type = ptp->adj_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
@@ -162,6 +179,42 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 	return 0;
 }
 
+/**
+ * idpf_ptp_get_cross_time - Send virtchnl get cross time message
+ * @adapter: Driver specific private structure
+ * @cross_time: Pointer to the device clock structure where the value is set
+ *
+ * Send virtchnl get cross time message to get the time of the clock and the
+ * system time.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time)
+{
+	struct virtchnl2_ptp_get_cross_time cross_time_msg;
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_PTP_GET_CROSS_TIME,
+		.send_buf.iov_base = &cross_time_msg,
+		.send_buf.iov_len = sizeof(cross_time_msg),
+		.recv_buf.iov_base = &cross_time_msg,
+		.recv_buf.iov_len = sizeof(cross_time_msg),
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	int reply_sz;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz != sizeof(cross_time_msg))
+		return -EIO;
+
+	cross_time->dev_clk_time_ns = le64_to_cpu(cross_time_msg.dev_time_ns);
+	cross_time->sys_time_ns = le64_to_cpu(cross_time_msg.sys_time_ns);
+
+	return 0;
+}
+
 /**
  * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
  * @adapter: Driver specific private structure
-- 
2.47.1


