Return-Path: <netdev+bounces-229707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7164BE028E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91E525074BE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7733A01D;
	Wed, 15 Oct 2025 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlCwauGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70F337695
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552493; cv=none; b=K+pYM7rFEM4gVWtjObZv/RbcUbRpK62g4HI1it7pXTfVjJV4IbSVk8RmhPPe0RFD8Or0zO5DokmZ3pB69YuulFrP6k8bU08gMK+twp10DVZrwrmAuh1JUm8iZaLOMf+aKEDlI+NZcahsIOxY7U/U9hMbDbE+wP6AhQjvCqUW0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552493; c=relaxed/simple;
	bh=C0nOezS2FMCaT4DVtnnr9AOurg/IbNXn/jE+p0KcmD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ9B3DaIkoBnc7qCDeNUwLyy2G5oXSToWhYyUtoPMjqFGo8Gg9c/7QKGuPSv/Hsf5lwmvnas0j6jROvv0sVgf9eDxy2g5uy7tAE28QbY0Z5/xWMM58CUOFeOGsIHAl2y3/vroVR4lLJm0t/BlIfPA3w0tpjT1aDM7GzRgG3O+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlCwauGi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782bfd0a977so5774455b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760552489; x=1761157289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp64OOTDMMU/j1+qMmwGSQ8xybomTCKVWDp1nxfRYIs=;
        b=TlCwauGifws//bRjH3qe2rCXb6OO5oeR0PQ1COJV1gAgrB9Wo2GelyCXum5hTDERcD
         hGejdoLe/5sG5f28wOHIBVluwrqntwCSk66PqOCkR4r8d6aW1s0XFwSBMCo6cFlWij5K
         Orw3MsdKv7VgnQyYmU5xo1SaZZDwlRtince83fg6Db9kSTtNPuaCB+qxGyk8qWhHnjkd
         3By/eol/bsC9gxD7dw45o3pCTnIHlQ+EZ5KryaAxhA13pAO4u7/zflpZaLXxeZresuHs
         kEOGSwqXFIaKvU00SUu7m27J9niJ8f25T7IksMkf215C1bFoE/dDXoj5rEphV9L8XSUn
         dPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552489; x=1761157289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp64OOTDMMU/j1+qMmwGSQ8xybomTCKVWDp1nxfRYIs=;
        b=YLDkDsr/5jgOu9BAKf2WidFvCxTAmBVCJtqrGi+uLaQqpAfAXNq7BwD5aHHpOyo6En
         DxPF6Al4CkKSLoqYnPqgCgnjq9Hm8dXpLfymcR8M23E2OJibRMqOuJ9/HUAXhtpETV2K
         JghOZwY8gwmv4lKsNA2Q5Cg6BpIibBEYASTOzFHv/k4szSb+oZMwgH9wqirv3HuTyF0f
         yyHiq4DwK1pE5HcG35gVxviaImcI9D4BOZYrL02yvCPeTN7n64ec8Oo1YNOJobaZagZm
         5oecg4EIrFKurQw7uzJxJ6T8w87TLm1RuD31DKJ5i5AX3vH7xAnMQXv9Lmt3ym3Lr54b
         J5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNuswULsEIuNvMRCzp6QTs9goPERzAlyZsG/f5M1gwaeUlpdjveyFHe5xv4bhCNS/c1GY10PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7CTj9obqTQfjS4XkosugKlhKDOfhGRx+YRRTzLRH6QC2m8DS
	C2XM0Or/ayKmkhcEwO9y8Hj7JwnMzRge32b8USiLTRrKJUgHLHQXVw06oFJK62Z34MSZJPJA8DP
	FEKwbGOgoBnoS6gDjf7NLxWbR1OJ14a44FWh/NJse
X-Gm-Gg: ASbGnct+NVyfm/CexfBWk78MDNSAC6djNGmsWhK/RKJXhO/NNog+hKSBZpz5UkYh+F1
	m0qHKz3NOUFqxF4d7x6i/om/TMNUak2HgCDvt5psuAW9qiIVRy/itkwgxibpU+anupLe/JcPVUF
	sUfb0vxRjwp8bWF1V8SXT2/3LMprSn4ka8kYbHambJ/AwBhAp7ZrN0UufLjSnkVUt7sdOSh/9Fb
	VFP6Gn1YZUEnW0vI5YjN4mXRfSMD+9GBnnEWcCzF3CamMqQNYqSnat5uuAaulXwGgllL+qwGw==
X-Google-Smtp-Source: AGHT+IFv6ZDTbnlyEa7PGKtiy3BHZqh5Atg4snl51qJOvPQs/NM5tOMV7CkHZGYdvUsd7R4gGq+3ZXyx9BwkDCSqhj0=
X-Received: by 2002:a17:902:e841:b0:273:59ef:4c30 with SMTP id
 d9443c01a7336-2902723a7ffmr425859825ad.15.1760552489053; Wed, 15 Oct 2025
 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev> <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev> <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev> <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev> <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com> <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
