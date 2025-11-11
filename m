Return-Path: <netdev+bounces-237710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC3C4F37F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00E8C4E3952
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC036B05F;
	Tue, 11 Nov 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WpzHqZW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF12550BA
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881444; cv=none; b=nad3XMfXW7SzGgSEhpd3xwm1SCq0CZ+/hEbdW7D+cGpoBmFbEn1XRjEITyXMlVSEauPmexDLss+Ufu7+a1xtqGX1qBktk443GG84yAuFbdDc3PQi0jTBZQiaViIMB9TM/t55YmWB2KhV+tGluSfUPlXV+cGUcCn9Ag19TcqaTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881444; c=relaxed/simple;
	bh=Tp7K1bfGFKXzkjdrwkUbSlYYxvOlRGgnG98PdWwD+DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYp/wEoPBS/xZF8ZFT6MkyHffCRXJvN1aRbox2CuBQp5guH4g/96WnU+tEcuLwdfyNw2qqxXnaOt1ZTMkdKY4rNXZLmysC70ILEpZU+kAikgNmuBQ6ss5ZdbeHm3GhDmZMQUPjxNUBnUuZheJg1w2UuepRQJ+w6jr0armdgRyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WpzHqZW3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed861eb98cso49773751cf.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762881441; x=1763486241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJhHvaa+TisF29pcpuUgPVi8cY/WYVBFbAl9NhNVO84=;
        b=WpzHqZW35dml2l+/71s8MFsf/aqlphAP5MFQSm/VOWfj5tOUTaNzOa0gPP9YDzRAne
         H2NinXyq7zm4Ul2PVOuOl2hfXbmNeu+vpWCCTYGpgwUjfaPmfN0pdw0f+9x8y8yM2CFe
         9Nkaf+9gzuznXE3cn+XjtOMAWKcjT4nHvRncSGmt1KG6axhS440ckm7UFAQmA3tu6Wr9
         1QHgwhw7VQCNNOSvrI5qshzVvGWMydKKDHECtLV+LguLyQB9Gy0u4TwHlKsuI7PIpd3c
         X4iBFVEjQ/F2LYEsB04pDz8f+GSKJJrGl5fXbrCZfOuF8SpQXV88Ba+kjC7ErYPVCdg4
         rigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881441; x=1763486241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJhHvaa+TisF29pcpuUgPVi8cY/WYVBFbAl9NhNVO84=;
        b=f0wzdISeFVbUkwys3+VRS5TbE8bt1CdyUMfpDxDCSJvx5uB2R417M6w+7AJ7/tOQAk
         8Xiyke8jtl6B8wgXmjj9VhK9WcEuwyTFQiafT8Tr7ggFTnpPf2S0NIERAkTOUHnuD22e
         iebV4P1iAu2z26EOKvv62Y26JqZhSfH5Quciru/F2ijGD2inyYRUs+bz9BWF3bmwVgM9
         3Rhuu3C6+mGEBGictGRIuwNl7qtO3eCqMjpubA9hV+umPjXWDYx4hqQlH568NnC7tYc+
         ZuF2E+G6/e2T3iIp3cuN3mH3T9PsfeyNTzaTiWYkyDmN7aJnEVWTnlXixdPbcvzYF3UY
         Aerw==
X-Forwarded-Encrypted: i=1; AJvYcCXt4FDXmeiKlU7JmXPBJXtk8SGyijDVHCMrAjIiUMAvapMvrwSviY/vbw+SJSltRBMZs0zwDZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWI0cjnX4Wy/LlQtyoiKPi5cJodN833dZvQCEBCEajzn9WEwF
	e9etxTVC7tK1IJDmxycrS63UhyzUIzuS/nvot5CnpzTfL5pDf2r93tbJiQ4rs1dHbezETFd+Vln
	LDE79xs0oMimd2vQI23LvWbuq0KsrFvWM3oEq4ud1
