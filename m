Return-Path: <netdev+bounces-223731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B7B5A40F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20254582F89
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9802283FF0;
	Tue, 16 Sep 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i750OeBt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E1285C95
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058570; cv=none; b=XM5E3rCOnEEDdVHlCeZwqsnD6SLmJoTO7r7cAukO6/Eh88t+G6JvsOt4foF6sUic2NReZ1umvgGnodBQvRyhdmyNA7ST4CyYosPudNNy1wVHjVWi2yxeEkOD5IH3XL0gCaxdFUJXgJyFJpAiLgbkUy235XEqeNTKiD9bKsdpaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058570; c=relaxed/simple;
	bh=R4IvnZP2BURM3byBfHmk2G06US6ImqiQPBrwjfp+Gq8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PIlwQQ8uGFEUqkDy7cJI3/AkMx/KRw3FenI+92b5a78Jjz87R0EuTLTmRT/Re54qSh0OWzRVnfLDc4KRfmdoyI3kETnMQXosNtJzGTmJ/pnNlptah5LF8uJ1YtIOd1Lt9CbaRDuHgl92YUrCW7l4mQE4Vj5BlvgaxLo1YKA3QAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i750OeBt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IG3KIjpS95Gc1iwbQ1wqN6dm9jeRa7ZM8TVQTaMIbFE=; b=i750OeBtu0cttNNbqqkqE6VLrW
	XkmXkF6xAJKJdUng4rBLBPQSyOCch+siXxAEjrn2xPCiMBYwHfYe8/mbGJ8qmlx1/olehbM2LgZTk
	WiyznEQGHOHu9AS1s82mJlUMffZ4++pyEFoQSvg7Sm4oGGhQgHLNqguvwFeat0cVfAcEBbaCMEafB
	wqarakGmvb3+vf7aReoPD7iknk/CcBcFv9bNSBMeXKbFnbDGfitZh3aNKrjSEuApFkwLZQNM0yGNS
	IoJv/MSD28+Qc4SAHrrUE3V0VCEkCS1DOEMQ23uPn2VozBQVHClR9GExQhs94sj3nM11WxFAAAy6+
	Tr2CN2Yg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47228 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uydLD-000000006LX-1JJa;
	Tue, 16 Sep 2025 22:35:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uydLC-000000061DG-2BRt;
	Tue, 16 Sep 2025 22:35:58 +0100
In-Reply-To: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
References: <aMnYIu7RbgfXrmGx@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 1/2] ptp: describe the two disables in
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
Message-Id: <E1uydLC-000000061DG-2BRt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 22:35:58 +0100

Accurately describe what each call to ptp_disable_pinfunc() is doing,
rather than the misleading comment above the first disable. This helps
to make the code more readable.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
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


