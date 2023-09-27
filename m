Return-Path: <netdev+bounces-36402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C547AF8E8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 799831C2099F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07F125C0;
	Wed, 27 Sep 2023 03:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FD134AD
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:10 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24D5FFC
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:08 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bc2c2f13dso2779777eaf.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787088; x=1696391888; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbfHoUCieXWdktxPY/0riATvRMCVvPdh3SIjfPeCEpg=;
        b=QAzNSE5/rpoS9R9sGyv6KdJIJNsy/xm8N8d65QqWhMhiJ/vhPBtfllRWbQgLCeEJG3
         X98tLmv5wKxwGpYNRL97pqVtiRrZQNJynly8JioWZEFj0L99HaPYwzIoWBXsHkzwc/HQ
         6Its5uUoT281DrC8VkU7NnjAIg0hy5AaZR7Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787088; x=1696391888;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbfHoUCieXWdktxPY/0riATvRMCVvPdh3SIjfPeCEpg=;
        b=Oj3l26inDH1aWy/OqhgeAjrjaRfh6fgZXwl89LmpZh1Y2FvpepeR2rK6paePAde6NI
         EX1qJ+TX6ndT6UWtLJcFDjz6gCkIHFokLKZGxUNHWf/6c2ARwjax6+4elnKu3/kwzX2s
         bzO0iw1YJ3JAJ6OPY/4k+BD3TsRPido0HOZjclxc0GKiR+UbWDGYxuRZbu+sScb4HLpH
         VyowUPZPHnZ6DdjuZ6uWxDFp9D+l3ZPu63j6F7c4kT3VufYcPHZ1mYNU2Xoh6xNJtk4d
         f+tR0ktFA8kCQkV4Mfpt4UUveeCzaQIGr41izxKbNCe6RM+VlG8/1asz+m12sYcwlFol
         mpaw==
X-Gm-Message-State: AOJu0YxMFPHqQjj4ZbtkugUcYX86WS2DB0w2r7dWhuHYth+UNAaFwU3d
	xgBk+U53JVj1W+eipj74bI8/Dw==
X-Google-Smtp-Source: AGHT+IF+l/zG89/pGz7aUi1JMmgZvmaYs1tcGg7qVJaCM928uxzbjkXuSq7HYXW13TYvxbN1sN1K3w==
X-Received: by 2002:a05:6870:9a1b:b0:1d5:f070:d518 with SMTP id fo27-20020a0568709a1b00b001d5f070d518mr1334275oab.52.1695787087498;
        Tue, 26 Sep 2023 20:58:07 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH net-next v2 3/9] bnxt_en: Move hwmon functions into a dedicated file
Date: Tue, 26 Sep 2023 20:57:28 -0700
Message-Id: <20230927035734.42816-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000153c606064f337a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000000153c606064f337a
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

This is in preparation for upcoming patches in the series.
Driver has to expose more threshold temperatures through the
hwmon sysfs interface. More code will be added and do not
want to overload bnxt.c.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 76 +----------------
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 82 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_hwmon.h   | 25 ++++++
 4 files changed, 109 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 2bc2b707d6ee..ba6c239d52fa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_BNXT) += bnxt_en.o
 bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
+bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 785084147994..b83f8de0a015 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -52,8 +52,6 @@
 #include <linux/cpu_rmap.h>
 #include <linux/cpumask.h>
 #include <net/pkt_cls.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
@@ -71,6 +69,7 @@
 #include "bnxt_tc.h"
 #include "bnxt_devlink.h"
 #include "bnxt_debugfs.h"
+#include "bnxt_hwmon.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
 #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
@@ -10250,79 +10249,6 @@ static void bnxt_get_wol_settings(struct bnxt *bp)
 	} while (handle && handle != 0xffff);
 }
 
