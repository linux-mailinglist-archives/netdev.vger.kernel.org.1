Return-Path: <netdev+bounces-99892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32348D6DFD
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 07:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301191C2180C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 05:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6BA94B;
	Sat,  1 Jun 2024 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSxvJ/im"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB3D304
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717218369; cv=none; b=iUvUud6LdQ4pzVPS9B+KA8cE9gjmGQ12asr9YMmW7TpEmY6i8vzj7AEtoFtp6peToGiahU57558i6cbnnFgRsNe/qUqIhYOMyCNi7r7ffVunF/YM7Lsv5gobIES7Sov0LSlmOZl1mbxlympOMHdCJEbvU5AkWHAfImWvj/sTfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717218369; c=relaxed/simple;
	bh=VTMW35vEjpM/QHpe8flrpNOsuPZ/GSDAzkaNqO8kDJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0jOZsCyc38qfKdKGfAN/45KyZXDgiXGsuAt0TgOSEbAs9vhsvR3N1PWW7ld7j70vfUXBYMAyixl5ZRE8vC382PM921AnEntQCbSOzjsROmOowX9PCMDF3xDTc2rL+gUHLAtTKvmVsxJOGi+VeLWm8dvngWtKv7kj+Now3P0Vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSxvJ/im; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717218369; x=1748754369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VTMW35vEjpM/QHpe8flrpNOsuPZ/GSDAzkaNqO8kDJg=;
  b=OSxvJ/imIwPIdLoY2dq3VmJBHfTuNBOjtyrCfdVPDyX5dPSkkBCsEyAQ
   2QJhAK0RDq9ijjtfocnu61vswSLyoQ6wcWao2YuuE/ayWeVs9WGAmwVAb
   RLHMJwSAO9VwjlFzPVAzFszzzZuXcWjGsl9ws1/+gz4OmFwqxYyn4Upjs
   gYok+Z+KWa4/5tkNzev3Xe2UClK05WKOZsOEPlRsiT/aTpJHOYtBtzZQB
   jliUW5u2/AKqEfT1lH+RT3qK8UYa/5xNSUh4sRqbXkPm7y+gPP6bS6pnZ
   850oLqQndjOyOhcS1oSHXml491KF6k9W5y1adDwD2FCuwp5tCgu5vr96F
   A==;
X-CSE-ConnectionGUID: zoqL1LGkSO2Ngf4BsI55jQ==
X-CSE-MsgGUID: NVObdTKZQYyzE7XNRlS9tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13617883"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="13617883"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:06:06 -0700
X-CSE-ConnectionGUID: TsnPq5hSQE6SquLzxWy+YQ==
X-CSE-MsgGUID: F6s4g2OvSFecWpLHIkmYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="41286992"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2024 22:06:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D54A718E; Sat, 01 Jun 2024 08:06:01 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Corinna Vinschen <vinschen@redhat.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] igc: Use PCI device pointer in logging in igc_ptp_init()
Date: Sat,  1 Jun 2024 08:06:01 +0300
Message-ID: <20240601050601.1782063-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
References: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in the commit 86167183a17e ("igc: fix a log entry using
uninitialized netdev"), the netdev has not yet been registered so we get
weird log entry like:

[    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added

Fix this by using the PCI device pointer instead, that's valid and
available at this point.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 1bb026232efc..c4a5ddbe6f34 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1169,9 +1169,9 @@ void igc_ptp_init(struct igc_adapter *adapter)
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
-		netdev_err(netdev, "ptp_clock_register failed\n");
+		dev_err(&adapter->pdev->dev, "ptp_clock_register failed\n");
 	} else if (adapter->ptp_clock) {
-		netdev_info(netdev, "PHC added\n");
+		dev_info(&adapter->pdev->dev, "PHC added\n");
 		adapter->ptp_flags |= IGC_PTP_ENABLED;
 	}
 }
-- 
2.43.0


