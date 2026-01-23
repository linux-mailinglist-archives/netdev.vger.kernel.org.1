Return-Path: <netdev+bounces-252651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IKoJ9cdc2kzsgAAu9opvQ
	(envelope-from <netdev+bounces-252651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:05:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777B71657
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E673028005
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26233F8C6;
	Fri, 23 Jan 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+syrcdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57433BBB9
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151662; cv=none; b=FGUQjRx6/4IeKhPr+hWwo3unidPMOESQWWLxz3TH/GRdY35DQi9uoahTtlq22ComRNA1YgGUeBWpkI/AeOqyHnXclb0c0Vtsi7WvpuYi8YARGQcEImHb67H9tAnm0TczINcr+/75wOQ7+6cHS1R7Ji4tVtCN4inZpHu8fk6AB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151662; c=relaxed/simple;
	bh=pTvK1Ud2AQSq+kngrcLZfGqilvW+N3NLkcbJ+VzW5FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=En7zLAQB4y18XZS7Q6CsIMY1hNjsFiDv3AqyCl7MDZBpK2uvK90qi0FlIIdWMxlte16JCoc8ZwOtyPyJLdT5rz+ynzpm0C2mDtD70u8wyUf3TXQnbcgJmEAHCnyxEpua7ekPGkepefuBIEA2rww8rDU5N5u2Cubptq4Z4gtb/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+syrcdD; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1233b172f02so2805883c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769151655; x=1769756455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w71v06CmCz9lwXzUHMcZAQbNs0uiKvgExrKC9KJWhR0=;
        b=g+syrcdD+2VUkQNHHAGgSZM53srD2BGeabfGsDajhFpU37qka5wCwkTWqDqj3yR7v0
         5csJuIQJoDvm42p4ZTS7CJGXETOlGKiHO9MzdUzkRjGICpFWyHtlA75Z8XhP4Ktatj2X
         BSee0Y8X6VJjV+5S+37r4lHzEUsMVVxtRuT/uo/wyKBeiGRD8+Z8aGADlKOFSOOPwpWx
         bO9rg9WYXKdteKqABYC5khISChlAoGnjWJWVqvuRueu4W8JqwuLNC6PzkoiamOOm+2sr
         NqfpdEd7PCbQHKMlKyooMRO7I1bICa7Pdzy0rUspKmd4RtA2HdWvAw4vmouxRDjVE7Lu
         rKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769151655; x=1769756455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w71v06CmCz9lwXzUHMcZAQbNs0uiKvgExrKC9KJWhR0=;
        b=BxHmxJ7AYsDUu/8ckmBmKxjjdBMAfHgoIJYIaHtN2v8dv4AqXreCR62+3BQqzY3mQM
         6xCdbnrNeFAbyp7BYN65nl1GZ6+tuPiZrcrOmwEIOLSd9Ww+oSoeX/bJjdsXUObV/vnb
         IcnhkVkfJ8QDgmFBXxF0JLRY9V5iosgi+dYtrnpuj9GpNqBnO7Zv1yRg8zFLQYkONTqX
         GUtCM8alRNqxpItN+NOR+sQtCu+z2PIME/ez+UTM1uLZo+zkwDAsytNb2m31nyaN/EsO
         wePnopvxjt41/Gz+WwmNQTuUg0EqhMffpbctK0f/LZMpoPGV7xC2a6Fo5ToQ4YYL2697
         MmBQ==
X-Gm-Message-State: AOJu0YzKOEIF7HjCioy6fjnu/K7tUzLBIrJ9ZOokh0ECQmUeJ3Rka6GX
	Vzkht+TuD1+66AdkrgK6hb5hhusy4N2RVjXMRgA6E9KIw+WuatwKbvpTwjb1CS9d
X-Gm-Gg: AZuq6aKMvK5ncMmMjcnehLgAyasMhCRdyvRe0WoQNfrmqjMRCFhjcR86cKHoqlfskzd
	OnryRXDEbZi0sVxQnOilPcovO0nK9GQv/zpBKiR+vGrJiKLRekg7dMgHsJR24nAbUnFQkMGRO2x
	aRBfiHa4F7YX+TGS0RDW0/SziaeoDoAW80mORRp8JBJNis+FDUN1LZ59wme0A590tDdtLk5wYOC
	Y0n835ljik8o/Q3hS0smXkrdnQOKstDPhTOl1AIFMzusEOS/3uOGwk9gbeYtg13Qzi2Ms7Ly+BL
	TB0CePIMzdrdPRPzHFbgX6Pry/UgiW0duEK4DG8gma1Dtk3aE3sJQ6lKUsUJakHex/1gw/r3CZt
	vLkdCHk9HoY5Lfmid4Gckog/upr8r5Rq3odbkxZn3zNwVx6jGIW1jlRdXfcHix1o2lLMhtQwdCp
	Bcp+dvGdYYhdIWN9CIbFCeCFv1KYabkJPGiKvLG8yliraLMs4uPFhlirqwrha6UYhOSU+2NthMR
	4OmOgNlm8sIBba67t4T+D423gu9/yFYi/qjEZnwY74KIDdrnU+qcE/qw9a/kM6oazLvi9FY4pfW
	T4cM
X-Received: by 2002:a05:7022:78f:b0:119:e56b:98c1 with SMTP id a92af1059eb24-1247dc0a63bmr805456c88.40.1769151654530;
        Thu, 22 Jan 2026 23:00:54 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c541sm2730485c88.7.2026.01.22.23.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:00:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH net-next] net: usb: sr9700: remove code to drive nonexistent multicast filter
