Return-Path: <netdev+bounces-107346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D701F91A9E7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C851C20F3B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749C5195389;
	Thu, 27 Jun 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUogo+Mo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DA3BB32
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500073; cv=none; b=m20fBGQkE7AjNDjz91KKTjBwSNUfjzI3qg3Za6UkH0Fhu+51BK3n6mAphKgX596dIOnAOosEyCefjyQkse+9QWROnJyglPcBXlsUpMGRuEgPjblnQeASJdJS2GMTAVzwUuhIqWraGRTxxjnSsTlhfjM6x3SXx3+GiYM5j+1jYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500073; c=relaxed/simple;
	bh=bNEOglout9SMjplcSItb/2ni81Kb2/DfFuwpqSFUEZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+OPkyHDCW9BmI5ZwILDiCB5GY8vYfds0wDkr3qe9s1b9jO5BE/hH989JdH8CCcu/L9Nfq16LaBWMxz5WI3kBYFqnfB7M6LMTdXzxv9vcRdEXDRyeChhtqiFHMSDqXaQi446mc/V43sAOjJ05KG04OIRn9ZDu3v5qAfmGZytcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUogo+Mo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500071; x=1751036071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bNEOglout9SMjplcSItb/2ni81Kb2/DfFuwpqSFUEZs=;
  b=FUogo+MotdBkpwauKg6AkMB+4k+XoFBHn2VddC+a55FfMQ4Ef/rZWVzc
   BwaF2FNH1B0A+kPDPo71VaVIykvg47FX0D/p7fb0cvtyL8pRSAX9mvDqK
   1xGF8Te+h9vfhFXK2OhwBPPKzBUtGDl5rdLKtBSzPIV3DDJp11SniPhSa
   pEofgep2IfDqAJxrFmyPPSYNwZOrxW3rQchVsYVpAcLjoB9VGLVnr4fhz
   eKYuWHFjJi0bwgmKXQnjSIK+CrPy1GmBa1l/p7tD9/q7e48/nHdjH2WUN
   B9Z2hSWkb2tinl3MOGs0+60TCxOfXH2iSvLeCGuaNE0hAWVbDhRE/t5/D
   g==;
X-CSE-ConnectionGUID: yTO+/71tSeSolBnaO9pZWg==
X-CSE-MsgGUID: ksOZDEzYSoycdHkkbRHVdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20514945"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20514945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:54:19 -0700
X-CSE-ConnectionGUID: ZtTLHv4ETYW0WhKSRdaG/w==
X-CSE-MsgGUID: EXEYlwofRm6nlx8oipiwEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67616366"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2024 07:54:17 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AE98627BB6;
	Thu, 27 Jun 2024 15:54:04 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v3 0/7] Switch API optimizations
Date: Thu, 27 Jun 2024 16:55:40 +0200
Message-ID: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the process of creating a recipe in the switch block by removing
duplicate switch ID words and changing how result indexes are fitted into
recipes. In many cases this can decrease the number of recipes required to
add a certain set of rules, potentially allowing a more varied set of rules
to be created. Total rule count will also increase, since less words will
be left unused/wasted. There are only 64 rules available in total, so every
one counts.

After this modification, many fields and some structs became unused or were
simplified, resulting in overall simpler implementation.

Marcin Szycik (4):
  ice: Remove unused struct ice_prot_lkup_ext members
  ice: Optimize switch recipe creation
  ice: Remove unused members from switch API
  ice: Add tracepoint for adding and removing switch rules

Michal Swiatkowski (3):
  ice: Remove reading all recipes before adding a new one
  ice: Simplify bitmap setting in adding recipe
  ice: remove unused recipe bookkeeping data

 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  43 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 674 ++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  20 +-
 drivers/net/ethernet/intel/ice/ice_trace.h    |  18 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 272 insertions(+), 496 deletions(-)

---
v3: Add tracepoint usage and exapmle output (patch 7)
v2 [2]:
* Nicify checking sizeof struct field
* Add a tracepoint for tracking recipe/rule utilization (patch 7)
v1: [1]

[1] https://lore.kernel.org/intel-wired-lan/20240618141157.1881093-1-marcin.szycik@linux.intel.com/T/#t
[2] https://lore.kernel.org/intel-wired-lan/20240624144530.690545-1-marcin.szycik@linux.intel.com/T/#t
-- 
2.45.0


