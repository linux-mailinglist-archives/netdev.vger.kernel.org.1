Return-Path: <netdev+bounces-118475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88EC951B79
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DB31F244D6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063F1B14F9;
	Wed, 14 Aug 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwnwvlz1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEB1B14E7
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640967; cv=none; b=BiS6X3SWxvFleyR/hzmeWs95coGd8ffCyw39yVmBf//ZYsuNxpSJgU9fYxwJuhsZid922nyuyIqQRn9lTnNgTMg6b66hOM1Lwu9Rg6uBknSjkQbWJWbm3BAKHa+GCBOD7A18qPP0fuH9pOgFuZ/uoV42dwxYb9cLQo/HDEekBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640967; c=relaxed/simple;
	bh=fv69A1X/eE3vo6a3jR5q9++eb855dOB5CZGXNH8LUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fI9nYvKUr7MoNzrE6XNjdZo0DamZ/gtL4lU1GRpGlsg9UJGHgUPiU3RG4eI3MVDDCwn3+613/Yv+3+zo86R5/q5tPjbvAO3DGYrMD5cdx1UDqk1rKeRBWWcHdJIlz9H/sjlU+8O7Oe0w9uIIrVCW6m2nHt6btFzTAf3GEvM2KL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwnwvlz1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723640965; x=1755176965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fv69A1X/eE3vo6a3jR5q9++eb855dOB5CZGXNH8LUPs=;
  b=Bwnwvlz1c0PrdHvi5pnnl721vyL7iU1okY5o1vNLrx9N/JeCPREUQtZJ
   xjWbeHq+q2hrEoQLgrHxvrtfvhnWYHfmKzH17G1shvdCKpu7Q0IDHNwfk
   vWsS06t04tE8Io2cHZwO8p3QcpsWTDoy0i6haSFZgf9dzQzD3D90P8A79
   esvdfXWv6bqg+XxtDYxruVXlkSOgYdibU5Gv6o06wclHm4ET9iBo/hpo0
   SiobB7R/IHJyG4j+YRrFklX3Cq0mibCaLORPiPkt+CqxXrbvgXodUe+jx
   OE6cFi/NNl3oaQc1f0R0XZFqIFCZ8LtZWGLgpESnsOnCC2jGnAjYsxOaA
   Q==;
X-CSE-ConnectionGUID: GCof449QTAKlcY0S+4G8wg==
X-CSE-MsgGUID: Ge5mIXmqTCS5ytDfP30gXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="25658749"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="25658749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 06:09:23 -0700
X-CSE-ConnectionGUID: otCyhaOxSW6oSiIG0AMeug==
X-CSE-MsgGUID: oda8AYmAQ1GmlCsItzhtFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="59009608"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa009.fm.intel.com with ESMTP; 14 Aug 2024 06:09:22 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v6 iwl-next 0/6] ice: Implement PTP support for E830 devices
Date: Wed, 14 Aug 2024 15:05:38 +0200
Message-ID: <20240814130918.58444-8-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 289 ++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  41 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 12 files changed, 614 insertions(+), 416 deletions(-)

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


base-commit: 1dc36a5700fae7c147c5a78da10930a36729d14a
-- 
2.46.0


