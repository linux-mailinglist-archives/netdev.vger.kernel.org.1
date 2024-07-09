Return-Path: <netdev+bounces-110248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6792B99B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AAF1F2545E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D71586F2;
	Tue,  9 Jul 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNYTMFcP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EA152160
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528603; cv=none; b=iqE+hhDiaQtYDOFc2qQfV4Yq6dXBE2XnG7RlOWiMSWAt2V2YBsqWll3BIg+mXzFDXOkA35g/bJMuRcFpvW0CFTMXXiLZ3YMcNlUIYzdQbXnFWowVYT8dBTk2DqO/HfIusGFLh6sgYjaxc+0o8Xhdvy+eqU/04ojOV8dnd8N8l+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528603; c=relaxed/simple;
	bh=XhSywQ0BcjcGguonn7oHKVbbArBG1xSAZzm3ujv8N4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMNPtZuD10EvOaVAQY2l19OOLLSgXzHo+1mAeHjOCDdVwEx1XdY1FIa66xcudyZDJJ7bFiPRK4jeIfQ/tH7SufaTvVPLELi3aMZmXtG09vDbG0rAfo51R9+oxqhNGk+RCqEAHtHscGgIk98IUwYM3eFPVIXsayJWbnr/ylYaihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNYTMFcP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720528601; x=1752064601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XhSywQ0BcjcGguonn7oHKVbbArBG1xSAZzm3ujv8N4Y=;
  b=lNYTMFcPckRi2GwItRzEP9OZjvZg+bzPBkXpeFaS4Foc+Yls4AEPObz4
   tVkwyVS7Xj1ON9ZoPFCpS6hlMemoWDnuP4fY9Rfmgpi8WTpbYeafX3n1Q
   WTlVZMba7dZ4cwN2GNpt3011Oy/4NFlUEXG/CewWsc4UGGrZa9t/FvASd
   /kURpOcnLwsmQvAaEbOELqKKYu81xX8HHLR1DUyHXmCyQ/OMP/T9fteJh
   TGt6i58eplFP/LnNxRaL5JxoMV2NKziLbskPNmRAV5BxT0j/RxmblSg7V
   9L5YNRAReUUhnjYwZxKGE+EBGFg6Xd/qLKlh2zGaGEv8djMIxEAxct6kT
   Q==;
X-CSE-ConnectionGUID: s29pu/ySTQmpQKyrZ3yTzw==
X-CSE-MsgGUID: jyhK5cf8SfGfQpGOp17G5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17598155"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17598155"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:36:41 -0700
X-CSE-ConnectionGUID: svmgPpBORcOAyNmkgJiTWg==
X-CSE-MsgGUID: QPsGzXLARcGPEJ+yAhGLHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47776092"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 05:36:40 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 0/4] ice: Implement PTP support for E830 devices
Date: Tue,  9 Jul 2024 14:34:54 +0200
Message-ID: <20240709123629.666151-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
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

Karol Kolacinski (2):
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 354 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 197 +++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 493 insertions(+), 155 deletions(-)


base-commit: 529314adcbceca0e0ec72b3ea94fe4a54ae61ca6
-- 
2.45.2


