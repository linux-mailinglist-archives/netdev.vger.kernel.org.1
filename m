Return-Path: <netdev+bounces-273094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGacJpAvymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE7356E43
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED5693004927
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC23ACA72;
	Mon, 30 Mar 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PfswceL2"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD23ACA66
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858095; cv=none; b=eDL/rD8BkW1bdfDi7qV6pl6FkdsH+ls3qhLWaOrzuy4CBudA3JkmqSejUsy3MfYV+1LJgU1JtZLo8JiEd5xA5J55Om2xOz3VbuBSGLBUX6rx1nJLu3xuh46KllBja66YiuEwUBjHArQiQ1C5czCII1nD8olDrBGCF5p3cUIkfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858095; c=relaxed/simple;
	bh=38jvFkpVvultNQ5a1ueAN2rm02/oqIbCKLjCvkvytuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7e4acn4vT4u6brn2VmbMzkMknRITd77sz84N3EItY6DqImYZaiS8qm7xvM4JYscjSsCVZ4VFhglZNp6iXNFGwsKMIIHN2oDzz7A5qFeTfSAmYLRDP4Y+Qa6JRAAnIBE+qRgFOpgpXKXT7lc5mO6/aRmIFOJckJDdGaViL2aPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PfswceL2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774858091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2pQUSQjr2/6ekAGkm9DFB/39oP/oelgKsn7Un+VkTE=;
	b=PfswceL2+VoG2lQh2U3k0JpPdTruTiTwsz/vXX/ghTvquJV1dEetoY4QyzArqjMvFQpAx8
	XvIIOAYkgYH1ITb/qk+ndjFTOqqy7grKkoAiFrkpZAyFO+zEylHorkemAtH8njvuxTjc49
	LQXR+AgjmRCc5YoOjXQnOpwO+RvUWto=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
Date: Mon, 30 Mar 2026 16:07:25 +0800
Message-ID: <20260330080746.319680-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260330080746.319680-1-jiayuan.chen@linux.dev>
References: <20260330080746.319680-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-273094-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3FE7356E43
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

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..fb975bcce804 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12248,11 +12248,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
+		if (ip_hdr(skb)->protocol != IPPROTO_TCP)
+			return -EINVAL;
+
 		ops = &tcp_request_sock_ops;
 		min_mss = 536;
 		break;
 #if IS_BUILTIN(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
+		if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
+			return -EINVAL;
+
 		ops = &tcp6_request_sock_ops;
 		min_mss = IPV6_MIN_MTU - 60;
 		break;
-- 
2.43.0


