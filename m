Return-Path: <netdev+bounces-175820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F9A678D7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A1424292
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76921148E;
	Tue, 18 Mar 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpDoPyQN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01D2101AF
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314428; cv=none; b=SgOlzZIVbYhzG+WZ16o4EWT72XAXQOvXr55aBt8HVnhRX9DZ33lEtxAChyNHVzub52OmTMaJI+SOMyl1c7HgH1G6IVl58dvVscDdwg7oDx7M3ie9VfuNnGQZXzoP3BV4Fs50ZzYk2Q7/ujhmriM4S9V15uKAtZ8VtqayEFBiZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314428; c=relaxed/simple;
	bh=rWJh1H4XZdhfTJMEa9n95Y8R6qVGMKXNGOX4wSJWEzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3VqVX0z6YjaNun4feXdhkB+Y9toI+rBNaPU2dlmNcttmN57K9C/RnmII/byFlTsiOQSiMgENKkBti+GvnorGVokWN5DTZKYatFzHrLQ2xC/j5L7UOhRqP44woB1u7XKbswvxXzyqVJsbg8+b+AvDZpseHd1H9vswZLP6tkgaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpDoPyQN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742314423; x=1773850423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWJh1H4XZdhfTJMEa9n95Y8R6qVGMKXNGOX4wSJWEzM=;
  b=WpDoPyQN+v12QNEdGXIXDCZx3V1Ls4Ob5mZdTZamVcJFLXLA0Geeoixd
   Ny0pyjsgVMUgYnAnu9fR0Av4ATvIp3jSJvEIQ6xH4Wzjzy4aBtLdIlobu
   KZgxu/MDMiujrSzEDIweFiHZmUhWt52AQoAotChX4PbVSiJGdu2sqp+Ai
   xvRkN4YbRqVT7j1lKTRDP7UUIG7EZUdk7/SMDewPwkhsVlUZBrCngLshY
   UNoxCfWK5KXA+GF2D0gXuxRPTHGEWcbIusyCcuWMJeEu0lDembQrsvABO
   LZi+2lX6tVHNjd6gJ5pahugrmA35qw5MKbRz7kF0+r4W3srGQHNYkGS9t
   Q==;
X-CSE-ConnectionGUID: jYw9wFYAS0+8mS8gi9uhGw==
X-CSE-MsgGUID: 7TWX2Kl9ThaF36WTPx+03w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54458834"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54458834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:13:33 -0700
X-CSE-ConnectionGUID: pvCL1bBXRz2t1QX4mfNvqA==
X-CSE-MsgGUID: k1n+O79ITxyGieoLXzz+4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122041953"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 09:13:34 -0700
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
	karol.kolacinski@intel.com,
	richardcochran@gmail.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 06/10] idpf: add PTP clock configuration
Date: Tue, 18 Mar 2025 09:13:21 -0700
Message-ID: <20250318161327.2532891-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

PTP clock configuration operations - set time, adjust time and adjust
frequency are required to control the clock and maintain synchronization
process.

Extend get PTP capabilities function to request for the clock adjustments
and add functions to enable these actions using dedicated virtchnl
messages.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 194 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  43 +++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   3 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 142 ++++++++++++-
 4 files changed, 379 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 7d7d399a3de0..5aa00b9177b2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -48,6 +48,20 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 	ptp->get_cross_tstamp_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
