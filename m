Return-Path: <netdev+bounces-163250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A32A29B46
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B365A3A3647
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE506213E6B;
	Wed,  5 Feb 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X73+JUw9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495820CCF4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787745; cv=none; b=PJYhhrrI30wH1x3i03XyjWHCvuxaXDKpUuxArwcf5o338Uk+NnmbV4s41Vi/VQYFiTUUBVWv+dEIsmNENyy2kO/3AuWKK2fYQw55iegUZYi7rIJQB7ZUa4YzqySesHEpOjNLa71b1ibfER7I00ZYIIKcjWLj7e5opgRjBqbI1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787745; c=relaxed/simple;
	bh=Gln2HnnDhsLWzXBWtI48MusUmvdYv7W4ohlK/dUqEdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYnBNiuA+qZEtJrI43D9U+gBFwctMjCfAO+7d2IPqLH4Dd4/9OGAky3oRxFzyHoGcdOjTZBiH4WfOhYuiW7balV9KvN6sPHmY9YeHtpMap4XpvXgAGk1vOzH1b+F08jZLxaZ7L8Z5GlmqE9BwNMX5zzT1RJbnYE8UB7Q7rkp9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X73+JUw9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f6ca9a81so28895ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738787743; x=1739392543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZEuWSeKUMeGugXmu8CgleUM3Xdha5JVQyBfoCzHa5I=;
        b=X73+JUw9WHEZfqCO/kLxEEzKA+HJq415GhsWyuXkEmtRgt/53VTeANp4HznDqKE0Nn
         R6ws9HhmgZsTdfOAdgyp46wcZvskHuouJcMmo64hVUrod182znUBSJxm35aQEVD6Pw/Y
         gqnLzt3vjs4BAjHwQtlgC9kGDP44a1zON3QKq5rBY+cXgDbMDgiWRu5QiHhPc8xkPUZS
         59EX0j9J24GfBA6vJy3isSaYaps+WkoawRasrWKJn1ltMDcdKGBfOmcg+555hGMPzd4k
         FZLizr/ppZQGzxGLvzWzSv4bNJ+wnbowYrEApiUEzCNQHuumsClwUaXpbRCXbVfWEQX9
         MMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787743; x=1739392543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZEuWSeKUMeGugXmu8CgleUM3Xdha5JVQyBfoCzHa5I=;
        b=WU04+U/l7Bf8r7AZMnXm3pVPtBaC/ZW4WjVRnSC/pvaIQJrMHPkR3QfnKEc9i84KL1
         eZfyZ0GBwOUjLqQCXRHsT+tUYojJokDalbN/x0b1SQpIHprZh/rWu9h1dQdL+DSOq768
         k4gfqv5TOlr+FYtAv5kzP4tw8yOhoCCmVYOPsKgrQg/CHzIgkk9LjOG3+sEViABLCsy1
         orpliJb21Tg6W4YcPEM+7NF9t1n7OTkhWvp/tPmT+5h+/g4M1BBK1TYx8i6m1ZMMJ0yT
         7xYH6YITPBtn+of3INCwdNRHUe0X1F0qtp2rwZQn8Jg1ABXTM4fTPfSjRoG7I49eL+3z
         2TkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoR3ff/lPMWgTGV+pVRpMeXPVWUHSWbzuebUA9gKma2VwPXnId2M/690Rkrn2xRN8rgX4qUqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnysWGceU5alNFrXlwepsgKblH+VHKXq3eVx4rRbhqQVlm2+38
	qlZ37KQIwu3AIwJSe7t+QNGiEivi+PGfOc5waVrDSAAFRYk1OdjQrN9T0botV/Hbl2Hn/yDa0dd
	jy1xapDxAfiGnMCBnhM/dpDjZaS5HKFGVw9sd
X-Gm-Gg: ASbGncvk+bAh9DIbYqcW3h/LAgrfHYBdXsUbZl2uUieOD4B79TT84x8gnfPFy5DLTyf
	xR6uiCW1Ug+b3gD74NdzONVyjlfh+4gPeeLBpyWpuyt+NlWBm9jZ7M1uu1uH8wnEtQazUP94U
X-Google-Smtp-Source: AGHT+IGF46x19UZL93ymOV4B7R5NUDwDWPDdkHijzUzUiVotxG+n7ZdG4FAKQnNE8KsGxGbrUvYuTCTc2ffVtk44Zgs=
X-Received: by 2002:a17:903:2b05:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-21f3033d2fbmr385455ad.24.1738787743260; Wed, 05 Feb 2025
 12:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190131.564456-1-kuba@kernel.org> <20250205190131.564456-3-kuba@kernel.org>
In-Reply-To: <20250205190131.564456-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 12:35:30 -0800
X-Gm-Features: AWEUYZnGIpB3jYhZ7OWxrR0A8HzqZOJu85CMdETZxeT2a6ISz5l3ce2UA4VwTbU
Message-ID: <CAHS8izNgVd_bPDCiFD5mN=TgkcaKmQK1RcLgw_051GRHcLXHvw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: devmem: don't call queue stop / start
 when the interface is down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We seem to be missing a netif_running() check from the devmem
> installation path. Starting a queue on a stopped device makes
> no sense. We still want to be able to allocate the memory, just
> to test that the device is indeed setting up the page pools
> in a memory provider compatible way.
>
> This is not a bug fix, because existing drivers check if
> the interface is down as part of the ops. But new drivers
> shouldn't have to do this, as long as they can correctly
> alloc/free while down.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/netdev_queues.h |  4 ++++
>  net/core/netdev_rx_queue.c  | 16 ++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index b02bb9f109d5..73d3401261a6 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -117,6 +117,10 @@ struct netdev_stat_ops {
>   *
>   * @ndo_queue_stop:    Stop the RX queue at the specified index. The sto=
pped
>   *                     queue's memory is written at the specified addres=
s.
> + *
> + * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called =
while
> + * the interface is closed. @ndo_queue_start and @ndo_queue_stop will on=
ly
> + * be called for an interface which is open.
>   */
>  struct netdev_queue_mgmt_ops {
>         size_t                  ndo_queue_mem_size;
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index a5813d50e058..5352e0c1f37e 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -37,13 +37,17 @@ int netdev_rx_queue_restart(struct net_device *dev, u=
nsigned int rxq_idx)
>         if (err)
>                 goto err_free_new_queue_mem;
>
> -       err =3D qops->ndo_queue_stop(dev, old_mem, rxq_idx);
> -       if (err)
> -               goto err_free_new_queue_mem;
> +       if (netif_running(dev)) {
> +               err =3D qops->ndo_queue_stop(dev, old_mem, rxq_idx);
> +               if (err)
> +                       goto err_free_new_queue_mem;
>
> -       err =3D qops->ndo_queue_start(dev, new_mem, rxq_idx);
> -       if (err)
> -               goto err_start_queue;
> +               err =3D qops->ndo_queue_start(dev, new_mem, rxq_idx);
> +               if (err)
> +                       goto err_start_queue;
> +       } else {
> +               swap(new_mem, old_mem);
> +       }

Why not return an error if !netif_running(), and change the call site
in net_devmem_unbind_dmabuf() to not call into this if
!netif_running()? Is that a bit cleaner? It feels a bit weird to have
netdev_rx_queue_restart() do a bunch of allocations and driver calls
unnecessarily when it's really not going to do anything, no?

--=20
Thanks,
Mina

