Return-Path: <netdev+bounces-32812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C852F79A7E0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396A1281105
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F3F9D8;
	Mon, 11 Sep 2023 12:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A7C8DB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:15:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB5198;
	Mon, 11 Sep 2023 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434522; x=1725970522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfjgEcn3j45qxnCU9n6VXDTvhnlTPXsfglb+ZF4euEo=;
  b=bEtgS33yNbuzE9Pc7tW6Jm7PEe9dWZjbeeQkxjapG2dWSCF2c/+yJSqi
   lJ9zEZvuIBFm0UzWNBeOFLt9FriRZk8j0LS5+4hoRUkHteiI3HGYP+nyK
   YUbXLIt1EuYzKzKrIjHiMAvI5wFAa4FTt58b1ghkUX1RcQFPVnuTpKw5K
   um2PoABYwiW/eWtH1oRGWkfr95n6QdXSMw/riivo8EkHE5Ouz4lQB8h1p
   WfV359LblJORs5wB7elLleXsgXytjc1pNYI3XwBkLhl60g1VTQ0SUkfpH
   CrY3JqVOHNoA6630+FsAPu0ErFHqYqi2aRuQth/+Wvr2vBJgHV2lNg1yL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863502"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863502"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383290"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383290"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/8] igb: Use FIELD_GET() to extract Link Width
Date: Mon, 11 Sep 2023 15:14:56 +0300
Message-Id: <20230911121501.21910-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
2.30.2


