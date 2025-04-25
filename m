Return-Path: <netdev+bounces-186152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F9A9D48F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490901782F1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A4224B0B;
	Fri, 25 Apr 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7WKQ9DK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CCE228C86
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617963; cv=none; b=ZW5SDyND0vuS0RLuRZf+XVxssKl4BvMnBcX9PzEa4AoqKefFPT9Gj1iDuEyNkYNbmHT4iU7OeqQYhKshEYlxD+LmvRa2RSg3W4ik0AdzCjzBFZFNhW7cCHJxGaLOvVk2lTXmDdHs/bm8mPLD0loM2lkht44kPDIa+fo+H7y6gIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617963; c=relaxed/simple;
	bh=MTeaJhSwAz+MXXtK9bryPDmnsY6k6XHKfWsnnOnYVO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPGQyPrdGSU5Ys1wD/i14WY7jtRcDngASOMeeLztLdzauWPUdaCAkB+ioLk0Y36EQ5rtFFtC1Yc24RF3BIELFsbvhrfFbuMJfpTJyCzrYcqumVonm5myYgX3oCu7jbcbaYcIpKmDW61XAyWyWSM/tpcWnwcPYavp1quYb8Lfk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7WKQ9DK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617962; x=1777153962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MTeaJhSwAz+MXXtK9bryPDmnsY6k6XHKfWsnnOnYVO0=;
  b=D7WKQ9DK8tK/fzLzEqwJ07kqrLxzoyxFzc9gkVDMWlQLhdI9W1H6Z6Dq
   v0K4hCSl4Man9TKyF/bPiFJSUCJ6z4XQvE4dKKByhMysVO7OGBfAsz4HM
   j3BpYH29Qh4AEO8vMB0CO3/lI0M59DuBSnv48/wn2m/rOwE2Gkyth2yWm
   +wEMbB1AgIT4q0vCaejXCOQqx+x800Pd5MRn9v6W8gQVuX5k6uA3/Nu9H
   umScrrHylwiVl0UM7uneEZdsAjnzxpE4SJX7LbQr+/bW8vLdxvPOincke
   pIUoEvtJoT52Ppi8SasfUErqBlWu/yhxlPcVeQI8DgK9lmjvirjPhtiKh
   Q==;
X-CSE-ConnectionGUID: cPYOfB8LRbinRu5O3jc7cA==
X-CSE-MsgGUID: l8vXjXgJQRqHG+/pS1IgfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69784571"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="69784571"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:52:37 -0700
X-CSE-ConnectionGUID: 8EzXKcKzRx6+WiyJ/mnvnA==
X-CSE-MsgGUID: 9fSbxtJrSDenoEtxEWNM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="163973524"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 14:52:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 07/11] idpf: add cross timestamping
Date: Fri, 25 Apr 2025 14:52:21 -0700
Message-ID: <20250425215227.3170837-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 139 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  18 ++-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  55 ++++++-
 3 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index bda194b56bbe..887257fe334d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -41,6 +41,13 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 	ptp->get_dev_clk_time_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
+
+	/* Get the cross timestamp */
+	direct = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB;
+	ptp->get_cross_tstamp_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
 }
 
 /**
@@ -150,6 +157,129 @@ static int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk,
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
+	*dev_time = ((u64)dev_time_hi << 32) | dev_time_lo;
+	*sys_time = ((u64)sys_time_hi << 32) | sys_time_lo;
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+}
+
+/**
+ * idpf_ptp_get_sync_device_time_mailbox - Get the cross time stamp values
+ *					   through mailbox
+ * @adapter: Driver specific private structure
+ * @dev_time: 64bit main timer value expressed in nanoseconds
+ * @sys_time: 64bit system time value expressed in nanoseconds
+ *
+ * Return: a pair of cross timestamp values on success, -errno otherwise.
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
+ * Return: the device and the system clocks time read simultaneously on success,
+ * -errno otherwise.
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
+		err =  idpf_ptp_get_sync_device_time_mailbox(adapter,
+							     &ns_time_dev,
+							     &ns_time_sys);
+		if (err)
+			return err;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*device = ns_to_ktime(ns_time_dev);
+
+#if IS_ENABLED(CONFIG_X86)
+	system->cs_id = CSID_X86_ART;
+#else
+	system->cs_id = CSID_ARM_ARCH_COUNTER;
+#endif /* CONFIG_X86 */
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
@@ -192,6 +322,15 @@ static void idpf_ptp_set_caps(const struct idpf_adapter *adapter)
 
 	info->owner = THIS_MODULE;
 	info->gettimex64 = idpf_ptp_gettimex64;
