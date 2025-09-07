Return-Path: <netdev+bounces-220668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9FB47A5A
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767F417917A
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436F239E91;
	Sun,  7 Sep 2025 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZisOWQuE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338023ABA7
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239531; cv=none; b=kh3RPvG/sU4CKKNV1zL+7FvMLtyK8SnfHLz3IF8ywUqsESBQC4SqCr1D/DEFetT4rqcdLAFoAAMnP3+ZZd6MhFVY03t3bPI7j3I/FidHn/5Y9o8aTJyTICCBlgWQ+lgG6mAN7p/I/xm8pRVVc/T2k0XVwoGZareB6IQlSP8dQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239531; c=relaxed/simple;
	bh=hRVYjpUOPDXKwSCfunaXYuTjHjfowP0q/Zx75pPwQgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCxqX+KUpVg63clh6his5rGoxNEyZl5UVnAun2sfoFdi9hVk1wXdV2W0wLqWMGdjikqpv9YescUstkVPimZMss3eMz1XWkC23TEzkuvlYAES1Q03uLTinRMN1eUkq3ro5OT6XZxMFyFrgDNBrkWUMvNJgH55JDJYTq+I8k9FxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZisOWQuE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757239528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/7yXl0qQW7gwa6AMhvoMYK1QGWL3FdKHDNDcG6o4/o=;
	b=ZisOWQuEkejGBl3qYOIpd2WByCh7Ds1mLZbFGJunSvxILOgQWprz74QELyNaPjdtwhHSP0
	zCVho5ZLzAZ7U+HsP4R5H6DbRj+5DqcIy2//91Psqz5ucyiZxBXSZPFTNJCxZu/m4CI/TT
	iYUj95Q4shFRS9UDyrXH3uKvh9aubvQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-A26D4uAyNhyEOk9v7fDN8w-1; Sun, 07 Sep 2025 06:05:26 -0400
X-MC-Unique: A26D4uAyNhyEOk9v7fDN8w-1
X-Mimecast-MFC-AGG-ID: A26D4uAyNhyEOk9v7fDN8w_1757239525
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df2f4aedd1so2516926f8f.3
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 03:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239525; x=1757844325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/7yXl0qQW7gwa6AMhvoMYK1QGWL3FdKHDNDcG6o4/o=;
        b=elrYO16b279x8wuo9FeW/P+SXU8EYHXxnJQrVPDouOPPiJY2iyhKDQotvSI6Kk9S+w
         QF/dbw+sPET/QQw0UZiaG4yu7xt+GV8oExxvtzg4AzrPtcNXra6OVDUZP2X17cuWkI3S
         1NMUKlhWBHWK2T3Jomr8d3dW/8aA6dORtDOGbQZERInGFKhZc3llEOg7/OmPgDr4lS+w
         M1svrMCiWoNiMMlzYjhtLidHOJSIi/L3rZTwDQvEVgxIwSVY8/Byph/kc3aWRHqfwllO
         jgL3KZiRF8skVfi1JUyHa5dovzQ56EC8ci1EURermBbyvbRDeR3oGztnJzlK3PW51ZOQ
         AQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcf2+bjrQOio7YsgRDaLzzICZ9khjbkm9G6GU0kKnKSNjeFpqvLCr2N2Xp9Qp6BeHJBV4QJ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLv0lotyX+VaCZY+YxFVp9yfFTUebGsdHwEQCf4RfhxI4+fbig
	/3koIErmQCAvG218ud8Kd0DveH08wf4d8tdQWZMUJSTEcGk+osAmJy59tlMPmxVaVnZtsI1OxAB
	sK3eiX03RfZA+Pu7b1SxeNkIC1cFZ8J60ARTwF3A2TVkTMoI6XFREjSVDvA==
X-Gm-Gg: ASbGnctZYm4LZUWbZkZii+uAjJN2tUDFerM4khFSyssofYa+5oL+KOsY8Yqe57dZ/ao
	znc8/kQbEN92QcqYtypt4qlX0kQN0YS727W97UoLk0cKdkGN94Cruy7XbBxIhCMUjshkvlkG2SK
	5dRcXeiTHqfOUAA+CDrR2icuCnSas+yIkCRpyBbwdIEe+nvCz51d87772gp70DpgyJitPFUmmoW
	Fv5EudvW6N1SQebjYMkEzsqr9K/bVnQxSsA+XEhPZMx6uqfeZuKap0rb9dUzBJbS76GO6FtACig
	CaJfk3TakRBVpEPn1k4wZ7aKdYLOjF6Ye46K/CVuqr0U
X-Received: by 2002:a05:6000:2f86:b0:3da:484a:3109 with SMTP id ffacd0b85a97d-3e6462581b8mr3290643f8f.38.1757239525170;
        Sun, 07 Sep 2025 03:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYCSrZSomb6kHFh8RlMnid6Isf/VI4Pnbc5c/vbupGaHQatOngkLKzM2GfUmG4PSvg8vTdyg==
X-Received: by 2002:a05:6000:2f86:b0:3da:484a:3109 with SMTP id ffacd0b85a97d-3e6462581b8mr3290620f8f.38.1757239524673;
        Sun, 07 Sep 2025 03:05:24 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db72983560sm19323344f8f.1.2025.09.07.03.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:05:24 -0700 (PDT)
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
Subject: [PATCH net-next,v4,2/2] i40e: support generic devlink param "max_mac_per_vf"
Date: Sun,  7 Sep 2025 13:04:54 +0300
Message-ID: <20250907100454.193420-2-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250907100454.193420-1-mheib@redhat.com>
References: <20250907100454.193420-1-mheib@redhat.com>
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
---
 Documentation/networking/devlink/i40e.rst     | 32 +++++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++----
 4 files changed, 105 insertions(+), 10 deletions(-)

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


