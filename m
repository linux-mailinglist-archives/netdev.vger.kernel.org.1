Return-Path: <netdev+bounces-202827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16187AEF2DA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70AA1BC72CF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFC26FD8E;
	Tue,  1 Jul 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CHL4LNSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98F26E154
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361126; cv=none; b=tBUSsZYGUI6v4ha3y6KjdS6rfKshC0e8VG8lG7t2oSiRa2qQ1JXFsOg2yUXM5gtYoktq8SvexKlIaiAFAFIJqbp5CwpTTfPnbgSeKOXPftBtT8gdooI0GRIDX5dd4iJ15znkJakZTE4Ifsm7TMwZsaqOYQr1aEtbmzqjm+8goic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361126; c=relaxed/simple;
	bh=Wlez0zvhdgj2NMU7MK0vkWaBeyx9njhJ7cfIc8ZDq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH5kJt6Bh+q1kr5cOVvE5XmYBbijMz3mB+CFOH83RWVsYZjXJbFaoNNXKhrf7F8EOhOylJcnYdx0s7mT3FbCrq5f/XDgtbMLmILBtjvTrhkyqGZZCGjPyNAytYv24Y4DhdW3D67ROugZYkOopPL/A5LWA7PebJDv/ZklrONdDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CHL4LNSk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5978715b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751361123; x=1751965923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irBA5xf1kOPHNpG+0PZ9Bf0gcMLVOa5ZCjBsgWosHi4=;
        b=CHL4LNSkwahGxLJ7U9McthQU2X1q0hU+/9uSb3Gh0rQTtMdrx+gB4hyHJHJ+XXE3ih
         y/F6JUwdU0gtUhdG0wRgSJEd5QDvuafBx9adL/NV31JMKsBSuWHacj3UjsKYNuhES9+9
         N+zupD0QLqeXbv+bnDE0YvkuB2sLUU0fJa69A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361123; x=1751965923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irBA5xf1kOPHNpG+0PZ9Bf0gcMLVOa5ZCjBsgWosHi4=;
        b=Y00fh3PvUMjkIYqHysYAO5Q+rU55ZbZM3WX6Chak8vfhAigvNR3/C5m4o/+l/fcWol
         dDq3IJdH3myH9b1LBi8C9OndECGOV1ByfvQ21DVYGzhUOvABVsN7FkPXtcWCB6XZ4ydd
         PB0iLz7PcREWA1sAgU+8Qv2gfoiqkmp8lwfkuVMA3eZSOH08gBz+d1Yme3h50YKDxjjh
         e+bfLvqXBADIcsPlsPShV6MJD+eOOp1Be+n944/xxb0+7jZaekNGu+gksG1r/S0wNgFm
         x3DXVLNiu6a340K90kX6OZaM8VWAtgzl3KfyoyLpGklNr+rp/sZYSrvZC3tOaDXSC6NF
         NegQ==
X-Gm-Message-State: AOJu0YxNXhs4NQwrzd4GvOL7UVOTQrw8VLCMkt5ZlKYn2JZ370D4r9Sn
	T7dBzcfRlkIqSLomkPyjbQBVVrbQo4+u8ljEnKmVtDXw2WPa76VjbduwYLoRhbjnzw==
X-Gm-Gg: ASbGncsP08bgJbw1PFks8Ec8Sx5YFAMeZPFCx00VZQdYu10M+lQqKeIJjf1KmQu1Or/
	mhViuXAYF5hl33XOzliMIFaiOpD5XAKt1J6iIW14wIxbXii4He3wjQd5//O26+j4Xajt5nck8hr
	Oo8RKwxOI86AVHns9zOmYLPY/yuWnvU+rRszPdcogBU+6UiYWuePRG+mJdEYsAq1/nqr4QECTcY
	AR8fre6C9Y3HQY5VWnOWP+y+rQYFt/mOJGjT/LhG8GEQzHIskIax5FIh5oTKC3l9X9mMO0OGgpW
	aLyapY05Wj5Rz5KZYDAEqfXOIuqZLbVDH2DLOtMJVnW3UNSLVIzVxXOgP2etBD8ppCcEzu/BeW4
	s0X9KNlp5JcDRQmcdqLsgJoY4FmFm
