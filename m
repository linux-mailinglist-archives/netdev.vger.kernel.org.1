Return-Path: <netdev+bounces-61042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B043F8224B2
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C337B22175
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668417740;
	Tue,  2 Jan 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+TMOVmU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B417725
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704234282; x=1735770282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbB42MAJJg45+sdzyKvOBZeW0G00mbraEzrXTXPBOKQ=;
  b=R+TMOVmUia4vxugQyFkXSnwfo9oH4i+KN/rbl5IZ3JDfJmghzJkqtBjB
   GcrSnXX9BM5f0aMibPbjZvl3NxttU07l2iFSuotL+g1AmcQaebPhpNGUj
   0cp6Zn7mrv/RkTgK4bxneZQi9TZ2KCmQetIvuR0vBkNA9w7xNYof984a1
   TUHOf+qmRcKnfd21HoTqntbxUw4gihYFsd1Ixz1YI5/x3C1o9kCeQmNtk
   xyO6fhphaOdqJtxZOgyrg5k6PmKPyenPy56N9+2OpIh7/cZThZdralqJW
   S8bgmfE/5lbcwXo3N4hYWoXV7CGKGmAkxaaJkPy6GauclOjKDZ2oV7XE/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3700425"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3700425"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772965464"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="772965464"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2024 14:24:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	Nick Desaulniers <ndesaulniers@google.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/5] i40e: Avoid unnecessary use of comma operator
Date: Tue,  2 Jan 2024 14:24:23 -0800
Message-ID: <20240102222429.699129-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
References: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

Although it does not seem to have any untoward side-effects,
the use of ';' to separate to assignments seems more appropriate than ','.

Flagged by clang-17 -Wcomma

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 8cc5697e2109..c841779713f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1911,7 +1911,7 @@ static int i40e_get_eeprom(struct net_device *netdev,
 			len = eeprom->len - (I40E_NVM_SECTOR_SIZE * i);
 			last = true;
 		}
-		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i),
+		offset = eeprom->offset + (I40E_NVM_SECTOR_SIZE * i);
 		ret_val = i40e_aq_read_nvm(hw, 0x0, offset, len,
 				(u8 *)eeprom_buff + (I40E_NVM_SECTOR_SIZE * i),
 				last, NULL);
-- 
2.41.0


