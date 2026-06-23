Return-Path: <netdev+bounces-301242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EMeQAyHmOWplywcAu9opvQ
	(envelope-from <netdev+bounces-301242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:49:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2656B363C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:49:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IrzIFAfK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301242-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E31C30380DC
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B46370AC7;
	Tue, 23 Jun 2026 01:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8683859F0
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:49:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179353; cv=none; b=tvnSScXBOms2c+a2bx9o+YieMTmj5AT4r9x0otfibz9Xs4S1cfjoqaA6nsEvgTxNJOkrSz6MzN8ihg4ERdZkCSs++WsVkev8eMxAzugvZCeQPHr8hxoEGBqv4Wvmpio+NdHW65mc6wP+iSHXPpmS29Twb9tzhKbwzBM4I80/+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179353; c=relaxed/simple;
	bh=3nfjaEtFO7rOC0JR1hAFhKGXBCnTehQeq6rVUE5vakg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWH3akpEgS++vRVX5vZt10+AzBpgsI3UOZEBouWOUTD1KCngDudnfNWje3TpyBWGoSlJA7UA99pE6+1E53ntvHrxHlzvUrhG3nF4l3aiX0Pmn629BlwMjwz4kgzG4ybQhdfb8L8RlovR1Fd++PN2HFE1hGQLHJvTt43/TNMFCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IrzIFAfK; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782179339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FP8XK6mc3XsF7klqo8W7GStOpRwDK+Hsqke0DeD5JPE=;
	b=IrzIFAfKGPZG6bNs9GLkxWWkAjerUzvGUgpMS+I+1aqBCTJ4TEIGxBw9eJFvLvx+N97GGt
	xTGjIx1BAsNBENINgBQbMcrYUagXt92R725IP893RnguzhJ6CKSGBi2wb87NJL8t/1e7sr
	w8F4wFvhBCW8tXvcTiZ5YyphGMmewKw=
From: Menglong Dong <menglong.dong@linux.dev>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Tue, 23 Jun 2026 09:48:51 +0800
Message-ID: <d3QXZoiISIiEIwCXJDbC5A@linux.dev>
In-Reply-To: <20260622085825-mutt-send-email-mst@kernel.org>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
 <20260622085825-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301242-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C2656B363C

On 2026/6/22 21:24 Michael S. Tsirkin <mst@redhat.com> write:
> On Mon, Jun 22, 2026 at 08:27:12PM +0800, Menglong Dong wrote:
> > On 2026/6/22 06:31 Michael S. Tsirkin <mst@redhat.com> write:
> > > On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
> > [...]
[...]
> > 
> > And the logic is like this:
> > 
> > Kernel: tx NAPI is waked up from skb_xmit_done() ->
> > Kernel: sq->vq and xsk->tx_ring are both empty ->
> > Kernel: call virtnet_xsk_xmit_batch()
> > 
> >     User: submit a entry to the xsk->tx_ring
> >     User: check the wakeup flag
> >     User: wakeup flag is not set, skip send()
> > 
> > Kernel: call xsk_set_tx_need_wakeup(), because sq->vq is empty
> > 
> > If we don't send more data, the data in the xsk->tx_ring will
> > not be sent forever.
> 
> I'm not 100% sure I understand, but when someone fixes cross-CPU races
> with no synchronization or CPU memory barriers just with extra checks,
> this always gives me pause.
> 
> AI helped write this for me, for example:
>   1. Kernel: xsk_set_tx_need_wakeup stores NEED_WAKEUP (sits in store buffer)
>   2. Kernel: xsk_tx_peek_release_desc_batch - load, sees empty (reordered before the store is globally visible)
>   3. Kernel: peek finds nothing, returns 0
>   4. Userspace: stores entry + producer
>   5. Userspace: loads flags - doesn't see NEED_WAKEUP yet (still in kernel's store buffer)
>   6. Userspeace: skips send()
>   7. Kernel: NEED_WAKEUP store finally becomes visible - too late
> 
> Seems legit?

Ah, it seems right. The race condition problem is more complex
than I thought. And seems that this is a common problem of
XSK WAKEUP, which should exists for all the drivers.

So I think we can remove the checking here. And I'll see if I
can solve such problem completely further. WDYT?

> 
> 
> 
> > > 
> > > >  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > > >  
> > > > +	if (need_wakeup) {
> > > > +		if (vring_size == sq->vq->num_free)
> > > > +			/* we can't wake up by ourself, and it should be done
> > > > +			 * by the user.
> > > > +			 */
> > > > +			xsk_set_tx_need_wakeup(pool);
> > > > +		else
> > > > +			/* we can wake up from skb_xmit_done() */
> > > > +			xsk_clear_tx_need_wakeup(pool);
> > > 
> > > But what if we don't have get tx napi so no wakeup in skb_xmit_done?
> > 
> > Sorry that I'm not sure what "get tx napi" means here ;(
> > 
> > There are entry in sq->vq, so skb_xmit_done() will be called after
> > the entries in the ring is consumed by the HOST, right?
> > Then, the corresponding sq->napi will be scheduled, as we ensure
> > that tx napi is always enabled, which means napi->weight is not
> > zero, in this commit:
> > 1df5116a41a8 ("virtio_net: xsk: prevent disable tx napi")
> 
> Oh I forgot we did that. But can xsk bind when tx napi has already
> been disabled previously?

According to my observe, it can, which I think is another issue, and
I were about to fix it later in a separate patch.

It is a problem, right?

There are 2 approach to fix it:
1. don't allow the binding if the tx napi is not enabled
2. or we set the tx_napi->weight to 1 when binding, and
    restore it to 0 when unbind.

Should I fix it in this series?

Thanks!
Menglong Dong

> 
> 
> > Right?
> > 
> > Thanks!
> > Menglong Dong
> > 
> > > 
> > > 
> > > > +	}
> > > > +
> > > >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > > >  		check_sq_full_and_disable(vi, vi->dev, sq);
> > > >  
> > > > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > > >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> > > >  	u64_stats_update_end(&sq->stats.syncp);
> > > >  
> > > > -	if (xsk_uses_need_wakeup(pool))
> > > > -		xsk_set_tx_need_wakeup(pool);
> > > > -
> > > >  	return sent;
> > > >  }
> > > >  
> > > > -- 
> > > > 2.54.0
> > > 
> > > 
> > > 
> > 
> > 
> > 
> 
> 





