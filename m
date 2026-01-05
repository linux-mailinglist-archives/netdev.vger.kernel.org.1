Return-Path: <netdev+bounces-247023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BACACCF37FF
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6EFB3077989
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C2335551;
	Mon,  5 Jan 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CMHnJEkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7D335090
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615302; cv=none; b=mRIZiVXBtATK5JFZcaiP6To8P+SEJJl1Lrnfb2HIOUqbhgC4MNu1WgqJDx/kGLEqHTI61iKY9vcTFrEtTqeHHu9ZKwMIWawgCUjbuGuQtEOoTWf4F0ESSM+jUJeAZ28aLuTJyU8/735YYU4qENWikiKH4I4CF/bbptHDbpiMT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615302; c=relaxed/simple;
	bh=iKNjQ1KAOrlD1L3h6idGK/qC6UzV3o2DCBC2/mqgcPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbQ1mr8syYUF6R2+sTLNYetQAm7y1Ig9n7OLI1Uv9ew928m8VlptMP3uVVHV5OsvK/uUF/K8qAQfiubMJFPoYACPy86PDpr5h6mRwAVwTE1QSqRWouBFkvDzdk11Ko//z6AyLA/IaTCUHMcqSazpe83gE9P/X+bGiHzlBS5875w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CMHnJEkG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73a9592fb8so370806866b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615297; x=1768220097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S0GquGXjoJIfJUVkVr8uapwjE8W/daiZGfUw2AwVE8=;
        b=CMHnJEkGDxyjqv6ajbjWhWaiTLZq4CXa6y8M5FmHTwVCPpcIOtoxu591vuiXgY8gQb
         zq19z/wh5tWrBjlLNV7aQngli6BboRJrsNJzsdbW3bCBaFr3TbCEK6fzF4CZ3Leov7Te
         h9bKGWGH+CQoqzuoHcD7nIzExODMdneK/RXE2jJ7GCA5ysLPPSSym10EswHKcct+htQI
         /b5fODRxU6TdVG36DQa5XY8SvCnQZNt47cepCMF4mwJuv5FnjJtVOXtDcwaERipo8jFv
         563iK4XrYjr51f2/tP9e5pa+en0dLQVtrMpLIZpWR3my+qjZ8bXiyJC3FyxIi+XN2Ju/
         V+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615297; x=1768220097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4S0GquGXjoJIfJUVkVr8uapwjE8W/daiZGfUw2AwVE8=;
        b=mjSwolZiSnBxUuk+tKi2wfdzfLqWta8mSgyZKsajBMXENcRslN3EnIbacM0DlmwFe2
         /5Md08Rtkz+EtGQI6407EODr9Wv/v9wpOqMcSIyw7TQecb2b7Ps7q+RBagRB2oI5Kj0S
         bE6BzpWRzSPU9Nuuqsm1B1d+a3o4tn99zYZaXbVcmQxjDqAow87QuivdW0J5AA9Wjilg
         hW2CLU/XiyqKZeXgZz8r6/2FKanVvL86b/6wG/ZnseGzV6I+DSdPvkpGAU4Bsi2hA7zU
         aMJ8jnCPmEppjSPNoRXHKIbv3a6Hf34f6spQY+oTSkCdFAiu23i2MegJmmsUmp3gRjwS
         nhHA==
X-Gm-Message-State: AOJu0Yz4lh0H+9r8xR/N7W2JrmvjpJ6fL6Phc8I5lx6TdrCNRpjNmlYQ
	HTWCgbCNguiGhFyaFYp/ewUzyHACbPwzdj9De1mKRC4WLAOucVPwF0GGizUy6llEFRk=
X-Gm-Gg: AY/fxX7kv4ud1tfnSpts+tBBTkW4WR53/R69mr+aFIOyxm7wqnERRXYdRI4cQ8dmoog
	wtyWz3XNimvGrRpFVwUGD4m7EC8UvBSOoyaaS3KMFx5XLT3kRlCZoi1BGevPMUKMnNIGRZ2qleu
	SJZP5fK7TvkpkGgPklI+p91BHw9GVeWpjBcosxIBlfeAmO11Ey2xA5qGrbCoVHGXrJ65Lv+grX0
	98diwLhtWEswWnMMgzyWdVHxn9fzs+lza6rMmF3X6rRVrsT4XbIDii7wHMZZ4vhovSWuWttBeCQ
	NfTRl9Nqe7NouANAO9FADu0UTiCbN4VQo4BLfUSD0BPXELOkfdX4UocrMfUSWpcswCnRhxkbU16
	OWxeIQ6KIZadLGHBVIKvifghizLa1nbKEq3Ge8fSMjZ7iWVu8BNWCqiQEqY/J6IKpj8LYlxeaqO
	97p7TATREevD9eK6ZEpPLou847fS7nGp3r8xic0F1NODy5zQASBAIV/g+Ho5I=
