Return-Path: <netdev+bounces-87146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02B8A1DFE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578A628E791
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425181ABF;
	Thu, 11 Apr 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR15MvP2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264102E410
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857138; cv=none; b=TcZ1zrfyO8VokqxQYcYu8IOV0onWEb+xkhI9YQlW3lUK1jEW1CYUje9cecYiJdUoumtDSKP6USpIsO2tcMrwhgkNPlRwJ2BxQE71zLKLYcKXBiDG+PlgZrHrIZaOxIbu2shIxkc2AfO2Gre9akOEgcVr2fo/GGdlsSGum1BMEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857138; c=relaxed/simple;
	bh=CJI8PBQx+zb04Uak9jlf+aCrSoLuPkQ+UnfcqTDjfIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUaj4B6V+UDDlZ35IO3Hk25axr3KHTWF19c9hA4lRYnSFMIrhMr7X//8CuuvDsxs1b1GismxCro8MwIaWidDuc4yV9IUTxRWUZ8U/4SpiD7ueHGOJDjCNKXw6A7p1A2aQ0tApJ3SOnknlElwPkhtnXKJx59pka+p4opld51KWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR15MvP2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857137; x=1744393137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJI8PBQx+zb04Uak9jlf+aCrSoLuPkQ+UnfcqTDjfIU=;
  b=WR15MvP2OxxzIxMXxHEyEBVa2Us7EAHTRn1EdDPnGF1mmIZuzapyHWuC
   XTHtZS5BPAFJpsO8/26DdM89PQdDpNW274+GfZNBXn11GYJB4SqcKtvz+
   e7z56vOPBiqXJM6ZOgPoqc1Reo2H0ESTnDmTFnzZPphF3mxwizrPoUaMO
   juxXyItixCFegdybZjIigMERDpM75D7SJ5lthft6OuDb16AhRVyBb3It9
   15Q9+wHxFfW+W4XbyPBFIi66oHB20tHacvlpoGikYDwR9nWcAbATKNA5A
   k7kFkKQ0Bt6q9uqjlVZVRb3+kaJODRPcW+wY9j9nN5E8LkKLApbofWypY
   g==;
X-CSE-ConnectionGUID: KKGwkPypTriDTxCbKB4h8Q==
X-CSE-MsgGUID: cxXxtAlJTK69nV3Aqqon4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11252944"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11252944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:38:57 -0700
X-CSE-ConnectionGUID: vWxG9isKTZWiaRX0GCJRkg==
X-CSE-MsgGUID: IKKZ1fBEQhaZK6VDpCMdXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20949089"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Apr 2024 10:38:56 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2024-04-11 (ice)
Date: Thu, 11 Apr 2024 10:38:40 -0700
Message-ID: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
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

The following are changes since commit 0e36c21d7640ddbfa9233c692db905e0848c6f44:
  Merge branch mana-ib-flex of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
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
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 138 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 111 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h    |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  14 +-
 10 files changed, 229 insertions(+), 68 deletions(-)

-- 
2.41.0


