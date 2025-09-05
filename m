Return-Path: <netdev+bounces-220478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5AB46490
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11E834E0F60
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F761274FE3;
	Fri,  5 Sep 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xK0/NUjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6925DB0D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103935; cv=none; b=hywKuXfweibcl8hE0+pNC6a4Lza/NgOrg4So5MqXDCZNgQ1lToH5iYwOECpLHWX0tO47XK2if7tO9xcCfbo+HiVAn0io/Kzp6ROSySgqVH5KdmPM8nexXRWVQDHxR+sxz8xuqp7aeowGqv15TmVhyjPHqyeQLwm5Xv0ZZnDSiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103935; c=relaxed/simple;
	bh=jDz74jtthF77PeBsMR7o2OGzDzYeLylYv8sJITBwzHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Trk3C1YkxweJ72tPIqSh0b40c1SFeECcGa4Jgq/2PC1kXEiGLKj+btCfgxVARrDkR+/R+GbgzGfqoJXy3uw0k5Jmno/vcZ3GZKxP9MnFw6BumfFi87HgFjcB4AZfxqXespdDNMT/EAvsrAVUmoh8tWgERJPplUZ6AN23dPky0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xK0/NUjQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6b77c91fso523e87.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757103931; x=1757708731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kgKtkFSvFxN0+GOpeYsXguLH3MBg6T1r5BTTkCZlzY=;
        b=xK0/NUjQqo/hoVq2QmNugemb0MSHJ3Puy3iK/1XltHHynDreQX2xz1JbFk8ZiOg1Y+
         Fn0OUBhY2/S5dqTfsH7oQeSF0gO/XwVkdLeAe/ATlqObmtG+esTeI6jTxgZBET73+PWf
         0pXmO055SqE2fH9d6qD7GMwt9epkZOmmilWnB1KtQr9COd3XOx1UEyRDuWMwQDwPzWVi
         aOQvNK7OL6z9Etu2B81OOuIsFDa6xZCXn+qhkuJKLTGrkCNGraxBAXGYqMYNFIbwcmzs
         8srrf2Iv+fELp4cNK4EcQAbDsqNQ3PS7+rHUe8t7aOGuYvACq0VDrfyJAb2I66cY4APY
         WgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757103931; x=1757708731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kgKtkFSvFxN0+GOpeYsXguLH3MBg6T1r5BTTkCZlzY=;
        b=E2JCnLDb0fKf+JCcsuHh9chwQKADXoYP9SwHIcNdhqXI376AnF37EEv+EVy0GIg7QV
         V/1YOp9IfgvwH5pLzzTOdSMLZ1xiodDUI8+B7V1+4HH7PkBjbVtn8j3hq/eYbALPhXP2
         jMX/qP8CMIvTKHFPKXKQGmXNF2SVokbURFrP6qmxa3K2NYrjVmwZt+5O4CCCnOMkixyo
         x9RJbJrmAfwCa5vnD8Uk6QcicecWbMnRfBDuDIoixAgBsdS306PNJHhr4oEhWekAQWFq
         qNdAsRlrfAxBvnE60BzCymDQvyXwdTESbcrvh95ultKXbpseoUodZzy2/lQWlye2cjiK
         LAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXZhJCSfd4EFwVVUAiKpfvaOYzqOk7bKZ1+i5NqOCjNc27+8uvBwNqL4s6T+h1mO4wiV6iHSo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3S631vaGKODFJYBK2I5XmN8qysWby/aOMlTUxxEIzRPE5ECD
	GL5nGDk0YF94iwFu3LDzGjjFqEoOscxcpVUZp5P1wvAW0ueujbIL9+ET4IYxQgsGqFgwzwK2fr4
	caz0uK5cL0/KiX3gqXNWEVXz3oI3dUGDUTB+/ruuR
X-Gm-Gg: ASbGncsRnfqbcWXbOFKV2gl8ZLC6QWqC+qHTY35Lvq0hNk4Cy8jO2dx4ulKyp48Kjzl
	CnzTxwvCFk4DcULV5p4CMapL4jpeY5Eowl5Ng/s5EAVXHGK1n0yH+a9SfZJi03HbSCUJdX2tVJA
	HCuwfiM16grymc+bvrNlq9wny1rPWy5OrwDum2vMbkYuOtZLOgCB9qxPK5MqjUg3069V+ItibVG
	FUnRekTL8ZZmY0n67HxdEBdXA==
