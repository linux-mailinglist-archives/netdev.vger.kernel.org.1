Return-Path: <netdev+bounces-187135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F7CAA5264
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E4987A46
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA925332B;
	Wed, 30 Apr 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niWRiigU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE61DC994
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033149; cv=none; b=C0rauTUA2Zo3FdV3ylVKMy8B+3QURCd+Wy87e6ofQWqhMHbpQ0VT7maVmHwOCIy8VoKTNKMHKrNb52Q63NTo4//9LLvcC6g4z6i/VIGigB0Wm/FUdnpWNNiymzoxHoJd/g+xnsqVZWGXgllaRt+I7ciNTqNu6W2vMwu5ce4i+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033149; c=relaxed/simple;
	bh=u0BBFSaUV64wj5ByuxZknCqGvWsF4wHEH18gXkfwdac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JbAMtk5rDnuODAcSTXp9Q0bg3duqsTpi/9h+3sJAM7imvLNqbRM8iZRAMkL2+i8Lvs3YZgv8fhPpMfSM8RhsKb+HSqI+PNQx6mXHiShuZ5ofZ5EBfc5DhW+h/krhXv9M0BKqKPdcYNt6CgejBdgBJ8XkBEnzYpzqIMyqiohVioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niWRiigU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746033148; x=1777569148;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=u0BBFSaUV64wj5ByuxZknCqGvWsF4wHEH18gXkfwdac=;
  b=niWRiigUl8inw56qAZ+IbIz0j56N/K/+v0H9dt8RD4FeNCU9t8OQf5+C
   4/0QBkqiHW7Fp8X/TvOq5sF40OL+GErjHEEOpE3u2owVesR3R4mo0HHgw
   HEigiEEqGYuMjtuJba2eO+L+V9I0Bu7YuVxMZoaSBVKzblZ8M48a38k3P
   l8usn73T0VcsqxSN+ygR2yds1iELpqldu1bNyxOBlExtRt6L2kCgJPYDz
   dJQaKEcgLgHvW6SpuuUoAZHC4oS+s2fuiamJjt0B/C4U0aRv42ySqPvMM
   xee6IvKsIa/vNm91Ur7CriSq5r2GLKxhIPHmWXUf+0hKA1cB4Kegv1SRH
   g==;
X-CSE-ConnectionGUID: z7uMe6FxSMC+D+vvK9cBMg==
X-CSE-MsgGUID: Ta9nHF65RmqmXImLcwyChg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51370084"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51370084"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:12:16 -0700
X-CSE-ConnectionGUID: sXxF7arZQQmaIXYRpBl/mw==
X-CSE-MsgGUID: xsELgrtaTKuqVWjvNNTpSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="139358951"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:12:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 0/2] net: intel: cleanup RSS hash configuration
 bits
Date: Wed, 30 Apr 2025 10:11:51 -0700
Message-Id: <20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdZEmgC/33NQQ6CMBQE0KuQrv2mLQWKK+9hXJTysVUspiUVQ
 7i7TVdsdDmZzJuVBPQWAzkVK/EYbbCTS4EdCqKNcjcE26dMOOUVFbyE+wOMCgbQKfA4KD1PHlq
 lGfJOlqpCkqav1Nglsxdi3yM4XGZyTY2xIQ0++S+y3P+nIwMKpW5KWVetEF13tm7G8ainZwYj3
 yPtD4QnpKFSoOrlwGi9R7Zt+wIeYj+fBwEAAA==
X-Change-ID: 20250423-jk-hash-ena-refactor-9ac1e2b83a5e
To: netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

The virtchnl API does not define the RSS Hash configuration bits directly
in virtchnl.h, but instead implicitly relies on the hardware definitions
for X710 and X722 in the i40e driver.

This results in duplicating the same bit definitions across 3 drivers. The
actual virtchnl.h header makes no mention of this, and its very unclear
what the bits mean without deep knowledge of the way RSS configuration
works over virtchnl.

In addition, the use of the term 'hena' is confusing. It comes from the
I40E_PFQF_HENA registers, indicating which hash types are enabled.

Rename the 'hena' fields and related functions to use 'hashcfg' as a
shorthand for hash configuration.

We could define the enumeration of packet types in virtchnl.h. Indeed, this
is what the out-of-tree releases of virtchnl.h do. However, this is
somewhat confusing for i40e. The X710 and X722 hardware use these bits
directly with PF hardware registers. It looks confusing to use "VIRTCHNL_*"
names for such access.

Instead, we move these definitions to libie as part of new pctype.h header
file. This allows us to remove all duplicate definitions and have a single
place for Linux to define the bit meanings. The virtchnl.h header can point
to this enumeration to clarify where the values are defined.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      net: intel: rename 'hena' to 'hashcfg' for clarity
      net: intel: move RSS packet classifier types to libie

 drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 43 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 32 ---------
 drivers/net/ethernet/intel/iavf/iavf.h             | 10 +--
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        | 40 ++++++-----
 drivers/net/ethernet/intel/iavf/iavf_type.h        | 32 ---------
 drivers/net/ethernet/intel/ice/ice_flow.h          | 68 ++++++------------
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |  4 +-
 include/linux/avf/virtchnl.h                       | 23 +++---
 include/linux/net/intel/libie/pctype.h             | 44 ++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 81 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 25 +++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 25 +++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 46 ++++++------
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 17 ++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 33 ++++-----
 drivers/net/ethernet/intel/ice/ice_flow.c          | 45 ++++++------
 drivers/net/ethernet/intel/ice/ice_lib.c           |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      | 44 ++++++------
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |  2 +-
 19 files changed, 289 insertions(+), 327 deletions(-)
---
base-commit: deeed351e982ac4d521598375b34b071304533b0
change-id: 20250423-jk-hash-ena-refactor-9ac1e2b83a5e

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


