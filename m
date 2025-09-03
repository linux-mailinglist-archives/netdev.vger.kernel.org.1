Return-Path: <netdev+bounces-219698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62883B42AD7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BB01C23304
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B242E11C5;
	Wed,  3 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN/tZgDP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146ED369345
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931147; cv=none; b=KpRGH9/6mB+TdKp2aTmyB7bxy/2n6I0uGYLNgmxoUkYz+TUvr43KrVO2HjkNdzT+DljHhyqg//IOWzHTb6Sa5iKQY1Z0DUU7YRZh2AH7KuD23o0Dy3n4kWplw+x7yMCZphmttTN/s2vYY/VYO2zVv2moSAt7+BZhq14pCHZWGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931147; c=relaxed/simple;
	bh=/JFHFPWtPdMDk3uWSINsFjB/Z9aTWpWpk+VE7hkKT8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFfJUf0H/TuMHA0J+88xdYm4dQptW/9J4WaJtF4cnnwHkm6au3omAQo5ELWEqbHIVz63exxUxUtpiYyn/QjhaHtjbXskAriuk8UfMLzAYRP/O3WHicjk9KQqkDRKfa1GSZrVC5E3keM0Z2Llm1KGP5VowG1V5GjeqIYWqS1KJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN/tZgDP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931146; x=1788467146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JFHFPWtPdMDk3uWSINsFjB/Z9aTWpWpk+VE7hkKT8w=;
  b=PN/tZgDPwGApOLGHApDMHaiGROu92ekjtPvtv0AuXwCcCejKHfX80TsD
   ARmJpcA8tFZw4FBy7gp67h6hp58yCPFqgbyc4Sa8Bemc584Uj4yGHwklP
   IpyLEhiU40NuC90pk2+GARWMP1YGIxdRm7H6iapDRTwXNi+P4hb5ZieLQ
   pMkWwURjwTY2ulUygD8QtWOHQHRx8vI6+OYmy5tw19al+vbg5ToFZKnFA
   mdUAUZgD0m9xfboll+LLRcZIzg8G9EkH0ZGy7KeZPAnnhj7gjFZy5gUJ/
   bj2BxlNrRyphHlQklQ7yv5mtbKbQrghBMiOF0QU+L/W7mY1h+N6FuSZ4T
   w==;
X-CSE-ConnectionGUID: 6sKdRdClSx256cW+fEan/w==
X-CSE-MsgGUID: U39pUb5KQRiNJwI8OUxgAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173060"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173060"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: Wtv1bzkySWOsvSqoReg7Ug==
X-CSE-MsgGUID: htFPo0MfQw+CPQtTDOCsZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823466"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2025 13:25:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacek Kowalski <jacek@jacekk.info>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 8/9] igc: drop unnecessary constant casts to u16
Date: Wed,  3 Sep 2025 13:25:34 -0700
Message-ID: <20250903202536.3696620-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Kowalski <jacek@jacekk.info>

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_i225.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
index 0dd61719f1ed..5226d10cc95b 100644
--- a/drivers/net/ethernet/intel/igc/igc_i225.c
+++ b/drivers/net/ethernet/intel/igc/igc_i225.c
@@ -435,7 +435,7 @@ static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 				     &checksum);
 	if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
index efd121c03967..a47b8d39238c 100644
--- a/drivers/net/ethernet/intel/igc/igc_nvm.c
+++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
@@ -123,7 +123,7 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -IGC_ERR_NVM;
 		goto out;
@@ -155,7 +155,7 @@ s32 igc_update_nvm_checksum(struct igc_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.1


