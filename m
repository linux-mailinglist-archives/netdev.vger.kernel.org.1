Return-Path: <netdev+bounces-98783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DC8D27BA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D8B1C216D9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1513DBBC;
	Tue, 28 May 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/k8/9Qm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C113DBA8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933980; cv=none; b=IZDibOEKCZDQoV+UEbvUwUoNQjD2LC4hDTBI0m0UQq6TKV1HbkJGVPmTd83WAdsS5SRbyrYIrFC1r6Gp0mBtg07rSrLa6M739VTnIoPi6pFXIIYhxd0dH7meWHRndICHbkt2GWcUX74ViL5cnlVnRVaPFLTbgVM8xvqW8x8M0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933980; c=relaxed/simple;
	bh=X8/XSgipI+hKgmdTNwjmfbt7DhDPve0g7MKKcLxFI9s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6iVUTbEKIH6hYbxMUg8RCauJYlu5FrnQZR+IlX49CT3znqXhcnEb2rv385Nhc+Uxf24Do/B+NV56eOLDCAIjjmn5xfYSUmwU+Hnk6jEpw52066XeMLgf1dQRprI1Ql6uMUK9OQUVvQzeBuwQgpfiOb3NQdKUjNlMUQJ/yl/oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/k8/9Qm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933979; x=1748469979;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=X8/XSgipI+hKgmdTNwjmfbt7DhDPve0g7MKKcLxFI9s=;
  b=B/k8/9QmWinZbkHpgPKasqU3vsxVp7G9qHDadoud2W66GKf5NDgejU+W
   hYUeIDidB9tDeIism5DJGcEAPMVQCp9IYht1Db4zXqXRcmzDz/X7MUkP/
   WGgKaqMzKaeHU44FGPD5+UewzP0i06Pbn2zHYfiX+tjhU7UyqdjxXr87W
   oknj2kRgv7/HeU7HQ2GTzNug2c35lOssAeI8Km0rU9BoArL54VL0T0fYN
   fub2IlgvmA3RBbIYOsUZgXZW+9HOrS9M4tQixexAtMP3Tw/aDulPb1Xhx
   H3xBU/2VIDjodVE4BR7bFu/diqtg0zyto8+JQYUJWIpDMxljCMuAS+bQZ
   w==;
X-CSE-ConnectionGUID: P+iSVayFSjivstgFCOz1iA==
X-CSE-MsgGUID: +apI1bVMQp6Z2uvX6qWV8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439592"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439592"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
X-CSE-ConnectionGUID: 36b4xg0iSB2uLO0OPVuFVw==
X-CSE-MsgGUID: RkZyKNVbSIqbu5zFNqZURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087510"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:17 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/8] Intel Wired LAN Driver Updates 2024-05-28 (e1000e,
 i40e, ice)
Date: Tue, 28 May 2024 15:06:03 -0700
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtVVmYC/x3M3QpAQBQE4FfRuXZqbRZ5FbnwMzilpV1Jybs7X
 H4z09wUEQSR6uSmgFOibF6RpQkNS+dnsIxqssbmxtmKPQ7+wMaxUvyB9Q8nuRC5GJ1BBVv2ZUF
 6sgf8hX40pDNqn+cF8HgDrHUAAAA=
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Hui Wang <hui.wang@canonical.com>, 
 Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 Naama Meir <naamax.meir@linux.intel.com>, Simon Horman <horms@kernel.org>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
 Thinh Tran <thinhtr@linux.ibm.com>, Robert Thomas <rob.thomas@ibm.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 George Kuruvinakunnel <george.kuruvinakunnel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Brett Creeley <brett.creeley@amd.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Dave Ertman <david.m.ertman@intel.com>, 
 Lukasz Czapnik <lukasz.czapnik@intel.com>
X-Mailer: b4 0.13.0

This series includes a variety of fixes that have been accumulating on the
Intel Wired LAN dev-queue.

Hui Wang provides a fix for suspend/resume on e1000e due to failure
to correctly setup the SMBUS in enable_ulp().

Thinh Tran provides a fix for EEH I/O suspend/resume on i40e to
ensure that I/O operations can continue after a resume. To avoid duplicate
code, the common logic is factored out of i40e_suspend and i40e_resume.

Michal Kubiak provides a fix for i40e XDP in if the user tries to rmmod the
i40e driver while an XDP program is loaded.

Paul Greenwalt provides a fix to correctly map the 200G PHY types to link
speeds in the ice driver.

Wojciech Drewek provides a fix to ice to resolve sporadic issues with
downloading the firmware package over the Admin queue.

Jacob provides a fix for the ice driver to correct reading the Shadow RAM
portion of the NVM for some of the newer devices including E830 and E825-C
devices.

Dave Ertman provides a fix correcting devlink parameter unregistration in
the event that the driver loads in safe mode and some of the parameters
were not registered.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Dave Ertman (1):
      ice: check for unregistering correct number of devlink params

Hui Wang (1):
      e1000e: move force SMBUS near the end of enable_ulp function

Jacob Keller (1):
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Michal Kubiak (1):
      i40e: Fix XDP program unloading while removing the driver

Paul Greenwalt (1):
      ice: fix 200G PHY types to link speed mapping

Thinh Tran (2):
      i40e: factoring out i40e_suspend/i40e_resume
      i40e: Fully suspend and resume IO operations in EEH case

Wojciech Drewek (1):
      ice: implement AQ download pkg retry

 drivers/net/ethernet/intel/e1000e/ich8lan.c      |  22 ++
 drivers/net/ethernet/intel/e1000e/netdev.c       |  18 --
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 277 +++++++++++++----------
 drivers/net/ethernet/intel/ice/devlink/devlink.c |  31 ++-
 drivers/net/ethernet/intel/ice/ice_common.c      |  10 +
 drivers/net/ethernet/intel/ice/ice_ddp.c         |  19 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c         |  88 ++++++-
 drivers/net/ethernet/intel/ice/ice_type.h        |  14 +-
 8 files changed, 319 insertions(+), 160 deletions(-)
---
base-commit: 56a5cf538c3f2d935b0d81040a8303b6e7fc5fd8
change-id: 20240528-net-2024-05-28-intel-net-fixes-6d50e8e27b76

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


