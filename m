Return-Path: <netdev+bounces-103547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC079088C5
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9502903AE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26571946C7;
	Fri, 14 Jun 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cQOnDa3G"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2164.outbound.protection.outlook.com [40.92.63.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B6192B8D;
	Fri, 14 Jun 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358623; cv=fail; b=K4l0BcNSfDhf/9yItdscBm1m9QSMTiM4Y2L8+FtE/ka+hmiusQh+ofU802gzwJfF/dp8gfDrkpmvMUCSpv44Tawpo7DWEEKpud7pJJrtevv5Z5PQ+Cnym/Fpz5D//m0ifoBc+Pg61uPCJp9rK+CB7F2cRKZE1ZtBLfGXpItiCFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358623; c=relaxed/simple;
	bh=/TbTD8JtqiKd0YcfLb8FIHHd/6E6He57dmMA22VEaYs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oEilanMuXsol87DrPmlOcFqCYl7YT7lSI3NkGs8qONUsDEfhxnB82GBAulnATfaurnmNoI6jlZgUBqZlC/sSU079zZaOuyQmPWMC5Q9JfwYAF9vyqRHSdMqK4TkMrhCXbfkaNdWLfMs0C4YrNqAlBguMrPx+QdkiMyjcmM8vBM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cQOnDa3G; arc=fail smtp.client-ip=40.92.63.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCsMmM/Ki8fJUWG3a4ubNrIJiqLLwkmcRpOgYs4IBqA/9KWWhkyvq/kgnYdBRmI1SeTR67HUWaw786T7/O8RdT4fRsRgMowlOwF7TrsV4sxU/XLaRjOht4beBrlKoN0DeCiOjT25j0ZseI4et4AqpDO3S7EtTLo527q9fxfkZ21EUK/XYvKmBSG+OyalKC+q3uPYKOyFoHkBMjVaOviu7CtxSHs3u32HE9PUZ4vEHyPZss6FuVnzh1/YGLvWdblhKfEUtXApCefE8q5YqetskNj3AWMffljHQN9ClPw+cVqtX7PpCVfdxYy+KpYNlE+ByqMvCW/F7QQ8lxRPeVaBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdFX8qhpjrVE59ZTW80a28mEr+G++j9u98lzuAOix5Q=;
 b=MmZmwoRBpfhJ36xDip4RdPe6IlQScTBL2l42nivA1RLCeEqQ/pRnS7MfvOy3ZS7vqBa8GZKpeQGSRlDv/v2BUJKuu7QUNIyHczIVE0hRDdtDqB86qnf/AAgRDVcFHkASaGgaBDuxgjoIp2Z23fYX20+nD/ixuB3R+y++CzFNIjeoJWKNbYLVxl/AyPUJdU397K/mA7dyYCyVdZc097xashK9b7Drv7T3FK8gH+0uW8XyILpiRChlfAVI6BrbsEYn8YWZzDCgFH0XaxfhxG5aqiiHA52tH1v84yrP5G72GWDLBytGWFzTxCkZMH9yxlAxfN9z6UNiFkotSLngZEzikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdFX8qhpjrVE59ZTW80a28mEr+G++j9u98lzuAOix5Q=;
 b=cQOnDa3Gtip/TMHojG3dbWceBpxTrXOyhEz2VstDoLW7rdotEUd6P/jr61dPPY8LYs9YKOIBwyZ+u6iwthMUG4dr0tYfqJ1gCSJI29B2vRUavSAVwFoGOUEVxnpMTcFxTpwZrH1qkgSso2E9mxwMwlyOI2Y8eJKxOeb29AhNihZU6TmII8R78OhninrAOkVH7TAYVsqLnkJYyJnKORYrl2F+tv+RjlnyYDOIZu1qVIXOwL+1UTlXozydZ6UnejvgmH8c2HKH9hkLd7/NThbPgmYl+dPk6jAII2d40VY5KDt5O7mSp8P1ViUPfMvZA0E6JL+lbHUzxQtPBmnhlRkoQg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY4P282MB1962.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 09:50:15 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f23f:94aa:b5cf:7696]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f23f:94aa:b5cf:7696%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:50:15 +0000
