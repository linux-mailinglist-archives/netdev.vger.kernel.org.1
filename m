Return-Path: <netdev+bounces-295699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id On+5ESZ8Imo4YQEAu9opvQ
	(envelope-from <netdev+bounces-295699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:35:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5FC64608C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b="AZk8/sNY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295699-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA6C93116E78
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8A478841;
	Fri,  5 Jun 2026 07:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0282EEE6E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:25:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644305; cv=none; b=ud9V8431fcfjJkPeaRmgORPXHyF2c62wzNMIWSP9eTg76vieroNHt5uGDuL/mCOd/Mh2UlaBm6WyARogirs9BM5gw0V+GqIFrVonKhf9mRlBMttUwVr2qY0AIhhhQMpOoIUwg92KPIyAltXKSfluJCN42onhMJmorNn9Fq7viOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644305; c=relaxed/simple;
	bh=9grFE2KSODKoIdN9ek3i3EUMv2sEpMNnec0jRm2cbow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JM6huxcB36Dfn8Z+eGixC9BjPcx9FCHqrT3ZEquyddCrp583qiSNbdTU2sZ9Mtiwi0SbDM4UKZLn1YsfD0hdBeUVLVcHyf0g5THosEgXi+fR3lZhCFS8XkFUkeoPVJfm0a1ACeY/yLQARHoYf8mjggY75vRYiE+Wlnunthf/2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AZk8/sNY; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780644301;
	bh=OHZN43dKP5RfoSHgsdj7tvTpoo8gmu9tGeIA54hNkxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AZk8/sNYVI7hsso7iuvZnGBxYB7K639bU7dW4MZwr48sIxAJ6vUCuXWrn+pLdhOuo
	 Tdx46MZYzeW5Z5/9ZS5BXR/QyjAtenwiN3zwGmNk5FcSTBo4geuURCouOoJfcaQr/S
	 FfhA4frJ1GhcZ7kj1pn+lP7xFikl7d+eJSvSdYPKqLKH93dNZg//B0kgEngEl/e7/P
	 JuHg03AGrQ9f3Eun6liF89c5g8DQLc3qlwYTidi1acmLjsvUUDOm6XkYffU3Sg+qmm
	 nTVwLDqUwLyWfOb/u5ojQG/btDZIfF2PlWYGc9aXaw9L0lGasKLIHUDbZX4UCznB0r
	 VqRC/puBJgexg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0E99965093; Fri,  5 Jun 2026 15:25:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 05 Jun 2026 15:24:14 +0800
Subject: [PATCH net 1/2] net: mctp: usb: fix race between urb completion
 and rx_retry cancellation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-dev-mctp-usb-rx-requeue-v1-1-b86993d01ac0@codeconstruct.com.au>
References: <20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au>
In-Reply-To: <20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:jk@codeconstruct.com.au,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,rx_retry_work.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F5FC64608C

It's possible that sequencing between setting ->stopped and cancelling
the rx_retry work (in ndo_stop) could leave us with an urb queued:

    T1: ndo_stop                  T2: rx_retry_work
    ------------                  ----------------
                                  LD: ->stopped => false
    ST: ->stopped <= true
    usb_kill_urb()
                                  mctp_usb_rx_queue()
                                    usb_submit_urb()
    cancel_delayed_work_sync()

Strenghen the sequencing between the stop (preventing another requeue)
and the cancel by updating both atomically under a new rx lock. After
setting ->rx_stopped, and cancelling pending work, we know that the
requeue cannot occur, so all that's left is killing any pending urb.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 3b5dff144177..cf6f6a93a451 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -22,7 +22,6 @@
 struct mctp_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
-	bool stopped;
 
 	struct net_device *netdev;
 
@@ -32,6 +31,9 @@ struct mctp_usb {
 	struct urb *tx_urb;
 	struct urb *rx_urb;
 
+	/* enforces atomic access to rx_stopped and requeuing the retry work */
+	spinlock_t rx_lock;
+	bool rx_stopped;
 	struct delayed_work rx_retry_work;
 };
 
@@ -122,6 +124,7 @@ static const unsigned long RX_RETRY_DELAY = HZ / 4;
 
 static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 {
+	unsigned long flags;
 	struct sk_buff *skb;
 	int rc;
 
@@ -147,7 +150,10 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	return rc;
 
 err_retry:
-	schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
+	spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+	if (!mctp_usb->rx_stopped)
+		schedule_delayed_work(&mctp_usb->rx_retry_work, RX_RETRY_DELAY);
+	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
 	return rc;
 }
 
@@ -248,9 +254,6 @@ static void mctp_usb_rx_retry_work(struct work_struct *work)
 	struct mctp_usb *mctp_usb = container_of(work, struct mctp_usb,
 						 rx_retry_work.work);
 
-	if (READ_ONCE(mctp_usb->stopped))
-		return;
-
 	mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
 }
 
@@ -258,7 +261,7 @@ static int mctp_usb_open(struct net_device *dev)
 {
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
 
-	WRITE_ONCE(mctp_usb->stopped, false);
+	WRITE_ONCE(mctp_usb->rx_stopped, false);
 
 	netif_start_queue(dev);
 
@@ -268,17 +271,21 @@ static int mctp_usb_open(struct net_device *dev)
 static int mctp_usb_stop(struct net_device *dev)
 {
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
+	unsigned long flags;
 
 	netif_stop_queue(dev);
 
 	/* prevent RX submission retry */
-	WRITE_ONCE(mctp_usb->stopped, true);
+	spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+	mctp_usb->rx_stopped = true;
+	cancel_delayed_work(&mctp_usb->rx_retry_work);
+	spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
+
+	flush_delayed_work(&mctp_usb->rx_retry_work);
 
 	usb_kill_urb(mctp_usb->rx_urb);
 	usb_kill_urb(mctp_usb->tx_urb);
 
-	cancel_delayed_work_sync(&mctp_usb->rx_retry_work);
-
 	return 0;
 }
 
@@ -331,6 +338,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	dev->netdev = netdev;
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
+	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
 	dev->ep_in = ep_in->bEndpointAddress;

-- 
2.47.3


