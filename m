Return-Path: <netdev+bounces-93017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864D8B9AAA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29696282ADB
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8C7E578;
	Thu,  2 May 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="bvih9iKS"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86E6E617
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652502; cv=none; b=rFk/CFBHqB4iRHqD7DS6gpR5eqelZWx2yf8Qjxrj45uc/0KKMESDbIKWHJK0p/sM6dpq8AkuBFmD1j1uZV9jAyGXX8g+mBn0xnyFSzZWbtdo19rePOVa2TCyeVpyKr3z9fkIhzYF9x0YPr0faeqwKU81oxQeVznB+QIcIxYS4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652502; c=relaxed/simple;
	bh=8Ni4I+F6BBZrAd+psu8ae0tZn5D/3lEqCf767w1NCGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehob8P6cs0IJfdX6P47ThdZVCkOpftecOX/nlFsI89bsaY/I61x3aAHEref6e0Br5OvycScnR1J+tHGmgAIiEfIllDis/3l2uO6URoLlEgQZcd/3yKUDiANgs/PjtJQMv4Y5KvyjL8tcLO+ViWvNCHdy0AhGeHt1TlDq4gEyB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=bvih9iKS; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 4f548184-087e-11ef-8845-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f548184-087e-11ef-8845-005056abad63;
	Thu, 02 May 2024 14:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=btYn3fsybJ1vByRXV9EYCa0JJYbgZv6fg0vAoyAhJaE=;
	b=bvih9iKSLmsmAs7H+268wJxoHX3l6Tot0G5L7e8mP1n9jmAHQZ9t2Z7M4f3LAFxs9MQeOaVS8cDRG
	 0tlyXwtyCl4UH4mpUQpoUCILWoyDsD52xJm0pkRnU+NN5dg7p1GdBhlYOj0/KevwAk27KYoXzW5W5v
	 DD/D7iUFCtNMC5C8=
X-KPN-MID: 33|mkmwyDCIB+k92k6NydjxDnTXdnwhq8WyaRylDIHldOLQDzoMMSOQHMpt/icmMlf
 0i74rtiqZ52cwAxkz/q1CvhAY/2QZHDVCUYzwKn53t/U=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|HsqRd0Ugj1duOeGLcGDaOKDEiaeWi7k2qoCcrSukiRk3zsNwtSaHgDjFD0v2wBv
 CKmH/En8/I5/7H839O7EkaA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5b01ecdd-087e-11ef-9fd1-005056ab7584;
	Thu, 02 May 2024 14:20:26 +0200 (CEST)
Date: Thu, 2 May 2024 14:20:25 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org,
	Paul Wouters <paul@nohats.ca>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH ipsec-next 0/3] Add support for per cpu xfrm states.
Message-ID: <ZjOFCQLjufp5ua0M@Antony2201.local>
References: <20240412060553.3483630-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412060553.3483630-1-steffen.klassert@secunet.com>


On Fri, Apr 12, 2024 at 08:05:50AM +0200, Steffen Klassert via Devel wrote:
> Add support for per cpu xfrm states.
> 
> This patchset implements the xfrm part of per cpu SAs as specified in:
> 
> https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/
> 
> Patch 1 adds the cpu as a lookup key and config option to to generate
> acquire messages for each cpu.
> 
> Patch 2 caches outbound states at the policy.
> 
> Patch 3 caches inbound states on a new percpu state cache.
> 
> Please review and test.

Hi Steffen,

I tried xfrm-pcpu-v8 branch, and get these kernel splats. I think it happens 
of the pervious version too. This kernel build has  KASAN enabled.
On AWS I didn't get it to work, with UDP encap enabled. I will try again.
Each ping packet seems to new CHILD_SA. Let me try again.

I am sending ping from the IPsc gateway. It does not appear on the receiver.  
And also appears with iperf too.

