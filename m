Return-Path: <netdev+bounces-207261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B97B067BC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136365041A0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BF29B8E4;
	Tue, 15 Jul 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX+BW4cw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59228000A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611408; cv=none; b=KKAogIWJkpwlkRZrUmUo5cZFA/pgB10DeaGQ8ZyjxCucK+fTp5yOVaXkVnaFvRlPG2CI24nZYI6c/xuCdlH8MynxK0ONCZ6LbODU/vlad6zeVUzQNte1C0+RZEIS+j6Z9bqiVG4DrU8cW+85HtGUGQvVcNl/WdfkXIzSeDEwu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611408; c=relaxed/simple;
	bh=DF51Ija4aTi6aDT+XWtc4DwAwkeHZC1nY5FsBaDZsB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1plc3VIwb0xlLnSAGwVMMN0a3Jvt/cvejh1p6tFPw3uqhDC4RrGKqNz4OS+fmtQtZLEkldx0dP6DV+ogvrKR1ouQhrZ2Y9K6YD/hAr1SJYvEekLWyx7Vdu5GWUhYl8U6PbxeMUepcYY+npTCgmyk234Ubz0DlZb7XrseD/G7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX+BW4cw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752611407; x=1784147407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DF51Ija4aTi6aDT+XWtc4DwAwkeHZC1nY5FsBaDZsB4=;
  b=TX+BW4cwmHRVcSqKyl6TXAFIdYpsa+q7LbFRLz5dycndnu4jWUIqvRYK
   0plu9Phr2Pv84zjWGtgQNrFrZECRos125iGmoQ5WLTNHQ/lyTBq1ulXlR
   EDDs0LOjNp5JiUW91NxyXos8tLe2IfG8g2vGyUJfPQJUYQgWn1qROHA3G
   FhXaaLIG5VqU/YgRRs6FTf2riaesaTRJTbODTscLUc2cCiIhhoTMvLD2r
   tsq0hyODJLChqrt65W9XbfM7YDkuuKSwLKPAcibdF++Fc+9sjw6AiqqFw
   wJEE539hVVy1c/rOKgeDY+/S/xou9yMuJxxBkS6bpMVpuc2rIfkwfkSVa
   Q==;
X-CSE-ConnectionGUID: g9d4msQqSaif+bGL6Skh8w==
X-CSE-MsgGUID: 6EZYw65pRiWlouItg8HO5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54699819"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54699819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:29:58 -0700
X-CSE-ConnectionGUID: GdePXKMtTQ25WNap89ha7A==
X-CSE-MsgGUID: r4RctxcjTCutVINMhqyb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="194449521"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 15 Jul 2025 13:29:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 2/3] ice: add NULL check in eswitch lag check
Date: Tue, 15 Jul 2025 13:29:45 -0700
Message-ID: <20250715202948.3841437-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
References: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

The function ice_lag_is_switchdev_running() is being called from outside of
the LAG event handler code.  This results in the lag->upper_netdev being
NULL sometimes.  To avoid a NULL-pointer dereference, there needs to be a
check before it is dereferenced.

Fixes: 776fe19953b0 ("ice: block default rule setting on LAG interface")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2410aee59fb2..d132eb477551 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2226,7 +2226,8 @@ bool ice_lag_is_switchdev_running(struct ice_pf *pf)
 	struct ice_lag *lag = pf->lag;
 	struct net_device *tmp_nd;
 
-	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) || !lag)
+	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) ||
+	    !lag || !lag->upper_netdev)
 		return false;
 
 	rcu_read_lock();
-- 
2.47.1


