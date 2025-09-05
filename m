Return-Path: <netdev+bounces-220482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D14B464A9
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB44BA0636B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D72C15BA;
	Fri,  5 Sep 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNgrd3V0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36992C15A0;
	Fri,  5 Sep 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104722; cv=none; b=I8M/NDowogYB4iBia7/AQFlRgTGPR8IUL3cQhBWBkXCxif8R4Bwwjmf7LJ0Uthb06eWTPhEBSPnuUFM5K7tz16VSltOFsHSn+1N439EJ21VZriMcU48woQ3dCE/wWl8a0WaTcyda9DnxSFEBBTiDYAN+mIfQ+275VVjHR9fYIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104722; c=relaxed/simple;
	bh=ie7MjFdZ9kNevq7sNR4c5Jnj9M312wu1JfDMTpZ5dfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT1BvxRKVwbv2Iiqm1PW0ltllLHRrnHCbchYs6EgUGShfvBweVy1Ked9NEfRJJ36s/nlFVmsiMV9u6dzeuTURyav/jb7KGO6o65a+VYmAjRZloCgySSXI83JIC+1nQpi2YvXtflKpAXbmnu71CcRAvwGOmXipGIQUj2vDUYaMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNgrd3V0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b21006804so26191085ad.3;
        Fri, 05 Sep 2025 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757104720; x=1757709520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GHCpdiwiI3ZIBuEZAHuwX3A3o77CaUiHFNIMRjlwvlA=;
        b=LNgrd3V0n+jkZ+baNYJXbGpzvwAQ+/6rBsOMImugf+f60U8enwH0D++g9Wuzfgyvjm
         jEJQznW+uod8srcO5eM4fyqA+PTjrBSaDBGYEwT0lG6rNVSN54HmZazq4d0jfqFrdWRJ
         k29hFpJS6lDXBZzNHC37AZcxic6DdHtiOk1RQCPVX1zeeKrV6371RYSECg/PzF8oAO/8
         6pSnEsV5/3F2zmLn0eSjLp3L5Ed9A0mgkJ0kwPuye0QpWA6oh/mA7LZ0+wg4mPmhvab9
         eWfD+6w4jeQejRKfk9UEgNvOMqknkwYHz3mAhAIdD6s5k/xB5fNPl1LgGuL/Sw/sBTld
         gKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104720; x=1757709520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHCpdiwiI3ZIBuEZAHuwX3A3o77CaUiHFNIMRjlwvlA=;
        b=XoJENcUf9e5YnlcFCmmhUqON19JruhfJaXqibeaWw56/r1VGNAqRGX5vvOxSAu7Vt+
         Qqm/9TXGJiBDB9gMXRqlzDqLQZleCulBPWPm4N7Fruz16kQ2cMmBuTDAkilR+Xm3z68x
         w3Ibi4gc8L5HUjcpcInC2ckJgfi0IpTm8r5c1ijXTJklymod3lkJ0cvD70Q0Kp6HlepX
         wE72/2u8rk5ppXLHdBE8GedjPfCwoCsxuLLVBpFj4dvoBQuCreCp7DjWbCy9NDZiH1KT
         kawfWEcNOsFJHygzVQYZFXKKb3xNk7BdzR34BXTWZWi+3uTonrLUPIe94Z7Sc2Nqzcxv
         4syQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLf7fo065vDXtAM2Ron5ZNXv8xm84nLEh9mM3Kje3QDwMbY1pJffpqGLNNeJdl6j8sovP5OUPf@vger.kernel.org, AJvYcCW/aR6ONjuzw9f5LHuZk2WbT4sEuovXptlCsdeQ4JD5tHr4nqv7iWoIDcT8FuWbpxHI8whwww2PJB+3HP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xox2Hiueg6NzD9LiUERmZDhpQkCl0lwFQ+/OqOdUtm+7lrdW
	1tKH4YROXI7YhzkM3sANMWuGi46+iCK7ZJMVJz+NrEYL9oevkDQ78fg=
