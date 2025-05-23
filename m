Return-Path: <netdev+bounces-193066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E537AC25FF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D3171379
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0ED21C170;
	Fri, 23 May 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="GOlYKp47";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rmvx5C2x"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07F24676D
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012834; cv=none; b=sVCBSaGrTESw8hJvx/ZzPui4CtGWB+FTt4iNppz5bBXirjZDIeYVEGspv34/OJzfGNXJqPXhcBlO/rjdG6WksN23X0C+pGqaCDX2SZQuq73lp3HMdpW0HO9Kfqq9bM0xbTqM7VgXP8/+UcyTCU+aO3pPsZplOKA6vEND6SOeFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012834; c=relaxed/simple;
	bh=n9CWlHKpbW854ohDdNf0dToL1KOCLlUTznn61di94Gc=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=TvrUJSysdVcdWdFzMoyW77msy93DCeZ3Jzw45LEzKag7a5iEtQyDL4pzODZGA4Et2CTNkQMmgph+oAQ/U6FFbf56G3zf9nno/wM8kei4Avn63GdXIzFQGKyfXdkk7rxjHVHj7fsyUdGLnJ4Xol5/MCDQddEzGzhrFSc0xTDNCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=GOlYKp47; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rmvx5C2x; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 777CA254009D;
	Fri, 23 May 2025 11:07:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 May 2025 11:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748012827; x=1748099227; bh=a6CqowYUt1
	YGpNE/ymoYbBvI62zpRnRh9FS4BGrrMj0=; b=GOlYKp47jW5I5cQZkANUcsY2yp
	1IGHwcmi0G6PR4kPJ7tEimGHAtrGOCUoz3cBrt2zZRCBEUtG9mYINnEis8QTTIi1
	9vgvlFkBXSY9aMMR/smsaZVRjh1rFbQ4lDvj0XFYn2Y3T73GZ3VvwAmQ3RzxK+Lt
	6djx2URmZxQGT8iP5ZvSjjVYvp6BlrEi6RQsIM3XSODPB+jZzH/7I5TbS2sYbo2k
	ktZda8dyUce92B9TiYO6pjiy0MxmjtbEKK0aULAkZD3s3ccyckxW+AKFYqYmfkef
	wx2Ue3bh9Wa/B4Nd4QpyGh5Sqk4qmXNik80b79TfSPyGCqOurbKewZdkuDgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748012827; x=1748099227; bh=a6CqowYUt1YGpNE/ymoYbBvI62zpRnRh9FS
	4BGrrMj0=; b=rmvx5C2xjVyqDTonSyBTaTiYhtVriAiCoY9rhol9wT2jqQyNZSV
	vf5qPvDVj6Hk/6c/Icr6/HN6ETBCf3hfZBE0lib7UkTCtxSP25Eq9w4oUO+Y2xL9
	1mrn2I1hdVgIdprLyQhPyL29EFUkGt4e9Ww+OrwErWPe1qk7BHhWO3QTnLZkkZhY
	kir4SkawSEPPp+ZnGI8RZzuBfy551aUNlsHJkaBFiO5cD/cag/yCT2C2oNMIHniH
	6TmUr10CcHwIiU2QurPELZPhVhSL1BRDhefIE7F60BfDdkbr0SMaGxS+SqmFjmgV
	/gadDBh0LLJrC+7hNqaDwcp1DzHLyAQskVA==
X-ME-Sender: <xms:GY8waGgafr4K1aKOaE5-r0cd4NFajXjDooJHAYu1I82_40VwaZg08Q>
    <xme:GY8waHDKQDejc55B4fdt5pWyq9OVtfdF96Q-ThhfAjfR02nHniRuKdaoIkYUdzmtp
    o51TJfewfijjwVGNog>
X-ME-Received: <xmr:GY8waOEpF3OhJx3cnzkNXw4rvyroo5zhVtGkNWEiEzcefhUT6R0uGYQW2FVHAqTXS-m3TDp43x90zPVL8-D2ytCojV5qVyvBVr2swHucKNIdnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffktgggufffjgev
    vfhfofesmhdtmherhhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnohcuoe
    hrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnhepfffhkedt
    jefhieegffejgfevkeeuheehheelkeehkeevleekgeelieffgfeuhfdunecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegsvghj
    rghrrghnohdrihhopdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphhtthho
    peihvghhvgiikhgvlhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Go8waPRmzM5cBmp3wgcjCfUlVf-OjH3lSNtVqYyTD2XHVI-ABcrCvw>
    <xmx:Go8waDzSum5kH7d59eORQtxDtJNyzL_1hOxoTH-fK0B8blSijl7D6g>
    <xmx:Go8waN4HpFbQFPgs3_Hjbou8JmndvI5AsYCmKUIP0-naLDpzT6xcVQ>
    <xmx:Go8waAxfLnqzoWORA3DZYaGigDiAyqBPMyrO_h895KWT-iXFWvHMNQ>
    <xmx:G48waIzwuFb_616ssoWYmz2EZabNdwQRE9piIIAoXzjTT81QNUSgGfQj>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:07:04 -0400 (EDT)
From: Ricard Bejarano <ricard@bejarano.io>
Message-Id: <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
Date: Fri, 23 May 2025 17:07:02 +0200
In-Reply-To: <20250523110743.GK88033@black.fi.intel.com>
Cc: netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hey, thank you very much for your answer.

Before responding, I've attached the 'perf top' outputs for blue's CPU =
#2 (which
I've made to be the one that handles the interrupts of both eno1 and =
tb0). They
don't point to anything conclusive, from what I can read.

> What is the performance without bridging?

I actually tested this as soon as I sent my original message. =
Interestingly
enough, performance without bridging is about the same: ~930Mbps in the
purple->red direction, ~5Mbps in red->purple.

I also tested running eBPF/XDP programs attached to both eno1 and tb0 to
immediately XDP_REDIRECT to each other. This worked, as confirmed by =
successful
ping/iperf even after bringing br0 down, and I could see the XDP program
invocation counts growing in 'bpftool prog list'.
But all I got was maybe (IMO falls within measurement error margin) a =
~1Mbps
average increase in throughput in the red->purple direction.
But I guess we've now isolated the problem out of the bridge completely, =
right?

As instructured, I've attached the full 'dmesg' output after setting the
'thunderbolt.dyndbg=3D+p' kernel command line flag.

Happy to provide whatever else you need.

Thanks again,
Ricard Bejarano


--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A
Content-Disposition: attachment;
	filename=perf-top-idle.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="perf-top-idle.txt"
Content-Transfer-Encoding: quoted-printable

The following is the `perf top` output of blue's CPU2 (which has been =
made to handle both tb0 and eno1) when idle (no iperfs running through =
it).

   PerfTop:      55 irqs/sec  kernel:94.5%  exact: 100.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles:P],  (all, CPU: 2)
=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
---------------------------------------

     2.66%  [kernel]       [k] menu_select
     2.17%  [kernel]       [k] cpuidle_enter_state
     1.72%  [kernel]       [k] _raw_spin_lock
     1.39%  [kernel]       [k] ktime_get
     1.34%  [kernel]       [k] read_tsc
     1.29%  [kernel]       [k] native_write_msr
     1.27%  [kernel]       [k] __hrtimer_next_event_base
     1.27%  [kernel]       [k] sysvec_apic_timer_interrupt
     1.21%  libc.so.6      [.] malloc
     1.21%  [kernel]       [k] kmem_cache_free
     1.07%  [kernel]       [k] psi_group_change
     1.06%  [kernel]       [k] select_task_rq_fair
     1.01%  [kernel]       [k] native_sched_clock
     0.99%  [kernel]       [k] account_idle_ticks
     0.98%  [kernel]       [k] do_idle
     0.97%  [kernel]       [k] __hrtimer_run_queues
     0.97%  [kernel]       [k] schedule_idle
     0.96%  [kernel]       [k] rb_next
     0.90%  [kernel]       [k] tick_program_event
     0.89%  [kernel]       [k] note_interrupt
     0.85%  [kernel]       [k] update_sd_lb_stats.constprop.0
     0.84%  [kernel]       [k] tick_nohz_next_event
     0.83%  [kernel]       [k] intel_iommu_map_pages
     0.83%  [kernel]       [k] cpupri_set
     0.82%  [kernel]       [k] __irq_wake_thread
     0.81%  [kernel]       [k] tcp_rcv_established
     0.78%  [kernel]       [k] __netif_receive_skb_core.constprop.0
     0.78%  [kernel]       [k] tcp_do_parse_auth_options
     0.73%  [kernel]       [k] iwl_pcie_rx_handle.cold
     0.73%  [kernel]       [k] alloc_iova_fast
     0.70%  [kernel]       [k] __schedule
     0.69%  [kernel]       [k] dequeue_task_rt
     0.69%  [kernel]       [k] _raw_spin_unlock
     0.69%  [kernel]       [k] update_rq_clock
     0.68%  [kernel]       [k] tick_nohz_idle_got_tick
     0.68%  [kernel]       [k] ieee80211_data_to_8023_exthdr
     0.67%  [kernel]       [k] sched_balance_update_blocked_averages
     0.63%  [kernel]       [k] __wrgsbase_inactive
     0.62%  [kernel]       [k] cpuidle_not_available
     0.61%  [kernel]       [k] clflush_cache_range
     0.60%  [kernel]       [k] __switch_to_asm
     0.59%  [kernel]       [k] ip_rcv_finish_core
     0.59%  [kernel]       [k] ieee80211_rx_handlers
     0.59%  [kernel]       [k] __update_load_avg_cfs_rq
     0.59%  [kernel]       [k] update_load_avg
     0.59%  [kernel]       [k] napi_complete_done
     0.59%  [kernel]       [k] dma_pte_clear_level

--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A
Content-Disposition: attachment;
	filename=perf-top-fast.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="perf-top-fast.txt"
Content-Transfer-Encoding: quoted-printable

The following is the `perf top` output of blue's CPU2 (which has been =
made to handle both tb0 and eno1) when running iperf3 from purple->red =
(the fast, ~930Mbps direction).

   PerfTop:    3689 irqs/sec  kernel:100.0%  exact: 100.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles:P],  (all, CPU: 2)
=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
---------------------------------------

     7.36%  [kernel]       [k] clflush_cache_range
     7.29%  [kernel]       [k] memcpy_orig
     4.61%  [kernel]       [k] ioread32
     3.83%  [kernel]       [k] pfn_to_dma_pte
     2.92%  [kernel]       [k] tbnet_start_xmit
     2.74%  [kernel]       [k] _raw_spin_lock_irqsave
     2.40%  [kernel]       [k] clear_page_erms
     2.40%  [kernel]       [k] intel_iommu_map_pages
     1.77%  [kernel]       [k] dma_pte_clear_level
     1.28%  [kernel]       [k] e1000_intr_msi
     1.26%  [kernel]       [k] cpuidle_enter_state
     1.19%  [kernel]       [k] menu_select
     1.18%  [kernel]       [k] dev_gro_receive
     1.18%  [kernel]       [k] e1000_clean_rx_irq
     1.15%  [kernel]       [k] csum_partial
     1.13%  [kernel]       [k] _raw_spin_lock
     1.09%  [kernel]       [k] e1000_irq_enable
     0.96%  [kernel]       [k] tcp_gro_receive
     0.88%  [kernel]       [k] kmem_cache_free
     0.85%  [kernel]       [k] memset_orig
     0.72%  [kernel]       [k] tbnet_poll
     0.66%  [kernel]       [k] __iommu_dma_unmap
     0.63%  [kernel]       [k] alloc_iova_fast
     0.62%  [kernel]       [k] __schedule
     0.62%  [kernel]       [k] br_handle_frame
     0.60%  [kernel]       [k] iommu_dma_free_iova
     0.58%  [kernel]       [k] e1000_xmit_frame
     0.58%  [kernel]       [k] e1000_alloc_rx_buffers
     0.54%  [kernel]       [k] skb_segment
     0.54%  [kernel]       [k] _raw_spin_unlock_irqrestore
     0.53%  [kernel]       [k] kmem_cache_alloc_noprof
     0.53%  [kernel]       [k] intel_iommu_unmap_pages
     0.51%  [kernel]       [k] inet_gro_receive
     0.51%  [kernel]       [k] skb_release_data
     0.49%  [kernel]       [k] fdb_find_rcu
     0.48%  [kernel]       [k] native_irq_return_iret
     0.48%  [kernel]       [k] iommu_pgsize
     0.47%  [kernel]       [k] ring_work
     0.47%  [kernel]       [k] get_page_from_freelist
     0.45%  [kernel]       [k] iommu_dma_map_page
     0.45%  [kernel]       [k] build_detached_freelist
     0.45%  [kernel]       [k] ring_write_descriptors
     0.44%  [kernel]       [k] cache_tag_flush_range_np
     0.43%  [kernel]       [k] iommu_map
     0.42%  [kernel]       [k] __iommu_map
     0.41%  [kernel]       [k] __iommu_dma_map
     0.41%  [kernel]       [k] iommu_dma_alloc_iova

--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A
Content-Disposition: attachment;
	filename=perf-top-slow.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="perf-top-slow.txt"
Content-Transfer-Encoding: quoted-printable