X-Google-Smtp-Source: AGHT+IEjoWid/fO8vEMfv+XUMnPq6NXM0UqfApFnVsvTvRttvhe+pHkGQgOO0iJz7aagmll2Km1pmMI4XrtkuYW71QE=
X-Received: by 2002:a05:6512:617:10b0:55f:68fe:76d4 with SMTP id
 2adb3069b0e04-5624d92cfb5mr44215e87.5.1757103930911; Fri, 05 Sep 2025
 13:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
 <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
 <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com> <aLjaIwkpO64rJtui@devvm11784.nha0.facebook.com>
In-Reply-To: <aLjaIwkpO64rJtui@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 5 Sep 2025 13:25:18 -0700
X-Gm-Features: Ac12FXyWRe7ahZJ70LMfFa5mWgcNJGy3jsE6h5CiZdZTxZA96gMHBx-UbV5x83g
Message-ID: <CAHS8izMe+u1pFzX5U_Mvifn3VNY2WGqi_uDvqWdG7RwPKW3z6A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: devmem: use niov array for token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:15=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Wed, Sep 03, 2025 at 01:20:57PM -0700, Mina Almasry wrote:
> > On Tue, Sep 2, 2025 at 2:36=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> > >
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> > > Improve CPU performance of devmem token management by using page offs=
ets
> > > as dmabuf tokens and using them for direct array access lookups inste=
ad
> > > of xarray lookups. Consequently, the xarray can be removed. The resul=
t
> > > is an average 5% reduction in CPU cycles spent by devmem RX user
> > > threads.
> > >
> >
> > Great!
> >
>
> Hey Mina, thanks for the feedback!
>
> > > This patch changes the meaning of tokens. Tokens previously referred =
to
> > > unique fragments of pages. In this patch tokens instead represent
> > > references to pages, not fragments.  Because of this, multiple tokens
> > > may refer to the same page and so have identical value (e.g., two sma=
ll
> > > fragments may coexist on the same page). The token and offset pair th=
at
> > > the user receives uniquely identifies fragments if needed.  This assu=
mes
> > > that the user is not attempting to sort / uniq the token list using
> > > tokens alone.
> > >
> > > A new restriction is added to the implementation: devmem RX sockets
> > > cannot switch dmabuf bindings. In practice, this is a symptom of inva=
lid
> > > configuration as a flow would have to be steered to a different queue=
 or
> > > device where there is a different binding, which is generally bad for
> > > TCP flows.
> >
> > Please do not assume configurations you don't use/care about are
> > invalid. Currently reconfiguring flow steering while a flow is active
> > works as intended today. This is a regression that needs to be
> > resolved. But more importantly, looking at your code, I don't think
> > this is a restriction you need to introduce?
> >
>
> That's fair, let's see if we can lift it.
>
> > > This restriction is necessary because the 32-bit dmabuf token
> > > does not have enough bits to represent both the pages in a large dmab=
uf
> > > and also a binding or dmabuf ID. For example, a system with 8 NICs an=
d
> > > 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queue=
s
> > > =3D=3D 256 queues total =3D=3D 2^8), which leaves only 24 bits for dm=
abuf pages
> > > (2^24 * 4096 / (1<<30) =3D=3D 64GB). This is insufficient for the dev=
ice and
> > > queue numbers on many current systems or systems that may need larger
> > > GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory =
per
> > > device).
> > >
> > > Using kperf[1] with 4 flows and workers, this patch improves receive
> > > worker CPU util by ~4.9% with slightly better throughput.
> > >
> > > Before, mean cpu util for rx workers ~83.6%:
> > >
> > > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> > > Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0=
.00    0.00    0.00   17.41
> > > Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0=
.00    0.00    0.00   16.67
> > > Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0=
.00    0.00    0.00   16.54
> > > Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0=
.00    0.00    0.00   14.86
> > >
> > > After, mean cpu util % for rx workers ~78.7%:
> > >
> > > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
> > > Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0=
.00    0.00    0.00   23.20
> > > Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0=
.00    0.00    0.00   21.94
> > > Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0=
.00    0.00    0.00   22.73
> > > Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0=
.00    0.00    0.00   17.32
> > >
> >
> > I think effectively all you're doing in this patch is removing xarray
> > with a regular array, right? I'm surprised an xarray account for 5%
> > cpu utilization. I wonder if you have debug configs turned on during
> > these experiments. Can you perf trace what about the xarray is taking
> > so long? I wonder if we're just using xarrays improperly (maybe
> > hitting constant resizing slow paths or something), and a similar
> > improvement can be gotten by adjusting the xarray flags or what not.
> >
>
> That is right.
>
> Here is some perf data gathered from:
>
>         perf record -a -g -F 99 -C 0-7 -- sleep 5
>
> RX queues pinned to 0-3 and kperf server pinned to 4-7.
>
>     11.25%  server       [kernel.kallsyms]                               =
       [k] tcp_recvmsg
