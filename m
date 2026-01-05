Return-Path: <netdev+bounces-247021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B72CF3792
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 146F1301DE37
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B6335094;
	Mon,  5 Jan 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KNiA/AK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BE3375CB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615299; cv=none; b=lgNZ8gZ6jxbHpbRFLyY8AGisTq4/dOi96V6lQQXuVauHA+hUMd+utjI1XyveTVWu1d7CmRpXva4YcU/1DYH4K3rZEGTRhJAe6ax3Stph2TC0iqZzvWee4a6m+VELOp/dUrivE0Mcov6y77EN2hniZ4BivOTHZURC9bnJSY9HZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615299; c=relaxed/simple;
	bh=LzUsfndNYRiISW44ZEYgC/3sJrwe5x1fMv5MnJIwQbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVkzYqCxGU+joIJudc4WBcWnqdCEeBuQQqaLYhxt0bejQuAvS7P8Z/7WogkLHUsAEpsU65rvsG+yk36peLBQht+tdzA+ruxVQAoGCWtE94n9Cdq9H2C/iNp3m38250obbWJymInoYsEdBXy1imWnZUc+Pi6wbXztNTaIKekmjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KNiA/AK/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so577896a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615295; x=1768220095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBBNRuPzYZnGEqSwm2zT3g3B1TUm8VIsmbp+DNBphRo=;
        b=KNiA/AK/+WGzJ6MbdcxR4a4Os8ZREXNpu7mDPB6JU7bSWT/wFKU8WI8nwWV4IEFShz
         05RVUoFqaJO6NOWrDLH6g/+XGSwJDyZMXwDvjhl18/QO2Sgx4T381nmcli6pQwdmZ1V0
         XdBQLRLjVQOoz3DE6/v1XWT9pWt0ohgBfQSN6RenvJySH//Qc5Xw0X47mq1n3YRAZ98V
         EeMwaFePwYKkylUWe5Mjv9p+vkhSNtT4IoPTXGnH3UPyEbXurCz4ivCFmLj2JpfnpIRu
         WimWQklC63JVDm9Iir46b5zSY2xnT+C/ShwwGhXl9Kn/p39sp8V3qlr6QGOO+YaOhjsI
         Rj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615295; x=1768220095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBBNRuPzYZnGEqSwm2zT3g3B1TUm8VIsmbp+DNBphRo=;
        b=SBeAdrExok02qPwUGY7gx79mygmdGbMsvFJ+kjq7jx6ShtmMLiv5+jhKBZMwq/mKac
         55uCYxOTYIyUZ6lV6ztfEZEPy+t8kYCP3F1cP8vJwJ0odbMU0mpb0twudCrbLRkaFG4M
         fiKMwq+zmBJqFWT+VK2o3Niqi1nPY/Gg0NY2WrXUQIaN1ZrvssyLccI1eQsllN9tTHM1
         EcCX3ZsX6vYh1B1kagMNnmLWcb3XDWBCtgWMRT85RUhh0qN4CSRE+479xlv08AcaeaKS
         fCyePNUbMJDCtCJ2q17qLyQEtEfeFp+uDvyuVZxU7pP3ShX4WG8Dy+aAk3O1nB4/cbbt
         2+cQ==
X-Gm-Message-State: AOJu0YxgIqc+V47jfO8mE8wOL55sLbHV2aWDZKfNcbrxsmXowbmOKeql
	zjYFWnCmrxDlbYscWFls2wAxbjYWxU6y7lru9DCiD+zlEQSnUZy6ayoSQZTvE6jNBaY=
X-Gm-Gg: AY/fxX5O3hGuWCRKWXpJS3nh8XKl+UnZJSrVKJ9b0XilB4JR3ckpwoQByIkpRa8ogQf
	zsR+cbYP7dIeXbQOmadMPAEcwYI1UAkY1NI3GVZwg+thk1IZ170h+F6LSPFEArB8LTbcKppWzqR
	mGYmokUms6TuXVJ1T6qByMuMA3TUhh7AjFaEsZUM1zZd83z9/ijnehDM3+waU9jgezauolE0G5m
	hhKnjZo9nAVCd0d08VzyPRdEG9LM0ZCi1GAORYWHVuXQVt9+Csg2SAmGT/TIFP7zT2BEvDUKOfk
	fxj2UMNIO+BNNn1/xogMXeGa8TzumFurTStKHKlUH4peze8/Ur0qHUVZtxqnSaFEQm8HTe4Lruu
	r8NskOFCtQoa3CSjVPURh9M6OzjyWxN2ZOmfMy/iWPPSvMzZKzfYj9NbG48Mhp3+1py696FJcHx
	PhdBkvbRsDvD0CplJFkRaYEgRatnYj+Z0wIieOYH9HSwLSprLzB4IAH3X0xWo=
