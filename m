Return-Path: <netdev+bounces-225165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6AB8FAC7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C44318A1803
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDB26E715;
	Mon, 22 Sep 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SmkiQXda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA0271443
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531690; cv=none; b=lDFpkyhes6j5L0ayBapDt3sktAbWf8jxCn0ngIH1fTzTRo+g6Dn/ml8Pd8hTOi9iTNf6BIkvoMr/Pu66jvbfTHwyeLxlorAjTXg4NuiKaoMWrUcVSDaDTO3tqzirdLm+XONEw3AQySXMbQnY9fDLh083KmRLMXKSg9udbsoO+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531690; c=relaxed/simple;
	bh=Qy8hYffP3sPiIpsuUpUG1Z3+dVX26Kd+av/R9Ub7Ruc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGwXpMTH3oqU8zjfSwiH1uOx4dr6ymzLiPUhiFQbs1IDTxyP+AAGfLzvh+gVB5U/S1KvQEM1daasnjYqtDAG/PeL9JzwXYAN0DjSPnwPjq3upX3q7zps0xDZRNCQ9NCXdS9VeaqK7z+Qga0gsHQ36eJpkoxVsgIMmR6PdPfSrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SmkiQXda; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-26e68904f0eso20166915ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531688; x=1759136488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYf3FocDtOVLVHe6E+jTO0pX05QZI2dTdjoc/EqrX18=;
        b=ODjnXq/WB70arlpuQN+GT6f1P+GJUepjhlpOnbD3Ij1isI6r7CAIYvj4G5OQ7sjvld
         8CnPF4wgnNQpjq9ChUGusrwgjmgHO9Ih0UYEJklonmpxhs61uvNOikc2YT3gqpm77Dbo
         MClzQ5NWxUNrEFncurW0lZLHKlO+kYsdJBRa+VfCG7Q5F7PAkllx7uKSlafVhUr1Q+pc
         Prs2pib8uNzTD5aupEXUnDpBQLP1kJEb/qHiRJS/wcU2JWVTRZcqVklPC9JYDZGsXxHa
         QTNf/XX43Hfe0mB32nZ5zoB6msp5CDDt5yUOJwE/aqNV8wg7Bh7STXJEE9aJJvVIwl2G
         ogTA==
X-Forwarded-Encrypted: i=1; AJvYcCXEI1km4uNW/Bp4X8J0DBPYYLDYn+xf9RQGFIIQ8M8DGv7jWOTmkDD1pnx7a3Nc9DsDQfHOeyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQyws821lgfpYzw78Dw4Cfw8m3WTm+8UaPtvNvM6EFLtNio+D
	6z56PLqzqPh4xCybRO2avaWlPwKRJEcRRIsP/+cRIR7+Q50d4Z/YqRDpYvaBiXijvPSE9V/W+Jt
	IR3HnwOjmYF3HyTN/JeNU1rG+FrJhTtnoxt3NFL9hTAZ7EN6D6aCsfsxC400njQIN57+5f5uMlh
	21d0OkTmmVtwP8VmcWksCXFqYSDCx+Ywmgs/KYrJoodeYVMNvoRG/DbCVpU5bAwwLckZ1jAuAtR
	lpik05NX6Q=
X-Gm-Gg: ASbGnctuwsO7xO7G03nLmhC8SkQigOEujrStp3U6B+GRYcAy0iDys+XbiVX5SHVRiAA
	cg1oj7Vg3J9nSESiBNpokZZBDxEX8QhV5QWB068lk3wkLoor4LTuXxo/H0vCpRGTTZ1NRggHV8C
	hiPgHs8WF/KvOBEkReA7p88F1txJ5Qjsi+nZwnMlLNMkIs+9ZimAgf+Lp4Z1nJRRbqxcqR54Dti
	qy8eTAZl+1OBetj2gzHPPz25mZ8pTkJQa71ueGN3F90nKhSIYJmHd7OdjUztM6Z1c7zuFhJSkVr
	thYHYWMf93tab718TODZnMA4S1Bm4wyMJd1r8eVr6KA6xoYQ5aFTxzOpS7KEPWuglGCLceE3dee
	ewRAS8TDuPmCPd7V1gzbRJ3oTI1J0RQQTiBDXLDlpH7bDpVEDPSp+mb1k63830gT/aX0uwEIkzE
	CLOQ==
