Return-Path: <netdev+bounces-54122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EE806095
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE6A1C20F5E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93176E5B7;
	Tue,  5 Dec 2023 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwHxM+S2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055AD1A3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811184; x=1733347184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFu9mwTALzTz535gCqPKGb7aSungoenJSJVJzcvI748=;
  b=hwHxM+S23wT4mB7fwD+VORY1CAErO/O2tXK+sMa0X39ot8ilfjaZAOwZ
   DPdTOiSg+5d3KLxqRx79Qfi2R3R4Tv94UbaYA4dRgcjq28JnBe4RpQ/DN
   yjyLC+Ie/LldkMNFH4R3F/Az4J1vRWaRMLyKoOoTgN4aywy1wB2V2oz4q
   GXg/gnjO9vI/QI2aw9GJrpx4NYUy6nKd+NTN4e/jqfPXFK0AuKLic7tri
   Ah10r7d+uYCmbFsjHl8Lr2QYt1OcnOQTD4jPgiRYJj823yyWbwfI7QcXt
   gNGr6cHHmbA96KnT0eFUUkzZ1EubjqD9zraZDBE5TpI0KHOMdEnQakRCI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393693815"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393693815"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894510107"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="894510107"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 13:19:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 3/4] i40e: Fix unexpected MFS warning message
Date: Tue,  5 Dec 2023 13:19:14 -0800
Message-ID: <20231205211918.2123019-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
References: <20231205211918.2123019-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
a warning message that reports unexpected size of port's MFS (max
frame size) value. This message use for the port number local
variable 'i' that is wrong.
In i40e_probe() this 'i' variable is used only to iterate VSIs
to find FDIR VSI:

<code>
...
/* if FDIR VSI was set up, start it now */
        for (i = 0; i < pf->num_alloc_vsi; i++) {
                if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
                        i40e_vsi_open(pf->vsi[i]);
                        break;
                }
        }
...
</code>

So the warning message use for the port number index of FDIR VSI
if this exists or pf->num_alloc_vsi if not.

Fix the message by using 'pf->hw.port' for the port number.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f7a332e51524..1ab8dbe2d880 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16224,7 +16224,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.41.0


