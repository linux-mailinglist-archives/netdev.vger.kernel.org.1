Return-Path: <netdev+bounces-128245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D98978B5C
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002471C21D69
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD6158538;
	Fri, 13 Sep 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nf5G/WUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7B155CBF
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266220; cv=none; b=rWcWsrjlSb25+dewxpvjCmFyXiG4pugoxX48aVTOXAmRjrC7e39LfqmbXiXDuag8jmUiGzVwcVpBeiQv08IK4KOcci7pnHlSdJJ3y+bK7VbluRrvUlFCqurRPDZ5dd87f+xSV3G6tHlVZm5pKFl3L9HxsLoIHcdjcpXD/IGbIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266220; c=relaxed/simple;
	bh=8XDxKfnE4f6ZNHCbw/Ar5LgDExZsWgFcsROXUnVV87c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnXCDBbLsFIxO4nz+4deT3ppMVK9Aipa9SgRd5N7vwzLGbBGtzK31YJDlaPSdKq7nNO/1pU1NCzEOaCRCwwcAck3xZh083Ba0p+4JgyJ8yK1fPi8EYq1k9/44PJNULkNIsBfwFKsl0SDAMxK3bkeIhlWuLu2yjIUI1RPOMDzm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nf5G/WUa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582b71df40so35191cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726266217; x=1726871017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqqyM6e9cpYbtlo2tWfzei5AGAvl9ob43ovRmyypuYs=;
        b=Nf5G/WUaXJpSgWwrhf0v5ilQ4diXqKjHIGSntopvu3x41Y0Gxa5lJgcPvg/IgkrBhB
         S51YC+w2YLzo5y8pMy+Hd0ViWVHarBSmxV8sB3VvLg6wvMeA3Y6Ps3sYuZcd9hv2EJAR
         0zFXZN99+3arNYaiBPOvrwFMq9gWwyF0gaFbKhVxK+fyLuWkyR1r0Sd18lvTZrDh0N+R
         6rl2Mdy4Ey8myBpjC4P3XF4eFgoyyJIWz/YMTsDps356n8mqrYPULnFz2aeF7bW5tTzt
         pUhEx6ifJn8rV9n5osXsurlC8mM85hGTKDzq80qDFPJ1y1R84NydVcWgTvpTuQ4kFK30
         Qmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266217; x=1726871017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqqyM6e9cpYbtlo2tWfzei5AGAvl9ob43ovRmyypuYs=;
        b=NnbTq+4hFlkBgouy5vWimDysxBiQq2CfbwpEXVkfZM3AK3Rwy63wQyJekD8sMgr3Dl
         rVMHHAbeqFqE/m4Ea1Sfha1WbVFOlxCXODlH+HfJAiOd16CjNfzYpB4wAVDkKr74ORmz
         QdRXQA6JLllYEzZe3v7wsIqjDnOw8DbiWGGhSSj6h54UFK79eFs/EEBPNNRM2Sx84Ysl
         A8+IWEoJq51SxAVFU6dkY2+NGTtbcc6OdZyGEHuk59l52ymWYznJloDf7KIS8ur/wdW8
         MAoUyppkgbBp4QzwkstHqYUH8JlkCjK+Aw77InoBkhX8CeG49pl6Xzc0cahLOs/Xiwm+
         B8MA==
X-Gm-Message-State: AOJu0YzVFbHBkF16xGq8df3f4wgCuO6by9huHko18ztlbikOOKB5/elQ
	rIHIp6+vczUv5O7x5k5DXZMDknX6gdkj6IDXIp50T3fF4Lug436qDWId4m1rbEzjEJhM5QD3wiV
	XE6GGrR6J3vp3L9ow6lXRVFGTnl+EMPPW/Ewa
X-Google-Smtp-Source: AGHT+IFnKX/B3cqJDC/JWovLKRmYSwF/IsdRdB5Egzrid1jjZiPb9OcqTMWDL6pk/cxRtNKG6BhhmgB+oQUm5lTqrG4=
X-Received: by 2002:ac8:5782:0:b0:453:58b6:e022 with SMTP id
 d75a77b69052e-458608844demr10344731cf.28.1726266217155; Fri, 13 Sep 2024
 15:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213351.3537411-1-almasrymina@google.com> <ZuS0x5ZRCGyzvTBg@mini-arch>
