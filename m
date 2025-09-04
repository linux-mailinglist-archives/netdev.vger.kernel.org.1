Return-Path: <netdev+bounces-219757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B8DB42E06
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A5B1899729
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32C288D6;
	Thu,  4 Sep 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/64N9V/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4824B28;
	Thu,  4 Sep 2025 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944938; cv=none; b=R6Ir48IkJKs80rziXUZxzDKei3v6OUFL0aXlQg31+GguQI7C9GSvLLhKLCf9Eio0G9cQeCIzUjNUf7O6GKvVVM0s/kDzRBh+VrA5lUyb1oIuU476fQMkuX1p+M8DNyuwcMAPK11dQFVEoIv/jEke5aVnbJ6RJWZ7282997tEqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944938; c=relaxed/simple;
	bh=V9F1JHqTWKQP22vqAVjVr7MPSHZhkhCaYUA4POc7hU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD7TqGHYyPmyak70U0iJ4HXzPEMmez5jwm211kJJEs9aGQxLfsLhxTquRoImyLzFMGP6U824I4J1E4cZ1lcoMp6LnxOeIkd0lXmU4EIzAX0P/x+btouVVtpPUvnB7AD/He61F1u08WWof7uai2nEQiTe6u3cBs95qPOA89pXriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/64N9V/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-723ad237d1eso4907747b3.1;
        Wed, 03 Sep 2025 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756944935; x=1757549735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0THgvxJFt5go/qGjp8zLHBZUwzKvN5XEJ2DksK1IT8=;
        b=W/64N9V/WpYdfq/hun1dKNf0HCzq5VMaG9Xzi+pL9aNnbjeKoL0JWNXD63RL9beZdw
         jvB9jrtoRUn6K28JhHB0Qaw1nJXlpVrbKT3jLT0RfvUDh/qF1kAUZTAEBiyIzGUiMNv2
         El1vR74aEKoSp7X3vFX8U84oTuR8Exl1zB9GqNML+i+Sh8mp1as5SoRIdjd5RjNIF07L
         fbICo4G5zPDouEovX6n1alC7rHyZ8y2PXJg7bKhidtXDC4ovKeXONrvVM7RFkMz/VLv4
         v10O1b4btGHrQUOFT+MMklMXYj+vZJfkIoHHkF4SMRK1HMRVXE8Du2JbDtDh7Db14uNx
         FEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756944935; x=1757549735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0THgvxJFt5go/qGjp8zLHBZUwzKvN5XEJ2DksK1IT8=;
        b=nKFSR545tP8AEKYVqzAnmxtK+HrKFhonclbgFuXrI2ynnAYVSw60g0CvpR5xPq/JEw
         oOy8Iov+oNtbwmNG00olCK1KdtXn0xJz1raixFVo7SRUukB/1971eVZDn+Et4hLude6N
         /P6bukC2tkEOJPH1oQZzARHX2ICr37INcrrNsBX6B9AbQsEaq70NqaPJTUv7PVNqU5UA
         5PrlIq/HEdmOi1wTuIAkrRda1UfiEGuntUD2MgCkVyUO4fciKRguNyyV8LaYCTWCMXHS
         xDCE0T3czaM7BZpi/Xkv5E4SD8HT9Ybbt4WiSYh/cYMtxuEPULTRZV+eTbBlDFnr/G71
         KUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUeZ1pQA1MLw/uI6JbHq0Cm2IY9ZBj9PACcHsU87bDWrRXOjS86SOQ48qgArRZCZL1Jzs+gPj7tDGHdbY0=@vger.kernel.org, AJvYcCWpfQoinzDpoI8MNnak35pOWN1svrMpT6Bt+k5YlYoP1P+fQbMp4nVYqzZT4kahFYXg80VHNRqy@vger.kernel.org
