Return-Path: <netdev+bounces-229090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8101BD8165
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1EC54FAB21
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB830F924;
	Tue, 14 Oct 2025 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U52d6M8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480B212572
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429070; cv=none; b=kFwVWJNSdgDOy78WXr6CBBboLeyGU7nM7nQXDm+co901g8YEj88nXgcRMkSsQsaGdqahWWl3dUu/ogKCYP6t5Ducq9/M4HptZYGoEbHT0pi9/T7dFF/NSt1WaKCrbLq0hlz05GwGlMdbAAVxMBpY5bhA1q79VM1iF+d6GuVZNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429070; c=relaxed/simple;
	bh=yCBr8xBM9FKuFFzDxR/r1+cBUlh6j/SvhokvzPJ6Hac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3rmhmQsi9jQFoX4bIXQosaPHnaGgLAtsXd1Dc2UWlkveDwJBZ4t3rQcRN4ucIOGVPw6GTgy5bBVMExFZ/Hw61DFC8Vj90CuwkPAXZVaf10EYetw7k46cW8VD3FOvfOULGXb8M68C6NIAKXNS+n3mtuHXJxfBX+ClL/jz24t+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U52d6M8j; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-36c9859b036so3153675fac.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429067; x=1761033867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sAVBIZzrxv8gsaOyZ2S6cYmSgApP79kVU8Cqk9T4b8=;
        b=bYNuvIeccKOJEzLJ7vAu3X3Jc5/aE6jSXvSizWnFi+6ku7cUjDS1gTve+L5jXdPYaf
         MwyckBO0eqjBreM5BlcVC2nUfKtWMJ6wwA45fqEo2wZVQcAA2RGSB9QWHwID+W5ByeRY
         16ijeUgdQV4LVW4Tsj0S2ykm8Gc7VGWmwR8olZBDAnib8hzUps64l5WGvEk4ZPTQY58w
         pEJg8baSoztJEy5pSoRhZvh5uenuIGIvvjX+tZ8BQ/SkWCvYWJPR1pHtLbX2i7lACy3y
         fF9LpuyfER8F5yGNaEhwdahvHIXut/Fcyo0ccseA9ek0q4NsPZ/D7YnWFTPvWRBqmEyp
         zIWg==
X-Forwarded-Encrypted: i=1; AJvYcCXBQoexDEN76mTi1oTHT1BIKxM8tjOom+XSsm/ENCFUH401sGU9RuxV1xpNXg7DtFFCftfv4+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgi5ChKKmGj2fZqnCFDdiRiPnHfgfE9ss5Sj1njTQny7gBU+4D
	6W1euCE6dNLhT0LvM80zNhSgUQEojKTVCQfC+XnbzxKjDpcTr3akwgaTczNo1mRem1/6UdqlMsC
	WfjlKYFQ/wpK/6t1NcFNtmaCLb4pZn43l7ogXQVS7dRMkAwFBB9zl+NErDN3ewmbDeDvRALJdaI
	ncP+uzrd3+FaTXgFa0uaCutG2mna0o8KkKwQZsfRmB3/cLA9VE3PV4+bj7FA5l4hYnCjlJPyngh
	vj8tV3wHw2QkA==
X-Gm-Gg: ASbGnctEX9wc8ztjbJaTODDYVgn6Y5SU7aQW5BaxWnIpwOJ2YsgZtLpav6rKqH3ir2O
	w83SGwl/WsuP0Deyr5cpjne+B8eKvBISQBvPciM28Is06pDRj0pHYQZx4+rmfZuUpLkvxCAtZTO
	a/aDaiu4X2KGgneEyXGCHPdof0hK9hbsxIpXCkFjyyY+0erJ0TeQrlQRCVm2XfTSq7yjhL6gCe0
	d3Hvd9Y/0TORBAFF+1snIgY+to4We4MZ3JQGp+gG2Gxh+IagQ1zyDD3ti8mTNenXS+IDGmKbJJT
	H+YPPihjmbLztbwWHFz4squ/kUF1kecI+uS/W1SGU7783fyXgc33g1QHfjx0/h0xE7ANk7unSCZ
	t0P5Ohka3N4c6LJZx7pT8WxiZwuWDXAd+Fl8TvGbAp3T17GQ34qJxc7VdTrCeVGNeZzlC1tO9Pd
	WSBg==
