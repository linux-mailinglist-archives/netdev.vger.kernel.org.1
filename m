Return-Path: <netdev+bounces-99500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F838D5120
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25F01C225F3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED746556;
	Thu, 30 May 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5/iu49C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FE18757F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090805; cv=none; b=AykaqQitfO1xWx2SwDXuXguyUyR4CjpYdhx82yW3bnb0pSTriljxTBXuapugqbWBWoS5Z3/E/34o/6cCPr3sN3eqQjxAEeB8Z4df83qbLopiSpd7Glx2lpGVTXBEcaWEFxpM2cBszuE07PPi7BGHxDeDLN+wDrIL0mUk2hidnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090805; c=relaxed/simple;
	bh=lzf+r43xu7w2qX3kzjP+qMyZAJzLiLGXupv9+XWi/y0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jT1ntkFhUoZ5b1CuGOC42AiFHnfXhYKuxBDOhk1UWaZgXqo8krI2pIRCP/uZ541ETOrqdQgveX+IoKQSmEcOWFI8yxPj2Vv+6IHYapnvVpsXXY780tppIn7TOs9R9oJLFfQb+WDNDSK2BzLoL11qh82NPpWMAWiYSYLgeS/l3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5/iu49C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090803; x=1748626803;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=lzf+r43xu7w2qX3kzjP+qMyZAJzLiLGXupv9+XWi/y0=;
  b=G5/iu49CKOXU2ZAw6/hVDyVOz44MkxujS6cRWjY0w8lnGe+e9LxtOPAV
   +bBsYVcwW8TqJWre8BSOakRepTV5oMadV/h9pu6TY0j9ighMChKjFyAKo
   IehuG0GfjgZHfOoePbzOL7nYE0OPh7J+n8wwMWNYBDFthHjkj9MadWd7F
   HuVAZtbgvsdyZsr3DdCo9I3aDGinbJSSBBE3oPQIAOzfnhr+YQBI1126j
   lVoF1egl2yxk3xQBRLkXmBc1RgXn8MpMtOTxC3pILzC1Af0l1gainoqbg
   uiUopifTaVnQMtsEZlB1HaP3j+Gycgglk8DD4q26T7Zs1fJwg7zosZWAJ
   w==;
X-CSE-ConnectionGUID: MvNDrc85Ty+SW8sXb7y2+Q==
X-CSE-MsgGUID: jn6G/W0RSFmrahS9BGIlpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119252"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119252"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
X-CSE-ConnectionGUID: /vcvvof9QFyCxghSHKx4zw==
X-CSE-MsgGUID: sTLMPy0+TBScLV+6UOwUGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766667"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/6] Intel Wired LAN Driver Updates 2024-05-29 (ice,
 igc)
Date: Thu, 30 May 2024 10:39:27 -0700
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+5WGYC/x3MSwqAMAwE0KtI1gbqJ1S8irjQNmpAqrQignh3o
 8s3M8wNiaNwgja7IfIpSbagKPIM3DKEmVG8GkpT1oYqg4EP/ICGUCnh4PUPJ7k44ejI+YbIW2t
 BT/bIf6EfHegM+ud5AVCXhjd1AAAA
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, 
 Sasha Neftin <sasha.neftin@intel.com>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>
X-Mailer: b4 0.13.0

This series includes fixes for the ice driver as well as a fix for the igc
driver.

Jacob fixes two issues in the ice driver with reading the NVM for providing
firmware data via devlink info. First, fix an off-by-one error when reading
the Preserved Fields Area, resolving an infinite loop triggered on some
NVMs which lack certain data in the NVM. Second, fix the reading of the NVM
Shadow RAM on newer E830 and E825-C devices which have a variable sized CSS
header rather than assuming this header is always the same fixed size as in
the E810 devices.

Larysa fixes three issues with the ice driver XDP logic that could occur if
the number of queues is changed after enabling an XDP program. First, the
af_xdp_zc_qps bitmap is removed and replaced by simpler logic to track
whether queues are in zero-copy mode. Second, the reset and .ndo_bpf flows
are distinguished to avoid potential races with a PF reset occuring
simultaneously to .ndo_bpf callback from userspace. Third, the logic for
mapping XDP queues to vectors is fixed so that XDP state is restored for
XDP queues after a reconfiguration.

Sasha fixes reporting of Energy Efficient Ethernet support via ethtool in
the igc driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      ice: fix iteration of TLVs in Preserved Fields Area
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Larysa Zaremba (3):
      ice: remove af_xdp_zc_qps bitmap
      ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
      ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

Sasha Neftin (1):
      igc: Fix Energy Efficient Ethernet support declaration

 drivers/net/ethernet/intel/ice/ice.h         |  44 +++++---
 drivers/net/ethernet/intel/ice/ice_base.c    |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c     |  29 ++----
 drivers/net/ethernet/intel/ice/ice_main.c    | 144 +++++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_nvm.c     | 116 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_type.h    |  14 ++-
 drivers/net/ethernet/intel/ice/ice_xsk.c     |  13 ++-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   4 +
 9 files changed, 258 insertions(+), 118 deletions(-)
---
base-commit: 13c7c941e72908b8cce5a84b45a7b5e485ca12ed
change-id: 20240530-net-2024-05-30-intel-net-fixes-bc5cd855d777

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


