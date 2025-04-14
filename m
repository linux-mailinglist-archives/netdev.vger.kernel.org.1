Return-Path: <netdev+bounces-182509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D07A88F24
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA957A9BFD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F70DDDC;
	Mon, 14 Apr 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLGeeGEg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C81BC07B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669860; cv=none; b=udlv7KUtZhApDaxEDeWNCityADUBurGZHg3FrLaVoDBoBNVi5H060nb6UTiraKmdQ+NFFEGj59jqkWcuUyAALGaYvKQ8UmBQ0eQgLH4HY3Ed3VJfwMdSrYY/Nl34ZZb24OEDK3ZMicfWmFtrzr3oiQlC/4gwAvDZ6CjJXMuxeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669860; c=relaxed/simple;
	bh=gyUCFg3/SoFCQsCTPzcOaN3BHhGiooPiZC1WCDeWK7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpujSVVx/yQQo/nDrtHDClNHggZQWGXaAYvs4Zsf6k0cbwdbg6plsibJPP9y0IX7w8IJwsceC6k3dtD8GcpClNkzNWfwzmtafLK4z3ksY+AbNBmD/kf1mFMpJ/w6dYvyWWI6+ImBdg7W3MGBqZxJYCk5X4GcP1TWjl7BsQa2lH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLGeeGEg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso67142465ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744669858; x=1745274658; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZUhNhhlHPfmMw0cjf6eMgMZZS8VQMmrOmkdg9gOXEE=;
        b=mLGeeGEgqHxV+VlQ7G1Q0MeEWJ9Ai0jvNogAcst1JkbJT/se1NofaRsTHYI4gauyTV
         7J71xooHXLEm5/7CwW7h4iybZIErt1JcOQadfL1iKfQUDHMiNoJWbJXsMryicTWXtAi6
         jlkLvoId0zascEMtDooiJqjNkVgqGJ1fS7Hib23f+3iamK1dp1wx38090B2J4Kgz7s8/
         sofDgJB0qJGJt/6rM7ovr2/ZgzNvD++b1tbovwLqzjVfKQgUoEEMdPSaf9KPnMhVmEEA
         WGLRNZXdw9xpz7fxeO7fI4kBGN1kJ20WDVIYEBRkMskNuS7UZQn5Sl4zMItPUdgbChYE
         9r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744669858; x=1745274658;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZUhNhhlHPfmMw0cjf6eMgMZZS8VQMmrOmkdg9gOXEE=;
        b=aIUvlaESrck0X51T1FZtxDeZav8pR9TY54U+ff9sGYrHuHw1rev6/UpM0rcKClq7Gl
         xD7s2/O/EIV9g+ggixi5i+Hv1bLLpMUMiejphGod+Jmh64soBoT/MXOl+GoCUvGdomba
         cyincI4nVw4vUJpasPxQ4FFKumS/jOjsnHhQTfruJSYnXX63pR/fYTyPCHq8L+ONzeUS
         yOJU+60gtHzKejgn0dDcHDBRnQajQNc2ctumfnV9Z0Cl3i4eJq/6VExLh4FgKAkz178u
         WCDc6JqUeTB2wxkEoVZKO6tfecdGFWdQT0bKoVmkfw9zKPcc3h6zNYx2dQAi+fsEDDss
         qFhA==
X-Gm-Message-State: AOJu0YzvBp2g/zM4xQbrbEDI7EstkGS2no8NTJP6cl58Ir+MlP6ccxqS
	0sORvUzBtR1/ORVjrYJKeh7etcp4N1UJOEgnHhHz2p7o6li6biIL
X-Gm-Gg: ASbGnctzP8+/i5WCxYPo2Jn2DftjnhhmiWQirOjjTtfXspMCa7QQuwxFBc1a839YT/I
	Im6CU7cqbGKgrsGBPXFKtaTd0hNMugmjLIaQXyYnQaLYxNTrlgR6XsGkWCiJ2nAr5XEFLbn6nZE
	hb7D5DuvmegQXfqYTTHG1MDLDN46A+x3ar5PhzmnvOcV1zC2yQZsFyIyueZydsOJJOxtvhM1xo2
	leceJLrrbEJw0FhQKJeOZCdYsHeQ6tiHpspzNBw11aZSv80uOEmheoiVDwIwewyxpGYhuCpDWI9
	MXRxlbBHSXlfw8Ra8UYkOf9/4bJdOfFslV2+d8/34zkpKuMgxvtKnRA=
X-Google-Smtp-Source: AGHT+IEPGBwYtiMI0wWvizIk8LhzL6gwTl0qvP0b0fW8ltkrLyUp0SvUWJAAhLsGNneXClogulTa0Q==
X-Received: by 2002:a17:902:c947:b0:223:517a:d2e2 with SMTP id d9443c01a7336-22bea50e2edmr217460905ad.53.1744669858192;
        Mon, 14 Apr 2025 15:30:58 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:fcee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e34asm7347760b3a.137.2025.04.14.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 15:30:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org
Subject: Re: [PATCH net v2 0/3] net: fix lwtunnel reentry loops
In-Reply-To: <20250314120048.12569-1-justin.iurman@uliege.be> (Justin Iurman's
	message of "Fri, 14 Mar 2025 13:00:45 +0100")
References: <20250314120048.12569-1-justin.iurman@uliege.be>
Date: Mon, 14 Apr 2025 15:30:55 -0700
Message-ID: <m2h62qwf34.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Iurman <justin.iurman@uliege.be> writes:

