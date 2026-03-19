Return-Path: <netdev+bounces-269511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jq1OUQavGlEsQIAu9opvQ
	(envelope-from <netdev+bounces-269511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAE92CDEE8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B5353095D9D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3C3E7151;
	Thu, 19 Mar 2026 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHQzRrne"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BE3DE434;
	Thu, 19 Mar 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934916; cv=none; b=fo11BatxKB7AhM2p9AejjTi0iUaoYs3ONEDpxQvn8BF5ZnqVVqyIiQ6qdLeXXrDZJNB+OILrZ/gKG/pna/oe+9usfiSSEeqU75JfAA4BsKQ46DDHB/Eleq+GKrTd1UbuR9Tj/WpVRFyhLxjbyg+XpPPfy3XINk+AV4xrIzi4YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934916; c=relaxed/simple;
	bh=fvmOWcUlqYNLaPbn1q7zJDCYFX1YGRgONeyzcpgFdB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL25dLmsPpsPVtFHzDOtIzlFytC9FdcA+vqkDjcXXrQ/Rq/WBzorYKd4NCnSbkuAyHv2ruwJDYwVk16GZcA9r17NlNHbyrE4yoFM0fldX98EAnmzzYgQXiEevyBHMN2VTnmEJEtIWjo+UHYGTKyHptkNpUcqsZs/lJ8HMV9YSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHQzRrne; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773934915; x=1805470915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvmOWcUlqYNLaPbn1q7zJDCYFX1YGRgONeyzcpgFdB8=;
  b=eHQzRrne7bpAulB7SwfQksLt8GLWwr7uPIC1gSmSLQvQ1cw3isPBm/7C
   uYJsraREhbbqLjBZFH1zq82M+sYqZk59zAUBrTr6znG2zW23AY1tvmZ3X
   3zjYuwDiRo201d/4qCBh0bJE4lOW3+BHiK3mkVuODUAU5mi8IiTXnGpa9
   m4jnqb1S7tLPyaECNXbx6+EQeGfgWOFhU9wfpV2CnM2UJrZih1NDBG1RJ
   tby+5Y+d+4bOOxoyVnAus2Sg5QcmJSRq+ZnfJuhVT/3eg4UoeCpz7pQns
   OXk4R21R249410PHzEJgAiFpQ88jxvzVk1Bmr2MTydaQgXJmh8VXt8Pbb
   g==;
X-CSE-ConnectionGUID: hkyGJVjdRTqrNYiqKfsv5g==
X-CSE-MsgGUID: e4q1EAJbT9WZdU4rmBpkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75042440"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75042440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:41:54 -0700
X-CSE-ConnectionGUID: mO58a4cCS/aPRyC+paGckQ==
X-CSE-MsgGUID: cEcrv8dbTmmVjsBLKixnUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="253469395"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:41:54 -0700
Date: Thu, 19 Mar 2026 08:41:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
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
Subject: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor flush
Message-ID: <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BAE92CDEE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding more mitigation options at exit-to-userspace for VMSCAPE would
usually require a series of checks to decide which mitigation to use. In
this case, the mitigation is done by calling a function, which is decided
at boot. So, adding more feature flags and multiple checks can be avoided
by using static_call() to the mitigating function.

Replace the flag-based mitigation selector with a static_call(). This also
frees the existing X86_FEATURE_IBPB_EXIT_TO_USER.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  7 +++----
 arch/x86/include/asm/nospec-branch.h |  3 +++
 arch/x86/kernel/cpu/bugs.c           | 13 ++++++++++++-
 arch/x86/kvm/x86.c                   |  2 +-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..5b8def9ddb98 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2720,6 +2720,7 @@ config MITIGATION_TSA
 config MITIGATION_VMSCAPE
 	bool "Mitigate VMSCAPE"
 	depends on KVM
+	depends on HAVE_STATIC_CALL
 	default y
 	help
 	  Enable mitigation for VMSCAPE attacks. VMSCAPE is a hardware security
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..b4d529dd6d30 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -503,7 +503,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
-#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
+/* Free */
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
 #define X86_FEATURE_SGX_EUPDATESVN	(21*32+17) /* Support for ENCLS[EUPDATESVN] instruction */
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 78b143673ca7..783e7cb50cae 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -4,6 +4,7 @@
 
 #include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
+#include <linux/static_call_types.h>
 
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
@@ -94,10 +95,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 */
 	choose_random_kstack_offset(rdtsc());
 
-	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
-	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
-	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
-		write_ibpb();
+	if (unlikely(this_cpu_read(x86_predictor_flush_exit_to_user))) {
+		static_call_cond(vmscape_predictor_flush)();
 		this_cpu_write(x86_predictor_flush_exit_to_user, false);
 	}
 }
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 0a55b1c64741..e45e49f1e0c9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -542,6 +542,9 @@ static inline void indirect_branch_prediction_barrier(void)
 			    :: "rax", "rcx", "rdx", "memory");
 }
 
+#include <linux/static_call_types.h>
+DECLARE_STATIC_CALL(vmscape_predictor_flush, write_ibpb);
+
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 68e2df3e3bf5..b75eda114503 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
  */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
+/*
+ * Controls CPU Fill buffer clear before VMenter. This is a subset of
+ * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
+ * mitigation is required.
+ */
+DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
+EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
+
+DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
+EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"mitigations: " fmt
 
@@ -3129,7 +3140,7 @@ static void __init vmscape_update_mitigation(void)
 static void __init vmscape_apply_mitigation(void)
 {
 	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
-		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
+		static_call_update(vmscape_predictor_flush, write_ibpb);
 }
 
 #undef pr_fmt
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 45d7cfedc507..5582056b2fa1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11463,7 +11463,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * set for the CPU that actually ran the guest, and not the CPU that it
 	 * may migrate to.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
+	if (static_call_query(vmscape_predictor_flush))
 		this_cpu_write(x86_predictor_flush_exit_to_user, true);
 
 	/*

-- 
2.34.1



