Return-Path: <netdev+bounces-97890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D388CDADF
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FFAB23C90
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC5219E7;
	Thu, 23 May 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="bRBJ8OO5"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31929AB
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492640; cv=none; b=QKgEhyMf4bChnWNzZ/NoawoCgsPsJUpZBninPorQvncic9oFPhYxIQD3m73p8IITKq85fgejhwsa6hf2XMSXxzJ4JcbIIxUFf2lti9+kiTwSD0OfiTSLl8DfVdqHQ6H39xo5Vnrmoj+6PE3NO5QKfMLFOomX0EVF8ofpLlv4jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492640; c=relaxed/simple;
	bh=rEpP2PlKKAU7ZxTjpNrZ/JjWxmDBIkjrBrbIs+a2yjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmgJx8xmq6/Sq3tLxjRO0WZEWo8FD0FJVHvJPPysCI+CHQbOfvocAzNBAtcArJDd3/mxXHYK6EMLhql5Bnfwou7TJtjG0MP3QwgqNAGUC1RXss3TSJOgLNnvZje508Ncw9JC6cneIThYyjLQ0YNX28wvsJ4QBKDXx1QxH8gxvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=bRBJ8OO5; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: bbb4f4ed-193a-11ef-93a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bbb4f4ed-193a-11ef-93a8-005056abbe64;
	Thu, 23 May 2024 21:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=ftGZF5WlVcqc2ZLyO2cr7wlHHWTXNLkw0qPpiRfZn1w=;
	b=bRBJ8OO5YqEU66J8K2K/CtrkRsSEogmk1jMLRqQfK1Wk8hHaW5pmtSy6LO4OjBv2P31G6v1hK0oU3
	 QiNEfSZ6nS3sa2TfivS5nPE4jgXv0LHVw0mlwMC5j1+UIvEwWY7w3IGJNJ9hmnXhx+LBmTieIBszqG
	 X6TTV3LKKKYO/eW0=
X-KPN-MID: 33|0zhVwXGGR/NN4NNPfVcXepi7d1cQPQKL9FZWH/GXZBNKOblM+qHSShY8EDWLDE8
 ciy5P86BLaAWFFeB5kRn6rE3DoBBnptQKXyzmE/NkXV0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|AHOgDKQY1p997ufRD1qozZQD5KcB8n2uPK1lEWGrmTy98d/PV93bz+f85QoCMn0
 3PBGjZTs0edszxTYAQvC5ag==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c2baef80-193a-11ef-a07f-005056abf0db;
	Thu, 23 May 2024 21:29:24 +0200 (CEST)
Date: Thu, 23 May 2024 21:29:23 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v1 0/8] Add IP-TFS mode to xfrm
Message-ID: <Zk-ZEzFmC7zciKCu@Antony2201.local>
References: <20240520214255.2590923-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520214255.2590923-1-chopps@chopps.org>

Hi Chris,

