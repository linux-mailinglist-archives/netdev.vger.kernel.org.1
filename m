Return-Path: <netdev+bounces-123149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A180963D73
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D402861A4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435915F336;
	Thu, 29 Aug 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="RHnjR9nh"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5214F130
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917520; cv=none; b=puJ/b8MiRNQlhdsY8PHAHR+6Yhh9RvhI80idAsC4WE7Z+rfX4u/PU+8CScu+EkdLvX0eUNxid8sJ/GQa1adfWyTGkqkvsNYv/hLwh5etoWkBYc6lTO0iZibVbQd+e5sDR3fjEd/kT+jKuAvoldkDNX/X6uPepciVInEfkh9dhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917520; c=relaxed/simple;
	bh=AVM+EbREUf2mHaL9W0AjWLbvD7nIp4l3feP7WyxeQmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzBWKVWi5eVFilCRbbWUin08ftSl101k4MQueqXK57QTq2FU9QBoNLxneGWyVf8M3ZeAqTwH4jXBaw4jiSn65QoZKjnwWggZDunTZT0S6vxMyLK+fg9bpI+5PXXY4EpnuAsX4finRtdo+2/MlDtSPY7k3oMmO8JCQZUrAQaPQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=RHnjR9nh; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 76ebe51a-65da-11ef-895b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 76ebe51a-65da-11ef-895b-005056ab378f;
	Thu, 29 Aug 2024 09:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Xn503NI6BEGKkw25YZDpk29xehPSYhV7+969bbh7rOY=;
	b=RHnjR9nhRMHF/qugWAv7mXSSNwZl+rKZTX9AeU4FaZVQlLf/mPtlw9nnqJ0ezzDau8NSfbTGeVWKu
	 2TXYJAUjHZtZbTum7nRSUSPTUYPvLrxFn75e2UGyV4Q+McGeGBgudK6k8HK4jh3bK20nLeuicBU8nD
	 i5uNIFvrtE0wxVyU=
X-KPN-MID: 33|M8ZKaRrWVIiJIrLQZHnS+7qOfbxssT9pESEbcdx59bOeC3OwS1Pn4dvrIqwQh83
 W0fKq4lOyaznAbB7SJgmwJJEdlP6P2xqrKP8xcGfmwY4=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|+J4AJxvh6DKkgKT8k4EV2CyqPCACjD2Fo4Sn7wrrsykF2NoDAchzbnyhgdq013h
 9QlySlND81E/cw9uATrWrtg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 76e8ac77-65da-11ef-999f-005056abf0db;
	Thu, 29 Aug 2024 09:44:05 +0200 (CEST)
Date: Thu, 29 Aug 2024 09:44:04 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next v10 00/16] Add IP-TFS mode to xfrm
Message-ID: <ZtAmxA_xflBWGlYO@Antony2201.local>
References: <20240824022054.3788149-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824022054.3788149-1-chopps@chopps.org>

Hi Chris,

On Fri, Aug 23, 2024 at 10:20:38PM -0400, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate)
> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
> payload type supports aggregation and fragmentation of the inner IP
> packet stream which in turn yields higher small-packet bandwidth as well
> as reducing MTU/PMTU issues. Congestion control is unimplementated as
> the send rate is demand driven rather than constant.
> 
> In order to allow loading this fucntionality as a module a set of
> callbacks xfrm_mode_cbs has been added to xfrm as well.
> 
> Patchset Structure:
> -------------------

I ran few tests. The basic tests passed. I noticed packet loss with ping -f 
especilly on IPv6.

ping6 -f  -n -q -c 50 2001:db8:1:2::23

On the sender I see 

