Return-Path: <netdev+bounces-126696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8F9723D6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25A31C2371A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFF18B462;
	Mon,  9 Sep 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFnTZlab"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48F18A93F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914345; cv=none; b=nymW3/Q+XmhImJoEctg+5r0uWS66/MXVoDdNsTbRCF+uh/+sJhhporiUK6Xi/VZN+sT4XmX0WznI6cQMhqnRdgl0nXv77mPCGvWCISMp39vVv+VNQz4ylNsse3VuyqKaWRZp42O+PU0DXhoNWIBjq1VqR/y7QAqd8HWxcu3SibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914345; c=relaxed/simple;
	bh=2G4/YtFwjyFvC1lTYPmGCljOrGz+xj7f8Wkf2jf5BIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0E3qxQE6cm3XuUU0s7N2drzCWY1rQh8ffMySXMRPpivBmJ0bugYcfzByj40UKReQZx3EfzaWjYk/3FQGinNBoD+AZLbLcDdOCr1ZgQJtGPquusHZ1+s5Nz4A5262ZURtzbs3KtU9i1yv7mjau8/ZIRM8QPUY3MlvgtJnkI8+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFnTZlab; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914344; x=1757450344;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2G4/YtFwjyFvC1lTYPmGCljOrGz+xj7f8Wkf2jf5BIs=;
  b=RFnTZlabD5sGQW8I2mK8Ym6TPd+vwrlxvoH1QdDrEMskxSAT0E51UcXl
   k1CpBjWPY5I+tGnPCDGrV8NW37ebfzf0LzJiwAzCAgjmWqcFYMkSOUZpp
   70c2TYiBUe3M64FqUqR60BRL6jGhBtfIQ05wJFJ0fHQEvl5J0uo3IV3z3
   vNnJc37niX1iPOdHVeRhQ0FohpqALI9uE9DpklFQuyxcp1x31IyBaimIQ
   ZhsIJNERxg9tKKcRIwnb5b2txOtNwoIS5rMR90dQOotKCdZ7cTU7Qi0oS
   JgMmsat5GmF5oSgzf86muosIib9Z5c1ZgvWcU8kNREdwlnZqb0Uz4AXMv
   Q==;
X-CSE-ConnectionGUID: oAtCtwCEQOSBfP5kP5E9RQ==
X-CSE-MsgGUID: EZhICghWTjmWzzF8cKnuAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787072"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787072"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:38:52 -0700
X-CSE-ConnectionGUID: /YEZI6M9TPC6f/0u+t4wfw==
X-CSE-MsgGUID: ORCwU3lqQDSrVnbZRoZ63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054804"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2024-09-09 (ice, igb)
Date: Mon,  9 Sep 2024 13:38:36 -0700
Message-ID: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to ice and igb drivers.

Martyna moves LLDP rule removal to the proper uninitialization function
for ice.

Jake corrects accounting logic for FWD_TO_VSI_LIST switch filters on
ice.

Przemek removes incorrect, explicit calls to pci_disable_device() for
ice.

Michal Schmidt stops incorrect use of VSI list for VLAN use on ice.

Sriram Yagnaraman adjusts igb_xdp_ring_update_tail() to be called under
Tx lock on igb.

The following are changes since commit b3c9e65eb227269ed72a115ba22f4f51b4e62b4d:
  net: hsr: remove seqnr_lock
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jacob Keller (1):
  ice: fix accounting for filters shared by multiple VSIs

Martyna Szapar-Mudlaw (1):
  ice: Fix lldp packets dropping after changing the number of channels

Michal Schmidt (1):
  ice: fix VSI lists confusion when adding VLANs

Przemek Kitszel (1):
  ice: stop calling pci_disable_device() as we use pcim

Sriram Yagnaraman (1):
  igb: Always call igb_xdp_ring_update_tail() under Tx lock

 drivers/net/ethernet/intel/ice/ice_lib.c    | 15 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 --
 drivers/net/ethernet/intel/ice/ice_switch.c |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c   | 17 +++++++++++++----
 4 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.42.0


