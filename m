Return-Path: <netdev+bounces-218262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB96B3BB5D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0595586CF7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7731771D;
	Fri, 29 Aug 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NhMqTK5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECB31A057
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470707; cv=none; b=Q2FedbftuaYABHTb2PkaBlB4+xbLFbT1pyuQJiyKMWiomya7N8MUk9a2Vl9euSWomPdAKq+0NKBzsvDqjcVyrcrfS3FTydVZClFpojMsUqfLx4rtaobuPldFrtlmBHvy0XPtKyJSLX0WWlEVO9R37CchjHNCEJyQN30l1w5zA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470707; c=relaxed/simple;
	bh=+tkMoEl2JTWyhdbhKqg7f4fwMDEyddaAjWeI0Osozqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c59887E7UraKg1JP7tiP79hyXLOD1mQn9uZrK4YE57uwLnZdYU0F26rueIajUhQ+FTLi5xVQYH38VPewTDNqs8HCcM4GvdAsuD9LjWGf/Pi7n+MvEJu/sEAHnHKuLra4l3XarMLcibPkNCNDAgECWrq5/jcFwyyhCHIIvfOLvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NhMqTK5c; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so11870995ab.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470705; x=1757075505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9+/a9hcq6wE5bnYT6NSRvJASliFdVnT0YARrBoP9Qw=;
        b=d/CWj2/Mv+mZk5jNc90O9gzwrcw4dJwn6/WSbbA6TbOmAdbhKIH0MnikQlTxBdvmuz
         WFBVX3WxHMEhZRVjavlLRg5yBMuaWEcxsba3fH7+G8S0ADe0DTipYYDY7RMgAsFG7mms
         b7jvrYQSp0Tqas9LjiuaNUqaxhL3qLE4wlKuVPVtoe+1Fwf9T91TZabwGaQjwehiK/HG
         zIvM1ZjiRInkffSABcJbG6oM2MqLOB3ylsl2wh2eSHrUd5br/4N4qum6+lQzst4U8+77
         cHpNzde6iX58NK7DlYw5+jcB2dRMAGR3si7ltnaPlcywfPbQX9Q2I+9OfPRb7EBBjc15
         UNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXooDT1dDf0DRuKI2UU9tijUJGrIpWrL+iYmSMLh1duDvqILgAYayCIMFPlsyLk88xMA3Ck4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGbsCM6fNOT3lpsukxJCNVm6yA3rtncblo9LhaZOP4wRh7Fce
	0/q9fmCEggCPar6IN3kkj5PLU7qIEKdNBC+nEVDQ18LZwBaTl7cqipT5TfDuGb+4CD/RFoDSrwk
	dPhX+/mu9s98LVD+MjwyqFkuF03De6rAs+Nz6VjICGaTPhGFA280tzkadajvKByiYqJaD+Aq4/y
	mFFm5+KvcUdVtpObDYhirXz6HjO92H2dUX7oiw+TZmzoyRc8k+HB+jMSRtY9suw48RxS5C+RRNL
	Kx/iTmLIOm9
X-Gm-Gg: ASbGncvy4HT7YzUbqvXqONyJaZQSbmW7ZG+cZckN8Tf/jfGMkJeCQGlM0xwF4UO4V8P
	w067luybSWNyUVeeiWYyfiA+/beUEjEM52nCjbdWskKmvyQ5c2wDG2bEfsUBPl0E7D7BMyfGNl1
	QYgVqeA9E4GdrqGgKVUO86trS2C0cmEraSwDC966cWZTp8d0xpLeEhdny/exMHOBJrrcgE3ONvR
	Sq+DJaNdlGJcZHFuC451yoD2kA+ZeuERHrDT/qkKBPeXdrmUYmjBkKQDd217z5CUkpqOAG7Eicd
	1yfSgB8qR+6ln/VOftyzolY6sUNG1C4KlgHIwc6GM+g8PqGBgJIHzCCuXXYLGd1Nlq9tk8brg0G
	i9pGVsR4iA+06zlPiWbkxX1KBDSuDi6FWajwLdqiRh9FYjCMGG4R+Y3cu754GOB9pD3aZInTW4w
	==
