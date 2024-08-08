Return-Path: <netdev+bounces-116802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306B94BC3A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E2C1F21B34
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37B18C349;
	Thu,  8 Aug 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlLAwmKu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AF18C331;
	Thu,  8 Aug 2024 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116288; cv=none; b=AiAsj2LXqt8LRj25e4O/hLi90AWBEwQdGU94wHo25qLmxrnFtQ4y4LBRvtiMEQHfBHLlncbKszcLC505wPoQOfYw/wGJ6d4dVSp+1uGhsvas5brx0VKikmRv70OZGnHhPZyKHHYE/ZSq9u1nF8rlDjqpw3Bd1nqEkec/Ozj+L3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116288; c=relaxed/simple;
	bh=ToxzEmyCBcJQpBYmvNRlzvMnU4ZACv/A5PG2kdgHUgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv5/MnfVi0JFbs+m/dCAwOCUxfQNWYzF+MxWwoxRVFuVosRrGLQeTbm4C99bm5GaRfywDlFn90ntpf8B1E5dldzL93WF6aiccClpDCVG1YBmWyxpSsOXd0Rn2hqnlKl67q46WWxJ/T3/1Oi/ZNJ1hTAOJfWl5JYIXkyD5yugBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlLAwmKu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723116287; x=1754652287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToxzEmyCBcJQpBYmvNRlzvMnU4ZACv/A5PG2kdgHUgg=;
  b=QlLAwmKu9fvs/MQkfSej3y2hT0QRk2yMUevi1fy/6khP74p9FZw5SWM+
   yovMSLnlhQChkEJHoC5qwaE+5XpmLD+dPeBbmLzAu/XnEYVh2ghTXawvK
   fOLEjZ5DesKnp/UCZlcvDh0uvWARnmV7qvb/ugzPy95Wd/uRXfpMB7tst
   1WdtvlzDRD2NGWJ3DrJt3PsgqtZ4PqGDKxtTBp7EBrNifQJBZIPWr0I0Z
   kWf8WkNK04hs5GSEBfKV9c4SjkMkrduQt4cdAtY+OPLqvgbegiivYJqOQ
   34/CKI5kbHeQB0ZsqgZ8X1gzuIS8JME02oFLjh9rVJAiksRIdhiUq7mBF
   w==;
X-CSE-ConnectionGUID: 0sxcPyk8Tcqa21mQvQlchA==
X-CSE-MsgGUID: 1tasa2QgQDKSpN0TJAq3HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38741861"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38741861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:24:46 -0700
X-CSE-ConnectionGUID: OUrqg2QwTmyadfOQcKLlxg==
X-CSE-MsgGUID: 5eKGEh9uQ4i+jP/AYzDZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61574905"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 04:24:43 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v1 1/2] dpll: add Embedded SYNC feature for a pin
Date: Thu,  8 Aug 2024 13:20:12 +0200
Message-Id: <20240808112013.166621-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
References: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement and document new pin attributes for providing Embedded SYNC
capabilities to the DPLL subsystem users through a netlink pin-get
do/dump messages. Allow the user to set Embedded SYNC frequency with
pin-set do netlink message.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/driver-api/dpll.rst     |  21 +++++
 Documentation/netlink/specs/dpll.yaml |  41 +++++++++
 drivers/dpll/dpll_netlink.c           | 127 ++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |   5 +-
 include/linux/dpll.h                  |  10 ++
 include/uapi/linux/dpll.h             |  23 +++++
 6 files changed, 225 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index ea8d16600e16..d7d091d268a1 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -214,6 +214,27 @@ offset values are fractional with 3-digit decimal places and shell be
 divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
 modulo divided to get fractional part.
 
+Embedded SYNC
+=============
+
+Device may provide ability to use Embedded SYNC feature. It allows
+to embed additional SYNC signal into the base frequency of a pin - a one
+special pulse of base frequency signal every time SYNC signal pulse
+happens. The user can configure the frequency of Embedded SYNC.
+The Embedded SYNC capability is always related to a given base frequency
+and HW capabilities. The user is provided a range of embedded sync
+frequencies supported, depending on current base frequency configured for
+the pin.
+
+  ========================================= =================================
+  ``DPLL_A_PIN_E_SYNC_FREQUENCY``           current embedded SYNC frequency
+  ``DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED`` nest available embedded SYNC
+                                            frequency ranges
+    ``DPLL_A_PIN_FREQUENCY_MIN``            attr minimum value of frequency
+    ``DPLL_A_PIN_FREQUENCY_MAX``            attr maximum value of frequency
+  ``DPLL_A_PIN_E_SYNC_PULSE``               pulse type of embedded SYNC
+  ========================================= =================================
+
 Configuration commands group
 ============================
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 94132d30e0e0..0aabf6f1fc2f 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -210,6 +210,25 @@ definitions:
       integer part of a measured phase offset value.
       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
       fractional part of a measured phase offset value.
