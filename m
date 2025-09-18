Return-Path: <netdev+bounces-224568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03731B86491
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887E5566633
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B031BCBA;
	Thu, 18 Sep 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eXjotSwz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4D31BCA5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217196; cv=none; b=SLQGo75iSrSgDb1Pqwxbg86ercOtY1hEM0+/XyxGeRhgMcwkTV4fmxBfclnST+ZVIp+7VZXMZSatJ/LJw3/Puov/QkufI+HWlS4bv1jCLkvRmAK7Pg0VsWderi+CeLNbfettrd81E77ahNqsa3Tnu6kw10g+3FBi5N7A7hRfjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217196; c=relaxed/simple;
	bh=vyF2dFwQrCdzBVWlisMh0N95TqWG+xsrMvOvCluFjaM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DyBl9FBoZuJ30gtEwoBK7EiyCHQXVeWdEIpAmW5o7iE+CO8pwov9KaqrC/IjqpGc1gOuFcjReAduxYFUl3CnzyL4J6dBy8QYUzIuUQhN1Ix7ut1+TjPe9lFYjIXefHom1hSlZrUmv1SXMAYyc2pSjMvVJPzSg0Y/kMiT0KuKNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eXjotSwz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GVdu2ek8T2oPIf0hkUZXibt2IWRiDdpAEXt7E0pt9E0=; b=eXjotSwzwJOJukVFgSWNp/5RoN
	NUBfiqlYf4p98g1m1Cmb+oGw7TpXtk8qGIuEs+2Kiy5ajO3CATzffvCblej+l7gJQNj8Stvwdo6Cr
	HqLIPPdnJeyKBlbdvE9Fb3yQQvfnomGwRm2nTQrhBsHLBimZGc63He5kjAy5rDVonILkcYEflcKkt
	aM6AzRd4yfrOxIMDD81Q5NbFJkEuN3+6M+8UvyJn5DwsRBE6hPYUgdBkC7CISEc3e2CR85JsirwYM
	/ZiVyVXOsxqQwr8JIeiMZdDXX+53RTI9uO4wDAIeXVcWma7xn/QNQ3vu5qm9pO2Kg///ddBy2ntre
	7aMK4dag==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50392 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbl-000000001cS-0kKs;
	Thu, 18 Sep 2025 18:39:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbk-00000006n06-0a3X;
	Thu, 18 Sep 2025 18:39:48 +0100
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
Subject: [PATCH RFC net-next 11/20] net: dsa: mv88e6xxx: split out EXTTS pin
 setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbk-00000006n06-0a3X@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:48 +0100

Split out the EXTTS pin setup from the extts configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index de44622d8513..19ccc8cda1f0 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -111,6 +111,20 @@ static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
 	return chip->info->ops->gpio_ops->set_pctl(chip, pin, func);
 }
 
+static int mv88e6352_ptp_pin_setup(struct mv88e6xxx_chip *chip, int pin,
+				   enum ptp_pin_function func, int enable)
+{
+	if (func != PTP_PF_EXTTS)
+		return -EOPNOTSUPP;
+
+	if (enable)
+		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
+	else
+		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
+
+	return mv88e6352_set_gpio_func(chip, pin, func, true);
+}
+
 static const struct mv88e6xxx_cc_coeffs *
 mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 {
@@ -352,27 +366,18 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 		return -EBUSY;
 
 	mv88e6xxx_reg_lock(chip);
+	err = mv88e6352_ptp_pin_setup(chip, pin, PTP_PF_EXTTS, on);
 
-	if (on) {
-		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
-
-		err = mv88e6352_set_gpio_func(chip, pin, func, true);
-		if (err)
-			goto out;
-
+	if (!on) {
+		/* Always cancel the work, even if an error occurs */
+		cancel_delayed_work_sync(&chip->tai_event_work);
+	} else if (!err) {
 		schedule_delayed_work(&chip->tai_event_work,
 				      TAI_EVENT_WORK_INTERVAL);
 
 		err = mv88e6352_config_eventcap(chip, rising);
-	} else {
-		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
-
-		err = mv88e6352_set_gpio_func(chip, pin, func, true);
-
-		cancel_delayed_work_sync(&chip->tai_event_work);
 	}
 
-out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
-- 
2.47.3