-#ifdef CONFIG_BNXT_HWMON
-static ssize_t bnxt_show_temp(struct device *dev,
-			      struct device_attribute *devattr, char *buf)
-{
-	struct hwrm_temp_monitor_query_output *resp;
-	struct hwrm_temp_monitor_query_input *req;
-	struct bnxt *bp = dev_get_drvdata(dev);
-	u32 len = 0;
-	int rc;
-
-	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
-	if (rc)
-		return rc;
-	resp = hwrm_req_hold(bp, req);
-	rc = hwrm_req_send(bp, req);
-	if (!rc)
-		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
-	hwrm_req_drop(bp, req);
-	if (rc)
-		return rc;
-	return len;
-}
-static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
-
-static struct attribute *bnxt_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(bnxt);
-
-static void bnxt_hwmon_uninit(struct bnxt *bp)
-{
-	if (bp->hwmon_dev) {
-		hwmon_device_unregister(bp->hwmon_dev);
-		bp->hwmon_dev = NULL;
-	}
-}
-
-static void bnxt_hwmon_init(struct bnxt *bp)
-{
-	struct hwrm_temp_monitor_query_input *req;
-	struct pci_dev *pdev = bp->pdev;
-	int rc;
-
-	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
-	if (!rc)
-		rc = hwrm_req_send_silent(bp, req);
-	if (rc == -EACCES || rc == -EOPNOTSUPP) {
-		bnxt_hwmon_uninit(bp);
-		return;
-	}
-
-	if (bp->hwmon_dev)
-		return;
-
-	bp->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
-							  DRV_MODULE_NAME, bp,
-							  bnxt_groups);
-	if (IS_ERR(bp->hwmon_dev)) {
-		bp->hwmon_dev = NULL;
-		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
-	}
-}
-#else
-static void bnxt_hwmon_uninit(struct bnxt *bp)
-{
-}
-
-static void bnxt_hwmon_init(struct bnxt *bp)
-{
-}
-#endif
-
 static bool bnxt_eee_config_ok(struct bnxt *bp)
 {
 	struct ethtool_eee *eee = &bp->eee;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
new file mode 100644
index 000000000000..476616d97071
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -0,0 +1,82 @@
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * Copyright (c) 2023 Broadcom Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/pci.h>
+
+#include "bnxt_hsi.h"
+#include "bnxt.h"
+#include "bnxt_hwrm.h"
+#include "bnxt_hwmon.h"
+
+static ssize_t bnxt_show_temp(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
+{
+	struct hwrm_temp_monitor_query_output *resp;
+	struct hwrm_temp_monitor_query_input *req;
+	struct bnxt *bp = dev_get_drvdata(dev);
+	u32 len = 0;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
+	if (rc)
+		return rc;
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send(bp, req);
+	if (!rc)
+		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
+	hwrm_req_drop(bp, req);
+	if (rc)
+		return rc;
+	return len;
+}
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
+
+static struct attribute *bnxt_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(bnxt);
+
+void bnxt_hwmon_uninit(struct bnxt *bp)
+{
+	if (bp->hwmon_dev) {
+		hwmon_device_unregister(bp->hwmon_dev);
+		bp->hwmon_dev = NULL;
+	}
+}
+
+void bnxt_hwmon_init(struct bnxt *bp)
+{
+	struct hwrm_temp_monitor_query_input *req;
+	struct pci_dev *pdev = bp->pdev;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
+	if (!rc)
+		rc = hwrm_req_send_silent(bp, req);
+	if (rc == -EACCES || rc == -EOPNOTSUPP) {
+		bnxt_hwmon_uninit(bp);
+		return;
+	}
+
+	if (bp->hwmon_dev)
+		return;
+
+	bp->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
+							  DRV_MODULE_NAME, bp,
+							  bnxt_groups);
+	if (IS_ERR(bp->hwmon_dev)) {
+		bp->hwmon_dev = NULL;
+		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
new file mode 100644
index 000000000000..af310066687c
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
@@ -0,0 +1,25 @@
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * Copyright (c) 2023 Broadcom Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef BNXT_HWMON_H
+#define BNXT_HWMON_H
+
+#ifdef CONFIG_BNXT_HWMON
+void bnxt_hwmon_uninit(struct bnxt *bp);
+void bnxt_hwmon_init(struct bnxt *bp);
+#else
+static inline void bnxt_hwmon_uninit(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_hwmon_init(struct bnxt *bp)
+{
+}
+#endif
+#endif
-- 
2.30.1


--0000000000000153c606064f337a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINr+SKiUfQORmGFDYxdXMkw/60wuP8Xr
PonlmiART7CLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB5/tqyub3pY6n7cEanbKMnQ1ia9R5q7k/xwPWQ/LlBI2qJk8K1
hT+nH6D+pDhO8WG3vQZDPGVlz71g2stzhCT5INQT20JZM9AcP1sSDAWEPUZEZwGJxZeO27BrN+cu
P7e4ZOQqP1VUGO5ZQtK/RXUSq3bk47Oom0rbzUGLwdw6FXo1h90Ypjgm+Lq23ZUJ04LGKAa4aHZR
96q2E7p6SYE9QHVUet+fc7/yTMEOxQB4bc8hSh0YQ30UvAlJs3MQDFOOiBtXhcaGLL29wvC0jVbl
oh4iOb7esN3Yi0rheV3RKBg0p1QWY8BovLGU26eaKIk+6FdQs6mXmdjeq0EY3tCN
--0000000000000153c606064f337a--

