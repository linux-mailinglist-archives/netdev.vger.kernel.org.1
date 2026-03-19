Return-Path: <netdev+bounces-269514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELerHvAavGlEsQIAu9opvQ
	(envelope-from <netdev+bounces-269514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F492CDFAE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49D333070987
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F31E3E8C72;
	Thu, 19 Mar 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPaHdqO0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342F3DEAE2;
	Thu, 19 Mar 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934972; cv=none; b=uhrf0NDW7iEDHw6PwUoqCxb4ITT05USuq7lL/OkbEcNMPN/t69ptuuGgU8r4C8xqofLmiSJaedx2GEmvPZ9zFuF2F8nBNHPKJm6Gjq9cuYnMwE9SRUS46sLTnVtZr+9szKqSawiec4IBvHhMd+s7Y0tEuld4Mesz3tedfpyzakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934972; c=relaxed/simple;
	bh=SMhEQ+pZHcmr0+HxLxjJHHt06QQIe9V8bFK9AAaiKxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCwPxigR9vB0i+YjYgyPx78GhJ8DdK6UHBAzoZ0fdQpPexHV48MbFJlTkoFr3w1y5ny8QIeZkkWNYRsRAIZXebT7AgmOs2tDujkHavGM7wwrCQjrPyLFaICg/yARtQMCpruO2ZOf1eKgqxc30Tcv/PsclNIAIbDRa84/mKtb64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPaHdqO0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773934971; x=1805470971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMhEQ+pZHcmr0+HxLxjJHHt06QQIe9V8bFK9AAaiKxk=;
  b=TPaHdqO0Gf9p9YnAp40lWQ789XWmxXjJMH1laKme+1E211fOvoTy96qQ
   r1oJEDYM5i5zniloi38YJX8PvwJQoJT3pCb2220YV7yoBfSQNHk2lalsT
   74wNnEjc7PByUmPHy1sh/Aflph2mpYX7MC3zLE+C5l8m9bFUXZe1MrpEH
   1mMuXceCxQUXkeqad//Kw/yEtkgbrMExK0+QXxnpAlexx5ohtFNj2s+W/
   MXpGr8X2RtaV/Y21hmqO5FH1yxaVFsGC/1xw4pR/wbNdvnvJVkjxQsTfJ
   I9RqUan/UOMxWhXvOOXeeTgInyrlMrbeyDw4BtVtiab6QQ5aOTjzKwaHn
   g==;
X-CSE-ConnectionGUID: dsjUUAdxSrO1Uq4hfF3bvg==
X-CSE-MsgGUID: e2d/7psMQtCp7r4XLTwy1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75195895"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75195895"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:42:50 -0700
X-CSE-ConnectionGUID: xE5PzlJkRwGmNCmx6XZqWw==
X-CSE-MsgGUID: e6DY7hSCT96D1Nlxu5fiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218891770"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:42:49 -0700
Date: Thu, 19 Mar 2026 08:42:48 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>,
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
Subject: [PATCH v7 10/10] x86/vmscape: Add cmdline vmscape=on to override
 attack vector controls
Message-ID: <20260319-vmscape-bhb-v7-10-b76a777a98af@linux.intel.com>
X-Mailer: b4 0.15-dev
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 32F492CDFAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In general, individual mitigation controls can be used to override the
attack vector controls. But, nothing exists to select BHB clearing
mitigation for VMSCAPE. The =force option comes close, but with a
side-effect of also forcibly setting the bug, hence deploying the
mitigation on unaffected parts too.

Add a new cmdline option vmscape=on to enable the mitigation based on the
VMSCAPE variant the CPU is affected by.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/vmscape.rst   | 4 ++++
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 arch/x86/kernel/cpu/bugs.c                      | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/vmscape.rst b/Documentation/admin-guide/hw-vuln/vmscape.rst
index dc63a0bac03d..580f288ae8bf 100644
--- a/Documentation/admin-guide/hw-vuln/vmscape.rst
+++ b/Documentation/admin-guide/hw-vuln/vmscape.rst
@@ -112,3 +112,7 @@ The mitigation can be controlled via the ``vmscape=`` command line parameter:
 
    Force vulnerability detection and mitigation even on processors that are
    not known to be affected.
+
+ * ``vmscape=on``:
+
+   Choose the mitigation based on the VMSCAPE variant the CPU is affected by.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..1068569be5cf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8378,9 +8378,11 @@ Kernel parameters
 
 			off		- disable the mitigation
 			ibpb		- use Indirect Branch Prediction Barrier
-					  (IBPB) mitigation (default)
+					  (IBPB) mitigation
 			force		- force vulnerability detection even on
 					  unaffected processors
+			on		- (default) selects IBPB or BHB clear
+					  mitigation based on CPU
 
 	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index aa4a727f0abf..d3fa6c2ad341 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3088,6 +3088,8 @@ static int __init vmscape_parse_cmdline(char *str)
 	} else if (!strcmp(str, "force")) {
 		setup_force_cpu_bug(X86_BUG_VMSCAPE);
 		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
+	} else if (!strcmp(str, "on")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_ON;
 	} else {
 		pr_err("Ignoring unknown vmscape=%s option.\n", str);
 	}

-- 
2.34.1



