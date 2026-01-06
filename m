Return-Path: <netdev+bounces-247284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9895ECF6716
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4AE309D9D2
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C7242D95;
	Tue,  6 Jan 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C006j4Ey"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988D6A33B;
	Tue,  6 Jan 2026 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665732; cv=none; b=qPdutBqbMkM0J0gu55M6P+HOjH4NlQoM++U5tisrXAupIdUdUgvTjlrEfjAmrFf4DC2htI+eWz9ap5NYBj0v7dpxBTc4NMNhDmuk/WZjgQT7MuHZtU8H0WjwMw4kLs7e64RndxcsAkO2nwVBEewwHc4hzCfiiqgOkMEhzIrx6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665732; c=relaxed/simple;
	bh=VPL7cY5hXj3FpxTvpOsbsODW83prXCZ0lMzheuXz8Fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQf1YXDtCUgcmJKYZ1hgllBIeBkXOUNtS/eqMnsf7JQukjjGiTY2bMZeaEaLIYiHAJNkmKgjgDsQbf1wCSZTtcvPzOdPTtSbCVlteT3pQoF6yseotIfdveUfZ9fxW8/sQj1Ngvmn5Pki3Ego04NMzJy/QLZ8lS2GhTAwrTRvT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=C006j4Ey; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605HTIWg2641688;
	Mon, 5 Jan 2026 18:15:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	gBybVPPCOIc6IngKgSVGMqcbXcX2DK8HxdJjFvtc7E=; b=C006j4EyS8N89YB86
	2ZbPUFTgj8Y88hQUrdn08sneqRlGvFzv5AEWdYEs6CW1tnrLHJk8m7cJ5H3MFS/M
	WutdFVEiWD0a7YwHqiA0m5x/HaH253/gPIrNgbwhlmDoL9bDVHQl6Ap+71PNdX1N
	p7XgOXyXRHBnGYGn7lpntsn7X1BTlbtXXNQXuyoSSGm8nlGWh2h5ePdd1KeDmT9V
	9YdIQJJeen8FS4vmLRQrtB9mVe51e+FyaFFRdjIINbtugTsZpISe6lFf9F8BKaAU
	DfsCF/NZOspzt49fiZld1egW7ZklvE8InGD+WueVbzHoMe+5eYI8bDf7f9gyHNgH
	bbmiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bfr8bk7ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 18:15:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 18:15:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 18:15:35 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0F2273F70C4;
	Mon,  5 Jan 2026 18:15:17 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next 03/10] octeontx2-pf: switch: Add pf files hierarchy
Date: Tue, 6 Jan 2026 07:44:40 +0530
Message-ID: <20260106021447.2359108-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106021447.2359108-1-rkannoth@marvell.com>
References: <20260106021447.2359108-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: upjjShMv1994MdZ78AFaazzrEylAC5Ph
X-Proofpoint-GUID: upjjShMv1994MdZ78AFaazzrEylAC5Ph
X-Authority-Analysis: v=2.4 cv=P/I3RyAu c=1 sm=1 tr=0 ts=695c7039 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=rErRu6woPkWivxaahN8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX7ISvLJNn8M/I
 RlmcyWVMahxKo9MQtoshNMLyD+/VIYy5KqeoEktq7ZRxf2FdEHNvD1UvlfrSnhZQ4RGjAZj/11U
 TvQfKJn0vAbv7STNT+9CaYnyl7Xj86gNN3HkHcthPdWKZ4cpHKSTDD44DedFuX8lWjn5mKx+btj
 /D3455HhUzRWUb/JHWcgeyW2lP0mrfCC3pZ4p6bmMY+LUjuku0zb5uboIngzBItrVzM2RRO5Q4m
 QJF8g11/ahWRekmb6ix87qvNKNIaWbb8FzuNnYZ+HXgQpf2jXlLnShKib7OkYTZHPlbgMlmq2Ms
 eoEpLtqjJ9KFGEu3S7ubRv2SC6BhVa9L4HHpYsr7TINLK90Xm0obRPLqIP4U9VxY3njJP4HeZwg
 xmvp5V1qczySzG0rctkDpKZmCbrYVB22Wz+yU7+GRwQMK/8OTWvRkBgHhd8y58oSYj+eG5snd5n
 IQ3maeukZbQZ8q6ex5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

PF driver skeleton files. Follow up patches add meat to
these files.

sw_nb*  : Implements various notifier callbacks for linux events
sw_fdb* : L2 offload
sw_fib* : L3 offload
sw_fl*  : Flow based offload (ovs, nft etc)

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/Kconfig  | 12 ++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/Makefile |  8 +++++++-
 .../marvell/octeontx2/nic/switch/sw_fdb.c       | 16 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h       | 13 +++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.c       | 16 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h       | 13 +++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.c        | 16 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h        | 13 +++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.c        | 17 +++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h        | 13 +++++++++++++
 10 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 35c4f5f64f58..a883efc9d9dd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -28,6 +28,18 @@ config NDC_DIS_DYNAMIC_CACHING
 	  , NPA stack pages etc in NDC. Also locks down NIX SQ/CQ/RQ/RSS and
 	  NPA Aura/Pool contexts.
 
+config OCTEONTX_SWITCH
+	tristate "Marvell OcteonTX2 switch driver"
+	select OCTEONTX2_MBOX
+	select NET_DEVLINK
+	default n
+	select PAGE_POOL
+	depends on (64BIT && COMPILE_TEST) || ARM64
+	help
+	  This driver supports Marvell's OcteonTX2 switch driver.
+	  Marvell SW HW can offload L2, L3 offload. ARM core interacts
+	  with Marvell SW HW thru mbox.
+
 config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 883e9f4d601c..da87e952c187 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,7 +9,13 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
+               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
+	       switch/sw_fdb.o switch/sw_fl.o
+
+ifdef CONFIG_OCTEONTX_SWITCH
+rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o
+endif
+
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
new file mode 100644
index 000000000000..6842c8d91ffc
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fdb.h"
+
+int sw_fdb_init(void)
+{
+	return 0;
+}
+
+void sw_fdb_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
new file mode 100644
index 000000000000..d4314d6d3ee4
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FDB_H_
+#define SW_FDB_H_
+
+void sw_fdb_deinit(void);
+int sw_fdb_init(void);
+
+#endif // SW_FDB_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
new file mode 100644
index 000000000000..12ddf8119372
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fib.h"
+
+int sw_fib_init(void)
+{
+	return 0;
+}
+
+void sw_fib_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
new file mode 100644
index 000000000000..a51d15c2b80e
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FIB_H_
+#define SW_FIB_H_
+
+void sw_fib_deinit(void);
+int sw_fib_init(void);
+
+#endif // SW_FIB_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
new file mode 100644
index 000000000000..36a2359a0a48
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_fl.h"
+
+int sw_fl_init(void)
+{
+	return 0;
+}
+
+void sw_fl_deinit(void)
+{
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
new file mode 100644
index 000000000000..cd018d770a8a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_FL_H_
+#define SW_FL_H_
+
+void sw_fl_deinit(void);
+int sw_fl_init(void);
+
+#endif // SW_FL_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
new file mode 100644
index 000000000000..2d14a0590c5d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "sw_nb.h"
+
+int sw_nb_unregister(void)
+{
+	return 0;
+}
+
+int sw_nb_register(void)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
new file mode 100644
index 000000000000..503a0e18cfd7
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell switch driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#ifndef SW_NB_H_
+#define SW_NB_H_
+
+int sw_nb_register(void);
+int sw_nb_unregister(void);
+
+#endif // SW_NB_H__
-- 
2.43.0


