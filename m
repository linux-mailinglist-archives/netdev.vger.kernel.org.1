Return-Path: <netdev+bounces-50438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DD7F5CF4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DE3B21193
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479F224E1;
	Thu, 23 Nov 2023 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXghXjbE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987ED54;
	Thu, 23 Nov 2023 02:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736811; x=1732272811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qhkT31CeMSRBRbWxutcPZy3/seb4c9qGZEE2XbyrOP8=;
  b=AXghXjbEgD7c9E3xgMwG1OWDcdcASQACwNXAykDmaKw/lRw99s66yH7w
   xqQ08eMlPeX0ffcEmMo/xQteK5GEQbHAf8mNK822mCIey8thvRDz4YZu7
   qEXu60ceWDtPTiiZVvhuUZ+ipLHVHzsje2qhPUl07+mjyrQISCPuEjm+z
   ohJBfSyQ8kzLysx2c85KcF+ajzv+l4GrVKrSfD09PDEpcd1Gi6WLtukvq
   Hf7uiH0vo7PzAz5AhI5cPDd/6fonHwD+UQ32lAzbWfEB6tSAgumdgIAgv
   dWTrkuRkpK8PVbKwQsMlzZVOxcmqnlXpGWOi4QAS+d40L4lMEY/jRLrYy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458741825"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="458741825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837764665"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="837764665"
Received: from mmichali-devpc.igk.intel.com (HELO localhost.localdomain) ([10.211.235.239])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2023 02:53:03 -0800
From: Michal Michalik <michal.michalik@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	poros@redhat.com,
	milena.olech@intel.com,
	mschmidt@redhat.com,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH RFC net-next v4 1/2] netdevsim: implement DPLL for subsystem selftests
Date: Thu, 23 Nov 2023 05:52:42 -0500
Message-Id: <20231123105243.7992-2-michal.michalik@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231123105243.7992-1-michal.michalik@intel.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPLL subsystem integration tests require a module which mimics the
behavior of real driver which supports DPLL hardware. To fully test the
subsystem the netdevsim is amended with DPLL implementation.

Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 drivers/net/Kconfig               |   1 +
 drivers/net/netdevsim/Makefile    |   2 +-
 drivers/net/netdevsim/dev.c       |  21 +-
 drivers/net/netdevsim/dpll.c      | 489 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  10 +
 drivers/net/netdevsim/netdevsim.h |  44 +++
 6 files changed, 565 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/netdevsim/dpll.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index af0da4bb429b..633ec89881ef 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -626,6 +626,7 @@ config NETDEVSIM
 	depends on PSAMPLE || PSAMPLE=n
 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
 	select NET_DEVLINK
+	select DPLL
 	help
 	  This driver is a developer testing tool and software model that can
 	  be used to test various control path networking APIs, especially
diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index f8de93bc5f5b..f338ffb34f16 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_NETDEVSIM) += netdevsim.o
 
 netdevsim-objs := \
-	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o
+	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o dpll.o
 
 ifeq ($(CONFIG_BPF_SYSCALL),y)
 netdevsim-objs += \
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..76da4e8aa9af 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -342,6 +342,17 @@ static int nsim_dev_debugfs_init(struct nsim_dev *nsim_dev)
 	debugfs_create_file("max_vfs", 0600, nsim_dev->ddir,
 			    nsim_dev, &nsim_dev_max_vfs_fops);
 
