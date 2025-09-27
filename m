Return-Path: <netdev+bounces-226877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B338BA5C6B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912A6322D4D
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B52D6E77;
	Sat, 27 Sep 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H0fnJ8b2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3B2D6E60
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965580; cv=none; b=VpQXn7OT1U8FyWfaFkHlxSLKh5/mInX6Hinn7NSn/cLAlOMc6VcAuC8CNJbeHD/4bFk5EPUQEBHPhM2Ig/L0V8zPzTARoP8RlV/MS7Cc497Sjc0L4u64tOnibmWgcQ83yzCxynr+b6BNFkPmlD0A7vlTDusNpjnPMg4ki/uBLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965580; c=relaxed/simple;
	bh=T0owoIPofnyzW4Avxoc6goge4UHeLJLB3B7hm4L3kic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQ0ocYPhxQBHpcwNooH0sW5SgNkKgBswR9DuKz4Vw3ukfVoa0kka3BvHwgp8i7Hjv58CZt+fbN2ksDIrwiKFZtg3i3yunJRUyEkkVKSD9RCZgLVhzLJM1dAV4STLRz/Gm/5NkHQgYhDG1oo94ME1IqkW1TtnyJd5PFP1uqQxUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H0fnJ8b2; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-378aa12c13dso116921fac.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965577; x=1759570377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2eN97lrd2X1O67qn4UD4rbJd5H5Hku4e5AFCX3vwPc=;
        b=R255V+tLoEfqb97txuGpGCOnJka1cuIusQ6IfOkKpdihW3vfslrbeeh+lmYkkm8HNr
         C9ur1Jmdu/P3lltS9UhxvGCC0lpcLHJlgaCaBbHn8nmiz/bMFxTzjh46BOkKo6MlAE90
         4I8AthOhI3rxHetm6GqljW6kIf3lGxfhALKA9SjIVvH8Ccc+Sk7Xsj52p2pCEA+M5YrZ
         lVoaXLKQVSoYLr6qM1PZmmE7u3J00QvEXjEY/kDSwbbEvftwgIaLqre92bScuk33S8cj
         6ibgeJnMrv8RFL1oql0BPHjXVkOBs7dDIZzLBFiLztUmYI4au2DSXgo+T0HzfTcsc+3t
         WhfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLb40mNU7stmEWtvEG9bUHGX7k2KFzvJTd1Y8DHSZsVd7m7oUUHub53HZSmgj1BxQll7l2FrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZbMqNDjtYLSSJyZn4Hvalf9eOhgACJJm/IpSQbr+0ejo450V
	WlPwpEu53CP9KxjWLpGIh5AXc7M4TypxDvfALbb5GRYqzdY4YV0nEQaKj8Fb2u1zruDXsIGZ+Ry
	gGZ8ACSkcC5brGfFWthLB3iQ42wU64f0YDynnQdOVD35MGLf0P4GwkifN4uCa1LxOSks8qFVKgB
	82ELKBro2nvh4YmTeOAPr/rbf4VgiDnv1hyTIyOr8CWSZC4qA7fjUYYJ5QOO5UPNmt106+oaz+u
	FMMxR58VQZkVA==
X-Gm-Gg: ASbGnctsC27iEeWx67EGK8d6gsZZuHJgwEur/jTNYwviT6OJ/rITu7kVMUrHw+RMPSc
	YVesvf/i6hv9PTV7+Yk3bqJrI7wUsufP0eJ5hVsqaBvqzblK1gi+NhDQk1ZW0EiENt9SJhgPwkc
	Oe7jeujMnvuIAM2bmett6n/oLrA4/taY+RR/fInaK11FQfEGTQM/a/SfPwxoxImaZdvCxp6oAmX
	LN+fDwr599DzZ9x8a8+degj+IqaDCYJp2aINFCpBlpM+nboR4ruoWSH7h0hq8HJFQ8lA1Py8+bY
	k0EJfXnTpdN+BUYWz+9IyY8IBK4qQbd6tLVCXO81+qJA9yczFVuM5GeB+ATCSvyT6Ohu5RQtnIu
	CbHReFW2nmkfPmLPR4I1H2IkdUULUmWRXRhVgSbQEWxHA105DdMLv7pcruqTXYB5ZpiBJRl2Uya
	w=
X-Google-Smtp-Source: AGHT+IH3Wv+WC9pjfO2kNNIawZouUqjkJKg9o1LYKhdzqmwAhqAY4S/3SclS8y38Z1N6hCYrk27LZ2FLtKY8
X-Received: by 2002:a05:6871:14f:b0:358:ecec:aa with SMTP id 586e51a60fabf-35ebd6f37abmr5338641fac.5.1758965577620;
        Sat, 27 Sep 2025 02:32:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-363b49ab3a3sm534898fac.13.2025.09.27.02.32.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:32:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso1932571b3a.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758965576; x=1759570376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2eN97lrd2X1O67qn4UD4rbJd5H5Hku4e5AFCX3vwPc=;
        b=H0fnJ8b2X8LsukQiQByDz8PV5C2dPO18XApdCI9wtSjqVdRp5EoBMa61VRefHowFCN
         AiRvIzaTZ+a+9leG+YfXjkLyaIxeJ7fmLKMgCDijuU4bwR18lt9wkYdKapxGsjP7m4yS
         WFlus+P0AALQlQF5SnWZPAqiKBcIAnfz7Wkho=
X-Forwarded-Encrypted: i=1; AJvYcCVxtEOv5w6dgUVeW3JAMad/CRBp46Pu/M9PKdXUSrVb46QLBBdB0qsHL9X5wP1r3qutYWlG/Y8=@vger.kernel.org
X-Received: by 2002:a05:6a00:2308:b0:77f:1b15:6b0d with SMTP id d2e1a72fcca58-780fce534aemr9540783b3a.13.1758965575844;
        Sat, 27 Sep 2025 02:32:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:2308:b0:77f:1b15:6b0d with SMTP id d2e1a72fcca58-780fce534aemr9540763b3a.13.1758965575418;
        Sat, 27 Sep 2025 02:32:55 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm6109940b3a.14.2025.09.27.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:32:55 -0700 (PDT)
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
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 1/5] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Sat, 27 Sep 2025 02:39:26 -0700
Message-Id: <20250927093930.552191-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
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

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c                         | 2 +-
 drivers/infiniband/hw/bnxt_re/main.c                            | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                        | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h                       | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                   | 2 +-
 .../broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h        | 0
 10 files changed, 9 insertions(+), 9 deletions(-)
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
index 1d0e0e7362bd..785a6146b968 100644
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
index 41686a6f84b5..818bd0fa0a7d 100644
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
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
similarity index 100%
rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
rename to include/linux/bnxt/ulp.h
-- 
2.39.1


