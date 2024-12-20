Return-Path: <netdev+bounces-153798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525939F9B0A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF471890B37
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA922579A;
	Fri, 20 Dec 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6sEDMWF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F225A43
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725768; cv=none; b=sSyzfiKhYsQteVO0mVD3xHXnzAKlnUH1vfkiEh4Xapet/HBplZBAEwVJWs2QQIs/U8hAgjsItyBJjNdPiPQWp29EZVkPPtit0IjxAxatlAKdITtbZyN27FcuqXcLkR5YPSVfIGn6djWjeEcnew8GUcY7xN2ZRr03Oup6sELFzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725768; c=relaxed/simple;
	bh=PibNLuvNyHwdVohc14JgJznsRG/wcvv40EXuN1Jipxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJU54fAet3AbR5hTARFYc3GVd0ezwgOOR5CZxcfr6zM78VPfiUU5ZTG8cquaVhPa88DUckBZaJxEkCLF07+1jMEw4h7OQNEV4c+JUk7FgS/gPKPn+ersI41eSS8sopV4g706SMrVFqs9W7UNwJwb01kKfFiRB6+I6Sx+VO6ylxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6sEDMWF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725767; x=1766261767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PibNLuvNyHwdVohc14JgJznsRG/wcvv40EXuN1Jipxo=;
  b=Q6sEDMWFu6ZjaN8BnAfFPY/DhqehzkkuoQZ3m0DpGJuwyz6X9bqn/rpd
   RGgh5b3s6reNrxGrhYqCdUEtEnrvm7omJf9LxsMUCkqg2pvT7VHZf+hjJ
   5Vr1k6d0Yo+V9ACB/NBW7BclU+dhR+YWFT8UNXKfnCtze7VFniwGfzEAf
   FgY4y5ZSWokS6TWg7tCkpglpQNlxnpNq7DaXjYAqF4SAjWmyh3qU0kTQ7
   UiXo2CKravl26IzA6zX3NO3NyqJy2vn64Oy6R792uk842s4JY10901WB4
   TT48atUiBM3J+Xmc5QajYwJplonnwenVdcZ/T3TgtHMl4lWQwxodQ0Rpr
   g==;
X-CSE-ConnectionGUID: 7P9f9H07SBKRlrfqx3Hd+Q==
X-CSE-MsgGUID: 4o9gEKQDQzyR8KVDPQRZuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292408"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:03 -0800
X-CSE-ConnectionGUID: WMQvFehVSJ2YAelULoPjnw==
X-CSE-MsgGUID: JRElrvm9SbyDRyT5tgYQDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717107"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 06/10] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Fri, 20 Dec 2024 12:15:11 -0800
Message-ID: <20241220201521.3363985-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Required to adopt x540 specific functions by E610 device.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index b69a680d3ab5..6ed360c5b605 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
+
+#ifndef _IXGBE_X540_H_
+#define _IXGBE_X540_H_
 
 #include "ixgbe_type.h"
 
@@ -17,3 +20,5 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_release_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_init_swfw_sync_X540(struct ixgbe_hw *hw);
 int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw);
+
+#endif /* _IXGBE_X540_H_ */
-- 
2.47.1


