Return-Path: <netdev+bounces-300891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FICzOiwgOGrGYQcAu9opvQ
	(envelope-from <netdev+bounces-300891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:32:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABD6AB5AF
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:32:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Wsm/PWVd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300891-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300891-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BD93014643
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B02ECE86;
	Sun, 21 Jun 2026 17:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D014281530
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 17:32:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063143; cv=none; b=mt0qQjdsGFjqsPFr/v1alFfU5YTuTdJNldV8MwbqFhnP3pPZrJUwxh6GTWCjtooGYR2WWpJpKqO/1cffSG+wnFgV9/o6X2qw+vYoSuG41Y62/Q+dAlLMBjeKY2FgvAbaEzCuUwg7UsyfvzCVGQ0tvYJ4i1fBxkTwoh5ZQQnpQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063143; c=relaxed/simple;
	bh=aUM92AgbauHV4QyBzFMhML/6iVhA0DCdmumoaxdeZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2RmfW8hI0gIP4WYnSEecywH4MNcvz8ceHneFVTrwbLlKQeI1MbIReRosGaWbPc+coaDD5TcurgD9eAHhmH/0RLFhawiPqlAvO7MZRq8uXZ5vDg0nTCXsrAhyGaxKoQ9D1BO9FxEsJLbO35mVfYl2FyEl1wYI1Lfbg/xansQ31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsm/PWVd; arc=none smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137eb0d76beso3209831c88.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782063141; x=1782667941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpjCT8M88BJGwAnD5H4rYxvEvus9dyd0UVGo/IMCVqw=;
        b=Wsm/PWVdSw5Tv62M7IOace2yqLPmtr0nMXALquGEpdNxSZG8HIoShvD0DO05ijkm0Z
         R+0DcT9RopJO27HZeTRPou4O1cnWvE8UJaAvqeXNeN4l37KR9K5Hmf6nuW7zMImnYT5A
         2ATeRRwlJW+PYVyPD8etfwwLSMhOv/ploVEKHIGByj1ewizslATm2vH7iEAC4SRPSECF
         Rwb8PZhRD/5zODJKllBaBoISAcgsiBA6UV9kqLppl79obUSad8Fui/aMnb2O0Vm8K0qE
         rR4uEue9mm+tzdNr+ZS799V9YKXHNjdqcGCnAW4UppiPduG0VO+xJYqzyX+WA4C6egXn
         MDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782063141; x=1782667941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpjCT8M88BJGwAnD5H4rYxvEvus9dyd0UVGo/IMCVqw=;
        b=MzYaif69M6I6Q9rpZkIUYisC43184t91l0uPMKSNVycv0q/ZcoWs3zmM8fnInaGV0z
         fou5JGa1cYxNAfFzVRjjeTlL/iiH1VedJ5+YdPKh3rwVabtPWV7E4+i43uibykUgTgHC
         UVSFZeB3GEFjEaCPwgwysBlYVZi8nk3WtSieiW/ggmPAIIBEiPG1q4U/BSIa9hyq5Xmj
         jAg46yXo6seNXIlVm8iEo/pB/mKIwIqn1SQPwiy8a3CQcsuSPqeyf2ZPKkgmb71fxOuM
         hRqGD+mGMAZlbqHwdYnGHbBFBXFJf9zYNaRZ6egI1eezjfaLx/OKY6fa01zH75hk9bUj
         ufdQ==
X-Gm-Message-State: AOJu0Yxr8WICaXpL91UvU0H2X6BgPUNdpgsiupK4/EgMXwQOikmh766O
	x7GaCfQ5HRwwpAM1TAJs7ONj+SpKJvaIVZAOoyY3dPfBqf3hhTfiSNMr
X-Gm-Gg: AfdE7ckLCcBuG9RZCNnoewKn8HZ6Ki5J1rpd5sLd5u5gwdOOOxbMfisJrXCRfJtpTOf
	w296EIeGkdWrjX6RxJpG4zoKR/N6Q1PUSbwcxcz+2rENcMXsGqP3jE+8xOtLmpGwZ7+iTGNsogf
	dAjGxZn90uNUWcG5Y8L7eNJcPn/ggLgA0CDoZM+Zrou1rtn7tdQBLNQHKDI7LoNlIA0fP8/RUCE
	/CkS4TBSH1UcK0A/OA1WAlzSkBuu5cky7K6xhQSt+QCw6FvMsMh2Kadpb4+TY/c1I5euSy+dtU9
	VOUYcvmO10zfmCtzPNvsSv6xTIIaPsmcz5xgLSQf4qNYWhDA6sprkZmjBzHMx4bup/DtNRVs1jY
	NrtIk+yRWYMHY3Z7Epul9bDYt32meT0D7Grmx8oSzA5b1OHeQoPMwWwZduzbc9iEzMqDLk9lifJ
	FlVdGnPyUG31NhtsS4OzNdBHAjNDmsCTjUVA==
X-Received: by 2002:a05:7022:626:b0:136:8b76:14eb with SMTP id a92af1059eb24-139a31185f4mr6140349c88.14.1782063141014;
        Sun, 21 Jun 2026 10:32:21 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:32:20 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v4 3/4] selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking
