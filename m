Return-Path: <netdev+bounces-223711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39CB5A34D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E395A179BED
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510CA2F9D8C;
	Tue, 16 Sep 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CL12jqlf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C52F5A34
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054894; cv=none; b=YzpDhQpk2sVt2dkHibX58vioP/eTTBGywFnkcc9qenNKQ5jYOytVABNAXlusqyvsOQcturokPFp+BM9BRXyxcNDJSHTiEUfNYNEE6XaycZvNMinVOMGn3hzVDhZ+o/5E1nKC2Z6UV9f+LM247vcrmeLOEme+U0dteXHR6+g0vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054894; c=relaxed/simple;
	bh=84qLKvdwNAtTxc2QlRg9E/cb6aCAsiIpTDOCDt9wsDQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QmLucSMq6B5eJPX/m4ZxtA397VxkHbIL3Kmrhpoid0w+SlIPGVu3fOnIjAfwyXH7WydfdaQzc0Pqkqf8wsub/mMyWdPG7LGtJurm/aNVZyB6VG6VatJ5x7ID4d5rZuf+i5HPkqBQyjMR7KnjJ/jfmNbyFkLOYb9Jqc96+WfAdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CL12jqlf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zpsfRKxW+LkK1MruYPMkWYa9YgmescovqL24sT7pWVA=; b=CL12jqlfH01zHQG5hxb1M5+K5a
	rivXs/C2x9IHKA+PRSwFiYXJKtw3Rf3mk1OTdAdXBukLe27c6JkGAC0STO2H23dDfxzFt+91N1StI
	MV6DS0U7NLCzhnZ7wpuGvndxfjvTtXup9zbAL6s/6/txDH6UCv/AKZTirWZXh14oLPlkfwuf5Nhr6
	8yu05z8/cm0xRRNTQIu/1zDHui/y51q1yPYTyV0CAv/odXaXBMsnFz+6doCab06juItn3EC2CZ7zW
	7RYlktDbYD+Isej4Bu+XojIUXYtnfymQj7Z5zEEqjpM2TdWMswuLLh+9HonFpn5ZEpNEyv2C6XWPk
	sE1HIh5g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37090 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uycO1-0000000067t-0flw;
	Tue, 16 Sep 2025 21:34:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uycO0-00000005xap-1rbr;
	Tue, 16 Sep 2025 21:34:48 +0100
In-Reply-To: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 1/5] net: dsa: mv88e6xxx: rename TAI definitions
 according to core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uycO0-00000005xap-1rbr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 21:34:48 +0100

The TAI_EVENT_STATUS and TAI_CFG definitions are only used for the
88E6352-family of TAI implementations. Rename them as such, and
remove the TAI_EVENT_TIME_* definitions that are unused (although
we read them as a block.)

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 24 ++++++++---------
 drivers/net/dsa/mv88e6xxx/ptp.h | 47 +++++++++++++++------------------
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index fa17ad6e378f..f7603573d3a9 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -144,7 +144,7 @@ static u64 mv88e6352_ptp_clock_read(struct cyclecounter *cc)
 	u16 phc_time[2];
 	int err;
 
-	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_TIME_LO, phc_time,
+	err = mv88e6xxx_tai_read(chip, MV88E6352_TAI_TIME_LO, phc_time,
 				 ARRAY_SIZE(phc_time));
 	if (err)
 		return 0;
@@ -158,7 +158,7 @@ static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 	u16 phc_time[2];
 	int err;
 
-	err = mv88e6xxx_tai_read(chip, MV88E6XXX_PTP_GC_TIME_LO, phc_time,
+	err = mv88e6xxx_tai_read(chip, MV88E6165_PTP_GC_TIME_LO, phc_time,
 				 ARRAY_SIZE(phc_time));
 	if (err)
 		return 0;
@@ -176,17 +176,17 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int rising)
 	u16 evcap_config;
 	int err;
 
-	evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
-		       MV88E6XXX_TAI_CFG_CAP_CTR_START;
+	evcap_config = MV88E6352_TAI_CFG_CAP_OVERWRITE |
+		       MV88E6352_TAI_CFG_CAP_CTR_START;
 	if (!rising)
-		evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
+		evcap_config |= MV88E6352_TAI_CFG_EVREQ_FALLING;
 
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
+	err = mv88e6xxx_tai_write(chip, MV88E6352_TAI_CFG, evcap_config);
 	if (err)
 		return err;
 
 	/* Write the capture config; this also clears the capture counter */
-	return mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, 0);
+	return mv88e6xxx_tai_write(chip, MV88E6352_TAI_EVENT_STATUS, 0);
 }
 
 static void mv88e6352_tai_event_work(struct work_struct *ugly)
@@ -199,7 +199,7 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 	int err;
 
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_EVENT_STATUS,
+	err = mv88e6xxx_tai_read(chip, MV88E6352_TAI_EVENT_STATUS,
 				 status, ARRAY_SIZE(status));
 	mv88e6xxx_reg_unlock(chip);
 
@@ -207,19 +207,19 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 		dev_err(chip->dev, "failed to read TAI status register\n");
 		return;
 	}
