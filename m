Return-Path: <netdev+bounces-206796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD8B0460B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3621A615D2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3A7262D;
	Mon, 14 Jul 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z1MOXxGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546E18E3F
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512532; cv=none; b=I2L9j6053GJj1g5/Dhle8Aho9q0rG3b6/HI2QYaf47aIJnf3lJx43kBPek/3D9BGJ/SgfpvcpRtxs+em66KosNQpDGtX9eqKe55mI4hQyfyY69ybLJG4uCkmx2UrcZBpmIr/LGt/RR6rzYDzlH2fSF9jRnbl+xzQawsD+hkNAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512532; c=relaxed/simple;
	bh=1auG+TU5cboTfyGVYoIeAniVR+gXLouO0rmStfR+ing=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IeR4cIWtsIsR4CMsLI1xpVemXFt2jkNjZbqNPDM4EMbHwXJ5+zAcoyvt5yHHi5hdsJr96Gmx3JYmFMtoA9yMKv1XpUmVRvi/XauEOiFYI9tAc4V3eOazKwzZ9yJYJ9eY6h2pG4K08jgPNbV85XaXuo9WzR+4MlR1hIuHrm61ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z1MOXxGo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236192f8770so30660115ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752512529; x=1753117329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj/aqV2+o0f8WVyXHFTHhoUS1neovB0UuTBp4DTae2k=;
        b=Z1MOXxGopuHWQUsXTsUdeWf58qazSpr1HAl7jBsR3E760bxAOJ1gbmcOMmgKCTMQNz
         jJgiLOybDe9ijBWnAM+8MZyQyz4lhnha/bfx1/0Xos7+fYAX4h4SmocbSFNQci30rlx9
         k7BwP29qjMdP6shQbYqrt2SkYKB4/4cIX+pe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512529; x=1753117329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj/aqV2+o0f8WVyXHFTHhoUS1neovB0UuTBp4DTae2k=;
        b=IbEGhEnbwVUtbbElsFSEQBabK+v5WbMPGyC2oU5SIf0/OONdemAurBo4o0mWGDVG0b
         QGPfllB596Rnof/lmu2oTl/tHp//AtIB0CqyPMzXtoRU0Qjj9s6ytQBqyRQ82iaO8ekW
         RWBgHgGipRDClf7FiQlfkWykm8HNT4Z+wIYiuKUg8lQ0q4ENBIH1nhwq8TUOQhPX1Cd2
         qdCyCGlc50uXLNIYMt7uhYBDFSAQydrZ84fPgOYUYpfU8gh7amhqmlqx3h5ehmATPAPs
         NOmZSvyLLxxFW/VHYl/KCZZiVGV0dUYLR5FMrYNGIbpJQLgGcUn5KxmxPqYd8GmLxbjC
         V9pw==
X-Gm-Message-State: AOJu0YwyCWHhLKUio14UJXSPewC5i/E6CVIV+x091jiOgDcZSTVaxW7v
	pfUb3Zs0LfWPqQhs6q80kavCxrrqgaBSOf9A93E9yqEMlfr/2QkzZbxm2XjINX/hLo5tCZ2DB/V
	yBS93/Xt1vMq2H9nLAZePhA70fkgKYbTeTy0cYFHSPf7iVUr7dn8gvDa13MdCPOigQtgTMgsTv5
	KxHEkJC9UT3kjKOkZkrVKh4vN7L78seq0jJHbPOLmwSW/KXapNvpobkw==
X-Gm-Gg: ASbGnctKsZY2htydXujI5ZWm5yiQUKk3OYcNIbb4433lXuhvyXy4nv6WCjWZzzy6uvk
	QyjPDSaCXaDf04Nw78DYPoTp/7WMAAGPxW8wbeD6UoNu+g/YVz4juy07KL6jgkaXykwO5ruTSx6
	NFHsi29+PfU1UpPOnzW0aXkOP23aVaSN9n5yErZV6dBEm7pCN+1sov3b7lhmswE+ThFvjMYEpw+
	zCbyrU33isO17Lf9QDsQs0JuBDyrwmSeLVbX7vZPyCqH1iTr109BNKCsxseK1ghcQs8OSrytJm6
	NacymS+b6WOeqxqjXDYFfn5z1BKeEmXeerld8lUcqLmwjFAa/nfAH1063OctJfUj93E09QDl16P
	xOJ+laCegoN2GsO5IE63kGfEb5aPT17Rq2n7K1w+NWVgQxj5Lbv/IK/E57T5ADHMoUk1ByrrMg6
	h6AQ==
X-Google-Smtp-Source: AGHT+IGYJtG3QTX9oZnfJEMsiOgiU16uxsyIkFypNGM1WTFRgWlN1cxSXZ7qGW+c8TVjOIGB6PvCBQ==
X-Received: by 2002:a17:903:124f:b0:233:fd7b:5e0d with SMTP id d9443c01a7336-23e1a42f6f0mr5283455ad.5.1752512528807;
        Mon, 14 Jul 2025 10:02:08 -0700 (PDT)
