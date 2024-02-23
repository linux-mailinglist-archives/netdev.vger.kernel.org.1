Return-Path: <netdev+bounces-74471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF486170A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791F52897D6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C584FA5;
	Fri, 23 Feb 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJXW2hbw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB57E796
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704398; cv=none; b=eKgnVkYnMvUIZVeOiQ9k0LZC1zGqz0F/TR3w+GMidX9YDjstymuB8xD/ORmzuBi5qtOJel5ww4C7rzZzA5rG9d5zK0XceSJ6szmviFtLr8x0lQPvO+V9KJ3IXwKjQ3WBiI8XQ1mOuWBc+AHOo64NQx4erpqa4wIwpFnlXLCNOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704398; c=relaxed/simple;
	bh=amXJ5OqYkpkcN0XNwwHOV+XH0OIfi/r0ru8qguX3XpM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TYiHscwRmznxWQSoQ3myUyGScm8ydNUQru2R1ix/P5xZMc6OBqWe0fuJ8vMXSk5tNIycxo4zbwjDBTi5Ts7xIBdFVcJySI3HQFx93mgEyxKcjNMKroRqyjYgkXLlr+kd/5DfilNbaAtEhumSZAvG2qtyNGTxyTJTjqPiv21Tkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJXW2hbw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704396; x=1740240396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=amXJ5OqYkpkcN0XNwwHOV+XH0OIfi/r0ru8qguX3XpM=;
  b=LJXW2hbwaCK4ganmWODqS4ay1wV31N1XovabNb1LhXvwA2o1sfYIE+FE
   bmieg7vS/jd+4ahVMBxKdHuT4P6m8pKzUljuPHh7/LfHLucEDtTAR9RYh
   fGgUZXjASpBWpzOrBFdtijwjEzozXX49PGD5WfkSbHh+ObXQFWuahKU2Z
   RXCXj3U+RCUFPh6zWLq7iwJjHDjgKAv9zBNJNSQ+eacyiTB6HoFlEVhmC
   7IoMJY5SPxEXdyPfC/zAKAZOU/fI4xE03EWb4XPmkeMH80z11WZiUiEFG
   NDmhV90bMc74L9D3hMGTFKumqSegrZ2N3nHFbxMxFQ1X9Te8/4mh74EkG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14454666"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14454666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6161950"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2024 08:06:33 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-next 0/3] intel: misc improvements
Date: Fri, 23 Feb 2024 17:06:26 +0100
Message-Id: <20240223160629.729433-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

here are not related improvements to ice and ixgbe. Spotted while
working on other issues. First one takes care redundant Tx disabling on
ifdown. Second one is about rather obvious getting rid of devm_ usage
and last one is plain refactor of stats update.

Thanks!

Przemek, I didn't include your tag, would be good if you could look if I
did what you suggested.

v2:
- remove unused variables after removing devm_ calls [kernel test robot]
- use __free(kfree) decorator [Przemek]


Maciej Fijalkowski (3):
  ice: do not disable Tx queues twice in ice_down()
  ice: avoid unnecessary devm_ usage
  ixgbe: pull out stats update to common routines

 drivers/net/ethernet/intel/ice/ice_common.c   | 34 ++++--------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 10 +---
 drivers/net/ethernet/intel/ice/ice_lib.c      | 55 -------------------
 drivers/net/ethernet/intel/ice/ice_lib.h      |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c     | 44 +++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 54 ++++++++++++++----
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 ++----
 8 files changed, 111 insertions(+), 112 deletions(-)

-- 
2.34.1


