Return-Path: <netdev+bounces-275281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AkQwFkZK0Glo5wYAu9opvQ
	(envelope-from <netdev+bounces-275281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D3399017
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90B93026165
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC833612F3;
	Fri,  3 Apr 2026 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqhoIoYw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349EA358399;
	Fri,  3 Apr 2026 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258179; cv=none; b=eR7rrs9JsENHKUWuFvC8M0ZvF79sVqKOWcJb7ITautg6hSgsVeWSJnzUY7w/dTztqZGNjxyn1B4tW/a0xhED+jVgwiM5ZZosuROd3G4EZxe3yG6e7X4U5x2IJ+hTCbiuHSK8i0dSSrajL4w1lA4W0HbXXnhpkbCy5AcXeFM3SGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258179; c=relaxed/simple;
	bh=EHy9QxSViQcZhCLgN+aOsMYMH25suitkUYTNfE9PU18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF7yEOgh/XXiTh/ZUTTwtgtpa6Srb+oNcu7P7VU+jKrSf04pkGJpnL8m0p/YDkWr/pdnNGYbZxhFH73JGSmPEVoNTMzCuZvA6T2RYQhZWuqwEVg8AeVxFZK1Crnv2KHnfv1oe4QpevXwpR7is0nVMleCsCwhcy4QQkSW1NC5tDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqhoIoYw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775258177; x=1806794177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EHy9QxSViQcZhCLgN+aOsMYMH25suitkUYTNfE9PU18=;
  b=aqhoIoYwBwzC0fUNdXe2r8IxupaGq8BzcVnGsiaVHwQ7dkO3VjrtNlqn
   g7Hzx0MvG9QZcGSXS4PXh5FYdIxq6oj+U1dOhfYVANn+2wB2OgcvmlI8G
   fpQX9jdqnFSSyyw8z18wCpalfXumP2YnmJim5UQUfGOR9u82iIE/RWxr9
   FPUuBcydFMyVE14XY0n1W6VNIJArkV7GNu9IyWWGM97kyg47/IaYtIAru
   5DX4VePb0fdgOmdkiyFaqFayLpUm9ldQdv/fD3jp7UOnRIoQleVmfLwAZ
   Jhjd7EvMiTd0iCar7uKW5ycS4xl8Jdjjf1VtwfaAI3f8+shNAWaj5qPGs
   w==;
X-CSE-ConnectionGUID: wZTOm060QL6NQgAV3Qh8mw==
X-CSE-MsgGUID: TSw6fX8vSSytdHavru1d2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76385873"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76385873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 16:16:16 -0700
X-CSE-ConnectionGUID: uQTi6Y1EQraWMGfyRqOYxg==
X-CSE-MsgGUID: 19+LjM0GTjWYMq2dnjIdjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250587794"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 16:16:15 -0700
Date: Fri, 3 Apr 2026 16:16:08 -0700
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
Message-ID: <20260403231608.zopnhnypdclzqlx7@desk>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk>
 <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk>
 <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275281-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 598D3399017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 02:59:33PM -0700, Jim Mattson wrote:
> On Fri, Apr 3, 2026 at 2:34 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Fri, Apr 03, 2026 at 01:19:17PM -0700, Jim Mattson wrote:
> > > On Fri, Apr 3, 2026 at 11:52 AM Pawan Gupta
> > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > >
> > > > On Fri, Apr 03, 2026 at 11:10:08AM -0700, Jim Mattson wrote:
> > > > > On Thu, Apr 2, 2026 at 5:32 PM Pawan Gupta
> > > > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > >
> > > > > > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> > > > > > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > > > > > sequence is not sufficient because it doesn't clear enough entries. This
> > > > > > was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> > > > > > in the kernel.
> > > > > >
> > > > > > Now with VMSCAPE (BHI variant) it is also required to isolate branch
> > > > > > history between guests and userspace. Since BHI_DIS_S only protects the
> > > > > > kernel, the newer CPUs also use IBPB.
> > > > > >
> > > > > > A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> > > > > > But it currently does not clear enough BHB entries to be effective on newer
> > > > > > CPUs with larger BHB. At boot, dynamically set the loop count of
> > > > > > clear_bhb_loop() such that it is effective on newer CPUs too. Use the
> > > > > > X86_FEATURE_BHI_CTRL feature flag to select the appropriate loop count.
> > > > > >
> > > > > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > > > > ---
> > > > > >  arch/x86/entry/entry_64.S            |  8 +++++---
> > > > > >  arch/x86/include/asm/nospec-branch.h |  2 ++
> > > > > >  arch/x86/kernel/cpu/bugs.c           | 13 +++++++++++++
> > > > > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > > > > > index 3a180a36ca0e..bbd4b1c7ec04 100644
> > > > > > --- a/arch/x86/entry/entry_64.S
> > > > > > +++ b/arch/x86/entry/entry_64.S
> > > > > > @@ -1536,7 +1536,9 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > >         ANNOTATE_NOENDBR
> > > > > >         push    %rbp
> > > > > >         mov     %rsp, %rbp
> > > > > > -       movl    $5, %ecx
> > > > > > +
> > > > > > +       movzbl    bhb_seq_outer_loop(%rip), %ecx
> > > > > > +
> > > > > >         ANNOTATE_INTRA_FUNCTION_CALL
> > > > > >         call    1f
> > > > > >         jmp     5f
> > > > > > @@ -1556,8 +1558,8 @@ SYM_FUNC_START(clear_bhb_loop)
> > > > > >          * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
> > > > > >          * but some Clang versions (e.g. 18) don't like this.
> > > > > >          */
> > > > > > -       .skip 32 - 18, 0xcc
> > > > > > -2:     movl    $5, %eax
> > > > > > +       .skip 32 - 20, 0xcc
> > > > > > +2:     movzbl  bhb_seq_inner_loop(%rip), %eax
> > > > > >  3:     jmp     4f
> > > > > >         nop
> > > > > >  4:     sub     $1, %eax
> > > > > > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > > > > > index 70b377fcbc1c..87b83ae7c97f 100644
> > > > > > --- a/arch/x86/include/asm/nospec-branch.h
> > > > > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > > > > @@ -548,6 +548,8 @@ DECLARE_PER_CPU(u64, x86_spec_ctrl_current);
> > > > > >  extern void update_spec_ctrl_cond(u64 val);
> > > > > >  extern u64 spec_ctrl_current(void);
> > > > > >
> > > > > > +extern u8 bhb_seq_inner_loop, bhb_seq_outer_loop;
> > > > > > +
> > > > > >  /*
> > > > > >   * With retpoline, we must use IBRS to restrict branch prediction
> > > > > >   * before calling into firmware.
> > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > > > > index 83f51cab0b1e..2cb4a96247d8 100644
> > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > @@ -2047,6 +2047,10 @@ enum bhi_mitigations {
> > > > > >  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> > > > > >         IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
> > > > > >
> > > > > > +/* Default to short BHB sequence values */
> > > > > > +u8 bhb_seq_outer_loop __ro_after_init = 5;
> > > > > > +u8 bhb_seq_inner_loop __ro_after_init = 5;
> > > > > > +
> > > > > >  static int __init spectre_bhi_parse_cmdline(char *str)
> > > > > >  {
> > > > > >         if (!str)
> > > > > > @@ -3242,6 +3246,15 @@ void __init cpu_select_mitigations(void)
> > > > > >                 x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
> > > > > >         }
> > > > > >
> > > > > > +       /*
> > > > > > +        * Switch to long BHB clear sequence on newer CPUs (with BHI_CTRL
> > > > > > +        * support), see Intel's BHI guidance.
> > > > > > +        */
> > > > > > +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > > > > > +               bhb_seq_outer_loop = 12;
> > > > > > +               bhb_seq_inner_loop = 7;
> > > > > > +       }
> > > > > > +
> > > > >
> > > > > How does this work for VMs in a heterogeneous migration pool that
> > > > > spans the Alder Lake boundary? They can't advertise BHI_CTRL, because
> > > > > it isn't available on all hosts in the migration pool, but they need
> > > > > the long sequence when running on Alder Lake or newer.
> > > >
> > > > As we discussed elsewhere, support for migration pool is much more
> > > > involved. It should be dealt in a separate QEMU/KVM focused series.
> > > >
> > > > A quickfix could be adding support for spectre_bhi=long that guests in a
> > > > migration pool can use?
> > >
> > > The simplest solution is to add "|
> > > cpu_feature_enabled(X86_FEATURE_HYPERVISOR)" to the condition above.
> > > If that is unacceptable for the performance of pre-Alder Lake
> >
> > Yes, that would be unnecessary overhead.
> >
> > > migration pools, you could define a CPUID or MSR bit that says
> > > explicitly, "long BHB flush sequence needed," rather than trying to
> > > intuit that property from the presence of BHI_CTRL. Like
> > > IA32_ARCH_CAPABILITIES.SKIP_L1DFL_VMENTRY, the bit would only be set
> > > by a hypervisor.
> >
> > I will think about this more.
> >
> > > I am still skeptical of the need for MSR_VIRTUAL_ENUMERATION and
> > > friends, unless there is a major guest OS out there that relies on
> > > them.
> >
> > If we forget about MSR_VIRTUAL_ENUMERATION for a moment, userspace VMM is
> > in the best position to decide whether a guest needs
> > virtual.SPEC_CTRL[BHI_DIS_S]. Via a KVM interface userspace VMM can get
> > BHI_DIS_S for the guests that are in migration pool?
> 
> That is not possible today, since KVM does not implement Intel's
> IA32_SPEC_CTRL virtualization, and cedes the hardware IA32_SPEC_CTRL
> to the guest after the first non-zero write to the guest's MSR.

Yes, KVM doesn't support it yet. But, adding that support to give more
control to userspace VMM helps this case, and probably many other in
the future.

I will check with Chao if he can prepare the next version of virtual
SPEC_CTRL series (leaving out virtual mitigation MSRs).

