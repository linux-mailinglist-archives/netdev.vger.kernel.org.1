Return-Path: <netdev+bounces-305738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8HdAA0ohTmohDwIAu9opvQ
	(envelope-from <netdev+bounces-305738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:07:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6014E7240A1
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:07:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b="X9/7U6Co";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305738-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305738-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F6E3033828
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FC379C5D;
	Wed,  8 Jul 2026 09:59:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57C202963;
	Wed,  8 Jul 2026 09:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504798; cv=none; b=fOvDw2KxtICiKTzsYKmMozAe6qfgZW3qndSWXffGA7TQceOg+EctgVoB6fdLPmCg+TV6ESwOC38cPxqhZLFwtzaiBoleY7uSrnBXPvfRUplpzqJehxIHqs0PIkoqKzUy72AlWI2LEqaeq0A/o4PJ3k/TJ7rPvSTh+BpE5PdF7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504798; c=relaxed/simple;
	bh=nf47f3pzTJS1vj9mzHuXzvIHt7Go83P6f+MM7+GRjNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSfuj8jM5DL+nACxqf57wl4KcwgBUHsGXzzt8etZnq0JQpYE1auz552phIY1H3fen/9u+0jLh75bON3PiSubh8aAzNcGeWo1GM+UUrFeKKPYaUjMIvlNa10CPFFDzcS5zMP0gNLxn0JYbAurv9XoQRiW5Qpj+HYRQIXJ68Flx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=X9/7U6Co; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504792;
	bh=2FQwAjLzEPg/3//LwE6OHMnLOHuSWNBVQz1WVQf4qys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X9/7U6Co58XGiz4Ik9tREoLJblFmNxLtXWe0Nrjqa2TRBHFh4d/V9JMPYwbqYCg3z
	 rLkYZCO8yh/ShXntrZV6/WkE3U0ZKsibjRwrNKh9WD9Xu9bMUXBn7XVYGHJ9nSmyjl
	 zXRBFmMkWxiUd6cnd3YcCvpFeLaRGZLeoteHQsSAfB69OS1lrGZtCh+FhYAGEcmhwq
	 0ieXdVhj5SOtSE69hNLzIT1Vh71NTFGyaW3QEE+lSve4pAXJd1UOU5ShRD88swgO7g
	 A919ud1VWwucg75Y82n3Vs7q4ybmndqEw4rwIzQQraMq/OSehwvmt4v33kdmO+SYIT
	 B7wOgpzGTr/qA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 46D2766593; Wed,  8 Jul 2026 17:59:52 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:43 +0800
Subject: [PATCH net-next v3 12/12] net: mctp: usb: Allow multiple urbs in
 flight
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-12-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6014E7240A1

Currently, we stop tx queues when we have one urb submitted. This means
we will immediately hit dev_hard_start_xmit's tx-queues-off ->
NETDEV_TX_BUSY case, and revert to the requeue -> gso_skb single-dequeue
path, and no longer be able to pack skbs without an xmit_more
indication.

Instead, allow a few urbs to be in-flight, with a limit of 16kB of data
outstanding (after which we will disable queues). With this, the tx path
will cause fewer requeues (and therefore non-packed transfers) under
normal loads.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v2:
 - rework tx_qmem locking, prevent race between completion and
   submission for stopping/waking the tx queues; perform the wake while
   locked
 - only wake if netif_running()
---
 drivers/net/mctp/mctp-usb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 8e29be9ebd1d..2d31075374b4 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -42,6 +42,9 @@ struct mctp_usb {
 
 	struct mctp_usblib_tx tx;
 	struct usb_anchor tx_anchor;
+	/* serialises tx_qmem updates to netdev queue states */
+	spinlock_t tx_qmem_lock;
+	int tx_qmem;
 };
 
 enum {
@@ -49,23 +52,41 @@ enum {
 	MCTP_USB_SUBCLASS_SPAN = 0x02,
 };
 
+/* We use a total-size limit for outstanding URBs, as the transfer counts
+ * may vary a lot between spanning- and non-spanning modes. In spanning mode,
+ * this will allow for a couple of max-sized transfers to be in flight. In
+ * non-spanning mode, 32.
+ *
+ * We want to avoid disabling the tx queue if possible; doing so will end up
+ * requeueing to gso_skb, and we only dequeue from that one skb at a time,
+ * so can no longer perform transfer packing.
+ */
+static const unsigned int TX_QMEM_MAX = 16384;
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned int len = urb->transfer_buffer_length;
 	struct net_device *netdev = mctp_usb->netdev;
+	unsigned long flags;
 
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
 	usb_free_urb(urb);
 
-	netif_wake_queue(netdev);
+	spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+	mctp_usb->tx_qmem -= len;
+	if (mctp_usb->tx_qmem < TX_QMEM_MAX && netif_running(netdev))
+		netif_wake_queue(netdev);
+	spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 }
 
 static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			    void *data, size_t len)
 {
 	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned long flags;
 	struct urb *urb;
 	int rc;
 
@@ -80,8 +101,6 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 	if (mctp_usb->span)
 		urb->transfer_flags |= URB_ZERO_PACKET;
 
-	netif_stop_queue(mctp_usb->netdev);
-
 	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
@@ -89,7 +108,12 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
 		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		netif_start_queue(mctp_usb->netdev);
+	} else {
+		spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+		mctp_usb->tx_qmem += len;
+		if (mctp_usb->tx_qmem >= TX_QMEM_MAX)
+			netif_stop_queue(mctp_usb->netdev);
+		spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 	}
 
 	return rc;
@@ -333,6 +357,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	if (dev->span)
 		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
+	spin_lock_init(&dev->tx_qmem_lock);
 	usb_set_intfdata(intf, dev);
 
 	mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),

-- 
2.47.3


