Return-Path: <netdev+bounces-212752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A3B21C36
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31A81A209AF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACF2D47F3;
	Tue, 12 Aug 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyTLJtb8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6F1AF0AF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974014; cv=none; b=XWEi1gog8ecnD31sqQg9ZoWjUmBYZFgfnzKP8nQ1o/CviwqF1NG7QhJAOwtxYWa3wVO+7UDZEAibsYw122C9VyrD7TToCyx1T1np8uL5XjQ4us0dkZwYfHKqyPQPT/PWWwF3Lej0ET3VzY9JVLj2a637J7EAinzExW5Y60bBHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974014; c=relaxed/simple;
	bh=B8ZQ+c6Xz2QVuq7k1UdVtgB4vbdN/oyyIKz6dW1BFBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss4wKBiYPnsoyVVbWfGEoCHo5CgkNVqSL+k+LakTPmETmXmkAaJkF3IPUCG1CmgV4tarc7pDSmPyHiZono9kk2rkNK6Er7zH31l4p3YCJiB6hoBfQk0aBXa5PFj34ZWiTtemgNxJY53TZ7lJ77r8jw5Xqum6yNrZK5aNeMtE9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyTLJtb8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974013; x=1786510013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B8ZQ+c6Xz2QVuq7k1UdVtgB4vbdN/oyyIKz6dW1BFBw=;
  b=QyTLJtb8+hhPJTqrckx/LRdlU+sxzz1tt9lQl0yZh/aamXP7Rq6AxzXQ
   A1CEv15FGBmyZnvo6Y68vnELzlYaNQGuYiENWGptv7vR3uAQlJJPJVYaK
   oFd8Wttgvlnishk2v7FfvpOciL6j51C6JFoULaX+LevknPGavmb9PQI2S
   jSm2r4ii26/JsveeTD9AeYyrRDpiiPeiXr/Hs7G+AQmRwk0SVwtq8a462
   IXXmOyyeuhNkPOOR05Rip0+lFMT1Lvq4j9+txzO+O841DzzcNr+uXJz48
   bkDcjexc0L4FV9VDmOV+X4qFlwm6QThAd2WqBWOWSXDRenD8RZududwdC
   g==;
X-CSE-ConnectionGUID: 39T+tnneTMKxpkquU+4SKQ==
X-CSE-MsgGUID: 10mIlomnREe5BIZY9YthEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612719"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612719"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:46:52 -0700
X-CSE-ConnectionGUID: 0RxjY4VsRZiA8ZGguK8XdQ==
X-CSE-MsgGUID: +lYVi0w4R4mGY3gJ+WtzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327864"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:46:51 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 00/15] Fwlog support in ixgbe
Date: Tue, 12 Aug 2025 06:23:21 +0200
Message-ID: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Firmware logging is a feature that allow user to dump firmware log using
debugfs interface. It is supported on device that can handle specific
firmware ops. It is true for ice and ixgbe driver.

Prepare code from ice driver to be moved to the library code and reuse
it in ixgbe driver.

v1 --> v2: [1]
 * fix building issue in patch 9

[1] https://lore.kernel.org/netdev/20250722104600.10141-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (15):
  ice: make fwlog functions static
  ice: move get_fwlog_data() to fwlog file
  ice: drop ice_pf_fwlog_update_module()
  ice: introduce ice_fwlog structure
  ice: add pdev into fwlog structure and use it for logging
  ice: allow calling custom send function in fwlog
  ice: move out debugfs init from fwlog
  ice: check for PF number outside the fwlog code
  ice: drop driver specific structure from fwlog code
  libie, ice: move fwlog admin queue to libie
  ice: move debugfs code to fwlog
  ice: prepare for moving file to libie
  ice: reregister fwlog after driver reinit
  ice, libie: move fwlog code to libie
  ixgbe: fwlog support for e610

 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ice/Makefile       |    1 -
 drivers/net/ethernet/intel/ice/ice.h          |    6 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   78 --
 drivers/net/ethernet/intel/ice/ice_common.c   |   46 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |  633 +---------
 drivers/net/ethernet/intel/ice/ice_fwlog.c    |  474 -------
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |   79 --
 drivers/net/ethernet/intel/ice/ice_main.c     |   43 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   32 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 +
 drivers/net/ethernet/intel/libie/Kconfig      |    9 +
 drivers/net/ethernet/intel/libie/Makefile     |    4 +
 drivers/net/ethernet/intel/libie/fwlog.c      | 1116 +++++++++++++++++
 include/linux/net/intel/libie/adminq.h        |   90 ++
 include/linux/net/intel/libie/fwlog.h         |   85 ++
 19 files changed, 1406 insertions(+), 1312 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
 create mode 100644 drivers/net/ethernet/intel/libie/fwlog.c
 create mode 100644 include/linux/net/intel/libie/fwlog.h

-- 
2.49.0


