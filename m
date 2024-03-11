Return-Path: <netdev+bounces-79068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9060877BB7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAAAEB20CCE
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81468C8E2;
	Mon, 11 Mar 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fN5OYbT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5F12E49
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145954; cv=none; b=MAEuAP846HUhJ8evT7Be607jVaIEfqLLFaIqYJdmZnpfaRu7v/WdWn1Htu+TgIwUhXl53K78DX9m6JDdiwqwDpAkV9i8x+KX1GmO5TdSc86mK5/gSbxDMdEFjWhnnw2hb1g2QEc1GVJDiV+2zW9l+HR8rX6Q5Zf0suhqTs9RGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145954; c=relaxed/simple;
	bh=x5ec069Py/OgCXIu9yohHAJ93X7AijwmWNVCPg8q9bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5g6qryB6k52dGOSoIn+c20/EO06LQYjIgiYmRVW1SXxgeeuW/9Z4aB/ZU0a2r+8zJf0LEKjzEh0GL/S6XRI05/RZbN7XXxa+m9c70oLk4jwxovFoJrvwYd6aR+cB+TU+EbwbnD+13kH5cKO7+QmRUX+KjcePzDc83KsrH1nSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fN5OYbT1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d094bc2244so63036221fa.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710145951; x=1710750751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9r+vNYj9kj35H0PtwD9InlJXv44xx/+vmqGYDjLPXw=;
        b=fN5OYbT19nj8YvWmtMtEkGvub/qGgxBlrnn0RHbULDYYnLHgDX53s6Uo3kS2kSNdI6
         bsU0XZwpN3OpXpX8uv3d72TjVZ4fh/5+SO6clj4Ll4A3FKulr55jFhfaxaogm7VdkPa2
         NNsTYkl/69XkgSv9MmmX3mnq9LCPNd5UvoZebcpWbZVCkbK4gFoEwXCbPer0fLFliuk0
         TVMMlbdq3Ne1mc9lAZEjz+yqevhGU9QfXfL8xhVwDszU4Nv0X2BV6Get0JeLKdmh1R/Y
         6I6HbJwlcXJRljYAh6tV7imEp7KWqw0YfzwXkMWyH5/8CEkXIDTr5AKPca7TUzfoT615
         HaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710145951; x=1710750751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9r+vNYj9kj35H0PtwD9InlJXv44xx/+vmqGYDjLPXw=;
        b=twVIxccZnJWmBqL8vQzgBVIaCF1rUIGZ+QMiexVyDzmBoBrxSYrIG7Q+teRAkzDvpF
         i8Dqv24rGbT1sqM2DyMzmvJYcoZAV9WxYiWXNAEreJUeBGd/q+qF6V/iNKzSHj2Eb2FU
         fAO8wP75V3ZHZemIPJ7xC33yClPq/GuKg8e5ZwvOrNPlpOLJO+eNllbFHoZt2X9AOKWg
         GWGLOVnxz07yxi9xLMqJfgGx5B8jOYDrx/eejJH6OM3h09aEVoBsw8SL5avdLMhFIAvs
         adMb6UbsE5hC+BRrq6T6ESo4AandK786hZZ46uSGI19II6yrG8ZADLci6HaSFdVGY9G8
         PL3A==
X-Gm-Message-State: AOJu0YxzAy5u6YMQGKx0vfBMWZkHsuKJsN6N1MnM6xosAa8+a//NEXbJ
	sU0U/HYzs2AJLLjpqoiIpsGHza9236tHA+6nS6WhG/Qq7BsG2TaQB7MO+ptmkVCItgtdCUW8g2R
	jq2yDO6Ttm/4IkhXiQRl686A96EgVTGJzzWJbng==
X-Google-Smtp-Source: AGHT+IEAip1T5JTfQrWkZO10dn+9pmDK+miaRh+4HJ+wfeFupKLfGGITctyueGGBLotSjKXhuCJcoMvjmgN4GDfzcGc=
X-Received: by 2002:a05:651c:14f:b0:2d2:abf0:1c0d with SMTP id
 c15-20020a05651c014f00b002d2abf01c0dmr3451548ljd.47.1710145950789; Mon, 11
 Mar 2024 01:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308204500.1112858-1-almasrymina@google.com>
In-Reply-To: <20240308204500.1112858-1-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Mar 2024 10:31:54 +0200
Message-ID: <CAC_iWj+304K5jDYXpK6NAO_sRtSwt5QJ+dYn0c1PAhKSi-0aSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle check
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 22:45, Mina Almasry <almasrymina@google.com> wrote:
>
> The check is duplicated in 2 places, factor it out into a common helper.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/page_pool.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d706fe5548df..dd364d738c00 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
>         return true;
>  }
>
> +static bool __page_pool_page_can_be_recycled(const struct page *page)
> +{
> +       return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
> +}
> +
>  /* If the page refcnt == 1, this will try to recycle the page.
>   * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
>   * the configured size min(dma_sync_size, pool->max_len).
> @@ -678,7 +683,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>          * page is NOT reusable when allocated when system is under
>          * some pressure. (page_is_pfmemalloc)
>          */
> -       if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
> +       if (likely(__page_pool_page_can_be_recycled(page))) {
>                 /* Read barrier done in page_ref_count / READ_ONCE */
>
>                 if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> @@ -793,7 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
>         if (likely(page_pool_unref_page(page, drain_count)))
>                 return NULL;
>
> -       if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
> +       if (__page_pool_page_can_be_recycled(page)) {
>                 if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>                         page_pool_dma_sync_for_device(pool, page, -1);
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

