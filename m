Return-Path: <netdev+bounces-251278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AFD3B7B1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92DC4300C981
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FCB2E5B05;
	Mon, 19 Jan 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PNhlhes2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300D2DC32A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852442; cv=none; b=dDPS2Js0mhbrt9R2tCRpBnaWEpyqqPsCXeWhG9NW8S66C7Dzxdl0gNO/tdpRKkq8jLPm4mHcq23Ite2e0fmSXZTDmMK0lfvNW3bLtZa2UYle+v+xmg9MT/RUxY2Z/jN9NolED9emwwUjQpamTXwDpXxweh5+W55zkTgjRaXc9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852442; c=relaxed/simple;
	bh=XPY8f92gY5l+PxSggY67J74gEUpY715vo4yA93jjTvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3JZK4klOtQty6YjlxFFOsGQYqvnRwx/vfeAhqaQuZwmINhMQi3jZEyFoFiciFT26h3ZlOSXL1HvMMc9Ttpi/wVR5/gJOtSZodbW/3qZuZD3hpRoUaUy2sW4d/qQA+pAJI/ZqCp6BrnaphCExL1LxQqdzmYWOeS+gbHk0r6BkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PNhlhes2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8708930695so719959466b.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852438; x=1769457238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h04Zr1La7PRpKhgRarx4qbf+Xu+NHw/7xbmMDgNEciE=;
        b=PNhlhes25ubUtoAhq7eBxZemthCGrKQ0UQy3F10EITc1gI9pAVy4kIIlivTTDnNkBd
         aCHwwobOaro2J82CwQ6ad3mObRP43QIDgIkMdUl8P4/U2XvdXyNvHeeA9TyP+oqRvILP
         t7OLhl2Kvw0/4jBnwMR2t4/GWb1uHtNufF39sG7qeMDd0nP2xfL2bqeJLutUy9CZ/oiv
         o3eehQpQFWPelhr2BkX04fS4pBnqo2+J5qHly47IfKw8pZJeFeN3cgXhzXzwFxS/heIN
         ea99qpvnUNQAdjr8LM44sgs68Qfe9r8P3ipszw4Yq24IvUiC0ELLq9/tcQ1oNqWnQ5Cl
         3giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852438; x=1769457238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h04Zr1La7PRpKhgRarx4qbf+Xu+NHw/7xbmMDgNEciE=;
        b=cgkK6TOCNCJOAseYUHJZw4DNfjKYvgkSdfkOgATfiXSYAYQqwnBo0T5Lp8F4Nm7wFk
         DMhf4eLHmASTirKA/rvB24o88+vTXarIx+jooeFEX8G19ftiV+HOx427qVeLfw6pOSqL
         ihMD0F/k+bX8y7UgwA2wpoK/cil5HSYDdDlpLhWLJNpWu5olVl6P6Vmz42CjeSUvcUTi
         PfVwtig3C+NrJ9cNDjjOsUxpth14RVzF/VNZ91XPX50dh/tcNlugVcvXnROAPiSdbKSt
         iohlKZzI89ujMcPDrOwbtNicErnDGWIn8AavRwzYqm4k6zBGopwRju49WdEHM1kLcbjC
         Zw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNUWWo0OW2rRayQGGLk4aJulVucduWoy9rbhv9nCIwTnxmvgZMZQSNeZAIgb7g2Y5q52hoACw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMi7h8HOA4fdpeQ4n/u+HT37ka2QKrT8azLfR7fD7xA0Iz6vOl
	8bPsspx5ejYJSjITRT9D39qBFB5rUQWyizLBPiwDbCQ+G4gq3PUdXqqvi9EGYkRM/Iw=
