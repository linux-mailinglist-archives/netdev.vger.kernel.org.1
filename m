Return-Path: <netdev+bounces-223038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECDB57A1E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030E71A2388A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0C21CC47;
	Mon, 15 Sep 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DBNSXKK5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE73064A6
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938393; cv=none; b=na/O1v4GmjRgJD2wQftvZqSakciTuFddLjnuVii+Xzb4Q+0S9fwFpwAOX3b3OpNrkWOdDC4Gai9AcPuHGpKBum/nWePQK4jcDtKHiNnUPFy69XuK8D9LT2lWy0ep/+9SD5Qqv+WAGd3PNZCK5XtGfhq3qLfMhKSqlGGkF21HY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938393; c=relaxed/simple;
	bh=rjILkvEJ6GjlFk43kM6qq3J+NtX13lVC3tTz9ddz08M=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=n+zJgoMWUPeBc4qt00uR8k5D6Ze/AOLgWgnNIz1Qx8Nx+qxtYQ+0R7VVxND2UwoOmqpO3KAHkYcLIKDF5r98XMjFggaxG0HSd9SWvUJdyNqQFFvgWpWg2VZ/A/SZmiY0DeIfagVTNpAAlLA7M5KW13cSPxel3sbgFQ7rR7hsHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DBNSXKK5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mz8TKwXSB515APhSbjLPHRxM+a0eQS1rFniNocWkBWk=; b=DBNSXKK5VzKzcKcNIZ/BAK9uyw
	zPjWzCnOhSmNJyM0Jm24XW8vk1qZe9joX4khvQXqyUl2nJXI8q1dW9yjWTQwz6q16g4vtCnpDf6Tk
	hBvjm2cwBCQf1OsPaeBq9bAJdWtYYdbHtlCIagQCHtnJEoyJ4+DhVIfredAqY9VwQH1eLy+sgHlF9
	sILE6DosOK8jtdn3MOyZ0w22B7hgniW1ZqavlTpP01Qxud/ywtMOfyrrkkEp5ETZakp1tn2y0vusr
	MPHIcSnv6JZke8XnXvGA7fCDRtaspNPh+rzm58ufOycVCw1G5l9faRs3FnXXXkgyuZl3DlrIEopga
	C6QO1m3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49640 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy84x-000000008UX-2syE;
	Mon, 15 Sep 2025 13:13:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy84w-00000005Spi-46iF;
	Mon, 15 Sep 2025 13:13:07 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: clean up PTP clock during setup
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 13:13:06 +0100

If an error occurs during mv88e6xxx_setup() and the PTP clock has been
registered, the clock will not be unregistered as mv88e6xxx_ptp_free()
will not be called. mv88e6xxx_hwtstamp_free() also is not called.

As mv88e6xxx_ptp_free() can cope with being called without a successful
call to mv88e6xxx_ptp_setup(), and mv88e6xxx_hwtstamp_free() is empty,
add both these *_free() calls to the error cleanup paths in
mv88e6xxx_setup().

Moreover, mv88e6xxx_teardown() should teardown setup done in
mv88e6xxx_setup() - see dsa_switch_setup(). However, instead *_free()
are called from mv88e6xxx_remove() function that is only called when a
device is unbound, which omits cleanup should a failure occur later in
dsa_switch_setup(). Move the *_free() calls from mv88e6xxx_remove() to
mv88e6xxx_teardown().

Note that mv88e6xxx_ptp_setup() must be called holding the reg_lock,
but mv88e6xxx_ptp_free() must never be. This is especially true after
commit "ptp: rework ptp_clock_unregister() to disable events". This
patch does not change this, but adds a comment to that effect.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This is a long-standing bug, and I don't think it makes sense to rush
it in via the net tree as a failure to trigger it is very unlikely to
happen.

 drivers/net/dsa/mv88e6xxx/chip.c | 15 +++++++--------
 drivers/net/dsa/mv88e6xxx/ptp.c  |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 25d4c89d36b8..b4d48997bf46 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3965,6 +3965,8 @@ static void mv88e6xxx_teardown(struct dsa_switch *ds)
 	mv88e6xxx_teardown_devlink_params(ds);
 	dsa_devlink_resources_unregister(ds);
 	mv88e6xxx_teardown_devlink_regions_global(ds);
+	mv88e6xxx_hwtstamp_free(chip);
+	mv88e6xxx_ptp_free(chip);
 	mv88e6xxx_mdios_unregister(chip);
 }
 
@@ -4105,7 +4107,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out_mdios;
+		goto out_hwtstamp;
 
 	/* Have to be called without holding the register lock, since
 	 * they take the devlink lock, and we later take the locks in
@@ -4114,7 +4116,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	 */
 	err = mv88e6xxx_setup_devlink_resources(ds);
 	if (err)
-		goto out_mdios;
+		goto out_hwtstamp;
 
 	err = mv88e6xxx_setup_devlink_params(ds);
 	if (err)
@@ -4130,7 +4132,9 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	mv88e6xxx_teardown_devlink_params(ds);
 out_resources:
 	dsa_devlink_resources_unregister(ds);
-out_mdios:
+out_hwtstamp:
+	mv88e6xxx_hwtstamp_free(chip);
+	mv88e6xxx_ptp_free(chip);
 	mv88e6xxx_mdios_unregister(chip);
 
 	return err;
@@ -7439,11 +7443,6 @@ static void mv88e6xxx_remove(struct mdio_device *mdiodev)
 
 	chip = ds->priv;
 
-	if (chip->info->ptp_support) {
-		mv88e6xxx_hwtstamp_free(chip);
-		mv88e6xxx_ptp_free(chip);
-	}
-
 	mv88e6xxx_unregister_switch(chip);
 
 	mv88e6xxx_g1_vtu_prob_irq_free(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 89fb61ea891d..fa17ad6e378f 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -551,6 +551,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+/* This must never be called holding the register lock */
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 {
 	if (chip->ptp_clock) {
-- 
2.47.3


