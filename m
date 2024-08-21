Return-Path: <netdev+bounces-120581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3A959E38
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FA51C21F80
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B9196C86;
	Wed, 21 Aug 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbFcbd45"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1B15FA92
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245909; cv=none; b=op1FSZ4LJRKfj7i3H3OeF0yWTVb+gIHQV4/NSoYYiYK2asvEdwu7qv84b6Eoi4GOfxzlz8HQGPGzNqKxJHHzzaa8URsInBbK3wpCDEJRIxnLVe8iIL/y/1AFWAsXR5YsS5zwUgGKLxtH9ZA2iUzTOuvlcg8f4Tn8WVfuQOxCvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245909; c=relaxed/simple;
	bh=3nO8mVl8Okwbqvile2/ShvLyJ0BVQQbqzRLYurYDto4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqmC55h4w/qAZkvMwUqTdhxljDL7Mxrog/GMTCi8rKnjS7zliTJAHAbbm6eGcxtlG2pid+2cNIz/RZl1aNw7eu2SMZXFCtqnaM2LegxuoZ9XDCBiClUqJVMucGv91AkNolsDIu1/sC6Oanalve7niu6bL74G9kJtO5M7Vftr5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbFcbd45; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724245908; x=1755781908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3nO8mVl8Okwbqvile2/ShvLyJ0BVQQbqzRLYurYDto4=;
  b=NbFcbd45h0+x8IA3nnTi08kEFmnvbYWrW2eaB0sb+gJxZGJXsCGPQrRs
   lYedbmHESNjt2AnQe9xkFUTw1nF4MGNscNboIXPS377KCbDA++FPon3vd
   KHpksu4759mNEZ/gLPjpsvheVYWzCvYRhYo9PJ/SETu5+Dcg3xKxFLWNP
   oquaR2ybAm1zlNYVTCn9CZzPeRE3JoTmsLJh18ZZk05QMIbdgm+341CAC
   ipg06kAIS284VDw45h2uAOpgOb2brGw+Us0Zm0mM1uAKyznNl/7367hg/
   +4il8ly+7imJ252Xyf79Xl/CRMcZg0/qgtrO6gwgyOtnV42Sakm98xvpB
   g==;
X-CSE-ConnectionGUID: VU9hz7wlQnelYl0iXLi7ow==
X-CSE-MsgGUID: i7Jk9Z9RS+uvv5lAlhBj4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26356918"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26356918"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:11:47 -0700
X-CSE-ConnectionGUID: crgoxB1mSXGeAjoTh7b9Gw==
X-CSE-MsgGUID: tSzqEzsySaKNc3lUQeclPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65432359"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa005.fm.intel.com with ESMTP; 21 Aug 2024 06:11:46 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v6 0/5] Replace auxbus with ice_adapter in the PTP support code
Date: Wed, 21 Aug 2024 15:09:52 +0200
Message-ID: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
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

Previous discussion: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20240812/043278.html

v1->v2: Code rearrangement between patches
v2->v3: Patch cleanup
v3->v4: E825C support in ice_adapter
v4->v5: Rebased on top of the latest changes
v5->v6: Minor formatting fixes

Sergey Temerkhanov (5):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Initial support for E825C hardware in ice_adapter
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 340 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 129 insertions(+), 311 deletions(-)

-- 
2.43.0