+
+	/* Set the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+
+	/* Adjust the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK;
+	mailbox = VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB;
+	ptp->adj_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
 }
 
 /**
@@ -296,6 +310,157 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 	return 0;
 }
 
+/**
+ * idpf_ptp_settime64 - Set the time of the clock
+ * @info: the driver's PTP info structure
+ * @ts: timespec64 structure that holds the new time value
+ *
+ * Set the device clock to the user input value. The conversion from timespec
+ * to ns happens in the write function.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_settime64(struct ptp_clock_info *info,
+			      const struct timespec64 *ts)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+	enum idpf_ptp_access access;
+	int err;
+	u64 ns;
+
+	access = adapter->ptp->set_dev_clk_time_access;
+	if (access != IDPF_PTP_MAILBOX)
+		return -EOPNOTSUPP;
+
+	ns = timespec64_to_ns(ts);
+
+	err = idpf_ptp_set_dev_clk_time(adapter, ns);
+	if (err) {
+		pci_err(adapter->pdev, "Failed to set the time, err: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_adjtime_nonatomic - Do a non-atomic clock adjustment
+ * @info: the driver's PTP info structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_adjtime_nonatomic(struct ptp_clock_info *info, s64 delta)
+{
+	struct timespec64 now, then;
+	int err;
+
+	err = idpf_ptp_gettimex64(info, &now, NULL);
+	if (err)
+		return err;
+
+	then = ns_to_timespec64(delta);
+	now = timespec64_add(now, then);
+
+	return idpf_ptp_settime64(info, &now);
+}
+
+/**
+ * idpf_ptp_adjtime - Adjust the time of the clock by the indicated delta
+ * @info: the driver's PTP info structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+	enum idpf_ptp_access access;
+	int err;
+
+	access = adapter->ptp->adj_dev_clk_time_access;
+	if (access != IDPF_PTP_MAILBOX)
+		return -EOPNOTSUPP;
+
+	/* Hardware only supports atomic adjustments using signed 32-bit
+	 * integers. For any adjustment outside this range, perform
+	 * a non-atomic get->adjust->set flow.
+	 */
+	if (delta > S32_MAX || delta < S32_MIN)
+		return idpf_ptp_adjtime_nonatomic(info, delta);
+
+	err = idpf_ptp_adj_dev_clk_time(adapter, delta);
+	if (err) {
+		pci_err(adapter->pdev, "Failed to adjust the clock with delta %lld err: %pe\n",
+			delta, ERR_PTR(err));
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_adjfine - Adjust clock increment rate
+ * @info: the driver's PTP info structure
+ * @scaled_ppm: Parts per million with 16-bit fractional field
+ *
+ * Adjust the frequency of the clock by the indicated scaled ppm from the
+ * base frequency.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int idpf_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+	enum idpf_ptp_access access;
+	u64 incval, diff;
+	int err;
+
+	access = adapter->ptp->adj_dev_clk_time_access;
+	if (access != IDPF_PTP_MAILBOX)
+		return -EOPNOTSUPP;
+
+	incval = adapter->ptp->base_incval;
+
+	diff = adjust_by_scaled_ppm(incval, scaled_ppm);
+	err = idpf_ptp_adj_dev_clk_fine(adapter, diff);
+	if (err)
+		pci_err(adapter->pdev, "Failed to adjust clock increment rate for scaled ppm %ld %pe\n",
+			scaled_ppm, ERR_PTR(err));
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_verify_pin - Verify if pin supports requested pin function
+ * @info: the driver's PTP info structure
+ * @pin: Pin index
+ * @func: Assigned function
+ * @chan: Assigned channel
+ *
+ * Return: EOPNOTSUPP as not supported yet.
+ */
+static int idpf_ptp_verify_pin(struct ptp_clock_info *info, unsigned int pin,
+			       enum ptp_pin_function func, unsigned int chan)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * idpf_ptp_gpio_enable - Enable/disable ancillary features of PHC
+ * @info: the driver's PTP info structure
+ * @rq: The requested feature to change
+ * @on: Enable/disable flag
+ *
+ * Return: EOPNOTSUPP as not supported yet.
+ */
+static int idpf_ptp_gpio_enable(struct ptp_clock_info *info,
+				struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * idpf_ptp_set_caps - Set PTP capabilities
  * @adapter: Driver specific private structure
@@ -310,7 +475,13 @@ static void idpf_ptp_set_caps(const struct idpf_adapter *adapter)
 		 KBUILD_MODNAME, pci_name(adapter->pdev));
 
 	info->owner = THIS_MODULE;
+	info->max_adj = adapter->ptp->max_adj;
 	info->gettimex64 = idpf_ptp_gettimex64;
+	info->settime64 = idpf_ptp_settime64;
+	info->adjfine = idpf_ptp_adjfine;
+	info->adjtime = idpf_ptp_adjtime;
+	info->verify = idpf_ptp_verify_pin;
+	info->enable = idpf_ptp_gpio_enable;
 
 #if IS_ENABLED(CONFIG_ARM_ARCH_TIMER)
 	info->getcrosststamp = idpf_ptp_get_crosststamp;
@@ -362,6 +533,7 @@ static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
  */
 int idpf_ptp_init(struct idpf_adapter *adapter)
 {
+	struct timespec64 ts;
 	int err;
 
 	if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_PTP)) {
@@ -389,10 +561,32 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 	if (err)
 		goto free_ptp;
 
+	/* Write the default increment time value if the clock adjustments
+	 * are enabled.
+	 */
+	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
+		err = idpf_ptp_adj_dev_clk_fine(adapter,
+						adapter->ptp->base_incval);
+		if (err)
+			goto remove_clock;
+	}
+
+	/* Write the initial time value if the set time operation is enabled */
+	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
+		ts = ktime_to_timespec64(ktime_get_real());
+		err = idpf_ptp_settime64(&adapter->ptp->info, &ts);
+		if (err)
+			goto remove_clock;
+	}
+
 	pci_dbg(adapter->pdev, "PTP init successful\n");
 
 	return 0;
 
