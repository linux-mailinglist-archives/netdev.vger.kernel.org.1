Return-Path: <netdev+bounces-223715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F461B5A353
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFBB16D2BC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F79279DB4;
	Tue, 16 Sep 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XVsckE6c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494427FB37
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054917; cv=none; b=n7g84ylPxZ1rGorRRHKyFs7cKg5VeQmp4N+oQD0zwxdED8mi/6badSJMtUyNfZ8K5iJ3Cu2Yp/i9WIjoveGaf4jR0HrQ8q0osOCWpgMg39nL1lVsAG4g3hAdrNZTlxEY1baGbWroxKLCG2tsFOuavqgj/fVYqI7BOGLJL4XnGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054917; c=relaxed/simple;
	bh=Qq43jd6cKgexMNe6qqLI1Nd3hRYO58R9kgAFidVnRB8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GwrbxNpW+CACxkMO4a1psbC3VI1P9qt3mBNmFn4gsp9Mlqzl9qQCY8ubZ37a2jZE1S4tm8YC8E6EuyHH6bkxJFeFDEGRXSs3V4ELXp55OzCS+nQGxWEthoE5sgTasc+QMtd/figXFY6zE8fq7oXmb9jcDGdsKgco+MMqWarB4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XVsckE6c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DP1KDkcCQWHsBx4lXmiT5I8ma3EZUUmQWlQZMtNFcus=; b=XVsckE6c97kB51cGTfoJelVM2+
	qehdIpsFWUD4bODJfn+BoqJwTc4dlvSmVebJtcYskPHjuJT1bsJwbW6PedtmTOfAlwFjC+MZ9G9wo
	BbFxJAghf6GrRFGhgtqYx0UwW6m9ajWPPYSGgW+UXktEykwje0b2VJ8dvr2NPJqIvL8UpWAC9M8Ez
	fzGF+sBGt7iUf+oI1zGcP6o6XzUwpQxGNRgp+PBFrN6/cmg7s1JeayCE7zWDubj6amO5XX551FBLY
	FjJYmx6dX5BExB4TzweMGovYW8mL3nA85t96UodA45O5xmJB4SqpmU5YzgJgToI72rILA09mpYCLj
	rTmtzTYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40718 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uycOL-0000000068n-3Fx5;
	Tue, 16 Sep 2025 21:35:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uycOK-00000005xbI-3u2c;
	Tue, 16 Sep 2025 21:35:08 +0100
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
Subject: [PATCH net-next v2 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uycOK-00000005xbI-3u2c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 21:35:08 +0100

Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its prototype
should be in hwtstamp.h, so move it there. Remove it's redundant stub
definition, as both hwtstamp.c (the function provider) and ptp.c (the
consumer) are both dependent on the same config symbol.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.h | 1 +
 drivers/net/dsa/mv88e6xxx/ptp.h      | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index 22e4acc957f0..c359821d5a6e 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -124,6 +124,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info);
 
+long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 529ac5d0907b..95bdddb0bf39 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -66,7 +66,6 @@
 
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 
@@ -79,11 +78,6 @@ extern const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops;
 
 #else /* !CONFIG_NET_DSA_MV88E6XXX_PTP */
 
-static inline long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
-{
-	return -1;
-}
-
 static inline int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	return 0;
-- 
2.47.3


