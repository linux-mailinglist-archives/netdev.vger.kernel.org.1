Return-Path: <netdev+bounces-83784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F09894447
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4661F22F0C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA34C61B;
	Mon,  1 Apr 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixFD8Mn+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A44AEF0
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992269; cv=none; b=PjWl/R/BxaACOSO5F1BumvotgZDHSlR3WXIRIDQg3jefID++iQCZ2NbdzgJBKOQ7e7ILOc4AXvwfCQ1opls/ZwhKvJEDf94AoYO3gPTnPpS+90HZjbb3hSYRFpQ5KHRhjEPJULtp/d9Cx9gA53dW/PHfVKT4bq9ga+QA8r0zJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992269; c=relaxed/simple;
	bh=m0cubPE+66/HNVb0tCXaJV2I1wHNyVVF0MufGRQXBG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDrGXHpd4qJl+9qet0mUBKzVWRh3vC8zmWEjjnrPSi7seexbBhWVBKZseNO1RRzwXr7eNoO0/8fDsGPB9g5pydkPzQ1/KW+WLlmxGBrbmVcfFp5a1yWe5gORDl/RBW9hneKXTiAy61UIAR3dkYpqfEIzVnZyJU3jowN/5LJB73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixFD8Mn+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992268; x=1743528268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0cubPE+66/HNVb0tCXaJV2I1wHNyVVF0MufGRQXBG4=;
  b=ixFD8Mn+eRdlZb2GzL7zHWmzdTZed/oGUMEnRq0xU9tLuGh7mqr4ozFh
   4llYEddlouTsFOWFYebC/Q5prQTrFCPbNT8wpFyzRfJXT0pdKVCV9fjJZ
   omrvzqYk3ePIQhkg+OD3LZI5M3R5SBZJniaMY38ntluirwFpwvIH1rKOe
   +JkLnrpd3l4ifB+yzrQ0n+2l/bKYWBq8VrAN+52+D/lN2VT0NtURfzcA6
   VhR3YxbJhYX82pggp/Ttw1TfCGNcIhv56+M6rQiQALeSZ5FLvaLtXFrEM
   v60eFv4cAxgVlOFFWi8fZq0Li+kVh202O9r36VefElmA/4VnAHJI8pkBt
   g==;
X-CSE-ConnectionGUID: iaQNDm1nS9ywg+2wLhwhsw==
X-CSE-MsgGUID: l9hOtuYMSo60chL6oThRTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606137"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235076"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates 2024-04-01 (ice)
Date: Mon,  1 Apr 2024 10:24:10 -0700
Message-ID: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Michal Schmidt changes flow for gettimex64 to use host-side spinlock
rather than hardware semaphore for lighter-weight locking.

Steven adds ability for switch recipes to be re-used when firmware
supports it.

Thorsten Blum removes unwanted newlines in netlink messaging.

Michal Swiatkowski and Piotr re-organize devlink related code; renaming,
moving, and consolidating it to a single location. Michal also
simplifies the devlink init and cleanup path to occur under a single
lock call.

The following are changes since commit 3b4cf29bdab08328dfab5bb7b41a62937ea5b379:
  Merge branch 'net-rps-misc'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Schmidt (3):
  ice: add ice_adapter for shared data across PFs on the same NIC
  ice: avoid the PTP hardware semaphore in gettimex64 path
  ice: fold ice_ptp_read_time into ice_ptp_gettimex64

Michal Swiatkowski (2):
  ice: move ice_devlink.[ch] to devlink folder
  ice: hold devlink lock for whole init/cleanup

Piotr Raczynski (1):
  ice: move devlink port code to a separate file

Steven Zou (1):
  ice: Add switch recipe reusing feature

Thorsten Blum (1):
  ice: Remove newlines in NL_SET_ERR_MSG_MOD

 drivers/net/ethernet/intel/ice/Makefile       |   7 +-
 .../ice/{ice_devlink.c => devlink/devlink.c}  | 463 +-----------------
 .../ice/{ice_devlink.h => devlink/devlink.h}  |   0
 .../ethernet/intel/ice/devlink/devlink_port.c | 430 ++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  12 +
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 116 +++++
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  28 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  33 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   3 +
 drivers/net/ethernet/intel/ice/ice_repr.c     |   3 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 187 ++++++-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 20 files changed, 814 insertions(+), 500 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c} (77%)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_port.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h

-- 
2.41.0


