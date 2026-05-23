Return-Path: <netdev+bounces-291057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BBDFs5lEWoelgYAu9opvQ
	(envelope-from <netdev+bounces-291057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3ED5BDE4C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248423024976
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C535676B;
	Sat, 23 May 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jh1k61Og"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39A351C27
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525008; cv=none; b=rya5e11sMO2I/zr2eRXwVXlQ+krMPeMLMSiYH44v4QuWbgKviQ3zeNz06+UvQ9YEoT9XQ3jqasje+jbWSc6G/8db0eExlHt9lQzhmiCS+IaF54VJjKVetvlcCfJf0j2QRtc/mas2cLg1pNNEfradK4K2jlQ1oJKDlXNPdSMk5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525008; c=relaxed/simple;
	bh=wpfP9iaC4NcOUpR4U8log0eGACMjzwD9P5ShdZk1/Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vq52pOL6/bxqyVFKxGdYdP2A+mTELjLlHNqDQZietkrWZs7YCx4quNxsvGx61HkD1dwethpaxBGv6XjelGy6OeVP/pu46mMA7nLzuridvcMpDL/nxQArEyB1g7uNYU2U8KfnXtdri0AZ4WC75Knk26buUEOcgXeN49S/HuhO7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jh1k61Og; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso150969905ad.3
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525006; x=1780129806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=Jh1k61Ognl4nKPK6gNRbO3Tl9ISBZdpYQiAxZXGNFi+WzVbp0rhGRVaj3gwar6lGMA
         +I6x81AhQkS1nF5hzIWGnjIDGwOY4+mR+DDa97xTInqcjntnL1ZAqn0TlfftXS0pzc5r
         zO/QpKFrxfIRj9glvM9BqMc3qPWoPgzhKBBV5V5sogtPwdQyDguCJzusXPxmB++DzDik
         rbElVzJbkK0VyYaAvIynCKnEoeegVjb8GPVu6XuUDHV2N9PKKXTw9C80lYCqL4QwGAYB
         OdN4QTelzUG1n3HtuYlxS7l6Dko5B/XB1APhwEBTc6kumBbuu6KWVq3QPAifa0c4WWql
         2d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525006; x=1780129806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=Ac9AVdk5YQzg3l3Wiu2vYzGI7y2H+7oURy2Y/sGyWvejD/ilJHonF0Vdx0Pn1RNdl+
         P8ZTLMw3MiIkwC8pv6Dw9uEN+4/ECmr0uBF0fJfZYMhaNQgx1fwMHFM+Hjok4QDPSKwh
         Bbrdra0kRw/NvcjAVRpQKhtSVTOi8hCwFpZkvdo+LEcgTrXui3hByo0AYqvODuH5CiK6
         Tfk4zrkZvmz8UaW0mmVVsUPck6HeyoYpQ9p6F/2pWjBvuxUvtc+YFszV3+2nqBCbQxYO
         T3IPRLaAOIF930boFmwU4vG2HHvITAsTFzbL5o+XvvLJM7etRbjd1XsAnBRRvkkRwV8I
         57iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LBQlKSV2oPgfBmaleI6XkN3b759Ogj1mvz/zhdQR3Ho68Mq286XwyXV3IW6jfDuuqPITYqPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwv2RTXIL7JhbDMZEho7dAdgLGVaR2vHXxK2awmyF4H3jshxn2
	H9K9FbuxbSRkRV4MBE0lm+WkNKe8hquQ4OL/4aq5W2Xr8pGSrc3AL4vEzQzQqihYFJvfnfwGNFp
	qyXcetA==
X-Received: from plll13.prod.google.com ([2002:a17:902:d04d:b0:2b0:c9c5:109b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e885:b0:2bc:e62a:979b
 with SMTP id d9443c01a7336-2beb0699cdemr77192945ad.30.1779525005751; Sat, 23
 May 2026 01:30:05 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:31 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291057-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.857];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC3ED5BDE4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will introduce a new type of opt-in hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVQ_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
(e.g., a full RPC frame) is available in the receive queue.

Note that is_locked_tcp_sock_ops() is left unchanged not to enable
bpf_setsockopt() unnecessarily, but bpf_sock_ops_cb_flags_set() is
supported at BPF_SOCK_OPS_RCVQ_CB to disable by itself.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: s/BPF_SOCK_OPS_RCVLOWAT_CB/BPF_SOCK_OPS_RCVQ_CB/g
---
 include/uapi/linux/bpf.h       | 18 +++++++++++++++++-
 net/core/filter.c              |  3 ++-
 tools/include/uapi/linux/bpf.h | 18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..31130e1b63ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..4a50fe2cd863 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!is_locked_tcp_sock_ops(bpf_sock))
+	if (!is_locked_tcp_sock_ops(bpf_sock) &&
+	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
 		return -EOPNOTSUPP;
 
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 37142e6d911a..3b8f392d8c69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.54.0.746.g67dd491aae-goog


