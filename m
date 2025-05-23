Return-Path: <netdev+bounces-193096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A5AC280A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6993B7B1330
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2529711E;
	Fri, 23 May 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghHD7nnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426502036EC
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019672; cv=none; b=n1Q3UvrRI9Ym6K8hVhxRfC5Nq6MR995/gYSJEaFxYCLNsWYoAO32GmyMnK9maJ7cPijI1HIiWiL1HAIKHzQi7FGOHQhDhniHbDFIwqNJx9fFipjJ/b0KejxwcaaY3l2Zo+idfrua9kH3BHeq2yJCe2lkK1+zlz6dVVhyihLUGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019672; c=relaxed/simple;
	bh=hExa2Cwm4bAPttUEZjJfYoGFUNfZ4ZleOpu3VTcmpaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua4ioylXlVfz3sR7fc9kx07kptkO4KTCxuJrupcb/iOMsHyj6LJJunqt1qJnSC2lowp3pzNe0jOhl0+01OCJXDi8aydkKiIf0mdXhvdjcw4NC3SUIC0Uf51xoBYzCgla/DD8GG9j+90PrPyTOT0BjT/tXy6B6YfQbMJATHQS0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghHD7nnw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231f6c0b692so8365ad.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748019669; x=1748624469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOSRKDWId4W8kN+rUt+nVQlh5cnha/mrBYJj+eK+Jf0=;
        b=ghHD7nnwMk4MPKcpkQnGayp4Nv24ozaA/sQig6FtW9RTCw4U/o7Qp2YHsZUmRkMLZm
         h4Ml4frDUIz75uSXS0vMhdX17TCuSWCXZ1SUXGWWYfRBJc43nSaG+0UsHLzaDSG7uZI3
         +eeSHHd7As90Sfs9K2sc3OpzH/oX/IrbIbqNnzUfZ6LolqM22MrmDIty4ytW3ovPzRZK
         8xSbTjG/mW9nlfa0z/pLNOXLWMeeRaGo+trZUA3fQdHwRk7lcHta2rdzWCjdwnEzd6KR
         IWsuVgn/9amsmTjLgCKy7iX3TijPiCc4TaJ4ki2NQyMtlzrnA7Lb7fb0f6raUFfwUnxV
         jD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748019669; x=1748624469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOSRKDWId4W8kN+rUt+nVQlh5cnha/mrBYJj+eK+Jf0=;
        b=f+4GWgCOmGUeMGyOA0X+hTRSGMgR4SBh/VjpY77MMeqRqAGciVoiFvdqYj5foud/NA
         pl+kwuJX3A7DZdlG2h1LYI82XiSsLkfXnA6olEHBoIMdy/Liz3+skMVM2Udigz0TJRlD
         b94GVeImYikSEPIy7g9RWIEf6S/iwnvwjX4LZ8SoRI8pZOis1S8titDG9+mxcezDsZeG
         jVy74/UEZOU9isO5a8rprk3fXXpj5cb7Sw3lOj6DKN3reXk7jCtIyySzC+eG0zEfxX/L
         Exblctx6gBGMf2ydRBOtCt7xdU33s+rMtA2CBIgofXoUgZOm82BOX5vKB+d/aecY5DtL
         CUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVoujVIYY52+/tHZU+meak72oxIp9WcXWGTKU8IwCf1NG9XtJ4yiG5blwYHYyEQ9GFuUEKAJ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ceXDboZt7mUtIJ3IAKfZxIi+82tJKJGx8hpF5YAJEItFjUIs
	NAVA1dHRrAzeo/O/Y4CvrGB8FKx/L9fmjMOvTJ21r6J/dmvWRK1J0oGJ+3uHj+wrCj6q661HPUD
	qhaQqADfj5eJsPz3xJ1hpqywmVq7xAHoiYxMe7iBA
