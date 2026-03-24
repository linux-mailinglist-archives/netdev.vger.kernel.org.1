Return-Path: <netdev+bounces-271234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBAGByvWwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:21:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96331AB67
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2755F30811DB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8133909B2;
	Tue, 24 Mar 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgdNAnII"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22757387356;
	Tue, 24 Mar 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376328; cv=none; b=WjhTIWM2mf9zwFeOZ+cxkUDCFpXYKQHz2zQhdGUhmhDFOGrYeIOl0DkKuNwpeNDfVtNO6POcdLBZYOs4jhcBt19xhsKL4V7ilBm8xIchTV+zsmeNK40hhQNVAECSRqz8qYAOtOo8LHJdJdWtVYMqFUvnphK7OILBd5CjnSkTlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376328; c=relaxed/simple;
	bh=/LpaN8rl4GCEDdEvnTvtBW4O1Y6doVjK38xWXFBBDrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHKzLQizHK0TKiCCDGyi5Ri/5tmI89NvCrw63oau30NREQ0f8fqIsP3qY6f02UwDK0YyHZUL7AuCgXd6VV5FIiz0rZnPZWnXs2MYA6YUy745/xt0JKQ2QMIC4nCZSYvyWy/r2x3ve0l8K/MUJ+/Mzz91gJGSq6+iLOr+9Uj4ITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgdNAnII; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774376327; x=1805912327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LpaN8rl4GCEDdEvnTvtBW4O1Y6doVjK38xWXFBBDrQ=;
  b=DgdNAnIIwBuNrnlWGSJ8nsX5eXzLdXeTGZG9D7nQBqK6cornIGDjb7aB
   x6a/zJhxuXZPvpGP5CTIyDrudKXCgYAFMCgMoSRtdYNRkKfAym7rcBBLN
   NkObbRcBIfM+ltTOaTg3YbmBOm9cnMywYYUMBL8Z8KWW2EeNWlCfQLXvN
   cLv/jafVp/SOaDePEWIBkgEevEYEczPZznitT8JPu5qPP3ZUNLPlStzoz
   HZxCNV6VBoiB/zQ8GvWQwJY4NlvNg6tkMLizg5yZFdmWqL4JxzHXKzEhe
   k0LXcy6hnCRAxt2YNZeL9k0kYvA9UJxfjiA9fbBds4pNYNsniqEgUUE9J
   Q==;
X-CSE-ConnectionGUID: ympmxbquTIKYdD/VVwUluw==
X-CSE-MsgGUID: BB81UbcfS3ey6wzWO9HF/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74429599"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74429599"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:18:47 -0700
X-CSE-ConnectionGUID: 0E2tp4xnR86/WS0a5+ZwGw==
X-CSE-MsgGUID: dnjGq3PESKyOF94JbD0moQ==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 11:18:45 -0700
Date: Tue, 24 Mar 2026 11:18:44 -0700
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
Subject: [PATCH v8 09/10] x86/vmscape: Resolve conflict between
 attack-vectors and vmscape=force
Message-ID: <20260324-vmscape-bhb-v8-9-68bb524b3ab9@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[37];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA96331AB67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmscape=force option currently defaults to AUTO mitigation. This lets
attack-vector controls to override the vmscape mitigation. Preventing the
user from being able to force VMSCAPE mitigation.

When vmscape mitigation is forced, allow it be deployed irrespective of
attack vectors. Introduce VMSCAPE_MITIGATION_ON that wins over
attack-vector controls.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8cacd9474fdf..ba714f600249 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3053,6 +3053,7 @@ static void __init srso_apply_mitigation(void)
 enum vmscape_mitigations {
 	VMSCAPE_MITIGATION_NONE,
 	VMSCAPE_MITIGATION_AUTO,
+	VMSCAPE_MITIGATION_ON,
 	VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER,
 	VMSCAPE_MITIGATION_IBPB_ON_VMEXIT,
 	VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER,
@@ -3061,6 +3062,7 @@ enum vmscape_mitigations {
 static const char * const vmscape_strings[] = {
 	[VMSCAPE_MITIGATION_NONE]			= "Vulnerable",
 	/* [VMSCAPE_MITIGATION_AUTO] */
+	/* [VMSCAPE_MITIGATION_ON] */
 	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]		= "Mitigation: IBPB before exit to userspace",
 	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]		= "Mitigation: IBPB on VMEXIT",
 	[VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER]	= "Mitigation: Clear BHB before exit to userspace",
@@ -3080,7 +3082,7 @@ static int __init vmscape_parse_cmdline(char *str)
 		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
-		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
 	} else if (!strcmp(str, "auto")) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {
@@ -3112,6 +3114,7 @@ static void __init vmscape_select_mitigation(void)
 		break;
 
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		/*
 		 * CPUs with BHI_CTRL(ADL and newer) can avoid the IBPB and use
 		 * BHB clear sequence. These CPUs are only vulnerable to the BHI
@@ -3245,6 +3248,7 @@ void cpu_bugs_smt_update(void)
 	switch (vmscape_mitigation) {
 	case VMSCAPE_MITIGATION_NONE:
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		break;
 	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
 	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:

-- 
2.34.1



