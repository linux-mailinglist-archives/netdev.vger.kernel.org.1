Return-Path: <netdev+bounces-221973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F25B52837
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B363B99E0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1AE1F2BA4;
	Thu, 11 Sep 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eo18NZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A5329F29
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569546; cv=none; b=MZq4SHjMt3evtAkPU7k+8FQaxsF12fT9F4ABwRgTOhcsT/sCxQytjroW83nCneGS3HdWj+T+d0Q2UzGY6PPkD0vDHFwtp9rcsGkwK0JQhAdf6debf35+QAZQkVspMu7GqDG/dNES1V7FSfplJnoQ/6Sz8BJNwR86ssmCRSfRk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569546; c=relaxed/simple;
	bh=zCtC/LumrT/S2WnpL9z8XZSY5NzR8Rzp8YFasncIBvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9sZjZy6+LuifB/BmFBZisqBCYpIXDoWJrMEjZrSqMSARU7Cniswxql7KS99qQdjYuZDduIh2ci2IYnb8g8XqKsK7KxpktLCqhijrGTELZOPRydYJi8TmeUMPKcJpDFmKBb0z2l0xxEK+SxcZ8VaqxwvQT9nnxRNu868GK5mGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eo18NZa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b3415bfb26so2509111cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 22:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757569543; x=1758174343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szg2ebJDM6zTJ8KbmVgh1ufOA5oMbq0PWiwE/ELdDOY=;
        b=1eo18NZat9Uuvd1KO6s+ZYSbM/EvCIUsGBsBYlpGW201wgJ7ccEbQ/TGfXXbhgQkJ1
         veRA4/6gQhjo/jTb0oldM9IMD9yFzQfbn0bDjRZXxKHJ9IEzlezfUUof8u3c+Dg/80T2
         Hs4//BLsqFlsWl9Fq4YHNzxWbxFticZ2BXl5LrDCGaEnBWj8a6Dk+afa0NdqLwXZ2OWK
         PZjbi0xJqYFo57cv0Iom7q5Fk6rab+d8LRd3N0W4ZlpFfPEcSEJy+n53FcLCHqeu/tzs
         FozaLnNxBq1seAABtz3Se2V7zpMoGmMOOE+91W2NziAvj1z17x3Inn8S891ND1MuVxXS
         Icmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757569543; x=1758174343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szg2ebJDM6zTJ8KbmVgh1ufOA5oMbq0PWiwE/ELdDOY=;
        b=A4APC24Ws6T4AtIBTvZ5KTttMe7vUlNHDjU6b2M8k4r5ewIVJV7AOf9ThnyZrA3d/N
         pMKW48uB9U356ca0Jclz/2rqrP/mV84CnzJO3rDs5hGsjfJKWc5nUjfXaUyXru7pqTHG
         7uCCkOqy67f951KfTHNL28ci23WYVX1zuv1UyYW5iFabF2WImyab1NBZVhNdd28OtKvX
         MWi0lmr3qdldycjpQXeueI/Sr2k3Dabi99iBrGkpcNWQmnh+WGe882XfcrTrW+1yOLJB
         ExXs++zpwWJ0v2JyWGsjWfzfyp1wERscsvgc7uVEBKQn7IXLRE6+64Si9l/n3tkaRS4o
         pDLA==
X-Forwarded-Encrypted: i=1; AJvYcCXKL+yCczvjtIfGUVndXBwwmRVI96r9DwBKU9vIRsXLSgtRp7NklUb3qh+/PGcnYpm+lXKZUyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcoVhMkNrIg4YhwDAnlXATbO4Wjyieue/Vd9L5ayd9Ye/L+/B
	2ceX3AYnEoGBTb2hSS3rNm+RZZWVlnfpSpRFlHlsC/QlKUVEfRVaqgXLjXpWSFEJegnyDp13oij
	Yua1vQhkJL2viW6aa5iyzhkJTJn4ZzmRKkJguOvQJ
