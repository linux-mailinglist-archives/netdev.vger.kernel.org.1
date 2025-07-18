Return-Path: <netdev+bounces-208219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CDB0AA5E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EF15A4149
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD342E764B;
	Fri, 18 Jul 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAxcl/yL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479682E7178
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864686; cv=none; b=vBlZq7N58Abbay3CR0rWqOpVMaSUjPuSQeZIi8yql3V2DN5svKvTA7l+nWawHWzqkBa+yS/Rk5PHcdXBD3T2hKFCaREW0hW63PCSBKMXCeCUUvg6QI5nh+mZ+4b3iGmcuDqPJGLI+37bpuNFP/uvJAxnhSRY8G7lPR7kPh17muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864686; c=relaxed/simple;
	bh=NQ8DYPnMernIZCNA+Wkzxc/FewqGKtzx0DmvrW8w+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhj/U3JkM7dLyHdEvgC7fL2E3jmlDnns+JuRTPukAP5K/105xeVkUTaEp6VxAidqyuHekuxo5DrSVvtj26H0vpRps0GXkX79a8SWuQWi0dZMH9OCx+w/RlQ3XgGyW0lDAD/BtFdgRZ6umRQR3qOXL7qKCDWoGmVzJNp9i0xE6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAxcl/yL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864684; x=1784400684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQ8DYPnMernIZCNA+Wkzxc/FewqGKtzx0DmvrW8w+MM=;
  b=DAxcl/yLNXOnPl6bXxuc4jmGiDij5LA2JozKWd8r5mXmH5i7Kgm2dYlk
   zecQ/ko6LabGU+kXjAPgsIjZIix2Sb542Kbhl6c/YZwT4LO7UWD6KiRNU
   hGAfhcUXefc4xT+NUptxT+ysrlWIua6MbJiEVTq9DYs5BRtdCI2m2ASzm
   sO7cyQkMId5CH+Ao9vFqBLnA9F/ArfcN9lfb2/8gFHM/uhYg1SSgOJB3H
   7Se/44yTIqQW4G3jcyses/bT3lAAkjUjt+EooIooRtm8lqqMtFa44fNig
   hst3iGzs2B3joGUdOGiUNQYeNuMUw3GdwPQoLUxRxL2RVHxW18qtYwvmZ
   g==;
X-CSE-ConnectionGUID: yBRTdgmZS3+REH657pEHKQ==
X-CSE-MsgGUID: IM7p4zMIQ+uElPrqWwEDmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320546"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320546"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:23 -0700
X-CSE-ConnectionGUID: P2LkGMPMRg2urW4xoMb+kw==
X-CSE-MsgGUID: 1JC/qKRcR/en8kgGhuv5LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506873"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver Updates 2025-07-18 (idpf, ice, igc, igbvf, ixgbevf)
Date: Fri, 18 Jul 2025 11:51:01 -0700
Message-ID: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For idpf:
Ahmed and Sudheer add support for flow steering via ntuple filters.
Current support is for IPv4 and TCP/UDP only.

Milena adds support for cross timestamping.

Ahmed preserves coalesce settings across resets.

For ice:
Alex adds reporting of 40GbE speed in devlink port split.

Dawid adds support for E835 devices.

Jesse refactors profile ptype processing for cleaner, more readable,
code.

Dave adds a couple of helper functions for LAG to reduce code
duplication.

For igc:
Siang adds support to configure "Default Queue" during runtime using
ethtool's Network Flow Classification (NFC) wildcard rule approach.

For igbvf:
Yuto Ohnuki removes unused fields from igbvf_adapter.

For ixgbevf:
Yuto Ohnuki removes unused fields from ixgbevf_adapter.

The following are changes since commit d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9:
  et131x: Add missing check after DMA map
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Ahmed Zaki (3):
  virtchnl2: rename enum virtchnl2_cap_rss
  idpf: add flow steering support
  idpf: preserve coalescing settings across resets

Aleksandr Loktionov (1):
  ice: add 40G speed to Admin Command GET PORT OPTION

Dave Ertman (1):
  ice: breakout common LAG code into helpers

Dawid Osuchowski (1):
  ice: add E835 device IDs

Jesse Brandeburg (1):
  ice: convert ice_add_prof() to bitmap

Milena Olech (1):
  idpf: add cross timestamping

Song Yoong Siang (2):
  igc: Relocate RSS field definitions to igc_defines.h
  igc: Add wildcard rule support to ethtool NFC using Default Queue

Sudheer Mogilappagari (1):
  virtchnl2: add flow steering support

Yuto Ohnuki (2):
  igbvf: remove unused fields from struct igbvf_adapter
  ixgbevf: remove unused fields from struct ixgbevf_adapter

 drivers/net/ethernet/intel/ice/devlink/port.c |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |  18 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   3 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  78 ++--
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  42 +++
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  19 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  23 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |  52 ++-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 334 +++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  23 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 136 +++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  17 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  13 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 124 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   6 +
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  55 ++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 243 +++++++++++--
 drivers/net/ethernet/intel/igbvf/igbvf.h      |  25 --
 drivers/net/ethernet/intel/igbvf/netdev.c     |   7 -
 drivers/net/ethernet/intel/igc/igc.h          |  15 +-
 drivers/net/ethernet/intel/igc/igc_defines.h  |   4 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  18 +
 drivers/net/ethernet/intel/igc/igc_main.c     |  22 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   3 -
 31 files changed, 1122 insertions(+), 195 deletions(-)

-- 
2.47.1


