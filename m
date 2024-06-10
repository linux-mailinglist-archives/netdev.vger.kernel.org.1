Return-Path: <netdev+bounces-102176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C9901C01
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780631F2169A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B5225CE;
	Mon, 10 Jun 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPWbME3b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00EB22081
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005179; cv=none; b=uVU2qm2Ncq5bhQ1qqBAKL4dtTcL8+aplCe4I6g06xQy77VBx7JvOzGGSMNbMj/bRebDg2g0Ipc7F5Tbmk11Zbe9Adq2+XMdwwdx531JSXhU4MnJOZsRkP8pZAbpkl4ld2HRaGDlr0q+pRuW785fJRUOwScrr4MwVfGsUSDmXboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005179; c=relaxed/simple;
	bh=OI2TMttIgG2il+LvyCg8MUCiIgvkycMDzNq/Drm0yhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lym7VhVrVPipuTlBSSIGkeKUfID+Y8kgMyLmVshwmig11q7xnZrsdOeo27ZEcrc3eUt/NAePL7w5SLGLHiPlQ0UiOuzJag6M+hWKtjzS44bbkRMvfAb9kcjwBddmuVGEAkQjTA3B1jrj97xyrd9OCbeVpJ40XKmEM3U54ZAnkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPWbME3b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718005178; x=1749541178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OI2TMttIgG2il+LvyCg8MUCiIgvkycMDzNq/Drm0yhE=;
  b=TPWbME3b6qNt19U6fFj6Om3dPBjjr2DYB+wVBJSwrXl4iJw3zBRVoxB8
   NjYGsjqfftWckkS4bIDUZ2QdEDC8KO5zAmou6lgY38yRpoKa0UpZFrY/9
   iSAGH5o9XLXobVl9PcWp9h908FrWYXU24PvTOSKY8C2OtGaDK535RYkAf
   JDHoqWIMOyN7o9sBptmYPEbuZcVjJCNfJMPWnwhauwaVXiVhO/KopjQtE
   1hQICOPkcrFVi7n7Udz0pYNyxnoRDKU5QzBVgahEH3V+N4pKCbzswEc5X
   zxvs/ad14/LZnzcCwE3m1bx0eT5oywBwjQgJE+53fEyCihj36gNQ9Xdwd
   A==;
X-CSE-ConnectionGUID: bvQSvZJCTCK/s5dMJIfoYA==
X-CSE-MsgGUID: XUxJ/ztuSBmgTeEkJH/B9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14448558"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14448558"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 00:39:37 -0700
X-CSE-ConnectionGUID: TDKla3zfQPubMd8LHryheA==
X-CSE-MsgGUID: XYNGAgmCTI2Zf6kixd1vLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="70151231"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 10 Jun 2024 00:39:34 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kuba@kernel.org
Subject: [iwl-next v3 0/4] ice: prepare representor for SF support
Date: Mon, 10 Jun 2024 09:44:30 +0200
Message-ID: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a series to prepare port representor for supporting also
subfunctions. We need correct devlink locking and the possibility to
update parent VSI after port representor is created.

Refactor how devlink lock is taken to suite the subfunction use case.

VSI configuration needs to be done after port representor is created.
Port representor needs only allocated VSI. It doesn't need to be
configured before.

VSI needs to be reconfigured when update function is called.

The code for this patchset was split from (too big) patchset [1].

v2 --> v3 [3]:
 * delete ice_repr_get_by_vsi() from header
 * rephrase commit message in moving devlink locking

v1 --> v2 [2]:
 * add returns for kdoc in ice_eswitch_cfg_vsi

[1] https://lore.kernel.org/netdev/20240213072724.77275-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240419171336.11617-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240506084653.532111-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (4):
  ice: store representor ID in bridge port
  ice: move devlink locking outside the port creation
  ice: move VSI configuration outside repr setup
  ice: update representor when VSI is ready

 .../net/ethernet/intel/ice/devlink/devlink.c  |  2 -
 .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 85 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 14 ++-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_repr.c     | 16 ++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
 9 files changed, 90 insertions(+), 39 deletions(-)

-- 
2.42.0


