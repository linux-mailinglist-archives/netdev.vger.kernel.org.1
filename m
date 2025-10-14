Return-Path: <netdev+bounces-229100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8516BD82D7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161701898BA0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09401EEA5F;
	Tue, 14 Oct 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="A52FvxuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSQWRiht"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335A30F940
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430512; cv=none; b=daormbQrTg/T5jUQZCt/fF7LjU/tZ0++Em4VtrncASjurELmwGDKYzOnU8yLl3gRukVa4VZ55kYl2aYIVJ7gvY7v1sKY/b42fNUELGVh5LJz+xdJA3wdwX9ZmXCqvJ6dCyNaN1IDnlyJfO67kwXzQeHnpcmNGyju9SSrbSorRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430512; c=relaxed/simple;
	bh=6VsvQym1Qdmse2H24qYxtinklalSbO+vgFocyChLTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKjCbpnUX2AUPOHAgNCm7jQKWtRVZz9cJjB77GyEMax3ioCpPgoT0znEcZa4n4NTkfOLorx+RKRGGUO1WQnIX1EX4QMqnUeIl7qiu2xcbqdcIoPFnbaKJNvyf6N1HYyPZKyrC+V8OsQd5a4BhKgHz1vVnttLfGVFhAtqIQIz5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=A52FvxuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSQWRiht; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 66665EC022E;
	Tue, 14 Oct 2025 04:28:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1760430508; x=1760516908; bh=krAWQmpQNQvSueBI5fQl747v4Z4gBpI1
	U+/70y5dyng=; b=A52FvxuCsywixUE230uw8/QYQeiccCJplleNWJcjWK1dG3pE
	88nT8lfJSt9YNz9WCpLR87LJNSj+M5UYj/BQQeb/rhMnYHZZLbjkZwVb0taGZx5k
	2yploaBbNNaRdtHwQ9Spd2sYAPyMPxXNtpolf9vR9LrcCmdy9wjx1+Otl5nBjxzg
	EGr3xcwJwqPL3zKWOy66LLtnibu4JIN16Me0BmmcFqOygwAXcc63pTl3hoDIABUr
	E8mSl8iKIjTHWjE4jqFMGsk+FAhok2ubK8TvfyDzo4dvaNgVB5YyGHuA98g4FTAf
	Bc/cbmManO/7Syzh7KgZJxtG8tow0Jy5vrQXcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760430508; x=
	1760516908; bh=krAWQmpQNQvSueBI5fQl747v4Z4gBpI1U+/70y5dyng=; b=p
	SQWRiht9OqNfEFU/LJaUP1KZ0s+8MPrAPPwVUoGP8srdugDc700cY3WOwr7oYGD+
	jJKGJlHcRtZ7tdJZMLiXVIG0djD3rIkWblPSqFAxbKPmj3H1rK+3nzYvNH2bPCV8
	2TIHPlqNkD6V6NZCyn7Haf67YwgGgvHqzSR8U2HPwDf9DRS9Uhsk5rZdwWcc+Usu
	0nFUtPM9yEjLoZ6W6HqeYZq27qGx0vdaxoWNM763iJNFTulGjzlKIrpXadvuEdIK
	xYkgwz2XeA5hHAaQC6KK8S/exfut1sMMwamFyAHtSE9tCH8LgvTACy4g/OivvrUQ
	wMdxucuOHfCsqvVZ/m3Qw==
X-ME-Sender: <xms:qwnuaCbzCUC6EzgJISlfl4O5v2DRzyiGWsSliIP99QuZb_kgHbxTTQ>
    <xme:qwnuaH-LbIJxz4f-pGdn2WIAOR-Exj9lz0hZTZTTDRblBVw4lVxDvWPRKRKfqRGLb
    Xql7xRHmLOpQPMOndLCexeDgXO-HJ9Zdf2DCzeyBpTxYuIonY2kPEQ>
