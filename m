Return-Path: <netdev+bounces-270306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE83L2/uv2m3AQQAu9opvQ
	(envelope-from <netdev+bounces-270306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 14:28:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8B2E9757
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 14:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F15E83005339
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F27C33344D;
	Sun, 22 Mar 2026 13:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61832BF42;
	Sun, 22 Mar 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186055; cv=none; b=WlptTruQ+L0nXU5GYsK5nvVS1Tn+KiLVx1oVylKzQKLOX7SaqU+arHctzY9Fbrg7/cHVFuXCc3HHrWtt7AC6zw48ySiLu75shJPRM/gows6JlTE+za92m3IBiuEL7dBY4g3YBh/xvKs1rhPusZpvZLwAWuW6Y2+KoEHZNOUI84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186055; c=relaxed/simple;
	bh=MkBKJWVbQH9HuFo7S7+Tnpv9bcvR2KXQo2I5KcAY9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq34Z+CnXvbz5epi0Ev80qoG5wL14cOQnaEn4kCaB3DQ8xkA+3sRJY0zKuPVi7iUYa9npG2u7Gq50RIJGT6kDsSBRDpBS9G0xkKffmUTSZ3CXSk4zkK4mUT339lD6tCgLqCzW5rCubDmb09EqM/YswV8oIUAhjf2l8PBqiamLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w4Ipv-0000000031a-07yd;
	Sun, 22 Mar 2026 13:27:23 +0000
Date: Sun, 22 Mar 2026 13:27:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 1/2] net: dsa: mxl862xx: add CRC for MDIO
 communication
Message-ID: <620453b9a150bbe5b7ea4224331cb5dc5e57263b.1774185953.git.daniel@makrotopia.org>
References: <cover.1774185953.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774185953.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BCA8B2E9757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable the firmware's opt-in CRC validation on the MDIO/MMD command
interface to detect bit errors on the bus. The firmware bundles CRC-6
and CRC-16 under a single enable flag, so both are implemented
together.

CRC-6 protects the ctrl and len_ret command registers using a table-
driven 3GPP algorithm. It is applied to every command exchange
including SET_DATA/GET_DATA batch transfers. With CRC enabled, the
firmware encodes its return value as a signed 11-bit integer within
the CRC- protected register fields, replacing the previous 16-bit
interpretation.

CRC-16 protects the data payload using the kernel's crc16() library.
The driver appends a CRC-16 checksum to outgoing data and verifies the
firmware-appended checksum on responses. The checksum is placed at the
exact byte offset where the struct data ends, correctly handling
packed structs with odd sizes by splitting the checksum across word
boundaries. SET_DATA/GET_DATA sub-commands carry only CRC-6.

Upon detection of a CRC error on either side all conduit interfaces
are taken down, triggering all user ports to go down as well. This is
the most feasible option: CRC errors are likely caused either by
broken hardware, or are symptom of overheating. In either case, trying
to resume normal operation isn't reasonable.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: trigger worker which takes down all ports in case of a CRC error

 drivers/net/dsa/mxl862xx/Kconfig         |   1 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 345 ++++++++++++++++++-----
 drivers/net/dsa/mxl862xx/mxl862xx-host.h |   2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c      |  11 +
 drivers/net/dsa/mxl862xx/mxl862xx.h      |   2 +
 5 files changed, 296 insertions(+), 65 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
index 3e772298cc894..e51a67a3cf9bf 100644
--- a/drivers/net/dsa/mxl862xx/Kconfig
+++ b/drivers/net/dsa/mxl862xx/Kconfig
@@ -2,6 +2,7 @@
 config NET_DSA_MXL862
 	tristate "MaxLinear MxL862xx"
 	depends on NET_DSA
+	select CRC16
 	select NET_DSA_TAG_MXL_862XX
 	help
 	  This enables support for the MaxLinear MxL862xx switch family.
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 4eefd2a759a7d..0b7f8db318257 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -7,7 +7,9 @@
  * Copyright (C) 2024 MaxLinear Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/crc16.h>
 #include <linux/iopoll.h>
 #include <linux/limits.h>
 #include <net/dsa.h>
