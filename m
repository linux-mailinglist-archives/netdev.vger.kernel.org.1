Return-Path: <netdev+bounces-280616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DcpLSC66WlJigIAu9opvQ
	(envelope-from <netdev+bounces-280616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C944D8D2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81EA304CE88
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44D314D13;
	Thu, 23 Apr 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIssIm/A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E5310777;
	Thu, 23 Apr 2026 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925013; cv=none; b=qZOVmnAMJCahjU2cOXO80v92U/U0/rF8Lh44CuPrYDFN5MuiZ0zJYpzYd/4euSBT77SeC4XziMBbvGygw5znS1YW8ZNavh8pVPM/DXpTeh4hU+s9Av0wyLXzdsiOET/4fObN7HOHfRTIxPEbqq31BFUBr6HcnPoreLYwxj+DyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925013; c=relaxed/simple;
	bh=ZuTIHjCRRWZzxI6mCXEsoUagqM4uYFytgSX9dnoqQKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXc1wmSjTQeG6d1KePbbbh/hcVGO6L0Lo+Flrz8UFGA2ViRYIsjVS7/8gGazYInGCj2FNs1dgOTQmY4VPXhRiznM+P6LSW3Vyt+5ELvutQaOaTUh1ylXdrqIY3Oue1znrR9Si5FTpRzGu8p+8pL8vNzfh9W7asCm9s7KQ4rxG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIssIm/A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776925012; x=1808461012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZuTIHjCRRWZzxI6mCXEsoUagqM4uYFytgSX9dnoqQKk=;
  b=PIssIm/AGR+YNwCcAGL0IsDabhX8bd2l0BEErA/eGlBRuHsoDuTcPG2A
   lbbwlgRVuN+5E3EMQ2SquYEAU9BzmxhUZ0bap2UatNfqIeHEr0cjCnYhs
   gzFRWhbVMpNFehTtQHNf4Gy3LaOIqBrweMFDDNZWtJsH495blxO56Nvu1
   3ivWwAOyHBWPEdRHle25tW8/Bs7zifrl2naeMNgc8/q29VFbw/hKAtpDX
   hQcbuxEYxeld/Yc0mG7geKp9M5pkYDxTTZsu2os7BJIgWZkXO4fwfGgKF
   3yRPaFA1PMxj4hOWtaSRO2mb6qFd0pfuw6RZkVIS/E3gJ0Y7g3YkVOtAb
   A==;
X-CSE-ConnectionGUID: cxf/n+BASKmNMj6IVHmUsg==
X-CSE-MsgGUID: H8Jp7MCrRgi8WyNYDts6HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80473349"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="80473349"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:52 -0700
X-CSE-ConnectionGUID: D7pbfXHMRu+bDadIC+P17w==
X-CSE-MsgGUID: 5SaLnwAPQkC0q9MYjogkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237551349"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:16:51 -0700
Date: Wed, 22 Apr 2026 23:16:50 -0700
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
Subject: [PATCH v11 08/12] kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
Message-ID: <20260422-vmscape-bhb-v11-8-b18e0cf32af4@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 524C944D8D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EXPORT_SYMBOL_FOR_KVM() exists to export symbols to KVM modules. Static
calls need the same treatment when the core kernel defines a static_call
that KVM needs access to (e.g. from a VM-exit path).

Define EXPORT_STATIC_CALL_FOR_KVM() as the static_call analogue of
EXPORT_SYMBOL_FOR_KVM(). The same three-way logic applies:

  - KVM_SUB_MODULES defined: export to "kvm," plus all sub-modules
  - KVM=m, no sub-modules: export to "kvm" only
  - KVM built-in: no export needed (noop)

  As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override both
  macros (e.g. to suppress the export when kvm.ko itself will not be
  built despite CONFIG_KVM=m). Add the x86 no-op overrides in
  arch/x86/include/asm/kvm_types.h for that case. To keep the pair in
  sync, EXPORT_STATIC_CALL_FOR_KVM() is defined inside the
  EXPORT_SYMBOL_FOR_KVM #ifndef block; an arch that defines
  EXPORT_SYMBOL_FOR_KVM must also define EXPORT_STATIC_CALL_FOR_KVM or the
  build will fail with a compile-time error.

As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override
EXPORT_STATIC_CALL_FOR_KVM definition (e.g. to suppress the export when
kvm.ko itself will not be built despite CONFIG_KVM=m). Add the x86 no-op
override in arch/x86/include/asm/kvm_types.h for that case.

Architectures must also define EXPORT_STATIC_CALL_FOR_KVM when they define
EXPORT_SYMBOL_FOR_KVM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/kvm_types.h |  1 +
 include/linux/kvm_types.h        | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
index d7c704ed1be9..bceeaed2940e 100644
--- a/arch/x86/include/asm/kvm_types.h
+++ b/arch/x86/include/asm/kvm_types.h
@@ -15,6 +15,7 @@
  * at least one vendor module is enabled.
  */
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif
 
 #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..be602d3f287e 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -13,6 +13,8 @@
 	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
 #define EXPORT_SYMBOL_FOR_KVM(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
+	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
 #else
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
 /*
@@ -23,11 +25,17 @@
 #ifndef EXPORT_SYMBOL_FOR_KVM
 #if IS_MODULE(CONFIG_KVM)
 #define EXPORT_SYMBOL_FOR_KVM(symbol) EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm")
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
 #else
 #define EXPORT_SYMBOL_FOR_KVM(symbol)
+#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
 #endif /* IS_MODULE(CONFIG_KVM) */
-#endif /* EXPORT_SYMBOL_FOR_KVM */
+#else
+#ifndef EXPORT_STATIC_CALL_FOR_KVM
+#error Must #define EXPORT_STATIC_CALL_FOR_KVM if #defining EXPORT_SYMBOL_FOR_KVM
 #endif
+#endif /* EXPORT_SYMBOL_FOR_KVM */
+#endif /* KVM_SUB_MODULES */
 
 #ifndef __ASSEMBLER__
 

-- 
2.34.1



