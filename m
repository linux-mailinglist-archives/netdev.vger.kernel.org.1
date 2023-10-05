Return-Path: <netdev+bounces-38324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCD7BA675
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C7BC3281E12
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3A30CE1;
	Thu,  5 Oct 2023 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaeKUCur"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F4134B6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:34:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947671980
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523610; x=1728059610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=59ko2CLJ74CefDm+7XQC54xUSZ4YDsqDKzDzILe7VpM=;
  b=eaeKUCur4I6AMCqjN/cruEq1jalZZ4b6QfYSqyBuhgeClC7E7O2cYXWh
   wmjXe9JMCUQF5XyD0yvbZJ28BbSTEWzzfGv/vn3AAZkbk18u9t76gYgZC
   Du7gGUrAq3Y+vxZEGvXKc8OgdDZEAeoWJt78LBTPpdsFksrvVTDIRbEEz
   2mhNtCecamc3WapqXrZOOqbIHLnCHSh0JF9jS2LHhATfKflQAOcgxucVn
   B8ivxI7LSdUBYggNBXLVyUhFLV9nNz2SW8EsyiqJbz41dSCD8SG/bHFvz
   mwlYVuMNtr8DnWRoR2wH0SOYZJRFiT4BSQJm2WH/giClJDSpHg4GBAYLh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152688"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152688"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607760"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607760"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 8/9] i40e: Remove circular header dependencies and fix headers
Date: Thu,  5 Oct 2023 09:28:49 -0700
Message-Id: <20231005162850.3218594-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

Similarly as for ice driver [1] there are also circular header
dependencies in i40e driver:
i40e.h -> i40e_virtchnl_pf.h -> i40e.h

Another issue is that i40e header files does not contain their own
dependencies on other header files (both private and standard) so their
inclusion in .c file require to add these deps in certain order to
that .c file to make it compilable.

Fix both issues by removal the mentioned circular dependency, by filling
i40e headers with their dependencies so they can be placed anywhere in
a source code. Additionally remove bunch of includes from i40e.h super
header file that are not necessary and include i40e.h only in .c files
that really require it.

[1] 649c87c6ff52 ("ice: remove circular header dependencies on ice.h")

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 43 ++++---------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +
 drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c | 11 +++--
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |  2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 ++-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 ++
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  8 ++--
 .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 ++++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  2 +
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 +--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  7 +--
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 ++
 27 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7f79d5929be6..107826c040c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,47 +4,20 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
-#include <net/tcp.h>
-#include <net/udp.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/netdevice.h>
-#include <linux/ioport.h>
-#include <linux/iommu.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/hashtable.h>
-#include <linux/string.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/sctp.h>
-#include <linux/pkt_sched.h>
-#include <linux/ipv6.h>
-#include <net/checksum.h>
-#include <net/ip6_checksum.h>
 #include <linux/ethtool.h>
-#include <linux/if_vlan.h>
-#include <linux/if_macvlan.h>
-#include <linux/if_bridge.h>
-#include <linux/clocksource.h>
-#include <linux/net_tstamp.h>
+#include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/types.h>
+#include <linux/avf/virtchnl.h>
+#include <linux/net/intel/i40e_client.h>
 #include <net/pkt_cls.h>
-#include <net/pkt_sched.h>
-#include <net/tc_act/tc_gact.h>
-#include <net/tc_act/tc_mirred.h>
 #include <net/udp_tunnel.h>
-#include <net/xdp_sock.h>
-#include <linux/bitfield.h>
-#include "i40e_type.h"
+#include "i40e_dcb.h"
+#include "i40e_debug.h"
+#include "i40e_io.h"
 #include "i40e_prototype.h"
-#include <linux/net/intel/i40e_client.h>
-#include <linux/avf/virtchnl.h>
-#include "i40e_virtchnl_pf.h"
+#include "i40e_register.h"
 #include "i40e_txrx.h"
-#include "i40e_dcb.h"
 
 /* Useful i40e defaults */
 #define I40E_MAX_VEB			16
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index e72cfe587c89..9ce6e633cc2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e_type.h"
+#include <linux/delay.h>
+#include "i40e_alloc.h"
 #include "i40e_register.h"
-#include "i40e_adminq.h"
 #include "i40e_prototype.h"
 
 static void i40e_resume_aq(struct i40e_hw *hw);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 3357d65a906b..18a1c3b6d72c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_ADMINQ_CMD_H_
 #define _I40E_ADMINQ_CMD_H_
 
