Return-Path: <netdev+bounces-307305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YaTxEDaIVWrupgAAu9opvQ
	(envelope-from <netdev+bounces-307305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:52:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA674FED3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307305-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307305-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B04630309FD
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246219CCF5;
	Tue, 14 Jul 2026 00:51:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE819E7F7;
	Tue, 14 Jul 2026 00:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990270; cv=none; b=lA4Jqup5ZHRtQhuoWq+7Iy3WzL/VxxUsxLnQueOy29L+EheK9tE5XnBLMec4YE0XpGxjSLhu3Evwg/0msIo6pN4q5UesqqA7+VF9XYOXpQX9RdEj43cRORggvsfF2DmNGBZDdAXrE2+hYZJ7I/T6jTapkY9z2AHBBC/jdfYAi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990270; c=relaxed/simple;
	bh=QkbN6xKi5x+GvBXQzCm2OuRsK1RFZoTl/vUHPwJmzNo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhjXNm0GTi5Q2/xSjdQFSIn+S7PUGzI317PK9DvnzygOLb4rDe1Y3wzFwA/Dc7qzrmWObPJUeT/CL4Gc27rSYM44SIoDFF21XKENxyuUCoGnaka7OHH/yIT+rCGMz+9uj9Df4dUCbeZV/ohkgSz//lIJvKkRuo15uppq1PGbRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wjRMX-000000001rd-0iEc;
	Tue, 14 Jul 2026 00:51:05 +0000
Date: Tue, 14 Jul 2026 01:51:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: dsa: mxl862xx: add devlink flash_update
 and info_get
Message-ID: <5d1614d1cd6b99bf0f0635c6370bbed10736a7fa.1783988826.git.daniel@makrotopia.org>
References: <cover.1783988826.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783988826.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:from_mime,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DBA674FED3

Implement runtime firmware upgrade via "devlink dev flash" and version
reporting via "devlink dev info":

  devlink dev info mdio_bus/<bus>/<addr>
  devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bin>

The driver sends SYS_MISC_FW_UPDATE to enter MCUboot rescue mode and
transfers the signed image over the SB PDI bulk-transfer protocol
(clause-22 SMDIO). Once the transfer has finished and the switch has
rebooted, the driver schedules device_reprobe() for a clean
remove()+probe() cycle.

Before the transfer begins the driver closes all conduit interfaces
and marks every netdev (user and conduit) not-present via
netif_device_detach() so that userspace cannot bring ports back up
during the flash and reprobe cycle, which takes just under a minute.
Closing the ports also stops phylib from polling the switch-internal
PHYs, whose firmware-relayed MDIO access is unavailable while the
switch is in MCUboot mode. Progress is reported through devlink
status notifications. Once the FW_UPDATE command has been sent the
switch is in MCUboot mode and normal operation can only be restored
by a reprobe, so the driver always schedules one regardless of
transfer outcome.

The reprobe work item is dynamically allocated because
device_reprobe() triggers remove() which frees the devm-managed priv
while the work item is still executing, so the work struct cannot be
a member of priv. iwlwifi uses the same approach for its
firmware-triggered device removal, see iwl_trans_pcie_removal_wk().

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - factor out SB PDI slice flush and devlink status notification
   helpers, resolving checkpatch issues
 - use kzalloc_obj() (Manuel Ebner)
 - add kernel-doc for the new mxl862xx_priv members
 - trim comments and state the actual duration of a flash and reprobe
   cycle, just under a minute (Manuel Ebner)
 - reword commit message: split up run-on sentence, explain the
   dynamically allocated reprobe work item (Manuel Ebner), mention
   that closing the ports stops phylib polling (Andrew Lunn)

 drivers/net/dsa/mxl862xx/Makefile        |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 410 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  15 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |   7 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   6 +
 7 files changed, 443 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-fw.h

diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
index a7be0e6669df..bccac0d0f703 100644
--- a/drivers/net/dsa/mxl862xx/Makefile
+++ b/drivers/net/dsa/mxl862xx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
-mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
+mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o mxl862xx-fw.o
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
index c87a955c13c4..e2aa2934e9e1 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
@@ -70,6 +70,7 @@
 #define INT_GPHY_READ			(GPY_GPY2XX_MAGIC + 0x1)
 #define INT_GPHY_WRITE			(GPY_GPY2XX_MAGIC + 0x2)
 
+#define SYS_MISC_FW_UPDATE		(SYS_MISC_MAGIC + 0x1)
 #define SYS_MISC_FW_VERSION		(SYS_MISC_MAGIC + 0x2)
 
 #define MXL862XX_XPCS_PCS_CONFIG	(MXL862XX_XPCS_MAGIC + 0x1)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
new file mode 100644
index 000000000000..b2c23ccf1370
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Firmware flash and devlink support for MaxLinear MxL862xx
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/rtnetlink.h>
+#include <net/dsa.h>
+
+#include "mxl862xx.h"
+#include "mxl862xx-api.h"
+#include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
+#include "mxl862xx-host.h"
+
+/* SB PDI registers (clause-22 SMDIO address space) */
+#define MXL862XX_SB_PDI_CTRL		0xe100
+#define MXL862XX_SB_PDI_ADDR		0xe101
+#define MXL862XX_SB_PDI_DATA		0xe102
+#define MXL862XX_SB_PDI_STAT		0xe103
+
+/* SB PDI CTRL modes */
+#define MXL862XX_SB_PDI_CTRL_RST	0x00
+#define MXL862XX_SB_PDI_CTRL_WR	0x02
+
+/* SB PDI handshake magic */
+#define MXL862XX_SB_PDI_READY		0xc55c
+#define MXL862XX_SB_PDI_START		0xf48f
+#define MXL862XX_SB_PDI_END		0x3cc3
+
+/* Firmware transfer geometry */
+#define MXL862XX_FW_HDR_SIZE		20
+#define MXL862XX_FW_BANK_HALF		16384	/* words per half-bank */
+#define MXL862XX_FW_BANK_SLICE		32760	/* words per full slice */
+#define MXL862XX_FW_SB1_ADDR		0x7800	/* SB1 word address */
+
+/* Timeouts (generous upper bounds) */
+#define MXL862XX_FW_READY_TIMEOUT_MS	30000
+#define MXL862XX_FW_ACK_TIMEOUT_MS	5000
+#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000
+#define MXL862XX_FW_WRITE_TIMEOUT_MS	120000
+#define MXL862XX_FW_REBOOT_DELAY_MS	5000
+
+static void mxl862xx_sb_pdi_reset(struct mxl862xx_priv *priv)
+{
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+			     MXL862XX_SB_PDI_CTRL_RST);
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
+			     MXL862XX_SB_PDI_CTRL_RST);
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
+			     MXL862XX_SB_PDI_CTRL_RST);
+}
+
+static int mxl862xx_sb_pdi_poll_stat(struct mxl862xx_priv *priv, u16 expected,
+				     unsigned long timeout_ms)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int ret;
+
+	do {
+		ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+		if (ret < 0)
+			return ret;
+		if ((u16)ret == expected)
+			return 0;
+		usleep_range(10000, 11000);
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int mxl862xx_sb_pdi_flush_slice(struct mxl862xx_priv *priv,
+				       u32 data_written)
+{
+	mxl862xx_sb_pdi_reset(priv);
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT, data_written);
+
+	return mxl862xx_sb_pdi_poll_stat(priv, 0,
+					 MXL862XX_FW_WRITE_TIMEOUT_MS);
+}
+
+static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
+				  u32 done, u32 total)
+{
+	devlink_flash_update_status_notify(dl, status, NULL, done, total);
+}
+
+/* device_reprobe() -> remove() frees priv while the work runs, so
+ * the work struct cannot live in mxl862xx_priv.
+ */
+struct mxl862xx_reprobe {
+	struct device *dev;
+	struct delayed_work dwork;
+};
+
+static void mxl862xx_reprobe_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_reprobe *reprobe =
+		container_of(work, struct mxl862xx_reprobe, dwork.work);
+
+	if (device_reprobe(reprobe->dev))
+		dev_err(reprobe->dev, "reprobe failed\n");
+	put_device(reprobe->dev);
+	kfree(reprobe);
+	module_put(THIS_MODULE);
+}
+
+/* MCUboot firmware image header */
+struct mxl862xx_fw_hdr {
+	__le32 image_type;
+	__le32 image_size_1;
+	__le32 image_checksum_1;
+	__le32 image_size_2;
+	__le32 image_checksum_2;
+} __packed;
+
+static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
+				   const struct firmware *fw,
+				   struct devlink *dl)
+{
+	const struct mxl862xx_fw_hdr *hdr;
+	u32 word_idx = 0, data_written = 0, idx = 0;
+	unsigned long next_notify = 0;
+	const u8 *payload;
+	u32 payload_size;
+	u16 word, fdata;
+	int ret, i;
+	u32 crc;
+
+	if (fw->size < MXL862XX_FW_HDR_SIZE)
+		return -EINVAL;
+
+	hdr = (const struct mxl862xx_fw_hdr *)fw->data;
+	payload = fw->data + MXL862XX_FW_HDR_SIZE;
+	payload_size = le32_to_cpu(hdr->image_size_1) +
+		       le32_to_cpu(hdr->image_size_2);
+
+	if (payload_size > fw->size - MXL862XX_FW_HDR_SIZE) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: firmware file too small for declared size\n");
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(hdr->image_size_1)) {
+		crc = ~crc32_le(~0U, payload,
+				le32_to_cpu(hdr->image_size_1));
+		if (crc != le32_to_cpu(hdr->image_checksum_1)) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: image 1 CRC mismatch (got %08x, expected %08x)\n",
+				crc, le32_to_cpu(hdr->image_checksum_1));
+			return -EINVAL;
+		}
+	}
+
+	if (le32_to_cpu(hdr->image_size_2)) {
+		crc = ~crc32_le(~0U,
+				payload + le32_to_cpu(hdr->image_size_1),
+				le32_to_cpu(hdr->image_size_2));
+		if (crc != le32_to_cpu(hdr->image_checksum_2)) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: image 2 CRC mismatch (got %08x, expected %08x)\n",
+				crc, le32_to_cpu(hdr->image_checksum_2));
+			return -EINVAL;
+		}
+	}
+
+	/* Step 1: reboot the firmware into MCUboot rescue mode */
+	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
+				false, false);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: FW_UPDATE command failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Failures from here on must go through end_magic so MCUboot
+	 * reboots instead of waiting forever.
+	 */
+
+	/* Step 2: wait for bootloader ready */
+	mxl862xx_flash_notify(dl, "Waiting for bootloader", 0, 0);
+	mxl862xx_sb_pdi_reset(priv);
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					MXL862XX_FW_READY_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 3: start handshake */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+			     MXL862XX_SB_PDI_START);
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_START + 1,
+					MXL862XX_FW_ACK_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: start handshake failed: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 4: transfer image header */
+	mxl862xx_flash_notify(dl, "Erasing flash", 0, 0);
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+			     MXL862XX_SB_PDI_CTRL_WR);
+	for (i = 0; i < MXL862XX_FW_HDR_SIZE / 2; i++) {
+		word = fw->data[i * 2] |
+		       ((u16)fw->data[i * 2 + 1] << 8);
+		mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, word);
+	}
+	mxl862xx_sb_pdi_reset(priv);
+
+	/* the byte count in STAT triggers the erase */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+			     MXL862XX_FW_HDR_SIZE);
+
+	/* ACK is byte count + 1 */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_FW_HDR_SIZE + 1,
+					MXL862XX_FW_ACK_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: header ACK failed: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 5: wait for erase to complete */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: erase timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 6: transfer payload */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+			     MXL862XX_SB_PDI_CTRL_WR);
+
+	while (idx < payload_size) {
+		if (idx + 1 < payload_size) {
+			fdata = payload[idx] |
+				((u16)payload[idx + 1] << 8);
+			idx += 2;
+			data_written += 2;
+		} else {
+			fdata = payload[idx];
+			idx++;
+			data_written++;
+		}
+
+		mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, fdata);
+		word_idx++;
+
+		if (idx >= payload_size) {
+			ret = mxl862xx_sb_pdi_flush_slice(priv, data_written);
+			break;
+		}
+
+		/* Half-bank boundary: switch to SB1 address */
+		if (word_idx == MXL862XX_FW_BANK_HALF) {
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+					     MXL862XX_SB_PDI_CTRL_RST);
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
+					     MXL862XX_FW_SB1_ADDR);
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+					     MXL862XX_SB_PDI_CTRL_WR);
+		} else if (word_idx >= MXL862XX_FW_BANK_SLICE) {
+			ret = mxl862xx_sb_pdi_flush_slice(priv, data_written);
+			if (ret) {
+				dev_err(&priv->mdiodev->dev,
+					"flash: write timeout at %u/%u: %pe\n",
+					idx, payload_size, ERR_PTR(ret));
+				goto end_magic;
+			}
+			word_idx = 0;
+			data_written = 0;
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+					     MXL862XX_SB_PDI_CTRL_WR);
+
+			if (time_after(jiffies, next_notify)) {
+				mxl862xx_flash_notify(dl, "Flashing", idx,
+						      payload_size);
+				next_notify = jiffies + msecs_to_jiffies(500);
+			}
+		}
+	}
+
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: final write timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	mxl862xx_flash_notify(dl, "Flashing", payload_size, payload_size);
+
+end_magic:
+	/* reboot MCUboot even after a failed transfer */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+			     MXL862XX_SB_PDI_END);
+	msleep(MXL862XX_FW_REBOOT_DELAY_MS);
+
+	return ret;
+}
+
+int mxl862xx_devlink_info_get(struct dsa_switch *ds,
+			      struct devlink_info_req *req,
+			      struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	const char *compatible;
+	char ver_str[32];
+	int ret;
+
+	if (!of_property_read_string_index(ds->dev->of_node, "compatible", 0,
+					   &compatible)) {
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+						     compatible);
+		if (ret)
+			return ret;
+	}
+
+	snprintf(ver_str, sizeof(ver_str), "%u.%u.%u",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	return devlink_info_version_running_put(req, "fw", ver_str);
+}
+
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_sys_fw_image_version ver = {};
+	struct mxl862xx_reprobe *reprobe;
+	struct dsa_port *dp;
+	int ret, i;
+
+	if (params->component) {
+		NL_SET_ERR_MSG_MOD(extack, "component is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+		 priv->fw_version.major, priv->fw_version.minor,
+		 priv->fw_version.revision);
+
+	/* Close ports while the firmware is still alive so the DSA
+	 * core's MDB/FDB tracking is drained, and detach user ports
+	 * so userspace cannot reopen them during the flash. The
+	 * conduit belongs to the MAC driver and is only closed.
+	 */
+	rtnl_lock();
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->user) {
+			dev_close(dp->user);
+			netif_device_detach(dp->user);
+		}
+	}
+	dsa_switch_for_each_cpu_port(dp, ds)
+		dev_close(dp->conduit);
+	rtnl_unlock();
+
+	priv->block_host = true;
+
+	cancel_delayed_work_sync(&priv->stats_work);
+	for (i = 0; i < ds->num_ports; i++)
+		cancel_work_sync(&priv->ports[i].host_flood_work);
+
+	ret = mxl862xx_flash_firmware(priv, params->fw, ds->devlink);
+	if (ret)
+		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
+
+	if (!ret) {
+		/* lift the block to query the new firmware version */
+		priv->block_host = false;
+		memset(&ver, 0, sizeof(ver));
+		if (!MXL862XX_API_READ_QUIET(priv, SYS_MISC_FW_VERSION, ver) &&
+		    ver.iv_major)
+			dev_info(ds->dev, "flash: new firmware %u.%u.%u\n",
+				 ver.iv_major, ver.iv_minor,
+				 le16_to_cpu(ver.iv_revision));
+	}
+
+	priv->skip_teardown = true;
+
+	reprobe = kzalloc_obj(*reprobe);
+	if (!reprobe)
+		return ret;
+
+	if (!try_module_get(THIS_MODULE)) {
+		kfree(reprobe);
+		return ret;
+	}
+
+	reprobe->dev = get_device(ds->dev);
+	INIT_DELAYED_WORK(&reprobe->dwork, mxl862xx_reprobe_work_fn);
+	schedule_delayed_work(&reprobe->dwork, msecs_to_jiffies(500));
+
+	return ret;
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
new file mode 100644
index 000000000000..a1b60fbacebf
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MXL862XX_FW_H
+#define __MXL862XX_FW_H
+
+#include <net/dsa.h>
+
+int mxl862xx_devlink_info_get(struct dsa_switch *ds,
+			      struct devlink_info_req *req,
+			      struct netlink_ext_ack *extack);
+int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
+				  struct devlink_flash_update_params *params,
+				  struct netlink_ext_ack *extack);
+
+#endif /* __MXL862XX_FW_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 6e582caea1fa..7ba984e94d82 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -15,6 +15,7 @@
 #include <linux/unaligned.h>
 #include <net/dsa.h>
 #include "mxl862xx.h"
