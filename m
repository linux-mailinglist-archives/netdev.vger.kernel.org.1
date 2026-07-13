Return-Path: <netdev+bounces-307162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+OcBeDlVGroggAAu9opvQ
	(envelope-from <netdev+bounces-307162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FD74B763
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:19:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C7xpwlSe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 360C83085867
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D341C31D;
	Mon, 13 Jul 2026 13:12:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93A41C2F7
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:12:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948364; cv=none; b=oZeqk3toobn8K5n+nHgK5MVYmt1YSnBEFWPgVQBt//UxZlwsrUWMHh3wogRL5xB/NxgcJ/+kYVl0wzcTC86T4eQ78l+DZNxvSeZSBGRUGsp+nA43jRxN1LNbzDpxVDMGjq11I/r7mZxbTKiPqXXpZcH3WrnWAGHtgc4Jyav33+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948364; c=relaxed/simple;
	bh=cDHVq9CqIfRIR62uRu3GOuluHC1aL1utukQGqNQ6q6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFD5JjPyoBQRs++e0WH+j2p3VSuzervnlJLgmeXO7X7PTYhsZAt719FVJzxo+pcqEP0kH+VSX6zsByZHgFgHLVGVUPAEXUI9LaUolEoUsVnQ1VPR4+Zi9k4FsmXBRXGbF7gwrfz7St14vn9PlyHb5EfJO3yr0/wODJJiJ2D9mYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7xpwlSe; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so30444475e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948360; x=1784553160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wLf6kKfoShCl5BdpP53JOz8OPZ6lUDbwTAoSkb8Jww=;
        b=C7xpwlSet/0uUJizu6e5E93MDVagbsUqXw3nbdRVJLGByGezdpFo0ONM4Ibytv+bU4
         2LlGBO58pE+Wfl3JoWE5vlnwi7LuHOFNWPKxEX88vVQMlAvOZwoVkXwEg+0NuzFl/+dN
         HpEIvtDKQts34w0QgbxO3KA8y6sKvHeu/zOjNQdvnEZCDPWVyz+xn/2JUdUnY28Ug25G
         pNKIaq67ylzy3Ki8IfrwScIDFczwaAvX5ngskZzF3Lw+Fj7EQWeDsV6+PUv5VqXYUJd3
         ck9kH43g8UpFSvGAquawlxRaS/jmJm0K8ZxdU6WukK99NCNAoMFk+h6g7bw4zlRQF0El
         f+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948360; x=1784553160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wLf6kKfoShCl5BdpP53JOz8OPZ6lUDbwTAoSkb8Jww=;
        b=b5wtNDLB5tM9uVFvmNSXtsbVgtm8U63A/WGz2UN9BXIXFqfXRpZnJEQ7MhikMxS4iV
         XnZ8RxxqW0EaLo433fWUNk+NVoxM0pbtcOqcVBCD6OLJm4L1hVI4bbuM0+HsJeot7nUT
         pvCDwBGox0NQ0ZwjpmO+dvrI0IyOWVqf1smHALGCKassUvKqhnaFK4ioV2dUMWqKHpQH
         nO4BTB8NDeaPY7rHS9kL7XGTOmxug4WD1cCHL8gTxL9iMhzgLPotswzFN4IQ9OCSLdG5
         noxFzP5B6ZzCecJnttPSQJD01/ISmdNS5LRxaUUanX6E7TDvusRhbB1oFYlMqvjdTh44
         BOdg==
X-Gm-Message-State: AOJu0YzKFBPqXbQYI9n7Ik7gRW3tW8oHNR3NU+vA5U2DMQ2sLw8YUtsp
	X943EzM7KAhlP4c4U5tIjTLMzsesYSsZt+2pKuIQpKFWD2kcEFBkPpiMSqSeng==
X-Gm-Gg: AfdE7ckPL8pfOnrmuZPJxt5r7DrXXqF78ApO4TEMIgrAJt+UyBfWDiY7JMgtaZyZJoD
	KVyiNiWE5rHeWkzHHhFnAP+RhFM63yK31ujnq+avpNkxMZFRRyFDeLrzaRwHJ/Q6iaiOUAIpZ+8
	dBBlwIJxwo04Skg4BEHWF86Kcrx6pHOv7pfbxy1oPPShXJG5qhHioYP7dtkJFonX5fuaFlFrVWL
	bgLvLOadSKH6fNLdCrbLqYu+f9HfJC+p8gM6eD4HFpGF2DYvdHf+T03cX27LWDfOwEWNaFfbY/y
	MuSG6igebcNRm/H+Whi4XUk1uC4ACAcbiYb+t+uHDlqUHiLTxs6ftKeGR9SdBxxpy5n+hpRrlU7
	rIRG4uyfp4fid6E21u2xfahJEQLrpzFs+5WPEKG3hNnBwVIc/HfQvtuKnpKhwyiiTMW+EUH+zYQ
	ogmBsJWSx85EoP
X-Received: by 2002:a05:600c:4754:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493f88262ddmr86665705e9.26.1783948359834;
        Mon, 13 Jul 2026 06:12:39 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3dcdsm354106345e9.3.2026.07.13.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:12:39 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 2/2] net: phy: add DAPU Telecom DAP8210R(I) Gigabit Ethernet PHY driver
