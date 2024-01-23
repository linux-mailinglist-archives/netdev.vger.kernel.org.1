Return-Path: <netdev+bounces-65018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5560838E09
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA39283EB6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC85D906;
	Tue, 23 Jan 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/g1gaKe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D657892
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011135; cv=none; b=kWDjLgmoIruCDfZQdqooCDy7IuptqXz93scXGi+WwkzPm8OKDCmdoMn/81KWRG8QnZimtD3oTWsQzwFDEHh8NwoFoUEt6gBZ8fYUQ7lvLHpk/1+ANLo2mfmRpdGhONB+FQBsW70G8ifM76Dm/TU8riWt57/DhNnSdzwcv8aJLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011135; c=relaxed/simple;
	bh=1bcccqTa96mUpHCwKNDIE1Dq4lVJdFzX/5s9BZMZVoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XRWaj6qediwiggjLAEarDQu0DO9Buuwb03vBRME8NTqIh2auEU6tBq/WSn0DT1tchI95zBQMLo3jA8NPtBWNhySdn3iJFSjZap43Tvs8TYb1jIAbZtedS/Tz0mpy/TjNmDrhMDvce9e0r2hfHmSEoxf6SCVxMc85putdzpIPDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/g1gaKe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706011133; x=1737547133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1bcccqTa96mUpHCwKNDIE1Dq4lVJdFzX/5s9BZMZVoo=;
  b=e/g1gaKeIPwphU653/wxTSxHGSEC3iLhMbZS0waOUgi/w5dzPEBkvVdH
   CtErcK3SqR4iJ77v6poumdLG46vZ4MzCRPECMetNNMb9PSvm/YG2JmFX5
   CAwgpBMAXGpHrX7DzILKKSR62/Lnj+tCBAmbQ/2vAqAfsaL5vHgODghAb
   wuR5HRbP1zNu5nCL6w2QatjGif6LVkAFjEm72LZ33hW1aOVQBL8kFR8pF
   /m5KjjeRAjbJKGFl6i4s4LAXBwRwgNFIbu5XDWDd7AxmFua5LVR903ePE
   BljYJk/1yUOAREAZrzC/jSWBVz270gNHeXpB6wa8WVqBZB6Tedlns5V2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22968558"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="22968558"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 03:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="27726675"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2024 03:58:50 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-next 0/2] ice: use ice_vsi_cfg_single_{r,t}xq in XSK
Date: Tue, 23 Jan 2024 12:58:44 +0100
Message-Id: <20240123115846.559559-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ice driver has routines dedicated for configuring single queues. Let us
use them from ZC control path. This move will allow us to make
ice_vsi_cfg_{r,t}xq() static.

Thanks,
Maciej

Maciej Fijalkowski (2):
  ice: make ice_vsi_cfg_rxq() static
  ice: make ice_vsi_cfg_txq() static

 drivers/net/ethernet/intel/ice/ice_base.c | 134 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_base.h |  10 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ---------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  10 --
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  22 +---
 5 files changed, 142 insertions(+), 163 deletions(-)

-- 
2.34.1


