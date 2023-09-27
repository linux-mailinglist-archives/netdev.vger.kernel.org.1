Return-Path: <netdev+bounces-36492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D27AFFF5
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 11:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 077F01C20A0F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA822F1F;
	Wed, 27 Sep 2023 09:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64D21356
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 09:27:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D40CDF;
	Wed, 27 Sep 2023 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695806844; x=1727342844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsZy8XQcjObrwgFNchQrgkMqxgu1CEi8IG6sP9GJcp8=;
  b=OsAqZByUOQB9yjG2pfrawlyWVXD06ply0wUL7EjlgoLWw0EsE+hqkijm
   9uET/8VhWhbDG3r0FcRDZJYbd6OaBjgCyLcUDfobS9XeYAmSS2fiQ18pO
   CnS6Fink43svUAOQOLN0S+NPy7khV+IWrTUBtPzPpP3f9SBjJJiVVyKfA
   NSyX9wyCdYipamEePS0Vh2+Ku53SeSEhrCk946Kxn21vaCjSaUctyh0cP
   cnEE1Lw1nV4awHy4q8Zx7ouiTF98rUjSLYmYe2DJDGQgRHIeGp/p47NyL
   WWdEQfVMhb5TeClhEjBVLssYGVVScrBAGrZN0tMlYMMq6hP/4j0UVYDjt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412692351"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412692351"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 02:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778479267"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778479267"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 02:27:16 -0700
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
Subject: [PATCH net-next 2/4] dpll: spec: add support for pin-dpll signal phase offset/adjust
Date: Wed, 27 Sep 2023 11:24:33 +0200
Message-Id: <20230927092435.1565336-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new pin's attributes to dpll netlink spec:
- phase-offset - measured difference between phase of signals on pin
  and dpll
- phase-adjust - adjustable value of pin's signal phase
- phase-adjust-min / phase-adjust-max - values for determining limits
  for phase-adjust

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/netlink/specs/dpll.yaml | 33 ++++++++++++++++++++++++++-
 drivers/dpll/dpll_nl.c                |  8 ++++---
 drivers/dpll/dpll_nl.h                |  2 +-
 include/uapi/linux/dpll.h             |  8 ++++++-
 4 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8b86b28b47a6..dc057494101f 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 
 name: dpll
-
+version: 2
 doc: DPLL subsystem.
 
 definitions:
@@ -164,6 +164,18 @@ definitions:
       -
         name: state-can-change
         doc: pin state can be changed
+  -
+    type: const
+    name: phase-offset-divider
+    value: 1000
+    doc: |
+      phase offset divider allows userspace to calculate a value of
+      measured signal phase difference between a pin and dpll device
+      as a fractional value with three digit decimal precision.
+      Value of (DPLL_A_PHASE_OFFSET / DPLL_PHASE_OFFSET_DIVIDER) is an
+      integer part of a measured phase offest value.
+      Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
+      fractional part of a measured phase offest value.
 
 attribute-sets:
   -
@@ -272,6 +284,18 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: pin-parent-pin
+      -
+        name: phase-adjust-min
+        type: s32
+      -
+        name: phase-adjust-max
+        type: s32
+      -
+        name: phase-adjust
+        type: s32
+      -
+        name: phase-offset
+        type: s64
   -
     name: pin-parent-device
     subset-of: pin
@@ -288,6 +312,9 @@ attribute-sets:
       -
         name: state
         type: u32
+      -
+        name: phase-offset
+        type: s64
   -
     name: pin-parent-pin
     subset-of: pin
@@ -439,6 +466,9 @@ operations:
             - capabilities
             - parent-device
             - parent-pin
+            - phase-adjust-min
+            - phase-adjust-max
+            - phase-adjust
 
       dump:
         pre: dpll-lock-dumpit
@@ -466,6 +496,7 @@ operations:
             - state
             - parent-device
             - parent-pin
+            - phase-adjust
     -
       name: pin-create-ntf
       doc: Notification about pin appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 14064c8c783b..eaee5be7aa64 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -11,11 +11,12 @@
 #include <uapi/linux/dpll.h>
 
 /* Common nested types */
-const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] = {
+const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1] = {
 	[DPLL_A_PIN_PARENT_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
 	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
+	[DPLL_A_PIN_PHASE_OFFSET] = { .type = NLA_S64, },
 };
 
 const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
@@ -61,7 +62,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
 };
 
 /* DPLL_CMD_PIN_SET - do */
-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PARENT_PIN + 1] = {
+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST + 1] = {
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
@@ -69,6 +70,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PARENT_PIN + 1]
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
+	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
 };
 
 /* Ops table for dpll */
@@ -140,7 +142,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_pin_set_doit,
 		.post_doit	= dpll_pin_post_doit,
 		.policy		= dpll_pin_set_nl_policy,
-		.maxattr	= DPLL_A_PIN_PARENT_PIN,
+		.maxattr	= DPLL_A_PIN_PHASE_ADJUST,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/drivers/dpll/dpll_nl.h b/drivers/dpll/dpll_nl.h
index 1f67aaed4742..92d4c9c4f788 100644
--- a/drivers/dpll/dpll_nl.h
+++ b/drivers/dpll/dpll_nl.h
@@ -12,7 +12,7 @@
 #include <uapi/linux/dpll.h>
 
 /* Common nested types */
-extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1];
+extern const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET + 1];
 extern const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1];
 
 int dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 20ef0718f8dc..050f51b48ef8 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -7,7 +7,7 @@
 #define _UAPI_LINUX_DPLL_H
 
 #define DPLL_FAMILY_NAME	"dpll"
-#define DPLL_FAMILY_VERSION	1
+#define DPLL_FAMILY_VERSION	2
 
 /**
  * enum dpll_mode - working modes a dpll can support, differentiates if and how
@@ -138,6 +138,8 @@ enum dpll_pin_capabilities {
 	DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE = 4,
 };
 
+#define DPLL_PHASE_OFFSET_DIVIDER	1000
+
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -173,6 +175,10 @@ enum dpll_a_pin {
 	DPLL_A_PIN_CAPABILITIES,
 	DPLL_A_PIN_PARENT_DEVICE,
 	DPLL_A_PIN_PARENT_PIN,
+	DPLL_A_PIN_PHASE_ADJUST_MIN,
+	DPLL_A_PIN_PHASE_ADJUST_MAX,
+	DPLL_A_PIN_PHASE_ADJUST,
+	DPLL_A_PIN_PHASE_OFFSET,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.38.1


