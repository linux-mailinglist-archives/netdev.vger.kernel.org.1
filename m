Return-Path: <netdev+bounces-253339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMX8C2IKd2lebAEAu9opvQ
	(envelope-from <netdev+bounces-253339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:32:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449F848B2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82AF6300460D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B5225A3B;
	Mon, 26 Jan 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpVdrEa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6909153BE9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769409119; cv=none; b=N8v4J7nF0Kf0Iq4xgQUPhcTsPpOVCW+A70pfCfn3b3OO02eD0GUf++83cygzWou52YG+Q/VRzt2X4bOam+iJpNg4c5mhUh3XJmlwVbNdWEygBlpQrlWYZFLwwKg8yZhTZVaH6iOxs7KGCXp6aLfagqbbjgs2ulfKjS1avSf+XoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769409119; c=relaxed/simple;
	bh=MwLSOA3uQCNtmf71JgeF5X8NEQ2zmM0uL2ZVH33yHVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kg0hOvhRGytJjstI+n3QRBnzKOCqC6k8R/V6vf/GxhRjpGA+F+DugWyZ7tA/VUuaJ9oLfe+OKip2dWZbAUYBYD7w0TniRl+IReg82+P0OQl1tzOkFXKIZb2C611JCO9cpRp7DB0wzlTfe/LSPMUUbBdOfjyOcRvCfro+3dRErkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpVdrEa+; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-947fe9e92c3so3340999241.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769409116; x=1770013916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQBy6DRxXy5h5AscbNfB5n+HhsWUMKIsOSrmArTqC34=;
        b=cpVdrEa+MGuAev36EQgApaqZYZRrR+CC62T4oBURyGpt3FM9q+lXDJtkfRNc3+5tHL
         qmq98VlIC71vYoT5QlIb7VAe9tuWFBi+sKz898Sh9HPaBEZg/uzevWVsaeHPwl1qTnsV
         tStU8W42wlN7T48XF24vc+GF/+TlDx58MG2fuBGIOcjT9ByhPlJyPq/XbyVSw/tUW1wv
         5/wGPJKK4BMiQKZ4fM+FdG6zBRQRFtkUbFbS+O008x5VcI+K410komw5DaiI7Kp2RI3M
         dCUkyEH6ulk5Ib1/B3XuT77B5rnLF1CIE1UVoDq2k+yi19o1d66JkA+ZxpC59FypHXP8
         ovQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769409116; x=1770013916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQBy6DRxXy5h5AscbNfB5n+HhsWUMKIsOSrmArTqC34=;
        b=XWMK3p9B1YBjBHhkiDwgdQ+ra20ZCM7FE8zS2bmIOung8dNWBak5cgIcy+K4T7Mqtb
         VTyHEbbAfQrN+q0ejHZKAMmz8zLb0d3iRIpBye0rDyJdw99AgZ0Pf9m/XYsCAORUMfvo
         AjQ+BYhu73PjpcSLyaPdu/ne5ci+bFAMUsHZuDcsNWZEpd479Eytii594ptl4d2W2P06
         9WxPnaHB3tl0o3w40SnTKYHc6qke/uk1STBCGebor/nmeu3Ll0ewwD8g/CqbPoCN8kdZ
         X0Zn2wDkht7HrbUsRZG9h9sjNaTbVwbJGlw7JlvsNc5dVIxEzy16BHRRwXQ/O9fQo2TF
         V6mg==
X-Gm-Message-State: AOJu0Yywvt0ijgcT91vt0Jze8iO0Mnmtsh78tOvrBqfplfEs2X2qPrfS
	Cgt83PGg5uj9mn8n3SSdw9RmprU4v+mS5XUCODjqfYdCj3tcsrdC8zvvfBLhrp0A
X-Gm-Gg: AZuq6aI7cpBh/WfV+63kKARvlY01u5Na8GqTxtshstJYirV2wwT2S/aoYbpA0uDrypk
	ywnug/Wb1pFXFKixYeo23lR9lElqMB2BLNYdto9UCqZJxwuwd5oKEV+bfhMlnoHS3LWsyhqGOsU
	SrWLuYxCHmiBVjO1NvvWqmRtVBSTPv86Qe7GcDxvdQFobX72szQkng9dzLeg8BydUGfFNmubufV
	JRhBLPpKhQ7W8XXTRZcD5fFOyuD8cQ0V0pMBBUh1XrFFvqbH2ZbRR+MggDaRK0GJJA0/Heg+65M
	WBHNWIF6sMmJtTicCO39HkWCH9txVWxzd8Q0ac+ZLALzYtSzJVeSCM85WG33DHSciKqmsjxKG/W
	yGq6GWF2tWF6C5lfe4nVoc5A5XW9rAGkjgFhDH2unzBl2k4g552QAkqlwyrrkl9nNBitP6P14DO
	w+lMxjG2uoUrml1dIX1NweCqKJv1sUWPAH9V3IAVEsTMkC6nN+bU0Pi44SqVt1jF7t4T4OdTzko
	BD9kdvb16GnS7VG3h0RPV7r3bdb4fFQd+GRiFSYTWDxUvVOsGxCVSMMrS8smEhJnf74GRvrcpdU
	fv6UN/tY
X-Received: by 2002:a05:7301:1691:b0:2ae:5e6b:dc41 with SMTP id 5a478bee46e88-2b7643426cemr1437848eec.14.1769402493623;
        Sun, 25 Jan 2026 20:41:33 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-22.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1c52sm11728841eec.16.2026.01.25.20.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 20:41:33 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH net-next] net: usb: int51x1: use usbnet_cdc_update_filter
