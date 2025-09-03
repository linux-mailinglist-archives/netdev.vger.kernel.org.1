Return-Path: <netdev+bounces-219710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C6B42C12
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEC156630C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669422EC08B;
	Wed,  3 Sep 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbzAwtcs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF41A7264
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935804; cv=none; b=bT6+8K/BbL5oRsl6TMYG2oSf24EhyGF/jDZj1q4VBVMOqO60gzM/Jovc8CCkORtT2/ou7Fy7DUtFgkhGgFxg6Pb4LtppC/teamP6n1wVWBm+hoqHn3MkXSEJhpzXwPyXlpRcL2cVJS0AaEK/vDXmYmlaqv5T9Qs/gqBDRIuDDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935804; c=relaxed/simple;
	bh=Qr70gD4oeMlQ4hQY5AUixqYTA1Zv8k4BE9mjTHwEK4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riF83siv2H8nHGIv58V29TNPGxm5kNl7hOMDhL06FiPGu5pwQlRJq70pTTPQk2OjlUNG4iLVsfyGpsXQBJS7ls7irV8yjW9I8J9uTuR7sFynUTIx1jEohhUkrxXNW+VhD/bvuJNUqaljHbkNBBM7FRoUTpGdi1g463W3xUDcfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbzAwtcs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756935801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlfl+ymrxqrkR6VsHpIygLrlWaJMalsml29q6ojxouU=;
	b=DbzAwtcsL+qzntJk50Pt7h2/OgW/hIKo8MSpfNBXa3WjJsD7FBWAVCikZGsze/p+0zY3th
	D2uQy5yjF71+sEC2OWVnZR0daBahWXiykHSBV/861YB4ajW3sFHXs1XhmJy6038d/FJAkW
	vNz9eHjcTiE40n8uzAb+w2l+7k1kqkM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-5mVl2GwpMje-etqBTuRtdA-1; Wed, 03 Sep 2025 17:43:19 -0400
X-MC-Unique: 5mVl2GwpMje-etqBTuRtdA-1
X-Mimecast-MFC-AGG-ID: 5mVl2GwpMje-etqBTuRtdA_1756935798
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e014bf8ebfso177529f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935798; x=1757540598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlfl+ymrxqrkR6VsHpIygLrlWaJMalsml29q6ojxouU=;
        b=MZ9o/V6rso49iCllEEsY3f8/jvSszPXgFtK6m6fJgXFZkuAWnBEOuDtMsB2zFjob6E
         v/P2mXtdoJmN/po3f9XT7NKTD/+Gu2zjUlL2qlGTQnCvzQwMJoI1+kXlh/sDclftQVn5
         meYNyAc3IBHu4VqP07c1wm2agX1q9JRAKfUT+cUeSwKTZhVe0NtpfLt+es5rJy04mVKI
         QHJmaKOTqISgS+HNXXkm8KHjW8xd28QeWZq/tcTtLHoM87DS0kiNAl4CNsHLTUeL/dfz
         cfkZaEnXk0Maj9EEQ9ToJ23gf8XYSjXVHrqhVfozVxXvIJer7gSLUzswWSRKLAPnEINb
         i7kg==
X-Forwarded-Encrypted: i=1; AJvYcCVtBvOnZemYnTiz61isNtslBZN+ZT/GCyHmbpyWFkWYMRNl5tii5WGpF68mXM0Jj+4evKtBx+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBy0lsR7ZUQxMUQwIy9HI8OPRbTUm67vLqZTHRkpC0N4JYDCq
	2J9Rua3PED51CoI8nvyuzcbilTD4cRo+f0V9h8k86mgbqShES6OrepyBt0gFgZIDtL8dxU1BVnf
	tH+qAug1xUNeJalSVTpn8oSGSKjOvKoS2MxziRP8x4hwHmYD84v9BgPX3lA==
X-Gm-Gg: ASbGncvL1nPKmhnInw9feV0M4Vk3r0f6HIlrSuCIuoKa8mYiZ0Cg3mnr1eJWUubuq9U
	szq0qGdwzNPNF1YsYMyMlHL+KQFflYEHBDH0rQjZcUAu+1RKqzh+6MDCBs1NCO0hrMHOQ+p8w53
	gjJoKxJhJLMSDEpT76pMIBHm7WSuvjZMdPxSBbIPefkp+FVMkA/hdX57c4YrahduFUVXJ1u65Er
	xvue8Jesys9VpAGubzpMaxYBS9Jq9JcfgUaMrY/SQHyLATT/Y+63wxnLrPMZUPd3Ihq5W3luUcK
	IzVoitkbUJ+itQBR3V1Mq661viOC2EXnXXd4MR2YDZvd
X-Received: by 2002:a05:6000:144b:b0:3d9:70cc:6dc1 with SMTP id ffacd0b85a97d-3d970cc6f4emr8255703f8f.6.1756935798167;
        Wed, 03 Sep 2025 14:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZu9hA/7PLviQ4gIWA7oM5crom8Ph7AzFyaj1R55D4GAmgifp7G1T9eRvT4my+FOozDc0MOQ==
X-Received: by 2002:a05:6000:144b:b0:3d9:70cc:6dc1 with SMTP id ffacd0b85a97d-3d970cc6f4emr8255685f8f.6.1756935797706;
        Wed, 03 Sep 2025 14:43:17 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm25529918f8f.13.2025.09.03.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:43:17 -0700 (PDT)
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
Subject: [PATCH net-next,v3,2/2] i40e: support generic devlink param "max_mac_per_vf"
Date: Thu,  4 Sep 2025 00:43:05 +0300
Message-ID: <20250903214305.57724-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903214305.57724-1-mheib@redhat.com>
References: <20250903214305.57724-1-mheib@redhat.com>
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
---
 Documentation/networking/devlink/i40e.rst     | 32 +++++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++----
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..524524fdd3de 100644
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
+        - MAC filters are a **shared hardware resource** across all VFs.
+          Setting a high value may cause other VFs to be starved of filters.
+
+        - This value is a **theoretical maximum**. The hardware may return
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


