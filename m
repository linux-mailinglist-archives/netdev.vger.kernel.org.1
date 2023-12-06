Return-Path: <netdev+bounces-54590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C059D8078A8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1125E281C31
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD347F49;
	Wed,  6 Dec 2023 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3ezdEKL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D611BD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 11:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701890965; x=1733426965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJ74U93h8bLZzk/gtfgA8PUSleARKCC5LXQ8p+r+f/M=;
  b=m3ezdEKLnDGIzw9KaHqzQAifTGT+qvM6YnuKA2WcY3S7I+0BfmaXxt4h
   I74FFbWGPVJAkyQBzvLlfM4cbOhF/0d/aSSEntQJ5bStoO8W7hJDVzJT/
   5S+pnyRNgcIBtgr2mKU8xUrI7GNN7ifKGMBls4xLZ5NljCj2wR6q4t1wa
   Ygs8udaawE4WyFJSgIhVCXY8V/1R1p02FRjr0AXRavi/FAlCK/u1YU+Vu
   jCh2byTHwE8xOzpFsCY8E9GdqWuWikjjlsI8xfDGC7haK+2t2j17gCmDg
   sfzZKynwLojyrnisOQxbhAsCgwRvZ60SqVmNnh7Jz2wobww/S4+6XWJq4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1214418"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1214418"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 11:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889446489"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889446489"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 11:29:23 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 0/3] ice: add E825C device family support
Date: Wed,  6 Dec 2023 20:29:16 +0100
Message-Id: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is supposed to add very basic support in ice driver
for new Intel Ethernet device family E825C.
E825C device consists of 2 NAC (Network Acceleration Complex) instances
in the IO die and supports max of 8 ports with combined bandwidth up to
200G.
There are 2 configurations (known as NAC Topology):
- single NAC (only one NAC is enabled) or
- dual NAC (both NACs are enabled, with one designated as primary and
  other as secondary).

This series covers:
- definition of new PCI device IDs assigned to E825C devices
- support for new 3k signed DDP segments

In the follow-up series support for new PHY and NAC topology parser
will be added.

Grzegorz Nitka (3):
  ice: introduce new E825C devices family
  ice:  Add helper function ice_is_generic_mac
  ice: add support for 3k signing DDP sections for E825C

 drivers/net/ethernet/intel/ice/ice_common.c   | 37 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_controlq.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  4 ++
 drivers/net/ethernet/intel/ice/ice_devids.h   |  8 ++++
 drivers/net/ethernet/intel/ice/ice_main.c     | 10 ++++-
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 7 files changed, 61 insertions(+), 3 deletions(-)


base-commit: 545c31d16cc00bba281ee1927d6338e27d4b7b5e
-- 
2.39.3


