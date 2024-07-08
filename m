Return-Path: <netdev+bounces-109918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B792A466
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215901C20F6D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115425745;
	Mon,  8 Jul 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYlzVwrH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE84430
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448167; cv=none; b=n/C5mBQU8LazHiQOpr5pt3jKEMHvTCRIifEsKP1FN5OaG7IC2apGPNkKJbesudCDOirngxbFwtod5VBU5uL8xE0BVCf8emAZMXiQ4V40H9WlAzzkR0DewanJN9murpvS0hql1V44vxx2FVB8FDQh6lDNwKEJMMRS/z3y8JXFNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448167; c=relaxed/simple;
	bh=CCx1ly+cK03YqLmNWgVOtp7jCYEU8Jb5LkCU0N+JVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jh1Wc44sfiFuSu9r7m0G5CPlKzW6669VjPyElciXIpgH/2Qm6HeTaxhnUJU6LBnLYdSDYG9mxdO3ZWKqbHoibg967BgALbV/1/8q1zMm68DRgPo32gKZzKuokldHqriBUUWn0m1r4o0ndQEO727d+JJhzEM1CBFXmoV3LlJqNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYlzVwrH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720448164; x=1751984164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CCx1ly+cK03YqLmNWgVOtp7jCYEU8Jb5LkCU0N+JVVw=;
  b=WYlzVwrH/zHh02VKN43+MKM8n9k6AtKkyon2vnBW+6UgzoQFs4jPL79A
   HZgcQ+sm5bnIY0CnN1CmJT+dpDBfMmE00HpkNlV1HnyXNHHF0QOxDTk7P
   aQYTm32wGP19Yz/PGSVucl6Sd/BPq1GjJlO6Y5xeO1GRgpBggj2mTwIo2
   Vfy9gh3WXNG4O+eEoZoj5LumXIbQC0ji8yyjX7RjT91J3ebQ6QCxXSzec
   TWlp3N4pvyxAFeluHa8zd/tG8q95Jonx0ixOFdy8ay4+o3Wf3UFMT6BGL
   6Pvbzm+v3ZbZN/Uyyn2QzVB+DbuD4i7GrHZlN9SAo1JuaM1RKee9ZvxbP
   w==;
X-CSE-ConnectionGUID: 7v5fjpfhTDqn0RnXczMDKg==
X-CSE-MsgGUID: qwdg8ybaRUOoMkv5JUEZaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29051626"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="29051626"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:16:03 -0700
X-CSE-ConnectionGUID: qoPmqMDYQXezNsBdsV1zCw==
X-CSE-MsgGUID: Pr8pk/5pRjinwgteqxOHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47946961"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:16:03 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	kuba@kernel.org,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next v4 0/3] ice: Support to dump PHY config, FEC
Date: Mon,  8 Jul 2024 07:09:17 -0700
Message-ID: <20240708141555.1327670-1-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implementation to dump PHY configuration and FEC statistics to
facilitate link level debugging of customer issues. Implementation has
two parts

a.     Serdes equalization
        # ethtool  -d eth0
        Output:
        Offset          Values
        ------          ------
        0x0000:         00 00 00 00 03 00 00 00 05 00 00 00 01 08 00 40
        0x0010:         01 00 00 40 00 00 39 3c 01 00 00 00 00 00 00 00
        0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
        ...
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

b.    FEC block counts
        # ethtool  -I --show-fec eth0
        Output:
         FEC parameters for eth0:
        Supported/Configured FEC encodings: Auto RS BaseR
        Active FEC encoding: RS
        Statistics:
        corrected_blocks: 0
         uncorrectable_blocks: 0

This series do following:
Patch 1 - Implementation to support user provided flag for side band
queue command.
Patch 2 - Currently driver does not have a way to derive serdes lane
number, pcs quad , pcs port from port number.So we introduced a
mechanism to derive above info.
          Ethtool interface extension to include FEC statistics counter.
Patch 3 - Ethtool interface extension to include serdes equalizer
output.
v3 -> v4 : Minor review comment update.
 
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 442 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 7 files changed, 662 insertions(+), 15 deletions(-)

-- 
2.44.0


