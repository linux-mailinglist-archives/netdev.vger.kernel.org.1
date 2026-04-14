Return-Path: <netdev+bounces-278317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCTFKtDo3WmulAkAu9opvQ
	(envelope-from <netdev+bounces-278317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:12:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915333F676A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E0203010B7D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE54837189B;
	Tue, 14 Apr 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9Zqw883"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104437105A;
	Tue, 14 Apr 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150510; cv=none; b=mGKcUM6TvthVk6i9z1QmLLevGUvPxJpx+FcjL8jm9YT8wXrWOTAn6myYBj8PaXpJQv6+P3CkDZEflprlhlT6//R33GARTYaVm8JMHeQ4ZMjGLMNQyF15Rq8MuPRkAe45VeJKgf5sHDClK6pZNos57acTKPikFt45DzQz1TfqpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150510; c=relaxed/simple;
	bh=/5skwiH0gY1oo5ieSmlZoXl/fkBIevmFUlNqtPJTLYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfpE0TnT399DmHjXerXlZOAheCge9J0yckQ2vIfPbRz2iTgFP5Ykw0rEaQmyZYvqj5KgUZUbsYjIMJO9H03e9VBMVYNd1YIhR3HtT5PB2DrMPTaqwMeX9G2aUoj8LfBVoFINQJxgfF+lYNNRR8JCJYgSVmDtlx65r6WNxQzrtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9Zqw883; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776150509; x=1807686509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/5skwiH0gY1oo5ieSmlZoXl/fkBIevmFUlNqtPJTLYQ=;
  b=X9Zqw883afLHSZh5WW8T+TCUHQ2tJN4DN2/nhPLeebwlrqYNsdIN7n1z
   Tn6xzsilMBYx+7s5xF7rhXLJvRlhvrtWeY5rUrdJSb6dpeSeqORc6Zt4n
   GAJaHYWNI0xafUmZKUIMxiFGovKUdneN4x1MDIYYm9JWxZA0BjrBCcRSS
   42+h+qNkKRIYSam1P8RGZj2ZBqsGQH+uPYlJpwOckw4TE5Ugj4CEUOzq4
   sFL8Ebj4jf5R5adOhg/HG3qK4zq8FYftuc6rjX8ARRFV+74xf2iycAPYy
   /GoGXLjz/u2o2VZ92X4ntIRGlyw9AfjNNYLaN28blALF6BKhevWkpQmYu
   Q==;
X-CSE-ConnectionGUID: 1DqyMwXeT1mvwN60ivhVOg==
X-CSE-MsgGUID: GbewHZsgR2GH1YKuT8pk5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76980649"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76980649"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:07:54 -0700
X-CSE-ConnectionGUID: wf/gjug8TzOgiJchL76yQQ==
X-CSE-MsgGUID: oraOJ9/jS3OmjTimA9Yr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="228974882"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:07:52 -0700
Date: Tue, 14 Apr 2026 00:07:52 -0700
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
Subject: [PATCH v10 10/12] x86/vmscape: Deploy BHB clearing mitigation
Message-ID: <20260414-vmscape-bhb-v10-10-efa924abae5f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278317-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,suse.com:email,intel.com:dkim,intel.com:email,nutanix.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 915333F676A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IBPB mitigation for VMSCAPE is an overkill on CPUs that are only affected
by the BHI variant of VMSCAPE. On such CPUs, eIBRS already provides
indirect branch isolation between guest and host userspace. However, branch
history from guest may also influence the indirect branches in host
userspace.

To mitigate the BHI aspect, use the BHB clearing sequence. Since now, IBPB
is not the only mitigation for VMSCAPE, update the documentation to reflect
that =auto could select either IBPB or BHB clear mitigation based on the
CPU.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/vmscape.rst   | 11 ++++++++-
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 arch/x86/include/asm/entry-common.h             |  4 ++++
 arch/x86/include/asm/nospec-branch.h            |  2 ++
 arch/x86/kernel/cpu/bugs.c                      | 30 +++++++++++++++++++------
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/vmscape.rst b/Documentation/admin-guide/hw-vuln/vmscape.rst
index d9b9a2b6c114..7c40cf70ad7a 100644
--- a/Documentation/admin-guide/hw-vuln/vmscape.rst
+++ b/Documentation/admin-guide/hw-vuln/vmscape.rst
@@ -86,6 +86,10 @@ The possible values in this file are:
    run a potentially malicious guest and issues an IBPB before the first
    exit to userspace after VM-exit.
 
+ * 'Mitigation: Clear BHB before exit to userspace':
+
+   As above, conditional BHB clearing mitigation is enabled.
+
  * 'Mitigation: IBPB on VMEXIT':
 
    IBPB is issued on every VM-exit. This occurs when other mitigations like
@@ -102,9 +106,14 @@ The mitigation can be controlled via the ``vmscape=`` command line parameter:
 
  * ``vmscape=ibpb``:
 
-   Enable conditional IBPB mitigation (default when CONFIG_MITIGATION_VMSCAPE=y).
+   Enable conditional IBPB mitigation.
 
  * ``vmscape=force``:
 
    Force vulnerability detection and mitigation even on processors that are
    not known to be affected.
+
+ * ``vmscape=auto``:
+
+   Choose the mitigation based on the VMSCAPE variant the CPU is affected by.
+   (default when CONFIG_MITIGATION_VMSCAPE=y)
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..3853c7109419 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8378,9 +8378,11 @@ Kernel parameters
 
 			off		- disable the mitigation
 			ibpb		- use Indirect Branch Prediction Barrier
-					  (IBPB) mitigation (default)
+					  (IBPB) mitigation
 			force		- force vulnerability detection even on
 					  unaffected processors
+			auto		- (default) use IBPB or BHB clear
+					  mitigation based on CPU
 
 	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 783e7cb50cae..13db31472f3a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -96,6 +96,10 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	choose_random_kstack_offset(rdtsc());
 
 	if (unlikely(this_cpu_read(x86_predictor_flush_exit_to_user))) {
+		/*
+		 * Since the mitigation is for userspace, an explicit
+		 * speculation barrier is not required after flush.
+		 */
 		static_call_cond(vmscape_predictor_flush)();
 		this_cpu_write(x86_predictor_flush_exit_to_user, false);
 	}
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 066fd8095200..38478383139b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -390,6 +390,8 @@ extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop_nofence(void);
+#else
+static inline void clear_bhb_loop_nofence(void) {}
 #endif
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bfc0e41697f6..1082ed1fb2e6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,9 +61,8 @@ DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
 EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
 /*
- * Set when the CPU has run a potentially malicious guest. An IBPB will
- * be needed to before running userspace. That IBPB will flush the branch
- * predictor content.
+ * Set when the CPU has run a potentially malicious guest. Indicates that a
+ * branch predictor flush is needed before running userspace.
  */
 DEFINE_PER_CPU(bool, x86_predictor_flush_exit_to_user);
 EXPORT_PER_CPU_SYMBOL_GPL(x86_predictor_flush_exit_to_user);
@@ -3061,13 +3060,15 @@ enum vmscape_mitigations {
 	VMSCAPE_MITIGATION_AUTO,
 	VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER,
 	VMSCAPE_MITIGATION_IBPB_ON_VMEXIT,
+	VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER,
 };
 
 static const char * const vmscape_strings[] = {
-	[VMSCAPE_MITIGATION_NONE]		= "Vulnerable",
+	[VMSCAPE_MITIGATION_NONE]			= "Vulnerable",
 	/* [VMSCAPE_MITIGATION_AUTO] */
-	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]	= "Mitigation: IBPB before exit to userspace",
-	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT",
+	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]		= "Mitigation: IBPB before exit to userspace",
+	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]		= "Mitigation: IBPB on VMEXIT",
+	[VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER]	= "Mitigation: Clear BHB before exit to userspace",
 };
 
 static enum vmscape_mitigations vmscape_mitigation __ro_after_init =
