Return-Path: <netdev+bounces-286641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNcvGiPRAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E520050E446
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32585301DECD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78938C41B;
	Mon, 11 May 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu5dF4P7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDF38F247
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503052; cv=none; b=QAkz6ggQWeKxAIPOD2uvOxPf7kjkc7dJjkl2DIzszT7thKkand8BtgQRcFf/7IwabLrbCf3Z+XOPB/K1zg1EpR/YNNjG1b+2EQTU3NMKjwnisMA4xbdDBCZ2L1W6C28rI7lNy+NceiTCvCrJwY4H/QdKij9Nj+kzU3kGmRVKXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503052; c=relaxed/simple;
	bh=mpnlRIp84AtLTYYBNSGEUDcNhnUmPndvkI8ESEoKZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSfynS10/9PI1dtOhCqU46q1V6+EwV9t74n0RXJ3PJBtOt0wCmjJMFKu3TiwQXn5w0/FeE9roKiNBSX7aKrMOXvM2KdRUwZ0FCbSqzmd7e2cDFWw9eLE22AfTdngEl1v90JvDrv/V08zGFQRFbjP1uQ+VXux8D6jbQ/p2PhO6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu5dF4P7; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1622560a12.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503051; x=1779107851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISZM7kzCd3i7an1IFyaHbOB6qikrwE1/Zcric7h+vGw=;
        b=Cu5dF4P7IW0XNTOWoNrm4X4n4IEYKPfRUlLY29m+zK7CW6JSqS5gT9zoUEONN/CMAW
         +I0wydADqsFD56ioMYPOWSpnSgDIN0/53JeNeq1nLfPDqjncPTs+PthsOQJnVZk4n5wY
         VWJMpubpelkXINgTz7uk23CGZrR6hzdEtuxh+Hgcuru/Q1s//S+SwTJKOidz+3s7A/n0
         7WcKjhrlYwy7icW8/yqlQ5yczDlHRsiStJsv9W3kcbql6q9dbn7h4GPbqrjp925p/Lfl
         MpeLwlWBLW1NWVZlX1eLJogs1PC+hBwrzRYpZyYF600R0kOkaIVDC+nq9KHSew7eQ5pK
         CKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503051; x=1779107851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISZM7kzCd3i7an1IFyaHbOB6qikrwE1/Zcric7h+vGw=;
        b=W+zCOigwa6vARQMWXBCx703nZagS2w29dwDLagivIqLWT7On8hajcC7FY+fnP7O0GN
         iXHc/u9TyMfRTDzVpb53iDK/eu3TT+rsR3WG8VU1poJwOFDzUQbXnK22XtV6TQKminOp
         6zw8ZaLKADyMq0s1RTf+4maBQCTmzTY4NzkScfMD1xTB3kPFmOvNRVyeMVcMKj6lH6Ux
         6XNajkurCMSp0m+yZllJl6R+6xaBAyXBGhq+p3fIVxyBhgfjNU53iNy9LGKQdorXsgkd
         BLqnevASUf2R7EJfHuVxVDL4gEQn+t3a8K2CQtiQtIWw7fonGe8Q0X5dwUww8Gr4gMFA
         5anA==
X-Forwarded-Encrypted: i=1; AFNElJ/4GOIVEa79PRoOJ09X1BiA0xOFXh8WmhYAOI7H0vgST0sCFqQxKuQBh+IAFP+lB6j5FqCXg2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iLw2G4etKXWXIt66OZ3+fwcwMKQhS+C+6Szx+fG5w26rxun7
	R01EGFok06FeswD9d8begHm7adQDDmKMCznXe60dPduzljeNZC4XzzWC
X-Gm-Gg: Acq92OE41yVfbsA2ieAcnJ/OR9CDYPahKiMJavw0bMA+2fvolHZJUh+FkxUte+ftah6
	xHVy57Tl8wmQA74TM6TpyR4mX23rkF64+PhtNnWpKHg/HrZs28uvThHdHoRn3NmJ2WCfHzZwsSd
	0uZ24Vj8B8byEgBoCj0WftvDvnu/L/KTs6IKw0vAvSdC+puorwLKiOAdJkpjSzhsBFSuDQXYRa9
	LJoQujf+CBnlotr7VmwG0JpImaGGUB+/0ETP97EtBfqxdjZuLSqMqdXmV4T83hmDHeGNtiIwzeI
	V6v53tvxqtTMATTeHZ4E5mTUHPSJMBBXbZ9ft4G+ZA7haZmH5nRwmyGGpxT8JdPkDtKMWaNx/DD
	2+u6N2IH2BXVzAjVv3exMG4zRrRUEbmmAJB7tZtUibWbzpA/HH4EcmmNybF3omXz7qEJ+Nxj8ev
	AFw6phgsHhX6Kg1tn8JDRrnCZne/Z25uCaPbxq4v8/rJu4Q8Y8+8xbzpqa
X-Received: by 2002:a05:6a21:e082:b0:39c:787:f197 with SMTP id adf61e73a8af0-3aab17186femr14956847637.36.1778503050577;
        Mon, 11 May 2026 05:37:30 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82677104b8sm9034592a12.19.2026.05.11.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:37:30 -0700 (PDT)
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
Subject: [PATCH] [PATCH net v2] selftests: bpf: add test for KTLS+sockmap reverse-order UAF
Date: Mon, 11 May 2026 21:37:18 +0900
Message-ID: <20260511123721.13906-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E520050E446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-286641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


