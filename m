Return-Path: <netdev+bounces-237933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C5C51AF3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68764FC7EA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20A303A03;
	Wed, 12 Nov 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sOa+d6dA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sOa+d6dA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE43019A2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943178; cv=none; b=loNN1oUSMLs3Ewh7TLKW2hz67xYjYfAy0Jtk+jXHzQjVTUppFLmoEQoHHuccxwznMgWRjF+lXniDbzUw+TzYg7AJkH9ChqODWsUTP6JDvOQidjKZcizQ+V1jXI+tfgQ+Pa+KVbDda86jknu+VrHU6WkBxAVj9ANva0YScOEwozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943178; c=relaxed/simple;
	bh=YvoNd64pzl5ss9nn0rssJbnU35KZXGmEAjwcd0ohukA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgrfngDeiCSLtMq+hQYY8+14K54DCZQiwgRZ69ozYUqZmdXCi6QCCA32+BN+jDJfMVZ7fIkeh2IZr/Ev7r6oeUwfkpE3iGPtq5wHCJGjE0uP4V54iFxNiOv7M7Gsb7RP5ivMbRL//hwfXgdObI1F4jaF53NJ0bFuvhOnOp9HHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sOa+d6dA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sOa+d6dA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFACE21B88;
	Wed, 12 Nov 2025 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762943173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M2yHZQB89iinIDJsvYvno2OLlMNlzc2IAST5uE5DI+g=;
	b=sOa+d6dAVwicKw8S2kY3BByQlJMAa0sle6l5ronk9sgE8dJXys+rIVwKUGtSn4EKItPZTy
	80TL0Fksxg1+qecLFa/cpid1+JnN0v8JOCdat6B/6dDljsc72Gv3wZTXFd4PeITjuyFbaF
	i3objAF15p6h15JCBvkIGkAdBWQOass=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762943173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=M2yHZQB89iinIDJsvYvno2OLlMNlzc2IAST5uE5DI+g=;
	b=sOa+d6dAVwicKw8S2kY3BByQlJMAa0sle6l5ronk9sgE8dJXys+rIVwKUGtSn4EKItPZTy
	80TL0Fksxg1+qecLFa/cpid1+JnN0v8JOCdat6B/6dDljsc72Gv3wZTXFd4PeITjuyFbaF
	i3objAF15p6h15JCBvkIGkAdBWQOass=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 870D73EA61;
	Wed, 12 Nov 2025 10:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1fPH8VgFGlMOgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 12 Nov 2025 10:26:13 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net-next v1 1/1] net: usb: usbnet: adhere to style
Date: Wed, 12 Nov 2025 11:25:00 +0100
Message-ID: <20251112102610.281565-1-oneukum@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

This satisfies the coding style.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 233 ++++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 113 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 3d10cf791c51..1d9faa70ba3b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -142,16 +142,16 @@ int usbnet_get_endpoints(struct usbnet *dev, struct usb_interface *intf)
 
 	if (alt->desc.bAlternateSetting != 0 ||
 	    !(dev->driver_info->flags & FLAG_NO_SETINT)) {
-		tmp = usb_set_interface (dev->udev, alt->desc.bInterfaceNumber,
-				alt->desc.bAlternateSetting);
+		tmp = usb_set_interface(dev->udev, alt->desc.bInterfaceNumber,
+					alt->desc.bAlternateSetting);
 		if (tmp < 0)
 			return tmp;
 	}
 
