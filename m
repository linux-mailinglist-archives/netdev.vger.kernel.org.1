Return-Path: <netdev+bounces-275319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D5YCGiL0GnG8gYAu9opvQ
	(envelope-from <netdev+bounces-275319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 05:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C74399DB1
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C794300A8E7
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 03:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235A2EDD62;
	Sat,  4 Apr 2026 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgkeAZtg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FF23C39A;
	Sat,  4 Apr 2026 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274603; cv=none; b=JnpPk7leDTAaV5u1J/EtFaxq5wXvJHxoa1/9IVsJVBqeolXeDPkP7sYoe6FBb+++ZSSY7Sg/Rd3NDb13n7tvcK9AjAUQVP/tTLlnqoJlbXxq//Dk9m5TlMN+Bb1Vh7lwg22MiCeS9QS7/ru0aewSpPswZPd1MDD1lK+ps2yrCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274603; c=relaxed/simple;
	bh=G8xvmblWSQNkLBTEI/Rr+0xm3IE4VSDw5eOz4xX4E/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiOtqMoTrUkxPEMGETuAsaeCP2wUG/FLrzhssskP2preaAfnTtXCJiwot0Llois8yVmjeUD0VDIzE9dtDNjfsVIfBspBaqvuwVAzkktLgnfqKvllWKCHsC1KdlXu1DgoOdavvAUCHDzdW9BnqjwdztsPqrVBK8+DSOaKUewGhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgkeAZtg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775274602; x=1806810602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G8xvmblWSQNkLBTEI/Rr+0xm3IE4VSDw5eOz4xX4E/o=;
  b=CgkeAZtg0w8ZFs2eqv2rOnQlT40DRN+98SS0rg0E2+VfvRTERWnviZTf
   f7gSIwwU/U/ifVuapRxey0ITJbP7fT7NmAPZHBjRL8e9pASajudDPggnm
   LzGIs+dqbkwOgb93xbR4mJ2UqGJkrHFCaSBctzGfLVZhk18sAp5+6Vw48
   /iQwaHFsvK5nPkA7cAdRT2EIBYfTXEZht932uM7c+N9wRaBRVQEu4gV8W
   imo3aMuaay7I8WQmjxYTxavuhh/4U8TYvi4Nk2J3L6exBQ6yHgfCSQ0D5
   JG5Mr1UoXizFpRIEXNbJxgJh7MoKOeGJbs/bEUjoiPKz0cth3oujtPYr0
   w==;
X-CSE-ConnectionGUID: tqdQLgeaSO+QbzVVVnLqoA==
X-CSE-MsgGUID: r5iayE5WTSau5yzA1xD18w==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76445953"
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="76445953"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 20:50:01 -0700
X-CSE-ConnectionGUID: /hjoufSMQX2cxDG39zfWEA==
X-CSE-MsgGUID: zjRESZ50Q3SdWCVtQZrIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,159,1770624000"; 
   d="scan'208";a="227335088"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 20:50:00 -0700
Date: Fri, 3 Apr 2026 20:49:54 -0700
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
Message-ID: <20260404034954.t7iapenzvhdpagxp@desk>
References: <20260403185236.sjgetnkha3o3a4d3@desk>
 <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk>
 <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk>
 <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
 <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
 <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-275319-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 76C74399DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 07:21:02PM -0700, Jim Mattson wrote:
> On Fri, Apr 3, 2026 at 5:22 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > > Since cloud providers have greater control over userspace, the decision to
> > > > use BHI_DIS_S or not can be left to them. KVM would simply follow what it
> > > > is asked to do by the userspace.
> > >
> > > I feel like we've gone over this before, but if userspace tells KVM
> > > not to enable BHI_DIS_S, how do we inform Windows that it needs to do
> > > the longer clearing sequence, despite the fact that the virtual CPU is
> > > masquerading as Ice Lake?
> >
> > IMO, if an OS is allergic to a hardware mitigation, and is also aware that
> > it is virtualized, it should default to a sw mitigation that works everywhere.
> 
> Agreed. So, without any information to the contrary, VMs should assume
> the long BHB clearing sequence is required.
> 
> Returning to my earlier comment, the test should be:
> 
> +       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
> cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
> +               bhb_seq_outer_loop = 12;
> +               bhb_seq_inner_loop = 7;
> +       }

To be clear, my comment was for an OS that doesn't want BHI_DIS_S
under-the-hood with virtual-SPEC_CTRL. Linux doesn't have that problem,
hardware mitigation on Linux is perfectly okay.

Without virtual-SPEC_CTRL, the problem set is limited to guests that
migrate accross Alder Lake generation CPUs. As you mentioned the change in
MAXPHYADDR makes it unlikely.

With virtual-SPEC_CTRL support, guests that fall into the subset that
migrate inspite of MAXPHYADDR change would also be mitigated. Then, on top
of hardware mitigation, deploying the long sequence in the guest would
incur a significant performance penalty for no good reason.

