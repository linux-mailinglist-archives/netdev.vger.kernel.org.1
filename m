Return-Path: <netdev+bounces-217701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656C7B3997E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773B81C28141
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0C3090F5;
	Thu, 28 Aug 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZLpE4AK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820A3090E1
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376221; cv=none; b=RvWIYC4i7EXRoYHag9IEJi2VyInGKA7NWySO+plUTPe/hOCxMAVpyMaF6ibJyppPDQ5WyACzrs2zcoYDvAykpUJw14mgxW6kDu8HX1V8umolMoV+mKVULCm7KagWa0RDKWjv1UVfstKRJLTAzOr0xOpizGawK48chzC5OZe2wm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376221; c=relaxed/simple;
	bh=Fp/Nuv4Kqxco0W4EvI6r9CY6UevNjcBkH6IqLqxB93Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LcwBXV/zVNAWUZdi6kJm0SL9yY+vYqoc89+BGBpW9PU2oXtsU/W27t0YniKhPZw/DY7sXpvMm5NHIC/1HaOQEhmWVC0/z/AdECPSz2y3Vyee4gagbgQm9V/aNrjafGmdfSFAe2qo+9akKrPmgwlIITyj5wdG3dYy3CVdk7YrXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZLpE4AK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JQs3plsdww5KIPefy/qyCbaIMlCKniyjtsdxcjVftN0=;
	b=fZLpE4AK/OmwnS9EHEUSZUDzm2mi5FcnN7R2n6YvKDb8ZLXu+o9E8UOTVsF4YTVS2AcCS1
	IndHVU5vzXt40xY8iuxanoHQVwZpE0/fNTTk2E3Dus5sao5OdTrbnplIWJ/pDRTPX7ZtXS
	Zz87bTIBSmDtAM1K5dwTwOFQmhZjK50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-A1ORHXGdNRmz-K2Fiy1Z3g-1; Thu, 28 Aug 2025 06:16:57 -0400
X-MC-Unique: A1ORHXGdNRmz-K2Fiy1Z3g-1
X-Mimecast-MFC-AGG-ID: A1ORHXGdNRmz-K2Fiy1Z3g_1756376216
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c79f0a6084so440724f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376216; x=1756981016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQs3plsdww5KIPefy/qyCbaIMlCKniyjtsdxcjVftN0=;
        b=PbKEP0yfH4iB74l7ALVLSYK9mm0brpTUXV2578S8NgK2+pynjaQMHaVfbS2fMhixx0
         XUG2NfcBPi/whOBFTMoa7fFQBx3I4VDLfD1+2nLvAJRYjHsvWFkSpX9l+ScTTiTYAKah
         /ntoc4fV8B5H6JvR8TIR7rFES1Z9wtTfz2QwNIKUUHn2tGV2M96msSakzaF9yM28p0E4
         UvUtnlbs1CUn3E6R+R4yUD2SxBITlGC2DI3uqRQt3MAg74YYYHkIEauhNbYL8IDCXlmy
         SQmWUWYkWRL/xW/6xW10Db8APvArZSdTNnFBWbRVnqw0z2rbtH49dPVSkXNyBsB9F0Ln
         /hXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZV7S+hwzmsHKLo6GIxwBeVKyz9uIyhn32Ozkk5l9ar4KFpUcwP4fe7mrciFeGxX8MFt0eEmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDv5CM5+FXAFsUHoskC1IrgcxMu0DuKTpbdOeFziTiaoSYsP0z
	+EvS2Mwi5ziKn63WXQExBJg/Zo5HYZfWdEubFqzqLCGBtYhd+E3+s58j/t/y2idwKzjohdRoWr1
	TXttzKIvCb5ptVHS1zGeXJ7pcp+ap6C3YtrOmeRpd/YIEz6MAix4ZqTSWaw==
X-Gm-Gg: ASbGncueY6Mc+AyY2TArGvbRYxz00skCdja/dKuQBzCTeKFsyTKEZpKDxYFo2vy6ooF
	HuSoc3QEbLlgwBAhhApG6LrIqZN+aliHfT+WmfI3kIELy0ix1uwFagSYO6XV1GHjVfixizWZJKE
	PeCy8dnat+11stYkvhYWQ1yxMVV5JNu4kKy1Ci2Yuc8tWaYQXPzRw6Da0sHsx/kb0lyLlg3TGZ9
	t9v1IDOF7lOzgHsMMrpkzuqoTbZAAtqlSslTrMheaXPBU1uZZjeIXTTgslizgrhSpBrWCXX7nMg
	q/NPWE1qkIoYvMCa78nkgMY5Dtj4uHw+YHiKE9BApP4r
X-Received: by 2002:a05:6000:26d0:b0:3ca:ba4d:ef71 with SMTP id ffacd0b85a97d-3caba4df136mr9123520f8f.62.1756376215766;
        Thu, 28 Aug 2025 03:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2XNld95zfpx8WQOhQ2WCBTntrUOlS042JWgWXiKm/73hOMN5cqLDFdzUy9zcHXli01bB+QQ==
X-Received: by 2002:a05:6000:26d0:b0:3ca:ba4d:ef71 with SMTP id ffacd0b85a97d-3caba4df136mr9123487f8f.62.1756376215253;
        Thu, 28 Aug 2025 03:16:55 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cd3sm23804466f8f.40.2025.08.28.03.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:16:54 -0700 (PDT)
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
Subject: [PATCH net v3] i40e: add devlink param to control VF MAC address limit
Date: Thu, 28 Aug 2025 13:16:32 +0300
Message-ID: <20250828101632.374605-1-mheib@redhat.com>
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
 Documentation/networking/devlink/i40e.rst     | 35 ++++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 55 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 28 ++++++----
 4 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..6ccd7501491a 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,41 @@ i40e devlink support
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
index cc4e9e2addb7..9c7476abc6a2 100644
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
@@ -165,7 +201,18 @@ void i40e_free_pf(struct i40e_pf *pf)
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
@@ -176,7 +223,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
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


