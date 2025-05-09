Return-Path: <netdev+bounces-189340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E96AB1B98
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E330316FEB3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F3237186;
	Fri,  9 May 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIE7lTsx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DE22AE59
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811944; cv=none; b=nfupU9HW42aK2oxVv/dTtIK/5biyvS291DhHN18bw95aNMoDUYIk4k1xNvPwKLpt1qxlW4h6ld4AngIyGlexn7F9+PzJnyZi8XafPX72SoEmKzufmhY/if4IPs4j9d55dWM/I/+gz6pygLeZXVFN7W6tf0Rp5dBtFsbOOxXji74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811944; c=relaxed/simple;
	bh=5eHoUKhkqLQGmaUembnNdbV4+tA3vXC6gIgS8fRZvko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvpHUi5fRZj5g8vZE6KUEfUqMAVWR+AOv/7iN8n2yk3NTpUeM1Yg81bn0iFTPlC/ZecDZZF3eCt/HAUw1n6seLB5wvKZmJzVwN1cxSJvsWJqHXXTAkmGm/mfmCtw8G3vKFhMil++weIzLGhZm47R1h1Wwi+fFmOotj3JJZuMKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIE7lTsx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22fa47f295dso12145ad.1
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746811941; x=1747416741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eksCJPPKUnzZZMnCwrQDL/i184EE28xZ4rbD/Sa6J8s=;
        b=aIE7lTsx8savGL5Q5mamEtqcix3P+sESbWkcCfn3Hr9VeAFOYnILPcxJbByibmcR0w
         DW21DtUkWT4gPwldwyAkE3xMaKrjQeCfj5s3XrrmSh4OVZq61qRRZbiIOPK6Owj6Qqj2
         fnV2txXGrFgBacwJ6Wg+2rjda69nYEKVmMgoLVkJIgYwitSmresw1Fm0cRZVvuLQVRQ7
         NbTNvUKnM4tNcGB2zuodYknU2fcNHvTcUvL7jLTbS7mzLnAw1tKC+ATc3N7/4jmxRgwS
         lmwPU2V7VGeSnofh2ComatdS5tg53lfsxdlUWEBSxlVbE1EGxiRLL9QOhuYOv9YHDrub
         bhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746811941; x=1747416741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eksCJPPKUnzZZMnCwrQDL/i184EE28xZ4rbD/Sa6J8s=;
        b=JtPcByaTv2K8EF6a0kj68gorLTNGJL6c30HnvEvSufBlKCop3beN0zB3Bf30ncAoYZ
         ffXsvu7XO+GVABLjFNCEx0DyRVlG6K5Sy03H0ORQBvvQecNL0uXyamjP09jj0QVgvZp+
         7x4Qql51AWLNAurwh3HgnLqPpcxUqbAOgRKaiTrr7Qgql+pKhD03MKjPzQIj1rHncXQe
         1dbyYFCfTsisGemRzVyt3ko1t3gELJF0ed1k2afo8OvYQuE/LJBwt8+Wk9U2cJuedFId
         +BTcI6EyWADbTK0oQmtm0HjasVTf5HxAYmjvtjg6aXTVE67vfxQ4a2tHMR5Zj2O8wnm5
         ZX/g==
X-Forwarded-Encrypted: i=1; AJvYcCV9xq6ZxJtAnJJilSpdLER7/pDYPvCGarN/uw/jN1tkdFW81en8cdRTclGaHflc7KmMVbbC+1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ddWdxByqW7gcCtyluJJKV3ldnAIQ2jMzM/x20IxIdJ8NP4p1
	0uUHigR0RlfVHIblvicvGWDK1gUqU90EExFuI1WNIB6XrLmO4AsLtriDJ3cXT4kZBnzXCzQ6Aq4
	Q0hX4l8OscdWaHN0dS42s+whtHAtbh7NaJO9+
X-Gm-Gg: ASbGnctGsYgnLUvsdDlMyBNr/AMv4e4ZIv8aNA8eSw3gk4bkVmbQ1X9Lvimc1nCbTYP
	SSmoxkZeObVMDueLXybD6GevL+S3FZv3ahZfH18+TLaUozv1Wo2FUsVsXdELQe0Ioj80W0Pz7AB
	EkHkB5sghjZjy8wQEPYy0JRvLZF4Y2829wYhiUvOyIbLhMTQq3xUJF
X-Google-Smtp-Source: AGHT+IFj0TndIRh/lZTWlpbLPDcfoUAdbzU63ncHeXdLshLF4cedqgULo3qSXEtwteAKMmWMtY8DXC8psezDG8cJFVo=
X-Received: by 2002:a17:903:4403:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-22fcfa67bbdmr2405535ad.21.1746811941138; Fri, 09 May 2025
 10:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-20-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-20-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 10:32:08 -0700
