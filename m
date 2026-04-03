Return-Path: <netdev+bounces-274785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIh1J2YKz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE338F765
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B2AA3008C2A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ECB219A8A;
	Fri,  3 Apr 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyInb4eX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682D2147E5;
	Fri,  3 Apr 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176268; cv=none; b=GjprjLp7gBuKzFCS39m0xmmRzssLm6TSion46hfFUCAlkrssG6H4MJJvu/kqeXFpsv6Eb4C1MfWhQzR0s358zLS+LuIFMsldnK2Dux8awZBW34umPDegx+W+a7UEhXbjv2E6JbmHOxnDDb8rYGSkJUTbcvu1iipjRwLnePk0ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176268; c=relaxed/simple;
	bh=vUaq1L4lvEMbQrUcYXAvv1Y3U3fF/UdA7tbV7tlCoj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeGToIaq2QdTRIUWlnHRlFfDhThv2Vbg9xz7QhT143qOp/VMJ3Ug1X1NLSM1wJJ0AK/k/VRs16oktC7uPVrSCtSmwWOOuHBYCDjgcilqs7iw4X+Y6XtCB+H5awtMxJfZ2TA3a12TlxdgMWLr7SCmGcBVTrA7/QVUELR8Co+QMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyInb4eX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775176267; x=1806712267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vUaq1L4lvEMbQrUcYXAvv1Y3U3fF/UdA7tbV7tlCoj4=;
  b=fyInb4eXHpFNZG9LPrxngm50YeCALc+SRttqQt2nZ7s6GbgpqxZV826v
   HV/TatP5K+DoR2P47E9RoSIuLOiVq2FTqsaFLnqsZVJzHVM3iDBnDCjMC
   YXEQkBCORo61AD6QwCrtHEXjE2AnB40H1TCNusJNQKO5nSpj869LxK7bz
   +Gdo6FAYnFZVKSqTlMVTJtXRqolEKt5qahTJGFfay/JYYHJT+hBGzHS84
   CrBSOKxkkMlxji+/kLQnOQTj5zvkwIh66gSF6RinHGiTrbhJIyHoXT/ok
   DpeKFDWfi4OQl4GmQwAYfF6CYyFl4jzp5ljnNgxdVpa/aoAp3sw9IjviJ
   g==;
X-CSE-ConnectionGUID: 253ljbtRSfe5H0MPiJdacg==
X-CSE-MsgGUID: Y1v8StbKTgGtZX+0E5WCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="63794189"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="63794189"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:06 -0700
X-CSE-ConnectionGUID: uPLorF36RVGRWD7aqlSONQ==
X-CSE-MsgGUID: EX1W2jVERpOaR2gxZWNRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="250191143"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 17:31:05 -0700
Date: Thu, 2 Apr 2026 17:31:04 -0700
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
Subject: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on newer
 CPUs
Message-ID: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-274785-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 44FE338F765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
the Branch History Buffer (BHB). On Alder Lake and newer parts this
sequence is not sufficient because it doesn't clear enough entries. This
was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
in the kernel.

Now with VMSCAPE (BHI variant) it is also required to isolate branch
history between guests and userspace. Since BHI_DIS_S only protects the
kernel, the newer CPUs also use IBPB.

A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
But it currently does not clear enough BHB entries to be effective on newer
CPUs with larger BHB. At boot, dynamically set the loop count of
clear_bhb_loop() such that it is effective on newer CPUs too. Use the
X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop count.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            |  8 +++++---
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..bbd4b1c7ec04 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
+	movzbl    bhb_seq_outer_loop(%rip), %ecx
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
-	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+	.skip 32 - 20, 0xcc
+2:	movzbl  bhb_seq_inner_loop(%rip), %eax
 3:	jmp	4f
 	nop
 4:	sub	$1, %eax
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 70b377fcbc1c..87b83ae7c97f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
 extern void update_spec_ctrl_cond(u64 val);
 extern u64 spec_ctrl_current(void);
 
+extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
+
 /*
  * With retpoline, we must use IBRS to restrict branch prediction
  * before calling into firmware.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..2cb4a96247d8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2047,6 +2047,10 @@ enum bhi_mitigations {
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
+/* Default to short BHB sequence values */
+u8 bhb_seq_outer_loop __ro_after_init = 5;
+u8 bhb_seq_inner_loop __ro_after_init = 5;
+
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
 	if (!str)
@@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	/*
+	 * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
+	 * support), see Intel's BHI guidance.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
+		bhb_seq_outer_loop = 12;
+		bhb_seq_inner_loop = 7;
+	}
+
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	cpu_print_attack_vectors();

-- 
2.34.1