The following is the `perf top` output of blue's CPU2 (which has been =
made to handle both tb0 and eno1) when running iperf3 from red->purple =
(the slow, ~5Mbps direction).

   PerfTop:     788 irqs/sec  kernel:94.7%  exact: 100.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles:P],  (all, CPU: 2)
=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
---------------------------------------

     3.23%  [kernel]       [k] e1000_irq_enable
     2.99%  [kernel]       [k] ioread32
     2.94%  [kernel]       [k] cpuidle_enter_state
     2.56%  [kernel]       [k] e1000_intr_msi
     2.14%  [kernel]       [k] menu_select
     1.93%  [kernel]       [k] _raw_spin_lock
     1.78%  [kernel]       [k] clflush_cache_range
     1.43%  [kernel]       [k] _raw_spin_lock_irqsave
     1.41%  perf           [.] dso__find_symbol
     1.39%  [kernel]       [k] pfn_to_dma_pte
     1.18%  [kernel]       [k] clear_page_erms
     1.00%  [kernel]       [k] br_handle_frame
     0.97%  [kernel]       [k] __dev_queue_xmit
     0.89%  [kernel]       [k] intel_iommu_map_pages
     0.82%  [kernel]       [k] native_irq_return_iret
     0.76%  [kernel]       [k] dma_pte_clear_level
     0.73%  [kernel]       [k] do_idle
     0.71%  [kernel]       [k] alloc_iova_fast
     0.71%  [kernel]       [k] __hrtimer_next_event_base
     0.69%  [kernel]       [k] __schedule
     0.69%  [kernel]       [k] read_tsc
     0.67%  [kernel]       [k] __netif_receive_skb_core.constprop.0
     0.67%  [kernel]       [k] native_apic_msr_eoi
     0.67%  [kernel]       [k] timerqueue_add
     0.66%  [kernel]       [k] psi_group_change
     0.66%  [kernel]       [k] native_sched_clock
     0.65%  [kernel]       [k] csum_partial
     0.63%  [kernel]       [k] net_rx_action
     0.59%  [kernel]       [k] kmem_cache_free
     0.55%  [kernel]       [k] e1000_xmit_frame
     0.55%  [kernel]       [k] sched_balance_update_blocked_averages
     0.54%  [kernel]       [k] ktime_get
     0.52%  [kernel]       [k] __get_next_timer_interrupt
     0.51%  [kernel]       [k] irq_chip_ack_parent
     0.50%  [kernel]       [k] __handle_irq_event_percpu
     0.48%  [kernel]       [k] ring_msix
     0.47%  [kernel]       [k] fdb_find_rcu
     0.46%  [kernel]       [k] e1000_clean_rx_irq
     0.46%  [kernel]       [k] eth_type_trans
     0.45%  [kernel]       [k] tbnet_poll
     0.41%  [kernel]       [k] rcu_sched_clock_irq
     0.41%  [kernel]       [k] e1000_clean_tx_irq
     0.39%  [kernel]       [k] sched_balance_newidle
     0.39%  [kernel]       [k] inet_gro_receive
     0.38%  [kernel]       [k] native_write_msr
     0.38%  [kernel]       [k] tbnet_alloc_rx_buffers
     0.38%  [kernel]       [k] __switch_to_asm

--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A
Content-Disposition: attachment;
	filename=dmesg.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

root@blue:~# cat /proc/cmdline
BOOT_IMAGE=3D/vmlinuz-6.14.7 root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro =
thunderbolt.dyndbg=3D+p
root@blue:~# dmesg
[    0.000000] Linux version 6.14.7 (root@orange) (gcc (Ubuntu =
13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 =
SMP PREEMPT_DYNAMIC Mon May 19 15:01:20 UTC 2025
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-6.14.7 =
root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro thunderbolt.dyndbg=3D+p
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007991afff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000007991b000-0x000000007a145fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000007a146000-0x000000007a1c2fff] =
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a1c3000-0x000000007a273fff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007a274000-0x000000007ac0dfff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000007ac0e000-0x000000007ac0efff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000007ac0f000-0x000000007fffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047dffffff] =
usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x6d525018-0x6d535e57] usable =3D=3D> =
usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem =
0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem =
0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem =
0x0000000000100000-0x000000006d525017] usable
[    0.000000] reserve setup_data: [mem =
0x000000006d525018-0x000000006d535e57] usable
[    0.000000] reserve setup_data: [mem =
0x000000006d535e58-0x000000007991afff] usable
[    0.000000] reserve setup_data: [mem =
0x000000007991b000-0x000000007a145fff] reserved
[    0.000000] reserve setup_data: [mem =
0x000000007a146000-0x000000007a1c2fff] ACPI data
[    0.000000] reserve setup_data: [mem =
0x000000007a1c3000-0x000000007a273fff] ACPI NVS
[    0.000000] reserve setup_data: [mem =
0x000000007a274000-0x000000007ac0dfff] reserved
[    0.000000] reserve setup_data: [mem =
0x000000007ac0e000-0x000000007ac0efff] usable
[    0.000000] reserve setup_data: [mem =
0x000000007ac0f000-0x000000007fffffff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem =
0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem =
0x0000000100000000-0x000000047dffffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=3D0x7a15f000 ACPI=3D0x7a15f000 =
TPMFinalLog=3D0x7a1ff000 SMBIOS=3D0x7a9a4000 SMBIOS 3.0=3D0x7a9a3000 =
MEMATTR=3D0x778e7018 ESRT=3D0x7a9d8c98 MOKvar=3D0x7a9d7000 =
INITRD=3D0x71856698 RNG=3D0x7a15e018 TPMEventLog=3D0x7a152018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem43: MMIO range=3D[0xe0000000-0xefffffff] =
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Not removing mem44: MMIO =
range=3D[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem45: MMIO =
range=3D[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem46: MMIO =
range=3D[0xfed00000-0xfed03fff] (16KB) from e820 map
[    0.000000] efi: Not removing mem47: MMIO =
range=3D[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem48: MMIO range=3D[0xff000000-0xffffffff] =
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.2.1 present.
[    0.000000] DMI: Intel(R) Client Systems NUC8i5BEH/NUC8BEB, BIOS =
BECFL357.86A.0095.2023.0918.1953 09/18/2023
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2300.000 MHz processor
[    0.000000] tsc: Detected 2299.968 MHz TSC
[    0.000357] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000361] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000371] last_pfn =3D 0x47e000 max_arch_pfn =3D 0x400000000
[    0.000377] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built =
from 10 variable MTRRs
[    0.000379] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT
[    0.001004] last_pfn =3D 0x7ac0f max_arch_pfn =3D 0x400000000
[    0.011253] esrt: Reserving ESRT space from 0x000000007a9d8c98 to =
0x000000007a9d8cd0.
[    0.011263] Using GB pages for direct mapping
[    0.011624] Secure boot disabled
[    0.011625] RAMDISK: [mem 0x1a2ea000-0x3ca98fff]
[    0.011698] ACPI: Early table checksum verification disabled
[    0.011701] ACPI: RSDP 0x000000007A15F000 000024 (v02 INTEL )
[    0.011707] ACPI: XSDT 0x000000007A15F0A8 0000D4 (v01 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011714] ACPI: FACP 0x000000007A19DC00 000114 (v06 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011722] ACPI: DSDT 0x000000007A15F210 03E9F0 (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011727] ACPI: FACS 0x000000007A273080 000040
[    0.011730] ACPI: APIC 0x000000007A19DD18 0000BC (v04 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011735] ACPI: FPDT 0x000000007A19DDD8 000044 (v01 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011739] ACPI: FIDT 0x000000007A19DE20 00009C (v01 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011743] ACPI: MCFG 0x000000007A19DEC0 00003C (v01 INTEL  NUC8i5BE =
0000005F MSFT 00000097)
[    0.011747] ACPI: SSDT 0x000000007A19DF00 001B1C (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011752] ACPI: SSDT 0x000000007A19FA20 0031C6 (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011756] ACPI: HPET 0x000000007A1A2BE8 000038 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011761] ACPI: SSDT 0x000000007A1A2C20 000FAE (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011765] ACPI: SSDT 0x000000007A1A3BD0 003048 (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011769] ACPI: UEFI 0x000000007A1A6C18 000042 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011773] ACPI: LPIT 0x000000007A1A6C60 000094 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011778] ACPI: WDAT 0x000000007A1A6CF8 000134 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011782] ACPI: SSDT 0x000000007A1A6E30 0027DE (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011786] ACPI: SSDT 0x000000007A1A9610 0008B8 (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011790] ACPI: DBGP 0x000000007A1A9EC8 000034 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011795] ACPI: DBG2 0x000000007A1A9F00 000054 (v00 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011799] ACPI: SSDT 0x000000007A1A9F58 000144 (v02 INTEL  NUC8i5BE =
0000005F INTL 20160527)
[    0.011803] ACPI: NHLT 0x000000007A1AA0A0 00002D (v00 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011807] ACPI: TPM2 0x000000007A1AA0D0 000034 (v04 INTEL  NUC8i5BE =
0000005F AMI  00000000)
[    0.011812] ACPI: DMAR 0x000000007A1AA108 0000A8 (v01 INTEL  NUC8i5BE =
0000005F      01000013)
[    0.011816] ACPI: WSMT 0x000000007A1AA1B0 000028 (v01 INTEL  NUC8i5BE =
0000005F AMI  00010013)
[    0.011819] ACPI: Reserving FACP table memory at [mem =
0x7a19dc00-0x7a19dd13]
[    0.011821] ACPI: Reserving DSDT table memory at [mem =
0x7a15f210-0x7a19dbff]
[    0.011823] ACPI: Reserving FACS table memory at [mem =
0x7a273080-0x7a2730bf]
[    0.011824] ACPI: Reserving APIC table memory at [mem =
0x7a19dd18-0x7a19ddd3]
[    0.011825] ACPI: Reserving FPDT table memory at [mem =
0x7a19ddd8-0x7a19de1b]
[    0.011826] ACPI: Reserving FIDT table memory at [mem =
0x7a19de20-0x7a19debb]
[    0.011827] ACPI: Reserving MCFG table memory at [mem =
0x7a19dec0-0x7a19defb]
[    0.011828] ACPI: Reserving SSDT table memory at [mem =
0x7a19df00-0x7a19fa1b]
[    0.011829] ACPI: Reserving SSDT table memory at [mem =
0x7a19fa20-0x7a1a2be5]
[    0.011830] ACPI: Reserving HPET table memory at [mem =
0x7a1a2be8-0x7a1a2c1f]
[    0.011831] ACPI: Reserving SSDT table memory at [mem =
0x7a1a2c20-0x7a1a3bcd]
[    0.011832] ACPI: Reserving SSDT table memory at [mem =
0x7a1a3bd0-0x7a1a6c17]
[    0.011833] ACPI: Reserving UEFI table memory at [mem =
0x7a1a6c18-0x7a1a6c59]
[    0.011834] ACPI: Reserving LPIT table memory at [mem =
0x7a1a6c60-0x7a1a6cf3]
[    0.011836] ACPI: Reserving WDAT table memory at [mem =
0x7a1a6cf8-0x7a1a6e2b]
[    0.011837] ACPI: Reserving SSDT table memory at [mem =
0x7a1a6e30-0x7a1a960d]
[    0.011838] ACPI: Reserving SSDT table memory at [mem =
0x7a1a9610-0x7a1a9ec7]
[    0.011839] ACPI: Reserving DBGP table memory at [mem =
0x7a1a9ec8-0x7a1a9efb]
[    0.011840] ACPI: Reserving DBG2 table memory at [mem =
0x7a1a9f00-0x7a1a9f53]
[    0.011841] ACPI: Reserving SSDT table memory at [mem =
0x7a1a9f58-0x7a1aa09b]
[    0.011842] ACPI: Reserving NHLT table memory at [mem =
0x7a1aa0a0-0x7a1aa0cc]
[    0.011843] ACPI: Reserving TPM2 table memory at [mem =
0x7a1aa0d0-0x7a1aa103]
[    0.011844] ACPI: Reserving DMAR table memory at [mem =
0x7a1aa108-0x7a1aa1af]
[    0.011845] ACPI: Reserving WSMT table memory at [mem =
0x7a1aa1b0-0x7a1aa1d7]
[    0.012106] No NUMA configuration found
[    0.012107] Faking a node at [mem =
0x0000000000000000-0x000000047dffffff]
[    0.012122] NODE_DATA(0) allocated [mem 0x47dfd5680-0x47dffffff]
[    0.012346] Zone ranges:
[    0.012347]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012350]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012352]   Normal   [mem 0x0000000100000000-0x000000047dffffff]
[    0.012353]   Device   empty
[    0.012354] Movable zone start for each node
[    0.012358] Early memory node ranges
[    0.012358]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.012360]   node   0: [mem 0x0000000000100000-0x000000007991afff]
[    0.012362]   node   0: [mem 0x000000007ac0e000-0x000000007ac0efff]
[    0.012363]   node   0: [mem 0x0000000100000000-0x000000047dffffff]
[    0.012366] Initmem setup node 0 [mem =
0x0000000000001000-0x000000047dffffff]
[    0.012372] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.012400] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.015949] On node 0, zone DMA32: 4851 pages in unavailable ranges
[    0.038078] On node 0, zone Normal: 21489 pages in unavailable ranges
[    0.038200] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.038216] Reserving Intel graphics memory at [mem =
0x7c000000-0x7fffffff]
[    0.038479] ACPI: PM-Timer IO Port: 0x1808
[    0.038491] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.038493] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.038494] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.038495] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.038496] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.038497] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.038498] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.038499] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.038552] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI =
0-119
[    0.038556] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.038559] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high =
level)
[    0.038565] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.038567] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.038571] TSC deadline timer available
[    0.038578] CPU topo: Max. logical packages:   1
[    0.038579] CPU topo: Max. logical dies:       1
[    0.038580] CPU topo: Max. dies per package:   1
[    0.038587] CPU topo: Max. threads per core:   2
[    0.038588] CPU topo: Num. cores per package:     4
[    0.038589] CPU topo: Num. threads per package:   8
[    0.038589] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.038605] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.038608] PM: hibernation: Registered nosave memory: [mem =
0x0009f000-0x000fffff]
[    0.038610] PM: hibernation: Registered nosave memory: [mem =
0x7991b000-0x7ac0dfff]
[    0.038612] PM: hibernation: Registered nosave memory: [mem =
0x7ac0f000-0xffffffff]
[    0.038614] [mem 0x80000000-0xfdffffff] available for PCI devices
[    0.038616] Booting paravirtualized kernel on bare hardware
[    0.038618] clocksource: refined-jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.038630] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 =
nr_node_ids:1
[    0.039213] percpu: Embedded 88 pages/cpu s237568 r8192 d114688 =
u524288
[    0.039220] pcpu-alloc: s237568 r8192 d114688 u524288 alloc=3D1*2097152=

