Return-Path: <netdev+bounces-275087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PaHED7Uz2kQ1AYAu9opvQ
	(envelope-from <netdev+bounces-275087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:52:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F45395636
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144DC3010B91
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1393C4574;
	Fri,  3 Apr 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pb/E0rBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A1392815
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227947; cv=none; b=WFnO1/VwFYPmkLncUm1gAnkxvx26ze3aW3GZRH1+9LMwsWOySkuwtEtqWSv9kCs9wtmd1ngZaFGpYGOlHK5uNURjFDboNDo9IGalciaAsyjzU1NZvUzQ5hKsbQYz7ekxfx9lUCA1CIYK1jJf2GuWGHOErGra2e5yB43qk9d7V3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227947; c=relaxed/simple;
	bh=CTRwpPkY5I/XQFDvpz3aZ16aVXK374cBhoFBuuzohBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKDipIQooAXJF94wFL3yHgm+P+sv5hYef5hPm/Ed8VFa7UDC2x7nYCU+sJpm1yVT5s7znm6fnnE7IWFpQmZ9B68E+vTKsZw2hLMrzrKQm6LEsI/32u6dSFv4A0keUQRdu/AvxW+plvLEXUtn+ldoIi1UWtyUVSz2uLd9iK0YiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pb/E0rBe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso1766097a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775227945; x=1775832745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DiuRvpeeoOLs6ih2ypPx8qDY3zNqJzQtKD09MDbtleo=;
        b=pb/E0rBe2VtJDHyiiYkaye+2q2uqM2fMcC9khj7OKTmr5qprdUk++Tut+pjMRLt58R
         F1j36ZpLAIWzt5UGrKHpjMCtApP+pA1Rrxj/gNnDO4NGvswlLPXdB0M2JSfPqdHdrQla
         tSdCpOhSCdnyNrxBkAysGyRY9TyS/1ohVDWbM1UHvCO2oQRLQ19THmeJVQFz9hDm2W/k
         VnQwKp5SCVZrXNpfgdl25tY/Is9cQGsMk5Bx05GdKCp/3cxtt9OiWbqd+cKWQa8GLKpq
         +vIn8GuWuFs6RWcBIBziKykrtBXXXnzkswWq3941XRcE2tMduMNmo5CP++qQ28eJxNK9
         FpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227945; x=1775832745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiuRvpeeoOLs6ih2ypPx8qDY3zNqJzQtKD09MDbtleo=;
        b=LjRVuqkMSrmqK/EZzR/zFxe7+j2LhL1Dlch9aSqfXeFjvU5whi84lwFvj0F9LAfJZz
         9zNmCobeNJnkbkgU11bHqobzH/OlGULsqMMUuULfdaR4jzlAi8TD/2gPft4jbLhz9Rws
         h7iE7idL8AV6qPO9G6nW94pG56GKTh8Wk1MUDjvYpz4uNn7xqt/A+zZavaD1S4igb+gC
         /CZ27+bDyVwSwd/tWRUCztWdsEETXbtYDBInqIwNxoaIPsHLym2/B8DL+HgSC0vzD9Qd
         A4v4QXRJFM4moG5buwb1Dx4FLZTAfHlAyRAqngSJ1RXmpteko0t9bPvQ9GKbaFdTVcjA
         pkFw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ26USAuX8UWhxERvsS9sZR3qXjZwaY/qUhTCQ54+RI/qGmhj4i12gLbxd8j5SHKSzlCI7QvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWSDBhMd8lU2gKiqHeoq1xk8UYGhenadliu129PDYsfCfl/vu
	LuUABANG2VVWIiXn11drXWJlISzoR7z3LTS4iCwHH8QD7GIbvDRbEmcDT+yF3ocfiRzbFuNibbG
	3PyvmJQ==
X-Received: from pjuf5.prod.google.com ([2002:a17:90a:ce05:b0:35c:2d1e:7123])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc3:b0:359:f825:5700
 with SMTP id 98e67ed59e1d1-35de68688f0mr3098585a91.10.1775227945130; Fri, 03
 Apr 2026 07:52:25 -0700 (PDT)
Date: Fri, 3 Apr 2026 07:52:23 -0700
In-Reply-To: <20260402-vmscape-bhb-v9-7-94d16bc29774@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com> <20260402-vmscape-bhb-v9-7-94d16bc29774@linux.intel.com>
Message-ID: <ac_UJx99kDJY8j3t@google.com>
Subject: Re: [PATCH v9 07/10] x86/vmscape: Use static_call() for predictor flush
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275087-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97F45395636
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026, Pawan Gupta wrote:
> Adding more mitigation options at exit-to-userspace for VMSCAPE would
> usually require a series of checks to decide which mitigation to use. In
> this case, the mitigation is done by calling a function, which is decided
> at boot. So, adding more feature flags and multiple checks can be avoided
> by using static_call() to the mitigating function.
> 
> Replace the flag-based mitigation selector with a static_call(). This also
> frees the existing X86_FEATURE_IBPB_EXIT_TO_USER.

...

> @@ -3133,8 +3139,14 @@ static void __init vmscape_update_mitigation(void)
>  static void __init vmscape_apply_mitigation(void)
>  {
>  	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
> -		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
> +		static_call_update(vmscape_predictor_flush, write_ibpb);
> +}
> +
> +bool vmscape_mitigation_enabled(void)
> +{
> +	return !!static_call_query(vmscape_predictor_flush);
>  }
> +EXPORT_SYMBOL_FOR_KVM(vmscape_mitigation_enabled);
>  
>  #undef pr_fmt
>  #define pr_fmt(fmt) fmt
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 45d7cfedc507..e204482e64f3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11463,7 +11463,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	 * set for the CPU that actually ran the guest, and not the CPU that it
>  	 * may migrate to.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
> +	if (vmscape_mitigation_enabled())

This is pretty lame.  It turns a statically patched MOV

  11548		if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
  11549			this_cpu_write(x86_ibpb_exit_to_user, true);
     0x000000000003c57a <+858>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c582 <vcpu_enter_guest+866>

into a function call and two sets of conditional branches.  And with mitigations
enabled, that function call may trigger the wonderful unret insanity

  11548		if (vmscape_mitigation_enabled())
     0x000000000003c575 <+853>:	call   0x3c57a <vcpu_enter_guest+858>
     0x000000000003c57a <+858>:	test   %al,%al
     0x000000000003c57c <+860>:	je     0x3c586 <vcpu_enter_guest+870>

  11549			this_cpu_write(x86_predictor_flush_exit_to_user, true);
     0x000000000003c57e <+862>:	movb   $0x1,%gs:0x0(%rip)        # 0x3c586 <vcpu_enter_guest+870>


  3166	{
     0xffffffff81285320 <+0>:	endbr64
     0xffffffff81285324 <+4>:	call   0xffffffff812aa5a0 <__fentry__>

  3167		return !!static_call_query(vmscape_predictor_flush);
     0xffffffff81285329 <+9>:	mov    0x13a4f30(%rip),%rax        # 0xffffffff8262a260 <__SCK__vmscape_predictor_flush>
     0xffffffff81285330 <+16>:	test   %rax,%rax
     0xffffffff81285333 <+19>:	setne  %al

  3168	}
     0xffffffff81285336 <+22>:	jmp    0xffffffff81db1e30 <__x86_return_thunk>

While this isn't KVM's super hot inner run loop, it's still very much a hot path.
Even more annoying, KVM will eat the function call on kernels with CPU_MITIGATIONS=n.

I'd like to at least do something like the below to make the common case of
multiple guest entry/exits more or less free, and to avoid the CALL+(UN)RET
overhead, but trying to include linux/static_call.h in processor.h (or any other
core x86 header) creates a cyclical dependency :-/

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 20ab4dd588c6..0dc0680a80f8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -36,6 +36,7 @@ struct vm86;
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/mem_encrypt.h>
+#include <linux/static_call.h>
 
 /*
  * We handle most unaligned accesses in hardware.  On the other hand
@@ -753,7 +754,11 @@ enum mds_mitigations {
 };
 
 extern bool gds_ucode_mitigated(void);
-extern bool vmscape_mitigation_enabled(void);
+
+static inline bool vmscape_mitigation_enabled(void)
+{
+       return !!static_call_query(vmscape_predictor_flush);
+}
 
 /*
  * Make previous memory operations globally visible before
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 366ebe1e1fb9..02bf626f0773 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -148,6 +148,7 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
  * sequence. This defaults to no mitigation.
  */
 DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
+EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);
 
 #undef pr_fmt
 #define pr_fmt(fmt)    "mitigations: " fmt
@@ -3162,12 +3163,6 @@ static void __init vmscape_apply_mitigation(void)
                static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
 }
 
-bool vmscape_mitigation_enabled(void)
-{
-       return !!static_call_query(vmscape_predictor_flush);
-}
-EXPORT_SYMBOL_FOR_KVM(vmscape_mitigation_enabled);
-
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1fbbab08291..117c60d00758 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11545,7 +11545,9 @@ static noinline int vcpu_enter_guest(struct kvm_vcpu *vcpu)
         * set for the CPU that actually ran the guest, and not the CPU that it
         * may migrate to.
         */
-       if (vmscape_mitigation_enabled())
+       if (IS_ENABLED(CONFIG_CPU_MITIGATIONS) &&
+           !this_cpu_read(x86_predictor_flush_exit_to_user) &&
+           vmscape_mitigation_enabled())
                this_cpu_write(x86_predictor_flush_exit_to_user, true);
 
        /*

