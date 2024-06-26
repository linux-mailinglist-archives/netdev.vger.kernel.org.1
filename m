Return-Path: <netdev+bounces-106920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633591817B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7308DB20B2F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5A181BBF;
	Wed, 26 Jun 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgKPni5B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D37180A61
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406578; cv=none; b=evgTauokAEzzGs+YC6hHByAACseTEKLGKEhl/H/ENpUCkXz8sCuMx8Luoq69oLdQ0Bf1Q83/CGJxQc1Y3AxHLOWdyuNunlVtvmzCc9ymcUNQsRjPIP2jKb1S6dhGrpHTUfLPlzi3e7QvItRUarel6ujUZC6qo25AnaVlVAYTZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406578; c=relaxed/simple;
	bh=4dDZAtv/P+cz8g4CQVaX7gFO4RWR7K7m4WW1uqJlRBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn36jaoC4r44ghPvNAx3BAJuNGDhXBaGuqE4OkAosywCYEWzos1yjNGMTF/P2LyDvewYpyfP3MjjnWEXwj9qxfjbHRJgXrhOxuJs/mH+9txQTkCZrnOanTmKfXAwQz3bSL2/9byFjTNYQ+FrbCAKbzy/GYlLqqVuRe4sPkM6nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgKPni5B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719406577; x=1750942577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4dDZAtv/P+cz8g4CQVaX7gFO4RWR7K7m4WW1uqJlRBk=;
  b=HgKPni5B8nIDethzVlY2z5b2ZBMcDWDlBZnVUz0Yyh6vrvWe33K8YHRm
   IuKOi4295vwofZOEGoNXD9S3X/NLM4vr54FZi07eXDWegp3y1PNIqKbO0
   mvCLib3Zf3a3nafUIKBrk8MgT4L/rmp4sawqvS2wztcpEPQeBJlz4f7nG
   BQ+56rQBsWooNGtjCqot6KEJ+FlKL1nZjUTDOJKMnDyR9Ptppjl84EkTI
   kQ6te8vuJZVaPA5K8u1N+0QgCo4lfaeZ8kCYGZMgUXmfLZo40P5hGp6XM
   Vs3uUX4SyeHHJZ3LPE+a4B1LBh1rT99w1gU1VorUkUbvf5y8H8PT6Rmua
   Q==;
X-CSE-ConnectionGUID: EaJaMHtnStaP0rgpL2EOfg==
X-CSE-MsgGUID: GwGWMyy6Qmylb2snQf7hww==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16158097"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16158097"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:56:16 -0700
X-CSE-ConnectionGUID: opfgUuZ/RZCfUsj+V/yywA==
X-CSE-MsgGUID: xc1pVhtoThqISx/PVGX9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48594629"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2024 05:56:15 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v2 0/4] Replace auxbus with ice_adapter in the PTP support code
Date: Wed, 26 Jun 2024 14:54:52 +0200
Message-ID: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces multiple aux buses and devices used in the PTP support
code with struct ice_adapter holding the necessary shared data

Patches 1,2 add convenience wrappers
Patch 3 does the main refactoring
Patch 4 finalizes the refactoring

Previous discussion: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20240624/042430.html

v1->v2: Code rearrangement between patches

Sergey Temerkhanov (4):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 337 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 112 insertions(+), 309 deletions(-)

-- 
2.43.0


