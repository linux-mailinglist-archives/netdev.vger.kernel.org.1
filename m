Return-Path: <netdev+bounces-219681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F309AB4296E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B341BC4B2E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067A2D29B7;
	Wed,  3 Sep 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is2Kp4k/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B42D660F
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926180; cv=none; b=qkfcxjWB7TQu/GdffmG/Ie7WyyA3RIvyMu/2ybl1hSmGoyu+wmxNBywJF/LeVemL3Io5NUV7cS46km8tm7GZm33sOOzpLrNwymF6g+YmPgGWMRZJw7afIdeH3GrCdhKdDFWOaDJrsWVuSmJS3pxUWr5bOeKvhABtkqNJNyJru5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926180; c=relaxed/simple;
	bh=jtApd2ZeWsZxj/ZI+3k16eU9crBCEEcddrRCQsgIc2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9SzST/Fh2niWtrZKrFfh/4wfOjLIUgf8VDgVWBCsHwJ6cVtcAcgrdD9n5N8Kxkb5IYbcrCNo61xNhIhETqCE5TloVl525+8VB7kqfFx3tYmhLRwx0UlR6m2v3iAUIf0ZipACeaVMiY/EqI9+V6wFWAOu2Yue2bWQPJoOwioUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Is2Kp4k/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756926176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuj6/ynYvZNCMQC+NtWMjW82+TVK2toqfMK12UBW0wg=;
	b=Is2Kp4k/MTb8uSmQQ0MvEbOpoiM0Nnl6BjKDx/MzITGeh4FY/uXY6TGVrBBUEHGs6Bak55
	p+vS5uaw17jswxBPZtaoMsJwiCjVVdCssibez6OeRD5SIybQVZGKxkq50QbjNqxE6P6Nl5
	G1hzwgpQp1F9Ur/UzI9PE4Z8KEIBVBo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-XYeOPqcxNNiJe9TIOGVbmw-1; Wed, 03 Sep 2025 15:02:48 -0400
X-MC-Unique: XYeOPqcxNNiJe9TIOGVbmw-1
X-Mimecast-MFC-AGG-ID: XYeOPqcxNNiJe9TIOGVbmw_1756926165
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so1927775e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926165; x=1757530965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuj6/ynYvZNCMQC+NtWMjW82+TVK2toqfMK12UBW0wg=;
        b=lPcxTDH/ZEUFHAX/XTKNXKCRH4fX5/Bvr/PGbORI00szo9kelCXTOF6H/LBINQo1AW
         rFD5bLA7qtc6BJNmQGkS2jucnaXWikxQ26epBrYEnZpgpTvjGF5Oba4YpK6TA3P/lwtf
         VwgVTqC0wuIRWEY5wRxjflKyrPqmdotfChpi0GdjL/QCT0k/quNeFd5vpf8/LAENfCcu
         XpGyQnG5xI+pjiagdcj4wpmiAhNEenrch1DkjCxt56GEescft+3SQnZABjRwunfbMrxo
         9mkJ3C1BKC89BdX8aYXugyznTQUod+R+S3n9lbfUYbImuXgsXQMFnTKan8OSP8h6/6r0
         HHDA==
X-Forwarded-Encrypted: i=1; AJvYcCWhegVc/+KUqodn51h36ryyOHLyGJ56DOzRLN0LLzVstDNzRgzL8zAQiMkYsvwkIZOeYMEGdWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDg3ZgvSAKIsae6fhbZBgoRO41jgVAiCcuBUGvUF4Iuzpl26zS
	W3Hf4H1vDfFIvC54QG8VYp5cl76HfFN9Laio+Jt8TsWCER1rggmB4/+wO4PjVVQLvvJMbr5wTGs
	ftHAivus8lV77QSMp/FTXypRTIl6JritkGlHR3BSj4evgnsoPaDNma8/QPQ==
X-Gm-Gg: ASbGncsmJgkjuRQgNbYqQ7Ej8F40OIje0Gz23UmjwxqT7DlBptlNcLcR9nMAHRRiCfN
	VM2YHFYButaC/yb8Pb5SEsE6kacZbCLmAVxEgC1vkw0TXs/GG7W58gca6mhqepo5BwRf1VY+hTy
	1zQZ72fRGdgY62LjcAhRO215yl+ghJzItlp5/SAR3/ZBHs0gScBhbhf+cH7lEIa6M1zQJrFDlH8
	L0H2wiW7JUI0n8C0RGUAKz9b8UUcEju13ZDHSJXPP+dKKFUCQI6KCG05mU158ooaJ/6gGhIrjSW
	+JNgGX4ynGGWtPa5Oscpu9dg3WLbhSvEFsWHdj2Qg1G2U1c=
X-Received: by 2002:a05:600c:4ed3:b0:45c:b549:2241 with SMTP id 5b1f17b1804b1-45cb54923d6mr26593335e9.27.1756926164930;
        Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGfe6sRBehSXUl814xMt0UzzbnzlGvmUMrebVIF41OwNzF4h3DaViA7EblSEd/J7Ia4fNPg==
X-Received: by 2002:a05:600c:4ed3:b0:45c:b549:2241 with SMTP id 5b1f17b1804b1-45cb54923d6mr26593155e9.27.1756926164395;
        Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
Received: from fedora.redhat.com ([2001:4df4:5814:7700:7fb2:f956:4fb9:7689])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm331978655e9.4.2025.09.03.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:02:44 -0700 (PDT)
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
Subject: [PATCH net-next,v2,2/2] i40e: support generic devlink param "max_mac_per_vf"
Date: Wed,  3 Sep 2025 22:02:29 +0300
Message-ID: <20250903190229.49193-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903190229.49193-1-mheib@redhat.com>
References: <20250903190229.49193-1-mheib@redhat.com>
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
"max_mac_per_vf". On i40e, the parameter affects only trusted VFs. It
provides administrators with a way to cap the number of MAC addresses a
VF can use:

- When the parameter is set to 0 (default), the driver continues to use
  its internally calculated limit.

- When set to a non-zero value, the driver applies this value as a strict
  cap for trusted VFs, overriding the internal calculation.

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


