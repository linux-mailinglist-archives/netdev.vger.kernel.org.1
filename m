Return-Path: <netdev+bounces-274842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKUoBjgfz2latAYAu9opvQ
	(envelope-from <netdev+bounces-274842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D8439034D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14F3304C97F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10A34CFC0;
	Fri,  3 Apr 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QH5a6AEF"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF634A783
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181559; cv=none; b=dBzIwD/jiSHdXV3CbFUUywiJnPzdrAHxw+t/my2ovSXRacSdUyDBL+vlXhvrkKrdH5MRURmA+nSIh8K0oRnICU7/vW8RrsYQsrom3zecVhPmlzhaoFdENA+1zr7qdN19tNYQS2Dpm8DmgIjGKatkRANoysz4N0hLTuwC/xueM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181559; c=relaxed/simple;
	bh=9fSKD3Avm0BQzmaAfC0U++yV7x2wT6xyCP8d3CRSlQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb/vjg9+ZZUaIWXXBVk763yd8+KvnnoTr8go7iAM8Bkz2gEAVzQSc/WFgmcQT1sO94on+5WFEhgYvuOsdz/caxONu0dD14NHOTIJeundrEB6yxoB4FouJPpQpXtPOUEF7xVhpAuTMY6o6ZDfttuoL/BbgMhS81eHNb+ewOp81Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QH5a6AEF; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775181555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jETAZmeBEafN+dZVNJTdpvdlOz4tdKzzwwoUFu72k6Y=;
	b=QH5a6AEF0tJ8blIgaQlbDzWQQWCRW8oaowhJi+GF7/nX13hVaauB1untwUKDli1ztH+7Ls
	P0O6ZhTgij8NmnAQIuE+5H6Zpii/vhQT8wzDlcmvGTyNmSvXyfnSx5aUeLS1VJSBwUavtc
	Z5ob9t+btu8ntKI6e9qU8uTDPqEwPgs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
Date: Fri,  3 Apr 2026 09:58:27 +0800
Message-ID: <20260403015851.148209-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260403015851.148209-1-jiayuan.chen@linux.dev>
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274842-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,davemloft.net,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83D8439034D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
check the L4 protocol in the IP header. A BPF program can call this kfunc
on a UDP skb with a valid TCP listener socket, which will succeed and
attach a TCP reqsk to the UDP skb.

When the UDP skb enters the UDP receive path, skb_steal_sock() returns
the TCP listener from the reqsk. The UDP code then passes this TCP socket
to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
it to udp_sock and accesses UDP-specific fields at invalid offsets,
causing a null pointer dereference and kernel panic:

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

Fix this by checking the IP header's protocol field in
bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.

Note that for IPv6, the nexthdr check does not walk extension headers.
This is uncommon for TCP SYN packets in practice, and keeping it simple
was agreed upon by Kuniyuki Iwashima.

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb05..523a63584cba0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12247,15 +12247,31 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 		return -ENETUNREACH;
 
 	switch (skb->protocol) {
-	case htons(ETH_P_IP):
+	case htons(ETH_P_IP): {
+		struct iphdr *iph, _iph;
+
+		iph = skb_header_pointer(skb, skb_network_offset(skb),
+					 sizeof(*iph), &_iph);
+		if (!iph || iph->protocol != IPPROTO_TCP)
+			return -EINVAL;
+
 		ops = &tcp_request_sock_ops;
 		min_mss = 536;
 		break;
+	}
 #if IS_BUILTIN(CONFIG_IPV6)
-	case htons(ETH_P_IPV6):
+	case htons(ETH_P_IPV6): {
+		struct ipv6hdr *ip6h, _ip6h;
+
+		ip6h = skb_header_pointer(skb, skb_network_offset(skb),
+					  sizeof(*ip6h), &_ip6h);
+		if (!ip6h || ip6h->nexthdr != IPPROTO_TCP)
+			return -EINVAL;
+
 		ops = &tcp6_request_sock_ops;
 		min_mss = IPV6_MIN_MTU - 60;
 		break;
+	}
 #endif
 	default:
 		return -EINVAL;
-- 
2.43.0


