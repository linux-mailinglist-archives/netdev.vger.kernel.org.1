Return-Path: <netdev+bounces-62966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0482A543
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 01:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC72828973A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 00:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29136A;
	Thu, 11 Jan 2024 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWrXDJWb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A010EC
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704933574; x=1736469574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/k+h6lnl1bMRJ1SN6oCoe9x96SxlH6BTXelJNumA84=;
  b=RWrXDJWbcrRuj/oAmu1PHg0PeoABy2nhIOx250bkuAjit2IzZl0M12Md
   JAPPqC4tIq8bDLoDCJktqOEKodvkVGM4tu3ygeRhy5G5iPtTpX0c+TLYe
   nPOhiL10DS2QoxOw6COjrrwEdejrHl9WUXMtuqcdhnyUDNj/EeZNOuV2O
   6NozXlBf2tNS9rt7nKhDPr76vtACZR8ATFztB+pRpcrzZyFvO65yQB9Zx
   Tc0noakfukpAQUy/KovcU0VeJE+OBSnD3QUXaudysnE2OdM5M5bxc6LhZ
   cWUpWezP457Etww/tRGiQJ2dx32OrB+KNOP4LjgN0HnzAwaNmlG7z8kfV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="398390877"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="398390877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 16:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905739364"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905739364"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2024 16:39:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	Martin Zaharinov <micron10@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net] i40e: Include types.h to some headers
Date: Wed, 10 Jan 2024 16:39:25 -0800
Message-ID: <20240111003927.2362752-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56df345917c0 ("i40e: Remove circular header dependencies and fix
headers") redistributed a number of includes from one large header file
to the locations they were needed. In some environments, types.h is not
included and causing compile issues. The driver should not rely on
implicit inclusion from other locations; explicitly include it to these
files.

Snippet of issue. Entire log can be seen through the Closes: link.

In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
                 from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown type name '__le16'
   33 |         __le16 flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown type name '__le16'
   34 |         __le16 opcode;
      |         ^~~~~~
...
drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type name 'u32'
   22 |         u32 elements;   /* number of elements if array */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type name 'u32'
   23 |         u32 stride;     /* bytes between each element */

Reported-by: Martin Zaharinov <micron10@gmail.com>
Closes: https://lore.kernel.org/netdev/21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com/
Fixes: 56df345917c0 ("i40e: Remove circular header dependencies and fix headers")
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 18a1c3b6d72c..c8f35d4de271 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -5,6 +5,7 @@
 #define _I40E_ADMINQ_CMD_H_
 
 #include <linux/bits.h>
+#include <linux/types.h>
 
 /* This header file defines the i40e Admin Queue commands and is shared between
  * i40e Firmware and Software.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_diag.h b/drivers/net/ethernet/intel/i40e/i40e_diag.h
index ece3a6b9a5c6..ab20202a3da3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_diag.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_diag.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_DIAG_H_
 #define _I40E_DIAG_H_
 
+#include <linux/types.h>
 #include "i40e_adminq_cmd.h"
 
 /* forward-declare the HW struct for the compiler */
-- 
2.41.0


