Return-Path: <netdev+bounces-263245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBcXA8r1pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:52:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1E1F1CFD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 330EB301BA61
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EDF47DD5D;
	Tue,  3 Mar 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HX+T88S2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wy5AETaR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63647CC8A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549575; cv=none; b=XcKp/+J/NoMlkFjfH2y5bJNKeUP33YicH65vxRWzVex3Z0y7ifPiowmxCY9d4qan9a/z0trUMw6C0H5WVgTdUM0evjefhpzyt+JZnroe3YMLuLI4JUHVwx9D0RXqVTfbK5NFgq6FK4csLMAjlTdTrI2voI3bIRV9t/V+xWqMX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549575; c=relaxed/simple;
	bh=m5AsEYtM0uOUCjvSxifGCa4J9z8z0dPbSZiTV37mYiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVdj/3HAkxh2IrGecig+LGBwchBUH0VnGBwnR2aDCal/JkX7ssaYAj9K375Q2EhUqed1YQvB0Vhh4lo3zu6ibv4e1kNGkqRCB2d5Km8wAit/pCamTJBCTLZ3JkuRObOLtY9xieLfIZx/Y1cz+wv/8HNQn1sIJRb8fKKNvVOXu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HX+T88S2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wy5AETaR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9A4E3F914;
	Tue,  3 Mar 2026 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTDAZ1H0R87IqHun36PhrX1jqBe8dIY89WTJWS5owBw=;
	b=HX+T88S2imbA8WNDkHacehjeYMzc8wVc8FY3hQps5T0duC6KDgoptMJcZI5GAaeDClJucf
	/8/Per8CY4k1nncd3tYYJFLvwkw+qUk5RxoDbxxOnqwv+tKWK62H8c6F5MehZ032eO95Oa
	pJUYWm2OmmjOCNpBWxF1Vr+SdidrPbQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTDAZ1H0R87IqHun36PhrX1jqBe8dIY89WTJWS5owBw=;
	b=Wy5AETaRXpPZWbtoWIB2IX2V9vrWlnBrVOIIQNzWGKNUTzlGaarze1Oo9vm73qwnVPcQiJ
	/8qWp7L1QIUwIE6HPyHVOmc4e7qPCWEZ0iQDQW627H759tDn+lSZ74nhbEAUb3ACSF0Egr
	2E79O3s1AVVTdYEniOfFuOjBQGMHSLI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BECA73EA6C;
	Tue,  3 Mar 2026 14:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GB94LcL1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:50 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 02/13] net: usb: move updating filter and status from cdc to usbnet
Date: Tue,  3 Mar 2026 15:50:22 +0100
Message-ID: <20260303145242.1377514-2-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303145242.1377514-1-oneukum@suse.com>
References: <20260303145242.1377514-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 79E1E1F1CFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263245-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

These helpers are used by multiple drivers and do not depend
on the rest of cdc. Leavin them in a cdc driver means that
more drivers are loaded just for infrastructure, not hardware
support.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c | 75 ------------------------------------
 drivers/net/usb/usbnet.c    | 76 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a032c1ded406..3149fa2b6ac1 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -63,35 +63,6 @@ static const u8 mbm_guid[16] = {
 	0xa6, 0x07, 0xc0, 0xff, 0xcb, 0x7e, 0x39, 0x2a,
 };
 
