Return-Path: <netdev+bounces-89891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C78AC13F
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 23:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487381F20FD6
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CF4437D;
	Sun, 21 Apr 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1B3q/2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02497219F9
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713733644; cv=none; b=Ls5U2bJqJ6yEPWRq0UB86WjX5+ldekkLfMc7VQVMchR2fbVZVmuEOq6YtDu29jgfSntw08XU3ACtALQR9pKnzocGfrgau6gQGvv+LG1+BwrR2iYsfXRyaKRz2FoLhu2X96az2mec11u2DWSaQEqCrM0F58shor28STXdcLzIU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713733644; c=relaxed/simple;
	bh=fw1TxB4UcuVOBhxihbMJeZ2PSmk3RcuwvuiKeCuLKws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCe2EgHAnDzL+wd+q4vkMJY2kVjlG1PomgZJxsd3/W21esTepkbmdB20Tc0x2ApD0EZKW4td/aMfSLGMlBqcCLXpqHSQRlksy/D+i5RIb4BsrY+debkeEABK4sO12OnBO6uq65JO+7QIFtmq38LQywsXw2qj3Iq93uK3rVU5+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1B3q/2v; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-436ed871225so298761cf.1
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713733642; x=1714338442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAu20l25ZV8ozJmVJz66xC1jDVBk272i4dhMpTfFjKQ=;
        b=E1B3q/2vy83MDo8EDnheBGOb8ZI/gZD1n5nC12tipTvbj8bndysFpHfurYUt38VW9u
         RZ2TGcO6yIivn2sgKWRiuQVohdIAKcY0PtQ8/DVardDxNQiZ9yaT5cdHT/QGRrO6Hx2i
         h+1NtwJ/nhZypBrLz3Htjcs9nIcR/3Z+ZrXoM1/7M27DrO156FZIkvxckrsYUx5Ix46P
         jqZqzEZXxjf8I6DaV4fOdYAt95ZXcrbBnjNoIV9S6dSROgtck+KcGjPYD574utMqZhTR
         DwHijsx7zkJ1qQjUNccDsbQ1L+FolHLWhA+5QZZOmWHJZtORFahc94j1DzvBTwIO/63V
         dGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713733642; x=1714338442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAu20l25ZV8ozJmVJz66xC1jDVBk272i4dhMpTfFjKQ=;
        b=ar2/7k6VgYjyZj4bugEYYV4ByISTmjMmL3K4zvIIKBRgu3m8PqX+Cx8Ehd/FqXiVzP
         T0Qw7yIvL8tNLyHyMvVoODLtgIWAd+SNZVOADqSHXpIp/Mi3KuXTJ52TynjpovTXYZzX
         FHMIs3cSLm2i0tvxFut79FEivLCR5ROxPLxD8EmW0S1EnMK+/HvdNqJOgQL6Dgf/zK5n
         03YvlsMoskqC9PPcd3v8Wk6pYJejxjKHsIz3CREg0p+hp0+XgdLEBKeLDfl+NaS5ZM9Q
         TRS5ZxbW+jF9UFfSvD42V2tfx/bNsjdOH9JY+JNJd/o8c84vELxTN6f2kPscaKa80ztt
         NdAg==
X-Forwarded-Encrypted: i=1; AJvYcCVHnDs/tLgh3QY1eTrO3xfBtOIwybupPtB66UWGZodunc3wn7phgHRwtZ8jp/aOrm59dzf1HKSrmEFq7uhzJjcfwg5Yh10j
X-Gm-Message-State: AOJu0YzTi6g5m65j6WpXsHiU89KqimoJz4lv2mivOwDdFfP2oGkbU71D
	qOWCW0kxXm730ywvc37gtHEQLuIVxd8LYHEiSqxnUJqQkvqXV/O+QhL8LTwSTmEKtrwqiIcxl3u
	uGo6dSFLti2R9Zi8THLQ7H1+DmrsluSzxzfbO
