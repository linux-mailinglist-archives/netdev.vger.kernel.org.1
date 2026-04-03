Return-Path: <netdev+bounces-274955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD5dGNyDz2mwwwYAu9opvQ
	(envelope-from <netdev+bounces-274955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:09:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F773929DB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5141B3048574
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D43859EB;
	Fri,  3 Apr 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dhhmPSWB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016B38657D
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207043; cv=none; b=VgufqUlsblbK46lNVtVTYoXjGhySyxwXotCUCtwCPvwl+MPlmqrDdjOSa3A6ilq6rtcnCIcvxHq5K8+9qwLcVHdX3LxyVPXYL+fFo1rRaPCN8qUOLYtHNbhBdQFjhSioak9lKXdBwyHy9RQcqmV/f+i83yqRpXaYqrtPRruNYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207043; c=relaxed/simple;
	bh=+dM6/hrrPfQsqwP6ZAWFsMLlTS5c9rU+YL9yPJQHRu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p9xVWBHIVkdn1uPAb2bT3B/XJjEGzAoCmsmP0dlbp6msSRcqymljZtJoQdKi3WswjR3Qe+0SlU/igv6GKl3b0BtBO46WyEKuCo0QiIJdnhCnPD1VRLdGzcUmIoORDO4Y1jSfKJoTuDVfz5QTDZ05EnohmvwrYbFKWEsOBNjcJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dhhmPSWB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AFE46C59F5A;
	Fri,  3 Apr 2026 09:04:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB1C8603C1;
	Fri,  3 Apr 2026 09:03:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28D81104502AB;
	Fri,  3 Apr 2026 11:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775207038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gvXMzezT/GwEiC62Cc8+yeqNLI/MJZ10CahI0gyd0Js=;
	b=dhhmPSWBGCET5DTLYuM1RXB1hdE8eJfG0DMjsgLRJmCtBmd7IryLkEgtug6F4w7Lhr+xG5
	51Ff68nbZc/eJK0N7atgcYfxlbWDtilC4uMkGpZ8bL9T04JeWIaFpW/Z2FoPFgE1Cbwqnl
	b2JJrzNjAWoEoBLzVHh6ZYiRpT4U536iPb1onE3Z6TtDQbDMdsJ6sOp8msA+sc0jGU7Bba
	o+QmTNS2QH0+twNPWazxwbndhno2K5qqFaMHSc5QhGVAF5frR1HRs2Pk4hTq4XHeo0fGat
	zXoEhNqA/99SHoJT47ai6ev+h/nT0l0uyVOGNBlKU49iCtdI1nN/h5QdEB4b/Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 11:03:48 +0200
Message-Id: <DHJEDEN0V2YO.1B1YSUP8Q39HT@bootlin.com>
Subject: Re: [PATCH net-next 10/11] net: macb: use context swapping in
 .set_ringparam()
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor
 Dooley" <conor@kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <20260401-macb-context-v1-10-9590c5ab7272@bootlin.com>
 <90f843aa3940bdbabadddce27314c1f1@tipi-net.de>
 <DHIT9TPJQJ46.21A89R5UAFXVH@bootlin.com>
In-Reply-To: <DHIT9TPJQJ46.21A89R5UAFXVH@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: D5F773929DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu Apr 2, 2026 at 6:31 PM CEST, Th=C3=A9o Lebrun wrote:
> On Thu Apr 2, 2026 at 1:29 PM CEST, Nicolai Buchwitz wrote:
>> On 1.4.2026 18:39, Th=C3=A9o Lebrun wrote:
>>> ethtool_ops.set_ringparam() is implemented using the primitive close /
>>> update ring size / reopen sequence. Under memory pressure this does not
>>> fly: we free our buffers at close and cannot reallocate new ones at
>>> open. Also, it triggers a slow PHY reinit.
>>>=20
>>> Instead, exploit the new context mechanism and improve our sequence to:
>>>  - allocate a new context (including buffers) first
>>>  - if it fails, early return without any impact to the interface
>>>  - stop interface
>>>  - update global state (bp, netdev, etc)
>>>  - pass buffer pointers to the hardware
>>>  - start interface
>>>  - free old context.
>>>=20
>>> The HW disable sequence is inspired by macb_reset_hw() but avoids
>>> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
>>>=20
>>> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
>>> over register writes which would be redundant (because values have not
>>> changed).
>>>=20
>>> The generic context swapping parts are isolated into helper functions
>>> macb_context_swap_start|end(), reusable by other operations=20
>>> (change_mtu,
>>> set_channels, etc).
>>>=20
>>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  drivers/net/ethernet/cadence/macb_main.c | 89=20
>>> +++++++++++++++++++++++++++++---
>>>  1 file changed, 82 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>>> b/drivers/net/ethernet/cadence/macb_main.c
>>> index 42b19b969f3e..543356554c11 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -2905,6 +2905,76 @@ static struct macb_context=20
>>> *macb_context_alloc(struct macb *bp,
>>>  	return ctx;
>>>  }
>>>=20
>>> +static void macb_context_swap_start(struct macb *bp)
>>> +{
>>> +	struct macb_queue *queue;
>>> +	unsigned int q;
>>> +	u32 ctrl;
>>> +
>>> +	/* Disable software Tx, disable HW Tx/Rx and disable NAPI. */
>>> +
>>> +	netif_tx_disable(bp->netdev);
>>> +
>>> +	ctrl =3D macb_readl(bp, NCR);
>>> +	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
>>> +
>>> +	macb_writel(bp, TSR, -1);
>>> +	macb_writel(bp, RSR, -1);
>>> +
>>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
>>> +		queue_writel(queue, IDR, -1);
>>> +		queue_readl(queue, ISR);
>>> +		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>>> +			queue_writel(queue, ISR, -1);
>>> +	}
>>> +
>>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
>>> +		napi_disable(&queue->napi_rx);
>>> +		napi_disable(&queue->napi_tx);
>>> +	}
>>
>> tx_error_task, hresp_err_bh_work, and tx_lpi_work all dereference
>> bp->ctx and could race with the pointer swap in swap_end.
>> macb_close() cancels at least tx_lpi_work here. Should these be
>> flushed too?
>
> This is a large topic! While trying to find a solution as part of this
> series I am noticing many race conditions. With this context series we
> worsen some (by introducing bp->ctx NULL ptr dereference).
>
> Let's start by identifying all schedule-able contexts involved:
>  - #1 any request from userspace, too many callbacks to list
>  - #2 NAPI softirq or kthread context, macb_{rx,tx}_poll()
>  - #3 bp->hresp_err_bh_work / macb_hresp_error_task()
>  - #4 bp->tx_lpi_work / macb_tx_lpi_work_fn()
>  - #5 queue->tx_error_task / macb_tx_error_task()
>  - #6 IRQ context, macb_interrupt()
>
> Some race conditions:
>
>  - #1 macb_close() doesn't cancel & wait upon #3 hresp_err_bh_work.
>    They could race, especially as #3 doesn't grab bp->lock. One race
>    example: #3 BP HRESP starts the interface after it has been closed
>    and buffers freed. RBQP/TBQP are not reset so MACB would occur
>    memory corruption on Rx and transmit memory content.
>
>  - #1 macb_close() doesn't cancel & wait upon #5 tx_error_task. #5 does
>    grab bp->lock but that doesn't make it much safer. One race example:
>    same as above, restart of interface with ghost ring buffers.
>
>  - #3 hresp_err_bh_work could collide with anything as it does no
>    locking, especially #1 (xmit for example) or #2 (NAPI). It is less
>    likely to collide with #6 IRQ because it starts by disabling those
>    but there is a possibility of the IRQ having already triggered and
>    macb_interrupt() already running in parallel of
>    macb_hresp_error_task().
>
>  - #5 queue->tx_error_task writes to Tx head/tail inside bp->lock.
>    #1 macb_start_xmit() modifies those too, but inside
>    queue->tx_ptr_lock. Oops. There probably are other places modifying
>    head/tail or any other Tx queue value without queue->tx_ptr_lock.
>
>  - #5 macb_tx_error_task() tries to gently disable TX but if it
>     times-out then it uses the global switch (TE field in NCR
>     register). That sounds racy with #2 NAPI that doesn't grab bp->lock
>     and would probably break if the interface is shutdown under its
>     feet.
>
> I don't see much more. To fix all that, someone ought to exhaustively go
> through all tasks (#1-6 above) & all shared data and reason one by one.
> Who will be that someone? ;-) But that sounds pretty unrelated to the
> series at hand, no?
>
> I'd agree that some locking of bp->lock around the swap operation would
> improve the series, and I'll add that in V2 for sure!

