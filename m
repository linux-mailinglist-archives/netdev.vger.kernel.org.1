Return-Path: <netdev+bounces-227234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C378FBAAC59
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F017EC49
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F638D;
	Tue, 30 Sep 2025 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk8H/caq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6F1804A
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190708; cv=none; b=Vuzxqc8j87x7RNXKvzmGZq9xGD40AFnqS8nui0AU6GcAh0e0hiw/oj8edtte2cdIa5rRIVqLV9sMHti1Rs8C+VV1fuxOvFCQfoZ1eat84VvZJdS9+nI836LWXgfL0CKDJWFICjcNJDS3AeAtRT9DB1hTa72be2NfyGWn2Yova0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190708; c=relaxed/simple;
	bh=eqf16crL2XW08zq3x3lWA9vUBQ8Q2HiZK/siA2rTqhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qroO2yVpuK+wzUmlh8ic44Uskuv5YHlvS45sOcJMBx5DZJljJMy5uGzM1bt+11Ed43ri/u6HsZmlS3bkL5PnkbG3qk29KkCZniB3u22UmYHg9mzNpkoj5d8tnCssJA3xRS6yaQPjoaGcLs+WgH22F/twMRX8s3Sl3hsXcWkx7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk8H/caq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-587bdad8919so3880e87.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759190705; x=1759795505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTFYa5j3Us4Va0xzYEn1WzVmgM5S4ZHh6Nsw7evNDJg=;
        b=yk8H/caqqSj4he5vGTvMni0yvh+krjvYdQrkAGjt1VTjziEXk8bsHG4nrUWi/6i0av
         qOrBH6fujCpI2kA6tlhCopfgIMWKMUlIysUTh5cidJAxsDwEhk+Q5eoopZIqJgxoNa/D
         9dqDd+6OW6NvrU611AOSqeLsGc9WXh0dVkFMw6GeP/YfBEEAg5zlmmJP82xi3pxvzvgy
         nRcaxG0wPhOU8WdAZ4h/bGjz50AmBgLOs3wGBONdng55TpySJRt9+ahg+1NK5hTvytU5
         RWhtRxzLNVBaJO4y7HNIpeFZ9DpzSyEjiK71h/kCd8gsHqjmvueWDNbP1GHw2HPEVZT+
         uTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759190705; x=1759795505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTFYa5j3Us4Va0xzYEn1WzVmgM5S4ZHh6Nsw7evNDJg=;
        b=nbgjz+tPi9dnk7DZoxC94o0ktSqdPAbPAGEKjTlCZ1mhGe26BK6el4YMZHEYjvH6Ak
         7F3N2KP+JC5WaSkH6/9uwYRo6CiS/mQYLqXN37JfXK3FPx1Iu5k7IarAiU3G2xtcPi45
         S6ix8KV1SOrm7pd6RlPx3U6KlLMvDknElV81CDqOFJG8SUWre3aY4iOct3jkHTC17uN6
         1T0z1vbOklbUf/wSxbPINPdA5NBxtM92032kwxu/IzVPZNhUzclIaoT1kOfHLbaXJKtt
         so6l+SiiNn1ld44IXijXsqpzDeI68E2JKfSZBEMLSrp1tMBKdZaF91dl8LoPMIKze4ej
         Ybtg==
X-Forwarded-Encrypted: i=1; AJvYcCVbJn5+awoQMvfwe2QV2Qxg/Qp7clF/6LuZCrVdOdiBLEOKimERw4nx0kTRIi5AwqyOS6Y2xWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiHqt/jgZtFCVxeHWc1N4a01F6FPgFBl6Jv9pFMseLoapEODq
	TNXBH5mBUZw1lFqa+VDru2FVOmu4w/ne2pnR85ejGlXLedOWDOjW8BxJ67Xg1uR4jSekeimAmlc
	dKNlxruKgtymIaRBma7bZKVXZ7wHc1wBjd5rVX6c2
X-Gm-Gg: ASbGncvx0z9UzQ8vqbt9YkYeyRT9gpJFApPTvDtHAMK1vAXqhkjAQAn4fCByWokbesC
	f10ZBICA9QM5JWSuUsMOROL7bjxp++O/25iizyNxS4Qs7EbRQPclOldEkBE2wqnDn2wRdO8T+aI
	nWsWqFfnSJtX8+KerB4fd+mWOPRnWSufmRl0l218/eie9XgMrEuv34igd9buon4y6k8llrzcphB
	fE50qNZl4Y4+HmPeH/oKEyXeT0tC7lH5YGypc2X6r5RZ85dIseRpY5TZHN1qfKWgCIDAB1SCL9U
	uFk=
