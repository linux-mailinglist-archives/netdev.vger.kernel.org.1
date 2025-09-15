Return-Path: <netdev+bounces-223097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57717B57F54
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC803BACE1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAC31C565;
	Mon, 15 Sep 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TzLxw/oV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB26334723
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947337; cv=none; b=UfDtKtTy4xF0XgCVRiALyqGN5+e1L5/P2cywsKOOE6ll0o+oKr5UaMPZWjU47AdZWWOCZ/q+pvKEv4A4+67vF4XxTxxDtssFhZNPjM8WcLJMOKD3FruEh8SqGw+MA2A/E6d1tk41S4aE/VatCUmhtM4npW1O2u9YhVa+a2m0Wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947337; c=relaxed/simple;
	bh=jeI8PSzbZZ7Z+pal3lt3rL+QC2O42V8dlsZm4Z/7p8g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SQZRjr/+NMIJNIy5GPEJTyxVkPkE7umyJBIjO+qb8kCwzIUL2RTz3DrDhYlhL2FDaYEevLOxk9dL4bJ/qUyz204vvwJMrt41196zN3MLLmN80EzBEBrOmaNawmEbO+JAvQImYahTLGFVqd0rbjKzSbsU4aa3ByUPO7LMsEOKkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TzLxw/oV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b5N7H20JIuzaWKE/IdgrKSPktcQcllLZYfJZoGtLKA4=; b=TzLxw/oV/yRpPHMKxL0bzI9fcQ
	BdeqfPMy5y8XgAWpI1a2mQI9Vh1cZvWtS6SX8aBtJMJODyYjuj0E1+2zN1LT+ZhgS/NRAdFMkQ5KA
	SP/A7Lrwpre4xS6Gxv0uBqyM6O86RpFRALNyvzYnVq8S3lyri7BuQ+cA7r+6Iwnsu7oPfTbUMv9O5
	+cmWto+KO1G4M65+ncL1dvP+MYAfYgdXyrlWBfqq6BeycJLldcdZH+X/UCSTkMU48dijcrOVjAOas
	KQuZ6m3pf9o1acTH4Os3Usxn06DnbZJogumMtzUqTnB/T+mahHfANWC43JHi9rPhbLirGpYWNo9Km
	ufk83wTg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53628 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uyAP8-000000000fk-2rQP;
	Mon, 15 Sep 2025 15:42:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uyAP7-00000005lGq-3FqI;
	Mon, 15 Sep 2025 15:42:05 +0100
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
Subject: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to disable
 events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 15:42:05 +0100

the ordering of ptp_clock_unregister() is not ideal, as the chardev
remains published while state is being torn down. There is also no
cleanup of enabled pin settings, which means enabled events can
still forward into the core.

Rework the ordering of cleanup in ptp_clock_unregister() so that we
unpublish the posix clock (and user chardev), disable any pins that
have events enabled, and then clean up the aux work and PPS source.

This avoids potential use-after-free and races in PTP clock driver
teardown.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/ptp/ptp_chardev.c | 13 +++++++++++++
 drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
 drivers/ptp/ptp_private.h |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index eb4f6d1b1460..640a98f17739 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -47,6 +47,19 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
 	return err;
 }
 
+void ptp_disable_all_pins(struct ptp_clock *ptp)
+{
+	struct ptp_clock_info *info = ptp->info;
+	unsigned int i;
+
+	mutex_lock(&ptp->pincfg_mux);
+	for (i = 0; i < info->n_pins; i++)
+		if (info->pin_config[i].func != PTP_PF_NONE)
+			ptp_disable_pinfunc(info, info->pin_config[i].func,
+					    info->pin_config[i].chan);
+	mutex_unlock(&ptp->pincfg_mux);
+}
+
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1d920f8e20a8..d2eb77081071 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -498,9 +498,23 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
 	}
 
+	/* Get the device to stop posix_clock_unregister() doing the last put
+	 * and freeing the structure(s)
+	 */
+	get_device(&ptp->dev);
+
+	/* Wake up any userspace waiting for an event. */
 	ptp->defunct = 1;
 	wake_up_interruptible(&ptp->tsev_wq);
 
+	/* Tear down the POSIX clock, which removes the user interface. */
+	posix_clock_unregister(&ptp->clock);
+
+	/* Disable any pin functions that the user may have setup, quiescing
+	 * all incoming events.
+	 */
+	ptp_disable_all_pins(ptp);
+
 	if (ptp->kworker) {
 		kthread_cancel_delayed_work_sync(&ptp->aux_work);
 		kthread_destroy_worker(ptp->kworker);
@@ -510,7 +524,8 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	posix_clock_unregister(&ptp->clock);
+	/* The final put, normally here, will invoke ptp_clock_release(). */
+	put_device(&ptp->dev);
 
 	return 0;
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index b352df4cd3f9..9d90aace7e64 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -141,6 +141,8 @@ extern const struct class ptp_class;
  * see ptp_chardev.c
  */
 
+void ptp_disable_all_pins(struct ptp_clock *ptp);
+
 /* caller must hold pincfg_mux */
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan);
-- 
2.47.3


