Return-Path: <netdev+bounces-194784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA7ACC5B5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7521F1891D69
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF20B229B12;
	Tue,  3 Jun 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WMXUD97F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4018C91F
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951171; cv=none; b=mEMOFmcfvxPAy1PCvBdagk61hJGoPqALb9hT6w5hiQnGpMhR/nvFryqw4F+IKHlkEg2HqtTvZS4pEoLbyatbyOYR1fy2ljpk8vO/Np7iSGUGJwpCX+pUf6/01GbmtGtVIrb0KChRw2WzYdUEbpCGTzpg9VCsg8/gmkZqP7t/vTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951171; c=relaxed/simple;
	bh=+ihgwVU+b9zMeEjPYVHveKrm9EftFoF33eyNXadvTxg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iCCjaVG+3nd/IAygooph3JrqCcnsO6nH4kjtlbOgnee88w0eqVmJUwuoOWiQsQNPA/drCWnE1GqtGDU6bbqfuwFJ7IoABtVuw/9xaFNT6Rz4xqG6u4WEOkL1Oq51ftAFXU/7IzkF9GDwD3J6ecuuMzLzYxuZLli3tkcuseW/HkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WMXUD97F; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c597760323so531172685a.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1748951168; x=1749555968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jng2POVZ39+DaVS2ZyIRj7+65RC9AU7gBQf6GvIlGHM=;
        b=WMXUD97FxJTpnd8ZEmeKD9AXNFuzkO4QQFiv153+yqvyHNDKJU+ji+cLcg7ylsfQDd
         9somrtdmWTMugViAbJkUZEUi+EcvOr2XpwYBaN59S1cbZxTfJnUucIyNmSEHjqyhgl2j
         YXfuiD5kVlJKCucs4oBjnyfPXHKsJRhtA2OtUGT1f2acFl+05gd+D2D2HX5/E3skJ7ug
         OiHUpsPqWcVfPcJadJkVK9cROxN2T88tOkILm0WPm3R9LEQZhR9APgXxhvdltsigVYeA
         75GHILu8rXWnj8tvUawr51hg+Hy7yC0v11stDoj02TAucoyTQsTC4f5yebGS8vVZ+vVW
         ukLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748951168; x=1749555968;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jng2POVZ39+DaVS2ZyIRj7+65RC9AU7gBQf6GvIlGHM=;
        b=aUHpmiQbOWwgOF0mvS6+QKK0uA2/WO6IafHG0l8LnYmnlRzP5zDf30/y3WU5CvQ7IR
         LBQWq1IfBVCTNmNEiWdWLfwGoXe4EvlRLAFmHSxBlel09txPOh9lzjaZxtv3r00uSpRK
         fVCXe5XMiNG37sx8x6fjNQEXTTkUcdW8I6bwVoG8MIi9Bk/L/I45ULVynPtc09DKVYZ0
         p3TydSx/urqJDszqvDJmd5yxjvtGd+A4f//n1cmqRUJmy0dM0vJ9G/Dx5RocdxqYjaqX
         k5kbm+LMu1v6nFqhO0jWD25tTr36QrnF9So1B0YEpMxKmXd+wnJgvjzgAC8FDIfgx8mq
         wV3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuFhROYTHlBue7+cLqIAm5VlaeilRgTuWx0drpDwu+wJNpKaaD5B46YKASBXmzpSfOKmj4dEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfPTCegUkO6euKnKqaB7M70aIRbeu0t4drHDE9gPCGAISxMXO
	LRFzLKDw0rxqEoPli47eMYY5fpkX1nW2ZjPUqW4qyWcYr6/a6mXREn+n1Qb+9QiJHw==
