Return-Path: <netdev+bounces-202825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CFAEF2D5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5AF17636E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498126E706;
	Tue,  1 Jul 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ASTr3KMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621E26E16C
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361117; cv=none; b=R8rS3Utnw2UN5OD9IPMcuM6yYbCY83lDXUhfLVFUlU+S6oXtnuouJRfJI8B2UX/DobXa/OWGdkNe9kKpQFPg5kVLq+gorbY2hM1CGdkMKYA33NFBoYM2293JXVbBPgs8bEJCy0x2BWrWa/344YktkBUkWn1QBr4X1wDemQQXZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361117; c=relaxed/simple;
	bh=W6cP78wIGMhoYyHYkrHnhShjuVMTLSpYdc7+nQOTa4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbSw8p0p2uiRCeslL401TrMhPfEin1XOFACvbJtJ6rjjhejHrNfhmErOYHWLp2GA97r6CIw0jl3DCiazAoiFI7j/IcpI4AidXcVAp3H38uEv8EQqxsP73dp15uMMe9yvKE7X+lCCQIKjxVs1UD6xImVDUJkgTiAtG/L8WmRHu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ASTr3KMN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso53499925ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751361115; x=1751965915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1gBQftS2Fk6V7LZfv5a/Ar3bdUI/g78/+w8i6zo9Uo=;
        b=ASTr3KMN6ksHo/oij9hn+PUtLiTR9C7nK7ewEWCIbhTs0p15jV3Askeimt7cdhW0SI
         HeZRu/bscNcy/1Jj31l4Ya9IQNy94Ub+HxV0y+oV/Fj0ZGE9uqTTIjzfoQidZmktRCxU
         Mq5aXBtxWKdMRHwyoSHUW2lHOboZokPEjwoD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361115; x=1751965915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1gBQftS2Fk6V7LZfv5a/Ar3bdUI/g78/+w8i6zo9Uo=;
        b=sg6vODE+tQTS68lUlq0mIiIflItvXolIe0/1CSTf3ScmPEDv45oNm7gghPyD9QvO8j
         c+8fyd8CLbQ+0s0sw2P48D8ePXns5e0AnJd4YO5VTAWFyavSdViSrs4oeXvy4lPBfT3P
         d/UK+HNiLG611ZWVtcvXuqGuzYWxCRFKtLcTR4LcNCF46QZrA32YHVfVvHZelMsGN8UW
         WMJepdzY0oJw7C/FZ3AwD0f0OqLW6L5bwJtWWPo/XMNwUKzZvzuUIKA0IEDUECf0YoH9
         aIIjiDiKUFcfyLWNJ1a9QFN4kZTafXNi4rMx7gb4MRirELM+Grte2AyRxx1faA2DwV7P
         N9fQ==
X-Gm-Message-State: AOJu0Yz1xsYfSTHuulbs5pYvGwc6xJ8y3g9MS2ykBDwsZQPrAxn3KPxD
	9oWAts06JjyDwupPRWjVG4nh9junLvZF6mK7hUonjmkx/nZGGF7IFepRURIonIvXZQ==
X-Gm-Gg: ASbGnctCDMFi8W+PKqdwNKxhOE9yheQBoi3F7y2R79PKfxhUHQphb1//FaTUD5gxDK8
	tKYIdQGkQ80GK/wr++RtngZVvIqHDP3DpEwvauJeFK1nUY3aCj9ncZ8v6JKP/oJDb6LLCTdjCli
	PZwZ8S/nKOG8rL5oae7q0xRqKSb+t1jYzKyLRvZrPTzsGBMB/yx8bpJFnksvNQaE0m53bIZKFhA
	Sjzs5yi6NQBXEktiXlJYgQg227Rljyv1UwA+aPWFNTJJX3D62TxMnck2A3pNFEA8Yyrbug9QwAO
	3bIF7AUNaSg377zyGsXakUbYRsk81zqHPVDToTPNHMjlrU3l7LW/P8qXamy4ZUAsNOM/MUJR+WY
	7iJEQ0ehserMO/oQA/SER+8YhZk7z
X-Google-Smtp-Source: AGHT+IEsR0fX4mu6qIR0dec/ZWIENXXucQzEdKkuwM/+snwoIUasS41gYQP+hlmbxTeAUtwsnl0Urw==
X-Received: by 2002:a17:903:f8c:b0:221:1497:7b08 with SMTP id d9443c01a7336-23b355985d6mr50306475ad.23.1751361114685;
        Tue, 01 Jul 2025 02:11:54 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e30201c1sm8893603a12.22.2025.07.01.02.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:11:54 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v3 02/10] bng_en: Add devlink interface
Date: Tue,  1 Jul 2025 14:35:00 +0000
Message-ID: <20250701143511.280702-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701143511.280702-1-vikas.gupta@broadcom.com>
References: <20250701143511.280702-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate a base device and devlink interface with minimal
devlink ops.
Add dsn and board related information.
Map PCIe BAR (bar0), which helps to communicate with the
firmware.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  11 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  39 +++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.c | 142 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.h |  16 ++
 6 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index e2c1ac91708e..0fc10e6c6902 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -256,6 +256,7 @@ config BNXT_HWMON
 config BNGE
 	tristate "Broadcom Ethernet device support"
 	depends on PCI
+	select NET_DEVLINK
 	help
 	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
 	  The module will be called bng_en. To compile this driver as a module,
diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 0c3d632805d1..e021a14d2fa0 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_BNGE) += bng_en.o
 
