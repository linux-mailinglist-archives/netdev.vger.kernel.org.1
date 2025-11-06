Return-Path: <netdev+bounces-236508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04CC3D5B6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FCFD34867C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FF2FD66E;
	Thu,  6 Nov 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4K8jq7Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F727F4CA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460987; cv=none; b=sSt/WSTMLw9I2RdzYVULks11biChqx2adG6M2eorfETxLfusnox17ijR06eBNtNVMh2+lRYwpztXFomV+B3qKE8NW0JP+cS/Ft/cYUyin4RHsoafVS+dWIMLiUmJCDGIwhKVt0xCJy+krIkIDEM8IYuz4rOIpT9S7fjG24s1xW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460987; c=relaxed/simple;
	bh=yCtP2DHV67HRR48STrhNLySDFBfNgvu5e3l3xb+sORo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nuSfrq2b2g61UL9yk2EzZNTp0/6KvABT4c9yRRGTYx06o+lzsn73dmxbzxIhmsG0Os80WFRORbDeRuvjPzNIUoQifrLDhPrhUaMbQRgtJIab/goxnRLHFbYX+P6f2RcqLj/5wz8OyI15PpWUsWeMA8svZuXDc5hBjV5HlGZaQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4K8jq7Nc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8802e9d2a85so1815976d6.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762460984; x=1763065784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJhgPwHB1BTvRj4Lp3REcWNSdG8MgbAPwZTYIB8M7MM=;
        b=4K8jq7Nc7J6iy9KLE93SpCvLZf0gGsAolBhu93MIYOHZ0msoG0ztdnTScFrpe8FnrU
         iL7qeMhuM1FrWRY1DBnplSrLJDz+pj2JpSvO0fYZprRKGhYbOJT3gaezOy3SdHLgyY7u
         Zi7RLbONTXDuVYZypndnIFnSpyKDE2DAFszfw3hBcN06Tgzp+8kLT8KznUMGDBsoZnal
         VhuarKu8ELIahFKb/PB2bIAmNMnW003aU1ZO+7k/rEgqOU+P7+PHl1IdM6wT7FJF2npK
         CyupSAGBwV5yoU0b6aTN7ZVDrzfLODttC14ArDmnRjWKJk/le+NGhiOMPcMPMaJMUfhD
         IWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460984; x=1763065784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJhgPwHB1BTvRj4Lp3REcWNSdG8MgbAPwZTYIB8M7MM=;
        b=IM8un2sHORHqlPDfgroRFOBKoZHIF8uRlTq/bF3l9PS7OurCSNSIQcLf8pNaXvUtTT
         biLCK80+Pu4x+SNvI1CW42w7PJUacmI+/kWMk3N7hSF5kXcDH+kZATElphuwwYQVTD7U
         kLEHYp6uqf6xrCj23Yj17mQu68Unl6Kaub/RgATRGmKDVrVLOBnszggkZqTB1mhk8bUc
         Q2D8PrfbARpPgAvrw5JLdef1wKC/dPq+59NqcuMWrbZmFrbF6zx6CA1E/KJ32FT1+PMp
         +f2C2c3Z8RWA0iRwbMfkD0SjF0KZkjRfR7Cuo86F6PNeG1OWwaQ7s+YtvlXVv15xdSMg
         QfQw==
X-Forwarded-Encrypted: i=1; AJvYcCXR7eClH1Zil97OrBTsnNZKtVdhLq8yM6L9iGZsehLqFMlRhdEybAjh1AFtvfvi63yHDea0M+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpBHACCU+H4vHVMndC8QiLISYZxoVHIcZDKkPnfSOJup8Yt1v
	9IuaR8tY7JQi0C1v0KcpxDHmRq7hN5kYFSFh0JqR5KU5pDk37B4mN4SbpmDXcSNSBPDhtlQ47fx
	xMTS+FYce3iSXGA==
