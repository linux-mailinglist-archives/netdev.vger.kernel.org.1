Return-Path: <netdev+bounces-186151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C23A9D48E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D44A1788E6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57E22A7E6;
	Fri, 25 Apr 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2gCMyWl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85707227E8C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617962; cv=none; b=lsfujVmOi0PTRguvkQuMKS3cKAGvgPCj0cYaaSe/+9Xucq3HezxQqS9/4MwEseztBARB3LFaAQbEvGsxpCfVStBIFPyF/zoFBkvSa7ySQC1X1JJCNyvpoGa5vIBXESgbkAHL50hwj2uaubJrC4G1t6edqyMkTNY7u61mkwlXSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617962; c=relaxed/simple;
	bh=yYg0cCjPDhPvMm2hkOk3rfJljLhG93yEgkQNhlVQ2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyx/3lwXSJnUIVK7pmyFispO4ZeL3PNLoOqBjpWFs5Zfa5mF0Jr28xdhubEFokwoRIzPEOg1i6tJuwI7aTZzB58LogQ73ldpTIvHRfvyfipv74u7j372Oc07Ar978byZP/TOXT+xNLICq72GWYVtQvJWYJUvWFcRwE3bvyQ8pKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2gCMyWl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745617961; x=1777153961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yYg0cCjPDhPvMm2hkOk3rfJljLhG93yEgkQNhlVQ2vk=;
  b=g2gCMyWlhsxEQZqN5HZYvJLkFa72lFtHoFADtWsWswulzEmFhE+d5w7g
   XrwapqfswZKrxeyVCgYe0ysrW+De8kBeHIC6Rl0YzvUNeLBOdKeUibzs7
   yi2QQWjny1Wd+GXxlF9uyAdMG2EKVvZjiFOFVLq9f2GP7m0k+wbnz/SZ7
   Arbzt8pNm+G+BpCXdICEJgaWlj+HIwKdc9mxMgP9MDZb/dMeLj7AkEs7w
   j4J2pn6DIZTOFIhI7ebHH/KfLjO4HQdI8kW4CeY5d1np20rPrI3vFHuBb
   vKYXLPTJWYURQ5yV3o49JDtP4uuqZda1LpseN0yYcUve3G0MGqYmxOXzV
   Q==;
X-CSE-ConnectionGUID: z3vGZg2PRAO4d6IrKwhAhQ==
X-CSE-MsgGUID: MgEHsX6iQ1+775bKco6eHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69784557"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="69784557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 14:52:37 -0700
X-CSE-ConnectionGUID: MPaenkYhTwilytyPzp5jjg==
X-CSE-MsgGUID: FYdrtvZoRTa3spdeh9ogiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="163973517"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2025 14:52:36 -0700
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
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 05/11] idpf: negotiate PTP capabilities and get PTP clock
Date: Fri, 25 Apr 2025 14:52:19 -0700
Message-ID: <20250425215227.3170837-6-anthony.l.nguyen@intel.com>
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

PTP capabilities are negotiated using virtchnl command. Add get
capabilities function, direct access to read the PTP clock.
Set initial PTP capabilities exposed to the stack.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Willem de Bruijn <willemb@google.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 ++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 170 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  84 +++++++++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  78 ++++++++
 7 files changed, 354 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 1f38a9d7125c..83ac5e296382 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -17,4 +17,6 @@ idpf-y := \
 	idpf_vf_dev.o
 
 idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