X-Gm-Message-State: AOJu0YybpWAeqFfxZWb/A055+CtUamAlCLOqqKgCg71TKNIFNqL1CqKy
	0y4jUVIBrarYfSmxuzdmA53HHzVNFRODNPtAoTKKxPCYnyPWkE9w/T1m
X-Gm-Gg: ASbGncvNxQZGKWV9+FqAlrNfbYJBbNqTmwZn7/BMIXNt4VCeYC82Lz83+cfXZkOhs7p
	DB/y/GHAXFUab1lGDRqJRM78+9ssAH1NSQ3eKtj2fkl3oLTdjiLyxec91WaDRCmyzCU6M+acPT+
	PZuzY+GJgth59WupNu38O+BOAs97/saMJKbpnDlcXQl+pxCP1LfEyM5LFsrohQvWj3vXAVpj2+v
	eOAsdc/T2NRMbnDI8iodK18cSprALCUSBNriTUsu5Ssr8O5MT8rVD1ZSqdIH6qIO2+K2mD+L5Qf
	IEHwgOoSlaT8L12VEn6cvwBR2RvEmtRDaOmtGaYLfm8x0h5azd53j0Jlfn7/XHPYX7SXkhJUFgN
	cXCFENQo/nMrYbgw6KSM/s3Puu+uq+/Xlt49SWDwkj74BCvAr9wKTMDS9cQ==
X-Google-Smtp-Source: AGHT+IGNkxHigKKQASBmsGk4a+hbWsQYyx36aNfGJG3PisCNlhbPCSYJiczOToxjNaReNmlC5wt/Lw==
X-Received: by 2002:a05:690c:4444:b0:721:314a:e5ed with SMTP id 00721157ae682-72276399155mr220344517b3.20.1756944934172;
        Wed, 03 Sep 2025 17:15:34 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85647a3sm17438007b3.61.2025.09.03.17.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:15:33 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:15:31 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/2] net: devmem: use niov array for token
 management
Message-ID: <aLjaIwkpO64rJtui@devvm11784.nha0.facebook.com>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
 <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
 <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com>

On Wed, Sep 03, 2025 at 01:20:57PM -0700, Mina Almasry wrote:
> On Tue, Sep 2, 2025 at 2:36 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Improve CPU performance of devmem token management by using page offsets
> > as dmabuf tokens and using them for direct array access lookups instead
> > of xarray lookups. Consequently, the xarray can be removed. The result
> > is an average 5% reduction in CPU cycles spent by devmem RX user
> > threads.
> >
> 
> Great!
> 

Hey Mina, thanks for the feedback!

> > This patch changes the meaning of tokens. Tokens previously referred to
> > unique fragments of pages. In this patch tokens instead represent
> > references to pages, not fragments.  Because of this, multiple tokens
> > may refer to the same page and so have identical value (e.g., two small
> > fragments may coexist on the same page). The token and offset pair that
> > the user receives uniquely identifies fragments if needed.  This assumes
> > that the user is not attempting to sort / uniq the token list using
> > tokens alone.
> >
> > A new restriction is added to the implementation: devmem RX sockets
> > cannot switch dmabuf bindings. In practice, this is a symptom of invalid
> > configuration as a flow would have to be steered to a different queue or
> > device where there is a different binding, which is generally bad for
> > TCP flows.
> 
> Please do not assume configurations you don't use/care about are
> invalid. Currently reconfiguring flow steering while a flow is active
> works as intended today. This is a regression that needs to be
> resolved. But more importantly, looking at your code, I don't think
> this is a restriction you need to introduce?
> 

That's fair, let's see if we can lift it.

