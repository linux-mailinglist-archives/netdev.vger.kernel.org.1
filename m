Return-Path: <netdev+bounces-122982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B196355C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779011C21A41
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51E1AD9D0;
	Wed, 28 Aug 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wusxySzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C92165EE4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887572; cv=none; b=d6DCI8KpqW7Qd83h5EN73fGzuPiNIrh51ObwJxfUgVqsxnLSqHJIBHjljWzOdpG4oelmfSmpllzIQhnpNG3Fe1SCe81Hk3gN3XxQmjLOLvRoabevT8bpt0Dr2tjOpu9qhOVS24KZ92QgnWSmvZUXY1PIPz/mGtJ+9HZ9FxyFZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887572; c=relaxed/simple;
	bh=DPNMirW0losS6hO+yjyi/VL0g2LS26nVNTJ4rb5+psk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoZAdm3TrYHSuMXSt1R8ZnAl2PgfuJj+3GL6bpjKK1Cc3tysLNyl3bmnggDLdjSlXZHMPrdKtDCVCPL3KW+nDecOAXSKVDy0HSmLOz8yRo8ANQRsomYRY1KHKz5aiDKJmCP+09ib5yh3fUXW4rctUTpOMvGbVl9unvj5bpviVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wusxySzJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371c5187198so16169f8f.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724887569; x=1725492369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsEnXmXmh28jAN8ip/UVLuy7v0nDD76ZYh++ZDSbnAA=;
        b=wusxySzJNZC3a7caNI4FbweDIMpnDkOOvr5/lTEOZwckAbL7U9934aJQRgEx6ZK7X7
         LvjKKLa6G6KYy4tM5dljn3V0+Rrx0IhicU7h3tvkAwTE96JwMTYpr6iXkvwZ3UCDWBxa
         /WEdLYyIFSv+Lk4/J/SmTDs3DJ7U5hso7f7jukJ+fT9TaMDidrhg5vCyG3lbnqTx9Ydd
         zFsgTyDViKK0wCRteNtmIA+ixNlpe/5HEo0LUPa0N05v9JGmMZerx1k9vOYOkjwFEjw4
         plkAQvjleHHWPkHW5cwzsqQIcF/tSlVXt9UWpPU0+CIIslz/K/7Q1hCT6yFgjYNCrUKe
         uJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887569; x=1725492369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsEnXmXmh28jAN8ip/UVLuy7v0nDD76ZYh++ZDSbnAA=;
        b=jGd4Un+Xajk6r8bR7i15J2Kg6GeYao06itDo3/jMLed7q04EfHIi0LIlvq5CWq6+oD
         Q8DHAOFp8dGX9qefF9bNP2f7O900iEZUwLkMfmbnI+J1pU1sJ2ltYVgGZ1EorCLzYDB/
         Ms1V7C6OFKWJjzIyoDxRH7Xa4is7TfqmZndsvubCRZ4l9g2LQmQhLpS7mXRgOPfAZgXf
         3acDUcU9TRTPbZT54H+n7aJhmyLykQ9jU4hXKtVXvjKcjIqmZOn221O+ArT4PpUptPSW
         Io4wSycq4PdwUPdtwv9aGH9qPPr/hTCCopKCzNJI1u3hITP8YTJoKQ4FXriDywQrMu24
         x5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWXE/rD0f7e4FpPxic9SZKI1DumyBQUedyqADfOUDS5Ntr93wOKU56fZXz7cogJfSwoMsqJ4fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyCiA8hzpMmPE9oPtNKJ2N++XLC4iotocqPW6a/r3NrxAX7Ib5
	Jk9x9tfUeD2BiYuIfaLwXbAD8oJcaalVHD/oIcg5VuEBAgCmofdNc6no7Nedkm79X86DboLHUSK
	cFJKe4PHsgd4rSgP+9JZp8FYM5JJkf2OX0MyC
X-Google-Smtp-Source: AGHT+IG5pCwLAoU4sKd/3zRhMlUJ8Wa1316EqcrRN4NtvrZ9INECIPWtXhcYlljVv8GYF5umbGN/AMY7d9HWlHTWyfk=
X-Received: by 2002:a5d:6188:0:b0:367:bb20:b3e1 with SMTP id
 ffacd0b85a97d-3749b585e8cmr613778f8f.51.1724887568192; Wed, 28 Aug 2024
 16:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
In-Reply-To: <20240827235228.1591842-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 16:25:30 -0700
Message-ID: <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> At the moment, the slab objects are charged to the memcg at the
> allocation time. However there are cases where slab objects are
> allocated at the time where the right target memcg to charge it to is
> not known. One such case is the network sockets for the incoming
> connection which are allocated in the softirq context.
>
> Couple hundred thousand connections are very normal on large loaded
> server and almost all of those sockets underlying those connections get
> allocated in the softirq context and thus not charged to any memcg.
> However later at the accept() time we know the right target memcg to
> charge. Let's add new API to charge already allocated objects, so we can
> have better accounting of the memory usage.
>
> To measure the performance impact of this change, tcp_crr is used from
> the neper [1] performance suite. Basically it is a network ping pong
> test with new connection for each ping pong.
>
> The server and the client are run inside 3 level of cgroup hierarchy
> using the following commands:
>
> Server:
>  $ tcp_crr -6
>
> Client:
>  $ tcp_crr -6 -c -H ${server_ip}
>
> If the client and server run on different machines with 50 GBPS NIC,
> there is no visible impact of the change.
>
> For the same machine experiment with v6.11-rc5 as base.
>
>           base (throughput)     with-patch
> tcp_crr   14545 (+- 80)         14463 (+- 56)
>
> It seems like the performance impact is within the noise.
>
> Link: https://github.com/google/neper [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@lin=
ux.dev/
> Changes since v1:
> - Correctly handle large allocations which bypass slab
> - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
>
> RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@li=
nux.dev/
> Changes since the RFC:
> - Added check for already charged slab objects.
> - Added performance results from neper's tcp_crr
>
>  include/linux/slab.h            |  1 +
>  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
>  net/ipv4/inet_connection_sock.c |  5 ++--
>  3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..05cfab107c72 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *=
s, struct list_lru *lru,
>                             gfp_t gfpflags) __assume_slab_alignment __mal=
loc;
>  #define kmem_cache_alloc_lru(...)      alloc_hooks(kmem_cache_alloc_lru_=
noprof(__VA_ARGS__))
>
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>  void kmem_cache_free(struct kmem_cache *s, void *objp);
>
>  kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..8265ea5f25be 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2185,6 +2185,43 @@ void memcg_slab_free_hook(struct kmem_cache *s, st=
ruct slab *slab, void **p,
>
>         __memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>  }
> +
> +#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
> +                     SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
> +
> +static __fastpath_inline
> +bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +       struct slabobj_ext *slab_exts;
> +       struct kmem_cache *s;
> +       struct folio *folio;
> +       struct slab *slab;
> +       unsigned long off;
> +
> +       folio =3D virt_to_folio(p);
> +       if (!folio_test_slab(folio)) {
> +               return __memcg_kmem_charge_page(folio_page(folio, 0), fla=
gs,
> +                                               folio_order(folio)) =3D=
=3D 0;
> +       }
> +
> +       slab =3D folio_slab(folio);
> +       s =3D slab->slab_cache;
> +
> +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> +               return true;

Taking a step back here, why do we need this? Which circular
dependency are we avoiding here?

