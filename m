Return-Path: <netdev+bounces-257793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHPCJ7nFh2lldAQAu9opvQ
	(envelope-from <netdev+bounces-257793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BE107634
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D163013873
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E373161A2;
	Sat,  7 Feb 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAIN2TB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0F3112C1
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505647; cv=none; b=WzqpaIyg7Lf+YI79faTlfeKCiU57pMtbCGCgdOAmNZI735UQUs4gEbhFHVaPIlKlv99NZy5YuZuZQExwztFOYANW52E3rYdzT2BEc4xThgpE8qbBKQ6wGw+QNFthUBT6tZ40Tui7iAiz86eE+2d4uXwIB6FlaOkNdixgr+dISZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505647; c=relaxed/simple;
	bh=v2w/95JyMlM9u7kuRCBiMeO91FSb+A/FLHxYMcrbkFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7ho6XEtMT8ZxzXMwgzEMHwuDuU1DebX2TS9YIhZglhR75xIJjqQlS47F+GW6SCrVSuDqx7b7dDYr7UO4l65HfdVj/zCPM/JmbDw10M+JrFLjW1hLAMTpTYgZjAfTcLi8hPIu2yQsxgG3rEbbZOhy6txKPhTjXA5xIofCRI2ERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAIN2TB/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad60525deso12510965ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505647; x=1771110447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=903pwS9Qmgkjn0WanGDgQP7chQ6S3IJyQ8D1TpFC1CA=;
        b=nAIN2TB/l2eXpsbEM4BKP0B/KyCHOJFF4UkqIPUB0L4y2zQN8htSI+QT+dKwQcfG5V
         b9tyntwgkyht1AVLny1flVqlW3XnGPfDqEFkswQtWn4iQAJ8y5qh7rty6FCKm551t4rb
         Cpyrr8JH1oHCtBxDEU1FBU+lAawlp56WTGc/BV0fsM4bfMEBWFpgFsbHsMxsnONc87q6
         qMik5TjOhVWkDK74Ly+eOM+AGeTNp9Nam+MhVOWicXf6JRBZgFLuXV1tAETaQ+ERQJcV
         woyGNGK3Z9FfnYggShPKAahZk/8ET8iQ0nj5D9FXGhi/h/Fex+57WPuN13uYLzH6HDvD
         SeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505647; x=1771110447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=903pwS9Qmgkjn0WanGDgQP7chQ6S3IJyQ8D1TpFC1CA=;
        b=NfafncFvSmRG3AL9yXWw4mYV6xwiLZF/W6sfzoitdQS6Uoj5ooVUg6I4FmSK2gfZrH
         xa629IhHqvbDKzi00vYvOHu2lve6+TObv9VDWLfTx7781BRd+ileEU12SOUhoJe5B7cR
         /PBib1bMM3H+o5aebsn0rBwZQtuVWKUvwR47aeEPX0A3aOPTJw5WYmhEMi3wA5OX5Fae
         65kCD6Be2r775iv2WPDYIfgntgVX2X4jAfTSEj5F6LvyItM4xCTxC1aOYjaLxlmeOhkx
         HgodjBF1y+fy98EdNEbTGZcscCtJLMPt3ft+QDn6eZ7GUoJ5cHj8tlgzDKA6QW3+KVh4
         jCog==
X-Forwarded-Encrypted: i=1; AJvYcCWmyXHo2Tr1Tl+IshmzUCltp8DiX0mfiz0gMpy6xkjRE/A8NhmHi1VUEu6CFezhqRikiq/HkHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79eIt5kll3L8QM0PMr5uoxRzyVfZkP+thJCr9PGWFl5k3obfk
	SmgI2IH+gSkX8bQpAy3eLwBdwqQGPKcTgHTZ1qylQWEQ0fIbHxFDGdfBfr7JL8qC4QhaOhjtR/Q
	pLHwJZw==
X-Received: from plok7.prod.google.com ([2002:a17:903:3bc7:b0:2a7:6d75:fafa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d1:b0:2aa:d67b:ef96
 with SMTP id d9443c01a7336-2aad67bf3b6mr16859935ad.31.1770505646720; Sat, 07
 Feb 2026 15:07:26 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:11 +0000
In-Reply-To: <20260207230720.2542943-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-3-kuniyu@google.com>
Subject: [PATCH v1 bpf 2/2] bpf: Reject access to unix_sk(sk)->listener.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257793-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,fomichev.me,google.com,rbox.co,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 164BE107634
X-Rspamd-Action: no action

With the previous patch, bpf prog cannot access unix_sk(sk)->peer.

struct unix_sock has two pointers to struct sock, and another
pointer unix_sk(sk)->listener also has the same problem mentioned
in the previous patch.

unix_sk(sk)->listener is set by unix_stream_connect() and
cleared by unix_update_edges() during accept(), and both are
done under unix_state_lock().

There are some functions where unix_sk(sk)->peer is passed and
bpf prog can access unix_sk(unix_sk(sk)->peer)->listener locklessly,
which is unsafe.  (e.g. unix_maybe_add_creds())

Let's reject bpf access to unix_sk(sk)->listener too.

Fixes: aed6ecef55d7 ("af_unix: Save listener for embryo socket.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/progs/verifier_sock.c       | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b328a1640c82..2ffc6eff5584 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7157,6 +7157,7 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 
 BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
 	struct sock *peer;
+	struct sock *listener;
 };
 
 static bool type_is_rcu(struct bpf_verifier_env *env,
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 8de4d3ed98d4..730850e93d6d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1191,4 +1191,28 @@ int BPF_PROG(trace_unix_dgram_sendmsg, struct socket *sock, struct msghdr *msg,
 	return 0;
 }
 
+SEC("fentry/unix_maybe_add_creds")
+__failure __msg("R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, xdp_sock, ptr_, trusted_ptr_")
+int BPF_PROG(trace_unix_maybe_add_creds, struct sk_buff *skb,
+	     const struct sock *sk, struct sock *other)
+{
+	struct unix_sock *u_other, *u_listener;
+
+	if (!other)
+		return 0;
+
+	u_other = bpf_skc_to_unix_sock(other);
+	if (!u_other)
+		return 0;
+
+	/* unix_accept() could clear u_other->listener
+	 * and the listener could be close()d.
+	 */
+	u_listener = bpf_skc_to_unix_sock(u_other->listener);
+	if (!u_listener)
+		return 0;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0.rc2.204.g2597b5adb4-goog