[42873.421440] ------------[ cut here ]------------
[42873.422458] refcount_t: underflow; use-after-free.
[42873.423544] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_saturate+0xc7/0x110
[42873.425087] Modules linked in:
[42873.425155] ------------[ cut here ]------------
[42873.425567] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-12625-g9b657a57e7c8-dirty #49
[42873.426037] refcount_t: saturated; leaking memory.
[42873.426086] WARNING: CPU: 1 PID: 865 at lib/refcount.c:22 refcount_warn_saturate+0x87/0x110
[42873.427333] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[42873.427816] Modules linked in:
[42873.429052] RIP: 0010:refcount_warn_saturate+0xc7/0x110
[42873.429072] Code: 65 0e f1 01 01 e8 9e c3 7a ff 0f 0b eb 5e 80 3d 54 0e f1 01 00 75 55 48 c7 c7 00 2b 6d 82 c6 05 44 0e f1 01 01 e8 7e c3 7a ff <0f> 0b eb 3e 80 3d 33 0e f1 01 00 75 35 48 c7 c7 60 2c 6d 82 c6 05
[42873.430420] CPU: 1 UID: 0 PID: 865 Comm: ping6 Not tainted 6.10.0-12625-g9b657a57e7c8-dirty #49
[42873.430882] RSP: 0018:ffffc90000007bc8 EFLAGS: 00010282
[42873.431650] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[42873.434377] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[42873.435644] RIP: 0010:refcount_warn_saturate+0x87/0x110
[42873.436410] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: fffff52000000f69
[42873.437781] Code: c3 7a ff 0f 0b e9 a2 00 00 00 80 3d 9a 0e f1 01 00 0f 85 95 00 00 00 48 c7 c7 a0 2b 6d 82 c6 05 86 0e f1 01 01 e8 be c3 7a ff <0f> 0b eb 7e 80 3d 75 0e f1 01 00 75 75 48 c7 c7 00 2c 6d 82 c6 05
[42873.437929] RBP: ffff8881076eb8bc R08: 0000000000000004 R09: 0000000000000001
[42873.438972] RSP: 0018:ffffc900018bf7c8 EFLAGS: 00010282
[42873.439477] R10: ffff88815ae2794b R11: ffffed102b5c4f29 R12: ffff8881076eb8bc

