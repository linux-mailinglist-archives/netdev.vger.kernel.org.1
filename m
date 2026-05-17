Return-Path: <netdev+bounces-288748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NYYIUrYCWossQQAu9opvQ
	(envelope-from <netdev+bounces-288748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC0561D50
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDC9301D684
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB63002AB;
	Sun, 17 May 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBoVrZ1O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AC27453
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029811; cv=none; b=vBOMw075M7ybzZOqDT7gDJ/29wW7glqFLeHmm20JhX9S4PUfnmzll7eXw3jzuT96uKNScAS3mcKYV310hem6KzbXGgjRf4isas0Fk0MEaJEU8psEOMEtY+QTjk6rgZ/Kd2Vgk0GfPp6pDo0O91ovmhmRAIkjtFX77rWVTR0Z4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029811; c=relaxed/simple;
	bh=Ufyxpdwq1L3yxUTfTSSPaUDjXRsTw2KAtE0kW+ZjqQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bX4r/HLZBGJXtp/kNtUhbMVtidhpYUWIMw6crFuySRFMAJX/VQEsiCP5OuAdUWoG633JDMjfkTLRnElnwJBZgc5eJVDIUugDIVwI8m273XAYsmT3l7LNHvEc+lHtSlvPDaGALGUjq2C+2jK7zCAHTX5Wbk8Dp2krNJrSpxdKAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBoVrZ1O; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c8025f1c227so1164794a12.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029809; x=1779634609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oam6mIXKm5UmWVLfrs9YAgkeS3fp9PlCxKZcZnyOOMI=;
        b=gBoVrZ1OYzstv2Fhky0PnLDDsNs+1bHYYHCdMnbXrIosRDNcc2NucU3rGc9ykfc84L
         Ztcd0IUaH9TVaemvdxekUGJCmO3nKsLyRX81NHNVGn2iJGc2Y9gPut94k7D7xWwlCctD
         Mnf7+pe4uKdE++zVFvuN9VD/oO32x5QRC40MHhrpAg/5LPo1VRav2FyLzKIEWSJNTKqu
         Sg3csXQvycdfe/N8Xa3E9SSofLhuNacnJImA+nTt7JXbjZX3gFphcdIBhrJeyDFxAx+h
         Je+WmzEBLXLlAeVxkMfS4eXPMEgHrbnBeetnRGjFLId1QWpLzPcYPN484oxcj03ReR6R
         Qtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029809; x=1779634609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oam6mIXKm5UmWVLfrs9YAgkeS3fp9PlCxKZcZnyOOMI=;
        b=fWymzlnU2eLSu8w9MJK/502Q9EKODb7HBjuf5LbSuqqBLs0+ysaWEwf8uykCNUOT3b
         Pi1RplxilpWFssk3s1+quMqryReVixqWFnjbPGL+aDqd3/aGDAvfvrQSQZs3/JcpSexu
         ApFh5hWqzkFLsOxHa0n5T/oW4aQRDqtZuxvZdzhvMAnu4Nj637wEeqRhuTxlakA3Z5O3
         aoJYbjvIFI5YBI/whKAGQq58/Z5kkRQj+H1fhkyTUs9H98wtA/nPtBIMJscWRHe8mmER
         JLirx4V65B4h6mK9oSo7hxvJyTIxqdC4DGHfdXNVA/qsyo802exNCBPJox2njfbcwq46
         9oJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8D9KJIhjkKe4Fhv8hDRzU1HG4LzSIOTJW64GQatG+420/NukNEugxDgLQ14G5X9acClrKsivk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2GP7/Ap2ldQ5PDCXAWeZfrP8BAQSvipwqy8MRZ63Ynk6cjW5
	iBkFu7GCbchj/VTbn8pwCJvyTetXEdySWHv0qALr0bf7VUb8E4O0IGXp
X-Gm-Gg: Acq92OGEybxqKBhBAh0jSHn5VqaRdesjErRbpJH/YJ3uiVacidGwCG/WIA3vPBa2Iyd
	vgGrtmx48GmgA/CH4UJzwLjMfaYxGn+5iqacq8KESt7LfLx9ussFDmJD77RODiq4FadEU4PUkxr
	IiHpHAzgu0VGHcJQX77XWY0YuffQu+NLzTAjJ15Fye36nc/+GYcL/MD7nzCAXaDDOP3axSJPr2r
	28CAiFLpchHI8jb2/KiMSsrJYhcDYe6ofE3iezt7zUCULxmjjsUDYMzbKeIT4DLT345EVvz6bD5
	1r2oulK06sHgkp7VSYjK+JJJNOQ03/7VVDHg4VIw7g2jbsKX2YhJuAcrXe3a6GnHzd8vUSKhwQG
	t8xrqx3i2mIDQUQWZHizmiLwsfFX6ZpdqyptvFN6ZPQefzOK2yVZbau97e9QKfgEPZnMkvrhS39
	ZDEVdJxLe5OMJKC8dwVtIftcmBSuXYmyfTWW4=
X-Received: by 2002:a05:6a20:6a03:b0:398:71e4:6287 with SMTP id adf61e73a8af0-3b22e7b6d8cmr13148176637.10.1779029809240;
        Sun, 17 May 2026 07:56:49 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm10392522a12.21.2026.05.17.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:56:48 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	mrpre@163.com
Cc: jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v5 2/2] selftests/bpf: add regression test for ktls+sockmap verdict UAF
Date: Sun, 17 May 2026 23:56:27 +0900
Message-ID: <20260517145630.20521-3-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
References: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8DC0561D50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[cloudflare.com,queasysnail.net,davemloft.net,redhat.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Test the scenario where a socket is inserted into a sockmap with a
BPF_SK_SKB_VERDICT program before TLS RX is configured.  Previously
sk_psock_verdict_data_ready() would call tcp_read_skb() and drain the
receive queue without advancing copied_seq, causing tls_decrypt_sg()
to walk a dangling frag_list pointer (use-after-free).

The test drives the full vulnerable sequence and verifies that after
the fix recv() returns the correct decrypted data.

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 103 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  21 ++++
 2 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index b87e7f39e..6ed8e149e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -417,6 +417,107 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	close(map);
 }
 
