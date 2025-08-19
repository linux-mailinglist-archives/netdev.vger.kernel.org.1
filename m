Return-Path: <netdev+bounces-214911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF9B2BC27
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A9E1BA36F1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233B31194E;
	Tue, 19 Aug 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghez2W9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468C31159E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593237; cv=none; b=eePhiF1kdGk+fNz+ASZ3oLWyVHmjCAFZEuWoZKPZH+P91k04PIDC+IVylZDS4Y0XHvglNi7m56TwWAfhJHF8ffa1Eo5DC8rZNxhx1YaARsYvlLFsriIVdSr+l5JloZIxW+Iqoxto3/CTegsjm0k0/ROVE50EPEBTDtbN5Jc1ibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593237; c=relaxed/simple;
	bh=jYLXe5QCSU4Gs2P5pMxvYSKcjUVhNYe9tWHDneqGIYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYZ+wE8T7joBfJsvz1zPufV0qBca7iLc4jOFOdG6WW/NF4WQQqdK5sj+RhVmu0a6BJqmjUVsdbjrrzikSHbRG/ykQqIvfNRnjiWovaIWicWwdEJQZkpfaQLvlyT1OhtpaTDirKTbh3Hh9fPEcSxFLdUNtJ6YvOf7L+kZS0JHtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghez2W9x; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a9282f475so43358436d6.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755593235; x=1756198035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjTOjrKpq7HcHOMrHkF7ZbVz5wRss5ik5G5OB8UHHE=;
        b=ghez2W9xaYog1lJncuXoF9PAobjV4ZkNi/UbToVqw8CP1y2SR4XUCpUebRApvwbvdb
         Ov+tlAXqCHqiSVO16TL+dNiWHNqqtkzS/+k8btllYEzU4tN4O0dG7/pEL1ZaAlItyqd5
         k/qehHpzzSYN0sOBRqoLOZFqdXuWcvxSO6tKCm62roVepcR3WGVz0Vl6qUVzt7Dmsmt/
         07WHwh/70IdAMCW809xmDWOMvLI4L/JnD+DmIQp2V0oX+nqjMa3DN7kaUIuXA8ZntsA8
         //N/HD9aZvOplBWlbhRBCvE6tX/Kaepqq42jetmnsmOjdfFJxcIbqT4DS/GZEvXP7ccp
         163A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593235; x=1756198035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTjTOjrKpq7HcHOMrHkF7ZbVz5wRss5ik5G5OB8UHHE=;
        b=WAoeruNXg6Q8sG8ZUcybSdfGEgB+ydgkpDEJZXyfNLMj4BSd5ycqAc1QQ7FS5380Me
         YevJ1xv4ql+Ttha6X2tUrP0lY+anCoErQalu0IX3hzMNW/7ZbKi5X8WIA4JJz8FZGJKD
         rx8lT4YO+G92lB9U+UN8omCvXx1M9STXJwLsvR53Ybrjx/zk8YSGG8ybOEo27gZMImhk
         mfC1rWm3p0EK+x7GrbXxO1XbbV0rXRu8ZxsQOZHs3GddTdER31Cb6erj/TGcFGidZal/
         jcpIKd1WEZLIoQ+Fgm+Sc9Z1wKii44FBO76TNuLqQTvIxm3+9hf05iHkOP4+5H7DqqUE
         nlSw==
X-Gm-Message-State: AOJu0Yzkh07jGbFGiGo+Xj0bqm3GyxyrOZhRqjWodaXfHtiIKD8bjDa2
	veRIAmAlMqGPCNRA4WjVRUT64zv9so8WxTfGu57DG05s4EkmXTMflKUF03ZBcTFEl+jgpAtxgWX
	FmT04NZcZBRazJzawP6bk4oNCpsIu9Eka7DFJ/JyQ
X-Gm-Gg: ASbGncvD/jB2CX8dm8Uk0e9wPOvOUTNkPXpUxA11TGbWthj4whjgeCn0GRc5P4YVwAh
	HqAYjfG+iE8QDoeEfYHlCDLTp0q3HRWLS8V+XhjbewD4uVIwTqZEof9aai88l4O1ntveKNDDGqY
	oJS6WwbZ8/osWrfOLnUQHPrDadyKyJlqLTi0s+pUiIie3lM+0XIGrhXzPotoEPMqu3C//dOUfR2
	pQpAPJ8QmOpWxg=
X-Google-Smtp-Source: AGHT+IGHTzLeNk8ykX+lpN/s5xUDjFhZiDUiNtDjALn7/NzmVRolIT0jQeRREaRRmVzzKNX71GQdH8cn8uZTsOWBwhQ=
X-Received: by 2002:ac8:584e:0:b0:4b1:226e:bce7 with SMTP id
 d75a77b69052e-4b286c6f9e3mr19777321cf.26.1755593234750; Tue, 19 Aug 2025
 01:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819063223.5239-1-richardbgobert@gmail.com> <20250819063223.5239-2-richardbgobert@gmail.com>
In-Reply-To: <20250819063223.5239-2-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Aug 2025 01:47:03 -0700
X-Gm-Features: Ac12FXyp82W8J4J-AaMbBX0uUMle9ZdE5ooUJY4dnTJNG1DUI1ywoFZBUTgbfZk
Message-ID: <CANn89iL8XHOeBbq_73SiCEEhYrudeDVagtr=K6wpEkh9JuZV6A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] net: gro: remove is_ipv6 from napi_gro_cb
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com, 
	salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, 
	ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, florian.fainelli@broadcom.com, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org, 
	linux-net-drivers@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:32=E2=80=AFPM Richard Gobert
<richardbgobert@gmail.com> wrote:
>
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
>
> Using sk->sk_family is reliable since udp_sock_create always
> creates either a AF_INET or a AF_INET6 socket, and IPv6-FOU
> doesn't support receiving IPv4 packets.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      |  3 ---
>  net/ipv4/fou_core.c    | 31 +++++++++++++------------------
>  net/ipv4/udp_offload.c |  2 --
>  net/ipv6/udp_offload.c |  2 --
>  4 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index a0fca7ac6e7e..87c68007f949 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -71,9 +71,6 @@ struct napi_gro_cb {
>                 /* Free the skb? */
>                 u8      free:2;
>
> -               /* Used in foo-over-udp, set in udp[46]_gro_receive */
> -               u8      is_ipv6:1;
> -
>                 /* Used in GRE, set in fou/gue_gro_receive */
>                 u8      is_fou:1;
>
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 3e30745e2c09..261ea2cf460f 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -228,21 +228,26 @@ static int gue_udp_recv(struct sock *sk, struct sk_=
buff *skb)
>         return 0;
>  }
>
> +static inline const struct net_offload *fou_gro_ops(struct sock *sk, int=
 proto)

const struct sock *sk

> +{
> +       const struct net_offload __rcu **offloads;
> +
> +       /* FOU doesn't allow IPv4 on IPv6 sockets. */
> +       offloads =3D sk->sk_family =3D=3D AF_INET6 ? inet6_offloads : ine=
t_offloads;


Do we have a guarantee sk->sk_family can not change under us ?

IPV6_ADDRFORM is available to UDP sockets after all.

