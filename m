Return-Path: <netdev+bounces-207956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F4B09275
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E21A623E6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1C2FF477;
	Thu, 17 Jul 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiMreQPB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBB2FEE32
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771465; cv=none; b=gsWxOp8wPWoaaT6B7M4NbSr0C9tOa1HfgNymm9qU7S3Sutn4pNgt1h/BicJsm/F2wQOeyPI2wwzzw0m72+TA67sjVLaN6niPuNUpyvMpXGd8cJYEUzQ9+BGaA4BUdOtR0XEx2PB0FAvlkgkJAJn+70zLQix9YT76iGBZ9rVO8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771465; c=relaxed/simple;
	bh=R6ZIJbG5oiO2OVRSdh2xmX6TYpkdnjtkWsrRFvDZ1sw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ig4rfUjx7t9fnICdAwsF80uxtw5rIeXOdR9tJGdGYOGiWqUDmzMyqQdF9u5Q9GOOPzlw0ywFmocVy0FqI710GXS8Y3IU4hmO3Bm8D0bxjQDXxl0Ci5gwJ0tP9fqCr5m/jUN1xsO/T0pADrXfKkAS5hy8Q1g4hadvKujz5J2LLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiMreQPB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752771463; x=1784307463;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=R6ZIJbG5oiO2OVRSdh2xmX6TYpkdnjtkWsrRFvDZ1sw=;
  b=EiMreQPB0J59zjEBfqbdDLB+kpjiEqW/Hfk5xABKQTrWYSeqMN6WzQMK
   7cJmTrzCSHagUiKOlWorAz6/6p/UdFRMOvvAYtxZbQTFNTAq5toAp9QFf
   NhEC7rWRwom47Hhef+FXgF7Can8kyMCgSqOG/WdThMQXQhWnv9du/+q/X
   2zIlPeGnMQzMZ3oIVddFm1Siwbaj2SK9mADQrBVUo51hUDGaaRlRvKeET
   xI2DZZwyrmD+HhLL8K3ngET1bFkPxg4G9FQMWuaNm9FDii9NGyO+Qv8nb
   x3l2wkEgKkiQM2iiwLY+nuCmhbqeGYvQmDokQQkNUK4nYg5EnL/v58Hea
   w==;
X-CSE-ConnectionGUID: 6j3l2zebS6mUPDOnoYcW3Q==
X-CSE-MsgGUID: GjgM98BdRN6mduuigsywDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55211383"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55211383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 09:57:43 -0700
X-CSE-ConnectionGUID: OHe/S9e2Rgmd6vz9FMqp9g==
X-CSE-MsgGUID: gYiBZbCKQGG/xu+Vej/mAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158199866"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 09:57:42 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net 0/2] ice: fix issues with loading certain older DDP
 packages
Date: Thu, 17 Jul 2025 09:57:07 -0700
Message-Id: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQreWgC/x2MywqDMBAAf0X27EKS4oP+inhI3VW3rVGy2griv
 xs8DsPMAcpRWOGZHRD5JypzSGDzDLrRh4FRKDE44wpT2RLfHyRaUH3POM2UvOrGSKV9mFfd1c4
 UkOIlci/7PW5A/l8MvEJ7nhcuVLQzcQAAAA==
X-Change-ID: 20250716-jk-ddp-safe-mode-issue-d6130b8c8205
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, vgrinber@redhat.com, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=R6ZIJbG5oiO2OVRSdh2xmX6TYpkdnjtkWsrRFvDZ1sw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoxK7aYqR5MtIl9LjFI27L7zMvWuycabBnfMFpS84W87s
 bDvppVcRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABO5LsDwVypKTSDhAKvYE4sj
 z6YKHY9znb7arUok95bo7+2bV2gbdjEynEgxEV7KLCkT/9g/ar76xXOtwalXg45s3v1uunSXe/t
 nTgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

This series contains two fixes to improve the software handling for certain
error conditions when loading an older DDP package on a device. In
particular, some combinations of DDP and firmware version can result in the
driver accidentally locking the device up due to blocking the global
configuration lock used for DDP programming.

Also, fix an error in the cleanup logic for a failed probe could result in
memory corruption due to a use-after-free from double-calling
ice_deinit_hw().

It is not clear if any publicly released DDP versions suffer from the exact
issues that caused the ice_cfg_tx_topo() failure. However, it is entirely
plausible that the error could be triggered in the future. Thus, it is
important to ensure the error flow is safe and won't make the device
inaccessible for such tasks as updating the firmware. Additionally,
degrading functionality simply because a user has not updated a DDP package
is wrong.

I settled on -ENODEV as the error code for handling ice_init_hw() failures,
to ensure probe stops in the rare cases where this fails. I am open to
alternative suggestions for how to handle errors from ice_cfg_tx_topo()
through into ice_init_tx_topology().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Jacob Keller (2):
      ice: fix double-call to ice_deinit_hw() during probe failure
      ice: don't leave device non-functional if Tx scheduler config fails

 drivers/net/ethernet/intel/ice/devlink/devlink.c | 10 +-----
 drivers/net/ethernet/intel/ice/ice_ddp.c         | 44 +++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c        | 38 ++++++++++----------
 3 files changed, 53 insertions(+), 39 deletions(-)
---
base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
change-id: 20250716-jk-ddp-safe-mode-issue-d6130b8c8205

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


