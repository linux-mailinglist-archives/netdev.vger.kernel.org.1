Return-Path: <netdev+bounces-110423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F98B92C48A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C0A282AD3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01056185607;
	Tue,  9 Jul 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dulGShrP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA014F108
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556999; cv=none; b=WuyWj1hIJgdar4xb6OP6Yk/gNx5TXvqXc5k4HoL+IX2+NQdbbz6WplMHSKtgXDo8yGhqUMPPzV6mbFc8Jp2BDARuTUxmBtNMvoRr6peWoCkJvXRPdA8AmFrGLl6LHomsisMtAjlFmbbAFBKeLcs+0FsKY3Mt96OHHCKtWaXgwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556999; c=relaxed/simple;
	bh=RLbcm5r4wcs0MnYW1N6BQc5e5x2+1u7s+nHtkyDLasA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhmEC1rk9IFVsZTp6CYfSYnYUVAnqaeCOKQtEHXOnBSB4CNN/5yL9ChEawf9vvUSxf6xF+lA+QW8w3Iqw8NFulX0Uc2FXqTH/H+qmYSUKqLSRmEF4FtziUZpPT9INbYh2Fcp8ps8JZAJq1i3UDk0b1MB9xy9CM+7AlezY78USLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dulGShrP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720556998; x=1752092998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RLbcm5r4wcs0MnYW1N6BQc5e5x2+1u7s+nHtkyDLasA=;
  b=dulGShrPM318PN7ICaF3M2zPHcmtXajdi3S5og6P/E6HLhR2O+huNiX/
   SNiQRtalNEX6qrbcY9PBf/cd/LwcbZTLAWcDRXB0tvQIhFM/f59YxpgLR
   fOg5Ba6FL75TsSNAIIUliMhYH18j1kz3buCYzwmMNGLcAia2Z58AyXGGu
   6w+Vge8FOfVfBQ19q6WVYIqS6z8phjKAzFoGP0Eai6Lyw2Y7ux5CH3KRE
   qY+DD1PXVh1MYQMfr/Ygd72yyjLK9rmN9/GtQXyZHE6N6ZO3rA3bqueW0
   F9hzWFyf0F38H3O/WUhlgYavNsTLmyWDRb1IZ5xqEkHYvIA6k7OQhhQeE
   g==;
X-CSE-ConnectionGUID: 2bmpm/AKQ1azIIe5foFZmQ==
X-CSE-MsgGUID: GHNYFWIwTvaSP5vwDqCBIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17680599"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17680599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 13:29:57 -0700
X-CSE-ConnectionGUID: YwPi8f4iTD6P6CCnb8Ov0Q==
X-CSE-MsgGUID: n0DQueotSwCQl/uvnEcVCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="47886345"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 13:29:57 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	anil.samal@intel.com
Subject: [PATCH net-next v2 0/3][pull request] ice: Support to dump PHY config, FEC
Date: Tue,  9 Jul 2024 13:29:46 -0700
Message-ID: <20240709202951.2103115-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anil Samal says:

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
number, pcs quad , pcs port from port number. So we introduced a
mechanism to derive above info.
          Ethtool interface extension to include FEC statistics counter.
Patch 3 - Ethtool interface extension to include serdes equalizer output.
---
v2:
- Remove 'hw' null check and combine '!pi' check with latter check (patch 2 & 3)
- Remove unneeded braces (patch 2)

v1: https://lore.kernel.org/netdev/20240702180710.2606969-1-anthony.l.nguyen@intel.com/

The following are changes since commit 7b769adc2612b495d94a4b4537ffaa725861d763:
  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Anil Samal (3):
  ice: Extend Sideband Queue command to support flags
  ice: Implement driver functionality to dump fec statistics
  ice: Implement driver functionality to dump serdes equalizer values

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 442 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 7 files changed, 662 insertions(+), 15 deletions(-)

-- 
2.41.0


