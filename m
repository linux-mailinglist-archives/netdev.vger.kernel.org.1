Return-Path: <netdev+bounces-228958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC246BD6692
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9AB406833
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A72EE5FD;
	Mon, 13 Oct 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsqipJ1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEF2D6E44
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392412; cv=none; b=L1xRZlOR0hxJ2F+Jqgh74lwASM4fbpvtYqwnGa82xjKrH+csB6oA/JCj41sE43mT/3wEroXGefI39uERRrfXLJq1JbcxE96lMlIfAzT3n+HHKQCeOz/wcQ/FDBLshSItpXvQQb1YGDSxp2wmKDHfRtyfyk+a3za/0MmB06bWqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392412; c=relaxed/simple;
	bh=9m4/eG8svGsFedcJvUujwH5oWnPa6sBX3Cx2rq+yV50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUDat+2lBJl+tu+0mQVNGNfLAglcYSMUQYGEF0ofcEJPlVwMZS1DRvm6mNXQs7gLEDpwBEZf2pOb3Cf1QBwrTG2s/QYFtmn3QaPcuIlj9ae6f4h90Z4O4Zwzvo5Ds6Yw0P6t2s18LTpWc7oCvkhdsVTsKIpmcuvIKEtNakn9jGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsqipJ1X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso41118175e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760392409; x=1760997209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eznQkcbVB5NzB/bIiJpDdx0jzlo0Dnq+XZ627uhHJTw=;
        b=LsqipJ1XQAbswJGaQA2eAPWHjtbKmoCi52/Aw/NqGZ+ep3zn1rGm6PL2uR/rUrq1tQ
         QFpHR8iiUsGIOforU8uAx104KqoeCOSMyqbKlfDsTDEh3qlj2uWYsdmPWwL9UVEQ7EDM
         nKxkgezMAiuakc3+Y4CkuV6T0LaeykBHveL3GQk3qt6HkdnAKd6KT6SqeOKCzeMoMe9b
         TYn/954rfacURtSgC9Vwa9wXs9JpaI6lcbh4XT/YT5OEO23qe0wOK9EfXavg+dkgcoOn
         KiNavDlXIeMHMBIHlqDDBdlSP8heYB5LEkVAk3g/J6G2mNDHk1/0UtnGrpDAa3yWGD2+
         azUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392409; x=1760997209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eznQkcbVB5NzB/bIiJpDdx0jzlo0Dnq+XZ627uhHJTw=;
        b=pqyuo5QpzOwDl3xeLWC8e+V11LAlYoCPBL7D8tZHq4bN9SvR8E7tXsXl1MNW7Z1Dux
         aMLclS/60i452pP3Ah4K+wmOFMoivbEb4lOYT5TuEYYzKa7WFZj2/j3huI7puJ0/KBQZ
         Dm9nwUbE4G+Y3qpor7Gmqyan1eieRsMu8b+kvGYM6LVRXOLAv+EMdpB/UuIZ3FZz0FXi
         nDcAh+eJCoBXAn1QKKS0xwwhEhXLbo5C56+fBdzLqO7BqtbhiJb3gjf3PA2A1nazkvlW
         2BxpdtaZRAaZTYb4jfCAeyy80LisMWsXdv6vSGqWrFw3tATYuE8kh991Flmy5dIT/wnd
         WH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVHGBaBdcOsoqnItoq2/0wneZCqWF1UuPhlOzQqbBG65Mk7LSGoJ2g1XW2OI75tUKsoCnqI944=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyxfhQIzglBOtzvYEu2Z8P5PfJlPSVGoqprtDepRUKOSc61j6
	rOmoiDXal4vmHC0u3XirfqgCQjKuA3FqZLObQTYd0YB7OtnKtHSFYp9G/r46YCvmlQiUukAeZHh
	0mljvEWVVDjiGQ+5/Fk/hVznoEBZJ3cA=
X-Gm-Gg: ASbGncuIpwzUClGBRpSd7rQ482djPptXtoRTYel+xi7SCGh42rH9o8k6Z1ptCzMdddo
	vL6qnkcISLAvJyf/uhcV8QuCyuhX+pmGvdFtdCrCDSIEPa3vMnD6VzrEQ7wHjcTvmzWB3HS5Vw0
	Zh3a9zQT97P8SoUK/dKmzsfkuTRX/dztXmwobwMivBl4f3t2EHsdT9flXtYQFFKa7z24C0M18c+
	Pp9hthwO/STu5PtFWyvZxNGufSPRkS5yfAVjXUKU7/dut0tQPE27lKlZeI=
X-Google-Smtp-Source: AGHT+IHjZPYSx/MFnDGMSVq+/lL2r95iSzOO5aOtH3FWckuHrmP+/J89/qhEWOR5QTdySxp5tyYSKjZsZl0Qibs5c9g=
X-Received: by 2002:a05:6000:4283:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-4266e7ce955mr15411285f8f.3.1760392409074; Mon, 13 Oct 2025
 14:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <dhmafwxu2jj4lu6acoqdhqh46k33sbsj5jvepcfzly4c7dn2t7@ln5dgubll4ac>
