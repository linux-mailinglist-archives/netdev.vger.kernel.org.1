Return-Path: <netdev+bounces-238009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9CC52ACB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698D44FD68B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02462820A9;
	Wed, 12 Nov 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNreza0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CFD2797AC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956498; cv=none; b=uc5VkvA+PQJiZPKuW6NgVUeEzgD+T6R5LMsOLq3zbHhDTv432vEnQl6Sxyhv/GhpguOobiZ9AnkqaicjPOgdk6I9weWQlL8IABnAwYQu1xm2xG3lagLaSQCNbR1lNvsNsIFFn/3cB9bK42YjkT9Nrjt50ZgT9rQsXN9mk1BmWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956498; c=relaxed/simple;
	bh=g2YlzHJGj084sc9sXlIRUmNldHbk06Gc/gLx23ejMkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKxhcU9sjD9TWPJ3nEmIi3QVn0J0Qnc6GKWPOW3YwlwO5XGXV083RLANjvXEgxnzLl31xPTa8rIMQqPNDN7VPVhRCCLv/+/rMB2Z3oGnCgoo7oygsNv3wLJUkE675yw4GFndS7bJbjt4O12RVCDPED5KLxhPTuST8QSMOy/pRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNreza0x; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e89de04d62so7125661cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762956496; x=1763561296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG5kkoChahqCjDZgn1sh/A2ZgGCb1MRj2TG2c+j1Y2k=;
        b=cNreza0xF5xMbi2vomgbWFr9NaKvbiLK9N11vFQfko4OxLx1WT4M2jRVn8wMEQtsjI
         bvWcwfhx7elx7Ad0AkOqxGq6Qu78E1mwHh6CpoXIHV/IfCgXmysGA6d1Js5mJ7LDTUy5
         LYoca/ZgLipXNWUAkdy1HLjLcGN5wa6fHBtNp3Rt0CChhPFtKENJkc/wtr2nNi1GFb1+
         LVITjUYasJYh+J726Sz6syaswBlfdrMki3fIDpRmQzCOQfXlbURlE/HFgsfWQnkrT403
         LzDglHqS2gGDzPk99gXl6qTwoaaonccbyfol+tUNMgK/7iX9gLhi8iXhyyAMXWIGiU1a
         r2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956496; x=1763561296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jG5kkoChahqCjDZgn1sh/A2ZgGCb1MRj2TG2c+j1Y2k=;
        b=qyonpfaInqZnMTWDZXf1edOIBYrnJH5tt3rGKi4PHvyb9DB/XDxgLZ1gIQrk0huEjP
         q8P8V5gg519FiImpF5fwTIqqotlWIGvaFDUPkZUXbzrQEzIq2tpk+WUTKEaR8XMNzetV
         vYQXfwcMbq8TemjXHvps7CJVSrhkBWqsKlMiYME5rOT/H3JTUc6/HwgMJ8CKvJ1PO2B1
         uRHVjLBwi7Yl7hFLm9VpWiSMvE5FvbvjCOtw0FzCu0BE0qzFPuL3D77dGDQi4b4ZU/5y
         9azw0MwnHSxA5NEfrkTqioulObZqL3ZUYr5cDAjir6KNfYxTIFU3B7G3kz6IczDEDBrn
         oh0w==
X-Forwarded-Encrypted: i=1; AJvYcCXyT6m2UBeSMQBd4PykD3HogE/IbANJDWJ6hkVTLYycIEMQA64mAEqs2EITeBfMJ7QnlcBnwiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywym74u0ceIfSbBfZbBT8amgzkw2g0FJPTOIc+YE5esOL7hDFOW
	xd4cLSZcPMlBngTj+3c8iLNLr8EHtTxB/7E6slCDPRdzOohEz/Q59wJpODJW+cczgp66hSkrxFg
	OElAvhCg1V32S5HONKY2jVRI3j+meHNdKlSZF6LGZ
X-Gm-Gg: ASbGnctwjlUQAYDjkCyhKXu3l9a8gLD6Py2w63M8BOwE3657C86d1Dn5NYIH+C2anf7
	AOMMKEH9cth5pm4stlmF+WxdtbF+nRuWW42Ost9Dz1SmTYxcVmE7q/ZRDJxX3dEFP7F+5bxRSw9
	BZoCDKWDmnCrkkruRZ4abY66dnlLbN0W4J/YedRAtA0QipklT7hGkJ08NxunfaMTtLMxgDV9lnD
	GYVNfjUycvr67/tQKugH2304UmFgC+9ezyBc1YxuGp/xUhWsC79ZSb/3iq6pdxsYo9RpzUI
