Return-Path: <netdev+bounces-221790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB0B51DC6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F36E488050
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5025D1E6;
	Wed, 10 Sep 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1mtmKwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02722609EE
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521985; cv=none; b=TKsLwo6CNq/vxj38k75bS6gARjiaAMkGvG/VMt41h90dct/hEXf6IbiFEa0gpqQoxxwSxD6e46KjJjaKBesksP2g7kKvFNj6JqRgGIJWf02lxczpHPi1lYyqD9kvSbm8pAQG7nhnj86K0Y7/Ofq05Tg8Ur5ME7u7GpwHjCLVkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521985; c=relaxed/simple;
	bh=6QWP6copzj9cf5FPkW3R7sbrZtIvIyER6xtRBGhVG/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAnNr+i8Yz/qyhc0TnIGB5iNeIM/4QzT9I1gfTwgcCtl4l5cP+Wp6hXaTSWrWkNdGf76aefG8AIlQBeNHChPXe8SHzsPC9Z+SoiWB21rw8nMrNvC/Sx3RnmnMYDOWoQDsPkUmrhA0PAzg0GgIxHwgNn8LeP7Moffrqvq4eJdwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1mtmKwu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24eb713b2dfso49455815ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757521983; x=1758126783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crg9ulSxnVedet7AE0tAYFjDi5iUeW7YmzwRm7NeGuA=;
        b=k1mtmKwuCuo0mPp+5/CDGzpDYM3NEpw6RqSoZ+T7JJt/wSDu9a9KP+hDnR4+f9+JXg
         8x5Zqre59Xp0Qs10YpH7IibsVR/xFMAPqQ9HvE0n149eWgHtqnbE7GFutGmxmHrhOxBO
         uk9K0SytK/hdKxXCP0XN3Wg/dhQqCqxOMPQ0W6crrld/rSA4fcxii0xW+fOwQfe+hNMB
         rpeM+94oXJS3mAdGL395osY09qm7pb7R8nAmOLkfwkO0brcl6fZNu/kWDf+UZVZ6Wi4i
         NbbIKbQ7NncNYG+vP/0VD3MPILLsxYD7JwdqYYLlaog430HBv/QP41VFbF/jzpfCobDH
         wq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521983; x=1758126783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crg9ulSxnVedet7AE0tAYFjDi5iUeW7YmzwRm7NeGuA=;
        b=auXf4GX4i5RTAc6iYlICmn3PiXNJ9RyH2mJ1s2SbaUFNJjIA+jK9oWVBCyDiqFezwh
         eUyTYLovS35LZ6nzgEhKiR5R2n9DbdCq2SAvU6uIkIH/qVB7Yd0Vp36emLgOJhBAzdqN
         0iukBTawwlsoeM5eUilWYShjzI6739TxPvPSNsDJ1OwXBvlv+Hm0FdUbzT5S88gTm9dd
         bIUesjuG79IZM4bwK/LgrgK3qrqZP/S3jITYEB1rJLhEJN96FvJ72fUc1gZxIv61+tHa
         0v9S6TfeefDFJyylw8l1d8oacmshpLHoPkch5cXz3lkApj8Tbks6kYJcGQ/aDPe5Aivi
         Kk4g==
X-Forwarded-Encrypted: i=1; AJvYcCUEV8VvA1PuLW8gbo+d+7bzkCn8TT1vQUZN33Iyby10uei3qf2n/73cu7fYAwsTBTdFPq72O7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04uTLdzc1BLOZLPgeH2cbAfTbR1nRUcd7tqVXanaZGWI3FOOf
	AqMgODIr38h6kKq3PJ89CXRqEBtrJHX6D+SznN5ujNBqENK8QYJKDRPu9ve5OfbZbrk7wn1f0UB
	laipFmfrS1dz7K4kw9cLxwJ7N3ZTKBxdA58o7JES0
X-Gm-Gg: ASbGnctczPeEYzCnKx33hVEAjjfhkJHhzr+Q+XSq7vLY7O+CLqSvz3KM7YJAjvG6mfz
	3VGD7fSQZxfPEqwtVzlA2g1lljYMjAC3r42wArY7wzQeyO31sbsFiGXWHPw36615RVBgJdU6l81
	jhpCLM+NYrF+rqXT45nJI2xZKCVxOxKdFvl8Ax0RPSqBFFLiUD5aVVJyw9qcoFPXvKpvJaJVlzG
	PTWwAYqAmldqwqw0MYCIkObGpaO0juxBBCnSW4I5MLnqfg=
X-Google-Smtp-Source: AGHT+IFygkRcH7mrdQ4Zhgc7n2vieMLoI6r6NoPaSe1OOy5LbAIzXpvm7rozB2gTILsaRSM0LL+d/usqZ1C3z4HoNpo=
X-Received: by 2002:a17:902:f54a:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2516dfcb5c4mr232806255ad.17.1757521982717; Wed, 10 Sep 2025
 09:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909204632.3994767-4-kuniyu@google.com> <202509101912.ROjtP2uL-lkp@intel.com>
In-Reply-To: <202509101912.ROjtP2uL-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 09:32:51 -0700
X-Gm-Features: Ac12FXx6aKnMeDmD-Oqq_oMACp8aNPwM23p9lZayrp8qexUb1gFrzTNdorO62hI
Message-ID: <CAAVpQUAXoxU4r1dgC3wtTxx6oVMpOWjd9q7Ub=SEsnHMpL3RAw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
To: kernel test robot <lkp@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:58=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/net]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
tcp-Save-lock_sock-for-memcg-in-inet_csk_accept/20250910-044928
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
net
> patch link:    https://lore.kernel.org/r/20250909204632.3994767-4-kuniyu%=
40google.com
> patch subject: [PATCH v7 bpf-next/net 3/6] net-memcg: Introduce net.core.=
memcg_exclusive sysctl.
> config: um-randconfig-001-20250910 (https://download.01.org/0day-ci/archi=
ve/20250910/202509101912.ROjtP2uL-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7=
fb1dc08d2f025aad5777bb779dfac1197e9ef87)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250910/202509101912.ROjtP2uL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509101912.ROjtP2uL-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permis=
sions
>    /usr/bin/ld: mm/memcontrol.o: in function `mem_cgroup_sk_set':
> >> memcontrol.c:(.text+0xa1e0): undefined reference to `init_net'
>    clang: error: linker command failed with exit code 1 (use -v to see in=
vocation)

CONFIG_NET=3Dn... will fix it in v8.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0d017c8b8a00..b7d405b57e23 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5002,8 +5002,10 @@ static void mem_cgroup_sk_set(struct sock *sk,
struct mem_cgroup *memcg)

  sk->sk_memcg =3D memcg;

+#ifdef CONFIG_NET
  if (READ_ONCE(sock_net(sk)->core.sysctl_memcg_exclusive))
    mem_cgroup_sk_set_flags(sk, SK_MEMCG_EXCLUSIVE);
+#endif
 }

 void mem_cgroup_sk_alloc(struct sock *sk)

