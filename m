Return-Path: <netdev+bounces-28515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACB77FAA8
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4894282034
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6085154A7;
	Thu, 17 Aug 2023 15:24:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC91548B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:24:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C8E55;
	Thu, 17 Aug 2023 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692285857; x=1723821857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HEUpET1bGjXyNVxq333FmKP9AFVYCQzhhjT7Z4aPAgQ=;
  b=CnI8NXz759x86ba6/MwJTOLXcEGa9gZt4kvwxNxQck/VkfGff1oXIk+A
   mBLHfAw9PEu4P8b5ZJmJjFdfSk9zptjSAfk5JvxhoYVK16olKNpyUO7zP
   VrEpPHRArMeuglE7cQCQMqS1OjJ9sMb1BP4Q9nwcNxmpFWnnfldIrtAio
   ArWrGzN8wvmtbUqfnwOU31xi+96+bXwsDvXOnruQETg3JrNvX3wuWCB6S
   yig7e2UnClWfnd8mBq6oRKhMVBvw4yecsfsDlqmrcCOQU6n2IKzG2iopD
   82bqrr8s89bQlJelpDVyzYwVqjQBHUC9IcBapM/lsjSiX/4RRrfvW73Nt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436758756"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436758756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734694126"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734694126"
Received: from mmichali-devpc.igk.intel.com ([10.211.235.239])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 08:24:13 -0700
From: Michal Michalik <michal.michalik@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	poros@redhat.com,
	milena.olech@intel.com,
	mschmidt@redhat.com,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH RFC net-next v1 1/2] selftests/dpll: add DPLL module for integration selftests
Date: Thu, 17 Aug 2023 17:22:08 +0200
Message-Id: <20230817152209.23868-2-michal.michalik@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20230817152209.23868-1-michal.michalik@intel.com>
References: <20230817152209.23868-1-michal.michalik@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

DPLL subsystem integration tests require a fake module which mimics the
behavior of real driver which supports DPLL hardware. To fully test the
subsystem two modules are added: dpll_test and dpll_test_other. Modules
while system selftesting are loaded in different order to verify the
logic implemented in DPLL subsystem.

Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 tools/testing/selftests/dpll/dpll_modules/Makefile |  12 +
 .../selftests/dpll/dpll_modules/dpll_helpers.c     | 259 +++++++++++++++++++++
 .../selftests/dpll/dpll_modules/dpll_test.c        | 148 ++++++++++++
 .../selftests/dpll/dpll_modules/dpll_test.h        |  38 +++
 .../selftests/dpll/dpll_modules/dpll_test_other.c  |  93 ++++++++
 .../selftests/dpll/dpll_modules/dpll_test_other.h  |  27 +++
 tools/testing/selftests/dpll/modules_handler.sh    |  79 +++++++
 7 files changed, 656 insertions(+)
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/Makefile
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/dpll_helpers.c
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/dpll_test.c
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/dpll_test.h
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/dpll_test_other.c
 create mode 100644 tools/testing/selftests/dpll/dpll_modules/dpll_test_other.h
 create mode 100755 tools/testing/selftests/dpll/modules_handler.sh

