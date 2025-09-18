Return-Path: <netdev+bounces-224244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B214CB82D67
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409EF1C06960
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6823C4E0;
	Thu, 18 Sep 2025 03:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0ZSP9wg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5551F4181
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167896; cv=none; b=Un9iImu+1eCNwe8eGLXkON/9DpJCjGuPdefIQJu1IleVr7ROVf9z1y8ZD73+wHAH5CYCbM5V5QoYvy1Qvv9YgP9loWbOgetCev2+eH7ktsE0Kj3BeBmTPtUh7Caw6iW0PCvDW9Xo5DbNl+P7MeJpy4yBCqsrd7INpDR4d5xdY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167896; c=relaxed/simple;
	bh=L/iM+X+hYqFMbGNYzuJeI0YYHeP7HynNQsTiwP1b/Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP6q8/o+vyJzPUl2hwB9li49MOkYxY0g2mYSp5qlK0Bi7qPoeXSTLa+4lMp19QGjrVxrfMvWiNW6EWvjWFqLk2c9X+44MZ8qxED+aQWcb/y6oZyGvcyKTOMUYrJRHsCE4+7jIFsjAj2Pfaei52ozCTiNvobEFYGvNKBpHAz7Ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0ZSP9wg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so5313441cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758167894; x=1758772694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REYpU7LacfENP6A0SW466yPz7Qi17NcMuns38quPckU=;
        b=D0ZSP9wgluW8OANPKHw3o88EmJJEPn8lf53nGttoXdua6SeAQ8ARN8xLIFQZxLPdtC
         5vaE+qkaPIyxnBl1hN6i4v27rAAIA8D9LBokYVk/y89MJnKusT8HjqDWIfqg3S8NwH9l
         GV5c6nACNQhw1J+ckPCTZVcDlLDrF5bOCaK4cePFJjPJ31jKCtts+NHvOI7JD1sjVxGY
         eEZZe4ZTR94RGVE6ePlPjmxowoyVjeXKdUZZrRWShUWtHSPEQG3kN3l0+XxBSTxXRJnQ
         GGOEAymkWqlVFQgsAoq1fuDFsAVNYWMidNiLgyqroJ4niVevD3HTblZNITvqn86qvTxd
         tz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758167894; x=1758772694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REYpU7LacfENP6A0SW466yPz7Qi17NcMuns38quPckU=;
        b=wLsu7dSrve7+DM00vSCgd3ZwSYUTwYh7SIa/TYPfZFeZ55Z/XvbK3wKeOuSLrVbV+9
         6y39bkxPNfEA9g3DnHbRnjvID526vTYX62NUW4BqQIl9lpqFD6FNYf4vKN9sK9MuTSTR
         xvxMC/sglf7f4q8YbYIipfwIMN7YqAI07J66jx8hc5+6sOd0BMpMlpjb3N+ntcQ80cFg
         MGmcbjfwRZwDpjENQAkxNuzQG66FBh6dtlOFmHkHMhONnyZzdEi1dnjsDQ6RFaBDO8Ka
         IjorCH6zwtELlUhC35OfiazNk/OJF4MguGVdzvagLAGm0CKTI94FQ9en2VbqRo1spqKq
         lifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMTM4IqbWw2PejgJx7ggWI2huSUxSd5/7POJ/JbMWoU4DbBR56Wy91BxZ9mCCeVP0X3236Ex8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghTTGrH3Y/g87H6HuvqTemqzT3Q8e/IKcqLM85WTc2341ioYr
	Rks1dnvrCajeibT9NHQlOsuT3m79ICqtMpw9niNwlsDFfIAXP3RitfMFWK0UvqDm328XKdTKuTm
	JZH3m0M4s2BrRj468nEiEB9CnmxWDyGM7MHbeUjma