@@ -15,6 +17,9 @@
 #include "mxl862xx-host.h"
 
 #define CTRL_BUSY_MASK			BIT(15)
+#define CTRL_CRC_FLAG			BIT(14)
+
+#define LEN_RET_LEN_MASK		GENMASK(9, 0)
 
 #define MXL862XX_MMD_REG_CTRL		0
 #define MXL862XX_MMD_REG_LEN_RET	1
@@ -27,7 +32,159 @@
 #define MMD_API_GET_DATA_0		5
 #define MMD_API_RST_DATA		8
 
-#define MXL862XX_SWITCH_RESET 0x9907
+#define MXL862XX_SWITCH_RESET		0x9907
+
+static void mxl862xx_crc_err_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_priv *priv = container_of(work, struct mxl862xx_priv,
+						  crc_err_work);
+	struct dsa_port *dp;
+
+	dev_warn(&priv->mdiodev->dev,
+		 "MDIO CRC error detected, shutting down all ports\n");
+
+	rtnl_lock();
+	dsa_switch_for_each_cpu_port(dp, priv->ds)
+		dev_close(dp->conduit);
+	rtnl_unlock();
+
+	clear_bit(0, &priv->crc_err);
+}
+
+/* Firmware CRC error codes (outside normal Zephyr errno range). */
+#define MXL862XX_FW_CRC6_ERR		(-1024)
+#define MXL862XX_FW_CRC16_ERR		(-1023)
+
+/* 3GPP CRC-6 lookup table (polynomial 0x6F).
+ * Matches the firmware's default CRC-6 implementation.
+ */
+static const u8 mxl862xx_crc6_table[256] = {
+	0x00, 0x2f, 0x31, 0x1e, 0x0d, 0x22, 0x3c, 0x13,
+	0x1a, 0x35, 0x2b, 0x04, 0x17, 0x38, 0x26, 0x09,
+	0x34, 0x1b, 0x05, 0x2a, 0x39, 0x16, 0x08, 0x27,
+	0x2e, 0x01, 0x1f, 0x30, 0x23, 0x0c, 0x12, 0x3d,
+	0x07, 0x28, 0x36, 0x19, 0x0a, 0x25, 0x3b, 0x14,
+	0x1d, 0x32, 0x2c, 0x03, 0x10, 0x3f, 0x21, 0x0e,
+	0x33, 0x1c, 0x02, 0x2d, 0x3e, 0x11, 0x0f, 0x20,
+	0x29, 0x06, 0x18, 0x37, 0x24, 0x0b, 0x15, 0x3a,
+	0x0e, 0x21, 0x3f, 0x10, 0x03, 0x2c, 0x32, 0x1d,
+	0x14, 0x3b, 0x25, 0x0a, 0x19, 0x36, 0x28, 0x07,
+	0x3a, 0x15, 0x0b, 0x24, 0x37, 0x18, 0x06, 0x29,
+	0x20, 0x0f, 0x11, 0x3e, 0x2d, 0x02, 0x1c, 0x33,
+	0x09, 0x26, 0x38, 0x17, 0x04, 0x2b, 0x35, 0x1a,
+	0x13, 0x3c, 0x22, 0x0d, 0x1e, 0x31, 0x2f, 0x00,
+	0x3d, 0x12, 0x0c, 0x23, 0x30, 0x1f, 0x01, 0x2e,
+	0x27, 0x08, 0x16, 0x39, 0x2a, 0x05, 0x1b, 0x34,
+	0x1c, 0x33, 0x2d, 0x02, 0x11, 0x3e, 0x20, 0x0f,
+	0x06, 0x29, 0x37, 0x18, 0x0b, 0x24, 0x3a, 0x15,
+	0x28, 0x07, 0x19, 0x36, 0x25, 0x0a, 0x14, 0x3b,
+	0x32, 0x1d, 0x03, 0x2c, 0x3f, 0x10, 0x0e, 0x21,
+	0x1b, 0x34, 0x2a, 0x05, 0x16, 0x39, 0x27, 0x08,
+	0x01, 0x2e, 0x30, 0x1f, 0x0c, 0x23, 0x3d, 0x12,
+	0x2f, 0x00, 0x1e, 0x31, 0x22, 0x0d, 0x13, 0x3c,
+	0x35, 0x1a, 0x04, 0x2b, 0x38, 0x17, 0x09, 0x26,
+	0x12, 0x3d, 0x23, 0x0c, 0x1f, 0x30, 0x2e, 0x01,
+	0x08, 0x27, 0x39, 0x16, 0x05, 0x2a, 0x34, 0x1b,
+	0x26, 0x09, 0x17, 0x38, 0x2b, 0x04, 0x1a, 0x35,
+	0x3c, 0x13, 0x0d, 0x22, 0x31, 0x1e, 0x00, 0x2f,
+	0x15, 0x3a, 0x24, 0x0b, 0x18, 0x37, 0x29, 0x06,
+	0x0f, 0x20, 0x3e, 0x11, 0x02, 0x2d, 0x33, 0x1c,
+	0x21, 0x0e, 0x10, 0x3f, 0x2c, 0x03, 0x1d, 0x32,
+	0x3b, 0x14, 0x0a, 0x25, 0x36, 0x19, 0x07, 0x28,
+};
+
+/* Compute 3GPP CRC-6 over the ctrl register (16 bits) and the lower
+ * 10 bits of the len_ret register. The 26-bit input is packed as
+ * { len_ret[9:0], ctrl[15:0] } and processed LSB-first through the
+ * lookup table.
+ */
+static u8 mxl862xx_crc6(u16 ctrl, u16 len_ret)
+{
+	u32 data = ((u32)(len_ret & LEN_RET_LEN_MASK) << 16) | ctrl;
+	u8 crc = 0;
+	int i;
+
+	for (i = 0; i < sizeof(data); i++, data >>= 8)
+		crc = mxl862xx_crc6_table[(crc << 2) ^ (data & 0xff)] & 0x3f;
+
+	return crc;
+}
+
+/* Encode CRC-6 into the ctrl and len_ret registers before writing them
+ * to MDIO. The caller must set ctrl = API_ID | CTRL_BUSY_MASK |
+ * CTRL_CRC_FLAG, and len_ret = parameter length (bits 0-9 only).
+ *
+ * After encoding:
+ *   ctrl[12:0]     = API ID (unchanged)
+ *   ctrl[14:13]    = CRC-6 bits 5-4
+ *   ctrl[15]       = busy flag (unchanged)
+ *   len_ret[9:0]   = parameter length (unchanged)
+ *   len_ret[13:10] = CRC-6 bits 3-0
+ *   len_ret[14]    = original ctrl[14] (CRC check flag, forwarded to FW)
+ *   len_ret[15]    = original ctrl[13] (magic bit, always 1)
+ */
+static void mxl862xx_crc6_encode(u16 *pctrl, u16 *plen_ret)
+{
+	u16 crc, ctrl, len_ret;
+
+	/* Set magic bit before CRC computation */
+	*pctrl |= BIT(13);
+
+	crc = mxl862xx_crc6(*pctrl, *plen_ret);
+
+	/* Place CRC MSB (bits 5-4) into ctrl bits 13-14 */
+	ctrl = (*pctrl & ~GENMASK(14, 13));
+	ctrl |= (crc & 0x30) << 9;
+
+	/* Place CRC LSB (bits 3-0) into len_ret bits 10-13 */
+	len_ret = *plen_ret | ((crc & 0x0f) << 10);
+
+	/* Forward ctrl[14] (CRC check flag) to len_ret[14],
+	 * and ctrl[13] (magic, always 1) to len_ret[15].
+	 */
+	len_ret |= (*pctrl & BIT(14)) | ((*pctrl & BIT(13)) << 2);
+
+	*pctrl = ctrl;
+	*plen_ret = len_ret;
+}
+
+/* Verify CRC-6 on a firmware response and extract the return value.
+ *
+ * The firmware encodes the return value as a signed 11-bit integer:
+ *   - Sign bit (bit 10) in ctrl[14]
+ *   - Magnitude (bits 9-0) in len_ret[9:0]
+ * These are recoverable after CRC-6 verification by restoring the
+ * original ctrl from the auxiliary copies in len_ret[15:14].
+ *
+ * Return: 0 on CRC match (with *result set), or -EIO on mismatch.
+ */
+static int mxl862xx_crc6_verify(u16 ctrl, u16 len_ret, int *result)
+{
+	u16 crc_recv, crc_calc;
+
+	/* Extract the received CRC-6 */
+	crc_recv = ((ctrl >> 9) & 0x30) | ((len_ret >> 10) & 0x0f);
+
+	/* Reconstruct the original ctrl for re-computation:
+	 *   ctrl[14] = len_ret[14] (sign bit / CRC check flag)
+	 *   ctrl[13] = len_ret[15] >> 2 (magic bit)
+	 */
+	ctrl &= ~GENMASK(14, 13);
+	ctrl |= len_ret & BIT(14);
+	ctrl |= (len_ret & BIT(15)) >> 2;
+
+	crc_calc = mxl862xx_crc6(ctrl, len_ret);
+	if (crc_recv != crc_calc)
+		return -EIO;
+
+	/* Extract signed 11-bit return value:
+	 *   bit 10 (sign) from ctrl[14], bits 9-0 from len_ret[9:0]
+	 */
+	*result = sign_extend32((len_ret & LEN_RET_LEN_MASK) |
+				((ctrl & CTRL_CRC_FLAG) >> 4), 10);
+
+	return 0;
+}
 
 static int mxl862xx_reg_read(struct mxl862xx_priv *priv, u32 addr)
 {
@@ -52,60 +209,78 @@ static int mxl862xx_busy_wait(struct mxl862xx_priv *priv)
 				  !(val & CTRL_BUSY_MASK), 15, 500000);
 }
 
