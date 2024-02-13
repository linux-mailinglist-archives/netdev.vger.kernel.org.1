Return-Path: <netdev+bounces-71128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5258526D6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6811F259A9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13127282F0;
	Tue, 13 Feb 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQT2WFf0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9627453
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786367; cv=none; b=eaVArjqmRE+nyhMgByj5jtUrr9R0J4j89V2789Wz3YNXQct7/OA7m3rEpSwYHT/nC3YFTTIIcdoTww9ecU7ubKqp7o0pr28MAmCWyLBcDqVPpxW3ReHJYLx/nLsIlOTdv6E3e3pnNW7O1tWXHhBC7x5sBP6W/6DTw8zKinEh20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786367; c=relaxed/simple;
	bh=PpJfuSoK9F4SyJi/EB+5TLQ5QLQ0FFKuc0JimksAtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNDT8wWNihcVenwLZDt8v6f0wc8zPNXEpfHQZCOdRN85EttCo723GL6btVZuWBFVBBoSrLDzyz9yEAGXcxufjsvydFEQv3su4UAH09+H8MXNhkEL1a6YHuiadJORIjfzMGY0Kv9rVrbxEAafk9jrpdhxmeBeJRP1nya6/r64tuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQT2WFf0; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786365; x=1739322365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PpJfuSoK9F4SyJi/EB+5TLQ5QLQ0FFKuc0JimksAtjs=;
  b=CQT2WFf0wrwa3I2ch2GacKMcRw3NrXBNPNanWQNAvEr9zRAqrqWHzkwC
   yZ5Vc/VYLCUwHDAfQ7iunjSTPV6DD3v/z/y8RJzpQiPiq3PPuSN62PHMh
   Q8OZKlm+BD3aMjfHz2jf1u+Waan0a9Ua68J4gPp7aaaxgu+Q0DLA2ZuF4
   IULwcue7CjU+uGCgQ4J8d4RZiXSbJGF55UX93hfFhkAceXJTpA020XeiY
   Pvmmu/dveuM9/7dliphPyrRlPMFMU866olTLMKp2/0ooPGNVDG7p7RUwh
   Oa40H0oQeoJu6IWAJdOckyzGXmgb93jxvc4J5Pc9hbIYA3vyXHUy3Bcsc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436927658"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436927658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911651335"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911651335"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2024 17:05:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/4] i40e: Fix wrong mask used during DCB config
Date: Mon, 12 Feb 2024 17:05:37 -0800
Message-ID: <20240213010540.1085039-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
References: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Mask used for clearing PRTDCB_RETSTCC register in function
i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
I40E_PRTDCB_RETSTCC_ETSTC_MASK.

The PRTDCB_RETSTCC register is used to configure whether ETS
or strict priority is used as TSA in Rx for particular TC.

In practice it means that once the register is set to use ETS
as TSA then it is not possible to switch back to strict priority
without CoreR reset.

Fix the value in the clearing mask.

Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 9d88ed6105fd..8db1eb0c1768 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -1523,7 +1523,7 @@ void i40e_dcb_hw_rx_ets_bw_config(struct i40e_hw *hw, u8 *bw_share,
 		reg = rd32(hw, I40E_PRTDCB_RETSTCC(i));
 		reg &= ~(I40E_PRTDCB_RETSTCC_BWSHARE_MASK     |
 			 I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK |
-			 I40E_PRTDCB_RETSTCC_ETSTC_SHIFT);
+			 I40E_PRTDCB_RETSTCC_ETSTC_MASK);
 		reg |= FIELD_PREP(I40E_PRTDCB_RETSTCC_BWSHARE_MASK,
 				  bw_share[i]);
 		reg |= FIELD_PREP(I40E_PRTDCB_RETSTCC_UPINTC_MODE_MASK,
-- 
2.41.0


