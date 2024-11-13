Return-Path: <netdev+bounces-144549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F89C7BB3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14DA1F21763
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E12071E4;
	Wed, 13 Nov 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m98f1tk6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22A20694B
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524086; cv=none; b=BEACW4ESDievyPJcKHf1GqZgVqmEB8CjFxgGOE50+Kj7IKbSH0Shf0cohStuQBmSHh9iCv6Ctr0y6DE3LAWWQj/ErxB/eRAoC8qQYzupFkX5zoWd8GZT2Ln5DVKmX4LcLo5jy7Rom/SK8BclpP+nGNzek+lmB0xfoA3K1j9IZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524086; c=relaxed/simple;
	bh=D1O8kUiFXLfJ6mWqr73ZO4TxwJgA+Zo7KrZhsmLOFMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlpIFs5MU3NG+bkXwQEr7xRBP2F+HRNm+Ij1NA6DjzGpiUWQfI86iSfjFKntLYxIitpssPAHE2OVPN9SzC40apLKnqPM498CciTUZ8W9eCanOpgT6GlPynX5L86cydA9AC7oSKzMXhSyLbzwbCh0Re6MNUWYAKBHY4/XxDSKQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m98f1tk6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524085; x=1763060085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1O8kUiFXLfJ6mWqr73ZO4TxwJgA+Zo7KrZhsmLOFMs=;
  b=m98f1tk67EoQE9sGzkkflNt5fBUwPqKHzQqfrRXy7Fe7rLKzEI2xcP7J
   A89t+UU+DhQY2B6Tir2vCi+P8vLPeLADDT21KaLcDGaZPC4B6hccQfKtx
   6AWMBTPvUcz6VIJ+qSx7yM7UbpqBagcu9uvf4yPXWrB/jc3zV46n/bgKL
   0DxdEZCV3wQoSCk7onv5IduMRPL6iodcroHco92y+5sSbFDlkqb5h7vEJ
   ZmE62EQGsYY8rlFA91ACZoZYf6pZNhSdSr6Bgxf7o/DPOzD0Tz5GHgJt2
   m4ZC5mj1V4phmgJcrNIZaVNplMQoAovBav5IbKuxhMm3qlM7+Z68tZ0vm
   w==;
X-CSE-ConnectionGUID: FPtkVmQLSG+nA5TnjOUN2A==
X-CSE-MsgGUID: iD135i7FTa+5oPVJgzMKNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589521"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589521"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:42 -0800
X-CSE-ConnectionGUID: RyGf8qQNTGeJSS5rBzuo5w==
X-CSE-MsgGUID: 2PH1VBqiRD6uXQkQq2Ylrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520751"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	larysa.zaremba@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 09/14] ice: Unbind the workqueue
Date: Wed, 13 Nov 2024 10:54:24 -0800
Message-ID: <20241113185431.1289708-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
References: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The ice workqueue doesn't seem to rely on any CPU locality and should
therefore be able to run on any CPU. In practice this is already
happening through the unbound ice_service_timer that may fire anywhere
and queue the workqueue accordingly to any CPU.

Make this official so that the ice workqueue is only ever queued to
housekeeping CPUs on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f9301493e92d..cc8d2d6e2b4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5931,7 +5931,7 @@ static int __init ice_module_init(void)
 
 	ice_adv_lnk_speed_maps_init();
 
-	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
+	ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
 		return status;
-- 
2.42.0