+	debugfs_create_u64("dpll_clock_id", 0600,
+			   nsim_dev->ddir, &nsim_dev->dpll.dpll_e_pd.clock_id);
+	debugfs_create_u32("dpll_e_status", 0600, nsim_dev->ddir,
+			   &nsim_dev->dpll.dpll_e_pd.status);
+	debugfs_create_u32("dpll_p_status", 0600, nsim_dev->ddir,
+			   &nsim_dev->dpll.dpll_p_pd.status);
+	debugfs_create_u32("dpll_e_temp", 0600, nsim_dev->ddir,
+			   &nsim_dev->dpll.dpll_e_pd.temperature);
+	debugfs_create_u32("dpll_p_temp", 0600, nsim_dev->ddir,
+			   &nsim_dev->dpll.dpll_p_pd.temperature);
+
 	nsim_dev->nodes_ddir = debugfs_create_dir("rate_nodes", nsim_dev->ddir);
 	if (IS_ERR(nsim_dev->nodes_ddir)) {
 		err = PTR_ERR(nsim_dev->nodes_ddir);
@@ -1601,14 +1612,21 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	if (err)
 		goto err_psample_exit;
 
-	err = nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
+	err = nsim_dpll_init_owner(&nsim_dev->dpll, nsim_bus_dev->port_count);
 	if (err)
 		goto err_hwstats_exit;
 
+	err = nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
+	if (err)
+		goto err_teardown_dpll;
+
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
 	devl_unlock(devlink);
+
 	return 0;
 
+err_teardown_dpll:
+	nsim_dpll_free_owner(&nsim_dev->dpll);
 err_hwstats_exit:
 	nsim_dev_hwstats_exit(nsim_dev);
 err_psample_exit:
@@ -1656,6 +1674,7 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 	}
 
 	nsim_dev_port_del_all(nsim_dev);
+	nsim_dpll_free_owner(&nsim_dev->dpll);
 	nsim_dev_hwstats_exit(nsim_dev);
 	nsim_dev_psample_exit(nsim_dev);
 	nsim_dev_health_exit(nsim_dev);
diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
new file mode 100644
index 000000000000..26a8b0f3be16
--- /dev/null
+++ b/drivers/net/netdevsim/dpll.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+#include "netdevsim.h"
+
+#define EEC_DPLL_DEV 0
+#define EEC_DPLL_TEMPERATURE 20
+#define PPS_DPLL_DEV 1
+#define PPS_DPLL_TEMPERATURE 30
+
+#define PIN_GNSS 0
+#define PIN_GNSS_CAPABILITIES DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
+#define PIN_GNSS_PRIORITY 5
+
+#define PIN_PPS 1
+#define PIN_PPS_CAPABILITIES                          \
+	(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE | \
+	 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |  \
+	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
+#define PIN_PPS_PRIORITY 6
+
+#define PIN_RCLK 2
+#define PIN_RCLK_CAPABILITIES                        \
+	(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | \
+	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
+#define PIN_RCLK_PRIORITY 7
+
+#define EEC_PINS_NUMBER 3
+#define PPS_PINS_NUMBER 2
+
+static int nsim_fill_pin_properties(struct dpll_pin_properties *pp,
+				    const char *label, enum dpll_pin_type type,
+				    unsigned long caps, u32 freq_supp_num,
+				    u64 fmin, u64 fmax)
+{
+	struct dpll_pin_frequency *freq_supp;
+
+	freq_supp = kzalloc(sizeof(*freq_supp), GFP_KERNEL);
+	if (!freq_supp)
+		goto freq_supp;
+	freq_supp->min = fmin;
+	freq_supp->max = fmax;
+
+	pp->board_label = kasprintf(GFP_KERNEL, "%s_brd", label);
+	if (!pp->board_label)
+		goto board_label;
+	pp->panel_label = kasprintf(GFP_KERNEL, "%s_pnl", label);
+	if (!pp->panel_label)
+		goto panel_label;
+	pp->package_label = kasprintf(GFP_KERNEL, "%s_pcg", label);
+	if (!pp->package_label)
+		goto package_label;
+	pp->freq_supported_num = freq_supp_num;
+	pp->freq_supported = freq_supp;
+	pp->capabilities = caps;
+	pp->type = type;
+
+	return 0;
+
+package_label:
+	kfree(pp->panel_label);
+panel_label:
+	kfree(pp->board_label);
+board_label:
+	kfree(freq_supp);
+freq_supp:
+	return -ENOMEM;
+}
+
+static void nsim_fill_pin_pd(struct nsim_pin_priv_data *pd, u64 frequency,
+			     u32 prio, enum dpll_pin_direction direction)
+{
+	pd->state_dpll = DPLL_PIN_STATE_DISCONNECTED;
+	pd->state_pin = DPLL_PIN_STATE_DISCONNECTED;
+	pd->frequency = frequency;
+	pd->direction = direction;
+	pd->prio = prio;
+}
+
+static int nsim_dds_ops_mode_get(const struct dpll_device *dpll,
+				 void *dpll_priv, enum dpll_mode *mode,
+				 struct netlink_ext_ack *extack)
+{
+	struct nsim_dpll_priv_data *pd = dpll_priv;
+	*mode = pd->mode;
+	return 0;
+};
+
+static bool nsim_dds_ops_mode_supported(const struct dpll_device *dpll,
+					void *dpll_priv,
+					const enum dpll_mode mode,
+					struct netlink_ext_ack *extack)
+{
+	return true;
+};
+
+static int nsim_dds_ops_lock_status_get(const struct dpll_device *dpll,
+					void *dpll_priv,
+					enum dpll_lock_status *status,
+					struct netlink_ext_ack *extack)
+{
+	struct nsim_dpll_priv_data *pd = dpll_priv;
+
+	*status = pd->status;
+	return 0;
+};
+
+static int nsim_dds_ops_temp_get(const struct dpll_device *dpll,
+				 void *dpll_priv, s32 *temp,
+				 struct netlink_ext_ack *extack)
+{
+	struct nsim_dpll_priv_data *pd = dpll_priv;
+
+	*temp = pd->temperature;
+	return 0;
+};
+
+static int nsim_pin_frequency_set(const struct dpll_pin *pin, void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv, const u64 frequency,
+				  struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	pd->frequency = frequency;
+	return 0;
+};
+
+static int nsim_pin_frequency_get(const struct dpll_pin *pin, void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv, u64 *frequency,
+				  struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	*frequency = pd->frequency;
+	return 0;
+};
+
+static int nsim_pin_direction_set(const struct dpll_pin *pin, void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv,
+				  const enum dpll_pin_direction direction,
+				  struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	pd->direction = direction;
+	return 0;
+};
+
+static int nsim_pin_direction_get(const struct dpll_pin *pin, void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv,
+				  enum dpll_pin_direction *direction,
+				  struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	*direction = pd->direction;
+	return 0;
+};
+
+static int nsim_pin_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
+				     const struct dpll_pin *parent_pin,
+				     void *parent_priv,
+				     enum dpll_pin_state *state,
+				     struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	*state = pd->state_pin;
+	return 0;
+};
+
+static int nsim_pin_state_on_dpll_get(const struct dpll_pin *pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv,
+				      enum dpll_pin_state *state,
+				      struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	*state = pd->state_dpll;
+	return 0;
+};
+
+static int nsim_pin_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
+				     const struct dpll_pin *parent_pin,
+				     void *parent_priv,
+				     const enum dpll_pin_state state,
+				     struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	pd->state_pin = state;
+	return 0;
+};
+
+static int nsim_pin_state_on_dpll_set(const struct dpll_pin *pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv,
+				      const enum dpll_pin_state state,
+				      struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	pd->state_dpll = state;
+	return 0;
+};
+
+static int nsim_pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
+			     const struct dpll_device *dpll, void *dpll_priv,
+			     u32 *prio, struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	*prio = pd->prio;
+	return 0;
+};
+
+static int nsim_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
+			     const struct dpll_device *dpll, void *dpll_priv,
+			     const u32 prio, struct netlink_ext_ack *extack)
+{
+	struct nsim_pin_priv_data *pd = pin_priv;
+
+	pd->prio = prio;
+	return 0;
+};
+
+static void nsim_free_pin_properties(struct dpll_pin_properties *pp)
+{
+	kfree(pp->board_label);
+	kfree(pp->panel_label);
+	kfree(pp->package_label);
+	kfree(pp->freq_supported);
+}
+
+static struct dpll_device_ops nsim_dds_ops = {
+	.mode_get = nsim_dds_ops_mode_get,
+	.mode_supported = nsim_dds_ops_mode_supported,
+	.lock_status_get = nsim_dds_ops_lock_status_get,
+	.temp_get = nsim_dds_ops_temp_get,
+};
+
+static struct dpll_pin_ops nsim_pin_ops = {
+	.frequency_set = nsim_pin_frequency_set,
+	.frequency_get = nsim_pin_frequency_get,
+	.direction_set = nsim_pin_direction_set,
+	.direction_get = nsim_pin_direction_get,
+	.state_on_pin_get = nsim_pin_state_on_pin_get,
+	.state_on_dpll_get = nsim_pin_state_on_dpll_get,
+	.state_on_pin_set = nsim_pin_state_on_pin_set,
+	.state_on_dpll_set = nsim_pin_state_on_dpll_set,
+	.prio_get = nsim_pin_prio_get,
+	.prio_set = nsim_pin_prio_set,
+};
+
+int nsim_dpll_init_owner(struct nsim_dpll *dpll, unsigned int ports_count)
+{
+	u64 clock_id;
+	int err;
+
+	get_random_bytes(&clock_id, sizeof(clock_id));
+
+	/* Create EEC DPLL */
+	dpll->dpll_e = dpll_device_get(clock_id, EEC_DPLL_DEV, THIS_MODULE);
+	if (IS_ERR(dpll->dpll_e))
+		return -EFAULT;
+
+	dpll->dpll_e_pd.temperature = EEC_DPLL_TEMPERATURE;
+	dpll->dpll_e_pd.mode = DPLL_MODE_AUTOMATIC;
+	dpll->dpll_e_pd.clock_id = clock_id;
+	dpll->dpll_e_pd.status = DPLL_LOCK_STATUS_UNLOCKED;
+
+	err = dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &nsim_dds_ops,
+				   &dpll->dpll_e_pd);
+	if (err)
+		goto e_reg;
+
+	/* Create PPS DPLL */
+	dpll->dpll_p = dpll_device_get(clock_id, PPS_DPLL_DEV, THIS_MODULE);
+	if (IS_ERR(dpll->dpll_p))
+		goto dpll_p;
+
+	dpll->dpll_p_pd.temperature = PPS_DPLL_TEMPERATURE;
+	dpll->dpll_p_pd.mode = DPLL_MODE_MANUAL;
+	dpll->dpll_p_pd.clock_id = clock_id;
+	dpll->dpll_p_pd.status = DPLL_LOCK_STATUS_UNLOCKED;
+
+	err = dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &nsim_dds_ops,
+				   &dpll->dpll_p_pd);
+	if (err)
+		goto p_reg;
+
+	/* Create first pin (GNSS) */
+	err = nsim_fill_pin_properties(&dpll->pp_gnss, "GNSS",
+				       DPLL_PIN_TYPE_GNSS,
+				       PIN_GNSS_CAPABILITIES, 1,
+				       DPLL_PIN_FREQUENCY_1_HZ,
+				       DPLL_PIN_FREQUENCY_1_HZ);
+	if (err)
+		goto pp_gnss;
+	dpll->p_gnss =
+		dpll_pin_get(clock_id, PIN_GNSS, THIS_MODULE, &dpll->pp_gnss);
+	if (IS_ERR(dpll->p_gnss))
+		goto p_gnss;
+	nsim_fill_pin_pd(&dpll->p_gnss_pd, DPLL_PIN_FREQUENCY_1_HZ,
+			 PIN_GNSS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
+	err = dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
+				&dpll->p_gnss_pd);
+	if (err)
+		goto e_gnss_reg;
+
+	/* Create second pin (PPS) */
+	err = nsim_fill_pin_properties(&dpll->pp_pps, "PPS", DPLL_PIN_TYPE_EXT,
+				       PIN_PPS_CAPABILITIES, 1,
+				       DPLL_PIN_FREQUENCY_1_HZ,
+				       DPLL_PIN_FREQUENCY_1_HZ);
+	if (err)
+		goto pp_pps;
+	dpll->p_pps =
+		dpll_pin_get(clock_id, PIN_PPS, THIS_MODULE, &dpll->pp_pps);
+	if (IS_ERR(dpll->p_pps)) {
+		err = -EFAULT;
+		goto p_pps;
+	}
+	nsim_fill_pin_pd(&dpll->p_pps_pd, DPLL_PIN_FREQUENCY_1_HZ,
+			 PIN_PPS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
+	err = dpll_pin_register(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
+				&dpll->p_pps_pd);
+	if (err)
+		goto e_pps_reg;
+	err = dpll_pin_register(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
+				&dpll->p_pps_pd);
+	if (err)
+		goto p_pps_reg;
+
+	dpll->pp_rclk =
+		kcalloc(ports_count, sizeof(*dpll->pp_rclk), GFP_KERNEL);
+	dpll->p_rclk = kcalloc(ports_count, sizeof(*dpll->p_rclk), GFP_KERNEL);
+	dpll->p_rclk_pd =
+		kcalloc(ports_count, sizeof(*dpll->p_rclk_pd), GFP_KERNEL);
+
+	return 0;
+
+p_pps_reg:
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
+			    &dpll->p_pps_pd);
+e_pps_reg:
+	dpll_pin_put(dpll->p_pps);
+p_pps:
+	nsim_free_pin_properties(&dpll->pp_pps);
+pp_pps:
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
+			    &dpll->p_gnss_pd);
+e_gnss_reg:
+	dpll_pin_put(dpll->p_gnss);
+p_gnss:
+	nsim_free_pin_properties(&dpll->pp_gnss);
+pp_gnss:
+	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
+p_reg:
+	dpll_device_put(dpll->dpll_p);
+dpll_p:
+	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
+e_reg:
+	dpll_device_put(dpll->dpll_e);
+	return err;
+}
+
+void nsim_dpll_free_owner(struct nsim_dpll *dpll)
+{
+	/* Free GNSS pin */
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
+			    &dpll->p_gnss_pd);
+	dpll_pin_put(dpll->p_gnss);
+	nsim_free_pin_properties(&dpll->pp_gnss);
+
+	/* Free PPS pin */
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
+			    &dpll->p_pps_pd);
+	dpll_pin_unregister(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
+			    &dpll->p_pps_pd);
+	dpll_pin_put(dpll->p_pps);
+	nsim_free_pin_properties(&dpll->pp_pps);
+
+	/* Free DPLL EEC */
+	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
+	dpll_device_put(dpll->dpll_e);
+
+	/* Free DPLL PPS */
+	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
+	dpll_device_put(dpll->dpll_p);
+
+	kfree(dpll->pp_rclk);
+	kfree(dpll->p_rclk);
+	kfree(dpll->p_rclk_pd);
+}
+
+int nsim_rclk_init(struct netdevsim *ns)
+{
+	struct nsim_dpll *dpll;
+	unsigned int index;
+	char *name;
+	int err;
+
+	index = ns->nsim_dev_port->port_index;
+	dpll = &ns->nsim_dev->dpll;
+	err = -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "RCLK_%i", index);
+	if (!name)
+		goto err;
+
+	/* Get EEC DPLL */
+	if (IS_ERR(dpll->dpll_e))
+		goto dpll;
+
+	/* Get PPS DPLL */
+	if (IS_ERR(dpll->dpll_p))
+		goto dpll;
+
+	/* Create Recovered clock pin (RCLK) */
+	nsim_fill_pin_properties(&dpll->pp_rclk[index], name,
+				 DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+				 PIN_RCLK_CAPABILITIES, 1, 1e6, 125e6);
+	dpll->p_rclk[index] = dpll_pin_get(dpll->dpll_e_pd.clock_id,
+					   PIN_RCLK + index, THIS_MODULE,
+					   &dpll->pp_rclk[index]);
+	if (IS_ERR(dpll->p_rclk[index]))
+		goto p_rclk;
+	nsim_fill_pin_pd(&dpll->p_rclk_pd[index], DPLL_PIN_FREQUENCY_10_MHZ,
+			 PIN_RCLK_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
+	err = dpll_pin_register(dpll->dpll_e, dpll->p_rclk[index],
+				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
+	if (err)
+		goto dpll_e_reg;
+	err = dpll_pin_register(dpll->dpll_p, dpll->p_rclk[index],
+				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
+	if (err)
+		goto dpll_p_reg;
+
+	netdev_dpll_pin_set(ns->netdev, dpll->p_rclk[index]);
+
+	kfree(name);
+	return 0;
+
+dpll_p_reg:
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
+			    &dpll->p_rclk_pd[index]);
+dpll_e_reg:
+	dpll_pin_put(dpll->p_rclk[index]);
+p_rclk:
+	nsim_free_pin_properties(&dpll->pp_rclk[index]);
+dpll:
+	kfree(name);
+err:
+	return err;
+}
+
+void nsim_rclk_free(struct netdevsim *ns)
+{
+	struct nsim_dpll *dpll;
+	unsigned int index;
+
+	index = ns->nsim_dev_port->port_index;
+	dpll = &ns->nsim_dev->dpll;
+
+	if (IS_ERR(dpll->dpll_e))
+		return;
+
+	if (IS_ERR(dpll->dpll_p))
+		return;
+
+	/* Free RCLK pin */
+	netdev_dpll_pin_clear(ns->netdev);
+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
+			    &dpll->p_rclk_pd[index]);
+	dpll_pin_unregister(dpll->dpll_p, dpll->p_rclk[index], &nsim_pin_ops,
+			    &dpll->p_rclk_pd[index]);
+	dpll_pin_put(dpll->p_rclk[index]);
+	nsim_free_pin_properties(&dpll->pp_rclk[index]);
+}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..3c604d8608a3 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -344,8 +344,15 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	err = nsim_rclk_init(ns);
+	if (err)
+		goto err_netdevice_unregister;
+
 	return 0;
 