+/*
+ * Regression test for the KTLS + sockmap (verdict) reverse-order UAF.
+ *
+ * Vulnerable sequence:
+ *   1. Insert receiver socket into sockmap with BPF_SK_SKB_VERDICT program.
+ *      sk->sk_data_ready becomes sk_psock_verdict_data_ready.
+ *   2. Configure TLS RX: tls_sw_strparser_arm() saves
+ *      sk_psock_verdict_data_ready as rx_ctx->saved_data_ready.
+ *
+ * When data arrives, tls_rx_msg_ready() calls saved_data_ready() =
+ * sk_psock_verdict_data_ready(), which calls tcp_read_skb() and drains
+ * sk_receive_queue via __skb_unlink() without advancing copied_seq.
+ * tls_strp_msg_load() then finds the queue empty while tcp_inq() is still
+ * non-zero, hits WARN_ON_ONCE(!first), and leaves a dangling frag_list
+ * pointer that tls_decrypt_sg() walks — a use-after-free.
+ *
+ * The fix adds a tls_sw_has_ctx_rx() check to sk_psock_verdict_data_ready(),
+ * mirroring what sk_psock_strp_data_ready() already does: when a TLS RX
+ * context is present, defer to psock->saved_data_ready (sock_def_readable)
+ * instead of calling tcp_read_skb(), so TLS retains sole ownership of the
+ * receive queue.  Data is then decrypted and returned correctly by
+ * tls_sw_recvmsg().
+ */
+static void test_sockmap_ktls_verdict_with_tls_rx(int family, int sotype)
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
+	/* Step 1: configure TLS TX on sender (no sockmap involvement) */
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
+	/* Step 2: insert receiver into sockmap BEFORE TLS RX */
+	err = bpf_map_update_elem(map_fd, &zero, &p, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	/* Step 3: configure TLS RX AFTER sockmap insertion */
+	err = setsockopt(p, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP) server"))
+		goto out;
+
+	err = setsockopt(p, SOL_TLS, TLS_RX, &crypto_info, sizeof(crypto_info));
+	if (!ASSERT_OK(err, "setsockopt(TLS_RX)"))
+		goto out;
+
+	/*
+	 * A buggy kernel hits WARN_ON_ONCE in tls_strp_load_anchor_with_queue
+	 * and may UAF in tls_decrypt_sg here.  With the fix,
+	 * sk_psock_verdict_data_ready defers to sock_def_readable and TLS
+	 * decrypts the record normally.
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
@@ -429,6 +530,8 @@ static void run_ktls_test(int family, int sotype)
 		test_sockmap_ktls_tx_no_buf(family, sotype, true);
 	if (test__start_subtest("tls tx with pop"))
 		test_sockmap_ktls_tx_pop(family, sotype);
+	if (test__start_subtest("tls verdict with tls rx"))
+		test_sockmap_ktls_verdict_with_tls_rx(family, sotype);
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

