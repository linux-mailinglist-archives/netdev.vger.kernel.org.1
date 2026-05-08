Return-Path: <netdev+bounces-285688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JdeLQaT/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504124F31D4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751EF3013795
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CD378D8B;
	Fri,  8 May 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utCezthk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AC2F8E81
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225659; cv=none; b=hC9rmke2Y2OAot72YkE/M0HwT4BsyNI78ohc03jHemNjiud/g/mgBPSX/hEwRzAediAI2lS7MqVMowuhrDPckME8QEaToF09K747pf/8QhjwKD2WBI/zf4vbhr+tyeX4CEWwPCw+CMYHiw+vRD3MzG9KEUi5dDq4N8B8pY2eepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225659; c=relaxed/simple;
	bh=RcOGC5biqqidL9mPmPnMFNJxdlLdq0RSsdIgim7YNI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pqFpPYSAM/K3wXMxdmxVZZTwMCKpkqViifohnMHKmkaEMxSGaYgHvC7HrJUId+lsG/J0fD0qzAghFTAgbJ/2Z9ZBbRw19FMZJNXf44bhm+aowpGUVa3jhATR4rMUvRXWQXURqs9OmQxKIff5Lv4/QMNZnpEiLFCLeTCxXnxQSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utCezthk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836d0184333so1686760b3a.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225658; x=1778830458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvA9sbXXBENIWpdg9GAByKEnEkJPQT3OBn9TGPBVCdQ=;
        b=utCezthkwCWW81QkCBv3B4r3OGEfvukzP6K6mDEO9PPDchUq5X23ErOtjCw0S3X5b1
         RYa6VKOUJ5GjTirZWtrLDYwQTDtrlr0HUeU/A0q1YQ635WiYn5fauzr6MdaIZ0MGqWmL
         Go6sE2vySKpcx6u1icE+FVxateanlI1uc0rrp0PGnOj5uiO2pxmJSqCqtWNSZAdumf4s
         gV3g96fGLPhB1nbN+gxVxdEhdce3fMSTT9fGr37Zt90p01nWAbUzJvc33i5Hvx6FaVbs
         AyYgJcbeT2v7ZjEIRyVUbPZNLiQTps+h1bsgIt1T31kGNid797PGxoLjUCHbueFwGZMq
         Fy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225658; x=1778830458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvA9sbXXBENIWpdg9GAByKEnEkJPQT3OBn9TGPBVCdQ=;
        b=b08MJoGnoM5TdRri0yoyLr71QmXM2ZTrwxnXMFjMtrp2kkP1njt0aRrVi1+ravQehY
         gVFMO+8XbHjCbwUvXf1pn4ex3BviBorsAfZ2RiDZ6a9dbiW3l0MsTkAXVuNHNPTbLkJN
         W7JaCCGyNRlC+Ii2aMzRR+thQbEUKWpN6roXTQltYbgIHtyublhuA8TSg28sbqGZ8chx
         aupLi5RTWOqsU/+eTafHHuql8Lu046cFJwrn2e2ItBBYWbhr199WcAHG7cxf+8N9zr6w
         R72BLzocYDNZfDVeiaSkkeU6JKvYkNRjdDUr68VKeioBzV76syZHFs4Cg4zDSnZqodvT
         QtLg==
X-Forwarded-Encrypted: i=1; AFNElJ8mSxoYi+NdCy3gpcL8OOXigen2GXLQxaFhQSyN9zglJzLXcRm5b5eizH8Cs3AfiK74vzYrLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/jRpEBtqSmcYt2ZLSEn8GjtPGL7w1Vfq/1r9qNvlNlfiIlmm
	b4kzgImpjhtnz+857lZJjc1VRw7Pk2Gbprgij1Q7OpTpzxD5sOl0ompTi0eVp4x7tnNDyRIonpx
	4ArMhKg==
X-Received: from pfbmu6.prod.google.com ([2002:a05:6a00:6e86:b0:837:f337:257c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438a:b0:838:6d43:9481
 with SMTP id d2e1a72fcca58-83a5b6c6b10mr11295215b3a.4.1778225657461; Fri, 08
 May 2026 00:34:17 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:24 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-4-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
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
X-Rspamd-Queue-Id: 504124F31D4
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285688-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_sock_ops.data:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.

In this hook, we want to parse the RPC descriptor in the skb
and adjust sk->sk_rcvlowat based on the RPC frame size.

However, we cannot access payload via bpf_sock_ops.data on
modern NICs with TCP header/data split on as the payload is
not placed in the linear area.

Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.

Two notes:

  1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
      invoked from recvmsg().

  2) Access to bpf_sock_ops.data will be disabled by passing
      0 end_offset to bpf_skops_init_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5fa9189eb772..94d07a15b2ab 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
+	   u32, offset, void *, to, u32, len)
+{
+	int err;
+
+	if (bpf_sock->op != BPF_SOCK_OPS_RCVLOWAT_CB) {
+		err = -EOPNOTSUPP;
+		goto err_clear;
+	}
+
+	if (!bpf_sock->skb) {
+		err = -EPERM;
+		goto err_clear;
+	}
+
+	return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
+
+err_clear:
+	memset(to, 0, len);
+	return err;
+}
+
+static const struct bpf_func_proto bpf_sock_ops_skb_load_bytes_proto = {
+	.func		= bpf_sock_ops_skb_load_bytes,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 static const u8 *bpf_search_tcp_opt(const u8 *op, const u8 *opend,
 				    u8 search_kind, const u8 *magic,
 				    u8 magic_len, bool *eol)
@@ -8574,6 +8606,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sock_ops_proto;
 #ifdef CONFIG_INET
+	case BPF_FUNC_skb_load_bytes:
+		return &bpf_sock_ops_skb_load_bytes_proto;
 	case BPF_FUNC_load_hdr_opt:
 		return &bpf_sock_ops_load_hdr_opt_proto;
 	case BPF_FUNC_store_hdr_opt:
-- 
2.54.0.563.g4f69b47b94-goog


