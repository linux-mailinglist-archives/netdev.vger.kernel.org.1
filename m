Return-Path: <netdev+bounces-256070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKcwIuBRgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:39:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023EDD3706
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB97D300E25E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA35273D9A;
	Tue,  3 Feb 2026 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFMEtKdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE4261B91
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082780; cv=none; b=cQzaB5cUfq1jj/smeWfQYBjZNOLTxxqw0x3ySphND0wbl/pEV4Td0L3t4SUJP4qde+gVn+GAId19/OW00VdcFrwtZeQqHcOuXOtLZHgSX5MMqkE6u3xK7oSzBC8JR4J14o3ueYpp93BxQG9LNebn4+hW4bJxZfe923ZfLinESkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082780; c=relaxed/simple;
	bh=loUI7EgbYb5OeWue2BHmAqWdkjUZ+YRUPFnGs67fTs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDihA3TqpYtYPP/YvvMda6idZQ5gYslvlvOq6LJ5Iz9oJToz6N9GKs4pfWL+Quebuxyz0emUsE7lIrE3JzWpiPomF1sxmIw6YKLjOO4QQVk+14xAfm+Cy95mrvjg5b0o75ZakmbLU5n8FMNjxIaCNBwbv0iMKt5QYLCzAnZC7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFMEtKdB; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9052517eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082778; x=1770687578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRsmajcOBWi1yis4RiEAOPVLDZ+gafbhmHNH16HP8tI=;
        b=mFMEtKdBJfdKSF/0oLCCZffy8B52I6C1BcW7o9DKE/IV8vddZpd7GkDcUCQGUq0qO3
         tjPj8SmbW3hPG02dGVicDEHtoY3HZUBJ4oJ/CHQyFkUsBdz3UDeJRKB5PGnrKunY9Yk8
         pCrrZyoknt9Hq1gf5KdEIIAWdX1Dwt5iR5WgGRfHu3HGXALbQh3BO84Jgf9mfB2kaGBn
         iFbjUsW7kHDR89X0NtyNYYovOdzoRj1zB7EkBsloAEM+EaQneFncL2+llfXf+PiRByGL
         SpzGMYm4N7Jkn3LRXR/5L1AzOHcuVyN13TcNZJy52eSItR3Olcuzd8jOUq3uMUTQiP1D
         er6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082778; x=1770687578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRsmajcOBWi1yis4RiEAOPVLDZ+gafbhmHNH16HP8tI=;
        b=F6W05ET1xkodlxkK2As0DGmgW7/kXALL7pbIhoB30anBMkfdTvQsZ4tTPi/+vX72mb
         HJah3ubJDNINf5H/xeRuX2wPa6K1exZkNxmIRRM126f+3Z1jGYZdGMXZEG5aizbxtxoj
         QqGbNyJxZwNknbv+v5Dc9cd14U52OFhRQKJ8SNaWu2dEQwV6R5PLJiUk7flVWh/D7FDj
         yvOUDKJTpLjdrIqvZJE7LTykh1vshRdLaTXJSwWgU6WrVKRxN9RvIVGxReTXoFUk4Y4o
         mzekvcxP/y0h+Mp+6R3tKYC+YKQdDh2TRRaPsy44WAGr0Z6pOF1+6IpAsNJ4UFa3w0ib
         BZnA==
X-Forwarded-Encrypted: i=1; AJvYcCUFSEczlWO/QItZXhyWHf3x3QuyikiCxXRqgDeuqwjd9e/f5rh9+gHMQDndxb5d0uIWllCd8wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1yRdlM1RUKp/Bnc7WJcAaNGl7zNDrEnpxBSjUKbSgC2lrOe9
	O3Oh5uI0ImR7BrHFRju+UKlRM/HOdugUWFQIXaiG5RGn0ypn/Z0VWmqg
X-Gm-Gg: AZuq6aLTn4cIxRLfWojs03Ue5kAUBH421iGcg13T3bRvKgD9CCT4ekJBLO+lzr51FG9
	FUCk8LKXyuo2g7exOJbk7zv/dg1rInCDJaMwQs2gFgUX1jKs6PHvT5UUMl64tv69sEkDRW+SyQR
	0lG4m5ftUAl3ydQmMb3o28a1wAX8sTMQnlhHR6SCob4KLLBo0RKjiq6/Cvk0YFkCjPId3Zyj1SX
	vgfoEGi7GH8TMuKtxAb9V72ZcKCUrNy5IYSDXm5Std7Fql5+XVhbQf0nX68faK6Fvm8Km1GRIe2
	x5jvn1g/u9qriyy8izAsns9jM3AWXrcwJii2WSC4B/RBQFhWEIAE3+0R6UIkgAAtRw49zgyIkxX
	OHFT/tUx1x8ikSH92VzFXlxGq4P4CkIQmbxBbnUfd9qF5LeFP74bc1/cM1Ck7DJ8AC+7raeg1oU
	z43SxpDHCVunTw38OFAsq6etv9PJlnC+EHWY7O6hB2Hyot5g09r3BFbEBO/Ay0AV6RLG7ojSFOc
	9SsQGTcRA5ehwTeiEFjIff4EVu1BbRbO9RYth1jK0MQ8JVJFunBPThX3Jy1g2s+OTriJFUQIZpZ
	ecSF
