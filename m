Return-Path: <netdev+bounces-116279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B41949D09
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E496B2138F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2B801;
	Wed,  7 Aug 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuAWdrsT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FE1DFCF
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991006; cv=none; b=NkEYjpU7ZSCjwDIsJnyBn8MUdgLamJ2XRT7bXChcdtt7et7bClzkRUC8rwID4tO8dQb+SK6SFoIpryT3Ul4wbRFaEYKAUKS/3OwgIKXq9Igu7WJ+zlMezpLlGYGP4PF6kGgp3b73zfDoIa+4c0betPJdDaGO+An8W83JLcuU0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991006; c=relaxed/simple;
	bh=QV9+GvHg6bYaP7NQb66ksRUUQwp1mzozYO2yGfHEd2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGtIH45LMrQgdyrDWIOpESwpQjf2Hb82dsq7eMh0B4gcuguindxWeq+czNtPxTIlZiGwPbWgWPzz5weE+5WMQw/AQvU62e9aH9dDNzFQoRK9q1utpI2EEEYzyrsrlv7P8dXb8OxRrpadul0XXavopjwkSrv1TGnl6+2VWQEWguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuAWdrsT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991005; x=1754527005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QV9+GvHg6bYaP7NQb66ksRUUQwp1mzozYO2yGfHEd2g=;
  b=BuAWdrsTYlFSbXZiYO4y6/ZL7lrpd4D4vmzTVZAmqwNH4pb4Vl93ebb2
   NKDkkkR46FYuUxYcbyb00Q9l9e1+5G8hZzrZcP2C2yDXev+kgoSnad/Kf
   Lux7cokJcjvUVrxrE+FrLGA+h4D664+aYLsgcZ8gc3yoyH/9LBbAkl16h
   iscqfzGqkBy0DeOVDmvhCEt8lFen0hC2qQCiQeNOr1wzTllX8WMQjHbMW
   oEFB6Av3nWaTLo6gvBkL0EgPTKVSNmnNGeVl7ZjPGEiYwI74+ggw2xWEN
   0DGZjsMUNBWVSB0CxEtrY/zUEw1VrzXEPHEOzOz2U4TAAYHAnbZ0yBT/B
   w==;
X-CSE-ConnectionGUID: qqOS2hyESZisvPrIjFnQwQ==
X-CSE-MsgGUID: bQo1K4XfSMSOj56VR+szfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669739"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:44 -0700
X-CSE-ConnectionGUID: 39nmRel1SXOo3mtdz+TAyg==
X-CSE-MsgGUID: 26VQOEdjS+yVeQdGg53hsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61496981"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:43 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v1 0/5] igc: PTM timeout fix
Date: Tue,  6 Aug 2024 17:30:27 -0700
Message-Id: <20240807003032.10300-1-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

There have been sporadic reports of PTM timeouts using i225/i226 devices

These timeouts have been root caused to:

1) Manipulating the PTM status register while PTM is enabled and triggered
2) The hardware retrying too quickly when an inappropriate response is
   received from the upstream device

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Christopher S M Hall (5):
  igc: Ensure the PTM cycle is reliably triggered
  igc: Lengthen the hardware retry time to prevent timeouts
  igc: Move ktime snapshot into PTM retry loop
  igc: Reduce retry count to a more reasonable number
  igc: Add lock preventing multiple simultaneous PTM transactions

 drivers/net/ethernet/intel/igc/igc.h         |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 100 +++++++++++--------
 3 files changed, 63 insertions(+), 41 deletions(-)

-- 
2.34.1


