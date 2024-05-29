Return-Path: <netdev+bounces-99149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F898D3D48
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E298B1F23EAE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C481A38E2;
	Wed, 29 May 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OahVjF+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBD1A0B09
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003224; cv=none; b=mhWOXA9EsJHAMJ9IPna3ZoIQa7IkfCAgbtMc4276QMWUE4tIeI3qvbM8//5MjQ5bR/FSbDPAi2nugfRjjGs7KxpaHM74Gmv38VahJg0KUQw4aopxcrIbWsrfU//mM0R0pMxCQIosUVGV+lTUGLuhWxVkCc7xnHzSrfA2rQGT7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003224; c=relaxed/simple;
	bh=7Dvlwp3cj9kBhnrZACSLGYw+fDrt3VMF9KkgcqNKF7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8+sQ9vTGpfREsUv+7Iz2vfdW6mbNwsZdssIfq+D80eeQzobF5yLakBQQOIwLLIizNTKn69dOzvcv2Oe4hbHO+7yAX1CRqOJyzK+AfGRjt3+sf65fIGNj9ZO2MOU8H8SyXzDe/KgQkQfeBZRjwPbWFbVydPSNnn+us/Se6muZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OahVjF+u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a609dd3fso37918766b.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717003220; x=1717608020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6S92XYKao8zmEwYTt3a/Nczc/mks5grdh4+BnfyPTc=;
        b=OahVjF+uze/S9Yn0R/e+72J80Eo14Ndb0JX3BX7MdTwFUtnWHqryLwOZV9e/HwNRn/
         KCzJSttyBaVlcSU8Aii7iGYJnLXOnG/vYNoV9ub7xA++Wb/uaDy335X6NZe/d0MZ4KmA
         Yemfy5Zcudp9/S6EY/5hs9Z0auOiK+7PZnIHC97KPZtxaRwTe04/w8S7LccXPI7E7tWD
         PEuSnKcy5PguqBJ+VJOY+H20C1JqxCF7VOzCbyV9PZf5dOwX7ILRV2T4KIDbhzzMEIgf
         F2HFp+dgVFKGX0yDYiaEGS6Kw/9n2i+uyrYYhyw+0lo+xD51tEUpd0vb5ywrXcox0zmZ
         d3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003220; x=1717608020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6S92XYKao8zmEwYTt3a/Nczc/mks5grdh4+BnfyPTc=;
        b=gYUyvBpLImbcVvUWlpMvUhO+2NWCEwlpvOFFgrnqh0cJxgPEQzerg/hE8R/gbLWGWZ
         QT1knEbTFU6a87dlo3RfwIU3HCbt1MnIIAoampAFhL9MRM0PWu51IhL3XZV6Jkwa0nfu
         9TLiK5aaLYU6QoRAB7cZ9L2Loj0XrkdYiQElHJb2P0nVeGrma3+u2E//BSu8KVQXTxVz
         kI8p0YZVdA5VnLc9/tqIBif5VdoFmT8p+UZO2y1qf4IgjOy6IdwtAzqT1cPUAfehJvMG
         rdM39pv2V4DtsewDg0vP5If0wPd156Epxh3gmVzaXBcxMTfn0vwpb6H6RibK6kyJX+Cc
         yQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUNqFIL7GCouyalEegUYeDXMZJ5w7esWb929OQQnSZVHPrrr29L4EdR24HDpUaoezOUR7GPn5dot4n6zGZ8AY9K4AvPB4QE
X-Gm-Message-State: AOJu0Yz9ieSPD7d/2g99gcS4+5jQsEuH1lWcBGf0AE5uNww7PhzbFxp8
	y8mXvAVz4W67nobkNZyKNgIYFBTxh8JYMkF832nuPYUtZSKDkh6p07otcNPEhXbAKYmYrL9aaF1
	WIolLgrw4u0UbIVyPbPb7zo0OFGQSMbr/E42G
X-Google-Smtp-Source: AGHT+IFAhIhHvER4srrkWNvWRV5ZrC6gug/SN6NLXzcRRgpzDjuVBSfERRb5LBk6wrj7S1gKnfcF1nodGURXGds/8UM=
X-Received: by 2002:a17:906:2dc2:b0:a62:c41d:c25f with SMTP id
 a640c23a62f3a-a642d6b1573mr258384666b.21.1717003219656; Wed, 29 May 2024
 10:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-12-almasrymina@google.com> <9097e78d-0e7d-43bd-bafd-e53a4872a4d1@davidwei.uk>
 <CAHS8izOe-uYjm0ttQgHOFpvp_Tj4_oRHV6d1Y1sWJAZJdCdCBA@mail.gmail.com> <29464e46-e196-47aa-9ff5-23173099c95e@gmail.com>
