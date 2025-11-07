Return-Path: <netdev+bounces-236662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184FC3EA56
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 07:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443AB4E2CEF
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7172303A23;
	Fri,  7 Nov 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ph/GZw3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A212F1FDA
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498031; cv=none; b=b6xQixUCRkD1rCYJxw/YeKWU7fk3SLpf6Bg6vqACP2rvDNFZAjfsSf/njvmMK9OvXleL8qjqcO7LCXE6TU6WqMgkTpe6MsbhhNMxvejlQXMZMQo3htKv8/vJJBWO/H7ILRyOJhPPKolsBRcJPAcswe4J3TR7K5QvID/ou8cZwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498031; c=relaxed/simple;
	bh=lO/BZKVnQ4UUwQdMZsxH1WbxOrK010Sme9F2tGXelY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEblUxAGmapIER9eeEG4eN03tq0Vt9MDvGJ3E24vhn+L6ecJ8bw9t83ImWhEF4cxErUpP9oWEv2IWxYtlxvUK4lwTmq+0U/iw5pkrwok7lgomg0CDJHtUOSQJxa5QZrIwLzKIQqRzElfiFKm5oqhq16wkfc21xHR56cIyQyrczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ph/GZw3K; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343514c7854so243474a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 22:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762498029; x=1763102829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuYtbewa74amlvxhOvnYWgzstPozDBL7SjTASBroF4w=;
        b=ph/GZw3KEX8T8jJMOhMc6mG/IVpn2p34eipiX3IySaFIhFIdj0M5XN+infY9fBTZzR
         qiyiT930TUcC05ZyaWbA0aM5aSjOQ0Xq66DlGBOOTEauZ8ejsTWxyqK5KGaLTQweDWQO
         1qT/5r9hsCzeLTctL5yj3B9GJX/Yik2fuOUD5dS/vm8pQWhGdhTg4F+xObRxioMyrfAd
         L7VpUHYpN+TPNrX0Rcf1cTZnh3Guk4RV5Q6sYzMipazMK8bzQqQyDxr+nXrl6GiVWVU3
         gtVUKCeX5NFzKkxE9aT6dX/QSLYIeAEVSwcxXPF68ysb2NUlCMdhLWgcB0INjBivSCw2
         /L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762498029; x=1763102829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuYtbewa74amlvxhOvnYWgzstPozDBL7SjTASBroF4w=;
        b=w91XHLjezITvv5IBxpfSwrWmAK0YplDEpRaTOmAwwhHU3DVEYYPdnghycE18VDnquL
         pwW2n/lHi2sM7hHAuD1OXe2NpNpUxEs9IiO6GgSQmobkH0kkStz4n6Xwlh6AZ5P9betU
         jbuyM5XYJgatepqg74gAvKxJcAGPZE26V0iSBMKUfXJKGGOT8Rl5c9/Ba+THjEHGh3Z9
         FvLPvIfAp5wLSaXkYKa75/0opqxmSNKSNMBSRkLgdn9vp85hd33mcPxFZ/Ykzo+S8h+p
         9pB0J7lOWzhSsaO7pdxkxRXebsOWS7cPvzNHYaQ/5lbfnxrUDepdOHnfp00PX8YYDLFt
         0jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs5N1uLxUuVdhZ3ORwUEQ4o5yGjid5lX47e1YrgttrmkDc0pow7gxR/3gNBgLjcOnOTe0AJ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9Xu9jFglyzMExQ9dl2AwIap5pBudXZYVBKFjFHn0GppUon2Z
	bB/UVtjV0n1vwqTPicuLRC+Nb9+9rTXfpKXc1IngDRP+mVXigDXRkn2/me6z+U0fMilKfVjOUU6
	wk0Ezv0418HlvYn4riQyOT1yONLL8SfqNH1AnbpyY
X-Gm-Gg: ASbGncsdS3XCnm3jXXTu7DLmXVnNH/16c5m7+d30/G+c8N0JohLbaP3sO9UQocfbir4
	W1apI/E3FrI99Vt54OI0SgraQRF8vtr6wKKyRLsFub1+vx4y/TQkmKzdiXMunBGvHu7Zri1Rk+r
	wvqvQ01UUXf3Ir2hT7FeV9gQDcndZUXbf8F9QNXtZ5HwAor1tuhbYJbiRi8SUPrL758/UMkO0mJ
	52AbHfeB1osIX6kwj75p5ehht17DcTR/lf5IX4DqVMJ7eCgdDWwtCY+AGgi9i8BBPQQXe1KaUJO
	fXl/apPWaM4LKyJ2wg==
X-Google-Smtp-Source: AGHT+IGkVMsnxefLeZTo+XB8zXrEfgF5CsVvC/uuEKj5wWNB1qwi87uCVDLK7NMjaB1NIjaztp/ey0cQPsF1qMthr1Y=
X-Received: by 2002:a17:90b:5101:b0:341:1a50:2ea9 with SMTP id
 98e67ed59e1d1-343537849b3mr919363a91.16.1762498029122; Thu, 06 Nov 2025
 22:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 22:46:58 -0800