After some sleep, I feel like my message was a bit rough. To clarify
what I plan for V2:
 - grab bp->lock on swap to protect us against some of #1 userspace and
   all of #6 IRQ.
 - disabling #2 NAPI on swap is already done
 - disable all three BH features on swap

That will not fix everything listed above.

On top, we should:
 - check/revise our locking strategy for almost all codepaths,
 - check all BH features are disabled and blocked upon in the right
   codepaths,
 - in many bp->lock critical section, we should early exit if !bp->ctx.

>
>>
>>> +}
>>> +
>>> +static void macb_context_swap_end(struct macb *bp,
>>> +				  struct macb_context *new_ctx)
>>> +{
>>> +	struct macb_context *old_ctx;
>>> +	struct macb_queue *queue;
>>> +	unsigned int q;
>>> +	u32 ctrl;
>>> +
>>> +	/* Swap contexts & give buffer pointers to HW. */
>>> +
>>> +	old_ctx =3D bp->ctx;
>>> +	bp->ctx =3D new_ctx;
>>> +	macb_init_buffers(bp);
>>> +
>>> +	/* Start NAPI, HW Tx/Rx and software Tx. */
>>> +
>>> +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
>>> +		napi_enable(&queue->napi_rx);
>>> +		napi_enable(&queue->napi_tx);
>>> +	}
>>> +
>>> +	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
>>> +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues;
>>> +		     ++q, ++queue) {
>>> +			queue_writel(queue, IER,
>>> +				     bp->rx_intr_mask |
>>> +				     MACB_TX_INT_FLAGS |
>>> +				     MACB_BIT(HRESP));
>>> +		}
>>> +	}
>>> +
>>> +	ctrl =3D macb_readl(bp, NCR);
>>> +	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
>>> +
>>> +	netif_tx_start_all_queues(bp->netdev);
>>> +
>>> +	/* Free old context. */
>>> +
>>> +	macb_free_consistent(old_ctx);
>>
>> 1. kfree(old_ctx) is missing. The context struct itself leaks on
>>     every swap.
>
> Agreed.
>
>> 2. macb_close() calls netdev_tx_reset_queue() for each queue.
>>     Shouldn't the swap do the same? BQL accounting will be stale
>>     after switching to a fresh context.
>
> I explicitely left that out as I thought DQL would benefit from keeping
> past context of the traffic. But indeed as we start afresh from a new
> set of buffers we should reset DQL. fbnic, pointed out as an good
> example by Jakub recently, does that.
>
>>
>> 3. macb_configure_dma() is not called after the swap. For
>>     set_ringparam this is probably fine since rx_buffer_size
>>     does not change, but this becomes a problem in patch 11.
>
> Indeed, I had missed it took bp->ctx->rx_buffer_size as a parameter.
> Will fix.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


