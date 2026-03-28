Return-Path: <netdev+bounces-272782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE6yAmb1x2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:36:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36C34EEDE
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0074300C570
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA633FE0D;
	Sat, 28 Mar 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoTVolg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064C33C50D
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712149; cv=none; b=Af0YDqt9w3C4KZxlUQR/CY5uNmbi95ex7uJDwXI6fpGhAl+HqOFrhQlW0LNfX4TWboxqekQp8CTwCt1M1wIveo0aS89PPy4BqdyVFBpFNvsIeOCXNsWsqOECvua3ujRO8dkfGj4mGA6XrOIxH2W8oe+jAeRZ4THcwtRH2PFjzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712149; c=relaxed/simple;
	bh=/GEXZkmKX4s9b/SmUpPLX93M0m6mbEsjeCZUiizWuRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InuywfR1+D3e0H4/nsL4SjwYKytCzghC4xMUgmydGflsKg9Cs6b4mU7NbtqH2Ey4iFItb2btIJ4DKScFOTPyRivjqY0rMHyJBGAbkkrO6d4SmNHxgnim5Ti4gJyLNXB+f1CPUcS+5IFOzWfF640WC+mldslo6c88n6ElsCbwQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoTVolg7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38c551f2497so28454711fa.2
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712146; x=1775316946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=eoTVolg7zd8KhH+yIogej5U0rkho/1ydJNjKzMD4H/mbWSwe1K4QL2bLJXATkZ2sX9
         gjvZ63dlh8bFBLEsz57lYbqG+aGbi4t+VsIoUMmBkrFZeVND8ZAhL4cPmUFdyk6SwyDc
         jcDGAxI/o3D+wnXseqc5foW5ndzBbcrx0YYYfILuKgivw54+rosQa8csZPx8mnyo+KuX
         h6L+x+DCKlnxq8nTXtyQZJ+PHBkhooTV08ot+lANCB+6I+yCYqMTDOTGAg/ywzBgjbLO
         j8Xmi/Fwd363yBYLhzQNPfFyPJ8n0A3jcqX9gjjbjN4+xKmIujS73MbNVQuVgFr2nwcx
         Di4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712146; x=1775316946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=S3R39kBV1yZtA/599Ho3PWgQ0AKRtcazRYv9XvFmcDym/Rm+rIjhypxJCK/vDsHQ+Z
         TrOSe2bsyoRI9nNS3LNbTJa9O/6Lf3e3j/FGj6vtxz5WB8TW/cUBGZmmnRlCMq+Z+vy/
         diJgXB/gtZ7DsSzyOJGCO/9zp24V5EHx5PAAygYdVJOzidLb5BkL6Ju1622i9phVT7tO
         OE7EopIahiWTCEhXddhXJiiZNa71OiH8UUwefYGPpn1tTglpsFXOH25P09gry8deUGkr
         0DjrmCv+nSqnLYvK6p6Qo3qskmQH8fzIENjAx0G4rkc/5yoRks/bazo5IHgxAvwWHuNB
         LorA==
X-Forwarded-Encrypted: i=1; AJvYcCWTKYhyewHjE4TwGmc0fxrIiU8pUUP+w8D0NCut3vbxOgHLyz3wyQMQuQ7OnjsaMMUnUdgDdpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgM+jyr+IuDiUmOeafGMPDXSiHbrcRuvG+CeDa/lVZNoxqYkG
	Ls2q+koR00FnOom4Ld9+uWJPAk8Yx62lfKs4CXLHXsrm/710C9lU0ynr
