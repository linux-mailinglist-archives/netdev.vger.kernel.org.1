Return-Path: <netdev+bounces-277286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g95kA6Kr2GlPgwgAu9opvQ
	(envelope-from <netdev+bounces-277286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4183D3950
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F12301BA67
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636B3A3E71;
	Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTP9P0+R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C1332EBC
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807366; cv=none; b=Qc1SzmMRh7X7XawfoBYdSGccEMMhlyXuNSiOPeCGeXJMwaDdK4Z6R1m7U48curgzC0KBBQqifZa9oCd0J4xWIsLXXHlC+BrNMsMrp/vdLeo87J/rNUh07bZXkJwbMS4/Xi32ItBUK4k4ZFQYPgoh82RYhy4Sm9BDPUMK7KRg6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807366; c=relaxed/simple;
	bh=buWg/nB8AnUQvbl+9LgNQcCODOBB+fgL61OAveIbTH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMvP/b8j5xQPdTVH62Kb4VX4WlbtjOcN/HXUF0DH2uVeC7EsOsadmI9//JZmr/E0CG9kunR6KTDyMbY+P5HsE/QUDx4nb6rpdqmQqPkyOTA3JIxOS7QOkyXoqszvDL4ZxLpQr9Im7tt5hPtlA4LflhdoLmRJkbsPgweLo3J3Slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTP9P0+R; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807365; x=1807343365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=buWg/nB8AnUQvbl+9LgNQcCODOBB+fgL61OAveIbTH8=;
  b=hTP9P0+Rc2qPIJFvvrRri1LitrG4UZ7Vp2nSl88OiLP0DKQS8V1Cd4s3
   p40Sl5dGVxPoR1LIdrdTgJS5f31Rlv3TdZSQpJaxbohGWjyAIW/8nL2fF
   /MQiFJyWTj0AWMzgdP17NerlVHCfvJ0TRnqa9dc6xYHBudWTI0EWDvj5e
   koyVsvYZc7UmoYko4ffUXD4BcKysDnb6oryPZXesIFIF+BdRMMuv3kzqm
   oTG/vzfQLWc9VkmFGotx3rrXGH/YyHXAH9MviQn9eTjqFpHsfGFvMyZ1y
   8acF39l9eD+eI8FOesf+2rZD3JmqJyJEABHeH+dWW0ypmPiKu1InaawnR
   Q==;
X-CSE-ConnectionGUID: +r94IHxNTtOcr0KmxKYGFQ==
X-CSE-MsgGUID: mDkQerSFQ02Hodh3tcq+YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007916"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007916"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:24 -0700
X-CSE-ConnectionGUID: WZwY2/85SbeenjuPVjA8Jg==
X-CSE-MsgGUID: Miag2Z7hTAqqT/WnyX1mIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941842"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/10] ice: misc cleanups and improvements
Date: Fri, 10 Apr 2026 09:49:11 +0200
Message-ID: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277286-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B4183D3950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ten independent patches for net-next. DCB fix for the 3-bit max-TC
wrap, ethtool link-type coverage gaps, OICR rate bump, and the usual
code quality sweep - log messages, struct layout, helper refactoring.
None touch the data path.

---
Aleksandr Loktionov (7):
  ice: add PORT_AUI and PORT_NONE ethtool port type reporting
  ice: improve Add/Update VSI error messages in ice_vsi_init()
  ice: increase OICR interrupt moderation rate to 20K interrupts/sec
  ice: emit user-visible info message for non-contiguous ETS TC config
  ice: move ice_phy_get_speed_eth56g() from ice_ptp_hw.c to ice_common.c
  ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir
  ice: promote Tx FIFO drain timeout message from dev_dbg to dev_warn

Dave Ertman (1):
  ice: translate FW to SW for max num TCs encoding

Jacob Keller (1):
  ice: reorder ice_flash_info fields to eliminate padding

Paul Greenwalt (1):
  ice: allow setting advertised speed and duplex for all media types

 drivers/net/ethernet/intel/ice/ice_common.c       | 45 +++++
 drivers/net/ethernet/intel/ice/ice_common.h       |  1 +
 drivers/net/ethernet/intel/ice/ice_dcb.c          |  2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c      |  2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c      | 30 ++++--
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 41 ++---
 drivers/net/ethernet/intel/ice/ice_lib.c          |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c         |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c          |  6 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c       | 45 -----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h       | 13 --
 drivers/net/ethernet/intel/ice/ice_type.h         | 15 +-
 11 files changed, 132 insertions(+), 57 deletions(-)

