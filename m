Return-Path: <netdev+bounces-154911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755CA004D7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564B33A3B1D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6B1C3F1C;
	Fri,  3 Jan 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4cEeRPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A51BC9F6;
	Fri,  3 Jan 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888610; cv=none; b=dVXqkhNRF7xLn624SGCNaH1XL61NbmrE5r1/Dds/YZ/XW87dnrd15zNQ5WtNQQ+MdYHlrV/qZFlp305smUFqL1p6Jdbb/Rk3R2w+vCRMgnHT7MPB/vsGuqKFY4JyWDXvaOGfu4nFXUim1WU+/MRpTFpKYN1x7dbC3wS50fN2ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888610; c=relaxed/simple;
	bh=WJ5h3zSDsKNOI/WK85r0RcSIW4ca6M90ETkkzYdBdjE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oSvea6QA5OboJXBcSCbuzJ+HEMYMf6tgOPzRRdDNGeNRCC2H0u2t6+EwRAA0ibG60aYw91FvmgkPv2W8B5+1/Bea1Sot5FXLoDlDIXeebmFoNOGUvkT+qiWee/gEOI9ALyzUcoHQ1BFk0ax7mhqzNm12FWrV3U142WEKdRmrmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4cEeRPt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so279084766b.3;
        Thu, 02 Jan 2025 23:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735888606; x=1736493406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJ5h3zSDsKNOI/WK85r0RcSIW4ca6M90ETkkzYdBdjE=;
        b=U4cEeRPtelldCtEefzwbPcZOrhuB3V7bXG7mbfEaEBen2en22vB6VdgMtxu+8vEqTt
         oy4OCkPnHUugoyFoHWqxTvCR0OQW6ZNe9dsBgXTRDbsTgPeK2r7+9ORkRMEJAZvMnq0s
         7w8HCoHC5xDdl5VEctLgKkbD6DBofHMTPYUk5kz1+koHOWp/hnXBiXUQb1tgcQO2loRg
         hmg4jR1E498Y0WD4EKXHbETnp+4FWXJDLDl/lakKXcYWTpss/U2xeE1SYaqmQlxr25zj
         yOGOCOI/f9zRLEu3V6NTdK2klWI0HrGDVdHz6N7+NjjBY33lMKkMUs9M26doKRpKKjxA
         jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888606; x=1736493406;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJ5h3zSDsKNOI/WK85r0RcSIW4ca6M90ETkkzYdBdjE=;
        b=FPtxWYAD6zT6CG7RdCCdcRajoVmBgQsi+w+3y00NMfi59zD8zAED7KIcNykCEMO5J4
         MijGbudUltLXXUXkIFRRlDBSEapxX0Ql3DDMhSFrUqTipN8Ia5OB0e88Eso6IA6qtTj6
         GOPxkRVX0HPV1uUVE/crJ76FD5btiy04FKxH68lBkIgnOLSt+Ol/CFe/u/CSWg/YVOXD
         eRb11jCDc2y76YFo3bSn9OzavMG5O4lJFsr6vw3c6i70Z6CX+v1xXr0upGr56bXC57o7
         wbK2u/jO+y5e7HuiS68+5sgrp3Rh63J2jNvLSjzbMzNqmHhEP5CWnUZpzxFhNsMI5mqY
         b0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0kmLRqGjrqIUaFYtqwS01fOhEAx54n0hPTor6/4Nf5ZFQBAw1VaxAB/v0aPwEDIfuYoCZqF+DR8mNFzE=@vger.kernel.org, AJvYcCVoCkpUWi6FQ2B3/uCTBA3ENuYAm/zN19WLS7TRCIZn7ae895ZqSO/WlbmiNlqiED60R6pdLWbf@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPHpXlaxBMcyv/ZBlVE0oub6LNkfSV24tSe7V/bXBH09ys8uJ
	iUcM1PWgSrh5fQJ9tG2fcT2A4odcwj5lqN0jKvlImPrjE6s0clzGGBip+dX3NMxxDD0Jy1YI8+O
	SyfuOqdJCTYS9lAKdPEljMblBFCPmVeUT
