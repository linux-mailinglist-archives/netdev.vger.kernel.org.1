Return-Path: <netdev+bounces-61491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8C82405F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77328B24002
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8F210F6;
	Thu,  4 Jan 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQjL22pD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8A210FD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704366904; x=1735902904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XOhGLMUyKxzJIQfIMJsbRvqzm/9eSEzz5pvJ33vXmTo=;
  b=QQjL22pDwmMDfCuPt9z4jWFyNjFHDCq6NdOspproPo4q4C1zkjAHHgfI
   GqN7VayJmBeL0SCvDpUgdz/clZqW6JAqeAxWmBavf+uXH9CLVKhpUlcMU
   velba1pOzEr4upN6h2KgIGuBfVvCgzlwve88fNcREy0gP89Y0wrEaxPu7
   WPKe++OMojNJnY+KaZt30aSQuRBHPnDe89loABhniTnKm9y6HhxKZM8Z2
   WOKa/DLBvvzlp4dW6vCjdiTBOyIDeySq0amtu+ur7SxvWYDw/5LvlBbTD
   oxobf4GHR8w/rHuZ65s5izHQuqCKKt1o+iE93cGWbRjLZbwXsdLFsSpsB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="382174431"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="382174431"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027391564"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1027391564"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2024 03:15:02 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	michal.michalik@intel.com,
	milena.olech@intel.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v2 2/4] dpll: fix pin dump crash for rebound module
Date: Thu,  4 Jan 2024 12:11:30 +0100
Message-Id: <20240104111132.42730-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kernel module is unbound but the pin resources were not entirely
freed (other kernel module instance have had kept the reference to that
pin), and kernel module is again bound, the pin properties would not be
updated (the properties are only assigned when memory for the pin is
allocated), prop pointer still points to the kernel module memory of
the kernel module which was deallocated on the unbind.

If the pin dump is invoked in this state, the result is a kernel crash.
Prevent the crash by storing persistent pin properties in dpll subsystem,
copy the content from the kernel module when pin is allocated, instead of
using memory of the kernel module.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_core.c    | 29 ++++++++++++++++++++++++++---
 drivers/dpll/dpll_core.h    |  4 ++--
 drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3568149b9562..0b469096ef79 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -429,6 +429,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	       const struct dpll_pin_properties *prop)
 {
 	struct dpll_pin *pin;
+	size_t freq_size;
 	int ret;
 
 	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
@@ -440,9 +441,22 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
-		goto err;
+		goto pin_free;
 	}
-	pin->prop = prop;
+	memcpy(&pin->prop, prop, sizeof(pin->prop));
+	if (prop->freq_supported && prop->freq_supported_num) {
+		freq_size = prop->freq_supported_num *
+			    sizeof(*pin->prop.freq_supported);
+		pin->prop.freq_supported = kmemdup(prop->freq_supported,
+						   freq_size, GFP_KERNEL);
+		if (!pin->prop.freq_supported) {
+			ret = -ENOMEM;
+			goto pin_free;
+		}
+	}
+	pin->prop.board_label = kstrdup(prop->board_label, GFP_KERNEL);
+	pin->prop.panel_label = kstrdup(prop->panel_label, GFP_KERNEL);
+	pin->prop.package_label = kstrdup(prop->package_label, GFP_KERNEL);
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
@@ -451,8 +465,13 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 		goto err;
 	return pin;
 err:
+	kfree(pin->prop.package_label);
+	kfree(pin->prop.panel_label);
+	kfree(pin->prop.board_label);
+	kfree(pin->prop.freq_supported);
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
+pin_free:
 	kfree(pin);
 	return ERR_PTR(ret);
 }
@@ -512,6 +531,10 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->dpll_refs);
 		xa_destroy(&pin->parent_refs);
 		xa_erase(&dpll_pin_xa, pin->id);
+		kfree(pin->prop.board_label);
+		kfree(pin->prop.panel_label);
+		kfree(pin->prop.package_label);
+		kfree(pin->prop.freq_supported);
 		kfree(pin);
 	}
 	mutex_unlock(&dpll_lock);
@@ -634,7 +657,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i, stop;
 	int ret;
 
-	if (WARN_ON(parent->prop->type != DPLL_PIN_TYPE_MUX))
+	if (WARN_ON(parent->prop.type != DPLL_PIN_TYPE_MUX))
 		return -EINVAL;
 
 	if (WARN_ON(!ops) ||
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 5585873c5c1b..717f715015c7 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -44,7 +44,7 @@ struct dpll_device {
  * @module:		module of creator
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
- * @prop:		pointer to pin properties given by registerer
+ * @prop:		pin properties copied from the registerer
  * @rclk_dev_name:	holds name of device when pin can recover clock from it
  * @refcount:		refcount
  **/
@@ -55,7 +55,7 @@ struct dpll_pin {
 	struct module *module;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
-	const struct dpll_pin_properties *prop;
+	struct dpll_pin_properties prop;
 	refcount_t refcount;
 };
 
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index b53478374a38..3ce9995013f1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
 			  DPLL_A_PIN_PAD))
 		return -EMSGSIZE;
-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++) {
 		nest = nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
 		if (!nest)
 			return -EMSGSIZE;
-		freq = pin->prop->freq_supported[fs].min;
+		freq = pin->prop.freq_supported[fs].min;
 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
 				  &freq, DPLL_A_PIN_PAD)) {
 			nla_nest_cancel(msg, nest);
 			return -EMSGSIZE;
 		}
-		freq = pin->prop->freq_supported[fs].max;
+		freq = pin->prop.freq_supported[fs].max;
 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
 				  &freq, DPLL_A_PIN_PAD)) {
 			nla_nest_cancel(msg, nest);
@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
 {
 	int fs;
 
-	for (fs = 0; fs < pin->prop->freq_supported_num; fs++)
-		if (freq >= pin->prop->freq_supported[fs].min &&
-		    freq <= pin->prop->freq_supported[fs].max)
+	for (fs = 0; fs < pin->prop.freq_supported_num; fs++)
+		if (freq >= pin->prop.freq_supported[fs].min &&
+		    freq <= pin->prop.freq_supported[fs].max)
 			return true;
 	return false;
 }
@@ -398,7 +398,7 @@ static int
 dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 		     struct netlink_ext_ack *extack)
 {
-	const struct dpll_pin_properties *prop = pin->prop;
+	const struct dpll_pin_properties *prop = &pin->prop;
 	struct dpll_pin_ref *ref;
 	int ret;
 
@@ -691,7 +691,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -727,7 +727,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -754,7 +754,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -782,7 +782,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
 	int ret;
 
 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
-	      pin->prop->capabilities)) {
+	      pin->prop.capabilities)) {
 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -812,8 +812,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	int ret;
 
 	phase_adj = nla_get_s32(phase_adj_attr);
-	if (phase_adj > pin->prop->phase_range.max ||
-	    phase_adj < pin->prop->phase_range.min) {
+	if (phase_adj > pin->prop.phase_range.max ||
+	    phase_adj < pin->prop.phase_range.min) {
 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
 				    "phase adjust value not supported");
 		return -EINVAL;
@@ -997,7 +997,7 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
 	unsigned long i;
 
 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
-		prop = pin->prop;
+		prop = &pin->prop;
 		cid_match = clock_id ? pin->clock_id == clock_id : true;
 		mod_match = mod_name_attr && module_name(pin->module) ?
 			!nla_strcmp(mod_name_attr,
-- 
2.38.1


