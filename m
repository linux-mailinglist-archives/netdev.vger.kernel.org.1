Return-Path: <netdev+bounces-262046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCreIc9QommF1wQAu9opvQ
	(envelope-from <netdev+bounces-262046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:19:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E11BFF11
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FAF3303606B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4532549E;
	Sat, 28 Feb 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gPTcvF7P"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07B30B53C
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772245186; cv=none; b=bAPG3tpVgeBs5tCcZ04y0JEB3tF69HN+NRti4SjhS9ldP7p3ocdsWe9dikJeKVWZiMYtIZk3J97lE4/pWLNK6EGZgsarOpPlfPIDzi0+IOxgV04pnZEu0H7mJ9E1wXKXAk/QpnE4mHVhiT13wMwqISCptmaheoslKdZUtU11mzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772245186; c=relaxed/simple;
	bh=/nWFWGm1LWFw2+LWBT5eLedzo5nO+2W6C3bxSAB4nQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ikyq2zO+qAVxz8xBXMzap0aJ9Z0arLO2XXcw1mP5ODQ5U+WTIXVI+G5+wR71fHz5736DIsEwIGi0zXY794p3yXIcL2zPWbtusDjkzzyVqfBqZNJrCvPfvCN4sBqkonuR2xkaaYzN4GzXfU0lwUw/Fsj2fGR9QWTF5SneSmUeeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gPTcvF7P; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772245182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OozEdu1pfaLvelgpBknkr6XecjF2fZSlQnkaPUUUzxY=;
	b=gPTcvF7PqGfSDep85HS019H82oiinx04yI1WgAQ2IWIyMgQzofa5aguCaWOFUKUD4rbqSI
	O1h5vvcMpFEBwKirJg5zTlRtyZrPdIlGPI2Yq2a6ejw2GHH7f3RVpa3xUFKukB+1clFcnH
	gLxrV8TaQzd6Z1okhSQi6AbN1vj7d+Q=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
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
Subject: [PATCH net v3 2/2] selftests/bpf: add test for xdp_master_redirect with bond not up
Date: Sat, 28 Feb 2026 10:19:14 +0800
Message-ID: <20260228021918.141002-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260228021918.141002-1-jiayuan.chen@linux.dev>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-262046-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE5E11BFF11
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a selftest that reproduces the null-ptr-deref in
bond_rr_gen_slave_id() when XDP redirect targets a bond device in
round-robin mode that was never brought up. The test verifies the fix
by ensuring no crash occurs.

Test setup:
- bond0: active-backup mode, UP, with native XDP (enables
  bpf_master_redirect_enabled_key globally)
- bond1: round-robin mode, never UP
- veth1: slave of bond1, with generic XDP (XDP_TX)
- BPF_PROG_TEST_RUN with live frames triggers the redirect path

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index fb952703653e..a5b15e464018 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -191,13 +191,18 @@ static int bonding_setup(struct skeletons *skeletons, int mode, int xmit_policy,
 	return -1;
 }
 
-static void bonding_cleanup(struct skeletons *skeletons)
+static void link_cleanup(struct skeletons *skeletons)
 {
-	restore_root_netns();
 	while (skeletons->nlinks) {
 		skeletons->nlinks--;
 		bpf_link__destroy(skeletons->links[skeletons->nlinks]);
 	}
+}
+
+static void bonding_cleanup(struct skeletons *skeletons)
+{
+	restore_root_netns();
+	link_cleanup(skeletons);
 	ASSERT_OK(system("ip link delete bond1"), "delete bond1");
 	ASSERT_OK(system("ip link delete veth1_1"), "delete veth1_1");
 	ASSERT_OK(system("ip link delete veth1_2"), "delete veth1_2");
@@ -493,6 +498,95 @@ static void test_xdp_bonding_nested(struct skeletons *skeletons)
 	system("ip link del bond_nest2");
 }
 
+/*
+ * Test that XDP redirect via xdp_master_redirect() does not crash when
+ * the bond master device is not up. When bond is in round-robin mode but
+ * never opened, rr_tx_counter is NULL.
+ */
+static void test_xdp_bonding_redirect_no_up(struct skeletons *skeletons)
+{
+	struct nstoken *nstoken = NULL;
+	int xdp_pass_fd, xdp_tx_fd;
+	int veth1_ifindex;
+	int err;
+	char pkt[ETH_HLEN + 1];
+	struct xdp_md ctx_in = {};
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &pkt,
+			    .data_size_in = sizeof(pkt),
+			    .ctx_in = &ctx_in,
+			    .ctx_size_in = sizeof(ctx_in),
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = 1,
+			    .batch_size = 1,
+		);
+
+	/* We can't use bonding_setup() because bond will be active */
+	SYS(out, "ip netns add ns_rr_no_up");
+	nstoken = open_netns("ns_rr_no_up");
+	if (!ASSERT_OK_PTR(nstoken, "open ns_rr_no_up"))
+		goto out;
+
+	/* bond0: active-backup, UP with slave veth0.
+	 * Attaching native XDP to bond0 enables bpf_master_redirect_enabled_key
+	 * globally.
+	 */
+	SYS(out, "ip link add bond0 type bond mode active-backup");
+	SYS(out, "ip link add veth0 type veth peer name veth0p");
+	SYS(out, "ip link set veth0 master bond0");
+	SYS(out, "ip link set bond0 up");
+	SYS(out, "ip link set veth0p up");
+
+	/* bond1: round-robin, never UP -> rr_tx_counter stays NULL */
+	SYS(out, "ip link add bond1 type bond mode balance-rr");
+	SYS(out, "ip link add veth1 type veth peer name veth1p");
+	SYS(out, "ip link set veth1 master bond1");
+
+	veth1_ifindex = if_nametoindex("veth1");
+	if (!ASSERT_GT(veth1_ifindex, 0, "veth1_ifindex"))
+		goto out;
+
+	/* Attach native XDP to bond0 -> enables global redirect key */
+	if (xdp_attach(skeletons, skeletons->xdp_tx->progs.xdp_tx, "bond0"))
+		goto out;
+
+	/* Attach generic XDP (XDP_TX) to veth1.
+	 * When packets arrive at veth1 via netif_receive_skb, do_xdp_generic()
+	 * runs this program. XDP_TX + bond slave triggers xdp_master_redirect().
+	 */
+	xdp_tx_fd = bpf_program__fd(skeletons->xdp_tx->progs.xdp_tx);
+	if (!ASSERT_GE(xdp_tx_fd, 0, "xdp_tx prog_fd"))
+		goto out;
+
+	err = bpf_xdp_attach(veth1_ifindex, xdp_tx_fd,
+			     XDP_FLAGS_SKB_MODE, NULL);
+	if (!ASSERT_OK(err, "attach generic XDP to veth1"))
+		goto out;
+
+	/* Run BPF_PROG_TEST_RUN with XDP_PASS live frames on veth1.
+	 * XDP_PASS frames become SKBs with skb->dev = veth1, entering
+	 * netif_receive_skb -> do_xdp_generic -> xdp_master_redirect.
+	 * Without the fix, bond_rr_gen_slave_id() dereferences NULL
+	 * rr_tx_counter and crashes.
+	 */
+	xdp_pass_fd = bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
+	if (!ASSERT_GE(xdp_pass_fd, 0, "xdp_pass prog_fd"))
+		goto out;
+
+	memset(pkt, 0, sizeof(pkt));
+	ctx_in.data_end = sizeof(pkt);
+	ctx_in.ingress_ifindex = veth1_ifindex;
+
+	err = bpf_prog_test_run_opts(xdp_pass_fd, &opts);
+	ASSERT_OK(err, "xdp_pass test_run should not crash");
+
+out:
+	link_cleanup(skeletons);
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del ns_rr_no_up");
+}
+
 static void test_xdp_bonding_features(struct skeletons *skeletons)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, query_opts);
@@ -680,6 +774,9 @@ void serial_test_xdp_bonding(void)
 	if (test__start_subtest("xdp_bonding_redirect_multi"))
 		test_xdp_bonding_redirect_multi(&skeletons);
 
+	if (test__start_subtest("xdp_bonding_redirect_no_up"))
+		test_xdp_bonding_redirect_no_up(&skeletons);
+
 out:
 	xdp_dummy__destroy(skeletons.xdp_dummy);
 	xdp_tx__destroy(skeletons.xdp_tx);
-- 
2.43.0