-	if (status[0] & MV88E6XXX_TAI_EVENT_STATUS_ERROR) {
+	if (status[0] & MV88E6352_TAI_EVENT_STATUS_ERROR) {
 		dev_warn(chip->dev, "missed event capture\n");
 		return;
 	}
-	if (!(status[0] & MV88E6XXX_TAI_EVENT_STATUS_VALID))
+	if (!(status[0] & MV88E6352_TAI_EVENT_STATUS_VALID))
 		goto out;
 
 	raw_ts = ((u32)status[2] << 16) | status[1];
 
 	/* Clear the valid bit so the next timestamp can come in */
-	status[0] &= ~MV88E6XXX_TAI_EVENT_STATUS_VALID;
+	status[0] &= ~MV88E6352_TAI_EVENT_STATUS_VALID;
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, status[0]);
+	err = mv88e6xxx_tai_write(chip, MV88E6352_TAI_EVENT_STATUS, status[0]);
 	mv88e6xxx_reg_unlock(chip);
 	if (err) {
 		dev_err(chip->dev, "failed to write TAI status register\n");
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index b3fd177d67e3..24c942d484be 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -16,19 +16,19 @@
 #include "chip.h"
 
 /* Offset 0x00: TAI Global Config */
-#define MV88E6XXX_TAI_CFG			0x00
-#define MV88E6XXX_TAI_CFG_CAP_OVERWRITE		0x8000
-#define MV88E6XXX_TAI_CFG_CAP_CTR_START		0x4000
-#define MV88E6XXX_TAI_CFG_EVREQ_FALLING		0x2000
-#define MV88E6XXX_TAI_CFG_TRIG_ACTIVE_LO	0x1000
-#define MV88E6XXX_TAI_CFG_IRL_ENABLE		0x0400
-#define MV88E6XXX_TAI_CFG_TRIG_IRQ_EN		0x0200
-#define MV88E6XXX_TAI_CFG_EVREQ_IRQ_EN		0x0100
-#define MV88E6XXX_TAI_CFG_TRIG_LOCK		0x0080
-#define MV88E6XXX_TAI_CFG_BLOCK_UPDATE		0x0008
-#define MV88E6XXX_TAI_CFG_MULTI_PTP		0x0004
-#define MV88E6XXX_TAI_CFG_TRIG_MODE_ONESHOT	0x0002
-#define MV88E6XXX_TAI_CFG_TRIG_ENABLE		0x0001
+#define MV88E6352_TAI_CFG			0x00
+#define MV88E6352_TAI_CFG_CAP_OVERWRITE		0x8000
+#define MV88E6352_TAI_CFG_CAP_CTR_START		0x4000
+#define MV88E6352_TAI_CFG_EVREQ_FALLING		0x2000
+#define MV88E6352_TAI_CFG_TRIG_ACTIVE_LO	0x1000
+#define MV88E6352_TAI_CFG_IRL_ENABLE		0x0400
+#define MV88E6352_TAI_CFG_TRIG_IRQ_EN		0x0200
+#define MV88E6352_TAI_CFG_EVREQ_IRQ_EN		0x0100
+#define MV88E6352_TAI_CFG_TRIG_LOCK		0x0080
+#define MV88E6352_TAI_CFG_BLOCK_UPDATE		0x0008
+#define MV88E6352_TAI_CFG_MULTI_PTP		0x0004
+#define MV88E6352_TAI_CFG_TRIG_MODE_ONESHOT	0x0002
+#define MV88E6352_TAI_CFG_TRIG_ENABLE		0x0001
 
 /* Offset 0x01: Timestamp Clock Period (ps) */
 #define MV88E6XXX_TAI_CLOCK_PERIOD		0x01
@@ -53,18 +53,15 @@
 #define MV88E6XXX_TAI_IRL_COMP_PS		0x08
 
 /* Offset 0x09: Event Status */
-#define MV88E6XXX_TAI_EVENT_STATUS		0x09
-#define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
-#define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
-#define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
-
-/* Offset 0x0A/0x0B: Event Time */
-#define MV88E6XXX_TAI_EVENT_TIME_LO		0x0a
-#define MV88E6XXX_TAI_EVENT_TYPE_HI		0x0b
+#define MV88E6352_TAI_EVENT_STATUS		0x09
+#define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
+#define MV88E6352_TAI_EVENT_STATUS_VALID	0x0100
+#define MV88E6352_TAI_EVENT_STATUS_CTR_MASK	0x00ff
+/* Offset 0x0A/0x0B: Event Time Lo/Hi. Always read with Event Status. */
 
 /* Offset 0x0E/0x0F: PTP Global Time */
-#define MV88E6XXX_TAI_TIME_LO			0x0e
-#define MV88E6XXX_TAI_TIME_HI			0x0f
+#define MV88E6352_TAI_TIME_LO			0x0e
+#define MV88E6352_TAI_TIME_HI			0x0f
 
 /* Offset 0x10/0x11: Trig Generation Time */
 #define MV88E6XXX_TAI_TRIG_TIME_LO		0x10
@@ -101,8 +98,8 @@
 #define MV88E6XXX_PTP_GC_INT_STATUS		0x08
 
 /* Offset 0x9/0xa: Global Time */
-#define MV88E6XXX_PTP_GC_TIME_LO		0x09
-#define MV88E6XXX_PTP_GC_TIME_HI		0x0A
+#define MV88E6165_PTP_GC_TIME_LO		0x09
+#define MV88E6165_PTP_GC_TIME_HI		0x0A
 
 /* 6165 Per Port Registers */
 /* Offset 0: Arrival Time 0 Status */
-- 
2.47.3


