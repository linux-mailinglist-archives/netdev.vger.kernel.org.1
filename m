Return-Path: <netdev+bounces-196716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9BAD60A6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574181E113C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6F23E355;
	Wed, 11 Jun 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqxUQzh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCC19A
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675994; cv=none; b=T5yPWws0VmqOn6zhlrLc+fGvtBQZuQvkJo45VFg8cGJFWN2MgAoh3QiM3PuDcNwBbSMS2FZEZ0UoFDZhBUDmqZ0qWisJUWKAvmUIHqsJ2ji6B+uk113rvoeUJXqtZZlI8HmPDzxEMJ7HptU3UhEcq0yd/ZiF62CUfQhKRXKOHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675994; c=relaxed/simple;
	bh=wvgAb2FqJAawbrjQjx2wJEGlkxQADIg2B0krO+/lfGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RivgAakk266LEEUez49rmlUwXS8nzn8wTR9lMTDnqFUSAL+t3HsHNe1nq2PELBgkS+BHgivPeoidWt1gXB5WxpgDhRV9hyaaZg3xlu162I+7ykX3Wg1xgQh7DbuEN+UMvEqKVdzgaUEaYrklLwHmKp8dG+XVhgyoamWkcRnhBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqxUQzh6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so357285b3a.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675992; x=1750280792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43B3Wj+dfSFoXoBSfombz/oJnumxEkfSEIEr/e0BkJs=;
        b=jqxUQzh6Kd5Dl9kgUvgO9L/q2T9VNl0CX//LJRP19SArUY9DUaRCg12SgjMh79iZz6
         sfU87dpUq9MmN9fBgbJhyVvcdPd5Fqm/RhjXWFYA36EQ2DwJJ7oJhPvPkVAPKygWtY0Q
         5KkMzx862/hRAEhRD/dAyL+HEWBL1/Kv3+CY9k5cpW+zV65r3K5ZWzU+qxqbcKjJRoeo
         wAf5YVdb+OqmiyNEolLZ0nfm1P9gkkjC30aDoMYN50TvSoZzQk1uBa/BahqmMfdeHc1i
         jPBqGe+baCM+rVp8siuR3uy31cVw125WEd+dfpmiHhDhSNvdrBWGZEECSKMYNNVLZUL6
         8Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675992; x=1750280792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43B3Wj+dfSFoXoBSfombz/oJnumxEkfSEIEr/e0BkJs=;
        b=pJgCtAKUdYU9J+EPL4YEE2LKULND0bIKBnTRZZQSUg9K2ByEYCqBtFubizW+kFOHU+
         Wi1KScS8VwvJlSDe/o2hh3pndQ+evVtuaEsfHMgn+UyUXozyG+SbjwW2XuhmE2Su+k2Q
         Ai1YrNTuIN0pr1/RmEF9xXPplOTDOjz8IJbe/V1BLS+8PSumbMqm0JlCmWw2A436ukDk
         mTHVpJ1secspKWzvt84ms+PL5hp96+P8YuG2DaN3pP4L2Gfvwum4qGKFeAIEBF8o+c7H
         sjHRXjiWIgVxD7s56rtcGThrNIPPkFFF4d5q42rySaUhLEDs1ZC5rg8Rb0/GpWzRMpG3
         2awg==
X-Forwarded-Encrypted: i=1; AJvYcCXHpPPNL4I7RGDWEth/bA+OgmF/OS/9JfYVC7LdBLWQipHR7Qv59PC7S49bMmEAArJSAZvs89I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxDxyF2JA5glMBZfG0PxLIuaG6rBoIZd8q9o07itLWzIFac6b
	2ShnZDMk559Qn2BOB+AdR0iezqNmbDeDY/3k5ahIOm8vDJd8F364gtc=
X-Gm-Gg: ASbGncu7C8NdUboCJB6lNWUktvwLlZg0p+77cKezZF/246om8RHTfkRVXP84BDu6iRX
	+kkwea4u7E0Bez/CSNx9AP83eTwNjtpZyGPyUAiikuECJANbsbzn5YvzH0H0s8oLcY17cz9XR1f
	V3p114yE6FZWvqbjYn/wxSXW7SiEEMns5yoIq+WfhQCfRY4hqDHArdt2SVOvr7IZnbRF9swjOf6
	8B9NsXMRPNaS0PI0w5ub+XXkfXIvCA2vyXqjd6v+W0/ly9xB2ifgV5UASW1lPKaJlU3AaDKyJ1G
	d0nvrvGBPqyS++IcQfo1ycDUllSp61N6Iu5jGfc=