X-Gm-Gg: ASbGncsjemzcEofv8TEq00R8kzQ72Xw51gE7xSE6gym4KcX5H2FUCtD6YHeTIa0GeaV
	0VzTKwVUjYDi0BqNF0NzdGvvcgrfjo1nG2o1uzyPyASREVGE6G/So4c547nxyotUCi90QjWGxMx
	biMXwopbs9/16SKqt6LVMr3sXTHs66+uuYIEr4jlDnCfdDXLFHa2+1liR6hms/RdlM0bYbfwDIf
	kWl374wM6cEzrQiRg2i5El09WqQ9tLuKimJJGv1S8GJcYepp23pVMPrSPl5Dtq/5iD9Pbwa/yIp
	Of07f47bpUajEHGtnxncnVB8jCAddOoQ2OjqBxuwmBOqv98uvlZnCJcr8wydYi+1m4UENBkY99E
	2zUnW5BNeNqraHny42jRn2ldcrg==
X-Google-Smtp-Source: AGHT+IHfT4l4UtcdZkWlD3Rmc5LKTQiF8iCdEHtEzyO8iotaUAm8tganF15gnja1setcHoPxtFaQFA==
X-Received: by 2002:a05:620a:44d0:b0:7ce:d352:668f with SMTP id af79cd13be357-7d0a202c5cfmr2697790285a.47.1748951168314;
        Tue, 03 Jun 2025 04:46:08 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f8b61sm829024085a.26.2025.06.03.04.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:46:07 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <edumazet@google.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-security-module@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, John Cheung <john.cs.hey@gmail.com>
Date: Tue, 03 Jun 2025 07:46:04 -0400
Message-ID: <197359ce460.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CANn89iJKc==e5pzCVFN2SBzrmb6=U_5nDEia2LMn8s7wdP9zJg@mail.gmail.com>
References: <20250522221858.91240-1-kuniyu@amazon.com>
 <CAHC9VhTM14E7Mz_ToVEqpW0CQr0KEfpwZOnSzTSYdMxX55k4yQ@mail.gmail.com>
 <CANn89iJKc==e5pzCVFN2SBzrmb6=U_5nDEia2LMn8s7wdP9zJg@mail.gmail.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [PATCH v1 net] calipso: Don't call calipso functions for AF_INET sk.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 3, 2025 6:01:06 AM Eric Dumazet <edumazet@google.com> wrote:
