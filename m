Return-Path: <netdev+bounces-216203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8312B32807
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1351C87A18
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFC24EAA7;
	Sat, 23 Aug 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clhO8cm7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D22494F0
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942605; cv=none; b=ldJCnJnM6lYg50ziIf61ZvuttoFWNCxtJa2zzuDfMby/VKkZ261W59TXGKISsV9B4BTahx619rfummW5n1C5VRPNGGvYpxqYoh6xOW6QMO8Sb10HYpJ6NKmrQ/rWV8k9oQZUkc1cnvJ2AegoQF8QAaktpTIhLawoU+uhYdL7MeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942605; c=relaxed/simple;
	bh=lQ0Ukp+e/nR81QTIi23V1aH8qN7iic6FbHvLtlL2UWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRgs3pjhFKz5KkOJp7fWkP013c/fCVzfwULFOJxDPdHiB3Cb8/U5vTMP/t5hsOnSvJ1GWLwIrceEnWhLwaqhO9ikufas9/E5hN1sCQ4z8gVzQestx6n0/cWo8CCm0rXiDjfDNiK1Z6mnI0miaJ/3Ilmb86NgneI/vPxgjfN4PtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clhO8cm7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755942602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fo/miEf2OgY1EZA/2dSe8LFLeCSjwJj43g1evMg5bzg=;
	b=clhO8cm72oPqftjHw0oyOYPBvS6ISGAg6wLMdOTaZkFdnT70hv7tnFH+HY8Y6KIhPXEumo
	+dxG+mU/Hclsqnip2jpBODoCQq0QlebLlg7V9mPeN1MnCHpxb0mGNlWFCZZKKNSaOjSTgA
	CHa1OJYftrEx40i4mejGd9s5sG5MGn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-zs8rZA4_PFWEtRSm_Z9vRQ-1; Sat, 23 Aug 2025 05:50:00 -0400
X-MC-Unique: zs8rZA4_PFWEtRSm_Z9vRQ-1
X-Mimecast-MFC-AGG-ID: zs8rZA4_PFWEtRSm_Z9vRQ_1755942599
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c380aa1ac0so1142053f8f.0
        for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 02:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755942599; x=1756547399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo/miEf2OgY1EZA/2dSe8LFLeCSjwJj43g1evMg5bzg=;
        b=GfskmmkOo2GGTSrcCSqGBYm29R5H5D+aLyesy62jGLRw3Zv1czFKuYvTq6zBejuar2
         luU2ip3kwbaDHP01e+mYy8vbjcSGLdv3xtBN+kfdGSB7eTjI6Tw/t/k86kdtn7YwN5kW
         2VHcL3QNdEsqqXTgTCtb8GuAoFd8nHsQ+YZygsPO4wlB/2XYMSzNhtcTvREy77PF14GD
         tATNJvyonyU7S/ftYzgIR7oy2/AIeN53Zv0OOW8AKW9t/vjPFdLT3ASlukRRLgBd8Xk6
         fMaqEBaCEy+oIWpeiVeriojGOUbkPSqVCnBE9bI54TAfVJVxIYWagPqXFhBpbhKdAL5q
         JRuA==
X-Forwarded-Encrypted: i=1; AJvYcCV/4srHA7CVNWXfTZjSIH5p/7xZzUDWehc2aGjTDOFLqjOKDKiT3+mVH0X0Ud0ze3+IDP5p4qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd08RNlj0i3iooBEvkkHZU3MutfRvzAK0jT3FO49ceWkmDbjV
	1APmb82f7kQvQr0clIELRQ05Ab2wuxRXL/YGqTKNbe5PWkOtaPssRsXQyeo6eP9GiBaTMO4mGjH
	tQod/C8+8pmFU/UPPf1MGILnDUilTQiacPGyP4vohdjjbjMEu3wI8Pd9iCQ==
X-Gm-Gg: ASbGncvh13tBMF30JZBCM52X0ZlNWOVn135vFV5T3Jx0WGKDSKaZmWTnFafo6RDHeNk
	WdV0C6bXLf0APqOm7VVF9N8Wi6TcftGPJP58ypIrF5ctip+vVmyEs5KYmvLC6aW0uXga0Zc4GH2
	22AE8FM98KvdaPPbJCuvBhND8QfFoiZ0qfsnB6YVKKOKlgC79OZXhvl4Pf70yGcJCzlvCsogwz8
	PNPchiwmgM8ERHE0Quc4wJx1sv0ssFvd3F16pItqiN58w6LojepAxQItkGyttd4hdCOfAVKxhjB
	ZJ35EdX9sdwcjne02koV+Wdzc3b2U/nWVB9k8uRwLtMP
