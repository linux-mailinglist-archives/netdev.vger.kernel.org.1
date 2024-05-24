Return-Path: <netdev+bounces-97970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA28CE662
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7850FB214E1
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3203D86656;
	Fri, 24 May 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk9FOELo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C312C47F
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558786; cv=none; b=F2mRa5ywm/9xmaV5yuLck7WsbmOjIBkDvxKO/nadfVCkdKwKr66ySa9iAFl7GE5i9DdPe9VTOHfYpdxEagfjkT7+GinAboUR74xf15bhzIFdHt1nENyvsxU5P51o5Dc19uLn3cHkA7/RInjdP00sF7avSSskTcwuMZ7GREn+ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558786; c=relaxed/simple;
	bh=vp8mVpHVZr18u4xtphEKzFCH3Q2PP6Da3DQzHv5eyB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAat7iuDnTQ09iuQ/Zu6ne0FgkT6KYrgNDe8dS+D+0hBs4vOuLquoT6rhkLXCYOusXhWV+IoQeKf/UqvMcd/sfnhomeRWGVenO3LJHu8vjVFPU3G4qH4ULR2PxvBzeIfbfq/r5ZvxWf4lzVzRUXUh7AIB2SaAuLK63Tt0hkan2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk9FOELo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716558784; x=1748094784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vp8mVpHVZr18u4xtphEKzFCH3Q2PP6Da3DQzHv5eyB8=;
  b=Rk9FOELoxIvvsdut+dgRLqRI7y+6haL3oi42/xWWUu9cbaXibA0LO4RQ
   peLk5TUxWSm+go+d3z/K8UT4KN1gMu+jVBbGbHNW8IezZ4B70XnYRQ1Ix
   n7y8kA/0Zj90hvb77TXnzGAWrZ4iEtWHzwtuP9nrvOnGjx0uZegxVjNu6
   G3D830ZSnotNb6WVOwSf/680nBOM4hMFUUMFzcCDA1c2igBTBiaolReKH
   NPBmLHjUFkK7i2RAWFe9FbBe2Esjjdkz4EJBCJt3j/0/+U+Y6stbQysmL
   Q6dVRls29NElrtXWmgqM2/8reEfosQF0cUMmXh5SkLMehZe78aIf/oxDL
   w==;
X-CSE-ConnectionGUID: PVbd4bYSRsy07e97rE+Hvw==
X-CSE-MsgGUID: 86DG9pTVRsK7eT/pE489Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13111906"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="13111906"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 06:53:04 -0700
X-CSE-ConnectionGUID: KbJy5UDOSACNI2VG/kaYcg==
X-CSE-MsgGUID: /VbFvpGzSraqOwReQ/fYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="64837185"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 06:53:04 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next v3 0/3] ice:Support to dump PHY config, FEC 
Date: Fri, 24 May 2024 06:51:04 -0700
Message-ID: <20240524135255.3607422-1-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Implementation to dump PHY configuration and FEC statistics to
facilitate link level debugging of customer issues.  Implementation has
two parts 
  
a.     Serdes equalization
        # ethtool  -d eth0 
        Output: 
        Offset          Values
        ------          ------
        0x0000:         00 00 00 00 03 00 00 00 05 00 00 00 01 08 00 40
        0x0010:         01 00 00 40 00 00 39 3c 01 00 00 00 00 00 00 00
        0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        ……
        …..
        0x01f0:         01 00 00 00 ef be ad de 8f 00 00 00 00 00 00 00
        0x0200:         00 00 00 00 ef be ad de 00 00 00 00 00 00 00 00
        0x0210:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0220:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0230:         00 00 00 00 00 00 00 00 00 00 00 00 fa ff 00 00
        0x0240:         06 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
        0x0250:         0f b0 0f b0 00 00 00 00 00 00 00 00 00 00 00 00
        0x0260:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0270:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0280:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x0290:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        0x02e0:         00 00 00 00 00 00 00 00 00 00 00 00
Current implementation appends 176 bytes i.e. 44 bytes * 4 serdes lane.
For port with 2 serdes lane, first 88 bytes are valid values and
remaining 88 bytes are filled with zero. Similarly for port with 1
serdes lane, first 44 bytes are valid and remaining 132 bytes are marked
zero. 

Each set of serdes equalizer parameter (i.e. set of 44 bytes) follows
below order 
    a. rx_equalization_pre2
    b. rx_equalization_pre1
    c. rx_equalization_post1
    d. rx_equalization_bflf
    e. rx_equalization_bfhf
    f. rx_equalization_drate
    g. tx_equalization_pre1
    h. tx_equalization_pre3
    i. tx_equalization_atten
    j. tx_equalization_post1
    k. tx_equalization_pre2
Where each individual equalizer parameter is of 4 bytes. As ethtool
prints values as individual bytes, for little endian machine these
values will be in reverse byte order. 

b.	FEC block counts
        # ethtool  -I --show-fec eth0
        Output:
         FEC parameters for eth0:
        Supported/Configured FEC encodings: Auto RS BaseR
        Active FEC encoding: RS
        Statistics:
        corrected_blocks: 0
         uncorrectable_blocks: 0

This series do following:
Patch 1 – Implementation to support user provided flag for side band
queue command. 
Patch 2 – Currently driver does not have a way to derive serdes lane
number, pcs quad , pcs port from port number.So we introduced a
mechanism to derive above info. 
          Ethtool interface extension to include FEC statistics counter.
Patch 3 – Ethtool interface extension to include serdes equalizer
output.

v1 -> v2, 
   Squashed 4 commit to 3 commit. 
   Removed extra null check of arguments.
   Removed initialization of local variable that are not required.

v2 -> v3
   updated the argument for sideband queue function from "flag" to
"flags"

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 449 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 ++
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  16 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 8 files changed, 669 insertions(+), 13 deletions(-)

-- 
2.44.0