X-Gm-Gg: ATEYQzyb0DP4umfPN9479m3198CbonjSQvNnvXOjBpFbnEtjrY/PYFhwVmP/qFV4fZB
	z9jhsIBZcRxWN6UGKBGY3lO28DpWYT/AcpKzoO+P8hNeXvw01GQDERWvrMWdgNAd6LgAok28QJ3
	rCQahUGilTr2LngOQfYBjqtJ1EFuK9SLQ5C0Ia9IiZL4y/5MPLVoUam3BztULh0ioRjMKVS6iBI
	efpg9BC5CbogKT52kMyjiNcM6rmQgnRMZFYcICh14P50JxzXpbp2G6SWyjR/Dxg/InlbMeAnmxn
	Z6zAWKJJ5wEu1qArjqa+9PHG/y5doyODb7d7FSHKs+4aIKPwPwJPOjfWHV+Z/cQ5kcnkbyFh/ZR
	QSx/jKN0sulyO5olqfkiP2vDW5/WKylPmvycXP584icUP3BiXHcPZQoZ2vSw7N7z08a9F5ArE1I
	gXwg71PHlgIIe6eN+Y/8eap6wvh8d86eh5eOCWmbLUauuR3dcYLhmjJ6UmFc4ZhG7X
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr86841645e9.15.1774692519962;
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872716799dsm32314725e9.25.2026.03.28.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Date: Sat, 28 Mar 2026 10:08:37 +0000
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
Message-ID: <20260328100837.7e6dc7fe@pumpkin>
In-Reply-To: <20260328004256.mm2ttj5iwvu5kdpa@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
	<20260326104557.24295cbb@pumpkin>
	<20260326202931.wlggnd3nfj6hngpb@desk>
	<20260328004256.mm2ttj5iwvu5kdpa@desk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272782-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: EA36C34EEDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 17:42:56 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:
> > On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:  
> > > On Thu, 26 Mar 2026 11:01:20 +0100
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >   
> > > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:  
> > > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > > ALTERNATIVE. Please let me know if I am missing something.    
> > > > 
> > > > Yes, you are.
> > > > 
> > > > The point is that you don't want to stick those alternative calls inside some
> > > > magic bhb_loop function but hand them in from the outside, as function
> > > > arguments.
> > > > 
> > > > Basically what I did.
> > > > 
> > > > Then you were worried about this being C code and it had to be noinstr... So
> > > > that outer function can be rewritten in asm, I think, and still keep it well
> > > > separate.
> > > > 
> > > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > >   
> > > 
> > > I think someone tried getting C code to write the values to global data
> > > and getting the asm to read them.
> > > That got discounted because it spilt things between two largely unrelated files.  
> > 
> > 
> > The implementation with global variables wasn't that bad, let me revive it.
> > 
> > This part which ties sequence to BHI mitigation, which is not ideal,
> > (because VMSCAPE also uses it) it does seems a cleaner option.
> > 
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> > 
> >  static void __init bhi_update_mitigation(void)
> >  {
> > +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > +       bhi_seq_outer_loop = 5;
> > +       bhi_seq_inner_loop = 5;
> > +   }
> > +
> > 
> > I believe this can be moved to somewhere common to all mitigations.
> >   
> > > I think the BPF code would need significant refactoring to call a C function.  
> > 
> > Ya, true. Will use globals and keep clear_bhb_loop() in asm.  
> 
> While testing this approach, I noticed that syscalls were suffering an 8%
> regression on ICX for Native BHI mitigation:
> 
>   $ perf bench syscall basic -l 100000000
> 
> Bisection pointed to the change for using 8-bit registers (al/ah replacing
> eax/ecx) as the main contributor to the regression. (Global variables added
> a bit, but within noise).
> 
> Further digging revealed a strange behavior, using %ah for the inner loop
> was causing the regression, interchanging %al and %ah in the loops
> (for movb and sub) eliminated the regression.
> 
> <clear_bhb_loop_nofence>:
> 
> 	movb	bhb_seq_outer_loop(%rip), %al
> 
> 	call	1f
> 	jmp	5f
> 1:	call	2f
> .Lret1:	RET
> 2:	movb	bhb_seq_inner_loop(%rip), %ah
> 3:	jmp	4f
> 	nop
> 4:	sub	$1, %ah <---- No regression with %al here
> 	jnz	3b
> 	sub	$1, %al
> 	jnz	1b
> 
> My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
> inner loop, which is executed more number of times is likely making the
> difference. A perf profile is needed to confirm this.

I bet it is also CPU dependant - it is quite likely that there isn't
any special hardware to support partial writes of %ah so it ends up taking
a slow path (possibly even a microcoded one to get an 8% regression).

As well as swapping %al <-> %ah try changing the outer loop decrement to
	sub $0x100, %ax
since %al is zero that will set the z flag the same.

I've just hacked a test into some test code I've got.
I'm not seeing an unexpected costs on either zen-5 or haswell.
So it may be more subtle.

	David


> 
> Never imagined a register selection can make an 8% difference in
> performance! Anyways, will update the patch with this finding.


