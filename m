Return-Path: <netdev+bounces-270477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLelI6UewWmTQwQAu9opvQ
	(envelope-from <netdev+bounces-270477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:06:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E70E12F0D13
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A431304046C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546D391E70;
	Mon, 23 Mar 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ehtOKZ3e"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618D3914E0;
	Mon, 23 Mar 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263366; cv=none; b=F0ZIkkoBEpeOpRphM5Y/satNAQsjTGSpBNK2JEIAdDmzlL5QcRPC/kbl7ufWwgrgtcR2jdbWKA7/c7IMp2ItiZrAXpml1emtxrd2eezD+Z1sFbXUHPuLR0/OzLdC7owsp52DCFrQw0MEUi4IwRlT53z3wQ0Uw6TbQL3Tnwe8G0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263366; c=relaxed/simple;
	bh=wYod2bsCx5XUAR8HjcZO0gY0sArDllNyLKMEev8bpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3zGuKkIKC18eHmlEU1dMPVRlwO2KBoUPzc3cUqqRAKSK8qsqx3sTZxf1spPsrTuV5aklQydygd3zflNHDsOXcBAyvdUyJI0IC62IsBRbtCk9lkqniSnLiS++cOD+tVczpJ1ojwbXb/lWdaeJhId22pwaIjWpq0m6d8vDeymQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ehtOKZ3e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774263362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGEQT91QO2Vr6HyhTsMYXno0TG9SvzxdFJGArBdL6wE=;
	b=ehtOKZ3ePc9JIUtNdvUNcr5fhe/qrNJFGwnfck/1+GVLByY/vRMwU4DTwll4pt3UuSFra5
	VNeOpV1lq3t4qGdmjfDq2LowgLskaSB7NUV6NgqKyOF7JJIfFLT5kmZV/ozhRdHfdpgJQh
	wvzrEILOINhGSCy/xZsSSJ3UHklXioQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
Date: Mon, 23 Mar 2026 18:54:50 +0800
Message-ID: <20260323105510.51990-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260323105510.51990-1-jiayuan.chen@linux.dev>
References: <20260323105510.51990-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-270477-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ipv4.sport:url]
X-Rspamd-Queue-Id: E70E12F0D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add test_tcp_custom_syncookie_protocol_check to verify that
bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
packet through a BPF program that calls bpf_sk_assign_tcp_reqsk() on it
and checks that the kfunc returns an error.

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
  test_tcp_custom_syncookie_protocol_check:PASS:start tcp_server 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:getsockname 0 nsec
  setup_tc:PASS:qdisc add dev lo clsact 0 nsec
  setup_tc:PASS:filter add dev lo ingress 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:udp socket 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:sendto udp 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:udp_intercepted 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:assign_ret 0 nsec
  #471     tcp_custom_syncookie_protocol_check:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 81 ++++++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 79 ++++++++++++++++++
 2 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..e622c5befa70 100644
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
@@ -145,6 +145,79 @@ void test_tcp_custom_syncookie(void)
 
 destroy_skel:
 	system("tc qdisc del dev lo clsact");
+	test_tcp_custom_syncookie__destroy(skel);
+}
+
+/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
+ *
+ * Send a UDP packet through a BPF program that calls
+ * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return -EINVAL
+ * because the skb carries UDP, not TCP.
+ *
+ * Currently the kfunc lacks L4 protocol check, so assign_ret == 0
+ * indicates the bug is present.
+ */
+void test_tcp_custom_syncookie_protocol_check(void)
+{
+	struct test_tcp_custom_syncookie *skel;
+	struct sockaddr_in tcp_addr, udp_addr;
+	socklen_t addr_len = sizeof(tcp_addr);
+	int tcp_server = -1, udp_client = -1;
+	char buf[32] = "test";
+	int ret;
+
+	if (setup_netns())
+		return;
+
+	skel = test_tcp_custom_syncookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
 
+	/* Create a TCP listener so the BPF can find a LISTEN socket */
+	tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
+		goto destroy_skel;
+
+	ret = getsockname(tcp_server, (struct sockaddr *)&tcp_addr, &addr_len);
+	if (!ASSERT_OK(ret, "getsockname"))
+		goto close_tcp;
+
+	skel->bss->tcp_listener_port = ntohs(tcp_addr.sin_port);
+	skel->bss->udp_test_port = 9999;
+
+	ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
+	if (setup_tc(ret))
+		goto close_tcp;
+
+	udp_client = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
+		goto cleanup_tc;
+
+	memset(&udp_addr, 0, sizeof(udp_addr));
+	udp_addr.sin_family = AF_INET;
+	udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	udp_addr.sin_port = htons(9999);
+
+	ret = sendto(udp_client, buf, sizeof(buf), 0,
+		     (struct sockaddr *)&udp_addr, sizeof(udp_addr));
+	ASSERT_EQ(ret, sizeof(buf), "sendto udp");
+
+	/* Wait for TC ingress BPF to process the skb. */
+	kern_sync_rcu();
+
+	ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
+
+	/* assign_ret == 0 means kfunc accepted UDP skb (bug).
+	 * assign_ret < 0 means kfunc correctly rejected it (fixed).
+	 */
+	ASSERT_NEQ(skel->data->assign_ret, 0, "assign_ret");
+
+cleanup_tc:
+	system("tc qdisc del dev lo clsact");
+	if (udp_client >= 0)
+		close(udp_client);
+close_tcp:
+	close(tcp_server);
+destroy_skel:
 	test_tcp_custom_syncookie__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index 7d5293de1952..386705b6c9f2 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -588,4 +588,83 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
 	return tcp_handle_ack(&ctx);
 }
 
+/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb.
+ * The kfunc should reject it, but currently it doesn't check L4 protocol.
+ */
+__u16 tcp_listener_port = 0;
+__u16 udp_test_port = 0;
+int assign_ret = -1;
+bool udp_intercepted = false;
+
+SEC("tc")
+int tcp_custom_syncookie_badproto(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct bpf_sock_tuple tuple = {};
+	struct bpf_tcp_req_attrs attrs = {};
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct udphdr *udp;
+	struct bpf_sock *skc;
+	struct sock *sk;
+
+	eth = (struct ethhdr *)data;
+	if (eth + 1 > data_end)
+		return TC_ACT_OK;
+
+	if (bpf_ntohs(eth->h_proto) != ETH_P_IP)
+		return TC_ACT_OK;
+
+	iph = (struct iphdr *)(eth + 1);
+	if (iph + 1 > data_end)
+		return TC_ACT_OK;
+
+	if (iph->protocol != IPPROTO_UDP)
+		return TC_ACT_OK;
+
+	udp = (struct udphdr *)(iph + 1);
+	if (udp + 1 > data_end)
+		return TC_ACT_OK;
+
+	if (bpf_ntohs(udp->dest) != udp_test_port)
+		return TC_ACT_OK;
+
+	udp_intercepted = true;
+
+	tuple.ipv4.saddr = iph->saddr;
+	tuple.ipv4.daddr = iph->daddr;
+	tuple.ipv4.sport = udp->source;
+	tuple.ipv4.dport = bpf_htons(tcp_listener_port);
+
+	skc = bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0);
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
+	/* Call bpf_sk_assign_tcp_reqsk on a UDP skb. */
+	assign_ret = bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(attrs));
+
+	bpf_sk_release(skc);
+
+	/* Let the packet continue into the kernel */
+	return TC_ACT_OK;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