-static int mxl862xx_set_data(struct mxl862xx_priv *priv, u16 words)
+/* Issue a firmware command with CRC-6 protection on the ctrl and len_ret
+ * registers, wait for completion, and verify the response CRC-6.
+ *
+ * Return: firmware result value (>= 0) on success, or negative errno.
+ */
+static int mxl862xx_issue_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 len)
 {
-	int ret;
-	u16 cmd;
+	u16 ctrl_enc, len_enc;
+	int ret, fw_result;
+
+	ctrl_enc = cmd | CTRL_BUSY_MASK | CTRL_CRC_FLAG;
+	len_enc = len;
+	mxl862xx_crc6_encode(&ctrl_enc, &len_enc);
+
+	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, len_enc);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL, ctrl_enc);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_busy_wait(priv);
+	if (ret < 0)
+		return ret;
+
+	ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_CTRL);
+	if (ret < 0)
+		return ret;
+	ctrl_enc = ret;
 
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET,
-				 MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
+	ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_LEN_RET);
 	if (ret < 0)
 		return ret;
+	len_enc = ret;
+
+	ret = mxl862xx_crc6_verify(ctrl_enc, len_enc, &fw_result);
+	if (ret) {
+		if (!test_and_set_bit(0, &priv->crc_err))
+			schedule_work(&priv->crc_err_work);
+		return -EIO;
+	}
+
+	return fw_result;
+}
+
+static int mxl862xx_set_data(struct mxl862xx_priv *priv, u16 words)
+{
+	u16 cmd;
 
 	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE - 1;
 	if (!(cmd < 2))
 		return -EINVAL;
 
 	cmd += MMD_API_SET_DATA_0;
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
-				 cmd | CTRL_BUSY_MASK);
-	if (ret < 0)
-		return ret;
 
