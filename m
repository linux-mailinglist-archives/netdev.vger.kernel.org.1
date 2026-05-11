Return-Path: <netdev+bounces-286642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENQ5CnjPAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EDA50E1F6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE64B300D4E5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A539BFFA;
	Mon, 11 May 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btTHTDQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D6390CA1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503317; cv=none; b=bsDx2C+h7vPnbQZRDhj9VSYNplb7lQ4LMhVQxJ2jwNgqJE0N2UJuLn5zn2zQwpdONE7/G6R61YQlwRW/WPVaq1rn301iPugDwXlp3CAJiw7aRPr6FEgZ0PcZpSg9dQ3AlFgvh/DuP1IVVePJfgnM0tcpiFHFrIuqTKgZVT2XXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503317; c=relaxed/simple;
	bh=mpnlRIp84AtLTYYBNSGEUDcNhnUmPndvkI8ESEoKZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qa+2M0+xqfXwcx9m5tj+1NoaNOSlm3VgzYKcjo3el++uem67ktZKCllN/x1LH36mdewyt5m/sAHrfZcqcgNudZT0SdDQJBj9vxgAtswI232pdFbRLHGolC6njUyd638RGz8xhXxJhL4IeYxpr3XrP5xBRO+GjVuJOHLHZtA+2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btTHTDQi; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-83d31ac4017so1319817b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503316; x=1779108116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISZM7kzCd3i7an1IFyaHbOB6qikrwE1/Zcric7h+vGw=;
        b=btTHTDQipDW4Ll5QDeWH3Qd67gV2MJGqKzVn+hIylzkQitmZKS9sLYZ8GgNkRa3JTu
         GtP8vuxzKox3mKDk0YAX0MxWIm7Oha5nNKKxpEh4hAQg+6Y1L5H1pTbvLTCMbCt+DpMA
         APbU8dxU4mPLrPNn/ejc38vzAmoqzcl3eLVfqBGYmpNLd9lEOz0BmVvRuRFyM3QbSCRi
         SymEYnKYAHSkARMJn71D5c6wvZDJUTszCNQh4ZjvzMi0LAaLUls2I43wIVG4W7n6THOl
         rFFsrtBrG3N75TSxgn5DtqCX+akD76t5T7zCo69IBPb11xvGZm5695KXw61dMmo+27Sz
         1J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503316; x=1779108116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISZM7kzCd3i7an1IFyaHbOB6qikrwE1/Zcric7h+vGw=;
        b=TXE9KSU4kKsl8rl53qERgvKmBxbhhWtli+k3LVGWvFPHQ9SNJFt7ZBPde3yK02VuHD
         ejgWrGQsFe6Vzknefci9VOjz30EK7zKE85BH9ir9zWuDbVENskv6nGfkLD7TgjVq4/zs
         JCKKIVcS+D+wq0EA3xVqTteUmQ1GxRbY1/rYwyhUmF/w3v6saqfSMA/035AvOCty/BNZ
         u3AQu8zbpi6X4RnMwKwzFRtKubqHrgyZc84R8nnOXJ/UlqSYlFFjHnBKOVh+BKdzCDGO
         VT1XQI05dYT9wj5l9a6Vl3m+mOub7udhGW4wicMkgeimcb3LrZd0zEZkOjPctiBACMjz
         xsCg==
X-Forwarded-Encrypted: i=1; AFNElJ+oq4cjl/FMZylvbVlU1OrWqpnBmdiZYpgSv/Ue+EvBANwaVEZPq5Au0VioSTPcQGZsBJclo8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUME/O9wZ+cLUDSYDCrcmJzoqwDQPH+i2QPfcbQG+BMWz/AtOh
	o2Cr0zSLW3MHbdM7IazhfHK319vG1HgYPBZ3wdrEG3QstIbSXUmKSOc8
X-Gm-Gg: Acq92OHp4DhahNr7Dg+++ITxDNfXpVB7mEJrZjiJEJfRqRa5+84p0r3IAsECwGUMGw7
	ATgT+qWKzHgae8Z/i5AWm47FRIJ8hTenK2QKxQqzcoKyMhU6CNYMVeCYRInERR7Qc6szVcZM5rc
	rFEH+wZGHHdBRfTmsk7BlNP2TL6abLCKLb6zC3bSWBpauy9Rqf/vWFUo/UECjV/pKYsnRgL4AZP
	oLjhHtU0IRMtttJJ0hsu2NKY8ZYrpl31O0CO/rPnt6Ze41YdXnuEmUo0bipjSuYn5l08sKwQl8A
	ERde8IRPwBPSXLRagEjDZbDIkLXU8slLgTq9pNyBPyXZTJYKZdzfbfwHAsPRafMhUpfdTSNa0zk
	GxVsWKLdci64zKTMd+R4BmjbV3MxLFxGteLVrRLOsHAGcBhoNiNyE4BBae64Eg1zdtbQD2vqZYm
	oeiJfsP2vYm9wGKyk3j50M9kQwIRrsfDP8AvM=
