Return-Path: <netdev+bounces-232814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F602C090AB
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6541B24F26
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B128C5D9;
	Sat, 25 Oct 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N34Be7Yv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05062877FC
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397871; cv=none; b=eDmj81tRLL8cjiMZUBmacOjsNqcG0JsmOW1k/LWe7PRwRRGP4WuJRT1pJnmLrk+xksSPnzokMr4wcvZUc/tR4AAMA73yUe7xyCfcalUs/sAGp1+Rc+4byypKVmspLD8EfC0f86HRRzZe2fDDYFwwh90dllDep+LeiuHFfut8DwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397871; c=relaxed/simple;
	bh=pJAz8ReIoJ5v1p9bZQpA7J4LYmhEqzsJczEHT04c5Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX7KvgH5EmDHZxDkIgJaie9toggI62s+WZSochGwtmM7SJAyB2QyB0h8ISTtexg2u+az07MNSvr60DplF578SzEltyo5kw/UN23KK/OzBX5aieWtS6K+nMW3H3lglMsytBSouu6YfyxI3QRDBQVElueZDh9C0eTAmq1gxMBPF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N34Be7Yv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761397867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGKJ+4qBOaBgA1KnlHLdE87TBTS6x4HmHzasoKyQciI=;
	b=N34Be7YvdoI1+IlVjFXyPS1MrRrq7Z4xqu+Ijt3kxjN8f72wuJwuszKmccAqrKzKR3KaGZ
	UFEnme1nSMIxcv2vUz4HXgN4Aw0K5bWaOsUTFWFRCbMeoh83F2baPK/ySqLUqorFZNWZ8O
	qNPLfSnL+oFgrnlVOcbqlmwUlaVhZCM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-g60nHzm3NbOBrCGbbaQIxg-1; Sat, 25 Oct 2025 09:11:05 -0400
X-MC-Unique: g60nHzm3NbOBrCGbbaQIxg-1
X-Mimecast-MFC-AGG-ID: g60nHzm3NbOBrCGbbaQIxg_1761397865
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114018621so19840295e9.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761397864; x=1762002664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGKJ+4qBOaBgA1KnlHLdE87TBTS6x4HmHzasoKyQciI=;
        b=e+0X0b7jZj+Zb0ve1Rx+u7Hp9hYDBpNcmDn1jjiLp/UDStZGDPwLLtELJxRQ73u8hN
         gUXB/MqU0YZUd7EHNUaMIhDTifrs9aCCRrlB8twhL1O36ogDl74Nj7YQ2TsrywBXU3Jx
         9KVuaX6sj90MLgR7i79UEkL3XaxI7uDAIDqZ9YVB72MzbYTHPpzw3W4PXj4lrbugfB6b
         hABP0SeoKr5iePZ4SFNT+17yubIftGpiXuWqUnOrpv+GVBEIoCvWkdoqb3u3OjP5LCPp
         rGmCC5BVgC0bcHHvTxJVaB26LQQYurB2sGB9PB6ficD1obQ6hCqRwRfdV1nApi3TeIVp
         GQTg==
X-Forwarded-Encrypted: i=1; AJvYcCWiCBUm1s1q4frWB16CcRcCh1MjsYqI8VrYfMyeCKryALM1u6+NcIgezXCicc+2eV9th/IiG4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4wJVKhkuU32yxdF8H3yvv2bFJL4ArgIqp/2upco79FifPAHx
	IdI4e95N8pxi12nMmN2qO/rUjhNjlQ0HYvOMqEFjMqcBUJv114LEE4VT8n5aRmHqY9RucW58BKD
	RZ/5iUJqB/7i5jNU5oFpPBBciYo468DcpzHh3ewZhoPvfuA93R98vHky2EA==
X-Gm-Gg: ASbGncvNaw+IEwMqc+phjxsVLRIAUo7T/s0rqIPAFFPxVUuh8mZtlkWyXC2S8UHQctz
	TqTD+VW9VAy9Vp11ZeyKGCFflnDejTC5d3U4umJS4fg28qcGQWwps7M8zANWEMDMvlJyml6jz0u
	MXPM+d60AhGe/zm+fbMSzmuflmMqSkX8dZlQN/pcrWREyvY7QXGt/hBsqHW3B6WBqpvr1Nk0yGA
	JaFTYeLGUpzQ4iWlAqJJuSscAqVFZIeJ/YDu7Afa1IUT/dihb+WYK+nKOTuuWn0UoVqssn1gRwh
	fuUYnecAOzDb0c1d4lK+VqkA0gJVcS00Wm5kBo4xYZ5BsZtzbVEiyqjAj1ZbmgJRcvt1Z/oITqd
	vm2su20yf8nWA/ozH+A3lqTuxvhn5tZG3fMty7yUu
X-Received: by 2002:a05:600c:828a:b0:46e:5a5b:db60 with SMTP id 5b1f17b1804b1-4711791c4eamr221047715e9.31.1761397864296;
        Sat, 25 Oct 2025 06:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrsXVKKWZzUoJ4wnz+m3UiWSxjoNWLD3DP+q85kf810Z0Ub9Q1NYCOxXBmP0fkV93J/9UQog==
X-Received: by 2002:a05:600c:828a:b0:46e:5a5b:db60 with SMTP id 5b1f17b1804b1-4711791c4eamr221047495e9.31.1761397863784;
        Sat, 25 Oct 2025 06:11:03 -0700 (PDT)
Received: from fedora.redhat.com (bzq-79-177-147-123.red.bezeqint.net. [79.177.147.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e4esm31935335e9.11.2025.10.25.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 06:11:03 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: kuba@kernel.org,
	przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next,v5,2/2] i40e: support generic devlink param "max_mac_per_vf"
Date: Sat, 25 Oct 2025 16:08:59 +0300
Message-ID: <20251025130859.144916-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251025130859.144916-1-mheib@redhat.com>
References: <20251025130859.144916-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 Documentation/networking/devlink/i40e.rst     | 34 ++++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 54 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++---
 4 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..51c887f0dc83 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,40 @@ i40e devlink support
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
+        - This value **must be set before enabling SR-IOV**.
+          Attempting to change it while SR-IOV is enabled will return an error.
+        - MAC filters are a **shared hardware resource** across all VFs.
+          Setting a high value may cause other VFs to be starved of filters.
+        - This value is a **Administrative policy**. The hardware may return
+          errors when its absolute limit is reached, regardless of the value
+          set here.
+
+        The default value is ``0`` (internal calculation is used).
+
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
index cc4e9e2addb7..bc205e3077c7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -5,6 +5,41 @@
 #include "i40e.h"
 #include "i40e_devlink.h"
 
+static int i40e_max_mac_per_vf_set(struct devlink *devlink,
+				   u32 id,
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	if (pf->num_alloc_vfs > 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot change max_mac_per_vf while SR-IOV is enabled");
+		return -EBUSY;
+	}
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
@@ -165,7 +200,18 @@ void i40e_free_pf(struct i40e_pf *pf)
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
@@ -176,7 +222,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
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
-- 
2.50.1