X-Gm-Features: ATxdqUGI6dEeIG5BsTRWq0lynejMc_q6rYi0sEc0AnPpkdnHxpWvN7YcbLR7W5c
Message-ID: <CAHS8izMoS4wwmc363TFJU_XCtOX9vOv5ZQwD_k2oHx40D8hAPA@mail.gmail.com>
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:51=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> Now that all the users of the page pool members in struct page have been
> gone, the members can be removed from struct page.  However, the space
> in struct page needs to be kept using a place holder with the same size,
> until struct netmem_desc has its own instance, not overlayed onto struct
> page, to avoid conficting with other members within struct page.
>
> Remove the page pool members in struct page and replace with a place
> holder.  The place holder should be removed once struct netmem_desc has
> its own instance.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h  | 13 ++-----------
>  include/net/netmem.h      | 35 +----------------------------------
>  include/net/netmem_type.h | 22 ++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 45 deletions(-)
>  create mode 100644 include/net/netmem_type.h
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e76bade9ebb12..69904a0855358 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -20,6 +20,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/types.h>
> +#include <net/netmem_type.h> /* for page pool */
>
>  #include <asm/mmu.h>
>
> @@ -118,17 +119,7 @@ struct page {
>                          */
>                         unsigned long private;
>                 };
> -               struct {        /* page_pool used by netstack */
> -                       /**
> -                        * @pp_magic: magic value to avoid recycling non
> -                        * page_pool allocated pages.
> -                        */
> -                       unsigned long pp_magic;
> -                       struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;
> -                       unsigned long dma_addr;
> -                       atomic_long_t pp_ref_count;
> -               };
> +               struct __netmem_desc place_holder_1; /* for page pool */
>                 struct {        /* Tail pages of compound page */
>                         unsigned long compound_head;    /* Bit zero is se=
t */
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 00064e766b889..c414de6c6ab0d 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -10,6 +10,7 @@
>
>  #include <linux/mm.h>
>  #include <net/net_debug.h>
> +#include <net/netmem_type.h>
>
>  /* net_iov */
>
> @@ -20,15 +21,6 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>   */
>  #define NET_IOV 0x01UL
>
> -struct netmem_desc {
> -       unsigned long __unused_padding;
> -       unsigned long pp_magic;
> -       struct page_pool *pp;
> -       struct net_iov_area *owner;
> -       unsigned long dma_addr;
> -       atomic_long_t pp_ref_count;
> -};
> -
>  struct net_iov_area {
>         /* Array of net_iovs for this area. */
>         struct netmem_desc *niovs;
> @@ -38,31 +30,6 @@ struct net_iov_area {
>         unsigned long base_virtual;
>  };
>
> -/* These fields in struct page are used by the page_pool and net stack:
> - *
> - *        struct {
> - *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> - *                unsigned long _pp_mapping_pad;
> - *                unsigned long dma_addr;
> - *                atomic_long_t pp_ref_count;
> - *        };
> - *
> - * We mirror the page_pool fields here so the page_pool can access these=
 fields
> - * without worrying whether the underlying fields belong to a page or ne=
t_iov.
> - *
> - * The non-net stack fields of struct page are private to the mm stack a=
nd must
> - * never be mirrored to net_iov.
> - */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> -       static_assert(offsetof(struct page, pg) =3D=3D \
> -                     offsetof(struct netmem_desc, iov))
> -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> -NET_IOV_ASSERT_OFFSET(pp, pp);
> -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> -#undef NET_IOV_ASSERT_OFFSET
> -
>  static inline struct net_iov_area *net_iov_owner(const struct netmem_des=
c *niov)
>  {
>         return niov->owner;
> diff --git a/include/net/netmem_type.h b/include/net/netmem_type.h
> new file mode 100644
> index 0000000000000..6a3ac8e908515
> --- /dev/null
> +++ b/include/net/netmem_type.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + *     Author: Byungchul Park <max.byungchul.park@gmail.com>
> + */
> +
> +#ifndef _NET_NETMEM_TYPE_H
> +#define _NET_NETMEM_TYPE_H
> +
> +#include <linux/stddef.h>
> +
> +struct netmem_desc {
> +       unsigned long __unused_padding;
> +       struct_group_tagged(__netmem_desc, actual_data,
> +               unsigned long pp_magic;
> +               struct page_pool *pp;
> +               struct net_iov_area *owner;
> +               unsigned long dma_addr;
> +               atomic_long_t pp_ref_count;
> +       );
> +};
> +
> +#endif /* _NET_NETMEM_TYPE_H */
> --
> 2.17.1
>

Currently the only restriction on net_iov is that some of its fields
need to be cache aligned with some of the fields of struct page, but
there is no restriction on new fields added to net_iov. We already
have fields in net_iov that have nothing to do with struct page and
shouldn't be part of struct page. Like net_iov_area *owner. I don't
think net_iov_area should be part of struct page and I don't think we
should add restrictions of net_iov.

What I would suggest here is, roughly:

1. Add a new struct:

               struct netmem_desc {
                       unsigned long pp_magic;
                       struct page_pool *pp;
                       unsigned long _pp_mapping_pad;
                       unsigned long dma_addr;
                       atomic_long_t pp_ref_count;
               };

2. Then update struct page to include this entry instead of the definitions=
:

struct page {
...
               struct netmem_desc place_holder_1; /* for page pool */
...
}

3. And update struct net_iov to also include netmem_desc:

struct net_iov {
    struct netmem_desc desc;
    struct net_iov_area *owner;
    /* More net_iov specific fields in the future */
};

And drop patch 1 which does a rename.

Essentially netmem_desc can be an encapsulation of the shared fields
between struct page and struct net_iov.

--=20
Thanks,
Mina

