Return-Path: <netdev+bounces-97202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB968C9E6F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12AD282CCC
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9241E50B;
	Mon, 20 May 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6M+XxYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD5136657
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213309; cv=none; b=Br6vNGxVLFff2nNUkZziUDjDMnWdhPXWWbKyZaRLBNYkfxjFOEpaJE1MpyWCs2SDviwwxUTNvZUiqLrxU6o9CjGdqenZfSShMOTVgJPC2eN2DuBqqRAoROavhjCEdFqbfxWxLq2FJBFltD384HzjOyivyO+Dv8az2MyYpQ/tPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213309; c=relaxed/simple;
	bh=VRbhLIGGRdMbdozY+j9x+0Lzkj3ji8VksWvLLXg0APk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjHhd0Y+dX2RV9TSJkopKTo/w10oZBUGqZkAPcBJ8eYxgMH8kQT1rV2ZnsFW9/MZcbIJf+aSEGDfNqSSMFR0tZsISAByPwkVfxUGmijJsCZ5U+ZlhXcnVxMux+UJsO5mHG0u8dy6FmYaYMcByHfo5fCxQNdaY5qYaA2zLoJy2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6M+XxYO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso11264a12.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716213307; x=1716818107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neB6i9wE+UbVAcUFdOfIm8rXYgeg25U8u7stu9F8pfY=;
        b=e6M+XxYOYJhygZE3W/v/l4VThYwcqgRh+PT+ClfTLPfd07eI2Mf7EC2rigMy9GrnNe
         dETrkGxPs9zey2Ev64fitZ4h2LmLq/D93+vta0s1g+RcJP0S2r5KdU5EkGoludjNH4xu
         LZPIYuCS/RCHbp422J/zaTb0yZ9LlewmuOhWliMAb7wPVX9UmibAcec9elYF7FvqMQhr
         +m7hOuC0wnbWYor5GlcEEV3F9+9j/aCcnXp/z0/HBC9U//5RladrsriDlszQ1QEbeI5v
         7mjH4oyITWnWrvlAtdpOX4864AWo/lPOGV4LuuvUxg6PcCsYJyxbFADcQW0iNNrjuR61
         lKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716213307; x=1716818107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neB6i9wE+UbVAcUFdOfIm8rXYgeg25U8u7stu9F8pfY=;
        b=n5TjNq/0D5yfwMUQi01zixK4hGhLV76/Oit6gr4Dr3WYrY8NV9HYVvRRxMpCybXrfH
         OSs/PMc+2JX6Lx4HEqnV55Co6tLYF990q4FS6Jwl6oThMb7iOmeRoVSqYYAJzREdz6nu
         /t2+d/Tk5/FjZuxqv93t7yqhJJX/ppeiXqj0wkEzfjDiwKFut2LwMYFvrXwLSQFXfKQK
         qM/gNBFxzXn6U8565ugMNl8r7nxLtgwCb1h5zFt2kKMFLXqyuP8pIHXH4SBzcFQKiJoI
         ScEPmhC75/Lr+x5KKqdVYjKSmvbX7EkaXCooRWudyfSE6xLeqaNtqaVa+4GfWJB7I8ur
         n/Yw==
X-Gm-Message-State: AOJu0YwKcvdNJE3M8aCJey7IRV7iC0nkIut9kF8rJ1uEb+c2LLLVT1TM
	ndNjt3vfI2ReXk4gFHFW8Rjnra7kOY4Z3fg7Z/pvt8XFmTAvMAuxkEfSM4C4sGmJ9OA58JwEWyk
	i+I5M25DhxRNDIxSM4BaSTEv5BRA+/Tho5sCqu7e2x/Ape80qkmb7
X-Google-Smtp-Source: AGHT+IG2zGprhthTfw13/rSR6DRpJ78xHZTxKAC5CpNGagzmSb2ENQQCLghq0kkBNDFXlj0pdIbTivmfC59hYUbEc/Y=
X-Received: by 2002:a05:6402:28b:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-5752c7157ddmr243142a12.3.1716213306499; Mon, 20 May 2024
 06:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13bccadd7dcc66283898cde11520918670e942db.1716202430.git.pabeni@redhat.com>
In-Reply-To: <13bccadd7dcc66283898cde11520918670e942db.1716202430.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 15:54:55 +0200
Message-ID: <CANn89iKg4p+ZgW36mKf-843QGydw0g_jxvti86QJOoxCyB0A8A@mail.gmail.com>
Subject: Re: [RFC PATCH] net: flush dst_cache on device removal
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 1:00=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Eric reported that dst_cache don't cope correctly with device removal,
> keeping the cached dst unmodified even when the underlining device is
> deleted and the dst itself is not uncached.
>
> The above causes the infamous 'unregistering netdevice' hangup.
>
> Address the issue implementing explicit book-keeping of all the
> initialized dst_caches. At network device unregistration time, traverse
> them, looking for relevant dst and eventually replace the dst reference
> with a blackhole one.
>
> Use an xarray to store the dst_cache references, to avoid blocking the
> BH during the traversal for a possibly unbounded time.
>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Fixes: 911362c70df5 ("net: add dst_cache support")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I can't reproduce the issue locally, I hope somebody able to observe it
> could step-in and give this patch a shot.
> ---

H Paolo, thanks for your patch.

It seems dst_cache_netdev_event() could spend an awful amount of cpu
in complex setups.

I wonder if we could instead reuse the existing uncached_list
mechanism we have already ?

BTW it seems we could get rid of the ul->quarantine lists.

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd931429e7f8c68df0df48bce6d604fb56..964dd7cc37ca8c53ebbd1306adb=
47772c62a7d36
100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -130,7 +130,6 @@ static struct fib6_info *rt6_get_route_info(struct net =
*net,
 struct uncached_list {
        spinlock_t              lock;
        struct list_head        head;
-       struct list_head        quarantine;
 };

 static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt6_uncached_list);
@@ -188,8 +187,7 @@ static void rt6_uncached_list_flush_dev(struct
net_device *dev)
                                handled =3D true;
                        }
                        if (handled)
-                               list_move(&rt->dst.rt_uncached,
-                                         &ul->quarantine);
+                               list_del_init(&rt->dst.rt_uncached);
                }
                spin_unlock_bh(&ul->lock);
        }
@@ -6754,7 +6752,6 @@ int __init ip6_route_init(void)
                struct uncached_list *ul =3D per_cpu_ptr(&rt6_uncached_list=
, cpu);

                INIT_LIST_HEAD(&ul->head);
-               INIT_LIST_HEAD(&ul->quarantine);
                spin_lock_init(&ul->lock);
        }