> v2:
> - removed some patches from the -v1 series
> - added a patch that was initially sent separately
> - code style for the selftest (thanks Paolo)
> v1:
> - https://lore.kernel.org/all/20250311141238.19862-1-justin.iurman@uliege.be/

Hi Justin,

I've noticed a BUG splat likely introduced by this patch.
The splat is reported when executing some BPF selftests,
e.g. lwt_ip_encap_ipv4/egress
(defined in tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c and
            tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c).

Decoded splat is at the end of the email.
Line numbers correspond to commit
a27a97f71394 ("Merge branch 'bpf-support-atomic-update-for-htab-of-maps'")
from the kernel/git/bpf/bpf-next.git tree.

Thanks,
Eduard

---

[  193.993893] BUG: using __this_cpu_add() in preemptible [00000000] code: test_progs/206
[  193.994292] caller is lwtunnel_xmit (net/core/dev.h:340 net/core/lwtunnel.c:408) 
[  193.994601] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  193.994603] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.el9 04/01/2014
[  193.994605] Call Trace:
[  193.994608]  <TASK>
[  193.994611] dump_stack_lvl (lib/dump_stack.c:122) 
[  193.994622] check_preemption_disabled (lib/smp_processor_id.c:0) 
[  193.994630] ? lwtunnel_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/core/lwtunnel.c:403) 
[  193.994637] lwtunnel_xmit (net/core/dev.h:340 net/core/lwtunnel.c:408) 
[  193.994648] ip_finish_output2 (net/ipv4/ip_output.c:222) 
[  193.994655] ? ip_skb_dst_mtu (./include/net/ip.h:517) 
[  193.994659] ? ip_skb_dst_mtu (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 ./include/net/ip.h:471 ./include/net/ip.h:512) 
[  193.994669] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.994672] ? __ip_finish_output (net/ipv4/ip_output.c:306) 
[  193.994683] ? __ip_queue_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/ipv4/ip_output.c:470) 
[  193.994688] __ip_queue_xmit (net/ipv4/ip_output.c:527) 
[  193.994693] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.994711] ? __ip_queue_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/ipv4/ip_output.c:470) 
[  193.994726] __tcp_transmit_skb (net/ipv4/tcp_output.c:1479) 
[  193.994800] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.994804] ? __asan_memset (mm/kasan/shadow.c:84) 
[  193.994810] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.994824] tcp_connect (net/ipv4/tcp_output.c:0 net/ipv4/tcp_output.c:4155) 
[  193.994890] tcp_v4_connect (net/ipv4/tcp_ipv4.c:343) 
[  193.994926] __inet_stream_connect (net/ipv4/af_inet.c:678) 
[  193.994944] ? __local_bh_enable_ip (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:119 kernel/softirq.c:412) 
[  193.994950] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.994953] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4473) 
[  193.994967] inet_stream_connect (net/ipv4/af_inet.c:748) 
[  193.994976] ? __pfx_inet_stream_connect (net/ipv4/af_inet.c:744) 
[  193.994981] __sys_connect (./include/linux/file.h:62 ./include/linux/file.h:83 net/socket.c:2058) 
[  193.995013] __x64_sys_connect (net/socket.c:2063 net/socket.c:2060 net/socket.c:2060) 
[  193.995022] do_syscall_64 (arch/x86/entry/syscall_64.c:0) 
[  193.995026] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
[  193.995030] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4473) 
[  193.995038] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  193.995042] RIP: 0033:0x7faec2d0f9cb
[ 193.995047] Code: 83 ec 18 89 54 24 0c 48 89 34 24 89 7c 24 08 e8 4b 70 f7 ff 8b 54 24 0c 48 8b 34 24 41 89 c0 8b 7c 24 08 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 08 e8 a1 70 f7 ff 8b 44
All code
========
   0:	83 ec 18             	sub    $0x18,%esp
   3:	89 54 24 0c          	mov    %edx,0xc(%rsp)
   7:	48 89 34 24          	mov    %rsi,(%rsp)
   b:	89 7c 24 08          	mov    %edi,0x8(%rsp)
   f:	e8 4b 70 f7 ff       	call   0xfffffffffff7705f
  14:	8b 54 24 0c          	mov    0xc(%rsp),%edx
  18:	48 8b 34 24          	mov    (%rsp),%rsi
  1c:	41 89 c0             	mov    %eax,%r8d
  1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  23:	b8 2a 00 00 00       	mov    $0x2a,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 35                	ja     0x67
  32:	44 89 c7             	mov    %r8d,%edi
  35:	89 44 24 08          	mov    %eax,0x8(%rsp)
  39:	e8 a1 70 f7 ff       	call   0xfffffffffff770df
  3e:	8b                   	.byte 0x8b
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 35                	ja     0x3d
   8:	44 89 c7             	mov    %r8d,%edi
   b:	89 44 24 08          	mov    %eax,0x8(%rsp)
   f:	e8 a1 70 f7 ff       	call   0xfffffffffff770b5
  14:	8b                   	.byte 0x8b
  15:	44                   	rex.R
[  193.995050] RSP: 002b:00007fff992d3a20 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
[  193.995054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faec2d0f9cb
[  193.995057] RDX: 0000000000000010 RSI: 00007fff992d3ad8 RDI: 0000000000000035
[  193.995059] RBP: 00007fff992d3ac0 R08: 0000000000000000 R09: 0000000000000004
[  193.995062] R10: 00007fff992d39b0 R11: 0000000000000293 R12: 00007fff992d7b78
[  193.995064] R13: 000000000095f760 R14: 0000000002e38b90 R15: 00007faec373d000
[  193.995091]  </TASK>


