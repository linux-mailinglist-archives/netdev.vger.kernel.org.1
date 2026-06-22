Return-Path: <netdev+bounces-301094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KNt9O34qOWoSnwcAu9opvQ
	(envelope-from <netdev+bounces-301094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:28:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F56AF702
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:28:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iul6CYjc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301094-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59C82301E742
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BAD3A719C;
	Mon, 22 Jun 2026 12:28:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772A3A7193
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131323; cv=none; b=YmGO/4KeZRVl+1y+SInKMPci8g7cLUDvF5tEmjuqqQuKyt/OOQ7seG24MIxTU749YNkO881q86J+Zqa/VhPHuvXNVVjbEJ31386pnJmGmqndBTh7HVzNO8N24B2pIA0MLuws7FZwMsDe9CKK1aJoYn6LeFyPa0BNwso5ttcRUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131323; c=relaxed/simple;
	bh=ilMbIHxM3LO0PFkjI+Cz2/XDUU5BLHB92aMMMp0DQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GekhrjE7YqW8vu95By+fWnaIRepdAmwJJIOHjOGGMpY8HBzvA0/X0hgLN7aBQ90vXLUJAGDBT1MpXXKYd4nMd+W62/+yC4WH0tBe54LavnPe9vRQ0dyGgsPFWBoDXDnR6CKhZMOXbKckTOnnXIKwVWHhNzZOSj8rNYeri/G/O8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iul6CYjc; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782131319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgblrmP0/YIgfsoN/hQkF4Nh8mmKPXKlUQ9nt/ej4G8=;
	b=iul6CYjc2sWR1WDrBFqVfauMJoNatGCBcGFeqCqMfDEBuhmy+i+34mndFi4W/v7M6aR04m
	hvoEZcLsid+9dtRxkDOu8ZEaAQl80dcBbbnUzF5jeoIIWJ0H9aDnRm1VKk+A65vSljroZc
	sxTJr5s/ArxevMr1Wi3DES3tkcBSdck=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, eperezma@redhat.com
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 20:28:30 +0800
Message-ID: <JKxclkQrSOi004E_FpT2eg@linux.dev>
In-Reply-To: <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
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
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301094-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:eperezma@redhat.com,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568F56AF702

On 2026/6/22 10:40 Xuan Zhuo <xuanzhuo@linux.alibaba.com> write:
> On Tue, 16 Jun 2026 19:59:12 +0800, Menglong Dong <menglong8.dong@gmail.com> wrote:
> > For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> > in the tx path for example: we set xsk_set_tx_need_wakeup() in
> > virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> > anywhere, which means the user will call send() for every packet.
> >
> > We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> > is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> > Otherwise, we will clear the wakeup flag.
> >
> > Race condition is considered for tx path.
> >
> > Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> 
> This is not a bug, so we do not need this.
> And you post this to net-next.

Okay, I'll remove this tag in the V4.

> 
> 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
[...]
> > +
> > +	if (need_wakeup && vring_size == sq->vq->num_free)
> > +		xsk_set_tx_need_wakeup(pool);
> 
> You need to comment this.

Ack!

> 
> 
> > +
[...]
> > +
> >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> >  		check_sq_full_and_disable(vi, vi->dev, sq);
> 
> 
> After fixed above comments, you can add:
> 
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

OK! Thanks for the review :)

> 
> Thanks.
> 
> 
> >
> > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> >  	u64_stats_update_end(&sq->stats.syncp);
> >
> > -	if (xsk_uses_need_wakeup(pool))
> > -		xsk_set_tx_need_wakeup(pool);
> > -
> >  	return sent;
> >  }
> >
> > --
> > 2.54.0
> >
> 
> 