Date: Mon, 13 Jul 2026 16:12:23 +0300
Message-ID: <20260713131223.279555-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713131223.279555-1-a.shimko.dev@gmail.com>
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307162-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:a.shimko.dev@gmail.com,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:ashimkodev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashimkodev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 954FD74B763

Add a new PHY driver for the DAPU Telecom DAP8211R(I) Gigabit
Ethernet PHY, which is commonly used in enterprise and industrial
networking applications.

The driver implements extended register access via indirect addressing
through corresponding registers, and provides comprehensive device tree
support for RGMII delay configuration. The rx-internal-delay-ps and
tx-internal-delay-ps properties allow precise tuning of clock delays in
150 ps steps from 0 to 2250 ps, with automatic selection of the nearest
supported value if an exact match is not specified. Additionally,
the optional tx-inverted-clk flag enables 180-degree TX clock phase shift
for boards where signal integrity or MAC requirements necessitate clock
inversion. The driver also exports a debugfs interface for diagnostics,
exposing PHY status registers and providing runtime control over the
internal packet generator, CRC corruption, and loopback functionality.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/net/phy/Kconfig    |  10 +
 drivers/net/phy/Makefile   |   1 +
 drivers/net/phy/dap8211r.c | 544 +++++++++++++++++++++++++++++++++++++
 3 files changed, 555 insertions(+)
 create mode 100644 drivers/net/phy/dap8211r.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..4576f707ac94 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -237,6 +237,16 @@ config DAVICOM_PHY
 	help
 	  Currently supports dm9161e and dm9131
 
+config DAP8211R_PHY
+	tristate "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY"
+	depends on OF
+	help
+	  Support for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+	  This PHY is designed for enterprise and industrial networking
+	  applications, supporting 10/100/1000 Mbps operation.
+	  RGMII with: configurable TX/RX clock delays, optional flag to enable
+	  180-degree TX clock phase shift and internal packet generator.
+
 config ICPLUS_PHY
 	tristate "ICPlus PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..ad35733eb4bb 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_CICADA_PHY)	+= cicada.o
 obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
 obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
+obj-$(CONFIG_DAP8211R_PHY)	+= dap8211r.o
 obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
 obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