X-Gm-Gg: ASbGncuUUV1nKOPo9b8IJ3ViMGK7oJosrPGdN8CR2VRNWauPZvZtkBwJk+OPIY7WKX4
	veR4PD7Odh9lTqGQgG1j8ntD78kTgUrrb5kqnakY=
X-Google-Smtp-Source: AGHT+IFt5Ht39WMpJ8NgigLcaPryM62odro1qx278LTtGwlbr5xlQZbBZVuvCAFR6IEeVdCbxd/T6XWhQtwMfUSo99U=
X-Received: by 2002:a17:907:1a50:b0:aaf:3f57:9d2e with SMTP id
 a640c23a62f3a-aaf3f57af0cmr1380222666b.0.1735888606129; Thu, 02 Jan 2025
 23:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:16:34 +0800
Message-ID: <CAKHoSAt_KtBEBHoc3ucdCdMVy89unQPBCKrM3oTA=Kz4Nqpjjw@mail.gmail.com>
Subject: "KASAN: null-ptr-deref Read in ipv6_renew_options" in Linux kernel
 version 6.13.0-rc2
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Affected File: net/ipv6/exthdrs.c

File: net/ipv6/exthdrs.c

Function: ipv6_renew_options

Detailed Call Stack:

------------[ cut here begin]------------

netlink: 'syz.0.3890': attribute type 4 has an invalid length.
TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending
cookies. Check SNMP counters.
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read
include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_read
include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: null-ptr-deref in sock_kmalloc+0x4a/0x100 net/core/sock.c:2425
Read of size 4 at addr 0000000000000270 by task syz.0.3891/24197

