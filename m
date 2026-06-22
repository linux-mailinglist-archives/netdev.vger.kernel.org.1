Return-Path: <netdev+bounces-301126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IfF5HLQ3OWoAowcAu9opvQ
	(envelope-from <netdev+bounces-301126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1B6AFD39
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=P+4YsLlU;
	dkim=pass header.d=redhat.com header.s=google header.b=Vy9DZmTZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301126-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301126-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8378A301F4BC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47C36E468;
	Mon, 22 Jun 2026 13:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0935028D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:24:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134668; cv=none; b=VG9TMniqVkbWxhVGGuAVDzQ6cwGgE3ASZs+/Yf3B2rCsChC585ObAZn9DoLzs+h+ttkqDRB8IbypxqfAjCDa54n7C0GhWTkeSBTAv8H822zbgZWnnYriD5R32c71uR04fz7oeFXY5S5ah3Ey7sVxXwXUgYdtoiwIZaWW+F79/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134668; c=relaxed/simple;
	bh=cjAXUTzNPqS4dOTkuXMbpmtFoEhnSMkBNWuo/+4MBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbHQXjtEni0H0d2r9VPTuoxQ+MvUk1Gr1MlpwPUx67L77idOc3WyK0+eNL1vjZzjb+ePVYghKAoxf2bGv+Tq6gFGS67jA66DMMX9t/EWW+Y6oqKEWmjsBsoZynfRjwjnWKbXbDxN/fgIUOZnfZrimMQOTtqNomoKWU8yxtwSTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+4YsLlU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vy9DZmTZ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782134665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfm03S2KrDPchvPaJf082C9fX5hmkhy7ZeP2RTcSj3M=;
	b=P+4YsLlUvm+UX6Ni4zWlphFoZ0oDiUe+sA9TZ31ODMmwmwIJUWWcP6X1doGZftu2QYtVJy
	fC18BSuZIlHamryH3qrw6TZ3Yl6Pz7fFh2Y9sdErPG2V0nd8pk+0gTRuhRYKqXC4WlDZe9
	j0mPJemaSXFWcpnTCevJ2phe3avUOMw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-2bJMBzleOheyeVOiSLQffA-1; Mon, 22 Jun 2026 09:24:24 -0400
X-MC-Unique: 2bJMBzleOheyeVOiSLQffA-1
X-Mimecast-MFC-AGG-ID: 2bJMBzleOheyeVOiSLQffA_1782134663
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490d3f03883so38960455e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782134663; x=1782739463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rfm03S2KrDPchvPaJf082C9fX5hmkhy7ZeP2RTcSj3M=;
        b=Vy9DZmTZzGmh26FVyaHkX7JtheKEvSSHg9hiVh242D2yWo3bUwcD732LFCNVR+DwBB
         +K2QGwwO0reErolln9PfFjG4yGUnw08uPOP4z8R3oqkLZarX3BSzOm5gdfzD8AcsfPaS
         cLGQx3jBxOxcGJNsD0E0VdwDmV/IaDp05LJCyR0i1gtFcPZNHtQRPlHJSwACnFlGxH2i
         s2fyYGSppf7IYE0rUv7DmqCL/Q99XreQ+h673putEzBh8SGdo737QD3vUUCCdoFe+WMQ
         xZmjBlMMwn6xq8pBvynFKNv6LgVpW73figTvVxV7qqOUuPum0ZG38Xs8EBr7g9/cZ02q
         aDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134663; x=1782739463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfm03S2KrDPchvPaJf082C9fX5hmkhy7ZeP2RTcSj3M=;
        b=LzNz0vvZr5rL1kC8UnW45BwLZRmW5ZsiAxY5X9GofJ8cAUDi2R8ldY6dc5I5xeKCxX
         yuNq3yIzzwIbfDH3n/bvbgLaGeMnLoJgAHTPu42G9bSD3ztjJe0ru3tdhl7Aln/QDQgg
         1rf4P0vi8wP0euYgtd2ZCxTMtHT9NSzGhC6tUeC6ffNgkYkf+9xDCtgmO4KjAg7Ey+Qn
         yhKJd6dmyzuvMmMrnccb2HQBKIZ6yX4/Khbe3oOm2ZDIfgkg05Xnltx3mfBq0ynPq5sM
         s3co2/GDW9dbsZVv1WCbQW8kkww5VY+YCDiZcF2FCaqupoi7xahg/cJ6ZhHHTfT3DDfd
         2YpA==
X-Forwarded-Encrypted: i=1; AFNElJ/kHRijevzjZWJt1ybHzFJs1yu0DLJfBoSeTX1slIl6ByybqgWofgCGh+ht9ujYXdgFb7rW2Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaF1EUpEqvcfq6J+oFfvWstdbdeLJTmvhqJ/NnZSDE/H2HQhd
	Lnu3Ek6te5XYlhtgLBAcnz+ajM+l3zzbyDibCmNp7oYEB3ElXd60xbkcjVje6ye4r7V2Qyfetzh
	nSYIXgXrZFZQCwrRTqKDEPqaSRM2jxeaMBgm149z9ENsXaRkFt6ZEOJBxLA==
X-Gm-Gg: AfdE7cmD45rTZDuJ6sJZiNoJmV01PpvrzF6VPqTvgW4oZ/BVi1HSRnLDr/7GCmksJZC
	uExCVBhoEY77tYmCX0pYGyfV457CG3oX2qzXqJuKxfDtGSvE939b+SqNQXdMgiW0Q3tI7HgiL9H
	zGwCBILfy5CcBNE78Ylc7k2zgpc6tVacdE5/nfIubWx5W9PBvVX2gg44RMOqZFNRj2AVu1Qd741
	Eebe1GaHp96NNlpwtYGIXJ5F+zdPwlMLzNwrucHlyS8waLwsEcGg0liMUVgr7N0CRJB8VvuBs7l
	kxUqNSzBlaEb6/PLL3jPDq6R9ZMRJ64/nncr8DebvagpJPNr9ObsyC1tgAEKC/eK5AVi37JPd5A
	N8yWc88lqO7PKEPG9wFya6QiZ9zvbsbhQ
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49240e9cb38mr237208405e9.27.1782134663019;
        Mon, 22 Jun 2026 06:24:23 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49240e9cb38mr237207865e9.27.1782134662470;
        Mon, 22 Jun 2026 06:24:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944faa8sm202537345e9.13.2026.06.22.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:24:22 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:24:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260622085825-mutt-send-email-mst@kernel.org>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <20260621182119-mutt-send-email-mst@kernel.org>
 <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-301126-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:menglong.dong@linux.dev,m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2E1B6AFD39

On Mon, Jun 22, 2026 at 08:27:12PM +0800, Menglong Dong wrote:
> On 2026/6/22 06:31 Michael S. Tsirkin <mst@redhat.com> write:
> > On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
> [...]
> > >  
> > > +	vring_size = virtqueue_get_vring_size(sq->vq);
> > > +	need_wakeup = xsk_uses_need_wakeup(pool);
> > > +
> > > +	if (need_wakeup && vring_size == sq->vq->num_free)
> > > +		xsk_set_tx_need_wakeup(pool);
> > > +
> > 
> > why are we doing this here?
> > the check after virtnet_xsk_xmit_batch not enough?
> > I vaguely think it's some kind of race we are closing?
> > Pls add a comment to explain.
> 
> Hi, Michael. Thanks for your review.
> 
> Yeah, it's for a race condition between user space and kernel
> space. I added a comment in V2, which is too confusing, and
> I removed it 😢. I'll make it more clear and add it in the V4. The
> origin comment is:
> 
>  * If the sq->vq is empty, and the tx ring is empty, and the user
>  * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
>  * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
>  * up the tx napi, so we have to set the need_wakeup flag here.
> 
> And the logic is like this:
> 
> Kernel: tx NAPI is waked up from skb_xmit_done() ->
> Kernel: sq->vq and xsk->tx_ring are both empty ->
> Kernel: call virtnet_xsk_xmit_batch()
> 
>     User: submit a entry to the xsk->tx_ring
>     User: check the wakeup flag
>     User: wakeup flag is not set, skip send()
> 
> Kernel: call xsk_set_tx_need_wakeup(), because sq->vq is empty
> 
> If we don't send more data, the data in the xsk->tx_ring will
> not be sent forever.

I'm not 100% sure I understand, but when someone fixes cross-CPU races
with no synchronization or CPU memory barriers just with extra checks,
this always gives me pause.

AI helped write this for me, for example:
  1. Kernel: xsk_set_tx_need_wakeup stores NEED_WAKEUP (sits in store buffer)
  2. Kernel: xsk_tx_peek_release_desc_batch - load, sees empty (reordered before the store is globally visible)
  3. Kernel: peek finds nothing, returns 0
  4. Userspace: stores entry + producer
  5. Userspace: loads flags - doesn't see NEED_WAKEUP yet (still in kernel's store buffer)
  6. Userspeace: skips send()
  7. Kernel: NEED_WAKEUP store finally becomes visible - too late

