Return-Path: <netdev+bounces-225548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCFB95517
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49EA3B8F3D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A76320A3F;
	Tue, 23 Sep 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BrbbHL5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66ED1946DF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620993; cv=none; b=g7mqrjySZS+9D4NTIoPgFuXNOfy3IDwAX5REmrHUKtma9Fvy8LnnNkh0WAhSOEzR2+UQU+BKTymnYvarha+3aIFSD1yUiurbo1/+fdMM9CvPm8pfemhj3occ8vqlvkaI9BgtEd3Z2kLhuvSjPJLTeV6/m58hNlJHw2KjGG45Py8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620993; c=relaxed/simple;
	bh=GrtQGmGkLlR86WPPf44M8jYSdkYl1opTdi22H1JdKYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmf3Rf4TZmvp3gw94bc6q7RoXmhQFrYU59z8ojdHYL4DDQrUMaIbznSn3pf1/Bf3UW6rGGk1JSOjdjBO27a0nIEsyiLneViqOIdaDvB1rIddp1/gYODiFmjMFD2NGzwseyhG8uTka1RReejEuGC2tgMKjZ3Q7JQc5qn3Xdw8ODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BrbbHL5Z; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42575d46250so19300025ab.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620991; x=1759225791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohToGiOuQ9ipgrncdzrxnVeYCG3P2De3hdTb+IzyuTg=;
        b=YnP+QjmXbvi7G4JGDFaNz7CenH+/7esb26CE0mkb/0o1d6MlKy5P1zBY37otHhLHCB
         yi4ld/aO718g4lSKqTQhsfay1J8uEYZQuqOSQ/W6cCGPlL/GslaTrQsjAeYvhcdW0quZ
         H9Eecj4w4JfDkrOsXKnvW1j5l+4obytPPMR3/l+jl4kMdSNJnlA4HC/m5tPSEP1xqmHK
         L4iclMXFzdVay34+Gc5GgQDuASXr+E58FZWAR/rXjoLb4tcjvFzXokTXyZFtKWtXKxlU
         QJtxAWkYMAm8QXiEFenUS+stpyggefUN033nfsmh1M/J36o93W3X9CrvxbcscPrMgtOk
         u2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUmJbDpp1+frxYjtuOrHx/oz5tq1ZIcJgNWEfu5oYoMkLQOd8zp4bE3A7pCx4hdmRlIOb5F2rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXw4NHhuKWJDenBl+xPMMgEnaOncVxzfFR/1BOssb1zSllPRD
	Eea8YmQkwjIpPUi7PB4xfCj0YFvV0lGGoTJHSxIRug9OmkCpenXBG14+o7JqjxZKLQAyMxy2xvi
	/fU4n7dl0m3XBlO4D8q7NXWc6561uIPwlnRRPkEfd7RkQweibpsLqjwTQ59l8h+mNch1cz8Ypwt
	eYG1fqYxDop+5gBOY+xP/aaBOCGVu8zfeneRCqp4ySS16UP3UyINH3QDqsEcXwms4N6r4Vk2hDS
	0MUfYQmnqE=
X-Gm-Gg: ASbGncsKk2YEijDxnEiYqiCFNgxOEgK9IgFYjtuNKx+5/HuG5+4l9QzKr75dMn5Nj5Q
	OzShL5FfboahZKkPhxYXQ915hHs1+Jm8mHi1O4zx8itFNxKeWKoFtOkZwv0IsbB5p+h2bYQVG/a
	Fq2ElPUIILcaw/3la9AZW5uuBFCckE/XqtmSDfeOz4Olf/QXhB0Z+zg9TyEdn32hvCa5LvnGQqX
	JvrWjdsdUrkx8XfnYrmi0kTYXrlB+dUDl1IwK42CixiSAHDsUuXIHQjV7/42u+3BEf9Cc5+Ygdb
	HIIcPFVqg/ftmvGOyil3bAY4VmBeXjW5FTIvzZtU7RT7bcH71aGy7qMifhpUK2/x/IuyOXP2MCO
	oqegNQmKS+lF3ntk4jgm15fyuQrFHauqaObimwVVNrfD/RQec9QX5I7yEAVFg7fGOFl2H5CbRGB
	M=
X-Google-Smtp-Source: AGHT+IFAYa0KfNvOIX35eBxFRlu9Rmkk3fimVEy4Fu0QoXOo2mderBVz6qpJ8X6bBw0PEfhSU12y4/rDbU52
X-Received: by 2002:a05:6e02:170b:b0:406:7c54:9f6c with SMTP id e9e14a558f8ab-42581e0e789mr27396245ab.7.1758620990640;
        Tue, 23 Sep 2025 02:49:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d54138732sm815418173.41.2025.09.23.02.49.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:49:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2697410e7f9so100965505ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758620989; x=1759225789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohToGiOuQ9ipgrncdzrxnVeYCG3P2De3hdTb+IzyuTg=;
        b=BrbbHL5ZwzE6HK7PVzhQHOkiD8mtmFJFgQIPGHdusShG6nA/d3+AauR3urk7ccDcVJ
         w1kmfoRJ8qfhiDoPttL8ktjaGGbYBxmtQrP1ZHnPywCzwEWRSgtr2o0B+NQsGinUO5mF
         1yT2KkkBFhJu+KuEJRroc4bo3Vv7JvORSqkbg=