-bng_en-y := bnge_core.o
+bng_en-y := bnge_core.o \
+	    bnge_devlink.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index b49c51b44473..19d85aabab4e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -13,4 +13,15 @@ enum board_idx {
 	BCM57708,
 };
 
+struct bnge_dev {
+	struct device	*dev;
+	struct pci_dev	*pdev;
+	u64	dsn;
+#define BNGE_VPD_FLD_LEN	32
+	char		board_partno[BNGE_VPD_FLD_LEN];
+	char		board_serialno[BNGE_VPD_FLD_LEN];
+
+	void __iomem	*bar0;
+};
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 514602555cd1..2596215f0639 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 
 #include "bnge.h"
+#include "bnge_devlink.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -77,8 +78,19 @@ static int bnge_pci_enable(struct pci_dev *pdev)
 	return rc;
 }
 
+static void bnge_unmap_bars(struct pci_dev *pdev)
+{
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	if (bd->bar0) {
+		pci_iounmap(pdev, bd->bar0);
+		bd->bar0 = NULL;
+	}
+}
+
 static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct bnge_dev *bd;
 	int rc;
 
 	if (pci_is_bridge(pdev))
@@ -100,13 +112,40 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnge_print_device_info(pdev, ent->driver_data);
 
+	bd = bnge_devlink_alloc(pdev);
+	if (!bd) {
+		dev_err(&pdev->dev, "Devlink allocation failed\n");
+		rc = -ENOMEM;
+		goto err_pci_disable;
+	}
+
+	bd->bar0 = pci_ioremap_bar(pdev, 0);
+	if (!bd->bar0) {
+		dev_err(&pdev->dev, "Failed mapping BAR-0, aborting\n");
+		rc = -ENOMEM;
+		goto err_devl_free;
+	}
+
 	pci_save_state(pdev);
 
 	return 0;
+
+err_devl_free:
+	bnge_devlink_free(bd);
+
+err_pci_disable:
+	bnge_pci_disable(pdev);
+	return rc;
 }
 
 static void bnge_remove_one(struct pci_dev *pdev)
 {
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	bnge_unmap_bars(pdev);
+
+	bnge_devlink_free(bd);
+
 	bnge_pci_disable(pdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
new file mode 100644
index 000000000000..d01cc32ce241
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/unaligned.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+
+#include "bnge.h"
+#include "bnge_devlink.h"
+
+static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
+			    enum bnge_dl_version_type type, const char *key,
+			    char *buf)
+{
+	if (!strlen(buf))
+		return 0;
+
+	switch (type) {
+	case BNGE_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, buf);
+	case BNGE_VERSION_RUNNING:
+		return devlink_info_version_running_put(req, key, buf);
+	case BNGE_VERSION_STORED:
+		return devlink_info_version_stored_put(req, key, buf);
+	}
+
+	return 0;
+}
+
+static void bnge_vpd_read_info(struct bnge_dev *bd)
+{
+	struct pci_dev *pdev = bd->pdev;
+	unsigned int vpd_size, kw_len;
+	int pos, size;
+	u8 *vpd_data;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		pci_warn(pdev, "Unable to read VPD\n");
+		return;
+	}
+
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_PARTNO, &kw_len);
+	if (pos < 0)
+		goto read_sn;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_partno, &vpd_data[pos], size);
+
+read_sn:
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_SERIALNO,
+					   &kw_len);
+	if (pos < 0)
+		goto exit;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_serialno, &vpd_data[pos], size);
+
+exit:
+	kfree(vpd_data);
+}
+
+static int bnge_devlink_info_get(struct devlink *devlink,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct bnge_dev *bd = devlink_priv(devlink);
+	int rc;
+
+	if (bd->dsn) {
+		char buf[32];
+		u8 dsn[8];
+		int rc;
+
+		put_unaligned_le64(bd->dsn, dsn);
+		sprintf(buf, "%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X",
+			dsn[7], dsn[6], dsn[5], dsn[4],
+			dsn[3], dsn[2], dsn[1], dsn[0]);
+		rc = devlink_info_serial_number_put(req, buf);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack, "Failed to set dsn");
+			return rc;
+		}
+	}
+
+	if (strlen(bd->board_serialno)) {
+		rc = devlink_info_board_serial_number_put(req,
+							  bd->board_serialno);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to set board serial number");
+			return rc;
+		}
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
+			      DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+			      bd->board_partno);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set board part number");
+		return rc;
+	}
+
+	return rc;
+}
+
+static const struct devlink_ops bnge_devlink_ops = {
+	.info_get = bnge_devlink_info_get,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_free(devlink);
+}
+
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev)
+{
+	struct devlink *devlink;
+	struct bnge_dev *bd;
+
+	devlink = devlink_alloc(&bnge_devlink_ops, sizeof(*bd), &pdev->dev);
+	if (!devlink)
+		return NULL;
+
+	bd = devlink_priv(devlink);
+	pci_set_drvdata(pdev, bd);
+	bd->dev = &pdev->dev;
+	bd->pdev = pdev;
+
+	bd->dsn = pci_get_dsn(pdev);
+	if (!bd->dsn)
+		pci_warn(pdev, "Failed to get DSN\n");
+
+	bnge_vpd_read_info(bd);
+
+	return bd;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
new file mode 100644
index 000000000000..497543918741
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_DEVLINK_H_
+#define _BNGE_DEVLINK_H_
+
+enum bnge_dl_version_type {
+	BNGE_VERSION_FIXED,
+	BNGE_VERSION_RUNNING,
+	BNGE_VERSION_STORED,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd);
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev);
+
+#endif /* _BNGE_DEVLINK_H_ */
-- 
2.47.1


