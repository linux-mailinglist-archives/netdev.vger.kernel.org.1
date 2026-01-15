Return-Path: <netdev+bounces-250115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2153D24254
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E465D3027E6F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8E3793DC;
	Thu, 15 Jan 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8vHIxeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1736D4F8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476232; cv=none; b=W9D2MIJ+RUr2xwaO2JEnQWqh1FMe9qBLpVuT8WShtbElGWRPwO4rTzjlG8/CHhDTUjJDTYoDeWCCiZG13KkdGexC8jIjSI24ZHyzNveThxLGZxZBYvZMAkakyczzgb9ccqWHsEqhRLLjb9JF+413RdQr+HkwGfyf+LISZb7dmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476232; c=relaxed/simple;
	bh=70uxJsBQdJTCq6o5pWVjXSAUli/F59boJa8Lmi5oQQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEU6OdFs0oGLDbY/7ulvrpEXNDqDviXpvKPgaNg+Ya1PAIoI9oet1UAtG9DYddyg8wSRwktj9z8pJdEMLPBn1KElN6G54n9x8vMFyixboA+jl3LSqb9m6AIx1wIt9F7D5ICY1HRa7AMk3YNZYB/J+3mTGppfEURlLBMMIKYDBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8vHIxeC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f0f875bc5so5754725ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476230; x=1769081030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/SVBFySwYnFgzCd+lOHdFqf2Vleur+xFZa5r+xY3I4=;
        b=M8vHIxeChXY7mp+UQdkoBlbjwbWelvJcygTzGlPVoZvJwMBZ3sQeiAp69m4YoLAvKm
         9CQ8N8GlmynHYSED0PPVXpEsOfA70kLoQMIlAzI1R8Bz0QRVJZN6tocxbm/l6wndiO0f
         Fr2xj2bKkUGy8X4+BOYbaO0bEBRXiR1td4UX0FzbTJc5WvCvdk7Q7C9Sdb0hXcXO6RhV
         +3hKmsRFlW8nzZnRwErP61QT1gfK49YguHXywvwVWunJow0hUvX+YE2QYyAiF7MNqWTO
         5eqoytd0r2LFDqIumZTHHczDSIENMyfvYuuXWfanrSeZO8OZcJs1h5dCDD7YH07odUJZ
         wp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476230; x=1769081030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/SVBFySwYnFgzCd+lOHdFqf2Vleur+xFZa5r+xY3I4=;
        b=G4X8TIONjHsiZT5ccBo9cbtEgpYbV8TgT+cwF1iAwJ7pZkq8cu5S4ekaiTSyUx+uPq
         0opHthL2wCEljXR8992J5taitrz0Zq6arPvutDlhfwvKp0VZ05YA8sTxcqY2QU4SKPoD
         aMQ0ASU/vvSUnC+ejbK4QPNzjnCDh/w9gHmMvCV4rY+YffrmREMymx2v20M/YqBFDfvj
         sSK+m94JYnFzUGPR9P28nHae3HKyPLWzTUtvWjkoiLY9rBhZ2/AI49klYYsw36oS2p4C
         CNAgbG/k77yu9SRUWxD/oFSbrO5GLnAM37god/QAiDXS7pofo0mhTTok1J2/p17sHU0t
         +CNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZZob80b/EdIqKpyNGBTKP9CK2u2s8+SBn67O9DkkZy998j19ra09dIbiDz+2WzkodZL+2S4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfLfxrbmtehQhoYULeZE2gy7Lp6LcW3L92OYerAej4DVrOV+X
	yM9WhS9eoPbJKioN7gj7x+rGzE5fOo04gFWwHJQ8jugsD3xR8mZq0ecl
X-Gm-Gg: AY/fxX4qlh5fiGNlKuxXOHZxCWJUiZfWR31EBgAOZzIZT+Zxql87Pw3ecB5lUSJwqrp
	qc2lXDBAEdADxZLDsmP7xNc+301VWN7mUYtZK4GDxsFSUr82ulhnTzKiK1eEA6Xwzouc0nQ08nJ
	dVZMD9MREfxPgMtfnXCx5EcPr/xsnWsa1TXarSgByYaIEH/0XZOqT5UQztUEiaQy3pl3Wo6vvb1
	h+sVs0G6ab1yJVn9Ed10HSxXd2BvD+SP4fhKQG/8KYY74Y2OoqCQaFQc/OqfyCTjDEsl4ZpIuBc
	PPRD9OGy+XUAvgFIr53QQ9jc3K8UNZZZmzhOVvRrerFhL52iRhWobweyFBMiyI+FgdrXrr5EKv1
	qZ3jjZck1rYDTvqhTpsey3u5AHJ+Rz3pAWrBRzC1HR89IMrNJpoSOghrz91bxs9TeBLZU4d+DEz
	N5jiIeSfc=
X-Received: by 2002:a17:902:cf06:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2a59bc61e10mr49446395ad.57.1768476230265;
        Thu, 15 Jan 2026 03:23:50 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:49 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
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
Subject: [PATCH bpf-next v10 05/12] bpf: support fsession for bpf_session_cookie
Date: Thu, 15 Jan 2026 19:22:39 +0800
Message-ID: <20260115112246.221082-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement session cookie for fsession. The session cookies will be stored
in the stack, and the layout of the stack will look like this:
  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

The offset of the cookie for the current bpf program, which is in 8-byte
units, is stored in the "(((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF".
Therefore, we can get the session cookie with ((u64 *)ctx)[-offset].

Implement and inline the bpf_session_cookie() for the fsession in the
verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- describe the offset of the session cookie more explicit
- make 8 as the bit shift of session cookie
- remove the session cookie count limitation

v9:
- remove the definition of bpf_fsession_cookie()

v7:
- reuse bpf_session_cookie() instead of introduce new kfunc

v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h   | 15 +++++++++++++++
 kernel/bpf/verifier.c | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f72d553f52b..551d2cb0ec7d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,7 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_SHIFT_COOKIE		8
 #define BPF_TRAMP_SHIFT_IS_RETURN	63
 
 struct bpf_tramp_links {
@@ -1782,6 +1783,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_session_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2190,6 +2192,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->call_session_cookie)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2efe458f9bad..3ab2da5f8165 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14303,6 +14303,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22617,6 +22620,23 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_SHIFT_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_SHIFT_COOKIE) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_SHIFT_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


