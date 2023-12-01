Return-Path: <netdev+bounces-53032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE780123A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809F42814CD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFB4F1E5;
	Fri,  1 Dec 2023 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nI1TKMzP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4B10B
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454137; x=1732990137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPtlO/jnrL67cPGbq/hH1CCQfG+mCtG9OdBDB8X9c4Q=;
  b=nI1TKMzPePL44Gb0TfoW0ZPJWrAvlHIb8rQvliT+Alfq3jeE/lQmIt8Y
   nBLGyLpa3KW/p4oqvcxTaammLB0i6/8M04FPHbGgNlwdbUou6J28CzLg9
   xfWGXHK+ToMfD910uVXT+d/X0q0NOIxwQC8WgBbBECql+feBU+mmgeTcc
   rKcGZJmeYg4QgmuuoknBzvzQbN1mq8a9JPdYC5Q4EDVMUdwTKeIvW2etF
   wa2kTzZ3yanUkMiNB/qrGTe/LrGI6WqXvJAmg1v8X8Iq3/oiZBsKoVOKt
   2pxs3hPgf9vC1MCvM7WswuB8D7g+2y+/f5kmEf9T6yh4k2Hh9km/LcA7s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244390"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244390"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272441"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272441"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/6] ice: add CGU info to devlink info callback
Date: Fri,  1 Dec 2023 10:08:40 -0800
Message-ID: <20231201180845.219494-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

If Clock Generation Unit is present on NIC board user shall know its
details.
Provide the devlink info callback with a new:
- fixed type object (cgu.id) indicating hardware variant of onboard CGU,
- running type object (fw.cgu) consisting of CGU id, config and firmware
versions.
These information shall be known for debugging purposes.

Test (on NIC board with CGU)
$ devlink dev info <bus_name>/<dev_name> | grep cgu
        cgu.id 36
        fw.cgu 8032.16973825.6021

Test (on NIC board without CGU)
$ devlink dev info <bus_name>/<dev_name> | grep cgu -c
0

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/ice.rst     |  9 +++++++++
 drivers/net/ethernet/intel/ice/ice_devlink.c | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 2f60e34ab926..7f30ebd5debb 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -38,6 +38,10 @@ The ``ice`` driver reports the following versions
       - fixed
       - K65390-000
       - The Product Board Assembly (PBA) identifier of the board.
+    * - ``cgu.id``
+      - fixed
+      - 36
+      - The Clock Generation Unit (CGU) hardware revision identifier.
     * - ``fw.mgmt``
       - running
       - 2.1.7
@@ -104,6 +108,11 @@ The ``ice`` driver reports the following versions
       - running
       - 0xee16ced7
       - The first 4 bytes of the hash of the netlist module contents.
+    * - ``fw.cgu``
+      - running
+      - 8032.16973825.6021
+      - The version of Clock Generation Unit (CGU). Format:
+        <CGU type>.<configuration version>.<firmware version>.
 
 Flash Update
 ============
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index f4e24d11ebd0..65be56f2af9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -193,6 +193,24 @@ ice_info_pending_netlist_build(struct ice_pf __always_unused *pf,
 		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
 }
 
+static void ice_info_cgu_fw_build(struct ice_pf *pf, struct ice_info_ctx *ctx)
+{
+	u32 id, cfg_ver, fw_ver;
+
+	if (!ice_is_feature_supported(pf, ICE_F_CGU))
+		return;
+	if (ice_aq_get_cgu_info(&pf->hw, &id, &cfg_ver, &fw_ver))
+		return;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u", id, cfg_ver, fw_ver);
+}
+
+static void ice_info_cgu_id(struct ice_pf *pf, struct ice_info_ctx *ctx)
+{
+	if (!ice_is_feature_supported(pf, ICE_F_CGU))
+		return;
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u", pf->hw.cgu_part_number);
+}
+
 #define fixed(key, getter) { ICE_VERSION_FIXED, key, getter, NULL }
 #define running(key, getter) { ICE_VERSION_RUNNING, key, getter, NULL }
 #define stored(key, getter, fallback) { ICE_VERSION_STORED, key, getter, fallback }
@@ -235,6 +253,8 @@ static const struct ice_devlink_version {
 	running("fw.app.bundle_id", ice_info_ddp_pkg_bundle_id),
 	combined("fw.netlist", ice_info_netlist_ver, ice_info_pending_netlist_ver),
 	combined("fw.netlist.build", ice_info_netlist_build, ice_info_pending_netlist_build),
+	fixed("cgu.id", ice_info_cgu_id),
+	running("fw.cgu", ice_info_cgu_fw_build),
 };
 
 /**
-- 
2.41.0


