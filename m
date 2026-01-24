Return-Path: <netdev+bounces-253010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHlIMKE9dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:33:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3B7C573
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3404F304E1A4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960925DAEA;
	Sat, 24 Jan 2026 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/05hELD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70206266576
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225529; cv=none; b=gtY5CzBIH6Lvw7JLAJvQYleQF293r6mw+YVXix2oaS5mATBrCSmvzU+oVtcCnoVOkNtF3AeeHz/fRRWeAnhLCDvtz/UVQvY7XhYgJjuMiEkO6tm8FjtRCsnwvoGfGtKXL0LaqZDYgrlzE//UrSwBaZtgrHQBo8C5L1eAdmFFaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225529; c=relaxed/simple;
	bh=K9b/t9XXOnTLdqEXsxRrneyFY/nndVnsOJwQPHo9UMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m60bI52GFFBLvy0FTgVuGL1/wEvpTDYXqUV/gKhRdwasbcr2axsZig6DdyOpqSOrWI6ev0WkGEf3iiRHFGYazztGKM7FoL8751TbjPa3woc20R6+BZ1tXy3mQemDLvPkqGqzKrfWFKcW+oVOSPpdXUjey4jxaXC/8HL10N8+4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/05hELD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0a95200e8so18999675ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225528; x=1769830328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaR31gnegNovKwQZUAOooLQs9UdrAAfPr7JJtoM3Rv0=;
        b=E/05hELDH2nfp1ornuzxqqyny93J4FwgM0+/ihJlm3s9bJtm0OwjTZHyrRYLoZC7U2
         os0DAhLQrmxdUMBu/rrHanQ12534tVJS9WW+0wxiAChcQ2jadYn8fERL8zvG1Z1c+cVt
         bElHm+NMj+1rAAUusN5n/aWFqzc4FvJIVvJnEyZmYHFsXWlJr9zXMZXRunGnjU5cgQRS
         0Xkrey+bxhzBxylCTvJphm2WnIo2xJWLcOarzXG2GJfYtOlDCmgmR2GMCoYzhPY58TYs
         ZJzcWhjkP8gzEBlaKzT6nDBroUIE61WpCvS+/5wEu8gvox7tkNVBY2lngIDWlaX0NbMF
         wclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225528; x=1769830328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uaR31gnegNovKwQZUAOooLQs9UdrAAfPr7JJtoM3Rv0=;
        b=U5Kx281jFWx0ASozrOybeDTK2L5QNV8Rx8q+xMPv7+glHAgLAvA/rhSUajAG8FOMsC
         Am1td6NHNNj7EDR0sGMntUftWHgwgO+OQrYKG1+iplDFiPOSvIYVOFrjSoGo1aHb6rAl
         7lNpDoKWpFsxx1/I6bMvTtDS69Ssork8Ht9oTFDZPI61s18mmspBZ9mo2AzQHbofNSwa
         eFBm1cw4OkjVOHjXER1v+ha24zR/GYdlPExZ1uULTO+EXex+5p5JtdkPJ24+OpMlvlqd
         PkImJ/FiN0OxkydeohpJRx66e/tP7O9DhPOv221ftu9NjY3aeB4AT6XxMN7Kqos6fnKt
         wqlw==
X-Forwarded-Encrypted: i=1; AJvYcCXseZqE2tSRPQwVPCLU/T74NbTqaRqUuRIJW4a//IcnKc3Db8Iurd9Yg1U+kGFuTEhden9aAys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLMbOwlkW1HCtEMSskRhOlVGnYpnw2qGSr3senMqmkMXCYiV4
	UcHIlqsMOYAljJPEBIyZTub7lWkPpQsltVQw/+73cjK80ug2c2aJx/Rl
X-Gm-Gg: AZuq6aI3NdIe+35lbjRtkYrKjO2JkQi06JqjghphV89rdYpTjb3Lkr0SEinBmpSegg3
	qOrDfPmib5A2hBTaDlYluW1CPOTpLJwY45XsF64KyWTJJpgRl7TzODMpzAZqqewCs3WaAbZa7dE
	Bnk83llXLjhxoP6/KBViOuiqf8agRAarzmfEmly1XifXoY81fUhFE4BUSmWv28Ztrlt6Z8SGJNX
	aiE8d9cyIWUqnBOXTUCm6BERtptVnGnbgh+DxewO9JYcVHhc6YAdOui2RDOKvE9vc2WJdcqbOU4
	dhwYS4A0shwLI3e4rNPNxWMkIifMJVeUtPnwFi0mt4W+RXik3mPSdlyBH4n5FDf0c8A8gIWVFfV
	xPO+EMSMl3WJsND9YMcTga1T41PY3KQaGIKS5j+ii8AWqyU5pAC4EkFe2mzI4VWwGwqKrI17l4w
	Ezc3gGaJNL
X-Received: by 2002:a17:903:380d:b0:2a0:9028:11af with SMTP id d9443c01a7336-2a7fe75c647mr48658585ad.59.1769225527714;
        Fri, 23 Jan 2026 19:32:07 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:07 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 04/13] bpf: support fsession for bpf_session_is_return
Date: Sat, 24 Jan 2026 11:31:10 +0800
Message-ID: <20260124033119.28682-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 4BC3B7C573
X-Rspamd-Action: no action

If fsession exists, we will use the bit (1 << BPF_TRAMP_IS_RETURN_SHIFT)
in ((u64 *)ctx)[-1] to store the "is_return" flag.

The logic of bpf_session_is_return() for fsession is implemented in the
verifier by inline following code:

  bool bpf_session_is_return(void *ctx)
  {
      return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
  }

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v11:
- rename BPF_TRAMP_SHIFT_IS_RETURN to BPF_TRAMP_IS_RETURN_SHIFT

v10:
- fix the wrong description of bpf_session_is_return() in commit log and
  comment
- rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_
- remove the definition of BPF_TRAMP_M_NR_ARGS
- use 63 for the shift of BPF_TRAMP_SHIFT_IS_RETURN
- check the program type in bpf_session_filter()

v9:
- remove the definition of bpf_fsession_is_return()

v7:
- reuse the kfunc bpf_session_is_return() instead of introduce new kfunc

v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/verifier.c    | 13 +++++++++++++
 kernel/trace/bpf_trace.c | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41228b0add52..29eecd79352e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,8 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_IS_RETURN_SHIFT	63
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0fa73d56cb8b..d04aea235a12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23011,6 +23011,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline the bpf_session_is_return() for fsession:
+		 *   bool bpf_session_is_return(void *ctx)
+		 *   {
+		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13f0a2de33b7..f7baeb8278ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1286,7 +1286,8 @@ static bool is_kprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_kprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
 }
 
 static inline bool is_uprobe_multi(const struct bpf_prog *prog)
@@ -1297,7 +1298,14 @@ static inline bool is_uprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_uprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+}
+
+static inline bool is_trace_fsession(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_TRACING &&
+	       prog->expected_attach_type == BPF_TRACE_FSESSION;
 }
 
 static const struct bpf_func_proto *
@@ -3341,34 +3349,39 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_START(session_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_session_is_return)
 BTF_ID_FLAGS(func, bpf_session_cookie)
-BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_END(session_kfunc_set_ids)
 
-static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) && !is_trace_fsession(prog))
 		return -EACCES;
 
 	return 0;
 }
 
-static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_session_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set = &kprobe_multi_kfunc_set_ids,
-	.filter = bpf_kprobe_multi_filter,
+	.set = &session_kfunc_set_ids,
+	.filter = bpf_session_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+static int __init bpf_trace_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