-void usbnet_cdc_update_filter(struct usbnet *dev)
-{
-	struct net_device	*net = dev->net;
-
-	u16 cdc_filter = USB_CDC_PACKET_TYPE_DIRECTED
-			| USB_CDC_PACKET_TYPE_BROADCAST;
-
-	/* filtering on the device is an optional feature and not worth
-	 * the hassle so we just roughly care about snooping and if any
-	 * multicast is requested, we take every multicast
-	 */
-	if (net->flags & IFF_PROMISC)
-		cdc_filter |= USB_CDC_PACKET_TYPE_PROMISCUOUS;
-	if (!netdev_mc_empty(net) || (net->flags & IFF_ALLMULTI))
-		cdc_filter |= USB_CDC_PACKET_TYPE_ALL_MULTICAST;
-
-	usb_control_msg(dev->udev,
-			usb_sndctrlpipe(dev->udev, 0),
-			USB_CDC_SET_ETHERNET_PACKET_FILTER,
-			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			cdc_filter,
-			dev->intf->cur_altsetting->desc.bInterfaceNumber,
-			NULL,
-			0,
-			USB_CTRL_SET_TIMEOUT
-		);
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_update_filter);
-
 /* We need to override usbnet_*_link_ksettings in bind() */
 static const struct ethtool_ops cdc_ether_ethtool_ops = {
 	.get_link		= usbnet_get_link,
@@ -394,52 +365,6 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
  * (by Brad Hards) talked with, with more functionality.
  */
 
-static void speed_change(struct usbnet *dev, __le32 *speeds)
-{
-	dev->tx_speed = __le32_to_cpu(speeds[0]);
-	dev->rx_speed = __le32_to_cpu(speeds[1]);
-}
-
-void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
-{
-	struct usb_cdc_notification	*event;
-
-	if (urb->actual_length < sizeof(*event))
-		return;
-
-	/* SPEED_CHANGE can get split into two 8-byte packets */
-	if (test_and_clear_bit(EVENT_STS_SPLIT, &dev->flags)) {
-		speed_change(dev, (__le32 *) urb->transfer_buffer);
-		return;
-	}
-
-	event = urb->transfer_buffer;
-	switch (event->bNotificationType) {
-	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
-		netif_dbg(dev, timer, dev->net, "CDC: carrier %s\n",
-			  event->wValue ? "on" : "off");
-		if (netif_carrier_ok(dev->net) != !!event->wValue)
-			usbnet_link_change(dev, !!event->wValue, 0);
-		break;
-	case USB_CDC_NOTIFY_SPEED_CHANGE:	/* tx/rx rates */
-		netif_dbg(dev, timer, dev->net, "CDC: speed change (len %d)\n",
-			  urb->actual_length);
-		if (urb->actual_length != (sizeof(*event) + 8))
-			set_bit(EVENT_STS_SPLIT, &dev->flags);
-		else
-			speed_change(dev, (__le32 *) &event[1]);
-		break;
-	/* USB_CDC_NOTIFY_RESPONSE_AVAILABLE can happen too (e.g. RNDIS),
-	 * but there are no standard formats for the response data.
-	 */
-	default:
-		netdev_err(dev->net, "CDC: unexpected notification %02x!\n",
-			   event->bNotificationType);
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_status);
-
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index d1edb710a5ed..906584cd71a4 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/usb/cdc.h>
 #include <linux/ctype.h>
 #include <linux/ethtool.h>
 #include <linux/workqueue.h>
@@ -2270,6 +2271,81 @@ int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 
 }
 EXPORT_SYMBOL_GPL(usbnet_write_cmd_async);
+
+void usbnet_cdc_update_filter(struct usbnet *dev)
+{
+	struct net_device	*net = dev->net;
+
+	u16 cdc_filter = USB_CDC_PACKET_TYPE_DIRECTED
+			| USB_CDC_PACKET_TYPE_BROADCAST;
+
+	/* filtering on the device is an optional feature and not worth
+	 * the hassle so we just roughly care about snooping and if any
+	 * multicast is requested, we take every multicast
+	 */
+	if (net->flags & IFF_PROMISC)
+		cdc_filter |= USB_CDC_PACKET_TYPE_PROMISCUOUS;
+	if (!netdev_mc_empty(net) || (net->flags & IFF_ALLMULTI))
+		cdc_filter |= USB_CDC_PACKET_TYPE_ALL_MULTICAST;
+
+	usb_control_msg(dev->udev,
+			usb_sndctrlpipe(dev->udev, 0),
+			USB_CDC_SET_ETHERNET_PACKET_FILTER,
+			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			cdc_filter,
+			dev->intf->cur_altsetting->desc.bInterfaceNumber,
+			NULL,
+			0,
+			USB_CTRL_SET_TIMEOUT
+		);
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_update_filter);
+
+static void speed_change(struct usbnet *dev, __le32 *speeds)
+{
+	dev->tx_speed = __le32_to_cpu(speeds[0]);
+	dev->rx_speed = __le32_to_cpu(speeds[1]);
+}
+
+void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
+{
+	struct usb_cdc_notification	*event;
+
+	if (urb->actual_length < sizeof(*event))
+		return;
+
+	/* SPEED_CHANGE can get split into two 8-byte packets */
+	if (test_and_clear_bit(EVENT_STS_SPLIT, &dev->flags)) {
+		speed_change(dev, (__le32 *) urb->transfer_buffer);
+		return;
+	}
+
+	event = urb->transfer_buffer;
+	switch (event->bNotificationType) {
+	case USB_CDC_NOTIFY_NETWORK_CONNECTION:
+		netif_dbg(dev, timer, dev->net, "CDC: carrier %s\n",
+			  event->wValue ? "on" : "off");
+		if (netif_carrier_ok(dev->net) != !!event->wValue)
+			usbnet_link_change(dev, !!event->wValue, 0);
+		break;
+	case USB_CDC_NOTIFY_SPEED_CHANGE:	/* tx/rx rates */
+		netif_dbg(dev, timer, dev->net, "CDC: speed change (len %d)\n",
+			  urb->actual_length);
+		if (urb->actual_length != (sizeof(*event) + 8))
+			set_bit(EVENT_STS_SPLIT, &dev->flags);
+		else
+			speed_change(dev, (__le32 *) &event[1]);
+		break;
+	/* USB_CDC_NOTIFY_RESPONSE_AVAILABLE can happen too (e.g. RNDIS),
+	 * but there are no standard formats for the response data.
+	 */
+	default:
+		netdev_err(dev->net, "CDC: unexpected notification %02x!\n",
+			   event->bNotificationType);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_status);
 /*-------------------------------------------------------------------------*/
 
 static int __init usbnet_init(void)
-- 
2.53.0