X-ME-Received: <xmr:qwnuaAlUvU9iBFIfBs4Lpn_aP35Z_P842VMTqXisOp17mPFUILvugi9Woh0J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    uggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtrdguuhhmrgii
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:qwnuaEyT9WAjaEX6COCNx_NcUUuZs8f4rbaab_AYTFDT8G-ld5FmyA>
    <xmx:qwnuaC4vdh5SEV89Vea-YP7nfyK-eqpURFj01SGrOFIaOuhlLND5vQ>
    <xmx:qwnuaMUgv5qEuha3eZLWh8bgGhaN1Hr15Rugmt-O2xxT2DNhpNzrxA>
    <xmx:qwnuaCLudG-SwHbS3eTQxizKJF1tkchn5_JhSqD03ijGBFAMAaoYbQ>
    <xmx:rAnuaOib-dfXLkQv77nM9ZD_e2kRnCa9rdwdm4IO2xH5vT0IEyOWAEA8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 04:28:27 -0400 (EDT)
Date: Tue, 14 Oct 2025 10:28:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <aO4JqeYJftHa-I8O@krikkit>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
 <CANn89i+t9e6qRwvkc70dbxAXLz2bGC6uamB==cfcJee3d8tbgQ@mail.gmail.com>
 <CANn89iJguZEYBP7K_x9LmWGhJw0zf7msbxrVHM0m99pS3dYKKg@mail.gmail.com>
 <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK6w0CNzMqRJiA7QN2Ap3AFWpqWYhbB55RcHPeLq6xzyg@mail.gmail.com>

2025-10-14, 01:06:04 -0700, Eric Dumazet wrote:
> On Tue, Oct 14, 2025 at 1:01 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 12:43 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 12:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > > > > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > > > >> Michal reported and bisected an issue after recent adoption
> > > > >> of skb_attempt_defer_free() in UDP.
> > > > >>
> > > > >> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979f
> > > > >> ("tcp: drop secpath at the same time as we currently drop dst")
> > > > >
> > > > > I'm not convinced this is the same bug. The TCP one was a "leaked"
> > > > > reference (delayed put). This looks more like a double put/missing
> > > > > hold to me (we get to the destroy path without having done the proper
> > > > > delete, which would set XFRM_STATE_DEAD).
> > > > >
> > > > > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > > > > x->tunnel as we delete x").
> > > >
> > > > I think Sabrina is right. If the skb carries a secpath,
> > > > UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
> > > > called by skb_consume_udp().
> > > >
> > > > skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> > > > skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()),
> > > > the skb will go through again skb_release_head_state(), with a double free.
> > > >
> > > > I think something alike the following (completely untested) should work:
> > > > ---
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 95241093b7f0..4a308fd6aa6c 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> > > > sk_buff *skb, int len)
> > > >                 sk_peek_offset_bwd(sk, len);
> > > >
> > > >         if (!skb_shared(skb)) {
> > > > -               if (unlikely(udp_skb_has_head_state(skb)))
> > > > +               if (unlikely(udp_skb_has_head_state(skb))) {
> > > >                         skb_release_head_state(skb);
> > > > +                       skb->active_extensions = 0;
> >
> > We probably also want to clear CONNTRACK state as well.
> 
> Perhaps not use skb_release_head_state() ?
> 
> We know there is no dst, and no destructor.

Then, do we need to do anything before calling skb_attempt_defer_free()?
skb_attempt_defer_free() only wants no dst and no destructor, and the
secpath issue that we dealt with in TCP is not a problem anymore.

Can we just drop the udp_skb_has_head_state() special handling and
simply call skb_attempt_defer_free()?


> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..98628486c4c5 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>                 sk_peek_offset_bwd(sk, len);
> 
>         if (!skb_shared(skb)) {
> -               if (unlikely(udp_skb_has_head_state(skb)))
> -                       skb_release_head_state(skb);
> +               if (unlikely(udp_skb_has_head_state(skb))) {
> +                       nf_reset_ct(skb);
> +                       skb_ext_reset(skb);
> +               }
>                 skb_attempt_defer_free(skb);
>                 return;
>         }

-- 
Sabrina

