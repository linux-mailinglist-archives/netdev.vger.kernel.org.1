Return-Path: <netdev+bounces-275449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBgdNPIN0mnFSwcAu9opvQ
	(envelope-from <netdev+bounces-275449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 09:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DA39D97B
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 09:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9034C3003831
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19234B410;
	Sun,  5 Apr 2026 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYF2EUMf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D02874F8;
	Sun,  5 Apr 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775373808; cv=none; b=FK/c/ybfF2ai1oMfvj5htK+prgGDH6lcpF0+lO3WbTJSEio4dZHUx1vFRS626383eOdAT2SZVBB8GFdBip4ia7k4StP+asqz12KAwSJpBgd5d+Ac5pExXflMkr3oS0ygoIzV519pSxSPSiBVimJ833NmxubNq5sDEKUqT+QBFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775373808; c=relaxed/simple;
	bh=YOehHECOLT4QVYKSmrNIW5ZBtaHoNollM2pLLqjv4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoscAqOiGBtZ+hSZEaFNB2zW9NgS8MEw1xd1eSsbtOKrD7jYEVnFs6jwfQM4W7UnQm92+D4S9arzEFxUVcTBSeRFn9RgyFoYnfX2W14RwRCxD1995R6FOfA7brnfnFxmpErFtHYVt/vt1mD11pSO0POPmLDjlC6aiolbmTFgI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYF2EUMf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775373807; x=1806909807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOehHECOLT4QVYKSmrNIW5ZBtaHoNollM2pLLqjv4oM=;
  b=SYF2EUMf6Geb678P9GN4XWDXD4zIZ446eFUqQqOzGFVS9qj71bjhx2r8
   WdL5qi/HCeY2CsQpzespMLYz591t8hWJM5/5RGf0R33dRDJKM6sVe4joz
   /t7t5JACIbUE5oNGM980mfByRHTlSZfeh9c5kVt23GfuDwxFqqIlAlU/C
   LGYk3pojAjY/vJaGSAqvW6OPt0xIUUWDK4+AevqyFYEk8wK0OfrGhwwZa
   xm6K5NliNxNcV8jFSzoB48/kK5559QiGqXMIGzxNyg7d1Uc5L2JE+8otc
   eO1fpvUnjEW420FYm2mBEoDm+hJ22JbYyT2py5TDWyhBxticyw9OD4soO
   Q==;
X-CSE-ConnectionGUID: EpjGxigYQJ64rrcILJj/+A==
X-CSE-MsgGUID: ovQzu9VgRs+hNEUHDzPgCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="76263642"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="76263642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 00:23:26 -0700
X-CSE-ConnectionGUID: lhUKzm/xTra/O0GWfZed7g==
X-CSE-MsgGUID: 1WQKvYV1RGmgelZEKv5qLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="250714858"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 00:23:24 -0700
Date: Sun, 5 Apr 2026 00:23:14 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
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
Subject: Re: [PATCH v9 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260405072314.efcaflw3oivjoikn@desk>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260404162059.34ca90df@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404162059.34ca90df@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275449-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7B2DA39D97B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 04:20:59PM +0100, David Laight wrote:
> On Thu, 2 Apr 2026 17:30:32 -0700
> Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> 
> > v9:
> > - Use global variables for BHB loop counters instead of ALTERNATIVE-based
> >   approach. (Dave & others)
> > - Use 32-bit registers (%eax/%ecx) for loop counters, loaded via movzbl
> >   from 8-bit globals. 8-bit registers (e.g. %ah in the inner loop) caused
> >   performance regression on certain CPUs due to partial-register stalls. (David Laight)
> > - Let BPF save/restore %rax/%rcx as in the original implementation, since
> >   it is the only caller that needs these registers preserved across the
> >   BHB clearing sequence.
> 
> That is as dangerous as hell...
> Does BPF even save %rcx - I'm sure I checked that a long time ago
> and found it didn't.

Below code injects save/restore of %rax and %rcx to BPF programs:

arch/x86/net/bpf_jit_comp.c

emit_spectre_bhb_barrier()
{
	u8 *prog = *pprog;
	u8 *func;

	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
		/* The clearing sequence clobbers eax and ecx. */
		EMIT1(0x50); /* push rax */
		EMIT1(0x51); /* push rcx */
		ip += 2;

		func = (u8 *)clear_bhb_loop_nofence;
		ip += x86_call_depth_emit_accounting(&prog, func, ip);

		if (emit_call(&prog, func, ip))
			return -EINVAL;
		/* Don't speculate past this until BHB is cleared */
		EMIT_LFENCE();
		EMIT1(0x59); /* pop rcx */
		EMIT1(0x58); /* pop rax */
	}
	...

> (I'm mostly AFK over Easter and can't check.)
> A least there should be a blood great big comment that BPF calls this code
> and only saves specific registers.

Sure, will add.

> But given the number of mispredicted branches and other pipeline stalls
> in this code a couple of register saves to stack are unlikely to make
> any difference.

BPF programs have been saving/restoring the registers since long now. What
problem are you anticipating?

