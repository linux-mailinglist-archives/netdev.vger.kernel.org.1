Return-Path: <netdev+bounces-227401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C249BAEC7F
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5711924DD0
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F8261B6D;
	Tue, 30 Sep 2025 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIuX6o5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409123C4F3
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275391; cv=none; b=Kzx6LzuaYAVYeMNAtYSHbkw/dmDWLisHXGtjaF7NHdT30nVPuNUes8uQsZBI3Z/amILWK91DPtKVB+Epovm4ejWpguFcdyt9OxlZbpFawiR2EWmMgZ0EN3Ck/1IJPTRxTLltK3YUydiM2DWn6mrCAlF1QYxyLKwMppsyHDQue+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275391; c=relaxed/simple;
	bh=z0fsIZfnV/2IhN4m/9m2JugiobRrcZVB3Di36W6eJ+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB66M+xcSSrVILznxvc2B26/Tl2i+RVUHTyoCdvhNYpMj0Vxwf62ZUHnWh+w1cTyO92JfuvvWwxtYdcYRKT9lAiUX7MENeNcsEJj/HE1FZIWOKNmcuJndAOhHiwFZlNmSfycti4EvQYikwvHD1GK0zIy4EfxjBmMiHXfgCo0mzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIuX6o5a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d97bac755so3712e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759275387; x=1759880187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzAGHoC3LCY9BMZcnX+2gQ2YcNS5UVNzJHOD3iXvnng=;
        b=hIuX6o5aLwQ+qMRFxb1cKkOol8t5j7HItxxl5J0XYuQT4uDF8OhEAcMkiz/Whh04S6
         PssAcIs24tdi0hkfJpOzYn5K1Qe81WEUPa1+yTKww75Mkx423gJQVTS5tGLqukin/Kh0
         1zg4lzWOrj1vLK796WrjsQ3XnNONwpVsFzuLXteAEtdqyjWXtSz/LRTAEO4bDaqAL5w0
         MEHAN65xjMhveRKBKuM7nDIGsJI+LZg7CcQ9vXc6VScGr+aQXwfE2TGTRqGLc750G7KU
         qxOKjUWqukxsHoZOuKh/wyrm48OCxMI2piCY7IjF2DgweUBfun2/CX+uga+uloDrNVEx
         AL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759275387; x=1759880187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzAGHoC3LCY9BMZcnX+2gQ2YcNS5UVNzJHOD3iXvnng=;
        b=d0UlZdKOg2ho615810gcLPeeNZ9Mp2E1F8KgEmeK7BuHz6v2wwRfbyqG3JBdZ4rJbu
         yVd8FbKQMi1l2LDbn71Y2zs4/ON4qCUel+LSQBJwPTT95P25Eb/w+dd6yazBcDydskGL
         Krua/qbutJo0XKqtnZvPE4YfW/0amCYkZQi7l6/xpt0p7TrTLmcpAcFefxWtBW9YYTpp
         yIQF1zoZ0u9LAdLcgNGkiiNl24B3XOnKq2Svylm8eDKdNoSExWW40sce/nfDDTSTgfWY
         J4X2UR7QMB8w4HwkHaXxUk7aYgtpL6MaMN8IHES/mMWLrhw+9KyGL2lsEX/5rGgsEH9b
         j2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcPTWvIvlg8nsaFZzTSzXk9n5UNvhV8FMAM0VjcJf0bAMJlzBKagjisu0CWY4w33ql1+bWIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n93bbMfVJxkkLpCMnSfZnZdZD9lkYf79IkXfQrHtjmfMCLSf
	PBqHhsMGt1SA5v0SJVpOz5NtKpCTKoXEV6SADa/DzJeMzSeRVkbtpz/CyZdbdZVtWgLVrzk/KfW
	FFkvj3p/Ibl39IK7dsrpDehPQqPZNrRRYn5rx60Gp
