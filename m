Return-Path: <netdev+bounces-254017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JsqMaE8eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:30:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB69B117
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33EDC3014138
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07C25487B;
	Tue, 27 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiT5X272"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377E45BE3
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553055; cv=none; b=eACh2ZQFgTX0oadX34OjOLDM1T9ZZ7FzZ76W1IRQ3t18rnl+gTCm0RDmLNm0erROG0JlAaky6EDBxG41sSGtgPx9wYbZyMVg1cdza7HiOhikpMN90y1LjzhMpP2b2IJWJNki1eTLRZeFfU31bBsu+H8sQTzUnJCqPF2wlgJA6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553055; c=relaxed/simple;
	bh=7gZNLxBsHt38KYsXdfaiP6M0YvXBEDU+WsvUqz4bxn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/B5HReRt39m1Q5oH5h4R/wUiZNbnYodyr4UGuApx/wpKErYoK91kNCEq4MdFWr+mgOQlySXRjb4SjGym7/2gvIcMYs/212n5ByDcmnxGkPtdV+DhwgG7OMaGyCb4d1QRLs9bovbXfGlPkpbdJnQvVxcLlKRQ+5yBa7ZHXTxMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiT5X272; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553054; x=1801089054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7gZNLxBsHt38KYsXdfaiP6M0YvXBEDU+WsvUqz4bxn8=;
  b=YiT5X272+AbW+ixPR16FUutu5+x0woDHA5oG2gpmUyciLVYyfH2TiV24
   V9zabQoU+QGUxCfTSIhezbdgsYBYV4OV9RilFB/7fuK8qrmTFnTowMa6o
   RrZe4VFODrTQ/hKVXEc903nY6vLAEQOp9wps5LkDZyUa09nEFlWGj8psK
   zOlJ2O583baVXAiw4ZrM1wNzoDxigzhne5viQHsNxUNpSaCrhpopWFghH
   a4Z1MjjQfmuaayeBjZUVgIlX323QoAMwmUOIW+6c3eQGfOOMNzhi3rh24
   l8YLYbhewBv6yU5QFz6twn80GKFq3iB22/P0fnYDhNvF7rqGtatMHEkCo
   g==;
X-CSE-ConnectionGUID: T1QB+/K2SX+bQ2qQCF66Ag==
X-CSE-MsgGUID: mDwIp3+eTAuAPEUmwJWdlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93418583"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93418583"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:30:54 -0800
X-CSE-ConnectionGUID: /ez3PlIlRsOQ8bnXp5Op6A==
X-CSE-MsgGUID: mee8J2CeTYy/7dHQ9Lvvfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="245714634"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 14:30:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2026-01-27 (ixgbe, ice)
Date: Tue, 27 Jan 2026 14:30:41 -0800
Message-ID: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254017-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DFB69B117
X-Rspamd-Action: no action

For ixgbe:
Kohei Enju adjusts the cleanup path on firmware error to resolve some
memory leaks and removes an instance of double init, free on ACI mutex.

For ice:
Aaron Ma adds NULL checks for q_vectors to avoid NULL pointer
dereference.

Jesse Brandeburg removes UDP checksum mismatch from being counted in Rx
errors.

The following are changes since commit e9acda52fd2ee0cdca332f996da7a95c5fd25294:
  bonding: fix use-after-free due to enslave fail after slave array update
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 10GbE

Aaron Ma (1):
  ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues

Jesse Brandeburg (1):
  ice: stop counting UDP csum mismatch as rx_errors

Kohei Enju (2):
  ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
  ixgbe: don't initialize aci lock in ixgbe_recovery_probe()

 drivers/net/ethernet/intel/ice/ice_lib.c      | 10 ++++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 +++++++------------
 3 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.47.1