X-Gm-Gg: AZuq6aIb0+PA48oBqPaVRKpo7xslLys8cOQwh9C4U4aiXR9pvcrak+iQxNyM5XCxfsi
	UM4Q1zly+2qdRqBC6GymGEWdoXxR2xYFaN7NzPYGjf0sRkUhlcbguTD0yIhyD7OvfKTUtekl2uJ
	LN/C2hH1+Drbs66GZ0vyxWXo8c+30d6O4nsE0MHNTLli5c9WrUhvlZW/OnZxUP+jVcKtjcV+Hpp
	s0zDFpB9q9hCHO5/d+s4aYY90ckJAcgIZjxEQnDSrM0zYBczyRFIgLt/ZvHyoxlxKchD6TnNblj
	NxzO8jJWNuypphXp07X8thKF5hPntJ9ZvxqSn0cRWGK08rCbNXX8GlVe5isBKumkN2xhB5LTv50
	HdqDq+bHQnFwQyrBh4dg8V135oSTf9oTzb5m4fnjZk4svRI+Xm5pY36cdJ1izxl8vemS+RQW8rD
	stAUz95kFWw337iA1oKAz/p94OrXk1IpFVQOQ2gNaCUnP27qDSwkw8EIqmlIg=
X-Received: by 2002:a17:907:1c1f:b0:b87:2abc:4a26 with SMTP id a640c23a62f3a-b87968e2de0mr1059949566b.14.1768852438311;
        Mon, 19 Jan 2026 11:53:58 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1216423666b.38.2026.01.19.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:57 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Jan 2026 20:53:52 +0100
Subject: [PATCH bpf-next 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
helper calls instead of BPF_CALL_KFUNC.

Remove the BTF_ID_LIST entries for these functions since they are no longer
registered as kfuncs.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/sched/bpf_qdisc.c | 76 ++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..cad9701d3b95 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -130,7 +130,30 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
+/* bpf_qdisc_init_prologue - Called in prologue of .init. */
+BPF_CALL_2(bpf_qdisc_init_prologue, struct Qdisc *, sch,
+	   struct netlink_ext_ack *, extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *p;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+
+	if (sch->parent != TC_H_ROOT) {
+		/* If qdisc_lookup() returns NULL, it means .init is called by
+		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
+		 * has not been added to qdisc_hash yet.
+		 */
+		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (p && !(p->flags & TCQ_F_MQROOT)) {
+			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 				  const struct bpf_prog *prog)
@@ -151,7 +174,7 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_init_prologue);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
 	*insn++ = BPF_EXIT_INSN();
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
@@ -160,7 +183,15 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return insn - insn_buf;
 }
 
-BTF_ID_LIST_SINGLE(bpf_qdisc_reset_destroy_epilogue_ids, func, bpf_qdisc_reset_destroy_epilogue)
+/* bpf_qdisc_reset_destroy_epilogue - Called in epilogue of .reset and .destroy */
+BPF_CALL_1(bpf_qdisc_reset_destroy_epilogue, struct Qdisc *, sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+
+	return 0;
+}
 
 static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
 				  s16 ctx_stack_off)
@@ -178,7 +209,7 @@ static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_pr
 	 */
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_ids[0]);
+	*insn++ = BPF_EMIT_CALL(bpf_qdisc_reset_destroy_epilogue);
 	*insn++ = BPF_EXIT_INSN();
 
 	return insn - insn_buf;
@@ -230,41 +261,6 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
 }
 
-/* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
-__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
-					struct netlink_ext_ack *extack)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-	struct net_device *dev = qdisc_dev(sch);
-	struct Qdisc *p;
-
-	qdisc_watchdog_init(&q->watchdog, sch);
-
-	if (sch->parent != TC_H_ROOT) {
-		/* If qdisc_lookup() returns NULL, it means .init is called by
-		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
-		 * has not been added to qdisc_hash yet.
-		 */
-		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
-		if (p && !(p->flags & TCQ_F_MQROOT)) {
-			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-/* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
- * and .destroy
- */
-__bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
-{
-	struct bpf_sched_data *q = qdisc_priv(sch);
-
-	qdisc_watchdog_cancel(&q->watchdog);
-}
-
 /* bpf_qdisc_bstats_update - Update Qdisc basic statistics
  * @sch: The qdisc from which an skb is dequeued.
  * @skb: The skb to be dequeued.
@@ -282,8 +278,6 @@ BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
-BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
-BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
 BTF_ID_FLAGS(func, bpf_qdisc_bstats_update)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 

-- 
2.43.0