In-Reply-To: <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 11:21:17 -0700
X-Gm-Features: AS18NWBl8DBuSyVQ5CvtXUGkTQXtnvm6oLLrRN_Q_tBNBRmemTwaIbj89yQ-PKI
Message-ID: <CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
> [...]
> > > > > > How about we track the actions taken by the callers of
> > > > > > mem_cgroup_sk_under_memory_pressure()? Basically if network sta=
ck
> > > > > > reduces the buffer size or whatever the other actions it may ta=
ke when
> > > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking those a=
ctions
> > > > > > is what I think is needed here, at least for the debugging use-=
case.
> >
> > I am not against it, but I feel that conveying those tracked actions (o=
r how
> > to represent them) to the user will be much harder. Are there already
> > existing APIs to push this information to the user?
> >
>
> I discussed with Wei Wang and she suggested we should start tracking the
> calls to tcp_adjust_rcv_ssthresh() first. So, something like the
> following. I would like feedback frm networking folks as well:

I think we could simply put memcg_memory_event() in
mem_cgroup_sk_under_memory_pressure() when it returns
true.

Other than tcp_adjust_rcv_ssthresh(), if tcp_under_memory_pressure()
returns true, it indicates something bad will happen, failure to expand
rcvbuf and sndbuf, need to prune out-of-order queue more aggressively,
FIN deferred to a retransmitted packet.

Also, we could cover mptcp and sctp too.



>
>
> From 54bd2bf6681c1c694295646532f2a62a205ee41a Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Tue, 14 Oct 2025 13:27:36 -0700
> Subject: [PATCH] memcg: track network throttling due to memcg memory pres=
sure
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 1 +
>  mm/memcontrol.c            | 2 ++
>  net/ipv4/tcp_input.c       | 5 ++++-
>  net/ipv4/tcp_output.c      | 8 ++++++--
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..5fe254813123 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -52,6 +52,7 @@ enum memcg_memory_event {
>         MEMCG_SWAP_HIGH,
>         MEMCG_SWAP_MAX,
>         MEMCG_SWAP_FAIL,
> +       MEMCG_SOCK_THROTTLED,
>         MEMCG_NR_MEMORY_EVENTS,
>  };
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..9207bba34e2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4463,6 +4463,8 @@ static void __memory_events_show(struct seq_file *m=
, atomic_long_t *events)
>                    atomic_long_read(&events[MEMCG_OOM_KILL]));
>         seq_printf(m, "oom_group_kill %lu\n",
>                    atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
> +       seq_printf(m, "sock_throttled %lu\n",
> +                  atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
>  }
>
>  static int memory_events_show(struct seq_file *m, void *v)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 31ea5af49f2d..2206968fb505 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -713,6 +713,7 @@ static void tcp_grow_window(struct sock *sk, const st=
ruct sk_buff *skb,
>                  * Adjust rcv_ssthresh according to reserved mem
>                  */
>                 tcp_adjust_rcv_ssthresh(sk);
> +               memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
>         }
>  }
>
> @@ -5764,8 +5765,10 @@ static int tcp_prune_queue(struct sock *sk, const =
struct sk_buff *in_skb)
>
>         if (!tcp_can_ingest(sk, in_skb))
>                 tcp_clamp_window(sk);
> -       else if (tcp_under_memory_pressure(sk))
> +       else if (tcp_under_memory_pressure(sk)) {
>                 tcp_adjust_rcv_ssthresh(sk);
> +               memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
> +       }
>
>         if (tcp_can_ingest(sk, in_skb))
>                 return 0;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index bb3576ac0ad7..8fe8d973d7ac 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3275,8 +3275,10 @@ u32 __tcp_select_window(struct sock *sk)
>         if (free_space < (full_space >> 1)) {
>                 icsk->icsk_ack.quick =3D 0;
>
> -               if (tcp_under_memory_pressure(sk))
> +               if (tcp_under_memory_pressure(sk)) {
>                         tcp_adjust_rcv_ssthresh(sk);
> +                       memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROT=
TLED);
> +               }
>
>                 /* free_space might become our new window, make sure we d=
on't
>                  * increase it due to wscale.
> @@ -3334,8 +3336,10 @@ u32 __tcp_select_window(struct sock *sk)
>         if (free_space < (full_space >> 1)) {
>                 icsk->icsk_ack.quick =3D 0;
>
> -               if (tcp_under_memory_pressure(sk))
> +               if (tcp_under_memory_pressure(sk)) {
>                         tcp_adjust_rcv_ssthresh(sk);
> +                       memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROT=
TLED);
> +               }
>
>                 /* if free space is too low, return a zero window */
>                 if (free_space < (allowed_space >> 4) || free_space < mss=
 ||
> --
> 2.47.3
>