Received: from JRM7P7Q02P.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323cd5sm95376135ad.126.2025.07.14.10.02.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 10:02:08 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
To: netdev@vger.kernel.org
Cc: vikas.gupta@broadcom.com,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next] bnxt: move bnxt_hsi.h to include/linux/bnxt/hsi.h
Date: Mon, 14 Jul 2025 13:02:02 -0400
Message-Id: <20250714170202.39688-1-gospo@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves bnxt_hsi.h contents to a common location so it can be
properly referenced by bnxt_en, bnxt_re, and bnge.

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/roce_hsi.h                      | 4 ++--
 drivers/net/ethernet/broadcom/bnge/bnge.h                     | 2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h                | 2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c            | 2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h              | 2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c                | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                     | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c            | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c             | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h             | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c             | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c             | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c                | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h                | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c               | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                  | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c                 | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                 | 2 +-
 .../broadcom/bnxt/bnxt_hsi.h => include/linux/bnxt/hsi.h      | 0
 24 files changed, 24 insertions(+), 24 deletions(-)
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h => include/linux/bnxt/hsi.h (100%)

diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 7eceb3e9f4ce..024845f945ff 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -39,8 +39,8 @@
 #ifndef __BNXT_RE_HSI_H__
 #define __BNXT_RE_HSI_H__
 
-/* include bnxt_hsi.h from bnxt_en driver */
-#include "bnxt_hsi.h"
+/* include linux/bnxt/hsi.h */
+#include <linux/bnxt/hsi.h>
 
 /* tx_doorbell (size:32b/4B) */
 struct tx_doorbell {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index a1795302c15a..6fb3683b6b04 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -8,7 +8,7 @@
 #define DRV_SUMMARY	"Broadcom 800G Ethernet Linux Driver"
 
 #include <linux/etherdevice.h>
-#include "../bnxt/bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
index 012aa4fa5aa9..83794a12cc81 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -4,7 +4,7 @@
 #ifndef _BNGE_HWRM_H_
 #define _BNGE_HWRM_H_
 
-#include "../bnxt/bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 
 enum bnge_hwrm_ctx_flags {
 	BNGE_HWRM_INTERNAL_CTX_OWNED	= BIT(0),
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 19091318cfdd..5c178fade065 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -5,9 +5,9 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/bnxt/hsi.h>
 
 #include "bnge.h"
-#include "../bnxt/bnxt_hsi.h"
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 96b77e44b552..a650d71a58db 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -4,7 +4,7 @@
 #ifndef _BNGE_NETDEV_H_
 #define _BNGE_NETDEV_H_
 
-#include "../bnxt/bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 0e935cc46da6..52ada65943a0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -9,9 +9,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/bnxt/hsi.h>
 
 #include "bnge.h"
-#include "../bnxt/bnxt_hsi.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6bbe875132b0..de8080df69a8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -58,8 +58,8 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <linux/pci-tph.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 67e70d3d0980..18d6c94d5cb8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_coredump.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 71e14be2507e..a00b67334f9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
 #include <rdma/ib_verbs.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_dcb.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 127b7015f676..3324afbb3bec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -10,7 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include <linux/dim.h>
 #include "bnxt.h"
 #include "bnxt_debugfs.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h
index d0bb4887acd0..a0a8d687dd99 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.h
@@ -7,7 +7,7 @@
  * the Free Software Foundation.
  */
 
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 777880594a04..4c4581b0342e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -12,7 +12,7 @@
 #include <linux/vmalloc.h>
 #include <net/devlink.h>
 #include <net/netdev_lock.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_vfr.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
index 6f6576dc417a..53a3bcb0efe0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/dim.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 
 void bnxt_dim_work(struct work_struct *work)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4c10373abffd..1b37612b1c01 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -26,7 +26,7 @@
 #include <linux/timecounter.h>
 #include <net/netdev_queues.h>
 #include <net/netlink.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
index 669d24ba0e87..de3427c6c6aa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
@@ -12,8 +12,8 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/pci.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_hwmon.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index d2fd2d04ed47..5ce190f50120 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -20,8 +20,8 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
index fb5f5b063c3d..791b3a0cdb83 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
@@ -10,7 +10,7 @@
 #ifndef BNXT_HWRM_H
 #define BNXT_HWRM_H
 
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 
 enum bnxt_hwrm_ctx_flags {
 	/* Update the HWRM_API_FLAGS right below for any new non-internal bit added here */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 0669d43472f5..471b1393ce6c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -15,7 +15,7 @@
 #include <linux/timekeeping.h>
 #include <linux/ptp_classify.h>
 #include <linux/clocksource.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ptp.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index bc0d80356568..ec14b51ba38e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -16,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/etherdevice.h>
 #include <net/dcbnl.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 0599d3016224..d72fd248f3aa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -19,8 +19,8 @@
 #include <net/tc_act/tc_pedit.h>
 #include <net/tc_act/tc_tunnel_key.h>
 #include <net/vxlan.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_sriov.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 2450a369b792..61cf201bb0dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -21,8 +21,8 @@
 #include <linux/bitmap.h>
 #include <linux/auxiliary_bus.h>
 #include <net/netdev_lock.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 619f0844e778..bd116fd578d8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -12,8 +12,8 @@
 #include <linux/rtnetlink.h>
 #include <linux/jhash.h>
 #include <net/pkt_cls.h>
+#include <linux/bnxt/hsi.h>
 
-#include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_vfr.h"
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 09e7e8efa6fa..58d579dca3f1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -17,7 +17,7 @@
 #include <linux/filter.h>
 #include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
-#include "bnxt_hsi.h"
+#include <linux/bnxt/hsi.h>
 #include "bnxt.h"
 #include "bnxt_xdp.h"
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/include/linux/bnxt/hsi.h
similarity index 100%
rename from drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
rename to include/linux/bnxt/hsi.h
-- 
2.31.1


