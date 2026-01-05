Return-Path: <netdev+bounces-247020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8DCF37DB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E07730393FD
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F03358BF;
	Mon,  5 Jan 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qh4YA3k5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2033507B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615297; cv=none; b=NtCDRDOH4LfeSIzViuK0V3JGyHuK4UMCyQMOh9rH69wHAuviuD4xO7QhzQ3+bgrhPEDb9T5e9poD4u8fZA+AzZV0vDZDV1hVvQa4k2zBuhRVCxRuX9tgomK5+3jbz2T2cYGoEXj8n06prulfQWBY/CL9m/0BT5CLs/ksTch4MEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615297; c=relaxed/simple;
	bh=IIFb51Gy/DWsJV6cFEMZaKjS0sm2RgnLEz5ayRS3wPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elN3R9SDr8D/azjvgl4bCVr8MFG8+SqfrzXDdkyX1FVC9xYXmyafqANItMHh3fHar758ojWAThL6RgpegWFh9C6I3GF7OvDBKdGhNOhyHXotTyRYfZtdfPwSnTbhF23FjT4G3sM4xv9fDXFPC8wVyV8LoZt30ujF3ScZFlI4RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qh4YA3k5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so2208722166b.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615294; x=1768220094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLmWUlmFbL3slFSMdfLDXe6ULlPoRwYj6o7jYafn/70=;
        b=Qh4YA3k50QN8s0cGV8BoHmdlT83XPrgXpDYxKDyeBQqc0IvnbdFZ//DQClpOr64fVA
         nW4/kZiWI4omOMcHPvSxhLNht1OQvZnoJEuiDe2ZJLwXd2Nei7j53oFdbHVy99kyIqlq
         hEzftitiKBcMer67BTNWltd00d5jp/ba+/3PN3KsWJ3rCAAO7K//2yBTfrzF/DovFE0T
         c4mfR+bTEf9YOaV0QW/uUNJ8dAJaZETP99XMPydHQ1hIzW5JaJf/z7pe6Ad4pRGXPPMy
         coK3Dc1PAaQYegtGIcupWTK00ZYkAbyD+9JipQS5/5ToMpgtDoVfv2e1O/etFgEFR1Iw
         E7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615294; x=1768220094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SLmWUlmFbL3slFSMdfLDXe6ULlPoRwYj6o7jYafn/70=;
        b=rZ6nYwM7RL3BpXvUI1SjCjp7TEMTWLOoRZWv2D+jQY0lr/ynizGDnTr14m6UEXPKpl
         nA7nJme6eaFIRBrnhUoMAizqs0MUqRXvIf+JeVtN/nWpNQzJfuXFhKpE/l6HqBAHmc7O
         MygO0hqQK5p5YadS3Ut4HyfJit2MtdNsc094z1yDClqzVplncCuC4RINZ/i0Vy3yJzns
         2zVXk8fq1TjididK7Pswxqrwi0fATJUNkiIOBm1wHHoFu5NLgHuZbIT8UMTtzJ7ULObO
         p29rN07js5R1RFfAS6NEUypHOwSVAu4EYS6w4LN9PBw11GUxXMq5mcPtx654nVSRuGZU
         E7Rg==
X-Gm-Message-State: AOJu0Yy6ZSYSe/CqIBycJ5rHHOGDmiAm+8yTYrPv7bS3+rEOgR9PPffw
	1vvjOEyhP+VtqJurjbAEckDQ9PnGcxZiNGi5icfk33xr5pPEAxs6qtbZbd0+N183jPI=
X-Gm-Gg: AY/fxX7qJw+PPzeIXJlGjYMc/mAlM+eRlL8G6E22pQ/vZXRRMhWWRKSGIZQtqq7nn9S
	spkpFSoRjV8z3+1XGhHGVcpJSnN93a861psLWc6BTKIG3D3cJOXiBGSQAoOdv9uGEcxwKRWC6SQ
	9XGF/chzohZB2tYkrcTrH/UyyKBM/QFY9VnIVqeAlHpS40H0tW8KG+OWGrtGYMtyvLDIEa3A4Wm
	6pLWEP22v66TH5nRnswceXzheBNF5wrGrdUg2WgN+Em9A4cER1XIOBYabO0bYlCU/ZJh8+5EH1Y
	0mpPvQvOy+olaABeIoBFSxLN03LZ81cnQsXkr1eODaFo1k+iraZyHHUr4Qa3AE+eJwOmk0mBzJf
	THZOC838+wmIMJ2aDwWQSi4tB/QuE6ReK5a1Jxm6nSHeUJaaCjBVuoNOm8m8htTkdxwB4mJ1iwz
	sdG6D0jc9ERnBpk74F9+WRoKtIpTfqB897vbRXBPjpF42vwYCInnyLLVyyD0w=
X-Google-Smtp-Source: AGHT+IFTJ4KekrqpPE7R5zKi6rpMjWZ3ksJ66ODNR2SOWPXSDf0DFhirt//1pXjOGuwzpA7+5TwyhA==
X-Received: by 2002:a17:907:60c9:b0:b70:b077:b957 with SMTP id a640c23a62f3a-b8036f0d7abmr4905490466b.15.1767615293997;
        Mon, 05 Jan 2026 04:14:53 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b803d3cea32sm5367167866b.34.2026.01.05.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:53 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:37 +0100
Subject: [PATCH bpf-next v2 12/16] bpf, verifier: Turn seen_direct_write
 flag into a bitmap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-12-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Convert seen_direct_write from a boolean to a bitmap (seen_packet_access)
in preparation for tracking additional packet access patterns.

No functional change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  6 +++++-
 kernel/bpf/verifier.c        | 11 ++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..c8397ae51880 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -647,6 +647,10 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+enum packet_access_flags {
+	PA_F_DIRECT_WRITE = BIT(0),
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
@@ -773,7 +777,7 @@ struct bpf_verifier_env {
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
-	bool seen_direct_write;
+	u8 seen_packet_access;	/* combination of enum packet_access_flags */
 	bool seen_exception;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52d76a848f65..f6094fd3fd94 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7714,7 +7714,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 					value_regno);
 				return -EACCES;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13885,7 +13885,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
-			env->seen_direct_write = true;
+			env->seen_packet_access |= PA_F_DIRECT_WRITE;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21758,6 +21758,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21785,13 +21786,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	if (ops->gen_prologue || env->seen_direct_write) {
+	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
+	if (ops->gen_prologue || seen_direct_write) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
+		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;

-- 
2.43.0


