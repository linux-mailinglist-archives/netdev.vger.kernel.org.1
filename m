Return-Path: <netdev+bounces-305632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EmpmJ7y8TWqJ9gEAu9opvQ
	(envelope-from <netdev+bounces-305632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:58:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF272143C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:58:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U34DRz1Q;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305632-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305632-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C1D3018409
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5143B993A;
	Wed,  8 Jul 2026 02:58:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DB3B774D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 02:57:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479480; cv=none; b=CGvtNdwVWrT4VcasMEuu3m83xTIidnY/ev2b6BWUJ9CJWrPnigkPo76c/3lmpKf1fmXCEmxqgDYsx0stWAYZEJzkMk9ZXbXvUVHC7Y1gHaVPO+BKh3urtab9gKwomyhi11mfrczHc3gDmZv7rZqWvg330leypoUc/nC/Nnb/cA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479480; c=relaxed/simple;
	bh=3j56XRit/D5wuYL8ciIptQ9YfsZGFgj9aMucYagHQRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSVul2dslbuZOagSUkIM76FeffkXOMu8Hd3pDNZe5vjK+ZEf/kdAwyX+z3uXMWfqwXrnlJ89N2xWpb0vDl0VW60u3a2uB9NiUZfTIEBFV8L7VCC3nElhHlapCHBFAOZU0xkN23j17rAq2SWLzlY/EJaRaolBDQ0hkpBPghsVb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U34DRz1Q; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so1432236d6.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479477; x=1784084277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kWZHyi+T+vyeURiAwf3NckMe8YMnDEn+Lis3dCslKy4=;
        b=U34DRz1QfXj7RcCG52IOUrymL1jAB3ILopNIj+nROKyIhEGMDX46eXxeLSUicoLIl+
         aRdR8bB75PNgtoNdXjf5d3ehc328hr8BZKhc72T2wEuFsRwnTxWiy7uReqxJdVJzqjsp
         JkVZm4Sj3jU57kX2rcfPZ1IYflWkwF2mRUpwTySAKmaIC4+KilJaf416Uc4gVN1ioHX4
         G0Rb/D20ZWjTtEX5iJNmlac7LswQP7PRMhu2BboK7Jk7scHXmM50Zrxubx3hHJ1MZrQd
         nrC6qiAPSuO2NQX0ALIQ692UX55WMOaMYYR0arifSEsvYsD84HI5aYJ8sfGSlE4GmzRj
         Otig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479477; x=1784084277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWZHyi+T+vyeURiAwf3NckMe8YMnDEn+Lis3dCslKy4=;
        b=VS7BPwOqkQY79pQRbY6OnmLvtV1L7yr+Q96rHEfK2wHwxGphz9C5MWjdKflTqqBT1b
         nUr9W+iT3NLyakyneyGQmkA0UwBjTFO+ebAgNGP1PcijEWmkBw6mJU/bPhiXvlDEr7jz
         sN1ihBb6o5aMSblMXbC4gksPnK4cmWy6Ju722FSq5cB4lguh5dMOawEyM5/jSupgIA8q
         naPHCQkzAU8l/Ksn+wUbWPML89TV8wqeupWXqEdmlSjnC7zN7cmp1pKfdSW/5tKNf62B
         bMw1/deN+uwU3ZqiYhQPf3GUNzU0CPMKTmXZPVhWg1/XPCrAz5LlF/75qkIpeqNrdVs7
         BWlw==
X-Forwarded-Encrypted: i=1; AHgh+RoEQaEI3LusoVEAgrO9EnahqiBgikyhNXpDlLA+2qsnyCLFjsRMEsVK+5Qlk58x4SgjvhQbCvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzog9T9oGj2+SGqoyPJ8ewjGqsD3I5/9UAcAdGCRqzRw6bmxUom
	No/YXEtCujP7olW3EtoVfpSiOpAuxDF8nFPAiMZDnmQyaLbv334k9zbu
X-Gm-Gg: AfdE7cnCmph957eW5/yYpbCT/rj8ZiHnHRhf5mqvJxwzwCyGhIRfAAPU2NAKqHabKqR
	M+DPA2wgGrMGOgGiZRmQu1nwPMSFu/i0tldJmiMJvxFfTxjfS3GbHLNhJ/djhDEO/e0wXzLvWZN
	s7fcRLtOkE0Az+9yPujozYMz8X89hiTRC6PD+5M2y14ObmdiP9W9LGOHuVcTeNSS3kcDDPyft0L
	9uPMbK83iFMgvpMFVtrB+e0fKYLuGbIm6iySN6ZK/gbmCQgTgLUpvf2+7xLDisZ7X1/9RNlASwe
	mfjiTlLWz16QqOveF5lKGm4Fu2dI8bgCCMUj3uFT4mVSEPrtklRP9zKcugrSc2smQWsidBRKzHb
	O+g/LZ53uwVgFYIyYayKflk6MhuJcgOV60oILZyOWXsNQw2Cl5nz5WhsxbQHbqBiIjkkiWWBqHE
	tr3ounB6cgo+MdwwuRjVw/sZ+kpgtc/upa3mtuWb+ByY+Y8rBhCT6KvVozJr4OWLqPs3c8RX8Vv
	nd4mUy4XXIxWAk=
X-Received: by 2002:a0c:f405:0:b0:8fd:6de3:dd8b with SMTP id 6a1803df08f44-8fec3bf69e6mr4016686d6.65.1783479477529;
        Tue, 07 Jul 2026 19:57:57 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de83f8sm175762936d6.33.2026.07.07.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:57:57 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf 1/2] bpf, x86: Fix FineIBT #CP in BPF dispatcher's indirect-jump fallback
