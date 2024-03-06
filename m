Return-Path: <netdev+bounces-77736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E5872CFE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863B61C265C8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10157C8C7;
	Wed,  6 Mar 2024 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF3uHeOV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB2635
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693438; cv=none; b=t3gUGf/alQDSEdCx4UqFxHb60MJgQlo2ARuVIKT2F83pnwLebsSXLFoK2lYbFlse116S/xSQrvBtBBbCkikU8jH999MWIhS55W2bhmXxYDO8yEC5sWe++nDUg8MMfjnAl08do926goF2HYRgS0z4OQAAheeqWjcPrP8zD/Z1yK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693438; c=relaxed/simple;
	bh=4QiwYzyIDPh9dLyrpI5WBB5yIvFVCJxZeRDGkfcvOyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulpY6z8bU2wOcmKH5ZfxrmZh3tNVa6uoTKtwea8yggHyt6blNnvxmMg1yDPTtIbfExvs1l6RdJ1O3adVFTWRHZtYy5oBvSsqPXebVNycpDN05CxkScFI7ZYY/VfeH/VTLwaIeCHuYRbjASjTMSNH/QJGG7Vg56u0i2E91MzLMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF3uHeOV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709693436; x=1741229436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4QiwYzyIDPh9dLyrpI5WBB5yIvFVCJxZeRDGkfcvOyM=;
  b=fF3uHeOVvzy5keoDa268JST6HHOqKbRy/f1M2kphFniR/B4KLqbXYgWd
   Sdw/GKihuQu+0jgcgk2CYkm5fiy7Qc30o3q+SF/1kXt3QVhekR1KR046L
   uxW2djdF/96lWsyWY+0J0x0WXTAhHTzomaMRX6DqJxAo0GlR9m733zdua
   dWJcAtZ8+ye50hykue0qVez4/8BFfVtFH0AJag0p6ngvu99KZ/iu36XZ6
   LYO9eADDK2zChe3B9GD9Jkx/IOs6cfg+Il1em6MLD8GJrtUr+7uQyYokp
   ymX6y6Oz7vHNgpjnBWtyVlTnautVSiX1D8g0w5HIsFQvyjUYWGq6WdsP2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="21741373"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="21741373"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14088531"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:50:29 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pmenzel@molgen.mpg.de
Subject: [PATCH iwl-next v2 0/2] net: intel: cleanup power ops
Date: Tue,  5 Mar 2024 18:50:20 -0800
Message-Id: <20240306025023.800029-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do a quick refactor of igb to clean up some unnecessary declarations,
noticed while doing the real work of 2/2.

Follow that with a change of all the Intel drivers to use the current
power management declaration APIs, to avoid complication and maintenance
issues with CONFIG_PM=<m|y|n>. This is as per [1]

Mostly compile-tested only, the ice driver currently has a bug in it
that causes a panic that is being fixed via -net.

Changes in v2:
- ice driver simple changes added which go with this series
- igb compilation issues of the patch when standalone with CONFIG_PM=n
  fixed by adding missing ifdef, which is then cleaned up in 2/2

original v1:
Link: https://lore.kernel.org/netdev/20240210220109.3179408-1-jesse.brandeburg@intel.com/

[1] https://lore.kernel.org/netdev/20211207002102.26414-1-paul@crapouillou.net/

Jesse Brandeburg (2):
  igb: simplify pci ops declaration
  net: intel: implement modern PM ops declarations

 drivers/net/ethernet/intel/e100.c             |  8 +--
 drivers/net/ethernet/intel/e1000/e1000_main.c | 14 ++---
 drivers/net/ethernet/intel/e1000e/netdev.c    | 22 +++----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 10 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 10 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
 drivers/net/ethernet/intel/ice/ice_main.c     | 12 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 59 ++++++++-----------
 drivers/net/ethernet/intel/igbvf/netdev.c     |  6 +-
 drivers/net/ethernet/intel/igc/igc_main.c     | 24 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  8 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  8 +--
 12 files changed, 78 insertions(+), 111 deletions(-)


base-commit: 60d06425e04558be21634a719b5c60c9bd862c34
-- 
2.39.3