X-Google-Smtp-Source: AGHT+IEKOKt0dsSPLoRm4ZjfhAuRZMnh5XHA0GLYp72UxSrSPRL5X/a3564LDoqStTbKgvYQTDufMyx7TMvK3KAKq/Y=
X-Received: by 2002:ac8:5e50:0:b0:4ed:b03c:7701 with SMTP id
 d75a77b69052e-4eddbdc3572mr37291131cf.69.1762956495146; Wed, 12 Nov 2025
 06:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <7460a188-3a74-4336-ae03-c88e21ffc1ca@nvidia.com>
In-Reply-To: <7460a188-3a74-4336-ae03-c88e21ffc1ca@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 06:08:04 -0800
X-Gm-Features: AWmQ_bnvazaykNvLNvtfSDFMux064qsf8aAFWNqISxTc25hPeCf2GdV9rip_Tqw
Message-ID: <CANn89iJBgaoVuQL7jgKwRJd8drpXYTLdGrJUpP9KVrzsPGK_Zw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:03=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Eric,
>
> On 06/11/2025 20:29, Eric Dumazet wrote:
> > There is a lack of NUMA awareness and more generally lack
> > of slab caches affinity on TX completion path.
> >
> > Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
> > in per-cpu caches so that they can be recycled in RX path.
> >
> > Only use this if the skb was allocated on the same cpu,
> > otherwise use skb_attempt_defer_free() so that the skb
> > is freed on the original cpu.
> >
> > This removes contention on SLUB spinlocks and data structures.
> >
> > After this patch, I get ~50% improvement for an UDP tx workload
> > on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).
> >
> > 80 Mpps -> 120 Mpps.
> >
> > Profiling one of the 32 cpus servicing NIC interrupts :
> >
> > Before:
> >
> > mpstat -P 511 1 1
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %stea=
l  %guest  %gnice   %idle
> > Average:     511    0.00    0.00    0.00    0.00    0.00   98.00    0.0=
0    0.00    0.00    2.00
> >
> >      31.01%  ksoftirqd/511    [kernel.kallsyms]  [k] queued_spin_lock_s=
lowpath
> >      12.45%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_s=
lowpath
> >       5.60%  ksoftirqd/511    [kernel.kallsyms]  [k] __slab_free
> >       3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_=
ring
> >       3.27%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_all
> >       2.95%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_sta=
rt
> >       2.52%  ksoftirqd/511    [kernel.kallsyms]  [k] fq_dequeue
> >       2.32%  ksoftirqd/511    [kernel.kallsyms]  [k] read_tsc
> >       2.25%  ksoftirqd/511    [kernel.kallsyms]  [k] build_detached_fre=
elist
> >       2.15%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free
> >       2.11%  swapper          [kernel.kallsyms]  [k] __slab_free
> >       2.06%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_features_chec=
k
> >       2.01%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_hdr
> >       1.97%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_data
> >       1.52%  ksoftirqd/511    [kernel.kallsyms]  [k] sock_wfree
> >       1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_=
ring
> >       1.23%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_all
> >       1.15%  ksoftirqd/511    [kernel.kallsyms]  [k] dma_unmap_page_att=
rs
> >       1.11%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_sta=
rt
> >       1.03%  swapper          [kernel.kallsyms]  [k] fq_dequeue
> >       0.94%  swapper          [kernel.kallsyms]  [k] kmem_cache_free
> >       0.93%  swapper          [kernel.kallsyms]  [k] read_tsc
> >       0.81%  ksoftirqd/511    [kernel.kallsyms]  [k] napi_consume_skb
> >       0.79%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_hdr
> >       0.77%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_free_head
> >       0.76%  swapper          [kernel.kallsyms]  [k] idpf_features_chec=
k
> >       0.72%  swapper          [kernel.kallsyms]  [k] skb_release_data
> >       0.69%  swapper          [kernel.kallsyms]  [k] build_detached_fre=
elist
> >       0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_s=
tate
> >       0.56%  ksoftirqd/511    [kernel.kallsyms]  [k] __put_partials
> >       0.55%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free_bu=
lk
> >       0.48%  swapper          [kernel.kallsyms]  [k] sock_wfree
> >
> > After:
> >
> > mpstat -P 511 1 1
> >
> > Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %stea=
l  %guest  %gnice   %idle
> > Average:     511    0.00    0.00    0.00    0.00    0.00   51.49    0.0=
0    0.00    0.00   48.51
> >
> >      19.10%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_hdr
> >      13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_=
ring
> >      10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_=
free
> >      10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_cle=
an_all
> >       7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_s=
lowpath
> >       6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
> >       5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_att=
rs
> >       3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
> >       3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_s=
tate
> >       2.73%  swapper          [kernel.kallsyms]  [k] read_tsc
> >       2.48%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_sta=
rt
> >       1.20%  swapper          [kernel.kallsyms]  [k] idpf_features_chec=
k
> >       1.13%  swapper          [kernel.kallsyms]  [k] napi_consume_skb
> >       0.93%  swapper          [kernel.kallsyms]  [k] idpf_vport_splitq_=
napi_poll
> >       0.64%  swapper          [kernel.kallsyms]  [k] native_send_call_f=
unc_single_ipi
> >       0.60%  swapper          [kernel.kallsyms]  [k] acpi_processor_ffh=
_cstate_enter
> >       0.53%  swapper          [kernel.kallsyms]  [k] io_idle
> >       0.43%  swapper          [kernel.kallsyms]  [k] netif_skb_features
> >       0.41%  swapper          [kernel.kallsyms]  [k] __direct_call_cpui=
dle_state_enter2
> >       0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_=
iret
> >       0.40%  swapper          [kernel.kallsyms]  [k] idpf_tx_buf_hw_upd=
ate
> >       0.36%  swapper          [kernel.kallsyms]  [k] sched_clock_noinst=
r
> >       0.34%  swapper          [kernel.kallsyms]  [k] handle_softirqs
> >       0.32%  swapper          [kernel.kallsyms]  [k] net_rx_action
> >       0.32%  swapper          [kernel.kallsyms]  [k] dql_completed
> >       0.32%  swapper          [kernel.kallsyms]  [k] validate_xmit_skb
> >       0.31%  swapper          [kernel.kallsyms]  [k] skb_network_protoc=
ol
> >       0.29%  swapper          [kernel.kallsyms]  [k] skb_csum_hwoffload=
_help
> >       0.29%  swapper          [kernel.kallsyms]  [k] x2apic_send_IPI
> >       0.28%  swapper          [kernel.kallsyms]  [k] ktime_get
> >       0.24%  swapper          [kernel.kallsyms]  [k] __qdisc_run
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   net/core/skbuff.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index eeddb9e737ff28e47c77739db7b25ea68e5aa735..7ac5f8aa1235a55db02b40b=
5a0f51bb3fa53fa03 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1476,6 +1476,11 @@ void napi_consume_skb(struct sk_buff *skb, int b=
udget)
> >
> >       DEBUG_NET_WARN_ON_ONCE(!in_softirq());
> >
> > +     if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
> > +             skb_release_head_state(skb);
> > +             return skb_attempt_defer_free(skb);
> > +     }
> > +
> >       if (!skb_unref(skb))
> >               return;
> >
>
> I have noticed a suspend regression on one of our Tegra boards. Bisect
> is pointing to this commit and reverting this on top of -next fixes the
> issue.
>
> Out of all the Tegra boards we test only one is failing and that is the
> tegra124-jetson-tk1. This board uses the realtek r8169 driver ...
>
>   r8169 0000:01:00.0: enabling device (0140 -> 0143)
>   r8169 0000:01:00.0 eth0: RTL8168g/8111g, 00:04:4b:25:b2:0e, XID 4c0, IR=
Q 132
>   r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksu=
mming: ko]
>
> I don't see any particular crash or error, and even after resuming from
> suspend the link does come up ...
>
>   r8169 0000:01:00.0 enp1s0: Link is Down
>   tegra-xusb 70090000.usb: Firmware timestamp: 2014-09-16 02:10:07 UTC
>   OOM killer enabled.
>   Restarting tasks: Starting
>   Restarting tasks: Done
>   random: crng reseeded on system resumption
>   PM: suspend exit
>   ata1: SATA link down (SStatus 0 SControl 300)
>   r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full - flow control rx/tx
>
> However, the board does not seem to resume fully. One thing I should
> point out is that for testing we always use an NFS rootfs. So this
> would indicate that the link comes up but networking is still having
> issues.
>
> Any thoughts?
>
> Jon

Perhaps try : https://patchwork.kernel.org/project/netdevbpf/patch/20251111=
151235.1903659-1-edumazet@google.com/

Thanks !

