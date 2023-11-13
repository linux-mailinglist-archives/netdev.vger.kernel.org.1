Return-Path: <netdev+bounces-47498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF87EA6AF
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07BAB209DE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021773D3B4;
	Mon, 13 Nov 2023 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+986XbY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C372D61A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:06:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ACAD6E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916761; x=1731452761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+H+Ru987IyatZHo8cHU48yps7moqJMWXhkN4pNpUIm8=;
  b=E+986XbY+crM6cEBAE6NIUIyERTekp1P/XhuQtGUmR/SdlZme3CwP5x/
   bTpZ2HzIDNRH0WRm2TH5n2dNP01H437/KcYmJNLv7MM5rYApKORDPbT1U
   wkXYxy+BK2M5fbaJTyArpj4stORbaf7SeQovc7iEfq2IBlol60wRTdh/m
   anDB1//2USUg2w3NcaPyjEVtv4CZVZtY8imHG36mJxrCAZNqZPnhDlLRz
   k679kRt7pvRcRf96vsdin6kBtzu7WgcHaY6PYqQZchNsVa3Zco7LWQ1gl
   qnfrcdZHHCqV5oc8G48aUgIGaloYNFQR09CTLVfD/scwXikq7Qkjk0Q78
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421633156"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421633156"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12598039"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 15:06:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/4] ice: dpll: fix initial lock status of dpll
Date: Mon, 13 Nov 2023 15:05:46 -0800
Message-ID: <20231113230551.548489-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
References: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

When dpll device is registered and dpll subsystem performs notify of a
new device, the lock state value provided to dpll subsystem equals 0
which is invalid value for the `enum dpll_lock_status`.
Provide correct value by obtaining it from firmware before registering
the dpll device.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 835c419ccc74..607f534055b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1756,6 +1756,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	}
 	d->pf = pf;
 	if (cgu) {
+		ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
 		if (ret) {
 			dpll_device_put(d->dpll);
@@ -1796,8 +1797,6 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	struct kthread_worker *kworker;
 
-	ice_dpll_update_state(pf, &d->eec, true);
-	ice_dpll_update_state(pf, &d->pps, true);
 	kthread_init_delayed_work(&d->work, ice_dpll_periodic_work);
 	kworker = kthread_create_worker(0, "ice-dplls-%s",
 					dev_name(ice_pf_to_dev(pf)));
-- 
2.41.0