X-Google-Smtp-Source: AGHT+IGQMyTtvtdVnTsrPdCeMtURnJ4RC3zZ8hAU2H7KlTBZWURnNvvocs9a9Q4K1iMaCUysIgGUBQ==
X-Received: by 2002:a05:6a00:3a17:b0:742:aecc:c47c with SMTP id d2e1a72fcca58-7486cb480damr6909662b3a.7.1749675991408;
        Wed, 11 Jun 2025 14:06:31 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087aa34sm11784b3a.12.2025.06.11.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:06:30 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	idosch@nvidia.com,
	kuniyu@google.com,
	mlxsw@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petrm@nvidia.com,
	razor@blackwall.org
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing locally-generated MC packets
Date: Wed, 11 Jun 2025 14:03:20 -0700
Message-ID: <20250611210629.3099711-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611132320.53c5bebc@kernel.org>
References: <20250611132320.53c5bebc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 11 Jun 2025 13:23:20 -0700
> On Wed, 11 Jun 2025 17:30:15 +0200 Petr Machata wrote:
> > Could it actually have been caused by another test? The howto page
> > mentions that the CI is running the tests one at a time, so I don't
> > suppose that's a possibility.
> > 
> > I'll try to run a more fuller suite tomorrow and star at the code a bit
> > to see if I might be missing an error branch or something.
> 
> We also hit a crash in ipv6 fcnal.sh, too. Looks like this is either a
> kmemleak false positive or possibly related to the rtnl changes in ipv6.
> Either way I it's not related to you changes, sorry about that! :(
> 
> [ 2900.792890] BUG: kernel NULL pointer dereference, address: 0000000000000108
> [ 2900.792961] #PF: supervisor read access in kernel mode
> [ 2900.793017] #PF: error_code(0x0000) - not-present page
> [ 2900.793053] PGD 8fd6067 P4D 8fd6067 PUD 6402067 PMD 0 
> [ 2900.793097] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 2900.793127] CPU: 0 UID: 0 PID: 15652 Comm: nettest Not tainted 6.15.0-virtme #1 PREEMPT(voluntary) 
> [ 2900.793200] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 2900.793245] RIP: 0010:ip6_pol_route+0x286/0x4a0

fwiw, my local syzkaller had the same splat on 6a325aed130b,
where my IPv6 series hadn't landed, and syzbot had a similar
one on f1b785f4c787, where my RTNL work was on the prep stage,
so I think this is an old? bug :)

I'll see if the .syz repro in the report still works on the latest.

syzbot:
https://lore.kernel.org/netdev/67a21f26.050a0220.163cdc.0068.GAE@google.com/

