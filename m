Return-Path: <netdev+bounces-229736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E625BE0750
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC2507FDA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910C030E0F5;
	Wed, 15 Oct 2025 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeZ20uww"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE430C602;
	Wed, 15 Oct 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556799; cv=none; b=n+suDQtw20CLZzuHUmOh2LS8S8tUBmmWFybpWmYjiKnH4G5mtDlfjrUV9Z/nSdKfb3QjVDkbLL9drujqOOhx9BSqg3h2josUiWDrcBpEDasstjIFGiMTixgOeJUvOnbvUW1QQlDUABLLRafs52XqdIQRN9SYgbCKvNiWAQL5U3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556799; c=relaxed/simple;
	bh=/ZyStLu8IVnuiQhnU+eKO0TSqCaPIpnXGQNIoPBXzuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZB/7btVMDzz5ssKd0HHqs1eOBIxLlfuj2gqOyTR1jolId9c3wX7CiV8h7NwSv5B7Iu+uNiyGsoBNUfyZ3OoG+ndaFWd+/rT44I6KklfVOWsa/iC7KdK1IxN7D/fWPUn2P6O8pxwA3QhXe4BDqaJ1HfahJSE37ua+xPZfcAsG3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeZ20uww; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556797; x=1792092797;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/ZyStLu8IVnuiQhnU+eKO0TSqCaPIpnXGQNIoPBXzuo=;
  b=DeZ20uwwp+zpMmzoH2owDXKUQYNsFp08QAJJXPs84hodUFV+BT/QqQJt
   mvTMr6CttBHc+bvkZ0Lt3BeYtfSIRi59UuOkAFAdndpDIiYk7zQkqCXPi
   rrGJoGB4ZCVwJWZ6S+Nd3r1nEBr0yli6LEe0k+SDh69zS4KL1a0wLshr8
   i8S/C4XzHTtKx4TifE44GxWSYSrZ9N7HtLQq4RfxTQUVf/ht+2ThSKoBy
   bFypNa3piWTD11wMpWDsYxpRHEk2xBJVrqgaX/75Enwpev7nItut6+/di
   o0YqFDjY/L5VCnUBsdd4V4DC0R1VH1iBK19WMjUWH4cFB09itIdulvQCk
   Q==;
X-CSE-ConnectionGUID: nJTLyG76RJmKC2ddML3SRA==
X-CSE-MsgGUID: UB9XToXoTt6MNW3WxMv/xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083476"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083476"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:14 -0700
X-CSE-ConnectionGUID: LwtSm/+jSyikreDj37HKqg==
X-CSE-MsgGUID: ubOIthcNQeujIKFTIaECAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044873"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:13 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:31:58 -0700
Subject: [PATCH net-next 02/14] i40e: support generic devlink param
 "max_mac_per_vf"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-2-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Mohammad Heib <mheib@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=8846;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=v0A2NSclHiOd1x06THWkFZxeJddjlSSoD287AlNXGoQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3375xXm7dEbZapemC87TXG6xXP+mTLX3YXM2eGKzZO
 N9OvK+3o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInY/GVkaHmt6jPbnNW5Kmrm
 zt+3f90o4nhU8vF14CRpezb9r2kVNYwMD1M13zIUCIvNajHZvFO7TLD55BxHfVMZ1uPTc+6IdJ/
 iAAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Mohammad Heib <mheib@redhat.com>

Currently the i40e driver enforces its own internally calculated per-VF MAC
filter limit, derived from the number of allocated VFs and available
hardware resources. This limit is not configurable by the administrator,
which makes it difficult to control how many MAC addresses each VF may
use.

This patch adds support for the new generic devlink runtime parameter
"max_mac_per_vf" which provides administrators with a way to cap the
number of MAC addresses a VF can use:

- When the parameter is set to 0 (default), the driver continues to use
  its internally calculated limit.

- When set to a non-zero value, the driver applies this value as a strict
  cap for VFs, overriding the internal calculation.

Important notes:

- The configured value is a theoretical maximum. Hardware limits may
  still prevent additional MAC addresses from being added, even if the
  parameter allows it.

- Since MAC filters are a shared hardware resource across all VFs,
  setting a high value may cause resource contention and starve other
  VFs.

- This change gives administrators predictable and flexible control over
  VF resource allocation, while still respecting hardware limitations.