From: Vanillan Wang <songjinjian@hotmail.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v1] net: wwan: t7xx: Add debug port
Date: Fri, 14 Jun 2024 17:49:51 +0800
Message-ID:
 <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NLFjexRlP99vCydBO8tfbrtLhk5qp4aDtsYgg4njLBU=]
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240614094951.6671-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY4P282MB1962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7218b7f0-f7aa-448a-ebe3-08dc8c5763b9
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199024|440099024|3412199020;
X-Microsoft-Antispam-Message-Info:
	i+px7bYv0FRTCVGHWnZ7LqY3IL/VqEpNGdeiESqoPF7SpuwdjDiNB1QkfR3akgvkzmfBJscpNVAawaFkJ7bZGxG7yoDsxIRGGnf92IXtXio9xwfIM6K/NcajiVDyzp3VHnyBsB4V3Hlgkx/M9uOEMICMAatjhtlQIxCdzvhCYRH4uqmI420+C3N4NcEZBb/cG8kfoGgg4vo56T/dVJGLmmfZvqF8XB/tME4fcO5tFd6dM7w0/z/M8qmLX9dJi5JgYQaPZdmuJ9Q9yEm30mDICdCzwrzjIWFJltdmqMja0+zjviO6GYRFln7Ryw5OW9yEjsjsdeb5ouiv0VaQKCD5LQuf9Fc01cpakgYiewLFJHB7O5O4QrUf3539pGOEhRd142Aw/jsL+HFejyFxHPMmfSan53mi+Na2FgkCmiixp04qHN062Oahc1SkdRR8Dvm5RRsHdmwWPF/zel7hD8MU410RFdEKQmKHmzhbSnsix9agSkPjrCSol9cT0qjXGF12yXe3eZZSawpJsbrtOAQr3mjt6WANvcWRZKTrdE0nhaE9fniqc2e3uuVeldFfjTII
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJsgfeXJrogGw2Or0/z2590+31IDip7SslteMl3j6ahBbZ6XxCJOeKS7PfPX?=
 =?us-ascii?Q?tbcj6gL9A5lw+LlIQPS65DZQqKFZOoDqJJtL1px6OlglYhh7vhpzX6oYcwxW?=
 =?us-ascii?Q?hdIaVUWyzbedB+M2iJ4nbQAfkjoX1E0uvFPC08jocSfsDs/3uf85fnQICO9f?=
 =?us-ascii?Q?P5wbUz6TMVTL9EAPdtYjuaaTH4Ccl+ROzsc1QlMrRKxIpyxqGl9Y3I6aLDvr?=
 =?us-ascii?Q?5kC6dbPkiQxAMMDgsJI6bb978mw7zZabOunZUT5JH/v6vJeNWM/BSDV1aIpS?=
 =?us-ascii?Q?2opcjgwzBREKiVLYaaW514/tfTuO8mpalrbQ2Mj6WRCpEllO6qYZAaZbqc7u?=
 =?us-ascii?Q?lUZLM5LiTE/tQsIc6P/7ft/cKHRz3y7CpjlSwsZFCv0DGf8v9AQBSb+/6lR8?=
 =?us-ascii?Q?aTjUULBeIQZsAcMmj2shcnwjkBzPRaf2IX+ZZ3lpo57AGdIlYa6G9/4qjmLM?=
 =?us-ascii?Q?mpTn+zYK50znDv+oIclakndv8uSxvxoL65XC5UsSDBiyoELU8NMsbfZo7K6x?=
 =?us-ascii?Q?iEiRFlDpas8qHg0lmW0oAyL+U1uhpsyQ/WgC1lmnVHoRgqUvePWufW1OWABx?=
 =?us-ascii?Q?5O8F1CAo0X5D8hxyfeUvAASQdZUhpc1CQhx2t+UZJR4v46r2Sv96UwJ+t0rH?=
 =?us-ascii?Q?E7vRO2E/afq+MJPlnKI6RPOGosBozd3vV5tr35CDTQhmzw7WVh9HFo/NRjnh?=
 =?us-ascii?Q?rCWU6C6NLw6neWQnMg0HTMWY2Bbkz8QqUGgp5Q3RrfpBjaQ20Q5t4zm587e4?=
 =?us-ascii?Q?N3UzdJH38m2B1oy9nkxxuNRajnDrVSxVYbjMKTuPCcE6gcuW0vVMsbWZXjlQ?=
 =?us-ascii?Q?Kqx8ygttoEFioxcroV9FUcl8yRB0SoWvSV0naoCGm4FN8D4IgzHNaphPyown?=
 =?us-ascii?Q?RxVZuVrd1+vBFOQ1YV7zT8q9fA/xpUxKDPCv/CGHe2IYkKGRC5lKV4fnEv9r?=
 =?us-ascii?Q?9J/2TMecKTf8yTDGKSd5y0OK3ZAe0tmCwGRxVgcU2iC8fjorzstCKdXqB0U6?=
 =?us-ascii?Q?nVU48nuEK1e8O1XSh5EzG/wGe0HfVstQqavr4DyLJ4nK56I8D33qlz/5QCuM?=
 =?us-ascii?Q?8Jcsm3r4mETXv4F9hf1a7Qo634ZuAoXcIeBiwFemAzI3LkL9HlcSnBBUodZh?=
 =?us-ascii?Q?yTKr1mWUM6G6EaUHRdGI87PG57VHWNfzcX8AvyxNvD9TYN2GAYsl+3ZDfcYp?=
 =?us-ascii?Q?gF6FXTFAOY3fUry+NFgtVXlS1VHaite1rSMoi2R/LZsO95GWQa0SvFAGvO2O?=
 =?us-ascii?Q?duPLT8wV0nqteUQm1Tkt?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7218b7f0-f7aa-448a-ebe3-08dc8c5763b9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:50:15.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1962

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to switch on the debug port(ADB,MIPC).
 - ADB port: /dev/ccci_sap_adb
 - MIPC port: /dev/ttyMIPC0

