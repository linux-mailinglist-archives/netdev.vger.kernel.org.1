Return-Path: <netdev+bounces-281111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAJEN/Ce7GmtagAAu9opvQ
	(envelope-from <netdev+bounces-281111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F2466063
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9622300B10F
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F432D7FF;
	Sat, 25 Apr 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qf1/mXqR"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AE30DEA9
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114813; cv=none; b=rkbwk8LUkPUHo/NJj8PI5TqZyRS2e0QOpYjigwUF/J/M7XpVoW+zJFdqmy76n+qa9XJBgQ68C2taU31D+dhj4VneYGMJ5NQA7v4WR9LXHiHhDv9rCBJkykns4fl3xHC49D3yNDtM0yN8GD5TOZp6Ebg4k8l4EHHc/nw7xyNZBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114813; c=relaxed/simple;
	bh=pX3I+Lk6VVItQh4a/LYbVKNchsr6SttcOh8lFjhQlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgwfRfq/sGzoapHcCS9nv8JZWHqPQc31Xdf81m2xWypPJmQUXG1U0WI1oWkHIi/nsvGAbaAmrwFj6YgST11x7I/f6c28bR8wH60QwQN3McvWqW24sFwWRcTwlrkQSTEc3iyrUbNs5s1JxOVMEmxBf729LdTzwPQ4aEkudQHv/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qf1/mXqR; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777114799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7x1S8p2qzRXK85k0FNVBep0q+wwaaQ/VD9E9QJxBuok=;
	b=qf1/mXqR68FazSOoznM/m6QYtuZFwuDkwZ8moly/aW166SBwpSxNrVwjxHRnX1BWxPPLv7
	cTtm2LeCN+M1Z4YS1iRni0FQMdXgHUqxVqBi6JQ1u5U+mYxiT6uvmvmIgaFu6FDEiA+apf
	MbvLA72ELlvUCp9qRmm9Xt/CVJe36QI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: prevent offloaded programs from running on host via tcx/netkit
Date: Sat, 25 Apr 2026 18:59:27 +0800
Message-ID: <20260425105942.223757-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 455F2466063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281111-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]

Yinhao reported a splat [1] when attaching a BPF program loaded with
prog_ifindex (targeted at an offload-capable device such as netdevsim)
to the software path via BPF_TCX_EGRESS. The program's bpf_func had
already been replaced by bpf_prog_warn_on_exec() during offload compile,
so the first packet that reaches tcx_run() trips the WARN:

