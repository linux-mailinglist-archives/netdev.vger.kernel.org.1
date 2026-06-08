Return-Path: <netdev+bounces-296338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KtlQIykaJmpCSQIAu9opvQ
	(envelope-from <netdev+bounces-296338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 03:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673B652134
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 03:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=TavPkn4N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296338-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF1630062C3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15992F8E8B;
	Mon,  8 Jun 2026 01:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409412F362B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 01:25:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881955; cv=none; b=Pcz/srvZ1nE5fXTCn14Li1YUxDQm12p3NL/yuNGt0EyK6NadLbQfYCbr+nzVU0uTf59fNN2ED8o0ZdvQYv0TTF96dUpvQuiTTonVA26gBj/ReCLIFQeKzczLOmM9fjQusxh7INDCxq0VESOvoOM98PWjs/0XM4KkDBZA4AVoUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881955; c=relaxed/simple;
	bh=+StYncN4X0KxwjEx9SUbzL1fyuoxpjaZa9yn60ZW38Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSmwEzQ+eZtHgwVTELH7+l7MnVIQdntqTUm3BOt8/3oIVPtkCmEyfHkCLNliupPB5ihdggvKuRcnEKauz/2eqXZ9CKNSLjo7PCbQl0/QmsOsuvjEER3O8zCVxk1PMgveUqFpbGs1fAeOez3dS9ktzX4EOYvd/7tT1A4TresKXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TavPkn4N; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780881946;
	bh=ddbrwbb+3ExuwngQwkQyerhjD2yf2yF9135LCs4Ru4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TavPkn4Nejd6uxgYixMwIyhJFgvSGpwzJ3Ow7Wu+vKw9KeTUWScuO81r221piEcit
	 b2uoiF5RDhwEACPRc4dYurTtBzcevHWloH5rWUdB5oa9RUiY+f7FRe2WYp4ATZz9fj
	 XxHcb4vdjfpef4zYfBS+aMgHD6D+8D1tMf0s5h3TemjZcqdFb3r09AYc8JHozmIxay
	 xuhkgLbBX4oPe7OTeyDgZANS04Rp9KlgYNlvjM1n4XKNlX1G6J0mQ79p15JmOj7VPB
	 9paO29fbmTaG/wKEmzaib1TwurIdkVa9dsHqxkm9hINTrhjkibeh8cI2VLNV0YyZwE
	 9VOK2x8ytyv1g==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 137CE60878; Mon,  8 Jun 2026 09:25:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 08 Jun 2026 09:25:40 +0800
Subject: [PATCH net v2 1/2] net: mctp: usb: fix race between urb completion
 and rx_retry cancellation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-dev-mctp-usb-rx-requeue-v2-1-29a3aa507609@codeconstruct.com.au>
References: <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
In-Reply-To: <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rx_retry_work.work:url,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,codeconstruct.com.au:from_mime,codeconstruct.com.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3673B652134

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

That urb completion can then re-schedule rx_retry_work.

Strenghen the sequencing between the stop (preventing another requeue)
and the cancel by updating both atomically under a new rx lock. After
setting ->rx_stopped, and cancelling pending work, we know that the
requeue cannot occur, so all that's left is killing any pending urb.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
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


