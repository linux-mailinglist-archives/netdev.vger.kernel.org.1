Return-Path: <netdev+bounces-223732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8CAB5A410
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DB3582F5F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33537283FF0;
	Tue, 16 Sep 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VZuvD9Vm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344F281369
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058576; cv=none; b=Dm7w1CgcW+fUOksYiWnvGuOdpxK8j4TxwcNfUks6MZvBjeyKNgads3fFLJJUlY4PxeIuUVTTjO+a3wmMXqO0+37BdeIFvAaJ4TqfmL1kFq9nTmQZMOU4SMR0nFAiXk2i5EHPVbQv/k42p7boS/AL3HTVdS/wuhkYJg6NBN6CkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058576; c=relaxed/simple;
	bh=N56YtZJFoXvsE7cRT1onTi17/fepHuemQoI30iftZh4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jqwF3BnPS4aiyysRG9OmOYa8laa4xSvLGLqqHLIkuKpMiDSilC+B1o6uRhWti7xq45B2wHuovqmflIIQwyP25z4hOkVszr7WTObB7bH6uQDlviAeT6/cjX5eKW7zgFNwRyiyV7kU2Vp7okNqX3VO+uL1ylOJcSiyqs8XqGAcvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VZuvD9Vm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kRXoK0A2hBXkU7zBWyuZuw+fxiVrjBZqA9iVdeGMOLk=; b=VZuvD9VmcNDTwAHN7jn2a2HRs4
	+b4FqadQcvgxW+fz9bZA1kKt7kx6Zh3iZvTlSOHAINJtUJYNJAi+ImGgf8o4sbI4B0MzHT+KlVMRF
	FznaiCMNSqQo+9lCziditrXqLCgCi/XQCpF8fRW5GZHYQKfdes3UXALvFMzqx1FDhAS4lWJMr57P+
	F96+rJC4qOt9dGhdb2mh5fY1ZHbCTN4O80vSg4cmhjJUUJS9FScN5A0KDky314I3bDU3U0RudxJKB
	xuovbpNVMsa4JtCv/epI2g/4eRm01ClxQDz/WjJYZS23lj073YSo2j/B67In3zZo5kxX3nytMsr4i
	0Aom7Pcw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47242 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uydLI-000000006Lm-1xiv;
	Tue, 16 Sep 2025 22:36:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uydLH-000000061DM-2gcV;
	Tue, 16 Sep 2025 22:36:03 +0100
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
Subject: [PATCH net-next v2 2/2] ptp: rework ptp_clock_unregister() to disable
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
Message-Id: <E1uydLH-000000061DM-2gcV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 22:36:03 +0100

The ordering of ptp_clock_unregister() is not ideal, as the chardev
remains published while state is being torn down, which means userspace
can race with the kernel teardown. There is also no cleanup of enabled
pin settings nor of the internal PPS event, which means enabled events
can still forward into the core, dereferencing a free'd pointer.

Rework the ordering of cleanup in ptp_clock_unregister() so that we
unpublish the posix clock (and user chardev), disable any pins that
have EXTTS events enabled, disable the PPS event, and then clean up
the aux work and PPS source.

This avoids potential use-after-free and races in PTP clock driver
teardown.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/ptp/ptp_chardev.c | 20 ++++++++++++++++++++
 drivers/ptp/ptp_clock.c   | 15 ++++++++++++++-
 drivers/ptp/ptp_private.h |  2 ++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index eb4f6d1b1460..8106eb617c8c 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -47,6 +47,26 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
 	return err;
 }
 
+void ptp_disable_all_events(struct ptp_clock *ptp)
+{
+	struct ptp_clock_info *info = ptp->info;
+	unsigned int i;
+
+	mutex_lock(&ptp->pincfg_mux);
+	/* Disable any pins that may raise EXTTS events */
+	for (i = 0; i < info->n_pins; i++)
+		if (info->pin_config[i].func == PTP_PF_EXTTS)
+			ptp_disable_pinfunc(info, info->pin_config[i].func,
+					    info->pin_config[i].chan);
+
+	/* Disable the PPS event if the driver has PPS support */
+	if (info->pps) {
+		struct ptp_clock_request req = { .type = PTP_CLK_REQ_PPS };
+		info->enable(info, &req, 0);
+	}
+	mutex_unlock(&ptp->pincfg_mux);
+}
+
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1d920f8e20a8..ef020599b771 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -498,9 +498,21 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
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
+	/* Disable all sources of event generation. */
+	ptp_disable_all_events(ptp);
+
 	if (ptp->kworker) {
 		kthread_cancel_delayed_work_sync(&ptp->aux_work);
 		kthread_destroy_worker(ptp->kworker);
@@ -510,7 +522,8 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	posix_clock_unregister(&ptp->clock);
+	/* The final put, normally here, will invoke ptp_clock_release(). */
+	put_device(&ptp->dev);
 
 	return 0;
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index b352df4cd3f9..76ab9276b588 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -141,6 +141,8 @@ extern const struct class ptp_class;
  * see ptp_chardev.c
  */
 
+void ptp_disable_all_events(struct ptp_clock *ptp);
+
 /* caller must hold pincfg_mux */
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan);
-- 
2.47.3