+#include <linux/bits.h>
+
 /* This header file defines the i40e Admin Queue commands and is shared between
  * i40e Firmware and Software.
  *
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 639c5a1ca853..306758428aef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -6,7 +6,6 @@
 #include <linux/net/intel/i40e_client.h>
 
 #include "i40e.h"
-#include "i40e_prototype.h"
 
 static LIST_HEAD(i40e_devices);
 static DEFINE_MUTEX(i40e_device_mutex);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index eeef20f77106..6d1042ca0317 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_type.h"
-#include "i40e_adminq.h"
-#include "i40e_prototype.h"
 #include <linux/avf/virtchnl.h>
+#include <linux/delay.h>
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+#include "i40e_adminq_cmd.h"
+#include "i40e_devids.h"
+#include "i40e_prototype.h"
+#include "i40e_register.h"
 
 /**
  * i40e_set_mac_type - Sets MAC type
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index f81e744c0fb3..68602fc375f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include "i40e_adminq.h"
-#include "i40e_prototype.h"
+#include "i40e_alloc.h"
 #include "i40e_dcb.h"
+#include "i40e_prototype.h"
 
 /**
  * i40e_get_dcbx_status
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 195421d863ab..077a95dad32c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -2,8 +2,8 @@
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
 #ifdef CONFIG_I40E_DCB
-#include "i40e.h"
 #include <net/dcbnl.h>
+#include "i40e.h"
 
 #define I40E_DCBNL_STATUS_SUCCESS	0
 #define I40E_DCBNL_STATUS_ERROR		1
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 0e72abd178ae..21b3518c4096 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/firmware.h>
 #include "i40e.h"
 
-#include <linux/firmware.h>
 
 /**
  * i40e_ddp_profiles_eq - checks if DDP profiles are the equivalent
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 1a497cb07710..999c9708def5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -5,8 +5,9 @@
 
 #include <linux/fs.h>
 #include <linux/debugfs.h>
-
+#include <linux/if_bridge.h>
 #include "i40e.h"
+#include "i40e_virtchnl_pf.h"
 
 static struct dentry *i40e_dbg_root;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index c3ce5f35211f..ece3a6b9a5c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -4,7 +4,10 @@
 #ifndef _I40E_DIAG_H_
 #define _I40E_DIAG_H_
 
-#include "i40e_type.h"
+#include "i40e_adminq_cmd.h"
+
+/* forward-declare the HW struct for the compiler */
+struct i40e_hw;
 
 enum i40e_lb_mode {
 	I40E_LB_MODE_NONE       = 0x0,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 77e4ac103866..a89f7ca510fd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3,9 +3,10 @@
 
 /* ethtool support for i40e */
 
-#include "i40e.h"
+#include "i40e_devids.h"
 #include "i40e_diag.h"
 #include "i40e_txrx_common.h"
+#include "i40e_virtchnl_pf.h"
 
 /* ethtool statistics helpers */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index b383aea652f3..1742624ca62e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_register.h"
 #include "i40e_alloc.h"
+#include "i40e_debug.h"
 #include "i40e_hmc.h"
 #include "i40e_type.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
index 9960da07a573..480e3a883cc7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
@@ -4,6 +4,10 @@
 #ifndef _I40E_HMC_H_
 #define _I40E_HMC_H_
 
+#include "i40e_alloc.h"
+#include "i40e_io.h"
+#include "i40e_register.h"
+
 #define I40E_HMC_MAX_BP_COUNT 512
 
 /* forward-declare the HW struct for the compiler */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 830f1de254ef..beaaf5c309d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
-#include "i40e_register.h"
-#include "i40e_type.h"
-#include "i40e_hmc.h"
+#include "i40e_alloc.h"
+#include "i40e_debug.h"
 #include "i40e_lan_hmc.h"
-#include "i40e_prototype.h"
+#include "i40e_type.h"
 
 /* lan specific interface functions */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
index 9f960404c2b3..305a276953b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_LAN_HMC_H_
 #define _I40E_LAN_HMC_H_
 
+#include "i40e_hmc.h"
+
 /* forward-declare the HW struct for the compiler */
 struct i40e_hw;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4ad845a77067..1e52e1debf7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1,19 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2021 Intel Corporation. */
 
-#include <linux/etherdevice.h>
-#include <linux/of_net.h>
-#include <linux/pci.h>
-#include <linux/bpf.h>
 #include <generated/utsrelease.h>
 #include <linux/crash_dump.h>
+#include <linux/if_bridge.h>
+#include <linux/if_macvlan.h>
+#include <linux/module.h>
+#include <net/pkt_cls.h>
+#include <net/xdp_sock_drv.h>
 
 /* Local includes */
 #include "i40e.h"
+#include "i40e_devids.h"
 #include "i40e_diag.h"
+#include "i40e_lan_hmc.h"
+#include "i40e_virtchnl_pf.h"
 #include "i40e_xsk.h"
-#include <net/udp_tunnel.h>
-#include <net/xdp_sock_drv.h>
+
 /* All i40e tracepoints are defined by the include below, which
  * must be included exactly once across the whole kernel with
  * CREATE_TRACE_POINTS defined
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 07a46adeab38..77cdbfc19d47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/delay.h>
+#include "i40e_alloc.h"
 #include "i40e_prototype.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 9c9234c0706f..2001fefa0c52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -4,10 +4,9 @@
 #ifndef _I40E_PROTOTYPE_H_
 #define _I40E_PROTOTYPE_H_
 
-#include "i40e_type.h"
-#include "i40e_alloc.h"
-#include "i40e_debug.h"
 #include <linux/avf/virtchnl.h>
+#include "i40e_debug.h"
+#include "i40e_type.h"
 
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 8a26811140b4..20b77398f060 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include "i40e.h"
 #include <linux/ptp_classify.h>
 #include <linux/posix-clock.h>
+#include "i40e.h"
+#include "i40e_devids.h"
 
 /* The XL710 timesync is very much like Intel's 82599 design when it comes to
  * the fundamental clock design. However, the clock operations are much simpler
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d680df615ff9..d1400cb7f1fc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1,14 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
-#include <linux/prefetch.h>
 #include <linux/bpf_trace.h>
+#include <linux/prefetch.h>
+#include <linux/sctp.h>
 #include <net/mpls.h>
 #include <net/xdp.h>
-#include "i40e.h"
-#include "i40e_trace.h"
-#include "i40e_prototype.h"
 #include "i40e_txrx_common.h"
+#include "i40e_trace.h"
 #include "i40e_xsk.h"
 
 #define I40E_TXD_CMD (I40E_TX_DESC_CMD_EOP | I40E_TX_DESC_CMD_RS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 900b0d9ede9f..421fe5675584 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -5,6 +5,7 @@
 #define _I40E_TXRX_H_
 
 #include <net/xdp.h>
+#include "i40e_type.h"
 
 /* Interrupt Throttling and Rate Limiting Goodies */
 #define I40E_DEFAULT_IRQ_WORK      256
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 8c5118c8baaf..e26807fd2123 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -4,6 +4,8 @@
 #ifndef I40E_TXRX_COMMON_
 #define I40E_TXRX_COMMON_
 
+#include "i40e.h"
+
 int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring *xdp_ring);
 void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64 qword0_raw,
 				   u64 qword1);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index b3980b5b6919..dc7cd16ad8fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -4,14 +4,9 @@
 #ifndef _I40E_TYPE_H_
 #define _I40E_TYPE_H_
 
