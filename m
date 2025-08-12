Return-Path: <netdev+bounces-212927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250BB2290E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FD63BA94F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14941280A2C;
	Tue, 12 Aug 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YInEqsTO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A727A918
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005946; cv=none; b=hAXh6w4+Ql73b1lzh4Qpdrah+bfqZ72hcfKChgOXhAnuy/1Daeam04Rlye4+5cHwXeNYDxEwe42S/I1kvquYG8/f9Kp3wVrtk8o5dOrYjSBPUBt7Ku6F1sMrXRSZ3NkF9SMkN3Jc3+Zzypn5HvVAKgiSyBFbU3OGwNkC2vIrNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005946; c=relaxed/simple;
	bh=TOSXConkqbhZiWMfHQMp43j6TW/KPXqP30QVkaB7RRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zbl7gOIDa3k2rWDKq4nKUj2JJxRsHI/Lct2/7+LKWHSQeXapIyvUniTp2TbDQhtHQeUUXVQLo2L52iD7M9PMbKKR399aChsvHOR2KIfXN3TBc2irFki6ufY19jBJAxT+JdHBwS95uFowZyWCRwjuUvqALw/MsQi0U558nMxD6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YInEqsTO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005945; x=1786541945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOSXConkqbhZiWMfHQMp43j6TW/KPXqP30QVkaB7RRU=;
  b=YInEqsTOEeKxF8ZbfEUCtYoMi4J1ISykgkKY418e/viBhqFAhZLF/Eg3
   31HiLr9sTtNfnFmD9KpjAkxOjcrNb4ibxAqmgarYHdPDplPnLISJn6XVX
   WdRcG1kGeV0zeyASKieVEaHm793GcPzAZzL1csgDSjgJMNILJbH6PCJZP
   HwcnXj/f7StlOOyqIgLmhpTQqvPZmDC1qekHsl/+RjdCWQiMe4v0Yhr7E
   0x+uIulwPIL4mzgyDLdUINJvIVXktXwMWFqZhg05MVj1Xz5cCCCF+0Ad5
   gyj1CECvuU+sDUAyIy8DBhs/wovv+PxR4i9+8BTUhEHAf3dB1ysRphcRh
   w==;
X-CSE-ConnectionGUID: oUG9acE+SEaPhs0gAG6upA==
X-CSE-MsgGUID: UEELGDFHThOyyvmlvSrYLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994319"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994319"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:03 -0700
X-CSE-ConnectionGUID: HX8uqehtRy2HeWb7TW4I2g==
X-CSE-MsgGUID: sALZVvPWR2CaFRait38r8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416052"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:01 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5420432CAD;
	Tue, 12 Aug 2025 14:39:00 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 01/12] ice: split queue stuff out of ice_virtchnl.c - p1
Date: Tue, 12 Aug 2025 15:28:59 +0200
Message-Id: <20250812132910.99626-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Temporary rename of ice_virtchnl.c into ice_virtchnl_queues.c

In order to split ice_virtchnl.c in a way that makes it much easier
to still blame new file, we do it via multiple git steps.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                         | 2 +-
 .../intel/ice/{ice_virtchnl.c => ice_virtchnl_queues.c}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.c => ice_virtchnl_queues.c} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index d0f9c9492363..56aec5ab9e6b 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -47,7 +47,7 @@ ice-y := ice_main.o	\
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
-	ice_virtchnl.o		\
+	ice_virtchnl_queues.o	\
 	ice_virtchnl_allowlist.o \
 	ice_virtchnl_fdir.o	\
 	ice_vf_mbx.o		\
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.c
rename to drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
-- 
2.39.3


