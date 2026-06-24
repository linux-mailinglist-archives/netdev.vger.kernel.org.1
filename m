Return-Path: <netdev+bounces-301792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CCaTIUlUPGoXmwgAu9opvQ
	(envelope-from <netdev+bounces-301792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ACE6C1ACF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kt8Q55al;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301792-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC803037173
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2930C618;
	Wed, 24 Jun 2026 22:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CE2517AF
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:03:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338609; cv=none; b=a0nQU/cEBrUJWO0BJHb6O1T+n5qcJkAr+w8ANRcpigUe5wZboDczuSiHWeFRAXZqqfBi6+mZOt4HWWvNrRJP4DcIfPNC1POsxkkmxS3YTOw8U2zrU4FGnOsjsPOIPoy87odGGTWKKeB700VC49UAv/gfpT9G6C6z9dGKBZ3DKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338609; c=relaxed/simple;
	bh=r5g6+V2Amp0yxvechpGrRZ8S0WXq2V+a9zpffLkRRbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8Craz0UAdGmjn+qUPu6EI/RPnZ547T4I4cbGBJgkhWJ/h6SFFaFOj8XM2XC6rm+IBHK6TP6J2z6KuL/WZpTFAXrtVhEqhbb2M+WGCE7YS3vlNcQRdgf4lpO3zVR1O/3a1ezBSxsn4Xf47F7xG29c5rjhaCrAsXFhclxFkHlCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kt8Q55al; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7ef3cc6d4so4526855ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782338607; x=1782943407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrxdfhnpHc3n007Ugb6QRVTz2pRJtP7mIebzaELjk+Q=;
        b=kt8Q55alaDwoCFWKoa5bV7LcIVUuvYZ+cxeB620+DGabur7nuY8PEpVyhUSxvSnco4
         OSwgjFGL9Eu0eZVhBoN19wU18B6Zd8Ea0vlTaDTPYK4VpqcUoKGVSZdsrtK/VVYBxi3m
         LOhFO78H2yV26E0pldjYBn/V1VvlesUVLbaVSI4LErRM9eVH488NhvbpjAglQjz3wxX2
         F25V9ad6yPEW03J1fq69n5YEhpiMbb/ikzkY+aBne+O3cwFts9p045oRm2sQP4pem8LF
         G7rXCZ8D0e3jIfuOEACMzP5ulS7A5gVxxS+BcFHQyMJZ4QTJ15nam/3pnnT8VQBwOQ8l
         FZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338607; x=1782943407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrxdfhnpHc3n007Ugb6QRVTz2pRJtP7mIebzaELjk+Q=;
        b=ojUr0EGKhAqQlLZz0FgPA/xbGlIRBlwFvAJaX14l+7fPePixggV9ofybwgg1PoyJ85
         tUuXMAzXOTh3AXl83IL2UVUCjd9jSFM96uiHlyzSyWS7QKzH6y9DciLKMnBkzoxmqypc
         /MOmBB6gUo2aoyAtTHAVmbzfArjoVTtl78YFcUVeD61uzYeDLBwahbyKZoVKFJqWlqRH
         cFUiNZVTH+UQLy0mnRmU2ASe10GY4AhPxClde9+6nEN2otUs1CGNy7/GcNAGk8+uEZwj
         9yrAAuH1ereo9hPGA51TH/zYXxLZdIsPkWZkSm8PuW4sS1rQTVIfXvy9KdmxmrMjg7A7
         H37Q==
X-Forwarded-Encrypted: i=1; AHgh+RqNubBCuBjd2zoHK36VhgnDL4XV8ro3CMc/1uOXuZCBMWerHgfnl62E+wqF0bUPHJtUmQuY1wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/l4TVVxinqeSa+Z19JfuONhbZr5Ii0OdI4EnrVDxEZtlI3dRI
	9fYxig8BHrHsB+WbXGwpcMaqqf4Jp7rVlK/Mdp72I+inZOqkRonhBAVkzt6Iq5XL8A59ESGuius
	xinZXmw==
X-Received: from plbl20.prod.google.com ([2002:a17:902:eb14:b0:2c7:e126:e2ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d0:b0:2c2:21e9:5a7d
 with SMTP id d9443c01a7336-2c7fc8a9b4fmr173895ad.34.1782338606050; Wed, 24
 Jun 2026 15:03:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 22:03:25 +0000
In-Reply-To: <20260624214955.6kkivefeuapcocib@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-7-76cbda0ae3e5@linux.intel.com> <ajvUp_kPJBRZ7k_p@google.com>
 <20260624214955.6kkivefeuapcocib@desk>
Message-ID: <ajxULasZkCS57NPq@google.com>
Subject: Re: [PATCH v12 07/12] static_call: Define EXPORT_STATIC_CALL_FOR_MODULES()
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301792-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[seanjc@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_RECIPIENTS(0.00)[m:pawan.kumar.gupta@linux.intel.com,m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:davidlaightlinux@gmail.com,m:johnfastab
 end@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,akamai.com,goodmis.org,linuxfoundation.org,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0ACE6C1ACF

On Wed, Jun 24, 2026, Pawan Gupta wrote:
> On Wed, Jun 24, 2026 at 05:59:19AM -0700, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Pawan Gupta wrote:
> > > There is EXPORT_STATIC_CALL_TRAMP() that hides the static key from all
> > > modules. But there is no equivalent of EXPORT_SYMBOL_FOR_MODULES() to
> > > restrict symbol visibility to only certain modules.
> > > 
> > > Add EXPORT_STATIC_CALL_FOR_MODULES(name, mods) that wraps both the key and
> > > the trampoline with EXPORT_SYMBOL_FOR_MODULES(), allowing only a limited
> > > set of modules to see and update the static key.
> > > 
> > > The immediate user is KVM, in the following commit.
> > > 
> > > checkpatch reported below warnings with this change that I believe don't
> > > apply in this case:
> > > 
> > >   include/linux/static_call.h:219: WARNING: Non-declarative macros with multiple statements should be enclosed in a do - while loop
> > >   include/linux/static_call.h:220: WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > 
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---

...

> > Drat, I forgot about this.  Exporting static call trampolines for KVM came up in
> > another conversation[*].  I had already put together patches to effectively default
> > to exporting only the trampoline, and also to deduplicate this code so that the
> > CONFIG_HAVE_STATIC_CALL_INLINE=y / CONFIG_HAVE_STATIC_CALL=y / CONFIG_HAVE_STATIC_CALL=n
> > implementations don't need to copy+paste the same lines of code.
> > 
> > The attached patches touch a lot more code, and will conflict mightily with KVM
> > changes I want to land in 7.3 (more use of a static_call in KVM).  But if we get
> > them applied (to tip tree) shortly after 7.2-rc1 and provide a topic branch/tag,
> > then there shouldn't be too much juggling needed?
> > 
> > If we want to go with the more aggressive cleanup, I'll formally post the patches.
> > 
> > [*] https://lore.kernel.org/all/ahhoDGUz39KSGZ6o@google.com
> 
> Thanks for the context.
> 
> Earlier making the key ro-after-init came up as an option in a thread with
> Peter. Does it look like a good option to you?

No, it won't work for KVM.  kvm.ko (owner of the keys) updates the keys only when
a vendor module (kvm-intel.ko or kvm-amd.ko) is loaded, and updates keys *every*
time a vendor module is loaded.  So for KVM, the static calls need to be __read_mostly,
not __ro_after_init.

> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index b610afd1ed55..ea56da8fb446 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -200,6 +200,14 @@ extern long __static_call_return0(void);
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>  
> +#define DEFINE_STATIC_CALL_NULL_RO_AFTER_INIT(name, _func)		\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key STATIC_CALL_KEY(name) __ro_after_init = {\
> +		.func = _func,						\
> +		.type = 1,						\
> +	};								\
> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> +
>  #define DEFINE_STATIC_CALL_RET0(name, _func)				\
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\