[    0.039224] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7
[    0.039248] Kernel command line: BOOT_IMAGE=3D/vmlinuz-6.14.7 =
root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro thunderbolt.dyndbg=3D+p
[    0.039317] Unknown kernel command line parameters =
"BOOT_IMAGE=3D/vmlinuz-6.14.7", will be passed to user space.
[    0.039353] printk: log buffer data + meta data: 262144 + 917504 =3D =
1179648 bytes
[    0.040806] Dentry cache hash table entries: 2097152 (order: 12, =
16777216 bytes, linear)
[    0.041539] Inode-cache hash table entries: 1048576 (order: 11, =
8388608 bytes, linear)
[    0.041710] Fallback order for Node 0: 0
[    0.041714] Built 1 zonelists, mobility grouping on.  Total pages: =
4159674
[    0.041715] Policy zone: Normal
[    0.041723] mem auto-init: stack:all(zero), heap alloc:on, heap =
free:off
[    0.041733] software IO TLB: area num 8.
[    0.097674] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, =
Nodes=3D1
[    0.097710] Kernel/User page tables isolation: enabled
[    0.097754] ftrace: allocating 56719 entries in 222 pages
[    0.135136] ftrace: allocated 222 pages with 6 groups
[    0.136187] Dynamic Preempt: voluntary
[    0.136287] rcu: Preemptible hierarchical RCU implementation.
[    0.136288] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to =
nr_cpu_ids=3D8.
[    0.136290] 	Trampoline variant of Tasks RCU enabled.
[    0.136290] 	Rude variant of Tasks RCU enabled.
[    0.136291] 	Tracing variant of Tasks RCU enabled.
[    0.136292] rcu: RCU calculated value of scheduler-enlistment delay =
is 100 jiffies.
[    0.136293] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D8
[    0.136303] RCU Tasks: Setting shift to 3 and lim to 1 =
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.136305] RCU Tasks Rude: Setting shift to 3 and lim to 1 =
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.136308] RCU Tasks Trace: Setting shift to 3 and lim to 1 =
rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.141634] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.141951] rcu: srcu_init: Setting srcu_struct sizes based on =
contention.
[    0.142260] Console: colour dummy device 80x25
[    0.142263] printk: legacy console [tty0] enabled
[    0.142774] ACPI: Core revision 20240827
[    0.143067] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.143109] APIC: Switch to symmetric I/O mode setup
[    0.143114] DMAR: Host address width 39
[    0.143118] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.143133] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap =
1c0000c40660462 ecap 19e2ff0505e
[    0.143140] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.143147] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap =
d2008c40660462 ecap f050da
[    0.143152] DMAR: RMRR base: 0x0000007a0f1000 end: 0x0000007a110fff
[    0.143158] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
[    0.143163] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.143167] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.143170] DMAR-IR: Queued invalidation will be enabled to support =
x2apic and Intr-remapping.
[    0.145540] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.145545] x2apic enabled
[    0.145642] APIC: Switched APIC routing to: cluster x2apic
[    0.151479] clocksource: tsc-early: mask: 0xffffffffffffffff =
max_cycles: 0x212717146a7, max_idle_ns: 440795291431 ns
[    0.151490] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 4599.93 BogoMIPS (lpj=3D2299968)
[    0.151527] x86/cpu: SGX disabled or unsupported by BIOS.
[    0.151537] CPU0: Thermal monitoring enabled (TM1)
[    0.151613] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.151617] Last level dTLB entries: 4KB 64, 2MB 32, 4MB 32, 1GB 4
[    0.151625] process: using mwait in idle threads
[    0.151631] Spectre V1 : Mitigation: usercopy/swapgs barriers and =
__user pointer sanitization
[    0.151637] Spectre V2 : Mitigation: IBRS
[    0.151640] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on =
context switch and VMEXIT
[    0.151645] RETBleed: Mitigation: IBRS
[    0.151649] Spectre V2 : mitigation: Enabling conditional Indirect =
Branch Prediction Barrier
[    0.151654] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.151658] Speculative Store Bypass: Mitigation: Speculative Store =
Bypass disabled via prctl
[    0.151669] MDS: Mitigation: Clear CPU buffers
[    0.151672] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.151679] SRBDS: Mitigation: Microcode
[    0.151689] GDS: Mitigation: Microcode
[    0.151697] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
[    0.151705] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.151711] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.151716] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds =
registers'
[    0.151722] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.151728] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.151735] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.151741] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.151747] x86/fpu: Enabled xstate features 0x1f, context size is =
960 bytes, using 'compacted' format.
[    0.152487] Freeing SMP alternatives memory: 48K
[    0.152487] pid_max: default: 32768 minimum: 301
[    0.152487] LSM: initializing =
lsm=3Dlockdown,capability,landlock,yama,apparmor,ima,evm
[    0.152487] landlock: Up and running.
[    0.152487] Yama: becoming mindful.
[    0.152487] AppArmor: AppArmor initialized
[    0.152487] Mount-cache hash table entries: 32768 (order: 6, 262144 =
bytes, linear)
[    0.152487] Mountpoint-cache hash table entries: 32768 (order: 6, =
262144 bytes, linear)
[    0.152487] smpboot: CPU0: Intel(R) Core(TM) i5-8259U CPU @ 2.30GHz =
(family: 0x6, model: 0x8e, stepping: 0xa)
[    0.152487] Performance Events: PEBS fmt3+, Skylake events, 32-deep =
LBR, full-width counters, Intel PMU driver.
[    0.152487] ... version:                4
[    0.152487] ... bit width:              48
[    0.152487] ... generic registers:      4
[    0.152487] ... value mask:             0000ffffffffffff
[    0.152487] ... max period:             00007fffffffffff
[    0.152487] ... fixed-purpose events:   3
[    0.152487] ... event mask:             000000070000000f
[    0.152487] signal: max sigframe size: 2032
[    0.152487] Estimated ratio of average max frequency by base =
frequency (times 1024): 1602
[    0.154011] rcu: Hierarchical SRCU implementation.
[    0.154016] rcu: 	Max phase no-delay instances is 400.
[    0.154090] Timer migration: 1 hierarchy levels; 8 children per =
group; 1 crossnode level
[    0.156114] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
[    0.156231] smp: Bringing up secondary CPUs ...
[    0.159568] smpboot: x86: Booting SMP configuration:
[    0.159574] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.169666] MDS CPU bug present and SMT on, data leak possible. See =
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for =
more details.
[    0.169666] MMIO Stale Data CPU bug present and SMT on, data leak =
possible. See =
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_=
stale_data.html for more details.
[    0.170550] smp: Brought up 1 node, 8 CPUs
[    0.170550] smpboot: Total of 8 processors activated (36799.48 =
BogoMIPS)
[    0.171621] Memory: 15649548K/16638696K available (21154K kernel =
code, 4604K rwdata, 8472K rodata, 5024K init, 4516K bss, 968880K =
reserved, 0K cma-reserved)
[    0.172157] devtmpfs: initialized
[    0.172157] x86/mm: Memory block size: 128MB
[    0.174935] ACPI: PM: Registering ACPI NVS region [mem =
0x7a1c3000-0x7a273fff] (724992 bytes)
[    0.174935] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.174935] futex hash table entries: 2048 (order: 5, 131072 bytes, =
linear)
[    0.174935] pinctrl core: initialized pinctrl subsystem
[    0.175493] PM: RTC time: 14:55:39, date: 2025-05-23
[    0.176206] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.176581] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic =
allocations
[    0.176736] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for =
atomic allocations
[    0.176895] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for =
atomic allocations
[    0.176926] audit: initializing netlink subsys (disabled)
[    0.176968] audit: type=3D2000 audit(1748012139.025:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.176968] thermal_sys: Registered thermal governor 'fair_share'
[    0.176968] thermal_sys: Registered thermal governor 'bang_bang'
[    0.176968] thermal_sys: Registered thermal governor 'step_wise'
[    0.176968] thermal_sys: Registered thermal governor 'user_space'
[    0.176968] thermal_sys: Registered thermal governor =
'power_allocator'
[    0.176968] cpuidle: using governor ladder
[    0.176968] cpuidle: using governor menu
[    0.176968] ACPI FADT declares the system doesn't support PCIe ASPM, =
so disable it
[    0.176968] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.177571] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) =
for domain 0000 [bus 00-ff]
[    0.177594] PCI: Using configuration type 1 for base access
[    0.177788] kprobes: kprobe jump-optimization is enabled. All kprobes =
are optimized if possible.
[    0.177803] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 =
pages
[    0.177803] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB =
page
[    0.177803] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 =
pages
[    0.177803] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.179156] fbcon: Taking over console
[    0.179209] ACPI: Added _OSI(Module Device)
[    0.179216] ACPI: Added _OSI(Processor Device)
[    0.179222] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.179228] ACPI: Added _OSI(Processor Aggregator Device)
[    0.304933] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.373297] ACPI: Dynamic OEM Table Load:
[    0.373313] ACPI: SSDT 0xFFFF94CD81582C00 000400 (v02 PmRef  Cpu0Cst  =
00003001 INTL 20160527)
[    0.375937] ACPI: Dynamic OEM Table Load:
[    0.375950] ACPI: SSDT 0xFFFF94CD8222B800 0005A2 (v02 PmRef  Cpu0Ist  =
00003000 INTL 20160527)
[    0.378654] ACPI: Dynamic OEM Table Load:
[    0.378665] ACPI: SSDT 0xFFFF94CD8159AB00 0000F4 (v02 PmRef  Cpu0Psd  =
00003000 INTL 20160527)
[    0.381695] ACPI: Dynamic OEM Table Load:
[    0.381708] ACPI: SSDT 0xFFFF94CD8222F800 0005FC (v02 PmRef  ApIst    =
00003000 INTL 20160527)
[    0.384424] ACPI: Dynamic OEM Table Load:
[    0.384440] ACPI: SSDT 0xFFFF94CD81583800 000317 (v02 PmRef  ApHwp    =
00003000 INTL 20160527)
[    0.387214] ACPI: Dynamic OEM Table Load:
[    0.387227] ACPI: SSDT 0xFFFF94CD82243000 000AB0 (v02 PmRef  ApPsd    =
00003000 INTL 20160527)
[    0.391099] ACPI: Dynamic OEM Table Load:
[    0.391111] ACPI: SSDT 0xFFFF94CD81585400 00030A (v02 PmRef  ApCst    =
00003000 INTL 20160527)
[    0.399763] ACPI: EC: EC started
[    0.399769] ACPI: EC: interrupt blocked
[    0.401445] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.401452] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC used to handle =
transactions
[    0.401458] ACPI: Interpreter enabled
[    0.402489] ACPI: PM: (supports S0 S3 S4 S5)
[    0.402489] ACPI: Using IOAPIC for interrupt routing
[    0.404866] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.404874] PCI: Ignoring E820 reservations for host bridge windows
[    0.407371] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.435839] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.442228] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.442987] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.443736] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.466209] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.475236] ACPI: \_TZ_.FN00: New power resource
[    0.475392] ACPI: \_TZ_.FN01: New power resource
[    0.475561] ACPI: \_TZ_.FN02: New power resource
[    0.475721] ACPI: \_TZ_.FN03: New power resource
[    0.475868] ACPI: \_TZ_.FN04: New power resource
[    0.477156] ACPI: \PIN_: New power resource
[    0.478808] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.478823] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI EDR HPX-Type3]
[    0.480327] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.483286] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug =
SHPCHotplug PME PCIeCapability LTR DPC]
[    0.483295] acpi PNP0A08:00: FADT indicates ASPM is unsupported, =
using BIOS configuration
[    0.485314] PCI host bridge to bus 0000:00
[    0.485324] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 =
window]
[    0.485331] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff =
window]
[    0.485338] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000bffff window]
[    0.485345] pci_bus 0000:00: root bus resource [mem =
0x000e0000-0x000effff window]
[    0.485351] pci_bus 0000:00: root bus resource [mem =
0x80000000-0xdfffffff window]
[    0.485358] pci_bus 0000:00: root bus resource [mem =
0x4000000000-0x7fffffffff window]
[    0.485364] pci_bus 0000:00: root bus resource [mem =
0xfc800000-0xfe7fffff window]
[    0.485371] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.485520] pci 0000:00:00.0: [8086:3ed0] type 00 class 0x060000 =
conventional PCI endpoint
[    0.485653] pci 0000:00:02.0: [8086:3ea5] type 00 class 0x030000 PCIe =
Root Complex Integrated Endpoint
[    0.485683] pci 0000:00:02.0: BAR 0 [mem 0xa7000000-0xa7ffffff 64bit]
[    0.485690] pci 0000:00:02.0: BAR 2 [mem 0x80000000-0x8fffffff 64bit =
pref]
[    0.485697] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.485719] pci 0000:00:02.0: Video device with shadowed ROM at [mem =
0x000c0000-0x000dffff]
[    0.486058] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000 =
conventional PCI endpoint
[    0.486091] pci 0000:00:08.0: BAR 0 [mem 0x4022c1a000-0x4022c1afff =
64bit]
[    0.486242] pci 0000:00:12.0: [8086:9df9] type 00 class 0x118000 =
conventional PCI endpoint
[    0.486298] pci 0000:00:12.0: BAR 0 [mem 0x4022c19000-0x4022c19fff =
64bit]
[    0.486457] pci 0000:00:14.0: [8086:9ded] type 00 class 0x0c0330 =
conventional PCI endpoint
[    0.486504] pci 0000:00:14.0: BAR 0 [mem 0x4022c00000-0x4022c0ffff =
64bit]
[    0.486557] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.489439] pci 0000:00:14.2: [8086:9def] type 00 class 0x050000 =
conventional PCI endpoint
[    0.489494] pci 0000:00:14.2: BAR 0 [mem 0x4022c14000-0x4022c15fff =
64bit]
[    0.489503] pci 0000:00:14.2: BAR 2 [mem 0x4022c18000-0x4022c18fff =
64bit]
[    0.490347] pci 0000:00:14.3: [8086:9df0] type 00 class 0x028000 PCIe =
Root Complex Integrated Endpoint
[    0.492613] pci 0000:00:14.3: BAR 0 [mem 0x4022c10000-0x4022c13fff =
64bit]
[    0.495996] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.497431] pci 0000:00:16.0: [8086:9de0] type 00 class 0x078000 =
conventional PCI endpoint
[    0.497494] pci 0000:00:16.0: BAR 0 [mem 0x4022c17000-0x4022c17fff =
64bit]
[    0.497563] pci 0000:00:16.0: PME# supported from D3hot
[    0.498395] pci 0000:00:17.0: [8086:9dd3] type 00 class 0x010601 =
conventional PCI endpoint
[    0.498443] pci 0000:00:17.0: BAR 0 [mem 0xa8a24000-0xa8a25fff]
[    0.498449] pci 0000:00:17.0: BAR 1 [mem 0xa8a27000-0xa8a270ff]
[    0.498456] pci 0000:00:17.0: BAR 2 [io  0x4090-0x4097]
[    0.498462] pci 0000:00:17.0: BAR 3 [io  0x4080-0x4083]
[    0.498468] pci 0000:00:17.0: BAR 4 [io  0x4060-0x407f]
[    0.498474] pci 0000:00:17.0: BAR 5 [mem 0xa8a26000-0xa8a267ff]
[    0.498527] pci 0000:00:17.0: PME# supported from D3hot
[    0.499215] pci 0000:00:1c.0: [8086:9db8] type 01 class 0x060400 PCIe =
Root Port
[    0.499248] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.499337] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.500681] pci 0000:00:1c.4: [8086:9dbc] type 01 class 0x060400 PCIe =
Root Port
[    0.500711] pci 0000:00:1c.4: PCI bridge to [bus 02-3a]
[    0.500721] pci 0000:00:1c.4:   bridge window [mem =
0x90000000-0xa60fffff]
[    0.500735] pci 0000:00:1c.4:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.500809] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.500841] pci 0000:00:1c.4: PTM enabled (root), 4ns granularity
[    0.502166] pci 0000:00:1d.0: [8086:9db0] type 01 class 0x060400 PCIe =
Root Port
[    0.502200] pci 0000:00:1d.0: PCI bridge to [bus 3b]
[    0.502291] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.503623] pci 0000:00:1d.6: [8086:9db6] type 01 class 0x060400 PCIe =
Root Port
[    0.503655] pci 0000:00:1d.6: PCI bridge to [bus 3c]
[    0.503663] pci 0000:00:1d.6:   bridge window [io  0x3000-0x3fff]
[    0.503670] pci 0000:00:1d.6:   bridge window [mem =
0xa8000000-0xa89fffff]
[    0.503684] pci 0000:00:1d.6:   bridge window [mem =
0x4022100000-0x4022afffff 64bit pref]
[    0.503765] pci 0000:00:1d.6: PME# supported from D0 D3hot D3cold
[    0.503803] pci 0000:00:1d.6: PTM enabled (root), 4ns granularity
[    0.505113] pci 0000:00:1f.0: [8086:9d84] type 00 class 0x060100 =
conventional PCI endpoint
[    0.505773] pci 0000:00:1f.3: [8086:9dc8] type 00 class 0x040380 =
conventional PCI endpoint
[    0.505909] pci 0000:00:1f.3: BAR 0 [mem 0xa8a20000-0xa8a23fff 64bit]
[    0.505928] pci 0000:00:1f.3: BAR 4 [mem 0x4022b00000-0x4022bfffff =
64bit]
[    0.506050] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.512723] pci 0000:00:1f.4: [8086:9da3] type 00 class 0x0c0500 =
conventional PCI endpoint
[    0.512785] pci 0000:00:1f.4: BAR 0 [mem 0x4022c16000-0x4022c160ff =
64bit]
[    0.512801] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.513247] pci 0000:00:1f.5: [8086:9da4] type 00 class 0x0c8000 =
conventional PCI endpoint
[    0.513306] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.513425] pci 0000:00:1f.6: [8086:15be] type 00 class 0x020000 =
conventional PCI endpoint
[    0.513562] pci 0000:00:1f.6: BAR 0 [mem 0xa8a00000-0xa8a1ffff]
[    0.513676] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.513986] acpiphp: Slot [1] registered
[    0.513998] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.514208] pci 0000:02:00.0: [8086:15da] type 01 class 0x060400 PCIe =
Switch Upstream Port
[    0.514251] pci 0000:02:00.0: PCI bridge to [bus 03-3a]
[    0.514265] pci 0000:02:00.0:   bridge window [mem =
0x90000000-0xa60fffff]
[    0.514282] pci 0000:02:00.0:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.514303] pci 0000:02:00.0: enabling Extended Tags
[    0.514410] pci 0000:02:00.0: supports D1 D2
[    0.514414] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.514685] pci 0000:00:1c.4: PCI bridge to [bus 02-3a]
[    0.514791] pci 0000:03:00.0: [8086:15da] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.514831] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.514845] pci 0000:03:00.0:   bridge window [mem =
0xa6000000-0xa60fffff]
[    0.514878] pci 0000:03:00.0: enabling Extended Tags
[    0.514990] pci 0000:03:00.0: supports D1 D2
[    0.514995] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.515203] pci 0000:03:01.0: [8086:15da] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.515242] pci 0000:03:01.0: PCI bridge to [bus 05-39]
[    0.515256] pci 0000:03:01.0:   bridge window [mem =
0x90000000-0xa5efffff]
[    0.515274] pci 0000:03:01.0:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.515296] pci 0000:03:01.0: enabling Extended Tags
[    0.515414] pci 0000:03:01.0: supports D1 D2
[    0.515418] pci 0000:03:01.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.515640] pci 0000:03:02.0: [8086:15da] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.515680] pci 0000:03:02.0: PCI bridge to [bus 3a]
[    0.515694] pci 0000:03:02.0:   bridge window [mem =
0xa5f00000-0xa5ffffff]
[    0.515727] pci 0000:03:02.0: enabling Extended Tags
[    0.515837] pci 0000:03:02.0: supports D1 D2
[    0.515841] pci 0000:03:02.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.516096] pci 0000:02:00.0: PCI bridge to [bus 03-3a]
[    0.516194] pci 0000:04:00.0: [8086:15d9] type 00 class 0x088000 PCIe =
Endpoint
[    0.516261] pci 0000:04:00.0: BAR 0 [mem 0xa6000000-0xa603ffff]
[    0.516268] pci 0000:04:00.0: BAR 1 [mem 0xa6040000-0xa6040fff]
[    0.516291] pci 0000:04:00.0: enabling Extended Tags
[    0.516419] pci 0000:04:00.0: supports D1 D2
[    0.516423] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.516668] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.516738] pci 0000:03:01.0: PCI bridge to [bus 05-39]
[    0.516861] pci 0000:3a:00.0: [8086:15db] type 00 class 0x0c0330 PCIe =
Endpoint
[    0.516932] pci 0000:3a:00.0: BAR 0 [mem 0xa5f00000-0xa5f0ffff]
[    0.516958] pci 0000:3a:00.0: enabling Extended Tags
[    0.517095] pci 0000:3a:00.0: supports D1 D2
[    0.517100] pci 0000:3a:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.517409] pci 0000:03:02.0: PCI bridge to [bus 3a]
[    0.517644] pci 0000:00:1d.0: PCI bridge to [bus 3b]
[    0.517922] pci 0000:3c:00.0: [10ec:522a] type 00 class 0xff0000 PCIe =
Endpoint
[    0.518054] pci 0000:3c:00.0: BAR 0 [mem 0xa8000000-0xa8000fff]
[    0.518163] pci 0000:3c:00.0: supports D1 D2
[    0.518168] pci 0000:3c:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.518564] pci 0000:00:1d.6: ASPM: current common clock =
configuration is inconsistent, reconfiguring
[    0.520597] pci 0000:00:1d.6: PCI bridge to [bus 3c]
[    0.524271] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.524426] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.524580] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.524730] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.524880] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.525029] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.525178] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.525327] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.534167] ACPI: EC: interrupt unblocked
[    0.534173] ACPI: EC: event unblocked
[    0.534191] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.534196] ACPI: EC: GPE=3D0x14
[    0.534201] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC initialization =
complete
[    0.534208] ACPI: \_SB_.PCI0.LPCB.H_EC: EC: Used to handle =
transactions and events
[    0.534518] iommu: Default domain type: Translated
[    0.534518] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.534703] SCSI subsystem initialized
[    0.534725] libata version 3.00 loaded.
[    0.534725] ACPI: bus type USB registered
[    0.534725] usbcore: registered new interface driver usbfs
[    0.534725] usbcore: registered new interface driver hub
[    0.534725] usbcore: registered new device driver usb
[    0.534725] pps_core: LinuxPPS API ver. 1 registered
[    0.534725] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.534725] PTP clock support registered
[    0.534725] EDAC MC: Ver: 3.0.0
[    0.535563] efivars: Registered efivars operations
[    0.535863] NetLabel: Initializing
[    0.535868] NetLabel:  domain hash size =3D 128
[    0.535873] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.535905] NetLabel:  unlabeled traffic allowed by default
[    0.535937] mctp: management component transport protocol core
[    0.535937] NET: Registered PF_MCTP protocol family
[    0.535937] PCI: Using ACPI for IRQ routing
[    0.571564] PCI: pci_cache_line_size set to 64 bytes
[    0.571907] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.571910] e820: reserve RAM buffer [mem 0x6d525018-0x6fffffff]
[    0.571912] e820: reserve RAM buffer [mem 0x7991b000-0x7bffffff]
[    0.571915] e820: reserve RAM buffer [mem 0x7ac0f000-0x7bffffff]
[    0.571916] e820: reserve RAM buffer [mem 0x47e000000-0x47fffffff]
[    0.571973] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.571973] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.571973] pci 0000:00:02.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.571973] vgaarb: loaded
[    0.571973] clocksource: Switched to clocksource tsc-early
[    0.572586] VFS: Disk quotas dquot_6.6.0
[    0.572606] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
[    0.572797] AppArmor: AppArmor Filesystem Enabled
[    0.572843] pnp: PnP ACPI init
[    0.573008] system 00:00: [mem 0x40000000-0x403fffff] could not be =
reserved
[    0.573673] system 00:01: [io  0x0a00-0x0a1f] has been reserved
[    0.573681] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.573687] system 00:01: [io  0x0a30-0x0a3f] has been reserved
[    0.573693] system 00:01: [io  0x0a40-0x0a4f] has been reserved
[    0.573699] system 00:01: [io  0x0a50-0x0a5f] has been reserved
[    0.573704] system 00:01: [io  0x0a60-0x0a6f] has been reserved
[    0.574089] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.574097] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.574299] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.574688] system 00:04: [mem 0xfed10000-0xfed17fff] has been =
reserved
[    0.574696] system 00:04: [mem 0xfed18000-0xfed18fff] has been =
reserved
[    0.574702] system 00:04: [mem 0xfed19000-0xfed19fff] has been =
reserved
[    0.574708] system 00:04: [mem 0xe0000000-0xefffffff] has been =
reserved
[    0.574715] system 00:04: [mem 0xfed20000-0xfed3ffff] has been =
reserved
[    0.574721] system 00:04: [mem 0xfed90000-0xfed93fff] could not be =
reserved
[    0.574727] system 00:04: [mem 0xfed45000-0xfed8ffff] has been =
reserved
[    0.574733] system 00:04: [mem 0xfee00000-0xfeefffff] could not be =
reserved
[    0.575114] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.575122] system 00:05: [mem 0xfd000000-0xfd69ffff] has been =
reserved
[    0.575128] system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been =
reserved
[    0.575134] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been =
reserved
[    0.575140] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be =
reserved
[    0.575146] system 00:05: [mem 0xfe200000-0xfe7fffff] has been =
reserved
[    0.575152] system 00:05: [mem 0xff000000-0xffffffff] has been =
reserved
[    0.575676] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.579219] pnp: PnP ACPI: found 8 devices
[    0.585789] clocksource: acpi_pm: mask: 0xffffff max_cycles: =
0xffffff, max_idle_ns: 2085701024 ns
[    0.585896] NET: Registered PF_INET protocol family
[    0.586072] IP idents hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
[    0.589905] tcp_listen_portaddr_hash hash table entries: 8192 (order: =
5, 131072 bytes, linear)
[    0.589945] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
[    0.590043] TCP established hash table entries: 131072 (order: 8, =
1048576 bytes, linear)
[    0.590322] TCP bind hash table entries: 65536 (order: 9, 2097152 =
bytes, linear)
[    0.590627] TCP: Hash tables configured (established 131072 bind =
65536)
[    0.590734] MPTCP token hash table entries: 16384 (order: 6, 393216 =
bytes, linear)
[    0.590817] UDP hash table entries: 8192 (order: 7, 524288 bytes, =
linear)
[    0.590924] UDP-Lite hash table entries: 8192 (order: 7, 524288 =
bytes, linear)
[    0.591045] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.591063] NET: Registered PF_XDP protocol family
[    0.591080] pci 0000:03:01.0: bridge window [io  0x1000-0x0fff] to =
[bus 05-39] add_size 1000
[    0.591092] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to =
[bus 03-3a] add_size 1000
[    0.591100] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to =
[bus 02-3a] add_size 2000
[    0.591108] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to =
[bus 3b] add_size 1000
[    0.591115] pci 0000:00:1d.0: bridge window [mem =
0x00100000-0x000fffff 64bit pref] to [bus 3b] add_size 200000 add_align =
100000
[    0.591126] pci 0000:00:1d.0: bridge window [mem =
0x00100000-0x000fffff] to [bus 3b] add_size 200000 add_align 100000
[    0.591145] pci 0000:00:1d.0: bridge window [mem =
0xa6100000-0xa62fffff]: assigned
[    0.591154] pci 0000:00:1d.0: bridge window [mem =
0x4022d00000-0x4022efffff 64bit pref]: assigned
[    0.591164] pci 0000:00:1c.4: bridge window [io  0x5000-0x6fff]: =
assigned
[    0.591171] pci 0000:00:1d.0: bridge window [io  0x7000-0x7fff]: =
assigned
[    0.591179] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.591197] pci 0000:02:00.0: bridge window [io  0x5000-0x5fff]: =
assigned
[    0.591204] pci 0000:03:01.0: bridge window [io  0x5000-0x5fff]: =
assigned
[    0.591211] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.591221] pci 0000:03:00.0:   bridge window [mem =
0xa6000000-0xa60fffff]
[    0.591235] pci 0000:03:01.0: PCI bridge to [bus 05-39]
[    0.591242] pci 0000:03:01.0:   bridge window [io  0x5000-0x5fff]
[    0.591251] pci 0000:03:01.0:   bridge window [mem =
0x90000000-0xa5efffff]
[    0.591259] pci 0000:03:01.0:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591272] pci 0000:03:02.0: PCI bridge to [bus 3a]
[    0.591281] pci 0000:03:02.0:   bridge window [mem =
0xa5f00000-0xa5ffffff]
[    0.591294] pci 0000:02:00.0: PCI bridge to [bus 03-3a]
[    0.591301] pci 0000:02:00.0:   bridge window [io  0x5000-0x5fff]
[    0.591314] pci 0000:02:00.0:   bridge window [mem =
0x90000000-0xa60fffff]
[    0.591326] pci 0000:02:00.0:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591338] pci 0000:00:1c.4: PCI bridge to [bus 02-3a]
[    0.591343] pci 0000:00:1c.4:   bridge window [io  0x5000-0x6fff]
[    0.591351] pci 0000:00:1c.4:   bridge window [mem =
0x90000000-0xa60fffff]
[    0.591359] pci 0000:00:1c.4:   bridge window [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591369] pci 0000:00:1d.0: PCI bridge to [bus 3b]
[    0.591376] pci 0000:00:1d.0:   bridge window [io  0x7000-0x7fff]
[    0.591384] pci 0000:00:1d.0:   bridge window [mem =
0xa6100000-0xa62fffff]
[    0.591398] pci 0000:00:1d.0:   bridge window [mem =
0x4022d00000-0x4022efffff 64bit pref]
[    0.591413] pci 0000:00:1d.6: PCI bridge to [bus 3c]
[    0.591419] pci 0000:00:1d.6:   bridge window [io  0x3000-0x3fff]
[    0.591427] pci 0000:00:1d.6:   bridge window [mem =
0xa8000000-0xa89fffff]
[    0.591434] pci 0000:00:1d.6:   bridge window [mem =
0x4022100000-0x4022afffff 64bit pref]
[    0.591446] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.591452] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.591458] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff =
window]
[    0.591464] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff =
window]
[    0.591470] pci_bus 0000:00: resource 8 [mem 0x80000000-0xdfffffff =
window]
[    0.591476] pci_bus 0000:00: resource 9 [mem =
0x4000000000-0x7fffffffff window]
[    0.591482] pci_bus 0000:00: resource 10 [mem 0xfc800000-0xfe7fffff =
window]
[    0.591489] pci_bus 0000:02: resource 0 [io  0x5000-0x6fff]
[    0.591494] pci_bus 0000:02: resource 1 [mem 0x90000000-0xa60fffff]
[    0.591500] pci_bus 0000:02: resource 2 [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591507] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.591512] pci_bus 0000:03: resource 1 [mem 0x90000000-0xa60fffff]
[    0.591517] pci_bus 0000:03: resource 2 [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591524] pci_bus 0000:04: resource 1 [mem 0xa6000000-0xa60fffff]
[    0.591529] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
[    0.591534] pci_bus 0000:05: resource 1 [mem 0x90000000-0xa5efffff]
[    0.591540] pci_bus 0000:05: resource 2 [mem =
0x4000000000-0x4021ffffff 64bit pref]
[    0.591546] pci_bus 0000:3a: resource 1 [mem 0xa5f00000-0xa5ffffff]
[    0.591552] pci_bus 0000:3b: resource 0 [io  0x7000-0x7fff]
[    0.591557] pci_bus 0000:3b: resource 1 [mem 0xa6100000-0xa62fffff]
[    0.591563] pci_bus 0000:3b: resource 2 [mem =
0x4022d00000-0x4022efffff 64bit pref]
[    0.591569] pci_bus 0000:3c: resource 0 [io  0x3000-0x3fff]
[    0.591574] pci_bus 0000:3c: resource 1 [mem 0xa8000000-0xa89fffff]
[    0.591579] pci_bus 0000:3c: resource 2 [mem =
0x4022100000-0x4022afffff 64bit pref]
[    0.592439] pci 0000:02:00.0: CLS mismatch (64 !=3D 128), using 64 =
bytes
[    0.592629] pci 0000:02:00.0: enabling device (0002 -> 0003)
[    0.592986] DMAR: No ATSR found
[    0.592991] DMAR: No SATC found
[    0.592994] DMAR: dmar0: Using Queued invalidation
[    0.593002] DMAR: dmar1: Using Queued invalidation
[    0.593034] Trying to unpack rootfs image as initramfs...
[    0.593352] pci 0000:00:02.0: Adding to iommu group 0
[    0.594200] pci 0000:00:00.0: Adding to iommu group 1
[    0.594219] pci 0000:00:08.0: Adding to iommu group 2
[    0.594243] pci 0000:00:12.0: Adding to iommu group 3
[    0.594273] pci 0000:00:14.0: Adding to iommu group 4
[    0.594290] pci 0000:00:14.2: Adding to iommu group 4
[    0.594308] pci 0000:00:14.3: Adding to iommu group 5
[    0.594335] pci 0000:00:16.0: Adding to iommu group 6
[    0.594352] pci 0000:00:17.0: Adding to iommu group 7
[    0.594380] pci 0000:00:1c.0: Adding to iommu group 8
[    0.594401] pci 0000:00:1c.4: Adding to iommu group 9
[    0.594427] pci 0000:00:1d.0: Adding to iommu group 10
[    0.594448] pci 0000:00:1d.6: Adding to iommu group 11
[    0.594496] pci 0000:00:1f.0: Adding to iommu group 12
[    0.594515] pci 0000:00:1f.3: Adding to iommu group 12
[    0.594533] pci 0000:00:1f.4: Adding to iommu group 12
[    0.594551] pci 0000:00:1f.5: Adding to iommu group 12
[    0.594568] pci 0000:00:1f.6: Adding to iommu group 12
[    0.594588] pci 0000:02:00.0: Adding to iommu group 13
[    0.594610] pci 0000:03:00.0: Adding to iommu group 14
[    0.594630] pci 0000:03:01.0: Adding to iommu group 15
[    0.594650] pci 0000:03:02.0: Adding to iommu group 16
[    0.594659] pci 0000:04:00.0: Adding to iommu group 14
[    0.594669] pci 0000:3a:00.0: Adding to iommu group 16
[    0.594689] pci 0000:3c:00.0: Adding to iommu group 17
[    0.596363] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.596372] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.596377] software IO TLB: mapped [mem =
0x00000000738e7000-0x00000000778e7000] (64MB)
[    0.600434] platform rtc_cmos: registered platform RTC device (no PNP =
device found)
[    0.601181] Initialise system trusted keyrings
[    0.601196] Key type blacklist registered
[    0.601252] workingset: timestamp_bits=3D36 max_order=3D22 =
bucket_order=3D0
[    0.601276] zbud: loaded
[    0.601657] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.601825] fuse: init (API version 7.42)
[    0.602057] integrity: Platform Keyring initialized
[    0.602071] integrity: Machine keyring initialized
[    0.628775] Key type asymmetric registered
[    0.628787] Asymmetric key parser 'x509' registered
[    0.628826] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 243)
[    0.628902] io scheduler mq-deadline registered
[    0.633465] ledtrig-cpu: registered to indicate activity on CPUs
[    0.633639] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.633832] pcieport 0000:00:1c.4: PME: Signaling with IRQ 124
[    0.633870] pcieport 0000:00:1c.4: pciehp: Slot #8 AttnBtn- PwrCtrl- =
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- =
LLActRep+
[    0.634111] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.634150] pcieport 0000:00:1d.0: pciehp: Slot #0 AttnBtn- PwrCtrl- =
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- =
LLActRep+
[    0.634602] pcieport 0000:00:1d.6: PME: Signaling with IRQ 126
[    0.634637] pcieport 0000:00:1d.6: pciehp: Slot #18 AttnBtn- PwrCtrl- =
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- =
LLActRep+
[    0.635128] pcieport 0000:03:01.0: enabling device (0002 -> 0003)
[    0.635287] pcieport 0000:03:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- =
MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- =
LLActRep+
[    0.635589] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
[    0.636837] input: Sleep Button as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.636880] ACPI: button: Sleep Button [SLPB]
[    0.636928] input: Power Button as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.636957] ACPI: button: Power Button [PWRB]
[    0.637003] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.637141] ACPI: button: Power Button [PWRF]
[    0.638520] ACPI: thermal: [Firmware Bug]: No valid trip points!
[    0.638597] thermal LNXTHERM:00: registered as thermal_zone0
[    0.638604] ACPI: thermal: Thermal Zone [TZ0] (-263 C)
[    0.639288] thermal LNXTHERM:01: registered as thermal_zone1
[    0.639295] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.639699] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.643244] hpet_acpi_add: no address or irqs in _CRS
[    0.643287] Linux agpgart interface v0.103
[    0.778277] ACPI: bus type drm_connector registered
[    0.781812] loop: module loaded
[    0.782344] tun: Universal TUN/TAP device driver, 1.6
[    0.782433] PPP generic driver version 2.4.2
[    0.782887] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.782899] xhci_hcd 0000:00:14.0: new USB bus registered, assigned =
bus number 1
[    0.784066] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version =
0x110 quirks 0x0000000000009810
[    0.784435] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.784443] xhci_hcd 0000:00:14.0: new USB bus registered, assigned =
bus number 2
[    0.784452] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    0.784511] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.14
[    0.784519] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.784526] usb usb1: Product: xHCI Host Controller
[    0.784531] usb usb1: Manufacturer: Linux 6.14.7 xhci-hcd
[    0.784536] usb usb1: SerialNumber: 0000:00:14.0
[    0.784763] hub 1-0:1.0: USB hub found
[    0.784790] hub 1-0:1.0: 12 ports detected
[    0.788090] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.14
[    0.788100] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.788107] usb usb2: Product: xHCI Host Controller
[    0.788112] usb usb2: Manufacturer: Linux 6.14.7 xhci-hcd
[    0.788117] usb usb2: SerialNumber: 0000:00:14.0
[    0.788287] hub 2-0:1.0: USB hub found
[    0.788306] hub 2-0:1.0: 6 ports detected
[    0.790212] xhci_hcd 0000:3a:00.0: xHCI Host Controller
[    0.790223] xhci_hcd 0000:3a:00.0: new USB bus registered, assigned =
bus number 3
[    0.791431] xhci_hcd 0000:3a:00.0: hcc params 0x200077c1 hci version =
0x110 quirks 0x0000000200009810
[    0.791828] xhci_hcd 0000:3a:00.0: xHCI Host Controller
[    0.791836] xhci_hcd 0000:3a:00.0: new USB bus registered, assigned =
bus number 4
[    0.791844] xhci_hcd 0000:3a:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    0.791895] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.14
[    0.791903] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.791909] usb usb3: Product: xHCI Host Controller
[    0.791914] usb usb3: Manufacturer: Linux 6.14.7 xhci-hcd
[    0.791919] usb usb3: SerialNumber: 0000:3a:00.0
[    0.792091] hub 3-0:1.0: USB hub found
[    0.792106] hub 3-0:1.0: 2 ports detected
[    0.792696] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.14
[    0.792705] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    0.792712] usb usb4: Product: xHCI Host Controller
[    0.792717] usb usb4: Manufacturer: Linux 6.14.7 xhci-hcd
[    0.792722] usb usb4: SerialNumber: 0000:3a:00.0
[    0.792890] hub 4-0:1.0: USB hub found
[    0.792905] hub 4-0:1.0: 2 ports detected
[    0.793544] i8042: PNP: No PS/2 controller found.
[    0.793550] i8042: Probing ports directly.
[    0.794695] i8042: No controller found
[    0.794870] mousedev: PS/2 mouse device common for all mice
[    0.795184] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.796432] rtc_cmos rtc_cmos: registered as rtc0
[    0.796665] rtc_cmos rtc_cmos: setting system clock to =
2025-05-23T14:55:39 UTC (1748012139)
[    0.796710] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes =
nvram
[    0.796728] i2c_dev: i2c /dev entries driver
[    0.797158] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is =
disabled. Duplicate IMA measurements will not be recorded in the IMA =
log.
[    0.797186] device-mapper: uevent: version 1.0.3
[    0.797276] device-mapper: ioctl: 4.49.0-ioctl (2025-01-17) =
initialised: dm-devel@lists.linux.dev
[    0.797288] intel_pstate: Intel P-state driver initializing
[    0.797810] intel_pstate: HWP enabled
[    0.797868] drop_monitor: Initializing network drop monitor service
[    0.797960] NET: Registered PF_INET6 protocol family
[    1.024357] usb 1-10: new full-speed USB device number 2 using =
xhci_hcd
[    1.148781] usb 1-10: New USB device found, idVendor=3D8087, =
idProduct=3D0aaa, bcdDevice=3D 0.02
[    1.148791] usb 1-10: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
[    1.655367] tsc: Refined TSC clocksource calibration: 2303.998 MHz
[    1.655380] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x2135f5e6f15, max_idle_ns: 440795231538 ns
[    1.655437] clocksource: Switched to clocksource tsc
[    3.541930] Freeing initrd memory: 564924K
[    3.547867] Segment Routing with IPv6
[    3.547900] In-situ OAM (IOAM) with IPv6
[    3.547929] NET: Registered PF_PACKET protocol family
[    3.548068] Key type dns_resolver registered
[    3.552669] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    3.553019] microcode: Current revision: 0x000000f6
[    3.553023] microcode: Updated early from: 0x000000f4
[    3.553782] IPI shorthand broadcast: enabled
[    3.555530] sched_clock: Marking stable (3546001036, =
9310033)->(3622090908, -66779839)
[    3.555808] registered taskstats version 1
[    3.556287] Loading compiled-in X.509 certificates
[    3.556813] Loaded X.509 cert 'Build time autogenerated kernel key: =
ba40f4861a4040834c312e6632c8f0d6a4284a73'
[    3.560870] Demotion targets for Node 0: null
[    3.561021] Key type .fscrypt registered
[    3.561024] Key type fscrypt-provisioning registered
[    3.561056] Key type trusted registered
[    3.567215] cryptd: max_cpu_qlen set to 1000
[    3.571189] AES CTR mode by8 optimization enabled
[    3.585479] Key type encrypted registered
[    3.585503] AppArmor: AppArmor sha256 policy hashing enabled
[    3.586511] integrity: Loading X.509 certificate: UEFI:db
[    3.586548] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI =
CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    3.586552] integrity: Loading X.509 certificate: UEFI:db
[    3.586569] integrity: Loaded X.509 cert 'Microsoft Windows =
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    3.586573] integrity: Loading X.509 certificate: UEFI:db
[    3.586937] integrity: Loaded X.509 cert 'CISD FW Update - =
Certificate: 068268b4a41c93854262d49b4f788f13'
[    3.588535] Loading compiled-in module X.509 certificates
[    3.588935] Loaded X.509 cert 'Build time autogenerated kernel key: =
ba40f4861a4040834c312e6632c8f0d6a4284a73'
[    3.588941] ima: Allocated hash algorithm: sha256
[    3.813734] ima: No architecture policies found
[    3.813795] evm: Initialising EVM extended attributes:
[    3.813803] evm: security.selinux
[    3.813809] evm: security.SMACK64
[    3.813815] evm: security.SMACK64EXEC
[    3.813820] evm: security.SMACK64TRANSMUTE
[    3.813826] evm: security.SMACK64MMAP
[    3.813831] evm: security.apparmor
[    3.813837] evm: security.ima
[    3.813841] evm: security.capability
[    3.813847] evm: HMAC attrs: 0x1
[    3.814492] PM:   Magic number: 9:99:941
[    3.815076] RAS: Correctable Errors collector initialized.
[    3.815146] clk: Disabling unused clocks
[    3.815154] PM: genpd: Disabling unused power domains
[    3.817715] Freeing unused decrypted memory: 2028K
[    3.819535] Freeing unused kernel image (initmem) memory: 5024K
[    3.819770] Write protecting the kernel read-only data: 32768k
[    3.821107] Freeing unused kernel image (text/rodata gap) memory: =
1372K
[    3.821706] Freeing unused kernel image (rodata/data gap) memory: =
1768K
[    3.863956] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.863960] x86/mm: Checking user space page tables
[    3.904480] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.904492] Run /init as init process
[    3.904494]   with arguments:
[    3.904496]     /init
[    3.904497]   with environment:
[    3.904498]     HOME=3D/
[    3.904499]     TERM=3Dlinux
[    3.904500]     BOOT_IMAGE=3D/vmlinuz-6.14.7
[    4.110106] ahci 0000:00:17.0: version 3.0
[    4.110426] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, =
6 Gbps, SATA mode
[    4.110438] ahci 0000:00:17.0: 1/1 ports implemented (port mask 0x4)
[    4.110444] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio =
slum part deso sadm sds apst
[    4.111190] scsi host0: ahci
[    4.111460] scsi host1: ahci
[    4.111630] scsi host2: ahci
[    4.111681] ata1: DUMMY
[    4.111685] ata2: DUMMY
[    4.111691] ata3: SATA max UDMA/133 abar m2048@0xa8a26000 port =
0xa8a26200 irq 144 lpm-pol 3
[    4.137422] e1000e: Intel(R) PRO/1000 Network Driver
[    4.137429] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.137685] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) =
set to dynamic conservative mode
[    4.144275] ACPI: bus type thunderbolt registered
[    4.144412] thunderbolt 0000:04:00.0: total paths: 12
[    4.144417] thunderbolt 0000:04:00.0: IOMMU DMA protection is =
disabled
[    4.144667] thunderbolt 0000:04:00.0: allocating TX ring 0 of size 10
[    4.144693] thunderbolt 0000:04:00.0: allocating RX ring 0 of size 10
[    4.144708] thunderbolt 0000:04:00.0: control channel created
[    4.144711] thunderbolt 0000:04:00.0: using firmware connection =
manager
[    4.144713] thunderbolt 0000:04:00.0: NHI initialized, starting =
thunderbolt
[    4.144714] thunderbolt 0000:04:00.0: control channel starting...
[    4.144715] thunderbolt 0000:04:00.0: starting TX ring 0
[    4.144722] thunderbolt 0000:04:00.0: enabling interrupt at register =
0x38200 bit 0 (0x0 -> 0x1)
[    4.144724] thunderbolt 0000:04:00.0: starting RX ring 0
[    4.144730] thunderbolt 0000:04:00.0: enabling interrupt at register =
0x38200 bit 12 (0x1 -> 0x1001)
[    4.314261] thunderbolt 0000:04:00.0: security level set to user
[    4.333021] thunderbolt 0000:04:00.0: current switch config:
[    4.333026] thunderbolt 0000:04:00.0:  Thunderbolt 3 Switch: =
8086:15da (Revision: 6, TB Version: 2)
[    4.333031] thunderbolt 0000:04:00.0:   Max Port Number: 11
[    4.333034] thunderbolt 0000:04:00.0:   Config:
[    4.333036] thunderbolt 0000:04:00.0:    Upstream Port Number: 5 =
Depth: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 254ms
[    4.333039] thunderbolt 0000:04:00.0:    unknown1: 0x0 unknown4: 0x0
[    4.380125] thunderbolt 0000:04:00.0: 0: DROM version: 1
[    4.380893] thunderbolt 0000:04:00.0: 0: uid: 0x8086cb1c54e9b600
[    4.382300] thunderbolt 0000:04:00.0:  Port 1: 8086:15da (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    4.382303] thunderbolt 0000:04:00.0:   Max hop id (in/out): 15/15
[    4.382305] thunderbolt 0000:04:00.0:   Max counters: 16
[    4.382306] thunderbolt 0000:04:00.0:   NFC Credits: 0x3c00000
[    4.382308] thunderbolt 0000:04:00.0:   Credits (total/control): 60/2
[    4.383709] thunderbolt 0000:04:00.0:  Port 2: 8086:15da (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    4.383712] thunderbolt 0000:04:00.0:   Max hop id (in/out): 15/15
[    4.383713] thunderbolt 0000:04:00.0:   Max counters: 16
[    4.383714] thunderbolt 0000:04:00.0:   NFC Credits: 0x3c00000
[    4.383716] thunderbolt 0000:04:00.0:   Credits (total/control): 60/2
[    4.383717] thunderbolt 0000:04:00.0: 0:3: disabled by eeprom
[    4.383718] thunderbolt 0000:04:00.0: 0:4: disabled by eeprom
[    4.383720] thunderbolt 0000:04:00.0: 0:5: disabled by eeprom
[    4.383964] thunderbolt 0000:04:00.0:  Port 6: 8086:15da (Revision: =
6, TB Version: 1, Type: PCIe (0x100101))
[    4.383966] thunderbolt 0000:04:00.0:   Max hop id (in/out): 8/8
[    4.383968] thunderbolt 0000:04:00.0:   Max counters: 2
[    4.383969] thunderbolt 0000:04:00.0:   NFC Credits: 0x800000
[    4.383970] thunderbolt 0000:04:00.0:   Credits (total/control): 8/0
[    4.384220] thunderbolt 0000:04:00.0:  Port 7: 8086:15da (Revision: =
6, TB Version: 1, Type: PCIe (0x100101))
[    4.384222] thunderbolt 0000:04:00.0:   Max hop id (in/out): 8/8
[    4.384223] thunderbolt 0000:04:00.0:   Max counters: 2
[    4.384224] thunderbolt 0000:04:00.0:   NFC Credits: 0x800000
[    4.384226] thunderbolt 0000:04:00.0:   Credits (total/control): 8/0
[    4.384227] thunderbolt 0000:04:00.0: 0:8: disabled by eeprom
[    4.384476] thunderbolt 0000:04:00.0:  Port 9: 8086:15da (Revision: =
6, TB Version: 1, Type: DP/HDMI (0xe0101))
[    4.384478] thunderbolt 0000:04:00.0:   Max hop id (in/out): 9/9
[    4.384479] thunderbolt 0000:04:00.0:   Max counters: 2
[    4.384480] thunderbolt 0000:04:00.0:   NFC Credits: 0x1000000
[    4.384482] thunderbolt 0000:04:00.0:   Credits (total/control): 16/0
[    4.384732] thunderbolt 0000:04:00.0:  Port 10: 8086:15da (Revision: =
6, TB Version: 1, Type: DP/HDMI (0xe0101))
[    4.384735] thunderbolt 0000:04:00.0:   Max hop id (in/out): 9/9
[    4.384736] thunderbolt 0000:04:00.0:   Max counters: 2
[    4.384737] thunderbolt 0000:04:00.0:   NFC Credits: 0x1000000
[    4.384738] thunderbolt 0000:04:00.0:   Credits (total/control): 16/0
[    4.384740] thunderbolt 0000:04:00.0: 0:11: disabled by eeprom
[    4.385773] thunderbolt 0000:04:00.0: 0: NVM version 33.0
[    4.385896] thunderbolt 0-1: local UUID =
d1030000-0090-8f18-23c5-b11c6cd30923
[    4.385899] thunderbolt 0-1: remote UUID =
d7030000-0070-6d18-232c-531042752121
[    4.421026] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.422328] ata3.00: Model 'CT120BX500SSD1', rev ' M6CR013', applying =
quirks: nolpm
[    4.422338] ata3.00: LPM support broken, forcing max_power
[    4.423853] ata3.00: ATA-9: CT120BX500SSD1,  M6CR013, max UDMA/133
[    4.425290] ata3.00: 234441648 sectors, multi 1: LBA48 NCQ (depth =
32), AA
[    4.430077] ata3.00: Features: Dev-Sleep
[    4.433330] ata3.00: LPM support broken, forcing max_power
[    4.441062] ata3.00: configured for UDMA/133
[    4.452587] ahci 0000:00:17.0: port does not support device sleep
[    4.452808] scsi 2:0:0:0: Direct-Access     ATA      CT120BX500SSD1   =
R013 PQ: 0 ANSI: 5
[    4.453326] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    4.453352] sd 2:0:0:0: [sda] 234441648 512-byte logical blocks: (120 =
GB/112 GiB)
[    4.453385] sd 2:0:0:0: [sda] Write Protect is off
[    4.453396] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.453423] sd 2:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    4.453474] sd 2:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.465911]  sda: sda1 sda2 sda3
[    4.466418] sd 2:0:0:0: [sda] Attached SCSI disk
[    4.487337] thunderbolt 0-1: running state INIT
[    4.518770] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): =
registered PHC clock
[    4.582722] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) =
1c:69:7a:00:22:99
[    4.582736] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network =
Connection
[    4.582851] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: =
FFFFFF-0FF
[    4.584449] e1000e 0000:00:1f.6 eno1: renamed from eth0
[    4.592373] thunderbolt 0-1: sending properties changed notification
[    4.740766] tpm tpm0: auth session is active
[    5.495677] thunderbolt 0-1: running state PROPERTIES
[    5.495691] thunderbolt 0-1: requesting remote properties
[    5.497037] thunderbolt 0-1: current link speed 10.0 Gb/s
[    5.497049] thunderbolt 0-1: current link width symmetric, single =
lane
[    5.497152] thunderbolt 0-1: new host found, vendor=3D0x8086 =
device=3D0x1
[    5.497178] thunderbolt 0-1: Intel Corp. red
[    5.557621] thunderbolt 0-1: sending properties changed notification
[    5.733348] raid6: avx2x4   gen() 39896 MB/s
[    5.750348] raid6: avx2x2   gen() 39021 MB/s
[    5.762913] thunderbolt 0000:04:00.0: 1: received XDomain properties =
request
[    5.763194] thunderbolt 0000:04:00.0: 1: received XDomain properties =
request
[    5.767348] raid6: avx2x1   gen() 31475 MB/s
[    5.767351] raid6: using algorithm avx2x4 gen() 39896 MB/s
[    5.784367] raid6: .... xor() 19096 MB/s, rmw enabled
[    5.784370] raid6: using avx2x2 recovery algorithm
[    5.786053] xor: automatically using best checksumming function   avx
[    5.787363] async_tx: api initialized (async)
[    5.981740] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    6.040154] EXT4-fs (dm-0): mounted filesystem =
651a5c81-f0ec-4fa7-9444-e2fb18183c26 ro with ordered data mode. Quota =
mode: none.
[    6.419031] systemd[1]: Inserted module 'autofs4'
[    6.474489] systemd[1]: systemd 255.4-1ubuntu8.6 running in system =
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT =
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC =
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 =
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT =
default-hierarchy=3Dunified)
[    6.474563] systemd[1]: Detected architecture x86-64.
[    6.477967] systemd[1]: Hostname set to <blue>.
[    6.716097] systemd[1]: Queued start job for default target =
graphical.target.
[    6.732408] systemd[1]: Created slice system-modprobe.slice - Slice =
/system/modprobe.
[    6.732773] systemd[1]: Created slice system-systemd\x2dfsck.slice - =
Slice /system/systemd-fsck.
[    6.733005] systemd[1]: Created slice user.slice - User and Session =
Slice.
[    6.733093] systemd[1]: Started systemd-ask-password-wall.path - =
Forward Password Requests to Wall Directory Watch.
[    6.733284] systemd[1]: Set up automount =
proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats =
File System Automount Point.
[    6.733338] systemd[1]: Expecting device =
dev-disk-by\x2duuid-6614\x2d3E45.device - /dev/disk/by-uuid/6614-3E45...
[    6.733372] systemd[1]: Expecting device =
dev-disk-by\x2duuid-e5851159\x2d8d53\x2d4060\x2d8b92\x2d5ed1b388f8fd.devic=
e - /dev/disk/by-uuid/e5851159-8d53-4060-8b92-5ed1b388f8fd...
[    6.733404] systemd[1]: Expecting device =
sys-subsystem-net-devices-wlp0s20f3.device - =
/sys/subsystem/net/devices/wlp0s20f3...
[    6.733448] systemd[1]: Reached target integritysetup.target - Local =
Integrity Protected Volumes.
[    6.733500] systemd[1]: Reached target slices.target - Slice Units.
[    6.733534] systemd[1]: Reached target snapd.mounts-pre.target - =
Mounting snaps.
[    6.733567] systemd[1]: Reached target snapd.mounts.target - Mounted =
snaps.
[    6.733613] systemd[1]: Reached target veritysetup.target - Local =
Verity Protected Volumes.
[    6.733712] systemd[1]: Listening on dm-event.socket - Device-mapper =
event daemon FIFOs.
[    6.733833] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll =
daemon socket.
[    6.733957] systemd[1]: Listening on multipathd.socket - multipathd =
control socket.
[    6.734802] systemd[1]: Listening on syslog.socket - Syslog Socket.
[    6.734931] systemd[1]: Listening on systemd-fsckd.socket - fsck to =
fsckd communication Socket.
[    6.735018] systemd[1]: Listening on systemd-initctl.socket - initctl =
Compatibility Named Pipe.
[    6.735156] systemd[1]: Listening on systemd-journald-dev-log.socket =
- Journal Socket (/dev/log).
[    6.735302] systemd[1]: Listening on systemd-journald.socket - =
Journal Socket.
[    6.735484] systemd[1]: Listening on systemd-networkd.socket - =
Network Service Netlink Socket.
[    6.735549] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension =
(Varlink) was skipped because of an unmet condition check =
(ConditionSecurity=3Dmeasured-uki).
[    6.735671] systemd[1]: Listening on systemd-udevd-control.socket - =
udev Control Socket.
[    6.735791] systemd[1]: Listening on systemd-udevd-kernel.socket - =
udev Kernel Socket.
[    6.736942] systemd[1]: Mounting dev-hugepages.mount - Huge Pages =
File System...
[    6.737632] systemd[1]: Mounting dev-mqueue.mount - POSIX Message =
Queue File System...
[    6.738270] systemd[1]: Mounting sys-kernel-debug.mount - Kernel =
Debug File System...
[    6.738932] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel =
Trace File System...
[    6.741356] systemd[1]: Starting systemd-journald.service - Journal =
Service...
[    6.742524] systemd[1]: Starting keyboard-setup.service - Set the =
console keyboard layout...
[    6.743766] systemd[1]: Starting kmod-static-nodes.service - Create =
List of Static Device Nodes...
[    6.744556] systemd[1]: Starting lvm2-monitor.service - Monitoring of =
LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    6.745823] systemd[1]: Starting modprobe@configfs.service - Load =
Kernel Module configfs...
[    6.747019] systemd[1]: Starting modprobe@dm_mod.service - Load =
Kernel Module dm_mod...
[    6.748214] systemd[1]: Starting modprobe@drm.service - Load Kernel =
Module drm...
[    6.749508] systemd[1]: Starting modprobe@efi_pstore.service - Load =
Kernel Module efi_pstore...
[    6.750919] systemd[1]: Starting modprobe@fuse.service - Load Kernel =
Module fuse...
[    6.752216] systemd[1]: Starting modprobe@loop.service - Load Kernel =
Module loop...
[    6.752360] systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch =
configuration for cleanup was skipped because of an unmet condition =
check (ConditionFileIsExecutable=3D/usr/bin/ovs-vsctl).
[    6.752656] systemd[1]: systemd-fsck-root.service - File System Check =
on Root Device was skipped because of an unmet condition check =
(ConditionPathExists=3D!/run/initramfs/fsck-root).
[    6.754964] systemd[1]: Starting systemd-modules-load.service - Load =
Kernel Modules...
[    6.755067] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine =
ID Measurement was skipped because of an unmet condition check =
(ConditionSecurity=3Dmeasured-uki).
[    6.756257] systemd[1]: Starting systemd-remount-fs.service - Remount =
Root and Kernel File Systems...
[    6.756544] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK =
Setup (Early) was skipped because of an unmet condition check =
(ConditionSecurity=3Dmeasured-uki).
[    6.757676] systemd[1]: Starting systemd-udev-trigger.service - =
Coldplug All udev Devices...
[    6.759848] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File =
System.
[    6.760090] systemd[1]: Mounted dev-mqueue.mount - POSIX Message =
Queue File System.
[    6.760265] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug =
File System.
[    6.760484] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel =
Trace File System.
[    6.760814] systemd[1]: Finished kmod-static-nodes.service - Create =
List of Static Device Nodes.
[    6.761169] pstore: Using crash dump compression: deflate
[    6.761455] systemd[1]: modprobe@configfs.service: Deactivated =
successfully.
[    6.761989] systemd[1]: Finished modprobe@configfs.service - Load =
Kernel Module configfs.
[    6.763144] systemd[1]: modprobe@dm_mod.service: Deactivated =
successfully.
[    6.763755] systemd[1]: Finished modprobe@dm_mod.service - Load =
Kernel Module dm_mod.
[    6.765016] systemd[1]: modprobe@drm.service: Deactivated =
successfully.
[    6.765591] systemd[1]: Finished modprobe@drm.service - Load Kernel =
Module drm.
[    6.766326] systemd-journald[397]: Collecting audit messages is =
disabled.
[    6.766601] systemd[1]: modprobe@fuse.service: Deactivated =
successfully.
[    6.767879] systemd[1]: Finished modprobe@fuse.service - Load Kernel =
Module fuse.
[    6.769134] systemd[1]: modprobe@loop.service: Deactivated =
successfully.
[    6.769792] systemd[1]: Finished modprobe@loop.service - Load Kernel =
Module loop.
[    6.773828] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE =
Control File System...
[    6.777458] systemd[1]: Mounting sys-kernel-config.mount - Kernel =
Configuration File System...
[    6.777659] systemd[1]: systemd-repart.service - Repartition Root =
Disk was skipped because no trigger condition checks were met.
[    6.780120] systemd[1]: Starting =
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in =
/dev gracefully...
[    6.784755] EXT4-fs (dm-0): re-mounted =
651a5c81-f0ec-4fa7-9444-e2fb18183c26 r/w. Quota mode: none.
[    6.784921] pstore: Registered efi_pstore as persistent store backend
[    6.787677] systemd[1]: modprobe@efi_pstore.service: Deactivated =
successfully.
[    6.787831] systemd[1]: Finished modprobe@efi_pstore.service - Load =
Kernel Module efi_pstore.
[    6.788120] systemd[1]: Finished systemd-remount-fs.service - Remount =
Root and Kernel File Systems.
[    6.788294] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE =
Control File System.
[    6.789215] systemd[1]: Activating swap swap.img.swap - /swap.img...
[    6.790244] systemd[1]: Starting multipathd.service - Device-Mapper =
Multipath Device Controller...
[    6.791645] systemd[1]: systemd-hwdb-update.service - Rebuild =
Hardware Database was skipped because no trigger condition checks were =
met.
[    6.791706] systemd[1]: systemd-pstore.service - Platform Persistent =
Storage Archival was skipped because of an unmet condition check =
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[    6.792783] systemd[1]: Starting systemd-random-seed.service - =
Load/Save OS Random Seed...
[    6.792853] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup =
was skipped because of an unmet condition check =
(ConditionSecurity=3Dmeasured-uki).
[    6.793743] systemd[1]: Mounted sys-kernel-config.mount - Kernel =
Configuration File System.
[    6.796471] systemd[1]: Finished systemd-modules-load.service - Load =
Kernel Modules.
[    6.798512] systemd[1]: Starting systemd-sysctl.service - Apply =
Kernel Variables...
[    6.799430] Adding 4194300k swap on /swap.img.  Priority:-2 =
extents:21 across:38420480k SS
[    6.800249] systemd[1]: Activated swap swap.img.swap - /swap.img.
[    6.800573] systemd[1]: Reached target swap.target - Swaps.
[    6.812493] systemd[1]: Finished systemd-random-seed.service - =
Load/Save OS Random Seed.
[    6.821255] systemd[1]: Finished =
systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in =
/dev gracefully.
[    6.832609] systemd[1]: Starting systemd-sysusers.service - Create =
System Users...
[    6.832988] systemd[1]: Finished lvm2-monitor.service - Monitoring of =
LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    6.833272] systemd[1]: Finished systemd-sysctl.service - Apply =
Kernel Variables.
[    6.833795] systemd[1]: Finished keyboard-setup.service - Set the =
console keyboard layout.
[    6.846020] systemd[1]: Finished systemd-sysusers.service - Create =
System Users.
[    6.847059] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - =
Create Static Device Nodes in /dev...
[    6.853239] systemd[1]: Started multipathd.service - Device-Mapper =
Multipath Device Controller.
[    6.857677] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - =
Create Static Device Nodes in /dev.
[    6.857843] systemd[1]: Reached target local-fs-pre.target - =
Preparation for Local File Systems.
[    6.858871] systemd[1]: Starting systemd-udevd.service - Rule-based =
Manager for Device Events and Files...
[    6.858974] systemd[1]: Started systemd-journald.service - Journal =
Service.
[    6.877118] systemd-journald[397]: Received client request to flush =
runtime journal.
[    6.889972] systemd-journald[397]: =
/var/log/journal/1a1ebe9ebc5e437388c401a31893d5b9/system.journal: =
Journal file uses a different sequence number ID, rotating.
[    6.889981] systemd-journald[397]: Rotating system journal.
[    7.019486] thunderbolt-net 0-1.0 tb0: renamed from thunderbolt0
[    7.204151] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    7.205858] intel_pmc_core INT33A1:00:  initialized
[    7.240079] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    7.240131] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    7.242809] i2c i2c-0: Successfully instantiated SPD at 0x50
[    7.264672] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, =
655360 ms ovfl timer
[    7.264676] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.264677] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.264678] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.264679] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.264680] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.308697] cfg80211: Loading compiled-in X.509 certificates for =
regulatory database
[    7.309011] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.309222] Loaded X.509 cert 'wens: =
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    7.309222] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, =
read-only
[    7.317080] spi-nor spi0.0: supply vcc not found, using dummy =
regulator
[    7.355936] Bluetooth: Core ver 2.22
[    7.355959] NET: Registered PF_BLUETOOTH protocol family
[    7.355960] Bluetooth: HCI device and connection manager initialized
[    7.355963] Bluetooth: HCI socket layer initialized
[    7.355965] Bluetooth: L2CAP socket layer initialized
[    7.355969] Bluetooth: SCO socket layer initialized
[    7.358450] Creating 1 MTD partitions on "0000:00:1f.5":
[    7.358462] 0x000000000000-0x000001000000 : "BIOS"
[    7.634734] Intel(R) Wireless WiFi driver for Linux
[    7.634793] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    7.635889] iwlwifi 0000:00:14.3: Detected crf-id 0x2816, cnv-id =
0x1000100 wfpm id 0x80000000
[    7.635899] iwlwifi 0000:00:14.3: PCI dev 9df0/0034, rev=3D0x312, =
rfid=3D0x105110
[    7.635902] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC 9560 =
160MHz
[    7.656646] iwlwifi 0000:00:14.3: WRT: Overriding region id 0
[    7.656651] iwlwifi 0000:00:14.3: WRT: Overriding region id 1
[    7.656653] iwlwifi 0000:00:14.3: WRT: Overriding region id 2
[    7.656654] iwlwifi 0000:00:14.3: WRT: Overriding region id 3
[    7.656655] iwlwifi 0000:00:14.3: WRT: Overriding region id 4
[    7.656657] iwlwifi 0000:00:14.3: WRT: Overriding region id 6
[    7.656658] iwlwifi 0000:00:14.3: WRT: Overriding region id 8
[    7.656659] iwlwifi 0000:00:14.3: WRT: Overriding region id 9
[    7.656661] iwlwifi 0000:00:14.3: WRT: Overriding region id 10
[    7.656662] iwlwifi 0000:00:14.3: WRT: Overriding region id 11
[    7.656664] iwlwifi 0000:00:14.3: WRT: Overriding region id 15
[    7.656665] iwlwifi 0000:00:14.3: WRT: Overriding region id 16
[    7.656666] iwlwifi 0000:00:14.3: WRT: Overriding region id 18
[    7.656668] iwlwifi 0000:00:14.3: WRT: Overriding region id 19
[    7.656669] iwlwifi 0000:00:14.3: WRT: Overriding region id 20
[    7.656670] iwlwifi 0000:00:14.3: WRT: Overriding region id 21
[    7.656672] iwlwifi 0000:00:14.3: WRT: Overriding region id 28
[    7.664068] iwlwifi 0000:00:14.3: loaded firmware version =
46.7e3e4b69.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
[    7.690786] usbcore: registered new interface driver btusb
[    7.715377] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> =
0002)
[    7.727648] EXT4-fs (sda2): mounted filesystem =
e5851159-8d53-4060-8b92-5ed1b388f8fd r/w with ordered data mode. Quota =
mode: none.
[    7.728059] Bluetooth: hci0: Found device firmware: =
intel/ibt-17-16-1.sfi
[    7.728148] Bluetooth: hci0: Boot Address: 0x40800
[    7.728150] Bluetooth: hci0: Firmware Version: 155-35.23
[    7.728151] Bluetooth: hci0: Firmware already loaded
[    7.729984] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but =
its usage is not supported.
[    7.913720] intel_tcc_cooling: Programmable TCC Offset detected
[    8.019824] audit: type=3D1400 audit(1748012146.721:2): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"brave" pid=3D660 comm=3D"apparmor_parser"
[    8.020939] audit: type=3D1400 audit(1748012146.721:3): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"Discord" pid=3D656 comm=3D"apparmor_parser"
[    8.020944] audit: type=3D1400 audit(1748012146.721:4): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D4D6F6E676F444220436F6D70617373 pid=3D657 comm=3D"apparmor_parser"
[    8.020947] audit: type=3D1400 audit(1748012146.721:5): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"QtWebEngineProcess" pid=3D658 comm=3D"apparmor_parser"
[    8.020949] audit: type=3D1400 audit(1748012146.721:6): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"busybox" pid=3D662 comm=3D"apparmor_parser"
[    8.020952] audit: type=3D1400 audit(1748012146.721:7): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"buildah" pid=3D661 comm=3D"apparmor_parser"
[    8.020954] audit: type=3D1400 audit(1748012146.721:8): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"1password" pid=3D655 comm=3D"apparmor_parser"
[    8.020957] audit: type=3D1400 audit(1748012146.721:9): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"balena-etcher" pid=3D659 comm=3D"apparmor_parser"
[    8.023088] audit: type=3D1400 audit(1748012146.724:10): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"cam" pid=3D663 comm=3D"apparmor_parser"
[    8.023319] audit: type=3D1400 audit(1748012146.724:11): =
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" =
name=3D"ch-checkns" pid=3D664 comm=3D"apparmor_parser"
[    8.359774] iwlwifi 0000:00:14.3: base HW address: d0:c6:37:09:01:5a, =
OTP minor version: 0x4
[    8.771391] ieee80211 phy0: Selected rate control algorithm =
'iwl-mvm-rs'
[    8.775745] intel_rapl_common: Found RAPL domain package
[    8.775750] intel_rapl_common: Found RAPL domain core
[    8.775752] intel_rapl_common: Found RAPL domain uncore
[    8.775753] intel_rapl_common: Found RAPL domain dram
[    8.775755] intel_rapl_common: Found RAPL domain psys
[    8.781673] i915 0000:00:02.0: [drm] Found coffeelake/ult (device ID =
3ea5) integrated display version 9.00 stepping N/A
[    8.782239] i915 0000:00:02.0: [drm] Found 128MB of eDRAM
[    8.782287] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    8.782290] i915 0000:00:02.0: vgaarb: deactivate vga console
[    8.782338] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[    8.782348] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    8.786023] i915 0000:00:02.0: vgaarb: VGA decodes changed: =
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    8.788671] mei_hdcp =
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 =
(ops i915_hdcp_ops [i915])
[    8.797549] i915 0000:00:02.0: [drm] Finished loading DMC firmware =
i915/kbl_dmc_ver1_04.bin (v1.4)
[    8.822389] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[    8.824908] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: =
no  post: no)
[    8.825351] input: Video Bus as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    8.898044] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    8.898099] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops =
i915_audio_component_bind_ops [i915])
[    8.934185] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    8.940696] snd_hda_codec_realtek hdaudioC0D0: ALC233: picked fixup  =
for PCI SSID 8086:2074
[    8.941302] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC233: =
line_outs=3D1 (0x21/0x0/0x0/0x0/0x0) type:hp
[    8.941306] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 =
(0x0/0x0/0x0/0x0/0x0)
[    8.941308] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D0 =
(0x0/0x0/0x0/0x0/0x0)
[    8.941314] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    8.941316] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    8.941317] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12=

