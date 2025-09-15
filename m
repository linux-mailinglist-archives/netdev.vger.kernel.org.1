Return-Path: <netdev+bounces-223167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF2B5814F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343071894C70
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B623E354;
	Mon, 15 Sep 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVzlkNNL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6823D7DA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951600; cv=none; b=hPac2xGmkDTvPu88EfELff2rYWFPSh9M1WQlx0U/tWov+ZQBUhp7qgMgMYRkF7qkye0/0OJi99So3tyA7eA2GXVR7MSz2RVmLDkYuxoRHKCHPgQMQ8F7jZWYGfeGF8S/YYywwqZm/FqeUkbLYZ1BxcYiKh0iswAKi9T5r91VPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951600; c=relaxed/simple;
	bh=xsjTqcwM/djTgLHzr7RnNNviX2OVJ9di352PlkKcfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l++n5o1CQbRuetIoYLyPRvdEDjJpuMH5cP53/nG3/czxaRqfNTCYHBkrmHcTUg9O89jbciZdzMb9sTWEHPsaxIsublymGNiEvZyJ6Yg0NVfN1nhlgpPSVSOyOB7bselSCTLBhRJFjU8nxX6IavElxymIxPb66rruCBeWQ1fO/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVzlkNNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAA2C113CF;
	Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951600;
	bh=xsjTqcwM/djTgLHzr7RnNNviX2OVJ9di352PlkKcfxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVzlkNNLbXf9M0N3sw5WUwCeIkxKQnyvtEqgKhfs/phkGPLBPGCjZNB/gUsv7e41Q
	 V5DpHqs6bkMRgQcZYSHai/eFJGOq3JvYEo8bZ7IdDmhQTTaf0UVjYsKQznx40IXpEF
	 2PTtl5NKl2hIz8iqEysnr0JxRXcMf1Ro5VbhtC2p47dgHBr+zQllr4bUGq1ulWGf/g
	 vrl/GEdRep01ZiF1ftnAbd+R2onLKL+6A8flal3YaQGyzGbNHYTtRhTB/d1Pi9rvuB
	 p9SpNrftq1ZgBF8QG4DL5iNdKIG9Uw3aHz+RgaaiPkVr2vv1/Feg1+0pIbMzoLlvpK
	 hzj/Akv7HuKVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 9/9] eth: fbnic: add OTP health reporter
Date: Mon, 15 Sep 2025 08:53:12 -0700
Message-ID: <20250915155312.1083292-10-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OTP memory ("fuses") are used for secure boot and anti-rollback
protection. The OTP memory is ECC protected. Check for its health
periodically to notice when the chip is starting to go bad.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 18 +++++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 65 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  5 ++
 5 files changed, 97 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 3c81b58d8292..5d364832f814 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -81,6 +81,13 @@ happened since power cycle - a snapshot of the FW memory. Diagnose callback
 shows current FW uptime (the crashes are detected by checking if uptime
 goes down).
 
+otp reporter
+~~~~~~~~~~~~
+
+OTP memory ("fuses") are used for secure boot and anti-rollback
+protection. The OTP memory is ECC protected, ECC errors indicate
+either manufacturing defect or part deteriorating with age.
+
 Statistics
 ----------
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 5f99976de0bb..b03e5a3d5144 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -28,6 +28,7 @@ struct fbnic_dev {
 	struct dentry *dbg_fbd;
 	struct device *hwmon;
 	struct devlink_health_reporter *fw_reporter;
+	struct devlink_health_reporter *otp_reporter;
 
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -166,6 +167,7 @@ void fbnic_devlink_register(struct fbnic_dev *fbd);
 void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 void __printf(2, 3)
 fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...);
+void fbnic_devlink_otp_check(struct fbnic_dev *fbd, const char *msg);
 
 int fbnic_fw_request_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index e2fffe1597e9..d3a7ad921f18 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -1178,4 +1178,22 @@ enum {
 #define FBNIC_IPC_MBX_DESC_FW_CMPL	DESC_BIT(1)
 #define FBNIC_IPC_MBX_DESC_HOST_CMPL	DESC_BIT(0)
 
+/* OTP Registers
+ * These registers are accessible via bar4 offset and are written by CMRT
+ * on boot. For the write status, the register is broken up in half with OTP
+ * Write Data Status occupying the top 16 bits and the ECC status occupying the
+ * bottom 16 bits.
+ */
+#define FBNIC_NS_OTP_STATUS		0x0021d
+#define FBNIC_NS_OTP_WRITE_STATUS	0x0021e
+
+#define FBNIC_NS_OTP_WRITE_DATA_STATUS_MASK	CSR_GENMASK(31, 16)
+#define FBNIC_NS_OTP_WRITE_ECC_STATUS_MASK	CSR_GENMASK(15, 0)
+
+#define FBNIC_REGS_VERSION			CSR_GENMASK(31, 16)
+#define FBNIC_REGS_HW_TYPE			CSR_GENMASK(15, 8)
+enum{
+	FBNIC_CSR_VERSION_V1_0_ASIC = 1,
+};
+
 #endif /* _FBNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index f3f3585c0aac..227236d0676c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -520,6 +520,60 @@ static const struct devlink_health_reporter_ops fbnic_fw_ops = {
 	.diagnose = fbnic_fw_reporter_diagnose,
 };
 