-	return mxl862xx_busy_wait(priv);
+	return mxl862xx_issue_cmd(priv, cmd,
+				  MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
 }
 
 static int mxl862xx_get_data(struct mxl862xx_priv *priv, u16 words)
 {
-	int ret;
 	u16 cmd;
 
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET,
-				 MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
-	if (ret < 0)
-		return ret;
-
 	cmd = words / MXL862XX_MMD_REG_DATA_MAX_SIZE;
 	if (!(cmd > 0 && cmd < 3))
 		return -EINVAL;
 
 	cmd += MMD_API_GET_DATA_0;
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
-				 cmd | CTRL_BUSY_MASK);
-	if (ret < 0)
-		return ret;
-
-	return mxl862xx_busy_wait(priv);
-}
 
-static int mxl862xx_firmware_return(int ret)
-{
-	/* Only 16-bit values are valid. */
-	if (WARN_ON(ret & GENMASK(31, 16)))
-		return -EINVAL;
-
-	/* Interpret value as signed 16-bit integer. */
-	return (s16)ret;
+	return mxl862xx_issue_cmd(priv, cmd,
+				  MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));
 }
 
 static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
@@ -113,30 +288,23 @@ static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
 {
 	int ret;
 
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_LEN_RET, size);
-	if (ret)
-		return ret;
-
-	ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_CTRL,
-				 cmd | CTRL_BUSY_MASK);
-	if (ret)
-		return ret;
-
-	ret = mxl862xx_busy_wait(priv);
-	if (ret)
-		return ret;
+	ret = mxl862xx_issue_cmd(priv, cmd, size);
 
