Return-Path: <netdev+bounces-99508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C150B8D5176
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A2B239D6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E09187574;
	Thu, 30 May 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDwCxZGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371132C6AE
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091212; cv=none; b=D62SwFSCbvlNpS2tTee6Ugt5puA1FkK1XWBvrYi7nw7/0tHTvtej2tBiPAOb0KQb6qdyqqA+/DzRJLjlPlwxo0eUpkg2Kal8ON7BFWwAdF7SbgldNoKxJhXSUIcH8lfM8uTdL5JU491mk23esH2duULRtMV9FrX89DVUsE2kfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091212; c=relaxed/simple;
	bh=smxJdpiv7qnMbKgy0IUvi7b98N801QcqyDaX9EErgBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS815G4itzHLwFLrf+2/CiM6sDx1U3fAm2P1Z7UFiZza5gjPHwN+iqK/+kyDgS+o04JsifPHUMkSTBYlbg4KmbvshKrUDpY4lXw4WYBsspfQ4JP8khiF5Zy6NWMjMoW9E+/UNimKjCDsu1N3pxD54fzB59n/dOkj+HXTEHly2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDwCxZGd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so732a12.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717091209; x=1717696009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRz9PS/+6JSq0ddbXvMQ5FymnGAmWkdiHc+DHAihXuI=;
        b=DDwCxZGdID5V/BYEjqpBEDvjUbAn7Whb23rBYpo+tQ7GJEi8hc7k7nwg6FRQFzAJtO
         EdoOycbKDvkqLoyvjdhANpc8MHetnkR2mEPVZgf4TLxMpV2oVkef60LEZK+d8+sI18G9
         b3/yEe3a8Y7jPJJ2NeH3jfAG1yYs2qwQtkS99Q1PLpTefN/kN4QptSzIE5AaimVBwNW9
         Bs6KbAT/dPSfqoF6CvLaNOWK6v6zggs7MpphqIAECiN4HbLXOhMzZoiYkM+QvIldxAnN
         XCqA8lESWhpnaftDeIe2pvnwwuDAMDCnBftDN6/flh3mN7kHkii0uGXkm73yeEli2U+/
         hFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717091209; x=1717696009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRz9PS/+6JSq0ddbXvMQ5FymnGAmWkdiHc+DHAihXuI=;
        b=lgAASZGzUXjPgsG4QZrVKbI7smrzxP5sbKhqlCgtCzQ6Vc9RqcNE1vxNxAfms0vmS7
         RLpU9E2o5BHV+saJsUKIo7L4447AkzjdDE8iyQUSSY0DyaRY0PROYAcXSOw9bHeLxpwN
         df68vKLVwIzUea2CBWQWMXdO0b+L5vk82fogKz8gy/2OXK7Mj1NEYJVV3FWg7ENqYq5H
         6qv2rjIFXJYJKviMbUnN54K5MIeLtpENqH+lgWk3NURvQhPP5S3h8uvQAAi/+/vLe/UV
         thQKakiGC5S1K9WRu4xNjGPmYrfKsyfE6i2KXhK5UwFZCsA+Dpvjclwe9h4KXkQhXUfW
         jkVg==
X-Gm-Message-State: AOJu0YzruaVwDp4dF1oSG8oSFOmjOlxHAXFh7v2oxKlk3MwdKelzVhSb
	HqXZ73dDQ3WGVtxlZdEDpgb5rL9uPyTFK/dgHo2boRZGrkUDt+orcasrFZb9i7ll2E69ygD9V3N
	w1jG6Ma3f8AWDgdDdmWZ93fbA+mber2F3x1CK
X-Google-Smtp-Source: AGHT+IGKoA96HuaTuG+3fQDaXyMVzq7OfBGue2nhs6iNBg/s2kJH6Ah5Mqr6fcx2fi+za5vUTWmm4mbUL4Mp/EnhkP0=
X-Received: by 2002:aa7:dcd7:0:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57a32d82edemr373a12.4.1717091209143; Thu, 30 May 2024 10:46:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717087015.git.pabeni@redhat.com> <cd710487a34149654a5ff73a8c0df9b1d3fc73a9.1717087015.git.pabeni@redhat.com>
In-Reply-To: <cd710487a34149654a5ff73a8c0df9b1d3fc73a9.1717087015.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 May 2024 19:46:38 +0200
Message-ID: <CANn89iJ-ah6N5OwDEsJAcNmjdDvJQjMoj-_iAaxSkYmfPt5PQA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] dst_cache: let rt_uncached cope with
 dst_cache cleanup
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:21=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Eric reported that dst_cache don't cope correctly with device removal,
> keeping the cached dst unmodified even when the underlining device is
> deleted and the dst itself is not uncached.
>
> The above causes the infamous 'unregistering netdevice' hangup.
>
> Address the issue by adding each entry held by the dst_caches to the
> 'uncached' list, so that the dst core will cleanup the device reference
> at device removal time.
>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 911362c70df5 ("net: add dst_cache support")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/core/dst_cache.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
> index 6a0482e676d3..d1cb852d5748 100644
> --- a/net/core/dst_cache.c
> +++ b/net/core/dst_cache.c
> @@ -11,6 +11,7 @@
>  #include <net/route.h>
>  #if IS_ENABLED(CONFIG_IPV6)
>  #include <net/ip6_fib.h>
> +#include <net/ip6_route.h>
>  #endif
>  #include <uapi/linux/in.h>
>
> @@ -28,6 +29,7 @@ static void dst_cache_per_cpu_dst_set(struct dst_cache_=
pcpu *dst_cache,
>                                       struct dst_entry *dst, u32 cookie)
>  {
>         dst_release(dst_cache->dst);
> +
>         if (dst)
>                 dst_hold(dst);
>
> @@ -98,6 +100,9 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, st=
ruct dst_entry *dst,
>
>         idst =3D this_cpu_ptr(dst_cache->cache);
>         dst_cache_per_cpu_dst_set(idst, dst, 0);
> +       if (dst && list_empty(&dst->rt_uncached))
> +               rt_add_uncached_list(dst_rtable(dst));
> +
>         idst->in_saddr.s_addr =3D saddr;
>  }
>  EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
> @@ -114,6 +119,9 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, s=
truct dst_entry *dst,
>         idst =3D this_cpu_ptr(dst_cache->cache);
>         dst_cache_per_cpu_dst_set(idst, dst,
>                                   rt6_get_cookie(dst_rt6_info(dst)));
> +       if (dst && list_empty(&dst->rt_uncached))
> +               rt6_uncached_list_add(dst_rt6_info(dst));

This probably will not compile if CONFIG_IPV6=3Dm ?

