Return-Path: <netdev+bounces-127804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76879976987
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92C71C20F6A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6671A2627;
	Thu, 12 Sep 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nI9OEDuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127318E04A
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145378; cv=none; b=eE7z7dbMVF9lBL0xZMbsSjY2r1PGgyf40MAX7gLBgwfq59+N1z8ZnZO6RKCSvj7N0XTZAGkLUrpLgMe3/fal9VSmSv0G4zE1aBYCnZevAYtE9nwCrPD0ZgbWW5Ssj4S7maAG6Y4vjDT5EAt3h6uvIgkvm4zlB4TUvedmPDwGAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145378; c=relaxed/simple;
	bh=p3QBE5QEv+TqZ+cYTRnIe5AYdRUPitJ+C6cLLbx+jxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj8TdrZ9dgYT+r3VLQiA6HzaxO+UuvTR25+Ybzy9IOJKRTjKHyR6ASaZ6shzR8SnXubiNqq6HeIRakZI5kPhS2vkDtp0zwd1LggeFnakRBElQ5OIbRVHIM6WDE6D5pMJrJ8yzC7jsGSPC7X16rgxDKYya5e+J1Z52hxIHbIItyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nI9OEDuZ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so263935ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726145376; x=1726750176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq8WYeWUrnhXK0NeTYagBg5yp4YGBI9SyavQHTWxNGc=;
        b=nI9OEDuZBbURfb0F+kFWjcIaS0AtMwKZDBXJYvajj07un5Fgv8co8ik5/kZVKaVwbG
         zQi7k1oJAfgDzOAA18GrNSEtT4S2JbgcoVyA09HUJ9de3O9VnIny90aqZWktB1EoRIpm
         GR1SyLMPAa6/OlHNINKTq7wlFaZmeF7tBJifK76PrrnRUAyRdc8zXb0BD7KhZAYYyb+L
         HrQxP/BXu3tt0vp8gMkLs8N5TDoCDp/n5/nF6HdfvjAQk4EFVwIYKjtrepcnStWX7cRg
         a983/uUeNdVyznAje0vH/dA6jTPnFZcj+bvkwYvzpFd57agXMj1P/kxLUHJhkoHwTPf/
         KdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145376; x=1726750176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq8WYeWUrnhXK0NeTYagBg5yp4YGBI9SyavQHTWxNGc=;
        b=NeJbacRYQNbET8TPTrvcS1xbH2Voat6gHlc67aRQe76haeObBkJq7sykQe2tDWGCeQ
         PyWnmqwCirxAmEsYLwa2/FFLqRLHHD/i8BtX5zmzCmpe0anAaqV7AOxmtjDaql3Tyq2P
         xDefD17km8LrQ05wb3Pu+j/Rji8s4zaAGm8hDIv/Ze+Aan+JKmm7Rq+1aX18oypnFUcu
         sK+tNrGRQGWgIMjf+3zOI1Edgdx6+M7mT0Ch/QGzaiK1i+5K8er0fRbY1Ps8Qcc16jRz
         pG6w0bNo+KPJ0F++LCabpjmTbw2fmfgj2SOR/rF8aAKLh2fgoB0weVPoeA9dSflzoJGg
         5VWw==
X-Forwarded-Encrypted: i=1; AJvYcCWBIAvJ68vPk+M+bmDVeHtKc30zIfmdFzHuG0tQLKvXorSivuwYf6Wi3V8Yn8JBZFLyoLaFRSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuX968gnsnUSmQqzD+Y3y2/6pIiOJP2+O+ZeKvRvt8my5pwqL
	XxVVdDs1tPyBqbhlw+MG5XlPhHHOjQvlH6zw2/CuYGfWwwr4Q4AXrxftxgcCqyv/V0w33wl1u/z
	nFvbkhAUoJJroQmL4Sh0JNGXr2sGB97DZEqqC
X-Google-Smtp-Source: AGHT+IGFRenuzU06NEUD8eoRW+qg2CN9wPF7RykjhsRvAZRW74bI1jCxGSj75TM+PYQll6CvvJOwUshzn7nmY1rcVH0=
X-Received: by 2002:a05:6e02:b48:b0:375:cd0d:9342 with SMTP id
 e9e14a558f8ab-3a08569094bmr3087625ab.3.1726145376170; Thu, 12 Sep 2024
 05:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
In-Reply-To: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 05:49:23 -0700
Message-ID: <CAHS8izOkpnLM_Uev79skrmdQjdOGwy_oYWV7xb3hNpSb=yYZ6g@mail.gmail.com>
Subject: Re: [PATCH net-next] memory-provider: fix compilation issue without SYSFS
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:25=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> When CONFIG_SYSFS is not set, the kernel fails to compile:
>
>      net/core/page_pool_user.c:368:45: error: implicit declaration of fun=
ction 'get_netdev_rx_queue_index' [-Werror=3Dimplicit-function-declaration]
>       368 |                 if (pool->slow.queue_idx =3D=3D get_netdev_rx=
_queue_index(rxq)) {
>           |                                             ^~~~~~~~~~~~~~~~~=
~~~~~~~~
>
> When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
> as well. In this case, page_pool_check_memory_provider() cannot check
> the memory provider, and a success answer can be returned instead.
>

Thanks Matthieu, and sorry about that.

I have reproduced the build error and the fix resolves it. But...

> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/core/page_pool_user.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 48335766c1bf..a98c0a76b33f 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -353,6 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
>  int page_pool_check_memory_provider(struct net_device *dev,
>                                     struct netdev_rx_queue *rxq)
>  {
> +#ifdef CONFIG_SYSFS
>         struct net_devmem_dmabuf_binding *binding =3D rxq->mp_params.mp_p=
riv;
>         struct page_pool *pool;
>         struct hlist_node *n;
> @@ -372,6 +373,9 @@ int page_pool_check_memory_provider(struct net_device=
 *dev,
>         }
>         mutex_unlock(&page_pools_lock);
>         return -ENODATA;
> +#else
> +       return 0;

...we can't assume success when we cannot check the memory provider.
The memory provider check is somewhat critical; we rely on it to
detect that the driver does not support memory providers or is not
doing the right thing, and report that to the user. I don't think we
can silently disable the check when the CONFIG_SYSFS is disabled.
Please return -ENODATA or some other error here.

If we disable devmem TCP for !CONFIG_SYSFS we should probably add
something to the docs saying this. I can do that in a follow up
change.

However, I'm looking at the definition of get_netdev_rx_queue_index()
and at first glance I don't see anything there that is actually
dependent on CONFIG_SYSFS. Can we do this instead? I have build-tested
it and it resolves the build issue as well:

```
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index ac34f5fb4f71..596836abf7bf 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -45,7 +45,6 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int=
 rxq)
        return dev->_rx + rxq;
 }

-#ifdef CONFIG_SYSFS
 static inline unsigned int
 get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 {
@@ -55,7 +54,6 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
        BUG_ON(index >=3D dev->num_rx_queues);
        return index;
 }
-#endif
 ```

Matthieu, I'm happy to follow up with v2 of this fix if you don't have time=
.

--=20
Thanks,
Mina

