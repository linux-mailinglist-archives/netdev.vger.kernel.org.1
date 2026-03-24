Return-Path: <netdev+bounces-271233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKx/LcrWwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:24:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45731AC46
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3D7E308B1C5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A513845DC;
	Tue, 24 Mar 2026 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGurPd8j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C537F733;
	Tue, 24 Mar 2026 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376312; cv=none; b=QwfmZ+p+nuqpM0OGTVtGh8CM06jnH8OFziAuv3xWv+QuOkIrf0Z8PEDanAEqci+Gyx428B7ukksP3t+hkNISBu4C7j8yERCZBJGffHc2lgot2m4Apkr9FaZ89dCZpy4KGsNtu/JSB0CdKiWyhA8KWR66J0xbFWJWvgBbf7gOjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376312; c=relaxed/simple;
	bh=5O7npA2R+PTs11/qeBAXfNz7xHj3j/vBMPYhM+J1ZLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpRvhypd+POzTJMxlVFlT3UoQyCsmNrUc5WMl1rp3HaQ/llBiGYsay85ovGEld4BAj6K/8lQ4ngoQHxMSZdFfmQKd3d2zK2J/MGLYjZMQs+5SDF96WYo6WK5tEDKqbg5glaqS9vpqGBexEIW3N1BkoD+hOnu47PxbrlOfBRbhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGurPd8j; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774376311; x=1805912311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5O7npA2R+PTs11/qeBAXfNz7xHj3j/vBMPYhM+J1ZLM=;
  b=KGurPd8j8IQcu+XlyaVIp7X4Y/s991JrvtGBcNAWZ6n/n8ubnqyH5cfl
   4WXgoFsNrlUhVaAmvyP5v1olugu4oNljMx4E0GzXphRc2x6onT7W+Rlp8
   LzyrZynSP5akpDPk3TJMtC1natClvSxeiW1cB5SKLMWwfXAhRIXcaffdE
   Tv6rcv64aFV+4TmEHdYP6fyzORL7Y09a1Eqenfmz+t6QV+3ELRNIdQfTS
   +Vb4SB7gEFnpPd6z6UDNTRfHxJoIBmI80Wtv67korPef6Xih6L0ZGpKbU
   s8txN5QvkOcKoghwmxAnrH/eB8Du0f8P1nL85Wa//legDM1ai0Fjg+sqi
   g==;
X-CSE-ConnectionGUID: bDhvreBgSZSk4dJAnZW3SQ==
X-CSE-MsgGUID: HKYfVIPLTLumRqMsRSnPGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74429569"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74429569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:18:30 -0700
X-CSE-ConnectionGUID: acNsU9AwSh6JnrYGgX7m4g==
X-CSE-MsgGUID: DdX15JbnSfGtiWGiWJ25zA==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:18:29 -0700
Date: Tue, 24 Mar 2026 11:18:28 -0700
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
Subject: [PATCH v8 08/10] x86/vmscape: Deploy BHB clearing mitigation
Message-ID: <20260324-vmscape-bhb-v8-8-68bb524b3ab9@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271233-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 6C45731AC46
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
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/vmscape.rst   | 11 ++++++++-
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 arch/x86/include/asm/nospec-branch.h            |  2 ++
 arch/x86/kernel/cpu/bugs.c                      | 30 +++++++++++++++++++------
 4 files changed, 38 insertions(+), 9 deletions(-)

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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e45e49f1e0c9..7be812a73326 100644
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
index a7dee7ec6ea3..8cacd9474fdf 100644
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
@@ -3056,13 +3055,15 @@ enum vmscape_mitigations {
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
@@ -3080,6 +3081,8 @@ static int __init vmscape_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+	} else if (!strcmp(str, "auto")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {
 		pr_err("Ignoring unknown vmscape=%s option.\n", str);
 	}
@@ -3109,7 +3112,17 @@ static void __init vmscape_select_mitigation(void)
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
@@ -3136,6 +3149,8 @@ static void __init vmscape_apply_mitigation(void)
 {
 	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
 		static_call_update(vmscape_predictor_flush, write_ibpb);
+	else if (vmscape_mitigation == VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER)
+		static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
 }
 
 bool vmscape_mitigation_enabled(void)
@@ -3233,6 +3248,7 @@ void cpu_bugs_smt_update(void)
 		break;
 	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
 	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
+	case VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER:
 		/*
 		 * Hypervisors can be attacked across-threads, warn for SMT when
 		 * STIBP is not already enabled system-wide.

-- 
2.34.1



