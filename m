Return-Path: <netdev+bounces-162399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC91A26BF8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848F6167C40
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3220371F;
	Tue,  4 Feb 2025 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIGAq4p/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75D1FFC79;
	Tue,  4 Feb 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649500; cv=none; b=bb1yXWIUEoXSBbCeNP6NL1MF7p2phTV70utGbMIJkHoYyfuE7IcCOT1CWiAXywj+l72pP0LXe7uwpiaNsApx3NO7pIa9ZMMZX19f6moMuRO+/mO74Dc20kJVQKxW4BBCN4f1lkK2kZC5pXlOgzKx34wsfKElQwImweer5BJajyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649500; c=relaxed/simple;
	bh=Gbb2UJByc91IL4vt5TUEDv7p+VJ4vmM++C8iN1b/p2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6ZtV0GmZcx7SE6eeUNVwl+81FZLwEq7bqN6swFKe8lhSGQwtVKIDJYQRb5uLQxUXORJDLhooYnC/OJUhBq8SiEvbXoGw6OAav68/Q7bCHZpsN/85kKc5jjgM5FSCWr0PFQF398oSdiTELVnaHN73Qn0xbOBZI4bCqgcbUmOLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIGAq4p/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738649498; x=1770185498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gbb2UJByc91IL4vt5TUEDv7p+VJ4vmM++C8iN1b/p2s=;
  b=YIGAq4p/mCHwIXVX3hPh8NXCi4oNLjtBfJBKqwOK/l8IeaBJKp2WQLMQ
   l1+uGO6cWQQRiEqqhiVQfVMwAeWL5osaoPHh/tInAzOLSczvE1epY9SiO
   P8FX1HmIuNTfHty1yPsBsSRUzrdpivm6JsD1yfakPM8jUtEdUsfrLnLM6
   bgsoZgn1UMrRXLJ/PSN6GNPpVJd0hZsB0pgkBsWH6hkH1RuH1Li9h+wiI
   sHXMHHPlChAGJDsNTk0/MvJlSvoDBkIUZRUfCRWzj+6wf31Kwmtayj+l4
   Bwt3SDVRKKabPNmOGDZGWTJ/8ET30gAIKG82TUOZz2xdp2hJODA4M6gtu
   g==;
X-CSE-ConnectionGUID: IkOYwPTYRoO+i58wNeKl6g==
X-CSE-MsgGUID: 1Hi85wu5T4y1VsQ+0KMG6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50579654"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50579654"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:11:37 -0800
X-CSE-ConnectionGUID: geDbVlmFRpG8R7JE1vBE6A==
X-CSE-MsgGUID: 1fvJTpkLQ/ChcQ5xOSlLOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110279183"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa009.jf.intel.com with ESMTP; 03 Feb 2025 22:11:29 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Simon Horman <horms@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v6 3/7] arch: x86: add IPC mailbox accessor function and add SoC register access
Date: Tue,  4 Feb 2025 14:10:16 +0800
Message-Id: <20250204061020.1199124-4-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

- Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
- Add support to use IPC command allows host to access SoC registers
through PMC firmware that are otherwise inaccessible to the host due to
security policies.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 MAINTAINERS                                   |  2 +
 arch/x86/Kconfig                              |  9 +++
 arch/x86/platform/intel/Makefile              |  1 +
 arch/x86/platform/intel/pmc_ipc.c             | 75 +++++++++++++++++++
 .../linux/platform_data/x86/intel_pmc_ipc.h   | 34 +++++++++
 5 files changed, 121 insertions(+)
 create mode 100644 arch/x86/platform/intel/pmc_ipc.c
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d1086e53a317..7a0681f83449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11862,8 +11862,10 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
 M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	arch/x86/platform/intel/pmc_ipc.c
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
+F:	linux/platform_data/x86/intel_pmc_ipc.h
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..631c1f10776c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -688,6 +688,15 @@ config X86_AMD_PLATFORM_DEVICE
 	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
 	  implemented under PINCTRL subsystem.
 
