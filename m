Return-Path: <netdev+bounces-304207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IbcqMzZ3Rmo2WQsAu9opvQ
	(envelope-from <netdev+bounces-304207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB436F8E92
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:35:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304207-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304207-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBEF73027635
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F84E3787;
	Thu,  2 Jul 2026 14:32:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275D4E3764
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002726; cv=none; b=JMcseSck2D4A+bztfekRa4I8W1u+u2Knczx0fBTtCB3dREqfkLPyz2AXz2FzH2bcmEEqdH0Hydbs7/t2qlPYzb/CAJXNtitlWvevt6/we+k9y9DbqELit6xY4M4C7QTiQU/bs3Klv8TYDM6l8oBi2A+ATIxI5A57bUKDmvfKsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002726; c=relaxed/simple;
	bh=kt4CRjaHG8MvWda6H7tcM3jaTCZNsbFAg5JAcIRtvQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7MArkIIcq1qlZvi61/v8qJgQ0Tzij/mCYCrlPx77WTGYLJxw06Loln1/MYuudI3pvOQo0l5Rvtv2wTWbWHoIljbxmxK5NIc3NBPbZlZjqh5OknYN+Wf4psyt4zWg1iKJKJunynKR4slev+1fn1JHK8lVZOCGoG2YbHZ8IQSZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F3275DF6;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B979779AC;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AGfOAVR2Rmr0MwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 02 Jul 2026 14:31:48 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shaoxul@foxmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net-next 1/4] net: usb: move updating filter and status from cdc to usbnet
Date: Thu,  2 Jul 2026 16:25:30 +0200
Message-ID: <20260702143142.890654-2-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143142.890654-1-oneukum@suse.com>
References: <20260702143142.890654-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304207-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBB436F8E92

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
index a0a5740590b9..b4df32e18461 100644
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
@@ -400,52 +371,6 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
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
index 25518635b7b7..5544af1f4aa5 100644
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
@@ -2271,6 +2272,81 @@ int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 
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
+		speed_change(dev, (__le32 *)urb->transfer_buffer);
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
+			speed_change(dev, (__le32 *)&event[1]);
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
2.54.0


