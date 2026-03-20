Return-Path: <netdev+bounces-269881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEoNMyIpvWkG7QIAu9opvQ
	(envelope-from <netdev+bounces-269881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:01:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 527092D9368
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39E2830614E0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D37383C7C;
	Fri, 20 Mar 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix6vlso+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0D38A717
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004385; cv=none; b=QStXTrDaRE7gYquWUdV37JbWEymbcPqqJol7ym7ZQzDjtIWueX6xYdtLKgZpEKBwdv0pXGe+jUx8E3JRTb7fHknO00kpHpWzrDEoFLHudiWPlJ2kDyQDdNCsQP7AYoVzZXMm15HauXnCxuKlrMbUSdlyatCanQrnCOoKoiQT8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004385; c=relaxed/simple;
	bh=/16a2o1bBFBTamsyHlsUwOjXKdArI+HOsdPgs3rK50Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvGQ1p6Z2zQTTSTyoECpBuG96b8aAzAggh+DOvwRG27gZbf1whn6/IftSReJWsPbmCp1qjiKLfL64Kj3pQBepXXrNCGmzX4000V5hdqUaarjL4DABspcj4CUlr9MXWC1CrpntVb2Hoa2eXGRcnukzS3gxbIwQU54+K6Q0sm0JsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix6vlso+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774004378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZryKPp8MrEGbzSS3pHimlGo1YuKSVEx94HTQlVLP0M=;
	b=ix6vlso+JlNkP2Dz3gQIA1J83BIAJL0tbdORXpJLdvvg7VtrJ1NSApxuOYlZHrO0IYKO82
	9DTvn9pgm09mJizvjyUxS4k5DpwPzicciYvZ/oKiVjjI+j1O8IAv6i74+IfFTFIbIBG4yp
	+t9pOpu9PG5WEAvBdeZYbWq0PbHfz+M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-3wzFLD_NPei-lMjld-VP-A-1; Fri,
 20 Mar 2026 06:59:35 -0400
X-MC-Unique: 3wzFLD_NPei-lMjld-VP-A-1
X-Mimecast-MFC-AGG-ID: 3wzFLD_NPei-lMjld-VP-A_1774004373
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AF2A19560B4;
	Fri, 20 Mar 2026 10:59:33 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7F361955F21;
	Fri, 20 Mar 2026 10:59:29 +0000 (UTC)
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
Subject: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input reference frequencies
Date: Fri, 20 Mar 2026 11:59:15 +0100
Message-ID: <20260320105915.149068-4-ivecera@redhat.com>
In-Reply-To: <20260320105915.149068-1-ivecera@redhat.com>
References: <20260320105915.149068-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-269881-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 527092D9368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose measured input reference frequencies via the hwmon interface
using custom sysfs attributes (freqN_input and freqN_label) since
hwmon has no native frequency sensor type. The frequency values are
read from the cached measurements updated by the periodic work thread.

Cache the device ready state in struct zl3073x_dev so that
freq_input_show() can return -ENODATA without an I2C access when
the device firmware is not configured.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c  |  4 +-
 drivers/dpll/zl3073x/core.h  |  2 +
 drivers/dpll/zl3073x/hwmon.c | 86 +++++++++++++++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 67e65f8e7e7d4..5805f87167c20 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -874,7 +874,9 @@ int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full)
 		return rc;
 	}
 
