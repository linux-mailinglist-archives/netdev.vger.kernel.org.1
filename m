Return-Path: <netdev+bounces-272706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKIMxwkx2lATgUAu9opvQ
	(envelope-from <netdev+bounces-272706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:43:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D49334CC65
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAAF03036AE2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7D205E02;
	Sat, 28 Mar 2026 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUH2KR/2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039811FC0EF;
	Sat, 28 Mar 2026 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658583; cv=none; b=Rkp9C3p80jIBzgPw0iP3rWRV2BPOw+gbk+2aFtsWps8V2+AA55wiVXZLVWpKDtV+Upwzt0/NfsVNiamzi1PARRkjMZBC4DCHb2Bgx5vFXmXngTQ+7vvFt3hp+JCxrhmXRRyIQVTPt05iCXYU6X0iDMTbHKP4wPgN75LMGxxuGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658583; c=relaxed/simple;
	bh=7NSTQHAfTLzUwxbewhUsEMWtdbDebIbYLUZFZavLeDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5KwsUAAK4rbkKYCjyacb1f0EfoFaLsF/+5VOdN4fH284cHcWQhUupCJIE7G8DmhKnobUC3J4Ue878LuamW+inXbGvAfGwAZ18Wo8k2ZssRLDOfLkf2OunBYR5xQmEgTByfYiGvDpXCS/SYZu1mBM52n5SLK7au77/Nv/nEopvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUH2KR/2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774658582; x=1806194582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NSTQHAfTLzUwxbewhUsEMWtdbDebIbYLUZFZavLeDg=;
  b=LUH2KR/2cTnaQ30segD0hwq3e0Bh9q6n67OKtudrVOFN1G7SrxNKZA6w
   Cx+qCxnxuUaBsmM7E3rN5L5CEDtF2rvlR1URWSvOPTT3F6mrNXP225uvt
   qU8YDLOItJ8EukusaZPLcWu0qgJ2MsFM/6CT0xq6O/MI02QR02Wz1Jct/
   CJ14W+TBALaqjRfHac4R2XJDC7yrP1rYq56YZw0r9C5DP+pJ5kl6jFSFh
   I0gdlPaTHtBabClZ+EibyLVSO9cnCu6U18KS/Dh2qcHewdMxHZx5uYkNP
   a1Dp2+1HtoC9L2jP7QWcPPUUm4qp36Flgv4QnzYfSZSjN9fxtogotz2+g
   Q==;
X-CSE-ConnectionGUID: tvHgASnVSPG9Kv8o5DVH0A==
X-CSE-MsgGUID: wwlSCmctSFG4Scz8wPdaaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75935237"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="75935237"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 17:43:01 -0700
X-CSE-ConnectionGUID: IWJPWWYgSgyOxbjfYtEolg==
X-CSE-MsgGUID: plpu0+QbQhqAtYmA408DUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="263411944"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 17:43:02 -0700
Date: Fri, 27 Mar 2026 17:42:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jon Kohler <jon@nutanix.com>,
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
Message-ID: <20260328004256.mm2ttj5iwvu5kdpa@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
 <20260324221308.7sh6afdy6r6tsf4w@desk>
 <20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
 <20260326083934.fk4wyhe6rgiss34z@desk>
 <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
 <20260326104557.24295cbb@pumpkin>
 <20260326202931.wlggnd3nfj6hngpb@desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326202931.wlggnd3nfj6hngpb@desk>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272706-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[alien8.de,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: 5D49334CC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:
> On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:
> > On Thu, 26 Mar 2026 11:01:20 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> > 
> > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:
> > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > ALTERNATIVE. Please let me know if I am missing something.  
> > > 
> > > Yes, you are.
> > > 
> > > The point is that you don't want to stick those alternative calls inside some
> > > magic bhb_loop function but hand them in from the outside, as function
> > > arguments.
> > > 
> > > Basically what I did.
> > > 
> > > Then you were worried about this being C code and it had to be noinstr... So
> > > that outer function can be rewritten in asm, I think, and still keep it well
> > > separate.
> > > 
> > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > 
> > 
> > I think someone tried getting C code to write the values to global data
> > and getting the asm to read them.
> > That got discounted because it spilt things between two largely unrelated files.
> 
> 
> The implementation with global variables wasn't that bad, let me revive it.
> 
> This part which ties sequence to BHI mitigation, which is not ideal,
> (because VMSCAPE also uses it) it does seems a cleaner option.
> 
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> 
>  static void __init bhi_update_mitigation(void)
>  {
> +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> +       bhi_seq_outer_loop = 5;
> +       bhi_seq_inner_loop = 5;
> +   }
> +
> 
> I believe this can be moved to somewhere common to all mitigations.
> 
> > I think the BPF code would need significant refactoring to call a C function.
> 
> Ya, true. Will use globals and keep clear_bhb_loop() in asm.

While testing this approach, I noticed that syscalls were suffering an 8%
regression on ICX for Native BHI mitigation:

  $ perf bench syscall basic -l 100000000

Bisection pointed to the change for using 8-bit registers (al/ah replacing
eax/ecx) as the main contributor to the regression. (Global variables added
a bit, but within noise).

Further digging revealed a strange behavior, using %ah for the inner loop
was causing the regression, interchanging %al and %ah in the loops
(for movb and sub) eliminated the regression.

<clear_bhb_loop_nofence>:

	movb	bhb_seq_outer_loop(%rip), %al

	call	1f
	jmp	5f
1:	call	2f
.Lret1:	RET
2:	movb	bhb_seq_inner_loop(%rip), %ah
3:	jmp	4f
	nop
4:	sub	$1, %ah <---- No regression with %al here
	jnz	3b
	sub	$1, %al
	jnz	1b

My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
inner loop, which is executed more number of times is likely making the
difference. A perf profile is needed to confirm this.

Never imagined a register selection can make an 8% difference in
performance! Anyways, will update the patch with this finding.

