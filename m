Return-Path: <netdev+bounces-108579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60B924705
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E42B24A5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD1C2300;
	Tue,  2 Jul 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nm6J6bom"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71F1C0076
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943639; cv=none; b=LGW9PvqHMJH1WzCzeCuoSQAwT9eH5jIkSelWjY1/4ZeQso50Gy7WF3tF8PvITPzuShsm9LcqMWtSUO6kSeEWcxV4qAkDcbNumCAWLU/Yj6bBPj8Va1625qLV4fiULf7eahQHO4FSaY9mC2S4r9JLsd773uXdQuwAuUuRkiTKFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943639; c=relaxed/simple;
	bh=dCqnu8t3fT0qZWRP0dtNATAAv27qAuDInNG7wqZfTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrcapL39ihmvcnUzRP0svcRar0aQpek5xYPKS+/3kIuyRB5a8fzKGqM3IcdQcCEX6j9RrupXKcTa+jeit7XQe0E0Fjw4dQKmAwt2UOD9mWkyr1BQXCerb3jP3OgH0AdSyo/CftAnj6NYEzp2m/Rk4xa1UEESlxUFqS4F0Y1TAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nm6J6bom; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719943638; x=1751479638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dCqnu8t3fT0qZWRP0dtNATAAv27qAuDInNG7wqZfTxA=;
  b=Nm6J6bomeb9u/QqQpscpvc+sVHrXPj1vlIS389LYqnyaMNlp9KB1B1Gj
   K6hvQsG/2R5Qmg5QwTjHIhMskWNIUDSBa8kTUbqrDfOeAMdUmPH9A7GGp
   JUgcJ5fS6HsJ7mHDZyBz0lXCDIZcTHmLasmaeh7xIUG+o1jfJIr6OsyAR
   q8PwBjpj+grtBWAlbiyDTRA6Xlx9I1GARN29wB1Ebd15TMvuw561LElAY
   gdPW9ANsE6oXr8RM05DVwEH2pXvFsztO/IHbfsi3EvK3UNqPlnoeCayjI
   +Zh6Kh8ByssDYjpFYAN3St3PdN60OwFz/9YKtxUUW93ZL9ez45+Fq8F85
   Q==;
X-CSE-ConnectionGUID: ryGtq1u6T3e3kZbVNxujiA==
X-CSE-MsgGUID: Jw+qn9cFQ1qzIdJdSuf7mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16964031"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16964031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:07:18 -0700
X-CSE-ConnectionGUID: NbhZVzPQQVK4YB5uTPZXpA==
X-CSE-MsgGUID: SO9WPglkT3qfNyXU/GcTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50321222"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 11:07:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	anil.samal@intel.com
Subject: [PATCH net-next 0/3][pull request] ice: Support to dump PHY config, FEC
Date: Tue,  2 Jul 2024 11:07:04 -0700
Message-ID: <20240702180710.2606969-1-anthony.l.nguyen@intel.com>
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
number, pcs quad , pcs port from port number.So we introduced a
mechanism to derive above info. 
          Ethtool interface extension to include FEC statistics counter.
Patch 3 - Ethtool interface extension to include serdes equalizer
output.

The following are changes since commit ac26327635d643efe173e7460fa09eb39f0e5c54:
  Merge branch 'fixes-for-stm32-dwmac-driver-fails-to-probe'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Anil Samal (3):
  ice: Extend Sideband Queue command to support flags
  ice: Implement driver functionality to dump fec statistics
  ice: Implement driver functionality to dump serdes equalizer values

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 449 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 7 files changed, 669 insertions(+), 15 deletions(-)

-- 
2.41.0