+  -
+    type: enum
+    name: pin-e-sync-pulse
+    doc: |
+      defines possible pulse length ratio between high and low state when
+      embedded sync signal occurs on base clock signal frequency
+    entries:
+      -
+        name: none
+        doc: embedded sync not enabled
+      -
+        name: 25-75
+        doc: when embedded sync signal occurs 25% of signal's period is in
+          high state, 75% of signal's period is in low state
+      -
+        name: 75-25
+        doc: when embedded sync signal occurs 75% of signal's period is in
+          high state, 25% of signal's period is in low state
+    render-max: true
 
 attribute-sets:
   -
@@ -345,6 +364,24 @@ attribute-sets:
           Value is in PPM (parts per million).
           This may be implemented for example for pin of type
           PIN_TYPE_SYNCE_ETH_PORT.
+      -
+        name: e-sync-frequency
+        type: u64
+        doc: |
+          Embedded Sync frequency. If provided a non-zero value, the pin is
+          configured with an embedded sync signal into its base frequency.
+      -
+        name: e-sync-frequency-supported
+        type: nest
+        nested-attributes: frequency-range
+        doc: |
+          If provided a pin is capable of enabling embedded sync frequency
+          into it's base frequency signal.
+      -
+        name: e-sync-pulse
+        type: u32
+        enum: pin-e-sync-pulse
+        doc: Embedded sync signal ratio.
   -
     name: pin-parent-device
     subset-of: pin
@@ -510,6 +547,9 @@ operations:
             - phase-adjust-max
             - phase-adjust
             - fractional-frequency-offset
+            - e-sync-frequency
+            - e-sync-frequency-supported
+            - e-sync-pulse
 
       dump:
         request:
@@ -536,6 +576,7 @@ operations:
             - parent-device
             - parent-pin
             - phase-adjust
+            - e-sync-frequency
     -
       name: pin-create-ntf
       doc: Notification about pin appearing
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 98e6ad8528d3..5ae2c0adb98e 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -342,6 +342,50 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 	return 0;
 }
 
+static int
+dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,
+		       struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	enum dpll_pin_e_sync_pulse pulse;
+	struct dpll_pin_frequency range;
+	struct nlattr *nest;
+	u64 esync;
+	int ret;
+
+	if (!ops->e_sync_get)
+		return 0;
+	ret = ops->e_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			      dpll_priv(dpll), &esync, &range, &pulse, extack);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+	else if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_E_SYNC_FREQUENCY, sizeof(esync),
+			  &esync, DPLL_A_PIN_PAD))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, DPLL_A_PIN_E_SYNC_PULSE, pulse))
+		return -EMSGSIZE;
+
+	nest = nla_nest_start(msg, DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED);
+	if (!nest)
+		return -EMSGSIZE;
+	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(range.min),
+			  &range.min, DPLL_A_PIN_PAD)) {
+		nla_nest_cancel(msg, nest);
+		return -EMSGSIZE;
+	}
+	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(range.max),
+			  &range.max, DPLL_A_PIN_PAD)) {
+		nla_nest_cancel(msg, nest);
+		return -EMSGSIZE;
+	}
+	nla_nest_end(msg, nest);
+
+	return 0;
+}
+
 static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
 {
 	int fs;
@@ -481,6 +525,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	if (xa_empty(&pin->parent_refs))
@@ -738,6 +785,81 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 	return ret;
 }
 
