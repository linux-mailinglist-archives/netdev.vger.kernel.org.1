Return-Path: <netdev+bounces-147385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C697F9D9573
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D815282E1B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4A1C462C;
	Tue, 26 Nov 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho2lmOoH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E41C3023
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616604; cv=none; b=JfBv723TuJVOUaKBleoCqthbChfa2oKRdSH4ClTanf2RJTfOwUQ91oAF6y+KWFQjRNcELxnHIQX+UfmqU9YfT13pcEkSZpRvqXWPTJXqW8Yso8eI4AODw6WYqr/A9rGKOtb6pHRstMo5WvMk7VqB/kjw7nBL/qNOFbNNKsGd9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616604; c=relaxed/simple;
	bh=n6a3XWHLj2QtXMtCxgh8TrOz2Az4VwQNcGvNl7xz++s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9zSdf27BnSHgHEl1l2Gn2xjUFun6BQq+9fFPUgGTi4DvaN6iNbAZj/dcU4qV5xpZiKQETx7nnZESUah1XN3RfngBs6Z7ydcg/OMwPvHBY3DCASJgiP77/DDyDoy2VAT2tiTa/OxyHgNzKz6WCy92l565SwYNktUx+jE7XvKKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho2lmOoH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732616602; x=1764152602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n6a3XWHLj2QtXMtCxgh8TrOz2Az4VwQNcGvNl7xz++s=;
  b=ho2lmOoH/eAQ/Prfr9nbF1yXwREJOQ0S2zvCxnk9/xGEVC5WDGvEOfEI
   1p1ymkmv/jMp1mBBgiqlCF/aZOFNPpvnto3ysdJuVP0AqmkHWOFRXy86W
   Kb1bQnA8jtHET7NK+D2nbIRVwkqu4fPXuAmoo99zy4j8BfsrN7myeOiUs
   T1lPYOuuo3G1IHobyEJWGRqW6qB/jO9Q7Hb6EJgwGztV8RL2AmPEfmfhh
   o0KIgknEmlVOWlIyhOglByzH4yKlPhl6vD9uwsJUsdjxotiidxy6MQvzY
   0MIceRp0wd8F37le0wGmY1/J19ntFFtpmZxBzIGur6Rpu/gY/gkAb6JA/
   Q==;
X-CSE-ConnectionGUID: 1rU+0H4oRFCoCVeflsvaiA==
X-CSE-MsgGUID: Ao8cfq4yQNy+E9iF169zcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43430155"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="43430155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 02:23:20 -0800
X-CSE-ConnectionGUID: uB9L+wlcTvue8ff0F8sNpA==
X-CSE-MsgGUID: q3E0kIs+RzWJOBJVZIycqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="92037121"
Received: from pae-dbg-r750-02-263.igk.intel.com ([172.28.191.215])
  by fmviesa009.fm.intel.com with ESMTP; 26 Nov 2024 02:23:18 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net] ice: fix incorrect PHY settings for 100 GB/s
Date: Tue, 26 Nov 2024 11:23:11 +0100
Message-Id: <20241126102311.344972-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp4l application reports too high offset when ran on E823 device
with a 100GB/s link. Those values cannot go under 100ns, like in a
PTP working case when using 100 GB/s cable.
This is due to incorrect frequency settings on the PHY clocks for
100 GB/s speed. Changes are introduced to align with the internal
hardware documentation, and correctly initialize frequency in PHY
clocks with the frequency values that are in our HW spec.
To reproduce the issue run ptp4l as a Time Receiver on E823 device,
and observe the offset, which will never approach values seen
in the PTP working case.

Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 6620642077bb..bdb1020147d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -761,9 +761,9 @@ const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD] = {
 		/* rx_desk_rsgb_par */
 		644531250, /* 644.53125 MHz Reed Solomon gearbox */
 		/* tx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* rx_desk_rsgb_pcs */
-		644531250, /* 644.53125 MHz Reed Solomon gearbox */
+		390625000, /* 390.625 MHz Reed Solomon gearbox */
 		/* tx_fixed_delay */
 		1620,
 		/* pmd_adj_divisor */

base-commit: 6ef5f61a4aa7d4df94a855a44f996bff08b0be83
-- 
2.31.1