> On Thu, May 22, 2025 at 3:31 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, May 22, 2025 at 6:19 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>>
>>> syzkaller reported a null-ptr-deref in txopt_get(). [0]
>>>
>>> The offset 0x70 was of struct ipv6_txoptions in struct ipv6_pinfo,
>>> so struct ipv6_pinfo was NULL there.
>>>
>>> However, this never happens for IPv6 sockets as inet_sk(sk)->pinet6
>>> is always set in inet6_create(), meaning the socket was not IPv6 one.
>>>
>>> The root cause is missing validation in netlbl_conn_setattr().
>>>
>>> netlbl_conn_setattr() switches branches based on struct
>>> sockaddr.sa_family, which is passed from userspace.  However,
>>> netlbl_conn_setattr() does not check if the address family matches
>>> the socket.
>>>
>>> The syzkaller must have called connect() for an IPv6 address on
>>> an IPv4 socket.
>>>
>>> We have a proper validation in tcp_v[46]_connect(), but
>>> security_socket_connect() is called in the earlier stage.
>>>
>>> Let's copy the validation to netlbl_conn_setattr().
>>>
>>> [0]:
>>> Oops: general protection fault, probably for non-canonical address 
>>> 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN NOPTI
>>> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
>>> CPU: 2 UID: 0 PID: 12928 Comm: syz.9.1677 Not tainted 6.12.0 #1
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>> RIP: 0010:txopt_get include/net/ipv6.h:390 [inline]
>>> RIP: 0010:
>>> Code: 02 00 00 49 8b ac 24 f8 02 00 00 e8 84 69 2a fd e8 ff 00 16 fd 48 8d 
>>> 7d 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 
>>> 85 53 02 00 00 48 8b 6d 70 48 85 ed 0f 84 ab 01 00
>>> RSP: 0018:ffff88811b8afc48 EFLAGS: 00010212
>>> RAX: dffffc0000000000 RBX: 1ffff11023715f8a RCX: ffffffff841ab00c
>>> RDX: 000000000000000e RSI: ffffc90007d9e000 RDI: 0000000000000070
>>> RBP: 0000000000000000 R08: ffffed1023715f9d R09: ffffed1023715f9e
>>> R10: ffffed1023715f9d R11: 0000000000000003 R12: ffff888123075f00
>>> R13: ffff88810245bd80 R14: ffff888113646780 R15: ffff888100578a80
>>> FS:  00007f9019bd7640(0000) GS:ffff8882d2d00000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f901b927bac CR3: 0000000104788003 CR4: 0000000000770ef0
>>> PKRU: 80000000
>>> Call Trace:
>>> <TASK>
>>> calipso_sock_setattr+0x56/0x80 net/netlabel/netlabel_calipso.c:557
>>> netlbl_conn_setattr+0x10c/0x280 net/netlabel/netlabel_kapi.c:1177
>>> selinux_netlbl_socket_connect_helper+0xd3/0x1b0 security/selinux/netlabel.c:569
>>> selinux_netlbl_socket_connect_locked security/selinux/netlabel.c:597 [inline]
>>> selinux_netlbl_socket_connect+0xb6/0x100 security/selinux/netlabel.c:615
>>> selinux_socket_connect+0x5f/0x80 security/selinux/hooks.c:4931
>>> security_socket_connect+0x50/0xa0 security/security.c:4598
>>> __sys_connect_file+0xa4/0x190 net/socket.c:2067
>>> __sys_connect+0x12c/0x170 net/socket.c:2088
>>> __do_sys_connect net/socket.c:2098 [inline]
>>> __se_sys_connect net/socket.c:2095 [inline]
>>> __x64_sys_connect+0x73/0xb0 net/socket.c:2095
>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>> do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f901b61a12d
>>> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 
>>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff 
>>> ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f9019bd6fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
>>> RAX: ffffffffffffffda RBX: 00007f901b925fa0 RCX: 00007f901b61a12d
>>> RDX: 000000000000001c RSI: 0000200000000140 RDI: 0000000000000003
>>> RBP: 00007f901b701505 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 0000000000000000 R14: 00007f901b5b62a0 R15: 00007f9019bb7000
>>> </TASK>
>>> Modules linked in:
>>>
>>> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the 
>>> secattr.")
>>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>>> Reported-by: John Cheung <john.cs.hey@gmail.com>
>>> Closes: 
>>> https://lore.kernel.org/netdev/CAP=Rh=M1LzunrcQB1fSGauMrJrhL6GGps5cPAKzHJXj6GQV+-g@mail.gmail.com/
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>> ---
>>> net/netlabel/netlabel_kapi.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>
>> Looks good to me, thanks for tracking this down and fixing it :)
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>>
>>> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
>>> index cd9160bbc919..6ea16138582c 100644
>>> --- a/net/netlabel/netlabel_kapi.c
>>> +++ b/net/netlabel/netlabel_kapi.c
>>> @@ -1165,6 +1165,9 @@ int netlbl_conn_setattr(struct sock *sk,
>>>          break;
>>> #if IS_ENABLED(CONFIG_IPV6)
>>>  case AF_INET6:
>>> +               if (sk->sk_family != AF_INET6)
>>> +                       return -EAFNOSUPPORT;
>
> A more correct fix would be to not return with rcu_read_lock() held :/
>
> I will send this :
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 
> 6ea16138582c0b6ad39608f2c08bdfde7493a13e..33b77084a4e5f34770f960d7c82e481d9889753a
> 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1165,8 +1165,10 @@ int netlbl_conn_setattr(struct sock *sk,
>                break;
> #if IS_ENABLED(CONFIG_IPV6)
>        case AF_INET6:
> -               if (sk->sk_family != AF_INET6)
> -                       return -EAFNOSUPPORT;
> +               if (sk->sk_family != AF_INET6) {
> +                       ret_val = -EAFNOSUPPORT;
> +                       goto conn_setattr_return;
> +               }
>
>                addr6 = (struct sockaddr_in6 *)addr;
>                entry = netlbl_domhsh_getentry_af6(secattr->domain,

My apologies for not catching that, thanks Eric.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com




