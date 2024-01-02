Return-Path: <netdev+bounces-61035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6F822486
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671FA286D9B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D8217728;
	Tue,  2 Jan 2024 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJTgrTS+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD417735
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233082; x=1735769082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxor/egSox4XR8I78NCPQArIaM/GEtu+wz5bCc42e+I=;
  b=QJTgrTS+XcWA5rH1CfI75rYxnlXQRPGadPduMmKCFIXWxrKHmdvyGG06
   l7+gSFPHdDOnifQP3pDOwgOKdmWLjGX1r10svvgz/ca1UxuFxelLZviZ6
   cC1pnbXixJpol9RCz3Qz1Ejd6k4X7I4T3lfkVdSERcsoFPkwi83kXBgfN
   iUc4oHLYu+KswNmg8thDIHT0ahb/zqkkMJGhD8khPOw++9/ItqrwSmcJv
   6L0j5xafZ3uvuKlFjs2cnZZRiX1Bm920wVVxUB92wTnIkr7ZGS9Uch4Ez
   9bpM3V56TwfRLMTKb26FNuylmjSSvjspNJN8IsEEf6bWckzpH0dFW5keo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567906"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621421"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621421"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 7/7] ice: Fix some null pointer dereference issues in ice_ptp.c
Date: Tue,  2 Jan 2024 14:04:23 -0800
Message-ID: <20240102220428.698969-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index c4fe28017b8d..3b6605c8585e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2863,6 +2863,8 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
 			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
 			      ice_get_ptp_src_clock_index(&pf->hw));
+	if (!name)
+		return -ENOMEM;
 
 	aux_driver->name = name;
 	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
@@ -3109,6 +3111,8 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
 			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
 			      ice_get_ptp_src_clock_index(&pf->hw));
+	if (!name)
+		return -ENOMEM;
 
 	aux_dev->name = name;
 	aux_dev->id = id;
-- 
2.41.0


