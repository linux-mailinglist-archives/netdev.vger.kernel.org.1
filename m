Return-Path: <netdev+bounces-117813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339D94F6F5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C1128186A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEC018E029;
	Mon, 12 Aug 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JE2EDoSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34EF18CC0B
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488944; cv=none; b=aRzXElOzGVcvXQ7R9CtgmxPOvMaOcE0xoNHpqSxr8pet7VH2H3H756s+gZFp7ofLi0SH7fm6Wp6ktREcmIj55WU6ZBQ3P6OcBrI+ddJSvQTqtM2IRZpVPz4NyvTUb4y+69sg0sib28NrRcB5U4aUlFEOit6ZWr6Z/Ob6YLXZCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488944; c=relaxed/simple;
	bh=Y9p37RqX7l1j3N2jsmOssPQ5ESl1rjQuTqBm9jOVt8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKwtabZcS+oawDwWOYlgevMhGpNqCu+0QQT8ted9zgQZ2YL0CSpAWZ8Ce6GFWN7T2uqeC3o5w3ssJVoA3p0cKdPL1wYyqemflKXADVvTI0ffUM9GqPDBeisMyJojLDNwotkHuaqFc927wqLPy/Ksl07YgEvoPFy1uy7WC8cBKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JE2EDoSb; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bb687c3cceso26701496d6.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723488942; x=1724093742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyADFD9WQhxzp2ay1aw2WKRVvkg6TDMP0WC4+Y4/ivc=;
        b=JE2EDoSbtq6wm1B9727dhIKwZo1odsMWmGQUvsIHhtojihAluxR+78riU33b4Mtvpt
         en9AG09BzK8ajop61MN1jdbhnn88cq1YjWw9J2WiwyS4Zrz1tpFRudHPUrb7cLkklA3E
         5rlPYmR4kXHmqoMwoFdqxKQgkJWju8br5/2zBgwDT/Y/5kvzpQ+Z4kChbi46wHrOs7BW
         pTeUttZXztoBAsLvecysgVjobbovM0HOMKKnopdKG6mS6L/DvZ8MzvylOvzJQ9qK5pz+
         qBEkQH8igzNobNXRzQs7ei3cybfZ/PN/ONO4DqqR09ntQ4CaHNxy3VR82+dPVzX2HoWn
         pq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488942; x=1724093742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyADFD9WQhxzp2ay1aw2WKRVvkg6TDMP0WC4+Y4/ivc=;
        b=IuKCXUQLY29H2ZohO+fGAoV0EFKMoNp/N9nRv0vWAU60JHx4lCdwMVeCFS2dkt3p5c
         HoxXRvf6vBkL8vaxKjYtjC7Dm3V1mtEM9TVwc5ocyK8WYuRpPf/XoVbl4X5vjdaG4H+e
         UffcmG7LCrkp8uLTakhSA+lTlw4hAxzJ+CquX1t4t6niPhCMT1Q/+lu1KYMsvz8OzFFR
         2hZUo4n6F1DQAmjyxvqmy+jScH4Uy80H473CN6UOseO0EqxN1RkrjHQrSA+9Na2nFxtv
         ad2GfD7BYt6r8VcPclDnoASPJ7jn/Y2O2wb/NcEXnECmLj+atXFV3RfBHeStNxjBB34K
         ETzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXspKxanLnboNKRtrl/atRFPzwfI7NkRBPDhdeplkeALhFMOSOX6wCypkOfiTESsF2Xnw2rJz0DP1PVJbhhufvttrj3TgLi
X-Gm-Message-State: AOJu0YylmA4HoMj5TeddS5mCVp1LBXIjfJph0gNLAyu0CaQMKIitKwlQ
	ebRo2WglNan0qtgImYmM2ZncIa/ijJcN0dbKGOYV6jEXCPoQXbsWbENcLVXxg0AM/a1UhmZv+mn
	JofJXeISU+6lkIig6jS2osshABYmzirmO0f+w