Date: Tue,  7 Jul 2026 22:57:55 -0400
Message-ID: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305632-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,redhat.com,alien8.de,linux.intel.com,zytor.com,davemloft.net,fomichev.me,infradead.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:peterz@infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:dwindsor@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FEF272143C

commit 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call") updated
emit_cfi() to emit FineIBT preambles for JIT-compiled BPF programs, but
did not update emit_bpf_dispatcher(). When prog->bpf_func is not in the
dispatcher table (e.g. an XDP_REDIRECT target program in a CPUMAP or
DEVMAP, or BPF_PROG_TEST_RUN of an unattached prog), the dispatcher
still jumps directly to prog->bpf_func. Without a FineIBT caller
sequence, under FineIBT this raises #CP:

  Missing ENDBR: __cfi_bpf_prog_..._xdp_dispatcher_unattached+0x10/0x10
  ------------[ cut here ]------------
  kernel BUG at arch/x86/kernel/cet.c:133!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  RIP: 0010:do_kernel_cp_fault+0x126/0x130
  Call Trace:
   <TASK>
   exc_control_protection+0x46/0x80
   asm_exc_control_protection+0x2b/0x30
  RIP: 0010:__cfi_bpf_prog_..._xdp_dispatcher_unattached+0x10/0x10
   bpf_prog_test_run+0xda/0x1b0
   __sys_bpf+0x70b/0x990
   __x64_sys_bpf+0x2d/0x50
   x64_sys_call+0x1079/0x2d40
   do_syscall_64+0x12a/0x3c0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

To fix this, we precede the indirect jump in emit_bpf_dispatcher() with
the FineIBT caller sequence: load cfi_bpf_hash into %eax and subtract
cfi_get_offset() from the target so it enters the preamble's real ENDBR.
Only needed for CFI_FINEIBT.

Fixes: 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")
Cc: stable@vger.kernel.org
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de7515ea1bea..1c8249d8ca3b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3740,6 +3740,15 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
+		/* If running under FineIBT, enter the preamble so the following
+		 * indirect jump lands on a real ENDBR instead of the poison.
+		 */
+		if (cfi_mode == CFI_FINEIBT) {
+			EMIT1_off32(0xb8, cfi_bpf_hash);	/* mov $cfi_bpf_hash, %eax */
+			EMIT1(add_1mod(0x48, BPF_REG_3));	/* sub rdx, cfi_get_offset() */
+			EMIT2_off32(0x81, add_1reg(0xE8, BPF_REG_3), cfi_get_offset());
+		}
+
 		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
-- 
2.53.0