[   92.935674] BUG: using smp_processor_id() in preemptible [00000000] code: ping/582
[   92.936489] caller is xfrm_state_find+0x131/0x19c3
[   92.937008] CPU: 0 PID: 582 Comm: ping Not tainted 6.9.0-rc2-00675-gcc50d6985093 #118
[   92.937807] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   92.938731] Call Trace:
[   92.939010]  <TASK>
[   92.939256]  dump_stack_lvl+0x47/0x5f
[   92.939654]  check_preemption_disabled+0xc1/0xd2
[   92.940142]  xfrm_state_find+0x131/0x19c3
[   92.940568]  ? stack_access_ok+0x17/0x58
[   92.941001]  ? on_stack+0x34/0x5f
[   92.941371]  ? xfrm_alloc_spi+0x358/0x358
[   92.941808]  ? preempt_count_sub+0x14/0xb5
[   92.942243]  ? unwind_next_frame+0x9d3/0xa68
[   92.942698]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   92.943242]  ? preempt_latency_start+0x40/0x4b
[   92.943711]  ? __rcu_read_unlock+0x32/0x224
[   92.944156]  ? __rcu_read_unlock+0x32/0x224
[   92.944597]  ? write_profile+0x1da/0x1da
[   92.945023]  xfrm_tmpl_resolve+0x246/0x497
[   92.945469]  ? policy_hash_bysel+0x208/0x208
[   92.945933]  ? fib_lookup_good_nhc+0x60/0xff
[   92.946388]  ? fib_table_lookup+0x673/0x738
[   92.946836]  ? __addr_hash+0x6a/0x7e
[   92.947225]  ? __addr_hash+0x6a/0x7e
[   92.947613]  xfrm_resolve_and_create_bundle+0xf7/0xac2
[   92.948149]  ? xfrm_policy_addr_delta+0x52/0xe0
[   92.948625]  ? __refcount_add_not_zero.constprop.0+0x91/0xe7
[   92.949214]  ? xfrm_flowi_sport.isra.0+0x46/0x6c
[   92.949718]  ? __rcu_read_unlock+0x4e/0x224
[   92.950163]  ? xfrm_tmpl_resolve+0x497/0x497
[   92.950619]  ? xfrm_policy_lookup_bytype+0x47a/0x4ca
[   92.951141]  ? xfrm_sk_policy_lookup+0xf7/0xf7
[   92.951614]  ? rcuref_get+0xf/0x23
[   92.951989]  xfrm_lookup_with_ifid+0x2af/0x768
[   92.952461]  ? xfrm_expand_policies.constprop.0+0x1cd/0x1cd
[   92.953053]  ? ip_route_output_key_hash+0xd0/0x110
[   92.953562]  ? ip_route_output_key_hash+0xd0/0x110
[   92.954069]  xfrm_lookup_route+0x18/0x8b
[   92.954491]  __ip4_datagram_connect+0x36a/0x522
[   92.954973]  ip4_datagram_connect+0x28/0x3c
[   92.955418]  __sys_connect+0xaa/0xfa
[   92.955808]  ? __sys_connect_file+0xa9/0xa9
[   92.956254]  ? fd_install+0x11e/0x130
[   92.956650]  ? preempt_count_sub+0x14/0xb5
[   92.957091]  ? rcu_read_unlock_sched+0xa/0x1b
[   92.957568]  ? __sys_socket+0xe0/0x120
[   92.957974]  ? update_socket_protocol+0x8/0x8
[   92.958436]  ? __rcu_read_unlock+0x4e/0x224
[   92.958881]  __x64_sys_connect+0x3c/0x43
[   92.959302]  do_syscall_64+0x6d/0xd9
[   92.959689]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   92.960218] RIP: 0033:0x7fa4d3443580
[   92.960603] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 61 10 0d 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
[   92.962448] RSP: 002b:00007ffd6336e968 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
[   92.963215] RAX: ffffffffffffffda RBX: 00007ffd6336e990 RCX: 00007fa4d3443580
[   92.963941] RDX: 0000000000000010 RSI: 00007ffd6336e990 RDI: 0000000000000005
[   92.964660] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[   92.965406] R10: 00007fa4d3350980 R11: 0000000000000202 R12: 0000000000000005
[   92.966138] R13: 000055e34bbf45c2 R14: 000055e34bbf9240 R15: 000055e34bbf2340
[   92.966863]  </TASK>
[   92.967531] BUG: using smp_processor_id() in preemptible [00000000] code: ping/582
[   92.968305] caller is xfrm_state_find+0x131/0x19c3
[   92.968809] CPU: 0 PID: 582 Comm: ping Not tainted 6.9.0-rc2-00675-gcc50d6985093 #118
[   92.969622] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   92.970549] Call Trace:
[   92.970828]  <TASK>
[   92.971106]  dump_stack_lvl+0x47/0x5f
[   92.971553]  check_preemption_disabled+0xc1/0xd2
[   92.972047]  xfrm_state_find+0x131/0x19c3
[   92.972476]  ? mas_push_data+0x3d3/0x400
[   92.972902]  ? xfrm_alloc_spi+0x358/0x358
[   92.973346]  ? _lookup_address_cpa.isra.0+0x2d/0x2d
[   92.973867]  ? on_stack+0x34/0x5f
[   92.974232]  ? on_stack+0x34/0x5f
[   92.974596]  ? preempt_count_sub+0x14/0xb5
[   92.975033]  ? unwind_next_frame+0x9d3/0xa68
[   92.975488]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   92.976033]  xfrm_tmpl_resolve+0x246/0x497
[   92.976504]  ? policy_hash_bysel+0x208/0x208
[   92.977049]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   92.977616]  ? fib_lookup_good_nhc+0x60/0xff
[   92.978074]  ? fib_table_lookup+0x673/0x738
[   92.978519]  ? __addr_hash+0x6a/0x7e
[   92.978910]  ? __addr_hash+0x6a/0x7e
[   92.979299]  xfrm_resolve_and_create_bundle+0xf7/0xac2
[   92.979835]  ? xfrm_policy_addr_delta+0x52/0xe0
[   92.980314]  ? __refcount_add_not_zero.constprop.0+0x91/0xe7
[   92.980902]  ? xfrm_flowi_sport.isra.0+0x54/0x6c
[   92.981407]  ? __rcu_read_unlock+0x4e/0x224
[   92.981860]  ? xfrm_tmpl_resolve+0x497/0x497
[   92.982316]  ? xfrm_policy_lookup_bytype+0x47a/0x4ca
[   92.982837]  ? xfrm_sk_policy_lookup+0xf7/0xf7
[   92.983309]  ? __kernel_text_address+0xe/0x30
[   92.983773]  xfrm_lookup_with_ifid+0x2af/0x768
[   92.984245]  ? xfrm_expand_policies.constprop.0+0x1cd/0x1cd
[   92.984819]  ? ip_route_output_key_hash+0xd0/0x110
[   92.985329]  ? copy_page_to_iter_nofault+0x61e/0x61e
[   92.985859]  ? preempt_latency_start+0x40/0x4b
[   92.986332]  xfrm_lookup_route+0x18/0x8b
[   92.986752]  raw_sendmsg+0x683/0x1014
[   92.987149]  ? native_flush_tlb_one_user+0x23/0xe7
[   92.987653]  ? raw_hash_sk+0x224/0x224
[   92.988056]  ? kasan_unpoison+0x28/0x33
[   92.988469]  ? kernel_init_pages+0x42/0x51
[   92.988905]  ? prep_new_page+0x44/0x51
[   92.989315]  ? get_page_from_freelist+0x722/0x8e6
[   92.989823]  ? zone_watermark_fast.isra.0+0x12b/0x12b
[   92.990351]  ? __might_resched+0x8c/0x246
[   92.990778]  ? __might_sleep+0x26/0xa1
[   92.991183]  ? first_zones_zonelist+0x2c/0x43
[   92.991646]  ? do_raw_spin_lock+0x72/0xbb
[   92.992076]  ? queued_read_unlock+0x19/0x19
[   92.992520]  ? walk_page_mapping+0x1ba/0x1ba
[   92.992988]  ? __might_resched+0x8c/0x246
[   92.993418]  ? __might_sleep+0x26/0xa1
[   92.993833]  ? inet_send_prepare+0x59/0x59
[   92.994271]  ? sock_sendmsg_nosec+0x42/0x6c
[   92.994713]  sock_sendmsg_nosec+0x42/0x6c
[   92.995141]  __sys_sendto+0x15d/0x1cc
[   92.995537]  ? __x64_sys_getpeername+0x44/0x44
[   92.996009]  ? __handle_mm_fault+0x667/0xad4
[   92.996466]  ? find_vma+0x6b/0x8b
[   92.996830]  ? find_vma_intersection+0x8a/0x8a
[   92.997308]  ? handle_mm_fault+0x39/0x167
[   92.997741]  ? handle_mm_fault+0xfd/0x167
[   92.998168]  ? preempt_latency_start+0x40/0x4b
[   92.998637]  ? preempt_count_sub+0x14/0xb5
[   92.999073]  __x64_sys_sendto+0x76/0x82
[   92.999486]  do_syscall_64+0x6d/0xd9
[   92.999879]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   93.000407] RIP: 0033:0x7fa4d3443a73
[   93.000795] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[   93.002626] RSP: 002b:00007ffd6336d758 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   93.003392] RAX: ffffffffffffffda RBX: 000055e34bbf2340 RCX: 00007fa4d3443a73
[   93.004114] RDX: 0000000000000040 RSI: 000055e34bbf83c0 RDI: 0000000000000003
[   93.004835] RBP: 000055e34bbf83c0 R08: 000055e34bbf45c0 R09: 0000000000000010
[   93.005578] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[   93.006301] R13: 00007ffd6336ee40 R14: 0000001d00000001 R15: 000055e34bbf5680
[   93.007033]  </TASK>
[   93.007334] BUG: using smp_processor_id() in preemptible [00000000] code: ping/582
[   93.008285] caller is xfrm_state_look_at.isra.0+0x28/0x1b6
[   93.008853] CPU: 0 PID: 582 Comm: ping Not tainted 6.9.0-rc2-00675-gcc50d6985093 #118
[   93.009661] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   93.010589] Call Trace:
[   93.010868]  <TASK>
[   93.011115]  dump_stack_lvl+0x47/0x5f
[   93.011512]  check_preemption_disabled+0xc1/0xd2
[   93.012000]  xfrm_state_look_at.isra.0+0x28/0x1b6

Breakpoint 1 at 0xffffffff81e13cb7: file net/xfrm/xfrm_user.c, line 790.
(gdb) list *xfrm_state_find+0x131
0xffffffff81e0166f is in xfrm_state_find (net/xfrm/xfrm_state.c:1215).
1210		u32 mark = pol->mark.v & pol->mark.m;
1211		unsigned short encap_family = tmpl->encap_family;
1212		unsigned int sequence;
1213		struct km_event c;
1214		bool cached = false;
1215		unsigned int pcpu_id = smp_processor_id();
1216
1217		to_put = NULL;
1218
1219		sequence = 
read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);

