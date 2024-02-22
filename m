Return-Path: <netdev+bounces-74042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E333C85FB94
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52C01C20C78
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36501474A2;
	Thu, 22 Feb 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy4wrnf2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2443AAE
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613435; cv=none; b=icY0snDWZdOn9U0swEtG3xOAs9ChGKnmby6iUai/6doH2uudd0PJm+ADYD2IriHnJIAAepKOITSKuuHcWBtTAg3bas2mX3JPf7wwjemMhTnQJdg1OUx6ZyndrssMEq3w13BZPskbu9NfTiLHGBUXXAFJ1ipSvtZXIkpOMCPX0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613435; c=relaxed/simple;
	bh=ai+POYHLNKjc0oXBJKD89ThCIyYIBpTvizWJxsexl1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZjoghqUxv7Xn4mRSKzvkGTxVZ5SWTBckJa0eHB94P3ySipx3BCWlXKCbhQsS1sxSr6Y7y6Btr5p8Ei1nTWZTN5oPfmc+m2S2WSL9d4Wva2dYLHLGASB+0JGxzFZYEK9U19AKsuEMs8fDv5wB7ULMGdQFGBFpc4ppJNagRk69b94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy4wrnf2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708613434; x=1740149434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ai+POYHLNKjc0oXBJKD89ThCIyYIBpTvizWJxsexl1s=;
  b=Xy4wrnf2PfZDC/TZpcTD/CVE+BjAKXNwgDIw6dvzhoyDSMba26rz8e8H
   9BWjYJ1jS1Fv1LaqjzBuOx9vsJ9KmQZisVp2bmVcZxOHVftterH/i0dOy
   atZ5ys6e9kxxEyuBeSomY7M77ERy4jcJKHhbqhdxWfpoUGiQ+Q3OM4i4e
   rxhvdOO1NPROd/FBunDXlf31VYusxlUVc3FlQVOtxsyyijjDwWN9NZz9z
   COGcItiF0S/8U4adXeE6y7IfTLMZXOfTmWK9gVJW7XdNIS+GJ20c8zYRx
   PsbrFaJqZhucNFDQtdO7w0Iyh9CFP+APna/j+tnwpkleeywXb0vsznogY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2949291"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2949291"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5670920"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 22 Feb 2024 06:50:31 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-next 0/3] intel: misc improvements
Date: Thu, 22 Feb 2024 15:50:22 +0100
Message-Id: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
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

Maciej Fijalkowski (3):
  ice: do not disable Tx queues twice in ice_down()
  ice: avoid unnecessary devm_ usage
  ixgbe: pull out stats update to common routines

 drivers/net/ethernet/intel/ice/ice_common.c   | 23 ++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 55 -------------------
 drivers/net/ethernet/intel/ice/ice_lib.h      |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c     | 44 +++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 54 ++++++++++++++----
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  7 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 ++----
 8 files changed, 109 insertions(+), 97 deletions(-)

-- 
2.34.1


