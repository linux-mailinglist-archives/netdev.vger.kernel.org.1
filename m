Return-Path: <netdev+bounces-304090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eB5OGUs+RmqeMgsAu9opvQ
	(envelope-from <netdev+bounces-304090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79EC6F5F35
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gLpyqVrL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304090-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB2D31758B8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EED48C8C5;
	Thu,  2 Jul 2026 10:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46A48BD54
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987022; cv=none; b=WLdCj1sz4J91/EnSM0QBQRB7wNwVElatNYMt0ux1mKaJCT7+PMyRh7krg68n7hdQOM8zeyNfYoylBhfCRmReMtZBWuqN3F25gQ5Fsv9jW4QChYVWRiN33tyysD4HcGI9Dkv/fCl51WHRt7piye+c/0Ott+DQ8K4RRx4Jb2yXwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987022; c=relaxed/simple;
	bh=4ARz9J1ErlXN+bkGXp0pgYYmw5ESF9s5MBLvFG6tThA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mP8v8pb8PPEYwGCtXyDFS3GvOSVkP3WcspVBIB1kFpdTgeI3IOCN09QFo6pI03E70W6B5EQDb8ch8wWrpRoWwKYaG8lPOFvSyOnzGqBa3sb7PZLRtH1j9SHTanVbVn3RZccncE4TGUlaLtrlbQ2y8AfG9y4D5rucAFgJe2s2/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLpyqVrL; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782987020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMvgCUl8MmT+Be2KtCj3vbRNFg4dyIJwmSs053/8hsc=;
	b=gLpyqVrLErGjqiPT/lCv91YLdvahLS0ow7eJ2l5otCEcJzcN6goZMQ7ogfIt/Vwpb83fET
	FrQkQA6CsbGbezff4Kl0RJS9JsD6KoU3eKIzF4Fmg1G4/FCQ+4CnzmWOY5vC0MQ5qveLLD
	aa2r4u3MxyGBuPjsq5JdBPiaP1iYU6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-XzUxGpLKMiu5B3tFpDH54g-1; Thu,
 02 Jul 2026 06:10:15 -0400
X-MC-Unique: XzUxGpLKMiu5B3tFpDH54g-1
X-Mimecast-MFC-AGG-ID: XzUxGpLKMiu5B3tFpDH54g_1782987013
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650AB1944CD1;
	Thu,  2 Jul 2026 10:10:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 371BF196665E;
	Thu,  2 Jul 2026 10:10:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jk@codeconstruct.com.au
Cc: matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] net: mctp: usb: Allow multiple urbs in flight
Date: Thu,  2 Jul 2026 12:09:38 +0200
Message-ID: <20260702100938.138310-1-pabeni@redhat.com>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-12-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-12-86a311fc67b7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304090-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B79EC6F5F35

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: mctp: usb: Allow multiple urbs in flight

Currently, we stop tx queues when we have one urb submitted. This means
we will immediately hit dev_hard_start_xmit's tx-queues-off ->
NETDEV_TX_BUSY case, and revert to the requeue -> gso_skb single-dequeue
path, and no longer be able to pack skbs without an xmit_more
indication.

Instead, allow a few urbs to be in-flight, with a limit of 16kB of data
outstanding (after which we will disable queues). With this, the tx path
will cause fewer requeues (and therefore non-packed transfers) under
normal loads.

> diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> index 5739c87da1095..28aeb5b258723 100644
> --- a/drivers/net/mctp/mctp-usb.c
> +++ b/drivers/net/mctp/mctp-usb.c
[ ... ]
> @@ -48,22 +51,38 @@ enum {
>  	MCTP_USB_SUBCLASS_SPAN = 0x02,
>  };
>  
> +/* We use a total-size limit for outstanding URBs, as the transfer counts
> + * may vary a lot between spanning- and non-spanning modes. In spanning mode,
> + * this will allow for a couple of max-sized transfers to be in flight. In
> + * non-spanning mode, 32.
> + *
> + * We want to avoid disabling the tx queue if possible; doing so will end up
> + * requeueing to gso_skb, and we only dequeue from that one skb at a time,
> + * so can no longer perform transfer packing.
> + */
> +static const unsigned int TX_QMEM_MAX = 16384;
> +
>  static void mctp_usb_out_complete(struct urb *urb)
>  {
>  	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
>  	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
>  	struct net_device *netdev = mctp_usb->netdev;
>  	unsigned long flags;
> +	bool wake = false;
>  
>  	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
>  
>  	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
> +	mctp_usb->tx_qmem -= urb->transfer_buffer_length;

[Severity: High]
Does this code underflow tx_qmem if called concurrently with or after
mctp_usb_stop() zeroes it?

If a user downs the interface while TX URBs are in flight, the USB core
(__usb_hcd_giveback_urb) unanchors the URB before invoking this completion
handler.

Because the URB is unanchored, usb_kill_anchored_urbs() in mctp_usb_stop()
can see an empty anchor list and return immediately, without waiting for
the completion handler.

> +	if (mctp_usb->tx_qmem < TX_QMEM_MAX)
> +		wake = true;
>  	usb_unanchor_urb(urb);
>  	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
>  
>  	usb_free_urb(urb);
>  
> -	netif_wake_queue(netdev);
> +	if (wake)
> +		netif_wake_queue(netdev);
>  }
[ ... ]
> @@ -221,12 +241,15 @@ static int mctp_usb_stop(struct net_device *dev)
>  	flush_delayed_work(&mctp_usb->rx_retry_work);
>  
>  	usb_kill_urb(mctp_usb->rx_urb);
> -	/* we have stopped queues, the anchor's own lock will serialise
> -	 * access from the urb completion.
> +
> +	/* We have stopped queues, the anchor's own lock will serialise
> +	 * access from the urb completion. We are then guaranteed that no
> +	 * further completions can occur, so can clear tx_qmem without locking.
>  	 */
>  	usb_kill_anchored_urbs(&mctp_usb->tx_anchor);
>  
>  	mctp_usblib_tx_cancel(&mctp_usb->tx, dev);
> +	mctp_usb->tx_qmem = 0;

[Severity: High]
Is the assumption in the comment correct?

Since __usb_hcd_giveback_urb unanchors the URB before calling the completion
handler, usb_kill_anchored_urbs() doesn't guarantee that all completion
handlers have finished.

If tx_qmem is zeroed here before the completion handler finishes, the
subsequent subtraction in mctp_usb_out_complete() will underflow tx_qmem to a
huge unsigned value, causing the TX queue to be permanently stalled on the
next device open.

>  
>  	return 0;
>  }
-- 
This is an AI-generated review.


