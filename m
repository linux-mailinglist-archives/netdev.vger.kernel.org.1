Return-Path: <netdev+bounces-219699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DCB42AD8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1AC164B6F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BE36999F;
	Wed,  3 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZzDRbQY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40679369352
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931147; cv=none; b=SlLm3zMM/NxfwrorGtAKusPQjHgGzEyVm5bNvP1j0KyW9EVkkZA6fPD5U8/ZM+bZbnU+8lXTwtEnZnCmmxzzsh3YGj+6esjFIJvTfkfc7LlxKdaZQ4msLusNM/LKi9JOxc6r76nxgeSG4zKX2rBXilSr2pMaPH3zyodHoSOPzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931147; c=relaxed/simple;
	bh=DptcmR0IszxXKSMdNOa8gH2gyZzcGde+ET8DD6lUr94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/P3K0QobiZNGw9Ygpv2LdGhoM2JAJd3YUPrMAl/gVM2ZJg+yc8Xqf/ogwMogp9j/NR1BwJ0UgIJMYWRjh6l6rA/NNLUmLjlgPpUZAgkDRQxyxG+z9zO6c157QyLxfDrSJUJnPEldG6WSFjvjWPNrMXPRKgcLI0gncO9VUl4FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZzDRbQY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756931146; x=1788467146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DptcmR0IszxXKSMdNOa8gH2gyZzcGde+ET8DD6lUr94=;
  b=YZzDRbQYEZCqu4KghOYmljmrJKbw8HXFf9hcuHwXF8JbPd1zoYDbNYET
   5Kb9TYt9x0V1qzeXABsFKIkud0IP7VjvYo/GxOquMRyW3nHHymjiAtPE8
   NMPGBNxhHZBvelCYGPQZ9S+GI5VSpMRF8vFUXFMelWbf0v2RmtydlQook
   bOxMaptYxj+Im6LfCq9DZt7AS19P0GERZKDwzL0iE5e2/bBvt6pxtbmaf
   7JJc4M+Bd3K8/eoS80nXMKDmSJhafAjFy5tChcsPdaVtiqGlAwagAo4C2
   sr3a4mhXsVFQXP36ppzq26dI5tEjvBUk4y01Rvmy3ucJRK3RNxpuhXIOZ
   w==;
X-CSE-ConnectionGUID: Q6tRjRWWRLq+SGKbti/V1Q==
X-CSE-MsgGUID: 4oHgLvewQ6uxptpKwazCSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173067"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173067"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 13:25:41 -0700
X-CSE-ConnectionGUID: 1rpqKTTMShCDOfwTXHxl2w==
X-CSE-MsgGUID: EfUa1lsDS0moYip/elc2ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175823472"
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
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 9/9] ixgbe: drop unnecessary casts to u16 / int
Date: Wed,  3 Sep 2025 13:25:35 -0700
Message-ID: <20250903202536.3696620-10-anthony.l.nguyen@intel.com>
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

Additionally drop cast from u16 to int in return statements.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4ff19426ab74..3ea6765f9c5d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1739,9 +1739,9 @@ int ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index c2353aed0120..e67e2feb045b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -373,9 +373,9 @@ static int ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index bfa647086c70..650c3e522c3e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1060,9 +1060,9 @@ static int ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 			return status;
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
-	return (int)checksum;
+	return checksum;
 }
 
 /** ixgbe_calc_eeprom_checksum_X550 - Calculates and returns the checksum
-- 
2.47.1


