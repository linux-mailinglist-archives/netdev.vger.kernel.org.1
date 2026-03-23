Return-Path: <netdev+bounces-270622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABCjFTh/wWl2TgQAu9opvQ
	(envelope-from <netdev+bounces-270622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:58:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF032FAB66
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AC4F3174D2F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958053C3C18;
	Mon, 23 Mar 2026 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2zZpA5e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D93BF687;
	Mon, 23 Mar 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285637; cv=none; b=MdTshzzALFcnT1+Tln+4VixGj8+sfuvnrxwBVw/JvLyX7XC9hIg4hUPEa+pGtn5G9alj5nYuloDH+781VC7WmZQQRX0PtiGeIWjWSeW0nguAZK7xt5M9KzuGU3AKm0d0JJLvIPk2jGWWhmzA0XfSux9Bw+VQdiOFtSEN9OMHdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285637; c=relaxed/simple;
	bh=ZPRtjSbDYAuXP+R2fMzJuVURJbzdyj1iPTpdebc3THE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bskLGxPEzb99/Qy6vmsVA2PkfAdpXTO3JKyEO816HMchN4dEZsLyIqCP604Tn1SZv5sF0/XVjL2NyDFCLSTwQ/F0rKww0xOEShhScB3YFvBOHQfNoQ8HUhz6j+jCrmIiOGyWbzDt+v89HMwbUCvIAE6viUxe+Nybo5GTcv7tIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2zZpA5e; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774285636; x=1805821636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZPRtjSbDYAuXP+R2fMzJuVURJbzdyj1iPTpdebc3THE=;
  b=m2zZpA5eoXOSOA6rSnbe92h1IrIrvZ91L/PHuHqY5B5RddnLRoH49n3y
   /ZUStjaftN/d52TDJIP44ESWMsluh7nYD1oYj0j/QHmo0NKEAt8uMDnCw
   tWtYpkug8Qkv8F1YZgkpSOArzIyHl87o99+aZtNK+nXFJ/GtXQGocPKHH
   uyKYhojZAZFEp/nWOe8xwQLy1Xj9Kl1bYVyslkEzEsCqdRrGK/d6c7qOF
   ggiVPDvuT9T5e2VORe+WRWs3vm1VX+vj+FvUQDu9DXSdTeenb0h2tHPe9
   sUQW31jsv6Zkf8EEZ2UmE4+lWiJbI8HR74hHd1ljD9K5FUyIXVfIYKQ/7
   w==;
X-CSE-ConnectionGUID: mwn/cEOOTAa9M2/J68LzmA==
X-CSE-MsgGUID: 80mGv3fvTbyWvRFvHsqe/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86657187"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="86657187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:07:15 -0700
X-CSE-ConnectionGUID: m87CQPESS927IIVwJpteSg==
X-CSE-MsgGUID: BMDfODy4QgaI4VGb46H6FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224298095"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:07:15 -0700
Date: Mon, 23 Mar 2026 10:07:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 03/10] x86/bhi: Rename clear_bhb_loop() to
 clear_bhb_loop_nofence()
Message-ID: <20260323170709.7lpdet4nnmhbdcxa@desk>
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-3-b76a777a98af@linux.intel.com>
 <6c315cb3-b3a0-478e-b8ec-36d82684d310@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c315cb3-b3a0-478e-b8ec-36d82684d310@suse.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270622-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alien8.de:email,suse.com:email,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 2CF032FAB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 04:44:24PM +0200, Nikolay Borisov wrote:
> 
> 
> On 19.03.26 г. 17:40 ч., Pawan Gupta wrote:
> > To reflect the recent change that moved LFENCE to the caller side.
> > 
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> 
> Nit: I think having the _nofence in the function name is leaking an
> implementation detail into the name/interface. I.e things change and we
> decide that the implementation of a particular function must change so we
> just do the change and substantiate it in the commit message or in a
> comment. Especially that we don't have a "with an lfence" version.

The explicit "_nofence" is because the series changes the implementation of
clear_bhb_loop() from lfence. If new call sites miss to add an lfence when
it is required could lead to a security issue. Having the "_nofence" in the
name helps avoid it.

Apart from the name, the commit message of patch 1/10 and the comment in
clear_bhb_loop() implementation covers this.

> What's more I'd consider this a "private" function, that's called via the
> CLEAR_BRANCH_HISTORY macros, the only place it's called directly is in the
> bpf jit code, but that's more of an exception.

Another place where the explicit "_nofence" in the name could help is while
applying the mitigation in vmscape_apply_mitigation(), which sets the
static call:

vmscape_apply_mitigation()
{
...
    if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
        static_call_update(vmscape_predictor_flush, write_ibpb);
    else if (vmscape_mitigation == VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER)
        static_call_update(vmscape_predictor_flush, clear_bhb_loop_nofence);

> Still,
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Thank you.

