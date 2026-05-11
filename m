Return-Path: <netdev+bounces-286729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGNlEOn7AWomnAEAu9opvQ
	(envelope-from <netdev+bounces-286729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:55:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1987511A54
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A8DE3024F96
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A3406288;
	Mon, 11 May 2026 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maKVNWf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EE402B9C
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514756; cv=none; b=deMLHmP00mZk/etbJtNLrCJ+kqn81NCw2EF2ttLFCh7/8F2p+xkwSRTu3cB3KYUxCmlKnWluLrgLqZJe0XLm7CnJzXqSTOfYvHpGehZG/eTDbQG+h5Y+r77piwW5BlZ5oe215AE0kOKXTxJ5X6rfh/9dGzKPjTMZ6lseSen6Qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514756; c=relaxed/simple;
	bh=DTFUEU2OuJNVmNPfMe4YoHyZOAvET9nfa33vgjgsZ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/7ZdxIJXZK9LfAMdoqFlHCbGYXqMn1rJssbYTMEZ0CpRjcpSoz0SfH7eikQ95Tk0AhCs/79Z2hyBzNIDjl7ONe5J8XH6wHUeqEvUKuy5ddULoHqJ1kTAF8+18QRNQpBDhPA9vYceCdVkuPW1nIy0nFjgezH/W/wJ0Oa2wely/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maKVNWf1; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c80227c9572so1983780a12.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778514754; x=1779119554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY7jXeM4i67pdCLJbWB9EBFnm7uOeoT6zFaMpTbtsOY=;
        b=maKVNWf1mJzHhaEeiuyuZWckH3Qr84UFyQ/JfdsCVyPgpiP4ln95izCR2on6W9dYFI
         obCH8V8ylJC0I9ADel0qt/Chk9cL1Kk/8S7QIHFFo4S9PoeWWrHi8HiS6rqh2JyQGzDn
         ELBdgCqUfWxrKpa6CiFX66vUd6B8bFJzBkDqy0crgM2WPB4N8FYbAtLlJmEgxVvqQGdW
         3vo01TMvKuQgL/L/53QgdioqDUTTd5h8hu2nzJCc33acg62g46BFofsGwXGPXUd3Fs3E
         KHOS8wllHWKMYRxNc0gKZyTpYXFnFvwfjx8jwCot8dTdzlFsY/K/Dms1HZWNqrvV9wy0
         z4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514754; x=1779119554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZY7jXeM4i67pdCLJbWB9EBFnm7uOeoT6zFaMpTbtsOY=;
        b=YkM7drv/UbTguk3aIV69nZ/EKeOYJ9CqgJGZT4AyhlGrvpo600QzAGl0gwTYpbxFg2
         fqE9/yMcvpR5py6Kkc/WVBqaCfauLSCvtQI702kh89LTpVeV0N2XbEgsNs8EdQJ4iQ+y
         U9VD3hAke0QGiACjErxC7Rhzjr4fOW+0p6Z787a5D+aGuNYp5de1XHH33Gg45GPc+NHV
         qNeRm+ObjSzajFBGY6y6685H/6tLorkMJojEOWeVKQ5lUslL75K0bQfqAK6kpTcOLUhm
         ZxiTg7cu4EWbiWr6wru1X7ktDwHg4FkW7m/Lgs9wIyGS79tXQSCkmpadAHWD/2AGdmxE
         uD5g==
X-Forwarded-Encrypted: i=1; AFNElJ/iucI3bXTEUimzno6KSB8uNo/8g9QYshpIA6Zq4H/qRTwA9S/ImK/YXe7ye+6O3hu3ay2riYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztX+8UasfXI8aEzOUT79ZupRnP6B4HGr2exQIMzbsx4gpPwII6
	96N2zgwAbWHk4kVKlzNJ2E4upFSugc/RRLaPUi3+QGvGXWJP2xa9NkGn
X-Gm-Gg: Acq92OE/CoUWw6ETD3bG1WLUu22lAkWXoQfDZZapGxnAGurfD4yGKqLGD98IsXibVZ3
	GwA+Mo9sJGgww10pkovUDQAJxNnc9FBC+8k72fygcU++69rmSHQs4+qmJSt0uL7P8e/UKkqqKDV
	8ryJhY2MlDot0gZeCkXA6P/LkpHQVav38se+BIYVR7ctKZqabyEt28eza4BL+ZABT1BpuWzv1k2
	KPveb1E3IZ2LR6MWeNpoFnPauiDcMeQZC/JaUJu3hmIp+HkORnsJJk8iTn5lRT7Jkqbc8K2TW0g
	N9SSTCbX0GZuAuR32SKnkO3ZoEfiuvhofPkcoKik24mk/UHI/TyjO/Zk/XhZ4IP5IV9K31RzO+M
	taBzdIA0sTvewySiZI1s6k+m3fhhS4TxwbLz4NshnkX62Diw3OatZYwz6wJPS93yyrnRH7EKGyS
	F7k85KheaPirN7K2UvlCaUVxA+h3lSbEnB4/E=
X-Received: by 2002:a17:903:64f:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2ba798c27a9mr170300155ad.23.1778514754024;
        Mon, 11 May 2026 08:52:34 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e78c6csm112117885ad.60.2026.05.11.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:52:33 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] selftests: bpf: add test for KTLS+sockmap reverse-order UAF
Date: Tue, 12 May 2026 00:52:09 +0900
Message-ID: <20260511155210.32926-3-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1987511A54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-286729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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
index b87e7f39e..e71e6561b 100644
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
+		ASSERT_TRUE(errno == EINVAL || errno == EBUSY || errno == EOPNOTSUPP,
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


