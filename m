Return-Path: <netdev+bounces-129909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39768986F97
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BF31C2084B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF6D14E2ED;
	Thu, 26 Sep 2024 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPhPbDZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7D610B
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341656; cv=none; b=Z4DwYRax2VQEbjq0xBTMdwJrh0vZASKXIiTrm5kerEpgoac3YEssLYP3+Pl44wig3QgPLebsbiP5iIiqH2DSPO2ZznRyFksHGkBbLlvisyD/j8+uxtEezYL09sKJICCNC4M9eY4j4HvjU8rrmzi0cpWy3lM7HK6XXn6ij3Axqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341656; c=relaxed/simple;
	bh=X782ZQnxlhPIWibcoZiFcHJbMBVds61ylfgc+hd+4rs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ly4bF2i4nTEHHtrja9drDZp91bgNgdvmcRUVuN4cGQpKgimatCaHfKkgAtokUh2C436yaUjMj7tHfv9qXDTgE5Bg0kwIvVsfm+aM0mxJP5+yIPzCnVRUSp0IVW6/IVXZSLrBbUZZagSSFK9sYKQiQu9MYEFPzOspmZ/+bR4CYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPhPbDZx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-458366791aaso3923601cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727341653; x=1727946453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anVe4bs0kNETxeJTR1m1vBrHCnshz5yT6R67iVtnLrA=;
        b=RPhPbDZxTMoZcYR4kOFVUOEEgPtZM0NgN04mDizCDpWpJTsSt8g5sFzpFWUR5OrDo4
         rvDzGxaR7qvx9OSZSJdxZDUwzlBPtauRKMu3C7+MTupNqGt9Hel0LLQz3GwqY1LtNRxT
         EQgsTAHUImidg28W3ld/DVyOh4eQPe8qnIY+JgJUQs+d+xoTqxg64ajSP2VESUTwIeWk
         75mTr5f1hmo8No37G3EZ0apjGMB2rQMZkWZMqOmXz6fLjWXJq5ZhB0cQSALRUmDdj7Tl
         1J/R61YcBHVtJXMeV+MAvu/d2+bxn3r7WMaAiklmJyYNzoJRpic4KQIR+hlFNHnH5pCI
         XsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341653; x=1727946453;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anVe4bs0kNETxeJTR1m1vBrHCnshz5yT6R67iVtnLrA=;
        b=h2/7VEzaVRwSBasXSSPfEeMSjo2SxDx714V6siV4YuvkBOse+CZDK08rVHm4BC29bL
         lVr4tlB04Hi8SERefpzIDqoW5gILs8o2n/6emKP0ozZBJS29mYkWGQ4yLPNXtzpmdbxT
         t+2Lx1PFijtKrcT6mrSSlARmlke0TQWxouf+R/qVp7rDY+3Wb50KDIdnjnD4l89jkAM3
         OnkEPtz9GQ+BiokZyc4QyT69kFah6rUdU9XCqN64fuJ8yQVuClY3nX9FIsfZz0HKLCc1
         l6cwmOef/SM2MMWmgP/Np8NBv2wIgbaztuErHvJCrNxfwJfQ3Bi4264kpE+2+Rd1xoy3
         ckbw==
X-Forwarded-Encrypted: i=1; AJvYcCWGL/UkclgQo/w8lExCwkTC2NA+A2hGIs0BgctK7vGjNug3i0RSj98XwOocDOz1cvt5ALGjtwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOdGHzqJR0RWg0lsh0BezG12TDSTxr+Q5v4Ggi2u+pFSxAXaC4
	MflW7lAFrKFgIjepG32U4PeFq73K4pHSrXnMd0Z8/I5NiJpkgNSC
X-Google-Smtp-Source: AGHT+IGS5XATISYU7pQly6iOq2RdZ42JZmyRwlpJ+2kszD6/5/GI8NxVZIt05yFDo20KVRH8t34RQA==
X-Received: by 2002:a05:622a:14cd:b0:458:5419:4479 with SMTP id d75a77b69052e-45b5dede48bmr75967551cf.19.1727341653123;
        Thu, 26 Sep 2024 02:07:33 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b52579daesm23916781cf.25.2024.09.26.02.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:07:32 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:07:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Jonathan Davies <jonathan.davies@nutanix.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>
