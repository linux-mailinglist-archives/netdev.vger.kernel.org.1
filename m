Return-Path: <netdev+bounces-288411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLRhDddmB2p11wIAu9opvQ
	(envelope-from <netdev+bounces-288411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C5556474
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250D23084ACC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E309F30C164;
	Fri, 15 May 2026 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbJmRHAF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6030C143
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869468; cv=none; b=KxT8UJXUJaxjmse+r+jT5V77Blo2NNw286N0ADHlymE2M6wDttYpfQHI4zqsReXQG9RkY4KzjdeBaB24L6gs1nNLYe0nKCKp+16502mzu2V1hyoj0MZIcvPAedsbJCz6saPU1IM1WysUCLLl2zzxylsPG2SLaICZKJGfontg82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869468; c=relaxed/simple;
	bh=ciC8WGxDeybLLAgjAV1uXIHcHgKts+zrf4/C+wbbW2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Laur3xJyGD/nOGvTELlzfnd8125ewSAB6cZ4xvgi4o4eVj+PyD9FYzr8LIrrXQsK/0hwj8nUoX8cnpz5i5LcIbJW4G1UxJMEznpJ9YjRjDeZbvRd1AGaHKqXiplP5Zkycl3jI9nc2sOPLS5YYHMyfAMf56S+IsXFGsWeysE+pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbJmRHAF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869467; x=1810405467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ciC8WGxDeybLLAgjAV1uXIHcHgKts+zrf4/C+wbbW2s=;
  b=SbJmRHAFw/mbUnzdRjgOoIHPTLFkTu89nfjIdMZy9WjkVBUjOS+5nlkC
   k97kLWZpJ2tGfxFuwRw+VXudQWRMJToUfmy5PxWCC/nKkvJtTZdTEih7O
   nhLpLxtiRZfAgBhDEdnRVxBATftTS1gppMeJmhzrC4K8AehKuZLXEagmB
   wZJY3u8lcvqJ+eI9K0EfTNzDV95lHDXfCZ6cgiL6d68u1Jb7weWNqqOUf
   e8fxHIZ/t4qoaDng75oJq8Jc4RV8EvTDFja1+OhJzyPHqZlI3a41XDM6E
   yFJh91hcd5+HnQQyVQqn4wM6d8vclZAR1qt8xCm36y3OVB3clM5gtGfPO
   Q==;
X-CSE-ConnectionGUID: b8lMTglhRS6uPc78SEiT8A==
X-CSE-MsgGUID: n4q1ugpCTOykW3FpzhMbOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701120"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:26 -0700
X-CSE-ConnectionGUID: v8M7h2l0RU+gRaIDLxEirw==
X-CSE-MsgGUID: Wftxy9GhSkKfR3i5E2evrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647432"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates 2026-05-15 (ice, ixgbevf, igc, e1000e)
Date: Fri, 15 May 2026 11:24:07 -0700
Message-ID: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D39C5556474
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288411-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

For ice:
Jake fixes a mismatch in locking around wait queue usage.

Jose Ignacio Tornos Martinez adjusts allowed lower bound for VF data
buffer size to accommodate low MTU sizes.

Marcin adjusts for -EEXIST to not trigger error path when the promisc
filter already exists as part of adding VLAN Ids.

Grzegorz fixes a few issues related to PTP. He adds locking to
ice_start_phy_timer_eth56g() to protect proper register programming.
Fixes the PTP lock used in 2xNAC configuration to always be the primary
and restores PTP configuration on ethtool channel changes.

For ixgbevf:
Michael Bommarito sets freed skb pointer to NULL to prevent
use-after-free.

For igc:
Kohei Enju resolves a couple of issues reported by Sashiko; setting
buffer type for an SMD skb and freeing skb on error of
igc_fpe_init_tx_descriptor().

For e1000e:
Vitaly adds detection, and correction, of XTAL clock on Tiger Lake
and Alder Lake systems.
---
Note: The e1000e patch was originally here:
https://lore.kernel.org/netdev/20260220004027.729384-14-anthony.l.nguyen@intel.com/

Changes since:
- fix cc.shift
- wrap TIMINCA write in systim_lock
- replace ktime_to_ns(ktime_get_real()) with ktime_get_real_ns()

The following are changes since commit 5db89c99566fc4728cc92e941d8e1975711e24b5:
  net: ifb: report ethtool stats over num_tx_queues
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Grzegorz Nitka (3):
  ice: ptp: serialize E825 PHY timer start with PTP lock
  ice: ptp: use primary NAC semaphore on E825
  ice: restore PTP Rx timestamp config after ethtool set-channels

Jacob Keller (1):
  ice: fix locking around wait_event_interruptible_locked_irq

Jose Ignacio Tornos Martinez (1):
  ice: fix VF queue configuration with low MTU values

Kohei Enju (2):
  igc: set tx buffer type for SMD frames
  igc: fix potential skb leak in igc_fpe_xmit_smd_frame()

Marcin Szycik (1):
  ice: fix setting promisc mode while adding VID filter

Michael Bommarito (1):
  ixgbevf: fix use-after-free in VEPA multicast source pruning

Vitaly Lifshits (1):
  e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency

 drivers/net/ethernet/intel/e1000e/netdev.c    | 78 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  8 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 33 ++++++--
 drivers/net/ethernet/intel/ice/virt/queues.c  |  2 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c      |  9 ++-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  1 +
 6 files changed, 121 insertions(+), 10 deletions(-)

-- 
2.47.1