X-Google-Smtp-Source: AGHT+IFExsAUnISWJTm0+z3bowXozNa589Iy7PlqOU7BkoDSN2CqcgWs7KfPtiRPKOUTFkLmtUXFzgA+DrHY
X-Received: by 2002:a17:903:120b:b0:265:47:a7b0 with SMTP id d9443c01a7336-269ba3f7155mr128318835ad.10.1758531687676;
        Mon, 22 Sep 2025 02:01:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2698016d0cdsm7337245ad.29.2025.09.22.02.01.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:01:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2681623f927so40886475ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531686; x=1759136486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYf3FocDtOVLVHe6E+jTO0pX05QZI2dTdjoc/EqrX18=;
        b=SmkiQXdaRkHa97BCH5oFdHZB7VIMZAbNUbTWZCOaxA2ZX2okftwzPY6qzBtGZ5z+aX
         kHCt4zekUM38fPbnizIzvDxNCuODVuV/95w5b57tsmE8vlOURc/kLdsarU7KE3pRwYu0
         bajqnYpnaA0WB9tYCtYNZDY+anQSdvWdrezfQ=
X-Forwarded-Encrypted: i=1; AJvYcCVC3g6u7HOawFZW6Ni3sHvN6AdzS7gE7w6Qs5hC9yPsWTaHDQ/fe2QF64iW0m0gqJV0SV6vZBY=@vger.kernel.org
X-Received: by 2002:a17:902:e94c:b0:269:8edf:67f8 with SMTP id d9443c01a7336-269ba585077mr171746445ad.52.1758531685657;
        Mon, 22 Sep 2025 02:01:25 -0700 (PDT)
X-Received: by 2002:a17:902:e94c:b0:269:8edf:67f8 with SMTP id d9443c01a7336-269ba585077mr171746015ad.52.1758531685174;
        Mon, 22 Sep 2025 02:01:25 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:01:24 -0700 (PDT)
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
Subject: [PATCH net-next 5/6] bnxt_fwctl: Add bnxt fwctl device
Date: Mon, 22 Sep 2025 02:08:50 -0700
Message-Id: <20250922090851.719913-6-pavan.chebbi@broadcom.com>
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

Create bnxt_fwctl device. This will bind to bnxt's aux device.
On the upper edge, it will register with the fwctl subsystem.
It will make use of bnxt's ULP functions to send FW commands.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 MAINTAINERS                 |   6 +
 drivers/fwctl/Kconfig       |  11 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/bnxt/Makefile |   4 +
 drivers/fwctl/bnxt/main.c   | 297 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/bnxt.h   |  63 ++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 7 files changed, 383 insertions(+)
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 create mode 100644 include/uapi/fwctl/bnxt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a8a770714101..8954da3e9203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10115,6 +10115,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/pds/
 
+FWCTL BNXT DRIVER
+M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/bnxt/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index b5583b12a011..203b6ebb06fc 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -29,5 +29,16 @@ config FWCTL_PDS
 	  to access the debug and configuration information of the AMD/Pensando
 	  DSC hardware family.
 
+	  If you don't know what to do here, say N.
+
+config FWCTL_BNXT
+	tristate "bnxt control fwctl driver"
+	depends on BNXT
+	help
+	  BNXT provides interface for the user process to access the debug and
+	  configuration registers of the Broadcom NIC hardware family
+	  This will allow configuration and debug tools to work out of the box on
+	  mainstream kernel.
+
 	  If you don't know what to do here, say N.
 endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index c093b5f661d6..fdd46f3a0e4e 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
 obj-$(CONFIG_FWCTL_PDS) += pds/