X-Gm-Gg: ASbGncvQD8DT2cW8/xKAnApIbx95kTcizWfJUIJlSEWg5xY7vWaJ6UMzXLD/NNZ2wMu
	osL8ny9m1F8NNbenVXhUHeWnBinzNL+fOt0hLkU1jfy5RZBI5qMkyK4/iuJFFoNtDBtEVc3k+GE
	5dWQLkdxwblskfYeV+gwookuuyULiFyAtp7LhGhwzIhSIuyYV3qJxjy1j2yiabcybrTbAF90YUz
	Ajv7PYMXJ8lS8YbvyC9MqvXashJ5HUmyfKwEqhHUhDcnrsDC3AG3Z5JjYmlwSfbzDmyYIWO87Fo
	oOu+4AfKAZCzrjgL3HEXH88JBQtqlGG+LNf1bJFUv6Tn/4jJtubX2Wff1RRY8jHCun1p823L2iV
	lfMjjNn3vmTvWhfAz/XQ1FrnibDUohzOQlC8FFnhIc5bf1v/H7Y8M/WzJ7RKc8O8X7pVhHKDrKn
	qoj44mZfn9aa8eq7iajjyBh+/rTfYyPs4hBOo7QD5hQoIPcHLJ65xgNr9Yx6rUIQy0PbJ0JxYPE
	aUL
X-Google-Smtp-Source: AGHT+IEpDdfB+E37xuwGKvC88xI2UsctswekN7dqAvcbt1gw4hTa7aftrP1EeJZ8thfDc1IOQMLoLA==
X-Received: by 2002:a17:902:fc8e:b0:23f:f96d:7579 with SMTP id d9443c01a7336-2517330a5e7mr99535ad.37.1757104719905;
        Fri, 05 Sep 2025 13:38:39 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24b905689d1sm95741175ad.64.2025.09.05.13.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:38:39 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:38:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Message-ID: <aLtKTwBmogXa48Rj@mini-arch>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
 <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
 <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com>
 <aLjaIwkpO64rJtui@devvm11784.nha0.facebook.com>
 <CAHS8izMe+u1pFzX5U_Mvifn3VNY2WGqi_uDvqWdG7RwPKW3z6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMe+u1pFzX5U_Mvifn3VNY2WGqi_uDvqWdG7RwPKW3z6A@mail.gmail.com>