X-Gm-Gg: ASbGncuamrzEoKAkIH/NwJoJWEYJVQur9ClbroUi5UQaFkxQXSVNCNNWyBgDO5JfB+F
	8/HSe/sXDxCqfegPOQnPnFeIGj7HylGGKw2aG0r9KBr6aJl/Mjgw5iUA2msz8z1KLzP4Gow7NTV
	4OdGKNJF1lsa5qs+1iyz5gOyJAX8Sehtg/pru8w3uxDkGRHuUtA/rW26psVY7G7UCeCSC8M/c8D
	Q==
X-Google-Smtp-Source: AGHT+IGJuHYQfZLr7hfQil+IpUEJXAuKmCwI79/rmEAXhTB8FY4jWtiRvq1iHUteieQZgEsK3rVaeZy0sUBH+cb+uvM=
X-Received: by 2002:a17:903:22d2:b0:231:e069:6195 with SMTP id
 d9443c01a7336-233f357c50cmr2674495ad.23.1748019669119; Fri, 23 May 2025
 10:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-2-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-2-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:00:55 -0700
X-Gm-Features: AX0GCFsW6gNVDYJM6WPqUUcEweldiOyGkOySslyL-ATgJPZxy65Z4gtkC0ipm7U
Message-ID: <CAHS8izPYrMMcqKiF1DmNqWW_=92joVrPE55rQTqGWaJ2=itHaw@mail.gmail.com>
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
>
> While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h |  2 +-
>  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..873e820e1521 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,13 +120,13 @@ struct page {
>                         unsigned long private;
>                 };
>                 struct {        /* page_pool used by netstack */
> +                       unsigned long _pp_mapping_pad;
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
> -                       unsigned long _pp_mapping_pad;

Like Toke says, moving this to the beginning of this struct is not
allowed. The first 3 bits of pp_magic are overlaid with page->lru so
the pp makes sure not to use them. _pp_mapping_pad is overlaid with
page->mapping, so the pp makes sure not to use it. AFAICT, this moving
of _pp_mapping_pad is not necessary for this patch. I think just drop
it.

>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 386164fb9c18..08e9d76cdf14 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -31,12 +31,41 @@ enum net_iov_type {
>  };
>
>  struct net_iov {
> -       enum net_iov_type type;
> -       unsigned long pp_magic;
> -       struct page_pool *pp;
> -       struct net_iov_area *owner;
> -       unsigned long dma_addr;
> -       atomic_long_t pp_ref_count;
> +       /*
> +        * XXX: Now that struct netmem_desc overlays on struct page,
> +        * struct_group_tagged() should cover all of them.  However,
> +        * a separate struct netmem_desc should be declared and embedded,
> +        * once struct netmem_desc is no longer overlayed but it has its
> +        * own instance from slab.  The final form should be:
> +        *
> +        *    struct netmem_desc {
> +        *         unsigned long pp_magic;
> +        *         struct page_pool *pp;
> +        *         unsigned long dma_addr;
> +        *         atomic_long_t pp_ref_count;
> +        *    };
> +        *
> +        *    struct net_iov {
> +        *         enum net_iov_type type;
> +        *         struct net_iov_area *owner;
> +        *         struct netmem_desc;
> +        *    };
> +        */

I'm unclear on why moving to this format is a TODO for the future. Why
isn't this state in the comment the state in the code? I think I gave
the same code snippet on the RFC, but here again:

struct netmem_desc {
                        /**
                         * @pp_magic: magic value to avoid recycling non
                         * page_pool allocated pages.
                         */
                        unsigned long pp_magic;
                        struct page_pool *pp;
                       unsigned long _pp_mapping_pad;
                        unsigned long dma_addr;
                        atomic_long_t pp_ref_count;
};

(Roughly):

struct page {
   ...
  struct {        /* page_pool used by netstack */
     struct netmem_desc;
  };
  ...
};

struct net_iov {
    enum net_iov_type type;
    struct netmem_desc;
    struct net_iov_area *owner;
}

AFAICT, this should work..?

--=20
Thanks,
Mina

