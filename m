Return-Path: <netdev+bounces-278312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPQFGx7o3WmulAkAu9opvQ
	(envelope-from <netdev+bounces-278312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:09:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AB3F66A9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D09F30345BB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AFA365A02;
	Tue, 14 Apr 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PovEGdae"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2935E956;
	Tue, 14 Apr 2026 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150442; cv=none; b=hlXJjwc2DCXthQfSnngB9QZyRpwMCeGP+bq8lZ5PvQLVGpTRht0h/y5+Ng7c9OcLIoCCpSVC3FmuumqosGFJk/gpkCMhgNndl7sZrgJNziJAnz1inEx6cXhQLXE8KLsuvtK6A8EoOoNs4g6wdjCY12lwHgrCjl8FxcmWlID4Xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150442; c=relaxed/simple;
	bh=YsdvlQqeVior0g/k+WAElPcnRGxse6gI8p2joQTg8Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJC0DzCBip2KX0dk3hJje0tFhnRoN1+lcKeMN3i9tbcN7zhJ/PxD2o7FCDDF0MeVbRrNrKf5pfXLTegzO1YlU3fmcbc9N1WcorjnIyCnsKKWSOxCM3Ub7EOCRTORpcLwMpMIw1g7cYTpRP5dH5bPR2lI8SibR8yB9ln1o21NcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PovEGdae; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776150440; x=1807686440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsdvlQqeVior0g/k+WAElPcnRGxse6gI8p2joQTg8Fc=;
  b=PovEGdae8yNB/AX6euDry4JoYMxrWZxXzWQoydG3w9Fo3DkpObX9cW11
   LhogVTP9YqI5XKURzMV02suRkYUbou9mx8ijnZDxWuPAAikWmj1q/ZBdM
   XOllFPlhSCogrn/MVT6MzKcbdHy+y8lXhJIuhvPWJve2OwyI7p8CMemuO
   9SK1DEOMHe8ubqjXs/550mf+1MuE+mc4LD/ObxDC2oA95IsI6dQVcIo81
   6XJpVQg6MCkB5YYU1QcF4Q8f/V+NUQppeef4E6j8lUunybJcaYE1nPQX8
   +3S98Jh/pUZXctD5T5iV4bsaKNTs6kN/XTN8yoW6pEakgv255dpFetnBD
   Q==;
X-CSE-ConnectionGUID: rFHTN/mrSRa0XFt8ZVzD0A==
X-CSE-MsgGUID: eFYd2JKhRuaLPIihMKletg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="99742708"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99742708"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:06:49 -0700
X-CSE-ConnectionGUID: Qqv0CU4hSmi1Ya0DhafpcQ==
X-CSE-MsgGUID: ld6HPmOxQI28P4mVvbJYIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="231744909"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:06:49 -0700
Date: Tue, 14 Apr 2026 00:06:48 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
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
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v10 06/12] x86/vmscape: Use write_ibpb() instead of
 indirect_branch_prediction_barrier()
Message-ID: <20260414-vmscape-bhb-v10-6-efa924abae5f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-vmscape-bhb-v10-0-efa924abae5f@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,suse.com:email,intel.com:dkim,intel.com:email,nutanix.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B0AB3F66A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

indirect_branch_prediction_barrier() is a wrapper to write_ibpb(), which
also checks if the CPU supports IBPB. For VMSCAPE, call to
indirect_branch_prediction_barrier() is only possible when CPU supports
IBPB.

Simply call write_ibpb() directly to avoid unnecessary alternative
patching.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index c45858db16c9..78b143673ca7 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -97,7 +97,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	/* Avoid unnecessary reads of 'x86_predictor_flush_exit_to_user' */
 	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
 	    this_cpu_read(x86_predictor_flush_exit_to_user)) {
-		indirect_branch_prediction_barrier();
+		write_ibpb();
 		this_cpu_write(x86_predictor_flush_exit_to_user, false);
 	}
 }

-- 
2.34.1



