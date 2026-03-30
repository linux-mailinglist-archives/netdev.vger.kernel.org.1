Return-Path: <netdev+bounces-273362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLYAOSMBy2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:02:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F836233B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9D6A301B17C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCA37C90A;
	Mon, 30 Mar 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFJIPaQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0E2F87B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911775; cv=none; b=Xmjp6j/3uarwEHt04LXHlJwGDbidK92ZMKOZc9ywlxVYexupjTLp4yIYi1FFPxGcWzwNUjuhpj2bfqKcIoXhker62nuoZsWaz8s0OTYlU6PMGzuP/vXQAW8pOHIcTtiMdf7y8lZe3MXmKhZoQ1hfkKj18rDTHzHY0gFpx+WQaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911775; c=relaxed/simple;
	bh=Z6Bsqpx5jBqtaFOF7nudK6XFEbhWCEZvVeHQW0mheQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXXH7D/L/rQ8wrbvAITBeNvlJmm980eCMiM/pfNvG+Fe3ZfmV3S5TT5wWAn94BefBZw9Km/GfM3gjdIww7gsuae87RvAMKeN5q3++OIai3sS89tLH2vBMB6pwMhpgBy3vg9FjSDkRVSAAMDKANE6KUXGvkV3TaWpiX8QNqF4AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFJIPaQ/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911773; x=1806447773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z6Bsqpx5jBqtaFOF7nudK6XFEbhWCEZvVeHQW0mheQA=;
  b=fFJIPaQ/AhZd5fUte5ZtyoRXhSWL64pbzrCFcOdq6vQY+p21TLy427fA
   h3mkfJwMJiadBfN4s+JlQpo9vbDvMLviJvUtophQ3rgkCAPJM7jHtJqcS
   k6srnvRmqVL3jFhX884g/FpUnoD9oQavIncbCEqDeYbYZwqAr8A8TfM+e
   LsZ0MEugsboyDuEhcd5l7DuzC+iqfM9odAtNnr8IRUwhu1+32t64GMZAE
   MUHNqze7MD3heNByoD/g3LsjiucSd8rh2COMNI6b+BeilVilOU8sTHHJB
   7ggejZNZNvNYSyndlPmD05Z2G5Uh1kROHi7a2w2LV7q5yk9KyvVyQ2gtO
   g==;
X-CSE-ConnectionGUID: BMdeXXuvTMW+cieXkmVtSw==
X-CSE-MsgGUID: YlNL5NCkRFKGEBAyLjKzlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297534"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297534"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:52 -0700
X-CSE-ConnectionGUID: P8boB7d9Tzi9xKzNk5SMgA==
X-CSE-MsgGUID: kzZRhbABRPG8Q7PWlS6AxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687699"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:52 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-03-30 (igc, igb, ice)
Date: Mon, 30 Mar 2026 16:02:29 -0700
Message-ID: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273362-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 600F836233B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For igc:
Mika Westerberg makes improvements to power management flows with a
focus on PTM.

Kohei Enju adds ethtool support for get/set hash key.

Maximilian Pezzullo fixes some typos.

For igb:
Takashi Kozu adds ethtool support for get/set hash key.

Kohei Enju adds setting of skb hash type based on values from Rx
descriptor.

Maximilian Pezzullo fixes some typos here as well.

For ice:
Arkadiusz adds support for unmanaged DPLL for ice E830 devices; device
settings are fixed but can be queried by DPLL.

Jake adds clarification for needed action on devlink reload command.

Przemyslaw Korba expands the size of a char array to silence a
format-truncation warning.

The following are changes since commit cf0d9080c6f795bc6be08babbffa29b62c06e9b0:
  Merge branch 'net-hsr-subsystem-cleanups-and-modernization'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Arkadiusz Kubalewski (1):
  ice: add support for unmanaged DPLL on E830 NIC

Jacob Keller (1):
  ice: mention fw_activate action along with devlink reload

Kohei Enju (4):
  igc: prepare for RSS key get/set support
  igc: expose RSS key via ethtool get_rxfh
  igc: allow configuring RSS key via ethtool set_rxfh
  igb: set skb hash type from RSS_TYPE

Maximilian Pezzullo (2):
  igb: fix typos in comments
  igc: fix typos in comments

Mika Westerberg (3):
  igc: Call netif_queue_set_napi() with rtnl locked
  igc: Let the PCI core deal with the PM resume flow
  igc: Don't reset the hardware on suspend path

Przemyslaw Korba (1):
  ice: dpll: Fix compilation warning

Takashi Kozu (3):
  igb: prepare for RSS key get/set support
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 .../device_drivers/ethernet/intel/ice.rst     |  83 +++++
 .../net/ethernet/intel/ice/devlink/health.c   |   4 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 136 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 304 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  10 +
 .../net/ethernet/intel/ice/ice_fw_update.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  46 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/igb/e1000_82575.h  |  21 ++
 .../net/ethernet/intel/igb/e1000_defines.h    |   2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c    |   2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h    |   2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |   2 +-
 drivers/net/ethernet/intel/igb/igb.h          |   3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  85 +++--
 drivers/net/ethernet/intel/igb/igb_main.c     |  25 +-
 drivers/net/ethernet/intel/igc/igc.h          |   5 +-
 drivers/net/ethernet/intel/igc/igc_diag.c     |   2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  73 +++--
 drivers/net/ethernet/intel/igc/igc_main.c     |  43 ++-
 23 files changed, 774 insertions(+), 108 deletions(-)

-- 
2.47.1