[   19.592982] ------------[ cut here ]------------
[   19.594654] attempt to execute device eBPF program on the host!
[   19.594659] WARNING: kernel/bpf/offload.c:420 at 0x0, CPU#0: poc/337
[   19.599906] Modules linked in:
[   19.600680] CPU: 0 UID: 0 PID: 337 Comm: poc Not tainted
6.18.0-rc7-next-20251125 #10 PREEMPT(none)
[   19.601659] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   19.602684] RIP: 0010:bpf_prog_warn_on_exec+0xc/0x20
[   19.603241] Code: 28 00 48 89 ef e8 74 44 2f 00 eb d7 66 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8d 3d a4 eb 95
06 <67> 48 0f b9 3a 31 c0 e9 83 76 44 ff 0f 1f 84 00 00 00 00 00 90 90
[   19.605093] RSP: 0018:ffff8881066e73d8 EFLAGS: 00010246
[   19.605663] RAX: ffffffff81cbca70 RBX: ffff8881013c4210 RCX:
0000000000000004
[   19.606378] RDX: 1ffff11020278842 RSI: ffffc90000563060 RDI:
ffffffff8861b620
[   19.607107] RBP: ffff8881010d0640 R08: ffff8881013c4210 R09:
ffff8881010d06b0
[   19.607827] R10: ffff8881010d06c3 R11: ffffc90000563000 R12:
ffffc90000563000
[   19.608751] R13: ffff8881010d06b4 R14: ffff888115eb1a34 R15:
dffffc0000000000
[   19.609478] FS:  000000000294c380(0000) GS:ffff8881911e9000(0000)
knlGS:0000000000000000
[   19.610316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.610943] CR2: 000057f6b9eb38c0 CR3: 00000001010ea000 CR4:
0000000000750ef0
[   19.611712] PKRU: 55555554
[   19.612006] Call Trace:
[   19.612281]  <TASK>
[   19.612523]  __dev_queue_xmit+0x22cb/0x3530
[   19.617607]  ip_finish_output2+0x621/0x1a60
[   19.621371]  ip_output+0x170/0x2e0
[   19.624586]  ip_send_skb+0x129/0x180
[   19.624940]  udp_send_skb+0x65d/0x1300
[   19.625316]  udp_sendmsg+0x13bf/0x2000
[   19.629960]  __sys_sendto+0x396/0x470
[   19.633720]  __x64_sys_sendto+0xdc/0x1b0
[   19.635066]  do_syscall_64+0x76/0x10a0
[   19.641701]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.642240] RIP: 0033:0x4240d7
[   19.642597] Code: 00 89 01 e9 c1 fe ff ff e8 f6 03 00 00 66 0f 1f 44
00 00 f3 0f 1e fa 80 3d 8d 3f 09 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
[   19.646088] RSP: 002b:00007fffcb9ecb68 EFLAGS: 00000202 ORIG_RAX:
000000000000002c
[   19.648938] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00000000004240d7
[   19.652116] RDX: 0000000000000008 RSI: 00007fffcb9ecce0 RDI:
0000000000000005
[   19.653148] RBP: 00007fffcb9eccf0 R08: 00007fffcb9ecbb0 R09:
0000000000000010
[   19.653951] R10: 0000000000000000 R11: 0000000000000202 R12:
00007fffcb9ece08
[   19.654760] R13: 00007fffcb9ece18 R14: 00000000004b2868 R15:
0000000000000001
[   19.657462]  </TASK>
[   19.657703] ---[ end trace 0000000000000000 ]---

The reason is that tcx, netkit and bpf_xdp_link_update() can install an
offloaded program onto a software execution path without rejecting it.
Rather than sprinkling the same check across every attach/update entry
point, do it at the source:

  - bpf_mprog_attach() is the single chokepoint for tcx/netkit (covers
    all three of attach, link create and link update on both subsystems,
    six call sites in total).
  - dev_xdp_install() is the single chokepoint for XDP (covers both the
    dev_xdp_attach() path and the bpf_xdp_link_update() path which
    previously bypassed the check).

This series adds/moves the check into those two functions so offloaded
programs can no longer be attached to (or swapped into) the software
path, regardless of which entry point is used.

v2 -> v3:
  - Alexei suggested converging the check rather than spreading it
    across attach entry points. Consolidated into a single check at
    bpf_mprog_attach() (covers all six tcx/netkit paths) and moved the
    existing XDP check from dev_xdp_attach() into dev_xdp_install() so
    the bpf_xdp_link_update() path is also covered. Three patches
    collapse into two.
v2: https://lore.kernel.org/bpf/20260424104201.217604-1-jiayuan.chen@linux.dev/

v1 -> v2:
  - tcx/netkit: also reject offloaded progs in the link update callback
    (tcx_link_update/netkit_link_update), not just attach; pointed out
    by the AI review on v1.
  - Add patch 3/3 for the same hole in bpf_xdp_link_update().
v1: https://lore.kernel.org/bpf/20260423033609.252464-1-jiayuan.chen@linux.dev/

[1]: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/

Jiayuan Chen (2):
  bpf, tcx, netkit: reject offloaded programs
  bpf, xdp: move offload check into dev_xdp_install()

 kernel/bpf/mprog.c | 11 +++++++++++
 net/core/dev.c     |  9 +++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.43.0