Date: Mon, 22 Jun 2026 01:27:34 +0800
Message-ID: <20260621172735.409355-4-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300891-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[r0.id:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,r2.id:url,r1.id:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41ABD6AB5AF

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit bebc17b1c03b224a0b4aec6a171815e39f8ba9bc ]

Add a few test cases to verify precision tracking for scalars gaining
range because of sync_linked_regs():
- check what happens when more than 6 registers might gain range in
  sync_linked_regs();
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and one of
  linked registers is marked precise;
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and a
  other-linked operand of the conditional jump is marked precise;
- add a minimized reproducer for precision tracking bug reported in [0];
- Check that mark_chain_precision() for one of the conditional jump
  operands does not trigger equal scalars precision propagation.

[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com
[ zhenzhong: keep the linked_regs_broken_link_2 reject check, but
  drop the mark_precise log expectations because 6.6.y does not derive
  the scalar-vs-scalar range for that non-constant JMP_X comparison. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index f70392bf696c..2eb85eb3a06c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -47,6 +47,72 @@ __naked void linked_regs_bpf_k(void)
 	: __clobber_all);
 }
 
+/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
+ * check that verifier marks r{1,2} as precise while backtracking
+ * 'if r1 > ...' with r0 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_src(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that verifier marks r{0,1,2} as precise while backtracking
+ * 'if r1 > r3' with r3 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_dst(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r3;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
@@ -280,6 +346,102 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check thar r0 and r6 have different IDs after 'if',
+ * collect_linked_regs() can't tie more than 6 registers for a single insn.
+ */
+__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+/* check that r{0-5} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__naked void linked_regs_too_many_regs(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r{0-6} IDs */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = r0;"
+	"r4 = r0;"
+	"r5 = r0;"
+	"r6 = r0;"
+	/* propagate range for r{0-6} */
+	"if r0 > 7 goto +0;"
+	/* make r6 appear in the log */
+	"r6 = r6;"
+	/* force r0 to be precise,
+	 * this would cause r{0-4} to be precise because of shared IDs
+	 */
+	"r7 = r10;"
+	"r7 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("div by zero")
+__naked void linked_regs_broken_link_2(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r8 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 1 goto +0;"
+	/* r7.id == r8.id,
+	 * thus r7 precision implies r8 precision,
+	 * which implies r0 precision because of the conditional below.
+	 */
+	"if r8 >= r0 goto 1f;"
+	/* break id relation between r7 and r8 */
+	"r8 += r8;"
+	/* make r7 precise */
+	"if r7 == 0 goto 1f;"
+	"r0 /= 0;"
+"1:"
+	"r0 = 42;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Check that mark_chain_precision() for one of the conditional jump
+ * operands does not trigger equal scalars precision propagation.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("3: (25) if r1 > 0x100 goto pc+0")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__naked void cjmp_no_linked_regs_trigger(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id */
+	"r1 = r0;"
+	/* the jump below would be predicted, thus r1 would be marked precise,
+	 * this should not imply precision mark for r0
+	 */
+	"if r1 > 256 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Verify that check_ids() is used by regsafe() for scalars.
  *
  * r9 = ... some pointer with range X ...
-- 
2.43.0