+obj-$(CONFIG_FWCTL_BNXT) += bnxt/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/bnxt/Makefile b/drivers/fwctl/bnxt/Makefile
new file mode 100644
index 000000000000..b47172761f1e
--- /dev/null
+++ b/drivers/fwctl/bnxt/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_BNXT) += bnxt_fwctl.o
+
+bnxt_fwctl-y += main.o
diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
new file mode 100644
index 000000000000..b23245029a3d
--- /dev/null
+++ b/drivers/fwctl/bnxt/main.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Broadcom Corporation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/fwctl.h>
+#include <uapi/fwctl/fwctl.h>
+#include <uapi/fwctl/bnxt.h>
+#include <linux/bnxt/common.h>
+#include <linux/bnxt/ulp.h>
+
+struct bnxtctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+};
+
+struct bnxtctl_dev {
+	struct fwctl_device fwctl;
+	struct bnxt_aux_priv *aux_priv;
+	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
+	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
+};
+
+DEFINE_FREE(bnxtctl, struct bnxtctl_dev *, if (_T) fwctl_put(&_T->fwctl))
+
+static int bnxtctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct bnxtctl_uctx *bnxtctl_uctx =
+		container_of(uctx, struct bnxtctl_uctx, uctx);
+
+	bnxtctl_uctx->uctx_caps = BIT(FWCTL_BNXT_QUERY_COMMANDS) |
+				  BIT(FWCTL_BNXT_SEND_COMMAND);
+	return 0;
+}
+
+static void bnxtctl_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *bnxtctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct bnxtctl_uctx *bnxtctl_uctx =
+		container_of(uctx, struct bnxtctl_uctx, uctx);
+	struct fwctl_info_bnxt *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = bnxtctl_uctx->uctx_caps;
+
+	*length = sizeof(*info);
+	return info;
+}
+
+static bool bnxtctl_validate_rpc(struct bnxt_en_dev *edev,
+				 struct bnxt_fw_msg *hwrm_in)
+{
+	struct input *req = (struct input *)hwrm_in->msg;
+
+	mutex_lock(&edev->en_dev_lock);
+	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED) {
+		mutex_unlock(&edev->en_dev_lock);
+		return false;
+	}
+	mutex_unlock(&edev->en_dev_lock);
+
+	if (req->req_type <= HWRM_LAST)
+		return true;
+
+	return false;
+}
+
+static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
+				   struct device *dev,
+				   int num_dma,
+				   struct fwctl_dma_info_bnxt *msg,
+				   struct bnxt_fw_msg *fw_msg)
+{
+	u8 i, num_allocated = 0;
+	void *dma_ptr;
+	int rc = 0;
+
+	for (i = 0; i < num_dma; i++) {
+		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
+			rc = -EINVAL;
+			goto err;
+		}
+		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
+								msg->len,
+								&bnxt_dev->dma_addr[i],
+								GFP_KERNEL);
+		if (!bnxt_dev->dma_virt_addr[i]) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		num_allocated++;
+		if (!(msg->read_from_device)) {
+			if (copy_from_user(bnxt_dev->dma_virt_addr[i],
+					   u64_to_user_ptr(msg->data),
+					   msg->len)) {
+				rc = -EFAULT;
+				goto err;
+			}
+		}
+		dma_ptr = fw_msg->msg + msg->offset;
+
+		if ((PTR_ALIGN(dma_ptr, 8) == dma_ptr) &&
+		    msg->offset < fw_msg->msg_len) {
+			__le64 *dmap = dma_ptr;
+
+			*dmap = cpu_to_le64(bnxt_dev->dma_addr[i]);
+		} else {
+			rc = -EINVAL;
+			goto err;
+		}
+		msg += 1;
+	}
+
+	return rc;
+err:
+	for (i = 0; i < num_allocated; i++)
+		dma_free_coherent(dev->parent,
+				  msg->len,
+				  bnxt_dev->dma_virt_addr[i],
+				  bnxt_dev->dma_addr[i]);
+
+	return rc;
+}
+
+static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
+			    enum fwctl_rpc_scope scope,
+			    void *in, size_t in_len, size_t *out_len)
+{
+	struct bnxtctl_dev *bnxtctl =
+		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
+	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
+	struct fwctl_dma_info_bnxt *dma_buf = NULL;
+	struct device *dev = &uctx->fwctl->dev;
+	struct fwctl_rpc_bnxt *msg = in;
+	struct bnxt_fw_msg rpc_in;
+	int i, rc, err = 0;
+	int dma_buf_size;
+
+	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
+	if (!rpc_in.msg) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
+			   msg->req_len)) {
+		dev_dbg(dev, "Failed to copy in_payload from user\n");
+		err = -EFAULT;
+		goto err_out;
+	}
+
+	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in))
+		return ERR_PTR(-EPERM);
+
+	rpc_in.msg_len = msg->req_len;
+	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
+	if (!rpc_in.resp) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	rpc_in.resp_max_len = *out_len;
+	if (!msg->timeout)
+		rpc_in.timeout = DFLT_HWRM_CMD_TIMEOUT;
+	else
+		rpc_in.timeout = msg->timeout;
+
+	if (msg->num_dma) {
+		if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
+			dev_err(dev, "DMA buffers exceed the number supported\n");
+			err = -EINVAL;
+			goto err_out;
+		}
+		dma_buf_size = msg->num_dma * sizeof(*dma_buf);
+		dma_buf = kzalloc(dma_buf_size, GFP_KERNEL);
+		if (!dma_buf) {
+			dev_err(dev, "Failed to allocate dma buffers\n");
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
+				   dma_buf_size)) {
+			dev_dbg(dev, "Failed to copy payload from user\n");
+			err = -EFAULT;
+			goto err_out;
+		}
+
+		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
+					     dma_buf, &rpc_in);
+		if (rc) {
+			err = -EIO;
+			goto err_out;
+		}
+	}
+
+	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
+	if (rc) {
+		err = -EIO;
+		goto err_out;
+	}
+
+	for (i = 0; i < msg->num_dma; i++) {
+		if (dma_buf[i].read_from_device) {
+			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
+					 bnxtctl->dma_virt_addr[i],
+					 dma_buf[i].len)) {
+				dev_dbg(dev, "Failed to copy resp to user\n");
+				err = -EFAULT;
+			}
+		}
+	}
+	for (i = 0; i < msg->num_dma; i++)
+		dma_free_coherent(dev->parent, dma_buf[i].len,
+				  bnxtctl->dma_virt_addr[i],
+				  bnxtctl->dma_addr[i]);
+
+err_out:
+	kfree(dma_buf);
+	kfree(rpc_in.msg);
+
+	if (err)
+		return ERR_PTR(err);
+
+	return rpc_in.resp;
+}
+
+static const struct fwctl_ops bnxtctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_BNXT,
+	.uctx_size = sizeof(struct bnxtctl_uctx),
+	.open_uctx = bnxtctl_open_uctx,
+	.close_uctx = bnxtctl_close_uctx,
+	.info = bnxtctl_info,
+	.fw_rpc = bnxtctl_fw_rpc,
+};
+
+static int bnxtctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+{
+	struct bnxt_aux_priv *aux_priv =
+		container_of(adev, struct bnxt_aux_priv, aux_dev);
+	struct bnxtctl_dev *bnxtctl __free(bnxtctl) =
+		fwctl_alloc_device(&aux_priv->edev->pdev->dev, &bnxtctl_ops,
+				   struct bnxtctl_dev, fwctl);
+	int rc;
+
+	if (!bnxtctl)
+		return -ENOMEM;
+
+	bnxtctl->aux_priv = aux_priv;
+
+	rc = fwctl_register(&bnxtctl->fwctl);
+	if (rc)
+		return rc;
+
+	auxiliary_set_drvdata(adev, no_free_ptr(bnxtctl));
+	return 0;
+}
+
+static void bnxtctl_remove(struct auxiliary_device *adev)
+{
+	struct bnxtctl_dev *ctldev = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&ctldev->fwctl);
+	fwctl_put(&ctldev->fwctl);
+}
+
+static const struct auxiliary_device_id bnxtctl_id_table[] = {
+	{ .name = "bnxt_en.fwctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, bnxtctl_id_table);
+
+static struct auxiliary_driver bnxtctl_driver = {
+	.name = "bnxt_fwctl",
+	.probe = bnxtctl_probe,
+	.remove = bnxtctl_remove,
+	.id_table = bnxtctl_id_table,
+};
+
+module_auxiliary_driver(bnxtctl_driver);
+
+MODULE_IMPORT_NS("FWCTL");
+MODULE_DESCRIPTION("BNXT fwctl driver");
+MODULE_AUTHOR("Pavan Chebbi <pavan.chebbi@broadcom.com>");
+MODULE_AUTHOR("Andy Gospodarek <gospo@broadcom.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/fwctl/bnxt.h b/include/uapi/fwctl/bnxt.h
new file mode 100644
index 000000000000..212499826b02
--- /dev/null
+++ b/include/uapi/fwctl/bnxt.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2025, Broadcom Corporation
+ *
+ */
+
+#ifndef _UAPI_FWCTL_BNXT_H_
+#define _UAPI_FWCTL_BNXT_H_
+
+#include <linux/types.h>
+
+#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
+#define DFLT_HWRM_CMD_TIMEOUT		500
+
+enum fwctl_bnxt_commands {
+	FWCTL_BNXT_QUERY_COMMANDS = 0,
+	FWCTL_BNXT_SEND_COMMAND,
+};
+
+/**
+ * struct fwctl_info_bnxt - ioctl(FWCTL_INFO) out_device_data
+ * @uctx_caps: The command capabilities driver accepts.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_bnxt {
+	__u32 uctx_caps;
+	__u32 reserved;
+};
+
+#define MAX_NUM_DMA_INDICATIONS 10
+
+/**
+ * struct fwctl_dma_info_bnxt - describe the buffer that should be DMAed
+ * @data: DMA-intended buffer
+ * @len: length of the @data
+ * @offset: offset at which FW (HWRM) input structure needs DMA address
+ * @read_from_device: DMA direction, 0 or 1
+ */
+struct fwctl_dma_info_bnxt {
+	__aligned_u64 data;
+	__u32 len;
+	__u16 offset;
+	__u8 read_from_device;
+	__u8 unused;
+};
+
+/**
+ * struct fwctl_rpc_bnxt - describe the fwctl message for bnxt
+ * @req: FW (HWRM) command input structure
+ * @req_len: length of @req
+ * @timeout: if the user wants to override the driver's default, 0 otherwise
+ * @num_dma: number of DMA buffers to be added to @req
+ * @payload: DMA buffer details in struct fwctl_dma_info_bnxt format
+ */
+struct fwctl_rpc_bnxt {
+	__aligned_u64 req;
+	__u32 req_len;
+	__u32 timeout;
+	__u32 num_dma;
+	__aligned_u64 payload;
+};
+#endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 716ac0eee42d..2d6d4049c205 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -44,6 +44,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_CXL = 2,
+	FWCTL_DEVICE_TYPE_BNXT = 3,
 	FWCTL_DEVICE_TYPE_PDS = 4,
 };
 
-- 
2.39.1