In-Reply-To: <29464e46-e196-47aa-9ff5-23173099c95e@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 29 May 2024 10:20:03 -0700
Message-ID: <CAHS8izOnD3J3i+z1nxg=AZQW9dm0w2JBtbg2=oouiER8xqeRPA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 11/14] tcp: RX path for devmem TCP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:42=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 5/28/24 18:36, Mina Almasry wrote:
> > On Wed, May 22, 2024 at 11:02=E2=80=AFPM David Wei <dw@davidwei.uk> wro=
te:
> ...
> >>> +                      */
> >>> +                     if (!skb_frag_net_iov(frag)) {
> >>> +                             net_err_ratelimited("Found non-dmabuf s=
kb with net_iov");
> >>> +                             err =3D -ENODEV;
> >>> +                             goto out;
> >>> +                     }
> >>> +
> >>> +                     niov =3D skb_frag_net_iov(frag);
> >>
> >> Sorry if we've already discussed this.
> >>
> >> We have this additional hunk:
> >>
> >> + if (niov->pp->mp_ops !=3D &dmabuf_devmem_ops) {
> >> +       err =3D -ENODEV;
> >> +       goto out;
> >> + }
> >>
> >> In case one of our skbs end up here, skb_frag_is_net_iov() and
> >> !skb_frags_readable(). Does this even matter? And if so then is there =
a
> >> better way to distinguish between our two types of net_iovs?
> >
> > Thanks for bringing this up, yes, maybe we do need a way to
> > distinguish, but it's not 100% critical, no? It's mostly for debug
> > checking?
>
> Not really. io_uring definitely wouldn't want the devmem completion path
> taking an iov and basically stashing it into a socket (via refcount),
> that's a lifetime problem. Nor we'd have all the binding/chunk_owner
> parts you have and probably use there.
>
> Same the other way around, you don't want io_uring grabbing your iov
> and locking it up, it won't even be possible to return it back. We
> also may want to have access to backing pages for different fallback
> purposes, for which we need to know the iov came from this particular
> ring.
>
> It shouldn't happen for a behaving user, but most of it would likely
> be exploitable one way or another.
>
> > I would say add a helper, like net_iov_is_dmabuf() or net_iov_is_io_uri=
ng().
>
> We're verifying that the context the iov bound to is the current
> context (e.g. io_uring instance) we're executing from. If we can
> agree that mp_priv should be a valid pointer, the check would look
> like:
>
> if (pp->mp_priv =3D=3D io_uring_ifq)
>
> > Checking for niov->pp->mp_ops seems a bit hacky to me, and may be
> > outright broken. IIRC niov's can be disconnected from the page_pool
> > via page_pool_clear_pp_info(), and niov->pp may be null. Abstractly
>
> It's called in the release path like page_pool_return_page(),
> I can't imagine someone can sanely clear it while inflight ...
>

Ah, yes, I wasn't sure what happens to the inflight pages when the pp
gets destroyed. I thought maybe the pp would return the inflight
pages, but it looks to me like the pp just returns the free pages in
the alloc cache and the ptr_ring, and the pp stays alive until all the
inflight pages are freed. So indeed niov->pp should always be valid
while it's in flight. I still prefer to have the memory type to be
part of the niov itself, but I don't feel strongly at this point; up
to you.

> > speaking the niov type maybe should be a property of the niov itself,
> > and not the pp the niov is attached to.
>
> ... but I can just stash all that in niov->owner,
> struct dmabuf_genpool_chunk_owner you have. That might be even
> cleaner. And regardless of it I'll be making some minor changes
> to the structure to make it generic.
>
> > It is not immediately obvious to me what the best thing to do here is,
> > maybe it's best to add a flag to niov or to use niov->pp_magic for
> > this.
> >
> > I would humbly ask that your follow up patchset takes care of this
> > bit, if possible. I think mine is doing quite a bit of heavy lifting
> > as is (and I think may be close to ready?), when it comes to concerns
> > of devmem + io_uring coexisting if you're able to take care, awesome,
> > if not, I can look into squashing some fix.
>
> Let it be this way then. It's not a problem while there is
> only one such a provider.
>

Thank you!

--=20
Thanks,
Mina