X-Received: by 2002:aa7:88d6:0:b0:835:3f51:730e with SMTP id d2e1a72fcca58-83a5b8d9aa3mr21768467b3a.13.1778503315547;
        Mon, 11 May 2026 05:41:55 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm24961380b3a.46.2026.05.11.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:41:55 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com
Cc: kuba@kernel.org,
	jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mrpre@163.com,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v3] selftests: bpf: add test for KTLS+sockmap reverse-order UAF
Date: Mon, 11 May 2026 21:41:48 +0900
Message-ID: <20260511124149.14834-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30EDA50E1F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-286642-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a selftest that reproduces the use-after-free triggered when a TCP
socket is inserted into a sockmap *before* TLS RX is configured on it
(the reverse of the order that is already blocked by the kernel).

Vulnerable sequence:

  1. bpf_map_update_elem(sockmap, server_fd)
     -> sk->sk_data_ready = sk_psock_verdict_data_ready

  2. setsockopt(server_fd, SOL_TLS, TLS_RX, ...)
     -> tls_sw_strparser_arm() saves sk_psock_verdict_data_ready as
        rx_ctx->saved_data_ready, then sets
        sk->sk_data_ready = tls_data_ready

When data arrives:
  tls_data_ready -> tls_strp_data_ready -> tls_rx_msg_ready ->
  saved_data_ready() [= sk_psock_verdict_data_ready] ->
  tcp_read_skb() drains sk_receive_queue via __skb_unlink() without
  calling tcp_eat_skb(), so copied_seq is never advanced.

  tls_strp_msg_load() then finds tcp_inq() >= full_len (stale), calls
  tcp_recv_skb() on an empty queue, hits WARN_ON_ONCE(!first), and
  returns with frag_list still pointing at the now psock-owned (or
  already freed) skb.  tls_decrypt_sg() subsequently walks that stale
  frag_list: a use-after-free.

The new BPF program (prog_skb_verdict_pass, sk_skb/verdict) returns
SK_PASS, which is the specific verdict that triggers the missing
tcp_eat_skb() call inside sk_psock_verdict_recv().

The test drives the full setup in the vulnerable order and then
attempts a send+recv.  After a correct fix the kernel either:

  (a) rejects setsockopt(TLS_RX) with EBUSY/EINVAL when the socket is
      already owned by a psock, or
  (b) completes the data transfer without corruption or kernel warnings.

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 109 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  21 ++++
 2 files changed, 130 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index b87e7f39e..e09861e1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -417,6 +417,113 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	close(map);
 }

