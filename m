Return-Path: <netdev+bounces-279179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNCQEJlm4Wm/swAAu9opvQ
	(envelope-from <netdev+bounces-279179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EF415564
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4952A303DF45
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60505390982;
	Thu, 16 Apr 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeIywNGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A91371CE1
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379494; cv=none; b=E512zmrsIdlGA2L3eKOfULHtoKB72bp3lqxU/CEuFlidm7LIxb6Izl7wkmwNKDBFv6in3dIvhCJutyFpg3mgMmD0WECi/hpB4OZJYttJu+pY67/lGmq+zx2qlmDrTThGTwz7LDQfJ/FHg4oD7NxzaHQPC6UxJvjhqcEwavudtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379494; c=relaxed/simple;
	bh=QnH1vIimESyZ2peW1iohZ3MwmBA4oBxKLRs7rK4wSqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+zHzTlwCCGP/tMQWKcqpRHt+TVAqR85YEhbvXxASs8/IOf0xE0TAST5/R721waas3kPIpntk3R/VPych2/czqAQM8CyRWhdb5/BWI6xFv2yUh4u08ivDynJ5+P2/8m2qmA33eq17/cjdB7XxfviHdYPt4k2XxR4rtNUvl3GR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeIywNGF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so54008b3a.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776379491; x=1776984291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqyYEqZgyMpoZKxskZj0QRqQl7ttahHyrPikYOVHCGs=;
        b=VeIywNGFDT898urzHsB6Lhv0CzlE8C3vn6rrp3ax65KnTTLVOjOmQaJ+bco7wSJcEK
         Uy2LteuxTCZUjkfGmcCfIm4Fo2uEZTOoWx5DyDzyt9YbtQhMuczlsGBBysKy9fqF8fpu
         KecMu0Mc4aRkDSV5sL7F5BhQtELHwHFx5LOSL/h6sLPYcGPdO68JwgPnKMwqygpU5OsU
         wYtHN1iyi0qbTfX9FV81jWlwUJHqQnESeK1b9u3YR1ZmbdLLxZZNcW/3Swyvej0rCDDe
         9ZQDd3gYL35i9oiaMKBf1YXy9Vm18CoXnTB4wWFJQSeoqAdWfBeUctSDwor4lSHE2cal
         jfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379491; x=1776984291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqyYEqZgyMpoZKxskZj0QRqQl7ttahHyrPikYOVHCGs=;
        b=gDcxqBMRsRMYRNzzyNjYaZlSXjmT1vkPKa2Hm9VUn/JwjE37ns9nYysD1ATWkOmpQ/
         hr/CSJQoEc6728AYLJ4KRsK92W5dDEEaij4JPtaTwo4NUoeM8iBDbndj4vBRv8qSNJIJ
         i/ojd3z0u6YhKQoKMUnpTu45ERk55XnPBZuiNify/o5HVPw6PP0mXc05dKbagDGIyECz
         mHOjaTd/2vXdnZaHGXH+b+C82h+EXZMD7KfF38rc5RCCcOgVw4i9FioTC19Lizlw4uIS
         eaIOpfUW2cTrw64fOPUkPrrmJwp3x9buFsSUKKLHC6MYVCEbA+EAEZ5eTdlm68Cm34G0
         DYKg==
X-Forwarded-Encrypted: i=1; AFNElJ90cnZKdqi8a9Qtb3dMEIYDmH2kJ+2v1DW66LSlNvgMsMwsWUiZxaa7+d5rd5/mo/2a7e/BuCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMpVwZm6zExqVZwHduPnch+Hj6FsR5v9mh4spqpz/AuKAg6Ui
	L6PvPe2rBYMb+bJExMAyZi0BLi19G8tN6iMPu1Q38X5ArlOJy/6F/V6PqwSAXi6Pd2aaLM87ToU
	qC1kJRQ==
X-Received: from pfbho13.prod.google.com ([2002:a05:6a00:880d:b0:7ba:8e68:3140])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:439b:b0:82f:8696:5a75
 with SMTP id d2e1a72fcca58-82f8c8bb700mr145981b3a.28.1776379491191; Thu, 16
 Apr 2026 15:44:51 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:44:49 -0700
In-Reply-To: <20260414-vmscape-bhb-v10-8-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com> <20260414-vmscape-bhb-v10-8-efa924abae5f@linux.intel.com>
Message-ID: <aeFmYd1ybZnVlAYW@google.com>
Subject: Re: [PATCH v10 08/12] kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279179-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB7EF415564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026, Pawan Gupta wrote:
> EXPORT_SYMBOL_FOR_KVM() exists to export symbols to KVM modules. Static
> calls need the same treatment when the core kernel defines a static_call
> that KVM needs access to (e.g. from a VM-exit path).
> 
> Define EXPORT_STATIC_CALL_FOR_KVM() as the static_call analogue of
> EXPORT_SYMBOL_FOR_KVM(). The same three-way logic applies:
> 
>   - KVM_SUB_MODULES defined: export to "kvm," plus all sub-modules
>   - KVM=m, no sub-modules: export to "kvm" only
>   - KVM built-in: no export needed (noop)
> 
> As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override the
> definition (e.g. to suppress the export when kvm.ko itself will not be
> built despite CONFIG_KVM=m). Add the x86 no-op override in
> arch/x86/include/asm/kvm_types.h for that case.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_types.h |  1 +
>  include/linux/kvm_types.h        | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
> index d7c704ed1be9..bceeaed2940e 100644
> --- a/arch/x86/include/asm/kvm_types.h
> +++ b/arch/x86/include/asm/kvm_types.h
> @@ -15,6 +15,7 @@
>   * at least one vendor module is enabled.
>   */
>  #define EXPORT_SYMBOL_FOR_KVM(symbol)
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
>  #endif
>  
>  #define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index a568d8e6f4e8..c81f4fdba625 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -13,6 +13,8 @@
>  	EXPORT_SYMBOL_FOR_MODULES(symbol, __stringify(KVM_SUB_MODULES))
>  #define EXPORT_SYMBOL_FOR_KVM(symbol) \
>  	EXPORT_SYMBOL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol) \
> +	EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm," __stringify(KVM_SUB_MODULES))
>  #else
>  #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol)
>  /*
> @@ -27,7 +29,16 @@
>  #define EXPORT_SYMBOL_FOR_KVM(symbol)
>  #endif /* IS_MODULE(CONFIG_KVM) */
>  #endif /* EXPORT_SYMBOL_FOR_KVM */
> -#endif
> +
> +#ifndef EXPORT_STATIC_CALL_FOR_KVM
> +#if IS_MODULE(CONFIG_KVM)
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol) EXPORT_STATIC_CALL_FOR_MODULES(symbol, "kvm")
> +#else
> +#define EXPORT_STATIC_CALL_FOR_KVM(symbol)
> +#endif /* IS_MODULE(CONFIG_KVM) */
> +#endif /* EXPORT_STATIC_CALL_FOR_KVM */
> +
> +#endif /* KVM_SUB_MODULES */

I think I'd prefer to require EXPORT_SYMBOL_FOR_KVM and EXPORT_STATIC_CALL_FOR_KVM
to come as a pair from arch code.  I can't think of a scenario where arch code
should override one but not the other.  The end result is slightly less ugly :-)

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
+#else
+#ifndef EXPORT_STATIC_CALL_FOR_KVM
+#error Must #define EXPORT_STATIC_CALL_FOR_KVM if #defining EXPORT_SYMBOL_FOR_KVM
+#endif
 #endif /* EXPORT_SYMBOL_FOR_KVM */
-#endif
+#endif /* KVM_SUB_MODULES */
 
 #ifndef __ASSEMBLER__
 

base-commit: 56b7ace84970ff647b095849e80bc36c094760aa
--

