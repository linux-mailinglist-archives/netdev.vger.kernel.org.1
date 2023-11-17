Return-Path: <netdev+bounces-48760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535047EF6DB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AC81F226D0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7D4314D;
	Fri, 17 Nov 2023 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBSzlkdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ECAD72
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:15:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so13573a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700241322; x=1700846122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgyNHLwb0dCQ1IvlWod8L7reerP9hkPsOGuvcVTdywg=;
        b=mBSzlkdVuTTDp0sbH//yk/Df5seSktt1cKvsclg01h8kgKOuaGQDTsdPta6wd10z7j
         ipeM1Wp4IQP7QqWzpdjIxCagToQ1y8FbW9cAbluhIizqfS1heYRdEEJ+mq4TpQTlEK7S
         tIdOx0husrVAC66FtscwTBAj/p26nDMMzOb5tqbzf40UxCHymXGP3aXSkLBpfM4y7R0z
         wtleBuPqm3eBgJIQJ3P9OqcJwSFHD/ZVsIK4VlALNTG8m+NQ68VbW4mxA7K0wItL0vkG
         fk/mPsbs1es6oaasxQuXweTRq+RD3c5h4XpElSM/3WoGxy1VAn2dWMpVUxnsC16Ni5DE
         548g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241322; x=1700846122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgyNHLwb0dCQ1IvlWod8L7reerP9hkPsOGuvcVTdywg=;
        b=hxIjrHRA9N/THLchG7jbwfMgfU2BSwrEbzvJ0A0wpWU6jhp8Gq3TNJq8ZgelVk62l1
         EshSRfswOJ3XpPTRz95eXDvJvoZ7N6SDjCZh/EdQ2TMMNkzfB1lDYdkFMbiE8ZQSDkSt
         eZkVa3icCMi0WsHXmVAZReRvMHc7yJ6t0wslpEi98p0CGp3BP7/MZrmrdrTl364A+72/
         8y8mAOgRpWq6WGbNfAaRpFoGZoq3uOeZZp6UGSzVaL+RrdRuBGHusiPwBHZj/fdDkRuS
         PwyNbbtDbrkARjIi5JjLdKuDNWXUw0a9UozoWdZWklqCEj1foCVPaitp98Rb5UJomAZP
         mcYg==
X-Gm-Message-State: AOJu0YzSSS/D0ZwygJn/6Z64/pKLpqYk+xEj0nbzJ624aU/ghv3bkss4
	2MqR6OJGwCFRGB3ZFJKhGMZl74FW1M5ZtVGSvTOyhg==
X-Google-Smtp-Source: AGHT+IGHaoxd6OBoU/9H58wg8QaFcYeqOGKdluo8DNtBVbnfVOwOK02JJAT/4aIMsyxVMxrNja0cakOcyd6K3U/OEpY=
X-Received: by 2002:aa7:c954:0:b0:545:279:d075 with SMTP id
 h20-20020aa7c954000000b005450279d075mr142936edt.1.1700241322418; Fri, 17 Nov
 2023 09:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117152728.2286551-1-chentao@kylinos.cn>
In-Reply-To: <20231117152728.2286551-1-chentao@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Nov 2023 18:15:08 +0100
Message-ID: <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
Subject: Re: [PATCH] ipv4: Correct/silence an endian warning in __ip_do_redirect
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 6:07=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different=
 base types)
> net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
> net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

We need Fixes: tag for networking patches.

> ---
>  net/ipv4/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3290a4442b4a..e8a542c6b031 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -780,7 +780,7 @@ static void __ip_do_redirect(struct rtable *rt, struc=
t sk_buff *skb, struct flow
>                         goto reject_redirect;
>         }
>
> -       n =3D __ipv4_neigh_lookup(rt->dst.dev, new_gw);
> +       n =3D __ipv4_neigh_lookup(rt->dst.dev, be32_to_cpu(new_gw));
>         if (!n)
>                 n =3D neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
>         if (!IS_ERR(n)) {
> --
> 2.34.1
>

How was this patch tested ?

You are 'fixing' sparse warnings by replacing them with real bugs.

be32_to_cpu() is going to swap bytes on x86, so the lookup will fail horrib=
ly.

Here, if you must silence sparse, you want (__force u32)new_gw

Look at this commit for a template.

commit 3c42b2019863b327caa233072c50739d4144dd16

