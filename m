Return-Path: <netdev+bounces-301424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G81oLsnDOmrvGAgAu9opvQ
	(envelope-from <netdev+bounces-301424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:35:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE456B919A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=PEiNtf8e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301424-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CED930AA3EE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBF38BF89;
	Tue, 23 Jun 2026 17:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0A30BF69;
	Tue, 23 Jun 2026 17:33:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236005; cv=none; b=Kl8KdQMZR0M4EmWnrqGGsZE7x/qb1cLEriVIItbLWQ9bz8lmOwzw7EGao+y1oZQ8zg7dFjz+OeUGfaaq8DQOR4Z0GmP+1GQCsuKw7G/0Xd+PPkl2CBNp5cplfhRuGRYlP2F95IR5xDLWq9OH0AM3VZSCdiKFaHkIAoWiebWwZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236005; c=relaxed/simple;
	bh=BkFa9vJUYvM7NzlMRf9CVE8hqLwWTCuoOuG3LDZd9JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBMvB9f55wB76HlUl7pIV6FEw4c0UUObwwiYXFe1xajx1D6Jt+V5ZRB660t2PWnBF8yXXTCyQZkFXQYS4AY6hdFXcUd7rPnUoyb8LDidZC0E/FX8XRq0VaNsOt+q6cUYpf6ioPtLqaBikVoEwnIpcHxdwfkoUIWiFyCF6TB7Wpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEiNtf8e; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782236004; x=1813772004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BkFa9vJUYvM7NzlMRf9CVE8hqLwWTCuoOuG3LDZd9JU=;
  b=PEiNtf8e5AvHciUFeR0J6gKNzXpqegGpgJDb0rZMIj7e+ed6fA0rcWlP
   vYGSZF5E8DXEGdKY5sz8dnr8COsnJiqlU/tc97D1igifOOuQMtMTBhZnc
   uOY/kKMEeKlobDTSVpd1pKZW456AVOkveuNVByP0dHIBuzMd8FqKnnKml
   osnuQV0LuyrYYVipmr9HEGYxYgcZFejAwohn/e2WJV4vAtWiSSCIDywDO
   KpKEic318XhA79reFkxAf5d4RCGT5Dqer2gue4UAeT07z2KDS3Y2lQW/W
   avAwmSv6XF6N/CQwEc2GUgp0eTgu+tq5v2hxWdWhp8ffyOxMHbYbAnVcf
   Q==;
X-CSE-ConnectionGUID: 2Cg/bLBRTFi3xKzOb50cnA==
X-CSE-MsgGUID: 2N/mvjRJR6yJ02dq3cACWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94481315"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94481315"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:33:23 -0700
X-CSE-ConnectionGUID: hEfyGkPeSG6UOAiP9PR+jw==
X-CSE-MsgGUID: cDT2oLTjQTKkFeQX3APvrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="246657704"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 10:33:22 -0700
Date: Tue, 23 Jun 2026 10:33:22 -0700
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
Subject: [PATCH v12 03/12] x86/bhi: Rename clear_bhb_loop() to
 clear_bhb_loop_nofence()
Message-ID: <20260622-vmscape-bhb-v12-3-76cbda0ae3e5@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301424-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.com:email,alien8.de:email,linux.intel.com:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AE456B919A

To reflect the recent change that moved LFENCE to the caller side.

Suggested-by: Borislav Petkov <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_64.S            | 8 ++++----
 arch/x86/include/asm/nospec-branch.h | 6 +++---
 arch/x86/net/bpf_jit_comp.c          | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index bbd4b1c7ec04..1f56d086d312 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1532,7 +1532,7 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * Note, callers should use a speculation barrier like LFENCE immediately after
  * a call to this function to ensure BHB is cleared before indirect branches.
  */
-SYM_FUNC_START(clear_bhb_loop)
+SYM_FUNC_START(clear_bhb_loop_nofence)
 	ANNOTATE_NOENDBR
 	push	%rbp
 	mov	%rsp, %rbp
@@ -1570,6 +1570,6 @@ SYM_FUNC_START(clear_bhb_loop)
 5:
 	pop	%rbp
 	RET
-SYM_FUNC_END(clear_bhb_loop)
-EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop)
-STACK_FRAME_NON_STANDARD(clear_bhb_loop)
+SYM_FUNC_END(clear_bhb_loop_nofence)
+EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop_nofence)
+STACK_FRAME_NON_STANDARD(clear_bhb_loop_nofence)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 87b83ae7c97f..157eb69c7f0f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -331,11 +331,11 @@
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
-	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_LOOP
+	ALTERNATIVE "", "call clear_bhb_loop_nofence; lfence", X86_FEATURE_CLEAR_BHB_LOOP
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop_nofence; lfence", X86_FEATURE_CLEAR_BHB_VMEXIT
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
@@ -389,7 +389,7 @@ extern void entry_untrain_ret(void);
 extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
-extern void clear_bhb_loop(void);
+extern void clear_bhb_loop_nofence(void);
 #endif
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f58ff2891d7d..e6d17eb4d949 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1619,7 +1619,7 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 		EMIT1(0x51); /* push rcx */
 		ip += 2;
 
-		func = (u8 *)clear_bhb_loop;
+		func = (u8 *)clear_bhb_loop_nofence;
 		ip += x86_call_depth_emit_accounting(&prog, func, ip);
 
 		if (emit_call(&prog, func, ip))

-- 
2.34.1



