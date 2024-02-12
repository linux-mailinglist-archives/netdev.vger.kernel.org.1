Return-Path: <netdev+bounces-70932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DA8511B6
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499C31F21706
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482A20B2E;
	Mon, 12 Feb 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbYPcgYg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1C383AA
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735814; cv=none; b=pLJkBlpBiboB7gMsHLGRskrfaE3jgRS40rg+jTUUUxTwZBJt3DL83XS7UMD4aPIfW1uXuzNbuoBu2KjiLpp2hwKZRHrMdd4LuQ5YIUa29h5/F93pHoGytbjMcQehyQ6ECSBG4ypdZiG51V6tow8Be1ckm7X8keiqdKC3tezziX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735814; c=relaxed/simple;
	bh=05Aq5i2ZpuWuLwfOfJcQmAVl42UYen4yCGuByyVY9uY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxQIJu+251aSTKAMJccb2TA89Cd6/L1f+QsGMNbrRgAyWdYOIAM6v6scJnKoInT2xQlIxSyZIDe/HC8l0wXP/Rc50Cum2GziOo46izJatLzfweG7YcOfRGfZRTtRaa8GrmjD57DxmvGeVBb4MBe2OtUW0XY9H67wgaizcYjHwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbYPcgYg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707735812; x=1739271812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=05Aq5i2ZpuWuLwfOfJcQmAVl42UYen4yCGuByyVY9uY=;
  b=NbYPcgYg3fOp46s5JUGLCXvDf60VK6JhWNbA5hX/+K86cvWYIShSsnvz
   4ALALdGxpMbW0ow2wgK5SfjmN6rRmh62ceySgSYjMBg9rwUmq3PNZkgya
   t9NR4z97pfFJsCMzfwRX+lYRdtb+kytU4j3LffWASDx49TqtiE8SVYVNL
   F+rz4WW3AVhupgTZO11WRIjRhseCAcC6vbA4s6mOYBt3FVXSpnf02y3op
   DVw9RUhbYyf8n4W5LutoS5T2KLhRG2PRkcNlDJvIC0sm8Erugcqub+0Ns
   g55lWpiWWBVwyBbtzTziEQLLmCu7UrHvPXBIE9YPIXqeZ22xL2OOO5xid
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1831223"
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="1831223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,263,1701158400"; 
   d="scan'208";a="7210921"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 12 Feb 2024 03:03:29 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.237.140.88])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ACC56135F7;
	Mon, 12 Feb 2024 11:03:26 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v7 0/2] ice: Support flow director ether type filters
Date: Mon, 12 Feb 2024 12:03:07 +0100
Message-Id: <20240212110307.12704-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v7: removed 0 initialization of static const array (omitted by error in v6)
v6: removed ice_fdir_eth and reused ethhdr, removed 0 initialization
    of static const array
v5: added missing documentation for parameter introduced in V4,
    extended commit message for patch adding flow-type ether rules support
v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 130 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 201 insertions(+), 47 deletions(-)

-- 
2.34.1


