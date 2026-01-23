Return-Path: <netdev+bounces-252710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGlTLJM6c2l/tQAAu9opvQ
	(envelope-from <netdev+bounces-252710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7A7300F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B043028C2F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298034D383;
	Fri, 23 Jan 2026 09:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCD30DEB5
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159274; cv=none; b=b1eXrK57muNEExz0gNqT+qfKFlKH4TgbaXy/NCQHwjNuwHmj/TRyR4W0ICLGdeKt4cBRRLajwdEIH4KaqQ76091sv1mTI3KPQZFAXnMs3EdvFmuHI0/qVarwuxKwBZY+AX+9pmD0rKYSfyDOAQA9sUt1RhDxCzXcEDKr8NpvhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159274; c=relaxed/simple;
	bh=/0cL2fuHdGpIi6bdL6UK4t+rDuKh3T0YQNJtD/9d/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB+Yg8pdE7oFixNHhTrVMOOrWSxmQk3BuRLp3W/Rgj3SM5W5FdFE/vFsutiRLwixet2D75uE8KPS7u/yk5Qeebz/7Uu0kRBkRWMAMwBVeZHU/NYPGD9kGe2nAS+D9Xic+3HzBsQjvgbRGgBmW2y2PYsl0S6F0nXzxGJm7ZJ3+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8q-00027I-58; Fri, 23 Jan 2026 10:07:44 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8p-002451-0k;
	Fri, 23 Jan 2026 10:07:42 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8o-00000006ZXC-20KC;
	Fri, 23 Jan 2026 10:07:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC PATCH 4/4] net: lan78xx: Add debugfs file for error injection testing
Date: Fri, 23 Jan 2026 10:07:40 +0100
Message-ID: <20260123090741.1566469-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123090741.1566469-1-o.rempel@pengutronix.de>
References: <20260123090741.1566469-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252710-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D7A7300F
X-Rspamd-Action: no action

Add a debugfs file (inject\_error) to allow users to trigger specific
hardware errors (e.g., Burst Cap Violation, RX FIFO Overflow, USB PHY
destabilization) for testing the newly introduced health and recovery
mechanisms.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 71 +++++++++++++++++++++++++++++++++++++++
 drivers/net/usb/lan78xx.h |  4 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 316a3a8d0534..ae721025cf3d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015 Microchip Technology
  */
 #include <linux/crc32.h>
+#include <linux/debugfs.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
@@ -519,6 +520,8 @@ struct lan78xx_net {
 
 	struct irq_domain_data	domain_data;
 
+	struct dentry		*debugfs_pdev;
+
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 
@@ -5088,6 +5091,68 @@ static const struct devlink_ops lan78xx_devlink_ops = {
 	.info_get = lan78xx_devlink_info_get,
 };
 
+static ssize_t lan78xx_inject_write(struct file *file, const char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct lan78xx_net *dev = file->private_data;
+	char buf[32];
+	int val, ret;
+	u32 reg_val;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+	buf[count] = 0;
+
+	if (kstrtoint(buf, 0, &val))
+		return -EINVAL;
+
+	switch (val) {
+	case 1: /* Trigger Burst Cap Violation (Hang UTX) */
+		/* Enable Burst Cap Enforcement */
+		ret = lan78xx_read_reg(dev, USB_CFG0, &reg_val);
+		if (ret < 0)
+			return ret;
+		reg_val |= USB_CFG_BCE_;
+		lan78xx_write_reg(dev, USB_CFG0, reg_val);
+
+		/* Set illegal Burst Cap size (512 bytes < Max Frame) */
+		lan78xx_write_reg(dev, BURST_CAP, 0x01);
+		break;
+
+	case 2: /* Trigger RX FIFO Overflow (Hold UTX in Reset) */
+		ret = lan78xx_read_reg(dev, USB_CFG0, &reg_val);
+		if (ret < 0)
+			return ret;
+		reg_val |= USB_CFG0_UTX_RESET_;
+		lan78xx_write_reg(dev, USB_CFG0, reg_val);
+		break;
+
+	case 3: /* Destabilize USB PHY (Invalid HS State) */
+		ret = lan78xx_read_reg(dev, LAN78XX_USB2_TEST_REG, &reg_val);
+		if (ret < 0)
+			return ret;
+		/* Set bits 15:14 to '10' (Binary) - Defined as "Invalid combination" */
+		reg_val &= ~(0x3 << 14);
+		reg_val |= (0x2 << 14);
+		lan78xx_write_reg(dev, LAN78XX_USB2_TEST_REG, reg_val);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations lan78xx_inject_fops = {
+	.open = simple_open,
+	.write = lan78xx_inject_write,
+	.llseek = default_llseek,
+};
+
 static void lan78xx_disconnect(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev;
@@ -5102,6 +5167,8 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
+	debugfs_remove_recursive(dev->debugfs_pdev);
+
 	lan78xx_health_cleanup(dev);
 	if (dev->devlink) {
 		cancel_work_sync(&dev->tx_timeout_work);
@@ -5594,6 +5661,10 @@ static int lan78xx_probe(struct usb_interface *intf,
 		lan78xx_health_init(dev);
 	}
 
+	dev->debugfs_pdev = debugfs_create_dir(netdev_name(netdev), NULL);
+	debugfs_create_file("inject_error", 0200, dev->debugfs_pdev, dev,
+			    &lan78xx_inject_fops);
+
 	return 0;
 
 phy_uninit:
diff --git a/drivers/net/usb/lan78xx.h b/drivers/net/usb/lan78xx.h
index 968e5e5faee0..16666a998441 100644
--- a/drivers/net/usb/lan78xx.h
+++ b/drivers/net/usb/lan78xx.h
@@ -366,6 +366,7 @@
 #define USB_CFG_MAX_DEV_SPEED_SS_	(0x00008000)
 #define USB_CFG_MAX_DEV_SPEED_HS_	(0x00000000)
 #define USB_CFG_MAX_DEV_SPEED_FS_	(0x00002000)
+#define USB_CFG0_UTX_RESET_		(0x00000400)
 #define USB_CFG_PHY_BOOST_MASK_		(0x00000180)
 #define USB_CFG_PHY_BOOST_PLUS_12_	(0x00000180)
 #define USB_CFG_PHY_BOOST_PLUS_8_	(0x00000100)
@@ -876,4 +877,7 @@
 #define OTP_TPVSR_VAL			(OTP_BASE_ADDR + 4 * 0x3A)
 #define OTP_TPVHR_VAL			(OTP_BASE_ADDR + 4 * 0x3B)
 #define OTP_TPVSA_VAL			(OTP_BASE_ADDR + 4 * 0x3C)
+
+#define LAN78XX_USB2_TEST_REG		(0x12C4)
+
 #endif /* _LAN78XX_H */
-- 
2.47.3


