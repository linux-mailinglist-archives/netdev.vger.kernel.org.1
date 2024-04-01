Return-Path: <netdev+bounces-83790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288589444D
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EF61F20FAD
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75B5103E;
	Mon,  1 Apr 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQvPhLdR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8C4E1D2
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992273; cv=none; b=kON3NTVnL5Y4PLKm5QxQSmHcDrQ59memvnpwYJGME5Lrg1UpKMj0sNnl1vJX6e9JGGnDpM6GnX/HahuvpiaVY7GG1VZxV5vP8bNIsNKx3k95y/lPUWEeEtK3t8GwoZbqcH+OfKWF5sgJ0vN+JDuyEv9yWlkXq0VQevZ9q2rCxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992273; c=relaxed/simple;
	bh=o5ugUs6AyJ1Rfj1Vb54fm56batEGOb+7RBJXaLkrIcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct7JJlyg7T9E46xyTeFKdfQS2L3Sh88nmGJqLKxbolj+LgSHBQsPY2wc8AhZoIGXxoG8LYXHzfUmDjepGqd3K6tcVsdC0ZaJKdVllr25sbbeVkA+2pOnn29W8MFsomiV5j7n55QKXvRC8I8SvZBHfVh5RX2Na8hCVKpXuEKj5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQvPhLdR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992272; x=1743528272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5ugUs6AyJ1Rfj1Vb54fm56batEGOb+7RBJXaLkrIcc=;
  b=lQvPhLdRE0jfsrsilCQ3bioWpr8VTzmSvEhvhPFYctmW7aufDKMmx2Y9
   Zu1V//qVbzE3P1NO8flqGrCS6BR2PLRlk94zDgupw5mNNHf7heoq9cpw4
   odJX3r9zlDo7m5S5xuPLFKCFn1F28dvV37xWb0vhIrgICsI7YpNrEJOyq
   yLNC2KlaqDfF8CnQ1l+Xn+O13ORNGrM5dPtdPWktf+4j5P0gZfxGNKX7K
   Tw3ikFlCz+AMi/VhvbUPUJ//sy8+bJLHRmB5HMXeSIonlEXubptbFA32U
   sLAGwespD1cBD4M2ue3bafjq8AHAWUKlhCfxwROW9JZRvHqf30DI94t4w
   w==;
X-CSE-ConnectionGUID: OtZ7KUl9Ru+PZazNInfCRw==
X-CSE-MsgGUID: G4W2r5JWR2mH3PevBMw/UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606175"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606175"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235097"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/8] ice: move ice_devlink.[ch] to devlink folder
Date: Mon,  1 Apr 2024 10:24:16 -0700
Message-ID: <20240401172421.1401696-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Only moving whole files, fixing Makefile and bunch of includes.

Some changes to ice_devlink file was done even in representor part (Tx
topology), so keep it as final patch to not mess up with rebasing.

After moving to devlink folder there is no need to have such long name
for these files. Rename them to simple devlink.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                        | 3 ++-
 .../ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c}    | 2 +-
 .../ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h}    | 0
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                      | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c                      | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c} (99%)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 4fa09c321440..736b1cae2033 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -5,6 +5,7 @@
 # Makefile for the Intel(R) Ethernet Connection E800 Series Linux Driver
 #
 
+subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_ICE) += ice.o
 
 ice-y := ice_main.o	\
@@ -28,7 +29,7 @@ ice-y := ice_main.o	\
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
 	 ice_idc.o	\
-	 ice_devlink.o	\
+	 devlink/devlink.o	\
 	 ice_ddp.o	\
 	 ice_fw_update.o \
 	 ice_lag.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/ice_devlink.c
rename to drivers/net/ethernet/intel/ice/devlink/devlink.c
index 3c3616f0f811..82983eab52e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -5,7 +5,7 @@
 
 #include "ice.h"
 #include "ice_lib.h"
-#include "ice_devlink.h"
+#include "devlink.h"
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_devlink.h
rename to drivers/net/ethernet/intel/ice/devlink/devlink.h
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index ceb17c004d79..a94e7072b570 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -3,7 +3,7 @@
 
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 
 /**
  * ice_dcb_get_ena_tc - return bitmap of enabled TCs
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index af4e9530eb48..c902848cf88e 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -7,7 +7,7 @@
 #include "ice_eswitch_br.h"
 #include "ice_fltr.h"
 #include "ice_repr.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_tc_lib.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 327de754922c..66eeaf345032 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -7,7 +7,7 @@
 #include "ice_lib.h"
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_vsi_vlan_ops.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d85736f700dd..eba1c18ea52e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -13,7 +13,7 @@
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 2429727d5562..3b4ecbf0aa8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -3,7 +3,7 @@
 
 #include "ice.h"
 #include "ice_eswitch.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
-- 
2.41.0


