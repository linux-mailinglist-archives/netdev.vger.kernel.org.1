Return-Path: <netdev+bounces-87513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABD8A3600
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54611C2190E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F114F119;
	Fri, 12 Apr 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G45o9qcg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B914F111
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947903; cv=none; b=UAk5CEFCbYBA/Hi3g0cNT5FAdQzHgZnjL/Ye6C9zaP7d88I7f1lP5winq+ndsiEPfjVixEwX43SJB/g7QwTwJSBOUjFlOEDCKvxuPFYsAGWCFhvJ8yKarBcBHxGdRHYBkUdZHk3MsLXzy1Of6aAUJEJ2nsKKMkxKFquxhVpMQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947903; c=relaxed/simple;
	bh=tElETQhpo1xQDwAjQlAaYeaGzHUxKceJyXJlsyX7nCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U1X9yu8Nktajmw0E1bFtDPRzS2xbxk4Y2rY9EHyh3bJoRoOt9lQkugEZa24xuUX0ahMEtcWXHNX4dQ8zFBBJOb4+yyJ520GBH4IyCJ/JVlmxG/xQ6Lj65MJJT29aKYsQlp1S/dmfYYmHiQeLSqPAg/6S3/2Zt/js2cOjSI3+vJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G45o9qcg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947902; x=1744483902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tElETQhpo1xQDwAjQlAaYeaGzHUxKceJyXJlsyX7nCA=;
  b=G45o9qcgNEtbCUHphgoqrpio+74waGdOZlaJZJ/J+GIfjxOR2ySDdBFy
   ykcY5cqwd9B4yDKjx3hkrLp79Rj+wcXdDgf/DqGFHaXvV/JrlnB+1dVXn
   PKLrwDMx+qLoRw5C9VQBkHrO5JzD3IYuq0LErtrG+/Fe+OuYIZQedmHu+
   n3yPO6Ruupd32dtgGfG4m2llbrlnuZnP/0kBmGQwavi+Z70ck8JXRwuae
   FKbPkX86+SBKOxHYXrYEyuQWvcyUIzMvnkTkPhnMlcgTMdiSYkBxIuXaN
   SLSyERPNksyc39H5+Xi0Q8Q4vfeFshZZf7ijD5zMSGV6L1MVmVnnw1cf4
   g==;
X-CSE-ConnectionGUID: 0PrTBLb5SrGtYmNeTatcjQ==
X-CSE-MsgGUID: kxTHuv/eSPKgVkN6GZXuaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8333630"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8333630"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:41 -0700
X-CSE-ConnectionGUID: fFir2hx7S8ih3nSQffjrDQ==
X-CSE-MsgGUID: 4qiXO6vSSbKqQq9Sl716qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26108555"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:41 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	leszek.pepiak@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next 0/4]ice:Support to dump PHY config, FEC stats
Date: Fri, 12 Apr 2024 11:49:16 -0700
Message-ID: <20240412185135.297368-1-anil.samal@intel.com>
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
Patch 1 – Layer to construct admin queue message to read from firmware. 
Patch 2 – Currently driver does not have a way to derive serdes lane
number, pcs quad , pcs port from port number.So we introduced a
mechanism to derive above info. 
Patch 3 – Ethtool interface extension to include serdes equalizer
output.
Patch 4 - Ethtool interface extension to include FEC statistics counter. 

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  99 +++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 506 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  29 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  16 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 8 files changed, 726 insertions(+), 13 deletions(-)

-- 
2.44.0


