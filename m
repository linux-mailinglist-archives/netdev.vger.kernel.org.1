Return-Path: <netdev+bounces-98254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDA8D0590
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1401F26DB3
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3BD16B72C;
	Mon, 27 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvuHmp3U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362516A392
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821605; cv=none; b=cN66ZAjEjB3Eklwz5Qhb8q5bEW54UeelPX7eqvEMck2y1LEmFJKO5ittnL/EZiDFYMgxLoRcmrg6V13U0latEYmH2G/Viu72QrjEWbL2YgvgkNtQX9NyWwy88+skYpsV/fWrc9Wom4CIPcPZkw12tjQZukUrzBqRgiFvuq42EbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821605; c=relaxed/simple;
	bh=yAlmKvQNAV/yUXqHSOBMs6ZT4KrFx6wmrNXDkPsKJTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWX6+gMZvnluDZ3UxSWjpPHJyRNA4RZimTN2XLil+wYMcHh4H8+7Kz2GwzAE8/HuzwlhkV59+1T2fLTbQKxSbDl9etJyIrTJIrTyEgUJ2iY1n+msMr6LSVMEOaLxBLEzvV191JWq623jwrDnIq6PZYYf5tS0gyg0FvNpVydt06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvuHmp3U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821604; x=1748357604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAlmKvQNAV/yUXqHSOBMs6ZT4KrFx6wmrNXDkPsKJTs=;
  b=HvuHmp3Uq7qUzhVp23mhjQd0U4gnScwi5eWApeNxcZ62jWIpJNzFn211
   T+BJCnsEBEJlSvERQp3eTMyudmPd2S4kdiD/oRVV+JnGt1uQcwrCfqIYj
   u+CHtL+URcs3NoJcdHPIDoQqko2rgSEFCQXkiXKEQlnoGVC2oAzfCx0oS
   CjSnOY5l6fYvSjEgNm8eEgRCebIoQglOnfgf9byEc7q1oJT8hgLCNJe92
   4F7ullqnYBeYSnia00AqqzcaOTqRQhTT3sZe1T353mlwhXfyMicPZG2KY
   HQDgEbpg32vz4TOQ8I8kH1by82L4ICRKTIeJNMyGu+X7PkOlVqaNakUTC
   Q==;
X-CSE-ConnectionGUID: 5u9miGOgSIOOkcQtPG5fgQ==
X-CSE-MsgGUID: KLcw4lGgQviN9LRM/ZFevQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11715264"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11715264"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:53:22 -0700
X-CSE-ConnectionGUID: G6fimsMWR3u98lq2bcryxA==
X-CSE-MsgGUID: 49CSnowzTzO3nVizef+Ghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39192017"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 07:53:19 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v7 5/7] ixgbe: Add ixgbe_x540 multiple header inclusion protection
Date: Mon, 27 May 2024 17:10:21 +0200
Message-Id: <20240527151023.3634-6-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required to adopt x540 specific functions by E610 device.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index b69a680..6ed360c 100644
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
2.31.1


