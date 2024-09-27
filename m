Return-Path: <netdev+bounces-130086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C4988213
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3281F22828
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAE1BB690;
	Fri, 27 Sep 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfoBIZmv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2C1BB686
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431167; cv=none; b=dyoLZW7HAP45rgOGWtgUmJIS6yBeA5Ak10p31seyYPyO6zGkAtI4/I/iHes/lmah1/49wLJkuYpzq4LnnOQ5hWKWT/E2xK5THFVsK1DzQyG7TfXkQfHF/PB+1Gw2NWyRX9GkJYi6ZPaSsJtljSp/28rZvDRp4+79+OYBC+LPcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431167; c=relaxed/simple;
	bh=9GE7t/o0nDhH/5FK6rykcZLRo/ZI2iY/e/0M2hWSQU4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mx5x7GsW3vpVpc7ZaUXli+j7xb7wYjzAG+AR3BnKDOpuwGzzIzk+MlO5Qy2KkGAdJVO+HcOVFZGv1L7/rFIie4hIRnauBsTOta9zz+3Vd2ULeDTCuReFQd6HmL3g1RlMLjLrJH4nH6duMltJANTGElJDPQcOWYy/ZSn2/6vL3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfoBIZmv; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45aeef3ce92so11424121cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727431162; x=1728035962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbPXvCJhXXy9iHPTb9kiCBhnC+rMXXMe+4wxSkYjBgI=;
        b=lfoBIZmvtv/0a8f+Eh3lOAk1H1+gCXQY3POn9Z4kIGGI78XSLMc1+jQGE3HWPCLZES
         jDe9hpsiUOyUWXyz34AFKCa3ytUD2Jh2v95SmmOLcookHFWK1acU3HHtI8Ez51OLt1Ch
         IhGOevoA8pkvxk3g+CIgHeHsvK2l+yzh86MYWYp45a0/ggfHAx5ijh2TxG2y/d4Dxxlq
         Yj8X45FyjAGJL/l00nqXQs7xOqUJXcBJfpC2hTx35t58i+9/lcG7YlXRa3biDqFzxrzn
         pbPl6cukA+WXhAKTMHnKB5tE+Wv+vYpN1YxPT5HK/DPxAkeYm3kh8Tg4L8Gkh4M4NPKV
         RGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431162; x=1728035962;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lbPXvCJhXXy9iHPTb9kiCBhnC+rMXXMe+4wxSkYjBgI=;
        b=YAfX1CT9br26zO37LkErzGnhKRygvGJMpwsxlut7F5EKiwxH6ASh3JGrO+fE2EBNzx
         +oS3qNoUcorJIxgm4iR75jEuIleRBLT+2NGV/8zYS+3TQ3vGnSyxdWUWKgHmknhaogaK
         6qf9R7g2dkBfWwHnlWM2g+rqpE0KlxMkWL89tFc4AdWgPorIZtjd58Ck6LGa4+jlUFFo
         20lZR7lg9NfPjdcRtgkeV8ooKsPq1e9SLOI98DmP6xqDhCcfU69RIbRTm8q+jeV4MjhF
         VpBi60OlYcspuzuxC3kB0v5dhnSLgxNRSQ+VYOjuNK+lTGluFDpz67XFnfbatvsO9kZZ
         P8eQ==
X-Gm-Message-State: AOJu0YzRGpE/lVzwDfNmoGd3jC7rF6ykfssxe4ZcNwcCWynKjqbYzlsh
	xHCpCvw9suDTpwRDU6KfhNjanffn4H7I7m/xlFn75vKvSDbwJmvq
X-Google-Smtp-Source: AGHT+IETUxyfx4cvbkX0zjNjq+YHasZhhPnYfQhHLBgTqNMXJNCdMbPxlRZILAN4I045POlCyjrAIA==
X-Received: by 2002:ac8:7d0a:0:b0:456:7e2e:45ef with SMTP id d75a77b69052e-45c9f20c6d2mr33830381cf.16.1727431161924;
        Fri, 27 Sep 2024 02:59:21 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28c844sm6424751cf.10.2024.09.27.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:59:21 -0700 (PDT)
Date: Fri, 27 Sep 2024 05:59:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66f681f8e81b8_ba96029444@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240926165836.3797406-1-edumazet@google.com>
References: <20240926165836.3797406-1-edumazet@google.com>
Subject: Re: [PATCH net] net: test for not too small csum_start in
 virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> syzbot was able to trigger this warning [1], after injecting a