+
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
+idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 2e8b14dd9d96..d5d5064d313b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -189,6 +189,7 @@ struct idpf_vport_max_q {
  * @mb_intr_reg_init: Mailbox interrupt register initialization
  * @reset_reg_init: Reset register initialization
  * @trigger_reset: Trigger a reset to occur
+ * @ptp_reg_init: PTP register initialization
  */
 struct idpf_reg_ops {
 	void (*ctlq_reg_init)(struct idpf_ctlq_create_info *cq);
@@ -197,6 +198,7 @@ struct idpf_reg_ops {
 	void (*reset_reg_init)(struct idpf_adapter *adapter);
 	void (*trigger_reset)(struct idpf_adapter *adapter,
 			      enum idpf_flags trig_cause);
+	void (*ptp_reg_init)(const struct idpf_adapter *adapter);
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 41e4bd49402a..3fae81f1f988 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -4,6 +4,7 @@
 #include "idpf.h"
 #include "idpf_lan_pf_regs.h"
 #include "idpf_virtchnl.h"
+#include "idpf_ptp.h"
 
 #define IDPF_PF_ITR_IDX_SPACING		0x4
 
@@ -148,6 +149,18 @@ static void idpf_trigger_reset(struct idpf_adapter *adapter,
 	       idpf_get_reg_addr(adapter, PFGEN_CTRL));
 }
 
+/**
+ * idpf_ptp_reg_init - Initialize required registers
+ * @adapter: Driver specific private structure
+ *
+ * Set the bits required for enabling shtime and cmd execution
+ */
+static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
+{
+	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
+	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
+}
+
 /**
  * idpf_reg_ops_init - Initialize register API function pointers
  * @adapter: Driver specific private structure
@@ -159,6 +172,7 @@ static void idpf_reg_ops_init(struct idpf_adapter *adapter)
 	adapter->dev_ops.reg_ops.mb_intr_reg_init = idpf_mb_intr_reg_init;
 	adapter->dev_ops.reg_ops.reset_reg_init = idpf_reset_reg_init;
 	adapter->dev_ops.reg_ops.trigger_reset = idpf_trigger_reset;
+	adapter->dev_ops.reg_ops.ptp_reg_init = idpf_ptp_reg_init;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h b/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
index 24edb8a6ec2e..cc9aa2b6a14a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
@@ -53,6 +53,10 @@
 #define PF_FW_ATQH_ATQH_M		GENMASK(9, 0)
 #define PF_FW_ATQT			(PF_FW_BASE + 0x24)
 
+/* Timesync registers */
+#define PF_GLTSYN_CMD_SYNC_EXEC_CMD_M	GENMASK(1, 0)
+#define PF_GLTSYN_CMD_SYNC_SHTIME_EN_M	BIT(2)
+
 /* Interrupts */
 #define PF_GLINT_BASE			0x08900000
 #define PF_GLINT_DYN_CTL(_INT)		(PF_GLINT_BASE + ((_INT) * 0x1000))
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 71fc652b79e6..3322598cf7d5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -4,6 +4,163 @@
 #include "idpf.h"
 #include "idpf_ptp.h"
 
+/**
+ * idpf_ptp_get_access - Determine the access type of the PTP features
+ * @adapter: Driver specific private structure
+ * @direct: Capability that indicates the direct access
+ * @mailbox: Capability that indicates the mailbox access
+ *
+ * Return: the type of supported access for the PTP feature.
+ */
+static enum idpf_ptp_access
+idpf_ptp_get_access(const struct idpf_adapter *adapter, u32 direct, u32 mailbox)
+{
+	if (adapter->ptp->caps & direct)
+		return IDPF_PTP_DIRECT;
+	else if (adapter->ptp->caps & mailbox)
+		return IDPF_PTP_MAILBOX;
+	else
+		return IDPF_PTP_NONE;
+}
+
+/**
+ * idpf_ptp_get_features_access - Determine the access type of PTP features
+ * @adapter: Driver specific private structure
+ *
+ * Fulfill the adapter structure with type of the supported PTP features
+ * access.
+ */
+void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 direct, mailbox;
+
+	/* Get the device clock time */
+	direct = VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB;
+	ptp->get_dev_clk_time_access = idpf_ptp_get_access(adapter,
+							   direct,
+							   mailbox);
+}
+
+/**
+ * idpf_ptp_enable_shtime - Enable shadow time and execute a command
+ * @adapter: Driver specific private structure
+ */
+static void idpf_ptp_enable_shtime(struct idpf_adapter *adapter)
+{
+	u32 shtime_enable, exec_cmd;
+
+	/* Get offsets */
+	shtime_enable = adapter->ptp->cmd.shtime_enable_mask;
+	exec_cmd = adapter->ptp->cmd.exec_cmd_mask;
+
+	/* Set the shtime en and the sync field */
+	writel(shtime_enable, adapter->ptp->dev_clk_regs.cmd_sync);
+	writel(exec_cmd | shtime_enable, adapter->ptp->dev_clk_regs.cmd_sync);
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
+ * @adapter: Driver specific private structure
+ * @sts: Optional parameter for holding a pair of system timestamps from
+ *	 the system clock. Will be ignored when NULL is given.
+ *
+ * Return: the device clock time.
+ */
+static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
+					    struct ptp_system_timestamp *sts)
+{
+	struct idpf_ptp *ptp = adapter->ptp;
+	u32 hi, lo;
+
+	spin_lock(&ptp->read_dev_clk_lock);
+
+	/* Read the system timestamp pre PHC read */
+	ptp_read_system_prets(sts);
+
+	idpf_ptp_enable_shtime(adapter);
+
+	/* Read the system timestamp post PHC read */
+	ptp_read_system_postts(sts);
+
+	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
+	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	spin_unlock(&ptp->read_dev_clk_lock);
+
+	return ((u64)hi << 32) | lo;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg - Read the main timer value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ * @sts: Optional parameter for holding a pair of system timestamps from
+ *	 the system clock. Will be ignored if NULL is given.
+ *
+ * Return: the device clock time on success, -errno otherwise.
+ */
+static int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, u64 *src_clk,
+				     struct ptp_system_timestamp *sts)
+{
+	switch (adapter->ptp->get_dev_clk_time_access) {
+	case IDPF_PTP_NONE:
+		return -EOPNOTSUPP;
+	case IDPF_PTP_DIRECT:
+		*src_clk = idpf_ptp_read_src_clk_reg_direct(adapter, sts);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_gettimex64 - Get the time of the clock
+ * @info: the driver's PTP info structure
+ * @ts: timespec64 structure to hold the current time value
+ * @sts: Optional parameter for holding a pair of system timestamps from
+ *	 the system clock. Will be ignored if NULL is given.
+ *
+ * Return: the device clock value in ns, after converting it into a timespec
+ * struct on success, -errno otherwise.
+ */
+static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
+			       struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts)
+{
+	struct idpf_adapter *adapter = idpf_ptp_info_to_adapter(info);
+	u64 time_ns;
+	int err;
+
+	err = idpf_ptp_read_src_clk_reg(adapter, &time_ns, sts);
+	if (err)
+		return -EACCES;
+
+	*ts = ns_to_timespec64(time_ns);
+
+	return 0;
+}
+
+/**
+ * idpf_ptp_set_caps - Set PTP capabilities
+ * @adapter: Driver specific private structure
+ *
+ * This function sets the PTP functions.
+ */
+static void idpf_ptp_set_caps(const struct idpf_adapter *adapter)
+{
+	struct ptp_clock_info *info = &adapter->ptp->info;
+
+	snprintf(info->name, sizeof(info->name), "%s-%s-clk",
+		 KBUILD_MODNAME, pci_name(adapter->pdev));
+
+	info->owner = THIS_MODULE;
+	info->gettimex64 = idpf_ptp_gettimex64;
+}
+
 /**
  * idpf_ptp_create_clock - Create PTP clock device for userspace
  * @adapter: Driver specific private structure
@@ -16,6 +173,8 @@ static int idpf_ptp_create_clock(const struct idpf_adapter *adapter)
 {
 	struct ptp_clock *clock;
 
+	idpf_ptp_set_caps(adapter);
+
 	/* Attempt to register the clock before enabling the hardware. */
 	clock = ptp_clock_register(&adapter->ptp->info,
 				   &adapter->pdev->dev);
@@ -56,10 +215,21 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 	/* add a back pointer to adapter */
 	adapter->ptp->adapter = adapter;
 
+	if (adapter->dev_ops.reg_ops.ptp_reg_init)
+		adapter->dev_ops.reg_ops.ptp_reg_init(adapter);
+
+	err = idpf_ptp_get_caps(adapter);
+	if (err) {
+		pci_err(adapter->pdev, "Failed to get PTP caps err %d\n", err);
+		goto free_ptp;
+	}
+
 	err = idpf_ptp_create_clock(adapter);
 	if (err)
 		goto free_ptp;
 
+	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
+
 	pci_dbg(adapter->pdev, "PTP init successful\n");
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index d009417bf947..955d697e51ab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -6,21 +6,96 @@
 
 #include <linux/ptp_clock_kernel.h>
 
+/**
+ * struct idpf_ptp_cmd - PTP command masks
+ * @exec_cmd_mask: mask to trigger command execution
+ * @shtime_enable_mask: mask to enable shadow time
+ */
+struct idpf_ptp_cmd {
+	u32 exec_cmd_mask;
+	u32 shtime_enable_mask;
+};
+
+/* struct idpf_ptp_dev_clk_regs - PTP device registers
+ * @dev_clk_ns_l: low part of the device clock register
+ * @dev_clk_ns_h: high part of the device clock register
+ * @phy_clk_ns_l: low part of the PHY clock register
+ * @phy_clk_ns_h: high part of the PHY clock register
+ * @cmd: PTP command register
+ * @phy_cmd: PHY command register
+ * @cmd_sync: PTP command synchronization register
+ */
+struct idpf_ptp_dev_clk_regs {
+	/* Main clock */
+	void __iomem *dev_clk_ns_l;
+	void __iomem *dev_clk_ns_h;
+
+	/* PHY timer */
+	void __iomem *phy_clk_ns_l;
+	void __iomem *phy_clk_ns_h;
+
+	/* Command */
+	void __iomem *cmd;
+	void __iomem *phy_cmd;
+	void __iomem *cmd_sync;
+};
+
+/**
+ * enum idpf_ptp_access - the type of access to PTP operations
+ * @IDPF_PTP_NONE: no access
+ * @IDPF_PTP_DIRECT: direct access through BAR registers
+ * @IDPF_PTP_MAILBOX: access through mailbox messages
+ */
+enum idpf_ptp_access {
+	IDPF_PTP_NONE = 0,
+	IDPF_PTP_DIRECT,
+	IDPF_PTP_MAILBOX,
+};
+
 /**
  * struct idpf_ptp - PTP parameters
  * @info: structure defining PTP hardware capabilities
  * @clock: pointer to registered PTP clock device
  * @adapter: back pointer to the adapter
+ * @cmd: HW specific command masks
+ * @dev_clk_regs: the set of registers to access the device clock
+ * @caps: PTP capabilities negotiated with the Control Plane
+ * @get_dev_clk_time_access: access type for getting the device clock time
+ * @rsv: reserved bits
+ * @read_dev_clk_lock: spinlock protecting access to the device clock read
+ *		       operation executed by the HW latch
  */
 struct idpf_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct idpf_adapter *adapter;
+	struct idpf_ptp_cmd cmd;
+	struct idpf_ptp_dev_clk_regs dev_clk_regs;
+	u32 caps;
+	enum idpf_ptp_access get_dev_clk_time_access:2;
+	u32 rsv:30;
+	spinlock_t read_dev_clk_lock;
 };
 
+/**
+ * idpf_ptp_info_to_adapter - get driver adapter struct from ptp_clock_info
+ * @info: pointer to ptp_clock_info struct
+ *
+ * Return: pointer to the corresponding adapter struct
+ */
+static inline struct idpf_adapter *
+idpf_ptp_info_to_adapter(const struct ptp_clock_info *info)
+{
+	const struct idpf_ptp *ptp = container_of_const(info, struct idpf_ptp,
+							info);
+	return ptp->adapter;
+}
+
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int idpf_ptp_init(struct idpf_adapter *adapter);
 void idpf_ptp_release(struct idpf_adapter *adapter);
+int idpf_ptp_get_caps(struct idpf_adapter *adapter);
+void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
 #else /* CONFIG_PTP_1588_CLOCK */
 static inline int idpf_ptp_init(struct idpf_adapter *adapter)
 {
@@ -28,5 +103,14 @@ static inline int idpf_ptp_init(struct idpf_adapter *adapter)
 }
 
 static inline void idpf_ptp_release(struct idpf_adapter *adapter) { }
+
+static inline int idpf_ptp_get_caps(struct idpf_adapter *adapter)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+idpf_ptp_get_features_access(const struct idpf_adapter *adapter) { }
+
 #endif /* CONFIG_PTP_1588_CLOCK */
 #endif /* _IDPF_PTP_H */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
new file mode 100644
index 000000000000..c3c6b920f277
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_ptp.h"
+#include "idpf_virtchnl.h"
+
+/**
+ * idpf_ptp_get_caps - Send virtchnl get ptp capabilities message
+ * @adapter: Driver specific private structure
+ *
+ * Send virtchnl get PTP capabilities message.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int idpf_ptp_get_caps(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg __free(kfree) = NULL;
+	struct virtchnl2_ptp_get_caps send_ptp_caps_msg = {
+		.caps = cpu_to_le32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |
+				    VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
+				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+				    VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB)
+	};
+	struct idpf_vc_xn_params xn_params = {
+		.vc_op = VIRTCHNL2_OP_PTP_GET_CAPS,
+		.send_buf.iov_base = &send_ptp_caps_msg,
+		.send_buf.iov_len = sizeof(send_ptp_caps_msg),
+		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
+	struct idpf_ptp *ptp = adapter->ptp;
+	enum idpf_ptp_access access_type;
+	u32 temp_offset;
+	int reply_sz;
+
+	recv_ptp_caps_msg = kzalloc(sizeof(struct virtchnl2_ptp_get_caps),
+				    GFP_KERNEL);
+	if (!recv_ptp_caps_msg)
+		return -ENOMEM;
+
+	xn_params.recv_buf.iov_base = recv_ptp_caps_msg;
+	xn_params.recv_buf.iov_len = sizeof(*recv_ptp_caps_msg);
+
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
+	if (reply_sz < 0)
+		return reply_sz;
+	else if (reply_sz != sizeof(*recv_ptp_caps_msg))
+		return -EIO;
+
+	ptp->caps = le32_to_cpu(recv_ptp_caps_msg->caps);
+
+	/* Determine the access type for the PTP features */
+	idpf_ptp_get_features_access(adapter);
+
+	access_type = ptp->get_dev_clk_time_access;
+	if (access_type != IDPF_PTP_DIRECT)
+		return 0;
+
+	clock_offsets = recv_ptp_caps_msg->clk_offsets;
+
+	temp_offset = le32_to_cpu(clock_offsets.dev_clk_ns_l);
+	ptp->dev_clk_regs.dev_clk_ns_l = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clock_offsets.dev_clk_ns_h);
+	ptp->dev_clk_regs.dev_clk_ns_h = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clock_offsets.phy_clk_ns_l);
+	ptp->dev_clk_regs.phy_clk_ns_l = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clock_offsets.phy_clk_ns_h);
+	ptp->dev_clk_regs.phy_clk_ns_h = idpf_get_reg_addr(adapter,
+							   temp_offset);
+	temp_offset = le32_to_cpu(clock_offsets.cmd_sync_trigger);
+	ptp->dev_clk_regs.cmd_sync = idpf_get_reg_addr(adapter, temp_offset);
+
+	return 0;
+}
-- 
2.47.1


