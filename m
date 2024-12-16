Return-Path: <netdev+bounces-152203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2FC9F317F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A037A053A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBC2054E6;
	Mon, 16 Dec 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8wqXd6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD17204F6B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355766; cv=none; b=QBKOj/kyxrJXxXOlko5Tr6zyP11ET1mB4kNOJhJyS1D90cs/QnwkWO9qEqE3pqgrJfaGTN8NBnYRhW9WF6PA1RS79jnhQJESwG2ZfdREohPoA3PstAufPgScuP/v2uJcyapD0x+1nvqmb7iqmkfVZj+1LFAnXz1El/xPtJ9yMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355766; c=relaxed/simple;
	bh=VAv70qrqiNi4ICOgv0yfM+dsX5zz+O2bqeDusinlGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfpQRHZwnOivdCxGs3eSY0BlCs6nUGq7hqMvo0e15p31GncHFP/NpUEwktORJPzB4ZROnwl2A7GRB7IkgrLmnUS/iflnRspsk+oQQ13cG9Lu7+5XOyyglc7nzwt49lkFQinPTRyd253b2G+BAE1dgriCthwqkHiLcIO/3upLO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8wqXd6+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso7415612a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734355763; x=1734960563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdFfWjEz9OKrUjwNAogLJrpv23QbUmdVV5IT3o9T1G8=;
        b=E8wqXd6+edi9ZD+RA6JdOrYN5N94HPz1KIdtqeS3ztgu+TxKhhT21lAXNsXP4PVGH4
         chOK8GGGdWW2fd2fTxz5bOd0+HEL/ZqRQwXwMwYr9X+0ChXZTjPtu8qgLQgPBWJYNXKC
         ineZaMPfe2uYKgin93oAA9/IZfZTE8V7T1Ide7q1Wss417lByk+amjUe3U4MXwn8ib+P
         i13pUTIrngm8Lga5aHA9PhXdpKITLZ5TCm75LFmUsS7XZH9OLgnTpTBq0yqBWpfXzQbs
         HMONmlrtADmYJTMr2PxUJfVJBvI6QVMQa7ZWTkCbdvl3B5VnmRkHBMBFx2VjxMUEol18
         DMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734355763; x=1734960563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdFfWjEz9OKrUjwNAogLJrpv23QbUmdVV5IT3o9T1G8=;
        b=nxaDU6O3NtGyeJIIjoGVReec8a0w3TM6qjIYD9vc0/6JY+08y0+3CZUtaGNB8ZcEdV
         mHd473UFKyCSCYX8cuGl+vGf7EpEpCn3LpTFWy93DxyztgYlhQQ04DmvrMVSuIBzMses
         54rw8ylYLnUlOGwLHkrHIksuZmRKn2V7NUETm+V5xpKdc4wqoeQCEDn0iiLPF7AUqonu
         CgcXRZDEufPAXy0AOIw8ULXyiGtsio7Zo/rh+q0ZLw01fH6Zj2vYd3eNtKUKGTa9zgq5
         mP+VKDuYJE+NqE2aMaNcqIbzPPpGvVilb9PKvAWVqaT8/Q1ARkqceE22AQmQhfxOH5iM
         vAUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1UNWVmsSi3DLjaTOYRVLl6RaoTaTqjMoKzWWSZ+8AiaHJDUs+JmfhfjrkJNx1RTmDGCte50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hBa8TZcDPCUtNrDCk8AVIp0wKWMYgZE+kwhMRNn99+77UEpF
	ASG5BXQ2ZauWHkHsC9XsUL8nPcHVXaz9gOY+3Qm++uMnGz4rpKIJVsOroT5a3jKlrTszhTK9Dna
	slsX84RZinD7xZrDFaRlucjsGaJBH0d044YTd
