Return-Path: <netdev+bounces-51514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37967FAF6E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F7281BBB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA20110B;
	Tue, 28 Nov 2023 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRO5zO47"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B01E6
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701134028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yB39XvXULa6fm+Sx4QOubXWgCDD+bG+6q4TxI6dCOY=;
	b=iRO5zO47B5sevrdkgcGqrW11k0+NML1YNaKKmZKEp67F+cvC+gA5LYkfpWKSh6t/l3lX5N
	2a/pepE9tlzJxgP4Tp/Yq/5P1zazsAj60jaF+IHqwuvEY+KhYNjyNaYDeYFLV1C2smMuep
	nrtC3/+FgMn9VbKkL/dQJddQJRvekCs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-49Swh3U9OSGMz0godmbB7g-1; Mon, 27 Nov 2023 20:13:46 -0500
X-MC-Unique: 49Swh3U9OSGMz0godmbB7g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33308815448so557791f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 17:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701134025; x=1701738825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yB39XvXULa6fm+Sx4QOubXWgCDD+bG+6q4TxI6dCOY=;
        b=IqpqoiIPgwjsKcTAu4KuwL+FPypjAoCl1O5D5uLQtlwqLpiODgurwaIxuPxl5xDF9z
         SLT6q/LC6rsYXfg3W6D74SKC9+B7ZSfdaIwFgQWb+06Nb+Ho0nOD7gxFWmpFGXjp9uRI
         LIAk8NaEdaCuIEqI4ABLYzDBBxjSi7qz6SWZiRB0+e0Jz5kAyqad3a2N/Z9XrAioRm+M
         WcHf7/D1V0RiJlUXGjdJIHyrDYqSn1gkV0hdHlf0CjBYUScVbIFUMsChCjB26CYn3iwK
         pZPvnDXNk6NnyjjJ6vNqR97ZG1iQEAicb/ggxM+pwkNcMC9UBsVO2hxJSLK507nQgnlh
         KM0Q==
X-Gm-Message-State: AOJu0YzSTtqbrl+k9iRePyu6FM14KPE3ESXDOS/oEB18pIdvKwd67ngy
	i/I52TOmatGJFiS5SyQ98cIQ75v1z2m8+NXgZPlvQHzjVWWmupnX6Xj3uJaAUdbTeUHnvb2tQs8
	YZN8f6RcghfK/WNf2
X-Received: by 2002:a5d:6806:0:b0:332:c0e9:8b1f with SMTP id w6-20020a5d6806000000b00332c0e98b1fmr9024610wru.65.1701134025470;
        Mon, 27 Nov 2023 17:13:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENSBHOp/iTGjGxcTtNdFJHsS+chSHs5B+24fZTzGUrvMW8iKlXUoPWEmtkuC3Hpy7aOyRMzg==
X-Received: by 2002:a5d:6806:0:b0:332:c0e9:8b1f with SMTP id w6-20020a5d6806000000b00332c0e98b1fmr9024596wru.65.1701134025170;
        Mon, 27 Nov 2023 17:13:45 -0800 (PST)
Received: from debian (2a01cb058d23d60028ed52b1e62ad61d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:28ed:52b1:e62a:d61d])
        by smtp.gmail.com with ESMTPSA id z1-20020adfec81000000b00332eb16d1fesm363805wrn.8.2023.11.27.17.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:13:44 -0800 (PST)
Date: Tue, 28 Nov 2023 02:13:42 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, mkubecek@suse.cz, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWU+xvr5HNGMwwHM@debian>
References: <ZWTRLVuFF+575qrI@debian>
 <20231127175643.28505-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127175643.28505-1-kuniyu@amazon.com>

On Mon, Nov 27, 2023 at 09:56:43AM -0800, Kuniyuki Iwashima wrote:
> From: Guillaume Nault <gnault@redhat.com>
> Date: Mon, 27 Nov 2023 18:26:05 +0100
> > On Fri, Nov 24, 2023 at 05:39:42PM -0800, Kuniyuki Iwashima wrote:
> > > > +			spin_lock_bh(&ibb->lock);
> > > > +			inet_bind_bucket_for_each(tb2, &ibb->chain) {
> > > > +				if (!net_eq(ib2_net(tb2), net))
> > > > +					continue;
> > > > +
> > > > +				sk_for_each_bound_bhash2(sk, &tb2->owners) {
> > > > +					struct inet_sock *inet = inet_sk(sk);
> > > > +
> > > > +					if (num < s_num)
> > > > +						goto next_bind;
> > > > +
> > > > +					if (sk->sk_state != TCP_CLOSE ||
> > > > +					    !inet->inet_num)
> > > > +						goto next_bind;
> > > > +
> > > > +					if (r->sdiag_family != AF_UNSPEC &&
> > > > +					    r->sdiag_family != sk->sk_family)
> > > > +						goto next_bind;
> > > > +
> > > > +					if (!inet_diag_bc_sk(bc, sk))
> > > > +						goto next_bind;
> > > > +
> > > > +					if (!refcount_inc_not_zero(&sk->sk_refcnt))
> > > > +						goto next_bind;
> > > 
> > > I guess this is copied from the ehash code below, but could
> > > refcount_inc_not_zero() fail for bhash2 under spin_lock_bh() ?
> > 
> > My understanding is that it can't fail, but I prefered to keep the test
> > to be on the safe side.
> > 
> > I can post a v3 using a plain sock_hold(), if you prefer.
> 
> I prefer sock_hold() because refcount_inc_not_zero() implies that it could
> fail and is confusing if it never fails.

Ok, I'll do that for v3.