Message-ID: <66f524538e0fd_8456129498@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240924150257.1059524-2-edumazet@google.com>
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-2-edumazet@google.com>
Subject: Re: [PATCH net 1/2] net: avoid potential underflow in
 qdisc_pkt_len_init() with UFO
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
> After commit 7c6d2ecbda83 ("net: be more gentle about silly gso
> requests coming from user") virtio_net_hdr_to_skb() had sanity check
> to detect malicious attempts from user space to cook a bad GSO packet.
> 
> Then commit cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count
> transport header in UFO") while fixing one issue, allowed user space
> to cook a GSO packet with the following characteristic :
> 
> IPv4 SKB_GSO_UDP, gso_size=3, skb->len = 28.
> 
> When this packet arrives in qdisc_pkt_len_init(), we end up
> with hdr_len = 28 (IPv4 header + UDP header), matching skb->len
> 
> Then the following sets gso_segs to 0 :
> 
> gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
>                         shinfo->gso_size);
> 
> Then later we set qdisc_skb_cb(skb)->pkt_len to back to zero :/
> 
> qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
> 
> This leads to the following crash in fq_codel [1]
> 
> qdisc_pkt_len_init() is best effort, we only want an estimation
> of the bytes sent on the wire, not crashing the kernel.
> 
> This patch is fixing this particular issue, a following one
> adds more sanity checks for another potential bug.
> 
> [1]
> [   70.724101] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   70.724561] #PF: supervisor read access in kernel mode
> [   70.724561] #PF: error_code(0x0000) - not-present page
> [   70.724561] PGD 10ac61067 P4D 10ac61067 PUD 107ee2067 PMD 0
> [   70.724561] Oops: Oops: 0000 [#1] SMP NOPTI
> [   70.724561] CPU: 11 UID: 0 PID: 2163 Comm: b358537762 Not tainted 6.11.0-virtme #991
> [   70.724561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   70.724561] RIP: 0010:fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
> [ 70.724561] Code: 24 08 49 c1 e1 06 44 89 7c 24 18 45 31 ed 45 31 c0 31 ff 89 44 24 14 4c 03 8b 90 01 00 00 eb 04 39 ca 73 37 4d 8b 39 83 c7 01 <49> 8b 17 49 89 11 41 8b 57 28 45 8b 5f 34 49 c7 07 00 00 00 00 49
> All code
> ========
>    0:	24 08                	and    $0x8,%al
>    2:	49 c1 e1 06          	shl    $0x6,%r9
>    6:	44 89 7c 24 18       	mov    %r15d,0x18(%rsp)
>    b:	45 31 ed             	xor    %r13d,%r13d
>    e:	45 31 c0             	xor    %r8d,%r8d
>   11:	31 ff                	xor    %edi,%edi
>   13:	89 44 24 14          	mov    %eax,0x14(%rsp)
>   17:	4c 03 8b 90 01 00 00 	add    0x190(%rbx),%r9
>   1e:	eb 04                	jmp    0x24
>   20:	39 ca                	cmp    %ecx,%edx
>   22:	73 37                	jae    0x5b
>   24:	4d 8b 39             	mov    (%r9),%r15
>   27:	83 c7 01             	add    $0x1,%edi
>   2a:*	49 8b 17             	mov    (%r15),%rdx		<-- trapping instruction
>   2d:	49 89 11             	mov    %rdx,(%r9)
>   30:	41 8b 57 28          	mov    0x28(%r15),%edx
>   34:	45 8b 5f 34          	mov    0x34(%r15),%r11d
>   38:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
>   3f:	49                   	rex.WB
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	49 8b 17             	mov    (%r15),%rdx
>    3:	49 89 11             	mov    %rdx,(%r9)
>    6:	41 8b 57 28          	mov    0x28(%r15),%edx
>    a:	45 8b 5f 34          	mov    0x34(%r15),%r11d
>    e:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
>   15:	49                   	rex.WB
> [   70.724561] RSP: 0018:ffff95ae85e6fb90 EFLAGS: 00000202
> [   70.724561] RAX: 0000000002000000 RBX: ffff95ae841de000 RCX: 0000000000000000
> [   70.724561] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> [   70.724561] RBP: ffff95ae85e6fbf8 R08: 0000000000000000 R09: ffff95b710a30000
> [   70.724561] R10: 0000000000000000 R11: bdf289445ce31881 R12: ffff95ae85e6fc58
> [   70.724561] R13: 0000000000000000 R14: 0000000000000040 R15: 0000000000000000
> [   70.724561] FS:  000000002c5c1380(0000) GS:ffff95bd7fcc0000(0000) knlGS:0000000000000000
> [   70.724561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   70.724561] CR2: 0000000000000000 CR3: 000000010c568000 CR4: 00000000000006f0
> [   70.724561] Call Trace:
> [   70.724561]  <TASK>
> [   70.724561] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
> [   70.724561] ? page_fault_oops (arch/x86/mm/fault.c:715)
> [   70.724561] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> [   70.724561] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> [   70.724561] ? fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
> [   70.724561] dev_qdisc_enqueue (net/core/dev.c:3784)
> [   70.724561] __dev_queue_xmit (net/core/dev.c:3880 (discriminator 2) net/core/dev.c:4390 (discriminator 2))
> [   70.724561] ? irqentry_enter (kernel/entry/common.c:237)
> [   70.724561] ? sysvec_apic_timer_interrupt (./arch/x86/include/asm/hardirq.h:74 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2))
> [   70.724561] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:58 (discriminator 4))
> [   70.724561] ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702)
> [   70.724561] ? virtio_net_hdr_to_skb.constprop.0 (./include/linux/virtio_net.h:129 (discriminator 1))
> [   70.724561] packet_sendmsg (net/packet/af_packet.c:3145 (discriminator 1) net/packet/af_packet.c:3177 (discriminator 1))
> [   70.724561] ? _raw_spin_lock_bh (./arch/x86/include/asm/atomic.h:107 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:127 (discriminator 4) kernel/locking/spinlock.c:178 (discriminator 4))
> [   70.724561] ? netdev_name_node_lookup_rcu (net/core/dev.c:325 (discriminator 1))
> [   70.724561] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2210 (discriminator 1))
> [   70.724561] ? __sys_setsockopt (./include/linux/file.h:34 net/socket.c:2355)
> [   70.724561] __x64_sys_sendto (net/socket.c:2222 (discriminator 1) net/socket.c:2218 (discriminator 1) net/socket.c:2218 (discriminator 1))
> [   70.724561] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
> [   70.724561] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   70.724561] RIP: 0033:0x41ae09
> 
> Fixes: cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count transport header in UFO")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jonathan Davies <jonathan.davies@nutanix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

