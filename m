Return-Path: <netdev+bounces-210656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E3B142E9
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 22:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EB517F2CE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60425A32E;
	Mon, 28 Jul 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knG5bCDa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4C245033
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734243; cv=none; b=GSK99OQTsRO71EIPSxMjl2N1BekbhORr3Te4RZp/nKYDl2CyLFydoASHDKHz4rk0jYBLDuDYglDCGnJ48A2qiOQR2VGC0WS8Facx2tIPm/ydGSqFobjgGkRClJHOkwS1iVDIAsWD4VUBIuhi7UKl8Nd5lKqWYskhr9TbDrKXC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734243; c=relaxed/simple;
	bh=LYoVVzajOoPgZDBKBpnnebLLV5vUzNDBvycFEG5lzVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdDzBt2f18NRULVNktL29hXhUSurXzEgtHcjGaM4xt5iTcuYirT9jbhXFlh8PhvSfSnrwdfSmb9ml/KHXCiUjnh5giFbtSwxFr9StXOj4xu8QrmOLSGI3g8NSRJGsY3u49krCTXIZBrrTBYXkJ7fPcj6PrB1hK3LOS/ihRNf8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knG5bCDa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2357c61cda7so7245ad.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734241; x=1754339041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xUafhtL99tEx506DlsL71l5w0tOKgOiw5rYe/8org4=;
        b=knG5bCDasZlraZR8DEIOvB0H2F+CSHXyx9ziUryIwi3YpfeyH9kvc6hc85JkT3Sjm9
         KBs7cSBLVJVx1WKorxURyJXHq063EvQ/A28ZXhK0C+1QQcRucSqgsenrIq94vEpLnt7O
         ytdIjlEX81t1nh5XgscijT8iZCImd7ueEJTKqn0wmYKWjyz8fF827Isd5ljYzO3xiPTL
         +y+KkiT6daCtC8JyUvC114qmbNiMN8w1QgGgQXB09EKC8j/MvOJjN4xRnM1BD8BKaEjA
         Gh6lSLE32FErfF9qlyHgTk7T+NbvXnoHPzefWzeEsizAvlJ/42vLZKhpJ2AfP51sFVUO
         G6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734241; x=1754339041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xUafhtL99tEx506DlsL71l5w0tOKgOiw5rYe/8org4=;
        b=PjbXF9YM9u8xxGGe3YNLer3komMfDrxlfKUBWSNIYBwQdzW621OOcihttCw3XNQRi5
         r1Sk0o2bdXoUaFAF2aXisscizV83BmAxwMPSV3NCrvxRn20FFqwieOZAH82LXvXLDYaU
         XC+HZ0zWjbg8Lzm/Uetmdik6EJdt4dcGbtVvAtbDtdjCg/wDY+99CawhdI78RjRCwSfY
         +tiOI2VgVge7/q32/3+1aVEVIA27MpVjlPKZ734ON14gFFa9HRPWNv579IGi6GoMDRTW
         Bhhiv5GwRcXH05JjNw9EzhDRAJgXTe7QbFQ5qTzusPizW3cApANFLC2rspKDtGajxNnh
         gMHA==
X-Forwarded-Encrypted: i=1; AJvYcCVSKx/25u4k2mtcjuaUUd3THoPcfkwQWO/atfr/Lhzwo3I7zfIFVBngZCserUEkEhPs5gCCXtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwONh9MvpSjFJMCNgO/ibXWWlgcZ3+n/zwApj/6U4gG+nZUzE7y
	oEdDC/73HEzqVsbdGclRankYl4w7zXB42OPw1JuRHHZBOMpDbPp+6wrL7ZHkDqUCSpnfuZvd1A4
	WOpbFzJ9hhZS0WOX+eQ5ChXib/QpktmC8jmV4ln/N
X-Gm-Gg: ASbGncuw+eMI/QLIPZdN+niQEf6t0Vj/o/OyqQZHCnfGVgbQpUZtUC0E0+JrrYUS4fv
	pg831HQhXvK3178kDdxerX0kVSiLapchsuZKTQHKZgczCdrNkL2UWz63oIth7sosKVkaNMDXCTk
	cTZdRrzRs5fjjVJoq3I5BvFdKgLm9Jsv0KjLX0GXBffVBl+6w2zDjR7nFNkqWfjFCq9uAc41Fm9
	/vzvuwpWg3cChThn+Vusi+GwYi6vxjfuz4RMw==
X-Google-Smtp-Source: AGHT+IEgYrUgg+rQMulSI1D4EeBbrjKfQAJZEYV3j7W2xzIx5XNASvs2W6+/TW71wDZn+udTnXlDHJ0wUaY9nyQn0SQ=
X-Received: by 2002:a17:902:f60c:b0:235:f18f:291f with SMTP id
 d9443c01a7336-240692404f8mr697235ad.23.1753734241164; Mon, 28 Jul 2025
 13:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <CAHS8izMyhMFA5DwBmHNJpEfPLE6xUmA453V+tF4pdWAenbrV3w@mail.gmail.com>
 <9922111a-63e6-468c-b2de-f9899e5b95cc@gmail.com>
