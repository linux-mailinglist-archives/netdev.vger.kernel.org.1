Return-Path: <netdev+bounces-224578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E5B864BB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696E27C13BB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C42D31E8A3;
	Thu, 18 Sep 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dAjdgNGZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFB31E8A8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217242; cv=none; b=lVAxK77qnQpOTbKwMhvnV39ZC38uuY4CV7jEcTIg9x2fbCJg2r6fMwZsxOWqZ4DwiU+7/A4xyVPAcy3H2jasP8XQvwRkEvlJNhE9BuZ31p4l3o1cMXj+kEZkum0rU9rfWmneU6bq9ZUu9QiIe6PXlbVAPfTQSJfZyjbbtmvxsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217242; c=relaxed/simple;
	bh=eT0pBDavJ4eaFAEQlDOzanTgLMKUdsGQI1UmlDmGmKs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aqJKRymRrDEe2RWCqm87IvHvNLmd075bGkA+bJOSNegGjcZ9KHDTstIUlYiKIzzqhppIoJIwUqvXCCUeSNHZ1Wm+Mu7UaYKOJ3lGDEqR9fpcuzbiwBBBMg+U7AxESOy1jZqhXZehXHXz1YusoIZQzra1L+R7UXWwsi+xTJDA4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dAjdgNGZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VYzVV20UifkHOEZaUvHMq7E7TbSSdVJpE48/cKBSsW0=; b=dAjdgNGZqqWxAtulMkcCpST8hO
	FF+8qZV7tjxNyXPEdj6oyD6UQiOdbp8uAKH1dcMEowlstuVMs/JXKwqo8iuS7W+BBAdR9kXjz2uQ2
	fffur0pvBL+fDx2QFGcAFTd3SxJwHFPTVP/4ieHY2Ai1Cj+EVybaOptBpjlBDjltPZcK8BHbEtwRo
	VT12TPtm7mrqY/npXMdQrSnsANHhr06ieeqzC00MXsm5sWGnP1KD+buUwlBu4GGHAu2evVfa/At/p
	l4LiyZJ58iSRc5BFt3rwyGQZafzr08cSNzINSIhJtMl53X+1EiqCKO8BUirCg0qqon2i2s6DH5Jzf
	sgl6z3wg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52024 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIcV-000000001eT-076b;
	Thu, 18 Sep 2025 18:40:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIcU-00000006n19-10Hl;
	Thu, 18 Sep 2025 18:40:34 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 20/20] net: dsa: mv88e6xxx: add ptp irq support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIcU-00000006n19-10Hl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:34 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h     |  2 +
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 60 +++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index db95265efa02..361c21aaf64b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -399,6 +399,8 @@ struct mv88e6xxx_chip {
 	struct marvell_ts ptp_ts[DSA_MAX_PORTS];
 	struct marvell_ts_caps ptp_caps;
 	u16 ptp_ts_enable_count;
+	int avb_irq;
+	char avb_irq_name[64];
 
 	/* Array of port structures. */
 	struct mv88e6xxx_port ports[DSA_MAX_PORTS];
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 4f6b2706a8be..d8c675886ea5 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -11,9 +11,12 @@
  */
 
 #include "chip.h"
+#include "global1.h"
 #include "global2.h"
 #include "hwtstamp.h"
 #include "ptp.h"
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/ptp_classify.h>
 
 #define SKB_PTP_TYPE(__skb) (*(unsigned int *)((__skb)->cb))
@@ -163,6 +166,34 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 		kfree_skb(clone);
 }
 
+static irqreturn_t mv88e6xxx_ptp_irq_thread_fn(int irq, void *dev_id)
+{
+	struct mv88e6xxx_chip *chip = dev_id;
+	irqreturn_t r, ret = IRQ_NONE;
+	unsigned int n, max;
+	unsigned long mask;
+	u16 status;
+	int err;
+
+	mv88e6xxx_reg_lock(chip);
+	err = mv88e6xxx_ptp_read(chip, MV88E6XXX_PTP_IRQ_STATUS, &status);
+	mv88e6xxx_reg_unlock(chip);
+	if (err || !status)
+		return IRQ_NONE;
+
+	dev_printk(KERN_DEBUG, chip->dev, "ptp irq, status=%04x\n", status);
+
+	mask = status;
+	max = chip->ds->num_ports;
+	for_each_set_bit(n, &mask, max) {
+		r = marvell_ts_irq(&chip->ptp_ts[n]);
+		if (r != IRQ_NONE)
+			ret = r;
+	}
+
+	return ret;
+}
+
 int mv88e6165_global_disable(struct mv88e6xxx_chip *chip)
 {
 	u16 val;
@@ -409,7 +440,21 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 int mv88e6xxx_hwtstamp_setup_unlocked(struct mv88e6xxx_chip *chip)
 {
 	unsigned int n_ports = mv88e6xxx_num_ports(chip);
-	int i, err;
+	int irq, i, err;
+
+	irq = irq_find_mapping(chip->g1_irq.domain, MV88E6XXX_G1_STS_IRQ_AVB);
+	if (irq > 0) {
+		chip->avb_irq = irq;
+		snprintf(chip->avb_irq_name, sizeof(chip->avb_irq_name),
+			 "mv88e6xxx-%s-g1-avb", dev_name(chip->dev));
+
+		if (request_threaded_irq(irq, NULL, mv88e6xxx_ptp_irq_thread_fn,
+					 IRQF_ONESHOT, chip->avb_irq_name,
+					 chip)) {
+			irq_dispose_mapping(irq);
+			chip->avb_irq = 0;
+		}
+	}
 
 	for (i = err = 0; i < n_ports; ++i) {
 		err = marvell_ts_probe(&chip->ptp_ts[i], chip->dev, chip->tai,
@@ -418,10 +463,16 @@ int mv88e6xxx_hwtstamp_setup_unlocked(struct mv88e6xxx_chip *chip)
 			break;
 	}
 
-	if (err)
+	if (err) {
 		while (i--)
 			marvell_ts_remove(&chip->ptp_ts[i]);
 
+		if (chip->avb_irq) {
+			irq_dispose_mapping(chip->avb_irq);
+			chip->avb_irq = 0;
+		}
+	}
+
 	return err;
 }
 
@@ -432,4 +483,9 @@ void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip)
 
 	for (i = 0; i < n_ports; i++)
 		marvell_ts_remove(&chip->ptp_ts[i]);
+
+	if (chip->avb_irq) {
+		free_irq(chip->avb_irq, chip);
+		irq_dispose_mapping(chip->avb_irq);
+	}
 }
-- 
2.47.3