+remove_clock:
+	ptp_clock_unregister(adapter->ptp->clock);
+	adapter->ptp->clock = NULL;
+
 free_ptp:
 	kfree(adapter->ptp);
 	adapter->ptp = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index 572ee0e79ba2..e7ccdcbdbd47 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -40,6 +40,18 @@ struct idpf_ptp_dev_clk_regs {
 	void __iomem *sys_time_ns_l;
 	void __iomem *sys_time_ns_h;
 
+	/* Main timer adjustments */
+	void __iomem *incval_l;
+	void __iomem *incval_h;
+	void __iomem *shadj_l;
+	void __iomem *shadj_h;
+
+	/* PHY timer adjustments */
+	void __iomem *phy_incval_l;
+	void __iomem *phy_incval_h;
+	void __iomem *phy_shadj_l;
+	void __iomem *phy_shadj_h;
+
 	/* Command */
 	void __iomem *cmd;
 	void __iomem *phy_cmd;
@@ -76,11 +88,15 @@ struct idpf_ptp_secondary_mbx {
  * @info: structure defining PTP hardware capabilities
  * @clock: pointer to registered PTP clock device
  * @adapter: back pointer to the adapter
+ * @base_incval: base increment value of the PTP clock
+ * @max_adj: maximum adjustment of the PTP clock
  * @cmd: HW specific command masks
  * @dev_clk_regs: the set of registers to access the device clock
  * @caps: PTP capabilities negotiated with the Control Plane
  * @get_dev_clk_time_access: access type for getting the device clock time
  * @get_cross_tstamp_access: access type for the cross timestamping
+ * @set_dev_clk_time_access: access type for setting the device clock time
+ * @adj_dev_clk_time_access: access type for the adjusting the device clock
  * @rsv: reserved bits
  * @secondary_mbx: parameters for using dedicated PTP mailbox
  */
@@ -88,12 +104,16 @@ struct idpf_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct idpf_adapter *adapter;
+	u64 base_incval;
+	u64 max_adj;
 	struct idpf_ptp_cmd cmd;
 	struct idpf_ptp_dev_clk_regs dev_clk_regs;
 	u32 caps;
 	enum idpf_ptp_access get_dev_clk_time_access:2;
 	enum idpf_ptp_access get_cross_tstamp_access:2;
-	u32 rsv:28;
+	enum idpf_ptp_access set_dev_clk_time_access:2;
+	enum idpf_ptp_access adj_dev_clk_time_access:2;
+	u8 rsv;
 	struct idpf_ptp_secondary_mbx secondary_mbx;
 };
 
@@ -130,6 +150,9 @@ int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 			      struct idpf_ptp_dev_timers *dev_clk_time);
 int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 			    struct idpf_ptp_dev_timers *cross_time);
+int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time);
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval);
+int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
 {
@@ -160,5 +183,23 @@ idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 	return -EOPNOTSUPP;
 }
 
+static inline int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter,
+					    u64 time)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter,
+					    u64 incval)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter,
+					    s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_PTP_1588_CLOCK */
 #endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 0fc2be15b539..5bd25dbc0e4c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -166,6 +166,9 @@ static bool idpf_ptp_is_mb_msg(u32 op)
 	switch (op) {
 	case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
 	case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+	case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
 		return true;
 	default:
 		return false;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index e51fa16d13cd..5de4bf94049b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -20,7 +20,9 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.caps = cpu_to_le32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |
 				    VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
 				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
-				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB)
+				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+				    VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+				    VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB)
 	};
 	struct idpf_vc_xn_params xn_params = {
 		.vc_op = VIRTCHNL2_OP_PTP_GET_CAPS,
@@ -29,6 +31,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
 	};
 	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
 	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
 	struct idpf_ptp_secondary_mbx *scnd_mbx;
 	struct idpf_ptp *ptp = adapter->ptp;
@@ -51,6 +54,8 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 		return -EIO;
 
 	ptp->caps = le32_to_cpu(recv_ptp_caps_msg->caps);
+	ptp->base_incval = le64_to_cpu(recv_ptp_caps_msg->base_incval);
+	ptp->max_adj = le32_to_cpu(recv_ptp_caps_msg->max_adj);
 
 	scnd_mbx = &ptp->secondary_mbx;
 	scnd_mbx->peer_mbx_q_id = le16_to_cpu(recv_ptp_caps_msg->peer_mbx_q_id);
