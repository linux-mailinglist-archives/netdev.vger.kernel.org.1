Return-Path: <netdev+bounces-215846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E991B309FF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7465A844F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE02EA475;
	Thu, 21 Aug 2025 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J41ohz7E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA02E3AE4
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755819582; cv=none; b=jeie2RIf+topEIHut4widjy7vLu+mMk1AxGDwyW5L0oJ2+ypaLpjm6/soOvYt8mOx+f9boqKtqvNH1cpdP9X2vd1uQBLEr4Ho8C8fSm7BLXxNUsKqu5ZWFBeUj1AlunRjy2J6zXWZdH4wSqHpS6EtwWCAVTE8zG15hHH46/TIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755819582; c=relaxed/simple;
	bh=TzZGYNrk9DGtCzjG9yskV1JAaBtTbOC5VAVLqJRg5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QffeMxPwLx8gqWJKAfJc9WWnh2OvKznREg3JVA5OESG8KpATbGxv0ZqWUqd11MW7dpDM3TTRtyVaZiwbKzLa5Ntnuba+THYTYMZ3TOzp+QVXFm/84svW5Hr6rUlDg2ysN+KdU9NilRCqf6HrO8Gt+6t6044P4goddERpAOHMwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J41ohz7E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755819578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dPEjACfdGEHu0JkXuoejITxEDtXCDfsHGkFKldzSeW8=;
	b=J41ohz7EIFmZDfP4Ts0NtZLc4d0M5dsHi5Ow3+r3YZe892tUN8+m7V89MK2c9phpUBR1VZ
	q7hJEyNdW2X2k7LALfpK5sZNJwIWnYVg2F9kzRi056lM353NRPYJEaEVlk67U5JSlX38j+
	N7IV3wggOZo3Bnd3oUgkKmQEeyACqLs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-31P3ZH5lNDyRJwWGa2qFqQ-1; Thu, 21 Aug 2025 19:39:37 -0400
X-MC-Unique: 31P3ZH5lNDyRJwWGa2qFqQ-1
X-Mimecast-MFC-AGG-ID: 31P3ZH5lNDyRJwWGa2qFqQ_1755819576
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109a92dddso46750061cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 16:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755819576; x=1756424376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPEjACfdGEHu0JkXuoejITxEDtXCDfsHGkFKldzSeW8=;
        b=STtSwiKCxhUshfSxRw8VjAkTgihoSDkFSbf/kewliUewj3vAAhV6ZD+8pmAb4eLqig
         5/7+Y3ojWzTu4Hyg+u5y7ROuiBJ2AMltLFzT/ufK7JKJKTyinbapmjBbEvmx8oEfg8x1
         A5/2YHcMPbrWix5Phdj0TMM0PWuq/hb/R6A7TeRZ3WJrKhsWESQEznmm/Exf3Xz8v8Sz
         67cjjFpD7xj9dDPEPeeXQsJFnTvoIhRdUtKSGBbJz7dLUehMc3FAkS/vgO6LecLVFvcE
         dCCE7gD+Y3sCP9QwmlZFnk/+n0f2W/kxLGGNJOJkSgoWeOLqfYmkMhuzQP3zdDohkplP
         LwnA==
X-Forwarded-Encrypted: i=1; AJvYcCWarQ+bPzVKWxM81q5ZbFc62kCO6WWkEfozfTuCPRI+622Fxvp+akiFcTgLDQ7QjGlyj/6yXRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvsJgQXV0LuP4ArhsZLQgCM6xmKnW6vpW+OGs7ZNtNcfzb1uSX
	Lw47cuGHpNFKpaeYeEV1mDekWI7d1/MmlDGq/Cd0bO2wSzKfV/QfGa5FsBnuofYXNmaLiFqz4AF
	r0aBnKuriOEdem/7T/hxp5/2vwteSkZoutt6yQDh8DbKt5wWmc0lDr05T8g==
