Return-Path: <netdev+bounces-166918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82536A37DD9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5BC1884782
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD51A23AC;
	Mon, 17 Feb 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvDNNbTK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B93383
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783203; cv=none; b=PyDHlZf3tPLEbfWSDfN9aACDUnd0qKJpEk94o06cykoFOobScjguNapo+PF89wXwnii15L74GbEegPKL3uRkLbmZUtCn23Ee9EipldgOQJbvTac43ffuo3Ry+xDYRZSdPMjqVQxn9LwQDpnQ1ucdTUT5LREJg0OLpdQNOK4fTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783203; c=relaxed/simple;
	bh=DUDpm184CnAqvw0VolVN5A57W+QNXKcQy8FrVRJLn7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+R6up5Y/Qg0y5/UXFy77K6fcMI87gngTal6qp+8V+VdfNhUqIHupCNA2pPINph3NvP7XLHw7HxrHtA3wW+jmGK+1o9Dp2mmX/tK9V1Uz48nrmeHEviONtwYc+neJIML59JoFpKJV9BL4lI5IGhEGNQ6DoB/ov3ngVH9i57XzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvDNNbTK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739783201; x=1771319201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUDpm184CnAqvw0VolVN5A57W+QNXKcQy8FrVRJLn7o=;
  b=dvDNNbTKakdeEBnG9m8yHI/2tdGQe5z7IkiSNL8wLqXbT0lCiiR2AfE1
   Rhmzcmp7zwFrBndvfCSewTk6KMlpSckG3EFF6tUTiwyd/ezl5VDhYRWlx
   LCCqzmYpAg4LakgBfVTa/qDdFDjkLDF80+VvIQTViGad5W2WVPLQFG+Vh
   65fs+XQhP7nHECtqXV1hC2xe89Ms+HsP/E0E1gqhq4SgSXIdc+cEHqU01
   BwON3n+bMVFTFjIHDLxVvMXZdNWnVxvd6mlkE/3XMtOUQ1aMWkw6tHO2e
   fSjXIx6dNuNiULJpjlESVVK0uz/hoIN8PHcx8bwUdREea78YrR7llA2vL
   w==;
X-CSE-ConnectionGUID: Zhn1+EgHQQOQLn+yYDBjfg==
X-CSE-MsgGUID: WvTicbnITAO1d2CiolT7oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51078476"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51078476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:06:39 -0800
X-CSE-ConnectionGUID: 61nso0TORY2JvT1zZXh1Xg==
X-CSE-MsgGUID: R07LcAZERIWE3inunRVCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113937576"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 17 Feb 2025 01:06:37 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de
Subject: [iwl-next v3 0/4] ixgbe: support Malicious Driver Detection (MDD)
Date: Mon, 17 Feb 2025 10:06:32 +0100
Message-ID: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset is adding support for MDD (malicious driver detection) for
ixgbe driver. It can catch the error on VF side and reset malicious VF.

An MDD event can be triggered for example by sending from VF a TSO packet
with segment number set to 0.

Add checking for Tx hang in case of MDD is unhandled. It will prevent VF
from staying in Tx hang state.

v2 --> v3: [2]
 * improve patch 1 commit message based on Paul comment

v1 --> v2: [1]
(All from Simon review, thanks)
 * change wqbr variable type in patch 1 to fix -Warray-bounds build
 * fix indend to be done by space to follow existing style (patch 3)
 * move e_warn() to be in one line because it fit (patch 3)

[2] https://lore.kernel.org/netdev/20250212075724.3352715-1-michal.swiatkowski@linux.intel.com/
[1] https://lore.kernel.org/netdev/20250207104343.2791001-1-michal.swiatkowski@linux.intel.com/

Don Skidmore (1):
  ixgbe: check for MDD events

Paul Greenwalt (1):
  ixgbe: add MDD support

Radoslaw Tyl (1):
  ixgbe: turn off MDD while modifying SRRCTL

Slawomir Mrozowicz (1):
  ixgbe: add Tx hang detection unhandled MDD

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  42 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 223 ++++++++++++++++--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  50 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 120 ++++++++++
 9 files changed, 430 insertions(+), 23 deletions(-)

-- 
2.42.0


