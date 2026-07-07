Return-Path: <netdev+bounces-305495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eVuXGAQSTWpTugEAu9opvQ
	(envelope-from <netdev+bounces-305495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3E71CD5A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:49:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305495-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305495-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C930A31961D7
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31724229C8;
	Tue,  7 Jul 2026 14:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A931282F;
	Tue,  7 Jul 2026 14:16:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433800; cv=none; b=pmm1c5r66Q+669ipzfysqfsUTnbLAeYmPDGpODrqNkaq+oCgM4Km8U5rx1n9hUzJpbFq8YgvbDVjvdyRgmNy73wii0wwc86FSPU1Gok+4pF25qVCozKwKb4Hffet/ElJMwUR4Jg+S3FlWkFoekaa0+0zrS0ZYcYkoVrowNStuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433800; c=relaxed/simple;
	bh=osyVUGVEAOh0e4ZqV72EpVTzMThINgFyf53ypiYphd8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pdhiRlqjeQlddDgvu7Vsr4HEQzWIRfHnM6UhU+awADbREibq/Mxwfxfm5Or8V+yWRmP8PdKrHZzFdIQ0qoxepUhF6CyptSvmWf3IF6BRkqCP65VBO34G+eNQhiFFCl/HoeJ4E3tYidZz4nXK/dFVLRHmNIEcfvdAQjPMZraSCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wh6bC-000000008Ah-3dwj;
	Tue, 07 Jul 2026 14:16:35 +0000
Date: Tue, 7 Jul 2026 16:16:26 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <ak0KOrM5E2_sPIHf@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-305495-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,makrotopia.org:from_mime,makrotopia.org:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dwork.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2B3E71CD5A

Implement runtime firmware upgrade via "devlink dev flash" and version
reporting via "devlink dev info":

  devlink dev info mdio_bus/<bus>/<addr>
  devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bin>

The driver sends SYS_MISC_FW_UPDATE to enter MCUboot rescue mode,
transfers the signed image over the SB PDI bulk-transfer protocol
(clause-22 SMDIO), waits for the switch to reboot, then schedules
device_reprobe() for a clean remove()+probe() cycle.

Before the transfer begins the driver closes all conduit interfaces
and marks every netdev (user and conduit) not-present via
netif_device_detach() so that userspace cannot bring ports back up
during the ~15 minute flash process. Progress is reported through
devlink status notifications. Once the FW_UPDATE command has been
sent the switch is in MCUboot mode and normal operation can only be
restored by a reprobe, so the driver always schedules one regardless
of transfer outcome.

The reprobe work item is dynamically allocated (following the iwlwifi
pattern) because device_reprobe() triggers remove() which frees the
devm-managed priv while the work is still executing.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/Makefile        |   2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-fw.c   | 434 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h   |  15 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |   7 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   2 +
 7 files changed, 463 insertions(+), 1 deletion(-)
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
index 000000000000..7cd4a462667b
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Firmware flash and devlink support for MaxLinear MxL862xx
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ *
+ * Usage:
+ *   # Query running firmware version:
+ *   devlink dev info mdio_bus/<bus>/<addr>
+ *
+ *   # Flash new firmware (all ports are taken down automatically):
+ *   devlink dev flash mdio_bus/<bus>/<addr> file <firmware.bin>
+ *
+ * The flash process takes approximately 15 minutes. Progress is
+ * reported via devlink status notifications. After a successful (or
+ * failed) flash the driver reprobes the device automatically.
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
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
+/* Timeouts */
+#define MXL862XX_FW_READY_TIMEOUT_MS	30000
+#define MXL862XX_FW_ACK_TIMEOUT_MS	5000
+#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000	/* flash erase is very slow */
+#define MXL862XX_FW_WRITE_TIMEOUT_MS	120000	/* per-slice program timeout */
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
+/* Reprobe work -- dynamically allocated so it survives remove().
+ * device_reprobe() -> remove() frees priv (devm) while work is executing,
+ * so the work struct must not live in mxl862xx_priv.
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
+/* MCUboot firmware image header (20 bytes) */
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
+	/* Validate CRC-32 of both image slots before touching hardware */
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
+	/* Step 1: Tell firmware to enter MCUboot rescue mode.
+	 * The FW_UPDATE command takes no payload (size 0).
+	 */
+	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
+				false, false);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: FW_UPDATE command failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	/* From this point on, the switch is in MCUboot rescue mode.
+	 * Any failure must go through the end_magic label to tell
+	 * MCUboot to reboot rather than leaving it stuck waiting.
+	 */
+
+	/* Step 2: Reset PDI and wait for bootloader ready */
+	devlink_flash_update_status_notify(dl, "Waiting for bootloader",
+					   NULL, 0, 0);
+	mxl862xx_sb_pdi_reset(priv);
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
+					MXL862XX_FW_READY_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: bootloader not ready: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 3: Start handshake */
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
+	/* Step 4: Transfer 20-byte header using auto-increment write mode */
+	devlink_flash_update_status_notify(dl, "Erasing flash", NULL, 0, 0);
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+			     MXL862XX_SB_PDI_CTRL_WR);
+	for (i = 0; i < MXL862XX_FW_HDR_SIZE / 2; i++) {
+		word = fw->data[i * 2] |
+		       ((u16)fw->data[i * 2 + 1] << 8);
+		mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, word);
+	}
+	mxl862xx_sb_pdi_reset(priv);
+
+	/* Write header byte count to STAT to trigger erase */
+	mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+			     MXL862XX_FW_HDR_SIZE);
+
+	/* Wait for header ACK (header_size + 1) */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_FW_HDR_SIZE + 1,
+					MXL862XX_FW_ACK_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: header ACK failed: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 5: Wait for erase to complete (STAT goes to 0) */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_ERASE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: erase timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	/* Step 6: Transfer payload using dual-bank auto-increment writes */
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
+		/* Last byte(s): flush final partial slice */
+		if (idx >= payload_size) {
+			mxl862xx_sb_pdi_reset(priv);
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+					     data_written);
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
+			/* Full slice: flush and wait for program */
+			mxl862xx_sb_pdi_reset(priv);
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
+					     data_written);
+			word_idx = 0;
+			data_written = 0;
+
+			ret = mxl862xx_sb_pdi_poll_stat(
+				priv, 0, MXL862XX_FW_WRITE_TIMEOUT_MS);
+			if (ret) {
+				dev_err(&priv->mdiodev->dev,
+					"flash: write timeout at %u/%u: %pe\n",
+					idx, payload_size, ERR_PTR(ret));
+				goto end_magic;
+			}
+			mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
+					     MXL862XX_SB_PDI_CTRL_WR);
+
+			if (time_after(jiffies, next_notify)) {
+				devlink_flash_update_status_notify(
+					dl, "Flashing", NULL,
+					idx, payload_size);
+				next_notify = jiffies +
+					      msecs_to_jiffies(500);
+			}
+		}
+	}
+
+	/* Wait for final slice to be programmed */
+	ret = mxl862xx_sb_pdi_poll_stat(priv, 0,
+					MXL862XX_FW_WRITE_TIMEOUT_MS);
+	if (ret) {
+		dev_err(&priv->mdiodev->dev,
+			"flash: final write timeout: %pe\n", ERR_PTR(ret));
+		goto end_magic;
+	}
+
+	devlink_flash_update_status_notify(dl, "Flashing", NULL,
+					   payload_size, payload_size);
+
+end_magic:
+	/* Always send end magic so MCUboot reboots instead of sitting
+	 * idle. The hardware reset during reprobe recovers the switch
+	 * regardless of whether the transfer succeeded or failed.
+	 */
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
+	char ver_str[32];
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
+	/* Close all user and CPU ports while the firmware is still
+	 * alive. dev_close() on user ports triggers multicast group
+	 * leave and host MDB/FDB removal on the CPU port through the
+	 * normal DSA callbacks so the core's tracking lists are
+	 * drained before we enter MCUboot. Then mark user ports
+	 * not-present so userspace cannot bring them back up during
+	 * the (slow) flash process. The conduit is only closed, not
+	 * detached -- it is owned by the Ethernet MAC driver and
+	 * dev_open() during reprobe must be able to bring it back.
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
+	/* Block all firmware API commands while the switch is being
+	 * reflashed. The conduit is intentionally kept open -- it is
+	 * owned by the Ethernet MAC driver and would not recover on
+	 * reprobe if we closed it here.
+	 */
+	priv->block_host = true;
+
+	/* Stop stats polling and pending host-flood work */
+	cancel_delayed_work_sync(&priv->stats_work);
+	for (i = 0; i < ds->num_ports; i++)
+		cancel_work_sync(&priv->ports[i].host_flood_work);
+
+	ret = mxl862xx_flash_firmware(priv, params->fw, ds->devlink);
+	if (ret)
+		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
+
+	if (!ret) {
+		/* Read new firmware version (switch just rebooted).
+		 * Temporarily lift the block for this single query.
+		 */
+		priv->block_host = false;
+		memset(&ver, 0, sizeof(ver));
+		if (!MXL862XX_API_READ_QUIET(priv, SYS_MISC_FW_VERSION, ver)
+		    && ver.iv_major)
+			dev_info(ds->dev, "flash: new firmware %u.%u.%u\n",
+				 ver.iv_major, ver.iv_minor,
+				 le16_to_cpu(ver.iv_revision));
+	}
+
+	/* Silently discard all API commands during the teardown that
+	 * reprobe triggers -- the switch firmware has been reset and
+	 * has no knowledge of the old configuration.
+	 */
+	priv->skip_teardown = true;
+
+	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
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
index 432a5f3f2e08..a53fc4c37451 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -337,6 +337,8 @@ struct mxl862xx_priv {
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	bool block_host;
+	bool skip_teardown;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0

