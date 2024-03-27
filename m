Return-Path: <netdev+bounces-82578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7588E975
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24B71F32013
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673073717F;
	Wed, 27 Mar 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJOPltoc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526D1DFF5
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553923; cv=none; b=HBkKB4wQwI/Uc/Cbilwj2/wbQB6AlKoOVesbZv8LkwaMGSELbbrA6eoWPPt8mYz3njIDUdYePopRLKV/Fw9jhHlygWwlCULVxdJEFhD5XV0riTVX/c1VVUOTxR/gUJQ1AMg+MIF34DCVjYekxp8Kh/iUia8n5ByQYI57TpotKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553923; c=relaxed/simple;
	bh=ktB/xB3Lp0DrTvfAFS5vXhhDauIgHWF4C+6HuvQJMJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fkjM5iJkcq1xcdrfMC8KG3ReaS4hghdf+UHLr12mIEx70ygQ/MZXhjlKhkhRT0B9AZrWU+727wMlS7Tfd8NFDXceTm+d8tmsKeEKmOwGGW1mmJCELH4i4ldSKaItBj2InMy3UYBnxEEnP89ZrLdahkvbBl2LLkUwFUQ8gC7nB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJOPltoc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553922; x=1743089922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktB/xB3Lp0DrTvfAFS5vXhhDauIgHWF4C+6HuvQJMJA=;
  b=iJOPltoc5yzA72OCDpDxFjqFYZCf/dnrAfT+45D9yMb57XN4Lj/SUKRb
   mpEwH4MbrYfPFeIiEpvfuObqTXfa2GnFRFj6S7+Tv0+Pi3/zJj/ObaS5R
   w/CTPEix+kzp5hO1+ZmBxdHROJ3mMCIAbDLQJWu5Z8CRsIau174euUn3r
   89F+NzdIUD7BFJqRira3fEHOVHG0/0a9wRScWHs86NFYz+AVGrjDJVmpg
   2+CjD3ePvufKVTqEMkKs/Nu8KxtouHFnXPaZVeZ8UtUcOXoMcMP/8Xqnn
   6gBFX1LguESfRt9OuSgyfXwhexTWvUD0UL3fRzHuw5+PeR8CYPAsVJH0E
   w==;
X-CSE-ConnectionGUID: 7cSsNTfqRnyC9YOPaJxUfw==
X-CSE-MsgGUID: apPanttZSoyh1Nc/wpoYGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6531099"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6531099"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20807787"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa005.fm.intel.com with ESMTP; 27 Mar 2024 08:38:26 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v1 0/5] ixgbe: Add support for Intel(R) E610 device
Date: Wed, 27 Mar 2024 16:54:17 +0100
Message-Id: <20240327155422.25424-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

This patch series adds low level support for the following features and
enables link management.

Piotr Kwapulinski (5):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   15 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2590 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  437 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   28 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4331 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
2.31.1


