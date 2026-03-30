Return-Path: <netdev+bounces-273095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFf9Je4vymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:10:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C359356EAB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF8EB30106B3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DB3ACF09;
	Mon, 30 Mar 2026 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pHIGHnzI"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407E3ACA72
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858107; cv=none; b=Hg9itMUBi0zCvIQ/RFVebEZwyI+M8gpun0DRXVCq8NXWa3yKf8D5VA+MKtjyN2nDeOWOrNWPdUkt81xng5LbSc2HqzKPt2b87FA+QnetPfZMzNbijBHwJL+aVATVUQ0s37FFe6+yYw7sHRqsb4cfoKF1kul/f307NAPpxnErU9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858107; c=relaxed/simple;
	bh=iEUY+9gWrFjCtPRfzgVXMQXVeRXlkW/T9DnKRXBgG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZAPHTUUnSO7z4hjYMPEKDxL7wQ7YfY0NrvOjy7eDcLGWY2ZEelKqdWXYUk8CHJSDJVLg2e7GQnxofwO3YQTDd3dP/p+krL4/A0LSZSgt03I13wORtzpYXJKyaNtD9/GfY77nWkJMBQQmjfjbT9kwGG72L7a2LZSfPimmuhQALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pHIGHnzI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774858104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLKWQBCloH5Wb28Pxxsg/3g0WCGImQfPe+MsKG52h4o=;
	b=pHIGHnzIOmsHdlZR/KXb+xmiMdZXmItx2ZO14m6BTEr3f1PIZacMfJf4y1xA0YC7LXvOlo
	lakclR+tdDz+s5ZBe0jmybb8LipZlv5yPL7awoAOxwxHtbYNOEpRETKw9chn6l0XcyKqQK
	JCBAFsEM3l1MHnQgheTMZLSLZ3HXgWo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
Date: Mon, 30 Mar 2026 16:07:26 +0800
Message-ID: <20260330080746.319680-3-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-273095-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ipv4.sport:url,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 9C359356EAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add test_tcp_custom_syncookie_protocol_check to verify that
bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
packet through TC ingress where a BPF program calls
bpf_sk_assign_tcp_reqsk() on it and checks that the kfunc returns an
error. A UDP server recv() is used as synchronization to ensure the
BPF program has finished processing before checking the result.

Without the fix in bpf_sk_assign_tcp_reqsk(), the kfunc succeeds and
attaches a TCP reqsk to the UDP skb, which causes a null pointer
dereference panic when the kernel processes it through the UDP receive
path.

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
  run_protocol_check:PASS:udp_intercepted 0 nsec
  run_protocol_check:PASS:assign_ret 0 nsec
  #471/1   tcp_custom_syncookie_protocol_check/IPv4 TCP:OK
  run_protocol_check:PASS:start tcp_server 0 nsec
  run_protocol_check:PASS:start udp_server 0 nsec
  run_protocol_check:PASS:connect udp_client 0 nsec
  run_protocol_check:PASS:send udp 0 nsec
  run_protocol_check:PASS:recv udp 0 nsec
  run_protocol_check:PASS:udp_intercepted 0 nsec
  run_protocol_check:PASS:assign_ret 0 nsec
  #471/2   tcp_custom_syncookie_protocol_check/IPv6 TCP:OK
  #471     tcp_custom_syncookie_protocol_check:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  91 ++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 109 ++++++++++++++++++
 2 files changed, 196 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..6e29402c4c59 100644
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
@@ -127,7 +127,7 @@ void test_tcp_custom_syncookie(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		return;
 
-	if (setup_tc(skel))
+	if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
 		goto destroy_skel;
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
@@ -145,6 +145,89 @@ void test_tcp_custom_syncookie(void)
 
 destroy_skel:
 	system("tc qdisc del dev lo clsact");
+	test_tcp_custom_syncookie__destroy(skel);
+}
+
+/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
+ *
+ * Send a UDP packet through TC ingress where a BPF program calls
+ * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
+ * because the skb carries UDP, not TCP.
+ *
+ * TCP and UDP servers share the same port. The BPF program intercepts
+ * the UDP packet, looks up the TCP listener via the dest port, and
+ * attempts to assign a TCP reqsk to the UDP skb.
+ */
+static void run_protocol_check(struct test_tcp_custom_syncookie *skel,
+			       int family, const char *addr)
+{
+	int tcp_server = -1, udp_server = -1, udp_client = -1;
+	char buf[32] = "test";
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
+	skel->bss->assign_ret = 0;
+
+	udp_client = connect_to_fd(udp_server, 0);
+	if (!ASSERT_NEQ(udp_client, -1, "connect udp_client"))
+		goto close_udp_server;
 
+	ret = send(udp_client, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, sizeof(buf), "send udp"))
+		goto close_udp_client;
+
+	/* recv() ensures TC ingress BPF has processed the skb */
+	ret = recv(udp_server, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
+		goto close_udp_client;
+
+	ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
+
+	ASSERT_EQ(skel->bss->assign_ret, -EINVAL, "assign_ret");
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
+
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
index 7d5293de1952..bd3fad3dd503 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -588,4 +588,113 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
 	return tcp_handle_ack(&ctx);
 }
 
+/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb.
+ * The kfunc should reject it because the skb is not TCP.
+ *
+ * TCP and UDP servers share the same port. The BPF program intercepts
+ * UDP packets, looks up the TCP listener on the same port, and tries
+ * to assign a TCP reqsk to the UDP skb.
+ */
+int assign_ret = 0;
+bool udp_intercepted = false;
+
+static int badproto_lookup_assign(struct __sk_buff *skb, struct udphdr *udp,
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
+	assign_ret = bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(attrs));
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
+		return badproto_lookup_assign(skb, udp, &tuple,
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
+		return badproto_lookup_assign(skb, udp, &tuple,
+					      sizeof(tuple.ipv6));
+	default:
+		return TC_ACT_OK;
+	}
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