X-Gm-Features: AWmQ_blCZpkdiYCtOdE79xX9RwhclIYhCwd35ZMViJNxLEGJJVxdawnJ_9UFRmg
Message-ID: <CAAVpQUA+L_PishcamVi9qOLb595mpB-xKgibRcnv9JSfXeoE_g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> There is a lack of NUMA awareness and more generally lack
> of slab caches affinity on TX completion path.
>
> Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
> in per-cpu caches so that they can be recycled in RX path.
>
> Only use this if the skb was allocated on the same cpu,
> otherwise use skb_attempt_defer_free() so that the skb
> is freed on the original cpu.
>
> This removes contention on SLUB spinlocks and data structures.
>
> After this patch, I get ~50% improvement for an UDP tx workload
> on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).
>
> 80 Mpps -> 120 Mpps.
>
> Profiling one of the 32 cpus servicing NIC interrupts :
>
> Before:
>
> mpstat -P 511 1 1
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:     511    0.00    0.00    0.00    0.00    0.00   98.00    0.00 =
   0.00    0.00    2.00
>
>     31.01%  ksoftirqd/511    [kernel.kallsyms]  [k] queued_spin_lock_slow=
path
>     12.45%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slow=
path
>      5.60%  ksoftirqd/511    [kernel.kallsyms]  [k] __slab_free
>      3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_rin=
g
>      3.27%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
all
>      2.95%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_start
>      2.52%  ksoftirqd/511    [kernel.kallsyms]  [k] fq_dequeue
>      2.32%  ksoftirqd/511    [kernel.kallsyms]  [k] read_tsc
>      2.25%  ksoftirqd/511    [kernel.kallsyms]  [k] build_detached_freeli=
st
>      2.15%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free
>      2.11%  swapper          [kernel.kallsyms]  [k] __slab_free
>      2.06%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_features_check
>      2.01%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
hdr
>      1.97%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_data
>      1.52%  ksoftirqd/511    [kernel.kallsyms]  [k] sock_wfree
>      1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_rin=
g
>      1.23%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
all
>      1.15%  ksoftirqd/511    [kernel.kallsyms]  [k] dma_unmap_page_attrs
>      1.11%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
>      1.03%  swapper          [kernel.kallsyms]  [k] fq_dequeue
>      0.94%  swapper          [kernel.kallsyms]  [k] kmem_cache_free
>      0.93%  swapper          [kernel.kallsyms]  [k] read_tsc
>      0.81%  ksoftirqd/511    [kernel.kallsyms]  [k] napi_consume_skb
>      0.79%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
hdr
>      0.77%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_free_head
>      0.76%  swapper          [kernel.kallsyms]  [k] idpf_features_check
>      0.72%  swapper          [kernel.kallsyms]  [k] skb_release_data
>      0.69%  swapper          [kernel.kallsyms]  [k] build_detached_freeli=
st
>      0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_stat=
e
>      0.56%  ksoftirqd/511    [kernel.kallsyms]  [k] __put_partials
>      0.55%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free_bulk
>      0.48%  swapper          [kernel.kallsyms]  [k] sock_wfree
>
> After:
>
> mpstat -P 511 1 1
>
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
> Average:     511    0.00    0.00    0.00    0.00    0.00   51.49    0.00 =
   0.00    0.00   48.51
>
>     19.10%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
hdr
>     13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_rin=
g
>     10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_fre=
e
>     10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
all
>      7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slow=
path
>      6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
>      5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_attrs
>      3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
>      3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_stat=
e
>      2.73%  swapper          [kernel.kallsyms]  [k] read_tsc
>      2.48%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
>      1.20%  swapper          [kernel.kallsyms]  [k] idpf_features_check
>      1.13%  swapper          [kernel.kallsyms]  [k] napi_consume_skb
>      0.93%  swapper          [kernel.kallsyms]  [k] idpf_vport_splitq_nap=
i_poll
>      0.64%  swapper          [kernel.kallsyms]  [k] native_send_call_func=
_single_ipi
>      0.60%  swapper          [kernel.kallsyms]  [k] acpi_processor_ffh_cs=
tate_enter
>      0.53%  swapper          [kernel.kallsyms]  [k] io_idle
>      0.43%  swapper          [kernel.kallsyms]  [k] netif_skb_features
>      0.41%  swapper          [kernel.kallsyms]  [k] __direct_call_cpuidle=
_state_enter2
>      0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_ire=
t
>      0.40%  swapper          [kernel.kallsyms]  [k] idpf_tx_buf_hw_update
>      0.36%  swapper          [kernel.kallsyms]  [k] sched_clock_noinstr
>      0.34%  swapper          [kernel.kallsyms]  [k] handle_softirqs
>      0.32%  swapper          [kernel.kallsyms]  [k] net_rx_action
>      0.32%  swapper          [kernel.kallsyms]  [k] dql_completed
>      0.32%  swapper          [kernel.kallsyms]  [k] validate_xmit_skb
>      0.31%  swapper          [kernel.kallsyms]  [k] skb_network_protocol
>      0.29%  swapper          [kernel.kallsyms]  [k] skb_csum_hwoffload_he=
lp
>      0.29%  swapper          [kernel.kallsyms]  [k] x2apic_send_IPI
>      0.28%  swapper          [kernel.kallsyms]  [k] ktime_get
>      0.24%  swapper          [kernel.kallsyms]  [k] __qdisc_run
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Big improvement again!

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

