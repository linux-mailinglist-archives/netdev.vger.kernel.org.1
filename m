Return-Path: <netdev+bounces-229037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6341BD75CB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8093E50FC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4C235041;
	Tue, 14 Oct 2025 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aKgu/lD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6821E500C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418490; cv=none; b=u4Xb1367aKFxZCBB2Bx/ihXPOLSI2vFOVLX3sKy2PHNXFfrKMf57r3yDLHKqbBIVUx1J46xl5KxI9+G/EphtMVMJshcsE1RW1wibN2wcQHoHgy7RaNix2N0r18Qo6zE60LC+ybLfwSmLkgmDF+qdxggfdxamdmRzrnLsJ1e+fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418490; c=relaxed/simple;
	bh=932RvO+/hs821ixBu+SCgqlcqoMNm2aId1K7SmkKHX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgXOtRB2L7mDxi4XlZTCEmN2ya/GmDCKVfdICSucxcneR56Ul3rTcVIB+qHBFD3qn8ObxxWQ6S8Yiz202B374Tr6qGkQFS+MM9tNm4E0INQxFIVQTSjmOf0zXKtA0m9+WjJ5B1z1zD3W7K8g4e7ObAglX4nrYg43j/oaxCDUjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aKgu/lD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-854cfde0ca2so1027289485a.3
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760418487; x=1761023287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5JkuuVSayA8Ofu2uznRObRn+eA97FQhk4dZT2qKwso=;
        b=0aKgu/lD6fAoextUtvtm+M5Bn3PtLhDN4NvSNEZrlGVfDKYtHO3Ucb7TSSmfVItlX0
         baEmLvVThX+a+n4Ny5TfuYHgQjfyqCk/CPUUSuCIfKUZwe8ggBbHE7v5IHgWCOXi3JWp
         SC+9jR0xcOKz4v8B9tVF15XWwhxV4pt0uJ239ZebS/d3KAHmztNAupJDJmJ+i8VoUTON
         WEUOumgOHc+mfL6OGGgWsnOsOz+djDYaHl8pFm6UZzHmCQN8br30RqOXDSADzYQXtwwf
         1fLT8cniKziQ0xkrQHbmyaT2ZyLQJf8GHLWpXx+KtCR56fK+N/2BeTry/MwxEEmidtWr
         gF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418487; x=1761023287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5JkuuVSayA8Ofu2uznRObRn+eA97FQhk4dZT2qKwso=;
        b=H8gcgyO2/s0Ki8wKMxxXguLZ+sQhQfMACRn7jFgZ+mLYHmQaWO7Gh1GXsuTz5wvMmM
         Eq+s9m2uBFiBIdsnapamAsC96b9ZP3DrisnXPKSCDgH/x/kz7D8UoeOx4hEL6MoCq3XY
         xdECOU+++GtJF8ngAebs+i/5S7mKGhB9P1M+ZmirxFXSycgQTfbq1NMZkCmePgw9wqF9
         c/qYwAtqtW+MGRjnSELqVdv9fi3F/CVuq0Y5DzFwlt7tACUCi5IBhj7rdDC6B5Q3yUB/
         QpLmq4oCOiN+X/cd1Y07lJdCxR0zu61IIU9D/o3BWAs5/jdVvcJaoExR9k4QFFGoNIS+
         r/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWjZrIWA6/rq5ZzLU05/oxrEFqs39qi5Ij5Q9Bmnn+xVztVNo/0NFGvZl9fuYzLyNLxucyu5fI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/NE9wjDC2yzzea8B3YJqKqbHckg+OJtDpLKyOIF4tvFXiJuA
	H1mQ88Adp72Vx7RnK2u2C/fikdrDTr4m2wm5u2hGF+IOg6+wHtOe3uDbsXWaZdcqVFeTdPBxXAN
	YhujfsqUuKCFtBg/ZyobpocGTzm2Zku4ggeep/9HT
X-Gm-Gg: ASbGncvgbx+57xU70T97RnwxzrrAjZ3rXULb0VA/t7Gy2urii43SEMWUw1u3N+8sgP9
	TfECTODvaGG1iWL4xEwQOOQMg2RpaoKqkrgNp8O73WgzoSSNMaYiv7j2NgUH1KUB2GruaiSLhCa
	uRauaqWkYOQAUI+/chKDXB8Im9nTL1XZElLO8aVGn3gug4vRzkwLXEIJrPTmnLFRLTrrPRfxqn1
	vah7RCjfd+nNbdzItXVcIyrBnb5Npdz2J7Z5mEwzgw=
X-Google-Smtp-Source: AGHT+IG/8aE+aHcI9fnIx7BC8BEsSWywbVC7oJ9GTxoNgoK6tWmthKLsGkvfKsZG/szhyaZle3TfMxlghiUG7vn+aPI=
X-Received: by 2002:ac8:7dc7:0:b0:4e7:1f14:c30c with SMTP id
 d75a77b69052e-4e71f14c405mr115414241cf.69.1760418486272; Mon, 13 Oct 2025
 22:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
 <20251014035846.1519-1-21cnbao@gmail.com>
In-Reply-To: <20251014035846.1519-1-21cnbao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 22:07:55 -0700
X-Gm-Features: AS18NWCWxB4_7MksVcSk_C7g7SO9YHjPuxXQz_zjkiBQ0xejWPMAGosiT_EXkB8
Message-ID: <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, hannes@cmpxchg.org, horms@kernel.org, 
	jackmanb@google.com, kuba@kernel.org, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linyunsheng@huawei.com, mhocko@suse.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, surenb@google.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	willemb@google.com, zhouhuacai@oppo.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:58=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
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
> >
> > The sysctl is quite useful for testing purposes, say on a freshly
> > booted host, with plenty of free memory.
> >
> > Also, having order-3 pages if possible is quite important for IOMM use =
cases.
> >
> > Perhaps kswapd should have some kind of heuristic to not start if a
> > recent run has already happened.
>
> I don=E2=80=99t understand why it shouldn=E2=80=99t start when users cont=
inuously request
> order-3 allocations and ask kswapd to prepare order-3 memory =E2=80=94 it=
 doesn=E2=80=99t
> make sense logically to skip it just because earlier requests were alread=
y
> satisfied.
>
> >
> > I am guessing phones do not need to send 1.6 Tbit per second on
> > network devices (yet),
> > an option  could be to disable it in your boot scripts.
>
> A problem with the existing sysctl is that it only covers the TX path;
> for the RX path, we also observe that kswapd consumes significant power.
> I could add the patch below to make it support the RX path, but it feels
> like a bit of a layer violation, since the RX path code resides in mm
> and is intended to serve generic users rather than networking, even
> though the current callers are primarily network-related.

You might have a buggy driver.

High performance drivers use order-0 allocations only.



>
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d2423f30577e..8ad18ec49f39 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/page_frag_cache.h>
> +#include <net/sock.h>
>  #include "internal.h"
>
>  static unsigned long encoded_page_create(struct page *page, unsigned int=
 order,
> @@ -54,10 +55,12 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>         gfp_t gfp =3D gfp_mask;
>
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -       gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> -                  __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> -       page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> -                            numa_mem_id(), NULL);
> +       if (!static_branch_unlikely(&net_high_order_alloc_disable_key)) {
> +               gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_=
COMP |
> +                       __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> +               page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDE=
R,
> +                               numa_mem_id(), NULL);
> +       }
>  #endif
>         if (unlikely(!page)) {
>
>
> Do you have a better idea on how to make the sysctl also cover the RX pat=
h?
>
> Thanks
> Barry
>