X-Gm-Gg: ASbGncuQuDaG8Uhy5C3yFWWUJXEMiMt3hPquQzk+UjRT7fk1KcC/9y++V5zmE4k+IYb
	ZtCKQrPU4kAlWXKd1CIpJpv7LkCwR5IL1PQ7EH2wBMQcu3KhYEWkN/RUutolmRxi0mO/I+DI+PE
	GDayNhlJqYI5TKpWe2grq+6046WpgGMRp+embTufPkL3ARPpUJGeKW2GBPd03FMXl1tibvbw1h2
	3f9treey25CVorn6QXl2FKz
X-Google-Smtp-Source: AGHT+IHFZp1D8mEIYWps2pJZ5ADVafGecyR8k7nMnCQY67bfeta9+d/1vINvRnGMF2IgPJEHVr7CPNc42YtVBEKvA9o=
X-Received: by 2002:a05:622a:14d4:b0:4b1:103b:bb6b with SMTP id
 d75a77b69052e-4b5f8465890mr173710301cf.61.1757569543216; Wed, 10 Sep 2025
 22:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com> <20250911030620.1284754-7-kuniyu@google.com>
In-Reply-To: <20250911030620.1284754-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Sep 2025 22:45:31 -0700
X-Gm-Features: Ac12FXwHqZ8L0e52qnsMgdJxmOQl6TuUIcxbdkEXhuX5qmW66-ytL41GqBI3inA
Message-ID: <CANn89iJnOZ-bYc9bAPSphiCX4vwy4af2r_QvF1ukVXF7DyA4Kw@mail.gmail.com>
Subject: Re: [PATCH v1 net 6/8] tcp: Use sk_dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> tcp_fastopen_active_disable_ofo_check() is called from tcp_disconnect()
> or tcp_v4_destroy_sock(), so not under RCU nor RTNL.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use sk_dst_dev_rcu().
>
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> Cc: Neal Cardwell <ncardwell@google.com>
> ---
>  net/ipv4/tcp_fastopen.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index f1884f0c9e52..de849b8c87ef 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -560,7 +560,6 @@ void tcp_fastopen_active_disable_ofo_check(struct soc=
k *sk)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct net_device *dev;
> -       struct dst_entry *dst;
>         struct sk_buff *skb;
>
>         if (!tp->syn_fastopen)
> @@ -576,11 +575,11 @@ void tcp_fastopen_active_disable_ofo_check(struct s=
ock *sk)
>                 }
>         } else if (tp->syn_fastopen_ch &&
>                    atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_tim=
es)) {
> -               dst =3D sk_dst_get(sk);
> -               dev =3D dst ? dst_dev(dst) : NULL;
> +               rcu_read_lock();
> +               dev =3D sk_dst_dev_rcu(sk);
>                 if (!(dev && (dev->flags & IFF_LOOPBACK)))
>                         atomic_set(&sock_net(sk)->ipv4.tfo_active_disable=
_times, 0);
> -               dst_release(dst);
> +               rcu_read_unlock();
>         }
>  }
>
> --
> 2.51.0.384.g4c02a37b29-goog
>

NACK. Please send a series against net-next as I did recently.

You will then discover :

commit b62a59c18b692f892dcb8109c1c2e653b2abc95c
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Aug 28 19:58:22 2025 +0000

    tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()

    Use RCU to avoid a pair of atomic operations and a potential
    UAF on dst_dev()->flags.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: David Ahern <dsahern@kernel.org>
    Link: https://patch.msgid.link/20250828195823.3958522-8-edumazet@google=
.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index f1884f0c9e523d50b2d120175cc94bc40b489dfb..7d945a527daf093f87882c7949e=
21058ed6df1cc
100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -576,11 +576,12 @@ void
tcp_fastopen_active_disable_ofo_check(struct sock *sk)
                }
        } else if (tp->syn_fastopen_ch &&
                   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times=
)) {
-               dst =3D sk_dst_get(sk);
-               dev =3D dst ? dst_dev(dst) : NULL;
+               rcu_read_lock();
+               dst =3D __sk_dst_get(sk);
+               dev =3D dst ? dst_dev_rcu(dst) : NULL;
                if (!(dev && (dev->flags & IFF_LOOPBACK)))

atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
-               dst_release(dst);
+               rcu_read_unlock();
        }
 }

