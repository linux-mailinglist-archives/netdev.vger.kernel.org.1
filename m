Return-Path: <netdev+bounces-275747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJHGIwUm1Gn5rgcAu9opvQ
	(envelope-from <netdev+bounces-275747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B463A78AD
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 361C53017275
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471523002B6;
	Mon,  6 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFPtVoLV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43481EA84
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511043; cv=none; b=XKB/3T9MZzbQsTBHDCftFT9rFyrSk767az4P+5Wt1OhV6mmMJjyBkKX+ZuHkaRj/VguGbKv5uACY02EHEWi+DXT6UJhp33Lzb8V8DlA458bFa5e+1Rc00rW8hu0y+5F3Bc8+DRCjQ3D2OLFkaZE2Pps2BRQVCEKaHg8/uqsPFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511043; c=relaxed/simple;
	bh=3DbwH5S+dOYHqyNr4unyFqxi3ye4PNvDERqNBhGK/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyC76fhqUCkuSsWXEeN5F2WCkJe/NNCKdOoLGkWEacNY5fqqFq1QiQ5vLX8poQs69LUaANcQDbm0GtDRlJRazEOXagRNwYEdhfZyEmMxyVYPWLowbUBjOw8L/F5loI77MOkxz3UVF3qL6VgxOlUOl6zVAi6N2GRqPiQXiLu3Dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFPtVoLV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775511042; x=1807047042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3DbwH5S+dOYHqyNr4unyFqxi3ye4PNvDERqNBhGK/Gc=;
  b=iFPtVoLV7uFiU04atkf5yqND6HN1jhFuH1hrKMxps+CcTxN0LR24f5uX
   DAwgrVuvqw59qtQ+2vajy3LW+5Tmfw0wGgi0LLtKKW+S3lVmaeQkTHa5X
   I1IbvzMGuYjUR3PlLJW61P2QJWU+H0aN5PQzBEdjXYLqaHIiMQZfUhwCs
   zqSZl+fMsOkj9bexJDmSVRjCn+oPG2qE/q42/hqHxNb7hUsGxRiqzPyCy
   PnHVmDvKntParf3OTrTT9UoqMrHi5skaAyyMAyOFBpTeyGuhwo+r0Ymu7
   jOpEKedpN9fT8YKMUkpjKB3rP9dphRy65lKwfdMkT+lBFkGlGikq25OtN
   w==;
X-CSE-ConnectionGUID: npn6ywEKROaE+Sd/AxLO2A==
X-CSE-MsgGUID: 5rAJlhbpQ5y2Uf3OT9KjPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79057365"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="79057365"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 14:30:41 -0700
X-CSE-ConnectionGUID: wLIY9tpAQTeVsJzk0C4QHg==
X-CSE-MsgGUID: kDRpwBVWQnyn1Cy1DxthnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228248093"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2026 14:30:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates 2026-04-06 (idpf, ice, ixgbe, ixgbevf, igb, e1000)
Date: Mon,  6 Apr 2026 14:30:27 -0700
Message-ID: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275747-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 26B463A78AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Emil converts to use spinlock_t for virtchnl transactions to make
consistent use of the xn_bm_lock when accessing the free_xn_bm bitmap,
while also avoiding nested raw/bh spinlock issue on PREEMPT_RT kernels.
He also sets payload size before calling the async handler, to make sure
it doesn't error out prematurely due to invalid size check for idpf.

Kohei Enju changes WARN_ON for missing PTP control PF to a dev_info() on
ice as there are cases where this is expected and acceptable.

Petr Oros fixes conditions in which error paths failed to call
ice_ptp_port_phy_restart() breaking PTP functionality on ice.

Alex significantly reduces reporting of driver information, and time
under RTNL locl, on ixgbe e610 devices by reducing reads of flash info
only on events that could change it.

Michal Schmidt adds missing Hyper-V op on ixgbevf.

Alex Dvoretsky removes call to napi_synchronize() in igb_down() to
resolve a deadlock.

Agalakov Daniil adds error check on e1000 for failed EEPROM read.

The following are changes since commit 1caa871bb0615e2b68aa11bb7b453eeac770ea1d:
  Merge branch 'net-stmmac-fix-tegra234-mgbe-clock'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Agalakov Daniil (1):
  e1000: check return value of e1000_read_eeprom

Aleksandr Loktionov (1):
  ixgbe: stop re-reading flash on every get_drvinfo for e610

Alex Dvoretsky (1):
  igb: remove napi_synchronize() in igb_down()

Emil Tantilov (3):
  idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
  idpf: improve locking around idpf_vc_xn_push_free()
  idpf: set the payload size before calling the async handler

Kohei Enju (1):
  ice: ptp: don't WARN when controlling PF is unavailable

Michal Schmidt (1):
  ixgbevf: add missing negotiate_features op to Hyper-V ops table

Petr Oros (1):
  ice: fix PTP timestamping broken by SyncE code on E825C

 .../net/ethernet/intel/e1000/e1000_ethtool.c  |  8 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 30 ++++++++++++-------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 20 +++++++------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  5 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     |  3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 13 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++++
 drivers/net/ethernet/intel/ixgbevf/vf.c       |  7 +++++
 10 files changed, 67 insertions(+), 33 deletions(-)

-- 
2.47.1


