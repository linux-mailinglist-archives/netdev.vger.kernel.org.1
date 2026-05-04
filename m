Return-Path: <netdev+bounces-284042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DeiN5gK+Wnt4gIAu9opvQ
	(envelope-from <netdev+bounces-284042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:07:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823C4C3E05
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98DD3047060
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCC33EAEC;
	Mon,  4 May 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEJuVEud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751E33F598
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928777; cv=none; b=HlyjapkiJD+lae09zaH/LOkxupj0ElKNlkWFTPOkR+0VW76wc13xlmMUHrouboRKkywG+WEMQq2L8T5Vy/CkMEJsZ51c43i0S4Y/UDfoTQvx3O9keijp8No8JXkZHidQYN/xNPBa9I5URqpMDgVOb57bAht8Bf+xKqAJ2b6JN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928777; c=relaxed/simple;
	bh=+tXOfed2AA1Peg5INonHwlEN3i7UeoxVPDgFqjVYyWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CtebNoba1ZNDd8CZ51yi4NsPgZxhqOGaSvnTCrKffe0zZ4frT3zZken+9a+/gGcdSCfVerZLISLWCZdooIKZTxY4hhjpth5fSaS8xJNqFR1shUvEO9EMGeg3Pa7GU8rEErSKXQOhRz4NB/++EWkFZrg8pjA9cTQvUTI7wqayj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEJuVEud; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so9404298a91.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928775; x=1778533575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5D0xEZ9yNUhyoPUL8WiMnGxIjniG9b8lDvBpm0pDEk=;
        b=GEJuVEudWXbywTpSRft7L9Yod9FE2EqF6kOx7YcuW2fEeCtp/TqvW5iuk9JbGYq8Av
         i6fQKjPhKetkZI6ojp3dg2KBgrqjBv71y4pXo3+0D8pEAAg9KIFZ4tEw5sIOHJ3hRIRd
         OpHcLa/JTruaMK2hDOUwg6ZDKc/HyGEffdbCWJ2vsRoSTwjW3AWd8dTeUsYd67o3Hxfo
         +44aUoLxXhZYQVmfGQwefh3UbPlpCRNh4qk7Vg4cG3vzOSmbKjMp4pEGSDLDg3r5aHrr
         Xkr82v+jKVj+kA0UU9yNGXT/Pf93jbQQ0626IZDkMriD+qb8QKvBhpcLVDmxm9sXM54p
         XJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928775; x=1778533575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5D0xEZ9yNUhyoPUL8WiMnGxIjniG9b8lDvBpm0pDEk=;
        b=lk3GQmcAVCUU+EnuOLukpBAGck9fy5b32LktbAtg4WMvSCjt+YW53JwUTqr1holsXP
         QqWATz8qeQAs7UUMrsKBHh+ZeczYHwVbBFqxWMoXEUWupFbc7HCKyAEmI53YbtCyPnw6
         SJqd+jCh1FE6dy8+H4rDtNwNrPXFkTmCPOiiw3kt+6y6h6wzlB5sCYzTkRQmubfx2eIn
         Ul7EM3FYrFe9YzGMdqplU4Swbiy+JFDA8tPa9ZQJ4DLVA1Ks8hZgIYxNMYjPmwtfDflG
         JtdeLzB6GoEBajnlqxPQ4f1YPc9E0VORWqm0AVbQDr+KRx4JwYL8UbDNRdMti1f8VVw4
         lDqw==
X-Forwarded-Encrypted: i=1; AFNElJ8gnOyYJShzwhh+t5E/bLd3we/Ivx4Umz34f4uVxjkYkchESsmxW5uDXUN0hnxu2AqGdX9G8Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJONiYuC9BYQbRKrBZxJzVwdqtUdAXk6IKXA+SeLWPk69um81x
	uYuk+/KuPkiGmmPKmBAEmOPYovq2hcAjRfbcHOUxwzs3Gw6kbtzBqaUAdGH6x4kKYuc1Jy3xYsI
	/2ME+Bg==
X-Received: from plbt6.prod.google.com ([2002:a17:903:c86:b0:2b2:6eb1:9305])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530f:b0:35d:9da0:4947
 with SMTP id 98e67ed59e1d1-3650cdda6b7mr11964572a91.11.1777928775449; Mon, 04
 May 2026 14:06:15 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:49 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-3-kuniyu@google.com>
Subject: [PATCH v2 bpf 2/6] selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4823C4C3E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284042-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
wrong socket type.

Before:
  # ./test_progs -t sockopt_sk
  [  151.948613] ==================================================================
  [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7/0x8e0
  [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_progs/1259
  ...
  run_test:FAIL:getsetsockopt unexpected error: -1 (errno 0)
  #427     sockopt_sk:FAIL

After:
  #427     sockopt_sk:OK

While at it, missing free() is fixed up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Inverted if (err) to if (!err)
---
 .../selftests/bpf/prog_tests/sockopt_sk.c      | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 16 ++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 53637431ec5d..5fd33ad2eaaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -190,7 +190,7 @@ static int getsetsockopt(void)
 	fd = socket(AF_NETLINK, SOCK_RAW, 0);
 	if (fd < 0) {
 		log_err("Failed to create AF_NETLINK socket");
-		return -1;
+		goto err;
 	}
 
 	buf.u32 = 1;
@@ -211,6 +211,22 @@ static int getsetsockopt(void)
 	}
 	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
 
+	/* Trick bpf_tcp_sock() with IPPROTO_TCP */
+	close(fd);
+	fd = socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
+	if (fd < 0) {
+		log_err("Failed to create RAW socket");
+		goto err;
+	}
+
+	optlen = 20;
+	errno = 0;
+	err = setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
+	if (!err) {
+		log_err("Unexpected setsockopt(TCP_SAVED_SYN)");
+		goto err;
+	}
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..5e0b27e7855c 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -149,6 +149,20 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	if (sk && sk->family == AF_NETLINK)
 		goto out;
 
+	if (sk && sk->family == AF_INET && sk->type == SOCK_RAW) {
+		struct bpf_tcp_sock *tp = bpf_tcp_sock(sk);
+
+		if (tp) {
+			char saved_syn[60];
+
+			bpf_getsockopt(sk, SOL_TCP, TCP_SAVED_SYN,
+				       &saved_syn, sizeof(saved_syn));
+			goto consumed;
+		}
+
+		goto out;
+	}
+
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
 	if (bpf_get_netns_cookie(NULL) == 0)
@@ -224,6 +238,8 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		return 0; /* couldn't get sk storage */
 
 	storage->val = optval[0];
+
+consumed:
 	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
 			   * setsockopt handler.
 			   */
-- 
2.54.0.545.g6539524ca2-goog


