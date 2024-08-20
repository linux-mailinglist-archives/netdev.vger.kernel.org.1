Return-Path: <netdev+bounces-120091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EDB958464
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE75287010
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53F18EFDC;
	Tue, 20 Aug 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLJLXbky"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252818EFC3
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149471; cv=none; b=pDWO131bvyb8FoUl56vj9m+/DE5/y/1s/tefp2qD/3GpxYpyCPVhwN/s9Sgo4oekoZIim2jR3nXFTsZH6th7B67XUJp34kKFvsNoLVOeFpTIoKoRyvqOzNpofkvdHardU/kSlFMoUhNrEQX9olec3gDCYECzZaMUknmxsB1kCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149471; c=relaxed/simple;
	bh=BrRtTluh0XeupPUpqsnwkQNqKN683wr3zvwkT/TA8bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhnQgCt02y6s1vV9Y8rr7ki7XaNh1r0+a6S/qJsGF1yhltBC6W5UnWpyrFT+Vl1rPwSs3+CC5UKlnIRlCov2t0YjidhlLWULnc2xbajl0AowpXZBRANOYqRaE0dgBCALOy5myNQ8NbBDHHo4ZcYX2aieipTAiFi/1cxVW+ZQ5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLJLXbky; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149470; x=1755685470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BrRtTluh0XeupPUpqsnwkQNqKN683wr3zvwkT/TA8bo=;
  b=YLJLXbky21dQkiGqeh1HF7ww7R90ypBZWmTYoz7Cxob3rWGuzgtOc/XS
   R7d7QQXu8T87NTeSDegqH1NLRnOUh3LYzk4WS+j51PVdCYA/uB+HV5gDk
   0Ir2OI8YI5/Q6L6sYq15A3SA0kEidVMrHc9S87wjdiSSU5lSNjAnxruj6
   3WbERD2bQ/tUnh3S48XnOMqlz5pZ2D8IPP2veHHUeBzO6UKNhPxw2MNKm
   H8gsaJyi3oRH0fr5z+mLUerHsyCFVRaphE47eBwz2soK52i9ODEo2z2LL
   ONWAYgDMMZU7jylAtmI3PZ4NvYYwGsV033g+INga2mjmSvQXLdAEeYAyN
   A==;
X-CSE-ConnectionGUID: qQmuy2j3QbKPMYDi4BGQbQ==
X-CSE-MsgGUID: dVQUe9FkT7egXwZ+8Qsh6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44962817"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="44962817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:24:29 -0700
X-CSE-ConnectionGUID: qo9MhO8SRyagRIyPzhlBRw==
X-CSE-MsgGUID: DIypUAjISnCM623UZidfAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="98152795"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa001.jf.intel.com with ESMTP; 20 Aug 2024 03:24:26 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 0/6] ice: Implement PTP support for E830 devices
Date: Tue, 20 Aug 2024 12:21:47 +0200
Message-ID: <20240820102402.576985-8-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add specific functions and definitions for E830 devices to enable
PTP support.
Refactor processing of timestamping interrupt and cross timestamp
to avoid code redundancy.

Jacob Keller (1):
  ice: combine cross timestamp functions for E82x and E830

Karol Kolacinski (4):
  ice: Remove unncecessary ice_is_e8xx() functions
  ice: Use FIELD_PREP for timestamp values
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 128 +----
 drivers/net/ethernet/intel/ice/ice_common.h   |  19 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  23 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 469 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 288 ++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  36 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 12 files changed, 608 insertions(+), 416 deletions(-)

V6 -> V7: Fixed timestamp acquisition in "ice: Implement PTP support for
          E830 devices"
V5 -> V6: Fixed minor compilation issue in "ice: Use FIELD_PREP for timestamp
          values"
V4 -> V5: Added 2 patches: "ice: Remove unncecessary ice_is_e8xx()
          functions" and "ice: Use FIELD_PREP for timestamp values".
          Edited return values "ice: Implement PTP support for E830
          devices".
V3 -> V4: Further kdoc fixes in "ice: Implement PTP support for
          E830 devices"
V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
          E830 devices"
V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: a2048a2cb937396757fee14263302191b3c0f0da
-- 
2.46.0


