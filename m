Return-Path: <netdev+bounces-205890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C8B00B3C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7922F17AE67
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711D2FCE18;
	Thu, 10 Jul 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVTsrauV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438152F2C46
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171609; cv=none; b=jfLoiokIJhVDpSo18q9N4ENaDYjT0TJUYc+FjN59FNDAr/Z3Wi0OOOF1COKbRAz3GrpknlFBXAeyzEql22p+j4+Ev4Q1w7rpBYKY/jg+KBQp6Lf9X5eSjXTNmi3L8spHpadJEPbLDhPCAgEpbKO/4UAf7GJNOFCj1ANS1w66A/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171609; c=relaxed/simple;
	bh=EPb99Ej9S7eTJEfY1Nzk/x3khOnYOd7XdYVqfG7FoJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBVHwNhf6x9igb2oE7YdNaP2xf3UGLDujouW1T5ZOFjSswJg6mTWVixIDXde2YoFeztI7qBPKDsriOWbd55a2ARCrGgLBmw5HXhHYy5F1wO04YXa9lQYh6y9sVOSOETfHgnTWNrmsMwo0xy1HawJ+wvZMjm7/O/AYSiz7a06BdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVTsrauV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso29935ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171606; x=1752776406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj46vkefhs4SRIRS/QU5g/lyrMXzFbGQlucGo0/msd8=;
        b=aVTsrauVNuKpK9aafet69r3jPNTQoC2Xc0YUgkx/B35Jxv8F0Fy4jS1RiJp9dK/3j6
         CbfDww2dCKMRktYkMSRpLfVDUTJbQu0BKAfK+PPbsHD74oERvK6ZG2gtOmgga5bm6T8H
         ruoSDy1aV6Q34ohrHP1GOD0H/8NChnHJOC1bCIhchiRT4Dg5TkSnYU/DM7nf4CMuQZ9i
         vrNPoFwc/6+EkdcycRocjHzQIQ0rK2fzm6bz4ymjllZWaxyDP6EDImQIoHQV/5yaMxvS
         KBK2n8chtEhCKJidQpPIQazll1I6andpOc9PZkZlS3EUgag365LQjV57tPqdjGarFE0/
         Jy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171606; x=1752776406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj46vkefhs4SRIRS/QU5g/lyrMXzFbGQlucGo0/msd8=;
        b=PBVQGDGCgjuRPPUT7EOpEkGh1QSE+uu21jzF/oiyXHcfAdDvYKhiGo8udFwGZA6WL6
         wND2aWwD9kTG5pyAs3LgI+rCDx/5FAMXF6Ml2RVvy3b+o8JC8S0CW5RH03f/4eHiQiON
         VrwMQ66Th8nrb5xphoWVqMYNLq4iXQ/dCZ6oGb5EfyM5BSHYOSEH4WeB0Pg3xsPp6ab5
         H9Vp8kW4Juf+YSPqWpbj3R6Eu279ke1iKrrcMZXETj+aVe0eoY8PZqLzr5mV+nf3yUld
         N2bOQNJV+3P8eeTdtvipm4uO4zmT6wXQKea/15j3M0cDtix0r+1YXkCypyPQVVgk9208
         gzYA==
X-Forwarded-Encrypted: i=1; AJvYcCV2YLjaoX93w/aWX4W27cVa54E3OrfyIn9xQj6YRUXU8gzujmuRFIzlBi6Y5BvGC9oTCizQQec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJvU1NL1dLm0nwMJnR57fhKrhaGig6iHei9Ng0QCcSac4aIZA
	0gA6EAtRqkN1cN9ifBR3X5Dktl6BOi3O/h9ZoXKE3jg4jycdV2KcYkYEi5Ai1dFTJJRxh0L31nq
	BTrneSbz+Vzn9oA+Y9u+DZQntf+4qZlKbbgI7nlk7
X-Gm-Gg: ASbGncuKwk5d7ei73IDictzP2Gm2iCYgHNnBZal4Rh52hmiMe+Zs/2TzAhNujR4MOj+
	D0slQDLX8OnygH/RkRWud9YCik9Bzm4X0FLta0aCUPnP9mUEJGtairnNEnJTamAINdZtxYzSPBs
	qq3QMdrxHG12pDtUkOi2MAQDBg8wdq8ZM9pVIuPcCFfYr6TkMklmLqhTURGsY0xTLdqWaPoKs=
X-Google-Smtp-Source: AGHT+IEnsQr2vt1xRK9+Gg05s9Ioj58hP/Frug0vVmNYyI/waR29AKDxjbFsuLIHKriJNaWLDKD8Qv90dKQTUZAuhEc=
X-Received: by 2002:a17:902:d4c1:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-23dee4c480fmr119455ad.5.1752171605810; Thu, 10 Jul 2025
 11:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-4-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-4-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:19:53 -0700
X-Gm-Features: Ac12FXw53iJ9LLYfmK6k3qWagqoxpTOfsxU_34s2pmiydSWa2zOUfuaE-4Qlaes
Message-ID: <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
>
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/mm.h   | 12 ------------
>  include/net/netmem.h | 17 +++++++++++++++++
>  mm/page_alloc.c      |  1 +
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..0b7f7f998085 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -       return false;
> -}
> -#endif
> -
>  #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index ad9444be229a..11e9de45efcb 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -355,6 +355,23 @@ static inline void *nmdesc_address(struct netmem_des=
c *nmdesc)
>         return page_address(nmdesc_to_page(nmdesc));
>  }
>
> +#ifdef CONFIG_PAGE_POOL
> +/* XXX: This would better be moved to mm, once mm gets its way to
> + * identify the type of page for page pool.
> + */
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +       struct netmem_desc *desc =3D page_to_nmdesc(page);
> +
> +       return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}

pages can be pp pages (where they have pp fields inside of them) or
non-pp pages (where they don't have pp fields inside them, because
they were never allocated from the page_pool).

Casting a page to a netmem_desc, and then checking if the page was a
pp page doesn't makes sense to me on a fundamental level. The
netmem_desc is only valid if the page was a pp page in the first
place. Maybe page_to_nmdesc should reject the cast if the page is not
a pp page or something.

--=20
Thanks,
Mina

