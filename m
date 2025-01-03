Return-Path: <netdev+bounces-154926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8428AA005C6
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8036A1883B36
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8C1C5F3C;
	Fri,  3 Jan 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBB/iPOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A51BEF9B
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892971; cv=none; b=BtkCF786dEuvik9ubErCAW+9eQ5crlRTMKSyuFxLOZfzw6198AJssIvPS0kdL2xhQzHNnhwU5a3VD1g/01ftsnOIPbIovb0TyrGgm1vhGohRliHlxu9oV0OeP1Xxg0VpsU5H9V23MDX5SjCs8biOZY1HTt1c3b21COsN0OMHjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892971; c=relaxed/simple;
	bh=TD4FAtlzxf5iaB+S3ZRmmTIhO+WtxCUhdpgpIS0yMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfWi/Bi3SiZ/YQm6DwV3u90sJBoRx/9WdG27kqUXGkQ53xSVLXCITvsLduM5EcEdsIq4Ng0WmF8jVfJ4xi0w2JC06NUeiiYDfZJiAk+hs7rJwqD51kMH0XMRnZeeinDFcE+t5cG5izIWngcfBjqTUG0/eROscr2JYu77Wtq2liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBB/iPOf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso23604356a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735892968; x=1736497768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LiYjmhM0zkf/eROv6zR3Ju2NCy1IB1JvopZ5i0GDBM=;
        b=MBB/iPOfxbHIImGzPfzijf3zD81pdBRkoBR3uQR4iSUbD0Cvc6LkLQat1H3UYNIx+R
         jLEUy83wt20/qLC7FFQfYdJlIj3tHiuYfPD29B4w/hT+7Xy/jCa8mWvUczydgFiRWpK1
         r1K4R7KkUHV0WPDJ3rhUMeCehmx3DQOOvxD17WELbn3SdtSfj12MjTWptdIjPBBSNAoh
         GwCbLllmIsUMAJS7wLVEklLnRyvHeHxXqpacgDTGnc2VHXfvmtuVu3T3UCJfrVCTQYRM
         ljiwm3hcRkidOL86DgA/zB2QMa1H8KsqQ4LiFtGZUjaPC2jJUmqGy7JwqzDo/vd3f4xA
         wyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892968; x=1736497768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LiYjmhM0zkf/eROv6zR3Ju2NCy1IB1JvopZ5i0GDBM=;
        b=av+ajg9M/UklnaSX/j0qea8EF06LFZaUK0jjTC2amkU8wSBzcY33SvcB6UReRLWBm7
         aVl5Sdxr2Z4JKGjs1FCGhQblNQWQS6494KRhMTa7IoAac4CLuk9negwgw2/SrwPgL8uK
         W2wIn9au+BMKuh4s1vgDpCiNJT/1ZXHOZIcd+00x9pH9+Llfw0Gkpqd/eSHpKjUpff25
         KDASPFPXyWdTUjPoVB8Hp/R9/0ADmQT8AGSvcuWco9uwJrZsIiRhldYPo00lRJbBwIvZ
         rkVkhDd5nvpKCfux+Mtw8qdhOH110Kag0lQZb9Stpquo28WXT1SHFrcrA95vaS+l2h9j
         eqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVUZ5L/C4hDr6MUJPe7sH1x/1K6GjXQpJZqt032ALTARl5VFWVCJU5lNe3cbiu29ppK1aTykn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywow4FP+gjKIItCx9k+FMg5GxG2/9UVCLDIe0dTBs0fm+CLu6/s
	+MvNlwhB3iBAwAzuG9j0rH7Gev6jiehAMo6Xx6B/mUqoScppHQDEgFQrCa7WbTDrse0dFfIBeyE
	PZ+mUR8mszNzOXicx3xU/BBVklxd7wm9vZHKB
X-Gm-Gg: ASbGncv3TUUooEjmf3XQ7BKb1K132SQN1b2tUUI5aGg6Cq4DerB61AmpWvFvYUOjo5k
	PhxeJFhCzocqVzGBT+LVTrO+QNGCkr1B3L8NPQas=
X-Google-Smtp-Source: AGHT+IHpO6L8kyzubsBZ2EPjidxzEK2+YTfxygKTNxu7xdhbWmvM7Lh2F1XWkvqENiH9QzQ5ruXMUvWhxDAH8UqpKvA=
X-Received: by 2002:a05:6402:3510:b0:5d0:e2c8:dc8d with SMTP id
 4fb4d7f45d1cf-5d81ddfe37cmr44979883a12.20.1735892967791; Fri, 03 Jan 2025
 00:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHoSAt_KtBEBHoc3ucdCdMVy89unQPBCKrM3oTA=Kz4Nqpjjw@mail.gmail.com>
 <CANn89iLr7-2utF1TbiS+ddHNWvBFhf-q3rDVt3g4B5xuz987HA@mail.gmail.com>