Date: Thu, 22 Jan 2026 22:58:32 -0800
Message-ID: <20260123065842.53669-1-enelsonmoore@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252651-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2777B71657
X-Rspamd-Action: no action

Several registers referenced in this driver's source code do not
actually exist (they are not writable and read as zero in my testing).
They exist in this driver because it originated as a copy of the dm9601
driver. Notably, these include the multicast filter registers - this
causes the driver to not support multicast packets correctly. Remove
the multicast filter code and instead set the chip to receive all
multicast filter packets when any multicast addresses are in the list.
Also take the opportunity to remove definitions for a few other
nonexistent registers, and a couple pointless comments.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 26 ++++----------------------
 drivers/net/usb/sr9700.h | 19 +++----------------
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 9c7cd0db1768..19c36b0d441c 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -17,7 +17,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/usb.h>
-#include <linux/crc32.h>
 #include <linux/usb/usbnet.h>
 
 #include "sr9700.h"
@@ -231,31 +230,14 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 static void sr9700_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	/* We use the 20 byte dev->data for our 8 byte filter buffer
-	 * to avoid allocating memory that is tricky to free later
-	 */
-	u8 *hashes = (u8 *)&dev->data;
-	/* rx_ctl setting : enable, disable_long, disable_crc */
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
+	else if (netdev->flags & IFF_ALLMULTI || netdev_mc_count(netdev) > 0)
+		/* The chip has no multicast filter */
+		rx_ctl |= RCR_ALL;
 
-	sr_write_async(dev, SR_MAR, SR_MCAST_SIZE, hashes);
 	sr_write_reg_async(dev, SR_RCR, rx_ctl);
 }
 
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index 3212859830dc..51c696108d80 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -8,8 +8,6 @@
 #ifndef _SR9700_H
 #define	_SR9700_H
 
-/* sr9700 spec. register table on Linux platform */
-
 /* Network Control Reg */
 #define	SR_NCR			0x00
 #define		NCR_RST			(1 << 0)
@@ -101,9 +99,7 @@
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
@@ -123,10 +119,7 @@
 #define	SR_RRPAL		0x26
 /* Rx sdram Read Pointer Address High */
 #define	SR_RRPAH		0x27
-/* Vendor ID register */
-#define	SR_VID			0x28	/* 0x28 ~ 0x29 2 bytes for VID */
-/* Product ID register */
-#define	SR_PID			0x2A	/* 0x2A ~ 0x2B 2 bytes for PID */
+/* 0x28 --> 0x2B unused */
 /* CHIP Revision register */
 #define	SR_CHIPR		0x2C
 /* 0x2D --> 0xEF unused */
@@ -143,10 +136,7 @@
 #define		TXC_USBS_EP1RDY		(1 << 5)
 #define		TXC_USBS_SUSFLAG	(1 << 6)
 #define		TXC_USBS_RXFAULT	(1 << 7)
-/* USB Control register */
-#define	SR_USBC			0xF4
-#define		USBC_EP3NAK		(1 << 4)
-#define		USBC_EP3ACK		(1 << 5)
+/* 0xF4 --> 0xFF unused */
 
 /* Register access commands and flags */
 #define	SR_RD_REGS		0x00
@@ -158,9 +148,6 @@
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


