Return-Path: <netdev+bounces-224563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC08B8645E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430167BEF65
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84431A54F;
	Thu, 18 Sep 2025 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Zb4NtpoS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65625C822
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217170; cv=none; b=oYtbK7lYS074bBfaODn0JjzAbaMc+nEQA3Ag0+l30vp47kmXCqm1loLkABEwtLE0q29JNSKUfmiXHYVhgP3RzgEtswGSc8bSM9yMSNhAAUHHGqB8Oug8+loJfGJV3HUMu5eVbxzjlCT8B6Ca3uAI/JNmW7I2yfEa4bNueMN7/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217170; c=relaxed/simple;
	bh=s1XaHO6UzMbaocHooifCLJF72iDv6Wq7yCnEB3Nk4U8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jSC67iUZ+GMVXBb0HkRgUD3luM3DrZLrFo7KLVyIBNi3Wopw5HaFmpDGdSnufcRy3nihtGhlWIpgkqbnJYFdwGL9SydOcYjzlFUTz6mT7tBfEminmwtw93mFaOz01+XTnR2VAVmNTMyP4bo0rMuXBZc+fHC0uIezGo1nF9n3dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Zb4NtpoS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p4YhQkfsYbGaz6GZf+zk41sUXZOWK6I1LKgClPvtKYk=; b=Zb4NtpoSPjgQanDS3yK1ymWnVN
	UgPzqrk11OVsCHACVakiFyUdSsI63/iAXeP77g6dYWJ352UrKBpVe0BvcsB8jK2AjquYlsDRdGVNx
	b3LSNw5HGwBh/pn3xD8zNuJ/QWeqVmsaif5TbEXF4cb2IPQmKfckCwbaLTIbzZ+Tw8LjZwv1NxkGF
	BXgPiPb4lMHVU224qvseGJRdRUXPRrrtWfYqAG+2s7BAZdyqr68kJkLIGl0s/gdvCzFyGmlgno1hr
	3goY8HfLw6dQxIroDsreoqYFf1OcZrhzM0RDfthupJRQoJz4U6Avq7TwkNJN2sDlDjMicCTQnC/ED
	n2BH1j2A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33838 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbL-000000001bL-1FJx;
	Thu, 18 Sep 2025 18:39:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbK-00000006mzc-27NF;
	Thu, 18 Sep 2025 18:39:22 +0100
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
Subject: [PATCH RFC net-next 06/20] net: dsa: mv88e6xxx: convert PTP
 ptp_verify() method to take chip
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbK-00000006mzc-27NF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:22 +0100

Wrap the ptp_ops->ptp_verify() method and convert it to take
struct mv88e6xxx_chip. This eases the transition to generic Marvell
PTP.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index fd91d2252735..ca62994f650a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -733,7 +733,7 @@ struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on);
-	int (*ptp_verify)(struct ptp_clock_info *ptp, unsigned int pin,
+	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
 	void (*event_work)(struct work_struct *ugly);
 	int (*port_enable)(struct mv88e6xxx_chip *chip, int port);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index d907ba04eddd..87d7fe407862 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -306,6 +306,14 @@ static int mv88e6xxx_ptp_settime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
+				enum ptp_pin_function func, unsigned int chan)
+{
+	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+
+	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
+}
+
 static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 				      struct ptp_clock_request *rq, int on)
 {
@@ -365,7 +373,7 @@ static int mv88e6352_ptp_enable(struct ptp_clock_info *ptp,
 	}
 }
 
-static int mv88e6352_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
+static int mv88e6352_ptp_verify(struct mv88e6xxx_chip *chip, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
 	switch (func) {
@@ -536,7 +544,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	chip->ptp_clock_info.gettime64	= mv88e6xxx_ptp_gettime;
 	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
 	chip->ptp_clock_info.enable	= ptp_ops->ptp_enable;
-	chip->ptp_clock_info.verify	= ptp_ops->ptp_verify;
+	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
 	chip->ptp_clock_info.do_aux_work = mv88e6xxx_hwtstamp_work;
 
 	chip->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
-- 
2.47.3