X-Google-Smtp-Source: AGHT+IFmtOiNGhpXutv206Ryv7APihDc0b48sMoCoX6pTFSN4PdjmBnmM6rEcYg9PaII4kO7yZv4pQ==
X-Received: by 2002:a17:907:1b0f:b0:b73:42df:29a with SMTP id a640c23a62f3a-b8037253c2emr4647903266b.59.1767615295194;
        Mon, 05 Jan 2026 04:14:55 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a6050dsm5584207866b.9.2026.01.05.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:54 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:38 +0100
Subject: [PATCH bpf-next v2 13/16] bpf, verifier: Propagate packet access
 flags to gen_prologue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-13-a21e679b5afa@cloudflare.com>
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

Change gen_prologue() to accept the packet access flags bitmap. This allows
gen_prologue() to inspect multiple access patterns when needed.

No functional change.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h                                  |  2 +-
 kernel/bpf/cgroup.c                                  |  2 +-
 kernel/bpf/verifier.c                                |  6 ++----
 net/core/filter.c                                    | 15 ++++++++-------
 net/sched/bpf_qdisc.c                                |  3 ++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a63e47d2109c..e279a16bcccb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1106,7 +1106,7 @@ struct bpf_verifier_ops {
 	bool (*is_valid_access)(int off, int size, enum bpf_access_type type,
 				const struct bpf_prog *prog,
 				struct bpf_insn_access_aux *info);
-	int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
+	int (*gen_prologue)(struct bpf_insn *insn, u32 pkt_access_flags,
 			    const struct bpf_prog *prog);
 	int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog *prog,
 			    s16 ctx_stack_off);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 69988af44b37..d96465cd7d43 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2694,7 +2694,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 }
 
 static int cg_sockopt_get_prologue(struct bpf_insn *insn_buf,
-				   bool direct_write,
+				   u32 pkt_access_flags,
 				   const struct bpf_prog *prog)
 {
 	/* Nothing to do for sockopt argument. The data is kzalloc'ated.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6094fd3fd94..558c983f30e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21758,7 +21758,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
-	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21786,13 +21785,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
-	if (ops->gen_prologue || seen_direct_write) {
+	if (ops->gen_prologue || (env->seen_packet_access & PA_F_DIRECT_WRITE)) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
+		cnt = ops->gen_prologue(insn_buf, env->seen_packet_access, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index d43df98e1ded..07af2a94cc9a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9052,7 +9052,7 @@ static bool sock_filter_is_valid_access(int off, int size,
 					       prog->expected_attach_type);
 }
 
-static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_noop_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			     const struct bpf_prog *prog)
 {
 	/* Neither direct read nor direct write requires any preliminary
@@ -9061,12 +9061,12 @@ static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return 0;
 }
 
-static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_unclone_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 				const struct bpf_prog *prog, int drop_verdict)
 {
 	struct bpf_insn *insn = insn_buf;
 
-	if (!direct_write)
+	if (!(pkt_access_flags & PA_F_DIRECT_WRITE))
 		return 0;
 
 	/* if (!skb->cloned)
@@ -9135,10 +9135,11 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
-static int tc_cls_act_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, TC_ACT_SHOT);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
+				    TC_ACT_SHOT);
 }
 
 static bool tc_cls_act_is_valid_access(int off, int size,
@@ -9476,10 +9477,10 @@ static bool sock_ops_is_valid_access(int off, int size,
 	return true;
 }
 
-static int sk_skb_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int sk_skb_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			   const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, SK_DROP);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog, SK_DROP);
 }
 
 static bool sk_skb_is_valid_access(int off, int size,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b9771788b9b3..dc7b9db7e785 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -132,7 +132,8 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 
 BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
 
-static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf,
+				  u32 direct_access_flags,
 				  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1c41d03bd5a1..d698e45783e3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1397,7 +1397,7 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 static int bpf_cgroup_from_id_id;
 static int bpf_cgroup_release_id;
 
-static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf,
 					  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1473,7 +1473,7 @@ static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struc
 }
 
 #define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
-static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1483,7 +1483,7 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 		return 0;
 
 	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+		return st_ops_gen_prologue_with_kfunc(insn_buf, prog);
 
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;

-- 
2.43.0


