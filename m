Return-Path: <netdev+bounces-89253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B318A9DB6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469E31C217D8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A153E168B1A;
	Thu, 18 Apr 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5mGcHDp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02906FB0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452241; cv=none; b=CptLuagPx6pQ3sHS8IdrHkUTkA0jk5Qg6saqNlF604h0Skek71Rp3rXYn9katDCvo1PQRInD8GfNO4ekorkPQtgmAPdvwF50Ds3JeFFBFJzFweTT7FGy89g2nYzyraXFW8tmEFUzvcw74joWtj0orHbiMWzXy+2Oz0hxr+nnNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452241; c=relaxed/simple;
	bh=5zKvUXdJBFPuQozJy4Os5tScuNYVv5VcQ1CguS1yJFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/Wto2r88YSFWPXy+MmslH4vZauKYCv6cDgY2uP6rouElAQh56N3af734y3H8b0vT+pB+AcM+OCq/Ome76Tm0CfIPQpnghuOHvHeR/e/hE7xbruVp2s+bKcTbod3IvVPIhSVjYrtTKGqhxRlTFbd7EQCRCTI5yz4VaTG+L/L7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5mGcHDp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51967f75729so1106561e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713452238; x=1714057038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4170ZhgzJpAXwr6ljG/YSDARpsJn4+o6qTKEWZM1ZqQ=;
        b=D5mGcHDpZV/3eDVGsdQM7kdPi6AjESzRhwzc6Ezf9ieNqqjEkxU5kWPXzA9TaFzf4T
         4ikezSPrKU3QOY9rYUOj0KhOMGul2WDGqP7PWN+zngWpkY4xxXVUkkQ6s701sueYh5gF
         zhFErGT61zNQYrzOO6sH55jKjzBurhdoEADZEXHb9qqqVHrkFRYvSKX1rzWQJfBHhNlF
         dUxi9lYysDsrN7weVq7FYSmGnyCOspOT6/W6DCf6/WJV765NvzMUqnVIBcuDWwz4AmOt
         w0Iv8vwahVnvhvmp3X0pKdD/5FlLP1ACwEk1qjLw3s+c1p7z29pJKVeatY3xK6DkG0Y7
         QAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452238; x=1714057038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4170ZhgzJpAXwr6ljG/YSDARpsJn4+o6qTKEWZM1ZqQ=;
        b=i5SHZ+T4yrmkwUhXCBwMGoNjH8+DAAYlVyBetgI7UCSHKLKSPDHfjZ/QuaHsVkycM4
         9SD7DW6Qu/2qzT7eg2PvARJhcjls2S6ObNnHv54cYi2IV5wvD2Z2RiZTNy39oc1x9trW
         1V5I8PZgKWz4TtHtjH4xk/CnwEfXRa2RalMyphPU+oze5SXQebic6mfEo625HalKohMB
         u0hQPXfcufogok4/MyB0Ffb95CSoviBMOiZldAB7P0S5KIwyVDON8QU/3a6lNNY75pir
         GB0V9bVJSVUBWjOWdzlMgMtvcFa+0D2YgdcUbajwOzWNvbJnVJ4WWHrQ2tg5ymR/9Ieh
         Cprw==
X-Forwarded-Encrypted: i=1; AJvYcCVsbzGBWgMvm/xGmjDLnmWvuV+G0zP+hLj2MPbJbdS8EyVRIU6hqSxRzwE8Z2AbUFI3TJWKZeXzlX6Fin42RfMAzNkOzFSt
X-Gm-Message-State: AOJu0YwKjGc/ObuLo43LBxw8UqFrUK4wNP/OL6cI64XWNchch4KW89V9
	biGL8Ag4I4RouMU9zRtudhHIHjReVaS/13gGZ0WhyFkCbn0h1ER8fYt7IwRZNPJUiJ2pXOZLh8H
	EhQ05jRsoZMyDrScYwxT4wUMtoHWjrAqV87yNmw==
X-Google-Smtp-Source: AGHT+IGgo5ZpK7ScQ3STj7jd+rPX7sm4nXqGrRIqUtUQ4a24HhXvoJYmRFhhYV7WswO4nrk1SpVmPZ75uDv3YLj6r+o=
X-Received: by 2002:a05:6512:3f0d:b0:519:7738:a5cf with SMTP id
 y13-20020a0565123f0d00b005197738a5cfmr1605328lfa.25.1713452238069; Thu, 18
 Apr 2024 07:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418113616.1108566-1-aleksander.lobakin@intel.com> <20240418113616.1108566-7-aleksander.lobakin@intel.com>
In-Reply-To: <20240418113616.1108566-7-aleksander.lobakin@intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Apr 2024 17:56:41 +0300
Message-ID: <CAC_iWjL6j5xS9GsLiZdLPJgJgfGNMbjKZPTMqnvX9U_9Dgq=ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 06/10] page_pool: add DMA-sync-for-CPU inline helper
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Christoph Lameter <cl@linux.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 14:37, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Each driver is responsible for syncing buffers written by HW for CPU
> before accessing them. Almost each PP-enabled driver uses the same
> pattern, which could be shorthanded into a static inline to make driver
> code a little bit more compact.
> Introduce a simple helper which performs DMA synchronization for the
> size passed from the driver. It can be used even when the pool doesn't
> manage DMA-syncs-for-device, just make sure the page has a correct DMA
> address set via page_pool_set_dma_addr().
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/helpers.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index c7bb06750e85..873631c79ab1 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -52,6 +52,8 @@
>  #ifndef _NET_PAGE_POOL_HELPERS_H
>  #define _NET_PAGE_POOL_HELPERS_H
>
> +#include <linux/dma-mapping.h>
> +
>  #include <net/page_pool/types.h>
>
>  #ifdef CONFIG_PAGE_POOL_STATS
> @@ -395,6 +397,28 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
>         return false;
>  }
>
> +/**
> + * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
> + * @pool: &page_pool the @page belongs to
> + * @page: page to sync
> + * @offset: offset from page start to "hard" start if using PP frags
> + * @dma_sync_size: size of the data written to the page
> + *
> + * Can be used as a shorthand to sync Rx pages before accessing them in the
> + * driver. Caller must ensure the pool was created with ``PP_FLAG_DMA_MAP``.
> + * Note that this version performs DMA sync unconditionally, even if the
> + * associated PP doesn't perform sync-for-device.
> + */
> +static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
> +                                             const struct page *page,
> +                                             u32 offset, u32 dma_sync_size)
> +{
> +       dma_sync_single_range_for_cpu(pool->p.dev,
> +                                     page_pool_get_dma_addr(page),
> +                                     offset + pool->p.offset, dma_sync_size,
> +                                     page_pool_get_dma_dir(pool));
> +}
> +
>  static inline bool page_pool_put(struct page_pool *pool)
>  {
>         return refcount_dec_and_test(&pool->user_cnt);
> --
> 2.44.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