In-Reply-To: <dhmafwxu2jj4lu6acoqdhqh46k33sbsj5jvepcfzly4c7dn2t7@ln5dgubll4ac>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 14:53:17 -0700
X-Gm-Features: AS18NWCpJ5cNadN1PuP9X6HpkCgMz2QoMAjad8BXEm_SW3mlUtmGRuLdphkG_3M
Message-ID: <CAADnVQKEhfFTSkn6f_PJr6xMcjB4d45E_+TsU6+945f2XD1SmA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>, 
	Harry Yoo <harry.yoo@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:35=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Oct 13, 2025 at 08:30:13PM +0200, Vlastimil Babka wrote:
> > On 10/13/25 12:16, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > On phones, we have observed significant phone heating when running ap=
ps
> > > with high network bandwidth. This is caused by the network stack freq=
uently
> > > waking kswapd for order-3 allocations. As a result, memory reclamatio=
n becomes
> > > constantly active, even though plenty of memory is still available fo=
r network
> > > allocations which can fall back to order-0.
> > >
> > > Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static=
 key")
> > > introduced high_order_alloc_disable for the transmit (TX) path
> > > (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> > > allowing the TX path to fall back to order-0 immediately, while leavi=
ng the
> > > receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> > > generally unaware of the sysctl and cannot easily adjust it for speci=
fic use
> > > cases. Enabling high_order_alloc_disable also completely disables the
> > > benefit of order-3 allocations. Additionally, the sysctl does not app=
ly to the
> > > RX path.
> > >
> > > An alternative approach is to disable kswapd for these frequent
> > > allocations and provide best-effort order-3 service for both TX and R=
X paths,
> > > while removing the sysctl entirely.
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Simon Horman <horms@kernel.org>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Brendan Jackman <jackmanb@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Zi Yan <ziy@nvidia.com>
> > > Cc: Yunsheng Lin <linyunsheng@huawei.com>
> > > Cc: Huacai Zhou <zhouhuacai@oppo.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/net.rst | 12 ------------
> > >  include/net/sock.h                       |  1 -
> > >  mm/page_frag_cache.c                     |  2 +-
> > >  net/core/sock.c                          |  8 ++------
> > >  net/core/sysctl_net_core.c               |  7 -------
> > >  5 files changed, 3 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation=
/admin-guide/sysctl/net.rst
> > > index 2ef50828aff1..b903bbae239c 100644
> > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on=
 a per-NAPI list. This
> > >  list is then passed to the stack when the number of segments reaches=
 the
> > >  gro_normal_batch limit.
> > >
> > > -high_order_alloc_disable
> > > -------------------------
> > > -
> > > -By default the allocator for page frags tries to use high order page=
s (order-3
> > > -on x86). While the default behavior gives good results in most cases=
, some users
> > > -might have hit a contention in page allocations/freeing. This was es=
pecially
> > > -true on older kernels (< 5.14) when high-order pages were not stored=
 on per-cpu
> > > -lists. This allows to opt-in for order-0 allocation instead but is n=
ow mostly of
> > > -historical importance.
> > > -
> > > -Default: 0
> > > -
> > >  2. /proc/sys/net/unix - Parameters for Unix domain sockets
> > >  ----------------------------------------------------------
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 60bcb13f045c..62306c1095d5 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -3011,7 +3011,6 @@ extern __u32 sysctl_wmem_default;
> > >  extern __u32 sysctl_rmem_default;
> > >
> > >  #define SKB_FRAG_PAGE_ORDER        get_order(32768)
> > > -DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
> > >
> > >  static inline int sk_get_wmem0(const struct sock *sk, const struct p=
roto *proto)
> > >  {
> > > diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> > > index d2423f30577e..dd36114dd16f 100644
> > > --- a/mm/page_frag_cache.c
> > > +++ b/mm/page_frag_cache.c
> > > @@ -54,7 +54,7 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
> > >     gfp_t gfp =3D gfp_mask;
> > >
> > >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > -   gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> > > +   gfp_mask =3D (gfp_mask & ~__GFP_RECLAIM) |  __GFP_COMP |
> > >                __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >
> > I'm a bit worried about proliferating "~__GFP_RECLAIM" allocations now =
that
> > we introduced alloc_pages_nolock() and kmalloc_nolock() where it's
> > interpreted as "cannot spin" - see gfpflags_allow_spinning(). Currently=
 it's
> > fine for the page allocator itself where we have a different entry poin=
t
> > that uses ALLOC_TRYLOCK, but it can affect nested allocations of all ki=
nds
> > of debugging and accounting metadata (page_owner, memcg, alloc tags for=
 slab
> > objects etc). kmalloc_nolock() relies on gfpflags_allow_spinning() full=
y
> >
> > I wonder if we should either:
> >
> > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > determine it precisely.
> >
> > 2) keep __GFP_KSWAPD_RECLAIM for allocations that remove it for purpose=
s of
> > not being disturbing (like proposed here), but that can in fact allow
> > spinning. Instead, decide to not wake up kswapd by those when other
> > information indicates it's an opportunistic allocation
> > (~__GFP_DIRECT_RECLAIM, _GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC,
> > order > 0...)
> >
> > 3) something better?
> >
>
> For the !allow_spin allocations, I think we should just add a new __GFP
> flag instead of adding more complexity to other allocators which may or
> may not want kswapd wakeup for many different reasons.

That's what I proposed long ago, but was convinced that the new flag
adds more complexity. Looks like we walked this road far enough and
the new flag will actually make things simpler.
Back then I proposed __GFP_TRYLOCK which is not a good name.
How about __GFP_NOLOCK ? or __GFP_NOSPIN ?

