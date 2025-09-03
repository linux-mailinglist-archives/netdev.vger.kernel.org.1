Return-Path: <netdev+bounces-219477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB8B41783
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23463B59F1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A42E1730;
	Wed,  3 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f80OpfzR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AF2E6126
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886338; cv=none; b=ORGgJGc8JtiDl7zWREkFQOiDc7IKu4jrIQQ+q/5T1c02wdlzlwAUUsO8EARo05TDzDo2astIteW4vcy3W7JQ5COUJyuRUTiLXZ1zK/pOmM9bnSd66eDoZCgdJtOmvEQAQYs9+DiBAnkPBonBNMwayH+oRlomrBmx2pABhPiIHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886338; c=relaxed/simple;
	bh=AYw2Yp+S96GZnFFiNqI6TM9iDdIBh5Qtd6Ia5fq95cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG6UCmySwLpJiXi5Gv/Fz69yvb1U4bHdJzND4sguk5KeBPTMdi+yZ3mUgg0sFscVlBS+qoFtarQ/IOUl/ht2fN1ZX7Nq3RMONjCxJiIGgt1nh6VMmwcumaeJoEF1Mt2Urn/4Pesv6jdHQTxU6RhKdcyKw9a7H4nHZbyDAqhcK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f80OpfzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756886335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNKb6p6pocOW/C+6sxZfv3rhI5CAgcckWlo3n+yWenA=;
	b=f80OpfzRoDpiM2J2P81fIA1msblckyzDByMliDknL/uhhZZk0n5pq8FOlQ3fJfTjfMo2ip
	u9RO+zxldpvevSVlkH/1h7nJrquHuJfwYa7m7q2tJOrsBiK/ge6lntacF/JX2YE5J/jTTk
	bqmeb4U07IXfgIOs8TkOYgjpnueKA5Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-h6tUNdLYMGyrtWUXBsoMCA-1; Wed, 03 Sep 2025 03:58:53 -0400
X-MC-Unique: h6tUNdLYMGyrtWUXBsoMCA-1
X-Mimecast-MFC-AGG-ID: h6tUNdLYMGyrtWUXBsoMCA_1756886332
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so8725245e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886332; x=1757491132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNKb6p6pocOW/C+6sxZfv3rhI5CAgcckWlo3n+yWenA=;
        b=NEg0eJvxLY3WDRbYGwhU2b/o00arN8slYLSB9nc0ZjSbv47ni1jMAk7M0uCYv0NsWO
         0R5Rf66/w410rcrWH5ebv9TUKdgKOAT4gajU8ATglX8SsSO4YqxfSlYV0EOfkW6Dfnjr
         Sf2byLpAqN1bizvgUqzEUOff9nqzzuecZS6U9p5oj+k+YgCEM3besJgGzhWKTufZKE7M
         861lF6Z4UJ64oS9H7A4VfSdfvbDczzswfUx7hjLNLo5M0RQcI7XShcUawC4hgPBniECm
         /ozJCjtNGc5J+jpWE6146b6WYFmdzhcT1mKlEZ3eRwjjGl15Jd1ud366MTKqWhB7BGNv
         +IJw==
X-Forwarded-Encrypted: i=1; AJvYcCVI4iGvh99bnXM6q41EIv5HZ7/SVgvLDwQInH7OdenExJTM82P5S3+oSviJKX2uV3JM1Nv/Nmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFb7RrNVpwIq2kJy48niAohGssuLp6pAWZH2Se+aDq6NJ/ELS
	agmSJjvkS1hbxCbdkbv9be1RVxfuiA9/55sLmFO1Q50Y9xzSB+dwpI84lYOTtAWORT4lDteiEax
	VabMGU0E4mAbiMDnjYMcSk17moTcImdIIuHX1WKq0FsuxNUTthwDZOjKpvQ==
X-Gm-Gg: ASbGncsQ2tjjDopIjSxtKjyjmBruP7uM7zrynxMUPIe5hLA6+a2K1LTwCV4C+sWiVAZ
	xeRRVjWljE6a4uwfglQVTqvuL1jNYCIaawUrI14VVRmD524ZYLL+tOYHEsxYV6vO6tvXEzlGKvD
	qQvJBZcyLuDmc24Bn2+31I7uNBDaRIqh0wa8HGjLg+oV4D9wQZd9EW2wfg37sRqQ3Si41u9SW8R
	KnllmmgF46CwrkjHD1QZuBfigYQUbrny1m/2H8Gr8Nu2m7g98JpbitfBiGLcQ/AkH+W3FrfqOj0
	nvj00I6pHMD8Jegk4t7IBUlQBJNvNf+0hnWnbXsuzMXb
X-Received: by 2002:a05:600c:4204:b0:45c:b56c:4194 with SMTP id 5b1f17b1804b1-45cb56c430bmr6930035e9.2.1756886332203;
        Wed, 03 Sep 2025 00:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhF7d2mK3/iUK2rDy/VY/BcvmzRewCiZbFnuHo3JdB4WYHablU5vS5ClBtKdJRMfXhTEY9/Q==
X-Received: by 2002:a05:600c:4204:b0:45c:b56c:4194 with SMTP id 5b1f17b1804b1-45cb56c430bmr6929865e9.2.1756886331743;
        Wed, 03 Sep 2025 00:58:51 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3decf936324sm1002477f8f.9.2025.09.03.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:58:51 -0700 (PDT)
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
Subject: [PATCH net-next,2/2] i40e: support generic devlink param "max_mac_per_vf"
Date: Wed,  3 Sep 2025 10:58:10 +0300
Message-ID: <20250903075810.17149-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903075810.17149-1-mheib@redhat.com>
References: <20250903075810.17149-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Add support for the new generic devlink runtime parameter
"max_mac_per_vf", which controls the maximum number of MAC addresses
a trusted VF can use.

By default (value 0), the driver enforces its internally calculated
per-VF MAC filter limit. A non-zero value acts as a strict cap,
overriding the internal calculation.

Please note that the configured value is only a theoretical maximum
and a hardware limits may still apply.

- Previous discussion about this change:
  https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com
  https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 35 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 28 +++++++----
 4 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..3052f638fdd5 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,41 @@ i40e devlink support
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
+      - Controls the maximum number of MAC addresses a **trusted VF** can use
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
+        - MAC filters are a **shared hardware resource** across all VFs.
+          Setting a high value may cause other VFs to be starved of filters.
+
+        - This value is a **theoretical maximum**. The hardware may return
+          errors when its absolute limit is reached, regardless of the value
+          set here.
+
+        - Only **trusted VFs** are affected; untrusted VFs use a fixed small
+          limit.
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
index 081a4526a2f0..e6d90d51221b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2935,19 +2935,26 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
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
+	 *   Note:
+	 *    even when overridden, this is a theoretical maximum; hardware
+	 *    may reject additional MACs if the absolute HW limit is reached.
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
@@ -2961,7 +2968,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
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


