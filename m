Return-Path: <netdev+bounces-94688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC75C8C0335
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CEC1C217FF
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9012D754;
	Wed,  8 May 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IESRWX5V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2212C469
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189636; cv=none; b=Ij3sWRJ8I1ttaHjgMBlfgkeTYkMpTQ8dw/NcWAhKOro73OTX31qoSPqvAL+26DMELut9YxidKdgWdRLE42g5s+Lt97kVsDCuBDSkZqgmSG+mXg9Z9plyXdphsizDm0SQAhYTY12ehmyLQfS+XVJKh4xesg6y63UlWW5PZ4sLLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189636; c=relaxed/simple;
	bh=S5kAvu7vvLLNh2OrPSKBV1yzdQzL7XdknFdkUe9c6Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkCFVtxigwn7tzMGkNvYXTwp0gXdaxeiL3FjM7Zp+JGtUIt48pLpv9F3gUF1faTfocv0jn7yjF3Ml9PFKGJB8TcXWerwZJqu7xxgLw4TG9ssHCU80puw9Ukly9+iiLd88essm4FM/mNNA8fyveE8UFgSao1+K599YYmTuqSG3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IESRWX5V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715189635; x=1746725635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5kAvu7vvLLNh2OrPSKBV1yzdQzL7XdknFdkUe9c6Oc=;
  b=IESRWX5VZuanFw2ifUFgxOBcSKfAk4yAN33IiAz6U1fSHrEvnLLaA6uW
   gZ6RK36vWZiHAWDPUTJFkA8vttL/6cVfeAGvKBBj2rsK92YcEboscZgq2
   eL5h4bOPmV6XtgLxB4vwxLV+YarHnP01bsp/hVL2FlDp1pAGpfAlA+sjE
   7ernqU4mydlLF8/kDGOf47sZfFHgaZJz8WgSnCj9nnL279GR+kD9CeXuc
   rLaA051d4W6tVODVGtxcdHRhfvlRl18b3M0RsvsU8yvVyCqFJ6dtA+cm/
   7uIBK1Va0Rryvbr/+QZXOnOdoMyHgVNvLCRb0jham8yi6zWFYjDhCa06V
   Q==;
X-CSE-ConnectionGUID: TNSNYiJNRE2Lb7x0KBYZgw==
X-CSE-MsgGUID: b7aN4xgPSM6P9EteyzsXog==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10938980"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10938980"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:33:52 -0700
X-CSE-ConnectionGUID: FohlTwPFR5OsuEqxfPJgWg==
X-CSE-MsgGUID: IsVsMyQ6RAmlL3JniZBw8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28843725"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 10:33:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>
Subject: [PATCH net-next 7/7] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
Date: Wed,  8 May 2024 10:33:39 -0700
Message-ID: <20240508173342.2760994-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
References: <20240508173342.2760994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

PCI_HEADER_TYPE_MULTIFUNC is define by e1000e and ixgbe and both are
unused. There is already PCI_HEADER_TYPE_MFD in pci_regs.h anyway which
should be used instead so remove the duplicated defines of it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h   | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 23a58cada43a..5e2cfa73f889 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -679,8 +679,6 @@
 /* PCI/PCI-X/PCI-EX Config space */
 #define PCI_HEADER_TYPE_REGISTER     0x0E
 
-#define PCI_HEADER_TYPE_MULTIFUNC    0x80
-
 #define PHY_REVISION_MASK      0xFFFFFFF0
 #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
 #define MAX_PHY_MULTI_PAGE_REG 0xF
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ed440dd0c4f9..897fe357b65b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2179,7 +2179,6 @@ enum {
 #define IXGBE_PCI_LINK_SPEED_5000 0x2
 #define IXGBE_PCI_LINK_SPEED_8000 0x3
 #define IXGBE_PCI_HEADER_TYPE_REGISTER  0x0E
-#define IXGBE_PCI_HEADER_TYPE_MULTIFUNC 0x80
 #define IXGBE_PCI_DEVICE_CONTROL2_16ms  0x0005
 
 #define IXGBE_PCIDEVCTRL2_TIMEO_MASK	0xf
-- 
2.41.0