X-Gm-Gg: ASbGncucL+b9HJLMXkPpz7aqJUWe46u+U607tJHbsccvjDrG8BJl6m9ObCE6qLap6XP
	niIhOdh0GitKPXMrOwNlubwm0ug/kakvxPMUmRllPY13jEUeEELlr7POkSoPLdXipaqrzhtE4
X-Google-Smtp-Source: AGHT+IGaxDUJw3NEpu2g/UUh60E0wvDhADBpA39iICJdvJxeTDO3MeoHEXC6Guup5NVqR0rj37XlESqDNcPSFS7C31U=
X-Received: by 2002:a05:6402:3889:b0:5d0:d0c5:f259 with SMTP id
 4fb4d7f45d1cf-5d63c1d3559mr11164556a12.3.1734355763457; Mon, 16 Dec 2024
 05:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Dec 2024 14:29:12 +0100
Message-ID: <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: "brianvv@google.com" <brianvv@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "martin.lau@kernel.org" <martin.lau@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Ziyad Atiyyeh <ziyadat@nvidia.com>, Dror Tennenbaum <drort@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 2:18=E2=80=AFPM Shahar Shitrit <shshitrit@nvidia.co=
m> wrote:
>
> Hello,
>
>
>
> We observe memory leaks reported by kmemleak when using IPSec in transpor=
t mode with crypto offload.
>
> The leaks reproduce for TX offload, RX offload and both.
>
> The leaks as shown in stack trace can be seen below.
>
>
>
> The issue has been bisected to this commit 507a96737d99686ca1714c7ba1f60a=
c323178189.
>
>

Nothing comes to mind. This might be an old bug in loopback paths.

>
> The leaks reproduce frequently in daily regression runs.
>
> We tried to reproduce it manually with ipv6 configurations on both sides,=
 IPSec configurations and iperf3 traffic, but didn't manage to trigger it s=
o far.
>
>
>
> We can provide more information if needed.
>
>
>
> Regards,
>
> Shahar Shitrit
>
>
>
>
>
> Initiate kmemleak scan
> ERROR: Detected 5 memory leaks in the log
> Nov 04 10:30:05 c-237-113-80-081 kernel: kmemleak: 5 new suspected memory=
 leaks (see /sys/kernel/debug/kmemleak)
