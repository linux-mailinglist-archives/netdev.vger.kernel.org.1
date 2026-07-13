Return-Path: <netdev+bounces-307207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6OUeL0P3VGp2iAAAu9opvQ
	(envelope-from <netdev+bounces-307207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EE74C701
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:33:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=f8ZmkEyC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307207-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307207-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B9BB301EB44
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333FF43B3EF;
	Mon, 13 Jul 2026 14:33:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9943746C;
	Mon, 13 Jul 2026 14:33:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953193; cv=none; b=AUT6GPAJ4OMEMuq4X1oQt4IEB0L4EncZO7zksP5ZolkB/P7sjkyInwMYjyRVQx9wx/PZ/0cXVBhKW7dhQu5AUpe9He6pT+bk6kv9uwAB9Ys0cehakSNfVp2bRAU5dG0FQ6zgXa25mmiyxK5HWZsu6H8MAZDepPjUvxv/1fljX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953193; c=relaxed/simple;
	bh=O3gTeDMzfiWNzLpen7XA+3xxApeiqLbTYXfhFJJlkcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNqkNEPwSW0q/xRb1RnrxaluoX/cCYp2Rec9T9TKWvUJPIvvSxYMTSqU16u/YRfil3h+0JFdr0fzmhszD2J7khQ0qezkG45RZ1tmNHyLmvHdxq/eNPOldg3+wOEaOKpSc9Eza0YeymFSxGIcuoyQvqsXcNrN4MLtwjnB3clo2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=f8ZmkEyC; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783953182;
	bh=3v5a6bXZwCBGLOTyOpJBVbQIBJws6d52jIUHNGTi9zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f8ZmkEyCfeUIHcMnCZimEWu5/nPPIwTdvl3XVNGcyxMBJJXZNDvL0nmDGzGB7uMAh
	 VJTt8UMDuHrJbksOYmsoeRDLFsjWfMu2UFynlwbBTic6d5CowrRM7L939Lo3WG+8eI
	 IZ9k1cqNa2xUb71rV9DRLZ/79Ep9meScEeXJ8G/R90NsuOo/pp7H7wZmMLgisRm6n2
	 OOTxUvDlbK3NblaH+j4I0XT2DrhFViTjcbJ2rh4JFbBgDWIv4uSBOEb6NQe6dbSdmw
	 W2aPyRBy+G2mOdeb6MWfvPQZccg2+hsyq8rGrbvrlyKP7nneQB+Eozy74sRClAHF7o
	 45w5v2WytIOMw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 45BB26561A; Mon, 13 Jul 2026 22:33:02 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Jul 2026 22:32:57 +0800
Subject: [PATCH net-next v4 04/12] net: mctp: usb: Improve IN endpoint
 status handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-dev-mctp-usb-1-1-v4-4-4ae8de764a01@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307207-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:from_mime,codeconstruct.com.au:mid,codeconstruct.com.au:email,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rx_retry_work.work:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5EE74C701

Currently, we give-up on all non-zero status values on our IN/rx urb,
and do not re-queue the urb. This will stall the driver, and prevent
any further receive.

Instead, attempt a re-queue on transient errors, with a max of ten
successive failures. Handle EPIPE specially, by scheduling a
usb_clear_halt() in non-atomic context.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v4:
 - move urb error common code to mctp_usb_in_urb_err, fixing a missing
   rx_cancel
 - allow retries of usb_clear_halt
v3:
 - improved IN urb status handling was introduced in v2, but now split
   to a separate change, via sashiko feedback
 - now with usb_clear_halt on EPIPE.
---
 drivers/net/mctp/mctp-usb.c | 91 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 9e5c64e76e4a..d556dd2d91de 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -32,6 +32,9 @@ struct mctp_usb {
 
 	struct urb *tx_urb;
 	struct urb *rx_urb;
+	int in_err_count;
+	int in_err_orig;
+	bool clear_halt;
 
 	/* enforces atomic access to rx_stopped and requeuing the retry work */
 	spinlock_t rx_lock;
@@ -158,27 +161,75 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 	return 0;
 }
 
+static const unsigned int rx_err_max = 10;
+
+/* Returns -1 if we have hit excessive errors, zero otherwise. */
+static int mctp_usb_in_urb_err(struct mctp_usb *mctp_usb, int status,
+			       bool stalled)
+{
+	mctp_usblib_rx_cancel(&mctp_usb->rx);
+
+	if (!mctp_usb->in_err_count++)
+		mctp_usb->in_err_orig = status;
+
+	if (mctp_usb->in_err_count >= rx_err_max) {
+		netdev_err(mctp_usb->netdev,
+			   "excessive errors from%s IN EP, first: %d\n",
+			   stalled ? " (stalled)" : "",
+			   mctp_usb->in_err_orig);
+		return -1;
+	}
+
+	return 0;
+}
+
 static void mctp_usb_in_complete(struct urb *urb)
 {
 	struct mctp_usb *mctp_usb = urb->context;
 	struct net_device *netdev = mctp_usb->netdev;
-	int status;
+	unsigned long flags;
+	int rc, status;
 
 	status = urb->status;
 
 	switch (status) {
-	default:
-		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
-		fallthrough;
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
-	case -EPROTO:
+		/* device shutdown, don't resubmit */
 		mctp_usblib_rx_cancel(&mctp_usb->rx);
 		return;
+
+	case -EPIPE:
+		/* endpoint stall: clear halt, which will cause a resubmit */
+		rc = mctp_usb_in_urb_err(mctp_usb, status, true);
+		if (rc)
+			return;
+
+		mctp_usb->clear_halt = true;
+		spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+		if (!mctp_usb->rx_stopped)
+			schedule_delayed_work(&mctp_usb->rx_retry_work,
+					      RX_RETRY_DELAY);
+		spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
+		return;
+
+	default:
+		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
+		fallthrough;
+	case -ETIME:
+	case -EPROTO:
+	case -EILSEQ:
+	case -EOVERFLOW:
+		/* possibly transient; record first failure, resubmit */
+		rc = mctp_usb_in_urb_err(mctp_usb, status, false);
+		if (rc)
+			return;
+		break;
+
 	case 0:
-		mctp_usblib_rx_complete(netdev, &mctp_usb->rx,
-					urb->actual_length);
+		mctp_usblib_rx_complete(netdev, &mctp_usb->rx, urb->actual_length);
+		mctp_usb->in_err_count = 0;
 		break;
 	}
 
@@ -189,6 +240,30 @@ static void mctp_usb_rx_retry_work(struct work_struct *work)
 {
 	struct mctp_usb *mctp_usb = container_of(work, struct mctp_usb,
 						 rx_retry_work.work);
+	unsigned long flags;
+	int rc;
+
+	/* We are only called when rx completions are suspended */
+	if (mctp_usb->clear_halt) {
+		int pipe = usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in);
+
+		rc = usb_clear_halt(mctp_usb->usbdev, pipe);
+		if (rc) {
+			netdev_err(mctp_usb->netdev,
+				   "can't clear IN EP halt: %d\n", rc);
+
+			if (++mctp_usb->in_err_count >= rx_err_max)
+				return;
+
+			spin_lock_irqsave(&mctp_usb->rx_lock, flags);
+			if (!mctp_usb->rx_stopped)
+				schedule_delayed_work(&mctp_usb->rx_retry_work,
+						      RX_RETRY_DELAY);
+			spin_unlock_irqrestore(&mctp_usb->rx_lock, flags);
+			return;
+		}
+		mctp_usb->clear_halt = false;
+	}
 
 	mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
 }
@@ -198,6 +273,8 @@ static int mctp_usb_open(struct net_device *dev)
 	struct mctp_usb *mctp_usb = netdev_priv(dev);
 
 	WRITE_ONCE(mctp_usb->rx_stopped, false);
+	mctp_usb->clear_halt = false;
+	mctp_usb->in_err_count = 0;
 
 	netif_start_queue(dev);
 

-- 
2.47.3


