Return-Path: <netdev+bounces-213869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FCFB272C8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE13628719
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B846288C23;
	Thu, 14 Aug 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFwx++N8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD44288516
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212951; cv=none; b=qGkjia4AMrz0zDTJmRU2UJ1vbRUvaax0RZTeeEHO6qpk37wOX4FwrnumfbMUTfWrXnEQx4ErUTXJQntqJLoLvAMo/0HIqSG5Lk7hu4SHENywZJSad/nsiWSk1v50rg2Fk23OEsJOSS6qw3vQ1fdcx0GaO+/xxx4PBONra94BLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212951; c=relaxed/simple;
	bh=+CqEdr2iI/CVEq7RxBFQzbpqTRiVaDAPqW4L37QoofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3jrVSTM7TCaG9wsZBzZC0Yd1hDbY6ynfnfX3qaxtuTMKRhHBiUdYfdrt+xv+LpxPvB8r69Oiotv8sZpK3Nfv+yus5kI1+aDznrX7HJFaMnqA/CIKhOYpqpO2HFj036yRfzj8MPmqfyiEZPQzYuiRpCr17DMoRBBRQMb+LWhxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFwx++N8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212950; x=1786748950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+CqEdr2iI/CVEq7RxBFQzbpqTRiVaDAPqW4L37QoofE=;
  b=JFwx++N8OF1beJF5GI2YG0K7lT2hhyEmA4GiAgsEDLoMy4hW1SCuOyI0
   ZuygI1Kd0KhQ1ChiCS8H5z4qzL6U3bv9pGbI0lDon06jzc9GN8DbZkmmf
   scxPWtBwbEoGAenfItwsP2UYh0RJx6QIcnW5FwDcSJ0zBdWS4y2pozjei
   J4zBUwQIZ7Seo6FDVTDjHnJJBCIn24rTdJaUOt6xEf/RiCIf0YLkwxURu
   MT9c2nfb2ick56vhHAB5zAgZz4xogn8/rRoOH+h14L/La2Fk2dtTtMac4
   Te9obfm1d7HzAQl3xkQUcAfupmv9hc/7urLElFfPW5IKrINintsTF61oQ
   g==;
X-CSE-ConnectionGUID: 9JGZOTwBSuilvkhCf2RWjg==
X-CSE-MsgGUID: HBglD6XdQ1qEOlTWRQuNBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117991"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117991"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: aj9Zv2UWRWS9rtAdBCJCug==
X-CSE-MsgGUID: I2Fa6lSsR32rZteXRMslfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848143"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 6/7] ice: cleanup capabilities evaluation
Date: Thu, 14 Aug 2025 16:08:53 -0700
Message-ID: <20250814230855.128068-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

When evaluating the capabilities field, the ICE_AQC_BIT_ROCEV2_LAG and
ICE_AQC_BIT_SRIOV_LAG defines were both not using the BIT operator,
instead simply setting a hex value that set the correct bits.  While
not inaccurate, this method is misleading, and when it is expanded in
the following implementation it becomes even more confusing.

Switch to using the BIT() operator to clarify what is being checked.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/net/intel/libie/adminq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 012b5d499c1a..dbe93f940ef0 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -192,8 +192,8 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
 #define LIBIE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define LIBIE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
-#define LIBIE_AQC_BIT_ROCEV2_LAG			0x01
-#define LIBIE_AQC_BIT_SRIOV_LAG				0x02
+#define LIBIE_AQC_BIT_ROCEV2_LAG			BIT(0)
+#define LIBIE_AQC_BIT_SRIOV_LAG				BIT(1)
 #define LIBIE_AQC_CAPS_FLEX10				0x00F1
 #define LIBIE_AQC_CAPS_CEM				0x00F2
 
-- 
2.47.1