On 09/05, Mina Almasry wrote:
> On Wed, Sep 3, 2025 at 5:15 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Wed, Sep 03, 2025 at 01:20:57PM -0700, Mina Almasry wrote:
> > > On Tue, Sep 2, 2025 at 2:36 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > >
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > Improve CPU performance of devmem token management by using page offsets
> > > > as dmabuf tokens and using them for direct array access lookups instead
> > > > of xarray lookups. Consequently, the xarray can be removed. The result
> > > > is an average 5% reduction in CPU cycles spent by devmem RX user
> > > > threads.
> > > >
> > >
> > > Great!
> > >
> >
> > Hey Mina, thanks for the feedback!
> >
> > > > This patch changes the meaning of tokens. Tokens previously referred to
> > > > unique fragments of pages. In this patch tokens instead represent
> > > > references to pages, not fragments.  Because of this, multiple tokens
> > > > may refer to the same page and so have identical value (e.g., two small
> > > > fragments may coexist on the same page). The token and offset pair that
> > > > the user receives uniquely identifies fragments if needed.  This assumes
> > > > that the user is not attempting to sort / uniq the token list using
> > > > tokens alone.
> > > >
> > > > A new restriction is added to the implementation: devmem RX sockets
> > > > cannot switch dmabuf bindings. In practice, this is a symptom of invalid
> > > > configuration as a flow would have to be steered to a different queue or
> > > > device where there is a different binding, which is generally bad for
> > > > TCP flows.
> > >
> > > Please do not assume configurations you don't use/care about are
> > > invalid. Currently reconfiguring flow steering while a flow is active
> > > works as intended today. This is a regression that needs to be
> > > resolved. But more importantly, looking at your code, I don't think
> > > this is a restriction you need to introduce?
> > >
> >
> > That's fair, let's see if we can lift it.
> >
> > > > This restriction is necessary because the 32-bit dmabuf token
> > > > does not have enough bits to represent both the pages in a large dmabuf
> > > > and also a binding or dmabuf ID. For example, a system with 8 NICs and
> > > > 32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
> > > > == 256 queues total == 2^8), which leaves only 24 bits for dmabuf pages
> > > > (2^24 * 4096 / (1<<30) == 64GB). This is insufficient for the device and
> > > > queue numbers on many current systems or systems that may need larger
> > > > GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
> > > > device).
> > > >
> > > > Using kperf[1] with 4 flows and workers, this patch improves receive
> > > > worker CPU util by ~4.9% with slightly better throughput.
> > > >
> > > > Before, mean cpu util for rx workers ~83.6%:
> > > >
> > > > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > > > Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00    0.00    0.00   17.41
> > > > Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00    0.00    0.00   16.67
> > > > Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00    0.00    0.00   16.54
> > > > Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00    0.00    0.00   14.86
> > > >
> > > > After, mean cpu util % for rx workers ~78.7%:
> > > >
> > > > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> > > > Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00    0.00    0.00   23.20
> > > > Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00    0.00    0.00   21.94
> > > > Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00    0.00    0.00   22.73
> > > > Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00    0.00    0.00   17.32
> > > >
> > >
> > > I think effectively all you're doing in this patch is removing xarray
> > > with a regular array, right? I'm surprised an xarray account for 5%
> > > cpu utilization. I wonder if you have debug configs turned on during
> > > these experiments. Can you perf trace what about the xarray is taking
> > > so long? I wonder if we're just using xarrays improperly (maybe
> > > hitting constant resizing slow paths or something), and a similar
> > > improvement can be gotten by adjusting the xarray flags or what not.
> > >
> >
> > That is right.
> >
> > Here is some perf data gathered from:
> >
> >         perf record -a -g -F 99 -C 0-7 -- sleep 5
> >
> > RX queues pinned to 0-3 and kperf server pinned to 4-7.
> >
> >     11.25%  server       [kernel.kallsyms]                                      [k] tcp_recvmsg
> >             |
> >              --10.98%--tcp_recvmsg
> >                        bpf_trampoline_6442594803
> >                        tcp_recvmsg
> >                        inet6_recvmsg
> >                        ____sys_recvmsg
> >                        ___sys_recvmsg
> >                        __x64_sys_recvmsg
> >                        do_syscall_64
> >                        entry_SYSCALL_64_after_hwframe
> >                        __libc_recvmsg
> >                        |
> >                         --2.74%--0x100000082
> >
> >      5.65%  server       [kernel.kallsyms]                                      [k] xas_store
> >             |
> >              --5.63%--xas_store
> >                        |
> >                        |--3.92%--__xa_erase
> >                        |          sock_devmem_dontneed
> >                        |          sk_setsockopt
> >                        |          __x64_sys_setsockopt
> >                        |          do_syscall_64
> >                        |          entry_SYSCALL_64_after_hwframe
> >                        |          __GI___setsockopt
> >                        |          0x4f00000001
> >                        |
> >                        |--0.94%--__xa_alloc
> >                        |          tcp_recvmsg
> >                        |          bpf_trampoline_6442594803
> >                        |          tcp_recvmsg
> >                        |          inet6_recvmsg
> >                        |          ____sys_recvmsg
> >                        |          ___sys_recvmsg
> >                        |          __x64_sys_recvmsg
> >                        |          do_syscall_64
> >                        |          entry_SYSCALL_64_after_hwframe
> >                        |          __libc_recvmsg
> >                        |
> >                         --0.76%--__xa_cmpxchg
> >                                   tcp_xa_pool_commit_locked
> >                                   tcp_xa_pool_commit
> >                                   tcp_recvmsg
> >                                   bpf_trampoline_6442594803
> >                                   tcp_recvmsg
> >                                   inet6_recvmsg
> >                                   ____sys_recvmsg
> >                                   ___sys_recvmsg
> >                                   __x64_sys_recvmsg
> >                                   do_syscall_64
> >                                   entry_SYSCALL_64_after_hwframe
> >                                   __libc_recvmsg
> >
> >
> >      [...]
> >
> >      1.22%  server       [kernel.kallsyms]                                      [k] xas_find_marked
> >             |
> >              --1.19%--xas_find_marked
> >                        __xa_alloc
> >                        tcp_recvmsg
> >                        bpf_trampoline_6442594803
> >                        tcp_recvmsg
> >                        inet6_recvmsg
> >                        ____sys_recvmsg
> >                        ___sys_recvmsg
> >                        __x64_sys_recvmsg
> >                        do_syscall_64
> >                        entry_SYSCALL_64_after_hwframe
> >                        __libc_recvmsg
> >
> 
> One thing that is a bit weird is that you're seeing 5.67% + 1.19%
> overall overhead for xarrays, but when you do the hacky
> just-give-userspace-the-pointer experiment you see a full 10%
> reduction. But that's beside the point.
> 
> >
> > Here is the output from zcat /proc/config.gz | grep DEBUG | grep =y, I'm
> > not 100% sure which may be worth toggling. I'm happy to rerun the
> > experiments if any of these are suspicious looking:
> >
> > CONFIG_X86_DEBUGCTLMSR=y
> > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > CONFIG_BLK_DEBUG_FS=y
> > CONFIG_BFQ_CGROUP_DEBUG=y
> > CONFIG_CMA_DEBUGFS=y
> > CONFIG_FW_LOADER_DEBUG=y
> > CONFIG_PNP_DEBUG_MESSAGES=y
> > CONFIG_SCSI_LPFC_DEBUG_FS=y
> > CONFIG_MLX4_DEBUG=y
> > CONFIG_INFINIBAND_MTHCA_DEBUG=y
> > CONFIG_NFS_DEBUG=y
> > CONFIG_SUNRPC_DEBUG=y
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_DYNAMIC_DEBUG_CORE=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_DWARF4=y
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> > CONFIG_DEBUG_INFO_BTF=y
> > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > CONFIG_DEBUG_FS=y
> > CONFIG_DEBUG_FS_ALLOW_ALL=y
> > CONFIG_SLUB_DEBUG=y
> > CONFIG_DEBUG_PAGE_REF=y
> > CONFIG_ARCH_HAS_DEBUG_WX=y
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_SCHED_DEBUG=y
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > CONFIG_CSD_LOCK_WAIT_DEBUG=y
> > CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y
> > CONFIG_DEBUG_CGROUP_REF=y
> > CONFIG_FAULT_INJECTION_DEBUG_FS=y
> >
> >
> 
> Thanks for the detailed data here. Nothing overly wrong jumps at me.
> 
> Cc Matthew Wilcox here. Maybe he can spot something obviously wrong
> with how we're using xarrays that can be optimized.
> 
> > For more context, I did a few other experiments before eventually
> > landing on this patch:
> >
> > 1) hacky approach - don't do any token management at all, replace dmabuf
> >    token with 64-bit pointer to niov, teach recvmsg() /
> >    sock_devmem_dontneed() to inc/dec the niov reference directly... this
> >    actually reduced the CPU util by a very consistent 10%+ per worker
> >    (the largest delta of all my experiements).
> >
> > 2) keep xarray, but use RCU/lockless lookups in both recvmsg/dontneed.
> >    Use page indices + xa_insert instead of xa_alloc. Acquire lock only if
> >    lockless lookup returns null in recvmsg path. Don't erase in dontneed,
> >    only take rcu_read_lock() and do lookup. Let xarray grow according to
> >    usage and cleanup when the socket is destroyed. Surprisingly, this
> >    didn't offer noticeable improvement.
> >
> > 3) use normal array but no atomics -- incorrect, but saw good improvement,
> >    despite possibility of leaked references.
> >
> > 4) use a hashmap + bucket locks instead of xarray --  performed way
> >    worse than xarray, no change to token
> >
> > > > Mean throughput improves, but falls within a standard deviation (~45GB/s
> > > > for 4 flows on a 50GB/s NIC, one hop).
> > > >
> > > > This patch adds an array of atomics for counting the tokens returned to
> > > > the user for a given page. There is a 4-byte atomic per page in the
> > > > dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.
> > > >
> > > > [1]: https://github.com/facebookexperimental/kperf
> > > >
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > ---
> > > >  include/net/sock.h       |   5 ++-
> > > >  net/core/devmem.c        |  17 ++++----
> > > >  net/core/devmem.h        |   2 +-
> > > >  net/core/sock.c          |  24 +++++++----
> > > >  net/ipv4/tcp.c           | 107 +++++++++++++++--------------------------------
> > > >  net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
> > > >  net/ipv4/tcp_minisocks.c |   2 -
> > > >  7 files changed, 99 insertions(+), 98 deletions(-)
> > > >
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 1e7f124871d2..70c97880229d 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -573,7 +573,10 @@ struct sock {
> > > >  #endif
> > > >         struct rcu_head         sk_rcu;
> > > >         netns_tracker           ns_tracker;
> > > > -       struct xarray           sk_user_frags;
> > > > +       struct {
> > > > +               struct net_devmem_dmabuf_binding        *binding;
> > > > +               atomic_t                                *urefs;
> > > > +       } sk_user_frags;
> > > >
> > >
> > > AFAIU, if you made sk_user_frags an array of (unref, binding) tuples
> > > instead of just an array of urefs then you can remove the
> > > single-binding restriction.
> > >
> > > Although, I wonder what happens if the socket receives the netmem at
> > > the same index on 2 different dmabufs. At that point I assume the
> > > wrong uref gets incremented? :(
> > >
> >
> > Right. We need some bits to differentiate bindings. Here are some ideas
> > I've had about this, I wonder what your thoughts are on them:
> >
> > 1) Encode a subset of bindings and wait for availability if the encoding
> > space becomes exhausted. For example, we could encode the binding in 5
> > bits for outstanding references across 32 bindings and 27 bits (512 GB)
> > of dmabuf. If recvmsg wants to return a reference to a 33rd binding, it
> > waits until the user returns enough tokens to release one of the binding
> > encoding bits (at which point it could be reused for the new reference).
> >
> 
> This, I think, sounds reasonable. supporting up to 2^5 rx dmabuf
> bindings at once and 2^27 max dmabuf size should be fine for us I
> think. Although you have to be patient with me, I have to make sure
> via tests and code inspection that these new limits will be OK. Also
> please understand the risk that even if the changes don't break us,
> they may break someone and have to be reverted anyway, although I
> think the risk is small.
> 
> Another suggestion I got from the team is to use a bitmap instead of
> an array of atomics. I initially thought this could work, but thinking
> about it more, I think that would not work, no? Because it's not 100%
> guaranteed that the socket will only get 1 ref on a net_iov. In the
> case where the driver fragments the net_iov, multiple difference frags
> could point to the same net_iov which means multiple refs. So it seems
> we're stuck with an array of atomic_t.
> 
> > 2) opt into an extended token (dmabuf_token_v2) via sockopts, and add
> > the binding ID or other needed information there.
> >
> 
> Eh, I would say this is an overkill? Today the limit of dma-bufs
> supported is 2^27 and I think the dmabuf size is technically 2^32 or
> something, but I don't know that we need all this flexibility for
> devmem tcp. I think adding a breakdown like above may be fine.
> 
> > > One way or another the single-binding restriction needs to be removed
> > > I think. It's regressing a UAPI that currently works.
> > >
> 
> Thinking about this more, if we can't figure out a different way and
> have to have a strict 1 socket to 1 dma-buf mapping, that may be
> acceptable...
> 
> ...the best way to do it is actually to do this, I think, would be to
> actually make sure the user can't break the mapping via `ethtool -N`.
> I.e. when the user tells us to update or delete a flow steering rule
> that belongs to a devmem socket, reject the request altogether. At
> that point we could we can be sure that the mapping would not change
> anyway. Although I don't know how feasible to implement this is.
> 
> AFAICT as well AF_XDP is in a similar boat to devmem in this regard.
> The AF_XDP docs require flow steering to be configured for the data to
> be available in the umem (and I assume, if flow steering is
> reconfigured then the data disappears from the umem?). Stan do you
> know how this works? If AF_XDP allows the user to break it by
> reconfiguring flow steering it may also be reasonable to allow the
> user to break a devmem socket as well (although maybe with
> clarification in the docs.

For af_xdp, there is a check in xsk_rcv_check (that runs _after_ bpf
program that does the redirect exits) and it drops the packet if
the packet is redirected to the unxpected queue (not the one that
the socket was bound to). And the only way to observe it after the fact
is a drop counter on the nic (or, rather, depends on the nic wrt how it
accounts it). I remember Willem wanted to remove that restriction,
but looks like he never got to it?

tl;dr we don't error out explicitly when the user misconfigures the steering
after the fact (or initially) and drop the packet in the data path.