> > This restriction is necessary because the 32-bit dmabuf token
> > does not have enough bits to represent both the pages in a large dmabuf
> > and also a binding or dmabuf ID. For example, a system with 8 NICs and
> > 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
> > == 256 queues total == 2^8), which leaves only 24 bits for dmabuf pages
> > (2^24 * 4096 / (1<<30) == 64GB). This is insufficient for the device and
> > queue numbers on many current systems or systems that may need larger
> > GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
> > device).
> >
> > Using kperf[1] with 4 flows and workers, this patch improves receive
> > worker CPU util by ~4.9% with slightly better throughput.
> >
> > Before, mean cpu util for rx workers ~83.6%:
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00    0.00    0.00   17.41
> > Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00    0.00    0.00   16.67
> > Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00    0.00    0.00   16.54
> > Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00    0.00    0.00   14.86
> >
> > After, mean cpu util % for rx workers ~78.7%:
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00    0.00    0.00   23.20
> > Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00    0.00    0.00   21.94
> > Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00    0.00    0.00   22.73
> > Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00    0.00    0.00   17.32
> >
> 
> I think effectively all you're doing in this patch is removing xarray
> with a regular array, right? I'm surprised an xarray account for 5%
> cpu utilization. I wonder if you have debug configs turned on during
> these experiments. Can you perf trace what about the xarray is taking
> so long? I wonder if we're just using xarrays improperly (maybe
> hitting constant resizing slow paths or something), and a similar
> improvement can be gotten by adjusting the xarray flags or what not.
> 

That is right.

Here is some perf data gathered from:

	perf record -a -g -F 99 -C 0-7 -- sleep 5

RX queues pinned to 0-3 and kperf server pinned to 4-7.

    11.25%  server       [kernel.kallsyms]                                      [k] tcp_recvmsg
            |          
             --10.98%--tcp_recvmsg
                       bpf_trampoline_6442594803
                       tcp_recvmsg
                       inet6_recvmsg
                       ____sys_recvmsg
                       ___sys_recvmsg
                       __x64_sys_recvmsg
                       do_syscall_64
                       entry_SYSCALL_64_after_hwframe
                       __libc_recvmsg
                       |          
                        --2.74%--0x100000082

     5.65%  server       [kernel.kallsyms]                                      [k] xas_store
            |          
             --5.63%--xas_store
                       |          
                       |--3.92%--__xa_erase
                       |          sock_devmem_dontneed
                       |          sk_setsockopt
                       |          __x64_sys_setsockopt
                       |          do_syscall_64
                       |          entry_SYSCALL_64_after_hwframe
                       |          __GI___setsockopt
                       |          0x4f00000001
                       |          
                       |--0.94%--__xa_alloc
                       |          tcp_recvmsg
                       |          bpf_trampoline_6442594803
                       |          tcp_recvmsg
                       |          inet6_recvmsg
                       |          ____sys_recvmsg
                       |          ___sys_recvmsg
                       |          __x64_sys_recvmsg
                       |          do_syscall_64
                       |          entry_SYSCALL_64_after_hwframe
                       |          __libc_recvmsg
                       |          
                        --0.76%--__xa_cmpxchg
                                  tcp_xa_pool_commit_locked
                                  tcp_xa_pool_commit
                                  tcp_recvmsg
                                  bpf_trampoline_6442594803
                                  tcp_recvmsg
                                  inet6_recvmsg
                                  ____sys_recvmsg
                                  ___sys_recvmsg
                                  __x64_sys_recvmsg
                                  do_syscall_64
                                  entry_SYSCALL_64_after_hwframe
                                  __libc_recvmsg


     [...]

     1.22%  server       [kernel.kallsyms]                                      [k] xas_find_marked
            |          
             --1.19%--xas_find_marked
                       __xa_alloc
                       tcp_recvmsg
                       bpf_trampoline_6442594803
                       tcp_recvmsg
                       inet6_recvmsg
                       ____sys_recvmsg
                       ___sys_recvmsg
                       __x64_sys_recvmsg
                       do_syscall_64
                       entry_SYSCALL_64_after_hwframe
                       __libc_recvmsg


Here is the output from zcat /proc/config.gz | grep DEBUG | grep =y, I'm
not 100% sure which may be worth toggling. I'm happy to rerun the
experiments if any of these are suspicious looking:

