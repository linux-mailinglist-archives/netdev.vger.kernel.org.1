Return-Path: <netdev+bounces-213819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA0B26EAD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA42E170AC2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554EC136347;
	Thu, 14 Aug 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXRMjfUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0F8834;
	Thu, 14 Aug 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195365; cv=none; b=cm9SxSzeUvsaciamhLweAInBg0fnSZqIl8EJHALhxMKHHAkaKFJxr9S96eVeAnjki8CWn11FoR00Lx1FKelw3Av1dK9b445FMWyagsULNBXTrR3LMa3+nPZHKrLjCLcJufjpC4vTNWFtR5jqrctokTzPYK/XeOKpUZ3gigeKpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195365; c=relaxed/simple;
	bh=lfR5m4C6qpeGF7BqklRhmXMKFJ//+lAnAnq/PFTEm3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAMmOXjVL3AR/ZtjFcaWEA/iahQgS0rNFVS6jB5MeVWIWIbvjdEvkj+GR9Pmogi0khzL7lc7Xp9Qxonye7QK/XXJhdtuhOVFJ/IITFSXR6h7qIg/TGXi6prDTLsqMdtPd6QzjcY46I5hdDJCNAnwCwKZQk8KV1ayaM7cyuP4uag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXRMjfUx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d6059f490so11387687b3.3;
        Thu, 14 Aug 2025 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755195362; x=1755800162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+n4/FeNOVvGWacFWXQIqguWy7zGbFv1DUiyZxjURns=;
        b=PXRMjfUxyW1eH5BBggU5NkT+3a06M3vzq4Y4kYYPIO/vm8+5zNxn5DajbE68leq9PE
         XuM6k0cbqxE81MFFKPoRiAdX6b8f24dgh9bEUsYHMn4Cv82zFQEmqqag/HUCx7v3/zrw
         IQlIUuHbPElK4CNxR1A8l0VfNB93a9+f9i9+miQ6z61jfMyvBMVTzqdAgyCSpUTmoX6z
         DkP80oPSOgFle4/GppWtJc0uEdATSLZgQf2IX0V3nXmqUisTVHiJd4IFqd6oVW56guM9
         4FHBTErUiG+EF3z5cOSeXMnSmMLtK42i5NYRZEBt6yaGo61ag4Cu8Ua4Vqjm0U68rnUJ
         uq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195362; x=1755800162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+n4/FeNOVvGWacFWXQIqguWy7zGbFv1DUiyZxjURns=;
        b=RwBD2QSgmot99pibcIlIz02m3BgCj7I4awjLjaxgbXYh7GdRVq7HtNytBtY8sPi4vD
         s9amiGGflDuhf5UO/etkM6UhJK7AlKidzJsNqdKBgnmy5q0AEIIbwgpaM8GOSvq8sqpR
         gYUsWmGb9sI3zjC65ux6YFFWHH96HxKoTyV2G627VRoPV8Po33uhjNQcNCvdXHMMwqFT
         nZn6QnzLhob9+liKxoHWKQi7NnfNCUEp4/BjOUGsh9A3UtFdH0NbVl18X+FbLobL28Cv
         xFDm7CNrCt6FpM6ACOAC1r2KZ9rKl12aGCewqbFM9Kx3iJlPVBoyvF0mxqR/1YURa6+j
         L7YA==
X-Forwarded-Encrypted: i=1; AJvYcCU1i4jH6Cw4SlLSWcKjOWy09aQYf4NdNB99rujy7AQegYUtNQJ0SjqcHSY+rQanMfElIFnTVvuJ@vger.kernel.org, AJvYcCVskjFs6Oy5v2Ia+dceKpcNaWy7ekJVvI/hbdPjGHZ/aDHhMiWrm1YuxtL2qTnWYU4LFWrZREWJ0Hdh2PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Kj8xNht6fbbgKgfG+j+MVdMN3bfnoj8JrCVgeEHUSoIQYV2z
	2P1Syy+5Kt1BqwrokkKLwkJOLPRmO5u3o+K0dCXlF2CqfQRqZP2gw3+FnPdumJfETu7P050ew99
	ieEjwd8IfqzqMqUnK0o2DnHob37EOpaw=
X-Gm-Gg: ASbGncszDTJxmQed7zBhMhM8AZ3hz6NjiPS0+gmJbzHSchAJIkBl6oSMRzqYf3j/sZA
	kqRpJMQVBceJWl9apjTbJypDREuy3q7O1tOQ85WWwDV5Am+orDWQX+QYEdPl8fBzF6F97OxElU3
	NrEDjZlK2EyBZtekDZwKLhIpalQeCATH9AIk8lmDvsx867QJI8JBEWo7RxnZIy3nmazPQtQS37y
	wV0pDh912h7ZlWf33GLZV7eg9d/wEJ4GKE=
X-Google-Smtp-Source: AGHT+IGfpA6WLqLoMafirvagHvFBKAIxZpGtck1OYWE5+xJQUQ5A40uzUgqaBVYQ02HSxIUhyuJwK/zBp85IPpmZZE4=
X-Received: by 2002:a05:690c:6103:b0:70c:c013:f26 with SMTP id
 00721157ae682-71d635b3ab1mr53754757b3.33.1755195362372; Thu, 14 Aug 2025
 11:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814172300.57458-1-zhtfdev@gmail.com>
In-Reply-To: <20250814172300.57458-1-zhtfdev@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 14 Aug 2025 20:15:25 +0200
X-Gm-Features: Ac12FXx_XcXnWKz9GdNfc372MhOuX6-i0nxWtxdWnyxqLeh1JDk-xBvVwPU7e-Y
Message-ID: <CAF=yD-KTwwWMwTMtLBkwWORB26Ty64o8pw1QxBefDmkHi6rL0g@mail.gmail.com>
Subject: Re: [PATCH] net: tun: fix strscpy call with missing size argument
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: =?UTF-8?Q?Miguel_Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>, 
	ason Wang <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, Network Development <netdev@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:23=E2=80=AFPM Zhang Tengfei <zhtfdev@gmail.com> w=
rote:
>
> The tun_set_iff() and tun_get_iff() functions call strscpy()
> with only two arguments, omitting the destination buffer size.
>
> This patch corrects these calls by providing the required size
> argument using the IFNAMSIZ macro. This ensures the code adheres
> to the function's documented contract and improves its overall
> robustness and clarity.
>
> Fixes: a57384110dc6 ("tun: replace strcpy with strscpy for ifr_name")
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>

The two argument choice is intentional. In that case the length is
taken from the struct field sizes, which is more robust than an
explicit argument.

https://lore.kernel.org/netdev/6899fde3dbfd6_532b129461@willemb.c.googlers.=
com.notmuch/


> ---
>  drivers/net/tun.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 86a9e927d0ff..88c440c99542 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2823,13 +2823,13 @@ static int tun_set_iff(struct net *net, struct fi=
le *file, struct ifreq *ifr)
>         if (netif_running(tun->dev))
>                 netif_tx_wake_all_queues(tun->dev);
>
> -       strscpy(ifr->ifr_name, tun->dev->name);
> +       strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
>         return 0;
>  }
>
>  static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>  {
> -       strscpy(ifr->ifr_name, tun->dev->name);
> +       strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
>
>         ifr->ifr_flags =3D tun_flags(tun);
>
> --
> 2.47.3
>

