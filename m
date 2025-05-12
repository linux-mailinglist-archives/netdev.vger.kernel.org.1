Return-Path: <netdev+bounces-189879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D42AB4472
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2876C16BD55
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E72980B7;
	Mon, 12 May 2025 19:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A0297B95;
	Mon, 12 May 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076980; cv=none; b=Nwy+1fQtN3o64BlHUDolQyFBYZ1tauMqxs4Qa6eKoTy7z+L8EGRI6YupgCzSKzPOTWVSGV07Fb+1CwGPwWF1TzXINvGSvP+4NmQaiN3lHHbCO3L7wkfZMLlU1wCANaAuAOB20exkJ6e2oeK/VWOYt9gLLWnAL5dJeiY1VGx9C4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076980; c=relaxed/simple;
	bh=DJ+l5QzZw9VZQNabyv3jkwLGwtMY56b2MtxyzuPKzcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwMsDA6XQfbBUZ70lvQWJwwH1OLOifPq89WClrbxAYMISMtiKzm/D74/vptpFLwYzdIlMo6DLNthYjsb9+6YuK9Ijk6xR7FhI8zHvUuellECdMhFefDNUw6IbJ1tsjmgw4NSLv7bY1nis+k95R/9p22/pHKJ4B7sseGlcuVnmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from [163.114.132.130] (helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uEYWm-00072w-UD; Mon, 12 May 2025 19:09:29 +0000
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>,
	Lee Trager <lee@trager.us>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/5] eth: fbnic: Add devlink dev flash support
Date: Mon, 12 May 2025 11:54:01 -0700
Message-ID: <20250512190109.2475614-6-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512190109.2475614-1-lee@trager.us>
References: <20250512190109.2475614-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to update the CMRT and control firmware as well as the UEFI
driver on fbnic using devlink dev flash.

Make sure the shutdown / quiescence paths like suspend take the devlink
lock to prevent them from interrupting the FW flashing process.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
V5:
* Make sure fbnic_pldm_match_record() always returns a bool

 .../device_drivers/ethernet/meta/fbnic.rst    |  11 +
 drivers/net/ethernet/meta/Kconfig             |   1 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 260 +++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   9 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +
 5 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index 3483e498c08e..f8592dec8851 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -28,6 +28,17 @@ devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.

+Upgrading Firmware
+------------------
+
+fbnic supports updating firmware using signed PLDM images with devlink dev
+flash. PLDM images are written into the flash. Flashing does not interrupt
+the operation of the device.
+
+On host boot the latest UEFI driver is always used, no explicit activation
+is required. Firmware activation is required to run new control firmware. cmrt
+firmware can only be activated by power cycling the NIC.
+
 Statistics
 ----------

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
index 0072d612215e..71d9461a0d1b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -3,10 +3,12 @@

 #include <linux/unaligned.h>
 #include <linux/pci.h>
+#include <linux/pldmfw.h>
 #include <linux/types.h>
 #include <net/devlink.h>

 #include "fbnic.h"
+#include "fbnic_tlv.h"

 #define FBNIC_SN_STR_LEN	24

@@ -109,8 +111,264 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
 	return 0;
 }