Date: Sun, 25 Jan 2026 20:40:39 -0800
Message-ID: <20260126044049.40359-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253339-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tandel.be:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8449F848B2
X-Rspamd-Action: no action

The int51x1 driver uses the same requests as USB CDC to handle packet
filtering, but provides its own definitions and function to handle it.
The chip datasheet says the requests are CDC compliant. Replace this
unnecessary code with a reference to usbnet_cdc_update_filter.

Also fix the broken datasheet link and remove an empty comment.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/Kconfig   |  1 +
 drivers/net/usb/int51x1.c | 39 +++------------------------------------
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 856e648d804e..d050adfe860a 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -564,6 +564,7 @@ config USB_HSO
 config USB_NET_INT51X1
 	tristate "Intellon PLC based usb adapter"
 	depends on USB_USBNET
+	select USB_NET_CDCETHER
 	help
 	  Choose this option if you're using a 14Mb USB-based PLC
 	  (Powerline Communications) solution with an Intellon
diff --git a/drivers/net/usb/int51x1.c b/drivers/net/usb/int51x1.c
index 6fde41550de1..87bd6be1fcb6 100644
--- a/drivers/net/usb/int51x1.c
+++ b/drivers/net/usb/int51x1.c
@@ -4,14 +4,11 @@
  *
  * Intellon usb PLC (Powerline Communications) usb net driver
  *
- * http://www.tandel.be/downloads/INT51X1_Datasheet.pdf
+ * https://web.archive.org/web/20101025091240id_/http://www.tandel.be/downloads/INT51X1_Datasheet.pdf
  *
  * Based on the work of Jan 'RedBully' Seiffert
  */
 
-/*
- */
-
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/netdevice.h>
@@ -27,14 +24,6 @@
 
 #define INT51X1_HEADER_SIZE	2	/* 2 byte header */
 
-#define PACKET_TYPE_PROMISCUOUS		(1 << 0)
-#define PACKET_TYPE_ALL_MULTICAST	(1 << 1) /* no filter */
-#define PACKET_TYPE_DIRECTED		(1 << 2)
-#define PACKET_TYPE_BROADCAST		(1 << 3)
-#define PACKET_TYPE_MULTICAST		(1 << 4) /* filtered */
-
-#define SET_ETHERNET_PACKET_FILTER	0x43
-
 static int int51x1_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
 	int len;
@@ -104,29 +93,6 @@ static struct sk_buff *int51x1_tx_fixup(struct usbnet *dev,
 	return skb;
 }
 
-static void int51x1_set_multicast(struct net_device *netdev)
-{
-	struct usbnet *dev = netdev_priv(netdev);
-	u16 filter = PACKET_TYPE_DIRECTED | PACKET_TYPE_BROADCAST;
-
-	if (netdev->flags & IFF_PROMISC) {
-		/* do not expect to see traffic of other PLCs */
-		filter |= PACKET_TYPE_PROMISCUOUS;
-		netdev_info(dev->net, "promiscuous mode enabled\n");
-	} else if (!netdev_mc_empty(netdev) ||
-		  (netdev->flags & IFF_ALLMULTI)) {
-		filter |= PACKET_TYPE_ALL_MULTICAST;
-		netdev_dbg(dev->net, "receive all multicast enabled\n");
-	} else {
-		/* ~PROMISCUOUS, ~MULTICAST */
-		netdev_dbg(dev->net, "receive own packets only\n");
-	}
-
-	usbnet_write_cmd_async(dev, SET_ETHERNET_PACKET_FILTER,
-			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       filter, 0, NULL, 0);
-}
-
 static const struct net_device_ops int51x1_netdev_ops = {
 	.ndo_open		= usbnet_open,
 	.ndo_stop		= usbnet_stop,
@@ -136,7 +102,7 @@ static const struct net_device_ops int51x1_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= int51x1_set_multicast,
+	.ndo_set_rx_mode	= usbnet_set_rx_mode,
 };
 
 static int int51x1_bind(struct usbnet *dev, struct usb_interface *intf)
@@ -158,6 +124,7 @@ static const struct driver_info int51x1_info = {
 	.bind        = int51x1_bind,
 	.rx_fixup    = int51x1_rx_fixup,
 	.tx_fixup    = int51x1_tx_fixup,
+	.set_rx_mode = usbnet_cdc_update_filter,
 	.in          = 1,
 	.out         = 2,
 	.flags       = FLAG_ETHER,
-- 
2.43.0


