Return-Path: <netdev+bounces-280619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH2iHJ266WlqiwIAu9opvQ
	(envelope-from <netdev+bounces-280619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC244D966
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3A03068D4F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C5318EC7;
	Thu, 23 Apr 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msD5WnSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2CB310777;
	Thu, 23 Apr 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925060; cv=none; b=j+vURJ76n3Rvx+ps5f3xN73NG5tM56f1rTk6o8cQUzFhOstWFQ15RS8DCyuU4dtdwnQwNHt+7j8L38PMSABvGvdLilCWDMC8uKqptFMT+kmmiCNLaQ7w9A1xr59DaRMHP/ceNGkx3bjZbT3OhIHt47zOESrWpzFYwUO/gr5lrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925060; c=relaxed/simple;
	bh=6gK4EmiJjoxMBErZvB2QlG52OKl4TSLVAd68WmRFl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkUkTFQBf882ZCQARAgiQgR1EEy7jfxvOFzMDNdKgA4QA09hmYuS+cdlFQqHpbdtXx1RSaE5wkaFHPONY7+Ec6ydAL1kuTOL/djAdAVzGAv+bMcO0l+zG2nFULKCisRJHbUnxL1vhk1cwih6y/OXPsm9tw9Lu1mTzAyUQEMUT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msD5WnSQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776925059; x=1808461059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gK4EmiJjoxMBErZvB2QlG52OKl4TSLVAd68WmRFl3s=;
  b=msD5WnSQGyyzAcpqbikD3iZXI49nABsJ1QU96dglQfbaExJ8UutfwUK+
   2l6D9FkDp5tXAA+iEoLcV5LQMNyeLwW9sz3bzo1IZr4q5Yl8ub2EqNFd1
   qeMqh+vTZ6/qdeAA4ks+IHTlS0x5RwbXd77b8p8/GvFeAsBJqoM2VO/s1
   /QoNCIColdDx3XmGWBkuVyN/E+1g5j5xgwGN+rFNgPFYziBiOVGw4l4f2
   OAAG3QZZ795ViiCIzOJF624P8gOOa8Z5IirQHyviwaYS/+ZuSzQGoMJS/
   /gS4gqneYv2SkEhGKK43bDSflstz9UFBlO3Inzcw7YRgEhgZR8ya7bYaG
   g==;
X-CSE-ConnectionGUID: VdClrXdXRs29VqU4eNE4Cg==
X-CSE-MsgGUID: qTR5FxOdRiC2tmAlw7piAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77868628"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77868628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:17:37 -0700
X-CSE-ConnectionGUID: k3JJm9/nQji8+5YpX/EA4w==
X-CSE-MsgGUID: UGP0AjIsSI+dVaQLoQqQfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="231684612"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:17:37 -0700
Date: Wed, 22 Apr 2026 23:17:37 -0700
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
	Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v11 11/12] x86/vmscape: Resolve conflict between
 attack-vectors and vmscape=force
Message-ID: <20260422-vmscape-bhb-v11-11-b18e0cf32af4@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-vmscape-bhb-v11-0-b18e0cf32af4@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,nutanix.com:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5BC244D966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmscape=force option currently defaults to AUTO mitigation. This lets
attack-vector controls to override the vmscape mitigation. Preventing the
user from being able to force VMSCAPE mitigation.

When vmscape mitigation is forced, allow it be deployed irrespective of
attack vectors. Introduce VMSCAPE_MITIGATION_ON that wins over
attack-vector controls.

Tested-by: Jon Kohler <jon@nutanix.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1082ed1fb2e6..fbdb137720c4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3058,6 +3058,7 @@ static void __init srso_apply_mitigation(void)
 enum vmscape_mitigations {
 	VMSCAPE_MITIGATION_NONE,
 	VMSCAPE_MITIGATION_AUTO,
+	VMSCAPE_MITIGATION_ON,
 	VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER,
 	VMSCAPE_MITIGATION_IBPB_ON_VMEXIT,
 	VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER,
@@ -3066,6 +3067,7 @@ enum vmscape_mitigations {
 static const char * const vmscape_strings[] = {
 	[VMSCAPE_MITIGATION_NONE]			= "Vulnerable",
 	/* [VMSCAPE_MITIGATION_AUTO] */
+	/* [VMSCAPE_MITIGATION_ON] */
 	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]		= "Mitigation: IBPB before exit to userspace",
 	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]		= "Mitigation: IBPB on VMEXIT",
 	[VMSCAPE_MITIGATION_BHB_CLEAR_EXIT_TO_USER]	= "Mitigation: Clear BHB before exit to userspace",
@@ -3085,7 +3087,7 @@ static int __init vmscape_parse_cmdline(char *str)
 		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
-		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
 	} else if (!strcmp(str, "auto")) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
 	} else {
@@ -3117,6 +3119,7 @@ static void __init vmscape_select_mitigation(void)
 		break;
 
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		/*
 		 * CPUs with BHI_CTRL(ADL and newer) can avoid the IBPB and use
 		 * BHB clear sequence. These CPUs are only vulnerable to the BHI
@@ -3244,6 +3247,7 @@ void cpu_bugs_smt_update(void)
 	switch (vmscape_mitigation) {
 	case VMSCAPE_MITIGATION_NONE:
 	case VMSCAPE_MITIGATION_AUTO:
+	case VMSCAPE_MITIGATION_ON:
 		break;
 	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
 	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:

-- 
2.34.1



