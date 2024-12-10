Return-Path: <netdev+bounces-150643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D309EB0F9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E96286762
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD411A38F9;
	Tue, 10 Dec 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E2d1+xKY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD61A0BE3
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834313; cv=none; b=e9AlOwesD/V7WhM0zmdodZDRVkbsXZewFUcTnKbr82GUkpLxc5nZRnDj/KmiKn7vZBwp+eZOUDBhsJciLr8chtmQ3Zm2zzc1WMuQx6kqcynmMMHkOEeFvR482uXDCbjqO5YGxCjzVwbpPU19ws+0cNth6+H5nu/6CboivluA2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834313; c=relaxed/simple;
	bh=2RpZVsF5f4Qlmvm4MyEKjsC2XNO8D5+c7gQarKC4xsw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=uWr/eF/x/u2PPaeXffcQRI2KNMvy7XXbncr91oYbh3cttHQ1mdcWpL3liqMmviqh9AOsRZ2IIAtzUIU35EVWx7MT4AskVqTMaRMgGca1YjW0s9KJMcYDrimyPHoaLwTOG8DVAz/l/5bTsyz9OKaXtR4YN9PU25sPrV9qv1gcV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E2d1+xKY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Y7t+5+55gUrZzwT9YKC1uhEW6PBOndPQQZe0SUV32c=; b=E2d1+xKY2kJCC56cQXj7ywMyp/
	ohuZpAzCjUdIuQUvdRjW/uUJ4ImEmWZKOdsWuID9eTeueDHK2zxcnpyVqlxJahgTvIio0V8sBmMex
	StjyFSxF6AmUBZ1qapJ5fcmhf0buWwnfzDcj3F04NV5lbXLdsdJpohkESs6OKENO88dkO5nBU5mTU
	HU3fK2p+O1+fiePmPGy1uHaXxWD5JTuDzbknRHS1tshulI/3rp6uuzRjwZnSDP0sS4fp8XP/9GGS4
	+0aRGP0H/LjEM6+FZ/BbZVTruZRqf7BlGNBrMQoSeMZiNkph2YvX3OVyY+WnJhpPRJLGitT3MRtbk
	7tr12oXg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41440 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKzVO-0002Im-2i;
	Tue, 10 Dec 2024 12:38:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKzVN-006c5w-EH; Tue, 10 Dec 2024 12:38:21 +0000
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
Subject: [PATCH net-next] net: mvpp2: tai: warn once if we fail to update our
 timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKzVN-006c5w-EH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 12:38:21 +0000

The hardware timestamps for packets contain a truncated seconds field,
only containing two bits of seconds. In order to provide the full
number of seconds, we need to keep track of the full hardware clock by
reading it every two seconds.

However, if we fail to read the clock, we silently ignore the error.
Print a warning indicating that the PP2 TAI clock timestamps have
become unreliable.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
index 95862aff49f1..4a2da9277e05 100644
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
+		  dev_warn_once(tai->dev, "PTP timestamps are unreliable");
 
 	return msecs_to_jiffies(2000);
 }
@@ -401,6 +403,7 @@ int mvpp22_tai_probe(struct device *dev, struct mvpp2 *priv)
 
 	spin_lock_init(&tai->lock);
 
+	tai->dev = dev;
 	tai->base = priv->iface_base;
 
 	/* The step size consists of three registers - a 16-bit nanosecond step
-- 
2.30.2


