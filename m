Return-Path: <netdev+bounces-87540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA348A3783
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D25B211E8
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCEA40BE5;
	Fri, 12 Apr 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtxtobaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C317C7F
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955944; cv=none; b=V3bMLMLWJegP5R4ZT4MgC+UDSGuRYnBmAsz/OfiIAg5W00pMrJFegAhgQoR7u8xyOVDaYCGtNWtT39c6L1ds/NC1olTPkxC6CySS6J+JrkM5MAGfTvyECwktSq+KwvCnrP+DI4f9Z+41Wl76ukHR6fXBmNrzUJjWUo6uGLtUVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955944; c=relaxed/simple;
	bh=Ck9ue2NFetrPEinPDkvtertZcx5rV0zt0WImRpUpCNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUlolMka1qugudiC69bzFAtdZCCYq/Qr+S+1BC+GT/b1cIqgB+0n7NXU05+KIpJw63EtlgFNjPU+DcYftawi2KoGBAijtfMWxJ0/ylqxL/unUqX6jPs9n/wEWRrQKvYXMUe4BKe/djOlerOYROq+GHqayRluO0C+LZiAq3zk8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtxtobaJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712955942; x=1744491942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ck9ue2NFetrPEinPDkvtertZcx5rV0zt0WImRpUpCNw=;
  b=CtxtobaJ/BUQzD35sJkXsLfUXMP7sMxZVEPWM6yKObAV6ghx/au5Mh1I
   eRDov8SMfT9XPaSJ5T4eBf6scmQtNukYTy2ZeL+kdnsAVg8+c1pMpfjd4
   cFug9WxgDHAYATb9UNqHfi+COB7SDQGZowhcfXYvYWMFKXeXKxZEYDl4N
   APzpCAtFwBxDyVpa9GGvITvvRTMwKfICMOZl6C2XC0/nXjyRCWHiKWc2b
   wJ69dmI5P846rz6pBKjX6tI8wBqskyv1aIbQLKC6FQQEs9MI0DrXu7mgO
   a9ve40Y7MBmTYrsSu5cDynwofidk9nS/OGWO2r/LBTaQrY+DsDni9Whjw
   A==;
X-CSE-ConnectionGUID: KkbvBe9NQQWIxzzFWCs+LQ==
X-CSE-MsgGUID: kFuwARrqQZGPxHKkCSY5zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575211"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575211"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:05:41 -0700
X-CSE-ConnectionGUID: 4QLaKZurSSuDbq8cptHlXw==
X-CSE-MsgGUID: Z/O/pzh/T6ir2bnUOOzIEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21836880"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 12 Apr 2024 14:05:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver Updates 2024-04-11 (ice)
Date: Fri, 12 Apr 2024 14:05:29 -0700
Message-ID: <20240412210534.916756-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Lukasz removes unnecessary argument from ice_fdir_comp_rules().

Jakub adds support for ethtool 'ether' flow-type rules.

Jake moves setting of VF MSI-X value to initialization function and adds
tracking of VF relative MSI-X index.
---
v2:
- Add kdoc short description to ice_set_ether_flow_seg(); short
description and return value description to ice_set_fdir_vlan_seg().

v1: https://lore.kernel.org/netdev/20240411173846.157007-1-anthony.l.nguyen@intel.com/

The following are changes since commit 982a73c7c594d553a688353c6ae43560542c4cd2:
  Merge branch 'nfp-minor-improvements'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (2):
  ice: set vf->num_msix in ice_initialize_vf_entry()
  ice: store VF relative MSI-X index in q_vector->vf_reg_idx

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 140 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 111 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  14 +-
 10 files changed, 231 insertions(+), 68 deletions(-)

-- 
2.41.0


