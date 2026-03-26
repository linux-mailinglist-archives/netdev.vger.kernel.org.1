Return-Path: <netdev+bounces-271859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IdFNETTxGnk4AQAu9opvQ
	(envelope-from <netdev+bounces-271859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:33:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3213832FE3D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77CF30730B2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB13B3BF4;
	Thu, 26 Mar 2026 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ROL0o+Td"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2203B38BE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506459; cv=none; b=GK5mYrwmj+7KjLli13TKe5qokPODFwULeqJQn4NU1eOgAUgkz7z0hKiAwdsJgIWRlaWDEBo3NVz2p+uU3keKxjfQxmrwJbAj7w5EywGlFR5y5/ko2c++v+obeaT9pBSNzTDabtpGUuMQYjjuSUzWvnM1W96SllDbgefRxdoabOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506459; c=relaxed/simple;
	bh=29zamgTScbbg5vvuvvtNvA6s4drRxnMdyD/RkK4l7BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyuE6JPyteq8JkxXB5Jlou9CppEL+lVMu51X/FDHLaNH1zVv/rTc+afbCy6x1o4XKJXLmVe4zSVd0BrAB9zFfMECmToYr/tRgcFG9qwokEa5kAv0oY987mrLLTqHYxF+4/Q+lwe4tJ3pBF9SKB1tvwtTDoDdRU2z7p3HNY9BHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ROL0o+Td; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774506454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9M3Pk1nKD0tOE5JdHLR3DyEbI3+wrZAKNOKkx5NkEK0=;
	b=ROL0o+TdwMkUlRMbyt3+ck1m5f2b/8rXVxtKzzgaYiPa/kR7EWEZJSwcJ+8GiHlD2eyQdN
	OxIk54G+GGF1Wy78LBC28SYE30PZJC1HBg4w6UeV1g5KExgIdZdzJwSBKPY2hzips3+IIy
	jQhCsebZQkZmRBL9kHxC9hSnsIDaqVw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
Date: Thu, 26 Mar 2026 14:26:36 +0800
Message-ID: <20260326062657.88446-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260326062657.88446-1-jiayuan.chen@linux.dev>
References: <20260326062657.88446-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-271859-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ipv4.sport:url,linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 3213832FE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

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
  test_tcp_custom_syncookie_protocol_check:PASS:start tcp_server 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:start udp_server 0 nsec
  setup_tc:PASS:qdisc add dev lo clsact 0 nsec
  setup_tc:PASS:filter add dev lo ingress 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:udp socket 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:sendto udp 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:recv udp 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:udp_intercepted 0 nsec
  test_tcp_custom_syncookie_protocol_check:PASS:assign_ret 0 nsec
  #471     tcp_custom_syncookie_protocol_check:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 84 ++++++++++++++++++-
 .../bpf/progs/test_tcp_custom_syncookie.c     | 79 +++++++++++++++++
 2 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..c50b76f70988 100644
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
@@ -145,6 +145,82 @@ void test_tcp_custom_syncookie(void)
 
 destroy_skel:
 	system("tc qdisc del dev lo clsact");
+	test_tcp_custom_syncookie__destroy(skel);
+}
 
+/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
+ *
+ * Send a UDP packet through TC ingress where a BPF program calls
+ * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
+ * because the skb carries UDP, not TCP.
+ */
+void test_tcp_custom_syncookie_protocol_check(void)
+{
+	int tcp_server = -1, udp_server = -1, udp_client = -1;
+	struct test_tcp_custom_syncookie *skel;
+	struct sockaddr_in udp_addr;
+	char buf[32] = "test";
+	int udp_port, ret;
+
+	if (setup_netns())
+		return;
+
+	skel = test_tcp_custom_syncookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* Create a TCP listener so the BPF can find a LISTEN socket */
+	tcp_server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
+		goto destroy_skel;
+
+	/* Create a UDP server to receive the packet as synchronization */
+	udp_server = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
+		goto close_tcp;
+
+	skel->bss->tcp_listener_port = ntohs(get_socket_local_port(tcp_server));
+	udp_port = ntohs(get_socket_local_port(udp_server));
+	skel->bss->udp_test_port = udp_port;
+
+	ret = bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto);
+	if (setup_tc(ret))
+		goto close_udp_server;
+
+	udp_client = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
+		goto cleanup_tc;
+
+	memset(&udp_addr, 0, sizeof(udp_addr));
+	udp_addr.sin_family = AF_INET;
+	udp_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	udp_addr.sin_port = htons(udp_port);
+
+	ret = sendto(udp_client, buf, sizeof(buf), 0,
+		     (struct sockaddr *)&udp_addr, sizeof(udp_addr));
+	if (!ASSERT_EQ(ret, sizeof(buf), "sendto udp"))
+		goto cleanup_tc;
+
+	/* recv() ensures TC ingress BPF has processed the skb */
+	ret = recv(udp_server, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
+		goto cleanup_tc;
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
+close_udp_server:
+	close(udp_server);
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


