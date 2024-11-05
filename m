Return-Path: <netdev+bounces-141971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB959BCCC9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D4D1F24034
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01B1D27B3;
	Tue,  5 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRhKdVjr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6861E485
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809948; cv=none; b=McTuVNV0/OQ92g17CsyGo0uQkDZilwnkOBPC4hUoscwQzoigIer+MMP/K6lcZqHJBCq1KSc7RoZTU9WGZgJtq/wvTn+eC3E52JhBvMWTThMsNnWCB9BDQWf7CYuf5OcdzkHQey15cr52f/SPoC1T0asEKixx7rcUQIfIV2rtnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809948; c=relaxed/simple;
	bh=6sCpw5OmNuGWdYB2B2FZ5TKHEdl6SEDWgUwuenv7RrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYDw3wl0duBMMsQlnnIMKVy1j/8cIedORKqfNJAHDbOH2IN/9E/4ePJm4NRdKdsQzPuTq1AwMEJaJ6ghioJm6ItCsvDnJVHfaMDsYNACUU232PFUtX5iUu2vZ2RGRvfY6cMQW1edcnDVY8vWjZc04TwPwf2V/3gWHP8NFNNrSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRhKdVjr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730809946; x=1762345946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6sCpw5OmNuGWdYB2B2FZ5TKHEdl6SEDWgUwuenv7RrU=;
  b=VRhKdVjrL3N/EbEwPMoRk6wvVx8CuNKJM26vT92NtzJQQNuzE7KW50dh
   2SKntUDyFZoGOI5lMScOo6UCPf8vUDYZnv/saAr+osWBA45lxDTXMAYub
   592nQ+0Dy+OfwkK3KAEc5GXPj3dEcNy7sHUQKyNlCC5RDwMrKIv1VYSwk
   qnZyFS86mcohlQ52e4yiKRwF453YY30fVy4LJb9htRjyXAD+4QirryoLD
   w8todjBiPDgsQ0Daj8XIKgz3A+Ce9oSftROTRwYv0l1javO/KUKr0v918
   qYVngMHs+EMitwi6AGE2GD+PRgIVgOt77PjCG2U9L1CYDwFNO66IpcaLb
   Q==;
X-CSE-ConnectionGUID: GyvWd849Qi+95m6NFtnSLw==
X-CSE-MsgGUID: Iv8IVwelQjCbtDpkXXyn1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29976180"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="29976180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 04:32:25 -0800
X-CSE-ConnectionGUID: 8u8Kr9IQREKI+IhM6YUF0w==
X-CSE-MsgGUID: iLf175dvTqS2m39CucwNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="121481216"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2024 04:32:24 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v4 iwl-net 0/4] Fix E825 initialization
Date: Tue,  5 Nov 2024 13:29:12 +0100
Message-Id: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking
the PHY revision only for current PHY and adding proper destination
device when reading port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as
a primary PHY lane number, which is incorrect.

Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  45 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 270 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 9 files changed, 207 insertions(+), 147 deletions(-)

V3 -> V4: Removed not-related clean-up code
V2 -> V3: Removed net-next hunks from "ice: Fix E825 initialization",
          replaced lower/upper_32_bits calls with lower/upper_16_bits
          in "ice: Fix quad registers read on E825",
          improved ice_get_phy_lane_number function in "ice: Add correct
          PHY lane assignment"
V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
          whole "ice: Remove unnecessary offset calculation for PF
          scoped registers" patch and fixed kdoc in "ice: Fix quad
          registers read on E825"

base-commit: 278dfaa171a0061a341f6b5d44c2c9913a2b7fa8
-- 
2.39.3


