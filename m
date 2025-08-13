Return-Path: <netdev+bounces-213462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46748B2524B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3457D7B5F8C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D829DB92;
	Wed, 13 Aug 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV5rDIu4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C229CB31
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107089; cv=none; b=hAlarVh6iqRVxrJVBycHza41Tho/dMR+YVatFtR6xVh5T80dmtPeyLYEMhNQML1ZxMnlkhc3qLHexCShwZU9sUfuvgl5X+VlxFaSrDKdT+TOfJau5fi7zkSTS0KyoVMYJB0KqWvhD0ZhNY4t5Liad+GmwkeXd/rRWOTPZWZ5Utc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107089; c=relaxed/simple;
	bh=4K+2jOKF+IefHFO0X7Hz/d58sXSVQhJaaaB4s1aokAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEkJZDgRP4LfuzR025x+YMPrLobYp0V9vJmsliix0YRbt+epFbYgbKuhW9ykBnrujADiZUZjQJjNO5xo5FpA1lZIyZeMVCy97Bw2pxmYf3SL6ciGAdUpYmMGw4Ju06X7qS0/fQPCapVs/BI4f/ZPc0fm9QyYuxukn7qCqcV/RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jV5rDIu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755107086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AgzuYGOf8wOkg85gmWURfpvM+Xe7IJedgyWnwdHVn0=;
	b=jV5rDIu4VDAd5OYGNwkVL3euZX2Pkjj4yDI/qKW85+NTzzo1BhY+a1KohhzCcuvgZ0m47f
	7RAQsJ9lbgojWpi/SStycZpe2dyVPAqwAdvTtp4F+Vt9EK69qpWGXTop2VVvtaW13qW16f
	rGsbl4SA4rlLLRCwG4xPsLgkDmtIjYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-rNowux0IPfiZDOWYXvXkew-1; Wed,
 13 Aug 2025 13:44:43 -0400
X-MC-Unique: rNowux0IPfiZDOWYXvXkew-1
X-Mimecast-MFC-AGG-ID: rNowux0IPfiZDOWYXvXkew_1755107081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ED9118003FC;
	Wed, 13 Aug 2025 17:44:41 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.146])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4513A180047F;
	Wed, 13 Aug 2025 17:44:36 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash callback
Date: Wed, 13 Aug 2025 19:44:08 +0200
Message-ID: <20250813174408.1146717-6-ivecera@redhat.com>
In-Reply-To: <20250813174408.1146717-1-ivecera@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use the introduced functionality to read firmware files and flash their
contents into the device's internal flash memory to implement the devlink
flash update callback.

Sample output on EDS2 development board:
 # devlink -j dev info i2c/1-0070 | jq '.[][]["versions"]["running"]'
 {
   "fw": "6026"
 }
 # devlink dev flash i2c/1-0070 file firmware_fw2.hex
 [utility] Prepare flash mode
 [utility] Downloading image 100%
 [utility] Flash mode enabled
 [firmware1-part1] Downloading image 100%
 [firmware1-part1] Flashing image
 [firmware1-part2] Downloading image 100%
 [firmware1-part2] Flashing image
 [firmware1] Flashing done
 [firmware2] Downloading image 100%
 [firmware2] Flashing image 100%
 [firmware2] Flashing done
 [utility] Leaving flash mode
 Flashing done
 # devlink -j dev info i2c/1-0070 | jq '.[][]["versions"]["running"]'
 {
   "fw": "7006"
 }

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3:
* Fixed return value documentation for zl3073x_flash_update()
---
 Documentation/networking/devlink/zl3073x.rst | 14 +++++
 drivers/dpll/zl3073x/devlink.c               | 65 ++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
index 4b6cfaf386433..fc5a8dc272a77 100644
--- a/Documentation/networking/devlink/zl3073x.rst
+++ b/Documentation/networking/devlink/zl3073x.rst
@@ -49,3 +49,17 @@ The ``zl3073x`` driver reports the following versions
       - running
       - 1.3.0.1
       - Device configuration version customized by OEM
+
+Flash Update
+============
+
+The ``zl3073x`` driver implements support for flash update using the
+``devlink-flash`` interface. It supports updating the device flash using a
+combined flash image ("bundle") that contains multiple components (firmware
+parts and configurations).
+
+During the flash procedure, the standard firmware interface is not available,
+so the driver unregisters all DPLLs and associated pins, and re-registers them
+once the flash procedure is complete.
+
+The driver does not support any overwrite mask flags.
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index d0f6d9cd4a68e..96fca97446bc7 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -9,6 +9,8 @@
 #include "core.h"
 #include "devlink.h"
 #include "dpll.h"
+#include "flash.h"
+#include "fw.h"
 #include "regs.h"
 
 /**
@@ -141,11 +143,74 @@ void zl3073x_devlink_flash_notify(struct zl3073x_dev *zldev, const char *msg,
 					   total);
 }
 
+/**
+ * zl3073x_flash_update - Devlink flash update callback
+ * @devlink: devlink structure pointer
+ * @params: flashing parameters pointer
+ * @extack: netlink extack pointer to report errors
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_update(struct devlink *devlink,
+			     struct devlink_flash_update_params *params,
+			     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	struct zl3073x_fw_component *util;
+	struct zl3073x_fw *zlfw;
+	int rc = 0;
+
+	/* Load firmware */
+	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
+			       extack);
+	if (IS_ERR(zlfw))
+		return PTR_ERR(zlfw);
+
+	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
+	if (!util) {
+		zl3073x_devlink_flash_notify(zldev,
+					     "Utility is missing in firmware",
+					     NULL, 0, 0);
+		rc = -EOPNOTSUPP;
+		goto error;
+	}
+
+	/* Stop normal operation during flash */
+	zl3073x_dev_stop(zldev);
+
+	/* Enter flashing mode */
+	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
+	if (!rc) {
+		/* Flash the firmware */
+		rc = zl3073x_fw_flash(zldev, zlfw, extack);
+
+		/* Leave flashing mode */
+		zl3073x_flash_mode_leave(zldev, extack);
+	}
+
+	/* Restart normal operation */
+	rc = zl3073x_dev_start(zldev, true);
+	if (rc)
+		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
+
+error:
+	/* Free flash context */
+	zl3073x_fw_free(zlfw);
+
+	zl3073x_devlink_flash_notify(zldev,
+				     rc ? "Flashing failed" : "Flashing done",
+				     NULL, 0, 0);
+
+	return rc;
+}
+
 static const struct devlink_ops zl3073x_devlink_ops = {
 	.info_get = zl3073x_devlink_info_get,
 	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT),
 	.reload_down = zl3073x_devlink_reload_down,
 	.reload_up = zl3073x_devlink_reload_up,
+	.flash_update = zl3073x_devlink_flash_update,
 };
 
 static void
-- 
2.49.1


