Return-Path: <netdev+bounces-82777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3788FB9B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B0C1F23C29
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169B36AF2;
	Thu, 28 Mar 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpqnDafi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE518E1E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618453; cv=none; b=qcrWNseIk1fyvI3+uYpw3KKiY4bRzYQNYcQxFOrpIYBUnBX7M135FmT3AtW9QmLoeZqfc3Chv8478pC7PmH4l6NZNPMaRGyIW7vt2CaRTlk/T2zOhcwC2Mzh8Z/nPsr5gLq6Jm7Um+2MO2PaPdOrNfpyOYTSFCV6fgsZpuFyApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618453; c=relaxed/simple;
	bh=RTgyQhh5hfPvHOZxi4F5KEWwjYtUZKgGi+s8RkLBcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPFjCKmoBHlCAwJRYQ7St/GOD5WMEPy+8ryPZdpNoS60TVRFv+gC3l2WZc/vpgHDBcOtd/nM78ifdAXOw3aVoY6o1+ih6HkLtrjJEdVSi9kipJgx0UhbMw/hef9Cfxb6Y2FYO11774luwco+JPPLkEztsNVB6+jpTyjtvMBDBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpqnDafi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711618451; x=1743154451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RTgyQhh5hfPvHOZxi4F5KEWwjYtUZKgGi+s8RkLBcn4=;
  b=bpqnDafiNpISnb73pNDqP88iPZzBr2QitufOm7NHBrQXdlbScvazQnPo
   +VgebwIDsHxp2MAKk+YKE2uzjTOVw9znmFP8SZ4hIZ8PRxNL2IiURdMkX
   TQFVz1w870cjGntIhomb09FzdIvuKbThAE0C/jLEbrsEHUf1ur+rfATBj
   MggvkDzqb948IUjcLhgDqNsdB+MWmPWC9Vyc+KgNz5LWxk+CLBexA9fth
   xqIGOFnMmAYwCrbTO6MAyvg5ABrG6EHnQt4XH/jrlp1FDSdWIge/qAvuP
   wCoEXCbcCHXjqQWeAKxUOab+pwe2jiyvJHCC980xvS5KYtMrINJKME9Cq
   g==;
X-CSE-ConnectionGUID: NSF0iHn1Qg2UkHYOkR3zUg==
X-CSE-MsgGUID: vsL0CMXJSraXxGu/nhLZTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6952634"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6952634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 02:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21276268"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 28 Mar 2024 02:34:09 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Thu, 28 Mar 2024 10:25:18 +0100
Message-ID: <20240328093405.336378-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825C products have a different PHY model than E822, E823 and E810 products.
This PHY is ETH56G and its support is necessary to have functional PTP stack
for E825C products.

Grzegorz Nitka (2):
  ice: Add NAC Topology device capability parser
  ice: Adjust PTP init for 2x50G E825C devices

Jacob Keller (2):
  ice: Introduce helper to get tmr_cmd_reg values
  ice: Introduce ice_get_base_incval() helper

Karol Kolacinski (4):
  ice: Introduce ice_ptp_hw struct
  ice: Add PHY OFFSET_READY register clearing
  ice: Change CGU regs struct to anonymous
  ice: Support 2XNAC configuration using auxbus

Michal Michalik (1):
  ice: Add support for E825-C TS PLL handling

Sergey Temerkhanov (3):
  ice: Implement Tx interrupt enablement functions
  ice: Move CGU block
  ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice.h          |   23 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  263 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3656 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  284 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3907 insertions(+), 934 deletions(-)


base-commit: a81f6acc75e74f8b5502e4fa7ede177623de2035
-- 
2.43.0


