Return-Path: <netdev+bounces-180729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CBA824E9
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A5A1BC29D4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31BB2620DE;
	Wed,  9 Apr 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsbOIj00"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BB26158B
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201722; cv=none; b=ba0xVx61kHOfsq7WD5YoIfCk3C7jVtkK8hGfXBf8YIHgv6IueTdFaWySjzEMfDDAehlAkerm+nyLL1n8WRToirnMb4pnFcxbVfkqC51kKnVg9ShpSYjjcIza9GkinNDzbOzTIHuTtjzBuU4Q8XEXmts6x8AOApItEcJiyq97sEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201722; c=relaxed/simple;
	bh=Mu+p15Hp5drZzvf5UskI2pfOzBCFUjQ49A9lPK2GyYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldSHIlabgkEtQvHgUvvVDlIjNZYjM9VxHRBWhrJCPmcaiQU5zfGkXqlSC+9F5YoTlvF6usfj4lFNn2ndKkkiuMKgYYOijlD0Ruf5HNxt4a5BYFlf/RXFl5p3IGiPPR2sEQbK+wKRKoi1fBr1PXyk54eLrgPsRYXnLh9gDILtV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsbOIj00; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744201721; x=1775737721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mu+p15Hp5drZzvf5UskI2pfOzBCFUjQ49A9lPK2GyYE=;
  b=nsbOIj00ps87e13pG+iCNayaeTQgsrpRPCjw9Iy9j1rkB3VXSTFdoWf3
   ywExxUPEjOYfjaUcoysJJkBtlX1MX/nUKy5E1sFhKYXFbZv/c1UzlC7Fm
   IIlwSbKjKKN+4Ok5MwpVpJe5/UUcxqZEcQ4EevRkHrA447D8sZ81R1daR
   yN/qqE5ypOb43mfrO4cBkjbsb/BYynBnmh1y4AiGmFVyScqHAsYEUtJ3y
   G46qnqqL59QX2nf2bEt3eSAgqcWT8SAjFXcpLWy7VEqKC94dc7/7kqgM/
   Sv3czZeXzKnK+hE5KI1FD8fGJRLLBd81l9ZkWcLn/nDfQSIFbj1sCz3rb
   w==;
X-CSE-ConnectionGUID: YMth/E95REiTrGz3h7fxeA==
X-CSE-MsgGUID: P1EtK7cERqyel8GvljAW6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56655653"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56655653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 05:28:39 -0700
X-CSE-ConnectionGUID: lZMKLIZLQhSecKc1ugG5Qg==
X-CSE-MsgGUID: NElIpxJARreKXuglKzeRrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133557165"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2025 05:28:38 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 00/10] ice: Separate TSPLL from PTP and clean up
Date: Wed,  9 Apr 2025 14:24:57 +0200
Message-ID: <20250409122830.1977644-12-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate TSPLL related functions and definitions from all PTP-related
files and clean up the code by implementing multiple helpers.

Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
proper init flow of TSPLL.

Karol Kolacinski (10):
  ice: move TSPLL functions to a separate file
  ice: rename TSPLL and CGU functions and definitions
  ice: use designated initializers for TSPLL consts
  ice: add TSPLL log config helper
  ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
  ice: use bitfields instead of unions for CGU regs
  ice: add multiple TSPLL helpers
  ice: wait before enabling TSPLL
  ice: fall back to TCXO on TSPLL lock fail
  ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h | 181 ------
 drivers/net/ethernet/intel/ice/ice_common.c   |  69 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  58 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  14 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 177 +-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 564 +-----------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  54 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 511 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  28 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  20 +-
 12 files changed, 701 insertions(+), 978 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_cgu_regs.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.h

V1 -> V2: fix compilation issues for patches 02-04 and add missing
          return values for patch 07

base-commit: edf956e8bd7d4c7ac8a7643ed74a36227db1fa27
-- 
2.49.0


