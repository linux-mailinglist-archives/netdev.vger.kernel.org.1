Return-Path: <netdev+bounces-120340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2710959005
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED30B217B8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F41C57A6;
	Tue, 20 Aug 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2xf7Wg1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AD1C5784
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190988; cv=none; b=h5zSpztoczEFPJDdIE/IGNusQpgd68Z5ix7AYhqGGVu/ARtVYH4sfCJ7o42HvHn3jbxENZ7+WwHicDDQnwN1SjhDJzC3dLYhgykiOEShBiRrba1nR5wvsmjQz+XlI4/Dh5HjGil4/fjfJDsjazVctDjjHlSRNm3NQNMDTDPEthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190988; c=relaxed/simple;
	bh=yxELL5yyTypSCipdnzuVOZjgO1qYhFeEn9TIzIhtFQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIcJt2NlMS0hflN5+7L9+ruJBpsQjWN4uasXPaY6vNZ4cBM2W/9vEMuRCT4S9tz/XZvIxRwuIE3AAmhjP862RDidqL/fbuFqEG1r064rBh3WiXrAXfj95ypGvqMQZ4nDAoFKosu9vK+lc0wsDy9kkKjGFu3ARPo7B2z9Lgy2haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2xf7Wg1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190987; x=1755726987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yxELL5yyTypSCipdnzuVOZjgO1qYhFeEn9TIzIhtFQ0=;
  b=I2xf7Wg18pzyMp1LVbQJ4U0kSPpzgt9wOZuJX+vPsiiDAJP2UuRaNlLe
   gLvIj+lT60L0aDfuCCX5Ni85YpIu6aQDMG1MmvupdD9x2Q2ZMImR98Gcf
   W70rs4+6fGaH83LjPe96Dth3VEUrQr6hxE9miQh6T3+eR6ztImT15nPhI
   ne3z4w9o0uthAFk8o4XURdFp9gE8jhsq1lS1UOTQ7ChArO31zhaTNQ70l
   /+DuRykfDcRlCm3lIBZGb0yos4XoFYA5FdNEjX3KI9aZYWSM+rLjw54w4
   cb0bTDMEMt1jaTZyq5FGb+YGZ7NMCg7ylF+w72W/kaJU5mYxmSpFq9O4k
   g==;
X-CSE-ConnectionGUID: j9Rx8SraRTW40pTEcyTLBA==
X-CSE-MsgGUID: EcqI4SocQautwRObM/AlWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39979341"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39979341"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:56:27 -0700
X-CSE-ConnectionGUID: EmOQYxOoSS2fSJiJXix3WQ==
X-CSE-MsgGUID: NWJ45iG8R7Ws/mLGl/1PrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65833189"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 14:56:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-08-20 (ice)
Date: Tue, 20 Aug 2024 14:56:14 -0700
Message-ID: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Maciej fixes issues with Rx data path on architectures with
PAGE_SIZE >= 8192; correcting page reuse usage and calculations for
last offset and truesize.

Michal corrects assignment of devlink port number to use PF id.

The following are changes since commit 7565c39da89dc6ac9b1b0733bd70276bc66612b1:
  Merge branch 'bonding-fix-xfrm-offload-bugs'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Maciej Fijalkowski (3):
  ice: fix page reuse when PAGE_SIZE is over 8k
  ice: fix ICE_LAST_OFFSET formula
  ice: fix truesize operations for PAGE_SIZE >= 8192

Michal Swiatkowski (1):
  ice: use internal pf id instead of function number

 .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 21 ++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 47 ++-----------------
 3 files changed, 26 insertions(+), 46 deletions(-)

-- 
2.42.0