X-Gm-Gg: ASbGncsbutD3Ym7mSP/aturprrauOzlPTAMluKp4dWmSiBqHdArnHdg+zth4YQJ3g2d
	h+JvUvANvsG8UZZqTLfshN66FUT79NtCzVuQJvBKzwBCbnW07kpGoQOPyz5PvrJMQVj75son8Uv
	Vyt2Hc7mfNA9O775iUYXQEtRGhBXfoxCUXK9EHAfBNXrZR1qWPLPukn8DEfM9FYZYip7EI3w6DL
	KTtdFoQ7gloVl0wLMafSW0IxsiygfLOv08fuxyKwIqnhIZsoUEFbXwLtVeXi499FThf9IU=
X-Google-Smtp-Source: AGHT+IHd/dseQ2GDMNXd8WyNpjDBtJeacyh0ET/SeQ1XejJ1sOZ9VZu+7UYMrP+vWrp1Y2nmJl6U6Hij9mgvUHh9Nug=
X-Received: by 2002:a05:622a:134b:b0:4ed:706e:bcb7 with SMTP id
 d75a77b69052e-4eda4ec71e5mr157946931cf.24.1762881440992; Tue, 11 Nov 2025
 09:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
 <20251111165622.GA30112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251111165622.GA30112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Nov 2025 09:17:10 -0800
X-Gm-Features: AWmQ_bkSYU0nL-3nvzh_axyHHn520bnRmVwgpcR3DwL9XU1bp4t7VR1HJe4doXc
Message-ID: <CANn89i+e2XDw4b_iHaj_LPTeg6M2+-+vroECks21Fs7Hfg2Aow@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, ssengar@linux.microsoft.com, gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 8:56=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On Thu, Nov 06, 2025 at 08:29:34PM +0000, Eric Dumazet wrote:
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
> >     31.01%  ksoftirqd/511    [kernel.kallsyms]  [k] queued_spin_lock_sl=
owpath
> >     12.45%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_sl=
owpath
> >      5.60%  ksoftirqd/511    [kernel.kallsyms]  [k] __slab_free
> >      3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_r=
ing
> >      3.27%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_all
> >      2.95%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_star=
t
> >      2.52%  ksoftirqd/511    [kernel.kallsyms]  [k] fq_dequeue
> >      2.32%  ksoftirqd/511    [kernel.kallsyms]  [k] read_tsc
> >      2.25%  ksoftirqd/511    [kernel.kallsyms]  [k] build_detached_free=
list
> >      2.15%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free
> >      2.11%  swapper          [kernel.kallsyms]  [k] __slab_free
> >      2.06%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_features_check
> >      2.01%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_hdr
> >      1.97%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_data
> >      1.52%  ksoftirqd/511    [kernel.kallsyms]  [k] sock_wfree
> >      1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_r=
ing
> >      1.23%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_all
> >      1.15%  ksoftirqd/511    [kernel.kallsyms]  [k] dma_unmap_page_attr=
s
> >      1.11%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_star=
t
> >      1.03%  swapper          [kernel.kallsyms]  [k] fq_dequeue
> >      0.94%  swapper          [kernel.kallsyms]  [k] kmem_cache_free
> >      0.93%  swapper          [kernel.kallsyms]  [k] read_tsc
> >      0.81%  ksoftirqd/511    [kernel.kallsyms]  [k] napi_consume_skb
> >      0.79%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_hdr
> >      0.77%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_free_head
> >      0.76%  swapper          [kernel.kallsyms]  [k] idpf_features_check
> >      0.72%  swapper          [kernel.kallsyms]  [k] skb_release_data
> >      0.69%  swapper          [kernel.kallsyms]  [k] build_detached_free=
list
> >      0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_st=
ate
> >      0.56%  ksoftirqd/511    [kernel.kallsyms]  [k] __put_partials
> >      0.55%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free_bul=
k
> >      0.48%  swapper          [kernel.kallsyms]  [k] sock_wfree
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
> >     19.10%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_hdr
> >     13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_r=
ing
> >     10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_f=
ree
> >     10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clea=
n_all
> >      7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_sl=
owpath
> >      6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
> >      5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_attr=
s
> >      3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
> >      3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_st=
ate
> >      2.73%  swapper          [kernel.kallsyms]  [k] read_tsc
> >      2.48%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_star=
t
> >      1.20%  swapper          [kernel.kallsyms]  [k] idpf_features_check
> >      1.13%  swapper          [kernel.kallsyms]  [k] napi_consume_skb
> >      0.93%  swapper          [kernel.kallsyms]  [k] idpf_vport_splitq_n=
api_poll
> >      0.64%  swapper          [kernel.kallsyms]  [k] native_send_call_fu=
nc_single_ipi
> >      0.60%  swapper          [kernel.kallsyms]  [k] acpi_processor_ffh_=
cstate_enter
> >      0.53%  swapper          [kernel.kallsyms]  [k] io_idle
> >      0.43%  swapper          [kernel.kallsyms]  [k] netif_skb_features
> >      0.41%  swapper          [kernel.kallsyms]  [k] __direct_call_cpuid=
le_state_enter2
> >      0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_i=
ret
> >      0.40%  swapper          [kernel.kallsyms]  [k] idpf_tx_buf_hw_upda=
te
> >      0.36%  swapper          [kernel.kallsyms]  [k] sched_clock_noinstr
> >      0.34%  swapper          [kernel.kallsyms]  [k] handle_softirqs
> >      0.32%  swapper          [kernel.kallsyms]  [k] net_rx_action
> >      0.32%  swapper          [kernel.kallsyms]  [k] dql_completed
> >      0.32%  swapper          [kernel.kallsyms]  [k] validate_xmit_skb
> >      0.31%  swapper          [kernel.kallsyms]  [k] skb_network_protoco=
l
> >      0.29%  swapper          [kernel.kallsyms]  [k] skb_csum_hwoffload_=
help
> >      0.29%  swapper          [kernel.kallsyms]  [k] x2apic_send_IPI
> >      0.28%  swapper          [kernel.kallsyms]  [k] ktime_get
> >      0.24%  swapper          [kernel.kallsyms]  [k] __qdisc_run
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/skbuff.c | 5 +++++
> >  1 file changed, 5 insertions(+)
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
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
>
> I ran these tests on latest net-next for MANA driver and I am observing a=
 regression here.