+static int
+dpll_pin_e_sync_set(struct dpll_pin *pin, struct nlattr *a,
+		    struct netlink_ext_ack *extack)
+{
+	u64 esync = nla_get_u64(a), old_esync;
+	struct dpll_pin_ref *ref, *failed;
+	enum dpll_pin_e_sync_pulse pulse;
+	struct dpll_pin_frequency range;
+	const struct dpll_pin_ops *ops;
+	struct dpll_device *dpll;
+	unsigned long i;
+	int ret;
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		ops = dpll_pin_ops(ref);
+		if (!ops->e_sync_set ||
+		    !ops->e_sync_get) {
+			NL_SET_ERR_MSG(extack,
+				       "embedded sync feature is not supported by this device");
+			return -EOPNOTSUPP;
+		}
+	}
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ops = dpll_pin_ops(ref);
+	dpll = ref->dpll;
+	ret = ops->e_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			      dpll_priv(dpll), &old_esync, &range, &pulse, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
+		return ret;
+	}
+	if (esync == old_esync)
+		return 0;
+	if (esync > range.max || esync < range.min) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "requested embedded sync frequency value is not supported by this device");
+		return -EINVAL;
+	}
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		void *pin_dpll_priv;
+
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
+		ret = ops->e_sync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
+				      esync, extack);
+		if (ret) {
+			failed = ref;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "embedded sync frequency set failed for dpll_id:%u",
+					   dpll->id);
+			goto rollback;
+		}
+	}
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+
+rollback:
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		void *pin_dpll_priv;
+
+		if (ref == failed)
+			break;
+		ops = dpll_pin_ops(ref);
+		dpll = ref->dpll;
+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
+		if (ops->e_sync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
+				    old_esync, extack))
+			NL_SET_ERR_MSG(extack, "set embedded sync frequency rollback failed");
+	}
+	return ret;
+}
+
 static int
 dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 			  enum dpll_pin_state state,
@@ -1039,6 +1161,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
 			if (ret)
 				return ret;
 			break;
+		case DPLL_A_PIN_E_SYNC_FREQUENCY:
+			ret = dpll_pin_e_sync_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
 		}
 	}
 
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 1e95f5397cfc..ba79a47f3a17 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -62,7 +62,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
 };
 
 /* DPLL_CMD_PIN_SET - do */
-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST + 1] = {
+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_E_SYNC_FREQUENCY + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
@@ -71,6 +71,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST +
 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
+	[DPLL_A_PIN_E_SYNC_FREQUENCY] = { .type = NLA_U64, },
 };
 
 /* Ops table for dpll */
@@ -138,7 +139,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_pin_set_doit,
 		.post_doit	= dpll_pin_post_doit,
 		.policy		= dpll_pin_set_nl_policy,
-		.maxattr	= DPLL_A_PIN_PHASE_ADJUST,
+		.maxattr	= DPLL_A_PIN_E_SYNC_FREQUENCY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index d275736230b3..137ab4bcb60e 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -15,6 +15,7 @@
 
 struct dpll_device;
 struct dpll_pin;
+struct dpll_pin_frequency;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -83,6 +84,15 @@ struct dpll_pin_ops {
 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
 		       const struct dpll_device *dpll, void *dpll_priv,
 		       s64 *ffo, struct netlink_ext_ack *extack);
+	int (*e_sync_set)(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 e_sync_freq, struct netlink_ext_ack *extack);
+	int (*e_sync_get)(const struct dpll_pin *pin, void *pin_priv,
+			  const struct dpll_device *dpll, void *dpll_priv,
+			  u64 *e_sync_freq,
+			  struct dpll_pin_frequency *e_sync_range,
+			  enum dpll_pin_e_sync_pulse *pulse,
+			  struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_frequency {
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 0c13d7f1a1bc..2a80a6fb0d1d 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -169,6 +169,26 @@ enum dpll_pin_capabilities {
 
 #define DPLL_PHASE_OFFSET_DIVIDER	1000
 
+/**
+ * enum dpll_pin_e_sync_pulse - defines possible pulse length ratio between
+ *   high and low state when embedded sync signal occurs on base clock signal
+ *   frequency
+ * @DPLL_PIN_E_SYNC_PULSE_NONE: embedded sync not enabled
+ * @DPLL_PIN_E_SYNC_PULSE_25_75: when embedded sync signal occurs 25% of
+ *   signal's period is in high state, 75% of signal's period is in low state
+ * @DPLL_PIN_E_SYNC_PULSE_75_25: when embedded sync signal occurs 75% of
+ *   signal's period is in high state, 25% of signal's period is in low state
+ */
+enum dpll_pin_e_sync_pulse {
+	DPLL_PIN_E_SYNC_PULSE_NONE,
+	DPLL_PIN_E_SYNC_PULSE_25_75,
+	DPLL_PIN_E_SYNC_PULSE_75_25,
+
+	/* private: */
+	__DPLL_PIN_E_SYNC_PULSE_MAX,
+	DPLL_PIN_E_SYNC_PULSE_MAX = (__DPLL_PIN_E_SYNC_PULSE_MAX - 1)
+};
+
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -210,6 +230,9 @@ enum dpll_a_pin {
 	DPLL_A_PIN_PHASE_ADJUST,
 	DPLL_A_PIN_PHASE_OFFSET,
 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+	DPLL_A_PIN_E_SYNC_FREQUENCY,
+	DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED,
+	DPLL_A_PIN_E_SYNC_PULSE,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.38.1


