Return-Path: <netdev+bounces-66010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AE83CF08
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133C91C25BDD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3F13AA30;
	Thu, 25 Jan 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib0P5DyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B213AA2D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219886; cv=none; b=Wtv5L+Sv6HuBAHZPoCeo3Wjwl6XkXhNlpdgtoyqy71pEoi2SmvCZPna9XHlBerqzyLDGRBQaDcL6wp28yVG25CaCuBq+C0OLo4YxYUk32am1+jxFplXxMLz1iD6BDac00iLvXMS6EhAof+tz8GYo5h/E21fDr6q8otcVw3gdoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219886; c=relaxed/simple;
	bh=3JA/WmK1DJG/lsNo9CXReeHf651vlFcyJHbFVNZCQ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/cSAtdXDRqgx8FLe2NRXfcC7pOERE+c5jCedmXOlCwnsnUvmC5FgsiG36oKCBSIWY8MbQWDSTliQitq0Xhi9I1RC12eVxUMUr5u2buTpJhjJxtlKtJ+ae0pKbaGUarQSW5VxElccqmK6FIG6AwjuUGIuvfuYkhIz5D9+DFddpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib0P5DyJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219884; x=1737755884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JA/WmK1DJG/lsNo9CXReeHf651vlFcyJHbFVNZCQ1g=;
  b=ib0P5DyJuUHCMIJGp/yceokPT2BBgxp/VVJHjTBbzjvu3xL9rYzhLqcd
   XkrtZDHiCm4dc/EECRaj40lgW4IZGMxIaS6+9yXtk04vvJseHRRjBNN5F
   oTOgeuCrDyEAXeo7GsYjO4HqgDhTy/Rd/AV19Ypvn1cNxYQFPUimndBNx
   tzLRtfpebB+8E1Cf3PX/vicjqdaXLIj6MAtqi9F/APDqBuFSxf/2ITBig
   wBvGNeHiJMEDDFW4EB5qXaZRe4H+EVA9PWuyQGuSNNkfiR1vmHfyV3c9r
   f+ATS4muXDN+8PHN01IrbOv1/g/l9CEcAfsh3ylPMeMabSV/XRQI8WafB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9069073"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9069073"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35239917"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 25 Jan 2024 13:58:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	richardcochran@gmail.com,
	karol.kolacinski@intel.com,
	jacob.e.keller@intel.com
Subject: [PATCH net-next 0/7][pull request] ice: fix timestamping in reset process
Date: Thu, 25 Jan 2024 13:57:48 -0800
Message-ID: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Karol Kolacinski says:

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

The following are changes since commit 91374ba537bd60caa9ae052c9f1c0fe055b39149:
  net: dsa: mt7530: support OF-based registration of switch MDIO bus
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (7):
  ice: introduce PTP state machine
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: don't check has_ready_bitmap in E810 functions
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 229 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 164 insertions(+), 106 deletions(-)

-- 
2.41.0


