Return-Path: <netdev+bounces-252662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGymK0slc2nCsgAAu9opvQ
	(envelope-from <netdev+bounces-252662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB071D0A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B5253010915
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58530E0E7;
	Fri, 23 Jan 2026 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzg9M5MZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663032936D
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153789; cv=none; b=i1lVCebZxTfjvHFrZbYtYxH6zwnuZzTL9V1ngZ79wc49sVgZkfQyhuZDYRwxhPQzwTx2ISxogiGvt12ZxnflJ5eGeWbJ1UAnZhy6wY6fDhe58xeBlER6qHZxhSwWwTm8Ppx3h47NG3ErT7A3/UcZKYnFHjmnrp1ctSJhzPYCAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153789; c=relaxed/simple;
	bh=vSkpBZEvrCOR8Y3iysu/OMLokt70OFbWQweW9dndaB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCzrSE8+bNnYLHzyDvmJ42rlYH6OWpYaIpvdB6v8AbCIBif/eVKKoNLCYCY2jEBSnf5mVffBOOmac9pLjzmyxGzFQc4ok81AAG1ocFjV1JIk9754wE1MaMB48CckEmD8ykHG75ZSOTlSg09BK92SeActtpfceQWZoNG/r9MtNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzg9M5MZ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so1636298b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153786; x=1769758586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lQ/Jj/JIfTtpegaG4Os883WpJ5VAXhTKAEFAxgFaVs=;
        b=Mzg9M5MZ34pGJVUO9nHsRxwSCCm5gGfGmfAkS/6FM2mmAFSRD2dtoYJBUsY+CGXCzj
         TrNMI6FQoqt79RLmgjUWwkPWw7GMZ3vCSbGvJna/1x8Zyk+UqWHSca5Gl34GecLDQ+uX
         0XINjbUhWVWgrguaegI6adDaujdRkF9HsBe+gX+SQN9iXJxeXDew4ftN5eBvYGy+ITDR
         WnG+jwgcrTjZhU/BFaciG+ipklJQZiCqd12Is/jJvSxvbjNz4/GAn/qv4sejNcvWojus
         OMGxwFCFv952kDC6EvwwWIRKWaEfNBn8XR1hPt0yip77NMfUKdJ2tCgTlbqkCJZENvk3
         ZhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153786; x=1769758586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lQ/Jj/JIfTtpegaG4Os883WpJ5VAXhTKAEFAxgFaVs=;
        b=qJbp7P+4h0jaeqxjCkSxdI0ADYNdktbYMjLuyXwdoeOQE/60v932URFNzuLSWXi5kq
         xghMpA2sbAxIHVMVe098IZE5zSYB/ZDlrMeR+2+8us0E3fAILyMalER9yHu9EqdN8TyO
         QwqoWeZVvx7H98JQldIc9KrEiuvEOAf+5c25+iYF9XpDzutTsz7DjNq/UkyGNAjCv6sh
         NREzgW6yUr9Oz7T4Ubl0f3LTo0KupnmUYGHE/S8+3/EV7NWmkVr9LzrSy8an8Wh6TTCo
         ZzoVqAHFI+Ki6ZG9k9CYw6x9okoTnvD+3uSxk+uViIAIVmu5M7HRWRgax8ULk2UhNj14
         rBBg==
X-Forwarded-Encrypted: i=1; AJvYcCXcpUtab3DRSh060k5zZGdFo29p7z7K30wODm7z5WWJbM2SfWaOlp0aTFRY6BE6pS3G1znV0vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+yH+AVGyrIYfzsoKftPK2dZ2Gz452ldiPq/0ohQERszNeANb
	Xnl/C5uwZ8lCuacEoQbyXH3Gpbj0SyM0Ck3DtzgLjklMzXLPNZ7gt1gp
X-Gm-Gg: AZuq6aIeKCpevDF99WMux5+vl2VHuldKCFK48EwyJSsRt0DVRnlySsZi07BtsC22XCH
	gIdw7HjVVPrNqLhPruRy7K3Ub7TLnVM1fKLIEDxMtmchffRODcsmJlxuUkKrZvW2ysLZ1AYm+bV
	+l4whdQOHy4Kcl3G2z9u3M4qOCYjVycyjQ58rF8rGC7PafyhzoWcUC0hhT37mTBGwsACzrSon2V
	UBrMvl1wdgoW1jlmvisCDrxc6z+UJlUmfD9geL4vl0a98X5pMRFhanPr92J13vaSpOgOxkzj272
	3KHpFWV9z/v/dvyN3Q+LKG6ZEsBSX35QiPh0pGaeHCRbYJURfBy5wweWjCwNnp/evV8gY3b4kqC
	D9iF3K//WIj6DZ9d7cXSn5O9jJ6LvOI63aYRaKkorsgwvVL/cRB+ElOO1oFxJO0Cu5rdpe+S0A0
	IvgVBTdnXu
X-Received: by 2002:a05:6a00:2d2a:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-82317ee84f2mr1955826b3a.49.1769153786089;
        Thu, 22 Jan 2026 23:36:26 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:25 -0800 (PST)
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
Subject: [PATCH bpf-next v11 05/12] bpf: support fsession for bpf_session_cookie
Date: Fri, 23 Jan 2026 15:35:25 +0800
Message-ID: <20260123073532.238985-6-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252662-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1FB071D0A
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
index 2ae8f29b854f..1f171ac3462e 100644
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


