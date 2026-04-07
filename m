Return-Path: <netdev+bounces-276134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NDjKfFW1Wmu4wcAu9opvQ
	(envelope-from <netdev+bounces-276134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 21:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B25AE3B3451
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD08A30147B3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0C34AAF7;
	Tue,  7 Apr 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brmo1u2X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA433E35B;
	Tue,  7 Apr 2026 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589100; cv=none; b=RFzQXz2pnD+qbo088wngC7kPx24kdacMfjHblyjK44KSpu+GoV6LYDw8pH6F9f1rc0b7rTTJWroLwwlrjgq4xhFJJ2wtupZ9GU58HTUtRK3wkifmC7Ngi5nQeIb5Mrdqlr1qj+JC9o3f9AMKfdl6Ptdupqix5Kx6oZ+aImHhhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589100; c=relaxed/simple;
	bh=1eTZaDaPMLqpdSYtorwnwSWTlbF1iszS3SXt9Qld5p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkcwUlMFJqxiOjHrBZInFa8MdH5F6Muk9Hhdl3rVVf5WxNh5qdxFLnhSQAut5y+SQslexBgX/f46GI54OMxRknXUoGjHGs3vWtxnhRD46ur29bYU5tsKvRADV1ndHq8UEs06UM9oXoewnpywdZ22pVzwW4aDuQft4Kue8518f3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brmo1u2X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775589098; x=1807125098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1eTZaDaPMLqpdSYtorwnwSWTlbF1iszS3SXt9Qld5p8=;
  b=brmo1u2X+dzCk+YWcolPe/mk5yNuW2jj0/uN19vZczIQWgPnwA84wHzF
   Ii/Y77iuXx9oWWKWvrDy3Jb5t/JMyiBazQ9ucMeyEMUfB0nqLlUxjAK7h
   Ltc1l5S+haDjZwJmdCP4LNz3n4LbYS3snpGXNzW+awqrK6rN23HPgWkp/
   txH6gWecxSeqRkqShQhMxVuA2rq0iZ+5L+YxY+Wb0IY5g+lgWiXqCUU+g
   6AJuPSpl+XSHp+450qTy6HwVjyP3zUsDw7xveGGGPJPXReeAalJTK7VA3
   IA/FLM0EK76E6MOYQgmpniBKZhaG90BACgOeRwrP6JK6dP23YCvLlfuPg
   g==;
X-CSE-ConnectionGUID: kGdcdCD5Q66L+30HcISRQg==
X-CSE-MsgGUID: Qbwu2k8QSySIB0XBTQl+WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86855746"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="86855746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 12:11:38 -0700
X-CSE-ConnectionGUID: K3BKmZE2QxOmuIeKaEHctA==
X-CSE-MsgGUID: vtTvIZBzRU+D/MxUmZoE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="232287983"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 12:11:37 -0700
Date: Tue, 7 Apr 2026 12:11:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	chao.gao@intel.com
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260407191128.b2hr2ttkdpyunhrr@desk>
References: <20260403233329.fb2ppifgwm3um6ny@desk>
 <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
 <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
 <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
 <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk>
 <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276134-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[39];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: B25AE3B3451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> On Tue, Apr 7, 2026 at 10:12 AM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Tue, Apr 07, 2026 at 09:46:07AM -0700, Jim Mattson wrote:
> > > On Tue, Apr 7, 2026 at 9:40 AM Pawan Gupta
> > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > >
> > > > On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> > > > > Yes, but the guest needs a way to determine whether the hypervisor
> > > > > will do what's necessary to make the short sequence effective. And, in
> > > > > particular, no KVM hypervisor today is prepared to do that.
> > > > >
> > > > > When running under a hypervisor, without BHI_CTRL and without any
> > > > > evidence to the contrary, the guest must assume that the longer
> > > > > sequence is necessary. At the very least, we need a CPUID or MSR bit
> > > > > that says, "the short BHB clearing sequence is adequate for this
> > > > > vCPU."
> > > >
> > > > After discussing this internally, the consensus is that the best path
> > > > forward is to add virtual SPEC_CTRL support to KVM, which also aligns with
> > > > Intel's guidance. In the long term, virtual SPEC_CTRL can benefit future
> > > > mitigations as well. As with many other mitigations (e.g. microcode), the
> > > > guest would rely on the host to enforce the appropriate protections.
> > >
> > > I don't think it's reasonable for the guest to rely on a future
> > > implementation to enforce the appropriate protections.
> > >
> > > This is already a problem today. If a guest sees that BHI_CTRL is
> > > unavailable, it will deploy the short BHB clearing sequence and
> > > declare that the vulnerability is mitigated. That isn't true if the
> > > guest is running on Alder Lake or newer.
> >
> > In any case, there is a change required in the kernel either for the guest
> > or the host, they both are future implementations. Why not implement the
> > one that is more future proof.
> 
> There will always be old hypervisors. True future-proofing requires
> that the guest be able to distinguish an old hypervisor from a new
> one.
> 
> My proposal is as follows:
> 
> 1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
> or MSR bit) that the short BHB clearing sequence is adequate. This may
> mean either that the VM will only be hosted on pre-Alder Lake hardware
> or that the hypervisor will set BHI_DIS_S behind the back of the
> guest. Presumably, this bit would not be reported if BHI_CTRL is
> advertised to the guest.
> 2. If the guest sees this bit, then it can use the short sequence. If
> it doesn't see this bit, it must use the long sequence.

Thats a good middle ground. Let me check with folks internally what they
think about defining a new software-only bit.

Third case, for a guest that doesn't want BHI_DIS_S, userspace should be
allowed to override setting BHI_DIS_S. Then this proposed bit can indicate
that long sequence is required.

