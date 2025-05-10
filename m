Return-Path: <netdev+bounces-189446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906A5AB21B1
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C2A1BA0D80
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC11E8323;
	Sat, 10 May 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZhqWk4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C761D63E1
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746862157; cv=none; b=BrrUDRAgoBdsAZ3S8juLknhDBkQVXZ5Tgwol6HNimSfVHBlHxPA6XPlZ3J9pbhMw2cKXuYPm4xX6D8jTV/0CgAFnT7QJrp6VIK9/DDORAsazkqFXzzvfHUuaZ2tQAsP4TojwWgC478pKLpCSmKAKzCfZPApMxAXlh0jmJmkrnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746862157; c=relaxed/simple;
	bh=xvMJy4jOfhr05ap3IoxrAv5Nl5E3LbWkecByzv8o984=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh7ncsThMRizAwJRheIbiGDNekShdnC1OA/SyCmHSQ3UbpWHbGkySR0l1AffIkYAvOZj0KdetaKM+Y7/EBaJzZNTlMq6lfKWenUikYRMYDNsTjnjjT9uEGe1fJXUYHo36Enc/OGHNbRI2uqm+70cMGoSCMtiJMrlSaXXVjQBFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FZhqWk4A; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e78effa4b34so2391565276.0
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746862154; x=1747466954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmD36ciZziZR7H2RC8Oob602p43Xl1hi/xBE0M4Q8MU=;
        b=FZhqWk4ApcT6+VBF+M4s7PWQ4tvYeyPQ8R/brgGghjJH0YXL8m/yPOGSsMKSA4LC2E
         8SooMeQytLUEDAO4S7zZ3YVgYqD6wS7THBa4WlAcPZq97ZPhcmNFkSrIyXbP+tEerDmh
         Uij2/fjbUrAxxu9cPHpxdSgI1L0Z3s4qb4XZFX05qwKqsksciaQ+oUd22jYdBx7MOOq0
         Yi3+8yJvgOz8hLSzLERJC2H7pfyXztuvyC3qmnxHrw3g6IAqrVMP7mc8W7ZLza2Qfb5J
         /FIrzhRDUHud5IyxOvwJpQdZYttH4cINw7jrn0V1xDPoLYjvDuimeDQD8ANJT1u2Brju
         fiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746862154; x=1747466954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmD36ciZziZR7H2RC8Oob602p43Xl1hi/xBE0M4Q8MU=;
        b=QflJB9Bc46si2Ikrn7P10zH4An33RbTgmtXin3ZmlRR4EGtETawJdJX1p8+E0i7wt7
         NrpHaKNb7nUTSbZFV+wAcPHJuee87iQ+Gj5o9+kS7bYzHzpCKlD17nTjuJmU8HilX+hI
         Y/Dol0FPKtY1h4zkrYhQkrVz4/mjjFjpula85uFUNX7qMKBrv/pSjQIdN3ojJPFpOAdj
         jFYesLLyRqcmSzvmtQ6/j9NfVuAfSoVknI2jyuH6sQsHkIFAVz6PsmQgThhWCNMhpDPQ
         xJYdac4s4IW7ksg0NvPRF8MGrUVqDq97RNpBwi2dw4EZtngqC7Z9VO+DcNE04i+V7I/h
         lJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVR8+cJLjNfjtzDHqkvSLKSUSiHJfBtM+9LTdh6aa3z0zqFVx3CD0w7G7UVtqaxbJwEmd2+dh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrY8YoUH/+szYew42G+kYMXmDAsHgB6LizDyPa1YrD8wOgD0Zz
	7q9ADTouiGe4T2STrWf4DfBFHuANYfuY7s3xh3Zy2sWZ9WNwOd9Jcrt3aSFmrjNsvwZ3q9aAKPo
	EIs5QCuPWEqdznG71JoptQgxsyUwzvTgdrsIGxQ==
X-Gm-Gg: ASbGnctJXO4HJXDZiXThIVtZPwFNUhMKRyCvqNA7Kw0srNYyD7eFXQMdDe9eqHOGu61
	DT9WzlNluHiMztFCZeHpNgoonUcJybyMpJOV2sJd/wBDV4irPQ1n07+3fQTx0CBmLh/yxDiB4lw
	fLVZh1NG65BuW9CXV/B04NKdhIl9qrXAdq
X-Google-Smtp-Source: AGHT+IEfIM9Qw+3d6qM4rvgEJLOTcGMzXGJ+Hg/E23wPkNnrtYTIEl4IAR6K4XzzErQSvkwMjFJbKzhGzX8NrLjHTkw=
X-Received: by 2002:a05:6902:2012:b0:e70:a83d:da74 with SMTP id
 3f1490d57ef6-e78fdfb0cbdmr7844342276.9.1746862154336; Sat, 10 May 2025
 00:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-19-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-19-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 10 May 2025 10:28:37 +0300
X-Gm-Features: AX0GCFsXhaptoCkxu0ZbCxN8jfaibb-tlI-nC4q5nIWFLMwAFBGIlbfnvN55rlU
Message-ID: <CAC_iWjLwC1t=Xrxb9QUxRpRqHCuXLcC6eRtu+Tr=NbpS-BFt4A@mail.gmail.com>
Subject: Re: [RFC 18/19] page_pool: make page_pool_get_dma_addr() just wrap page_pool_get_dma_addr_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 14:51, Byungchul Park <byungchul@sk.com> wrote:
>
> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
>
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/net/page_pool/helpers.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 4deb0b32e4bac..7e0395c70bfa2 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -441,12 +441,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
>   */
>  static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
>  {
> -       dma_addr_t ret = page->dma_addr;
> -
> -       if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> -               ret <<= PAGE_SHIFT;
> -
> -       return ret;
> +       return page_pool_get_dma_addr_netmem(page_to_netmem(page));
>  }
>
>  static inline void __page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> --
> 2.17.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

