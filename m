Return-Path: <netdev+bounces-117255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7AD94D57E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EF7282A35
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD24F5FB;
	Fri,  9 Aug 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lcvjz0DC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10316426
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224993; cv=none; b=HRJ+qw43gh7Y+0kztS0c1VypOWZz7KSzKyD5zY5d4Flgraj1jkA59oplJzSUecnk4tcINzRW1XuuNd0JuJ5kLwgClqrSohyq9N8d/dqXYhUpxiz/lsj4vvB39xGDplt8U6S3qinGVqLxOJH3n7BMCinQnwzXkDfYceARy/IAD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224993; c=relaxed/simple;
	bh=6TAdpQz6PFfeYz4b9vjrb+jwoaa3+l5JaXG5oN52HTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQkncrRUuQKMKmJbVVEFR9+lUc4XdDQZFYWlhnKLAP3G+6SKBug4uUfZz3HCbRKChDD9zT1VXMgmkldOqbZsUoeZo1HZAaoPA23EbleFTefMQwSKmlsJmOFGlzUg5A97k3exHy6GABDK5Q5pWoCZztQ/9qai1r4bBuqjvRK+XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lcvjz0DC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723224992; x=1754760992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TAdpQz6PFfeYz4b9vjrb+jwoaa3+l5JaXG5oN52HTE=;
  b=Lcvjz0DC/afuK2dtliB6yak1PCqdami9dhDBQMU7wplS8wH73Y+0uaEv
   oiGRjM3K+rCXsTWnm5OT0nbyh43vym8ONdJHuK5fY3oTBBLZROQ5tyhtX
   pYiQtBHhAPT68fnRhilPiSZtgryuQtVPGJrzD58SJiPajGYvRGx03ktCf
   sHjKAs+JUGJev8sefF+mKvzQOQtFAKzqm9YAhv6U51zVY6NAVOKcYUPvd
   v3OKdJ8KROOKW9WmK7PDDr4Mcm2s2cuDOxBv6ddOYAXwB63YqzmPRPzRg
   s/AtCkLasbtDGYgFaMgVnuSsrS+LcNqb03Aj5vCe2DnVgtP4eIeEn6VwL
   w==;
X-CSE-ConnectionGUID: E4klfacqSxCeI3vdlLJSnQ==
X-CSE-MsgGUID: aIednGoOR3yznZZoNbdb7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551248"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551248"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:28 -0700
X-CSE-ConnectionGUID: FTXW4conT3mxkK4lLPmHCA==
X-CSE-MsgGUID: wNHslz/tTc2ZbyRiM6KB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589151"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Junfeng Guo <junfeng.guo@intel.com>,
	anthony.l.nguyen@intel.com,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 01/13] ice: add parser create and destroy skeleton
Date: Fri,  9 Aug 2024 10:36:00 -0700
Message-ID: <20240809173615.2031516-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

Add new parser module which can parse a packet in binary and generate
information like ptype, protocol/offset pairs and flags which can be later
used to feed the FXP profile creation directly.

Add skeleton of the create and destroy APIs:
ice_parser_create()
ice_parser_destroy()

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile     |  1 +
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_parser.c | 32 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h | 13 +++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 03500e28ac99..23fa3f7f36ef 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -28,6 +28,7 @@ ice-y := ice_main.o	\
 	 ice_vlan_mode.o \
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
+	 ice_parser.o    \
 	 ice_idc.o	\
 	 devlink/devlink.o	\
 	 devlink/devlink_port.o \
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 66f29bac783a..27208a60cece 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -10,6 +10,7 @@
 #include "ice_type.h"
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
+#include "ice_parser.h"
 #include <linux/avf/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
new file mode 100644
index 000000000000..6c50164efae0
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024 Intel Corporation */
+
+#include "ice_common.h"
+
+/**
+ * ice_parser_create - create a parser instance
+ * @hw: pointer to the hardware structure
+ *
+ * Return: a pointer to the allocated parser instance or ERR_PTR
+ * in case of error.
+ */
+struct ice_parser *ice_parser_create(struct ice_hw *hw)
+{
+	struct ice_parser *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->hw = hw;
+	return p;
+}
+
+/**
+ * ice_parser_destroy - destroy a parser instance
+ * @psr: pointer to a parser instance
+ */
+void ice_parser_destroy(struct ice_parser *psr)
+{
+	kfree(psr);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
new file mode 100644
index 000000000000..09ed380eee32
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _ICE_PARSER_H_
+#define _ICE_PARSER_H_
+
+struct ice_parser {
+	struct ice_hw *hw; /* pointer to the hardware structure */
+};
+
+struct ice_parser *ice_parser_create(struct ice_hw *hw);
+void ice_parser_destroy(struct ice_parser *psr);
+#endif /* _ICE_PARSER_H_ */
-- 
2.42.0


