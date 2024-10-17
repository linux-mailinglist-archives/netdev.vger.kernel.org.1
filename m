Return-Path: <netdev+bounces-136583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DE9A2369
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730FB28A794
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222551DE2B5;
	Thu, 17 Oct 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzIu5e0t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9951DE2A4
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170950; cv=none; b=opsQ1KxcML3E4dutZv6/Rt68jdv9B63PLmNIsDhIaLJzTRXcWtERKvJuT1WsFuLtofmxLmz9v82wKFf6Bbt3fLsHdBrqpI9FfWmPUzkFKkp0LStwODjebyGxzzlWCiPCstrYP1xO862PxJN4YvqY8qXne+Xwrflr4RvZqExlNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170950; c=relaxed/simple;
	bh=YB7+HFcGK8k46+CVdTngS7vscQZUut1NpWXvPpsWZ78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtP4xq4Hi0xBxm3lmjV7u+VyVMb0+nqLusfs+zIfxpe1vPjv0KChU7rJRGehgy+KoBgAWVhzWBs1qkyGzdjJfG2h01QiCenX2lyxEiWoA70ovAwwLbxLlr2jf8k1IG8rX/JupPUkX7YfCj+S8xpPtGRlgTA5g+i5QGR2r+YVxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzIu5e0t; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729170947; x=1760706947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YB7+HFcGK8k46+CVdTngS7vscQZUut1NpWXvPpsWZ78=;
  b=XzIu5e0tG4fKhaOqCbg4+dfCY2Dk2Uex1IHMa5AqW0qsnNEetMBzpYY4
   /d3IYXVaTGpqEqySolBu2Z5iSBxIDpVL/8a1PZuZjS39pRHk+74Cqkf3D
   jii6Xm3n5zPiaFxmBqYYZaiwMznRry6KgLSv7qTGJgXHqGrw58eQ+rczl
   idzuX6WWTmiHFrYWizuLaZhpKoCQUzPaJLI0LVvrnqfHQ7uAX+V8UiKz5
   Ns9UOOUBd3qTt63wLViiUsHcz1spQt0ROYV8J4XfNXEGz1yOQECSJgY5X
   AF6DZ0U7UECnzsUsOilVP1yjjjOqhjW9CrQmkQ8QKtNYHxr0Gom9R6rpq
   w==;
X-CSE-ConnectionGUID: DbXhmWH9TMi7d404hVqQGw==
X-CSE-MsgGUID: 5DM+WQmMT8O2EeD3qoRbIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54068259"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="54068259"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:15:47 -0700
X-CSE-ConnectionGUID: E+ShnjFfRFa3pz7umIcTTg==
X-CSE-MsgGUID: eR21KDJ6RBqsuvaZNmoHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="82505226"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 06:15:45 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next 0/2] ixgbevf: Add support for Intel(R) E610 device
Date: Thu, 17 Oct 2024 15:15:01 +0200
Message-ID: <20241017131501.4229-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel(R) E610 Series of network devices. The E610 is
based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

Piotr Kwapulinski (2):
  PCI: Add PCI_VDEVICE_SUB helper macro
  ixgbevf: Add support for Intel(R) E610 device

 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 include/linux/pci.h                               | 14 ++++++++++++++
 6 files changed, 47 insertions(+), 6 deletions(-)

-- 
  E610 ixgbe support:
  https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=426452

2.43.0


