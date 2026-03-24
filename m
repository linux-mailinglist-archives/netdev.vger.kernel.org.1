Return-Path: <netdev+bounces-271262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HVzCsTrwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:53:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEA31BE42
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685FE30F48A6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A6301474;
	Tue, 24 Mar 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bo94spsm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899302F531F;
	Tue, 24 Mar 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381586; cv=none; b=K612guoUgtem7WQRW+wgpe5Ou4mLHd3+CTI/ZGsqfNCqr1ButqkgLEVwdq1in4+1g1EgACfDBqjg9b2SADgt3m3F4AJTXtlUb07eCi2ngSRPILh5kRkwZlILTRyDem5UzbQVCM112k6bOqdmZDGvKwU2wnz5zv878HpNlmzK5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381586; c=relaxed/simple;
	bh=2IjbiGOydgTISwKREhFDXr7AUF1Ww7b9HlNRKg+3qSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWsewpF6KDPphltnzqc5U8VsClxcJigYCSzRF76IGDu5EHtMEeIU/7AYO/h3h/mCUKYWPtbSHxo3qAR9O+Suzb283XHQVCoRUNS3KZDJ3/YDGE8jWfkb9J9TsSqZd1jj+zMRa2B9PHdQyx77yEIPeV3EOLaSj+7DH3hev4moSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bo94spsm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774381585; x=1805917585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2IjbiGOydgTISwKREhFDXr7AUF1Ww7b9HlNRKg+3qSE=;
  b=bo94spsmrfDgFInPU1zdXMnsm0T/DVFM/GCXxOiilspiU0MS/hl2EirK
   3l0+xKgjq1gpn4Dn6CWv8vP+/xtAyflp3NTP9YAuM4csC4saY+UfE3tyw
   oDTXdz+EriGY4M9eFMIWQE1FmAiYPOWAWKwO5aWdOI0SYtstySCjuTaA5
   oOBk5MFRr6U4JO+/iT0iNeTxpipNkrG75wAN75C4smqXA53mYUsoU+9jP
   HQEPEkIAyVhBgUu5sYBoEtQTK19Z1nRnbrpmOeQmj9lC2sbzu5Y0M7grz
   8rd4f7qMnhTPHCRyGjrQNZgs3brh6JKm27gznMv+wGbMPPG7Fkeb8BB2J
   g==;
X-CSE-ConnectionGUID: yzUxuVv3S2eGVn2dX5fiWg==
X-CSE-MsgGUID: YyizQrKrRAW20QwKG/3Mdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75380910"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75380910"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:46:19 -0700
X-CSE-ConnectionGUID: axslOJxhRbeFA+nuy+i/BA==
X-CSE-MsgGUID: p0QH1MlYQBGmYM6fF3GyOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="248026177"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 12:46:18 -0700
Date: Tue, 24 Mar 2026 12:46:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: x86@kernel.org, jon@nutanix.com, nik.borisov@suse.com, hpa@zytor.com,
	jpoimboe@kernel.org, david.kaplan@amd.com, seanjc@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, jolsa@kernel.org, davem@davemloft.net,
	david.laight.linux@gmail.com, luto@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dsahern@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	pbonzini@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, asit.k.mallick@intel.com, tao1.zhang@intel.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v8 08/10] x86/vmscape: Deploy BHB clearing mitigation
Message-ID: <20260324194613.otkxlu6x4xehgnt7@desk>
References: <20260324-vmscape-bhb-v8-8-68bb524b3ab9@linux.intel.com>
 <ed36be8ab3fd8dc38efe3fe4c5846d1f315fbeef0782ab56550e279960e57ce8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed36be8ab3fd8dc38efe3fe4c5846d1f315fbeef0782ab56550e279960e57ce8@mail.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271262-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: BCFEA31BE42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:09:33PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index a7dee7ec6ea39..8cacd9474fdf0 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> 
> [ ... ]
> 
> > @@ -3136,6 +3149,8 @@ static void __init vmscape_apply_mitigation(void)
> >  {
> >  	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
> >  		static_call_update(vmscape_predictor_flush, write_ibpb);
> > +	else if (vmscape_mitigation == VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER)
> > +		static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);
> >  }
> 
> When vmscape_predictor_flush is set to clear_bhb_loop_nofence, the
> call site in arch_exit_to_user_mode_prepare() becomes:
> 
>     static_call_cond(vmscape_predictor_flush)();
>     this_cpu_write(x86_predictor_flush_exit_to_user, false);
> 
> The comment above clear_bhb_loop_nofence() in entry_64.S says:
> 
>     Note, callers should use a speculation barrier like LFENCE
>     immediately after a call to this function to ensure BHB is
>     cleared before indirect branches.
> 
> Every other callsite follows this requirement, e.g. in
> CLEAR_BRANCH_HISTORY and CLEAR_BRANCH_HISTORY_VMEXIT:
> 
>     call clear_bhb_loop_nofence; lfence
> 
> The previous static_call target, write_ibpb(), uses wrmsr which is
> serializing and inherently acts as a speculation barrier. But
> clear_bhb_loop_nofence() is just a loop that fills the BHB -- it is
> not serializing.
> 
> Without an lfence after the static_call, is there a speculative
> window where indirect branches could execute using stale
> (guest-controlled) branch history before the BHB clear takes
> architectural effect?

VMSCAPE mitigation is for userspace, LFENCE is not required at exit-to-user
because ring transitions are serializing. Will add a comment.

