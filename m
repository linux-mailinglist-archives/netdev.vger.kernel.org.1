Return-Path: <netdev+bounces-95979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0708C3F18
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A723287BCB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBC14D2BF;
	Mon, 13 May 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VN53KNYO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811F14AD20;
	Mon, 13 May 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596723; cv=none; b=WAQv4n4wS9mx5VK5QNxLa4w1RfN25VSHzjNIhqt245GZNJkU8rFa2gMRH+jpapXLIEYKKF8iAd6kYEyOcCrrX3BmvgaDewlF/TjMSd8jXV7++ZlQGqnHYN6bx/1IB8/NMokMlZoZVfzHPVUbkOXXfnjbeXOyy7D/4Tgvvj0MRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596723; c=relaxed/simple;
	bh=4F1lxedZEM3s7N7Auk2OfI1FJs1f0oZxEqwluHiKK4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdoUDZKMzbjXNC+LwX3lYwbjQ4s2qH4ZBINuknkqHJWig6wJg51EPlgjWiKPobhC7rKxms9dboh39NGNlauR7qH+iZ1vZFbiS9TLMUg9+gGvkCpbOs3YefkNr/qyCZMFoTve7uA2rC+P6UqVGQ6XFwlNEhcCrZ97Xokw3paUiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VN53KNYO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596721; x=1747132721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4F1lxedZEM3s7N7Auk2OfI1FJs1f0oZxEqwluHiKK4Q=;
  b=VN53KNYOEOUtYQXTLt3iLuNZcaN3Ukf+RA3rZnQyRCd6jC/yedy+6NNI
   j/ocWCrF+RmvrtYcr4ndzHcdFaLKGHYB5PVvTwgzWFHAW9cz6DaosbCgQ
   j3AOlmhtfnVPLPYAC2SuAZ2ncJPSLlgoa2ZkDCCJ2IZZCO3DvrunB7m5E
   YirAzeIy2KDnqiJ7UvmxSDIi0yQUVPo43QpZHlm76F4ef06BNML9bUYIF
   EtgEdKBDBmVFWVVpXlDipSRILfJR98ak33sd0euBInTStbiL6A/plepD3
   Sw36XsIbdgnAiBHHsUemE+lsoBMtQxEj9/zslvs5wrCiprS2SpDO4V1+4
   A==;
X-CSE-ConnectionGUID: POXM4+eZRCyWBW5r9HfQ8A==
X-CSE-MsgGUID: jdp/A/vwTvSKPyRT2MdNLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29038953"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29038953"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:38:40 -0700
X-CSE-ConnectionGUID: TKDRBQSYQt+KkyGmmH7qiA==
X-CSE-MsgGUID: 6I/FiArkTq2mDDY4WToxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481723"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:34 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v8 03/12] e1000e: remove convert_art_to_tsc()
Date: Mon, 13 May 2024 16:08:04 +0530
Message-Id: <20240513103813.5666-4-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The core code provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Store the ART clocksoure ID and the cycles value in the provided
system_counterval structure.

Replace the direct conversion via convert_art_to_tsc() by filling in the
required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index bbcfd529399b..89d57dd911dc 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	*system = convert_art_to_tsc(sys_cycles);
+	system->cycles = sys_cycles;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


