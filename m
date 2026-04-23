Return-Path: <netdev+bounces-280760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNMkLI8c6mntuQIAu9opvQ
	(envelope-from <netdev+bounces-280760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:20:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD092452BEC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 704673019625
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48963F23A1;
	Thu, 23 Apr 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ph4tBiup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA383F0A91
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949983; cv=none; b=muYEx8aKOOHgsEn2iTd6gt9R+PrafXAWZrjBCNk8jlu7gG5/t3xZ2ZbO4xZWDit8qIFc0oSJ2TYJwKpLl8lhaafybGFbrx1jBR27bdkQdck4lAo/hHqKWyX66Dca1i2KwI7i2ayDwNvz8UFTRog90sCi9ZISpsVFIUOLxNnfV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949983; c=relaxed/simple;
	bh=OFPsVUKTkkJPaSLrVoEdb9zPLdAMuapXjHJIMHyQpqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opthv4JlJKbnwolYYikJpJqSSTRXWjoYv7/uqHohni3pGIlfNuW72SM8d1NBoebmeNoszeuS4iSs1IeSJFuIKjNZHJvenzziGsS4W2Di+EfhIwmyp+5ec+/SZudv/YLrCmO/9YWo4K7HU6J7DafQyBPEr3676VhdvM985I5kmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ph4tBiup; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79744a2d99so2905242a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776949981; x=1777554781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gKFsUpIcJrOZ7JV012cOGqmLlLh75Tdbz6kdKZGcdk=;
        b=ph4tBiupjuLp6t/sTgxD1XKl1wEf5iYcYhvGnRrqD4t1vCR6kfvWJKwW8NFxZKOg5A
         YWOgnN4RlxtFofD33JhSbYF+ttQQlRuC0XMpZF5aLlUIpjpG8cgAvch59hv0of20jvIU
         lGCdY3mei3SBG69+W5naU3Spr8cC0ThfxUh5xA7NXp6jiyeWQOHVE/rWzePhgoi+wQXR
         3THDivfKBAAirFeT+zGeHqmemtiLtP2IfFlQ8ra033+J9fdp2viVLgsXs2YyzZqQBK6x
         oKacUrNjZJ86LwU2h6Ojh+7NfbOmriJzJ6KbnhXs04VSHsdDCtAu+IUWpGAzMajY5iAi
         HTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949981; x=1777554781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gKFsUpIcJrOZ7JV012cOGqmLlLh75Tdbz6kdKZGcdk=;
        b=Qf8ZoboN9rQvnnJjT5tGdkQX/fD4vr8KgzkksgvxRoKrl59ZYsibPFbVzbo4Cmbpj0
         ee07S/yrLp6Y18iWw0gZqPrg9jjxssukirIeaKsWrxzoPQ+1xX5+XTQQBx7cMrZB7844
         yV5WBf2iH6THccxtO9durcBQ5buFvC0XccuMDeU2Aptgx0XD43VgiqTWw+t/l/JA+B+o
         8B4U7PxwLdmH0rGcCVShuVpgMA6N/f2964DqWLqoxGbEBkImBIUHEyyaUzWc+2ZvKFj6
         KF1EfZsg+0j1iwYHM/caYkwmThKzdl+GX0NJE49EWAooD/V6HwjWkC/nJLuuG2lib9cO
         NfJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Quakvy02CMYtmFs+Wevwy9EwspvKCL5t0czdMY5fKpmmnqNlPYyTHdf2VzJ9/UaaDSxK2dP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHjuDEsD+GGdvxGcDBxnptIyvnbJ76Ol8rcceQm+wUJUCwQxa
	/QZxYoYsYssOCODJDMIddoRKSsiq/+oyAChoH++46ZXy9+lNj9zDmtxGz4omjcrJvOcjcQueshq
	/vxVHqA==
X-Received: from pfbiv33.prod.google.com ([2002:a05:6a00:66e1:b0:82f:1051:621])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a883:b0:829:6f7d:3093
 with SMTP id d2e1a72fcca58-82f8c9ece1emr28281470b3a.48.1776949980819; Thu, 23
 Apr 2026 06:13:00 -0700 (PDT)
Date: Thu, 23 Apr 2026 06:12:59 -0700
In-Reply-To: <20260422-vmscape-bhb-v11-8-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com> <20260422-vmscape-bhb-v11-8-b18e0cf32af4@linux.intel.com>
Message-ID: <aeoa2yM2gq8Llype@google.com>
Subject: Re: [PATCH v11 08/12] kvm: Define EXPORT_STATIC_CALL_FOR_KVM()
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,akamai.com,goodmis.org,linuxfoundation.org,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-280760-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[42];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CD092452BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Uber nit (don't bother with a new version), please capitalize KVM:

On Wed, Apr 22, 2026, Pawan Gupta wrote:
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
>   As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override both
>   macros (e.g. to suppress the export when kvm.ko itself will not be
>   built despite CONFIG_KVM=m). Add the x86 no-op overrides in
>   arch/x86/include/asm/kvm_types.h for that case. To keep the pair in
>   sync, EXPORT_STATIC_CALL_FOR_KVM() is defined inside the
>   EXPORT_SYMBOL_FOR_KVM #ifndef block; an arch that defines
>   EXPORT_SYMBOL_FOR_KVM must also define EXPORT_STATIC_CALL_FOR_KVM or the
>   build will fail with a compile-time error.
> 
> As with EXPORT_SYMBOL_FOR_KVM(), allow architectures to override
> EXPORT_STATIC_CALL_FOR_KVM definition (e.g. to suppress the export when
> kvm.ko itself will not be built despite CONFIG_KVM=m). Add the x86 no-op
> override in arch/x86/include/asm/kvm_types.h for that case.
> 
> Architectures must also define EXPORT_STATIC_CALL_FOR_KVM when they define
> EXPORT_SYMBOL_FOR_KVM.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

