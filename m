Return-Path: <netdev+bounces-270020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD/NKcCRvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:28:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 528032DF66E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 758FB302EE8E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF03E6DE7;
	Fri, 20 Mar 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbIa1AmN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BB309F09;
	Fri, 20 Mar 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030996; cv=none; b=CpUDNQdfXT04TfMbsIfYu9mOVCMZK22Q6SIqgKUifTTEKLdTQd4seLUMM/Nc1AeZiacmmz8PMcCKMMJBout3oCC5IP5dnG7TuTroqFEZ/X5YxPd0CbPH7PY+EOzuknhetWnRYENdIvCLJtXwdxa2jIMDSJnRDwN3eHBjIjyeQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030996; c=relaxed/simple;
	bh=Oo3xetu+OW+HuF5FbXSeo0y3UTOrNwihIV/ErHQMwZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXtiFeOEz6emCehTUlVV3Vtmv9sURU0SbSm6kVLeOq+Jr5hjNHW8rAblT2abbcQy0WpPVuwVSX6eqJsdunYZZcGfJ4Bo1b9KQkZnGqHQGdbCPYAG366MAlDNu11WOz+9QT2R8M1CAHOLNah554unJiFaUgH2K4herBFi5Mv5I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbIa1AmN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774030995; x=1805566995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oo3xetu+OW+HuF5FbXSeo0y3UTOrNwihIV/ErHQMwZ8=;
  b=LbIa1AmNBi3h389XRQnnyg0P8on1P6NlvBbh5/+KpryiFT3lX3qqRxta
   jphHXZ6Xc59wQ+4ek4rBZqACQBn51LIpkTdiNSEIQHrfDeLa7ZqGHD2rs
   zmjTqhEfqkxK4UsXME6x97MHle5FIlL4LDI/A82iFycI4QH1lUfFOsfrf
   zAYl6atOLMvQDH8xaciK3MUE9RuOu8t4FnP2RgxqLbQnrSKm7/2F+gA7G
   N6MYjh/rPdU2rGmxAZj8g7a8UV3gCnPP9zSCMvLNOfiEHBZkA8QLR4MJO
   83pEVbG4TxpNxB8DBWV2jQ9arD+Bh9ZtiUIeWdU2O+enfKwHLzRW4ayYo
   Q==;
X-CSE-ConnectionGUID: SDBJFMzvRnqn2Qehyo1L4Q==
X-CSE-MsgGUID: Bm9p67d9S02qir+ayAHPvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86599980"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86599980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 11:23:14 -0700
X-CSE-ConnectionGUID: pRU6djUYQQKnXyA5m48FcA==
X-CSE-MsgGUID: TpRuEgmhSx6uchIprLQlTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227844785"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 11:23:15 -0700
Date: Fri, 20 Mar 2026 11:23:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <20260320182308.ahynqzuswlv34wf6@desk>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
 <20260319205802.GJ3738786@noisy.programming.kicks-ass.net>
 <20260319213421.br6na4dulrjm6eke@desk>
 <20260319214409.GL3738786@noisy.programming.kicks-ass.net>
 <20260320062206.bdrnmnvho6lhmejw@desk>
 <20260320090340.GN3738786@noisy.programming.kicks-ass.net>
 <20260320113134.GAab0wFqe-hewZc175@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320113134.GAab0wFqe-hewZc175@fat_crate.local>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270020-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,suse.com,zytor.com,amd.com,google.com,linux.intel.com,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.912];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 528032DF66E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:31:34PM +0100, Borislav Petkov wrote:
> On Fri, Mar 20, 2026 at 10:03:40AM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 19, 2026 at 11:22:06PM -0700, Pawan Gupta wrote:
> > 
> > > This plus extending it to support EXPORT_STATIC_CALL_FOR_KVM() is probably
> > > a better solution. Please let me know which one you prefer.
> > 
> > The EXPORT twiddling will do I suppose. I'll try and not forget looking
> > at doing the RO static_call thing some time.
> 
> Dunno, but exporting a static_call sounds really really wrong to me. No matter
> where. As in: we're exporting the underlying inner workings of it and that
> should be a big fat no-no.

I am curious, what problems do you anticipate? There are nearly 50
instances of static key being exported. For example:

$ git grep -A1 -n DEFINE_STATIC_KEY | grep -B 1 EXPORT_SYMBOL
  arch/arm64/kernel/mte.c:34:DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
  arch/arm64/kernel/mte.c-35-EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
  --
  arch/arm64/kernel/rsi.c:22:DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
  arch/arm64/kernel/rsi.c-23-EXPORT_SYMBOL(rsi_present);
  --
  arch/powerpc/kernel/firmware.c:25:DEFINE_STATIC_KEY_FALSE(kvm_guest);
  arch/powerpc/kernel/firmware.c-26-EXPORT_SYMBOL_GPL(kvm_guest);
  ...

Since EXPORT_STATIC_CALL_FOR_KVM() exports only to a module that needs it,
it limits the scope of the problem.

> So definitely +1 on exporting the helper instead.

The helper approach can be easily replaced with the static_call export
later. I can go with the helper for now.