X-Google-Smtp-Source: AGHT+IHr59MZNmDtDIguYM0qeMzWhkE70syUGT2vovGBLJYMjCscL89E/NtxRAKBEkg8D1Xr87dbQoED9+Z8sMzqjdc=
X-Received: by 2002:ac8:514e:0:b0:437:c5ff:ac05 with SMTP id
 h14-20020ac8514e000000b00437c5ffac05mr285313qtn.1.1713733641590; Sun, 21 Apr
 2024 14:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421175248.1692552-1-edumazet@google.com>
In-Reply-To: <20240421175248.1692552-1-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Sun, 21 Apr 2024 17:06:45 -0400
Message-ID: <CACSApvbc__=J-_hNReeDTNAj2_KJjQaseP+QnY2aQgQGbvkQwA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix sk_memory_allocated_{add|sub} vs softirqs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 1:52=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Jonathan Heathcote reported a regression caused by blamed commit
> on aarch64 architecture.
>
> x86 happens to have irq-safe __this_cpu_add_return()
> and __this_cpu_sub(), but this is not generic.
>
> I think my confusion came from "struct sock" argument,
> because these helpers are called with a locked socket.
> But the memory accounting is per-proto (and per-cpu after
> the blamed commit). We might cleanup these helpers later
> to directly accept a "struct proto *proto" argument.
>
> Switch to this_cpu_add_return() and this_cpu_xchg()
> operations, and get rid of preempt_disable()/preempt_enable() pairs.
>
> Fast path becomes a bit faster as a result :)
>
> Many thanks to Jonathan Heathcote for his awesome report and
> investigations.
>
> Fixes: 3cd3399dd7a8 ("net: implement per-cpu reserves for memory_allocate=
d")
> Reported-by: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
> Closes: https://lore.kernel.org/netdev/VI1PR01MB42407D7947B2EA448F1E04EFD=
10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Very nice catch! and thank you for the fix!

> ---
>  include/net/sock.h | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f57bfd8a2ad2deaedf3f351325ab9336ae040504..b4b553df7870c0290ae632c51=
828ad7161ba332d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1410,32 +1410,34 @@ sk_memory_allocated(const struct sock *sk)
>  #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
>  extern int sysctl_mem_pcpu_rsv;
>
> +static inline void proto_memory_pcpu_drain(struct proto *proto)
> +{
> +       int val =3D this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
> +
> +       if (val)
> +               atomic_long_add(val, proto->memory_allocated);
> +}
> +
>  static inline void
> -sk_memory_allocated_add(struct sock *sk, int amt)
> +sk_memory_allocated_add(const struct sock *sk, int val)
>  {
> -       int local_reserve;
> +       struct proto *proto =3D sk->sk_prot;
>
> -       preempt_disable();
> -       local_reserve =3D __this_cpu_add_return(*sk->sk_prot->per_cpu_fw_=
alloc, amt);
> -       if (local_reserve >=3D READ_ONCE(sysctl_mem_pcpu_rsv)) {
> -               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_rese=
rve);
> -               atomic_long_add(local_reserve, sk->sk_prot->memory_alloca=
ted);
> -       }
> -       preempt_enable();
> +       val =3D this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
> +
> +       if (unlikely(val >=3D READ_ONCE(sysctl_mem_pcpu_rsv)))
> +               proto_memory_pcpu_drain(proto);
>  }
>
>  static inline void
> -sk_memory_allocated_sub(struct sock *sk, int amt)
> +sk_memory_allocated_sub(const struct sock *sk, int val)
>  {
> -       int local_reserve;
> +       struct proto *proto =3D sk->sk_prot;
>
> -       preempt_disable();
> -       local_reserve =3D __this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_=
alloc, amt);
> -       if (local_reserve <=3D -READ_ONCE(sysctl_mem_pcpu_rsv)) {
> -               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_rese=
rve);
> -               atomic_long_add(local_reserve, sk->sk_prot->memory_alloca=
ted);
> -       }
> -       preempt_enable();
> +       val =3D this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
> +
> +       if (unlikely(val <=3D -READ_ONCE(sysctl_mem_pcpu_rsv)))
> +               proto_memory_pcpu_drain(proto);
>  }
>
>  #define SK_ALLOC_PERCPU_COUNTER_BATCH 16
> --
> 2.44.0.769.g3c40516874-goog
>

