Return-Path: <netdev+bounces-291340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZgDGxdFGqgMwcAu9opvQ
	(envelope-from <netdev+bounces-291340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:32:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5D5CBC4D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66A43013D6A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DE3ED5D9;
	Mon, 25 May 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QC43VHLh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DB34846E
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719465; cv=none; b=sJND9uqEztBUaP6zwzNsrkqEYRDpVs4y/z6gXG1mzqgpfM2FeOW5bbbfs2nJWrf8yvK2nWoC0ShJiK1qU/vG01asNeF72WSEPWo3ijrPJy8AgRTqzPiKNw/W6W/cf7pWCmp7GHDH/WSc2TFAGDAiY+nofXA8aPxwRJHYlRGPUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719465; c=relaxed/simple;
	bh=WMTE157dD8g+v5naxxaBeOIvwYVp6WNe8lrymqYZFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWtCVwNsf9HFG+Wu6Qf4cnn/y3Mtg9ju7GGpyOTUOYewaPpVGEBBSyNp2M+hAGnBvSTDWsp8rt+3BT1hPTe2O6dcZzCl1WzOdDNO2GgJDhtwq3OsLCOHt3IEIb2kLQptDZtZDPEXsnkGZLQQMZ6JWa5j7Bnp8Cd1e4mi8NqFLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QC43VHLh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779719463; x=1811255463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WMTE157dD8g+v5naxxaBeOIvwYVp6WNe8lrymqYZFTI=;
  b=QC43VHLhvnvl/9g1bPdZo18BZkAfLWRzpdJdED0aG7a2wIT4+pgt5mFP
   wCoClHNT6Q+ErfHUcDQ5483yoaUsz+kAYu5HtrbFncIaGCB3fRdM6B769
   wy79ER+DkZVj3fQP4AARxNB9dtbmHoaColcX3VH7bOQdWlQi2jKAIYbnE
   vAO3jnmqXUlKPDkmpEKGSdZmAu2iY7Q/tTn5xvm/453/1t5vqRb7Bu6Nb
   EclBhKGkWMj9zKGCC26C9NbKTErTQSB+0fBN9YiFzyFARwz3t8BsP2N/2
   +1OUlCedBCwPx5g7xQzNEUQUeEVC55lkE3fjALmR2jATdR5TwCiCJckpP
   Q==;
X-CSE-ConnectionGUID: nKY0xJu4RG+zZR5zUhfVVg==
X-CSE-MsgGUID: NPejLbQpRt+8jPmaApHw3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80596719"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="80596719"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 07:31:02 -0700
X-CSE-ConnectionGUID: nvL+cXkzQMGhns8v9KSxZA==
X-CSE-MsgGUID: kZITJZNgR8CBwnc+tBgYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="237189227"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa006.fm.intel.com with ESMTP; 25 May 2026 07:31:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [RESEND PATCH iwl-net v2 0/3] Rework ctrl_pf pointer usage in struct ice_adapter
Date: Mon, 25 May 2026 14:30:57 +0000
Message-ID: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,osuosl.org:url,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 84E5D5CBC4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260504/054842.html

v1->v2: Rebase onto the latest dev-queue branch:
        297c032796ab ("igc: add support for forcing link speed without autonegotiation")

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         | 10 ++-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 66 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 26 ++++++--
 4 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.53.0


