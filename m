Return-Path: <netdev+bounces-275152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAAoEPDwz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:55:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DBD396A96
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F8A300B459
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD93CE4B1;
	Fri,  3 Apr 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGkts3DA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27E3CCFC5;
	Fri,  3 Apr 2026 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234779; cv=none; b=QTO8VLRJam+pIapfXlU9FWhpvaC+uPF/PXXGefSMO2UdhzvgrCoMTgVcsZeBPKHNfRyVnPUny+VLUsqIN/HukK8UUpxI3+a1yvUB+ZrfCS0vpZfI5JZtJ0KuX3Gf6DdoGOiku2k2hRP7cYs6YZuZR88ez9znIyglje7RaDX9Md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234779; c=relaxed/simple;
	bh=F+1A2IItb+OUo6yKq0bGWNUTEv593pDXelm7mkt0/YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crxP13fXqJcMImEJIatwEQvV+WYRpwCgzRlEzTt/1HG9FUDkoyYM+pPJbNAWW++ZAVjcmbhqHCnyNEbq0SVLh/lyoXDIqm9DLr45L+A2JHm5ZsFFha/0W+rAKMBbTOc2O9MOknpZNPcZd4HmNHmfFtPXzI9BbZqr4YKPDzHLkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGkts3DA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775234776; x=1806770776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+1A2IItb+OUo6yKq0bGWNUTEv593pDXelm7mkt0/YI=;
  b=gGkts3DAsbis6Jc7qr/ayYn8sjrYO8CBTwuybk/y8AofGIlIanAlwxiu
   CdiziiPOaWA8OkS8nxH6QUFVPmPQp3uFZKyiUfMjbfqjQrqoo2kAKtHjP
   J2z+9O6rPZH0viAbxYEdZeWc7aY4QFHCwk8RYq0qyQznM+Hb66Cn6xKXH
   krzsINoO8TQ7j0E0Ajdy4JcR5zqpLy80SCGVLIqc0bk9soQciW+Tp0nhI
   uxwynq2XANLIEEy/DyKgwl8IRcT+a1H7qiYlC33Sh8vbFZcf1toEPtd0X
   3kuswUHQGOnv8Z2q7EOl4E9SOc5eSU8aO2nygwW66a+KBX8FFCrQGSfz9
   g==;
X-CSE-ConnectionGUID: vZhweHLZQw+wIBlDb4EPiw==
X-CSE-MsgGUID: p3DcfVgiQoSisGNBIEXrlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="86918559"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="86918559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:46:00 -0700
X-CSE-ConnectionGUID: 9CtrSTgcRamYgbtQBb++5A==
X-CSE-MsgGUID: y6DKFLp5SvqomrSFspNmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="250514787"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:45:58 -0700
Date: Fri, 3 Apr 2026 09:45:52 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
Subject: Re: [PATCH v9 01/10] x86/bhi: x86/vmscape: Move LFENCE out of
 clear_bhb_loop()
Message-ID: <20260403164552.chdvvmdfaufcgxzo@desk>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
 <20260402-vmscape-bhb-v9-1-94d16bc29774@linux.intel.com>
 <20260403151630.GWac_ZzhQZj5LUDlRf@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403151630.GWac_ZzhQZj5LUDlRf@fat_crate.local>
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
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275152-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B6DBD396A96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:16:30PM +0200, Borislav Petkov wrote:
> On Thu, Apr 02, 2026 at 05:30:47PM -0700, Pawan Gupta wrote:
> > Currently, the BHB clearing sequence is followed by an LFENCE to prevent
> > transient execution of subsequent indirect branches prematurely. However,
> > the LFENCE barrier could be unnecessary in certain cases. For example, when
> > the kernel is using the BHI_DIS_S mitigation, and BHB clearing is only
> > needed for userspace. In such cases, the LFENCE is redundant because ring
> > transitions would provide the necessary serialization.
> > 
> > Below is a quick recap of BHI mitigation options:
> > 
> > On Alder Lake and newer
> > 
> >     BHI_DIS_S: Hardware control to mitigate BHI in ring0. This has low
> >     performance overhead.
> > 
> >     Long loop: Alternatively, a longer version of the BHB clearing sequence
> >     can be used to mitigate BHI. It can also be used to mitigate the BHI
> >     variant of VMSCAPE. This is not yet implemented in Linux.
> > 
> > On older CPUs
> > 
> >     Short loop: Clears BHB at kernel entry and VMexit. The "Long loop" is
> >     effective on older CPUs as well, but should be avoided because of
> >     unnecessary overhead.
> > 
> > On Alder Lake and newer CPUs, eIBRS isolates the indirect targets between
> > guest and host. But when affected by the BHI variant of VMSCAPE, a guest's
> > branch history may still influence indirect branches in userspace. This
> > also means the big hammer IBPB could be replaced with a cheaper option that
> > clears the BHB at exit-to-userspace after a VMexit.
> > 
> > In preparation for adding the support for the BHB sequence (without LFENCE)
> > on newer CPUs, move the LFENCE to the caller side after clear_bhb_loop() is
> > executed. Allow callers to decide whether they need the LFENCE or not. This
> > adds a few extra bytes to the call sites, but it obviates the need for
> > multiple variants of clear_bhb_loop().
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Tested-by: Jon Kohler <jon@nutanix.com>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/entry/entry_64.S            | 5 ++++-
> >  arch/x86/include/asm/nospec-branch.h | 4 ++--
> >  arch/x86/net/bpf_jit_comp.c          | 2 ++
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thanks.

