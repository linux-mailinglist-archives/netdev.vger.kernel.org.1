Return-Path: <netdev+bounces-222222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A3B539B3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B95177AC3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248835AAB8;
	Thu, 11 Sep 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVkJ524T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9635AABE
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609633; cv=none; b=oUYT1il04t0eYz/083x4vXTSm+6TXcmcCoA2Y4t6zDeP+RMBIudKxEsQPH/ZcXOLWdYEAvQFVYhbaEAzMWgOuGPKBNwdgx0GUU/R/ZeGDezhg5etOsJv87B1AoNO6422gg3+x8w4h+AdAdQTsGpIMIQxuZt7sMPkodWBFV4Phuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609633; c=relaxed/simple;
	bh=c8WFOk8X5DTl5jpcdbOLzsBuSjihI1HDyw8bbGNhIgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSF3cJYHmCGdvy+70ff5spoKO42JwN6Keuclc/5/U8+wtp7gGPiSm/U4sF9tJUXSPBzXCLhBW15ccMGcdIsX9rj8hwkDlOW7yXT6m0AiEjrKfA1WpZITv8LS9On8tOXlAS9+kJSl2DRWXwjIZItfypd7NjhmfuSPyTSFi28N9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVkJ524T; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cb39fbd90so8508535ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757609631; x=1758214431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkvBw37pyQQ/Ii4F9oRnTBovl9HPSW1iZeQONvhz8+c=;
        b=BVkJ524T9LlR0kyKGd3F26gSHCwVx/J26ahH0wv/KQtR523Ze5kUOi6lfFl3CqgiJk
         kBhwjOmwBSyq/J81GNCROuhmwX5zU+9Ga8DIaes/RApQpen16lx29FSP52KK3K3x9daS
         YgR/E8F3bBvWsrt9/Tmz8bgpy2QPlLT6Y3wcjtk+zATtuqwb179jxvQRuaOyHsyqyhXQ
         OI8Sw2QyvOxXy38J77ZhmikrEyGkhS3XzpV9HJDXGylPeo227NyvU/PjXQnSFCG1AVhe
         xhQqbXqHq46D90eJVgzHGcIMJEMC0QKbI3i4XEDBsoU7G+OrAYyZcvwNIzjCN/MwyiOH
         MiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609631; x=1758214431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkvBw37pyQQ/Ii4F9oRnTBovl9HPSW1iZeQONvhz8+c=;
        b=j7Yf+yF++QBagCeHaMyAYmF34lB9eI3OMQkYb7SrgbmybaiLQN9MQo9O2cvd2C+75A
         fw4WwA/Y4yoYM73t7bgN65RgEFrgHLBJSUf8dSu4Frvg+BxmdIeZ8I+SLg+Q3Hu2syQw
         wB09jcSPUQlH9WInxEDvjEHlhZEEdaz4Co1fvGSy+sxpvu4meRc1fH2BSW5QqZh+Gn5j
         AsvCa4ykMxbvfxlHewzBoEygcLfSIZRiQHtydkphxaN6IEqH4/r5aXsE0z/I95mB+hBF
         Yfj9zmvV2mbGdt/Boqt0+gIVUmVVElDaXz79ENbkVAMNXpYl6cPaK/hhRKU4Ey1S+rj8
         AeMg==
X-Forwarded-Encrypted: i=1; AJvYcCVnz+eAYSEy8uzs78/BvS8DJWMMzwix66KDL9Gy4l9/IGpWXGZvNh/pJDQdNogtn9roGBY3kcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI14PRCe2lZUewiLMsSYk77U9+ZjDx5AI/ZGixbErbHzzQb+cH
	uau3F4QShb4gW9GAJLrLpG/IHZUDG3WLdxdacYQLVP8k+3LiKGBeBsH/mWWg9WjELvTwgUI7AZp
	qtDFFNpBe0KvKdzx1euRsDZKMeqGAxaRGcLzqT+WQ