[    8.941319] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x19
[    8.991289] input: HDA Intel PCH Mic as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input4
[    8.991708] input: HDA Intel PCH Front Headphone as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input5
[    8.991886] input: HDA Intel PCH HDMI/DP,pcm=3D3 as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input6
[    8.992120] input: HDA Intel PCH HDMI/DP,pcm=3D7 as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input7
[    8.992271] input: HDA Intel PCH HDMI/DP,pcm=3D8 as =
/devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[    9.049296] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, =
with index: 1
[    9.050871] bridge: filtering via arp/ip/ip6tables is no longer =
available by default. Update your scripts to load br_netfilter if you =
need this.
[    9.094373] br0: port 1(eno1) entered blocking state
[    9.094387] br0: port 1(eno1) entered disabled state
[    9.094436] e1000e 0000:00:1f.6 eno1: entered allmulticast mode
[    9.094593] e1000e 0000:00:1f.6 eno1: entered promiscuous mode
[    9.095912] br0: port 2(tb0) entered blocking state
[    9.095925] br0: port 2(tb0) entered disabled state
[    9.095964] thunderbolt-net 0-1.0 tb0: entered allmulticast mode
[    9.096250] thunderbolt-net 0-1.0 tb0: entered promiscuous mode
[    9.287737] thunderbolt 0000:04:00.0: allocating TX ring -1 of size =
256
[    9.287775] thunderbolt 0000:04:00.0: allocating RX ring -1 of size =
256
[    9.287838] br0: port 2(tb0) entered blocking state
[    9.287842] br0: port 2(tb0) entered forwarding state
[    9.289781] br0: port 2(tb0) entered disabled state
[    9.446692] NET: Registered PF_QIPCRTR protocol family
[    9.505652] loop0: detected capacity change from 0 to 8
[   12.539265] wlp0s20f3: authenticate with f4:1e:57:7f:25:ad (local =
address=3Dd0:c6:37:09:01:5a)
[   12.539767] wlp0s20f3: send auth to f4:1e:57:7f:25:ad (try 1/3)
[   12.580688] wlp0s20f3: authenticated
[   12.582448] wlp0s20f3: associate with f4:1e:57:7f:25:ad (try 1/3)
[   12.592257] wlp0s20f3: RX AssocResp from f4:1e:57:7f:25:ad =
(capab=3D0x1531 status=3D0 aid=3D7)
[   12.597919] wlp0s20f3: associated
[   12.631423] wlp0s20f3: Limiting TX power to 20 (20 - 0) dBm as =
advertised by f4:1e:57:7f:25:ad
[   14.013358] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full =
Duplex, Flow Control: Rx/Tx
[   14.013644] br0: port 1(eno1) entered blocking state
[   14.013662] br0: port 1(eno1) entered forwarding state
[   15.683008] thunderbolt 0000:04:00.0: starting TX ring 1
[   15.683034] thunderbolt 0000:04:00.0: enabling interrupt at register =
0x38200 bit 1 (0x1001 -> 0x1003)
[   15.683053] thunderbolt 0000:04:00.0: starting RX ring 1
[   15.683063] thunderbolt 0000:04:00.0: enabling E2E for RX ring 1 with =
TX HopID 1
[   15.683080] thunderbolt 0000:04:00.0: enabling interrupt at register =
0x38200 bit 13 (0x1003 -> 0x3003)
[   15.690454] br0: port 2(tb0) entered blocking state
[   15.690475] br0: port 2(tb0) entered forwarding state
[  288.033783] systemd-journald[397]: =
/var/log/journal/1a1ebe9ebc5e437388c401a31893d5b9/user-1000.journal: =
Journal file uses a different sequence number ID, rotating.
root@blue:~#

--Apple-Mail=_3962C952-BF08-4354-944B-A070C4E45E0A--

