Return-Path: <netdev+bounces-226615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1DCBA3041
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFE63B99EB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7A29B778;
	Fri, 26 Sep 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ROYU4YKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3129B20A
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876690; cv=none; b=Va8MU4YM1wtrOEEQIvFPiwARjR99MXGclF/TFhTd+RYz3ZtaAOqk7132NaAgd37enNJdy0IcQmxzVXi4XoQe66h9kj2khzzNH2AqS34a1vBtfZ4+efM9O465ls7bEbyQxeZu97Zz2org0kmtVFUzt6UZaSThHdujugcfvM9zxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876690; c=relaxed/simple;
	bh=PqVmoBJ3n9FUfPcb+ahelooKl/SQ3J98XS1MbbnNCPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUj17Z4ubae9yihETkxqKf/ODFjxCVqWCsFpnJW/lB6lgmiZ5x4V6Bb8FZq60esrfQuuvvt8e7kRdvwVlopcpcfHyTZPZIriF0gpKx7Z3V+EszOz5ci0R38CUyuM8E0GBx/+TDJ/yV++jj9uVusB71V8FFMwkpd98SUR3TYaCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ROYU4YKE; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4dca66a31f7so12569341cf.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876687; x=1759481487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WTwptKJB4wsOQ5ZpYNmlcHWB6JYf0nt/4QKdcm94TA=;
        b=DwkL2pG8S0fMwF82/p/y7JPgASnAKt8rI38bq6Ru9sUIBCrcSXfCzr3r6xKu/cBsTF
         3LZFzAt5g11Ni/ur6oXj86Gq0QPVJVtOOE32HtwCD68NyLrZ8j5OjIh21uYEZrK1FL4S
         I99bhqiQ5RnP05+xIdjecupyhk9XWax287/SlD/cPuQ6QNKOlO6VYL8MfcVVFl6zJ73V
         qAnC40ArA9M66szErx5TYexQhpYvKaKZDjS4ajK6Bxnq+97H3Tt00Mr6VU2e+LDYJkQ4
         pWHh4Xx75ZVuKTyscpsXSfULceWU89Hn3T1ShSiZXzH4Z9pqGmuWJNSRO1ov+J4a4GfO
         gvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeQq3zPDroP3QYFQprO6trgF/hXpCQ5at48auOeJrE+CSjUvPCaZoTWqrUCFQ4/wxiDmZzPDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjeSgxBXVncj93KExrhgXC7JeD6ZMS3ycQqUFDysSqwusw1cL
	Uh3lx5CbrSr8rxV4+/4f0sxEYl8ycllVnGkQF+sdsvBkGCBV6/Ph0T/+1MUUXNSp42hrJZBeXeM
	L2dLmb8tJcFcoHZpRvXug5rS0gKj4FvJtL8M72UFyemNUcY4pAucIw4U2PpurdCzKcqKwpPqfAP
	tWNfxqRgvc3pW7Ap5g77eL+k3Rq97G597Q6+JWIvFKAhCX3yY5M6WV7YpaN4+udh44XJr2YX07v
	Pl2jrgH2ng=
X-Gm-Gg: ASbGncsjn7i6Yn0qZqG4L4ypqJ8WH4Du2bKR309095BI0yOFmxjuTU4ggB61a3Vynzi
	HzkO4qpKOhQtC4Wg41r6fFp7xL+e6H8gYTHM9D5BzRTEkAp5LAkRgA55huBryQhL9YA3WtNq7i0
	WBB9Oh2tZPa/X8zTEPQi6xkmsnM0nouVnRXUmGrulvxJMBL0iz9kQYQ6e+kqB7rAPDjPlloOJ+T
	ciXW0mcL+QuIVnDMWyzObRml3+8U8gqio68fzjt7rHuNDk2HDRsNj1r6MiQuCJsOp+cxCcBkpSs
	GtN4mHTZG6LBk+B6Ftyb+LLWig+6/ZxN26/Nw+TobF50Y8q9/V4gDzOse8o78rLAsx5rt9K4FFT
	vSUJKm3T+X/Hfsuyl9CvE35vIpuHjDmvb6yi5vt6xUMBq5zi3x/wcf//b6OxxAzFvVtYRPKx9qx
	pK/A==
X-Google-Smtp-Source: AGHT+IGGz+0ZRYFb1n72PUuHbm4jaeopA8t8oZcLhnhMb/l55bxw8CvgosAiVdLTKYs5RuO/hb18CaTGhE0u
X-Received: by 2002:a05:6214:e42:b0:787:3a55:93c2 with SMTP id 6a1803df08f44-7fc2c4d0845mr99912196d6.23.1758876687306;
        Fri, 26 Sep 2025 01:51:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-80132c7b665sm2786506d6.7.2025.09.26.01.51.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:51:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117fbda6eso443386b3a.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758876686; x=1759481486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WTwptKJB4wsOQ5ZpYNmlcHWB6JYf0nt/4QKdcm94TA=;
        b=ROYU4YKEtlZjZQf+uI3oVnikjdeZ1XkEKPOpSd0SDOyEjZrDe5bEypwgf3AfDsYsCr
         Ja5AmdTKj26M34YG3oPuMw+HnRwvVUEuT20X79ri0z+yZfxDO9xJnsAE4CETQ0EtZMpR
         ++FeUxKQGzNNStm4YUbvpD3jrku+yRIQFpu2Q=
X-Forwarded-Encrypted: i=1; AJvYcCWQbLcXzpvPLYnfbdCDv9U87uLfNBQo03d02dOIePmHmRHPGmLTgw5Zqf++XxHUZnjBpsCsHN4=@vger.kernel.org
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8684556637.32.1758876685949;
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d95:b0:262:d265:a3c with SMTP id adf61e73a8af0-2e7ceeee4a2mr8684521637.32.1758876685537;
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm3959896b3a.92.2025.09.26.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:51:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/5] bnxt_en: Move common definitions to include/linux/bnxt/
Date: Fri, 26 Sep 2025 01:59:07 -0700
Message-Id: <20250926085911.354947-2-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
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
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/linux/bnxt/ulp.h
similarity index 100%
rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
rename to include/linux/bnxt/ulp.h
-- 
2.39.1


