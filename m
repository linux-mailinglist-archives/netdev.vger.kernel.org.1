Return-Path: <netdev+bounces-301431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HyIxAmTFOmqtGQgAu9opvQ
	(envelope-from <netdev+bounces-301431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:41:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E96EA6B9287
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YmaiVbtA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301431-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301431-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 699E03071548
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7F3905E3;
	Tue, 23 Jun 2026 17:35:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3838CFE1;
	Tue, 23 Jun 2026 17:35:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236113; cv=none; b=SwUdApqWZyNoJCFiMQ4HJtw7rogzP8sCsqRKuIce929W7ZXjE2Lc8M5APLKA56Boqx06B8nZH3eWRitIW+ZW3DRmxPWdMxyvvWlGiZ+4vFfijM0WBzdXOXNSPknH2y/cnND2p8vMU/3RYjX1kBCJAtrtWrwEPdCu+gyizWIX4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236113; c=relaxed/simple;
	bh=A79rL4qxRxF7ycuhclRP6P1oxxPfK5g73gkq6CMSKog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7J385hEdF9DmZWeNva2c45aJjzt2EAAwfNcbBpLqsyco+xAnHg5/b2tfXyzUQbMhPAZYczRQwvh//atL0E1BuBOydv24N9hRky3GGygh04ikbPFQlrhTjYj40jbKBHrcyYeMsdTw3VQ+4Nvpvov9kLLg5P5/2sWfZanrKPEaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmaiVbtA; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236112; x=1813772112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A79rL4qxRxF7ycuhclRP6P1oxxPfK5g73gkq6CMSKog=;
  b=YmaiVbtABrCqdTpeMoqdWvM6js3AB9t/hhZt/ctkNBzgdrwiHZMc5uRN
   ibyqmTPUsohb7SD5dSMFFHa2Y5yRbP/EuphbolgMeCUjgBnSPpK+HS/wi
   b+ZV1vXy0jD1mBZp234qHb3to2Cj2SEaJei8f5IsVoFY9ptYoyQrEFkpc
   qHGuaClESso/NDYnkaJTorX6r+nzD7Gk8CNURqwlYdp6o3kLhy7t07tQo
   fXsURuadRLhxfbPGCBVmi0/jbaESSoM/m7qndlkfx5nqgGqAAJc2PTfDa
   kmOcraS0MXLRUEjbs08a/H28KLa3Mi2rVTPAEiT9Swi7hygJOjJaMgnOq
   A==;
X-CSE-ConnectionGUID: VKkXrAMnTHqU9LvgSWimzg==
X-CSE-MsgGUID: D52tXPsPRq6umHiS1DYjgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100415064"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100415064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:12 -0700
X-CSE-ConnectionGUID: uOtvg+fDQuWMFB0eZJzG9A==
X-CSE-MsgGUID: Qqn4raj5R3WnoML1LU0oWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="248700586"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:35:12 -0700
Date: Tue, 23 Jun 2026 10:35:11 -0700
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v12 10/12] x86/vmscape: Deploy BHB clearing mitigation
Message-ID: <20260622-vmscape-bhb-v12-10-76cbda0ae3e5@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301431-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:
 lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nutanix.com:email,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E96EA6B9287

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
index 97007f4f69d4..38594df8859f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8337,9 +8337,11 @@ Kernel parameters
 
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
index d5b390c76f00..befa14a19817 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -84,6 +84,10 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 #endif
 
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



