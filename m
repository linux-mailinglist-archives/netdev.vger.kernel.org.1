Return-Path: <netdev+bounces-304350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AmZtLjpOR2ppVwAAu9opvQ
	(envelope-from <netdev+bounces-304350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF46FEDA9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:52:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b="RHK4I/pE";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304350-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD205308C885
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EB37A849;
	Fri,  3 Jul 2026 05:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A535F192;
	Fri,  3 Jul 2026 05:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057704; cv=none; b=Fh9A1cZ87sxuombTR4D81tYxlb7SWPKZAOEX0Hpv0OXlFa+1Wg4aBklH7PdOt9HnzKBXli1T+eKy2es9wWfwRTNtktXVK3k/f/mV6LNAP3RL/6ervey+jGyBBWMyY6Ohwfsfy6MyZMmqKYLcknBg9S0y9pqCl8XbYMq/t+xZzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057704; c=relaxed/simple;
	bh=EgB+vBpXw4eXQcU1VwIA+lTtRwEQuf/vVem5ALUYzUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqaIsNJCdyKe3g1v/BR4/9TTo0x7/U1/nZJJKyBYWbggJK5pEwNcStmfe+o0bp5pQUSK0GhuRpspp9mCgAIASbm0DOU2rcW3rkXTNQS9cfHvzkqslOZXnt39P2WLun9be9q7P4RS2lcymQ2PRAZxtSWnLw+uU1z7p5X1/7OGYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RHK4I/pE; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057671;
	bh=SMRFXUUSftRXXsDSm0VxSKfsxk1JKeuUIqQA2u7GE6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RHK4I/pEk2/X3+Oi2898oRjmrt5he5IKLDcly45657mdZ6RoUsOROzv9C4ss5JYMw
	 7+irAcCbKxYfmDSdjVA75fCCoB3Bwez7Wf0qYRtFACqZGWC+3VQGCNQSh7jqk1tJwN
	 tiMcuUIeFnBIXhsY/FGfpM3fXP3mwfvL8R1M7/MyuLPF1z8BDnXyNJNh/ba7SD3WO0
	 996r/yli1VgH/6lRQxlOJnIDPoonfYFNnmeDyneRjB1hOQuAwJeixoYDgAQC6mM5ts
	 dukCA2ssgfvKLn/p5fY1oDQMVsrrJGT7ZtkQ9Z1HzHD7L5mPlCwXykWwPY0mVq2VEm
	 2+VSfGhob0+fw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id D515166291; Fri,  3 Jul 2026 13:47:51 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:27 +0800
Subject: [PATCH net-next v2 07/12] net: mctp: usb: Accommodate DSP0283 v1.1
 header format
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-7-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304350-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32BF46FEDA9

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
index f2221dbc1019..13dbeb84a0b7 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -88,6 +88,7 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 	while (skb) {
 		struct sk_buff *skb2 = NULL;
 		struct mctp_usb_hdr *hdr;
+		u16 hdr_len;
 		/* length of MCTP packet, no USB header */
 		u8 pkt_len;
 
@@ -105,21 +106,23 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
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
 
@@ -386,8 +389,7 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
 	}
 
 	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
-	hdr->rsvd = 0;
-	hdr->len = plen + sizeof(*hdr);
+	hdr->len = cpu_to_be16(plen + sizeof(*hdr));
 
 	return 0;
 }
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 9d9b1f5eee5c..00e94ddfadcb 100644
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