@@ -89,7 +94,7 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 cross_tstamp:
 	access_type = ptp->get_cross_tstamp_access;
 	if (access_type != IDPF_PTP_DIRECT)
-		return 0;
+		goto discipline_clock;
 
 	cross_tstamp_offsets = recv_ptp_caps_msg->cross_time_offsets;
 
@@ -102,6 +107,39 @@ int idpf_ptp_get_caps(struct idpf_adapter *adapter)
 	temp_offset = le32_to_cpu(cross_tstamp_offsets.cmd_sync_trigger);
 	ptp->dev_clk_regs.cmd_sync = idpf_get_reg_addr(adapter, temp_offset);
 
+discipline_clock:
+	access_type = ptp->adj_dev_clk_time_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		return 0;
+
+	clk_adj_offsets = recv_ptp_caps_msg->clk_adj_offsets;
+
+	/* Device clock offsets */
+	temp_offset = le32_to_cpu(clk_adj_offsets.dev_clk_cmd_type);
+	ptp->dev_clk_regs.cmd = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.dev_clk_incval_l);
+	ptp->dev_clk_regs.incval_l = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.dev_clk_incval_h);
+	ptp->dev_clk_regs.incval_h = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.dev_clk_shadj_l);
+	ptp->dev_clk_regs.shadj_l = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.dev_clk_shadj_h);
+	ptp->dev_clk_regs.shadj_h = idpf_get_reg_addr(adapter, temp_offset);
+
+	/* PHY clock offsets */
+	temp_offset = le32_to_cpu(clk_adj_offsets.phy_clk_cmd_type);
+	ptp->dev_clk_regs.phy_cmd = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.phy_clk_incval_l);
+	ptp->dev_clk_regs.phy_incval_l = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.phy_clk_incval_h);
+	ptp->dev_clk_regs.phy_incval_h = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.phy_clk_shadj_l);
+	ptp->dev_clk_regs.phy_shadj_l = idpf_get_reg_addr(adapter, temp_offset);
+	temp_offset = le32_to_cpu(clk_adj_offsets.phy_clk_shadj_h);
+	ptp->dev_clk_regs.phy_shadj_h = idpf_get_reg_addr(adapter, temp_offset);
+
 	return 0;
 }
 
@@ -176,3 +214,103 @@ int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 
 	return 0;
 }
+
+/**
+ * idpf_ptp_set_dev_clk_time - Send virtchnl set device time message
+ * @adapter: Driver specific private structure
+ * @time: New time value
+ *
+ * Send virtchnl set time message to set the time of the clock.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
+{
+	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg = {
+		.dev_time_ns = cpu_to_le64(time),
+	};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME,
+		.send_buf.iov_base = &set_dev_clk_time_msg,
+		.send_buf.iov_len = sizeof(set_dev_clk_time_msg),
+		.recv_buf.iov_base = &set_dev_clk_time_msg,
+		.recv_buf.iov_len = sizeof(set_dev_clk_time_msg),
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	int reply_sz;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz != sizeof(set_dev_clk_time_msg))
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_adj_dev_clk_time - Send virtchnl adj device clock time message
+ * @adapter: Driver specific private structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Send virtchnl adj time message to adjust the clock by the indicated delta.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
+{
+	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg = {
+		.delta = cpu_to_le64(delta),
+	};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME,
+		.send_buf.iov_base = &adj_dev_clk_time_msg,
+		.send_buf.iov_len = sizeof(adj_dev_clk_time_msg),
+		.recv_buf.iov_base = &adj_dev_clk_time_msg,
+		.recv_buf.iov_len = sizeof(adj_dev_clk_time_msg),
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	int reply_sz;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz != sizeof(adj_dev_clk_time_msg))
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_adj_dev_clk_fine - Send virtchnl adj time message
+ * @adapter: Driver specific private structure
+ * @incval: Source timer increment value per clock cycle
+ *
+ * Send virtchnl adj fine message to adjust the frequency of the clock by
+ * incval.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
+{
+	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg = {
+		.incval = cpu_to_le64(incval),
+	};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE,
+		.send_buf.iov_base = &adj_dev_clk_fine_msg,
+		.send_buf.iov_len = sizeof(adj_dev_clk_fine_msg),
+		.recv_buf.iov_base = &adj_dev_clk_fine_msg,
+		.recv_buf.iov_len = sizeof(adj_dev_clk_fine_msg),
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	int reply_sz;
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	if (reply_sz != sizeof(adj_dev_clk_fine_msg))
+		return -EIO;
+
+	return 0;
+}
-- 
2.47.1