>             |
>              --10.98%--tcp_recvmsg
>                        bpf_trampoline_6442594803
>                        tcp_recvmsg
>                        inet6_recvmsg
>                        ____sys_recvmsg
>                        ___sys_recvmsg
>                        __x64_sys_recvmsg
>                        do_syscall_64
>                        entry_SYSCALL_64_after_hwframe
>                        __libc_recvmsg
>                        |
>                         --2.74%--0x100000082
>
>      5.65%  server       [kernel.kallsyms]                               =
       [k] xas_store
>             |
>              --5.63%--xas_store
>                        |
>                        |--3.92%--__xa_erase
>                        |          sock_devmem_dontneed
>                        |          sk_setsockopt
>                        |          __x64_sys_setsockopt
>                        |          do_syscall_64
>                        |          entry_SYSCALL_64_after_hwframe
>                        |          __GI___setsockopt
>                        |          0x4f00000001
>                        |
>                        |--0.94%--__xa_alloc
>                        |          tcp_recvmsg
>                        |          bpf_trampoline_6442594803
>                        |          tcp_recvmsg
>                        |          inet6_recvmsg
>                        |          ____sys_recvmsg
>                        |          ___sys_recvmsg
>                        |          __x64_sys_recvmsg
>                        |          do_syscall_64
>                        |          entry_SYSCALL_64_after_hwframe
>                        |          __libc_recvmsg
>                        |
>                         --0.76%--__xa_cmpxchg
>                                   tcp_xa_pool_commit_locked
>                                   tcp_xa_pool_commit
>                                   tcp_recvmsg
>                                   bpf_trampoline_6442594803
>                                   tcp_recvmsg
>                                   inet6_recvmsg
>                                   ____sys_recvmsg
>                                   ___sys_recvmsg
>                                   __x64_sys_recvmsg
>                                   do_syscall_64
>                                   entry_SYSCALL_64_after_hwframe
>                                   __libc_recvmsg
>
>
>      [...]
>
>      1.22%  server       [kernel.kallsyms]                               =
       [k] xas_find_marked
>             |
>              --1.19%--xas_find_marked
>                        __xa_alloc
>                        tcp_recvmsg
>                        bpf_trampoline_6442594803
>                        tcp_recvmsg
>                        inet6_recvmsg
>                        ____sys_recvmsg
>                        ___sys_recvmsg
>                        __x64_sys_recvmsg
>                        do_syscall_64
>                        entry_SYSCALL_64_after_hwframe
>                        __libc_recvmsg
>

One thing that is a bit weird is that you're seeing 5.67% + 1.19%
overall overhead for xarrays, but when you do the hacky
just-give-userspace-the-pointer experiment you see a full 10%
reduction. But that's beside the point.

>
> Here is the output from zcat /proc/config.gz | grep DEBUG | grep =3Dy, I'=
m
> not 100% sure which may be worth toggling. I'm happy to rerun the
> experiments if any of these are suspicious looking:
>
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_BFQ_CGROUP_DEBUG=3Dy
> CONFIG_CMA_DEBUGFS=3Dy
> CONFIG_FW_LOADER_DEBUG=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_SCSI_LPFC_DEBUG_FS=3Dy
> CONFIG_MLX4_DEBUG=3Dy
> CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
> CONFIG_NFS_DEBUG=3Dy
> CONFIG_SUNRPC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> CONFIG_DEBUG_INFO_BTF=3Dy
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> CONFIG_DEBUG_PAGE_REF=3Dy
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_CSD_LOCK_WAIT_DEBUG=3Dy
> CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=3Dy
> CONFIG_DEBUG_CGROUP_REF=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>
>

Thanks for the detailed data here. Nothing overly wrong jumps at me.

Cc Matthew Wilcox here. Maybe he can spot something obviously wrong
with how we're using xarrays that can be optimized.

