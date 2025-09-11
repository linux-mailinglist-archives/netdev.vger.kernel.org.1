Return-Path: <netdev+bounces-222058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95648B52EE8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F1517DB45
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D5310631;
	Thu, 11 Sep 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oKBYe1b+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106B2D7DD4
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587610; cv=none; b=CRtZEj93PWFrspl6FQajDYZ9lOpRGyXZKkuhu1VDN8tVXtYKf9kOKH5EBSZow3cZuT8wfgR4ZWWKGFSCqggGnjqHjlyom5yjXE6eFIaP0kz4ZgMLLJ9mYSD01EBN7uYn+BO/6ePCRMIe9OhZBvX4pO5n8QCEJifib0etk9x4jmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587610; c=relaxed/simple;
	bh=26ZtJ/z+uBO8txHGV0WOWKSejznZBXKK9nEr1uMKYaI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZYAv75W2LVeGNeiviK9mchiLn4Qv3xHgjh+mc3QgxhYCxATHn1aI1iTAskyByCE5icrSgORjqyfD2cfbo8fGpj32ok2Dhv/L1Oeuqx0EARmQEVkoDR5+zrKHtRjxrsps63fMs41Rsbp6UtTpvnP7V1+0ic3NubQV75CUID+x0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oKBYe1b+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CYWoOljQc/dG0YxShGygjGhaG52aixbyG1vUxDHhkTk=; b=oKBYe1b+Cl//BUYBImC+Fhz3Rn
	xNrAQB9/ZVGv9wTb4neaymTf7gpNOgZHghLQiKLuqoToR++/ZRPaGVpdDwwynhcHUWd4ForRHSwX4
	C257orfNmdHNouX1WV0OYs9DGXQMGmwiWZMo2OosbYsuSrhYdk6Ga21BRjg0c19hqYtAyWqeaj8Nu
	1KIHEls+him9u4b3c+sIZrYIRVt7fyLD3vmLERMg1aMaZ5lBIJ1gOFCaleDBfpFapPoSpZcFITCyv
	TINHrCf1NxymxJslPjJlLSB5xG+zDJ6sqXIJCGpN2q+z9eoYztMy9QMZeSqwGJxjEyq1+g3sB/goQ
	wGq5Uksw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44440 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwepA-000000002q0-0tBV;
	Thu, 11 Sep 2025 11:46:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwep9-00000004ikJ-2FeF;
	Thu, 11 Sep 2025 11:46:43 +0100
In-Reply-To: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
References: <aMKoYyN18FHFCa1q@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 4/4] net: dsa: mv88e6xxx: remove unused support
 for PPS event capture
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uwep9-00000004ikJ-2FeF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 11:46:43 +0100

mv88e6352_config_eventcap() is documented as handling both EXTTS and
PPS capture modes, but nothing ever calls it for PPS capture. Remove
the unused PPS capture mode support, and the now unused
MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG definition.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
--
v2: remove MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG definition
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 21 +++------------------
 drivers/net/dsa/mv88e6xxx/ptp.h |  1 -
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 350f1d5c05f4..89fb61ea891d 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -167,16 +167,13 @@ static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 }
 
 /* mv88e6352_config_eventcap - configure TAI event capture
- * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
  * @rising: zero for falling-edge trigger, else rising-edge trigger
  *
  * This will also reset the capture sequence counter.
  */
-static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
-				     int rising)
+static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int rising)
 {
 	u16 evcap_config;
-	u16 cap_config;
 	int err;
 
 	evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
@@ -188,20 +185,8 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 	if (err)
 		return err;
 
-	if (event == PTP_CLOCK_PPS) {
-		cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;
-	} else if (event == PTP_CLOCK_EXTTS) {
-		/* if STATUS_CAP_TRIG is unset we capture PTP_EVREQ events */
-		cap_config = 0;
-	} else {
-		return -EINVAL;
-	}
-
 	/* Write the capture config; this also clears the capture counter */
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS,
-				  cap_config);
-
-	return err;
+	return mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, 0);
 }
 
 static void mv88e6352_tai_event_work(struct work_struct *ugly)
@@ -354,7 +339,7 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 		schedule_delayed_work(&chip->tai_event_work,
 				      TAI_EVENT_WORK_INTERVAL);
 
-		err = mv88e6352_config_eventcap(chip, PTP_CLOCK_EXTTS, rising);
+		err = mv88e6352_config_eventcap(chip, rising);
 	} else {
 		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 24b824f42046..b3fd177d67e3 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -54,7 +54,6 @@
 
 /* Offset 0x09: Event Status */
 #define MV88E6XXX_TAI_EVENT_STATUS		0x09
-#define MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG	0x4000
 #define MV88E6XXX_TAI_EVENT_STATUS_ERROR	0x0200
 #define MV88E6XXX_TAI_EVENT_STATUS_VALID	0x0100
 #define MV88E6XXX_TAI_EVENT_STATUS_CTR_MASK	0x00ff
-- 
2.47.3