+err_netdevice_unregister:
+	unregister_netdevice(ns->netdev);
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
@@ -419,6 +426,9 @@ void nsim_destroy(struct netdevsim *ns)
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_udp_tunnels_info_destroy(dev);
 	mock_phc_destroy(ns->phc);
+
+	nsim_rclk_free(ns);
+
 	free_netdev(dev);
 }
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 028c825b86db..bd798a4cf49f 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -25,6 +25,8 @@
 #include <net/udp_tunnel.h>
 #include <net/xdp.h>
 #include <net/macsec.h>
+#include <linux/dpll.h>
+#include <linux/random.h>
 
 #define DRV_NAME	"netdevsim"
 
@@ -90,6 +92,42 @@ struct nsim_ethtool {
 	struct ethtool_fecparam fec;
 };
 
+struct nsim_dpll_priv_data {
+	enum dpll_mode mode;
+	int temperature;
+	u64 clock_id;
+	enum dpll_lock_status status;
+};
+
+struct nsim_pin_priv_data {
+	u64 frequency;
+	enum dpll_pin_direction direction;
+	enum dpll_pin_state state_pin;
+	enum dpll_pin_state state_dpll;
+	u32 prio;
+};
+
+struct nsim_dpll {
+	bool owner;
+
+	struct dpll_device *dpll_e;
+	struct nsim_dpll_priv_data dpll_e_pd;
+	struct dpll_device *dpll_p;
+	struct nsim_dpll_priv_data dpll_p_pd;
+
+	struct dpll_pin_properties pp_gnss;
+	struct dpll_pin *p_gnss;
+	struct nsim_pin_priv_data p_gnss_pd;
+
+	struct dpll_pin_properties pp_pps;
+	struct dpll_pin *p_pps;
+	struct nsim_pin_priv_data p_pps_pd;
+
+	struct dpll_pin_properties *pp_rclk;
+	struct dpll_pin **p_rclk;
+	struct nsim_pin_priv_data *p_rclk_pd;
+};
+
 struct netdevsim {
 	struct net_device *netdev;
 	struct nsim_dev *nsim_dev;
@@ -323,6 +361,7 @@ struct nsim_dev {
 	} udp_ports;
 	struct nsim_dev_psample *psample;
 	u16 esw_mode;
+	struct nsim_dpll dpll;
 };
 
 static inline bool nsim_esw_mode_is_legacy(struct nsim_dev *nsim_dev)
@@ -415,5 +454,10 @@ struct nsim_bus_dev {
 	bool init;
 };
 
+int nsim_dpll_init_owner(struct nsim_dpll *dpll, unsigned int ports_count);
+void nsim_dpll_free_owner(struct nsim_dpll *dpll);
+int nsim_rclk_init(struct netdevsim *ns);
+void nsim_rclk_free(struct netdevsim *ns);
+
 int nsim_bus_init(void);
 void nsim_bus_exit(void);
-- 
2.39.3