-	ret = mxl862xx_reg_read(priv, MXL862XX_MMD_REG_LEN_RET);
-	if (ret < 0)
-		return ret;
-
-	/* handle errors returned by the firmware as -EIO
+	/* Handle errors returned by the firmware as -EIO.
 	 * The firmware is based on Zephyr OS and uses the errors as
 	 * defined in errno.h of Zephyr OS. See
 	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
+	 *
+	 * The firmware signals CRC validation failures with dedicated
+	 * error codes outside the normal Zephyr errno range:
+	 *   -1024: CRC-6 mismatch on ctrl/len_ret registers
+	 *   -1023: CRC-16 mismatch on data payload
 	 */
-	ret = mxl862xx_firmware_return(ret);
 	if (ret < 0) {
+		if ((ret == MXL862XX_FW_CRC6_ERR ||
+		     ret == MXL862XX_FW_CRC16_ERR) &&
+		    !test_and_set_bit(0, &priv->crc_err))
+			schedule_work(&priv->crc_err_work);
 		if (!quiet)
 			dev_err(&priv->mdiodev->dev,
 				"CMD %04x returned error %d\n", cmd, ret);
@@ -151,7 +319,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 {
 	__le16 *data = _data;
 	int ret, cmd_ret;
-	u16 max, i;
+	u16 max, crc, i;
 
 	dev_dbg(&priv->mdiodev->dev, "CMD %04x DATA %*ph\n", cmd, size, data);
 
@@ -163,26 +331,45 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < max; i++) {
+	/* Compute CRC-16 over the data payload; written as an extra word
+	 * after the data so the firmware can verify the transfer.
+	 */
+	crc = crc16(0xffff, (const u8 *)data, size);
+
+	for (i = 0; i < max + 1; i++) {
 		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
+		u16 val;
 
 		if (i && off == 0) {
 			/* Send command to set data when every
 			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are written.
-			 */
+			  */
 			ret = mxl862xx_set_data(priv, i);
 			if (ret < 0)
 				goto out;
 		}
 
-		if ((i * 2 + 1) == size)
-			ret = mxl862xx_reg_write(priv,
-						 MXL862XX_MMD_REG_DATA_FIRST + off,
-						 *(u8 *)&data[i]);
-		else
-			ret = mxl862xx_reg_write(priv,
-						 MXL862XX_MMD_REG_DATA_FIRST + off,
-						 le16_to_cpu(data[i]));
+		if (i == max) {
+			/* Even size: full CRC word.
+			 * Odd size: only CRC high byte remains (low byte
+			 * was packed into the previous word).
+			 */
+			val = (size & 1) ? crc >> 8 : crc;
+		} else if ((i * 2 + 1) == size) {
+			/* Special handling for last BYTE if it's not WORD
+			 * aligned to avoid reading beyond the allocated data
+			 * structure.  Pack the CRC low byte into the high
+			 * byte of this word so it sits at byte offset 'size'
+			 * in the firmware's contiguous buffer.
+			 */
+			val = *(u8 *)&data[i] | ((crc & 0xff) << 8);
+		} else {
+			val = le16_to_cpu(data[i]);
+		}
+
+		ret = mxl862xx_reg_write(priv,
+					 MXL862XX_MMD_REG_DATA_FIRST + off,
+					 val);
 		if (ret < 0)
 			goto out;
 	}
@@ -194,13 +381,13 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	/* store result of mxl862xx_send_cmd() */
 	cmd_ret = ret;
 
-	for (i = 0; i < max; i++) {
+	for (i = 0; i < max + 1; i++) {
 		u16 off = i % MXL862XX_MMD_REG_DATA_MAX_SIZE;
 
 		if (i && off == 0) {
 			/* Send command to fetch next batch of data when every
 			 * MXL862XX_MMD_REG_DATA_MAX_SIZE of WORDs are read.
-			 */
+			  */
 			ret = mxl862xx_get_data(priv, i);
 			if (ret < 0)
 				goto out;
@@ -210,17 +397,35 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 		if (ret < 0)
 			goto out;
 
-		if ((i * 2 + 1) == size) {
+		if (i == max) {
+			/* Even size: full CRC word.
+			 * Odd size: only CRC high byte remains (low byte
+			 * was in the previous word).
+			 */
+			if (size & 1)
+				crc = (crc & 0x00ff) |
+				      (((u16)ret & 0xff) << 8);
+			else
+				crc = (u16)ret;
+		} else if ((i * 2 + 1) == size) {
 			/* Special handling for last BYTE if it's not WORD
 			 * aligned to avoid writing beyond the allocated data
-			 * structure.
+			 * structure.  The high byte carries the CRC low byte.
 			 */
 			*(uint8_t *)&data[i] = ret & 0xff;
+			crc = (ret >> 8) & 0xff;
 		} else {
 			data[i] = cpu_to_le16((u16)ret);
 		}
 	}
 
+	if (crc16(0xffff, (const u8 *)data, size) != crc) {
+		if (!test_and_set_bit(0, &priv->crc_err))
+			schedule_work(&priv->crc_err_work);
+		ret = -EIO;
+		goto out;
+	}
+
 	/* on success return the result of the mxl862xx_send_cmd() */
 	ret = cmd_ret;
 
@@ -249,3 +454,13 @@ int mxl862xx_reset(struct mxl862xx_priv *priv)
 
 	return ret;
 }
+
+void mxl862xx_host_init(struct mxl862xx_priv *priv)
+{
+	INIT_WORK(&priv->crc_err_work, mxl862xx_crc_err_work_fn);
+}
+
+void mxl862xx_host_shutdown(struct mxl862xx_priv *priv)
+{
+	cancel_work_sync(&priv->crc_err_work);
+}
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
index 7cc496f6be5cc..84512a30bc185 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -5,6 +5,8 @@
 
 #include "mxl862xx.h"
 
+void mxl862xx_host_init(struct mxl862xx_priv *priv);
+void mxl862xx_host_shutdown(struct mxl862xx_priv *priv);
 int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 		      bool read, bool quiet);
 int mxl862xx_reset(struct mxl862xx_priv *priv);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index c825704c9e9ec..78eef639628a0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -424,6 +424,7 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	ds->ops = &mxl862xx_switch_ops;
 	ds->phylink_mac_ops = &mxl862xx_phylink_mac_ops;
 	ds->num_ports = MXL862XX_MAX_PORTS;
+	mxl862xx_host_init(priv);
 
 	dev_set_drvdata(dev, ds);
 
@@ -433,22 +434,32 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 static void mxl862xx_remove(struct mdio_device *mdiodev)
 {
 	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
+	struct mxl862xx_priv *priv;
 
 	if (!ds)
 		return;
 
+	priv = ds->priv;
+
 	dsa_unregister_switch(ds);
+
+	mxl862xx_host_shutdown(priv);
 }
 
 static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 {
 	struct dsa_switch *ds = dev_get_drvdata(&mdiodev->dev);
+	struct mxl862xx_priv *priv;
 
 	if (!ds)
 		return;
 
+	priv = ds->priv;
+
 	dsa_switch_shutdown(ds);
 
+	mxl862xx_host_shutdown(priv);
+
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index bfeb436942d5f..3ca0d386f3e8f 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -11,6 +11,8 @@
 struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
+	struct work_struct crc_err_work;
+	unsigned long crc_err;
 };
 
 #endif /* __MXL862XX_H */
-- 
2.53.0