In-Reply-To: <CANn89iLr7-2utF1TbiS+ddHNWvBFhf-q3rDVt3g4B5xuz987HA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 09:29:16 +0100
Message-ID: <CANn89iLpmrsA+uMhr70yVsfWMwP5BWD7SEMjgGUFbvX1vLYhtg@mail.gmail.com>
Subject: Re: "KASAN: null-ptr-deref Read in ipv6_renew_options" in Linux
 kernel version 6.13.0-rc2
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Jan 3, 2025 at 8:16=E2=80=AFAM cheung wall <zzqq0103.hey@gmail.co=
m> wrote:
> >
> > Hello,
> >
> > I am writing to report a potential vulnerability identified in the
> > Linux Kernel version 6.13.0-rc2. This issue was discovered using our
> > custom vulnerability discovery tool.
> >
> > HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)
> >
> > Affected File: net/ipv6/exthdrs.c
> >
> > File: net/ipv6/exthdrs.c
> >
> > Function: ipv6_renew_options
> >
> > Detailed Call Stack:
> >
> > ------------[ cut here begin]------------
> >
> > netlink: 'syz.0.3890': attribute type 4 has an invalid length.
> > TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending
> > cookies. Check SNMP counters.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: null-ptr-deref in instrument_atomic_read
> > include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: null-ptr-deref in atomic_read
> > include/linux/atomic/atomic-instrumented.h:27 [inline]
> > BUG: KASAN: null-ptr-deref in sock_kmalloc+0x4a/0x100 net/core/sock.c:2=
425
> > Read of size 4 at addr 0000000000000270 by task syz.0.3891/24197
> >
> > CPU: 3 PID: 24197 Comm: syz.0.3891 Not tainted 5.15.169 #1
> > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> > 1.16.3-debian-1.16.3-2 04/01/2014

BTW this stack trace is for 5.15.169, not 6.13 as claimed in your email ???

Please do not post syzbot traces for old kernels.