X-Google-Smtp-Source: AGHT+IGIu6ZfUFC6831kj/kQZIrUVyEtrf6F1rhZW2LGImkBg3bJpbAXTgFFPJ3huPmnaWNhKXDuheNSSUczIVpSXDs=
X-Received: by 2002:ac2:43ad:0:b0:579:78f4:9c37 with SMTP id
 2adb3069b0e04-58a96682e41mr102373e87.7.1759190704260; Mon, 29 Sep 2025
 17:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926113841.376461-1-toke@redhat.com>
In-Reply-To: <20250926113841.376461-1-toke@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 29 Sep 2025 17:04:51 -0700
X-Gm-Features: AS18NWBo6Spv6pqHnyjBYozErlOOQW4NN9hFr99N2o7oXA_HCtzRJ7sGtISz6UA
Message-ID: <CAHS8izMsRq4tfx8603R3HLKPYGqEsLqvPH8qfENFnzeB5Ja8AA@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, 
	Helge Deller <deller@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:40=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
> boot on his 32-bit parisc machine. The cause of this is the mask is set
> too wide, so the page_pool_page_is_pp() incurs false positives which
> crashes the machine.
>
> Just disabling the check in page_pool_is_pp() will lead to the page_pool
> code itself malfunctioning; so instead of doing this, this patch changes
> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
> pointers for page_pool-tagged pages.
>
> The fix relies on the kernel pointers that alias with the pp_magic field
> always being above PAGE_OFFSET. With this assumption, we can use the
> lowest bit of the value of PAGE_OFFSET as the upper bound of the
> PP_DMA_INDEX_MASK, which should avoid the false positives.
>
> Because we cannot rely on PAGE_OFFSET always being a compile-time
> constant, nor on it always being >0, we fall back to disabling the
> dma_index storage when there are no bits available. This leaves us in
> the situation we were in before the patch in the Fixes tag, but only on
> a subset of architecture configurations. This seems to be the best we
> can do until the transition to page types in complete for page_pool
> pages.
>
> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
> Sorry for the delay on getting this out. I have only compile-tested it,
> since I don't have any hardware that triggers the original bug. Helge, I'=
m
> hoping you can take it for a spin?
>
>  include/linux/mm.h   | 18 +++++------
>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 62 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..28541cb40f69 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4159,14 +4159,13 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long status);
>   * since this value becomes part of PP_SIGNATURE; meaning we can just us=
e the
>   * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), =
and the
>   * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_D=
ELTA is
> - * 0, we make sure that we leave the two topmost bits empty, as that gua=
rantees
> - * we won't mistake a valid kernel pointer for a value we set, regardles=
s of the
> - * VMSPLIT setting.
> + * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that value=
 is
> + * known at compile-time.
>   *
> - * Altogether, this means that the number of bits available is constrain=
ed by
> - * the size of an unsigned long (at the upper end, subtracting two bits =
per the
> - * above), and the definition of PP_SIGNATURE (with or without
> - * POISON_POINTER_DELTA).
> + * If the value of PAGE_OFFSET is not known at compile time, or if it is=
 too
> + * small to leave some bits available above PP_SIGNATURE, we define the =
number
> + * of bits to be 0, which turns off the DMA index tracking altogether (s=
ee
> + * page_pool_register_dma_index()).
>   */
>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELT=
A))
>  #if POISON_POINTER_DELTA > 0
> @@ -4175,8 +4174,9 @@ int arch_lock_shadow_stack_status(struct task_struc=
t *t, unsigned long status);
>   */
>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_I=
NDEX_SHIFT)
>  #else
> -/* Always leave out the topmost two; see above. */
> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2=
)
> +/* Constrain to the lowest bit of PAGE_OFFSET if known; see above. */
> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && PAGE_OF=
FSET > PP_SIGNATURE) ? \
> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_S=
HIFT) : 0)

Do you have to watch out for an underflow of __ffs(PAGE_OFFSET) -
PP_DMA_INDEX_SHIFT (at which point we'll presumably use 32 here
instead of the expected 0)? Or is that guaranteed to be positive for
some reason I'm not immediately grasping.

--=20
Thanks,
Mina