syzkaller:
---8<---
BUG: unable to handle page fault for address: 00007f93e4d51a23
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12cd4c067 P4D 125130067 PUD 0 
Oops: Oops: 0000 [#1] SMP
CPU: 1 UID: 0 PID: 2259 Comm: syz.2.555 Not tainted 6.15.0-rc1-00220-g6a325aed130b #2 PREEMPT(voluntary)  fb2957dd255dfc2983199dfa2ccdedc09370f316
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:rt_genid_ipv6 include/net/net_namespace.h:537 [inline]
RIP: 0010:rt6_is_valid net/ipv6/route.c:1435 [inline]
RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1445 [inline]
RIP: 0010:ip6_pol_route+0x301/0x9d0 net/ipv6/route.c:2298
Code: a9 fe 4d 85 ff 4c 8b 74 24 10 74 3b 41 8b 9f 98 00 00 00 31 ff 89 de e8 3d 37 a9 fe 85 db 74 33 49 8b 07 48 8b 80 08 01 00 00 <8b> a8 24 0a 00 00 89 df 89 ee e8 f0 34 a9 fe 39 eb 75 20 e8 67 33
RSP: 0018:ffa0000000c3ba20 EFLAGS: 00010202
RAX: 00007f93e4d50fff RBX: 000000001ac62540 RCX: 0000000000000002
RDX: ff11000005e99700 RSI: 000000001ac62540 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffff0000 R11: 0000000000000002 R12: ffffffff829af127
R13: 0000000000000000 R14: ff110001053e2580 R15: ff1100012505f400
FS:  00007f190e8276c0(0000) GS:ff110001b79d2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f93e4d51a23 CR3: 000000011d7b5004 CR4: 0000000000771ef0
DR0: 0000000080000001 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
PKRU: 80000000
Call Trace:
 <TASK>
 pol_lookup_func include/net/ip6_fib.h:616 [inline]
 fib6_rule_lookup+0xe8/0x2a0 net/ipv6/fib6_rules.c:120
 ip6_route_output_flags_noref net/ipv6/route.c:2673 [inline]
 ip6_route_output_flags+0x188/0x260 net/ipv6/route.c:2685
 ip6_route_output include/net/ip6_route.h:93 [inline]
 ip6_dst_lookup_tail+0x9a/0x7d0 net/ipv6/ip6_output.c:1128
 ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1259
 tcp_v6_connect+0x50c/0x8e0 net/ipv6/tcp_ipv6.c:277
 mptcp_connect+0x389/0x680 net/mptcp/protocol.c:3683
 __inet_stream_connect+0x11f/0x5c0 net/ipv4/af_inet.c:677
 inet_stream_connect+0x36/0x50 net/ipv4/af_inet.c:748
 __sys_connect_file net/socket.c:2038 [inline]
 __sys_connect+0x17b/0x220 net/socket.c:2057
 __do_sys_connect net/socket.c:2063 [inline]
 __se_sys_connect net/socket.c:2060 [inline]
 __x64_sys_connect+0x1c/0x20 net/socket.c:2060
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc8/0x1a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f19101bd169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f190e827038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f19103d5fa0 RCX: 00007f19101bd169
RDX: 000000000000001c RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007f191023e730 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f19103d5fa0 R15: 00007f19104ffa28
 </TASK>
Modules linked in:
CR2: 00007f93e4d51a23
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:rt_genid_ipv6 include/net/net_namespace.h:537 [inline]
RIP: 0010:rt6_is_valid net/ipv6/route.c:1435 [inline]
RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1445 [inline]
RIP: 0010:ip6_pol_route+0x301/0x9d0 net/ipv6/route.c:2298
Code: a9 fe 4d 85 ff 4c 8b 74 24 10 74 3b 41 8b 9f 98 00 00 00 31 ff 89 de e8 3d 37 a9 fe 85 db 74 33 49 8b 07 48 8b 80 08 01 00 00 <8b> a8 24 0a 00 00 89 df 89 ee e8 f0 34 a9 fe 39 eb 75 20 e8 67 33
RSP: 0018:ffa0000000c3ba20 EFLAGS: 00010202
RAX: 00007f93e4d50fff RBX: 000000001ac62540 RCX: 0000000000000002
RDX: ff11000005e99700 RSI: 000000001ac62540 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffff0000 R11: 0000000000000002 R12: ffffffff829af127
R13: 0000000000000000 R14: ff110001053e2580 R15: ff1100012505f400
FS:  00007f190e8276c0(0000) GS:ff110001b79d2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f93e4d51a23 CR3: 000000011d7b5004 CR4: 0000000000771ef0
DR0: 0000000080000001 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000600
PKRU: 80000000
----------------
Code disassembly (best guess):
   0:	a9 fe 4d 85 ff       	test   $0xff854dfe,%eax
   5:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
   a:	74 3b                	je     0x47
   c:	41 8b 9f 98 00 00 00 	mov    0x98(%r15),%ebx
  13:	31 ff                	xor    %edi,%edi
  15:	89 de                	mov    %ebx,%esi
  17:	e8 3d 37 a9 fe       	call   0xfea93759
  1c:	85 db                	test   %ebx,%ebx
  1e:	74 33                	je     0x53
  20:	49 8b 07             	mov    (%r15),%rax
  23:	48 8b 80 08 01 00 00 	mov    0x108(%rax),%rax
* 2a:	8b a8 24 0a 00 00    	mov    0xa24(%rax),%ebp <-- trapping instruction
  30:	89 df                	mov    %ebx,%edi
  32:	89 ee                	mov    %ebp,%esi
  34:	e8 f0 34 a9 fe       	call   0xfea93529
  39:	39 eb                	cmp    %ebp,%ebx
  3b:	75 20                	jne    0x5d
  3d:	e8                   	.byte 0xe8
  3e:	67                   	addr32
  3f:	33                   	.byte 0x33
---8<---

