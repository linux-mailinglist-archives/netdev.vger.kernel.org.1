Return-Path: <netdev+bounces-131835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F898FB0E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5193D1C21C22
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C351CB308;
	Thu,  3 Oct 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg2rEcan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2745161302;
	Thu,  3 Oct 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999598; cv=none; b=nAOE2Wi3MGBxsGBVfDCI7CRVmvRfMpHREwb1CUGxWrVtQYKkrdU8yEy6dg+/2XVetFTuVjI8ekK5jaImrnt9qNarw2ASjjcO4mz/4kPrjR0+xQGyC7uc544XgEjKC02ieZDQBsallnOWN+a5qDVjtRb3hg/lq5MWeSNuhKh45Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999598; c=relaxed/simple;
	bh=GElq+7zEdSOqzTUc8Qtq98W9eVoQzqCdc05DPJguzgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDAQcMUdwRwYd9mQBB03ajqdmvOVwbxIOtFow6TPyPqiN9dShsxfgL7Rqrq4VDepaXu4Juhr+1AgRNsOc9ibWKV+V1IBN13CT2V8HJNb+WR89ul/nEjIQSDYnWH4XNOkX24Wju57aicLLslO7/tTwwDI2QrLJN1lmqh2UDbxF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg2rEcan; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso14314775e9.2;
        Thu, 03 Oct 2024 16:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727999595; x=1728604395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FXW2qfy0Mzte0KQiCiX7jmY+EmRVQswHOXZMTK6z7c=;
        b=Pg2rEcanPkY3/juiijGDPHA9qKWqSNG+g4kXN2XEuJuysEnkDAz6tYF2oMdSgB82ZV
         efuWEYJfbEzvAFDbXKiC34qad/DcCT67MtfeexwtaTEQmO7/UaXHp3qCD9UwBWsIjq3t
         R76+wYU9G3npFbRSF2xDwqAsJCsTQSRnHCuH/7vZiSUHquEGmTFeo+s53o7BQmCPqQp5
         UE0rgIpgOslPUzjDWonnhMhLj1qK4/yl2JWr4X3P9kHG5T5+jS3iEXNx65ai0CRfQuKl
         WqoD0iCKw6/cZsVBxFlVIacwb6PwpLmgeAq+ldmY+E2z15KhGgo6H/Jr+SAo9dXTk1zg
         09Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999595; x=1728604395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FXW2qfy0Mzte0KQiCiX7jmY+EmRVQswHOXZMTK6z7c=;
        b=ivz7CbBOobHBcw6bqr2DSUkvMIzVOqduUfM/OlQwoEtBriy89n8GcnBihOnS0eqHQq
         HnKUovhxrIMVlRAm5dMzcyNvQsxt0Ipdjrhu0nh3evzlukvnRpunEIUxJmj5exBavWQe
         HaYUmUOre6sYaNtnNehy3UG9/GOwVPUDRVhRxKZdVHTWFNwhb5h5YRBArV6UxqtJii+G
         Ys/LTIP5C9nWgDRueOG5KmmoqjOJ06w2P9d2QfVfozlyb5fH4plXfr9AL5PQ/+YOwtZ1
         jxHynf75SgghllVreQsK+yVffDoJVf3MZgiNdveK5AW9WImB/tL7mLgZANT48rDf4txB
         3Skw==
X-Forwarded-Encrypted: i=1; AJvYcCUwaurfS6TtKS72RJiQypiDccuAG4egPfyY8FaJ4gmx077wO8KQUXxg6i92/1EZDz+Fxd57TAoSajDg9NM=@vger.kernel.org, AJvYcCVW6EWP9rGw1vqE75QhfYXLGcBaYDggiYdTeIys4QSxlA7hSV80V8UPTZ6IFr2bvi0YiXtXtXjF@vger.kernel.org
X-Gm-Message-State: AOJu0YwbU2yoJfFjPGYSsPRP0x7lkNH+dTMmi15apVlh+Au4hkOZWmBp
	fQtl5lRjrPbT/KOzct/ZjW/LTs8iPfLvZ8eialsF0jG7uQurMLkvWw0+ybRXlrZxSBN1JnsEie9
	bW3ETtNvVvO3J3uoE/LD73qvXBPs=
X-Google-Smtp-Source: AGHT+IGn4fiOS89M9btpbU+jhafEsx5YrKlTjASgePNBq5sUh3zB9NpfPwXjvgun8r3L8mFlf1mrHdGYSR8h8EhWulk=
X-Received: by 2002:a05:600c:3b96:b0:42c:bad0:6c1c with SMTP id
 5b1f17b1804b1-42f85ab86cemr4605685e9.18.1727999594965; Thu, 03 Oct 2024
 16:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001075858.48936-1-linyunsheng@huawei.com> <20241001075858.48936-9-linyunsheng@huawei.com>
In-Reply-To: <20241001075858.48936-9-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 Oct 2024 16:52:37 -0700
Message-ID: <CAKgT0UchhzRXd03XXb5VMh99hgf9XOQ9Dkq3x93vgwsoYxzZxw@mail.gmail.com>
Subject: Re: [PATCH net-next v19 08/14] mm: page_frag: use __alloc_pages() to
 replace alloc_pages_node()
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yunsheng Lin <linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> It seems there is about 24Bytes binary size increase for
> __page_frag_cache_refill() after refactoring in arm64 system
> with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
> we can have more than 100Bytes decrease for the binary size
> by using __alloc_pages() to replace alloc_pages_node(), as
> there seems to be some unnecessary checking for nid being
> NUMA_NO_NODE, especially when page_frag is part of the mm
> system.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/page_frag_cache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 6f6e47bbdc8d..a5448b44068a 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -61,11 +61,11 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> -       page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> -                               PAGE_FRAG_CACHE_MAX_ORDER);
> +       page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> +                            numa_mem_id(), NULL);
>  #endif
>         if (unlikely(!page)) {
> -               page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +               page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>                 order =3D 0;
>         }
>

Still not a huge fan of fixing the bigger issue here, but I guess
there is only one or two other spots that encounter this, so I would
classify it as "mostly harmless" in terms of not fixing it.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

