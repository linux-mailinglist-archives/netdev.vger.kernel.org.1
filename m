Return-Path: <netdev+bounces-262045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBBsGxdRommF1wQAu9opvQ
	(envelope-from <netdev+bounces-262045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7D1BFF35
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD3331262B2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92B32720C;
	Sat, 28 Feb 2026 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fj32PcGk"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CA32ED2E
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245182; cv=none; b=p8RwejvxlpTlPkAo5/JXBBm1VlrxyAgppZVtoHY9JQFlMEjFQRrKiLNrJlA0EthzcoCVJALSKkAunI2kNaBSqEfQKw4wTKLXX1lRHD2g8kcR7fwKqpav1J7lMSR1aC9pST8kQaZ47ZxX6tFUi3vmSIdXKitwy9RZmVKiDaRZrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245182; c=relaxed/simple;
	bh=gHIh4sqbYO3XN4sKruePjxab0owym4GgL7g75gy8ct4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCFrawVMQ66pMvIo6sLYdxX9J1gjiBxVczuse9+rDASBcRDngQuxIc8A7CeQ2H0WonoJb3pNSFCgXdoKpptDR5CzCpejSex0jxukcr0U41MDxzm6qBy2y1deZxNQhpfYRoit59Dsgbr0GqVJ7DBsMH3ynJrw8RP52qPAbk0kO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fj32PcGk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772245168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VBBFXxju4EHAKAvIFPYghqpWPD1q39Oai/LGor6LSrU=;
	b=Fj32PcGkDiI7U+Q0OcuYbXbNmn3Hjgi7SjTx0DavqfC44/v73/ZJ6kZaej7SsB4O+hEeqA
	nWJZYB+OZSScIhNwnLBdSsex6K1iXp4f4q7pIDTlDTG643TbgxMAh+y1QGhKQa3zHfPkOJ
	0SSRBg4x1iXku51mldXq2923TSCYRjk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v3 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Sat, 28 Feb 2026 10:19:12 +0800
Message-ID: <20260228021918.141002-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-262045-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linux.dev:mid,linux.dev:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0E7D1BFF35
X-Rspamd-Action: no action

syzkaller reported a kernel panic [1] with the following crash stack:

Call Trace:
BUG: unable to handle page fault for address: ffff8ebd08580000
PF: supervisor write access in kernel mode
PF: error_code(0x0002) - not-present page
PGD 11f201067 P4D 11f201067 PUD 0
Oops: Oops: 0002 [#1] SMP PTI
CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PREEMPT_RT
RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 bond_xdp_get_xmit_slave+0xc0/0x240
 xdp_master_redirect+0x74/0xc0
 bpf_prog_run_generic_xdp+0x2f2/0x3f0
 do_xdp_generic+0x1fd/0x3d0
 __netif_receive_skb_core.constprop.0+0x30d/0x1220
 __netif_receive_skb_list_core+0xfc/0x250
 netif_receive_skb_list_internal+0x20c/0x3d0
 ? eth_type_trans+0x137/0x160
 netif_receive_skb_list+0x25/0x140
 xdp_test_run_batch.constprop.0+0x65b/0x6e0
 bpf_test_run_xdp_live+0x1ec/0x3b0
 bpf_prog_test_run_xdp+0x49d/0x6e0
 __sys_bpf+0x446/0x27b0
 __x64_sys_bpf+0x1a/0x30
 x64_sys_call+0x146c/0x26e0
 do_syscall_64+0xd3/0x1510
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Problem Description

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
when the bond mode is round-robin. If the bond device was never brought
up, rr_tx_counter remains NULL.

The XDP redirect path can reach this code even when the bond is not up:
bpf_master_redirect_enabled_key is a global static key, so when any bond
device has native XDP attached, the XDP_TX -> xdp_master_redirect()
interception is enabled for all bond slaves system-wide.

Solution

Patch 1: Allocate rr_tx_counter unconditionally in bond_init() (ndo_init).
Patch 2: Add a selftest that reproduces the above scenario.

Changes since v2:
https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux.dev/T/#t
- Moved allocation from bond_create_init() helper into bond_init()
  (ndo_init), which is the natural single point covering both creation
  paths and also handles post-creation mode changes to round-robin

Changes since v1:
https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#t
- Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
  into the bonding subsystem itself
  (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)

[1] https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

Jiayuan Chen (2):
  bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
  selftests/bpf: add test for xdp_master_redirect with bond not up

 drivers/net/bonding/bond_main.c               |  12 +--
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 2 files changed, 105 insertions(+), 8 deletions(-)

-- 
2.43.0


