Return-Path: <netdev+bounces-223165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E1B5814B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEDC1894040
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8115923B604;
	Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWErPwa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59214239E9B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951599; cv=none; b=gt0hWcrC9L0ReZnMPNT2EkjTUSmn509EwtU6rBrdnBgpVhiZWLfj8RXhl4VvCyGQL8nVLVDkVKgwHtYJJH5oe4wPkNw4cBZlCRCezXmCL4b6M5syA13INjPNBG7S0kYz9wyhW3iXBxcuutrBRREFIW70atErPTequ6Nwl0jwltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951599; c=relaxed/simple;
	bh=noqzWmwLgxpRbJyfZRusCPih67MNRbIYicbG6V5Q8co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s83/t/QvXNFJYwBhN+OBoawUpUzGTykGwts2LkLR/48+ZdFS623lJYNudTTnWbrOwe+DXVRqT2TR6lnlVeHFP+j/aeGlHjELmL/7aLCnxkhVF8LcgzXTls+Pb05XjSc+Us3KZH43YqJBzU2mELWNu+mbSdOkvhj7nRgKNd+kCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWErPwa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9EDC4AF09;
	Mon, 15 Sep 2025 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951598;
	bh=noqzWmwLgxpRbJyfZRusCPih67MNRbIYicbG6V5Q8co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWErPwa8QjsAf1MEff4PV6vKb5LXXbqg62wLK7z8pASH2EEnX8urAH5nQ5JKJennN
	 KCPcy7t0XWyGZCq4tcbalSvb3A3KSMxZicxsmGDRyKMgrDkm/4NYDZX19qnn6EKKXr
	 HHzJhAlmywKIHas3E6/HCnmB2L+l1YXqXBfEyge/mmjjXCyV2CCrBIoj2EP3ho4Ck4
	 ECA4Tw5JGRGinl5ph9up4a3OtJbRyIS8iT97e9nxOBmn2KWOIYI3owfzxxdSvA1kqA
	 tUOfDnwuo+ikY8dMIVPc+heDuT5XtWKuSaCCJhjF3iWlJ+nmd8RXuqFjRnWVFK0U6M
	 Fpo2I+sYcViAQ==
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
Subject: [PATCH net-next v2 7/9] eth: fbnic: add FW health reporter
Date: Mon, 15 Sep 2025 08:53:10 -0700
Message-ID: <20250915155312.1083292-8-kuba@kernel.org>
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

Add a health reporter to catch FW crashes. Dumping the reporter
if FW has not crashed will create a snapshot of FW memory.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  10 ++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   5 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 157 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  11 +-
 4 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index fb6559fa4be4..62693566ff1f 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -69,6 +69,16 @@ On host boot the latest UEFI driver is always used, no explicit activation
 is required. Firmware activation is required to run new control firmware. cmrt
 firmware can only be activated by power cycling the NIC.
 
+Health reporters
+----------------
+
+fw reporter
+~~~~~~~~~~~
+
+The ``fw`` health reporter tracks FW crashes. Dumping the reporter will
+show the core dump of the most recent FW crash, and if no FW crash has
+happened since power cycle - a snapshot of the FW memory.
+
 Statistics
 ----------
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index b364c2f0724b..5f99976de0bb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -27,6 +27,7 @@ struct fbnic_dev {
 	struct net_device *netdev;
 	struct dentry *dbg_fbd;
 	struct device *hwmon;
+	struct devlink_health_reporter *fw_reporter;
 
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -159,8 +160,12 @@ extern char fbnic_driver_name[];
 
 void fbnic_devlink_free(struct fbnic_dev *fbd);
 struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev);
+int fbnic_devlink_health_create(struct fbnic_dev *fbd);
+void fbnic_devlink_health_destroy(struct fbnic_dev *fbd);
 void fbnic_devlink_register(struct fbnic_dev *fbd);
 void fbnic_devlink_unregister(struct fbnic_dev *fbd);
