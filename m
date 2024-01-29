Return-Path: <netdev+bounces-66846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFD8412CB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FF91F27526
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560961E4BD;
	Mon, 29 Jan 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5wjdBt9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A43C463
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554480; cv=none; b=DKExyWmrnhS8B6LAgLV/A/RnP1CKMusWriGF7cYmGgj9+mhl1UdWeQSzOMDfzX81xtANQK2mUnVW4GAx/xdYDkerwGAWpGxwmsa2B9C+F+4LEeVHzqmUYXg2bujem2SxVmMvzi/tYMm9FWWoBSmyXg9Q+5AAxd8xWsMfzD4tyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554480; c=relaxed/simple;
	bh=UaA5Q7SlQapn+YGahBPvHSpnw4HatqiXv7FIBxk9pEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO2pQt3JLGQA0Cl0n+1/PTxobmD5825nQ79YhWGY7uGT5TbN/m9a4cDyiZVCGC/PkcVpwJE/62+uoQq6VaNGBB809JCv2bcwAXdEzYnsQisWEZ3RjSfAIOcV4ZJzOUQN6attEZsYBLZPmKWyRAIV2mtDlrJ27OKPrDpsEGZn1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5wjdBt9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706554479; x=1738090479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UaA5Q7SlQapn+YGahBPvHSpnw4HatqiXv7FIBxk9pEM=;
  b=i5wjdBt98nUOCr2MVsx4sY9s+0XHDe2qCq+1dSa7qdFkYPS9/VQ16c8m
   /IH62C/er/0FLnf6ezfAb8n5tPJr+ytWWgA2Mbq19Xm9VKr6kmH7+oGJu
   ttR1x1g1mTwwObG8yvRELsSBB3szkKQbmYvyyevsaTl0iLM2P1WONnKEE
   cdEtLDGmnOZhOZAU1WGZf0KvOn0rnM4dPHzUCQ2ZZ5WrUzEkMmCyappKZ
   6MyD7D7ew520LQ9CLA9dTuTrK9lzYd/C9qE4h0oD7LOBAu+2SaRULO71V
   vDXVZivSxH+AqJPen3VfQQzBnMcIashIMd2DVrVHjyI4fLvlmioXo+Vn+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2879951"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2879951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 10:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3470149"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jan 2024 10:52:50 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/2] ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
Date: Mon, 29 Jan 2024 10:52:38 -0800
Message-ID: <20240129185240.787397-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
References: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

All error handling paths, except this one, go to 'out' where
release_swfw_sync() is called.
This call balances the acquire_swfw_sync() call done at the beginning of
the function.

Branch to the error handling path in order to correctly release some
resources in case of error.

Fixes: ae14a1d8e104 ("ixgbe: Fix IOSF SB access issues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 6208923e29a2..c1adc94a5a65 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -716,7 +716,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 	if ((command & IXGBE_SB_IOSF_CTRL_RESP_STAT_MASK) != 0) {
 		error = FIELD_GET(IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK, command);
 		hw_dbg(hw, "Failed to read, error %x\n", error);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (!ret)
-- 
2.41.0