+static bool
+fbnic_pldm_match_record(struct pldmfw *context, struct pldmfw_record *record)
+{
+	struct pldmfw_desc_tlv *desc;
+	u32 anti_rollback_ver = 0;
+	struct devlink *devlink;
+	struct fbnic_dev *fbd;
+	struct pci_dev *pdev;
+
+	/* First, use the standard PCI matching function */
+	if (!pldmfw_op_pci_match_record(context, record))
+		return false;
+
+	pdev = to_pci_dev(context->dev);
+	fbd = pci_get_drvdata(pdev);
+	devlink = priv_to_devlink(fbd);
+
+	/* If PCI match is successful, check for vendor-specific descriptors */
+	list_for_each_entry(desc, &record->descs, entry) {
+		if (desc->type != PLDM_DESC_ID_VENDOR_DEFINED)
+			continue;
+
+		if (desc->size < 21 || desc->data[0] != 1 ||
+		    desc->data[1] != 15)
+			continue;
+
+		if (memcmp(desc->data + 2, "AntiRollbackVer", 15) != 0)
+			continue;
+
+		anti_rollback_ver = get_unaligned_le32(desc->data + 17);
+		break;
+	}
+
+	/* Compare versions and return error if they do not match */
+	if (anti_rollback_ver < fbd->fw_cap.anti_rollback_version) {
+		char buf[128];
+
+		snprintf(buf, sizeof(buf),
+			 "New firmware anti-rollback version (0x%x) is older than device version (0x%x)!",
+			 anti_rollback_ver, fbd->fw_cap.anti_rollback_version);
+		devlink_flash_update_status_notify(devlink, buf,
+						   "Anti-Rollback", 0, 0);
+
+		return false;
+	}
+
+	return true;
+}
+
+static int
+fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
+{
+	struct fbnic_fw_completion *cmpl;
+	int err;
+
+	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	if (!cmpl)
+		return -ENOMEM;
+
+	fbnic_fw_init_cmpl(cmpl, FBNIC_TLV_MSG_ID_FW_START_UPGRADE_REQ);
+	err = fbnic_fw_xmit_fw_start_upgrade(fbd, cmpl,
+					     component->identifier,
+					     component->component_size);
+	if (err)
+		goto cmpl_free;
+
+	/* Wait for firmware to ack firmware upgrade start */
+	if (wait_for_completion_timeout(&cmpl->done, 10 * HZ))
+		err = cmpl->result;
+	else
+		err = -ETIMEDOUT;
+
+	fbnic_fw_clear_cmpl(fbd, cmpl);
+cmpl_free:
+	fbnic_fw_put_cmpl(cmpl);
+
+	return err;
+}
+
+static int
+fbnic_flash_component(struct pldmfw *context,
+		      struct pldmfw_component *component)
+{
+	const u8 *data = component->component_data;
+	const u32 size = component->component_size;
+	struct fbnic_fw_completion *cmpl;
+	const char *component_name;
+	struct devlink *devlink;
+	struct fbnic_dev *fbd;
+	struct pci_dev *pdev;
+	u32 offset = 0;
+	u32 length = 0;
+	char buf[32];
+	int err;
+
+	pdev = to_pci_dev(context->dev);
+	fbd = pci_get_drvdata(pdev);
+	devlink = priv_to_devlink(fbd);
+
+	switch (component->identifier) {
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
+		snprintf(buf, sizeof(buf), "Unknown component ID %u!",
+			 component->identifier);
+		devlink_flash_update_status_notify(devlink, buf, NULL, 0,
+						   size);
+		return -EINVAL;
+	}
+
+	/* Once firmware receives the request to start upgrading it responds
+	 * with two messages:
+	 * 1. An ACK that it received the message and possible error code
+	 *    indicating that an upgrade is not currently possible.
+	 * 2. A request for the first chunk of data
+	 *
+	 * Setup completions for write before issuing the start message so
+	 * the driver can catch both messages.
+	 */
+	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	if (!cmpl)
+		return -ENOMEM;
+
+	fbnic_fw_init_cmpl(cmpl, FBNIC_TLV_MSG_ID_FW_WRITE_CHUNK_REQ);
+	err = fbnic_mbx_set_cmpl(fbd, cmpl);
+	if (err)
+		goto cmpl_free;
+
+	devlink_flash_update_timeout_notify(devlink, "Initializing",
+					    component_name, 15);
+	err = fbnic_flash_start(fbd, component);
+	if (err)
+		goto err_no_msg;
+
+	while (offset < size) {
+		if (!wait_for_completion_timeout(&cmpl->done, 15 * HZ)) {
+			err = -ETIMEDOUT;
+			break;
+		}
+
+		err = cmpl->result;
+		if (err)
+			break;
+
+		/* Verify firmware is requesting the next chunk in the seq. */
+		if (cmpl->u.fw_update.offset != offset + length) {
+			err = -EFAULT;
+			break;
+		}
+
+		offset = cmpl->u.fw_update.offset;
+		length = cmpl->u.fw_update.length;
+
+		if (length > TLV_MAX_DATA || offset + length > size) {
+			err = -EFAULT;
+			break;
+		}
+
+		devlink_flash_update_status_notify(devlink, "Flashing",
+						   component_name,
+						   offset, size);
+
+		/* Mailbox will set length to 0 once it receives the finish
+		 * message.
+		 */
+		if (!length)
+			continue;
+
+		reinit_completion(&cmpl->done);
+		err = fbnic_fw_xmit_fw_write_chunk(fbd, data, offset, length,
+						   0);
+		if (err)
+			break;
+	}
+
+	if (err) {
+		fbnic_fw_xmit_fw_write_chunk(fbd, NULL, 0, 0, err);
+err_no_msg:
+		snprintf(buf, sizeof(buf), "Mailbox encountered error %d!",
+			 err);
+		devlink_flash_update_status_notify(devlink, buf,
+						   component_name, 0, 0);
+	}
+
+	fbnic_fw_clear_cmpl(fbd, cmpl);
+cmpl_free:
+	fbnic_fw_put_cmpl(cmpl);
+
+	return err;
+}
+
+static const struct pldmfw_ops fbnic_pldmfw_ops = {
+	.match_record = fbnic_pldm_match_record,
+	.flash_component = fbnic_flash_component,
+};
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
+
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Failed to flash PLDM Image: %s (error: %d)",
+				       err_msg, err);
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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 0ab6ae3859e4..6baac10fd688 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -100,6 +100,15 @@ do {									\
 #define fbnic_mk_fw_ver_str(_rev_id, _str) \
 	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))

+enum {
+	QSPI_SECTION_CMRT			= 0,
+	QSPI_SECTION_CONTROL_FW			= 1,
+	QSPI_SECTION_UCODE			= 2,
+	QSPI_SECTION_OPTION_ROM			= 3,
+	QSPI_SECTION_USER			= 4,
+	QSPI_SECTION_INVALID,
+};
+
 #define FW_HEARTBEAT_PERIOD		(10 * HZ)

 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 70a852b3e99d..249d3ef862d5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/rtnetlink.h>
 #include <linux/types.h>
+#include <net/devlink.h>

 #include "fbnic.h"
 #include "fbnic_drvinfo.h"
@@ -388,8 +389,12 @@ static int fbnic_pm_suspend(struct device *dev)
 	rtnl_unlock();

 null_uc_addr:
+	devl_lock(priv_to_devlink(fbd));
+
 	fbnic_fw_free_mbx(fbd);

+	devl_unlock(priv_to_devlink(fbd));
+
 	/* Free the IRQs so they aren't trying to occupy sleeping CPUs */
 	fbnic_free_irqs(fbd);

@@ -420,11 +425,15 @@ static int __fbnic_pm_resume(struct device *dev)

 	fbd->mac->init_regs(fbd);

+	devl_lock(priv_to_devlink(fbd));
+
 	/* Re-enable mailbox */
 	err = fbnic_fw_request_mbx(fbd);
 	if (err)
 		goto err_free_irqs;

+	devl_unlock(priv_to_devlink(fbd));
+
 	/* No netdev means there isn't a network interface to bring up */
 	if (fbnic_init_failure(fbd))
 		return 0;
--
2.47.1

