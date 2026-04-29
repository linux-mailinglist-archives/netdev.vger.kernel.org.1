Return-Path: <netdev+bounces-282530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAZnOMGG8mkDsQEAu9opvQ
	(envelope-from <netdev+bounces-282530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A447A49B10F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11DFF303B8E4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0144BCAC;
	Wed, 29 Apr 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPwGILz4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B694418E3;
	Wed, 29 Apr 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501806; cv=none; b=UsajA3lictjYViKU9iaQQ5mhInGj4gn8mGhIwnUnRCKnhoFzcC/Au64TIZcntgzzq59bsrDLxHU98nDLTayH+EY3qEApnsX05FeKUhpAKssET9F/aW30iux6YPcEBr2FIr3VET85/3T+TvsO9CgGzhyHTxNaf0SuiLpIcLFo7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501806; c=relaxed/simple;
	bh=KLo8GwQQAN017DwDhaIw9VW4z9RqVNldHinrlyKtg2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV1fM5NwDAyIzEaYNWetCUt2z5P5eQJ5C8GQ3LPkADOT/ZUI/bhkhENkhhbIT1U3NhaovCOByGSZvjah3wOGmnTWx317wtL57V2fhARLCKZ1E2MYqh+o34SehikaTH7dCB7Btkr9HlV4BwgRKspcAYVWb1kOR9SEq3EJPG+YunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPwGILz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F96DC19425;
	Wed, 29 Apr 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501806;
	bh=KLo8GwQQAN017DwDhaIw9VW4z9RqVNldHinrlyKtg2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPwGILz4aiMPP+PKxU73i1CA7Q7+y1euk2NrZ9sXPskDNjSRcpWDf7ziFnbCwMx6b
	 hKaiUvZ5Myponoo9cfZGoRLbt0SD7J/ba3mnZDpsJ6x+gh3To8HhwLqFJJkULPcUEE
	 h+u3TPPBOwRTKLHZ8ZDEefDm5wHLmQSEpZpDj/Lhrx5e41/+Cv2NYKABAb1jYXKjJ5
	 RfihHrrdINeCC8SxaaeKsRgU2EhOOQx9zMFyrwuzBjpAFShzCqM/8+vomAPsptrQg0
	 HOkQJ9fU7cH0xilvyWUHcRGJRpbMY1xlWdfHFo2yqLc6Mg26Z2rv3YLIn72mIreiPl
	 3yxb4HQVJwdJA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	isolodrai@meta.com
Subject: [PATCH net 5/7] selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path
Date: Wed, 29 Apr 2026 15:29:42 -0700
Message-ID: <20260429222944.2139041-6-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A447A49B10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net,iogearbox.net,linux.dev,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-282530-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add a regression test for the off-by-one in tls_push_record() where
the sg_chain() entry count was MAX_SKB_FRAGS instead of NR_MSG_FRAG_IDS,
causing the chain pointer to overwrite a live ring slot when an sk_msg
scatterlist ring wrapped (sg.end < sg.start).

The new "tls tx wrapped sg chain" subtest:
1. attaches an SK_MSG program (prog_sk_policy_drop) that drops the first
   N bytes of a message via bpf_msg_apply_bytes() + SK_DROP,
2. splices 17 single-byte frags through a kTLS TX socket so the ring
   fills to sg.start=16, sg.end=17,
3. removes the socket from the sockmap and sends one more byte, which
   wraps sg.end to 0 and exercises the wrap branch in tls_push_record().

Without the fix the kernel hangs on the wrapping send (the corrupted
chain pointer leaves the sg traversal stuck); with the fix the test
completes cleanly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: memxor@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: jolsa@kernel.org
CC: shuah@kernel.org
CC: john.fastabend@gmail.com
CC: jiayuan.chen@linux.dev
CC: isolodrai@meta.com
CC: bpf@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 83 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  8 ++
 2 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index b87e7f39e15a..8ab7f4cdc614 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -4,6 +4,7 @@
  * Tests for sockmap/sockhash holding kTLS sockets.
  */
 #include <error.h>
+#include <fcntl.h>
 #include <netinet/tcp.h>
 #include <linux/tls.h>
 #include "test_progs.h"
@@ -403,6 +404,86 @@ static void test_sockmap_ktls_tx_pop(int family, int sotype)
 	test_sockmap_ktls__destroy(skel);
 }
 
+static void test_sockmap_ktls_tx_wrapped_chain(int family, int sotype)
+{
+	int c = -1, p = -1, one = 1, prog_fd, map_fd;
+	int pipefd[2] = { -1, -1 };
+	struct test_sockmap_ktls *skel;
+	char byte;
+	ssize_t n;
+	int err, i;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy_drop);
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk msg"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &one, &c, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
+		goto out;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	/* packetized pipe so each splice frag becomes its own sg entry */
+	err = pipe2(pipefd, O_DIRECT);
+	if (!ASSERT_OK(err, "pipe2"))
+		goto out;
+	err = fcntl(pipefd[0], F_SETPIPE_SZ, 17 * 4096);
+	if (!ASSERT_GE(err, 17 * 4096, "F_SETPIPE_SZ"))
+		goto out;
+
+	for (i = 0; i < 17; i++) {
+		byte = 'A' + i;
+		if (!ASSERT_EQ(write(pipefd[1], &byte, 1), 1, "write to pipe"))
+			goto out;
+	}
+
+	/* drop the first 16 bytes so sg.start advances to 16 */
+	skel->bss->apply_bytes = 16;
+
+	n = splice(pipefd[0], NULL, c, NULL, 17, 0);
+	if (n < 0)
+		ASSERT_EQ(errno, EACCES, "splice errno");
+
+	err = bpf_map_delete_elem(map_fd, &one);
+	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
+		goto out;
+	usleep(50000);
+
+	while (recv(p, &byte, 1, MSG_DONTWAIT) > 0)
+		;
+
+	/* this send wraps sg.end to 0 and trips the wrap branch */
+	byte = 'X';
+	n = send(c, &byte, 1, MSG_DONTWAIT);
+	if (n < 0)
+		ASSERT_TRUE(errno == EAGAIN || errno == EACCES || errno == EPIPE,
+			    "send errno");
+
+out:
+	if (pipefd[0] != -1)
+		close(pipefd[0]);
+	if (pipefd[1] != -1)
+		close(pipefd[1]);
+	if (c != -1)
+		close(c);
+	if (p != -1)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_tests(int family, enum bpf_map_type map_type)
 {
 	int map;
@@ -429,6 +510,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_no_buf(family, sotype, true);
 	if (test__start_subtest("tls tx with pop"))
 		test_sockmap_ktls_tx_pop(family, sotype);
+	if (test__start_subtest("tls tx wrapped sg chain"))
+		test_sockmap_ktls_tx_wrapped_chain(family, sotype);
 }
 
 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
index 83df4919c224..18de4d7cd816 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -38,3 +38,11 @@ int prog_sk_policy_redir(struct sk_msg_md *msg)
 	bpf_msg_apply_bytes(msg, apply_bytes);
 	return bpf_msg_redirect_map(msg, &sock_map, two, 0);
 }
+
+SEC("sk_msg")
+int prog_sk_policy_drop(struct sk_msg_md *msg)
+{
+	if (apply_bytes > 0)
+		bpf_msg_apply_bytes(msg, apply_bytes);
+	return SK_DROP;
+}
-- 
2.54.0


