Return-Path: <netdev+bounces-100768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7358FBE92
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E81A1F233CE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75051143872;
	Tue,  4 Jun 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtTGDmwX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC901428E7;
	Tue,  4 Jun 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539216; cv=none; b=JWOwQbVVmUuIb02trYDLluID4p7fgjG/3QZ4Qx9Kde07diJHfb7sgVbHbXK4Aq1oNUCso6V3PQzCfoQZv9ByRgjNMwWalVTnRqj611ZmiXAlmwgow1O4w0IXt6qFEUHZtREDYP911OhIQl6CnNabYgxrg6wMkFd9u/Yq4aJkeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539216; c=relaxed/simple;
	bh=llZfe2oGQU8w8nwBOAhiV/pkSNZCGmsZAAeCESgAvu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0HOqtZGZ0dhhgWpX9iCReR+N2oNqLcoxumTmGbwDdS8OMzu2SoF6BNPztp0Eq9BLUkR4KGp9H1gtl+0LzMmGSwqax+UEIzinfQ3s+JQu6u3lyb/dOBYx/Gcca+fzlc1fbjFsVKBlL5D1w8kZacUXeXFO3OmEdS724DBFbUhKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtTGDmwX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717539215; x=1749075215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=llZfe2oGQU8w8nwBOAhiV/pkSNZCGmsZAAeCESgAvu8=;
  b=YtTGDmwXdF9/IMlKfTlSqLOzJm91Yes12Nwzeg7viQNzE9Rkbx02x8M3
   nZ4DZFRgazjAGy0UBAAgQ630pH6IrHpe5rVI1Zldx9JuOgmNkmyRkHP8D
   4xZPIb6HlVk6fp7DOEvJIbt3bdJCxo/vV90PyfgWbFZbn7NfShAh2LvdN
   W5xqJi83p1joq3/DrQYp8fNOT4AXQem0gE6ZrZkg2bbZaX1O7ZpFO33fp
   vS9D7uQugysQxsCoHIOA8o/KSfl42ncKKkQvBUkI4DodbgmvtEt3Hvd7u
   uwiWd27pMiRaaa4wrh36NUicRsOx+zHVnrghPXNUiIMAzrnlImig3PPKJ
   A==;
X-CSE-ConnectionGUID: otRCgjG/STyxVx3gpsn9Ig==
X-CSE-MsgGUID: UzuXsPkAQgeF1nx7wPEtwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36635251"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="36635251"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:32 -0700
X-CSE-ConnectionGUID: HUrSsUqJQ4uAziSvgyQk3Q==
X-CSE-MsgGUID: 40zCo2b0SmaBZ0U8LGqFPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37503232"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:13:32 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v1 0/5] ice: add standard stats
Date: Tue,  4 Jun 2024 15:13:20 -0700
Message-ID: <20240604221327.299184-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main point of this series is to implement the standard stats for the
ice driver, but also add a related documentation fix and finish the
series off with a cleanup that removes a bunch of code.

Jesse Brandeburg (5):
  net: docs: add missing features that can have stats
  ice: implement ethtool standard stats
  ice: add tracking of good transmit timestamps
  ice: implement transmit hardware timestamp statistics
  ice: refactor to use helpers

 Documentation/networking/statistics.rst       |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 138 ++++++++++++++----
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   9 ++
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 9 files changed, 132 insertions(+), 47 deletions(-)


base-commit: 95cd03f32a1680f693b291da920ab5d3f9d8c5c1
-- 
2.43.0