X-Google-Smtp-Source: AGHT+IEyIqJU66sB3hby+pfKnKr+TEFdRQ6rspAY0cLoaaNGhxbS/TLUno1XkU2nlWeehIqICM7i/4cohO09
X-Received: by 2002:a05:6e02:194d:b0:3f1:dd7:24a7 with SMTP id e9e14a558f8ab-3f10dd7250emr103922275ab.29.1756470663805;
        Fri, 29 Aug 2025 05:31:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d7bff868esm115463173.31.2025.08.29.05.31.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f737071bebso472997285a.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470663; x=1757075463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9+/a9hcq6wE5bnYT6NSRvJASliFdVnT0YARrBoP9Qw=;
        b=NhMqTK5cMwddP4jp49kFRW18s/dqgTukZwuzBgUlMzkdHcHW55+m1iCw22+YUafbAa
         k4EBYigx54j5I6NcU9I+c/8N28mXoKGnOpJ1bls2pCRn+YUYCR7zeCW0WCf0537ozNRl
         HNIv8X8MHZ3unTazuFdKifsjC00PNfmi4tfSw=
X-Forwarded-Encrypted: i=1; AJvYcCViDsDfa1gJfcRLpMaxL7wy6Ezi2VFpk8b5Hddugjg6zLWyY6SOAjGUiB2OfF08c9oXP4rgQkQ=@vger.kernel.org
X-Received: by 2002:a05:620a:2888:b0:7e8:72d3:22ad with SMTP id af79cd13be357-7ea10f72357mr3029250385a.1.1756470662641;
        Fri, 29 Aug 2025 05:31:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2888:b0:7e8:72d3:22ad with SMTP id af79cd13be357-7ea10f72357mr3029246085a.1.1756470661990;
        Fri, 29 Aug 2025 05:31:01 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:01 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH 1/8] bng_en: Add RoCE aux device support
Date: Fri, 29 Aug 2025 12:30:35 +0000
Message-Id: <20250829123042.44459-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Vikas Gupta <vikas.gupta@broadcom.com>

Add an auxiliary (aux) device to support RoCE. The base driver is
responsible for creating the auxiliary device and allocating the
required resources to it, which will be owned by the bnge RoCE
driver in future patches.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +++
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 9 files changed, 426 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 6142d9c57f49..ea6596854e5c 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -9,4 +9,5 @@ bng_en-y := bnge_core.o \
 	    bnge_rmem.o \
 	    bnge_resc.o \
 	    bnge_netdev.o \
-	    bnge_ethtool.o
+	    bnge_ethtool.o \
+	    bnge_auxr.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 6fb3683b6b04..703e25ec37ef 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -11,6 +11,7 @@
 #include <linux/bnxt/hsi.h>
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
+#include "bnge_auxr.h"
 
 #define DRV_VER_MAJ	1
 #define DRV_VER_MIN	15
@@ -22,6 +23,12 @@ enum board_idx {
 	BCM57708,
 };
 