In-Reply-To: <9922111a-63e6-468c-b2de-f9899e5b95cc@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 13:23:48 -0700
X-Gm-Features: Ac12FXxRLNnTbHG0XSh53urfnw-X8f_2naL5njl5hHHsXtSKSTfv4SwKW8HRAW0
Message-ID: <CAHS8izMR+PsD12BA+Rq2yixKn=656V1jQhryiVZrC6z05Kq1SQ@mail.gmail.com>
Subject: Re: [RFC v1 00/22] Large rx buffer support for zcrx
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 12:40=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 7/28/25 19:54, Mina Almasry wrote:
> > On Mon, Jul 28, 2025 at 4:03=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> This series implements large rx buffer support for io_uring/zcrx on
> >> top of Jakub's queue configuration changes, but it can also be used
> >> by other memory providers. Large rx buffers can be drastically
> >> beneficial with high-end hw-gro enabled cards that can coalesce traffi=
c
> >> into larger pages, reducing the number of frags traversing the network
> >> stack and resuling in larger contiguous chunks of data for the
> >> userspace. Benchamrks showed up to ~30% improvement in CPU util.
> >>
> >
> > Very exciting.
> >
> > I have not yet had a chance to thoroughly look, but even still I have
> > a few high level questions/concerns. Maybe you already have answers to
> > them that can make my life a bit easier as I try to take a thorough
> > look.
> >
> > - I'm a bit confused that you're not making changes to the core net
> > stack to support non-PAGE_SIZE netmems. From a quick glance, it seems
> > that there are potentially a ton of places in the net stack that
> > assume PAGE_SIZE:
>
> The stack already supports large frags and it's not new. Page pools
> has higher order allocations, see __page_pool_alloc_page_order. The
> tx path can allocate large pages / coalesce user pages.

Right, large order allocations are not new, but I'm not sure they
actually work reliably. AFAICT most drivers set pp_params.order =3D 0;
I'm not sure how well tested multi-order pages are.

It may be reasonable to assume multi order pages just work and see
what blows up, though.

> Any specific
> place that concerns you? There are many places legitimately using
> PAGE_SIZE: kmap'ing folios, shifting it by order to get the size,
> linear allocations, etc.
>

From a 5-min look:

- skb_splice_from_iter, this line: size_t part =3D min_t(size_t,
PAGE_SIZE - off, len);
- skb_pp_cow_data, this line: max_head_size =3D
SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
- skb_seq_read, this line: pg_sz =3D min_t(unsigned int, pg_sz -
st->frag_off, PAGE_SIZE - pg_off
- zerocopy_fill_skb_from_iter, this line: int size =3D min_t(int,
copied, PAGE_SIZE - start);

I think the `PAGE_SIZE -` logic in general assumes the memory is
PAGE_SIZEd. Although in these cases it seems page specifics, i.e.
net_iovs wouldn't be exposed to these particular call sites.

I spent a few weeks acking the net stack for all page-access to prune
all of them to add unreadable netmem... are you somewhat confident
there are no PAGE_SIZE assumptions in the net stack that affect
net_iovs that require a deep look? Or is the approach here to merge
this and see what/if breaks?

> > cd net
> > ackc "PAGE_SIZE|PAGE_SHIFT" | wc -l
> > 468
> >
> > Are we sure none of these places assuming PAGE_SIZE or PAGE_SHIFT are
> > concerning?
> >
> > - You're not adding a field in the net_iov that tells us how big the
> > net_iov is. It seems to me you're configuring the driver to set the rx
> > buffer size, then assuming all the pp allocations are of that size,
> > then assuming in the rxzc code that all the net_iov are of that size.
> > I think a few problems may happen?
> >
> > (a) what happens if the rx buffer size is re-configured? Does the
> > io_uring rxrc instance get recreated as well?
>
> Any reason you even want it to work? You can't and frankly
> shouldn't be allowed to, at least in case of io_uring. Unless it's
> rejected somewhere earlier, in this case it'll fail on the order
> check while trying to create a page pool with a zcrx provider.
>

I think it's reasonable to disallow rx-buffer-size reconfiguration
when the queue is memory-config bound. I can check to see what this
code is doing.

> > (b) what happens with skb coalescing? skb coalescing is already a bit
> > of a mess. We don't allow coalescing unreadable and readable skbs, but
> > we do allow coalescing devmem and iozcrx skbs which could lead to some
> > bugs I'm guessing already. AFAICT as of this patch series we may allow
> > coalescing of skbs with netmems inside of them of different sizes, but
> > AFAICT so far, the iozcrx assume the size is constant across all the
> > netmems it gets, which I'm not sure is always true?
>
> It rejects niovs from other providers incl. from any other io_uring
> instances, so it only assume a uniform size for its own niovs.

Thanks. What is 'it' and where is the code that does the rejection?

> The
> backing memory is verified that it can be chunked.
>   > For all these reasons I had assumed that we'd need space in the
> > net_iov that tells us its size: net_iov->size.
>
> Nope, not in this case.
>
> > And then netmem_size(netmem) would replace all the PAGE_SIZE
> > assumptions in the net stack, and then we'd disallow coalescing of
> > skbs with different-sized netmems (else we need to handle them
> > correctly per the netmem_size).
> I'm not even sure what's the concern. What's the difference b/w
> tcp_recvmsg_dmabuf() getting one skb with differently sized frags
> or same frags in separate skbs? You still need to handle it
> somehow, even if by failing.
>

Right, I just wanted to understand what the design is. I guess the
design is allowing the netmems in the same skb to have different max
frag lens, yes?

I am guessing that it works, even in tcp_recvmsg_dmabuf. I guess the
frag len is actually in frag->len, so already it may vary from frag to
frag. Even if coalescing happens, some frags would have a frag->len =3D
PAGE_SIZE and some > PAGE_SIZE. Seems fine to me off the bat.

> Also, we should never coalesce different niovs together regardless
> of sizes. And for coalescing two chunks of the same niov, it should
> work just fine even without knowing the length.
>

Yeah, we should probably not coalesce 2 netmems together, although I
vaguely remember reading code in a net stack hepler that does that
somewhere already. Whatever.

--=20
Thanks,
Mina

