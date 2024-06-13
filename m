Return-Path: <netdev+bounces-103301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6344907773
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8761C24BAC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D314B96A;
	Thu, 13 Jun 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci4EQ1a4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7614AD0A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293526; cv=none; b=n1pNEG9ETXUROzDpq9cpfVqNpAMJKemHUp5Yd26GOrg1E98BBsUwwxK5YZPMBalWGscwgRHpaXCmMnDc2xSjIPmm3Ie412ub5Ar1TWpgxxFRfE/rmHPShfSLr1rPV+LG4iI9UP/df6AVo8NjW7sfbVNZ+MU0gpcxamPEc8Q+kOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293526; c=relaxed/simple;
	bh=pJgk+4GFxhSP9n+1P6GfF3XIwj+YEmPeHsu9OPdKcTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpBZ8Qqw+SGeC23nHLog9uCQK2dXUshYL+NQeS0TOl4oqoW24b3ynWUA8yYmywzQiVb3ZGU6IEX/4B3FVTEG8DhkGUrtZVORWOgkFCdpMV+daZWVIwz9LWWd/oTCmYIBVKb3qJlS8BAe620s31EanhHhmJjKm3m/PAv9HTGzUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci4EQ1a4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718293523; x=1749829523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pJgk+4GFxhSP9n+1P6GfF3XIwj+YEmPeHsu9OPdKcTo=;
  b=Ci4EQ1a4iM0Iqj07KL1T4GHGaEsHT1m66h34uGDK3Yvp8gPRgk1r9GV5
   k/RPT5lPRrsUmFFF1gzK2fMj1fMT02j6UG9a6o91PazluCn065Whwwh15
   e4yIQBqwKp7GOVaGt3DtfI5SM+LR5P9Cs3BXrCPZflV3rSHr0MZhruxvD
   1oPjYllNsr01RgBQqMKi/var223ubzYmz5ty7qNou1crlLaj2QMOmRXzi
   6vPb9q2YCujBySrNJ6Mb5Hw3qUufDbx8dbE1tqtmWAt1uc0Bxh7X59uRB
   GWW16GBhQZh/k0e6h7BqAuzdRY3jZoZ1qPrhKXlOBiT8NLjsDQj2SCoCI
   A==;
X-CSE-ConnectionGUID: J517xLuYSPqRNY+yhkTgAA==
X-CSE-MsgGUID: TlliEPd2SYaqiBX4ARZ67g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37645766"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="37645766"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 08:45:22 -0700
X-CSE-ConnectionGUID: DLOEzH2GTyC5iXud5enF5A==
X-CSE-MsgGUID: sHcJt3W5RNKWCoCd6LRC2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40124495"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Jun 2024 08:45:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 2/3] ice: fix 200G link speed message log
Date: Thu, 13 Jun 2024 08:45:09 -0700
Message-ID: <20240613154514.1948785-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
References: <20240613154514.1948785-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 24407a01e57c ("ice: Add 200G speed/phy type use") added support
for 200G PHY speeds, but did not include 200G link speed message
support. As a result the driver incorrectly reports Unknown for 200G
link speed.

Fix this by adding 200G support to ice_print_link_msg().

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 45d850514f4c..1766230abfff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -805,6 +805,9 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	}
 
 	switch (vsi->port_info->phy.link_info.link_speed) {
+	case ICE_AQ_LINK_SPEED_200GB:
+		speed = "200 G";
+		break;
 	case ICE_AQ_LINK_SPEED_100GB:
 		speed = "100 G";
 		break;
-- 
2.41.0