X-Gm-Gg: ASbGncs22G1lXJ0+6Bye63KSU8OuTg3HPtoKcjIc+QN2czd1fP8tKqv78V2OTZ0tALP
	h/hxXUvA0AAjiE5C3u36wcOyjvrbS9YITcseQjZZM2nocE9bFw0OnI8vjrRUxLmy1SvyUd1P1bR
	V4Ahj0V6eQeCM+1F62U8+iWwXsjcFbsARD9AncvsvQJ+hZ64a2rNCbf/J7lxFOjcxuyJLg6degf
	/oR+etqyVH4Kxv/SV6zlCiOL65Jy4Ty
X-Google-Smtp-Source: AGHT+IHtz17yvhI/0eRSSRhKVwaBa8lxW988D2yvu7qD+blQq7cNdNty8hkthm3gB3zTGz2QG16xKLmMG9JJLAnM9N8=
X-Received: by 2002:a05:622a:1e95:b0:4b6:1a4d:36f6 with SMTP id
 d75a77b69052e-4ba6d71db4amr49633501cf.83.1758167893187; Wed, 17 Sep 2025
 20:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-8-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-8-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:58:02 -0700
X-Gm-Features: AS18NWDImsTVAM6gN1i7XUtfamAIDA7VuRF5Zl6e-nCIsuSdfKPKVffx68T3_8I
Message-ID: <CANn89iLkfEhGrLvCFMJi1qxrF2qJgHoceDBhPEC5hWnWffn_cw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 07/19] net: tcp: allow tcp_timewait_sock to
 validate skbs before handing to device
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> Provide a callback to validate skb's originating from tcp timewait
> socks before passing to the device layer. Full socks have a
> sk_validate_xmit_skb member for checking that a device is capable of
> performing offloads required for transmitting an skb. With psp, tcp
> timewait socks will inherit the crypto state from their corresponding
> full socks. Any ACKs or RSTs that originate from a tcp timewait sock
> carrying psp state should be psp encapsulated.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>
> Notes:
>     v3:
>     - check for sk_is_inet() before casting to inet_twsk()
>     v2:
>     - patch introduced in v2
>
>  include/net/inet_timewait_sock.h |  5 +++++
>  net/core/dev.c                   | 14 ++++++++++++--
>  net/ipv4/inet_timewait_sock.c    |  3 +++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait=
_sock.h
> index c1295246216c..3a31c74c9e15 100644
> --- a/include/net/inet_timewait_sock.h
> +++ b/include/net/inet_timewait_sock.h
> @@ -84,6 +84,11 @@ struct inet_timewait_sock {
>  #if IS_ENABLED(CONFIG_INET_PSP)
>         struct psp_assoc __rcu    *psp_assoc;
>  #endif
> +#ifdef CONFIG_SOCK_VALIDATE_XMIT
> +       struct sk_buff*         (*tw_validate_xmit_skb)(struct sock *sk,
> +                                                       struct net_device=
 *dev,
> +                                                       struct sk_buff *s=
kb);

I guess we could use a single bit instead of a full pointer, as long
as the only user for this method is psp_validate_xmit()

This can be done later, incrementally.


> +#endif
>  };
>  #define tw_tclass tw_tos
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 384e59d7e715..5e22d062bac5 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3915,10 +3915,20 @@ static struct sk_buff *sk_validate_xmit_skb(struc=
t sk_buff *skb,
>                                             struct net_device *dev)
>  {
>  #ifdef CONFIG_SOCK_VALIDATE_XMIT
> +       struct sk_buff *(*sk_validate)(struct sock *sk, struct net_device=
 *dev,
> +                                      struct sk_buff *skb);
>         struct sock *sk =3D skb->sk;
>
> -       if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
> -               skb =3D sk->sk_validate_xmit_skb(sk, dev, skb);
> +       sk_validate =3D NULL;
> +       if (sk) {
> +               if (sk_fullsock(sk))
> +                       sk_validate =3D sk->sk_validate_xmit_skb;
> +               else if (sk_is_inet(sk) && sk->sk_state =3D=3D TCP_TIME_W=
AIT)

Interestingly, note that we check  TCP_TIME_WAIT in places where we do
not test sk_is_inet(),
like in sk_to_full_sk(). Time for an audit I guess.

Reviewed-by: Eric Dumazet <edumazet@google.com>

