Return-Path: <netdev+bounces-111649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A2931EF1
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3169C1C20F43
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113D4687;
	Tue, 16 Jul 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxnqa8nK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130554A2F
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097549; cv=none; b=kn8XHcUn4hKJ2I+AZQkW1pNVeKns5hq9O6zIw19PHhk2/8wbkemRUnwI7JAh/ptthA0PfvjBzOSy5CSCjZn/BrXlYoVNjaFRWDcIXdkpKs8kjlC+vjwWUHn4FuF4XRsGLbtsOVF/qW2pXbO++tAP7Rb6/AgHO/sh55hz9C6zAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097549; c=relaxed/simple;
	bh=CbdtatzWcHCmkM0JAXgc8gY/RADWVdRfVW+eGH4z6U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6NoP9gBkAKXX73hYRVRgPOTdPdPub4rLEok/LexLZvaHiy41CzJj6JjJO/WV8fy4EBCBIEecPh/ouqGDepI3HS9zHZ0Q3yozATERp8LYRsiMZLgoEdFoVQvpJUoePopiTdiLvZJDq/QnTO/LIJFnHqM9JcJ41TOT271illONTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxnqa8nK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c9a8313984so4046739a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721097547; x=1721702347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXjOlTXyIYKmifBSI7YafZgZUJ57v6XUGbrTOxWJo+E=;
        b=fxnqa8nKL2N4JTHa2HXhqpzKof1LRPfEm9l4d8OQ3NCdO9XjFAlux5VKZLHsWpQ8IJ
         B7Oe2T/5ESNsg/73aNj0ahCw5wzBD0TN3lKFVbMxLwmhrDzejK/vX184TYkFXtDgfkuc
         bkxBcTELa9HlVT/42diU40ZtAkKHlXmOtoJbWSjOBuYdnHrWp2Uq7Tgg4jpww50tMKn3
         Zn9GyXp9hPCXv9iYSm3K5+Vrb53cyjrjo6mJamq2ZJZMSlZTwA3FactFHOj6zy1dTuth
         S7r19HRxSKcNTiTYJA0fq8nJ3FQtprZ5B5asT0doH2n2zlINOmo+VKTY1qXWKlw+OZhU
         35eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721097547; x=1721702347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXjOlTXyIYKmifBSI7YafZgZUJ57v6XUGbrTOxWJo+E=;
        b=Z6tUkUgPPAu9TilxFOXwpEPVYOnVBhqFQ7RxY5mP3KF91xGA8j1/1x+ENHdC5sTE+x
         Xv+yOfE1P5GgoNuYu6enffTrqK1ZzysvNpo6txYVYB4L5v/IywGvpqySkDun65HGOADP
         e+i9nYIz8dMl2S3evS5OB8v8tNXrFTZtYgDBevAvrSl9NZiw0h/bff+IwKZxWSy061SI
         UpnFP+LoQSaj4yT467iSov7iH0ahsySrdS/BumEIIgvzn+ufzFFSmv8F6p3Bi/ui5bMP
         m5GPaCCxiB8X10T+Mt0sGk3qib7eDKsFRcm319jXWb8NHEtVSWeOfUEqTJITW/VxZZjt
         AqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIiLRUq1rvO3W/Ygs3EjgZTWP7WaK7evK5EEJFNhWg/8nOwrARNpIouKVQgMp902WI4zBh06UFkedLGTgdJqlslrN4EUaM
X-Gm-Message-State: AOJu0YwLwLMGRLKTq8mb5dFcS16jVFtwWg9s1vCGFEb4byAXiW5k78nd
	RKanpxbHU282jxxD2nc2S9xkONTSPQ3k5HV3mSA+rEAFH7OF/v3nu046VKdq1HeyPJ27Ax1Pq8I
	ynpaifgUFDGoyQ1WkgkKs6ODmUFk=
X-Google-Smtp-Source: AGHT+IH95UChyzVXWPlT+vOAMignRjEP/4g586Cfhh1nKjtUy3henupaTWbx1GJsGwYM+TtGuS7TOdFNeb59h7OHjOs=
X-Received: by 2002:a17:90b:1b4e:b0:2c9:6ccc:2fbb with SMTP id
 98e67ed59e1d1-2cb37427d9emr612772a91.24.1721097547197; Mon, 15 Jul 2024
 19:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714161719.6528-1-kuniyu@amazon.com>