In-Reply-To: <ZuS0x5ZRCGyzvTBg@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 15:23:22 -0700
Message-ID: <CAHS8izPthEJJX1yRenCjGeU9s6dgbfRE+pMZvcxfnMMC5kD9iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: fix build on powerpc with GCC 14
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 2:55=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/13, Mina Almasry wrote:
> > Building net-next with powerpc with GCC 14 compiler results in this
> > build error:
> >
> > /home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
> > /home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is
> > not a multiple of 4)
> > make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229:
> > net/core/page_pool.o] Error 1
> >
> > Root caused in this thread:
> > https://lore.kernel.org/netdev/913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-=
soprasteria.com/
> >
> > We try to access offset 40 in the pointer returned by this function:
> >
> > static inline unsigned long _compound_head(const struct page *page)
> > {
> >         unsigned long head =3D READ_ONCE(page->compound_head);
> >
> >         if (unlikely(head & 1))
> >                 return head - 1;
> >         return (unsigned long)page_fixed_fake_head(page);
> > }
> >
> > The GCC 14 (but not 11) compiler optimizes this by doing:
> >
> > ld page + 39
> >
> > Rather than:
> >
> > ld (page - 1) + 40
> >
> > And causing an unaligned load. Get around this by issuing a READ_ONCE a=
s
> > we convert the page to netmem.  That disables the compiler optimizing t=
he
> > load in this way.
> >
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: David Miller <davem@davemloft.net>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Networking <netdev@vger.kernel.org>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v2: https://lore.kernel.org/netdev/20240913192036.3289003-1-almasrymina=
@google.com/
> >
> > - Work around this issue as we convert the page to netmem, instead of
> >   a generic change that affects compound_head().
> > ---
> >  net/core/page_pool.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index a813d30d2135..74ea491d0ab2 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -859,12 +859,25 @@ void page_pool_put_page_bulk(struct page_pool *po=
ol, void **data,
> >  {
> >       int i, bulk_len =3D 0;
> >       bool allow_direct;
> > +     netmem_ref netmem;
> > +     struct page *page;
> >       bool in_softirq;
> >
> >       allow_direct =3D page_pool_napi_local(pool);
> >
> >       for (i =3D 0; i < count; i++) {
> > -             netmem_ref netmem =3D page_to_netmem(virt_to_head_page(da=
ta[i]));
> > +             page =3D virt_to_head_page(data[i]);
> > +
> > +             /* GCC 14 powerpc compiler will optimize reads into the
> > +              * resulting netmem_ref into unaligned reads as it sees a=
ddress
> > +              * arithmetic in _compound_head() call that the page has =
come
> > +              * from.
> > +              *
> > +              * The READ_ONCE here gets around that by breaking the
> > +              * optimization chain between the address arithmetic and =
later
> > +              * indexing.
> > +              */
> > +             netmem =3D page_to_netmem(READ_ONCE(page));
> >
> >               /* It is not the last user for the page frag case */
> >               if (!page_pool_is_last_ref(netmem))
>
> Are we sure this is the only place where we can hit by this?
> Any reason not to hide this inside page_to_netmem?
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 8a6e20be4b9d..46bc362acec4 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -100,7 +100,7 @@ static inline netmem_ref net_iov_to_netmem(struct net=
_iov *niov)
>
>  static inline netmem_ref page_to_netmem(struct page *page)
>  {
> -       return (__force netmem_ref)page;
> +       return (__force netmem_ref)READ_ONCE(page);
>  }
>
>  static inline int netmem_ref_count(netmem_ref netmem)
>
> Is it gonna generate slower code elsewhere?

Yeah, I think it will likely generate slower code elsewhere, and
avoiding the overhead when this is the only callsite that needs this
really seemed like a plus.

--=20
Thanks,
Mina