X-Received: by 2002:a05:6000:400e:b0:3bf:2c26:eb73 with SMTP id ffacd0b85a97d-3c5dac1a04cmr3908048f8f.17.1755942599101;
        Sat, 23 Aug 2025 02:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07xsOTcHl9o3bduUDPzLZSCoLilgEFoC01Yv7/kmt5q/uC3uHCdbpQFaZeDyVt2WwzJLbcw==
X-Received: by 2002:a05:6000:400e:b0:3bf:2c26:eb73 with SMTP id ffacd0b85a97d-3c5dac1a04cmr3908034f8f.17.1755942598638;
        Sat, 23 Aug 2025 02:49:58 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70eb7ef1esm2889084f8f.19.2025.08.23.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 02:49:58 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net v2] i40e: add devlink param to control VF MAC address limit
Date: Sat, 23 Aug 2025 12:49:52 +0300
Message-ID: <20250823094952.182181-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

This patch introduces a new devlink runtime parameter that controls
the maximum number of MAC filters allowed per VF.

The parameter is an integer value. If set to a non-zero number, it is
used as a strict per-VF cap. If left at zero, the driver falls back to
the default limit calculated from the number of allocated VFs and
ports.

This makes the limit policy explicit and configurable by user space,
instead of being only driver internal logic.

Example command to enable per-vf mac limit:
 - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
	value 12 \
	cmode runtime

- Previous discussion about this change:
  https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com

Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/networking/devlink/i40e.rst     | 22 ++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++----
 4 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..f8d5b00bb51d 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,28 @@ i40e devlink support
 This document describes the devlink features implemented by the ``i40e``
 device driver.
 
+Parameters
+==========
+
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``max_mac_per_vf``
+      - runtime
+      - Controls the maximum number of MAC addresses a VF can use on i40e devices.
+
+        By default (``0``), the driver enforces its internally calculated per-VF
+        MAC filter limit, which is based on the number of allocated VFS.
+
+        If set to a non-zero value, this parameter acts as a strict cap:
+        the driver enforces the maximum of the user-provided value and ignore
+        internally calculated limit.
+
+        The default value is ``0``.
+
 Info versions
 =============
 
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
index cc4e9e2addb7..8532e40b5c7d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -5,6 +5,42 @@
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
+enum i40e_dl_param_id {
+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
+};
+
+static const struct devlink_param i40e_dl_params[] = {
+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
+			     "max_mac_per_vf",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     i40e_max_mac_per_vf_get,
+			     i40e_max_mac_per_vf_set,
+			     NULL),
+};
+
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
 {
 	u8 dsn[8];
@@ -165,7 +201,19 @@ void i40e_free_pf(struct i40e_pf *pf)
  **/
 void i40e_devlink_register(struct i40e_pf *pf)
 {
-	devlink_register(priv_to_devlink(pf));
+	int err;
+	struct devlink *dl = priv_to_devlink(pf);
+	struct device *dev = &pf->pdev->dev;
+
+	err = devlink_params_register(dl, i40e_dl_params,
+				      ARRAY_SIZE(i40e_dl_params));
+	if (err) {
+		dev_err(dev,
+			"devlink params register failed with error %d", err);
+	}
+
+	devlink_register(dl);
+
 }
 
 /**
@@ -176,7 +224,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
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
index 081a4526a2f0..e7c0c791eed1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2935,19 +2935,23 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		if (!f)
 			++mac_add_cnt;
 	}
-
-	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses.
+	/* Determine the maximum number of MAC addresses this VF may use.
+	 *
+	 * - For untrusted VFs: use a fixed small limit.
+	 *
+	 * - For trusted VFs: limit is calculated by dividing total MAC
+	 *  filter pool across all VFs/ports.
 	 *
-	 * If this VF is trusted, it can use more resources than untrusted.
-	 * However to ensure that every trusted VF has appropriate number of
-	 * resources, divide whole pool of resources per port and then across
-	 * all VFs.
+	 * - User can override this by devlink param "max_mac_per_vf".
+	 *   If set its value is used as a strict cap.
 	 */
-	if (!vf_trusted)
+	if (!vf_trusted) {
 		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
-	else
+	} else {
 		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
+		if (pf->max_mac_per_vf > 0)
+			mac_add_max = pf->max_mac_per_vf;
+	}
 
 	/* VF can replace all its filters in one step, in this case mac_add_max
 	 * will be added as active and another mac_add_max will be in
@@ -2961,7 +2965,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 			return -EPERM;
 		} else {
 			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
+				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
+				mac_add_max);
 			return -EPERM;
 		}
 	}
-- 
2.47.3