On Mon, May 20, 2024 at 05:42:38PM -0400, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Summary of Changes
> ------------------
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
> Patchset Changes:
> -----------------
> 
>   23 files changed, 3252 insertions(+), 19 deletions(-)
>   Documentation/networking/xfrm_sysctl.rst |   30 +
>   include/net/netns/xfrm.h                 |    6 +
>   include/net/xfrm.h                       |   40 +
>   include/uapi/linux/in.h                  |    2 +
>   include/uapi/linux/ip.h                  |   16 +
>   include/uapi/linux/ipsec.h               |    3 +-
>   include/uapi/linux/snmp.h                |    3 +
>   include/uapi/linux/xfrm.h                |    9 +-
>   net/ipv4/esp4.c                          |    3 +-
>   net/ipv6/esp6.c                          |    3 +-
>   net/netfilter/nft_xfrm.c                 |    3 +-
>   net/xfrm/Makefile                        |    1 +
>   net/xfrm/trace_iptfs.h                   |  218 +++
>   net/xfrm/xfrm_compat.c                   |   10 +-
>   net/xfrm/xfrm_device.c                   |    4 +-
>   net/xfrm/xfrm_input.c                    |   14 +-
>   net/xfrm/xfrm_iptfs.c                    | 2741 ++++++++++++++++++++++++++++++
>   net/xfrm/xfrm_output.c                   |    6 +
>   net/xfrm/xfrm_policy.c                   |   26 +-
>   net/xfrm/xfrm_proc.c                     |    3 +
>   net/xfrm/xfrm_state.c                    |   60 +
>   net/xfrm/xfrm_sysctl.c                   |   38 +
>   net/xfrm/xfrm_user.c                     |   32 +
> 
> Patchset Structure:
> -------------------
> 
> The first 8 commits are changes to the xfrm infrastructure to support
> the callbacks as well as more generic IP-TFS additions that may be used
> outside the actual IP-TFS implementation.
> 
>   - iptfs: config: add CONFIG_XFRM_IPTFS
>   - iptfs: uapi: ip: add ip_tfs_*_hdr packet formats
>   - iptfs: uapi: IPPROTO_AGGFRAG AGGFRAG in ESP
>   - iptfs: sysctl: allow configuration of global default values
>   - iptfs: netlink: add config (netlink) options
>   - iptfs: xfrm: Add mode_cbs module functionality
>   - iptfs: xfrm: add generic iptfs defines and functionality
> 
> The last 9+1 commits constitute the IP-TFS implementation constructed in
> layers to make review easier. The first 9 commits all apply to a single
> file `net/xfrm/xfrm_iptfs.c`, the last commit adds a new tracepoint
> header file along with the use of these new tracepoint calls.
> 
>   - iptfs: impl: add new iptfs xfrm mode impl
>   - iptfs: impl: add user packet (tunnel ingress) handling
>   - iptfs: impl: share page fragments of inner packets
>   - iptfs: impl: add fragmenting of larger than MTU user packets
>   - iptfs: impl: add basic receive packet (tunnel egress) handling
>   - iptfs: impl: handle received fragmented inner packets
>   - iptfs: impl: add reusing received skb for the tunnel egress packet
>   - iptfs: impl: add skb-fragment sharing code
>   - iptfs: impl: handle reordering of received packets
>   - iptfs: impl: add tracepoint functionality
> 
> Patchset History:
> -----------------
> 
> RFCv1 (11/10/2023)
> 
> RFCv1 -> RFCv2 (11/12/2023)
> 
>   Updates based on feedback from Simon Horman, Antony,
>   Michael Richardson, and kernel test robot.
> 
> RFCv2 -> v1 (2/19/2024)
> 
>   Updates based on feedback from Sabrina Dubroca, kernel test robot
> 
> v1 -> v2 (5/19/2024)
> 
>   Updates based on feedback from Sabrina Dubroca, Simon Horman, Antony.
> 
>   o Add handling of new netlink SA direction attribute (Antony).
>   o Split single patch/commit of xfrm_iptfs.c (the actual IP-TFS impl)
>     into 9+1 distinct layered functionality commits for aiding review.
>   - xfrm: fix return check on clone() callback
>   - xfrm: add sa_len() callback in xfrm_mode_cbs for copy to user
>   - iptfs: remove unneeded skb free count variable
>   - iptfs: remove unused variable and "breadcrumb" for future code.
>   - iptfs: use do_div() to avoid "__udivd13 missing" link failure.
>   - iptfs: remove some BUG_ON() assertions questioned in review.
> -- 

I ran a couple of tests and it hit KSAN BUG.

I was sending large ping while MTU is 1500.