X-Forwarded-Encrypted: i=1; AJvYcCWC+HMgFZ7L/rsAu9jjwD5X1GmiwfqSOYSPLK03iOPysG8EzEfouZLtAAUkqkSmRcAiihAHdEE=@vger.kernel.org
X-Received: by 2002:a17:903:1209:b0:269:d978:7ec0 with SMTP id d9443c01a7336-27cc5625511mr21869675ad.28.1758620989165;
        Tue, 23 Sep 2025 02:49:49 -0700 (PDT)
X-Received: by 2002:a17:903:1209:b0:269:d978:7ec0 with SMTP id d9443c01a7336-27cc5625511mr21869445ad.28.1758620988811;
        Tue, 23 Sep 2025 02:49:48 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm139105945ad.100.2025.09.23.02.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:49:48 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	davem@davemloft.net,
	corbet@lwn.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 1/6] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Tue, 23 Sep 2025 02:58:20 -0700
Message-Id: <20250923095825.901529-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

We have common definitions that are now going to be used
by more than one component outside of bnxt (bnxt_re and
fwctl)

Move bnxt_ulp.h to include/linux/bnxt/ as ulp.h.
Have a new common.h, also at the same place that will
have some non-ulp but shared bnxt declarations.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c       |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  7 +------
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +-
 include/linux/bnxt/common.h                   | 20 +++++++++++++++++++
 .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  0
 12 files changed, 30 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/bnxt/common.h
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (100%)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index e632f1661b92..a9dd3597cfbc 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -9,8 +9,8 @@
 #include <linux/debugfs.h>
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
+#include <linux/bnxt/ulp.h>
 
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index df7cf8d68e27..b773556fc5e9 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -55,8 +55,8 @@
 #include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
 #include <linux/hashtable.h>
+#include <linux/bnxt/ulp.h>
 
-#include "bnxt_ulp.h"
 #include "roce_hsi.h"
 #include "qplib_res.h"
 #include "qplib_sp.h"
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index ee36b3d82cc0..bb252cd8509b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/prefetch.h>
 #include <linux/if_ether.h>
+#include <linux/bnxt/ulp.h>
 #include <rdma/ib_mad.h>
 
 #include "roce_hsi.h"
@@ -55,7 +56,6 @@
 #include "qplib_sp.h"
 #include "qplib_fp.h"
 #include <rdma/ib_addr.h>
-#include "bnxt_ulp.h"
 #include "bnxt_re.h"
 #include "ib_verbs.h"
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 6a13927674b4..7cdddf921b48 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -39,7 +39,7 @@
 #ifndef __BNXT_QPLIB_RES_H__
 #define __BNXT_QPLIB_RES_H__
 
-#include "bnxt_ulp.h"
+#include <linux/bnxt/ulp.h>
 
 extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59612d1e176..917a39f8865c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -59,10 +59,10 @@
 #include <net/netdev_rx_queue.h>
 #include <linux/pci-tph.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_sriov.h"
 #include "bnxt_ethtool.h"
 #include "bnxt_dcb.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 06a4c2afdf8a..2578bac16f6c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -33,6 +33,7 @@
 #ifdef CONFIG_TEE_BNXT_FW
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
+#include <linux/bnxt/common.h>
 
 #define BNXT_DEFAULT_RX_COPYBREAK 256
 #define BNXT_MAX_RX_COPYBREAK 1024
@@ -2075,12 +2076,6 @@ struct bnxt_fw_health {
 #define BNXT_FW_IF_RETRY		10
 #define BNXT_FW_SLOT_RESET_RETRY	4
 
-struct bnxt_aux_priv {
-	struct auxiliary_device aux_dev;
-	struct bnxt_en_dev *edev;
-	int id;
-};
-
 enum board_idx {
 	BCM57301,
 	BCM57302,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 02961d93ed35..cfcd3335a2d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -13,12 +13,12 @@
 #include <net/devlink.h>
 #include <net/netdev_lock.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_vfr.h"
 #include "bnxt_devlink.h"
 #include "bnxt_ethtool.h"
-#include "bnxt_ulp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_coredump.h"
 #include "bnxt_nvm_defs.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index be32ef8f5c96..3231d3c022dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -27,9 +27,9 @@
 #include <net/netdev_queues.h>
 #include <net/netlink.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_xdp.h"
 #include "bnxt_ptp.h"
 #include "bnxt_ethtool.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 80fed2c07b9e..84c43f83193a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -17,9 +17,9 @@
 #include <linux/etherdevice.h>
 #include <net/dcbnl.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 #include "bnxt_sriov.h"
 #include "bnxt_vfr.h"
 #include "bnxt_ethtool.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 61cf201bb0dc..992eec874345 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -22,10 +22,10 @@
 #include <linux/auxiliary_bus.h>
 #include <net/netdev_lock.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
-#include "bnxt_ulp.h"
 
 static DEFINE_IDA(bnxt_aux_dev_ids);
 
diff --git a/include/linux/bnxt/common.h b/include/linux/bnxt/common.h
new file mode 100644
index 000000000000..2ee75a0a1feb
--- /dev/null
+++ b/include/linux/bnxt/common.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2025, Broadcom Corporation
+ *
+ */
+
+#ifndef BNXT_COMN_H
+#define BNXT_COMN_H
+
+#include <linux/bnxt/hsi.h>
+#include <linux/bnxt/ulp.h>
+#include <linux/auxiliary_bus.h>
+
+struct bnxt_aux_priv {
+	struct auxiliary_device aux_dev;
+	struct bnxt_en_dev *edev;
+	int id;
+};
+
+#endif /* BNXT_COMN_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
similarity index 100%
rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
rename to include/linux/bnxt/ulp.h
-- 
2.39.1


