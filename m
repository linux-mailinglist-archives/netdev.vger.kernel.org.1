Return-Path: <netdev+bounces-172295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E768A54143
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A38171AC2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76634194C75;
	Thu,  6 Mar 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opa4c8aw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0C18DB3F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232166; cv=none; b=FX31BFIuvHLn//DS0oCXEDGzRCLgIiiLOdjoiLh4EiogsoWEHz9qHY+HaG9KG0MR+5nMYuPf935eqjLMgKuIz3rfjhLDkp+BBu97trhSyrHOK6C/fDsF9Gook86MOGgUM71ktCJTuXWcU77KUHzXW6EKheTD8lJYMI3OrqtnNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232166; c=relaxed/simple;
	bh=i9IFxtSRXqIywX//1elETmNRg156YMbIO3HKlhk6gnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFUkU82McN8SeLDgXXCLR/5GbeeHY+f4t5U2xucTkf+82+a85F3y6ElfRxRM/fsDfJzaKw/+U+BGkgsGsq+b5cKb6rk/x40ME450cgLZ985LQLZlNAcaksgHGeI9MqEutnsPOxpYAWv7mdlDBD5v5qCKaHb32tNfZExk/OX5MPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opa4c8aw; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d284b9734fso2328035ab.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741232164; x=1741836964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg4jySCpQxcyKzCjDNiWnRZE2QABgIVafumVkv2GB0c=;
        b=Opa4c8awhgxbW08cIemZBrCk7RZxGjvzxIrc69opKR4gx+ynW/n7sC3uAQKS8mnTVM
         UnTlRqvHyng5Cn+c8rMedauz4xfcQ0utFqdS1QjLIxNq5Mu3h1lldFMG43OpKTDPoYt1
         qr+OeQH0iDr19YgfbqbqWMEiTT0zjcmUvQC7Z7tIfdN2xgbH7L2FKYBJNwtNhQ+m2TCG
         Nwd7+yBJU/YbY14I5DF6C7ZTSBqDkYOA3cyloO7VA06R/Oqnizr7uZx9MhENNdTf3Hsu
         bEoJN55ZQX5EHs7Doc9/gA8dccdGInSgm4AgR60/yX77/AS14jXum8EdfaVkMr3dT3Z2
         xM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741232164; x=1741836964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg4jySCpQxcyKzCjDNiWnRZE2QABgIVafumVkv2GB0c=;
        b=IhTxt8WyvWLOthmOxQJGdhCN60KMcryKAHM1uKJuz/j536d5Xc9hgHTb8/63MNTuXH
         hZypTqSkGQobFCfGMRKq6EyDCPI39RcyV4/mN+hr/Dj+ARwk6qAvlQYYybnnR4HXFzoE
         0n6ldgWk5YprkDNBE1HYCvNPkDTpOVGsN6HcyfsmlUyKb5SLdrwvwIkPW88gXtFQp6qO
         KPA1RSFkKwsT0OcLnv3QrijgD92KnP1dTY4i/hTiNdN1lhTaB04py0/SHnhdJiH0WSbV
         joXI4X4a/V6FUFeY8bK2Os0VBQ0JLp/9u7GxpaoEptVOXlKsyHId5b/v99MUkaw3wsqy
         hJBg==
X-Forwarded-Encrypted: i=1; AJvYcCW9gttnBN9Tos3SQk30i8EfWLqr/s7mffBMy/bS/klMjrEXoZACB8f/x52j7k5RdYCun0qqtYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyFJ0I3xSrWADRg0hWQl3/oaA4ajipXFmcXs+4zkJwxt05f5o
	Xb3JTi1Q89DO5iJaeICgQvxB8d8Wiu2xpQWtHudjB/bNXO2i/r50RsxqubEqZfkUzdet8LAUyT5
	gUjBt9P67ITT1QckJhtyLTuhljak=
X-Gm-Gg: ASbGnctLlKl/DeWnQwjG4AMMxFMXd96YivXKXMzL3/RO5UI8w0ZMECwlER4aeeePq1Q
	ELAgqZ0zeBDACSApkD34hgLOwjEYCIqujCD2JxllhskZMU+gLK+kU0Ili2Ul5ilQzIXNPk+Pw/u
	CbaysVpZ7Uiy+1hZFD5BF4U9eHQQ==