+#include "mxl862xx-cmd.h"
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
@@ -336,6 +337,12 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	int ret, cmd_ret;
 	u16 max, crc, i;
 
+	if (priv->skip_teardown)
+		return 0;
+
+	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE)
+		return -EBUSY;
+
 	dev_dbg(&priv->mdiodev->dev, "CMD %04x DATA %*ph\n", cmd, size, data);
 
 	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 45d237b3a40f..e643083d3938 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -21,6 +21,7 @@
 #include "mxl862xx.h"
 #include "mxl862xx-api.h"
 #include "mxl862xx-cmd.h"
+#include "mxl862xx-fw.h"
 #include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
@@ -2086,6 +2087,8 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_pause_stats = mxl862xx_get_pause_stats,
 	.get_rmon_stats = mxl862xx_get_rmon_stats,
 	.get_stats64 = mxl862xx_get_stats64,
+	.devlink_info_get = mxl862xx_devlink_info_get,
+	.devlink_flash_update = mxl862xx_devlink_flash_update,
 };
 
 static int mxl862xx_probe(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 432a5f3f2e08..64d91ad51936 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -319,6 +319,10 @@ struct mxl862xx_fw_version {
  * @evlan_ingress_size: per-port ingress Extended VLAN block size
  * @evlan_egress_size:  per-port egress Extended VLAN block size
  * @vf_block_size:      per-port VLAN Filter block size
+ * @block_host:         reject firmware API commands (except FW_UPDATE)
+ *                      during a firmware flash
+ * @skip_teardown:      discard firmware API commands during the teardown
+ *                      triggered by the post-flash reprobe
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -337,6 +341,8 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	bool block_host;
+	bool skip_teardown;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0