-	if (!FIELD_GET(ZL_INFO_READY, info)) {
+	zldev->ready = !!FIELD_GET(ZL_INFO_READY, info);
+
+	if (!zldev->ready) {
 		/* The ready bit indicates that the firmware was successfully
 		 * configured and is ready for normal operation. If it is
 		 * cleared then the configuration stored in flash is wrong
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 99440620407da..a416b8a65f41b 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -48,6 +48,7 @@ struct zl3073x_chip_info {
  * @regmap: regmap to access device registers
  * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
+ * @ready: true if device firmware is configured and ready for normal operation
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -63,6 +64,7 @@ struct zl3073x_dev {
 	struct regmap			*regmap;
 	const struct zl3073x_chip_info	*info;
 	struct mutex			multiop_lock;
+	bool				ready;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
diff --git a/drivers/dpll/zl3073x/hwmon.c b/drivers/dpll/zl3073x/hwmon.c
index 4b44df4def820..96879609ce100 100644
--- a/drivers/dpll/zl3073x/hwmon.c
+++ b/drivers/dpll/zl3073x/hwmon.c
@@ -2,9 +2,11 @@
 
 #include <linux/device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 
 #include "core.h"
 #include "hwmon.h"
+#include "ref.h"
 #include "regs.h"
 
 static int zl3073x_hwmon_read(struct device *dev,
@@ -55,6 +57,88 @@ static const struct hwmon_chip_info zl3073x_hwmon_chip_info = {
 	.info = zl3073x_hwmon_info,
 };
 
+static ssize_t freq_input_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	struct zl3073x_dev *zldev = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(devattr)->index;
+	const struct zl3073x_ref *ref;
+
+	if (!zldev->ready)
+		return -ENODATA;
+
+	ref = zl3073x_ref_state_get(zldev, index);
+
+	return sysfs_emit(buf, "%u\n", zl3073x_ref_meas_freq_get(ref));
+}
+
+static ssize_t freq_label_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	static const char * const labels[] = {
+		"REF0P", "REF0N", "REF1P", "REF1N", "REF2P",
+		"REF2N", "REF3P", "REF3N", "REF4P", "REF4N",
+	};
+	int index = to_sensor_dev_attr(devattr)->index;
+
+	return sysfs_emit(buf, "%s\n", labels[index]);
+}
+
+static SENSOR_DEVICE_ATTR_RO(freq0_input, freq_input, 0);
+static SENSOR_DEVICE_ATTR_RO(freq1_input, freq_input, 1);
+static SENSOR_DEVICE_ATTR_RO(freq2_input, freq_input, 2);
+static SENSOR_DEVICE_ATTR_RO(freq3_input, freq_input, 3);
+static SENSOR_DEVICE_ATTR_RO(freq4_input, freq_input, 4);
+static SENSOR_DEVICE_ATTR_RO(freq5_input, freq_input, 5);
+static SENSOR_DEVICE_ATTR_RO(freq6_input, freq_input, 6);
+static SENSOR_DEVICE_ATTR_RO(freq7_input, freq_input, 7);
+static SENSOR_DEVICE_ATTR_RO(freq8_input, freq_input, 8);
+static SENSOR_DEVICE_ATTR_RO(freq9_input, freq_input, 9);
+
+static SENSOR_DEVICE_ATTR_RO(freq0_label, freq_label, 0);
+static SENSOR_DEVICE_ATTR_RO(freq1_label, freq_label, 1);
+static SENSOR_DEVICE_ATTR_RO(freq2_label, freq_label, 2);
+static SENSOR_DEVICE_ATTR_RO(freq3_label, freq_label, 3);
+static SENSOR_DEVICE_ATTR_RO(freq4_label, freq_label, 4);
+static SENSOR_DEVICE_ATTR_RO(freq5_label, freq_label, 5);
+static SENSOR_DEVICE_ATTR_RO(freq6_label, freq_label, 6);
+static SENSOR_DEVICE_ATTR_RO(freq7_label, freq_label, 7);
+static SENSOR_DEVICE_ATTR_RO(freq8_label, freq_label, 8);
+static SENSOR_DEVICE_ATTR_RO(freq9_label, freq_label, 9);
+
+static struct attribute *zl3073x_freq_attrs[] = {
+	&sensor_dev_attr_freq0_input.dev_attr.attr,
+	&sensor_dev_attr_freq0_label.dev_attr.attr,
+	&sensor_dev_attr_freq1_input.dev_attr.attr,
+	&sensor_dev_attr_freq1_label.dev_attr.attr,
+	&sensor_dev_attr_freq2_input.dev_attr.attr,
+	&sensor_dev_attr_freq2_label.dev_attr.attr,
+	&sensor_dev_attr_freq3_input.dev_attr.attr,
+	&sensor_dev_attr_freq3_label.dev_attr.attr,
+	&sensor_dev_attr_freq4_input.dev_attr.attr,
+	&sensor_dev_attr_freq4_label.dev_attr.attr,
+	&sensor_dev_attr_freq5_input.dev_attr.attr,
+	&sensor_dev_attr_freq5_label.dev_attr.attr,
+	&sensor_dev_attr_freq6_input.dev_attr.attr,
+	&sensor_dev_attr_freq6_label.dev_attr.attr,
+	&sensor_dev_attr_freq7_input.dev_attr.attr,
+	&sensor_dev_attr_freq7_label.dev_attr.attr,
+	&sensor_dev_attr_freq8_input.dev_attr.attr,
+	&sensor_dev_attr_freq8_label.dev_attr.attr,
+	&sensor_dev_attr_freq9_input.dev_attr.attr,
+	&sensor_dev_attr_freq9_label.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group zl3073x_freq_group = {
+	.attrs = zl3073x_freq_attrs,
+};
+
+static const struct attribute_group *zl3073x_hwmon_groups[] = {
+	&zl3073x_freq_group,
+	NULL,
+};
+
 int zl3073x_hwmon_init(struct zl3073x_dev *zldev)
 {
 	struct device *hwmon;
@@ -62,6 +146,6 @@ int zl3073x_hwmon_init(struct zl3073x_dev *zldev)
 	hwmon = devm_hwmon_device_register_with_info(zldev->dev, "zl3073x",
 						     zldev,
 						     &zl3073x_hwmon_chip_info,
-						     NULL);
+						     zl3073x_hwmon_groups);
 	return PTR_ERR_OR_ZERO(hwmon);
 }
-- 
2.52.0