X-Google-Smtp-Source: AGHT+IHCyAQjCFHdxsOw3+jt9Hp58zbATfdUwR/r8/3aaArd3Gyl42KzwPu1AR42OmJ/wlHYOHrHJA==
X-Received: by 2002:a05:6a21:5019:b0:222:d191:5bbd with SMTP id adf61e73a8af0-222d1915d3dmr482431637.39.1751361123354;
        Tue, 01 Jul 2025 02:12:03 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e30201c1sm8893603a12.22.2025.07.01.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:12:02 -0700 (PDT)
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
Subject: [net-next, v3 04/10] bng_en: Add initial interaction with firmware
Date: Tue,  1 Jul 2025 14:35:02 +0000
Message-ID: <20250701143511.280702-5-vikas.gupta@broadcom.com>
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

Query firmware with the help of basic firmware commands and
cache the capabilities. With the help of basic commands
start the initialization process of the driver with the
firmware.
Since basic information is available from the firmware,
register with devlink.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  54 +++++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  71 ++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.c | 164 ++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.h |   2 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 213 ++++++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  16 ++
 7 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index b296d7de56ce..b8dbbc2d5972 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_BNGE) += bng_en.o
 
 bng_en-y := bnge_core.o \
 	    bnge_devlink.o \
-	    bnge_hwrm.o
+	    bnge_hwrm.o \
+	    bnge_hwrm_lib.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 8f2a562d9ae2..60af0517c45e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -7,6 +7,13 @@
 #define DRV_NAME	"bng_en"
 #define DRV_SUMMARY	"Broadcom 800G Ethernet Linux Driver"
 