> > Call Trace:
> > <IRQ>
> > __dump_stack lib/dump_stack.c:88 [inline]
> > dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
> > __kasan_report mm/kasan/report.c:438 [inline]
> > kasan_report.cold+0x116/0x11b mm/kasan/report.c:451
> > check_region_inline mm/kasan/generic.c:183 [inline]
> > kasan_check_range+0xfd/0x1f0 mm/kasan/generic.c:189
> > instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
> > sock_kmalloc+0x4a/0x100 net/core/sock.c:2425
> > ipv6_renew_options+0x275/0x960 net/ipv6/exthdrs.c:1310
> > calipso_req_setattr+0x131/0x2e0 net/ipv6/calipso.c:1207
> > calipso_req_setattr+0x52/0x80 net/netlabel/netlabel_calipso.c:596
> > netlbl_req_setattr+0x18c/0x580 net/netlabel/netlabel_kapi.c:1224
> > selinux_netlbl_inet_conn_request+0x1fe/0x330 security/selinux/netlabel.=
c:337
> > selinux_inet_conn_request+0x1cc/0x2a0 security/selinux/hooks.c:5583
> > security_inet_conn_request+0x56/0xb0 security/security.c:2344
> > tcp_v6_route_req+0x24f/0x520 net/ipv6/tcp_ipv6.c:858
> > tcp_conn_request+0xaa4/0x3120 net/ipv4/tcp_input.c:6995
> > tcp_v6_conn_request net/ipv6/tcp_ipv6.c:1218 [inline]
> > tcp_v6_conn_request+0x24c/0x420 net/ipv6/tcp_ipv6.c:1205
> > tcp_rcv_state_process+0x9e5/0x47c0 net/ipv4/tcp_input.c:6512
> > tcp_v6_do_rcv+0x438/0x16b0 net/ipv6/tcp_ipv6.c:1551
> > tcp_v6_rcv+0x32d4/0x3620 net/ipv6/tcp_ipv6.c:1755
> > ip6_protocol_deliver_rcu+0x2f5/0x1800 net/ipv6/ip6_input.c:425
> > ip6_input_finish+0x64/0x1b0 net/ipv6/ip6_input.c:466
> > NF_HOOK include/linux/netfilter.h:302 [inline]
> > NF_HOOK include/linux/netfilter.h:296 [inline]
> > ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:475
> > dst_input include/net/dst.h:453 [inline]
> > ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> > ip6_rcv_finish net/ipv6/ip6_input.c:69 [inline]
> > NF_HOOK include/linux/netfilter.h:302 [inline]
> > NF_HOOK include/linux/netfilter.h:296 [inline]
> > ipv6_rcv+0x155/0x520 net/ipv6/ip6_input.c:300
> > __netif_receive_skb_one_core+0x12e/0x1f0 net/core/dev.c:5489
> > __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5603
> > process_backlog+0x222/0x820 net/core/dev.c:6480
> > __napi_poll+0xb9/0x5b0 net/core/dev.c:7039
> > napi_poll net/core/dev.c:7106 [inline]
> > net_rx_action+0x8b1/0xbb0 net/core/dev.c:7196
> > handle_softirqs+0x1bd/0x6e0 kernel/softirq.c:558
> > do_softirq kernel/softirq.c:459 [inline]
> > do_softirq+0xad/0xe0 kernel/softirq.c:446
> > </IRQ>
> > <TASK>
> > __local_bh_enable_ip+0xd7/0x100 kernel/softirq.c:383
> > local_bh_enable include/linux/bottom_half.h:32 [inline]
> > rcu_read_unlock_bh include/linux/rcupdate.h:809 [inline]
> > ip6_finish_output2+0xb71/0x1d00 net/ipv6/ip6_output.c:131
> > __ip6_finish_output.part.0+0x509/0xc10 net/ipv6/ip6_output.c:201
> > __ip6_finish_output net/ipv6/ip6_output.c:186 [inline]
> > ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
> > NF_HOOK_COND include/linux/netfilter.h:291 [inline]
> > ip6_output+0x30b/0x9f0 net/ipv6/ip6_output.c:234
> > dst_output include/net/dst.h:443 [inline]
> > NF_HOOK include/linux/netfilter.h:302 [inline]
> > NF_HOOK include/linux/netfilter.h:296 [inline]
> > ip6_xmit+0x1053/0x1d50 net/ipv6/ip6_output.c:338
> > inet6_csk_xmit+0x36d/0x6f0 net/ipv6/inet6_connection_sock.c:135
> > __tcp_transmit_skb+0x18d8/0x35a0 net/ipv4/tcp_output.c:1402
> > tcp_transmit_skb net/ipv4/tcp_output.c:1420 [inline]
> > tcp_send_syn_data net/ipv4/tcp_output.c:3851 [inline]
> > tcp_connect+0x23b0/0x4600 net/ipv4/tcp_output.c:3890
> > tcp_v6_connect+0x1419/0x1c40 net/ipv6/tcp_ipv6.c:337
> > __inet_stream_connect+0x8d8/0xe70 net/ipv4/af_inet.c:674
> > tcp_sendmsg_fastopen net/ipv4/tcp.c:1195 [inline]
> > tcp_sendmsg_locked+0x2004/0x2ce0 net/ipv4/tcp.c:1237
> > tcp_sendmsg+0x2b/0x50 net/ipv4/tcp.c:1457
> > inet6_sendmsg+0xb5/0x140 net/ipv6/af_inet6.c:669
> > sock_sendmsg_nosec net/socket.c:704 [inline]
> > __sock_sendmsg+0xf2/0x190 net/socket.c:716
> > __sys_sendto+0x21c/0x320 net/socket.c:2063
> > __do_sys_sendto net/socket.c:2075 [inline]
> > __se_sys_sendto net/socket.c:2071 [inline]
> > __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2071
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x6c/0xd6
> > RIP: 0033:0x2b4da5fe19c9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00002b4da7f5e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00002b4da61fdf80 RCX: 00002b4da5fe19c9
> > RDX: fffffffffffffedd RSI: 0000000020000280 RDI: 0000000000000004
> > RBP: 00002b4da608e1b6 R08: 0000000020000080 R09: 000000000000001c
> > R10: 0000000020000004 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00002b4da61fdf80 R15: 00007ffed7f48918
> >
> > ------------[ cut here end]------------
> >
> > Root Cause:
> >
> > The crash is caused by a null pointer dereference detected by
> > KernelAddressSANitizer (KASAN) within the sock_kmalloc function of the
> > Linux networking stack. Specifically, the atomic_read operation in
> > sock_kmalloc is attempting to access memory at address 0x270, which is
> > invalid or uninitialized. This issue likely arises from an improperly
> > handled or uninitialized socket structure, leading the kernel to
> > attempt to read from a null or corrupted pointer. The problem occurs
> > during the processing of IPv6 connections, involving multiple layers
> > of the networking and security (SELinux) subsystems. As a result, the
> > kernel crashes when it tries to access or manipulate this invalid
> > memory address during socket allocation.
> >
>
> Yeah, the 'root cause' section seems to be AI generated, you are
> rephrasing the report.
>
> I have an idea of the root cause, I had a syzbot report for the same
> issue in my queue.
>
> A similar bug was fixed in
>
> commit eedcad2f2a371786f8a32d0046794103dadcedf3
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Nov 26 14:59:11 2024 +0000
>
>     selinux: use sk_to_full_sk() in selinux_ip_output()
>
>
>
> Thanks.
>
> > Thank you for your time and attention.
> >
> > Best regards
> >
> > Wall

