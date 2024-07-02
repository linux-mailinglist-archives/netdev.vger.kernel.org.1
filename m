Return-Path: <netdev+bounces-108486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F04923F48
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879EE1C21FBC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129B1B47DC;
	Tue,  2 Jul 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LILiKqsk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4131B4C41
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927899; cv=none; b=ZqVN9LNV/JQU53ndErP3pUV7Rp22XSff+muM02hsR2Ozik44gbcBV63uk1WSvMnCsMlMBaxYxy+XoIqO3saCmlGqIcBRDRAGPiNxXHdUwUK+FQ/5bXA6sEMl7hWc/OFEmW3aR2pH+TJ8JFONezasnYFJKNtKIivwtrXw0csbu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927899; c=relaxed/simple;
	bh=2gpnR2gAVTCUgMbD2zpjQMoFCN1JPTv8HiXHTi269wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVrjBDkOEQ18dAY1ItUJ2zgV3WGzK+v1PppPws4K+vNuop7cZ579BLUteduUgJLaLRdHrlFfIB6ykoS4QDKMwkr+eZp7Cs4gNJSodn2G1D9JVkqpA7XguQirNGX+V6N3phocNCjosChekZGOIWVj/PiJVKXffjEK8YqBhlQ2URs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LILiKqsk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927898; x=1751463898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2gpnR2gAVTCUgMbD2zpjQMoFCN1JPTv8HiXHTi269wY=;
  b=LILiKqskldYnuK/7M/nWJNQPLJPeW/3WUYUoJw8dBfQ118atozLh86qi
   Jmlbsktz2oanWlQJAcvBLJ+Z9qV8VMR1ztqf1ksTDaUQhj/kn1NmMkxqY
   ThUautt/BjmGkUQSnhQ/fttKRyx9J6z3DpA4/BSJo6pXzSz443+l2BHsR
   vrojfDDulVqd547+48QyyicREwu+PZXN7pbN+sXelQfHWtugTOB9QMjsu
   cxMhbGkSC0cbxOZnP+YHUFSjHWrFeBUcJ87/KJm3DVMKLIcviWz4bRKuq
   I26LGrwTNYiIu7ceZXakBuIFBhEIpy8Qa4fwwVyGBGnPoLpheBsqBJKN/
   g==;
X-CSE-ConnectionGUID: E92c7PapRUC4xWwqicWK1g==
X-CSE-MsgGUID: lfJLPRn3Sf620YJxF2tbHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16826397"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16826397"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:44:57 -0700
X-CSE-ConnectionGUID: 8sa5tS7OTkypD3T1vOjt2A==
X-CSE-MsgGUID: iAtLnuk5SlmKYxqn6500Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83460492"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 06:44:56 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 0/7] ice: Cleanup and refactor PTP pin handling
Date: Tue,  2 Jul 2024 15:41:29 +0200
Message-ID: <20240702134448.132374-9-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  103 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   72 +-
 7 files changed, 799 insertions(+), 639 deletions(-)

V1 -> V2: fixed formatting issues for:
          - ice: Implement ice_ptp_pin_desc
          - ice: Add SDPs support for E825C
          - ice: Align E810T GPIO to other products
          - ice: Cache perout/extts requests and check flags
          - ice: Disable shared pin on E810 on setfunc
          - ice: Enable 1PPS out from CGU for E825C products

base-commit: e3b49a7f2d9eded4f7fa4d4a5c803986d747e192
-- 
2.45.2


