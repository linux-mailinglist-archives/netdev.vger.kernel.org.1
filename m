Return-Path: <netdev+bounces-162222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00660A26408
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD79E1883CB9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721D204592;
	Mon,  3 Feb 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gRITsGv7"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F37081E;
	Mon,  3 Feb 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612262; cv=none; b=p7WOXo1DebEr7WYNgI1xOkNarT1qDUyDmggF83d2FdNTbPj5Y3Py5wT1zRHdUQUwWLI4geI/F7sMk6rF2ulHGfonKgdsQLtqvdXbpPDg4T5++x2g3/5wb/D4+ifYSsq3WiCAIhfFtAK1TpdhILQDB0dzmiHBrKnJ7n+q+qT9N6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612262; c=relaxed/simple;
	bh=hp3kp06KNDlIfdhHyemJW+gaT7pV1t52585ZKC6oSJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XuFQxGfx/44giEPum8gX3thG8rtVlXiKGHV3XLrpezzvrn5Qg+wt62dK4nHhYpSIsIe7nRaXViNp3K9+0ego9MbZGGqDx1oyHa5qKQb8S9johagcuqYVOWVbZTag9uI6zlgylTF1PuzyUUlhwEmSRAPomHfXvvjCdVAt5KgcC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gRITsGv7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738612254;
	bh=hp3kp06KNDlIfdhHyemJW+gaT7pV1t52585ZKC6oSJc=;
	h=From:Date:Subject:To:Cc:From;
	b=gRITsGv7Z4uS4EaXFKusUSOMCI2J716Ij6lJ5HOJ/szNyDaihM7IPKOiTF5LEtlQr
	 ASbIgHawhLFYQMufmtZG+YDhwYRbOUCM8/6zFBWhXeqxY3N1aSNaDEdgY5KQ+74M89
	 QMbsAAyos62TdncKO1QjQP2azNJaM8uaDBZoY0WQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 03 Feb 2025 20:50:46 +0100
Subject: [PATCH net] ptp: Add mock device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-ptp-mock-dev-v1-1-f84c56fd9e45@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABUeoWcC/x3MTQqAIBBA4avErBswI/q5SrQQZ6ohMtGQQLp70
 vJbvJchchCOMFUZAieJcrmCpq7A7sZtjELFoJXuVKM1+tvjedkDiROawVJLbU8jj1ASH3iV59/
 N4PiG5X0/6O2/VWMAAAA=
X-Change-ID: 20250122-ptp-mock-dev-a8cd3d37d9e9
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738612254; l=3096;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hp3kp06KNDlIfdhHyemJW+gaT7pV1t52585ZKC6oSJc=;
 b=3JBt5DetI2u4KUE5vSnBVYw61iiWTAk6HT3TrEC3soqGVYnt+yKu8MtR3nVEKYphRYjja4O6Z
 hQFtxypsFDCCqad2lPRAMt8Ezz0jm66bt/9jtopSItpDAsc/23jc854
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

While working on the PTP core or userspace components,
a real PTP device is not always available.
Introduce a tiny module which creates a mock PTP device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ptp/Kconfig        | 10 ++++++++++
 drivers/ptp/Makefile       |  1 +
 drivers/ptp/ptp_mock_dev.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 07bf7f9aae019ca26aa6d39a3c19b9dd0420f9bb..f0bbf0cbf13fb89c8cbf8934f6f2f0b81e622466 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -195,6 +195,16 @@ config PTP_1588_CLOCK_MOCK
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_mock.
 
+config PTP_1588_CLOCK_MOCK_DEV
+	tristate "Mock-up PTP clock device"
+	depends on PTP_1588_CLOCK_MOCK
+	help
+	  Instantiante a dummy PTP clock device derived from the system
+	  monotonic time.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_mock_dev.
+
 config PTP_1588_CLOCK_VMW
 	tristate "VMware virtual PTP clock"
 	depends on ACPI && HYPERVISOR_GUEST && X86
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9f0406a02c75d83027a0e6cfa10bf..216065f68e152963b35c55594ec1fd0b33db097a 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
 obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
 obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
+obj-$(CONFIG_PTP_1588_CLOCK_MOCK_DEV)	+= ptp_mock_dev.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
diff --git a/drivers/ptp/ptp_mock_dev.c b/drivers/ptp/ptp_mock_dev.c
new file mode 100644
index 0000000000000000000000000000000000000000..3423e2f0c45a4082875c2e031883735388d27b64
--- /dev/null
+++ b/drivers/ptp/ptp_mock_dev.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025 Thomas Weißschuh <linux@weissschuh.net>
+ *
+ * Mock-up PTP Hardware Clock device
+ *
+ * Create a PTP device which offers PTP time manipulation operations
+ * using a timecounter/cyclecounter on top of CLOCK_MONOTONIC_RAW.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/ptp_mock.h>
+
+static struct mock_phc *phc;
+
+static int __init ptp_mock_dev_init(void)
+{
+	phc = mock_phc_create(NULL);
+	return PTR_ERR_OR_ZERO(phc);
+}
+module_init(ptp_mock_dev_init);
+
+static void __exit ptp_mock_dev_exit(void)
+{
+	mock_phc_destroy(phc);
+}
+module_exit(ptp_mock_dev_exit);
+
+MODULE_DESCRIPTION("Mock-up PTP Hardware Clock device");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_LICENSE("GPL");

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250122-ptp-mock-dev-a8cd3d37d9e9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