Switch on debug port:
 - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode

Switch off debug port:
 - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/Makefile          |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c        |   7 +
 drivers/net/wwan/t7xx/t7xx_pci.h        |   2 +
 drivers/net/wwan/t7xx/t7xx_port.h       |  16 ++
 drivers/net/wwan/t7xx/t7xx_port_debug.c | 354 ++++++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c |  45 ++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h |   2 +
 7 files changed, 426 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_debug.c

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..b9684fd46d76 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -11,6 +11,7 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_port_proxy.o  \
 		t7xx_port_ctrl_msg.o \
 		t7xx_port_wwan.o \
+		t7xx_port_debug.o \
 		t7xx_hif_dpmaif.o  \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..6b18460d626c 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -41,6 +41,7 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
+#include "t7xx_port_proxy.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
@@ -59,6 +60,8 @@ static const char * const t7xx_mode_names[] = {
 	[T7XX_FASTBOOT_SWITCHING] = "fastboot_switching",
 	[T7XX_FASTBOOT_DOWNLOAD] = "fastboot_download",
 	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
+	[T7XX_DEBUG] = "debug",
+	[T7XX_NORMAL] = "normal",
 };
 
 static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
@@ -82,6 +85,10 @@ static ssize_t t7xx_mode_store(struct device *dev,
 	} else if (index == T7XX_RESET) {
 		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
 		t7xx_acpi_pldr_func(t7xx_dev);
+	} else if (index == T7XX_DEBUG) {
+		t7xx_proxy_port_debug(t7xx_dev, true);
+	} else if (index == T7XX_NORMAL) {
+		t7xx_proxy_port_debug(t7xx_dev, false);
 	}
 
 	return count;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..bdcadeb035e0 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -50,6 +50,8 @@ enum t7xx_mode {
 	T7XX_FASTBOOT_SWITCHING,
 	T7XX_FASTBOOT_DOWNLOAD,
 	T7XX_FASTBOOT_DUMP,
+	T7XX_DEBUG,
+	T7XX_NORMAL,
 	T7XX_MODE_LAST, /* must always be last */
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index f74d3bab810d..aa9b0df1f730 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/wwan.h>
+#include <linux/cdev.h>
 
 #include "t7xx_hif_cldma.h"
 #include "t7xx_pci.h"
@@ -42,6 +43,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_ADB_RX = 0x100a,
+	PORT_CH_AP_ADB_TX = 0x100b,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
@@ -100,6 +103,16 @@ struct t7xx_port_conf {
 	struct port_ops		*ops;
 	char			*name;
 	enum wwan_port_type	port_type;
+	bool			debug;
+	char			*class_name;
+	unsigned char		baseminor;
+};
+
+struct t7xx_cdev {
+	struct t7xx_port	*port;
+	struct cdev		cdev;
+	dev_t			dev_num;
+	struct class		*dev_class;
 };
 
 struct t7xx_port {
@@ -134,6 +147,9 @@ struct t7xx_port {
 		struct {
 			struct rchan			*relaych;
 		} log;
+		struct {
+			struct t7xx_cdev		*debug_port;
+		} debug;
 	};
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_debug.c b/drivers/net/wwan/t7xx/t7xx_port_debug.c
new file mode 100644
index 000000000000..8c94a72f210d
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_debug.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2024, Fibocom Wireless Inc.
+ *
+ * Authors: Jinjian Song <jinjian.song@fibocom.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+
+#include "t7xx_state_monitor.h"
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+
+static __poll_t port_char_poll(struct file *fp, struct poll_table_struct *poll)
+{
+	struct t7xx_port *port;
+	__poll_t mask = 0;
+
+	port = fp->private_data;
+	poll_wait(fp, &port->rx_wq, poll);
+
+	spin_lock_irq(&port->rx_wq.lock);
+	if (!skb_queue_empty(&port->rx_skb_list))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	spin_unlock_irq(&port->rx_wq.lock);
+
+	return mask;
+}
+
+/**
+ * port_char_open() - open char port
+ * @inode: pointer to inode structure
+ * @file: pointer to file structure
+ *
+ * Open a char port using pre-defined md_ccci_ports structure in port_proxy
+ *
+ * Return: 0 for success, -EINVAL for failure
+ */
+static int port_char_open(struct inode *inode, struct file *file)
+{
+	struct t7xx_cdev *t7xx_debug;
+	struct t7xx_port *port;
+
+	t7xx_debug = container_of(inode->i_cdev, struct t7xx_cdev, cdev);
+	port = t7xx_debug->port;
+
+	if (!port)
+		return -EINVAL;
+
+	port->port_conf->ops->enable_chl(port);
+	atomic_inc(&port->usage_cnt);
+
+	file->private_data = port;
+
+	return nonseekable_open(inode, file);
+}
+
+static int port_char_close(struct inode *inode, struct file *file)
+{
+	struct t7xx_port *port;
+	struct sk_buff *skb;
+
+	port = file->private_data;
+
+	/* decrease usage count, so when we ask again,
+	 * the packet can be dropped in recv_request.
+	 */
+	atomic_dec(&port->usage_cnt);
+	port->port_conf->ops->disable_chl(port);
+
+	/* purge RX request list */
+	spin_lock_irq(&port->rx_wq.lock);
+	while ((skb = __skb_dequeue(&port->rx_skb_list)) != NULL)
+		dev_kfree_skb(skb);
+	spin_unlock_irq(&port->rx_wq.lock);
+
+	return 0;
+}
+
+static ssize_t port_char_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	bool full_req_done = false;
+	struct t7xx_port *port;
+	int ret = 0, read_len;
+	struct sk_buff *skb;
+
+	port = file->private_data;
+
+	spin_lock_irq(&port->rx_wq.lock);
+	if (skb_queue_empty(&port->rx_skb_list)) {
+		if (file->f_flags & O_NONBLOCK) {
+			spin_unlock_irq(&port->rx_wq.lock);
+			return -EAGAIN;
+		}
+
+		ret = wait_event_interruptible_locked_irq(port->rx_wq,
+							  !skb_queue_empty(&port->rx_skb_list));
+		if (ret == -ERESTARTSYS) {
+			spin_unlock_irq(&port->rx_wq.lock);
+			return -EINTR;
+		}
+	}
+	skb = skb_peek(&port->rx_skb_list);
+
+	if (count >= skb->len) {
+		read_len = skb->len;
+		full_req_done = true;
+		__skb_unlink(skb, &port->rx_skb_list);
+	} else {
+		read_len = count;
+	}
+
+	spin_unlock_irq(&port->rx_wq.lock);
+	if (copy_to_user(buf, skb->data, read_len)) {
+		dev_err(port->dev, "Read on %s, copy to user failed, %d/%zu\n",
+			port->port_conf->name, read_len, count);
+		ret = -EFAULT;
+	}
+
+	skb_pull(skb, read_len);
+	if (full_req_done)
+		dev_kfree_skb(skb);
+
+	return ret ? ret : read_len;
+}
+
+static ssize_t port_char_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	unsigned int header_len = sizeof(struct ccci_header);
+	size_t  offset, txq_mtu, chunk_len = 0;
+	struct t7xx_port *port;
+	struct sk_buff *skb;
+	bool blocking;
+	int ret;
+
+	port = file->private_data;
+
+	blocking = !(file->f_flags & O_NONBLOCK);
+	if (!blocking)
+		return -EAGAIN;
+
+	if (!port->chan_enable)
+		return -EINVAL;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	for (offset = 0; offset < count; offset += chunk_len) {
+		chunk_len = min(count - offset, txq_mtu - header_len);
+
+		skb = __dev_alloc_skb(chunk_len + header_len, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		ret = copy_from_user(skb_put(skb, chunk_len), buf + offset, chunk_len);
+
+		if (ret) {
+			dev_kfree_skb(skb);
+			return -EFAULT;
+		}
+
+		ret = t7xx_port_send_skb(port, skb, 0, 0);
+		if (ret) {
+			if (ret == -EBUSY && !blocking)
+				ret = -EAGAIN;
+			dev_kfree_skb_any(skb);
+			return ret;
+		}
+	}
+
+	return count;
+}
+
+static int t7xx_cdev_init(struct t7xx_port *port)
+{
+	struct t7xx_cdev *t7xx_debug;
+	struct device *dev;
+
+	dev = &port->t7xx_dev->pdev->dev;
+
+	t7xx_debug = devm_kzalloc(dev, sizeof(*t7xx_debug), GFP_KERNEL);
+	if (!t7xx_debug)
+		return -ENOMEM;
+
+	t7xx_debug->port = port;
+	port->debug.debug_port = t7xx_debug;
+
+	return 0;
+}
+
+static void t7xx_cdev_uninit(struct t7xx_port *port)
+{
+	struct device *dev;
+
+	if (!port->debug.debug_port)
+		return;
+
+	dev = &port->t7xx_dev->pdev->dev;
+
+	devm_kfree(dev, port->debug.debug_port);
+	port->debug.debug_port = NULL;
+}
+
+static const struct file_operations char_fops = {
+	.owner = THIS_MODULE,
+	.open = &port_char_open,
+	.read = &port_char_read,
+	.write = &port_char_write,
+	.release = &port_char_close,
+	.poll = &port_char_poll,
+};
+
+static int port_char_init(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	struct t7xx_cdev *t7xx_debug;
+	struct device *dev;
+	int ret;
+
+	if (port->debug.debug_port)
+		return 0;
+
+	t7xx_cdev_init(port);
+
+	t7xx_debug = port->debug.debug_port;
+
+	port->rx_length_th = RX_QUEUE_MAXLEN;
+
+	ret = alloc_chrdev_region(&t7xx_debug->dev_num, port_conf->baseminor, 1, "t7xx_cdev");
+	if (ret) {
+		dev_err(port->dev, "Alloc chrdev region failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	cdev_init(&t7xx_debug->cdev, &char_fops);
+	t7xx_debug->cdev.owner = THIS_MODULE;
+
+	ret = cdev_add(&t7xx_debug->cdev, t7xx_debug->dev_num, 1);
+	if (ret) {
+		dev_err(port->dev, "Add cdev failed, ret=%d\n", ret);
+		goto err_cdev_add;
+	}
+
+	t7xx_debug->dev_class = class_create(port_conf->class_name);
+	if (IS_ERR(t7xx_debug->dev_class)) {
+		ret = PTR_ERR(t7xx_debug->dev_class);
+		dev_err(port->dev, "Create class failed, ret=%d\n", ret);
+		goto err_class_create;
+	}
+
+	dev = device_create(t7xx_debug->dev_class, NULL, t7xx_debug->dev_num,
+			    NULL, port->port_conf->name);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		dev_err(port->dev, "Create device failed, ret=%d\n", ret);
+		goto err_device_create;
+	}
+
+	port->debug.debug_port->cdev = t7xx_debug->cdev;
+	t7xx_debug->port = port;
+
+	return 0;
+
+err_device_create:
+	class_destroy(t7xx_debug->dev_class);
+err_class_create:
+	cdev_del(&t7xx_debug->cdev);
+err_cdev_add:
+	unregister_chrdev_region(t7xx_debug->dev_num, 1);
+	return ret;
+}
+
+static void port_char_uninit(struct t7xx_port *port)
+{
+	struct t7xx_cdev *t7xx_debug;
+	unsigned long flags;
+	struct sk_buff *skb;
+
+	if (!port->debug.debug_port)
+		return;
+
+	t7xx_debug = port->debug.debug_port;
+
+	device_destroy(t7xx_debug->dev_class, t7xx_debug->dev_num);
+	class_destroy(t7xx_debug->dev_class);
+	cdev_del(&t7xx_debug->cdev);
+	unregister_chrdev_region(t7xx_debug->dev_num, 1);
+
+	t7xx_cdev_uninit(port);
+
+	spin_lock_irqsave(&port->rx_wq.lock, flags);
+	while ((skb = __skb_dequeue(&port->rx_skb_list)) != NULL)
+		dev_kfree_skb(skb);
+	spin_unlock_irqrestore(&port->rx_wq.lock, flags);
+}
+
+static int port_char_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned long flags;
+
+	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
+		dev_dbg_ratelimited(port->dev, "Port %s is not opened, drop packets\n",
+				    port_conf->name);
+		return -ENETDOWN;
+	}
+
+	spin_lock_irqsave(&port->rx_wq.lock, flags);
+	if (port->rx_skb_list.qlen >= port->rx_length_th) {
+		spin_unlock_irqrestore(&port->rx_wq.lock, flags);
+		return -ENOBUFS;
+	}
+
+	__skb_queue_tail(&port->rx_skb_list, skb);
+	spin_unlock_irqrestore(&port->rx_wq.lock, flags);
+
+	wake_up_all(&port->rx_wq);
+
+	return 0;
+}
+
+static int port_char_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+static int port_char_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+struct port_ops debug_port_ops = {
+	.init = &port_char_init,
+	.recv_skb = &port_char_recv_skb,
+	.uninit = &port_char_uninit,
+	.enable_chl = &port_char_enable_chl,
+	.disable_chl = &port_char_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 7d6388bf1d7c..3dd87f25124e 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -39,6 +39,8 @@
 
 #define Q_IDX_CTRL			0
 #define Q_IDX_MBIM			2
+#define Q_IDX_MIPC			2
+#define Q_IDX_ADB			3
 #define Q_IDX_AT_CMD			5
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
@@ -100,6 +102,28 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
+	}, {
+		.tx_ch = PORT_CH_AP_ADB_TX,
+		.rx_ch = PORT_CH_AP_ADB_RX,
+		.txq_index = Q_IDX_ADB,
+		.rxq_index = Q_IDX_ADB,
+		.path_id = CLDMA_ID_AP,
+		.ops = &debug_port_ops,
+		.name = "ccci_sap_adb",
+		.debug = true,
+		.class_name = "t7xx_adb",
+		.baseminor = 100,
+	}, {
+		.tx_ch = PORT_CH_MIPC_TX,
+		.rx_ch = PORT_CH_MIPC_RX,
+		.txq_index = Q_IDX_MIPC,
+		.rxq_index = Q_IDX_MIPC,
+		.path_id = CLDMA_ID_MD,
+		.ops = &debug_port_ops,
+		.name = "ttyCMIPC0",
+		.debug = true,
+		.class_name = "t7xx_mipc",
+		.baseminor = 101,
 	},
 };
 
@@ -505,13 +529,32 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops && port_conf->ops->init)
+		if (!port_conf->debug && port_conf->ops && port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
+{
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		spin_lock_init(&port->port_update_lock);
+		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
+			if (show)
+				port_conf->ops->init(port);
+			else
+				port_conf->ops->uninit(port);
+		}
+	}
+}
+
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
 {
 	struct port_proxy *port_prox = md->port_prox;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..5bf958824aa8 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -93,11 +93,13 @@ struct ctrl_msg_header {
 /* Port operations mapping */
 extern struct port_ops wwan_sub_port_ops;
 extern struct port_ops ctl_port_ops;
+extern struct port_ops debug_port_ops;
 
 #ifdef CONFIG_WWAN_DEBUGFS
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show);
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
-- 
2.34.1