> unreferenced object 0xffff8881a3a94240 (size 3264):
>   comm "iperf3", pid 45263, jiffies 4296417151
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     0a 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
>   backtrace (crc bbd45a15):
>     [<00000000e06ca7f4>] kmem_cache_alloc_noprof+0x225/0x3e0
>     [<00000000e1e2f493>] sk_prot_alloc+0x5a/0x230
>     [<000000001213af38>] sk_alloc+0x30/0x360
>     [<00000000a1686abe>] inet6_create+0x29e/0x10c0
>     [<00000000db62dfa0>] __sock_create+0x25a/0x650
>     [<00000000f8c982c4>] __sys_socket+0x114/0x1d0
>     [<00000000a045d271>] __x64_sys_socket+0x6e/0xb0
>     [<00000000102c0964>] do_syscall_64+0x6d/0x140
>     [<00000000a454f7f5>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
> unreferenced object 0xffff88814b45d900 (size 232):
>   comm "softirq", pid 0, jiffies 4296417840
>   hex dump (first 32 bytes):
>     00 80 ce 0c 81 88 ff ff 40 07 fa 87 ff ff ff ff  ........@.......
>     e1 6a 00 84 ff ff ff ff 00 00 00 00 00 00 00 00  .j..............
>   backtrace (crc bfc5fbc4):
>     [<00000000e06ca7f4>] kmem_cache_alloc_noprof+0x225/0x3e0
>     [<00000000d81ccda7>] dst_alloc+0x76/0x140
>     [<0000000030d3284e>] ip6_dst_alloc+0x1f/0x80
>     [<000000007e198912>] ip6_pol_route+0x722/0xc60
>     [<000000005535207e>] fib6_rule_lookup+0x10e/0x5f0
>     [<00000000806ddab6>] ip6_route_input+0x5cd/0xa50
>     [<0000000030a268eb>] ip6_list_rcv_finish.constprop.0+0x1a5/0x9a0
>     [<00000000e6c0deb7>] ipv6_list_rcv+0x2cc/0x400
>     [<00000000eed4d9ac>] __netif_receive_skb_list_core+0x496/0x8c0
>     [<000000005616f892>] netif_receive_skb_list_internal+0x60f/0xd30
>     [<000000008137f84a>] napi_complete_done+0x1a4/0x7e0
>     [<0000000070f546d4>] gro_cell_poll+0x112/0x1e0
>     [<0000000068db02b9>] __napi_poll.constprop.0+0xa3/0x5b0
>     [<00000000e5987926>] net_rx_action+0x4fd/0xce0
>     [<00000000571a033c>] handle_softirqs+0x266/0x840
>     [<000000009757e476>] irq_exit_rcu+0xc3/0x100
> unreferenced object 0xffff88811a0f3500 (size 3264):
>   comm "softirq", pid 0, jiffies 4296417842
>   hex dump (first 32 bytes):
>     7f 00 00 06 7f 00 00 06 38 a1 90 0b aa 86 00 00  ........8.......
>     0a 00 07 41 00 00 00 00 58 42 0f 1a 81 88 ff ff  ...A....XB......
>   backtrace (crc 65fda5f0):
>     [<00000000e06ca7f4>] kmem_cache_alloc_noprof+0x225/0x3e0
>     [<00000000e1e2f493>] sk_prot_alloc+0x5a/0x230
>     [<000000008b3eab13>] sk_clone_lock+0x6a/0xfd0
>     [<00000000e061c828>] inet_csk_clone_lock+0x1a/0x4e0
>     [<0000000071a69e46>] tcp_create_openreq_child+0x26/0x1830
>     [<0000000065ed76dc>] tcp_v6_syn_recv_sock+0x165/0x1ee0
>     [<000000003535f9c5>] tcp_check_req+0x38b/0x1440
>     [<0000000073b86243>] tcp_v6_rcv+0x13ef/0x38a0
>     [<000000001734e1c2>] ip6_protocol_deliver_rcu+0x10f/0x11f0
>     [<00000000ec2e87d3>] ip6_input_finish+0x155/0x2a0
>     [<00000000a1de2827>] ip6_sublist_rcv_finish+0x8d/0x250
>     [<00000000b156115a>] ip6_list_rcv_finish.constprop.0+0x5cd/0x9a0
>     [<00000000e6c0deb7>] ipv6_list_rcv+0x2cc/0x400
>     [<00000000eed4d9ac>] __netif_receive_skb_list_core+0x496/0x8c0
>     [<000000005616f892>] netif_receive_skb_list_internal+0x60f/0xd30
>     [<000000008137f84a>] napi_complete_done+0x1a4/0x7e0
> unreferenced object 0xffff88813a93dcc0 (size 3264):
>   comm "iperf3", pid 45340, jiffies 4296426688
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     0a 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
>   backtrace (crc ce0c3519):
>     [<00000000e06ca7f4>] kmem_cache_alloc_noprof+0x225/0x3e0
>     [<00000000e1e2f493>] sk_prot_alloc+0x5a/0x230
>     [<000000001213af38>] sk_alloc+0x30/0x360
>     [<00000000a1686abe>] inet6_create+0x29e/0x10c0
>     [<00000000db62dfa0>] __sock_create+0x25a/0x650
>     [<00000000f8c982c4>] __sys_socket+0x114/0x1d0
>     [<00000000a045d271>] __x64_sys_socket+0x6e/0xb0
>     [<00000000102c0964>] do_syscall_64+0x6d/0x140
>     [<00000000a454f7f5>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
> runtime: 3m24s
> TEST FAILED
>
>
>
>