X-Google-Smtp-Source: AGHT+IENDwMkCnvfHYgir+6A8RlA2oNGz008Q5nyzNLb1K9zbT01Ny04ADsqTZaxntj9FuIsQHmkoUSFxp1+
X-Received: by 2002:a05:6870:d312:b0:315:60a6:c27b with SMTP id 586e51a60fabf-3c115c148fbmr9970625fac.10.1760429067482;
        Tue, 14 Oct 2025 01:04:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3c8c8f7668esm1089872fac.24.2025.10.14.01.04.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780f9cc532bso7367794b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429066; x=1761033866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sAVBIZzrxv8gsaOyZ2S6cYmSgApP79kVU8Cqk9T4b8=;
        b=U52d6M8jyO/idFTmVSuEX4PzByX+Z+THdUs7rPArDPdIp+iTWgs+x+W77uZYbIby9H
         GufYh1yfK6AfGijLJyXhh5/3cBnsu+RTj3KTnrDrXEK4t51DdSZt1Z9IZfxpBTbrRAam
         TK0ifdFkaZwltW2Q+i265tOFOU6+xMb9DEYWA=
X-Forwarded-Encrypted: i=1; AJvYcCVQWVxNqkcjEhSgLYwJ1OL1b5y5Le/lQXn8WA8a0kyCQ/9rMp9JWD4mjVmwF3yg2ZYYuftY8A0=@vger.kernel.org
X-Received: by 2002:a05:6a00:987:b0:781:1110:f175 with SMTP id d2e1a72fcca58-793992757eemr29632406b3a.14.1760429065527;
        Tue, 14 Oct 2025 01:04:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:987:b0:781:1110:f175 with SMTP id d2e1a72fcca58-793992757eemr29632364b3a.14.1760429064942;
        Tue, 14 Oct 2025 01:04:24 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:24 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/5] bnxt_fwctl: Add bnxt fwctl device
