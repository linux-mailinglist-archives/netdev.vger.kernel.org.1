Return-Path: <netdev+bounces-269879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sApHJv0ovWkG7QIAu9opvQ
	(envelope-from <netdev+bounces-269879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD02D9342
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE643019156
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3E399378;
	Fri, 20 Mar 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzmCugJY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F023469E6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004378; cv=none; b=kyQ4urs+rbB1zbK90tEiHSTCg8UPydUGQ/gGCjAamivYyP6Q7VHE+oQRnavJzFbLgncKKzUSTDb+UZLBJyuimma6LDZVY1VZxS9ZDx56z+fCrnTWV3uiLhMlodc+DvqNxsQQOOhKlIxxYkUWBYdbBzcBa/ATzxFsnOeq5tdNyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004378; c=relaxed/simple;
	bh=8XoXEOFnRFU+xTDSeilbgf+OIdxrhZOSKc9IPoSqbQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTSp4Yf/CTgsFH7OV9LnwOMKq8FbpA/ywVCAgiiOH/AGShsEZFClZw/xVYowmDCNgK38UF4ORYxs05JeLNvZL6E8oSzLLM3r3YtUcBO65QCC7OS4LqNXI+/WTCdLNuSuxJ/n0N7FgK3FEsVge20CCNeQgW1A9TnpKSCKMH3Ymws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzmCugJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774004371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=liQz5OshvtXJy/w8Kf9VDPryfJ9WB7whqRNmekeRQHM=;
	b=CzmCugJYt/TC6KrgYMqCc/uiMp0GKmXP07VJ9NCOGEP0mHPryLZWbcix58cFqQbQESsvu1
	NvGlt6oZND5boGLjYJRHev1dEwyAYqgrXIklq3dNKEQ2dOOgnID6QqUNob/Vpssix8y3pD
	sDlSO0bURZL3x6ukngzNwnhNaHd6D7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-i_bvTNvvM0y70qsV4neiFw-1; Fri,
 20 Mar 2026 06:59:26 -0400
X-MC-Unique: i_bvTNvvM0y70qsV4neiFw-1
X-Mimecast-MFC-AGG-ID: i_bvTNvvM0y70qsV4neiFw_1774004365
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ACDE1955EAC;
	Fri, 20 Mar 2026 10:59:25 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A8C61955F21;
	Fri, 20 Mar 2026 10:59:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/3] dpll: zl3073x: add hwmon support for die temperature
Date: Fri, 20 Mar 2026 11:59:13 +0100
Message-ID: <20260320105915.149068-2-ivecera@redhat.com>
In-Reply-To: <20260320105915.149068-1-ivecera@redhat.com>
References: <20260320105915.149068-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[ivecera.redhat.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DBD02D9342
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register an hwmon device to expose the chip die temperature via the
standard hwmon temperature interface. The temperature sensor is only
available on chip variants that have the ZL3073X_FLAG_DIE_TEMP flag
set and its visibility is controlled via the is_visible callback.

The die temperature register provides a value in 0.1°C units that is
converted to millidegrees Celsius for the hwmon subsystem.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Makefile |  1 +
 drivers/dpll/zl3073x/core.c   |  7 ++++
 drivers/dpll/zl3073x/hwmon.c  | 67 +++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/hwmon.h  | 16 +++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 drivers/dpll/zl3073x/hwmon.c
 create mode 100644 drivers/dpll/zl3073x/hwmon.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index 906ec3fbcc202..6930bf7867151 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
 zl3073x-objs			:= chan.o core.o devlink.o dpll.o	\
 				   flash.o fw.o out.o prop.o ref.o synth.o
+zl3073x-$(CONFIG_HWMON)		+= hwmon.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7eebfc1ad1019..dcea98c31d694 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -18,6 +18,7 @@
 #include "core.h"
 #include "devlink.h"
 #include "dpll.h"
+#include "hwmon.h"
 #include "regs.h"
 
 #define ZL_CHIP_INFO(_id, _nchannels, _flags)				\
@@ -1038,6 +1039,12 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 	if (rc)
 		return rc;
 
+	/* Register hwmon interface */
+	rc = zl3073x_hwmon_init(zldev);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to register hwmon device\n");
+
 	/* Register the devlink instance and parameters */
 	rc = zl3073x_devlink_register(zldev);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/hwmon.c b/drivers/dpll/zl3073x/hwmon.c
new file mode 100644
index 0000000000000..4b44df4def820
--- /dev/null
+++ b/drivers/dpll/zl3073x/hwmon.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/hwmon.h>
+
+#include "core.h"
+#include "hwmon.h"
+#include "regs.h"
+
+static int zl3073x_hwmon_read(struct device *dev,
+			      enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct zl3073x_dev *zldev = dev_get_drvdata(dev);
+	u16 raw;
+	int rc;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_DIE_TEMP_STATUS, &raw);
+	if (rc)
+		return rc;
+
+	/* Convert from 0.1°C units to millidegrees Celsius */
+	*val = (s16)raw * 100;
+
+	return 0;
+}
+
+static umode_t zl3073x_hwmon_is_visible(const void *data,
+					enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	const struct zl3073x_dev *zldev = data;
+
+	if (type == hwmon_temp && (zldev->info->flags & ZL3073X_FLAG_DIE_TEMP))
+		return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info * const zl3073x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL,
+};
+
+static const struct hwmon_ops zl3073x_hwmon_ops = {
+	.is_visible = zl3073x_hwmon_is_visible,
+	.read = zl3073x_hwmon_read,
+};
+
+static const struct hwmon_chip_info zl3073x_hwmon_chip_info = {
+	.ops = &zl3073x_hwmon_ops,
+	.info = zl3073x_hwmon_info,
+};
+
+int zl3073x_hwmon_init(struct zl3073x_dev *zldev)
+{
+	struct device *hwmon;
+
+	hwmon = devm_hwmon_device_register_with_info(zldev->dev, "zl3073x",
+						     zldev,
+						     &zl3073x_hwmon_chip_info,
+						     NULL);
+	return PTR_ERR_OR_ZERO(hwmon);
+}
diff --git a/drivers/dpll/zl3073x/hwmon.h b/drivers/dpll/zl3073x/hwmon.h
new file mode 100644
index 0000000000000..6048d596985ad
--- /dev/null
+++ b/drivers/dpll/zl3073x/hwmon.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_HWMON_H
+#define _ZL3073X_HWMON_H
+
+#include <linux/kconfig.h>
+
+struct zl3073x_dev;
+
+#if IS_REACHABLE(CONFIG_HWMON)
+int zl3073x_hwmon_init(struct zl3073x_dev *zldev);
+#else
+static inline int zl3073x_hwmon_init(struct zl3073x_dev *zldev) { return 0; }
+#endif
+
+#endif /* _ZL3073X_HWMON_H */
-- 
2.52.0


