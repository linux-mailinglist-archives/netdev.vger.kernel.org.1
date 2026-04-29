Return-Path: <netdev+bounces-282532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLu/A8WG8mkDsQEAu9opvQ
	(envelope-from <netdev+bounces-282532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD749B11A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 714F0301FF4A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7507C44CF34;
	Wed, 29 Apr 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA2LCDgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C68426D11;
	Wed, 29 Apr 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501808; cv=none; b=lFkT8GGfZzTDHpmO8tS6yA1WQh2m1HBMv5ZYLrbxV9XCAC+H1TxBJSMMo/yR5OnvdQyZSdSgtc6ue5KzEF+QZfAeslEeYPsT0xlsZyvYqnRDEcpFEJzYjclyI+Fruxlw6wEwcd5SLVLq5mm2gs43/SeKZg/drd4dTcWF5X6BhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501808; c=relaxed/simple;
	bh=MmHDsAMZYMXgY8MGklEdTKgGz7VWFYW7BvgJ0ItBfcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir0jVmu3Iet9X3E9M6nCien0/QhIDfup0hfLDINxtsgWaUTuMHW9w15MX4XRkMyDLcx3RaK1kLEjjrJtOUPW/3wZTAeZBT31+EEXknaqgopcscSR4U60K2g+Q/F8JrnO8LSZohWOg76GiOb53/DfVtxcr/hsSyB/M9ODvBYuMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA2LCDgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1665DC2BCF5;
	Wed, 29 Apr 2026 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501808;
	bh=MmHDsAMZYMXgY8MGklEdTKgGz7VWFYW7BvgJ0ItBfcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA2LCDgzA5g32u3eeH+S5ZnxhnhbX5UWC9jYDwWoYU+EbnwY6stHvYjaqPUTLT64/
	 CEBbA2I8nkCHGF15aD8z69ye6m1RQKODlMLfsu8ugY2RwHCyisJPEAEenpjaSCxO8v
	 INZ0PP16De25iyKdUXKq/RO4rr68ifFOXGIJ+heFuAPz6sRneRx76CUzDyewCb1H8F
	 +o5Ogi6qLEuoM6xCm3vUazQwxBykZSnx2ajtfgKdlaptcpwe7oPR4UZ0xST4JF5gwx
	 ZFhVkAOxuGsCkavJjBV3L33wBwGEu6i2AdOZYGVmKXvXCVHKuhtRRjh0xiXHrHvV45
	 jNiG7HVUImWjA==
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
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	isolodrai@meta.com
Subject: [PATCH net 7/7] selftests: bpf: cover tls_sw_sendmsg UAF after bpf_exec_tx_verdict split
Date: Wed, 29 Apr 2026 15:29:44 -0700
Message-ID: <20260429222944.2139041-8-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 4BDD749B11A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net,iogearbox.net,linux.dev,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-282532-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add a regression test for the use-after-free in tls_sw_sendmsg_locked()
where the cached msg_pl pointer becomes stale after bpf_exec_tx_verdict()
returns -ENOSPC: tls_push_record() may have called
tls_split_open_record() which replaces ctx->open_rec and frees the old
record, but the caller still dereferences msg_pl->cork_bytes.

Reusing prog_sk_policy with apply_bytes=1000 + cork_bytes=800, a single
1500-byte send on a kTLS TX socket in a sockmap drives the split-and-free
path. Without the fix, KASAN reports slab-use-after-free in tls_sw_sendmsg
and the kernel hangs; with the fix the test completes cleanly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrii@kernel.org
CC: eddyz87@gmail.com
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: martin.lau@linux.dev
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
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 56 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  2 +
 2 files changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 8ab7f4cdc614..d0bc8d39893a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -404,6 +404,60 @@ static void test_sockmap_ktls_tx_pop(int family, int sotype)
 	test_sockmap_ktls__destroy(skel);
 }
 
+static void test_sockmap_ktls_tx_apply_cork_uaf(int family, int sotype)
+{
+	int c = -1, p = -1, one = 1, prog_fd, map_fd;
+	struct test_sockmap_ktls *skel;
+	char buf[1500];
+	ssize_t n;
+	int err;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open ktls skel"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair()"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_sk_policy);
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
+	/* apply_bytes < send drives tls_split_open_record(); cork_bytes >
+	 * remaining returns -ENOSPC after the split frees the old rec
+	 */
+	skel->bss->apply_bytes = 1000;
+	skel->bss->cork_byte = 800;
+
+	err = init_ktls_pairs(c, p);
+	if (!ASSERT_OK(err, "init_ktls_pairs(c, p)"))
+		goto out;
+
+	memset(buf, 'A', sizeof(buf));
+	n = send(c, buf, sizeof(buf), MSG_DONTWAIT);
+	if (n < 0)
+		ASSERT_TRUE(errno == ENOSPC || errno == EAGAIN, "send errno");
+
+	n = send(c, buf, sizeof(buf), MSG_DONTWAIT);
+	if (n < 0)
+		ASSERT_TRUE(errno == ENOSPC || errno == EAGAIN, "send errno");
+
+out:
+	if (c != -1)
+		close(c);
+	if (p != -1)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void test_sockmap_ktls_tx_wrapped_chain(int family, int sotype)
 {
 	int c = -1, p = -1, one = 1, prog_fd, map_fd;
@@ -512,6 +566,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_pop(family, sotype);
 	if (test__start_subtest("tls tx wrapped sg chain"))
 		test_sockmap_ktls_tx_wrapped_chain(family, sotype);
+	if (test__start_subtest("tls tx apply cork uaf"))
+		test_sockmap_ktls_tx_apply_cork_uaf(family, sotype);
 }
 
 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
index 18de4d7cd816..b34f0c0f9f83 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -20,6 +20,8 @@ struct {
 SEC("sk_msg")
 int prog_sk_policy(struct sk_msg_md *msg)
 {
+	if (apply_bytes > 0)
+		bpf_msg_apply_bytes(msg, apply_bytes);
 	if (cork_byte > 0)
 		bpf_msg_cork_bytes(msg, cork_byte);
 	if (push_start > 0 && push_end > 0)
-- 
2.54.0