- Previous discussion about this change:
  https://lore.kernel.org/netdev/20250805134042.2604897-2-dhill@redhat.com
  https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  4 ++
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     | 48 +++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 31 ++++++++++----
 Documentation/networking/devlink/i40e.rst          | 32 +++++++++++++++
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 801a57a925da..d2d03db2acec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -574,6 +574,10 @@ struct i40e_pf {
 	struct i40e_vf *vf;
 	int num_alloc_vfs;	/* actual number of VFs allocated */
 	u32 vf_aq_requests;
+	/* If set to non-zero, the device uses this value
+	 * as maximum number of MAC filters per VF.
+	 */
+	u32 max_mac_per_vf;
 	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
 	struct ratelimit_state mdd_message_rate_limit;
 	/* DCBx/DCBNL capability for PF that indicates
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index cc4e9e2addb7..cd01e35da94e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -5,6 +5,35 @@
 #include "i40e.h"
 #include "i40e_devlink.h"
 
+static int i40e_max_mac_per_vf_set(struct devlink *devlink,
+				   u32 id,
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	pf->max_mac_per_vf = ctx->val.vu32;
+	return 0;
+}
+
+static int i40e_max_mac_per_vf_get(struct devlink *devlink,
+				   u32 id,
+				   struct devlink_param_gset_ctx *ctx)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vu32 = pf->max_mac_per_vf;
+	return 0;
+}
+
+static const struct devlink_param i40e_dl_params[] = {
+	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
+			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			      i40e_max_mac_per_vf_get,
+			      i40e_max_mac_per_vf_set,
+			      NULL),
+};
+
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
 {
 	u8 dsn[8];
@@ -165,7 +194,18 @@ void i40e_free_pf(struct i40e_pf *pf)
  **/
 void i40e_devlink_register(struct i40e_pf *pf)
 {
-	devlink_register(priv_to_devlink(pf));
+	struct devlink *dl = priv_to_devlink(pf);
+	struct device *dev = &pf->pdev->dev;
+	int err;
+
+	err = devlink_params_register(dl, i40e_dl_params,
+				      ARRAY_SIZE(i40e_dl_params));
+	if (err)
+		dev_err(dev,
+			"devlink params register failed with error %d", err);
+
+	devlink_register(dl);
+
 }
 
 /**
@@ -176,7 +216,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
  **/
 void i40e_devlink_unregister(struct i40e_pf *pf)
 {
-	devlink_unregister(priv_to_devlink(pf));
+	struct devlink *dl = priv_to_devlink(pf);
+
+	devlink_unregister(dl);
+	devlink_params_unregister(dl, i40e_dl_params,
+				  ARRAY_SIZE(i40e_dl_params));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..6e154a8aa474 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2935,33 +2935,48 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		if (!f)
 			++mac_add_cnt;
 	}
-
-	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses.
+	/* Determine the maximum number of MAC addresses this VF may use.
 	 *
-	 * If this VF is trusted, it can use more resources than untrusted.
-	 * However to ensure that every trusted VF has appropriate number of
-	 * resources, divide whole pool of resources per port and then across
-	 * all VFs.
+	 * - For untrusted VFs: use a fixed small limit.
+	 *
+	 * - For trusted VFs: limit is calculated by dividing total MAC
+	 *  filter pool across all VFs/ports.
+	 *
+	 * - User can override this by devlink param "max_mac_per_vf".
+	 *   If set its value is used as a strict cap for both trusted and
+	 *   untrusted VFs.
+	 *   Note:
+	 *    even when overridden, this is a theoretical maximum; hardware
+	 *    may reject additional MACs if the absolute HW limit is reached.
 	 */
 	if (!vf_trusted)
 		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
 	else
 		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
 
+	if (pf->max_mac_per_vf > 0)
+		mac_add_max = pf->max_mac_per_vf;
+
 	/* VF can replace all its filters in one step, in this case mac_add_max
 	 * will be added as active and another mac_add_max will be in
 	 * a to-be-removed state. Account for that.
 	 */
 	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
 	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
+		if (pf->max_mac_per_vf == mac_add_max && mac_add_max > 0) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses: VF reached its maximum allowed limit (%d)\n",
+				mac_add_max);
+				return -EPERM;
+		}
 		if (!vf_trusted) {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
 			return -EPERM;
 		} else {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
+				mac_add_max);
 			return -EPERM;
 		}
 	}
diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..7480f0300fdb 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,38 @@ i40e devlink support
 This document describes the devlink features implemented by the ``i40e``
 device driver.
 
+Parameters
+==========
+
+.. list-table:: Generic parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Notes
+    * - ``max_mac_per_vf``
+      - runtime
+      - Controls the maximum number of MAC addresses a VF can use
+        on i40e devices.
+
+        By default (``0``), the driver enforces its internally calculated per-VF
+        MAC filter limit, which is based on the number of allocated VFS.
+
+        If set to a non-zero value, this parameter acts as a strict cap:
+        the driver will use the user-provided value instead of its internal
+        calculation.
+
+        **Important notes:**
+
+        - MAC filters are a **shared hardware resource** across all VFs.
+          Setting a high value may cause other VFs to be starved of filters.
+        - This value is a **theoretical maximum**. The hardware may return
+          errors when its absolute limit is reached, regardless of the value
+          set here.
+
+        The default value is ``0`` (internal calculation is used).
+
+
 Info versions
 =============
 

-- 
2.51.0.rc1.197.g6d975e95c9d7


