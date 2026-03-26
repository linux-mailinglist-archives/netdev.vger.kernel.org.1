Return-Path: <netdev+bounces-271945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE8zAvr7xGny5QQAu9opvQ
	(envelope-from <netdev+bounces-271945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:27:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A767F332503
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6B530440BC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7FA2ED846;
	Thu, 26 Mar 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YepfNsf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC62DB787
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516559; cv=none; b=loQSDf0SwfTSNfCSBQNEprgasNVdegmGaRQLTViS/yhuh56YJBQ2Fie7chz970tedhpCsM/Aue+IwZPc59KYLuHDeF8UebVqbDqbylSgzpperJlW5rvIjRfkNHwQnch3Xt+SquPkq/yMAFwTQwzheAy5ykgHq9GDtx9emF0OWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516559; c=relaxed/simple;
	bh=vuXIxAlE+8VDPmKuy3kgKQSNmOeDUZC6172+muiSKao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz/VYxcjSORmd9lrBkEOiHIEkEFt2TOlG9uhWEWMPT/qpMiDSdYnuE7OVAZiBpriCIGduiqQuYroCQuTtGewtOGRg512SZzcb4UiYk5Zi/BlWIB0ReOyndfhST795fvc6P+sN4jrlYDnRkmTNyjPAO6qX3M6qaWhVEzyI5na+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YepfNsf2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so8895775e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516556; x=1775121356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMTJK/EQaff6wJVDA7nxhfImBcBFjA6yOuaHGNzrGu8=;
        b=YepfNsf2/dAhq0QSAF2FPzq7AU58TQmQheCcpPSOge89kz0swZ1HMzi/rvAonM9C+c
         BO0dZUIkuLg3P2gvOadR9AEtcTf3wR3ooPVZIcuq23f4xEZoxBXOhk9aUz/9gc5qQmaB
         rkMKTZ5eUgFtnjY8WkUiGVuKrcg0tfQYSU/FAys8BU3KVDEgFzj94z8XPfYYc4yidrR0
         EUgqLk7W0flOBXuHFqIemMm1uBgaysj1AHZ3CFd+P3mEXG9UuVyzOCGU1/9UVgVnwCv0
         0R4cxT0YmuKvAzjKrvLuiC7fooEm0AVoRFY31/nRiqli7ItKKh7UMnIJnH2FjU2VtKmw
         XeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516556; x=1775121356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMTJK/EQaff6wJVDA7nxhfImBcBFjA6yOuaHGNzrGu8=;
        b=bvQ7e12MPSCVHjakrF+MbvPKO3bp59IEsCY1xLSfCv2812YkOTKq6mRwYXJvE+tqad
         PwQQQvN5gdNC0LyRFNpKCYWTeYJopLKbYe49cU8t9t+W9j+Tj4zUrXn25h4ryhDPKoFK
         Rx7ezd6EEDGRtvOUQlZcX6AkGf4q+EUgOXCvzWlols3Rl4dWFAwSLvhhKfPs6QgAVk0G
         v0Jjh49iJJA4YQhmPB4VAHkMzzz1C2wqnCr+8/7WRyo4pVOEPxZT4HVZKXYpW+acN8fE
         J93beBYEQhwyVATIVLebXjmvYLPTLZYirURbzjfRdpZQsT/NUDCywUKac92HCKs2P5dq
         ojRg==
X-Forwarded-Encrypted: i=1; AJvYcCXODFOvHQ31OuASuN87UHZJfyBYgUuRnai4j+jZVNfeK6M9hpacBHwPbn+cPDTkXLStjDZTDhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKim+TUJwJSiiFLvOttm4WSd4DE8MrNJOz5irDxKJXl/p/6os1
	O7lfThvAvAQDh+vsnMrazIEqF/vushx8Ei+/u+X2WPvdioIFSYBJSnaN
X-Gm-Gg: ATEYQzzUhz4TK3k1bkMC+R+k9AJkCGLkMenW36NkciOW38nc1LgERzgWAa1gXaLSAkT
	tgEqQ2CVgQ9ESmKJsYuDJ0/511rLyv7q4nvi35cknKb2XTJNeUDUGPylA8kEs230fb2B8WjJIkf
	x11+n2S8kJtRGBEafpeQhNvi5oWsuB6h9RGf39dXs+N/810j77cG5N4Vi67U6gt6j54xmozVv3e
	inlm/wA6sHE/T8tnYpzFYwUWRf7UEUR5AqJt2SNY2QFCOQXChjRe7HHSSmmkIi/CuIuDsz2qAj/
	+L3pE6rWamcBXJEkmJ/l9do4XVPkODYSJq//mBHm/1mlmBzNCHNUbN7LZIu5mTEkCS6EqXSAWN3
	UKYvekhFpl4cQ9nu+fZbfFjYdjme+pox/yRKQcCY7w9ZKxOPN9GON7Jy+cskI3AHmywUgQ7gSLz
	1TOP+83VACQ/YJrs/Knk1CC/DMV4jetRDullHNe2Prj6ce9UiN4+f1Z/tJkMKqX1RK
X-Received: by 2002:a05:600c:6087:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4871605a9a5mr95820565e9.18.1774516555572;
        Thu, 26 Mar 2026 02:15:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e533sm7731498f8f.2.2026.03.26.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:15:55 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:15:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jon Kohler
 <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260326091553.414752ee@pumpkin>
In-Reply-To: <20260326083934.fk4wyhe6rgiss34z@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271945-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[alien8.de,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A767F332503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 01:39:34 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Wed, Mar 25, 2026 at 09:37:59PM +0100, Borislav Petkov wrote:
> > On Tue, Mar 24, 2026 at 03:13:08PM -0700, Pawan Gupta wrote:  
> > > This is cleaner. A few things to consider are, CLEAR_BRANCH_HISTORY that
> > > calls clear_bhb_loop() would be calling into C code very early during the
> > > kernel entry. The code generated here may vary based on the compiler. Any
> > > indirect branch here would be security risk. This needs to be noinstr so
> > > that it can't be hijacked by probes and ftraces.
> > > 
> > > At kernel entry, calling into C before mitigations are applied is risky.  
> > 
> > You can write the above function in asm if you prefer - should still be
> > easier.  
> 
> I believe the equivalent for cpu_feature_enabled() in asm is the
> ALTERNATIVE. Please let me know if I am missing something.
> 
> Regarding your intent to move the loop count selection out of the BHB
> sequence, below is what I could come up. It is not as pretty as the C
> version, but it is trying to achieve something similar:

I think that fails on being harder to read and longer.
So no real benefit.

I believe this code has to be asm because it is required to excute
specific instructions in a specific order - you can't trust the C
compiler to do that for you.

	David

> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index ecae3cef9d8c..54c65b0a3f65 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1494,6 +1494,20 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
>  SYM_CODE_END(rewind_stack_and_make_dead)
>  .popsection
>  
> +/*
> + * Between the long and short version of BHB clear sequence, just the
> + * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
> + */
> +#define BHB_SHORT_LOOP_OUTER	5
> +#define BHB_SHORT_LOOP_INNER	5
> +
> +#define BHB_LONG_LOOP_OUTER	12
> +#define BHB_LONG_LOOP_INNER	7
> +
> +#define BHB_MOVB(type, reg)						\
> +	ALTERNATIVE __stringify(movb $BHB_SHORT_LOOP_##type, reg),	\
> +		    __stringify(movb $BHB_LONG_LOOP_##type, reg), X86_FEATURE_BHI_CTRL
> +
>  /*
>   * This sequence executes branches in order to remove user branch information
>   * from the branch history tracker in the Branch Predictor, therefore removing
> @@ -1540,12 +1554,7 @@ SYM_FUNC_START(clear_bhb_loop_nofence)
>  	/* BPF caller may require all registers to be preserved */
>  	push	%rax
>  
> -	/*
> -	 * Between the long and short version of BHB clear sequence, just the
> -	 * loop count differs based on BHI_CTRL, see Intel's BHI guidance.
> -	 */
> -	ALTERNATIVE "movb $5,  %al",	\
> -		    "movb $12, %al", X86_FEATURE_BHI_CTRL
> +	BHB_MOVB(OUTER, %al)
>  
>  	ANNOTATE_INTRA_FUNCTION_CALL
>  	call	1f
> @@ -1567,8 +1576,7 @@ SYM_FUNC_START(clear_bhb_loop_nofence)
>  	 * but some Clang versions (e.g. 18) don't like this.
>  	 */
>  	.skip 32 - 14, 0xcc
> -2:	ALTERNATIVE "movb $5, %ah",	\
> -		    "movb $7, %ah", X86_FEATURE_BHI_CTRL
> +2:	BHB_MOVB(INNER, %ah)
>  3:	jmp	4f
>  	nop
>  4:	sub	$1, %ah
> 
> 
> Below is how the disassembly looks like:
> 
> clear_bhb_loop_nofence:
> 	...
> 	call    1f
> 	jmp     5f
> 	// BHB_MOVB(OUTER, %al)
> 	mov    $0x5,%al


