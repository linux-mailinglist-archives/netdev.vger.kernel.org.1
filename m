Return-Path: <netdev+bounces-305727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y+YOLhsgTmrKDgIAu9opvQ
	(envelope-from <netdev+bounces-305727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A0723FB1
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=N7Je1sR9;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305727-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305727-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E922301F5E8
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451D3749FB;
	Wed,  8 Jul 2026 09:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582636A35A;
	Wed,  8 Jul 2026 09:58:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504737; cv=none; b=Ip68JvGDtruit1G8bdd0UfsDsV2S3J+qM4cHyzvHVho4R5z5xOUdL6xhM3/z14HGq9lEjmHpjqdT52jDRjtjptOWiUHOAfFRVRkndEJHLgpxrRLBXu1Ln+1V0n0DK+WHpsPAM9fpGk1m4m831hLDaNnT50s4yirOlKo7VEIrb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504737; c=relaxed/simple;
	bh=/2Ier6FRdzjPO3Emli1gXM2xVhA3IkF3e6eshK4zg2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/y4+NBYSZlcJCbGVcck7UPpEadYKwqpG9++i5J+hEJ5RF54eLIuxkKDCYohdCADY5fjAyAkJ2jg2DSxXPz0kO2kZjh78ODia0+XCv3S+1dr5ex+4569u57232gMAvTRaGl5xkYfppS15n60q6eK7mgYL+0VWcyL0+KnClQb9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N7Je1sR9; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504728;
	bh=bjKgiEdKsT7lRbJrX1xrLVJ5yD4EUl26YxZG1ln3Jpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N7Je1sR9pyDf5rKYd29RBhwUS4LFE+MarUzAKGjhRrga4jp6Lx544IuhlYgjOLKFx
	 wl2LvOLxFWgR73jxeO2izbX91mMfLvP8OtSsD4uQKtMQmZywUK9ZqSaiV0uOpTyccu
	 vjAkrK5DASDsuwBCBuGtuSiRRKqbsY3WekZg9YU11rUgBG3hNNFAlB7qcgWqE8JcXJ
	 s8WZXFpS26xIuADmOqKIl46xQXw+omujaWB5KjwCb78TJWDki2HrnK+7R9DiAr24eG
	 ThQz6deaQW/Gq0k1f9oHxCCbWbbfwzz6TmD7xKzjU+zw8cVD3lG+tf4BNLKTZ7uTwT
	 XmQ0v+c8LflRQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 35F8D6654B; Wed,  8 Jul 2026 17:58:48 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:32 +0800
Subject: [PATCH net-next v3 01/12] net: mctp: usb: Include version
 indicator in max packet size defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-1-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-305727-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 157A0723FB1

DSP0283 v1.1.0 will introduce larger maximum packet sizes. In
preparation, indicate that the current maxima are specific to v1.0.x.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c  | 8 ++++----
 include/linux/usb/mctp-usb.h | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index fade65f2f269..545eff06322c 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -76,7 +76,7 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 
 	plen = skb->len;
 
-	if (plen + sizeof(*hdr) > MCTP_USB_XFER_SIZE)
+	if (plen + sizeof(*hdr) > MCTP_USB_1_0_XFER_SIZE)
 		goto err_drop;
 
 	rc = skb_cow_head(skb, sizeof(*hdr));
@@ -128,7 +128,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	struct sk_buff *skb;
 	int rc;
 
-	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_XFER_SIZE, gfp);
+	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_1_0_XFER_SIZE, gfp);
 	if (!skb) {
 		rc = -ENOMEM;
 		goto err_retry;
@@ -136,7 +136,7 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 
 	usb_fill_bulk_urb(mctp_usb->rx_urb, mctp_usb->usbdev,
 			  usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in),
-			  skb->data, MCTP_USB_XFER_SIZE,
+			  skb->data, MCTP_USB_1_0_XFER_SIZE,
 			  mctp_usb_in_complete, skb);
 
 	rc = usb_submit_urb(mctp_usb->rx_urb, gfp);
@@ -301,7 +301,7 @@ static void mctp_usb_netdev_setup(struct net_device *dev)
 
 	dev->mtu = MCTP_USB_MTU_MIN;
 	dev->min_mtu = MCTP_USB_MTU_MIN;
-	dev->max_mtu = MCTP_USB_MTU_MAX;
+	dev->max_mtu = MCTP_USB_1_0_MTU_MAX;
 
 	dev->hard_header_len = sizeof(struct mctp_usb_hdr);
 	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index a2f6f1e04efb..47e2e3931d63 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -21,10 +21,11 @@ struct mctp_usb_hdr {
 	u8	len;
 } __packed;
 
-#define MCTP_USB_XFER_SIZE	512
+/* max transfer size for DSP0283 v1.0 */
+#define MCTP_USB_1_0_XFER_SIZE	512
 #define MCTP_USB_BTU		68
 #define MCTP_USB_MTU_MIN	MCTP_USB_BTU
-#define MCTP_USB_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_1_0_MTU_MAX	(U8_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3


