Return-Path: <netdev+bounces-56593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2780F86A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981B81F2148B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865065A68;
	Tue, 12 Dec 2023 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XihUvG9S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364ACD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414253; x=1733950253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcoOlsmjBYrwMj6VOO/G42J3R9d0cs6CdGghqQIqH3o=;
  b=XihUvG9SIjdsRuLJCTqcoWty82eFmOuoumhHRbueSaJF8mrrM71gTTco
   irIGrHEKx3q8pZuxMiRwjSOzCxGsj36TRUHDNtgVjnnEmugAVRST5OXEA
   nxvkpSIHgKBU5ISoBfipDnKcTfMpBeQxhOsDwn1HtSWwuuUofQdtI+0sE
   O4cFhyYpQAOjSLR0Bwrk4JBOumvNy13lTBoTkuiH+CwYSM6ofIFJ808sL
   YJrEg/DZQQQhphLMCikA++gY5VAIHjFjGQCNbnP9FAuXG1kcdbyh7RlBN
   C4XLtTTEiFyHVNoMv+ZPhGurtOtuqLl0uO/2/XK9QvZ6HoyjCEqYJXVIg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1942376"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1942376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105044030"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105044030"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 12:49:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/3] igb: Use FIELD_GET() to extract Link Width
Date: Tue, 12 Dec 2023 12:49:43 -0800
Message-ID: <20231212204947.513563-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
References: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index caf91c6f52b4..5a23b9cfec6c 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/if_ether.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
@@ -50,9 +51,8 @@ s32 igb_get_bus_info_pcie(struct e1000_hw *hw)
 			break;
 		}
 
-		bus->width = (enum e1000_bus_width)((pcie_link_status &
-						     PCI_EXP_LNKSTA_NLW) >>
-						     PCI_EXP_LNKSTA_NLW_SHIFT);
+		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
+							     pcie_link_status);
 	}
 
 	reg = rd32(E1000_STATUS);
-- 
2.41.0


