Return-Path: <netdev+bounces-236370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C6C3B2B6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC571893AE7
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB632ABC1;
	Thu,  6 Nov 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1S09r2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456023148BE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434791; cv=none; b=Hg5L/3dFE1bgNrWpxKbC5tYxswwiE6lqQ/Y2lE2QdfA8fPFl8hDzLxXCwl9g5AV37VH8btagwcqJgIsRknMjz39Jtv3IzRdW2KxRiqMDGrIW0p7MI/4ZhGElJcHk+k0/KjxC9FACMymtN6ywaHm/UG5T7129KXiEjODnZvsutuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434791; c=relaxed/simple;
	bh=Rgg2Af4bzAMXAetO+2YUfn1QvzY5Z7jf0MbYpQj87MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko5gbGZTgY9pVIE9HZyhW7U2HMCWe5ey+tMg7QWZxRD6t5V/ZzQJr2v5gECG2El83Mh7hwrBnbVdjb2Gvn8SznQP4cFhl1NYSmPGJG+3Jz9ACUX4EsuuuFXHjTN/NKseVo+OseAqNCyADRhiYZpUDThwBmrN599gqRHfIh/93bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1S09r2G; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63d0692136bso932432d50.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434788; x=1763039588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr8zIq++NWe3T42mWiyg4rbtFwpYjZBhkQARiQCCDt8=;
        b=R1S09r2GhRQnOcd8X+O2zTWysTMpkG12lwRhTrRE72Xy5yS9RtyLyRd79dQGboQYGt
         h7w3WZT+QEfMvbX4p+41wYD2JZbohvgydjZFfWBHor7G8jyng0xz6PaSu2di9yXyCW8e
         WOaYNxtx9YCvZhM5MQkIaHbNMRVpYzlUhDdrDiCUXlq2upTa44tKdOepoMZiKJK9+q9W
         rMjkYQwfgIeLORTzlm5IrHb5CLWC4d8tJIQzhJmoU+8sAGZDAXw7vAH4qp6VSXtYpZyb
         89wsPArU7L963ank6JR1AX/oJQBbbS5q00EKo18cWTClg0rUFFJ+5hB2JMeQlurG1aH8
         +oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434788; x=1763039588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr8zIq++NWe3T42mWiyg4rbtFwpYjZBhkQARiQCCDt8=;
        b=XeGRb2d9RS1W51rICUGLRQ+nQqwA7FEe69x3gn9faAPjClUTBTwCnCwf3Mtxk7j7Jq
         tRcxh/BI+J3jyVJcdVW816vWIQaT+DlwB7YoMD+ZtocW5wecD4s4VVRcjYxOIm+3QM3X
         h+BGJXWg+OarKw94EhYDhzL/H+VssUswPyzAVc6oWK5GLcnEOHAeXtpyKhbhCpcB8YFX
         j8oUhTwNS8ctywnEoiDW7yLnOx3cpSZaxwAV5r/6IsRrohsqbdQDxLsmQ9V8zc2J1VDc
         lcCVHl8Htb13qG+h2fBaFJ3jsu2jV1BcGAfVuUb0MM86IneDpLqPi8iqeeD2XEIVoCWU
         QqZg==
X-Gm-Message-State: AOJu0YzLN/nij8pSUOFpyVoWNmYjjRB7rJkyoAFis0QYjRccFn4QQ420
	StCBBwFnUMfzgViB6az86SitSlORMRhcCwMslLD4dJoWoG7lHJ6DPR2SGtfY5jqQr2eDjcsLHCS
	Qq7n/q3yIqjZZjiHWDwaRP4RMGmx7WtHjllVj5SOQsA==
X-Gm-Gg: ASbGnctpRyhjABTdAKUb1qzdgTHF3JW1cXvt05t0Y4wYzTxFSdDZxJKU5zjfUhKAgmN
	iH7nIwLa9ece1nO5LT9XWRxBoC7vxXFbiCJLlfW3T7bVZP5vowOqo8J5o5IIy3KzjRgogFshh60
	+phPueXGYrjk7OSeZAU18rjNt4I6BQuf2yg4tO31EH8f3UNd6LpW+YxAelkwaGbYlCL4SJ5j+0O
	t1ePtsz8az9gv3ayPHCvUC3xFRfAuPrQbvqDGeaYfHDcL0qBtMbWdhhZPJBGsosrJRX5XMC6Xmz
	9OkIYfhl+5G9qMEbgac7Id9gOM02ncmBV54PU9VCCAsQgu1Dxx0h
X-Google-Smtp-Source: AGHT+IHpA25Qw9KHp85CbOrmqi7smoI+i5HXa4iYSYr8Yl5m2jCAvh/JMAJMh3OTTZoWzQa0g2jxyJn4ENm2LDRqHa8=
X-Received: by 2002:a53:d058:0:20b0:63f:9f4a:3ea with SMTP id
 956f58d0204a3-63fd34cd64cmr4943589d50.19.1762434788033; Thu, 06 Nov 2025
 05:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
In-Reply-To: <20251105200801.178381-1-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 15:12:30 +0200
X-Gm-Features: AWmQ_bnjH5M9dyJZq9l8Gj4I9eAK7C21YFV07XTbiWP_NI6BQWytXh7uxg1q-mI
Message-ID: <CAC_iWjK1bz9a_SzYsEuZmqvYDWT6h6hFwWdX2OO5aNBcjp1MFw@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] page_pool: expose max page pool ring size
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 22:08, Mina Almasry <almasrymina@google.com> wrote:
>
> Expose this as a constant so we can reuse it in drivers.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 1509a536cb85..5edba3122b10 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -58,6 +58,8 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +#define PAGE_POOL_MAX_RING_SIZE 16384
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1a5edec485f1..7b2808da294f 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
>                 return -EINVAL;
>
>         if (pool->p.pool_size)
> -               ring_qsize = min(pool->p.pool_size, 16384);
> +               ring_qsize = min(pool->p.pool_size, PAGE_POOL_MAX_RING_SIZE);
>
>         /* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
>          * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
>
> base-commit: 327c20c21d80e0d87834b392d83ae73c955ad8ff
> --
> 2.51.2.1026.g39e6a42477-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

