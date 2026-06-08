Return-Path: <netdev+bounces-296539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJzKKKC8JmorcAIAu9opvQ
	(envelope-from <netdev+bounces-296539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:59:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A345E6565EA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=l4zdgaSc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296539-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296539-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9872E3004D3D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9B29B78F;
	Mon,  8 Jun 2026 12:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB99296BCF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923547; cv=none; b=muMCfLUN5SK3TiK1Zvu1EH/OL78DAtDuc9wqswEdyfXbtMGm8mwbjPvUKA8eGwWzkA5Uzqus+LZCJSFjGCYtLYemrovjROgk3tuYnDXnz+wREQun0Z742FWNbmMlG01XHZK+rrbXu8ksFI63TQ3cqoqCgSOjNv4eL4x5Cw6vWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923547; c=relaxed/simple;
	bh=5FNPCPysBtlY1McZBVnBdBHZEzilhetJuuzqH/78qcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tik9WM5OEHMIHdlsSLrfpSQkwb8a0tnEjDAv4XlxBd5itcPaCW0wMvjPpCMPkcE+WOcrW06E1StnU1/SpAbr9ZfLcOocn6lnrdOoqVO6bjTIjyfPr4Aph7Gp5j10v0n5xzNCsJ+MZ3OykTKiZByuZr+X6EB3wtRZW6yXUCPYOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4zdgaSc; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780923541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PGHH0jvqAvskxAvzSGW+VDZz2ncp2vRZIRhqBagTjPs=;
	b=l4zdgaScfewFK6IX3WJMvUOIf8TjtU953zJIglPxHvX6jl26BSwH6fRKDHXOsycLMWuA/1
	LIoSeHQC4JbLA/YjiskzXx9HmhqUXHZdvlOZEbTKT2BLoMlbZn+sRY22/+cK6EV+c3/n9Q
	oZdah3OmhOxPwD4sEyAziDx3ncmvA1E=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Joe Stringer <joe@wand.net.nz>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v8 0/2] bpf: tcp: Fix null-ptr-deref in arbitrary SYN Cookie
Date: Mon,  8 Jun 2026 20:58:26 +0800
Message-ID: <20260608125846.157004-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296539-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,wand.net.nz,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A345E6565EA

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

Validating the protocol in the helper is not enough: a BPF program can
bypass an ip_hdr(skb)->protocol check via TOCTOU by rewriting the header
around the call, and bpf_sk_assign() has the same problem since it can
assign any socket type to any skb. So validate the protocol where the
assigned socket is consumed instead.

Patch 1: Validate the L4 protocol in skb_steal_sock(). Each caller passes
the protocol it handles (TCP or UDP), and a prefetched socket whose
protocol does not match is rejected, regardless of how it was assigned.
Patch 2: Add a selftest that calls bpf_sk_assign_tcp_reqsk() on a UDP skb
and verifies the stack no longer crashes.

---
v1: https://lore.kernel.org/bpf/20260323105510.51990-1-jiayuan.chen@linux.dev/
v2: https://lore.kernel.org/bpf/20260326062657.88446-1-jiayuan.chen@linux.dev/
v3: https://lore.kernel.org/bpf/20260327133915.286037-1-jiayuan.chen@linux.dev/
v4: https://lore.kernel.org/bpf/20260330080746.319680-1-jiayuan.chen@linux.dev/
v5: https://lore.kernel.org/bpf/20260401110511.73355-1-jiayuan.chen@linux.dev/
v6: https://lore.kernel.org/all/20260403015851.148209-1-jiayuan.chen@linux.dev/

Changes in v6 & v7: 
- resend and keep selftest.

Changes in v5:
- use skb_header_pointer instead of pskb_may_pull.

Changes in v5:
- Add pskb_may_pull before accessing IP/IPv6 headers in kfunc
- Use buf[] instead of buf[32], verify recv data with ASSERT_STREQ
- Remove unnecessary variable initializations in selftest and BPF

Changes in v4:
- Check if assign_ret is EINVAL instead of checking if it is 0

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
  net: Validate protocol in skb_steal_sock() for BPF-assigned sockets
  selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()

 include/net/inet6_hashtables.h                |   7 +-
 include/net/inet_hashtables.h                 |   7 +-
 include/net/request_sock.h                    |  16 ++-
 net/ipv4/udp.c                                |   2 +-
 net/ipv6/udp.c                                |   2 +-
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  87 ++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 102 ++++++++++++++++++
 7 files changed, 210 insertions(+), 13 deletions(-)

-- 
2.43.0