Date: Tue, 14 Oct 2025 01:10:32 -0700
Message-Id: <20251014081033.1175053-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 MAINTAINERS                 |   6 +
 drivers/fwctl/Kconfig       |  11 +
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/bnxt/Makefile |   4 +
 drivers/fwctl/bnxt/main.c   | 453 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/bnxt.h   |  64 +++++
 include/uapi/fwctl/fwctl.h  |   1 +
 7 files changed, 540 insertions(+)
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 create mode 100644 include/uapi/fwctl/bnxt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2..a5ab77d4ea67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10282,6 +10282,12 @@ L:	linux-kernel@vger.kernel.org
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
index b5583b12a011..b3795a17f8f2 100644
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
+	  configuration registers of the Broadcom NIC hardware family.
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
index 000000000000..b31f34c1cc3c
--- /dev/null
+++ b/drivers/fwctl/bnxt/main.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Broadcom Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/fwctl.h>
+#include <uapi/fwctl/fwctl.h>
+#include <uapi/fwctl/bnxt.h>
+#include <linux/bnxt/hsi.h>
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
+				 struct bnxt_fw_msg *hwrm_in,
+				 enum fwctl_rpc_scope scope)
+{
+	struct input *req = (struct input *)hwrm_in->msg;
+
+	guard(mutex)(&edev->en_dev_lock);
+	if (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)
+		return false;
+
+	switch (le16_to_cpu(req->req_type)) {
+	case HWRM_FUNC_VF_CFG:
+	case HWRM_FUNC_RESET:
+	case HWRM_FUNC_CFG:
+	case HWRM_PORT_PHY_CFG:
+	case HWRM_PORT_MAC_CFG:
+	case HWRM_PORT_CLR_STATS:
+	case HWRM_QUEUE_PRI2COS_CFG:
+	case HWRM_QUEUE_COS2BW_CFG:
+	case HWRM_QUEUE_DSCP2PRI_CFG:
+	case HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG:
+	case HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG:
+	case HWRM_QUEUE_ADPTV_QOS_RX_TUNING_CFG:
+	case HWRM_VNIC_RSS_CFG:
+	case HWRM_TUNNEL_DST_PORT_ALLOC:
+	case HWRM_TUNNEL_DST_PORT_FREE:
+	case HWRM_QUEUE_ADPTV_QOS_TX_TUNING_CFG:
+	case HWRM_PORT_TX_FIR_CFG:
+	case HWRM_FW_SET_STRUCTURED_DATA:
+	case HWRM_PORT_PRBS_TEST:
+	case HWRM_PORT_EP_TX_CFG:
+	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_INFO:
+	case HWRM_CFA_FLOW_FLUSH:
+	case HWRM_CFA_L2_FILTER_ALLOC:
+	case HWRM_CFA_NTUPLE_FILTER_FREE:
+	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_ALLOC:
+	case HWRM_CFA_REDIRECT_TUNNEL_TYPE_FREE:
+	case HWRM_FW_LIVEPATCH:
+	case HWRM_FW_RESET:
+	case HWRM_FW_SYNC:
+	case HWRM_FW_SET_TIME:
+	case HWRM_PORT_CFG:
+	case HWRM_FUNC_PTP_PIN_CFG:
+	case HWRM_FUNC_PTP_CFG:
+	case HWRM_FUNC_PTP_EXT_CFG:
+	case HWRM_FUNC_SYNCE_CFG:
+	case HWRM_MFG_OTP_CFG:
+	case HWRM_MFG_TESTS:
+	case HWRM_UDCC_CFG:
+	case HWRM_DBG_SERDES_TEST:
+	case HWRM_DBG_LOG_BUFFER_FLUSH:
+	case HWRM_DBG_DUMP:
+	case HWRM_DBG_ERASE_NVM:
+	case HWRM_DBG_CFG:
+	case HWRM_DBG_COREDUMP_LIST:
+	case HWRM_DBG_COREDUMP_INITIATE:
+	case HWRM_DBG_COREDUMP_RETRIEVE:
+	case HWRM_DBG_CRASHDUMP_HEADER:
+	case HWRM_DBG_CRASHDUMP_ERASE:
+	case HWRM_DBG_PTRACE:
+	case HWRM_DBG_TOKEN_CFG:
+	case HWRM_NVM_DEFRAG:
+	case HWRM_NVM_FACTORY_DEFAULTS:
+	case HWRM_NVM_FLUSH:
+	case HWRM_NVM_INSTALL_UPDATE:
+	case HWRM_NVM_MODIFY:
+	case HWRM_NVM_VERIFY_UPDATE:
+	case HWRM_NVM_ERASE_DIR_ENTRY:
+	case HWRM_NVM_MOD_DIR_ENTRY:
+	case HWRM_NVM_FIND_DIR_ENTRY:
+	case HWRM_NVM_RAW_DUMP:
+		return scope >= FWCTL_RPC_CONFIGURATION;
+
+	case HWRM_VER_GET:
+	case HWRM_FW_GET_STRUCTURED_DATA:
+	case HWRM_ERROR_RECOVERY_QCFG:
+	case HWRM_FUNC_QCAPS:
+	case HWRM_FUNC_QCFG:
+	case HWRM_FUNC_QSTATS:
+	case HWRM_PORT_QSTATS:
+	case HWRM_PORT_PHY_QCFG:
+	case HWRM_PORT_MAC_QCFG:
+	case HWRM_PORT_PHY_QCAPS:
+	case HWRM_PORT_PHY_I2C_READ:
+	case HWRM_PORT_PHY_MDIO_READ:
+	case HWRM_QUEUE_PRI2COS_QCFG:
+	case HWRM_QUEUE_COS2BW_QCFG:
+	case HWRM_QUEUE_DSCP2PRI_QCFG:
+	case HWRM_VNIC_RSS_QCFG:
+	case HWRM_QUEUE_GLOBAL_QCFG:
+	case HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_QCFG:
+	case HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG:
+	case HWRM_QUEUE_QCAPS:
+	case HWRM_QUEUE_ADPTV_QOS_RX_TUNING_QCFG:
+	case HWRM_QUEUE_ADPTV_QOS_TX_TUNING_QCFG:
+	case HWRM_TUNNEL_DST_PORT_QUERY:
+	case HWRM_PORT_QSTATS_EXT:
+	case HWRM_PORT_TX_FIR_QCFG:
+	case HWRM_FW_LIVEPATCH_QUERY:
+	case HWRM_FW_QSTATUS:
+	case HWRM_FW_HEALTH_CHECK:
+	case HWRM_FW_GET_TIME:
+	case HWRM_PORT_DSC_DUMP:
+	case HWRM_PORT_EP_TX_QCFG:
+	case HWRM_PORT_QCFG:
+	case HWRM_PORT_MAC_QCAPS:
+	case HWRM_TEMP_MONITOR_QUERY:
+	case HWRM_REG_POWER_QUERY:
+	case HWRM_CORE_FREQUENCY_QUERY:
+	case HWRM_STAT_QUERY_ROCE_STATS:
+	case HWRM_STAT_QUERY_ROCE_STATS_EXT:
+	case HWRM_CFA_REDIRECT_QUERY_TUNNEL_TYPE:
+	case HWRM_CFA_FLOW_INFO:
+	case HWRM_CFA_ADV_FLOW_MGNT_QCAPS:
+	case HWRM_FUNC_RESOURCE_QCAPS:
+	case HWRM_FUNC_BACKING_STORE_QCAPS:
+	case HWRM_FUNC_BACKING_STORE_QCFG:
+	case HWRM_FUNC_QSTATS_EXT:
+	case HWRM_FUNC_PTP_PIN_QCFG:
+	case HWRM_FUNC_PTP_EXT_QCFG:
+	case HWRM_FUNC_BACKING_STORE_QCFG_V2:
+	case HWRM_FUNC_BACKING_STORE_QCAPS_V2:
+	case HWRM_FUNC_SYNCE_QCFG:
+	case HWRM_FUNC_TTX_PACING_RATE_PROF_QUERY:
+	case HWRM_PCIE_QSTATS:
+	case HWRM_MFG_OTP_QCFG:
+	case HWRM_MFG_FRU_EEPROM_READ:
+	case HWRM_MFG_GET_NVM_MEASUREMENT:
+	case HWRM_STAT_GENERIC_QSTATS:
+	case HWRM_PORT_PHY_FDRSTAT:
+	case HWRM_UDCC_QCAPS:
+	case HWRM_UDCC_QCFG:
+	case HWRM_UDCC_SESSION_QCFG:
+	case HWRM_UDCC_SESSION_QUERY:
+	case HWRM_UDCC_COMP_QCFG:
+	case HWRM_UDCC_COMP_QUERY:
+	case HWRM_QUEUE_ADPTV_QOS_RX_QCFG:
+	case HWRM_QUEUE_ADPTV_QOS_TX_QCFG:
+	case HWRM_TF_RESC_USAGE_QUERY:
+	case HWRM_TFC_RESC_USAGE_QUERY:
+	case HWRM_DBG_READ_DIRECT:
+	case HWRM_DBG_READ_INDIRECT:
+	case HWRM_DBG_RING_INFO_GET:
+	case HWRM_DBG_QCAPS:
+	case HWRM_DBG_QCFG:
+	case HWRM_DBG_USEQ_FLUSH:
+	case HWRM_DBG_USEQ_QCAPS:
+	case HWRM_DBG_SIM_CABLE_STATE:
+	case HWRM_DBG_TOKEN_QUERY_AUTH_IDS:
+	case HWRM_NVM_GET_VARIABLE:
+	case HWRM_NVM_GET_DEV_INFO:
+	case HWRM_NVM_GET_DIR_ENTRIES:
+	case HWRM_NVM_GET_DIR_INFO:
+	case HWRM_NVM_READ:
+	case HWRM_SELFTEST_QLIST:
+	case HWRM_SELFTEST_RETRIEVE_SERDES_DATA:
+		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case HWRM_PORT_PHY_I2C_WRITE:
+	case HWRM_MFG_FRU_WRITE_CONTROL:
+	case HWRM_MFG_FRU_EEPROM_WRITE:
+	case HWRM_DBG_WRITE_DIRECT:
+	case HWRM_NVM_SET_VARIABLE:
+	case HWRM_NVM_WRITE:
+	case HWRM_NVM_RAW_WRITE_BLK:
+	case HWRM_PORT_PHY_MDIO_WRITE:
+		return scope >= FWCTL_RPC_DEBUG_WRITE;
+
+	default:
+		return false;
+	}
+}
+
+static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
+				   struct device *dev,
+				   struct fwctl_dma_info_bnxt *msg,
+				   struct bnxt_fw_msg *fw_msg,
+				   int num_dma,
+				   void **dma_virt_addr,
+				   dma_addr_t *dma_addr)
+{
+	u8 i, num_allocated = 0;
+	void *dma_ptr;
+	int rc;
+
+	for (i = 0; i < num_dma; i++) {
+		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
+			rc = -EINVAL;
+			goto err;
+		}
+		dma_virt_addr[i] = dma_alloc_coherent(dev->parent, msg->len,
+						      &dma_addr[i], GFP_KERNEL);
+		if (!dma_virt_addr[i]) {
+			rc = -ENOMEM;
+			goto err;
+		}
+		num_allocated++;
+		if (msg->dma_direction == DEVICE_WRITE) {
+			if (copy_from_user(dma_virt_addr[i],
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
+			*dmap = cpu_to_le64(dma_addr[i]);
+		} else {
+			rc = -EINVAL;
+			goto err;
+		}
+		msg += 1;
+	}
+
+	return 0;
+err:
+	for (i = 0; i < num_allocated; i++)
+		dma_free_coherent(dev->parent, msg->len, dma_virt_addr[i],
+				  dma_addr[i]);
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
+	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
+	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
+	struct fwctl_dma_info_bnxt *dma_buf = NULL;
+	struct device *dev = &uctx->fwctl->dev;
+	struct fwctl_rpc_bnxt *msg = in;
+	struct bnxt_fw_msg rpc_in;
+	int i, rc, err = 0;
+
+	rpc_in.msg = memdup_user(u64_to_user_ptr(msg->req), msg->req_len);
+	if (IS_ERR(rpc_in.msg))
+		return rpc_in.msg;
+
+	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in, scope)) {
+		err = -EPERM;
+		goto free_msg_out;
+	}
+
+	rpc_in.msg_len = msg->req_len;
+	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
+	if (!rpc_in.resp) {
+		err = -ENOMEM;
+		goto free_msg_out;
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
+			goto free_msg_out;
+		}
+
+		dma_buf = kcalloc(msg->num_dma, sizeof(*dma_buf), GFP_KERNEL);
+		if (!dma_buf) {
+			err = -ENOMEM;
+			goto free_msg_out;
+		}
+
+		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
+				   msg->num_dma * sizeof(*dma_buf))) {
+			dev_dbg(dev, "Failed to copy payload from user\n");
+			err = -EFAULT;
+			goto free_dmabuf_out;
+		}
+
+		err = bnxt_fw_setup_input_dma(bnxtctl, dev, dma_buf, &rpc_in,
+					      msg->num_dma, &dma_virt_addr[0],
+					      &dma_addr[0]);
+		if (err)
+			goto free_dmabuf_out;
+	}
+
+	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
+	if (rc) {
+		struct output *resp = rpc_in.resp;
+
+		/* Copy the response to user always, as it contains
+		 * detailed status of the command failure
+		 */
+		if (!resp->error_code)
+			/* bnxt_send_msg() returned much before FW
+			 * received the command.
+			 */
+			resp->error_code = rc;
+
+		goto free_dma_out;
+	}
+
+	for (i = 0; i < msg->num_dma; i++) {
+		if (dma_buf[i].dma_direction == DEVICE_READ) {
+			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
+					 dma_virt_addr[i],
+					 dma_buf[i].len)) {
+				dev_dbg(dev, "Failed to copy resp to user\n");
+				err = -EFAULT;
+				break;
+			}
+		}
+	}
+free_dma_out:
+	for (i = 0; i < msg->num_dma; i++)
+		dma_free_coherent(dev->parent, dma_buf[i].len, dma_virt_addr[i],
+				  dma_addr[i]);
+free_dmabuf_out:
+	kfree(dma_buf);
+free_msg_out:
+	kfree(rpc_in.msg);
+
+	if (err) {
+		kfree(rpc_in.resp);
+		return ERR_PTR(err);
+	}
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
+	{}
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
index 000000000000..0fb20972b476
--- /dev/null
+++ b/include/uapi/fwctl/bnxt.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2025, Broadcom Inc
+ */
+
+#ifndef _UAPI_FWCTL_BNXT_H_
+#define _UAPI_FWCTL_BNXT_H_
+
+#include <linux/types.h>
+
+#define MAX_DMA_MEM_SIZE		0x10000 /*64K*/
+#define DFLT_HWRM_CMD_TIMEOUT		500
+#define DEVICE_WRITE			0
+#define DEVICE_READ			1
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
+};
+
+#define MAX_NUM_DMA_INDICATIONS 10
+
+/**
+ * struct fwctl_dma_info_bnxt - describe the buffer that should be DMAed
+ * @data: DMA-intended buffer
+ * @len: length of the @data
+ * @offset: offset at which FW (HWRM) input structure needs DMA address
+ * @dma_direction: DMA direction, DEVICE_READ or DEVICE_WRITE
+ * @unused: pad
+ */
+struct fwctl_dma_info_bnxt {
+	__aligned_u64 data;
+	__u32 len;
+	__u16 offset;
+	__u8 dma_direction;
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