+
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
index b536c1cdbb2e..b605e779f922 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -21,6 +21,8 @@ struct idpf_ptp_cmd {
  * @dev_clk_ns_h: high part of the device clock register
  * @phy_clk_ns_l: low part of the PHY clock register
  * @phy_clk_ns_h: high part of the PHY clock register
+ * @sys_time_ns_l: low part of the system time register
+ * @sys_time_ns_h: high part of the system time register
  * @cmd: PTP command register
  * @phy_cmd: PHY command register
  * @cmd_sync: PTP command synchronization register
@@ -34,6 +36,10 @@ struct idpf_ptp_dev_clk_regs {
 	void __iomem *phy_clk_ns_l;
 	void __iomem *phy_clk_ns_h;
 
+	/* System time */
+	void __iomem *sys_time_ns_l;
+	void __iomem *sys_time_ns_h;
+
 	/* Command */
 	void __iomem *cmd;
 	void __iomem *phy_cmd;
@@ -74,6 +80,7 @@ struct idpf_ptp_secondary_mbx {
  * @dev_clk_regs: the set of registers to access the device clock
  * @caps: PTP capabilities negotiated with the Control Plane
  * @get_dev_clk_time_access: access type for getting the device clock time
+ * @get_cross_tstamp_access: access type for the cross timestamping
  * @rsv: reserved bits
  * @secondary_mbx: parameters for using dedicated PTP mailbox
  * @read_dev_clk_lock: spinlock protecting access to the device clock read
@@ -87,7 +94,8 @@ struct idpf_ptp {
 	struct idpf_ptp_dev_clk_regs dev_clk_regs;
 	u32 caps;
 	enum idpf_ptp_access get_dev_clk_time_access:2;
-	u32 rsv:30;
+	enum idpf_ptp_access get_cross_tstamp_access:2;
+	u32 rsv:28;
 	struct idpf_ptp_secondary_mbx secondary_mbx;
 	spinlock_t read_dev_clk_lock;
 };
@@ -123,6 +131,8 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter);
 void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
 int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 			      struct idpf_ptp_dev_timers *dev_clk_time);
+int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
 {
@@ -146,5 +156,11 @@ idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			struct idpf_ptp_dev_timers *cross_time)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PTP_1588_CLOCK */
 #endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 79bd2585703b..e51fa16d13cd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -28,6 +28,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.send_buf.iov_len = sizeof(send_ptp_caps_msg),
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
 	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
 	struct idpf_ptp_secondary_mbx *scnd_mbx;
 	struct idpf_ptp *ptp = adapter->ptp;
@@ -66,7 +67,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 
 	access_type = ptp->get_dev_clk_time_access;
 	if (access_type != IDPF_PTP_DIRECT)
-		return 0;
+		goto cross_tstamp;
 
 	clock_offsets = recv_ptp_caps_msg->clk_offsets;
 
@@ -85,6 +86,22 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	temp_offset = le32_to_cpu(clock_offsets.cmd_sync_trigger);
 	ptp->dev_clk_regs.cmd_sync = idpf_get_reg_addr(adapter, temp_offset);
 
+cross_tstamp:
+	access_type = ptp->get_cross_tstamp_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		return 0;
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
 	return 0;
 }
 
@@ -123,3 +140,39 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 
 	return 0;
 }
+
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
-- 
2.47.1


