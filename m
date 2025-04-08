Return-Path: <netdev+bounces-180403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DDA81387
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B407B1D5A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36E237176;
	Tue,  8 Apr 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q++EhCho"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422023A58D
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133062; cv=none; b=oG/meish/yNSG31q05UMgs4qu1D/5BX0HmF+4R83pAecfAt6h+PwPqM6Q2mGh5KsUc/R0csArCmwtH3Mz/D6SvJoMdXexZbdNpfQjrYyr7BgnnvlsJuBjGtIxZhvbkrlqV7x+szBWY0WqcMXnLMVVH6Qrn72ElT+YdlN3kQ7+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133062; c=relaxed/simple;
	bh=/TkdCI6CvZCoKfW3p16k0WxDFHT1vD+zzJY2loP6GhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bmidLxn40qcqwWzG99NsgkuGIlFNMPm31qKAJPafQy8XCStLuS9Buc3acAOeVAKH90mccv/lgteEQPcOj6gpV3LydEnm36jCSoJcJUZ+zgZjDwuQOa9/txUV8KzJFfu9ZpzMlDlbfJBbSr2Ww3vvwEiY6R2+OAJ3gxcpFGlwYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q++EhCho; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744133061; x=1775669061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/TkdCI6CvZCoKfW3p16k0WxDFHT1vD+zzJY2loP6GhU=;
  b=Q++EhChoiRcil0pXQ7udxarph8Fl4iXZCyL8FOPMoI52SRcP0w2K5YG6
   kBqXpIy8cR2kRUxhjwxhojj82Kke1a6yOwAdaJNTtM412eCchSvuIGRqC
   jwfFsZVvve192jwYlGnk9sUYgFGOqRPWVBc7HoWb2CB2+HzDjsoXFPL0Z
   sGyiPNljRWofyboO2q6zNGmlNZiss7YmXI2Ao+/y6ZTpAVNgAC2cnVkrr
   8EE7tznJ95k90keDF2FwG7GkKy1meuNV1LJdDkpsqHL10vBfgF8W8syeu
   ISc7BlBtBdSxzBR3pE+GchdtrYmglBF2NTHnrlEUpd2YLyCYeODC86967
   Q==;
X-CSE-ConnectionGUID: byu9STIBSc2Ghbhk4yKG0g==
X-CSE-MsgGUID: 0jA899PYT8Gv4czSM/ZPGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45744130"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45744130"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 10:24:20 -0700
X-CSE-ConnectionGUID: P8KrnZXfSNi1DwmKfeVmlA==
X-CSE-MsgGUID: fSxm7UGlTjWcOa3jFIRnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128839662"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa010.fm.intel.com with ESMTP; 08 Apr 2025 10:24:19 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v4 0/3] ice: decouple control of SMA/U.FL/SDP pins
Date: Tue,  8 Apr 2025 19:18:33 +0200
Message-Id: <20250408171836.998073-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously control of the dpll SMA/U.FL pins was partially done through
ptp API, decouple pins control from both interfaces (dpll and ptp).
Allow the SMA/U.FL pins control over a dpll subsystem, and leave ptp
related SDP pins control over a ptp subsystem.

Arkadiusz Kubalewski (1):
  ice: redesign dpll sma/u.fl pins control

Karol Kolacinski (2):
  ice: change SMA pins to SDP in PTP API
  ice: add ice driver PTP pin documentation

 .../device_drivers/ethernet/intel/ice.rst     |  13 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 925 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 254 +----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 6 files changed, 986 insertions(+), 233 deletions(-)


base-commit: 808e3ee1385480f99a2129156c437fadee01823a
-- 
2.38.1


