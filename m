Return-Path: <netdev+bounces-278906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULbzBZhH4GkPeQAAu9opvQ
	(envelope-from <netdev+bounces-278906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C1409AEE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7AB300D31F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8622A80D;
	Thu, 16 Apr 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Osu8rI3a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648811A6805;
	Thu, 16 Apr 2026 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776305914; cv=none; b=T5tU5onYsoigs+/T9rIIgLfyvlNoqsxb6l6TbC3G2tLi3HnlddTYgaU2oI04BbHpb2e+DnxvKnlfnf9YQnUn9VRcvjS4Eok22h+82YcJ9pnzSy2XgW7zI/Iy+GIpID8DFXEhPraKhJdLU81jvu2UZupbPCM0QPOTXvb7TONWYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776305914; c=relaxed/simple;
	bh=Hd+1dN5IevHoWoTVdLczDqxYv7KnWEcwalHmW5qnm94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7IyCQmscOIloXZuG0ovaX/Q9D5yVC9O2HrU+J5IF5D7hJkpO8H7YnQ1BtUKCkZybbUJVagEcB58JrTSQerJVfmd2dhO9WDXIp9BAePmo9pV3xyiEY9QN2OVOOJpPyll0IB1gj46zUmtXnN3Xv+7M8vWjxEjlGw0ndRYgGlt+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Osu8rI3a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776305912; x=1807841912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hd+1dN5IevHoWoTVdLczDqxYv7KnWEcwalHmW5qnm94=;
  b=Osu8rI3aZZX2Z8wdgdVaphn66pCUxOlzqlilA9mjTadnd4LOttDy8Dbx
   ca2p4GMuXDPhB/n2ArY7hV5HpopWID49hI8hbgwFRtdHfNaKH1Y7bFAq8
   53TrBNaBfgpF0o6vcZn092GHMjq0lzhOBJJqZO6jZU6rrtTGJ73AgUBaR
   wK+nj9FiRSTeNVM/k7PeSNJSsU0zawjNKiolmqmvz4bEwtQSx/0WfK3UR
   jfXfPgdKmm4ykxhfy0/N6jGxe5vgqmlgmnfUYD3CdN3J/kuoTGhd/+7SR
   9N2D03tS4+CBKF5qnt0cuMPDtDnhBsjFHFnvzRL0aAuhMDuqLay1pJ2f5
   w==;
X-CSE-ConnectionGUID: rWV5HKF0QiCGG9ZrDSGFSg==
X-CSE-MsgGUID: 2iG6qyEES+yOgTbSlaSE4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81168775"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81168775"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 19:18:31 -0700
X-CSE-ConnectionGUID: 3CyJPPd4TjKHQSu86COnsA==
X-CSE-MsgGUID: MDa1h4/FT0ShD6TrkLAXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227442166"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 19:18:05 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-next v2 0/3] igc: add support for forcing link speed without autonegotiation
Date: Thu, 16 Apr 2026 09:55:17 +0800
Message-ID: <20260416015520.6090-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278906-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B86C1409AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v2:
- Simon Horman's review comment: when forcing half-duplex, set
  hw->fc.requested_mode = igc_fc_none, since half-duplex cannot support
  flow control per IEEE 802.3.
- Split the original single patch into three patches for clarity:
  patches 1 and 2 are preparatory cleanups; patch 3 carries the
  functional change.

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (3):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 203 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 251 insertions(+), 90 deletions(-)

--
2.43.0


