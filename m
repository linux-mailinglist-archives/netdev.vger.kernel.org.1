Return-Path: <netdev+bounces-64033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D51830BDF
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DB11C21AF5
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE2225DD;
	Wed, 17 Jan 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUso5K2q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71081E48C
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512343; cv=none; b=s4d2w9C9vU77G7uOZk+OgbmICNWnhCH18vu/R3GgUyNVljNj8RsbZlxvogdpjGv7tb19TuSySL1Wg+YqPwKkmd7D7aGccvpv8kaIHAFWmQpfwWcH1kKSkxskANvRmBMpzTKRDTpf5qojmEA1m/H/sHd6/A5fkvingpyrDWbP8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512343; c=relaxed/simple;
	bh=uLyl+WkOUixIeLO1fA5FuCRzCq3+Q0c9gEWAfKYEBiY=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=Z4NLxdmyMLaHa8kNXxNAq/jnBIVQh4l0aIMxYRCNvFfM0T4gxtBo4JkynfMwcUjF3k7BogDynSYhXbmLxOW9BaL80F3DA1GZDa3wqPrElZwyIcq/LBoVQjEuH99iXb/NEZUE3/DfcWpNUd9RiBPBUzvzgMpG7xm6YLzI2UyPDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUso5K2q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705512342; x=1737048342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uLyl+WkOUixIeLO1fA5FuCRzCq3+Q0c9gEWAfKYEBiY=;
  b=nUso5K2q+PHSh/LnqC76R4nEhUXF6ocY5hBR0kVyEQi02g7MaUovhLtr
   7R9zpa1wyRISYPQEvn+81VFIBVJunk6Ifco6Iq9gqX7FPbx93eQP0n9xX
   8ODOBU9LuzeHGTf19qtFBHGnyne1yIrXfOhRrwHkdMVRlv2SNSItF5YLv
   fTUOQJQA0qON8j+Wxd1CY2epBjfC1DrkLaj7l497nF/BnxeijjSs/eEl6
   GTeFAsPG8Dbbyp2MLSHR09j/kyYBiNBVEJvMaFuQr8kSaXYnM1reB6rmJ
   mMOcmSddhzbqy9HtJyKZjcGUAgKbt38mN/ZgnUzqsaCLVE+0aXeYPE278
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="117702"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="117702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 09:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="32864755"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 17 Jan 2024 09:25:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ivecera@redhat.com,
	Martin Zaharinov <micron10@gmail.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net] i40e: Include types.h to some headers
Date: Wed, 17 Jan 2024 09:25:32 -0800
Message-ID: <20240117172534.3555162-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
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