CONFIG_X86_DEBUGCTLMSR=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BFQ_CGROUP_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_PNP_DEBUG_MESSAGES=y
CONFIG_SCSI_LPFC_DEBUG_FS=y
CONFIG_MLX4_DEBUG=y
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_NFS_DEBUG=y
CONFIG_SUNRPC_DEBUG=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_SLUB_DEBUG=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_SCHED_DEBUG=y
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_CSD_LOCK_WAIT_DEBUG=y
CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y
CONFIG_DEBUG_CGROUP_REF=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y


For more context, I did a few other experiments before eventually
landing on this patch:

1) hacky approach - don't do any token management at all, replace dmabuf
   token with 64-bit pointer to niov, teach recvmsg() /
   sock_devmem_dontneed() to inc/dec the niov reference directly... this
   actually reduced the CPU util by a very consistent 10%+ per worker
   (the largest delta of all my experiements).

2) keep xarray, but use RCU/lockless lookups in both recvmsg/dontneed.
   Use page indices + xa_insert instead of xa_alloc. Acquire lock only if
   lockless lookup returns null in recvmsg path. Don't erase in dontneed,
   only take rcu_read_lock() and do lookup. Let xarray grow according to
   usage and cleanup when the socket is destroyed. Surprisingly, this
   didn't offer noticeable improvement.

3) use normal array but no atomics -- incorrect, but saw good improvement,
   despite possibility of leaked references.

4) use a hashmap + bucket locks instead of xarray --  performed way
   worse than xarray, no change to token

> > Mean throughput improves, but falls within a standard deviation (~45GB/s
> > for 4 flows on a 50GB/s NIC, one hop).
> >
> > This patch adds an array of atomics for counting the tokens returned to
> > the user for a given page. There is a 4-byte atomic per page in the
> > dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
> >
> > [1]: https://github.com/facebookexperimental/kperf
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  include/net/sock.h       |   5 ++-
> >  net/core/devmem.c        |  17 ++++----
> >  net/core/devmem.h        |   2 +-
> >  net/core/sock.c          |  24 +++++++----
> >  net/ipv4/tcp.c           | 107 +++++++++++++++--------------------------------
> >  net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
> >  net/ipv4/tcp_minisocks.c |   2 -
> >  7 files changed, 99 insertions(+), 98 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 1e7f124871d2..70c97880229d 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -573,7 +573,10 @@ struct sock {
> >  #endif
> >         struct rcu_head         sk_rcu;
> >         netns_tracker           ns_tracker;
> > -       struct xarray           sk_user_frags;
> > +       struct {
> > +               struct net_devmem_dmabuf_binding        *binding;
> > +               atomic_t                                *urefs;
> > +       } sk_user_frags;
> >
> 
> AFAIU, if you made sk_user_frags an array of (unref, binding) tuples
> instead of just an array of urefs then you can remove the
> single-binding restriction.
> 
> Although, I wonder what happens if the socket receives the netmem at
> the same index on 2 different dmabufs. At that point I assume the
> wrong uref gets incremented? :(
> 

Right. We need some bits to differentiate bindings. Here are some ideas
I've had about this, I wonder what your thoughts are on them:

1) Encode a subset of bindings and wait for availability if the encoding
space becomes exhausted. For example, we could encode the binding in 5
bits for outstanding references across 32 bindings and 27 bits (512 GB)
of dmabuf. If recvmsg wants to return a reference to a 33rd binding, it
waits until the user returns enough tokens to release one of the binding
encoding bits (at which point it could be reused for the new reference).

2) opt into an extended token (dmabuf_token_v2) via sockopts, and add
the binding ID or other needed information there.