X-Received: by 2002:a05:7301:2f95:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b7c88da4f1mr6045650eec.26.1770082778320;
        Mon, 02 Feb 2026 17:39:38 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abedcasm21162096eec.21.2026.02.02.17.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 17:39:38 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Eric Biggers <ebiggers@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH net-next v3] net: usb: sr9700: remove code to drive nonexistent multicast filter
Date: Mon,  2 Feb 2026 17:39:09 -0800
Message-ID: <20260203013924.28582-1-enelsonmoore@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pengutronix.de,armlinux.org.uk,korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-256070-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 023EDD3706
X-Rspamd-Action: no action

Several registers referenced in this driver's source code do not
actually exist (they are not writable and read as zero in my testing).
They exist in this driver because it originated as a copy of the dm9601
driver. Notably, these include the multicast filter registers - this
causes the driver to not support multicast packets correctly. Remove
the multicast filter code and register definitions. Instead, set the
chip to receive all multicast filter packets when any multicast
addresses are in the list.

Reviewed-by: Simon Horman <horms@kernel.org> (from v1)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2:
Remove unrelated cleanups; adjust commit message
Use netdev_mc_empty()
Changes in v3:
Rebase on latest net-next
Drop now-unused CRC32 Kconfig dependency

 drivers/net/usb/Kconfig  |  1 -
 drivers/net/usb/sr9700.c | 25 ++++---------------------
 drivers/net/usb/sr9700.h |  7 +------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index d050adfe860a..52a5c0922c79 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -319,7 +319,6 @@ config USB_NET_DM9601
 config USB_NET_SR9700
 	tristate "CoreChip-sz SR9700 based USB 1.1 10/100 ethernet devices"
 	depends on USB_USBNET
-	select CRC32
 	help
 	  This option adds support for CoreChip-sz SR9700 based USB 1.1
 	  10/100 Ethernet adapters.
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 49764bcf0912..937e6fef3ac6 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -17,7 +17,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/usb.h>
-#include <linux/crc32.h>
 #include <linux/usb/usbnet.h>
 
 #include "sr9700.h"
@@ -231,31 +230,15 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 static void sr9700_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	/* We use the 20 byte dev->data for our 8 byte filter buffer
-	 * to avoid allocating memory that is tricky to free later
-	 */
-	u8 *hashes = (u8 *)&dev->data;
 	/* rx_ctl setting : enable, disable_long, disable_crc */
 	u8 rx_ctl = RCR_RXEN | RCR_DIS_CRC | RCR_DIS_LONG;
 
-	memset(hashes, 0x00, SR_MCAST_SIZE);
-	/* broadcast address */
-	hashes[SR_MCAST_SIZE - 1] |= SR_MCAST_ADDR_FLAG;
-	if (netdev->flags & IFF_PROMISC) {
+	if (netdev->flags & IFF_PROMISC)
 		rx_ctl |= RCR_PRMSC;
-	} else if (netdev->flags & IFF_ALLMULTI ||
-		   netdev_mc_count(netdev) > SR_MCAST_MAX) {
-		rx_ctl |= RCR_RUNT;
-	} else if (!netdev_mc_empty(netdev)) {
-		struct netdev_hw_addr *ha;
-
-		netdev_for_each_mc_addr(ha, netdev) {
-			u32 crc = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			hashes[crc >> 3] |= 1 << (crc & 0x7);
-		}
-	}
+	else if (netdev->flags & IFF_ALLMULTI || !netdev_mc_empty(netdev))
+		/* The chip has no multicast filter */
+		rx_ctl |= RCR_ALL;
 
-	sr_write_async(dev, SR_MAR, SR_MCAST_SIZE, hashes);
 	sr_write_reg_async(dev, SR_RCR, rx_ctl);
 }
 
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index 5c04ea0306c7..d1663cb1e8cd 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -101,9 +101,7 @@
 #define		WCR_LINKEN		(1 << 5)
 /* Physical Address Reg */
 #define	SR_PAR			0x10	/* 0x10 ~ 0x15 6 bytes for PAR */
-/* Multicast Address Reg */
-#define	SR_MAR			0x16	/* 0x16 ~ 0x1D 8 bytes for MAR */
-/* 0x1e unused */
+/* 0x16 --> 0x1E unused */
 /* Phy Reset Reg */
 #define	SR_PRR			0x1F
 #define		PRR_PHY_RST		(1 << 0)
@@ -158,9 +156,6 @@
 /* parameters */
 #define	SR_EEPROM_TIMEOUT	1000
 #define	SR_EEPROM_LEN		256
-#define	SR_MCAST_SIZE		8
-#define	SR_MCAST_ADDR_FLAG	0x80
-#define	SR_MCAST_MAX		64
 #define	SR_TX_OVERHEAD		2	/* 2bytes header */
 #define	SR_RX_OVERHEAD		7	/* 3bytes header + 4crc tail */
 
-- 
2.43.0