> For more context, I did a few other experiments before eventually
> landing on this patch:
>
> 1) hacky approach - don't do any token management at all, replace dmabuf
>    token with 64-bit pointer to niov, teach recvmsg() /
>    sock_devmem_dontneed() to inc/dec the niov reference directly... this
>    actually reduced the CPU util by a very consistent 10%+ per worker
>    (the largest delta of all my experiements).
>
> 2) keep xarray, but use RCU/lockless lookups in both recvmsg/dontneed.
>    Use page indices + xa_insert instead of xa_alloc. Acquire lock only if
>    lockless lookup returns null in recvmsg path. Don't erase in dontneed,
>    only take rcu_read_lock() and do lookup. Let xarray grow according to
>    usage and cleanup when the socket is destroyed. Surprisingly, this
>    didn't offer noticeable improvement.
>
> 3) use normal array but no atomics -- incorrect, but saw good improvement=
,
>    despite possibility of leaked references.
>
> 4) use a hashmap + bucket locks instead of xarray --  performed way
>    worse than xarray, no change to token
>
> > > Mean throughput improves, but falls within a standard deviation (~45G=
B/s
> > > for 4 flows on a 50GB/s NIC, one hop).
> > >
> > > This patch adds an array of atomics for counting the tokens returned =
to
> > > the user for a given page. There is a 4-byte atomic per page in the
> > > dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
> > >
> > > [1]: https://github.com/facebookexperimental/kperf
> > >
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > ---
> > >  include/net/sock.h       |   5 ++-
> > >  net/core/devmem.c        |  17 ++++----
> > >  net/core/devmem.h        |   2 +-
> > >  net/core/sock.c          |  24 +++++++----
> > >  net/ipv4/tcp.c           | 107 +++++++++++++++----------------------=
----------
> > >  net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
> > >  net/ipv4/tcp_minisocks.c |   2 -
> > >  7 files changed, 99 insertions(+), 98 deletions(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 1e7f124871d2..70c97880229d 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -573,7 +573,10 @@ struct sock {
> > >  #endif
> > >         struct rcu_head         sk_rcu;
> > >         netns_tracker           ns_tracker;
> > > -       struct xarray           sk_user_frags;
> > > +       struct {
> > > +               struct net_devmem_dmabuf_binding        *binding;
> > > +               atomic_t                                *urefs;
> > > +       } sk_user_frags;
> > >
> >
> > AFAIU, if you made sk_user_frags an array of (unref, binding) tuples
> > instead of just an array of urefs then you can remove the
> > single-binding restriction.
> >
> > Although, I wonder what happens if the socket receives the netmem at
> > the same index on 2 different dmabufs. At that point I assume the
> > wrong uref gets incremented? :(
> >
>
> Right. We need some bits to differentiate bindings. Here are some ideas
> I've had about this, I wonder what your thoughts are on them:
>
> 1) Encode a subset of bindings and wait for availability if the encoding
> space becomes exhausted. For example, we could encode the binding in 5
> bits for outstanding references across 32 bindings and 27 bits (512 GB)
> of dmabuf. If recvmsg wants to return a reference to a 33rd binding, it
> waits until the user returns enough tokens to release one of the binding
> encoding bits (at which point it could be reused for the new reference).
>

This, I think, sounds reasonable. supporting up to 2^5 rx dmabuf
bindings at once and 2^27 max dmabuf size should be fine for us I
think. Although you have to be patient with me, I have to make sure
via tests and code inspection that these new limits will be OK. Also
please understand the risk that even if the changes don't break us,
they may break someone and have to be reverted anyway, although I
think the risk is small.

Another suggestion I got from the team is to use a bitmap instead of
an array of atomics. I initially thought this could work, but thinking
about it more, I think that would not work, no? Because it's not 100%
guaranteed that the socket will only get 1 ref on a net_iov. In the
case where the driver fragments the net_iov, multiple difference frags
could point to the same net_iov which means multiple refs. So it seems
we're stuck with an array of atomic_t.

> 2) opt into an extended token (dmabuf_token_v2) via sockopts, and add
> the binding ID or other needed information there.
>

Eh, I would say this is an overkill? Today the limit of dma-bufs
supported is 2^27 and I think the dmabuf size is technically 2^32 or
something, but I don't know that we need all this flexibility for
devmem tcp. I think adding a breakdown like above may be fine.

> > One way or another the single-binding restriction needs to be removed
> > I think. It's regressing a UAPI that currently works.
> >

Thinking about this more, if we can't figure out a different way and
have to have a strict 1 socket to 1 dma-buf mapping, that may be
acceptable...

...the best way to do it is actually to do this, I think, would be to
actually make sure the user can't break the mapping via `ethtool -N`.
I.e. when the user tells us to update or delete a flow steering rule
that belongs to a devmem socket, reject the request altogether. At
that point we could we can be sure that the mapping would not change
anyway. Although I don't know how feasible to implement this is.

AFAICT as well AF_XDP is in a similar boat to devmem in this regard.
The AF_XDP docs require flow steering to be configured for the data to
be available in the umem (and I assume, if flow steering is
reconfigured then the data disappears from the umem?). Stan do you
know how this works? If AF_XDP allows the user to break it by
reconfiguring flow steering it may also be reasonable to allow the
user to break a devmem socket as well (although maybe with
clarification in the docs.

--
Thanks,
Mina