X-Google-Smtp-Source: AGHT+IFngG9C5Emo1poRtE5y3IgHLlg59MWI04naXXIvG/l7OVIBZCoIsM1/UXLDitF7jMZ4aaBi2Q==
X-Received: by 2002:a17:906:d550:b0:b77:1b05:a082 with SMTP id a640c23a62f3a-b83e25b4698mr875496066b.2.1767615297485;
        Mon, 05 Jan 2026 04:14:57 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80426fc164sm5342154466b.30.2026.01.05.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:57 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:40 +0100
Subject: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
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

After decoupling metadata location from MAC header offset, a gap can appear
between metadata and skb->data on L2 decapsulation (e.g., VLAN, GRE). This
breaks the BPF data_meta pointer which assumes metadata is directly before
skb->data.

Introduce bpf_skb_meta_realign() kfunc to close the gap by moving metadata
to immediately precede the MAC header. Inject a call to it in
tc_cls_act_prologue() when the verifier detects data_meta access
(PA_F_DATA_META_LOAD flag).

Update skb_data_move() to handle the gap case: on skb_push(), move metadata
to the top of the head buffer; on skb_pull() where metadata is already
detached, leave it in place.

This restores data_meta functionality for TC programs while keeping the
performance benefit of avoiding memmove on L2 decapsulation for programs
that don't use data_meta.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 25 +++++++++++++++--------
 net/core/filter.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6dd09f55a975..0fc4df42826e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4600,19 +4600,28 @@ static inline void skb_data_move(struct sk_buff *skb, const int len,
 	if (!meta_len)
 		goto no_metadata;
 
-	meta_end = skb_metadata_end(skb);
-	meta = meta_end - meta_len;
-
-	if (WARN_ON_ONCE(meta_end + len != skb->data ||
-			 meta_len > skb_headroom(skb))) {
+	/* Not enough headroom left for metadata. Drop it. */
+	if (WARN_ONCE(meta_len > skb_headroom(skb),
+		      "skb headroom smaller than metadata")) {
 		skb_metadata_clear(skb);
 		goto no_metadata;
 	}
 
-	memmove(meta + len, meta, meta_len + n);
-	skb_shinfo(skb)->meta_end += len;
-	return;
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
 
+	/* Metadata in front of data before push/pull. Keep it that way. */
+	if (meta_end == skb->data - len) {
+		memmove(meta + len, meta, meta_len + n);
+		skb_shinfo(skb)->meta_end += len;
+		return;
+	}
+
+	if (len < 0) {
+		/* Data pushed. Move metadata to the top. */
+		memmove(skb->head, meta, meta_len);
+		skb_shinfo(skb)->meta_end = meta_len;
+	}
 no_metadata:
 	memmove(skb->data, skb->data - len, n);
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 07af2a94cc9a..7f5bc6a505e1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9135,11 +9135,62 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
+{
+	struct sk_buff *skb = (typeof(skb))skb_;
+	u8 *meta_end = skb_metadata_end(skb);
+	u8 meta_len = skb_metadata_len(skb);
+	u8 *meta;
+	int gap;
+
+	gap = skb_mac_header(skb) - meta_end;
+	if (!meta_len || !gap)
+		return;
+
+	if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
+		skb_metadata_clear(skb);
+		return;
+	}
+
+	meta = meta_end - meta_len;
+	memmove(meta + gap, meta, meta_len);
+	skb_shinfo(skb)->meta_end += gap;
+
+	bpf_compute_data_pointers(skb);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tc_cls_act_hidden_ids)
+BTF_ID_FLAGS(func, bpf_skb_meta_realign)
+BTF_KFUNCS_END(tc_cls_act_hidden_ids)
+
+BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
+
 static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
-				    TC_ACT_SHOT);
+	struct bpf_insn *insn = insn_buf;
+	int cnt;
+
+	if (pkt_access_flags & PA_F_DATA_META_LOAD) {
+		/* Realign skb metadata for access through data_meta pointer.
+		 *
+		 * r6 = r1; // r6 will be "u64 *ctx"
+		 * r0 = bpf_skb_meta_realign(r1); // r0 is undefined
+		 * r1 = r6;
+		 */
+		*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+		*insn++ = BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]);
+		*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	}
+	cnt = bpf_unclone_prologue(insn, pkt_access_flags, prog, TC_ACT_SHOT);
+	if (!cnt && insn > insn_buf)
+		*insn++ = prog->insnsi[0];
+
+	return cnt + insn - insn_buf;
 }
 
 static bool tc_cls_act_is_valid_access(int off, int size,

-- 
2.43.0


