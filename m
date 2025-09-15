Return-Path: <netdev+bounces-223096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C4B57F51
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC91A2724F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51E32CF91;
	Mon, 15 Sep 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BNzw5wz7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859030E0E4
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947334; cv=none; b=XVzTDWnuuj2tmSUg4VXyyX3mQ1Vhom9i8vMoXhnU+dMiElJxuPS/j+4n9L10dNBKRkCiEJWbj+inYNlBOLXXhrArV+3L8j110zN5Amkz1kgjKRH44iEXhrOlkM3J8PXoMb1x6butRpCPGCVCxJnjcP8e2WlBp2PAkMAjjWyMxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947334; c=relaxed/simple;
	bh=RLDlBUtOc4ONtuNE3I+2mNBg5QYOg5SppYGstOxgwWg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VFSzWp8dZIhWmxdN0rAvU7ZewpxpeoIY9jize+9YeEby/I+68Z47WoOZ+0uA6zFdo68vuyEXZLPbnuHRmuKZnZmr4e9stYZHc2caoThkV0LN6keOBZngqEUzItCVczvzhBTyB0n/Xng2AA1DH2Vdm+U+Ji6YQ5ueqFWnShGu/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BNzw5wz7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rXzVoJbLD07uRSjmM2W32eBL7DaVMX2GcKV9vs+BS+M=; b=BNzw5wz7bKH7GiXkxxriRstZHT
	6K9qNd9HdqTQuj2vbvpDfCPppZEqly9OFSXc7FyNlcNJ23Nfw7Tf6gKRHWC0gnUG41e/Hb1beT9gf
	4RVqfJdE0d0qwYqO501ap47wn5NAj6VP6yD0uxyv4lC03K5LfhmzQqFSghawVMMKxWHlcZU9n9TVi
	TmweXy941hfkAasoQP9Ur37GNHO9xSRXLktJVWYa4CbvN2k3wtIUbbN6J0CmZnTgu+OCdpEI8d4B9
	6zdlltwSa68C4zt5B2YeH7+YwoUyRzNh79GCe4lEBLfxUB7uOJak/kgMAbLhzVbnTYOdqT+lYs+83
	ChKrTWvA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53618 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uyAP3-000000000fU-1w4w;
	Mon, 15 Sep 2025 15:42:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uyAP2-00000005lGk-2q9l;
	Mon, 15 Sep 2025 15:42:00 +0100
In-Reply-To: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net-next 1/2] ptp: describe the two disables in
 ptp_set_pinfunc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uyAP2-00000005lGk-2q9l@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 15:42:00 +0100

Accurately describe what each call to ptp_disable_pinfunc() is doing,
rather than the misleading comment above the first disable. This helps
to make the code more readable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/ptp/ptp_chardev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index e9719f365aab..eb4f6d1b1460 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -91,12 +91,18 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		return -EOPNOTSUPP;
 	}
 
-	/* Disable whatever function was previously assigned. */
+	/* Disable whichever pin was previously assigned to this function and
+	 * channel.
+	 */
 	if (pin1) {
 		ptp_disable_pinfunc(info, func, chan);
 		pin1->func = PTP_PF_NONE;
 		pin1->chan = 0;
 	}
+
+	/* Disable whatever function was previously assigned to the requested
+	 * pin.
+	 */
 	ptp_disable_pinfunc(info, pin2->func, pin2->chan);
 	pin2->func = func;
 	pin2->chan = chan;
-- 
2.47.3