> One way or another the single-binding restriction needs to be removed
> I think. It's regressing a UAPI that currently works.
> 
> >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> >         struct module           *sk_owner;
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index b4c570d4f37a..50e92dcf5bf1 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -187,6 +187,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >         struct dma_buf *dmabuf;
> >         unsigned int sg_idx, i;
> >         unsigned long virtual;
> > +       gfp_t flags;
> >         int err;
> >
> >         if (!dma_dev) {
> > @@ -230,14 +231,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 goto err_detach;
> >         }
> >
> > -       if (direction == DMA_TO_DEVICE) {
> > -               binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > -                                             sizeof(struct net_iov *),
> > -                                             GFP_KERNEL);
> > -               if (!binding->vec) {
> > -                       err = -ENOMEM;
> > -                       goto err_unmap;
> > -               }
> > +       flags = (direction == DMA_FROM_DEVICE) ? __GFP_ZERO : 0;
> > +
> 
> Why not pass __GFP_ZERO unconditionally?
> 

Seemed unnecessary for the TX side, though I see no problem adding it
for the next rev.

> > +       binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > +                                     sizeof(struct net_iov *),
> > +                                     GFP_KERNEL | flags);
> > +       if (!binding->vec) {
> > +               err = -ENOMEM;
> > +               goto err_unmap;
> >         }
> >
> >         /* For simplicity we expect to make PAGE_SIZE allocations, but the
> > diff --git a/net/core/devmem.h b/net/core/devmem.h
> > index 2ada54fb63d7..d4eb28d079bb 100644
> > --- a/net/core/devmem.h
> > +++ b/net/core/devmem.h
> > @@ -61,7 +61,7 @@ struct net_devmem_dmabuf_binding {
> >
> >         /* Array of net_iov pointers for this binding, sorted by virtual
> >          * address. This array is convenient to map the virtual addresses to
> > -        * net_iovs in the TX path.
> > +        * net_iovs.
> >          */
> >         struct net_iov **vec;
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9a8290fcc35d..3a5cb4e10519 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -87,6 +87,7 @@
> >
> >  #include <linux/unaligned.h>
> >  #include <linux/capability.h>
> > +#include <linux/dma-buf.h>
> >  #include <linux/errno.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/types.h>
> > @@ -151,6 +152,7 @@
> >  #include <uapi/linux/pidfd.h>
> >
> >  #include "dev.h"
> > +#include "devmem.h"
> >
> >  static DEFINE_MUTEX(proto_list_mutex);
> >  static LIST_HEAD(proto_list);
> > @@ -1100,32 +1102,40 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> >                 return -EFAULT;
> >         }
> >
> > -       xa_lock_bh(&sk->sk_user_frags);
> >         for (i = 0; i < num_tokens; i++) {
> >                 for (j = 0; j < tokens[i].token_count; j++) {
> > +                       struct net_iov *niov;
> > +                       unsigned int token;
> > +                       netmem_ref netmem;
> > +
> > +                       token = tokens[i].token_start + j;
> > +                       if (WARN_ONCE(token >= sk->sk_user_frags.binding->dmabuf->size / PAGE_SIZE,
> > +                                     "invalid token passed from user"))
> > +                               break;
> 
> WARNs on invalid user behavior are a non-starter AFAIU. For one,
> syzbot trivially reproduces them and files a bug. Please remove all of
> them. pr_err may be acceptable for extremely bad errors. Invalid user
> input is not worthy of WARN or pr_err.
> 

Gotcha, I did not know that. Sounds good to me.

> > +
> >                         if (++num_frags > MAX_DONTNEED_FRAGS)
> >                                 goto frag_limit_reached;
> > -
> > -                       netmem_ref netmem = (__force netmem_ref)__xa_erase(
> > -                               &sk->sk_user_frags, tokens[i].token_start + j);
> > +                       niov = sk->sk_user_frags.binding->vec[token];
> > +                       netmem = net_iov_to_netmem(niov);
> 
> So token is the index to both vec and sk->sk_user_frags.binding->vec?
> 
> xarrays are a resizable array. AFAIU what you're doing abstractly here
> is replacing a resizable array with an array of max size, no? (I
> didn't read too closely yet, I may be missing something).
> 

Yes, 100%.

> Which makes me think either due to a bug or due to specifics of your
> setup, xarray is unreasonably expensive. Without investigating the
> details I wonder if we're constantly running into a resizing slowpath
> in xarray code and I think this needs some investigation.
> 

Certainly possible, I found the result surprising myself, hence my
experiment with a more read-mostly usage of xarray.

> >
> >                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> >                                 continue;
> >
> > +                       if (WARN_ONCE(atomic_dec_if_positive(&sk->sk_user_frags.urefs[token])
> > +                                               < 0, "user released token too many times"))
> 
> Here and everywhere, please remove the WARNs for weird user behavior.
> 
> > +                               continue;
> > +
> >                         netmems[netmem_num++] = netmem;
> >                         if (netmem_num == ARRAY_SIZE(netmems)) {
> > -                               xa_unlock_bh(&sk->sk_user_frags);
> >                                 for (k = 0; k < netmem_num; k++)
> >                                         WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> >                                 netmem_num = 0;
> > -                               xa_lock_bh(&sk->sk_user_frags);
> 
> You remove the locking but it's not clear to me why we don't need it
> anymore. What's stopping 2 dontneeds from freeing at the same time?
> I'm guessing it's because urefs are atomic so we don't need any extra
> sync?
> 

Yes, atomic uref. The array itself doesn't change until the socket is
destroyed.

> >                         }
> >                         ret++;
> >                 }
> >         }
> >
> >  frag_limit_reached:
> > -       xa_unlock_bh(&sk->sk_user_frags);
> >         for (k = 0; k < netmem_num; k++)
> >                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 40b774b4f587..585b50fa8c00 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -261,6 +261,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/highmem.h>
> >  #include <linux/cache.h>
> > +#include <linux/dma-buf.h>
> >  #include <linux/err.h>
> >  #include <linux/time.h>
> >  #include <linux/slab.h>
> > @@ -475,7 +476,8 @@ void tcp_init_sock(struct sock *sk)
> >
> >         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
> >         sk_sockets_allocated_inc(sk);
> > -       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
> > +       sk->sk_user_frags.binding = NULL;
> > +       sk->sk_user_frags.urefs = NULL;
> >  }
> >  EXPORT_IPV6_MOD(tcp_init_sock);
> >
> > @@ -2386,68 +2388,6 @@ static int tcp_inq_hint(struct sock *sk)
> >         return inq;
> >  }
> >
> > -/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. */
> > -struct tcp_xa_pool {
> > -       u8              max; /* max <= MAX_SKB_FRAGS */
> > -       u8              idx; /* idx <= max */
> > -       __u32           tokens[MAX_SKB_FRAGS];
> > -       netmem_ref      netmems[MAX_SKB_FRAGS];
> > -};
> > -
> > -static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
> > -{
> > -       int i;
> > -
> > -       /* Commit part that has been copied to user space. */
> > -       for (i = 0; i < p->idx; i++)
> > -               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
> > -                            (__force void *)p->netmems[i], GFP_KERNEL);
> > -       /* Rollback what has been pre-allocated and is no longer needed. */
> > -       for (; i < p->max; i++)
> > -               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> > -
> > -       p->max = 0;
> > -       p->idx = 0;
> > -}
> > -
> > -static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
> > -{
> > -       if (!p->max)
> > -               return;
> > -
> > -       xa_lock_bh(&sk->sk_user_frags);
> > -
> > -       tcp_xa_pool_commit_locked(sk, p);
> > -
> > -       xa_unlock_bh(&sk->sk_user_frags);
> > -}
> > -
> > -static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> > -                             unsigned int max_frags)
> > -{
> > -       int err, k;
> > -
> > -       if (p->idx < p->max)
> > -               return 0;
> > -
> > -       xa_lock_bh(&sk->sk_user_frags);
> > -
> > -       tcp_xa_pool_commit_locked(sk, p);
> > -
> > -       for (k = 0; k < max_frags; k++) {
> > -               err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> > -                                XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
> > -               if (err)
> > -                       break;
> > -       }
> > -
> > -       xa_unlock_bh(&sk->sk_user_frags);
> > -
> > -       p->max = k;
> > -       p->idx = 0;
> > -       return k ? 0 : err;
> > -}
> > -
> >  /* On error, returns the -errno. On success, returns number of bytes sent to the
> >   * user. May not consume all of @remaining_len.
> >   */
> > @@ -2456,14 +2396,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                               int remaining_len)
> >  {
> >         struct dmabuf_cmsg dmabuf_cmsg = { 0 };
> > -       struct tcp_xa_pool tcp_xa_pool;
> >         unsigned int start;
> >         int i, copy, n;
> >         int sent = 0;
> >         int err = 0;
> >
> > -       tcp_xa_pool.max = 0;
> > -       tcp_xa_pool.idx = 0;
> >         do {
> >                 start = skb_headlen(skb);
> >
> > @@ -2510,8 +2447,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                  */
> >                 for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >                         skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> > +                       struct net_devmem_dmabuf_binding *binding;
> >                         struct net_iov *niov;
> >                         u64 frag_offset;
> > +                       size_t size;
> > +                       u32 token;
> >                         int end;
> >
> >                         /* !skb_frags_readable() should indicate that ALL the
> > @@ -2544,13 +2484,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >                                               start;
> >                                 dmabuf_cmsg.frag_offset = frag_offset;
> >                                 dmabuf_cmsg.frag_size = copy;
> > -                               err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
> > -                                                        skb_shinfo(skb)->nr_frags - i);
> > -                               if (err)
> > +
> > +                               binding = net_devmem_iov_binding(niov);
> > +
> > +                               if (!sk->sk_user_frags.binding) {
> > +                                       sk->sk_user_frags.binding = binding;
> > +
> > +                                       size = binding->dmabuf->size / PAGE_SIZE;
> > +                                       sk->sk_user_frags.urefs = kzalloc(size,
> > +                                                                         GFP_KERNEL);
> > +                                       if (!sk->sk_user_frags.urefs) {
> > +                                               sk->sk_user_frags.binding = NULL;
> > +                                               err = -ENOMEM;
> > +                                               goto out;
> > +                                       }
> > +
> > +                                       net_devmem_dmabuf_binding_get(binding);
> 
> It's not clear to me why we need to get the binding. AFAIR the way it
> works is that we grab a reference on the net_iov, which guarantees
> that the associated pp is alive, which in turn guarantees that the
> binding remains alive and we don't need to get the binding for every
> frag.
> 

Oh you are right, the chain of references will keep it alive at least
until dontneed.

> > +                               }
> > +
> > +                               if (WARN_ONCE(sk->sk_user_frags.binding != binding,
> > +                                             "binding changed for devmem socket")) {
> 
> Remove WARN_ONCE. It's not reasonable to kernel splat because the user
> reconfigured flow steering me thinks.
> 

Sounds good.

> > +                                       err = -EFAULT;
> >                                         goto out;
> > +                               }
> > +
> > +                               token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
> > +                               binding->vec[token] = niov;
> 
> I don't think you can do this? I thought vec[token] was already == niov.
> 
> binding->vec should be initialized when teh binding is initialized,
> not re-written on every recvmsg, no?
> 

Currently binding->vec is only initialized like that if direction ==
DMA_TO_DEVICE, but now that you mention it I don't see why RX shouldn't
also initialize upfront too.

[...]

> Thanks,
> Mina

Thanks again for the review, much appreciated!

Best,
Bobby

