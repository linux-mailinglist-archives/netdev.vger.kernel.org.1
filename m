Return-Path: <netdev+bounces-236844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C418C40A59
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50AB1893FE9
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B532D7D8;
	Fri,  7 Nov 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qti9o61k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597932D0F9
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530308; cv=none; b=dG07yb9miOeh7Kw/fhdELT1+G+s64VuiBetD2+JZVhygzUYdM1JSepVE18DbjNn8dcBYvoaODFTFTD37yxQLRC0G2BO53F2Y0CD88qUj1VKYJa4fjosHJOaQcijeghfM4x1fo3FQuha3WA30+cWnsMAxTTRlGSFLYrWxsjvU78U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530308; c=relaxed/simple;
	bh=5iYJEqegYp4DylAFjqtesOu4OtnEugBH/GmaqwizSAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCbnA131V5mru5QjitX9gD85Rj7FEIFjXuSLiflC99tAIuNE4jnubK1OTQfHlXRbIW28F/num12VSmPOgle+d+iMKXWjFBiIQUC9GxlTIhCyLo3cKEaBhaWcfIARrEHkmI7dQe+HD5i0c2FbBg17unFV7GobRc5gVAjWta5W49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qti9o61k; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43320988dcfso3114085ab.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530306; x=1763135106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAuQV3P10tvELq+4DDVuXMDJZC15r/ACPECa19wk8Gc=;
        b=Qti9o61kPdrR9eia/keHTHj35+1roy70r6onj/zNW/Eo2H96ShY9sUxIDInj3ksC5G
         VpGYPH1i0VC+5fxJPtGcUArenQmpbh48SbWSM//KD/557PqRuGcKFTAW2VvIbIlDDYQd
         bQb77jFprhSPi2FT+M3JIPw4e23IPgigfm+DiQg0cDhePPhmF/+W7Cmjy/G/X63Gc4D+
         5tbT3SRYJQOdqBM17uJAQe7E3cvM4/iYZDf6k/25mLu+nqXFS+55ChCFLssmJxEfrboR
         LHXoPUU1GdlzSk+sVItOVVwnC/Br+BLcLVnQDJLzoRBAZ0oZhVFIZ4n4sMDa63ZlFkGy
         70Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530306; x=1763135106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAuQV3P10tvELq+4DDVuXMDJZC15r/ACPECa19wk8Gc=;
        b=tzeyCVdsV0LXUa0iFzPNRtsqiYGI5QTJ9h2kJbutIDHeMYD8SxiPK5q+Amuv32ogzh
         6r4OLO8YAPvLPL0zxbjsjeulnZYIIJDPmQLn5fwy1CRpyuimjZ32mWqwKnwFq2yBT9EG
         Z43w4ByN0ZOWrsD4IDhF1xtM9FUfMjI+wSeybWgwgta10UaqhVrqu6qk4A3rUyvhi1J6
         U1QXA26vwBl+EOl3wf7tip9uKWfXihFwhTCTVUPjNdMdMRLyBhTJnwWvFFsjHpIGT6ay
         f1hOoL/Wpf/YMajrM8uwYHBv3Z+rcwFl+q2UUFtWj/bXGtqEi6AE5s6AQf7ua4dsnXjO
         ha1g==
X-Forwarded-Encrypted: i=1; AJvYcCXqJGD5QSjttlatBcae4Qg+zzUX+MJc4wlyZqgs+UzZ3FQ4w3SGJmLzbx5bnOjEgxCU/TKj3Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NJV1yi8s4rcAk1zH+vW/HFXJi0R1yK5tzb0Vtl3rIERxGMCN
	eyNNGZwHuY2Jjj0vZO+ReyG3Sh/eV6AP+ux7hz7q5l3zIvOAZ69ldzgTZLzEDlMV658Y9w5mRLV
	s3O61Dy6hV7iw3K17ZIpZXogJixaEAwg=
X-Gm-Gg: ASbGncu6X1GjBK4q0WV33MWcbcJLahBQT5AhcCI8dtLFltrx3RdbM0QcdVWkaPxS3lF
	z01oCs0QBsjCvWnCiigwl6A4x7fIX1Wanc8LMBj4Gf8J+hk1oXBgbNkeDJQqlK0ecPwpenK03ad
	I2v4XNFGZ8kfrSSlBgQAkWJFPOhgSvyGf1O6xO5P/+aOVYBeUBgmCE2olD0M/gR6rKGVZtwvlUD
	sJn800w2YHZA3sFL79SW4ucEbX4m5WTWy4NGxK0phOY3a5cWX8fr4MbWOAhtSVyxLce8k3XECI=
X-Google-Smtp-Source: AGHT+IFcaVgekAXNby3+vvoJfMusidfHdXgYe71+3tRaD8t2HUSilWUh3528qR0xPcQuTk8N64hTg2gtS2LK7FRxhac=
X-Received: by 2002:a92:cd8d:0:b0:433:2597:8cc with SMTP id
 e9e14a558f8ab-4335f455e61mr49443635ab.29.1762530305601; Fri, 07 Nov 2025
 07:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-3-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Nov 2025 23:44:29 +0800
X-Gm-Features: AWmQ_bkhaFfuA_kFwV3-5szwLD7JEYO3iJnw1bgi0G8HvSluayHkXmJXo1diVf0
Message-ID: <CAL+tcoDqUYgu0iVKm0Ss-jg+RXHSgoFxG9tMRdxE9ycKz7Gt=Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
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

Thanks for your brilliant work that really gives me so much
inspiration one more time.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

