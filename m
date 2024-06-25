Return-Path: <netdev+bounces-106586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AC916EC3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE3328CCA4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BC176FDB;
	Tue, 25 Jun 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grkHgG7+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23F2F56
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334987; cv=none; b=sxa0sjA7zaIbMDKXfsemu+jdHo84K9b0waIOLLxSV3u7sPk+GMGRqjyhfgp2IuJA/zWripclwsfgGJoIHeNoU+vkzgT/8vD2pJbOTJECezgY9fitk9/rwarIJ4hzhnyhhjFWcyYH8kMBwLUUDmq/nUFe80ysZoM04hTqUUwlgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334987; c=relaxed/simple;
	bh=fnJQnTOh6rOBc/JjC4l6zK3yrL4IXLPEWg4f5HDzdZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoCgubjCUMCdgIvOHy4G7bQQ9H5UnQMNZnP9A7QXXun5h4H3lQYRpMlDTAaYGBFsmtkpUo7GjkdaB3Oi/Zd6ZkeDqzDNgicTWlrFvVhyCL/lG9e6KhQYRPKnl2fHMEWyyI8z6sPBYA20wmYjx6i81wuDsOrHbbqH+/Iz68hAsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grkHgG7+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334987; x=1750870987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnJQnTOh6rOBc/JjC4l6zK3yrL4IXLPEWg4f5HDzdZ8=;
  b=grkHgG7+CWUZDZF5aZ4n6deVBWfKmkcL0Z6gZznKn7gO5B1j12AAeoO1
   B/mQAwsNky74FMQA0lbV8Xm8rLdB94ep91JxvK4Cl3XLDCXVm3RQlRxl0
   eu9+w4ZL55wS12YQrLj/zSKrMxm9U2U6qzAHLDUPLU8kG1Yf/gAoMwvwF
   mCBGAiVGpFhUs+5a0p3M+DozrWPWi/CQtzAEQEPlHGUi5G6h/YC5U3d3f
   7x6/Yf0Rz9fZUYsM7l2w6r6PcXIBO9YDVq4nJ0zDmExBVn8b/xuFL+ifu
   YjJIVPnHqmnk5niIGL/ETPnPl9wL2anoNxBl5FHTkvvXs2DQY2m+fNjPn
   w==;
X-CSE-ConnectionGUID: ojbLPfXpR5i5LxeuDzbZhQ==
X-CSE-MsgGUID: foepWmrhTQ2yKlisKbWSAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33825665"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33825665"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:02:54 -0700
X-CSE-ConnectionGUID: wUYaZRmjTueaZglf+GD7Zw==
X-CSE-MsgGUID: OX36lBVrQ3CnB66buy0W+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48893934"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 10:02:54 -0700
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
Subject: [PATCH net 4/4] ice: use proper macro for testing bit
Date: Tue, 25 Jun 2024 10:02:47 -0700
Message-ID: <20240625170248.199162-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
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