-	dev->in = usb_rcvbulkpipe (dev->udev,
-			in->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
-	dev->out = usb_sndbulkpipe (dev->udev,
-			out->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+	dev->in = usb_rcvbulkpipe(dev->udev,
+				  in->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+	dev->out = usb_sndbulkpipe(dev->udev,
+				   out->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
 	dev->status = status;
 	return 0;
 }
@@ -163,7 +163,7 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 	int 		tmp = -1, ret;
 	unsigned char	buf [13];
 
-	ret = usb_string(dev->udev, iMACAddress, buf, sizeof buf);
+	ret = usb_string(dev->udev, iMACAddress, buf, sizeof(buf));
 	if (ret == 12)
 		tmp = hex2bin(addr, buf, 6);
 	if (tmp < 0) {
@@ -215,7 +215,7 @@ static void intr_complete(struct urb *urb)
 		break;
 	}
 
-	status = usb_submit_urb (urb, GFP_ATOMIC);
+	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status != 0)
 		netif_err(dev, timer, dev->net,
 			  "intr resubmit --> %d\n", status);
@@ -231,24 +231,24 @@ static int init_status(struct usbnet *dev, struct usb_interface *intf)
 	if (!dev->driver_info->status)
 		return 0;
 
-	pipe = usb_rcvintpipe (dev->udev,
-			dev->status->desc.bEndpointAddress
-				& USB_ENDPOINT_NUMBER_MASK);
+	pipe = usb_rcvintpipe(dev->udev,
+			      dev->status->desc.bEndpointAddress
+			      & USB_ENDPOINT_NUMBER_MASK);
 	maxp = usb_maxpacket(dev->udev, pipe);
 
 	/* avoid 1 msec chatter:  min 8 msec poll rate */
 	period = max ((int) dev->status->desc.bInterval,
 		(dev->udev->speed == USB_SPEED_HIGH) ? 7 : 3);
 
-	buf = kmalloc (maxp, GFP_KERNEL);
+	buf = kmalloc(maxp, GFP_KERNEL);
 	if (buf) {
-		dev->interrupt = usb_alloc_urb (0, GFP_KERNEL);
+		dev->interrupt = usb_alloc_urb(0, GFP_KERNEL);
 		if (!dev->interrupt) {
-			kfree (buf);
+			kfree(buf);
 			return -ENOMEM;
 		} else {
 			usb_fill_int_urb(dev->interrupt, dev->udev, pipe,
-				buf, maxp, intr_complete, dev, period);
+					 buf, maxp, intr_complete, dev, period);
 			dev->interrupt->transfer_flags |= URB_FREE_BUFFER;
 			dev_dbg(&intf->dev,
 				"status ep%din, %d bytes period %d\n",
@@ -339,7 +339,7 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 
 	/* only update if unset to allow minidriver rx_fixup override */
 	if (skb->protocol == 0)
-		skb->protocol = eth_type_trans (skb, dev->net);
+		skb->protocol = eth_type_trans(skb, dev->net);
 
 	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
 	u64_stats_inc(&stats64->rx_packets);
@@ -347,8 +347,8 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
 	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
 
 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
-		  skb->len + sizeof (struct ethhdr), skb->protocol);
-	memset (skb->cb, 0, sizeof (struct skb_data));
+		  skb->len + sizeof(struct ethhdr), skb->protocol);
+	memset(skb->cb, 0, sizeof(struct skb_data));
 
 	if (skb_defer_rx_timestamp(skb))
 		return;
@@ -511,8 +511,8 @@ static int rx_submit(struct usbnet *dev, struct urb *urb, gfp_t flags)
 		skb = __netdev_alloc_skb_ip_align(dev->net, size, flags);
 	if (!skb) {
 		netif_dbg(dev, rx_err, dev->net, "no rx skb\n");
-		usbnet_defer_kevent (dev, EVENT_RX_MEMORY);
-		usb_free_urb (urb);
+		usbnet_defer_kevent(dev, EVENT_RX_MEMORY);
+		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
@@ -521,27 +521,27 @@ static int rx_submit(struct usbnet *dev, struct urb *urb, gfp_t flags)
 	entry->dev = dev;
 	entry->length = 0;
 
-	usb_fill_bulk_urb (urb, dev->udev, dev->in,
-		skb->data, size, rx_complete, skb);
+	usb_fill_bulk_urb(urb, dev->udev, dev->in,
+			  skb->data, size, rx_complete, skb);
 
-	spin_lock_irqsave (&dev->rxq.lock, lockflags);
+	spin_lock_irqsave(&dev->rxq.lock, lockflags);
 
-	if (netif_running (dev->net) &&
-	    netif_device_present (dev->net) &&
+	if (netif_running(dev->net) &&
+	    netif_device_present(dev->net) &&
 	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
-	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
-	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
+	    !test_bit(EVENT_RX_HALT, &dev->flags) &&
+	    !test_bit(EVENT_DEV_ASLEEP, &dev->flags) &&
 	    !usbnet_going_away(dev)) {
-		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
+		switch (retval = usb_submit_urb(urb, GFP_ATOMIC)) {
 		case -EPIPE:
-			usbnet_defer_kevent (dev, EVENT_RX_HALT);
+			usbnet_defer_kevent(dev, EVENT_RX_HALT);
 			break;
 		case -ENOMEM:
-			usbnet_defer_kevent (dev, EVENT_RX_MEMORY);
+			usbnet_defer_kevent(dev, EVENT_RX_MEMORY);
 			break;
 		case -ENODEV:
 			netif_dbg(dev, ifdown, dev->net, "device gone\n");
-			netif_device_detach (dev->net);
+			netif_device_detach(dev->net);
 			break;
 		case -EHOSTUNREACH:
 			retval = -ENOLINK;
@@ -558,10 +558,10 @@ static int rx_submit(struct usbnet *dev, struct urb *urb, gfp_t flags)
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
 		retval = -ENOLINK;
 	}
-	spin_unlock_irqrestore (&dev->rxq.lock, lockflags);
+	spin_unlock_irqrestore(&dev->rxq.lock, lockflags);
 	if (retval) {
-		dev_kfree_skb_any (skb);
-		usb_free_urb (urb);
+		dev_kfree_skb_any(skb);
+		usb_free_urb(urb);
 	}
 	return retval;
 }
@@ -572,7 +572,7 @@ static int rx_submit(struct usbnet *dev, struct urb *urb, gfp_t flags)
 static inline int rx_process(struct usbnet *dev, struct sk_buff *skb)
 {
 	if (dev->driver_info->rx_fixup &&
-	    !dev->driver_info->rx_fixup (dev, skb)) {
+	    !dev->driver_info->rx_fixup(dev, skb)) {
 		/* With RX_ASSEMBLE, rx_fixup() must update counters */
 		if (!(dev->driver_info->flags & FLAG_RX_ASSEMBLE))
 			dev->net->stats.rx_errors++;
@@ -605,7 +605,7 @@ static void rx_complete(struct urb *urb)
 	int			urb_status = urb->status;
 	enum skb_state		state;
 
-	skb_put (skb, urb->actual_length);
+	skb_put(skb, urb->actual_length);
 	state = rx_done;
 	entry->urb = NULL;
 
@@ -621,7 +621,7 @@ static void rx_complete(struct urb *urb)
 	 */
 	case -EPIPE:
 		dev->net->stats.rx_errors++;
-		usbnet_defer_kevent (dev, EVENT_RX_HALT);
+		usbnet_defer_kevent(dev, EVENT_RX_HALT);
 		fallthrough;
 
 	/* software-driven interface shutdown */
@@ -639,8 +639,8 @@ static void rx_complete(struct urb *urb)
 	case -ETIME:
 	case -EILSEQ:
 		dev->net->stats.rx_errors++;
-		if (!timer_pending (&dev->delay)) {
-			mod_timer (&dev->delay, jiffies + THROTTLE_JIFFIES);
+		if (!timer_pending(&dev->delay)) {
+			mod_timer(&dev->delay, jiffies + THROTTLE_JIFFIES);
 			netif_dbg(dev, link, dev->net,
 				  "rx throttle %d\n", urb_status);
 		}
@@ -676,14 +676,14 @@ static void rx_complete(struct urb *urb)
 	state = defer_bh(dev, skb, &dev->rxq, state);
 
 	if (urb) {
-		if (netif_running (dev->net) &&
-		    !test_bit (EVENT_RX_HALT, &dev->flags) &&
+		if (netif_running(dev->net) &&
+		    !test_bit(EVENT_RX_HALT, &dev->flags) &&
 		    state != unlink_start) {
-			rx_submit (dev, urb, GFP_ATOMIC);
+			rx_submit(dev, urb, GFP_ATOMIC);
 			usb_mark_last_busy(dev->udev);
 			return;
 		}
-		usb_free_urb (urb);
+		usb_free_urb(urb);
 	}
 	netif_dbg(dev, rx_err, dev->net, "no read resubmitted\n");
 }
@@ -761,7 +761,7 @@ static int unlink_urbs(struct usbnet *dev, struct sk_buff_head *q)
 		spin_unlock_irqrestore(&q->lock, flags);
 		// during some PM-driven resume scenarios,
 		// these (async) unlinks complete immediately
-		retval = usb_unlink_urb (urb);
+		retval = usb_unlink_urb(urb);
 		if (retval != -EINPROGRESS && retval != 0)
 			netdev_dbg(dev->net, "unlink urb err, %d\n", retval);
 		else
@@ -769,7 +769,7 @@ static int unlink_urbs(struct usbnet *dev, struct sk_buff_head *q)
 		usb_put_urb(urb);
 		spin_lock_irqsave(&q->lock, flags);
 	}
-	spin_unlock_irqrestore (&q->lock, flags);
+	spin_unlock_irqrestore(&q->lock, flags);
 	return count;
 }
 
@@ -830,7 +830,7 @@ int usbnet_stop(struct net_device *net)
 	int			retval, pm, mpn;
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
-	netif_stop_queue (net);
+	netif_stop_queue(net);
 	netdev_reset_queue(net);
 
 	netif_info(dev, ifdown, dev->net,
@@ -910,23 +910,29 @@ int usbnet_open(struct net_device *net)
 	}
 
 	// put into "known safe" state
-	if (info->reset && (retval = info->reset (dev)) < 0) {
-		netif_info(dev, ifup, dev->net,
-			   "open reset fail (%d) usbnet usb-%s-%s, %s\n",
-			   retval,
-			   dev->udev->bus->bus_name,
-			   dev->udev->devpath,
-			   info->description);
-		goto done;
+	if (info->reset) {
+		retval = info->reset(dev);
+		if (retval < 0) {
+			netif_info(dev, ifup, dev->net,
+				   "open reset fail (%d) usbnet usb-%s-%s, %s\n",
+				   retval,
+				   dev->udev->bus->bus_name,
+				   dev->udev->devpath,
+				   info->description);
+			goto done;
+		}
 	}
 
 	/* hard_mtu or rx_urb_size may change in reset() */
 	usbnet_update_max_qlen(dev);
 
 	// insist peer be connected
-	if (info->check_connect && (retval = info->check_connect (dev)) < 0) {
-		netif_err(dev, ifup, dev->net, "can't open; %d\n", retval);
-		goto done;
+	if (info->check_connect) {
+		retval = info->check_connect(dev);
+		if (retval < 0) {
+			netif_err(dev, ifup, dev->net, "can't open; %d\n", retval);
+			goto done;
+		}
 	}
 
 	/* start any status interrupt transfer */
@@ -1056,7 +1062,7 @@ u32 usbnet_get_link(struct net_device *net)
 
 	/* If a check_connect is defined, return its result */
 	if (dev->driver_info->check_connect)
-		return dev->driver_info->check_connect (dev) == 0;
+		return dev->driver_info->check_connect(dev) == 0;
 
 	/* if the device has mii operations, use those */
 	if (dev->mii.mdio_read)
@@ -1085,7 +1091,7 @@ void usbnet_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
 	strscpy(info->driver, dev->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, dev->driver_info->description,
 		sizeof(info->fw_version));
-	usb_make_path (dev->udev, info->bus_info, sizeof info->bus_info);
+	usb_make_path(dev->udev, info->bus_info, sizeof(info->bus_info));
 }
 EXPORT_SYMBOL_GPL(usbnet_get_drvinfo);
 
@@ -1175,64 +1181,64 @@ usbnet_deferred_kevent(struct work_struct *work)
 	int			status;
 
 	/* usb_clear_halt() needs a thread context */
-	if (test_bit (EVENT_TX_HALT, &dev->flags)) {
-		unlink_urbs (dev, &dev->txq);
+	if (test_bit(EVENT_TX_HALT, &dev->flags)) {
+		unlink_urbs(dev, &dev->txq);
 		status = usb_autopm_get_interface(dev->intf);
 		if (status < 0)
 			goto fail_pipe;
-		status = usb_clear_halt (dev->udev, dev->out);
+		status = usb_clear_halt(dev->udev, dev->out);
 		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
-			if (netif_msg_tx_err (dev))
+			if (netif_msg_tx_err(dev))
 fail_pipe:
 				netdev_err(dev->net, "can't clear tx halt, status %d\n",
 					   status);
 		} else {
-			clear_bit (EVENT_TX_HALT, &dev->flags);
+			clear_bit(EVENT_TX_HALT, &dev->flags);
 			if (status != -ESHUTDOWN)
-				netif_wake_queue (dev->net);
+				netif_wake_queue(dev->net);
 		}
 	}
-	if (test_bit (EVENT_RX_HALT, &dev->flags)) {
-		unlink_urbs (dev, &dev->rxq);
+	if (test_bit(EVENT_RX_HALT, &dev->flags)) {
+		unlink_urbs(dev, &dev->rxq);
 		status = usb_autopm_get_interface(dev->intf);
 		if (status < 0)
 			goto fail_halt;
-		status = usb_clear_halt (dev->udev, dev->in);
+		status = usb_clear_halt(dev->udev, dev->in);
 		usb_autopm_put_interface(dev->intf);
 		if (status < 0 &&
 		    status != -EPIPE &&
 		    status != -ESHUTDOWN) {
-			if (netif_msg_rx_err (dev))
+			if (netif_msg_rx_err(dev))
 fail_halt:
 				netdev_err(dev->net, "can't clear rx halt, status %d\n",
 					   status);
 		} else {
-			clear_bit (EVENT_RX_HALT, &dev->flags);
+			clear_bit(EVENT_RX_HALT, &dev->flags);
 			if (!usbnet_going_away(dev))
 				queue_work(system_bh_wq, &dev->bh_work);
 		}
 	}
 
 	/* work could resubmit itself forever if memory is tight */
-	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
+	if (test_bit(EVENT_RX_MEMORY, &dev->flags)) {
 		struct urb	*urb = NULL;
 		int resched = 1;
 
-		if (netif_running (dev->net))
-			urb = usb_alloc_urb (0, GFP_KERNEL);
+		if (netif_running(dev->net))
+			urb = usb_alloc_urb(0, GFP_KERNEL);
 		else
-			clear_bit (EVENT_RX_MEMORY, &dev->flags);
+			clear_bit(EVENT_RX_MEMORY, &dev->flags);
 		if (urb != NULL) {
-			clear_bit (EVENT_RX_MEMORY, &dev->flags);
+			clear_bit(EVENT_RX_MEMORY, &dev->flags);
 			status = usb_autopm_get_interface(dev->intf);
 			if (status < 0) {
 				usb_free_urb(urb);
 				goto fail_lowmem;
 			}
-			if (rx_submit (dev, urb, GFP_KERNEL) == -ENOLINK)
+			if (rx_submit(dev, urb, GFP_KERNEL) == -ENOLINK)
 				resched = 0;
 			usb_autopm_put_interface(dev->intf);
 fail_lowmem:
@@ -1246,7 +1252,7 @@ usbnet_deferred_kevent(struct work_struct *work)
 		const struct driver_info *info = dev->driver_info;
 		int			retval = 0;
 
-		clear_bit (EVENT_LINK_RESET, &dev->flags);
+		clear_bit(EVENT_LINK_RESET, &dev->flags);
 		status = usb_autopm_get_interface(dev->intf);
 		if (status < 0)
 			goto skip_reset;
@@ -1266,10 +1272,10 @@ usbnet_deferred_kevent(struct work_struct *work)
 		__handle_link_change(dev);
 	}
 
-	if (test_bit (EVENT_LINK_CHANGE, &dev->flags))
+	if (test_bit(EVENT_LINK_CHANGE, &dev->flags))
 		__handle_link_change(dev);
 
-	if (test_bit (EVENT_SET_RX_MODE, &dev->flags))
+	if (test_bit(EVENT_SET_RX_MODE, &dev->flags))
 		__handle_set_rx_mode(dev);
 
 
@@ -1298,7 +1304,7 @@ static void tx_complete(struct urb *urb)
 
 		switch (urb->status) {
 		case -EPIPE:
-			usbnet_defer_kevent (dev, EVENT_TX_HALT);
+			usbnet_defer_kevent(dev, EVENT_TX_HALT);
 			break;
 
 		/* software-driven interface shutdown */
@@ -1313,13 +1319,13 @@ static void tx_complete(struct urb *urb)
 		case -ETIME:
 		case -EILSEQ:
 			usb_mark_last_busy(dev->udev);
-			if (!timer_pending (&dev->delay)) {
-				mod_timer (&dev->delay,
-					jiffies + THROTTLE_JIFFIES);
+			if (!timer_pending(&dev->delay)) {
+				mod_timer(&dev->delay,
+					  jiffies + THROTTLE_JIFFIES);
 				netif_dbg(dev, link, dev->net,
 					  "tx throttle %d\n", urb->status);
 			}
-			netif_stop_queue (dev->net);
+			netif_stop_queue(dev->net);
 			break;
 		default:
 			netif_dbg(dev, tx_err, dev->net,
@@ -1338,7 +1344,7 @@ void usbnet_tx_timeout(struct net_device *net, unsigned int txqueue)
 {
 	struct usbnet		*dev = netdev_priv(net);
 
-	unlink_urbs (dev, &dev->txq);
+	unlink_urbs(dev, &dev->txq);
 	queue_work(system_bh_wq, &dev->bh_work);
 	/* this needs to be handled individually because the generic layer
 	 * doesn't know what is sufficient and could not restore private
@@ -1400,7 +1406,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 	// some devices want funky USB-level framing, for
 	// win32 driver (usually) and/or hardware quirks
 	if (info->tx_fixup) {
-		skb = info->tx_fixup (dev, skb, GFP_ATOMIC);
+		skb = info->tx_fixup(dev, skb, GFP_ATOMIC);
 		if (!skb) {
 			/* packet collected; minidriver waiting for more */
 			if (info->flags & FLAG_MULTI_PACKET)
@@ -1410,7 +1416,8 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 		}
 	}
 
-	if (!(urb = usb_alloc_urb (0, GFP_ATOMIC))) {
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
 		netif_dbg(dev, tx_err, dev->net, "no urb\n");
 		goto drop;
 	}
@@ -1419,8 +1426,8 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 	entry->urb = urb;
 	entry->dev = dev;
 
-	usb_fill_bulk_urb (urb, dev->udev, dev->out,
-			skb->data, skb->len, tx_complete, skb);
+	usb_fill_bulk_urb(urb, dev->udev, dev->out,
+			  skb->data, skb->len, tx_complete, skb);
 	if (dev->can_dma_sg) {
 		if (build_dma_sg(skb, urb) < 0)
 			goto drop;
@@ -1490,8 +1497,8 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 
 	switch ((retval = usb_submit_urb (urb, GFP_ATOMIC))) {
 	case -EPIPE:
-		netif_stop_queue (net);
-		usbnet_defer_kevent (dev, EVENT_TX_HALT);
+		netif_stop_queue(net);
+		usbnet_defer_kevent(dev, EVENT_TX_HALT);
 		usb_autopm_put_interface_async(dev->intf);
 		break;
 	default:
@@ -1506,7 +1513,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 		if (dev->txq.qlen >= TX_QLEN (dev))
 			netif_stop_queue (net);
 	}
-	spin_unlock_irqrestore (&dev->txq.lock, flags);
+	spin_unlock_irqrestore(&dev->txq.lock, flags);
 
 	if (retval) {
 		netif_dbg(dev, tx_err, dev->net, "drop, code %d\n", retval);
@@ -1514,7 +1521,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, struct net_device *net)
 		dev->net->stats.tx_dropped++;
 not_drop:
 		if (skb)
-			dev_kfree_skb_any (skb);
+			dev_kfree_skb_any(skb);
 		if (urb) {
 			kfree(urb->sg);
 			usb_free_urb(urb);
@@ -1625,7 +1632,7 @@ static void usbnet_bh(struct timer_list *t)
 				queue_work(system_bh_wq, &dev->bh_work);
 		}
 		if (dev->txq.qlen < TX_QLEN (dev))
-			netif_wake_queue (dev->net);
+			netif_wake_queue(dev->net);
 	}
 }
 
@@ -1658,7 +1665,7 @@ void usbnet_disconnect(struct usb_interface *intf)
 		return;
 	usbnet_mark_going_away(dev);
 
-	xdev = interface_to_usbdev (intf);
+	xdev = interface_to_usbdev(intf);
 
 	netif_info(dev, probe, dev->net, "unregister '%s' usb-%s-%s, %s\n",
 		   intf->dev.driver->name,
@@ -1666,7 +1673,7 @@ void usbnet_disconnect(struct usb_interface *intf)
 		   dev->driver_info->description);
 
 	net = dev->net;
-	unregister_netdev (net);
+	unregister_netdev(net);
 
 	cancel_work_sync(&dev->kevent);
 
@@ -1737,7 +1744,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		dev_dbg (&udev->dev, "blacklisted by %s\n", name);
 		return -ENODEV;
 	}
-	xdev = interface_to_usbdev (udev);
+	xdev = interface_to_usbdev(udev);
 	interface = udev->cur_altsetting;
 
 	status = -ENOMEM;
@@ -1767,10 +1774,10 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	skb_queue_head_init(&dev->rxq_pause);
 	spin_lock_init(&dev->bql_spinlock);
 	INIT_WORK(&dev->bh_work, usbnet_bh_work);
-	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
+	INIT_WORK(&dev->kevent, usbnet_deferred_kevent);
 	init_usb_anchor(&dev->deferred);
 	timer_setup(&dev->delay, usbnet_bh, 0);
-	mutex_init (&dev->phy_mutex);
+	mutex_init(&dev->phy_mutex);
 	mutex_init(&dev->interrupt_mutex);
 	dev->interrupt_count = 0;
 
@@ -1792,7 +1799,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	// allow device-specific bind/init procedures
 	// NOTE net->name still not usable ...
 	if (info->bind) {
-		status = info->bind (dev, udev);
+		status = info->bind(dev, udev);
 		if (status < 0)
 			goto out1;
 
@@ -1817,18 +1824,18 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
 			net->mtu = dev->hard_mtu - net->hard_header_len;
 	} else if (!info->in || !info->out)
-		status = usbnet_get_endpoints (dev, udev);
+		status = usbnet_get_endpoints(dev, udev);
 	else {
 		u8 ep_addrs[3] = {
 			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
 		};
 
-		dev->in = usb_rcvbulkpipe (xdev, info->in);
-		dev->out = usb_sndbulkpipe (xdev, info->out);
+		dev->in = usb_rcvbulkpipe(xdev, info->in);
+		dev->out = usb_sndbulkpipe(xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
-			status = usb_set_interface (xdev,
-				interface->desc.bInterfaceNumber,
-				interface->desc.bAlternateSetting);
+			status = usb_set_interface(xdev,
+						   interface->desc.bInterfaceNumber,
+						   interface->desc.bAlternateSetting);
 		else
 			status = 0;
 
@@ -1836,7 +1843,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
-		status = init_status (dev, udev);
+		status = init_status(dev, udev);
 	if (status < 0)
 		goto out3;
 
@@ -1870,7 +1877,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		}
 	}
 
-	status = register_netdev (net);
+	status = register_netdev(net);
 	if (status)
 		goto out5;
 	netif_info(dev, probe, dev->net,
@@ -1881,9 +1888,9 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 		   net->dev_addr);
 
 	// ok, it's ready to go.
-	usb_set_intfdata (udev, dev);
+	usb_set_intfdata(udev, dev);
 
-	netif_device_attach (net);
+	netif_device_attach(net);
 
 	if (dev->driver_info->flags & FLAG_LINK_INTR)
 		usbnet_link_change(dev, 0, 0);
@@ -1896,7 +1903,7 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
 	usb_free_urb(dev->interrupt);
 out3:
 	if (info->unbind)
-		info->unbind (dev, udev);
+		info->unbind(dev, udev);
 out1:
 	/* subdrivers must undo all they did in bind() if they
 	 * fail it, but we may fail later and a deferred kevent
@@ -1938,7 +1945,7 @@ int usbnet_suspend(struct usb_interface *intf, pm_message_t message)
 		 * accelerate emptying of the rx and queues, to avoid
 		 * having everything error out.
 		 */
-		netif_device_detach (dev->net);
+		netif_device_detach(dev->net);
 		usbnet_terminate_urbs(dev);
 		__usbnet_status_stop_force(dev);
 
@@ -1946,7 +1953,7 @@ int usbnet_suspend(struct usb_interface *intf, pm_message_t message)
 		 * reattach so runtime management can use and
 		 * wake the device
 		 */
-		netif_device_attach (dev->net);
+		netif_device_attach(dev->net);
 	}
 	return 0;
 }
-- 
2.51.1


