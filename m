Return-Path: <netdev+bounces-296541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7pPfNba8JmovcAIAu9opvQ
	(envelope-from <netdev+bounces-296541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4386565F8
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:59:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="FHYQcl/j";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296541-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E37913004D3D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648E2BDC28;
	Mon,  8 Jun 2026 12:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F63230BE9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923569; cv=none; b=F7b6eVg9/l2+XvpvnOH49ocr9spUbrsOrETtcD3d/AoKr5TQ08XVIE0Zy2GBKhm1JJKprtRGpHlzl8xmKmXr+BDsWCKLgSlIpud3Yi9vHr62nxbTSn8UHOUDZ4D84ztEnO2Edtb3Apb0OkgnVgcXE3lHNSJyTgTRAQ0Gi4BkQR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923569; c=relaxed/simple;
	bh=pppSCiti4jvi5EsxxegmSDnZrha/rHxM9F+JK/EvxDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlvQATfbAs77M6ZbaST43rqoIVKgOoff6GRbGNnPs1G4es22IYyakWPKNw3LMF2MAt55zzR021VVRD0u9UM08f/aN2X3CJi9wQpQDcnVzLp1yPT4Xwp1rNMLpXbGl6c3fij4JE5cwY8Fs6LoflRqh4vUwah0/iESw+E+IjN8pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FHYQcl/j; arc=none smtp.client-ip=91.218.175.183
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780923566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3XNGhcQHJVmcyavdjn9EhDX/kEW3MIT6FKFuaZuhMc=;
	b=FHYQcl/jKZ6FER/I7Nsw0rubDgjwRebm9faiJzCI6Qy+D8pGv+GbpsYyyaMA55ERV5fNNp
	otTEdJUoB4CTR2WhYFXTqtOWwbmMlOHux0E0n4s3X5YKNLzplzDmAwIwYJtk6UlEz/Yi4n
	ogIVPOzzs4Q498mo8pFRzuuYhHCq0lA=
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
Subject: [PATCH bpf v8 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
Date: Mon,  8 Jun 2026 20:58:28 +0800
Message-ID: <20260608125846.157004-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260608125846.157004-1-jiayuan.chen@linux.dev>
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296541-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,wand.net.nz,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,ipv6.sport:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB4386565F8

Add test_tcp_custom_syncookie_protocol_check to test assigning a TCP sk to
UDP skb->sk. The test sends a UDP packet through TC ingress, where a BPF
program calls bpf_sk_assign_tcp_reqsk() on it. A UDP server's recv() is
used for synchronization to ensure the BPF program has finished processing
before checking the result.

Without the fix in bpf_sk_assign_tcp_reqsk(), this will cause a null
pointer dereference panic when the kernel processes it through the UDP
receive path.

Test result:
	./test_progs -a tcp_custom_syncookie_protocol_check -v
	setup_netns:PASS:create netns 0 nsec
	setup_netns:PASS:ip 0 nsec
	write_sysctl:PASS:open sysctl 0 nsec
	write_sysctl:PASS:write sysctl 0 nsec
	setup_netns:PASS:write_sysctl 0 nsec
	test_tcp_custom_syncookie_protocol_check:PASS:open_and_load 0 nsec
	setup_tc:PASS:qdisc add dev lo clsact 0 nsec
	setup_tc:PASS:filter add dev lo ingress 0 nsec
	run_protocol_check:PASS:start tcp_server 0 nsec
	run_protocol_check:PASS:start udp_server 0 nsec
	run_protocol_check:PASS:connect udp_client 0 nsec
	run_protocol_check:PASS:send udp 0 nsec
	run_protocol_check:PASS:recv udp 0 nsec
	run_protocol_check:PASS:recv data 0 nsec
	run_protocol_check:PASS:udp_intercepted 0 nsec
	#492/1   tcp_custom_syncookie_protocol_check/IPv4 TCP:OK
	run_protocol_check:PASS:start tcp_server 0 nsec
	run_protocol_check:PASS:start udp_server 0 nsec
	run_protocol_check:PASS:connect udp_client 0 nsec
	run_protocol_check:PASS:send udp 0 nsec
	run_protocol_check:PASS:recv udp 0 nsec
	run_protocol_check:PASS:recv data 0 nsec
	run_protocol_check:PASS:udp_intercepted 0 nsec
	#492/2   tcp_custom_syncookie_protocol_check/IPv6 TCP:OK
	#492     tcp_custom_syncookie_protocol_check:OK
	Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  87 ++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 102 ++++++++++++++++++
 2 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index 00d5c32674fc9..03103b7b9c5bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -5,6 +5,7 @@
 #include <sched.h>
 #include <stdlib.h>
 #include <net/if.h>
+#include <netinet/in.h>
 
 #include "test_progs.h"
 #include "cgroup_helpers.h"
@@ -47,11 +48,10 @@ static int setup_netns(void)
 	return -1;
 }
 
-static int setup_tc(struct test_tcp_custom_syncookie *skel)
+static int setup_tc(int prog_fd)
 {
 	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
-	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
-		    .prog_fd = bpf_program__fd(skel->progs.tcp_custom_syncookie));
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach, .prog_fd = prog_fd);
 
 	qdisc_lo.ifindex = if_nametoindex("lo");
 	if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo clsact"))