+/*
+ * Regression test for the KTLS + sockmap reverse-order frag_list UAF.
+ *
+ * Vulnerable sequence:
+ *   1. Insert receiver socket into sockmap (sets sk_data_ready =
+ *      sk_psock_verdict_data_ready)
+ *   2. Configure TLS RX on the same socket: tls_sw_strparser_arm() saves
+ *      sk_psock_verdict_data_ready as rx_ctx->saved_data_ready and replaces
+ *      sk_data_ready with tls_data_ready.
+ *
+ * When data arrives, tls_rx_msg_ready() calls saved_data_ready(), which is
+ * sk_psock_verdict_data_ready().  That drains sk_receive_queue via
+ * tcp_read_skb() / __skb_unlink() without advancing copied_seq.
+ * tls_strp_msg_load() then finds an empty queue while tcp_inq() is still
+ * non-zero, hits WARN_ON_ONCE(!first), and leaves a dangling frag_list
+ * pointer that tls_decrypt_sg() walks — a use-after-free.
+ *
+ * After the fix the kernel either:
+ *   (a) rejects setsockopt(TLS_RX) with EBUSY/EINVAL when the socket is
+ *       already owned by a psock, or
+ *   (b) correctly handles the data path so recv() returns the right data.
+ */
+static void test_sockmap_ktls_reverse_order_tls(int family, int sotype)
+{
+	struct tls12_crypto_info_aes_gcm_128 crypto_info = {};
+	char send_buf[] = "hello ktls sockmap reverse order";
+	char recv_buf[sizeof(send_buf)] = {};
+	struct test_sockmap_ktls *skel;
+	int c = -1, p = -1, zero = 0;
+	int prog_fd, map_fd;
+	ssize_t n;
+	int err;
+
+	skel = test_sockmap_ktls__open_and_load();
+	if (!ASSERT_TRUE(skel, "open_and_load"))
+		return;
+
+	err = create_pair(family, sotype, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_skb_verdict_pass);
+	map_fd = bpf_map__fd(skel->maps.sock_map_verdict);
+
+	err = bpf_prog_attach(prog_fd, map_fd, BPF_SK_SKB_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach sk_skb verdict"))
+		goto out;
+
+	/* Configure TLS TX on the sender (normal order, no sockmap) */
+	err = setsockopt(c, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP) client"))
+		goto out;
+
+	crypto_info.info.version = TLS_1_2_VERSION;
+	crypto_info.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	memset(crypto_info.key, 0x01, sizeof(crypto_info.key));
+	memset(crypto_info.salt, 0x02, sizeof(crypto_info.salt));
+
+	err = setsockopt(c, SOL_TLS, TLS_TX, &crypto_info, sizeof(crypto_info));
+	if (!ASSERT_OK(err, "setsockopt(TLS_TX)"))
+		goto out;
+
+	/* Insert receiver into sockmap BEFORE TLS RX — the vulnerable ordering */
+	err = bpf_map_update_elem(map_fd, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem server"))
+		goto out;
+
+	/* Attempt TLS RX setup AFTER sockmap insertion */
+	err = setsockopt(p, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (err) {
+		/* Kernel correctly rejected TLS ULP on a psock-owned socket */
+		ASSERT_TRUE(errno == EINVAL || errno == EBUSY,
+			    "expected EINVAL or EBUSY for TCP_ULP on sockmap socket");
+		goto out;
+	}
+
+	err = setsockopt(p, SOL_TLS, TLS_RX, &crypto_info, sizeof(crypto_info));
+	if (err) {
+		/* Kernel correctly rejected TLS RX after sockmap insertion */
+		ASSERT_TRUE(errno == EINVAL || errno == EBUSY || errno == ENOTSUPP,
+			    "expected rejection of TLS_RX on sockmap socket");
+		goto out;
+	}
+
+	/*
+	 * Setup was allowed — verify data transfer is correct.
+	 * A buggy kernel hits WARN_ON_ONCE in tls_strp_load_anchor_with_queue
+	 * and may UAF in tls_decrypt_sg when walking the stale frag_list.
+	 */
+	n = send(c, send_buf, sizeof(send_buf), 0);
+	if (!ASSERT_EQ(n, (ssize_t)sizeof(send_buf), "send"))
+		goto out;
+
+	n = recv_timeout(p, recv_buf, sizeof(recv_buf), 0, 5);
+	if (!ASSERT_EQ(n, (ssize_t)sizeof(send_buf), "recv"))
+		goto out;
+
+	ASSERT_OK(memcmp(send_buf, recv_buf, sizeof(send_buf)), "data integrity");
+
+out:
+	if (c != -1)
+		close(c);
+	if (p != -1)
+		close(p);
+	test_sockmap_ktls__destroy(skel);
+}
+
 static void run_ktls_test(int family, int sotype)
 {
 	if (test__start_subtest("tls simple offload"))
@@ -429,6 +536,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_no_buf(family, sotype, true);
 	if (test__start_subtest("tls tx with pop"))
 		test_sockmap_ktls_tx_pop(family, sotype);
+	if (test__start_subtest("tls rx after sockmap insert"))
+		test_sockmap_ktls_reverse_order_tls(family, sotype);
 }

 void test_sockmap_ktls(void)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
index 83df4919c..facafeaf4 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
@@ -17,6 +17,13 @@ struct {
 	__type(value, int);
 } sock_map SEC(".maps");

+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, int);
+} sock_map_verdict SEC(".maps");
+
 SEC("sk_msg")
 int prog_sk_policy(struct sk_msg_md *msg)
 {
@@ -38,3 +45,17 @@ int prog_sk_policy_redir(struct sk_msg_md *msg)
 	bpf_msg_apply_bytes(msg, apply_bytes);
 	return bpf_msg_redirect_map(msg, &sock_map, two, 0);
 }
+
+/*
+ * Verdict program for the reverse-order TLS/sockmap regression test.
+ * Returns SK_PASS so tcp_read_skb() drains the receive queue via
+ * sk_psock_verdict_recv() without calling tcp_eat_skb(), which is
+ * the precondition for the KTLS strparser frag_list UAF.
+ */
+SEC("sk_skb/verdict")
+int prog_skb_verdict_pass(struct __sk_buff *skb)
+{
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.54.0