-#include <linux/delay.h>
-#include <linux/if_ether.h>
-#include "i40e_io.h"
-#include "i40e_register.h"
+#include <uapi/linux/if_ether.h>
 #include "i40e_adminq.h"
 #include "i40e_hmc.h"
-#include "i40e_lan_hmc.h"
-#include "i40e_devids.h"
 
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			4
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 186b1130dbaf..08d7edccfb8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
 #include "i40e.h"
+#include "i40e_lan_hmc.h"
+#include "i40e_virtchnl_pf.h"
 
 /*********************notification routines***********************/
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 895b8feb2567..2ee0f8a23248 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -4,7 +4,9 @@
 #ifndef _I40E_VIRTCHNL_PF_H_
 #define _I40E_VIRTCHNL_PF_H_
 
-#include "i40e.h"
+#include <linux/avf/virtchnl.h>
+#include <linux/netdevice.h>
+#include "i40e_type.h"
 
 #define I40E_MAX_VLANID 4095
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 37f41c8a682f..4a49848f7781 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -2,11 +2,7 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <linux/stringify.h>
 #include <net/xdp_sock_drv.h>
-#include <net/xdp.h>
-
-#include "i40e.h"
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index 821df248f8be..ef156fad52f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -4,6 +4,8 @@
 #ifndef _I40E_XSK_H_
 #define _I40E_XSK_H_
 
+#include <linux/types.h>
+
 /* This value should match the pragma in the loop_unrolled_for
  * macro. Why 4? It is strictly empirical. It seems to be a good
  * compromise between the advantage of having simultaneous outstanding
@@ -20,7 +22,9 @@
 #define loop_unrolled_for for
 #endif
 
+struct i40e_ring;
 struct i40e_vsi;
+struct net_device;
 struct xsk_buff_pool;
 
 int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair);
-- 
2.38.1


