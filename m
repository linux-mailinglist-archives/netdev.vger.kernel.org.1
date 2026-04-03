Return-Path: <netdev+bounces-274784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDzOBVMKz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E4D38F75E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFA13302A867
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3D221FCD;
	Fri,  3 Apr 2026 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyNIqkAm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240419D8AC;
	Fri,  3 Apr 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176251; cv=none; b=M5hZrnn3Ejr74qKvdMKIroY8sP7mmOCmNdLH5CTOr+DOLnSW3F953xx5Em9z3jOuY07EtAlpDBn3CwPNbm5BnYHY1bMae+IkUQDkYOTE4EOY4Op8An3onPkmYKO3qYU+J1wvnAG/+/7GYqzn3NiaoWzY0X58CdQqHEb28tHEy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176251; c=relaxed/simple;
	bh=UEaAzxTV5k9qgAQSvHOrlSueZGJf50PP0Vc880X5kxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMnfQA0Yu+BVm8dGMtEr8ViP1PJkU3E8mCKTbQzE/CRiRwxKhegWAPAZ1zJ+SPBqbA0XwC9Of15Kn8RPyuOGp7zOxq8gHoIAugScxe+oipNokZ2E6Ne2VG1FcRPZ1Fg7Cjl7+5yHDAK+XVwGa/Pecc/MIfdKm/+HXtZqXUBiZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyNIqkAm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775176250; x=1806712250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UEaAzxTV5k9qgAQSvHOrlSueZGJf50PP0Vc880X5kxY=;
  b=hyNIqkAmNJOfNGaO1aR1OrxifzUGlFj4iV771dXVYgyTW25V+7eQjRVB
   eDqmU2Dh16BbvXQtRa3ET7okFIU7EbkFOy0k5iRIYuI6yv/vT5VTNE5Ee
   fkBzuwZ7a+evpUdOLDrOTYE39Z9/Z8wCVvN+/JQv20eHBO4/rqkgxui/F
   xWszNJqINzwHskGuUJtZUQxgGs0xH0ebJRIDpxvCZgKKUqS+IjMyDgiOu
   MH77nkghOJFMJTi9QaOXIi0i8Pk+gvys1xpxwbR+GetZjRCX8pl+jeRiD
   YWq+lNOADspAfJj2VHAOUcJ79F5gTvoc5RMQG9zs+jThsBDhjUUdp9wqx
   A==;
X-CSE-ConnectionGUID: FVSv3JBqTF6tes/nLaWvQg==
X-CSE-MsgGUID: 5BEg14AHSK6EMZPGAZFE/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="63794162"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="63794162"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:30:49 -0700
X-CSE-ConnectionGUID: DWJutCRWQCywqqZMdG5oYg==
X-CSE-MsgGUID: rlnQxJSPQPGZKAhZ0AnTxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="250191117"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:30:48 -0700
Date: Thu, 2 Apr 2026 17:30:47 -0700
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
Subject: [PATCH v9 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260402-vmscape-bhb-v9-1-94d16bc29774@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: B9E4D38F75E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the BHB clearing sequence is followed by an LFENCE to prevent
transient execution of subsequent indirect branches prematurely. However,
the LFENCE barrier could be unnecessary in certain cases. For example, when
the kernel is using the BHI_DIS_S mitigation, and BHB clearing is only
needed for userspace. In such cases, the LFENCE is redundant because ring
transitions would provide the necessary serialization.

Below is a quick recap of BHI mitigation options:

On Alder Lake and newer

    BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
    performance overhead.

    Long loop: Alternatively, a longer version of the BHB clearing sequence
    can be used to mitigate BHI. It can also be used to mitigate the BHI
    variant of VMSCAPE. This is not yet implemented in Linux.

On older CPUs

    Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
    effective on older CPUs as well, but should be avoided because of
    unnecessary overhead.

On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
branch history may still influence indirect branches in userspace. This
also means the big hammer IBPB could be replaced with a cheaper option that
clears the BHB at exit-to-userspace after a VMexit.

In preparation for adding the support for the BHB sequence (without LFENCE)
on newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
executed. Allow callers to decide whether they need the LFENCE or not. This
adds a few extra bytes to the call sites, but it obviates the need for
multiple variants of clear_bhb_loop().

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            | 5 ++++-
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 arch/x86/net/bpf_jit_comp.c          | 2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 42447b1e1dff..3a180a36ca0e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1528,6 +1528,9 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * refactored in the future if needed. The .skips are for safety, to ensure
  * that all RETs are in the second half of a cacheline to mitigate Indirect
  * Target Selection, rather than taking the slowpath via its_return_thunk.
+ *
+ * Note, callers should use a speculation barrier like LFENCE immediately after
+ * a call to this function to ensure BHB is cleared before indirect branches.
  */
 SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
@@ -1562,7 +1565,7 @@ SYM_FUNC_START(clear_bhb_loop)
 	sub	$1, %ecx
 	jnz	1b
 .Lret2:	RET
-5:	lfence
+5:
 	pop	%rbp
 	RET
 SYM_FUNC_END(clear_bhb_loop)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4f4b5e8a1574..70b377fcbc1c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -331,11 +331,11 @@
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
+	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_LOOP
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e9b78040d703..63d6c9fa5e80 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1624,6 +1624,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 
 		if (emit_call(&prog, func, ip))
 			return -EINVAL;
+		/* Don't speculate past this until BHB is cleared */
+		EMIT_LFENCE();
 		EMIT1(0x59); /* pop rcx */
 		EMIT1(0x58); /* pop rax */
 	}

-- 
2.34.1



