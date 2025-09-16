Return-Path: <netdev+bounces-223692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D86B5A12B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B834E221C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA8C25B695;
	Tue, 16 Sep 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi6l0DFO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59CB661;
	Tue, 16 Sep 2025 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050215; cv=none; b=STDmOU6R5k6TekYnwjTOFlD4THuTx0xAcfgPoot0z7uO7whFFpIhzmR4EGOV8R4UNAnntkxfIUqDFiPgQZFJPf9TcrG/JqWJzBDfS+JiHnJ8kV1L9z9PJMwQMTpmfxPLivDlB2AzWoIhzp+eZv2mspA88BeWroJJPL+U7Rr26Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050215; c=relaxed/simple;
	bh=rnnvGOspUX8LMCfMNzcnUQjB720Pd9PtIOQ/ZSdxyJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pMugBk/rj8vefFN83tPeTuvQBmALXr70eaqD2YLvSAV7wTpd+xPdOlCldcmLWGofZBg1J6zQnGHwghoOoLDe6eVNPOXvdES14Ahlbx0Sz4DKyQX9ZXfI5l27WnsaUlUBARz3deVMZVZfuxb+VJ25p5o/3BhGrOHiEO7U4VPiTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi6l0DFO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758050214; x=1789586214;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=rnnvGOspUX8LMCfMNzcnUQjB720Pd9PtIOQ/ZSdxyJY=;
  b=Wi6l0DFOcSgDBNiRkMAZqFZdM2s41+Qfek4HGdw4M8U6iu9fkLsPJGwD
   lrjf8pfqyzKShVhfCkJTs3fYmrcWCVK2cmf9fKIZif2DXA8mOJ0rnpDy7
   Wf9jFkqNT7aQR3D+KEGQObafccQT+J4nYRA4hGKxBBTb8SdEPMUxzDEtQ
   Q33VLVWW65yYx0yiSzdHPXMlCci6OHOc7ws2jDbaS0BVMxfIR7/5MTxXW
   MUZ8t4x1gQDXinFConSbkPbrd24FGZyWUHdgsVb0kkEaOcN+98FpYHYJd
   yp+FQL/o7DY7iDRQr6CJ4/T7xtx6nJ0V0FLfO/x0WpAMlT/LIwRwBs6xz
   w==;
X-CSE-ConnectionGUID: 9sVfK6s9TzSROSfY94Jyxg==
X-CSE-MsgGUID: LV8+2u/UTLSt/N5mjEvViQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60037570"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60037570"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:53 -0700
X-CSE-ConnectionGUID: Yu+J6Ej6QImXf/3Y9qD62w==
X-CSE-MsgGUID: MYUgQzR3Q4ibhM4wf0T4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174961751"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 12:16:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v4 0/5] ice: add standard stats
Date: Tue, 16 Sep 2025 12:14:53 -0700
Message-Id: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC63yWgC/5WNQQ6CMBBFr2Jm7RhaqEZX3sOwGNqpjMFi2gYxh
 LtbuYG79/KT/xZIHIUTXHYLRJ4kyRiKNPsd2J7CnVFccdCVNtVZKYycODh8dJGC4w7FMqZcmKL
 7QU541E1jFGsi56EcvSJ7mbfIDeQ9YOA5Q1uWXlIe42erT/W2/xOaaqxQddZ7p8yJyFwlZB4Od
 nxCu67rF/lEIYjeAAAA
X-Change-ID: 20250911-resend-jbrandeb-ice-standard-stats-624451e2aadf
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>, 
 Simon Horman <horms@kernel.org>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=rnnvGOspUX8LMCfMNzcnUQjB720Pd9PtIOQ/ZSdxyJY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyT2+cLqvBO2GF2xeSfn4fTIicL779z+ZWUn/W+0n1kx
 HA8k2l6RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPZupOR4afZqthLDWse35K+
 MfM/X2vZf/HD0ukG33ku6/XGbK/alsrw3/9y5Z2Jm6qaQ5WNTHT2Or46fcP986Owb08+FHB8D13
 TzwYA
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
Changes in v4:
- Add missing iwl-next target
- Pick up review tags on final patch
- Link to v3: https://lore.kernel.org/r/20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com

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


