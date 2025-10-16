Return-Path: <netdev+bounces-230079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60379BE3B41
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A912F1A654F6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C24339B2A;
	Thu, 16 Oct 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2WpB+2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CC1DF982
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621379; cv=none; b=kV8DM6Hu7SkZacDSNc7oOJRQ4ZtRLsd+TXyS2ourMkzQMO9XLQRLBglE+39Fc5VDdNq7fkGdNHM9MwqDiF3UqD6OhFCGLk8Jo0zmiTt/Ba6KquJFIpCxb6iR26HO8aYx+GUkb6wZ2pkJPuE271Le8YRSJTFg6srPDD3Jy6AHkMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621379; c=relaxed/simple;
	bh=bVsabvY+t7bTPR3frcObO7gbW0Whupx5B/t4emtmHvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crL6EOX7mdCu7shXJ46VufI1pG02S79NahEBdSNBgHbMGhm4S7euYs+B4VsungtRcl2OCx/g0tnyYQUSSKDag6ong7E6UFm0tK63ZxNRg5S2X3uY1qdt51Kd3EgcKawkHuFedC9s3DzxH6H7EBfY7jL0cEuWFE0zHFd1zbH18o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2WpB+2x; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c103928ffso10936316d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760621376; x=1761226176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VABsyQ2k2Sf4kJ4n3mj+egxWRN+ywmlEoOTgdTk/4vE=;
        b=O2WpB+2xMZMEpm6HYZZiRF1h4GcEVQ1sktwetkrwFmPXfiEoKTrm7Ev1DevqP2i8S/
         AvR8qsqFnNR3eFx1BEKjH3fFuITPex4PJTpwlaV67AqhjmImJwPZ+kptNRorLHoMjOar
         fvNfI989pDSf3cl7ANUYeOSMKnZAYL/BCgg0XaS3hC3WKbU+yApqhlqnn9QNR4Ssbkf5
         G68qCUsGsCaaUd4A2NTYo+X6GpaXrafRor1bAj+X3nq97UF82Gm0Tn2EMfMfYjYKuYlL
         YKnYcRkdPyrBGMKSVV3geI7GMs2r8YB6bKcIkcsgOxwVQdFuiS5aahoYcKqb7DEiwq1G
         73RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621376; x=1761226176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VABsyQ2k2Sf4kJ4n3mj+egxWRN+ywmlEoOTgdTk/4vE=;
        b=Hbl6ebp0b6h9Do5/wPybBTMxLsRud26IRCaGaKPOv82YI0Di5uKepY8aO2n5uyAjYZ
         Oxbcao6i63DvSEMrYGmmlX0q/9vGGVyOrr+PaZNgFYbPwNZOzd1U3LYeeL+83g/QHLtj
         +wuMkf3O1cFFO6l67MTeP/pmpXUjjkSlc3+9WVCHdg/sWegrcIOEwQlMR1bMLED8AWRy
         MZrLPC0L2F7tH4eYAKmvr1M9yoOpFdsYcNM6hQ4zp7YNpgzumC4lW5EO3AQc3eXBzDmO
         ZLYX8HA6Oh9MgbuT/QcIB+hploKlQ0tQFkpkHdWASI6jcNw+oz8XKD/CmJlzYSHUR6AV
         pIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEKqa3DLlVpRkml3aJSAavgxssk1C6A3DZ0CD0q5ZqQN0AAxA2L6ckoglq2TkOyL5A08FG8Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0T1pX2aBFSjjCeixitpNRjllnPAaCqY83DyKQqvTIcdNn3QT
	XuG6IqbDoMxX7esx0OuGHF/JiWeK6ECInw/L06PQ/QZ/jQW/3omSis5mqpuKONKQ11VEstm5js8
	0jIJU/D7weI/Lgl6hqY0wz2i1AufXeXKeeDkQ/qHW
X-Gm-Gg: ASbGnct2KtidBWqGQU8S8WaxDDMGko77VEvyojef41X/hhef+qajGnEjEP/wEFPfJGd
	CXoneViEEh6WQxDUY3vV37FR2xZDdMa6N8ZyRzcaUgOMerKKgUecVkR9zs6pMaFCxGAoZSfEX2L
	lYCHhLy+xsa+SGBnWZ/P3MNVsmDnp75X8a5x0ySN2mCeUOfknO29aEmj7R8QSyEVbughfSifQqL
	UJ4xZTVvGk4zmI7QjQHvIgY2vB6u54l9zgz5x86KhAy1PIDI7OT1IpF/tzLppAguDbnis+hrp15
	fZI=