+static u32 fbnic_read_otp_status(struct fbnic_dev *fbd)
+{
+	return fbnic_fw_rd32(fbd, FBNIC_NS_OTP_STATUS);
+}
+
+static int
+fbnic_otp_reporter_dump(struct devlink_health_reporter *reporter,
+			struct devlink_fmsg *fmsg, void *priv_ctx,
+			struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
+	u32 otp_status, otp_write_status, m;
+
+	otp_status = fbnic_read_otp_status(fbd);
+	otp_write_status = fbnic_fw_rd32(fbd, FBNIC_NS_OTP_WRITE_STATUS);
+
+	/* Dump OTP status */
+	devlink_fmsg_pair_nest_start(fmsg, "OTP");
+	devlink_fmsg_obj_nest_start(fmsg);
+
+	devlink_fmsg_u32_pair_put(fmsg, "Status", otp_status);
+
+	/* Extract OTP Write Data status */
+	m = FBNIC_NS_OTP_WRITE_DATA_STATUS_MASK;
+	devlink_fmsg_u32_pair_put(fmsg, "Data",
+				  FIELD_GET(m, otp_write_status));
+
+	/* Extract OTP Write ECC status */
+	m = FBNIC_NS_OTP_WRITE_ECC_STATUS_MASK;
+	devlink_fmsg_u32_pair_put(fmsg, "ECC",
+				  FIELD_GET(m, otp_write_status));
+
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+
+	return 0;
+}
+
+void fbnic_devlink_otp_check(struct fbnic_dev *fbd, const char *msg)
+{
+	/* Check if there is anything to report */
+	if (!fbnic_read_otp_status(fbd))
+		return;
+
+	devlink_health_report(fbd->otp_reporter, msg, fbd);
+	if (fbnic_fw_log_ready(fbd))
+		fbnic_fw_log_write(fbd, 0, fbd->firmware_time, msg);
+}
+
+static const struct devlink_health_reporter_ops fbnic_otp_ops = {
+	.name = "otp",
+	.dump = fbnic_otp_reporter_dump,
+};
+
 int fbnic_devlink_health_create(struct fbnic_dev *fbd)
 {
 	fbd->fw_reporter = devlink_health_reporter_create(priv_to_devlink(fbd),
@@ -531,11 +585,22 @@ int fbnic_devlink_health_create(struct fbnic_dev *fbd)
 		return PTR_ERR(fbd->fw_reporter);
 	}
 
+	fbd->otp_reporter = devlink_health_reporter_create(priv_to_devlink(fbd),
+							   &fbnic_otp_ops, fbd);
+	if (IS_ERR(fbd->otp_reporter)) {
+		devlink_health_reporter_destroy(fbd->fw_reporter);
+		dev_warn(fbd->dev,
+			 "Failed to create OTP fault reporter: %pe\n",
+			 fbd->otp_reporter);
+		return PTR_ERR(fbd->otp_reporter);
+	}
+
 	return 0;
 }
 
 void fbnic_devlink_health_destroy(struct fbnic_dev *fbd)
 {
+	devlink_health_reporter_destroy(fbd->otp_reporter);
 	devlink_health_reporter_destroy(fbd->fw_reporter);
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e71be857d692..c934fb00ee64 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -197,6 +197,7 @@ static void fbnic_health_check(struct fbnic_dev *fbd)
 		return;
 
 	fbnic_devlink_fw_report(fbd, "Firmware crashed detected!");
+	fbnic_devlink_otp_check(fbd, "error detected after firmware recovery");
 
 	if (fbnic_fw_config_after_crash(fbd))
 		dev_err(fbd->dev, "Firmware recovery failed after crash\n");
@@ -322,6 +323,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			 err);
 
 	fbnic_devlink_register(fbd);
+	fbnic_devlink_otp_check(fbd, "error detected during probe");
 	fbnic_dbg_fbd_init(fbd);
 
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
@@ -475,6 +477,9 @@ static int __fbnic_pm_resume(struct device *dev)
 	 */
 	fbnic_fw_log_enable(fbd, list_empty(&fbd->fw_log.entries));
 
+	/* Since the FW should be up, check if it reported OTP errors */
+	fbnic_devlink_otp_check(fbd, "error detected after PM resume");
+
 	/* No netdev means there isn't a network interface to bring up */
 	if (fbnic_init_failure(fbd))
 		return 0;
-- 
2.51.0