[42873.440477] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[42873.442255] R13: ffff8881076eb9e0 R14: 1ffff92000000f8e R15: ffff88810744e800
[42873.442943] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: fffff52000317ee9
[42873.443451] FS:  0000000000000000(0000) GS:ffff88815ae00000(0000) knlGS:0000000000000000
[42873.444134] RBP: ffff8881076eb8bc R08: 0000000000000004 R09: 0000000000000001
[42873.444294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[42873.444990] R10: ffff88815af2794b R11: ffffed102b5e4f29 R12: 00000000000000e1
[42873.445672] CR2: 000055654922bbf8 CR3: 0000000115648000 CR4: 0000000000350ef0
[42873.446355] R13: 0000000000000000 R14: ffff8881076eb740 R15: 0000000000000000
[42873.447130] Call Trace:
[42873.447818] FS:  00007ffb460f3c40(0000) GS:ffff88815af00000(0000) knlGS:0000000000000000
[42873.448375]  <IRQ>
[42873.449073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[42873.449760]  ? __warn+0xc4/0x175
[42873.450442] CR2: 00007fff2eda6ff8 CR3: 000000010f034000 CR4: 0000000000350ef0
[42873.450688]  ? refcount_warn_saturate+0xc7/0x110
[42873.451458] Call Trace:
[42873.451667]  ? report_bug+0x133/0x1c0
[42873.452229]  <TASK>
[42873.452548]  ? refcount_warn_saturate+0xc7/0x110
[42873.453253]  ? __warn+0xc4/0x175
[42873.453696]  ? handle_bug+0x3c/0x6c
[42873.453938]  ? refcount_warn_saturate+0x87/0x110
[42873.454298]  ? exc_invalid_op+0x13/0x3c
[42873.454520]  ? report_bug+0x133/0x1c0
[42873.454968]  ? asm_exc_invalid_op+0x16/0x20
[42873.455287]  ? refcount_warn_saturate+0x87/0x110
[42873.455644]  ? refcount_warn_saturate+0xc7/0x110
[42873.456088]  ? handle_bug+0x3c/0x6c
[42873.456463]  ? refcount_warn_saturate+0xc7/0x110
[42873.456836]  ? exc_invalid_op+0x13/0x3c
[42873.457241]  __refcount_sub_and_test.constprop.0+0x39/0x42
[42873.457689]  ? asm_exc_invalid_op+0x16/0x20
[42873.458141]  sock_wfree+0x8d/0x161
[42873.458492]  ? refcount_warn_saturate+0x87/0x110
[42873.458936]  skb_release_head_state+0x28/0x72
[42873.459310]  ? refcount_warn_saturate+0x87/0x110
[42873.459850]  skb_release_all+0x13/0x3e
[42873.460257]  __ip6_append_data.isra.0+0x14ed/0x157a
[42873.460596]  napi_consume_skb+0x53/0x62
[42873.461094]  ? __pfx_raw6_getfrag+0x10/0x10
[42873.461493]  __free_old_xmit+0x119/0x26b
[42873.461947]  ? __pfx_xfrm_lookup_with_ifid+0x10/0x10
[42873.462319]  ? __pfx___free_old_xmit+0x10/0x10
[42873.462797]  ? __pfx___ip6_append_data.isra.0+0x10/0x10
[42873.463168]  ? ttwu_do_wakeup+0x4f/0x64
[42873.463574]  ? __rcu_read_unlock+0x4e/0x228
[42873.463962]  ? srso_return_thunk+0x5/0x5f
[42873.464447]  ? ip6_dst_lookup_tail.constprop.0+0x338/0x3e0
[42873.464889]  ? srso_return_thunk+0x5/0x5f
[42873.465399]  ? srso_return_thunk+0x5/0x5f
[42873.465775]  ? decay_load+0x3d/0x61
[42873.466181]  ? xfrm_mtu+0x24/0x44
[42873.466573]  ? preempt_count_sub+0x14/0xb9
[42873.467101]  ? srso_return_thunk+0x5/0x5f
[42873.467498]  free_old_xmit+0x74/0xd3
[42873.467887]  ? ip6_setup_cork+0x4ee/0x507
[42873.468233]  ? __pfx_free_old_xmit+0x10/0x10
[42873.468562]  ip6_append_data+0x167/0x17e
[42873.468970]  ? do_raw_spin_lock+0x72/0xbf
[42873.469369]  ? __pfx_raw6_getfrag+0x10/0x10
[42873.469722]  ? srso_return_thunk+0x5/0x5f
[42873.470113]  rawv6_sendmsg+0x10a6/0x153e
[42873.470527]  ? virtqueue_disable_cb+0x71/0xed
[42873.470912]  ? __pfx_rawv6_recvmsg+0x10/0x10
[42873.471304]  virtnet_poll_tx+0x110/0x233
[42873.471720]  ? srso_return_thunk+0x5/0x5f
[42873.472114]  __napi_poll.constprop.0+0x5d/0x1b1
[42873.472500]  ? __pfx_rawv6_sendmsg+0x10/0x10
[42873.472936]  net_rx_action+0x255/0x427
[42873.473356]  ? __pfx_sock_common_recvmsg+0x10/0x10
[42873.473743]  ? __pfx_net_rx_action+0x10/0x10
[42873.474129]  ? __ww_mutex_lock.constprop.0+0x116/0xd48
[42873.474572]  ? srso_return_thunk+0x5/0x5f
[42873.474988]  ? srso_return_thunk+0x5/0x5f
[42873.475358]  ? srso_return_thunk+0x5/0x5f
[42873.475823]  ? __might_resched+0x8c/0x24a
[42873.476242]  ? __raise_softirq_irqoff+0x5e/0x77
[42873.476756]  ? srso_return_thunk+0x5/0x5f
[42873.477142]  ? srso_return_thunk+0x5/0x5f
[42873.477532]  ? _copy_to_user+0x48/0x5a
[42873.477924]  ? __napi_schedule+0x40/0x53
[42873.478315]  ? srso_return_thunk+0x5/0x5f
[42873.478767]  ? srso_return_thunk+0x5/0x5f
[42873.479159]  ? move_addr_to_user+0x5c/0xa6
[42873.479555]  ? do_raw_spin_lock+0x72/0xbf
[42873.479928]  ? srso_return_thunk+0x5/0x5f
[42873.480311]  ? __pfx_do_raw_spin_lock+0x10/0x10
[42873.480734]  ? ____sys_recvmsg+0x185/0x1d2
[42873.481120]  ? srso_return_thunk+0x5/0x5f
[42873.481525]  ? __pfx_____sys_recvmsg+0x10/0x10
[42873.481913]  ? preempt_count_add+0x1b/0x6a
[42873.482306]  ? srso_return_thunk+0x5/0x5f
[42873.482746]  ? srso_return_thunk+0x5/0x5f
[42873.483143]  ? copy_msghdr_from_user+0xc2/0x10b
[42873.483539]  handle_softirqs+0x153/0x300
[42873.483981]  ? srso_return_thunk+0x5/0x5f
[42873.484381]  ? srso_return_thunk+0x5/0x5f
[42873.484797]  ? srso_return_thunk+0x5/0x5f
[42873.485177]  common_interrupt+0x96/0xbc
[42873.485626]  ? sock_sendmsg_nosec+0x82/0xe2
[42873.486042]  </IRQ>
[42873.486433]  ? __pfx_rawv6_sendmsg+0x10/0x10
[42873.486827]  <TASK>
[42873.487220]  sock_sendmsg_nosec+0x82/0xe2
[42873.487600]  asm_common_interrupt+0x22/0x40
[42873.488013]  __sys_sendto+0x15d/0x1d0
[42873.488227] RIP: 0010:default_idle+0xb/0x11
[42873.488649]  ? __pfx___sys_sendto+0x10/0x10
[42873.488874] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d 87 04 36 00 fb f4 <fa> e9 5f cc 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[42873.489268]  ? srso_return_thunk+0x5/0x5f
[42873.489675] RSP: 0018:ffffffff83007e58 EFLAGS: 00000202
[42873.490034]  ? __handle_mm_fault+0x63a/0xa94

[42873.490860]  ? srso_return_thunk+0x5/0x5f
[42873.492649] RAX: 0000000000000000 RBX: ffffffff8301ad40 RCX: ffffed102b5c67e1
[42873.493075]  __x64_sys_sendto+0x76/0x86
[42873.493564] RDX: ffffed102b5c67e1 RSI: ffffffff826d86c0 RDI: 0000000005ef6de4
[42873.493986]  do_syscall_64+0x68/0xd8
[42873.494142] RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000001
[42873.494536]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[42873.495226] R10: ffff88815ae33f03 R11: ffffed102b5c67e0 R12: 0000000000000000
[42873.495605] RIP: 0033:0x7ffb463afa73
[42873.496313] R13: 1ffffffff0600fcd R14: 0000000000000000 R15: 0000000000013af0
[42873.496663] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[42873.497372]  ? srso_return_thunk+0x5/0x5f
[42873.497854] RSP: 002b:00007fff2eda7ca8 EFLAGS: 00000202
[42873.498541]  default_idle_call+0x34/0x53
[42873.498892]  ORIG_RAX: 000000000000002c
[42873.499580]  do_idle+0x100/0x211
[42873.501375] RAX: ffffffffffffffda RBX: 000055ce3f8bc340 RCX: 00007ffb463afa73
[42873.501769]  ? __pfx_do_idle+0x10/0x10
[42873.502271] RDX: 0000000000000040 RSI: 000055ce3f8c23c0 RDI: 0000000000000003
[42873.502657]  ? schedule_idle+0x36/0x43
[42873.503029] RBP: 000055ce3f8c23c0 R08: 000055ce3f8be554 R09: 000000000000001c
[42873.503351]  ? do_idle+0x20a/0x211
[42873.504041] R10: 0000000000000800 R11: 0000000000000202 R12: 00007fff2eda8fb8
[42873.504413]  cpu_startup_entry+0x2f/0x31
[42873.505109] R13: 0000000000000040 R14: 0000001d00000001 R15: 000055ce3f8bf700
[42873.505475]  rest_init+0xda/0xda
[42873.506167]  </TASK>
[42873.506498]  start_kernel+0x33a/0x33a
[42873.507179] ---[ end trace 0000000000000000 ]---
[42873.507575]  x86_64_start_reservations+0x25/0x25
[42873.517611]  x86_64_start_kernel+0x78/0x78
[42873.518073]  common_startup_64+0x12c/0x138
[42873.518540]  </TASK>
[42873.518807] ---[ end trace 0000000000000000 ]---

Occessionally, once every, 3-4 tries, I noticed packet loss and kernel 
splat.

$ping6 -f -n -q -c 100 -I  2001:db8:1:2::23
PING 2001:db8:1:2::23(2001:db8:1:2::23) from 2001:db8:1:2::45 : 56 data bytes

--- 2001:db8:1:2::23 ping statistics ---
100 packets transmitted, 38 received, 62% packet loss, time 17843ms
rtt min/avg/max/mdev = 7.639/8.652/36.772/4.642 ms, pipe 2, ipg/ewma 
180.229/11.165 ms

Without iptfs, in tunnel mode, I  have never see the kernel splat or packet losss. 

Have you tried ping6 -f? and possibly with "dont-frag"?

The setup is a simple one, host-to-host tunnel,
2001:db8:1:2::23 to 2001:db8:1:2::45 wit policy /128

root@west:/testing/pluto/ikev2-74-iptfs-02-ipv6$ip x p
src 2001:db8:1:2::45/128 dst 2001:db8:1:2::23/128
	dir out priority 1703937 ptype main
	tmpl src 2001:db8:1:2::45 dst 2001:db8:1:2::23
		proto esp reqid 16393 mode iptfs
src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
	dir fwd priority 1703937 ptype main
	tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
		proto esp reqid 16393 mode iptfs
src 2001:db8:1:2::23/128 dst 2001:db8:1:2::45/128
	dir in priority 1703937 ptype main
	tmpl src 2001:db8:1:2::23 dst 2001:db8:1:2::45
		proto esp reqid 16393 mode iptfs

src 2001:db8:1:2::45 dst 2001:db8:1:2::23
	proto esp spi 0x64b502a7 reqid 16393 mode iptfs
	flag af-unspec esn
	aead rfc4106(gcm(aes)) 0x4bf7846c1418b14213487da785fb4019cfa47396c8c1968fb3a38559e7e39709fa87dfd9 128
	lastused 2024-08-29 09:30:00
	anti-replay esn context:	 oseq-hi 0x0, oseq 0xa
	dir out
	iptfs-opts drop-time 0 reorder-window 0 init-delay 0 dont-frag
src 2001:db8:1:2::23 dst 2001:db8:1:2::45
	proto esp spi 0xc5b34ddd reqid 16393 mode iptfs
	replay-window 0 flag af-unspec esn
	aead rfc4106(gcm(aes)) 0x9029a5ad6da74a19086946836152a6a5d1abbdd81b7a8b997785d23b271413e522da9a11 128
	lastused 2024-08-29 09:30:00
	anti-replay esn context:
	 seq-hi 0x0, seq 0xa
	 replay_window 128, bitmap-length 4
	 00000000 00000000 00000000 000003ff
	dir in
	iptfs-opts pkt-size 3 max-queue-size 3

Did I misconfigure "reorder-window 0" even then it should not drop packets?

-antony