north login: shed systemd-user-sessions.service - Permit User Sessions.
north login: [   78.594770] ==================================================================
[   78.595825] BUG: KASAN: null-ptr-deref in iptfs_output_collect+0x263/0x57b
[   78.596658] Read of size 8 at addr 0000000000000108 by task ping/493
[   78.597435] ng rpc-statd-notify.service - Notify NFS peers of a restart...
[   78.597651] CPU: 0 PID: 493 Comm: ping Not tainted 6.9.0-rc2-00697-g489ca863e24f-dirty #11
[   78.598645] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   78.599747] Call Trace:tty@ttyS2.service - Serial Getty on ttyS2.
[   78.600070]  <TASK>l-getty@ttyS3.service - Serial Getty on ttyS3.
[   78.600354]  dump_stack_lvl+0x2a/0x3bogin Prompts.
[   78.600817]  kasan_report+0x84/0xa6rvice - Hostname Service...
[   78.601262]  ? iptfs_output_collect+0x263/0x57bl server.
[   78.601825]  iptfs_output_collect+0x263/0x57bogin Management.
[   78.602374]  ip_send_skb+0x25/0x57vice - Notify NFS peers of a restart.
[   78.602807]  raw_sendmsg+0xee8/0x1011t - Multi-User System.
[   78.603269]  ? native_flush_tlb_one_user+0xd/0xe5e Service.
[   78.603850]  ? raw_hash_sk+0x21b/0x21b
[   78.604331]  ? kernel_init_pages+0x42/0x51
[   78.604845]  ? prep_new_page+0x44/0x51Re…line ext4 Metadata Check Snapshots.
[   78.605318]  ? get_page_from_freelist+0x72b/0x915 Interface.
[   78.605903]  ? signal_pending_state+0x77/0x77cord Runlevel Change in UTMP...
[   78.606462]  ? __might_resched+0x8a/0x240e - Record Runlevel Change in UTMP.
[   78.606966]  ? __might_sleep+0x25/0xa0
[   78.607440]  ? first_zones_zonelist+0x2c/0x43
[   78.607985]  ? __rcu_read_lock+0x2d/0x3a
[   78.608479]  ? __pte_offset_map+0x32/0xa4
[   78.608979]  ? __might_resched+0x8a/0x240
[   78.609478]  ? __might_sleep+0x25/0xa0
[   78.609949]  ? inet_send_prepare+0x54/0x54
[   78.610464]  ? sock_sendmsg_nosec+0x42/0x6c
[   78.610984]  sock_sendmsg_nosec+0x42/0x6c
[   78.611485]  __sys_sendto+0x15d/0x1cc
[   78.611947]  ? __x64_sys_getpeername+0x44/0x44
[   78.612498]  ? __handle_mm_fault+0x679/0xae4
[   78.613033]  ? find_vma+0x6b/0x8b
[   78.613457]  ? find_vma_intersection+0x8a/0x8a
[   78.614006]  ? __handle_irq_event_percpu+0x180/0x197
[   78.614617]  ? handle_mm_fault+0x38/0x154
[   78.615114]  ? handle_mm_fault+0xeb/0x154
[   78.615620]  ? preempt_latency_start+0x29/0x34
[   78.616169]  ? preempt_count_sub+0x14/0xb3
[   78.616678]  ? up_read+0x4b/0x5c
[   78.617094]  __x64_sys_sendto+0x76/0x82
[   78.617577]  do_syscall_64+0x6b/0xd7
[   78.618043]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   78.618667] RIP: 0033:0x7fed3de99a73
[   78.619118] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[   78.621291] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   78.622205] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: 00007fed3de99a73
[   78.623056] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: 0000000000000003
[   78.623908] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: 0000000000000010
[   78.624765] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000007d8
[   78.625619] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: 000055c53815c680
[   78.626480]  </TASK>
[   78.626773] ==================================================================
[   78.627656] Disabling lock debugging due to kernel taint
[   78.628305] BUG: kernel NULL pointer dereference, address: 0000000000000108
[   78.629136] #PF: supervisor read access in kernel mode
[   78.629766] #PF: error_code(0x0000) - not-present page
[   78.630402] PGD 0 P4D 0
[   78.630739] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC KASAN
[   78.631398] CPU: 0 PID: 493 Comm: ping Tainted: G    B              6.9.0-rc2-00697-g489ca863e24f-dirty #11
[   78.632548] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   78.633649] RIP: 0010:iptfs_output_collect+0x263/0x57b
[   78.634283] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 00 00 48 8d 7b 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 ff <4d> 8b b6 08 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
[   78.636444] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
[   78.637076] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: fffffbfff07623ad
[   78.637923] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: ffffffff83b11d60
[   78.638792] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: 0000000000000001
[   78.639645] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: 00000000000005a2
[   78.640498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810e9a3401
[   78.641359] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0000) knlGS:0000000000000000
[   78.642324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.643022] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: 0000000000350ef0
[   78.643882] Call Trace:
[   78.644204]  <TASK>
[   78.644487]  ? __die_body+0x1a/0x56
[   78.644929]  ? page_fault_oops+0x45f/0x4cd
[   78.645441]  ? dump_pagetable+0x1db/0x1db
[   78.645942]  ? vprintk_emit+0x163/0x171
[   78.646425]  ? iptfs_output_collect+0x263/0x57b
[   78.646986]  ? _printk+0xb2/0xe1
[   78.647401]  ? find_first_fitting_seq+0x193/0x193
[   78.647982]  ? iptfs_output_collect+0x263/0x57b
[   78.648541]  ? do_user_addr_fault+0x14f/0x56c
[   78.649084]  ? exc_page_fault+0xa5/0xbe
[   78.649566]  ? asm_exc_page_fault+0x22/0x30
[   78.650100]  ? iptfs_output_collect+0x263/0x57b
[   78.650660]  ? iptfs_output_collect+0x263/0x57b
[   78.651221]  ip_send_skb+0x25/0x57
[   78.651652]  raw_sendmsg+0xee8/0x1011
[   78.652113]  ? native_flush_tlb_one_user+0xd/0xe5
[   78.652693]  ? raw_hash_sk+0x21b/0x21b
[   78.653166]  ? kernel_init_pages+0x42/0x51
[   78.653683]  ? prep_new_page+0x44/0x51
[   78.654160]  ? get_page_from_freelist+0x72b/0x915
[   78.654739]  ? signal_pending_state+0x77/0x77
[   78.655284]  ? __might_resched+0x8a/0x240
[   78.655784]  ? __might_sleep+0x25/0xa0
[   78.656255]  ? first_zones_zonelist+0x2c/0x43
[   78.656798]  ? __rcu_read_lock+0x2d/0x3a
[   78.657289]  ? __pte_offset_map+0x32/0xa4
[   78.657788]  ? __might_resched+0x8a/0x240
[   78.658291]  ? __might_sleep+0x25/0xa0
[   78.658763]  ? inet_send_prepare+0x54/0x54
[   78.659272]  ? sock_sendmsg_nosec+0x42/0x6c
[   78.659791]  sock_sendmsg_nosec+0x42/0x6c
[   78.660293]  __sys_sendto+0x15d/0x1cc
[   78.660755]  ? __x64_sys_getpeername+0x44/0x44
[   78.661304]  ? __handle_mm_fault+0x679/0xae4
[   78.661838]  ? find_vma+0x6b/0x8b
[   78.662272]  ? find_vma_intersection+0x8a/0x8a
[   78.662828]  ? __handle_irq_event_percpu+0x180/0x197
[   78.663436]  ? handle_mm_fault+0x38/0x154
[   78.663935]  ? handle_mm_fault+0xeb/0x154
[   78.664435]  ? preempt_latency_start+0x29/0x34
[   78.664987]  ? preempt_count_sub+0x14/0xb3
[   78.665498]  ? up_read+0x4b/0x5c
[   78.665911]  __x64_sys_sendto+0x76/0x82
[   78.666398]  do_syscall_64+0x6b/0xd7
[   78.666849]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   78.667466] RIP: 0033:0x7fed3de99a73
[   78.667918] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[   78.670097] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   78.671002] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: 00007fed3de99a73
[   78.671858] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: 0000000000000003
[   78.672708] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: 0000000000000010
[   78.673564] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000007d8
[   78.674430] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: 000055c53815c680
[   78.675287]  </TASK>
[   78.675580] Modules linked in:
[   78.675975] CR2: 0000000000000108
[   78.676396] ---[ end trace 0000000000000000 ]---
[   78.676966] RIP: 0010:iptfs_output_collect+0x263/0x57b
[   78.677596] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 00 00 48 8d 7b 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 ff <4d> 8b b6 08 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
[   78.679768] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
[   78.680410] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: fffffbfff07623ad
[   78.681264] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: ffffffff83b11d60
[   78.682136] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: 0000000000000001
[   78.682997] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: 00000000000005a2
[   78.683853] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810e9a3401
[   78.684710] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0000) knlGS:0000000000000000
[   78.685675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.686387] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: 0000000000350ef0
[   78.687246] Kernel panic - not syncing: Fatal exception in interrupt
[   78.688014] Kernel Offset: disabled
[   78.688460] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

