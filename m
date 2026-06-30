Return-Path: <netdev+bounces-302927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sks2LvA2Q2rJVAoAu9opvQ
	(envelope-from <netdev+bounces-302927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E66E00A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=Uw9eqRFt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302927-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0725C304C628
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6103D813E;
	Tue, 30 Jun 2026 03:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86336AB4D;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789759; cv=none; b=Z/CKZ7DOp5lSoJx1wfjBRllfWRx9pdirW6bgd45lKIRBOh6D8kIQRSA6Fd6fhOYG6G62R3eknYII/ddS0oaXcxSPkNtHxgIlTdtPUZ+6gB8yNAie74njCWJpi3pL0w2Qsks0axvmIM0lyIzZbBvk8ooN00YwEknWu63AKofdJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789759; c=relaxed/simple;
	bh=GrphSALXPY3hqGjYd/RXdbMGhyPOM0ZO6Nu4zHRn/UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ex4jbSz+RaOndPUVvVvZMW4M6v0zwqOj5Wp/vGV82u1uTMRo1eFRU24SF3V00s2Tm8s5ePdVLbF4hUfMM746A1hIFow+4muCuHygWF9MCPwLAOu4Mk6/ivLmhcM5k7BsFJt9dBFTSFSmPwlkbIdmIEXOTyK5ONgE2Kue/DZsm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Uw9eqRFt; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789747;
	bh=8Rh+COseJwVbf0Udu1Sv/zt4AsKsA23GjBE0/9zhItQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uw9eqRFt6Bj5T+IGqBHjgofizy1l8o3W4F2dAghFivUYPT417thFfJmSUeJmWnzQL
	 q73Mv/U4sTlxK2hOp4yGAfjfiftNo+WwSsOZvvodkLN41lVOBryYBXIeLdeMNQB4Z0
	 z0W07fjqkyNs9vtmtj7t/wRJFCXxsAO+q46JQ6EeqKs04Hbyo6jk4zyRLUz5P6U2iY
	 vpbDrDontnxtSqZ1h9OpA9tYFe/WOU0S+YZuCeaNRQC7MUQG+uIMZaYUFSd2/Wiz36
	 agcLvtP31dTonvuj4hlKhvjWzexWBWU+y02crQjvOz6nvC4kgF2VXX8Nj0TsrR6D/c
	 /fpXDPrNHGWEQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CD86A660F3; Tue, 30 Jun 2026 11:22:27 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:28 +0800
Subject: [PATCH net-next 07/12] net: mctp: usb: Accommodate DSP0283 v1.1
 header format
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-7-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-302927-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 112E66E00A4

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
 drivers/net/mctp/mctp-usblib.c | 12 +++++++-----
 include/linux/usb/mctp-usb.h   | 11 ++++++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index a8491ec04df3..acfae6d32390 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -89,6 +89,7 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 	while (skb) {
 		struct sk_buff *skb2 = NULL;
 		struct mctp_usb_hdr *hdr;
+		u16 hdr_len;
 		/* length of MCTP packet, no USB header */
 		u8 pkt_len;
 
@@ -106,7 +107,9 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 			break;
 		}
 
-		if (hdr->len <
+		hdr_len = be16_to_cpu(hdr->len) & MCTP_USB_1_0_PKTLEN_MAX;
+
+		if (hdr_len <
 		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
 			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
 				   hdr->len);
@@ -115,12 +118,12 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
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
 
@@ -360,8 +363,7 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb)
 		return -ENOMEM;
 
 	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
-	hdr->rsvd = 0;
-	hdr->len = plen + sizeof(*hdr);
+	hdr->len = cpu_to_be16(plen + sizeof(*hdr));
 
 	return 0;
 }
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 56a4aef1f7d0..47561f2471e5 100644
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


