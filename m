Return-Path: <netdev+bounces-290704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COHkGK8KEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85B5B0344
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC383058173
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD83A5452;
	Fri, 22 May 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeCI1/1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CF38E8C7
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435970; cv=none; b=qbKA1gAK1uauvBnxw+DfuJg4lmcy3/hvbNLGRblwcJ5t//6qqwM2qKZjoUAbxmBdljq5fI0KqBm3mApuuYYweUEoK9ufr/aksYjTxaa6qG+T8p16FQMiKxW5Xh9yD5pfohwfZUhoke5s+iksQ4ipPy7zjGp2MAvSQI8ehugRokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435970; c=relaxed/simple;
	bh=YGrfI2hL0wwPAhTinlsXS+ugZFdc+65ByQaIbLZr3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKkoWeIr0iXg82d7sjb4OuLJyg/MTOcf81n/LnMZDac8hkAA3mG/WTsBP8sLMODhlml7zG2O+WTMHRxju3ykl+uEx6LTwDpIJCfrc9b2iaOI/aa49gOWPRbZVcaSFOpLarp286H7QEvdbOKxciNGlm1ldqY8E2q0SywXQYImcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeCI1/1j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso14257306a91.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435968; x=1780040768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=QeCI1/1jeIUuEfS0fp3akjvHllz+KOBdrc9QPpfbt5tcGN8ywdMWLlN+KM4+h2igYC
         fCSi+7ASXeZSMacO8YBIj/CpJ7st/q2cH+aQBReZJpyzHVnNFtMUxJ6W1BOrp3kegWOw
         cXaqmKH1wmSYOBmsO/nnzZafwqmXyKSPE/OwC+FtcIdajwDNg+yX8D1aHvzk3X0KkHYt
         JtXnlN8Jn4m+V1ep+gMKk4gbXMxsuBipmOZXtEC1q5dFvupbPPS8bdNaymddxVO+VxXj
         Zt0Xq3XACTpKCtawJq3yG4ldc4tD/VT2SEI0Ez0m/QmxFakcewO45/fUcSykr7sLaf5I
         P15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435968; x=1780040768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=QsiyTou40qakrbVlth2hNCZKfn510zX9s4fn+wTEP3jQBMA3TpuaP7/YN9Wnp9b3h3
         jwvDVkoFUJvLLWsJrU7mZ7PvqvVfeq9JOu+w1K3xpYPvhrmg3jLGIYJ25dRdYzBlOxdT
         6Jk+ThKQMgqw85R1nvNKvG/QOYgQ2RpECTXEwSNFI/b7DsROwGSGEXImdsLzYO1ienrR
         kmNZQRhJSpm/w5Ft4r+b7VkEin3Vg3gp9IP9Nh9X51THAIqpu1E+cE7xM4rojYYpiev1
         +mrvIw+898gJQ/a/HYi26UyxB6LXE3Cgd6510z1WkYG+DfUd33cGqYRyq8nTzJ+hd01i
         qQDA==
X-Forwarded-Encrypted: i=1; AFNElJ9+hxY4lHDifG9BRL+ImKdV7SQrGy+6lyVyHpFrIMmyhFduQ8ua5SMHeGjNDXvLcAWd8ZodZrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtUNAz7Y8t3v48bYKdIhBtyDbiKSmsxm9yt5vtLzlUTyLk18f
	KXIagblQvuJcI4G0bziFY3Yrsz2UW5Xtbm8gxex6wtOOP9Hbkoijh5HpiE8v+uxoM9kvl4tx9BD
	LSuE2Tg==
X-Received: from pgum14.prod.google.com ([2002:a65:6a0e:0:b0:c7f:cab4:88ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:3b3:f46:1eea
 with SMTP id adf61e73a8af0-3b328cba26dmr2426731637.7.1779435967789; Fri, 22
 May 2026 00:46:07 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:54 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
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
	TAGGED_FROM(0.00)[bounces-290704-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.939];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: BF85B5B0344
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
prog can be called with BPF_SOCK_OPS_RCVQ_CB.

In this hook, we want to parse the RPC descriptor in the skb
and adjust sk->sk_rcvlowat based on the RPC frame size.

However, we cannot access payload via bpf_sock_ops.data on
modern NICs with TCP header/data split on as the payload is
not placed in the linear area.

Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.

Three notes:

  1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
      invoked from recvmsg().

  2) Access to bpf_sock_ops.data will be disabled by passing
      0 end_offset to bpf_skops_init_skb().

  3) ____bpf_skb_load_bytes() is called directly instead of
     __bpf_skb_load_bytes() to allow compilers to inline it
     instead of generating a tail-call.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Explain why using ____ version instead of __
---
 net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4a50fe2cd863..fa8a7c7d86eb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
+	   u32, offset, void *, to, u32, len)
+{
+	int err;
+
+	if (bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB) {
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
@@ -8616,6 +8648,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sock_ops_proto;
 #ifdef CONFIG_INET
+	case BPF_FUNC_skb_load_bytes:
+		return &bpf_sock_ops_skb_load_bytes_proto;
 	case BPF_FUNC_load_hdr_opt:
 		return &bpf_sock_ops_load_hdr_opt_proto;
 	case BPF_FUNC_store_hdr_opt:
-- 
2.54.0.746.g67dd491aae-goog