X-Gm-Gg: ASbGnctjKct1hZM5fch2MWbexO4cFJNY/GfhdtkIPTc2BIhuxmPyEP9r8aAkOewX+0M
	Vycu9i0FZrYMHBl8NHSu+X4ByyphSoRMasZiVoiNPpOAuPJXOY6oeafqiMPuRl/MaAtA+2PczaY
	A3mUB81FUmIPLldTAUXw0jhqedUFSK9K/NwVJ+QsruWTVDVMAQbwour8XMWeJWD5pEBhLKUF8d1
	hfeRWG2JG6vx6sCxcLECkUvsuHCOwou0YegROCYTQYe+w4=
X-Google-Smtp-Source: AGHT+IEmZhV2/tQk1/bIIdLrrvfwflsDnhbHAUkStTJSLbsnf0jkCzJnIY8eUk6mYaJv1F3gPeNZScC4WiOnnxA5Dzk=
X-Received: by 2002:a17:902:e552:b0:24d:3ae4:1189 with SMTP id
 d9443c01a7336-25d2587cf95mr1037705ad.26.1757609630501; Thu, 11 Sep 2025
 09:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
 <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
In-Reply-To: <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Sep 2025 09:53:39 -0700
X-Gm-Features: Ac12FXwXjfcwcwXqR2mjxPIAi1AYEj__CQs3pkdBo6r8Sv_vh--oTXGUcnmYUOM
Message-ID: <CAAVpQUA3cnUz5=2AYQ_6Od_jmHUjS0Cd20NhdzfDxB1GptfsQg@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:45=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Sep 10, 2025 at 8:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > tcp_fastopen_active_disable_ofo_check() is called from tcp_disconnect()
> > or tcp_v4_destroy_sock(), so not under RCU nor RTNL.
> >
> > Using sk_dst_get(sk)->dev could trigger UAF.
> >
> > Let's use sk_dst_dev_rcu().
> >
> > Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > Cc: Neal Cardwell <ncardwell@google.com>
> > ---
> >  net/ipv4/tcp_fastopen.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index f1884f0c9e52..de849b8c87ef 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -560,7 +560,6 @@ void tcp_fastopen_active_disable_ofo_check(struct s=
ock *sk)
> >  {
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> >         struct net_device *dev;
> > -       struct dst_entry *dst;
> >         struct sk_buff *skb;
> >
> >         if (!tp->syn_fastopen)
> > @@ -576,11 +575,11 @@ void tcp_fastopen_active_disable_ofo_check(struct=
 sock *sk)
> >                 }
> >         } else if (tp->syn_fastopen_ch &&
> >                    atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_t=
imes)) {
> > -               dst =3D sk_dst_get(sk);
> > -               dev =3D dst ? dst_dev(dst) : NULL;
> > +               rcu_read_lock();
> > +               dev =3D sk_dst_dev_rcu(sk);
> >                 if (!(dev && (dev->flags & IFF_LOOPBACK)))
> >                         atomic_set(&sock_net(sk)->ipv4.tfo_active_disab=
le_times, 0);
> > -               dst_release(dst);
> > +               rcu_read_unlock();
> >         }
> >  }
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
> NACK. Please send a series against net-next as I did recently.
>
> You will then discover :
>

Sorry, I missed this one.  I'll drop this patch and send the
series to net-next.


> commit b62a59c18b692f892dcb8109c1c2e653b2abc95c
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Aug 28 19:58:22 2025 +0000
>
>     tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
>
>     Use RCU to avoid a pair of atomic operations and a potential
>     UAF on dst_dev()->flags.
>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Reviewed-by: David Ahern <dsahern@kernel.org>
>     Link: https://patch.msgid.link/20250828195823.3958522-8-edumazet@goog=
le.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index f1884f0c9e523d50b2d120175cc94bc40b489dfb..7d945a527daf093f87882c794=
9e21058ed6df1cc
> 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -576,11 +576,12 @@ void
> tcp_fastopen_active_disable_ofo_check(struct sock *sk)
>                 }
>         } else if (tp->syn_fastopen_ch &&
>                    atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_tim=
es)) {
> -               dst =3D sk_dst_get(sk);
> -               dev =3D dst ? dst_dev(dst) : NULL;
> +               rcu_read_lock();
> +               dst =3D __sk_dst_get(sk);
> +               dev =3D dst ? dst_dev_rcu(dst) : NULL;
>                 if (!(dev && (dev->flags & IFF_LOOPBACK)))
>
> atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
> -               dst_release(dst);
> +               rcu_read_unlock();
>         }
>  }