X-Google-Smtp-Source: AGHT+IFp1FOu+6VTl1SH9buQrdLY2XqoeRggmpmtFnspQqVeWmDUabh+mYhlUvwOU41NX/UJ102jz8xe1dWJwc2epkA=
X-Received: by 2002:a05:6214:3a8b:b0:6bf:4f29:bdac with SMTP id
 6a1803df08f44-6bf4f8ad213mr10468556d6.57.1723488941777; Mon, 12 Aug 2024
 11:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com> <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org> <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com> <20240809205236.77c959b0@kernel.org>
 <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
 <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com> <20240812105732.5d2845e4@kernel.org>
In-Reply-To: <20240812105732.5d2845e4@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 12 Aug 2024 14:55:28 -0400
Message-ID: <CAHS8izPb51gvEHGHeQwWTs4YmimLLamau1c4j=Z4KGM8ZJrx5g@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 11 Aug 2024 22:51:13 +0100 Pavel Begunkov wrote:
> > > I think we're talking about 2 slightly different flags, AFAIU.>
> > > Pavel and I are suggesting the driver reports "I support memory
> > > providers" directly to core (via the queue-api or what not), and we
> > > check that flag directly in netdev_rx_queue_restart(), and fail
> > > immediately if the support is not there.
> >
> > I might've misread Jakub, but yes, I believe it's different. It'd
> > communicate about support for providers to upper layers, so we can
> > fail even before attempting to allocate a new queue and init a
> > page pool.
>
> Got it. Since allocating memory happens before stopping traffic
> I think it's acceptable to stick to a single flag.
>
> > > Jakub is suggesting a page_pool_params flag which lets the driver
> > > report "I support memory providers". If the driver doesn't support it
> > > but core is trying to configure that, then the page_pool_create will
> > > fail, which will cause the queue API operation
> > > (ndo_queue_alloc_mem_alloc) to fail, which causes
> > > netdev_rx_queue_restart() to fail.
> >
> > And I'm not against this way either if we explicitly get an error
> > back instead of trying to figure it out post-factum like by
> > checking the references and possibly reverting the allocation.
> > Maybe that's where I was confused, and that refcount thing was
> > suggested as a WARN_ONCE?
>
> Yup, the refcount (now: check of the page pool list) was meant
> as a WARN_ONCE() to catch bad drivers.
>
> > FWIW, I think it warrants two flags. The first saying that the
> > driver supports providers at all:
> >
> > page_pool_init() {
> >       if (rxq->mp_params)
> >               if (!(flags & PP_PROVIDERS_SUPPORTED))
> >                       goto fail;
> > }
> >
> > And the second telling whether the driver wants to install
> > providers for this particular page pool, so if there is a
> > separate pool for headers we can set it with plain old kernel
> > pages.
>
> The implementation of the queue API should be resilient against
> failures in alloc, and not being MP capable is just a form of
> alloc failure. I don't see the upside of double-flag.
>
> > payload_pool =3D page_pool_create(rqx, PP_PROVIDERS_SUPPORTED);
> > header_pool =3D page_pool_create(rqx, PP_PROVIDERS_SUPPORTED |
> >                                      PP_IGNORE_PROVIDERS);
>
> Also don't see the upside of the explicit "non-capable" flag,
> but I haven't thought of that. Is there any use?
>

There are 2 things we're trying to accomplish:

1. Drivers need to be able to say "I support unreadable netmem".
Failure to report unreadable netmem support should cause the netlink
API to fail when the user tries to bind dmabuf/io uring memory.

2. Drivers need to be able to say "I want a header pool (with readable
netmem)" or "I want a data pool (potentially with unreadable netmem)".

Pavel is suggesting implementing both of these in 2 different flags.

Jakub is suggesting implementing both with 1 flag which says "I can
support unreadable netmem for this pool" , and guarding against #1
with a refcount check to detect if a dmabuf pool should have been
created but wasn't.

I prefer Jakub's suggestion, but beware that if we go with Jakub's
suggestion, we can't WARN_ON when the core-net check fails, because
it's not a kernel warning. All that's happening is that the user asked
for dmabuf binding but the driver didn't ask for it (because likely it
doesn't support it). That's not cause for a warning to be printed in
the kernel. The netlink API should just fail and return -EOPNOTSUPP or
something.

> One important note. The flag should not be tied to memory providers
> but rather to netmem, IOW unreadable memory. MP is an internal detail,
> the important fact from the driver-facing API perspective is that the
> driver doesn't need struct pages.
>

Agreed.

--=20
Thanks,
Mina