new file mode 100644
index 000000000000..bd695bc4953a
--- /dev/null
+++ b/drivers/net/phy/dap8211r.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Driver for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
+ *
+ * Specifications:
+ *   - IEEE 802.3 10BASE-Te, 100BASE-TX, 1000BASE-T
+ *   - IEEE 802.3az-2010 Energy Efficient Ethernet
+ *   - IEEE 1588 SyncE support
+ *   - RGMII
+ *   - Package Generator for diagnostics
+ *
+ * Author: Artem Shimko <a.shimko.dev@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define DAP8211R_PHY_ID			0x0008011B
+#define DAP8211R_PHY_ID_MASK		0xFFFFFFFF
+
+#define DAP8211R_EXT_ADD		0x1E
+#define DAP8211R_EXT_DATA		0x1F
+
+#define DAP8211R_PKGC5			0xA0
+#define DAP8211R_PKG_PL_MASK		GENMASK(1, 0)
+#define DAP8211R_PKG_PL_5AA5		BIT(1)
+#define DAP8211R_PKG_COR_CRC		BIT(2)
+#define DAP8211R_PKG_GEN_EN		BIT(12)
+#define DAP8211R_PKG_GEN_MODE		BIT(13)
+#define DAP8211R_PKG_GATE_EN		BIT(14)
+#define DAP8211R_PKG_CHK_EN		BIT(15)
+#define DAP8211R_PKG_GEN_MASK		GENMASK(15, 12)
+
+#define DAP8211R_PHY_CON		0xA001
+#define DAP8211R_PHY_LDO_EN		BIT(6)
+#define DAP8211R_PHY_RX_DLY		BIT(8)
+#define DAP8211R_PHY_GATE_RX_CLK	BIT(9)
+#define DAP8211R_PHY_SW_RST		BIT(15)
+
+#define DAP8211R_RGMII_CON		0xA003
+#define DAP8211R_RGMII_TX_DEL_MASK	GENMASK(3, 0)
+#define DAP8211R_RGMII_RX_DEL_MASK	GENMASK(13, 10)
+#define DAP8211R_RGMII_CLK_INVERT	BIT(14)
+
+/* Default RGMII delay (1.95ns == 13 * 150)ps) */
+#define DAP8211R_DEFAULT_DELAY_PS	1950
+
+struct dap8211r_delay_config {
+	u32 ps;
+	u8 sel;
+};
+
+static const struct dap8211r_delay_config delay_config[] = {
+	{   0, 0},
+	{ 150, 1},
+	{ 300, 2},
+	{ 450, 3},
+	{ 600, 4},
+	{ 750, 5},
+	{ 900, 6},
+	{1050, 7},
+	{1200, 8},
+	{1350, 9},
+	{1500, 10},
+	{1650, 11},
+	{1800, 12},
+	{1950, 13},
+	{2100, 14},
+	{2250, 15},
+};
+
+#define DAP8211R_DELAY_COUNT	ARRAY_SIZE(delay_config)
+
+struct dap8211r_priv {
+	struct device *dev;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *root_dir;
+	bool crc_cor;
+	bool loopback;
+#endif
+};
+
+/**
+ * dap8211r_delay_ps_to_sel() - Convert picoseconds to register value
+ * @ps: Delay in picoseconds (0-2250)
+ *
+ * Converts a delay value in picoseconds to the corresponding register value
+ * for RGMII delay configuration. The PHY supports 150ps steps from 0 to 2250ps.
+ *
+ * Return: Register value (0-15)
+ */
+static u16 dap8211r_delay_ps_to_sel(struct phy_device *phydev, u32 ps)
+{
+	int i, best_idx = 0;
+	u32 best_diff = UINT_MAX, diff = 0;
+
+	if (!ps)
+		return 0;
+
+	for (i = 0; i < DAP8211R_DELAY_COUNT; i++) {
+		diff = abs(ps - delay_config[i].ps);
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			best_idx = i;
+		}
+
+		if (!diff)
+			break;
+	}
+
+	if (best_diff)
+		phydev_warn(phydev, "Delay %u ps not found, using closest %u ps\n", ps,
+			    delay_config[best_idx].ps);
+
+	phydev_dbg(phydev, "Delay ps idx: %u\n", delay_config[best_idx].sel);
+
+	return delay_config[best_idx].sel;
+}
+
+/**
+ * dap8211r_read_ext() - Read extended register
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ *
+ * Reads a PHY extended register using the indirect access method.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: Register value on success, or negative error code
+ */
+static int dap8211r_read_ext(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_read(phydev, DAP8211R_EXT_DATA);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_modify_ext() - Modify extended register bits
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ * @mask: Bit mask of bits to clear
+ * @set: Bit mask of bits to set
+ *
+ * Modifies a PHY extended register using the indirect access method.
+ * New value = (old value & ~mask) | set.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_modify_ext(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_modify(phydev, DAP8211R_EXT_DATA, mask, set);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+/**
+ * dap8211r_get_rgmii_delay() - Get RGMII delay from device tree
+ * @phydev: PHY device structure
+ * @prop_name: Device tree property name
+ *
+ * Reads the RGMII delay from the device tree. If the property is not
+ * specified, the default delay (1950ps) is used.
+ *
+ * Return: Register value (0-15) or default if property not found
+ */
+static u32 dap8211r_get_rgmii_delay(struct phy_device *phydev, const char *prop_name)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	int ret;
+	u32 ps = 0;
+
+	ret = of_property_read_u32(np, prop_name, &ps);
+	if (ret) {
+		phydev_dbg(phydev, "Using default delay (%ups)\n", DAP8211R_DEFAULT_DELAY_PS);
+		ps = DAP8211R_DEFAULT_DELAY_PS;
+	}
+
+	return dap8211r_delay_ps_to_sel(phydev, ps);
+}
+
+/**
+ * dap8211r_config_init() - Initialize PHY
+ * @phydev: PHY device structure
+ *
+ * Configures the PHY during initialization:
+ * - RGMII delays based on interface mode
+ * - TX clock invertion
+ * - Software reset to apply settings
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_config_init(struct phy_device *phydev)
+{
+	struct device_node *phydev_node = phydev->mdio.dev.of_node;
+	u16 mask = 0, set = 0;
+	int ret;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK,
+				 dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps"));
+		mask = DAP8211R_RGMII_RX_DEL_MASK;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK,
+				 dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps"));
+		mask = DAP8211R_RGMII_RX_DEL_MASK;
+		fallthrough;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK,
+				  dap8211r_get_rgmii_delay(phydev, "tx-internal-delay-ps"));
+		mask |= DAP8211R_RGMII_TX_DEL_MASK;
+		break;
+	default:
+		phydev_err(phydev, "Unsupported interface: %d\n",
+			   phydev->interface);
+		return -EINVAL;
+	}
+
+	if (of_property_read_bool(phydev_node, "tx-use-inverted-clk"))
+		set |= DAP8211R_RGMII_CLK_INVERT;
+
+	mask |= DAP8211R_RGMII_CLK_INVERT;
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_PHY_CON, DAP8211R_PHY_SW_RST, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for reset self-clear */
+	fsleep(200);
+
+	ret = dap8211r_modify_ext(phydev, DAP8211R_RGMII_CON, mask, set);
+	if (ret)
+		return ret;
+
+	phydev_dbg(phydev, "RGMII configured: interface=%d, mask=0x%04x, set=0x%04x\n",
+		   phydev->interface, mask, set);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+/**
+ * info_show() - Show PHY status information
+ * @sf: Sequence file structure
+ * @data: Private data (struct dap8211r_priv *)
+ *
+ * Displays PHY configuration and status registers for debugging.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int info_show(struct seq_file *sf, void *data)
+{
+	struct dap8211r_priv *priv = sf->private;
+	struct phy_device *phydev = to_phy_device(priv->dev);
+	int val;
+
+	val = dap8211r_read_ext(phydev, DAP8211R_PHY_CON);
+	if (val < 0)
+		return val;
+
+	seq_printf(sf, "PHY_CON: 0x%04x\n", val);
+	seq_printf(sf, "  LDO enabled: %s\n", FIELD_GET(DAP8211R_PHY_LDO_EN, val)  ?
+		   "yes" : "no");
+	seq_printf(sf, "  RX dly en: %s\n", FIELD_GET(DAP8211R_PHY_RX_DLY, val) ?
+		   "yes" : "no");
+	seq_printf(sf, "  RX ckl gating: %s\n", FIELD_GET(DAP8211R_PHY_GATE_RX_CLK, val) ?
+		   "yes" : "no");
+
+	val = dap8211r_read_ext(phydev, DAP8211R_RGMII_CON);
+	if (val < 0)
+		return val;
+
+	seq_printf(sf, "RGMII_CON: 0x%04x\n", val);
+	seq_printf(sf, "  TX delay idx: %lx\n", FIELD_GET(DAP8211R_RGMII_TX_DEL_MASK, val));
+	seq_printf(sf, "  RX delay idx: %lx\n", FIELD_GET(DAP8211R_RGMII_RX_DEL_MASK, val));
+	seq_printf(sf, "  CLK invert: %s\n", FIELD_GET(DAP8211R_RGMII_CLK_INVERT, val) ?
+		   "yes" : "no");
+
+	val = phy_read(phydev, MII_BMSR);
+	if (val < 0)
+		return val;
+
+	seq_printf(sf, "BMSR: 0x%04x\n", val);
+	seq_printf(sf, "  Link: %s\n", FIELD_GET(BMSR_LSTATUS, val) ?
+		   "up" : "down");
+	seq_printf(sf, "  AN complete: %s\n", FIELD_GET(BMSR_ANEGCOMPLETE, val) ?
+		   "yes" : "no");
+
+	val = dap8211r_read_ext(phydev, DAP8211R_PKGC5);
+	if (val < 0)
+		return val;
+
+	if (FIELD_GET(DAP8211R_PKG_GEN_EN, val) &&
+	    FIELD_GET(DAP8211R_PKG_CHK_EN, val))
+		seq_puts(sf, "WARNING: Package Generating enabled\n");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(info);
+
+/**
+ * pkg_gen_show() - Show packet generator status
+ * @sf: Sequence file structure
+ * @data: Private data (struct dap8211r_priv *)
+ *
+ * Displays the current status of the internal packet generator,
+ * including CRC corruption and loopback settings.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int pkg_gen_show(struct seq_file *sf, void *data)
+{
+	struct dap8211r_priv *priv = sf->private;
+	struct phy_device *phydev = to_phy_device(priv->dev);
+	int val;
+
+	val = dap8211r_read_ext(phydev, DAP8211R_PKGC5);
+	if (val < 0)
+		return val;
+
+	seq_puts(sf, "Package Generating: ");
+	if (FIELD_GET(DAP8211R_PKG_GEN_EN, val) &&
+	    FIELD_GET(DAP8211R_PKG_CHK_EN, val))
+		seq_puts(sf, "enabled\n");
+	else
+		seq_puts(sf, "disabled\n");
+
+	seq_printf(sf, "CRC corruption en: %s\n", FIELD_GET(DAP8211R_PKG_COR_CRC, val) ?
+		   "enabled" : "disabled");
+
+	val = phy_read(phydev, MII_BMCR);
+	if (val < 0)
+		return val;
+
+	seq_printf(sf, "Loopback en: %s\n", FIELD_GET(BMCR_LOOPBACK, val) ?
+		   "enabled" : "disabled");
+	return 0;
+}
+
+/**
+ * pkg_gen_write() - Enable/disable packet generator
+ * @file: File structure
+ * @user_buf: User space buffer
+ * @count: Buffer size
+ * @ppos: File position
+ *
+ * Enables or disables the internal packet generator.
+ * Also controls loopback and CRC corruption via debugfs flags.
+ *
+ * NOTE: We intentionally do not use genphy_loopback() here.
+ * genphy_loopback() does a full BMCR overwrite (mask = ~0) and
+ * waits up to 500 ms for link in loopback mode. This is too
+ * heavy for a diagnostic packet generator:
+ *
+ * - It destroys all other BMCR state (speed, duplex, AN config).
+ * - The 500 ms link poll is unnecessary: we already have a link
+ *   or are deliberately setting up a test condition.
+ * - We want to minimize changes to BMCR during debugging.
+ *
+ * Return: Number of bytes written on success, or negative error code
+ */
+static ssize_t pkg_gen_write(struct file *file,
+			     const char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct dap8211r_priv *priv = sf->private;
+	struct phy_device *phydev = to_phy_device(priv->dev);
+	bool en;
+	u16 mask, set, set_bmcr;
+	int ret;
+
+	ret = kstrtobool_from_user(user_buf, count, &en);
+	if (ret)
+		return ret;
+
+	if (en) {
+		set = DAP8211R_PKG_GEN_EN | DAP8211R_PKG_CHK_EN | DAP8211R_PKG_PL_5AA5;
+
+		if (priv->crc_cor)
+			set |= DAP8211R_PKG_COR_CRC;
+
+		if (priv->loopback)
+			set_bmcr = BMCR_LOOPBACK;
+		else
+			set_bmcr = BMCR_ANENABLE;
+	} else {
+		set = DAP8211R_PKG_GEN_MODE | DAP8211R_PKG_GATE_EN;
+		set_bmcr = BMCR_ANENABLE;
+	}
+
+	ret = phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK | BMCR_ANENABLE, set_bmcr);
+	if (ret < 0)
+		return ret;
+
+	mask = DAP8211R_PKG_GEN_MASK | DAP8211R_PKG_PL_MASK | DAP8211R_PKG_COR_CRC;
+	ret = dap8211r_modify_ext(phydev, DAP8211R_PKGC5, mask, set);
+	if (ret < 0) {
+		phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK, 0);
+		return ret;
+	}
+
+	return count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(pkg_gen);
+
+/**
+ * dap8211r_debug_init() - Initialize debugfs entries
+ * @priv: Private driver data
+ *
+ * Creates debugfs directory and files for PHY debugging.
+ * - info: PHY status information
+ * - pkg_gen: Enable/disable generator (1/0)
+ * - pkg_gen_crc_cor: Enable CRC corruption (Y/N)
+ * - pkg_gen_loopback: Enable loopback (Y/N)
+ *
+ * Debugfs is only available when CONFIG_DEBUG_FS is enabled.
+ */
+static void dap8211r_debug_init(struct dap8211r_priv *priv)
+{
+	priv->root_dir = debugfs_create_dir(dev_name(priv->dev), NULL);
+	if (IS_ERR(priv->root_dir))
+		return;
+
+	debugfs_create_file("info", 0444, priv->root_dir, priv,
+			    &info_fops);
+	debugfs_create_file("pkg_gen", 0644, priv->root_dir, priv,
+			    &pkg_gen_fops);
+	debugfs_create_bool("pkg_gen_crc_cor", 0644, priv->root_dir,
+			    &priv->crc_cor);
+	debugfs_create_bool("pkg_gen_loopback", 0644, priv->root_dir,
+			    &priv->loopback);
+}
+
+/**
+ * dap8211r_debug_remove() - Remove debugfs entries
+ * @priv: Private driver data
+ *
+ * Recursively removes all debugfs files and directories created
+ * by dap8211r_debug_init().
+ */
+static void dap8211r_debug_remove(struct dap8211r_priv *priv)
+{
+	debugfs_remove_recursive(priv->root_dir);
+}
+
+#else /* !CONFIG_DEBUG_FS */
+static void dap8211r_debug_init(struct dap8211r_priv *priv) {}
+static void dap8211r_debug_remove(struct dap8211r_priv *priv) {}
+#endif /* CONFIG_DEBUG_FS */
+
+/**
+ * dap8211r_probe() - PHY probe callback
+ * @phydev: PHY device structure
+ *
+ * Called when the PHY is discovered. Allocates and initializes
+ * private driver data and debugfs entries.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct dap8211r_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	phydev->priv = priv;
+
+	dap8211r_debug_init(priv);
+	phydev_dbg(phydev, "DAP8211R PHY probed\n");
+
+	return 0;
+}
+
+/**
+ * dap8211r_remove() - PHY remove callback
+ * @phydev: PHY device structure
+ *
+ * Called when the PHY is removed. Cleans up private driver data
+ * and debugfs entries.
+ */
+static void dap8211r_remove(struct phy_device *phydev)
+{
+	dap8211r_debug_remove(phydev->priv);
+}
+
+static struct phy_driver dap8211r_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(DAP8211R_PHY_ID),
+		.name		= "DAP8211R Gigabit Ethernet",
+		.probe          = dap8211r_probe,
+		.remove		= dap8211r_remove,
+		.config_init	= dap8211r_config_init,
+		.read_status	= genphy_read_status,
+		.set_loopback	= genphy_loopback,
+		.config_aneg	= genphy_config_aneg,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+};
+module_phy_driver(dap8211r_driver);
+
+MODULE_DESCRIPTION("DAP8211R Gigabit Ethernet PHY driver");
+MODULE_AUTHOR("Artem Shimko <a.shimko.dev@gmail.com>");
+MODULE_LICENSE("GPL");
+
+static const struct mdio_device_id __maybe_unused dap8211r_tb[] = {
+	{ DAP8211R_PHY_ID, DAP8211R_PHY_ID_MASK },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(mdio, dap8211r_tb);
-- 
2.43.0


