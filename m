Return-Path: <netdev+bounces-273092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGvPFYQvymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:08:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5780356E2C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 391203004695
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98ED3ACA51;
	Mon, 30 Mar 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R/O85a7x"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0B3ACA48
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858092; cv=none; b=LYiL97C6Mdm3DzeNWBI3c9nyTAYk1bj++g2qD3/HSr0yPvObJEgJzybmRFwYxnu24TzU6FA5w+C3O106WPRIuNk8dUrYPN3HM1uYsEDMvlBl4LXuTzNQ0B971un86jQSIRfxe/Lb4PsKc8F2b08kMMTIDSKtsbcTLPIahX5XVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858092; c=relaxed/simple;
	bh=VYfo2JE7NvtABKnE9DEwIy/nZWzlK8oHOS54PxmISlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdAE8y8BQam3u33/S2O5s7HoRNg7O5Y/lFmcAyhfV3YbbsHxfibd+EqaCxZ7HBfJjdTQ63rKLvvj3vCAtPkNagJ2nS8NHkS5ocBqm1hhE9J2+X1JxqgFGca4NHzIWvOiMcx3NhC1xEQAesOtT9ZRzKE5Tl5bv1jyfziagTbOPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R/O85a7x; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774858079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EAKIwnjB5Oawmq89pgUvZeH/TVFj76rosWd2pW+3SXc=;
	b=R/O85a7x/xGN1+2TpssGJvUqCmyRFAvzSQ7R4+op2aRaKPmXg4WhupfQVOncQEQ7pWeviI
	Ksna5hWOmdGW8VfwzPYyV6JecLGumacZEFsXwb0O0n1F2d/qdSa47YTPSEPeKm9UPXmK49
	ptCThBG/BpyY1rqLPA1J1MNu+bd7U1M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/2] bpf: tcp: Fix null-ptr-deref in arbitrary SYN Cookie
Date: Mon, 30 Mar 2026 16:07:24 +0800
Message-ID: <20260330080746.319680-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-273092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5780356E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

bpf_sk_assign_tcp_reqsk() does not validate the L4 protocol of the skb,
only checking skb->protocol (L3). A BPF program that calls this kfunc on
a non-TCP skb (e.g. UDP) will succeed, attaching a TCP reqsk to the skb.

When the skb enters the UDP receive path, skb_steal_sock() returns the
TCP listener socket from the reqsk. The UDP code then casts this TCP
socket to udp_sock and accesses UDP-specific fields at invalid offsets,
causing a null pointer dereference:

  BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
  Read of size 4 at addr 0000000000000008 by task test_progs/537

  CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREEMPT
  Call Trace:
   <IRQ>
   dump_stack_lvl (lib/dump_stack.c:123)
   print_report (mm/kasan/report.c:487)
   kasan_report (mm/kasan/report.c:597)
   __kasan_check_read (mm/kasan/shadow.c:32)
   __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
   udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
   udp_queue_rcv_skb (net/ipv4/udp.c:2532)
   udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
   __udp4_lib_rcv (net/ipv4/udp.c:2742)
   udp_rcv (net/ipv4/udp.c:2937)
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
   ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_input.c:242)
   ip_local_deliver (net/ipv4/ip_input.c:265)
   __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
   __netif_receive_skb (net/core/dev.c:6280)

Solution

Patch 1: Add L4 protocol validation in bpf_sk_assign_tcp_reqsk(). Check
ip_hdr(skb)->protocol (IPv4) and ipv6_hdr(skb)->nexthdr (IPv6) against
IPPROTO_TCP, returning -EINVAL for non-TCP skbs.
Patch 2: Add selftest that calls bpf_sk_assign_tcp_reqsk() on a UDP skb
and verifies the kfunc rejects it.


---
v1: https://lore.kernel.org/bpf/20260323105510.51990-1-jiayuan.chen@linux.dev/
v2: https://lore.kernel.org/bpf/20260326062657.88446-1-jiayuan.chen@linux.dev/
v3: https://lore.kernel.org/bpf/20260327133915.286037-1-jiayuan.chen@linux.dev/

Changes in v4:
- Check if assign_ret is EINVAL instead of checking if it is 0. 
  Suggested by Martin KaFai Lau

Changes in v3:
- Add IPv6 test coverage, reuse test_cases[] to iterate over both
  address families
- Share TCP/UDP port to simplify BPF program, remove unnecessary
  global variables
- Use connect_to_fd() + send()/recv() instead of manual sockaddr
  construction
- Suggested by Kuniyuki Iwashima

Changes in v2:
- Add Reviewed-by tag from Kuniyuki Iwashima for patch 1
- Use UDP socket recv() instead of kern_sync_rcu() for synchronization
  in selftest

Jiayuan Chen (2):
  bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
  selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()

 net/core/filter.c                             |   6 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  91 ++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 109 ++++++++++++++++++
 3 files changed, 202 insertions(+), 4 deletions(-)

-- 
2.43.0