Seems legit?



> > 
> > >  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > >  
> > > +	if (need_wakeup) {
> > > +		if (vring_size == sq->vq->num_free)
> > > +			/* we can't wake up by ourself, and it should be done
> > > +			 * by the user.
> > > +			 */
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +		else
> > > +			/* we can wake up from skb_xmit_done() */
> > > +			xsk_clear_tx_need_wakeup(pool);
> > 
> > But what if we don't have get tx napi so no wakeup in skb_xmit_done?
> 
> Sorry that I'm not sure what "get tx napi" means here ;(
> 
> There are entry in sq->vq, so skb_xmit_done() will be called after
> the entries in the ring is consumed by the HOST, right?
> Then, the corresponding sq->napi will be scheduled, as we ensure
> that tx napi is always enabled, which means napi->weight is not
> zero, in this commit:
> 1df5116a41a8 ("virtio_net: xsk: prevent disable tx napi")

Oh I forgot we did that. But can xsk bind when tx napi has already
been disabled previously?


> Right?
> 
> Thanks!
> Menglong Dong
> 
> > 
> > 
> > > +	}
> > > +
> > >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > >  		check_sq_full_and_disable(vi, vi->dev, sq);
> > >  
> > > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> > >  	u64_stats_update_end(&sq->stats.syncp);
> > >  
> > > -	if (xsk_uses_need_wakeup(pool))
> > > -		xsk_set_tx_need_wakeup(pool);
> > > -
> > >  	return sent;
> > >  }
> > >  
> > > -- 
> > > 2.54.0
> > 
> > 
> > 
> 
> 
> 