diff --git a/tools/testing/selftests/dpll/dpll_modules/Makefile b/tools/testing/selftests/dpll/dpll_modules/Makefile
new file mode 100644
index 0000000..d2816cd
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/Makefile
@@ -0,0 +1,12 @@
+ifndef KSRC
+	KSRC:=${shell git rev-parse --show-toplevel}
+endif
+
+obj-m += dpll_test.o
+obj-m += dpll_test_other.o
+
+all:
+	make -C $(KSRC) M=$(PWD) modules
+
+clean:
+	make -C $(KSRC) M=$(PWD) clean
diff --git a/tools/testing/selftests/dpll/dpll_modules/dpll_helpers.c b/tools/testing/selftests/dpll/dpll_modules/dpll_helpers.c
new file mode 100644
index 0000000..c73fbd3
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/dpll_helpers.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+
+struct dpll_pd {
+	enum dpll_mode mode;
+	int temperature;
+};
+
+struct pin_pd {
+	u64 frequency;
+	enum dpll_pin_direction direction;
+	enum dpll_pin_state state_pin;
+	enum dpll_pin_state state_dpll;
+	u32 prio;
+};
+
+static struct dpll_pin_properties *
+create_pin_properties(const char *label, enum dpll_pin_type type,
+		      unsigned long caps, u32 freq_supp_num, u64 fmin, u64 fmax)
+{
+	struct dpll_pin_frequency *freq_supp;
+	struct dpll_pin_properties *pp;
+
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return pp;
+
+	freq_supp = kzalloc(sizeof(*freq_supp), GFP_KERNEL);
+	if (!pp)
+		goto err;
+	*freq_supp =
+		(struct dpll_pin_frequency)DPLL_PIN_FREQUENCY_RANGE(fmin, fmax);
+
+	pp->board_label = kasprintf(GFP_KERNEL, "%s_brd", label);
+	pp->panel_label = kasprintf(GFP_KERNEL, "%s_pnl", label);
+	pp->package_label = kasprintf(GFP_KERNEL, "%s_pcg", label);
+	pp->freq_supported_num = freq_supp_num;
+	pp->freq_supported = freq_supp;
+	pp->capabilities = caps;
+	pp->type = type;
+
+	return pp;
+err:
+	kfree(pp);
+	return NULL;
+}
+
+static struct dpll_pd *create_dpll_pd(int temperature, enum dpll_mode mode)
+{
+	struct dpll_pd *pd;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return pd;
+
+	pd->temperature = temperature;
+	pd->mode = mode;
+
+	return pd;
+}
+
+static struct pin_pd *create_pin_pd(u64 frequency, u32 prio,
+				    enum dpll_pin_direction direction)
+{
+	struct pin_pd *pd;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return pd;
+
+	pd->state_dpll = DPLL_PIN_STATE_DISCONNECTED;
+	pd->state_pin = DPLL_PIN_STATE_DISCONNECTED;
+	pd->frequency = frequency;
+	pd->direction = direction;
+	pd->prio = prio;
+
+	return pd;
+}
+
+static int
+dds_ops_mode_get(const struct dpll_device *dpll, void *dpll_priv,
+		 enum dpll_mode *mode, struct netlink_ext_ack *extack)
+{
+	*mode = ((struct dpll_pd *)(dpll_priv))->mode;
+	return 0;
+};
+
+static bool
+dds_ops_mode_supported(const struct dpll_device *dpll, void *dpll_priv,
+		       const enum dpll_mode mode,
+		       struct netlink_ext_ack *extack)
+{
+	return true;
+};
+
+static int
+dds_ops_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
+			enum dpll_lock_status *status,
+			struct netlink_ext_ack *extack)
+{
+	if (((struct dpll_pd *)dpll_priv)->mode == DPLL_MODE_MANUAL)
+		*status = DPLL_LOCK_STATUS_LOCKED;
+	else
+		*status = DPLL_LOCK_STATUS_UNLOCKED;
+	return 0;
+};
+
+static int
+dds_ops_temp_get(const struct dpll_device *dpll, void *dpll_priv, s32 *temp,
+		 struct netlink_ext_ack *extack)
+{
+	*temp = ((struct dpll_pd *)dpll_priv)->temperature;
+	return 0;
+};
+
+
+static int
+pin_frequency_set(const struct dpll_pin *pin, void *pin_priv,
+		  const struct dpll_device *dpll, void *dpll_priv,
+		  const u64 frequency, struct netlink_ext_ack *extack)
+{
+	((struct pin_pd *)pin_priv)->frequency = frequency;
+	return 0;
+};
+
+static int
+pin_frequency_get(const struct dpll_pin *pin, void *pin_priv,
+		  const struct dpll_device *dpll, void *dpll_priv,
+		  u64 *frequency, struct netlink_ext_ack *extack)
+{
+	*frequency = ((struct pin_pd *)pin_priv)->frequency;
+	return 0;
+};
+
+static int
+pin_direction_set(const struct dpll_pin *pin, void *pin_priv,
+		  const struct dpll_device *dpll, void *dpll_priv,
+		  const enum dpll_pin_direction direction,
+		  struct netlink_ext_ack *extack)
+{
+	((struct pin_pd *)pin_priv)->direction = direction;
+	return 0;
+};
+
+static int
+pin_direction_get(const struct dpll_pin *pin, void *pin_priv,
+		  const struct dpll_device *dpll, void *dpll_priv,
+		  enum dpll_pin_direction *direction,
+		  struct netlink_ext_ack *extack)
+{
+	*direction = ((struct pin_pd *)pin_priv)->direction;
+	return 0;
+};
+
+static int
+pin_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
+		     const struct dpll_pin *parent_pin, void *parent_priv,
+		     enum dpll_pin_state *state,
+		     struct netlink_ext_ack *extack)
+{
+	*state = ((struct pin_pd *)pin_priv)->state_pin;
+	return 0;
+};
+
+static int
+pin_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
+		      const struct dpll_device *dpll, void *dpll_priv,
+		      enum dpll_pin_state *state,
+		      struct netlink_ext_ack *extack)
+{
+	*state = ((struct pin_pd *)pin_priv)->state_dpll;
+	return 0;
+};
+
+static int
+pin_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
+		     const struct dpll_pin *parent_pin, void *parent_priv,
+		     const enum dpll_pin_state state,
+		     struct netlink_ext_ack *extack)
+{
+	((struct pin_pd *)pin_priv)->state_pin = state;
+	return 0;
+};
+
+static int
+pin_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
+		      const struct dpll_device *dpll, void *dpll_priv,
+		      const enum dpll_pin_state state,
+		      struct netlink_ext_ack *extack)
+{
+	((struct pin_pd *)pin_priv)->state_dpll = state;
+	return 0;
+};
+
+static int
+pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
+	     const struct dpll_device *dpll, void *dpll_priv,
+	     u32 *prio, struct netlink_ext_ack *extack)
+{
+	*prio = ((struct pin_pd *)pin_priv)->prio;
+	return 0;
+};
+
+static int
+pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
+	     const struct dpll_device *dpll, void *dpll_priv,
+	     const u32 prio, struct netlink_ext_ack *extack)
+{
+	((struct pin_pd *)pin_priv)->prio = prio;
+	return 0;
+};
+
+static void
+free_pin_data(struct dpll_pin_properties *pp, void *pd)
+{
+	/* Free pin properties */
+	if (pp) {
+		kfree(pp->board_label);
+		kfree(pp->panel_label);
+		kfree(pp->package_label);
+		kfree(pp->freq_supported);
+		kfree(pp);
+	}
+
+	/* Free pin private data */
+	kfree(pd);
+}
+
+struct bus_type bus = {
+	.name = DPLLS_BUS_NAME
+};
+
+struct device dev = {
+	.init_name = DPLLS_DEV_NAME,
+	.bus = &bus
+};
+
+struct dpll_device_ops dds_ops = {
+	.mode_get = dds_ops_mode_get,
+	.mode_supported = dds_ops_mode_supported,
+	.lock_status_get = dds_ops_lock_status_get,
+	.temp_get = dds_ops_temp_get,
+};
+
+struct dpll_pin_ops pin_ops = {
+	.frequency_set = pin_frequency_set,
+	.frequency_get = pin_frequency_get,
+	.direction_set = pin_direction_set,
+	.direction_get = pin_direction_get,
+	.state_on_pin_get = pin_state_on_pin_get,
+	.state_on_dpll_get = pin_state_on_dpll_get,
+	.state_on_pin_set = pin_state_on_pin_set,
+	.state_on_dpll_set = pin_state_on_dpll_set,
+	.prio_get = pin_prio_get,
+	.prio_set = pin_prio_set,
+};
diff --git a/tools/testing/selftests/dpll/dpll_modules/dpll_test.c b/tools/testing/selftests/dpll/dpll_modules/dpll_test.c
new file mode 100644
index 0000000..afbdfac
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/dpll_test.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Michal Michalik");
+MODULE_DESCRIPTION("DPLL interface test driver");
+MODULE_LICENSE("GPL");
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+#include <linux/dpll.h>
+#include <uapi/linux/dpll.h>
+
+#include "dpll_test.h"
+#include "dpll_helpers.c"
+
+struct dpll_device *dpll_e;
+struct dpll_pd *dpll_e_pd;
+struct dpll_device *dpll_p;
+struct dpll_pd *dpll_p_pd;
+
+struct dpll_pin_properties *pp_gnss;
+struct dpll_pin *p_gnss;
+struct pin_pd *p_gnss_pd;
+
+struct dpll_pin_properties *pp_pps;
+struct dpll_pin *p_pps;
+struct pin_pd *p_pps_pd;
+
+struct dpll_pin_properties *pp_rclk;
+struct dpll_pin *p_rclk;
+struct pin_pd *p_rclk_pd;
+
+
+static int __init custom_init(void)
+{
+	/* Create EEC DPLL */
+	dpll_e = dpll_device_get(DPLLS_CLOCK_ID, EEC_DPLL_DEV, THIS_MODULE);
+	dpll_e_pd = create_dpll_pd(EEC_DPLL_TEMPERATURE, DPLL_MODE_AUTOMATIC);
+	if (dpll_device_register(dpll_e, DPLL_TYPE_EEC, &dds_ops,
+				 (void *) dpll_e_pd))
+		goto ret;
+
+	/* Create PPS DPLL */
+	dpll_p = dpll_device_get(DPLLS_CLOCK_ID, PPS_DPLL_DEV, THIS_MODULE);
+	dpll_p_pd = create_dpll_pd(PPS_DPLL_TEMPERATURE, DPLL_MODE_MANUAL);
+	if (dpll_device_register(dpll_p, DPLL_TYPE_PPS, &dds_ops,
+				 (void *) dpll_p_pd))
+		goto f_eec;
+
+	/* Create first pin (GNSS) */
+	pp_gnss = create_pin_properties("GNSS", DPLL_PIN_TYPE_GNSS,
+					PIN_GNSS_CAPABILITIES,
+					1, DPLL_PIN_FREQUENCY_1_HZ,
+					DPLL_PIN_FREQUENCY_1_HZ);
+	p_gnss = dpll_pin_get(DPLLS_CLOCK_ID, PIN_GNSS, THIS_MODULE, pp_gnss);
+	p_gnss_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ, PIN_GNSS_PRIORITY,
+				  DPLL_PIN_DIRECTION_INPUT);
+	if (dpll_pin_register(dpll_e, p_gnss, &pin_ops, (void *)p_gnss_pd))
+		goto f_dplls;
+
+	/* Create second pin (PPS) */
+	pp_pps = create_pin_properties("PPS", DPLL_PIN_TYPE_EXT,
+					PIN_PPS_CAPABILITIES,
+					1, DPLL_PIN_FREQUENCY_1_HZ,
+					DPLL_PIN_FREQUENCY_1_HZ);
+	p_pps = dpll_pin_get(DPLLS_CLOCK_ID, PIN_PPS, THIS_MODULE, pp_pps);
+	p_pps_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ, PIN_PPS_PRIORITY,
+				  DPLL_PIN_DIRECTION_INPUT);
+	if (dpll_pin_register(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd))
+		goto f_gnss;
+	if (dpll_pin_register(dpll_p, p_pps, &pin_ops, (void *)p_pps_pd))
+		goto f_pps_e;
+
+	/* Create third pin (RCLK) */
+	pp_rclk = create_pin_properties("RCLK", DPLL_PIN_TYPE_SYNCE_ETH_PORT,
+					PIN_RCLK_CAPABILITIES, 1, 1e6, 125e6);
+	p_rclk = dpll_pin_get(DPLLS_CLOCK_ID, PIN_RCLK, THIS_MODULE, pp_rclk);
+	p_rclk_pd = create_pin_pd(DPLL_PIN_FREQUENCY_10_MHZ, PIN_RCLK_PRIORITY,
+				  DPLL_PIN_DIRECTION_INPUT);
+	if (dpll_pin_register(dpll_e, p_rclk, &pin_ops, (void *)p_rclk_pd))
+		goto f_pps_p;
+	if (dpll_pin_register(dpll_p, p_rclk, &pin_ops, (void *)p_rclk_pd))
+		goto f_all;
+
+	return 0;
+f_all:
+	dpll_pin_unregister(dpll_e, p_rclk, &pin_ops, (void *)p_rclk_pd);
+f_pps_p:
+	dpll_pin_unregister(dpll_p, p_pps, &pin_ops, (void *)p_pps_pd);
+f_pps_e:
+	dpll_pin_unregister(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_put(p_pps);
+	free_pin_data(pp_pps, (void *)p_pps_pd);
+f_gnss:
+	dpll_pin_unregister(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_unregister(dpll_p, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_put(p_pps);
+	free_pin_data(pp_pps, (void *)p_pps_pd);
+f_dplls:
+	dpll_device_unregister(dpll_p, &dds_ops, (void *) dpll_p_pd);
+	dpll_device_put(dpll_p);
+	kfree(dpll_p_pd);
+f_eec:
+	dpll_device_unregister(dpll_e, &dds_ops, (void *) dpll_e_pd);
+	dpll_device_put(dpll_e);
+	kfree(dpll_e_pd);
+ret:
+	return -1;
+}
+
+static void __exit custom_exit(void)
+{
+	/* Free GNSS pin */
+	dpll_pin_unregister(dpll_e, p_gnss, &pin_ops, (void *)p_gnss_pd);
+	dpll_pin_put(p_gnss);
+	free_pin_data(pp_gnss, (void *)p_gnss_pd);
+
+	/* Free PPS pin */
+	dpll_pin_unregister(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_unregister(dpll_p, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_put(p_pps);
+	free_pin_data(pp_pps, (void *)p_pps_pd);
+
+	/* Free RCLK pin */
+	dpll_pin_unregister(dpll_e, p_rclk, &pin_ops, (void *)p_rclk_pd);
+	dpll_pin_unregister(dpll_p, p_rclk, &pin_ops, (void *)p_rclk_pd);
+	dpll_pin_put(p_rclk);
+	free_pin_data(pp_rclk, (void *)p_rclk_pd);
+
+	/* Free DPLL EEC */
+	dpll_device_unregister(dpll_e, &dds_ops, (void *) dpll_e_pd);
+	dpll_device_put(dpll_e);
+	kfree(dpll_e_pd);
+
+	/* Free DPLL PPS */
+	dpll_device_unregister(dpll_p, &dds_ops, (void *) dpll_p_pd);
+	dpll_device_put(dpll_p);
+	kfree(dpll_p_pd);
+}
+
+module_init(custom_init);
+module_exit(custom_exit);
diff --git a/tools/testing/selftests/dpll/dpll_modules/dpll_test.h b/tools/testing/selftests/dpll/dpll_modules/dpll_test.h
new file mode 100644
index 0000000..c43e4c1
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/dpll_test.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+
+#ifndef DPLL_TEST_H
+#define DPLL_TEST_H
+
+#define EEC_DPLL_DEV 0
+#define EEC_DPLL_TEMPERATURE 20
+#define PPS_DPLL_DEV 1
+#define PPS_DPLL_TEMPERATURE 30
+#define DPLLS_CLOCK_ID 234
+#define DPLLS_DEV_NAME "dpll_dev"
+#define DPLLS_BUS_NAME "dpll_bus"
+
+#define PIN_GNSS 0
+#define PIN_GNSS_CAPABILITIES 2 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE */
+#define PIN_GNSS_PRIORITY 5
+
+#define PIN_PPS 1
+#define PIN_PPS_CAPABILITIES 7 /* DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE
+				* || DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
+				* || DPLL_PIN_CAPS_STATE_CAN_CHANGE
+				*/
+#define PIN_PPS_PRIORITY 6
+
+#define PIN_RCLK 2
+#define PIN_RCLK_CAPABILITIES 6 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
+				 * || DPLL_PIN_CAPS_STATE_CAN_CHANGE
+				 */
+#define PIN_RCLK_PRIORITY 7
+
+#define EEC_PINS_NUMBER 3
+#define PPS_PINS_NUMBER 2
+
+#endif /* DPLL_TEST_H */
diff --git a/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.c b/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.c
new file mode 100644
index 0000000..0929d4f
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Michal Michalik");
+MODULE_DESCRIPTION("DPLL interface test driver (second)");
+MODULE_LICENSE("GPL");
+
+#include <linux/types.h>
+#include <linux/netlink.h>
+
+#include <linux/dpll.h>
+#include <uapi/linux/dpll.h>
+
+#include "dpll_test_other.h"
+#include "dpll_helpers.c"
+
+struct dpll_device *dpll_e;
+struct dpll_pd *dpll_e_pd;
+
+struct dpll_pin_properties *pp_gnss;
+struct dpll_pin *p_gnss;
+struct pin_pd *p_gnss_pd;
+
+struct dpll_pin_properties *pp_pps;
+struct dpll_pin *p_pps;
+struct pin_pd *p_pps_pd;
+
+static int __init custom_init(void)
+{
+	/* Create EEC DPLL */
+	dpll_e = dpll_device_get(DPLLS_CLOCK_ID, DPLL_1_DEV, THIS_MODULE);
+	dpll_e_pd = create_dpll_pd(DPLLS_TEMPERATURE, DPLL_MODE_AUTOMATIC);
+	if (dpll_device_register(dpll_e, DPLL_TYPE_EEC, &dds_ops,
+				 (void *) dpll_e_pd))
+		goto ret;
+
+	/* Create first pin (GNSS) */
+	pp_gnss = create_pin_properties("GNSS", DPLL_PIN_TYPE_GNSS,
+					PIN_GNSS_CAPABILITIES, 1, 1, 1);
+	p_gnss = dpll_pin_get(DPLLS_CLOCK_ID, PIN_GNSS, THIS_MODULE, pp_gnss);
+	p_gnss_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ, PIN_GNSS_PRIORITY,
+				  DPLL_PIN_DIRECTION_INPUT);
+	if (dpll_pin_register(dpll_e, p_gnss, &pin_ops, (void *)p_gnss_pd))
+		goto f_eec;
+
+	/* Create second pin (PPS) */
+	pp_pps = create_pin_properties("PPS", DPLL_PIN_TYPE_EXT,
+					PIN_PPS_CAPABILITIES, 1, 1, 1);
+	p_pps = dpll_pin_get(DPLLS_CLOCK_ID, PIN_PPS, THIS_MODULE, pp_pps);
+	p_pps_pd = create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ, PIN_PPS_PRIORITY,
+				  DPLL_PIN_DIRECTION_INPUT);
+	if (dpll_pin_register(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd))
+		goto f_gnss;
+
+	return 0;
+f_gnss:
+	dpll_pin_unregister(dpll_e, p_gnss, &pin_ops, (void *)p_gnss_pd);
+	dpll_pin_put(p_gnss);
+	free_pin_data(pp_gnss, (void *)p_gnss_pd);
+f_eec:
+	dpll_device_unregister(dpll_e, &dds_ops, (void *) dpll_e_pd);
+	dpll_device_put(dpll_e);
+	kfree(dpll_e_pd);
+ret:
+	return -1;
+}
+
+static void __exit custom_exit(void)
+{
+
+	/* Free GNSS pin */
+	dpll_pin_unregister(dpll_e, p_gnss, &pin_ops, (void *)p_gnss_pd);
+	dpll_pin_put(p_gnss);
+	free_pin_data(pp_gnss, (void *)p_gnss_pd);
+
+	/* Free PPS pins */
+	dpll_pin_unregister(dpll_e, p_pps, &pin_ops, (void *)p_pps_pd);
+	dpll_pin_put(p_pps);
+	free_pin_data(pp_pps, (void *)p_pps_pd);
+
+	/* Free DPLL EEC */
+	dpll_device_unregister(dpll_e, &dds_ops, (void *) dpll_e_pd);
+	dpll_device_put(dpll_e);
+	kfree(dpll_e_pd);
+}
+
+module_init(custom_init);
+module_exit(custom_exit);
diff --git a/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.h b/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.h
new file mode 100644
index 0000000..9585840
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_modules/dpll_test_other.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Intel Corporation.
+ * Author: Michal Michalik <michal.michalik@intel.com>
+ */
+
+#ifndef DPLL_TEST_OTHER_H
+#define DPLL_TEST_OTHER_H
+
+#define DPLL_1_DEV 2
+#define DPLL_2_DEV 3
+#define DPLLS_CLOCK_ID 678
+#define DPLLS_TEMPERATURE 21
+#define DPLLS_DEV_NAME "dpll_sec_dev"
+#define DPLLS_BUS_NAME "dpll_sec_bus"
+
+#define PIN_GNSS 0
+#define PIN_GNSS_CAPABILITIES 2 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE */
+#define PIN_GNSS_PRIORITY 4
+#define PIN_PPS 1
+#define PIN_PPS_CAPABILITIES 7 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
+				* || DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
+				* || DPLL_PIN_CAPS_STATE_CAN_CHANGE
+				*/
+#define PIN_PPS_PRIORITY 5
+
+#endif /* DPLL_TEST_OTHER_H */
diff --git a/tools/testing/selftests/dpll/modules_handler.sh b/tools/testing/selftests/dpll/modules_handler.sh
new file mode 100755
index 0000000..d8e8116
--- /dev/null
+++ b/tools/testing/selftests/dpll/modules_handler.sh
@@ -0,0 +1,79 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helper script for building, loading and unloading modules used in system
+# integration tests.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+ACTION=${1:-build}
+MODULE_NAME=${2:-dpll_test}
+MODULE_DIR=${3:-dpll_modules}
+KSRC=${KSRC:-$(git rev-parse --show-toplevel)}
+
+build() {
+    # Kernel sources are necessary for the module build
+    if [ -z "$KSRC" ]; then
+        echo "ERROR: Set the KSRC environment variable pointing target kernel source"
+        exit 1
+    fi
+
+    pushd ${MODULE_DIR}
+
+    make clean
+
+    if make; then
+        echo "INFO: Successfully build driver"
+    else
+        echo "ERROR: Failed to build driver"
+        exit 2
+    fi
+
+    popd
+}
+
+load()
+{
+    pushd ${MODULE_DIR}
+
+    if insmod ${MODULE_NAME}.ko; then
+        echo "INFO: Successfully loaded driver"
+    else
+        echo "ERROR: Failed to load driver"
+        exit 3
+    fi
+
+    popd
+}
+
+unload()
+{
+    if rmmod ${MODULE_NAME}; then
+            echo "INFO: Successfully unloaded driver"
+    else
+        echo "ERROR: Failed to unload driver"
+        exit 4
+    fi
+}
+
+case $ACTION in
+    build)
+        echo "INFO: Run build of the $MODULE_DIR/$MODULE_NAME"
+        build
+        ;;
+    load)
+        echo "INFO: Run load of the $MODULE_DIR/$MODULE_NAME"
+        load
+        ;;
+    unload)
+        echo "INFO: Run unload of the $MODULE_DIR/$MODULE_NAME"
+        unload
+        ;;
+    *)
+        echo "ERROR: Bad action: $ACTION"
+        exit 1;
+        ;;
+esac
+
+exit 0
-- 
2.9.5