+#include <linux/etherdevice.h>
+#include "../bnxt/bnxt_hsi.h"
+
+#define DRV_VER_MAJ	1
+#define DRV_VER_MIN	15
+#define DRV_VER_UPD	1
+
 extern char bnge_driver_name[];
 
 enum board_idx {
@@ -15,6 +22,36 @@ enum board_idx {
 
 #define INVALID_HW_RING_ID      ((u16)-1)
 
+enum {
+	BNGE_FW_CAP_SHORT_CMD				= BIT_ULL(0),
+	BNGE_FW_CAP_LLDP_AGENT				= BIT_ULL(1),
+	BNGE_FW_CAP_DCBX_AGENT				= BIT_ULL(2),
+	BNGE_FW_CAP_IF_CHANGE				= BIT_ULL(3),
+	BNGE_FW_CAP_KONG_MB_CHNL			= BIT_ULL(4),
+	BNGE_FW_CAP_ERROR_RECOVERY			= BIT_ULL(5),
+	BNGE_FW_CAP_PKG_VER				= BIT_ULL(6),
+	BNGE_FW_CAP_CFA_ADV_FLOW			= BIT_ULL(7),
+	BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V2		= BIT_ULL(8),
+	BNGE_FW_CAP_PCIE_STATS_SUPPORTED		= BIT_ULL(9),
+	BNGE_FW_CAP_EXT_STATS_SUPPORTED			= BIT_ULL(10),
+	BNGE_FW_CAP_ERR_RECOVER_RELOAD			= BIT_ULL(11),
+	BNGE_FW_CAP_HOT_RESET				= BIT_ULL(12),
+	BNGE_FW_CAP_RX_ALL_PKT_TS			= BIT_ULL(13),
+	BNGE_FW_CAP_VLAN_RX_STRIP			= BIT_ULL(14),
+	BNGE_FW_CAP_VLAN_TX_INSERT			= BIT_ULL(15),
+	BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED		= BIT_ULL(16),
+	BNGE_FW_CAP_LIVEPATCH				= BIT_ULL(17),
+	BNGE_FW_CAP_HOT_RESET_IF			= BIT_ULL(18),
+	BNGE_FW_CAP_RING_MONITOR			= BIT_ULL(19),
+	BNGE_FW_CAP_DBG_QCAPS				= BIT_ULL(20),
+	BNGE_FW_CAP_THRESHOLD_TEMP_SUPPORTED		= BIT_ULL(21),
+	BNGE_FW_CAP_DFLT_VLAN_TPID_PCP			= BIT_ULL(22),
+	BNGE_FW_CAP_VNIC_TUNNEL_TPA			= BIT_ULL(23),
+	BNGE_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO		= BIT_ULL(24),
+	BNGE_FW_CAP_CFA_RFS_RING_TBL_IDX_V3		= BIT_ULL(25),
+	BNGE_FW_CAP_VNIC_RE_FLUSH			= BIT_ULL(26),
+};
+
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
@@ -25,6 +62,9 @@ struct bnge_dev {
 
 	void __iomem	*bar0;
 
+	u16		chip_num;
+	u8		chip_rev;
+
 	/* HWRM members */
 	u16			hwrm_cmd_seq;
 	u16			hwrm_cmd_kong_seq;
@@ -35,6 +75,20 @@ struct bnge_dev {
 	unsigned int		hwrm_cmd_timeout;
 	unsigned int		hwrm_cmd_max_timeout;
 	struct mutex		hwrm_cmd_lock;	/* serialize hwrm messages */
+
+	struct hwrm_ver_get_output	ver_resp;
+#define FW_VER_STR_LEN		32
+	char			fw_ver_str[FW_VER_STR_LEN];
+	char			hwrm_ver_supp[FW_VER_STR_LEN];
+	char			nvm_cfg_ver[FW_VER_STR_LEN];
+	u64			fw_ver_code;
+#define BNGE_FW_VER_CODE(maj, min, bld, rsv)			\
+	((u64)(maj) << 48 | (u64)(min) << 32 | (u64)(bld) << 16 | (rsv))
+
+	unsigned long           state;
+#define BNGE_STATE_DRV_REGISTERED      0
+
+	u64			fw_cap;
 };
 
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 2596215f0639..4d7b4ef1c466 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -8,6 +8,8 @@
 
 #include "bnge.h"
 #include "bnge_devlink.h"
+#include "bnge_hwrm.h"
+#include "bnge_hwrm_lib.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -37,6 +39,51 @@ static void bnge_print_device_info(struct pci_dev *pdev, enum board_idx idx)
 	pcie_print_link_status(pdev);
 }
 
+static void bnge_nvm_cfg_ver_get(struct bnge_dev *bd)
+{
+	struct hwrm_nvm_get_dev_info_output nvm_info;
+
+	if (!bnge_hwrm_nvm_dev_info(bd, &nvm_info))
+		snprintf(bd->nvm_cfg_ver, FW_VER_STR_LEN, "%d.%d.%d",
+			 nvm_info.nvm_cfg_ver_maj, nvm_info.nvm_cfg_ver_min,
+			 nvm_info.nvm_cfg_ver_upd);
+}
+
+static void bnge_fw_unregister_dev(struct bnge_dev *bd)
+{
+	bnge_hwrm_func_drv_unrgtr(bd);
+}
+
+static int bnge_fw_register_dev(struct bnge_dev *bd)
+{
+	int rc;
+
+	bd->fw_cap = 0;
+	rc = bnge_hwrm_ver_get(bd);
+	if (rc) {
+		dev_err(bd->dev, "Get Version command failed rc: %d\n", rc);
+		return rc;
+	}
+
+	bnge_nvm_cfg_ver_get(bd);
+
+	rc = bnge_hwrm_func_reset(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed to reset function rc: %d\n", rc);
+		return rc;
+	}
+
+	bnge_hwrm_fw_set_time(bd);
+
+	rc =  bnge_hwrm_func_drv_rgtr(bd);
+	if (rc) {
+		dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
 static void bnge_pci_disable(struct pci_dev *pdev)
 {
 	pci_release_regions(pdev);
@@ -126,10 +173,28 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_devl_free;
 	}
 
+	rc = bnge_init_hwrm_resources(bd);
+	if (rc)
+		goto err_bar_unmap;
+
+	rc = bnge_fw_register_dev(bd);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to register with firmware rc = %d\n", rc);
+		goto err_hwrm_cleanup;
+	}
+
+	bnge_devlink_register(bd);
+
 	pci_save_state(pdev);
 
 	return 0;
 
+err_hwrm_cleanup:
+	bnge_cleanup_hwrm_resources(bd);
+
+err_bar_unmap:
+	bnge_unmap_bars(pdev);
+
 err_devl_free:
 	bnge_devlink_free(bd);
 
@@ -142,6 +207,12 @@ static void bnge_remove_one(struct pci_dev *pdev)
 {
 	struct bnge_dev *bd = pci_get_drvdata(pdev);
 
+	bnge_devlink_unregister(bd);
+
+	bnge_fw_unregister_dev(bd);
+
+	bnge_cleanup_hwrm_resources(bd);
+
 	bnge_unmap_bars(pdev);
 
 	bnge_devlink_free(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
index d01cc32ce241..a987afebd64d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -8,6 +8,7 @@
 
 #include "bnge.h"
 #include "bnge_devlink.h"
+#include "bnge_hwrm_lib.h"
 
 static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
 			    enum bnge_dl_version_type type, const char *key,
@@ -16,6 +17,10 @@ static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
 	if (!strlen(buf))
 		return 0;
 
+	if (!strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_NCSI) ||
+	    !strcmp(key, DEVLINK_INFO_VERSION_GENERIC_FW_ROCE))
+		return 0;
+
 	switch (type) {
 	case BNGE_VERSION_FIXED:
 		return devlink_info_version_fixed_put(req, key, buf);
@@ -63,11 +68,20 @@ static void bnge_vpd_read_info(struct bnge_dev *bd)
 	kfree(vpd_data);
 }
 
+#define HWRM_FW_VER_STR_LEN	16
+
 static int bnge_devlink_info_get(struct devlink *devlink,
 				 struct devlink_info_req *req,
 				 struct netlink_ext_ack *extack)
 {
+	struct hwrm_nvm_get_dev_info_output nvm_dev_info;
 	struct bnge_dev *bd = devlink_priv(devlink);
+	struct hwrm_ver_get_output *ver_resp;
+	char mgmt_ver[FW_VER_STR_LEN];
+	char roce_ver[FW_VER_STR_LEN];
+	char ncsi_ver[FW_VER_STR_LEN];
+	char buf[32];
+
 	int rc;
 
 	if (bd->dsn) {
@@ -104,6 +118,144 @@ static int bnge_devlink_info_get(struct devlink *devlink,
 		return rc;
 	}
 
+	/* More information from HWRM ver get command */
+	sprintf(buf, "%X", bd->chip_num);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
+			      DEVLINK_INFO_VERSION_GENERIC_ASIC_ID, buf);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set asic id");
+		return rc;
+	}
+
+	ver_resp = &bd->ver_resp;
+	sprintf(buf, "%c%d", 'A' + ver_resp->chip_rev, ver_resp->chip_metal);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
+			      DEVLINK_INFO_VERSION_GENERIC_ASIC_REV, buf);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set asic info");
+		return rc;
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_PSID,
+			      bd->nvm_cfg_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set firmware version");
+		return rc;
+	}
+
+	buf[0] = 0;
+	strncat(buf, ver_resp->active_pkg_name, HWRM_FW_VER_STR_LEN);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set firmware generic version");
+		return rc;
+	}
+
+	if (ver_resp->flags & VER_GET_RESP_FLAGS_EXT_VER_AVAIL) {
+		snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->hwrm_fw_major, ver_resp->hwrm_fw_minor,
+			 ver_resp->hwrm_fw_build, ver_resp->hwrm_fw_patch);
+
+		snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->mgmt_fw_major, ver_resp->mgmt_fw_minor,
+			 ver_resp->mgmt_fw_build, ver_resp->mgmt_fw_patch);
+
+		snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->roce_fw_major, ver_resp->roce_fw_minor,
+			 ver_resp->roce_fw_build, ver_resp->roce_fw_patch);
+	} else {
+		snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->hwrm_fw_maj_8b, ver_resp->hwrm_fw_min_8b,
+			 ver_resp->hwrm_fw_bld_8b, ver_resp->hwrm_fw_rsvd_8b);
+
+		snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->mgmt_fw_maj_8b, ver_resp->mgmt_fw_min_8b,
+			 ver_resp->mgmt_fw_bld_8b, ver_resp->mgmt_fw_rsvd_8b);
+
+		snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+			 ver_resp->roce_fw_maj_8b, ver_resp->roce_fw_min_8b,
+			 ver_resp->roce_fw_bld_8b, ver_resp->roce_fw_rsvd_8b);
+	}
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, mgmt_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set firmware mgmt version");
+		return rc;
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+			      bd->hwrm_ver_supp);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set firmware mgmt api version");
+		return rc;
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_NCSI, ncsi_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set ncsi firmware version");
+		return rc;
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_RUNNING,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_ROCE, roce_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set roce firmware version");
+		return rc;
+	}
+
+	rc = bnge_hwrm_nvm_dev_info(bd, &nvm_dev_info);
+	if (!(nvm_dev_info.flags & NVM_GET_DEV_INFO_RESP_FLAGS_FW_VER_VALID))
+		return 0;
+
+	buf[0] = 0;
+	strncat(buf, nvm_dev_info.pkg_name, HWRM_FW_VER_STR_LEN);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
+			      DEVLINK_INFO_VERSION_GENERIC_FW, buf);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set roce firmware version");
+		return rc;
+	}
+
+	snprintf(mgmt_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+		 nvm_dev_info.hwrm_fw_major, nvm_dev_info.hwrm_fw_minor,
+		 nvm_dev_info.hwrm_fw_build, nvm_dev_info.hwrm_fw_patch);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, mgmt_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set stored firmware version");
+		return rc;
+	}
+
+	snprintf(ncsi_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+		 nvm_dev_info.mgmt_fw_major, nvm_dev_info.mgmt_fw_minor,
+		 nvm_dev_info.mgmt_fw_build, nvm_dev_info.mgmt_fw_patch);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_NCSI, ncsi_ver);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set stored ncsi firmware version");
+		return rc;
+	}
+
+	snprintf(roce_ver, FW_VER_STR_LEN, "%d.%d.%d.%d",
+		 nvm_dev_info.roce_fw_major, nvm_dev_info.roce_fw_minor,
+		 nvm_dev_info.roce_fw_build, nvm_dev_info.roce_fw_patch);
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_STORED,
+			      DEVLINK_INFO_VERSION_GENERIC_FW_ROCE, roce_ver);
+	if (rc)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to set stored roce firmware version");
+
 	return rc;
 }
 
