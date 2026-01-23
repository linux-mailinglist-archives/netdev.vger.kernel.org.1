Return-Path: <netdev+bounces-252661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNp/AIglc2nCsgAAu9opvQ
	(envelope-from <netdev+bounces-252661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:38:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB471D4E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 292B6304C07D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB42EA48F;
	Fri, 23 Jan 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyc0wtaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963832C95B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153780; cv=none; b=C0VpQrYkf8E82SiNOBePNNFY+Wd0uMEJncKhUin4+145upBKfqH5HZCheWm92EKEzQXlLdGYFg3aDCIfo75D5NXtjHIxqIMa0iFEzTbYwJrWlKwJ9eQDeFipqiYJU/qtlKqocwRQBZq1utYv0X7F/PrSo+k34RGuUeffMKppanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153780; c=relaxed/simple;
	bh=+LohW/5iZ/BTA3wEhODcalmnhVN7Hw9KbOPLybwo5cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvJxdrTiDQoRPsUHmaE4ezui07gTG8pmTzzVmPIs9tSSfR32nrq349bxRmyKq7wzia70ur9F0j/XPT/D06atYUcvhOssZcTUczbUXHo35Qr4GdNdEwpCeEJb9XekCTnPlsfEL9+2EXO5KLuvcMKwt0XKlNKCM6v/jlL9LPDh4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyc0wtaZ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81f39438187so1047128b3a.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153777; x=1769758577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zK61mrn2X2UJzXm7UaRNg+WFPm1j9ZsyaLN3K5LWzAA=;
        b=Cyc0wtaZTD6fQ+1bxDnH6I3L1JM32xAsnbfDk1pO3HPQ29OSS0Hsv1sBzCadgpN+tJ
         1U36eNY6l6qviNYwUYZ/ldOWSwfs0FVc6vHVXUeA6pLnT19O87xdc6+/+im9HmsuEiEj
         tqn63851rBCO/U24NHXgGA77DoEQKhYbU3YwGLxPlVhdy4C3bxmdo5NcRqXrf+3hYX/b
         oDZWTD/XMN0xZt+N0wY20eNtwMsjIPob2kQhtGyOOSq8dkK0XUZJzQD3gHSl6742rhq8
         uGA1NwkG7GFf9d+xKISs741cQoBDDZ6GntKkwEElhinNhl71QJSsL3+aszXzdKcmq32U
         ZD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153777; x=1769758577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zK61mrn2X2UJzXm7UaRNg+WFPm1j9ZsyaLN3K5LWzAA=;
        b=H1vqxqsZU+9GWkZtLh8JSku/eErkM0mTCAKZ3PF+IfLOPdXAF+c2SrvmxgnH77VOx1
         3/UfIq6gSfF+iPgO6QksPNaN/xwABf1eE6i8IeVNT7YECMuoIKu/Y87wIDlbaNmfn6tJ
         UFhNSwUXiYV4WijkJA9WcsUanbdfRj0tSEJnzIOoM4kBPzie7rTjodAr+9WDIrsjq98o
         +MsTojrisIdeoo9A70T+Et6NzqlzBXG+MdL9tifz/hQ45Smopj2YCRNoqy/sNCsHrDt0
         38v806jPKFVxyQDvZueA1ciF3sfLf76H2plYsb8fqvM2bvloa1bl6r0btm+hSJw3CRTI
         KBTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOyngzWFotZ/bI0kovO8bzmPInxMpSl8m6VLCuGyACvwcqp5Yj8p5siqyJlWT+AeyNCTsBxVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HiM1ehvy9rE+Jm5TqTH3pvcWVgqSP9741TWAjBMN+8uSv5KO
	NEtNqz+0c9GoPzzO2I+CyxfOS7gSSOLyyD7nUW4p1v3tovo47UUd+4T4bhD45YqX
X-Gm-Gg: AZuq6aLz1x1T+Bvnx6+FKnvUsgVh1a2/T8K8am4RRb7szCCtLGMGx8K80oNuksw3A0o
	vXDRXJtaMZDf2FctitobHolGqGKB4SrxHEY6NeyI2Vlj8kt5aUL4CufAalrcMNP8P6i+hhR1dDW
	O3INr2MA8ELQK1v2F494P+N6wHG411lrAeKRyKdL6Dv+ei/qvqwGoa3Lslj75G1+g8pYPvaRaFe
	zT7Ok8E0jggo8NT2dMAc581RrTVRH7rKSqaRt32NOtWNUdQZdecHnom0Ff6MYSYO9rJ9AdpHrce
	zhLnpsJDQ5Ng1QUdJDlLU2D4jtV39ZZPRtDwSgkSBRue7fOAAUbC5i7n2w6OQi/HJoP5au/vvwF
	lsvdszR4esRDo7R78WyStDGWIS1B6sNdV3jnsGgbDvkWORJpvY9e8W76mSXlZN8kNLdcPDzPJD5
	ABADvu5QGi
X-Received: by 2002:a05:6a00:ad1:b0:81f:3a05:8a7a with SMTP id d2e1a72fcca58-82317d23940mr1878480b3a.19.1769153777539;
        Thu, 22 Jan 2026 23:36:17 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v11 04/12] bpf: support fsession for bpf_session_is_return
Date: Fri, 23 Jan 2026 15:35:24 +0800
Message-ID: <20260123073532.238985-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252661-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 69CB471D4E
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
index 19fd16697262..2ae8f29b854f 100644
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


