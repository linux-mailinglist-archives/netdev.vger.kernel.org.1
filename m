Return-Path: <netdev+bounces-151072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521719ECAB8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F61285E4B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EAE1A8413;
	Wed, 11 Dec 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DmHq1LYo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E715239BC4
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914576; cv=none; b=FVDyAarLFxkyBVDIEitM2Chwf5y0XrUMFZ65WTjUgpYO7VFFV2W7MjbJmLAOjbYW6HQ7jZLTwytWdRQ8ZcK9wnbP7Z4TRhoKkXNZEM16Tb6nc98H1lboSimwtUxNGBQIZ2XG9hDDIMJpnZWnmsI5AK8iqjkqjWh4+7ox9DBbGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914576; c=relaxed/simple;
	bh=pqp1UbUpiuMLiEio3vxxFwravCAtuxQ1gLh6s2/6oBE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=bOkUL2QDofSmC0+SphqA9CrKE7KSoT5Hc0R3iAY0uQeWmIzLMHLE0mOaKfkBKB9xFPxNPju1KTQnOWmk5+uaxb1RnIGw1vk5JONlSB0wbQQy1/2Rj08UeVPUS5z6Fswo2klzElbADavq2JEhNDYEHqSjDKHk/G7HtyT1vjsjkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DmHq1LYo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UXC+0wprXb2/iY9uBJkKRgB3dt2dkr54kskVQChfMKg=; b=DmHq1LYosWGwWNSv1oC0v4Sf3p
	5v3CbbtYKovyGzqYSUB2ScXSmAVDmSXMhur2pQA1+36DXmv3/ylwjO1KzwnFSW1IMJBniR+V83Ajx
	ls9kcryuKPhB2z8RZQQ2Qlu+4gZpagSEvW9LliAZ4hXX5YyNuA3E7ZjUb3Nrqg84BWnH5eyF45oiO
	e2lGFraZxmKPOqai1B2FYHz8RzxsYz5kscwytIdPW0shkuqQG8iImX5IM8j4tKSWBG1EWAT9hmVjc
	VQuBphScjhlD5oJonlFwybzmO54M/qNDHnRkFDdSBz5uLKkzKfR3VxJWoPcYcfesesf+ND0ePx7XB
	z8wVq5Jg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36538 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tLKNn-0003lt-2u;
	Wed, 11 Dec 2024 10:55:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tLKNm-006eTd-FD; Wed, 11 Dec 2024 10:55:54 +0000
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
Subject: [PATCH net-next v2] net: mvpp2: tai: warn once if we fail to update
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
Message-Id: <E1tLKNm-006eTd-FD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Dec 2024 10:55:54 +0000

The hardware timestamps for packets contain a truncated seconds field,
only containing two bits of seconds. In order to provide the full
number of seconds, we need to keep track of the full hardware clock by
reading it every two seconds.

However, if we fail to read the clock, we silently ignore the error.
Print a warning indicating that the PP2 TAI clock timestamps have
become unreliable.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
--
v2: correct dev_warn_once() indentation
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
index 95862aff49f1..6b60beb1f3ed 100644
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
+		dev_warn_once(tai->dev, "PTP timestamps are unreliable");
 
 	return msecs_to_jiffies(2000);
 }
@@ -401,6 +403,7 @@ int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv)
 
 	spin_lock_init(&tai->lock);
 
+	tai->dev = dev;
 	tai->base = priv->iface_base;
 
 	/* The step size consists of three registers - a 16-bit nanosecond step
-- 
2.30.2


