Return-Path: <netdev+bounces-143646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD399C3784
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403BC1C20BFF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756FB78289;
	Mon, 11 Nov 2024 04:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495EEC5;
	Mon, 11 Nov 2024 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299598; cv=none; b=Tf+r6ZOq62uNLcfkBPfEBjqMolC6sljZ887uH+nfbLgjkYasYAn6+JC20U4jTAxXgVaPwMd75Ak1RH3N5urGJdbpNyjCGpEhhh+hC1vAVzvAxujGG3he28UC3t71z2f+fAMN408fFgXwM8muV4gbmUs0dqid/9/3bnLKXnw9WDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299598; c=relaxed/simple;
	bh=6Z+AxkKR9zlrGHBwt2JjK+ih49DyBUV8ksoi07TJ5Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chkSfUwfery1nwP3c46BMy/R4AVfWc/GoMw+eKZRv7wRI6VtuT2kOSSpn5eUaaqZcCkAXeaBHAlyOyWgILQjRRCZpvTicIy93i9xYlgWaU6CT0S4be7Iloc5Ixx9smhRDGyEH74gX+sb6c/n7T5c6cXD/UWtoSYyi3Xq2Pl6cEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1tAM6u-0003L1-DF; Mon, 11 Nov 2024 04:33:08 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lee Trager <lee@trager.us>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] eth: fbnic: Add devlink dev flash support
Date: Sun, 10 Nov 2024 20:28:42 -0800
Message-ID: <20241111043058.1251632-3-lee@trager.us>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241111043058.1251632-1-lee@trager.us>
References: <20241111043058.1251632-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic supports updating firmware using a PLDM image signed and distributed
by Meta. PLDM images are written into stored flashed. Flashing does not
interrupt operation.

On host reboot the newly flashed UEFI driver will be used. To run new
control or cmrt firmware the NIC must be power cycled.

Signed-off-by: Lee Trager <lee@trager.us>
---
 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 drivers/net/ethernet/meta/Kconfig             |   1 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 269 +++++++++++++++++-
 3 files changed, 280 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 32ff114f5c26..d6726c254818 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -27,3 +27,14 @@ driver takes over.
 devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.
+
+Upgrading Firmware
+------------------
+
+fbnic supports upgrading firmware using devlink dev flash. Firmware images
+are signed and distributed by Meta. All firmware is bundled into a single
+PLDM image which is written into stored flash. Flashing firmware does not
+interrupt operation.
+
+On host reboot the newly flashed UEFI driver will be used. To run new control
+or cmrt firmware the NIC must be power cycled.
diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index 831921b9d4d5..3ba527514f1e 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -27,6 +27,7 @@ config FBNIC
 	select NET_DEVLINK
 	select PAGE_POOL
 	select PHYLINK
+	select PLDMFW
 	help
 	  This driver supports Meta Platforms Host Network Interface.

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index 0072d612215e..bd718b3e314b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -3,6 +3,7 @@

 #include <linux/unaligned.h>
 #include <linux/pci.h>
+#include <linux/pldmfw.h>
 #include <linux/types.h>
 #include <net/devlink.h>

@@ -109,8 +110,274 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
 	return 0;
 }