+struct bnge_auxr_priv {
+	struct auxiliary_device aux_dev;
+	struct bnge_auxr_dev *auxr_dev;
+	int id;
+};
+
 struct bnge_pf_info {
 	u16	fw_fid;
 	u16	port_id;
@@ -191,6 +198,9 @@ struct bnge_dev {
 
 	struct bnge_irq		*irq_tbl;
 	u16			irqs_acquired;
+
+	struct bnge_auxr_priv	*aux_priv;
+	struct bnge_auxr_dev	*auxr_dev;
 };
 
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
new file mode 100644
index 000000000000..d64592b64e17
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <asm/byteorder.h>
+#include <linux/bitmap.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnge.h"
+#include "bnge_hwrm.h"
+#include "bnge_auxr.h"
+
+static DEFINE_IDA(bnge_aux_dev_ids);
+
+static void bnge_fill_msix_vecs(struct bnge_dev *bd,
+				struct bnge_msix_info *info)
+{
+	struct bnge_auxr_dev *auxr_dev = bd->auxr_dev;
+	int num_msix, i;
+
+	if (!auxr_dev->auxr_info->msix_requested) {
+		dev_warn(bd->dev, "Requested MSI-X vectors not allocated\n");
+		return;
+	}
+	num_msix = auxr_dev->auxr_info->msix_requested;
+	for (i = 0; i < num_msix; i++) {
+		info[i].vector = bd->irq_tbl[i].vector;
+		info[i].db_offset = bd->db_offset;
+		info[i].ring_idx = i;
+	}
+}
+
+int bnge_register_dev(struct bnge_auxr_dev *auxr_dev,
+		      void *handle)
+{
+	struct bnge_dev *bd = pci_get_drvdata(auxr_dev->pdev);
+	struct bnge_auxr_info *auxr_info;
+	int rc = 0;
+
+	netdev_lock(bd->netdev);
+	mutex_lock(&auxr_dev->auxr_dev_lock);
+	if (!bd->irq_tbl) {
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	if (!bnge_aux_has_enough_resources(bd)) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	auxr_info = auxr_dev->auxr_info;
+	auxr_info->handle = handle;
+
+	auxr_info->msix_requested = bd->aux_num_msix;
+
+	bnge_fill_msix_vecs(bd, bd->auxr_dev->msix_info);
+	auxr_dev->flags |= BNGE_ARDEV_MSIX_ALLOC;
+
+exit:
+	mutex_unlock(&auxr_dev->auxr_dev_lock);
+	netdev_unlock(bd->netdev);
+	return rc;
+}
+EXPORT_SYMBOL(bnge_register_dev);
+
+void bnge_unregister_dev(struct bnge_auxr_dev *auxr_dev)
+{
+	struct bnge_dev *bd = pci_get_drvdata(auxr_dev->pdev);
+	struct bnge_auxr_info *auxr_info;
+
+	auxr_info = auxr_dev->auxr_info;
+	netdev_lock(bd->netdev);
+	mutex_lock(&auxr_dev->auxr_dev_lock);
+	if (auxr_info->msix_requested)
+		auxr_dev->flags &= ~BNGE_ARDEV_MSIX_ALLOC;
+	auxr_info->msix_requested = 0;
+
+	mutex_unlock(&auxr_dev->auxr_dev_lock);
+	netdev_unlock(bd->netdev);
+}
+EXPORT_SYMBOL(bnge_unregister_dev);
+
+int bnge_send_msg(struct bnge_auxr_dev *auxr_dev, struct bnge_fw_msg *fw_msg)
+{
+	struct bnge_dev *bd = pci_get_drvdata(auxr_dev->pdev);
+	struct output *resp;
+	struct input *req;
+	u32 resp_len;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, 0 /* don't care */);
+	if (rc)
+		return rc;
+
+	rc = bnge_hwrm_req_replace(bd, req, fw_msg->msg, fw_msg->msg_len);
+	if (rc)
+		goto drop_req;
+
+	bnge_hwrm_req_timeout(bd, req, fw_msg->timeout);
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	resp_len = le16_to_cpu(resp->resp_len);
+	if (resp_len) {
+		if (fw_msg->resp_max_len < resp_len)
+			resp_len = fw_msg->resp_max_len;
+
+		memcpy(fw_msg->resp, resp, resp_len);
+	}
+drop_req:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+EXPORT_SYMBOL(bnge_send_msg);
+
+void bnge_rdma_aux_device_uninit(struct bnge_dev *bd)
+{
+	struct bnge_auxr_priv *aux_priv;
+	struct auxiliary_device *adev;
+
+	/* Skip if no auxiliary device init was done. */
+	if (!bd->aux_priv)
+		return;
+
+	aux_priv = bd->aux_priv;
+	adev = &aux_priv->aux_dev;
+	auxiliary_device_uninit(adev);
+}
+
+static void bnge_aux_dev_release(struct device *dev)
+{
+	struct bnge_auxr_priv *aux_priv =
+			container_of(dev, struct bnge_auxr_priv, aux_dev.dev);
+	struct bnge_dev *bd = pci_get_drvdata(aux_priv->auxr_dev->pdev);
+
+	ida_free(&bnge_aux_dev_ids, aux_priv->id);
+	kfree(aux_priv->auxr_dev->auxr_info);
+	bd->auxr_dev = NULL;
+	kfree(aux_priv->auxr_dev);
+	kfree(aux_priv);
+	bd->aux_priv = NULL;
+}
+
+void bnge_rdma_aux_device_del(struct bnge_dev *bd)
+{
+	if (!bd->auxr_dev)
+		return;
+
+	auxiliary_device_delete(&bd->aux_priv->aux_dev);
+}
+
+static void bnge_set_auxr_dev_info(struct bnge_auxr_dev *auxr_dev,
+				   struct bnge_dev *bd)
+{
+	auxr_dev->pdev = bd->pdev;
+	auxr_dev->l2_db_size = bd->db_size;
+	auxr_dev->l2_db_size_nc = bd->db_size;
+	auxr_dev->l2_db_offset = bd->db_offset;
+	mutex_init(&auxr_dev->auxr_dev_lock);
+
+	if (bd->flags & BNGE_EN_ROCE_V1)
+		auxr_dev->flags |= BNGE_ARDEV_ROCEV1_SUPP;
+	if (bd->flags & BNGE_EN_ROCE_V2)
+		auxr_dev->flags |= BNGE_ARDEV_ROCEV2_SUPP;
+
+	auxr_dev->chip_num = bd->chip_num;
+	auxr_dev->hw_ring_stats_size = bd->hw_ring_stats_size;
+	auxr_dev->pf_port_id = bd->pf.port_id;
+	auxr_dev->en_state = bd->state;
+	auxr_dev->bar0 = bd->bar0;
+}
+
+void bnge_rdma_aux_device_add(struct bnge_dev *bd)
+{
+	struct auxiliary_device *aux_dev;
+	int rc;
+
+	if (!bd->auxr_dev)
+		return;
+
+	aux_dev = &bd->aux_priv->aux_dev;
+	rc = auxiliary_device_add(aux_dev);
+	if (rc) {
+		dev_warn(bd->dev, "Failed to add auxiliary device for ROCE\n");
+		auxiliary_device_uninit(aux_dev);
+		bd->flags &= ~BNGE_EN_ROCE;
+	}
+
+	bd->auxr_dev->net = bd->netdev;
+}
+
+void bnge_rdma_aux_device_init(struct bnge_dev *bd)
+{
+	struct auxiliary_device *aux_dev;
+	struct bnge_auxr_info *auxr_info;
+	struct bnge_auxr_priv *aux_priv;
+	struct bnge_auxr_dev *auxr_dev;
+	int rc;
+
+	if (!bnge_is_roce_en(bd))
+		return;
+
+	aux_priv = kzalloc(sizeof(*aux_priv), GFP_KERNEL);
+	if (!aux_priv)
+		goto exit;
+
+	aux_priv->id = ida_alloc(&bnge_aux_dev_ids, GFP_KERNEL);
+	if (aux_priv->id < 0) {
+		dev_warn(bd->dev, "ida alloc failed for aux device\n");
+		kfree(aux_priv);
+		goto exit;
+	}
+
+	aux_dev = &aux_priv->aux_dev;
+	aux_dev->id = aux_priv->id;
+	aux_dev->name = "rdma";
+	aux_dev->dev.parent = &bd->pdev->dev;
+	aux_dev->dev.release = bnge_aux_dev_release;
+
+	rc = auxiliary_device_init(aux_dev);
+	if (rc) {
+		ida_free(&bnge_aux_dev_ids, aux_priv->id);
+		kfree(aux_priv);
+		goto exit;
+	}
+	bd->aux_priv = aux_priv;
+
+	auxr_dev = kzalloc(sizeof(*auxr_dev), GFP_KERNEL);
+	if (!auxr_dev)
+		goto aux_dev_uninit;
+
+	aux_priv->auxr_dev = auxr_dev;
+
+	auxr_info = kzalloc(sizeof(*auxr_info), GFP_KERNEL);
+	if (!auxr_info)
+		goto aux_dev_uninit;
+
+	auxr_dev->auxr_info = auxr_info;
+	bd->auxr_dev = auxr_dev;
+	bnge_set_auxr_dev_info(auxr_dev, bd);
+
+	return;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(aux_dev);
+exit:
+	bd->flags &= ~BNGE_EN_ROCE;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
new file mode 100644
index 000000000000..6c5c15ef2b0a
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_AUXR_H_
+#define _BNGE_AUXR_H_
+
+#include <linux/auxiliary_bus.h>
+
+#define BNGE_MIN_ROCE_CP_RINGS	2
+#define BNGE_MIN_ROCE_STAT_CTXS	1
+
+#define BNGE_MAX_ROCE_MSIX	64
+
+struct hwrm_async_event_cmpl;
+struct bnge;
+
+struct bnge_msix_info {
+	u32	vector;
+	u32	ring_idx;
+	u32	db_offset;
+};
+
+struct bnge_fw_msg {
+	void	*msg;
+	int	msg_len;
+	void	*resp;
+	int	resp_max_len;
+	int	timeout;
+};
+
+struct bnge_auxr_info {
+	void		*handle;
+	u16		msix_requested;
+};
+
+enum {
+	BNGE_ARDEV_ROCEV1_SUPP		= BIT(0),
+	BNGE_ARDEV_ROCEV2_SUPP		= BIT(1),
+	BNGE_ARDEV_MSIX_ALLOC		= BIT(2),
+};
+
+#define BNGE_ARDEV_ROCE_SUPP	(BNGE_ARDEV_ROCEV1_SUPP | \
+				 BNGE_ARDEV_ROCEV2_SUPP)
+
+struct bnge_auxr_dev {
+	struct net_device	*net;
+	struct pci_dev		*pdev;
+	void __iomem		*bar0;
+
+	struct bnge_msix_info	msix_info[BNGE_MAX_ROCE_MSIX];
+
+	u32 flags;
+
+	struct bnge_auxr_info	*auxr_info;
+
+	/* Doorbell BAR size in bytes mapped by L2 driver. */
+	int	l2_db_size;
+	/* Doorbell BAR size in bytes mapped as non-cacheable. */
+	int	l2_db_size_nc;
+	/* Doorbell offset in bytes within l2_db_size_nc. */
+	int	l2_db_offset;
+
+	u16		chip_num;
+	u16		hw_ring_stats_size;
+	u16		pf_port_id;
+	unsigned long	en_state;
+
+	u16	auxr_num_msix_vec;
+	u16	auxr_num_ctxs;
+
+	/* serialize auxr operations */
+	struct mutex	auxr_dev_lock;
+};
+
+void bnge_rdma_aux_device_uninit(struct bnge_dev *bdev);
+void bnge_rdma_aux_device_del(struct bnge_dev *bdev);
+void bnge_rdma_aux_device_add(struct bnge_dev *bdev);
+void bnge_rdma_aux_device_init(struct bnge_dev *bdev);
+int bnge_register_dev(struct bnge_auxr_dev *adev,
+		      void *handle);
+void bnge_unregister_dev(struct bnge_auxr_dev *adev);
+int bnge_send_msg(struct bnge_auxr_dev *adev, struct bnge_fw_msg *fw_msg);
+
+#endif /* _BNGE_AUXR_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68da656f2894..8b98112600c3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -41,6 +41,11 @@ static void bnge_print_device_info(struct pci_dev *pdev, enum board_idx idx)
 
 bool bnge_aux_registered(struct bnge_dev *bd)
 {
+	struct bnge_auxr_dev *ba_dev = bd->auxr_dev;
+
+	if (ba_dev && ba_dev->auxr_info->msix_requested)
+		return true;
+
 	return false;
 }
 
@@ -296,16 +301,20 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_config_uninit;
 	}
 
+	bnge_rdma_aux_device_init(bd);
+
 	rc = bnge_alloc_irqs(bd);
 	if (rc) {
 		dev_err(&pdev->dev, "Error IRQ allocation rc = %d\n", rc);
-		goto err_config_uninit;
+		goto err_uninit_auxr;
 	}
 
 	rc = bnge_netdev_alloc(bd, max_irqs);
 	if (rc)
 		goto err_free_irq;
 
+	bnge_rdma_aux_device_add(bd);
+
 	pci_save_state(pdev);
 
 	return 0;
@@ -313,6 +322,9 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_free_irq:
 	bnge_free_irqs(bd);
 
+err_uninit_auxr:
+	bnge_rdma_aux_device_uninit(bd);
+
 err_config_uninit:
 	bnge_net_uninit_dflt_config(bd);
 
@@ -338,10 +350,14 @@ static void bnge_remove_one(struct pci_dev *pdev)
 {
 	struct bnge_dev *bd = pci_get_drvdata(pdev);
 
+	bnge_rdma_aux_device_del(bd);
+
 	bnge_netdev_free(bd);
 
 	bnge_free_irqs(bd);
 
+	bnge_rdma_aux_device_uninit(bd);
+
 	bnge_net_uninit_dflt_config(bd);
 
 	bnge_devlink_unregister(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
index 0f971af24142..c3087e5cd875 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
@@ -98,6 +98,46 @@ void bnge_hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t gfp)
 		ctx->gfp = gfp;
 }
 
+int bnge_hwrm_req_replace(struct bnge_dev *bd, void *req, void *new_req,
+			  u32 len)
+{
+	struct bnge_hwrm_ctx *ctx = __hwrm_ctx_get(bd, req);
+	struct input *internal_req = req;
+	u16 req_type;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (len > BNGE_HWRM_CTX_OFFSET)
+		return -E2BIG;
+
+	/* free any existing slices */
+	ctx->allocated = BNGE_HWRM_DMA_SIZE - BNGE_HWRM_CTX_OFFSET;
+	if (ctx->slice_addr) {
+		dma_free_coherent(bd->dev, ctx->slice_size,
+				  ctx->slice_addr, ctx->slice_handle);
+		ctx->slice_addr = NULL;
+	}
+	ctx->gfp = GFP_KERNEL;
+
+	if ((bd->fw_cap & BNGE_FW_CAP_SHORT_CMD) || len > BNGE_HWRM_MAX_REQ_LEN) {
+		memcpy(internal_req, new_req, len);
+	} else {
+		internal_req->req_type = ((struct input *)new_req)->req_type;
+		ctx->req = new_req;
+	}
+
+	ctx->req_len = len;
+	ctx->req->resp_addr = cpu_to_le64(ctx->dma_handle +
+					  BNGE_HWRM_RESP_OFFSET);
+
+	/* update sentinel for potentially new request type */
+	req_type = le16_to_cpu(internal_req->req_type);
+	ctx->sentinel = bnge_cal_sentinel(ctx, req_type);
+
+	return 0;
+}
+
 void bnge_hwrm_req_flags(struct bnge_dev *bd, void *req,
 			 enum bnge_hwrm_ctx_flags flags)
 {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
index 83794a12cc81..6df629761d95 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
@@ -107,4 +107,6 @@ int bnge_hwrm_req_send_silent(struct bnge_dev *bd, void *req);
 void bnge_hwrm_req_alloc_flags(struct bnge_dev *bd, void *req, gfp_t flags);
 void *bnge_hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
 			      dma_addr_t *dma);
+int bnge_hwrm_req_replace(struct bnge_dev *bd, void *req, void *new_req,
+			  u32 len);
 #endif /* _BNGE_HWRM_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index c79a3607a1b7..719be3d74043 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -34,6 +34,18 @@ static unsigned int bnge_get_max_func_stat_ctxs(struct bnge_dev *bd)
 	return bd->hw_resc.max_stat_ctxs;
 }
 
+bool bnge_aux_has_enough_resources(struct bnge_dev *bd)
+{
+	unsigned int max_stat_ctxs;
+
+	max_stat_ctxs = bnge_get_max_func_stat_ctxs(bd);
+	if (max_stat_ctxs <= BNGE_MIN_ROCE_STAT_CTXS ||
+	    bd->nq_nr_rings == max_stat_ctxs)
+		return false;
+
+	return true;
+}
+
 static unsigned int bnge_get_max_func_cp_rings(struct bnge_dev *bd)
 {
 	return bd->hw_resc.max_cp_rings;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index 54ef1c7d8822..bb9363df3727 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -72,6 +72,7 @@ void bnge_free_irqs(struct bnge_dev *bd);
 int bnge_net_init_dflt_config(struct bnge_dev *bd);
 void bnge_net_uninit_dflt_config(struct bnge_dev *bd);
 void bnge_aux_init_dflt_config(struct bnge_dev *bd);
+bool bnge_aux_has_enough_resources(struct bnge_dev *bd);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.34.1


