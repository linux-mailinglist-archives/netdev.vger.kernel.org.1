Return-Path: <netdev+bounces-95980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA928C3F1F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C3C1C21B9D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056014B948;
	Mon, 13 May 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUmZCXpX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA193149DEE;
	Mon, 13 May 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596729; cv=none; b=LjEe3Hpqz0At69epOuSY9Idm9g3LuEy/Rn44UbYG25VBTtxbF8KzsWbRbhDA2t6SvNooWAO+MmE7/7czLi02ZRGdSNSZlx04hXtcI+KtYMKheymmHr1HkNvwNKqj1jO8bfeMwVU4aml0b2VaiBcqr1Upyt/uR9B5Prc7G1SvD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596729; c=relaxed/simple;
	bh=E24oiqBr9fZRW5QO8Q7Dp8xrmLM7n8Eet5142z/yLlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRjPE2h2dtA+UEty5+aMu/cWzK5ZNAh7bJDTaD7GjnsHpny9HvjkxIpvemVu0bPC07VXIA++qCBVcx16/BB5qun+i3DTNh0kAvk3x2A2AbJcTBxENVCQW9ML+VX/U0PkFETNu1XE4gPDyYp2q/DS/+tBqD1w1ViCssQ9Wa6N7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUmZCXpX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596727; x=1747132727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E24oiqBr9fZRW5QO8Q7Dp8xrmLM7n8Eet5142z/yLlA=;
  b=cUmZCXpXBgnUVqZqE99BZ/+cSS3PPkm+ZiMKonWvGgx8RVt0AwsFx45R
   g7G5xqTra0eyGdG/H/9A9r2E4Ubl31UMOZfvTdfDtxest91c872EiG7Gc
   rAPKyByCkgeHS3toPXz279+luTL0+nhzyS7StgTKQ/3bwQhR4mOZxUW9H
   x+F9AWnJJXN/6CBrkvihxFPeqbPYzeov7MKgV5n3wF+CHq9Y4INvG/f0M
   QmMREzm2Nx0P9ZMzAa3woaSmbCQB4JvCAHKYPaAjHBVd+UEzcIOAxguhB
   GwnhCx403qqnc/rvT9PSBrpDXERr2PLXryp4F+HTD+M0MmRHRptELxYuA
   w==;
X-CSE-ConnectionGUID: 6F3UnCjBQ1SO1/ZBXFyJ8w==
X-CSE-MsgGUID: 8cE+sBgQRlajLJge9EN/7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29038986"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29038986"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:38:46 -0700
X-CSE-ConnectionGUID: ffHlNrxyRwOrL7MFQJm/9w==
X-CSE-MsgGUID: 1qZZ6hJaRCCuZyQIRuokXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481729"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:40 -0700
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
Subject: [PATCH v8 04/12] igc: remove convert_art_ns_to_tsc()
Date: Mon, 13 May 2024 16:08:05 +0530
Message-Id: <20240513103813.5666-5-lakshmi.sowjanya.d@intel.com>
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

All what is required is to store the ART clocksoure ID and the cycles
value in the provided system_counterval structure.

Replace the direct conversion via convert_art_ns_to_tsc() by filling in
the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 885faaa7b9de..39656489d73e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -901,7 +901,11 @@ static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
 static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
 {
 #if IS_ENABLED(CONFIG_X86_TSC) && !defined(CONFIG_UML)
-	return convert_art_ns_to_tsc(tstamp);
+	return (struct system_counterval_t) {
+		.cs_id		= CSID_X86_ART,
+		.cycles		= tstamp,
+		.use_nsecs	= true,
+	};
 #else
 	return (struct system_counterval_t) { };
 #endif
-- 
2.35.3


