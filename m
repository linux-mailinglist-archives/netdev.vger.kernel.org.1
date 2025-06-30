Return-Path: <netdev+bounces-202523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E753AEE1D2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6072A3A3284
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEA28CF65;
	Mon, 30 Jun 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCKsBch2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713E28C872
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295694; cv=none; b=pKkItVlZbxIljZ6TLBobmS4T1/trSL5rsx6q1eNwBkd/kvaRnQ1JIuJ4we+69N/NIROrUNsfaI7O1/Rt9GJI9Fjpqbaf8V3AjoMfBPMncKolPnWLR4GKWmcW8KceTUuyaza8/T0XMLVioIb7OaX1O0WWltXjFdRTWoA3IvYqMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295694; c=relaxed/simple;
	bh=bA2iVNqi1xBKfeRItYPrF/CNMUgz/auMZ2sX65vERlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1eeY4JsR1cn4JQO/Fgh873H2T01Z8evuk6K5DFmi3KpDsy2o1AFn2Fn3dcaj1RfXpz45QoYFrqjSgY/MimE2IFS4hZ6NKkIqXR1FPleV82gItDLkM9JyLrnnRuMoFDCwUSBv0ktOKzEiQ8BJK6kT/OHPEn2SdU0ZCE0BMrJNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uCKsBch2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73a5c3e1b7aso1106120a34.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751295692; x=1751900492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15iePih5BC5Jn/3k3dCq80lQGBhxEjm0LI0eUO5reYk=;
        b=uCKsBch2OVUu3+mV617U4c1Rp6E4Cr61unWNVV1P+4IEUxOlw0hZGxQvgVvWEWCQYe
         L3PjlHnR8947/pjnoXfWyNaKLw9UzzHsy29cI70YLQmDyNTUekKz3z+rxVsTp8B6YNIO
         TXm5BBSKjTtLzX9Znr1YXFMVOdcic7gj+P4KHO6+BkpxKTE6UNuv7TqWnVbSXGXClFRt
         dnhEzRd3XXDyC7kTVA/5IVpQzH6YD3XOdCHKUfyO6Art1cLtOI9q35Ax5ylH5XSB/icn
         rOLVhhJcVPyjiZYtvAxYwJj7GLlXeTWBy0q9eqS14c6RJIbPNIuLOPt2oFJ0ZJVbYeOo
         DyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295692; x=1751900492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15iePih5BC5Jn/3k3dCq80lQGBhxEjm0LI0eUO5reYk=;
        b=us0maTa+G5jehzDLCD9Lb4OqP4TjTAW+mTm0xrtSeC7D8k+LuNH4Kz1oKzLMsRnOUF
         XUCWeSco/3CqDSWajq3xP9NzU6u2phbJbF5l8+J/KmfUaRU4OAq1o0qI+NtyRRZGDDM4
         EjTtzyCxmmGF9vkW1rWFmnA9+eIkJh1kWC4h2uH4MnqC0cvZzAW5ADG8mKdbc8ua3kBv
         I83PD+L9SHB2dkENFPxjSflwYH/VIp1+wrPiPhTu61Za32XX1gkHKHkfrw0V9Pkkghan
         hBgDc2sb+bcUYgtOpdiaUjL4gKxcr/mQ3ufKNSfSKUV8xd2HoDYqtuSytEgtku3gWqWe
         tebQ==
X-Gm-Message-State: AOJu0YywLzKT8Yq7LV7aVYZbjnVU0i9H4HG1zY1ArZKnrlPkz7CE7Ibr
	5WF03gci9Nxrrx24N+kgStqjPZEJuVf8PnDLjPL2uzgSELTQHSQ1px0Z2uqKkf4evRfXsDupvpm
	ppMqz1/IBx+5NwbWvIdOXekH7YddFiZXzMEb+3kiMsQ==
X-Gm-Gg: ASbGnctPK9VE8Nw3EiVSizR7ubSwiJOOzXTPUdLOYjruoY2rdpVVLMOwVb3mXunjSkr
	gfuqGYKJDjhFgo/6WIjIQPoHPL/LjRoiRjdJqgxPWkhYePKdMFUW9P9EUjAmVf3p2zy0sApBeXj
	msmMmum7YvYXgzTkVDuGRU2krGunaL3A3115kyIcsEd5y0
X-Google-Smtp-Source: AGHT+IH39dcYGayERTHKwfkUbm8atj+vg9Buf7IQPXCRI9PooAjIYyvSqsdYej+jsm7V5GylTSqfC6HfkDzqBwhgvgQ=
X-Received: by 2002:a05:6870:a512:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2efed6aa567mr9175890fac.18.1751295691384; Mon, 30 Jun 2025
 08:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627200501.1712389-1-almasrymina@google.com> <20250627200501.1712389-2-almasrymina@google.com>
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 18:00:55 +0300
X-Gm-Features: Ac12FXy1xBEUxoV-RSx5hkK5xW-WOODrAl4t6LxpeZZdNAPeYcO-k0boL2C7b-c
Message-ID: <CAC_iWjLY10NAW7b7-vk5UD3x-Nay=4sfAW5uowq2MKyK_h-6aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 23:05, Mina Almasry <almasrymina@google.com> wrote:
>
> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  .../net/bench/page_pool/bench_page_pool_simple.c     | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> index 1cd3157fb6a9..cb6468adbda4 100644
> --- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> +++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> @@ -16,12 +16,6 @@
>  static int verbose = 1;
>  #define MY_POOL_SIZE 1024
>
> -static void _page_pool_put_page(struct page_pool *pool, struct page *page,
> -                               bool allow_direct)
> -{
> -       page_pool_put_page(pool, page, -1, allow_direct);
> -}
> -
>  /* Makes tests selectable. Useful for perf-record to analyze a single test.
>   * Hint: Bash shells support writing binary number like: $((2#101010)
>   *
> @@ -121,7 +115,7 @@ static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
>         for (i = 0; i < elems; i++)
>                 array[i] = page_pool_alloc_pages(pp, gfp_mask);
>         for (i = 0; i < elems; i++)
> -               _page_pool_put_page(pp, array[i], false);
> +               page_pool_put_page(pp, array[i], -1, false);
>
>         kfree(array);
>  }
> @@ -180,14 +174,14 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
>
>                 } else if (type == type_ptr_ring) {
>                         /* Normal return path */
> -                       _page_pool_put_page(pp, page, false);
> +                       page_pool_put_page(pp, page, -1, false);
>
>                 } else if (type == type_page_allocator) {
>                         /* Test if not pages are recycled, but instead
>                          * returned back into systems page allocator
>                          */
>                         get_page(page); /* cause no-recycling */
> -                       _page_pool_put_page(pp, page, false);
> +                       page_pool_put_page(pp, page, -1, false);
>                         put_page(page);
>                 } else {
>                         BUILD_BUG();
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

