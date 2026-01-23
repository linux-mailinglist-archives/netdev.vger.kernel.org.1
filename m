Return-Path: <netdev+bounces-252896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ETOCfSqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83678CC0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C85307BE28
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831E306B25;
	Fri, 23 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O3KeqcjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4030170F
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187937; cv=none; b=T7pZOl1rapZbJKLqR5sgIDP907j+kZX0oE+t2fXUZzzScBM9raQiFEJ2e8kuicrBbBQOIIfN6teMtfRm3HMmaY/MyCZv4cGHLPZNx3it4vE8cRhJA9M6gm1Gy1ffMa43FR36uSoMvXB5pDXK1JgCDnlEbZVmAkGdgv1ExDwVT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187937; c=relaxed/simple;
	bh=nXj3Q76IlpZbOECwV6g+4+roXhmhBlgsqVRAXVI8FlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuvqLFJsyULYJRSHyW6OXJfY3eYXypWNiZI3QvW0PWWckcfWhubbFWLf7vaTV9oEfraf+DmGDjEk1JPZj9W++FP3Yz2uZ7fghKzs5ycjCp31qpWQiRMDghk+7IKas6ZsP+b4h6olO2ZB4LmpvPFqWCX8AYNH+nPMfyaADWONmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O3KeqcjS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso3794134a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187934; x=1769792734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHfRMp+G9XW+duymvt9Q2+cD8A5sxDN6vWrUvFGULFE=;
        b=O3KeqcjSDIe8V0//GgObS3bVzcHr+E3JiV28OAdG/OkfpBX7Vf0YdGd+soPCCMlJwr
         dEXyMe+UVIdMTb7+MK+aK/Erc+GRR0l+N2UknUQU1WhFJOfWB8x0aBMuwWNT5AWOg8Z/
         pJoMC7GHlSYx9Xi5/Sp+MecmPJDB/O/GzYpOmrE5bKshbPzpCEwlmIbVUB995i0ih5Ry
         gWRoeLBre1ukMJfhArvH42gvip8PY9Vomh+6ugsqz1gW3tt2Hapqi2GcVgX76k+PudAR
         6tT/F8/kgfIiSO7nxxcKK+x11VJYFNLbbW2Cxh2XFGHtGblIP7dXk/y4XO+RNEZFihxu
         blNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187934; x=1769792734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fHfRMp+G9XW+duymvt9Q2+cD8A5sxDN6vWrUvFGULFE=;
        b=qihRdQ33xVfb/w9gAnvabExvDPlwsxG35bSbcY7/ejJTc0FxoZj6f+EZ44K/Xd47Wr
         9CJYIsAwZeDmkFXr88YYYuggYAHHjfVzsEKIG9Rk4yCWqgvAleEA0MrY38luqRWDkqy+
         zN1ACWJNIFycrYxCPr04yBWejvoc17fPYQRhGrG61zrl+n9aEekjzDS8p3x0qrDJTizh
         M/IfmdiRUvOxUhEMBJFvBfVA6AhA7G5wjfMJdjrwuqytG2fuSLtb5FKCLdZ8493DcrOc
         OLTdcgPj+JaAUqX+aGdkhkjIuvlBS9Zn+ma9lWy7pU+FT6lYg8jboaYDYIsYcVICWql8
         cxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMjCfXAdBYmccQk37WaPi8Ih99ppwtcoIeKq5tsxdAcPbpOPPH2ecIuY2vN1UUGxnss340L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XglmlnBPhOqUwAOREhS5L2HEb4LExV31Xy+nBWHujUtx3U4o
	hpXM7HI/xZD4y2Vr7EeegnqBcNCJZ42Rs58kmrvNHtPiNyECYHj6TBfnoZknQz0CObY=
X-Gm-Gg: AZuq6aJNqmNbG8UaC5aC/7xwxpd/QDv6Jz5vwJPvbq+jwG3lO1NprO8AE7hDE2lX08P
	/+zep2GA3rwk1fLY2k4ye0icQ+15I5JS7jt4bSVDYeZnaszWClxMi4tRK+KNYDD6h3TQLMG+CG6
	MO83/RA9l2hgM39FDjlEgAODfHgGjcR5gHbM+2xsAHWslb4Q5kHjg7c6F2jUgE8Y/lYGBg/zKQE
	qRAnpe0Zm0rYWx/PtQ5NU30NBnUsIWR1ZiDBt9EVx2fZY55L9gZhv3PDbXRP5NQxxQ8AS//dBgf
	R5z7yOeRhg0BmFC5kXUnzWN7VcCK+cxXgjaw9VhqngIFzt4nGYxyAkyOxMYBis9/Q039CIA3rbY
	0IDJzdmmHjzQ0Vj9mrJv0s8Jy4CP2A7NBL3sKa8rfQ1CjLwb83GOfuQeVU4YstVM3vFALadq/SH
	B0pIMzsG0mWK8aTHem3GJ5h3SHfqNU/jTStIVFYkzGd0S19Srxc8cCAJs08MvALA==
X-Received: by 2002:a17:907:7b8e:b0:b87:1be6:c707 with SMTP id a640c23a62f3a-b885ac69192mr308784666b.17.1769187933746;
        Fri, 23 Jan 2026 09:05:33 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4d7sm130944866b.45.2026.01.23.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:33 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:19 +0100
Subject: [PATCH bpf-next v2 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-2-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252896-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F83678CC0
X-Rspamd-Action: no action

Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
helper calls instead of BPF_CALL_KFUNC.

Remove the BTF_ID_LIST entries for these functions since they are no longer
registered as kfuncs.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
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


