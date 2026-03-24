Return-Path: <netdev+bounces-271227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDFBJ0rVwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:17:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BC31A9D6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 884C33001A79
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A537D103;
	Tue, 24 Mar 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGEuthKq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B337B400;
	Tue, 24 Mar 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376216; cv=none; b=PPUPLRtJH/k+wyhnNtvr19R38vwqQ0BPAjLhyJTbB2/7dJRRAcXJk9ROq+vPPv4WC7vNID+CFR4g0eaEUIcJQxw62ExRUMdFzNudOOSx91G+8VFhkPiDOwYygk0R21b1wr6VB3383ayYPHxXztJoPblUZzdIaSlKWeNsOAfPbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376216; c=relaxed/simple;
	bh=44kks2Hupy2PXIuwsM7N+ABSrDUKzV+bhx8Hz1JtAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFHueTxtZxiGgYp7oXY0bKaF5R6m5EW1ai84Js+JYpATTwNgNStGvznI8wan+eCzd9JHuMbPUU99p2yCqq4/qaNtmNKEuMlHlMRZ245A8cBh6OhZnRz62nQubVAQUkr6CVVPklD/e9OSAms+IjH21UlTdu7Jdmips8sq7ml5eFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGEuthKq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774376215; x=1805912215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44kks2Hupy2PXIuwsM7N+ABSrDUKzV+bhx8Hz1JtAcg=;
  b=HGEuthKqfi+gjw7yTlfHDr+ANsQesn+Nn76NzolLIzDQuMwRCREroWYl
   7EBHqNFpBTpwTljvGwM49CTtTAD6B7RaoC7HxOmgDLJIT2r3fMK/ExXV/
   sHpGsJUPOa3gcrNNqv7of2/xPbKAwg+reME708kWnS0yeqzV3ViWSR3Jl
   biyM5/45bYeckK5f60RB/0NePSq234vQ23ODopD1tT2cbwSyjgii0fodc
   nAOVZ2yt1vQoAsYYxumypwd0K+FhQlCt6AsbbCFnPwhJNjRkGsCHBYciT
   mID2IZ//dqhwvSmoePUZMwWElQ8TzeRUOtrTyuB96+sOnGwhV6N7N7Sod
   Q==;
X-CSE-ConnectionGUID: X/6oGqDaQMmS2m7HFYZkPw==
X-CSE-MsgGUID: Vfxugr7zTomFaVoLILCAJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79261575"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79261575"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:16:54 -0700
X-CSE-ConnectionGUID: HFi0EA1VRl2RlV6R1Q2qYw==
X-CSE-MsgGUID: xT/ewu6PToS/Hi9AYvILiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="248012771"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:16:52 -0700
Date: Tue, 24 Mar 2026 11:16:51 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on newer
 CPUs
Message-ID: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:dkim,intel.com:email,linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793BC31A9D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a mitigation for BHI, clear_bhb_loop() executes branches that overwrites
the Branch History Buffer (BHB). On Alder Lake and newer parts this
sequence is not sufficient because it doesn't clear enough entries. This
was not an issue because these CPUs have a hardware control (BHI_DIS_S)
that mitigates BHI in kernel.

BHI variant of VMSCAPE requires isolating branch history between guests and
userspace. Note that there is no equivalent hardware control for userspace.
To effectively isolate branch history on newer CPUs, clear_bhb_loop()
should execute sufficient number of branches to clear a larger BHB.

Dynamically set the loop count of clear_bhb_loop() such that it is
effective on newer CPUs too. Use the hardware control enumeration
X86_FEATURE_BHI_CTRL to select the appropriate loop count.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
 arch/x86/net/bpf_jit_comp.c |  7 -------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..8128e00ca73f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
 SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
+	/* BPF caller may require %rax to be preserved */
+	push	%rax
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	/*
+	 * Between the long and short version of BHB clear sequence, just the
+	 * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
+	 */
+	ALTERNATIVE "movb $5,  %al",	\
+		    "movb $12, %al", X86_FEATURE_BHI_CTRL
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1556,16 +1565,18 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
-	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+	.skip 32 - 14, 0xcc
+2:	ALTERNATIVE "movb $5, %ah",	\
+		    "movb $7, %ah", X86_FEATURE_BHI_CTRL
 3:	jmp	4f
 	nop
-4:	sub	$1, %eax
+4:	sub	$1, %ah
 	jnz	3b
-	sub	$1, %ecx
+	sub	$1, %al
 	jnz	1b
 .Lret2:	RET
 5:
+	pop	%rax
 	pop	%rbp
 	RET
 SYM_FUNC_END(clear_bhb_loop)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 63d6c9fa5e80..e2cceabb23e8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1614,11 +1614,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	u8 *func;
 
 	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
-		/* The clearing sequence clobbers eax and ecx. */
-		EMIT1(0x50); /* push rax */
-		EMIT1(0x51); /* push rcx */
-		ip += 2;
-
 		func = (u8 *)clear_bhb_loop;
 		ip += x86_call_depth_emit_accounting(&prog, func, ip);
 
@@ -1626,8 +1621,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 			return -EINVAL;
 		/* Don't speculate past this until BHB is cleared */
 		EMIT_LFENCE();
-		EMIT1(0x59); /* pop rcx */
-		EMIT1(0x58); /* pop rax */
 	}
 	/* Insert IBHF instruction */
 	if ((cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP) &&

-- 
2.34.1