X-Gm-Gg: ASbGncvWo2zGmt4LNfkifLUlJ+/fF2iEPqgexvURVA0R4O+4BQ7vYtvmYLCDT68Vy3Y
	sw08zdbSyZ1W4IRNQOCr72qKhuXEAwKB4xQvjLLFu6IqGoQgWdnKXDFoHJs9LarSVm2NHFtMHs3
	zhkIp/O7z5oJoe3lKhce4VPEFpsK47Qrw2C8Z03WuBtUVbrIN1T6+2sdDH6u5PC1oKfNS89oLP8
	kvXINnxhgViRhiGHg09AIDkVeCVUjn9I47EN1vpW3VzMtq27vm2WdEXo8VYtj0RbURf23RYFhDS
	uYMhHqaP4oAXH5R/v2k6xttMpvKwnvAnC7x3aLr90r9v
X-Received: by 2002:a05:622a:28f:b0:4b2:8ac4:ef82 with SMTP id d75a77b69052e-4b2aab4c366mr15877131cf.81.1755819576531;
        Thu, 21 Aug 2025 16:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRrj5eC7J8wzGSLIZI5lp4gdyL90oThp2IIL3gA65kw5819iq/kYNJGM5lN3fMdWmK6OHWA==
X-Received: by 2002:a05:622a:28f:b0:4b2:8ac4:ef82 with SMTP id d75a77b69052e-4b2aab4c366mr15876911cf.81.1755819576105;
        Thu, 21 Aug 2025 16:39:36 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8727sm112032351cf.39.2025.08.21.16.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:39:35 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] i40e: add devlink param to control VF MAC address limit
Date: Fri, 22 Aug 2025 02:39:30 +0300
Message-ID: <20250821233930.127420-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

This patch introduces a new devlink runtime parameter
to control whether the VF MAC filter limit feature is
enabled or disabled.

When the parameter is set to non-zero, the driver enforces the per-VF MAC
filter limit calculated from the number of allocated VFs and ports.
When the parameter is unset (zero), no limit is applied and behavior
remains as before commit cfb1d572c986
   ("i40e: Add ensurance of MacVlan resources for every trusted VF").

This implementation allows us to toggle the feature through devlink
while preserving old behavior. In the future, the parameter can be
extended to represent a configurable "max MACs per VF" value, but for
now it acts as a simple on/off switch.

Example command to enable per-vf mac limit:
 - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
	value 1 \
	cmode runtime

Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 19 +++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 14 ++++-
 4 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index d3cb5bb5197e..4bdc7c33b2b3 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -7,6 +7,25 @@ i40e devlink support
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
+      - Determines whether the per-VF MAC filter limit is enforced on i40e devices.
+        When set to 0: no limit is enforced, and each VF can request any
+        number of MAC addresses (legacy behavior).
+        When set to non-zero: the driver enforces a calculated per-VF MAC filter limit
+        based on the number of allocated VFs.
+
+        Default value of ``max_mac_per_vf`` parameter is ``0``.
+
 Info versions
 =============
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 49aa4497efce..4a4cb55b6ce8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -574,6 +574,10 @@ struct i40e_pf {
 	struct i40e_vf *vf;
 	int num_alloc_vfs;	/* actual number of VFs allocated */
 	u32 vf_aq_requests;
+	/* If set to none-zero, the device reserves
+	 * a minimum number of MAC filters for each VF.
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
index 9b8efdeafbcf..020517b1a3f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2949,9 +2949,19 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	 * all VFs.
 	 */
 	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
+		/* Enforce per-VF MAC filter limit only if enabled by
+		 * user/module param "max_mac_per_vf",
+		 * Currently, the parameter is used as a flag to indicate
+		 * whether the per-VF MAC limit should be enabled or not.
+		 *
+		 * If future work introduces VF MAC limits through devlink
+		 * resources, we can still use "max_mac_per_vf" as a fallback
+		 * for the maximum number of MACs per VF.
+		 */
+		if (((i40e_count_filters(vsi) + mac2add_cnt) >
 		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+						       hw->num_ports)) &&
+						       pf->max_mac_per_vf) {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
 			return -EPERM;
-- 
2.50.1


