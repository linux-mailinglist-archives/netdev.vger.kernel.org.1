Return-Path: <netdev+bounces-119709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC0956AE0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA7B25DB4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A416CD37;
	Mon, 19 Aug 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz63z6oV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6C16B75F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070411; cv=none; b=jAo9iFlQZiBMeI6ciy3oIOPz4S35+hkhsWOOHEoO0pUvS1uDasE+hfrkAcxktmik1ebHDhq0GjBTTjuNVoaYvNL6AVFxZ5oWinITeCFSdtrzoguhIh0K8Y4kAXvRXkdrbdyl7VuMy5pgwUVw+wYRXQ0nNqZfYDaP+ytWI18/+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070411; c=relaxed/simple;
	bh=RwyJOPoVAvdlverc0AdDGz/CEbDpLABbNYEYt28YRY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AxpMfgfhhvKsJzJcGr/G9Z0aZlTcEoLewy7pfgTTKcQ3Qg+Yf+OTcZVLEJUUR6uQAHs/Tf5NYYhHGegIRXeK7WdVvF10k3JFOes/5Nx9/RbaxzsTFGlTIZpGhf2ki0NtRMzwv6D3e/XkRktwAPzypoUl329GmYddf6crKWaoVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz63z6oV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6aef423f80aso38915537b3.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724070408; x=1724675208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uo/c7CXBHX8zkeJwDZfQBkHDwgduPiVmrh0bvYsjlj8=;
        b=Wz63z6oVYDqNBkis5Ba28JWure1EV+9ZmkCogAMcfwu1JmcFUvGlrvYm00x7nv78G2
         5Lz2PR1XEQ4Wv0N7Pbj5ZwBDKbY9KbYtJb/h7kFmS2VeByMt044MbVFS5+nTUbvylbBJ
         delL52PpuM8A4Y7cj1i4CI8TLndNfzNPu0DMEHZYaKU6gh2UizA3N4GnOQJnXBnTnHqe
         DjDz20nMTjNxutROUSp77qClClwjF6p/m9ruoujbvs/qKL/9s251PZZ1zPyk/ImtsUXz
         uO+UsITzJFRGlCsR5Fw2wE6z40Vlh6BAU+31MpTQEAw/GtWCXdcf/vU5ZG/iUocrlNRX
         Vcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070408; x=1724675208;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo/c7CXBHX8zkeJwDZfQBkHDwgduPiVmrh0bvYsjlj8=;
        b=Pbys0m9wB1y2uEVlTgF9fsd2Wk2G4xXJc41yBvE+VcUsE6tcsbR59qRk+z0xnu451I
         G1NI1j1JQrdDqUHsdwbIEU+EQdSeWpu0nSiVkNImrxfPTfhAEYggAenDWtFyb9D4yIui
         WnZ/xPrWmENEzcnosOjbf1YkNgqpexXudvsnwBjsLsg475ZtG/1DyMqgJF+WMA7HiEYG
         i2h65fj4pVWOuYlnOgs8RfBh6mZvnT13t5HKsGVG48/7/iOk2K99RJWshkDiJDIUShep
         hM+d/h0eEop8LIvaAAuDYY6T9EqCwylw87yJx1hzXV8+8TBkvdEDkI396mo+H7J9sVxE
         TtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1L29bE7iUOGU1v6AoyxcrDoAqGJbf2UGpyFXOecoLNs5Jom5Q/5ms96wlH9+OyjxGMjpob3kcjiu4yGrKjzGHRWBZeNj8
X-Gm-Message-State: AOJu0Yz65VFi7WDjZo8jQ9apUqokunUHpQ/eMR4KcEOs0cGorIWb7D2d
	8PrmFhEZVEItMD6eXwDZCVVe85XAkhx7KxiDg24tAH3ZPKurQKrfPu/HpUeCEg7CqgesgXx/JQc
	+BdyV72LzgkGahZuiWf3W1WDGYL4=
X-Google-Smtp-Source: AGHT+IHt013X0xj9oerfRFQgEmZXelRKA+BuNAkuIgLoHYXPFhltjRVqju/HMWU9kj9ukELA/cKA80h6m4QabUPB6+U=
X-Received: by 2002:a05:690c:60c5:b0:61b:3304:b702 with SMTP id
 00721157ae682-6b1b73a894amr119145937b3.5.1724070408263; Mon, 19 Aug 2024
 05:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shane Francis <bigbeeshane@gmail.com>
Date: Mon, 19 Aug 2024 13:26:37 +0100
Message-ID: <CABnpCuCLN6VNgmoWHwc4_8AT34xqmQnEoUHLncvE2yLqYZBaKg@mail.gmail.com>
Subject: [BUG] net: stmmac: crash within stmmac_rx()
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary of the problem:
===================
Crash observed within stmmac_rx when under high RX demand

Hardware : Rockchip RK3588 platform with an RTL8211F NIC

the issue seems identical to the one described here :
https://lore.kernel.org/netdev/20210514214927.GC1969@qmqm.qmqm.pl/T/

Full description of the problem/report:
=============================
I have observed that when under high upload scenarios the stmmac
driver will crash due to what I think is an overflow error, after some
debugging I found that stmmac_rx_buf2_len() is returning an
unexpectedly high value and assigning to buf2_len here
https://github.com/torvalds/linux/blob/v6.6/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L5466

