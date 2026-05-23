Return-Path: <netdev+bounces-291058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKbhN9NlEWr7lQYAu9opvQ
	(envelope-from <netdev+bounces-291058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37D5BDE5A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4BC302633F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAD357CE5;
	Sat, 23 May 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myzaeVHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0F357CFD
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525008; cv=none; b=tqEKQx6exulRozjhdTmaHRP+88jkegnX24v13s1omlinm+EoSc2iFhjodgULhMuGYt0XXiP7rvrt94orN6gs1YeyEtV2tzSa0xnFC5gBqRw2Y9r0TimY4EPW6PnedGYDEm5kpi+MngsdTp7xBFocS1S3EEjP6vJarhuwI2zPaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525008; c=relaxed/simple;
	bh=YGrfI2hL0wwPAhTinlsXS+ugZFdc+65ByQaIbLZr3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZmTfTADJpGg7bjXnb5ucPFNzq2Di4zcDCrzxskxXiKWbNCHYxHw+WO/UKVmC3BaQP4oKLHcuNPkn6qriVmtbGyhPOc3lVDqiTGpufDpxGRVFqv0/RTEno+YbDJtbrKQhi9v2oS6zGimupVZhIEUTVhLdwm5Qt+cYTNJsn8kGloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myzaeVHJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so179838435ad.3
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525007; x=1780129807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=myzaeVHJns+3Y5NeTf3eFTFyE7GdKMDpxDdb28r6yhLAMT1JiHDiNXFMXMD2gbVH+x
         vyWMmOe1JwKO4eTCDVsdg6OCQcUQpwWdjmyNqGP6BoNh2x3zrUl0C3HdV/udhKAWzer5
         88eFaEuTe0wAHIfdVdJS9OPOZ7LJrsnZpNvHPycl0E1BDwx0+wKlJIVOvJvz3I4fczoF
         6VLnhmyc7t6tV4Nmbd/p0DAMbiz3vJ97DPvWPkR0aS42z7spoGfSbGEbBpkRy0TYNAdm
         4RjcbHBiuur1TGNpv1gHJzE4zHfVYev0s92iXdk0uFkHPRVtkUKJh6/1INHb1l7n5iAb
         IxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525007; x=1780129807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=ZGTLD67SItEUZydreeu114WlT3ChwwSxbNYXHDTuxMyjJtJ4OALJ4X4hCpx7RMnchr
         E0RmUTM2RXGj1RlbSTQlKyyepXSExHr4SOvR3aqeSxhw3MV/jh5Jw3X76V6eG6VrKXMO
         eZVSXdFHvSBI2th/AgImGqVB4zqqHsf1hmmwyiP/08CBoHX5IwTVjkf0TidbLWNHdipX
         XMujC/bLT76aEp0hkUhlRBveXZ5IvyfRqetGxiNL1g12RGO936O9BdRX7ySS0j+i3cjX
         8gseaXA9Q9NHGyQtpOrAP6Q3iyPcARWJbDrmtr6iU+gVeh7Jqm10FDfZhVwpdvet51AT
         xAdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+X/rbT3GxmzJIA8tq9jKKnu0eHLOvMZ1tdzXFRHt3fPudaRFP+ksUdhF+R2sbJaHiYsVhQq5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVW0nBS/Ew9oXb4VAoJHdfZYeKWNw20mSzl5CHEG5OfbtJhE1
	aHnTnNRp1zb7Fts91EFiPpY26VrzHB+sj3V+oIvabQO1Bw/JBkf+vxQDYlo/tRIIM+Heesjj1CG
	8uiFD9w==
X-Received: from plht3.prod.google.com ([2002:a17:903:2f03:b0:2ba:903:90e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2beb06fc2c0mr82433795ad.22.1779525006541; Sat, 23
 May 2026 01:30:06 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:32 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-4-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291058-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.939];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C37D5BDE5A
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


