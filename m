Return-Path: <netdev+bounces-108565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B59244D1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8457F1C22464
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B41BF330;
	Tue,  2 Jul 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/XnotXN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4821BE22A
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940508; cv=none; b=LEWbK0NMGa/72ztfZCfH4KCrIx/8C8SVIJLvfPWXDHvjhjbhib+4Jh/UTl+DtJMrsu/F/9NCd8njN29m4z04ErI1WhAz2WNMGH0OETlf3kaWK+ZUHaKnOLflhR3zng3UOtSlEwv8BsOKqSbRh63TzALYpoS5JU2P6emCM86/NT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940508; c=relaxed/simple;
	bh=fnJQnTOh6rOBc/JjC4l6zK3yrL4IXLPEWg4f5HDzdZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL6IS+KlVJeDPnmqIvi7mbExtWp5cYDthd1bUgZZFiCy4SdR+K0wvX/CU7cHUkZ4gRfalafD3VxwWjZXSRlDbr2jXZaNiQUyh9uCGyfpchNUckH3Z1H4CAazc/EleK/tPlx5ILkRMizlLXnWDmLkhe9SHUQTmX3jUjKDSg2X8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/XnotXN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719940507; x=1751476507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnJQnTOh6rOBc/JjC4l6zK3yrL4IXLPEWg4f5HDzdZ8=;
  b=a/XnotXNuMfHMWtEAUEK8MnxJtz0tyqC+ZcuztU5yEilJiMf3Y9lNKhK
   Oa4IkA4HyKF9KHVz95IFX/q+27pAU3V9YnrOsKXad/54yrTTpn7Wuuz14
   6bxIpOrgZfseHSOWr0zd8mia3GEZEI46udDZLAUL+x2AuFJjxvIef9X+Z
   54gsF07GpCmQUM/q0xczVfy4/JQjhmq09pMGPORZ/no2Lp24YK1u4Xc66
   N5f0z6j6Gt5QctDjGehAa6lQIjEM4ovzeqc0QbpIZTZvRuaFrdDLzaLan
   QBh0xSAigqCCAcMt7qBIAF+kBoN94BnOX2eaZEPwc1xqo2Oe014leadiD
   w==;
X-CSE-ConnectionGUID: irBsGGtOQOqsZDnMsxYT0A==
X-CSE-MsgGUID: nioriiuzTuOzkrz335BRTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20032344"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20032344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:15:04 -0700
X-CSE-ConnectionGUID: riqi0Kp+TLe3HRfd3EAZVw==
X-CSE-MsgGUID: e40+ftCNQQKJY+WOBVA1wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76708765"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 10:15:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	Ivan Vecera <ivecera@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 4/4] ice: use proper macro for testing bit
Date: Tue,  2 Jul 2024 10:14:57 -0700
Message-ID: <20240702171459.2606611-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
References: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Oros <poros@redhat.com>

Do not use _test_bit() macro for testing bit. The proper macro for this
is one without underline.

_test_bit() is what test_bit() was prior to const-optimization. It
directly calls arch_test_bit(), i.e. the arch-specific implementation
(or the generic one). It's strictly _internal_ and shouldn't be used
anywhere outside the actual test_bit() macro.

test_bit() is a wrapper which checks whether the bitmap and the bit
number are compile-time constants and if so, it calls the optimized
function which evaluates this call to a compile-time constant as well.
If either of them is not a compile-time constant, it just calls _test_bit().
test_bit() is the actual function to use anywhere in the kernel.

IOW, calling _test_bit() avoids potential compile-time optimizations.

The sensors is not a compile-time constant, thus most probably there
are no object code changes before and after the patch.
But anyway, we shouldn't call internal wrappers instead of
the actual API.

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Acked-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
index e4c2c1bff6c0..b7aa6812510a 100644
--- a/drivers/net/ethernet/intel/ice/ice_hwmon.c
+++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
@@ -96,7 +96,7 @@ static bool ice_is_internal_reading_supported(struct ice_pf *pf)
 
 	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
 
-	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
+	return test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);
 };
 
 void ice_hwmon_init(struct ice_pf *pf)
-- 
2.41.0