> malicious packet through af_packet, setting skb->csum_start and thus
> the transport header to an incorrect value.
> 
> We can at least make sure the transport header is after
> the end of the network header (with a estimated minimal size).
> 
> [1]
> [   67.873027] skb len=4096 headroom=16 headlen=14 tailroom=0
> mac=(-1,-1) mac_len=0 net=(16,-6) trans=10
> shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
> csum(0xa start=10 offset=0 ip_summed=3 complete_sw=0 valid=0 level=0)
> hash(0x0 sw=0 l4=0) proto=0x0800 pkttype=0 iif=0
> priority=0x0 mark=0x0 alloc_cpu=10 vlan_all=0x0
> encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [   67.877172] dev name=veth0_vlan feat=0x000061164fdd09e9
> [   67.877764] sk family=17 type=3 proto=0
> [   67.878279] skb linear:   00000000: 00 00 10 00 00 00 00 00 0f 00 00 00 08 00
> [   67.879128] skb frag:     00000000: 0e 00 07 00 00 00 28 00 08 80 1c 00 04 00 00 02
> [   67.879877] skb frag:     00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.880647] skb frag:     00000020: 00 00 02 00 00 00 08 00 1b 00 00 00 00 00 00 00
> [   67.881156] skb frag:     00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.881753] skb frag:     00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.882173] skb frag:     00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.882790] skb frag:     00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.883171] skb frag:     00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.883733] skb frag:     00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.884206] skb frag:     00000090: 00 00 00 00 00 00 00 00 00 00 69 70 76 6c 61 6e
> [   67.884704] skb frag:     000000a0: 31 00 00 00 00 00 00 00 00 00 2b 00 00 00 00 00
> [   67.885139] skb frag:     000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.885677] skb frag:     000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.886042] skb frag:     000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.886408] skb frag:     000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.887020] skb frag:     000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.887384] skb frag:     00000100: 00 00
> [   67.887878] ------------[ cut here ]------------
> [   67.887908] offset (-6) >= skb_headlen() (14)
> [   67.888445] WARNING: CPU: 10 PID: 2088 at net/core/dev.c:3332 skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
> [   67.889353] Modules linked in: macsec macvtap macvlan hsr wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 libchacha poly1305_x86_64 dummy bridge sr_mod cdrom evdev pcspkr i2c_piix4 9pnet_virtio 9p 9pnet netfs
> [   67.890111] CPU: 10 UID: 0 PID: 2088 Comm: b363492833 Not tainted 6.11.0-virtme #1011
> [   67.890183] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   67.890309] RIP: 0010:skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
> [   67.891043] Call Trace:
> [   67.891173]  <TASK>
> [   67.891274] ? __warn (kernel/panic.c:741)
> [   67.891320] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
> [   67.891333] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [   67.891348] ? handle_bug (arch/x86/kernel/traps.c:239)
> [   67.891363] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
> [   67.891372] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
> [   67.891388] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
> [   67.891399] ? skb_checksum_help (net/core/dev.c:3332 (discriminator 2))
> [   67.891416] ip_do_fragment (net/ipv4/ip_output.c:777 (discriminator 1))
> [   67.891448] ? __ip_local_out (./include/linux/skbuff.h:1146 ./include/net/l3mdev.h:196 ./include/net/l3mdev.h:213 net/ipv4/ip_output.c:113)
> [   67.891459] ? __pfx_ip_finish_output2 (net/ipv4/ip_output.c:200)
> [   67.891470] ? ip_route_output_flow (./arch/x86/include/asm/preempt.h:84 (discriminator 13) ./include/linux/rcupdate.h:96 (discriminator 13) ./include/linux/rcupdate.h:871 (discriminator 13) net/ipv4/route.c:2625 (discriminator 13) ./include/net/route.h:141 (discriminator 13) net/ipv4/route.c:2852 (discriminator 13))
> [   67.891484] ipvlan_process_v4_outbound (drivers/net/ipvlan/ipvlan_core.c:445 (discriminator 1))
> [   67.891581] ipvlan_queue_xmit (drivers/net/ipvlan/ipvlan_core.c:542 drivers/net/ipvlan/ipvlan_core.c:604 drivers/net/ipvlan/ipvlan_core.c:670)
> [   67.891596] ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:227)
> [   67.891607] dev_hard_start_xmit (./include/linux/netdevice.h:4916 ./include/linux/netdevice.h:4925 net/core/dev.c:3588 net/core/dev.c:3604)
> [   67.891620] __dev_queue_xmit (net/core/dev.h:168 (discriminator 25) net/core/dev.c:4425 (discriminator 25))
> [   67.891630] ? skb_copy_bits (./include/linux/uaccess.h:233 (discriminator 1) ./include/linux/uaccess.h:260 (discriminator 1) ./include/linux/highmem-internal.h:230 (discriminator 1) net/core/skbuff.c:3018 (discriminator 1))
> [   67.891645] ? __pskb_pull_tail (net/core/skbuff.c:2848 (discriminator 4))
> [   67.891655] ? skb_partial_csum_set (net/core/skbuff.c:5657)
> [   67.891666] ? virtio_net_hdr_to_skb.constprop.0 (./include/linux/skbuff.h:2791 (discriminator 3) ./include/linux/skbuff.h:2799 (discriminator 3) ./include/linux/virtio_net.h:109 (discriminator 3))
> [   67.891684] packet_sendmsg (net/packet/af_packet.c:3145 (discriminator 1) net/packet/af_packet.c:3177 (discriminator 1))
> [   67.891700] ? _raw_spin_lock_bh (./arch/x86/include/asm/atomic.h:107 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:127 (discriminator 4) kernel/locking/spinlock.c:178 (discriminator 4))
> [   67.891716] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2210 (discriminator 1))
> [   67.891734] ? do_sock_setsockopt (net/socket.c:2335)
> [   67.891747] ? __sys_setsockopt (./include/linux/file.h:34 net/socket.c:2355)
> [   67.891761] __x64_sys_sendto (net/socket.c:2222 (discriminator 1) net/socket.c:2218 (discriminator 1) net/socket.c:2218 (discriminator 1))
> [   67.891772] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
> [   67.891785] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Fixes: 9181d6f8a2bb ("net: add more sanity check in virtio_net_hdr_to_skb()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


