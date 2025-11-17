Return-Path: <netdev+bounces-239195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B1C65747
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E68A64EB39D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642931577B;
	Mon, 17 Nov 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bK+2Krm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26730AAC6
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399533; cv=none; b=gRrdH35HBIu22JBxWKx+LaFYwRX2XuwfbER8ZzFElPDqnp7ne4q80G595j0Fsa8R3xI/ZWH/XNWm9TKskou0KVRXHWtxqYCfR/5nyD/Wojqn9CJtesqAcX8lHe3G4GZmH1OzljIxo5mh1nvHqGV9ewScvjCl3LBQScwtir/LtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399533; c=relaxed/simple;
	bh=gSDQak5EM2xNX8KXnpZwXBYga18WpFlF6tAQgL2RVp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH+yB02tDTYhfLgm5GaM/UDQ/1ZSmWTdcXYQ0EhlxX3m2prGfxoswAzyz/Ev6PKG4gmDS32NxZMA7dxMONMCeoCY8yJNRTTfm9VUliPgQ1AZyX9BYp5pYMJadYLzAQ2jib+mfcZhSaHpYFqLY85YLt1J+kFvo9vJBqGROejo9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bK+2Krm2; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3ec47e4c20eso489862fac.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399530; x=1764004330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO/KOoj+ef+xg5h1V086p6nR339skLiWU6R0PmteqkU=;
        b=nvLhKDUNiMqJQcnLFdzUGu/4mqllXIcQtxgsImN5ripdSFf53u6XhsRmY6GxqWgUX2
         lFc9eOm573d0Svs7nFFKuXSxDG9PQ2XfqBdDNcOiL7GQfrKoI3nHAWL56thC5R3Cb+XX
         BLIQkXDzLFX1FYgE5tYRO/n4FUGaeUi0SRxS+qkGi/nlRUXxEeYHpRGf7PsTE4dS0bCc
         a93uZpfrt2QmRXBg10amonwPf/GX+nAux0hxT79NIzSdYJ8aysz39/5M/ulx7i0UW9nG
         J449JE16FInXX6ysbGsqiHeNnJRwsbfVFdcNcjTAPsDIJG9l4Ea7Y6cNE6YSIpMxZAPk
         dyUw==
X-Forwarded-Encrypted: i=1; AJvYcCVlw+Gi4Vbh6BSDmLfHflhYziizhO47/5DEXZ+8+lJ1NAVsAGYm/QdeDIIqD8aVIyOqWrri4pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQh/D2LZASu/gYOJh9P+pFOnoEmxb2Ei4U5AjJzzscBUUkyeF
	AmY9NySSb/r9xINL/2s18xxQugVRvxwmBgZPCPePZ6y3jGiXNSiIETH70aVq4xh7qiXgNo7enkk
	biSVUcRDoeq9yMrs7CHC3rTtA4GcfT0SVc4dpvgn1eXr55mjPt1/Ccacy7qPMOMVkbcOrmvjFRu
	ieRNWxZunMo7QDKmaExraquAjH1cYYgsPhv6opEdHgL54+2XB7tHFezTKPKwXlB+izgEYhSPfeL
	sV/Z6vBMp91
X-Gm-Gg: ASbGncs5bpcjVVfxPbYBUpHsi3Nhf3z97TCumCsnatDMB3SuwpoNCOkvyoil7Ntgavr
	GAZOvWy61A1Mhj4CL1zCAA0vLqf/rAhlRxpkb2sNCCHc+0NZRakXFw+GiyIvgTnPBdPJhdN0Hxp
	Oj+SAcRas1GTUo7GFQebd5shwSbzGY9rjwfW2PFIJlGcy6PUfROT4mlWeQGMex1is5ibn36Yxrc
	+P7sjnPSu9niVC/L+kIBzki3HiooxkvskAA4LOAJBSOfx7KXEpKWlRKQ8typbK6uhlJListzN8W
	EinUIK3k5YNG1WGcF4Es55pmoT3M2mCQeM1oiXt+NKiiWVZX4czWmD+AZhdJyG8uZ9l2ijIj/yu
	X2eOg0zwbF8Cr1jWw5y4LEW1mAUmCg+T72kANlUShy+I9YVP0mGEJTQPtdFSZ7UkHkccYnukTp6
	7N8domi1ipGMfhtiydu4VUqNnSNQO2305H
X-Google-Smtp-Source: AGHT+IEMX+1tA9A+CVH9Yq3DfzEB183K4kzQ+RtFb6vf9ig+AjEKQ4qkcC5/nVYcQChdK4j0XBLSVVTPmBnP
X-Received: by 2002:a05:6871:33aa:b0:3d1:d26e:e163 with SMTP id 586e51a60fabf-3e868e0856emr6488962fac.3.1763399529746;
        Mon, 17 Nov 2025 09:12:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3e852060794sm1232623fac.9.2025.11.17.09.12.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso145452491cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399529; x=1764004329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO/KOoj+ef+xg5h1V086p6nR339skLiWU6R0PmteqkU=;
        b=bK+2Krm24Tlukf/aCNm968DJBEM/gEFLi2dRULRzCdUE55Mrljk8MKFjZucfvRTEoI
         dnxr0oF8yygbbsC6qUNw8D4o2oBIOJCc7JnyPcdtXFsr5wM9WOGennfPqWZY3LHADNJZ
         ZkxGDlJGMCVJUmD1AYsyAUGaVRjRaKWIlX5rM=
X-Forwarded-Encrypted: i=1; AJvYcCVGgjfOYfpsWS9OnV2dem94obbRctbUaQDk46dmDuHxIZzz/W6Pp1b+/50Ndk9R4CdTcZ/hidE=@vger.kernel.org
X-Received: by 2002:a05:622a:1a9a:b0:4eb:e287:3a7e with SMTP id d75a77b69052e-4edf2130d83mr190841061cf.50.1763399528712;
        Mon, 17 Nov 2025 09:12:08 -0800 (PST)
X-Received: by 2002:a05:622a:1a9a:b0:4eb:e287:3a7e with SMTP id d75a77b69052e-4edf2130d83mr190840411cf.50.1763399528172;
        Mon, 17 Nov 2025 09:12:08 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:07 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v3 1/8] bng_en: Add RoCE aux device support
Date: Mon, 17 Nov 2025 17:11:19 +0000
Message-ID: <20251117171136.128193-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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
index 7aed5f81cd51..411744894349 100644
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
@@ -197,6 +204,9 @@ struct bnge_dev {
 
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
index 2c72dd34d50d..c94e132bebc8 100644
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
 
@@ -312,16 +317,20 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	spin_lock_init(&bd->db_lock);
 #endif
 
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
@@ -329,6 +338,9 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_free_irq:
 	bnge_free_irqs(bd);
 
+err_uninit_auxr:
+	bnge_rdma_aux_device_uninit(bd);
+
 err_config_uninit:
 	bnge_net_uninit_dflt_config(bd);
 
@@ -354,10 +366,14 @@ static void bnge_remove_one(struct pci_dev *pdev)
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
index 62ebe03a0dcf..943df5f60f01 100644
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
index 0d6213b27580..b62a634669f6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -74,6 +74,7 @@ void bnge_net_uninit_dflt_config(struct bnge_dev *bd);
 void bnge_aux_init_dflt_config(struct bnge_dev *bd);
 u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd);
 int bnge_cal_nr_rss_ctxs(u16 rx_rings);
+bool bnge_aux_has_enough_resources(struct bnge_dev *bd);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.43.0


