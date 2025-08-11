Return-Path: <netdev+bounces-212477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B8CB20C74
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DD16E2A4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF22E11C9;
	Mon, 11 Aug 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+5NpRPt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7612E11B6
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923247; cv=none; b=PkptbBfsHvdpkPtV/Qg63+TvmF9vHKMZU7YC836RRsQtREQGixOGLUW4oUINYFIpggoZecwd5exJxcEAuSlWNIVPozqUFSdOrm/0/ZaEXNry1MnA5rSjQvSfEDY1MKGP9n/AfQiDTZ2s8B7bgn47rqlKwizgZW7ilZxAUjjQ0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923247; c=relaxed/simple;
	bh=JcrZQg4NSQPxjI3ARjKhCDXAM0AmuH0YqWdBQlP7btI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff7sQ05DJqAnQ335ik15mp68Az7Hh/KugdDF03kQJg0uGiFv/nScP4CbMgBwQ5mTXXvndYJpHg4Z843wJuzLaLfviKk/tsMo5OCfFW+HJ280PdypyCiFtf4wDDJLtOjVeISEwU9rTt3OoagWAQmqRgGYKQ2gl9+3hKwJnNhN6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+5NpRPt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiZnBTHWpWVPXm9lDPLsbMep0xLgG8NJHfff/JNQO4g=;
	b=L+5NpRPtlf3isKutNwP1TavWiyizXFAgwxA5L4C2xInW0dANne5PpqXeRDUwiMWag2grdN
	qKGV1Idbsg7d8184bLqHHGV8WMAOtA7b978B02okkx6JXGPYU9LTx+exuvJLzrSampwCiG
	YfGSCGX+0lbvADrDnaaV2KdMf2mSTJA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-yJpbncX4P2aRbeJ0keAnug-1; Mon,
 11 Aug 2025 10:40:40 -0400
X-MC-Unique: yJpbncX4P2aRbeJ0keAnug-1
X-Mimecast-MFC-AGG-ID: yJpbncX4P2aRbeJ0keAnug_1754923238
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A701956080;
	Mon, 11 Aug 2025 14:40:38 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.225.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA1C2300145A;
	Mon, 11 Aug 2025 14:40:34 +0000 (UTC)
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
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 5/5] dpll: zl3073x: Implement devlink flash callback
Date: Mon, 11 Aug 2025 16:40:09 +0200
Message-ID: <20250811144009.2408337-6-ivecera@redhat.com>
In-Reply-To: <20250811144009.2408337-1-ivecera@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index d0f6d9cd4a68e..06962643c9363 100644
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
+ * Returns 0 in case of success or negative value otherwise
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


