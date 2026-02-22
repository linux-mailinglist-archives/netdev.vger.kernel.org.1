Return-Path: <netdev+bounces-259856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JvoLe2Ommn+cQMAu9opvQ
	(envelope-from <netdev+bounces-259856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046D16E7F7
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7561D301BF61
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1A19D092;
	Sun, 22 Feb 2026 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="Gntw2/dY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334C35972
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771736799; cv=none; b=p7goMqhNV5HFIjKNKdFN3CYHwePLuLspIgvXxGhmZVndHsG9SqU8tpgZcVoYfOoTUK/kjKpQe43bX6/JgX+q+Z8mebU2jnSSsc+JDlxZQIq+nR5jaM02FAP1oY1YXxFROXVgIuIofOaqHUW6KPUROHEnWDSESIlIRlv7pBj9tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771736799; c=relaxed/simple;
	bh=t1HmHm/txpNwilCNIdjf84AFW98nrGgCLRcSa8+4pE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ImKUvu2tyEmiViCRleLxssaVfbEbHhHC2BHNcVteTEv31OYDCT5WavqggxAn17VbM8kw94IOO3dbdL22Bstn3GbzSobUrsbVuIig5P8qH8ehbuxPN7/vHQRVnHS5X0nlKDH19zrZDlGFwRvhuGQwNqViT9r1HMPDLrvFiTUKACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=Gntw2/dY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896f9397ecdso36039466d6.3
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 21:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1771736796; x=1772341596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bttcDNU2nAINHq9ZznGXMUM8VB0ktwFg7EYW3Smrsho=;
        b=Gntw2/dY9sUPWzTfLAec1UP7CdcXgc2J7z1oKpk3o2DIumwBBbmDdBJ2nbjxkqpLcA
         PhWqglu+Q545/AJ7ZloEVaWoyBRe1bMhxf7RUhUIPvtge3rnkjq6ZMSkKQ3ZrOHs0lku
         vbwnHyW9GORIfoeFZehPMFAmoH7vHNU1Cp2kGcuuERCVvXcISq5GJ9KXxi1NUQuhHQHO
         vBHIeg/eIZrmzRZhx4g610QWMjRtqgo4ryXOKbTBjefQvVmjcNXTg6BmM4eI0vCfsRDf
         9iC2IcJnwxxgjWC/gCI545ZJDXDqzekctFSZp83kUNHARZFJ1oLOYLTxzcf51X3PXe1T
         QCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771736796; x=1772341596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bttcDNU2nAINHq9ZznGXMUM8VB0ktwFg7EYW3Smrsho=;
        b=JJ6RF1vLRYijuu/uxn4ZFhZq2GemdTsvjBbVaC2KsuCN0KPBV3j3HOnhYCxAYVEQLr
         ukXMzKvzzcD76ksrpE/y6grI/zUnEQCOfSBtsMa6AAJadXxIb9NQXZpiDmMAIDZW2wPc
         qvlK9jG0E6bZINydL9bukYvUa7q6cfLMOscMH21Goe8yHlC1vG0iebAJV3GQBzMHX8K7
         12koPvcIH3djp/qM9Xc3Bnqdn614II+B11lBAeE6xuAzIsahla+p/00INE656hwKxwNM
         DI4DZ1hsnMqUgzeMs9K1TBf7HXe5mCZSoIW6iVmfou+VUQrdUE5hUhqfMiz/eB6MB9pr
         Jn+w==
X-Forwarded-Encrypted: i=1; AJvYcCUuxMOOYEdspKgdXcZ198UWg0hHvxXxrD5SIK5rT+V69NzE5xqcBOI3b0t+qpqQd5Mk9KnEo1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypidBhmhOBJNvFmhueO7yc7zLPou6jRZFzA3vo/WbLA2KCC9rt
	l0NhhCYaBdF1MjayOf52Eec+QL3VvGw62YWt8MvIOB1gcvFxSnziKuEY4vf/+CI9ZeE=
X-Gm-Gg: AZuq6aLwtEQTKlSvoyv49fac1Xvyoz2MuXJUPB/tGuAgtJmTz4NLzSHgFar7a9MtMhL
	z0RAmqGsicI2nadL4GFZDaOuamhEItnGdVEG9p2GnezBQ0jhkchE31YgtVqbYivDl7WZv5nJ2qs
	cEYZPsjQBbdrCv0q9pzYQVic+vYjZ7f/NFzp0ygEo7bbkeYUy2a5Z1s7BZnHfYBJyD7Bsu8FPSb
	7k+FUDmbXgxsaIdWVHAg15c+d70MYryd2NOn2gRwPs1TGcgXc0alAEW2Vqv3Y9BScjbQrskbg+z
	9IQHUF6BrGKz7+FUkxl5lJyy2W04PcT9Du6EypN91xbC2WxsQCS9mwY8dCTvsciCzu5RkOUTL67
	wAa8GdZGNuPL1Hz5K8VSZKZ1T8vBdm6AgPzrEkpypzYAhUytq+WBE0dTi5/c1GVlOSG0fRTBWa0
	8XEcfYK+HCpVxI8yeEAMZEnMiiYug7a1dpmxt3ZeFW5timjxBpjTKN1C6WLAHDF7Lt8Mz/05+Rb
	7KFzmPbgnzwH3Ds9Nqa5ZiNnDYoXhS3+bFidzh6qIM=
X-Received: by 2002:a05:6214:d65:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-89979d362b3mr78240586d6.41.1771736796388;
        Sat, 21 Feb 2026 21:06:36 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e7741c0sm33287246d6.50.2026.02.21.21.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 21:06:36 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH net] net: usb: pegasus: enable basic endpoint checking
