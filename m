Return-Path: <netdev+bounces-133969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D0997940
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB21628446D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A01E3784;
	Wed,  9 Oct 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4dqNLTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD951E282B;
	Wed,  9 Oct 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517281; cv=none; b=AdTzgjLvTJdQ8iNgyo8c70Aujq99Lmu+1zBaQQH+5fKUgAkXE8eMMCAIpNFWpOCVC/tIpXVZaXovp/lZ/OZclZYx7r6PjhetYIGgD6tVYoI7YgWyU9Ja4JZmREyKkiKyITc92o/9VdktKYL/jKZ2CVIS5EhEMG30ZhL4xV3ZvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517281; c=relaxed/simple;
	bh=CNesG7FGcoT/a+eEEk3+j8joxt3TDHqw+TPFTXvAMfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7I3B15mwPPj3zHQaRG3Lmw3I/3O6Ld8eTfH6NT2VXKzaU2DVdJxVF3NBEpA5WmZPkdc4CwELHi/3gusWFX/IEQQpKoYObM9dQd/Ai7E0qlDpwn5LzuIMr8UJl4dNjPQ5jHOOiEKEUcKq2mromF3Ez7wAAdGAPoBvs198yvS9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4dqNLTt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so83170f8f.0;
        Wed, 09 Oct 2024 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517278; x=1729122078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV6IS5DWa+7uSQHx5EG2LlvpJvo8gaGC4KIn0m9Kmxo=;
        b=V4dqNLTtW8HpfotDI7NVv+Tt3xdixROiGYQIIiOPWmIbIgU6YdAQlF7NOR/LNmQua4
         55/XUBjk9b9uPWm9HmhcQTHBQee066atDdHOPxumqdEGx5flWRGIggc9rg3oW94j6TF1
         1eFRZ3E1KUZL1UDiwoo5eV+BEMp2Dz1sxaqFqjkJwBXjr1aW6MjBtb/KrbHQsp088zGO
         cdzL3YKn3ytqv684kg/CkTlW6UNqaukRki0rbE0PwyBl0X4IZJ0RQXuBx32y7LtnPNFh
         3tEJPGUgpuIwWYYIXgKQVByl1f3ShIPrA7qZVh8SmQxhC73yEZGBb/sOxyJUOdEad3Wh
         evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517278; x=1729122078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV6IS5DWa+7uSQHx5EG2LlvpJvo8gaGC4KIn0m9Kmxo=;
        b=HPFnr5ALKcG46t20YMaW0pVvex9nBmtkWCqqtu9ibljWNM8YEvUYzhj9ZTdotVstNK
         2uIf3wo4l7kjtak64FGGWnVs6XSkFF5FdU+B7e5EsHA8+bHTUlesSwIIdQUgPRyDZ7SH
         qZARUB7GwXFTF37rvyAJEr81flXTFgJIE8OrfM6PPkFzw9DBOPmELWR5OCwJMV+KZwC7
         2zr13Q0FuoGVkG8LX2vZN49bMygDryQF+OUHajmwqEyBiWB2sqDRLCbNJyeA3X5gvgBY
         cl+xj1T06tXC1hpDnlaUgz8PVXTx0rNrHZCpOEOlLxgJBOThaAMzd7ctlHEWzOjZlsTM
         1cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKdn3qMcS0sBPIs0OLXuOy+f6JIULa/feS0814WT2p3dS1Yio2avn2DPgbfL+61KH6sptI3pF@vger.kernel.org, AJvYcCW51Gxd6yAzgCJ/B2EWU5ahz0tPh6YU9ZB/LGM+Nh51BsHq6Xtxn1wlZqXnG2mP1CGufAtdYOVAO1Djnpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6O2PSM7iYqEi45uhgavmwPLuryMFJKxMNie7rs87mXJkO2Ot
	8vOQcEEGubJcycPw+yLVD99BYtxdCawbpVk9hwuWmjHnRE8uNLIehmX6eEgPcmzXlA2FkRsZN9U
	mu/nwVsv9R7u6hTVrquwgb7ttlm/VEg==
X-Google-Smtp-Source: AGHT+IH6236Rx+1SLLug8rPn5iG8s8FC6z+M5OjhHc3ocP0zbDgQyxE3mAqgxQFxYRpaqgXhMKa30LvOxFCv6SzBgWY=
X-Received: by 2002:adf:e78d:0:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-37d47e93ccbmr1180232f8f.10.1728517277639; Wed, 09 Oct 2024
 16:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112049.2279307-1-linyunsheng@huawei.com> <20241008112049.2279307-10-linyunsheng@huawei.com>
In-Reply-To: <20241008112049.2279307-10-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 9 Oct 2024 16:40:40 -0700
Message-ID: <CAKgT0Ue_mp1JB2XffSx-9siR4V6u3U_jEyy91BUqTS9C6TJ5mw@mail.gmail.com>
Subject: Re: [PATCH net-next v20 09/14] net: rename skb_copy_to_page_nocache() helper
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:27=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> Rename skb_copy_to_page_nocache() to skb_add_frag_nocache()
> to avoid calling virt_to_page() as we are about to pass virtual
> address directly.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/net/sock.h | 9 +++------
>  net/ipv4/tcp.c     | 7 +++----
>  net/kcm/kcmsock.c  | 7 +++----
>  3 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index e282127092ab..e0b4e2daca5d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2192,15 +2192,12 @@ static inline int skb_add_data_nocache(struct soc=
k *sk, struct sk_buff *skb,
>         return err;
>  }
>
> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_i=
ter *from,
> -                                          struct sk_buff *skb,
> -                                          struct page *page,
> -                                          int off, int copy)
> +static inline int skb_add_frag_nocache(struct sock *sk, struct iov_iter =
*from,
> +                                      struct sk_buff *skb, char *va, int=
 copy)

This is not adding a frag. It is copying to a frag. This naming is a
hard no as there are functions that actually add frags to the skb and
this is not what this is doing. It sounds like it should be some
variant on skb_add_rx_frag and it isn't.

Instead of "_add_" I would suggest you stick with "_copy_to_" as the
action as the alternative would be confusing as it implies you are
going to be adding this to frags yourself.

