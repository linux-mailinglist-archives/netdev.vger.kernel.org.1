Return-Path: <netdev+bounces-222344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44907B53F2B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FD7BC780
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5E2F6562;
	Thu, 11 Sep 2025 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0aWyEUf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A92F531A;
	Thu, 11 Sep 2025 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634101; cv=none; b=dAPySPbndqyUtm1oTYUjLIfamWN6dgbMC9aIy7D0D903IEOKqLe65WpBA7fgiFyb8eBMUDcaDm0fc1+zCOYeo9CHZ6Zhq3JD4qUOA4qOOdYLFHoh/K4UzBE6oJ8LzYzwGR8K7Jds9JDgrEdmVmzbmHG7lfFhkmTSn1NJojhz+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634101; c=relaxed/simple;
	bh=0YsDROY4gTOp7UbeCY5Hr1hp6cHbhjW+j6MiWdqKxiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FZpysvOOopLc8SeTh5fwN5XIGAlVFSZxR3pa7UdQB43bWvI8bUUOpuIqFNE/ovi1YfEUY8hdGOpcrAz6KHjvZFlNj4Ct+SGRnZj5YT0jQxzdQ30S3TeLU0dcujoCmP+Ji4zH7ycuwIFKKPGV9O+h2lwsXEjPZmT04/pphmcH1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0aWyEUf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757634100; x=1789170100;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0YsDROY4gTOp7UbeCY5Hr1hp6cHbhjW+j6MiWdqKxiE=;
  b=i0aWyEUfcFCr7d/5cbG7H6FRh0i4u8yceRcwdo0Zs3zlVPdZCYP06a3R
   kFHEHjA5nze2tedk/5xplcNS99SoGGSUQjUa147NmpsO+lQonS1Zkm8S2
   BvZbvi8FKHTs0NTw3Tg7hloKfWYDx0PpzfPzseGewgXQsgHs9Q6BNIovQ
   sTznyS3F2P6M/FCtHc3Wy5QiuLhbK+43kGV2hy0DJfD5T2cW90le/RXGC
   xutSjENWBBxPTJtVwlDNAzhjJd9Wt05eptsA4aBc+FZKnjywzFBnUI8d+
   q1EH8kYyfPi7AvHWwQJzb0vbPvrPCACR5ZKBMPt1qc/tGTQ8i9ZhNp3T/
   A==;
X-CSE-ConnectionGUID: Vt1xKfm1Q4eP28ucvTD/Dg==
X-CSE-MsgGUID: ASxD08i6ScuX86wL95A7CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71354779"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="71354779"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:38 -0700
X-CSE-ConnectionGUID: ZZcvvu8aRtOUcouWrXsBfw==
X-CSE-MsgGUID: vebiGtscT3SdM3agTl7uCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="204589487"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 16:41:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 0/5] ice: add standard stats
Date: Thu, 11 Sep 2025 16:40:36 -0700
Message-Id: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVdw2gC/x2NwQ6CQAwFf4X0bBN2BRP9FeOh0AfWw2paQkwI/
 +7KbeYys1HADUG3ZiPHamHvUuV8amh8SpnBptUpt7lvrymxI1CUX4NLUQxsIziWyuL6hyX4kru
 uT8giOlENfRyTfY/J/bHvP5xXFap0AAAA
X-Change-ID: 20250911-resend-jbrandeb-ice-standard-stats-624451e2aadf
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=0YsDROY4gTOp7UbeCY5Hr1hp6cHbhjW+j6MiWdqKxiE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhozDcTpFBt2HXr1vWLv81pv1B3LifbmMnofWtc11610sm
 3r1a/C2jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACayfi3D/6IJHEca5lsGOam7
 xjyYuzqi851ffqjQ/QTX3xHvLluYODH8MysJ2v7fX6F3yXzW3YK3N1VeaHN4IJVb3x1usq/MXWM
 NCwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

I recently rediscovered this work while migrating data off of one of my
less used systems. The v2 apparently got rejected due to some test issues,
and its been accumulating dust since... *checks notes* over a year.

Supporting standardized statistics is important for usability and
consistency, so I thought it was a good idea to revive it.

The main point of the series is the implementation of standard stats for
the ice driver. It also includes a related documentation fix, and finishes
off with some cleanup to remove boiler plate code by making use of
ice_netdev_to_pf().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v3:
- Rebase from a year ago.
- Move standard stats functions in ice_ethtool.c to align with where we
  placed the ice_fec_stats function.
- Add a few more users of ice_netdev_to_pf() I noticed while rebasing.
- Fix the kdoc nit reported by Simon
- Drop review tags on the final patch since its got new work.

---
Jesse Brandeburg (5):
      net: docs: add missing features that can have stats
      ice: implement ethtool standard stats
      ice: add tracking of good transmit timestamps
      ice: implement transmit hardware timestamp statistics
      ice: refactor to use helpers

 drivers/net/ethernet/intel/ice/ice_ptp.h       |   2 +
 drivers/net/ethernet/intel/ice/ice_type.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 144 +++++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_lag.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c      |  13 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.c       |  15 ++-
 drivers/net/ethernet/intel/ice/ice_sriov.c     |   3 +-
 Documentation/networking/statistics.rst        |   4 +-
 9 files changed, 138 insertions(+), 55 deletions(-)
---
base-commit: 10ee8b756efd0913ef0ec6fc7a147771cdc36416
change-id: 20250911-resend-jbrandeb-ice-standard-stats-624451e2aadf

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


