Return-Path: <netdev+bounces-269504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COYVKdkYvGlEsQIAu9opvQ
	(envelope-from <netdev+bounces-269504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:40:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036992CDD5D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D7B63012B50
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697CC3E63BA;
	Thu, 19 Mar 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8uYBtaF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A93E3173;
	Thu, 19 Mar 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934805; cv=none; b=MGc/TVnYL2bvhgsJc3qnpuBNsi8/OYGeIt17BsyGaIdWMSX488TTzgEd+7RsUJVHCzLtnl0rZAe7mVrP2+7p5bGf4WJu8dJVJ5jNcwwaGxFScSGCNhoCwmqKAxpQu63JpFNHTXcmNRgZvVBhB5XQuzSrZpjuaIuYPCWgNgghJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934805; c=relaxed/simple;
	bh=8emaTLPxEgafUtAPvR+F0T/ynGTrAJNTFy/hqEOWGzE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kwLpqRGwBYBMpI48TivVcuCSBwPHkY6PLrlTTLEA3j1SvXclCqF3DdN6hYtabMmOZzBDqqwR3LGBCyd0JZZHTU+8RcwO2wLyjAOLjPBC36NWwdYMC6eYF9q4yKJ8C+6RVPWicd0pCphCqG/vtfTjCPaKcvCjjZO0CHL6ZRD2dMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8uYBtaF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773934804; x=1805470804;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8emaTLPxEgafUtAPvR+F0T/ynGTrAJNTFy/hqEOWGzE=;
  b=D8uYBtaFbn7rim+05cRTc6eGs0w1/YGk0Z6r0NVbWHgYoSTuJ/QnlRoP
   FN38T/eD89wthabO1W0eDqrw4vGCMmdsVL7u8jwlaFEE7rLg8W0j/9bR7
   TldIfmCkuIdpUrVG1cX7uJ74bgKS6S9SunS9oBEldL8QWZYNhCldM5t/r
   3w5IiSCLBSb7zOuv/UW+ruRemXj1ojNzl9jww428xiG3SaalbTBNdvFxz
   yFRpVq0eAcH9Yr9nyI7OACfcgYCL6ml0vCzJkQ8I/MQtf3pu/CX6CzzCZ
   jVEKImGP92h34mbZgwQdQCDFvs7NfknbLKNNYZGsc88eJLlc6Toa4C5Ed
   Q==;
X-CSE-ConnectionGUID: lWOSUTtOShq4QQ9gCCmA9Q==
X-CSE-MsgGUID: f1dSQysaT1mRHNS77NF8oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78868755"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78868755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:40:03 -0700
X-CSE-ConnectionGUID: 4ioP+Kv7SFCqtVD3EB9QBA==
X-CSE-MsgGUID: LlK2adJCRn2gb9b203t3RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="222241348"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 08:40:03 -0700
Date: Thu, 19 Mar 2026 08:40:01 -0700
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
Subject: [PATCH v7 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIEXvGkC/23QTWrDMBAF4KsEraugGf0xXfUepQtZI9eCxAl2K
 lKC7145lCaiXr6B+eC9m5jTlNMsXnc3MaWS53waa/AvOxGHMH4mmblmgQqtInCyHOcYzkl2Qyf
 Zs3FE3vfYi/pxnlKfr3ft/aPmIc+X0/R9xwus118HTeMUkEpysNCrBKQNvx3y+HXd5/GSDvt4O
 opVK/gngALbClgFgtgxU9SB3LagnwT0raCrYD3piFabRHpbMA8BgFrBVAECBzbJEXPcFuyTgO2
 excraA9m5ZFB3Sm0L7iGgglZw65IOFLMF68H8F5Zl+QHfXtB89gEAAA==
X-Change-ID: 20250916-vmscape-bhb-d7d469977f2f
X-Mailer: b4 0.15-dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269504-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,ethz.ch:url]
X-Rspamd-Queue-Id: 036992CDD5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v7:
- s/This allows/Allow/ and s/This does adds/This adds/ in patch 1/10 commit
  message (Borislav).
- Minimize register usage in BHB clearing seq. (David Laight)
  - Instead of separate ecx/eax counters, use al/ah.
  - Adjust the alignment of RET due to register size change.
  - save/restore rax in the seq itself.
  - Remove the save/restore of rax/rcx for BPF callers.
- Rename clear_bhb_loop() to clear_bhb_loop_nofence() to make it
  obvious that the LFENCE is not part of the sequence (Borislav).
- Fix Kconfig: s/select/depends on/ HAVE_STATIC_CALL (PeterZ).
- Rebased to v7.0-rc4.

v6: https://lore.kernel.org/r/20251201-vmscape-bhb-v6-0-d610dd515714@linux.intel.com
- Remove semicolon at the end of asm in ALTERNATIVE (Uros).
- Fix build warning in vmscape_select_mitigation() (LKP).
- Rebased to v6.18.

v5: https://lore.kernel.org/r/20251126-vmscape-bhb-v5-2-02d66e423b00@linux.intel.com
- For BHI seq, limit runtime-patching to loop counts only (Dave).
  Dropped 2 patches that moved the BHB seq to a macro.
- Remove redundant switch cases in vmscape_select_mitigation() (Nikolay).
- Improve commit message (Nikolay).
- Collected tags.

v4: https://lore.kernel.org/r/20251119-vmscape-bhb-v4-0-1adad4e69ddc@linux.intel.com
- Move LFENCE to the callsite, out of clear_bhb_loop(). (Dave)
- Make clear_bhb_loop() work for larger BHB. (Dave)
  This now uses hardware enumeration to determine the BHB size to clear.
- Use write_ibpb() instead of indirect_branch_prediction_barrier() when
  IBPB is known to be available. (Dave)
- Use static_call() to simplify mitigation at exit-to-userspace. (Dave)
- Refactor vmscape_select_mitigation(). (Dave)
- Fix vmscape=on which was wrongly behaving as AUTO. (Dave)
- Split the patches. (Dave)
  - Patch 1-4 prepares for making the sequence flexible for VMSCAPE use.
  - Patch 5 trivial rename of variable.
  - Patch 6-8 prepares for deploying BHB mitigation for VMSCAPE.
  - Patch 9 deploys the mitigation.
  - Patch 10-11 fixes ON Vs AUTO mode.

v3: https://lore.kernel.org/r/20251027-vmscape-bhb-v3-0-5793c2534e93@linux.intel.com
- s/x86_pred_flush_pending/x86_predictor_flush_exit_to_user/ (Sean).
- Removed IBPB & BHB-clear mutual exclusion at exit-to-userspace.
- Collected tags.

v2: https://lore.kernel.org/r/20251015-vmscape-bhb-v2-0-91cbdd9c3a96@linux.intel.com
- Added check for IBPB feature in vmscape_select_mitigation(). (David)
- s/vmscape=auto/vmscape=on/ (David)
- Added patch to remove LFENCE from VMSCAPE BHB-clear sequence.
- Rebased to v6.18-rc1.

v1: https://lore.kernel.org/r/20250924-vmscape-bhb-v1-0-da51f0e1934d@linux.intel.com

Hi All,

These patches aim to improve the performance of a recent mitigation for
VMSCAPE[1] vulnerability. This improvement is relevant for BHI variant of
VMSCAPE that affect Alder Lake and newer processors.

The current mitigation approach uses IBPB on kvm-exit-to-userspace for all
affected range of CPUs. This is an overkill for CPUs that are only affected
by the BHI variant. On such CPUs clearing the branch history is sufficient
for VMSCAPE, and also more apt as the underlying issue is due to poisoned
branch history.

Below is the iPerf data for transfer between guest and host, comparing IBPB
and BHB-clear mitigation. BHB-clear shows performance improvement over IBPB
in most cases.

Platform: Emerald Rapids
Baseline: vmscape=off
Target: IBPB at VMexit-to-userspace Vs the new BHB-clear at
	VMexit-to-userspace mitigation (both compared against baseline).

(pN = N parallel connections)

| iPerf user-net | IBPB    | BHB Clear |
|----------------|---------|-----------|
| UDP 1-vCPU_p1  | -12.5%  |   1.3%    |
| TCP 1-vCPU_p1  | -10.4%  |  -1.5%    |
| TCP 1-vCPU_p1  | -7.5%   |  -3.0%    |
| UDP 4-vCPU_p16 | -3.7%   |  -3.7%    |
| TCP 4-vCPU_p4  | -2.9%   |  -1.4%    |
| UDP 4-vCPU_p4  | -0.6%   |   0.0%    |
| TCP 4-vCPU_p4  |  3.5%   |   0.0%    |

| iPerf bridge-net | IBPB    | BHB Clear |
|------------------|---------|-----------|
| UDP 1-vCPU_p1    | -9.4%   |  -0.4%    |
| TCP 1-vCPU_p1    | -3.9%   |  -0.5%    |
| UDP 4-vCPU_p16   | -2.2%   |  -3.8%    |
| TCP 4-vCPU_p4    | -1.0%   |  -1.0%    |
| TCP 4-vCPU_p4    |  0.5%   |   0.5%    |
| UDP 4-vCPU_p4    |  0.0%   |   0.9%    |
| TCP 1-vCPU_p1    |  0.0%   |   0.9%    |

| iPerf vhost-net | IBPB    | BHB Clear |
|-----------------|---------|-----------|
| UDP 1-vCPU_p1   | -4.3%   |   1.0%    |
| TCP 1-vCPU_p1   | -3.8%   |  -0.5%    |
| TCP 1-vCPU_p1   | -2.7%   |  -0.7%    |
| UDP 4-vCPU_p16  | -0.7%   |  -2.2%    |
| TCP 4-vCPU_p4   | -0.4%   |   0.8%    |
| UDP 4-vCPU_p4   |  0.4%   |  -0.7%    |
| TCP 4-vCPU_p4   |  0.0%   |   0.6%    |

[1] https://comsec.ethz.ch/research/microarch/vmscape-exposing-and-exploiting-incomplete-branch-predictor-isolation-in-cloud-environments/

---
Pawan Gupta (10):
      x86/bhi: x86/vmscape: Move LFENCE out of clear_bhb_loop()
      x86/bhi: Make clear_bhb_loop() effective on newer CPUs
      x86/bhi: Rename clear_bhb_loop() to clear_bhb_loop_nofence()
      x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
      x86/vmscape: Move mitigation selection to a switch()
      x86/vmscape: Use write_ibpb() instead of indirect_branch_prediction_barrier()
      x86/vmscape: Use static_call() for predictor flush
      x86/vmscape: Deploy BHB clearing mitigation
      x86/vmscape: Fix conflicting attack-vector controls with =force
      x86/vmscape: Add cmdline vmscape=on to override attack vector controls

 Documentation/admin-guide/hw-vuln/vmscape.rst   |  8 +++
 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 arch/x86/Kconfig                                |  1 +
 arch/x86/entry/entry_64.S                       | 34 +++++++----
 arch/x86/include/asm/cpufeatures.h              |  2 +-
 arch/x86/include/asm/entry-common.h             |  9 ++-
 arch/x86/include/asm/nospec-branch.h            | 13 +++--
 arch/x86/kernel/cpu/bugs.c                      | 75 ++++++++++++++++++++-----
 arch/x86/kvm/x86.c                              |  4 +-
 arch/x86/net/bpf_jit_comp.c                     | 11 +---
 10 files changed, 116 insertions(+), 45 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20250916-vmscape-bhb-d7d469977f2f

Best regards,
--  
Pawan



