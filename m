Return-Path: <netdev+bounces-253011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBmmAsQ9dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:34:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D47C58A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 782713056CC4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E93260588;
	Sat, 24 Jan 2026 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS6IdWkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504720B7ED
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225538; cv=none; b=GttdDkLzg7t7qZ9uGYROlwgpA1uDsvFNo80g9PZi+UCWA8ac/pH7g4wUlUvCFoPZgZwxPzeuIkU0A3BHBuGXhlllTQ/TD54GVSc6Upt0pQN5rgshTxANuGfnXLhrMc8b/0EAqiITieOIz3twAj/kvA3xoXGKIYkzM2mdIBkuXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225538; c=relaxed/simple;
	bh=kjcr3U+Eej2jkvLdErMnd6YR7FAn98KttpJB/4PZM7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJgtNsLjxevI+DwuLrBWU+3D2YN2JwQKsWA+22q68139nTgQAamPFkZTPk9q7iWc9wm5kWFyNZNtP1V/1q0aKPVK5Gjh3c/ZCEOxyZAdpvstRVsgcfxQWWdYeSIKVKaiQqgZzl7ENXAcFXqRCeLJV2LN1Q6cRVT1oqlTcbeZOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS6IdWkj; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so31933555ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225537; x=1769830337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRFPc/7UJMwRjQVl87T1d/8z+6sYjAGIhOZdpUb7X2k=;
        b=eS6IdWkjCUdqG9J8pG3uEMgxQGAr9KOVpwPoKUHj3GbIh90zP22hIvD9YWdiCsnzPs
         wwY8fwoG7Nxhjs6dGwGX9lbqdO/BYvac69UB5pEyq3OYo58R97ZPfOlcLCHPbPMAk+UQ
         qrQRaoH/ZnfGtgrFsrLT7tUGX+F99dfj+vHVBCL3qmHfSP36c5rsP/3YZ8rmtAqfjdX+
         IIg8JtbMMYpgfFYq2sKb//pOECAevwd/pdMsaR7gslVsa7VqOxjk0U/0Fq/vyTrJV7lf
         74vJ9cLYvKzUE2A59yVE/r7CllnrkmCOEM4/awtYKEaCGFgjtDxyAwAzign7SSkyRFdV
         9HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225537; x=1769830337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRFPc/7UJMwRjQVl87T1d/8z+6sYjAGIhOZdpUb7X2k=;
        b=iZLwO7BgJjiWLvzY8h452oKYtnMYH+Oe/EuTQj7tR5TkSDRwziNWh9JPLt+HK5F2bF
         ECORdXBdsGRS8vYr87yUIlHFQHML0oAde0fc2DKfMsRSgXAjeX+PtDvDX/UkxPOW3zpg
         /sTGdY98vTvGBKmCzRCIF/mZRqhprM/rcWxDluFYmK+9a2y68yI33I5m+9hwJW0QlbGx
         nrLgUDBsZzyEexaVKrfKIUiLIOzcpVUhy7p2J4b7mVzowDfu0QfAHxavN+5mhB6ii4Tg
         TfY9zyxOHqjnG2iehIf2K/kuHBymH0nU2a997Pqjdqp2KH5Nwb1q7Qj0RZTe2ltaPY0u
         BscQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSLNChaDr6T91ryA60BdO6V88alnkEWIysCMqf0FUI2rA2iEPKxSIZNx/0QCoX04PoiB13/SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8MPR2a8BxPTMIldGYTozpFGfSkMlxlRqKY11i2iicJPP+owB
	YQOT1bxxomGUQKMiBkYr0JuJZNFeFEkqX7Hh8fUHMwIdJLtD/9nw81k5
X-Gm-Gg: AZuq6aL8NSwI5arCmqATHplSxoDXi+881L6xGbANfPwNvzXVD4DwMZL8McF9ciLqRA5
	s31cWVucdZpsX3AZMxM3xjT8ZtNecv3JnSwMy93BouuehBJ/3OpaUZQA87Pba+jDOCAokEvV/P3
	WuT3XHrPw6k/4okF7zSS/b8O0JH9qFMNefkJYGze7SCqBtXalT00W/L/YFN9l63vA7Prf/hmj0a
	hEDtaNNQdKur86BzElK/JtPJpC4FLpM/OmH0iq1xMN8eDitx8jNaDyvNV2QKecG0TUxreLGVj45
	8klW6+IcRhqdI5GwFNIxCqshUh/EiOtMHloCMnObMYqkrugfygjYd2D5yxvoO4GoLTNwsF7xYgl
	RBAb8QjG1Zvo1kTBGJrnJOLijkOnsIvF5kjuTrGIZbrZul0TiEKIbKwzvZKblfyPHm23fI+gX8V
	7h0jlvOCvu
X-Received: by 2002:a17:902:d2ce:b0:29f:2b84:652b with SMTP id d9443c01a7336-2a7fe625ffemr60090195ad.29.1769225536593;
        Fri, 23 Jan 2026 19:32:16 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:16 -0800 (PST)
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
Subject: [PATCH bpf-next v12 05/13] bpf: support fsession for bpf_session_cookie
Date: Sat, 24 Jan 2026 11:31:11 +0800
Message-ID: <20260124033119.28682-6-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253011-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 812D47C58A
X-Rspamd-Action: no action

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
units, is stored in the
"(((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF". Therefore, we
can get the session cookie with ((u64 *)ctx)[-offset].

Implement and inline the bpf_session_cookie() for the fsession in the
verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v11:
- rename BPF_TRAMP_SHIFT_COOKIE to BPF_TRAMP_COOKIE_INDEX_SHIFT

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
index 29eecd79352e..4427c6e98331 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,7 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_COOKIE_INDEX_SHIFT	8
 #define BPF_TRAMP_IS_RETURN_SHIFT	63
 
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
index d04aea235a12..c2f2650db9fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14406,6 +14406,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -23024,6 +23027,23 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_COOKIE_INDEX_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