+config INTEL_PMC_IPC
+	tristate "Intel Core SoC Power Management Controller IPC mailbox"
+	depends on ACPI
+	help
+	  This option enables sideband register access support for Intel SoC
+	  power management controller IPC mailbox.
+
+	  If you don't require the option or are in doubt, say N.
+
 config IOSF_MBI
 	tristate "Intel SoC IOSF Sideband support for SoC platforms"
 	depends on PCI
diff --git a/arch/x86/platform/intel/Makefile b/arch/x86/platform/intel/Makefile
index dbee3b00f9d0..2f1805556d0c 100644
--- a/arch/x86/platform/intel/Makefile
+++ b/arch/x86/platform/intel/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IOSF_MBI)			+= iosf_mbi.o
+obj-$(CONFIG_INTEL_PMC_IPC)		+= pmc_ipc.o
diff --git a/arch/x86/platform/intel/pmc_ipc.c b/arch/x86/platform/intel/pmc_ipc.c
new file mode 100644
index 000000000000..a96234982710
--- /dev/null
+++ b/arch/x86/platform/intel/pmc_ipc.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Core SoC Power Management Controller IPC mailbox
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
+ *          David E. Box <david.e.box@linux.intel.com>
+ */
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/platform_data/x86/intel_pmc_ipc.h>
+
+#define PMC_IPCS_PARAM_COUNT           7
+
+int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object params[PMC_IPCS_PARAM_COUNT] = {
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+	};
+	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
+	union acpi_object *obj;
+	int status;
+
+	if (!ipc_cmd || !rbuf)
+		return -EINVAL;
+
+	/*
+	 * 0: IPC Command
+	 * 1: IPC Sub Command
+	 * 2: Size
+	 * 3-6: Write Buffer for offset
+	 */
+	params[0].integer.value = ipc_cmd->cmd;
+	params[1].integer.value = ipc_cmd->sub_cmd;
+	params[2].integer.value = ipc_cmd->size;
+	params[3].integer.value = ipc_cmd->wbuf[0];
+	params[4].integer.value = ipc_cmd->wbuf[1];
+	params[5].integer.value = ipc_cmd->wbuf[2];
+	params[6].integer.value = ipc_cmd->wbuf[3];
+
+	status = acpi_evaluate_object(NULL, "\\IPCS", &arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = buffer.pointer;
+	/* Check if the number of elements in package is 5 */
+	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
+		const union acpi_object *objs = obj->package.elements;
+
+		if ((u8)objs[0].integer.value != 0)
+			return -EINVAL;
+
+		rbuf[0] = objs[1].integer.value;
+		rbuf[1] = objs[2].integer.value;
+		rbuf[2] = objs[3].integer.value;
+		rbuf[3] = objs[4].integer.value;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_pmc_ipc);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel PMC IPC Mailbox accessor");
diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
new file mode 100644
index 000000000000..d47b89f873fc
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel Core SoC Power Management Controller Header File
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
+ *          David E. Box <david.e.box@linux.intel.com>
+ */
+#ifndef INTEL_PMC_IPC_H
+#define INTEL_PMC_IPC_H
+
+#define IPC_SOC_REGISTER_ACCESS			0xAA
+#define IPC_SOC_SUB_CMD_READ			0x00
+#define IPC_SOC_SUB_CMD_WRITE			0x01
+
+struct pmc_ipc_cmd {
+	u32 cmd;
+	u32 sub_cmd;
+	u32 size;
+	u32 wbuf[4];
+};
+
+/**
+ * intel_pmc_ipc() - PMC IPC Mailbox accessor
+ * @ipc_cmd:  struct pmc_ipc_cmd prepared with input to send
+ * @rbuf:     Allocated u32[4] array for returned IPC data
+ *
+ * Return: 0 on success. Non-zero on mailbox error
+ */
+int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
+
+#endif /* INTEL_PMC_IPC_H */
-- 
2.34.1