+void __printf(2, 3)
+fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...);
 
 int fbnic_fw_request_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_free_mbx(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index c5f81f139e7e..0e8920685da6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -8,6 +8,7 @@
 #include <net/devlink.h>
 
 #include "fbnic.h"
+#include "fbnic_fw.h"
 #include "fbnic_tlv.h"
 
 #define FBNIC_SN_STR_LEN	24
@@ -369,6 +370,162 @@ static const struct devlink_ops fbnic_devlink_ops = {
 	.flash_update	= fbnic_devlink_flash_update,
 };
 
+static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
+				  struct devlink_fmsg *fmsg, void *priv_ctx,
+				  struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_health_reporter_priv(reporter);
+	u32 offset, index, index_count, length, size;
+	struct fbnic_fw_completion *fw_cmpl;
+	u8 *dump_data, **data;
+	int err;
+
+	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_COREDUMP_GET_INFO_RESP);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	err = fbnic_fw_xmit_coredump_info_msg(fbd, fw_cmpl, true);
+	if (err) {
+		dev_err(fbd->dev,
+			"Failed to transmit core dump info msg: %d\n", err);
+		goto cmpl_free;
+	}
+	if (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+		dev_err(fbd->dev, "Timed out waiting on core dump info\n");
+		err = -ETIMEDOUT;
+		goto cmpl_cleanup;
+	}
+
+	size = fw_cmpl->u.coredump_info.size;
+	err = fw_cmpl->result;
+
+	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
+	fbnic_fw_put_cmpl(fw_cmpl);
+
+	/* Handle error returned by firmware */
+	if (err) {
+		if (err == -ETIMEDOUT)
+			dev_info(fbd->dev, "Firmware timed out on core dump\n");
+		else
+			dev_err(fbd->dev,
+				"Firmware core dump returned error: %d\n", err);
+		return err;
+	}
+	if (!size) {
+		dev_err(fbd->dev, "Firmware core dump returned size 0\n");
+		return -EIO;
+	}
+
+	/* Read the dump, we can only transfer TLV_MAX_DATA at a time */
+	index_count = DIV_ROUND_UP(size, TLV_MAX_DATA);
+
+	fw_cmpl = __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_COREDUMP_READ_RESP,
+					sizeof(void *) * index_count + size);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	/* Populate pointer table w/ pointer offsets */
+	dump_data = (void *)&fw_cmpl->u.coredump.data[index_count];
+	data = fw_cmpl->u.coredump.data;
+	fw_cmpl->u.coredump.size = size;
+	fw_cmpl->u.coredump.stride = TLV_MAX_DATA;
+
+	for (index = 0; index < index_count; index++) {
+		/* First iteration installs completion */
+		struct fbnic_fw_completion *cmpl_arg = index ? NULL : fw_cmpl;
+
+		offset = index * TLV_MAX_DATA;
+		length = min(size - offset, TLV_MAX_DATA);
+
+		data[index] = dump_data + offset;
+		err = fbnic_fw_xmit_coredump_read_msg(fbd, cmpl_arg,
+						      offset, length);
+		if (err) {
+			dev_err(fbd->dev, "Failed to transmit core dump msg: %d\n",
+				err);
+			if (cmpl_arg)
+				goto cmpl_free;
+			else
+				goto cmpl_cleanup;
+		}
+
+		if (wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
+			reinit_completion(&fw_cmpl->done);
+		} else {
+			dev_err(fbd->dev,
+				"Timed out waiting on core dump (%d/%d)\n",
+				index + 1, index_count);
+			err = -ETIMEDOUT;
+			goto cmpl_cleanup;
+		}
+
+		/* If we didn't see the reply record as incomplete */
+		if (fw_cmpl->u.coredump.data[index]) {
+			dev_err(fbd->dev,
+				"No data for core dump chunk (%d/%d)\n",
+				index + 1, index_count);
+			err = -EIO;
+			goto cmpl_cleanup;
+		}
+	}
+
+	devlink_fmsg_binary_pair_nest_start(fmsg, "FW coredump");
+
+	for (offset = 0; offset < size; offset += length) {
+		length = min_t(u32, size - offset, TLV_MAX_DATA);
+
+		devlink_fmsg_binary_put(fmsg, dump_data + offset, length);
+	}
+
+	devlink_fmsg_binary_pair_nest_end(fmsg);
+
+cmpl_cleanup:
+	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
+cmpl_free:
+	fbnic_fw_put_cmpl(fw_cmpl);
+
+	return err;
+}
+
+void __printf(2, 3)
+fbnic_devlink_fw_report(struct fbnic_dev *fbd, const char *format, ...)
+{
+	char msg[FBNIC_FW_LOG_MAX_SIZE];
+	va_list args;
+
+	va_start(args, format);
+	vsnprintf(msg, FBNIC_FW_LOG_MAX_SIZE, format, args);
+	va_end(args);
+
+	devlink_health_report(fbd->fw_reporter, msg, fbd);
+	if (fbnic_fw_log_ready(fbd))
+		fbnic_fw_log_write(fbd, 0, fbd->firmware_time, msg);
+}
+
+static const struct devlink_health_reporter_ops fbnic_fw_ops = {
+	.name = "fw",
+	.dump = fbnic_fw_reporter_dump,
+};
+
+int fbnic_devlink_health_create(struct fbnic_dev *fbd)
+{
+	fbd->fw_reporter = devlink_health_reporter_create(priv_to_devlink(fbd),
+							  &fbnic_fw_ops, fbd);
+	if (IS_ERR(fbd->fw_reporter)) {
+		dev_warn(fbd->dev,
+			 "Failed to create FW fault reporter: %pe\n",
+			 fbd->fw_reporter);
+		return PTR_ERR(fbd->fw_reporter);
+	}
+
+	return 0;
+}
+
+void fbnic_devlink_health_destroy(struct fbnic_dev *fbd)
+{
+	devlink_health_reporter_destroy(fbd->fw_reporter);
+}
+
 void fbnic_devlink_free(struct fbnic_dev *fbd)
 {
 	struct devlink *devlink = priv_to_devlink(fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 53690db14d77..e71be857d692 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -196,6 +196,8 @@ static void fbnic_health_check(struct fbnic_dev *fbd)
 	if (tx_mbx->head != tx_mbx->tail)
 		return;
 
+	fbnic_devlink_fw_report(fbd, "Firmware crashed detected!");
+
 	if (fbnic_fw_config_after_crash(fbd))
 		dev_err(fbd->dev, "Firmware recovery failed after crash\n");
 }
@@ -279,6 +281,10 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 	}
 
+	err = fbnic_devlink_health_create(fbd);
+	if (err)
+		goto free_fbd;
+
 	/* Populate driver with hardware-specific info and handlers */
 	fbd->max_num_queues = info->max_num_queues;
 
@@ -289,7 +295,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = fbnic_alloc_irqs(fbd);
 	if (err)
-		goto free_fbd;
+		goto err_destroy_health;
 
 	err = fbnic_mac_init(fbd);
 	if (err) {
@@ -358,6 +364,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 free_irqs:
 	fbnic_free_irqs(fbd);
+err_destroy_health:
+	fbnic_devlink_health_destroy(fbd);
 free_fbd:
 	fbnic_devlink_free(fbd);
 
@@ -392,6 +400,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 	fbnic_fw_free_mbx(fbd);
 	fbnic_free_irqs(fbd);
 
+	fbnic_devlink_health_destroy(fbd);
 	fbnic_devlink_free(fbd);
 }
 
-- 
2.51.0