CPU: 3 PID: 24197 Comm: syz.0.3891 Not tainted 5.15.169 #1
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
__kasan_report mm/kasan/report.c:438 [inline]
kasan_report.cold+0x116/0x11b mm/kasan/report.c:451
check_region_inline mm/kasan/generic.c:183 [inline]
kasan_check_range+0xfd/0x1f0 mm/kasan/generic.c:189
instrument_atomic_read include/linux/instrumented.h:71 [inline]
atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
sock_kmalloc+0x4a/0x100 net/core/sock.c:2425
ipv6_renew_options+0x275/0x960 net/ipv6/exthdrs.c:1310
calipso_req_setattr+0x131/0x2e0 net/ipv6/calipso.c:1207
calipso_req_setattr+0x52/0x80 net/netlabel/netlabel_calipso.c:596
netlbl_req_setattr+0x18c/0x580 net/netlabel/netlabel_kapi.c:1224
selinux_netlbl_inet_conn_request+0x1fe/0x330 security/selinux/netlabel.c:337
selinux_inet_conn_request+0x1cc/0x2a0 security/selinux/hooks.c:5583
security_inet_conn_request+0x56/0xb0 security/security.c:2344
tcp_v6_route_req+0x24f/0x520 net/ipv6/tcp_ipv6.c:858
tcp_conn_request+0xaa4/0x3120 net/ipv4/tcp_input.c:6995
tcp_v6_conn_request net/ipv6/tcp_ipv6.c:1218 [inline]
tcp_v6_conn_request+0x24c/0x420 net/ipv6/tcp_ipv6.c:1205
tcp_rcv_state_process+0x9e5/0x47c0 net/ipv4/tcp_input.c:6512
tcp_v6_do_rcv+0x438/0x16b0 net/ipv6/tcp_ipv6.c:1551
tcp_v6_rcv+0x32d4/0x3620 net/ipv6/tcp_ipv6.c:1755
ip6_protocol_deliver_rcu+0x2f5/0x1800 net/ipv6/ip6_input.c:425
ip6_input_finish+0x64/0x1b0 net/ipv6/ip6_input.c:466
NF_HOOK include/linux/netfilter.h:302 [inline]
NF_HOOK include/linux/netfilter.h:296 [inline]
ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:475
dst_input include/net/dst.h:453 [inline]
ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
ip6_rcv_finish net/ipv6/ip6_input.c:69 [inline]
NF_HOOK include/linux/netfilter.h:302 [inline]
NF_HOOK include/linux/netfilter.h:296 [inline]
ipv6_rcv+0x155/0x520 net/ipv6/ip6_input.c:300
__netif_receive_skb_one_core+0x12e/0x1f0 net/core/dev.c:5489
__netif_receive_skb+0x24/0x1b0 net/core/dev.c:5603
process_backlog+0x222/0x820 net/core/dev.c:6480
__napi_poll+0xb9/0x5b0 net/core/dev.c:7039
napi_poll net/core/dev.c:7106 [inline]
net_rx_action+0x8b1/0xbb0 net/core/dev.c:7196
handle_softirqs+0x1bd/0x6e0 kernel/softirq.c:558
do_softirq kernel/softirq.c:459 [inline]
do_softirq+0xad/0xe0 kernel/softirq.c:446
</IRQ>
<TASK>
__local_bh_enable_ip+0xd7/0x100 kernel/softirq.c:383
local_bh_enable include/linux/bottom_half.h:32 [inline]
rcu_read_unlock_bh include/linux/rcupdate.h:809 [inline]
ip6_finish_output2+0xb71/0x1d00 net/ipv6/ip6_output.c:131
__ip6_finish_output.part.0+0x509/0xc10 net/ipv6/ip6_output.c:201
__ip6_finish_output net/ipv6/ip6_output.c:186 [inline]
ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
NF_HOOK_COND include/linux/netfilter.h:291 [inline]
ip6_output+0x30b/0x9f0 net/ipv6/ip6_output.c:234
dst_output include/net/dst.h:443 [inline]
NF_HOOK include/linux/netfilter.h:302 [inline]
NF_HOOK include/linux/netfilter.h:296 [inline]
ip6_xmit+0x1053/0x1d50 net/ipv6/ip6_output.c:338
inet6_csk_xmit+0x36d/0x6f0 net/ipv6/inet6_connection_sock.c:135
__tcp_transmit_skb+0x18d8/0x35a0 net/ipv4/tcp_output.c:1402
tcp_transmit_skb net/ipv4/tcp_output.c:1420 [inline]
tcp_send_syn_data net/ipv4/tcp_output.c:3851 [inline]
tcp_connect+0x23b0/0x4600 net/ipv4/tcp_output.c:3890
tcp_v6_connect+0x1419/0x1c40 net/ipv6/tcp_ipv6.c:337
__inet_stream_connect+0x8d8/0xe70 net/ipv4/af_inet.c:674
tcp_sendmsg_fastopen net/ipv4/tcp.c:1195 [inline]
tcp_sendmsg_locked+0x2004/0x2ce0 net/ipv4/tcp.c:1237
tcp_sendmsg+0x2b/0x50 net/ipv4/tcp.c:1457
inet6_sendmsg+0xb5/0x140 net/ipv6/af_inet6.c:669
sock_sendmsg_nosec net/socket.c:704 [inline]
__sock_sendmsg+0xf2/0x190 net/socket.c:716
__sys_sendto+0x21c/0x320 net/socket.c:2063
__do_sys_sendto net/socket.c:2075 [inline]
__se_sys_sendto net/socket.c:2071 [inline]
__x64_sys_sendto+0xdd/0x1b0 net/socket.c:2071
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x6c/0xd6
RIP: 0033:0x2b4da5fe19c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00002b4da7f5e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00002b4da61fdf80 RCX: 00002b4da5fe19c9
RDX: fffffffffffffedd RSI: 0000000020000280 RDI: 0000000000000004
RBP: 00002b4da608e1b6 R08: 0000000020000080 R09: 000000000000001c
R10: 0000000020000004 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00002b4da61fdf80 R15: 00007ffed7f48918

------------[ cut here end]------------

Root Cause:

The crash is caused by a null pointer dereference detected by
KernelAddressSANitizer (KASAN) within the sock_kmalloc function of the
Linux networking stack. Specifically, the atomic_read operation in
sock_kmalloc is attempting to access memory at address 0x270, which is
invalid or uninitialized. This issue likely arises from an improperly
handled or uninitialized socket structure, leading the kernel to
attempt to read from a null or corrupted pointer. The problem occurs
during the processing of IPv6 connections, involving multiple layers
of the networking and security (SELinux) subsystems. As a result, the
kernel crashes when it tries to access or manipulate this invalid
memory address during socket allocation.

Thank you for your time and attention.

Best regards

Wall

