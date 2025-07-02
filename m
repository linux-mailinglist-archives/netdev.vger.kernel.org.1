Return-Path: <netdev+bounces-203407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F9AF5CEB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8301916BB87
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC372F198D;
	Wed,  2 Jul 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qO0k6M2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C3288C97
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470003; cv=none; b=fyWpqBEOS67p3HnoA76QFb0DP0s6YC9huK608omqzaD6cnYxu/7dgXqgcZNRatAl+lycJ15T8k7LG28YCDubYwsLBmaYpG9X0RyZgk5yRBnCTRSDbOU7dGNwYyTrmtBXuOW0O6O0tP4FnQ3wGZ2XrvRfEQdLkZgQmaOo1/GbXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470003; c=relaxed/simple;
	bh=yTwTjAEsqE8rj045/ciU4b52UtCHhuYIPzLwtPO2e/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/S98RwJrg3kPSkoU3tqh5OdnidGu2duxjlXUH4dSUx6LyfMXhzT1ThfRyH2b18o5tz/btpv8OFPgThY6Ykzpbw0tZ79OqP1PhNxIvDllbq/4cck+IQXFOjXdsjmMo8QfoEIJux+SH9GuojWgSXjUi9igwFj35ajjv/Q35Fzr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qO0k6M2w; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a98208fa69so202361cf.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751470000; x=1752074800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCPXcNK+DUyogAPJxVpc3HAuduDHqfqUzIGLlK3xdwQ=;
        b=qO0k6M2wEE0hfRDZm10j2qfUrNqLLa+SjG6m2Cz1GqSMLtbQXkt93fygg4dow70V6K
         ZzXcE4rdHZtrNC6jAd3QbkNjJSjSEEo9AhTKvA6DXDKaI2wdRtKVIXno1OYyV7lSitkF
         djWXeGXfPy6TydK2v3q5rHtm1njjalTzl1EW+9QoOzDwNtDjwf/T2Qtj2E2rIvtv1Sty
         g+vmh9Sp4lRwQEiVNvJGDxngVAt6SbxzkKisNL0WjNL5aXdildWszBBnhlEVimvMJ+gw
         SUgcSNTslYTo0mlmzi8oZfMiCqpSWSK3x1Ii2ajqXIKQmNBjQbxvmlWmmk43PCDWHfqK
         iQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470000; x=1752074800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCPXcNK+DUyogAPJxVpc3HAuduDHqfqUzIGLlK3xdwQ=;
        b=K36ozvbkwkVyt1q31CND2xIXmFqPeujpRuwjtDj4dqu29RrNj2utwtWMfT7MwBmhJz
         3VzCR1qJJpaMe0N21NS+EX4q0vve9okdgy4etrEj5bDM+MArXmZMuSN1mWBfk+hilO8D
         80r0tF0c6zOqiVr9SWUZs0U9MbjgWaX8CtVpKYRzjF9nGgIypBXdq03H7cyIu2Ds5Euw
         0+pudI9GxhtMNxY/iW/xBwn/IRConbvP3nJk/EgPd1AdKGjuAOm+A7EVM0uzk9XV8qB6
         ip3q5qGzpOxtzkau3zBiC/aY6usEZSAmtyUBSuZmJmHKmq09M/ceR9N0uP9nEU0VhP/a
         Yk0Q==
X-Gm-Message-State: AOJu0YyhjklHdQRjTIwxv7wyh7UJaU0nPAtXlEqBTQsDxD1yQOVCFCSZ
	khJuzGi8505oOXe2hTYfaswbo92ZC9P2HvLgdJYrGl7y7bzduJ42Ty/AkC1JjGcOIYdt7H6SJlP
	fihMNJx8vibXQhGg0a1bnyUSqnZ/qsX66kF9ij0fM
X-Gm-Gg: ASbGnct6TU1FQ0uFj25SykodcNH5fjrH+on+/05Mt3l8zKhkulc/cUXsBOSXRyjoIzB
	l7jPyca+umQ0DJqsI1Se5kszLvfcc0oUqtW9LOzKMN2DVEywEmd8Di/+bXy477SoxVQSm63S6uV
	Mq3HpxsAnEK7vmhRDHGXiW4YpDhaWfIH0OibnqyJRr8Q==
X-Google-Smtp-Source: AGHT+IH6CmHt8lPy9XENkmI+GA/Cv+r7CIhuq+Az9ScfxiFnyCFfXb99vMuNSbCmH6thvLn8wp9cASXm/JqpECT2UKc=
X-Received: by 2002:a05:622a:4a0b:b0:4a8:191f:1893 with SMTP id
 d75a77b69052e-4a9781a6c80mr46335991cf.26.1751469999922; Wed, 02 Jul 2025
 08:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702141515.9414-1-oscmaes92@gmail.com>
In-Reply-To: <20250702141515.9414-1-oscmaes92@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 08:26:28 -0700
X-Gm-Features: Ac12FXzRVX_eX2sqMm4YSTrDpzTWZI16IKpRrmn5eNbVSJYT11OpAEK61oHliW8
Message-ID: <CANn89iK0Hu6CZQ=76+z6p-TPY4bTmEQh9SAgLu-==zNB9RrWMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv4: fix incorrect MTU in broadcast routes
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 7:15=E2=80=AFAM Oscar Maes <oscmaes92@gmail.com> wro=
te:
>
> Currently, __mkroute_output overrules the MTU value configured for
> broadcast routes.
>
> This buggy behaviour can be reproduced with:
>
> ip link set dev eth1 mtu 9000
> ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src=
 192.168.0.2
> ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src=
 192.168.0.2 mtu 1500
>
> The maximum packet size should be 1500, but it is actually 8000:
>
> ping -b 192.168.0.255 -s 8000

Looks sane to me, but could you add a test in tools/testing/selftests/net ?



>
> Fix __mkroute_output to allow MTU values to be configured for
> for broadcast routes (to support a mixed-MTU local-area-network).
>
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/ipv4/route.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index fccb05fb3..a2a3b6482 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2585,7 +2585,6 @@ static struct rtable *__mkroute_output(const struct=
 fib_result *res,
>         do_cache =3D true;
>         if (type =3D=3D RTN_BROADCAST) {
>                 flags |=3D RTCF_BROADCAST | RTCF_LOCAL;
> -               fi =3D NULL;
>         } else if (type =3D=3D RTN_MULTICAST) {
>                 flags |=3D RTCF_MULTICAST | RTCF_LOCAL;
>                 if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
> --
> 2.39.5
>

