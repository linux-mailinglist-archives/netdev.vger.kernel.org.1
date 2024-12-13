Return-Path: <netdev+bounces-151828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B99F1250
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DD816BD1B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCF1E3DD7;
	Fri, 13 Dec 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M630K9gT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543D1DFE3A
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107659; cv=none; b=uKjF2PjFtZv1cKSoagGvSXpb+owf061Yce3ZXQV+Gr606zVlSu2fWpU4Fk+FGaxDsGxhs6JfsaKG1xd72hS51PjWs2Rpr2OHtc4Ql357W4zXPZ/2cgQK80Ov/9aVk7cyrO1m2QiHTWel8hbNxEb4k3g7VwKTrNGgJIIMl++TqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107659; c=relaxed/simple;
	bh=QiHd/viQZKfmBw+A7X5QTVZ66k3kAXqWi+u4gQtbkUg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=mJUhUycHfZnZ4YDzFpjJPviWV81i93aEvu1532A2TgbaJeWAY/uKwC/lsjsYIDMFAUkxWYX24zGnqFFgIdZSqyn49SWYvCDv8gW9RmQpjXhPWEqgu4GJ6vk7HKSFdgNi9UvQQDRJ1bYwHVAMXYXTN1rd+CTbOe4dJFGsxUQR7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M630K9gT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fC1xH0XVOxl8w7Y/HGaKyXZdC84TNZvWnaU6ICX75Q8=; b=M630K9gT4nmfVrgS+zNhSwEqY0
	HXnHMKXMieMNa1SjFLP9cb1zv7xlShgOfHq807lnHwcDWoySC0SnjAQNciT78bhbcBt1u/EBm0222
	/JgJ7ZOd6qFVZdR2k8+jdM4C4tqslOv39R8bycyPVRghe/Ei4BHoztawDXK4bpwjLYFHm/WXUtdaQ
	R7N9gRPGbnkIXXCac4jF3Vwz5v6U0F4nmrKnQMYoBwtieaE5LAcNwpmV/GHQb+nhSOe0RhxzDP0Y+
	WkMRwUbT6Dux956rd1gISls8xkD+wI/2UbpvbOl0uuUPgtRvZL4oAVzR4NAuWzBcfkC9+NI/9O5cO
	48BxZllw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52536 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tM8cC-0006za-1h;
	Fri, 13 Dec 2024 16:34:08 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tM8cA-006t1i-KF; Fri, 13 Dec 2024 16:34:06 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to update
 our timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Dec 2024 16:34:06 +0000

The hardware timestamps for packets contain a truncated seconds field,
only containing two bits of seconds. In order to provide the full
number of seconds, we need to keep track of the full hardware clock by
reading it every two seconds.

However, if we fail to read the clock, we silently ignore the error.
Print a warning indicating that the PP2 TAI clock timestamps have
become unreliable.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
--
v2: correct dev_warn_once() indentation
v3: add '\n'
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
index 95862aff49f1..d4e8708a9c76 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
@@ -54,6 +54,7 @@
 #define TCSR_CAPTURE_0_VALID		BIT(0)
 
 struct mvpp2_tai {
+	struct device *dev;
 	struct ptp_clock_info caps;
 	struct ptp_clock *ptp_clock;
 	void __iomem *base;
@@ -303,7 +304,8 @@ static long mvpp22_tai_aux_work(struct ptp_clock_info *ptp)
 {
 	struct mvpp2_tai *tai = ptp_to_tai(ptp);
 
-	mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL);
+	if (mvpp22_tai_gettimex64(ptp, &tai->stamp, NULL) < 0)
+		dev_warn_once(tai->dev, "PTP timestamps are unreliable\n");
 
 	return msecs_to_jiffies(2000);
 }
@@ -401,6 +403,7 @@ int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv)
 
 	spin_lock_init(&tai->lock);
 
+	tai->dev = dev;
 	tai->base = priv->iface_base;
 
 	/* The step size consists of three registers - a 16-bit nanosecond step
-- 
2.30.2


