Return-Path: <netdev+bounces-103594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381F908C27
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22923283548
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119B199EB5;
	Fri, 14 Jun 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed0zcBBX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705E1990C2
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369985; cv=none; b=R6Wu267tpIwIRFHtTZa+AiMxckaJ9B1M08n0Oh9L/PF4XK4S4lwCJvEqhSLo6G+0A97YAiHpiKLQHiXrpYvAHjGyI62TJad9bm5zcmtnAu4x8/o1dCaBAZ+pzhU6BN9KMLZux7rX2J+kenpxZjb8mcr0rnTOx7hWBlToqoMfY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369985; c=relaxed/simple;
	bh=02+m0Z/OMq/ZIVZ2UEQx+MfnnammXXAg4bkjeHmvZeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsPKICehjkdD105U+7BMQkjf2NSDo7AqUfW7QjW76PPQxMC6WKtcWYJP09IZ9B/4+3twq9U7nf98GhPI9Fo4NqXBcTncM8Yr0yW0Qvouoo1Z/DOol5jI4fUztCEHlIDOybp4UYc8N3V622mOzrY/FULlKBneQsF4znw2uPkBUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed0zcBBX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718369983; x=1749905983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02+m0Z/OMq/ZIVZ2UEQx+MfnnammXXAg4bkjeHmvZeM=;
  b=Ed0zcBBXlOYuJHQ8Q/n9WqQk0fEN3Rn+gokwQr0zJxZ2slsSuhrzq3Gp
   dM+OKGb2zP9aYsj2GbmgDhUDPsq250BrLpMPnTSi+cGhTz+FSO+5B2rQM
   Rjfxwj1Zf95YlSULIBK5yxwwK7JhFCN2w+LW6LV1svjPWVkwnaC9/+BO2
   yxFB4kUR9jaZjpZtPrGz2VmwfJw/R+nlreByw9RoI8Vy6ROXhDGa9YKFG
   aJFTX2vmR0UkpOrb4LeSPlRlj7YvBShMXn6RV6gWqwrgrUG5lnQ69iGI4
   cq+7sPPC8DV7LoS1Wz3sQJaCO7FpTBt336yy8oHRJaCdc4v+CFLSir/3i
   w==;
X-CSE-ConnectionGUID: jlP9ZmOAT4OgOFVf+fgn/w==
X-CSE-MsgGUID: LZNJITLES32EDWDJKoeE3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="40669471"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40669471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:59:43 -0700
X-CSE-ConnectionGUID: eTTcyTIZSSSKcxxBm7s6Jw==
X-CSE-MsgGUID: zzKKVR2qTyiqkjeDdprhcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40593799"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:59:43 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next v3 0/3] ice:Support to dump PHY config, FEC 
Date: Fri, 14 Jun 2024 05:58:14 -0700
Message-ID: <20240614125935.900102-1-anil.samal@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 7 files changed, 669 insertions(+), 15 deletions(-)

-- 
2.44.0