an example value set that i have observed to causes the crash :
    buf1_len = 0
    buf2_len = 4294966330

from within the stmmac_rx_buf2_len function
    plen = 2106
    len = 3072

the return value would be plen-len or -966 (4294966330 as a uint32
that matches the buf2_len)

I am unsure on how to debug this further, would clamping
stmmac_rx_buf2_len function to return the dma_buf_sz if the return
value would have otherwise exceeded it ?

This only happens when exceeding 500mbps upload speeds, I have been
unable to replicate the issue when limiting the speed to sub 500mbps


Kernel version (from /proc/version):
===========================
6.6.45


Crash Log
========
[  120.746602] Mem abort info:
[  120.746848]   ESR = 0x000000009600014f
[  120.747189]   EC = 0x25: DABT (current EL), IL = 32 bits
[  120.747668]   SET = 0, FnV = 0
[  120.747943]   EA = 0, S1PTW = 0
[  120.748225]   FSC = 0x0f: level 3 permission fault
[  120.748650] Data abort info:
[  120.748908]   ISV = 0, ISS = 0x0000014f, ISS2 = 0x00000000
[  120.749392]   CM = 1, WnR = 1, TnD = 0, TagAccess = 0
[  120.749835]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  120.750311] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000003ddd000
[  120.750902] [ffff000003210000] pgd=18000001ffff8003,
p4d=18000001ffff8003, pud=18000001ffff7003, pmd=18000001fffde003,
pte=0060000003210783
[  120.752014] Internal error: Oops: 000000009600014f [#1] PREEMPT SMP
[  120.752562] Modules linked in: pppoe ppp_async nft_fib_inet
nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4
nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat
nft_masq nft_log nft_limit nft_hash nft_flow_offload nft
_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat
nf_flow_table nf_conntrack slhc r8169 nfnetlink nf_reject_ipv6
nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 crc_ccitt
gpio_button_hotplug(O)
[  120.756247] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O
   6.6.45 #0
[  120.756894] Hardware name: FriendlyElec NanoPi R6S (DT)
[  120.757351] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  120.757959] pc : dcache_inval_poc+0x40/0x58
[  120.758331] lr : arch_sync_dma_for_cpu+0x2c/0x3c
[  120.758739] sp : ffff80008000bcf0
[  120.759030] x29: ffff80008000bcf0 x28: ffff0001018e8900 x27: ffff000104920000
[  120.759657] x26: 0000000000000000 x25: ffff000103d28500 x24: ffff0001018e8900
[  120.760284] x23: ffff0001018ec900 x22: 00000000fffffc36 x21: 0000000000000002
[  120.760910] x20: ffff000100bf6410 x19: 0000000000589000 x18: 0000000000000000
[  120.761537] x17: 1128298ef1fd0a08 x16: 01010000efc30001 x15: ffffffffffffffff
[  120.762164] x14: ffffffffffffffff x13: ffffffffffffffff x12: ffffffffffffffff
[  120.762790] x11: ffffffffffffffff x10: ffffffffffffffff x9 : ffffffffffffffff
[  120.763417] x8 : ffffffffffffffff x7 : 0000000000000640 x6 : dead00000000003f
[  120.764043] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 000000000000003f
[  120.764670] x2 : 0000000000000040 x1 : ffff000100588c00 x0 : ffff000003210000
[  120.765296] Call trace:
[  120.765512]  dcache_inval_poc+0x40/0x58
[  120.765849]  dma_sync_single_for_cpu+0xec/0x110
[  120.766250]  stmmac_napi_poll_rx+0x30c/0xd9c
[  120.766628]  __napi_poll+0x38/0x178
[  120.766939]  net_rx_action+0x114/0x23c
[  120.767270]  handle_softirqs+0x108/0x248
[  120.767617]  __do_softirq+0x14/0x20
[  120.767926]  ____do_softirq+0x10/0x1c
[  120.768249]  call_on_irq_stack+0x24/0x4c
[  120.768594]  do_softirq_own_stack+0x1c/0x28
[  120.768963]  irq_exit_rcu+0xbc/0xd8
[  120.769272]  el1_interrupt+0x38/0x68
[  120.769590]  el1h_64_irq_handler+0x18/0x24
[  120.769951]  el1h_64_irq+0x68/0x6c
[  120.770251]  cpuidle_enter_state+0x130/0x2f0
[  120.770625]  cpuidle_enter+0x38/0x50
[  120.770941]  do_idle+0x19c/0x1f0
[  120.771229]  cpu_startup_entry+0x38/0x3c
[  120.771575]  __cpu_disable+0x0/0xdc
[  120.771883]  __secondary_switched+0xb8/0xbc
[  120.772255] Code: 8a230000 54000060 d50b7e20 14000002 (d5087620)
[  120.772787] ---[ end trace 0000000000000000 ]---
[  120.773192] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  120.773790] SMP: stopping secondary CPUs
[  120.774203] Kernel Offset: disabled
[  120.774507] CPU features: 0x0,c0000000,70028141,1000700b
[  120.774971] Memory Limit: none