In-Reply-To: <20240714161719.6528-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 16 Jul 2024 03:38:54 +0100
Message-ID: <CAJwJo6aKKpjLO5uQWQDGayxjBYfunoObTezW0Ps-diTLEaAmNg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't access uninit tcp_rsk(req)->ao_keyid in tcp_create_openreq_child().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jul 2024 at 17:17, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> syzkaller reported KMSAN splat in tcp_create_openreq_child(). [0]
>
> The uninit variable is tcp_rsk(req)->ao_keyid.
>
> tcp_rsk(req)->ao_keyid is initialised only when tcp_conn_request() finds
> a valid TCP AO option in SYN.  Then, tcp_rsk(req)->used_tcp_ao is set
> accordingly.
>
> Let's not read tcp_rsk(req)->ao_keyid when tcp_rsk(req)->used_tcp_ao is
> false.
>
> [0]:
> BUG: KMSAN: uninit-value in tcp_create_openreq_child+0x198b/0x1ff0 net/ipv4/tcp_minisocks.c:610
>  tcp_create_openreq_child+0x198b/0x1ff0 net/ipv4/tcp_minisocks.c:610
>  tcp_v4_syn_recv_sock+0x18e/0x2170 net/ipv4/tcp_ipv4.c:1754
>  tcp_check_req+0x1a3e/0x20c0 net/ipv4/tcp_minisocks.c:852
>  tcp_v4_rcv+0x26a4/0x53a0 net/ipv4/tcp_ipv4.c:2265
>  ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
>  ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
>  ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
>  __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
>  __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
>  __netif_receive_skb_list net/core/dev.c:5803 [inline]
>  netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
>  gro_normal_list include/net/gro.h:515 [inline]
>  napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
>  e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
>  __napi_poll+0xd9/0x990 net/core/dev.c:6771
>  napi_poll net/core/dev.c:6840 [inline]
>  net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
>  handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
>  common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>  __msan_instrument_asm_store+0xd6/0xe0
>  arch_atomic_inc arch/x86/include/asm/atomic.h:53 [inline]
>  raw_atomic_inc include/linux/atomic/atomic-arch-fallback.h:992 [inline]
>  atomic_inc include/linux/atomic/atomic-instrumented.h:436 [inline]
>  page_ref_inc include/linux/page_ref.h:153 [inline]
>  folio_ref_inc include/linux/page_ref.h:160 [inline]
>  filemap_map_order0_folio mm/filemap.c:3596 [inline]
>  filemap_map_pages+0x11c7/0x2270 mm/filemap.c:3644
>  do_fault_around mm/memory.c:4879 [inline]
>  do_read_fault mm/memory.c:4912 [inline]
>  do_fault mm/memory.c:5051 [inline]
>  do_pte_missing mm/memory.c:3897 [inline]
>  handle_pte_fault mm/memory.c:5381 [inline]
>  __handle_mm_fault mm/memory.c:5524 [inline]
>  handle_mm_fault+0x3677/0x6f00 mm/memory.c:5689
>  do_user_addr_fault+0x1373/0x2b20 arch/x86/mm/fault.c:1338
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x54/0xc0 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>
> Uninit was stored to memory at:
>  tcp_create_openreq_child+0x1984/0x1ff0 net/ipv4/tcp_minisocks.c:611
>  tcp_v4_syn_recv_sock+0x18e/0x2170 net/ipv4/tcp_ipv4.c:1754
>  tcp_check_req+0x1a3e/0x20c0 net/ipv4/tcp_minisocks.c:852
>  tcp_v4_rcv+0x26a4/0x53a0 net/ipv4/tcp_ipv4.c:2265
>  ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
>  ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
>  ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
>  __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
>  __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
>  __netif_receive_skb_list net/core/dev.c:5803 [inline]
>  netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
>  gro_normal_list include/net/gro.h:515 [inline]
>  napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
>  e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
>  __napi_poll+0xd9/0x990 net/core/dev.c:6771
>  napi_poll net/core/dev.c:6840 [inline]
>  net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
>  handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
>  common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>
> Uninit was created at:
>  __alloc_pages_noprof+0x82d/0xcb0 mm/page_alloc.c:4706
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page mm/slub.c:2265 [inline]
>  allocate_slab mm/slub.c:2428 [inline]
>  new_slab+0x2af/0x14e0 mm/slub.c:2481
>  ___slab_alloc+0xf73/0x3150 mm/slub.c:3667
>  __slab_alloc mm/slub.c:3757 [inline]
>  __slab_alloc_node mm/slub.c:3810 [inline]
>  slab_alloc_node mm/slub.c:3990 [inline]
>  kmem_cache_alloc_noprof+0x53a/0x9f0 mm/slub.c:4009
>  reqsk_alloc_noprof net/ipv4/inet_connection_sock.c:920 [inline]
>  inet_reqsk_alloc+0x63/0x700 net/ipv4/inet_connection_sock.c:951
>  tcp_conn_request+0x339/0x4860 net/ipv4/tcp_input.c:7177
>  tcp_v4_conn_request+0x13b/0x190 net/ipv4/tcp_ipv4.c:1719
>  tcp_rcv_state_process+0x2dd/0x4a10 net/ipv4/tcp_input.c:6711
>  tcp_v4_do_rcv+0xbee/0x10d0 net/ipv4/tcp_ipv4.c:1932
>  tcp_v4_rcv+0x3fad/0x53a0 net/ipv4/tcp_ipv4.c:2334
>  ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
>  ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
>  ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
>  __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
>  __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
>  __netif_receive_skb_list net/core/dev.c:5803 [inline]
>  netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
>  gro_normal_list include/net/gro.h:515 [inline]
>  napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
>  e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
>  __napi_poll+0xd9/0x990 net/core/dev.c:6771
>  napi_poll net/core/dev.c:6840 [inline]
>  net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
>  handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
>  common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>
> CPU: 0 PID: 239 Comm: modprobe Tainted: G    B              6.10.0-rc7-01816-g852e42cc2dd4 #3 1107521f0c7b55c9309062382d0bda9f604dbb6d
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

LGTM, thank you!
Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

-- 
             Dmitry