Date: Sun, 22 Feb 2026 05:06:33 +0000
Message-Id: <20260222050633.410165-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,northwestern.edu:email,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2046D16E7F7
X-Rspamd-Action: no action

pegasus_probe() fills URBs with hardcoded endpoint pipes without
verifying the endpoint descriptors:

  - usb_rcvbulkpipe(dev, 1) for RX data
  - usb_sndbulkpipe(dev, 2) for TX data
  - usb_rcvintpipe(dev, 3)  for status interrupts

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes.

Add a pegasus_usb_ep enum for endpoint numbers, replacing magic
constants throughout. Add usb_check_bulk_endpoints() and
usb_check_int_endpoints() calls before any resource allocation to
verify endpoint types before use, rejecting devices with mismatched
descriptors at probe time, and avoid triggering assertion.

Similar fix to
- commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
- commit 9e7021d2aeae ("net: usb: catc: enable basic endpoint checking")

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/usb/pegasus.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 7b6d6eb60709..b84968c5f074 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -28,6 +28,17 @@ static const char driver_name[] = "pegasus";
 			BMSR_100FULL | BMSR_ANEGCAPABLE)
 #define CARRIER_CHECK_DELAY (2 * HZ)
 
+/*
+ * USB endpoints.
+ */
+
+enum pegasus_usb_ep {
+	PEGASUS_USB_EP_CONTROL	= 0,
+	PEGASUS_USB_EP_BULK_IN	= 1,
+	PEGASUS_USB_EP_BULK_OUT	= 2,
+	PEGASUS_USB_EP_INT_IN	= 3,
+};
+
 static bool loopback;
 static bool mii_mode;
 static char *devid;
@@ -542,7 +553,7 @@ static void read_bulk_callback(struct urb *urb)
 		goto tl_sched;
 goon:
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 	rx_status = usb_submit_urb(pegasus->rx_urb, GFP_ATOMIC);
@@ -582,7 +593,7 @@ static void rx_fixup(struct tasklet_struct *t)
 		return;
 	}
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 try_again:
@@ -710,7 +721,7 @@ static netdev_tx_t pegasus_start_xmit(struct sk_buff *skb,
 	((__le16 *) pegasus->tx_buff)[0] = cpu_to_le16(l16);
 	skb_copy_from_linear_data(skb, pegasus->tx_buff + 2, skb->len);
 	usb_fill_bulk_urb(pegasus->tx_urb, pegasus->usb,
-			  usb_sndbulkpipe(pegasus->usb, 2),
+			  usb_sndbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_OUT),
 			  pegasus->tx_buff, count,
 			  write_bulk_callback, pegasus);
 	if ((res = usb_submit_urb(pegasus->tx_urb, GFP_ATOMIC))) {
@@ -837,7 +848,7 @@ static int pegasus_open(struct net_device *net)
 	set_registers(pegasus, EthID, 6, net->dev_addr);
 
 	usb_fill_bulk_urb(pegasus->rx_urb, pegasus->usb,
-			  usb_rcvbulkpipe(pegasus->usb, 1),
+			  usb_rcvbulkpipe(pegasus->usb, PEGASUS_USB_EP_BULK_IN),
 			  pegasus->rx_skb->data, PEGASUS_MTU,
 			  read_bulk_callback, pegasus);
 	if ((res = usb_submit_urb(pegasus->rx_urb, GFP_KERNEL))) {
@@ -848,7 +859,7 @@ static int pegasus_open(struct net_device *net)
 	}
 
 	usb_fill_int_urb(pegasus->intr_urb, pegasus->usb,
-			 usb_rcvintpipe(pegasus->usb, 3),
+			 usb_rcvintpipe(pegasus->usb, PEGASUS_USB_EP_INT_IN),
 			 pegasus->intr_buff, sizeof(pegasus->intr_buff),
 			 intr_callback, pegasus, pegasus->intr_interval);
 	if ((res = usb_submit_urb(pegasus->intr_urb, GFP_KERNEL))) {
@@ -1133,10 +1144,24 @@ static int pegasus_probe(struct usb_interface *intf,
 	pegasus_t *pegasus;
 	int dev_index = id - pegasus_ids;
 	int res = -ENOMEM;
+	static const u8 bulk_ep_addr[] = {
+		PEGASUS_USB_EP_BULK_IN | USB_DIR_IN,
+		PEGASUS_USB_EP_BULK_OUT | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		PEGASUS_USB_EP_INT_IN | USB_DIR_IN,
+		0};
 
 	if (pegasus_blacklisted(dev))
 		return -ENODEV;
 
+	/* Verify that all required endpoints are present */
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(&intf->dev, "Missing or invalid endpoints\n");
+		return -ENODEV;
+	}
+
 	net = alloc_etherdev(sizeof(struct pegasus));
 	if (!net)
 		goto out;
-- 
2.34.1


