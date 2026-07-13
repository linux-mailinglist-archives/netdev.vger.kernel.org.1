Return-Path: <netdev+bounces-307208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQKcI6v4VGrUiAAAu9opvQ
	(envelope-from <netdev+bounces-307208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:39:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF974C7F6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=BJ7APobG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307208-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307208-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 337ED306E142
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA043B48A;
	Mon, 13 Jul 2026 14:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E443B480;
	Mon, 13 Jul 2026 14:33:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953195; cv=none; b=ajXWiwbJt97xaZSSUzNqMIhkgt+O9yXcYGw2a30+OF/XPpcM602gLaF+ZDA3wj4f0whVRxB1s6/lJzggwAw6jgKuBGtlJbuV0mvu/KxBZWMy/Y0IXdojO1nyFG4xqAjmYEo3mRB6l+WB2W80FV+BYbsDYDgZ95l2gc5H5PSQ8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953195; c=relaxed/simple;
	bh=KKtcR/+m4QN5F8ll5/kMMHagRDQ7KeNz9Wo+ucTMTzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWa9dj56KyzHrWnXJIw/DD7EqO+eLzmV5Ed8uMToIVMaWeYcJ4H6vYQXRMfFwzVu+L9pCXRvjwvyF0z6fI/QntPEWRwvwwqbSSzdOMu1d7WXBsaZACteqSSUNrwnQAUxyhe6lRAcgrMVRTYAtk1rkWw13EkqXGXVQwcRfc+Tauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BJ7APobG; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783953183;
	bh=KhBfWwuMYMkpiuzjTYQnaD8wQ0aG+68CnnMiZzh6YwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BJ7APobGWUo8kvNI8ZhrkcxwaAtEqwcCiDuh8sZxQxQGZRQd/GbHBuOBRjbqv94D2
	 b/YTovxuY9tW0TkLVcmDkM4sT+TaLmtXf3QD/nt/ljFWCibNe7NncX+m6Hd6APdKzz
	 IBbEDB6Oc1IsmpUQXz0LtU0dsu553+5KK3d7lUhk+CfOlL4UyFcdBloxyT96qeU8gG
	 F00ZpHdMrcnTK0Y1nlf+tVc00eXXkB8tAU6XNlPK4X0mK8Zdi7ebfiEUc9l4XB0+St
	 N5QH4YVg8CgHBwJ7ZAF+gT0LEODqF609y86QSzPkX6Og+TjIt0yrLlS1Jk6eZjdjcQ
	 Na7XOuMFu0UlA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2E3616561C; Mon, 13 Jul 2026 22:33:03 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Jul 2026 22:33:00 +0800
Subject: [PATCH net-next v4 07/12] net: mctp: usb: Accommodate DSP0283 v1.1
 header format
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-dev-mctp-usb-1-1-v4-7-4ae8de764a01@codeconstruct.com.au>
References: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
In-Reply-To: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307208-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:from_mime,codeconstruct.com.au:mid,codeconstruct.com.au:email,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp,dmtf.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2AF974C7F6

In the v1.1 update to DSP0283, we have a larger header field, of 13 bits
rather than 8.

In order to accommodate this, in preparation for proper v1.1 support,
expand our struct mctp_usb_hdr's len field to a u16, and endian-convert
when necessary. Because we don't yet support spanning mode, we will
never receive or transmit with the top 5 bits set, so we always mask
out anyway.

This allows for a future change where we allow spanning mode with
>512-byte transfers.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - fix short packet (hdr) debug message: use endian-converted value
---
 drivers/net/mctp/mctp-usblib.c | 14 ++++++++------
 include/linux/usb/mctp-usb.h   | 11 ++++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 2e464254353e..d58178f47c06 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -99,6 +99,7 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 	while (skb) {
 		struct sk_buff *skb2 = NULL;
 		struct mctp_usb_hdr *hdr;
+		u16 hdr_len;
 		/* length of MCTP packet, no USB header */
 		u8 pkt_len;
 
@@ -116,21 +117,23 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 			break;
 		}
 
-		if (hdr->len <
+		hdr_len = be16_to_cpu(hdr->len) & MCTP_USB_1_0_PKTLEN_MAX;
+
+		if (hdr_len <
 		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
 			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
-				   hdr->len);
+				   hdr_len);
 			rc = -EPROTO;
 			break;
 		}
 
 		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
-		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
+		pkt_len = hdr_len - sizeof(struct mctp_usb_hdr);
 		if (pkt_len > skb->len) {
 			rc = -EPROTO;
 			netdev_dbg(netdev,
 				   "rx: short packet (xfer) %d, actual %d\n",
-				   hdr->len, skb->len);
+				   hdr_len, skb->len);
 			break;
 		}
 
@@ -399,8 +402,7 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
 	}
 
 	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
-	hdr->rsvd = 0;
-	hdr->len = plen + sizeof(*hdr);
+	hdr->len = cpu_to_be16(plen + sizeof(*hdr));
 
 	return 0;
 }
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 2e1cde6a6745..1a5e795b4ec1 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -2,7 +2,7 @@
 /*
  * mctp-usb.h - MCTP USB transport binding: common definitions,
  * based on DMTF0283 specification:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
  * These are protocol-level definitions, that may be shared between host
  * and gadget drivers.
@@ -17,10 +17,15 @@
 #include <linux/skbuff.h>
 #include <linux/types.h>
 
+/*
+ * MCTP-over-USB transport header. DSP0283 v1.0 has an 8-bit length field
+ * (preceded by 8 reserved bits), v1.1 has a 13-bit length field (preceded by
+ * 3 reserved bits). We use a be16 for our length to handle the larger v1.1
+ * representation, and mask as appropriate.
+ */
 struct mctp_usb_hdr {
 	__be16	id;
-	u8	rsvd;
-	u8	len;
+	__be16	len;
 } __packed;
 
 /* max transfer size for DSP0283 v1.0 */

-- 
2.47.3