X-Google-Smtp-Source: AGHT+IHtG8udq3FgUPObBuBIKtWKGwyV1sdIkniBO3SIWoUdAe02IExO7i1ZtHBcjXRFB+RyD7qfkYth+7718mEBMWU=
X-Received: by 2002:ac8:7d0e:0:b0:4e8:8722:4ec6 with SMTP id
 d75a77b69052e-4e89d3a46d5mr1578051cf.61.1760621375806; Thu, 16 Oct 2025
 06:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015233801.2977044-1-edumazet@google.com> <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
 <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com>
 <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com> <CANn89i+mnGg9WRCJG82fTRMtit+HWC0e7FrVmmC-JqNQEuDArw@mail.gmail.com>
In-Reply-To: <CANn89i+mnGg9WRCJG82fTRMtit+HWC0e7FrVmmC-JqNQEuDArw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 06:29:24 -0700
X-Gm-Features: AS18NWCrEEPKrQ8GLf5xB0scEQrBvH3ctq8489QcmmLLTmJg7qZZJOY12xNoawo
Message-ID: <CANn89iKBYdc6r5fYi-tCqgjD99T=YXcrUiuuPQA9K1nXbtGnBA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Oct 16, 2025 at 4:08=E2=80=AFAM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> >
> > BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same way?
>
> Probably, like other calls to napi_skb_cache_put(()
>
> No loop there, so I guess there is no big deal.
>
> I was looking at napi_skb_cache_put() because there is a lack of NUMA awa=
reness,
> and was curious to experiment with some strategies there.

If we cache kmem_cache_size() in net_hotdata, the compiler is able to
eliminate dead code
for CONFIG_KASAN=3Dn

Maybe this looks better ?

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 1aca9db99320f942b06b7d412d428a3045e87e60..f643e6a4647cc5e694a7044797f=
01a1107db46a9
100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -33,9 +33,10 @@ struct net_hotdata {
        struct kmem_cache       *skbuff_cache;
        struct kmem_cache       *skbuff_fclone_cache;
        struct kmem_cache       *skb_small_head_cache;
+       u32                     skbuff_cache_size;
 #ifdef CONFIG_RPS
-       struct rps_sock_flow_table __rcu *rps_sock_flow_table;
        u32                     rps_cpu_mask;
+       struct rps_sock_flow_table __rcu *rps_sock_flow_table;
 #endif
        struct skb_defer_node __percpu *skb_defer_nodes;
        int                     gro_normal_batch;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c9e33f26852b63e930e33a406c19cc02f1821746..62b1acca55c7fd3e1fb7614cb0c=
625206db0ab3f
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -365,7 +365,7 @@ static struct sk_buff *napi_skb_cache_get(void)

        skb =3D nc->skb_cache[--nc->skb_count];
        local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
-       kasan_mempool_unpoison_object(skb,
kmem_cache_size(net_hotdata.skbuff_cache));
+       kasan_mempool_unpoison_object(skb, net_hotdata.skbuff_cache_size);

        return skb;
 }
@@ -1504,7 +1504,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
        if (unlikely(nc->skb_count =3D=3D NAPI_SKB_CACHE_SIZE)) {
                for (i =3D NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i+=
+)
                        kasan_mempool_unpoison_object(nc->skb_cache[i],
-
kmem_cache_size(net_hotdata.skbuff_cache));
+                                               net_hotdata.skbuff_cache_si=
ze);

                kmem_cache_free_bulk(net_hotdata.skbuff_cache,
NAPI_SKB_CACHE_HALF,
                                     nc->skb_cache + NAPI_SKB_CACHE_HALF);
@@ -5164,6 +5164,7 @@ void __init skb_init(void)
                                              offsetof(struct sk_buff, cb),
                                              sizeof_field(struct sk_buff, =
cb),
                                              NULL);
+       net_hotdata.skbuff_cache_size =3D
kmem_cache_size(net_hotdata.skbuff_cache);
        net_hotdata.skbuff_fclone_cache =3D
kmem_cache_create("skbuff_fclone_cache",
                                                sizeof(struct sk_buff_fclon=
es),
                                                0,

