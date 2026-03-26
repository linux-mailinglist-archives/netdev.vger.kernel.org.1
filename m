Return-Path: <netdev+bounces-271934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMfTJHfyxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:46:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CE331968
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267EF3082A5D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFD43B7B94;
	Thu, 26 Mar 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ4NHV1h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C23431E3;
	Thu, 26 Mar 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514383; cv=none; b=SUQml2GD/971+vpg6mHBxyT03F9zwHIDIYM5f70HGKC+UQ5zHQm3Mxe7ooI48XcaFSRR490u/2t0GWe/Ey/xm3LM3gWUllrf1cw0Id9RHPtpWRk2nz834RanAfTCmnDdGgVZou7hQG9aRQhi6Xm2Mz+xYvUeCbua8zi0DQGLEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514383; c=relaxed/simple;
	bh=6vSpyGPjeFRTtvTBtbIoMDWm0//t1rVmCeXYqkxOhEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFEt+I6BW/3dQXlVCSwkmkzJhN/2jW16696/iwCQn/zr8gMfk1y/9YGGTUtZKpnFD2BlmmBVKZ1xJn6Fq5WZk2MnVfhcvZ/0MsrX10SiZjm4yCJLAkh7oXg0mjFUCt93IV2FKvIg5OX+PdFO1DJ1nhsZd2QIFt/DUYynkQu7M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJ4NHV1h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514382; x=1806050382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vSpyGPjeFRTtvTBtbIoMDWm0//t1rVmCeXYqkxOhEk=;
  b=DJ4NHV1h7yqPJvEeDxJRm5mSI6RW2Cv2xMYVAF4VZ69c65zzSak98vix
   tdpeyvcU78ZX9p/mapjaxxSHeSc8+oAsodfKU4ulMRhj8rxruEqHcTsLu
   RdoLENsgvDYwXMIRAT/w/LEwsJVgPeOv6ocMnX0uUSUhWElWEfR8DfFKp
   kaMsav71wea7u7X9AcgVOHzxSsyKct6/WBvVaudLxd2fvSoGWc2SpnuC7
   i+TOWawHfRZ25cK2LD7bdk+Sxkk9PVFdOS4bC6296pcXKyb0UBVMHeYqi
   CHV24bFv5HiSWZ7G8kPopokSi+Skd4xP61CRbWRseEVDd+FQKtkcfb/NM
   g==;
X-CSE-ConnectionGUID: PkTNvgnFRP+Pzrzlo3FOwQ==
X-CSE-MsgGUID: gQ65NXCrTcetSsWAXSe1Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75468502"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75468502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:39:41 -0700
X-CSE-ConnectionGUID: xHn+uvVyTvSUDrv+QgRcxw==
X-CSE-MsgGUID: kwAYSHBcT3Sh+NfYSJvwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="262856864"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:39:41 -0700
Date: Thu, 26 Mar 2026 01:39:34 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260326083934.fk4wyhe6rgiss34z@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
 <20260324221308.7sh6afdy6r6tsf4w@desk>
 <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271934-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE6CE331968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 09:37:59PM +0100, Borislav Petkov wrote:
> On Tue, Mar 24, 2026 at 03:13:08PM -0700, Pawan Gupta wrote:
> > This is cleaner. A few things to consider are, CLEAR_BRANCH_HISTORY that
> > calls clear_bhb_loop() would be calling into C code very early during the
> > kernel entry. The code generated here may vary based on the compiler. Any
> > indirect branch here would be security risk. This needs to be noinstr so
> > that it can't be hijacked by probes and ftraces.
> > 
> > At kernel entry, calling into C before mitigations are applied is risky.
> 
> You can write the above function in asm if you prefer - should still be
> easier.

I believe the equivalent for cpu_feature_enabled() in asm is the
ALTERNATIVE. Please let me know if I am missing something.

Regarding your intent to move the loop count selection out of the BHB
sequence, below is what I could come up. It is not as pretty as the C
version, but it is trying to achieve something similar:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ecae3cef9d8c..54c65b0a3f65 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1494,6 +1494,20 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 SYM_CODE_END(rewind_stack_and_make_dead)
 .popsection
 
+/*
+ * Between the long and short version of BHB clear sequence, just the
+ * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
+ */
+#define BHB_SHORT_LOOP_OUTER	5
+#define BHB_SHORT_LOOP_INNER	5
+
+#define BHB_LONG_LOOP_OUTER	12
+#define BHB_LONG_LOOP_INNER	7
+
+#define BHB_MOVB(type, reg)						\
+	ALTERNATIVE __stringify(movb $BHB_SHORT_LOOP_##type, reg),	\
+		    __stringify(movb $BHB_LONG_LOOP_##type, reg), X86_FEATURE_BHI_CTRL
+
 /*
  * This sequence executes branches in order to remove user branch information
  * from the branch history tracker in the Branch Predictor, therefore removing
@@ -1540,12 +1554,7 @@ SYM_FUNC_START(clear_bhb_loop_nofence)
 	/* BPF caller may require all registers to be preserved */
 	push	%rax
 
-	/*
-	 * Between the long and short version of BHB clear sequence, just the
-	 * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
-	 */
-	ALTERNATIVE "movb $5,  %al",	\
-		    "movb $12, %al", X86_FEATURE_BHI_CTRL
+	BHB_MOVB(OUTER, %al)
 
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
@@ -1567,8 +1576,7 @@ SYM_FUNC_START(clear_bhb_loop_nofence)
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
 	.skip 32 - 14, 0xcc
-2:	ALTERNATIVE "movb $5, %ah",	\
-		    "movb $7, %ah", X86_FEATURE_BHI_CTRL
+2:	BHB_MOVB(INNER, %ah)
 3:	jmp	4f
 	nop
 4:	sub	$1, %ah


Below is how the disassembly looks like:

clear_bhb_loop_nofence:
	...
	call    1f
	jmp     5f
	// BHB_MOVB(OUTER, %al)
	mov    $0x5,%al

