Return-Path: <netdev+bounces-236765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2842C3FB8F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7C8D4E29A2
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B931813F;
	Fri,  7 Nov 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2XF9Z7y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQUILY6N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C02C9D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514637; cv=none; b=ICWGm+fXT0X/kJpuBxbW+u73WsB2HBKK5j0P/fcLGyjY8j+T5dGPQkdlYGK/PBPvj0F8hR6kAEhR9c8XqzYAY/Q/i99x6wj3FhjF80W5E/LBBx4TmdMkTaWcdQ1bIZ4QrC2rPzp5/BPEhr2byZYoe5TbLO8E7vPVWpm7t/ABMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514637; c=relaxed/simple;
	bh=N3W3K+r+XJY7EwefiJ1VgSfYKVFoOgOgxB8/IkQcUFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRYKwaPP8vxzgdfOmCBDKHEY/DoitfnPYnGJP96lxnTV2OUSlGQQlj7MWPnPx+/Qlf+pYhiw7AYNbeiLteyVFYhfh2jcLpIz57W0mZxQAV2jEFo7eW5XVCdIuy+8/+rgu3UR2ZD9IfMl0SnmW3VLDjhOiov46gFYnSjOLeFF7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2XF9Z7y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQUILY6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762514635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z44DscELzJiIRryTl/vCj+p0lP8HVx6RovOgJeewf3g=;
	b=Q2XF9Z7yvOmJK8DkkrZTTkTkOTiG7uXbXg4qDOPVusJD0pd9G8YK+GkoYOfFZU98pf+W/D
	iKBfIQtfinfRWmrBjoBm4ZwTpi8kU+yxMfcd+b90aoTAHcDj4Xv8JaytGegUtz9Ulq6ez9
	OvP6XkcrXgEVjeWObrQ3gQfI56LGLtU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-wRAe9cEvMzOHNQnBsV2n-Q-1; Fri, 07 Nov 2025 06:23:54 -0500
X-MC-Unique: wRAe9cEvMzOHNQnBsV2n-Q-1
X-Mimecast-MFC-AGG-ID: wRAe9cEvMzOHNQnBsV2n-Q_1762514633
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b5c6c817a95so58560166b.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762514632; x=1763119432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z44DscELzJiIRryTl/vCj+p0lP8HVx6RovOgJeewf3g=;
        b=CQUILY6NnClQAWo/jfTIvLqlzge8tG15JtGWtmh7hKJH/blbVYJPlZgDHndbTS6Ziw
         taRysuifcpO8aq2OcP8M1JBpqYL/P9kBFxN24y7/KqlwHN9bB/+OX1CAAsF/UzdtfJvf
         ZFkbkuKNEK3l/rADIUZl82rGFM2NrV4h4qMN3+jaWE6we8gV6ao7YCKcvzxaFlgLNW2C
         O5625s1vqkL3gUOnATSeydpYp3brsIywdIFoXLNYuB3B8hfTk2Vp7tR803NlAdWWim5y
         h4IQWyXCVQyIuJZWVxCIbrz4HuMKcF8vjnR+BdXjFa+36qYjsbeqjJYOHRersM+PNEHJ
         0E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514632; x=1763119432;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z44DscELzJiIRryTl/vCj+p0lP8HVx6RovOgJeewf3g=;
        b=Bh5BBNZg5Mf4UdUn6BXQXH6st/IhNLl52hn1z674M4LXcU7hKJMRHx1W1KbO/cAix4
         MedvgsM9hOEH3HTvDzU98Hr5rMNM/bnrDjUfEsERPvVlNXyUVIuTx48LNIsAsa8xKXlD
         QL97JS8ygJ9X8G8iTM5izuUukcJRnLy6QHKbNSLn+Uj+TUwgX1fsyTwQiugtzwQVWkcn
         5GSdW/JUmIocQjMmixcJp2npsaq6rkCsAyxKYIThJ9fbK1b6OWM+o8XBYsN1zLEqswOO
         ToXLYWF24JvrgIMkX/XlVBpvGIxMKws2vjLcJ6goDFueyw8R49NksG3bTpDcKwWiz479
         j1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDZD03Hs60oZ8u0cV+4eDy+r7XenOxKyMFi7nyylsoBwUOovNvoWedkIWDh/DKZFjhYH2P/Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2AJDbCyaaaCfJPNVUKo2M8O/9Oez/b4O8/S0gpSTRGhXUtnn
	kNQMbZYTKk0vpk1JqDCYe0OuLK5D8O6fLIopq8Rd51W+0SHXRfoX1jofbx4GAjxfCr5mKw8xlR0
	a8EbI3wz1BH8OjQtr9/hnluR/52ndEAr13jX2N338FLYnIKU1+RCUXhsgZB7eh4+m6w==
X-Gm-Gg: ASbGncs2DyaQOpQqgJKESgosWjn+fuuxGyXZAbm4bvtmsXa2o/0G6g0a3XWE8CfVwAz
	l9xvwuYNmktII80Yk3fUTAQJg1j7XaNCTcr3IDXsUgNnFPB3HUEXbRVch9/l056MxGXzk/vQR1M
	cXCo2DeaytUCXUGxyA9PG44khQgONNo0WR1x1G+R7L/t7zzS597rxWt7sxqvTdEStjusetOaTba
	heEIEbWf4GauCtCpcWTYkFYAW+ueZ/XyJeR/VRM6WFd4j2xiChxluLyjo9jyCgn5cTzZXnqBwpj
	EtwWQtpVnKAc8+/WiSRdGt4OPbz5ouTeZNlJPPXqJJjFZvORLFkrDCyO9nBuC8wyklRL2PrCQqd
	QBTUZILkMFXKfrrCt2H1YgFY=
X-Received: by 2002:a17:907:7e8b:b0:b6f:9db1:f831 with SMTP id a640c23a62f3a-b72c09e9697mr264935066b.23.1762514632557;
        Fri, 07 Nov 2025 03:23:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSWR8/VVwmvl15zc2TMuzmw9QtZkm4SJqy7/gEm8twkPQL+pX7SgMbVRcUSZldOfxJn9qaCg==
X-Received: by 2002:a17:907:7e8b:b0:b6f:9db1:f831 with SMTP id a640c23a62f3a-b72c09e9697mr264932366b.23.1762514632125;
        Fri, 07 Nov 2025 03:23:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d461sm230473066b.47.2025.11.07.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:23:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E6E2C328C21; Fri, 07 Nov 2025 12:23:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
In-Reply-To: <20251106202935.1776179-3-edumazet@google.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Nov 2025 12:23:50 +0100
Message-ID: <87ikfmnl15.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

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
>      3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
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
>      1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
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
>      0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_state
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
>     13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
>     10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_free
>     10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_=
all
>      7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slow=
path
>      6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
>      5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_attrs
>      3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
>      3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_state
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
>      0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_iret
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

Impressive!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