+/**
+ * fbnic_send_package_data - Send record package data to firmware
+ * @context: PLDM FW update structure
+ * @data: pointer to the package data
+ * @length: length of the package data
+ *
+ * Send a copy of the package data associated with the PLDM record matching
+ * this device to the firmware.
+ *
+ * Return: zero on success
+ *	    negative error code on failure
+ */
+static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
+				   u16 length)
+{
+	struct device *dev = context->dev;
+
+	/* Temp placeholder required by devlink */
+	dev_info(dev,
+		 "Sending %u bytes of PLDM record package data to firmware\n",
+		 length);
+
+	return 0;
+}
+
+/**
+ * fbnic_send_component_table - Send PLDM component table to the firmware
+ * @context: PLDM FW update structure
+ * @component: The component to send
+ * @transfer_flag: Flag indication location in component tables
+ *
+ * Read relevant data from component table and forward it to the firmware.
+ * Check response to verify if the firmware indicates that it wishes to
+ * proceed with the update.
+ *
+ * Return: zero on success
+ *	    negative error code on failure
+ */
+static int fbnic_send_component_table(struct pldmfw *context,
+				      struct pldmfw_component *component,
+				      u8 transfer_flag)
+{
+	struct device *dev = context->dev;
+	u16 id = component->identifier;
+	u8 test_string[80];
+
+	switch (id) {
+	case QSPI_SECTION_CMRT:
+	case QSPI_SECTION_CONTROL_FW:
+	case QSPI_SECTION_OPTION_ROM:
+		break;
+	default:
+		dev_err(dev, "Unknown component ID %u\n", id);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Sending PLDM component table to firmware\n");
+
+	/* Temp placeholder */
+	strscpy(test_string, component->version_string,
+		min_t(u8, component->version_len, 79));
+	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
+		 id, test_string);
+
+	return 0;
+}
+
+/**
+ * fbnic_flash_component - Flash a component of the QSPI
+ * @context: PLDM FW update structure
+ * @component: The component table to send to FW
+ *
+ * Map contents of component and make it available for FW to download
+ * so that it can update the contents of the QSPI Flash.
+ *
+ * Return: zero on success
+ *	    negative error code on failure
+ */
+static int fbnic_flash_component(struct pldmfw *context,
+				 struct pldmfw_component *component)
+{
+	const u8 *data = component->component_data;
+	u32 size = component->component_size;
+	struct fbnic_fw_completion *fw_cmpl;
+	struct device *dev = context->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 id = component->identifier;
+	const char *component_name;
+	int retries = 2;
+	int err;
+
+	struct devlink *devlink;
+	struct fbnic_dev *fbd;
+
+	switch (id) {
+	case QSPI_SECTION_CMRT:
+		component_name = "boot1";
+		break;
+	case QSPI_SECTION_CONTROL_FW:
+		component_name = "boot2";
+		break;
+	case QSPI_SECTION_OPTION_ROM:
+		component_name = "option-rom";
+		break;
+	default:
+		dev_err(dev, "Unknown component ID %u\n", id);
+		return -EINVAL;
+	}
+
+	fw_cmpl = kzalloc(sizeof(*fw_cmpl), GFP_KERNEL);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	pdev = to_pci_dev(dev);
+	fbd = pci_get_drvdata(pdev);
+	devlink = priv_to_devlink(fbd);
+
+	/* Initialize completion and queue it for FW to process */
+	fw_cmpl->msg_type = FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ;
+	init_completion(&fw_cmpl->done);
+
+	fw_cmpl->fw_update.last_offset = 0;
+	fw_cmpl->fw_update.data = data;
+	fw_cmpl->fw_update.size = size;
+
+	err = fbnic_fw_xmit_fw_start_upgrade(fbd, fw_cmpl, id, size);
+	if (err)
+		goto cmpl_free;
+
+	/* Monitor completions and report status of update */
+	while (fw_cmpl->fw_update.data) {
+		u32 offset = fw_cmpl->fw_update.last_offset;
+
+		devlink_flash_update_status_notify(devlink, "Flashing",
+						   component_name, offset,
+						   size);
+
+		/* Allow 5 seconds for reply, resend and try up to 2 times */
+		if (wait_for_completion_timeout(&fw_cmpl->done, 5 * HZ)) {
+			reinit_completion(&fw_cmpl->done);
+			/* If we receive a reply, reinit our retry counter */
+			retries = 2;
+		} else if (--retries == 0) {
+			dev_err(fbd->dev, "Timed out waiting on update\n");
+			err = -ETIMEDOUT;
+			goto cmpl_cleanup;
+		}
+	}
+
+	err = fw_cmpl->result;
+	if (err)
+		goto cmpl_cleanup;
+
+	devlink_flash_update_status_notify(devlink, "Flashing",
+					   component_name, size, size);
+
+cmpl_cleanup:
+	fbd->cmpl_data = NULL;
+cmpl_free:
+	kfree(fw_cmpl);
+
+	return err;
+}
+
+/**
+ * fbnic_finalize_update - Perform last steps to complete device update
+ * @context: PLDM FW update structure
+ *
+ * Notify FW that update is complete and that it can take any actions
+ * needed to finalize the FW update.
+ *
+ * Return: zero on success
+ *	    negative error code on failure
+ */
+static int fbnic_finalize_update(struct pldmfw *context)
+{
+	struct device *dev = context->dev;
+
+	/* Temp placeholder required by devlink */
+	dev_info(dev, "PLDMFW: Finalize update\n");
+
+	return 0;
+}
+
+static const struct pldmfw_ops fbnic_pldmfw_ops = {
+	.match_record = pldmfw_op_pci_match_record,
+	.send_package_data = fbnic_send_package_data,
+	.send_component_table = fbnic_send_component_table,
+	.flash_component = fbnic_flash_component,
+	.finalize_update = fbnic_finalize_update,
+};
+
+static void fbnic_devlink_flash_update_report_err(struct fbnic_dev *fbd,
+						  struct devlink *devlink,
+						  const char *err_msg,
+						  int err)
+{
+	char err_str[128];
+
+	snprintf(err_str, sizeof(err_str),
+		 "Failed to flash PLDM Image: %s (error: %d)",
+		 err_msg, err);
+	devlink_flash_update_status_notify(devlink, err_str, NULL, 0, 0);
+	dev_err(fbd->dev, "%s\n", err_str);
+}
+
+static int
+fbnic_devlink_flash_update(struct devlink *devlink,
+			   struct devlink_flash_update_params *params,
+			   struct netlink_ext_ack *extack)
+{
+	struct fbnic_dev *fbd = devlink_priv(devlink);
+	const struct firmware *fw = params->fw;
+	struct device *dev = fbd->dev;
+	struct pldmfw context;
+	char *err_msg;
+	int err;
+
+	if (!fw || !fw->data || !fw->size)
+		return -EINVAL;
+
+	devlink_flash_update_status_notify(devlink, "Preparing to flash",
+					   NULL, 0, 0);
+
+	context.ops = &fbnic_pldmfw_ops;
+	context.dev = dev;
+
+	err = pldmfw_flash_image(&context, fw);
+	if (err) {
+		switch (err) {
+		case -EINVAL:
+			err_msg = "Invalid image";
+			break;
+		case -EOPNOTSUPP:
+			err_msg = "Unsupported image";
+			break;
+		case -ENOMEM:
+			err_msg = "Out of memory";
+			break;
+		case -EFAULT:
+			err_msg = "Invalid header";
+			break;
+		case -ENOENT:
+			err_msg = "No matching record";
+			break;
+		case -ENODEV:
+			err_msg = "No matching device";
+			break;
+		case -ETIMEDOUT:
+			err_msg = "Timed out waiting for reply";
+			break;
+		default:
+			err_msg = "Unknown error";
+			break;
+		}
+		fbnic_devlink_flash_update_report_err(fbd, devlink,
+						      err_msg, err);
+	} else {
+		devlink_flash_update_status_notify(devlink, "Flashing done",
+						   NULL, 0, 0);
+	}
+
+	return err;
+}
+
 static const struct devlink_ops fbnic_devlink_ops = {
-	.info_get = fbnic_devlink_info_get,
+	.info_get	= fbnic_devlink_info_get,
+	.flash_update	= fbnic_devlink_flash_update,
 };

 void fbnic_devlink_free(struct fbnic_dev *fbd)
--
2.43.5