@@ -3085,6 +3086,8 @@ static int __init vmscape_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+	} else if (!strcmp(str, "auto")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {
 		pr_err("Ignoring unknown vmscape=%s option.\n", str);
 	}
@@ -3114,7 +3117,17 @@ static void __init vmscape_select_mitigation(void)
 		break;
 
 	case VMSCAPE_MITIGATION_AUTO:
-		if (boot_cpu_has(X86_FEATURE_IBPB))
+		/*
+		 * CPUs with BHI_CTRL(ADL and newer) can avoid the IBPB and use
+		 * BHB clear sequence. These CPUs are only vulnerable to the BHI
+		 * variant of the VMSCAPE attack, and thus they do not require a
+		 * full predictor flush.
+		 *
+		 * Note, in 32-bit mode BHB clear sequence is not supported.
+		 */
+		if (boot_cpu_has(X86_FEATURE_BHI_CTRL) && IS_ENABLED(CONFIG_X86_64))
+			vmscape_mitigation = VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER;
+		else if (boot_cpu_has(X86_FEATURE_IBPB))
 			vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
 		else
 			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
@@ -3141,6 +3154,8 @@ static void __init vmscape_apply_mitigation(void)
 {
 	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
 		static_call_update(vmscape_predictor_flush, write_ibpb);
+	else if (vmscape_mitigation == VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER)
+		static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
 }
 
 #undef pr_fmt
@@ -3232,6 +3247,7 @@ void cpu_bugs_smt_update(void)
 		break;
 	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
 	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
+	case VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER:
 		/*
 		 * Hypervisors can be attacked across-threads, warn for SMT when
 		 * STIBP is not already enabled system-wide.

-- 
2.34.1



