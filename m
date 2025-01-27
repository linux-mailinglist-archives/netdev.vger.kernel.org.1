Return-Path: <netdev+bounces-161186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580DA1DCE0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF613A1FD0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A41192B90;
	Mon, 27 Jan 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFWSKUmW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9819066D
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006917; cv=none; b=n42jJ3xLIgC7qb/0Gxo7FpwaHkMsWvzEu6vMfKFf3IHPqy43uemiZlPd+IqsOKbKJmRDOjedx62n9gku9/Ez3s9wR7MUjeeVjHQLz3vmH517OHlQwWLLJ0EhFtl8w9s3sZN2f1oOfgeiPmcj5fg9Ir6TEZrhFnTPbSFt718D2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006917; c=relaxed/simple;
	bh=gieH0hqF851JC+PGfjXEJS8TB6U8bnPjMDCbDwwKVtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opBCHQGsNwLzLvkkthvkwBP+Sv5uF5qCTyZxi7hvIKbvFzhTN5Z5kzKM2AY9AMYtIIIslUpo0GNSjbOgW3CUOx8cqLNsHJusf/btFa6iM9SVH/hP9sGAzFAg9FQ9kQAgrXy3VMA0u4T73EZmLhZb4hXvck/5KRRsbesha3T3quU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFWSKUmW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215740b7fb8so23005ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738006915; x=1738611715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjunlDg2ZxWmfVt8C8pmyI9BtnNpXmXok5P9BvQ8hs4=;
        b=LFWSKUmWkDwgz1wHWH9+HjqOZUx5YVm951WUvEbtKz3zEiTcSbv55UXTLkoJDDY/lX
         /uu72EG/isW2XECTMSjtsSXG1gvruiKoHoTy5JCmVWHefx0ldXALioNovVBTS7FlgIvr
         uTvcUcRkYG0QhoVo7GuZaHKZ9Jr+4brn2AUd7EdJ4ug5lXML+Rk3zhSbgkpjzZq+FvQ3
         Gs/xkpbB7MjQDgY7GIG3CVFtQWMts06fmOi6Wb7p2YXzk0Qlc6ptuPPh0O1B4mvb4sWa
         qnLZnIeNDghXTBjvOofrZyuY69JyhJsmbjzaxDcHYOMA20dBHojm94ovY/WOo+vKDaGL
         CYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006915; x=1738611715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjunlDg2ZxWmfVt8C8pmyI9BtnNpXmXok5P9BvQ8hs4=;
        b=h+aZBfpe/5EC7ZW1GUJlwbzGVyx7maiBQ1R2ylDAeH5HAtZt8EPnWjHWL8JOtqR195
         Vi+D03BPpoIhkYXzJIl6e40sIqvBRaLNL6+7jqSZib8Q5/wu8Fx9F4PV6iXUp1/9dWbv
         qwS70kVXDMhLPgZUhEMiT+Xhjp+shw1S1sbIu/tpGdCqhE8VTu/vKlN0lZ82t4kMsM/7
         OQjlXXf82RitCvOwkVo1KAE07UgM+gFbiPASHJx5Sfks0206zw4EWukACyxIEWGsd3/3
         qcZZTDu9jTJjJPyp8QZJ4F8ecu4213MeGgfVB9Ig4kiE/QYd+gvgFwwlDZapqWVkoKVR
         eVew==
X-Forwarded-Encrypted: i=1; AJvYcCWd7wnRbcUAmWkdRLF5jhqcUNafN8e6X1U6gDCOTr8S49fKnqm89044w0ho2+Tloo1XdaHsPFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZYSy6sxK2XuKKQBQVX6yh3mCpjp+dDGBCS4fLUBOg0PRI+AgO
	A3pKgs3gZrrdkStPt0woRuIlbNwk9avM41+9PrmjJmOyIwYKlm4MWhqhTdgtaxmRE47j5WA1JsL
	BBBbX07lSkQNE5k6+oeIIxmEvDjbVkceAyceZ
X-Gm-Gg: ASbGncs7GZVsrxB1kg3a24oPN8HhzLs6V3EG/Sq6IRxQBTAuJPifKEGFByW5Hk6i8dV
	67ofd3X3fGUaXDT5yNYEEyqHdJe39vUYo0WF+TumWY6v6NjZXoOKtsXEQoUTZR4Vie7xzzLer8x
	tUoYZIFZ2yRxcKcHGlKTX951IS00Y=
X-Google-Smtp-Source: AGHT+IEZtMo0CSV7XiFNH+Vtol8La5vL0JtfV+S1GGNmNAYSJ0/PnW5Pb6XWNes2chkP4OWX70siq49zdBmkQaNlvPQ=
X-Received: by 2002:a17:902:d54d:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-21dcce27897mr285615ad.10.1738006915156; Mon, 27 Jan 2025
 11:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123231620.1086401-1-kuba@kernel.org> <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
 <87r04rq2jj.fsf@toke.dk> <CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com>
 <877c6gpen5.fsf@toke.dk> <20250127113750.54ed83d4@kernel.org>
In-Reply-To: <20250127113750.54ed83d4@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Jan 2025 11:41:42 -0800
X-Gm-Features: AWEUYZkJzMa1nQRCOAWRlQebZiyjShG3dqUHlvXi8sR1woNn_JZPSOnDxOCr9RU
Message-ID: <CAHS8izPDTNUV5vZ-JebU6nio3x+w-22VHz9r0gpRfdRfr6-vVA@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 27 Jan 2025 14:31:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > > +
> > > +/* page_pool_destroy or page_pool_disable_direct_recycling must be
> > > called before
> > > + * netif_napi_del if pool->p.napi is set.
> > > + */
>
> FWIW the comment is better placed on the warning, that's where people
> will look when they hit it ;)
>
> > >  void page_pool_destroy(struct page_pool *pool);
> > >  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect=
)(void *),
> > >                            const struct xdp_mem_info *mem);
> > >
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index 5c4b788b811b..dc82767b2516 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -1161,6 +1161,8 @@ void page_pool_destroy(struct page_pool *pool)
> > >         if (!page_pool_put(pool))
> > >                 return;
> > >
> > > +       DEBUG_NET_WARN_ON(pool->p.napi && !napi_is_valid(pool->p.napi=
));
>
> IDK what "napi_is_valid()" is. I think like this:
>

Yeah, napi_is_valid() was just pseudo code because I wasn't sure how
to actually check yet, but thanks for the diff below.

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3de752c5178..837ed36472db 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1145,6 +1145,7 @@ void page_pool_disable_direct_recycling(struct page=
_pool *pool)
>          * pool and NAPI are unlinked when NAPI is disabled.
>          */
>         WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
> +       WARN_ON(!test_bit(NAPI_STATE_LISTED, &pool->p.napi->state));
>         WARN_ON(READ_ONCE(pool->p.napi->list_owner) !=3D -1);
>
>         WRITE_ONCE(pool->p.napi, NULL);
>
> Because page_pool_disable_direct_recycling() must also be called while
> NAPI is listed. Technically we should also sync rcu if the driver calls
> this directly, because NAPI may be reused :(
>
> > >         page_pool_disable_direct_recycling(pool);
> > >         page_pool_free_frag(pool);
> >
> > Yeah, good idea; care to send a proper patch? :)
>
> ...for net-next ? :)

Will put it on my TODO list for when the tree reopens, thanks.

--=20
Thanks,
Mina

