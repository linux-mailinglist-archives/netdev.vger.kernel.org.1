Return-Path: <netdev+bounces-259619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEfNKdutl2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:42:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFA163E96
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C8E3026C2A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71A1F09A5;
	Fri, 20 Feb 2026 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mckt35cH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A701B0F19
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548034; cv=none; b=q32/Ql13gb7rStlJT/WpQVa0PSD9B8JLlOabfTfKLYRzEw4B46wl0MHTnppk43fUFUIGJcIYvQ5Kx5DsT/f6rmgYWKP1OGiC58cLa2O0NCWF7ynuqf1mq4yZe1vioz07kouCJU/1K+E09l+wy2nULLw0Ild2JSzULVHetebDMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548034; c=relaxed/simple;
	bh=hELtRf1+RelxDa7Tc7WYN9mHXWU60XRPUlkhSHSaFqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vd0T2sbWX9tHypLEk03j9ICBJnzL1kT2LGu9HA8DNEEskTejapqWFCtGZu1cWQa836CV3W9WIjlBbUl0n2gKSxDixD4ByIVWA8tnIjqzm0+HpYeP2DJ2oXjcxAOJyCu5+8UCaYiDB65sTB81yO5f/JQ86n7T3GQeShjnZ1IVCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mckt35cH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548034; x=1803084034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hELtRf1+RelxDa7Tc7WYN9mHXWU60XRPUlkhSHSaFqI=;
  b=Mckt35cHnINh/OOJgsT5NewXjyTm+9qaUZ9Bx4gmXhoAZP7E0yKnVB6+
   ZNBbpYClZpCDt7vdgQPCCS1fw3NLHV7GNPumsPQ97STsYuMWxNsVagtBp
   bk+9y1btIvA9UvHN5v5x8b7w1l0/NWFoWbs3sYV7Yc2tzcMDudPp68ip/
   2E4ARckRkR/1tsV7o4iQB7sk+7AsIWg+pPkFP0itccbJS50ElViK0rY2x
   SxSnoP9zYRBVHKGwgTu65+tdPXTtOUaVIZ1BvAG1EHEKEKT69og3T7eYS
   UOclpYQMYWTfZlAk+M5UEJvNZoSspqfSghSBwXCfwXsMoFQHlztlaZ7LH
   Q==;
X-CSE-ConnectionGUID: NdnvtH1MQ4aAgx5fX5iCYA==
X-CSE-MsgGUID: Ookm2kKpSpyiM7yXs+wMsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484163"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484163"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:33 -0800
X-CSE-ConnectionGUID: DvteM3giTHODAMk9wn765A==
X-CSE-MsgGUID: YHsyo0iaRYeiwCIhZC46Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850457"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/13][pull request] Intel Wired LAN Driver Updates 2026-02-19 (idpf, ice, i40e, ixgbevf, e1000e)
Date: Thu, 19 Feb 2026 16:40:12 -0800
Message-ID: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259619-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21FFA163E96
X-Rspamd-Action: no action

For idpf:
Li Li moves the check for software marker to occur after incrementing
next to clean to avoid re-encountering the same packet. He also adds a
couple of checks to prevent NULL pointer dereferences and NULLs rss_key,
after free, in error path so that later checks are properly evaluated.

Brian Vazquez adjusts IRQ naming to have correlation with netdev naming.

Sreedevi removes validation of action type as part of ntuple rule
deletion.

For ice:
Aaron Ma breaks RDMA initialization into two steps and adjusts calls so
that VSIs are entirely configured before plugging.

Michal Schmidt fixes initialization of loopback VSI to have proper
resources allocated to allow for loopback testing to occur.

For i40e:
Thomas Gleixner fixes a leak of preempt count by replacing get_cpu()
with smp_processor_id().

For ixgbevf:
Jedrzej adds a check for mailbox version before attempting to call an
associated link state call that is supported in that mailbox version.

For e1000e:
Vitaly clears power gating feature for Panther Lake systems to avoid
packet issues. He also adds detection, and correction, of XTAL clock on
Tiger Lake and Alder Lake systems.

The following are changes since commit 8bf22c33e7a172fbc72464f4cc484d23a6b412ba:
  Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Aaron Ma (1):
  ice: recap the VSI and QoS info after rebuild

Brian Vazquez (1):
  idpf: change IRQ naming to match netdev and ethtool queue numbering

Jedrzej Jagielski (1):
  ixgbevf: fix link setup issue

Li Li (4):
  idpf: increment completion queue next_to_clean in sw marker wait
    routine
  idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
  idpf: skip deallocating txq group's txqs if it is NULL
  idpf: nullify pointers after they are freed

Michal Schmidt (1):
  ice: fix crash in ethtool offline loopback test

Sreedevi Joshi (1):
  idpf: Fix flow rule delete failure due to invalid validation

Thomas Gleixner (1):
  i40e: Fix preempt count leak in napi poll tracepoint

Vitaly Lifshits (3):
  e1000e: introduce new board type for Panther Lake PCH
  e1000e: clear DPG_EN after reset to avoid autonomous power-gating
  e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency

 drivers/net/ethernet/intel/e1000e/defines.h   |  1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |  4 +-
 drivers/net/ethernet/intel/e1000e/hw.h        |  2 -
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 31 ++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 92 +++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c     |  5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +
 drivers/net/ethernet/intel/ice/ice_idc.c      | 44 +++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c      | 15 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  3 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 14 ++-
 drivers/net/ethernet/intel/ixgbevf/vf.c       |  3 +-
 16 files changed, 191 insertions(+), 38 deletions(-)

-- 
2.47.1


