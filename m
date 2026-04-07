Return-Path: <netdev+bounces-276124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I6SGGZE1WnY3wcAu9opvQ
	(envelope-from <netdev+bounces-276124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:52:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDD3B29A4
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE9D3005EA5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4EF3A5E82;
	Tue,  7 Apr 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfZGZ9RS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135839150B;
	Tue,  7 Apr 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584351; cv=none; b=u49Dno5e4HNa/CdVGWDXkNIlLD/MamlrF6gRRONBgJ/oMx+zJ954I2JAckSpJhc3t4ox0wSmBVBTyGVxwHc5Jk+oStkarTeGyrZ5kymGcuivK+6pp2C6E60wykMvmvNITGf6tyAA34DhrGIh00pIdiqjrkU39i456FDgS7DPjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584351; c=relaxed/simple;
	bh=3fkEJFFrgqy6MjrcRSqfdHOdo4sUYO6cXLb/hD4bbJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrKKhq6liAke1NdTqKdOvlJ3hlU8OEZXMW9I0PRZqw0W08zo5MqVCdct7foQF+wQsFW2LhExAU5NQE05uH/K6X048K29rQmUjw7pFZLcJh/tanLuw1n+R0qjo/wQh+5Nz8mJlsMV5v7Yos6UoQYXpFKK2CrHHi4hrZLx82WCLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfZGZ9RS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775584348; x=1807120348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3fkEJFFrgqy6MjrcRSqfdHOdo4sUYO6cXLb/hD4bbJE=;
  b=ZfZGZ9RSVVUWvofDn0gKvRDaUUQ8GNjaIIP+Zv/nDR14Rp8EA7BnvcLh
   oCEMm0jdMyheZm4oJhI+taByO5ZCylCTMp0YhELOIuGjmwzY7mxTPb5fw
   tm0wkBCDzj2S34Yshe1ZbkVdl9I9U5+lbzw0H5B7FY3/S7tyqjH3WEygq
   K1S4Ivmk1TWnnNbdpupzH8VdfW96pq3iV6wGPbMr3RGLdK253Xl4qEl+Q
   gRdRzr2B0ri7iGHO8fFgQJcZ9Q/m1lHPxllxBzTFbRT6Ig2EqI976ASXO
   MHImjAhdngG+O/BVuGNlrG7765s9FerPCrr0o/tSDkuzUM7q0dQFcHK/b
   w==;
X-CSE-ConnectionGUID: e+snA+APRoiD1jp68msHpA==
X-CSE-MsgGUID: tW/ZJIB+Tn6tD/tnnr0IGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86849748"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="86849748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:52:27 -0700
X-CSE-ConnectionGUID: U0nsAuVHTcSOdZVcP9udKA==
X-CSE-MsgGUID: pG8Pe/rGRBK4wc6fe0pTxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="233114723"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:52:23 -0700
Date: Tue, 7 Apr 2026 10:52:07 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jim Mattson <jmattson@google.com>, "x86@kernel.org" <x86@kernel.org>,
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
	Jonathan Corbet <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"chao.gao@intel.com" <chao.gao@intel.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260407175207.j5atzf772mkdezgg@desk>
References: <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
 <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
 <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
 <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
 <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <FAA31092-E1CA-4D79-8CEC-3DB0F6F1C792@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FAA31092-E1CA-4D79-8CEC-3DB0F6F1C792@nutanix.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276124-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[google.com,kernel.org,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9EDD3B29A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 05:12:06PM +0000, Jon Kohler wrote:
> 
> 
> > On Apr 7, 2026, at 11:46 AM, Jim Mattson <jmattson@google.com> wrote:
> > 
> > On Tue, Apr 7, 2026 at 9:40 AM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> >> 
> >> On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> >>> Yes, but the guest needs a way to determine whether the hypervisor
> >>> will do what's necessary to make the short sequence effective. And, in
> >>> particular, no KVM hypervisor today is prepared to do that.
> >>> 
> >>> When running under a hypervisor, without BHI_CTRL and without any
> >>> evidence to the contrary, the guest must assume that the longer
> >>> sequence is necessary. At the very least, we need a CPUID or MSR bit
> >>> that says, "the short BHB clearing sequence is adequate for this
> >>> vCPU."
> >> 
> >> After discussing this internally, the consensus is that the best path
> >> forward is to add virtual SPEC_CTRL support to KVM, which also aligns with
> >> Intel's guidance. In the long term, virtual SPEC_CTRL can benefit future
> >> mitigations as well. As with many other mitigations (e.g. microcode), the
> >> guest would rely on the host to enforce the appropriate protections.
> 
> Would we have to wait for virtual SPEC_CTRL to get this optimization?

The optimization works with or without virtual-SPEC_CTRL.

> Or would that be a future enhancement to make this more prescriptive?

Virtual-SPEC_CTRL enables safer guest migrations between pre and post Alder
Lake CPUs w.r.t. Native BHI mitigation. It is not related to VMSCAPE.