X-Google-Smtp-Source: AGHT+IFZM8H0LfDs32fMqWhfy8vHCoNUEycN8nDHqx0oEdUsNrGQIKdnGkCA9Jm4yIqfd+Z2DAAB0RBm1JzFbw==
X-Received: from qvboe4.prod.google.com ([2002:a05:6214:4304:b0:880:3298:f5a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2027:b0:880:5730:d3db with SMTP id 6a1803df08f44-8817670b130mr11728996d6.21.1762460984646;
 Thu, 06 Nov 2025 12:29:44 -0800 (PST)
Date: Thu,  6 Nov 2025 20:29:34 +0000
In-Reply-To: <20251106202935.1776179-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106202935.1776179-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is a lack of NUMA awareness and more generally lack
of slab caches affinity on TX completion path.

Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
in per-cpu caches so that they can be recycled in RX path.

Only use this if the skb was allocated on the same cpu,
otherwise use skb_attempt_defer_free() so that the skb
is freed on the original cpu.

This removes contention on SLUB spinlocks and data structures.

After this patch, I get ~50% improvement for an UDP tx workload
on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).

80 Mpps -> 120 Mpps.

Profiling one of the 32 cpus servicing NIC interrupts :

Before:

mpstat -P 511 1 1

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     511    0.00    0.00    0.00    0.00    0.00   98.00    0.00    0.00    0.00    2.00

    31.01%  ksoftirqd/511    [kernel.kallsyms]  [k] queued_spin_lock_slowpath
    12.45%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slowpath
     5.60%  ksoftirqd/511    [kernel.kallsyms]  [k] __slab_free
     3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
     3.27%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
     2.95%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_start
     2.52%  ksoftirqd/511    [kernel.kallsyms]  [k] fq_dequeue
     2.32%  ksoftirqd/511    [kernel.kallsyms]  [k] read_tsc
     2.25%  ksoftirqd/511    [kernel.kallsyms]  [k] build_detached_freelist
     2.15%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free
     2.11%  swapper          [kernel.kallsyms]  [k] __slab_free
     2.06%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_features_check
     2.01%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
     1.97%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_data
     1.52%  ksoftirqd/511    [kernel.kallsyms]  [k] sock_wfree
     1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
     1.23%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
     1.15%  ksoftirqd/511    [kernel.kallsyms]  [k] dma_unmap_page_attrs
     1.11%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
     1.03%  swapper          [kernel.kallsyms]  [k] fq_dequeue
     0.94%  swapper          [kernel.kallsyms]  [k] kmem_cache_free
     0.93%  swapper          [kernel.kallsyms]  [k] read_tsc
     0.81%  ksoftirqd/511    [kernel.kallsyms]  [k] napi_consume_skb
     0.79%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
     0.77%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_free_head
     0.76%  swapper          [kernel.kallsyms]  [k] idpf_features_check
     0.72%  swapper          [kernel.kallsyms]  [k] skb_release_data
     0.69%  swapper          [kernel.kallsyms]  [k] build_detached_freelist
     0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_state
     0.56%  ksoftirqd/511    [kernel.kallsyms]  [k] __put_partials
     0.55%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free_bulk
     0.48%  swapper          [kernel.kallsyms]  [k] sock_wfree

After:

mpstat -P 511 1 1

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:     511    0.00    0.00    0.00    0.00    0.00   51.49    0.00    0.00    0.00   48.51

    19.10%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
    13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
    10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_free
    10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
     7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slowpath
     6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
     5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_attrs
     3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
     3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_state
     2.73%  swapper          [kernel.kallsyms]  [k] read_tsc
     2.48%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
     1.20%  swapper          [kernel.kallsyms]  [k] idpf_features_check
     1.13%  swapper          [kernel.kallsyms]  [k] napi_consume_skb
     0.93%  swapper          [kernel.kallsyms]  [k] idpf_vport_splitq_napi_poll
     0.64%  swapper          [kernel.kallsyms]  [k] native_send_call_func_single_ipi
     0.60%  swapper          [kernel.kallsyms]  [k] acpi_processor_ffh_cstate_enter
     0.53%  swapper          [kernel.kallsyms]  [k] io_idle
     0.43%  swapper          [kernel.kallsyms]  [k] netif_skb_features
     0.41%  swapper          [kernel.kallsyms]  [k] __direct_call_cpuidle_state_enter2
     0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_iret
     0.40%  swapper          [kernel.kallsyms]  [k] idpf_tx_buf_hw_update
     0.36%  swapper          [kernel.kallsyms]  [k] sched_clock_noinstr
     0.34%  swapper          [kernel.kallsyms]  [k] handle_softirqs
     0.32%  swapper          [kernel.kallsyms]  [k] net_rx_action
     0.32%  swapper          [kernel.kallsyms]  [k] dql_completed
     0.32%  swapper          [kernel.kallsyms]  [k] validate_xmit_skb
     0.31%  swapper          [kernel.kallsyms]  [k] skb_network_protocol
     0.29%  swapper          [kernel.kallsyms]  [k] skb_csum_hwoffload_help
     0.29%  swapper          [kernel.kallsyms]  [k] x2apic_send_IPI
     0.28%  swapper          [kernel.kallsyms]  [k] ktime_get
     0.24%  swapper          [kernel.kallsyms]  [k] __qdisc_run

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index eeddb9e737ff28e47c77739db7b25ea68e5aa735..7ac5f8aa1235a55db02b40b5a0f51bb3fa53fa03 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1476,6 +1476,11 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 
+	if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
+		skb_release_head_state(skb);
+		return skb_attempt_defer_free(skb);
+	}
+
 	if (!skb_unref(skb))
 		return;
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


