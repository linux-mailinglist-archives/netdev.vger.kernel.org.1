Return-Path: <netdev+bounces-142101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE68D9BD7CD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0370C1C22AAF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941D1D5CEB;
	Tue,  5 Nov 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQ18iDj+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0951CCEF4
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843358; cv=none; b=ep+CJBdnuHX8NhHeH9dtfJVOH1VUND7R6yfiukwEb8cnPATQmLfUtN93M62K4QNLq8/h6OXTjSv+mHiT5MVyroKBMeTJvISnbkcCOtHB+WYrstLbs23588iMBFdXQ42Ov7Sdf5kD/2ApqkFFhItLn0nw3W6wCBRMUoCE4AvN23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843358; c=relaxed/simple;
	bh=6PdbRlg5M3fLbSsWfS7ryObuGd7lsNLIQHOn0mAGD3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frI02mfU9sxsN5M2XD9auKB0s8N+s/rQzm1eX1mJ2V70r+Zto9+iaZLXLcmbFgwMeioaAGs7/cK1w1Q2BeKza6h46jEQnLUWraehM4xMSNkqcML2A4IO9/OPd42CxDk+CeGETn5pTh8rnijrrVvNnNkGYxlkFScmjZiHIaQ+uWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQ18iDj+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730843356; x=1762379356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6PdbRlg5M3fLbSsWfS7ryObuGd7lsNLIQHOn0mAGD3c=;
  b=KQ18iDj+OQFt9pTMDETwpi/BhXR2xmJWYAmwL+qFBjYQ1mKrnvcTHBDo
   TjupN7gB2pI0gQ3U3fQ+DKAYAyHlCc+zbVgaD5q7Mq+PHVph7nuPkwae/
   1zz3Xby8i3qETnPD0f/LoztO3d/O1y6FQH1leShh68KuETcmVRq25vvYj
   uJAjts86mNWOZmFVeJ2wLTD+00fZUZxSlpMkMxF9bnQrfyaMnBHHOJwpf
   wVQRjvtbNrgUQVP0rYx+8f/Bry1qGe1fee0cDvBmrKhh4MbJ3cks+BKT2
   RxcfoLnUymtEk2NdpgEu88XRG9WS8Urgm0KZmFJXeQUWipl4SFqsqLPhY
   w==;
X-CSE-ConnectionGUID: FPTjhX8kShu1XQnpLWBW7Q==
X-CSE-MsgGUID: 9QpBp/++RTewJEnpjkqOdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30735920"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30735920"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 13:49:15 -0800
X-CSE-ConnectionGUID: aaefivJLS/OSLxacnZ/nXg==
X-CSE-MsgGUID: M2CB1TofTCeOdfc8/RSqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="85010407"
Received: from coyotepass-34596-p1.jf.intel.com ([10.166.80.48])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2024 13:49:02 -0800
From: Tarun K Singh <tarun.k.singh@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v1 0/4] fix locking issue
Date: Tue,  5 Nov 2024 13:48:55 -0500
Message-ID: <20241105184859.741473-1-tarun.k.singh@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fix deadlock issues in the driver. The first patch changes
argument of function 'idpf_vport_ctrl_lock' to adapter. The second patch
renames 'vport_ctrl_lock' to 'vport_cfg_lock'. The first 2 patches make the
third patch easier to review. The third patch fixes the locking issue,
and the fourth patch prevents lockdep from complaining.

Ahmed Zaki (1):
  idpf: add lock class key

Tarun K Singh (3):
  idpf: Change function argument
  idpf: rename vport_ctrl_lock
  idpf: Add init, reinit, and deinit control lock

 drivers/net/ethernet/intel/idpf/idpf.h        | 49 ++++++++----
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 59 +++++++-------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 80 +++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 39 ++++++---
 4 files changed, 149 insertions(+), 78 deletions(-)

-- 
2.46.0