X-Google-Smtp-Source: AGHT+IGVFcgwAAVL98WiSjYrAkfm2MrKoAKQTb5jTQ+vXO2uE2JotO3uJl/PW/bGa6NDcD5Sx6UXHQWRzdWIwMjetRw=
X-Received: by 2002:a05:6e02:1fe2:b0:3d3:f7ed:c907 with SMTP id
 e9e14a558f8ab-3d42b95feaemr71618935ab.15.1741232163692; Wed, 05 Mar 2025
 19:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305130550.1865988-1-edumazet@google.com>
In-Reply-To: <20250305130550.1865988-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 11:35:27 +0800
X-Gm-Features: AQ5f1Jo0hdtoRORHU33l-OLsDFd_m6bwq6P8O3nLjRhPP6Cx98TaeMY0eExcquw
Message-ID: <CAL+tcoBvzg=+3i=pGbkP0o3RkH6Yy8-FUTdN4tMMM+BdBUv1oQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We have platforms with 6 NUMA nodes and 480 cpus.
>
> inet_ehash_locks_alloc() currently allocates a single 64KB page
> to hold all ehash spinlocks. This adds more pressure on a single node.
>
> Change inet_ehash_locks_alloc() to use vmalloc() to spread
> the spinlocks on all online nodes, driven by NUMA policies.
>
> At boot time, NUMA policy is interleave=3Dall, meaning that
> tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
>
> Tested:
>
> lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
>
> lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet_ehash_l=
ocks_alloc /proc/vmallocinfo"
> 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N5=3D1
> 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
>
> lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "grep inet_ehash_l=
ocks_alloc /proc/vmallocinfo"
> 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
>
> lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet_ehash_l=
ocks_alloc /proc/vmallocinfo"
> 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D1 vmalloc N2=3D1
> 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+0x90=
/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Tested-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0c7b2e70d1f=
c9b3b9b60256ef7 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *=
hashinfo)
>  {
>         unsigned int locksz =3D sizeof(spinlock_t);
>         unsigned int i, nblocks =3D 1;
> +       spinlock_t *ptr =3D NULL;
>
> -       if (locksz !=3D 0) {
> -               /* allocate 2 cache lines or at least one spinlock per cp=
u */
> -               nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U);
> -               nblocks =3D roundup_pow_of_two(nblocks * num_possible_cpu=
s());
> +       if (locksz =3D=3D 0)
> +               goto set_mask;
>
> -               /* no more locks than number of hash buckets */
> -               nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> +       /* Allocate 2 cache lines or at least one spinlock per cpu. */
> +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_=
cpus();
>
> -               hashinfo->ehash_locks =3D kvmalloc_array(nblocks, locksz,=
 GFP_KERNEL);
> -               if (!hashinfo->ehash_locks)
> -                       return -ENOMEM;
> +       /* At least one page per NUMA node. */
> +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_SIZE / locksz)=
;
> +
> +       nblocks =3D roundup_pow_of_two(nblocks);
> +
> +       /* No more locks than number of hash buckets. */
> +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
>
> -               for (i =3D 0; i < nblocks; i++)
> -                       spin_lock_init(&hashinfo->ehash_locks[i]);
> +       if (num_online_nodes() > 1) {
> +               /* Use vmalloc() to allow NUMA policy to spread pages
> +                * on all available nodes if desired.
> +                */
> +               ptr =3D vmalloc_array(nblocks, locksz);

I wonder if at this point the memory shortage occurs, is it necessary
to fall back to kvmalloc() later even when non-contiguous allocation
fails? Could we return with -ENOMEM directly here? If so, I can cook a
follow-up patch so that you don't need to revise this version:)

Thanks,
Jason

> +       }
> +       if (!ptr) {
> +               ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> +               if (!ptr)
> +                       return -ENOMEM;
>         }
> +       for (i =3D 0; i < nblocks; i++)
> +               spin_lock_init(&ptr[i]);
> +       hashinfo->ehash_locks =3D ptr;
> +set_mask:
>         hashinfo->ehash_locks_mask =3D nblocks - 1;
>         return 0;
>  }
> --
> 2.48.1.711.g2feabab25a-goog
>
>

