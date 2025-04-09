Return-Path: <netdev+bounces-180809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F15A828EE
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C4B3B4182
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7E26F452;
	Wed,  9 Apr 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ9b4a/Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370726E16E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209847; cv=none; b=SsRgGropZcSDEn7ju6NBQAnR6Lu0lmX4r2jHkNUK3xttqx7a7feglbEem73wSgclssr8Q4A+ihB+9xw0fUOFpIjP6I4eHxwXFXL4lblpCrkVUCP7d6ExRkUKrBvTLFgY7EP9FmQcII+Yfnm9VoYG4nuON/178buOfdl6S/u/4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209847; c=relaxed/simple;
	bh=3KVVeyaaBucR+xq4HP+LPTfEPMLNXt/RYHslpoy8OVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZTFXQSxG7n5q7Dvb+zH2jalnpfKVE1V6csNZGvMAO/OJN3Ig67QjpNSoEZImPk/g87LUa7lGKU70QSk8CxsEaNbV5YmPiNcwiEvhBHYqlupjStCBimDfYODTJb70RUZlI5mJlsv+gwE8NRq37j3qMwzhDvDa40GEYCQ6FTI1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJ9b4a/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI/uVE90Vs4dIFRxTpo8ubx3UzUF0EGLNIDuWr90bcQ=;
	b=jJ9b4a/QWKGI0MjeAx5ldGF8Lc6SxMoQHau7X6dbwyDdpEt0Ldn3VUHdi5zFV4H85al8T+
	hESUHHVzHyNkHq0IDlTOS3B1IhmiKfiUW96M5oLI+pU2mTuEn87VfXaI+H2nwQgq35ZjzE
	5GnkgeaX4PRE7j20S7MfLiajW7rY6gI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-GZCle4ljPzij80t35XdORw-1; Wed,
 09 Apr 2025 10:44:01 -0400
X-MC-Unique: GZCle4ljPzij80t35XdORw-1
X-Mimecast-MFC-AGG-ID: GZCle4ljPzij80t35XdORw_1744209839
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF7DB180AB19;
	Wed,  9 Apr 2025 14:43:59 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 220F31801766;
	Wed,  9 Apr 2025 14:43:54 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 13/14] mfd: zl3073x: Load mfg file into HW if it is present
Date: Wed,  9 Apr 2025 16:42:49 +0200
Message-ID: <20250409144250.206590-14-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add support for loading mfg file that can be provided by a user. The mfg
file can be generated by Microchip tool and contains snippets of device
configuration that is different from the one stored in the flash memory
inside the chip.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 110 +++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index a1fb5af5b3d9f..110071b28cab9 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -4,15 +4,19 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/kstrtox.h>
 #include <linux/lockdep.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/regmap.h>
 #include <linux/sprintf.h>
+#include <linux/string.h>
 #include <linux/unaligned.h>
 #include <net/devlink.h>
 #include "zl3073x.h"
@@ -464,6 +468,108 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+static int zl3073x_fw_parse_line(struct zl3073x_dev *zldev, const char *line)
+{
+#define ZL3073X_FW_WHITESPACES_SIZE	3
+#define ZL3073X_FW_COMMAND_SIZE		1
+	const char *ptr = line;
+	char *endp;
+	u32 delay;
+	u16 addr;
+	u8 val;
+
+	switch (ptr[0]) {
+	case 'X':
+		/* The line looks like this:
+		 * X , ADDR , VAL
+		 * Where:
+		 *  - X means that is a command that needs to be executed
+		 *  - ADDR represents the addr and is always 2 bytes and the
+		 *         value is in hex, for example 0x0232
+		 *  - VAL represents the value that is written and is always 1
+		 *        byte and the value is in hex, for example 0x12
+		 */
+		ptr += ZL3073X_FW_COMMAND_SIZE;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		addr = simple_strtoul(ptr, &endp, 16);
+
+		ptr = endp;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		val = simple_strtoul(ptr, NULL, 16);
+
+		/* Write requested value to given register */
+		return zl3073x_write_reg(zldev, addr, 1, &val);
+	case 'W':
+		/* The line looks like this:
+		 * W , DELAY
+		 * Where:
+		 *  - W means that is a wait command
+		 *  - DELAY represents the delay in microseconds and the value
+		 *    is in decimal
+		 */
+		ptr += ZL3073X_FW_COMMAND_SIZE;
+		ptr += ZL3073X_FW_WHITESPACES_SIZE;
+		delay = simple_strtoul(ptr, NULL, 10);
+
+		fsleep(delay);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+#define ZL3073X_MFG_FILE "microchip/zl3073x.mfg"
+
+static void zl3073x_fw_load(struct zl3073x_dev *zldev)
+{
+	const struct firmware *fw;
+	const char *ptr, *end;
+	char buf[128];
+	int rc;
+
+	rc = firmware_request_nowarn(&fw, ZL3073X_MFG_FILE, zldev->dev);
+	if (rc)
+		return;
+
+	dev_info(zldev->dev, "Applying mfg file %s...\n", ZL3073X_MFG_FILE);
+
+	guard(zl3073x)(zldev);
+
+	ptr = fw->data;
+	end = ptr + fw->size;
+	while (ptr < end) {
+		/* Get next end of the line or end of buffer */
+		char *eol = strnchrnul(ptr, end - ptr, '\n');
+		size_t len = eol - ptr;
+
+		/* Check line length */
+		if (len >= sizeof(buf)) {
+			dev_err(zldev->dev, "Line in firmware is too long\n");
+			return;
+		}
+
+		/* Copy line from buffer */
+		memcpy(buf, ptr, len);
+		buf[len] = '\0';
+
+		/* Parse and process the line */
+		rc = zl3073x_fw_parse_line(zldev, buf);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to parse firmware line: %pe\n",
+				ERR_PTR(rc));
+			break;
+		}
+
+		/* Move to next line */
+		ptr = eol + 1;
+	}
+
+	release_firmware(fw);
+}
+
 /**
  * zl3073x_dev_init - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -505,6 +611,9 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 	/* Use chip ID and given dev ID as clock ID */
 	zldev->clock_id = ((u64)id << 8) | dev_id;
 
+	/* Load mfg file if present */
+	zl3073x_fw_load(zldev);
+
 	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
 		 id, revision, fw_ver);
 	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
@@ -528,3 +637,4 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
 MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
 MODULE_DESCRIPTION("Microchip ZL3073x core driver");
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(ZL3073X_MFG_FILE);
-- 
2.48.1


