Return-Path: <netdev+bounces-107356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1391AAB3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03ED1F22132
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86C1197A96;
	Thu, 27 Jun 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckW2jsYG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7621591F0
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501098; cv=none; b=L+kub4W5cv7rvZTbZ93nLYiLKu7DcBW5V7Gwd7pUUOIww7DXdLuFct3ugCpM7BX6Hs5CH7XfzPfP2p5s+5nraCJ993KsKx6eMkGHWDuEeWY+LR9QbLuy2SDR7uDwCzCxdLR9aQ8U3k6csRgAhFKRLupzWmz4NtLTqwo8YHHlkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501098; c=relaxed/simple;
	bh=pwCjiIUxO75pO5di4qRhIFHtzN1Bs3/cpB/j/x7S5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPCYep73f4tA8wTC4k7LmjT6GIggAm+Lxyhc6eoFx+r0xVgaWXrSUsNSfHS8SE/CgSD9znEW6Tmu1w5ucpcvF3Qr2GbWNJoQqu9lJhXe5TrhzGAcsg4X8NQ4a6kVMcycaWh44Qq6j4jLhwNhDxwUZxta3JyjR86t8i8hm8BPOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckW2jsYG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501097; x=1751037097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pwCjiIUxO75pO5di4qRhIFHtzN1Bs3/cpB/j/x7S5SE=;
  b=ckW2jsYGgvLeLGa/LPdz04Sbs+K6WITkgAlf62C5LbnF1m4fibRCtXXh
   iUsfIbFmrfwKmG5v0BxAVsqvWNv/QBYVB2tZ8OZe5DqzhZGBabwt4Dcf9
   tDcI6Pcfj2uioOKchD5YgwGlt3v+2aoCrrCv9VhUZ0IHoNk2dqVDGqU2h
   Rfpuz6mLc8ZfpM6euqXoCWlbOgQHADNxAzdh9WmZEtnOWX/a6wfNzCZ1K
   wOynmcdFF2gLEhp6JU+kM+TzLZrX7iVPUsOm+iwYLGjAnB37Cqxl/0XdE
   pym24aJmkRD5D8IS9cyBWcy4byquZr4EG7SnNMLKVYS5iZX3z/hTGU4ab
   g==;
X-CSE-ConnectionGUID: /7pxLCTkS/Ozg6xU1v+55g==
X-CSE-MsgGUID: ECKdAXBCS22SEfYzWBy1Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27222460"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="27222460"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:11:35 -0700
X-CSE-ConnectionGUID: 1Ya23w1kR/SOJt2lXwBgGA==
X-CSE-MsgGUID: xr6z+K/zSs6+l5QNmR1xsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="48759662"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2024 08:11:32 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 0/7] ice: Cleanup and refactor PTP pin handling
Date: Thu, 27 Jun 2024 17:09:24 +0200
Message-ID: <20240627151127.284884-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up current PTP GPIO pin handling, fixes minor bugs,
refactors implementation for all products, introduces SDP (Software
Definable Pins) for E825C and implements reading SDP section from NVM
for E810 products.

Karol Kolacinski (5):
  ice: Implement ice_ptp_pin_desc
  ice: Add SDPs support for E825C
  ice: Align E810T GPIO to other products
  ice: Cache perout/extts requests and check flags
  ice: Disable shared pin on E810 on setfunc

Sergey Temerkhanov (1):
  ice: Enable 1PPS out from CGU for E825C products

Yochai Hagvi (1):
  ice: Read SDP section from NVM for pin definitions

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    9 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |    4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 1129 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  119 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  101 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   72 +-
 7 files changed, 800 insertions(+), 636 deletions(-)


base-commit: 6a788e1f6ddc6750a553314403136b1be9301cf5
-- 
2.45.2


