Return-Path: <netdev+bounces-225162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D9B8FABB
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8184E4E1E3D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739452777EA;
	Mon, 22 Sep 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HwJjORpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AE26A0A7
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531660; cv=none; b=HTfQk2X0lMiQk+ThsI7miXyEXtPByln49vtMKny1M+xDn1JJVuKN0ThYrEoZIPVFlJ8Tu6nWOHHwsQp50T1bACic8ducX8hKVup9YG5xLxnAfLUBMM7Wjec7u6J00vTH2PdYvl5NtVnKwpiFtP0Trr5Gmh4JB6mGvhTY2rm2bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531660; c=relaxed/simple;
	bh=GrtQGmGkLlR86WPPf44M8jYSdkYl1opTdi22H1JdKYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbWCoaOFBb73KirZnGQ5Iga55sH+uqfyOIOaC0YyXu4vF3jHhNEPr5gTfPwh//BbM+5GGSGXe0fR66M/wUajyKeJdpdycjIKAYazg+yt+/Lcc56fUdsgq9ETIuUP4u5WMBzpT8DhiQyiCR1U+FNVYEZ8iFIrOEhE8iDqXyrC3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HwJjORpI; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-7639af4c4acso48268266d6.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531657; x=1759136457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohToGiOuQ9ipgrncdzrxnVeYCG3P2De3hdTb+IzyuTg=;
        b=IBF1OcfedB/g/WdUqcQpv+KJCbBKtl00GeIWyguBRUSBONUseBRUvFHvAD2bZACEi4
         8lC6FEdmUA6A7mR4v5j5dAuawtvlcW7xWWKFSQT+LAhaxsTt6VPaJ4hiKBB8j3MTRegH
         1C+KQlWV5MHyo1+ruTIiQbUTUd4e9/r+OUqswLlyoriZBagqR2m0g//w45y7BBtL9uSj
         D0P1Lu2gycTCrBu0ZYCfvF9WANYYc5++hrOlDKbp/Ug4Z86a29NxS/2Jc+dGZ8TgGAA4
         2jfpG6+XSBD7DQUbw54bWA5k/ZWL/iSCrmnPx8+Ljpdqr7gyCv5k5kUH5K6d4DpsfRBQ
         jS3w==
X-Forwarded-Encrypted: i=1; AJvYcCXmHmjhcIOyANI1RcZrmpT9OiDzbJjn/tyb1jw8/Q2q11JKdkYaR5U15WyO16NJ4D467q4F9sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJLGQqb95JCWzbCYbWSUiH7O3cUJiJ+wqbe8UuowQcaonVN7i
	n8O3+07zKqvyEYkuP7gZWkLKL4dgcMryWl3tZV7eSqchnI89AZe5rkkLIolSQvzkF52VuuVinqY
	ibY+acTSPJrWNqGsbb2/+om7h2YjwNky2oBDlnhWcCuLNGk2riIFrFdRA+6f9wOv2aKLCUDsGMs
	rm2WtGH7SSvGZdT/ZvPnMlFJCUFBJIZ43x5u7fgHbvwMOcEDAHnhREI6q/tiOqFFVZfZVdxu8FN
	HMZKTqurPo=
X-Gm-Gg: ASbGncv2Afe69Bc2igpCNW7sEri9q5ThNsVQy9Ge17G57uGMaczsELOQpBCFxuJz60f
	EL8zyg6hwn5slLGPlK3RHomIesqL/IoMOPUpe9dMfwap1auzEn2ltzpltdlb5DQ683aP6/VEjew
	arkjv8lu772coCtXvWnAQLIMwdDURQL/QOevgkxdf6+va/lde93BRLEIsnyFclRNfy/v4skaVkL
	Bf3czMOiIJjjYnkYC6e4s//OyUwv4lakAkfVAMxc+U4tlqn3T+r71NQgFCp+ubboXlFybAw35bt
	j0XVk829/kgJJl9lCvwpTsCbmO2w78qhWHztW8MmryG18LpqL44hhO/yJYgUq6FHoPY6HHE9FR0
	qlTSOc+9DU6RbrCOxbK8j7LxcG2nB1s/ZAQitd7AI4AHsl1qdf+8MfNIjbrcUoTrW2SXjwvSLaA
	OMkQ==
X-Google-Smtp-Source: AGHT+IGjSNHc6lvLgeVVWwU/GyRradTXihi41oh57QPLpF9LyhIjWzyNMibbxcqwXHUILywRV2e2OGqDSqEy
X-Received: by 2002:a05:6214:411:b0:722:48f8:66a with SMTP id 6a1803df08f44-79914a178ddmr158527046d6.28.1758531657103;
        Mon, 22 Sep 2025 02:00:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793456fe307sm7544416d6.14.2025.09.22.02.00.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:00:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457ef983fso93588145ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531656; x=1759136456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohToGiOuQ9ipgrncdzrxnVeYCG3P2De3hdTb+IzyuTg=;
        b=HwJjORpIfyrCRqMVGbH+Dsrn35moQPBcyzRbqF/Ij2AW/58uxQqkHTy2TTtTCUSmG5
         ufwpIAUGx/gCVKjtFuQ26O//yd7n0j7iN24O6TDf4Zkibt1taAHRv/S3ba2MgZb2tiUy
         V4ije4TOpOWEJ+8npk53k57bGTpbHxfjyYaeo=
X-Forwarded-Encrypted: i=1; AJvYcCXr+JWspCHUBksVX6nv7sy+VNu4yEXGb8a3HX9xWcIByaagjqOVVcsVEgWaER6u6X5SODoQ4tg=@vger.kernel.org
X-Received: by 2002:a17:902:e852:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-269ba3ecc28mr167160075ad.12.1758531655709;
        Mon, 22 Sep 2025 02:00:55 -0700 (PDT)
X-Received: by 2002:a17:902:e852:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-269ba3ecc28mr167159785ad.12.1758531655243;
        Mon, 22 Sep 2025 02:00:55 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:00:54 -0700 (PDT)
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
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 1/6] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Mon, 22 Sep 2025 02:08:46 -0700
Message-Id: <20250922090851.719913-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
References: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
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


