Return-Path: <netdev+bounces-37901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EAF7B7B31
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7EF77281568
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE51094E;
	Wed,  4 Oct 2023 09:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080E1094F
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:08:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29FADC;
	Wed,  4 Oct 2023 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410520; x=1727946520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5zVEg/I+Gu2q4wK/C1xI3u6uGivmsKp9MuiUjz4V18=;
  b=c7kcv+bZzqFiZygoRuf/MCLuaNWkC6Aqk1iXRCxb7/u+rqX5Z2FZEyDa
   sxvUeOMDi7J2ClHe90W92mbq5SZMo/ExRlltIqPRU52YfX90ut0fRFu4m
   +1Njb25VvSMzPNOE09NTs91YCaNtRGCDFknXRkFIw8Z39ZaH8kRfN/FNO
   l/6isBu/f292kn80I3IvoN3lGOu/I8CDz26ti091pi+wt2059ukuANWtS
   AnGTdAemMYvVOFfNO2FQTwmtSJS0Gwd+mNIoItgasubqvu9d+BOdMvdNu
   F/DRbrSBYpvmuEic0QXvLJo6OQ3NPw//jIrfNABKwZT6EULBrU+hD7y3Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373448518"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="373448518"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780668475"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="780668475"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2023 02:08:37 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v2 3/5] dpll: netlink/core: add support for pin-dpll signal phase offset/adjust
Date: Wed,  4 Oct 2023 11:05:45 +0200
Message-Id: <20231004090547.1597844-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004090547.1597844-1-arkadiusz.kubalewski@intel.com>
References: <20231004090547.1597844-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add callback ops for pin-dpll phase measurment.
Add callback for pin signal phase adjustment.
Add min and max phase adjustment values to pin proprties.
Invoke callbacks in dpll_netlink.c when filling the pin details to
provide user with phase related attribute values.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 130 +++++++++++++++++++++++++++++++++++-
 include/linux/dpll.h        |  18 +++++
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index e20daba6896a..97319a9e4667 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -212,6 +212,53 @@ dpll_msg_add_pin_direction(struct sk_buff *msg, struct dpll_pin *pin,
 	return 0;
 }
 
+static int
+dpll_msg_add_pin_phase_adjust(struct sk_buff *msg, struct dpll_pin *pin,
+			      struct dpll_pin_ref *ref,
+			      struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	s32 phase_adjust;
+	int ret;
+
+	if (!ops->phase_adjust_get)
+		return 0;
+	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				    dpll, dpll_priv(dpll),
+				    &phase_adjust, extack);
+	if (ret)
+		return ret;
+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST, phase_adjust))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
+			  struct dpll_pin_ref *ref,
+			  struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	s64 phase_offset;
+	int ret;
+
+	if (!ops->phase_offset_get)
+		return 0;
+	ret = ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				    dpll, dpll_priv(dpll), &phase_offset,
+				    extack);
+	if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET, sizeof(phase_offset),
+			  &phase_offset, DPLL_A_PIN_PAD))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
@@ -330,6 +377,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
 		if (ret)
 			goto nest_cancel;
 		ret = dpll_msg_add_pin_direction(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
 		if (ret)
 			goto nest_cancel;
 		nla_nest_end(msg, attr);
@@ -377,6 +427,15 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (nla_put_u32(msg, DPLL_A_PIN_CAPABILITIES, prop->capabilities))
 		return -EMSGSIZE;
 	ret = dpll_msg_add_pin_freq(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
+			prop->phase_range.min))
+		return -EMSGSIZE;
+	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MAX,
+			prop->phase_range.max))
+		return -EMSGSIZE;
+	ret = dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	if (xa_empty(&pin->parent_refs))
@@ -416,7 +475,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
 		return -EMSGSIZE;
 
-	return ret;
+	return 0;
 }
 
 static int
@@ -705,6 +764,70 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
+		       struct netlink_ext_ack *extack)
+{
+	struct dpll_pin_ref *ref, *failed;
+	const struct dpll_pin_ops *ops;
+	s32 phase_adj, old_phase_adj;
+	struct dpll_device *dpll;
+	unsigned long i;
+	int ret;
+
+	phase_adj = nla_get_s32(phase_adj_attr);
+	if (phase_adj > pin->prop->phase_range.max ||
+	    phase_adj < pin->prop->phase_range.min) {
+		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
+		return -EINVAL;
+	}
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		if (!ops->phase_adjust_set || !ops->phase_adjust_get)
+			return -EOPNOTSUPP;
+	}
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ops = dpll_pin_ops(ref);
+	dpll = ref->dpll;
+	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				    dpll, dpll_priv(dpll), &old_phase_adj,
+				    extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get old phase adjust value");
+		return ret;
+	}
+	if (phase_adj == old_phase_adj)
+		return 0;
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		ret = ops->phase_adjust_set(pin,
+					    dpll_pin_on_dpll_priv(dpll, pin),
+					    dpll, dpll_priv(dpll), phase_adj,
+					    extack);
+		if (ret) {
+			failed = ref;
+			goto rollback;
+		}
+	}
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+
+rollback:
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (ref == failed)
+			break;
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+					  dpll, dpll_priv(dpll), old_phase_adj,
+					  extack))
+			NL_SET_ERR_MSG(extack, "set phase adjust rollback failed");
+	}
+	return ret;
+}
+
 static int
 dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr *parent_nest,
 			   struct netlink_ext_ack *extack)
@@ -793,6 +916,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
 			if (ret)
 				return ret;
 			break;
+		case DPLL_A_PIN_PHASE_ADJUST:
+			ret = dpll_pin_phase_adj_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
 		case DPLL_A_PIN_PARENT_DEVICE:
 			ret = dpll_pin_parent_device_set(pin, a, info->extack);
 			if (ret)
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index bbc480cd2932..578fc5fa3750 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -68,6 +68,18 @@ struct dpll_pin_ops {
 	int (*prio_set)(const struct dpll_pin *pin, void *pin_priv,
 			const struct dpll_device *dpll, void *dpll_priv,
 			const u32 prio, struct netlink_ext_ack *extack);
+	int (*phase_offset_get)(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				s64 *phase_offset,
+				struct netlink_ext_ack *extack);
+	int (*phase_adjust_get)(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				s32 *phase_adjust,
+				struct netlink_ext_ack *extack);
+	int (*phase_adjust_set)(const struct dpll_pin *pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				const s32 phase_adjust,
+				struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_frequency {
@@ -91,6 +103,11 @@ struct dpll_pin_frequency {
 #define DPLL_PIN_FREQUENCY_DCF77 \
 	DPLL_PIN_FREQUENCY(DPLL_PIN_FREQUENCY_77_5_KHZ)
 
+struct dpll_pin_phase_adjust_range {
+	s32 min;
+	s32 max;
+};
+
 struct dpll_pin_properties {
 	const char *board_label;
 	const char *panel_label;
@@ -99,6 +116,7 @@ struct dpll_pin_properties {
 	unsigned long capabilities;
 	u32 freq_supported_num;
 	struct dpll_pin_frequency *freq_supported;
+	struct dpll_pin_phase_adjust_range phase_range;
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-- 
2.38.1