@@ -140,3 +292,15 @@ struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev)
 
 	return bd;
 }
+
+void bnge_devlink_register(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+	devlink_register(devlink);
+}
+
+void bnge_devlink_unregister(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+	devlink_unregister(devlink);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
index 497543918741..c6575255e650 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
@@ -12,5 +12,7 @@ enum bnge_dl_version_type {
 
 void bnge_devlink_free(struct bnge_dev *bd);
 struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev);
+void bnge_devlink_register(struct bnge_dev *bd);
+void bnge_devlink_unregister(struct bnge_dev *bd);
 
 #endif /* _BNGE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
new file mode 100644
index 000000000000..25ac73ac37ba
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+
+#include "bnge.h"
+#include "../bnxt/bnxt_hsi.h"
+#include "bnge_hwrm.h"
+#include "bnge_hwrm_lib.h"
+
+int bnge_hwrm_ver_get(struct bnge_dev *bd)
+{
+	u32 dev_caps_cfg, hwrm_ver, hwrm_spec_code;
+	u16 fw_maj, fw_min, fw_bld, fw_rsv;
+	struct hwrm_ver_get_output *resp;
+	struct hwrm_ver_get_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VER_GET);
+	if (rc)
+		return rc;
+
+	bnge_hwrm_req_flags(bd, req, BNGE_HWRM_FULL_WAIT);
+	bd->hwrm_max_req_len = HWRM_MAX_REQ_LEN;
+	req->hwrm_intf_maj = HWRM_VERSION_MAJOR;
+	req->hwrm_intf_min = HWRM_VERSION_MINOR;
+	req->hwrm_intf_upd = HWRM_VERSION_UPDATE;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto hwrm_ver_get_exit;
+
+	memcpy(&bd->ver_resp, resp, sizeof(struct hwrm_ver_get_output));
+
+	hwrm_spec_code = resp->hwrm_intf_maj_8b << 16 |
+			 resp->hwrm_intf_min_8b << 8 |
+			 resp->hwrm_intf_upd_8b;
+	hwrm_ver = HWRM_VERSION_MAJOR << 16 | HWRM_VERSION_MINOR << 8 |
+			HWRM_VERSION_UPDATE;
+
+	if (hwrm_spec_code > hwrm_ver)
+		snprintf(bd->hwrm_ver_supp, FW_VER_STR_LEN, "%d.%d.%d",
+			 HWRM_VERSION_MAJOR, HWRM_VERSION_MINOR,
+			 HWRM_VERSION_UPDATE);
+	else
+		snprintf(bd->hwrm_ver_supp, FW_VER_STR_LEN, "%d.%d.%d",
+			 resp->hwrm_intf_maj_8b, resp->hwrm_intf_min_8b,
+			 resp->hwrm_intf_upd_8b);
+
+	fw_maj = le16_to_cpu(resp->hwrm_fw_major);
+	fw_min = le16_to_cpu(resp->hwrm_fw_minor);
+	fw_bld = le16_to_cpu(resp->hwrm_fw_build);
+	fw_rsv = le16_to_cpu(resp->hwrm_fw_patch);
+
+	bd->fw_ver_code = BNGE_FW_VER_CODE(fw_maj, fw_min, fw_bld, fw_rsv);
+	snprintf(bd->fw_ver_str, FW_VER_STR_LEN, "%d.%d.%d.%d",
+		 fw_maj, fw_min, fw_bld, fw_rsv);
+
+	if (strlen(resp->active_pkg_name)) {
+		int fw_ver_len = strlen(bd->fw_ver_str);
+
+		snprintf(bd->fw_ver_str + fw_ver_len,
+			 FW_VER_STR_LEN - fw_ver_len - 1, "/pkg %s",
+			 resp->active_pkg_name);
+		bd->fw_cap |= BNGE_FW_CAP_PKG_VER;
+	}
+
+	bd->hwrm_cmd_timeout = le16_to_cpu(resp->def_req_timeout);
+	if (!bd->hwrm_cmd_timeout)
+		bd->hwrm_cmd_timeout = BNGE_DFLT_HWRM_CMD_TIMEOUT;
+	bd->hwrm_cmd_max_timeout = le16_to_cpu(resp->max_req_timeout) * 1000;
+	if (!bd->hwrm_cmd_max_timeout)
+		bd->hwrm_cmd_max_timeout = BNGE_HWRM_CMD_MAX_TIMEOUT;
+	else if (bd->hwrm_cmd_max_timeout > BNGE_HWRM_CMD_MAX_TIMEOUT)
+		dev_warn(bd->dev, "Default HWRM commands max timeout increased to %d seconds\n",
+			 bd->hwrm_cmd_max_timeout / 1000);
+
+	bd->hwrm_max_req_len = le16_to_cpu(resp->max_req_win_len);
+	bd->hwrm_max_ext_req_len = le16_to_cpu(resp->max_ext_req_len);
+
+	if (bd->hwrm_max_ext_req_len < HWRM_MAX_REQ_LEN)
+		bd->hwrm_max_ext_req_len = HWRM_MAX_REQ_LEN;
+
+	bd->chip_num = le16_to_cpu(resp->chip_num);
+	bd->chip_rev = resp->chip_rev;
+
+	dev_caps_cfg = le32_to_cpu(resp->dev_caps_cfg);
+	if ((dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_SUPPORTED) &&
+	    (dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_REQUIRED))
+		bd->fw_cap |= BNGE_FW_CAP_SHORT_CMD;
+
+	if (dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_KONG_MB_CHNL_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_KONG_MB_CHNL;
+
+	if (dev_caps_cfg &
+	    VER_GET_RESP_DEV_CAPS_CFG_CFA_ADV_FLOW_MGNT_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_CFA_ADV_FLOW;
+
+hwrm_ver_get_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int
+bnge_hwrm_nvm_dev_info(struct bnge_dev *bd,
+		       struct hwrm_nvm_get_dev_info_output *nvm_info)
+{
+	struct hwrm_nvm_get_dev_info_output *resp;
+	struct hwrm_nvm_get_dev_info_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_NVM_GET_DEV_INFO);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		memcpy(nvm_info, resp, sizeof(*resp));
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_func_reset(struct bnge_dev *bd)
+{
+	struct hwrm_func_reset_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_RESET);
+	if (rc)
+		return rc;
+
+	req->enables = 0;
+	bnge_hwrm_req_timeout(bd, req, BNGE_HWRM_RESET_TIMEOUT);
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_hwrm_fw_set_time(struct bnge_dev *bd)
+{
+	struct hwrm_fw_set_time_input *req;
+	struct tm tm;
+	int rc;
+
+	time64_to_tm(ktime_get_real_seconds(), 0, &tm);
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FW_SET_TIME);
+	if (rc)
+		return rc;
+
+	req->year = cpu_to_le16(1900 + tm.tm_year);
+	req->month = 1 + tm.tm_mon;
+	req->day = tm.tm_mday;
+	req->hour = tm.tm_hour;
+	req->minute = tm.tm_min;
+	req->second = tm.tm_sec;
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
+{
+	struct hwrm_func_drv_rgtr_output *resp;
+	struct hwrm_func_drv_rgtr_input *req;
+	u32 flags;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
+	if (rc)
+		return rc;
+
+	req->enables = cpu_to_le32(FUNC_DRV_RGTR_REQ_ENABLES_OS_TYPE |
+				   FUNC_DRV_RGTR_REQ_ENABLES_VER |
+				   FUNC_DRV_RGTR_REQ_ENABLES_ASYNC_EVENT_FWD);
+
+	req->os_type = cpu_to_le16(FUNC_DRV_RGTR_REQ_OS_TYPE_LINUX);
+	flags = FUNC_DRV_RGTR_REQ_FLAGS_16BIT_VER_MODE;
+
+	req->flags = cpu_to_le32(flags);
+	req->ver_maj_8b = DRV_VER_MAJ;
+	req->ver_min_8b = DRV_VER_MIN;
+	req->ver_upd_8b = DRV_VER_UPD;
+	req->ver_maj = cpu_to_le16(DRV_VER_MAJ);
+	req->ver_min = cpu_to_le16(DRV_VER_MIN);
+	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc) {
+		set_bit(BNGE_STATE_DRV_REGISTERED, &bd->state);
+		if (resp->flags &
+		    cpu_to_le32(FUNC_DRV_RGTR_RESP_FLAGS_IF_CHANGE_SUPPORTED))
+			bd->fw_cap |= BNGE_FW_CAP_IF_CHANGE;
+	}
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd)
+{
+	struct hwrm_func_drv_unrgtr_input *req;
+	int rc;
+
+	if (!test_and_clear_bit(BNGE_STATE_DRV_REGISTERED, &bd->state))
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_UNRGTR);
+	if (rc)
+		return rc;
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
new file mode 100644
index 000000000000..9308d4fe64d2
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_HWRM_LIB_H_
+#define _BNGE_HWRM_LIB_H_
+
+int bnge_hwrm_ver_get(struct bnge_dev *bd);
+int bnge_hwrm_func_reset(struct bnge_dev *bd);
+int bnge_hwrm_fw_set_time(struct bnge_dev *bd);
+int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd);
+int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd);
+int bnge_hwrm_vnic_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_nvm_dev_info(struct bnge_dev *bd,
+			   struct hwrm_nvm_get_dev_info_output *nvm_dev_info);
+
+#endif /* _BNGE_HWRM_LIB_H_ */
-- 
2.47.1