>
> lisatest@lisa--747-e0-n0:~$ iperf3 -c 10.0.0.4 -t 30 -l 1048576
> Connecting to host 10.0.0.4, port 5201
> [  5] local 10.0.0.5 port 48692 connected to 10.0.0.4 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  4.57 GBytes  39.2 Gbits/sec  586   1.04 MBytes
> [  5]   1.00-2.00   sec  4.74 GBytes  40.7 Gbits/sec  520   1.13 MBytes
> [  5]   2.00-3.00   sec  5.16 GBytes  44.3 Gbits/sec  191   1.20 MBytes
> [  5]   3.00-4.00   sec  5.13 GBytes  44.1 Gbits/sec  520   1.11 MBytes
> [  5]   4.00-5.00   sec   678 MBytes  5.69 Gbits/sec   93   1.37 KBytes
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  10.00-11.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  11.00-12.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  12.00-13.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  13.00-14.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  14.00-15.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  15.00-16.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  16.00-17.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  17.00-18.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  18.00-19.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  19.00-20.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  20.00-21.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  21.00-22.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  22.00-23.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  23.00-24.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  24.00-25.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  25.00-26.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  26.00-27.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  27.00-28.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  28.00-29.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> [  5]  29.00-30.00  sec  0.00 Bytes  0.00 bits/sec    0   1.37 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-30.00  sec  20.3 GBytes  5.80 Gbits/sec  1910             se=
nder
> [  5]   0.00-30.00  sec  20.3 GBytes  5.80 Gbits/sec                  rec=
eiver
>
> iperf Done.
>
>
> I tested again by reverting this patch and regression was not there.
>
> lisatest@lisa--747-e0-n0:~/net-next$ iperf3 -c 10.0.0.4 -t 30 -l 1048576
> Connecting to host 10.0.0.4, port 5201
> [  5] local 10.0.0.5 port 58188 connected to 10.0.0.4 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  4.95 GBytes  42.5 Gbits/sec  541   1.10 MBytes
> [  5]   1.00-2.00   sec  4.92 GBytes  42.3 Gbits/sec  599    878 KBytes
> [  5]   2.00-3.00   sec  4.51 GBytes  38.7 Gbits/sec  438    803 KBytes
> [  5]   3.00-4.00   sec  4.69 GBytes  40.3 Gbits/sec  647   1.17 MBytes
> [  5]   4.00-5.00   sec  4.18 GBytes  35.9 Gbits/sec  1183    715 KBytes
> [  5]   5.00-6.00   sec  5.05 GBytes  43.4 Gbits/sec  484    975 KBytes
> [  5]   6.00-7.00   sec  5.32 GBytes  45.7 Gbits/sec  520    836 KBytes
> [  5]   7.00-8.00   sec  5.29 GBytes  45.5 Gbits/sec  436   1.10 MBytes
> [  5]   8.00-9.00   sec  5.27 GBytes  45.2 Gbits/sec  464   1.30 MBytes
> [  5]   9.00-10.00  sec  5.25 GBytes  45.1 Gbits/sec  425   1.13 MBytes
> [  5]  10.00-11.00  sec  5.29 GBytes  45.4 Gbits/sec  268   1.19 MBytes
> [  5]  11.00-12.00  sec  4.98 GBytes  42.8 Gbits/sec  711    793 KBytes
> [  5]  12.00-13.00  sec  3.80 GBytes  32.6 Gbits/sec  1255    801 KBytes
> [  5]  13.00-14.00  sec  3.80 GBytes  32.7 Gbits/sec  1130    642 KBytes
> [  5]  14.00-15.00  sec  4.31 GBytes  37.0 Gbits/sec  1024   1.11 MBytes
> [  5]  15.00-16.00  sec  5.18 GBytes  44.5 Gbits/sec  359   1.25 MBytes
> [  5]  16.00-17.00  sec  5.23 GBytes  44.9 Gbits/sec  265    900 KBytes
> [  5]  17.00-18.00  sec  4.70 GBytes  40.4 Gbits/sec  769    715 KBytes
> [  5]  18.00-19.00  sec  3.77 GBytes  32.4 Gbits/sec  1841    889 KBytes
> [  5]  19.00-20.00  sec  3.77 GBytes  32.4 Gbits/sec  1084    827 KBytes
> [  5]  20.00-21.00  sec  5.01 GBytes  43.0 Gbits/sec  558    994 KBytes
> [  5]  21.00-22.00  sec  5.27 GBytes  45.3 Gbits/sec  450   1.25 MBytes
> [  5]  22.00-23.00  sec  5.25 GBytes  45.1 Gbits/sec  338   1.18 MBytes
> [  5]  23.00-24.00  sec  5.29 GBytes  45.4 Gbits/sec  200   1.14 MBytes
> [  5]  24.00-25.00  sec  5.29 GBytes  45.5 Gbits/sec  518   1.02 MBytes
> [  5]  25.00-26.00  sec  4.28 GBytes  36.7 Gbits/sec  1258    792 KBytes
> [  5]  26.00-27.00  sec  3.87 GBytes  33.2 Gbits/sec  1365    799 KBytes
> [  5]  27.00-28.00  sec  4.77 GBytes  41.0 Gbits/sec  530   1.09 MBytes
> [  5]  28.00-29.00  sec  5.31 GBytes  45.6 Gbits/sec  419   1.06 MBytes
> [  5]  29.00-30.00  sec  5.32 GBytes  45.7 Gbits/sec  222   1.10 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-30.00  sec   144 GBytes  41.2 Gbits/sec  20301             s=
ender
> [  5]   0.00-30.00  sec   144 GBytes  41.2 Gbits/sec                  rec=
eiver
>
> iperf Done.
>
>
> I am still figuring out technicalities of this patch, but wanted to share=
 initial findings for your input. Please let me know your thoughts on this!

Perhaps try : https://patchwork.kernel.org/project/netdevbpf/patch/20251111=
151235.1903659-1-edumazet@google.com/

Thanks !

