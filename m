Return-Path: <netdev+bounces-219525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF8B41B5B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740906832B3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F12F3639;
	Wed,  3 Sep 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCD+RcV2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B02EA479
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894180; cv=none; b=XKYzJeIqNOE/piYZckLfIOTlgqDvBaqvA1fw1NTCiVOvb0GPGKNasU7tkPWMXny5jsk+Yj4VeS5PfR0ym1UwKqUeJheYFg8Ze7/iAWeY3jANlcmomo66qk+9x/jcVJMR63XpPPOQDbqtjHYrJUm+57rn5hvoQWj02F32hLevm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894180; c=relaxed/simple;
	bh=i9nex+0Hy8Z4apcE/BVm010wVwlzEUOO1laDm9cqTw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmJIIi3GP85a4UZGv09Ziu4YuI8hgSCt9HBAY8chrh9wrHtmUvWW5JBDFoDSCPFAoBE/i9ejLpFp0vIKGYXJBWMsMF+j1FjM29fkVbvfwJ81zVxmjkbk4yjzlGYyH90m9RE69wdB6guIgsx9b+y1KuhfX0T2rg0t8yda5LMuSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCD+RcV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756894177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Afdu6sCdl4Qvs3czRpCzeNvJvun5ee9CZmX9RNbj/TQ=;
	b=jCD+RcV2ux+tjl4ow4a5whn+TRm8RAfJfdpg/nZa3G+2Kg1okuUilonNAfpU41qRgKpxRL
	D28MUXiyM6QOuSmwQYRDdPwfcmxUWiWa3lSXA9tgm/hlCEDz66U1qoG40FnivFpFnq+wUQ
	Xd1STS1qx4DKMLjmKgt1UFaHiXMlDlM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-Bfvrl6tZOF-6xfLCCyHaoQ-1; Wed,
 03 Sep 2025 06:09:34 -0400
X-MC-Unique: Bfvrl6tZOF-6xfLCCyHaoQ-1
X-Mimecast-MFC-AGG-ID: Bfvrl6tZOF-6xfLCCyHaoQ_1756894172
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6939D1955E9E;
	Wed,  3 Sep 2025 10:09:32 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.85])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DF971800576;
	Wed,  3 Sep 2025 10:09:28 +0000 (UTC)
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
Subject: [PATCH net-next v4 5/5] dpll: zl3073x: Implement devlink flash callback
Date: Wed,  3 Sep 2025 12:09:00 +0200
Message-ID: <20250903100900.8470-6-ivecera@redhat.com>
In-Reply-To: <20250903100900.8470-1-ivecera@redhat.com>
References: <20250903100900.8470-1-ivecera@redhat.com>
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
v4:
* Removed excessive comments
* Refactored flash callback by adding helper for preparation and finish
  phase
v3:
* Fixed return value documentation for zl3073x_flash_update()
---
 Documentation/networking/devlink/zl3073x.rst |  14 ++
 drivers/dpll/zl3073x/devlink.c               | 127 +++++++++++++++++++
 2 files changed, 141 insertions(+)

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
index d0f6d9cd4a68e..a0e4bede7d1f7 100644
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
@@ -141,11 +143,136 @@ void zl3073x_devlink_flash_notify(struct zl3073x_dev *zldev, const char *msg,
 					   total);
 }
 
+/**
+ * zl3073x_devlink_flash_prepare - Prepare and enter flash mode
+ * @zldev: zl3073x device pointer
+ * @zlfw: pointer to loaded firmware
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function stops normal operation and switches the device to flash mode.
+ * If an error occurs the normal operation is resumed.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
+			      struct zl3073x_fw *zlfw,
+			      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_fw_component *util;
+	int rc;
+
+	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
+	if (!util) {
+		zl3073x_devlink_flash_notify(zldev,
+					     "Utility is missing in firmware",
+					     NULL, 0, 0);
+		zl3073x_fw_free(zlfw);
+		return -ENOEXEC;
+	}
+
+	/* Stop normal operation prior entering flash mode */
+	zl3073x_dev_stop(zldev);
+
+	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
+	if (rc) {
+		zl3073x_devlink_flash_notify(zldev,
+					     "Failed to enter flash mode",
+					     NULL, 0, 0);
+
+		/* Resume normal operation */
+		return zl3073x_dev_start(zldev, true);
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_devlink_flash_finish - Leave flash mode and resume normal operation
+ * @zldev: zl3073x device pointer
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function switches the device back to standard mode and resumes normal
+ * operation.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_finish(struct zl3073x_dev *zldev,
+			     struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	/* Reset device CPU to normal mode */
+	zl3073x_flash_mode_leave(zldev, extack);
+
+	/* Resume normal operation */
+	rc = zl3073x_dev_start(zldev, true);
+	if (rc)
+		zl3073x_devlink_flash_notify(zldev,
+					     "Failed to start normal operation",
+					     NULL, 0, 0);
+
+	return rc;
+}
+
+/**
+ * zl3073x_devlink_flash_update - Devlink flash update callback
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
+	struct zl3073x_fw *zlfw;
+	int rc = 0;
+
+	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
+			       extack);
+	if (IS_ERR(zlfw)) {
+		zl3073x_devlink_flash_notify(zldev, "Failed to load firmware",
+					     NULL, 0, 0);
+		rc = PTR_ERR(zlfw);
+		goto finish;
+	}
+
+	/* Stop normal operation and enter flash mode */
+	rc = zl3073x_devlink_flash_prepare(zldev, zlfw, extack);
+	if (rc)
+		goto finish;
+
+	rc = zl3073x_fw_flash(zldev, zlfw, extack);
+	if (rc) {
+		zl3073x_devlink_flash_finish(zldev, extack);
+		goto finish;
+	}
+
+	/* Resume normal mode */
+	rc = zl3073x_devlink_flash_finish(zldev, extack);
+
+finish:
+	if (!IS_ERR(zlfw))
+		zl3073x_fw_free(zlfw);
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


