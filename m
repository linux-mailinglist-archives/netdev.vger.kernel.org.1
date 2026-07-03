Return-Path: <netdev+bounces-304344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LUp1GJxNR2o7VwAAu9opvQ
	(envelope-from <netdev+bounces-304344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75546FED66
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b="iM//2fm0";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304344-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304344-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AD14302A715
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6A369D7D;
	Fri,  3 Jul 2026 05:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18972369D63;
	Fri,  3 Jul 2026 05:48:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057689; cv=none; b=F7LkP91Y8dmiBQrf9ECp1Vx0Rpy6BmfSZ66A6P2VQgcK7MBNtGQlteu5q7oj+YzFNInJRTOO9L4mTUnnjWYINqMaroVPxAtVc5+5YYA9F2riOy416zlRkkXWYrieotCThtm4k/y8EoxsHKnGZv9BBpZ21ehEj1y2y6ntKWZrQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057689; c=relaxed/simple;
	bh=LQZc4rIna5P6w5GjBtRUSMmbad/eKzzcgHBBcPUi+a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZs1/QU4EHSle4Q2opJIbYNUQiRBMs+1tx4Z4hNpF7Cw1qMwk4K1DnXe0BWeG+qZ1ocaBG3R5YLwEPJ6pr3xV3eQ1kdMrtrkbUN19nPavwD+iGnEBNPYOjcZwHJDkP4vx/31jk7nyVPnBx+le7GA13LIt9DdcJ+0I0LzznVVfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iM//2fm0; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057670;
	bh=3vAgljkxOZKzaYntzYofEQoz0xcOMVn5Ns3RtQoLP38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iM//2fm0Hby4xanoisrXHGgfLJ8rdTLTJi2Vz04L8g6w87GFucs36e1/MH+kWjz71
	 6qyCPLjBIA1b0Msyxv7hI9enhw9jbe5oTTWxuYKYAu3yNEBKi6XV9TB7uNGNGva4EW
	 l4JdByfOBYI2KXJJ3lxfeb5v79IhrcWkqg1XqG2iL6d/WBTeUWxFk4D4Jc8W8KUrRF
	 JuTRb8H0vDNx/BsrT+GnYfzqXf5vfB+hB5vKdY/kSwkzFUzhBJjXI4xahR1YSEaGyJ
	 CeyA1Xu4+xZ5vTkpozBm9zmZzU0REYAopTkdvYf5rnZVK8N+OcUIirggFDdx8tPoXV
	 Sx/U57PV3G0KQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 5279B6628A; Fri,  3 Jul 2026 13:47:50 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:22 +0800
Subject: [PATCH net-next v2 02/12] net: mctp: usb: Use packet-length max
 for maximum packet-size check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-2-60367b861b33@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-304344-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B75546FED66

The max packet size is smaller than the max transfer size, as we only
have a u8 length field in the transport header.

Add a define for the maximum representable length, and use that for our
check. Use this for the MTU maximum calculation too.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c  | 2 +-
 include/linux/usb/mctp-usb.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 545eff06322c..c6e36b63e87a 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -76,7 +76,7 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 
 	plen = skb->len;
 
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_XFER_SIZE)
+	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
 		goto err_drop;
 
 	rc = skb_cow_head(skb, sizeof(*hdr));
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 47e2e3931d63..2bece8afd1c7 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -25,7 +25,8 @@ struct mctp_usb_hdr {
 #define MCTP_USB_1_0_XFER_SIZE	512
 #define MCTP_USB_BTU		68
 #define MCTP_USB_MTU_MIN	MCTP_USB_BTU
-#define MCTP_USB_1_0_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_1_0_PKTLEN_MAX	U8_MAX
+#define MCTP_USB_1_0_MTU_MAX	(MCTP_USB_1_0_PKTLEN_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3


