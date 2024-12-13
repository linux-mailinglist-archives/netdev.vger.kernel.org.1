Return-Path: <netdev+bounces-151842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A69F1429
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D2D28419A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC01E572A;
	Fri, 13 Dec 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rroV4cgW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058201E5705
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111828; cv=none; b=IR7fN+wnnIUYXiCbg2KRS9K2sluyW3iIY4HWHA266t3JmjmlSdFivpKZ9sUVIJe414wVMViy+fYpKTAYOKd24ZPwJ2o0djR54zPwdlwHv+x+3eRN1vN5/99q4BK1K/fZE8+uXL8LsE3fkCecafqfn8Faw1yjrTWLB4uvEA3v7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111828; c=relaxed/simple;
	bh=/Y6ExPMSdtTNFFDetWL772H3JkfzBH5p/iYBW8zbvdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3O/2CrINJqa6n/u+bKnD9IfULAvJ67VIcBvR/tuIlwzgjfjB74UV+TNOKpalW4gGy7otA6AM+qHC4OIIbiQumjnLtveNqb4U4Lf1aUCSPYJx2jZ+znMQvZZwq09ERJh4aXA2VAf4pEOrLCNpmOfA0vjsTGaumnwUydznk93M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rroV4cgW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6eeca49d8baso18094887b3.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734111826; x=1734716626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a8YKuxtRxjmT79uOPtT40ZwuY+Gm57+IISMu9btN/v8=;
        b=rroV4cgWy+TyUGzh4/PCShgygTv04BADM834M8sEZmoiq9ZnD2jvK5kp8OYUXJz3Y4
         YCWffeuH4W/3oe4CyfX/8CSD9vCYtwY9eWjzAlPCHP2Yg6BNhHcOhg6FmTthhOKkVrrz
         QUv9fTRuVX+5QopwqMezv9w4XaXAPmlKl3qEoHpxqPZJNITA32SbGd47ICQhvcuoAD4d
         gn5lrs63RvVvlLTuwcuYqB93df3z52iJOHBr+/5OcXGDodrmnVZhxjI3me4WbpIN1dqa
         Bmf7pP18bqSHxNCXgQF0Bp1L7X/9ivi9UA6R4OrMrk0WRYMR5DjuzR2TRX8rPcuTTCDU
         qTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734111826; x=1734716626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8YKuxtRxjmT79uOPtT40ZwuY+Gm57+IISMu9btN/v8=;
        b=gWN2AM8q5m6p8mD0xmYmn4Kcbjaf7vYrK8k7Fq0n9EB2xMURfjqyDPGOUj/I3rkXSo
         6+sMsL/Ozk+VzqUiqxQH9LejzyMLCTwBrE6SFynZVnTva7M56ewkryXcM8lSL3CPi26A
         cA7Avr5lHp+EWzDin0beRvJDasGvuGZBBB+D8cT85bMNeBEN4OxrIWG0DprjSaqrlTNy
         yY8PqeuWzBWF9ksi+hOaglEq8N5Wp25ojoUiacy8lfjP7UF1k6zMahPfiSpPCjLXOEBW
         lcMjKJPKoygQrWy8RvNT5N7XhMj1TmEae5DOgNBCmGTkN4cxrwnqqAvMQNyFH6GSunN3
         OC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiYBSrgMRDLceHZxKlK77dPQ/wh8VwefES8mlnhs+T7hXM1eKk9I8PmoRAJurYl5y4yC8a22g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QYDsGiU+Pa2xaP0Bukgk18nGMW70mJ49dGwLn4YbUY/4Yvo6
	x3kZuDdbrp88feEGxmd1Dyl+dnX80TJkG7n0VNF5zPtkOa/WspRxsGdFA6CgqiC+XJMHMqTDVKH
	CFZOD4+SUQ/rSCGPtzin7xchS0/EWkxLzd3UmABNGIME/6H9WobE=
X-Gm-Gg: ASbGncur/NYPSlaxRm53nb63nZNCbXa0Z26cIlHIl4NnD2GElpSVWerU1sT7tIsQoFT
	kAomh9/VR0uNfP0+/01JXF6GhgLguSJu96yfuvA==
X-Google-Smtp-Source: AGHT+IHbaQLKxW8jv06NHY5L5CZx11FwWYhSQ5kW5QXSr03iJ25TyiTxQjCbFy/xekILN9zlRCs+aOjMnMnK9oTU5yQ=
X-Received: by 2002:a05:690c:6407:b0:6ee:8088:831d with SMTP id
 00721157ae682-6f275c048f7mr54670927b3.3.1734111826063; Fri, 13 Dec 2024
 09:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213153759.3086474-1-kuba@kernel.org>
In-Reply-To: <20241213153759.3086474-1-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 19:43:09 +0200
Message-ID: <CAC_iWjLNzpu2RmGmr+q=Hbj5jeGQi_+Hm+K5n8_Sa0oXiOUrew@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: rename page_pool_is_last_ref()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, aleksander.lobakin@intel.com, 
	asml.silence@gmail.com, almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 17:38, Jakub Kicinski <kuba@kernel.org> wrote:
>
> page_pool_is_last_ref() releases a reference while the name,
> to me at least, suggests it just checks if the refcount is 1.
> The semantics of the function are the same as those of
> atomic_dec_and_test() and refcount_dec_and_test(), so just
> use the _and_test() suffix.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Hopefully this doesn't conflict with anyone's work, I've been
> deferring sending this rename forever because I always look
> at it while reviewing an in-flight series and then I'm worried
> it will conflict.
>
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: aleksander.lobakin@intel.com
> CC: asml.silence@gmail.com
> CC: almasrymina@google.com
> ---
>  include/net/page_pool/helpers.h | 4 ++--
>  net/core/page_pool.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 26caa2c20912..ef0e496bcd93 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -299,7 +299,7 @@ static inline void page_pool_ref_page(struct page *page)
>         page_pool_ref_netmem(page_to_netmem(page));
>  }
>
> -static inline bool page_pool_is_last_ref(netmem_ref netmem)
> +static inline bool page_pool_unref_and_test(netmem_ref netmem)
>  {
>         /* If page_pool_unref_page() returns 0, we were the last user */
>         return page_pool_unref_netmem(netmem, 1) == 0;
> @@ -314,7 +314,7 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>          */
>  #ifdef CONFIG_PAGE_POOL
> -       if (!page_pool_is_last_ref(netmem))
> +       if (!page_pool_unref_and_test(netmem))
>                 return;
>
>         page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4c85b77cfdac..56efe3f8140b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -867,7 +867,7 @@ void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
>                 netmem_ref netmem = netmem_compound_head(data[i]);
>
>                 /* It is not the last user for the page frag case */
> -               if (!page_pool_is_last_ref(netmem))
> +               if (!page_pool_unref_and_test(netmem))
>                         continue;
>
>                 netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