ping -s 2000  -n -q -W 1 -c 2 -I 192.0.3.254  192.0.2.254

(gdb) list *iptfs_output_collect+0x263
0xffffffff81d5076f is in iptfs_output_collect (./include/net/net_namespace.h:383).
378	}
379
380	static inline struct net *read_pnet(const possible_net_t *pnet)
381	{
382	#ifdef CONFIG_NET_NS
383		return rcu_dereference_protected(pnet->net, true);
384	#else
385		return &init_net;
386	#endif
387	}

I suspect actual crash is from the line 1756 instead,
(gdb) list *iptfs_output_collect+0x256
0xffffffff81d50762 is in iptfs_output_collect (net/xfrm/xfrm_iptfs.c:1756).
1751			return 0;
1752
1753		/* We only send ICMP too big if the user has configured us as
1754		 * dont-fragment.
1755		 */
1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
1757
1758		if (sk) {
1759			xfrm_local_error(skb, pmtu);
1760		} else if (ip_hdr(skb)->version == 4) {

Later I ran with gdb iptfs_is_too_big which is called twice and second time 
it crash.
Here is gdb bt. Just before the crash

#0  iptfs_is_too_big (pmtu=1442, skb=0xffff88810dbea3c0, sk=0xffff888104d4ed40) at net/xfrm/xfrm_iptfs.c:1756
#1  iptfs_output_collect (net=<optimized out>, sk=0xffff888104d4ed40, skb=0xffff88810dbea3c0) at net/xfrm/xfrm_iptfs.c:1847
#2  0xffffffff81c8a3cb in ip_send_skb (net=0xffffffff83e57f20 <init_net>, skb=0xffff88810dbea3c0)
    at net/ipv4/ip_output.c:1492
#3  0xffffffff81c8a439 in ip_push_pending_frames (sk=sk@entry=0xffff888104d4ed40, fl4=fl4@entry=0xffffc90000e3fb90)
    at net/ipv4/ip_output.c:1512
#4  0xffffffff81ccf3cf in raw_sendmsg (sk=0xffff888104d4ed40, msg=0xffffc90000e3fd80, len=<optimized out>)
    at net/ipv4/raw.c:654
#5  0xffffffff81b096ea in sock_sendmsg_nosec (sock=sock@entry=0xffff888115136040, msg=msg@entry=0xffffc90000e3fd80)
    at net/socket.c:730
#6  0xffffffff81b0c327 in __sock_sendmsg (msg=0xffffc90000e3fd80, sock=0xffff888115136040) at net/socket.c:745
#7  __sys_sendto (fd=<optimized out>, buff=buff@entry=0x558edefb73c0, len=len@entry=2008, flags=flags@entry=0,
    addr=addr@entry=0x558edefb35c0, addr_len=addr_len@entry=16) at net/socket.c:2191
#8  0xffffffff81b0c40c in __do_sys_sendto (addr_len=16, addr=0x558edefb35c0, flags=0, len=2008, buff=0x558edefb73c0,
    fd=<optimized out>) at net/socket.c:2203
#9  __se_sys_sendto (addr_len=16, addr=94072114722240, flags=0, len=2008, buff=94072114738112, fd=<optimized out>)
    at net/socket.c:2199

gdb) list
1751			return 0;
1752
1753		/* We only send ICMP too big if the user has configured us as
1754		 * dont-fragment.
1755		 */
1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
1757
1758		if (sk) {
1759			xfrm_local_error(skb, pmtu);
1760		} else if (ip_hdr(skb)->version == 4) {

-antony

