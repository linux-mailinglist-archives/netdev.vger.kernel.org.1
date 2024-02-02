Return-Path: <netdev+bounces-68637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED728476C7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF31F22F49
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850F214C5AC;
	Fri,  2 Feb 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ1eiPoT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3514C58B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896581; cv=none; b=ooA4ztWQg0vhJ5EPoVaD2tl0tp6dsemVq6NU5moNGyGlqPzPdIDPdt+EVLvl5TmzF7+wfw61JR8wjUl60QCPuzTApVIVKYBaapALsAv92TIznhE6YBo/zae7PArjTnq6+Y1/ypiIbJ35oBSkCk0HQuFpPkOr29SkijU78kY5CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896581; c=relaxed/simple;
	bh=O3zdSI6R0ydnM3isIn52feJrisXNpPRn9beuy/bJiYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHbCBHVl3FmvJWC8YxsKZh/fUAFAvjVvk+Jk0QFI6NHqZp26CiRzl8GNc7ROtbyY79bW7NUnlbUasnQJqLndpB6B7L40407/79+DfkJF3EEZxp65p6nYfpwSLCe0oB7PpZ9Ri1j8zTyGiN0hA+QyPpXJ2BP6mdm+0MYwlBmt658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJ1eiPoT; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896579; x=1738432579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3zdSI6R0ydnM3isIn52feJrisXNpPRn9beuy/bJiYg=;
  b=DJ1eiPoT6oYUs1U3Cj0w3/cWGCZN5+sJHG0lTzB4zmkYGQQ2cP1wT279
   oEDCwszA3Q+C5U6DQhz6tiQjzZDWA8WPXc7nerTkDKVKD31aCWm8mzJJg
   3rgdY65RgUbqeq3LsvheJb1SJHX9C7rsvjeN7byx25wxI0gIBkbjz14Lm
   xSRxeO8X+XUsGMY3fiLflO2CYfg888mRggwrkmsnbmY1kgglB4hEAqL4M
   Pi6oHbHFUo9OhSuAOFeALQhes+9R6SyRtsuWEwXLVSVwOpwGfBR7Qpwkw
   iqFdesto+9vAbw9BxzTWT5dMD52yipY7wE/ArLS8P3r//vM1OqyQUvgSU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435347602"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435347602"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="137828"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 09:56:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/4][pull request] Intel Wired LAN Driver Updates 2024-02-02 (ice)
Date: Fri,  2 Feb 2024 09:56:08 -0800
Message-ID: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Maciej changes some queue configuration calls to existing ones which are
better suited for the purpose.

Aniruddha adds separate reporting for Rx EIPE errors as hardware may
incorrectly report errors on certain packets.

Paul removes an incorrect comment.

The following are changes since commit d81c0792e640586c8639cf10ac6d0a0e79da6466:
  Merge tag 'batadv-next-pullrequest-20240201' of git://git.open-mesh.org/linux-merge
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aniruddha Paul (1):
  ice: Add a new counter for Rx EIPE errors

Maciej Fijalkowski (2):
  ice: make ice_vsi_cfg_rxq() static
  ice: make ice_vsi_cfg_txq() static

Paul M Stillwell Jr (1):
  ice: remove incorrect comment

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c     | 134 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_base.h     |  10 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |   3 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 129 -----------------
 drivers/net/ethernet/intel/ice/ice_lib.h      |  10 --
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  22 +--
 9 files changed, 150 insertions(+), 168 deletions(-)

-- 
2.41.0


