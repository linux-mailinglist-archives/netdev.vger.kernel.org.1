Return-Path: <netdev+bounces-66955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B98419CD
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 04:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31901F242A7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AE36B17;
	Tue, 30 Jan 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cetHROQn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECA1E87F
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583836; cv=none; b=pqEfBpghV3TN9CC92Krkceo7sHxuM7DgUYe2zOjM3Flq3ka/6II0pEWC5OVOKYoIdLrk8GHSh0a++a7NdShBBG7lpk/8OfWhbpG54dhoiRXgf0OKjKY3XWC9Y9G4XVOUtukTdrSBqsBtmy7h4rSmt0Jl+5M2UqzfQus85XNLoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583836; c=relaxed/simple;
	bh=lzFLBAut8yM5tB+UhaTZSmCibKMmV25eq3SsNLBe5hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RKrNQBimuLdN+ldObjFSw/hdW3++FPBf/qXQH0eq5jyenHqlk3mox4v+A/n2RtCicKTE663mBBn5S4L+QY3FCW0Z/b2RiJF+TbdFN0IcvWNRdzXlBEF1PiXObV/8nfPiPTIMyb1lBnp9YH56E7NmK5zDu6CqGU3+prjGJa5wxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cetHROQn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706583835; x=1738119835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lzFLBAut8yM5tB+UhaTZSmCibKMmV25eq3SsNLBe5hs=;
  b=cetHROQnhL9hdd4jDd/Ar+UnjPzGq6KL/DxJhmZGQLxm8yiS9sw2I090
   lKeUJCEllO33Jpg740nVH0/msn9cGKPdKdYp3qtmqYrxfqpku+sZ86v9T
   w4xVQgktu0fgvMMuM/PZ/7slytW/WxRESx2eLwSyTK1cOHJriCKfcFDCQ
   SBvUE3jkMuRnRefL0bM9zVjVi1NUzkJfjR3TVxqeQzA4o4Z9Uytm3vkvp
   uehvwPBVYE4jBkSMDGF9+C6HVv1n5Jo9CbuIHr603LOSy9/76sRi9e6Nk
   tP68ywkx+BZPaDqfes7/AQl4I9yYxncRhJAS1aR+xKPX3mv707SzqvSSP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9892439"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9892439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3521609"
Received: from wp3.sh.intel.com ([10.240.108.102])
  by orviesa005.jf.intel.com with ESMTP; 29 Jan 2024 19:03:52 -0800
From: Steven Zou <steven.zou@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com,
	andrii.staikov@intel.com,
	jan.sokolowski@intel.com,
	steven.zou@intel.com
Subject: [PATCH RESEND iwl-next 0/2] ice: Introduce switch recipe reusing
Date: Tue, 30 Jan 2024 10:51:44 +0800
Message-Id: <20240130025146.30265-1-steven.zou@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series firstly fix the bitmap casting issue in getting/mapping
recipe to profile association that is used in both legacy and recipe
reusing mode, then introduce switch recipe reusing feature as new E810
firmware supports the corresponding functionality. 

Steven Zou (2):
  ice: Refactor FW data type and fix bitmap casting issue
  ice: Add switch recipe reusing feature

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 211 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 197 insertions(+), 32 deletions(-)


base-commit: f2aae2089368d8e5abb4ec01542c31bc4d011a74
-- 
2.31.1