@@ -147,7 +147,7 @@ void test_tcp_custom_syncookie(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		return;
 
-	if (setup_tc(skel))
+	if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
 		goto destroy_skel;
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
@@ -165,6 +165,85 @@ void test_tcp_custom_syncookie(void)
 
 destroy_skel:
 	system("tc qdisc del dev lo clsact");
+	test_tcp_custom_syncookie__destroy(skel);
+}
+
+/* TCP and UDP servers share the same port. The BPF program intercepts
+ * the UDP packet, looks up the TCP listener via the dest port, and
+ * attempts to assign a TCP reqsk to the UDP skb.
+ * Although bpf_sk_assign_tcp_reqsk() assign udp skb to tcp reqsk, the
+ * network stack should not crash.
+ */
+static void run_protocol_check(struct test_tcp_custom_syncookie *skel,
+			       int family, const char *addr)
+{
+	int tcp_server, udp_server, udp_client;
+	char buf[] = "test";
+	int port, ret;
+
+	tcp_server = start_server(family, SOCK_STREAM, addr, 0, 0);
+	if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
+		return;
+
+	port = ntohs(get_socket_local_port(tcp_server));
+
+	/* UDP server on same port for synchronization and port sharing */
+	udp_server = start_server(family, SOCK_DGRAM, addr, port, 0);
+	if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
+		goto close_tcp;
+
+	skel->bss->udp_intercepted = false;
+
+	udp_client = connect_to_fd(udp_server, 0);
+	if (!ASSERT_NEQ(udp_client, -1, "connect udp_client"))
+		goto close_udp_server;
+
+	ret = send(udp_client, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, sizeof(buf), "send udp"))
+		goto close_udp_client;
+
+	memset(buf, 0, sizeof(buf));
+
+	/* recv() ensures TC ingress BPF has processed the skb */
+	ret = recv(udp_server, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
+		goto close_udp_client;
+
+	ASSERT_STREQ(buf, "test", "recv data");
+	ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
+
+close_udp_client:
+	close(udp_client);
+close_udp_server:
+	close(udp_server);
+close_tcp:
+	close(tcp_server);
+}
+
+void test_tcp_custom_syncookie_protocol_check(void)
+{
+	struct test_tcp_custom_syncookie *skel;
+	int i;
+
+	if (setup_netns())
+		return;
 
+	skel = test_tcp_custom_syncookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto)))
+		goto destroy_skel;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		if (!test__start_subtest(test_cases[i].name))
+			continue;
+
+		run_protocol_check(skel, test_cases[i].family,
+				   test_cases[i].addr);
+	}
+
+destroy_skel:
+	system("tc qdisc del dev lo clsact");
 	test_tcp_custom_syncookie__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index 7d5293de19523..5cf99d2a12aa5 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -588,4 +588,106 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
 	return tcp_handle_ack(&ctx);
 }
 
+/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb. */
+bool udp_intercepted;
+
+static int badproto_lookup_assign(struct __sk_buff *skb,
+				  struct bpf_sock_tuple *tuple, u32 tuple_size)
+{
+	struct bpf_tcp_req_attrs attrs = {};
+	struct bpf_sock *skc;
+	struct sock *sk;
+
+	skc = bpf_skc_lookup_tcp(skb, tuple, tuple_size, -1, 0);
+	if (!skc)
+		return TC_ACT_OK;
+
+	if (skc->state != TCP_LISTEN) {
+		bpf_sk_release(skc);
+		return TC_ACT_OK;
+	}
+
+	sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
+	if (!sk) {
+		bpf_sk_release(skc);
+		return TC_ACT_OK;
+	}
+
+	attrs.mss = 1460;
+	attrs.wscale_ok = 1;
+	attrs.snd_wscale = 7;
+	attrs.rcv_wscale = 7;
+	attrs.sack_ok = 1;
+
+	bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(attrs));
+
+	bpf_sk_release(skc);
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int tcp_custom_syncookie_badproto(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct bpf_sock_tuple tuple = {};
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
+	struct udphdr *udp;
+
+	eth = (struct ethhdr *)data;
+	if (eth + 1 > data_end)
+		return TC_ACT_OK;
+
+	switch (bpf_ntohs(eth->h_proto)) {
+	case ETH_P_IP:
+		iph = (struct iphdr *)(eth + 1);
+		if (iph + 1 > data_end)
+			return TC_ACT_OK;
+
+		if (iph->protocol != IPPROTO_UDP)
+			return TC_ACT_OK;
+
+		udp = (struct udphdr *)(iph + 1);
+		if (udp + 1 > data_end)
+			return TC_ACT_OK;
+
+		udp_intercepted = true;
+
+		tuple.ipv4.saddr = iph->saddr;
+		tuple.ipv4.daddr = iph->daddr;
+		tuple.ipv4.sport = udp->source;
+		tuple.ipv4.dport = udp->dest;
+
+		return badproto_lookup_assign(skb, &tuple,
+					      sizeof(tuple.ipv4));
+	case ETH_P_IPV6:
+		ip6h = (struct ipv6hdr *)(eth + 1);
+		if (ip6h + 1 > data_end)
+			return TC_ACT_OK;
+
+		if (ip6h->nexthdr != IPPROTO_UDP)
+			return TC_ACT_OK;
+
+		udp = (struct udphdr *)(ip6h + 1);
+		if (udp + 1 > data_end)
+			return TC_ACT_OK;
+
+		udp_intercepted = true;
+
+		__builtin_memcpy(tuple.ipv6.saddr, &ip6h->saddr,
+				 sizeof(tuple.ipv6.saddr));
+		__builtin_memcpy(tuple.ipv6.daddr, &ip6h->daddr,
+				 sizeof(tuple.ipv6.daddr));
+		tuple.ipv6.sport = udp->source;
+		tuple.ipv6.dport = udp->dest;
+
+		return badproto_lookup_assign(skb, &tuple,
+					      sizeof(tuple.ipv6));
+	default:
+		return TC_ACT_OK;
+	}
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


