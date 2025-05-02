Return-Path: <netdev+bounces-187480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F56AA75A1
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 17:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89701C064B6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52325B692;
	Fri,  2 May 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="15GxSG4s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8oe7RMus"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8B25A623
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198432; cv=none; b=JuSvdi7UlIoQBE5kHteV6ydk4MUOZGXFtlKnQ6xLmEk3Ci31ew/VXTaLrxBc8/sUbaAuc0oi1XNkW6gx6pmI139MzZFl+CCs8wQv5ZKazTg7IkJXhKqA6NxboDFNsKo34nybYOiM8z1NVSPwkI3eOv7X1iYOLOzGdiu/8zGf5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198432; c=relaxed/simple;
	bh=FhZSEKakuHrftAvZsQuDccKNUIrZD+H9IEITRHWuf2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUQY/CadI9GHGRy3mfb51Wb33VFGmgAWcdlMJPjtoHxKS818PPC5xExXeK116tyvpcPs0/0fiZ6Na/nBIu/7MsUUCwRjLPAzOK8P/6SdyGhULaaXu5OC/OriH5ZD6ENfZyv2K0Lljhkz0q5tWtG4eF8H5vwGZZD4gtGbyHc4paE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=15GxSG4s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8oe7RMus; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 2 May 2025 17:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746198427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkmPEZPk/ktQXGvhPAM+mQl6SyG+K+iXiAnBN+c43mg=;
	b=15GxSG4sVX2igLYwYfp9dh+QpgH1E/p0c85adBCVk9GXAN2chTavqodeGUXXn7Ur6b1Wug
	ChF9CCk6/vJNo16ErnyTOK7XlmXLcd2/k+LJoL++jDYO0TqpQzaQ2dbQrSsiO6/0USyjyd
	z+4gHICTCrmU9LxJQw7n74ZWjVYdoAmOTSARK6FhT7qeDAKE8AgAE084NWdLPHQsgqyg0k
	z2gEV6zCyEJpQ227k2q+57REE+wosZgTaD8jVqN/yloGAKojePA+E6GLRK5lbPBFikaX6K
	LG3XjkpDencg8jW4+XC3MXsbdQyKgk52XUHw3I6P4t8hieeEBS2x/iVydBG0qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746198427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkmPEZPk/ktQXGvhPAM+mQl6SyG+K+iXiAnBN+c43mg=;
	b=8oe7RMusE8v8XEsPV5RNMFW8WwenbOITj+R5ujMr0AOtv5MqQ0kSI6gpIsOH+70g66dr1H
	6uQyItld5I29BLDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
Message-ID: <20250502150705.1sewZ77B@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
 <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de>
 <87ikmj5bh5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ikmj5bh5.fsf@toke.dk>

On 2025-05-02 16:33:10 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>=20
> > @@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_=
buff *xdp)
> >  	local_lock_nested_bh(&system_page_pool.bh_lock);
> >  	pp =3D this_cpu_read(system_page_pool.pool);
> >  	data =3D page_pool_dev_alloc_va(pp, &truesize);
> > -	if (unlikely(!data)) {
> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
> > -		return NULL;
> > -	}
> > +	if (unlikely(!data))
> > +		goto out;
> > =20
> >  	skb =3D napi_build_skb(data, truesize);
> >  	if (unlikely(!skb)) {
> >  		page_pool_free_va(pp, data, true);
> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
> > -		return NULL;
> > +		goto out;
> >  	}
> > =20
> >  	skb_mark_for_recycle(skb);
> > @@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_=
buff *xdp)
> > =20
> >  	if (unlikely(xdp_buff_has_frags(xdp)) &&
> >  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> > -		local_unlock_nested_bh(&system_page_pool.bh_lock);
> >  		napi_consume_skb(skb, true);
> > -		return NULL;
> > +		skb =3D NULL;
> >  	}
> > +
> > +out:
> >  	local_unlock_nested_bh(&system_page_pool.bh_lock);
> > -
> > -	xsk_buff_free(xdp);
> > -
> > -	skb->protocol =3D eth_type_trans(skb, rxq->dev);
> > +	if (skb) {
> > +		xsk_buff_free(xdp);
> > +		skb->protocol =3D eth_type_trans(skb, rxq->dev);
> > +	}
>=20
> I had in mind moving the out: label (and the unlock) below the
> skb->protocol assignment, which would save the if(skb) check; any reason
> we can't call xsk_buff_free() while holding the lock?

We could do that, I wasn't entirely sure about xsk_buff_free(). It is
just larger scope but nothing else so far.

I've been staring at xsk_buff_free() and the counterparts such as
xsk_buff_alloc_batch() and I didn't really figure out what is protecting
the list. Do we rely on the fact that this is used once per-NAPI
instance within RX-NAPI and never somewhere else?

> -Toke

Sebastian