X-Gm-Gg: ASbGncuhL6nqdLZOTdycFMFSuLtrcb8l6RvtiOR6X7jZ4CA7Gy62ohtxPXX14byuNbu
	XJkLWV3oPrZnDtNA2uix5YkzIhfnmO359/pUAHZmlOVtYcJedcALfg0xgdXVrG3FIMOfHeiL2Te
	7GjzuR7K4JnavquGtA/z/ys5c9suue/wvsP3RiQ0u4Gr6wYPno2PjJY+u04Ql0Apyuk+azJsfOP
	lRdb/4jzmZnlF98Bnj/MP78KaecO8nB+xA4vaJXOYBbTBfE0ishq/7nioPKHmw4kGLMk5xFNnMk
	V04=
X-Google-Smtp-Source: AGHT+IFkc4IJjLwRN6BK7QqMPx6rU0WejItlxxFNvZ50TdxHWfIXW7DGWHWYtXgj2YsxQvYwGLGM181jyibNLaHKuC8=
X-Received: by 2002:ac2:490c:0:b0:57b:aa84:8b11 with SMTP id
 2adb3069b0e04-58afa3eb46emr129851e87.2.1759275386958; Tue, 30 Sep 2025
 16:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930114331.675412-1-toke@redhat.com>
In-Reply-To: <20250930114331.675412-1-toke@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Sep 2025 16:36:14 -0700
X-Gm-Features: AS18NWBXmtCuQg-Y2WOs8Fk6rwYNK6cExv_BH5QWhhlqrllaXyqnaMgGll4hTLc
Message-ID: <CAHS8izPGxvdDu7JwEWK2=fk=qHoYgFzOs1FjOWjmNwqrU2r0kA@mail.gmail.com>
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:43=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
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
> dma_index storage when there are not enough bits available. This leaves
> us in the situation we were in before the patch in the Fixes tag, but
> only on a subset of architecture configurations. This seems to be the
> best we can do until the transition to page types in complete for
> page_pool pages.
>
> v2:
> - Make sure there's at least 8 bits available and that the PAGE_OFFSET
>   bit calculation doesn't wrap
>
> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Cc: stable@vger.kernel.org # 6.15+
> Tested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/linux/mm.h   | 22 +++++++------
>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 66 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..0905eb6b55ec 100644
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
> + * small to leave at least 8 bits available above PP_SIGNATURE, we defin=
e the
> + * number of bits to be 0, which turns off the DMA index tracking altoge=
ther
> + * (see page_pool_register_dma_index()).
>   */
>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELT=
A))
>  #if POISON_POINTER_DELTA > 0
> @@ -4175,8 +4174,13 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_I=
NDEX_SHIFT)
>  #else
> -/* Always leave out the topmost two; see above. */
> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2=
)
> +/* Use the lowest bit of PAGE_OFFSET if there's at least 8 bits availabl=
e; see above */
> +#define PP_DMA_INDEX_MIN_OFFSET (1 << (PP_DMA_INDEX_SHIFT + 8))
> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && \
> +                           PAGE_OFFSET >=3D PP_DMA_INDEX_MIN_OFFSET && \
> +                           !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1)=
)) ? \
> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_S=
HIFT) : 0)
> +
>  #endif

It took some staring at, but I think I understand this code and it is
correct. This is the critical check, it's making sure that the bits
used by PAGE_OFFSET are not shared with the bits used for the
dma-index:

> +                           !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1)=
)) ? \

The following check confused me for a while, but I think I figured it
out. It's checking that the bits used for PAGE_OFFSET are 'higher'
than the bits used for PP_DMA_INDEX:

> +                           PAGE_OFFSET >=3D PP_DMA_INDEX_MIN_OFFSET && \

And finally this calculation should indeed be the bits we can use (the
empty space between the lsb set by PAGE_OFFSET and the msb set by the
pp magic:

> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_S=
HIFT) : 0)

AFAIU we should not need the MIN anymore, since that subtraction is
guaranteed to be positive, but that's a nit.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

