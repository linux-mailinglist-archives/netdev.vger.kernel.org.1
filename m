Return-Path: <netdev+bounces-88824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977A8A89E8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A85D1C212B7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4617109F;
	Wed, 17 Apr 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VB/m3byU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33113D527
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373733; cv=none; b=eIstvt1U3d5UQtUk5sveqt0FHbupMBTsvLb4XjPomgYcLDCLRRGXNHV9Y3boRbrGeJGO/MalQzM5AqQ4McDRZsE+6yB+9UyRuHSey07o3m8JjQLC/DGdQpXnys8K7gOfN/2i4LsS6vfypschTiVEnxajOcb+C8qt/6tD99MIexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373733; c=relaxed/simple;
	bh=sOnHa2PNLJmMzfkGoG0CpNx388WUMaUS/JHYWFuSYlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAOPlTZSxmEYmSs3HO/io3PZPIeEN5dOVH6VV6FR6N8B1fPXWzXHKS0jpSn6Fniv2oxPoIaTzpIOTH8/vLciNowtldK4/s1geIUx3aSL4PpLdbiadg2aFE0q9HYf4dtF+OM+q5MJ8Ilgl7P66dilXZqI2MZn023f/7FIi2/zQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VB/m3byU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so4005e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373730; x=1713978530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCiT53MA4IlJDveEkNsoLj2mRPWOBydxZ7sx3kM5KXQ=;
        b=VB/m3byUlLYsiVMO7pf6m+RPwR+ZmOwKCSg2WyhGmlzk7I4jClS0aR9JvebQk4lp3D
         x/F/H0j2bZrLUePgXv+XzPa/xKYSJ/g30UpNgp8hOP1Ctv4m6PlTzUdh1BWJB8wO/sZd
         Sbj3mLYtADOyDCfKFsDa9krQRghXpUWwrYn5G3QPd44skfeoXkafwxOhRr9zXNaneRBE
         Zf6B5mXoRkoeKjF0IjW4wEJ3mqVL7MzCCO0wVowGEmnSwHJw6jct9ik8tI55tm4/O5FA
         dIbyRWVes/UXT2G5+05geMUW8ZqUY+E40ZD/qwKyWTGrbECxrZ29CPBdpkS0AsGxBgh0
         7pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373730; x=1713978530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCiT53MA4IlJDveEkNsoLj2mRPWOBydxZ7sx3kM5KXQ=;
        b=Anmygd1cEWu1Xp/5JQpc4RkNrflZbFqBIZWr1R5e9P5UhiM7oZHeajO+/Bvep56o6X
         KSQsXk6tRJpN2/QCd8VdKoAFths9DIcQSMGJTVuMulrRJEeDbvJsg6HGyNulsUr2T+Jx
         k5oLvN7qqp4Fk6uc5yHQBwc7HTLYEBtr4e9dGcPt13zTMiacJ4/a2i92/5XFSz7vF90B
         2yIvb2I69tuKlSG0j/L4BbZZInm+6nXEaPBXCWTA3NKbpcbU3mLZ8wT7HVmv/x62pTN+
         ls59Kl+KgBdrEN1l72o02zxKdsA6YjSW1wrq/KUbHz837WP3+XLaZM/4rtQRMhtO+iu5
         Rt+g==
X-Forwarded-Encrypted: i=1; AJvYcCXeDWuSp7X2nH4YOug1Er1zpNJIlPd5Y3f6pvCsNRy0MN2GbAZ9pEzfjSpP1w/IgpqFaFl2O4jFrVDa7q6q0SlQzV3CdgSa
X-Gm-Message-State: AOJu0Ywm9aCwhV1Xyhx9V6lGcwJ9YPeBWQjPaji3PbSihVGgzmxG8MM/
	ZCx9uc2ghzCzpkYodzExdRuitrLk84h5eLObvfIS/oRNk2p1tkWHAyE2afXOnUsWQMC5jOne9c1
	MODDjG0sCeN2g9E6gwxXrXLUAXxlwgZAMlrrTvu7acg+cP4nBKF/w
X-Google-Smtp-Source: AGHT+IEazwJ6/JG+q8hoVrBsdSrLEmLsQ1s5IFWRVsw94pKdDFi5Y0p/7642XrgxBCfBLws3+zguk7ezvuGYVS+JtX4=
X-Received: by 2002:a05:600c:3b20:b0:418:39a2:3820 with SMTP id
 m32-20020a05600c3b2000b0041839a23820mr219340wms.5.1713373730515; Wed, 17 Apr
 2024 10:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
In-Reply-To: <20240417165756.2531620-2-edumazet@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 17 Apr 2024 10:08:39 -0700
Message-ID: <CANP3RGceOxPAMWi2S2uV6MHSh0BX-tPM9XmaoPy0QwOOF_KFvw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:58=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Blamed commit claimed in its changelog that the new functionality
> was guarded by IP_RECVERR/IPV6_RECVERR :
>
>     Note that applications need to set IP_RECVERR/IPV6_RECVERR option to
>     enable this feature, and that the error message is only queued
>     while in SYN_SNT state.
>
> This was true only for IPv6, because ipv6_icmp_error() has
> the following check:
>
> if (!inet6_test_bit(RECVERR6, sk))
>     return;
>
> Other callers check IP_RECVERR by themselves, it is unclear
> if we could factorize these checks in ip_icmp_error()
>
> For stable backports, I chose to add the missing check in tcp_v4_err()
>
> We think this missing check was the root cause for commit
> 0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
> some ICMP") breakage, leading to a revert.
>
> Many thanks to Dragos Tatulea for conducting the investigations.
>
> As Jakub said :
>
>     The suspicion is that SSH sees the ICMP report on the socket error qu=
eue
>     and tries to connect() again, but due to the patch the socket isn't
>     disconnected, so it gets EALREADY, and throws its hands up...
>
>     The error bubbles up to Vagrant which also becomes unhappy.
>
>     Can we skip the call to ip_icmp_error() for non-fatal ICMP errors?
>
> Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Shachar Kagan <skagan@nvidia.com>
> ---
>  net/ipv4/tcp_ipv4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a64178d7ed=
1109325d64a6d51 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
>                 if (fastopen && !fastopen->sk)
>                         break;
>
> -               ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
> +               if (inet_test_bit(RECVERR, sk))
> +                       ip_icmp_error(sk, skb, err, th->dest, info, (u8 *=
)th);
>
>                 if (!sock_owned_by_user(sk)) {
>                         WRITE_ONCE(sk->sk_err, err);
> --
> 2.44.0.683.g7961c838ac-goog
>

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

Makes sense to me.

